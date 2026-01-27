.global TSRTFloatMinMax

.text
.p2align 4

TSRTFloatMinMax:

TSRTFloatMinMax_TestBegin:
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
    MRS  X4, NZCV
    STP  X2, X3, [SP, #-16]!
    STP  X4, X2, [SP, #-16]!
    MOVZ  X3, #0xd0e6, LSL #0
    MOVK  X3, #0xd18c, LSL #16
    MOVK  X3, #0x59e3, LSL #32
    MOVK  X3, #0x7978, LSL #48
    MOVZ  X4, #0x3cef, LSL #0
    MOVK  X4, #0x734a, LSL #16
    MOVK  X4, #0x11c2, LSL #32
    MOVK  X4, #0x99fe, LSL #48
    MOVZ  X5, #0x290b, LSL #0
    MOVK  X5, #0x9d77, LSL #16
    MOVK  X5, #0x8af, LSL #32
    MOVK  X5, #0xbebc, LSL #48
    MOVZ  X6, #0xa18e, LSL #0
    MOVK  X6, #0x46c2, LSL #16
    MOVK  X6, #0x3c34, LSL #32
    MOVK  X6, #0xab74, LSL #48
    MOVZ  X7, #0xa2f5, LSL #0
    MOVK  X7, #0x8f4d, LSL #16
    MOVK  X7, #0xa29f, LSL #32
    MOVK  X7, #0xe64c, LSL #48
    MOVZ  X8, #0xbd43, LSL #0
    MOVK  X8, #0xd5b9, LSL #16
    MOVK  X8, #0x7b34, LSL #32
    MOVK  X8, #0xb2c3, LSL #48
    MOVZ  X9, #0xbf00, LSL #0
    MOVK  X9, #0xa2de, LSL #16
    MOVK  X9, #0x83e1, LSL #32
    MOVK  X9, #0x96d5, LSL #48
    MOVZ  X10, #0xfc93, LSL #0
    MOVK  X10, #0xbd50, LSL #16
    MOVK  X10, #0xfead, LSL #32
    MOVK  X10, #0xf090, LSL #48
    MOVZ  X12, #0x4365, LSL #0
    MOVK  X12, #0x7f06, LSL #16
    MOVK  X12, #0x8036, LSL #32
    MOVK  X12, #0x8932, LSL #48
    MOVZ  X13, #0x335f, LSL #0
    MOVK  X13, #0x597e, LSL #16
    MOVK  X13, #0x6634, LSL #32
    MOVK  X13, #0xea84, LSL #48
    MOVZ  X14, #0x3567, LSL #0
    MOVK  X14, #0x98f1, LSL #16
    MOVK  X14, #0x6a3c, LSL #32
    MOVK  X14, #0x1155, LSL #48
    MOVZ  X15, #0x19f7, LSL #0
    MOVK  X15, #0x96b0, LSL #16
    MOVK  X15, #0xb8b3, LSL #32
    MOVK  X15, #0x9d05, LSL #48
    MOVZ  X16, #0x40dc, LSL #0
    MOVK  X16, #0xaca, LSL #16
    MOVK  X16, #0x5691, LSL #32
    MOVK  X16, #0x4391, LSL #48
    MOVZ  X17, #0x66a, LSL #0
    MOVK  X17, #0x69ef, LSL #16
    MOVK  X17, #0xe9fa, LSL #32
    MOVK  X17, #0x5f1f, LSL #48
    MOVZ  X18, #0xbb9e, LSL #0
    MOVK  X18, #0xb2e4, LSL #16
    MOVK  X18, #0xfdb9, LSL #32
    MOVK  X18, #0xb581, LSL #48
    MOVZ  X20, #0xaa60, LSL #0
    MOVK  X20, #0x6752, LSL #16
    MOVK  X20, #0xd96e, LSL #32
    MOVK  X20, #0xc8a1, LSL #48
    MOVZ  X21, #0x2b89, LSL #0
    MOVK  X21, #0xba4b, LSL #16
    MOVK  X21, #0xb866, LSL #32
    MOVK  X21, #0x1f4d, LSL #48
    MOVZ  X22, #0x1496, LSL #0
    MOVK  X22, #0x2951, LSL #16
    MOVK  X22, #0xbdaf, LSL #32
    MOVK  X22, #0x3af4, LSL #48
    MOVZ  X23, #0x37d, LSL #0
    MOVK  X23, #0x775d, LSL #16
    MOVK  X23, #0xdf0c, LSL #32
    MOVK  X23, #0x2ba6, LSL #48
    MOVZ  X24, #0xcc20, LSL #0
    MOVK  X24, #0x296f, LSL #16
    MOVK  X24, #0x570f, LSL #32
    MOVK  X24, #0xbf7f, LSL #48
    MOVZ  X25, #0x3385, LSL #0
    MOVK  X25, #0x9da1, LSL #16
    MOVK  X25, #0x9186, LSL #32
    MOVK  X25, #0x2797, LSL #48
    MOVZ  X26, #0xf465, LSL #0
    MOVK  X26, #0xd77, LSL #16
    MOVK  X26, #0x4c4, LSL #32
    MOVK  X26, #0xfc8e, LSL #48
    MOVZ  X28, #0x1e4e, LSL #0
    MOVK  X28, #0x46ed, LSL #16
    MOVK  X28, #0xe1cf, LSL #32
    MOVK  X28, #0x367a, LSL #48
    MOVZ  X29, #0xae50, LSL #0
    MOVK  X29, #0xdca0, LSL #16
    MOVK  X29, #0x2743, LSL #32
    MOVK  X29, #0x15a3, LSL #48
    MOVZ  X8, #0x22b2, LSL #0
    MOVK  X8, #0x6974, LSL #16
    MOVK  X8, #0x5a57, LSL #32
    MOVK  X8, #0x3abd, LSL #48
    MSR  FPCR, X8
    MOVZ  X8, #0xf1eb, LSL #0
    MOVK  X8, #0x8716, LSL #16
    MOVK  X8, #0xcc62, LSL #32
    MOVK  X8, #0xf133, LSL #48
    MSR  FPSR, X8
    MRS  X24, FPSR
    MOVZ  X28, #0xff60, LSL #0
    MOVK  X28, #0x7ff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    AND  X24, X24, X28
    MOVZ  X28, #0x0, LSL #0
    ORR  X24, X24, X28
    MSR  FPSR, X24
    ISB  SY
    ADDS  X18, X23, #0xf09, LSL #12
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X3, #0x7029, LSL #0
    MOVK  X3, #0x6a9e, LSL #16
    MOVK  X3, #0xd78f, LSL #32
    MOVK  X3, #0x7a93, LSL #48
    MOVZ  X4, #0xe7eb, LSL #0
    MOVK  X4, #0xd352, LSL #16
    MOVK  X4, #0xdbfb, LSL #32
    MOVK  X4, #0xc355, LSL #48
    MOVZ  X5, #0xcdc0, LSL #0
    MOVK  X5, #0x7d04, LSL #16
    MOVK  X5, #0x133c, LSL #32
    MOVK  X5, #0x4e53, LSL #48
    MOVZ  X6, #0xabe9, LSL #0
    MOVK  X6, #0x14c4, LSL #16
    MOVK  X6, #0xe7e9, LSL #32
    MOVK  X6, #0x2b68, LSL #48
    MOVZ  X7, #0x5f5e, LSL #0
    MOVK  X7, #0x4bcc, LSL #16
    MOVK  X7, #0x7172, LSL #32
    MOVK  X7, #0x1d59, LSL #48
    MOVZ  X8, #0xac07, LSL #0
    MOVK  X8, #0x5088, LSL #16
    MOVK  X8, #0x8120, LSL #32
    MOVK  X8, #0xa398, LSL #48
    MOVZ  X9, #0xbc4e, LSL #0
    MOVK  X9, #0x74f7, LSL #16
    MOVK  X9, #0x88a2, LSL #32
    MOVK  X9, #0x361, LSL #48
    MOVZ  X10, #0x17a2, LSL #0
    MOVK  X10, #0x846c, LSL #16
    MOVK  X10, #0xc508, LSL #32
    MOVK  X10, #0x111f, LSL #48
    MOVZ  X12, #0x1bcc, LSL #0
    MOVK  X12, #0x4b3f, LSL #16
    MOVK  X12, #0x583c, LSL #32
    MOVK  X12, #0x6864, LSL #48
    MOVZ  X13, #0x63f3, LSL #0
    MOVK  X13, #0x1465, LSL #16
    MOVK  X13, #0x7199, LSL #32
    MOVK  X13, #0x3293, LSL #48
    MOVZ  X14, #0xc475, LSL #0
    MOVK  X14, #0x8930, LSL #16
    MOVK  X14, #0xa96b, LSL #32
    MOVK  X14, #0x915d, LSL #48
    MOVZ  X15, #0x8af1, LSL #0
    MOVK  X15, #0x6543, LSL #16
    MOVK  X15, #0x221f, LSL #32
    MOVK  X15, #0x1ad5, LSL #48
    MOVZ  X16, #0xc241, LSL #0
    MOVK  X16, #0xbd3, LSL #16
    MOVK  X16, #0x8cfb, LSL #32
    MOVK  X16, #0xd54d, LSL #48
    MOVZ  X17, #0xb39a, LSL #0
    MOVK  X17, #0x1454, LSL #16
    MOVK  X17, #0x85fd, LSL #32
    MOVK  X17, #0xf269, LSL #48
    MOVZ  X18, #0xe0ff, LSL #0
    MOVK  X18, #0xe362, LSL #16
    MOVK  X18, #0xe217, LSL #32
    MOVK  X18, #0xb528, LSL #48
    MOVZ  X20, #0x680b, LSL #0
    MOVK  X20, #0x20a6, LSL #16
    MOVK  X20, #0x666b, LSL #32
    MOVK  X20, #0x25e5, LSL #48
    MOVZ  X21, #0x807d, LSL #0
    MOVK  X21, #0xb47f, LSL #16
    MOVK  X21, #0x1c36, LSL #32
    MOVK  X21, #0x567f, LSL #48
    MOVZ  X22, #0x8466, LSL #0
    MOVK  X22, #0x5edf, LSL #16
    MOVK  X22, #0xb040, LSL #32
    MOVK  X22, #0x7b22, LSL #48
    MOVZ  X23, #0x1319, LSL #0
    MOVK  X23, #0xb16, LSL #16
    MOVK  X23, #0x8aa4, LSL #32
    MOVK  X23, #0xe1a8, LSL #48
    MOVZ  X24, #0xc8a5, LSL #0
    MOVK  X24, #0x9c45, LSL #16
    MOVK  X24, #0xcfa0, LSL #32
    MOVK  X24, #0xb6e6, LSL #48
    MOVZ  X25, #0x41ea, LSL #0
    MOVK  X25, #0x74a8, LSL #16
    MOVK  X25, #0x8172, LSL #32
    MOVK  X25, #0xc187, LSL #48
    MOVZ  X26, #0xdfed, LSL #0
    MOVK  X26, #0xe0bf, LSL #16
    MOVK  X26, #0x50a8, LSL #32
    MOVK  X26, #0x8073, LSL #48
    MOVZ  X28, #0xac9d, LSL #0
    MOVK  X28, #0xc214, LSL #16
    MOVK  X28, #0xfc37, LSL #32
    MOVK  X28, #0x20ee, LSL #48
    MOVZ  X29, #0x2a3e, LSL #0
    MOVK  X29, #0xdd93, LSL #16
    MOVK  X29, #0x7f52, LSL #32
    MOVK  X29, #0x9426, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X25
    FMOV  V2.D[1], X14
    FMOV  D3, X20
    FMOV  V3.D[1], X26
    FMOV  D4, X7
    FMOV  V4.D[1], X21
    FMOV  D5, X28
    FMOV  V5.D[1], X8
    FMOV  D6, X13
    FMOV  V6.D[1], X13
    FMOV  D7, X16
    FMOV  V7.D[1], X28
    FMOV  D8, X10
    FMOV  V8.D[1], X23
    FMOV  D9, X24
    FMOV  V9.D[1], X16
    FMOV  D10, X9
    FMOV  V10.D[1], X3
    FMOV  D11, X8
    FMOV  V11.D[1], X17
    FMOV  D12, X21
    FMOV  V12.D[1], X17
    FMOV  D13, X28
    FMOV  V13.D[1], X14
    FMOV  D14, X22
    FMOV  V14.D[1], X18
    FMOV  D15, X18
    FMOV  V15.D[1], X22
    FMOV  D16, X5
    FMOV  V16.D[1], X25
    FMOV  D17, X10
    FMOV  V17.D[1], X24
    FMOV  D18, X6
    FMOV  V18.D[1], X3
    FMOV  D19, X7
    FMOV  V19.D[1], X22
    FMOV  D20, X25
    FMOV  V20.D[1], X9
    FMOV  D21, X14
    FMOV  V21.D[1], X24
    FMOV  D22, X25
    FMOV  V22.D[1], X7
    FMOV  D23, X16
    FMOV  V23.D[1], X28
    FMOV  D24, X5
    FMOV  V24.D[1], X12
    FMOV  D25, X22
    FMOV  V25.D[1], X28
    FMOV  D26, X3
    FMOV  V26.D[1], X23
    FMOV  D27, X28
    FMOV  V27.D[1], X25
    FMOV  D28, X15
    FMOV  V28.D[1], X7
    FMOV  D29, X13
    FMOV  V29.D[1], X23
    FMOV  D30, X4
    FMOV  V30.D[1], X16
    FMOV  D31, X29
    FMOV  V31.D[1], X8
    MOVZ  X17, #0xf, LSL #0
TSRTFloatMinMax_label_0:
    FMAX  D18, D28, D21
    FMINNM  S0, S24, S29
    FMIN  S17, S31, S25
    FMAX  D28, D18, D0
    FMINNM  H14, H17, H27
    FMINNM  H6, H26, H28
    FMAX  D26, D30, D14
    FMAXNM  H28, H26, H6
    FMAX  H31, H28, H28
    FMIN  S26, S31, S31
    FMIN  H3, H26, H26
    FMAXNM  D1, D3, D3
    FMAX  S25, S1, S1
    FMINNM  D31, D25, D25
    FMAXNM  D25, D31, D31
    FMAXNM  D31, D8, D31
    FMAX  H24, H22, H11
    FMINNM  D31, D30, D22
    FMAX  H0, H28, H20
    FMIN  H20, H26, H16
    FMIN  D17, D24, D13
    FMINNM  S30, S30, S19
    FMAX  D22, D10, D0
    FMAX  S26, S1, S24
    FMINNM  D19, D20, D11
    FMIN  H24, H0, H27
    FMIN  D18, D30, D26
    FMAXNM  S10, S9, S25
    FMAX  S13, S7, S14
    FMAX  H25, H21, H20
    FMAX  H9, H31, H25
    FMAX  D11, D13, D17
    FMIN  S25, S22, S24
    FMAXNM  D26, D11, D11
    FMIN  D28, D19, D25
    FMAXNM  H20, H28, H28
    FMIN  S13, S10, S10
    FMAX  D3, D18, D18
    FMAX  H21, H3, H26
    FMAXNM  H10, H21, H18
    FMAX  S28, S20, S13
    FMAX  D1, D28, D9
    FMAX  H17, H10, H1
    FMINNM  H26, H28, H14
    FMAX  H24, H21, H15
    FMINNM  S20, S0, S5
    FMAX  D21, D15, D9
    FMAXNM  D0, D18, D19
    FMINNM  H10, H24, H15
    FMINNM  H5, H25, H17
    FMAXNM  D1, D29, D24
    FMINNM  H17, H7, H30
    FMINNM  S9, S16, S25
    FMAX  H30, H9, H9
    FMINNM  H14, H17, H30
    FMIN  H7, H0, H10
    FMAX  S16, S20, S5
    FMAXNM  D18, D1, D21
    FMAXNM  D10, D7, D18
    FMAX  H19, H10, H14
    FMIN  D15, D16, D16
    FMAX  H25, H19, H26
    FMAX  S9, S15, S15
    FMAXNM  H29, H9, H25
    FMINNM  D20, D11, D4
    FMAXNM  D19, D11, D2
    FMAX  D13, D27, D15
    FMAXNM  S26, S11, S28
    FMINNM  S17, S6, S21
    FMINNM  H30, H9, H18
    FMAX  H7, H7, H5
    FMAX  S24, S24, S26
    FMAX  D2, D2, D14
    FMIN  H4, H29, H2
    FMAXNM  H10, H4, H17
    FMAX  S16, S7, S8
    FMAXNM  H26, H13, H13
    FMAX  D13, D20, D30
    FMINNM  H9, H13, H13
    FMINNM  S17, S26, S19
    FMAX  S14, S9, S24
    FMAX  H11, H16, H10
    FMAX  D25, D11, D14
    FMAXNM  D2, D17, D25
    FMIN  D5, D7, D15
    FMIN  D6, D17, D13
    FMINNM  S29, S7, S13
    FMIN  S10, S14, S2
    FMAXNM  D21, D25, D23
    FMAXNM  H18, H20, H10
    FMINNM  S19, S17, S22
    FMIN  H27, H12, H31
    FMAX  H15, H31, H17
    FMAXNM  S28, S27, S4
    FMAXNM  S4, S28, S11
    FMIN  S8, S23, S31
    FMAXNM  S7, S5, S21
    FMAXNM  S27, S6, S15
    FMAX  D2, D27, D29
    FMIN  D17, D4, D2
    FMAXNM  S6, S19, S7
    FMIN  H28, H6, H18
    FMAX  H10, H8, H8
    FMINNM  H8, H10, H28
    FMAXNM  H14, H8, H17
    FMAXNM  S18, S28, S6
    FMIN  D15, D12, D12
    FMAXNM  S11, S30, S3
    FMAX  S20, S30, S18
    FMINNM  S23, S11, S22
    FMINNM  H2, H1, H19
    FMAX  H22, H16, H13
    FMAXNM  S18, S29, S7
    FMAX  H29, H30, H18
    FMAX  S4, S12, S7
    FMAXNM  H13, H27, H3
    FMINNM  D16, D22, D14
    FMAX  H3, H13, H16
    FMAXNM  H11, H28, H15
    FMAX  H14, H3, H11
    FMAXNM  H30, H23, H4
    FMAX  D16, D20, D29
    FMIN  S12, S14, S16
    FMINNM  S18, S2, S2
    FMAX  D20, D12, D18
    FMIN  D6, D30, D31
    FMAXNM  D16, D6, D20
    FMAX  H17, H11, H17
    FMIN  H10, H23, H31
    FMINNM  H11, H21, H18
    FMAX  H12, H7, H5
    FMINNM  H15, H4, H14
    FMAX  D20, D27, D10
    FMIN  D22, D24, D20
    FMAXNM  D6, D11, D30
    FMINNM  H28, H6, H17
    FMIN  S13, S5, S0
    FMAX  H3, H7, H23
    FMINNM  D29, D13, D2
    FMIN  H13, H16, H11
    FMINNM  D2, D29, D2
    FMINNM  D10, D20, D11
    FMAX  D4, D21, D12
    FMIN  H16, H27, H16
    FMAXNM  S14, S16, S16
    FMAX  S12, S2, S4
    FMAX  D23, D14, D15
    FMIN  S7, S13, S23
    FMAXNM  H31, H28, H7
    FMAX  S0, S3, S12
    FMINNM  S5, S22, S0
    FMINNM  D6, D5, D31
    FMAX  H16, H6, H10
    FMINNM  D21, D27, D27
    FMINNM  D11, D24, D11
    FMAX  H29, H30, H10
    FMIN  S14, S5, S5
    FMINNM  D28, D21, D11
    FMAXNM  D21, D26, D5
    FMAX  S17, S1, S4
    FMINNM  S27, S1, S28
    FMINNM  H15, H31, H18
    FMINNM  D28, D9, D5
    FMAX  H10, H12, H27
    FMIN  S20, S14, S17
    FMAX  S2, S7, S27
    FMIN  H24, H6, H3
    FMAXNM  D30, D10, D15
    FMIN  D26, D8, D18
    FMAXNM  H31, H24, H21
    FMINNM  S24, S20, S2
    FMAX  H3, H29, H30
    FMAXNM  D23, D28, D28
    FMAX  H6, H3, H23
    FMINNM  H11, H26, H6
    FMIN  H20, H24, H24
    FMAXNM  D15, D20, D31
    FMINNM  H31, H11, H11
    FMAXNM  S11, S31, S31
    FMINNM  D29, D11, D15
    FMAX  D7, D29, D29
    FMIN  D18, D7, D7
    FMIN  S12, S18, S18
    FMIN  H20, H12, H12
    FMINNM  H7, H20, H21
    FMINNM  D10, D27, D11
    FMIN  H28, H22, H22
    FMINNM  H11, H28, H10
    FMAX  H30, H19, H22
    FMIN  H15, H4, H4
    FMIN  S27, S4, S9
    FMINNM  H18, H31, H4
    FMIN  H28, H21, H21
    FMIN  S29, S26, S17
    FMIN  D22, D19, D11
    FMIN  D26, D21, D18
    FMAX  D17, D6, D11
    FMINNM  S11, S17, S28
    FMINNM  H6, H26, H7
    FMAX  H20, H27, H14
    SUBS  X17, X17, #0x1
    B.NE  TSRTFloatMinMax_label_0
    MOVZ  X21, #0xe7eb, LSL #0
    MOVK  X21, #0xd352, LSL #16
    MOVK  X21, #0xdbfb, LSL #32
    MOVK  X21, #0xc355, LSL #48
    SUB  X20, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xcdc0, LSL #0
    MOVK  X21, #0x7d04, LSL #16
    MOVK  X21, #0x133c, LSL #32
    MOVK  X21, #0x4e53, LSL #48
    SUB  X20, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xabe9, LSL #0
    MOVK  X21, #0x14c4, LSL #16
    MOVK  X21, #0xe7e9, LSL #32
    MOVK  X21, #0x2b68, LSL #48
    SUB  X20, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x5f5e, LSL #0
    MOVK  X21, #0x4bcc, LSL #16
    MOVK  X21, #0x7172, LSL #32
    MOVK  X21, #0x1d59, LSL #48
    SUB  X20, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xac07, LSL #0
    MOVK  X21, #0x5088, LSL #16
    MOVK  X21, #0x8120, LSL #32
    MOVK  X21, #0xa398, LSL #48
    SUB  X20, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xbc4e, LSL #0
    MOVK  X21, #0x74f7, LSL #16
    MOVK  X21, #0x88a2, LSL #32
    MOVK  X21, #0x361, LSL #48
    SUB  X20, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x17a2, LSL #0
    MOVK  X21, #0x846c, LSL #16
    MOVK  X21, #0xc508, LSL #32
    MOVK  X21, #0x111f, LSL #48
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x1bcc, LSL #0
    MOVK  X21, #0x4b3f, LSL #16
    MOVK  X21, #0x583c, LSL #32
    MOVK  X21, #0x6864, LSL #48
    SUB  X20, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x63f3, LSL #0
    MOVK  X21, #0x1465, LSL #16
    MOVK  X21, #0x7199, LSL #32
    MOVK  X21, #0x3293, LSL #48
    SUB  X20, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xc475, LSL #0
    MOVK  X21, #0x8930, LSL #16
    MOVK  X21, #0xa96b, LSL #32
    MOVK  X21, #0x915d, LSL #48
    SUB  X20, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x8af1, LSL #0
    MOVK  X21, #0x6543, LSL #16
    MOVK  X21, #0x221f, LSL #32
    MOVK  X21, #0x1ad5, LSL #48
    SUB  X20, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xc241, LSL #0
    MOVK  X21, #0xbd3, LSL #16
    MOVK  X21, #0x8cfb, LSL #32
    MOVK  X21, #0xd54d, LSL #48
    SUB  X20, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xe0ff, LSL #0
    MOVK  X21, #0xe362, LSL #16
    MOVK  X21, #0xe217, LSL #32
    MOVK  X21, #0xb528, LSL #48
    SUB  X20, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x8466, LSL #0
    MOVK  X21, #0x5edf, LSL #16
    MOVK  X21, #0xb040, LSL #32
    MOVK  X21, #0x7b22, LSL #48
    SUB  X20, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x1319, LSL #0
    MOVK  X21, #0xb16, LSL #16
    MOVK  X21, #0x8aa4, LSL #32
    MOVK  X21, #0xe1a8, LSL #48
    SUB  X20, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xc8a5, LSL #0
    MOVK  X21, #0x9c45, LSL #16
    MOVK  X21, #0xcfa0, LSL #32
    MOVK  X21, #0xb6e6, LSL #48
    SUB  X20, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x41ea, LSL #0
    MOVK  X21, #0x74a8, LSL #16
    MOVK  X21, #0x8172, LSL #32
    MOVK  X21, #0xc187, LSL #48
    SUB  X20, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xdfed, LSL #0
    MOVK  X21, #0xe0bf, LSL #16
    MOVK  X21, #0x50a8, LSL #32
    MOVK  X21, #0x8073, LSL #48
    SUB  X20, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xac9d, LSL #0
    MOVK  X21, #0xc214, LSL #16
    MOVK  X21, #0xfc37, LSL #32
    MOVK  X21, #0x20ee, LSL #48
    SUB  X20, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x2a3e, LSL #0
    MOVK  X21, #0xdd93, LSL #16
    MOVK  X21, #0x7f52, LSL #32
    MOVK  X21, #0x9426, LSL #48
    SUB  X20, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x80, LSL #0
    MRS  X20, FPSR
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V0.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D0
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V1.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D1
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V2.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D2
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V3.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D3
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D4
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V5.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D5
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V6.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D6
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V7.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D7
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V8.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D8
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V9.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D9
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V10.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D10
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V11.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D11
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V12.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D12
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V13.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D13
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V14.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D14
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V15.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D15
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V16.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D16
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V17.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D17
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V18.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D18
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V19.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D19
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V20.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D20
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V21.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D21
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V22.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D22
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V23.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D23
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V24.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D24
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V25.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D25
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V26.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D26
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V27.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D27
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V28.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D28
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D29
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D30
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, V31.D[1]
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X20, D31
    SUB  X3, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X10
    FMOV  V0.D[1], X20
    FMOV  D1, X18
    FMOV  V1.D[1], X23
    FMOV  D2, X29
    FMOV  V2.D[1], X16
    FMOV  D3, X14
    FMOV  V3.D[1], X21
    FMOV  D4, X24
    FMOV  V4.D[1], X28
    FMOV  D5, X22
    FMOV  V5.D[1], X26
    FMOV  D6, X25
    FMOV  V6.D[1], X6
    FMOV  D7, X3
    FMOV  V7.D[1], X29
    FMOV  D8, X14
    FMOV  V8.D[1], X4
    FMOV  D9, X21
    FMOV  V9.D[1], X21
    FMOV  D10, X16
    FMOV  V10.D[1], X28
    FMOV  D11, X20
    FMOV  V11.D[1], X14
    FMOV  D12, X13
    FMOV  V12.D[1], X9
    FMOV  D13, X12
    FMOV  V13.D[1], X6
    FMOV  D14, X9
    FMOV  V14.D[1], X20
    FMOV  D15, X24
    FMOV  V15.D[1], X4
    FMOV  D16, X9
    FMOV  V16.D[1], X26
    FMOV  D17, X25
    FMOV  V17.D[1], X15
    FMOV  D18, X16
    FMOV  V18.D[1], X21
    FMOV  D19, X15
    FMOV  V19.D[1], X13
    FMOV  D20, X20
    FMOV  V20.D[1], X9
    FMOV  D21, X18
    FMOV  V21.D[1], X13
    FMOV  D22, X24
    FMOV  V22.D[1], X28
    FMOV  D23, X4
    FMOV  V23.D[1], X29
    FMOV  D24, X5
    FMOV  V24.D[1], X24
    FMOV  D25, X25
    FMOV  V25.D[1], X14
    FMOV  D26, X28
    FMOV  V26.D[1], X12
    FMOV  D27, X12
    FMOV  V27.D[1], X17
    FMOV  D28, X22
    FMOV  V28.D[1], X5
    FMOV  D29, X21
    FMOV  V29.D[1], X21
    FMOV  D30, X14
    FMOV  V30.D[1], X9
    FMOV  D31, X22
    FMOV  V31.D[1], X17
    MOVZ  X25, #0xf, LSL #0
TSRTFloatMinMax_label_1:
    FMIN  H20, H30, H24
    FMAX  H14, H18, H28
    FMAXNM  S24, S14, S25
    FMAX  D10, D31, D27
    FMAX  D23, D26, D20
    FMINNM  D18, D29, D23
    FMAX  S31, S18, S10
    FMIN  D1, D24, D24
    FMAX  H6, H1, H31
    FMIN  D13, D6, D6
    FMIN  H20, H13, H13
    FMIN  H30, H20, H20
    FMAX  S14, S30, S30
    FMIN  S10, S27, S3
    FMAX  D25, D2, D14
    FMINNM  D30, D11, D29
    FMIN  S28, S2, S16
    FMAXNM  S11, S18, S16
    FMINNM  D16, D2, D20
    FMAXNM  H18, H30, H9
    FMAX  S29, S12, S30
    FMAX  S12, S30, S15
    FMINNM  S24, S13, S11
    FMAX  D31, D3, D14
    FMINNM  D11, D10, D31
    FMAXNM  S6, S24, S11
    FMIN  D9, D12, D25
    FMAXNM  S15, S9, S9
    FMINNM  S26, S28, S15
    FMAX  S11, S29, S10
    FMINNM  S27, S18, S6
    FMAX  H18, H16, H27
    FMIN  H2, H11, H11
    FMINNM  S31, S26, S26
    FMIN  H1, H2, H19
    FMAXNM  S16, S1, S18
    FMAX  D20, D16, D31
    FMINNM  H13, H26, H24
    FMIN  D12, D24, D27
    FMIN  H10, H4, H24
    FMAXNM  S4, S19, S3
    FMAXNM  D31, D17, D22
    FMINNM  S16, S29, S24
    FMAXNM  D11, D2, D10
    FMINNM  S30, S7, S5
    FMIN  S5, S30, S22
    FMINNM  H7, H7, H29
    FMINNM  D24, D12, D20
    FMAXNM  S2, S13, S11
    FMAX  D26, D5, D16
    FMINNM  H20, H26, H4
    FMIN  D16, D2, D31
    FMAX  H5, H20, H7
    FMINNM  D17, D5, D11
    FMINNM  H7, H17, H24
    FMIN  H26, H4, H16
    FMAX  D4, D12, D7
    FMIN  S10, S4, S18
    FMAX  H7, H10, H10
    FMINNM  D24, D26, D7
    FMAX  D19, D15, D13
    FMAX  H31, H17, H12
    FMAX  H5, H6, H11
    FMINNM  H15, H25, H22
    FMIN  H29, H6, H5
    FMINNM  H13, H21, H17
    FMIN  H21, H13, H12
    FMIN  H25, H10, H28
    FMIN  D26, D28, D27
    FMIN  H7, H12, H7
    FMAXNM  D18, D21, D12
    FMINNM  D2, D31, D31
    FMINNM  H30, H10, H8
    FMINNM  S12, S30, S15
    FMINNM  H22, H29, H7
    FMIN  S4, S1, S25
    FMAX  S16, S19, S19
    FMIN  S20, S22, S2
    FMIN  H11, H4, H4
    FMIN  D4, D24, D18
    FMAXNM  H10, H16, H12
    FMINNM  D12, D10, D11
    FMIN  H5, H26, H26
    FMIN  S19, S20, S5
    FMAX  H8, H4, H4
    FMAXNM  S16, S31, S19
    FMINNM  S5, S26, S16
    FMINNM  D22, D5, D8
    FMAX  S31, S12, S12
    FMAXNM  D18, D31, D11
    FMAXNM  H5, H22, H22
    FMINNM  S12, S18, S1
    FMAXNM  D8, D12, D12
    FMAXNM  D20, D8, D8
    FMAXNM  D22, D20, D20
    FMAX  D31, D22, D5
    FMINNM  H22, H26, H15
    FMAXNM  D16, D19, D17
    FMAXNM  S1, S28, S26
    FMINNM  D4, D25, D17
    FMIN  S10, S18, S15
    FMAX  S11, S21, S14
    FMIN  H12, H12, H28
    FMAX  S14, S11, S20
    FMAX  H7, H3, H1
    FMAX  H19, H6, H9
    FMINNM  S28, S31, S7
    FMIN  S7, S14, S30
    FMIN  S8, S7, S22
    FMIN  S11, S19, S27
    FMAXNM  H1, H4, H11
    FMIN  D17, D1, D1
    FMAXNM  D5, D28, D12
    FMAXNM  D27, D24, D5
    FMAXNM  H21, H10, H8
    FMINNM  H7, H27, H17
    FMINNM  H6, H16, H16
    FMIN  H31, H21, H6
    FMAX  H26, H19, H7
    FMAX  H1, H16, H31
    FMIN  H12, H26, H26
    FMIN  H31, H12, H1
    FMINNM  D9, D15, D10
    FMINNM  S19, S14, S22
    FMAXNM  S8, S8, S8
    FMIN  D21, D25, D9
    FMINNM  H9, H7, H21
    FMIN  H3, H8, H24
    FMAXNM  H18, H27, H2
    FMAX  H16, H1, H10
    FMINNM  S30, S9, S17
    FMAX  D10, D22, D1
    FMAX  H5, H30, H7
    FMAXNM  S1, S27, S21
    FMINNM  S4, S22, S19
    FMAXNM  D27, D6, D14
    FMINNM  D12, D31, D18
    FMAX  D11, D27, D3
    FMAX  S8, S5, S4
    FMIN  S14, S11, S10
    FMINNM  D6, D14, D1
    FMIN  D28, D16, D6
    FMAX  S9, S8, S12
    FMIN  D17, D28, D28
    FMAX  D4, D24, D17
    FMAX  D10, D4, D9
    FMINNM  D25, D21, D27
    FMAXNM  D14, D30, D10
    FMAXNM  H1, H28, H24
    FMAXNM  S16, S7, S9
    FMINNM  S21, S24, S16
    FMAX  H5, H17, H9
    FMIN  H15, H26, H13
    FMINNM  H3, H6, H17
    FMINNM  H22, H26, H9
    FMIN  S9, S24, S15
    FMINNM  S27, S10, S4
    FMAX  H11, H1, H27
    FMAX  D12, D11, D9
    FMIN  D7, D3, D0
    FMAX  S24, S7, S22
    FMAX  S7, S12, S5
    FMINNM  S30, S24, S21
    FMAX  S15, S14, S25
    FMAX  H16, H15, H15
    FMAXNM  D15, D16, D16
    FMAX  H28, H11, H15
    FMINNM  S14, S8, S7
    FMIN  S4, S30, S28
    FMINNM  D7, D19, D14
    FMAX  H25, H7, H4
    FMAX  H16, H11, H12
    FMAX  D10, D1, D14
    FMAXNM  H22, H2, H31
    FMAXNM  D4, D0, D28
    FMIN  S13, S6, S0
    FMIN  S3, S0, S5
    FMAXNM  S11, S26, S7
    FMAXNM  H12, H15, H0
    FMIN  D8, D25, D10
    FMIN  D28, D11, D4
    FMAX  D7, D22, D28
    FMIN  S6, S16, S12
    FMAX  S5, S17, S13
    FMIN  D26, D5, D3
    FMAX  H3, H8, H26
    FMAX  H25, H3, H7
    FMIN  D13, D6, D25
    FMINNM  D30, D29, D6
    FMAXNM  S25, S14, S22
    FMAXNM  H10, H23, H7
    FMAXNM  D24, D30, D2
    FMAXNM  H22, H1, H17
    FMAXNM  S31, S1, S26
    FMIN  D29, D1, D4
    FMIN  S11, S7, S17
    FMAX  S0, S27, S27
    FMINNM  H19, H29, H13
    FMIN  D3, D31, D11
    FMAX  H27, H0, H25
    SUBS  X25, X25, #0x1
    B.NE  TSRTFloatMinMax_label_1
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x80, LSL #0
    MRS  X14, FPSR
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D1
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D3
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D8
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D9
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D10
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D11
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D12
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D19
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D20
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D22
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, D31
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatMinMax_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X24
    FMOV  D3, X15
    FMOV  V3.D[1], X9
    FMOV  D4, X12
    FMOV  V4.D[1], X7
    FMOV  D5, X25
    FMOV  V5.D[1], X4
    FMOV  D6, X5
    FMOV  V6.D[1], X8
    FMOV  D7, X12
    FMOV  V7.D[1], X24
    FMOV  D8, X13
    FMOV  V8.D[1], X3
    FMOV  D9, X8
    FMOV  V9.D[1], X4
    FMOV  D10, X13
    FMOV  V10.D[1], X7
    FMOV  D11, X14
    FMOV  V11.D[1], X21
    FMOV  D12, X15
    FMOV  V12.D[1], X5
    FMOV  D13, X21
    FMOV  V13.D[1], X18
    FMOV  D14, X7
    FMOV  V14.D[1], X3
    FMOV  D15, X3
    FMOV  V15.D[1], X12
    FMOV  D16, X23
    FMOV  V16.D[1], X22
    FMOV  D17, X29
    FMOV  V17.D[1], X28
    FMOV  D18, X14
    FMOV  V18.D[1], X20
    FMOV  D19, X6
    FMOV  V19.D[1], X6
    FMOV  D20, X8
    FMOV  V20.D[1], X21
    FMOV  D21, X28
    FMOV  V21.D[1], X28
    FMOV  D22, X5
    FMOV  V22.D[1], X24
    FMOV  D23, X22
    FMOV  V23.D[1], X16
    FMOV  D24, X3
    FMOV  V24.D[1], X4
    FMOV  D25, X15
    FMOV  V25.D[1], X9
    FMOV  D26, X28
    FMOV  V26.D[1], X24
    FMOV  D27, X5
    FMOV  V27.D[1], X28
    FMOV  D28, X25
    FMOV  V28.D[1], X4
    FMOV  D29, X17
    FMOV  V29.D[1], X28
    FMOV  D30, X28
    FMOV  V30.D[1], X15
    FMOV  D31, X28
    FMOV  V31.D[1], X28
    MOVZ  X13, #0xf, LSL #0
TSRTFloatMinMax_label_2:
    FMAX  D21, D27, D26
    FMAXNM  S6, S25, S20
    FMAXNM  H10, H24, H21
    FMAXNM  H12, H29, H30
    FMAX  D4, D28, D6
    FMAXNM  H19, H31, H31
    FMAX  D29, D19, D4
    FMAXNM  D12, D22, D10
    FMINNM  H13, H12, H12
    FMIN  H27, H13, H13
    FMINNM  S26, S27, S23
    FMAXNM  H20, H26, H29
    FMAXNM  S19, S15, S20
    FMAX  H25, H27, H8
    FMAXNM  D21, D14, D30
    FMAX  D28, D6, D17
    FMINNM  D23, D28, D12
    FMAXNM  S10, S3, S29
    FMINNM  S8, S14, S1
    FMAX  S20, S28, S31
    FMAXNM  D15, D19, D31
    FMAX  H24, H4, H15
    FMINNM  D28, D28, D30
    FMINNM  S15, S18, S0
    FMAX  D13, D26, D15
    FMIN  H18, H25, H21
    FMINNM  H14, H18, H23
    FMAX  H6, H20, H28
    FMINNM  D22, D24, D24
    FMAX  D27, D10, D22
    FMAX  D19, D8, D4
    FMINNM  H24, H0, H19
    FMAX  S4, S13, S27
    FMINNM  D26, D6, D14
    FMAXNM  S19, S4, S24
    FMAX  D10, D19, D26
    FMAX  S26, S13, S25
    FMIN  S27, S5, S12
    FMIN  H19, H28, H11
    FMAX  S25, S18, S20
    FMIN  S31, S6, S0
    FMINNM  H14, H24, H9
    FMAX  H18, H4, H8
    FMAX  H21, H2, H3
    FMINNM  H15, H21, H26
    FMINNM  H12, H27, H19
    FMIN  D4, D12, D10
    FMAXNM  S24, S4, S14
    FMINNM  H1, H31, H18
    FMAXNM  H13, H1, H24
    FMAXNM  H21, H15, H13
    FMAXNM  S31, S25, S25
    FMIN  H5, H21, H31
    FMIN  S25, S23, S27
    FMIN  S22, S3, S30
    FMAXNM  H13, H11, H13
    FMIN  S14, S3, S1
    FMAXNM  S4, S31, S21
    FMIN  S20, S23, S2
    FMINNM  S31, S23, S10
    FMAX  H9, H25, H17
    FMINNM  S26, S1, S14
    FMAXNM  D3, D1, D8
    FMIN  S23, S22, S26
    FMIN  D18, D5, D9
    FMINNM  S19, S13, S13
    FMINNM  S24, S19, S30
    FMAX  D27, D20, D31
    FMIN  S15, S4, S4
    FMINNM  D12, D24, D27
    FMINNM  H10, H23, H3
    FMAXNM  S17, S18, S10
    FMIN  D11, D12, D15
    FMINNM  H4, H11, H11
    FMAX  D3, D17, D4
    FMIN  S14, S21, S18
    FMIN  D15, D20, D21
    FMAX  S30, S24, S16
    FMINNM  D13, D13, D16
    FMAXNM  H23, H30, H21
    FMIN  D9, D4, D15
    FMIN  H27, H18, H24
    FMAXNM  H21, H17, H3
    FMAX  S1, S22, S6
    FMINNM  S10, S28, S5
    FMINNM  H5, H11, H27
    FMAX  S31, S5, S17
    FMINNM  D18, D6, D15
    FMAXNM  S12, S21, S1
    FMAX  H20, H14, H4
    FMIN  H25, H7, H31
    FMINNM  D27, D13, D25
    FMAX  H6, H18, H27
    FMIN  H25, H23, H20
    FMAX  S19, S6, S12
    FMINNM  D12, D10, D25
    FMIN  H5, H12, H12
    FMAXNM  S4, S9, S9
    FMINNM  H15, H5, H19
    FMAX  S27, S17, S15
    FMINNM  S21, S2, S4
    FMAXNM  S10, S21, S21
    FMINNM  D1, D10, D11
    FMIN  D28, D27, D27
    FMAX  H17, H1, H28
    FMAXNM  S28, S22, S2
    FMINNM  H23, H22, H22
    FMINNM  H18, H31, H18
    FMAXNM  D7, D13, D8
    FMINNM  H21, H4, H23
    FMINNM  S12, S13, S8
    FMINNM  S31, S13, S15
    FMIN  D2, D30, D0
    FMINNM  S22, S13, S3
    FMAXNM  S1, S21, S28
    FMIN  S27, S1, S17
    FMAXNM  H10, H18, H27
    FMAX  D11, D10, D7
    FMIN  H7, H12, H12
    FMAX  D0, D7, D9
    FMAX  S23, S31, S11
    FMINNM  D7, D23, D22
    FMINNM  D17, D2, D0
    FMAXNM  D20, D7, D17
    FMAXNM  D30, D31, D26
    FMIN  D8, D22, D14
    FMIN  H27, H28, H28
    FMINNM  H23, H2, H6
    FMAXNM  D18, D30, D1
    FMIN  D21, D3, D17
    FMIN  D15, D27, D15
    FMIN  S27, S0, S2
    FMAX  D10, D20, D19
    FMINNM  D17, D23, D31
    FMINNM  H22, H28, H29
    FMAX  S11, S3, S0
    FMAXNM  S26, S27, S18
    FMIN  H31, H8, H24
    FMAXNM  D14, D31, D31
    FMIN  S0, S26, S21
    FMIN  D19, D15, D15
    FMIN  H29, H14, H10
    FMAXNM  D20, D17, D0
    FMAXNM  S30, S22, S22
    FMAXNM  S9, S30, S30
    FMAXNM  H28, H19, H11
    FMINNM  D23, D29, D9
    FMAX  H6, H10, H23
    FMAXNM  D7, D28, D20
    FMAXNM  S29, S31, S6
    FMAXNM  H23, H29, H7
    FMAX  D17, D11, D1
    FMAX  D29, D0, D28
    FMINNM  S9, S22, S9
    FMINNM  D31, D29, D31
    FMIN  D18, D28, D6
    FMAXNM  S30, S29, S24
    FMAXNM  H10, H22, H8
    FMAXNM  H1, H1, H13
    FMIN  D20, D21, D17
    FMAXNM  D0, D20, D2
    FMAXNM  D6, D11, D25
    FMIN  S19, S0, S23
    FMAX  D20, D18, D30
    FMAXNM  D29, D10, D9
    FMAXNM  D14, D1, D31
    FMIN  S22, S6, S6
    FMAX  H7, H19, H14
    FMINNM  S13, S7, S20
    FMAXNM  H20, H29, H29
    FMIN  H21, H20, H20
    FMIN  S29, S21, S22
    FMAXNM  D23, D29, D7
    FMINNM  H6, H13, H23
    FMIN  D13, D4, D2
    FMINNM  S8, S26, S28
    FMAX  H4, H25, H19
    FMIN  D24, D4, D27
    FMAX  D18, D22, D8
    FMIN  H9, H5, H3
    FMAX  H5, H31, H15
    FMAX  D4, D11, D4
    FMIN  H10, H23, H9
    FMIN  D9, D11, D14
    FMAXNM  S21, S17, S8
    FMINNM  S20, S6, S4
    FMIN  D2, D9, D21
    FMAXNM  H21, H2, H18
    FMIN  S19, S24, S5
    FMINNM  D18, D21, D20
    FMAX  D23, D19, D19
    FMAX  H11, H13, H13
    FMAX  S22, S10, S10
    FMAXNM  D6, D18, D11
    FMINNM  D18, D23, D23
    FMINNM  H11, H6, H18
    FMIN  D18, D11, D11
    FMIN  D19, D18, D22
    FMAX  S10, S15, S13
    FMAX  H17, H10, H18
    SUBS  X13, X13, #0x1
    B.NE  TSRTFloatMinMax_label_2
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x80, LSL #0
    MRS  X16, FPSR
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D10
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, V16.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X16, D16
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D20
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X7, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x2f7f, LSL #0
    MOVK  X3, #0x1728, LSL #16
    MOVK  X3, #0x3132, LSL #32
    MOVK  X3, #0x21d9, LSL #48
    MOVZ  X4, #0x1e47, LSL #0
    MOVK  X4, #0x4d54, LSL #16
    MOVK  X4, #0xb70b, LSL #32
    MOVK  X4, #0x65c6, LSL #48
    MOVZ  X5, #0xbf25, LSL #0
    MOVK  X5, #0x747f, LSL #16
    MOVK  X5, #0xfb0e, LSL #32
    MOVK  X5, #0x3582, LSL #48
    MOVZ  X6, #0x5062, LSL #0
    MOVK  X6, #0x2baf, LSL #16
    MOVK  X6, #0x65bf, LSL #32
    MOVK  X6, #0x8e5a, LSL #48
    MOVZ  X7, #0x1a63, LSL #0
    MOVK  X7, #0xc27b, LSL #16
    MOVK  X7, #0x3629, LSL #32
    MOVK  X7, #0xcbfb, LSL #48
    MOVZ  X8, #0x8d79, LSL #0
    MOVK  X8, #0x7351, LSL #16
    MOVK  X8, #0xee8e, LSL #32
    MOVK  X8, #0x5883, LSL #48
    MOVZ  X9, #0xf134, LSL #0
    MOVK  X9, #0xe54e, LSL #16
    MOVK  X9, #0xc246, LSL #32
    MOVK  X9, #0x8b67, LSL #48
    MOVZ  X10, #0x4f9, LSL #0
    MOVK  X10, #0x38e9, LSL #16
    MOVK  X10, #0x3ea3, LSL #32
    MOVK  X10, #0x86d4, LSL #48
    MOVZ  X12, #0x28e3, LSL #0
    MOVK  X12, #0x72, LSL #16
    MOVK  X12, #0x1d28, LSL #32
    MOVK  X12, #0x92a2, LSL #48
    MOVZ  X13, #0x64c6, LSL #0
    MOVK  X13, #0x2dcd, LSL #16
    MOVK  X13, #0x3a05, LSL #32
    MOVK  X13, #0xedf7, LSL #48
    MOVZ  X14, #0xc120, LSL #0
    MOVK  X14, #0x7666, LSL #16
    MOVK  X14, #0xb592, LSL #32
    MOVK  X14, #0xe1ee, LSL #48
    MOVZ  X15, #0x2997, LSL #0
    MOVK  X15, #0x13dd, LSL #16
    MOVK  X15, #0xe7c8, LSL #32
    MOVK  X15, #0x9609, LSL #48
    MOVZ  X16, #0x77e0, LSL #0
    MOVK  X16, #0xf24a, LSL #16
    MOVK  X16, #0xd57, LSL #32
    MOVK  X16, #0x1d68, LSL #48
    MOVZ  X17, #0x5eea, LSL #0
    MOVK  X17, #0x933f, LSL #16
    MOVK  X17, #0x5de7, LSL #32
    MOVK  X17, #0xbc41, LSL #48
    MOVZ  X18, #0xbb0e, LSL #0
    MOVK  X18, #0xf262, LSL #16
    MOVK  X18, #0x8144, LSL #32
    MOVK  X18, #0x1197, LSL #48
    MOVZ  X20, #0xfb04, LSL #0
    MOVK  X20, #0xc829, LSL #16
    MOVK  X20, #0xd0b6, LSL #32
    MOVK  X20, #0xd644, LSL #48
    MOVZ  X21, #0xea63, LSL #0
    MOVK  X21, #0x7a19, LSL #16
    MOVK  X21, #0x1379, LSL #32
    MOVK  X21, #0x3545, LSL #48
    MOVZ  X22, #0x92f3, LSL #0
    MOVK  X22, #0xbdc1, LSL #16
    MOVK  X22, #0x4f15, LSL #32
    MOVK  X22, #0xb6ac, LSL #48
    MOVZ  X23, #0x8e33, LSL #0
    MOVK  X23, #0x9fe4, LSL #16
    MOVK  X23, #0xed63, LSL #32
    MOVK  X23, #0x5a26, LSL #48
    MOVZ  X24, #0xc0af, LSL #0
    MOVK  X24, #0x8cb4, LSL #16
    MOVK  X24, #0xda94, LSL #32
    MOVK  X24, #0xb99, LSL #48
    MOVZ  X25, #0xd923, LSL #0
    MOVK  X25, #0x6057, LSL #16
    MOVK  X25, #0xefdd, LSL #32
    MOVK  X25, #0xbab5, LSL #48
    MOVZ  X26, #0xc2e4, LSL #0
    MOVK  X26, #0x580a, LSL #16
    MOVK  X26, #0xa7ef, LSL #32
    MOVK  X26, #0xf805, LSL #48
    MOVZ  X28, #0x7d1e, LSL #0
    MOVK  X28, #0xd9b, LSL #16
    MOVK  X28, #0x5342, LSL #32
    MOVK  X28, #0x5508, LSL #48
    MOVZ  X29, #0x5838, LSL #0
    MOVK  X29, #0xcc4e, LSL #16
    MOVK  X29, #0x9d94, LSL #32
    MOVK  X29, #0x987f, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X24
    FMOV  V3.D[1], X26
    FMOV  D4, X23
    FMOV  V4.D[1], X10
    FMOV  D5, X7
    FMOV  V5.D[1], X12
    FMOV  D6, X13
    FMOV  V6.D[1], X14
    FMOV  D7, X16
    FMOV  V7.D[1], X7
    FMOV  D8, X7
    FMOV  V8.D[1], X8
    FMOV  D9, X25
    FMOV  V9.D[1], X14
    FMOV  D10, X10
    FMOV  V10.D[1], X16
    FMOV  D11, X5
    FMOV  V11.D[1], X17
    FMOV  D12, X6
    FMOV  V12.D[1], X17
    FMOV  D13, X3
    FMOV  V13.D[1], X3
    FMOV  D14, X20
    FMOV  V14.D[1], X22
    FMOV  D15, X20
    FMOV  V15.D[1], X13
    FMOV  D16, X24
    FMOV  V16.D[1], X21
    FMOV  D17, X24
    FMOV  V17.D[1], X6
    FMOV  D18, X4
    FMOV  V18.D[1], X7
    FMOV  D19, X20
    FMOV  V19.D[1], X21
    FMOV  D20, X23
    FMOV  V20.D[1], X5
    FMOV  D21, X22
    FMOV  V21.D[1], X10
    FMOV  D22, X25
    FMOV  V22.D[1], X15
    FMOV  D23, X23
    FMOV  V23.D[1], X4
    FMOV  D24, X7
    FMOV  V24.D[1], X29
    FMOV  D25, X14
    FMOV  V25.D[1], X5
    FMOV  D26, X28
    FMOV  V26.D[1], X26
    FMOV  D27, X7
    FMOV  V27.D[1], X15
    FMOV  D28, X12
    FMOV  V28.D[1], X6
    FMOV  D29, X7
    FMOV  V29.D[1], X24
    FMOV  D30, X25
    FMOV  V30.D[1], X22
    FMOV  D31, X25
    FMOV  V31.D[1], X16
    MOVZ  X24, #0xf, LSL #0
TSRTFloatMinMax_label_3:
    FMAX  S1, S24, S23
    FMIN  S8, S1, S27
    FMINNM  S0, S19, S8
    FMAXNM  D12, D0, D30
    FMIN  S10, S31, S25
    FMAX  S7, S28, S28
    FMAXNM  D21, D29, D29
    FMINNM  H30, H26, H26
    FMAXNM  S22, S12, S12
    FMAX  S23, S22, S30
    FMAX  H28, H23, H10
    FMAX  H24, H28, H21
    FMIN  D22, D7, D4
    FMAXNM  S14, S24, S18
    FMAXNM  D24, D22, D14
    FMIN  S23, S30, S1
    FMAX  D0, D23, D4
    FMIN  H12, H1, H16
    FMAX  D22, D21, D7
    FMAX  S25, S20, S4
    FMAX  S10, S3, S13
    FMAX  S19, S24, S14
    FMAXNM  S21, S19, S27
    FMAXNM  D30, D2, D0
    FMAXNM  S16, S16, S10
    FMINNM  S19, S26, S28
    FMAX  H27, H0, H10
    FMINNM  D23, D17, D18
    FMAXNM  S7, S6, S12
    FMAXNM  D17, D22, D25
    FMAXNM  S25, S22, S19
    FMIN  S28, S25, S26
    FMINNM  D2, D28, D21
    FMIN  D14, D17, D27
    FMIN  S17, S30, S30
    FMAX  D10, D7, D2
    FMINNM  H7, H14, H14
    FMIN  D18, D17, D7
    FMINNM  H4, H23, H23
    FMAXNM  H28, H3, H10
    FMAXNM  H20, H16, H16
    FMAXNM  S24, S1, S20
    FMINNM  S19, S28, S24
    FMINNM  D20, D4, D18
    FMAXNM  D23, D20, D22
    FMINNM  D22, D19, D19
    FMIN  D10, D22, D23
    FMIN  H30, H9, H17
    FMIN  D27, D4, D7
    FMINNM  D14, D15, D10
    FMINNM  H26, H15, H20
    FMAX  H4, H7, H4
    FMINNM  D2, D30, D12
    FMAX  D12, D17, D29
    FMAX  D17, D16, D7
    FMIN  S18, S22, S21
    FMAX  H28, H30, H17
    FMINNM  D23, D8, D9
    FMINNM  D9, D27, D14
    FMAXNM  S24, S9, S4
    FMAX  H19, H24, H26
    FMAXNM  S7, S28, S19
    FMINNM  D26, D12, D18
    FMINNM  D8, D7, D2
    FMIN  H24, H8, H23
    FMAX  H14, H26, H26
    FMINNM  D27, D14, D14
    FMINNM  D21, D9, D24
    FMINNM  S4, S25, S21
    FMAXNM  S14, S4, S27
    FMAXNM  S27, S27, S31
    FMINNM  S29, S12, S30
    FMINNM  S4, S16, S17
    FMIN  H31, H31, H5
    FMIN  S18, S7, S7
    FMAX  H26, H30, H16
    FMIN  H12, H6, H31
    FMINNM  S8, S31, S4
    FMAXNM  D9, D26, D10
    FMINNM  S10, S5, S14
    FMINNM  D24, D3, D23
    FMIN  H30, H30, H6
    FMINNM  D21, D18, D18
    FMIN  D2, D21, D24
    FMINNM  D22, D29, D2
    FMAXNM  S23, S30, S10
    FMAXNM  D18, D27, D23
    FMIN  S14, S9, S22
    FMAXNM  D23, D8, D14
    FMAXNM  H16, H12, H23
    FMAX  S28, S18, S18
    FMAXNM  D9, D28, D28
    FMIN  D23, D23, D16
    FMAXNM  S22, S23, S23
    FMINNM  D5, D22, D9
    FMAX  H2, H24, H31
    FMINNM  D21, D4, D21
    FMINNM  D6, D27, D5
    FMINNM  S3, S17, S9
    FMAX  D27, D0, D9
    FMIN  S0, S16, S3
    FMINNM  D22, D26, D14
    FMAXNM  D31, D7, D6
    FMAX  H30, H18, H10
    FMINNM  D28, D4, D17
    FMAXNM  D6, D2, D19
    FMAXNM  D23, D29, D7
    FMAXNM  H24, H31, H21
    FMAXNM  H12, H15, H30
    FMIN  S3, S6, S27
    FMAX  H21, H0, H12
    FMIN  S26, S21, S28
    FMIN  S8, S23, S22
    FMIN  D5, D24, D26
    FMAX  H16, H5, H8
    FMAX  H12, H16, H3
    FMAX  D30, D18, D12
    FMAX  S22, S19, S28
    FMAX  S10, S3, S11
    FMAXNM  S16, S6, S15
    FMIN  D12, D21, D25
    FMIN  D18, D13, D16
    FMAXNM  H6, H29, H8
    FMINNM  S24, S17, S12
    FMIN  S3, S8, S22
    FMAXNM  S7, S22, S2
    FMINNM  H28, H4, H27
    FMAXNM  S19, S30, S3
    FMAX  H0, H12, H15
    FMAXNM  S29, S23, S4
    FMINNM  D14, D24, D29
    FMAX  D5, D7, D28
    FMIN  S24, S5, S14
    FMINNM  H14, H6, H10
    FMAX  H10, H0, H18
    FMAX  D8, D14, D10
    FMIN  S22, S24, S8
    FMAXNM  D11, D22, D19
    FMINNM  D27, D8, D5
    FMAX  D5, D0, D30
    FMAX  H15, H15, H15
    FMINNM  S18, S16, S1
    FMINNM  S24, S10, S16
    FMIN  H4, H22, H10
    FMAX  S14, S13, S2
    FMAX  D7, D5, D10
    FMAXNM  H19, H24, H15
    FMINNM  S1, S15, S13
    FMIN  S25, S8, S15
    FMIN  D6, D11, D18
    FMAXNM  H15, H7, H6
    FMINNM  H0, H15, H25
    FMAX  S24, S14, S1
    FMAX  S7, S19, S24
    FMIN  D24, D0, D27
    FMIN  S1, S24, S24
    FMAX  H19, H4, H1
    FMINNM  D27, D19, D7
    FMAX  H5, H18, H26
    FMINNM  H13, H28, H0
    FMINNM  H28, H28, H4
    FMINNM  D25, D24, D2
    FMIN  D24, D22, D11
    FMAXNM  S14, S11, S8
    FMAXNM  S15, S23, S24
    FMAXNM  S30, S12, S20
    FMAX  H1, H28, H15
    FMINNM  D26, D27, D14
    FMIN  D11, D12, D6
    FMINNM  H2, H8, H28
    FMAX  D12, D19, D18
    FMAXNM  D24, D1, D11
    FMAXNM  S22, S24, S12
    FMIN  H6, H22, H5
    FMAX  D24, D30, D25
    FMAX  S15, S24, S26
    FMINNM  D27, D6, D2
    FMAX  D7, D31, D27
    FMAXNM  H28, H15, H15
    FMIN  D5, D7, D7
    FMAX  D25, D28, D28
    FMAX  D28, D25, D5
    FMAX  S5, S28, S28
    FMIN  D25, D5, D5
    FMIN  S14, S25, S25
    FMINNM  D7, D14, D14
    FMAXNM  D22, D7, D7
    FMINNM  S2, S22, S22
    FMINNM  H1, H2, H2
    FMINNM  H6, H1, H1
    FMAXNM  H28, H20, H6
    FMINNM  H11, H28, H28
    FMINNM  S7, S3, S6
    FMAXNM  H28, H9, H5
    FMIN  H30, H5, H1
    FMINNM  S9, S13, S22
    FMINNM  H2, H30, H25
    FMAXNM  S13, S25, S30
    FMIN  H22, H1, H21
    FMAX  S14, S13, S15
    SUBS  X24, X24, #0x1
    B.NE  TSRTFloatMinMax_label_3
    MOVZ  X21, #0x2f7f, LSL #0
    MOVK  X21, #0x1728, LSL #16
    MOVK  X21, #0x3132, LSL #32
    MOVK  X21, #0x21d9, LSL #48
    SUB  X14, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x1e47, LSL #0
    MOVK  X21, #0x4d54, LSL #16
    MOVK  X21, #0xb70b, LSL #32
    MOVK  X21, #0x65c6, LSL #48
    SUB  X14, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xbf25, LSL #0
    MOVK  X21, #0x747f, LSL #16
    MOVK  X21, #0xfb0e, LSL #32
    MOVK  X21, #0x3582, LSL #48
    SUB  X14, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x5062, LSL #0
    MOVK  X21, #0x2baf, LSL #16
    MOVK  X21, #0x65bf, LSL #32
    MOVK  X21, #0x8e5a, LSL #48
    SUB  X14, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x1a63, LSL #0
    MOVK  X21, #0xc27b, LSL #16
    MOVK  X21, #0x3629, LSL #32
    MOVK  X21, #0xcbfb, LSL #48
    SUB  X14, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x8d79, LSL #0
    MOVK  X21, #0x7351, LSL #16
    MOVK  X21, #0xee8e, LSL #32
    MOVK  X21, #0x5883, LSL #48
    SUB  X14, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xf134, LSL #0
    MOVK  X21, #0xe54e, LSL #16
    MOVK  X21, #0xc246, LSL #32
    MOVK  X21, #0x8b67, LSL #48
    SUB  X14, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x28e3, LSL #0
    MOVK  X21, #0x72, LSL #16
    MOVK  X21, #0x1d28, LSL #32
    MOVK  X21, #0x92a2, LSL #48
    SUB  X14, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x64c6, LSL #0
    MOVK  X21, #0x2dcd, LSL #16
    MOVK  X21, #0x3a05, LSL #32
    MOVK  X21, #0xedf7, LSL #48
    SUB  X14, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x2997, LSL #0
    MOVK  X21, #0x13dd, LSL #16
    MOVK  X21, #0xe7c8, LSL #32
    MOVK  X21, #0x9609, LSL #48
    SUB  X14, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x77e0, LSL #0
    MOVK  X21, #0xf24a, LSL #16
    MOVK  X21, #0xd57, LSL #32
    MOVK  X21, #0x1d68, LSL #48
    SUB  X14, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x5eea, LSL #0
    MOVK  X21, #0x933f, LSL #16
    MOVK  X21, #0x5de7, LSL #32
    MOVK  X21, #0xbc41, LSL #48
    SUB  X14, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xbb0e, LSL #0
    MOVK  X21, #0xf262, LSL #16
    MOVK  X21, #0x8144, LSL #32
    MOVK  X21, #0x1197, LSL #48
    SUB  X14, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xfb04, LSL #0
    MOVK  X21, #0xc829, LSL #16
    MOVK  X21, #0xd0b6, LSL #32
    MOVK  X21, #0xd644, LSL #48
    SUB  X14, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x92f3, LSL #0
    MOVK  X21, #0xbdc1, LSL #16
    MOVK  X21, #0x4f15, LSL #32
    MOVK  X21, #0xb6ac, LSL #48
    SUB  X14, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x8e33, LSL #0
    MOVK  X21, #0x9fe4, LSL #16
    MOVK  X21, #0xed63, LSL #32
    MOVK  X21, #0x5a26, LSL #48
    SUB  X14, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xd923, LSL #0
    MOVK  X21, #0x6057, LSL #16
    MOVK  X21, #0xefdd, LSL #32
    MOVK  X21, #0xbab5, LSL #48
    SUB  X14, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0xc2e4, LSL #0
    MOVK  X21, #0x580a, LSL #16
    MOVK  X21, #0xa7ef, LSL #32
    MOVK  X21, #0xf805, LSL #48
    SUB  X14, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x7d1e, LSL #0
    MOVK  X21, #0xd9b, LSL #16
    MOVK  X21, #0x5342, LSL #32
    MOVK  X21, #0x5508, LSL #48
    SUB  X14, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x5838, LSL #0
    MOVK  X21, #0xcc4e, LSL #16
    MOVK  X21, #0x9d94, LSL #32
    MOVK  X21, #0x987f, LSL #48
    SUB  X14, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x81, LSL #0
    MRS  X14, FPSR
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D1
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D3
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D8
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D9
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D10
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D11
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D12
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D19
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D20
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D22
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X14, D31
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X8
    FMOV  V0.D[1], X20
    FMOV  D1, X21
    FMOV  V1.D[1], X29
    FMOV  D2, X25
    FMOV  V2.D[1], X28
    FMOV  D3, X22
    FMOV  V3.D[1], X10
    FMOV  D4, X16
    FMOV  V4.D[1], X26
    FMOV  D5, X18
    FMOV  V5.D[1], X23
    FMOV  D6, X24
    FMOV  V6.D[1], X9
    FMOV  D7, X4
    FMOV  V7.D[1], X13
    FMOV  D8, X13
    FMOV  V8.D[1], X13
    FMOV  D9, X13
    FMOV  V9.D[1], X6
    FMOV  D10, X26
    FMOV  V10.D[1], X5
    FMOV  D11, X26
    FMOV  V11.D[1], X29
    FMOV  D12, X23
    FMOV  V12.D[1], X12
    FMOV  D13, X9
    FMOV  V13.D[1], X29
    FMOV  D14, X26
    FMOV  V14.D[1], X9
    FMOV  D15, X4
    FMOV  V15.D[1], X13
    FMOV  D16, X21
    FMOV  V16.D[1], X12
    FMOV  D17, X16
    FMOV  V17.D[1], X15
    FMOV  D18, X12
    FMOV  V18.D[1], X8
    FMOV  D19, X24
    FMOV  V19.D[1], X25
    FMOV  D20, X9
    FMOV  V20.D[1], X20
    FMOV  D21, X6
    FMOV  V21.D[1], X26
    FMOV  D22, X16
    FMOV  V22.D[1], X14
    FMOV  D23, X8
    FMOV  V23.D[1], X25
    FMOV  D24, X9
    FMOV  V24.D[1], X5
    FMOV  D25, X17
    FMOV  V25.D[1], X7
    FMOV  D26, X28
    FMOV  V26.D[1], X26
    FMOV  D27, X20
    FMOV  V27.D[1], X15
    FMOV  D28, X23
    FMOV  V28.D[1], X8
    FMOV  D29, X13
    FMOV  V29.D[1], X22
    FMOV  D30, X18
    FMOV  V30.D[1], X22
    FMOV  D31, X12
    FMOV  V31.D[1], X17
    MOVZ  X20, #0xf, LSL #0
TSRTFloatMinMax_label_4:
    FMAX  H17, H29, H22
    FMINNM  H23, H28, H18
    FMIN  H4, H25, H31
    FMAXNM  D28, D20, D21
    FMAX  S24, S30, S26
    FMIN  H24, H23, H27
    FMINNM  D28, D4, D4
    FMAX  S15, S28, S28
    FMAX  D13, D24, D24
    FMAX  S2, S15, S28
    FMAX  S22, S2, S13
    FMIN  D2, D22, D27
    FMAX  S31, S2, S17
    FMAXNM  H17, H31, H23
    FMIN  H10, H27, H23
    FMIN  H18, H7, H14
    FMINNM  S21, S8, S16
    FMINNM  S14, S1, S30
    FMAXNM  D7, D21, D28
    FMIN  H4, H7, H11
    FMINNM  H3, H9, H4
    FMIN  D26, D21, D22
    FMINNM  D4, D1, D11
    FMINNM  D24, D0, D8
    FMAXNM  H31, H13, H30
    FMAXNM  H2, H24, H26
    FMAXNM  S26, S10, S4
    FMIN  D4, D18, D2
    FMIN  S29, S11, S3
    FMAXNM  D3, D14, D26
    FMINNM  H20, H31, H21
    FMINNM  S22, S11, S4
    FMAXNM  H24, H3, H29
    FMAXNM  D27, D5, D17
    FMIN  S7, S22, S20
    FMAXNM  S29, S27, S19
    FMINNM  H26, H27, H29
    FMAX  D17, D24, D26
    FMIN  H10, H7, H7
    FMIN  D9, D17, D17
    FMINNM  S7, S17, S10
    FMINNM  S23, S21, S7
    FMINNM  D19, D23, D23
    FMAX  S18, S19, S9
    FMAX  S10, S16, S24
    FMAXNM  D9, D14, D13
    FMINNM  D4, D0, D29
    FMINNM  D31, D16, D30
    FMIN  D29, D9, D28
    FMAXNM  D27, D7, D15
    FMINNM  D20, D4, D6
    FMIN  D5, D12, D3
    FMAXNM  S8, S24, S17
    FMAX  D17, D20, D0
    FMAX  H23, H1, H13
    FMAX  D3, D10, D8
    FMAXNM  D16, D18, D17
    FMIN  H24, H29, H23
    FMAX  D12, D23, D16
    FMIN  S26, S3, S24
    FMAX  H10, H1, H5
    FMAXNM  S21, S10, S26
    FMAXNM  S23, S31, S21
    FMAX  D14, D12, D12
    FMAXNM  H3, H27, H27
    FMAXNM  D12, D23, D23
    FMINNM  S6, S14, S12
    FMAXNM  D19, D3, D11
    FMIN  S15, S19, S19
    FMAX  H4, H6, H15
    FMAX  D11, D29, D16
    FMAXNM  H7, H21, H9
    FMAX  S23, S15, S29
    FMINNM  H8, H30, H8
    FMAXNM  D21, D13, D9
    FMAX  S30, S29, S14
    FMIN  D13, D23, D28
    FMINNM  D17, D31, D5
    FMINNM  H15, H20, H7
    FMINNM  H27, H2, H15
    FMIN  H12, H11, H11
    FMIN  D31, D31, D11
    FMAXNM  D11, D17, D17
    FMAXNM  S15, S11, S8
    FMAXNM  S17, S13, S4
    FMINNM  S5, S17, S12
    FMINNM  H28, H21, H5
    FMAXNM  S11, S30, S31
    FMIN  D14, D28, D27
    FMAXNM  D23, D11, D15
    FMIN  S27, S23, S23
    FMAXNM  S8, S8, S14
    FMINNM  H20, H27, H27
    FMAXNM  H13, H20, H8
    FMINNM  D28, D17, D6
    FMIN  H30, H10, H0
    FMAX  H20, H21, H18
    FMIN  S31, S25, S6
    FMAX  D17, D1, D28
    FMAXNM  D1, D20, D1
    FMINNM  S27, S12, S2
    FMAX  D14, D1, D6
    FMAX  S4, S0, S20
    FMINNM  S11, S30, S15
    FMINNM  S12, S30, S26
    FMAXNM  S7, S21, S23
    FMAXNM  H15, H31, H12
    FMAXNM  H21, H13, H13
    FMINNM  D2, D14, D27
    FMAXNM  H8, H9, H21
    FMINNM  H13, H7, H11
    FMIN  S26, S17, S4
    FMIN  H21, H26, H13
    FMAX  D18, D2, D25
    FMINNM  D10, D15, D8
    FMINNM  S4, S21, S18
    FMIN  D17, D4, D4
    FMIN  S21, S19, S10
    FMINNM  H13, H17, H6
    FMAX  H30, H21, H16
    FMINNM  H20, H8, H10
    FMIN  S9, S13, S30
    FMAX  H6, H9, H20
    FMIN  H13, H3, H14
    FMINNM  H3, H30, H31
    FMIN  H11, H20, H21
    FMAX  H25, H21, H6
    FMIN  S9, S9, S18
    FMAX  D6, D26, D4
    FMAXNM  S23, S18, S2
    FMAX  D14, D31, D4
    FMAXNM  D27, D30, D13
    FMAX  S16, S19, S2
    FMAX  D17, D16, D30
    FMINNM  S8, S9, S25
    FMAX  S13, S27, S8
    FMAX  D8, D17, D23
    FMAX  S20, S6, S14
    FMIN  D6, D3, D11
    FMIN  D10, D13, D20
    FMAX  S9, S10, S6
    FMAX  D3, D9, D8
    FMAXNM  H15, H30, H14
    FMIN  H10, H31, H24
    FMAX  S17, S14, S2
    FMIN  S31, S28, S14
    FMAXNM  S9, S27, S1
    FMAXNM  D8, D31, D21
    FMAX  D2, D25, D11
    FMAXNM  H1, H7, H13
    FMINNM  S23, S11, S30
    FMIN  D16, D23, D3
    FMIN  H18, H10, H10
    FMAX  D20, D15, D2
    FMAX  H10, H20, H8
    FMAX  S15, S7, S9
    FMAXNM  D14, D1, D16
    FMIN  D28, D17, D18
    FMAXNM  S6, S15, S28
    FMINNM  H13, H10, H6
    FMIN  H8, H14, H14
    FMINNM  H28, H13, H13
    FMAX  H20, H28, H28
    FMINNM  D7, D8, D20
    FMAXNM  H30, H0, H22
    FMAXNM  H3, H14, H9
    FMIN  H17, H24, H13
    FMINNM  H13, H27, H1
    FMINNM  D10, D1, D28
    FMIN  D22, D13, D1
    FMAX  S13, S6, S28
    FMAXNM  D23, D5, D31
    FMAXNM  S0, S29, S23
    FMINNM  S9, S9, S31
    FMINNM  D14, D9, D7
    FMINNM  S8, S14, S17
    FMAX  D25, D0, D8
    FMAX  D6, D25, D4
    FMIN  D25, D30, D13
    FMAX  S17, S3, S22
    FMIN  H0, H25, H17
    FMAXNM  H18, H6, H29
    FMINNM  S4, S0, S10
    FMINNM  D30, D18, D18
    FMAXNM  H10, H30, H4
    FMIN  D8, D8, D10
    FMIN  H27, H9, H15
    FMAX  S22, S20, S15
    FMINNM  H23, H27, H10
    FMAX  S27, S15, S29
    FMAXNM  H4, H27, H29
    FMIN  H15, H21, H23
    FMINNM  H14, H26, H15
    FMAXNM  D30, D15, D3
    FMINNM  D20, D29, D3
    FMIN  H26, H4, H30
    FMAXNM  S24, S14, S0
    FMAX  S23, S30, S4
    FMAXNM  D0, D6, D12
    FMAXNM  H27, H14, H4
    SUBS  X20, X20, #0x1
    B.NE  TSRTFloatMinMax_label_4
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x81, LSL #0
    MRS  X23, FPSR
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V0.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D0
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V1.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D1
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D2
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V3.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D3
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D4
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D5
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D6
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V7.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D7
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D8
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D9
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D10
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V11.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D11
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V12.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D12
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V13.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D13
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D14
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D15
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D16
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V17.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D17
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V18.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D18
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D19
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V20.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D20
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V21.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D21
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D22
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D23
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V24.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D24
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D25
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D26
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D27
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V28.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D28
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D29
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D30
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X23, D31
    SUB  X29, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMinMax_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X24
    FMOV  D3, X20
    FMOV  V3.D[1], X29
    FMOV  D4, X5
    FMOV  V4.D[1], X14
    FMOV  D5, X16
    FMOV  V5.D[1], X6
    FMOV  D6, X25
    FMOV  V6.D[1], X17
    FMOV  D7, X6
    FMOV  V7.D[1], X18
    FMOV  D8, X28
    FMOV  V8.D[1], X12
    FMOV  D9, X13
    FMOV  V9.D[1], X9
    FMOV  D10, X12
    FMOV  V10.D[1], X28
    FMOV  D11, X5
    FMOV  V11.D[1], X17
    FMOV  D12, X13
    FMOV  V12.D[1], X26
    FMOV  D13, X6
    FMOV  V13.D[1], X17
    FMOV  D14, X7
    FMOV  V14.D[1], X29
    FMOV  D15, X6
    FMOV  V15.D[1], X7
    FMOV  D16, X14
    FMOV  V16.D[1], X9
    FMOV  D17, X25
    FMOV  V17.D[1], X5
    FMOV  D18, X7
    FMOV  V18.D[1], X25
    FMOV  D19, X8
    FMOV  V19.D[1], X16
    FMOV  D20, X24
    FMOV  V20.D[1], X12
    FMOV  D21, X22
    FMOV  V21.D[1], X8
    FMOV  D22, X22
    FMOV  V22.D[1], X6
    FMOV  D23, X29
    FMOV  V23.D[1], X5
    FMOV  D24, X22
    FMOV  V24.D[1], X4
    FMOV  D25, X17
    FMOV  V25.D[1], X24
    FMOV  D26, X18
    FMOV  V26.D[1], X22
    FMOV  D27, X22
    FMOV  V27.D[1], X29
    FMOV  D28, X22
    FMOV  V28.D[1], X20
    FMOV  D29, X25
    FMOV  V29.D[1], X7
    FMOV  D30, X14
    FMOV  V30.D[1], X6
    FMOV  D31, X6
    FMOV  V31.D[1], X15
    MOVZ  X3, #0xf, LSL #0
TSRTFloatMinMax_label_5:
    FMAXNM  S23, S25, S28
    FMINNM  H0, H29, H27
    FMAXNM  H22, H24, H0
    FMINNM  D20, D23, D22
    FMINNM  D27, D20, D31
    FMAX  S26, S26, S21
    FMAX  H8, H26, H30
    FMAX  D24, D8, D8
    FMINNM  S13, S24, S24
    FMIN  D0, D13, D27
    FMAX  S18, S31, S19
    FMAX  D31, D16, D4
    FMIN  S26, S25, S31
    FMINNM  H25, H26, H15
    FMINNM  S20, S12, S9
    FMINNM  H30, H15, H24
    FMINNM  S19, S21, S30
    FMAX  S15, S16, S9
    FMAX  H9, H14, H27
    FMIN  S23, S0, S5
    FMIN  D5, D9, D12
    FMIN  S4, S22, S31
    FMIN  D16, D23, D6
    FMIN  D8, D27, D19
    FMIN  D22, D6, D31
    FMIN  D30, D20, D22
    FMINNM  H28, H4, H18
    FMIN  H21, H18, H28
    FMAXNM  H13, H28, H21
    FMAX  H31, H25, H8
    FMAX  D12, D16, D13
    FMAX  D18, D5, D31
    FMAXNM  D4, D12, D15
    FMAXNM  H15, H4, H4
    FMAX  H28, H18, H15
    FMINNM  H5, H28, H30
    FMAXNM  H4, H10, H3
    FMIN  D12, D28, D28
    FMAX  D8, D7, D25
    FMAX  D14, D20, D3
    FMAX  H18, H21, H17
    FMAXNM  D26, D26, D31
    FMIN  H6, H2, H9
    FMINNM  H15, H3, H17
    FMAX  D2, D18, D15
    FMAXNM  H16, H6, H5
    FMINNM  D5, D26, D4
    FMIN  D28, D12, D16
    FMIN  S4, S8, S28
    FMIN  H3, H5, H4
    FMINNM  D21, D2, D2
    FMINNM  H13, H8, H21
    FMAX  H18, H3, H14
    FMIN  S8, S13, S13
    FMINNM  H22, H8, H18
    FMAX  D18, D24, D28
    FMINNM  S17, S12, S17
    FMINNM  S2, S28, S25
    FMIN  S25, S3, S3
    FMAXNM  H21, H16, H28
    FMINNM  D26, D21, D2
    FMINNM  H20, H21, H8
    FMAX  H5, H13, H26
    FMAXNM  D3, D13, D30
    FMIN  H26, H20, H10
    FMIN  D24, D17, D23
    FMIN  S17, S20, S18
    FMINNM  D12, D30, D15
    FMAX  H18, H9, H29
    FMIN  S16, S26, S5
    FMAXNM  D14, D25, D18
    FMINNM  H13, H14, H3
    FMAXNM  D21, D24, D16
    FMINNM  S8, S17, S13
    FMIN  S13, S8, S22
    FMAXNM  D14, D13, D12
    FMAXNM  D24, D5, D21
    FMAX  D13, D14, D24
    FMINNM  S12, S30, S16
    FMAX  S2, S0, S6
    FMINNM  D28, D25, D31
    FMIN  S17, S10, S17
    FMINNM  D8, D19, D0
    FMINNM  S22, S11, S15
    FMAXNM  D16, D20, D8
    FMIN  D21, D19, D4
    FMINNM  D3, D25, D30
    FMAX  S26, S0, S21
    FMINNM  D5, D16, D26
    FMAX  D25, D12, D17
    FMAX  H6, H13, H22
    FMINNM  S15, S28, S28
    FMIN  S12, S3, S2
    FMIN  D2, D15, D25
    FMAXNM  D14, D5, D2
    FMAX  D29, D12, D6
    FMAX  H22, H14, H14
    FMIN  D2, D22, D29
    FMIN  S11, S10, S14
    FMAX  S24, S13, S21
    FMAXNM  S25, S21, S3
    FMIN  H19, H5, H25
    FMAXNM  S31, S15, S20
    FMAX  S25, S27, S8
    FMINNM  S26, S9, S7
    FMAX  H17, H25, H25
    FMAX  H28, H13, H4
    FMAX  H30, H25, H5
    FMAX  S7, S11, S26
    FMINNM  H3, H30, H17
    FMIN  S17, S2, S28
    FMAX  H14, H14, H17
    FMIN  D13, D7, D3
    FMAXNM  S28, S15, S31
    FMAX  D17, D13, D14
    FMAX  D27, D28, D28
    FMAX  H4, H27, H24
    FMIN  D5, D4, D17
    FMIN  S8, S5, S19
    FMAX  D15, D19, D17
    FMAXNM  H9, H3, H1
    FMIN  D31, D28, D10
    FMINNM  S5, S27, S6
    FMINNM  D4, D25, D15
    FMAX  S20, S29, S17
    FMAX  H6, H31, H12
    FMAX  H14, H8, H7
    FMAXNM  H26, H17, H13
    FMAXNM  S7, S30, S1
    FMAXNM  H27, H21, H29
    FMIN  S10, S9, S14
    FMAXNM  D9, D15, D5
    FMAX  H31, H6, H27
    FMIN  S8, S31, S4
    FMINNM  S24, S10, S20
    FMAX  D4, D8, D8
    FMINNM  D28, D26, D4
    FMINNM  H13, H7, H9
    FMINNM  D27, D13, D24
    FMAXNM  H6, H28, H27
    FMAXNM  H8, H29, H15
    FMIN  D25, D19, D9
    FMAXNM  S20, S28, S3
    FMINNM  D3, D28, D28
    FMINNM  S26, S30, S11
    FMAXNM  D9, D26, D20
    FMINNM  D29, D21, D21
    FMIN  D31, D16, D25
    FMAXNM  S28, S2, S10
    FMIN  H20, H26, H23
    FMINNM  D21, D23, D12
    FMAXNM  H17, H9, H8
    FMAX  D12, D3, D6
    FMAXNM  S8, S31, S17
    FMINNM  H19, H28, H28
    FMAX  S15, S20, S8
    FMINNM  H6, H15, H29
    FMIN  S27, S21, S8
    FMAX  H20, H20, H12
    FMIN  D9, D19, D20
    FMAXNM  H28, H6, H27
    FMAXNM  S2, S9, S9
    FMINNM  H20, H28, H28
    FMIN  S9, S2, S10
    FMAX  D15, D19, D9
    FMINNM  H25, H15, H20
    FMAXNM  S2, S21, S30
    FMAX  S6, S31, S20
    FMAXNM  D31, D5, D5
    FMAX  D17, D11, D7
    FMAXNM  H27, H26, H9
    FMAX  D12, D13, D6
    FMINNM  D26, D6, D28
    FMINNM  D28, D4, D29
    FMAX  S9, S29, S13
    FMAX  D5, D26, D12
    FMAXNM  D4, D31, D28
    FMAX  H7, H4, H25
    FMAXNM  H21, H5, H17
    FMINNM  H25, H2, H7
    FMIN  D10, D27, D18
    FMIN  S2, S9, S9
    FMAX  D6, D8, D2
    FMAX  D9, D21, D6
    FMAXNM  D17, D25, D25
    FMAXNM  H11, H17, H28
    FMIN  S29, S11, S11
    FMAX  D18, D9, D10
    FMAXNM  S31, S29, S29
    FMAXNM  D12, D31, D31
    FMAXNM  H11, H12, H18
    FMINNM  S8, S14, S19
    FMAXNM  D4, D24, D29
    FMAXNM  H2, H9, H30
    FMIN  S31, S23, S3
    FMAXNM  H26, H0, H25
    FMIN  H27, H2, H24
    FMAX  S28, S10, S11
    FMIN  H25, H21, H17
    FMINNM  S23, S20, S29
    SUBS  X3, X3, #0x1
    B.NE  TSRTFloatMinMax_label_5
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x81, LSL #0
    MRS  X25, FPSR
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    FMOV  X25, V1.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    FMOV  X25, D1
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D5
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D24
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X6, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x5ec, LSL #0
    MOVK  X3, #0x1757, LSL #16
    MOVK  X3, #0xfaa3, LSL #32
    MOVK  X3, #0x1301, LSL #48
    MOVZ  X4, #0xe406, LSL #0
    MOVK  X4, #0x9d41, LSL #16
    MOVK  X4, #0x18b4, LSL #32
    MOVK  X4, #0x5277, LSL #48
    MOVZ  X5, #0x791b, LSL #0
    MOVK  X5, #0xb2a1, LSL #16
    MOVK  X5, #0xcc76, LSL #32
    MOVK  X5, #0x5f7b, LSL #48
    MOVZ  X6, #0xff46, LSL #0
    MOVK  X6, #0x73b9, LSL #16
    MOVK  X6, #0xb7b0, LSL #32
    MOVK  X6, #0x88c6, LSL #48
    MOVZ  X7, #0x1453, LSL #0
    MOVK  X7, #0xc7b8, LSL #16
    MOVK  X7, #0xbe0b, LSL #32
    MOVK  X7, #0xb890, LSL #48
    MOVZ  X8, #0x1203, LSL #0
    MOVK  X8, #0xfd6e, LSL #16
    MOVK  X8, #0x1afc, LSL #32
    MOVK  X8, #0x3373, LSL #48
    MOVZ  X9, #0xa82d, LSL #0
    MOVK  X9, #0x7efe, LSL #16
    MOVK  X9, #0xc0c1, LSL #32
    MOVK  X9, #0xd630, LSL #48
    MOVZ  X10, #0xd1fc, LSL #0
    MOVK  X10, #0x12e0, LSL #16
    MOVK  X10, #0xd279, LSL #32
    MOVK  X10, #0x7510, LSL #48
    MOVZ  X12, #0x8798, LSL #0
    MOVK  X12, #0x9974, LSL #16
    MOVK  X12, #0xbbde, LSL #32
    MOVK  X12, #0xafd3, LSL #48
    MOVZ  X13, #0xa3a, LSL #0
    MOVK  X13, #0xa9e1, LSL #16
    MOVK  X13, #0x7c97, LSL #32
    MOVK  X13, #0xf2d6, LSL #48
    MOVZ  X14, #0x5d9f, LSL #0
    MOVK  X14, #0x7387, LSL #16
    MOVK  X14, #0xadee, LSL #32
    MOVK  X14, #0xa434, LSL #48
    MOVZ  X15, #0x1149, LSL #0
    MOVK  X15, #0x4cf8, LSL #16
    MOVK  X15, #0xcb5c, LSL #32
    MOVK  X15, #0xc7b8, LSL #48
    MOVZ  X16, #0x4ba6, LSL #0
    MOVK  X16, #0xfca9, LSL #16
    MOVK  X16, #0x1e1d, LSL #32
    MOVK  X16, #0x7a5f, LSL #48
    MOVZ  X17, #0xb474, LSL #0
    MOVK  X17, #0x6ae8, LSL #16
    MOVK  X17, #0x7413, LSL #32
    MOVK  X17, #0x5efa, LSL #48
    MOVZ  X18, #0xb1a9, LSL #0
    MOVK  X18, #0x61d2, LSL #16
    MOVK  X18, #0x951e, LSL #32
    MOVK  X18, #0x2b1e, LSL #48
    MOVZ  X20, #0x3e8a, LSL #0
    MOVK  X20, #0x3ff8, LSL #16
    MOVK  X20, #0xbd2d, LSL #32
    MOVK  X20, #0x78d2, LSL #48
    MOVZ  X21, #0xcb1d, LSL #0
    MOVK  X21, #0x6bed, LSL #16
    MOVK  X21, #0xdcb7, LSL #32
    MOVK  X21, #0xdd36, LSL #48
    MOVZ  X22, #0xdeee, LSL #0
    MOVK  X22, #0x97f4, LSL #16
    MOVK  X22, #0x1500, LSL #32
    MOVK  X22, #0x629e, LSL #48
    MOVZ  X23, #0xdc8e, LSL #0
    MOVK  X23, #0xab5, LSL #16
    MOVK  X23, #0x2231, LSL #32
    MOVK  X23, #0xd6b0, LSL #48
    MOVZ  X24, #0x8e2f, LSL #0
    MOVK  X24, #0xf523, LSL #16
    MOVK  X24, #0xda9e, LSL #32
    MOVK  X24, #0x2d9b, LSL #48
    MOVZ  X25, #0x1cdb, LSL #0
    MOVK  X25, #0x1272, LSL #16
    MOVK  X25, #0xc732, LSL #32
    MOVK  X25, #0xe824, LSL #48
    MOVZ  X26, #0x85ac, LSL #0
    MOVK  X26, #0x2729, LSL #16
    MOVK  X26, #0xcc4, LSL #32
    MOVK  X26, #0xeb43, LSL #48
    MOVZ  X28, #0x3157, LSL #0
    MOVK  X28, #0x8603, LSL #16
    MOVK  X28, #0x1914, LSL #32
    MOVK  X28, #0xeabe, LSL #48
    MOVZ  X29, #0x1bb2, LSL #0
    MOVK  X29, #0x1d11, LSL #16
    MOVK  X29, #0x524e, LSL #32
    MOVK  X29, #0xb86a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X17
    FMOV  D3, X6
    FMOV  V3.D[1], X22
    FMOV  D4, X22
    FMOV  V4.D[1], X3
    FMOV  D5, X8
    FMOV  V5.D[1], X6
    FMOV  D6, X12
    FMOV  V6.D[1], X16
    FMOV  D7, X12
    FMOV  V7.D[1], X4
    FMOV  D8, X20
    FMOV  V8.D[1], X25
    FMOV  D9, X22
    FMOV  V9.D[1], X8
    FMOV  D10, X8
    FMOV  V10.D[1], X3
    FMOV  D11, X17
    FMOV  V11.D[1], X25
    FMOV  D12, X21
    FMOV  V12.D[1], X13
    FMOV  D13, X8
    FMOV  V13.D[1], X7
    FMOV  D14, X21
    FMOV  V14.D[1], X29
    FMOV  D15, X12
    FMOV  V15.D[1], X13
    FMOV  D16, X3
    FMOV  V16.D[1], X18
    FMOV  D17, X8
    FMOV  V17.D[1], X9
    FMOV  D18, X22
    FMOV  V18.D[1], X29
    FMOV  D19, X20
    FMOV  V19.D[1], X29
    FMOV  D20, X6
    FMOV  V20.D[1], X22
    FMOV  D21, X28
    FMOV  V21.D[1], X8
    FMOV  D22, X22
    FMOV  V22.D[1], X7
    FMOV  D23, X29
    FMOV  V23.D[1], X10
    FMOV  D24, X4
    FMOV  V24.D[1], X4
    FMOV  D25, X8
    FMOV  V25.D[1], X24
    FMOV  D26, X18
    FMOV  V26.D[1], X22
    FMOV  D27, X9
    FMOV  V27.D[1], X8
    FMOV  D28, X17
    FMOV  V28.D[1], X15
    FMOV  D29, X14
    FMOV  V29.D[1], X7
    FMOV  D30, X15
    FMOV  V30.D[1], X6
    FMOV  D31, X26
    FMOV  V31.D[1], X29
    MOVZ  X14, #0xf, LSL #0
TSRTFloatMinMax_label_6:
    FMAX  D8, D31, D26
    FMINNM  S30, S25, S29
    FMAX  H25, H24, H24
    FMINNM  D30, D28, D8
    FMAXNM  H18, H25, H27
    FMIN  H4, H18, H30
    FMAXNM  H21, H4, H4
    FMAX  D3, D22, D21
    FMAX  S16, S3, S3
    FMINNM  S11, S16, S16
    FMAX  S10, S11, S11
    FMAXNM  H8, H10, H10
    FMIN  H10, H8, H8
    FMAX  H8, H21, H10
    FMAXNM  D21, D8, D8
    FMAX  H27, H21, H30
    FMAXNM  S4, S17, S30
    FMIN  D17, D9, D11
    FMAX  D28, D11, D14
    FMAXNM  H10, H22, H24
    FMIN  S25, S23, S29
    FMAX  S11, S16, S8
    FMAXNM  D26, D26, D24
    FMINNM  H18, H2, H22
    FMAXNM  D3, D17, D27
    FMAX  D16, D25, D28
    FMAXNM  D25, D26, D18
    FMINNM  H17, H10, H11
    FMIN  S24, S3, S3
    FMIN  D11, D4, D24
    FMAX  S14, S17, S11
    FMAX  D10, D16, D14
    FMAX  H27, H9, H10
    FMAX  D24, D27, D27
    FMAX  D9, D24, D24
    FMINNM  D21, D9, D9
    FMAXNM  H27, H25, H21
    FMINNM  S8, S15, S3
    FMAX  S14, S5, S25
    FMAXNM  H26, H26, H13
    FMAXNM  D2, D15, D0
    FMAXNM  D11, D29, D11
    FMINNM  S24, S19, S5
    FMIN  H0, H22, H31
    FMINNM  D10, D18, D5
    FMINNM  H9, H14, H2
    FMIN  D23, D16, D9
    FMIN  H17, H10, H24
    FMIN  S9, S17, S17
    FMAXNM  D28, D9, D0
    FMAXNM  S13, S26, S28
    FMINNM  S4, S13, S23
    FMAX  S9, S4, S27
    FMINNM  S21, S8, S9
    FMAX  H15, H21, H21
    FMINNM  D3, D15, D11
    FMAXNM  D10, D24, D16
    FMAXNM  S17, S26, S22
    FMIN  S4, S21, S21
    FMIN  H23, H2, H25
    FMAXNM  D18, D9, D11
    FMINNM  H8, H11, H13
    FMINNM  H14, H11, H8
    FMINNM  D31, D3, D13
    FMINNM  H19, H27, H0
    FMIN  D2, D9, D10
    FMIN  S28, S17, S12
    FMINNM  H13, H26, H20
    FMAXNM  H15, H4, H4
    FMAXNM  D20, D23, D15
    FMIN  H26, H13, H31
    FMINNM  D12, D20, D20
    FMIN  H11, H28, H12
    FMIN  D3, D14, D19
    FMIN  D8, D18, D3
    FMAX  S15, S11, S2
    FMINNM  S24, S4, S26
    FMAX  S10, S6, S8
    FMIN  H17, H21, H10
    FMIN  D25, D15, D17
    FMIN  D31, D18, D25
    FMINNM  S14, S31, S24
    FMIN  S26, S18, S25
    FMINNM  D27, D5, D21
    FMAX  D19, D24, D1
    FMAX  D3, D17, D3
    FMINNM  D5, D1, D12
    FMAXNM  D31, D30, D4
    FMAXNM  D18, D4, D21
    FMAXNM  H9, H21, H12
    FMIN  S13, S27, S19
    FMAX  S30, S3, S19
    FMAX  D28, D30, D13
    FMAXNM  D1, D28, D18
    FMAX  S11, S26, S14
    FMINNM  D27, D11, D1
    FMINNM  S18, S9, S9
    FMAX  D1, D5, D31
    FMAX  S9, S18, S30
    FMINNM  H30, H1, H27
    FMINNM  S10, S30, S9
    FMAXNM  S21, S18, S17
    FMIN  H31, H17, H5
    FMAX  S4, S22, S31
    FMIN  D30, D11, D16
    FMAX  S16, S1, S28
    FMAXNM  S26, S14, S30
    FMIN  D5, D14, D4
    FMINNM  D18, D8, D16
    FMINNM  H24, H13, H31
    FMAXNM  S11, S24, S24
    FMAX  D16, D4, D10
    FMINNM  H13, H29, H31
    FMAX  S29, S21, S19
    FMAXNM  H22, H11, H16
    FMINNM  D17, D2, D20
    FMIN  D2, D10, D1
    FMAX  H14, H30, H13
    FMIN  D9, D12, D31
    FMAXNM  H3, H18, H9
    FMINNM  D18, D22, D26
    FMAXNM  D9, D7, D14
    FMAXNM  H30, H9, H29
    FMIN  S8, S5, S5
    FMAXNM  H26, H18, H18
    FMIN  H16, H17, H26
    FMIN  S4, S3, S2
    FMAXNM  S2, S8, S30
    FMIN  S3, S2, S20
    FMINNM  S21, S16, S3
    FMAX  H5, H21, H4
    FMIN  D3, D31, D24
    FMIN  D2, D30, D10
    FMINNM  D1, D3, D5
    FMIN  H17, H19, H27
    FMINNM  S13, S19, S0
    FMAX  H11, H30, H11
    FMAXNM  S5, S29, S7
    FMIN  D8, D23, D13
    FMINNM  D18, D11, D7
    FMIN  D29, D11, D29
    FMIN  S24, S19, S15
    FMINNM  S19, S27, S12
    FMINNM  D12, D18, D24
    FMAXNM  S22, S19, S12
    FMAX  S21, S5, S1
    FMAXNM  D5, D22, D2
    FMIN  H12, H5, H29
    FMAXNM  H9, H12, H21
    FMAX  S22, S9, S17
    FMIN  H0, H8, H22
    FMIN  D11, D20, D17
    FMAX  S2, S11, S9
    FMINNM  D19, D3, D12
    FMINNM  S3, S3, S7
    FMIN  H27, H31, H0
    FMIN  D18, D16, D27
    FMIN  D1, D11, D1
    FMAXNM  H16, H30, H31
    FMAX  H22, H8, H2
    FMAX  H29, H25, H24
    FMAX  D17, D13, D0
    FMIN  S5, S29, S28
    FMINNM  S8, S5, S19
    FMAXNM  S21, S6, S11
    FMAX  D2, D14, D14
    FMAXNM  H11, H21, H22
    FMINNM  D15, D8, D18
    FMIN  S27, S1, S16
    FMINNM  D29, D2, D17
    FMAXNM  H2, H27, H15
    FMAX  D5, D3, D11
    FMIN  S31, S5, S29
    FMIN  H29, H31, H2
    FMAXNM  D20, D8, D27
    FMAXNM  D13, D3, D4
    FMIN  S7, S27, S2
    FMIN  D28, D21, D6
    FMINNM  D9, D5, D1
    FMAX  H1, H23, H19
    FMAXNM  D27, D30, D1
    FMINNM  H14, H7, H9
    FMAX  S23, S14, S26
    FMINNM  H26, H6, H22
    FMAX  H22, H23, H10
    FMAX  S21, S8, S31
    FMAX  H7, H12, H13
    FMIN  S3, S4, S8
    FMAX  S15, S21, S28
    FMAXNM  D30, D27, D20
    FMAX  H25, H30, H30
    FMINNM  D1, D31, D26
    FMAXNM  H19, H29, H22
    FMAX  D28, D19, D25
    FMINNM  S5, S28, S7
    FMINNM  D22, D15, D15
    FMAX  S9, S1, S13
    FMINNM  H13, H9, H3
    FMAXNM  D15, D22, D22
    FMINNM  S21, S0, S13
    SUBS  X14, X14, #0x1
    B.NE  TSRTFloatMinMax_label_6
    MOVZ  X18, #0x5ec, LSL #0
    MOVK  X18, #0x1757, LSL #16
    MOVK  X18, #0xfaa3, LSL #32
    MOVK  X18, #0x1301, LSL #48
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xe406, LSL #0
    MOVK  X18, #0x9d41, LSL #16
    MOVK  X18, #0x18b4, LSL #32
    MOVK  X18, #0x5277, LSL #48
    SUB  X28, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x791b, LSL #0
    MOVK  X18, #0xb2a1, LSL #16
    MOVK  X18, #0xcc76, LSL #32
    MOVK  X18, #0x5f7b, LSL #48
    SUB  X28, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x1453, LSL #0
    MOVK  X18, #0xc7b8, LSL #16
    MOVK  X18, #0xbe0b, LSL #32
    MOVK  X18, #0xb890, LSL #48
    SUB  X28, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x1203, LSL #0
    MOVK  X18, #0xfd6e, LSL #16
    MOVK  X18, #0x1afc, LSL #32
    MOVK  X18, #0x3373, LSL #48
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa82d, LSL #0
    MOVK  X18, #0x7efe, LSL #16
    MOVK  X18, #0xc0c1, LSL #32
    MOVK  X18, #0xd630, LSL #48
    SUB  X28, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xd1fc, LSL #0
    MOVK  X18, #0x12e0, LSL #16
    MOVK  X18, #0xd279, LSL #32
    MOVK  X18, #0x7510, LSL #48
    SUB  X28, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x8798, LSL #0
    MOVK  X18, #0x9974, LSL #16
    MOVK  X18, #0xbbde, LSL #32
    MOVK  X18, #0xafd3, LSL #48
    SUB  X28, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xa3a, LSL #0
    MOVK  X18, #0xa9e1, LSL #16
    MOVK  X18, #0x7c97, LSL #32
    MOVK  X18, #0xf2d6, LSL #48
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x1149, LSL #0
    MOVK  X18, #0x4cf8, LSL #16
    MOVK  X18, #0xcb5c, LSL #32
    MOVK  X18, #0xc7b8, LSL #48
    SUB  X28, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x4ba6, LSL #0
    MOVK  X18, #0xfca9, LSL #16
    MOVK  X18, #0x1e1d, LSL #32
    MOVK  X18, #0x7a5f, LSL #48
    SUB  X28, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xb474, LSL #0
    MOVK  X18, #0x6ae8, LSL #16
    MOVK  X18, #0x7413, LSL #32
    MOVK  X18, #0x5efa, LSL #48
    SUB  X28, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x3e8a, LSL #0
    MOVK  X18, #0x3ff8, LSL #16
    MOVK  X18, #0xbd2d, LSL #32
    MOVK  X18, #0x78d2, LSL #48
    SUB  X28, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xcb1d, LSL #0
    MOVK  X18, #0x6bed, LSL #16
    MOVK  X18, #0xdcb7, LSL #32
    MOVK  X18, #0xdd36, LSL #48
    SUB  X28, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xdeee, LSL #0
    MOVK  X18, #0x97f4, LSL #16
    MOVK  X18, #0x1500, LSL #32
    MOVK  X18, #0x629e, LSL #48
    SUB  X28, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xdc8e, LSL #0
    MOVK  X18, #0xab5, LSL #16
    MOVK  X18, #0x2231, LSL #32
    MOVK  X18, #0xd6b0, LSL #48
    SUB  X28, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x8e2f, LSL #0
    MOVK  X18, #0xf523, LSL #16
    MOVK  X18, #0xda9e, LSL #32
    MOVK  X18, #0x2d9b, LSL #48
    SUB  X28, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x1cdb, LSL #0
    MOVK  X18, #0x1272, LSL #16
    MOVK  X18, #0xc732, LSL #32
    MOVK  X18, #0xe824, LSL #48
    SUB  X28, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x85ac, LSL #0
    MOVK  X18, #0x2729, LSL #16
    MOVK  X18, #0xcc4, LSL #32
    MOVK  X18, #0xeb43, LSL #48
    SUB  X28, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x1bb2, LSL #0
    MOVK  X18, #0x1d11, LSL #16
    MOVK  X18, #0x524e, LSL #32
    MOVK  X18, #0xb86a, LSL #48
    SUB  X28, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x81, LSL #0
    MRS  X28, FPSR
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D0
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D1
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D2
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D3
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D4
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V5.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D5
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x4ba6, LSL #0
    MOVK  X18, #0xfca9, LSL #16
    MOVK  X18, #0x1e1d, LSL #32
    MOVK  X18, #0x7a5f, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x8798, LSL #0
    MOVK  X18, #0x9974, LSL #16
    MOVK  X18, #0xbbde, LSL #32
    MOVK  X18, #0xafd3, LSL #48
    FMOV  X28, D6
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D7
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D8
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D9
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D10
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D11
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D12
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D13
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D14
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D15
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D16
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D17
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D18
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D19
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D20
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D21
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D22
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D23
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D24
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D25
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x8798, LSL #0
    FMOV  X28, D26
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D27
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D28
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D29
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D30
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V31.D[1]
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D31
    SUB  X6, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X8
    FMOV  V0.D[1], X15
    FMOV  D1, X9
    FMOV  V1.D[1], X4
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X18
    FMOV  V3.D[1], X26
    FMOV  D4, X17
    FMOV  V4.D[1], X29
    FMOV  D5, X22
    FMOV  V5.D[1], X25
    FMOV  D6, X23
    FMOV  V6.D[1], X24
    FMOV  D7, X9
    FMOV  V7.D[1], X14
    FMOV  D8, X7
    FMOV  V8.D[1], X5
    FMOV  D9, X24
    FMOV  V9.D[1], X24
    FMOV  D10, X22
    FMOV  V10.D[1], X22
    FMOV  D11, X14
    FMOV  V11.D[1], X22
    FMOV  D12, X17
    FMOV  V12.D[1], X5
    FMOV  D13, X3
    FMOV  V13.D[1], X15
    FMOV  D14, X8
    FMOV  V14.D[1], X24
    FMOV  D15, X6
    FMOV  V15.D[1], X23
    FMOV  D16, X5
    FMOV  V16.D[1], X13
    FMOV  D17, X16
    FMOV  V17.D[1], X6
    FMOV  D18, X3
    FMOV  V18.D[1], X17
    FMOV  D19, X21
    FMOV  V19.D[1], X16
    FMOV  D20, X18
    FMOV  V20.D[1], X16
    FMOV  D21, X14
    FMOV  V21.D[1], X8
    FMOV  D22, X4
    FMOV  V22.D[1], X29
    FMOV  D23, X21
    FMOV  V23.D[1], X28
    FMOV  D24, X26
    FMOV  V24.D[1], X12
    FMOV  D25, X13
    FMOV  V25.D[1], X13
    FMOV  D26, X22
    FMOV  V26.D[1], X15
    FMOV  D27, X28
    FMOV  V27.D[1], X21
    FMOV  D28, X16
    FMOV  V28.D[1], X24
    FMOV  D29, X8
    FMOV  V29.D[1], X28
    FMOV  D30, X4
    FMOV  V30.D[1], X10
    FMOV  D31, X20
    FMOV  V31.D[1], X18
    MOVZ  X25, #0xf, LSL #0
TSRTFloatMinMax_label_7:
    FMAXNM  S31, S26, S26
    FMAXNM  D17, D28, D23
    FMAXNM  D11, D19, D30
    FMAXNM  H0, H17, H25
    FMAXNM  S28, S27, S27
    FMAX  H18, H28, H0
    FMIN  D25, D29, D22
    FMIN  H28, H18, H31
    FMINNM  S11, S21, S11
    FMAX  H20, H11, H11
    FMAX  D2, D25, D28
    FMAXNM  H22, H20, H2
    FMAXNM  S2, S22, S22
    FMAXNM  S21, S2, S2
    FMAXNM  S18, S21, S21
    FMINNM  S23, S18, S18
    FMIN  D17, D10, D23
    FMIN  H19, H28, H7
    FMIN  D23, D16, D6
    FMAXNM  H6, H6, H21
    FMAX  D11, D15, D25
    FMAX  D16, D0, D28
    FMAXNM  H22, H26, H9
    FMAXNM  D31, D0, D6
    FMINNM  D10, D23, D30
    FMAX  D21, D3, D31
    FMAXNM  S25, S7, S27
    FMAXNM  D7, D2, D4
    FMAXNM  D9, D17, D29
    FMINNM  H26, H11, H9
    FMAX  S30, S25, S19
    FMAXNM  S4, S30, S30
    FMIN  H23, H7, H4
    FMINNM  H9, H23, H16
    FMINNM  S20, S21, S10
    FMAXNM  H28, H22, H26
    FMAX  H18, H9, H9
    FMINNM  D2, D20, D18
    FMAX  D18, D2, D30
    FMAXNM  S20, S18, S28
    FMAX  D29, D26, D6
    FMINNM  S3, S20, S5
    FMINNM  H17, H12, H23
    FMAXNM  D15, D22, D2
    FMAX  S26, S30, S24
    FMINNM  H4, H28, H7
    FMIN  H18, H19, H15
    FMAX  H15, H0, H24
    FMAXNM  S30, S28, S29
    FMINNM  D10, D13, D6
    FMIN  D11, D12, D30
    FMINNM  D24, D12, D13
    FMINNM  S30, S3, S17
    FMIN  D20, D30, D24
    FMAX  H19, H20, H26
    FMIN  H17, H19, H10
    FMAXNM  S28, S4, S17
    FMINNM  S29, S18, S18
    FMAX  D22, D11, D15
    FMAX  S3, S22, S28
    FMAXNM  H13, H3, H3
    FMINNM  D7, D13, D13
    FMAXNM  D0, D7, D29
    FMAXNM  S18, S3, S3
    FMAXNM  S19, S19, S28
    FMINNM  S13, S7, S30
    FMIN  H2, H11, H7
    FMINNM  D29, D6, D23
    FMIN  D15, D5, D17
    FMIN  H10, H29, H30
    FMINNM  S22, S24, S23
    FMINNM  H7, H26, H21
    FMIN  D26, D19, D13
    FMAXNM  S3, S22, S16
    FMAX  D19, D2, D10
    FMIN  S4, S0, S18
    FMIN  D21, D15, D4
    FMIN  H20, H19, H27
    FMAX  D12, D7, D7
    FMAX  S6, S21, S20
    FMINNM  S21, S3, S3
    FMAXNM  S13, S26, S21
    FMAX  D20, D13, D12
    FMAXNM  D13, D20, D6
    FMAXNM  H29, H28, H22
    FMINNM  D0, D3, D11
    FMIN  H20, H18, H23
    FMAXNM  H12, H2, H15
    FMINNM  D4, D13, D26
    FMIN  H17, H0, H16
    FMIN  D21, D12, D16
    FMINNM  H10, H19, H5
    FMINNM  H26, H20, H9
    FMAXNM  D20, D19, D29
    FMAX  D27, D9, D26
    FMINNM  H6, H2, H8
    FMAX  H16, H4, H30
    FMIN  H24, H29, H3
    FMAX  S13, S16, S26
    FMINNM  H8, H4, H22
    FMAXNM  D19, D10, D24
    FMAXNM  D23, D19, D8
    FMAXNM  H4, H17, H13
    FMAX  D17, D27, D20
    FMAXNM  D13, D6, D23
    FMIN  D8, D5, D21
    FMINNM  D7, D17, D8
    FMIN  S5, S7, S13
    FMAX  D8, D5, D4
    FMINNM  D30, D29, D24
    FMAXNM  S9, S7, S15
    FMINNM  H2, H30, H11
    FMAXNM  H4, H19, H18
    FMAX  H3, H6, H15
    FMAXNM  S5, S13, S9
    FMINNM  D7, D19, D10
    FMIN  S29, S25, S13
    FMIN  S30, S17, S25
    FMINNM  H15, H13, H0
    FMAXNM  D20, D30, D29
    FMAXNM  H13, H3, H7
    FMIN  H30, H2, H5
    FMAX  D6, D30, D13
    FMAXNM  H29, H8, H15
    FMAX  S18, S29, S24
    FMINNM  S10, S8, S20
    FMINNM  D8, D4, D4
    FMAXNM  S9, S29, S8
    FMINNM  S29, S19, S18
    FMIN  H24, H4, H10
    FMIN  D17, D23, D29
    FMINNM  D13, D19, D24
    FMAX  H29, H6, H6
    FMINNM  D25, D18, D29
    FMAXNM  S18, S9, S9
    FMINNM  S4, S18, S18
    FMAX  H6, H13, H18
    FMAX  H29, H6, H6
    FMIN  H6, H29, H25
    FMAXNM  D18, D17, D17
    FMAX  H10, H4, H18
    FMAX  S3, S10, S6
    FMINNM  D0, D22, D6
    FMINNM  D6, D26, D28
    FMAX  H17, H26, H4
    FMAXNM  H26, H12, H30
    FMAXNM  S4, S20, S3
    FMINNM  D12, D9, D27
    FMINNM  D10, D23, D0
    FMAXNM  S30, S8, S9
    FMAX  D0, D7, D17
    FMINNM  S24, S24, S20
    FMIN  S7, S16, S31
    FMIN  D19, D10, D6
    FMAXNM  S25, S26, S4
    FMINNM  S27, S12, S25
    FMAXNM  D25, D0, D27
    FMAX  S28, S25, S19
    FMIN  S3, S28, S24
    FMAXNM  H22, H7, H7
    FMIN  H4, H3, H22
    FMINNM  S19, S4, S30
    FMIN  H23, H24, H22
    FMIN  S18, S7, S0
    FMIN  D13, D7, D0
    FMAXNM  S28, S21, S1
    FMINNM  H22, H21, H6
    FMINNM  H7, H1, H16
    FMAXNM  H12, H26, H13
    FMINNM  D21, D4, D24
    FMAXNM  S30, S6, S20
    FMINNM  S3, S22, S12
    FMIN  H13, H7, H28
    FMAXNM  D4, D30, D21
    FMIN  D26, D13, D4
    FMAX  H0, H3, H19
    FMIN  H7, H0, H26
    FMINNM  D24, D23, D7
    FMAXNM  D22, D18, D24
    FMAXNM  H10, H5, H4
    FMINNM  S24, S9, S9
    FMINNM  H20, H4, H29
    FMAX  H29, H6, H16
    FMIN  S5, S2, S19
    FMIN  D6, D30, D23
    FMAX  S28, S5, S17
    FMAX  D1, D26, D26
    FMINNM  H16, H21, H17
    FMINNM  D19, D6, D6
    FMAXNM  D4, D19, D19
    FMAXNM  H9, H20, H4
    FMAXNM  S26, S0, S9
    FMIN  S2, S26, S28
    FMAXNM  S5, S2, S2
    FMIN  S4, S5, S29
    FMAXNM  S12, S25, S16
    FMIN  H18, H1, H1
    FMAXNM  D30, D4, D4
    FMAX  D6, D18, D24
    FMAX  S23, S22, S12
    SUBS  X25, X25, #0x1
    B.NE  TSRTFloatMinMax_label_7
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x81, LSL #0
    MRS  X16, FPSR
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D10
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D16
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D20
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X8, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X26
    FMOV  D1, X22
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X28
    FMOV  V3.D[1], X17
    FMOV  D4, X8
    FMOV  V4.D[1], X14
    FMOV  D5, X16
    FMOV  V5.D[1], X14
    FMOV  D6, X10
    FMOV  V6.D[1], X23
    FMOV  D7, X13
    FMOV  V7.D[1], X9
    FMOV  D8, X21
    FMOV  V8.D[1], X23
    FMOV  D9, X21
    FMOV  V9.D[1], X6
    FMOV  D10, X24
    FMOV  V10.D[1], X25
    FMOV  D11, X12
    FMOV  V11.D[1], X13
    FMOV  D12, X17
    FMOV  V12.D[1], X28
    FMOV  D13, X22
    FMOV  V13.D[1], X25
    FMOV  D14, X29
    FMOV  V14.D[1], X24
    FMOV  D15, X24
    FMOV  V15.D[1], X8
    FMOV  D16, X24
    FMOV  V16.D[1], X4
    FMOV  D17, X17
    FMOV  V17.D[1], X12
    FMOV  D18, X26
    FMOV  V18.D[1], X3
    FMOV  D19, X23
    FMOV  V19.D[1], X4
    FMOV  D20, X15
    FMOV  V20.D[1], X9
    FMOV  D21, X12
    FMOV  V21.D[1], X23
    FMOV  D22, X10
    FMOV  V22.D[1], X18
    FMOV  D23, X28
    FMOV  V23.D[1], X17
    FMOV  D24, X15
    FMOV  V24.D[1], X15
    FMOV  D25, X14
    FMOV  V25.D[1], X8
    FMOV  D26, X16
    FMOV  V26.D[1], X22
    FMOV  D27, X26
    FMOV  V27.D[1], X22
    FMOV  D28, X23
    FMOV  V28.D[1], X13
    FMOV  D29, X21
    FMOV  V29.D[1], X7
    FMOV  D30, X23
    FMOV  V30.D[1], X21
    FMOV  D31, X22
    FMOV  V31.D[1], X29
    MOVZ  X12, #0xf, LSL #0
TSRTFloatMinMax_label_8:
    FMAXNM  D17, D25, D30
    FMAX  H1, H29, H29
    FMIN  S9, S27, S26
    FMAX  H22, H31, H17
    FMAXNM  D30, D28, D24
    FMAX  H5, H1, H30
    FMINNM  H10, H9, H23
    FMAX  S29, S22, S10
    FMINNM  S29, S5, S5
    FMAXNM  H25, H29, H29
    FMAXNM  S18, S25, S14
    FMINNM  S27, S31, S12
    FMIN  H12, H27, H7
    FMIN  H22, H7, H17
    FMIN  H23, H22, H21
    FMIN  S27, S7, S11
    FMIN  D21, D5, D18
    FMAXNM  H5, H4, H3
    FMINNM  H18, H14, H0
    FMIN  H9, H7, H29
    FMAX  D31, D10, D23
    FMAX  S11, S30, S2
    FMAXNM  S22, S4, S6
    FMAX  D3, D22, D18
    FMIN  D22, D27, D12
    FMAX  D4, D22, D22
    FMAXNM  S25, S11, S4
    FMIN  H18, H5, H21
    FMAX  S6, S18, S11
    FMAX  S0, S9, S6
    FMAX  D2, D31, D31
    FMIN  S29, S2, S13
    FMAXNM  S18, S0, S25
    FMAXNM  S28, S18, S18
    FMAXNM  H4, H28, H11
    FMAX  D14, D4, D3
    FMAX  D18, D4, D7
    FMINNM  H25, H14, H29
    FMAXNM  D23, D25, D25
    FMAX  H2, H23, H23
    FMAXNM  S3, S18, S18
    FMIN  H0, H2, H3
    FMAXNM  S30, S26, S30
    FMIN  S9, S5, S30
    FMAXNM  H11, H8, H22
    FMINNM  H29, H26, H30
    FMIN  D8, D29, D6
    FMAX  H18, H8, H26
    FMINNM  S21, S14, S2
    FMAXNM  D2, D17, D19
    FMAXNM  H19, H24, H29
    FMINNM  S28, S31, S14
    FMIN  S8, S4, S12
    FMINNM  H12, H2, H19
    FMAX  D19, D12, D18
    FMIN  H24, H9, H8
    FMINNM  H13, H24, H24
    FMAX  S26, S20, S11
    FMAX  H6, H21, H21
    FMIN  H24, H28, H28
    FMAXNM  H14, H26, H24
    FMAXNM  H20, H11, H13
    FMAXNM  H3, H19, H20
    FMINNM  S18, S6, S0
    FMAXNM  D19, D14, D14
    FMINNM  D17, D19, D19
    FMAXNM  D9, D17, D3
    FMAX  S8, S18, S9
    FMIN  D31, D30, D17
    FMAXNM  S6, S4, S28
    FMAXNM  D29, D21, D2
    FMAX  D17, D30, D7
    FMIN  D21, D25, D6
    FMIN  D13, D25, D23
    FMAX  S20, S16, S0
    FMAX  H30, H7, H10
    FMIN  D10, D24, D2
    FMIN  H6, H8, H0
    FMAXNM  D24, D29, D31
    FMIN  D14, D13, D17
    FMINNM  S13, S20, S21
    FMIN  S25, S13, S13
    FMAX  S17, S14, S24
    FMAXNM  S19, S25, S30
    FMINNM  H3, H10, H17
    FMINNM  S30, S3, S6
    FMAX  D28, D19, D30
    FMINNM  S6, S13, S22
    FMAX  H17, H26, H21
    FMINNM  S3, S7, S6
    FMAXNM  D16, D29, D5
    FMINNM  D22, D29, D1
    FMINNM  D18, D29, D9
    FMINNM  S10, S1, S21
    FMAXNM  H31, H13, H3
    FMAX  S21, S10, S16
    FMAXNM  H29, H2, H25
    FMAX  D23, D13, D9
    FMINNM  S0, S4, S22
    FMIN  H25, H29, H22
    FMINNM  S22, S18, S28
    FMINNM  S29, S3, S7
    FMIN  H24, H16, H21
    FMINNM  H30, H30, H25
    FMIN  D26, D14, D31
    FMIN  S18, S13, S28
    FMAXNM  S21, S24, S17
    FMINNM  H17, H23, H30
    FMAX  D6, D5, D17
    FMIN  H28, H26, H6
    FMIN  H20, H21, H18
    FMAXNM  H23, H9, H0
    FMAX  D3, D22, D28
    FMAXNM  S4, S3, S20
    FMAX  H6, H29, H4
    FMINNM  S30, S6, S6
    FMIN  D19, D1, D30
    FMIN  D22, D23, D23
    FMAXNM  H26, H22, H19
    FMAX  S7, S30, S15
    FMIN  H28, H17, H24
    FMINNM  D21, D19, D20
    FMIN  S22, S6, S17
    FMINNM  D3, D26, D21
    FMAX  D4, D11, D8
    FMINNM  D30, D21, D3
    FMAXNM  D26, D7, D4
    FMIN  H16, H31, H9
    FMIN  S17, S10, S17
    FMIN  D4, D27, D29
    FMAX  D27, D19, D16
    FMIN  D0, D20, D5
    FMAXNM  D23, D21, D7
    FMAXNM  D14, D0, D28
    FMIN  D8, D30, D23
    FMAX  D6, D27, D13
    FMINNM  D7, D14, D8
    FMINNM  H1, H26, H6
    FMINNM  H5, H17, H4
    FMAXNM  S17, S7, S7
    FMIN  D7, D1, D1
    FMAXNM  D27, D22, D22
    FMAX  H23, H27, H17
    FMAX  H31, H5, H23
    FMINNM  D17, D13, D31
    FMINNM  D13, D7, D17
    FMINNM  H21, H1, H3
    FMAX  S10, S29, S22
    FMINNM  S22, S18, S16
    FMAX  D31, D1, D9
    FMINNM  D3, D26, D14
    FMINNM  S20, S19, S12
    FMAX  S11, S6, S17
    FMIN  S18, S1, S29
    FMAXNM  S23, S29, S13
    FMIN  S27, S10, S23
    FMAXNM  S4, S11, S15
    FMAX  D11, D4, D18
    FMAX  S13, S11, S22
    FMIN  D30, D16, D3
    FMAX  D17, D21, D27
    FMINNM  S6, S20, S8
    FMAX  D15, D13, D13
    FMINNM  S21, S30, S31
    FMINNM  D14, D17, D20
    FMAX  D9, D14, D14
    FMAXNM  H4, H9, H6
    FMIN  S14, S15, S21
    FMAXNM  D9, D4, D4
    FMAX  D4, D9, D14
    FMIN  H11, H15, H11
    FMIN  S26, S2, S4
    FMIN  S18, S17, S17
    FMAX  H13, H29, H13
    FMIN  D3, D6, D1
    FMINNM  H12, H9, H1
    FMIN  H14, H30, H14
    FMAX  S27, S28, S17
    FMAX  S6, S29, S29
    FMAXNM  D23, D14, D26
    FMAXNM  S9, S18, S11
    FMIN  D18, D9, D13
    FMIN  D1, D18, D23
    FMIN  H21, H6, H1
    FMAX  D16, D12, D27
    FMAXNM  D6, D3, D21
    FMINNM  S2, S16, S16
    FMIN  H3, H2, H2
    FMINNM  D20, D6, D6
    FMINNM  H2, H20, H3
    FMAX  S30, S5, S29
    FMINNM  D28, D24, D22
    FMAXNM  D6, D2, D4
    FMAXNM  H15, H29, H18
    FMIN  H21, H30, H6
    FMAX  S23, S8, S1
    FMINNM  D6, D8, D12
    FMINNM  D22, D21, D29
    FMIN  H17, H22, H29
    FMINNM  D13, D14, D1
    SUBS  X12, X12, #0x1
    B.NE  TSRTFloatMinMax_label_8
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x81, LSL #0
    MRS  X20, FPSR
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V0.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D0
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V1.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D1
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V2.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D2
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V3.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D3
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D4
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V5.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D5
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V6.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D6
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V7.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D7
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V8.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D8
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V9.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D9
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V10.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D10
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V11.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D11
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V12.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D12
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V13.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D13
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V14.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D14
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V15.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D15
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V16.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D16
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V17.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D17
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V18.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D18
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V19.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D19
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V20.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D20
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V21.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D21
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V22.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D22
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V23.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D23
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V24.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D24
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V25.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D25
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V26.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D26
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V27.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D27
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V28.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D28
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D29
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D30
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, V31.D[1]
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X20, D31
    SUB  X25, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x1557, LSL #0
    MOVK  X3, #0xf66f, LSL #16
    MOVK  X3, #0x2f3d, LSL #32
    MOVK  X3, #0xc0cd, LSL #48
    MOVZ  X4, #0xe713, LSL #0
    MOVK  X4, #0x4a70, LSL #16
    MOVK  X4, #0xe9d9, LSL #32
    MOVK  X4, #0x7f2b, LSL #48
    MOVZ  X5, #0x409f, LSL #0
    MOVK  X5, #0x1122, LSL #16
    MOVK  X5, #0x9278, LSL #32
    MOVK  X5, #0x2d6, LSL #48
    MOVZ  X6, #0xbd67, LSL #0
    MOVK  X6, #0x5e0, LSL #16
    MOVK  X6, #0xb982, LSL #32
    MOVK  X6, #0x8c17, LSL #48
    MOVZ  X7, #0xb598, LSL #0
    MOVK  X7, #0x163e, LSL #16
    MOVK  X7, #0x7d58, LSL #32
    MOVK  X7, #0xab14, LSL #48
    MOVZ  X8, #0xf66, LSL #0
    MOVK  X8, #0xf582, LSL #16
    MOVK  X8, #0x646e, LSL #32
    MOVK  X8, #0x2620, LSL #48
    MOVZ  X9, #0xb57b, LSL #0
    MOVK  X9, #0xf0ae, LSL #16
    MOVK  X9, #0x821e, LSL #32
    MOVK  X9, #0x996f, LSL #48
    MOVZ  X10, #0xe123, LSL #0
    MOVK  X10, #0x68c5, LSL #16
    MOVK  X10, #0xc887, LSL #32
    MOVK  X10, #0x768f, LSL #48
    MOVZ  X12, #0xf4f9, LSL #0
    MOVK  X12, #0xa5a8, LSL #16
    MOVK  X12, #0xa8cb, LSL #32
    MOVK  X12, #0x6102, LSL #48
    MOVZ  X13, #0xcde, LSL #0
    MOVK  X13, #0x67e9, LSL #16
    MOVK  X13, #0x2da0, LSL #32
    MOVK  X13, #0x9cff, LSL #48
    MOVZ  X14, #0xe116, LSL #0
    MOVK  X14, #0x707c, LSL #16
    MOVK  X14, #0x1fc3, LSL #32
    MOVK  X14, #0x539a, LSL #48
    MOVZ  X15, #0x83a9, LSL #0
    MOVK  X15, #0xc1b, LSL #16
    MOVK  X15, #0x9f9b, LSL #32
    MOVK  X15, #0x2ff7, LSL #48
    MOVZ  X16, #0x5599, LSL #0
    MOVK  X16, #0xfa44, LSL #16
    MOVK  X16, #0x7a93, LSL #32
    MOVK  X16, #0x2ef6, LSL #48
    MOVZ  X17, #0x532f, LSL #0
    MOVK  X17, #0x126d, LSL #16
    MOVK  X17, #0x4f6, LSL #32
    MOVK  X17, #0xd1b9, LSL #48
    MOVZ  X18, #0x58c2, LSL #0
    MOVK  X18, #0x51ed, LSL #16
    MOVK  X18, #0x1e3d, LSL #32
    MOVK  X18, #0x757a, LSL #48
    MOVZ  X20, #0x5b21, LSL #0
    MOVK  X20, #0xb44d, LSL #16
    MOVK  X20, #0x790a, LSL #32
    MOVK  X20, #0xd5c7, LSL #48
    MOVZ  X21, #0xcf2b, LSL #0
    MOVK  X21, #0x873c, LSL #16
    MOVK  X21, #0xd7bc, LSL #32
    MOVK  X21, #0xded7, LSL #48
    MOVZ  X22, #0xa2c8, LSL #0
    MOVK  X22, #0x9cb5, LSL #16
    MOVK  X22, #0x4d85, LSL #32
    MOVK  X22, #0x4d3c, LSL #48
    MOVZ  X23, #0xf204, LSL #0
    MOVK  X23, #0xc5c0, LSL #16
    MOVK  X23, #0x1421, LSL #32
    MOVK  X23, #0x80a3, LSL #48
    MOVZ  X24, #0x418f, LSL #0
    MOVK  X24, #0x19ba, LSL #16
    MOVK  X24, #0xf48, LSL #32
    MOVK  X24, #0xc4ad, LSL #48
    MOVZ  X25, #0x9890, LSL #0
    MOVK  X25, #0xf4a9, LSL #16
    MOVK  X25, #0xc94f, LSL #32
    MOVK  X25, #0xcbf3, LSL #48
    MOVZ  X26, #0x3880, LSL #0
    MOVK  X26, #0x9b5a, LSL #16
    MOVK  X26, #0x856a, LSL #32
    MOVK  X26, #0x9b2c, LSL #48
    MOVZ  X28, #0x6d71, LSL #0
    MOVK  X28, #0xf5fe, LSL #16
    MOVK  X28, #0x38d2, LSL #32
    MOVK  X28, #0x8498, LSL #48
    MOVZ  X29, #0x724, LSL #0
    MOVK  X29, #0xf4f8, LSL #16
    MOVK  X29, #0xece1, LSL #32
    MOVK  X29, #0x8581, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X24
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X8
    FMOV  D3, X16
    FMOV  V3.D[1], X23
    FMOV  D4, X9
    FMOV  V4.D[1], X28
    FMOV  D5, X22
    FMOV  V5.D[1], X22
    FMOV  D6, X3
    FMOV  V6.D[1], X7
    FMOV  D7, X10
    FMOV  V7.D[1], X29
    FMOV  D8, X9
    FMOV  V8.D[1], X4
    FMOV  D9, X15
    FMOV  V9.D[1], X29
    FMOV  D10, X9
    FMOV  V10.D[1], X29
    FMOV  D11, X8
    FMOV  V11.D[1], X12
    FMOV  D12, X18
    FMOV  V12.D[1], X18
    FMOV  D13, X26
    FMOV  V13.D[1], X23
    FMOV  D14, X28
    FMOV  V14.D[1], X12
    FMOV  D15, X4
    FMOV  V15.D[1], X6
    FMOV  D16, X17
    FMOV  V16.D[1], X6
    FMOV  D17, X23
    FMOV  V17.D[1], X3
    FMOV  D18, X23
    FMOV  V18.D[1], X6
    FMOV  D19, X22
    FMOV  V19.D[1], X15
    FMOV  D20, X28
    FMOV  V20.D[1], X28
    FMOV  D21, X25
    FMOV  V21.D[1], X10
    FMOV  D22, X23
    FMOV  V22.D[1], X28
    FMOV  D23, X24
    FMOV  V23.D[1], X8
    FMOV  D24, X7
    FMOV  V24.D[1], X8
    FMOV  D25, X14
    FMOV  V25.D[1], X7
    FMOV  D26, X22
    FMOV  V26.D[1], X12
    FMOV  D27, X6
    FMOV  V27.D[1], X7
    FMOV  D28, X21
    FMOV  V28.D[1], X22
    FMOV  D29, X3
    FMOV  V29.D[1], X25
    FMOV  D30, X14
    FMOV  V30.D[1], X25
    FMOV  D31, X12
    FMOV  V31.D[1], X25
    MOVZ  X23, #0xf, LSL #0
TSRTFloatMinMax_label_9:
    FMAXNM  H19, H25, H25
    FMIN  H2, H24, H20
    FMAXNM  H4, H2, H23
    FMINNM  D14, D30, D19
    FMIN  D17, D31, D4
    FMIN  H11, H22, H29
    FMAX  H18, H17, H11
    FMIN  H16, H28, H28
    FMIN  H8, H14, H27
    FMAX  H17, H8, H18
    FMINNM  D19, D16, D26
    FMINNM  D28, D19, D19
    FMIN  S27, S17, S28
    FMAX  S17, S28, S7
    FMINNM  S4, S14, S8
    FMAX  S28, S7, S3
    FMINNM  D24, D4, D3
    FMAXNM  D23, D3, D28
    FMIN  S7, S25, S24
    FMIN  S11, S20, S9
    FMIN  H31, H11, H30
    FMINNM  D9, D12, D21
    FMIN  H24, H8, H10
    FMAX  D18, D25, D1
    FMINNM  S10, S3, S22
    FMIN  H2, H31, H10
    FMAX  S30, S2, S9
    FMINNM  H14, H24, H18
    FMAXNM  D12, D27, D27
    FMINNM  S27, S30, S17
    FMIN  D29, D27, D14
    FMAX  H27, H7, H12
    FMIN  D22, D27, D27
    FMAXNM  S20, S23, S29
    FMAX  S27, S22, S22
    FMAXNM  S12, S27, S27
    FMINNM  D21, D12, D20
    FMAX  S26, S27, S31
    FMINNM  H10, H18, H27
    FMINNM  S7, S15, S17
    FMINNM  S22, S22, S14
    FMAXNM  D24, D30, D7
    FMAX  D23, D15, D24
    FMINNM  H17, H15, H8
    FMAXNM  H29, H23, H12
    FMIN  H20, H31, H19
    FMINNM  S2, S11, S1
    FMINNM  S23, S3, S22
    FMINNM  S27, S19, S31
    FMAX  S3, S20, S30
    FMIN  H30, H10, H23
    FMAXNM  H7, H2, H17
    FMIN  D31, D29, D7
    FMINNM  H22, H31, H30
    FMINNM  H9, H22, H4
    FMIN  H12, H27, H27
    FMINNM  H14, H9, H26
    FMAX  D18, D14, D14
    FMINNM  H20, H12, H18
    FMAXNM  D17, D3, D20
    FMIN  D3, D17, D17
    FMIN  S9, S3, S3
    FMIN  D26, D9, D21
    FMINNM  D17, D14, D7
    FMAX  S19, S22, S5
    FMAX  S22, S10, S12
    FMINNM  S3, S0, S21
    FMINNM  S18, S20, S28
    FMAX  D23, D4, D7
    FMAX  S31, S25, S17
    FMAXNM  D27, D28, D4
    FMAXNM  H5, H31, H1
    FMAXNM  S31, S19, S16
    FMINNM  H14, H20, H21
    FMAXNM  H10, H23, H26
    FMAX  S9, S22, S22
    FMINNM  H22, H5, H31
    FMAX  S7, S27, S18
    FMINNM  S16, S14, S3
    FMAX  S12, S9, S7
    FMAX  H1, H12, H10
    FMINNM  D14, D16, D1
    FMAX  H1, H22, H14
    FMINNM  H22, H27, H22
    FMAX  S21, S17, S31
    FMIN  D20, D2, D17
    FMAXNM  D23, D7, D1
    FMAX  S4, S20, S7
    FMIN  S0, S6, S9
    FMAX  D28, D23, D30
    FMINNM  H23, H14, H26
    FMAX  S12, S12, S2
    FMINNM  H30, H7, H17
    FMINNM  D31, D17, D27
    FMINNM  S6, S21, S0
    FMAX  S1, S6, S31
    FMINNM  S17, S22, S22
    FMIN  S16, S4, S4
    FMINNM  H10, H28, H1
    FMAX  S22, S23, S23
    FMINNM  D26, D12, D22
    FMAX  D23, D30, D30
    FMINNM  S20, S23, S23
    FMAXNM  H14, H16, H20
    FMINNM  S16, S16, S10
    FMAX  S3, S16, S14
    FMIN  H16, H26, H17
    FMIN  H22, H16, H3
    FMAX  H3, H27, H12
    FMAXNM  D12, D20, D26
    FMAX  D30, D31, D8
    FMAXNM  S10, S14, S29
    FMINNM  D17, D26, D17
    FMIN  D16, D0, D11
    FMIN  S0, S31, S2
    FMINNM  S29, S29, S21
    FMINNM  S11, S30, S29
    FMAX  H26, H11, H16
    FMAXNM  D11, D3, D0
    FMINNM  S31, S10, S11
    FMAXNM  H23, H26, H27
    FMAX  S2, S22, S31
    FMIN  H26, H23, H12
    FMINNM  S12, S2, S2
    FMINNM  D16, D0, D19
    FMAXNM  S23, S26, S12
    FMIN  H2, H16, H17
    FMAXNM  S26, S2, S18
    FMINNM  S0, S23, S23
    FMINNM  D29, D26, D0
    FMAXNM  D18, D5, D24
    FMAX  S5, S11, S14
    FMAXNM  D23, D2, D7
    FMAX  D12, D4, D20
    FMAXNM  H10, H6, H29
    FMAX  H14, H2, H13
    FMIN  H31, H12, H19
    FMIN  H7, H26, H27
    FMAX  S27, S21, S23
    FMINNM  S30, S21, S12
    FMAXNM  S24, S14, S10
    FMIN  D14, D13, D26
    FMIN  H4, H15, H12
    FMINNM  H21, H24, H24
    FMIN  S0, S14, S7
    FMAX  S10, S31, S31
    FMAXNM  D13, D21, D9
    FMAXNM  S21, S13, S4
    FMAXNM  S4, S27, S27
    FMIN  D31, D4, D0
    FMINNM  D0, D18, D30
    FMAX  H19, H10, H5
    FMAX  S29, S0, S31
    FMAX  S24, S29, S19
    FMINNM  D0, D24, D24
    FMAX  D30, D21, D0
    FMINNM  H31, H26, H26
    FMINNM  D12, D10, D20
    FMAX  H26, H2, H17
    FMIN  H27, H16, H31
    FMAX  S21, S8, S26
    FMINNM  S2, S16, S15
    FMINNM  S0, S25, S18
    FMIN  H14, H8, H12
    FMIN  S17, S10, S10
    FMAX  H4, H26, H20
    FMINNM  H10, H7, H12
    FMAXNM  D24, D30, D30
    FMAX  H5, H24, H14
    FMIN  S31, S27, S17
    FMAX  H13, H31, H31
    FMAX  D19, D0, D0
    FMINNM  S7, S4, S2
    FMAX  H30, H19, H21
    FMINNM  S26, S13, S30
    FMINNM  S16, S5, S7
    FMAXNM  S18, S26, S10
    FMAX  H30, H18, H18
    FMINNM  D18, D30, D30
    FMINNM  H10, H16, H18
    FMIN  D0, D19, D4
    FMIN  S8, S12, S15
    FMINNM  H13, H2, H9
    FMINNM  H21, H7, H11
    FMIN  S30, S25, S30
    FMAXNM  S18, S9, S26
    FMAXNM  D31, D9, D13
    FMAX  D27, D6, D29
    FMAXNM  H11, H20, H21
    FMAX  D6, D4, D7
    FMIN  H16, H31, H27
    FMAX  D5, D11, D10
    FMINNM  H19, H5, H5
    FMIN  D11, D18, D19
    FMINNM  H17, H11, H6
    FMAXNM  D10, D30, D17
    FMINNM  S19, S8, S16
    FMAX  H5, H10, H19
    FMIN  D17, D0, D5
    FMAX  H26, H29, H31
    SUBS  X23, X23, #0x1
    B.NE  TSRTFloatMinMax_label_9
    MOVZ  X25, #0x1557, LSL #0
    MOVK  X25, #0xf66f, LSL #16
    MOVK  X25, #0x2f3d, LSL #32
    MOVK  X25, #0xc0cd, LSL #48
    SUB  X24, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xe713, LSL #0
    MOVK  X25, #0x4a70, LSL #16
    MOVK  X25, #0xe9d9, LSL #32
    MOVK  X25, #0x7f2b, LSL #48
    SUB  X24, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x409f, LSL #0
    MOVK  X25, #0x1122, LSL #16
    MOVK  X25, #0x9278, LSL #32
    MOVK  X25, #0x2d6, LSL #48
    SUB  X24, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xbd67, LSL #0
    MOVK  X25, #0x5e0, LSL #16
    MOVK  X25, #0xb982, LSL #32
    MOVK  X25, #0x8c17, LSL #48
    SUB  X24, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xb598, LSL #0
    MOVK  X25, #0x163e, LSL #16
    MOVK  X25, #0x7d58, LSL #32
    MOVK  X25, #0xab14, LSL #48
    SUB  X24, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xf66, LSL #0
    MOVK  X25, #0xf582, LSL #16
    MOVK  X25, #0x646e, LSL #32
    MOVK  X25, #0x2620, LSL #48
    SUB  X24, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xb57b, LSL #0
    MOVK  X25, #0xf0ae, LSL #16
    MOVK  X25, #0x821e, LSL #32
    MOVK  X25, #0x996f, LSL #48
    SUB  X24, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xe123, LSL #0
    MOVK  X25, #0x68c5, LSL #16
    MOVK  X25, #0xc887, LSL #32
    MOVK  X25, #0x768f, LSL #48
    SUB  X24, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xf4f9, LSL #0
    MOVK  X25, #0xa5a8, LSL #16
    MOVK  X25, #0xa8cb, LSL #32
    MOVK  X25, #0x6102, LSL #48
    SUB  X24, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xcde, LSL #0
    MOVK  X25, #0x67e9, LSL #16
    MOVK  X25, #0x2da0, LSL #32
    MOVK  X25, #0x9cff, LSL #48
    SUB  X24, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xe116, LSL #0
    MOVK  X25, #0x707c, LSL #16
    MOVK  X25, #0x1fc3, LSL #32
    MOVK  X25, #0x539a, LSL #48
    SUB  X24, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x83a9, LSL #0
    MOVK  X25, #0xc1b, LSL #16
    MOVK  X25, #0x9f9b, LSL #32
    MOVK  X25, #0x2ff7, LSL #48
    SUB  X24, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x532f, LSL #0
    MOVK  X25, #0x126d, LSL #16
    MOVK  X25, #0x4f6, LSL #32
    MOVK  X25, #0xd1b9, LSL #48
    SUB  X24, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x58c2, LSL #0
    MOVK  X25, #0x51ed, LSL #16
    MOVK  X25, #0x1e3d, LSL #32
    MOVK  X25, #0x757a, LSL #48
    SUB  X24, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x5b21, LSL #0
    MOVK  X25, #0xb44d, LSL #16
    MOVK  X25, #0x790a, LSL #32
    MOVK  X25, #0xd5c7, LSL #48
    SUB  X24, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xcf2b, LSL #0
    MOVK  X25, #0x873c, LSL #16
    MOVK  X25, #0xd7bc, LSL #32
    MOVK  X25, #0xded7, LSL #48
    SUB  X24, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xa2c8, LSL #0
    MOVK  X25, #0x9cb5, LSL #16
    MOVK  X25, #0x4d85, LSL #32
    MOVK  X25, #0x4d3c, LSL #48
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x3880, LSL #0
    MOVK  X25, #0x9b5a, LSL #16
    MOVK  X25, #0x856a, LSL #32
    MOVK  X25, #0x9b2c, LSL #48
    SUB  X24, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x6d71, LSL #0
    MOVK  X25, #0xf5fe, LSL #16
    MOVK  X25, #0x38d2, LSL #32
    MOVK  X25, #0x8498, LSL #48
    SUB  X24, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x724, LSL #0
    MOVK  X25, #0xf4f8, LSL #16
    MOVK  X25, #0xece1, LSL #32
    MOVK  X25, #0x8581, LSL #48
    SUB  X24, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x81, LSL #0
    MRS  X24, FPSR
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D0
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D1
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D2
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D3
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D4
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D5
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D6
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D7
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D8
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D9
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D10
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D11
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D12
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D13
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D14
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xbd67, LSL #0
    MOVK  X25, #0x5e0, LSL #16
    MOVK  X25, #0xb982, LSL #32
    MOVK  X25, #0x8c17, LSL #48
    FMOV  X24, V15.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xe713, LSL #0
    MOVK  X25, #0x4a70, LSL #16
    MOVK  X25, #0xe9d9, LSL #32
    MOVK  X25, #0x7f2b, LSL #48
    FMOV  X24, D15
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D16
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D17
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D18
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D19
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D20
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D22
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D23
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D24
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xb598, LSL #0
    MOVK  X25, #0x163e, LSL #16
    MOVK  X25, #0x7d58, LSL #32
    MOVK  X25, #0xab14, LSL #48
    FMOV  X24, V25.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0xe116, LSL #0
    MOVK  X25, #0x707c, LSL #16
    MOVK  X25, #0x1fc3, LSL #32
    MOVK  X25, #0x539a, LSL #48
    FMOV  X24, D25
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D26
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D27
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D28
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D29
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D30
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X16, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X18
    FMOV  V0.D[1], X4
    FMOV  D1, X24
    FMOV  V1.D[1], X12
    FMOV  D2, X29
    FMOV  V2.D[1], X13
    FMOV  D3, X28
    FMOV  V3.D[1], X16
    FMOV  D4, X17
    FMOV  V4.D[1], X21
    FMOV  D5, X26
    FMOV  V5.D[1], X25
    FMOV  D6, X23
    FMOV  V6.D[1], X22
    FMOV  D7, X6
    FMOV  V7.D[1], X14
    FMOV  D8, X13
    FMOV  V8.D[1], X29
    FMOV  D9, X24
    FMOV  V9.D[1], X26
    FMOV  D10, X20
    FMOV  V10.D[1], X28
    FMOV  D11, X8
    FMOV  V11.D[1], X9
    FMOV  D12, X17
    FMOV  V12.D[1], X14
    FMOV  D13, X17
    FMOV  V13.D[1], X23
    FMOV  D14, X5
    FMOV  V14.D[1], X20
    FMOV  D15, X24
    FMOV  V15.D[1], X18
    FMOV  D16, X10
    FMOV  V16.D[1], X26
    FMOV  D17, X7
    FMOV  V17.D[1], X26
    FMOV  D18, X10
    FMOV  V18.D[1], X21
    FMOV  D19, X20
    FMOV  V19.D[1], X12
    FMOV  D20, X29
    FMOV  V20.D[1], X6
    FMOV  D21, X10
    FMOV  V21.D[1], X29
    FMOV  D22, X4
    FMOV  V22.D[1], X28
    FMOV  D23, X15
    FMOV  V23.D[1], X23
    FMOV  D24, X25
    FMOV  V24.D[1], X12
    FMOV  D25, X14
    FMOV  V25.D[1], X25
    FMOV  D26, X5
    FMOV  V26.D[1], X14
    FMOV  D27, X28
    FMOV  V27.D[1], X18
    FMOV  D28, X22
    FMOV  V28.D[1], X8
    FMOV  D29, X29
    FMOV  V29.D[1], X14
    FMOV  D30, X24
    FMOV  V30.D[1], X15
    FMOV  D31, X13
    FMOV  V31.D[1], X5
    MOVZ  X22, #0xf, LSL #0
TSRTFloatMinMax_label_10:
    FMAXNM  H18, H25, H29
    FMAXNM  S7, S31, S31
    FMIN  S15, S26, S7
    FMINNM  D23, D27, D21
    FMINNM  D17, D30, D30
    FMAX  D30, D28, D18
    FMAXNM  D27, D24, D30
    FMIN  D17, D15, D15
    FMAX  H11, H23, H23
    FMAX  S8, S17, S22
    FMINNM  H29, H8, H27
    FMINNM  S30, S11, S29
    FMAX  H18, H6, H22
    FMINNM  H15, H7, H11
    FMAX  D29, D14, D21
    FMAXNM  H23, H31, H31
    FMAXNM  S0, S23, S2
    FMAX  S25, S30, S20
    FMIN  H21, H23, H20
    FMAX  D23, D27, D31
    FMINNM  S28, S17, S28
    FMIN  D26, D12, D27
    FMAXNM  S24, S23, S18
    FMAX  S31, S25, S28
    FMAXNM  S27, S15, S21
    FMAX  S15, S26, S0
    FMIN  S2, S29, S24
    FMIN  H29, H2, H31
    FMIN  S17, S29, S29
    FMAX  D25, D28, D27
    FMAXNM  H21, H28, H25
    FMIN  S24, S15, S17
    FMIN  D26, D21, D24
    FMAX  H11, H20, H23
    FMIN  H29, H29, H19
    FMIN  H25, H31, H23
    FMINNM  D12, D4, D15
    FMIN  S15, S2, S28
    FMAX  S27, S4, S8
    FMIN  S0, S21, S0
    FMAX  S23, S0, S21
    FMAXNM  S17, S6, S25
    FMAXNM  H18, H8, H25
    FMAX  S19, S26, S25
    FMINNM  S6, S12, S11
    FMAXNM  S0, S18, S27
    FMINNM  S24, S17, S0
    FMAXNM  H18, H10, H6
    FMIN  S6, S18, S24
    FMAXNM  D10, D23, D19
    FMINNM  H23, H18, H6
    FMAXNM  H8, H29, H4
    FMIN  S11, S10, S25
    FMAX  D28, D15, D20
    FMINNM  H17, H28, H8
    FMAX  S0, S5, S23
    FMAXNM  D23, D11, D0
    FMAX  H24, H17, H17
    FMAX  D19, D19, D24
    FMINNM  S10, S23, S23
    FMINNM  D27, D25, D19
    FMIN  S21, S27, S27
    FMAXNM  D5, D21, D10
    FMIN  H17, H25, H5
    FMINNM  S15, S23, S0
    FMAXNM  D27, D23, D23
    FMAXNM  D24, D22, D4
    FMIN  D20, D6, D25
    FMIN  D22, D10, D26
    FMAXNM  S21, S31, S27
    FMAX  H4, H18, H16
    FMAX  S5, S19, S28
    FMAX  D28, D5, D10
    FMIN  H0, H7, H1
    FMAXNM  H11, H21, H16
    FMINNM  H19, H24, H17
    FMAX  D18, D15, D28
    FMIN  H6, H4, H6
    FMAX  S10, S14, S6
    FMIN  S14, S22, S18
    FMAXNM  H7, H14, H20
    FMINNM  D17, D0, D7
    FMIN  S0, S11, S17
    FMAXNM  H28, H0, H6
    FMAX  D6, D10, D28
    FMAX  S1, S19, S5
    FMINNM  H19, H6, H6
    FMINNM  S22, S19, S19
    FMIN  H16, H22, H1
    FMAX  H18, H16, H1
    FMAX  S17, S19, S19
    FMAXNM  D21, D10, D30
    FMAXNM  S0, S1, S21
    FMAX  H4, H6, H22
    FMAXNM  H21, H16, H31
    FMINNM  H19, H14, H25
    FMAX  H15, H24, H4
    FMINNM  H30, H22, H5
    FMIN  S6, S7, S6
    FMAXNM  H20, H0, H30
    FMIN  D11, D5, D19
    FMAX  H19, H1, H15
    FMAX  S28, S10, S21
    FMIN  H21, H10, H20
    FMINNM  S16, S4, S13
    FMAXNM  H10, H11, H6
    FMINNM  H30, H25, H25
    FMIN  S20, S9, S15
    FMIN  D5, D19, D21
    FMIN  H0, H28, H18
    FMAXNM  H13, H16, H16
    FMINNM  D19, D10, D30
    FMAXNM  H4, H20, H5
    FMAX  S14, S17, S0
    FMAX  H10, H14, H14
    FMAX  S21, S10, S10
    FMAX  D17, D4, D13
    FMINNM  S16, S21, S17
    FMINNM  S7, S16, S19
    FMINNM  H0, H1, H29
    FMIN  D29, D13, D9
    FMINNM  H28, H8, H0
    FMAX  S13, S24, S19
    FMIN  H20, H29, H12
    FMIN  H10, H22, H19
    FMINNM  H30, H19, H23
    FMAXNM  D5, D12, D10
    FMIN  S14, S11, S18
    FMAXNM  S6, S2, S15
    FMAX  D19, D12, D17
    FMINNM  D11, D14, D20
    FMINNM  H12, H11, H17
    FMIN  H16, H13, H30
    FMIN  D21, D5, D15
    FMAX  D2, D19, D21
    FMAX  S21, S28, S6
    FMAXNM  D19, D12, D7
    FMAX  D4, D19, D2
    FMAX  D27, D16, D4
    FMAX  H2, H21, H18
    FMAX  D17, D27, D27
    FMIN  D15, D2, D2
    FMAXNM  H10, H17, H15
    FMIN  H5, H8, H20
    FMIN  D27, D23, D10
    FMAXNM  H6, H13, H3
    FMAX  S13, S22, S2
    FMAX  S30, S14, S6
    FMAXNM  H21, H3, H21
    FMIN  S11, S5, S4
    FMAX  H18, H19, H29
    FMAXNM  H24, H8, H9
    FMIN  D28, D26, D4
    FMAX  H8, H3, H15
    FMIN  D15, D13, D8
    FMAX  D5, D24, D27
    FMAX  D17, D21, D11
    FMAX  H20, H5, H17
    FMINNM  S6, S18, S18
    FMAX  S23, S28, S6
    FMINNM  S6, S15, S20
    FMIN  D19, D23, D30
    FMAX  H8, H19, H19
    FMIN  S23, S8, S6
    FMAXNM  D17, D11, D29
    FMIN  S11, S24, S10
    FMIN  H30, H4, H12
    FMAXNM  S20, S5, S22
    FMAXNM  D5, D24, D13
    FMAXNM  S10, S9, S4
    FMAXNM  D13, D12, D3
    FMAX  H29, H25, H27
    FMINNM  S15, S30, S20
    FMINNM  H30, H23, H6
    FMIN  S2, S17, S15
    FMINNM  H4, H5, H30
    FMAXNM  S9, S2, S11
    FMIN  S23, S9, S29
    FMAXNM  H28, H10, H4
    FMAXNM  D30, D13, D23
    FMIN  D26, D16, D30
    FMAXNM  S30, S28, S19
    FMAX  S16, S30, S1
    FMINNM  D22, D16, D22
    FMIN  S8, S22, S17
    FMAX  D12, D8, D25
    FMAXNM  H27, H26, H12
    FMAXNM  S16, S21, S22
    FMAX  D25, D6, D10
    FMINNM  H28, H20, H24
    FMAX  D2, D22, D31
    FMINNM  H15, H11, H15
    FMINNM  H3, H28, H23
    FMINNM  H11, H12, H19
    FMAXNM  H12, H22, H3
    FMIN  D9, D1, D2
    FMAX  D2, D1, D16
    FMINNM  H5, H25, H16
    FMAXNM  H29, H6, H2
    FMIN  S24, S5, S29
    SUBS  X22, X22, #0x1
    B.NE  TSRTFloatMinMax_label_10
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x81, LSL #0
    MRS  X9, FPSR
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D0
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D1
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D2
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D3
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D4
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D5
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D6
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D7
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D9
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D10
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D11
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D12
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D13
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D14
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D15
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D16
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D17
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D18
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D19
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D20
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D21
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D22
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D23
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D24
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D25
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D26
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D27
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D28
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D29
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D30
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X9, D31
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X21
    FMOV  D1, X22
    FMOV  V1.D[1], X23
    FMOV  D2, X24
    FMOV  V2.D[1], X22
    FMOV  D3, X29
    FMOV  V3.D[1], X13
    FMOV  D4, X28
    FMOV  V4.D[1], X28
    FMOV  D5, X14
    FMOV  V5.D[1], X18
    FMOV  D6, X10
    FMOV  V6.D[1], X18
    FMOV  D7, X15
    FMOV  V7.D[1], X29
    FMOV  D8, X12
    FMOV  V8.D[1], X5
    FMOV  D9, X29
    FMOV  V9.D[1], X22
    FMOV  D10, X24
    FMOV  V10.D[1], X18
    FMOV  D11, X13
    FMOV  V11.D[1], X8
    FMOV  D12, X29
    FMOV  V12.D[1], X13
    FMOV  D13, X23
    FMOV  V13.D[1], X4
    FMOV  D14, X14
    FMOV  V14.D[1], X4
    FMOV  D15, X4
    FMOV  V15.D[1], X16
    FMOV  D16, X3
    FMOV  V16.D[1], X25
    FMOV  D17, X9
    FMOV  V17.D[1], X15
    FMOV  D18, X18
    FMOV  V18.D[1], X3
    FMOV  D19, X22
    FMOV  V19.D[1], X6
    FMOV  D20, X18
    FMOV  V20.D[1], X17
    FMOV  D21, X6
    FMOV  V21.D[1], X23
    FMOV  D22, X17
    FMOV  V22.D[1], X18
    FMOV  D23, X4
    FMOV  V23.D[1], X4
    FMOV  D24, X5
    FMOV  V24.D[1], X22
    FMOV  D25, X7
    FMOV  V25.D[1], X23
    FMOV  D26, X20
    FMOV  V26.D[1], X22
    FMOV  D27, X29
    FMOV  V27.D[1], X20
    FMOV  D28, X29
    FMOV  V28.D[1], X12
    FMOV  D29, X7
    FMOV  V29.D[1], X5
    FMOV  D30, X20
    FMOV  V30.D[1], X12
    FMOV  D31, X4
    FMOV  V31.D[1], X17
    MOVZ  X7, #0xf, LSL #0
TSRTFloatMinMax_label_11:
    FMIN  D1, D24, D29
    FMINNM  D18, D31, D28
    FMIN  S15, S27, S25
    FMIN  D12, D30, D26
    FMAX  H24, H18, H12
    FMAXNM  H22, H15, H24
    FMIN  S30, S22, S1
    FMINNM  D12, D30, D30
    FMAXNM  H22, H12, H12
    FMAXNM  D30, D22, D22
    FMAX  H11, H30, H30
    FMAXNM  H19, H11, H11
    FMAXNM  H2, H19, H23
    FMAX  D26, D1, D31
    FMIN  H23, H22, H19
    FMINNM  H12, H1, H0
    FMAXNM  D15, D23, D18
    FMAX  S18, S12, S7
    FMINNM  H25, H23, H2
    FMAX  D24, D7, D24
    FMAXNM  S27, S31, S11
    FMAXNM  D30, D18, D0
    FMINNM  D22, D10, D9
    FMIN  S7, S6, S31
    FMAX  D2, D3, D16
    FMINNM  S9, S2, S26
    FMAX  S29, S20, S9
    FMAX  D26, D22, D22
    FMINNM  S18, S26, S25
    FMIN  H26, H18, H18
    FMAXNM  H19, H30, H9
    FMIN  D22, D29, D26
    FMIN  D12, D19, D27
    FMIN  S1, S12, S22
    FMIN  S30, S24, S13
    FMAXNM  H9, H15, H15
    FMAXNM  D16, D9, D7
    FMAXNM  D11, D1, D16
    FMINNM  D25, D30, D15
    FMAX  S0, S11, S25
    FMAXNM  D24, D14, D1
    FMINNM  D3, D9, D8
    FMAXNM  S23, S30, S21
    FMIN  D27, D10, D7
    FMAXNM  H26, H0, H23
    FMAXNM  H12, H8, H11
    FMIN  D8, D0, D8
    FMINNM  S25, S21, S31
    FMINNM  S18, S15, S8
    FMINNM  S9, S11, S9
    FMAX  D30, D20, D15
    FMAXNM  H16, H27, H30
    FMINNM  D23, D3, D4
    FMINNM  D14, D22, D16
    FMAX  D1, D23, D24
    FMIN  S10, S26, S25
    FMAX  S4, S18, S18
    FMINNM  D24, D4, D10
    FMIN  D15, D14, D1
    FMAXNM  D27, D15, D9
    FMIN  D18, D24, D27
    FMAXNM  H23, H18, H18
    FMIN  D18, D12, D12
    FMINNM  S0, S19, S6
    FMINNM  S24, S0, S18
    FMINNM  S4, S30, S24
    FMAXNM  S7, S21, S23
    FMIN  D24, D7, D4
    FMIN  D4, D13, D31
    FMIN  H15, H12, H23
    FMIN  D13, D29, D8
    FMAXNM  H31, H23, H31
    FMIN  S8, S30, S9
    FMIN  S27, S19, S10
    FMIN  D19, D15, D17
    FMAXNM  H14, H16, H9
    FMAXNM  S9, S7, S5
    FMAXNM  S1, S19, S13
    FMINNM  H19, H27, H1
    FMAX  S11, S21, S14
    FMAX  S15, S9, S9
    FMAXNM  S0, S8, S19
    FMAXNM  S9, S24, S31
    FMINNM  D17, D11, D4
    FMINNM  S10, S8, S17
    FMIN  H16, H10, H10
    FMINNM  S30, S15, S16
    FMAX  S23, S30, S9
    FMINNM  S18, S23, S23
    FMINNM  H21, H18, H0
    FMIN  D7, D7, D7
    FMAX  H13, H9, H19
    FMINNM  S24, S10, S2
    FMAXNM  H18, H14, H5
    FMIN  D29, D30, D19
    FMIN  S11, S15, S28
    FMIN  D12, D9, D24
    FMAX  H31, H6, H20
    FMAXNM  H24, H16, H7
    FMAXNM  S27, S29, S31
    FMINNM  D4, D3, D4
    FMIN  D3, D19, D13
    FMAX  S8, S23, S15
    FMAX  S17, S11, S21
    FMIN  H30, H18, H18
    FMINNM  D18, D29, D17
    FMAXNM  S11, S4, S18
    FMAXNM  S15, S11, S12
    FMAX  D29, D8, D15
    FMAXNM  D0, D27, D26
    FMIN  H17, H29, H24
    FMIN  D26, D30, D30
    FMAXNM  D13, D0, D17
    FMINNM  H11, H3, H3
    FMAX  S21, S26, S13
    FMAX  H23, H11, H21
    FMIN  H2, H7, H7
    FMIN  D10, D5, D5
    FMAXNM  H7, H26, H7
    FMIN  H19, H24, H31
    FMINNM  S18, S25, S30
    FMIN  S30, S24, S29
    FMAXNM  H13, H10, H13
    FMINNM  S17, S7, S13
    FMAXNM  D5, D26, D13
    FMAX  S12, S10, S10
    FMIN  S4, S8, S8
    FMAXNM  D13, D5, D4
    FMAXNM  D3, D30, D13
    FMAX  S0, S2, S2
    FMAXNM  D11, D23, D0
    FMAX  D29, D11, D17
    FMINNM  H21, H29, H29
    FMINNM  H7, H19, H21
    FMAX  S26, S18, S3
    FMAXNM  S29, S7, S25
    FMIN  D10, D12, D12
    FMINNM  H5, H26, H29
    FMIN  S12, S10, S5
    FMINNM  H10, H6, H28
    FMINNM  H28, H10, H25
    FMINNM  S18, S5, S7
    FMINNM  H8, H10, H3
    FMIN  D3, D27, D19
    FMINNM  S17, S11, S29
    FMINNM  S5, S7, S29
    FMAXNM  S23, S12, S21
    FMINNM  H26, H19, H12
    FMINNM  H2, H14, H16
    FMAXNM  H6, H17, H28
    FMAX  D7, D3, D6
    FMAXNM  S4, S18, S2
    FMAXNM  D27, D4, D4
    FMIN  D4, D5, D8
    FMIN  H10, H23, H4
    FMINNM  D23, D7, D7
    FMAXNM  S30, S10, S23
    FMIN  D13, D14, D27
    FMINNM  S0, S13, S30
    FMAX  S5, S0, S26
    FMAXNM  H29, H26, H24
    FMIN  D16, D1, D6
    FMIN  S25, S10, S21
    FMAXNM  H11, H31, H17
    FMIN  S6, S31, S9
    FMIN  S10, S30, S7
    FMAXNM  S26, S1, S24
    FMAXNM  D7, D28, D1
    FMIN  D1, D10, D5
    FMIN  S23, S25, S1
    FMAX  S27, S6, S29
    FMAX  S8, S23, S7
    FMIN  H4, H8, H27
    FMAX  H23, H16, H16
    FMAXNM  S9, S26, S4
    FMAXNM  S31, S11, S9
    FMIN  D21, D23, D31
    FMINNM  H31, H6, H21
    FMINNM  D0, D1, D29
    FMIN  D21, D5, D27
    FMINNM  H17, H11, H31
    FMAXNM  H28, H30, H28
    FMAX  H4, H31, H19
    FMINNM  S9, S16, S4
    FMINNM  H1, H10, H25
    FMINNM  H6, H21, H3
    FMIN  H13, H5, H31
    FMINNM  S5, S18, S28
    FMIN  D24, D24, D26
    FMIN  D7, D20, D21
    FMAX  H13, H0, H0
    FMAX  H26, H9, H13
    FMIN  S23, S6, S26
    FMAX  D21, D23, D1
    FMINNM  H16, H21, H24
    FMAX  H4, H16, H16
    FMIN  H26, H17, H7
    FMIN  S25, S4, S26
    FMAX  D9, D5, D25
    FMAXNM  S3, S9, S15
    SUBS  X7, X7, #0x1
    B.NE  TSRTFloatMinMax_label_11
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x81, LSL #0
    MRS  X24, FPSR
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D0
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D1
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D2
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D3
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D4
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D5
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D6
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X24, D7
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D8
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D9
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D10
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D11
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D12
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D13
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D14
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D15
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D16
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D17
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D18
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    FMOV  X24, D19
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X24, V20.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X24, D20
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D22
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D23
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D24
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D25
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0xffff, LSL #0
    FMOV  X24, D26
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D27
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D28
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D29
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D30
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xbf07, LSL #0
    MOVK  X3, #0x1e94, LSL #16
    MOVK  X3, #0x9506, LSL #32
    MOVK  X3, #0x4055, LSL #48
    MOVZ  X4, #0xaf86, LSL #0
    MOVK  X4, #0x7879, LSL #16
    MOVK  X4, #0x2f61, LSL #32
    MOVK  X4, #0x7d2f, LSL #48
    MOVZ  X5, #0x1ffb, LSL #0
    MOVK  X5, #0x482e, LSL #16
    MOVK  X5, #0x724d, LSL #32
    MOVK  X5, #0x2f84, LSL #48
    MOVZ  X6, #0xc95d, LSL #0
    MOVK  X6, #0x1cb5, LSL #16
    MOVK  X6, #0xf29c, LSL #32
    MOVK  X6, #0x31f2, LSL #48
    MOVZ  X7, #0x531e, LSL #0
    MOVK  X7, #0x5c26, LSL #16
    MOVK  X7, #0x90ab, LSL #32
    MOVK  X7, #0x66bf, LSL #48
    MOVZ  X8, #0x24cb, LSL #0
    MOVK  X8, #0x354, LSL #16
    MOVK  X8, #0x1932, LSL #32
    MOVK  X8, #0xb587, LSL #48
    MOVZ  X9, #0x40b8, LSL #0
    MOVK  X9, #0x4578, LSL #16
    MOVK  X9, #0x6e93, LSL #32
    MOVK  X9, #0xe69f, LSL #48
    MOVZ  X10, #0xcc50, LSL #0
    MOVK  X10, #0xcf0b, LSL #16
    MOVK  X10, #0xb, LSL #32
    MOVK  X10, #0x122e, LSL #48
    MOVZ  X12, #0x7804, LSL #0
    MOVK  X12, #0x8885, LSL #16
    MOVK  X12, #0xa60c, LSL #32
    MOVK  X12, #0xab77, LSL #48
    MOVZ  X13, #0x6ede, LSL #0
    MOVK  X13, #0x4cdd, LSL #16
    MOVK  X13, #0xe263, LSL #32
    MOVK  X13, #0x5340, LSL #48
    MOVZ  X14, #0x6a43, LSL #0
    MOVK  X14, #0x1a91, LSL #16
    MOVK  X14, #0x2c38, LSL #32
    MOVK  X14, #0x9e58, LSL #48
    MOVZ  X15, #0x1254, LSL #0
    MOVK  X15, #0x6820, LSL #16
    MOVK  X15, #0xb354, LSL #32
    MOVK  X15, #0xa9de, LSL #48
    MOVZ  X16, #0xc1f4, LSL #0
    MOVK  X16, #0x4033, LSL #16
    MOVK  X16, #0x6714, LSL #32
    MOVK  X16, #0x8028, LSL #48
    MOVZ  X17, #0xd80c, LSL #0
    MOVK  X17, #0x62b5, LSL #16
    MOVK  X17, #0xa00c, LSL #32
    MOVK  X17, #0xab8d, LSL #48
    MOVZ  X18, #0xe6a9, LSL #0
    MOVK  X18, #0x6334, LSL #16
    MOVK  X18, #0xd4a5, LSL #32
    MOVK  X18, #0xe97, LSL #48
    MOVZ  X20, #0x9b8, LSL #0
    MOVK  X20, #0x915e, LSL #16
    MOVK  X20, #0xebb, LSL #32
    MOVK  X20, #0xffa7, LSL #48
    MOVZ  X21, #0xa2c3, LSL #0
    MOVK  X21, #0xb6e2, LSL #16
    MOVK  X21, #0xabbe, LSL #32
    MOVK  X21, #0x5433, LSL #48
    MOVZ  X22, #0xdd49, LSL #0
    MOVK  X22, #0x2619, LSL #16
    MOVK  X22, #0x9569, LSL #32
    MOVK  X22, #0xcc17, LSL #48
    MOVZ  X23, #0x5c66, LSL #0
    MOVK  X23, #0xaff, LSL #16
    MOVK  X23, #0x93af, LSL #32
    MOVK  X23, #0x9843, LSL #48
    MOVZ  X24, #0x3560, LSL #0
    MOVK  X24, #0xb286, LSL #16
    MOVK  X24, #0xbe62, LSL #32
    MOVK  X24, #0xf845, LSL #48
    MOVZ  X25, #0x81a1, LSL #0
    MOVK  X25, #0xa0f3, LSL #16
    MOVK  X25, #0x39f4, LSL #32
    MOVK  X25, #0x2dbe, LSL #48
    MOVZ  X26, #0x7099, LSL #0
    MOVK  X26, #0xe953, LSL #16
    MOVK  X26, #0x63d7, LSL #32
    MOVK  X26, #0xb73c, LSL #48
    MOVZ  X28, #0xdccf, LSL #0
    MOVK  X28, #0x3da4, LSL #16
    MOVK  X28, #0xfe4a, LSL #32
    MOVK  X28, #0x3e9c, LSL #48
    MOVZ  X29, #0xffb5, LSL #0
    MOVK  X29, #0xbe75, LSL #16
    MOVK  X29, #0x32c8, LSL #32
    MOVK  X29, #0xc758, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X29
    FMOV  D3, X23
    FMOV  V3.D[1], X16
    FMOV  D4, X12
    FMOV  V4.D[1], X14
    FMOV  D5, X20
    FMOV  V5.D[1], X18
    FMOV  D6, X23
    FMOV  V6.D[1], X16
    FMOV  D7, X6
    FMOV  V7.D[1], X6
    FMOV  D8, X13
    FMOV  V8.D[1], X6
    FMOV  D9, X24
    FMOV  V9.D[1], X7
    FMOV  D10, X20
    FMOV  V10.D[1], X5
    FMOV  D11, X17
    FMOV  V11.D[1], X4
    FMOV  D12, X29
    FMOV  V12.D[1], X12
    FMOV  D13, X24
    FMOV  V13.D[1], X3
    FMOV  D14, X10
    FMOV  V14.D[1], X15
    FMOV  D15, X20
    FMOV  V15.D[1], X6
    FMOV  D16, X20
    FMOV  V16.D[1], X10
    FMOV  D17, X12
    FMOV  V17.D[1], X26
    FMOV  D18, X14
    FMOV  V18.D[1], X3
    FMOV  D19, X25
    FMOV  V19.D[1], X22
    FMOV  D20, X3
    FMOV  V20.D[1], X28
    FMOV  D21, X7
    FMOV  V21.D[1], X24
    FMOV  D22, X23
    FMOV  V22.D[1], X6
    FMOV  D23, X20
    FMOV  V23.D[1], X18
    FMOV  D24, X26
    FMOV  V24.D[1], X6
    FMOV  D25, X3
    FMOV  V25.D[1], X12
    FMOV  D26, X15
    FMOV  V26.D[1], X17
    FMOV  D27, X17
    FMOV  V27.D[1], X13
    FMOV  D28, X26
    FMOV  V28.D[1], X9
    FMOV  D29, X13
    FMOV  V29.D[1], X3
    FMOV  D30, X10
    FMOV  V30.D[1], X14
    FMOV  D31, X9
    FMOV  V31.D[1], X24
    MOVZ  X22, #0xf, LSL #0
TSRTFloatMinMax_label_12:
    FMIN  D20, D21, D22
    FMAXNM  H26, H24, H20
    FMIN  H29, H30, H23
    FMAXNM  S27, S25, S27
    FMAXNM  S1, S28, S19
    FMAXNM  S27, S24, S1
    FMAXNM  D5, D31, D27
    FMAXNM  D11, D29, D26
    FMAXNM  D13, D11, D11
    FMAXNM  S22, S13, S13
    FMAX  H31, H5, H5
    FMAX  H28, H31, H22
    FMIN  H1, H3, H20
    FMAXNM  H11, H21, H2
    FMAX  H21, H18, H0
    FMIN  D19, D3, D19
    FMINNM  S30, S19, S12
    FMAX  S24, S20, S25
    FMINNM  D31, D29, D8
    FMAXNM  D22, D2, D25
    FMIN  H18, H17, H16
    FMAXNM  D19, D28, D18
    FMINNM  D8, D11, D1
    FMAX  H29, H21, H31
    FMIN  S28, S24, S22
    FMINNM  S0, S30, S30
    FMAXNM  D23, D29, D19
    FMAXNM  H24, H23, H28
    FMIN  S31, S0, S0
    FMIN  D3, D31, D24
    FMAXNM  D22, D8, D8
    FMAX  D11, D14, D22
    FMAX  S24, S3, S11
    FMAX  S31, S19, S8
    FMAX  S11, S16, S22
    FMAXNM  D28, D14, D26
    FMIN  S3, S7, S31
    FMIN  H25, H11, H6
    FMAX  S1, S3, S25
    FMAXNM  S19, S4, S11
    FMAXNM  S22, S10, S12
    FMINNM  S18, S11, S2
    FMAXNM  H30, H14, H9
    FMAXNM  S26, S3, S11
    FMIN  H9, H16, H6
    FMAXNM  D23, D1, D24
    FMAX  S12, S28, S9
    FMAX  H29, H19, H23
    FMIN  D25, D30, D29
    FMAX  D17, D26, D12
    FMINNM  S19, S17, S25
    FMINNM  D7, D22, D0
    FMAXNM  H2, H19, H18
    FMAXNM  D29, D7, D2
    FMAX  S17, S22, S11
    FMINNM  H1, H9, H23
    FMIN  D14, D9, D19
    FMAXNM  H23, H23, H20
    FMAX  D20, D12, D27
    FMIN  D18, D15, D30
    FMAXNM  H22, H29, H22
    FMAXNM  S27, S10, S25
    FMIN  D3, D17, D5
    FMAX  S5, S27, S19
    FMAXNM  H26, H9, H31
    FMAXNM  D11, D27, D1
    FMIN  S28, S5, S14
    FMIN  S2, S18, S23
    FMAXNM  S19, S26, S11
    FMINNM  D12, D28, D3
    FMINNM  S3, S22, S12
    FMIN  S6, S20, S3
    FMAXNM  H18, H19, H19
    FMIN  H7, H2, H6
    FMIN  S0, S18, S18
    FMIN  D24, D7, D7
    FMAXNM  D9, D0, D24
    FMAX  D18, D1, D21
    FMAXNM  D26, D29, D8
    FMAX  S31, S11, S14
    FMINNM  S8, S30, S17
    FMAXNM  S27, S20, S17
    FMAXNM  S25, S9, S26
    FMAX  S7, S31, S14
    FMAX  H14, H10, H13
    FMIN  H11, H5, H7
    FMINNM  H3, H2, H30
    FMIN  S15, S29, S16
    FMIN  H17, H18, H20
    FMINNM  H23, H26, H18
    FMIN  S21, S8, S3
    FMAX  D16, D15, D15
    FMIN  H20, H27, H27
    FMIN  S19, S17, S23
    FMAX  H31, H19, H25
    FMAX  D9, D20, D14
    FMAX  D1, D16, D9
    FMINNM  D30, D11, D21
    FMIN  H0, H31, H30
    FMINNM  H16, H0, H1
    FMAXNM  S0, S8, S12
    FMIN  D19, D30, D16
    FMIN  D25, D25, D7
    FMINNM  H23, H6, H23
    FMAX  H29, H21, H13
    FMINNM  S31, S3, S22
    FMINNM  D9, D20, D0
    FMAX  S8, S13, S24
    FMAXNM  D20, D18, D5
    FMIN  D13, D30, D6
    FMAXNM  D16, D31, D20
    FMAX  H15, H9, H29
    FMINNM  S30, S19, S15
    FMAXNM  H1, H29, H23
    FMIN  D12, D9, D1
    FMAX  D21, D13, D30
    FMAX  H0, H8, H16
    FMAX  S29, S25, S12
    FMINNM  D25, D29, D21
    FMAXNM  D3, D0, D25
    FMAX  D13, D18, D12
    FMAX  H8, H1, H1
    FMIN  D31, D2, D14
    FMAX  D25, D9, D5
    FMIN  D14, D11, D9
    FMIN  H21, H22, H5
    FMAXNM  D1, D28, D18
    FMAXNM  H6, H17, H10
    FMINNM  S28, S21, S25
    FMINNM  S15, S28, S1
    FMIN  S16, S3, S21
    FMAXNM  D0, D13, D16
    FMAX  S28, S0, S25
    FMINNM  S9, S14, S28
    FMAXNM  S1, S9, S15
    FMIN  H29, H31, H6
    FMAX  D17, D8, D1
    FMAX  D12, D29, D4
    FMAX  H5, H12, H17
    FMINNM  D16, D21, D23
    FMAXNM  S12, S13, S15
    FMAXNM  S19, S7, S1
    FMAX  H25, H21, H12
    FMINNM  S29, S0, S23
    FMAXNM  D9, D25, D17
    FMINNM  S28, S26, S8
    FMIN  H3, H27, H17
    FMIN  H10, H20, H17
    FMAX  S31, S27, S11
    FMAXNM  D4, D10, D3
    FMAX  S13, S28, S19
    FMAX  S6, S31, S16
    FMINNM  H31, H4, H9
    FMAXNM  S16, S26, S13
    FMINNM  S15, S6, S16
    FMAX  H1, H5, H31
    FMAX  D25, D1, D29
    FMIN  D7, D15, D15
    FMAXNM  H16, H16, H7
    FMAXNM  H21, H16, H16
    FMINNM  D8, D25, D25
    FMINNM  S7, S21, S8
    FMAXNM  S23, S25, S18
    FMIN  D14, D9, D28
    FMAX  H27, H31, H9
    FMIN  S13, S26, S5
    FMAX  S0, S16, S26
    FMAX  H12, H8, H18
    FMINNM  S3, S17, S24
    FMAX  S19, S12, S1
    FMAX  S5, S13, S10
    FMAX  H11, H6, H29
    FMAXNM  D20, D5, D14
    FMINNM  H29, H23, H3
    FMAX  S9, S0, S11
    FMINNM  S16, S19, S27
    FMAXNM  S3, S7, S20
    FMINNM  D12, D7, D3
    FMINNM  S27, S16, S12
    FMAX  D17, D29, D9
    FMAXNM  D3, D27, D27
    FMAX  H14, H17, H3
    FMAX  H16, H8, H9
    FMAXNM  S15, S26, S13
    FMAX  S18, S7, S5
    FMAXNM  H8, H20, H2
    FMINNM  H23, H18, H14
    FMAX  D24, D22, D18
    FMAX  H0, H1, H27
    FMAX  H21, H28, H4
    FMAX  D27, D0, D6
    FMAXNM  D7, D4, D26
    FMINNM  H26, H15, H25
    FMINNM  H3, H17, H27
    FMINNM  D14, D0, D15
    FMIN  D10, D23, D16
    FMIN  D18, D26, D10
    FMIN  S25, S21, S8
    FMAX  S5, S25, S3
    FMIN  H2, H5, H14
    SUBS  X22, X22, #0x1
    B.NE  TSRTFloatMinMax_label_12
    MOVZ  X26, #0xaf86, LSL #0
    MOVK  X26, #0x7879, LSL #16
    MOVK  X26, #0x2f61, LSL #32
    MOVK  X26, #0x7d2f, LSL #48
    SUB  X3, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x1ffb, LSL #0
    MOVK  X26, #0x482e, LSL #16
    MOVK  X26, #0x724d, LSL #32
    MOVK  X26, #0x2f84, LSL #48
    SUB  X3, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0xc95d, LSL #0
    MOVK  X26, #0x1cb5, LSL #16
    MOVK  X26, #0xf29c, LSL #32
    MOVK  X26, #0x31f2, LSL #48
    SUB  X3, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x531e, LSL #0
    MOVK  X26, #0x5c26, LSL #16
    MOVK  X26, #0x90ab, LSL #32
    MOVK  X26, #0x66bf, LSL #48
    SUB  X3, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x24cb, LSL #0
    MOVK  X26, #0x354, LSL #16
    MOVK  X26, #0x1932, LSL #32
    MOVK  X26, #0xb587, LSL #48
    SUB  X3, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x40b8, LSL #0
    MOVK  X26, #0x4578, LSL #16
    MOVK  X26, #0x6e93, LSL #32
    MOVK  X26, #0xe69f, LSL #48
    SUB  X3, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0xcc50, LSL #0
    MOVK  X26, #0xcf0b, LSL #16
    MOVK  X26, #0xb, LSL #32
    MOVK  X26, #0x122e, LSL #48
    SUB  X3, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x7804, LSL #0
    MOVK  X26, #0x8885, LSL #16
    MOVK  X26, #0xa60c, LSL #32
    MOVK  X26, #0xab77, LSL #48
    SUB  X3, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x6ede, LSL #0
    MOVK  X26, #0x4cdd, LSL #16
    MOVK  X26, #0xe263, LSL #32
    MOVK  X26, #0x5340, LSL #48
    SUB  X3, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x6a43, LSL #0
    MOVK  X26, #0x1a91, LSL #16
    MOVK  X26, #0x2c38, LSL #32
    MOVK  X26, #0x9e58, LSL #48
    SUB  X3, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x1254, LSL #0
    MOVK  X26, #0x6820, LSL #16
    MOVK  X26, #0xb354, LSL #32
    MOVK  X26, #0xa9de, LSL #48
    SUB  X3, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0xc1f4, LSL #0
    MOVK  X26, #0x4033, LSL #16
    MOVK  X26, #0x6714, LSL #32
    MOVK  X26, #0x8028, LSL #48
    SUB  X3, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0xd80c, LSL #0
    MOVK  X26, #0x62b5, LSL #16
    MOVK  X26, #0xa00c, LSL #32
    MOVK  X26, #0xab8d, LSL #48
    SUB  X3, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x9b8, LSL #0
    MOVK  X26, #0x915e, LSL #16
    MOVK  X26, #0xebb, LSL #32
    MOVK  X26, #0xffa7, LSL #48
    SUB  X3, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0xa2c3, LSL #0
    MOVK  X26, #0xb6e2, LSL #16
    MOVK  X26, #0xabbe, LSL #32
    MOVK  X26, #0x5433, LSL #48
    SUB  X3, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x5c66, LSL #0
    MOVK  X26, #0xaff, LSL #16
    MOVK  X26, #0x93af, LSL #32
    MOVK  X26, #0x9843, LSL #48
    SUB  X3, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x3560, LSL #0
    MOVK  X26, #0xb286, LSL #16
    MOVK  X26, #0xbe62, LSL #32
    MOVK  X26, #0xf845, LSL #48
    SUB  X3, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x81a1, LSL #0
    MOVK  X26, #0xa0f3, LSL #16
    MOVK  X26, #0x39f4, LSL #32
    MOVK  X26, #0x2dbe, LSL #48
    SUB  X3, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0xdccf, LSL #0
    MOVK  X26, #0x3da4, LSL #16
    MOVK  X26, #0xfe4a, LSL #32
    MOVK  X26, #0x3e9c, LSL #48
    SUB  X3, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0xffb5, LSL #0
    MOVK  X26, #0xbe75, LSL #16
    MOVK  X26, #0x32c8, LSL #32
    MOVK  X26, #0xc758, LSL #48
    SUB  X3, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x81, LSL #0
    MRS  X3, FPSR
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D1
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D2
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D3
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D5
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D7
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D8
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D9
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D11
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D12
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D15
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D16
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D18
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D19
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D20
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D21
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D22
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D24
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D25
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D26
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D27
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D28
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D29
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D30
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X3, D31
    SUB  X18, X26, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X14
    FMOV  V0.D[1], X26
    FMOV  D1, X17
    FMOV  V1.D[1], X25
    FMOV  D2, X16
    FMOV  V2.D[1], X23
    FMOV  D3, X28
    FMOV  V3.D[1], X20
    FMOV  D4, X18
    FMOV  V4.D[1], X22
    FMOV  D5, X29
    FMOV  V5.D[1], X21
    FMOV  D6, X24
    FMOV  V6.D[1], X14
    FMOV  D7, X18
    FMOV  V7.D[1], X13
    FMOV  D8, X3
    FMOV  V8.D[1], X20
    FMOV  D9, X15
    FMOV  V9.D[1], X17
    FMOV  D10, X12
    FMOV  V10.D[1], X8
    FMOV  D11, X26
    FMOV  V11.D[1], X18
    FMOV  D12, X5
    FMOV  V12.D[1], X6
    FMOV  D13, X10
    FMOV  V13.D[1], X15
    FMOV  D14, X17
    FMOV  V14.D[1], X7
    FMOV  D15, X8
    FMOV  V15.D[1], X10
    FMOV  D16, X12
    FMOV  V16.D[1], X29
    FMOV  D17, X29
    FMOV  V17.D[1], X23
    FMOV  D18, X10
    FMOV  V18.D[1], X25
    FMOV  D19, X8
    FMOV  V19.D[1], X22
    FMOV  D20, X25
    FMOV  V20.D[1], X16
    FMOV  D21, X9
    FMOV  V21.D[1], X17
    FMOV  D22, X13
    FMOV  V22.D[1], X10
    FMOV  D23, X5
    FMOV  V23.D[1], X29
    FMOV  D24, X25
    FMOV  V24.D[1], X24
    FMOV  D25, X9
    FMOV  V25.D[1], X23
    FMOV  D26, X9
    FMOV  V26.D[1], X17
    FMOV  D27, X16
    FMOV  V27.D[1], X9
    FMOV  D28, X25
    FMOV  V28.D[1], X21
    FMOV  D29, X6
    FMOV  V29.D[1], X25
    FMOV  D30, X13
    FMOV  V30.D[1], X29
    FMOV  D31, X12
    FMOV  V31.D[1], X20
    MOVZ  X14, #0xf, LSL #0
TSRTFloatMinMax_label_13:
    FMAXNM  S8, S25, S17
    FMINNM  S4, S27, S28
    FMINNM  H14, H30, H22
    FMINNM  H10, H14, H14
    FMINNM  D6, D31, D24
    FMAX  H23, H8, H6
    FMAX  S16, S23, S4
    FMAXNM  H0, H29, H26
    FMIN  D29, D0, D10
    FMINNM  S10, S16, S16
    FMINNM  S25, S29, S10
    FMAX  S31, S16, S26
    FMINNM  S16, S16, S23
    FMIN  S22, S29, S2
    FMINNM  S4, S12, S5
    FMIN  H17, H27, H29
    FMINNM  H0, H7, H2
    FMINNM  S6, S31, S26
    FMINNM  D8, D8, D30
    FMIN  D10, D7, D4
    FMINNM  D31, D28, D14
    FMAX  D30, D22, D27
    FMAX  S27, S30, S8
    FMINNM  D29, D16, D31
    FMAXNM  H28, H25, H27
    FMAX  H27, H17, H6
    FMAXNM  D17, D27, D29
    FMAXNM  S5, S28, S10
    FMINNM  S12, S0, S26
    FMAX  S23, S12, S17
    FMAXNM  D2, D23, D23
    FMAXNM  D30, D5, D5
    FMINNM  D31, D2, D2
    FMINNM  S7, S8, S30
    FMAX  H27, H31, H7
    FMIN  D22, D28, D31
    FMIN  H4, H16, H24
    FMIN  S16, S22, S20
    FMINNM  H14, H18, H7
    FMAXNM  S25, S15, S3
    FMIN  D0, D24, D20
    FMIN  D28, D11, D0
    FMIN  S17, S12, S4
    FMINNM  D7, D21, D27
    FMAX  S25, S16, S24
    FMAX  D11, D17, D16
    FMINNM  S21, S22, S5
    FMAXNM  H29, H29, H15
    FMINNM  D31, D2, D19
    FMIN  H24, H23, H8
    FMINNM  D12, D14, D12
    FMAX  S5, S24, S12
    FMAX  S4, S31, S21
    FMAXNM  S18, S14, S28
    FMINNM  D16, D7, D29
    FMIN  S8, S25, S11
    FMAX  S12, S5, S8
    FMAX  D17, D11, D4
    FMIN  H23, H17, H16
    FMINNM  D30, D12, D23
    FMAX  S3, S30, S18
    FMIN  D30, D16, D31
    FMAX  D20, D4, D5
    FMAXNM  H18, H28, H30
    FMAXNM  D27, D26, D3
    FMAXNM  H21, H29, H17
    FMAXNM  S15, S4, S20
    FMAX  S24, S12, S6
    FMINNM  H0, H12, H2
    FMIN  S22, S7, S27
    FMINNM  D11, D18, D4
    FMIN  S19, S9, S25
    FMINNM  D8, D14, D13
    FMINNM  H6, H16, H1
    FMINNM  D12, D0, D0
    FMAX  H18, H22, H24
    FMAXNM  H20, H11, H11
    FMAX  S29, S20, S8
    FMAX  H20, H15, H17
    FMIN  H11, H21, H6
    FMIN  H7, H11, H18
    FMAXNM  H30, H19, H29
    FMAX  S17, S30, S30
    FMAXNM  S28, S17, S11
    FMINNM  S29, S25, S24
    FMAXNM  H6, H28, H20
    FMAX  H4, H12, H7
    FMAXNM  H22, H4, H4
    FMINNM  D18, D29, D29
    FMINNM  H7, H18, H6
    FMAX  H29, H22, H22
    FMIN  D8, D31, D29
    FMAX  D2, D7, D7
    FMINNM  H28, H8, H8
    FMAX  S15, S28, S2
    FMIN  D2, D26, D21
    FMAXNM  S22, S11, S13
    FMAX  D11, D11, D8
    FMINNM  H24, H4, H21
    FMINNM  D26, D2, D26
    FMINNM  H16, H1, H27
    FMINNM  D31, D3, D13
    FMIN  D29, D19, D4
    FMIN  D8, D0, D3
    FMAXNM  S13, S15, S24
    FMAX  S1, S16, S27
    FMINNM  S0, S22, S8
    FMINNM  H18, H3, H0
    FMAXNM  D7, D18, D18
    FMIN  S28, S19, S7
    FMAXNM  H6, H11, H31
    FMAXNM  D31, D6, D26
    FMAXNM  H17, H1, H28
    FMAX  D2, D29, D29
    FMAXNM  D1, D17, D2
    FMAX  D29, D31, D31
    FMAX  H18, H24, H1
    FMINNM  D27, D13, D18
    FMIN  D7, D27, D29
    FMAX  H13, H23, H31
    FMAXNM  H15, H25, H1
    FMAX  D11, D24, D19
    FMIN  S26, S21, S2
    FMINNM  S22, S26, S17
    FMAXNM  H4, H1, H19
    FMAXNM  D6, D1, D6
    FMAX  D21, D26, D18
    FMINNM  D19, D4, D8
    FMAX  S27, S30, S8
    FMAXNM  D31, D13, D7
    FMINNM  S26, S15, S21
    FMIN  D16, D6, D22
    FMIN  H3, H16, H11
    FMAX  S1, S3, S27
    FMAXNM  S25, S1, S1
    FMAX  H29, H19, H19
    FMIN  S15, S25, S26
    FMAXNM  S19, S29, S15
    FMIN  D28, D13, D31
    FMINNM  D17, D19, D28
    FMIN  S28, S27, S12
    FMIN  H25, H14, H15
    FMIN  D6, D23, D9
    FMINNM  D16, D18, D24
    FMAXNM  D2, D20, D19
    FMAXNM  H29, H16, H7
    FMIN  D20, D23, D8
    FMAXNM  S14, S8, S27
    FMAXNM  D31, D7, D27
    FMAX  D26, D31, D20
    FMAXNM  H31, H26, H9
    FMAXNM  D27, D27, D31
    FMINNM  S19, S15, S14
    FMAX  H1, H25, H19
    FMINNM  D4, D1, D27
    FMIN  S19, S29, S29
    FMINNM  S14, S26, S4
    FMAXNM  S31, S6, S19
    FMAX  S29, S2, S2
    FMIN  S16, S14, S5
    FMINNM  H24, H28, H16
    FMAX  H18, H31, H17
    FMINNM  H19, H17, H18
    FMINNM  S13, S24, S19
    FMINNM  D12, D29, D13
    FMINNM  D9, D9, D10
    FMIN  S13, S5, S3
    FMAX  D3, D20, D8
    FMAX  H19, H30, H31
    FMIN  D23, D16, D18
    FMAX  H4, H6, H20
    FMAX  D25, D10, D0
    FMAX  D6, D25, D14
    FMAX  S26, S1, S23
    FMIN  S18, S26, S27
    FMIN  D24, D30, D9
    FMAX  D2, D19, D29
    FMIN  S8, S14, S24
    FMAXNM  S17, S5, S20
    FMINNM  D31, D9, D4
    FMAX  S15, S31, S12
    FMAX  H19, H29, H15
    FMAXNM  D5, D17, D8
    FMIN  D31, D2, D6
    FMINNM  S16, S3, S18
    FMIN  S4, S18, S13
    FMINNM  S24, S4, S19
    FMAXNM  D28, D16, D16
    FMIN  H16, H5, H31
    FMAX  S16, S16, S24
    FMAXNM  D18, D28, D16
    FMAXNM  D12, D22, D10
    FMIN  D25, D2, D5
    FMAX  S19, S30, S6
    FMAX  D0, D13, D31
    FMAXNM  H13, H26, H5
    FMINNM  S27, S4, S4
    FMAX  D20, D4, D19
    FMIN  S17, S1, S26
    FMAX  D16, D3, D5
    SUBS  X14, X14, #0x1
    B.NE  TSRTFloatMinMax_label_13
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x81, LSL #0
    MRS  X22, FPSR
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D0
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V1.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D1
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D2
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D3
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D4
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D5
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D6
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D7
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D8
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D9
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D10
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D11
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D12
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D13
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V14.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D14
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D15
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D16
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D17
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D18
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D20
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D21
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D22
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D23
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D25
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D26
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D27
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D28
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D29
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D30
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D31
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X18
    FMOV  D3, X22
    FMOV  V3.D[1], X26
    FMOV  D4, X21
    FMOV  V4.D[1], X6
    FMOV  D5, X15
    FMOV  V5.D[1], X6
    FMOV  D6, X22
    FMOV  V6.D[1], X8
    FMOV  D7, X6
    FMOV  V7.D[1], X26
    FMOV  D8, X28
    FMOV  V8.D[1], X26
    FMOV  D9, X15
    FMOV  V9.D[1], X7
    FMOV  D10, X23
    FMOV  V10.D[1], X13
    FMOV  D11, X17
    FMOV  V11.D[1], X10
    FMOV  D12, X21
    FMOV  V12.D[1], X10
    FMOV  D13, X24
    FMOV  V13.D[1], X26
    FMOV  D14, X14
    FMOV  V14.D[1], X13
    FMOV  D15, X6
    FMOV  V15.D[1], X12
    FMOV  D16, X5
    FMOV  V16.D[1], X24
    FMOV  D17, X20
    FMOV  V17.D[1], X25
    FMOV  D18, X14
    FMOV  V18.D[1], X15
    FMOV  D19, X14
    FMOV  V19.D[1], X14
    FMOV  D20, X22
    FMOV  V20.D[1], X4
    FMOV  D21, X14
    FMOV  V21.D[1], X18
    FMOV  D22, X4
    FMOV  V22.D[1], X13
    FMOV  D23, X9
    FMOV  V23.D[1], X8
    FMOV  D24, X5
    FMOV  V24.D[1], X29
    FMOV  D25, X18
    FMOV  V25.D[1], X12
    FMOV  D26, X25
    FMOV  V26.D[1], X21
    FMOV  D27, X3
    FMOV  V27.D[1], X5
    FMOV  D28, X3
    FMOV  V28.D[1], X13
    FMOV  D29, X21
    FMOV  V29.D[1], X15
    FMOV  D30, X8
    FMOV  V30.D[1], X28
    FMOV  D31, X13
    FMOV  V31.D[1], X28
    MOVZ  X28, #0xf, LSL #0
TSRTFloatMinMax_label_14:
    FMAX  S21, S21, S21
    FMINNM  H23, H23, H26
    FMAXNM  S28, S21, S28
    FMINNM  S0, S27, S30
    FMAX  D7, D29, D29
    FMINNM  S2, S22, S0
    FMINNM  H25, H25, H28
    FMINNM  D28, D25, D23
    FMAX  D9, D28, D28
    FMINNM  H20, H24, H24
    FMAXNM  D8, D31, D7
    FMIN  D13, D2, D9
    FMIN  S21, S13, S20
    FMIN  S13, S8, S21
    FMAXNM  D2, D22, D15
    FMINNM  D21, D16, D31
    FMINNM  H20, H26, H1
    FMAXNM  S24, S23, S11
    FMINNM  D25, D16, D15
    FMINNM  S23, S19, S25
    FMAXNM  S26, S25, S24
    FMAXNM  H0, H6, H27
    FMAXNM  H7, H25, H22
    FMINNM  H1, H8, H18
    FMAX  S22, S7, S1
    FMIN  D7, D8, D23
    FMAXNM  S9, S22, S7
    FMAX  D31, D13, D20
    FMINNM  D28, D31, D26
    FMAXNM  H20, H0, H2
    FMAXNM  D27, D9, D21
    FMAXNM  S25, S20, S28
    FMIN  D26, D25, D27
    FMINNM  D11, D18, D19
    FMAX  D15, D26, D19
    FMIN  S27, S17, S10
    FMINNM  S2, S25, S1
    FMIN  H21, H31, H13
    FMINNM  S8, S7, S7
    FMIN  H26, H28, H3
    FMAXNM  H7, H23, H7
    FMAXNM  D31, D6, D5
    FMAXNM  H6, H21, H7
    FMAXNM  H20, H31, H2
    FMIN  H5, H11, H10
    FMAXNM  H1, H8, H15
    FMINNM  H24, H6, H6
    FMAXNM  H9, H20, H1
    FMAX  H23, H1, H27
    FMINNM  D7, D26, D9
    FMINNM  H20, H5, H5
    FMAXNM  S21, S10, S20
    FMINNM  H17, H24, H24
    FMIN  H20, H21, H21
    FMIN  S25, S23, S17
    FMIN  D3, D7, D6
    FMAX  D17, D20, D20
    FMAXNM  H11, H3, H17
    FMINNM  D15, D25, D25
    FMAX  D5, D11, D11
    FMIN  H9, H5, H15
    FMINNM  D31, D25, D26
    FMINNM  S25, S10, S21
    FMAXNM  H20, H22, H21
    FMAX  S7, S6, S11
    FMINNM  H5, H12, H26
    FMAXNM  D24, D7, D23
    FMAXNM  H3, H13, H9
    FMAX  D13, D24, D10
    FMAXNM  D24, D17, D12
    FMIN  S15, S27, S15
    FMIN  S10, S9, S20
    FMAXNM  S22, S13, S12
    FMIN  D13, D20, D2
    FMAX  H17, H22, H5
    FMINNM  S20, S24, S15
    FMINNM  H15, H25, H10
    FMINNM  H1, H31, H3
    FMINNM  S10, S15, S27
    FMINNM  D15, D13, D17
    FMINNM  S23, S1, S20
    FMAXNM  H4, H15, H23
    FMINNM  S4, S4, S4
    FMAX  D16, D10, D21
    FMAXNM  S21, S4, S16
    FMAXNM  H22, H28, H6
    FMAXNM  H3, H27, H28
    FMAX  S24, S17, S25
    FMAX  D1, D30, D0
    FMIN  D7, D19, D21
    FMAXNM  D15, D22, D24
    FMAXNM  H5, H4, H24
    FMAXNM  D22, D4, D28
    FMINNM  D6, D22, D29
    FMINNM  H23, H20, H22
    FMINNM  S10, S14, S28
    FMAX  H25, H22, H2
    FMAXNM  H9, H1, H7
    FMIN  S0, S15, S3
    FMINNM  S2, S5, S18
    FMAX  H18, H6, H23
    FMINNM  S7, S10, S25
    FMAXNM  H15, H9, H2
    FMAX  D1, D0, D15
    FMAXNM  D30, D18, D18
    FMAXNM  H2, H30, H30
    FMIN  S29, S7, S2
    FMIN  H25, H29, H1
    FMINNM  S28, S29, S22
    FMINNM  S1, S4, S31
    FMAX  D18, D19, D21
    FMAXNM  S22, S21, S26
    FMINNM  H20, H7, H21
    FMAX  H3, H3, H0
    FMINNM  H19, H2, H28
    FMAX  D23, D28, D10
    FMAX  D4, D10, D9
    FMAX  D15, D4, D4
    FMAX  S5, S18, S23
    FMINNM  H4, H22, H25
    FMIN  D7, D1, D3
    FMAX  S10, S20, S5
    FMAXNM  S6, S10, S19
    FMINNM  D28, D15, D10
    FMAX  D29, D6, D6
    FMIN  D5, D28, D29
    FMINNM  D25, D5, D5
    FMIN  S23, S4, S25
    FMAX  D5, D23, D7
    FMINNM  S0, S4, S23
    FMIN  H25, H10, H16
    FMINNM  S30, S14, S2
    FMIN  H29, H27, H4
    FMAX  D16, D29, D17
    FMINNM  D9, D3, D31
    FMINNM  D28, D29, D20
    FMIN  D20, D11, D4
    FMAX  D31, D10, D2
    FMAXNM  D6, D31, D26
    FMIN  H3, H16, H30
    FMINNM  S1, S3, S9
    FMAXNM  D29, D27, D28
    FMAXNM  H15, H5, H25
    FMAX  S7, S1, S29
    FMIN  H29, H15, H6
    FMAX  S4, S20, S0
    FMIN  H22, H28, H7
    FMAXNM  S30, S4, S4
    FMAX  D0, D29, D30
    FMINNM  D16, D0, D0
    FMINNM  H17, H16, H16
    FMAXNM  D20, D17, D22
    FMIN  H9, H24, H6
    FMAX  H3, H25, H10
    FMIN  H31, H30, H8
    FMAXNM  H10, H18, H3
    FMIN  H0, H10, H13
    FMINNM  D5, D12, D24
    FMAX  S16, S24, S0
    FMAX  D3, D29, D26
    FMAXNM  D2, D12, D29
    FMAX  S1, S15, S31
    FMAX  S29, S6, S5
    FMIN  H5, H4, H14
    FMINNM  D24, D14, D12
    FMAXNM  H22, H20, H8
    FMIN  S20, S22, S16
    FMAX  H26, H24, H9
    FMIN  S13, S26, S3
    FMAX  S30, S5, S29
    FMINNM  S31, S20, S2
    FMAX  H28, H24, H0
    FMAXNM  S4, S1, S28
    FMINNM  D15, D13, D30
    FMAXNM  S6, S31, S15
    FMINNM  S8, S4, S7
    FMINNM  H14, H6, H6
    FMIN  D0, D8, D8
    FMAX  D22, D27, D0
    FMINNM  D12, D14, D14
    FMAXNM  H2, H12, H12
    FMAX  H16, H7, H2
    FMINNM  S28, S14, S22
    FMAXNM  D31, D16, D28
    FMIN  S14, S18, S31
    FMAXNM  S28, S13, S13
    FMAX  D29, D10, D19
    FMIN  D16, D8, D12
    FMIN  H30, H18, H7
    FMIN  S7, S3, S1
    FMIN  S15, S16, S13
    FMIN  D31, D24, D29
    FMAXNM  H4, H16, H2
    FMAXNM  S6, S23, S27
    FMAX  D23, D15, D17
    FMAX  D0, D29, D18
    FMAXNM  S18, S7, S31
    FMINNM  D20, D28, D4
    FMIN  S15, S23, S6
    FMAXNM  H22, H0, H18
    SUBS  X28, X28, #0x1
    B.NE  TSRTFloatMinMax_label_14
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X18, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x81, LSL #0
    MRS  X18, FPSR
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D0
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D1
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D2
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D3
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D4
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D5
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D6
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D7
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D8
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D9
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D10
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D11
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D12
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D13
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D14
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D15
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D16
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D17
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D18
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D19
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D20
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D21
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D22
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D23
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D24
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D25
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D26
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D27
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D28
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D29
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D30
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, D31
    SUB  X23, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x80a7, LSL #0
    MOVK  X3, #0xfcb4, LSL #16
    MOVK  X3, #0x5945, LSL #32
    MOVK  X3, #0x54b2, LSL #48
    MOVZ  X4, #0x87a8, LSL #0
    MOVK  X4, #0xb34e, LSL #16
    MOVK  X4, #0xa373, LSL #32
    MOVK  X4, #0x2d57, LSL #48
    MOVZ  X5, #0xef9, LSL #0
    MOVK  X5, #0xf384, LSL #16
    MOVK  X5, #0x8db1, LSL #32
    MOVK  X5, #0x17f6, LSL #48
    MOVZ  X6, #0xd4a1, LSL #0
    MOVK  X6, #0xe16, LSL #16
    MOVK  X6, #0xf9aa, LSL #32
    MOVK  X6, #0x6511, LSL #48
    MOVZ  X7, #0xe8cd, LSL #0
    MOVK  X7, #0xcd1b, LSL #16
    MOVK  X7, #0x6011, LSL #32
    MOVK  X7, #0xa359, LSL #48
    MOVZ  X8, #0x64b8, LSL #0
    MOVK  X8, #0x83dc, LSL #16
    MOVK  X8, #0x421d, LSL #32
    MOVK  X8, #0x748b, LSL #48
    MOVZ  X9, #0x2ac0, LSL #0
    MOVK  X9, #0xe4ed, LSL #16
    MOVK  X9, #0x4acb, LSL #32
    MOVK  X9, #0x4fd8, LSL #48
    MOVZ  X10, #0xe343, LSL #0
    MOVK  X10, #0x3cf1, LSL #16
    MOVK  X10, #0x6d11, LSL #32
    MOVK  X10, #0xa63, LSL #48
    MOVZ  X12, #0x468d, LSL #0
    MOVK  X12, #0x7ee1, LSL #16
    MOVK  X12, #0x8832, LSL #32
    MOVK  X12, #0xfb9d, LSL #48
    MOVZ  X13, #0xe40a, LSL #0
    MOVK  X13, #0xaf8a, LSL #16
    MOVK  X13, #0xef8, LSL #32
    MOVK  X13, #0xb2b, LSL #48
    MOVZ  X14, #0x2598, LSL #0
    MOVK  X14, #0x3141, LSL #16
    MOVK  X14, #0xb64, LSL #32
    MOVK  X14, #0x3582, LSL #48
    MOVZ  X15, #0xa7e3, LSL #0
    MOVK  X15, #0x4c2c, LSL #16
    MOVK  X15, #0xf9b1, LSL #32
    MOVK  X15, #0x7674, LSL #48
    MOVZ  X16, #0x6fed, LSL #0
    MOVK  X16, #0xba1f, LSL #16
    MOVK  X16, #0x4336, LSL #32
    MOVK  X16, #0xdef9, LSL #48
    MOVZ  X17, #0x272f, LSL #0
    MOVK  X17, #0xa24a, LSL #16
    MOVK  X17, #0xa509, LSL #32
    MOVK  X17, #0xb54d, LSL #48
    MOVZ  X18, #0x738, LSL #0
    MOVK  X18, #0x6192, LSL #16
    MOVK  X18, #0xf2b1, LSL #32
    MOVK  X18, #0xbb3f, LSL #48
    MOVZ  X20, #0xcb39, LSL #0
    MOVK  X20, #0x1bc, LSL #16
    MOVK  X20, #0x4d6, LSL #32
    MOVK  X20, #0x6dad, LSL #48
    MOVZ  X21, #0xba07, LSL #0
    MOVK  X21, #0x73a, LSL #16
    MOVK  X21, #0xde09, LSL #32
    MOVK  X21, #0x95a5, LSL #48
    MOVZ  X22, #0x52fc, LSL #0
    MOVK  X22, #0xfc2d, LSL #16
    MOVK  X22, #0xe37f, LSL #32
    MOVK  X22, #0x22ef, LSL #48
    MOVZ  X23, #0xbf4c, LSL #0
    MOVK  X23, #0x3aac, LSL #16
    MOVK  X23, #0x3955, LSL #32
    MOVK  X23, #0x94a9, LSL #48
    MOVZ  X24, #0x1eed, LSL #0
    MOVK  X24, #0x7e64, LSL #16
    MOVK  X24, #0xbd70, LSL #32
    MOVK  X24, #0x918f, LSL #48
    MOVZ  X25, #0x5d54, LSL #0
    MOVK  X25, #0xf938, LSL #16
    MOVK  X25, #0x9dcc, LSL #32
    MOVK  X25, #0x1a49, LSL #48
    MOVZ  X26, #0xe30f, LSL #0
    MOVK  X26, #0x5629, LSL #16
    MOVK  X26, #0x38b3, LSL #32
    MOVK  X26, #0x4467, LSL #48
    MOVZ  X28, #0x7de4, LSL #0
    MOVK  X28, #0x421b, LSL #16
    MOVK  X28, #0x99cd, LSL #32
    MOVK  X28, #0x113a, LSL #48
    MOVZ  X29, #0x44c3, LSL #0
    MOVK  X29, #0x97a1, LSL #16
    MOVK  X29, #0xf201, LSL #32
    MOVK  X29, #0xbabf, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X22
    FMOV  D3, X3
    FMOV  V3.D[1], X21
    FMOV  D4, X6
    FMOV  V4.D[1], X29
    FMOV  D5, X29
    FMOV  V5.D[1], X13
    FMOV  D6, X21
    FMOV  V6.D[1], X14
    FMOV  D7, X20
    FMOV  V7.D[1], X10
    FMOV  D8, X28
    FMOV  V8.D[1], X9
    FMOV  D9, X14
    FMOV  V9.D[1], X21
    FMOV  D10, X15
    FMOV  V10.D[1], X28
    FMOV  D11, X24
    FMOV  V11.D[1], X29
    FMOV  D12, X25
    FMOV  V12.D[1], X25
    FMOV  D13, X23
    FMOV  V13.D[1], X21
    FMOV  D14, X29
    FMOV  V14.D[1], X24
    FMOV  D15, X29
    FMOV  V15.D[1], X26
    FMOV  D16, X22
    FMOV  V16.D[1], X14
    FMOV  D17, X7
    FMOV  V17.D[1], X13
    FMOV  D18, X18
    FMOV  V18.D[1], X20
    FMOV  D19, X29
    FMOV  V19.D[1], X20
    FMOV  D20, X18
    FMOV  V20.D[1], X15
    FMOV  D21, X13
    FMOV  V21.D[1], X14
    FMOV  D22, X20
    FMOV  V22.D[1], X10
    FMOV  D23, X24
    FMOV  V23.D[1], X16
    FMOV  D24, X13
    FMOV  V24.D[1], X8
    FMOV  D25, X3
    FMOV  V25.D[1], X25
    FMOV  D26, X14
    FMOV  V26.D[1], X9
    FMOV  D27, X3
    FMOV  V27.D[1], X9
    FMOV  D28, X28
    FMOV  V28.D[1], X13
    FMOV  D29, X25
    FMOV  V29.D[1], X6
    FMOV  D30, X6
    FMOV  V30.D[1], X14
    FMOV  D31, X16
    FMOV  V31.D[1], X15
    MOVZ  X16, #0xf, LSL #0
TSRTFloatMinMax_label_15:
    FMIN  S3, S25, S24
    FMAX  H5, H28, H23
    FMINNM  D31, D3, D29
    FMIN  H6, H30, H5
    FMINNM  D16, D20, D27
    FMIN  S14, S26, S6
    FMAX  H31, H14, H31
    FMAXNM  S22, S21, S16
    FMAXNM  H24, H31, H31
    FMAX  H31, H29, H22
    FMIN  D3, D31, D24
    FMIN  D25, D3, D25
    FMAXNM  S30, S30, S21
    FMIN  S21, S29, S11
    FMAXNM  H22, H30, H25
    FMAX  D23, D13, D30
    FMINNM  D28, D23, D12
    FMAX  S12, S14, S31
    FMIN  H29, H13, H8
    FMIN  H16, H1, H2
    FMINNM  D30, D19, D31
    FMAXNM  D27, D23, D5
    FMINNM  H23, H1, H27
    FMINNM  D14, D9, D0
    FMAXNM  H19, H12, H12
    FMINNM  D9, D15, D28
    FMAX  H24, H9, H29
    FMINNM  S5, S24, S30
    FMAXNM  S28, S5, S23
    FMAXNM  S12, S27, S14
    FMAXNM  H13, H19, H21
    FMIN  D21, D13, D28
    FMAXNM  S20, S12, S22
    FMINNM  D30, D20, D21
    FMIN  S19, S16, S16
    FMAX  H8, H30, H30
    FMAX  D23, D3, D8
    FMAXNM  D8, D19, D19
    FMAX  H16, H23, H23
    FMAX  H19, H8, H16
    FMINNM  H14, H26, H6
    FMIN  D5, D29, D9
    FMINNM  H2, H14, H15
    FMINNM  H22, H26, H22
    FMAXNM  S26, S12, S24
    FMIN  H27, H10, H6
    FMAX  H28, H5, H21
    FMIN  H14, H31, H10
    FMAX  H29, H23, H25
    FMAXNM  S12, S26, S15
    FMINNM  S30, S6, S20
    FMIN  D9, D30, D30
    FMAXNM  D30, D12, D29
    FMIN  S16, S30, S9
    FMAX  S9, S19, S27
    FMAX  S21, S14, S9
    FMINNM  H23, H22, H22
    FMINNM  H8, H28, H21
    FMIN  D20, D16, D8
    FMAXNM  S27, S2, S20
    FMAXNM  D9, D23, D27
    FMAX  H21, H30, H11
    FMAX  S3, S9, S31
    FMIN  S8, S18, S5
    FMIN  S18, S15, S3
    FMINNM  H25, H30, H28
    FMAXNM  D12, D28, D20
    FMIN  D5, D24, D6
    FMAXNM  S20, S7, S30
    FMAX  H22, H7, H10
    FMINNM  D27, D21, D14
    FMAXNM  D15, D20, D26
    FMAXNM  H3, H6, H3
    FMAX  D29, D8, D3
    FMAX  H8, H18, H6
    FMAXNM  S18, S22, S29
    FMAXNM  H3, H25, H12
    FMINNM  D20, D5, D8
    FMIN  H6, H27, H3
    FMAX  S25, S15, S6
    FMINNM  S21, S25, S18
    FMINNM  S6, S20, S21
    FMAXNM  S26, S27, S13
    FMINNM  D24, D21, D26
    FMINNM  S10, S26, S10
    FMAXNM  S28, S6, S17
    FMINNM  D20, D12, D5
    FMINNM  S30, S15, S18
    FMINNM  H16, H14, H2
    FMAX  S7, S22, S29
    FMAXNM  H8, H21, H27
    FMAX  S17, S21, S3
    FMAX  S15, S17, S7
    FMAXNM  S25, S8, S1
    FMAXNM  S22, S25, S10
    FMIN  D2, D20, D7
    FMAXNM  H7, H2, H22
    FMINNM  D26, D15, D30
    FMAX  D27, D24, D28
    FMIN  S15, S12, S27
    FMAXNM  D8, D7, D16
    FMAX  H14, H2, H8
    FMAXNM  H24, H14, H14
    FMIN  D2, D26, D15
    FMIN  D25, D2, D2
    FMAXNM  S18, S25, S25
    FMINNM  H10, H24, H24
    FMAX  D30, D10, D10
    FMAX  D26, D0, D9
    FMAX  H28, H26, H18
    FMAX  H29, H28, H3
    FMAXNM  S6, S29, S30
    FMIN  H5, H23, H0
    FMAXNM  S10, S23, S3
    FMAX  D8, D24, D31
    FMIN  D14, D10, D28
    FMAXNM  D9, D25, D30
    FMINNM  D7, D17, D15
    FMAXNM  H2, H24, H5
    FMAXNM  S12, S7, S16
    FMAXNM  S7, S22, S30
    FMINNM  S25, S28, S31
    FMAX  D10, D8, D9
    FMIN  S24, S22, S26
    FMAX  S26, S18, S30
    FMAXNM  S16, S7, S14
    FMAXNM  H27, H25, H12
    FMAXNM  H28, H26, H6
    FMAX  H26, H28, H10
    FMINNM  S0, S26, S16
    FMIN  H26, H24, H2
    FMAXNM  H25, H27, H0
    FMIN  S12, S26, S26
    FMINNM  D6, D25, D12
    FMAX  D30, D19, D9
    FMIN  S28, S24, S14
    FMAXNM  S18, S1, S1
    FMIN  D3, D19, D17
    FMAXNM  D25, D24, D11
    FMIN  D0, D1, D18
    FMAXNM  D1, D11, D31
    FMIN  H19, H21, H11
    FMINNM  D2, D1, D3
    FMAX  H21, H16, H27
    FMAX  S26, S11, S31
    FMIN  D3, D19, D2
    FMAXNM  H10, H3, H26
    FMINNM  S14, S19, S21
    FMIN  D27, D6, D14
    FMAXNM  D9, D0, D30
    FMAXNM  S30, S27, S9
    FMAX  H2, H25, H10
    FMAXNM  H0, H28, H26
    FMAXNM  D31, D0, D30
    FMIN  H24, H2, H31
    FMAX  D28, D6, D6
    FMIN  D18, D19, D9
    FMAX  H3, H16, H27
    FMAXNM  D6, D15, D9
    FMINNM  S10, S22, S17
    FMIN  H30, H29, H23
    FMAXNM  H0, H28, H19
    FMAXNM  D9, D2, D11
    FMIN  S22, S12, S23
    FMAXNM  S23, S3, S22
    FMIN  S26, S23, S7
    FMAXNM  D17, D24, D10
    FMINNM  H31, H26, H17
    FMAX  H15, H18, H18
    FMIN  S14, S30, S0
    FMINNM  S0, S31, S6
    FMAX  S21, S14, S9
    FMAXNM  S23, S15, S15
    FMAX  D25, D21, D23
    FMAX  S7, S19, S0
    FMINNM  D18, D7, D25
    FMINNM  H17, H6, H23
    FMAX  S23, S5, S17
    FMAX  H27, H9, H30
    FMIN  D31, D9, D5
    FMIN  H7, H12, H17
    FMAXNM  S26, S8, S24
    FMAXNM  D9, D12, D13
    FMAXNM  S25, S9, S4
    FMINNM  S9, S20, S22
    FMIN  D30, D20, D4
    FMAXNM  H17, H11, H31
    FMAXNM  D22, D25, D23
    FMAX  D0, D18, D27
    FMIN  S19, S30, S7
    FMIN  D5, D26, D0
    FMIN  S8, S9, S19
    FMIN  S15, S5, S17
    FMAXNM  S7, S15, S15
    FMAX  H24, H22, H8
    FMAXNM  S25, S24, S7
    FMIN  D23, D21, D21
    FMIN  H31, H28, H1
    FMIN  H30, H3, H4
    FMIN  D4, D23, D7
    SUBS  X16, X16, #0x1
    B.NE  TSRTFloatMinMax_label_15
    MOVZ  X5, #0x80a7, LSL #0
    MOVK  X5, #0xfcb4, LSL #16
    MOVK  X5, #0x5945, LSL #32
    MOVK  X5, #0x54b2, LSL #48
    SUB  X9, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x87a8, LSL #0
    MOVK  X5, #0xb34e, LSL #16
    MOVK  X5, #0xa373, LSL #32
    MOVK  X5, #0x2d57, LSL #48
    SUB  X9, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0xd4a1, LSL #0
    MOVK  X5, #0xe16, LSL #16
    MOVK  X5, #0xf9aa, LSL #32
    MOVK  X5, #0x6511, LSL #48
    SUB  X9, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0xe8cd, LSL #0
    MOVK  X5, #0xcd1b, LSL #16
    MOVK  X5, #0x6011, LSL #32
    MOVK  X5, #0xa359, LSL #48
    SUB  X9, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x64b8, LSL #0
    MOVK  X5, #0x83dc, LSL #16
    MOVK  X5, #0x421d, LSL #32
    MOVK  X5, #0x748b, LSL #48
    SUB  X9, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0xe343, LSL #0
    MOVK  X5, #0x3cf1, LSL #16
    MOVK  X5, #0x6d11, LSL #32
    MOVK  X5, #0xa63, LSL #48
    SUB  X9, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x468d, LSL #0
    MOVK  X5, #0x7ee1, LSL #16
    MOVK  X5, #0x8832, LSL #32
    MOVK  X5, #0xfb9d, LSL #48
    SUB  X9, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0xe40a, LSL #0
    MOVK  X5, #0xaf8a, LSL #16
    MOVK  X5, #0xef8, LSL #32
    MOVK  X5, #0xb2b, LSL #48
    SUB  X9, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x2598, LSL #0
    MOVK  X5, #0x3141, LSL #16
    MOVK  X5, #0xb64, LSL #32
    MOVK  X5, #0x3582, LSL #48
    SUB  X9, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x272f, LSL #0
    MOVK  X5, #0xa24a, LSL #16
    MOVK  X5, #0xa509, LSL #32
    MOVK  X5, #0xb54d, LSL #48
    SUB  X9, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x738, LSL #0
    MOVK  X5, #0x6192, LSL #16
    MOVK  X5, #0xf2b1, LSL #32
    MOVK  X5, #0xbb3f, LSL #48
    SUB  X9, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0xcb39, LSL #0
    MOVK  X5, #0x1bc, LSL #16
    MOVK  X5, #0x4d6, LSL #32
    MOVK  X5, #0x6dad, LSL #48
    SUB  X9, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0xba07, LSL #0
    MOVK  X5, #0x73a, LSL #16
    MOVK  X5, #0xde09, LSL #32
    MOVK  X5, #0x95a5, LSL #48
    SUB  X9, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x52fc, LSL #0
    MOVK  X5, #0xfc2d, LSL #16
    MOVK  X5, #0xe37f, LSL #32
    MOVK  X5, #0x22ef, LSL #48
    SUB  X9, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0xbf4c, LSL #0
    MOVK  X5, #0x3aac, LSL #16
    MOVK  X5, #0x3955, LSL #32
    MOVK  X5, #0x94a9, LSL #48
    SUB  X9, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x1eed, LSL #0
    MOVK  X5, #0x7e64, LSL #16
    MOVK  X5, #0xbd70, LSL #32
    MOVK  X5, #0x918f, LSL #48
    SUB  X9, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x5d54, LSL #0
    MOVK  X5, #0xf938, LSL #16
    MOVK  X5, #0x9dcc, LSL #32
    MOVK  X5, #0x1a49, LSL #48
    SUB  X9, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0xe30f, LSL #0
    MOVK  X5, #0x5629, LSL #16
    MOVK  X5, #0x38b3, LSL #32
    MOVK  X5, #0x4467, LSL #48
    SUB  X9, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x7de4, LSL #0
    MOVK  X5, #0x421b, LSL #16
    MOVK  X5, #0x99cd, LSL #32
    MOVK  X5, #0x113a, LSL #48
    SUB  X9, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x44c3, LSL #0
    MOVK  X5, #0x97a1, LSL #16
    MOVK  X5, #0xf201, LSL #32
    MOVK  X5, #0xbabf, LSL #48
    SUB  X9, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x81, LSL #0
    MRS  X9, FPSR
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D0
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D1
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x1eed, LSL #0
    FMOV  X9, D2
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D3
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D4
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D5
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D6
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D7
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D9
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D10
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x44c3, LSL #0
    MOVK  X5, #0x97a1, LSL #16
    MOVK  X5, #0xf201, LSL #32
    MOVK  X5, #0xbabf, LSL #48
    FMOV  X9, V11.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x1eed, LSL #0
    MOVK  X5, #0x7e64, LSL #16
    MOVK  X5, #0xbd70, LSL #32
    MOVK  X5, #0x918f, LSL #48
    FMOV  X9, D11
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D12
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D13
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D14
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D15
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D16
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x1eed, LSL #0
    FMOV  X9, D17
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D18
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D19
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D20
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D21
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D22
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D23
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D24
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D25
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D26
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D27
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D28
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D29
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D30
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X9, D31
    SUB  X15, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X5
    FMOV  V0.D[1], X26
    FMOV  D1, X22
    FMOV  V1.D[1], X20
    FMOV  D2, X4
    FMOV  V2.D[1], X25
    FMOV  D3, X14
    FMOV  V3.D[1], X23
    FMOV  D4, X21
    FMOV  V4.D[1], X17
    FMOV  D5, X29
    FMOV  V5.D[1], X24
    FMOV  D6, X28
    FMOV  V6.D[1], X20
    FMOV  D7, X5
    FMOV  V7.D[1], X9
    FMOV  D8, X14
    FMOV  V8.D[1], X24
    FMOV  D9, X25
    FMOV  V9.D[1], X18
    FMOV  D10, X18
    FMOV  V10.D[1], X26
    FMOV  D11, X5
    FMOV  V11.D[1], X9
    FMOV  D12, X29
    FMOV  V12.D[1], X24
    FMOV  D13, X16
    FMOV  V13.D[1], X9
    FMOV  D14, X10
    FMOV  V14.D[1], X23
    FMOV  D15, X22
    FMOV  V15.D[1], X26
    FMOV  D16, X14
    FMOV  V16.D[1], X28
    FMOV  D17, X24
    FMOV  V17.D[1], X21
    FMOV  D18, X20
    FMOV  V18.D[1], X4
    FMOV  D19, X29
    FMOV  V19.D[1], X5
    FMOV  D20, X26
    FMOV  V20.D[1], X18
    FMOV  D21, X23
    FMOV  V21.D[1], X5
    FMOV  D22, X6
    FMOV  V22.D[1], X13
    FMOV  D23, X13
    FMOV  V23.D[1], X8
    FMOV  D24, X5
    FMOV  V24.D[1], X17
    FMOV  D25, X25
    FMOV  V25.D[1], X6
    FMOV  D26, X12
    FMOV  V26.D[1], X5
    FMOV  D27, X24
    FMOV  V27.D[1], X29
    FMOV  D28, X21
    FMOV  V28.D[1], X23
    FMOV  D29, X7
    FMOV  V29.D[1], X20
    FMOV  D30, X7
    FMOV  V30.D[1], X23
    FMOV  D31, X23
    FMOV  V31.D[1], X26
    MOVZ  X24, #0xf, LSL #0
TSRTFloatMinMax_label_16:
    FMINNM  S23, S31, S22
    FMIN  D3, D29, D27
    FMINNM  D1, D23, D25
    FMIN  H24, H3, H3
    FMAX  H11, H21, H21
    FMAXNM  S6, S30, S24
    FMIN  S0, S1, S11
    FMINNM  H21, H26, H28
    FMAX  H26, H6, H0
    FMAX  S30, S26, S21
    FMAXNM  D3, D6, D28
    FMAXNM  H6, H22, H7
    FMAXNM  H31, H17, H9
    FMAX  D17, D16, D29
    FMIN  H23, H11, H3
    FMIN  H11, H5, H6
    FMINNM  S7, S8, S17
    FMAX  H2, H29, H6
    FMAXNM  S25, S0, S24
    FMAXNM  S1, S16, S30
    FMAX  S16, S2, S6
    FMINNM  D9, D16, D3
    FMIN  H22, H18, H17
    FMINNM  H28, H3, H2
    FMAXNM  D18, D9, D11
    FMAX  S8, S18, S18
    FMAXNM  D24, D1, D8
    FMIN  H8, H24, H7
    FMIN  H16, H8, H23
    FMAX  H2, H31, H28
    FMAX  S17, S2, S2
    FMAXNM  S27, S20, S17
    FMINNM  S17, S10, S25
    FMAXNM  D3, D16, D17
    FMINNM  S5, S24, S22
    FMAX  D8, D27, D27
    FMINNM  S27, S3, S8
    FMINNM  D23, D27, D27
    FMAX  D6, D5, D23
    FMIN  D26, D31, D11
    FMAXNM  D11, D10, D11
    FMINNM  H20, H26, H23
    FMIN  H28, H0, H1
    FMAXNM  S8, S3, S26
    FMINNM  D2, D2, D20
    FMAX  H7, H18, H27
    FMIN  D25, D29, D27
    FMIN  D5, D21, D22
    FMINNM  H18, H17, H25
    FMAX  S27, S30, S25
    FMINNM  S22, S6, S5
    FMINNM  D20, D11, D8
    FMAXNM  S21, S22, S27
    FMAXNM  H31, H11, H2
    FMAX  D27, D28, D7
    FMAX  S23, S21, S27
    FMAXNM  H17, H20, H31
    FMAX  S20, S23, S17
    FMINNM  D25, D20, D20
    FMINNM  H31, H18, H18
    FMIN  D10, D5, D31
    FMINNM  H3, H10, H2
    FMIN  H11, H3, H8
    FMAX  D30, D25, D11
    FMAXNM  H28, H7, H2
    FMAX  S7, S21, S18
    FMIN  S22, S19, S21
    FMAXNM  H11, H31, H28
    FMINNM  D28, D5, D28
    FMINNM  H17, H18, H2
    FMAX  S29, S22, S5
    FMAXNM  H19, H20, H1
    FMIN  D5, D4, D7
    FMAX  S1, S11, S20
    FMINNM  D25, D30, D29
    FMAX  S22, S17, S23
    FMINNM  D21, D26, D14
    FMAXNM  D29, D24, D6
    FMINNM  D31, D28, D0
    FMINNM  H10, H31, H28
    FMINNM  S3, S26, S17
    FMINNM  D7, D21, D21
    FMINNM  D11, D19, D19
    FMAXNM  S4, S11, S23
    FMIN  S18, S10, S1
    FMAXNM  H8, H5, H25
    FMAXNM  H26, H8, H8
    FMINNM  S21, S17, S2
    FMIN  D22, D22, D4
    FMAX  S23, S26, S26
    FMAXNM  H25, H23, H3
    FMAXNM  H6, H7, H29
    FMIN  D1, D21, D22
    FMAX  S0, S25, S25
    FMINNM  H26, H0, H0
    FMAXNM  D8, D6, D18
    FMINNM  S22, S8, S8
    FMIN  D8, D1, D22
    FMIN  D7, D10, D4
    FMAX  H1, H7, H26
    FMAXNM  S21, S1, S16
    FMAX  H16, H21, H21
    FMAXNM  D3, D8, D16
    FMIN  H17, H26, H25
    FMINNM  H19, H2, H6
    FMIN  D10, D26, D9
    FMINNM  D1, D27, D14
    FMAXNM  D25, D19, D2
    FMAXNM  H28, H22, H8
    FMAX  S2, S21, S29
    FMINNM  H4, H23, H29
    FMIN  H5, H13, H1
    FMAX  S21, S19, S13
    FMAX  S19, S21, S17
    FMAXNM  S21, S28, S5
    FMAX  S17, S3, S4
    FMAX  S1, S10, S21
    FMAXNM  H27, H11, H1
    FMAX  D7, D14, D27
    FMAX  H16, H2, H7
    FMAXNM  S6, S25, S17
    FMINNM  S11, S6, S16
    FMAXNM  H16, H11, H11
    FMAX  S11, S16, S19
    FMAX  D1, D18, D20
    FMIN  H6, H23, H18
    FMIN  H26, H7, H31
    FMAXNM  S2, S22, S1
    FMAX  S1, S7, S3
    FMIN  H21, H2, H1
    FMAX  D27, D7, D2
    FMAX  D13, D22, D6
    FMAX  H20, H16, H15
    FMIN  S17, S31, S23
    FMAXNM  D7, D23, D4
    FMAXNM  H8, H0, H1
    FMIN  D14, D13, D27
    FMAXNM  D6, D8, D20
    FMAX  S13, S6, S7
    FMAXNM  H4, H17, H26
    FMINNM  S2, S13, S21
    FMAX  S27, S4, S14
    FMINNM  S31, S2, S2
    FMAXNM  D8, D31, D31
    FMAXNM  S10, S27, S27
    FMINNM  D3, D10, D10
    FMIN  S22, S3, S3
    FMAX  H10, H11, H11
    FMINNM  D13, D8, D10
    FMAX  D16, D22, D13
    FMINNM  H13, H31, H6
    FMIN  D22, D5, D14
    FMINNM  S7, S28, S12
    FMINNM  H28, H14, H0
    FMINNM  H21, H2, H26
    FMINNM  H4, H13, H15
    FMINNM  H23, H30, H15
    FMAXNM  S8, S7, S7
    FMAX  H11, H27, H29
    FMAX  D3, D26, D21
    FMAXNM  D17, D23, D24
    FMAX  H2, H21, H3
    FMAX  H0, H2, H10
    FMAX  S5, S25, S13
    FMIN  H6, H5, H16
    FMAX  D12, D6, D6
    FMAXNM  D31, D22, D17
    FMIN  H6, H0, H11
    FMAX  H15, H8, H8
    FMIN  D16, D30, D6
    FMINNM  H0, H12, H28
    FMIN  S17, S11, S4
    FMIN  H24, H31, H17
    FMAX  D8, D15, D15
    FMAX  S10, S16, S14
    FMAX  D27, D8, D0
    FMINNM  D0, D27, D10
    FMINNM  D28, D24, D29
    FMAXNM  H31, H28, H28
    FMAX  S7, S31, S0
    FMINNM  S2, S29, S1
    FMAXNM  S5, S7, S11
    FMIN  H25, H18, H4
    FMAXNM  H22, H23, H9
    FMINNM  D11, D11, D2
    FMIN  D14, D14, D1
    FMIN  D15, D25, D1
    FMINNM  D0, D26, D15
    FMAX  D13, D23, D12
    FMAXNM  H1, H1, H25
    FMAXNM  D25, D9, D6
    FMAXNM  D24, D11, D6
    FMIN  S10, S16, S7
    FMIN  D8, D13, D25
    FMAXNM  H13, H14, H8
    FMINNM  D18, D13, D1
    FMINNM  S25, S5, S0
    FMINNM  D30, D24, D25
    FMAX  S29, S22, S22
    FMAXNM  D4, D29, D18
    SUBS  X24, X24, #0x1
    B.NE  TSRTFloatMinMax_label_16
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x81, LSL #0
    MRS  X15, FPSR
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D0
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D1
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D2
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D3
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D4
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D5
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D6
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D8
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D10
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D11
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D12
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D13
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D16
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D17
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D18
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D20
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D22
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D23
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D24
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D26
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D27
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D29
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D30
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X15, D31
    SUB  X10, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMinMax_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X16
    FMOV  D3, X3
    FMOV  V3.D[1], X10
    FMOV  D4, X25
    FMOV  V4.D[1], X6
    FMOV  D5, X22
    FMOV  V5.D[1], X22
    FMOV  D6, X26
    FMOV  V6.D[1], X9
    FMOV  D7, X28
    FMOV  V7.D[1], X24
    FMOV  D8, X13
    FMOV  V8.D[1], X10
    FMOV  D9, X28
    FMOV  V9.D[1], X24
    FMOV  D10, X23
    FMOV  V10.D[1], X9
    FMOV  D11, X23
    FMOV  V11.D[1], X29
    FMOV  D12, X12
    FMOV  V12.D[1], X6
    FMOV  D13, X15
    FMOV  V13.D[1], X10
    FMOV  D14, X12
    FMOV  V14.D[1], X21
    FMOV  D15, X20
    FMOV  V15.D[1], X7
    FMOV  D16, X8
    FMOV  V16.D[1], X16
    FMOV  D17, X5
    FMOV  V17.D[1], X14
    FMOV  D18, X18
    FMOV  V18.D[1], X5
    FMOV  D19, X5
    FMOV  V19.D[1], X24
    FMOV  D20, X5
    FMOV  V20.D[1], X29
    FMOV  D21, X8
    FMOV  V21.D[1], X4
    FMOV  D22, X26
    FMOV  V22.D[1], X7
    FMOV  D23, X5
    FMOV  V23.D[1], X20
    FMOV  D24, X21
    FMOV  V24.D[1], X18
    FMOV  D25, X15
    FMOV  V25.D[1], X4
    FMOV  D26, X5
    FMOV  V26.D[1], X5
    FMOV  D27, X20
    FMOV  V27.D[1], X18
    FMOV  D28, X9
    FMOV  V28.D[1], X7
    FMOV  D29, X3
    FMOV  V29.D[1], X13
    FMOV  D30, X16
    FMOV  V30.D[1], X15
    FMOV  D31, X29
    FMOV  V31.D[1], X24
    MOVZ  X7, #0xf, LSL #0
TSRTFloatMinMax_label_17:
    FMIN  S26, S23, S28
    FMINNM  D9, D30, D20
    FMAX  H5, H29, H27
    FMAXNM  S3, S5, S31
    FMAXNM  H17, H25, H9
    FMAXNM  D16, D3, D17
    FMINNM  D18, D21, D26
    FMAXNM  S3, S16, S16
    FMIN  H31, H3, H24
    FMAXNM  D17, D31, D18
    FMAXNM  S30, S17, S17
    FMAX  S3, S30, S1
    FMAXNM  D24, D3, D3
    FMIN  S27, S10, S30
    FMIN  D17, D23, D5
    FMIN  H23, H3, H19
    FMINNM  H31, H29, H28
    FMAX  S28, S15, S12
    FMAXNM  S16, S12, S2
    FMAXNM  S21, S22, S20
    FMAX  D19, D11, D4
    FMIN  S25, S24, S21
    FMIN  H30, H27, H31
    FMIN  S15, S19, S17
    FMAXNM  S29, S6, S15
    FMAXNM  H12, H23, H23
    FMAXNM  S3, S28, S28
    FMAXNM  H1, H25, H25
    FMAXNM  H5, H3, H29
    FMIN  D28, D5, D5
    FMINNM  D25, D28, D12
    FMAX  H27, H25, H1
    FMAXNM  D23, D30, D16
    FMAX  H15, H27, H23
    FMIN  D21, D10, D22
    FMIN  H10, H19, H25
    FMIN  D3, D25, D22
    FMIN  S20, S12, S24
    FMINNM  H4, H13, H30
    FMINNM  D29, D12, D18
    FMINNM  D31, D15, D6
    FMIN  S11, S16, S24
    FMIN  S2, S6, S5
    FMAXNM  S16, S31, S2
    FMAXNM  H19, H11, H16
    FMAX  D28, D31, D19
    FMAX  H31, H28, H29
    FMIN  S17, S6, S4
    FMAXNM  S2, S10, S21
    FMIN  H21, H20, H31
    FMIN  D15, D21, D17
    FMAXNM  D23, D2, D2
    FMINNM  D21, D23, D3
    FMAXNM  H27, H15, H15
    FMAX  D15, D21, D21
    FMIN  H28, H15, H27
    FMAX  S11, S2, S16
    FMAX  H13, H29, H15
    FMINNM  D22, D27, D8
    FMIN  H19, H16, H29
    FMAX  S17, S17, S31
    FMAX  H31, H10, H28
    FMAXNM  S28, S3, S12
    FMINNM  D12, D18, D8
    FMINNM  D27, D27, D22
    FMIN  D15, D30, D2
    FMAXNM  S29, S15, S7
    FMAXNM  H16, H12, H31
    FMINNM  H5, H11, H28
    FMINNM  H22, H5, H13
    FMINNM  S3, S22, S22
    FMINNM  D8, D29, D29
    FMAXNM  H4, H27, H19
    FMINNM  D29, D17, D16
    FMAXNM  D17, D29, D3
    FMAXNM  H6, H8, H8
    FMAX  H13, H6, H4
    FMAXNM  S8, S17, S17
    FMIN  H19, H13, H8
    FMAX  D5, D13, D24
    FMIN  H4, H28, H28
    FMINNM  H13, H18, H25
    FMAXNM  D10, D5, D11
    FMIN  D21, D9, D23
    FMAXNM  H29, H10, H25
    FMAXNM  S22, S30, S16
    FMAXNM  D25, D8, D28
    FMAX  S18, S1, S7
    FMAX  S17, S6, S16
    FMIN  S5, S29, S4
    FMAX  D3, D25, D5
    FMAXNM  H27, H3, H3
    FMIN  D24, D22, D19
    FMINNM  S11, S18, S24
    FMIN  D8, D13, D1
    FMAX  H28, H21, H8
    FMAX  S7, S11, S27
    FMAXNM  D30, D17, D7
    FMAX  S29, S30, S28
    FMINNM  H10, H2, H10
    FMAXNM  H21, H27, H24
    FMAXNM  D8, D20, D15
    FMAXNM  S16, S21, S30
    FMAXNM  S21, S1, S30
    FMINNM  S2, S31, S22
    FMAX  S6, S10, S19
    FMAXNM  D28, D3, D9
    FMAX  D25, D12, D30
    FMIN  S7, S21, S4
    FMAX  H20, H24, H5
    FMINNM  D5, D2, D29
    FMAX  D23, D5, D8
    FMAX  D2, D7, D6
    FMIN  H30, H28, H16
    FMINNM  S6, S23, S30
    FMINNM  S16, S2, S20
    FMAXNM  D4, D25, D16
    FMAXNM  H23, H6, H4
    FMAX  D17, D24, D13
    FMINNM  D21, D27, D16
    FMAXNM  H11, H27, H18
    FMAX  D24, D23, D16
    FMAX  D12, D2, D13
    FMINNM  D15, D11, D23
    FMAX  D30, D27, D30
    FMAX  D3, D9, D12
    FMIN  H20, H30, H19
    FMAXNM  S27, S30, S22
    FMAX  S31, S11, S26
    FMINNM  D25, D20, D28
    FMIN  S10, S8, S0
    FMINNM  D2, D31, D10
    FMAXNM  H4, H3, H17
    FMAX  D19, D24, D27
    FMAX  D30, D21, D15
    FMIN  S6, S2, S25
    FMAX  S25, S6, S19
    FMAXNM  H21, H4, H25
    FMAX  D27, D21, D30
    FMAXNM  H23, H23, H2
    FMIN  S0, S24, S25
    FMIN  S18, S19, S6
    FMAXNM  H22, H13, H28
    FMAX  H15, H24, H29
    FMAX  D28, D16, D20
    FMAXNM  S29, S28, S11
    FMINNM  S17, S31, S15
    FMIN  H26, H6, H26
    FMAXNM  S13, S0, S17
    FMAX  D6, D7, D18
    FMAXNM  D18, D29, D23
    FMAX  S8, S17, S13
    FMAX  H4, H4, H15
    FMINNM  D20, D14, D17
    FMIN  D12, D30, D13
    FMIN  H21, H26, H20
    FMINNM  H2, H6, H4
    FMIN  H19, H22, H8
    FMIN  S25, S27, S19
    FMAXNM  D16, D19, D18
    FMAXNM  D29, D12, D12
    FMAXNM  D22, D21, D21
    FMINNM  S21, S22, S16
    FMINNM  S27, S2, S25
    FMAX  H11, H29, H21
    FMAXNM  D25, D11, D27
    FMAX  H31, H20, H20
    FMINNM  S14, S21, S29
    FMAXNM  D17, D31, D3
    FMAXNM  D26, D26, D23
    FMAX  H31, H6, H13
    FMAXNM  D2, D11, D13
    FMIN  S3, S29, S17
    FMAX  S23, S31, S13
    FMIN  S27, S7, S6
    FMIN  D6, D4, D18
    FMINNM  S7, S7, S19
    FMIN  S29, S25, S25
    FMIN  H21, H23, H29
    FMIN  D17, D26, D27
    FMINNM  S22, S14, S17
    FMINNM  H20, H3, H6
    FMAX  H11, H22, H20
    FMINNM  D30, D11, D11
    FMIN  H19, H7, H7
    FMINNM  S11, S2, S2
    FMINNM  H23, H20, H2
    FMINNM  H26, H11, H21
    FMAXNM  S12, S23, S30
    FMAX  S13, S26, S15
    FMINNM  D27, D19, D19
    FMAX  H19, H12, H12
    FMAXNM  D23, D13, D19
    FMAX  H15, H23, H23
    FMIN  H2, H27, H27
    FMIN  H20, H15, H15
    FMAX  D21, D2, D20
    FMAX  D3, D20, D17
    FMAXNM  S31, S21, S19
    FMINNM  S14, S4, S18
    SUBS  X7, X7, #0x1
    B.NE  TSRTFloatMinMax_label_17
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x81, LSL #0
    MRS  X18, FPSR
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D1
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D2
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D3
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D4
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D5
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D6
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D7
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D8
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D9
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D10
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D11
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D12
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D13
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D14
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D15
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D16
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D17
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D18
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D19
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D20
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D21
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D22
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D23
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D24
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D25
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D26
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D27
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D28
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D29
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D30
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D31
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0xc122, LSL #0
    MOVK  X3, #0x594c, LSL #16
    MOVK  X3, #0x1744, LSL #32
    MOVK  X3, #0xb042, LSL #48
    MOVZ  X4, #0x6c13, LSL #0
    MOVK  X4, #0xc836, LSL #16
    MOVK  X4, #0x97f1, LSL #32
    MOVK  X4, #0x6321, LSL #48
    MOVZ  X5, #0x9a7f, LSL #0
    MOVK  X5, #0x6359, LSL #16
    MOVK  X5, #0xe64c, LSL #32
    MOVK  X5, #0xec83, LSL #48
    MOVZ  X6, #0x539c, LSL #0
    MOVK  X6, #0x1ad1, LSL #16
    MOVK  X6, #0x9f18, LSL #32
    MOVK  X6, #0xc4ad, LSL #48
    MOVZ  X7, #0xf0f3, LSL #0
    MOVK  X7, #0x852a, LSL #16
    MOVK  X7, #0x50a9, LSL #32
    MOVK  X7, #0xd7df, LSL #48
    MOVZ  X8, #0x924d, LSL #0
    MOVK  X8, #0xc9bb, LSL #16
    MOVK  X8, #0xe9aa, LSL #32
    MOVK  X8, #0xdb27, LSL #48
    MOVZ  X9, #0x6bd0, LSL #0
    MOVK  X9, #0x3608, LSL #16
    MOVK  X9, #0x26d6, LSL #32
    MOVK  X9, #0x71a3, LSL #48
    MOVZ  X10, #0x484a, LSL #0
    MOVK  X10, #0xffa1, LSL #16
    MOVK  X10, #0x89e0, LSL #32
    MOVK  X10, #0x684a, LSL #48
    MOVZ  X12, #0x2dd0, LSL #0
    MOVK  X12, #0xd6f3, LSL #16
    MOVK  X12, #0x8110, LSL #32
    MOVK  X12, #0x5177, LSL #48
    MOVZ  X13, #0xaf1b, LSL #0
    MOVK  X13, #0x723e, LSL #16
    MOVK  X13, #0x993e, LSL #32
    MOVK  X13, #0xb5ff, LSL #48
    MOVZ  X14, #0x2749, LSL #0
    MOVK  X14, #0xea9, LSL #16
    MOVK  X14, #0x94a8, LSL #32
    MOVK  X14, #0xdc02, LSL #48
    MOVZ  X15, #0x3e73, LSL #0
    MOVK  X15, #0xb1e8, LSL #16
    MOVK  X15, #0x8de8, LSL #32
    MOVK  X15, #0xd058, LSL #48
    MOVZ  X16, #0x6fb7, LSL #0
    MOVK  X16, #0x6298, LSL #16
    MOVK  X16, #0xd34, LSL #32
    MOVK  X16, #0x1119, LSL #48
    MOVZ  X17, #0x35f9, LSL #0
    MOVK  X17, #0x5385, LSL #16
    MOVK  X17, #0xa574, LSL #32
    MOVK  X17, #0x2f6e, LSL #48
    MOVZ  X18, #0x9553, LSL #0
    MOVK  X18, #0xe79e, LSL #16
    MOVK  X18, #0xc594, LSL #32
    MOVK  X18, #0xe00d, LSL #48
    MOVZ  X20, #0xc8ba, LSL #0
    MOVK  X20, #0x6d1c, LSL #16
    MOVK  X20, #0x6d9d, LSL #32
    MOVK  X20, #0x45b7, LSL #48
    MOVZ  X21, #0xea66, LSL #0
    MOVK  X21, #0xa8e, LSL #16
    MOVK  X21, #0x686f, LSL #32
    MOVK  X21, #0xc7e3, LSL #48
    MOVZ  X22, #0xf00f, LSL #0
    MOVK  X22, #0xeebd, LSL #16
    MOVK  X22, #0x3081, LSL #32
    MOVK  X22, #0x4180, LSL #48
    MOVZ  X23, #0x2bfa, LSL #0
    MOVK  X23, #0x14d9, LSL #16
    MOVK  X23, #0x9f93, LSL #32
    MOVK  X23, #0x26de, LSL #48
    MOVZ  X24, #0x8424, LSL #0
    MOVK  X24, #0x4c90, LSL #16
    MOVK  X24, #0x2b1, LSL #32
    MOVK  X24, #0x16e1, LSL #48
    MOVZ  X25, #0xb04e, LSL #0
    MOVK  X25, #0xc784, LSL #16
    MOVK  X25, #0xdb58, LSL #32
    MOVK  X25, #0xc892, LSL #48
    MOVZ  X26, #0x9eae, LSL #0
    MOVK  X26, #0xefe2, LSL #16
    MOVK  X26, #0xa46e, LSL #32
    MOVK  X26, #0x6c2b, LSL #48
    MOVZ  X28, #0xa9f, LSL #0
    MOVK  X28, #0xa9c1, LSL #16
    MOVK  X28, #0x7a4, LSL #32
    MOVK  X28, #0x5491, LSL #48
    MOVZ  X29, #0x20dd, LSL #0
    MOVK  X29, #0x22d6, LSL #16
    MOVK  X29, #0x560e, LSL #32
    MOVK  X29, #0x8f0f, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X18
    FMOV  V2.D[1], X13
    FMOV  D3, X5
    FMOV  V3.D[1], X18
    FMOV  D4, X16
    FMOV  V4.D[1], X20
    FMOV  D5, X22
    FMOV  V5.D[1], X14
    FMOV  D6, X9
    FMOV  V6.D[1], X9
    FMOV  D7, X10
    FMOV  V7.D[1], X10
    FMOV  D8, X21
    FMOV  V8.D[1], X8
    FMOV  D9, X22
    FMOV  V9.D[1], X17
    FMOV  D10, X29
    FMOV  V10.D[1], X7
    FMOV  D11, X22
    FMOV  V11.D[1], X18
    FMOV  D12, X28
    FMOV  V12.D[1], X18
    FMOV  D13, X23
    FMOV  V13.D[1], X21
    FMOV  D14, X9
    FMOV  V14.D[1], X15
    FMOV  D15, X12
    FMOV  V15.D[1], X10
    FMOV  D16, X8
    FMOV  V16.D[1], X12
    FMOV  D17, X29
    FMOV  V17.D[1], X17
    FMOV  D18, X25
    FMOV  V18.D[1], X12
    FMOV  D19, X3
    FMOV  V19.D[1], X24
    FMOV  D20, X24
    FMOV  V20.D[1], X7
    FMOV  D21, X8
    FMOV  V21.D[1], X6
    FMOV  D22, X14
    FMOV  V22.D[1], X9
    FMOV  D23, X14
    FMOV  V23.D[1], X6
    FMOV  D24, X26
    FMOV  V24.D[1], X10
    FMOV  D25, X9
    FMOV  V25.D[1], X20
    FMOV  D26, X8
    FMOV  V26.D[1], X26
    FMOV  D27, X7
    FMOV  V27.D[1], X3
    FMOV  D28, X14
    FMOV  V28.D[1], X21
    FMOV  D29, X21
    FMOV  V29.D[1], X15
    FMOV  D30, X6
    FMOV  V30.D[1], X22
    FMOV  D31, X17
    FMOV  V31.D[1], X21
    MOVZ  X10, #0xf, LSL #0
TSRTFloatMinMax_label_18:
    FMAX  S21, S26, S31
    FMIN  S22, S23, S30
    FMIN  D8, D25, D27
    FMAX  S12, S21, S29
    FMAXNM  S0, S24, S24
    FMIN  H28, H28, H22
    FMAX  H11, H8, H0
    FMAX  D28, D11, D11
    FMINNM  D10, D12, D12
    FMAX  D2, D10, D28
    FMAX  S21, S1, S10
    FMIN  H28, H13, H18
    FMAX  S18, S9, S25
    FMAXNM  D27, D15, D27
    FMAXNM  D1, D3, D9
    FMAXNM  H23, H11, H21
    FMAX  H27, H23, H25
    FMIN  S26, S20, S7
    FMIN  D29, D4, D22
    FMIN  S13, S18, S4
    FMAXNM  S24, S8, S5
    FMAX  H0, H5, H18
    FMIN  H21, H0, H0
    FMAXNM  D12, D2, D26
    FMINNM  H11, H28, H1
    FMAX  H22, H11, H18
    FMAXNM  D11, D22, D22
    FMINNM  H22, H12, H12
    FMAXNM  H12, H24, H22
    FMAX  D28, D12, D21
    FMAX  H7, H3, H27
    FMAX  D24, D21, D29
    FMIN  S21, S7, S7
    FMAX  H12, H28, H0
    FMIN  S2, S13, S13
    FMAXNM  S0, S12, S11
    FMINNM  H4, H2, H2
    FMAX  H27, H24, H0
    FMINNM  H10, H4, H27
    FMINNM  D18, D10, D21
    FMIN  S27, S26, S20
    FMAXNM  D3, D3, D31
    FMINNM  S29, S11, S5
    FMINNM  H1, H30, H23
    FMAX  S22, S31, S14
    FMAXNM  S11, S30, S3
    FMAX  H31, H25, H5
    FMINNM  S24, S12, S4
    FMAX  D26, D24, D9
    FMAXNM  D0, D16, D2
    FMAXNM  S13, S29, S26
    FMINNM  S10, S11, S13
    FMAX  H23, H31, H1
    FMAXNM  H20, H28, H27
    FMIN  S21, S18, S0
    FMAX  S9, S20, S17
    FMAX  H5, H21, H22
    FMAX  S17, S5, S23
    FMINNM  D5, D17, D10
    FMAX  H18, H9, H5
    FMINNM  D12, D16, D17
    FMAXNM  D0, D16, D31
    FMINNM  H29, H8, H30
    FMINNM  D17, D16, D15
    FMIN  S25, S6, S12
    FMINNM  H6, H23, H15
    FMINNM  H24, H24, H5
    FMIN  D15, D29, D17
    FMIN  D26, D30, D11
    FMIN  H12, H17, H12
    FMAX  S1, S30, S12
    FMINNM  D17, D16, D7
    FMIN  S31, S24, S0
    FMIN  S20, S15, S18
    FMAX  H21, H25, H25
    FMINNM  H18, H17, H26
    FMAX  H10, H6, H18
    FMAX  S23, S20, S21
    FMIN  H20, H31, H31
    FMAXNM  S8, S20, S23
    FMIN  S31, S10, S8
    FMIN  S15, S1, S1
    FMINNM  H25, H15, H31
    FMAX  D10, D26, D30
    FMAX  H0, H24, H14
    FMIN  S9, S11, S25
    FMINNM  D22, D27, D10
    FMAX  S11, S20, S11
    FMINNM  S29, S16, S3
    FMINNM  H1, H19, H6
    FMAX  S23, S21, S18
    FMINNM  S16, S29, S8
    FMAX  S19, S21, S28
    FMIN  S7, S12, S11
    FMIN  D15, D5, D4
    FMINNM  H5, H4, H15
    FMIN  D31, D7, D23
    FMAX  S28, S31, S1
    FMINNM  H27, H16, H22
    FMAX  H17, H9, H9
    FMINNM  D26, D19, D5
    FMINNM  S6, S4, S0
    FMIN  H30, H27, H27
    FMAXNM  S24, S25, S30
    FMIN  S16, S6, S28
    FMAX  D15, D16, D24
    FMIN  S30, S17, S17
    FMAXNM  D6, D26, D30
    FMINNM  D1, D6, D9
    FMAX  D23, D15, D6
    FMAX  H19, H1, H23
    FMAX  S24, S19, S10
    FMAXNM  D4, D11, D24
    FMINNM  S19, S26, S28
    FMINNM  D9, D20, D2
    FMAXNM  H18, H14, H20
    FMAX  S5, S5, S11
    FMINNM  H31, H19, H24
    FMAX  D26, D4, D7
    FMINNM  D25, D16, D11
    FMAX  H27, H25, H8
    FMAX  D20, D19, D14
    FMIN  S19, S26, S28
    FMINNM  H28, H0, H28
    FMINNM  D24, D22, D1
    FMAXNM  D2, D1, D31
    FMIN  S20, S19, S24
    FMAXNM  D4, D9, D27
    FMIN  D14, D4, D5
    FMAX  D10, D28, D2
    FMINNM  S25, S20, S18
    FMAX  S9, S14, S14
    FMIN  H27, H10, H25
    FMINNM  D14, D9, D27
    FMINNM  D27, D30, D17
    FMAX  S25, S30, S2
    FMIN  S7, S12, S31
    FMINNM  H12, H25, H10
    FMINNM  H4, H25, H19
    FMAX  D11, D6, D4
    FMAXNM  D28, D23, D10
    FMINNM  H1, H28, H22
    FMIN  S23, S8, S16
    FMIN  S18, S21, S1
    FMAX  S26, S14, S10
    FMAX  D16, D29, D20
    FMAXNM  S1, S28, S17
    FMAX  S19, S11, S23
    FMIN  H31, H12, H16
    FMINNM  S22, S19, S7
    FMAXNM  D24, D27, D27
    FMAX  S8, S9, S26
    FMAXNM  H19, H18, H1
    FMINNM  D12, D19, D8
    FMIN  H28, H31, H12
    FMIN  H12, H28, H24
    FMAXNM  D7, D22, D18
    FMAX  D16, D12, D12
    FMAX  D1, D16, D16
    FMINNM  H25, H1, H1
    FMIN  D14, D25, D7
    FMIN  H24, H11, H27
    FMAXNM  D31, D1, D11
    FMINNM  S4, S1, S12
    FMAX  S17, S27, S1
    FMINNM  H19, H15, H7
    FMIN  S16, S8, S21
    FMAXNM  H29, H17, H21
    FMINNM  D18, D20, D22
    FMIN  D25, D30, D20
    FMIN  H1, H14, H4
    FMAXNM  D20, D1, D24
    FMAXNM  D23, D29, D20
    FMAXNM  H29, H23, H19
    FMAXNM  D21, D31, D31
    FMINNM  D26, D16, D21
    FMIN  S11, S18, S18
    FMINNM  H18, H25, H29
    FMIN  D20, D18, D26
    FMIN  H21, H20, H20
    FMAX  D20, D20, D11
    FMAX  D8, D21, D0
    FMAX  H15, H20, H20
    FMAXNM  S26, S15, S8
    FMINNM  D23, D11, D13
    FMAX  S28, S18, S25
    FMAX  S20, S2, S21
    FMAXNM  D8, D20, D26
    FMINNM  S31, S17, S7
    FMAX  D21, D29, D30
    FMAXNM  H15, H25, H30
    FMAX  D13, D18, D19
    FMAXNM  S26, S8, S16
    FMINNM  H2, H19, H28
    FMAX  S0, S4, S5
    FMINNM  H20, H18, H0
    FMAXNM  S18, S30, S14
    FMAXNM  S14, S18, S20
    FMINNM  D16, D23, D2
    FMAXNM  H20, H31, H9
    SUBS  X10, X10, #0x1
    B.NE  TSRTFloatMinMax_label_18
    MOVZ  X18, #0xc122, LSL #0
    MOVK  X18, #0x594c, LSL #16
    MOVK  X18, #0x1744, LSL #32
    MOVK  X18, #0xb042, LSL #48
    SUB  X8, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x6c13, LSL #0
    MOVK  X18, #0xc836, LSL #16
    MOVK  X18, #0x97f1, LSL #32
    MOVK  X18, #0x6321, LSL #48
    SUB  X8, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x9a7f, LSL #0
    MOVK  X18, #0x6359, LSL #16
    MOVK  X18, #0xe64c, LSL #32
    MOVK  X18, #0xec83, LSL #48
    SUB  X8, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x539c, LSL #0
    MOVK  X18, #0x1ad1, LSL #16
    MOVK  X18, #0x9f18, LSL #32
    MOVK  X18, #0xc4ad, LSL #48
    SUB  X8, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xf0f3, LSL #0
    MOVK  X18, #0x852a, LSL #16
    MOVK  X18, #0x50a9, LSL #32
    MOVK  X18, #0xd7df, LSL #48
    SUB  X8, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x6bd0, LSL #0
    MOVK  X18, #0x3608, LSL #16
    MOVK  X18, #0x26d6, LSL #32
    MOVK  X18, #0x71a3, LSL #48
    SUB  X8, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x2dd0, LSL #0
    MOVK  X18, #0xd6f3, LSL #16
    MOVK  X18, #0x8110, LSL #32
    MOVK  X18, #0x5177, LSL #48
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xaf1b, LSL #0
    MOVK  X18, #0x723e, LSL #16
    MOVK  X18, #0x993e, LSL #32
    MOVK  X18, #0xb5ff, LSL #48
    SUB  X8, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x2749, LSL #0
    MOVK  X18, #0xea9, LSL #16
    MOVK  X18, #0x94a8, LSL #32
    MOVK  X18, #0xdc02, LSL #48
    SUB  X8, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x3e73, LSL #0
    MOVK  X18, #0xb1e8, LSL #16
    MOVK  X18, #0x8de8, LSL #32
    MOVK  X18, #0xd058, LSL #48
    SUB  X8, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x6fb7, LSL #0
    MOVK  X18, #0x6298, LSL #16
    MOVK  X18, #0xd34, LSL #32
    MOVK  X18, #0x1119, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x35f9, LSL #0
    MOVK  X18, #0x5385, LSL #16
    MOVK  X18, #0xa574, LSL #32
    MOVK  X18, #0x2f6e, LSL #48
    SUB  X8, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xc8ba, LSL #0
    MOVK  X18, #0x6d1c, LSL #16
    MOVK  X18, #0x6d9d, LSL #32
    MOVK  X18, #0x45b7, LSL #48
    SUB  X8, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xea66, LSL #0
    MOVK  X18, #0xa8e, LSL #16
    MOVK  X18, #0x686f, LSL #32
    MOVK  X18, #0xc7e3, LSL #48
    SUB  X8, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xf00f, LSL #0
    MOVK  X18, #0xeebd, LSL #16
    MOVK  X18, #0x3081, LSL #32
    MOVK  X18, #0x4180, LSL #48
    SUB  X8, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x2bfa, LSL #0
    MOVK  X18, #0x14d9, LSL #16
    MOVK  X18, #0x9f93, LSL #32
    MOVK  X18, #0x26de, LSL #48
    SUB  X8, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x8424, LSL #0
    MOVK  X18, #0x4c90, LSL #16
    MOVK  X18, #0x2b1, LSL #32
    MOVK  X18, #0x16e1, LSL #48
    SUB  X8, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0xb04e, LSL #0
    MOVK  X18, #0xc784, LSL #16
    MOVK  X18, #0xdb58, LSL #32
    MOVK  X18, #0xc892, LSL #48
    SUB  X8, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x9eae, LSL #0
    MOVK  X18, #0xefe2, LSL #16
    MOVK  X18, #0xa46e, LSL #32
    MOVK  X18, #0x6c2b, LSL #48
    SUB  X8, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x20dd, LSL #0
    MOVK  X18, #0x22d6, LSL #16
    MOVK  X18, #0x560e, LSL #32
    MOVK  X18, #0x8f0f, LSL #48
    SUB  X8, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x81, LSL #0
    MRS  X8, FPSR
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x35f9, LSL #0
    MOVK  X18, #0x5385, LSL #16
    FMOV  X8, D0
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D1
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D2
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x35f9, LSL #0
    MOVK  X18, #0x5385, LSL #16
    MOVK  X18, #0xa574, LSL #32
    MOVK  X18, #0x2f6e, LSL #48
    FMOV  X8, D3
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D4
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x35f9, LSL #0
    MOVK  X18, #0x5385, LSL #16
    FMOV  X8, D5
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D6
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D7
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D8
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D9
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D10
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V11.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D11
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D12
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V13.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D13
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D14
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V15.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D15
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D16
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D17
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D18
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D19
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D20
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D21
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D22
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D23
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D24
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D25
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D26
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D27
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D28
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D29
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D30
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D31
    SUB  X28, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatMinMax_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X7
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X21
    FMOV  D2, X26
    FMOV  V2.D[1], X22
    FMOV  D3, X14
    FMOV  V3.D[1], X29
    FMOV  D4, X16
    FMOV  V4.D[1], X18
    FMOV  D5, X23
    FMOV  V5.D[1], X20
    FMOV  D6, X28
    FMOV  V6.D[1], X18
    FMOV  D7, X25
    FMOV  V7.D[1], X5
    FMOV  D8, X20
    FMOV  V8.D[1], X15
    FMOV  D9, X18
    FMOV  V9.D[1], X14
    FMOV  D10, X12
    FMOV  V10.D[1], X7
    FMOV  D11, X29
    FMOV  V11.D[1], X16
    FMOV  D12, X26
    FMOV  V12.D[1], X12
    FMOV  D13, X20
    FMOV  V13.D[1], X24
    FMOV  D14, X5
    FMOV  V14.D[1], X9
    FMOV  D15, X20
    FMOV  V15.D[1], X10
    FMOV  D16, X9
    FMOV  V16.D[1], X16
    FMOV  D17, X21
    FMOV  V17.D[1], X22
    FMOV  D18, X23
    FMOV  V18.D[1], X8
    FMOV  D19, X7
    FMOV  V19.D[1], X28
    FMOV  D20, X16
    FMOV  V20.D[1], X20
    FMOV  D21, X26
    FMOV  V21.D[1], X22
    FMOV  D22, X7
    FMOV  V22.D[1], X13
    FMOV  D23, X4
    FMOV  V23.D[1], X29
    FMOV  D24, X29
    FMOV  V24.D[1], X16
    FMOV  D25, X28
    FMOV  V25.D[1], X3
    FMOV  D26, X14
    FMOV  V26.D[1], X28
    FMOV  D27, X25
    FMOV  V27.D[1], X24
    FMOV  D28, X18
    FMOV  V28.D[1], X15
    FMOV  D29, X20
    FMOV  V29.D[1], X20
    FMOV  D30, X29
    FMOV  V30.D[1], X4
    FMOV  D31, X3
    FMOV  V31.D[1], X8
    MOVZ  X22, #0xf, LSL #0
TSRTFloatMinMax_label_19:
    FMIN  H6, H27, H27
    FMINNM  D25, D28, D31
    FMIN  D3, D24, D29
    FMAXNM  D27, D3, D30
    FMAXNM  D14, D27, D6
    FMIN  H23, H25, H14
    FMAXNM  D4, D23, D26
    FMIN  S30, S4, S4
    FMINNM  S19, S30, S30
    FMINNM  H30, H22, H19
    FMIN  H9, H30, H30
    FMAX  D30, D29, D20
    FMAXNM  H3, H16, H21
    FMAXNM  D31, D8, D28
    FMAXNM  D14, D9, D0
    FMAX  H28, H6, H4
    FMIN  S22, S15, S6
    FMAX  S24, S19, S0
    FMIN  D29, D15, D26
    FMAX  D26, D12, D11
    FMAX  S8, S22, S22
    FMAXNM  S20, S30, S24
    FMIN  D27, D8, D20
    FMAX  S19, S8, S11
    FMINNM  D25, D3, D3
    FMINNM  S6, S25, S28
    FMINNM  S23, S31, S31
    FMIN  S28, S14, S14
    FMAXNM  S14, S27, S19
    FMAX  S27, S29, S6
    FMINNM  D16, D14, D23
    FMAX  D22, D26, D28
    FMAXNM  D0, D27, D16
    FMINNM  D9, D22, D0
    FMAXNM  D25, D5, D2
    FMAXNM  D31, D8, D21
    FMAX  D4, D27, D16
    FMAXNM  S28, S31, S4
    FMIN  H15, H25, H0
    FMAXNM  D30, D20, D24
    FMINNM  S24, S1, S20
    FMAX  S12, S24, S7
    FMAX  H19, H20, H16
    FMINNM  D31, D5, D1
    FMAXNM  D8, D18, D2
    FMAX  D2, D28, D16
    FMAXNM  S24, S8, S5
    FMINNM  H23, H20, H15
    FMINNM  S14, S4, S9
    FMINNM  S11, S29, S20
    FMAXNM  H29, H19, H11
    FMAXNM  D28, D31, D29
    FMAXNM  S25, S12, S28
    FMIN  S7, S14, S24
    FMAXNM  S19, S3, S7
    FMIN  D1, D25, D19
    FMINNM  D27, D2, D1
    FMINNM  D18, D8, D27
    FMINNM  D14, D23, D18
    FMINNM  S31, S30, S30
    FMINNM  S7, S3, S23
    FMAXNM  D12, D14, D14
    FMINNM  D5, D7, D12
    FMIN  H24, H31, H31
    FMINNM  D4, D5, D5
    FMAX  S28, S24, S26
    FMAXNM  D20, D28, D4
    FMINNM  H9, H27, H3
    FMAX  H11, H9, H6
    FMINNM  H23, H6, H14
    FMAXNM  H25, H24, H0
    FMIN  D12, D2, D24
    FMIN  H19, H8, H25
    FMIN  S7, S18, S22
    FMINNM  H5, H14, H11
    FMAX  H14, H6, H16
    FMINNM  S24, S25, S21
    FMAX  S30, S27, S3
    FMAX  S0, S30, S14
    FMAXNM  S25, S20, S20
    FMAX  D31, D0, D23
    FMIN  S9, S25, S5
    FMINNM  D16, D12, D9
    FMINNM  D21, D16, D7
    FMINNM  D7, D31, D24
    FMAX  S24, S7, S7
    FMAXNM  H28, H24, H19
    FMIN  S16, S28, S21
    FMIN  D3, D14, D21
    FMAXNM  H7, H16, H25
    FMINNM  H23, H11, H26
    FMIN  D6, D17, D6
    FMIN  H22, H26, H28
    FMAXNM  H19, H2, H29
    FMIN  S16, S14, S13
    FMINNM  H30, H17, H4
    FMIN  D8, D16, D29
    FMIN  S26, S19, S22
    FMAX  H9, H16, H29
    FMAX  H17, H21, H19
    FMIN  S4, S3, S9
    FMAXNM  H21, H23, H0
    FMAXNM  S20, S30, S7
    FMIN  D7, D20, D6
    FMAXNM  S31, S21, S4
    FMAXNM  S12, S31, S17
    FMIN  S23, S7, S8
    FMAX  D22, D26, D26
    FMAX  H16, H22, H12
    FMAXNM  S0, S23, S23
    FMIN  S11, S0, S0
    FMINNM  D31, D16, D16
    FMAXNM  H9, H11, H31
    FMAXNM  D8, D3, D15
    FMIN  H30, H27, H21
    FMIN  D20, D25, D5
    FMIN  H19, H23, H4
    FMAXNM  D21, D6, D5
    FMIN  D22, D12, D25
    FMIN  H0, H4, H11
    FMAX  S16, S27, S2
    FMIN  D17, D21, D9
    FMAXNM  D26, D27, D20
    FMINNM  S9, S19, S19
    FMIN  H20, H20, H22
    FMIN  H31, H30, H8
    FMINNM  H30, H9, H9
    FMAX  S8, S0, S30
    FMAXNM  S0, S8, S16
    FMAX  H2, H31, H20
    FMINNM  D21, D2, D20
    FMAXNM  D7, D0, D21
    FMAX  D12, D7, D26
    FMINNM  H19, H12, H12
    FMIN  H26, H19, H19
    FMAX  S15, S17, S3
    FMAX  H6, H30, H26
    FMINNM  H0, H15, H6
    FMAXNM  S9, S26, S24
    FMIN  H12, H29, H31
    FMINNM  H31, H21, H11
    FMAX  D19, D20, D9
    FMIN  S22, S7, S22
    FMAX  H9, H17, H21
    FMIN  D3, D27, D25
    FMAX  S16, S10, S1
    FMAXNM  D27, D24, D11
    FMAXNM  S30, S27, S0
    FMAXNM  S26, S20, S31
    FMINNM  S8, S22, S26
    FMAX  D29, D16, D12
    FMINNM  H2, H9, H19
    FMINNM  S12, S3, S3
    FMINNM  H7, H30, H12
    FMAX  H27, H7, H8
    FMAX  D11, D8, D27
    FMAX  S20, S2, S11
    FMIN  H31, H29, H20
    FMAX  H10, H10, H2
    FMIN  S8, S15, S12
    FMIN  H6, H31, H16
    FMAXNM  H7, H30, H14
    FMIN  H11, H9, H25
    FMINNM  D17, D28, D30
    FMINNM  D19, D11, D4
    FMAXNM  S12, S26, S7
    FMIN  H3, H11, H16
    FMAX  S2, S15, S1
    FMAX  H27, H0, H29
    FMIN  H15, H10, H14
    FMINNM  H10, H17, H2
    FMAXNM  S9, S8, S3
    FMINNM  S30, S27, S30
    FMAXNM  S27, S30, S6
    FMAXNM  S30, S27, S15
    FMIN  S22, S19, S10
    FMAXNM  H24, H22, H9
    FMAXNM  H14, H24, H12
    FMAXNM  H19, H30, H30
    FMINNM  S24, S22, S30
    FMINNM  S11, S18, S14
    FMIN  D9, D19, D19
    FMAX  H25, H24, H11
    FMAXNM  S12, S4, S22
    FMIN  S17, S9, S9
    FMAX  H26, H17, H25
    FMAXNM  D1, D26, D12
    FMAX  D20, D23, D4
    FMAX  S7, S7, S10
    FMAX  H24, H28, H15
    FMAX  S2, S12, S7
    FMIN  S15, S22, S14
    FMIN  S22, S0, S15
    FMAXNM  H3, H17, H22
    FMAXNM  H17, H27, H13
    FMAX  H4, H12, H1
    FMAX  H8, H4, H31
    FMIN  S11, S31, S3
    FMINNM  D29, D10, D15
    FMAXNM  S10, S12, S28
    SUBS  X22, X22, #0x1
    B.NE  TSRTFloatMinMax_label_19
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x81, LSL #0
    MRS  X25, FPSR
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D5
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D24
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMinMax_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X20
    FMOV  D3, X20
    FMOV  V3.D[1], X14
    FMOV  D4, X13
    FMOV  V4.D[1], X28
    FMOV  D5, X26
    FMOV  V5.D[1], X29
    FMOV  D6, X26
    FMOV  V6.D[1], X28
    FMOV  D7, X22
    FMOV  V7.D[1], X5
    FMOV  D8, X28
    FMOV  V8.D[1], X26
    FMOV  D9, X4
    FMOV  V9.D[1], X15
    FMOV  D10, X6
    FMOV  V10.D[1], X4
    FMOV  D11, X23
    FMOV  V11.D[1], X7
    FMOV  D12, X20
    FMOV  V12.D[1], X28
    FMOV  D13, X24
    FMOV  V13.D[1], X14
    FMOV  D14, X4
    FMOV  V14.D[1], X25
    FMOV  D15, X17
    FMOV  V15.D[1], X8
    FMOV  D16, X20
    FMOV  V16.D[1], X3
    FMOV  D17, X10
    FMOV  V17.D[1], X14
    FMOV  D18, X23
    FMOV  V18.D[1], X17
    FMOV  D19, X10
    FMOV  V19.D[1], X13
    FMOV  D20, X23
    FMOV  V20.D[1], X18
    FMOV  D21, X22
    FMOV  V21.D[1], X20
    FMOV  D22, X17
    FMOV  V22.D[1], X10
    FMOV  D23, X10
    FMOV  V23.D[1], X20
    FMOV  D24, X24
    FMOV  V24.D[1], X5
    FMOV  D25, X29
    FMOV  V25.D[1], X23
    FMOV  D26, X29
    FMOV  V26.D[1], X6
    FMOV  D27, X16
    FMOV  V27.D[1], X10
    FMOV  D28, X4
    FMOV  V28.D[1], X16
    FMOV  D29, X18
    FMOV  V29.D[1], X15
    FMOV  D30, X4
    FMOV  V30.D[1], X29
    FMOV  D31, X9
    FMOV  V31.D[1], X16
    MOVZ  X25, #0xf, LSL #0
TSRTFloatMinMax_label_20:
    FMAX  D11, D24, D29
    FMINNM  D3, D19, D30
    FMAXNM  S23, S31, S27
    FMINNM  S13, S21, S21
    FMINNM  D30, D26, D13
    FMINNM  S15, S30, S20
    FMINNM  D28, D11, D28
    FMAX  H29, H23, H28
    FMAX  S16, S3, S29
    FMIN  H16, H16, H16
    FMAXNM  H9, H15, H15
    FMIN  H15, H9, H16
    FMAX  S23, S15, S15
    FMAX  S9, S23, S23
    FMAX  D31, D9, D9
    FMAX  H30, H31, H31
    FMAXNM  S11, S30, S30
    FMAX  H20, H11, H11
    FMAX  S21, S20, S20
    FMINNM  S19, S3, S4
    FMIN  S11, S6, S13
    FMINNM  H3, H30, H3
    FMAXNM  D20, D3, D10
    FMINNM  H4, H12, H8
    FMAX  D13, D10, D29
    FMINNM  H26, H15, H14
    FMIN  S14, S8, S15
    FMIN  H29, H1, H23
    FMAXNM  S6, S21, S13
    FMAXNM  D27, D26, D6
    FMAXNM  D26, D20, D14
    FMINNM  D1, D19, D29
    FMAX  S20, S14, S1
    FMAX  S19, S4, S12
    FMAX  D10, D11, D11
    FMINNM  S21, S27, S27
    FMIN  D1, D26, D10
    FMIN  D27, D1, D21
    FMAXNM  S3, S27, S27
    FMAXNM  H8, H20, H3
    FMINNM  S15, S8, S19
    FMAX  D10, D4, D23
    FMAXNM  S26, S29, S29
    FMINNM  S6, S14, S24
    FMINNM  S19, S4, S4
    FMAX  S20, S28, S14
    FMAXNM  H1, H21, H26
    FMAX  S26, S22, S17
    FMIN  S8, S25, S23
    FMAX  H12, H24, H1
    FMAXNM  H13, H26, H19
    FMIN  D30, D27, D3
    FMAXNM  S25, S4, S3
    FMIN  H29, H30, H25
    FMAXNM  D11, D20, D15
    FMINNM  D2, D10, D13
    FMINNM  S26, S6, S8
    FMAXNM  H28, H12, H26
    FMAX  D13, D29, D2
    FMINNM  H25, H11, H11
    FMAX  S19, S25, S13
    FMAXNM  D3, D19, D29
    FMAX  H13, H28, H28
    FMIN  D29, D3, D13
    FMINNM  S1, S15, S27
    FMAX  D13, D26, D24
    FMAX  H14, H4, H29
    FMINNM  H28, H4, H4
    FMAX  D11, D26, D24
    FMINNM  D27, D2, D16
    FMAXNM  S30, S23, S16
    FMIN  D26, D26, D1
    FMAX  S23, S5, S7
    FMINNM  S4, S13, S14
    FMINNM  D10, D9, D14
    FMINNM  S13, S29, S26
    FMINNM  D8, D17, D6
    FMAXNM  H15, H30, H27
    FMAX  D14, D4, D23
    FMINNM  D9, D14, D14
    FMINNM  D26, D1, D28
    FMAXNM  D3, D26, D11
    FMIN  H2, H3, H10
    FMIN  H5, H15, H8
    FMAXNM  D15, D5, D5
    FMAX  S12, S9, S13
    FMAX  S19, S11, S2
    FMAX  S11, S15, S12
    FMAXNM  D14, D11, D15
    FMIN  S29, S19, S3
    FMIN  S12, S14, S14
    FMAXNM  D7, D12, D12
    FMAX  H23, H26, H29
    FMAX  S28, S23, S7
    FMAXNM  H11, H12, H16
    FMAX  H5, H28, H7
    FMINNM  H24, H1, H14
    FMAX  S13, S0, S31
    FMAX  S1, S1, S6
    FMAX  D17, D2, D7
    FMAXNM  S23, S31, S24
    FMIN  D16, D30, D29
    FMIN  D28, D16, D22
    FMINNM  D19, D5, D27
    FMAX  H12, H9, H6
    FMIN  S24, S5, S31
    FMAX  S8, S15, S17
    FMAX  H9, H13, H11
    FMAX  H0, H28, H8
    FMIN  D6, D0, D19
    FMAXNM  S27, S1, S9
    FMIN  H15, H6, H12
    FMAX  S14, S15, S24
    FMIN  S13, S27, S23
    FMIN  D31, D14, D14
    FMAX  S17, S13, S13
    FMAX  S11, S17, S21
    FMINNM  D5, D11, D11
    FMAXNM  S26, S31, S5
    FMIN  S13, S14, S9
    FMAXNM  H2, H8, H21
    FMAX  H7, H21, H22
    FMAX  S6, S0, S14
    FMAXNM  H14, H20, H14
    FMIN  H22, H27, H15
    FMAX  D23, D15, D22
    FMINNM  D28, D22, D16
    FMAX  H16, H7, H25
    FMAXNM  D24, D2, D6
    FMINNM  H17, H30, H19
    FMIN  D12, D6, D18
    FMAX  S9, S26, S24
    FMINNM  D1, D16, D16
    FMINNM  D5, D14, D17
    FMIN  H22, H13, H23
    FMAX  H31, H22, H18
    FMINNM  H27, H31, H9
    FMAX  S8, S12, S28
    FMAXNM  D20, D5, D27
    FMAXNM  H26, H25, H1
    FMAX  D11, D8, D8
    FMAX  D31, D20, D26
    FMINNM  S2, S31, S31
    FMINNM  S18, S2, S2
    FMIN  S21, S11, S27
    FMAX  D6, D31, D21
    FMIN  S26, S26, S6
    FMAX  D9, D26, D18
    FMINNM  S19, S16, S0
    FMAXNM  H12, H18, H14
    FMIN  D23, D27, D1
    FMAX  D30, D2, D1
    FMIN  D6, D25, D9
    FMAXNM  H16, H9, H9
    FMINNM  D28, D6, D0
    FMIN  S18, S13, S25
    FMINNM  S20, S22, S7
    FMAXNM  D14, D23, D13
    FMINNM  H23, H23, H15
    FMAXNM  H9, H23, H23
    FMINNM  H23, H9, H19
    FMAX  D17, D19, D23
    FMIN  D19, D14, D16
    FMIN  D11, D20, D17
    FMAXNM  D23, D30, D19
    FMAX  H1, H23, H20
    FMAXNM  D2, D18, D28
    FMINNM  S16, S12, S11
    FMINNM  S0, S16, S16
    FMINNM  D7, D1, D2
    FMAXNM  H15, H0, H7
    FMINNM  S18, S22, S18
    FMAX  H26, H27, H16
    FMAX  S20, S23, S15
    FMIN  D9, D9, D25
    FMINNM  S28, S31, S8
    FMINNM  S19, S4, S16
    FMAX  S7, S18, S31
    FMINNM  S6, S23, S6
    FMAX  H31, H21, H11
    FMAXNM  S15, S8, S11
    FMAXNM  S21, S31, S13
    FMAX  D0, D9, D21
    FMAXNM  S22, S7, S26
    FMIN  H21, H22, H0
    FMIN  H18, H6, H20
    FMINNM  D22, D18, D28
    FMINNM  H12, H19, H15
    FMAX  H1, H21, H12
    FMINNM  D4, D1, D1
    FMAX  S25, S22, S4
    FMIN  D18, D22, D16
    FMINNM  D22, D2, D7
    FMAXNM  S2, S14, S2
    FMAXNM  S20, S10, S31
    FMAXNM  D27, D9, D10
    FMAXNM  H28, H24, H12
    FMIN  H21, H2, H22
    FMIN  H11, H10, H12
    FMINNM  S7, S4, S27
    SUBS  X25, X25, #0x1
    B.NE  TSRTFloatMinMax_label_20
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x81, LSL #0
    MRS  X5, FPSR
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V0.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D0
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V1.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D1
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V2.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D2
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V3.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D3
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V4.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D4
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V5.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D5
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V6.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D6
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V7.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D7
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V8.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D8
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V9.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D9
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D10
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D11
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D12
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V13.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D13
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D14
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D15
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D16
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V17.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D17
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V18.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D18
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V19.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D19
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D20
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D21
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V22.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D22
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D23
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V24.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D24
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D25
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D26
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D27
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V28.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D28
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V29.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D29
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D30
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X5, D31
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMinMax_TestFail

TSRTFloatMinMax_TestEnd:
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
TSRTFloatMinMax_TestFail:
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
