.global LCRTAdvsimdScalarRDM

.text
.p2align 4

LCRTAdvsimdScalarRDM:

LCRTAdvsimdScalarRDM_TestBegin:
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
    MOVZ  X2, #0xaad6, LSL #0
    MOVK  X2, #0x5971, LSL #16
    MOVK  X2, #0xb51f, LSL #32
    MOVK  X2, #0x7892, LSL #48
    MOVZ  X3, #0x55e7, LSL #0
    MOVK  X3, #0x5200, LSL #16
    MOVK  X3, #0x950c, LSL #32
    MOVK  X3, #0x9bc1, LSL #48
    MOVZ  X4, #0x1a, LSL #0
    MOVK  X4, #0xa1e0, LSL #16
    MOVK  X4, #0xb25f, LSL #32
    MOVK  X4, #0x974b, LSL #48
    MOVZ  X5, #0x2c64, LSL #0
    MOVK  X5, #0x93b5, LSL #16
    MOVK  X5, #0x923, LSL #32
    MOVK  X5, #0x3a4c, LSL #48
    MOVZ  X6, #0x64e3, LSL #0
    MOVK  X6, #0x68f2, LSL #16
    MOVK  X6, #0xe37e, LSL #32
    MOVK  X6, #0xa74c, LSL #48
    MOVZ  X7, #0x40d2, LSL #0
    MOVK  X7, #0xaa94, LSL #16
    MOVK  X7, #0xcf62, LSL #32
    MOVK  X7, #0xd51a, LSL #48
    MOVZ  X8, #0x650a, LSL #0
    MOVK  X8, #0x6c98, LSL #16
    MOVK  X8, #0xf108, LSL #32
    MOVK  X8, #0xee82, LSL #48
    MOVZ  X9, #0x5b00, LSL #0
    MOVK  X9, #0x46d1, LSL #16
    MOVK  X9, #0x89e1, LSL #32
    MOVK  X9, #0x617c, LSL #48
    MOVZ  X10, #0xea7c, LSL #0
    MOVK  X10, #0x38d1, LSL #16
    MOVK  X10, #0x3094, LSL #32
    MOVK  X10, #0x5477, LSL #48
    MOVZ  X11, #0xeb45, LSL #0
    MOVK  X11, #0x269e, LSL #16
    MOVK  X11, #0x48ad, LSL #32
    MOVK  X11, #0x2750, LSL #48
    MOVZ  X12, #0x4d57, LSL #0
    MOVK  X12, #0x810a, LSL #16
    MOVK  X12, #0xc802, LSL #32
    MOVK  X12, #0x420a, LSL #48
    MOVZ  X13, #0x1f8c, LSL #0
    MOVK  X13, #0xcf1, LSL #16
    MOVK  X13, #0x851e, LSL #32
    MOVK  X13, #0x80b9, LSL #48
    MOVZ  X14, #0x352b, LSL #0
    MOVK  X14, #0xfcee, LSL #16
    MOVK  X14, #0xc1f4, LSL #32
    MOVK  X14, #0xf4fd, LSL #48
    MOVZ  X15, #0xc10f, LSL #0
    MOVK  X15, #0x7391, LSL #16
    MOVK  X15, #0xc0e2, LSL #32
    MOVK  X15, #0x14f4, LSL #48
    MOVZ  X16, #0xcab9, LSL #0
    MOVK  X16, #0xb298, LSL #16
    MOVK  X16, #0xfe80, LSL #32
    MOVK  X16, #0xed64, LSL #48
    MOVZ  X17, #0xf479, LSL #0
    MOVK  X17, #0x43cf, LSL #16
    MOVK  X17, #0xf732, LSL #32
    MOVK  X17, #0x7cc3, LSL #48
    MOVZ  X18, #0x430f, LSL #0
    MOVK  X18, #0xe3bc, LSL #16
    MOVK  X18, #0x41f3, LSL #32
    MOVK  X18, #0x21a9, LSL #48
    MOVZ  X19, #0xae2b, LSL #0
    MOVK  X19, #0x976a, LSL #16
    MOVK  X19, #0xa7da, LSL #32
    MOVK  X19, #0xd29f, LSL #48
    MOVZ  X20, #0xa7ae, LSL #0
    MOVK  X20, #0x7b56, LSL #16
    MOVK  X20, #0x9277, LSL #32
    MOVK  X20, #0xefeb, LSL #48
    MOVZ  X21, #0xf740, LSL #0
    MOVK  X21, #0xccbc, LSL #16
    MOVK  X21, #0x9b3d, LSL #32
    MOVK  X21, #0xa709, LSL #48
    MOVZ  X22, #0x1e2f, LSL #0
    MOVK  X22, #0x6ef, LSL #16
    MOVK  X22, #0x29e3, LSL #32
    MOVK  X22, #0x3ff7, LSL #48
    MOVZ  X23, #0x572, LSL #0
    MOVK  X23, #0x4653, LSL #16
    MOVK  X23, #0x19c2, LSL #32
    MOVK  X23, #0x6c5d, LSL #48
    MOVZ  X25, #0xe1a8, LSL #0
    MOVK  X25, #0xeafb, LSL #16
    MOVK  X25, #0xf995, LSL #32
    MOVK  X25, #0x4218, LSL #48
    MOVZ  X6, #0x1099, LSL #0
    MOVK  X6, #0x51f0, LSL #16
    MOVK  X6, #0xe74e, LSL #32
    MOVK  X6, #0x26d3, LSL #48
    MSR  FPCR, X6
    MRS  X19, FPCR
    MOVZ  X4, #0x60ff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    AND  X19, X19, X4
    MOVZ  X4, #0x0, LSL #0
    ORR  X19, X19, X4
    MSR  FPCR, X19
    ISB  SY
    MOVZ  X6, #0xd3a4, LSL #0
    MOVK  X6, #0x3eab, LSL #16
    MOVK  X6, #0x9869, LSL #32
    MOVK  X6, #0xe2c0, LSL #48
    MSR  FPSR, X6
    MRS  X10, FPSR
    MOVZ  X17, #0xff60, LSL #0
    MOVK  X17, #0x7ff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    AND  X10, X10, X17
    MOVZ  X17, #0x0, LSL #0
    ORR  X10, X10, X17
    MSR  FPSR, X10
    ISB  SY
    ANDS  W25, W6, W18, LSL #20
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x52d0, LSL #0
    MOVK  X2, #0x73b7, LSL #16
    MOVK  X2, #0xc719, LSL #32
    MOVK  X2, #0x1dea, LSL #48
    MOVZ  X3, #0x3a4c, LSL #0
    MOVK  X3, #0x11bc, LSL #16
    MOVK  X3, #0x90f4, LSL #32
    MOVK  X3, #0x5379, LSL #48
    MOVZ  X4, #0xeec9, LSL #0
    MOVK  X4, #0x3975, LSL #16
    MOVK  X4, #0x410, LSL #32
    MOVK  X4, #0xe351, LSL #48
    MOVZ  X5, #0x5a63, LSL #0
    MOVK  X5, #0xc160, LSL #16
    MOVK  X5, #0x857f, LSL #32
    MOVK  X5, #0x93d1, LSL #48
    MOVZ  X6, #0x54e, LSL #0
    MOVK  X6, #0x75c7, LSL #16
    MOVK  X6, #0x13c8, LSL #32
    MOVK  X6, #0x7324, LSL #48
    MOVZ  X7, #0xedf, LSL #0
    MOVK  X7, #0x2aac, LSL #16
    MOVK  X7, #0x8bcf, LSL #32
    MOVK  X7, #0xcea, LSL #48
    MOVZ  X8, #0xa2e6, LSL #0
    MOVK  X8, #0xfe89, LSL #16
    MOVK  X8, #0x3d49, LSL #32
    MOVK  X8, #0x6328, LSL #48
    MOVZ  X9, #0x54eb, LSL #0
    MOVK  X9, #0xa4d3, LSL #16
    MOVK  X9, #0x22a5, LSL #32
    MOVK  X9, #0xc727, LSL #48
    MOVZ  X10, #0x1c2b, LSL #0
    MOVK  X10, #0x7425, LSL #16
    MOVK  X10, #0x8330, LSL #32
    MOVK  X10, #0xa33b, LSL #48
    MOVZ  X11, #0x1ecf, LSL #0
    MOVK  X11, #0x295a, LSL #16
    MOVK  X11, #0x96b2, LSL #32
    MOVK  X11, #0x99aa, LSL #48
    MOVZ  X12, #0xbb6d, LSL #0
    MOVK  X12, #0x6b31, LSL #16
    MOVK  X12, #0x7b31, LSL #32
    MOVK  X12, #0xa56b, LSL #48
    MOVZ  X13, #0x824e, LSL #0
    MOVK  X13, #0x3bda, LSL #16
    MOVK  X13, #0x33d4, LSL #32
    MOVK  X13, #0x5a67, LSL #48
    MOVZ  X14, #0xe51e, LSL #0
    MOVK  X14, #0x7a67, LSL #16
    MOVK  X14, #0xbb7e, LSL #32
    MOVK  X14, #0x93e, LSL #48
    MOVZ  X15, #0xdf0e, LSL #0
    MOVK  X15, #0xe290, LSL #16
    MOVK  X15, #0x709, LSL #32
    MOVK  X15, #0x55d2, LSL #48
    MOVZ  X16, #0xf616, LSL #0
    MOVK  X16, #0xd603, LSL #16
    MOVK  X16, #0xde9b, LSL #32
    MOVK  X16, #0xa2e1, LSL #48
    MOVZ  X17, #0x73a5, LSL #0
    MOVK  X17, #0x248a, LSL #16
    MOVK  X17, #0xe5a7, LSL #32
    MOVK  X17, #0x39c7, LSL #48
    MOVZ  X18, #0x4bfe, LSL #0
    MOVK  X18, #0xab46, LSL #16
    MOVK  X18, #0xeee8, LSL #32
    MOVK  X18, #0x8ea2, LSL #48
    MOVZ  X19, #0xb39e, LSL #0
    MOVK  X19, #0xadfc, LSL #16
    MOVK  X19, #0x2d7c, LSL #32
    MOVK  X19, #0x3569, LSL #48
    MOVZ  X20, #0xc40b, LSL #0
    MOVK  X20, #0xd0cc, LSL #16
    MOVK  X20, #0x18b1, LSL #32
    MOVK  X20, #0xe56c, LSL #48
    MOVZ  X21, #0x7063, LSL #0
    MOVK  X21, #0x6c21, LSL #16
    MOVK  X21, #0x25c6, LSL #32
    MOVK  X21, #0x88e4, LSL #48
    MOVZ  X22, #0xd121, LSL #0
    MOVK  X22, #0xcd1d, LSL #16
    MOVK  X22, #0x546c, LSL #32
    MOVK  X22, #0xff59, LSL #48
    MOVZ  X23, #0xa805, LSL #0
    MOVK  X23, #0x3308, LSL #16
    MOVK  X23, #0xb501, LSL #32
    MOVK  X23, #0xb3f9, LSL #48
    MOVZ  X25, #0x8fbf, LSL #0
    MOVK  X25, #0x58cf, LSL #16
    MOVK  X25, #0x3c36, LSL #32
    MOVK  X25, #0xbc0a, LSL #48
    FMOV  D0, X4
    FMOV  V0.D[1], X21
    FMOV  D1, X25
    FMOV  V1.D[1], X25
    FMOV  D2, X22
    FMOV  V2.D[1], X23
    FMOV  D3, X14
    FMOV  V3.D[1], X23
    FMOV  D4, X21
    FMOV  V4.D[1], X7
    FMOV  D5, X11
    FMOV  V5.D[1], X9
    FMOV  D6, X15
    FMOV  V6.D[1], X6
    FMOV  D7, X18
    FMOV  V7.D[1], X13
    FMOV  D8, X17
    FMOV  V8.D[1], X7
    FMOV  D9, X25
    FMOV  V9.D[1], X15
    FMOV  D10, X25
    FMOV  V10.D[1], X19
    FMOV  D11, X5
    FMOV  V11.D[1], X9
    FMOV  D12, X8
    FMOV  V12.D[1], X3
    FMOV  D13, X16
    FMOV  V13.D[1], X12
    FMOV  D14, X5
    FMOV  V14.D[1], X14
    FMOV  D15, X18
    FMOV  V15.D[1], X16
    FMOV  D16, X5
    FMOV  V16.D[1], X15
    FMOV  D17, X6
    FMOV  V17.D[1], X4
    FMOV  D18, X4
    FMOV  V18.D[1], X17
    FMOV  D19, X2
    FMOV  V19.D[1], X10
    FMOV  D20, X20
    FMOV  V20.D[1], X18
    FMOV  D21, X4
    FMOV  V21.D[1], X18
    FMOV  D22, X2
    FMOV  V22.D[1], X13
    FMOV  D23, X10
    FMOV  V23.D[1], X4
    FMOV  D24, X15
    FMOV  V24.D[1], X18
    FMOV  D25, X15
    FMOV  V25.D[1], X22
    FMOV  D26, X10
    FMOV  V26.D[1], X19
    FMOV  D27, X16
    FMOV  V27.D[1], X15
    FMOV  D28, X14
    FMOV  V28.D[1], X17
    FMOV  D29, X16
    FMOV  V29.D[1], X13
    FMOV  D30, X10
    FMOV  V30.D[1], X21
    FMOV  D31, X12
    FMOV  V31.D[1], X23
    SQRDMLAH H26, H18, V7.H[0x7]
    SQRDMLAH H4, H28, V11.H[0x1]
    SQRDMLAH H30, H31, V0.H[0x4]
    SQRDMLAH H14, H5, V13.H[0x6]
    SQRDMLAH H30, H22, V12.H[0x7]
    SQRDMLAH H22, H24, V4.H[0x0]
    SQRDMLAH H13, H29, V12.H[0x5]
    SQRDMLAH H2, H13, V14.H[0x3]
    SQRDMLAH H4, H20, V14.H[0x3]
    SQRDMLAH H0, H9, V2.H[0x4]
    SQRDMLAH S30, S30, V30.S[0x2]
    SQRDMLAH S14, S22, V7.S[0x3]
    SQRDMLAH S18, S22, V0.S[0x0]
    SQRDMLAH S24, S14, V30.S[0x0]
    SQRDMLAH S13, S24, V26.S[0x3]
    SQRDMLAH S7, S7, V20.S[0x0]
    SQRDMLAH S31, S25, V24.S[0x3]
    SQRDMLAH S30, S1, V7.S[0x1]
    SQRDMLAH S11, S2, V13.S[0x0]
    SQRDMLAH S22, S31, V2.S[0x3]
    SQRDMLAH H14, H3, H11
    SQRDMLAH H3, H4, H27
    SQRDMLAH H13, H7, H14
    SQRDMLAH H20, H30, H18
    SQRDMLAH H24, H13, H14
    SQRDMLAH H7, H24, H5
    SQRDMLAH H23, H20, H3
    SQRDMLAH H3, H22, H7
    SQRDMLAH H28, H7, H14
    SQRDMLAH H20, H2, H5
    SQRDMLAH S1, S20, S9
    SQRDMLAH S12, S5, S25
    SQRDMLAH S25, S21, S8
    SQRDMLAH S11, S31, S0
    SQRDMLAH S2, S14, S27
    SQRDMLAH S0, S21, S6
    SQRDMLAH S8, S2, S28
    SQRDMLAH S24, S11, S0
    SQRDMLAH S6, S3, S12
    SQRDMLAH S26, S13, S23
    SQRDMLSH H11, H1, V5.H[0x0]
    SQRDMLSH H28, H12, V8.H[0x5]
    SQRDMLSH H2, H31, V6.H[0x4]
    SQRDMLSH H4, H20, V11.H[0x2]
    SQRDMLSH H7, H4, V0.H[0x4]
    SQRDMLSH H9, H2, V6.H[0x6]
    SQRDMLSH H12, H0, V7.H[0x6]
    SQRDMLSH H22, H25, V9.H[0x1]
    SQRDMLSH H5, H3, V12.H[0x0]
    SQRDMLSH H19, H8, V5.H[0x1]
    SQRDMLSH S31, S11, V26.S[0x3]
    SQRDMLSH S26, S31, V12.S[0x0]
    SQRDMLSH S21, S28, V24.S[0x3]
    SQRDMLSH S25, S19, V20.S[0x1]
    SQRDMLSH S20, S24, V21.S[0x1]
    SQRDMLSH S11, S26, V21.S[0x3]
    SQRDMLSH S3, S10, V5.S[0x0]
    SQRDMLSH S6, S25, V3.S[0x1]
    SQRDMLSH S9, S20, V6.S[0x2]
    SQRDMLSH S6, S11, V29.S[0x3]
    SQRDMLSH H14, H31, H22
    SQRDMLSH H24, H6, H6
    SQRDMLSH H22, H14, H24
    SQRDMLSH H4, H4, H31
    SQRDMLSH H3, H9, H19
    SQRDMLSH H2, H24, H19
    SQRDMLSH H5, H27, H7
    SQRDMLSH H14, H21, H24
    SQRDMLSH H18, H30, H1
    SQRDMLSH H12, H7, H26
    SQRDMLSH S27, S29, S26
    SQRDMLSH S9, S18, S9
    SQRDMLSH S21, S26, S12
    SQRDMLSH S30, S5, S27
    SQRDMLSH S27, S3, S21
    SQRDMLSH S16, S19, S22
    SQRDMLSH S8, S4, S2
    SQRDMLSH S14, S27, S8
    SQRDMLSH S24, S14, S15
    SQRDMLSH S1, S8, S9
    MOVZ  X14, #0x52d0, LSL #0
    MOVK  X14, #0x73b7, LSL #16
    MOVK  X14, #0xc719, LSL #32
    MOVK  X14, #0x1dea, LSL #48
    SUB  X6, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x3a4c, LSL #0
    MOVK  X14, #0x11bc, LSL #16
    MOVK  X14, #0x90f4, LSL #32
    MOVK  X14, #0x5379, LSL #48
    SUB  X6, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0xeec9, LSL #0
    MOVK  X14, #0x3975, LSL #16
    MOVK  X14, #0x410, LSL #32
    MOVK  X14, #0xe351, LSL #48
    SUB  X6, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x5a63, LSL #0
    MOVK  X14, #0xc160, LSL #16
    MOVK  X14, #0x857f, LSL #32
    MOVK  X14, #0x93d1, LSL #48
    SUB  X6, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0xedf, LSL #0
    MOVK  X14, #0x2aac, LSL #16
    MOVK  X14, #0x8bcf, LSL #32
    MOVK  X14, #0xcea, LSL #48
    SUB  X6, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0xa2e6, LSL #0
    MOVK  X14, #0xfe89, LSL #16
    MOVK  X14, #0x3d49, LSL #32
    MOVK  X14, #0x6328, LSL #48
    SUB  X6, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x54eb, LSL #0
    MOVK  X14, #0xa4d3, LSL #16
    MOVK  X14, #0x22a5, LSL #32
    MOVK  X14, #0xc727, LSL #48
    SUB  X6, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x1c2b, LSL #0
    MOVK  X14, #0x7425, LSL #16
    MOVK  X14, #0x8330, LSL #32
    MOVK  X14, #0xa33b, LSL #48
    SUB  X6, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x1ecf, LSL #0
    MOVK  X14, #0x295a, LSL #16
    MOVK  X14, #0x96b2, LSL #32
    MOVK  X14, #0x99aa, LSL #48
    SUB  X6, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0xbb6d, LSL #0
    MOVK  X14, #0x6b31, LSL #16
    MOVK  X14, #0x7b31, LSL #32
    MOVK  X14, #0xa56b, LSL #48
    SUB  X6, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x824e, LSL #0
    MOVK  X14, #0x3bda, LSL #16
    MOVK  X14, #0x33d4, LSL #32
    MOVK  X14, #0x5a67, LSL #48
    SUB  X6, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0xdf0e, LSL #0
    MOVK  X14, #0xe290, LSL #16
    MOVK  X14, #0x709, LSL #32
    MOVK  X14, #0x55d2, LSL #48
    SUB  X6, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0xf616, LSL #0
    MOVK  X14, #0xd603, LSL #16
    MOVK  X14, #0xde9b, LSL #32
    MOVK  X14, #0xa2e1, LSL #48
    SUB  X6, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x73a5, LSL #0
    MOVK  X14, #0x248a, LSL #16
    MOVK  X14, #0xe5a7, LSL #32
    MOVK  X14, #0x39c7, LSL #48
    SUB  X6, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x4bfe, LSL #0
    MOVK  X14, #0xab46, LSL #16
    MOVK  X14, #0xeee8, LSL #32
    MOVK  X14, #0x8ea2, LSL #48
    SUB  X6, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0xc40b, LSL #0
    MOVK  X14, #0xd0cc, LSL #16
    MOVK  X14, #0x18b1, LSL #32
    MOVK  X14, #0xe56c, LSL #48
    SUB  X6, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x7063, LSL #0
    MOVK  X14, #0x6c21, LSL #16
    MOVK  X14, #0x25c6, LSL #32
    MOVK  X14, #0x88e4, LSL #48
    SUB  X6, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0xd121, LSL #0
    MOVK  X14, #0xcd1d, LSL #16
    MOVK  X14, #0x546c, LSL #32
    MOVK  X14, #0xff59, LSL #48
    SUB  X6, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0xa805, LSL #0
    MOVK  X14, #0x3308, LSL #16
    MOVK  X14, #0xb501, LSL #32
    MOVK  X14, #0xb3f9, LSL #48
    SUB  X6, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X14, #0x8fbf, LSL #0
    MOVK  X14, #0x58cf, LSL #16
    MOVK  X14, #0x3c36, LSL #32
    MOVK  X14, #0xbc0a, LSL #48
    SUB  X6, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MRS  X14, FPSR
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x800, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D0
    MOVZ  X6, #0x53a0, LSL #0
    MOVK  X6, #0xf2ca, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D1
    MOVZ  X6, #0xe4db, LSL #0
    MOVK  X6, #0x58cf, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D2
    MOVZ  X6, #0xedd3, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D3
    MOVZ  X6, #0x415e, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D4
    MOVZ  X6, #0x7fff, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D5
    MOVZ  X6, #0x21b5, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D6
    MOVZ  X6, #0xc84e, LSL #0
    MOVK  X6, #0xe290, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D7
    MOVZ  X6, #0x75a3, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D8
    MOVZ  X6, #0x73a5, LSL #0
    MOVK  X6, #0x248a, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D9
    MOVZ  X6, #0x8fbe, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X6, #0xb39e, LSL #0
    MOVK  X6, #0xadfc, LSL #16
    MOVK  X6, #0x2d7c, LSL #32
    MOVK  X6, #0x3569, LSL #48
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D10
    MOVZ  X6, #0x8fbf, LSL #0
    MOVK  X6, #0x58cf, LSL #16
    MOVK  X6, #0x3c36, LSL #32
    MOVK  X6, #0xbc0a, LSL #48
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D11
    MOVZ  X6, #0x1f06, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D12
    MOVZ  X6, #0x7fff, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D13
    MOVZ  X6, #0x95e1, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D14
    MOVZ  X6, #0xee2d, LSL #0
    MOVK  X6, #0xbfc, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X6, #0xf616, LSL #0
    MOVK  X6, #0xd603, LSL #16
    MOVK  X6, #0xde9b, LSL #32
    MOVK  X6, #0xa2e1, LSL #48
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D15
    MOVZ  X6, #0x4bfe, LSL #0
    MOVK  X6, #0xab46, LSL #16
    MOVK  X6, #0xeee8, LSL #32
    MOVK  X6, #0x8ea2, LSL #48
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D16
    MOVZ  X6, #0x5a62, LSL #0
    MOVK  X6, #0xc160, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X6, #0xeec9, LSL #0
    MOVK  X6, #0x3975, LSL #16
    MOVK  X6, #0x410, LSL #32
    MOVK  X6, #0xe351, LSL #48
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D17
    MOVZ  X6, #0x54e, LSL #0
    MOVK  X6, #0x75c7, LSL #16
    MOVK  X6, #0x13c8, LSL #32
    MOVK  X6, #0x7324, LSL #48
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D18
    MOVZ  X6, #0xec67, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D19
    MOVZ  X6, #0x52d0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D20
    MOVZ  X6, #0xb5cf, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D21
    MOVZ  X6, #0xeec9, LSL #0
    MOVK  X6, #0x3975, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D22
    MOVZ  X6, #0xe09a, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D23
    MOVZ  X6, #0x2e29, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D24
    MOVZ  X6, #0xef0f, LSL #0
    MOVK  X6, #0x7ef, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D25
    MOVZ  X6, #0x3146, LSL #0
    MOVK  X6, #0xf2f8, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D26
    MOVZ  X6, #0xcc12, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D27
    MOVZ  X6, #0xc7b6, LSL #0
    MOVK  X6, #0xd603, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D28
    MOVZ  X6, #0x8000, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X6, #0x824e, LSL #0
    MOVK  X6, #0x3bda, LSL #16
    MOVK  X6, #0x33d4, LSL #32
    MOVK  X6, #0x5a67, LSL #48
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D29
    MOVZ  X6, #0xf616, LSL #0
    MOVK  X6, #0xd603, LSL #16
    MOVK  X6, #0xde9b, LSL #32
    MOVK  X6, #0xa2e1, LSL #48
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D30
    MOVZ  X6, #0x2104, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X14, D31
    MOVZ  X6, #0xbb6d, LSL #0
    MOVK  X6, #0x6b31, LSL #16
    SUB  X19, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x5e79, LSL #0
    MOVK  X2, #0x48f7, LSL #16
    MOVK  X2, #0x3cb2, LSL #32
    MOVK  X2, #0x4d8a, LSL #48
    MOVZ  X3, #0x1e28, LSL #0
    MOVK  X3, #0xa686, LSL #16
    MOVK  X3, #0xe27f, LSL #32
    MOVK  X3, #0x3aa7, LSL #48
    MOVZ  X4, #0x9eb, LSL #0
    MOVK  X4, #0x1e2e, LSL #16
    MOVK  X4, #0x80e6, LSL #32
    MOVK  X4, #0x7b36, LSL #48
    MOVZ  X5, #0x39e5, LSL #0
    MOVK  X5, #0xe7bd, LSL #16
    MOVK  X5, #0x8a2d, LSL #32
    MOVK  X5, #0x541b, LSL #48
    MOVZ  X6, #0xc516, LSL #0
    MOVK  X6, #0xb13a, LSL #16
    MOVK  X6, #0x5225, LSL #32
    MOVK  X6, #0x1b78, LSL #48
    MOVZ  X7, #0x17ef, LSL #0
    MOVK  X7, #0x5c62, LSL #16
    MOVK  X7, #0xeea9, LSL #32
    MOVK  X7, #0x56e0, LSL #48
    MOVZ  X8, #0x414b, LSL #0
    MOVK  X8, #0xbc13, LSL #16
    MOVK  X8, #0x8040, LSL #32
    MOVK  X8, #0xa6a2, LSL #48
    MOVZ  X9, #0xb4c2, LSL #0
    MOVK  X9, #0x191b, LSL #16
    MOVK  X9, #0xe7d4, LSL #32
    MOVK  X9, #0x8b3e, LSL #48
    MOVZ  X10, #0x2ee3, LSL #0
    MOVK  X10, #0xeebb, LSL #16
    MOVK  X10, #0x8269, LSL #32
    MOVK  X10, #0xc029, LSL #48
    MOVZ  X11, #0xa9f1, LSL #0
    MOVK  X11, #0xa8c6, LSL #16
    MOVK  X11, #0xc947, LSL #32
    MOVK  X11, #0xbbf0, LSL #48
    MOVZ  X12, #0x98d, LSL #0
    MOVK  X12, #0xa917, LSL #16
    MOVK  X12, #0xd321, LSL #32
    MOVK  X12, #0x55ab, LSL #48
    MOVZ  X13, #0xecce, LSL #0
    MOVK  X13, #0x838f, LSL #16
    MOVK  X13, #0x1c6, LSL #32
    MOVK  X13, #0xb147, LSL #48
    MOVZ  X14, #0x14d1, LSL #0
    MOVK  X14, #0x2b5b, LSL #16
    MOVK  X14, #0xf410, LSL #32
    MOVK  X14, #0x3a7f, LSL #48
    MOVZ  X15, #0xb606, LSL #0
    MOVK  X15, #0xe705, LSL #16
    MOVK  X15, #0x296c, LSL #32
    MOVK  X15, #0xd509, LSL #48
    MOVZ  X16, #0x745f, LSL #0
    MOVK  X16, #0xd94f, LSL #16
    MOVK  X16, #0xf113, LSL #32
    MOVK  X16, #0x33f, LSL #48
    MOVZ  X17, #0x40b0, LSL #0
    MOVK  X17, #0x42cd, LSL #16
    MOVK  X17, #0xcd4f, LSL #32
    MOVK  X17, #0x3741, LSL #48
    MOVZ  X18, #0x891d, LSL #0
    MOVK  X18, #0x51b, LSL #16
    MOVK  X18, #0x8445, LSL #32
    MOVK  X18, #0x8790, LSL #48
    MOVZ  X19, #0xf0aa, LSL #0
    MOVK  X19, #0x7781, LSL #16
    MOVK  X19, #0xaa20, LSL #32
    MOVK  X19, #0xd342, LSL #48
    MOVZ  X20, #0x1fc, LSL #0
    MOVK  X20, #0x3711, LSL #16
    MOVK  X20, #0xdeb2, LSL #32
    MOVK  X20, #0x3cbc, LSL #48
    MOVZ  X21, #0x56aa, LSL #0
    MOVK  X21, #0x6417, LSL #16
    MOVK  X21, #0x142c, LSL #32
    MOVK  X21, #0x81da, LSL #48
    MOVZ  X22, #0xea12, LSL #0
    MOVK  X22, #0x37c9, LSL #16
    MOVK  X22, #0xcbe0, LSL #32
    MOVK  X22, #0xa6eb, LSL #48
    MOVZ  X23, #0x91ec, LSL #0
    MOVK  X23, #0xf227, LSL #16
    MOVK  X23, #0xb3dd, LSL #32
    MOVK  X23, #0x7969, LSL #48
    MOVZ  X25, #0xcb13, LSL #0
    MOVK  X25, #0xde35, LSL #16
    MOVK  X25, #0x2717, LSL #32
    MOVK  X25, #0x1cc6, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X21
    FMOV  D1, X23
    FMOV  V1.D[1], X18
    FMOV  D2, X22
    FMOV  V2.D[1], X25
    FMOV  D3, X7
    FMOV  V3.D[1], X16
    FMOV  D4, X23
    FMOV  V4.D[1], X12
    FMOV  D5, X22
    FMOV  V5.D[1], X16
    FMOV  D6, X22
    FMOV  V6.D[1], X23
    FMOV  D7, X23
    FMOV  V7.D[1], X8
    FMOV  D8, X17
    FMOV  V8.D[1], X16
    FMOV  D9, X16
    FMOV  V9.D[1], X9
    FMOV  D10, X6
    FMOV  V10.D[1], X21
    FMOV  D11, X8
    FMOV  V11.D[1], X4
    FMOV  D12, X7
    FMOV  V12.D[1], X19
    FMOV  D13, X4
    FMOV  V13.D[1], X12
    FMOV  D14, X2
    FMOV  V14.D[1], X21
    FMOV  D15, X3
    FMOV  V15.D[1], X22
    FMOV  D16, X10
    FMOV  V16.D[1], X12
    FMOV  D17, X25
    FMOV  V17.D[1], X9
    FMOV  D18, X13
    FMOV  V18.D[1], X17
    FMOV  D19, X16
    FMOV  V19.D[1], X6
    FMOV  D20, X17
    FMOV  V20.D[1], X21
    FMOV  D21, X6
    FMOV  V21.D[1], X14
    FMOV  D22, X21
    FMOV  V22.D[1], X3
    FMOV  D23, X22
    FMOV  V23.D[1], X7
    FMOV  D24, X7
    FMOV  V24.D[1], X3
    FMOV  D25, X22
    FMOV  V25.D[1], X9
    FMOV  D26, X17
    FMOV  V26.D[1], X6
    FMOV  D27, X14
    FMOV  V27.D[1], X12
    FMOV  D28, X3
    FMOV  V28.D[1], X19
    FMOV  D29, X21
    FMOV  V29.D[1], X17
    FMOV  D30, X12
    FMOV  V30.D[1], X5
    FMOV  D31, X25
    FMOV  V31.D[1], X20
    MOVZ  X5, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_0:
    SQRDMLAH S14, S30, S27
    SQRDMLSH S13, S7, S26
    SQRDMLAH S27, S25, S31
    SQRDMLSH H19, H14, H13
    SQRDMLSH S13, S28, V27.S[0x2]
    SQRDMLSH H4, H19, V13.H[0x3]
    SQRDMLAH H31, H4, V4.H[0x5]
    SQRDMLSH H8, H27, V2.H[0x6]
    SQRDMLAH S31, S8, V29.S[0x1]
    SQRDMLSH S0, S16, V31.S[0x2]
    SQRDMLSH H31, H0, V0.H[0x6]
    SQRDMLAH S29, S23, V31.S[0x3]
    SQRDMLSH S25, S24, S29
    SQRDMLSH S27, S2, S29
    SQRDMLAH H4, H20, H22
    SQRDMLAH H27, H22, H10
    SQRDMLAH S2, S23, V28.S[0x1]
    SQRDMLAH H7, H25, H15
    SQRDMLSH H13, H0, H30
    SQRDMLAH H22, H24, H2
    SQRDMLSH H25, H11, H16
    SQRDMLAH H8, H9, H6
    SQRDMLAH H25, H8, H23
    SQRDMLSH H8, H24, V9.H[0x1]
    SQRDMLAH S14, S30, S15
    SQRDMLSH S9, S21, V22.S[0x1]
    SQRDMLSH S31, S4, V0.S[0x1]
    SQRDMLSH S5, S19, S24
    SQRDMLAH H30, H16, H13
    SQRDMLSH S29, S9, S8
    SQRDMLAH H22, H29, H27
    SQRDMLSH H21, H26, V5.H[0x2]
    SQRDMLSH H27, H30, H27
    SQRDMLSH S9, S21, V27.S[0x2]
    SQRDMLAH S0, S7, V25.S[0x3]
    SQRDMLAH S20, S9, V31.S[0x2]
    SQRDMLSH S13, S22, V20.S[0x3]
    SQRDMLAH S26, S0, S0
    SQRDMLAH S27, S13, V14.S[0x3]
    SQRDMLSH S0, S15, V10.S[0x1]
    SQRDMLAH H29, H24, V0.H[0x5]
    SQRDMLSH S11, S23, V26.S[0x1]
    SQRDMLSH H24, H24, H7
    SQRDMLAH S16, S25, V13.S[0x0]
    SQRDMLAH H6, H6, V8.H[0x5]
    SQRDMLAH H8, H7, H9
    SQRDMLSH S31, S14, S26
    SQRDMLSH S10, S23, S19
    SQRDMLSH S0, S16, S5
    SQRDMLSH H21, H24, V8.H[0x5]
    SQRDMLAH S4, S20, V31.S[0x2]
    SQRDMLAH S20, S11, S8
    SQRDMLAH H8, H4, V9.H[0x3]
    SQRDMLSH H9, H10, H23
    SQRDMLSH S23, S29, V0.S[0x2]
    SQRDMLAH S4, S20, V6.S[0x1]
    SQRDMLSH H20, H6, V8.H[0x5]
    SQRDMLSH S22, S4, V28.S[0x1]
    SQRDMLAH S16, S27, S9
    SQRDMLAH S25, S16, S20
    SQRDMLAH S11, S19, V22.S[0x0]
    SQRDMLSH S7, S25, V21.S[0x3]
    SQRDMLSH S0, S23, S16
    SQRDMLSH H21, H16, V8.H[0x5]
    SQRDMLSH S28, S25, V14.S[0x1]
    SQRDMLAH S29, S7, V23.S[0x2]
    SQRDMLAH S8, S21, V28.S[0x3]
    SQRDMLSH S21, S11, V21.S[0x3]
    SQRDMLSH S4, S0, V9.S[0x3]
    SQRDMLAH S31, S25, V4.S[0x2]
    SQRDMLSH S0, S21, S27
    SQRDMLSH H10, H31, V11.H[0x7]
    SQRDMLSH S22, S29, S29
    SQRDMLSH H28, H1, H23
    SQRDMLSH S20, S10, S8
    SQRDMLAH H24, H0, V1.H[0x2]
    SQRDMLAH H10, H24, H12
    SQRDMLSH S4, S28, V13.S[0x1]
    SQRDMLAH S5, S12, V23.S[0x3]
    SQRDMLAH H15, H26, H22
    SQRDMLAH H8, H10, H10
    SQRDMLAH H10, H5, H20
    SQRDMLAH S1, S4, S15
    SQRDMLAH S28, S1, S28
    SQRDMLAH H29, H28, H5
    SQRDMLSH S9, S10, S0
    SQRDMLSH S6, S11, V20.S[0x3]
    SQRDMLAH H19, H9, V8.H[0x2]
    SQRDMLAH S21, S1, S29
    SQRDMLSH S0, S21, V27.S[0x1]
    SQRDMLSH H4, H2, V11.H[0x0]
    SQRDMLAH H26, H4, V0.H[0x6]
    SQRDMLAH S0, S12, S19
    SQRDMLAH H23, H26, V0.H[0x0]
    SQRDMLAH H9, H11, H25
    SQRDMLAH H13, H1, V7.H[0x4]
    SQRDMLAH H27, H22, V13.H[0x2]
    SQRDMLAH H24, H15, H4
    SQRDMLAH H21, H22, V13.H[0x7]
    SQRDMLAH S28, S23, V24.S[0x3]
    SQRDMLSH H4, H31, V4.H[0x0]
    SQRDMLAH H11, H18, V13.H[0x1]
    SQRDMLSH S18, S14, V6.S[0x2]
    SQRDMLSH S13, S4, V3.S[0x2]
    SQRDMLAH S10, S14, V27.S[0x0]
    SQRDMLAH S12, S23, V3.S[0x2]
    SQRDMLAH H25, H31, H6
    SQRDMLSH H6, H10, H13
    SQRDMLAH H2, H21, V12.H[0x1]
    SQRDMLAH H17, H9, H11
    SQRDMLSH S1, S2, V28.S[0x3]
    SQRDMLAH S14, S17, S17
    SQRDMLSH H4, H25, V5.H[0x1]
    SQRDMLSH S11, S6, S4
    SQRDMLAH H4, H14, H18
    SQRDMLAH H20, H1, V1.H[0x7]
    SQRDMLSH H3, H4, V11.H[0x5]
    SQRDMLAH H30, H29, H6
    SQRDMLAH S27, S15, S28
    SQRDMLAH H6, H9, V11.H[0x5]
    SQRDMLAH S28, S27, S0
    SQRDMLSH S13, S23, V22.S[0x0]
    SQRDMLAH H15, H25, H2
    SQRDMLSH H30, H11, V15.H[0x5]
    SQRDMLAH S17, S13, V3.S[0x2]
    SQRDMLAH H4, H11, V15.H[0x1]
    SQRDMLSH H12, H23, H12
    SQRDMLSH S5, S29, S20
    SQRDMLSH H18, H9, V6.H[0x2]
    SQRDMLSH S31, S26, S22
    SQRDMLSH S1, S16, S19
    SQRDMLAH S19, S5, S20
    SQRDMLSH S13, S12, V12.S[0x1]
    SQRDMLSH S9, S30, S17
    SQRDMLAH H12, H19, V8.H[0x6]
    SQRDMLAH H10, H22, H18
    SQRDMLSH H17, H31, V10.H[0x4]
    SQRDMLAH S15, S17, V10.S[0x2]
    SQRDMLAH H10, H15, V13.H[0x3]
    SQRDMLSH S14, S28, S28
    SQRDMLAH H2, H9, H4
    SQRDMLSH S26, S12, V2.S[0x2]
    SQRDMLAH H15, H26, V14.H[0x3]
    SQRDMLSH H28, H10, H15
    SQRDMLSH S14, S11, S10
    SQRDMLSH S6, S6, V11.S[0x2]
    SQRDMLAH H27, H12, H0
    SQRDMLSH H19, H0, V15.H[0x6]
    SQRDMLSH S2, S30, S22
    SQRDMLSH S25, S5, S1
    SQRDMLAH H16, H12, V6.H[0x3]
    SQRDMLAH S9, S4, V10.S[0x0]
    SQRDMLAH S22, S29, S24
    SQRDMLSH S24, S19, V16.S[0x1]
    SQRDMLSH S15, S2, S27
    SQRDMLAH H0, H16, V9.H[0x4]
    SQRDMLAH S10, S12, V0.S[0x2]
    SQRDMLSH H31, H28, V14.H[0x3]
    SQRDMLSH S30, S25, V15.S[0x0]
    SQRDMLSH H11, H24, H24
    SQRDMLAH H27, H7, V11.H[0x3]
    SQRDMLSH S17, S27, S31
    SQRDMLSH H7, H21, H30
    SQRDMLAH H1, H10, V1.H[0x7]
    SQRDMLAH H4, H7, V7.H[0x7]
    SQRDMLAH H13, H17, V11.H[0x7]
    SQRDMLAH S5, S22, V23.S[0x3]
    SQRDMLSH H0, H1, V11.H[0x5]
    SQRDMLAH H9, H0, V4.H[0x6]
    SQRDMLSH S0, S5, V5.S[0x1]
    SQRDMLAH S11, S9, V12.S[0x3]
    SQRDMLSH H4, H10, V13.H[0x5]
    SQRDMLSH H30, H4, H4
    SQRDMLSH H31, H17, H30
    SQRDMLSH S5, S11, V0.S[0x2]
    SQRDMLAH H22, H6, H18
    SQRDMLAH H1, H15, H31
    SQRDMLSH S24, S13, S13
    SQRDMLAH H31, H8, H17
    SQRDMLSH S18, S26, S14
    SQRDMLSH H7, H25, H18
    SQRDMLSH S21, S2, S9
    SQRDMLAH S19, S17, S31
    SQRDMLSH H19, H31, V7.H[0x1]
    SQRDMLAH S12, S30, V5.S[0x0]
    SQRDMLAH S28, S8, V2.S[0x2]
    SQRDMLAH S0, S25, S29
    SQRDMLAH S8, S2, S31
    SQRDMLAH S5, S21, S0
    SQRDMLSH H6, H19, V0.H[0x1]
    SQRDMLSH S10, S28, S1
    SQRDMLAH H28, H25, H6
    SQRDMLAH S1, S10, S24
    SQRDMLSH H26, H28, V11.H[0x2]
    SQRDMLSH S29, S7, S14
    SQRDMLSH S17, S29, V30.S[0x3]
    SQRDMLSH H19, H17, V8.H[0x1]
    SQRDMLAH H9, H7, V8.H[0x6]
    SQRDMLAH S2, S10, V6.S[0x2]
    SQRDMLSH H15, H9, H9
    SUBS  X5, X5, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_0
    MOVZ  X2, #0x1e28, LSL #0
    MOVK  X2, #0xa686, LSL #16
    MOVK  X2, #0xe27f, LSL #32
    MOVK  X2, #0x3aa7, LSL #48
    SUB  X16, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x9eb, LSL #0
    MOVK  X2, #0x1e2e, LSL #16
    MOVK  X2, #0x80e6, LSL #32
    MOVK  X2, #0x7b36, LSL #48
    SUB  X16, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0xc516, LSL #0
    MOVK  X2, #0xb13a, LSL #16
    MOVK  X2, #0x5225, LSL #32
    MOVK  X2, #0x1b78, LSL #48
    SUB  X16, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x17ef, LSL #0
    MOVK  X2, #0x5c62, LSL #16
    MOVK  X2, #0xeea9, LSL #32
    MOVK  X2, #0x56e0, LSL #48
    SUB  X16, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x414b, LSL #0
    MOVK  X2, #0xbc13, LSL #16
    MOVK  X2, #0x8040, LSL #32
    MOVK  X2, #0xa6a2, LSL #48
    SUB  X16, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0xb4c2, LSL #0
    MOVK  X2, #0x191b, LSL #16
    MOVK  X2, #0xe7d4, LSL #32
    MOVK  X2, #0x8b3e, LSL #48
    SUB  X16, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x2ee3, LSL #0
    MOVK  X2, #0xeebb, LSL #16
    MOVK  X2, #0x8269, LSL #32
    MOVK  X2, #0xc029, LSL #48
    SUB  X16, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0xa9f1, LSL #0
    MOVK  X2, #0xa8c6, LSL #16
    MOVK  X2, #0xc947, LSL #32
    MOVK  X2, #0xbbf0, LSL #48
    SUB  X16, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x98d, LSL #0
    MOVK  X2, #0xa917, LSL #16
    MOVK  X2, #0xd321, LSL #32
    MOVK  X2, #0x55ab, LSL #48
    SUB  X16, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0xecce, LSL #0
    MOVK  X2, #0x838f, LSL #16
    MOVK  X2, #0x1c6, LSL #32
    MOVK  X2, #0xb147, LSL #48
    SUB  X16, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x14d1, LSL #0
    MOVK  X2, #0x2b5b, LSL #16
    MOVK  X2, #0xf410, LSL #32
    MOVK  X2, #0x3a7f, LSL #48
    SUB  X16, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0xb606, LSL #0
    MOVK  X2, #0xe705, LSL #16
    MOVK  X2, #0x296c, LSL #32
    MOVK  X2, #0xd509, LSL #48
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x891d, LSL #0
    MOVK  X2, #0x51b, LSL #16
    MOVK  X2, #0x8445, LSL #32
    MOVK  X2, #0x8790, LSL #48
    SUB  X16, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0xf0aa, LSL #0
    MOVK  X2, #0x7781, LSL #16
    MOVK  X2, #0xaa20, LSL #32
    MOVK  X2, #0xd342, LSL #48
    SUB  X16, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x1fc, LSL #0
    MOVK  X2, #0x3711, LSL #16
    MOVK  X2, #0xdeb2, LSL #32
    MOVK  X2, #0x3cbc, LSL #48
    SUB  X16, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x56aa, LSL #0
    MOVK  X2, #0x6417, LSL #16
    MOVK  X2, #0x142c, LSL #32
    MOVK  X2, #0x81da, LSL #48
    SUB  X16, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0xea12, LSL #0
    MOVK  X2, #0x37c9, LSL #16
    MOVK  X2, #0xcbe0, LSL #32
    MOVK  X2, #0xa6eb, LSL #48
    SUB  X16, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x91ec, LSL #0
    MOVK  X2, #0xf227, LSL #16
    MOVK  X2, #0xb3dd, LSL #32
    MOVK  X2, #0x7969, LSL #48
    SUB  X16, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0xcb13, LSL #0
    MOVK  X2, #0xde35, LSL #16
    MOVK  X2, #0x2717, LSL #32
    MOVK  X2, #0x1cc6, LSL #48
    SUB  X16, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    MRS  X2, FPSR
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x800, LSL #16
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D0
    MOVZ  X16, #0xeb4, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D1
    MOVZ  X16, #0xa169, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D2
    MOVZ  X16, #0x8000, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D3
    MOVZ  X16, #0x17ef, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D4
    MOVZ  X16, #0x4428, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D5
    MOVZ  X16, #0x8dad, LSL #0
    MOVK  X16, #0x37c9, LSL #16
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D6
    MOVZ  X16, #0xfcf5, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D7
    MOVZ  X16, #0x7fff, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D8
    MOVZ  X16, #0x9204, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D9
    MOVZ  X16, #0x8000, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D10
    MOVZ  X16, #0x1d2c, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D11
    MOVZ  X16, #0x3c29, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D12
    MOVZ  X16, #0xe97e, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D13
    MOVZ  X16, #0x7ffe, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D14
    MOVZ  X16, #0xe2, LSL #0
    MOVK  X16, #0x6848, LSL #16
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D15
    MOVZ  X16, #0x8000, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D16
    MOVZ  X16, #0x2ef0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D17
    MOVZ  X16, #0x326d, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D18
    MOVZ  X16, #0xc67a, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D19
    MOVZ  X16, #0xc604, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D20
    MOVZ  X16, #0xc14c, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D21
    MOVZ  X16, #0xbab3, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D22
    MOVZ  X16, #0x68b3, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D23
    MOVZ  X16, #0xe09c, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D24
    MOVZ  X16, #0xd0ce, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D25
    MOVZ  X16, #0x72d4, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D26
    MOVZ  X16, #0xe0ab, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D27
    MOVZ  X16, #0xe156, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D28
    MOVZ  X16, #0xb6db, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D29
    MOVZ  X16, #0xa683, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D30
    MOVZ  X16, #0xf20e, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X2, D31
    MOVZ  X16, #0xa31f, LSL #0
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    FMOV  D0, X7
    FMOV  V0.D[1], X12
    FMOV  D1, X3
    FMOV  V1.D[1], X20
    FMOV  D2, X2
    FMOV  V2.D[1], X15
    FMOV  D3, X6
    FMOV  V3.D[1], X21
    FMOV  D4, X10
    FMOV  V4.D[1], X18
    FMOV  D5, X16
    FMOV  V5.D[1], X23
    FMOV  D6, X25
    FMOV  V6.D[1], X8
    FMOV  D7, X22
    FMOV  V7.D[1], X22
    FMOV  D8, X4
    FMOV  V8.D[1], X9
    FMOV  D9, X22
    FMOV  V9.D[1], X10
    FMOV  D10, X17
    FMOV  V10.D[1], X13
    FMOV  D11, X16
    FMOV  V11.D[1], X2
    FMOV  D12, X21
    FMOV  V12.D[1], X11
    FMOV  D13, X22
    FMOV  V13.D[1], X23
    FMOV  D14, X15
    FMOV  V14.D[1], X11
    FMOV  D15, X13
    FMOV  V15.D[1], X13
    FMOV  D16, X5
    FMOV  V16.D[1], X15
    FMOV  D17, X19
    FMOV  V17.D[1], X9
    FMOV  D18, X18
    FMOV  V18.D[1], X23
    FMOV  D19, X23
    FMOV  V19.D[1], X20
    FMOV  D20, X3
    FMOV  V20.D[1], X4
    FMOV  D21, X5
    FMOV  V21.D[1], X4
    FMOV  D22, X22
    FMOV  V22.D[1], X15
    FMOV  D23, X15
    FMOV  V23.D[1], X7
    FMOV  D24, X21
    FMOV  V24.D[1], X4
    FMOV  D25, X11
    FMOV  V25.D[1], X17
    FMOV  D26, X22
    FMOV  V26.D[1], X6
    FMOV  D27, X6
    FMOV  V27.D[1], X5
    FMOV  D28, X19
    FMOV  V28.D[1], X6
    FMOV  D29, X5
    FMOV  V29.D[1], X19
    FMOV  D30, X25
    FMOV  V30.D[1], X22
    FMOV  D31, X11
    FMOV  V31.D[1], X8
    MOVZ  X18, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_1:
    SQRDMLAH H5, H31, V2.H[0x4]
    SQRDMLSH S27, S29, S26
    SQRDMLSH H11, H28, V4.H[0x4]
    SQRDMLSH S0, S20, V25.S[0x2]
    SQRDMLAH H7, H23, V14.H[0x2]
    SQRDMLAH H27, H0, H0
    SQRDMLAH H24, H7, H30
    SQRDMLSH S5, S4, S3
    SQRDMLSH H20, H24, V5.H[0x7]
    SQRDMLAH S23, S22, V27.S[0x1]
    SQRDMLAH S14, S31, V23.S[0x0]
    SQRDMLAH H22, H16, V11.H[0x1]
    SQRDMLSH H25, H22, V9.H[0x1]
    SQRDMLAH H20, H25, H8
    SQRDMLAH H2, H13, V9.H[0x6]
    SQRDMLAH S13, S31, S22
    SQRDMLSH H16, H4, V15.H[0x3]
    SQRDMLSH H8, H26, H1
    SQRDMLAH S5, S21, S30
    SQRDMLSH S22, S1, V1.S[0x3]
    SQRDMLAH H24, H22, V6.H[0x2]
    SQRDMLSH S27, S12, S23
    SQRDMLSH H29, H8, H2
    SQRDMLSH H29, H27, V6.H[0x2]
    SQRDMLSH S21, S26, V5.S[0x2]
    SQRDMLAH H7, H24, H19
    SQRDMLSH S19, S13, V0.S[0x3]
    SQRDMLAH S11, S27, V15.S[0x2]
    SQRDMLSH H11, H20, H25
    SQRDMLAH S30, S7, V21.S[0x1]
    SQRDMLSH S28, S30, V19.S[0x2]
    SQRDMLSH H21, H29, H14
    SQRDMLAH S24, S2, S11
    SQRDMLSH H5, H21, V11.H[0x6]
    SQRDMLSH S29, S24, V16.S[0x3]
    SQRDMLSH H13, H28, H31
    SQRDMLSH H8, H18, H22
    SQRDMLAH S23, S25, S8
    SQRDMLAH S1, S13, V4.S[0x1]
    SQRDMLAH S16, S29, V29.S[0x1]
    SQRDMLAH S8, S8, V23.S[0x0]
    SQRDMLAH H14, H1, H1
    SQRDMLAH S6, S14, S31
    SQRDMLSH S19, S8, V14.S[0x0]
    SQRDMLAH S30, S6, S21
    SQRDMLAH S27, S30, V30.S[0x0]
    SQRDMLSH H28, H30, H19
    SQRDMLSH S14, S13, S16
    SQRDMLSH S15, S14, S28
    SQRDMLSH H21, H27, V5.H[0x2]
    SQRDMLSH H13, H0, V2.H[0x3]
    SQRDMLAH H19, H15, H1
    SQRDMLAH S16, S14, S6
    SQRDMLSH S14, S0, V25.S[0x2]
    SQRDMLSH H30, H13, H27
    SQRDMLSH S0, S8, V25.S[0x0]
    SQRDMLAH H22, H12, H14
    SQRDMLSH H6, H31, V10.H[0x1]
    SQRDMLSH H17, H3, H0
    SQRDMLSH S29, S15, V15.S[0x0]
    SQRDMLSH S10, S13, S31
    SQRDMLAH S15, S28, S22
    SQRDMLSH H13, H6, V10.H[0x6]
    SQRDMLSH S31, S19, V13.S[0x3]
    SQRDMLAH H16, H21, H21
    SQRDMLAH S14, S17, S1
    SQRDMLAH H10, H19, V14.H[0x0]
    SQRDMLSH H27, H2, V10.H[0x4]
    SQRDMLAH S28, S29, S30
    SQRDMLAH S22, S15, V31.S[0x3]
    SQRDMLAH S19, S22, V27.S[0x0]
    SQRDMLAH S22, S19, S28
    SQRDMLSH H3, H18, H11
    SQRDMLSH H0, H11, V13.H[0x1]
    SQRDMLSH S19, S19, V19.S[0x3]
    SQRDMLAH H21, H3, V0.H[0x5]
    SQRDMLSH H28, H3, H14
    SQRDMLAH H12, H2, V1.H[0x6]
    SQRDMLSH H14, H11, V8.H[0x0]
    SQRDMLAH S27, S2, S31
    SQRDMLAH S30, S29, V5.S[0x0]
    SQRDMLAH S13, S19, V30.S[0x3]
    SQRDMLSH H28, H12, V12.H[0x2]
    SQRDMLSH S12, S14, S14
    SQRDMLSH H11, H22, H30
    SQRDMLSH H22, H27, H1
    SQRDMLSH H3, H28, H0
    SQRDMLAH S25, S16, S3
    SQRDMLAH S31, S11, S12
    SQRDMLAH S1, S25, S21
    SQRDMLAH H5, H22, H13
    SQRDMLAH S28, S1, V5.S[0x0]
    SQRDMLSH S22, S1, S4
    SQRDMLAH H13, H19, V6.H[0x4]
    SQRDMLAH S18, S12, V17.S[0x0]
    SQRDMLAH S11, S9, V22.S[0x3]
    SQRDMLSH S17, S7, S5
    SQRDMLAH S2, S21, V16.S[0x1]
    SQRDMLAH H2, H29, V14.H[0x5]
    SQRDMLAH S1, S12, S11
    SQRDMLAH H12, H5, V2.H[0x7]
    SQRDMLSH H16, H31, H23
    SQRDMLAH H2, H5, V14.H[0x1]
    SQRDMLSH S8, S14, V10.S[0x1]
    SQRDMLSH S4, S1, V17.S[0x1]
    SQRDMLAH H22, H16, H13
    SQRDMLSH S1, S28, V12.S[0x1]
    SQRDMLSH H11, H22, H1
    SQRDMLAH H26, H10, H12
    SQRDMLAH H10, H12, V13.H[0x6]
    SQRDMLSH H21, H8, H9
    SQRDMLSH S8, S4, S28
    SQRDMLAH H29, H2, H18
    SQRDMLSH H27, H10, V8.H[0x7]
    SQRDMLSH H26, H27, V11.H[0x7]
    SQRDMLAH H13, H8, V2.H[0x5]
    SQRDMLAH H5, H18, V13.H[0x5]
    SQRDMLAH S13, S8, V8.S[0x1]
    SQRDMLSH H9, H5, H5
    SQRDMLSH H16, H20, V9.H[0x6]
    SQRDMLSH H4, H16, H21
    SQRDMLAH H23, H29, H18
    SQRDMLSH H2, H10, V10.H[0x3]
    SQRDMLSH H9, H2, V2.H[0x6]
    SQRDMLSH S28, S13, S26
    SQRDMLAH S12, S28, V23.S[0x3]
    SQRDMLSH S12, S21, V25.S[0x3]
    SQRDMLSH S27, S10, S14
    SQRDMLAH S31, S20, S25
    SQRDMLAH S5, S4, V27.S[0x0]
    SQRDMLAH S29, S15, V31.S[0x3]
    SQRDMLSH S20, S5, V29.S[0x0]
    SQRDMLSH S2, S13, V12.S[0x2]
    SQRDMLSH S25, S0, S9
    SQRDMLSH H16, H20, H25
    SQRDMLSH S18, S11, V2.S[0x3]
    SQRDMLAH S31, S29, S30
    SQRDMLAH H22, H18, V2.H[0x2]
    SQRDMLAH H9, H29, H30
    SQRDMLAH S19, S16, V23.S[0x0]
    SQRDMLSH S21, S1, V7.S[0x1]
    SQRDMLSH H23, H9, H1
    SQRDMLAH S15, S22, V5.S[0x2]
    SQRDMLAH S18, S7, S17
    SQRDMLAH H8, H5, H0
    SQRDMLSH S27, S12, V27.S[0x2]
    SQRDMLSH S7, S26, S23
    SQRDMLAH H9, H23, V12.H[0x7]
    SQRDMLAH S11, S9, S7
    SQRDMLSH S19, S25, S18
    SQRDMLAH S24, S19, V2.S[0x3]
    SQRDMLSH S1, S27, S29
    SQRDMLSH S2, S21, V1.S[0x2]
    SQRDMLSH S12, S15, S15
    SQRDMLAH H15, H16, H16
    SQRDMLSH S26, S18, S1
    SQRDMLSH H12, H31, V8.H[0x6]
    SQRDMLSH H18, H11, V7.H[0x5]
    SQRDMLSH H17, H24, V15.H[0x1]
    SQRDMLAH S25, S26, V18.S[0x3]
    SQRDMLAH H16, H12, V5.H[0x4]
    SQRDMLSH H26, H2, V1.H[0x2]
    SQRDMLAH H18, H16, H25
    SQRDMLSH H9, H14, V3.H[0x3]
    SQRDMLSH S30, S7, V26.S[0x3]
    SQRDMLSH S1, S17, V18.S[0x1]
    SQRDMLAH S27, S9, S1
    SQRDMLSH S29, S18, S29
    SQRDMLAH H14, H4, H26
    SQRDMLAH H8, H31, H12
    SQRDMLAH H17, H3, H22
    SQRDMLAH S11, S23, S17
    SQRDMLAH H23, H12, V10.H[0x4]
    SQRDMLAH H17, H22, H0
    SQRDMLSH S13, S18, S6
    SQRDMLAH H12, H13, V1.H[0x7]
    SQRDMLAH S2, S17, V2.S[0x3]
    SQRDMLAH S1, S30, V29.S[0x1]
    SQRDMLSH H13, H29, V2.H[0x7]
    SQRDMLAH S26, S8, V27.S[0x3]
    SQRDMLSH S5, S26, V30.S[0x2]
    SQRDMLSH H0, H11, V4.H[0x0]
    SQRDMLAH S11, S19, V23.S[0x1]
    SQRDMLAH S10, S18, V0.S[0x1]
    SQRDMLSH S29, S1, V22.S[0x0]
    SQRDMLSH H27, H25, V14.H[0x2]
    SQRDMLAH S3, S13, S27
    SQRDMLAH S26, S9, V2.S[0x2]
    SQRDMLAH H18, H26, V3.H[0x0]
    SQRDMLAH H14, H29, H5
    SQRDMLAH S22, S11, V18.S[0x0]
    SQRDMLAH S31, S7, S16
    SQRDMLAH H17, H12, H28
    SQRDMLSH H0, H16, H31
    SQRDMLAH S18, S0, S1
    SQRDMLAH S20, S3, V22.S[0x1]
    SQRDMLAH S7, S10, S17
    SQRDMLSH H2, H30, V11.H[0x7]
    SQRDMLSH S31, S20, S3
    SQRDMLSH S1, S8, S24
    SUBS  X18, X18, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_1
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MRS  X6, FPSR
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x800, LSL #16
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D0
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D1
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D8
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D30
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X6, D31
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X23
    FMOV  D1, X17
    FMOV  V1.D[1], X8
    FMOV  D2, X19
    FMOV  V2.D[1], X2
    FMOV  D3, X6
    FMOV  V3.D[1], X20
    FMOV  D4, X22
    FMOV  V4.D[1], X6
    FMOV  D5, X4
    FMOV  V5.D[1], X18
    FMOV  D6, X15
    FMOV  V6.D[1], X4
    FMOV  D7, X5
    FMOV  V7.D[1], X2
    FMOV  D8, X13
    FMOV  V8.D[1], X16
    FMOV  D9, X11
    FMOV  V9.D[1], X8
    FMOV  D10, X19
    FMOV  V10.D[1], X22
    FMOV  D11, X20
    FMOV  V11.D[1], X9
    FMOV  D12, X25
    FMOV  V12.D[1], X17
    FMOV  D13, X19
    FMOV  V13.D[1], X19
    FMOV  D14, X13
    FMOV  V14.D[1], X20
    FMOV  D15, X19
    FMOV  V15.D[1], X22
    FMOV  D16, X15
    FMOV  V16.D[1], X9
    FMOV  D17, X23
    FMOV  V17.D[1], X11
    FMOV  D18, X16
    FMOV  V18.D[1], X16
    FMOV  D19, X8
    FMOV  V19.D[1], X19
    FMOV  D20, X5
    FMOV  V20.D[1], X25
    FMOV  D21, X18
    FMOV  V21.D[1], X4
    FMOV  D22, X2
    FMOV  V22.D[1], X13
    FMOV  D23, X14
    FMOV  V23.D[1], X17
    FMOV  D24, X4
    FMOV  V24.D[1], X5
    FMOV  D25, X19
    FMOV  V25.D[1], X7
    FMOV  D26, X13
    FMOV  V26.D[1], X9
    FMOV  D27, X16
    FMOV  V27.D[1], X12
    FMOV  D28, X9
    FMOV  V28.D[1], X5
    FMOV  D29, X17
    FMOV  V29.D[1], X8
    FMOV  D30, X21
    FMOV  V30.D[1], X5
    FMOV  D31, X22
    FMOV  V31.D[1], X6
    MOVZ  X12, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_2:
    SQRDMLSH H22, H27, H17
    SQRDMLAH H12, H19, H28
    SQRDMLSH H17, H24, V12.H[0x4]
    SQRDMLAH H15, H2, H12
    SQRDMLSH H4, H22, H30
    SQRDMLSH H19, H29, H15
    SQRDMLSH H22, H4, V1.H[0x3]
    SQRDMLSH S18, S16, S19
    SQRDMLSH H18, H7, V13.H[0x0]
    SQRDMLAH S20, S11, S23
    SQRDMLSH H4, H22, V7.H[0x3]
    SQRDMLSH H22, H17, H31
    SQRDMLAH S8, S22, V4.S[0x2]
    SQRDMLAH H30, H18, H20
    SQRDMLAH H16, H10, H25
    SQRDMLSH S19, S13, S16
    SQRDMLAH H18, H11, V3.H[0x6]
    SQRDMLAH S23, S18, V29.S[0x0]
    SQRDMLAH S24, S30, S23
    SQRDMLAH H3, H24, V3.H[0x7]
    SQRDMLAH H27, H20, V3.H[0x1]
    SQRDMLSH S2, S8, V19.S[0x0]
    SQRDMLAH S4, S21, S29
    SQRDMLSH S17, S15, S21
    SQRDMLAH S22, S10, S16
    SQRDMLAH H8, H9, H25
    SQRDMLSH H1, H26, V2.H[0x5]
    SQRDMLSH S28, S16, V29.S[0x0]
    SQRDMLSH S25, S24, V27.S[0x1]
    SQRDMLAH S13, S28, V18.S[0x2]
    SQRDMLAH H23, H19, V8.H[0x1]
    SQRDMLAH S18, S7, V15.S[0x1]
    SQRDMLAH H12, H13, H23
    SQRDMLSH S2, S5, V3.S[0x3]
    SQRDMLSH S24, S17, S27
    SQRDMLSH H31, H25, H21
    SQRDMLSH H30, H4, H13
    SQRDMLAH S17, S28, S7
    SQRDMLAH H15, H22, H23
    SQRDMLAH H28, H15, H15
    SQRDMLAH S7, S17, S26
    SQRDMLSH S20, S24, S2
    SQRDMLAH H9, H1, H28
    SQRDMLSH H2, H18, V7.H[0x4]
    SQRDMLSH S19, S1, S20
    SQRDMLSH H24, H31, H29
    SQRDMLAH H29, H30, V6.H[0x0]
    SQRDMLAH S11, S2, V29.S[0x0]
    SQRDMLSH S28, S31, S12
    SQRDMLAH S29, S9, S21
    SQRDMLAH S22, S3, S28
    SQRDMLSH H5, H29, H24
    SQRDMLSH S2, S6, V19.S[0x1]
    SQRDMLAH H28, H17, H2
    SQRDMLAH H31, H30, V5.H[0x0]
    SQRDMLAH S18, S31, S23
    SQRDMLSH H26, H11, V10.H[0x4]
    SQRDMLAH S24, S28, V22.S[0x3]
    SQRDMLSH H4, H1, V10.H[0x3]
    SQRDMLSH S22, S26, V13.S[0x0]
    SQRDMLSH S10, S22, S22
    SQRDMLAH H6, H4, V3.H[0x3]
    SQRDMLSH S1, S18, V12.S[0x2]
    SQRDMLAH S4, S24, V25.S[0x3]
    SQRDMLSH H24, H6, V10.H[0x4]
    SQRDMLAH H20, H1, V6.H[0x4]
    SQRDMLAH S13, S24, S15
    SQRDMLSH H1, H15, V13.H[0x0]
    SQRDMLAH H19, H4, V0.H[0x7]
    SQRDMLSH S10, S20, V23.S[0x2]
    SQRDMLAH S10, S3, V25.S[0x3]
    SQRDMLAH S26, S19, S29
    SQRDMLAH H4, H25, H10
    SQRDMLAH S24, S26, V4.S[0x1]
    SQRDMLAH S13, S18, V0.S[0x3]
    SQRDMLAH H28, H2, V9.H[0x5]
    SQRDMLAH S22, S7, V14.S[0x1]
    SQRDMLAH H10, H8, H25
    SQRDMLSH H5, H13, V11.H[0x7]
    SQRDMLAH S6, S1, V7.S[0x0]
    SQRDMLSH H12, H0, V14.H[0x6]
    SQRDMLSH S1, S11, V26.S[0x3]
    SQRDMLSH S20, S19, S17
    SQRDMLAH H26, H23, V3.H[0x3]
    SQRDMLAH S29, S21, V6.S[0x2]
    SQRDMLSH H11, H24, H5
    SQRDMLSH S4, S28, S13
    SQRDMLAH H15, H29, H4
    SQRDMLAH H24, H12, V10.H[0x3]
    SQRDMLSH S30, S7, V24.S[0x3]
    SQRDMLSH H11, H5, V14.H[0x0]
    SQRDMLAH S0, S4, V15.S[0x0]
    SQRDMLAH S29, S20, V19.S[0x1]
    SQRDMLAH H7, H26, V0.H[0x7]
    SQRDMLSH S3, S1, V29.S[0x0]
    SQRDMLSH S5, S7, V22.S[0x0]
    SQRDMLSH S28, S24, V13.S[0x3]
    SQRDMLAH H17, H5, H12
    SQRDMLSH H13, H28, V1.H[0x1]
    SQRDMLSH H4, H11, H11
    SQRDMLSH S14, S25, S17
    SQRDMLSH H23, H22, V13.H[0x0]
    SQRDMLAH H24, H4, V15.H[0x7]
    SQRDMLAH S28, S19, V22.S[0x1]
    SQRDMLSH H2, H31, V12.H[0x7]
    SQRDMLAH H15, H23, V6.H[0x5]
    SQRDMLAH S19, S14, V2.S[0x2]
    SQRDMLAH S10, S28, S3
    SQRDMLSH S11, S7, V24.S[0x0]
    SQRDMLSH H26, H20, V10.H[0x6]
    SQRDMLSH S17, S26, V11.S[0x3]
    SQRDMLSH H22, H29, H19
    SQRDMLSH H11, H22, V15.H[0x3]
    SQRDMLSH S7, S11, S17
    SQRDMLSH H4, H15, V7.H[0x1]
    SQRDMLAH H5, H27, V15.H[0x1]
    SQRDMLSH H25, H11, H20
    SQRDMLSH H15, H16, H19
    SQRDMLSH H17, H25, V10.H[0x4]
    SQRDMLAH S16, S0, V2.S[0x1]
    SQRDMLAH H31, H7, H6
    SQRDMLSH S19, S14, S22
    SQRDMLSH S6, S11, V15.S[0x2]
    SQRDMLSH S7, S8, S1
    SQRDMLAH H8, H4, V5.H[0x4]
    SQRDMLSH H13, H13, V9.H[0x2]
    SQRDMLAH S1, S10, S5
    SQRDMLAH H0, H1, H6
    SQRDMLAH H14, H16, H16
    SQRDMLAH H17, H31, H31
    SQRDMLAH S27, S17, V8.S[0x1]
    SQRDMLSH H9, H19, H25
    SQRDMLSH S19, S29, V27.S[0x0]
    SQRDMLSH S3, S19, S7
    SQRDMLSH S24, S9, V9.S[0x0]
    SQRDMLSH H4, H5, H24
    SQRDMLSH H6, H0, H13
    SQRDMLSH H17, H4, V15.H[0x5]
    SQRDMLAH H22, H10, V3.H[0x7]
    SQRDMLSH H31, H6, H29
    SQRDMLSH H18, H17, V14.H[0x6]
    SQRDMLAH S8, S31, V16.S[0x0]
    SQRDMLAH S6, S22, V1.S[0x3]
    SQRDMLSH H5, H1, V8.H[0x6]
    SQRDMLAH S29, S6, S18
    SQRDMLSH H9, H27, H24
    SQRDMLSH S14, S27, S15
    SQRDMLAH S4, S14, S10
    SQRDMLSH S27, S16, S17
    SQRDMLAH S31, S10, S21
    SQRDMLSH S3, S30, V20.S[0x0]
    SQRDMLSH H15, H9, V13.H[0x1]
    SQRDMLAH S25, S25, S29
    SQRDMLSH H19, H6, H13
    SQRDMLAH H6, H0, H2
    SQRDMLSH S8, S19, S25
    SQRDMLAH S18, S5, S5
    SQRDMLAH S29, S5, S8
    SQRDMLSH S9, S29, V13.S[0x1]
    SQRDMLAH H22, H12, V15.H[0x4]
    SQRDMLAH S21, S31, V17.S[0x3]
    SQRDMLSH H7, H27, V9.H[0x3]
    SQRDMLAH S31, S3, V0.S[0x0]
    SQRDMLSH H18, H22, V4.H[0x7]
    SQRDMLSH H6, H18, V14.H[0x6]
    SQRDMLSH S12, S31, S21
    SQRDMLAH H24, H6, H27
    SQRDMLAH H4, H24, V12.H[0x1]
    SQRDMLSH H17, H21, V1.H[0x0]
    SQRDMLSH S5, S31, S23
    SQRDMLSH H9, H17, H22
    SQRDMLSH H10, H15, H30
    SQRDMLSH S27, S28, V30.S[0x0]
    SQRDMLAH H30, H13, V10.H[0x5]
    SQRDMLSH S2, S2, S10
    SQRDMLAH S15, S2, V2.S[0x1]
    SQRDMLAH S31, S5, S27
    SQRDMLSH S21, S21, S16
    SQRDMLAH S11, S15, S30
    SQRDMLAH S17, S22, V22.S[0x3]
    SQRDMLSH H8, H25, V14.H[0x0]
    SQRDMLAH S1, S8, S11
    SQRDMLSH S12, S16, V3.S[0x0]
    SQRDMLAH H14, H25, V9.H[0x1]
    SQRDMLAH S16, S2, S25
    SQRDMLSH H28, H21, V5.H[0x3]
    SQRDMLSH S28, S28, V16.S[0x2]
    SQRDMLAH S8, S1, S4
    SQRDMLSH H8, H28, H8
    SQRDMLSH H23, H7, H17
    SQRDMLAH H4, H31, H23
    SQRDMLAH S11, S8, V22.S[0x0]
    SQRDMLSH H5, H14, H12
    SQRDMLSH S23, S16, S4
    SQRDMLAH H18, H23, V11.H[0x2]
    SQRDMLAH S15, S22, S13
    SQRDMLSH S21, S14, V17.S[0x0]
    SQRDMLSH H7, H2, V6.H[0x3]
    SQRDMLSH H11, H27, H30
    SQRDMLAH H23, H30, V3.H[0x3]
    SUBS  X12, X12, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_2
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X15, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    MRS  X7, FPSR
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x800, LSL #16
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D0
    MOVZ  X15, #0x1, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D1
    MOVZ  X15, #0x17, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D2
    MOVZ  X15, #0xffeb, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D3
    MOVZ  X15, #0xffd5, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D4
    MOVZ  X15, #0x3, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D5
    MOVZ  X15, #0xfffb, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D6
    MOVZ  X15, #0xffff, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D7
    MOVZ  X15, #0xfffb, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D8
    MOVZ  X15, #0xffff, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D9
    MOVZ  X15, #0xffff, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D10
    MOVZ  X15, #0x11, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D11
    MOVZ  X15, #0x1, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D12
    MOVZ  X15, #0xfffd, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D13
    MOVZ  X15, #0x13, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D14
    MOVZ  X15, #0xffeb, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D15
    MOVZ  X15, #0xffff, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D16
    MOVZ  X15, #0x1, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D17
    MOVZ  X15, #0x11, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D18
    MOVZ  X15, #0x13, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D19
    MOVZ  X15, #0xfffd, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D20
    MOVZ  X15, #0xffe9, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D21
    MOVZ  X15, #0xfffd, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D22
    MOVZ  X15, #0x13, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D23
    MOVZ  X15, #0xffff, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D24
    MOVZ  X15, #0xfff9, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D25
    MOVZ  X15, #0x1, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D26
    MOVZ  X15, #0x1, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D27
    MOVZ  X15, #0xffe9, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D28
    MOVZ  X15, #0xfffd, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D29
    MOVZ  X15, #0x13, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D30
    MOVZ  X15, #0xffff, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X7, D31
    MOVZ  X15, #0x13, LSL #0
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X13
    FMOV  D1, X25
    FMOV  V1.D[1], X22
    FMOV  D2, X4
    FMOV  V2.D[1], X23
    FMOV  D3, X21
    FMOV  V3.D[1], X22
    FMOV  D4, X12
    FMOV  V4.D[1], X25
    FMOV  D5, X18
    FMOV  V5.D[1], X16
    FMOV  D6, X11
    FMOV  V6.D[1], X3
    FMOV  D7, X16
    FMOV  V7.D[1], X8
    FMOV  D8, X6
    FMOV  V8.D[1], X19
    FMOV  D9, X16
    FMOV  V9.D[1], X3
    FMOV  D10, X12
    FMOV  V10.D[1], X16
    FMOV  D11, X10
    FMOV  V11.D[1], X4
    FMOV  D12, X8
    FMOV  V12.D[1], X10
    FMOV  D13, X21
    FMOV  V13.D[1], X11
    FMOV  D14, X22
    FMOV  V14.D[1], X17
    FMOV  D15, X2
    FMOV  V15.D[1], X20
    FMOV  D16, X17
    FMOV  V16.D[1], X4
    FMOV  D17, X6
    FMOV  V17.D[1], X15
    FMOV  D18, X10
    FMOV  V18.D[1], X10
    FMOV  D19, X14
    FMOV  V19.D[1], X15
    FMOV  D20, X17
    FMOV  V20.D[1], X8
    FMOV  D21, X3
    FMOV  V21.D[1], X4
    FMOV  D22, X16
    FMOV  V22.D[1], X4
    FMOV  D23, X6
    FMOV  V23.D[1], X8
    FMOV  D24, X10
    FMOV  V24.D[1], X7
    FMOV  D25, X13
    FMOV  V25.D[1], X20
    FMOV  D26, X20
    FMOV  V26.D[1], X9
    FMOV  D27, X19
    FMOV  V27.D[1], X20
    FMOV  D28, X3
    FMOV  V28.D[1], X10
    FMOV  D29, X4
    FMOV  V29.D[1], X25
    FMOV  D30, X11
    FMOV  V30.D[1], X18
    FMOV  D31, X7
    FMOV  V31.D[1], X13
    MOVZ  X8, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_3:
    SQRDMLSH H20, H28, V14.H[0x5]
    SQRDMLSH S23, S19, V27.S[0x1]
    SQRDMLAH S14, S29, V20.S[0x2]
    SQRDMLSH H30, H30, V1.H[0x7]
    SQRDMLAH S15, S24, V30.S[0x1]
    SQRDMLAH H24, H31, H29
    SQRDMLSH S9, S28, S25
    SQRDMLAH S24, S24, V8.S[0x3]
    SQRDMLAH S9, S22, V24.S[0x3]
    SQRDMLAH S18, S25, S17
    SQRDMLAH H30, H23, V6.H[0x3]
    SQRDMLAH S13, S6, S10
    SQRDMLSH S19, S26, S9
    SQRDMLSH S24, S2, S19
    SQRDMLSH H28, H13, V13.H[0x4]
    SQRDMLAH H13, H11, H27
    SQRDMLAH S31, S6, S24
    SQRDMLSH H8, H12, V14.H[0x7]
    SQRDMLSH S5, S16, V28.S[0x1]
    SQRDMLSH S29, S0, V21.S[0x3]
    SQRDMLAH S9, S8, S6
    SQRDMLSH H2, H4, V14.H[0x6]
    SQRDMLAH S11, S13, V9.S[0x0]
    SQRDMLSH H22, H5, H5
    SQRDMLAH S6, S11, S15
    SQRDMLAH H14, H5, V8.H[0x6]
    SQRDMLAH S17, S22, V19.S[0x3]
    SQRDMLAH S1, S29, S18
    SQRDMLAH S27, S14, S2
    SQRDMLSH H4, H6, V6.H[0x6]
    SQRDMLSH S8, S12, V17.S[0x3]
    SQRDMLAH H12, H30, H31
    SQRDMLAH S29, S19, S8
    SQRDMLAH H17, H27, V14.H[0x0]
    SQRDMLAH H24, H4, V4.H[0x2]
    SQRDMLAH H6, H16, H1
    SQRDMLAH H28, H6, V10.H[0x6]
    SQRDMLSH H9, H24, V12.H[0x3]
    SQRDMLAH S31, S29, V9.S[0x0]
    SQRDMLSH S4, S8, V12.S[0x3]
    SQRDMLSH S1, S5, S19
    SQRDMLSH S0, S23, V17.S[0x3]
    SQRDMLSH H8, H9, V1.H[0x4]
    SQRDMLSH S9, S6, V19.S[0x1]
    SQRDMLAH S22, S8, S1
    SQRDMLAH S1, S4, S31
    SQRDMLAH H29, H6, H9
    SQRDMLAH H10, H1, V0.H[0x0]
    SQRDMLSH S27, S28, V28.S[0x0]
    SQRDMLSH S28, S22, S27
    SQRDMLAH H1, H10, V0.H[0x1]
    SQRDMLAH H18, H1, V15.H[0x6]
    SQRDMLSH H31, H24, V4.H[0x5]
    SQRDMLAH H1, H18, H31
    SQRDMLAH H6, H1, H1
    SQRDMLSH H12, H29, V4.H[0x5]
    SQRDMLAH S29, S6, V14.S[0x3]
    SQRDMLAH H15, H28, V6.H[0x0]
    SQRDMLSH S27, S29, V12.S[0x1]
    SQRDMLSH H18, H0, V11.H[0x0]
    SQRDMLSH H29, H10, V15.H[0x2]
    SQRDMLSH H18, H1, H15
    SQRDMLAH S0, S16, V27.S[0x1]
    SQRDMLAH H15, H6, V12.H[0x4]
    SQRDMLAH S28, S10, S16
    SQRDMLAH H9, H22, V15.H[0x6]
    SQRDMLSH S21, S31, S24
    SQRDMLAH H27, H0, V8.H[0x5]
    SQRDMLSH S11, S11, V31.S[0x0]
    SQRDMLAH S15, S28, V15.S[0x1]
    SQRDMLAH H12, H26, V2.H[0x7]
    SQRDMLSH S19, S13, V3.S[0x1]
    SQRDMLSH S14, S19, S22
    SQRDMLSH H3, H10, V11.H[0x4]
    SQRDMLAH S28, S27, V3.S[0x2]
    SQRDMLSH H24, H3, V14.H[0x7]
    SQRDMLAH H14, H29, V15.H[0x1]
    SQRDMLAH H14, H9, H24
    SQRDMLSH S24, S28, V14.S[0x1]
    SQRDMLAH S3, S18, V10.S[0x2]
    SQRDMLAH H19, H24, V3.H[0x6]
    SQRDMLAH H0, H19, V12.H[0x6]
    SQRDMLSH S27, S10, V22.S[0x1]
    SQRDMLAH S2, S12, V15.S[0x2]
    SQRDMLSH S3, S25, S21
    SQRDMLAH S12, S20, V28.S[0x1]
    SQRDMLSH S26, S9, S20
    SQRDMLAH S31, S16, V22.S[0x0]
    SQRDMLAH S16, S9, S10
    SQRDMLSH S14, S25, V22.S[0x2]
    SQRDMLSH H20, H31, V7.H[0x0]
    SQRDMLSH H15, H0, V14.H[0x3]
    SQRDMLSH S11, S20, V27.S[0x2]
    SQRDMLAH S25, S2, V24.S[0x0]
    SQRDMLSH S2, S26, V25.S[0x2]
    SQRDMLSH S26, S16, S11
    SQRDMLSH H20, H2, V5.H[0x7]
    SQRDMLSH H25, H20, H19
    SQRDMLAH S14, S3, V25.S[0x1]
    SQRDMLSH H2, H12, V11.H[0x3]
    SQRDMLAH H12, H14, H7
    SQRDMLSH H29, H12, V10.H[0x4]
    SQRDMLAH H7, H30, H2
    SQRDMLAH S21, S29, V22.S[0x1]
    SQRDMLSH S31, S7, S23
    SQRDMLAH S18, S21, S15
    SQRDMLAH S15, S3, V19.S[0x2]
    SQRDMLAH H27, H27, H26
    SQRDMLAH S14, S18, S7
    SQRDMLSH S3, S15, V14.S[0x3]
    SQRDMLAH S9, S3, S9
    SQRDMLSH H20, H9, V14.H[0x7]
    SQRDMLAH H15, H6, V13.H[0x3]
    SQRDMLAH H26, H31, V15.H[0x4]
    SQRDMLSH S12, S1, S29
    SQRDMLAH S3, S16, S25
    SQRDMLSH S7, S20, S7
    SQRDMLSH H24, H7, V14.H[0x2]
    SQRDMLSH H1, H2, V14.H[0x6]
    SQRDMLSH S21, S26, V24.S[0x2]
    SQRDMLAH H29, H3, V3.H[0x7]
    SQRDMLSH H25, H1, V1.H[0x5]
    SQRDMLSH H18, H4, H0
    SQRDMLAH H23, H25, V12.H[0x2]
    SQRDMLAH H5, H23, V1.H[0x3]
    SQRDMLAH H30, H27, H18
    SQRDMLAH H31, H30, V5.H[0x1]
    SQRDMLSH H13, H6, H21
    SQRDMLSH H26, H29, V7.H[0x1]
    SQRDMLAH S1, S8, V2.S[0x0]
    SQRDMLAH H23, H7, H13
    SQRDMLSH S29, S28, S2
    SQRDMLSH S6, S26, V26.S[0x2]
    SQRDMLSH H4, H20, V6.H[0x7]
    SQRDMLSH S16, S4, S29
    SQRDMLSH H16, H16, V7.H[0x5]
    SQRDMLSH H24, H25, V2.H[0x3]
    SQRDMLAH S14, S24, S10
    SQRDMLSH H24, H18, H31
    SQRDMLAH S6, S16, V16.S[0x3]
    SQRDMLAH H15, H29, V1.H[0x7]
    SQRDMLSH S5, S6, S15
    SQRDMLSH H26, H30, V5.H[0x4]
    SQRDMLSH S1, S15, S14
    SQRDMLSH S10, S29, S24
    SQRDMLAH S24, S23, V1.S[0x2]
    SQRDMLSH S8, S18, S10
    SQRDMLSH S15, S26, S20
    SQRDMLAH H23, H15, V3.H[0x2]
    SQRDMLAH H10, H28, H23
    SQRDMLSH H13, H8, V8.H[0x4]
    SQRDMLAH H20, H10, H13
    SQRDMLAH S26, S11, S29
    SQRDMLSH H5, H0, H17
    SQRDMLAH S6, S28, V5.S[0x3]
    SQRDMLAH H3, H25, H15
    SQRDMLAH S16, S11, V13.S[0x2]
    SQRDMLAH S4, S24, V19.S[0x2]
    SQRDMLSH H5, H6, H16
    SQRDMLAH S24, S25, V8.S[0x1]
    SQRDMLAH S23, S14, V15.S[0x0]
    SQRDMLAH S4, S10, V8.S[0x3]
    SQRDMLSH H13, H5, V4.H[0x3]
    SQRDMLAH H10, H7, H3
    SQRDMLSH S1, S31, S10
    SQRDMLSH S2, S18, V15.S[0x0]
    SQRDMLAH H6, H22, H28
    SQRDMLSH S5, S4, V1.S[0x2]
    SQRDMLSH S17, S3, S22
    SQRDMLSH S29, S24, S19
    SQRDMLSH H8, H13, V6.H[0x1]
    SQRDMLSH S18, S23, V20.S[0x0]
    SQRDMLAH S31, S2, V29.S[0x1]
    SQRDMLAH S20, S24, V17.S[0x3]
    SQRDMLAH H2, H8, H8
    SQRDMLAH S7, S31, V24.S[0x2]
    SQRDMLAH S10, S18, V7.S[0x3]
    SQRDMLSH H16, H5, V6.H[0x4]
    SQRDMLAH H25, H16, V7.H[0x0]
    SQRDMLAH H19, H10, H25
    SQRDMLAH S18, S25, V19.S[0x0]
    SQRDMLSH H9, H16, V2.H[0x2]
    SQRDMLSH H6, H28, V9.H[0x3]
    SQRDMLSH S11, S6, V11.S[0x2]
    SQRDMLSH H23, H20, H1
    SQRDMLSH H22, H17, V11.H[0x6]
    SQRDMLSH H19, H19, V1.H[0x7]
    SQRDMLSH H31, H28, V6.H[0x0]
    SQRDMLSH H1, H31, H19
    SQRDMLSH S7, S22, S22
    SQRDMLAH S10, S20, S1
    SQRDMLSH H17, H12, H7
    SQRDMLSH S12, S19, S19
    SQRDMLSH H16, H18, V10.H[0x5]
    SQRDMLSH S31, S17, S17
    SQRDMLAH H31, H3, H14
    SQRDMLSH H3, H7, H16
    SQRDMLSH H7, H23, V3.H[0x1]
    SQRDMLSH S17, S12, S31
    SQRDMLAH H14, H15, H28
    SUBS  X8, X8, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_3
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X4, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MRS  X25, FPSR
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x800, LSL #16
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D0
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D1
    MOVZ  X4, #0x7fff, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D2
    MOVZ  X4, #0x7fff, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D3
    MOVZ  X4, #0x7fff, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D4
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D5
    MOVZ  X4, #0x8000, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D6
    MOVZ  X4, #0x7fff, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D7
    MOVZ  X4, #0x8000, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D8
    MOVZ  X4, #0x5a54, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D9
    MOVZ  X4, #0x25c3, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D10
    MOVZ  X4, #0x8000, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D11
    MOVZ  X4, #0xcb07, LSL #0
    MOVK  X4, #0x5a57, LSL #16
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D12
    MOVZ  X4, #0x8000, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D13
    MOVZ  X4, #0x8000, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D14
    MOVZ  X4, #0xb832, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D15
    MOVZ  X4, #0x4fe0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D16
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D17
    MOVZ  X4, #0x898b, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D18
    MOVZ  X4, #0x8000, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D19
    MOVZ  X4, #0x8000, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D20
    MOVZ  X4, #0x7fff, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D21
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D22
    MOVZ  X4, #0x8000, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D23
    MOVZ  X4, #0x2, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D24
    MOVZ  X4, #0x7fff, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D25
    MOVZ  X4, #0x25a5, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D26
    MOVZ  X4, #0x3da6, LSL #0
    MOVK  X4, #0x1, LSL #16
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D27
    MOVZ  X4, #0x12, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D28
    MOVZ  X4, #0x8b18, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D29
    MOVZ  X4, #0x7ffe, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D30
    MOVZ  X4, #0x8000, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X25, D31
    MOVZ  X4, #0x7fff, LSL #0
    SUB  X22, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X9
    FMOV  D1, X11
    FMOV  V1.D[1], X25
    FMOV  D2, X13
    FMOV  V2.D[1], X19
    FMOV  D3, X19
    FMOV  V3.D[1], X17
    FMOV  D4, X22
    FMOV  V4.D[1], X23
    FMOV  D5, X17
    FMOV  V5.D[1], X6
    FMOV  D6, X25
    FMOV  V6.D[1], X17
    FMOV  D7, X23
    FMOV  V7.D[1], X11
    FMOV  D8, X3
    FMOV  V8.D[1], X2
    FMOV  D9, X6
    FMOV  V9.D[1], X25
    FMOV  D10, X3
    FMOV  V10.D[1], X22
    FMOV  D11, X23
    FMOV  V11.D[1], X6
    FMOV  D12, X16
    FMOV  V12.D[1], X17
    FMOV  D13, X21
    FMOV  V13.D[1], X20
    FMOV  D14, X13
    FMOV  V14.D[1], X18
    FMOV  D15, X25
    FMOV  V15.D[1], X14
    FMOV  D16, X13
    FMOV  V16.D[1], X12
    FMOV  D17, X2
    FMOV  V17.D[1], X9
    FMOV  D18, X23
    FMOV  V18.D[1], X13
    FMOV  D19, X18
    FMOV  V19.D[1], X21
    FMOV  D20, X16
    FMOV  V20.D[1], X23
    FMOV  D21, X5
    FMOV  V21.D[1], X9
    FMOV  D22, X13
    FMOV  V22.D[1], X4
    FMOV  D23, X12
    FMOV  V23.D[1], X3
    FMOV  D24, X13
    FMOV  V24.D[1], X16
    FMOV  D25, X21
    FMOV  V25.D[1], X10
    FMOV  D26, X6
    FMOV  V26.D[1], X13
    FMOV  D27, X4
    FMOV  V27.D[1], X25
    FMOV  D28, X16
    FMOV  V28.D[1], X12
    FMOV  D29, X25
    FMOV  V29.D[1], X25
    FMOV  D30, X5
    FMOV  V30.D[1], X19
    FMOV  D31, X23
    FMOV  V31.D[1], X4
    MOVZ  X19, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_4:
    SQRDMLSH H26, H17, V2.H[0x1]
    SQRDMLAH S26, S26, V29.S[0x1]
    SQRDMLSH S0, S24, S31
    SQRDMLSH S29, S26, S3
    SQRDMLSH S24, S0, V25.S[0x2]
    SQRDMLSH S19, S22, V4.S[0x0]
    SQRDMLAH H18, H24, H28
    SQRDMLAH H7, H28, H21
    SQRDMLAH H9, H17, V5.H[0x7]
    SQRDMLSH S3, S5, S27
    SQRDMLSH H17, H8, V8.H[0x7]
    SQRDMLSH S7, S19, V3.S[0x0]
    SQRDMLSH S9, S9, S7
    SQRDMLSH H31, H9, V9.H[0x5]
    SQRDMLAH H29, H5, V7.H[0x1]
    SQRDMLSH H26, H31, H17
    SQRDMLSH S17, S26, S8
    SQRDMLSH H19, H17, H29
    SQRDMLSH S26, S7, V19.S[0x3]
    SQRDMLSH S0, S26, S30
    SQRDMLAH H27, H7, H4
    SQRDMLSH S16, S28, V17.S[0x0]
    SQRDMLSH S19, S26, S8
    SQRDMLSH H4, H8, V4.H[0x3]
    SQRDMLSH S24, S23, S2
    SQRDMLAH H13, H28, V9.H[0x7]
    SQRDMLAH H30, H0, H30
    SQRDMLAH H23, H12, H7
    SQRDMLAH H29, H23, H7
    SQRDMLAH H31, H16, V7.H[0x0]
    SQRDMLAH H28, H2, H31
    SQRDMLAH S4, S29, V24.S[0x3]
    SQRDMLAH H0, H13, V13.H[0x5]
    SQRDMLAH S25, S15, V31.S[0x3]
    SQRDMLAH H16, H0, H18
    SQRDMLSH S26, S30, S27
    SQRDMLAH H23, H16, V14.H[0x3]
    SQRDMLAH S14, S11, S4
    SQRDMLAH S8, S26, S28
    SQRDMLSH H26, H23, V6.H[0x0]
    SQRDMLSH H7, H11, H1
    SQRDMLSH H31, H14, V7.H[0x1]
    SQRDMLAH S16, S18, S3
    SQRDMLAH S20, S25, V8.S[0x2]
    SQRDMLAH H18, H7, V8.H[0x3]
    SQRDMLSH S8, S16, S14
    SQRDMLSH H17, H26, H18
    SQRDMLAH H1, H31, H3
    SQRDMLSH S21, S1, S1
    SQRDMLAH H28, H20, H19
    SQRDMLSH S2, S17, S16
    SQRDMLSH S0, S21, S12
    SQRDMLSH H21, H2, V6.H[0x4]
    SQRDMLAH S12, S29, S28
    SQRDMLAH S14, S5, S8
    SQRDMLSH S2, S0, S12
    SQRDMLSH H1, H23, H2
    SQRDMLAH S8, S9, V14.S[0x2]
    SQRDMLAH H3, H1, H14
    SQRDMLAH S28, S13, V8.S[0x0]
    SQRDMLAH H19, H11, H28
    SQRDMLAH S6, S5, V21.S[0x2]
    SQRDMLSH H11, H10, H6
    SQRDMLSH S10, S31, S11
    SQRDMLAH H7, H10, H10
    SQRDMLSH S29, S19, V9.S[0x2]
    SQRDMLSH H17, H7, V14.H[0x4]
    SQRDMLSH H6, H3, V3.H[0x5]
    SQRDMLSH S18, S6, S29
    SQRDMLSH S23, S19, V20.S[0x3]
    SQRDMLAH S29, S29, V7.S[0x1]
    SQRDMLAH S31, S17, V21.S[0x2]
    SQRDMLAH H12, H17, V2.H[0x7]
    SQRDMLAH S13, S15, S6
    SQRDMLSH S6, S15, V30.S[0x2]
    SQRDMLSH S11, S22, S28
    SQRDMLAH S17, S3, S3
    SQRDMLAH H28, H9, H11
    SQRDMLSH H2, H13, V6.H[0x1]
    SQRDMLSH H7, H17, V4.H[0x2]
    SQRDMLAH S17, S13, V29.S[0x2]
    SQRDMLAH H12, H7, V12.H[0x4]
    SQRDMLSH H1, H31, V2.H[0x3]
    SQRDMLSH H30, H5, V4.H[0x1]
    SQRDMLSH H4, H23, H23
    SQRDMLSH H14, H16, V11.H[0x5]
    SQRDMLAH S3, S14, V30.S[0x0]
    SQRDMLAH H16, H28, H19
    SQRDMLSH S27, S12, V18.S[0x3]
    SQRDMLSH S11, S24, V3.S[0x3]
    SQRDMLAH S28, S1, V16.S[0x0]
    SQRDMLSH H19, H25, H25
    SQRDMLAH H16, H28, H4
    SQRDMLSH H7, H19, V1.H[0x1]
    SQRDMLSH H12, H11, H11
    SQRDMLAH S5, S25, S21
    SQRDMLSH H8, H17, V13.H[0x6]
    SQRDMLAH H6, H16, H0
    SQRDMLAH H1, H20, H25
    SQRDMLSH H3, H8, V7.H[0x2]
    SQRDMLSH H9, H12, H3
    SQRDMLAH H7, H24, H26
    SQRDMLSH H0, H29, V7.H[0x7]
    SQRDMLAH S19, S24, V7.S[0x1]
    SQRDMLAH H11, H0, H6
    SQRDMLAH S28, S15, S9
    SQRDMLAH H16, H27, V2.H[0x0]
    SQRDMLAH S25, S28, S11
    SQRDMLSH S11, S16, S17
    SQRDMLSH S0, S23, S19
    SQRDMLSH H6, H5, H21
    SQRDMLSH H9, H7, V1.H[0x6]
    SQRDMLAH S29, S23, S27
    SQRDMLSH H17, H26, V14.H[0x3]
    SQRDMLSH H28, H29, H5
    SQRDMLSH H11, H12, V8.H[0x4]
    SQRDMLSH S18, S11, V26.S[0x1]
    SQRDMLAH H16, H17, V6.H[0x3]
    SQRDMLAH H23, H10, V3.H[0x3]
    SQRDMLSH H13, H25, V0.H[0x5]
    SQRDMLSH S20, S16, V21.S[0x3]
    SQRDMLSH H25, H9, H9
    SQRDMLSH S5, S18, S13
    SQRDMLSH S7, S5, V25.S[0x1]
    SQRDMLAH S19, S28, S30
    SQRDMLAH S24, S23, S28
    SQRDMLSH S30, S28, V22.S[0x0]
    SQRDMLSH H29, H30, V7.H[0x3]
    SQRDMLAH S3, S9, S29
    SQRDMLAH S15, S24, S26
    SQRDMLAH H7, H29, V15.H[0x3]
    SQRDMLSH H29, H20, H25
    SQRDMLSH H14, H29, H19
    SQRDMLSH H9, H3, H3
    SQRDMLSH S23, S7, V9.S[0x0]
    SQRDMLAH H16, H16, V11.H[0x0]
    SQRDMLAH S10, S7, S22
    SQRDMLSH S21, S16, S27
    SQRDMLAH H19, H15, H17
    SQRDMLAH H12, H2, H4
    SQRDMLSH H17, H12, H5
    SQRDMLAH S18, S10, V1.S[0x2]
    SQRDMLSH S28, S4, V24.S[0x2]
    SQRDMLSH S2, S22, V9.S[0x3]
    SQRDMLAH H30, H12, V3.H[0x4]
    SQRDMLAH S11, S2, V17.S[0x1]
    SQRDMLAH H20, H14, V14.H[0x1]
    SQRDMLAH S0, S0, V28.S[0x1]
    SQRDMLSH S28, S20, V13.S[0x1]
    SQRDMLAH S8, S14, V23.S[0x2]
    SQRDMLAH S3, S19, S18
    SQRDMLSH S9, S0, V20.S[0x1]
    SQRDMLSH H17, H21, H28
    SQRDMLSH H19, H8, H17
    SQRDMLSH H23, H9, H9
    SQRDMLSH S28, S19, S15
    SQRDMLSH S24, S30, S16
    SQRDMLSH H15, H3, H4
    SQRDMLAH S13, S23, S15
    SQRDMLAH H13, H13, H24
    SQRDMLSH S4, S5, S11
    SQRDMLSH S30, S18, S13
    SQRDMLAH S14, S30, V3.S[0x2]
    SQRDMLAH S17, S28, S28
    SQRDMLAH H0, H6, V4.H[0x1]
    SQRDMLSH H7, H14, H5
    SQRDMLAH S21, S25, S17
    SQRDMLAH S15, S7, S21
    SQRDMLSH H11, H16, H16
    SQRDMLSH S3, S22, S0
    SQRDMLSH H30, H11, V2.H[0x1]
    SQRDMLAH H19, H22, H31
    SQRDMLSH S14, S25, S27
    SQRDMLSH H22, H22, H10
    SQRDMLAH S2, S10, V11.S[0x2]
    SQRDMLAH H21, H14, H21
    SQRDMLSH S31, S22, V25.S[0x3]
    SQRDMLAH S25, S10, V30.S[0x2]
    SQRDMLSH S27, S3, S1
    SQRDMLAH S1, S27, V30.S[0x3]
    SQRDMLSH H22, H14, V12.H[0x3]
    SQRDMLAH S3, S12, V13.S[0x3]
    SQRDMLSH H24, H23, H21
    SQRDMLSH H17, H22, H25
    SQRDMLSH H11, H2, V1.H[0x2]
    SQRDMLSH H7, H17, V15.H[0x3]
    SQRDMLSH H13, H11, H19
    SQRDMLSH H10, H31, V3.H[0x1]
    SQRDMLSH H6, H13, V14.H[0x7]
    SQRDMLAH S15, S18, S6
    SQRDMLAH H11, H11, H10
    SQRDMLAH S6, S24, S15
    SQRDMLAH S27, S11, S6
    SQRDMLAH S2, S20, V28.S[0x2]
    SQRDMLAH S23, S8, V21.S[0x3]
    SQRDMLSH S1, S11, S16
    SQRDMLAH S12, S3, S6
    SQRDMLSH S8, S14, V17.S[0x0]
    SQRDMLAH H3, H0, H18
    SQRDMLSH S26, S25, S2
    SUBS  X19, X19, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_4
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X3, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MRS  X12, FPSR
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x800, LSL #16
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D0
    MOVZ  X3, #0x408f, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D1
    MOVZ  X3, #0x7fff, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D2
    MOVZ  X3, #0xfffb, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D3
    MOVZ  X3, #0xc31d, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D4
    MOVZ  X3, #0xb1ac, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D5
    MOVZ  X3, #0x4b4e, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D6
    MOVZ  X3, #0xe5c2, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D7
    MOVZ  X3, #0x7fff, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D8
    MOVZ  X3, #0x8b0d, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D9
    MOVZ  X3, #0x8000, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D10
    MOVZ  X3, #0x3af, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D11
    MOVZ  X3, #0x3b0d, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D12
    MOVZ  X3, #0x8006, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D13
    MOVZ  X3, #0xd4c4, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D14
    MOVZ  X3, #0x7fff, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D15
    MOVZ  X3, #0x8003, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D16
    MOVZ  X3, #0xf87, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D17
    MOVZ  X3, #0x8554, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D18
    MOVZ  X3, #0xe014, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D19
    MOVZ  X3, #0xd03, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D20
    MOVZ  X3, #0xa5a5, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D21
    MOVZ  X3, #0xf1be, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D22
    MOVZ  X3, #0xbc8a, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D23
    MOVZ  X3, #0x8000, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D24
    MOVZ  X3, #0xba57, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D25
    MOVZ  X3, #0x8000, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D26
    MOVZ  X3, #0x7fff, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D27
    MOVZ  X3, #0xb226, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D28
    MOVZ  X3, #0xd2ec, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D29
    MOVZ  X3, #0x8000, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D30
    MOVZ  X3, #0x7ffd, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X12, D31
    MOVZ  X3, #0x8da2, LSL #0
    SUB  X22, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x88ad, LSL #0
    MOVK  X2, #0xea6c, LSL #16
    MOVK  X2, #0xc304, LSL #32
    MOVK  X2, #0x4161, LSL #48
    MOVZ  X3, #0x5972, LSL #0
    MOVK  X3, #0xee66, LSL #16
    MOVK  X3, #0xecc, LSL #32
    MOVK  X3, #0x4aae, LSL #48
    MOVZ  X4, #0x53f6, LSL #0
    MOVK  X4, #0x6ebc, LSL #16
    MOVK  X4, #0xc23e, LSL #32
    MOVK  X4, #0xf85e, LSL #48
    MOVZ  X5, #0x3db1, LSL #0
    MOVK  X5, #0xb219, LSL #16
    MOVK  X5, #0x1fac, LSL #32
    MOVK  X5, #0x47a2, LSL #48
    MOVZ  X6, #0x2542, LSL #0
    MOVK  X6, #0x6861, LSL #16
    MOVK  X6, #0x3cef, LSL #32
    MOVK  X6, #0xf538, LSL #48
    MOVZ  X7, #0x85f2, LSL #0
    MOVK  X7, #0x52bb, LSL #16
    MOVK  X7, #0xdcf8, LSL #32
    MOVK  X7, #0xafde, LSL #48
    MOVZ  X8, #0xd2dc, LSL #0
    MOVK  X8, #0x359f, LSL #16
    MOVK  X8, #0x71ac, LSL #32
    MOVK  X8, #0x903b, LSL #48
    MOVZ  X9, #0xa67c, LSL #0
    MOVK  X9, #0x57ee, LSL #16
    MOVK  X9, #0xe38, LSL #32
    MOVK  X9, #0x635a, LSL #48
    MOVZ  X10, #0x4de4, LSL #0
    MOVK  X10, #0xb179, LSL #16
    MOVK  X10, #0x1cff, LSL #32
    MOVK  X10, #0x2ea2, LSL #48
    MOVZ  X11, #0x9247, LSL #0
    MOVK  X11, #0xcc13, LSL #16
    MOVK  X11, #0x8a71, LSL #32
    MOVK  X11, #0xa36d, LSL #48
    MOVZ  X12, #0xe706, LSL #0
    MOVK  X12, #0x12bf, LSL #16
    MOVK  X12, #0x8ac6, LSL #32
    MOVK  X12, #0x829d, LSL #48
    MOVZ  X13, #0xebdf, LSL #0
    MOVK  X13, #0xd820, LSL #16
    MOVK  X13, #0xa760, LSL #32
    MOVK  X13, #0xf930, LSL #48
    MOVZ  X14, #0xea1b, LSL #0
    MOVK  X14, #0x1297, LSL #16
    MOVK  X14, #0x54c0, LSL #32
    MOVK  X14, #0x3990, LSL #48
    MOVZ  X15, #0x7527, LSL #0
    MOVK  X15, #0x9c34, LSL #16
    MOVK  X15, #0xc34c, LSL #32
    MOVK  X15, #0x5913, LSL #48
    MOVZ  X16, #0xa2d2, LSL #0
    MOVK  X16, #0x5ae1, LSL #16
    MOVK  X16, #0x21, LSL #32
    MOVK  X16, #0x9199, LSL #48
    MOVZ  X17, #0x2848, LSL #0
    MOVK  X17, #0x696c, LSL #16
    MOVK  X17, #0x9558, LSL #32
    MOVK  X17, #0xf6c5, LSL #48
    MOVZ  X18, #0x2758, LSL #0
    MOVK  X18, #0x45e6, LSL #16
    MOVK  X18, #0xecd3, LSL #32
    MOVK  X18, #0xd387, LSL #48
    MOVZ  X19, #0xa477, LSL #0
    MOVK  X19, #0xf211, LSL #16
    MOVK  X19, #0x6660, LSL #32
    MOVK  X19, #0x1bb8, LSL #48
    MOVZ  X20, #0x82ae, LSL #0
    MOVK  X20, #0x7556, LSL #16
    MOVK  X20, #0x112c, LSL #32
    MOVK  X20, #0x5698, LSL #48
    MOVZ  X21, #0xbf2b, LSL #0
    MOVK  X21, #0x6c2e, LSL #16
    MOVK  X21, #0x1bef, LSL #32
    MOVK  X21, #0xc427, LSL #48
    MOVZ  X22, #0xd693, LSL #0
    MOVK  X22, #0x620a, LSL #16
    MOVK  X22, #0x2463, LSL #32
    MOVK  X22, #0xd50d, LSL #48
    MOVZ  X23, #0x6221, LSL #0
    MOVK  X23, #0x8f94, LSL #16
    MOVK  X23, #0x7380, LSL #32
    MOVK  X23, #0x5d06, LSL #48
    MOVZ  X25, #0x6e28, LSL #0
    MOVK  X25, #0xdb64, LSL #16
    MOVK  X25, #0xa9f9, LSL #32
    MOVK  X25, #0x1d6a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X22
    FMOV  D1, X6
    FMOV  V1.D[1], X9
    FMOV  D2, X22
    FMOV  V2.D[1], X14
    FMOV  D3, X25
    FMOV  V3.D[1], X21
    FMOV  D4, X19
    FMOV  V4.D[1], X25
    FMOV  D5, X3
    FMOV  V5.D[1], X13
    FMOV  D6, X9
    FMOV  V6.D[1], X2
    FMOV  D7, X12
    FMOV  V7.D[1], X12
    FMOV  D8, X8
    FMOV  V8.D[1], X9
    FMOV  D9, X22
    FMOV  V9.D[1], X16
    FMOV  D10, X7
    FMOV  V10.D[1], X14
    FMOV  D11, X17
    FMOV  V11.D[1], X5
    FMOV  D12, X15
    FMOV  V12.D[1], X6
    FMOV  D13, X14
    FMOV  V13.D[1], X20
    FMOV  D14, X5
    FMOV  V14.D[1], X2
    FMOV  D15, X6
    FMOV  V15.D[1], X13
    FMOV  D16, X14
    FMOV  V16.D[1], X5
    FMOV  D17, X2
    FMOV  V17.D[1], X25
    FMOV  D18, X18
    FMOV  V18.D[1], X17
    FMOV  D19, X19
    FMOV  V19.D[1], X3
    FMOV  D20, X10
    FMOV  V20.D[1], X11
    FMOV  D21, X13
    FMOV  V21.D[1], X6
    FMOV  D22, X23
    FMOV  V22.D[1], X11
    FMOV  D23, X9
    FMOV  V23.D[1], X25
    FMOV  D24, X14
    FMOV  V24.D[1], X4
    FMOV  D25, X20
    FMOV  V25.D[1], X2
    FMOV  D26, X15
    FMOV  V26.D[1], X14
    FMOV  D27, X11
    FMOV  V27.D[1], X4
    FMOV  D28, X25
    FMOV  V28.D[1], X5
    FMOV  D29, X18
    FMOV  V29.D[1], X19
    FMOV  D30, X4
    FMOV  V30.D[1], X15
    FMOV  D31, X16
    FMOV  V31.D[1], X4
    MOVZ  X18, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_5:
    SQRDMLAH S31, S0, S26
    SQRDMLAH S31, S30, S18
    SQRDMLAH S10, S28, S15
    SQRDMLSH S30, S29, S25
    SQRDMLSH S30, S31, V22.S[0x2]
    SQRDMLSH S2, S31, V30.S[0x0]
    SQRDMLSH H26, H3, H27
    SQRDMLAH H25, H18, V2.H[0x4]
    SQRDMLAH S14, S10, S16
    SQRDMLAH H1, H25, V14.H[0x2]
    SQRDMLSH H14, H19, V1.H[0x5]
    SQRDMLAH S16, S16, S10
    SQRDMLSH S22, S16, S24
    SQRDMLAH H28, H13, V11.H[0x7]
    SQRDMLAH S15, S16, S10
    SQRDMLSH S18, S28, S18
    SQRDMLAH H25, H18, H2
    SQRDMLSH H29, H25, H25
    SQRDMLAH S19, S26, S15
    SQRDMLAH H24, H6, V14.H[0x5]
    SQRDMLSH H1, H24, V8.H[0x4]
    SQRDMLSH S3, S22, S26
    SQRDMLAH S15, S19, S19
    SQRDMLSH H8, H8, H29
    SQRDMLSH S29, S4, S1
    SQRDMLAH H27, H29, H8
    SQRDMLSH S1, S15, S0
    SQRDMLAH H14, H14, H18
    SQRDMLAH S29, S5, S5
    SQRDMLAH S25, S21, S3
    SQRDMLSH H11, H17, V8.H[0x4]
    SQRDMLSH H26, H20, H25
    SQRDMLAH S4, S14, V11.S[0x0]
    SQRDMLAH S0, S1, V29.S[0x1]
    SQRDMLAH S5, S0, S8
    SQRDMLSH H26, H5, V5.H[0x5]
    SQRDMLAH H17, H27, V3.H[0x1]
    SQRDMLSH H1, H4, V4.H[0x1]
    SQRDMLSH S5, S25, V19.S[0x3]
    SQRDMLAH S15, S5, S30
    SQRDMLAH H4, H17, H26
    SQRDMLSH S26, S5, V15.S[0x1]
    SQRDMLAH H5, H1, V4.H[0x2]
    SQRDMLSH S20, S12, S5
    SQRDMLSH H27, H22, V5.H[0x2]
    SQRDMLAH H24, H5, V13.H[0x1]
    SQRDMLAH H22, H29, H1
    SQRDMLSH S2, S24, V17.S[0x0]
    SQRDMLAH S6, S14, S31
    SQRDMLAH S14, S31, S9
    SQRDMLAH H4, H13, H27
    SQRDMLAH H5, H15, H12
    SQRDMLAH S25, S30, V10.S[0x1]
    SQRDMLAH S27, S5, S28
    SQRDMLSH S10, S4, S4
    SQRDMLSH S22, S4, V31.S[0x3]
    SQRDMLSH S21, S26, V27.S[0x3]
    SQRDMLSH H4, H10, H25
    SQRDMLSH S28, S2, S21
    SQRDMLAH S19, S28, V14.S[0x0]
    SQRDMLAH S1, S19, V20.S[0x0]
    SQRDMLSH S21, S4, V13.S[0x0]
    SQRDMLSH H12, H11, H22
    SQRDMLAH S15, S22, S21
    SQRDMLSH H22, H17, V1.H[0x5]
    SQRDMLSH H10, H25, V10.H[0x5]
    SQRDMLAH S29, S10, V30.S[0x2]
    SQRDMLSH H13, H15, V8.H[0x3]
    SQRDMLSH H8, H27, H13
    SQRDMLSH H26, H22, H11
    SQRDMLSH S20, S8, V8.S[0x1]
    SQRDMLAH S28, S26, S26
    SQRDMLSH H27, H18, H29
    SQRDMLAH H19, H27, H27
    SQRDMLAH H24, H19, V15.H[0x0]
    SQRDMLAH H17, H26, V7.H[0x2]
    SQRDMLSH S22, S4, S17
    SQRDMLSH H27, H12, V12.H[0x1]
    SQRDMLSH S29, S28, S20
    SQRDMLSH H14, H29, V4.H[0x3]
    SQRDMLAH H2, H27, V0.H[0x1]
    SQRDMLAH H20, H14, H22
    SQRDMLSH S25, S24, V10.S[0x3]
    SQRDMLAH S28, S2, V8.S[0x0]
    SQRDMLSH S21, S20, V28.S[0x1]
    SQRDMLSH S22, S2, V25.S[0x1]
    SQRDMLAH H17, H27, V10.H[0x1]
    SQRDMLSH H17, H17, V14.H[0x4]
    SQRDMLSH H5, H22, H31
    SQRDMLSH H30, H21, V15.H[0x2]
    SQRDMLSH H0, H18, V8.H[0x1]
    SQRDMLSH S8, S3, V24.S[0x1]
    SQRDMLSH S28, S26, V18.S[0x0]
    SQRDMLSH H21, H7, V11.H[0x7]
    SQRDMLAH H25, H29, H21
    SQRDMLSH H15, H18, V0.H[0x5]
    SQRDMLSH S10, S22, V12.S[0x2]
    SQRDMLSH S7, S25, V11.S[0x2]
    SQRDMLAH S0, S9, V20.S[0x2]
    SQRDMLSH S20, S5, V17.S[0x0]
    SQRDMLAH S26, S28, S7
    SQRDMLAH S19, S0, V21.S[0x0]
    SQRDMLSH S12, S20, S8
    SQRDMLSH H22, H19, H0
    SQRDMLAH S14, S12, S4
    SQRDMLSH S7, S27, V28.S[0x0]
    SQRDMLSH H9, H22, V7.H[0x3]
    SQRDMLSH S5, S26, S30
    SQRDMLAH S0, S18, V15.S[0x3]
    SQRDMLSH H7, H11, V0.H[0x1]
    SQRDMLAH H26, H5, V14.H[0x5]
    SQRDMLSH S22, S10, V6.S[0x2]
    SQRDMLAH H29, H31, V14.H[0x5]
    SQRDMLSH S25, S31, V26.S[0x2]
    SQRDMLAH H3, H22, H22
    SQRDMLAH S17, S9, V20.S[0x1]
    SQRDMLAH H24, H7, V7.H[0x3]
    SQRDMLSH S26, S19, S28
    SQRDMLSH H9, H18, V10.H[0x5]
    SQRDMLAH S27, S0, V3.S[0x3]
    SQRDMLSH H24, H29, V12.H[0x3]
    SQRDMLSH H5, H27, H24
    SQRDMLSH H3, H19, H25
    SQRDMLAH S19, S9, S9
    SQRDMLSH S15, S17, S5
    SQRDMLSH H3, H15, H15
    SQRDMLAH S28, S22, S19
    SQRDMLAH S25, S4, V26.S[0x0]
    SQRDMLAH H14, H25, V2.H[0x5]
    SQRDMLSH S29, S29, V28.S[0x0]
    SQRDMLAH H12, H24, H20
    SQRDMLAH H22, H20, V0.H[0x0]
    SQRDMLSH H24, H25, H4
    SQRDMLSH S10, S12, V22.S[0x0]
    SQRDMLAH S30, S25, S10
    SQRDMLSH S2, S24, S28
    SQRDMLSH S17, S2, V31.S[0x3]
    SQRDMLAH H11, H29, V3.H[0x5]
    SQRDMLAH S13, S14, S30
    SQRDMLSH S24, S17, S11
    SQRDMLAH S29, S28, V18.S[0x3]
    SQRDMLSH S0, S0, V12.S[0x2]
    SQRDMLAH H25, H11, V10.H[0x0]
    SQRDMLSH S20, S12, S24
    SQRDMLAH H2, H13, V15.H[0x0]
    SQRDMLSH S27, S24, V17.S[0x2]
    SQRDMLAH S4, S24, V15.S[0x0]
    SQRDMLAH H31, H15, V4.H[0x1]
    SQRDMLAH S9, S22, V16.S[0x0]
    SQRDMLSH S15, S17, S3
    SQRDMLSH S17, S15, S29
    SQRDMLAH H12, H0, V2.H[0x6]
    SQRDMLSH S16, S2, V31.S[0x3]
    SQRDMLAH H28, H16, H12
    SQRDMLSH H18, H27, V10.H[0x4]
    SQRDMLSH H29, H9, H25
    SQRDMLAH H2, H4, V10.H[0x0]
    SQRDMLSH S0, S6, V2.S[0x0]
    SQRDMLSH S4, S17, S12
    SQRDMLSH H27, H29, H4
    SQRDMLAH S31, S28, S18
    SQRDMLSH S22, S0, S0
    SQRDMLAH H13, H31, H31
    SQRDMLSH S4, S23, V27.S[0x0]
    SQRDMLSH H24, H22, H2
    SQRDMLSH H25, H12, V2.H[0x5]
    SQRDMLAH H30, H13, H24
    SQRDMLAH S29, S30, S22
    SQRDMLSH H22, H18, H4
    SQRDMLSH S16, S20, V25.S[0x0]
    SQRDMLSH H15, H22, H22
    SQRDMLAH H2, H15, V1.H[0x3]
    SQRDMLSH H24, H29, H15
    SQRDMLAH H20, H24, V2.H[0x2]
    SQRDMLSH S29, S29, V13.S[0x0]
    SQRDMLSH H24, H14, V13.H[0x0]
    SQRDMLSH H25, H9, V15.H[0x1]
    SQRDMLAH S28, S2, S24
    SQRDMLAH H5, H4, H17
    SQRDMLSH S31, S1, V8.S[0x1]
    SQRDMLSH H12, H31, H13
    SQRDMLSH S22, S22, S6
    SQRDMLAH H6, H24, V6.H[0x4]
    SQRDMLAH H10, H28, V5.H[0x3]
    SQRDMLSH H8, H2, V10.H[0x0]
    SQRDMLSH H15, H17, V10.H[0x7]
    SQRDMLSH S15, S8, S30
    SQRDMLSH S2, S31, V15.S[0x2]
    SQRDMLAH S31, S29, S26
    SQRDMLSH H14, H16, H12
    SQRDMLAH S4, S2, S2
    SQRDMLAH H13, H31, H20
    SQRDMLSH H9, H29, H31
    SQRDMLSH H3, H30, V9.H[0x0]
    SQRDMLAH S27, S10, S3
    SQRDMLAH S20, S6, S7
    SQRDMLSH H6, H25, V4.H[0x5]
    SQRDMLSH S26, S6, V30.S[0x2]
    SQRDMLAH S1, S27, S26
    SQRDMLSH S2, S13, V1.S[0x2]
    SUBS  X18, X18, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_5
    MOVZ  X15, #0x5972, LSL #0
    MOVK  X15, #0xee66, LSL #16
    MOVK  X15, #0xecc, LSL #32
    MOVK  X15, #0x4aae, LSL #48
    SUB  X2, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x53f6, LSL #0
    MOVK  X15, #0x6ebc, LSL #16
    MOVK  X15, #0xc23e, LSL #32
    MOVK  X15, #0xf85e, LSL #48
    SUB  X2, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x3db1, LSL #0
    MOVK  X15, #0xb219, LSL #16
    MOVK  X15, #0x1fac, LSL #32
    MOVK  X15, #0x47a2, LSL #48
    SUB  X2, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x2542, LSL #0
    MOVK  X15, #0x6861, LSL #16
    MOVK  X15, #0x3cef, LSL #32
    MOVK  X15, #0xf538, LSL #48
    SUB  X2, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x85f2, LSL #0
    MOVK  X15, #0x52bb, LSL #16
    MOVK  X15, #0xdcf8, LSL #32
    MOVK  X15, #0xafde, LSL #48
    SUB  X2, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0xd2dc, LSL #0
    MOVK  X15, #0x359f, LSL #16
    MOVK  X15, #0x71ac, LSL #32
    MOVK  X15, #0x903b, LSL #48
    SUB  X2, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0xa67c, LSL #0
    MOVK  X15, #0x57ee, LSL #16
    MOVK  X15, #0xe38, LSL #32
    MOVK  X15, #0x635a, LSL #48
    SUB  X2, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x4de4, LSL #0
    MOVK  X15, #0xb179, LSL #16
    MOVK  X15, #0x1cff, LSL #32
    MOVK  X15, #0x2ea2, LSL #48
    SUB  X2, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x9247, LSL #0
    MOVK  X15, #0xcc13, LSL #16
    MOVK  X15, #0x8a71, LSL #32
    MOVK  X15, #0xa36d, LSL #48
    SUB  X2, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0xe706, LSL #0
    MOVK  X15, #0x12bf, LSL #16
    MOVK  X15, #0x8ac6, LSL #32
    MOVK  X15, #0x829d, LSL #48
    SUB  X2, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0xebdf, LSL #0
    MOVK  X15, #0xd820, LSL #16
    MOVK  X15, #0xa760, LSL #32
    MOVK  X15, #0xf930, LSL #48
    SUB  X2, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0xea1b, LSL #0
    MOVK  X15, #0x1297, LSL #16
    MOVK  X15, #0x54c0, LSL #32
    MOVK  X15, #0x3990, LSL #48
    SUB  X2, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x2848, LSL #0
    MOVK  X15, #0x696c, LSL #16
    MOVK  X15, #0x9558, LSL #32
    MOVK  X15, #0xf6c5, LSL #48
    SUB  X2, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0xa477, LSL #0
    MOVK  X15, #0xf211, LSL #16
    MOVK  X15, #0x6660, LSL #32
    MOVK  X15, #0x1bb8, LSL #48
    SUB  X2, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x82ae, LSL #0
    MOVK  X15, #0x7556, LSL #16
    MOVK  X15, #0x112c, LSL #32
    MOVK  X15, #0x5698, LSL #48
    SUB  X2, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0xbf2b, LSL #0
    MOVK  X15, #0x6c2e, LSL #16
    MOVK  X15, #0x1bef, LSL #32
    MOVK  X15, #0xc427, LSL #48
    SUB  X2, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0xd693, LSL #0
    MOVK  X15, #0x620a, LSL #16
    MOVK  X15, #0x2463, LSL #32
    MOVK  X15, #0xd50d, LSL #48
    SUB  X2, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x6221, LSL #0
    MOVK  X15, #0x8f94, LSL #16
    MOVK  X15, #0x7380, LSL #32
    MOVK  X15, #0x5d06, LSL #48
    SUB  X2, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X15, #0x6e28, LSL #0
    MOVK  X15, #0xdb64, LSL #16
    MOVK  X15, #0xa9f9, LSL #32
    MOVK  X15, #0x1d6a, LSL #48
    SUB  X2, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    MRS  X15, FPSR
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x800, LSL #16
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D0
    MOVZ  X2, #0xdc05, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D1
    MOVZ  X2, #0xe023, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D2
    MOVZ  X2, #0x8000, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D3
    MOVZ  X2, #0x3764, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D4
    MOVZ  X2, #0x3784, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D5
    MOVZ  X2, #0xb95, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D6
    MOVZ  X2, #0x5fb9, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D7
    MOVZ  X2, #0xe740, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D8
    MOVZ  X2, #0x7fff, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D9
    MOVZ  X2, #0x2d6a, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D10
    MOVZ  X2, #0x56db, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D11
    MOVZ  X2, #0x2848, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D12
    MOVZ  X2, #0x7fff, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D13
    MOVZ  X2, #0xea3d, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D14
    MOVZ  X2, #0x9a97, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D15
    MOVZ  X2, #0xb5fa, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D16
    MOVZ  X2, #0xfd61, LSL #0
    MOVK  X2, #0x1a46, LSL #16
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D17
    MOVZ  X2, #0x7ffe, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D18
    MOVZ  X2, #0xf1d9, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D19
    MOVZ  X2, #0x7c66, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D20
    MOVZ  X2, #0x325a, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D21
    MOVZ  X2, #0xcd5a, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D22
    MOVZ  X2, #0xb083, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X2, #0x6e28, LSL #0
    MOVK  X2, #0xdb64, LSL #16
    MOVK  X2, #0xa9f9, LSL #32
    MOVK  X2, #0x1d6a, LSL #48
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D23
    MOVZ  X2, #0xa67c, LSL #0
    MOVK  X2, #0x57ee, LSL #16
    MOVK  X2, #0xe38, LSL #32
    MOVK  X2, #0x635a, LSL #48
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D24
    MOVZ  X2, #0xf7ba, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D25
    MOVZ  X2, #0x4f01, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D26
    MOVZ  X2, #0x278d, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D27
    MOVZ  X2, #0x6986, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D28
    MOVZ  X2, #0x6c3e, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D29
    MOVZ  X2, #0xcfb, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D30
    MOVZ  X2, #0xd583, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X15, D31
    MOVZ  X2, #0x19, LSL #0
    SUB  X16, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    FMOV  D0, X9
    FMOV  V0.D[1], X11
    FMOV  D1, X20
    FMOV  V1.D[1], X3
    FMOV  D2, X5
    FMOV  V2.D[1], X14
    FMOV  D3, X21
    FMOV  V3.D[1], X10
    FMOV  D4, X16
    FMOV  V4.D[1], X19
    FMOV  D5, X5
    FMOV  V5.D[1], X25
    FMOV  D6, X17
    FMOV  V6.D[1], X15
    FMOV  D7, X18
    FMOV  V7.D[1], X23
    FMOV  D8, X22
    FMOV  V8.D[1], X2
    FMOV  D9, X11
    FMOV  V9.D[1], X15
    FMOV  D10, X2
    FMOV  V10.D[1], X14
    FMOV  D11, X10
    FMOV  V11.D[1], X13
    FMOV  D12, X9
    FMOV  V12.D[1], X11
    FMOV  D13, X4
    FMOV  V13.D[1], X17
    FMOV  D14, X15
    FMOV  V14.D[1], X12
    FMOV  D15, X17
    FMOV  V15.D[1], X8
    FMOV  D16, X18
    FMOV  V16.D[1], X7
    FMOV  D17, X22
    FMOV  V17.D[1], X18
    FMOV  D18, X2
    FMOV  V18.D[1], X2
    FMOV  D19, X9
    FMOV  V19.D[1], X15
    FMOV  D20, X7
    FMOV  V20.D[1], X25
    FMOV  D21, X11
    FMOV  V21.D[1], X10
    FMOV  D22, X14
    FMOV  V22.D[1], X23
    FMOV  D23, X7
    FMOV  V23.D[1], X11
    FMOV  D24, X10
    FMOV  V24.D[1], X21
    FMOV  D25, X21
    FMOV  V25.D[1], X5
    FMOV  D26, X18
    FMOV  V26.D[1], X14
    FMOV  D27, X8
    FMOV  V27.D[1], X15
    FMOV  D28, X12
    FMOV  V28.D[1], X2
    FMOV  D29, X22
    FMOV  V29.D[1], X15
    FMOV  D30, X10
    FMOV  V30.D[1], X9
    FMOV  D31, X15
    FMOV  V31.D[1], X5
    MOVZ  X12, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_6:
    SQRDMLSH H3, H30, H27
    SQRDMLSH H4, H26, V11.H[0x0]
    SQRDMLSH S30, S28, V29.S[0x2]
    SQRDMLSH S26, S31, S25
    SQRDMLSH S0, S7, S26
    SQRDMLSH S24, S30, V23.S[0x2]
    SQRDMLSH H31, H3, H3
    SQRDMLAH S2, S18, S15
    SQRDMLAH S26, S0, V4.S[0x2]
    SQRDMLSH H26, H31, V2.H[0x2]
    SQRDMLSH H31, H26, H10
    SQRDMLAH H10, H11, H24
    SQRDMLAH H15, H10, V10.H[0x0]
    SQRDMLSH H17, H8, H9
    SQRDMLSH S8, S7, S19
    SQRDMLSH H26, H11, H21
    SQRDMLAH S28, S7, S22
    SQRDMLSH H25, H6, V12.H[0x2]
    SQRDMLAH H4, H4, V8.H[0x6]
    SQRDMLAH S6, S9, S26
    SQRDMLAH S2, S3, S26
    SQRDMLSH H11, H0, H10
    SQRDMLAH H29, H6, H15
    SQRDMLAH H12, H4, V12.H[0x0]
    SQRDMLAH S18, S12, V17.S[0x1]
    SQRDMLAH H8, H11, H28
    SQRDMLAH H6, H25, H18
    SQRDMLSH S16, S21, S8
    SQRDMLAH H30, H30, V2.H[0x4]
    SQRDMLSH S23, S31, V19.S[0x3]
    SQRDMLSH H2, H16, H30
    SQRDMLAH H1, H23, H23
    SQRDMLAH S3, S29, S29
    SQRDMLAH S15, S12, S1
    SQRDMLSH H24, H15, H29
    SQRDMLSH S31, S6, S1
    SQRDMLAH H6, H31, V3.H[0x5]
    SQRDMLSH H18, H6, V2.H[0x2]
    SQRDMLAH S28, S2, S26
    SQRDMLAH H1, H23, H7
    SQRDMLAH S25, S2, S15
    SQRDMLSH S19, S11, S6
    SQRDMLSH S30, S18, S28
    SQRDMLSH S8, S5, S29
    SQRDMLAH H5, H13, H13
    SQRDMLSH H21, H27, H12
    SQRDMLAH H4, H6, H12
    SQRDMLSH S2, S5, S8
    SQRDMLSH H28, H21, V2.H[0x6]
    SQRDMLAH S16, S19, S16
    SQRDMLAH H6, H0, V6.H[0x6]
    SQRDMLSH S19, S23, V30.S[0x3]
    SQRDMLAH S27, S12, S16
    SQRDMLAH S21, S4, S8
    SQRDMLSH H26, H21, H1
    SQRDMLSH S7, S28, S24
    SQRDMLAH H2, H6, H28
    SQRDMLSH S5, S28, S7
    SQRDMLAH S0, S2, V5.S[0x1]
    SQRDMLSH S24, S25, S27
    SQRDMLAH H31, H15, V0.H[0x3]
    SQRDMLAH S8, S24, S22
    SQRDMLSH S6, S31, S19
    SQRDMLSH S15, S0, S30
    SQRDMLSH H0, H15, H15
    SQRDMLAH H31, H6, V8.H[0x6]
    SQRDMLAH H28, H26, V0.H[0x5]
    SQRDMLSH S0, S20, S13
    SQRDMLAH S4, S28, V13.S[0x2]
    SQRDMLAH S30, S4, V19.S[0x2]
    SQRDMLAH S28, S1, S15
    SQRDMLSH H20, H9, V14.H[0x7]
    SQRDMLAH H9, H3, H23
    SQRDMLAH S21, S23, S24
    SQRDMLAH H16, H0, H6
    SQRDMLSH S26, S7, V8.S[0x2]
    SQRDMLAH H0, H0, V15.H[0x3]
    SQRDMLSH H1, H1, V0.H[0x2]
    SQRDMLAH S0, S16, V28.S[0x3]
    SQRDMLAH H22, H1, H30
    SQRDMLSH H15, H20, V9.H[0x2]
    SQRDMLSH S24, S0, V17.S[0x3]
    SQRDMLAH S9, S19, S31
    SQRDMLAH H1, H10, V11.H[0x1]
    SQRDMLAH S30, S1, V26.S[0x1]
    SQRDMLAH H23, H9, V9.H[0x6]
    SQRDMLSH S4, S23, S24
    SQRDMLAH S28, S27, V4.S[0x3]
    SQRDMLAH S20, S21, V24.S[0x2]
    SQRDMLSH H8, H15, H15
    SQRDMLSH S19, S30, V28.S[0x3]
    SQRDMLSH H29, H19, V3.H[0x7]
    SQRDMLSH S21, S22, S25
    SQRDMLSH H9, H14, H20
    SQRDMLAH S7, S21, S21
    SQRDMLSH S21, S5, V14.S[0x0]
    SQRDMLSH H20, H8, H5
    SQRDMLAH H6, H25, H9
    SQRDMLSH H5, H7, H7
    SQRDMLSH H14, H29, H6
    SQRDMLSH H26, H14, H5
    SQRDMLSH H27, H20, H21
    SQRDMLSH S30, S4, V29.S[0x0]
    SQRDMLAH H19, H10, H27
    SQRDMLAH H7, H17, H29
    SQRDMLSH S4, S16, S18
    SQRDMLSH H8, H14, H30
    SQRDMLAH H27, H3, H26
    SQRDMLSH S28, S29, S24
    SQRDMLAH S10, S7, V30.S[0x1]
    SQRDMLAH H5, H7, V14.H[0x4]
    SQRDMLAH S26, S5, S18
    SQRDMLAH S18, S7, V20.S[0x1]
    SQRDMLSH H23, H26, V1.H[0x0]
    SQRDMLAH S25, S18, S20
    SQRDMLAH H18, H2, V8.H[0x3]
    SQRDMLSH S9, S15, S9
    SQRDMLAH S21, S27, S19
    SQRDMLAH H20, H4, V6.H[0x6]
    SQRDMLAH S5, S16, V28.S[0x0]
    SQRDMLAH H14, H17, H14
    SQRDMLAH H6, H21, V12.H[0x4]
    SQRDMLSH S16, S10, V10.S[0x2]
    SQRDMLAH H17, H16, V5.H[0x4]
    SQRDMLSH S2, S9, S6
    SQRDMLSH S27, S29, V16.S[0x2]
    SQRDMLSH H6, H17, V14.H[0x3]
    SQRDMLSH S8, S25, V27.S[0x1]
    SQRDMLAH H1, H6, V2.H[0x4]
    SQRDMLAH S5, S18, V1.S[0x3]
    SQRDMLAH S19, S20, V23.S[0x3]
    SQRDMLSH S16, S8, V25.S[0x2]
    SQRDMLSH H1, H5, V14.H[0x1]
    SQRDMLSH H25, H18, V1.H[0x1]
    SQRDMLSH S21, S8, V13.S[0x1]
    SQRDMLSH S30, S31, S16
    SQRDMLSH S6, S13, S18
    SQRDMLSH S19, S22, S19
    SQRDMLSH H10, H9, V1.H[0x5]
    SQRDMLAH H27, H21, V14.H[0x2]
    SQRDMLSH H15, H6, H6
    SQRDMLSH H23, H28, H19
    SQRDMLAH H29, H25, V7.H[0x1]
    SQRDMLSH H25, H29, V10.H[0x5]
    SQRDMLSH H29, H25, H25
    SQRDMLAH S5, S2, S0
    SQRDMLSH S2, S12, V20.S[0x1]
    SQRDMLAH H8, H28, V5.H[0x3]
    SQRDMLSH S17, S27, V8.S[0x0]
    SQRDMLSH H7, H15, V2.H[0x5]
    SQRDMLSH H14, H29, V4.H[0x7]
    SQRDMLAH H19, H17, V14.H[0x5]
    SQRDMLSH S27, S11, V30.S[0x2]
    SQRDMLSH S15, S27, V7.S[0x1]
    SQRDMLSH H21, H31, H1
    SQRDMLSH S7, S3, S15
    SQRDMLAH H30, H18, H23
    SQRDMLSH H1, H24, V14.H[0x4]
    SQRDMLSH S31, S30, V30.S[0x0]
    SQRDMLAH S6, S29, S13
    SQRDMLAH S17, S21, S7
    SQRDMLAH H11, H11, H6
    SQRDMLSH S15, S19, S7
    SQRDMLAH S23, S15, S11
    SQRDMLSH S24, S6, S31
    SQRDMLAH H2, H23, H23
    SQRDMLSH S29, S22, V25.S[0x3]
    SQRDMLAH H6, H26, H6
    SQRDMLSH H3, H6, V2.H[0x6]
    SQRDMLAH H30, H24, V11.H[0x2]
    SQRDMLSH S26, S29, S17
    SQRDMLSH S21, S1, V7.S[0x1]
    SQRDMLAH H22, H31, H0
    SQRDMLAH H5, H22, V1.H[0x2]
    SQRDMLAH H29, H13, H26
    SQRDMLSH H14, H30, V3.H[0x2]
    SQRDMLAH H22, H14, H21
    SQRDMLSH S27, S5, S29
    SQRDMLAH H28, H15, H16
    SQRDMLAH H15, H3, V4.H[0x5]
    SQRDMLAH S29, S6, S26
    SQRDMLSH S31, S7, S10
    SQRDMLSH S4, S26, V30.S[0x3]
    SQRDMLAH H3, H5, V13.H[0x6]
    SQRDMLSH H17, H16, V15.H[0x0]
    SQRDMLSH S1, S24, S10
    SQRDMLAH S2, S15, V27.S[0x1]
    SQRDMLSH S21, S28, S29
    SQRDMLSH S5, S1, S17
    SQRDMLSH H29, H22, V5.H[0x1]
    SQRDMLAH S14, S0, S31
    SQRDMLAH H14, H3, V4.H[0x6]
    SQRDMLAH H5, H2, H0
    SQRDMLSH H24, H14, V14.H[0x2]
    SQRDMLSH S1, S8, S16
    SQRDMLSH S7, S1, S21
    SQRDMLSH S2, S3, S6
    SQRDMLSH H4, H29, H5
    SQRDMLSH S11, S4, S29
    SQRDMLAH H28, H24, V11.H[0x7]
    SUBS  X12, X12, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_6
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    MRS  X8, FPSR
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x800, LSL #16
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D0
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D1
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D10
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D14
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D29
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D30
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X8, D31
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X22
    FMOV  D1, X23
    FMOV  V1.D[1], X14
    FMOV  D2, X25
    FMOV  V2.D[1], X5
    FMOV  D3, X25
    FMOV  V3.D[1], X23
    FMOV  D4, X23
    FMOV  V4.D[1], X5
    FMOV  D5, X20
    FMOV  V5.D[1], X3
    FMOV  D6, X21
    FMOV  V6.D[1], X25
    FMOV  D7, X22
    FMOV  V7.D[1], X6
    FMOV  D8, X8
    FMOV  V8.D[1], X9
    FMOV  D9, X20
    FMOV  V9.D[1], X15
    FMOV  D10, X4
    FMOV  V10.D[1], X25
    FMOV  D11, X19
    FMOV  V11.D[1], X5
    FMOV  D12, X14
    FMOV  V12.D[1], X12
    FMOV  D13, X7
    FMOV  V13.D[1], X6
    FMOV  D14, X10
    FMOV  V14.D[1], X25
    FMOV  D15, X22
    FMOV  V15.D[1], X7
    FMOV  D16, X14
    FMOV  V16.D[1], X5
    FMOV  D17, X9
    FMOV  V17.D[1], X23
    FMOV  D18, X18
    FMOV  V18.D[1], X7
    FMOV  D19, X17
    FMOV  V19.D[1], X15
    FMOV  D20, X19
    FMOV  V20.D[1], X16
    FMOV  D21, X25
    FMOV  V21.D[1], X15
    FMOV  D22, X3
    FMOV  V22.D[1], X19
    FMOV  D23, X21
    FMOV  V23.D[1], X2
    FMOV  D24, X4
    FMOV  V24.D[1], X4
    FMOV  D25, X8
    FMOV  V25.D[1], X3
    FMOV  D26, X12
    FMOV  V26.D[1], X6
    FMOV  D27, X5
    FMOV  V27.D[1], X3
    FMOV  D28, X5
    FMOV  V28.D[1], X21
    FMOV  D29, X18
    FMOV  V29.D[1], X4
    FMOV  D30, X4
    FMOV  V30.D[1], X2
    FMOV  D31, X21
    FMOV  V31.D[1], X15
    MOVZ  X18, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_7:
    SQRDMLAH S4, S31, V29.S[0x3]
    SQRDMLSH H30, H10, H22
    SQRDMLSH H16, H26, V11.H[0x3]
    SQRDMLAH S10, S4, V16.S[0x3]
    SQRDMLSH S26, S28, S24
    SQRDMLSH H12, H1, V7.H[0x1]
    SQRDMLAH H4, H30, H26
    SQRDMLSH H9, H27, V13.H[0x6]
    SQRDMLSH S29, S21, S9
    SQRDMLAH H19, H7, V3.H[0x2]
    SQRDMLSH S5, S29, V19.S[0x2]
    SQRDMLAH H24, H5, H12
    SQRDMLSH S27, S30, V4.S[0x2]
    SQRDMLAH S4, S15, S24
    SQRDMLAH H26, H24, V10.H[0x3]
    SQRDMLSH H16, H23, H26
    SQRDMLAH H1, H16, V1.H[0x3]
    SQRDMLAH S29, S25, V27.S[0x2]
    SQRDMLSH H13, H20, V1.H[0x2]
    SQRDMLAH H23, H4, H11
    SQRDMLSH S26, S8, S5
    SQRDMLAH H8, H22, H15
    SQRDMLSH S26, S23, V26.S[0x0]
    SQRDMLAH H1, H8, V6.H[0x7]
    SQRDMLAH S16, S26, V1.S[0x2]
    SQRDMLSH H20, H20, H6
    SQRDMLAH S12, S13, S1
    SQRDMLAH H15, H16, V3.H[0x3]
    SQRDMLSH S17, S12, V12.S[0x3]
    SQRDMLSH H5, H22, H8
    SQRDMLAH S27, S30, V1.S[0x0]
    SQRDMLAH H3, H4, H29
    SQRDMLAH S12, S20, S15
    SQRDMLAH S17, S17, S12
    SQRDMLSH S19, S5, S5
    SQRDMLSH H25, H27, V8.H[0x4]
    SQRDMLAH H16, H17, V3.H[0x1]
    SQRDMLSH H4, H19, H25
    SQRDMLSH H3, H6, V9.H[0x2]
    SQRDMLSH S26, S31, V31.S[0x1]
    SQRDMLSH H22, H30, V7.H[0x3]
    SQRDMLSH S8, S17, S23
    SQRDMLAH S9, S31, S26
    SQRDMLSH S21, S12, V15.S[0x2]
    SQRDMLSH S20, S0, S5
    SQRDMLSH H17, H30, V6.H[0x3]
    SQRDMLAH S7, S6, S3
    SQRDMLAH S15, S22, V25.S[0x3]
    SQRDMLSH H23, H8, V4.H[0x2]
    SQRDMLSH H30, H24, V9.H[0x2]
    SQRDMLSH H27, H21, V5.H[0x5]
    SQRDMLAH S16, S16, S27
    SQRDMLSH H12, H20, H5
    SQRDMLAH S5, S23, V17.S[0x0]
    SQRDMLAH H20, H5, V5.H[0x5]
    SQRDMLAH H27, H17, H20
    SQRDMLAH H19, H15, V3.H[0x3]
    SQRDMLSH S0, S19, V12.S[0x2]
    SQRDMLAH S31, S16, S30
    SQRDMLSH H5, H14, H31
    SQRDMLAH H31, H0, H7
    SQRDMLSH H0, H31, H4
    SQRDMLSH S26, S27, S31
    SQRDMLSH H6, H8, V5.H[0x5]
    SQRDMLSH H22, H4, H26
    SQRDMLSH S9, S13, S13
    SQRDMLSH H26, H0, V9.H[0x3]
    SQRDMLSH H12, H1, H6
    SQRDMLAH H14, H12, V2.H[0x6]
    SQRDMLAH S12, S22, V22.S[0x1]
    SQRDMLAH H13, H15, H1
    SQRDMLAH H0, H6, H14
    SQRDMLAH S24, S23, V26.S[0x3]
    SQRDMLAH S7, S8, V13.S[0x0]
    SQRDMLSH S9, S25, S0
    SQRDMLAH H5, H14, H16
    SQRDMLAH S16, S9, V7.S[0x0]
    SQRDMLSH H19, H3, V5.H[0x6]
    SQRDMLAH H30, H24, H3
    SQRDMLAH S0, S5, S10
    SQRDMLSH S24, S16, S17
    SQRDMLAH H3, H2, V8.H[0x6]
    SQRDMLSH S20, S24, V3.S[0x2]
    SQRDMLAH H16, H0, V3.H[0x1]
    SQRDMLAH S2, S16, V28.S[0x2]
    SQRDMLSH H30, H28, V12.H[0x7]
    SQRDMLAH S12, S20, V13.S[0x2]
    SQRDMLSH S20, S8, V10.S[0x3]
    SQRDMLAH S27, S23, S20
    SQRDMLSH S17, S25, S6
    SQRDMLAH S10, S27, V16.S[0x2]
    SQRDMLSH H27, H30, H10
    SQRDMLSH S22, S19, V30.S[0x1]
    SQRDMLAH S5, S16, V10.S[0x1]
    SQRDMLAH S29, S2, S27
    SQRDMLAH H26, H17, V5.H[0x1]
    SQRDMLSH H2, H4, H12
    SQRDMLSH S28, S2, V17.S[0x0]
    SQRDMLAH H14, H3, V6.H[0x4]
    SQRDMLSH H17, H0, V14.H[0x2]
    SQRDMLAH S8, S22, S13
    SQRDMLSH H23, H29, H30
    SQRDMLAH S0, S8, S7
    SQRDMLSH H13, H23, H4
    SQRDMLAH S19, S17, V0.S[0x3]
    SQRDMLSH H8, H13, V13.H[0x4]
    SQRDMLSH S23, S28, S8
    SQRDMLAH S29, S3, S19
    SQRDMLSH H24, H12, H29
    SQRDMLSH H4, H26, V4.H[0x3]
    SQRDMLSH H5, H13, V4.H[0x6]
    SQRDMLSH S7, S9, S15
    SQRDMLSH H15, H24, H23
    SQRDMLSH S22, S5, S15
    SQRDMLAH S3, S31, V31.S[0x3]
    SQRDMLSH H30, H14, H26
    SQRDMLAH H14, H24, H18
    SQRDMLSH S31, S29, S3
    SQRDMLSH H4, H11, V11.H[0x7]
    SQRDMLSH S24, S6, V5.S[0x0]
    SQRDMLSH H3, H24, H17
    SQRDMLAH S0, S25, V31.S[0x3]
    SQRDMLSH S10, S31, V22.S[0x1]
    SQRDMLSH H15, H1, V14.H[0x5]
    SQRDMLAH H12, H27, H14
    SQRDMLAH H9, H28, H9
    SQRDMLAH H24, H0, H12
    SQRDMLSH H11, H4, H2
    SQRDMLAH H5, H3, V11.H[0x1]
    SQRDMLAH S11, S4, S9
    SQRDMLAH S6, S5, V15.S[0x2]
    SQRDMLSH S17, S16, V10.S[0x2]
    SQRDMLAH H29, H17, V4.H[0x3]
    SQRDMLAH H1, H23, V11.H[0x4]
    SQRDMLAH S26, S13, V4.S[0x1]
    SQRDMLSH S13, S12, V30.S[0x3]
    SQRDMLAH H22, H1, H24
    SQRDMLAH H15, H6, V1.H[0x4]
    SQRDMLAH H10, H29, H13
    SQRDMLSH H6, H0, V11.H[0x6]
    SQRDMLSH S28, S19, S6
    SQRDMLSH H31, H5, V10.H[0x1]
    SQRDMLSH H13, H19, V11.H[0x6]
    SQRDMLSH S3, S25, S22
    SQRDMLAH S10, S3, S2
    SQRDMLSH H31, H21, H19
    SQRDMLSH S12, S31, V28.S[0x2]
    SQRDMLSH H21, H22, V10.H[0x1]
    SQRDMLSH S25, S12, S12
    SQRDMLSH S14, S21, S22
    SQRDMLAH H4, H15, H26
    SQRDMLSH S2, S12, V25.S[0x1]
    SQRDMLAH H23, H13, V10.H[0x3]
    SQRDMLAH H20, H4, H22
    SQRDMLSH H25, H2, H2
    SQRDMLAH S1, S23, V20.S[0x1]
    SQRDMLSH H4, H18, H22
    SQRDMLSH H31, H4, H1
    SQRDMLAH S22, S25, S31
    SQRDMLSH S13, S13, S22
    SQRDMLSH H25, H10, V15.H[0x6]
    SQRDMLSH S19, S17, V1.S[0x0]
    SQRDMLSH S20, S26, V20.S[0x0]
    SQRDMLAH S15, S11, S15
    SQRDMLAH H12, H13, H12
    SQRDMLSH S1, S9, V18.S[0x0]
    SQRDMLAH S3, S5, V31.S[0x1]
    SQRDMLSH H22, H29, V3.H[0x2]
    SQRDMLAH S23, S9, V28.S[0x3]
    SQRDMLAH H30, H19, V14.H[0x4]
    SQRDMLAH S18, S14, V13.S[0x0]
    SQRDMLAH S21, S17, S25
    SQRDMLAH S2, S31, S1
    SQRDMLAH H10, H20, V12.H[0x7]
    SQRDMLSH H31, H15, H21
    SQRDMLSH S23, S31, V23.S[0x1]
    SQRDMLAH S9, S18, V5.S[0x1]
    SQRDMLAH S23, S30, S9
    SQRDMLSH S4, S29, V27.S[0x0]
    SQRDMLSH S12, S4, S4
    SQRDMLSH S13, S10, V11.S[0x3]
    SQRDMLAH H29, H12, V13.H[0x3]
    SQRDMLSH S14, S23, V29.S[0x3]
    SQRDMLAH S11, S5, S2
    SQRDMLAH S15, S11, S11
    SQRDMLAH H10, H14, H14
    SQRDMLAH S31, S22, S1
    SQRDMLAH H26, H31, H31
    SQRDMLSH S29, S15, S10
    SQRDMLSH H21, H28, V7.H[0x3]
    SQRDMLAH H28, H12, H11
    SQRDMLSH S10, S8, S2
    SQRDMLAH S7, S9, V14.S[0x1]
    SQRDMLSH S5, S6, S19
    SQRDMLAH S11, S11, V3.S[0x1]
    SQRDMLSH S7, S6, V16.S[0x1]
    SQRDMLAH H30, H0, V2.H[0x6]
    SQRDMLAH H1, H25, H7
    SQRDMLAH S27, S1, S29
    SQRDMLAH H2, H23, H16
    SUBS  X18, X18, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_7
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, LCRTAdvsimdScalarRDM_TestFail
    MRS  X13, FPSR
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x800, LSL #16
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D0
    MOVZ  X25, #0xffff, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D1
    MOVZ  X25, #0xffff, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D2
    MOVZ  X25, #0xffff, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D3
    MOVZ  X25, #0xffeb, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D4
    MOVZ  X25, #0x1, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D5
    MOVZ  X25, #0xffed, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D6
    MOVZ  X25, #0xffff, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D7
    MOVZ  X25, #0x11, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D8
    MOVZ  X25, #0x13, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D9
    MOVZ  X25, #0xffd7, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D10
    MOVZ  X25, #0x13, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D11
    MOVZ  X25, #0x13, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D12
    MOVZ  X25, #0x13, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D13
    MOVZ  X25, #0xffeb, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D14
    MOVZ  X25, #0xfffd, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D15
    MOVZ  X25, #0x3, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D16
    MOVZ  X25, #0xffff, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D17
    MOVZ  X25, #0xffeb, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D18
    MOVZ  X25, #0x13, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D19
    MOVZ  X25, #0xffd7, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D20
    MOVZ  X25, #0xffd9, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D21
    MOVZ  X25, #0x13, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D22
    MOVZ  X25, #0xffff, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D23
    MOVZ  X25, #0x13, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D24
    MOVZ  X25, #0xffd9, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D25
    MOVZ  X25, #0xffff, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D26
    MOVZ  X25, #0xffeb, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D27
    MOVZ  X25, #0x15, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D28
    MOVZ  X25, #0xffd7, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D29
    MOVZ  X25, #0x13, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D30
    MOVZ  X25, #0xffff, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D31
    MOVZ  X25, #0x27, LSL #0
    SUB  X15, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X23
    FMOV  D1, X21
    FMOV  V1.D[1], X7
    FMOV  D2, X17
    FMOV  V2.D[1], X17
    FMOV  D3, X19
    FMOV  V3.D[1], X25
    FMOV  D4, X6
    FMOV  V4.D[1], X3
    FMOV  D5, X12
    FMOV  V5.D[1], X21
    FMOV  D6, X10
    FMOV  V6.D[1], X21
    FMOV  D7, X16
    FMOV  V7.D[1], X20
    FMOV  D8, X19
    FMOV  V8.D[1], X2
    FMOV  D9, X3
    FMOV  V9.D[1], X8
    FMOV  D10, X10
    FMOV  V10.D[1], X25
    FMOV  D11, X2
    FMOV  V11.D[1], X22
    FMOV  D12, X6
    FMOV  V12.D[1], X12
    FMOV  D13, X23
    FMOV  V13.D[1], X11
    FMOV  D14, X25
    FMOV  V14.D[1], X11
    FMOV  D15, X4
    FMOV  V15.D[1], X6
    FMOV  D16, X20
    FMOV  V16.D[1], X8
    FMOV  D17, X22
    FMOV  V17.D[1], X18
    FMOV  D18, X23
    FMOV  V18.D[1], X16
    FMOV  D19, X21
    FMOV  V19.D[1], X8
    FMOV  D20, X5
    FMOV  V20.D[1], X25
    FMOV  D21, X23
    FMOV  V21.D[1], X21
    FMOV  D22, X14
    FMOV  V22.D[1], X22
    FMOV  D23, X12
    FMOV  V23.D[1], X4
    FMOV  D24, X21
    FMOV  V24.D[1], X19
    FMOV  D25, X22
    FMOV  V25.D[1], X10
    FMOV  D26, X20
    FMOV  V26.D[1], X7
    FMOV  D27, X12
    FMOV  V27.D[1], X15
    FMOV  D28, X25
    FMOV  V28.D[1], X3
    FMOV  D29, X23
    FMOV  V29.D[1], X10
    FMOV  D30, X20
    FMOV  V30.D[1], X18
    FMOV  D31, X20
    FMOV  V31.D[1], X18
    MOVZ  X14, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_8:
    SQRDMLAH S10, S30, V30.S[0x0]
    SQRDMLSH S18, S31, S25
    SQRDMLAH S21, S8, S7
    SQRDMLSH S15, S28, V29.S[0x1]
    SQRDMLAH H21, H11, V7.H[0x2]
    SQRDMLSH H4, H21, V9.H[0x7]
    SQRDMLAH S25, S26, V4.S[0x3]
    SQRDMLSH S24, S27, V22.S[0x1]
    SQRDMLAH H25, H25, V10.H[0x3]
    SQRDMLAH H4, H1, V9.H[0x4]
    SQRDMLAH S9, S25, V25.S[0x3]
    SQRDMLAH S21, S18, S12
    SQRDMLAH S8, S9, V20.S[0x0]
    SQRDMLSH H18, H24, H0
    SQRDMLAH H28, H25, V5.H[0x7]
    SQRDMLSH H25, H18, H4
    SQRDMLSH S5, S11, V26.S[0x3]
    SQRDMLAH H9, H22, V8.H[0x2]
    SQRDMLAH S7, S21, S21
    SQRDMLSH H27, H5, V15.H[0x0]
    SQRDMLAH H30, H28, V15.H[0x6]
    SQRDMLSH H10, H25, V9.H[0x4]
    SQRDMLSH S15, S27, S7
    SQRDMLSH S5, S25, V15.S[0x1]
    SQRDMLAH S9, S10, S30
    SQRDMLAH H28, H31, V13.H[0x3]
    SQRDMLSH S4, S21, V26.S[0x3]
    SQRDMLSH S0, S28, S12
    SQRDMLAH H25, H27, H14
    SQRDMLAH S1, S10, S24
    SQRDMLAH H24, H2, H31
    SQRDMLSH H20, H16, V6.H[0x7]
    SQRDMLAH H7, H2, V7.H[0x2]
    SQRDMLSH H19, H9, H5
    SQRDMLAH S2, S20, V20.S[0x0]
    SQRDMLSH H16, H19, H19
    SQRDMLAH S14, S2, S31
    SQRDMLAH S10, S19, V4.S[0x3]
    SQRDMLSH S26, S10, S10
    SQRDMLAH H5, H26, V14.H[0x3]
    SQRDMLSH H4, H5, H1
    SQRDMLSH H19, H7, H24
    SQRDMLAH S30, S4, S24
    SQRDMLAH H27, H16, H25
    SQRDMLSH S10, S27, S30
    SQRDMLAH S1, S18, V13.S[0x2]
    SQRDMLSH H18, H23, H14
    SQRDMLAH S16, S18, V18.S[0x2]
    SQRDMLAH S7, S16, S10
    SQRDMLSH S4, S17, V1.S[0x0]
    SQRDMLAH H12, H4, V4.H[0x2]
    SQRDMLSH S18, S27, V7.S[0x0]
    SQRDMLAH H4, H19, H19
    SQRDMLSH S28, S4, V12.S[0x2]
    SQRDMLAH S26, S18, S13
    SQRDMLAH S2, S26, V28.S[0x3]
    SQRDMLAH S30, S30, V12.S[0x2]
    SQRDMLAH H26, H11, V11.H[0x5]
    SQRDMLSH S28, S9, V8.S[0x2]
    SQRDMLAH S5, S26, S1
    SQRDMLSH S11, S10, V20.S[0x1]
    SQRDMLAH H20, H15, V4.H[0x6]
    SQRDMLSH H16, H26, H0
    SQRDMLSH S8, S24, S17
    SQRDMLSH S9, S22, S26
    SQRDMLAH S18, S2, S11
    SQRDMLAH S22, S25, V20.S[0x2]
    SQRDMLAH S12, S18, S8
    SQRDMLSH H13, H12, H30
    SQRDMLSH S27, S12, V5.S[0x3]
    SQRDMLSH H10, H9, V3.H[0x0]
    SQRDMLAH S9, S22, S28
    SQRDMLSH H4, H25, H19
    SQRDMLAH S5, S4, V10.S[0x3]
    SQRDMLAH H0, H18, H18
    SQRDMLSH H2, H3, H5
    SQRDMLSH S20, S27, S28
    SQRDMLAH S12, S20, S2
    SQRDMLAH S1, S13, V19.S[0x3]
    SQRDMLSH H2, H30, H9
    SQRDMLSH S9, S0, V5.S[0x1]
    SQRDMLSH S0, S12, V12.S[0x1]
    SQRDMLSH H25, H1, V2.H[0x7]
    SQRDMLSH H17, H18, H8
    SQRDMLSH H19, H0, H4
    SQRDMLAH S2, S9, S9
    SQRDMLSH H30, H22, V2.H[0x3]
    SQRDMLSH S3, S19, V30.S[0x0]
    SQRDMLAH S22, S3, S25
    SQRDMLSH H4, H17, H17
    SQRDMLAH S12, S15, V4.S[0x3]
    SQRDMLAH H18, H22, H22
    SQRDMLSH H27, H4, H18
    SQRDMLAH H22, H27, V6.H[0x2]
    SQRDMLSH S31, S12, V19.S[0x2]
    SQRDMLSH H28, H26, V9.H[0x2]
    SQRDMLAH H20, H22, V6.H[0x5]
    SQRDMLAH H8, H16, V5.H[0x5]
    SQRDMLSH H4, H21, V8.H[0x7]
    SQRDMLAH S25, S30, V22.S[0x2]
    SQRDMLAH H27, H16, H11
    SQRDMLSH S15, S21, S6
    SQRDMLSH S21, S0, V21.S[0x1]
    SQRDMLAH H11, H3, V2.H[0x4]
    SQRDMLSH H16, H28, H27
    SQRDMLSH S3, S25, S20
    SQRDMLAH H25, H3, V5.H[0x1]
    SQRDMLAH H8, H16, H31
    SQRDMLAH S6, S25, V30.S[0x1]
    SQRDMLSH H18, H0, H21
    SQRDMLSH S0, S18, S15
    SQRDMLAH H21, H14, H6
    SQRDMLAH S20, S8, V21.S[0x1]
    SQRDMLAH S1, S2, V10.S[0x3]
    SQRDMLSH H9, H4, V15.H[0x5]
    SQRDMLSH S2, S9, S5
    SQRDMLAH S28, S1, V20.S[0x0]
    SQRDMLAH H3, H11, V0.H[0x6]
    SQRDMLSH H5, H20, V10.H[0x0]
    SQRDMLSH S0, S28, S23
    SQRDMLAH S27, S31, S28
    SQRDMLSH S15, S0, S13
    SQRDMLAH S4, S15, S3
    SQRDMLSH H9, H2, H17
    SQRDMLSH H26, H23, H5
    SQRDMLSH S2, S9, S26
    SQRDMLAH H16, H6, H4
    SQRDMLAH S15, S16, S17
    SQRDMLAH S30, S15, V2.S[0x0]
    SQRDMLAH H1, H24, H22
    SQRDMLSH H3, H0, H29
    SQRDMLAH H14, H7, H24
    SQRDMLAH S26, S25, S31
    SQRDMLSH H16, H0, V11.H[0x5]
    SQRDMLAH H28, H0, H25
    SQRDMLSH H24, H1, H23
    SQRDMLSH S20, S6, V30.S[0x1]
    SQRDMLSH H31, H18, V13.H[0x3]
    SQRDMLSH H10, H3, V14.H[0x4]
    SQRDMLSH S30, S10, V26.S[0x0]
    SQRDMLSH S0, S1, V28.S[0x1]
    SQRDMLSH S22, S31, S21
    SQRDMLAH S11, S24, S0
    SQRDMLAH H14, H2, H7
    SQRDMLSH H30, H22, V14.H[0x7]
    SQRDMLSH H0, H28, H16
    SQRDMLSH S21, S0, V15.S[0x1]
    SQRDMLAH S24, S20, V27.S[0x0]
    SQRDMLSH H26, H21, V2.H[0x3]
    SQRDMLAH S0, S11, V14.S[0x1]
    SQRDMLSH S20, S24, S30
    SQRDMLSH H1, H26, V0.H[0x4]
    SQRDMLAH H18, H23, V12.H[0x1]
    SQRDMLSH H24, H25, V14.H[0x0]
    SQRDMLAH S31, S28, V6.S[0x3]
    SQRDMLSH H15, H22, H16
    SQRDMLSH H28, H1, V10.H[0x7]
    SQRDMLSH H12, H3, V15.H[0x2]
    SQRDMLAH S0, S29, V21.S[0x3]
    SQRDMLAH S30, S28, S10
    SQRDMLSH S15, S24, S25
    SQRDMLSH H28, H15, V8.H[0x2]
    SQRDMLSH S27, S30, V26.S[0x3]
    SQRDMLSH S4, S29, V6.S[0x0]
    SQRDMLAH H22, H2, H9
    SQRDMLAH S1, S4, S4
    SQRDMLAH H7, H27, V12.H[0x6]
    SQRDMLAH S26, S22, S20
    SQRDMLAH S4, S26, S5
    SQRDMLSH S30, S1, V1.S[0x3]
    SQRDMLSH H12, H0, V7.H[0x5]
    SQRDMLAH S23, S28, S12
    SQRDMLSH H3, H27, V3.H[0x4]
    SQRDMLAH H3, H23, H4
    SQRDMLAH H18, H31, V3.H[0x7]
    SQRDMLAH H4, H17, H4
    SQRDMLSH S5, S25, V0.S[0x0]
    SQRDMLSH H6, H22, V2.H[0x6]
    SQRDMLSH H28, H9, H31
    SQRDMLSH H2, H3, H16
    SQRDMLAH H26, H3, H4
    SQRDMLSH S14, S23, S31
    SQRDMLAH H3, H17, H5
    SQRDMLSH H9, H27, V14.H[0x2]
    SQRDMLAH H17, H28, H27
    SQRDMLAH H12, H17, H2
    SQRDMLSH H24, H19, H10
    SQRDMLSH H28, H28, V15.H[0x7]
    SQRDMLAH H27, H24, V15.H[0x2]
    SQRDMLSH S16, S6, S19
    SQRDMLSH S24, S27, V9.S[0x0]
    SQRDMLAH S0, S0, V30.S[0x3]
    SQRDMLSH S31, S18, V16.S[0x2]
    SQRDMLAH H17, H28, H12
    SQRDMLAH H12, H0, V1.H[0x6]
    SQRDMLAH H27, H17, V12.H[0x5]
    SQRDMLSH H9, H27, V3.H[0x1]
    SQRDMLSH H12, H9, V9.H[0x2]
    SQRDMLSH S7, S4, V0.S[0x2]
    SQRDMLAH S8, S24, S7
    SUBS  X14, X14, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_8
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X12, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdScalarRDM_TestFail
    MRS  X21, FPSR
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x800, LSL #16
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D0
    MOVZ  X12, #0x5b1d, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D1
    MOVZ  X12, #0x8001, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D2
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D3
    MOVZ  X12, #0xa210, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D4
    MOVZ  X12, #0x8000, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D5
    MOVZ  X12, #0x9e72, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D6
    MOVZ  X12, #0x5a5a, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D7
    MOVZ  X12, #0x2e4e, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D8
    MOVZ  X12, #0x8000, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D9
    MOVZ  X12, #0x8000, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D10
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D11
    MOVZ  X12, #0x5a5b, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D12
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D13
    MOVZ  X12, #0x8000, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D14
    MOVZ  X12, #0x4038, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D15
    MOVZ  X12, #0xf956, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D16
    MOVZ  X12, #0x8000, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D17
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D18
    MOVZ  X12, #0x50f4, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D19
    MOVZ  X12, #0x8000, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D20
    MOVZ  X12, #0x2530, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D21
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D22
    MOVZ  X12, #0x8000, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D23
    MOVZ  X12, #0x5a5e, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D24
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D25
    MOVZ  X12, #0xc037, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D26
    MOVZ  X12, #0x8000, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D27
    MOVZ  X12, #0x25a4, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D28
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D29
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D30
    MOVZ  X12, #0x704f, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X21, D31
    MOVZ  X12, #0x5a5a, LSL #0
    SUB  X22, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X7
    FMOV  D1, X10
    FMOV  V1.D[1], X18
    FMOV  D2, X21
    FMOV  V2.D[1], X25
    FMOV  D3, X10
    FMOV  V3.D[1], X22
    FMOV  D4, X19
    FMOV  V4.D[1], X14
    FMOV  D5, X7
    FMOV  V5.D[1], X4
    FMOV  D6, X25
    FMOV  V6.D[1], X25
    FMOV  D7, X17
    FMOV  V7.D[1], X10
    FMOV  D8, X22
    FMOV  V8.D[1], X4
    FMOV  D9, X19
    FMOV  V9.D[1], X3
    FMOV  D10, X25
    FMOV  V10.D[1], X7
    FMOV  D11, X9
    FMOV  V11.D[1], X14
    FMOV  D12, X11
    FMOV  V12.D[1], X21
    FMOV  D13, X23
    FMOV  V13.D[1], X25
    FMOV  D14, X20
    FMOV  V14.D[1], X7
    FMOV  D15, X6
    FMOV  V15.D[1], X19
    FMOV  D16, X15
    FMOV  V16.D[1], X9
    FMOV  D17, X6
    FMOV  V17.D[1], X19
    FMOV  D18, X14
    FMOV  V18.D[1], X19
    FMOV  D19, X23
    FMOV  V19.D[1], X23
    FMOV  D20, X6
    FMOV  V20.D[1], X25
    FMOV  D21, X12
    FMOV  V21.D[1], X7
    FMOV  D22, X3
    FMOV  V22.D[1], X23
    FMOV  D23, X5
    FMOV  V23.D[1], X22
    FMOV  D24, X16
    FMOV  V24.D[1], X11
    FMOV  D25, X14
    FMOV  V25.D[1], X11
    FMOV  D26, X22
    FMOV  V26.D[1], X14
    FMOV  D27, X19
    FMOV  V27.D[1], X8
    FMOV  D28, X23
    FMOV  V28.D[1], X3
    FMOV  D29, X2
    FMOV  V29.D[1], X2
    FMOV  D30, X18
    FMOV  V30.D[1], X12
    FMOV  D31, X6
    FMOV  V31.D[1], X21
    MOVZ  X15, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_9:
    SQRDMLSH H12, H28, H23
    SQRDMLAH H8, H22, V3.H[0x4]
    SQRDMLAH S13, S26, V26.S[0x2]
    SQRDMLSH S18, S12, S26
    SQRDMLAH H7, H8, V8.H[0x5]
    SQRDMLSH S31, S27, S12
    SQRDMLAH S24, S11, V9.S[0x1]
    SQRDMLAH H25, H30, H31
    SQRDMLSH H19, H20, V13.H[0x4]
    SQRDMLAH H12, H0, V9.H[0x7]
    SQRDMLSH H27, H7, V10.H[0x1]
    SQRDMLAH S26, S18, V27.S[0x2]
    SQRDMLAH H23, H29, H25
    SQRDMLSH S3, S24, S23
    SQRDMLAH S10, S26, V12.S[0x2]
    SQRDMLSH H19, H1, V12.H[0x0]
    SQRDMLAH H18, H19, H18
    SQRDMLAH H28, H10, H11
    SQRDMLAH S18, S3, S3
    SQRDMLSH S24, S16, S26
    SQRDMLSH S9, S18, S11
    SQRDMLAH H23, H31, H22
    SQRDMLSH H18, H27, V10.H[0x5]
    SQRDMLAH H29, H21, H28
    SQRDMLSH S7, S26, S11
    SQRDMLSH S10, S10, S28
    SQRDMLAH H31, H6, V15.H[0x2]
    SQRDMLAH S22, S16, V2.S[0x3]
    SQRDMLSH S3, S7, S22
    SQRDMLSH H14, H24, H6
    SQRDMLAH S12, S3, S14
    SQRDMLAH S28, S18, V31.S[0x1]
    SQRDMLAH H14, H29, H18
    SQRDMLSH S11, S14, V12.S[0x0]
    SQRDMLAH S19, S9, S28
    SQRDMLSH S31, S23, S22
    SQRDMLAH S19, S10, V10.S[0x2]
    SQRDMLSH H9, H21, H19
    SQRDMLSH S24, S31, V10.S[0x1]
    SQRDMLSH H29, H11, V1.H[0x7]
    SQRDMLSH H3, H1, V9.H[0x5]
    SQRDMLSH S25, S3, S29
    SQRDMLSH S2, S12, V22.S[0x3]
    SQRDMLSH S6, S13, S6
    SQRDMLAH H14, H1, H11
    SQRDMLAH S12, S31, V9.S[0x0]
    SQRDMLSH H31, H28, H5
    SQRDMLSH S16, S27, V17.S[0x2]
    SQRDMLSH S1, S31, V3.S[0x1]
    SQRDMLSH H5, H13, V9.H[0x2]
    SQRDMLAH S18, S24, V6.S[0x1]
    SQRDMLAH H21, H17, H18
    SQRDMLSH S22, S23, S25
    SQRDMLSH H13, H15, V12.H[0x1]
    SQRDMLSH H9, H2, V13.H[0x3]
    SQRDMLSH S15, S21, S16
    SQRDMLAH S27, S15, V15.S[0x3]
    SQRDMLAH S28, S14, S11
    SQRDMLAH H29, H9, H27
    SQRDMLAH S15, S26, S29
    SQRDMLSH S21, S5, S10
    SQRDMLAH S24, S22, S1
    SQRDMLSH H16, H10, V9.H[0x3]
    SQRDMLSH S22, S19, V15.S[0x1]
    SQRDMLAH S23, S22, V12.S[0x1]
    SQRDMLSH S1, S24, V23.S[0x3]
    SQRDMLSH H27, H1, V9.H[0x1]
    SQRDMLAH S17, S27, S21
    SQRDMLSH H1, H17, H14
    SQRDMLAH S29, S12, S20
    SQRDMLAH S2, S1, V1.S[0x2]
    SQRDMLAH S5, S16, S29
    SQRDMLSH S22, S28, V11.S[0x2]
    SQRDMLSH H25, H5, H5
    SQRDMLSH H26, H22, H8
    SQRDMLSH H10, H2, V2.H[0x4]
    SQRDMLSH S29, S6, S10
    SQRDMLSH S30, S27, V25.S[0x1]
    SQRDMLSH S6, S12, S10
    SQRDMLAH S31, S29, S10
    SQRDMLAH H24, H31, V6.H[0x5]
    SQRDMLSH H10, H26, H19
    SQRDMLSH H16, H6, V5.H[0x2]
    SQRDMLSH S5, S24, V30.S[0x1]
    SQRDMLAH H19, H0, H23
    SQRDMLSH H30, H10, H18
    SQRDMLSH H29, H22, V3.H[0x5]
    SQRDMLSH S2, S30, V16.S[0x1]
    SQRDMLAH S11, S10, S29
    SQRDMLSH H26, H19, H26
    SQRDMLSH H5, H26, H2
    SQRDMLAH S16, S8, V19.S[0x2]
    SQRDMLSH S8, S21, S28
    SQRDMLSH H2, H8, V13.H[0x0]
    SQRDMLSH S27, S20, S20
    SQRDMLSH H24, H1, H31
    SQRDMLSH S30, S13, V19.S[0x3]
    SQRDMLAH S0, S18, V21.S[0x0]
    SQRDMLAH S21, S6, V2.S[0x3]
    SQRDMLAH S25, S6, V20.S[0x1]
    SQRDMLSH S31, S11, V5.S[0x1]
    SQRDMLAH S26, S31, V0.S[0x2]
    SQRDMLAH H16, H16, V2.H[0x5]
    SQRDMLAH H31, H28, V8.H[0x0]
    SQRDMLSH S3, S12, S22
    SQRDMLAH H27, H28, V0.H[0x6]
    SQRDMLAH S1, S25, S21
    SQRDMLAH H18, H27, V15.H[0x4]
    SQRDMLSH S5, S31, S18
    SQRDMLSH S22, S24, V3.S[0x0]
    SQRDMLAH H13, H30, V5.H[0x4]
    SQRDMLSH H0, H26, V9.H[0x4]
    SQRDMLSH H5, H20, V0.H[0x4]
    SQRDMLAH H20, H23, H22
    SQRDMLAH S19, S20, V4.S[0x0]
    SQRDMLSH H26, H27, V7.H[0x0]
    SQRDMLSH H27, H4, V1.H[0x6]
    SQRDMLAH H15, H27, V7.H[0x1]
    SQRDMLSH H20, H19, V5.H[0x0]
    SQRDMLAH H11, H30, H16
    SQRDMLAH S7, S11, S11
    SQRDMLSH S0, S7, V0.S[0x3]
    SQRDMLAH S5, S8, V20.S[0x1]
    SQRDMLSH S19, S5, V13.S[0x2]
    SQRDMLSH S9, S15, V25.S[0x1]
    SQRDMLAH H4, H26, V9.H[0x2]
    SQRDMLSH S6, S23, V0.S[0x0]
    SQRDMLSH S31, S14, V6.S[0x3]
    SQRDMLAH H27, H19, H22
    SQRDMLSH H11, H27, H16
    SQRDMLAH S9, S4, V31.S[0x1]
    SQRDMLAH H20, H17, V4.H[0x1]
    SQRDMLAH S15, S15, V17.S[0x2]
    SQRDMLAH S21, S22, S19
    SQRDMLAH S21, S14, S22
    SQRDMLSH S27, S12, V0.S[0x1]
    SQRDMLSH S14, S16, V20.S[0x0]
    SQRDMLSH H6, H8, H24
    SQRDMLAH S4, S28, S10
    SQRDMLSH H5, H23, V8.H[0x2]
    SQRDMLAH S13, S9, S27
    SQRDMLAH H27, H14, V15.H[0x3]
    SQRDMLAH H26, H19, H27
    SQRDMLAH H20, H26, V9.H[0x3]
    SQRDMLSH S15, S20, V19.S[0x0]
    SQRDMLAH H8, H11, H11
    SQRDMLAH S11, S4, S6
    SQRDMLAH H24, H8, H5
    SQRDMLAH S7, S11, V21.S[0x1]
    SQRDMLSH S17, S13, S11
    SQRDMLSH S6, S23, V24.S[0x3]
    SQRDMLSH H20, H26, H15
    SQRDMLAH H10, H7, V6.H[0x4]
    SQRDMLSH S21, S20, V4.S[0x2]
    SQRDMLAH H23, H17, H3
    SQRDMLSH S7, S12, V21.S[0x1]
    SQRDMLAH S24, S5, V6.S[0x2]
    SQRDMLSH H13, H10, H15
    SQRDMLAH H12, H30, H13
    SQRDMLAH S19, S22, V12.S[0x2]
    SQRDMLSH H9, H23, H19
    SQRDMLAH S6, S29, V0.S[0x3]
    SQRDMLAH H26, H6, H7
    SQRDMLSH H17, H16, V9.H[0x1]
    SQRDMLSH H22, H4, V8.H[0x4]
    SQRDMLAH H12, H26, V13.H[0x2]
    SQRDMLAH S29, S9, V28.S[0x3]
    SQRDMLSH S19, S2, S24
    SQRDMLAH H11, H8, H4
    SQRDMLSH H20, H29, V11.H[0x5]
    SQRDMLAH H10, H20, H10
    SQRDMLSH H28, H10, V14.H[0x3]
    SQRDMLSH H9, H22, H17
    SQRDMLAH S8, S9, V12.S[0x3]
    SQRDMLSH S18, S19, V4.S[0x1]
    SQRDMLAH H3, H28, H19
    SQRDMLAH S19, S28, V3.S[0x0]
    SQRDMLSH S3, S19, S29
    SQRDMLAH H16, H8, H25
    SQRDMLAH H20, H3, H24
    SQRDMLSH S25, S17, S20
    SQRDMLAH S6, S28, V16.S[0x3]
    SQRDMLAH H4, H18, V4.H[0x2]
    SQRDMLAH H9, H5, H25
    SQRDMLSH H28, H0, V4.H[0x0]
    SQRDMLAH H8, H20, H28
    SQRDMLAH H22, H19, H23
    SQRDMLAH H14, H9, V8.H[0x3]
    SQRDMLSH H25, H30, H6
    SQRDMLAH H8, H14, V6.H[0x3]
    SQRDMLAH H7, H29, H25
    SQRDMLAH H4, H8, V11.H[0x5]
    SQRDMLSH H5, H26, V9.H[0x0]
    SQRDMLSH S23, S4, S5
    SQRDMLAH S17, S17, V30.S[0x3]
    SQRDMLAH S8, S21, V7.S[0x0]
    SQRDMLSH S26, S11, V17.S[0x0]
    SQRDMLSH H6, H9, V12.H[0x1]
    SQRDMLAH S2, S10, V22.S[0x0]
    SQRDMLAH S18, S8, S2
    SUBS  X15, X15, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_9
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X8, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    MRS  X17, FPSR
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x800, LSL #16
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D0
    MOVZ  X8, #0xa5a7, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D1
    MOVZ  X8, #0x8001, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D2
    MOVZ  X8, #0x7fff, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D3
    MOVZ  X8, #0x7ffe, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D4
    MOVZ  X8, #0xa5a8, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D5
    MOVZ  X8, #0x7fff, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D6
    MOVZ  X8, #0xf849, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D7
    MOVZ  X8, #0x39f, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D8
    MOVZ  X8, #0x3f61, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D9
    MOVZ  X8, #0xcf9a, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D10
    MOVZ  X8, #0x1035, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D11
    MOVZ  X8, #0x8000, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D12
    MOVZ  X8, #0x4d1e, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D13
    MOVZ  X8, #0x8000, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D14
    MOVZ  X8, #0xa05c, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D15
    MOVZ  X8, #0x7ff2, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D16
    MOVZ  X8, #0x8000, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D17
    MOVZ  X8, #0xa5a5, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D18
    MOVZ  X8, #0xffff, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D19
    MOVZ  X8, #0x8065, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D20
    MOVZ  X8, #0x409e, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D21
    MOVZ  X8, #0xeea8, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D22
    MOVZ  X8, #0x6f3e, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D23
    MOVZ  X8, #0xdc8b, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D24
    MOVZ  X8, #0x7fff, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D25
    MOVZ  X8, #0x8000, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D26
    MOVZ  X8, #0x670d, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D27
    MOVZ  X8, #0x8000, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D28
    MOVZ  X8, #0x8000, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D29
    MOVZ  X8, #0x8001, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D30
    MOVZ  X8, #0x9c64, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X17, D31
    MOVZ  X8, #0x9104, LSL #0
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X2, #0x10ba, LSL #0
    MOVK  X2, #0x28d8, LSL #16
    MOVK  X2, #0x2aa5, LSL #32
    MOVK  X2, #0xba48, LSL #48
    MOVZ  X3, #0x321d, LSL #0
    MOVK  X3, #0x6a6a, LSL #16
    MOVK  X3, #0x1e23, LSL #32
    MOVK  X3, #0xe592, LSL #48
    MOVZ  X4, #0x1f79, LSL #0
    MOVK  X4, #0x5a48, LSL #16
    MOVK  X4, #0x5908, LSL #32
    MOVK  X4, #0x27ea, LSL #48
    MOVZ  X5, #0xa2c8, LSL #0
    MOVK  X5, #0x4bec, LSL #16
    MOVK  X5, #0x1950, LSL #32
    MOVK  X5, #0x807f, LSL #48
    MOVZ  X6, #0xbc42, LSL #0
    MOVK  X6, #0x393a, LSL #16
    MOVK  X6, #0xd57a, LSL #32
    MOVK  X6, #0x2652, LSL #48
    MOVZ  X7, #0x121, LSL #0
    MOVK  X7, #0x20b4, LSL #16
    MOVK  X7, #0xccb4, LSL #32
    MOVK  X7, #0xe5c1, LSL #48
    MOVZ  X8, #0x2a4a, LSL #0
    MOVK  X8, #0xd451, LSL #16
    MOVK  X8, #0x8aff, LSL #32
    MOVK  X8, #0xf644, LSL #48
    MOVZ  X9, #0x1dee, LSL #0
    MOVK  X9, #0x148f, LSL #16
    MOVK  X9, #0x121, LSL #32
    MOVK  X9, #0x28c0, LSL #48
    MOVZ  X10, #0xa06c, LSL #0
    MOVK  X10, #0x5885, LSL #16
    MOVK  X10, #0x468d, LSL #32
    MOVK  X10, #0x35fe, LSL #48
    MOVZ  X11, #0x9d83, LSL #0
    MOVK  X11, #0xd9c0, LSL #16
    MOVK  X11, #0x7806, LSL #32
    MOVK  X11, #0x2f12, LSL #48
    MOVZ  X12, #0x7ea1, LSL #0
    MOVK  X12, #0xd09e, LSL #16
    MOVK  X12, #0xbbc1, LSL #32
    MOVK  X12, #0x837b, LSL #48
    MOVZ  X13, #0x547f, LSL #0
    MOVK  X13, #0x3d3d, LSL #16
    MOVK  X13, #0xdf, LSL #32
    MOVK  X13, #0x10c1, LSL #48
    MOVZ  X14, #0xd475, LSL #0
    MOVK  X14, #0x992e, LSL #16
    MOVK  X14, #0x7672, LSL #32
    MOVK  X14, #0xdbe5, LSL #48
    MOVZ  X15, #0x9a3b, LSL #0
    MOVK  X15, #0x9c3a, LSL #16
    MOVK  X15, #0x9765, LSL #32
    MOVK  X15, #0xd640, LSL #48
    MOVZ  X16, #0xa0fd, LSL #0
    MOVK  X16, #0xd06a, LSL #16
    MOVK  X16, #0x938c, LSL #32
    MOVK  X16, #0x5b04, LSL #48
    MOVZ  X17, #0x8087, LSL #0
    MOVK  X17, #0x7810, LSL #16
    MOVK  X17, #0xc980, LSL #32
    MOVK  X17, #0x83e5, LSL #48
    MOVZ  X18, #0xfd9e, LSL #0
    MOVK  X18, #0x24a2, LSL #16
    MOVK  X18, #0x5a72, LSL #32
    MOVK  X18, #0x75f6, LSL #48
    MOVZ  X19, #0x269, LSL #0
    MOVK  X19, #0xaad9, LSL #16
    MOVK  X19, #0xa819, LSL #32
    MOVK  X19, #0xe4c6, LSL #48
    MOVZ  X20, #0x51e9, LSL #0
    MOVK  X20, #0xad33, LSL #16
    MOVK  X20, #0xf5c7, LSL #32
    MOVK  X20, #0x29e9, LSL #48
    MOVZ  X21, #0x96ab, LSL #0
    MOVK  X21, #0x6048, LSL #16
    MOVK  X21, #0x3a91, LSL #32
    MOVK  X21, #0xb10f, LSL #48
    MOVZ  X22, #0xf710, LSL #0
    MOVK  X22, #0x8cbd, LSL #16
    MOVK  X22, #0x1642, LSL #32
    MOVK  X22, #0xac88, LSL #48
    MOVZ  X23, #0x6fad, LSL #0
    MOVK  X23, #0xd05b, LSL #16
    MOVK  X23, #0xbd6f, LSL #32
    MOVK  X23, #0xdcd6, LSL #48
    MOVZ  X25, #0x831b, LSL #0
    MOVK  X25, #0xf9a, LSL #16
    MOVK  X25, #0x511, LSL #32
    MOVK  X25, #0xb0b2, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X20
    FMOV  D1, X21
    FMOV  V1.D[1], X19
    FMOV  D2, X18
    FMOV  V2.D[1], X13
    FMOV  D3, X4
    FMOV  V3.D[1], X22
    FMOV  D4, X18
    FMOV  V4.D[1], X13
    FMOV  D5, X5
    FMOV  V5.D[1], X23
    FMOV  D6, X25
    FMOV  V6.D[1], X2
    FMOV  D7, X17
    FMOV  V7.D[1], X21
    FMOV  D8, X10
    FMOV  V8.D[1], X19
    FMOV  D9, X15
    FMOV  V9.D[1], X4
    FMOV  D10, X23
    FMOV  V10.D[1], X17
    FMOV  D11, X9
    FMOV  V11.D[1], X11
    FMOV  D12, X2
    FMOV  V12.D[1], X15
    FMOV  D13, X2
    FMOV  V13.D[1], X11
    FMOV  D14, X7
    FMOV  V14.D[1], X21
    FMOV  D15, X16
    FMOV  V15.D[1], X25
    FMOV  D16, X12
    FMOV  V16.D[1], X10
    FMOV  D17, X3
    FMOV  V17.D[1], X11
    FMOV  D18, X13
    FMOV  V18.D[1], X19
    FMOV  D19, X15
    FMOV  V19.D[1], X9
    FMOV  D20, X20
    FMOV  V20.D[1], X25
    FMOV  D21, X6
    FMOV  V21.D[1], X8
    FMOV  D22, X14
    FMOV  V22.D[1], X3
    FMOV  D23, X16
    FMOV  V23.D[1], X20
    FMOV  D24, X25
    FMOV  V24.D[1], X19
    FMOV  D25, X4
    FMOV  V25.D[1], X10
    FMOV  D26, X12
    FMOV  V26.D[1], X18
    FMOV  D27, X12
    FMOV  V27.D[1], X15
    FMOV  D28, X14
    FMOV  V28.D[1], X5
    FMOV  D29, X22
    FMOV  V29.D[1], X22
    FMOV  D30, X10
    FMOV  V30.D[1], X11
    FMOV  D31, X14
    FMOV  V31.D[1], X3
    MOVZ  X2, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_10:
    SQRDMLSH H6, H24, H26
    SQRDMLSH S13, S23, S6
    SQRDMLAH H9, H18, H30
    SQRDMLAH S7, S28, V27.S[0x0]
    SQRDMLAH H15, H7, V9.H[0x1]
    SQRDMLSH S9, S13, S13
    SQRDMLSH S12, S31, S15
    SQRDMLSH H19, H9, H2
    SQRDMLSH H30, H12, V5.H[0x3]
    SQRDMLSH S23, S19, V30.S[0x1]
    SQRDMLSH S2, S25, V29.S[0x3]
    SQRDMLAH H28, H2, H2
    SQRDMLSH S9, S28, S23
    SQRDMLAH H5, H12, H21
    SQRDMLAH S28, S16, S7
    SQRDMLAH H11, H10, V1.H[0x7]
    SQRDMLSH S1, S24, V29.S[0x2]
    SQRDMLSH S16, S22, V21.S[0x1]
    SQRDMLAH S24, S29, V10.S[0x2]
    SQRDMLAH H27, H23, H21
    SQRDMLAH H13, H23, H31
    SQRDMLAH H21, H13, H8
    SQRDMLAH S23, S5, V1.S[0x3]
    SQRDMLAH S27, S24, V21.S[0x3]
    SQRDMLSH H15, H27, V9.H[0x0]
    SQRDMLAH S12, S16, V29.S[0x0]
    SQRDMLSH S24, S8, S25
    SQRDMLAH H27, H26, H15
    SQRDMLAH H9, H28, H24
    SQRDMLSH S26, S11, V9.S[0x2]
    SQRDMLSH S7, S27, S10
    SQRDMLSH S2, S26, V23.S[0x3]
    SQRDMLSH S5, S2, S7
    SQRDMLSH H24, H13, V11.H[0x0]
    SQRDMLSH H16, H27, V0.H[0x0]
    SQRDMLSH S23, S1, S29
    SQRDMLSH S8, S24, S18
    SQRDMLAH S9, S12, S16
    SQRDMLSH S27, S11, S25
    SQRDMLSH S2, S14, S24
    SQRDMLSH S10, S29, V19.S[0x0]
    SQRDMLSH H19, H10, V9.H[0x7]
    SQRDMLAH H22, H11, V7.H[0x5]
    SQRDMLSH H18, H31, H1
    SQRDMLSH S14, S1, S17
    SQRDMLAH S29, S5, S19
    SQRDMLSH H22, H14, H27
    SQRDMLSH H19, H18, H18
    SQRDMLAH S17, S29, V8.S[0x3]
    SQRDMLAH S13, S23, S0
    SQRDMLSH H15, H24, H22
    SQRDMLAH S18, S15, S7
    SQRDMLAH S0, S13, V13.S[0x3]
    SQRDMLSH S13, S2, V19.S[0x0]
    SQRDMLAH H8, H13, H28
    SQRDMLSH H0, H5, H18
    SQRDMLSH H13, H10, H0
    SQRDMLSH S31, S13, V8.S[0x1]
    SQRDMLSH H9, H7, H6
    SQRDMLSH S22, S11, S19
    SQRDMLSH H11, H26, V3.H[0x5]
    SQRDMLAH S24, S4, S27
    SQRDMLSH S28, S17, S12
    SQRDMLAH S1, S6, S7
    SQRDMLSH S26, S3, S28
    SQRDMLSH S15, S25, S28
    SQRDMLAH S2, S16, V7.S[0x2]
    SQRDMLAH S19, S24, S27
    SQRDMLSH H4, H22, H31
    SQRDMLSH H0, H1, V4.H[0x4]
    SQRDMLSH S27, S7, V3.S[0x3]
    SQRDMLSH S16, S0, S15
    SQRDMLAH S22, S26, V28.S[0x2]
    SQRDMLAH S14, S27, V2.S[0x1]
    SQRDMLSH H24, H16, V14.H[0x1]
    SQRDMLAH H1, H19, V3.H[0x0]
    SQRDMLSH H6, H22, H24
    SQRDMLSH H0, H11, H2
    SQRDMLAH S3, S1, V19.S[0x0]
    SQRDMLSH S13, S0, S23
    SQRDMLSH S19, S3, S13
    SQRDMLAH S15, S6, S23
    SQRDMLSH S25, S10, S18
    SQRDMLAH S12, S13, S19
    SQRDMLAH H23, H15, V4.H[0x2]
    SQRDMLAH S14, S24, S22
    SQRDMLAH H3, H14, V2.H[0x3]
    SQRDMLSH H27, H25, V5.H[0x4]
    SQRDMLAH S18, S8, V12.S[0x2]
    SQRDMLSH S7, S31, V20.S[0x3]
    SQRDMLSH H19, H23, V6.H[0x0]
    SQRDMLSH H18, H2, H3
    SQRDMLSH H24, H11, H20
    SQRDMLSH H22, H24, H7
    SQRDMLSH S20, S8, S4
    SQRDMLAH S1, S17, V6.S[0x2]
    SQRDMLSH H10, H18, H24
    SQRDMLSH H0, H20, H27
    SQRDMLSH H4, H14, H22
    SQRDMLAH S20, S19, S4
    SQRDMLAH H31, H1, H1
    SQRDMLAH S16, S10, V0.S[0x3]
    SQRDMLSH S1, S21, V20.S[0x1]
    SQRDMLSH H6, H16, H22
    SQRDMLSH H0, H21, H15
    SQRDMLAH S19, S27, S0
    SQRDMLAH S7, S19, S19
    SQRDMLAH S15, S0, S17
    SQRDMLSH H18, H6, H18
    SQRDMLAH H13, H31, V14.H[0x7]
    SQRDMLAH S24, S10, S7
    SQRDMLSH S6, S23, S15
    SQRDMLSH H21, H16, H9
    SQRDMLAH S19, S10, S21
    SQRDMLSH H27, H27, V2.H[0x0]
    SQRDMLAH S5, S18, V30.S[0x2]
    SQRDMLAH H4, H15, V9.H[0x0]
    SQRDMLAH H20, H0, V13.H[0x3]
    SQRDMLAH S9, S17, S18
    SQRDMLSH H22, H2, V1.H[0x2]
    SQRDMLAH S10, S17, V6.S[0x0]
    SQRDMLSH S18, S24, V26.S[0x2]
    SQRDMLAH H16, H26, V8.H[0x4]
    SQRDMLAH S0, S18, V16.S[0x2]
    SQRDMLSH H20, H19, V10.H[0x2]
    SQRDMLSH H7, H9, H24
    SQRDMLAH S19, S22, S7
    SQRDMLAH S18, S8, S27
    SQRDMLSH H6, H18, H14
    SQRDMLSH S31, S4, V10.S[0x1]
    SQRDMLAH H16, H20, V10.H[0x5]
    SQRDMLSH H23, H19, H5
    SQRDMLAH H26, H10, H6
    SQRDMLSH S17, S27, V0.S[0x0]
    SQRDMLAH H9, H14, H19
    SQRDMLSH H30, H23, H17
    SQRDMLAH H5, H15, H14
    SQRDMLAH H8, H26, V10.H[0x3]
    SQRDMLAH S20, S19, V9.S[0x3]
    SQRDMLAH S4, S29, V16.S[0x0]
    SQRDMLSH H29, H16, H30
    SQRDMLAH H26, H1, H0
    SQRDMLSH S15, S7, S4
    SQRDMLSH H30, H5, V8.H[0x1]
    SQRDMLAH S8, S29, V7.S[0x0]
    SQRDMLSH S19, S8, V20.S[0x3]
    SQRDMLSH S14, S30, S30
    SQRDMLAH S17, S14, S5
    SQRDMLSH H0, H27, V15.H[0x0]
    SQRDMLAH S1, S19, S31
    SQRDMLAH S23, S0, V15.S[0x0]
    SQRDMLSH H24, H30, H23
    SQRDMLAH H19, H13, V15.H[0x6]
    SQRDMLAH S20, S19, V19.S[0x1]
    SQRDMLAH H0, H20, V12.H[0x5]
    SQRDMLAH H13, H24, V8.H[0x1]
    SQRDMLSH S31, S17, S17
    SQRDMLSH H27, H1, H11
    SQRDMLSH H19, H31, V13.H[0x7]
    SQRDMLSH S8, S30, S10
    SQRDMLSH H23, H0, H27
    SQRDMLAH S1, S4, V26.S[0x3]
    SQRDMLAH S25, S21, S0
    SQRDMLAH H9, H8, V1.H[0x0]
    SQRDMLAH H5, H23, V9.H[0x0]
    SQRDMLSH H7, H5, V3.H[0x0]
    SQRDMLAH S20, S19, S25
    SQRDMLAH H17, H9, V8.H[0x4]
    SQRDMLAH S14, S12, S25
    SQRDMLAH S29, S25, S13
    SQRDMLSH S8, S5, S1
    SQRDMLAH H1, H25, H12
    SQRDMLAH S0, S30, V30.S[0x0]
    SQRDMLAH S3, S20, S24
    SQRDMLSH H4, H22, V12.H[0x6]
    SQRDMLSH H27, H14, V4.H[0x3]
    SQRDMLSH S24, S30, V18.S[0x3]
    SQRDMLSH H10, H29, H3
    SQRDMLSH S29, S10, S10
    SQRDMLAH H13, H4, H17
    SQRDMLAH H30, H1, H0
    SQRDMLAH H20, H13, V7.H[0x7]
    SQRDMLSH S18, S20, V8.S[0x2]
    SQRDMLAH H21, H30, V2.H[0x5]
    SQRDMLSH H4, H31, V13.H[0x4]
    SQRDMLSH H14, H18, V3.H[0x1]
    SQRDMLSH S18, S4, V4.S[0x0]
    SQRDMLAH S17, S18, S14
    SQRDMLAH H19, H15, V10.H[0x5]
    SQRDMLSH H31, H0, H9
    SQRDMLAH H2, H19, V14.H[0x6]
    SQRDMLSH S31, S29, V29.S[0x3]
    SQRDMLAH S22, S5, V2.S[0x2]
    SQRDMLAH S14, S21, V4.S[0x2]
    SQRDMLSH S2, S27, V13.S[0x3]
    SQRDMLAH S3, S22, V22.S[0x3]
    SQRDMLSH H15, H26, V13.H[0x2]
    SQRDMLAH H26, H28, V2.H[0x3]
    SQRDMLAH S13, S29, S17
    SQRDMLAH H29, H15, V14.H[0x7]
    SUBS  X2, X2, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_10
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x321d, LSL #0
    MOVK  X16, #0x6a6a, LSL #16
    MOVK  X16, #0x1e23, LSL #32
    MOVK  X16, #0xe592, LSL #48
    SUB  X19, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x1f79, LSL #0
    MOVK  X16, #0x5a48, LSL #16
    MOVK  X16, #0x5908, LSL #32
    MOVK  X16, #0x27ea, LSL #48
    SUB  X19, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xa2c8, LSL #0
    MOVK  X16, #0x4bec, LSL #16
    MOVK  X16, #0x1950, LSL #32
    MOVK  X16, #0x807f, LSL #48
    SUB  X19, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xbc42, LSL #0
    MOVK  X16, #0x393a, LSL #16
    MOVK  X16, #0xd57a, LSL #32
    MOVK  X16, #0x2652, LSL #48
    SUB  X19, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x121, LSL #0
    MOVK  X16, #0x20b4, LSL #16
    MOVK  X16, #0xccb4, LSL #32
    MOVK  X16, #0xe5c1, LSL #48
    SUB  X19, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x1dee, LSL #0
    MOVK  X16, #0x148f, LSL #16
    MOVK  X16, #0x121, LSL #32
    MOVK  X16, #0x28c0, LSL #48
    SUB  X19, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xa06c, LSL #0
    MOVK  X16, #0x5885, LSL #16
    MOVK  X16, #0x468d, LSL #32
    MOVK  X16, #0x35fe, LSL #48
    SUB  X19, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x9d83, LSL #0
    MOVK  X16, #0xd9c0, LSL #16
    MOVK  X16, #0x7806, LSL #32
    MOVK  X16, #0x2f12, LSL #48
    SUB  X19, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x7ea1, LSL #0
    MOVK  X16, #0xd09e, LSL #16
    MOVK  X16, #0xbbc1, LSL #32
    MOVK  X16, #0x837b, LSL #48
    SUB  X19, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x547f, LSL #0
    MOVK  X16, #0x3d3d, LSL #16
    MOVK  X16, #0xdf, LSL #32
    MOVK  X16, #0x10c1, LSL #48
    SUB  X19, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xd475, LSL #0
    MOVK  X16, #0x992e, LSL #16
    MOVK  X16, #0x7672, LSL #32
    MOVK  X16, #0xdbe5, LSL #48
    SUB  X19, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x9a3b, LSL #0
    MOVK  X16, #0x9c3a, LSL #16
    MOVK  X16, #0x9765, LSL #32
    MOVK  X16, #0xd640, LSL #48
    SUB  X19, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x8087, LSL #0
    MOVK  X16, #0x7810, LSL #16
    MOVK  X16, #0xc980, LSL #32
    MOVK  X16, #0x83e5, LSL #48
    SUB  X19, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xfd9e, LSL #0
    MOVK  X16, #0x24a2, LSL #16
    MOVK  X16, #0x5a72, LSL #32
    MOVK  X16, #0x75f6, LSL #48
    SUB  X19, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x51e9, LSL #0
    MOVK  X16, #0xad33, LSL #16
    MOVK  X16, #0xf5c7, LSL #32
    MOVK  X16, #0x29e9, LSL #48
    SUB  X19, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x96ab, LSL #0
    MOVK  X16, #0x6048, LSL #16
    MOVK  X16, #0x3a91, LSL #32
    MOVK  X16, #0xb10f, LSL #48
    SUB  X19, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xf710, LSL #0
    MOVK  X16, #0x8cbd, LSL #16
    MOVK  X16, #0x1642, LSL #32
    MOVK  X16, #0xac88, LSL #48
    SUB  X19, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x6fad, LSL #0
    MOVK  X16, #0xd05b, LSL #16
    MOVK  X16, #0xbd6f, LSL #32
    MOVK  X16, #0xdcd6, LSL #48
    SUB  X19, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0x831b, LSL #0
    MOVK  X16, #0xf9a, LSL #16
    MOVK  X16, #0x511, LSL #32
    MOVK  X16, #0xb0b2, LSL #48
    SUB  X19, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdScalarRDM_TestFail
    MRS  X16, FPSR
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x800, LSL #16
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D0
    MOVZ  X19, #0x15a7, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D1
    MOVZ  X19, #0x8000, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D2
    MOVZ  X19, #0x1616, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D3
    MOVZ  X19, #0x1f89, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D4
    MOVZ  X19, #0x2fa, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D5
    MOVZ  X19, #0xecb, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D6
    MOVZ  X19, #0x3a46, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D7
    MOVZ  X19, #0x6ab9, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D8
    MOVZ  X19, #0x301a, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D9
    MOVZ  X19, #0x9b78, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D10
    MOVZ  X19, #0x9e7d, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D11
    MOVZ  X19, #0x7834, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D12
    MOVZ  X19, #0x7a61, LSL #0
    MOVK  X19, #0x37ca, LSL #16
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D13
    MOVZ  X19, #0xf860, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D14
    MOVZ  X19, #0xd4db, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D15
    MOVZ  X19, #0x8c02, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D16
    MOVZ  X19, #0xbc20, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D17
    MOVZ  X19, #0xf720, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D18
    MOVZ  X19, #0x6686, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D19
    MOVZ  X19, #0x8001, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D20
    MOVZ  X19, #0x6036, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D21
    MOVZ  X19, #0x8000, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D22
    MOVZ  X19, #0x7112, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D23
    MOVZ  X19, #0x8000, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D24
    MOVZ  X19, #0x7fff, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D25
    MOVZ  X19, #0x9afb, LSL #0
    MOVK  X19, #0x5a48, LSL #16
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D26
    MOVZ  X19, #0x9a51, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D27
    MOVZ  X19, #0x7fff, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D28
    MOVZ  X19, #0xeefe, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D29
    MOVZ  X19, #0x843f, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D30
    MOVZ  X19, #0x46b6, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D31
    MOVZ  X19, #0x7fff, LSL #0
    SUB  X8, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    FMOV  D0, X18
    FMOV  V0.D[1], X20
    FMOV  D1, X25
    FMOV  V1.D[1], X16
    FMOV  D2, X13
    FMOV  V2.D[1], X12
    FMOV  D3, X23
    FMOV  V3.D[1], X19
    FMOV  D4, X7
    FMOV  V4.D[1], X22
    FMOV  D5, X25
    FMOV  V5.D[1], X17
    FMOV  D6, X10
    FMOV  V6.D[1], X21
    FMOV  D7, X13
    FMOV  V7.D[1], X12
    FMOV  D8, X23
    FMOV  V8.D[1], X12
    FMOV  D9, X15
    FMOV  V9.D[1], X5
    FMOV  D10, X23
    FMOV  V10.D[1], X22
    FMOV  D11, X13
    FMOV  V11.D[1], X7
    FMOV  D12, X7
    FMOV  V12.D[1], X15
    FMOV  D13, X18
    FMOV  V13.D[1], X2
    FMOV  D14, X5
    FMOV  V14.D[1], X13
    FMOV  D15, X23
    FMOV  V15.D[1], X4
    FMOV  D16, X10
    FMOV  V16.D[1], X10
    FMOV  D17, X23
    FMOV  V17.D[1], X17
    FMOV  D18, X9
    FMOV  V18.D[1], X18
    FMOV  D19, X19
    FMOV  V19.D[1], X11
    FMOV  D20, X10
    FMOV  V20.D[1], X11
    FMOV  D21, X8
    FMOV  V21.D[1], X13
    FMOV  D22, X22
    FMOV  V22.D[1], X6
    FMOV  D23, X14
    FMOV  V23.D[1], X3
    FMOV  D24, X8
    FMOV  V24.D[1], X7
    FMOV  D25, X3
    FMOV  V25.D[1], X7
    FMOV  D26, X25
    FMOV  V26.D[1], X18
    FMOV  D27, X12
    FMOV  V27.D[1], X23
    FMOV  D28, X10
    FMOV  V28.D[1], X9
    FMOV  D29, X16
    FMOV  V29.D[1], X20
    FMOV  D30, X14
    FMOV  V30.D[1], X8
    FMOV  D31, X16
    FMOV  V31.D[1], X22
    MOVZ  X15, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_11:
    SQRDMLSH H12, H23, V2.H[0x2]
    SQRDMLAH S2, S12, V28.S[0x2]
    SQRDMLAH S19, S14, S28
    SQRDMLSH H23, H25, H4
    SQRDMLAH S18, S22, V16.S[0x3]
    SQRDMLAH H4, H26, V3.H[0x6]
    SQRDMLSH H31, H24, V7.H[0x0]
    SQRDMLSH S16, S18, V18.S[0x3]
    SQRDMLAH S29, S2, S16
    SQRDMLAH S12, S27, V20.S[0x1]
    SQRDMLAH H6, H29, H12
    SQRDMLSH S14, S4, V14.S[0x1]
    SQRDMLAH S5, S6, V27.S[0x3]
    SQRDMLSH H26, H14, H19
    SQRDMLAH H4, H6, H20
    SQRDMLAH H14, H31, H31
    SQRDMLAH S24, S28, V12.S[0x3]
    SQRDMLSH H7, H30, H14
    SQRDMLAH S18, S26, V25.S[0x2]
    SQRDMLAH H31, H23, V4.H[0x4]
    SQRDMLSH H25, H5, H31
    SQRDMLSH H5, H24, V7.H[0x0]
    SQRDMLAH S27, S3, S25
    SQRDMLSH S30, S18, V27.S[0x0]
    SQRDMLSH S25, S31, S13
    SQRDMLSH H26, H10, V5.H[0x7]
    SQRDMLAH H16, H22, H21
    SQRDMLSH H7, H12, H25
    SQRDMLSH H22, H29, V14.H[0x3]
    SQRDMLAH H6, H31, V15.H[0x5]
    SQRDMLSH S31, S31, V4.S[0x3]
    SQRDMLSH S14, S24, V27.S[0x2]
    SQRDMLSH H2, H28, H29
    SQRDMLSH H15, H22, H30
    SQRDMLAH S13, S12, S6
    SQRDMLAH H28, H16, H8
    SQRDMLAH S5, S0, V28.S[0x1]
    SQRDMLAH H21, H26, V1.H[0x4]
    SQRDMLAH H18, H31, H21
    SQRDMLAH S25, S14, S14
    SQRDMLAH H22, H25, V2.H[0x7]
    SQRDMLSH S27, S13, S15
    SQRDMLAH H20, H27, H22
    SQRDMLSH H12, H20, V4.H[0x1]
    SQRDMLAH H13, H12, H7
    SQRDMLSH H7, H19, H22
    SQRDMLAH S1, S7, S7
    SQRDMLSH S6, S13, V1.S[0x2]
    SQRDMLAH H1, H15, V10.H[0x4]
    SQRDMLAH H25, H5, V6.H[0x4]
    SQRDMLSH H7, H8, V8.H[0x2]
    SQRDMLAH H6, H18, V7.H[0x4]
    SQRDMLSH S10, S6, V1.S[0x1]
    SQRDMLAH S20, S7, S13
    SQRDMLSH S7, S3, V9.S[0x2]
    SQRDMLSH S28, S24, V10.S[0x2]
    SQRDMLAH S9, S3, V24.S[0x1]
    SQRDMLSH H24, H20, V1.H[0x7]
    SQRDMLAH S27, S22, V23.S[0x1]
    SQRDMLSH S10, S27, S28
    SQRDMLSH H15, H25, V14.H[0x3]
    SQRDMLSH H22, H13, H22
    SQRDMLSH H20, H1, V14.H[0x2]
    SQRDMLSH H25, H12, H12
    SQRDMLAH H16, H18, H16
    SQRDMLAH H17, H25, H14
    SQRDMLAH S1, S24, V10.S[0x2]
    SQRDMLAH S13, S7, S9
    SQRDMLSH S10, S1, V18.S[0x1]
    SQRDMLSH H14, H17, V10.H[0x6]
    SQRDMLSH S18, S14, S14
    SQRDMLSH H20, H28, V13.H[0x3]
    SQRDMLAH S24, S30, V15.S[0x2]
    SQRDMLSH S23, S16, V13.S[0x1]
    SQRDMLAH H7, H17, V5.H[0x0]
    SQRDMLSH H17, H20, V7.H[0x6]
    SQRDMLAH H5, H18, H28
    SQRDMLAH S15, S17, S16
    SQRDMLAH H6, H14, H21
    SQRDMLSH S1, S23, S15
    SQRDMLSH H7, H25, V4.H[0x1]
    SQRDMLSH H31, H1, V1.H[0x0]
    SQRDMLAH S14, S7, V7.S[0x3]
    SQRDMLAH S7, S14, S22
    SQRDMLAH S26, S24, S8
    SQRDMLAH H24, H23, H5
    SQRDMLSH S6, S6, S7
    SQRDMLSH S14, S31, S26
    SQRDMLSH H21, H24, H27
    SQRDMLAH H5, H21, V2.H[0x3]
    SQRDMLSH S24, S14, V19.S[0x0]
    SQRDMLSH S7, S6, V15.S[0x0]
    SQRDMLSH H26, H5, V8.H[0x3]
    SQRDMLAH H27, H24, V6.H[0x3]
    SQRDMLSH H19, H15, V7.H[0x1]
    SQRDMLSH S10, S15, V27.S[0x3]
    SQRDMLSH H1, H5, V10.H[0x1]
    SQRDMLAH S21, S1, S0
    SQRDMLAH H10, H21, H19
    SQRDMLSH H4, H22, V13.H[0x6]
    SQRDMLAH S7, S9, S1
    SQRDMLSH H23, H14, V14.H[0x7]
    SQRDMLSH H5, H30, V1.H[0x1]
    SQRDMLSH H11, H19, V12.H[0x0]
    SQRDMLAH S9, S11, S16
    SQRDMLSH S21, S21, V18.S[0x3]
    SQRDMLSH H13, H12, V15.H[0x5]
    SQRDMLAH S16, S9, V20.S[0x3]
    SQRDMLAH S0, S13, V23.S[0x3]
    SQRDMLAH S18, S7, V13.S[0x0]
    SQRDMLSH H2, H4, V10.H[0x7]
    SQRDMLAH S9, S0, S7
    SQRDMLAH S6, S21, V21.S[0x1]
    SQRDMLAH H22, H6, V3.H[0x6]
    SQRDMLSH H13, H27, V5.H[0x6]
    SQRDMLAH H4, H22, H15
    SQRDMLSH H20, H3, V4.H[0x7]
    SQRDMLSH H12, H16, V13.H[0x7]
    SQRDMLAH H7, H9, V2.H[0x5]
    SQRDMLAH S20, S18, V12.S[0x3]
    SQRDMLSH H23, H15, V7.H[0x6]
    SQRDMLSH S18, S30, S23
    SQRDMLAH H0, H9, H27
    SQRDMLAH H21, H15, V3.H[0x1]
    SQRDMLSH S7, S18, V21.S[0x2]
    SQRDMLAH S30, S20, V20.S[0x3]
    SQRDMLAH H15, H14, V3.H[0x1]
    SQRDMLSH S21, S19, S30
    SQRDMLAH S14, S15, S0
    SQRDMLSH H22, H28, V4.H[0x2]
    SQRDMLSH S11, S14, V21.S[0x3]
    SQRDMLAH S10, S9, V24.S[0x1]
    SQRDMLSH S30, S2, S8
    SQRDMLSH S9, S11, S10
    SQRDMLSH H11, H31, V5.H[0x0]
    SQRDMLAH S6, S22, S7
    SQRDMLSH S15, S6, S12
    SQRDMLAH S31, S15, V15.S[0x3]
    SQRDMLSH S8, S9, S9
    SQRDMLSH S21, S26, V30.S[0x2]
    SQRDMLAH S24, S31, V21.S[0x1]
    SQRDMLAH H2, H14, V15.H[0x5]
    SQRDMLAH S4, S24, S2
    SQRDMLAH H2, H22, H4
    SQRDMLAH H6, H2, V15.H[0x4]
    SQRDMLSH H9, H8, H31
    SQRDMLSH S5, S9, V1.S[0x3]
    SQRDMLAH S26, S11, V5.S[0x1]
    SQRDMLSH H9, H6, V0.H[0x7]
    SQRDMLSH H5, H1, H2
    SQRDMLAH H28, H17, V12.H[0x7]
    SQRDMLSH S15, S28, S28
    SQRDMLSH S30, S5, S17
    SQRDMLSH H12, H3, H9
    SQRDMLAH H14, H10, V10.H[0x7]
    SQRDMLSH H9, H13, H31
    SQRDMLSH H19, H15, V4.H[0x2]
    SQRDMLSH H11, H26, V3.H[0x4]
    SQRDMLSH H21, H31, V2.H[0x4]
    SQRDMLAH S26, S20, S31
    SQRDMLSH H22, H15, H1
    SQRDMLAH S0, S26, V11.S[0x1]
    SQRDMLAH S8, S30, V24.S[0x2]
    SQRDMLSH S30, S8, S21
    SQRDMLSH S13, S18, S14
    SQRDMLSH S7, S5, V19.S[0x2]
    SQRDMLAH S1, S18, S7
    SQRDMLAH H2, H5, V2.H[0x6]
    SQRDMLAH H17, H9, H24
    SQRDMLAH S14, S30, V22.S[0x1]
    SQRDMLAH S4, S2, V21.S[0x0]
    SQRDMLSH S1, S14, S1
    SQRDMLSH S9, S22, V7.S[0x0]
    SQRDMLAH S14, S13, V4.S[0x3]
    SQRDMLSH H4, H9, H17
    SQRDMLAH S15, S4, S31
    SQRDMLSH H11, H14, H1
    SQRDMLSH S17, S21, S0
    SQRDMLSH S1, S11, S23
    SQRDMLAH H24, H22, H12
    SQRDMLAH S22, S1, S1
    SQRDMLSH H0, H22, H12
    SQRDMLAH H26, H24, V2.H[0x6]
    SQRDMLAH H21, H13, H12
    SQRDMLSH H8, H26, H17
    SQRDMLAH S24, S14, V4.S[0x0]
    SQRDMLAH S2, S0, S25
    SQRDMLSH S19, S21, V11.S[0x0]
    SQRDMLSH H4, H8, V2.H[0x7]
    SQRDMLSH S2, S29, V15.S[0x2]
    SQRDMLSH S5, S28, V23.S[0x2]
    SQRDMLAH H17, H5, H19
    SQRDMLSH H12, H28, V2.H[0x6]
    SQRDMLSH H7, H4, V12.H[0x0]
    SQRDMLSH H0, H17, V7.H[0x3]
    SQRDMLSH S23, S19, V3.S[0x1]
    SQRDMLSH H22, H3, V1.H[0x0]
    SQRDMLAH H31, H4, V9.H[0x6]
    SQRDMLAH S17, S6, S20
    SQRDMLAH S6, S4, V4.S[0x2]
    SUBS  X15, X15, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_11
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MRS  X3, FPSR
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x800, LSL #16
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D0
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D1
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D9
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D29
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X3, D31
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X20
    FMOV  D1, X21
    FMOV  V1.D[1], X19
    FMOV  D2, X12
    FMOV  V2.D[1], X18
    FMOV  D3, X23
    FMOV  V3.D[1], X20
    FMOV  D4, X23
    FMOV  V4.D[1], X14
    FMOV  D5, X22
    FMOV  V5.D[1], X17
    FMOV  D6, X22
    FMOV  V6.D[1], X6
    FMOV  D7, X25
    FMOV  V7.D[1], X9
    FMOV  D8, X21
    FMOV  V8.D[1], X16
    FMOV  D9, X25
    FMOV  V9.D[1], X3
    FMOV  D10, X10
    FMOV  V10.D[1], X19
    FMOV  D11, X5
    FMOV  V11.D[1], X3
    FMOV  D12, X11
    FMOV  V12.D[1], X9
    FMOV  D13, X5
    FMOV  V13.D[1], X20
    FMOV  D14, X2
    FMOV  V14.D[1], X20
    FMOV  D15, X12
    FMOV  V15.D[1], X11
    FMOV  D16, X4
    FMOV  V16.D[1], X14
    FMOV  D17, X9
    FMOV  V17.D[1], X13
    FMOV  D18, X6
    FMOV  V18.D[1], X9
    FMOV  D19, X4
    FMOV  V19.D[1], X2
    FMOV  D20, X2
    FMOV  V20.D[1], X16
    FMOV  D21, X19
    FMOV  V21.D[1], X17
    FMOV  D22, X13
    FMOV  V22.D[1], X4
    FMOV  D23, X17
    FMOV  V23.D[1], X11
    FMOV  D24, X13
    FMOV  V24.D[1], X2
    FMOV  D25, X12
    FMOV  V25.D[1], X22
    FMOV  D26, X25
    FMOV  V26.D[1], X19
    FMOV  D27, X9
    FMOV  V27.D[1], X19
    FMOV  D28, X8
    FMOV  V28.D[1], X11
    FMOV  D29, X13
    FMOV  V29.D[1], X18
    FMOV  D30, X22
    FMOV  V30.D[1], X21
    FMOV  D31, X19
    FMOV  V31.D[1], X21
    MOVZ  X2, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_12:
    SQRDMLAH H4, H20, H26
    SQRDMLAH H11, H29, H24
    SQRDMLAH S22, S6, S25
    SQRDMLAH H6, H28, V0.H[0x0]
    SQRDMLSH S19, S7, V19.S[0x2]
    SQRDMLSH S26, S27, V31.S[0x2]
    SQRDMLAH S10, S23, V19.S[0x2]
    SQRDMLAH S4, S30, S29
    SQRDMLAH S2, S3, V5.S[0x0]
    SQRDMLSH S18, S8, S22
    SQRDMLAH H7, H6, H10
    SQRDMLSH H31, H16, H11
    SQRDMLAH S20, S7, S4
    SQRDMLAH S26, S14, S2
    SQRDMLSH H8, H31, V3.H[0x3]
    SQRDMLSH S27, S20, S8
    SQRDMLAH H5, H26, V0.H[0x4]
    SQRDMLAH H22, H5, H20
    SQRDMLSH S8, S18, V19.S[0x2]
    SQRDMLSH H25, H28, H22
    SQRDMLSH S22, S25, S27
    SQRDMLAH S19, S8, S1
    SQRDMLAH H4, H17, V0.H[0x6]
    SQRDMLAH H26, H18, V6.H[0x0]
    SQRDMLAH H24, H15, V4.H[0x6]
    SQRDMLAH S28, S29, V23.S[0x0]
    SQRDMLAH S0, S23, S29
    SQRDMLSH S7, S28, V14.S[0x2]
    SQRDMLAH H18, H27, H16
    SQRDMLAH H30, H22, H19
    SQRDMLAH S4, S12, V3.S[0x1]
    SQRDMLSH S12, S6, V0.S[0x3]
    SQRDMLSH S1, S15, S6
    SQRDMLSH H28, H22, H21
    SQRDMLAH H0, H24, H1
    SQRDMLSH S17, S4, V30.S[0x1]
    SQRDMLSH S27, S18, S12
    SQRDMLSH S10, S26, V0.S[0x1]
    SQRDMLAH S11, S10, V7.S[0x1]
    SQRDMLSH S19, S2, V17.S[0x3]
    SQRDMLAH S21, S30, V22.S[0x2]
    SQRDMLAH H22, H19, V10.H[0x5]
    SQRDMLSH H29, H19, H21
    SQRDMLAH H23, H26, H22
    SQRDMLAH S1, S29, S11
    SQRDMLSH H7, H28, H23
    SQRDMLSH S26, S27, S27
    SQRDMLSH S29, S7, S5
    SQRDMLSH H7, H2, H11
    SQRDMLSH S28, S8, V26.S[0x1]
    SQRDMLSH H30, H28, H2
    SQRDMLSH H16, H7, H27
    SQRDMLAH S12, S19, S1
    SQRDMLSH H4, H12, H29
    SQRDMLAH S22, S4, V4.S[0x3]
    SQRDMLAH S18, S30, S2
    SQRDMLAH S26, S18, V22.S[0x0]
    SQRDMLSH S23, S18, V5.S[0x0]
    SQRDMLSH H28, H15, V5.H[0x7]
    SQRDMLAH S1, S24, V10.S[0x1]
    SQRDMLAH H14, H20, V10.H[0x2]
    SQRDMLAH S5, S29, V12.S[0x3]
    SQRDMLAH H21, H19, V15.H[0x5]
    SQRDMLSH S11, S20, V22.S[0x2]
    SQRDMLAH S22, S11, V23.S[0x3]
    SQRDMLAH H2, H28, V14.H[0x4]
    SQRDMLAH S24, S16, S2
    SQRDMLAH H20, H16, V1.H[0x2]
    SQRDMLAH H4, H18, H5
    SQRDMLSH H11, H10, V2.H[0x3]
    SQRDMLAH S26, S24, V8.S[0x0]
    SQRDMLSH H5, H26, H19
    SQRDMLSH H22, H24, V9.H[0x6]
    SQRDMLAH H2, H10, H11
    SQRDMLAH H12, H20, V4.H[0x0]
    SQRDMLAH S11, S12, V2.S[0x0]
    SQRDMLAH S3, S30, V11.S[0x2]
    SQRDMLAH H29, H13, H15
    SQRDMLAH H27, H21, V14.H[0x7]
    SQRDMLAH H28, H27, H5
    SQRDMLSH S20, S28, S22
    SQRDMLAH S24, S7, V18.S[0x3]
    SQRDMLSH H4, H7, H20
    SQRDMLAH H10, H5, V2.H[0x2]
    SQRDMLAH S20, S10, S24
    SQRDMLAH S14, S28, V24.S[0x2]
    SQRDMLAH S16, S2, V31.S[0x1]
    SQRDMLAH S1, S4, V16.S[0x0]
    SQRDMLAH H30, H20, H17
    SQRDMLSH H13, H1, H6
    SQRDMLAH H8, H3, H30
    SQRDMLAH H5, H26, V8.H[0x6]
    SQRDMLAH S10, S27, V27.S[0x1]
    SQRDMLSH H31, H4, V11.H[0x1]
    SQRDMLAH H2, H5, H10
    SQRDMLAH H12, H14, H14
    SQRDMLAH H8, H21, V11.H[0x0]
    SQRDMLSH H27, H29, H8
    SQRDMLAH S14, S13, V12.S[0x3]
    SQRDMLSH S22, S14, S11
    SQRDMLSH S26, S7, S31
    SQRDMLSH H28, H27, H7
    SQRDMLAH S21, S1, S22
    SQRDMLSH H12, H0, V9.H[0x6]
    SQRDMLAH H29, H26, H28
    SQRDMLSH H30, H29, V12.H[0x4]
    SQRDMLAH H26, H21, V13.H[0x3]
    SQRDMLSH H20, H26, V2.H[0x6]
    SQRDMLSH S23, S8, V28.S[0x1]
    SQRDMLAH S24, S2, S8
    SQRDMLAH H9, H10, H22
    SQRDMLSH H2, H4, V9.H[0x6]
    SQRDMLAH S13, S2, S10
    SQRDMLAH H21, H1, V8.H[0x4]
    SQRDMLAH S22, S17, V13.S[0x2]
    SQRDMLSH H17, H4, H22
    SQRDMLAH H22, H2, H9
    SQRDMLSH H1, H28, H7
    SQRDMLAH S2, S31, V31.S[0x2]
    SQRDMLSH S28, S29, V24.S[0x2]
    SQRDMLSH S31, S30, S27
    SQRDMLAH H7, H17, H21
    SQRDMLSH S13, S31, V23.S[0x3]
    SQRDMLSH H27, H2, H10
    SQRDMLAH H30, H27, H10
    SQRDMLAH H5, H15, H0
    SQRDMLAH H4, H12, V13.H[0x3]
    SQRDMLAH H23, H30, H1
    SQRDMLSH S0, S5, V4.S[0x1]
    SQRDMLAH H9, H20, H23
    SQRDMLSH S15, S0, S0
    SQRDMLSH H0, H12, V2.H[0x4]
    SQRDMLSH H13, H25, H7
    SQRDMLSH H28, H28, V15.H[0x0]
    SQRDMLSH S1, S0, S29
    SQRDMLSH H17, H4, H17
    SQRDMLAH S26, S9, S28
    SQRDMLSH H30, H1, V12.H[0x0]
    SQRDMLSH H15, H22, H19
    SQRDMLSH H2, H13, V3.H[0x7]
    SQRDMLSH H15, H15, H2
    SQRDMLAH S27, S25, V17.S[0x1]
    SQRDMLSH H31, H26, H15
    SQRDMLAH H23, H30, V15.H[0x7]
    SQRDMLAH H26, H27, H11
    SQRDMLSH H4, H26, H31
    SQRDMLAH S29, S26, S27
    SQRDMLAH S31, S17, V16.S[0x1]
    SQRDMLAH H17, H22, V13.H[0x2]
    SQRDMLAH H13, H22, H18
    SQRDMLAH S2, S12, V20.S[0x1]
    SQRDMLSH H20, H29, H22
    SQRDMLSH S19, S6, S16
    SQRDMLAH H25, H31, V15.H[0x1]
    SQRDMLSH H27, H21, V12.H[0x7]
    SQRDMLSH H3, H1, H9
    SQRDMLSH H11, H25, H4
    SQRDMLSH H18, H17, V15.H[0x0]
    SQRDMLSH H23, H29, V5.H[0x4]
    SQRDMLSH H17, H13, V13.H[0x0]
    SQRDMLSH H0, H3, V3.H[0x5]
    SQRDMLSH S9, S8, V27.S[0x0]
    SQRDMLAH S22, S23, S30
    SQRDMLSH S15, S20, V28.S[0x2]
    SQRDMLSH S3, S9, S2
    SQRDMLSH S16, S27, S6
    SQRDMLAH S25, S22, S0
    SQRDMLAH S9, S17, V11.S[0x1]
    SQRDMLAH H2, H18, H19
    SQRDMLSH H23, H16, V15.H[0x6]
    SQRDMLSH S30, S9, V10.S[0x1]
    SQRDMLAH S15, S3, V16.S[0x3]
    SQRDMLAH H4, H30, H15
    SQRDMLSH S30, S23, S4
    SQRDMLAH H13, H25, V2.H[0x0]
    SQRDMLSH H8, H15, V9.H[0x2]
    SQRDMLSH H26, H11, V13.H[0x3]
    SQRDMLAH H31, H4, H1
    SQRDMLAH H29, H28, H18
    SQRDMLAH S6, S11, S11
    SQRDMLSH S11, S16, V3.S[0x1]
    SQRDMLAH S28, S28, S27
    SQRDMLSH S22, S24, S30
    SQRDMLSH H19, H16, H13
    SQRDMLAH H21, H6, H26
    SQRDMLSH S20, S17, S25
    SQRDMLAH H5, H27, V11.H[0x7]
    SQRDMLAH H30, H28, V13.H[0x6]
    SQRDMLAH H2, H14, V5.H[0x3]
    SQRDMLSH S0, S8, V19.S[0x0]
    SQRDMLAH H13, H0, V13.H[0x0]
    SQRDMLSH S18, S2, S31
    SQRDMLAH H24, H19, H30
    SQRDMLSH H14, H13, H29
    SQRDMLAH H5, H22, H18
    SQRDMLAH H28, H2, V14.H[0x5]
    SQRDMLAH H13, H5, V5.H[0x2]
    SQRDMLAH H30, H8, V13.H[0x5]
    SQRDMLAH S2, S24, V28.S[0x3]
    SQRDMLSH S22, S28, V20.S[0x2]
    SUBS  X2, X2, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_12
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdScalarRDM_TestFail
    MRS  X16, FPSR
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x800, LSL #16
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D0
    MOVZ  X9, #0xfffd, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D1
    MOVZ  X9, #0xffdd, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D2
    MOVZ  X9, #0x11, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D3
    MOVZ  X9, #0xfffd, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D4
    MOVZ  X9, #0x11, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D5
    MOVZ  X9, #0xffff, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D6
    MOVZ  X9, #0xffff, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D7
    MOVZ  X9, #0xffff, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D8
    MOVZ  X9, #0xffff, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D9
    MOVZ  X9, #0xffeb, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D10
    MOVZ  X9, #0xffff, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D11
    MOVZ  X9, #0x1, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D12
    MOVZ  X9, #0xf, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D13
    MOVZ  X9, #0x1, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D14
    MOVZ  X9, #0xffff, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D15
    MOVZ  X9, #0xffeb, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D16
    MOVZ  X9, #0xffeb, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D17
    MOVZ  X9, #0xffff, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D18
    MOVZ  X9, #0xfffb, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D19
    MOVZ  X9, #0xfffb, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D20
    MOVZ  X9, #0x1, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D21
    MOVZ  X9, #0xffff, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D22
    MOVZ  X9, #0x11, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D23
    MOVZ  X9, #0xffeb, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D24
    MOVZ  X9, #0x3, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D25
    MOVZ  X9, #0x3, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D26
    MOVZ  X9, #0xffe3, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D27
    MOVZ  X9, #0xfffb, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D28
    MOVZ  X9, #0x13, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D29
    MOVZ  X9, #0xfffb, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D30
    MOVZ  X9, #0xfffd, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X16, D31
    MOVZ  X9, #0xffeb, LSL #0
    SUB  X23, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X4
    FMOV  D1, X19
    FMOV  V1.D[1], X22
    FMOV  D2, X21
    FMOV  V2.D[1], X3
    FMOV  D3, X25
    FMOV  V3.D[1], X23
    FMOV  D4, X21
    FMOV  V4.D[1], X16
    FMOV  D5, X8
    FMOV  V5.D[1], X9
    FMOV  D6, X13
    FMOV  V6.D[1], X23
    FMOV  D7, X15
    FMOV  V7.D[1], X18
    FMOV  D8, X10
    FMOV  V8.D[1], X9
    FMOV  D9, X4
    FMOV  V9.D[1], X13
    FMOV  D10, X23
    FMOV  V10.D[1], X16
    FMOV  D11, X7
    FMOV  V11.D[1], X12
    FMOV  D12, X16
    FMOV  V12.D[1], X16
    FMOV  D13, X23
    FMOV  V13.D[1], X16
    FMOV  D14, X12
    FMOV  V14.D[1], X14
    FMOV  D15, X10
    FMOV  V15.D[1], X20
    FMOV  D16, X18
    FMOV  V16.D[1], X11
    FMOV  D17, X5
    FMOV  V17.D[1], X5
    FMOV  D18, X15
    FMOV  V18.D[1], X13
    FMOV  D19, X12
    FMOV  V19.D[1], X25
    FMOV  D20, X2
    FMOV  V20.D[1], X3
    FMOV  D21, X15
    FMOV  V21.D[1], X12
    FMOV  D22, X2
    FMOV  V22.D[1], X25
    FMOV  D23, X20
    FMOV  V23.D[1], X18
    FMOV  D24, X2
    FMOV  V24.D[1], X14
    FMOV  D25, X8
    FMOV  V25.D[1], X10
    FMOV  D26, X15
    FMOV  V26.D[1], X19
    FMOV  D27, X15
    FMOV  V27.D[1], X12
    FMOV  D28, X23
    FMOV  V28.D[1], X10
    FMOV  D29, X22
    FMOV  V29.D[1], X15
    FMOV  D30, X9
    FMOV  V30.D[1], X22
    FMOV  D31, X15
    FMOV  V31.D[1], X14
    MOVZ  X23, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_13:
    SQRDMLAH H11, H26, V7.H[0x6]
    SQRDMLSH H30, H16, H30
    SQRDMLSH H8, H19, V11.H[0x7]
    SQRDMLSH S29, S28, S24
    SQRDMLAH S0, S30, V30.S[0x3]
    SQRDMLSH H10, H0, H20
    SQRDMLSH H19, H25, V10.H[0x0]
    SQRDMLSH S12, S19, S23
    SQRDMLAH S11, S27, V27.S[0x2]
    SQRDMLAH H11, H11, V8.H[0x1]
    SQRDMLAH S10, S24, S10
    SQRDMLSH H2, H12, V12.H[0x6]
    SQRDMLAH H4, H29, H2
    SQRDMLAH S24, S31, V4.S[0x1]
    SQRDMLAH S28, S24, V10.S[0x0]
    SQRDMLAH H31, H15, V4.H[0x2]
    SQRDMLAH H19, H4, H16
    SQRDMLAH H25, H23, H31
    SQRDMLAH S16, S10, V29.S[0x1]
    SQRDMLAH S27, S0, S17
    SQRDMLSH H19, H5, H21
    SQRDMLAH S21, S15, V2.S[0x1]
    SQRDMLAH S20, S24, V15.S[0x1]
    SQRDMLAH S13, S30, V6.S[0x2]
    SQRDMLSH H26, H11, V4.H[0x3]
    SQRDMLAH S7, S3, S4
    SQRDMLSH S18, S7, V13.S[0x0]
    SQRDMLSH H7, H26, V1.H[0x5]
    SQRDMLSH S16, S16, S27
    SQRDMLSH S5, S7, S25
    SQRDMLSH H23, H18, V5.H[0x7]
    SQRDMLSH H31, H23, H23
    SQRDMLSH S18, S16, V28.S[0x1]
    SQRDMLAH H0, H20, H5
    SQRDMLAH H15, H18, H18
    SQRDMLAH S23, S21, S0
    SQRDMLAH H3, H24, V1.H[0x1]
    SQRDMLAH H4, H31, H20
    SQRDMLSH H27, H30, H18
    SQRDMLSH H28, H4, H10
    SQRDMLSH S5, S3, V3.S[0x2]
    SQRDMLSH S21, S19, S27
    SQRDMLSH H31, H23, H21
    SQRDMLAH S25, S31, V5.S[0x1]
    SQRDMLAH S3, S2, V13.S[0x0]
    SQRDMLSH H27, H4, H15
    SQRDMLAH H0, H3, V7.H[0x6]
    SQRDMLAH H1, H27, V2.H[0x6]
    SQRDMLSH S24, S0, S1
    SQRDMLSH S30, S1, S25
    SQRDMLAH S10, S24, S14
    SQRDMLAH S6, S1, V14.S[0x0]
    SQRDMLAH S24, S28, V10.S[0x2]
    SQRDMLSH S0, S31, V24.S[0x1]
    SQRDMLAH H16, H6, V5.H[0x4]
    SQRDMLSH H0, H24, V12.H[0x7]
    SQRDMLSH H20, H0, V13.H[0x6]
    SQRDMLAH S27, S16, V11.S[0x0]
    SQRDMLAH H24, H25, H18
    SQRDMLSH S6, S28, V20.S[0x2]
    SQRDMLAH H21, H19, V8.H[0x0]
    SQRDMLAH H2, H29, H21
    SQRDMLSH S14, S25, S13
    SQRDMLAH H15, H2, V11.H[0x3]
    SQRDMLAH H20, H15, V8.H[0x5]
    SQRDMLSH H7, H2, H28
    SQRDMLAH S4, S7, V24.S[0x1]
    SQRDMLSH S0, S10, S6
    SQRDMLAH H8, H30, H25
    SQRDMLSH S11, S27, S7
    SQRDMLSH S31, S4, V3.S[0x1]
    SQRDMLSH S1, S8, S0
    SQRDMLAH S21, S31, S23
    SQRDMLAH H15, H21, V11.H[0x3]
    SQRDMLSH H19, H31, H6
    SQRDMLAH S21, S8, V1.S[0x2]
    SQRDMLSH H3, H18, H12
    SQRDMLSH H24, H12, V15.H[0x2]
    SQRDMLAH S11, S14, S21
    SQRDMLSH H29, H6, H11
    SQRDMLSH S7, S3, S29
    SQRDMLSH H20, H27, V14.H[0x6]
    SQRDMLAH S0, S17, S11
    SQRDMLAH S14, S22, V7.S[0x3]
    SQRDMLAH H31, H0, H23
    SQRDMLSH S31, S20, V20.S[0x0]
    SQRDMLAH S6, S0, S4
    SQRDMLSH H21, H5, V14.H[0x5]
    SQRDMLAH S29, S13, S28
    SQRDMLAH H27, H7, V15.H[0x7]
    SQRDMLAH H23, H5, H24
    SQRDMLSH H1, H19, V6.H[0x7]
    SQRDMLSH S10, S21, V29.S[0x3]
    SQRDMLSH S6, S23, V23.S[0x2]
    SQRDMLSH H11, H2, H1
    SQRDMLAH S21, S22, S27
    SQRDMLAH S27, S27, V10.S[0x1]
    SQRDMLAH S14, S5, S7
    SQRDMLSH S20, S6, S6
    SQRDMLAH H6, H15, H11
    SQRDMLAH S12, S20, S21
    SQRDMLSH S2, S18, V6.S[0x1]
    SQRDMLSH S28, S27, S12
    SQRDMLSH S24, S5, S31
    SQRDMLSH H1, H14, H28
    SQRDMLSH S3, S24, S2
    SQRDMLSH H10, H1, V2.H[0x7]
    SQRDMLSH S22, S26, V23.S[0x2]
    SQRDMLAH S11, S11, V31.S[0x2]
    SQRDMLSH H27, H9, V7.H[0x0]
    SQRDMLAH S1, S6, S4
    SQRDMLSH H22, H18, H16
    SQRDMLAH H17, H0, V9.H[0x5]
    SQRDMLAH H31, H29, V13.H[0x1]
    SQRDMLSH S29, S13, V30.S[0x0]
    SQRDMLSH S7, S17, S29
    SQRDMLSH S14, S11, S14
    SQRDMLAH H9, H10, V12.H[0x4]
    SQRDMLSH S29, S14, V14.S[0x0]
    SQRDMLAH S12, S4, S2
    SQRDMLAH S30, S31, V22.S[0x1]
    SQRDMLAH S13, S7, S29
    SQRDMLSH S22, S1, S11
    SQRDMLAH H24, H3, V13.H[0x7]
    SQRDMLSH S18, S21, V27.S[0x2]
    SQRDMLAH S11, S24, V12.S[0x2]
    SQRDMLAH S2, S3, S30
    SQRDMLSH H6, H9, V6.H[0x5]
    SQRDMLAH H24, H6, V6.H[0x5]
    SQRDMLAH S14, S18, V24.S[0x0]
    SQRDMLAH S0, S22, S19
    SQRDMLSH H18, H17, H5
    SQRDMLSH S9, S17, S11
    SQRDMLSH H27, H9, V9.H[0x2]
    SQRDMLAH S24, S23, V15.S[0x1]
    SQRDMLSH H3, H0, H19
    SQRDMLAH H9, H27, H14
    SQRDMLSH S12, S3, V7.S[0x2]
    SQRDMLAH S3, S2, V21.S[0x0]
    SQRDMLAH H16, H8, H14
    SQRDMLAH S17, S12, V3.S[0x1]
    SQRDMLAH S8, S9, V17.S[0x2]
    SQRDMLSH S12, S8, S8
    SQRDMLAH S9, S18, S20
    SQRDMLAH S29, S9, S24
    SQRDMLSH S23, S29, S12
    SQRDMLAH S15, S1, V20.S[0x2]
    SQRDMLAH H3, H4, H24
    SQRDMLAH H15, H16, V15.H[0x1]
    SQRDMLAH H21, H19, H11
    SQRDMLSH S1, S25, V14.S[0x0]
    SQRDMLSH H20, H18, H2
    SQRDMLAH H4, H6, V10.H[0x4]
    SQRDMLSH S29, S12, V4.S[0x3]
    SQRDMLSH S0, S13, V2.S[0x1]
    SQRDMLAH H9, H30, H21
    SQRDMLSH S30, S4, S7
    SQRDMLAH S13, S3, S15
    SQRDMLSH H17, H20, H29
    SQRDMLAH H15, H9, H1
    SQRDMLAH S20, S17, V13.S[0x0]
    SQRDMLAH H3, H5, V11.H[0x0]
    SQRDMLAH H21, H7, H20
    SQRDMLAH S10, S10, V30.S[0x1]
    SQRDMLAH S2, S10, V10.S[0x2]
    SQRDMLAH H20, H29, H21
    SQRDMLSH H16, H2, V15.H[0x5]
    SQRDMLSH S13, S20, V31.S[0x1]
    SQRDMLAH H18, H31, V10.H[0x0]
    SQRDMLAH S15, S3, V17.S[0x1]
    SQRDMLAH H17, H23, V13.H[0x3]
    SQRDMLSH H21, H18, H0
    SQRDMLAH H9, H14, V14.H[0x2]
    SQRDMLSH H20, H9, V9.H[0x7]
    SQRDMLAH S24, S20, V21.S[0x1]
    SQRDMLSH H31, H28, V15.H[0x4]
    SQRDMLSH S10, S7, S17
    SQRDMLAH H3, H4, V8.H[0x5]
    SQRDMLSH H9, H26, H10
    SQRDMLAH S4, S5, V24.S[0x1]
    SQRDMLAH S30, S31, V16.S[0x3]
    SQRDMLSH S13, S9, V30.S[0x3]
    SQRDMLAH H18, H4, V4.H[0x0]
    SQRDMLAH H21, H13, H12
    SQRDMLAH S15, S12, S3
    SQRDMLSH H8, H7, V3.H[0x5]
    SQRDMLAH H2, H15, V11.H[0x0]
    SQRDMLAH H29, H18, V8.H[0x7]
    SQRDMLSH H20, H16, H21
    SQRDMLSH H1, H9, H29
    SQRDMLAH S14, S20, S15
    SQRDMLAH H0, H26, H0
    SQRDMLAH S29, S2, V2.S[0x1]
    SQRDMLSH H11, H0, V1.H[0x3]
    SQRDMLAH H12, H25, V11.H[0x5]
    SQRDMLAH S9, S22, V14.S[0x3]
    SQRDMLAH H10, H7, V11.H[0x7]
    SQRDMLAH H18, H1, H29
    SQRDMLSH S16, S12, S8
    SQRDMLAH S31, S28, V18.S[0x2]
    SUBS  X23, X23, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_13
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdScalarRDM_TestFail
    MRS  X13, FPSR
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x800, LSL #16
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D0
    MOVZ  X4, #0x8000, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D1
    MOVZ  X4, #0x6e75, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D2
    MOVZ  X4, #0x7fff, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D3
    MOVZ  X4, #0xf515, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D4
    MOVZ  X4, #0xe1cb, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D5
    MOVZ  X4, #0x5a59, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D6
    MOVZ  X4, #0x3ab9, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D7
    MOVZ  X4, #0xd10e, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D8
    MOVZ  X4, #0x7ffe, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D9
    MOVZ  X4, #0xc58e, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D10
    MOVZ  X4, #0xe65a, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D11
    MOVZ  X4, #0xb32, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D12
    MOVZ  X4, #0xa830, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D13
    MOVZ  X4, #0x5c3d, LSL #0
    MOVK  X4, #0x5a58, LSL #16
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D14
    MOVZ  X4, #0x371c, LSL #0
    MOVK  X4, #0x5a57, LSL #16
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D15
    MOVZ  X4, #0x4325, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D16
    MOVZ  X4, #0x56a7, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D17
    MOVZ  X4, #0xd7f7, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D18
    MOVZ  X4, #0x17f9, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D19
    MOVZ  X4, #0xaf86, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D20
    MOVZ  X4, #0xee2d, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D21
    MOVZ  X4, #0xcda8, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D22
    MOVZ  X4, #0xab54, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D23
    MOVZ  X4, #0x67aa, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D24
    MOVZ  X4, #0x38cc, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D25
    MOVZ  X4, #0x6f30, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D26
    MOVZ  X4, #0x5a5a, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D27
    MOVZ  X4, #0x9420, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D28
    MOVZ  X4, #0x28ab, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D29
    MOVZ  X4, #0x130f, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D30
    MOVZ  X4, #0xfffe, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X13, D31
    MOVZ  X4, #0x8000, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, LCRTAdvsimdScalarRDM_TestFail
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
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  D0, X17
    FMOV  V0.D[1], X23
    FMOV  D1, X20
    FMOV  V1.D[1], X21
    FMOV  D2, X25
    FMOV  V2.D[1], X20
    FMOV  D3, X22
    FMOV  V3.D[1], X12
    FMOV  D4, X23
    FMOV  V4.D[1], X18
    FMOV  D5, X21
    FMOV  V5.D[1], X10
    FMOV  D6, X23
    FMOV  V6.D[1], X25
    FMOV  D7, X20
    FMOV  V7.D[1], X15
    FMOV  D8, X9
    FMOV  V8.D[1], X20
    FMOV  D9, X16
    FMOV  V9.D[1], X20
    FMOV  D10, X7
    FMOV  V10.D[1], X16
    FMOV  D11, X25
    FMOV  V11.D[1], X17
    FMOV  D12, X13
    FMOV  V12.D[1], X5
    FMOV  D13, X9
    FMOV  V13.D[1], X18
    FMOV  D14, X25
    FMOV  V14.D[1], X21
    FMOV  D15, X25
    FMOV  V15.D[1], X21
    FMOV  D16, X3
    FMOV  V16.D[1], X16
    FMOV  D17, X15
    FMOV  V17.D[1], X11
    FMOV  D18, X11
    FMOV  V18.D[1], X21
    FMOV  D19, X17
    FMOV  V19.D[1], X13
    FMOV  D20, X25
    FMOV  V20.D[1], X6
    FMOV  D21, X9
    FMOV  V21.D[1], X11
    FMOV  D22, X9
    FMOV  V22.D[1], X16
    FMOV  D23, X18
    FMOV  V23.D[1], X6
    FMOV  D24, X22
    FMOV  V24.D[1], X8
    FMOV  D25, X25
    FMOV  V25.D[1], X8
    FMOV  D26, X18
    FMOV  V26.D[1], X20
    FMOV  D27, X19
    FMOV  V27.D[1], X15
    FMOV  D28, X7
    FMOV  V28.D[1], X23
    FMOV  D29, X15
    FMOV  V29.D[1], X9
    FMOV  D30, X6
    FMOV  V30.D[1], X13
    FMOV  D31, X6
    FMOV  V31.D[1], X17
    MOVZ  X9, #0xa, LSL #0
