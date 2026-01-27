.global TaishanSimdImmP01

.text
.p2align 4

TaishanSimdImmP01:

TaishanSimdImmP01_TestBegin:
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
    STP  Q0, Q1, [SP, #-32]!
    STP  Q2, Q3, [SP, #-32]!
    STP  Q4, Q5, [SP, #-32]!
    STP  Q6, Q7, [SP, #-32]!
    STP  Q8, Q9, [SP, #-32]!
    STP  Q10, Q11, [SP, #-32]!
    STP  Q12, Q13, [SP, #-32]!
    STP  Q14, Q15, [SP, #-32]!
    STP  Q16, Q17, [SP, #-32]!
    STP  Q18, Q19, [SP, #-32]!
    STP  Q20, Q21, [SP, #-32]!
    STP  Q22, Q23, [SP, #-32]!
    STP  Q24, Q25, [SP, #-32]!
    STP  Q26, Q27, [SP, #-32]!
    STP  Q28, Q29, [SP, #-32]!
    STP  Q30, Q31, [SP, #-32]!
    MRS  X2, FPCR
    MRS  X3, FPSR
    STP  X2, X3, [SP, #-16]!
    MRS  X1, NZCV
    STP  X1, X2, [SP, #-16]!
    MOVZ  X1, #0x0, LSL #0
    MOVK  X2, #0x6fce, LSL #48
    MOVK  X2, #0x746c, LSL #32
    MOVK  X2, #0xbb00, LSL #16
    MOVK  X2, #0x3663, LSL #0
    MOVK  X3, #0x8936, LSL #48
    MOVK  X3, #0x7797, LSL #32
    MOVK  X3, #0xbc13, LSL #16
    MOVK  X3, #0x94f3, LSL #0
    MOVK  X4, #0xee4a, LSL #48
    MOVK  X4, #0x2905, LSL #32
    MOVK  X4, #0x611b, LSL #16
    MOVK  X4, #0x5006, LSL #0
    MOVK  X5, #0xc9ac, LSL #48
    MOVK  X5, #0x411a, LSL #32
    MOVK  X5, #0x87d8, LSL #16
    MOVK  X5, #0x849b, LSL #0
    MOVK  X6, #0x599e, LSL #48
    MOVK  X6, #0xb23b, LSL #32
    MOVK  X6, #0xa0a3, LSL #16
    MOVK  X6, #0x5785, LSL #0
    MOVK  X7, #0x2b04, LSL #48
    MOVK  X7, #0x271, LSL #32
    MOVK  X7, #0x7950, LSL #16
    MOVK  X7, #0xe3b, LSL #0
    MOVK  X8, #0xbc73, LSL #48
    MOVK  X8, #0xba7e, LSL #32
    MOVK  X8, #0xcaa3, LSL #16
    MOVK  X8, #0x5374, LSL #0
    MOVK  X9, #0x11a3, LSL #48
    MOVK  X9, #0x8e19, LSL #32
    MOVK  X9, #0x65, LSL #16
    MOVK  X9, #0x2ef4, LSL #0
    MOVK  X10, #0x682c, LSL #48
    MOVK  X10, #0x81b, LSL #32
    MOVK  X10, #0x9ce8, LSL #16
    MOVK  X10, #0x1331, LSL #0
    MOVK  X11, #0xd6d, LSL #48
    MOVK  X11, #0x4e4b, LSL #32
    MOVK  X11, #0x3626, LSL #16
    MOVK  X11, #0x1560, LSL #0
    MOVK  X12, #0x859c, LSL #48
    MOVK  X12, #0x9fca, LSL #32
    MOVK  X12, #0x8c9f, LSL #16
    MOVK  X12, #0xb558, LSL #0
    MOVK  X13, #0x3e8, LSL #48
    MOVK  X13, #0xcb92, LSL #32
    MOVK  X13, #0x4128, LSL #16
    MOVK  X13, #0x2cb4, LSL #0
    MOVK  X14, #0x337a, LSL #48
    MOVK  X14, #0xbb4, LSL #32
    MOVK  X14, #0x6ca2, LSL #16
    MOVK  X14, #0xd0e4, LSL #0
    MOVK  X15, #0x1e12, LSL #48
    MOVK  X15, #0x9561, LSL #32
    MOVK  X15, #0xd036, LSL #16
    MOVK  X15, #0x6776, LSL #0
    MOVK  X16, #0x37d6, LSL #48
    MOVK  X16, #0x41f3, LSL #32
    MOVK  X16, #0xd17e, LSL #16
    MOVK  X16, #0x7d25, LSL #0
    MOVK  X17, #0x36f5, LSL #48
    MOVK  X17, #0xb66, LSL #32
    MOVK  X17, #0x2dc, LSL #16
    MOVK  X17, #0x196, LSL #0
    MOVK  X18, #0x664, LSL #48
    MOVK  X18, #0x5dbc, LSL #32
    MOVK  X18, #0x14bc, LSL #16
    MOVK  X18, #0x326e, LSL #0
    MOVK  X19, #0x468f, LSL #48
    MOVK  X19, #0x5566, LSL #32
    MOVK  X19, #0x1742, LSL #16
    MOVK  X19, #0x8c8e, LSL #0
    MOVK  X20, #0x51ad, LSL #48
    MOVK  X20, #0x3db6, LSL #32
    MOVK  X20, #0xb641, LSL #16
    MOVK  X20, #0x3d8c, LSL #0
    MOVK  X21, #0xaee1, LSL #48
    MOVK  X21, #0xfa63, LSL #32
    MOVK  X21, #0x92bf, LSL #16
    MOVK  X21, #0x5aec, LSL #0
    MOVK  X22, #0xab61, LSL #48
    MOVK  X22, #0xaffb, LSL #32
    MOVK  X22, #0x840e, LSL #16
    MOVK  X22, #0x4220, LSL #0
    MOVK  X24, #0xebaa, LSL #48
    MOVK  X24, #0x442a, LSL #32
    MOVK  X24, #0xf077, LSL #16
    MOVK  X24, #0x5489, LSL #0
    MOVK  X25, #0x5924, LSL #48
    MOVK  X25, #0x4923, LSL #32
    MOVK  X25, #0xfc9f, LSL #16
    MOVK  X25, #0x9240, LSL #0
    MOVK  X26, #0x6180, LSL #48
    MOVK  X26, #0x1986, LSL #32
    MOVK  X26, #0x4dc2, LSL #16
    MOVK  X26, #0xbfeb, LSL #0
    MOVK  X27, #0xe06e, LSL #48
    MOVK  X27, #0x41d6, LSL #32
    MOVK  X27, #0xd473, LSL #16
    MOVK  X27, #0x8ca5, LSL #0
    MOVK  X28, #0x80e, LSL #48
    MOVK  X28, #0x24f3, LSL #32
    MOVK  X28, #0xa24d, LSL #16
    MOVK  X28, #0x320c, LSL #0
    MOVK  X29, #0xed70, LSL #48
    MOVK  X29, #0x3fea, LSL #32
    MOVK  X29, #0x596b, LSL #16
    MOVK  X29, #0xd994, LSL #0
    SUBS  X21, X29, X19, ASR #46
    MOVZ  X17, #0x68af, LSL #0
    MOVK  X17, #0x38c0, LSL #16
    MSR  FPCR, X17
    MRS  X10, FPSR
    MOVZ  X8, #0xff60, LSL #0
    MOVK  X8, #0x7ff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    AND  X10, X10, X8
    MOVZ  X8, #0x0, LSL #0
    ORR  X10, X10, X8
    MSR  FPSR, X10
    ISB  SY
    MOVZ  X2, #0xcd2e, LSL #0
    MOVK  X2, #0xe9d3, LSL #16
    MOVK  X2, #0x9c8b, LSL #32
    MOVK  X2, #0x5e2, LSL #48
    MOVZ  X3, #0xc115, LSL #0
    MOVK  X3, #0xf4c2, LSL #16
    MOVK  X3, #0x4c3a, LSL #32
    MOVK  X3, #0x4b9a, LSL #48
    MOVZ  X4, #0x6c07, LSL #0
    MOVK  X4, #0x1502, LSL #16
    MOVK  X4, #0xd9fc, LSL #32
    MOVK  X4, #0x689f, LSL #48
    MOVZ  X5, #0xa8cf, LSL #0
    MOVK  X5, #0x98e8, LSL #16
    MOVK  X5, #0xf36d, LSL #32
    MOVK  X5, #0x8660, LSL #48
    MOVZ  X6, #0xf363, LSL #0
    MOVK  X6, #0xe45, LSL #16
    MOVK  X6, #0x4121, LSL #32
    MOVK  X6, #0xaa6b, LSL #48
    MOVZ  X7, #0x9cb7, LSL #0
    MOVK  X7, #0x5788, LSL #16
    MOVK  X7, #0x7fea, LSL #32
    MOVK  X7, #0x176d, LSL #48
    MOVZ  X8, #0x33dc, LSL #0
    MOVK  X8, #0xcaf6, LSL #16
    MOVK  X8, #0xe788, LSL #32
    MOVK  X8, #0xf5e3, LSL #48
    MOVZ  X9, #0x3a86, LSL #0
    MOVK  X9, #0x3f5c, LSL #16
    MOVK  X9, #0xa36e, LSL #32
    MOVK  X9, #0x4a65, LSL #48
    MOVZ  X10, #0xc99f, LSL #0
    MOVK  X10, #0x9d12, LSL #16
    MOVK  X10, #0x7123, LSL #32
    MOVK  X10, #0x102a, LSL #48
    MOVZ  X11, #0xaf11, LSL #0
    MOVK  X11, #0x2133, LSL #16
    MOVK  X11, #0xe8a9, LSL #32
    MOVK  X11, #0xbc53, LSL #48
    MOVZ  X12, #0x5519, LSL #0
    MOVK  X12, #0x9a04, LSL #16
    MOVK  X12, #0xa0e0, LSL #32
    MOVK  X12, #0xb0ce, LSL #48
    MOVZ  X13, #0x6ce9, LSL #0
    MOVK  X13, #0x3059, LSL #16
    MOVK  X13, #0xefa8, LSL #32
    MOVK  X13, #0x940, LSL #48
    MOVZ  X14, #0x7713, LSL #0
    MOVK  X14, #0x9df5, LSL #16
    MOVK  X14, #0xd011, LSL #32
    MOVK  X14, #0xf019, LSL #48
    MOVZ  X15, #0x4be9, LSL #0
    MOVK  X15, #0xca35, LSL #16
    MOVK  X15, #0xa1b4, LSL #32
    MOVK  X15, #0x881a, LSL #48
    MOVZ  X16, #0x8af8, LSL #0
    MOVK  X16, #0x173a, LSL #16
    MOVK  X16, #0x49d0, LSL #32
    MOVK  X16, #0x32c2, LSL #48
    MOVZ  X17, #0x3d5, LSL #0
    MOVK  X17, #0xf9ab, LSL #16
    MOVK  X17, #0xd6cd, LSL #32
    MOVK  X17, #0xd58d, LSL #48
    MOVZ  X18, #0xb2a0, LSL #0
    MOVK  X18, #0x4a57, LSL #16
    MOVK  X18, #0x10a6, LSL #32
    MOVK  X18, #0xb6, LSL #48
    MOVZ  X19, #0xe341, LSL #0
    MOVK  X19, #0x9146, LSL #16
    MOVK  X19, #0xc4, LSL #32
    MOVK  X19, #0xf471, LSL #48
    MOVZ  X20, #0xf60d, LSL #0
    MOVK  X20, #0xd4e9, LSL #16
    MOVK  X20, #0xee17, LSL #32
    MOVK  X20, #0x649b, LSL #48
    MOVZ  X21, #0x9cff, LSL #0
    MOVK  X21, #0x675, LSL #16
    MOVK  X21, #0xb9de, LSL #32
    MOVK  X21, #0x6c24, LSL #48
    MOVZ  X22, #0xa571, LSL #0
    MOVK  X22, #0xef1e, LSL #16
    MOVK  X22, #0xfae9, LSL #32
    MOVK  X22, #0xa9f0, LSL #48
    MOVZ  X24, #0x74fa, LSL #0
    MOVK  X24, #0x7631, LSL #16
    MOVK  X24, #0xd0c3, LSL #32
    MOVK  X24, #0x4beb, LSL #48
    MOVZ  X25, #0x39bb, LSL #0
    MOVK  X25, #0xbad0, LSL #16
    MOVK  X25, #0x8a63, LSL #32
    MOVK  X25, #0x4d42, LSL #48
    MOVZ  X26, #0x611b, LSL #0
    MOVK  X26, #0x29b5, LSL #16
    MOVK  X26, #0x4c5, LSL #32
    MOVK  X26, #0x278b, LSL #48
    MOVZ  X27, #0x5ab3, LSL #0
    MOVK  X27, #0xc1bb, LSL #16
    MOVK  X27, #0xa791, LSL #32
    MOVK  X27, #0xc7d3, LSL #48
    MOVZ  X28, #0x7755, LSL #0
    MOVK  X28, #0xe6fb, LSL #16
    MOVK  X28, #0xabbe, LSL #32
    MOVK  X28, #0x33a7, LSL #48
    MOVZ  X29, #0x281e, LSL #0
    MOVK  X29, #0x7f65, LSL #16
    MOVK  X29, #0x3540, LSL #32
    MOVK  X29, #0xcc01, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X28
    FMOV  D1, X27
    FMOV  V1.D[1], X12
    FMOV  D2, X2
    FMOV  V2.D[1], X15
    FMOV  D3, X9
    FMOV  V3.D[1], X29
    FMOV  D4, X7
    FMOV  V4.D[1], X2
    FMOV  D5, X5
    FMOV  V5.D[1], X16
    FMOV  D6, X4
    FMOV  V6.D[1], X3
    FMOV  D7, X20
    FMOV  V7.D[1], X2
    FMOV  D8, X14
    FMOV  V8.D[1], X21
    FMOV  D9, X12
    FMOV  V9.D[1], X16
    FMOV  D10, X28
    FMOV  V10.D[1], X20
    FMOV  D11, X2
    FMOV  V11.D[1], X26
    FMOV  D12, X12
    FMOV  V12.D[1], X25
    FMOV  D13, X19
    FMOV  V13.D[1], X7
    FMOV  D14, X17
    FMOV  V14.D[1], X3
    FMOV  D15, X2
    FMOV  V15.D[1], X4
    FMOV  D16, X19
    FMOV  V16.D[1], X26
    FMOV  D17, X6
    FMOV  V17.D[1], X14
    FMOV  D18, X18
    FMOV  V18.D[1], X25
    FMOV  D19, X6
    FMOV  V19.D[1], X10
    FMOV  D20, X28
    FMOV  V20.D[1], X25
    FMOV  D21, X12
    FMOV  V21.D[1], X4
    FMOV  D22, X13
    FMOV  V22.D[1], X25
    FMOV  D23, X20
    FMOV  V23.D[1], X21
    FMOV  D24, X20
    FMOV  V24.D[1], X20
    FMOV  D25, X27
    FMOV  V25.D[1], X22
    FMOV  D26, X6
    FMOV  V26.D[1], X10
    FMOV  D27, X16
    FMOV  V27.D[1], X25
    FMOV  D28, X21
    FMOV  V28.D[1], X29
    FMOV  D29, X2
    FMOV  V29.D[1], X15
    FMOV  D30, X3
    FMOV  V30.D[1], X27
    FMOV  D31, X19
    FMOV  V31.D[1], X2
    MOVZ  X13, #0xa, LSL #0
TaishanSimdImmP01_label_0:
    ADDP  V14.8H, V27.8H, V25.8H
    ADD  D5, D10, D28
    ADDV  H13, V14.4H
    ADDV  B16, V17.8B
    ADDV  S19, V31.4S
    ADD  V26.8H, V9.8H, V11.8H
    ADDP  V7.2D, V2.2D, V3.2D
    ADD  V23.8B, V19.8B, V13.8B
    ADDV  B22, V28.8B
    ADD  D9, D7, D24
    ADDV  B21, V11.8B
    ADDP  D29, V23.2D
    ADD  D10, D12, D30
    ADDV  S11, V9.4S
    ADDP  D9, V5.2D
    ADDV  H22, V16.4H
    ADDHN2  V12.8H, V14.4S, V3.4S
    ADDHN  V1.4H, V20.4S, V20.4S
    ADDV  H22, V19.4H
    ADDP  V21.2D, V23.2D, V2.2D
    ADDP  V10.2S, V26.2S, V5.2S
    ADD  D10, D10, D19
    ADDV  S19, V16.4S
    ADDV  H24, V19.4H
    ADD  D24, D20, D23
    ADDHN2  V10.4S, V1.2D, V13.2D
    ADDHN2  V21.8H, V9.4S, V20.4S
    ADDV  S4, V28.4S
    ADDP  D2, V11.2D
    ADDP  V23.4S, V23.4S, V14.4S
    ADD  V1.8H, V24.8H, V13.8H
    ADDP  D4, V22.2D
    ADDHN2  V6.8H, V18.4S, V1.4S
    ADDV  B16, V10.8B
    ADD  D19, D3, D1
    ADDP  D10, V22.2D
    ADD  D4, D5, D8
    ADDP  D10, V23.2D
    ADD  V16.2D, V16.2D, V14.2D
    ADDV  B28, V9.8B
    ADD  V7.8H, V16.8H, V12.8H
    ADDP  V12.2S, V24.2S, V27.2S
    ADDHN2  V5.8H, V16.4S, V28.4S
    ADD  V20.8B, V27.8B, V1.8B
    ADDP  V0.8H, V6.8H, V15.8H
    ADDV  S18, V28.4S
    ADDV  B15, V3.8B
    ADDP  V27.2S, V25.2S, V16.2S
    ADDHN2  V16.8H, V31.4S, V26.4S
    ADDV  S25, V23.4S
    ADDHN2  V10.8H, V27.4S, V18.4S
    ADDP  D20, V4.2D
    ADDV  B7, V9.8B
    ADDV  S3, V20.4S
    ADD  V10.16B, V28.16B, V22.16B
    ADDV  B19, V19.16B
    ADDP  D27, V15.2D
    ADDV  H1, V26.4H
    ADDHN  V16.8B, V28.8H, V4.8H
    ADDV  H27, V9.4H
    ADDV  H6, V30.4H
    ADDP  D14, V12.2D
    ADDP  D6, V1.2D
    ADDP  D5, V7.2D
    ADDP  V26.4S, V1.4S, V19.4S
    ADDHN  V31.8B, V1.8H, V10.8H
    ADDP  D27, V9.2D
    ADDP  D29, V16.2D
    ADDHN  V26.4H, V14.4S, V9.4S
    ADDV  H25, V29.4H
    ADDP  V23.8B, V9.8B, V11.8B
    ADDP  D20, V24.2D
    ADDV  B24, V5.8B
    ADDV  S20, V26.4S
    ADDV  B10, V25.8B
    ADD  D5, D13, D6
    ADDP  D26, V16.2D
    ADD  D10, D19, D26
    ADDP  D13, V21.2D
    ADDV  H22, V21.4H
    ADDV  H0, V18.8H
    ADDV  H21, V21.8H
    ADDV  S21, V30.4S
    ADDV  S31, V23.4S
    ADD  V31.8B, V3.8B, V23.8B
    ADDHN2  V21.16B, V6.8H, V29.8H
    ADD  V28.4H, V5.4H, V1.4H
    ADDV  H30, V20.8H
    ADDV  H23, V27.8H
    ADDV  B18, V11.16B
    ADD  D10, D11, D2
    ADDHN  V7.8B, V10.8H, V5.8H
    ADDHN  V19.4H, V31.4S, V28.4S
    ADDP  V27.4S, V18.4S, V19.4S
    ADD  D7, D10, D27
    ADDHN2  V29.16B, V19.8H, V3.8H
    ADD  V20.8H, V24.8H, V1.8H
    ADDV  H20, V17.8H
    ADD  V10.8B, V20.8B, V11.8B
    ADDV  S19, V10.4S
    ADDP  V6.8H, V17.8H, V9.8H
    ADDHN2  V19.16B, V0.8H, V23.8H
    ADD  D31, D8, D19
    ADDHN2  V17.8H, V31.4S, V7.4S
    ADDP  D1, V10.2D
    ADD  V1.8B, V21.8B, V10.8B
    ADD  D30, D22, D21
    ADDHN  V3.8B, V22.8H, V19.8H
    ADD  D11, D22, D17
    ADDP  V0.8B, V1.8B, V21.8B
    ADD  D14, D13, D8
    ADDV  B20, V19.8B
    ADDHN  V17.4H, V26.4S, V13.4S
    ADDV  B11, V23.8B
    ADDHN  V22.4H, V19.4S, V23.4S
    ADD  V10.16B, V10.16B, V21.16B
    ADD  V8.4H, V0.4H, V0.4H
    ADDV  B29, V21.16B
    ADDHN2  V20.8H, V21.4S, V14.4S
    ADDP  V12.8B, V24.8B, V29.8B
    ADD  V3.2D, V9.2D, V30.2D
    ADDV  H1, V8.4H
    ADDHN2  V31.16B, V31.8H, V11.8H
    ADD  D30, D0, D6
    ADDP  V17.4H, V8.4H, V13.4H
    ADDP  D25, V7.2D
    ADD  D9, D25, D4
    ADDP  V15.2S, V13.2S, V27.2S
    ADDV  S6, V6.4S
    ADD  D22, D25, D9
    ADD  D1, D4, D10
    ADDV  S26, V7.4S
    ADDHN  V30.2S, V0.2D, V1.2D
    ADDV  B7, V7.8B
    ADD  V26.8B, V22.8B, V25.8B
    ADDV  S0, V30.4S
    ADDP  V7.8H, V15.8H, V15.8H
    ADDV  B22, V1.8B
    ADDP  V13.2S, V0.2S, V27.2S
    ADDHN  V8.4H, V6.4S, V30.4S
    ADDV  S27, V20.4S
    ADDP  D4, V0.2D
    ADDHN2  V7.8H, V28.4S, V27.4S
    ADDHN2  V24.8H, V16.4S, V29.4S
    ADDHN2  V22.16B, V26.8H, V9.8H
    ADDV  B18, V17.8B
    ADDHN  V0.4H, V8.4S, V18.4S
    ADDP  V17.16B, V17.16B, V23.16B
    ADDP  D24, V4.2D
    ADDP  D7, V8.2D
    ADDP  D20, V19.2D
    ADDV  S5, V0.4S
    ADDP  D23, V13.2D
    ADDV  S25, V17.4S
    ADD  D29, D28, D24
    ADD  V28.16B, V27.16B, V23.16B
    ADDP  D9, V10.2D
    ADDV  B0, V22.16B
    ADDP  V25.8B, V21.8B, V6.8B
    ADDHN  V19.8B, V5.8H, V9.8H
    ADDV  S22, V19.4S
    ADDHN  V22.2S, V21.2D, V28.2D
    ADDV  B3, V0.16B
    ADDV  S9, V22.4S
    ADDV  S24, V7.4S
    ADDV  B14, V29.16B
    ADD  V14.2S, V31.2S, V25.2S
    ADDV  S1, V6.4S
    ADDV  B8, V19.16B
    ADDP  V19.8H, V31.8H, V11.8H
    ADDP  V31.2S, V21.2S, V12.2S
    ADDP  V27.4S, V21.4S, V26.4S
    ADDV  H29, V23.8H
    ADDV  S17, V31.4S
    ADDV  H21, V30.8H
    ADD  V1.2S, V27.2S, V27.2S
    ADD  D2, D30, D10
    ADDV  H8, V11.8H
    ADDV  H20, V6.8H
    ADDV  H23, V21.4H
    ADDP  V7.2D, V6.2D, V13.2D
    ADDP  V16.4H, V25.4H, V23.4H
    ADDP  D3, V9.2D
    ADD  D3, D20, D1
    ADDV  S15, V31.4S
    ADDV  S21, V18.4S
    ADDHN2  V26.16B, V6.8H, V6.8H
    ADDP  V2.2S, V8.2S, V8.2S
    ADDP  V30.4S, V20.4S, V8.4S
    ADDV  H22, V4.8H
    ADDV  S15, V22.4S
    ADDV  S24, V4.4S
    ADDV  H18, V24.8H
    ADDP  V5.2S, V26.2S, V22.2S
    ADDV  B21, V14.16B
    ADDHN2  V6.8H, V21.4S, V14.4S
    ADD  V2.2S, V11.2S, V26.2S
    ADD  V19.8B, V24.8B, V19.8B
    ADD  D8, D8, D22
    ADD  V1.2S, V1.2S, V5.2S
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdImmP01_label_0
    MOVZ  X15, #0xcd2e, LSL #0
    MOVK  X15, #0xe9d3, LSL #16
    MOVK  X15, #0x9c8b, LSL #32
    MOVK  X15, #0x5e2, LSL #48
    SUB  X3, X15, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x6c07, LSL #0
    MOVK  X12, #0x1502, LSL #16
    MOVK  X12, #0xd9fc, LSL #32
    MOVK  X12, #0x689f, LSL #48
    SUB  X16, X12, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0xa8cf, LSL #0
    MOVK  X4, #0x98e8, LSL #16
    MOVK  X4, #0xf36d, LSL #32
    MOVK  X4, #0x8660, LSL #48
    SUB  X9, X4, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0xf363, LSL #0
    MOVK  X9, #0xe45, LSL #16
    MOVK  X9, #0x4121, LSL #32
    MOVK  X9, #0xaa6b, LSL #48
    SUB  X3, X9, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x9cb7, LSL #0
    MOVK  X2, #0x5788, LSL #16
    MOVK  X2, #0x7fea, LSL #32
    MOVK  X2, #0x176d, LSL #48
    SUB  X15, X2, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x33dc, LSL #0
    MOVK  X10, #0xcaf6, LSL #16
    MOVK  X10, #0xe788, LSL #32
    MOVK  X10, #0xf5e3, LSL #48
    SUB  X16, X10, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0xf363, LSL #0
    MOVK  X26, #0xe45, LSL #16
    MOVK  X26, #0x4121, LSL #32
    MOVK  X26, #0xaa6b, LSL #48
    SUB  X21, X26, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x33dc, LSL #0
    MOVK  X4, #0xcaf6, LSL #16
    MOVK  X4, #0xe788, LSL #32
    MOVK  X4, #0xf5e3, LSL #48
    SUB  X24, X4, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X17, #0xaf11, LSL #0
    MOVK  X17, #0x2133, LSL #16
    MOVK  X17, #0xe8a9, LSL #32
    MOVK  X17, #0xbc53, LSL #48
    SUB  X3, X17, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x6c07, LSL #0
    MOVK  X28, #0x1502, LSL #16
    MOVK  X28, #0xd9fc, LSL #32
    MOVK  X28, #0x689f, LSL #48
    SUB  X19, X28, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x7713, LSL #0
    MOVK  X28, #0x9df5, LSL #16
    MOVK  X28, #0xd011, LSL #32
    MOVK  X28, #0xf019, LSL #48
    SUB  X9, X28, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xb2a0, LSL #0
    MOVK  X21, #0x4a57, LSL #16
    MOVK  X21, #0x10a6, LSL #32
    MOVK  X21, #0xb6, LSL #48
    SUB  X3, X21, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0xf60d, LSL #0
    MOVK  X24, #0xd4e9, LSL #16
    MOVK  X24, #0xee17, LSL #32
    MOVK  X24, #0x649b, LSL #48
    SUB  X2, X24, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0xb2a0, LSL #0
    MOVK  X6, #0x4a57, LSL #16
    MOVK  X6, #0x10a6, LSL #32
    MOVK  X6, #0xb6, LSL #48
    SUB  X16, X6, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xa571, LSL #0
    MOVK  X2, #0xef1e, LSL #16
    MOVK  X2, #0xfae9, LSL #32
    MOVK  X2, #0xa9f0, LSL #48
    SUB  X9, X2, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0xf60d, LSL #0
    MOVK  X29, #0xd4e9, LSL #16
    MOVK  X29, #0xee17, LSL #32
    MOVK  X29, #0x649b, LSL #48
    SUB  X7, X29, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0xf363, LSL #0
    MOVK  X15, #0xe45, LSL #16
    MOVK  X15, #0x4121, LSL #32
    MOVK  X15, #0xaa6b, LSL #48
    SUB  X12, X15, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x5ab3, LSL #0
    MOVK  X25, #0xc1bb, LSL #16
    MOVK  X25, #0xa791, LSL #32
    MOVK  X25, #0xc7d3, LSL #48
    SUB  X9, X25, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x7713, LSL #0
    MOVK  X10, #0x9df5, LSL #16
    MOVK  X10, #0xd011, LSL #32
    MOVK  X10, #0xf019, LSL #48
    SUB  X17, X10, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0xf60d, LSL #0
    MOVK  X26, #0xd4e9, LSL #16
    MOVK  X26, #0xee17, LSL #32
    MOVK  X26, #0x649b, LSL #48
    SUB  X25, X26, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X29, D2
    MOVZ  X8, #0x2128, LSL #0
    MOVK  X8, #0xc5e9, LSL #16
    MOVK  X8, #0xea, LSL #32
    SUB  X5, X8, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X9, D3
    MOVZ  X10, #0xfcaf, LSL #0
    MOVK  X10, #0x1, LSL #16
    MOVK  X10, #0x4e, LSL #32
    SUB  X26, X10, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X25, D4
    MOVZ  X2, #0x17f, LSL #0
    SUB  X22, X2, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X26, D5
    MOVZ  X19, #0x21a0, LSL #0
    MOVK  X19, #0xc5e9, LSL #16
    MOVK  X19, #0x17f, LSL #32
    SUB  X14, X19, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X26, #0xc55f, LSL #0
    SUB  X29, X26, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X22, D6
    MOVZ  X26, #0xd5bd, LSL #0
    MOVK  X26, #0xe6, LSL #16
    SUB  X29, X26, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X14, #0x17f, LSL #0
    MOVK  X14, #0xcc, LSL #32
    SUB  X16, X14, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X2, D7
    MOVZ  X14, #0xd5bd, LSL #0
    MOVK  X14, #0xe6, LSL #16
    SUB  X16, X14, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X29, D8
    MOVZ  X22, #0x1f1, LSL #0
    SUB  X6, X22, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X21, D9
    MOVZ  X8, #0xcc, LSL #0
    SUB  X25, X8, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X21, #0x27, LSL #0
    SUB  X27, X21, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X2, D10
    MOVZ  X21, #0x2b1d, LSL #0
    MOVK  X21, #0xc55f, LSL #16
    SUB  X27, X21, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X6, D11
    MOVZ  X18, #0x72, LSL #0
    SUB  X7, X18, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X17, D12
    MOVZ  X25, #0x71, LSL #0
    MOVK  X25, #0xc0, LSL #32
    SUB  X24, X25, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X9, D13
    MOVZ  X25, #0x17f, LSL #0
    MOVK  X25, #0xcc, LSL #32
    SUB  X10, X25, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X5, D14
    MOVZ  X3, #0x9a75, LSL #0
    MOVK  X3, #0xc55f, LSL #16
    MOVK  X3, #0xe692, LSL #32
    SUB  X18, X3, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X26, D15
    MOVZ  X19, #0x17f, LSL #0
    SUB  X7, X19, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X5, D16
    MOVZ  X2, #0x99, LSL #0
    MOVK  X2, #0xe692, LSL #16
    MOVK  X2, #0x17f, LSL #32
    SUB  X17, X2, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X9, D17
    MOVZ  X24, #0x9437, LSL #0
    SUB  X2, X24, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X6, D18
    MOVZ  X21, #0x17f, LSL #0
    SUB  X15, X21, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X15, D19
    MOVZ  X24, #0x60ba, LSL #0
    MOVK  X24, #0xc59a, LSL #32
    SUB  X6, X24, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X8, D20
    MOVZ  X28, #0xd6a3, LSL #0
    SUB  X11, X28, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X29, D21
    MOVZ  X27, #0xab, LSL #0
    SUB  X12, X27, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X29, D22
    MOVZ  X4, #0x17f, LSL #0
    SUB  X13, X4, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X18, D24
    MOVZ  X13, #0x17f, LSL #0
    SUB  X29, X13, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X13, D25
    MOVZ  X10, #0x99, LSL #0
    MOVK  X10, #0xe692, LSL #32
    SUB  X8, X10, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X3, #0x1ab, LSL #0
    SUB  X15, X3, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X24, D26
    MOVZ  X3, #0x20b6, LSL #0
    MOVK  X3, #0xc5e9, LSL #16
    MOVK  X3, #0xea, LSL #32
    SUB  X15, X3, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X4, #0x21a0, LSL #0
    MOVK  X4, #0xc5e9, LSL #16
    SUB  X12, X4, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X24, D27
    MOVZ  X4, #0x9306, LSL #0
    MOVK  X4, #0x27, LSL #32
    SUB  X12, X4, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X13, D28
    MOVZ  X25, #0x153, LSL #0
    MOVK  X25, #0xcc, LSL #32
    SUB  X22, X25, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X12, D29
    MOVZ  X10, #0x24b, LSL #0
    SUB  X6, X10, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X25
    FMOV  V0.D[1], X21
    FMOV  D1, X17
    FMOV  V1.D[1], X3
    FMOV  D2, X26
    FMOV  V2.D[1], X20
    FMOV  D3, X14
    FMOV  V3.D[1], X18
    FMOV  D4, X28
    FMOV  V4.D[1], X12
    FMOV  D5, X16
    FMOV  V5.D[1], X28
    FMOV  D6, X27
    FMOV  V6.D[1], X29
    FMOV  D7, X5
    FMOV  V7.D[1], X6
    FMOV  D8, X22
    FMOV  V8.D[1], X9
    FMOV  D9, X27
    FMOV  V9.D[1], X9
    FMOV  D10, X24
    FMOV  V10.D[1], X6
    FMOV  D11, X26
    FMOV  V11.D[1], X8
    FMOV  D12, X20
    FMOV  V12.D[1], X22
    FMOV  D13, X4
    FMOV  V13.D[1], X12
    FMOV  D14, X26
    FMOV  V14.D[1], X12
    FMOV  D15, X5
    FMOV  V15.D[1], X17
    FMOV  D16, X21
    FMOV  V16.D[1], X14
    FMOV  D17, X14
    FMOV  V17.D[1], X18
    FMOV  D18, X12
    FMOV  V18.D[1], X11
    FMOV  D19, X26
    FMOV  V19.D[1], X8
    FMOV  D20, X10
    FMOV  V20.D[1], X8
    FMOV  D21, X2
    FMOV  V21.D[1], X26
    FMOV  D22, X9
    FMOV  V22.D[1], X11
    FMOV  D23, X15
    FMOV  V23.D[1], X8
    FMOV  D24, X6
    FMOV  V24.D[1], X17
    FMOV  D25, X7
    FMOV  V25.D[1], X16
    FMOV  D26, X22
    FMOV  V26.D[1], X17
    FMOV  D27, X20
    FMOV  V27.D[1], X15
    FMOV  D28, X2
    FMOV  V28.D[1], X18
    FMOV  D29, X26
    FMOV  V29.D[1], X14
    FMOV  D30, X6
    FMOV  V30.D[1], X3
    FMOV  D31, X21
    FMOV  V31.D[1], X28
    MOVZ  X28, #0xa, LSL #0
TaishanSimdImmP01_label_83:
    ADDP  D26, V31.2D
    ADDHN  V10.8B, V29.8H, V18.8H
    ADDP  V19.8B, V29.8B, V3.8B
    ADDV  H9, V2.8H
    ADD  D16, D26, D21
    ADDV  H11, V10.8H
    ADDV  B7, V2.16B
    ADDV  B6, V23.8B
    ADDHN2  V12.8H, V31.4S, V12.4S
    ADDP  D26, V29.2D
    ADD  D31, D1, D10
    ADD  V26.4H, V27.4H, V25.4H
    ADD  D4, D14, D3
    ADDHN  V11.4H, V25.4S, V18.4S
    ADDP  D20, V4.2D
    ADDV  H27, V10.8H
    ADD  V11.4H, V16.4H, V9.4H
    ADD  D20, D5, D18
    ADD  D26, D6, D21
    ADDP  D2, V2.2D
    ADD  D16, D27, D22
    ADDV  S23, V12.4S
    ADD  D8, D31, D10
    ADDV  B9, V21.16B
    ADDHN  V17.2S, V20.2D, V30.2D
    ADDHN2  V12.4S, V22.2D, V19.2D
    ADDP  V15.16B, V11.16B, V15.16B
    ADD  D29, D22, D31
    ADDV  H28, V7.8H
    ADDHN  V29.8B, V0.8H, V17.8H
    ADDP  D22, V29.2D
    ADD  D7, D28, D31
    ADDHN2  V30.4S, V5.2D, V27.2D
    ADD  V31.4S, V17.4S, V30.4S
    ADDV  B12, V0.16B
    ADDV  S27, V1.4S
    ADDV  S4, V12.4S
    ADDP  D6, V22.2D
    ADDP  V27.4S, V4.4S, V10.4S
    ADDP  V11.4S, V18.4S, V16.4S
    ADD  V4.2D, V13.2D, V4.2D
    ADD  D11, D28, D4
    ADDV  H19, V31.8H
    ADDHN  V6.8B, V30.8H, V5.8H
    ADDV  S28, V18.4S
    ADDP  D24, V29.2D
    ADDV  B5, V7.8B
    ADDV  S1, V12.4S
    ADDHN  V15.8B, V7.8H, V7.8H
    ADDP  V13.2D, V28.2D, V13.2D
    ADDV  H13, V22.4H
    ADD  V7.4S, V16.4S, V10.4S
    ADD  V13.2D, V4.2D, V13.2D
    ADDHN2  V18.4S, V15.2D, V24.2D
    ADDP  V1.2S, V4.2S, V20.2S
    ADDV  S23, V27.4S
    ADDHN  V6.2S, V14.2D, V18.2D
    ADDP  V1.8B, V16.8B, V3.8B
    ADDHN  V16.4H, V21.4S, V7.4S
    ADDV  B28, V6.16B
    ADDHN  V28.4H, V5.4S, V7.4S
    ADDV  B24, V16.16B
    ADDHN  V11.4H, V0.4S, V20.4S
    ADDHN2  V13.8H, V6.4S, V22.4S
    ADDV  S18, V24.4S
    ADDV  H13, V22.4H
    ADDP  D17, V15.2D
    ADDV  H11, V11.8H
    ADD  V5.2D, V29.2D, V20.2D
    ADDHN  V24.8B, V18.8H, V1.8H
    ADDHN2  V24.8H, V10.4S, V22.4S
    ADD  V0.16B, V26.16B, V29.16B
    ADD  V31.16B, V29.16B, V10.16B
    ADDV  H2, V31.8H
    ADDP  D31, V14.2D
    ADDV  H2, V4.8H
    ADDV  S26, V17.4S
    ADDV  H29, V22.8H
    ADDV  S17, V1.4S
    ADDV  B13, V14.8B
    ADDV  S17, V29.4S
    ADDP  V8.4H, V5.4H, V11.4H
    ADD  D3, D26, D24
    ADDV  B11, V2.16B
    ADDP  V11.2S, V2.2S, V4.2S
    ADD  D15, D22, D18
    ADDP  V30.8B, V11.8B, V4.8B
    ADDHN  V29.4H, V31.4S, V22.4S
    ADDP  D30, V1.2D
    ADDV  S10, V10.4S
    ADDP  V22.4S, V12.4S, V28.4S
    ADDV  B16, V31.16B
    ADDHN  V22.4H, V9.4S, V25.4S
    ADDV  S22, V9.4S
    ADDV  B12, V28.8B
    ADDV  H3, V12.8H
    ADD  V29.8B, V30.8B, V11.8B
    ADDHN  V13.2S, V17.2D, V26.2D
    ADDP  V8.16B, V31.16B, V6.16B
    ADDV  S24, V2.4S
    ADDHN2  V31.8H, V15.4S, V7.4S
    ADDP  V27.8H, V26.8H, V8.8H
    ADDP  D3, V9.2D
    ADDV  S24, V28.4S
    ADDV  B8, V29.8B
    ADDHN  V13.8B, V2.8H, V4.8H
    ADDP  V23.8H, V7.8H, V2.8H
    ADDP  V21.8H, V7.8H, V31.8H
    ADD  D27, D30, D2
    ADDV  H12, V30.4H
    ADDP  D9, V21.2D
    ADDP  D17, V1.2D
    ADD  V5.8H, V30.8H, V19.8H
    ADDV  B18, V2.8B
    ADDV  H25, V25.4H
    ADDV  S6, V0.4S
    ADDV  H20, V28.8H
    ADDHN  V19.4H, V8.4S, V15.4S
    ADDHN2  V28.8H, V10.4S, V1.4S
    ADD  D17, D27, D18
    ADDV  S8, V16.4S
    ADDHN  V3.4H, V29.4S, V1.4S
    ADDHN2  V26.8H, V27.4S, V17.4S
    ADDHN2  V23.4S, V26.2D, V20.2D
    ADDV  B27, V29.8B
    ADDV  H27, V8.4H
    ADDHN  V12.4H, V7.4S, V23.4S
    ADDV  S28, V17.4S
    ADDP  V24.4H, V19.4H, V23.4H
    ADDHN2  V13.16B, V10.8H, V3.8H
    ADDV  H24, V31.8H
    ADDP  V24.8H, V29.8H, V18.8H
    ADDHN2  V11.8H, V10.4S, V10.4S
    ADDP  V27.2S, V5.2S, V1.2S
    ADDV  B23, V21.16B
    ADD  V17.2D, V10.2D, V0.2D
    ADD  V0.2S, V2.2S, V17.2S
    ADDHN  V7.4H, V11.4S, V11.4S
    ADDP  D0, V19.2D
    ADDP  V16.2D, V15.2D, V1.2D
    ADDP  V23.2D, V21.2D, V9.2D
    ADDHN2  V5.16B, V6.8H, V12.8H
    ADDV  H28, V10.4H
    ADDHN2  V26.8H, V3.4S, V14.4S
    ADDHN  V10.2S, V5.2D, V6.2D
    ADDV  S28, V8.4S
    ADDV  B24, V27.8B
    ADDV  S31, V13.4S
    ADD  D31, D21, D16
    ADDP  V13.8B, V23.8B, V15.8B
    ADDHN2  V1.8H, V20.4S, V16.4S
    ADDP  V8.8H, V25.8H, V13.8H
    ADDP  D13, V27.2D
    ADD  D7, D8, D8
    ADD  V21.16B, V3.16B, V1.16B
    ADDP  V0.8H, V16.8H, V19.8H
    ADD  V18.8B, V5.8B, V18.8B
    ADD  D28, D23, D13
    ADD  D4, D28, D25
    ADDHN2  V6.16B, V7.8H, V28.8H
    ADDV  B25, V12.8B
    ADDV  S27, V16.4S
    ADD  D24, D26, D27
    ADDV  H16, V21.8H
    ADDHN  V14.2S, V1.2D, V3.2D
    ADDV  S15, V11.4S
    ADDHN  V25.8B, V16.8H, V13.8H
    ADDV  B26, V8.16B
    ADDV  S1, V2.4S
    ADDHN2  V21.16B, V30.8H, V18.8H
    ADDP  V22.8B, V13.8B, V8.8B
    ADDHN2  V20.4S, V11.2D, V23.2D
    ADDV  H7, V16.4H
    ADD  D9, D26, D27
    ADDP  D2, V4.2D
    ADDV  S30, V20.4S
    ADDV  B20, V4.8B
    ADDV  H26, V6.8H
    ADDP  V15.8B, V28.8B, V3.8B
    ADDP  D5, V3.2D
    ADDP  V14.2D, V24.2D, V0.2D
    ADD  V1.4H, V8.4H, V24.4H
    ADDP  V13.8H, V5.8H, V5.8H
    ADD  V15.8B, V22.8B, V6.8B
    ADD  D12, D8, D28
    ADDV  B1, V0.16B
    ADDP  V2.4S, V3.4S, V25.4S
    ADDV  S1, V15.4S
    ADD  V17.4S, V18.4S, V15.4S
    ADDP  V17.8H, V6.8H, V14.8H
    ADDHN  V1.2S, V2.2D, V25.2D
    ADDP  D4, V6.2D
    ADDP  V20.4H, V24.4H, V7.4H
    ADDV  B2, V11.8B
    ADDP  V26.8H, V27.8H, V10.8H
    ADDV  H23, V5.4H
    ADDV  B30, V16.8B
    ADDV  S1, V10.4S
    ADDP  V11.4S, V10.4S, V9.4S
    ADDV  B3, V5.16B
    SUBS  X28, X28, #0x1
    B.NE  TaishanSimdImmP01_label_83
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X22, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X29, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X17, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X13, D5
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X8, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X21, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X6, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X11, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X9, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X18, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X11, D12
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X8, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X12, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X26, D15
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X17, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X11, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X4, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X25, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X29, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X8, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X27, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X3, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X3, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X25, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X28, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X13, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X9, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
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
    FMOV  V0.D[1], X7
    FMOV  D1, X17
    FMOV  V1.D[1], X2
    FMOV  D2, X20
    FMOV  V2.D[1], X24
    FMOV  D3, X18
    FMOV  V3.D[1], X8
    FMOV  D4, X19
    FMOV  V4.D[1], X6
    FMOV  D5, X26
    FMOV  V5.D[1], X28
    FMOV  D6, X29
    FMOV  V6.D[1], X18
    FMOV  D7, X26
    FMOV  V7.D[1], X13
    FMOV  D8, X25
    FMOV  V8.D[1], X22
    FMOV  D9, X22
    FMOV  V9.D[1], X9
    FMOV  D10, X22
    FMOV  V10.D[1], X13
    FMOV  D11, X24
    FMOV  V11.D[1], X6
    FMOV  D12, X9
    FMOV  V12.D[1], X25
    FMOV  D13, X20
    FMOV  V13.D[1], X9
    FMOV  D14, X2
    FMOV  V14.D[1], X6
    FMOV  D15, X10
    FMOV  V15.D[1], X18
    FMOV  D16, X29
    FMOV  V16.D[1], X6
    FMOV  D17, X2
    FMOV  V17.D[1], X14
    FMOV  D18, X24
    FMOV  V18.D[1], X22
    FMOV  D19, X25
    FMOV  V19.D[1], X18
    FMOV  D20, X29
    FMOV  V20.D[1], X15
    FMOV  D21, X14
    FMOV  V21.D[1], X22
    FMOV  D22, X15
    FMOV  V22.D[1], X25
    FMOV  D23, X14
    FMOV  V23.D[1], X11
    FMOV  D24, X18
    FMOV  V24.D[1], X12
    FMOV  D25, X2
    FMOV  V25.D[1], X19
    FMOV  D26, X3
    FMOV  V26.D[1], X11
    FMOV  D27, X20
    FMOV  V27.D[1], X19
    FMOV  D28, X22
    FMOV  V28.D[1], X26
    FMOV  D29, X11
    FMOV  V29.D[1], X26
    FMOV  D30, X4
    FMOV  V30.D[1], X19
    FMOV  D31, X19
    FMOV  V31.D[1], X13
    MOVZ  X8, #0xf, LSL #0
TaishanSimdImmP01_label_164:
    ADD  V28.16B, V31.16B, V7.16B
    ADD  D22, D24, D30
    ADD  D24, D22, D5
    ADD  V26.8B, V16.8B, V15.8B
    ADDV  H7, V28.8H
    ADDV  B27, V4.8B
    ADDHN  V12.2S, V4.2D, V29.2D
    ADDP  V16.4H, V12.4H, V8.4H
    ADD  V11.4H, V24.4H, V29.4H
    ADDV  S28, V3.4S
    ADDHN  V3.2S, V12.2D, V16.2D
    ADDHN  V26.2S, V10.2D, V26.2D
    ADD  D2, D9, D22
    ADD  D11, D11, D30
    ADDV  B27, V8.16B
    ADDV  H3, V11.8H
    ADDHN2  V23.16B, V21.8H, V0.8H
    ADDV  H15, V23.4H
    ADDV  S9, V17.4S
    ADDV  B7, V30.8B
    ADD  V25.8H, V11.8H, V15.8H
    ADDHN2  V23.16B, V13.8H, V3.8H
    ADDP  V0.8B, V13.8B, V0.8B
    ADDV  S12, V18.4S
    ADD  D23, D8, D3
    ADDV  S20, V20.4S
    ADDP  D10, V30.2D
    ADDHN2  V23.8H, V24.4S, V22.4S
    ADDV  H17, V29.8H
    ADDV  H23, V16.4H
    ADDV  H2, V13.4H
    ADDP  V4.4H, V23.4H, V10.4H
    ADD  V26.4S, V25.4S, V20.4S
    ADDP  D25, V9.2D
    ADDHN2  V16.16B, V16.8H, V12.8H
    ADD  V30.4S, V12.4S, V12.4S
    ADDV  B31, V3.8B
    ADD  D28, D28, D15
    ADDHN  V29.2S, V6.2D, V1.2D
    ADDHN  V18.4H, V3.4S, V0.4S
    ADDV  S0, V2.4S
    ADDHN2  V7.8H, V29.4S, V2.4S
    ADDP  D24, V0.2D
    ADDP  D20, V16.2D
    ADDV  B7, V1.16B
    ADDV  H22, V26.8H
    ADDHN  V12.4H, V16.4S, V4.4S
    ADDP  D22, V0.2D
    ADDP  V26.16B, V18.16B, V25.16B
    ADDHN2  V1.4S, V17.2D, V29.2D
    ADDV  S13, V6.4S
    ADDV  S0, V31.4S
    ADDP  V30.4S, V30.4S, V26.4S
    ADDV  B31, V5.16B
    ADD  V7.2D, V28.2D, V7.2D
    ADDP  D27, V1.2D
    ADDP  D4, V20.2D
    ADDHN2  V2.4S, V7.2D, V29.2D
    ADDHN  V16.4H, V2.4S, V26.4S
    ADDP  D10, V16.2D
    ADDV  B30, V30.16B
    ADDV  B24, V25.16B
    ADDHN2  V13.8H, V8.4S, V19.4S
    ADDV  S21, V2.4S
    ADDHN  V23.2S, V3.2D, V20.2D
    ADDV  H22, V21.4H
    ADDHN2  V7.4S, V10.2D, V15.2D
    ADD  V9.2D, V14.2D, V12.2D
    ADDV  S24, V17.4S
    ADDV  H6, V31.4H
    ADDV  S3, V23.4S
    ADDV  H28, V12.4H
    ADDV  B16, V0.8B
    ADDHN  V5.8B, V7.8H, V2.8H
    ADD  V21.8H, V10.8H, V17.8H
    ADDV  H22, V31.4H
    ADDV  S19, V25.4S
    ADD  D1, D23, D8
    ADDV  S20, V28.4S
    ADDHN2  V25.16B, V6.8H, V21.8H
    ADD  V20.2S, V16.2S, V26.2S
    ADDV  H19, V5.4H
    ADDP  D15, V25.2D
    ADDHN2  V15.16B, V12.8H, V4.8H
    ADD  V9.8H, V31.8H, V13.8H
    ADD  D10, D8, D4
    ADDHN  V22.4H, V6.4S, V10.4S
    ADDHN2  V12.16B, V17.8H, V19.8H
    ADDHN  V3.2S, V7.2D, V29.2D
    ADD  V11.4S, V22.4S, V24.4S
    ADDP  V27.4H, V1.4H, V15.4H
    ADDHN2  V8.16B, V20.8H, V15.8H
    ADDP  V19.2D, V25.2D, V14.2D
    ADDHN2  V19.8H, V10.4S, V22.4S
    ADD  V10.2D, V9.2D, V2.2D
    ADDV  S8, V11.4S
    ADDP  D16, V29.2D
    ADDP  V29.8B, V17.8B, V12.8B
    ADDP  V29.4H, V11.4H, V29.4H
    ADD  D15, D3, D16
    ADDP  D7, V6.2D
    ADDP  D23, V18.2D
    ADDV  H28, V2.8H
    ADDHN2  V15.4S, V4.2D, V3.2D
    ADDV  S27, V10.4S
    ADD  D27, D0, D23
    ADD  V15.2D, V18.2D, V11.2D
    ADD  D15, D17, D28
    ADD  V11.4H, V11.4H, V17.4H
    ADDHN  V6.4H, V27.4S, V6.4S
    ADD  V22.4S, V26.4S, V14.4S
    ADDV  S8, V22.4S
    ADDV  B4, V4.8B
    ADDP  V4.16B, V0.16B, V4.16B
    ADDHN2  V12.8H, V26.4S, V17.4S
    ADD  D6, D10, D6
    ADD  D14, D10, D21
    ADDHN2  V10.16B, V8.8H, V8.8H
    ADDV  H10, V4.8H
    ADD  V0.8B, V12.8B, V7.8B
    ADDP  D7, V14.2D
    ADDP  V21.8B, V30.8B, V9.8B
    ADDV  H8, V22.4H
    ADDP  V26.4S, V14.4S, V24.4S
    ADDV  S15, V14.4S
    ADDP  D14, V21.2D
    ADDHN  V18.2S, V4.2D, V30.2D
    ADD  V25.16B, V29.16B, V3.16B
    ADD  V31.2S, V22.2S, V8.2S
    ADDP  D10, V2.2D
    ADDP  V30.16B, V22.16B, V6.16B
    ADDP  D11, V24.2D
    ADDHN  V10.2S, V28.2D, V19.2D
    ADDHN2  V25.16B, V31.8H, V9.8H
    ADD  D7, D25, D25
    ADDHN  V15.4H, V6.4S, V28.4S
    ADDV  S29, V11.4S
    ADDP  V13.4H, V24.4H, V6.4H
    ADDP  D30, V5.2D
    ADDV  B18, V12.8B
    ADDHN  V14.4H, V16.4S, V5.4S
    ADDP  D18, V2.2D
    ADDHN2  V14.16B, V28.8H, V23.8H
    ADD  V8.2D, V0.2D, V18.2D
    ADDV  B21, V29.8B
    ADDHN  V7.2S, V9.2D, V9.2D
    ADDHN2  V24.8H, V28.4S, V13.4S
    ADDHN2  V15.8H, V2.4S, V22.4S
    ADDV  B12, V13.8B
    ADDV  B23, V24.16B
    ADDHN2  V22.8H, V13.4S, V30.4S
    ADDHN2  V6.8H, V9.4S, V10.4S
    ADDV  H15, V7.4H
    ADDHN2  V19.16B, V7.8H, V25.8H
    ADD  D17, D1, D21
    ADD  D15, D23, D11
    ADDV  B10, V6.16B
    ADDP  D30, V3.2D
    ADDP  D22, V15.2D
    ADDV  S28, V0.4S
    ADDV  S12, V3.4S
    ADDHN2  V21.16B, V8.8H, V8.8H
    ADDP  D4, V14.2D
    ADDV  B30, V4.8B
    ADDV  S15, V29.4S
    ADDHN2  V10.16B, V19.8H, V16.8H
    ADDV  H8, V13.4H
    ADDHN  V13.2S, V24.2D, V6.2D
    ADD  V12.8B, V12.8B, V17.8B
    ADD  D17, D24, D29
    ADDP  V19.4S, V17.4S, V17.4S
    ADDV  S4, V23.4S
    ADDP  V6.16B, V21.16B, V4.16B
    ADDV  B8, V27.8B
    ADDV  B0, V4.16B
    ADDV  S21, V30.4S
    ADDP  V16.4S, V6.4S, V10.4S
    ADDHN2  V17.4S, V10.2D, V21.2D
    ADD  D20, D9, D8
    ADDP  D14, V15.2D
    ADDV  S27, V24.4S
    ADDV  S25, V20.4S
    ADD  D22, D7, D21
    ADD  D19, D11, D31
    ADDV  H31, V20.4H
    ADDV  B8, V28.8B
    ADDV  S29, V12.4S
    ADDV  B0, V31.16B
    ADDP  V14.2S, V29.2S, V27.2S
    ADD  V6.16B, V25.16B, V0.16B
    ADDHN2  V10.8H, V15.4S, V0.4S
    ADDV  H29, V26.8H
    ADD  V28.4S, V30.4S, V21.4S
    ADD  V11.8B, V2.8B, V13.8B
    ADDHN  V23.4H, V3.4S, V0.4S
    ADDP  D17, V25.2D
    ADDHN  V31.2S, V7.2D, V30.2D
    ADD  D3, D20, D7
    ADDV  H3, V27.8H
    ADDV  S13, V3.4S
    SUBS  X8, X8, #0x1
    B.NE  TaishanSimdImmP01_label_164
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X15, X2, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X22, X13, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X21, X7, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X18, X11, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X3, X20, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X19, X21, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X26, X29, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X9, X4, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X21, X28, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X3, X14, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X9, X2, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X24, X7, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X17, X3, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X3, X5, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X12, D2
    MOVZ  X25, #0x2dc7, LSL #0
    SUB  X17, X25, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X14, D3
    MOVZ  X6, #0x295c, LSL #0
    SUB  X16, X6, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X24, D4
    MOVZ  X19, #0x85, LSL #0
    SUB  X8, X19, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X9, D5
    MOVZ  X16, #0x5b, LSL #0
    SUB  X15, X16, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X3, D6
    MOVZ  X18, #0x920, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X16, X18, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X27, D7
    MOVZ  X18, #0x1, LSL #0
    SUB  X22, X18, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X4, D8
    MOVZ  X7, #0x8c, LSL #0
    SUB  X21, X7, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X15, D9
    MOVZ  X25, #0x878, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X10, X25, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X17, D10
    MOVZ  X7, #0x71, LSL #0
    SUB  X12, X7, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X5, D11
    MOVZ  X22, #0x2dc7, LSL #0
    SUB  X8, X22, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X21, D12
    MOVZ  X20, #0xef, LSL #0
    SUB  X9, X20, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X19, D13
    MOVZ  X26, #0x295c, LSL #0
    SUB  X12, X26, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X4, D14
    MOVZ  X28, #0xef, LSL #0
    MOVK  X28, #0x295c, LSL #32
    SUB  X5, X28, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X3, D15
    MOVZ  X20, #0x295c, LSL #0
    SUB  X26, X20, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X11, #0x71, LSL #0
    MOVK  X11, #0xff08, LSL #32
    SUB  X25, X11, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X14, D16
    MOVZ  X11, #0xe1, LSL #0
    MOVK  X11, #0x85, LSL #32
    SUB  X25, X11, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X8, D17
    MOVZ  X10, #0x90c, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X9, X10, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X8, D18
    MOVZ  X5, #0x2dc7, LSL #0
    SUB  X13, X5, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X29, D19
    MOVZ  X28, #0x595f, LSL #0
    MOVK  X28, #0x2dc7, LSL #32
    SUB  X9, X28, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X16, D20
    MOVZ  X21, #0x90c, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X13, X21, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X4, D21
    MOVZ  X5, #0x2d, LSL #0
    SUB  X22, X5, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X25, D22
    MOVZ  X8, #0x2e, LSL #0
    SUB  X18, X8, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X19, D24
    MOVZ  X2, #0x295c, LSL #0
    SUB  X28, X2, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X9, D25
    MOVZ  X21, #0x90c, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X26, X21, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X18, #0x295c, LSL #0
    SUB  X11, X18, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X17, D26
    MOVZ  X18, #0x5f9b, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X11, X18, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X10, D27
    MOVZ  X14, #0x295c, LSL #0
    SUB  X15, X14, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X8, D28
    MOVZ  X10, #0x5a, LSL #0
    SUB  X12, X10, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X20, D29
    MOVZ  X16, #0x88f6, LSL #0
    SUB  X14, X16, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x416d, LSL #0
    MOVK  X2, #0x56c, LSL #16
    MOVK  X2, #0x2146, LSL #32
    MOVK  X2, #0x1c81, LSL #48
    MOVZ  X3, #0x2824, LSL #0
    MOVK  X3, #0x6b0e, LSL #16
    MOVK  X3, #0xfb8e, LSL #32
    MOVK  X3, #0x88fa, LSL #48
    MOVZ  X4, #0xfb94, LSL #0
    MOVK  X4, #0x3fec, LSL #16
    MOVK  X4, #0x8e1f, LSL #32
    MOVK  X4, #0xaee8, LSL #48
    MOVZ  X5, #0x4c9f, LSL #0
    MOVK  X5, #0xdb0d, LSL #16
    MOVK  X5, #0x1659, LSL #32
    MOVK  X5, #0x6b3d, LSL #48
    MOVZ  X6, #0x6294, LSL #0
    MOVK  X6, #0xf371, LSL #16
    MOVK  X6, #0xbd63, LSL #32
    MOVK  X6, #0xe26b, LSL #48
    MOVZ  X7, #0x5c54, LSL #0
    MOVK  X7, #0x2bcf, LSL #16
    MOVK  X7, #0x26cc, LSL #32
    MOVK  X7, #0xde57, LSL #48
    MOVZ  X8, #0x85df, LSL #0
    MOVK  X8, #0xe4bd, LSL #16
    MOVK  X8, #0x3810, LSL #32
    MOVK  X8, #0x9cca, LSL #48
    MOVZ  X9, #0xe22a, LSL #0
    MOVK  X9, #0x97c8, LSL #16
    MOVK  X9, #0x5a33, LSL #32
    MOVK  X9, #0x632b, LSL #48
    MOVZ  X10, #0x12e6, LSL #0
    MOVK  X10, #0x5a46, LSL #16
    MOVK  X10, #0x20a3, LSL #32
    MOVK  X10, #0xa87c, LSL #48
    MOVZ  X11, #0x55b0, LSL #0
    MOVK  X11, #0xf3aa, LSL #16
    MOVK  X11, #0x5028, LSL #32
    MOVK  X11, #0xd63f, LSL #48
    MOVZ  X12, #0x8645, LSL #0
    MOVK  X12, #0x55af, LSL #16
    MOVK  X12, #0x4889, LSL #32
    MOVK  X12, #0xdf7f, LSL #48
    MOVZ  X13, #0x5238, LSL #0
    MOVK  X13, #0x77a9, LSL #16
    MOVK  X13, #0xc6c5, LSL #32
    MOVK  X13, #0x36c7, LSL #48
    MOVZ  X14, #0x8437, LSL #0
    MOVK  X14, #0xee00, LSL #16
    MOVK  X14, #0xd14f, LSL #32
    MOVK  X14, #0x326b, LSL #48
    MOVZ  X15, #0xa575, LSL #0
    MOVK  X15, #0x802b, LSL #16
    MOVK  X15, #0x3075, LSL #32
    MOVK  X15, #0xe9f2, LSL #48
    MOVZ  X16, #0x7e06, LSL #0
    MOVK  X16, #0x84d3, LSL #16
    MOVK  X16, #0x326a, LSL #32
    MOVK  X16, #0x70c1, LSL #48
    MOVZ  X17, #0x3139, LSL #0
    MOVK  X17, #0xe9c2, LSL #16
    MOVK  X17, #0xc29f, LSL #32
    MOVK  X17, #0xeb00, LSL #48
    MOVZ  X18, #0xa5bf, LSL #0
    MOVK  X18, #0xe16d, LSL #16
    MOVK  X18, #0x36d0, LSL #32
    MOVK  X18, #0x6e77, LSL #48
    MOVZ  X19, #0xa0e6, LSL #0
    MOVK  X19, #0xbaa0, LSL #16
    MOVK  X19, #0x8e64, LSL #32
    MOVK  X19, #0x2ca, LSL #48
    MOVZ  X20, #0x7d30, LSL #0
    MOVK  X20, #0x5267, LSL #16
    MOVK  X20, #0xdf7a, LSL #32
    MOVK  X20, #0x576d, LSL #48
    MOVZ  X21, #0x3006, LSL #0
    MOVK  X21, #0xbbb4, LSL #16
    MOVK  X21, #0x8ca4, LSL #32
    MOVK  X21, #0xcebb, LSL #48
    MOVZ  X22, #0x8e7, LSL #0
    MOVK  X22, #0xfa53, LSL #16
    MOVK  X22, #0xd5af, LSL #32
    MOVK  X22, #0xfca0, LSL #48
    MOVZ  X24, #0x694b, LSL #0
    MOVK  X24, #0x2be4, LSL #16
    MOVK  X24, #0x3ae0, LSL #32
    MOVK  X24, #0xe0ee, LSL #48
    MOVZ  X25, #0x6966, LSL #0
    MOVK  X25, #0xa53, LSL #16
    MOVK  X25, #0xc1c2, LSL #32
    MOVK  X25, #0x2a99, LSL #48
    MOVZ  X26, #0x838a, LSL #0
    MOVK  X26, #0xf959, LSL #16
    MOVK  X26, #0x896, LSL #32
    MOVK  X26, #0xb9d4, LSL #48
    MOVZ  X27, #0x5b5, LSL #0
    MOVK  X27, #0x516f, LSL #16
    MOVK  X27, #0x9717, LSL #32
    MOVK  X27, #0x4266, LSL #48
    MOVZ  X28, #0xd931, LSL #0
    MOVK  X28, #0x9bbb, LSL #16
    MOVK  X28, #0x9b05, LSL #32
    MOVK  X28, #0x60bf, LSL #48
    MOVZ  X29, #0x5448, LSL #0
    MOVK  X29, #0xb9e3, LSL #16
    MOVK  X29, #0xec65, LSL #32
    MOVK  X29, #0x64ff, LSL #48
    FMOV  D0, X14
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X13
    FMOV  D2, X2
    FMOV  V2.D[1], X15
    FMOV  D3, X25
    FMOV  V3.D[1], X14
    FMOV  D4, X28
    FMOV  V4.D[1], X27
    FMOV  D5, X11
    FMOV  V5.D[1], X26
    FMOV  D6, X11
    FMOV  V6.D[1], X3
    FMOV  D7, X6
    FMOV  V7.D[1], X24
    FMOV  D8, X17
    FMOV  V8.D[1], X17
    FMOV  D9, X29
    FMOV  V9.D[1], X18
    FMOV  D10, X14
    FMOV  V10.D[1], X6
    FMOV  D11, X2
    FMOV  V11.D[1], X27
    FMOV  D12, X20
    FMOV  V12.D[1], X13
    FMOV  D13, X26
    FMOV  V13.D[1], X28
    FMOV  D14, X27
    FMOV  V14.D[1], X21
    FMOV  D15, X6
    FMOV  V15.D[1], X16
    FMOV  D16, X19
    FMOV  V16.D[1], X6
    FMOV  D17, X6
    FMOV  V17.D[1], X17
    FMOV  D18, X21
    FMOV  V18.D[1], X3
    FMOV  D19, X20
    FMOV  V19.D[1], X19
    FMOV  D20, X20
    FMOV  V20.D[1], X28
    FMOV  D21, X20
    FMOV  V21.D[1], X27
    FMOV  D22, X4
    FMOV  V22.D[1], X5
    FMOV  D23, X3
    FMOV  V23.D[1], X7
    FMOV  D24, X7
    FMOV  V24.D[1], X14
    FMOV  D25, X7
    FMOV  V25.D[1], X21
    FMOV  D26, X25
    FMOV  V26.D[1], X29
    FMOV  D27, X16
    FMOV  V27.D[1], X28
    FMOV  D28, X14
    FMOV  V28.D[1], X21
    FMOV  D29, X16
    FMOV  V29.D[1], X26
    FMOV  D30, X10
    FMOV  V30.D[1], X21
    FMOV  D31, X4
    FMOV  V31.D[1], X17
    MOVZ  X24, #0xa, LSL #0
TaishanSimdImmP01_label_245:
    ADD  V16.8H, V15.8H, V28.8H
    ADDV  B16, V2.8B
    ADDP  V8.4H, V12.4H, V20.4H
    ADDHN2  V29.8H, V25.4S, V31.4S
    ADDV  S30, V24.4S
    ADDV  H0, V26.8H
    ADD  D9, D11, D4
    ADD  V30.4H, V19.4H, V13.4H
    ADD  V25.16B, V17.16B, V13.16B
    ADD  V27.4S, V9.4S, V20.4S
    ADDP  V20.2S, V20.2S, V23.2S
    ADDV  H22, V20.8H
    ADDHN  V23.4H, V19.4S, V27.4S
    ADDP  V21.8B, V24.8B, V6.8B
    ADDV  S4, V31.4S
    ADDV  H15, V30.8H
    ADDHN  V28.4H, V9.4S, V27.4S
    ADDP  V7.16B, V29.16B, V19.16B
    ADD  V29.16B, V4.16B, V1.16B
    ADD  D5, D13, D8
    ADD  D8, D13, D16
    ADD  D6, D28, D26
    ADDP  D0, V17.2D
    ADDV  B26, V21.8B
    ADDHN  V12.8B, V9.8H, V28.8H
    ADD  D17, D20, D31
    ADDV  B10, V9.16B
    ADDP  V13.2D, V24.2D, V15.2D
    ADDV  B11, V3.8B
    ADDHN2  V17.4S, V15.2D, V7.2D
    ADDHN2  V19.16B, V16.8H, V23.8H
    ADD  V29.16B, V16.16B, V12.16B
    ADDV  B26, V3.16B
    ADDHN  V25.2S, V5.2D, V20.2D
    ADDP  D0, V28.2D
    ADDHN2  V6.8H, V0.4S, V27.4S
    ADDHN  V28.8B, V1.8H, V0.8H
    ADD  D10, D29, D4
    ADD  D30, D9, D8
    ADDP  V16.2D, V13.2D, V6.2D
    ADD  D24, D9, D0
    ADDV  B2, V18.16B
    ADDV  H11, V6.8H
    ADDHN  V10.8B, V13.8H, V11.8H
    ADDP  V26.4H, V30.4H, V28.4H
    ADDP  V7.4H, V0.4H, V24.4H
    ADDV  S15, V31.4S
    ADD  D31, D0, D19
    ADDP  D30, V29.2D
    ADD  D31, D6, D31
    ADDP  V10.2D, V23.2D, V9.2D
    ADDHN  V13.2S, V18.2D, V28.2D
    ADD  V13.8B, V16.8B, V8.8B
    ADDP  D4, V12.2D
    ADDV  S26, V16.4S
    ADDP  D4, V6.2D
    ADD  V27.2S, V24.2S, V26.2S
    ADDP  V9.4S, V30.4S, V19.4S
    ADDHN  V0.8B, V10.8H, V4.8H
    ADDP  D29, V27.2D
    ADDV  H2, V26.4H
    ADDV  S12, V6.4S
    ADDHN2  V3.4S, V8.2D, V12.2D
    ADDHN  V28.2S, V31.2D, V29.2D
    ADDV  H3, V13.8H
    ADDV  B2, V24.16B
    ADDP  D11, V21.2D
    ADD  D5, D5, D20
    ADDP  V28.8H, V14.8H, V20.8H
    ADDV  S11, V29.4S
    ADDHN  V9.2S, V24.2D, V7.2D
    ADDHN  V17.2S, V14.2D, V16.2D
    ADDV  B18, V22.16B
    ADDP  D11, V2.2D
    ADDV  S22, V10.4S
    ADDP  D11, V14.2D
    ADD  D26, D2, D12
    ADD  D27, D4, D0
    ADDP  D1, V27.2D
    ADDHN  V31.4H, V3.4S, V25.4S
    ADDHN  V20.4H, V17.4S, V5.4S
    ADDHN  V31.2S, V19.2D, V22.2D
    ADDP  V10.4S, V16.4S, V19.4S
    ADDP  D13, V7.2D
    ADDP  V0.2S, V24.2S, V28.2S
    ADDP  D2, V16.2D
    ADDV  S11, V11.4S
    ADD  D28, D22, D27
    ADDV  H31, V21.8H
    ADD  V21.2S, V26.2S, V31.2S
    ADDP  V13.8H, V13.8H, V1.8H
    ADD  V6.8B, V13.8B, V18.8B
    ADDV  S13, V25.4S
    ADDV  B19, V20.16B
    ADDV  S10, V22.4S
    ADDV  S11, V9.4S
    ADDP  V22.4S, V2.4S, V5.4S
    ADDV  S17, V17.4S
    ADDV  S22, V3.4S
    ADD  D0, D16, D23
    ADDV  S13, V25.4S
    ADD  V22.4H, V12.4H, V1.4H
    ADD  D6, D22, D18
    ADDHN  V8.2S, V19.2D, V30.2D
    ADDP  V0.4H, V4.4H, V11.4H
    ADDP  D22, V6.2D
    ADDV  H17, V26.4H
    ADDV  S21, V24.4S
    ADD  D25, D0, D30
    ADD  D18, D2, D22
    ADDV  S13, V28.4S
    ADDV  B15, V24.16B
    ADDHN  V25.2S, V16.2D, V30.2D
    ADDHN  V8.4H, V17.4S, V9.4S
    ADDP  V23.16B, V16.16B, V5.16B
    ADDP  D11, V25.2D
    ADDV  S26, V5.4S
    ADDV  B30, V29.16B
    ADDV  H31, V1.8H
    ADDV  H14, V21.8H
    ADDP  D5, V14.2D
    ADDHN2  V20.4S, V19.2D, V11.2D
    ADDHN  V14.8B, V10.8H, V8.8H
    ADDHN2  V18.4S, V18.2D, V11.2D
    ADDHN  V3.2S, V28.2D, V31.2D
    ADD  V5.8H, V24.8H, V30.8H
    ADDP  V18.2D, V14.2D, V23.2D
    ADDP  V6.8H, V12.8H, V13.8H
    ADD  V5.4S, V5.4S, V20.4S
    ADDHN  V29.8B, V9.8H, V27.8H
    ADDHN2  V3.4S, V22.2D, V0.2D
    ADDV  H17, V16.8H
    ADDHN2  V25.16B, V7.8H, V19.8H
    ADDV  B21, V30.8B
    ADDV  S1, V12.4S
    ADDV  B12, V20.16B
    ADD  D17, D14, D8
    ADDV  S23, V3.4S
    ADDHN2  V29.8H, V21.4S, V2.4S
    ADDP  D29, V15.2D
    ADDP  V11.4H, V17.4H, V29.4H
    ADDV  H25, V7.8H
    ADDHN  V9.2S, V17.2D, V10.2D
    ADDV  S25, V0.4S
    ADD  V7.8H, V13.8H, V30.8H
    ADD  V24.8H, V9.8H, V2.8H
    ADDHN  V18.2S, V14.2D, V14.2D
    ADDV  S26, V18.4S
    ADDV  S9, V13.4S
    ADDV  H14, V29.4H
    ADDHN2  V13.4S, V16.2D, V7.2D
    ADDHN2  V23.8H, V14.4S, V30.4S
    ADDV  H24, V11.8H
    ADD  D25, D13, D15
    ADDP  V22.16B, V8.16B, V21.16B
    ADD  D23, D16, D10
    ADDV  H16, V23.4H
    ADDHN  V21.4H, V17.4S, V27.4S
    ADDP  D24, V7.2D
    ADDP  V8.2S, V7.2S, V4.2S
    ADDHN2  V9.16B, V2.8H, V18.8H
    ADDV  S26, V10.4S
    ADDP  V11.4H, V24.4H, V20.4H
    ADD  D9, D8, D6
    ADD  V24.2S, V3.2S, V27.2S
    ADDV  H18, V9.4H
    ADDP  V17.16B, V11.16B, V22.16B
    ADDHN2  V7.4S, V18.2D, V26.2D
    ADDP  V24.8H, V16.8H, V31.8H
    ADDV  H0, V30.4H
    ADDHN  V19.8B, V17.8H, V19.8H
    ADDHN  V1.4H, V23.4S, V24.4S
    ADDP  D4, V20.2D
    ADDV  B18, V21.8B
    ADDV  B17, V22.8B
    ADDHN2  V4.16B, V9.8H, V15.8H
    ADDV  B24, V15.16B
    ADDHN  V9.8B, V3.8H, V16.8H
    ADDP  D29, V16.2D
    ADD  D28, D21, D15
    ADD  D1, D17, D3
    ADD  D2, D1, D10
    ADDV  S0, V14.4S
    ADD  V10.4S, V30.4S, V19.4S
    ADD  D16, D7, D28
    ADDV  B7, V22.16B
    ADD  V2.4H, V9.4H, V31.4H
    ADDV  B1, V21.8B
    ADDHN2  V14.4S, V19.2D, V31.2D
    ADDHN  V28.8B, V18.8H, V16.8H
    ADDHN  V7.8B, V9.8H, V2.8H
    ADD  D21, D14, D21
    ADDP  D13, V1.2D
    ADDP  D2, V1.2D
    ADDP  D27, V16.2D
    ADDV  H17, V22.4H
    ADD  D15, D30, D22
    ADDV  B10, V3.8B
    ADD  V10.16B, V30.16B, V14.16B
    ADDHN2  V4.4S, V29.2D, V19.2D
    SUBS  X24, X24, #0x1
    B.NE  TaishanSimdImmP01_label_245
    MOVZ  X22, #0x416d, LSL #0
    MOVK  X22, #0x56c, LSL #16
    MOVK  X22, #0x2146, LSL #32
    MOVK  X22, #0x1c81, LSL #48
    SUB  X25, X22, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x2824, LSL #0
    MOVK  X27, #0x6b0e, LSL #16
    MOVK  X27, #0xfb8e, LSL #32
    MOVK  X27, #0x88fa, LSL #48
    SUB  X8, X27, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0xfb94, LSL #0
    MOVK  X27, #0x3fec, LSL #16
    MOVK  X27, #0x8e1f, LSL #32
    MOVK  X27, #0xaee8, LSL #48
    SUB  X29, X27, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x4c9f, LSL #0
    MOVK  X9, #0xdb0d, LSL #16
    MOVK  X9, #0x1659, LSL #32
    MOVK  X9, #0x6b3d, LSL #48
    SUB  X3, X9, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x6294, LSL #0
    MOVK  X7, #0xf371, LSL #16
    MOVK  X7, #0xbd63, LSL #32
    MOVK  X7, #0xe26b, LSL #48
    SUB  X10, X7, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x6294, LSL #0
    MOVK  X14, #0xf371, LSL #16
    MOVK  X14, #0xbd63, LSL #32
    MOVK  X14, #0xe26b, LSL #48
    SUB  X27, X14, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x4c9f, LSL #0
    MOVK  X9, #0xdb0d, LSL #16
    MOVK  X9, #0x1659, LSL #32
    MOVK  X9, #0x6b3d, LSL #48
    SUB  X29, X9, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x55b0, LSL #0
    MOVK  X8, #0xf3aa, LSL #16
    MOVK  X8, #0x5028, LSL #32
    MOVK  X8, #0xd63f, LSL #48
    SUB  X2, X8, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x8645, LSL #0
    MOVK  X16, #0x55af, LSL #16
    MOVK  X16, #0x4889, LSL #32
    MOVK  X16, #0xdf7f, LSL #48
    SUB  X29, X16, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x5238, LSL #0
    MOVK  X27, #0x77a9, LSL #16
    MOVK  X27, #0xc6c5, LSL #32
    MOVK  X27, #0x36c7, LSL #48
    SUB  X4, X27, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0xa575, LSL #0
    MOVK  X3, #0x802b, LSL #16
    MOVK  X3, #0x3075, LSL #32
    MOVK  X3, #0xe9f2, LSL #48
    SUB  X21, X3, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x8645, LSL #0
    MOVK  X12, #0x55af, LSL #16
    MOVK  X12, #0x4889, LSL #32
    MOVK  X12, #0xdf7f, LSL #48
    SUB  X25, X12, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0xa0e6, LSL #0
    MOVK  X3, #0xbaa0, LSL #16
    MOVK  X3, #0x8e64, LSL #32
    MOVK  X3, #0x2ca, LSL #48
    SUB  X6, X3, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0x5238, LSL #0
    MOVK  X18, #0x77a9, LSL #16
    MOVK  X18, #0xc6c5, LSL #32
    MOVK  X18, #0x36c7, LSL #48
    SUB  X22, X18, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X8, D2
    MOVZ  X5, #0xed, LSL #0
    SUB  X25, X5, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X4, #0x4ba0, LSL #0
    MOVK  X4, #0x65, LSL #16
    SUB  X26, X4, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X14, D3
    MOVZ  X4, #0x8bc9, LSL #0
    MOVK  X4, #0x64, LSL #16
    SUB  X26, X4, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X5, D4
    MOVZ  X12, #0x8bb8, LSL #0
    MOVK  X12, #0xd8af, LSL #16
    SUB  X8, X12, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X7, D5
    MOVZ  X22, #0xf7d6, LSL #0
    MOVK  X22, #0x6469, LSL #16
    MOVK  X22, #0x6465, LSL #32
    SUB  X14, X22, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X14, #0x3338, LSL #0
    SUB  X18, X14, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X13, D6
    MOVZ  X14, #0xff15, LSL #0
    SUB  X18, X14, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X9, D7
    MOVZ  X11, #0x64, LSL #0
    SUB  X15, X11, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X15, D8
    MOVZ  X17, #0xcf34, LSL #0
    MOVK  X17, #0x64cf, LSL #16
    MOVK  X17, #0x2665, LSL #32
    MOVK  X17, #0xd8b0, LSL #48
    SUB  X25, X17, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X10, D9
    MOVZ  X5, #0x5c, LSL #0
    MOVK  X5, #0x4b, LSL #32
    SUB  X6, X5, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X6, D10
    MOVZ  X14, #0x97, LSL #0
    SUB  X15, X14, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X25, D11
    MOVZ  X18, #0x3403, LSL #0
    MOVK  X18, #0x6467, LSL #32
    SUB  X15, X18, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X10, D12
    MOVZ  X21, #0xca, LSL #0
    SUB  X18, X21, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X9, D13
    MOVZ  X8, #0xed, LSL #0
    SUB  X20, X8, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X16, D14
    MOVZ  X10, #0xcc, LSL #0
    SUB  X2, X10, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X28, D15
    MOVZ  X7, #0x196, LSL #0
    SUB  X6, X7, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X19, D16
    MOVZ  X22, #0xa8b1, LSL #0
    MOVK  X22, #0x6534, LSL #16
    SUB  X21, X22, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X7, D17
    MOVZ  X5, #0xcb, LSL #0
    SUB  X20, X5, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X13, D18
    MOVZ  X4, #0xed, LSL #0
    SUB  X16, X4, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X4, D19
    MOVZ  X5, #0x1, LSL #0
    SUB  X27, X5, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X19, D20
    MOVZ  X5, #0x8bb8, LSL #0
    MOVK  X5, #0xd8af, LSL #16
    SUB  X9, X5, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X20, D21
    MOVZ  X13, #0xd97d, LSL #0
    MOVK  X13, #0x64, LSL #16
    SUB  X8, X13, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X28, #0xcb, LSL #0
    SUB  X24, X28, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X20, D22
    MOVZ  X28, #0xcb, LSL #0
    SUB  X24, X28, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X4, D24
    MOVZ  X14, #0xcc, LSL #0
    SUB  X3, X14, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X5, D25
    MOVZ  X4, #0xcf35, LSL #0
    MOVK  X4, #0x64cf, LSL #16
    SUB  X14, X4, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X8, D26
    MOVZ  X16, #0x43fe, LSL #0
    MOVK  X16, #0x8bba, LSL #16
    SUB  X7, X16, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X19, D27
    MOVZ  X21, #0xa8b1, LSL #0
    MOVK  X21, #0x6534, LSL #16
    SUB  X11, X21, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X11, D28
    MOVZ  X2, #0x65a9, LSL #0
    SUB  X21, X2, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X12, D29
    MOVZ  X3, #0xd0a2, LSL #0
    SUB  X9, X3, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X20
    FMOV  V0.D[1], X16
    FMOV  D1, X27
    FMOV  V1.D[1], X11
    FMOV  D2, X26
    FMOV  V2.D[1], X21
    FMOV  D3, X27
    FMOV  V3.D[1], X14
    FMOV  D4, X16
    FMOV  V4.D[1], X22
    FMOV  D5, X7
    FMOV  V5.D[1], X17
    FMOV  D6, X6
    FMOV  V6.D[1], X8
    FMOV  D7, X16
    FMOV  V7.D[1], X16
    FMOV  D8, X28
    FMOV  V8.D[1], X14
    FMOV  D9, X15
    FMOV  V9.D[1], X22
    FMOV  D10, X21
    FMOV  V10.D[1], X9
    FMOV  D11, X16
    FMOV  V11.D[1], X8
    FMOV  D12, X26
    FMOV  V12.D[1], X8
    FMOV  D13, X4
    FMOV  V13.D[1], X7
    FMOV  D14, X6
    FMOV  V14.D[1], X26
    FMOV  D15, X28
    FMOV  V15.D[1], X3
    FMOV  D16, X7
    FMOV  V16.D[1], X22
    FMOV  D17, X22
    FMOV  V17.D[1], X6
    FMOV  D18, X4
    FMOV  V18.D[1], X20
    FMOV  D19, X8
    FMOV  V19.D[1], X14
    FMOV  D20, X9
    FMOV  V20.D[1], X16
    FMOV  D21, X7
    FMOV  V21.D[1], X20
    FMOV  D22, X26
    FMOV  V22.D[1], X9
    FMOV  D23, X2
    FMOV  V23.D[1], X27
    FMOV  D24, X16
    FMOV  V24.D[1], X22
    FMOV  D25, X7
    FMOV  V25.D[1], X10
    FMOV  D26, X26
    FMOV  V26.D[1], X20
    FMOV  D27, X22
    FMOV  V27.D[1], X19
    FMOV  D28, X13
    FMOV  V28.D[1], X20
    FMOV  D29, X14
    FMOV  V29.D[1], X9
    FMOV  D30, X16
    FMOV  V30.D[1], X8
    FMOV  D31, X8
    FMOV  V31.D[1], X17
    MOVZ  X4, #0xa, LSL #0
TaishanSimdImmP01_label_325:
    ADDHN2  V24.4S, V9.2D, V25.2D
    ADDV  H9, V20.8H
    ADDV  B8, V22.8B
    ADDP  D24, V23.2D
    ADDV  H5, V11.8H
    ADDHN2  V30.4S, V24.2D, V15.2D
    ADDHN  V9.8B, V14.8H, V23.8H
    ADDHN  V5.4H, V23.4S, V21.4S
    ADD  D8, D30, D8
    ADD  V27.4S, V5.4S, V20.4S
    ADDP  D8, V26.2D
    ADD  V15.8H, V2.8H, V27.8H
    ADDP  D18, V5.2D
    ADDP  V10.4H, V25.4H, V31.4H
    ADD  V4.8B, V19.8B, V12.8B
    ADDV  S26, V10.4S
    ADDHN  V14.8B, V15.8H, V8.8H
    ADD  D6, D2, D0
    ADD  V23.16B, V14.16B, V18.16B
    ADDV  S1, V4.4S
    ADDHN2  V7.4S, V10.2D, V10.2D
    ADDP  V28.2D, V3.2D, V5.2D
    ADDHN2  V24.16B, V22.8H, V11.8H
    ADDP  V14.2D, V13.2D, V7.2D
    ADDHN2  V18.16B, V27.8H, V13.8H
    ADDP  V13.4S, V20.4S, V20.4S
    ADDHN2  V31.8H, V14.4S, V1.4S
    ADDHN  V24.2S, V20.2D, V3.2D
    ADDV  S22, V7.4S
    ADDV  B18, V3.8B
    ADDP  V31.8H, V7.8H, V20.8H
    ADDHN  V13.2S, V12.2D, V31.2D
    ADDV  H6, V5.8H
    ADDV  S10, V17.4S
    ADDP  V15.4H, V26.4H, V8.4H
    ADDP  D15, V3.2D
    ADDV  H6, V20.8H
    ADD  V8.4S, V19.4S, V8.4S
    ADD  V4.4S, V26.4S, V26.4S
    ADD  V31.16B, V26.16B, V26.16B
    ADDP  D13, V23.2D
    ADD  D23, D23, D10
    ADDV  S17, V2.4S
    ADD  D2, D23, D20
    ADDV  S19, V11.4S
    ADDP  V30.2D, V28.2D, V17.2D
    ADDP  D24, V18.2D
    ADDV  H16, V24.8H
    ADDHN2  V25.4S, V24.2D, V22.2D
    ADD  V2.4S, V4.4S, V25.4S
    ADDHN  V20.8B, V23.8H, V27.8H
    ADDV  S30, V10.4S
    ADDV  S19, V12.4S
    ADDP  D14, V18.2D
    ADDHN  V19.4H, V9.4S, V23.4S
    ADDHN2  V10.8H, V0.4S, V27.4S
    ADD  D2, D15, D29
    ADDHN  V23.4H, V5.4S, V29.4S
    ADD  D27, D15, D16
    ADDP  V7.2S, V25.2S, V22.2S
    ADDV  H7, V25.4H
    ADDP  V24.4H, V17.4H, V31.4H
    ADDV  H22, V28.8H
    ADDV  S21, V14.4S
    ADD  D25, D23, D4
    ADDV  B9, V6.8B
    ADDHN2  V29.4S, V28.2D, V19.2D
    ADDP  V15.8H, V14.8H, V27.8H
    ADDP  D4, V13.2D
    ADDHN  V27.4H, V0.4S, V4.4S
    ADDP  D15, V16.2D
    ADDV  B12, V22.8B
    ADDHN  V19.4H, V20.4S, V12.4S
    ADDHN2  V7.8H, V14.4S, V30.4S
    ADD  V30.8H, V9.8H, V30.8H
    ADDHN  V29.2S, V29.2D, V24.2D
    ADDP  V11.16B, V27.16B, V21.16B
    ADDHN  V29.4H, V6.4S, V12.4S
    ADDP  D29, V25.2D
    ADDV  H30, V13.8H
    ADDV  S15, V19.4S
    ADDHN  V0.4H, V2.4S, V15.4S
    ADD  V28.8B, V30.8B, V6.8B
    ADD  V3.2D, V7.2D, V2.2D
    ADD  V15.2D, V12.2D, V13.2D
    ADDP  V8.8H, V17.8H, V15.8H
    ADDHN2  V8.16B, V17.8H, V14.8H
    ADDV  B28, V2.8B
    ADD  V12.16B, V9.16B, V11.16B
    ADDHN2  V29.16B, V15.8H, V11.8H
    ADDV  B6, V22.8B
    ADDV  B9, V6.16B
    ADDP  V24.16B, V23.16B, V8.16B
    ADDP  V3.8B, V0.8B, V15.8B
    ADDHN  V6.8B, V15.8H, V25.8H
    ADDHN2  V4.16B, V31.8H, V28.8H
    ADDHN  V16.2S, V27.2D, V16.2D
    ADDHN  V16.2S, V20.2D, V21.2D
    ADD  V29.8H, V22.8H, V7.8H
    ADD  D14, D16, D29
    ADDHN2  V25.16B, V13.8H, V21.8H
    ADDV  S16, V28.4S
    ADDP  D15, V15.2D
    ADDP  V28.8B, V25.8B, V14.8B
    ADDV  H9, V29.8H
    ADDP  D19, V12.2D
    ADDV  B30, V20.8B
    ADDP  D30, V6.2D
    ADD  V30.2D, V20.2D, V15.2D
    ADDV  H19, V3.4H
    ADDHN  V7.4H, V28.4S, V9.4S
    ADDV  S23, V30.4S
    ADDV  H19, V7.4H
    ADDHN2  V21.16B, V9.8H, V20.8H
    ADDV  S16, V24.4S
    ADDP  V31.2D, V20.2D, V30.2D
    ADDV  H30, V19.4H
    ADD  V7.2D, V30.2D, V13.2D
    ADDHN2  V29.4S, V23.2D, V25.2D
    ADD  V18.2S, V27.2S, V21.2S
    ADDP  D9, V18.2D
    ADD  V9.2S, V3.2S, V25.2S
    ADDV  H9, V17.8H
    ADDV  S27, V20.4S
    ADDHN2  V11.16B, V9.8H, V23.8H
    ADDHN  V4.8B, V7.8H, V7.8H
    ADD  V15.8B, V7.8B, V6.8B
    ADDHN2  V28.16B, V9.8H, V20.8H
    ADD  D14, D11, D26
    ADDP  D16, V29.2D
    ADD  V15.2D, V17.2D, V20.2D
    ADDHN2  V0.16B, V29.8H, V17.8H
    ADDHN  V1.4H, V7.4S, V31.4S
    ADD  D14, D7, D11
    ADD  V5.2S, V26.2S, V18.2S
    ADDV  H16, V18.4H
    ADDV  H0, V13.8H
    ADD  V18.2D, V13.2D, V14.2D
    ADDP  D9, V11.2D
    ADD  D14, D8, D21
    ADDP  V7.16B, V21.16B, V23.16B
    ADDHN  V31.2S, V9.2D, V25.2D
    ADDV  H6, V4.8H
    ADDP  D27, V2.2D
    ADDP  D4, V17.2D
    ADDV  B14, V8.16B
    ADDP  V13.16B, V8.16B, V18.16B
    ADDP  D24, V29.2D
    ADDV  S8, V19.4S
    ADDV  H23, V25.4H
    ADDHN2  V11.4S, V14.2D, V11.2D
    ADDHN  V8.4H, V27.4S, V10.4S
    ADDP  V12.16B, V9.16B, V26.16B
    ADDV  B26, V31.8B
    ADDV  B24, V10.16B
    ADDV  H10, V11.8H
    ADDV  S25, V5.4S
    ADDP  D21, V11.2D
    ADD  V31.4H, V0.4H, V15.4H
    ADDP  V11.2S, V13.2S, V13.2S
    ADD  V3.4H, V27.4H, V14.4H
    ADDHN  V14.4H, V2.4S, V19.4S
    ADDHN2  V14.8H, V6.4S, V10.4S
    ADDP  D0, V4.2D
    ADDP  D28, V14.2D
    ADDV  B12, V9.16B
    ADDHN2  V9.4S, V20.2D, V10.2D
    ADDV  S3, V26.4S
    ADDV  B11, V7.8B
    ADD  V31.2S, V20.2S, V14.2S
    ADDHN2  V28.8H, V31.4S, V24.4S
    ADD  D1, D21, D14
    ADDP  V13.2S, V30.2S, V19.2S
    ADDP  D24, V20.2D
    ADDP  D15, V0.2D
    ADDV  H0, V24.8H
    ADD  D12, D8, D13
    ADDHN2  V3.8H, V17.4S, V5.4S
    ADDHN2  V30.4S, V3.2D, V1.2D
    ADDV  H25, V20.4H
    ADDP  V29.2D, V26.2D, V11.2D
    ADD  V29.2S, V10.2S, V26.2S
    ADDP  D30, V20.2D
    ADDHN2  V4.4S, V20.2D, V13.2D
    ADDP  D25, V15.2D
    ADDV  B7, V19.16B
    ADDP  V4.4H, V15.4H, V8.4H
    ADDV  H4, V25.4H
    ADDHN  V4.2S, V29.2D, V9.2D
    ADD  V27.8B, V23.8B, V7.8B
    ADDP  V19.4H, V23.4H, V31.4H
    ADDV  H27, V22.8H
    ADDP  D17, V27.2D
    ADD  D2, D19, D21
    ADDV  S31, V11.4S
    ADDV  S14, V30.4S
    ADDV  H15, V5.4H
    ADDV  H4, V19.4H
    ADDV  S4, V11.4S
    ADDV  H5, V4.4H
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdImmP01_label_325
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X15, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X25, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X12, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X28, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X19, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X17, D7
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X21, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X24, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X20, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X20, D11
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X16, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X16, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X12, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X16, D15
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X17, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X24, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X8, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X12, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X2, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X7, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X11, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X5, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X16, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X22, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X7, D27
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X21, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X26, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
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
TaishanSimdImmP01_label_216:
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
    FMOV  V0.D[1], X26
    FMOV  D1, X11
    FMOV  V1.D[1], X27
    FMOV  D2, X9
    FMOV  V2.D[1], X9
    FMOV  D3, X25
    FMOV  V3.D[1], X27
    FMOV  D4, X26
    FMOV  V4.D[1], X29
    FMOV  D5, X15
    FMOV  V5.D[1], X3
    FMOV  D6, X5
    FMOV  V6.D[1], X7
    FMOV  D7, X21
    FMOV  V7.D[1], X16
    FMOV  D8, X14
    FMOV  V8.D[1], X13
    FMOV  D9, X18
    FMOV  V9.D[1], X12
    FMOV  D10, X27
    FMOV  V10.D[1], X25
    FMOV  D11, X18
    FMOV  V11.D[1], X27
    FMOV  D12, X24
    FMOV  V12.D[1], X7
    FMOV  D13, X16
    FMOV  V13.D[1], X14
    FMOV  D14, X9
    FMOV  V14.D[1], X15
    FMOV  D15, X10
    FMOV  V15.D[1], X10
    FMOV  D16, X18
    FMOV  V16.D[1], X12
    FMOV  D17, X19
    FMOV  V17.D[1], X10
    FMOV  D18, X29
    FMOV  V18.D[1], X28
    FMOV  D19, X26
    FMOV  V19.D[1], X2
    FMOV  D20, X21
    FMOV  V20.D[1], X16
    FMOV  D21, X26
    FMOV  V21.D[1], X16
    FMOV  D22, X28
    FMOV  V22.D[1], X20
    FMOV  D23, X26
    FMOV  V23.D[1], X22
    FMOV  D24, X29
    FMOV  V24.D[1], X15
    FMOV  D25, X28
    FMOV  V25.D[1], X3
    FMOV  D26, X22
    FMOV  V26.D[1], X25
    FMOV  D27, X5
    FMOV  V27.D[1], X8
    FMOV  D28, X13
    FMOV  V28.D[1], X7
    FMOV  D29, X28
    FMOV  V29.D[1], X13
    FMOV  D30, X20
    FMOV  V30.D[1], X21
    FMOV  D31, X26
    FMOV  V31.D[1], X5
    MOVZ  X22, #0xf, LSL #0
TaishanSimdImmP01_label_403:
    ADDHN2  V30.8H, V28.4S, V21.4S
    ADDV  H5, V29.4H
    ADDV  H10, V26.4H
    ADDV  S0, V20.4S
    ADD  V23.4H, V19.4H, V28.4H
    ADDV  S24, V10.4S
    ADDV  B11, V2.8B
    ADDHN2  V2.4S, V0.2D, V10.2D
    ADDHN2  V5.16B, V25.8H, V19.8H
    ADDV  S5, V24.4S
    ADDHN  V25.8B, V18.8H, V29.8H
    ADD  V9.16B, V21.16B, V14.16B
    ADDHN2  V23.16B, V15.8H, V15.8H
    ADDHN2  V4.16B, V12.8H, V31.8H
    ADDV  B0, V7.8B
    ADD  D4, D9, D29
    ADDV  B17, V30.8B
    ADDP  V19.4H, V10.4H, V21.4H
    ADDV  B31, V2.16B
    ADDP  D23, V30.2D
    ADD  D5, D14, D2
    ADDHN  V16.2S, V1.2D, V21.2D
    ADDV  B1, V15.8B
    ADDV  S19, V5.4S
    ADDV  S20, V0.4S
    ADDHN2  V16.16B, V12.8H, V20.8H
    ADD  D11, D0, D6
    ADD  D21, D14, D29
    ADDP  V16.2S, V7.2S, V9.2S
    ADD  V19.2D, V18.2D, V12.2D
    ADDV  B24, V7.16B
    ADDP  D30, V27.2D
    ADD  D26, D18, D10
    ADDP  V14.16B, V2.16B, V14.16B
    ADD  D9, D11, D13
    ADD  D2, D26, D26
    ADDV  H28, V7.8H
    ADDP  D2, V19.2D
    ADDHN2  V27.8H, V19.4S, V28.4S
    ADDHN2  V16.4S, V7.2D, V6.2D
    ADDV  S19, V1.4S
    ADDP  V25.4S, V11.4S, V11.4S
    ADDV  H0, V1.4H
    ADDV  B21, V4.8B
    ADD  V13.8H, V17.8H, V13.8H
    ADDP  V11.8B, V17.8B, V28.8B
    ADDHN2  V22.16B, V18.8H, V0.8H
    ADDP  D2, V12.2D
    ADD  V24.8H, V24.8H, V12.8H
    ADDV  H9, V12.8H
    ADDP  D23, V31.2D
    ADDHN  V2.8B, V18.8H, V26.8H
    ADD  D25, D20, D29
    ADDV  H17, V13.8H
    ADDHN2  V17.4S, V0.2D, V31.2D
    ADDV  B8, V0.16B
    ADDHN2  V4.16B, V4.8H, V8.8H
    ADDV  B20, V22.16B
    ADDHN2  V28.8H, V30.4S, V6.4S
    ADD  D22, D29, D14
    ADDP  D30, V16.2D
    ADDHN2  V10.16B, V25.8H, V15.8H
    ADDP  D6, V13.2D
    ADDP  D21, V31.2D
    ADD  V11.8H, V25.8H, V31.8H
    ADDV  H22, V5.4H
    ADDV  S11, V17.4S
    ADDP  D10, V0.2D
    ADDHN  V31.8B, V19.8H, V0.8H
    ADD  D12, D9, D15
    ADDV  H13, V12.8H
    ADDP  D1, V3.2D
    ADD  D8, D3, D21
    ADDV  B29, V7.8B
    ADDHN  V12.8B, V1.8H, V15.8H
    ADDV  H2, V13.4H
    ADD  D9, D16, D7
    ADDV  H6, V21.8H
    ADDHN2  V26.4S, V28.2D, V17.2D
    ADDHN  V14.8B, V3.8H, V22.8H
    ADD  D18, D21, D23
    ADDV  B29, V18.16B
    ADDHN2  V22.8H, V12.4S, V24.4S
    ADDHN  V29.2S, V16.2D, V9.2D
    ADD  V19.8B, V13.8B, V1.8B
    ADDHN  V23.4H, V2.4S, V3.4S
    ADD  D26, D8, D8
    ADDP  D17, V28.2D
    ADDV  H26, V18.4H
    ADD  D16, D25, D23
    ADDHN2  V14.4S, V28.2D, V28.2D
    ADDP  D6, V13.2D
    ADD  V15.8H, V6.8H, V19.8H
    ADD  V19.8B, V6.8B, V31.8B
    ADDV  B12, V16.8B
    ADDHN  V25.2S, V6.2D, V12.2D
    ADDHN  V3.8B, V11.8H, V14.8H
    ADDP  D9, V1.2D
    ADDV  B7, V29.16B
    ADDP  D22, V31.2D
    ADDV  B23, V6.16B
    ADDP  V0.2S, V13.2S, V30.2S
    ADDV  S6, V18.4S
    ADD  V3.16B, V10.16B, V25.16B
    ADDV  S7, V13.4S
    ADDV  H25, V13.4H
    ADDHN  V15.8B, V6.8H, V30.8H
    ADDV  H9, V13.8H
    ADDV  H27, V3.4H
    ADDV  S30, V8.4S
    ADD  V6.8B, V31.8B, V28.8B
    ADD  D16, D29, D10
    ADDP  D20, V10.2D
    ADDP  D12, V29.2D
    ADDV  B24, V3.16B
    ADDHN2  V26.16B, V12.8H, V6.8H
    ADDV  H2, V18.8H
    ADDHN  V19.8B, V1.8H, V12.8H
    ADDV  B31, V1.16B
    ADDP  V30.2D, V19.2D, V1.2D
    ADDP  D2, V17.2D
    ADDP  V3.4H, V8.4H, V13.4H
    ADDV  B30, V17.16B
    ADDV  B7, V2.16B
    ADDP  V12.8B, V31.8B, V28.8B
    ADDV  S25, V14.4S
    ADD  D20, D24, D24
    ADDV  B15, V1.16B
    ADDHN  V24.8B, V20.8H, V27.8H
    ADDHN  V27.2S, V11.2D, V24.2D
    ADDHN  V18.2S, V7.2D, V9.2D
    ADDV  S23, V15.4S
    ADDHN  V29.4H, V26.4S, V1.4S
    ADDHN  V1.8B, V31.8H, V27.8H
    ADDP  V4.4S, V13.4S, V13.4S
    ADD  D3, D16, D10
    ADDV  S30, V18.4S
    ADDHN  V8.2S, V25.2D, V10.2D
    ADD  D28, D8, D31
    ADDP  V23.4S, V10.4S, V30.4S
    ADDHN  V15.4H, V15.4S, V2.4S
    ADDHN  V28.2S, V18.2D, V12.2D
    ADD  D15, D9, D17
    ADDV  S5, V10.4S
    ADD  D28, D18, D1
    ADD  V16.8B, V29.8B, V28.8B
    ADDHN  V0.2S, V10.2D, V5.2D
    ADDHN2  V23.8H, V11.4S, V18.4S
    ADDV  S4, V9.4S
    ADDV  B31, V15.8B
    ADDHN  V3.2S, V13.2D, V17.2D
    ADD  V10.16B, V20.16B, V29.16B
    ADD  V5.4S, V28.4S, V28.4S
    ADDP  D22, V18.2D
    ADDP  D13, V28.2D
    ADDHN2  V5.8H, V30.4S, V10.4S
    ADD  D31, D16, D30
    ADDV  S19, V5.4S
    ADDP  D8, V20.2D
    ADDV  H7, V25.4H
    ADDHN  V20.8B, V3.8H, V18.8H
    ADD  V25.4S, V13.4S, V9.4S
    ADDP  V2.4H, V4.4H, V23.4H
    ADDP  D10, V8.2D
    ADDP  V30.4H, V13.4H, V11.4H
    ADD  V21.2D, V29.2D, V12.2D
    ADD  V27.16B, V3.16B, V7.16B
    ADDP  V6.4H, V29.4H, V24.4H
    ADD  V10.4S, V26.4S, V7.4S
    ADDP  V7.8H, V8.8H, V25.8H
    ADDP  D28, V26.2D
    ADDP  V18.2D, V19.2D, V17.2D
    ADDV  S22, V8.4S
    ADD  D17, D30, D29
    ADDHN2  V24.16B, V31.8H, V21.8H
    ADDV  H25, V11.4H
    ADDP  D24, V29.2D
    ADDHN  V29.8B, V2.8H, V29.8H
    ADDV  H14, V22.4H
    ADDV  S9, V25.4S
    ADD  D25, D4, D21
    ADDV  S13, V2.4S
    ADDHN2  V26.16B, V25.8H, V26.8H
    ADDP  V25.4H, V7.4H, V1.4H
    ADD  V21.16B, V3.16B, V10.16B
    ADDP  D6, V12.2D
    ADD  D12, D6, D8
    ADDV  S31, V19.4S
    ADDV  H22, V28.4H
    ADDHN2  V27.8H, V12.4S, V4.4S
    ADD  V0.4H, V9.4H, V16.4H
    ADD  V29.2D, V25.2D, V13.2D
    ADDHN2  V23.4S, V26.2D, V20.2D
    ADDHN2  V18.4S, V16.2D, V30.2D
    ADD  V22.8H, V16.8H, V16.8H
    ADDP  D26, V25.2D
    ADDV  H9, V7.4H
    ADDP  V3.8B, V20.8B, V15.8B
    ADDHN  V17.4H, V15.4S, V17.4S
    ADDHN2  V6.16B, V25.8H, V18.8H
    SUBS  X22, X22, #0x1
    B.NE  TaishanSimdImmP01_label_403
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X24, X2, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X7, X9, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X28, X14, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X21, X17, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X13, X21, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X22, X20, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X2, X4, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X19, X28, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X4, X5, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X20, X6, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X14, X6, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X27, X6, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X24, X7, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X10, X3, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X16, X6, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X20, X13, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X21, D2
    MOVZ  X19, #0x3f18, LSL #0
    MOVK  X19, #0x9d, LSL #32
    SUB  X9, X19, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X21, D3
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xc, LSL #32
    SUB  X2, X5, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X20, D4
    MOVZ  X3, #0x3f18, LSL #0
    SUB  X27, X3, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X21, D5
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X14, #0x1, LSL #0
    MOVK  X14, #0xa, LSL #32
    SUB  X29, X14, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X5, D6
    MOVZ  X14, #0x9d, LSL #0
    MOVK  X14, #0xb5, LSL #32
    SUB  X29, X14, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X20, #0x3f18, LSL #0
    SUB  X4, X20, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X3, D7
    MOVZ  X20, #0x13a, LSL #0
    SUB  X4, X20, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X17, D8
    MOVZ  X9, #0x13a, LSL #0
    SUB  X21, X9, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X22, D9
    MOVZ  X15, #0x13a, LSL #0
    SUB  X21, X15, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X5, #0xf, LSL #0
    SUB  X18, X5, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X16, D10
    MOVZ  X5, #0x53, LSL #0
    SUB  X18, X5, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X5, D11
    MOVZ  X27, #0xa8b, LSL #0
    SUB  X7, X27, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X17, D12
    MOVZ  X29, #0x1d7, LSL #0
    MOVK  X29, #0xb5, LSL #32
    SUB  X15, X29, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X15, D13
    MOVZ  X26, #0x3fb5, LSL #0
    SUB  X20, X26, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X29, D14
    MOVZ  X11, #0x13a, LSL #0
    SUB  X15, X11, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X25, D15
    MOVZ  X17, #0x49c3, LSL #0
    SUB  X27, X17, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X28, D16
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X15, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X28, #0xa8b, LSL #0
    SUB  X22, X28, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X19, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X2, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X5, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X26, #0xf, LSL #0
    SUB  X7, X26, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X29, D21
    MOVZ  X26, #0x53, LSL #0
    SUB  X7, X26, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X2, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X13, D24
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X28, D25
    MOVZ  X26, #0x13a, LSL #0
    SUB  X3, X26, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X24, D26
    MOVZ  X6, #0x13a, LSL #0
    SUB  X2, X6, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X25, D27
    MOVZ  X17, #0xb, LSL #0
    SUB  X4, X17, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X11, D28
    MOVZ  X18, #0x57, LSL #0
    SUB  X9, X18, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X11, D29
    MOVZ  X26, #0x40ef, LSL #0
    SUB  X13, X26, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x331c, LSL #0
    MOVK  X2, #0x89d7, LSL #16
    MOVK  X2, #0x4415, LSL #32
    MOVK  X2, #0x1f6, LSL #48
    MOVZ  X3, #0xa4d0, LSL #0
    MOVK  X3, #0x2998, LSL #16
    MOVK  X3, #0xc576, LSL #32
    MOVK  X3, #0xfd07, LSL #48
    MOVZ  X4, #0xc065, LSL #0
    MOVK  X4, #0x8a4e, LSL #16
    MOVK  X4, #0xd9ff, LSL #32
    MOVK  X4, #0x2245, LSL #48
    MOVZ  X5, #0x2a16, LSL #0
    MOVK  X5, #0x8116, LSL #16
    MOVK  X5, #0x5de6, LSL #32
    MOVK  X5, #0xf331, LSL #48
    MOVZ  X6, #0xf0c, LSL #0
    MOVK  X6, #0x6226, LSL #16
    MOVK  X6, #0xddc8, LSL #32
    MOVK  X6, #0x2205, LSL #48
    MOVZ  X7, #0xaf2e, LSL #0
    MOVK  X7, #0x5116, LSL #16
    MOVK  X7, #0xd087, LSL #32
    MOVK  X7, #0x78c7, LSL #48
    MOVZ  X8, #0xfc99, LSL #0
    MOVK  X8, #0xab0d, LSL #16
    MOVK  X8, #0xc4ca, LSL #32
    MOVK  X8, #0x2cfd, LSL #48
    MOVZ  X9, #0xd234, LSL #0
    MOVK  X9, #0x4668, LSL #16
    MOVK  X9, #0x3a1f, LSL #32
    MOVK  X9, #0x125c, LSL #48
    MOVZ  X10, #0xdaa9, LSL #0
    MOVK  X10, #0x3364, LSL #16
    MOVK  X10, #0x9f67, LSL #32
    MOVK  X10, #0xd2ef, LSL #48
    MOVZ  X11, #0x1d11, LSL #0
    MOVK  X11, #0xf279, LSL #16
    MOVK  X11, #0xe7c8, LSL #32
    MOVK  X11, #0xf6da, LSL #48
    MOVZ  X12, #0x2617, LSL #0
    MOVK  X12, #0xd15c, LSL #16
    MOVK  X12, #0x2196, LSL #32
    MOVK  X12, #0xbda3, LSL #48
    MOVZ  X13, #0x7289, LSL #0
    MOVK  X13, #0xc880, LSL #16
    MOVK  X13, #0x8baa, LSL #32
    MOVK  X13, #0x5689, LSL #48
    MOVZ  X14, #0xa6e7, LSL #0
    MOVK  X14, #0xb2f2, LSL #16
    MOVK  X14, #0x829e, LSL #32
    MOVK  X14, #0xc4a1, LSL #48
    MOVZ  X15, #0xbe51, LSL #0
    MOVK  X15, #0xdd17, LSL #16
    MOVK  X15, #0x2715, LSL #32
    MOVK  X15, #0xf284, LSL #48
    MOVZ  X16, #0x447e, LSL #0
    MOVK  X16, #0x4351, LSL #16
    MOVK  X16, #0xb77f, LSL #32
    MOVK  X16, #0xb12a, LSL #48
    MOVZ  X17, #0xdc27, LSL #0
    MOVK  X17, #0x2221, LSL #16
    MOVK  X17, #0x125e, LSL #32
    MOVK  X17, #0x9af1, LSL #48
    MOVZ  X18, #0xe554, LSL #0
    MOVK  X18, #0x486b, LSL #16
    MOVK  X18, #0x9597, LSL #32
    MOVK  X18, #0x8226, LSL #48
    MOVZ  X19, #0x7f05, LSL #0
    MOVK  X19, #0x37e9, LSL #16
    MOVK  X19, #0xfeef, LSL #32
    MOVK  X19, #0x69da, LSL #48
    MOVZ  X20, #0x9203, LSL #0
    MOVK  X20, #0x6afe, LSL #16
    MOVK  X20, #0xaebe, LSL #32
    MOVK  X20, #0x7ba6, LSL #48
    MOVZ  X21, #0x89fc, LSL #0
    MOVK  X21, #0x194c, LSL #16
    MOVK  X21, #0xd70e, LSL #32
    MOVK  X21, #0xb0d7, LSL #48
    MOVZ  X22, #0xee1b, LSL #0
    MOVK  X22, #0xd634, LSL #16
    MOVK  X22, #0xf12b, LSL #32
    MOVK  X22, #0x48ba, LSL #48
    MOVZ  X24, #0xe65b, LSL #0
    MOVK  X24, #0x57ed, LSL #16
    MOVK  X24, #0x5d23, LSL #32
    MOVK  X24, #0xecaa, LSL #48
    MOVZ  X25, #0x4d23, LSL #0
    MOVK  X25, #0xb8b, LSL #16
    MOVK  X25, #0x2812, LSL #32
    MOVK  X25, #0xf9c1, LSL #48
    MOVZ  X26, #0x8b9b, LSL #0
    MOVK  X26, #0xe592, LSL #16
    MOVK  X26, #0x7ce0, LSL #32
    MOVK  X26, #0xf99d, LSL #48
    MOVZ  X27, #0x5c5b, LSL #0
    MOVK  X27, #0xe18c, LSL #16
    MOVK  X27, #0x2709, LSL #32
    MOVK  X27, #0x2b91, LSL #48
    MOVZ  X28, #0x1974, LSL #0
    MOVK  X28, #0xf166, LSL #16
    MOVK  X28, #0x7708, LSL #32
    MOVK  X28, #0xf0a3, LSL #48
    MOVZ  X29, #0x29a9, LSL #0
    MOVK  X29, #0x6217, LSL #16
    MOVK  X29, #0x3959, LSL #32
    MOVK  X29, #0x1afb, LSL #48
    FMOV  D0, X2
    FMOV  V0.D[1], X16
    FMOV  D1, X24
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X9
    FMOV  D3, X28
    FMOV  V3.D[1], X13
    FMOV  D4, X14
    FMOV  V4.D[1], X22
    FMOV  D5, X7
    FMOV  V5.D[1], X10
    FMOV  D6, X9
    FMOV  V6.D[1], X3
    FMOV  D7, X26
    FMOV  V7.D[1], X29
    FMOV  D8, X13
    FMOV  V8.D[1], X27
    FMOV  D9, X21
    FMOV  V9.D[1], X25
    FMOV  D10, X29
    FMOV  V10.D[1], X26
    FMOV  D11, X17
    FMOV  V11.D[1], X28
    FMOV  D12, X2
    FMOV  V12.D[1], X14
    FMOV  D13, X16
    FMOV  V13.D[1], X6
    FMOV  D14, X26
    FMOV  V14.D[1], X4
    FMOV  D15, X24
    FMOV  V15.D[1], X13
    FMOV  D16, X4
    FMOV  V16.D[1], X24
    FMOV  D17, X21
    FMOV  V17.D[1], X28
    FMOV  D18, X17
    FMOV  V18.D[1], X12
    FMOV  D19, X9
    FMOV  V19.D[1], X17
    FMOV  D20, X13
    FMOV  V20.D[1], X13
    FMOV  D21, X13
    FMOV  V21.D[1], X14
    FMOV  D22, X26
    FMOV  V22.D[1], X26
    FMOV  D23, X15
    FMOV  V23.D[1], X18
    FMOV  D24, X5
    FMOV  V24.D[1], X18
    FMOV  D25, X27
    FMOV  V25.D[1], X27
    FMOV  D26, X5
    FMOV  V26.D[1], X12
    FMOV  D27, X10
    FMOV  V27.D[1], X10
    FMOV  D28, X24
    FMOV  V28.D[1], X16
    FMOV  D29, X19
    FMOV  V29.D[1], X28
    FMOV  D30, X6
    FMOV  V30.D[1], X6
    FMOV  D31, X16
    FMOV  V31.D[1], X12
    MOVZ  X15, #0xa, LSL #0
TaishanSimdImmP01_label_479:
    ADDP  D15, V29.2D
    ADD  D7, D13, D16
    ADDP  D28, V27.2D
    ADDV  B20, V8.16B
    ADDP  D9, V28.2D
    ADD  V13.4H, V11.4H, V30.4H
    ADDHN  V4.4H, V7.4S, V8.4S
    ADDV  H29, V26.4H
    ADDHN  V25.4H, V8.4S, V10.4S
    ADDV  B18, V7.8B
    ADD  D14, D21, D4
    ADDV  B11, V13.16B
    ADDHN  V5.8B, V5.8H, V9.8H
    ADDV  S28, V20.4S
    ADD  V29.2S, V5.2S, V27.2S
    ADDV  B14, V21.16B
    ADDHN2  V29.4S, V3.2D, V24.2D
    ADDHN  V24.2S, V18.2D, V5.2D
    ADDV  S14, V10.4S
    ADDP  D15, V24.2D
    ADDP  V28.16B, V16.16B, V9.16B
    ADDP  V22.2S, V4.2S, V19.2S
    ADDHN2  V20.4S, V28.2D, V13.2D
    ADDHN  V30.2S, V20.2D, V25.2D
    ADDV  B12, V30.16B
    ADDHN  V19.2S, V19.2D, V4.2D
    ADDV  B18, V4.8B
    ADDHN  V7.2S, V9.2D, V30.2D
    ADDHN2  V19.16B, V23.8H, V19.8H
    ADDP  D30, V8.2D
    ADDP  D10, V3.2D
    ADDHN  V6.2S, V0.2D, V20.2D
    ADDV  S24, V8.4S
    ADDHN  V9.2S, V8.2D, V18.2D
    ADD  D0, D9, D27
    ADDV  H22, V6.4H
    ADDHN2  V3.8H, V24.4S, V0.4S
    ADDV  H0, V22.8H
    ADD  D30, D4, D16
    ADDV  B0, V4.16B
    ADD  V0.4H, V19.4H, V22.4H
    ADDV  B6, V0.8B
    ADDV  B0, V15.8B
    ADDHN  V23.8B, V24.8H, V14.8H
    ADDV  H23, V9.8H
    ADD  D10, D22, D27
    ADDV  S20, V14.4S
    ADD  D7, D18, D3
    ADD  D26, D31, D22
    ADDV  B28, V23.8B
    ADDV  B31, V2.8B
    ADDV  S30, V10.4S
    ADD  V6.8B, V26.8B, V3.8B
    ADDV  H14, V5.4H
    ADD  V23.2S, V7.2S, V31.2S
    ADD  V10.8H, V0.8H, V27.8H
    ADDV  B25, V22.16B
    ADD  V25.4H, V31.4H, V20.4H
    ADDP  V15.2D, V28.2D, V27.2D
    ADDHN  V23.2S, V24.2D, V9.2D
    ADDV  B29, V14.8B
    ADDP  V23.4H, V17.4H, V30.4H
    ADDP  V9.4H, V7.4H, V12.4H
    ADDV  H6, V0.4H
    ADDHN  V24.8B, V6.8H, V6.8H
    ADDHN2  V3.8H, V12.4S, V13.4S
    ADDP  V10.4H, V20.4H, V30.4H
    ADDHN2  V4.8H, V0.4S, V18.4S
    ADDHN  V1.8B, V10.8H, V31.8H
    ADDHN2  V1.4S, V8.2D, V0.2D
    ADD  V10.4S, V17.4S, V1.4S
    ADDP  D6, V24.2D
    ADD  V7.8H, V19.8H, V16.8H
    ADDV  S3, V25.4S
    ADD  V23.16B, V10.16B, V7.16B
    ADDP  D8, V4.2D
    ADDHN  V1.8B, V18.8H, V16.8H
    ADD  V10.8B, V25.8B, V14.8B
    ADDHN  V23.2S, V14.2D, V2.2D
    ADDHN2  V10.8H, V28.4S, V28.4S
    ADD  V21.4H, V21.4H, V10.4H
    ADDV  B12, V11.16B
    ADDHN  V31.8B, V20.8H, V13.8H
    ADDV  B11, V21.16B
    ADDV  S27, V3.4S
    ADDHN2  V1.16B, V11.8H, V31.8H
    ADDHN  V11.2S, V16.2D, V7.2D
    ADDHN  V29.2S, V17.2D, V6.2D
    ADDHN  V1.8B, V8.8H, V6.8H
    ADDHN  V30.4H, V12.4S, V30.4S
    ADDV  B8, V1.8B
    ADDV  H12, V12.8H
    ADDHN2  V25.16B, V8.8H, V0.8H
    ADDV  B8, V10.16B
    ADD  D0, D13, D2
    ADDHN2  V28.8H, V11.4S, V12.4S
    ADDP  V3.4H, V29.4H, V1.4H
    ADD  D0, D10, D21
    ADDHN2  V10.8H, V20.4S, V3.4S
    ADD  D14, D6, D19
    ADDV  S15, V22.4S
    ADDP  V15.2D, V11.2D, V16.2D
    ADD  D9, D0, D24
    ADDP  V17.4S, V18.4S, V13.4S
    ADDP  D2, V15.2D
    ADDV  B0, V26.8B
    ADDHN  V0.8B, V11.8H, V21.8H
    ADDHN  V4.4H, V17.4S, V14.4S
    ADDP  V17.4H, V29.4H, V15.4H
    ADDV  B17, V27.16B
    ADDHN2  V24.4S, V27.2D, V9.2D
    ADDP  V27.8H, V7.8H, V11.8H
    ADDV  B0, V30.8B
    ADD  D25, D15, D18
    ADDV  B14, V7.16B
    ADDP  D14, V29.2D
    ADDV  H17, V4.8H
    ADDV  B27, V9.16B
    ADD  D7, D20, D2
    ADDHN2  V7.8H, V2.4S, V22.4S
    ADDV  S11, V20.4S
    ADDHN  V0.2S, V13.2D, V17.2D
    ADDHN2  V19.4S, V8.2D, V7.2D
    ADD  D18, D20, D11
    ADDV  H5, V25.8H
    ADDV  H1, V2.4H
    ADD  V26.2S, V30.2S, V13.2S
    ADDV  H5, V31.4H
    ADDP  D15, V16.2D
    ADDP  V1.8H, V11.8H, V29.8H
    ADD  V26.16B, V0.16B, V18.16B
    ADDHN  V21.8B, V16.8H, V21.8H
    ADDP  D19, V4.2D
    ADDV  S22, V5.4S
    ADD  V29.8H, V13.8H, V17.8H
    ADDHN2  V0.8H, V19.4S, V17.4S
    ADDV  S31, V1.4S
    ADDP  D21, V27.2D
    ADDV  B0, V2.16B
    ADDHN2  V15.16B, V27.8H, V31.8H
    ADDP  D31, V16.2D
    ADDP  V6.2S, V15.2S, V1.2S
    ADDHN  V15.8B, V2.8H, V13.8H
    ADDHN  V13.8B, V25.8H, V28.8H
    ADD  V1.16B, V12.16B, V11.16B
    ADDV  B18, V7.8B
    ADD  V15.4H, V2.4H, V5.4H
    ADDV  B3, V12.16B
    ADDP  V11.4S, V14.4S, V7.4S
    ADD  D1, D29, D6
    ADD  V24.4S, V4.4S, V25.4S
    ADD  V28.4S, V12.4S, V3.4S
    ADDHN2  V4.8H, V1.4S, V13.4S
    ADDV  S11, V4.4S
    ADDHN  V13.8B, V13.8H, V22.8H
    ADDV  B26, V30.8B
    ADDV  H24, V17.4H
    ADDV  S10, V11.4S
    ADDV  S22, V4.4S
    ADDV  S7, V20.4S
    ADDP  V2.8B, V13.8B, V17.8B
    ADDP  D16, V14.2D
    ADDV  H11, V31.8H
    ADD  D1, D12, D20
    ADDP  V18.8H, V30.8H, V19.8H
    ADDP  D26, V0.2D
    ADDV  H6, V28.8H
    ADDP  V13.8H, V6.8H, V29.8H
    ADD  D9, D19, D3
    ADDP  V12.4S, V24.4S, V18.4S
    ADDV  S28, V5.4S
    ADDP  D19, V17.2D
    ADDP  V7.16B, V5.16B, V4.16B
    ADDV  H25, V24.4H
    ADD  V12.8B, V6.8B, V18.8B
    ADDHN  V1.2S, V17.2D, V11.2D
    ADDP  V25.4S, V23.4S, V31.4S
    ADDP  D3, V22.2D
    ADD  V0.8B, V24.8B, V30.8B
    ADDV  S4, V14.4S
    ADDP  V10.2D, V7.2D, V29.2D
    ADDP  D19, V13.2D
    ADDHN  V30.4H, V26.4S, V0.4S
    ADDHN2  V9.4S, V19.2D, V15.2D
    ADD  V3.16B, V29.16B, V13.16B
    ADDHN  V8.4H, V7.4S, V5.4S
    ADDV  B3, V28.16B
    ADDV  S9, V16.4S
    ADDHN2  V6.16B, V28.8H, V22.8H
    ADDP  V2.8H, V17.8H, V21.8H
    ADDP  D29, V28.2D
    ADD  D24, D26, D21
    ADD  D6, D22, D5
    ADDV  H22, V26.4H
    ADDHN2  V28.16B, V8.8H, V12.8H
    ADDP  V1.2D, V18.2D, V8.2D
    ADDV  H25, V13.4H
    ADDP  D19, V6.2D
    ADD  D3, D7, D11
    ADDP  V25.2D, V21.2D, V10.2D
    SUBS  X15, X15, #0x1
    B.NE  TaishanSimdImmP01_label_479
    MOVZ  X16, #0x331c, LSL #0
    MOVK  X16, #0x89d7, LSL #16
    MOVK  X16, #0x4415, LSL #32
    MOVK  X16, #0x1f6, LSL #48
    SUB  X11, X16, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0xa4d0, LSL #0
    MOVK  X5, #0x2998, LSL #16
    MOVK  X5, #0xc576, LSL #32
    MOVK  X5, #0xfd07, LSL #48
    SUB  X21, X5, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0xc065, LSL #0
    MOVK  X3, #0x8a4e, LSL #16
    MOVK  X3, #0xd9ff, LSL #32
    MOVK  X3, #0x2245, LSL #48
    SUB  X22, X3, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0xa4d0, LSL #0
    MOVK  X14, #0x2998, LSL #16
    MOVK  X14, #0xc576, LSL #32
    MOVK  X14, #0xfd07, LSL #48
    SUB  X16, X14, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0xf0c, LSL #0
    MOVK  X24, #0x6226, LSL #16
    MOVK  X24, #0xddc8, LSL #32
    MOVK  X24, #0x2205, LSL #48
    SUB  X25, X24, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xaf2e, LSL #0
    MOVK  X13, #0x5116, LSL #16
    MOVK  X13, #0xd087, LSL #32
    MOVK  X13, #0x78c7, LSL #48
    SUB  X17, X13, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xfc99, LSL #0
    MOVK  X2, #0xab0d, LSL #16
    MOVK  X2, #0xc4ca, LSL #32
    MOVK  X2, #0x2cfd, LSL #48
    SUB  X29, X2, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0xd234, LSL #0
    MOVK  X16, #0x4668, LSL #16
    MOVK  X16, #0x3a1f, LSL #32
    MOVK  X16, #0x125c, LSL #48
    SUB  X5, X16, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0xdaa9, LSL #0
    MOVK  X9, #0x3364, LSL #16
    MOVK  X9, #0x9f67, LSL #32
    MOVK  X9, #0xd2ef, LSL #48
    SUB  X12, X9, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0xaf2e, LSL #0
    MOVK  X19, #0x5116, LSL #16
    MOVK  X19, #0xd087, LSL #32
    MOVK  X19, #0x78c7, LSL #48
    SUB  X13, X19, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xa4d0, LSL #0
    MOVK  X21, #0x2998, LSL #16
    MOVK  X21, #0xc576, LSL #32
    MOVK  X21, #0xfd07, LSL #48
    SUB  X25, X21, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0xaf2e, LSL #0
    MOVK  X3, #0x5116, LSL #16
    MOVK  X3, #0xd087, LSL #32
    MOVK  X3, #0x78c7, LSL #48
    SUB  X9, X3, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x9203, LSL #0
    MOVK  X8, #0x6afe, LSL #16
    MOVK  X8, #0xaebe, LSL #32
    MOVK  X8, #0x7ba6, LSL #48
    SUB  X18, X8, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0xa4d0, LSL #0
    MOVK  X6, #0x2998, LSL #16
    MOVK  X6, #0xc576, LSL #32
    MOVK  X6, #0xfd07, LSL #48
    SUB  X26, X6, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0xf0c, LSL #0
    MOVK  X14, #0x6226, LSL #16
    MOVK  X14, #0xddc8, LSL #32
    MOVK  X14, #0x2205, LSL #48
    SUB  X3, X14, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x1974, LSL #0
    MOVK  X29, #0xf166, LSL #16
    MOVK  X29, #0x7708, LSL #32
    MOVK  X29, #0xf0a3, LSL #48
    SUB  X5, X29, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x1974, LSL #0
    MOVK  X10, #0xf166, LSL #16
    MOVK  X10, #0x7708, LSL #32
    MOVK  X10, #0xf0a3, LSL #48
    SUB  X26, X10, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X14, #0xf6, LSL #0
    SUB  X24, X14, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X13, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X6, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X17, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X28, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X15, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X11, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X4, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X10, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X15, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X16, D11
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X20, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X29, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X13, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X13, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X29, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X8, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X5, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X15, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X5, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X13, D21
    MOVZ  X24, #0xf6, LSL #0
    SUB  X7, X24, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X27, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X20, D24
    MOVZ  X10, #0xf6, LSL #0
    SUB  X9, X10, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X10, D25
    MOVZ  X15, #0xf6, LSL #0
    SUB  X18, X15, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X11, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X6, D27
    MOVZ  X4, #0xf6, LSL #0
    SUB  X10, X4, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X8, D28
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X28, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X9
    FMOV  V0.D[1], X4
    FMOV  D1, X18
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X16
    FMOV  D3, X18
    FMOV  V3.D[1], X25
    FMOV  D4, X4
    FMOV  V4.D[1], X9
    FMOV  D5, X26
    FMOV  V5.D[1], X19
    FMOV  D6, X27
    FMOV  V6.D[1], X18
    FMOV  D7, X22
    FMOV  V7.D[1], X16
    FMOV  D8, X18
    FMOV  V8.D[1], X10
    FMOV  D9, X27
    FMOV  V9.D[1], X11
    FMOV  D10, X3
    FMOV  V10.D[1], X15
    FMOV  D11, X27
    FMOV  V11.D[1], X19
    FMOV  D12, X14
    FMOV  V12.D[1], X21
    FMOV  D13, X2
    FMOV  V13.D[1], X24
    FMOV  D14, X24
    FMOV  V14.D[1], X19
    FMOV  D15, X3
    FMOV  V15.D[1], X10
    FMOV  D16, X14
    FMOV  V16.D[1], X12
    FMOV  D17, X10
    FMOV  V17.D[1], X5
    FMOV  D18, X3
    FMOV  V18.D[1], X16
    FMOV  D19, X19
    FMOV  V19.D[1], X12
    FMOV  D20, X15
    FMOV  V20.D[1], X13
    FMOV  D21, X11
    FMOV  V21.D[1], X12
    FMOV  D22, X27
    FMOV  V22.D[1], X18
    FMOV  D23, X13
    FMOV  V23.D[1], X15
    FMOV  D24, X6
    FMOV  V24.D[1], X19
    FMOV  D25, X20
    FMOV  V25.D[1], X24
    FMOV  D26, X14
    FMOV  V26.D[1], X27
    FMOV  D27, X17
    FMOV  V27.D[1], X24
    FMOV  D28, X7
    FMOV  V28.D[1], X15
    FMOV  D29, X22
    FMOV  V29.D[1], X2
    FMOV  D30, X26
    FMOV  V30.D[1], X28
    FMOV  D31, X10
    FMOV  V31.D[1], X21
    MOVZ  X26, #0xa, LSL #0
TaishanSimdImmP01_label_553:
    ADD  D24, D11, D24
    ADDV  H26, V1.4H
    ADDV  H3, V20.4H
    ADD  V0.16B, V29.16B, V0.16B
    ADDV  B9, V20.16B
    ADDP  D10, V18.2D
    ADDP  D15, V31.2D
    ADDHN  V28.8B, V30.8H, V18.8H
    ADDV  S29, V13.4S
    ADDP  V29.8B, V28.8B, V9.8B
    ADDP  V31.2S, V20.2S, V15.2S
    ADDP  D1, V6.2D
    ADDP  V25.2D, V9.2D, V24.2D
    ADD  V23.8H, V17.8H, V26.8H
    ADDP  D20, V24.2D
    ADDP  V7.4H, V29.4H, V23.4H
    ADDP  V4.8H, V26.8H, V24.8H
    ADD  D28, D20, D23
    ADDP  D8, V21.2D
    ADDV  H25, V8.8H
    ADDHN  V2.4H, V5.4S, V11.4S
    ADDV  S7, V3.4S
    ADD  V3.8B, V6.8B, V8.8B
    ADDV  S31, V7.4S
    ADDHN2  V5.4S, V16.2D, V13.2D
    ADDHN  V21.2S, V15.2D, V5.2D
    ADDHN  V4.8B, V0.8H, V23.8H
    ADDP  D31, V30.2D
    ADDP  V30.8H, V27.8H, V19.8H
    ADDV  H20, V7.4H
    ADD  V17.2D, V12.2D, V1.2D
    ADDHN2  V17.8H, V10.4S, V26.4S
    ADDV  S29, V3.4S
    ADDV  B10, V8.16B
    ADDV  H13, V28.8H
    ADDHN2  V2.4S, V11.2D, V21.2D
    ADD  V28.8H, V29.8H, V9.8H
    ADDHN  V3.8B, V10.8H, V25.8H
    ADDV  H3, V20.8H
    ADD  V30.4S, V5.4S, V7.4S
    ADDV  S28, V30.4S
    ADD  D9, D22, D4
    ADDP  D22, V30.2D
    ADDHN  V22.4H, V17.4S, V20.4S
    ADDP  V8.4S, V31.4S, V30.4S
    ADDP  D5, V9.2D
    ADDHN  V5.8B, V24.8H, V5.8H
    ADD  D28, D1, D22
    ADDV  S25, V22.4S
    ADDV  B11, V7.8B
    ADDV  H7, V18.4H
    ADDV  B13, V16.8B
    ADDV  H14, V9.4H
    ADDP  V31.4H, V7.4H, V22.4H
    ADD  V23.2S, V23.2S, V29.2S
    ADDV  B3, V20.16B
    ADDHN2  V25.16B, V25.8H, V5.8H
    ADD  V10.8H, V5.8H, V12.8H
    ADDP  V8.8B, V24.8B, V7.8B
    ADDV  B13, V20.16B
    ADDV  B8, V23.16B
    ADD  D4, D3, D15
    ADDHN2  V11.8H, V22.4S, V18.4S
    ADD  V16.2S, V17.2S, V25.2S
    ADDP  D5, V8.2D
    ADDP  V7.16B, V18.16B, V2.16B
    ADDV  S9, V11.4S
    ADDP  D7, V26.2D
    ADDV  B11, V9.8B
    ADDHN  V8.8B, V14.8H, V24.8H
    ADDHN  V28.8B, V15.8H, V23.8H
    ADDV  H29, V29.4H
    ADDHN  V27.4H, V3.4S, V1.4S
    ADD  D23, D5, D10
    ADDV  B16, V25.16B
    ADDV  H8, V23.8H
    ADDV  B28, V21.8B
    ADDV  S23, V5.4S
    ADDP  V3.16B, V13.16B, V29.16B
    ADD  V7.4H, V29.4H, V6.4H
    ADDP  V15.4H, V19.4H, V8.4H
    ADDHN2  V3.16B, V26.8H, V21.8H
    ADDP  D25, V17.2D
    ADDP  V26.4S, V8.4S, V27.4S
    ADDP  V10.8B, V28.8B, V20.8B
    ADD  D26, D19, D25
    ADDV  H9, V17.8H
    ADD  D2, D23, D19
    ADD  D27, D10, D16
    ADDV  H13, V8.4H
    ADD  V2.2D, V21.2D, V28.2D
    ADDHN2  V12.16B, V15.8H, V19.8H
    ADDHN2  V12.16B, V15.8H, V20.8H
    ADDV  H31, V2.4H
    ADDP  D5, V7.2D
    ADDP  V6.2D, V4.2D, V18.2D
    ADD  V16.4S, V7.4S, V31.4S
    ADD  D31, D28, D31
    ADD  V21.4H, V3.4H, V23.4H
    ADDV  B29, V7.16B
    ADDP  V22.2S, V26.2S, V17.2S
    ADDHN2  V19.8H, V29.4S, V22.4S
    ADDP  V10.16B, V10.16B, V19.16B
    ADDV  H1, V30.4H
    ADDV  S26, V3.4S
    ADDHN2  V7.4S, V16.2D, V11.2D
    ADD  D19, D20, D5
    ADDP  V6.8B, V10.8B, V3.8B
    ADDV  H26, V21.4H
    ADD  V0.16B, V26.16B, V7.16B
    ADDP  D28, V23.2D
    ADDV  S15, V18.4S
    ADDP  V10.8H, V30.8H, V7.8H
    ADD  V26.8H, V3.8H, V20.8H
    ADDP  V27.2S, V13.2S, V23.2S
    ADDHN2  V27.4S, V0.2D, V27.2D
    ADDV  H8, V27.4H
    ADDP  D4, V6.2D
    ADDP  D1, V17.2D
    ADDP  D4, V27.2D
    ADD  D31, D22, D19
    ADDV  H8, V14.4H
    ADDP  D21, V31.2D
    ADDHN  V19.2S, V13.2D, V28.2D
    ADD  D10, D4, D23
    ADDV  S3, V15.4S
    ADDP  V7.16B, V27.16B, V14.16B
    ADDV  S26, V19.4S
    ADDP  V31.4S, V19.4S, V1.4S
    ADDV  B6, V24.16B
    ADDV  H8, V20.8H
    ADDHN2  V8.8H, V27.4S, V13.4S
    ADDHN2  V28.8H, V8.4S, V23.4S
    ADDV  B17, V1.16B
    ADD  D5, D10, D18
    ADDHN2  V12.16B, V8.8H, V20.8H
    ADDV  S16, V22.4S
    ADDV  B26, V29.8B
    ADDV  S8, V26.4S
    ADD  V22.16B, V27.16B, V16.16B
    ADD  V19.2D, V3.2D, V14.2D
    ADDHN2  V30.4S, V30.2D, V11.2D
    ADDV  B23, V17.8B
    ADDP  D21, V26.2D
    ADDV  H6, V19.4H
    ADD  D19, D22, D30
    ADDV  S18, V8.4S
    ADDP  V28.4S, V4.4S, V24.4S
    ADD  V13.2D, V11.2D, V13.2D
    ADDP  D2, V12.2D
    ADDHN  V0.2S, V22.2D, V17.2D
    ADDV  H20, V28.8H
    ADDP  V20.2D, V18.2D, V23.2D
    ADDP  V21.2S, V16.2S, V13.2S
    ADDV  B1, V1.8B
    ADD  D2, D2, D8
    ADDV  H1, V0.4H
    ADD  D4, D2, D26
    ADD  V6.8H, V25.8H, V0.8H
    ADD  D13, D6, D21
    ADDHN2  V7.8H, V0.4S, V5.4S
    ADDHN2  V31.4S, V10.2D, V3.2D
    ADDHN2  V24.4S, V13.2D, V9.2D
    ADD  D24, D14, D23
    ADDV  H4, V8.4H
    ADDP  D14, V24.2D
    ADDP  V18.16B, V19.16B, V17.16B
    ADDV  B3, V12.8B
    ADDHN2  V26.8H, V2.4S, V8.4S
    ADD  D16, D28, D11
    ADDHN2  V25.16B, V3.8H, V25.8H
    ADDV  S30, V16.4S
    ADDP  V23.2D, V7.2D, V11.2D
    ADD  V13.2S, V12.2S, V26.2S
    ADDP  V19.4S, V14.4S, V12.4S
    ADD  V7.8B, V13.8B, V18.8B
    ADDV  H21, V15.8H
    ADDV  S11, V18.4S
    ADD  V30.4S, V11.4S, V9.4S
    ADDHN2  V8.8H, V23.4S, V10.4S
    ADDV  S25, V28.4S
    ADDV  H2, V20.8H
    ADDP  D8, V6.2D
    ADDHN2  V11.8H, V0.4S, V17.4S
    ADD  D16, D14, D16
    ADD  D1, D24, D25
    ADDHN  V22.8B, V11.8H, V2.8H
    ADDHN2  V16.8H, V7.4S, V15.4S
    ADDV  B11, V7.16B
    ADDV  S14, V16.4S
    ADDV  H23, V16.8H
    ADD  D22, D24, D5
    ADDV  S23, V30.4S
    ADDP  D25, V4.2D
    ADDP  V8.8B, V22.8B, V30.8B
    ADDV  B27, V13.16B
    ADDP  V23.16B, V6.16B, V19.16B
    ADDHN  V5.4H, V25.4S, V1.4S
    ADDHN2  V25.8H, V15.4S, V8.4S
    ADD  V10.2S, V14.2S, V4.2S
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdImmP01_label_553
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X22, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X28, D3
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X18, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X21, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X2, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X4, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X19, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X20, D9
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X19, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X5, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X21, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X12, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X11, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X13, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
TaishanSimdImmP01_label_208:
    FMOV  X2, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X27, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X8, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X17, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X29, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X3, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X25, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X18, D24
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X15, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X27, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X14, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X8, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X17, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
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
    FMOV  D0, X12
    FMOV  V0.D[1], X3
    FMOV  D1, X8
    FMOV  V1.D[1], X9
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X9
    FMOV  V3.D[1], X21
    FMOV  D4, X7
    FMOV  V4.D[1], X11
    FMOV  D5, X29
    FMOV  V5.D[1], X16
    FMOV  D6, X9
    FMOV  V6.D[1], X28
    FMOV  D7, X5
    FMOV  V7.D[1], X25
    FMOV  D8, X2
    FMOV  V8.D[1], X26
    FMOV  D9, X18
    FMOV  V9.D[1], X19
    FMOV  D10, X21
    FMOV  V10.D[1], X7
    FMOV  D11, X18
    FMOV  V11.D[1], X20
    FMOV  D12, X19
    FMOV  V12.D[1], X25
    FMOV  D13, X24
    FMOV  V13.D[1], X13
    FMOV  D14, X17
    FMOV  V14.D[1], X19
TaishanSimdImmP01_label_248:
    FMOV  D15, X7
    FMOV  V15.D[1], X27
    FMOV  D16, X24
    FMOV  V16.D[1], X12
    FMOV  D17, X16
    FMOV  V17.D[1], X29
    FMOV  D18, X5
    FMOV  V18.D[1], X5
    FMOV  D19, X15
    FMOV  V19.D[1], X11
    FMOV  D20, X27
    FMOV  V20.D[1], X5
    FMOV  D21, X15
    FMOV  V21.D[1], X11
    FMOV  D22, X12
    FMOV  V22.D[1], X25
    FMOV  D23, X16
    FMOV  V23.D[1], X3
    FMOV  D24, X18
    FMOV  V24.D[1], X27
    FMOV  D25, X18
    FMOV  V25.D[1], X11
    FMOV  D26, X17
    FMOV  V26.D[1], X8
    FMOV  D27, X6
    FMOV  V27.D[1], X11
    FMOV  D28, X12
    FMOV  V28.D[1], X12
    FMOV  D29, X27
    FMOV  V29.D[1], X24
    FMOV  D30, X4
    FMOV  V30.D[1], X20
    FMOV  D31, X6
    FMOV  V31.D[1], X6
    MOVZ  X16, #0xf, LSL #0
TaishanSimdImmP01_label_632:
    ADDV  B31, V19.16B
    ADDHN2  V11.16B, V9.8H, V14.8H
    ADDP  V9.2D, V13.2D, V27.2D
    ADDP  V7.8B, V4.8B, V7.8B
    ADDV  H29, V9.8H
    ADDV  H12, V15.8H
    ADDHN  V3.8B, V14.8H, V16.8H
    ADDP  D0, V4.2D
    ADD  D0, D12, D15
    ADDP  D24, V0.2D
    ADDHN  V19.2S, V4.2D, V2.2D
    ADD  V5.4S, V1.4S, V23.4S
    ADDV  S15, V4.4S
    ADDV  H18, V14.8H
    ADDP  D9, V2.2D
    ADDV  B9, V31.16B
    ADDV  B24, V3.8B
    ADDHN2  V14.4S, V23.2D, V9.2D
    ADD  D5, D15, D19
    ADDP  V17.8H, V11.8H, V22.8H
    ADDP  V5.8H, V27.8H, V23.8H
    ADDHN2  V23.16B, V31.8H, V7.8H
    ADD  D12, D18, D27
    ADDP  D12, V31.2D
    ADDV  H28, V11.8H
    ADD  D22, D8, D24
    ADDHN  V7.8B, V14.8H, V19.8H
    ADDHN  V19.8B, V11.8H, V16.8H
    ADDHN  V30.8B, V23.8H, V14.8H
    ADD  D21, D30, D29
    ADDP  V6.8B, V8.8B, V13.8B
    ADDP  D10, V14.2D
    ADDHN2  V27.8H, V26.4S, V2.4S
    ADDV  S0, V26.4S
    ADDP  V5.4H, V26.4H, V14.4H
    ADDV  S14, V30.4S
    ADD  V1.2D, V15.2D, V8.2D
    ADDP  D17, V1.2D
    ADDP  D8, V26.2D
    ADDHN2  V8.16B, V23.8H, V13.8H
    ADDP  V17.16B, V10.16B, V22.16B
    ADD  D3, D14, D28
    ADDP  V4.8B, V2.8B, V7.8B
    ADDV  S17, V2.4S
    ADDP  D15, V16.2D
    ADDV  H3, V16.8H
    ADDV  S2, V13.4S
    ADDV  S26, V6.4S
    ADDV  B30, V26.16B
    ADDHN  V20.4H, V11.4S, V16.4S
    ADDV  B12, V23.16B
    ADDHN2  V4.8H, V29.4S, V12.4S
    ADDHN2  V21.8H, V8.4S, V11.4S
    ADDHN2  V7.4S, V17.2D, V0.2D
    ADDP  V18.4H, V5.4H, V15.4H
    ADD  V1.8B, V17.8B, V29.8B
    ADDHN  V0.2S, V6.2D, V3.2D
    ADDHN2  V11.4S, V29.2D, V29.2D
    ADDHN2  V11.16B, V18.8H, V6.8H
    ADDP  V31.8H, V11.8H, V15.8H
    ADDV  S4, V20.4S
    ADDV  H17, V29.8H
    ADD  D22, D1, D7
    ADDHN  V14.2S, V26.2D, V4.2D
    ADDP  V14.4H, V19.4H, V3.4H
    ADD  V9.2D, V31.2D, V13.2D
    ADDHN  V11.4H, V8.4S, V17.4S
    ADDP  D5, V8.2D
    ADDHN2  V13.4S, V2.2D, V20.2D
    ADDP  D12, V14.2D
    ADDHN  V26.2S, V27.2D, V11.2D
    ADD  D19, D23, D7
    ADDHN2  V5.8H, V27.4S, V29.4S
    ADDV  S9, V23.4S
    ADD  V16.4S, V23.4S, V29.4S
    ADDP  V0.2S, V3.2S, V18.2S
    ADDP  D12, V21.2D
    ADDP  V8.16B, V30.16B, V26.16B
    ADDP  D8, V26.2D
    ADDV  H7, V16.8H
    ADDV  S23, V28.4S
    ADDHN2  V4.4S, V20.2D, V17.2D
    ADDP  D17, V20.2D
    ADD  V26.4S, V16.4S, V7.4S
    ADDHN  V0.8B, V3.8H, V27.8H
    ADDV  S4, V13.4S
    ADD  D15, D12, D3
    ADDV  H15, V29.4H
    ADDP  D4, V4.2D
    ADDHN  V13.8B, V7.8H, V13.8H
    ADDHN2  V31.8H, V31.4S, V26.4S
    ADDHN  V1.8B, V26.8H, V31.8H
    ADDV  H3, V25.4H
    ADDHN  V7.2S, V14.2D, V25.2D
    ADDHN2  V0.4S, V27.2D, V2.2D
    ADDP  D15, V17.2D
    ADDV  H23, V30.4H
    ADDHN  V14.2S, V6.2D, V29.2D
    ADD  D13, D13, D20
    ADDV  H2, V13.4H
    ADDV  H9, V0.8H
    ADD  V6.4H, V2.4H, V2.4H
    ADDP  D19, V7.2D
    ADDP  D1, V5.2D
    ADD  V19.4S, V14.4S, V2.4S
    ADDV  B21, V14.8B
    ADDV  B18, V1.8B
    ADDHN2  V23.8H, V29.4S, V27.4S
    ADD  V18.2D, V13.2D, V9.2D
    ADDV  H19, V14.4H
    ADDV  S12, V8.4S
    ADDHN2  V10.16B, V2.8H, V28.8H
    ADDV  S12, V19.4S
    ADDP  V26.2S, V17.2S, V15.2S
    ADDV  H6, V30.8H
    ADDV  H18, V14.4H
    ADDHN2  V0.8H, V30.4S, V18.4S
    ADDV  S10, V1.4S
    ADDV  H23, V8.8H
    ADD  V8.2S, V20.2S, V0.2S
    ADD  V21.8B, V15.8B, V7.8B
    ADD  V20.4S, V30.4S, V22.4S
    ADDV  S14, V10.4S
    ADD  D6, D19, D2
    ADDHN2  V7.8H, V29.4S, V12.4S
    ADD  D11, D22, D1
    ADDV  H9, V25.8H
    ADDP  D17, V13.2D
    ADD  D17, D22, D19
    ADD  V21.16B, V26.16B, V17.16B
    ADD  D19, D28, D18
    ADDP  V14.2D, V7.2D, V6.2D
    ADDHN  V22.2S, V18.2D, V17.2D
    ADDP  D18, V7.2D
    ADD  D7, D25, D22
    ADDHN  V13.8B, V26.8H, V20.8H
    ADD  D15, D10, D1
    ADDP  D26, V6.2D
    ADDP  V12.16B, V27.16B, V17.16B
    ADDHN  V9.2S, V27.2D, V17.2D
    ADDP  V8.8B, V30.8B, V17.8B
    ADD  D12, D23, D1
    ADD  V26.8H, V11.8H, V14.8H
    ADD  V1.16B, V25.16B, V21.16B
    ADDP  V30.4S, V7.4S, V1.4S
    ADDHN2  V1.4S, V17.2D, V12.2D
    ADD  D6, D28, D20
    ADDHN  V28.8B, V1.8H, V26.8H
    ADDP  D22, V22.2D
    ADDHN2  V26.4S, V11.2D, V0.2D
    ADDP  V25.4H, V26.4H, V29.4H
    ADDHN2  V6.4S, V1.2D, V2.2D
    ADDHN  V23.2S, V27.2D, V2.2D
    ADD  V19.8H, V13.8H, V23.8H
    ADDP  D30, V18.2D
    ADDV  S22, V17.4S
    ADDP  V6.16B, V24.16B, V29.16B
    ADDP  V15.8B, V6.8B, V8.8B
    ADDV  S27, V24.4S
    ADDHN  V17.8B, V22.8H, V12.8H
    ADDV  B26, V13.8B
    ADDHN  V1.4H, V12.4S, V23.4S
    ADDV  H31, V20.4H
    ADDV  S9, V10.4S
    ADDHN2  V30.16B, V9.8H, V17.8H
    ADDHN  V12.4H, V12.4S, V27.4S
    ADDP  D20, V13.2D
    ADDHN2  V10.8H, V4.4S, V17.4S
    ADDV  S29, V18.4S
    ADDV  S19, V15.4S
    ADDV  B5, V22.16B
    ADDHN  V31.8B, V10.8H, V25.8H
    ADDP  V20.16B, V16.16B, V17.16B
    ADD  D21, D30, D8
    ADDV  B6, V28.16B
    ADDP  D26, V19.2D
    ADD  D20, D29, D16
    ADD  D11, D30, D24
    ADDP  D17, V19.2D
    ADD  V28.8B, V9.8B, V25.8B
    ADD  D15, D5, D4
    ADD  V15.8H, V31.8H, V17.8H
    ADDP  V23.8H, V30.8H, V11.8H
    ADDHN2  V8.8H, V2.4S, V14.4S
    ADDHN  V16.8B, V18.8H, V1.8H
    ADDHN2  V11.4S, V11.2D, V2.2D
    ADDP  D19, V29.2D
    ADDV  S31, V13.4S
    ADDV  B23, V14.8B
    ADDHN2  V19.16B, V12.8H, V16.8H
    ADDV  S8, V1.4S
    ADD  D1, D25, D16
    ADDP  V29.2S, V16.2S, V11.2S
    ADDV  H21, V15.4H
    ADDV  B29, V20.8B
    ADD  D8, D5, D22
    ADD  V16.8H, V19.8H, V15.8H
    ADDV  S1, V25.4S
    ADDV  S31, V1.4S
    ADDV  B11, V27.16B
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdImmP01_label_632
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X5, X20, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X10, X22, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X13, X15, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X8, X12, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X29, X26, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X2, X9, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X21, X15, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X11, X3, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X24, X26, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X24, D2
    MOVZ  X20, #0x12, LSL #0
    SUB  X10, X20, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X11, D3
    MOVZ  X4, #0x1bc6, LSL #0
    SUB  X2, X4, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X8, D4
    MOVZ  X29, #0x2, LSL #0
    SUB  X27, X29, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X6, D5
    MOVZ  X25, #0x34, LSL #0
    SUB  X7, X25, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X21, D6
    MOVZ  X22, #0x37, LSL #0
    SUB  X27, X22, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X29, D7
    MOVZ  X21, #0x1b99, LSL #0
    MOVK  X21, #0x2d, LSL #32
    SUB  X15, X21, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X3, D8
    MOVZ  X19, #0x68, LSL #0
    SUB  X4, X19, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X24, D9
    MOVZ  X14, #0x105, LSL #0
    MOVK  X14, #0x11, LSL #16
    SUB  X12, X14, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X15, D10
    MOVZ  X11, #0x105, LSL #0
    MOVK  X11, #0x11, LSL #16
    SUB  X29, X11, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X4, D11
    MOVZ  X17, #0x32, LSL #0
    SUB  X15, X17, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X8, D12
    MOVZ  X28, #0x11, LSL #0
    SUB  X14, X28, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X6, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X7, #0x14, LSL #0
    SUB  X5, X7, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X27, D14
    MOVZ  X7, #0x1a3e, LSL #0
    SUB  X5, X7, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X14, D15
    MOVZ  X12, #0x72, LSL #0
    MOVK  X12, #0x34, LSL #16
    SUB  X3, X12, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X24, D16
    MOVZ  X29, #0x1ab0, LSL #0
    MOVK  X29, #0x34, LSL #16
    SUB  X7, X29, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X14, D17
    MOVZ  X20, #0x56, LSL #0
    MOVK  X20, #0x34, LSL #16
    SUB  X9, X20, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X19, D18
    MOVZ  X10, #0x1a3e, LSL #0
    SUB  X8, X10, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X29, D19
    MOVZ  X24, #0x1a3e, LSL #0
    SUB  X22, X24, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X29, D20
    MOVZ  X2, #0x1b64, LSL #0
    SUB  X16, X2, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X13, D21
    MOVZ  X11, #0xa6, LSL #0
    SUB  X8, X11, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X20, D22
    MOVZ  X19, #0x34, LSL #0
    SUB  X12, X19, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X10, D24
    MOVZ  X7, #0x32, LSL #0
    SUB  X8, X7, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X3, D25
    MOVZ  X8, #0x1b86, LSL #0
    MOVK  X8, #0x30, LSL #32
    SUB  X7, X8, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X6, D26
    MOVZ  X15, #0x56, LSL #0
    MOVK  X15, #0x34, LSL #16
    SUB  X24, X15, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X3, D27
    MOVZ  X11, #0x32, LSL #0
    SUB  X29, X11, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X18, D28
    MOVZ  X8, #0x1c8b, LSL #0
    MOVK  X8, #0x11, LSL #16
    MOVK  X8, #0x30, LSL #32
    SUB  X6, X8, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X4, D29
    MOVZ  X8, #0x7f, LSL #0
    SUB  X16, X8, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x4a92, LSL #0
    MOVK  X2, #0xe26b, LSL #16
    MOVK  X2, #0x66f, LSL #32
    MOVK  X2, #0x8e1f, LSL #48
    MOVZ  X3, #0x7c79, LSL #0
    MOVK  X3, #0x9b28, LSL #16
    MOVK  X3, #0x7636, LSL #32
    MOVK  X3, #0x299b, LSL #48
    MOVZ  X4, #0xbecc, LSL #0
    MOVK  X4, #0x76e1, LSL #16
    MOVK  X4, #0xc501, LSL #32
    MOVK  X4, #0x409e, LSL #48
    MOVZ  X5, #0x58db, LSL #0
    MOVK  X5, #0x241b, LSL #16
    MOVK  X5, #0x30d, LSL #32
    MOVK  X5, #0xdbbc, LSL #48
    MOVZ  X6, #0x2063, LSL #0
    MOVK  X6, #0xc40d, LSL #16
    MOVK  X6, #0xb180, LSL #32
    MOVK  X6, #0x3f8c, LSL #48
    MOVZ  X7, #0x1ed5, LSL #0
    MOVK  X7, #0xf0, LSL #16
    MOVK  X7, #0xd934, LSL #32
    MOVK  X7, #0xae40, LSL #48
    MOVZ  X8, #0x7d30, LSL #0
    MOVK  X8, #0xa329, LSL #16
    MOVK  X8, #0xc8f6, LSL #32
    MOVK  X8, #0x135b, LSL #48
    MOVZ  X9, #0x774f, LSL #0
    MOVK  X9, #0x4e74, LSL #16
    MOVK  X9, #0x908e, LSL #32
    MOVK  X9, #0x8f92, LSL #48
    MOVZ  X10, #0xb645, LSL #0
    MOVK  X10, #0x199c, LSL #16
    MOVK  X10, #0x6cc4, LSL #32
    MOVK  X10, #0x51f3, LSL #48
    MOVZ  X11, #0x80bb, LSL #0
    MOVK  X11, #0xbb5, LSL #16
    MOVK  X11, #0x482c, LSL #32
    MOVK  X11, #0x6786, LSL #48
    MOVZ  X12, #0xa65f, LSL #0
    MOVK  X12, #0x34d3, LSL #16
    MOVK  X12, #0x4665, LSL #32
    MOVK  X12, #0x42f1, LSL #48
TaishanSimdImmP01_label_276:
    MOVZ  X13, #0xf3a9, LSL #0
    MOVK  X13, #0x2ba5, LSL #16
    MOVK  X13, #0x74f3, LSL #32
    MOVK  X13, #0x714d, LSL #48
    MOVZ  X14, #0xc0ac, LSL #0
    MOVK  X14, #0x4a43, LSL #16
    MOVK  X14, #0x4ceb, LSL #32
    MOVK  X14, #0x59f7, LSL #48
    MOVZ  X15, #0xf33e, LSL #0
    MOVK  X15, #0x4c89, LSL #16
    MOVK  X15, #0x1e48, LSL #32
    MOVK  X15, #0x9487, LSL #48
    MOVZ  X16, #0xfafb, LSL #0
    MOVK  X16, #0x76b, LSL #16
    MOVK  X16, #0xd25e, LSL #32
    MOVK  X16, #0x3dc2, LSL #48
    MOVZ  X17, #0xc6c, LSL #0
    MOVK  X17, #0x26f6, LSL #16
    MOVK  X17, #0x5599, LSL #32
    MOVK  X17, #0xbf84, LSL #48
    MOVZ  X18, #0xda2a, LSL #0
    MOVK  X18, #0x1665, LSL #16
    MOVK  X18, #0xbb5, LSL #32
    MOVK  X18, #0xac54, LSL #48
    MOVZ  X19, #0x9ca7, LSL #0
    MOVK  X19, #0x2dcd, LSL #16
    MOVK  X19, #0x8a9b, LSL #32
    MOVK  X19, #0x9318, LSL #48
    MOVZ  X20, #0x93e4, LSL #0
    MOVK  X20, #0xc63d, LSL #16
    MOVK  X20, #0x22e8, LSL #32
    MOVK  X20, #0x8e33, LSL #48
    MOVZ  X21, #0x3bad, LSL #0
    MOVK  X21, #0x807a, LSL #16
    MOVK  X21, #0x79a4, LSL #32
    MOVK  X21, #0xcb4d, LSL #48
    MOVZ  X22, #0x9498, LSL #0
    MOVK  X22, #0x5616, LSL #16
    MOVK  X22, #0xe6fd, LSL #32
    MOVK  X22, #0xf49e, LSL #48
    MOVZ  X24, #0x141, LSL #0
    MOVK  X24, #0xc48e, LSL #16
    MOVK  X24, #0x3642, LSL #32
    MOVK  X24, #0x7d8a, LSL #48
    MOVZ  X25, #0xd5c1, LSL #0
    MOVK  X25, #0x2afd, LSL #16
    MOVK  X25, #0x52ef, LSL #32
    MOVK  X25, #0x4c9b, LSL #48
    MOVZ  X26, #0x1b00, LSL #0
    MOVK  X26, #0x154, LSL #16
    MOVK  X26, #0xab64, LSL #32
    MOVK  X26, #0x6e60, LSL #48
    MOVZ  X27, #0xadd8, LSL #0
    MOVK  X27, #0x4ab9, LSL #16
    MOVK  X27, #0x3686, LSL #32
    MOVK  X27, #0x213, LSL #48
    MOVZ  X28, #0xeefd, LSL #0
    MOVK  X28, #0xe3f9, LSL #16
    MOVK  X28, #0x3b7b, LSL #32
    MOVK  X28, #0x9d21, LSL #48
    MOVZ  X29, #0xd2e2, LSL #0
    MOVK  X29, #0xa2d1, LSL #16
    MOVK  X29, #0x53e5, LSL #32
    MOVK  X29, #0x9d56, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X13
    FMOV  D2, X29
    FMOV  V2.D[1], X13
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X19
    FMOV  V4.D[1], X9
    FMOV  D5, X27
    FMOV  V5.D[1], X26
    FMOV  D6, X21
    FMOV  V6.D[1], X5
    FMOV  D7, X10
    FMOV  V7.D[1], X27
    FMOV  D8, X25
    FMOV  V8.D[1], X8
    FMOV  D9, X28
    FMOV  V9.D[1], X28
    FMOV  D10, X9
    FMOV  V10.D[1], X8
    FMOV  D11, X22
    FMOV  V11.D[1], X7
    FMOV  D12, X4
    FMOV  V12.D[1], X27
    FMOV  D13, X16
    FMOV  V13.D[1], X7
    FMOV  D14, X21
    FMOV  V14.D[1], X13
    FMOV  D15, X7
    FMOV  V15.D[1], X4
    FMOV  D16, X22
    FMOV  V16.D[1], X25
    FMOV  D17, X8
    FMOV  V17.D[1], X16
    FMOV  D18, X25
    FMOV  V18.D[1], X25
    FMOV  D19, X16
    FMOV  V19.D[1], X7
    FMOV  D20, X16
    FMOV  V20.D[1], X27
    FMOV  D21, X26
    FMOV  V21.D[1], X5
    FMOV  D22, X3
    FMOV  V22.D[1], X16
    FMOV  D23, X5
    FMOV  V23.D[1], X22
    FMOV  D24, X8
    FMOV  V24.D[1], X25
    FMOV  D25, X7
    FMOV  V25.D[1], X13
    FMOV  D26, X4
    FMOV  V26.D[1], X8
    FMOV  D27, X2
    FMOV  V27.D[1], X28
    FMOV  D28, X5
    FMOV  V28.D[1], X12
    FMOV  D29, X15
    FMOV  V29.D[1], X16
    FMOV  D30, X19
    FMOV  V30.D[1], X18
    FMOV  D31, X3
    FMOV  V31.D[1], X26
    MOVZ  X7, #0xa, LSL #0
TaishanSimdImmP01_label_704:
    ADDV  B22, V0.16B
    ADDHN2  V16.4S, V31.2D, V26.2D
    ADDP  D4, V3.2D
    ADD  V30.8B, V14.8B, V12.8B
    ADDV  S15, V26.4S
    ADD  D18, D17, D10
    ADDP  V15.2D, V29.2D, V7.2D
    ADD  D9, D30, D7
    ADDV  S25, V25.4S
    ADDV  S24, V10.4S
    ADDV  B16, V22.8B
    ADDP  D4, V23.2D
    ADDHN  V6.8B, V17.8H, V22.8H
    ADD  D24, D28, D12
    ADDV  B5, V25.8B
    ADDP  D6, V21.2D
    ADDHN2  V26.16B, V3.8H, V22.8H
    ADDV  S0, V16.4S
    ADDP  V14.16B, V0.16B, V17.16B
    ADDP  D14, V25.2D
    ADDV  H23, V26.4H
    ADDHN2  V20.4S, V18.2D, V1.2D
    ADDP  V18.4H, V29.4H, V7.4H
    ADDV  H11, V31.4H
    ADD  V31.4S, V6.4S, V3.4S
    ADDV  B3, V1.8B
    ADDP  V16.16B, V8.16B, V27.16B
    ADDHN2  V1.8H, V19.4S, V31.4S
    ADDV  H26, V8.8H
    ADDV  B17, V4.8B
    ADD  V11.16B, V1.16B, V7.16B
    ADDHN  V2.4H, V30.4S, V30.4S
    ADD  V2.2D, V15.2D, V0.2D
    ADDHN  V30.4H, V25.4S, V24.4S
    ADDV  S11, V18.4S
    ADDP  V0.16B, V6.16B, V11.16B
    ADDV  S15, V23.4S
    ADD  D24, D1, D23
    ADD  D15, D16, D15
    ADD  V20.4H, V17.4H, V6.4H
    ADDP  V25.2S, V27.2S, V3.2S
    ADDV  B21, V29.16B
    ADD  D5, D7, D6
    ADDHN2  V14.4S, V31.2D, V23.2D
    ADDHN2  V24.4S, V15.2D, V23.2D
    ADDV  H27, V24.8H
    ADDP  D29, V20.2D
    ADDP  V28.8B, V1.8B, V4.8B
    ADDV  S31, V7.4S
    ADD  D2, D19, D26
    ADD  V21.16B, V0.16B, V3.16B
    ADDHN2  V25.8H, V26.4S, V11.4S
    ADDHN2  V15.4S, V5.2D, V18.2D
    ADDV  H2, V17.8H
    ADDP  D25, V12.2D
    ADDP  V8.8H, V24.8H, V10.8H
    ADDHN2  V10.4S, V22.2D, V6.2D
    ADD  V6.8H, V26.8H, V11.8H
    ADD  V7.2S, V21.2S, V29.2S
    ADDV  H0, V14.4H
    ADDHN2  V2.4S, V0.2D, V16.2D
    ADDP  V10.4S, V19.4S, V10.4S
    ADDV  H26, V25.4H
    ADDHN2  V24.16B, V0.8H, V22.8H
    ADDV  B28, V21.8B
    ADDHN  V11.8B, V27.8H, V14.8H
    ADDV  B0, V29.8B
    ADDHN  V8.2S, V24.2D, V4.2D
    ADDHN  V22.2S, V20.2D, V7.2D
    ADD  V31.2D, V10.2D, V6.2D
    ADD  D11, D28, D8
    ADDHN2  V0.4S, V15.2D, V4.2D
    ADDHN  V5.8B, V31.8H, V17.8H
    ADDV  H28, V14.8H
    ADDV  H11, V28.8H
    ADD  V24.8H, V16.8H, V11.8H
    ADDV  S6, V27.4S
    ADDP  V8.2S, V31.2S, V11.2S
    ADDP  D17, V5.2D
    ADDHN  V18.8B, V3.8H, V8.8H
    ADDP  V10.8H, V12.8H, V1.8H
    ADDV  H26, V8.4H
    ADDP  D24, V26.2D
    ADD  V20.2S, V26.2S, V9.2S
    ADD  D20, D28, D15
    ADDP  V29.2S, V4.2S, V4.2S
    ADDV  H31, V6.4H
    ADDHN  V10.2S, V20.2D, V30.2D
    ADDHN2  V15.16B, V24.8H, V0.8H
    ADDHN  V5.4H, V12.4S, V20.4S
    ADDP  V26.8B, V16.8B, V5.8B
    ADDV  H14, V6.8H
    ADD  D25, D3, D23
    ADDHN2  V2.4S, V20.2D, V30.2D
    ADD  D27, D6, D9
    ADDHN  V5.2S, V6.2D, V7.2D
    ADDV  H26, V28.4H
    ADD  V0.2D, V23.2D, V4.2D
    ADD  V13.4S, V14.4S, V26.4S
    ADDHN2  V23.8H, V30.4S, V8.4S
    ADDV  H23, V3.8H
    ADDP  D12, V5.2D
    ADDHN2  V11.16B, V15.8H, V22.8H
    ADDP  D5, V14.2D
    ADDP  D4, V4.2D
    ADDV  H4, V29.4H
    ADD  D8, D26, D4
    ADDP  V16.16B, V25.16B, V0.16B
    ADDP  V17.2D, V18.2D, V1.2D
    ADDHN2  V28.16B, V3.8H, V6.8H
    ADD  V18.4H, V16.4H, V29.4H
    ADDP  D24, V25.2D
    ADDP  D28, V19.2D
    ADDP  D8, V9.2D
    ADD  D25, D29, D6
    ADDV  S5, V5.4S
    ADDP  V15.8B, V7.8B, V16.8B
    ADD  V1.16B, V16.16B, V11.16B
    ADD  D30, D11, D17
    ADD  D30, D23, D8
    ADD  V3.4S, V18.4S, V1.4S
    ADDHN  V12.4H, V15.4S, V24.4S
    ADDHN2  V30.8H, V0.4S, V5.4S
    ADD  V6.2S, V12.2S, V17.2S
    ADDP  V6.8H, V1.8H, V23.8H
    ADD  D28, D23, D20
    ADDP  V0.2D, V1.2D, V28.2D
    ADD  V20.2S, V25.2S, V1.2S
    ADDP  D29, V21.2D
    ADDP  V17.8H, V7.8H, V2.8H
    ADDV  S28, V16.4S
    ADDP  D16, V20.2D
    ADDHN  V16.8B, V16.8H, V16.8H
    ADD  V16.8B, V16.8B, V26.8B
    ADDHN  V9.8B, V5.8H, V5.8H
    ADDV  S0, V16.4S
    ADDP  D12, V4.2D
    ADDV  B28, V2.8B
    ADDV  S18, V21.4S
    ADDV  B31, V7.16B
    ADD  D23, D0, D3
    ADD  V31.2S, V3.2S, V28.2S
    ADD  V8.2S, V22.2S, V22.2S
    ADDV  H2, V8.4H
    ADDP  D27, V14.2D
    ADD  D15, D21, D11
    ADD  V0.8H, V24.8H, V15.8H
    ADDV  H11, V5.8H
    ADDHN  V30.2S, V24.2D, V18.2D
    ADDP  D31, V17.2D
    ADD  D27, D15, D8
    ADDP  D6, V9.2D
    ADD  D5, D0, D24
    ADD  V28.16B, V29.16B, V21.16B
    ADDP  V26.4H, V16.4H, V14.4H
    ADD  D10, D29, D2
    ADDV  S30, V7.4S
    ADDV  H2, V8.4H
    ADDV  S20, V30.4S
    ADDP  D22, V5.2D
    ADDP  V27.8B, V22.8B, V23.8B
    ADDV  S24, V18.4S
    ADD  D11, D27, D28
    ADDP  V27.16B, V9.16B, V9.16B
    ADDP  V10.2D, V17.2D, V16.2D
    ADDV  S17, V24.4S
    ADDP  D2, V19.2D
    ADDHN  V8.2S, V26.2D, V23.2D
    ADDV  B0, V14.16B
    ADDHN2  V24.16B, V17.8H, V27.8H
    ADDV  S19, V17.4S
    ADD  V2.16B, V20.16B, V3.16B
    ADDP  V5.4H, V21.4H, V25.4H
    ADD  D24, D2, D28
    ADDHN  V14.2S, V26.2D, V12.2D
    ADDHN2  V24.16B, V25.8H, V14.8H
    ADDV  H16, V3.8H
    ADDHN2  V31.8H, V26.4S, V31.4S
    ADD  V31.16B, V29.16B, V0.16B
    ADDHN2  V13.4S, V11.2D, V23.2D
    ADDV  H27, V25.8H
    ADD  D1, D6, D0
    ADDHN2  V25.8H, V8.4S, V26.4S
    ADD  D19, D20, D20
    ADD  D5, D10, D1
    ADDV  S26, V14.4S
    ADD  V5.8H, V24.8H, V14.8H
    ADDV  B2, V0.8B
    ADDV  S6, V9.4S
    ADDV  B16, V16.8B
    ADDP  V6.4H, V7.4H, V15.4H
    ADDP  D19, V18.2D
    ADDV  B27, V13.8B
    ADDV  B20, V19.16B
    ADDHN  V6.4H, V20.4S, V17.4S
    ADDV  S7, V26.4S
    ADDP  D1, V21.2D
    ADDHN2  V29.4S, V2.2D, V17.2D
    ADD  V0.4S, V0.4S, V20.4S
    ADDP  D28, V29.2D
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdImmP01_label_704
    MOVZ  X18, #0x4a92, LSL #0
    MOVK  X18, #0xe26b, LSL #16
    MOVK  X18, #0x66f, LSL #32
    MOVK  X18, #0x8e1f, LSL #48
    SUB  X3, X18, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xbecc, LSL #0
    MOVK  X7, #0x76e1, LSL #16
    MOVK  X7, #0xc501, LSL #32
    MOVK  X7, #0x409e, LSL #48
    SUB  X8, X7, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x58db, LSL #0
    MOVK  X28, #0x241b, LSL #16
    MOVK  X28, #0x30d, LSL #32
    MOVK  X28, #0xdbbc, LSL #48
    SUB  X18, X28, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x2063, LSL #0
    MOVK  X13, #0xc40d, LSL #16
    MOVK  X13, #0xb180, LSL #32
    MOVK  X13, #0x3f8c, LSL #48
    SUB  X5, X13, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0xbecc, LSL #0
    MOVK  X11, #0x76e1, LSL #16
    MOVK  X11, #0xc501, LSL #32
    MOVK  X11, #0x409e, LSL #48
    SUB  X15, X11, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x774f, LSL #0
    MOVK  X3, #0x4e74, LSL #16
    MOVK  X3, #0x908e, LSL #32
    MOVK  X3, #0x8f92, LSL #48
    SUB  X5, X3, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xb645, LSL #0
    MOVK  X21, #0x199c, LSL #16
    MOVK  X21, #0x6cc4, LSL #32
    MOVK  X21, #0x51f3, LSL #48
    SUB  X6, X21, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0xbecc, LSL #0
    MOVK  X11, #0x76e1, LSL #16
    MOVK  X11, #0xc501, LSL #32
    MOVK  X11, #0x409e, LSL #48
    SUB  X27, X11, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xa65f, LSL #0
    MOVK  X21, #0x34d3, LSL #16
    MOVK  X21, #0x4665, LSL #32
    MOVK  X21, #0x42f1, LSL #48
    SUB  X8, X21, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x2063, LSL #0
    MOVK  X4, #0xc40d, LSL #16
    MOVK  X4, #0xb180, LSL #32
    MOVK  X4, #0x3f8c, LSL #48
    SUB  X16, X4, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0xc0ac, LSL #0
    MOVK  X3, #0x4a43, LSL #16
    MOVK  X3, #0x4ceb, LSL #32
    MOVK  X3, #0x59f7, LSL #48
    SUB  X15, X3, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xa65f, LSL #0
    MOVK  X2, #0x34d3, LSL #16
    MOVK  X2, #0x4665, LSL #32
    MOVK  X2, #0x42f1, LSL #48
    SUB  X12, X2, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x9498, LSL #0
    MOVK  X29, #0x5616, LSL #16
    MOVK  X29, #0xe6fd, LSL #32
    MOVK  X29, #0xf49e, LSL #48
    SUB  X21, X29, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x141, LSL #0
    MOVK  X20, #0xc48e, LSL #16
    MOVK  X20, #0x3642, LSL #32
    MOVK  X20, #0x7d8a, LSL #48
    SUB  X15, X20, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x58db, LSL #0
    MOVK  X5, #0x241b, LSL #16
    MOVK  X5, #0x30d, LSL #32
    MOVK  X5, #0xdbbc, LSL #48
    SUB  X28, X5, X28
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x9498, LSL #0
    MOVK  X13, #0x5616, LSL #16
    MOVK  X13, #0xe6fd, LSL #32
    MOVK  X13, #0xf49e, LSL #48
    SUB  X12, X13, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X12, D2
    MOVZ  X22, #0xb5, LSL #0
    SUB  X4, X22, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X11, #0xcbad, LSL #0
    MOVK  X11, #0x5225, LSL #16
    MOVK  X11, #0x35, LSL #48
    SUB  X21, X11, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X4, D3
    MOVZ  X11, #0xb29d, LSL #0
    MOVK  X11, #0xd449, LSL #16
    MOVK  X11, #0x2588, LSL #32
    MOVK  X11, #0xd449, LSL #48
    SUB  X21, X11, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X17, D4
    MOVZ  X28, #0xf3a2, LSL #0
    SUB  X9, X28, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X15, #0xd46b, LSL #0
    MOVK  X15, #0xd425, LSL #16
    SUB  X7, X15, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X6, D5
    MOVZ  X15, #0x57c3, LSL #0
    MOVK  X15, #0xd449, LSL #16
    MOVK  X15, #0x2588, LSL #32
    MOVK  X15, #0xd449, LSL #48
    SUB  X7, X15, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X14, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X21, D7
    MOVZ  X5, #0xa312, LSL #0
    SUB  X3, X5, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X7, D8
    MOVZ  X16, #0xc89b, LSL #0
    MOVK  X16, #0xd449, LSL #16
    SUB  X14, X16, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X16, D9
    MOVZ  X13, #0x46, LSL #0
    SUB  X24, X13, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X18, #0x3454, LSL #0
    MOVK  X18, #0xa84b, LSL #16
    SUB  X7, X18, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X2, D10
    MOVZ  X18, #0x21d, LSL #0
    SUB  X7, X18, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X4, D11
    MOVZ  X25, #0x168, LSL #0
    MOVK  X25, #0x10d7, LSL #32
    MOVK  X25, #0x1dae, LSL #48
    SUB  X21, X25, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X22, D12
    MOVZ  X17, #0xf3a2, LSL #0
    SUB  X24, X17, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X9, #0x3660, LSL #0
    MOVK  X9, #0xf1f7, LSL #16
    SUB  X8, X9, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X4, D13
    MOVZ  X9, #0x2fbd, LSL #0
    MOVK  X9, #0x1, LSL #16
    SUB  X8, X9, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X28, D14
    MOVZ  X12, #0xa312, LSL #0
    SUB  X19, X12, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X16, D15
    MOVZ  X11, #0x8cb1, LSL #0
    SUB  X25, X11, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X11, D16
    MOVZ  X13, #0x5c, LSL #0
    SUB  X22, X13, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X8, D17
    MOVZ  X21, #0xbb, LSL #0
    SUB  X11, X21, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X13, D18
    MOVZ  X15, #0xbb, LSL #0
    SUB  X26, X15, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X3, D19
    MOVZ  X27, #0xbb, LSL #0
    SUB  X14, X27, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X25, D20
    MOVZ  X19, #0xbb, LSL #0
    SUB  X6, X19, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X27, #0xb5, LSL #0
    SUB  X10, X27, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X6, D21
    MOVZ  X27, #0x6, LSL #0
    SUB  X10, X27, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X4, D22
    MOVZ  X27, #0xd2d5, LSL #0
    SUB  X17, X27, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X27, #0xd46b, LSL #0
    MOVK  X27, #0xd425, LSL #16
    SUB  X21, X27, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X12, D24
    MOVZ  X27, #0xb4b1, LSL #0
    MOVK  X27, #0xd449, LSL #16
    MOVK  X27, #0x2588, LSL #32
    MOVK  X27, #0xd449, LSL #48
    SUB  X21, X27, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X10, #0xd44a, LSL #0
    SUB  X24, X10, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X19, D25
    MOVZ  X10, #0xc89a, LSL #0
    MOVK  X10, #0xd449, LSL #16
    MOVK  X10, #0x2588, LSL #32
    MOVK  X10, #0xd449, LSL #48
    SUB  X24, X10, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X17, D26
    MOVZ  X12, #0xa312, LSL #0
    SUB  X20, X12, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X13, D27
    MOVZ  X28, #0xed, LSL #0
    SUB  X20, X28, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X26, D28
    MOVZ  X7, #0xbb, LSL #0
    SUB  X12, X7, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X24, D29
    MOVZ  X12, #0xbb, LSL #0
    SUB  X21, X12, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X15
    FMOV  V0.D[1], X3
    FMOV  D1, X10
    FMOV  V1.D[1], X17
    FMOV  D2, X5
TaishanSimdImmP01_label_71:
    FMOV  V2.D[1], X26
    FMOV  D3, X14
    FMOV  V3.D[1], X27
    FMOV  D4, X22
    FMOV  V4.D[1], X6
    FMOV  D5, X26
    FMOV  V5.D[1], X19
    FMOV  D6, X22
    FMOV  V6.D[1], X7
    FMOV  D7, X12
    FMOV  V7.D[1], X13
    FMOV  D8, X18
    FMOV  V8.D[1], X26
    FMOV  D9, X22
    FMOV  V9.D[1], X17
    FMOV  D10, X22
    FMOV  V10.D[1], X26
    FMOV  D11, X21
    FMOV  V11.D[1], X4
    FMOV  D12, X6
    FMOV  V12.D[1], X4
    FMOV  D13, X7
    FMOV  V13.D[1], X8
    FMOV  D14, X21
    FMOV  V14.D[1], X10
    FMOV  D15, X5
    FMOV  V15.D[1], X21
    FMOV  D16, X12
    FMOV  V16.D[1], X28
    FMOV  D17, X12
    FMOV  V17.D[1], X25
    FMOV  D18, X7
    FMOV  V18.D[1], X2
    FMOV  D19, X5
    FMOV  V19.D[1], X25
    FMOV  D20, X25
    FMOV  V20.D[1], X18
    FMOV  D21, X14
    FMOV  V21.D[1], X21
    FMOV  D22, X21
    FMOV  V22.D[1], X21
    FMOV  D23, X11
    FMOV  V23.D[1], X6
    FMOV  D24, X20
    FMOV  V24.D[1], X27
    FMOV  D25, X4
    FMOV  V25.D[1], X7
    FMOV  D26, X9
    FMOV  V26.D[1], X7
    FMOV  D27, X25
    FMOV  V27.D[1], X27
    FMOV  D28, X7
    FMOV  V28.D[1], X2
    FMOV  D29, X5
    FMOV  V29.D[1], X11
    FMOV  D30, X25
    FMOV  V30.D[1], X15
    FMOV  D31, X24
    FMOV  V31.D[1], X14
    MOVZ  X13, #0xa, LSL #0
TaishanSimdImmP01_label_779:
    ADDV  B5, V19.16B
    ADDP  V25.4S, V6.4S, V10.4S
    ADDHN  V18.4H, V10.4S, V17.4S
    ADDHN  V15.8B, V24.8H, V24.8H
    ADDP  D23, V15.2D
    ADDHN2  V9.16B, V29.8H, V14.8H
    ADDV  B23, V0.16B
    ADDHN  V31.2S, V17.2D, V29.2D
    ADDV  H20, V31.8H
    ADDV  B4, V26.8B
    ADD  V17.16B, V6.16B, V31.16B
    ADDV  H14, V17.4H
    ADDP  D18, V13.2D
    ADDP  V4.8H, V18.8H, V19.8H
    ADDP  V6.4H, V25.4H, V9.4H
    ADDV  B14, V21.8B
    ADDHN  V7.2S, V25.2D, V30.2D
    ADDP  V27.4S, V4.4S, V3.4S
    ADDV  B15, V31.8B
    ADDV  S21, V11.4S
    ADDHN  V5.8B, V26.8H, V28.8H
    ADD  D29, D7, D20
    ADDV  H23, V17.4H
    ADDV  B10, V7.8B
    ADDP  V31.4S, V4.4S, V5.4S
    ADDHN  V30.4H, V20.4S, V12.4S
    ADDP  V18.4H, V2.4H, V30.4H
    ADD  V6.16B, V31.16B, V15.16B
    ADD  D10, D12, D26
    ADDP  V31.16B, V26.16B, V14.16B
    ADDP  V31.8H, V31.8H, V24.8H
    ADDHN2  V18.16B, V11.8H, V4.8H
    ADDV  B31, V25.16B
    ADDV  S11, V26.4S
    ADD  V0.4H, V1.4H, V30.4H
    ADDP  D26, V1.2D
    ADD  D11, D4, D10
    ADDHN  V7.8B, V17.8H, V15.8H
    ADDHN  V7.2S, V17.2D, V7.2D
    ADDP  D5, V28.2D
    ADDP  V30.8B, V31.8B, V12.8B
    ADDV  H7, V10.4H
    ADD  V1.2D, V13.2D, V24.2D
    ADDP  D23, V24.2D
    ADDP  V23.16B, V3.16B, V10.16B
    ADDP  D10, V14.2D
    ADD  V15.8B, V23.8B, V2.8B
    ADD  V4.2D, V25.2D, V1.2D
    ADDV  B16, V29.16B
    ADD  V24.8H, V28.8H, V20.8H
    ADDV  S7, V15.4S
    ADDHN2  V27.8H, V29.4S, V3.4S
    ADDHN2  V18.4S, V0.2D, V18.2D
    ADDV  B19, V30.16B
    ADDHN  V19.2S, V3.2D, V12.2D
    ADDP  V0.8B, V28.8B, V22.8B
    ADDP  V14.8B, V19.8B, V21.8B
    ADDV  H14, V26.4H
    ADD  D29, D10, D10
    ADD  D26, D27, D18
    ADDHN  V20.2S, V4.2D, V18.2D
    ADD  V22.2S, V24.2S, V4.2S
    ADDHN  V9.2S, V7.2D, V17.2D
    ADDV  B30, V3.8B
    ADD  V16.2S, V23.2S, V15.2S
    ADDP  D21, V21.2D
    ADD  V16.16B, V25.16B, V7.16B
    ADDV  S1, V11.4S
    ADDHN  V5.2S, V22.2D, V3.2D
    ADDP  V4.2D, V22.2D, V20.2D
    ADD  D26, D17, D5
    ADD  D7, D3, D18
    ADDV  S16, V13.4S
    ADDV  B2, V16.16B
    ADDHN  V15.8B, V3.8H, V30.8H
    ADDHN  V1.4H, V19.4S, V4.4S
    ADDP  V5.8B, V0.8B, V0.8B
    ADDP  D11, V8.2D
    ADDP  D21, V24.2D
    ADDP  D12, V3.2D
    ADDV  S22, V25.4S
    ADDV  S25, V25.4S
    ADDP  V11.2D, V0.2D, V31.2D
    ADD  V16.4H, V28.4H, V17.4H
    ADDV  B27, V12.8B
    ADDP  D18, V28.2D
    ADDV  S28, V22.4S
    ADD  D28, D14, D5
    ADDP  V25.4S, V19.4S, V19.4S
    ADDP  D4, V19.2D
    ADDHN  V16.2S, V20.2D, V8.2D
    ADDP  V12.16B, V19.16B, V3.16B
    ADDV  H2, V3.4H
    ADDP  D19, V28.2D
    ADDV  S9, V9.4S
    ADDP  D7, V15.2D
    ADDHN  V10.8B, V17.8H, V17.8H
    ADDP  V12.8H, V10.8H, V10.8H
    ADDHN2  V3.4S, V5.2D, V12.2D
    ADDHN  V17.8B, V31.8H, V0.8H
    ADDV  S2, V11.4S
    ADDV  S14, V9.4S
    ADDP  V26.4H, V8.4H, V30.4H
    ADDHN2  V14.4S, V10.2D, V23.2D
    ADDV  S19, V23.4S
    ADDHN2  V24.8H, V24.4S, V11.4S
    ADD  V6.2S, V21.2S, V9.2S
    ADDP  D3, V28.2D
    ADDV  B12, V23.8B
    ADDV  H2, V28.4H
    ADDV  S24, V8.4S
    ADD  D12, D26, D10
    ADDHN2  V10.16B, V11.8H, V15.8H
    ADDHN2  V18.4S, V4.2D, V19.2D
    ADDV  B5, V21.8B
    ADD  V12.8B, V3.8B, V0.8B
    ADDP  D14, V17.2D
    ADDP  V9.8B, V9.8B, V17.8B
    ADDV  H2, V7.4H
    ADD  V10.4S, V8.4S, V23.4S
TaishanSimdImmP01_label_357:
    ADDHN2  V7.16B, V15.8H, V25.8H
    ADDV  S9, V24.4S
    ADD  D18, D25, D21
    ADD  V11.4H, V31.4H, V0.4H
    ADD  D17, D4, D2
    ADD  D6, D12, D6
    ADD  D3, D2, D6
    ADDP  D6, V7.2D
    ADD  V18.8H, V22.8H, V0.8H
    ADDV  S10, V10.4S
    ADD  V15.8B, V5.8B, V29.8B
    ADDP  D10, V6.2D
    ADDP  V1.8H, V7.8H, V18.8H
    ADDP  D22, V1.2D
    ADDV  S14, V14.4S
    ADDP  D14, V4.2D
    ADD  V29.2S, V15.2S, V31.2S
    ADDP  V8.8H, V14.8H, V10.8H
    ADDHN2  V27.16B, V18.8H, V24.8H
    ADD  D11, D11, D9
    ADDHN  V21.2S, V28.2D, V21.2D
    ADDHN2  V9.8H, V19.4S, V9.4S
    ADDV  H31, V2.4H
    ADD  V0.4S, V23.4S, V14.4S
    ADDV  H27, V31.4H
    ADDHN2  V29.8H, V8.4S, V9.4S
    ADDP  D23, V28.2D
    ADDV  B29, V28.8B
    ADDHN2  V11.8H, V22.4S, V15.4S
    ADDV  S7, V21.4S
    ADDHN2  V28.16B, V27.8H, V0.8H
    ADDP  D23, V29.2D
    ADDV  H2, V15.4H
    ADDP  V2.16B, V25.16B, V11.16B
    ADDHN  V11.8B, V30.8H, V11.8H
    ADDP  D23, V26.2D
    ADDV  H13, V11.4H
    ADDV  B30, V16.8B
    ADDV  H15, V13.4H
    ADDHN  V30.2S, V7.2D, V25.2D
    ADD  V11.2D, V19.2D, V1.2D
    ADDHN  V7.4H, V0.4S, V13.4S
    ADDHN2  V7.8H, V10.4S, V7.4S
    ADDV  H29, V14.4H
    ADD  D30, D21, D28
    ADDHN  V27.4H, V4.4S, V28.4S
    ADDV  B28, V4.8B
    ADDHN  V15.8B, V0.8H, V26.8H
    ADDHN  V2.8B, V23.8H, V16.8H
    ADDV  S25, V22.4S
    ADDV  S15, V4.4S
    ADDV  H25, V24.4H
    ADDV  H11, V2.4H
    ADDV  S15, V4.4S
    ADDHN  V13.2S, V7.2D, V4.2D
    ADDHN  V21.4H, V29.4S, V7.4S
    ADDHN2  V13.16B, V9.8H, V2.8H
    ADDV  S6, V11.4S
    ADDP  D10, V0.2D
    ADDV  H15, V6.8H
    ADDP  V17.4S, V19.4S, V21.4S
    ADDHN  V8.2S, V31.2D, V21.2D
    ADDP  D3, V31.2D
    ADDV  H8, V29.8H
    ADD  D6, D3, D19
    ADDHN2  V5.16B, V28.8H, V28.8H
    ADDHN2  V13.8H, V6.4S, V2.4S
    ADDHN  V14.8B, V6.8H, V10.8H
    ADD  V0.4S, V6.4S, V18.4S
    ADDV  S2, V14.4S
    ADD  V10.2D, V10.2D, V7.2D
    ADDV  B10, V29.16B
    ADDP  D26, V2.2D
    ADDP  D1, V20.2D
    ADDV  H1, V0.8H
    ADD  D25, D11, D14
    ADDP  V4.2D, V7.2D, V28.2D
    ADDV  H15, V18.8H
    ADDV  S13, V18.4S
    ADDV  H8, V29.4H
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdImmP01_label_779
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X5, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X18, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X14, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X12, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X13, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X27, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X27, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X7, D9
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X29, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X2, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X20, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X7, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X24, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X6, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X11, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X11, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X22, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X15, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X27, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X13, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X15, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X11, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X27, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X18, D26
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X5, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X3, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X13, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
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
TaishanSimdImmP01_label_404:
    MOVK  X20, #0xffff, LSL #48
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
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
    FMOV  D0, X10
    FMOV  V0.D[1], X28
    FMOV  D1, X16
    FMOV  V1.D[1], X6
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X11
    FMOV  V3.D[1], X3
    FMOV  D4, X14
    FMOV  V4.D[1], X8
    FMOV  D5, X17
    FMOV  V5.D[1], X26
    FMOV  D6, X9
    FMOV  V6.D[1], X27
    FMOV  D7, X29
    FMOV  V7.D[1], X16
    FMOV  D8, X11
    FMOV  V8.D[1], X27
    FMOV  D9, X16
    FMOV  V9.D[1], X29
    FMOV  D10, X16
    FMOV  V10.D[1], X14
    FMOV  D11, X3
    FMOV  V11.D[1], X11
    FMOV  D12, X27
    FMOV  V12.D[1], X8
    FMOV  D13, X19
    FMOV  V13.D[1], X14
    FMOV  D14, X19
    FMOV  V14.D[1], X11
    FMOV  D15, X28
    FMOV  V15.D[1], X21
    FMOV  D16, X25
    FMOV  V16.D[1], X26
    FMOV  D17, X2
    FMOV  V17.D[1], X4
    FMOV  D18, X20
    FMOV  V18.D[1], X5
    FMOV  D19, X20
    FMOV  V19.D[1], X24
    FMOV  D20, X26
    FMOV  V20.D[1], X24
    FMOV  D21, X22
    FMOV  V21.D[1], X3
    FMOV  D22, X16
    FMOV  V22.D[1], X7
    FMOV  D23, X25
    FMOV  V23.D[1], X11
    FMOV  D24, X20
    FMOV  V24.D[1], X4
    FMOV  D25, X17
    FMOV  V25.D[1], X28
    FMOV  D26, X11
    FMOV  V26.D[1], X19
    FMOV  D27, X18
    FMOV  V27.D[1], X19
    FMOV  D28, X24
    FMOV  V28.D[1], X20
    FMOV  D29, X3
    FMOV  V29.D[1], X18
    FMOV  D30, X5
    FMOV  V30.D[1], X3
    FMOV  D31, X3
    FMOV  V31.D[1], X12
    MOVZ  X4, #0xf, LSL #0
TaishanSimdImmP01_label_851:
    ADDHN  V31.4H, V26.4S, V28.4S
    ADDV  H23, V20.4H
    ADDP  V31.8H, V5.8H, V9.8H
    ADD  D25, D21, D29
    ADDP  V11.4S, V27.4S, V29.4S
    ADDHN2  V1.4S, V6.2D, V23.2D
    ADD  V1.2S, V5.2S, V11.2S
    ADD  V13.8H, V31.8H, V9.8H
    ADDV  B7, V7.8B
    ADD  D24, D5, D19
    ADDV  S17, V4.4S
    ADD  V10.2S, V18.2S, V14.2S
    ADDHN  V9.2S, V2.2D, V26.2D
    ADDV  H1, V4.4H
    ADD  V26.8H, V18.8H, V19.8H
    ADDP  V29.16B, V16.16B, V13.16B
    ADDV  H13, V1.8H
    ADD  V28.8B, V8.8B, V31.8B
    ADD  D5, D25, D10
    ADDP  V25.8B, V24.8B, V18.8B
    ADDP  D29, V31.2D
    ADDV  S2, V20.4S
    ADDP  V20.16B, V26.16B, V15.16B
    ADDV  H8, V11.8H
    ADDV  B7, V5.16B
    ADDP  V28.16B, V1.16B, V27.16B
    ADDV  S12, V7.4S
    ADDHN  V25.8B, V17.8H, V10.8H
    ADDHN  V13.8B, V27.8H, V11.8H
    ADDV  H2, V13.8H
    ADDV  S30, V29.4S
    ADDP  D16, V20.2D
    ADD  D0, D19, D13
    ADD  V10.8H, V19.8H, V27.8H
    ADDV  B31, V4.16B
    ADD  D2, D2, D31
    ADD  V0.2D, V25.2D, V2.2D
    ADDV  S24, V8.4S
    ADDV  H31, V24.8H
    ADDV  S16, V5.4S
    ADDV  S1, V10.4S
    ADDHN  V11.8B, V24.8H, V26.8H
    ADDHN2  V31.4S, V20.2D, V30.2D
    ADD  V6.4H, V29.4H, V12.4H
    ADDHN2  V0.16B, V23.8H, V22.8H
    ADDV  S11, V15.4S
    ADDP  D20, V30.2D
    ADD  D8, D27, D20
    ADDV  B27, V14.8B
    ADD  V17.2D, V18.2D, V12.2D
    ADD  D31, D4, D24
    ADDHN  V23.4H, V26.4S, V1.4S
    ADDV  S17, V24.4S
    ADDP  V31.16B, V9.16B, V10.16B
    ADDHN  V3.8B, V4.8H, V28.8H
    ADD  V10.2S, V7.2S, V29.2S
    ADDV  H1, V3.4H
    ADDV  H2, V16.4H
    ADDP  D20, V22.2D
    ADD  V30.2S, V0.2S, V18.2S
    ADD  D2, D6, D25
    ADDV  B31, V6.16B
    ADDV  S9, V11.4S
    ADDP  D26, V4.2D
    ADD  V1.16B, V13.16B, V2.16B
    ADDV  H17, V15.4H
    ADDP  D9, V17.2D
    ADDP  V26.16B, V27.16B, V26.16B
    ADDV  B15, V12.8B
    ADD  D11, D14, D31
    ADD  D8, D2, D1
    ADDP  V20.8B, V2.8B, V20.8B
    ADDP  V20.2D, V30.2D, V23.2D
    ADDHN2  V20.16B, V23.8H, V13.8H
    ADD  D27, D24, D11
    ADDHN  V1.8B, V28.8H, V7.8H
    ADDHN  V1.4H, V4.4S, V23.4S
    ADDP  V8.8H, V6.8H, V13.8H
    ADDHN2  V2.8H, V11.4S, V9.4S
    ADDHN2  V9.8H, V10.4S, V6.4S
    ADD  D10, D8, D19
    ADD  D3, D21, D7
    ADDHN2  V12.8H, V2.4S, V1.4S
    ADDP  V18.4S, V17.4S, V24.4S
    ADDV  B20, V20.16B
    ADDHN  V5.2S, V31.2D, V30.2D
    ADDV  H30, V3.4H
    ADDP  D20, V11.2D
    ADDP  D27, V1.2D
    ADDHN2  V21.16B, V18.8H, V12.8H
    ADDHN2  V26.4S, V7.2D, V24.2D
    ADDV  S1, V18.4S
    ADDV  H19, V21.8H
    ADD  V4.2S, V28.2S, V31.2S
    ADDP  V31.2D, V21.2D, V4.2D
    ADDP  V5.8H, V0.8H, V15.8H
    ADD  V0.8H, V31.8H, V22.8H
    ADDP  V15.2S, V27.2S, V19.2S
    ADDP  V19.16B, V3.16B, V15.16B
    ADDP  V1.8B, V2.8B, V1.8B
    ADDV  S2, V0.4S
    ADDP  D28, V20.2D
    ADDHN  V21.4H, V31.4S, V11.4S
    ADD  D11, D17, D19
    ADDV  H6, V2.8H
    ADDP  V27.8B, V18.8B, V18.8B
    ADDP  D5, V6.2D
    ADDV  H26, V3.8H
    ADDHN2  V18.8H, V20.4S, V20.4S
    ADDV  H18, V20.8H
    ADDV  S26, V13.4S
    ADDV  S30, V15.4S
    ADD  D4, D17, D17
    ADDP  D3, V7.2D
    ADDHN2  V22.8H, V3.4S, V26.4S
    ADDHN  V9.4H, V21.4S, V31.4S
    ADD  D8, D29, D1
    ADDV  S9, V16.4S
    ADDP  V30.8B, V18.8B, V20.8B
    ADDHN  V27.2S, V16.2D, V30.2D
    ADDV  B2, V11.8B
    ADDP  D22, V4.2D
    ADDP  V23.8B, V14.8B, V21.8B
    ADDV  B9, V12.8B
    ADDV  S21, V24.4S
    ADDV  H5, V8.4H
    ADD  V2.16B, V12.16B, V23.16B
    ADDHN2  V8.16B, V22.8H, V28.8H
    ADDV  B11, V27.8B
    ADDV  B4, V31.16B
    ADDP  V23.8H, V20.8H, V7.8H
    ADDHN2  V3.16B, V22.8H, V29.8H
    ADDHN  V2.4H, V15.4S, V3.4S
    ADDP  V1.2S, V23.2S, V7.2S
    ADDV  B4, V10.8B
    ADDV  H2, V16.4H
    ADD  V18.8B, V13.8B, V14.8B
    ADD  D29, D5, D24
    ADD  D11, D22, D22
    ADDV  H14, V27.4H
    ADDHN2  V13.4S, V13.2D, V2.2D
    ADDV  H3, V30.8H
    ADD  V3.4H, V2.4H, V18.4H
    ADDHN2  V30.16B, V16.8H, V4.8H
    ADDV  S15, V13.4S
    ADDV  S0, V20.4S
    ADDV  B13, V0.8B
    ADDHN  V30.8B, V4.8H, V16.8H
    ADDV  S31, V8.4S
    ADDHN2  V23.8H, V30.4S, V23.4S
    ADDHN2  V29.8H, V12.4S, V11.4S
    ADDV  B14, V24.16B
    ADD  D28, D18, D19
    ADD  V25.8H, V6.8H, V22.8H
    ADDV  B6, V14.16B
    ADDV  H18, V24.4H
    ADDV  S5, V13.4S
    ADDP  V18.4S, V28.4S, V30.4S
    ADDP  D27, V20.2D
    ADD  D16, D31, D6
    ADD  V30.4H, V1.4H, V8.4H
    ADDV  H7, V18.4H
    ADD  D6, D5, D16
    ADDV  H1, V28.4H
    ADDHN  V7.2S, V21.2D, V1.2D
    ADD  D25, D25, D29
    ADDHN2  V27.16B, V17.8H, V7.8H
    ADDP  D6, V26.2D
    ADD  V30.8B, V4.8B, V7.8B
    ADDHN2  V2.8H, V19.4S, V10.4S
    ADDV  S23, V16.4S
    ADDP  V14.16B, V23.16B, V28.16B
    ADDHN2  V22.4S, V19.2D, V16.2D
    ADDP  D10, V11.2D
    ADDHN2  V25.16B, V10.8H, V8.8H
    ADDP  V5.4H, V17.4H, V17.4H
    ADDV  H8, V13.4H
    ADD  V6.4S, V28.4S, V10.4S
    ADD  D12, D21, D31
    ADDV  B30, V17.8B
    ADDP  V31.8B, V29.8B, V16.8B
    ADDHN2  V18.16B, V14.8H, V10.8H
    ADDV  S30, V23.4S
    ADD  V25.8H, V10.8H, V6.8H
    ADDP  V25.8B, V25.8B, V2.8B
    ADDP  D3, V19.2D
    ADDV  B21, V13.8B
    ADDV  H29, V13.4H
    ADDP  V12.2D, V23.2D, V18.2D
    ADDHN  V4.4H, V10.4S, V19.4S
    ADDV  S8, V8.4S
    ADD  D20, D18, D17
    ADDP  D24, V8.2D
    ADDV  B3, V31.8B
    ADDV  B16, V20.8B
    ADDHN2  V22.16B, V17.8H, V27.8H
    ADDV  B2, V3.16B
    ADDP  D20, V26.2D
    ADDP  V5.4H, V10.4H, V27.4H
    ADDP  V24.2D, V23.2D, V15.2D
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdImmP01_label_851
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X4, X11, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X26, X10, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X14, X27, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X27, X20, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X15, X19, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X3, X15, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X7, X10, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X29, X13, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X10, X2, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X2, X5, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X19, X5, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
TaishanSimdImmP01_label_327:
    MOVZ  X3, #0x0, LSL #0
TaishanSimdImmP01_label_411:
    SUB  X16, X3, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X11, D2
    MOVZ  X4, #0x13, LSL #0
    SUB  X7, X4, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X5, D3
    MOVZ  X21, #0x13, LSL #0
    SUB  X13, X21, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X18, D4
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xdc, LSL #32
    SUB  X5, X14, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X27, D5
    MOVZ  X9, #0x64, LSL #0
    MOVK  X9, #0x304b, LSL #32
    SUB  X13, X9, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X4, D6
    MOVZ  X26, #0x3089, LSL #0
    SUB  X14, X26, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X12, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X26, D8
    MOVZ  X21, #0x7b, LSL #0
    SUB  X14, X21, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X3, D9
    MOVZ  X25, #0x37, LSL #0
    SUB  X4, X25, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X8, D10
    MOVZ  X22, #0x64, LSL #0
    SUB  X5, X22, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X25, D11
    MOVZ  X8, #0x64, LSL #0
    SUB  X10, X8, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X16, #0x30ff, LSL #0
    SUB  X13, X16, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X18, D12
    MOVZ  X16, #0xdf68, LSL #0
    MOVK  X16, #0xda, LSL #16
    SUB  X13, X16, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X2, D13
    MOVZ  X22, #0x7b, LSL #0
    SUB  X21, X22, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X24, #0x55, LSL #0
    SUB  X28, X24, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X10, D14
    MOVZ  X24, #0xda47, LSL #0
    SUB  X28, X24, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X18, D15
    MOVZ  X3, #0x1, LSL #0
    SUB  X19, X3, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X12, D16
    MOVZ  X15, #0x6e, LSL #0
    SUB  X3, X15, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X6, D17
    MOVZ  X18, #0x19, LSL #0
    SUB  X27, X18, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X21, #0xda, LSL #0
    SUB  X16, X21, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X27, D18
    MOVZ  X21, #0x3025, LSL #0
    SUB  X16, X21, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xdc, LSL #16
    SUB  X12, X14, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X27, D19
    MOVZ  X14, #0x12, LSL #0
    SUB  X12, X14, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X16, D20
    MOVZ  X8, #0x1, LSL #0
    SUB  X22, X8, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X4, D21
    MOVZ  X6, #0x7b, LSL #0
    SUB  X11, X6, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X14, #0x30, LSL #0
    SUB  X4, X14, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X10, D22
    MOVZ  X14, #0x32, LSL #0
    SUB  X4, X14, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X7, #0x1, LSL #0
    SUB  X2, X7, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X8, D24
    MOVZ  X7, #0xdf68, LSL #0
    MOVK  X7, #0xda, LSL #16
    SUB  X2, X7, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X7, D25
    MOVZ  X2, #0x1d, LSL #0
    MOVK  X2, #0x37, LSL #32
    SUB  X19, X2, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X12, D26
    MOVZ  X2, #0x1, LSL #0
    SUB  X14, X2, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X29, D27
    MOVZ  X22, #0x304b, LSL #0
    SUB  X2, X22, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X12, D28
    MOVZ  X11, #0x3025, LSL #0
    SUB  X29, X11, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X7, D29
    MOVZ  X4, #0x7b, LSL #0
    SUB  X5, X4, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x91da, LSL #0
    MOVK  X2, #0xa702, LSL #16
    MOVK  X2, #0xc6b3, LSL #32
    MOVK  X2, #0x9858, LSL #48
    MOVZ  X3, #0xeeeb, LSL #0
    MOVK  X3, #0x2ec8, LSL #16
    MOVK  X3, #0x8e2f, LSL #32
    MOVK  X3, #0xfd2c, LSL #48
    MOVZ  X4, #0x315d, LSL #0
    MOVK  X4, #0xc510, LSL #16
    MOVK  X4, #0xae40, LSL #32
    MOVK  X4, #0xa658, LSL #48
    MOVZ  X5, #0xec7c, LSL #0
    MOVK  X5, #0x29f0, LSL #16
    MOVK  X5, #0xee0, LSL #32
    MOVK  X5, #0x9b08, LSL #48
    MOVZ  X6, #0x6f46, LSL #0
    MOVK  X6, #0xb77a, LSL #16
    MOVK  X6, #0xb570, LSL #32
    MOVK  X6, #0xcaf8, LSL #48
    MOVZ  X7, #0x887b, LSL #0
    MOVK  X7, #0x924, LSL #16
    MOVK  X7, #0xfc15, LSL #32
    MOVK  X7, #0x14db, LSL #48
    MOVZ  X8, #0xb51e, LSL #0
    MOVK  X8, #0x3b35, LSL #16
    MOVK  X8, #0x648b, LSL #32
    MOVK  X8, #0xccc, LSL #48
    MOVZ  X9, #0x96dd, LSL #0
    MOVK  X9, #0x9793, LSL #16
    MOVK  X9, #0xf53a, LSL #32
    MOVK  X9, #0x29f3, LSL #48
    MOVZ  X10, #0x5d0b, LSL #0
    MOVK  X10, #0xccd2, LSL #16
    MOVK  X10, #0xf646, LSL #32
    MOVK  X10, #0xb0dc, LSL #48
    MOVZ  X11, #0x19b3, LSL #0
    MOVK  X11, #0xe164, LSL #16
    MOVK  X11, #0x8479, LSL #32
    MOVK  X11, #0x9a61, LSL #48
    MOVZ  X12, #0xb736, LSL #0
    MOVK  X12, #0xfb48, LSL #16
    MOVK  X12, #0xef71, LSL #32
    MOVK  X12, #0xe21b, LSL #48
    MOVZ  X13, #0xce10, LSL #0
    MOVK  X13, #0xc6ef, LSL #16
    MOVK  X13, #0xe930, LSL #32
    MOVK  X13, #0x94d3, LSL #48
    MOVZ  X14, #0xd4ab, LSL #0
    MOVK  X14, #0x5147, LSL #16
    MOVK  X14, #0xe25c, LSL #32
    MOVK  X14, #0xf438, LSL #48
    MOVZ  X15, #0x3a85, LSL #0
    MOVK  X15, #0x608c, LSL #16
    MOVK  X15, #0x29c7, LSL #32
    MOVK  X15, #0x866b, LSL #48
    MOVZ  X16, #0x5d9e, LSL #0
    MOVK  X16, #0x81ae, LSL #16
    MOVK  X16, #0x7e5f, LSL #32
    MOVK  X16, #0x1d38, LSL #48
    MOVZ  X17, #0xaa59, LSL #0
    MOVK  X17, #0x5e3e, LSL #16
    MOVK  X17, #0x6c89, LSL #32
    MOVK  X17, #0xd337, LSL #48
    MOVZ  X18, #0xee6c, LSL #0
    MOVK  X18, #0xe3c2, LSL #16
    MOVK  X18, #0x3e27, LSL #32
    MOVK  X18, #0xef5c, LSL #48
    MOVZ  X19, #0x9d, LSL #0
    MOVK  X19, #0x854e, LSL #16
    MOVK  X19, #0x5e, LSL #32
    MOVK  X19, #0x7c03, LSL #48
    MOVZ  X20, #0x34b2, LSL #0
    MOVK  X20, #0xa038, LSL #16
    MOVK  X20, #0xe363, LSL #32
    MOVK  X20, #0xe31d, LSL #48
    MOVZ  X21, #0x4e10, LSL #0
    MOVK  X21, #0x6dbf, LSL #16
    MOVK  X21, #0x432a, LSL #32
    MOVK  X21, #0x3f46, LSL #48
    MOVZ  X22, #0xe72, LSL #0
    MOVK  X22, #0xefd7, LSL #16
    MOVK  X22, #0xa58f, LSL #32
    MOVK  X22, #0x2228, LSL #48
    MOVZ  X24, #0x29d6, LSL #0
    MOVK  X24, #0xf81f, LSL #16
    MOVK  X24, #0x6c45, LSL #32
    MOVK  X24, #0x9273, LSL #48
    MOVZ  X25, #0xc709, LSL #0
    MOVK  X25, #0xd7b3, LSL #16
    MOVK  X25, #0x9237, LSL #32
    MOVK  X25, #0x7779, LSL #48
    MOVZ  X26, #0x3c9d, LSL #0
    MOVK  X26, #0xcf67, LSL #16
    MOVK  X26, #0x9bec, LSL #32
    MOVK  X26, #0xb603, LSL #48
    MOVZ  X27, #0x425a, LSL #0
    MOVK  X27, #0x8081, LSL #16
    MOVK  X27, #0x8ad6, LSL #32
    MOVK  X27, #0xa18c, LSL #48
    MOVZ  X28, #0xd6aa, LSL #0
    MOVK  X28, #0x28aa, LSL #16
    MOVK  X28, #0xce26, LSL #32
    MOVK  X28, #0x2d65, LSL #48
    MOVZ  X29, #0xad47, LSL #0
    MOVK  X29, #0x9b47, LSL #16
    MOVK  X29, #0x22f5, LSL #32
    MOVK  X29, #0xd700, LSL #48
    FMOV  D0, X12
    FMOV  V0.D[1], X20
    FMOV  D1, X8
    FMOV  V1.D[1], X20
    FMOV  D2, X27
    FMOV  V2.D[1], X2
    FMOV  D3, X12
    FMOV  V3.D[1], X8
    FMOV  D4, X13
    FMOV  V4.D[1], X27
    FMOV  D5, X17
    FMOV  V5.D[1], X3
    FMOV  D6, X17
    FMOV  V6.D[1], X28
    FMOV  D7, X15
    FMOV  V7.D[1], X16
    FMOV  D8, X29
    FMOV  V8.D[1], X27
    FMOV  D9, X3
    FMOV  V9.D[1], X5
    FMOV  D10, X10
    FMOV  V10.D[1], X3
    FMOV  D11, X18
    FMOV  V11.D[1], X17
    FMOV  D12, X17
    FMOV  V12.D[1], X29
    FMOV  D13, X17
    FMOV  V13.D[1], X13
    FMOV  D14, X29
    FMOV  V14.D[1], X20
    FMOV  D15, X4
    FMOV  V15.D[1], X16
    FMOV  D16, X15
    FMOV  V16.D[1], X2
    FMOV  D17, X7
    FMOV  V17.D[1], X21
    FMOV  D18, X11
    FMOV  V18.D[1], X9
    FMOV  D19, X12
    FMOV  V19.D[1], X4
    FMOV  D20, X28
    FMOV  V20.D[1], X27
    FMOV  D21, X9
    FMOV  V21.D[1], X25
    FMOV  D22, X27
    FMOV  V22.D[1], X9
    FMOV  D23, X28
    FMOV  V23.D[1], X27
    FMOV  D24, X28
    FMOV  V24.D[1], X2
    FMOV  D25, X25
    FMOV  V25.D[1], X15
    FMOV  D26, X14
    FMOV  V26.D[1], X25
    FMOV  D27, X3
    FMOV  V27.D[1], X25
    FMOV  D28, X6
    FMOV  V28.D[1], X20
    FMOV  D29, X18
    FMOV  V29.D[1], X25
    FMOV  D30, X20
    FMOV  V30.D[1], X20
    FMOV  D31, X27
    FMOV  V31.D[1], X12
    MOVZ  X9, #0xa, LSL #0
TaishanSimdImmP01_label_924:
    ADDV  B13, V7.8B
    ADDP  D21, V6.2D
    ADD  D28, D0, D17
    ADDV  S3, V26.4S
    ADDP  D22, V13.2D
    ADDP  V23.2D, V11.2D, V6.2D
    ADDV  S27, V31.4S
    ADD  V16.4S, V22.4S, V19.4S
    ADDHN  V14.8B, V1.8H, V25.8H
    ADDV  S15, V22.4S
    ADD  D21, D16, D27
    ADDP  D30, V22.2D
    ADDV  H27, V22.8H
    ADDV  B25, V5.8B
    ADDHN  V22.8B, V15.8H, V29.8H
    ADDP  D14, V31.2D
    ADDHN  V14.8B, V14.8H, V28.8H
    ADDP  V0.16B, V27.16B, V28.16B
    ADDV  B17, V0.8B
    ADDV  H4, V22.4H
    ADDV  S11, V14.4S
    ADDP  D0, V15.2D
    ADDP  V5.2D, V17.2D, V21.2D
    ADDHN  V20.2S, V30.2D, V30.2D
    ADD  V29.4S, V22.4S, V23.4S
    ADDP  D19, V9.2D
    ADDV  S21, V19.4S
    ADDHN  V29.4H, V11.4S, V25.4S
    ADD  D6, D11, D21
    ADDV  S27, V31.4S
    ADDV  H30, V28.8H
    ADDP  V30.2S, V31.2S, V1.2S
    ADDHN  V0.2S, V16.2D, V14.2D
    ADDV  H20, V13.8H
    ADDV  H8, V25.8H
    ADDHN  V25.2S, V1.2D, V4.2D
    ADDV  S5, V19.4S
    ADDV  S29, V8.4S
    ADD  V1.2D, V3.2D, V8.2D
    ADDHN  V22.4H, V4.4S, V26.4S
    ADD  V27.2D, V3.2D, V31.2D
    ADDHN  V15.8B, V6.8H, V14.8H
    ADDV  H26, V25.8H
    ADDV  H24, V24.8H
    ADD  V11.16B, V26.16B, V16.16B
    ADDV  H11, V9.4H
    ADD  D13, D8, D30
    ADDP  V22.4S, V13.4S, V6.4S
    ADDV  H12, V27.8H
    ADDHN2  V8.8H, V27.4S, V19.4S
    ADD  D30, D29, D10
    ADDHN  V11.4H, V30.4S, V9.4S
    ADDP  V27.4S, V11.4S, V28.4S
    ADDP  V4.8B, V19.8B, V30.8B
    ADDP  V8.4S, V5.4S, V16.4S
    ADDHN  V12.4H, V22.4S, V4.4S
    ADDV  S16, V27.4S
    ADDHN2  V12.16B, V24.8H, V25.8H
    ADDP  V14.8H, V27.8H, V25.8H
    ADD  D14, D19, D0
    ADDV  S8, V14.4S
    ADDP  D20, V1.2D
    ADDP  D8, V6.2D
    ADDV  S14, V18.4S
    ADDHN  V1.4H, V29.4S, V27.4S
    ADDP  V8.4H, V7.4H, V22.4H
    ADDP  V18.8B, V20.8B, V26.8B
    ADDHN2  V25.8H, V16.4S, V6.4S
    ADD  V5.8B, V14.8B, V12.8B
    ADD  V1.8B, V5.8B, V13.8B
    ADDHN  V8.4H, V25.4S, V19.4S
    ADDHN  V19.2S, V29.2D, V19.2D
    ADDHN2  V4.4S, V28.2D, V2.2D
    ADDV  H0, V14.4H
    ADDV  H7, V17.8H
    ADDHN  V3.2S, V0.2D, V5.2D
    ADDP  D9, V16.2D
    ADDHN2  V10.8H, V31.4S, V13.4S
    ADDHN2  V3.4S, V10.2D, V0.2D
    ADDHN  V6.2S, V1.2D, V0.2D
    ADDV  H23, V3.4H
    ADDV  B9, V7.16B
    ADDHN  V31.8B, V4.8H, V7.8H
    ADD  D24, D24, D14
    ADD  D31, D6, D27
    ADDP  V26.2S, V27.2S, V30.2S
    ADDV  S22, V9.4S
    ADDHN  V16.2S, V20.2D, V1.2D
    ADDHN  V13.4H, V13.4S, V23.4S
    ADD  V17.16B, V24.16B, V24.16B
    ADDHN  V20.4H, V5.4S, V13.4S
    ADDP  V10.8H, V6.8H, V9.8H
    ADDP  D21, V16.2D
    ADD  D1, D16, D21
    ADD  V17.2D, V1.2D, V11.2D
    ADD  D16, D31, D8
    ADDP  D10, V21.2D
    ADD  D6, D1, D5
    ADDV  S17, V27.4S
    ADDP  D0, V14.2D
    ADDP  V26.16B, V27.16B, V22.16B
    ADDV  H2, V24.8H
    ADDP  V18.8H, V26.8H, V20.8H
    ADDV  B22, V15.16B
    ADDV  S26, V18.4S
    ADDV  B19, V3.8B
    ADDV  B28, V2.16B
    ADDV  H23, V31.8H
    ADDHN  V13.2S, V4.2D, V15.2D
    ADDHN  V30.8B, V13.8H, V13.8H
    ADD  V3.8H, V0.8H, V21.8H
    ADD  D25, D25, D27
    ADDHN2  V19.4S, V15.2D, V10.2D
    ADDP  V20.2S, V8.2S, V13.2S
    ADDHN  V0.4H, V17.4S, V22.4S
    ADDV  S4, V5.4S
    ADDV  H28, V19.8H
    ADD  D26, D26, D1
    ADDP  D13, V31.2D
    ADDV  B1, V23.8B
    ADDHN  V29.4H, V29.4S, V1.4S
    ADD  D22, D8, D27
    ADDV  H2, V30.8H
    ADD  V31.8H, V15.8H, V8.8H
    ADDP  D6, V10.2D
    ADDHN2  V2.16B, V11.8H, V30.8H
    ADDP  D24, V20.2D
    ADDV  S8, V13.4S
    ADDHN2  V31.4S, V26.2D, V16.2D
    ADDHN2  V5.8H, V1.4S, V11.4S
    ADDHN2  V29.16B, V27.8H, V23.8H
    ADDP  V26.4H, V10.4H, V30.4H
    ADDV  B29, V26.16B
    ADDV  H22, V25.4H
    ADDHN2  V5.8H, V22.4S, V19.4S
    ADD  D4, D16, D15
    ADDHN2  V24.8H, V16.4S, V3.4S
    ADDP  V25.4S, V14.4S, V12.4S
    ADDHN2  V29.8H, V15.4S, V19.4S
    ADDV  S31, V5.4S
    ADDV  S6, V20.4S
    ADDP  V27.2S, V15.2S, V14.2S
    ADD  D2, D31, D30
    ADD  V23.4S, V8.4S, V21.4S
    ADDV  S26, V6.4S
    ADDV  H26, V18.8H
    ADDV  H25, V4.8H
    ADDP  D26, V23.2D
    ADDV  B9, V21.16B
    ADDHN2  V2.4S, V18.2D, V9.2D
    ADD  V5.4H, V2.4H, V29.4H
    ADDHN  V26.2S, V11.2D, V20.2D
    ADDHN  V11.8B, V18.8H, V25.8H
    ADDP  D4, V6.2D
    ADDP  V3.8B, V26.8B, V11.8B
    ADDP  V15.2S, V13.2S, V29.2S
    ADDV  S4, V7.4S
    ADDV  S2, V17.4S
    ADD  D19, D24, D5
    ADDP  V27.2S, V5.2S, V25.2S
    ADDHN2  V28.16B, V15.8H, V6.8H
    ADD  V4.4H, V27.4H, V2.4H
    ADDP  D5, V4.2D
    ADD  D15, D12, D25
    ADDV  S6, V26.4S
    ADD  V5.8B, V12.8B, V0.8B
    ADDV  H3, V8.8H
    ADDV  S8, V1.4S
    ADD  D28, D16, D15
    ADD  V23.4H, V11.4H, V8.4H
    ADDV  B29, V31.16B
    ADDP  D18, V22.2D
    ADDP  V30.2S, V6.2S, V14.2S
    ADDV  B19, V20.8B
    ADDV  H20, V28.8H
    ADDHN  V17.4H, V27.4S, V24.4S
    ADDV  B26, V25.16B
    ADDHN2  V15.4S, V21.2D, V16.2D
    ADDHN  V24.4H, V31.4S, V15.4S
    ADD  D6, D13, D25
    ADD  D16, D25, D16
    ADDV  S14, V7.4S
    ADDV  S12, V24.4S
    ADD  V23.4S, V7.4S, V5.4S
    ADDHN2  V27.4S, V21.2D, V4.2D
    ADD  D16, D9, D18
    ADDV  B15, V7.16B
    ADDP  V16.2S, V19.2S, V22.2S
    ADDHN  V6.4H, V11.4S, V23.4S
    ADDV  H30, V21.4H
    ADDHN2  V29.4S, V16.2D, V19.2D
    ADDV  S8, V22.4S
    ADDHN  V3.4H, V20.4S, V31.4S
    ADDP  V14.8H, V11.8H, V0.8H
    ADD  V16.8B, V1.8B, V28.8B
    ADD  D21, D7, D12
    ADDP  D11, V16.2D
    ADD  V27.4H, V5.4H, V12.4H
    ADDHN2  V16.4S, V6.2D, V21.2D
    ADDV  S28, V6.4S
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdImmP01_label_924
    MOVZ  X16, #0x91da, LSL #0
    MOVK  X16, #0xa702, LSL #16
    MOVK  X16, #0xc6b3, LSL #32
    MOVK  X16, #0x9858, LSL #48
    SUB  X25, X16, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0xeeeb, LSL #0
    MOVK  X29, #0x2ec8, LSL #16
    MOVK  X29, #0x8e2f, LSL #32
    MOVK  X29, #0xfd2c, LSL #48
    SUB  X5, X29, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x315d, LSL #0
    MOVK  X16, #0xc510, LSL #16
    MOVK  X16, #0xae40, LSL #32
    MOVK  X16, #0xa658, LSL #48
    SUB  X2, X16, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x6f46, LSL #0
    MOVK  X6, #0xb77a, LSL #16
    MOVK  X6, #0xb570, LSL #32
    MOVK  X6, #0xcaf8, LSL #48
    SUB  X7, X6, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0xb51e, LSL #0
    MOVK  X22, #0x3b35, LSL #16
    MOVK  X22, #0x648b, LSL #32
    MOVK  X22, #0xccc, LSL #48
    SUB  X21, X22, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x5d0b, LSL #0
    MOVK  X14, #0xccd2, LSL #16
    MOVK  X14, #0xf646, LSL #32
    MOVK  X14, #0xb0dc, LSL #48
    SUB  X11, X14, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0xb736, LSL #0
    MOVK  X27, #0xfb48, LSL #16
    MOVK  X27, #0xef71, LSL #32
    MOVK  X27, #0xe21b, LSL #48
    SUB  X12, X27, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0xce10, LSL #0
    MOVK  X3, #0xc6ef, LSL #16
    MOVK  X3, #0xe930, LSL #32
    MOVK  X3, #0x94d3, LSL #48
    SUB  X15, X3, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x5d0b, LSL #0
    MOVK  X4, #0xccd2, LSL #16
    MOVK  X4, #0xf646, LSL #32
    MOVK  X4, #0xb0dc, LSL #48
    SUB  X9, X4, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xaa59, LSL #0
    MOVK  X21, #0x5e3e, LSL #16
    MOVK  X21, #0x6c89, LSL #32
    MOVK  X21, #0xd337, LSL #48
    SUB  X14, X21, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0xee6c, LSL #0
    MOVK  X24, #0xe3c2, LSL #16
    MOVK  X24, #0x3e27, LSL #32
    MOVK  X24, #0xef5c, LSL #48
    SUB  X9, X24, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0xaa59, LSL #0
    MOVK  X15, #0x5e3e, LSL #16
    MOVK  X15, #0x6c89, LSL #32
    MOVK  X15, #0xd337, LSL #48
    SUB  X25, X15, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xb51e, LSL #0
    MOVK  X21, #0x3b35, LSL #16
    MOVK  X21, #0x648b, LSL #32
    MOVK  X21, #0xccc, LSL #48
    SUB  X29, X21, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0xee6c, LSL #0
    MOVK  X21, #0xe3c2, LSL #16
    MOVK  X21, #0x3e27, LSL #32
    MOVK  X21, #0xef5c, LSL #48
    SUB  X12, X21, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x3c9d, LSL #0
    MOVK  X10, #0xcf67, LSL #16
    MOVK  X10, #0x9bec, LSL #32
    MOVK  X10, #0xb603, LSL #48
    SUB  X20, X10, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0xb736, LSL #0
    MOVK  X18, #0xfb48, LSL #16
    MOVK  X18, #0xef71, LSL #32
    MOVK  X18, #0xe21b, LSL #48
    SUB  X17, X18, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X10, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X22, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X12, D4
    MOVZ  X16, #0x20, LSL #0
    MOVK  X16, #0x20, LSL #32
    SUB  X25, X16, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X8, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X28, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X20, D7
    MOVZ  X26, #0x8c, LSL #0
    SUB  X25, X26, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X11, D8
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X11, D9
    MOVZ  X29, #0x20, LSL #0
    SUB  X27, X29, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X2, D10
    MOVZ  X19, #0x20, LSL #0
    SUB  X27, X19, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X5, D11
    MOVZ  X17, #0x60, LSL #0
    SUB  X28, X17, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X3, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X21, D13
    MOVZ  X9, #0x20, LSL #0
    SUB  X4, X9, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X15, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X5, D15
    MOVZ  X3, #0x8c, LSL #0
    SUB  X24, X3, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X4, D16
    MOVZ  X25, #0x60, LSL #0
    SUB  X29, X25, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X24, D17
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X24, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X17, D19
    MOVZ  X15, #0x20, LSL #0
    SUB  X9, X15, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X18, D20
    MOVZ  X22, #0x40, LSL #0
    SUB  X25, X22, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X8, D21
    MOVZ  X28, #0x8c, LSL #0
    SUB  X13, X28, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X15, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X25, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X7, D25
    MOVZ  X15, #0x20, LSL #0
    SUB  X6, X15, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X15, D26
    MOVZ  X27, #0x20, LSL #0
    SUB  X7, X27, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X15, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X5, D28
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X28, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X19
    FMOV  V0.D[1], X7
    FMOV  D1, X15
    FMOV  V1.D[1], X26
    FMOV  D2, X2
    FMOV  V2.D[1], X20
    FMOV  D3, X16
    FMOV  V3.D[1], X2
    FMOV  D4, X24
    FMOV  V4.D[1], X11
    FMOV  D5, X21
    FMOV  V5.D[1], X24
    FMOV  D6, X27
    FMOV  V6.D[1], X22
    FMOV  D7, X5
    FMOV  V7.D[1], X29
    FMOV  D8, X2
    FMOV  V8.D[1], X8
    FMOV  D9, X3
    FMOV  V9.D[1], X11
    FMOV  D10, X17
    FMOV  V10.D[1], X29
    FMOV  D11, X6
    FMOV  V11.D[1], X9
    FMOV  D12, X13
    FMOV  V12.D[1], X11
    FMOV  D13, X12
    FMOV  V13.D[1], X25
    FMOV  D14, X26
    FMOV  V14.D[1], X24
    FMOV  D15, X16
    FMOV  V15.D[1], X27
    FMOV  D16, X21
    FMOV  V16.D[1], X8
    FMOV  D17, X13
    FMOV  V17.D[1], X6
    FMOV  D18, X28
    FMOV  V18.D[1], X27
    FMOV  D19, X10
    FMOV  V19.D[1], X10
    FMOV  D20, X25
    FMOV  V20.D[1], X20
    FMOV  D21, X5
    FMOV  V21.D[1], X2
    FMOV  D22, X2
    FMOV  V22.D[1], X13
    FMOV  D23, X10
    FMOV  V23.D[1], X28
    FMOV  D24, X8
    FMOV  V24.D[1], X21
    FMOV  D25, X7
    FMOV  V25.D[1], X13
    FMOV  D26, X6
    FMOV  V26.D[1], X24
    FMOV  D27, X27
    FMOV  V27.D[1], X22
    FMOV  D28, X20
    FMOV  V28.D[1], X2
    FMOV  D29, X16
    FMOV  V29.D[1], X19
    FMOV  D30, X7
    FMOV  V30.D[1], X25
    FMOV  D31, X3
    FMOV  V31.D[1], X20
    MOVZ  X18, #0xa, LSL #0
TaishanSimdImmP01_label_994:
    ADD  V4.2D, V11.2D, V13.2D
    ADDV  S16, V28.4S
    ADDP  D4, V20.2D
    ADDP  D7, V30.2D
    ADDV  B4, V31.8B
    ADDP  D3, V25.2D
    ADD  V25.2S, V16.2S, V19.2S
    ADDV  H1, V11.8H
    ADDHN2  V8.16B, V21.8H, V18.8H
    ADDP  V5.2D, V28.2D, V25.2D
    ADDHN2  V11.16B, V12.8H, V10.8H
    ADDP  V23.4S, V23.4S, V7.4S
    ADD  V12.16B, V4.16B, V3.16B
    ADDV  H29, V17.4H
    ADDV  S23, V13.4S
    ADDV  H31, V26.4H
    ADDV  H30, V3.4H
    ADD  V13.2D, V7.2D, V12.2D
    ADD  D12, D13, D17
    ADDV  H10, V22.8H
    ADDP  V3.4H, V30.4H, V12.4H
    ADDHN2  V24.16B, V16.8H, V4.8H
    ADD  D20, D26, D8
    ADDV  H9, V29.4H
    ADDHN2  V8.4S, V9.2D, V17.2D
    ADDV  H0, V25.4H
    ADDV  H26, V19.8H
    ADDP  V15.8B, V24.8B, V3.8B
    ADDV  B25, V7.16B
    ADDP  D20, V22.2D
    ADDHN2  V30.8H, V30.4S, V19.4S
    ADDHN2  V29.8H, V6.4S, V28.4S
    ADDV  H31, V25.8H
    ADDV  H29, V4.4H
    ADDV  S12, V1.4S
    ADDP  D28, V25.2D
    ADDHN2  V17.16B, V24.8H, V30.8H
    ADD  D29, D8, D29
    ADDV  B4, V19.8B
    ADDHN2  V5.16B, V3.8H, V31.8H
    ADDV  H8, V9.8H
    ADDHN  V28.2S, V16.2D, V17.2D
    ADDP  D25, V9.2D
    ADDP  V13.8B, V29.8B, V25.8B
    ADDP  D16, V18.2D
    ADDHN2  V5.16B, V16.8H, V2.8H
    ADDV  B10, V17.16B
    ADDP  D13, V20.2D
    ADDHN2  V5.16B, V3.8H, V20.8H
    ADD  V1.8H, V29.8H, V31.8H
    ADDHN  V31.2S, V6.2D, V16.2D
    ADDP  V9.2S, V5.2S, V4.2S
    ADDP  V31.4S, V4.4S, V3.4S
    ADDP  D18, V15.2D
    ADDV  B16, V22.8B
    ADD  V26.16B, V19.16B, V25.16B
    ADD  D20, D9, D22
    ADDV  S22, V23.4S
    ADDP  V1.2D, V16.2D, V2.2D
    ADDHN  V7.2S, V21.2D, V17.2D
    ADDHN2  V12.16B, V24.8H, V10.8H
    ADD  D26, D13, D24
    ADDV  B15, V12.16B
    ADDHN2  V31.16B, V8.8H, V1.8H
    ADDV  B26, V10.16B
    ADDP  V18.4S, V9.4S, V20.4S
    ADDV  B7, V18.8B
    ADDV  S18, V6.4S
    ADDHN  V24.2S, V7.2D, V4.2D
    ADDP  V25.4H, V21.4H, V28.4H
    ADDP  D8, V3.2D
    ADD  D23, D16, D25
    ADDV  S6, V27.4S
    ADD  V5.4H, V23.4H, V13.4H
    ADDHN2  V12.16B, V26.8H, V13.8H
    ADDP  V12.8B, V22.8B, V24.8B
    ADD  V7.8H, V31.8H, V8.8H
    ADDHN2  V6.8H, V21.4S, V15.4S
    ADDHN2  V24.4S, V9.2D, V18.2D
    ADDHN  V21.8B, V29.8H, V7.8H
    ADDV  H25, V9.4H
    ADDHN2  V25.4S, V31.2D, V29.2D
    ADDV  H28, V23.8H
    ADDP  V21.16B, V23.16B, V3.16B
    ADD  V17.8H, V21.8H, V28.8H
    ADDV  H28, V21.4H
    ADDP  D10, V16.2D
    ADDP  V25.4H, V1.4H, V20.4H
    ADD  D17, D21, D10
    ADDV  S29, V28.4S
    ADDV  H24, V16.8H
    ADDV  S6, V18.4S
    ADDV  B31, V18.16B
    ADDV  S4, V29.4S
    ADDHN2  V0.16B, V12.8H, V3.8H
    ADDP  V13.2S, V14.2S, V9.2S
    ADDP  V14.2S, V13.2S, V20.2S
    ADDV  B4, V19.16B
    ADDP  V29.4S, V25.4S, V16.4S
    ADDHN  V23.2S, V29.2D, V2.2D
    ADDP  V18.2S, V24.2S, V11.2S
    ADD  D5, D23, D20
    ADDP  D20, V5.2D
    ADDP  D11, V11.2D
    ADDHN2  V16.16B, V18.8H, V13.8H
    ADDP  D10, V19.2D
    ADDP  V1.2S, V5.2S, V13.2S
    ADDV  H0, V12.8H
    ADDHN  V23.4H, V2.4S, V16.4S
    ADDV  H19, V3.4H
    ADDV  H16, V24.8H
    ADDV  H6, V15.4H
    ADDHN  V7.8B, V12.8H, V6.8H
    ADDV  B18, V17.16B
    ADDP  D7, V27.2D
    ADDHN  V4.8B, V25.8H, V1.8H
    ADD  V2.2D, V14.2D, V12.2D
    ADDHN2  V17.16B, V5.8H, V31.8H
    ADDV  H26, V22.4H
    ADDP  V26.8H, V17.8H, V20.8H
    ADDV  S25, V27.4S
    ADDP  V31.8H, V1.8H, V10.8H
    ADDV  B7, V15.8B
    ADDP  V7.4S, V15.4S, V16.4S
    ADD  V28.4H, V3.4H, V5.4H
    ADD  V7.2S, V16.2S, V5.2S
    ADDV  H10, V2.8H
    ADDP  D0, V22.2D
    ADDP  V28.8B, V21.8B, V13.8B
    ADDV  S20, V31.4S
    ADD  V21.8H, V20.8H, V5.8H
    ADDHN  V11.8B, V18.8H, V17.8H
    ADDP  D21, V26.2D
    ADD  D2, D15, D18
    ADD  D23, D8, D3
    ADDP  V23.4S, V27.4S, V23.4S
    ADDV  S26, V17.4S
    ADD  D8, D25, D8
    ADDHN2  V25.16B, V18.8H, V30.8H
    ADD  D16, D0, D13
    ADDHN  V0.4H, V21.4S, V15.4S
    ADDV  S7, V9.4S
    ADDV  S6, V8.4S
    ADDV  B5, V10.16B
    ADD  V13.4S, V31.4S, V10.4S
    ADDHN2  V10.8H, V0.4S, V28.4S
    ADDHN  V29.2S, V10.2D, V2.2D
    ADDV  S8, V20.4S
    ADDP  D28, V11.2D
    ADDV  S17, V22.4S
    ADDHN2  V1.8H, V25.4S, V1.4S
    ADDV  S30, V9.4S
    ADD  D13, D13, D12
    ADDV  S26, V21.4S
    ADDP  D18, V9.2D
    ADDHN2  V13.4S, V4.2D, V19.2D
    ADDP  V22.2D, V31.2D, V21.2D
    ADDV  S8, V18.4S
    ADDP  V25.8B, V28.8B, V24.8B
    ADDV  H23, V11.8H
    ADD  V25.16B, V27.16B, V7.16B
    ADD  V26.2D, V18.2D, V6.2D
    ADD  D24, D28, D9
    ADDV  H12, V8.8H
    ADD  V24.16B, V15.16B, V9.16B
    ADD  V27.2D, V22.2D, V16.2D
    ADDP  V0.4H, V17.4H, V19.4H
    ADDHN  V8.2S, V2.2D, V9.2D
    ADDV  S19, V13.4S
    ADDP  V12.8H, V2.8H, V27.8H
    ADDHN  V22.8B, V8.8H, V30.8H
    ADDP  D22, V10.2D
    ADD  D30, D22, D9
    ADDV  S10, V28.4S
    ADD  D30, D13, D18
    ADDP  D11, V24.2D
    ADD  V30.2S, V26.2S, V9.2S
    ADDP  V4.16B, V29.16B, V5.16B
    ADDV  S10, V31.4S
    ADDV  S29, V22.4S
    ADDV  H11, V21.4H
    ADDHN2  V8.16B, V2.8H, V24.8H
    ADDHN  V13.2S, V11.2D, V23.2D
    ADDHN2  V18.4S, V9.2D, V25.2D
    ADDHN  V6.8B, V19.8H, V2.8H
    ADDP  V30.4H, V12.4H, V20.4H
    ADDV  S5, V6.4S
    ADDV  H9, V4.8H
    ADD  V8.2D, V19.2D, V5.2D
    ADDP  V8.4S, V0.4S, V11.4S
    ADD  V19.4S, V19.4S, V0.4S
    ADDP  V29.4H, V3.4H, V12.4H
    ADDV  H23, V24.8H
    ADDHN  V21.2S, V6.2D, V24.2D
    ADDHN2  V18.16B, V9.8H, V25.8H
    ADD  D11, D16, D31
    ADDV  B16, V7.16B
    ADD  D25, D22, D31
    ADDP  V19.2S, V14.2S, V8.2S
    ADDV  B10, V29.16B
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdImmP01_label_994
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X4, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X7, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X2, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X6, D5
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X14, D6
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X3, D7
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X15, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X13, D9
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X11, D10
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X20, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X18, D12
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X10, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X21, D14
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X12, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X2, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X10, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X29, D18
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X15, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X11, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X3, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X12, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X3, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X9, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X2, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X29, D27
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X18, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X18, D29
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
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
    FMOV  V0.D[1], X5
    FMOV  D1, X26
    FMOV  V1.D[1], X2
    FMOV  D2, X20
    FMOV  V2.D[1], X2
    FMOV  D3, X29
    FMOV  V3.D[1], X3
    FMOV  D4, X11
    FMOV  V4.D[1], X22
    FMOV  D5, X14
    FMOV  V5.D[1], X21
    FMOV  D6, X26
    FMOV  V6.D[1], X2
    FMOV  D7, X11
    FMOV  V7.D[1], X28
    FMOV  D8, X4
    FMOV  V8.D[1], X27
    FMOV  D9, X3
    FMOV  V9.D[1], X8
    FMOV  D10, X8
    FMOV  V10.D[1], X6
    FMOV  D11, X20
    FMOV  V11.D[1], X21
    FMOV  D12, X9
    FMOV  V12.D[1], X21
    FMOV  D13, X29
    FMOV  V13.D[1], X8
    FMOV  D14, X21
    FMOV  V14.D[1], X16
    FMOV  D15, X19
    FMOV  V15.D[1], X20
    FMOV  D16, X27
    FMOV  V16.D[1], X22
    FMOV  D17, X6
    FMOV  V17.D[1], X22
    FMOV  D18, X13
    FMOV  V18.D[1], X13
    FMOV  D19, X18
    FMOV  V19.D[1], X6
    FMOV  D20, X19
    FMOV  V20.D[1], X18
    FMOV  D21, X27
    FMOV  V21.D[1], X22
    FMOV  D22, X11
    FMOV  V22.D[1], X26
    FMOV  D23, X10
    FMOV  V23.D[1], X8
    FMOV  D24, X2
    FMOV  V24.D[1], X24
    FMOV  D25, X8
    FMOV  V25.D[1], X21
    FMOV  D26, X26
    FMOV  V26.D[1], X28
    FMOV  D27, X3
    FMOV  V27.D[1], X24
    FMOV  D28, X29
    FMOV  V28.D[1], X12
    FMOV  D29, X16
    FMOV  V29.D[1], X13
    FMOV  D30, X8
    FMOV  V30.D[1], X20
    FMOV  D31, X5
    FMOV  V31.D[1], X12
    MOVZ  X18, #0xf, LSL #0
TaishanSimdImmP01_label_1060:
    ADDP  V7.2S, V26.2S, V26.2S
    ADD  D29, D27, D8
    ADDP  V14.4H, V14.4H, V8.4H
    ADDHN2  V30.4S, V18.2D, V1.2D
    ADDV  S4, V29.4S
    ADDHN  V11.8B, V19.8H, V30.8H
    ADDV  B11, V16.16B
    ADDHN2  V21.8H, V6.4S, V14.4S
    ADDP  D21, V2.2D
    ADD  D15, D15, D20
    ADDV  B0, V12.16B
    ADDV  B15, V4.16B
    ADDHN2  V18.4S, V31.2D, V4.2D
    ADD  D31, D22, D29
    ADD  D11, D2, D12
    ADD  D7, D0, D30
    ADDP  V3.8H, V7.8H, V24.8H
    ADDV  B14, V20.16B
    ADD  D15, D26, D11
    ADDV  B8, V28.8B
    ADDHN  V29.4H, V28.4S, V14.4S
    ADDP  V11.8H, V7.8H, V27.8H
    ADDV  B10, V1.8B
    ADDHN2  V0.16B, V24.8H, V16.8H
    ADDHN2  V25.8H, V6.4S, V15.4S
    ADDP  D30, V30.2D
    ADDHN  V17.2S, V13.2D, V26.2D
    ADDP  V23.2D, V15.2D, V21.2D
    ADDHN2  V13.16B, V27.8H, V17.8H
    ADDP  V12.2D, V23.2D, V8.2D
    ADD  D17, D17, D22
    ADDV  H13, V11.4H
    ADDHN2  V5.4S, V23.2D, V8.2D
    ADDV  H15, V28.4H
    ADDP  D12, V10.2D
    ADDP  V17.8H, V10.8H, V9.8H
    ADDP  V26.16B, V11.16B, V13.16B
    ADDV  S5, V5.4S
    ADDP  V26.4H, V9.4H, V0.4H
    ADD  V14.4S, V14.4S, V6.4S
    ADD  D30, D12, D14
    ADD  V22.4S, V26.4S, V4.4S
    ADDP  D15, V14.2D
    ADDV  H29, V27.8H
    ADDV  B6, V27.16B
    ADD  D1, D25, D14
    ADDV  S24, V3.4S
    ADDP  V8.8B, V1.8B, V7.8B
    ADDV  B13, V22.8B
    ADDHN2  V20.16B, V30.8H, V15.8H
    ADDHN2  V25.4S, V0.2D, V19.2D
    ADD  D19, D11, D25
    ADDHN2  V29.4S, V19.2D, V29.2D
    ADDP  D12, V29.2D
    ADDP  V30.4H, V1.4H, V27.4H
    ADDV  B21, V23.8B
    ADDV  B24, V24.8B
    ADDV  H10, V14.8H
    ADDV  B14, V1.8B
    ADDP  V3.4S, V11.4S, V3.4S
    ADDHN  V30.8B, V0.8H, V8.8H
    ADDV  B6, V9.8B
    ADDP  V30.8B, V5.8B, V31.8B
    ADDP  D13, V27.2D
    ADDV  H29, V14.8H
    ADDV  B3, V12.16B
    ADD  V6.8H, V10.8H, V31.8H
    ADDHN2  V12.16B, V2.8H, V8.8H
    ADDV  H4, V1.4H
    ADDHN  V13.4H, V18.4S, V2.4S
    ADDHN2  V2.8H, V20.4S, V29.4S
    ADDV  H11, V23.8H
    ADD  V3.4S, V6.4S, V8.4S
    ADDHN  V3.4H, V3.4S, V25.4S
    ADDV  H28, V12.8H
    ADD  V4.4H, V12.4H, V10.4H
    ADDV  S24, V18.4S
    ADD  D23, D22, D28
    ADDV  S9, V4.4S
    ADDHN  V21.4H, V2.4S, V31.4S
    ADDP  D31, V5.2D
    ADD  V9.4S, V22.4S, V11.4S
    ADDP  D29, V15.2D
    ADDP  V21.8B, V17.8B, V31.8B
    ADDHN2  V21.4S, V11.2D, V1.2D
    ADD  D17, D10, D16
    ADDV  B22, V20.8B
    ADDHN2  V10.4S, V30.2D, V26.2D
    ADDHN  V18.4H, V29.4S, V16.4S
    ADDP  V20.8B, V25.8B, V15.8B
    ADD  V9.2D, V20.2D, V8.2D
    ADDP  D5, V0.2D
    ADD  V4.8B, V5.8B, V22.8B
    ADDV  B31, V27.16B
    ADDP  D17, V21.2D
    ADD  D21, D9, D23
    ADDHN  V9.2S, V7.2D, V28.2D
    ADD  D17, D23, D11
    ADDV  S5, V21.4S
    ADDHN2  V27.8H, V7.4S, V6.4S
    ADD  D29, D7, D6
    ADDV  H31, V9.8H
    ADDV  H9, V1.8H
    ADDP  D29, V23.2D
    ADDP  V11.2D, V7.2D, V16.2D
    ADD  V21.4H, V9.4H, V5.4H
    ADDV  S17, V2.4S
    ADDHN2  V14.16B, V26.8H, V21.8H
    ADD  V23.16B, V21.16B, V17.16B
    ADD  D2, D12, D25
    ADDHN2  V3.4S, V31.2D, V21.2D
    ADD  D15, D3, D6
    ADDHN  V22.4H, V6.4S, V14.4S
    ADDV  B9, V16.16B
    ADDHN2  V6.16B, V0.8H, V12.8H
    ADDP  V6.16B, V27.16B, V14.16B
    ADDHN  V15.4H, V17.4S, V27.4S
    ADDV  H12, V16.4H
    ADDV  B27, V17.16B
    ADDV  S11, V25.4S
    ADDP  D6, V1.2D
    ADDHN  V4.2S, V19.2D, V21.2D
    ADDV  H20, V16.8H
    ADD  D27, D30, D13
    ADD  D12, D28, D8
    ADD  V7.8H, V17.8H, V6.8H
    ADD  D21, D14, D3
    ADDV  H30, V12.8H
    ADDV  B30, V25.8B
    ADDHN  V25.2S, V29.2D, V15.2D
    ADDHN  V2.8B, V13.8H, V20.8H
    ADD  V27.2D, V23.2D, V5.2D
    ADDHN2  V20.4S, V30.2D, V16.2D
    ADDV  H9, V12.8H
    ADDP  D21, V15.2D
    ADDP  D25, V17.2D
    ADDP  V1.2D, V25.2D, V23.2D
    ADDP  D29, V15.2D
    ADD  V13.4S, V28.4S, V17.4S
    ADD  V24.2S, V19.2S, V31.2S
    ADD  D2, D21, D6
    ADDV  B1, V10.8B
    ADDHN  V19.4H, V16.4S, V16.4S
    ADD  V16.2S, V1.2S, V4.2S
    ADDV  S6, V14.4S
    ADD  V12.16B, V5.16B, V31.16B
    ADDP  V26.8H, V22.8H, V9.8H
    ADDHN2  V12.8H, V9.4S, V23.4S
    ADDHN  V24.2S, V3.2D, V7.2D
    ADDHN  V2.4H, V22.4S, V7.4S
    ADDV  S15, V6.4S
    ADD  D2, D12, D4
    ADDHN2  V24.16B, V26.8H, V14.8H
    ADDP  D13, V30.2D
    ADDV  H16, V5.4H
    ADDP  D29, V1.2D
    ADDV  S2, V3.4S
    ADDP  V16.8B, V18.8B, V9.8B
    ADDP  D26, V19.2D
    ADDV  B26, V30.16B
    ADDP  V8.2D, V19.2D, V0.2D
    ADDV  B0, V28.16B
    ADDHN2  V9.16B, V1.8H, V1.8H
    ADD  D27, D12, D4
    ADDHN  V5.8B, V19.8H, V28.8H
    ADD  D6, D26, D26
    ADD  D21, D6, D26
    ADDP  V16.2S, V10.2S, V1.2S
    ADDP  D29, V1.2D
    ADDV  B1, V2.8B
    ADD  V17.2D, V0.2D, V8.2D
    ADD  D13, D1, D22
    ADDHN  V22.8B, V24.8H, V0.8H
    ADDV  S23, V7.4S
    ADDV  H16, V10.4H
    ADD  D4, D20, D31
    ADDHN  V1.2S, V4.2D, V7.2D
    ADD  V12.4H, V21.4H, V11.4H
    ADDHN2  V1.4S, V1.2D, V14.2D
    ADD  D12, D10, D16
    ADDV  H9, V10.4H
    ADDV  H23, V10.8H
    ADDP  D16, V27.2D
    ADDV  S21, V1.4S
    ADDHN  V29.4H, V13.4S, V27.4S
    ADDP  V8.8B, V21.8B, V22.8B
    ADDHN  V23.8B, V26.8H, V12.8H
    ADDP  D2, V22.2D
    ADD  D1, D28, D12
    ADDHN2  V9.8H, V15.4S, V31.4S
    ADDHN  V28.4H, V4.4S, V10.4S
    ADD  D16, D3, D24
    ADDP  V20.16B, V23.16B, V9.16B
    ADD  V2.2D, V15.2D, V26.2D
    ADD  V26.2S, V3.2S, V12.2S
    ADDV  B0, V12.16B
    ADDP  V25.4H, V2.4H, V11.4H
    ADDHN2  V25.4S, V28.2D, V27.2D
    ADDV  S1, V8.4S
    ADDV  H31, V12.4H
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdImmP01_label_1060
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X21, X9, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X11, X25, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X22, X13, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X4, X2, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X20, X9, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X17, X14, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X10, X28, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X10, X5, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X17, X7, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X13, X5, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X9, X7, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X21, D2
    MOVZ  X19, #0xe85, LSL #0
    SUB  X13, X19, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X9, D3
    MOVZ  X24, #0xd42, LSL #0
    SUB  X18, X24, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X10, D4
    MOVZ  X5, #0x466e, LSL #0
    SUB  X21, X5, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X11, D5
    MOVZ  X17, #0x43, LSL #0
    SUB  X26, X17, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X2, D6
    MOVZ  X24, #0x10e, LSL #0
    SUB  X20, X24, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X15
TaishanSimdImmP01_label_900:
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X15, D7
    MOVZ  X10, #0x1ba8, LSL #0
    MOVK  X10, #0x4653, LSL #32
    SUB  X5, X10, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X18, D8
    MOVZ  X19, #0x99, LSL #0
    MOVK  X19, #0x46, LSL #32
    SUB  X15, X19, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X3, D9
    MOVZ  X14, #0x1e4, LSL #0
    SUB  X22, X14, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X26, #0xb4ea, LSL #0
    MOVK  X26, #0x3a, LSL #16
    SUB  X28, X26, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X20, D10
    MOVZ  X26, #0x1e4, LSL #0
    SUB  X28, X26, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X13, D11
    MOVZ  X28, #0x5335, LSL #0
    SUB  X22, X28, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X14, D12
    MOVZ  X7, #0x3c8, LSL #0
    SUB  X13, X7, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X24, D13
    MOVZ  X11, #0xcf7, LSL #0
    SUB  X8, X11, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X21, #0xd91, LSL #0
    SUB  X12, X21, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X27, D14
    MOVZ  X21, #0x6d, LSL #0
    SUB  X12, X21, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X4, D15
    MOVZ  X20, #0xdfe, LSL #0
    SUB  X27, X20, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X18, D16
    MOVZ  X14, #0x5395, LSL #0
    SUB  X24, X14, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X8, #0xe3, LSL #0
    SUB  X11, X8, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X12, D17
    MOVZ  X8, #0xa, LSL #0
    SUB  X11, X8, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X6, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X25, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X2, #0xe5, LSL #0
    SUB  X27, X2, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X17, D20
    MOVZ  X2, #0x4, LSL #0
    SUB  X27, X2, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X8, D21
    MOVZ  X5, #0x4653, LSL #0
    SUB  X29, X5, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X17, D22
    MOVZ  X2, #0x46, LSL #0
    SUB  X21, X2, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X8, #0xd, LSL #0
    MOVK  X8, #0x53, LSL #32
    SUB  X29, X8, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X3, D24
    MOVZ  X8, #0x4653, LSL #0
    SUB  X29, X8, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X18, #0x3a, LSL #0
    SUB  X29, X18, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X4, D25
    MOVZ  X18, #0xe85, LSL #0
    MOVK  X18, #0x5335, LSL #32
    SUB  X29, X18, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X18, D26
    MOVZ  X11, #0x110a, LSL #0
    SUB  X27, X11, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X24, D27
    MOVZ  X7, #0x8165, LSL #0
    MOVK  X7, #0xddb, LSL #16
    SUB  X29, X7, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X8, D28
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3a, LSL #32
    SUB  X9, X14, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X19, D29
    MOVZ  X24, #0xddb, LSL #0
    SUB  X9, X24, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xf053, LSL #0
    MOVK  X2, #0xe101, LSL #16
    MOVK  X2, #0xaae8, LSL #32
    MOVK  X2, #0xd469, LSL #48
    MOVZ  X3, #0xaeeb, LSL #0
    MOVK  X3, #0xc014, LSL #16
    MOVK  X3, #0xe4e5, LSL #32
    MOVK  X3, #0x6d34, LSL #48
    MOVZ  X4, #0x151a, LSL #0
    MOVK  X4, #0x53a7, LSL #16
    MOVK  X4, #0xf2d5, LSL #32
    MOVK  X4, #0xae52, LSL #48
    MOVZ  X5, #0x2255, LSL #0
    MOVK  X5, #0xf449, LSL #16
    MOVK  X5, #0x6952, LSL #32
    MOVK  X5, #0x7c7, LSL #48
    MOVZ  X6, #0x3d58, LSL #0
    MOVK  X6, #0x42db, LSL #16
    MOVK  X6, #0xd562, LSL #32
    MOVK  X6, #0x8093, LSL #48
    MOVZ  X7, #0x99ee, LSL #0
    MOVK  X7, #0x7d5e, LSL #16
    MOVK  X7, #0xdba0, LSL #32
    MOVK  X7, #0xc1bd, LSL #48
    MOVZ  X8, #0xa840, LSL #0
    MOVK  X8, #0x80ae, LSL #16
    MOVK  X8, #0xeb31, LSL #32
    MOVK  X8, #0xbaa3, LSL #48
    MOVZ  X9, #0xc75e, LSL #0
    MOVK  X9, #0xbb37, LSL #16
    MOVK  X9, #0xf404, LSL #32
    MOVK  X9, #0x5bb6, LSL #48
    MOVZ  X10, #0x4c0c, LSL #0
    MOVK  X10, #0x9e9e, LSL #16
    MOVK  X10, #0x3108, LSL #32
    MOVK  X10, #0xbc52, LSL #48
    MOVZ  X11, #0xf386, LSL #0
    MOVK  X11, #0x160c, LSL #16
    MOVK  X11, #0xdef0, LSL #32
    MOVK  X11, #0x8f6d, LSL #48
    MOVZ  X12, #0x569, LSL #0
    MOVK  X12, #0x2f11, LSL #16
    MOVK  X12, #0xea72, LSL #32
    MOVK  X12, #0x79e7, LSL #48
    MOVZ  X13, #0x37eb, LSL #0
    MOVK  X13, #0x6f31, LSL #16
    MOVK  X13, #0x3393, LSL #32
    MOVK  X13, #0xead7, LSL #48
    MOVZ  X14, #0x105, LSL #0
    MOVK  X14, #0x7c26, LSL #16
    MOVK  X14, #0x9eba, LSL #32
    MOVK  X14, #0x83d9, LSL #48
    MOVZ  X15, #0xc7ba, LSL #0
    MOVK  X15, #0x870d, LSL #16
    MOVK  X15, #0x7152, LSL #32
    MOVK  X15, #0xc923, LSL #48
    MOVZ  X16, #0x6acb, LSL #0
    MOVK  X16, #0xeee3, LSL #16
    MOVK  X16, #0x5fe7, LSL #32
    MOVK  X16, #0xa679, LSL #48
    MOVZ  X17, #0x5a53, LSL #0
    MOVK  X17, #0x485b, LSL #16
    MOVK  X17, #0xb62e, LSL #32
    MOVK  X17, #0x56d6, LSL #48
    MOVZ  X18, #0xf959, LSL #0
    MOVK  X18, #0x5f85, LSL #16
    MOVK  X18, #0xab54, LSL #32
    MOVK  X18, #0x3d94, LSL #48
    MOVZ  X19, #0x8466, LSL #0
    MOVK  X19, #0x335c, LSL #16
    MOVK  X19, #0xba60, LSL #32
    MOVK  X19, #0x1af9, LSL #48
    MOVZ  X20, #0x914d, LSL #0
    MOVK  X20, #0x1a12, LSL #16
    MOVK  X20, #0xed50, LSL #32
    MOVK  X20, #0x75b5, LSL #48
    MOVZ  X21, #0xc54f, LSL #0
    MOVK  X21, #0xb010, LSL #16
    MOVK  X21, #0x9a38, LSL #32
    MOVK  X21, #0xdfe5, LSL #48
    MOVZ  X22, #0x614a, LSL #0
    MOVK  X22, #0xa329, LSL #16
    MOVK  X22, #0xe0c1, LSL #32
    MOVK  X22, #0xecd9, LSL #48
    MOVZ  X24, #0xccb1, LSL #0
    MOVK  X24, #0x2969, LSL #16
    MOVK  X24, #0xc982, LSL #32
    MOVK  X24, #0xc380, LSL #48
    MOVZ  X25, #0xc22b, LSL #0
    MOVK  X25, #0x76bd, LSL #16
    MOVK  X25, #0x2e7b, LSL #32
    MOVK  X25, #0x93ab, LSL #48
    MOVZ  X26, #0xc021, LSL #0
    MOVK  X26, #0x62e6, LSL #16
    MOVK  X26, #0xa66d, LSL #32
    MOVK  X26, #0xaf3, LSL #48
    MOVZ  X27, #0xa524, LSL #0
    MOVK  X27, #0x9c06, LSL #16
    MOVK  X27, #0x67c2, LSL #32
    MOVK  X27, #0x2545, LSL #48
    MOVZ  X28, #0xfa85, LSL #0
    MOVK  X28, #0x6f0f, LSL #16
    MOVK  X28, #0x7f22, LSL #32
    MOVK  X28, #0x50fa, LSL #48
    MOVZ  X29, #0xacb1, LSL #0
    MOVK  X29, #0xce4f, LSL #16
TaishanSimdImmP01_label_159:
    MOVK  X29, #0xc4f1, LSL #32
    MOVK  X29, #0x936d, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X10
    FMOV  D1, X29
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X5
    FMOV  V3.D[1], X27
    FMOV  D4, X28
    FMOV  V4.D[1], X5
    FMOV  D5, X5
    FMOV  V5.D[1], X14
    FMOV  D6, X24
    FMOV  V6.D[1], X21
    FMOV  D7, X7
    FMOV  V7.D[1], X4
    FMOV  D8, X4
    FMOV  V8.D[1], X6
    FMOV  D9, X11
    FMOV  V9.D[1], X13
    FMOV  D10, X25
    FMOV  V10.D[1], X22
    FMOV  D11, X16
    FMOV  V11.D[1], X3
    FMOV  D12, X19
    FMOV  V12.D[1], X3
    FMOV  D13, X24
    FMOV  V13.D[1], X5
    FMOV  D14, X16
TaishanSimdImmP01_label_44:
    FMOV  V14.D[1], X12
    FMOV  D15, X14
    FMOV  V15.D[1], X12
    FMOV  D16, X12
    FMOV  V16.D[1], X18
    FMOV  D17, X6
    FMOV  V17.D[1], X27
    FMOV  D18, X11
    FMOV  V18.D[1], X22
    FMOV  D19, X10
    FMOV  V19.D[1], X26
    FMOV  D20, X13
    FMOV  V20.D[1], X10
    FMOV  D21, X14
    FMOV  V21.D[1], X4
    FMOV  D22, X25
    FMOV  V22.D[1], X2
    FMOV  D23, X13
    FMOV  V23.D[1], X18
    FMOV  D24, X26
    FMOV  V24.D[1], X11
    FMOV  D25, X11
    FMOV  V25.D[1], X19
    FMOV  D26, X14
    FMOV  V26.D[1], X25
    FMOV  D27, X9
    FMOV  V27.D[1], X6
    FMOV  D28, X18
    FMOV  V28.D[1], X3
    FMOV  D29, X29
    FMOV  V29.D[1], X24
    FMOV  D30, X27
    FMOV  V30.D[1], X7
    FMOV  D31, X18
    FMOV  V31.D[1], X4
    MOVZ  X14, #0xa, LSL #0
TaishanSimdImmP01_label_1128:
    ADDP  V6.16B, V9.16B, V27.16B
    ADDV  S26, V21.4S
    ADDP  D5, V4.2D
    ADDV  S22, V27.4S
    ADDV  B1, V29.8B
    ADDHN2  V12.16B, V25.8H, V26.8H
    ADDV  H19, V28.4H
    ADDP  V3.16B, V16.16B, V4.16B
    ADD  V1.4S, V28.4S, V23.4S
    ADDP  V12.4H, V17.4H, V15.4H
    ADDHN2  V19.16B, V4.8H, V18.8H
    ADDP  D31, V3.2D
    ADD  D6, D3, D30
    ADD  V13.8B, V27.8B, V14.8B
    ADDP  V24.4S, V10.4S, V6.4S
    ADDV  S0, V10.4S
    ADD  V15.8H, V14.8H, V11.8H
    ADD  V18.4H, V5.4H, V16.4H
    ADDHN  V31.2S, V1.2D, V24.2D
    ADDV  S0, V24.4S
    ADDV  H9, V27.8H
    ADDP  V5.4H, V5.4H, V2.4H
    ADD  D1, D2, D3
    ADDP  D29, V9.2D
    ADDP  V28.2D, V9.2D, V2.2D
    ADD  V23.8B, V0.8B, V8.8B
    ADD  D2, D11, D4
    ADD  V16.4S, V19.4S, V14.4S
    ADDHN  V31.2S, V14.2D, V29.2D
    ADDP  V25.4H, V23.4H, V9.4H
    ADDP  V14.2D, V2.2D, V23.2D
    ADDHN  V11.4H, V22.4S, V9.4S
    ADDV  H29, V5.8H
    ADDHN2  V29.16B, V18.8H, V17.8H
    ADDP  D20, V4.2D
    ADDHN  V15.2S, V9.2D, V21.2D
    ADDV  S31, V12.4S
    ADDV  H20, V4.4H
    ADDHN2  V29.4S, V28.2D, V29.2D
    ADD  V6.8B, V29.8B, V15.8B
    ADDV  B24, V22.16B
    ADDP  D3, V18.2D
    ADDP  D9, V22.2D
    ADD  D21, D8, D8
    ADD  V25.2D, V8.2D, V18.2D
    ADDV  H3, V30.8H
    ADDHN  V14.2S, V11.2D, V3.2D
    ADDV  B18, V12.16B
    ADDHN2  V24.4S, V4.2D, V12.2D
    ADDV  S22, V24.4S
    ADDV  H13, V21.8H
    ADDHN  V9.8B, V4.8H, V5.8H
    ADD  V27.8H, V9.8H, V4.8H
    ADDP  V15.8B, V22.8B, V1.8B
    ADDHN2  V20.4S, V9.2D, V31.2D
    ADDP  V2.4H, V26.4H, V24.4H
    ADD  V8.8B, V7.8B, V5.8B
    ADDV  S13, V6.4S
    ADDP  D24, V17.2D
    ADDP  V3.8B, V12.8B, V12.8B
    ADD  V13.2D, V30.2D, V28.2D
    ADD  D10, D24, D6
    ADDP  D14, V24.2D
    ADDV  H9, V1.4H
    ADDV  H0, V1.8H
    ADD  V15.2D, V13.2D, V10.2D
    ADDHN2  V18.4S, V2.2D, V6.2D
    ADD  D11, D6, D14
    ADDV  S11, V4.4S
    ADD  V27.8B, V9.8B, V23.8B
    ADDP  D21, V22.2D
    ADDHN  V18.8B, V15.8H, V1.8H
    ADD  V9.8B, V1.8B, V4.8B
    ADDV  B20, V31.16B
    ADDV  S3, V3.4S
    ADD  D8, D8, D31
    ADD  D3, D21, D12
    ADDHN2  V3.8H, V9.4S, V9.4S
    ADDV  H21, V0.8H
    ADDV  H28, V22.4H
    ADD  D17, D2, D3
    ADDP  V6.16B, V27.16B, V26.16B
    ADDV  H11, V11.4H
    ADD  V3.16B, V6.16B, V25.16B
    ADD  V24.4H, V12.4H, V7.4H
    ADD  V8.4H, V14.4H, V2.4H
    ADD  D5, D12, D8
    ADDV  H16, V16.8H
    ADDV  B26, V0.16B
    ADDHN  V5.2S, V16.2D, V26.2D
    ADDV  B24, V17.16B
    ADDV  S21, V7.4S
    ADDV  S15, V20.4S
    ADDV  B17, V25.8B
    ADDP  D28, V9.2D
    ADDHN  V15.8B, V29.8H, V11.8H
    ADD  D4, D20, D1
    ADDHN  V11.4H, V23.4S, V23.4S
    ADDV  H30, V29.8H
    ADD  D2, D0, D28
    ADDV  B15, V30.8B
    ADDV  S29, V1.4S
    ADDV  S15, V20.4S
    ADDP  V5.2D, V12.2D, V1.2D
    ADDP  V26.4S, V20.4S, V24.4S
    ADDHN2  V15.8H, V14.4S, V26.4S
    ADDV  H2, V20.8H
    ADD  V29.8B, V23.8B, V18.8B
    ADDV  S4, V28.4S
    ADDV  S27, V26.4S
    ADD  V13.4H, V7.4H, V0.4H
    ADDP  D24, V20.2D
    ADDV  B25, V20.16B
    ADDV  S1, V15.4S
    ADDV  B28, V12.16B
    ADD  D28, D26, D9
    ADDP  V7.8B, V23.8B, V12.8B
    ADDV  H14, V11.8H
TaishanSimdImmP01_label_131:
    ADDV  S6, V15.4S
    ADDHN2  V28.4S, V21.2D, V24.2D
    ADDV  B5, V0.16B
TaishanSimdImmP01_label_861:
    ADDV  S4, V12.4S
    ADDHN2  V24.4S, V20.2D, V2.2D
    ADDV  B27, V30.16B
    ADDV  B21, V27.16B
    ADD  V4.2S, V2.2S, V14.2S
    ADD  V16.4H, V6.4H, V27.4H
    ADDV  S20, V13.4S
    ADD  V19.8B, V24.8B, V0.8B
    ADDP  V31.4H, V12.4H, V1.4H
    ADDHN  V7.4H, V7.4S, V10.4S
    ADD  D12, D9, D21
    ADDP  V16.8H, V27.8H, V11.8H
    ADDP  V21.8B, V27.8B, V26.8B
    ADDV  B13, V4.8B
    ADDP  V11.8B, V24.8B, V13.8B
    ADDV  S15, V24.4S
    ADDP  V31.2D, V26.2D, V24.2D
    ADD  D15, D23, D11
    ADDP  D25, V14.2D
    ADDHN  V21.4H, V5.4S, V11.4S
    ADDHN  V21.2S, V4.2D, V10.2D
    ADDP  V0.16B, V7.16B, V26.16B
    ADDHN2  V20.4S, V6.2D, V19.2D
    ADD  V11.2D, V15.2D, V1.2D
    ADDV  S10, V3.4S
    ADDV  B4, V30.16B
    ADDV  H6, V26.4H
    ADDV  S16, V18.4S
    ADDHN2  V13.4S, V23.2D, V13.2D
    ADDHN2  V11.8H, V12.4S, V19.4S
    ADDV  S21, V9.4S
    ADDHN  V24.2S, V11.2D, V23.2D
    ADD  D13, D13, D16
    ADD  V0.2D, V28.2D, V31.2D
    ADD  V0.8B, V18.8B, V4.8B
    ADDV  S16, V19.4S
    ADD  D0, D21, D9
    ADD  D7, D20, D19
    ADDP  D7, V6.2D
    ADDV  S29, V3.4S
    ADDV  S29, V10.4S
    ADD  D12, D4, D9
    ADD  D23, D29, D27
    ADDV  H22, V30.4H
    ADDHN  V15.2S, V15.2D, V26.2D
    ADDP  D0, V5.2D
    ADDHN  V10.2S, V5.2D, V13.2D
    ADDP  V12.4H, V14.4H, V8.4H
    ADDHN  V8.8B, V12.8H, V29.8H
    ADDV  H17, V17.4H
    ADD  V27.16B, V16.16B, V24.16B
    ADDV  H18, V28.4H
    ADDHN2  V18.16B, V16.8H, V18.8H
    ADDP  V24.8B, V8.8B, V13.8B
    ADD  V28.8H, V16.8H, V18.8H
    ADDHN  V24.2S, V8.2D, V19.2D
    ADDHN  V19.4H, V2.4S, V22.4S
    ADD  D3, D3, D19
    ADDV  B7, V24.16B
    ADD  V25.4H, V1.4H, V2.4H
    ADDP  D14, V26.2D
    ADD  V2.8B, V10.8B, V26.8B
    ADD  D3, D4, D27
    ADDP  D24, V17.2D
    ADDP  V8.8B, V30.8B, V21.8B
    ADDV  H29, V18.4H
    ADDP  D10, V10.2D
    ADDP  V5.4H, V3.4H, V19.4H
    ADDV  H17, V26.8H
    ADD  D3, D10, D17
    ADDP  V4.8B, V29.8B, V4.8B
    ADDHN2  V22.4S, V5.2D, V18.2D
    ADDHN2  V13.16B, V25.8H, V25.8H
    ADD  D11, D18, D18
    ADDP  V21.2D, V4.2D, V4.2D
    ADDHN  V18.8B, V21.8H, V8.8H
    ADDHN  V22.2S, V21.2D, V8.2D
    ADDHN  V12.8B, V19.8H, V22.8H
    ADD  V27.4H, V24.4H, V31.4H
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdImmP01_label_1128
    MOVZ  X5, #0xf053, LSL #0
    MOVK  X5, #0xe101, LSL #16
    MOVK  X5, #0xaae8, LSL #32
    MOVK  X5, #0xd469, LSL #48
    SUB  X13, X5, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0xaeeb, LSL #0
    MOVK  X14, #0xc014, LSL #16
    MOVK  X14, #0xe4e5, LSL #32
    MOVK  X14, #0x6d34, LSL #48
    SUB  X3, X14, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x151a, LSL #0
    MOVK  X24, #0x53a7, LSL #16
    MOVK  X24, #0xf2d5, LSL #32
    MOVK  X24, #0xae52, LSL #48
TaishanSimdImmP01_label_1091:
    SUB  X27, X24, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xf053, LSL #0
    MOVK  X2, #0xe101, LSL #16
    MOVK  X2, #0xaae8, LSL #32
    MOVK  X2, #0xd469, LSL #48
    SUB  X25, X2, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x3d58, LSL #0
    MOVK  X7, #0x42db, LSL #16
    MOVK  X7, #0xd562, LSL #32
    MOVK  X7, #0x8093, LSL #48
    SUB  X26, X7, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x3d58, LSL #0
    MOVK  X15, #0x42db, LSL #16
    MOVK  X15, #0xd562, LSL #32
    MOVK  X15, #0x8093, LSL #48
    SUB  X24, X15, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xa840, LSL #0
    MOVK  X13, #0x80ae, LSL #16
    MOVK  X13, #0xeb31, LSL #32
    MOVK  X13, #0xbaa3, LSL #48
    SUB  X14, X13, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0xc75e, LSL #0
    MOVK  X20, #0xbb37, LSL #16
    MOVK  X20, #0xf404, LSL #32
    MOVK  X20, #0x5bb6, LSL #48
    SUB  X25, X20, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x4c0c, LSL #0
    MOVK  X13, #0x9e9e, LSL #16
    MOVK  X13, #0x3108, LSL #32
    MOVK  X13, #0xbc52, LSL #48
    SUB  X5, X13, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xf386, LSL #0
    MOVK  X7, #0x160c, LSL #16
    MOVK  X7, #0xdef0, LSL #32
    MOVK  X7, #0x8f6d, LSL #48
    SUB  X14, X7, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x569, LSL #0
    MOVK  X9, #0x2f11, LSL #16
    MOVK  X9, #0xea72, LSL #32
    MOVK  X9, #0x79e7, LSL #48
    SUB  X29, X9, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x4c0c, LSL #0
    MOVK  X11, #0x9e9e, LSL #16
    MOVK  X11, #0x3108, LSL #32
    MOVK  X11, #0xbc52, LSL #48
    SUB  X26, X11, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x3d58, LSL #0
    MOVK  X25, #0x42db, LSL #16
    MOVK  X25, #0xd562, LSL #32
    MOVK  X25, #0x8093, LSL #48
    SUB  X17, X25, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x6acb, LSL #0
    MOVK  X19, #0xeee3, LSL #16
    MOVK  X19, #0x5fe7, LSL #32
    MOVK  X19, #0xa679, LSL #48
    SUB  X5, X19, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0xf959, LSL #0
    MOVK  X16, #0x5f85, LSL #16
    MOVK  X16, #0xab54, LSL #32
    MOVK  X16, #0x3d94, LSL #48
    SUB  X6, X16, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0xc75e, LSL #0
    MOVK  X15, #0xbb37, LSL #16
    MOVK  X15, #0xf404, LSL #32
    MOVK  X15, #0x5bb6, LSL #48
    SUB  X4, X15, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xc54f, LSL #0
    MOVK  X7, #0xb010, LSL #16
    MOVK  X7, #0x9a38, LSL #32
    MOVK  X7, #0xdfe5, LSL #48
    SUB  X26, X7, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x614a, LSL #0
    MOVK  X24, #0xa329, LSL #16
    MOVK  X24, #0xe0c1, LSL #32
    MOVK  X24, #0xecd9, LSL #48
    SUB  X11, X24, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x614a, LSL #0
    MOVK  X21, #0xa329, LSL #16
    MOVK  X21, #0xe0c1, LSL #32
    MOVK  X21, #0xecd9, LSL #48
    SUB  X26, X21, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x3d58, LSL #0
    MOVK  X26, #0x42db, LSL #16
    MOVK  X26, #0xd562, LSL #32
    MOVK  X26, #0x8093, LSL #48
    SUB  X12, X26, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x3d58, LSL #0
    MOVK  X14, #0x42db, LSL #16
    MOVK  X14, #0xd562, LSL #32
    MOVK  X14, #0x8093, LSL #48
    SUB  X21, X14, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0xfa85, LSL #0
    MOVK  X13, #0x6f0f, LSL #16
    MOVK  X13, #0x7f22, LSL #32
    MOVK  X13, #0x50fa, LSL #48
    SUB  X4, X13, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X28, D2
    MOVZ  X21, #0xbc, LSL #0
    SUB  X26, X21, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X24, D3
    MOVZ  X13, #0x13e, LSL #0
    SUB  X5, X13, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X7, D4
    MOVZ  X24, #0xbf, LSL #0
    MOVK  X24, #0xa9, LSL #32
    SUB  X28, X24, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
TaishanSimdImmP01_label_1029:
    FMOV  X7, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X7, D5
    MOVZ  X20, #0x363, LSL #0
    SUB  X11, X20, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X18, D6
    MOVZ  X19, #0xbc, LSL #0
    SUB  X25, X19, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X15, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X11, D8
    MOVZ  X22, #0xa9, LSL #0
    MOVK  X22, #0x3, LSL #32
    SUB  X26, X22, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X19, D9
    MOVZ  X15, #0x16a, LSL #0
    MOVK  X15, #0x97, LSL #32
    SUB  X6, X15, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X18, D10
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X6, D11
    MOVZ  X27, #0x57a, LSL #0
    SUB  X12, X27, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X18, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X5, #0x2, LSL #0
    SUB  X10, X5, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X16, D13
    MOVZ  X5, #0xc2, LSL #0
    SUB  X10, X5, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X9, D14
    MOVZ  X12, #0x13e, LSL #0
    SUB  X3, X12, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X16, D15
    MOVZ  X5, #0x152, LSL #0
    SUB  X6, X5, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X11, D16
    MOVZ  X7, #0x1d2, LSL #0
    SUB  X29, X7, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X20, D17
    MOVZ  X4, #0x13e, LSL #0
    SUB  X12, X4, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X17, D18
    MOVZ  X26, #0x1, LSL #0
    SUB  X27, X26, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X11, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X13, D20
    MOVZ  X18, #0x116, LSL #0
    SUB  X11, X18, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X10, #0xbf, LSL #0
    MOVK  X10, #0xa9, LSL #32
    SUB  X27, X10, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X11, D21
    MOVZ  X10, #0xbf, LSL #0
    MOVK  X10, #0xa9, LSL #32
    SUB  X27, X10, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X18, D22
    MOVZ  X26, #0xac, LSL #0
    MOVK  X26, #0xa9, LSL #32
    SUB  X29, X26, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X17, D24
    MOVZ  X2, #0x73, LSL #0
    SUB  X13, X2, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X15, D25
    MOVZ  X29, #0x178, LSL #0
    SUB  X28, X29, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X11, #0x82, LSL #0
    SUB  X27, X11, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X14, D26
    MOVZ  X11, #0xbc, LSL #0
    SUB  X27, X11, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X14, D27
    MOVZ  X18, #0x1b1, LSL #0
    SUB  X8, X18, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X8, #0x4, LSL #0
    SUB  X6, X8, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X4, D28
    MOVZ  X8, #0x48f, LSL #0
    SUB  X6, X8, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X4, D29
    MOVZ  X3, #0x2bd, LSL #0
    SUB  X6, X3, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X11
    FMOV  V0.D[1], X6
    FMOV  D1, X6
    FMOV  V1.D[1], X11
    FMOV  D2, X10
    FMOV  V2.D[1], X6
    FMOV  D3, X2
    FMOV  V3.D[1], X6
    FMOV  D4, X19
    FMOV  V4.D[1], X11
    FMOV  D5, X6
    FMOV  V5.D[1], X20
    FMOV  D6, X13
    FMOV  V6.D[1], X28
    FMOV  D7, X29
    FMOV  V7.D[1], X9
    FMOV  D8, X26
    FMOV  V8.D[1], X27
    FMOV  D9, X2
    FMOV  V9.D[1], X15
    FMOV  D10, X21
    FMOV  V10.D[1], X24
    FMOV  D11, X14
    FMOV  V11.D[1], X28
    FMOV  D12, X5
    FMOV  V12.D[1], X20
    FMOV  D13, X25
    FMOV  V13.D[1], X9
    FMOV  D14, X27
    FMOV  V14.D[1], X27
    FMOV  D15, X10
    FMOV  V15.D[1], X7
    FMOV  D16, X22
    FMOV  V16.D[1], X2
    FMOV  D17, X26
    FMOV  V17.D[1], X21
    FMOV  D18, X24
    FMOV  V18.D[1], X5
    FMOV  D19, X3
    FMOV  V19.D[1], X25
    FMOV  D20, X8
    FMOV  V20.D[1], X16
    FMOV  D21, X15
    FMOV  V21.D[1], X7
    FMOV  D22, X25
    FMOV  V22.D[1], X11
    FMOV  D23, X13
    FMOV  V23.D[1], X5
    FMOV  D24, X2
    FMOV  V24.D[1], X3
    FMOV  D25, X6
    FMOV  V25.D[1], X16
    FMOV  D26, X14
    FMOV  V26.D[1], X11
    FMOV  D27, X2
    FMOV  V27.D[1], X4
    FMOV  D28, X24
    FMOV  V28.D[1], X18
    FMOV  D29, X14
    FMOV  V29.D[1], X9
    FMOV  D30, X5
    FMOV  V30.D[1], X10
    FMOV  D31, X27
    FMOV  V31.D[1], X7
    MOVZ  X22, #0xa, LSL #0
TaishanSimdImmP01_label_1193:
    ADDV  S31, V0.4S
    ADDP  D17, V24.2D
    ADD  D26, D2, D14
    ADDHN  V11.8B, V29.8H, V19.8H
    ADD  D27, D26, D30
    ADDV  B2, V7.8B
    ADDP  D27, V3.2D
    ADD  V18.8H, V10.8H, V27.8H
    ADD  D11, D13, D23
    ADDV  H22, V31.8H
    ADD  D20, D2, D27
    ADDHN2  V12.4S, V30.2D, V4.2D
    ADDHN  V22.4H, V23.4S, V11.4S
    ADDP  V9.2S, V15.2S, V20.2S
    ADDHN2  V21.8H, V31.4S, V0.4S
    ADD  D8, D6, D18
    ADD  V9.2S, V14.2S, V7.2S
    ADDP  D27, V17.2D
    ADDHN  V12.8B, V3.8H, V10.8H
    ADDHN  V14.8B, V4.8H, V22.8H
    ADDHN2  V21.4S, V8.2D, V13.2D
    ADDV  B26, V30.8B
    ADDV  H2, V3.4H
    ADDP  V4.2S, V2.2S, V1.2S
    ADDP  D26, V21.2D
    ADD  D22, D5, D8
    ADDV  H7, V12.4H
    ADDV  S24, V27.4S
    ADD  D19, D16, D9
    ADDHN  V12.4H, V3.4S, V10.4S
    ADDV  H0, V0.8H
    ADD  D21, D29, D30
    ADDHN  V0.8B, V9.8H, V17.8H
    ADDP  D22, V4.2D
    ADD  D4, D9, D24
    ADDHN2  V9.4S, V2.2D, V23.2D
    ADD  V6.4S, V9.4S, V10.4S
    ADD  D29, D11, D6
    ADDP  V14.4S, V0.4S, V15.4S
    ADDV  S20, V5.4S
    ADDHN  V27.4H, V21.4S, V23.4S
    ADDV  H22, V5.8H
    ADDP  V8.2D, V26.2D, V22.2D
    ADD  V11.4S, V19.4S, V14.4S
    ADDV  B20, V17.8B
    ADDV  H5, V31.4H
    ADDHN  V22.4H, V12.4S, V22.4S
    ADDP  V21.2S, V26.2S, V27.2S
    ADDV  B2, V3.8B
    ADD  V29.4H, V27.4H, V21.4H
    ADDHN2  V26.8H, V30.4S, V14.4S
    ADDV  H29, V17.4H
    ADDV  S11, V6.4S
    ADDP  D18, V17.2D
    ADDV  S19, V23.4S
    ADD  V12.2S, V26.2S, V0.2S
    ADD  D11, D22, D0
    ADDP  D3, V2.2D
    ADDP  D5, V1.2D
    ADDHN2  V10.4S, V18.2D, V3.2D
    ADDP  V20.4H, V11.4H, V11.4H
    ADD  V31.16B, V14.16B, V31.16B
    ADDHN  V28.4H, V27.4S, V11.4S
    ADDHN2  V28.8H, V1.4S, V8.4S
    ADD  V5.4H, V28.4H, V9.4H
    ADDHN2  V15.8H, V15.4S, V12.4S
    ADDV  H4, V19.8H
    ADDV  B11, V26.16B
    ADDHN2  V29.4S, V11.2D, V26.2D
    ADDHN2  V11.8H, V18.4S, V27.4S
    ADDV  H12, V0.8H
    ADDP  D21, V31.2D
    ADDV  H28, V28.4H
    ADD  D31, D12, D12
    ADDV  S13, V20.4S
    ADDV  H11, V1.4H
    ADDHN  V31.2S, V2.2D, V3.2D
    ADD  V26.16B, V30.16B, V5.16B
    ADDP  V21.4H, V5.4H, V8.4H
    ADD  D5, D12, D8
    ADD  V6.4H, V21.4H, V0.4H
    ADDHN  V16.8B, V18.8H, V27.8H
    ADDV  S8, V29.4S
    ADDV  B9, V12.8B
    ADDP  V0.2S, V26.2S, V28.2S
    ADDP  D6, V18.2D
    ADDV  H0, V12.8H
    ADDP  D25, V19.2D
    ADDHN  V26.2S, V31.2D, V15.2D
    ADD  V11.4S, V11.4S, V5.4S
    ADD  V23.4H, V10.4H, V6.4H
    ADDV  H0, V7.8H
    ADDV  S18, V25.4S
    ADDV  H26, V23.8H
    ADDV  B21, V13.8B
    ADDP  V21.4H, V17.4H, V2.4H
    ADDHN  V21.4H, V21.4S, V4.4S
    ADDHN2  V13.4S, V15.2D, V9.2D
    ADDV  S20, V27.4S
    ADD  D24, D11, D12
    ADDV  S24, V11.4S
    ADDP  V28.4H, V6.4H, V21.4H
    ADDV  S16, V28.4S
    ADD  D18, D16, D4
    ADD  D5, D3, D29
    ADDHN2  V13.16B, V30.8H, V23.8H
    ADDHN  V26.2S, V26.2D, V30.2D
    ADD  D31, D21, D12
    ADDV  B25, V16.16B
    ADDV  B7, V19.16B
    ADDHN  V20.8B, V12.8H, V18.8H
    ADDHN2  V31.16B, V24.8H, V27.8H
    ADDHN  V23.4H, V3.4S, V27.4S
    ADD  D31, D12, D14
    ADDV  S2, V27.4S
    ADDV  S13, V10.4S
    ADDV  H30, V23.8H
    ADD  V0.8H, V5.8H, V10.8H
    ADDV  H19, V29.4H
    ADDV  H29, V19.8H
    ADD  V20.16B, V30.16B, V14.16B
    ADDHN2  V13.8H, V2.4S, V31.4S
    ADDV  S9, V4.4S
    ADDV  H22, V17.4H
    ADDV  S9, V19.4S
    ADD  V22.8H, V23.8H, V4.8H
    ADDP  D10, V7.2D
    ADDV  B9, V31.16B
    ADDV  S19, V11.4S
    ADDHN  V24.4H, V9.4S, V0.4S
    ADDV  H10, V13.4H
    ADDV  H18, V11.4H
    ADDP  V6.16B, V15.16B, V25.16B
    ADDV  S4, V30.4S
    ADDHN  V31.4H, V21.4S, V27.4S
    ADDV  H30, V11.8H
    ADDV  S7, V11.4S
    ADDHN2  V9.16B, V13.8H, V15.8H
    ADDV  B26, V25.8B
    ADDP  D2, V21.2D
    ADDP  V21.2S, V8.2S, V2.2S
    ADDHN2  V15.16B, V18.8H, V14.8H
    ADDV  B21, V0.16B
    ADD  V29.4S, V19.4S, V31.4S
    ADDHN2  V23.8H, V0.4S, V6.4S
    ADDV  B27, V22.16B
    ADDP  V31.8H, V29.8H, V4.8H
    ADD  V11.4S, V19.4S, V25.4S
    ADDP  D18, V25.2D
    ADD  V14.8B, V21.8B, V15.8B
    ADD  D23, D6, D29
    ADDV  B15, V11.8B
    ADDV  B30, V2.8B
    ADDV  S23, V24.4S
    ADDP  V23.4S, V2.4S, V20.4S
    ADDV  B8, V15.8B
    ADDHN  V27.8B, V30.8H, V19.8H
    ADDV  H20, V28.4H
    ADDHN  V14.2S, V11.2D, V31.2D
    ADDV  B22, V7.8B
    ADDHN  V27.8B, V16.8H, V4.8H
    ADDP  D12, V9.2D
    ADDHN2  V26.8H, V9.4S, V0.4S
    ADDP  D2, V20.2D
    ADDP  V5.2D, V0.2D, V31.2D
    ADDV  H1, V14.4H
    ADDV  B28, V25.8B
    ADDP  V21.4S, V18.4S, V18.4S
    ADDV  H22, V3.8H
    ADDV  S18, V24.4S
    ADDP  D8, V27.2D
    ADDHN2  V30.4S, V9.2D, V15.2D
    ADDP  D22, V1.2D
    ADD  D16, D12, D13
    ADD  V11.8H, V29.8H, V19.8H
    ADD  V24.2S, V8.2S, V19.2S
    ADDHN  V29.2S, V24.2D, V27.2D
    ADD  D18, D11, D8
    ADDV  S5, V25.4S
    ADDV  H31, V15.8H
    ADDHN  V30.8B, V31.8H, V19.8H
    ADDV  S9, V26.4S
    ADDP  V23.4H, V22.4H, V22.4H
    ADDV  H5, V12.4H
    ADD  D16, D1, D23
    ADD  D5, D12, D28
    ADDHN2  V18.16B, V25.8H, V12.8H
    ADDV  B5, V19.8B
    ADDP  D30, V18.2D
    ADDV  B25, V4.16B
    ADDP  V0.4S, V12.4S, V15.4S
    ADDV  H8, V25.4H
    ADDHN2  V11.4S, V12.2D, V11.2D
    ADDV  S18, V12.4S
TaishanSimdImmP01_label_115:
    ADDHN  V15.8B, V15.8H, V25.8H
    ADDHN  V20.2S, V6.2D, V8.2D
    ADDHN  V19.8B, V18.8H, V27.8H
    ADDV  S24, V27.4S
    ADDV  B15, V27.16B
    ADDV  B5, V30.8B
    SUBS  X22, X22, #0x1
    B.NE  TaishanSimdImmP01_label_1193
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X16
TaishanSimdImmP01_label_869:
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X6, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X29, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X2, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X20, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X19, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X19, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X25, D8
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X24, D9
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X17, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X7, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X13, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X21, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X21, D14
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X18, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X18, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X11, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X21, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X28, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X7, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X13, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X8, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X2, D24
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X5, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X27, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X25, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X21, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X11, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
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
    FMOV  D0, X7
    FMOV  V0.D[1], X25
    FMOV  D1, X21
    FMOV  V1.D[1], X8
    FMOV  D2, X18
    FMOV  V2.D[1], X11
    FMOV  D3, X20
    FMOV  V3.D[1], X19
    FMOV  D4, X4
    FMOV  V4.D[1], X10
    FMOV  D5, X29
    FMOV  V5.D[1], X2
    FMOV  D6, X6
    FMOV  V6.D[1], X27
    FMOV  D7, X28
    FMOV  V7.D[1], X28
    FMOV  D8, X6
    FMOV  V8.D[1], X7
    FMOV  D9, X22
    FMOV  V9.D[1], X26
    FMOV  D10, X16
    FMOV  V10.D[1], X9
    FMOV  D11, X20
    FMOV  V11.D[1], X6
    FMOV  D12, X16
    FMOV  V12.D[1], X10
    FMOV  D13, X19
    FMOV  V13.D[1], X5
    FMOV  D14, X5
    FMOV  V14.D[1], X8
    FMOV  D15, X16
    FMOV  V15.D[1], X16
    FMOV  D16, X26
    FMOV  V16.D[1], X24
    FMOV  D17, X19
    FMOV  V17.D[1], X11
    FMOV  D18, X18
    FMOV  V18.D[1], X28
    FMOV  D19, X26
    FMOV  V19.D[1], X16
    FMOV  D20, X16
    FMOV  V20.D[1], X4
    FMOV  D21, X7
    FMOV  V21.D[1], X24
    FMOV  D22, X12
    FMOV  V22.D[1], X4
    FMOV  D23, X15
    FMOV  V23.D[1], X7
    FMOV  D24, X4
    FMOV  V24.D[1], X20
    FMOV  D25, X21
    FMOV  V25.D[1], X8
    FMOV  D26, X9
    FMOV  V26.D[1], X8
    FMOV  D27, X10
    FMOV  V27.D[1], X13
    FMOV  D28, X29
    FMOV  V28.D[1], X8
    FMOV  D29, X7
    FMOV  V29.D[1], X3
    FMOV  D30, X6
    FMOV  V30.D[1], X9
    FMOV  D31, X21
    FMOV  V31.D[1], X10
    MOVZ  X11, #0xf, LSL #0
TaishanSimdImmP01_label_1263:
    ADDV  S23, V30.4S
    ADDV  S7, V18.4S
    ADD  D23, D26, D17
    ADDP  D13, V26.2D
    ADDP  V24.16B, V24.16B, V11.16B
    ADDV  H5, V28.4H
    ADDP  V4.2D, V29.2D, V22.2D
    ADDP  D7, V1.2D
    ADD  D23, D22, D3
    ADD  D6, D24, D27
    ADDHN  V7.4H, V7.4S, V2.4S
    ADDV  S8, V2.4S
    ADD  V6.2S, V8.2S, V3.2S
    ADD  D2, D7, D1
    ADDP  D1, V2.2D
    ADDV  B28, V9.8B
    ADDP  D28, V27.2D
    ADD  D9, D5, D25
    ADDHN2  V10.4S, V31.2D, V30.2D
    ADDP  D4, V23.2D
    ADD  D14, D21, D1
    ADDV  B14, V24.8B
    ADDV  H23, V11.8H
    ADDP  V6.8H, V8.8H, V21.8H
    ADDV  S25, V22.4S
    ADDHN2  V12.16B, V13.8H, V21.8H
    ADD  D19, D30, D27
    ADDV  S28, V27.4S
    ADD  D7, D21, D9
    ADDHN  V9.8B, V20.8H, V20.8H
    ADDHN2  V24.16B, V3.8H, V11.8H
    ADDP  D9, V24.2D
    ADD  V18.8B, V26.8B, V19.8B
    ADD  V22.2S, V22.2S, V6.2S
    ADD  D8, D1, D17
    ADD  D9, D2, D31
    ADDP  V19.4S, V13.4S, V18.4S
    ADDHN  V9.4H, V10.4S, V22.4S
    ADDV  H13, V23.4H
    ADDV  B30, V19.8B
    ADDP  V12.4S, V31.4S, V14.4S
    ADD  V20.2D, V17.2D, V25.2D
    ADDHN  V13.4H, V26.4S, V8.4S
    ADDHN  V20.8B, V4.8H, V7.8H
    ADDHN  V25.4H, V4.4S, V31.4S
    ADDP  V5.2S, V8.2S, V12.2S
    ADDHN2  V24.16B, V10.8H, V6.8H
    ADDP  V9.4S, V11.4S, V20.4S
    ADDHN2  V5.8H, V28.4S, V30.4S
    ADDHN  V8.2S, V13.2D, V21.2D
    ADD  V11.8H, V28.8H, V12.8H
    ADDV  B24, V3.8B
    ADDV  H25, V17.4H
    ADDHN2  V25.16B, V9.8H, V25.8H
    ADDHN  V17.4H, V2.4S, V25.4S
    ADDHN  V25.2S, V15.2D, V16.2D
    ADDHN  V25.8B, V4.8H, V23.8H
    ADDP  V4.4H, V25.4H, V28.4H
    ADDHN  V12.2S, V9.2D, V17.2D
    ADDHN  V12.4H, V8.4S, V12.4S
    ADDP  V19.4H, V6.4H, V9.4H
    ADDHN2  V23.4S, V26.2D, V8.2D
    ADDV  H24, V11.4H
    ADD  D23, D25, D8
    ADDP  V4.8H, V19.8H, V19.8H
    ADDV  S20, V24.4S
    ADDHN  V18.8B, V21.8H, V22.8H
    ADD  V28.2S, V29.2S, V6.2S
    ADDV  B13, V15.16B
    ADDHN  V9.2S, V31.2D, V18.2D
    ADDHN2  V20.16B, V3.8H, V10.8H
    ADDV  B28, V25.8B
    ADDV  B28, V19.8B
    ADDHN  V24.8B, V23.8H, V10.8H
    ADDV  S18, V24.4S
    ADDV  B29, V18.16B
    ADDP  V17.2D, V13.2D, V14.2D
    ADDV  B24, V17.16B
    ADD  D16, D12, D0
    ADDV  H1, V14.8H
    ADDHN  V20.8B, V29.8H, V4.8H
    ADD  D31, D28, D31
    ADDP  D28, V18.2D
    ADDHN2  V28.16B, V8.8H, V3.8H
    ADDP  D14, V17.2D
    ADD  V16.8H, V24.8H, V3.8H
    ADDHN  V30.8B, V17.8H, V17.8H
    ADD  V18.2D, V3.2D, V31.2D
    ADDV  B4, V0.8B
    ADDHN2  V28.16B, V8.8H, V24.8H
    ADDHN  V24.2S, V9.2D, V15.2D
    ADD  D4, D12, D30
    ADDV  B11, V31.16B
    ADDHN2  V25.8H, V25.4S, V24.4S
    ADD  V5.2D, V22.2D, V0.2D
    ADDP  V16.8H, V0.8H, V20.8H
    ADDV  H28, V14.4H
    ADDHN  V9.2S, V9.2D, V31.2D
    ADDHN  V18.2S, V31.2D, V18.2D
    ADDHN  V13.2S, V25.2D, V13.2D
    ADDV  H26, V10.8H
    ADDP  D9, V6.2D
    ADDV  S7, V16.4S
    ADDV  S21, V1.4S
    ADDV  B27, V4.16B
    ADDHN  V23.2S, V4.2D, V7.2D
    ADDHN  V25.2S, V3.2D, V7.2D
    ADDP  V16.2D, V30.2D, V26.2D
    ADDHN  V1.2S, V5.2D, V25.2D
    ADDV  S23, V23.4S
    ADDV  B26, V1.16B
    ADDV  B29, V13.8B
    ADDV  B7, V15.16B
    ADD  V0.2S, V10.2S, V8.2S
    ADDHN2  V15.16B, V13.8H, V20.8H
    ADDHN2  V7.8H, V4.4S, V4.4S
    ADDHN2  V0.8H, V15.4S, V15.4S
    ADDV  B18, V0.16B
    ADD  D1, D8, D30
    ADD  D4, D11, D10
    ADD  D10, D24, D23
    ADDV  H3, V29.4H
    ADDHN2  V18.8H, V7.4S, V15.4S
    ADD  V10.16B, V12.16B, V18.16B
    ADDV  B27, V22.16B
    ADDV  H28, V14.4H
    ADDP  V25.2D, V8.2D, V2.2D
    ADDP  D15, V12.2D
    ADD  V12.16B, V7.16B, V16.16B
    ADDHN  V0.4H, V24.4S, V29.4S
    ADDV  B6, V22.16B
    ADD  V0.4H, V31.4H, V0.4H
    ADDV  B25, V14.8B
    ADD  V15.8B, V2.8B, V22.8B
    ADDP  D31, V23.2D
    ADD  D31, D6, D31
    ADDV  H15, V27.4H
    ADDV  B16, V28.16B
    ADDHN2  V29.8H, V27.4S, V6.4S
    ADDV  S21, V17.4S
    ADDV  B3, V18.8B
    ADDV  H13, V12.8H
    ADDHN  V17.4H, V1.4S, V6.4S
    ADDV  H31, V0.4H
    ADDV  H25, V21.4H
    ADDHN2  V26.16B, V17.8H, V4.8H
    ADD  V30.2D, V2.2D, V2.2D
    ADDV  B7, V17.8B
    ADD  D15, D14, D8
    ADDV  H8, V11.4H
    ADDV  H27, V3.8H
    ADDP  D11, V29.2D
    ADDV  B4, V11.8B
    ADDP  V27.2D, V18.2D, V29.2D
    ADDHN2  V25.4S, V31.2D, V23.2D
    ADD  V17.2D, V30.2D, V6.2D
    ADDV  S2, V28.4S
    ADDP  D30, V20.2D
    ADDV  S5, V14.4S
    ADDV  B3, V19.8B
    ADD  D23, D27, D13
    ADDP  V4.2S, V4.2S, V12.2S
    ADD  V20.8B, V2.8B, V19.8B
    ADDV  H6, V13.8H
    ADDHN  V4.2S, V15.2D, V9.2D
    ADDP  V11.8H, V7.8H, V11.8H
    ADDV  B17, V12.8B
    ADD  V29.8B, V1.8B, V12.8B
    ADD  D14, D11, D15
    ADDV  B16, V27.8B
    ADDP  D4, V4.2D
    ADDV  H12, V9.8H
    ADD  V25.8H, V19.8H, V1.8H
    ADD  D28, D5, D16
    ADDHN  V28.4H, V28.4S, V11.4S
    ADD  V25.8B, V27.8B, V9.8B
    ADDHN  V14.4H, V31.4S, V27.4S
    ADDHN  V18.8B, V2.8H, V6.8H
    ADDHN  V23.8B, V3.8H, V26.8H
    ADDP  D25, V23.2D
    ADD  V19.8H, V20.8H, V25.8H
    ADDV  S25, V23.4S
    ADDV  H2, V24.8H
    ADDP  D14, V17.2D
    ADDV  B31, V1.8B
    ADDP  D24, V3.2D
    ADDP  D18, V3.2D
    ADDP  D4, V27.2D
    ADDP  V25.8H, V24.8H, V18.8H
    ADDP  D13, V9.2D
    ADDV  H3, V26.4H
    ADDV  B22, V21.8B
    ADDP  V22.2D, V21.2D, V23.2D
    ADD  D28, D6, D14
    ADDV  B10, V6.16B
    ADDHN2  V10.8H, V19.4S, V23.4S
    ADDV  B19, V22.16B
    ADDV  B26, V19.8B
    ADDHN  V4.2S, V30.2D, V26.2D
    ADDV  S20, V19.4S
    SUBS  X11, X11, #0x1
    B.NE  TaishanSimdImmP01_label_1263
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X7, X14, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X26, X6, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X26, X25, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X14, X11, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X3, X26, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X14, X22, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X18, X9, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X5, X26, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X24, X2, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X3, X26, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X3, X2, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X21, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X12, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X14, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X13, D5
    MOVZ  X9, #0xd0, LSL #0
    SUB  X16, X9, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X19, D6
    MOVZ  X9, #0x174, LSL #0
    SUB  X22, X9, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X2, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X12, D8
    MOVZ  X17, #0x1, LSL #0
    SUB  X16, X17, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X11, D9
    MOVZ  X24, #0xd0, LSL #0
    SUB  X28, X24, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X19, D10
    MOVZ  X8, #0x75, LSL #0
    SUB  X18, X8, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X13, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X25, D12
    MOVZ  X15, #0xd0, LSL #0
    SUB  X8, X15, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X4, D13
    MOVZ  X14, #0xd0, LSL #0
    SUB  X11, X14, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X19, D14
    MOVZ  X26, #0xd1, LSL #0
    SUB  X24, X26, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X10, D15
    MOVZ  X18, #0xd0, LSL #0
    SUB  X27, X18, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X4, D16
    MOVZ  X6, #0xa3, LSL #0
    SUB  X3, X6, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X15, D17
    MOVZ  X9, #0xd1, LSL #0
    SUB  X11, X9, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X9, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X12, D19
    MOVZ  X5, #0xd0, LSL #0
    SUB  X17, X5, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X7, D20
    MOVZ  X19, #0xd0, LSL #0
    SUB  X12, X19, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X12, D21
    MOVZ  X6, #0xd0, LSL #0
    SUB  X3, X6, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X26, D22
    MOVZ  X6, #0xd0, LSL #0
    SUB  X9, X6, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X28, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X10, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X25, D26
    MOVZ  X27, #0xd0, LSL #0
    SUB  X13, X27, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X24, D27
    MOVZ  X20, #0xa3, LSL #0
    SUB  X8, X20, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X5, D28
    MOVZ  X9, #0x245, LSL #0
    SUB  X29, X9, X5
TaishanSimdImmP01_label_850:
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X15, D29
    MOVZ  X13, #0xd2, LSL #0
    SUB  X11, X13, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xfebd, LSL #0
    MOVK  X2, #0x60a9, LSL #16
    MOVK  X2, #0x75ab, LSL #32
    MOVK  X2, #0x8ff5, LSL #48
    MOVZ  X3, #0x5cbf, LSL #0
    MOVK  X3, #0xa141, LSL #16
    MOVK  X3, #0xcca, LSL #32
    MOVK  X3, #0x5e34, LSL #48
    MOVZ  X4, #0x10ff, LSL #0
    MOVK  X4, #0xbc3, LSL #16
    MOVK  X4, #0xab9a, LSL #32
    MOVK  X4, #0xda81, LSL #48
    MOVZ  X5, #0xafa0, LSL #0
    MOVK  X5, #0xd535, LSL #16
    MOVK  X5, #0xd21f, LSL #32
    MOVK  X5, #0x89f0, LSL #48
    MOVZ  X6, #0x704e, LSL #0
    MOVK  X6, #0x4303, LSL #16
    MOVK  X6, #0x8248, LSL #32
    MOVK  X6, #0xc1e, LSL #48
    MOVZ  X7, #0xe39e, LSL #0
    MOVK  X7, #0xe22e, LSL #16
    MOVK  X7, #0xa83f, LSL #32
    MOVK  X7, #0x7a24, LSL #48
    MOVZ  X8, #0x98ca, LSL #0
    MOVK  X8, #0x36a6, LSL #16
    MOVK  X8, #0x8bba, LSL #32
    MOVK  X8, #0x7dbf, LSL #48
    MOVZ  X9, #0xb71f, LSL #0
    MOVK  X9, #0x5187, LSL #16
    MOVK  X9, #0x6c89, LSL #32
    MOVK  X9, #0x7b91, LSL #48
    MOVZ  X10, #0x8ce4, LSL #0
    MOVK  X10, #0x40d6, LSL #16
    MOVK  X10, #0x3eb7, LSL #32
    MOVK  X10, #0xcb1f, LSL #48
    MOVZ  X11, #0x7555, LSL #0
    MOVK  X11, #0xe731, LSL #16
    MOVK  X11, #0xdb2c, LSL #32
    MOVK  X11, #0x3a55, LSL #48
    MOVZ  X12, #0xb29a, LSL #0
    MOVK  X12, #0xc417, LSL #16
    MOVK  X12, #0x71f5, LSL #32
    MOVK  X12, #0x6eaf, LSL #48
    MOVZ  X13, #0xaeb8, LSL #0
    MOVK  X13, #0xdf42, LSL #16
    MOVK  X13, #0x963d, LSL #32
    MOVK  X13, #0xfb54, LSL #48
    MOVZ  X14, #0x2654, LSL #0
    MOVK  X14, #0xadb2, LSL #16
    MOVK  X14, #0xfe49, LSL #32
    MOVK  X14, #0xf319, LSL #48
    MOVZ  X15, #0x8789, LSL #0
    MOVK  X15, #0xaf08, LSL #16
    MOVK  X15, #0x513, LSL #32
    MOVK  X15, #0x4025, LSL #48
    MOVZ  X16, #0x324f, LSL #0
    MOVK  X16, #0xf537, LSL #16
    MOVK  X16, #0xd1eb, LSL #32
    MOVK  X16, #0xb9a0, LSL #48
    MOVZ  X17, #0x40, LSL #0
    MOVK  X17, #0x4de5, LSL #16
    MOVK  X17, #0x7a22, LSL #32
    MOVK  X17, #0xe296, LSL #48
    MOVZ  X18, #0x983b, LSL #0
    MOVK  X18, #0xb385, LSL #16
    MOVK  X18, #0x4c00, LSL #32
    MOVK  X18, #0x905a, LSL #48
    MOVZ  X19, #0x673, LSL #0
    MOVK  X19, #0xe664, LSL #16
    MOVK  X19, #0xc62d, LSL #32
    MOVK  X19, #0x2180, LSL #48
    MOVZ  X20, #0xb86f, LSL #0
    MOVK  X20, #0x1e4e, LSL #16
    MOVK  X20, #0xadaa, LSL #32
    MOVK  X20, #0x749d, LSL #48
    MOVZ  X21, #0x9e3d, LSL #0
    MOVK  X21, #0x34ff, LSL #16
    MOVK  X21, #0xba5b, LSL #32
    MOVK  X21, #0xe82a, LSL #48
    MOVZ  X22, #0xd5be, LSL #0
    MOVK  X22, #0x96cf, LSL #16
    MOVK  X22, #0xb4ba, LSL #32
    MOVK  X22, #0xb87d, LSL #48
    MOVZ  X24, #0x3c6, LSL #0
    MOVK  X24, #0x9e2d, LSL #16
    MOVK  X24, #0xb04d, LSL #32
    MOVK  X24, #0x6db2, LSL #48
    MOVZ  X25, #0x2b28, LSL #0
    MOVK  X25, #0x1d25, LSL #16
    MOVK  X25, #0xdb10, LSL #32
    MOVK  X25, #0x9883, LSL #48
    MOVZ  X26, #0xdb78, LSL #0
    MOVK  X26, #0xca1a, LSL #16
    MOVK  X26, #0xc8e3, LSL #32
    MOVK  X26, #0xbcc8, LSL #48
    MOVZ  X27, #0xf47, LSL #0
    MOVK  X27, #0x31fa, LSL #16
    MOVK  X27, #0xf015, LSL #32
    MOVK  X27, #0xc5b7, LSL #48
    MOVZ  X28, #0x126f, LSL #0
    MOVK  X28, #0xb343, LSL #16
    MOVK  X28, #0x2651, LSL #32
    MOVK  X28, #0x4a03, LSL #48
    MOVZ  X29, #0xa6f0, LSL #0
    MOVK  X29, #0xe9a6, LSL #16
    MOVK  X29, #0x2760, LSL #32
    MOVK  X29, #0x75b1, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X18
    FMOV  D1, X17
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X21
    FMOV  D3, X5
    FMOV  V3.D[1], X29
    FMOV  D4, X26
    FMOV  V4.D[1], X7
    FMOV  D5, X13
    FMOV  V5.D[1], X21
    FMOV  D6, X7
    FMOV  V6.D[1], X28
    FMOV  D7, X12
    FMOV  V7.D[1], X28
    FMOV  D8, X19
    FMOV  V8.D[1], X8
    FMOV  D9, X4
    FMOV  V9.D[1], X11
    FMOV  D10, X15
    FMOV  V10.D[1], X27
    FMOV  D11, X29
    FMOV  V11.D[1], X15
    FMOV  D12, X25
    FMOV  V12.D[1], X17
    FMOV  D13, X28
    FMOV  V13.D[1], X28
    FMOV  D14, X21
    FMOV  V14.D[1], X11
    FMOV  D15, X5
    FMOV  V15.D[1], X7
    FMOV  D16, X7
    FMOV  V16.D[1], X28
    FMOV  D17, X2
    FMOV  V17.D[1], X15
    FMOV  D18, X5
    FMOV  V18.D[1], X13
    FMOV  D19, X21
    FMOV  V19.D[1], X28
    FMOV  D20, X27
    FMOV  V20.D[1], X5
    FMOV  D21, X25
    FMOV  V21.D[1], X27
    FMOV  D22, X17
    FMOV  V22.D[1], X10
    FMOV  D23, X27
    FMOV  V23.D[1], X6
    FMOV  D24, X2
    FMOV  V24.D[1], X2
    FMOV  D25, X25
    FMOV  V25.D[1], X27
    FMOV  D26, X7
    FMOV  V26.D[1], X8
    FMOV  D27, X20
    FMOV  V27.D[1], X5
    FMOV  D28, X6
    FMOV  V28.D[1], X10
    FMOV  D29, X6
    FMOV  V29.D[1], X2
    FMOV  D30, X20
    FMOV  V30.D[1], X26
    FMOV  D31, X10
    FMOV  V31.D[1], X26
    MOVZ  X10, #0xa, LSL #0
TaishanSimdImmP01_label_1336:
    ADDHN2  V25.16B, V3.8H, V23.8H
    ADDV  H22, V4.8H
    ADDP  D29, V31.2D
    ADDV  S19, V29.4S
    ADDP  D30, V17.2D
    ADDHN  V8.4H, V21.4S, V18.4S
    ADDV  H17, V26.8H
    ADDV  B12, V22.8B
    ADDV  S1, V30.4S
    ADDV  S3, V5.4S
    ADDV  H20, V25.8H
    ADDV  B21, V23.8B
    ADDHN  V13.4H, V4.4S, V2.4S
    ADDHN  V20.2S, V15.2D, V21.2D
    ADDV  S24, V19.4S
    ADDP  V23.16B, V12.16B, V8.16B
    ADDP  D15, V22.2D
    ADDHN2  V2.4S, V1.2D, V7.2D
    ADD  D17, D0, D30
    ADDHN  V1.4H, V21.4S, V1.4S
    ADD  V17.8H, V16.8H, V11.8H
    ADD  V3.8H, V4.8H, V21.8H
    ADDV  S11, V3.4S
    ADDV  B13, V6.8B
    ADDHN2  V16.4S, V1.2D, V15.2D
    ADDHN  V17.4H, V16.4S, V21.4S
    ADD  V3.2S, V19.2S, V28.2S
    ADDV  B18, V15.8B
    ADDHN  V28.8B, V17.8H, V11.8H
    ADDHN  V24.8B, V14.8H, V19.8H
    ADD  D29, D3, D5
    ADDV  H28, V3.8H
    ADD  D18, D19, D5
    ADD  V27.16B, V13.16B, V13.16B
    ADDV  S29, V7.4S
    ADDV  S4, V7.4S
    ADDV  S0, V24.4S
    ADDHN2  V14.16B, V26.8H, V20.8H
    ADD  D23, D0, D25
    ADD  V3.8B, V1.8B, V29.8B
    ADDV  S2, V0.4S
    ADDV  H18, V0.8H
    ADD  V1.2D, V6.2D, V7.2D
    ADD  D2, D29, D15
    ADDP  D4, V18.2D
    ADDP  V24.4S, V28.4S, V29.4S
    ADDP  D14, V3.2D
    ADDP  V5.4S, V27.4S, V0.4S
    ADDV  S22, V30.4S
    ADD  D25, D5, D5
    ADDV  H1, V2.4H
    ADDP  V22.8B, V12.8B, V14.8B
    ADD  D28, D23, D24
    ADD  D17, D13, D17
    ADDHN2  V12.16B, V22.8H, V14.8H
    ADDHN  V23.4H, V1.4S, V8.4S
    ADDHN  V23.4H, V22.4S, V27.4S
    ADDV  H26, V30.4H
    ADD  D28, D31, D24
    ADDV  S3, V11.4S
    ADDP  D7, V16.2D
    ADD  D6, D20, D15
    ADDHN2  V3.4S, V18.2D, V18.2D
    ADDP  D22, V9.2D
    ADD  V1.2D, V4.2D, V14.2D
    ADD  V24.2S, V13.2S, V12.2S
    ADDP  D22, V13.2D
    ADDV  H2, V17.4H
    ADDP  V5.8B, V24.8B, V16.8B
    ADD  V7.8B, V22.8B, V5.8B
    ADDV  B11, V9.16B
    ADDV  S16, V20.4S
    ADDHN2  V12.16B, V23.8H, V20.8H
    ADDP  D23, V31.2D
    ADDV  H25, V17.8H
    ADDHN  V16.4H, V13.4S, V16.4S
    ADDHN2  V2.8H, V10.4S, V28.4S
    ADDHN2  V9.8H, V29.4S, V30.4S
    ADDHN  V29.4H, V11.4S, V3.4S
    ADDV  B26, V10.16B
    ADDHN  V5.4H, V4.4S, V21.4S
    ADDV  H4, V22.4H
    ADDP  V22.16B, V13.16B, V25.16B
    ADDV  B10, V21.16B
    ADDV  S7, V2.4S
    ADD  D19, D0, D17
    ADDHN2  V1.16B, V12.8H, V21.8H
    ADDV  B8, V16.16B
    ADDV  H28, V18.8H
    ADD  D7, D10, D12
    ADD  D31, D3, D1
    ADD  D28, D17, D24
    ADDHN2  V1.8H, V23.4S, V20.4S
    ADDV  B7, V2.16B
    ADDV  B2, V24.16B
    ADDP  D6, V6.2D
    ADDV  B2, V17.16B
    ADD  D7, D7, D1
    ADD  D7, D1, D21
    ADDV  S15, V19.4S
    ADD  D20, D10, D6
    ADDV  S21, V20.4S
    ADDP  D10, V7.2D
    ADDHN  V5.8B, V12.8H, V12.8H
    ADDV  S13, V13.4S
    ADDV  H19, V20.8H
    ADDHN2  V15.8H, V6.4S, V25.4S
    ADDV  B21, V23.8B
    ADD  V13.8H, V12.8H, V24.8H
    ADD  V0.8H, V0.8H, V7.8H
    ADDV  S26, V5.4S
    ADDHN2  V17.4S, V2.2D, V23.2D
    ADDV  B23, V20.16B
    ADDHN  V10.8B, V26.8H, V20.8H
    ADD  D7, D8, D31
    ADDV  H24, V21.4H
    ADDP  V8.2D, V13.2D, V19.2D
    ADD  D18, D15, D22
    ADDV  H3, V31.4H
    ADDP  D13, V23.2D
    ADDV  H17, V8.8H
    ADDV  B18, V5.8B
    ADDHN2  V22.16B, V13.8H, V2.8H
    ADDV  H17, V31.8H
    ADDHN  V15.2S, V7.2D, V5.2D
    ADDV  S23, V14.4S
    ADDV  B20, V3.16B
    ADDP  V22.8B, V21.8B, V31.8B
    ADDV  S11, V20.4S
    ADD  V12.16B, V11.16B, V18.16B
    ADDV  S25, V24.4S
    ADDP  D25, V25.2D
    ADDV  H1, V4.4H
    ADD  D12, D6, D19
    ADDV  S6, V29.4S
    ADDV  B15, V0.8B
    ADDV  H6, V10.8H
    ADD  D17, D19, D19
    ADDP  V5.4H, V30.4H, V9.4H
    ADD  V9.2D, V29.2D, V13.2D
    ADD  V25.4H, V17.4H, V18.4H
    ADDV  S10, V13.4S
    ADD  V5.8B, V9.8B, V6.8B
    ADDHN2  V17.4S, V11.2D, V1.2D
    ADDV  S15, V25.4S
    ADDV  S18, V6.4S
    ADDV  S31, V12.4S
    ADDHN2  V18.4S, V23.2D, V19.2D
    ADDV  S31, V11.4S
    ADDHN2  V13.4S, V6.2D, V30.2D
    ADD  V29.8B, V24.8B, V31.8B
    ADDV  H29, V9.4H
    ADDP  V12.2S, V21.2S, V17.2S
    ADDV  B30, V29.8B
    ADDHN2  V26.8H, V9.4S, V22.4S
    ADDV  B12, V0.16B
    ADDHN2  V22.4S, V5.2D, V27.2D
    ADD  V1.4H, V19.4H, V12.4H
    ADDV  B27, V18.8B
    ADDHN2  V13.4S, V3.2D, V28.2D
    ADD  V30.4H, V21.4H, V28.4H
    ADDV  S8, V8.4S
    ADD  V23.4S, V11.4S, V15.4S
    ADDP  V27.2S, V24.2S, V29.2S
    ADD  D13, D4, D8
    ADDHN2  V9.16B, V13.8H, V28.8H
    ADDV  B26, V27.16B
    ADDP  D30, V31.2D
    ADDP  V5.8H, V15.8H, V9.8H
    ADDV  S5, V1.4S
    ADDHN  V17.2S, V23.2D, V10.2D
    ADDV  S23, V15.4S
    ADD  D22, D18, D9
    ADDP  V26.2S, V25.2S, V2.2S
    ADDP  V0.4H, V14.4H, V0.4H
    ADDV  H7, V17.4H
    ADD  D19, D7, D6
    ADDV  H24, V9.4H
    ADDHN2  V15.8H, V20.4S, V26.4S
    ADDP  D17, V15.2D
    ADDP  D30, V19.2D
    ADDV  H20, V11.8H
    ADD  D22, D12, D6
    ADDP  D14, V5.2D
    ADDHN  V25.2S, V22.2D, V9.2D
    ADD  D19, D6, D25
    ADD  D31, D26, D25
    ADDP  D19, V12.2D
    ADDV  H29, V25.4H
    ADDV  B17, V12.16B
    ADDV  H25, V13.4H
    ADD  D24, D17, D5
    ADDV  B2, V9.16B
    ADDP  D0, V9.2D
    ADDV  B20, V20.16B
    ADDV  S8, V11.4S
    ADDV  S31, V18.4S
    ADD  D28, D14, D30
    ADDP  V27.4H, V28.4H, V13.4H
    ADDV  H22, V23.8H
    SUBS  X10, X10, #0x1
    B.NE  TaishanSimdImmP01_label_1336
    MOVZ  X9, #0xfebd, LSL #0
    MOVK  X9, #0x60a9, LSL #16
    MOVK  X9, #0x75ab, LSL #32
    MOVK  X9, #0x8ff5, LSL #48
    SUB  X14, X9, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x5cbf, LSL #0
    MOVK  X7, #0xa141, LSL #16
    MOVK  X7, #0xcca, LSL #32
    MOVK  X7, #0x5e34, LSL #48
    SUB  X28, X7, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x10ff, LSL #0
    MOVK  X28, #0xbc3, LSL #16
    MOVK  X28, #0xab9a, LSL #32
    MOVK  X28, #0xda81, LSL #48
    SUB  X11, X28, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0xafa0, LSL #0
    MOVK  X8, #0xd535, LSL #16
    MOVK  X8, #0xd21f, LSL #32
    MOVK  X8, #0x89f0, LSL #48
    SUB  X14, X8, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x704e, LSL #0
    MOVK  X16, #0x4303, LSL #16
    MOVK  X16, #0x8248, LSL #32
    MOVK  X16, #0xc1e, LSL #48
    SUB  X27, X16, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x5cbf, LSL #0
    MOVK  X8, #0xa141, LSL #16
    MOVK  X8, #0xcca, LSL #32
    MOVK  X8, #0x5e34, LSL #48
    SUB  X6, X8, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0x5cbf, LSL #0
    MOVK  X18, #0xa141, LSL #16
    MOVK  X18, #0xcca, LSL #32
    MOVK  X18, #0x5e34, LSL #48
    SUB  X24, X18, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0xfebd, LSL #0
    MOVK  X8, #0x60a9, LSL #16
    MOVK  X8, #0x75ab, LSL #32
    MOVK  X8, #0x8ff5, LSL #48
    SUB  X12, X8, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0xaeb8, LSL #0
    MOVK  X16, #0xdf42, LSL #16
    MOVK  X16, #0x963d, LSL #32
    MOVK  X16, #0xfb54, LSL #48
    SUB  X12, X16, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x5cbf, LSL #0
    MOVK  X10, #0xa141, LSL #16
    MOVK  X10, #0xcca, LSL #32
    MOVK  X10, #0x5e34, LSL #48
    SUB  X6, X10, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0xd5be, LSL #0
    MOVK  X28, #0x96cf, LSL #16
    MOVK  X28, #0xb4ba, LSL #32
    MOVK  X28, #0xb87d, LSL #48
    SUB  X12, X28, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0xdb78, LSL #0
    MOVK  X9, #0xca1a, LSL #16
    MOVK  X9, #0xc8e3, LSL #32
    MOVK  X9, #0xbcc8, LSL #48
    SUB  X13, X9, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0xd5be, LSL #0
    MOVK  X22, #0x96cf, LSL #16
    MOVK  X22, #0xb4ba, LSL #32
    MOVK  X22, #0xb87d, LSL #48
    SUB  X24, X22, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X26, D2
    MOVZ  X17, #0xc6, LSL #0
    SUB  X19, X17, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X12, D3
    MOVZ  X19, #0xc6, LSL #0
    SUB  X10, X19, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X5, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X9, D5
    MOVZ  X7, #0x18c, LSL #0
    SUB  X27, X7, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X21, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X27, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X15, D8
    MOVZ  X10, #0xc6, LSL #0
    SUB  X25, X10, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X19, D9
    MOVZ  X18, #0xc6, LSL #0
    SUB  X14, X18, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X24, D10
    MOVZ  X18, #0xc6, LSL #0
    SUB  X20, X18, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X9, D11
    MOVZ  X16, #0xc6, LSL #0
    SUB  X7, X16, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X25, D12
    MOVZ  X6, #0xc6, LSL #0
    SUB  X9, X6, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X2, D13
    MOVZ  X26, #0xc6, LSL #0
    SUB  X20, X26, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X11, D14
    MOVZ  X8, #0x18c, LSL #0
    SUB  X5, X8, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X22, D15
    MOVZ  X10, #0x18c, LSL #0
    SUB  X27, X10, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X22, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X19, D17
    MOVZ  X16, #0xc6, LSL #0
    SUB  X6, X16, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X16, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X13, D19
    MOVZ  X17, #0xc6, LSL #0
    SUB  X16, X17, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X9, D20
    MOVZ  X4, #0xc6, LSL #0
    SUB  X13, X4, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X11, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X15, D22
    MOVZ  X4, #0x18c, LSL #0
    SUB  X16, X4, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X28, D24
    MOVZ  X21, #0x252, LSL #0
    SUB  X11, X21, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X4, D25
    MOVZ  X14, #0xc6, LSL #0
    SUB  X18, X14, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X28, D26
    MOVZ  X13, #0x18c, LSL #0
    SUB  X14, X13, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X3, D27
    MOVZ  X26, #0x18c, LSL #0
    MOVK  X26, #0xc6, LSL #32
    SUB  X5, X26, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X7, D28
    MOVZ  X17, #0x18c, LSL #0
    SUB  X19, X17, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X2, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
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
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X4
    FMOV  V0.D[1], X2
    FMOV  D1, X12
    FMOV  V1.D[1], X3
    FMOV  D2, X16
    FMOV  V2.D[1], X17
    FMOV  D3, X11
    FMOV  V3.D[1], X5
    FMOV  D4, X28
    FMOV  V4.D[1], X2
    FMOV  D5, X13
    FMOV  V5.D[1], X11
    FMOV  D6, X26
    FMOV  V6.D[1], X12
    FMOV  D7, X19
    FMOV  V7.D[1], X6
    FMOV  D8, X28
    FMOV  V8.D[1], X27
    FMOV  D9, X10
    FMOV  V9.D[1], X20
    FMOV  D10, X2
    FMOV  V10.D[1], X26
    FMOV  D11, X3
    FMOV  V11.D[1], X6
    FMOV  D12, X16
    FMOV  V12.D[1], X20
    FMOV  D13, X25
    FMOV  V13.D[1], X2
    FMOV  D14, X19
    FMOV  V14.D[1], X4
    FMOV  D15, X2
    FMOV  V15.D[1], X21
    FMOV  D16, X24
    FMOV  V16.D[1], X19
    FMOV  D17, X4
    FMOV  V17.D[1], X21
    FMOV  D18, X17
    FMOV  V18.D[1], X18
    FMOV  D19, X25
    FMOV  V19.D[1], X12
    FMOV  D20, X24
    FMOV  V20.D[1], X14
    FMOV  D21, X21
    FMOV  V21.D[1], X18
    FMOV  D22, X4
    FMOV  V22.D[1], X14
    FMOV  D23, X12
    FMOV  V23.D[1], X18
    FMOV  D24, X2
    FMOV  V24.D[1], X25
    FMOV  D25, X8
    FMOV  V25.D[1], X3
    FMOV  D26, X10
    FMOV  V26.D[1], X4
    FMOV  D27, X14
    FMOV  V27.D[1], X7
    FMOV  D28, X24
    FMOV  V28.D[1], X13
    FMOV  D29, X14
    FMOV  V29.D[1], X21
    FMOV  D30, X21
    FMOV  V30.D[1], X24
    FMOV  D31, X20
    FMOV  V31.D[1], X7
    MOVZ  X24, #0xa, LSL #0
TaishanSimdImmP01_label_1402:
    ADDV  S11, V10.4S
    ADDHN2  V27.4S, V22.2D, V23.2D
    ADDHN2  V28.8H, V14.4S, V19.4S
    ADDV  S28, V18.4S
    ADDV  H3, V0.8H
    ADD  V13.4H, V23.4H, V21.4H
    ADDV  H0, V3.4H
    ADDHN  V13.4H, V2.4S, V29.4S
    ADD  D23, D24, D25
    ADDV  B13, V17.8B
    ADDV  B13, V1.8B
    ADDHN  V31.4H, V22.4S, V5.4S
    ADDHN  V1.8B, V4.8H, V11.8H
    ADDP  D1, V7.2D
    ADDV  B31, V9.8B
    ADDHN  V17.4H, V19.4S, V11.4S
    ADDV  S30, V5.4S
    ADDV  H15, V26.4H
    ADD  V7.16B, V29.16B, V4.16B
    ADDHN2  V15.16B, V19.8H, V21.8H
    ADDP  V13.2D, V30.2D, V22.2D
    ADDHN2  V21.8H, V23.4S, V9.4S
    ADDV  B17, V29.16B
    ADD  D18, D12, D18
    ADDP  D1, V25.2D
    ADDV  B5, V7.8B
    ADDP  V19.16B, V19.16B, V18.16B
    ADDV  H19, V24.4H
    ADDV  B27, V26.8B
    ADDV  H31, V15.4H
    ADDP  V7.8H, V6.8H, V30.8H
    ADDV  B24, V28.16B
    ADD  V17.8B, V17.8B, V24.8B
    ADDV  S29, V5.4S
TaishanSimdImmP01_label_537:
    ADDP  V18.8B, V1.8B, V7.8B
    ADDV  B23, V0.16B
    ADDHN2  V26.16B, V13.8H, V4.8H
    ADD  V4.2D, V11.2D, V20.2D
    ADD  V4.2D, V31.2D, V0.2D
    ADD  V18.8B, V11.8B, V7.8B
    ADDHN2  V9.8H, V24.4S, V14.4S
    ADD  D8, D25, D27
    ADDV  H22, V11.4H
    ADDV  S24, V15.4S
    ADDP  D26, V1.2D
    ADDV  S27, V27.4S
    ADDV  S27, V30.4S
    ADDV  S18, V8.4S
    ADDHN2  V8.4S, V16.2D, V10.2D
    ADDV  H18, V8.4H
    ADDV  H30, V15.8H
    ADDV  B0, V7.8B
    ADD  D23, D11, D15
    ADDV  H3, V24.8H
    ADDP  D31, V4.2D
    ADD  V29.2D, V16.2D, V7.2D
    ADD  D18, D11, D8
    ADDP  D13, V23.2D
    ADDHN2  V0.4S, V5.2D, V31.2D
    ADD  D9, D14, D13
    ADDV  S6, V30.4S
    ADDV  H12, V14.4H
    ADDV  H0, V14.4H
    ADDV  B27, V13.8B
    ADDP  D6, V18.2D
    ADDV  S14, V7.4S
    ADDHN2  V14.8H, V27.4S, V9.4S
    ADDV  S26, V6.4S
    ADDV  H23, V6.8H
    ADDV  B23, V0.16B
    ADDP  D26, V13.2D
    ADDV  S13, V23.4S
    ADDV  S7, V28.4S
    ADDV  H16, V21.8H
    ADD  D23, D17, D23
    ADDP  V15.8B, V5.8B, V27.8B
    ADDP  V29.4S, V3.4S, V3.4S
    ADDV  H24, V30.8H
    ADD  V1.2S, V31.2S, V15.2S
    ADDV  H7, V14.8H
    ADDV  S24, V2.4S
    ADDP  D5, V6.2D
    ADD  V17.2D, V10.2D, V2.2D
    ADDV  S11, V10.4S
    ADDP  D16, V20.2D
    ADDP  V30.8B, V9.8B, V3.8B
    ADD  D26, D17, D2
    ADDP  D8, V20.2D
    ADDP  D27, V22.2D
    ADD  V21.2S, V18.2S, V2.2S
    ADDP  D19, V21.2D
    ADDP  V28.4H, V8.4H, V28.4H
    ADDP  D23, V26.2D
    ADDHN2  V4.16B, V24.8H, V5.8H
    ADDV  H0, V10.4H
    ADDP  V25.8B, V0.8B, V19.8B
    ADDV  S7, V7.4S
    ADD  D2, D0, D23
    ADDHN2  V5.8H, V24.4S, V29.4S
    ADDHN2  V22.4S, V6.2D, V5.2D
    ADD  V22.4H, V30.4H, V7.4H
    ADDP  D22, V11.2D
    ADDHN2  V27.4S, V18.2D, V19.2D
    ADDP  D9, V20.2D
    ADD  V26.16B, V16.16B, V29.16B
    ADDHN2  V1.16B, V27.8H, V15.8H
    ADDP  V17.4H, V28.4H, V28.4H
    ADDV  S19, V12.4S
    ADDHN2  V25.8H, V25.4S, V9.4S
    ADDHN2  V29.4S, V19.2D, V23.2D
    ADDV  S8, V28.4S
    ADDP  D20, V30.2D
    ADD  D18, D30, D28
    ADDHN  V16.2S, V26.2D, V12.2D
    ADD  D16, D22, D30
    ADD  V4.4H, V11.4H, V8.4H
    ADD  V24.4H, V21.4H, V31.4H
    ADDP  D3, V1.2D
    ADDHN  V3.4H, V1.4S, V29.4S
    ADD  D25, D15, D20
    ADD  D16, D12, D25
    ADDP  V18.8B, V7.8B, V17.8B
    ADDV  B21, V9.16B
    ADDHN2  V26.16B, V13.8H, V2.8H
    ADDV  B3, V23.16B
    ADDV  H4, V3.8H
    ADDHN2  V8.16B, V4.8H, V2.8H
    ADDV  B15, V30.8B
    ADDV  H26, V22.4H
    ADDP  D17, V4.2D
    ADD  D11, D6, D4
    ADD  D8, D23, D22
    ADDP  D24, V30.2D
    ADDV  S25, V8.4S
    ADDHN2  V10.8H, V24.4S, V7.4S
    ADDHN2  V23.8H, V26.4S, V3.4S
    ADDHN2  V6.16B, V23.8H, V25.8H
    ADDV  S22, V21.4S
    ADDHN2  V22.8H, V16.4S, V21.4S
    ADDP  V19.4H, V11.4H, V19.4H
    ADDHN  V2.4H, V18.4S, V20.4S
    ADDP  V22.2S, V15.2S, V28.2S
    ADD  V8.2S, V0.2S, V30.2S
    ADD  D19, D11, D20
    ADDP  V23.4H, V22.4H, V20.4H
    ADDV  B29, V19.8B
    ADDP  V1.8H, V25.8H, V18.8H
    ADDV  H1, V5.4H
    ADDV  B6, V27.8B
    ADDHN2  V25.8H, V11.4S, V1.4S
    ADD  V2.4H, V12.4H, V0.4H
    ADDP  D6, V14.2D
    ADDHN  V5.8B, V18.8H, V10.8H
    ADD  V8.16B, V24.16B, V14.16B
    ADD  D6, D13, D19
    ADDV  S23, V0.4S
    ADDP  D9, V0.2D
    ADDHN  V9.2S, V25.2D, V10.2D
    ADDP  V7.4H, V17.4H, V11.4H
    ADDV  H4, V2.8H
    ADDP  D25, V21.2D
    ADDHN  V7.4H, V27.4S, V28.4S
    ADDV  S25, V12.4S
    ADDHN  V1.4H, V28.4S, V13.4S
    ADD  V9.16B, V13.16B, V28.16B
    ADDP  D12, V17.2D
    ADDV  S20, V18.4S
    ADDHN  V31.8B, V7.8H, V16.8H
    ADDP  V21.8B, V14.8B, V10.8B
    ADDHN  V20.2S, V22.2D, V26.2D
    ADDV  H24, V4.4H
    ADDV  S6, V13.4S
    ADD  V0.2D, V31.2D, V4.2D
    ADDV  S29, V5.4S
    ADDHN2  V6.8H, V22.4S, V4.4S
    ADDHN  V11.2S, V17.2D, V5.2D
    ADDV  H31, V27.8H
    ADDV  B3, V28.16B
    ADDV  B22, V25.16B
    ADDP  V1.2S, V4.2S, V20.2S
    ADDV  B8, V1.8B
    ADDV  S14, V3.4S
    ADDHN2  V22.16B, V0.8H, V28.8H
    ADDV  B14, V27.16B
    ADDP  D29, V4.2D
    ADDV  B4, V11.16B
    ADDV  B1, V12.8B
    ADD  V14.2D, V25.2D, V3.2D
    ADD  D22, D24, D31
    ADDHN  V30.8B, V29.8H, V8.8H
    ADDV  H13, V6.8H
    ADDV  S6, V23.4S
    ADDV  H4, V20.8H
    ADDV  B26, V25.16B
    ADD  V11.8B, V12.8B, V1.8B
    ADD  D23, D28, D31
    ADDV  H8, V0.8H
    ADDV  B30, V10.16B
    ADDV  B17, V9.16B
    ADD  D0, D28, D22
    SUBS  X24, X24, #0x1
    B.NE  TaishanSimdImmP01_label_1402
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X24
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X13, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X29, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X6, D4
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X19, D5
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X8, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X16, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X7, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X19, D9
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X13, D10
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X10, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X7, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X21, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X3, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X20, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdImmP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X26, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X3, D17
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdImmP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X11, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X22, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdImmP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X27, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X18, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X14, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X6, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X5, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X3, D26
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X22, D27
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdImmP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X14, D28
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X13, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X6
    FMOV  V1.D[1], X26
    FMOV  D2, X9
    FMOV  V2.D[1], X13
    FMOV  D3, X11
    FMOV  V3.D[1], X6
    FMOV  D4, X25
    FMOV  V4.D[1], X12
    FMOV  D5, X28
    FMOV  V5.D[1], X27
    FMOV  D6, X29
    FMOV  V6.D[1], X12
    FMOV  D7, X28
    FMOV  V7.D[1], X25
    FMOV  D8, X19
    FMOV  V8.D[1], X3
    FMOV  D9, X24
    FMOV  V9.D[1], X13
    FMOV  D10, X21
    FMOV  V10.D[1], X2
    FMOV  D11, X14
    FMOV  V11.D[1], X17
    FMOV  D12, X10
    FMOV  V12.D[1], X22
    FMOV  D13, X26
    FMOV  V13.D[1], X5
    FMOV  D14, X7
    FMOV  V14.D[1], X8
    FMOV  D15, X26
    FMOV  V15.D[1], X18
    FMOV  D16, X16
    FMOV  V16.D[1], X12
    FMOV  D17, X5
    FMOV  V17.D[1], X14
    FMOV  D18, X17
    FMOV  V18.D[1], X5
    FMOV  D19, X27
    FMOV  V19.D[1], X29
    FMOV  D20, X10
    FMOV  V20.D[1], X17
    FMOV  D21, X2
    FMOV  V21.D[1], X18
    FMOV  D22, X17
    FMOV  V22.D[1], X6
    FMOV  D23, X24
    FMOV  V23.D[1], X29
    FMOV  D24, X28
    FMOV  V24.D[1], X27
    FMOV  D25, X14
    FMOV  V25.D[1], X14
    FMOV  D26, X10
    FMOV  V26.D[1], X25
    FMOV  D27, X21
    FMOV  V27.D[1], X17
    FMOV  D28, X16
    FMOV  V28.D[1], X27
    FMOV  D29, X2
    FMOV  V29.D[1], X21
    FMOV  D30, X9
    FMOV  V30.D[1], X7
    FMOV  D31, X10
    FMOV  V31.D[1], X27
    MOVZ  X24, #0xf, LSL #0
TaishanSimdImmP01_label_1468:
    ADDV  S11, V22.4S
    ADDHN2  V29.8H, V25.4S, V22.4S
    ADD  D18, D24, D11
    ADD  D14, D8, D12
    ADDV  B4, V12.8B
    ADDV  S26, V19.4S
    ADDHN2  V17.8H, V4.4S, V23.4S
    ADDV  S26, V23.4S
    ADDV  S17, V17.4S
    ADD  V26.16B, V28.16B, V2.16B
    ADDHN2  V31.4S, V29.2D, V16.2D
    ADDV  B21, V4.16B
    ADDHN2  V18.8H, V4.4S, V17.4S
    ADDV  H31, V21.4H
    ADDHN2  V24.4S, V24.2D, V7.2D
    ADDP  V9.2D, V7.2D, V5.2D
    ADDP  D21, V8.2D
    ADDP  D30, V4.2D
    ADDV  B7, V24.8B
    ADDV  S15, V29.4S
    ADDP  V27.2D, V28.2D, V29.2D
    ADDV  S13, V2.4S
    ADDV  S26, V11.4S
    ADDHN  V31.2S, V26.2D, V28.2D
    ADDP  V0.8H, V18.8H, V18.8H
    ADDV  S1, V0.4S
    ADDV  B11, V23.8B
    ADDHN2  V5.8H, V24.4S, V23.4S
    ADDV  H8, V10.8H
    ADD  V30.2D, V24.2D, V3.2D
    ADD  D17, D27, D22
    ADD  V23.8B, V24.8B, V27.8B
    ADDV  H29, V3.8H
    ADDP  D27, V21.2D
    ADDHN  V20.2S, V30.2D, V3.2D
    ADDV  S17, V25.4S
    ADDV  B28, V11.8B
    ADDHN  V7.8B, V26.8H, V17.8H
    ADD  D25, D14, D23
    ADDHN  V15.2S, V22.2D, V1.2D
    ADDHN2  V17.16B, V9.8H, V18.8H
    ADDHN2  V20.4S, V8.2D, V19.2D
    ADDV  B26, V19.16B
    ADDHN2  V27.8H, V22.4S, V13.4S
    ADDHN2  V11.4S, V27.2D, V6.2D
    ADDV  B3, V26.8B
    ADDV  B14, V22.8B
    ADDHN2  V9.8H, V21.4S, V13.4S
    ADDV  H20, V20.4H
    ADDHN  V22.8B, V22.8H, V26.8H
    ADDP  D6, V6.2D
    ADD  D3, D12, D22
    ADDV  S11, V9.4S
    ADDHN2  V16.4S, V0.2D, V20.2D
    ADDHN  V26.4H, V22.4S, V17.4S
    ADDV  S10, V30.4S
    ADD  V14.2D, V9.2D, V1.2D
    ADD  V10.4S, V31.4S, V12.4S
    ADDHN2  V26.16B, V15.8H, V9.8H
    ADD  D26, D31, D6
    ADDHN2  V10.4S, V16.2D, V17.2D
    ADD  D29, D3, D10
    ADDV  S20, V3.4S
    ADD  V17.8B, V3.8B, V14.8B
    ADDHN  V15.8B, V7.8H, V25.8H
    ADDV  B28, V23.8B
    ADD  D5, D11, D29
    ADDV  S26, V24.4S
    ADDV  H12, V14.8H
    ADDV  S15, V29.4S
    ADDV  S14, V24.4S
    ADDV  S15, V14.4S
    ADDP  D8, V24.2D
    ADDP  D31, V28.2D
    ADDV  H11, V0.8H
    ADDP  D26, V14.2D
    ADDP  V12.16B, V5.16B, V19.16B
    ADDHN  V3.4H, V31.4S, V25.4S
    ADDP  V7.8B, V1.8B, V18.8B
    ADDV  S10, V1.4S
    ADDV  B7, V30.16B
    ADDP  D11, V8.2D
    ADDHN2  V3.16B, V4.8H, V1.8H
    ADDP  V9.4S, V12.4S, V5.4S
    ADDHN  V25.2S, V18.2D, V14.2D
    ADDV  H3, V3.8H
    ADDV  S7, V13.4S
    ADDP  V29.4H, V30.4H, V29.4H
    ADDV  S17, V24.4S
    ADDV  B16, V28.16B
    ADDHN  V28.8B, V3.8H, V9.8H
    ADDV  H5, V6.8H
    ADD  D8, D9, D21
    ADDP  D5, V20.2D
    ADDV  B7, V25.8B
    ADD  D18, D9, D21
    ADDV  S14, V7.4S
    ADDP  V9.2S, V14.2S, V19.2S
    ADDV  B7, V10.16B
    ADDHN  V1.2S, V3.2D, V18.2D
    ADDV  B26, V11.16B
    ADD  V17.4S, V12.4S, V14.4S
    ADD  D30, D21, D31
    ADDHN2  V29.4S, V6.2D, V1.2D
    ADD  V26.8B, V30.8B, V12.8B
    ADD  V6.2D, V4.2D, V14.2D
    ADDHN2  V20.8H, V31.4S, V17.4S
    ADD  D24, D9, D24
    ADDV  B26, V22.8B
    ADDV  H21, V25.4H
    ADDHN  V10.4H, V6.4S, V5.4S
    ADD  V24.2D, V16.2D, V8.2D
    ADDHN2  V8.4S, V2.2D, V20.2D
    ADDV  S14, V8.4S
    ADDHN2  V29.16B, V18.8H, V11.8H
    ADDHN2  V23.8H, V24.4S, V14.4S
    ADD  D3, D6, D24
    ADD  D22, D11, D7
    ADDHN2  V2.16B, V19.8H, V22.8H
    ADDHN2  V4.4S, V9.2D, V11.2D
    ADDV  B28, V0.8B
    ADDV  S24, V31.4S
    ADD  D9, D4, D0
    ADDV  S8, V30.4S
    ADDP  V20.2S, V8.2S, V27.2S
    ADDP  D1, V31.2D
    ADDP  D16, V1.2D
    ADDHN  V24.8B, V13.8H, V15.8H
    ADD  V30.8B, V17.8B, V9.8B
    ADDHN  V30.2S, V12.2D, V30.2D
    ADDP  V16.8B, V15.8B, V5.8B
    ADD  V11.8B, V21.8B, V16.8B
    ADDV  S11, V3.4S
    ADDP  V19.8B, V28.8B, V0.8B
    ADDV  H10, V10.8H
    ADDHN  V4.4H, V24.4S, V9.4S
    ADDP  D5, V11.2D
    ADDHN2  V9.8H, V1.4S, V10.4S
    ADDV  S16, V2.4S
    ADDP  V4.2S, V6.2S, V15.2S
    ADDP  D17, V30.2D
    ADD  D5, D8, D30
    ADDV  S29, V9.4S
    ADD  D11, D27, D24
    ADD  V4.4H, V9.4H, V0.4H
    ADDHN  V4.8B, V0.8H, V8.8H
    ADDHN  V11.4H, V8.4S, V16.4S
    ADDP  V30.8B, V14.8B, V3.8B
    ADDV  H17, V16.4H
    ADD  D23, D5, D24
    ADD  V30.8H, V16.8H, V11.8H
    ADDP  V13.8H, V2.8H, V12.8H
    ADDV  S17, V7.4S
    ADDHN  V12.2S, V16.2D, V21.2D
    ADDV  S20, V29.4S
    ADD  V15.8H, V17.8H, V27.8H
    ADD  V27.2D, V0.2D, V13.2D
    ADDHN2  V30.16B, V31.8H, V24.8H
    ADDHN  V21.2S, V12.2D, V27.2D
    ADDP  V30.2S, V3.2S, V4.2S
    ADDP  D30, V8.2D
    ADDV  S23, V0.4S
    ADDV  S2, V14.4S
    ADDP  D30, V0.2D
    ADDV  B26, V24.8B
    ADDP  V4.16B, V12.16B, V21.16B
    ADDP  V24.2D, V5.2D, V31.2D
    ADDP  D1, V23.2D
    ADDP  D27, V23.2D
    ADDP  D17, V28.2D
    ADDHN  V12.4H, V17.4S, V23.4S
    ADDP  D14, V18.2D
    ADD  D29, D24, D18
    ADD  D1, D15, D0
    ADD  V21.16B, V12.16B, V29.16B
    ADDV  B4, V3.16B
    ADDHN2  V1.4S, V18.2D, V24.2D
    ADDV  B17, V18.8B
    ADDP  V8.2D, V25.2D, V0.2D
    ADDV  B1, V28.16B
    ADDP  D29, V15.2D
    ADDP  D2, V1.2D
    ADD  D14, D8, D18
    ADDV  H3, V13.4H
    ADDV  S6, V1.4S
    ADDP  V0.2S, V28.2S, V2.2S
    ADD  D31, D31, D26
    ADDV  S14, V20.4S
    ADDP  V27.8B, V20.8B, V24.8B
    ADD  D11, D22, D22
    ADDV  B6, V17.8B
    ADDP  V12.8B, V2.8B, V8.8B
    ADDP  D24, V29.2D
    ADDP  D17, V28.2D
    ADDHN  V7.8B, V13.8H, V9.8H
    ADDP  V17.16B, V18.16B, V24.16B
    ADD  V15.4S, V31.4S, V8.4S
    ADDV  B10, V31.8B
    ADDHN2  V26.8H, V12.4S, V28.4S
    ADDV  H6, V27.4H
    SUBS  X24, X24, #0x1
    B.NE  TaishanSimdImmP01_label_1468
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X6, X10, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X11, X25, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X14, X27, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X5, X7, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X28, X4, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X27, X19, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X15, X22, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdImmP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdImmP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X27, X11, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X28, X5, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X10, X26, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X20, X12, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdImmP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X17, X22, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X6, X7, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X24, D2
    MOVZ  X3, #0x80, LSL #0
    SUB  X26, X3, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdImmP01_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X15, D3
    MOVZ  X19, #0x2c4e, LSL #0
    SUB  X6, X19, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X21, D4
    MOVZ  X28, #0x63, LSL #0
    SUB  X13, X28, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X20, D5
    MOVZ  X21, #0xef76, LSL #0
    MOVK  X21, #0xdc19, LSL #16
    SUB  X9, X21, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X3, D6
    MOVZ  X4, #0x972f, LSL #0
    SUB  X20, X4, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X4, D7
    MOVZ  X16, #0xfcc8, LSL #0
    MOVK  X16, #0x15, LSL #16
    MOVK  X16, #0x29, LSL #32
    MOVK  X16, #0x60, LSL #48
    SUB  X13, X16, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X21, #0x8f4c, LSL #0
    MOVK  X21, #0xf949, LSL #16
    MOVK  X21, #0xd315, LSL #32
    MOVK  X21, #0x1, LSL #48
    SUB  X17, X21, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X5, D8
    MOVZ  X21, #0xfca4, LSL #0
    SUB  X17, X21, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X11, D9
    MOVZ  X3, #0xc88e, LSL #0
    MOVK  X3, #0xfca4, LSL #16
    MOVK  X3, #0xe98a, LSL #32
    SUB  X4, X3, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdImmP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X8, D10
    MOVZ  X14, #0x1e, LSL #0
    SUB  X9, X14, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdImmP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X14, D11
    MOVZ  X12, #0xd370, LSL #0
    MOVK  X12, #0x5698, LSL #16
    MOVK  X12, #0xf946, LSL #32
    MOVK  X12, #0x1, LSL #48
    SUB  X13, X12, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdImmP01_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X15, D12
    MOVZ  X5, #0x80, LSL #0
    MOVK  X5, #0xa0, LSL #32
    SUB  X27, X5, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X6, #0x29ee, LSL #0
    MOVK  X6, #0x607c, LSL #32
    SUB  X27, X6, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X15, D13
    MOVZ  X6, #0x6e, LSL #0
    MOVK  X6, #0x2be0, LSL #32
    SUB  X27, X6, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X10, D14
    MOVZ  X22, #0xb218, LSL #0
    MOVK  X22, #0xfca5, LSL #16
    SUB  X6, X22, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdImmP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X16, #0x8f4c, LSL #0
    MOVK  X16, #0xf949, LSL #16
    MOVK  X16, #0xd315, LSL #32
    MOVK  X16, #0x1, LSL #48
    SUB  X19, X16, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X14, D15
    MOVZ  X16, #0xfdc1, LSL #0
    SUB  X19, X16, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdImmP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X10, D16
    MOVZ  X18, #0x2bd8, LSL #0
    MOVK  X18, #0x76, LSL #16
    SUB  X21, X18, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X12, #0xf488, LSL #0
    MOVK  X12, #0x1c0, LSL #16
    SUB  X29, X12, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X27, D17
    MOVZ  X12, #0xe8c7, LSL #0
    MOVK  X12, #0x6f2f, LSL #16
    SUB  X29, X12, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdImmP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X8, D18
    MOVZ  X10, #0x4582, LSL #0
    MOVK  X10, #0xdd0b, LSL #16
    MOVK  X10, #0xe946, LSL #32
    MOVK  X10, #0x600f, LSL #48
    SUB  X27, X10, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X16, D19
    MOVZ  X2, #0x80, LSL #0
    MOVK  X2, #0xa06d, LSL #32
    MOVK  X2, #0x73, LSL #48
    SUB  X18, X2, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdImmP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X27, D20
    MOVZ  X28, #0xb218, LSL #0
    MOVK  X28, #0xfca5, LSL #16
    SUB  X5, X28, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdImmP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X6, D21
    MOVZ  X22, #0x2d43, LSL #0
    MOVK  X22, #0xb925, LSL #16
    MOVK  X22, #0xe947, LSL #32
    MOVK  X22, #0x600f, LSL #48
    SUB  X27, X22, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdImmP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X28, D22
    MOVZ  X15, #0x69b8, LSL #0
    MOVK  X15, #0x2b4c, LSL #16
    MOVK  X15, #0xfca3, LSL #32
    SUB  X11, X15, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdImmP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X28, D24
    MOVZ  X18, #0xd7b, LSL #0
    MOVK  X18, #0xdc18, LSL #16
    MOVK  X18, #0xe8d8, LSL #32
    MOVK  X18, #0x1, LSL #48
    SUB  X12, X18, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdImmP01_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X10, D25
    MOVZ  X16, #0xfca4, LSL #0
    SUB  X20, X16, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdImmP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X27, D26
    MOVZ  X16, #0x91, LSL #0
    SUB  X21, X16, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdImmP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X11, D27
    MOVZ  X3, #0xa1ca, LSL #0
    MOVK  X3, #0xf565, LSL #32
    SUB  X8, X3, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdImmP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X6, D28
    MOVZ  X8, #0x80, LSL #0
    SUB  X25, X8, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdImmP01_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail
    FMOV  X3, D29
    MOVZ  X28, #0xd7b, LSL #0
    MOVK  X28, #0xdc18, LSL #16
    MOVK  X28, #0xe8d8, LSL #32
    MOVK  X28, #0x1, LSL #48
    SUB  X17, X28, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdImmP01_TestFail

TaishanSimdImmP01_TestEnd:
    MOVZ  X1, #0x0, LSL #0
    STP  X1, X2,   [X0], #0x10
    STP  X3, X4,   [X0], #0x10
    STP  X5, X6,   [X0], #0x10
    STP  X7, X8,   [X0], #0x10
    STP  X9, X10,  [X0], #0x10
    STP  X11, X12, [X0], #0x10
    STP  X13, X14, [X0], #0x10
    STP  X15, X16, [X0], #0x10
    STP  X17, X18, [X0], #0x10
    STP  X19, X20, [X0], #0x10
    STP  X21, X22, [X0], #0x10
    STP  X23, X24, [X0], #0x10
    STP  X25, X26, [X0], #0x10
    STP  X27, X28, [X0], #0x10
    STP  X29, X30, [X0], #0x10
    LDP  X1, X2, [SP], #16
    MSR  NZCV, X1
    LDP  X2, X3, [SP], #16
    MSR  FPCR, X2
    MSR  FPSR, X3
    ISB  SY

    LDP  Q30, Q31, [SP], #32
    LDP  Q28, Q29, [SP], #32
    LDP  Q26, Q27, [SP], #32
    LDP  Q24, Q25, [SP], #32
    LDP  Q22, Q23, [SP], #32
    LDP  Q20, Q21, [SP], #32
    LDP  Q18, Q19, [SP], #32
    LDP  Q16, Q17, [SP], #32
    LDP  Q14, Q15, [SP], #32
    LDP  Q12, Q13, [SP], #32
    LDP  Q10, Q11, [SP], #32
    LDP  Q8, Q9, [SP], #32
    LDP  Q6, Q7, [SP], #32
    LDP  Q4, Q5, [SP], #32
    LDP  Q2, Q3, [SP], #32
    LDP  Q0, Q1, [SP], #32
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
TaishanSimdImmP01_TestFail:
    STP  X1, X2,   [X0], #0x10
    STP  X3, X4,   [X0], #0x10
    STP  X5, X6,   [X0], #0x10
    STP  X7, X8,   [X0], #0x10
    STP  X9, X10,  [X0], #0x10
    STP  X11, X12, [X0], #0x10
    STP  X13, X14, [X0], #0x10
    STP  X15, X16, [X0], #0x10
    STP  X17, X18, [X0], #0x10
    STP  X19, X20, [X0], #0x10
    STP  X21, X22, [X0], #0x10
    STP  X23, X24, [X0], #0x10
    STP  X25, X26, [X0], #0x10
    STP  X27, X28, [X0], #0x10
    STP  X29, X30, [X0], #0x10
    LDP  X1, X2, [SP], #16
    MSR  NZCV, X1
    LDP  X2, X3, [SP], #16
    MSR  FPCR, X2
    MSR  FPSR, X3
    ISB  SY

    LDP  Q30, Q31, [SP], #32
    LDP  Q28, Q29, [SP], #32
    LDP  Q26, Q27, [SP], #32
    LDP  Q24, Q25, [SP], #32
    LDP  Q22, Q23, [SP], #32
    LDP  Q20, Q21, [SP], #32
    LDP  Q18, Q19, [SP], #32
    LDP  Q16, Q17, [SP], #32
    LDP  Q14, Q15, [SP], #32
    LDP  Q12, Q13, [SP], #32
    LDP  Q10, Q11, [SP], #32
    LDP  Q8, Q9, [SP], #32
    LDP  Q6, Q7, [SP], #32
    LDP  Q4, Q5, [SP], #32
    LDP  Q2, Q3, [SP], #32
    LDP  Q0, Q1, [SP], #32
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