LCRTAdvsimdScalarRDM_label_14:
    SQRDMLAH H1, H31, V14.H[0x0]
    SQRDMLAH S30, S29, S2
    SQRDMLSH S31, S26, V23.S[0x1]
    SQRDMLSH H14, H20, H1
    SQRDMLAH H22, H10, V10.H[0x1]
    SQRDMLSH S10, S3, V22.S[0x0]
    SQRDMLAH S4, S13, V27.S[0x3]
    SQRDMLSH H25, H31, H30
    SQRDMLAH S5, S25, V10.S[0x3]
    SQRDMLSH S3, S5, V14.S[0x2]
    SQRDMLSH S27, S28, S4
    SQRDMLSH S13, S3, S3
    SQRDMLAH H28, H27, V2.H[0x7]
    SQRDMLAH H26, H13, V13.H[0x5]
    SQRDMLSH H22, H1, V0.H[0x4]
    SQRDMLAH S20, S22, S22
    SQRDMLAH S0, S20, V28.S[0x1]
    SQRDMLAH H26, H17, H19
    SQRDMLSH S17, S14, S9
    SQRDMLSH S18, S13, S18
    SQRDMLAH H19, H28, H8
    SQRDMLAH S13, S11, V4.S[0x1]
    SQRDMLAH S29, S1, V0.S[0x2]
    SQRDMLAH H12, H17, H1
    SQRDMLAH H23, H8, V4.H[0x4]
    SQRDMLSH H21, H14, H2
    SQRDMLAH S2, S7, V5.S[0x3]
    SQRDMLAH S5, S2, S24
    SQRDMLAH S11, S12, V7.S[0x1]
    SQRDMLAH H31, H18, H23
    SQRDMLAH S4, S13, V23.S[0x1]
    SQRDMLSH H8, H21, H26
    SQRDMLAH S22, S19, V19.S[0x1]
    SQRDMLSH H4, H8, H26
    SQRDMLAH S25, S11, S11
    SQRDMLAH S13, S4, V31.S[0x0]
    SQRDMLAH H28, H13, V4.H[0x2]
    SQRDMLAH H25, H29, H7
    SQRDMLAH S0, S27, S25
    SQRDMLSH S9, S31, S0
    SQRDMLAH S9, S17, V3.S[0x0]
    SQRDMLAH H25, H5, V5.H[0x6]
    SQRDMLAH H26, H7, H25
    SQRDMLAH H5, H31, V9.H[0x4]
    SQRDMLSH H25, H19, H22
    SQRDMLSH H14, H26, H28
    SQRDMLAH H16, H12, H27
    SQRDMLSH S28, S27, V16.S[0x2]
    SQRDMLSH S9, S14, V5.S[0x0]
    SQRDMLSH H5, H21, H25
    SQRDMLAH H19, H28, H28
    SQRDMLSH H11, H5, V9.H[0x7]
    SQRDMLSH S28, S5, S30
    SQRDMLAH S25, S11, S24
    SQRDMLAH H0, H8, H19
    SQRDMLSH H26, H8, V12.H[0x7]
    SQRDMLSH H23, H16, V12.H[0x1]
    SQRDMLSH H29, H30, V2.H[0x1]
    SQRDMLSH H13, H22, H5
    SQRDMLSH H22, H24, V3.H[0x5]
    SQRDMLSH S21, S21, V10.S[0x0]
    SQRDMLSH S27, S11, S13
    SQRDMLAH H29, H23, V14.H[0x2]
    SQRDMLSH H12, H27, V1.H[0x4]
    SQRDMLSH S9, S21, V0.S[0x2]
    SQRDMLAH H4, H28, V9.H[0x5]
    SQRDMLSH S31, S29, S26
    SQRDMLSH S11, S1, S22
    SQRDMLAH S14, S24, V31.S[0x0]
    SQRDMLSH S15, S11, S30
    SQRDMLAH S19, S4, V14.S[0x0]
    SQRDMLAH S22, S15, S28
    SQRDMLSH S11, S19, V12.S[0x1]
    SQRDMLSH H2, H15, V5.H[0x0]
    SQRDMLAH S11, S22, V25.S[0x0]
    SQRDMLSH S24, S12, S15
    SQRDMLAH H30, H20, H7
    SQRDMLAH H27, H13, H18
    SQRDMLAH H3, H0, H28
    SQRDMLAH H23, H0, H18
    SQRDMLAH S16, S4, S22
    SQRDMLSH S7, S15, S5
    SQRDMLAH H20, H7, V4.H[0x5]
    SQRDMLSH H1, H16, H24
    SQRDMLSH S23, S2, V30.S[0x2]
    SQRDMLSH S29, S20, V27.S[0x1]
    SQRDMLSH H20, H11, H1
    SQRDMLSH S16, S29, S29
    SQRDMLAH S0, S16, V26.S[0x1]
    SQRDMLAH S1, S3, V19.S[0x1]
    SQRDMLAH H24, H20, H20
    SQRDMLAH S4, S1, S1
    SQRDMLSH H29, H0, V4.H[0x3]
    SQRDMLAH S3, S23, V29.S[0x2]
    SQRDMLAH S11, S9, S6
    SQRDMLAH S28, S2, V1.S[0x1]
    SQRDMLSH H29, H13, V12.H[0x3]
    SQRDMLSH S13, S22, S30
    SQRDMLSH S26, S8, V10.S[0x1]
    SQRDMLSH S8, S2, S15
    SQRDMLSH H0, H3, V9.H[0x1]
    SQRDMLAH H20, H8, V13.H[0x2]
    SQRDMLAH H5, H0, H17
    SQRDMLAH H6, H21, H26
    SQRDMLSH H12, H19, V3.H[0x3]
    SQRDMLSH S27, S30, V3.S[0x1]
    SQRDMLSH S21, S10, V27.S[0x2]
    SQRDMLSH H9, H12, H6
    SQRDMLAH S4, S28, V28.S[0x2]
    SQRDMLSH S26, S20, S11
    SQRDMLSH S12, S4, S10
    SQRDMLSH S11, S26, S29
    SQRDMLAH S10, S12, S11
    SQRDMLSH S17, S9, S31
    SQRDMLSH H22, H13, H26
    SQRDMLAH S28, S17, S10
    SQRDMLAH H26, H22, V5.H[0x3]
    SQRDMLSH H0, H21, H24
    SQRDMLAH H12, H22, H29
    SQRDMLAH H9, H0, V10.H[0x4]
    SQRDMLAH H15, H28, H18
    SQRDMLAH S3, S8, V0.S[0x3]
    SQRDMLAH S20, S31, S20
    SQRDMLSH H2, H9, H20
    SQRDMLSH S9, S12, V26.S[0x1]
    SQRDMLSH H28, H3, H9
    SQRDMLAH H12, H2, V2.H[0x1]
    SQRDMLSH S6, S17, V7.S[0x2]
    SQRDMLAH H9, H12, V12.H[0x5]
    SQRDMLAH S8, S6, S28
    SQRDMLAH H5, H9, V15.H[0x4]
    SQRDMLAH H2, H7, V12.H[0x3]
    SQRDMLSH S22, S11, S14
    SQRDMLAH S24, S3, S23
    SQRDMLSH H9, H18, H19
    SQRDMLAH S19, S3, V2.S[0x0]
    SQRDMLAH H23, H0, H7
    SQRDMLAH S12, S9, V25.S[0x1]
    SQRDMLAH S30, S4, V11.S[0x0]
    SQRDMLAH S15, S4, V14.S[0x0]
    SQRDMLAH S3, S5, V12.S[0x3]
    SQRDMLSH H2, H9, V5.H[0x1]
    SQRDMLAH H20, H8, V8.H[0x5]
    SQRDMLAH H14, H6, H5
    SQRDMLSH S25, S24, S22
    SQRDMLAH H13, H4, V3.H[0x6]
    SQRDMLSH S18, S25, V2.S[0x1]
    SQRDMLSH H31, H26, V6.H[0x5]
    SQRDMLAH H5, H18, H15
    SQRDMLSH S11, S19, V12.S[0x3]
    SQRDMLAH H3, H14, V5.H[0x1]
    SQRDMLSH H8, H30, V9.H[0x0]
    SQRDMLAH S18, S24, S7
    SQRDMLSH H2, H18, V11.H[0x3]
    SQRDMLAH S0, S25, V13.S[0x3]
    SQRDMLSH S28, S17, S3
    SQRDMLSH S14, S2, S9
    SQRDMLAH H30, H12, V5.H[0x1]
    SQRDMLAH H18, H11, V13.H[0x6]
    SQRDMLAH H19, H14, H2
    SQRDMLAH H15, H3, H2
    SQRDMLSH S19, S30, S15
    SQRDMLSH S2, S31, S0
    SQRDMLAH S0, S18, V28.S[0x1]
    SQRDMLAH H22, H8, V0.H[0x6]
    SQRDMLAH H18, H10, H23
    SQRDMLSH H13, H7, V2.H[0x1]
    SQRDMLSH S2, S7, S26
    SQRDMLAH S8, S2, S30
    SQRDMLAH H1, H22, V9.H[0x6]
    SQRDMLSH H11, H10, H19
    SQRDMLSH S16, S13, S20
    SQRDMLAH H0, H8, H8
    SQRDMLAH H6, H16, V11.H[0x4]
    SQRDMLSH S31, S20, S0
    SQRDMLSH H21, H18, H27
    SQRDMLAH S20, S31, V21.S[0x2]
    SQRDMLSH S8, S25, V1.S[0x3]
    SQRDMLSH H13, H20, V5.H[0x0]
    SQRDMLAH S26, S14, S6
    SQRDMLAH S3, S31, V2.S[0x2]
    SQRDMLAH H23, H5, H13
    SQRDMLSH S27, S26, S3
    SQRDMLSH H23, H27, V8.H[0x5]
    SQRDMLSH S14, S13, V10.S[0x3]
    SQRDMLSH H31, H29, V11.H[0x7]
    SQRDMLSH S19, S31, S29
    SQRDMLSH S20, S2, V19.S[0x0]
    SQRDMLAH S1, S9, V8.S[0x3]
    SQRDMLSH H0, H5, V12.H[0x6]
    SQRDMLSH S25, S15, V30.S[0x1]
    SQRDMLAH S22, S3, S22
    SQRDMLSH H27, H27, V2.H[0x0]
    SQRDMLAH H17, H8, H4
    SQRDMLAH S29, S25, V22.S[0x0]
    SQRDMLSH S28, S28, S17
    SQRDMLSH S30, S29, S24
    SQRDMLSH H10, H28, V14.H[0x3]
    SQRDMLAH S3, S30, S27
    SQRDMLAH S24, S20, S20
    SUBS  X9, X9, #0x1
    B.NE  LCRTAdvsimdScalarRDM_label_14
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X6, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdScalarRDM_TestFail
    MRS  X20, FPSR
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x800, LSL #16
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D0
    MOVZ  X6, #0x98b6, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D1
    MOVZ  X6, #0xf921, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D2
    MOVZ  X6, #0x904b, LSL #0
    MOVK  X6, #0x1, LSL #16
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D3
    MOVZ  X6, #0xfc15, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D4
    MOVZ  X6, #0x8002, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D5
    MOVZ  X6, #0x1a46, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D6
    MOVZ  X6, #0x3661, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D7
    MOVZ  X6, #0x34f7, LSL #0
    MOVK  X6, #0xa5a6, LSL #16
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D8
    MOVZ  X6, #0xc7c2, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D9
    MOVZ  X6, #0x30c5, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D10
    MOVZ  X6, #0x7641, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D11
    MOVZ  X6, #0xccba, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D12
    MOVZ  X6, #0xcb61, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D13
    MOVZ  X6, #0x751e, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D14
    MOVZ  X6, #0xf50, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D15
    MOVZ  X6, #0xa65, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D16
    MOVZ  X6, #0x7ffe, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D17
    MOVZ  X6, #0x188b, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D18
    MOVZ  X6, #0xda04, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D19
    MOVZ  X6, #0x4df9, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D20
    MOVZ  X6, #0xff91, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D21
    MOVZ  X6, #0xd98b, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D22
    MOVZ  X6, #0xd83a, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D23
    MOVZ  X6, #0xc62e, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D24
    MOVZ  X6, #0x8004, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D25
    MOVZ  X6, #0xfcd3, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D26
    MOVZ  X6, #0xdb5e, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D27
    MOVZ  X6, #0x4aa3, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D28
    MOVZ  X6, #0x45f9, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D29
    MOVZ  X6, #0x9d8a, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D30
    MOVZ  X6, #0x4b3, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail
    FMOV  X20, D31
    MOVZ  X6, #0x7ffd, LSL #0
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdScalarRDM_TestFail

LCRTAdvsimdScalarRDM_TestEnd:
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
LCRTAdvsimdScalarRDM_TestFail:
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
