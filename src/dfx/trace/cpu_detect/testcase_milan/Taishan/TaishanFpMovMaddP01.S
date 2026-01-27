.global TaishanFpMovMaddP01

.text
.p2align 4

TaishanFpMovMaddP01:

TaishanFpMovMaddP01_TestBegin:
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
    MOVK  X2, #0xd2f7, LSL #48
    MOVK  X2, #0xae5c, LSL #32
    MOVK  X2, #0xe616, LSL #16
    MOVK  X2, #0xea77, LSL #0
    MOVK  X3, #0x2da0, LSL #48
    MOVK  X3, #0xc15b, LSL #32
    MOVK  X3, #0x9434, LSL #16
    MOVK  X3, #0xd8a6, LSL #0
    MOVK  X4, #0xce7e, LSL #48
    MOVK  X4, #0xd22b, LSL #32
    MOVK  X4, #0x4be3, LSL #16
    MOVK  X4, #0x2e4, LSL #0
    MOVK  X5, #0x8a46, LSL #48
    MOVK  X5, #0xa1c6, LSL #32
    MOVK  X5, #0x6a9c, LSL #16
    MOVK  X5, #0xd46a, LSL #0
    MOVK  X6, #0x503, LSL #48
    MOVK  X6, #0x40e7, LSL #32
    MOVK  X6, #0x6f49, LSL #16
    MOVK  X6, #0xab43, LSL #0
    MOVK  X7, #0x155c, LSL #48
    MOVK  X7, #0xc22, LSL #32
    MOVK  X7, #0x38a4, LSL #16
    MOVK  X7, #0xd810, LSL #0
    MOVK  X8, #0x27fc, LSL #48
    MOVK  X8, #0x514a, LSL #32
    MOVK  X8, #0xc59c, LSL #16
    MOVK  X8, #0x591b, LSL #0
    MOVK  X9, #0xe2cf, LSL #48
    MOVK  X9, #0x5705, LSL #32
    MOVK  X9, #0x8470, LSL #16
    MOVK  X9, #0x3b82, LSL #0
    MOVK  X10, #0x4b7, LSL #48
    MOVK  X10, #0xce43, LSL #32
    MOVK  X10, #0xc0e2, LSL #16
    MOVK  X10, #0xb679, LSL #0
    MOVK  X11, #0xd5d2, LSL #48
    MOVK  X11, #0x63bf, LSL #32
    MOVK  X11, #0x47be, LSL #16
    MOVK  X11, #0x9617, LSL #0
    MOVK  X13, #0xf7ad, LSL #48
    MOVK  X13, #0xb7b6, LSL #32
    MOVK  X13, #0x2580, LSL #16
    MOVK  X13, #0x5164, LSL #0
    MOVK  X14, #0xb645, LSL #48
    MOVK  X14, #0x7c73, LSL #32
    MOVK  X14, #0xeda2, LSL #16
    MOVK  X14, #0xc637, LSL #0
    MOVK  X15, #0x77f6, LSL #48
    MOVK  X15, #0xb660, LSL #32
    MOVK  X15, #0x6f30, LSL #16
    MOVK  X15, #0xa604, LSL #0
    MOVK  X16, #0x84fc, LSL #48
    MOVK  X16, #0x5ee3, LSL #32
    MOVK  X16, #0xba61, LSL #16
    MOVK  X16, #0xad82, LSL #0
    MOVK  X17, #0x85cd, LSL #48
    MOVK  X17, #0xe405, LSL #32
    MOVK  X17, #0x1661, LSL #16
    MOVK  X17, #0x722f, LSL #0
    MOVK  X18, #0x5364, LSL #48
    MOVK  X18, #0x22b, LSL #32
    MOVK  X18, #0x1cf8, LSL #16
    MOVK  X18, #0xa33d, LSL #0
    MOVK  X19, #0xab87, LSL #48
    MOVK  X19, #0xd2dc, LSL #32
    MOVK  X19, #0x9d93, LSL #16
    MOVK  X19, #0xf919, LSL #0
    MOVK  X20, #0x9a89, LSL #48
    MOVK  X20, #0xa6b8, LSL #32
    MOVK  X20, #0x6399, LSL #16
    MOVK  X20, #0xc9d8, LSL #0
    MOVK  X21, #0xab01, LSL #48
    MOVK  X21, #0x1c, LSL #32
    MOVK  X21, #0x1f57, LSL #16
    MOVK  X21, #0x175d, LSL #0
    MOVK  X22, #0x8427, LSL #48
    MOVK  X22, #0x7a2c, LSL #32
    MOVK  X22, #0x49a4, LSL #16
    MOVK  X22, #0xf98, LSL #0
    MOVK  X23, #0x78e2, LSL #48
    MOVK  X23, #0xdfef, LSL #32
    MOVK  X23, #0xeaf3, LSL #16
    MOVK  X23, #0xe530, LSL #0
    MOVK  X24, #0xc14, LSL #48
    MOVK  X24, #0xcaf3, LSL #32
    MOVK  X24, #0xcbce, LSL #16
    MOVK  X24, #0x2303, LSL #0
    MOVK  X25, #0x4036, LSL #48
    MOVK  X25, #0x3428, LSL #32
    MOVK  X25, #0x787a, LSL #16
    MOVK  X25, #0x1f90, LSL #0
    MOVK  X26, #0xb39d, LSL #48
    MOVK  X26, #0x63b8, LSL #32
    MOVK  X26, #0x5ec4, LSL #16
    MOVK  X26, #0x3168, LSL #0
    MOVK  X27, #0xe440, LSL #48
    MOVK  X27, #0xbfed, LSL #32
    MOVK  X27, #0xf829, LSL #16
    MOVK  X27, #0xac0e, LSL #0
    MOVK  X28, #0xa1d4, LSL #48
    MOVK  X28, #0x4418, LSL #32
    MOVK  X28, #0xc575, LSL #16
    MOVK  X28, #0xf2b, LSL #0
    MOVK  X29, #0x8878, LSL #48
    MOVK  X29, #0x1817, LSL #32
    MOVK  X29, #0xd72f, LSL #16
    MOVK  X29, #0x19dc, LSL #0
    ANDS  X25, X29, X27, LSR #34
    MOVZ  X13, #0xb9db, LSL #0
    MOVK  X13, #0xbbda, LSL #16
    MSR  FPCR, X13
    MRS  X9, FPSR
    MOVZ  X15, #0xff60, LSL #0
    MOVK  X15, #0x7ff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    AND  X9, X9, X15
    MOVZ  X15, #0x0, LSL #0
    ORR  X9, X9, X15
    MSR  FPSR, X9
    ISB  SY
    MOVZ  X2, #0xc345, LSL #0
    MOVK  X2, #0xd085, LSL #16
    MOVK  X2, #0xe715, LSL #32
    MOVK  X2, #0x25c1, LSL #48
    MOVZ  X3, #0x83b4, LSL #0
    MOVK  X3, #0x77f6, LSL #16
    MOVK  X3, #0x3fc, LSL #32
    MOVK  X3, #0xfc53, LSL #48
    MOVZ  X4, #0xa71f, LSL #0
    MOVK  X4, #0xbdfc, LSL #16
    MOVK  X4, #0x38f1, LSL #32
    MOVK  X4, #0x61ec, LSL #48
    MOVZ  X5, #0xd9a8, LSL #0
    MOVK  X5, #0x9c47, LSL #16
    MOVK  X5, #0x8abf, LSL #32
    MOVK  X5, #0x3649, LSL #48
    MOVZ  X6, #0x6400, LSL #0
    MOVK  X6, #0x6aa4, LSL #16
    MOVK  X6, #0x4634, LSL #32
    MOVK  X6, #0x3ef7, LSL #48
    MOVZ  X7, #0xf663, LSL #0
    MOVK  X7, #0x13e5, LSL #16
    MOVK  X7, #0xb8d1, LSL #32
    MOVK  X7, #0x5ca, LSL #48
    MOVZ  X8, #0x1d51, LSL #0
    MOVK  X8, #0x7189, LSL #16
    MOVK  X8, #0x4d14, LSL #32
    MOVK  X8, #0xbf1c, LSL #48
    MOVZ  X9, #0xf876, LSL #0
    MOVK  X9, #0x7b88, LSL #16
    MOVK  X9, #0x44af, LSL #32
    MOVK  X9, #0x6014, LSL #48
    MOVZ  X10, #0x8c15, LSL #0
    MOVK  X10, #0xc20d, LSL #16
    MOVK  X10, #0x1d71, LSL #32
    MOVK  X10, #0x7140, LSL #48
    MOVZ  X11, #0xd287, LSL #0
    MOVK  X11, #0xf54b, LSL #16
    MOVK  X11, #0xf529, LSL #32
    MOVK  X11, #0xc1bf, LSL #48
    MOVZ  X13, #0xcb83, LSL #0
    MOVK  X13, #0xe4bf, LSL #16
    MOVK  X13, #0x5f55, LSL #32
    MOVK  X13, #0xb962, LSL #48
    MOVZ  X14, #0x266, LSL #0
    MOVK  X14, #0x6697, LSL #16
    MOVK  X14, #0x831c, LSL #32
    MOVK  X14, #0x1dc1, LSL #48
    MOVZ  X15, #0xe819, LSL #0
    MOVK  X15, #0x1265, LSL #16
    MOVK  X15, #0x5a34, LSL #32
    MOVK  X15, #0x3bb, LSL #48
    MOVZ  X16, #0xe147, LSL #0
    MOVK  X16, #0xf686, LSL #16
    MOVK  X16, #0x351c, LSL #32
    MOVK  X16, #0xe492, LSL #48
    MOVZ  X17, #0x64a8, LSL #0
    MOVK  X17, #0xe495, LSL #16
    MOVK  X17, #0x661, LSL #32
    MOVK  X17, #0x722, LSL #48
    MOVZ  X18, #0x7a27, LSL #0
    MOVK  X18, #0xb07b, LSL #16
    MOVK  X18, #0xc2c0, LSL #32
    MOVK  X18, #0x7040, LSL #48
    MOVZ  X19, #0xf3b1, LSL #0
    MOVK  X19, #0x4d39, LSL #16
    MOVK  X19, #0x16fa, LSL #32
    MOVK  X19, #0x69b1, LSL #48
    MOVZ  X20, #0x41c4, LSL #0
    MOVK  X20, #0x43b1, LSL #16
    MOVK  X20, #0x58d0, LSL #32
    MOVK  X20, #0xd90d, LSL #48
    MOVZ  X21, #0xe101, LSL #0
    MOVK  X21, #0xe8c4, LSL #16
    MOVK  X21, #0xa58c, LSL #32
    MOVK  X21, #0x69c1, LSL #48
    MOVZ  X22, #0xf0a4, LSL #0
    MOVK  X22, #0x1a25, LSL #16
    MOVK  X22, #0x7305, LSL #32
    MOVK  X22, #0x52ee, LSL #48
    MOVZ  X23, #0x1df, LSL #0
    MOVK  X23, #0x2b3b, LSL #16
    MOVK  X23, #0xc35b, LSL #32
    MOVK  X23, #0x3cd4, LSL #48
    MOVZ  X24, #0xf053, LSL #0
    MOVK  X24, #0xa99, LSL #16
    MOVK  X24, #0x3f7f, LSL #32
    MOVK  X24, #0x8345, LSL #48
    MOVZ  X25, #0xce79, LSL #0
    MOVK  X25, #0x2a49, LSL #16
    MOVK  X25, #0x84f, LSL #32
    MOVK  X25, #0x2136, LSL #48
    MOVZ  X26, #0x90e1, LSL #0
    MOVK  X26, #0x75d3, LSL #16
    MOVK  X26, #0xc73e, LSL #32
    MOVK  X26, #0xe39, LSL #48
    MOVZ  X27, #0x6f66, LSL #0
    MOVK  X27, #0x4b26, LSL #16
    MOVK  X27, #0xf7e9, LSL #32
    MOVK  X27, #0x32d3, LSL #48
    MOVZ  X28, #0x6e90, LSL #0
    MOVK  X28, #0x155c, LSL #16
    MOVK  X28, #0xf690, LSL #32
    MOVK  X28, #0xb6af, LSL #48
    MOVZ  X29, #0x8e8d, LSL #0
    MOVK  X29, #0x78a3, LSL #16
    MOVK  X29, #0xcbde, LSL #32
    MOVK  X29, #0x4dee, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X21
    FMOV  D1, X29
    FMOV  V1.D[1], X15
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X21
    FMOV  V3.D[1], X19
    FMOV  D4, X20
    FMOV  V4.D[1], X9
    FMOV  D5, X21
    FMOV  V5.D[1], X24
    FMOV  D6, X7
    FMOV  V6.D[1], X4
    FMOV  D7, X22
    FMOV  V7.D[1], X10
    FMOV  D8, X6
    FMOV  V8.D[1], X23
    FMOV  D9, X23
    FMOV  V9.D[1], X8
    FMOV  D10, X8
    FMOV  V10.D[1], X19
    FMOV  D11, X22
    FMOV  V11.D[1], X8
    FMOV  D12, X26
    FMOV  V12.D[1], X6
    FMOV  D13, X28
    FMOV  V13.D[1], X28
    FMOV  D14, X22
    FMOV  V14.D[1], X4
    FMOV  D15, X21
    FMOV  V15.D[1], X22
    FMOV  D16, X10
    FMOV  V16.D[1], X6
    FMOV  D17, X19
    FMOV  V17.D[1], X9
    FMOV  D18, X19
    FMOV  V18.D[1], X22
    FMOV  D19, X5
    FMOV  V19.D[1], X21
    FMOV  D20, X13
    FMOV  V20.D[1], X26
    FMOV  D21, X24
    FMOV  V21.D[1], X19
    FMOV  D22, X18
    FMOV  V22.D[1], X18
    FMOV  D23, X28
    FMOV  V23.D[1], X13
    FMOV  D24, X10
    FMOV  V24.D[1], X5
    FMOV  D25, X13
    FMOV  V25.D[1], X6
    FMOV  D26, X28
    FMOV  V26.D[1], X2
    FMOV  D27, X27
    FMOV  V27.D[1], X4
    FMOV  D28, X11
    FMOV  V28.D[1], X4
    FMOV  D29, X9
    FMOV  V29.D[1], X22
    FMOV  D30, X24
    FMOV  V30.D[1], X10
    FMOV  D31, X2
    FMOV  V31.D[1], X13
    MOVZ  X11, #0xa, LSL #0
TaishanFpMovMaddP01_label_0:
    FMAXNM  S23, S0, S9
    FMAXNM  H21, H2, H6
    FMINNM  D23, D16, D31
    FMAXNM  H24, H30, H22
    FMINNM  S21, S14, S30
    FMAXNM  S6, S21, S5
    FMIN  S20, S30, S27
    FMAX  D4, D29, D28
    FMAXNM  D29, D18, D4
    FMAX  D28, D6, D23
    FMAXNM  D26, D16, D18
    FMIN  H20, H22, H12
    FMAXNM  S13, S22, S24
    FMIN  D21, D27, D5
    FMAXNM  H15, H20, H6
    FMAX  D5, D14, D26
    FMINNM  S31, S23, S17
    FMAX  S3, S31, S10
    FMAXNM  D21, D4, D10
    FMINNM  D30, D4, D10
    FMAXNM  S9, S0, S21
    FMAX  H8, H25, H22
    FMAXNM  D17, D3, D13
    FMAXNM  H10, H8, H10
    FMIN  D3, D8, D2
    FMAXNM  S13, S5, S3
    FMINNM  H23, H25, H14
    FMAXNM  H17, H9, H18
    FMAX  H13, H25, H14
    FMAX  S29, S2, S12
    FMINNM  D24, D29, D10
    FMAX  D22, D22, D11
    FMIN  D29, D9, D20
    FMIN  D9, D18, D19
    FMAX  H17, H10, H30
    FMINNM  D1, D0, D28
    FMAXNM  H11, H30, H14
    FMAX  H4, H21, H1
    FMAXNM  H3, H21, H29
    FMIN  S20, S2, S24
    FMAX  D23, D29, D2
    FMAXNM  S3, S16, S27
    FMINNM  D12, D17, D5
    FMAX  H23, H23, H11
    FMIN  S15, S30, S19
    FMIN  S30, S8, S11
    FMAX  S4, S29, S14
    FMAX  S5, S8, S7
    FMINNM  S13, S30, S20
    FMAX  H8, H9, H15
    FMINNM  S24, S7, S23
    FMAXNM  H9, H2, H1
    FMAXNM  S5, S28, S21
    FMIN  S22, S9, S24
    FMAX  S16, S27, S19
    FMAXNM  D15, D5, D17
    FMAX  H8, H9, H31
    FMINNM  S5, S4, S15
    FMINNM  D20, D6, D5
    FMINNM  S0, S9, S16
    FMAXNM  H21, H15, H3
    FMIN  H7, H27, H22
    FMIN  H4, H12, H4
    FMAX  H2, H28, H27
    FMAXNM  H24, H2, H6
    FMAX  S11, S7, S4
    FMINNM  H12, H3, H14
    FMIN  H0, H28, H6
    FMINNM  D19, D20, D4
    FMINNM  D24, D12, D11
    FMIN  H14, H8, H26
    FMAXNM  S3, S25, S19
    FMAX  D5, D19, D0
    FMINNM  S7, S7, S14
    FMINNM  H20, H5, H10
    FMAXNM  D3, D14, D5
    FMAX  S13, S21, S16
    FMAXNM  D27, D13, D24
    FMINNM  H26, H8, H24
    FMIN  S29, S15, S17
    FMAX  S23, S12, S27
    FMIN  S16, S0, S0
    FMAX  D16, D7, D12
    FMAXNM  D12, D31, D19
    FMAX  D23, D31, D12
    FMAXNM  S10, S29, S1
    FMAX  D17, D3, D3
    FMIN  S6, S20, S20
    FMAXNM  H27, H4, H24
    FMINNM  S27, S7, S22
    FMIN  H22, H27, H24
    FMAXNM  H22, H27, H26
    FMINNM  D4, D10, D20
    FMINNM  S8, S31, S4
    FMAX  H17, H11, H17
    FMIN  H22, H21, H10
    FMAXNM  S13, S16, S11
    FMINNM  D24, D6, D27
    FMINNM  S23, S11, S12
    FMIN  D26, D8, D22
    FMAX  D22, D14, D27
    FMAXNM  S22, S10, S4
    FMAXNM  S24, S7, S22
    FMAXNM  D8, D24, D27
    FMIN  S2, S20, S23
    FMAXNM  S1, S15, S3
    FMAXNM  S27, S24, S15
    FMINNM  D22, D0, D8
    FMAXNM  D6, D26, D13
    FMINNM  D14, D12, D6
    FMAXNM  S28, S18, S21
    FMINNM  D10, D15, D25
    FMAXNM  H2, H31, H1
    FMAXNM  S10, S31, S29
    FMAX  H30, H27, H12
    FMINNM  H4, H10, H14
    FMINNM  D14, D28, D16
    FMINNM  D24, D4, D2
    FMAX  H2, H1, H24
    FMAX  D27, D26, D15
    FMAX  S30, S3, S11
    FMINNM  S31, S23, S0
    FMINNM  H1, H31, H18
    FMIN  S30, S29, S10
    FMINNM  H7, H29, H28
    FMINNM  D19, D26, D17
    FMIN  S28, S19, S11
    FMAX  D5, D28, D19
    FMINNM  S23, S13, S7
    FMINNM  H2, H29, H1
    FMAXNM  D21, D21, D19
    FMAX  S27, S25, S4
    FMIN  S23, S10, S4
    FMINNM  H7, H2, H27
    FMAX  S7, S26, S31
    FMINNM  H0, H12, H7
    FMAXNM  D21, D18, D30
    FMINNM  H31, H10, H28
    FMIN  D23, D9, D4
    FMAX  D28, D18, D3
    FMAXNM  D5, D0, D26
    FMAXNM  H21, H21, H26
    FMAX  H4, H7, H14
    FMINNM  S18, S5, S25
    FMINNM  S4, S20, S20
    FMINNM  H28, H0, H26
    FMINNM  H8, H1, H1
    FMAXNM  S28, S3, S0
    FMAX  S8, S24, S9
    FMIN  D0, D22, D2
    FMAX  S4, S10, S2
    FMINNM  H27, H30, H5
    FMAXNM  H12, H0, H21
    FMAXNM  S31, S19, S18
    FMAXNM  H16, H27, H11
    FMIN  H29, H29, H4
    FMINNM  D29, D27, D16
    FMINNM  S7, S12, S23
    FMAXNM  S8, S28, S11
    FMAXNM  H21, H31, H18
    FMINNM  D23, D22, D16
    FMINNM  D22, D24, D13
    FMAXNM  S4, S27, S2
    FMIN  D4, D31, D19
    FMAXNM  S31, S31, S7
    FMAX  D5, D14, D30
    FMIN  D5, D13, D0
    FMIN  S4, S13, S13
    FMINNM  D18, D27, D15
    FMAXNM  H14, H17, H29
    FMINNM  D21, D23, D23
    FMINNM  D4, D24, D1
    FMAXNM  H24, H18, H5
    FMAX  H18, H7, H0
    FMIN  S0, S14, S30
    FMINNM  H30, H17, H8
    FMAXNM  S11, S20, S8
    FMINNM  S19, S31, S17
    FMIN  D11, D16, D16
    FMINNM  D30, D29, D20
    FMIN  H13, H18, H30
    FMINNM  D11, D24, D13
    FMAX  S8, S17, S21
    FMIN  S6, S8, S29
    FMIN  S23, S6, S13
    FMIN  S24, S0, S19
    FMINNM  H17, H23, H18
    FMAX  H24, H1, H14
    FMIN  D4, D14, D8
    FMAX  D24, D7, D4
    FMINNM  S31, S18, S16
    FMIN  S16, S4, S9
    FMIN  H8, H17, H30
    FMAXNM  H14, H3, H21
    FMIN  D10, D1, D30
    FMAXNM  S7, S13, S18
    FMAX  D7, D16, D29
    FMAX  S0, S23, S3
    FMAXNM  H24, H25, H11
    FMIN  D4, D4, D13
    SUBS  X11, X11, #0x1
    B.NE  TaishanFpMovMaddP01_label_0
    MOVZ  X15, #0xc345, LSL #0
    MOVK  X15, #0xd085, LSL #16
    MOVK  X15, #0xe715, LSL #32
    MOVK  X15, #0x25c1, LSL #48
    SUB  X26, X15, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x83b4, LSL #0
    MOVK  X5, #0x77f6, LSL #16
    MOVK  X5, #0x3fc, LSL #32
    MOVK  X5, #0xfc53, LSL #48
    SUB  X16, X5, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0xa71f, LSL #0
    MOVK  X3, #0xbdfc, LSL #16
    MOVK  X3, #0x38f1, LSL #32
    MOVK  X3, #0x61ec, LSL #48
    SUB  X27, X3, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x83b4, LSL #0
    MOVK  X26, #0x77f6, LSL #16
    MOVK  X26, #0x3fc, LSL #32
    MOVK  X26, #0xfc53, LSL #48
    SUB  X22, X26, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x6400, LSL #0
    MOVK  X3, #0x6aa4, LSL #16
    MOVK  X3, #0x4634, LSL #32
    MOVK  X3, #0x3ef7, LSL #48
    SUB  X10, X3, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0xf663, LSL #0
    MOVK  X22, #0x13e5, LSL #16
    MOVK  X22, #0xb8d1, LSL #32
    MOVK  X22, #0x5ca, LSL #48
    SUB  X25, X22, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x1d51, LSL #0
    MOVK  X6, #0x7189, LSL #16
    MOVK  X6, #0x4d14, LSL #32
    MOVK  X6, #0xbf1c, LSL #48
    SUB  X2, X6, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0xf876, LSL #0
    MOVK  X8, #0x7b88, LSL #16
    MOVK  X8, #0x44af, LSL #32
    MOVK  X8, #0x6014, LSL #48
    SUB  X18, X8, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0xcb83, LSL #0
    MOVK  X14, #0xe4bf, LSL #16
    MOVK  X14, #0x5f55, LSL #32
    MOVK  X14, #0xb962, LSL #48
    SUB  X15, X14, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0xcb83, LSL #0
    MOVK  X23, #0xe4bf, LSL #16
    MOVK  X23, #0x5f55, LSL #32
    MOVK  X23, #0xb962, LSL #48
    SUB  X11, X23, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x41c4, LSL #0
    MOVK  X8, #0x43b1, LSL #16
    MOVK  X8, #0x58d0, LSL #32
    MOVK  X8, #0xd90d, LSL #48
    SUB  X14, X8, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0xe101, LSL #0
    MOVK  X6, #0xe8c4, LSL #16
    MOVK  X6, #0xa58c, LSL #32
    MOVK  X6, #0x69c1, LSL #48
    SUB  X9, X6, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x6e90, LSL #0
    MOVK  X22, #0x155c, LSL #16
    MOVK  X22, #0xf690, LSL #32
    MOVK  X22, #0xb6af, LSL #48
    SUB  X29, X22, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X22, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D5
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D7
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D13
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D14
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D15
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X9, #0x6400, LSL #0
    MOVK  X9, #0x6aa4, LSL #16
    MOVK  X9, #0x4634, LSL #32
    MOVK  X9, #0x3ef7, LSL #48
    SUB  X15, X9, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D25
    MOVZ  X9, #0xcb83, LSL #0
    MOVK  X9, #0xe4bf, LSL #16
    MOVK  X9, #0x5f55, LSL #32
    MOVK  X9, #0xb962, LSL #48
    SUB  X15, X9, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X29
    FMOV  V0.D[1], X9
    FMOV  D1, X14
    FMOV  V1.D[1], X29
    FMOV  D2, X17
    FMOV  V2.D[1], X19
    FMOV  D3, X22
    FMOV  V3.D[1], X14
    FMOV  D4, X17
    FMOV  V4.D[1], X25
    FMOV  D5, X5
    FMOV  V5.D[1], X8
    FMOV  D6, X28
    FMOV  V6.D[1], X27
    FMOV  D7, X24
    FMOV  V7.D[1], X7
    FMOV  D8, X17
    FMOV  V8.D[1], X24
    FMOV  D9, X18
    FMOV  V9.D[1], X27
    FMOV  D10, X27
    FMOV  V10.D[1], X23
    FMOV  D11, X9
    FMOV  V11.D[1], X14
    FMOV  D12, X13
    FMOV  V12.D[1], X8
    FMOV  D13, X21
    FMOV  V13.D[1], X8
    FMOV  D14, X13
    FMOV  V14.D[1], X23
    FMOV  D15, X9
    FMOV  V15.D[1], X20
    FMOV  D16, X28
    FMOV  V16.D[1], X23
    FMOV  D17, X27
    FMOV  V17.D[1], X28
    FMOV  D18, X24
    FMOV  V18.D[1], X3
    FMOV  D19, X27
    FMOV  V19.D[1], X6
    FMOV  D20, X27
    FMOV  V20.D[1], X7
    FMOV  D21, X8
    FMOV  V21.D[1], X2
    FMOV  D22, X3
    FMOV  V22.D[1], X21
    FMOV  D23, X6
    FMOV  V23.D[1], X24
    FMOV  D24, X2
    FMOV  V24.D[1], X13
    FMOV  D25, X29
    FMOV  V25.D[1], X9
    FMOV  D26, X25
    FMOV  V26.D[1], X5
    FMOV  D27, X15
    FMOV  V27.D[1], X4
    FMOV  D28, X19
    FMOV  V28.D[1], X21
    FMOV  D29, X21
    FMOV  V29.D[1], X25
    FMOV  D30, X29
    FMOV  V30.D[1], X19
    FMOV  D31, X23
    FMOV  V31.D[1], X26
    MOVZ  X5, #0xa, LSL #0
TaishanFpMovMaddP01_label_83:
    FMAX  D19, D31, D23
    FMAXNM  S21, S21, S13
    FMAXNM  D15, D13, D25
    FMAXNM  D2, D26, D7
    FMAXNM  D29, D13, D22
    FMIN  D5, D13, D19
    FMIN  S14, S2, S26
    FMAXNM  S24, S0, S11
    FMAX  S18, S8, S19
    FMAXNM  H29, H26, H30
    FMIN  H13, H17, H8
    FMINNM  D19, D4, D16
    FMAXNM  D17, D9, D15
    FMIN  D31, D17, D5
    FMAX  H16, H30, H9
    FMINNM  D3, D15, D13
    FMAXNM  S29, S8, S16
    FMINNM  S14, S0, S26
    FMIN  S15, S17, S22
    FMAX  S2, S21, S5
    FMAXNM  D8, D4, D19
    FMAX  H16, H0, H11
    FMAXNM  S9, S24, S31
    FMINNM  S14, S13, S30
    FMAXNM  H19, H16, H21
    FMAX  H2, H15, H28
    FMINNM  D9, D6, D20
    FMIN  S20, S26, S1
    FMAX  S3, S1, S19
    FMIN  D17, D6, D4
    FMAX  D5, D17, D0
    FMAX  D4, D1, D18
    FMAXNM  H9, H1, H13
    FMAXNM  H28, H20, H1
    FMINNM  H21, H14, H25
    FMIN  D25, D2, D11
    FMIN  S17, S16, S30
    FMAX  D0, D6, D0
    FMAX  D30, D26, D27
    FMAX  S17, S3, S4
    FMIN  S23, S15, S25
    FMAXNM  H18, H8, H2
    FMAXNM  H31, H27, H30
    FMAXNM  H23, H31, H3
    FMIN  H3, H19, H25
    FMIN  S26, S30, S14
    FMAX  H29, H16, H13
    FMIN  H20, H1, H14
    FMAXNM  D5, D18, D20
    FMIN  H24, H4, H7
    FMIN  S15, S29, S27
    FMINNM  H26, H18, H5
    FMAXNM  S24, S8, S5
    FMAX  H15, H17, H13
    FMINNM  H26, H17, H23
    FMINNM  D7, D24, D0
    FMAXNM  D24, D30, D15
    FMAXNM  H16, H0, H18
    FMIN  D4, D14, D27
    FMINNM  H22, H7, H10
    FMAXNM  H4, H19, H0
    FMAXNM  S25, S11, S4
    FMIN  S17, S24, S29
    FMIN  H15, H3, H16
    FMAXNM  S5, S7, S24
    FMINNM  D24, D28, D22
    FMIN  D26, D12, D11
    FMAXNM  H0, H16, H28
    FMIN  H25, H24, H10
    FMAX  D8, D5, D0
    FMAXNM  S18, S17, S26
    FMINNM  D30, D16, D23
    FMAX  H4, H30, H16
    FMAX  H11, H28, H19
    FMAXNM  H4, H25, H29
    FMIN  S20, S21, S15
    FMAX  S29, S12, S20
    FMAXNM  D20, D6, D2
    FMINNM  D28, D25, D22
    FMINNM  H17, H1, H28
    FMAXNM  H11, H13, H10
    FMIN  D21, D16, D29
    FMAXNM  S26, S16, S18
    FMINNM  S19, S13, S31
    FMINNM  S20, S7, S30
    FMAX  S23, S9, S6
    FMAXNM  S8, S22, S13
    FMAX  S15, S20, S17
    FMAXNM  D9, D24, D18
    FMINNM  H15, H20, H26
    FMAX  H14, H4, H5
    FMAXNM  D14, D28, D15
    FMAX  S18, S16, S11
    FMAXNM  S24, S6, S21
    FMAXNM  S4, S16, S10
    FMAX  S8, S10, S0
    FMAXNM  D8, D5, D10
    FMIN  H8, H26, H8
    FMAXNM  D31, D25, D15
    FMINNM  S14, S8, S17
    FMINNM  D23, D18, D22
    FMIN  D23, D20, D11
    FMAX  S31, S14, S8
    FMINNM  S19, S1, S17
    FMIN  H15, H9, H15
    FMAXNM  S31, S3, S30
    FMIN  D2, D6, D18
    FMIN  H12, H19, H29
    FMINNM  D8, D19, D23
    FMAXNM  S16, S9, S2
    FMINNM  D29, D11, D4
    FMIN  S7, S17, S11
    FMINNM  S17, S1, S31
    FMINNM  D9, D13, D23
    FMIN  S5, S14, S18
    FMAXNM  H21, H11, H4
    FMAX  S23, S22, S5
    FMIN  D18, D8, D9
    FMAX  S3, S8, S21
    FMAX  H24, H17, H18
    FMAX  D14, D14, D3
    FMAXNM  H27, H21, H8
    FMINNM  D7, D4, D8
    FMAX  S3, S7, S7
    FMIN  D12, D16, D25
    FMAXNM  H26, H27, H21
    FMAX  D26, D12, D22
    FMINNM  S24, S19, S23
    FMAX  S17, S26, S11
    FMAX  H24, H28, H29
    FMAXNM  S3, S31, S15
    FMINNM  D1, D5, D9
    FMINNM  D24, D10, D14
    FMAX  H24, H20, H15
    FMAX  D12, D29, D0
    FMIN  D11, D10, D24
    FMINNM  S17, S17, S17
    FMAX  S3, S12, S31
    FMAX  D7, D18, D21
    FMIN  H10, H1, H26
    FMAX  S19, S11, S10
    FMAX  D7, D25, D11
    FMINNM  S22, S26, S9
    FMAX  H19, H29, H7
    FMINNM  H23, H31, H13
    FMINNM  S14, S17, S1
    FMAX  H0, H28, H13
    FMAXNM  S13, S8, S25
    FMINNM  H17, H12, H25
    FMAXNM  H23, H12, H26
    FMAX  D13, D0, D21
    FMIN  D23, D24, D25
    FMINNM  H15, H15, H17
    FMAX  D2, D24, D8
    FMAX  S23, S24, S14
    FMAX  S14, S2, S21
    FMINNM  S22, S19, S13
    FMINNM  H3, H3, H2
    FMIN  H27, H12, H31
    FMIN  H28, H10, H1
    FMINNM  H28, H19, H22
    FMINNM  H15, H28, H7
    FMIN  S23, S23, S25
    FMINNM  S29, S17, S24
    FMINNM  D23, D8, D24
    FMINNM  D13, D31, D13
    FMINNM  S14, S7, S29
    FMINNM  H31, H10, H22
    FMAXNM  S15, S15, S19
    FMIN  D18, D28, D23
    FMAX  D27, D27, D2
    FMAXNM  S26, S25, S30
    FMAXNM  H3, H8, H3
    FMINNM  S0, S13, S13
    FMINNM  S17, S23, S10
    FMAXNM  D27, D25, D24
    FMAXNM  S25, S19, S27
    FMAX  S31, S14, S26
    FMAX  H25, H31, H12
    FMIN  H1, H31, H25
    FMAX  S30, S17, S18
    FMINNM  S0, S25, S1
    FMAXNM  H25, H16, H22
    FMAXNM  S3, S21, S17
    FMIN  S24, S5, S29
    FMINNM  S15, S11, S0
    FMIN  S4, S8, S26
    FMAXNM  S1, S14, S8
    FMAX  S21, S15, S22
    FMAXNM  H31, H9, H7
    FMAXNM  H18, H30, H31
    FMINNM  H30, H3, H6
    FMINNM  H10, H17, H5
    FMIN  H30, H28, H12
    FMAX  S30, S24, S7
    FMINNM  D7, D3, D17
    FMAXNM  H10, H29, H30
    FMIN  S4, S31, S28
    FMAX  D5, D0, D25
    FMINNM  S3, S18, S16
    SUBS  X5, X5, #0x1
    B.NE  TaishanFpMovMaddP01_label_83
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D19
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X6
    FMOV  D1, X6
    FMOV  V1.D[1], X4
    FMOV  D2, X29
    FMOV  V2.D[1], X20
    FMOV  D3, X26
    FMOV  V3.D[1], X27
    FMOV  D4, X25
    FMOV  V4.D[1], X23
    FMOV  D5, X24
    FMOV  V5.D[1], X14
    FMOV  D6, X29
    FMOV  V6.D[1], X19
    FMOV  D7, X9
    FMOV  V7.D[1], X16
    FMOV  D8, X4
    FMOV  V8.D[1], X26
    FMOV  D9, X10
    FMOV  V9.D[1], X7
    FMOV  D10, X6
    FMOV  V10.D[1], X25
    FMOV  D11, X6
    FMOV  V11.D[1], X8
    FMOV  D12, X25
    FMOV  V12.D[1], X29
    FMOV  D13, X10
    FMOV  V13.D[1], X10
    FMOV  D14, X20
    FMOV  V14.D[1], X9
    FMOV  D15, X14
    FMOV  V15.D[1], X23
    FMOV  D16, X21
    FMOV  V16.D[1], X19
    FMOV  D17, X29
    FMOV  V17.D[1], X18
    FMOV  D18, X4
    FMOV  V18.D[1], X2
    FMOV  D19, X18
    FMOV  V19.D[1], X8
    FMOV  D20, X13
    FMOV  V20.D[1], X2
    FMOV  D21, X2
    FMOV  V21.D[1], X13
    FMOV  D22, X13
    FMOV  V22.D[1], X17
    FMOV  D23, X24
    FMOV  V23.D[1], X14
    FMOV  D24, X23
    FMOV  V24.D[1], X22
    FMOV  D25, X25
    FMOV  V25.D[1], X24
    FMOV  D26, X11
    FMOV  V26.D[1], X21
    FMOV  D27, X8
    FMOV  V27.D[1], X8
    FMOV  D28, X3
    FMOV  V28.D[1], X3
    FMOV  D29, X18
    FMOV  V29.D[1], X17
    FMOV  D30, X21
    FMOV  V30.D[1], X19
    FMOV  D31, X25
    FMOV  V31.D[1], X24
    MOVZ  X13, #0xf, LSL #0
TaishanFpMovMaddP01_label_166:
    FMAX  H29, H27, H17
    FMIN  D16, D14, D28
    FMAX  D4, D9, D26
    FMAX  D0, D21, D3
    FMAXNM  S12, S20, S20
    FMAX  H30, H29, H12
    FMAXNM  D28, D27, D13
    FMIN  S26, S16, S20
    FMINNM  H13, H22, H12
    FMINNM  H25, H27, H28
    FMAXNM  H23, H30, H11
    FMIN  S31, S28, S26
    FMAX  H31, H3, H25
    FMIN  S23, S17, S28
    FMAXNM  S17, S12, S2
    FMAX  H2, H9, H2
    FMIN  H17, H23, H0
    FMIN  H12, H2, H22
    FMIN  D12, D22, D17
    FMINNM  S17, S5, S10
    FMAX  S26, S18, S25
    FMAX  D13, D17, D14
    FMAXNM  S19, S25, S26
    FMAX  D3, D0, D28
    FMINNM  D17, D31, D13
    FMIN  H5, H30, H9
    FMIN  D12, D28, D2
    FMINNM  H27, H24, H20
    FMAX  H28, H29, H6
    FMINNM  H5, H14, H28
    FMINNM  H7, H27, H23
    FMAXNM  H5, H1, H21
    FMAXNM  D9, D7, D3
    FMIN  H16, H4, H27
    FMINNM  H0, H26, H9
    FMAXNM  S0, S19, S8
    FMINNM  D30, D14, D22
    FMIN  H3, H0, H18
    FMAXNM  H5, H21, H3
    FMAXNM  D23, D27, D12
    FMAX  H1, H4, H23
    FMIN  H20, H17, H19
    FMINNM  S0, S1, S21
    FMINNM  S20, S17, S25
    FMINNM  D8, D20, D2
    FMIN  S8, S3, S27
    FMAXNM  H18, H25, H20
    FMIN  H16, H5, H17
    FMAX  S28, S19, S7
    FMINNM  S16, S17, S22
    FMAXNM  D31, D1, D19
    FMIN  S3, S30, S4
    FMAXNM  D31, D25, D7
    FMAX  S9, S2, S8
    FMAXNM  S19, S24, S19
    FMINNM  D12, D4, D13
    FMAXNM  S17, S8, S15
    FMIN  S20, S28, S0
    FMAXNM  S21, S25, S5
    FMAXNM  D4, D20, D18
    FMAXNM  D26, D18, D8
    FMAX  H12, H15, H9
    FMAX  D16, D8, D22
    FMINNM  H0, H14, H22
    FMINNM  H28, H18, H16
    FMINNM  H28, H13, H11
    FMIN  S0, S3, S26
    FMAXNM  D1, D10, D1
    FMAXNM  H12, H5, H15
    FMIN  D7, D25, D24
    FMAXNM  D11, D30, D25
    FMAXNM  S26, S26, S15
    FMAXNM  H18, H2, H24
    FMIN  D16, D26, D26
    FMAXNM  S11, S24, S9
    FMAXNM  H20, H4, H13
    FMAX  D4, D6, D12
    FMIN  D3, D4, D27
    FMAXNM  S21, S21, S17
    FMAX  H21, H20, H7
    FMINNM  S5, S5, S11
    FMINNM  S2, S27, S9
    FMIN  D15, D10, D9
    FMIN  D12, D18, D18
    FMIN  S5, S9, S26
    FMINNM  H14, H15, H30
    FMINNM  H28, H3, H18
    FMAXNM  S0, S26, S16
    FMAXNM  S10, S15, S16
    FMINNM  S31, S16, S21
    FMIN  S0, S5, S21
    FMAXNM  H21, H9, H0
    FMIN  S23, S24, S5
    FMINNM  H20, H6, H5
    FMAXNM  S20, S29, S20
    FMAX  D3, D3, D3
    FMIN  S21, S14, S14
    FMINNM  S21, S1, S3
    FMAX  H31, H6, H7
    FMINNM  S26, S6, S11
    FMIN  D18, D25, D28
    FMAXNM  D12, D20, D3
    FMINNM  S13, S18, S19
    FMAX  D17, D15, D19
    FMIN  H4, H28, H17
    FMIN  H11, H18, H23
    FMIN  H24, H25, H2
    FMAX  S1, S7, S29
    FMAXNM  D8, D27, D6
    FMAXNM  S25, S10, S2
    FMIN  D28, D1, D21
    FMINNM  H27, H14, H8
    FMAX  H3, H7, H1
    FMINNM  H26, H27, H20
    FMINNM  S6, S20, S2
    FMINNM  D19, D27, D22
    FMINNM  D27, D2, D16
    FMINNM  D11, D2, D16
    FMIN  S15, S11, S13
    FMINNM  D29, D4, D14
    FMAXNM  D28, D15, D20
    FMIN  H16, H8, H16
    FMIN  H8, H4, H13
    FMINNM  S3, S8, S2
    FMIN  H24, H20, H18
    FMINNM  S30, S20, S16
    FMAX  S29, S8, S25
    FMINNM  S20, S30, S23
    FMINNM  D14, D4, D8
    FMAX  H15, H12, H14
    FMINNM  S5, S11, S13
    FMIN  H1, H30, H18
    FMINNM  H12, H25, H7
    FMAXNM  H9, H11, H9
    FMAX  H0, H10, H5
    FMIN  H10, H16, H21
    FMAXNM  H10, H19, H30
    FMIN  S2, S26, S4
    FMAXNM  H15, H0, H1
    FMAX  D6, D22, D1
    FMAXNM  S7, S20, S8
    FMAX  H23, H10, H5
    FMINNM  D11, D24, D9
    FMAX  S2, S18, S5
    FMINNM  S26, S16, S6
    FMIN  D22, D7, D1
    FMINNM  H25, H3, H4
    FMINNM  D27, D23, D1
    FMINNM  S6, S17, S30
    FMAX  H2, H25, H23
    FMAXNM  S5, S8, S15
    FMIN  D15, D14, D13
    FMIN  S14, S24, S16
    FMIN  S21, S2, S6
    FMIN  H22, H25, H25
    FMINNM  S10, S25, S21
    FMAX  D21, D4, D15
    FMAX  H0, H26, H9
    FMIN  D6, D25, D18
    FMINNM  S21, S17, S29
    FMIN  H17, H28, H30
    FMAX  D20, D27, D31
    FMAXNM  H17, H27, H18
    FMINNM  H16, H13, H25
    FMAXNM  D27, D12, D6
    FMAXNM  D18, D8, D2
    FMINNM  H23, H18, H21
    FMAX  D20, D20, D6
    FMIN  H9, H8, H29
    FMINNM  H28, H11, H19
    FMAXNM  H28, H16, H16
    FMAXNM  S20, S31, S21
    FMIN  H0, H31, H18
    FMINNM  D29, D20, D28
    FMINNM  D21, D9, D9
    FMIN  S9, S9, S27
    FMAXNM  D12, D4, D30
    FMINNM  H30, H12, H24
    FMAXNM  H13, H2, H23
    FMIN  S23, S29, S21
    FMAX  D1, D12, D25
    FMIN  H29, H16, H16
    FMAXNM  D12, D24, D19
    FMAXNM  D30, D18, D6
    FMIN  S23, S26, S31
    FMAXNM  H19, H26, H15
    FMINNM  S7, S18, S11
    FMAX  H1, H11, H18
    FMINNM  S5, S6, S11
    FMIN  H16, H29, H28
    FMAXNM  S21, S19, S30
    FMAX  S15, S25, S28
    FMAXNM  H26, H28, H5
    FMAX  D12, D20, D8
    FMAX  D5, D30, D7
    FMAXNM  H15, H24, H3
    FMAX  S13, S21, S6
    FMIN  D2, D17, D18
    FMAXNM  D31, D17, D10
    FMAXNM  H31, H7, H27
    SUBS  X13, X13, #0x1
    B.NE  TaishanFpMovMaddP01_label_166
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X5, X26, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X3, X8, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X6, X28, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X10, X25, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X27, X16, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X16, X2, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X4, X11, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X15, X22, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X28, X5, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X18, X26, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X14, X15, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X7, X5, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X6, X19, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X22, X24, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D15
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D25
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D27
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D29
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x8f3a, LSL #0
    MOVK  X2, #0x3cc8, LSL #16
    MOVK  X2, #0xc4d0, LSL #32
    MOVK  X2, #0xc27a, LSL #48
    MOVZ  X3, #0xeab, LSL #0
    MOVK  X3, #0x5c37, LSL #16
    MOVK  X3, #0x4a5d, LSL #32
    MOVK  X3, #0x2dc7, LSL #48
    MOVZ  X4, #0x67ab, LSL #0
    MOVK  X4, #0x7184, LSL #16
    MOVK  X4, #0xda42, LSL #32
    MOVK  X4, #0xbb99, LSL #48
    MOVZ  X5, #0x54fe, LSL #0
    MOVK  X5, #0xc766, LSL #16
    MOVK  X5, #0x657f, LSL #32
    MOVK  X5, #0x6086, LSL #48
    MOVZ  X6, #0xaf5b, LSL #0
    MOVK  X6, #0xe06c, LSL #16
    MOVK  X6, #0x1393, LSL #32
    MOVK  X6, #0x4e8b, LSL #48
    MOVZ  X7, #0x3686, LSL #0
    MOVK  X7, #0x6d48, LSL #16
    MOVK  X7, #0xa8f4, LSL #32
    MOVK  X7, #0x30be, LSL #48
    MOVZ  X8, #0xfb01, LSL #0
    MOVK  X8, #0x5b1b, LSL #16
    MOVK  X8, #0xe8f4, LSL #32
    MOVK  X8, #0x692c, LSL #48
    MOVZ  X9, #0xe922, LSL #0
    MOVK  X9, #0x8ac5, LSL #16
    MOVK  X9, #0x1, LSL #32
    MOVK  X9, #0xe5f, LSL #48
    MOVZ  X10, #0xa576, LSL #0
    MOVK  X10, #0x922d, LSL #16
    MOVK  X10, #0xf26c, LSL #32
    MOVK  X10, #0x775f, LSL #48
    MOVZ  X11, #0x8f9a, LSL #0
    MOVK  X11, #0xa828, LSL #16
    MOVK  X11, #0x9177, LSL #32
    MOVK  X11, #0x482c, LSL #48
    MOVZ  X13, #0xbf81, LSL #0
    MOVK  X13, #0xe668, LSL #16
    MOVK  X13, #0xfe72, LSL #32
    MOVK  X13, #0xde6b, LSL #48
    MOVZ  X14, #0x17fe, LSL #0
    MOVK  X14, #0xba56, LSL #16
    MOVK  X14, #0xd92d, LSL #32
    MOVK  X14, #0xc482, LSL #48
    MOVZ  X15, #0x2264, LSL #0
    MOVK  X15, #0xf526, LSL #16
    MOVK  X15, #0x258c, LSL #32
    MOVK  X15, #0xa91f, LSL #48
    MOVZ  X16, #0x7aa4, LSL #0
    MOVK  X16, #0xa06f, LSL #16
    MOVK  X16, #0xb010, LSL #32
    MOVK  X16, #0xa75b, LSL #48
    MOVZ  X17, #0x5a99, LSL #0
    MOVK  X17, #0x9a1, LSL #16
    MOVK  X17, #0xb79c, LSL #32
    MOVK  X17, #0xe1b9, LSL #48
    MOVZ  X18, #0x515c, LSL #0
    MOVK  X18, #0xa9fc, LSL #16
    MOVK  X18, #0x1edd, LSL #32
    MOVK  X18, #0xe3f7, LSL #48
    MOVZ  X19, #0xd2d6, LSL #0
    MOVK  X19, #0xbf0b, LSL #16
    MOVK  X19, #0xbf1e, LSL #32
    MOVK  X19, #0x45b1, LSL #48
    MOVZ  X20, #0x114a, LSL #0
    MOVK  X20, #0xdcaf, LSL #16
    MOVK  X20, #0x4eda, LSL #32
    MOVK  X20, #0xc033, LSL #48
    MOVZ  X21, #0x812f, LSL #0
    MOVK  X21, #0x5fb, LSL #16
    MOVK  X21, #0xb285, LSL #32
    MOVK  X21, #0x2903, LSL #48
    MOVZ  X22, #0x2d29, LSL #0
    MOVK  X22, #0x5605, LSL #16
    MOVK  X22, #0x2523, LSL #32
    MOVK  X22, #0xefb5, LSL #48
    MOVZ  X23, #0xfcdd, LSL #0
    MOVK  X23, #0x3658, LSL #16
    MOVK  X23, #0xa6e8, LSL #32
    MOVK  X23, #0x10cb, LSL #48
    MOVZ  X24, #0xcf45, LSL #0
    MOVK  X24, #0x9455, LSL #16
    MOVK  X24, #0xefa, LSL #32
    MOVK  X24, #0x41b1, LSL #48
    MOVZ  X25, #0xf24a, LSL #0
    MOVK  X25, #0x57df, LSL #16
    MOVK  X25, #0x3997, LSL #32
    MOVK  X25, #0x2dee, LSL #48
    MOVZ  X26, #0xb17, LSL #0
    MOVK  X26, #0xf655, LSL #16
    MOVK  X26, #0x1171, LSL #32
    MOVK  X26, #0x3c45, LSL #48
    MOVZ  X27, #0x4664, LSL #0
    MOVK  X27, #0x391a, LSL #16
    MOVK  X27, #0xc611, LSL #32
    MOVK  X27, #0x3e73, LSL #48
    MOVZ  X28, #0xd56d, LSL #0
    MOVK  X28, #0xc66b, LSL #16
    MOVK  X28, #0x86bc, LSL #32
    MOVK  X28, #0x6921, LSL #48
    MOVZ  X29, #0x6cd7, LSL #0
    MOVK  X29, #0x6ee4, LSL #16
    MOVK  X29, #0x18f1, LSL #32
    MOVK  X29, #0x8891, LSL #48
    FMOV  D0, X17
    FMOV  V0.D[1], X22
    FMOV  D1, X21
    FMOV  V1.D[1], X24
    FMOV  D2, X7
    FMOV  V2.D[1], X28
    FMOV  D3, X17
    FMOV  V3.D[1], X21
    FMOV  D4, X5
    FMOV  V4.D[1], X24
    FMOV  D5, X29
    FMOV  V5.D[1], X14
    FMOV  D6, X14
    FMOV  V6.D[1], X3
    FMOV  D7, X2
    FMOV  V7.D[1], X29
    FMOV  D8, X11
    FMOV  V8.D[1], X14
    FMOV  D9, X3
    FMOV  V9.D[1], X8
    FMOV  D10, X10
    FMOV  V10.D[1], X24
    FMOV  D11, X25
    FMOV  V11.D[1], X5
    FMOV  D12, X8
    FMOV  V12.D[1], X27
    FMOV  D13, X26
    FMOV  V13.D[1], X10
    FMOV  D14, X27
    FMOV  V14.D[1], X4
    FMOV  D15, X2
    FMOV  V15.D[1], X2
    FMOV  D16, X2
    FMOV  V16.D[1], X2
    FMOV  D17, X15
    FMOV  V17.D[1], X7
    FMOV  D18, X6
    FMOV  V18.D[1], X19
    FMOV  D19, X22
    FMOV  V19.D[1], X24
    FMOV  D20, X25
    FMOV  V20.D[1], X29
    FMOV  D21, X10
    FMOV  V21.D[1], X22
    FMOV  D22, X24
    FMOV  V22.D[1], X27
    FMOV  D23, X7
    FMOV  V23.D[1], X13
    FMOV  D24, X6
    FMOV  V24.D[1], X7
    FMOV  D25, X6
    FMOV  V25.D[1], X16
    FMOV  D26, X15
    FMOV  V26.D[1], X6
    FMOV  D27, X10
    FMOV  V27.D[1], X28
    FMOV  D28, X24
    FMOV  V28.D[1], X11
    FMOV  D29, X9
    FMOV  V29.D[1], X23
    FMOV  D30, X6
    FMOV  V30.D[1], X22
    FMOV  D31, X2
    FMOV  V31.D[1], X13
    MOVZ  X17, #0xa, LSL #0
TaishanFpMovMaddP01_label_249:
    FMIN  H15, H9, H31
    FMAXNM  D20, D14, D6
    FMINNM  H24, H15, H22
    FMAX  H25, H21, H24
    FMIN  S7, S30, S6
    FMINNM  H0, H3, H29
    FMAXNM  S25, S29, S28
    FMIN  H1, H1, H9
    FMINNM  S1, S23, S23
    FMAXNM  D25, D21, D20
    FMINNM  S15, S8, S25
    FMINNM  D20, D9, D11
    FMAX  D5, D7, D26
    FMINNM  H11, H23, H9
    FMIN  D1, D12, D21
    FMAXNM  S12, S28, S19
    FMIN  S3, S11, S11
    FMIN  S12, S25, S20
    FMINNM  H7, H27, H7
    FMIN  H2, H16, H25
    FMAX  H16, H26, H10
    FMINNM  D13, D16, D27
    FMAXNM  S21, S24, S28
    FMIN  S25, S0, S22
    FMAXNM  H20, H14, H30
    FMAXNM  H12, H20, H17
    FMINNM  S20, S24, S2
    FMAX  H8, H11, H18
    FMINNM  S21, S17, S11
    FMINNM  S10, S16, S26
    FMINNM  H14, H30, H2
    FMAXNM  H24, H26, H23
    FMAXNM  H24, H0, H6
    FMAX  S24, S12, S14
    FMINNM  H5, H5, H6
    FMINNM  D23, D26, D20
    FMAXNM  D16, D18, D26
    FMIN  S23, S7, S27
    FMIN  D1, D25, D12
    FMINNM  D11, D0, D30
    FMIN  S20, S9, S21
    FMINNM  H5, H18, H19
    FMAXNM  H29, H18, H6
    FMIN  D15, D31, D10
    FMIN  S31, S30, S15
    FMAX  D13, D26, D24
    FMAXNM  S27, S25, S1
    FMAXNM  D27, D12, D29
    FMAX  S11, S21, S27
    FMAXNM  D10, D26, D26
    FMINNM  D27, D10, D25
    FMINNM  H24, H24, H27
    FMAXNM  S3, S24, S26
    FMIN  D11, D14, D25
    FMAXNM  H13, H12, H26
    FMINNM  H19, H27, H0
    FMIN  D17, D17, D8
    FMAX  D10, D14, D12
    FMAX  S24, S3, S13
    FMINNM  S13, S17, S7
    FMAXNM  H29, H13, H31
    FMIN  S18, S11, S4
    FMAX  D10, D26, D21
    FMAXNM  D17, D22, D7
    FMAX  D12, D3, D19
    FMINNM  H17, H10, H12
    FMINNM  H16, H29, H4
    FMINNM  S26, S31, S13
    FMAXNM  D26, D26, D28
    FMIN  D5, D4, D1
    FMINNM  H17, H4, H2
    FMINNM  S22, S1, S4
    FMIN  S31, S21, S25
    FMAXNM  D15, D1, D4
    FMAX  D14, D26, D19
    FMAX  H8, H7, H1
    FMIN  D4, D14, D16
    FMINNM  H2, H10, H26
    FMINNM  D22, D11, D27
    FMINNM  H28, H17, H9
    FMAXNM  S24, S4, S4
    FMAX  D2, D9, D31
    FMAXNM  H24, H6, H21
    FMINNM  H19, H0, H30
    FMINNM  D13, D11, D31
    FMIN  D19, D20, D24
    FMIN  H5, H29, H29
    FMINNM  D11, D22, D27
    FMINNM  D8, D5, D6
    FMAXNM  H13, H21, H7
    FMIN  S13, S10, S15
    FMINNM  S31, S4, S22
    FMAXNM  H28, H30, H17
    FMINNM  S0, S2, S18
    FMINNM  S10, S11, S16
    FMAX  H30, H7, H0
    FMAX  S11, S13, S11
    FMAXNM  D10, D15, D18
    FMAX  D8, D15, D13
    FMAX  S8, S31, S10
    FMINNM  H2, H19, H3
    FMINNM  H20, H2, H17
    FMAX  H21, H20, H15
    FMINNM  H8, H8, H31
    FMINNM  H26, H11, H17
    FMINNM  S22, S13, S14
    FMAX  H3, H1, H20
    FMINNM  H11, H9, H5
    FMAXNM  S8, S7, S10
    FMINNM  S0, S20, S21
    FMINNM  H17, H19, H30
    FMIN  D7, D28, D6
    FMAXNM  H17, H2, H27
    FMAXNM  S10, S30, S21
    FMINNM  H0, H10, H4
    FMINNM  D10, D24, D16
    FMIN  S3, S6, S29
    FMIN  S17, S26, S17
    FMIN  D3, D28, D18
    FMAXNM  D3, D15, D26
    FMAX  D31, D14, D30
    FMINNM  S5, S5, S31
    FMAX  S17, S6, S31
    FMAXNM  H24, H29, H9
    FMINNM  H9, H0, H28
    FMAXNM  D15, D15, D14
    FMAX  H9, H24, H10
    FMINNM  H11, H28, H22
    FMINNM  S5, S19, S15
    FMAX  D24, D16, D4
    FMINNM  D0, D16, D6
    FMIN  D0, D8, D5
    FMAX  H22, H18, H16
    FMIN  H13, H15, H9
    FMAXNM  H30, H13, H24
    FMAX  H16, H31, H21
    FMIN  D18, D18, D7
    FMAXNM  H14, H4, H14
    FMIN  D29, D29, D6
    FMINNM  S7, S9, S8
    FMINNM  D0, D1, D1
    FMIN  H13, H5, H12
    FMAXNM  D18, D3, D0
    FMIN  H6, H12, H28
    FMIN  H12, H8, H12
    FMAXNM  S9, S2, S14
    FMIN  H15, H15, H2
    FMAXNM  D9, D12, D16
    FMIN  D1, D23, D21
    FMIN  D19, D10, D12
    FMAXNM  S15, S18, S26
    FMAXNM  S13, S9, S16
    FMIN  S21, S22, S28
    FMAX  H7, H31, H3
    FMAX  H7, H22, H25
    FMAXNM  D20, D12, D31
    FMIN  D18, D13, D20
    FMAX  S3, S19, S21
    FMAXNM  S15, S8, S24
    FMAX  D11, D10, D17
    FMAXNM  H13, H0, H22
    FMIN  H8, H21, H29
    FMIN  H1, H1, H17
    FMINNM  S20, S9, S15
    FMINNM  D7, D3, D26
    FMIN  H8, H28, H0
    FMINNM  D30, D7, D6
    FMINNM  H14, H21, H4
    FMAX  S4, S2, S8
    FMINNM  D7, D4, D25
    FMAX  D27, D21, D16
    FMAX  H24, H22, H11
    FMINNM  H19, H29, H22
    FMINNM  S29, S0, S17
    FMINNM  S7, S22, S19
    FMINNM  D17, D22, D4
    FMINNM  H25, H17, H21
    FMAXNM  D3, D23, D10
    FMAX  H25, H2, H12
    FMAXNM  H19, H5, H13
    FMIN  D19, D14, D19
    FMAXNM  S11, S1, S5
    FMIN  D5, D16, D31
    FMAX  D25, D13, D7
    FMINNM  S19, S16, S30
    FMIN  H2, H3, H20
    FMINNM  S12, S23, S8
    FMIN  D5, D14, D2
    FMIN  H24, H19, H18
    FMAX  D6, D10, D31
    FMINNM  H25, H5, H18
    FMINNM  S8, S12, S24
    FMAXNM  S8, S6, S21
    FMINNM  S30, S14, S11
    FMIN  S3, S7, S24
    FMAXNM  S3, S19, S25
    FMAXNM  D18, D27, D28
    FMINNM  S15, S13, S29
    FMINNM  H29, H30, H29
    FMAXNM  D8, D31, D30
    SUBS  X17, X17, #0x1
    B.NE  TaishanFpMovMaddP01_label_249
    MOVZ  X9, #0x8f3a, LSL #0
    MOVK  X9, #0x3cc8, LSL #16
    MOVK  X9, #0xc4d0, LSL #32
    MOVK  X9, #0xc27a, LSL #48
    SUB  X2, X9, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0xeab, LSL #0
    MOVK  X19, #0x5c37, LSL #16
    MOVK  X19, #0x4a5d, LSL #32
    MOVK  X19, #0x2dc7, LSL #48
    SUB  X7, X19, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x67ab, LSL #0
    MOVK  X27, #0x7184, LSL #16
    MOVK  X27, #0xda42, LSL #32
    MOVK  X27, #0xbb99, LSL #48
    SUB  X14, X27, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x54fe, LSL #0
    MOVK  X15, #0xc766, LSL #16
    MOVK  X15, #0x657f, LSL #32
    MOVK  X15, #0x6086, LSL #48
    SUB  X18, X15, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0xaf5b, LSL #0
    MOVK  X8, #0xe06c, LSL #16
    MOVK  X8, #0x1393, LSL #32
    MOVK  X8, #0x4e8b, LSL #48
    SUB  X15, X8, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0xaf5b, LSL #0
    MOVK  X20, #0xe06c, LSL #16
    MOVK  X20, #0x1393, LSL #32
    MOVK  X20, #0x4e8b, LSL #48
    SUB  X21, X20, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x8f3a, LSL #0
    MOVK  X5, #0x3cc8, LSL #16
    MOVK  X5, #0xc4d0, LSL #32
    MOVK  X5, #0xc27a, LSL #48
    SUB  X7, X5, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0xa576, LSL #0
    MOVK  X29, #0x922d, LSL #16
    MOVK  X29, #0xf26c, LSL #32
    MOVK  X29, #0x775f, LSL #48
    SUB  X11, X29, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0xeab, LSL #0
    MOVK  X25, #0x5c37, LSL #16
    MOVK  X25, #0x4a5d, LSL #32
    MOVK  X25, #0x2dc7, LSL #48
    SUB  X27, X25, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x2d29, LSL #0
    MOVK  X4, #0x5605, LSL #16
    MOVK  X4, #0x2523, LSL #32
    MOVK  X4, #0xefb5, LSL #48
    SUB  X18, X4, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0xeab, LSL #0
    MOVK  X16, #0x5c37, LSL #16
    MOVK  X16, #0x4a5d, LSL #32
    MOVK  X16, #0x2dc7, LSL #48
    SUB  X24, X16, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D2
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D4
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D7
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D9
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D15
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D17
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D21
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D25
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X13
    FMOV  V0.D[1], X7
    FMOV  D1, X20
    FMOV  V1.D[1], X7
    FMOV  D2, X5
    FMOV  V2.D[1], X9
    FMOV  D3, X6
    FMOV  V3.D[1], X17
    FMOV  D4, X3
    FMOV  V4.D[1], X10
    FMOV  D5, X21
    FMOV  V5.D[1], X28
    FMOV  D6, X28
    FMOV  V6.D[1], X7
    FMOV  D7, X20
    FMOV  V7.D[1], X22
    FMOV  D8, X2
    FMOV  V8.D[1], X7
    FMOV  D9, X29
    FMOV  V9.D[1], X17
    FMOV  D10, X11
    FMOV  V10.D[1], X27
    FMOV  D11, X5
    FMOV  V11.D[1], X11
    FMOV  D12, X10
    FMOV  V12.D[1], X15
    FMOV  D13, X15
    FMOV  V13.D[1], X5
    FMOV  D14, X28
    FMOV  V14.D[1], X5
    FMOV  D15, X11
    FMOV  V15.D[1], X17
    FMOV  D16, X22
    FMOV  V16.D[1], X10
    FMOV  D17, X18
    FMOV  V17.D[1], X17
    FMOV  D18, X27
    FMOV  V18.D[1], X26
    FMOV  D19, X10
    FMOV  V19.D[1], X4
    FMOV  D20, X6
    FMOV  V20.D[1], X6
    FMOV  D21, X28
    FMOV  V21.D[1], X29
    FMOV  D22, X9
    FMOV  V22.D[1], X15
    FMOV  D23, X24
    FMOV  V23.D[1], X22
    FMOV  D24, X13
    FMOV  V24.D[1], X21
    FMOV  D25, X28
    FMOV  V25.D[1], X13
    FMOV  D26, X24
    FMOV  V26.D[1], X15
    FMOV  D27, X22
    FMOV  V27.D[1], X28
    FMOV  D28, X15
    FMOV  V28.D[1], X22
    FMOV  D29, X21
    FMOV  V29.D[1], X25
    FMOV  D30, X13
    FMOV  V30.D[1], X21
    FMOV  D31, X27
    FMOV  V31.D[1], X11
    MOVZ  X26, #0xa, LSL #0
TaishanFpMovMaddP01_label_331:
    FMAXNM  H23, H24, H18
    FMAX  S30, S24, S21
    FMIN  H8, H16, H30
    FMINNM  D9, D28, D3
    FMAXNM  D7, D31, D31
    FMINNM  H26, H18, H9
    FMAX  H30, H25, H24
    FMAXNM  D6, D7, D26
    FMIN  S13, S29, S7
    FMINNM  S21, S23, S8
    FMAXNM  H21, H8, H27
    FMIN  H8, H13, H25
    FMINNM  D5, D8, D31
    FMAX  S13, S5, S9
    FMAXNM  S23, S19, S17
    FMAX  D16, D24, D16
    FMAX  D13, D8, D17
    FMAX  D29, D17, D24
    FMINNM  D3, D13, D25
    FMINNM  D8, D19, D23
    FMAXNM  D25, D24, D30
    FMAX  H1, H1, H6
    FMINNM  H12, H12, H6
    FMINNM  S16, S22, S0
    FMAXNM  D15, D25, D3
    FMINNM  H25, H25, H1
    FMINNM  H31, H1, H22
    FMAXNM  S21, S21, S9
    FMINNM  H16, H21, H19
    FMAX  H29, H12, H1
    FMAX  H17, H14, H10
    FMIN  S23, S1, S21
    FMAXNM  S13, S12, S8
    FMAXNM  S16, S29, S30
    FMIN  D16, D15, D8
    FMINNM  S16, S23, S5
    FMAX  D27, D30, D27
    FMAXNM  S27, S25, S20
    FMINNM  D6, D18, D0
    FMAX  H22, H18, H21
    FMIN  D7, D30, D7
    FMINNM  S3, S3, S12
    FMAX  D16, D31, D19
    FMAXNM  D22, D3, D9
    FMINNM  H22, H8, H13
    FMINNM  S4, S1, S14
    FMAX  S7, S23, S23
    FMAX  S17, S3, S31
    FMINNM  H22, H27, H5
    FMINNM  H25, H22, H25
    FMAX  H29, H11, H0
    FMIN  S14, S14, S31
    FMINNM  S6, S26, S23
    FMINNM  D14, D9, D16
    FMIN  H30, H12, H27
    FMINNM  H20, H25, H15
    FMAXNM  S25, S9, S22
    FMAXNM  D2, D6, D6
    FMAXNM  S16, S1, S2
    FMINNM  S18, S22, S25
    FMINNM  H2, H16, H20
    FMINNM  D4, D2, D22
    FMAX  S5, S5, S2
    FMIN  D30, D26, D3
    FMAX  D24, D16, D2
    FMINNM  S27, S12, S22
    FMIN  H14, H0, H19
    FMAX  D24, D26, D29
    FMIN  S8, S21, S21
    FMINNM  D12, D3, D15
    FMAXNM  S9, S11, S16
    FMAXNM  S18, S11, S6
    FMAXNM  D25, D16, D24
    FMAX  S6, S25, S11
    FMIN  H11, H9, H1
    FMIN  H26, H15, H9
    FMAX  S27, S12, S28
    FMAXNM  S28, S24, S29
    FMAX  S23, S5, S26
    FMAXNM  S2, S31, S23
    FMAX  D25, D30, D15
    FMIN  H0, H12, H8
    FMAXNM  S14, S22, S3
    FMIN  H15, H14, H14
    FMAX  S23, S13, S15
    FMINNM  D24, D12, D21
    FMAXNM  H23, H6, H13
    FMAX  H20, H25, H16
    FMAX  H20, H31, H5
    FMIN  S26, S28, S20
    FMAXNM  H27, H24, H6
    FMIN  S31, S29, S19
    FMAXNM  D12, D0, D9
    FMAX  H2, H8, H6
    FMAXNM  D1, D29, D2
    FMAX  H14, H18, H20
    FMINNM  H30, H9, H14
    FMAX  D26, D18, D25
    FMINNM  H10, H5, H26
    FMIN  S3, S15, S25
    FMINNM  H7, H19, H9
    FMINNM  S9, S11, S23
    FMINNM  D23, D29, D10
    FMAXNM  H22, H25, H12
    FMINNM  D16, D7, D26
    FMAX  H11, H16, H0
    FMINNM  D11, D26, D8
    FMAXNM  H16, H18, H17
    FMAX  H28, H30, H10
    FMAX  S19, S11, S1
    FMINNM  H6, H0, H24
    FMIN  S27, S2, S29
    FMIN  H5, H14, H20
    FMIN  H3, H8, H15
    FMAXNM  H30, H4, H21
    FMIN  H12, H8, H26
    FMINNM  S4, S21, S17
    FMINNM  S8, S16, S31
    FMAX  H12, H3, H26
    FMIN  H30, H13, H22
    FMINNM  S12, S29, S21
    FMAX  D2, D27, D21
    FMAXNM  D14, D5, D24
    FMINNM  H8, H17, H23
    FMIN  H9, H4, H20
    FMIN  D25, D2, D12
    FMINNM  S8, S25, S0
    FMAX  H5, H3, H6
    FMIN  S14, S18, S19
    FMAX  H2, H30, H20
    FMINNM  D31, D2, D25
    FMINNM  H14, H15, H1
    FMAX  D24, D1, D26
    FMAX  D0, D31, D22
    FMINNM  D7, D5, D21
    FMINNM  D29, D29, D27
    FMAX  S19, S5, S30
    FMIN  H6, H17, H18
    FMIN  H14, H0, H29
    FMINNM  S4, S27, S3
    FMAX  H6, H18, H8
    FMAXNM  H23, H5, H13
    FMAX  H28, H24, H17
    FMAX  H15, H24, H4
    FMAXNM  D18, D5, D9
    FMINNM  H23, H10, H7
    FMINNM  S0, S26, S20
    FMINNM  D9, D7, D31
    FMAXNM  S27, S29, S4
    FMINNM  S30, S17, S0
    FMINNM  S17, S14, S18
    FMIN  H26, H14, H29
    FMAX  D22, D14, D12
    FMIN  D27, D3, D23
    FMAXNM  D3, D27, D19
    FMAXNM  S6, S6, S23
    FMINNM  S27, S15, S17
    FMAX  S21, S30, S28
    FMIN  H8, H23, H16
    FMAX  D9, D16, D17
    FMIN  S29, S24, S2
    FMAX  H15, H16, H21
    FMAXNM  D25, D0, D3
    FMIN  H25, H24, H18
    FMAX  D26, D31, D25
    FMIN  S2, S19, S25
    FMINNM  D5, D18, D15
    FMINNM  H18, H24, H29
    FMAX  H10, H4, H15
    FMIN  S6, S6, S30
    FMIN  D24, D29, D26
    FMINNM  S28, S5, S29
    FMAX  D6, D27, D6
    FMINNM  S9, S24, S13
    FMAX  D20, D21, D17
    FMAX  H13, H7, H2
    FMIN  H31, H8, H10
    FMIN  H13, H26, H30
    FMAX  S28, S16, S10
    FMINNM  S19, S15, S18
    FMAXNM  H14, H9, H5
    FMIN  H1, H1, H27
    FMIN  H16, H17, H18
    FMAXNM  H14, H16, H3
    FMIN  D26, D30, D8
    FMIN  H7, H26, H10
    FMAXNM  H31, H13, H10
    FMAXNM  D17, D1, D4
    FMAX  D9, D0, D28
    FMINNM  H29, H5, H13
    FMAXNM  S4, S27, S26
    FMAXNM  S5, S16, S15
    FMAXNM  S28, S18, S19
    FMAX  D9, D13, D27
    FMINNM  S10, S26, S16
    FMIN  H16, H30, H15
    FMINNM  D12, D0, D30
    FMIN  D20, D8, D30
    FMINNM  D3, D21, D5
    FMIN  S28, S14, S30
    SUBS  X26, X26, #0x1
    B.NE  TaishanFpMovMaddP01_label_331
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X22, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
TaishanFpMovMaddP01_label_17:
    FMOV  X4, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
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
    FMOV  V0.D[1], X13
    FMOV  D1, X21
    FMOV  V1.D[1], X16
    FMOV  D2, X9
    FMOV  V2.D[1], X5
    FMOV  D3, X11
    FMOV  V3.D[1], X26
    FMOV  D4, X13
    FMOV  V4.D[1], X21
    FMOV  D5, X3
    FMOV  V5.D[1], X28
    FMOV  D6, X28
    FMOV  V6.D[1], X21
    FMOV  D7, X29
    FMOV  V7.D[1], X5
    FMOV  D8, X7
    FMOV  V8.D[1], X13
    FMOV  D9, X5
    FMOV  V9.D[1], X22
    FMOV  D10, X28
    FMOV  V10.D[1], X18
    FMOV  D11, X28
    FMOV  V11.D[1], X23
    FMOV  D12, X7
    FMOV  V12.D[1], X7
    FMOV  D13, X23
    FMOV  V13.D[1], X9
    FMOV  D14, X3
    FMOV  V14.D[1], X26
    FMOV  D15, X10
    FMOV  V15.D[1], X26
    FMOV  D16, X29
    FMOV  V16.D[1], X7
    FMOV  D17, X9
    FMOV  V17.D[1], X8
    FMOV  D18, X5
    FMOV  V18.D[1], X3
    FMOV  D19, X22
    FMOV  V19.D[1], X23
    FMOV  D20, X7
    FMOV  V20.D[1], X17
    FMOV  D21, X8
    FMOV  V21.D[1], X21
    FMOV  D22, X13
    FMOV  V22.D[1], X23
    FMOV  D23, X5
    FMOV  V23.D[1], X4
    FMOV  D24, X25
    FMOV  V24.D[1], X10
    FMOV  D25, X22
    FMOV  V25.D[1], X8
    FMOV  D26, X8
    FMOV  V26.D[1], X7
    FMOV  D27, X10
    FMOV  V27.D[1], X24
    FMOV  D28, X18
    FMOV  V28.D[1], X28
    FMOV  D29, X24
    FMOV  V29.D[1], X19
    FMOV  D30, X28
    FMOV  V30.D[1], X19
    FMOV  D31, X4
    FMOV  V31.D[1], X24
    MOVZ  X16, #0xf, LSL #0
TaishanFpMovMaddP01_label_413:
    FMINNM  D25, D30, D16
    FMIN  S20, S11, S19
    FMINNM  S5, S9, S2
    FMINNM  H7, H25, H8
    FMINNM  D21, D19, D1
    FMAXNM  H28, H29, H2
    FMIN  H24, H0, H0
    FMAX  S16, S0, S27
    FMIN  S21, S31, S3
    FMIN  H14, H8, H20
    FMAX  D1, D24, D20
    FMAXNM  S21, S4, S31
    FMAXNM  D6, D4, D8
    FMAX  D31, D6, D26
    FMIN  S21, S20, S14
    FMAX  S3, S25, S18
    FMIN  H5, H3, H5
    FMINNM  H13, H14, H1
    FMAX  S31, S19, S29
    FMIN  D6, D18, D7
    FMAXNM  S8, S16, S21
    FMIN  H21, H7, H9
    FMAX  D24, D2, D9
    FMINNM  D1, D11, D24
    FMAX  H2, H12, H6
    FMAXNM  H10, H27, H19
    FMIN  H16, H4, H19
    FMAX  H18, H31, H12
    FMINNM  D14, D28, D5
    FMAXNM  H10, H5, H30
    FMINNM  D29, D19, D7
    FMAXNM  D9, D11, D18
    FMINNM  H4, H31, H20
    FMINNM  S31, S12, S2
    FMIN  D14, D1, D10
    FMAXNM  S5, S4, S12
    FMIN  D6, D4, D15
    FMAXNM  H0, H20, H15
    FMIN  S21, S0, S18
    FMAX  H29, H9, H5
    FMIN  H1, H30, H8
    FMINNM  D11, D9, D13
    FMIN  D31, D15, D4
    FMIN  D6, D14, D24
    FMINNM  S13, S6, S23
    FMAX  H9, H24, H11
    FMAX  S18, S3, S31
    FMAXNM  H31, H7, H13
    FMAX  S18, S20, S28
    FMIN  H18, H1, H27
    FMINNM  H9, H10, H24
    FMAXNM  D20, D19, D31
    FMINNM  D9, D2, D1
    FMINNM  S0, S18, S16
    FMAXNM  S5, S0, S14
    FMAXNM  S19, S5, S5
    FMINNM  D2, D3, D11
    FMINNM  H15, H14, H22
    FMAX  S30, S0, S22
    FMIN  D6, D17, D21
    FMIN  H11, H12, H23
    FMIN  H8, H8, H19
    FMIN  D29, D30, D10
    FMINNM  H11, H4, H20
    FMIN  D23, D6, D2
    FMAX  H19, H31, H9
    FMAXNM  D23, D28, D0
    FMAXNM  D2, D29, D22
    FMIN  S31, S5, S11
    FMAX  H6, H30, H24
    FMAXNM  D28, D6, D15
    FMINNM  H2, H11, H1
    FMAXNM  S7, S30, S6
    FMAX  H2, H20, H28
    FMAXNM  S8, S17, S3
    FMAXNM  H1, H8, H17
    FMIN  H7, H8, H14
    FMINNM  H10, H23, H26
    FMAX  H31, H5, H24
    FMINNM  D0, D8, D6
    FMINNM  H20, H29, H10
    FMAX  H23, H19, H20
    FMAX  S26, S8, S17
    FMIN  H5, H7, H10
    FMIN  S14, S26, S16
    FMAXNM  D29, D12, D5
    FMAX  D8, D24, D23
    FMINNM  S0, S8, S21
    FMINNM  H2, H15, H31
    FMIN  D10, D30, D29
    FMAX  S27, S6, S8
    FMINNM  H31, H4, H19
    FMINNM  H28, H20, H23
    FMAXNM  D24, D26, D17
    FMINNM  D8, D1, D31
    FMAX  D21, D24, D14
    FMINNM  S5, S14, S28
    FMAXNM  D5, D21, D2
    FMAXNM  H5, H4, H14
    FMAX  D25, D11, D31
    FMAX  S24, S15, S0
    FMAX  S9, S25, S15
    FMIN  H22, H3, H15
    FMAX  D23, D4, D24
    FMAXNM  S2, S31, S12
    FMAX  D17, D29, D18
    FMIN  D15, D21, D28
    FMAX  D0, D15, D1
    FMINNM  S0, S10, S23
    FMIN  D11, D9, D6
    FMIN  H26, H13, H0
    FMAXNM  H16, H3, H28
    FMAXNM  S14, S15, S10
    FMAXNM  S3, S29, S19
    FMINNM  D7, D20, D31
    FMAX  H22, H30, H15
    FMAX  S23, S16, S22
    FMAXNM  H31, H2, H20
    FMAXNM  S0, S6, S14
    FMINNM  S9, S27, S13
    FMIN  S4, S7, S26
    FMINNM  H8, H29, H17
    FMAX  D4, D24, D9
    FMINNM  D27, D21, D29
    FMAXNM  S11, S22, S17
    FMINNM  S17, S29, S3
    FMAXNM  D17, D4, D29
    FMAXNM  S9, S11, S20
    FMAX  D27, D16, D10
    FMIN  S25, S11, S17
    FMINNM  D0, D24, D18
    FMIN  S18, S9, S17
    FMIN  S29, S16, S30
    FMAX  S22, S22, S13
    FMAX  D13, D27, D21
    FMAX  S31, S18, S10
    FMINNM  D22, D0, D31
    FMAX  D15, D31, D23
    FMAXNM  H23, H0, H15
    FMINNM  H24, H5, H19
    FMAX  H5, H17, H29
    FMAX  S17, S2, S29
    FMINNM  H22, H31, H2
    FMAXNM  S24, S4, S23
    FMAX  S11, S22, S16
    FMINNM  S21, S17, S25
    FMAX  D28, D13, D16
    FMIN  D29, D26, D17
    FMAX  D20, D2, D23
    FMAXNM  S26, S5, S29
    FMINNM  H1, H11, H11
    FMINNM  D0, D12, D4
    FMINNM  D0, D26, D9
    FMAX  S25, S18, S19
    FMIN  S19, S9, S7
    FMIN  H3, H27, H24
    FMIN  S24, S7, S1
    FMAXNM  H20, H18, H21
    FMAXNM  S8, S22, S27
    FMAXNM  D18, D21, D25
    FMINNM  D10, D16, D31
    FMINNM  S12, S25, S23
    FMAX  S6, S19, S9
    FMIN  S7, S10, S7
    FMAXNM  S7, S29, S1
    FMAXNM  D7, D2, D11
    FMAXNM  H11, H2, H31
    FMIN  D0, D18, D1
    FMAX  S4, S0, S20
    FMAX  H3, H16, H4
    FMIN  H16, H1, H9
    FMAXNM  S4, S19, S26
    FMAX  H7, H22, H26
    FMAXNM  S14, S6, S6
    FMIN  S8, S10, S5
    FMAXNM  S11, S23, S14
    FMINNM  S25, S26, S24
    FMAX  H2, H20, H2
    FMINNM  D27, D13, D11
    FMAX  H8, H11, H2
    FMAX  D25, D11, D3
    FMINNM  D10, D9, D3
    FMAX  D7, D24, D27
    FMIN  H7, H10, H26
    FMAXNM  D20, D12, D20
    FMIN  H7, H14, H1
    FMINNM  H26, H12, H29
    FMIN  H0, H11, H6
    FMAX  H19, H25, H15
    FMINNM  S16, S0, S10
    FMAXNM  S4, S4, S11
    FMINNM  D11, D23, D19
    FMAXNM  S16, S21, S13
    FMAXNM  S6, S3, S22
    FMAX  D26, D30, D21
    FMINNM  H16, H28, H11
    FMAXNM  S25, S4, S27
    FMAXNM  D9, D11, D4
    FMIN  H29, H25, H23
    FMIN  H5, H18, H7
    SUBS  X16, X16, #0x1
    B.NE  TaishanFpMovMaddP01_label_413
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X3, X16, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X15, X3, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X7, X24, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X15, X25, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X9, X18, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X5, X8, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X26, X18, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X4, X5, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X25, X7, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X5, X22, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X6, X28, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X29, X21, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
TaishanFpMovMaddP01_label_426:
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X13, X29, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X22, X7, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
TaishanFpMovMaddP01_label_138:
    FMOV  X15, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X22, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D27
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0xd53c, LSL #0
    MOVK  X2, #0xd968, LSL #16
    MOVK  X2, #0xe38b, LSL #32
    MOVK  X2, #0x85f2, LSL #48
    MOVZ  X3, #0x3487, LSL #0
    MOVK  X3, #0x26a4, LSL #16
    MOVK  X3, #0x29fb, LSL #32
    MOVK  X3, #0x646e, LSL #48
    MOVZ  X4, #0x743c, LSL #0
    MOVK  X4, #0x7258, LSL #16
    MOVK  X4, #0xf6ea, LSL #32
    MOVK  X4, #0x6105, LSL #48
    MOVZ  X5, #0x56f, LSL #0
    MOVK  X5, #0xe32, LSL #16
    MOVK  X5, #0x79a9, LSL #32
    MOVK  X5, #0x53a6, LSL #48
    MOVZ  X6, #0x1374, LSL #0
    MOVK  X6, #0xbada, LSL #16
    MOVK  X6, #0x9307, LSL #32
    MOVK  X6, #0xf6fd, LSL #48
    MOVZ  X7, #0x3eeb, LSL #0
    MOVK  X7, #0x71fa, LSL #16
    MOVK  X7, #0xf94b, LSL #32
    MOVK  X7, #0x5cfe, LSL #48
    MOVZ  X8, #0xdbfc, LSL #0
    MOVK  X8, #0xa72f, LSL #16
    MOVK  X8, #0x1d0f, LSL #32
    MOVK  X8, #0x6f84, LSL #48
    MOVZ  X9, #0x35ea, LSL #0
    MOVK  X9, #0xb571, LSL #16
    MOVK  X9, #0x908, LSL #32
    MOVK  X9, #0x9839, LSL #48
    MOVZ  X10, #0xab, LSL #0
    MOVK  X10, #0x6307, LSL #16
    MOVK  X10, #0x6594, LSL #32
    MOVK  X10, #0x6962, LSL #48
    MOVZ  X11, #0xec96, LSL #0
    MOVK  X11, #0x6085, LSL #16
    MOVK  X11, #0x8716, LSL #32
    MOVK  X11, #0x4035, LSL #48
    MOVZ  X13, #0xdfef, LSL #0
    MOVK  X13, #0x2696, LSL #16
    MOVK  X13, #0xcb4, LSL #32
    MOVK  X13, #0x5fbc, LSL #48
    MOVZ  X14, #0x22, LSL #0
    MOVK  X14, #0x6c25, LSL #16
    MOVK  X14, #0xa4a9, LSL #32
    MOVK  X14, #0x6aac, LSL #48
    MOVZ  X15, #0x517a, LSL #0
    MOVK  X15, #0xbead, LSL #16
    MOVK  X15, #0xef1e, LSL #32
    MOVK  X15, #0xcbc8, LSL #48
    MOVZ  X16, #0x1135, LSL #0
    MOVK  X16, #0xbf3d, LSL #16
    MOVK  X16, #0x523f, LSL #32
    MOVK  X16, #0x47a8, LSL #48
    MOVZ  X17, #0x2b47, LSL #0
    MOVK  X17, #0x926, LSL #16
    MOVK  X17, #0x8d98, LSL #32
    MOVK  X17, #0x5f68, LSL #48
    MOVZ  X18, #0x722c, LSL #0
    MOVK  X18, #0xfa86, LSL #16
    MOVK  X18, #0x3c6a, LSL #32
    MOVK  X18, #0x2a64, LSL #48
    MOVZ  X19, #0xbff3, LSL #0
    MOVK  X19, #0x248a, LSL #16
    MOVK  X19, #0x6dd6, LSL #32
    MOVK  X19, #0x2dfa, LSL #48
    MOVZ  X20, #0xd8a2, LSL #0
    MOVK  X20, #0x561a, LSL #16
    MOVK  X20, #0x7d37, LSL #32
    MOVK  X20, #0xd1b, LSL #48
    MOVZ  X21, #0x5a23, LSL #0
    MOVK  X21, #0xbfc2, LSL #16
    MOVK  X21, #0xe62d, LSL #32
    MOVK  X21, #0xb992, LSL #48
    MOVZ  X22, #0xea3f, LSL #0
    MOVK  X22, #0x3c6e, LSL #16
    MOVK  X22, #0x5f89, LSL #32
    MOVK  X22, #0xea6c, LSL #48
    MOVZ  X23, #0x127d, LSL #0
    MOVK  X23, #0xd67b, LSL #16
    MOVK  X23, #0xfb66, LSL #32
    MOVK  X23, #0xd53c, LSL #48
    MOVZ  X24, #0xfcf1, LSL #0
    MOVK  X24, #0x99e4, LSL #16
    MOVK  X24, #0x231e, LSL #32
    MOVK  X24, #0xf8, LSL #48
    MOVZ  X25, #0x26eb, LSL #0
    MOVK  X25, #0xbbb, LSL #16
    MOVK  X25, #0xab7d, LSL #32
    MOVK  X25, #0x633d, LSL #48
    MOVZ  X26, #0xe264, LSL #0
    MOVK  X26, #0x73c0, LSL #16
    MOVK  X26, #0x1bb6, LSL #32
    MOVK  X26, #0x8950, LSL #48
    MOVZ  X27, #0x2081, LSL #0
    MOVK  X27, #0x48fc, LSL #16
    MOVK  X27, #0xf06b, LSL #32
    MOVK  X27, #0x258e, LSL #48
    MOVZ  X28, #0x4685, LSL #0
    MOVK  X28, #0x9a87, LSL #16
    MOVK  X28, #0x5955, LSL #32
    MOVK  X28, #0xb11b, LSL #48
    MOVZ  X29, #0x1481, LSL #0
    MOVK  X29, #0x7814, LSL #16
    MOVK  X29, #0xcc00, LSL #32
    MOVK  X29, #0xb7fe, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X17
    FMOV  D1, X25
    FMOV  V1.D[1], X23
    FMOV  D2, X10
    FMOV  V2.D[1], X26
    FMOV  D3, X6
    FMOV  V3.D[1], X25
    FMOV  D4, X2
    FMOV  V4.D[1], X3
    FMOV  D5, X8
    FMOV  V5.D[1], X20
    FMOV  D6, X10
    FMOV  V6.D[1], X5
    FMOV  D7, X24
    FMOV  V7.D[1], X17
    FMOV  D8, X4
    FMOV  V8.D[1], X10
    FMOV  D9, X29
    FMOV  V9.D[1], X9
    FMOV  D10, X3
    FMOV  V10.D[1], X17
    FMOV  D11, X9
    FMOV  V11.D[1], X3
    FMOV  D12, X10
    FMOV  V12.D[1], X27
    FMOV  D13, X13
    FMOV  V13.D[1], X10
    FMOV  D14, X18
    FMOV  V14.D[1], X8
    FMOV  D15, X15
    FMOV  V15.D[1], X13
    FMOV  D16, X4
    FMOV  V16.D[1], X26
    FMOV  D17, X21
    FMOV  V17.D[1], X13
    FMOV  D18, X13
    FMOV  V18.D[1], X27
    FMOV  D19, X14
    FMOV  V19.D[1], X17
    FMOV  D20, X24
    FMOV  V20.D[1], X27
    FMOV  D21, X9
    FMOV  V21.D[1], X4
    FMOV  D22, X17
    FMOV  V22.D[1], X14
    FMOV  D23, X29
    FMOV  V23.D[1], X6
    FMOV  D24, X18
    FMOV  V24.D[1], X16
    FMOV  D25, X13
    FMOV  V25.D[1], X7
    FMOV  D26, X19
    FMOV  V26.D[1], X29
    FMOV  D27, X4
    FMOV  V27.D[1], X14
    FMOV  D28, X13
    FMOV  V28.D[1], X7
    FMOV  D29, X20
    FMOV  V29.D[1], X14
    FMOV  D30, X14
    FMOV  V30.D[1], X6
    FMOV  D31, X28
    FMOV  V31.D[1], X7
    MOVZ  X19, #0xa, LSL #0
TaishanFpMovMaddP01_label_493:
    FMAXNM  D24, D26, D0
    FMAXNM  S0, S25, S9
    FMINNM  H9, H23, H1
    FMAXNM  S31, S20, S14
    FMINNM  D5, D1, D17
    FMAX  D15, D30, D31
    FMIN  D31, D6, D16
    FMIN  S13, S2, S16
    FMAX  H26, H6, H31
    FMIN  D23, D26, D4
    FMINNM  S23, S23, S20
    FMAX  D4, D4, D23
    FMAX  S26, S28, S18
    FMAXNM  D11, D15, D11
    FMAX  D18, D14, D4
    FMAXNM  H20, H24, H21
    FMINNM  D26, D17, D5
    FMIN  H4, H26, H27
    FMAXNM  H30, H4, H13
    FMINNM  H25, H15, H31
    FMAXNM  D9, D11, D18
    FMAX  D5, D25, D26
    FMINNM  S5, S0, S15
    FMAX  D31, D14, D23
    FMINNM  H30, H4, H30
    FMINNM  H20, H27, H30
    FMAXNM  D26, D15, D3
    FMINNM  D27, D31, D16
    FMAXNM  D18, D2, D27
    FMINNM  D14, D18, D18
    FMIN  S3, S26, S30
    FMINNM  D12, D16, D1
    FMAXNM  H10, H5, H11
    FMIN  D9, D15, D25
    FMAX  D23, D5, D27
    FMAXNM  S5, S24, S2
    FMIN  D0, D15, D7
    FMAXNM  H6, H4, H12
    FMAX  H11, H24, H20
    FMINNM  H11, H15, H23
    FMAXNM  S23, S17, S12
    FMAX  H22, H11, H19
    FMINNM  D8, D6, D9
    FMIN  H0, H21, H18
    FMIN  H19, H9, H9
    FMAXNM  D17, D20, D11
    FMIN  H30, H11, H3
    FMAXNM  H12, H10, H18
    FMIN  D13, D15, D12
    FMAX  S29, S7, S23
    FMAX  D22, D4, D0
    FMAX  S2, S17, S6
    FMAX  H5, H25, H2
    FMINNM  H4, H1, H1
    FMAX  D7, D30, D18
    FMAX  S21, S11, S24
    FMAXNM  H20, H3, H8
    FMIN  H17, H22, H14
    FMAXNM  H25, H20, H26
    FMINNM  H24, H1, H5
    FMAX  D0, D10, D14
    FMINNM  S3, S20, S28
    FMIN  D12, D17, D11
    FMAXNM  S7, S22, S4
    FMAX  S27, S27, S19
    FMIN  D5, D3, D10
    FMINNM  S7, S3, S19
    FMIN  D20, D14, D8
    FMAXNM  D18, D29, D14
    FMINNM  S28, S19, S13
    FMIN  H21, H0, H20
    FMAXNM  S22, S26, S3
    FMINNM  D14, D2, D12
    FMIN  S27, S8, S19
    FMAX  D22, D21, D25
    FMIN  S3, S14, S25
    FMINNM  H31, H27, H20
    FMIN  D22, D30, D6
    FMINNM  S2, S9, S17
    FMAXNM  H10, H12, H30
    FMAX  S13, S18, S18
    FMAXNM  S12, S7, S20
    FMAXNM  D29, D16, D17
    FMIN  D10, D22, D1
    FMIN  S18, S22, S0
    FMAXNM  H3, H28, H16
    FMIN  D13, D18, D8
    FMAXNM  H7, H11, H5
    FMAX  H2, H16, H3
    FMAX  D11, D31, D4
    FMAX  H20, H9, H24
    FMIN  D19, D29, D11
    FMIN  D6, D2, D26
    FMINNM  H18, H17, H12
    FMAX  H31, H19, H16
    FMAXNM  D2, D3, D17
    FMAX  S4, S16, S13
    FMINNM  D25, D12, D6
    FMAX  D28, D31, D26
    FMIN  H10, H18, H2
    FMIN  H17, H28, H30
    FMINNM  D27, D6, D17
    FMIN  D12, D28, D23
    FMAX  H28, H18, H28
    FMINNM  D20, D0, D22
    FMIN  D25, D2, D9
    FMIN  S18, S12, S1
    FMAX  H8, H7, H29
    FMAX  D30, D22, D4
    FMIN  D9, D7, D8
    FMIN  S17, S0, S26
    FMIN  S6, S5, S26
    FMINNM  H9, H9, H26
    FMAX  D28, D1, D9
    FMAX  H23, H26, H19
    FMINNM  S5, S17, S30
    FMAXNM  H0, H14, H8
    FMAX  H7, H22, H2
    FMAXNM  S8, S27, S20
    FMIN  S22, S23, S9
    FMAXNM  H9, H25, H28
    FMINNM  H2, H19, H9
    FMAX  S5, S12, S2
    FMIN  D25, D26, D18
    FMIN  H12, H23, H29
    FMAXNM  S13, S21, S27
    FMAX  S21, S19, S14
    FMIN  S12, S21, S15
    FMIN  H4, H31, H3
    FMIN  H28, H2, H2
    FMAX  D8, D2, D5
    FMAX  H2, H1, H18
    FMAXNM  H6, H15, H30
    FMAXNM  H1, H2, H0
    FMINNM  D22, D28, D1
    FMIN  S10, S21, S24
    FMIN  S7, S27, S29
    FMAXNM  H19, H26, H20
    FMIN  S24, S23, S24
    FMINNM  H14, H11, H12
    FMINNM  D25, D16, D5
    FMINNM  D19, D21, D17
    FMAXNM  D29, D12, D30
    FMINNM  S4, S18, S7
    FMAXNM  D10, D2, D21
    FMIN  H3, H8, H21
    FMIN  H15, H26, H21
    FMINNM  S12, S22, S24
    FMAX  D14, D14, D6
    FMINNM  S18, S10, S6
    FMIN  H12, H21, H25
    FMAXNM  S21, S10, S27
    FMINNM  D7, D24, D18
    FMAX  H23, H12, H18
    FMINNM  D15, D16, D19
    FMIN  H22, H15, H14
    FMAX  S31, S6, S9
    FMIN  H31, H31, H7
    FMAX  S12, S25, S30
    FMINNM  S4, S29, S5
    FMAXNM  D6, D9, D31
    FMAXNM  H23, H0, H17
    FMIN  S21, S3, S6
    FMAXNM  D22, D21, D28
    FMAX  H17, H27, H12
    FMAXNM  S4, S8, S26
    FMAX  D7, D22, D17
    FMAX  H9, H12, H23
    FMINNM  D9, D5, D7
    FMINNM  D0, D2, D27
    FMINNM  S4, S2, S16
    FMAX  H5, H10, H7
    FMINNM  H5, H20, H7
    FMINNM  S23, S21, S4
    FMIN  S24, S3, S1
    FMAX  S9, S9, S16
    FMAXNM  S15, S9, S10
    FMAX  D15, D2, D14
    FMAXNM  D12, D24, D15
    FMINNM  S3, S28, S20
    FMAX  H16, H4, H8
    FMAXNM  S0, S5, S20
    FMAXNM  H5, H23, H11
    FMINNM  S3, S29, S21
    FMIN  D25, D11, D21
    FMINNM  D13, D16, D14
    FMAXNM  S21, S4, S5
    FMINNM  S16, S25, S6
    FMAXNM  S31, S14, S16
    FMAX  D8, D26, D21
    FMINNM  S18, S28, S12
    FMINNM  S12, S6, S29
    FMAX  H28, H9, H26
    FMIN  D2, D31, D27
    FMIN  H12, H26, H22
    FMAX  D7, D24, D9
    FMAXNM  S30, S31, S13
    FMINNM  H19, H22, H1
    FMIN  S17, S3, S17
    FMAXNM  D0, D21, D3
    SUBS  X19, X19, #0x1
    B.NE  TaishanFpMovMaddP01_label_493
    MOVZ  X14, #0xd53c, LSL #0
    MOVK  X14, #0xd968, LSL #16
    MOVK  X14, #0xe38b, LSL #32
    MOVK  X14, #0x85f2, LSL #48
    SUB  X17, X14, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x3487, LSL #0
    MOVK  X19, #0x26a4, LSL #16
    MOVK  X19, #0x29fb, LSL #32
    MOVK  X19, #0x646e, LSL #48
    SUB  X25, X19, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x743c, LSL #0
    MOVK  X4, #0x7258, LSL #16
    MOVK  X4, #0xf6ea, LSL #32
    MOVK  X4, #0x6105, LSL #48
    SUB  X5, X4, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x1374, LSL #0
    MOVK  X8, #0xbada, LSL #16
    MOVK  X8, #0x9307, LSL #32
    MOVK  X8, #0xf6fd, LSL #48
    SUB  X2, X8, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x3eeb, LSL #0
    MOVK  X9, #0x71fa, LSL #16
    MOVK  X9, #0xf94b, LSL #32
    MOVK  X9, #0x5cfe, LSL #48
    SUB  X5, X9, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x1374, LSL #0
    MOVK  X16, #0xbada, LSL #16
    MOVK  X16, #0x9307, LSL #32
    MOVK  X16, #0xf6fd, LSL #48
    SUB  X4, X16, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x3eeb, LSL #0
    MOVK  X4, #0x71fa, LSL #16
    MOVK  X4, #0xf94b, LSL #32
    MOVK  X4, #0x5cfe, LSL #48
    SUB  X9, X4, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0xab, LSL #0
    MOVK  X7, #0x6307, LSL #16
    MOVK  X7, #0x6594, LSL #32
    MOVK  X7, #0x6962, LSL #48
    SUB  X6, X7, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0xec96, LSL #0
    MOVK  X19, #0x6085, LSL #16
    MOVK  X19, #0x8716, LSL #32
    MOVK  X19, #0x4035, LSL #48
    SUB  X20, X19, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0xdfef, LSL #0
    MOVK  X23, #0x2696, LSL #16
    MOVK  X23, #0xcb4, LSL #32
    MOVK  X23, #0x5fbc, LSL #48
    SUB  X4, X23, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0xd53c, LSL #0
    MOVK  X10, #0xd968, LSL #16
    MOVK  X10, #0xe38b, LSL #32
    MOVK  X10, #0x85f2, LSL #48
    SUB  X9, X10, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x517a, LSL #0
    MOVK  X9, #0xbead, LSL #16
    MOVK  X9, #0xef1e, LSL #32
    MOVK  X9, #0xcbc8, LSL #48
    SUB  X15, X9, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x1374, LSL #0
    MOVK  X5, #0xbada, LSL #16
    MOVK  X5, #0x9307, LSL #32
    MOVK  X5, #0xf6fd, LSL #48
    SUB  X10, X5, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x722c, LSL #0
    MOVK  X23, #0xfa86, LSL #16
    MOVK  X23, #0x3c6a, LSL #32
    MOVK  X23, #0x2a64, LSL #48
    SUB  X13, X23, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0xec96, LSL #0
    MOVK  X10, #0x6085, LSL #16
    MOVK  X10, #0x8716, LSL #32
    MOVK  X10, #0x4035, LSL #48
    SUB  X13, X10, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x5a23, LSL #0
    MOVK  X5, #0xbfc2, LSL #16
    MOVK  X5, #0xe62d, LSL #32
    MOVK  X5, #0xb992, LSL #48
    SUB  X19, X5, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0xea3f, LSL #0
    MOVK  X26, #0x3c6e, LSL #16
    MOVK  X26, #0x5f89, LSL #32
    MOVK  X26, #0xea6c, LSL #48
    SUB  X20, X26, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x722c, LSL #0
    MOVK  X17, #0xfa86, LSL #16
    MOVK  X17, #0x3c6a, LSL #32
    MOVK  X17, #0x2a64, LSL #48
    SUB  X21, X17, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0xfcf1, LSL #0
    MOVK  X27, #0x99e4, LSL #16
    MOVK  X27, #0x231e, LSL #32
    MOVK  X27, #0xf8, LSL #48
    SUB  X18, X27, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0xea3f, LSL #0
    MOVK  X7, #0x3c6e, LSL #16
    MOVK  X7, #0x5f89, LSL #32
    MOVK  X7, #0xea6c, LSL #48
    SUB  X27, X7, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x1481, LSL #0
    MOVK  X19, #0x7814, LSL #16
    MOVK  X19, #0xcc00, LSL #32
    MOVK  X19, #0xb7fe, LSL #48
    SUB  X13, X19, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D3
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D4
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D15
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D21
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X28
    FMOV  V0.D[1], X6
    FMOV  D1, X14
    FMOV  V1.D[1], X7
    FMOV  D2, X26
    FMOV  V2.D[1], X11
    FMOV  D3, X11
    FMOV  V3.D[1], X16
    FMOV  D4, X6
    FMOV  V4.D[1], X7
    FMOV  D5, X27
    FMOV  V5.D[1], X5
    FMOV  D6, X9
    FMOV  V6.D[1], X11
    FMOV  D7, X21
    FMOV  V7.D[1], X25
    FMOV  D8, X3
    FMOV  V8.D[1], X3
    FMOV  D9, X8
    FMOV  V9.D[1], X4
    FMOV  D10, X11
    FMOV  V10.D[1], X14
    FMOV  D11, X8
    FMOV  V11.D[1], X20
    FMOV  D12, X10
    FMOV  V12.D[1], X8
    FMOV  D13, X16
    FMOV  V13.D[1], X2
    FMOV  D14, X21
    FMOV  V14.D[1], X18
    FMOV  D15, X15
    FMOV  V15.D[1], X28
    FMOV  D16, X6
    FMOV  V16.D[1], X14
    FMOV  D17, X3
    FMOV  V17.D[1], X29
    FMOV  D18, X15
    FMOV  V18.D[1], X5
    FMOV  D19, X9
    FMOV  V19.D[1], X3
    FMOV  D20, X11
    FMOV  V20.D[1], X4
    FMOV  D21, X17
    FMOV  V21.D[1], X2
    FMOV  D22, X16
    FMOV  V22.D[1], X14
    FMOV  D23, X6
    FMOV  V23.D[1], X11
    FMOV  D24, X28
    FMOV  V24.D[1], X24
    FMOV  D25, X6
    FMOV  V25.D[1], X18
    FMOV  D26, X13
    FMOV  V26.D[1], X24
    FMOV  D27, X8
    FMOV  V27.D[1], X13
    FMOV  D28, X10
    FMOV  V28.D[1], X27
    FMOV  D29, X14
    FMOV  V29.D[1], X13
    FMOV  D30, X4
    FMOV  V30.D[1], X16
    FMOV  D31, X5
    FMOV  V31.D[1], X15
    MOVZ  X18, #0xa, LSL #0
TaishanFpMovMaddP01_label_575:
    FMAXNM  S5, S28, S0
    FMAX  D26, D10, D12
    FMAX  H0, H10, H8
    FMIN  D4, D24, D15
    FMAXNM  S19, S10, S21
    FMINNM  H16, H4, H6
    FMINNM  H14, H19, H10
    FMIN  H5, H18, H1
    FMIN  S9, S5, S12
    FMAX  S6, S13, S8
    FMAXNM  H27, H26, H30
    FMIN  D6, D14, D23
    FMIN  S25, S8, S15
    FMAXNM  S9, S24, S14
    FMAX  H5, H16, H16
    FMAXNM  S3, S8, S7
    FMAXNM  S13, S15, S1
    FMINNM  H25, H21, H14
    FMAX  S23, S4, S5
    FMINNM  D15, D9, D20
    FMIN  S1, S4, S16
    FMIN  H24, H9, H10
    FMAXNM  H5, H23, H31
    FMAXNM  D21, D30, D1
    FMINNM  D13, D11, D30
    FMAX  D6, D25, D20
    FMIN  H29, H28, H27
    FMIN  D31, D9, D0
    FMIN  D9, D18, D18
    FMAX  S13, S16, S18
    FMAXNM  H31, H1, H29
    FMINNM  S28, S3, S16
    FMAXNM  D6, D19, D5
    FMAX  H6, H14, H6
    FMAX  H3, H30, H0
    FMIN  H7, H20, H15
    FMIN  H24, H13, H0
    FMINNM  D9, D10, D11
    FMINNM  H10, H22, H30
    FMIN  S26, S21, S9
    FMIN  S9, S21, S31
    FMINNM  S11, S20, S16
    FMIN  D3, D25, D30
    FMAX  D16, D31, D0
    FMIN  D28, D7, D16
    FMIN  H17, H14, H16
    FMIN  S2, S22, S26
    FMAX  S10, S27, S8
    FMIN  S10, S27, S26
    FMIN  S6, S18, S26
    FMAXNM  S23, S28, S6
    FMINNM  D23, D13, D28
    FMINNM  S15, S29, S31
    FMIN  H22, H25, H23
    FMIN  S20, S6, S30
    FMAXNM  H24, H29, H11
    FMAXNM  D25, D8, D15
    FMINNM  S19, S6, S8
    FMIN  D13, D5, D31
    FMAX  D16, D2, D12
    FMIN  D3, D31, D23
    FMAXNM  S18, S4, S0
    FMINNM  S9, S12, S31
    FMAX  H24, H27, H31
    FMIN  H5, H15, H10
    FMAXNM  H26, H29, H13
    FMIN  D22, D15, D3
    FMAXNM  S2, S2, S20
    FMIN  H20, H26, H8
    FMAXNM  S15, S30, S11
    FMAX  H9, H31, H25
    FMAXNM  S14, S20, S22
    FMIN  D31, D31, D23
    FMINNM  H19, H22, H11
    FMAX  H3, H17, H16
    FMINNM  S15, S21, S15
    FMIN  H31, H9, H22
    FMINNM  H26, H0, H6
    FMIN  D26, D19, D21
    FMIN  D13, D28, D17
    FMAXNM  D11, D27, D25
    FMIN  S13, S2, S18
    FMINNM  H14, H3, H8
    FMAXNM  H20, H21, H0
    FMAXNM  H29, H11, H30
    FMINNM  H0, H29, H0
    FMIN  H31, H15, H26
    FMIN  H15, H5, H0
    FMIN  H5, H9, H13
    FMAX  S3, S9, S8
    FMINNM  D15, D10, D19
    FMIN  D31, D31, D15
    FMIN  D28, D12, D22
    FMAXNM  H11, H3, H6
    FMIN  D20, D24, D5
    FMAXNM  D28, D22, D19
    FMINNM  H22, H25, H29
    FMAX  H20, H31, H27
    FMAX  H25, H14, H6
    FMIN  D0, D21, D29
    FMAXNM  S25, S3, S0
    FMINNM  D13, D5, D19
    FMINNM  S6, S26, S26
    FMAXNM  S11, S11, S12
    FMIN  H17, H11, H15
    FMIN  S17, S4, S29
    FMINNM  H28, H19, H22
    FMAXNM  S17, S2, S6
    FMIN  H15, H25, H9
    FMAXNM  S15, S5, S29
    FMINNM  D20, D24, D17
    FMAX  H15, H22, H30
    FMAXNM  H3, H16, H28
    FMAXNM  D30, D13, D22
    FMINNM  D26, D5, D19
    FMIN  S1, S29, S20
    FMAXNM  D19, D4, D1
    FMAX  H14, H13, H26
    FMINNM  S18, S30, S27
    FMAXNM  D22, D24, D31
    FMAXNM  S21, S28, S15
    FMINNM  D3, D24, D12
    FMAX  H0, H16, H9
    FMINNM  D6, D24, D28
    FMINNM  H6, H22, H15
    FMAX  D16, D27, D9
    FMAXNM  S9, S16, S5
    FMINNM  H22, H0, H0
    FMAXNM  S25, S25, S20
    FMIN  S12, S13, S25
    FMAXNM  S27, S21, S8
    FMINNM  H12, H22, H9
    FMIN  S9, S30, S29
    FMIN  S11, S24, S8
    FMIN  S12, S0, S22
    FMIN  D27, D25, D1
    FMAXNM  D29, D14, D31
    FMAX  S16, S16, S15
    FMAX  D14, D19, D17
    FMINNM  H27, H31, H16
    FMIN  H14, H3, H16
    FMIN  S25, S22, S6
    FMINNM  H0, H5, H2
    FMINNM  S12, S2, S11
    FMAXNM  H25, H29, H18
    FMAX  H11, H0, H9
    FMAX  H1, H7, H3
    FMIN  H24, H14, H30
    FMINNM  S14, S7, S20
    FMINNM  D25, D22, D19
    FMAX  H9, H18, H12
    FMAX  S16, S5, S14
    FMAX  D8, D20, D1
    FMAX  D14, D13, D25
    FMINNM  D16, D22, D27
    FMIN  H17, H17, H31
    FMINNM  S7, S31, S18
    FMAXNM  D8, D13, D0
    FMAXNM  D15, D10, D3
    FMINNM  D2, D13, D22
    FMAX  H18, H11, H25
    FMAXNM  D7, D8, D4
    FMAX  S21, S22, S7
    FMAX  H22, H19, H29
    FMINNM  D16, D24, D27
    FMAX  H7, H16, H26
    FMIN  S1, S10, S5
    FMAXNM  D6, D31, D2
    FMAXNM  S18, S26, S27
    FMIN  D19, D27, D3
    FMAXNM  S6, S26, S29
    FMIN  S18, S28, S3
    FMAX  S2, S6, S7
    FMAX  H27, H1, H0
    FMINNM  S13, S1, S29
    FMAX  S31, S0, S26
    FMIN  D1, D11, D2
    FMAX  S14, S19, S10
    FMAXNM  S8, S3, S24
    FMIN  D19, D2, D28
    FMAXNM  H0, H11, H16
    FMAX  H5, H15, H5
    FMIN  D21, D19, D2
    FMINNM  H21, H5, H14
    FMIN  S1, S22, S21
    FMAXNM  H8, H31, H11
    FMAXNM  H17, H30, H19
    FMINNM  S15, S24, S28
    FMAX  D17, D26, D21
    FMIN  D3, D0, D17
    FMAXNM  D4, D19, D5
    FMAXNM  D20, D17, D14
    FMAXNM  S4, S7, S29
    FMAXNM  H10, H17, H20
    FMAXNM  S18, S13, S19
    FMIN  H6, H24, H7
    FMIN  H16, H9, H8
    FMINNM  H22, H14, H28
    FMAXNM  S29, S5, S31
    FMAXNM  S3, S1, S9
    SUBS  X18, X18, #0x1
    B.NE  TaishanFpMovMaddP01_label_575
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D3
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D6
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D13
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D17
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D26
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
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
    FMOV  D0, X19
    FMOV  V0.D[1], X4
    FMOV  D1, X24
    FMOV  V1.D[1], X22
    FMOV  D2, X13
    FMOV  V2.D[1], X5
    FMOV  D3, X28
    FMOV  V3.D[1], X29
    FMOV  D4, X29
    FMOV  V4.D[1], X18
    FMOV  D5, X3
    FMOV  V5.D[1], X16
    FMOV  D6, X8
    FMOV  V6.D[1], X18
    FMOV  D7, X18
    FMOV  V7.D[1], X3
    FMOV  D8, X17
    FMOV  V8.D[1], X4
    FMOV  D9, X22
    FMOV  V9.D[1], X15
    FMOV  D10, X17
    FMOV  V10.D[1], X28
    FMOV  D11, X20
    FMOV  V11.D[1], X8
    FMOV  D12, X3
    FMOV  V12.D[1], X21
    FMOV  D13, X10
    FMOV  V13.D[1], X13
    FMOV  D14, X18
    FMOV  V14.D[1], X28
    FMOV  D15, X25
    FMOV  V15.D[1], X20
    FMOV  D16, X7
    FMOV  V16.D[1], X15
    FMOV  D17, X15
    FMOV  V17.D[1], X3
    FMOV  D18, X25
    FMOV  V18.D[1], X28
    FMOV  D19, X6
    FMOV  V19.D[1], X11
    FMOV  D20, X20
    FMOV  V20.D[1], X5
    FMOV  D21, X23
    FMOV  V21.D[1], X14
    FMOV  D22, X11
    FMOV  V22.D[1], X17
    FMOV  D23, X4
    FMOV  V23.D[1], X7
    FMOV  D24, X19
    FMOV  V24.D[1], X6
    FMOV  D25, X19
    FMOV  V25.D[1], X3
    FMOV  D26, X5
    FMOV  V26.D[1], X17
    FMOV  D27, X27
    FMOV  V27.D[1], X2
    FMOV  D28, X3
    FMOV  V28.D[1], X3
    FMOV  D29, X5
    FMOV  V29.D[1], X6
    FMOV  D30, X7
    FMOV  V30.D[1], X28
    FMOV  D31, X22
    FMOV  V31.D[1], X20
    MOVZ  X13, #0xf, LSL #0
TaishanFpMovMaddP01_label_657:
    FMINNM  D3, D13, D5
    FMAXNM  D26, D20, D26
    FMAX  H19, H27, H0
    FMAX  S23, S23, S7
    FMAX  S16, S5, S29
    FMINNM  D2, D29, D12
    FMAX  S6, S5, S13
    FMIN  S4, S2, S16
    FMINNM  S14, S6, S8
    FMINNM  D19, D5, D30
    FMIN  S31, S0, S19
    FMIN  S3, S22, S27
    FMINNM  S0, S31, S22
    FMAX  D29, D28, D13
    FMAX  H28, H12, H9
    FMAX  S6, S8, S27
    FMIN  S20, S18, S16
    FMAX  H20, H14, H23
    FMAX  S23, S7, S4
    FMINNM  H20, H29, H27
    FMINNM  H9, H2, H21
    FMINNM  H6, H5, H6
    FMIN  H9, H27, H0
    FMAXNM  H17, H26, H24
    FMAXNM  S30, S16, S31
    FMAXNM  D18, D10, D15
    FMINNM  S9, S10, S8
    FMIN  D3, D7, D14
    FMAXNM  D27, D3, D6
    FMINNM  H9, H26, H18
    FMAX  S30, S6, S29
    FMINNM  S27, S9, S30
    FMINNM  S31, S12, S1
    FMIN  S9, S28, S0
    FMAXNM  H0, H9, H14
    FMIN  H15, H12, H21
    FMIN  H6, H26, H5
    FMIN  D5, D23, D7
    FMAX  H12, H19, H12
    FMAXNM  D0, D9, D30
    FMIN  S5, S25, S9
    FMIN  S1, S16, S17
    FMAXNM  S0, S15, S18
    FMAXNM  D1, D30, D11
    FMINNM  S31, S27, S14
    FMINNM  S27, S12, S22
    FMIN  H28, H29, H19
    FMAX  H8, H25, H24
    FMINNM  H13, H6, H27
    FMAX  H3, H24, H20
    FMAXNM  H26, H6, H31
    FMINNM  D6, D21, D3
    FMAXNM  S3, S31, S5
    FMINNM  H26, H22, H14
    FMIN  S8, S16, S1
    FMAX  S19, S26, S25
    FMAX  D19, D26, D25
    FMAX  D6, D20, D18
    FMINNM  S28, S17, S12
    FMAXNM  H13, H29, H0
    FMINNM  S29, S25, S0
    FMAXNM  D8, D29, D3
    FMIN  D1, D6, D9
    FMINNM  D13, D13, D1
    FMIN  D1, D27, D3
    FMIN  D5, D6, D14
    FMAXNM  S20, S10, S11
    FMIN  S0, S4, S27
    FMIN  S13, S0, S26
    FMAX  H12, H19, H9
    FMAX  D12, D17, D9
    FMINNM  H7, H30, H19
    FMIN  S30, S30, S20
    FMAX  S15, S11, S0
    FMINNM  S13, S9, S15
    FMAX  H6, H29, H12
    FMINNM  D0, D7, D8
    FMIN  H26, H24, H22
    FMAX  D4, D9, D28
    FMINNM  D1, D2, D13
    FMAX  D19, D30, D13
    FMAXNM  H21, H30, H2
    FMIN  S17, S29, S8
    FMAX  H28, H3, H31
    FMIN  H8, H4, H12
    FMIN  H7, H21, H21
    FMIN  S10, S31, S20
    FMINNM  S7, S30, S28
    FMIN  D30, D4, D8
    FMAX  D27, D0, D27
    FMAXNM  H27, H12, H0
    FMAXNM  H0, H1, H28
    FMAX  D22, D2, D17
    FMINNM  H26, H29, H13
    FMIN  H11, H2, H21
    FMINNM  H10, H28, H14
    FMIN  D10, D23, D26
    FMAXNM  D11, D21, D19
    FMIN  D28, D28, D26
    FMIN  S26, S29, S18
    FMAX  S5, S28, S23
    FMAX  H8, H21, H8
    FMAXNM  S7, S27, S30
    FMINNM  D14, D30, D19
    FMINNM  D22, D28, D17
    FMAXNM  D2, D28, D26
    FMINNM  D29, D9, D23
    FMAX  S11, S7, S17
    FMAXNM  H14, H10, H6
    FMAX  S8, S22, S0
    FMINNM  S30, S3, S2
    FMINNM  H7, H24, H0
    FMAX  D16, D24, D15
    FMINNM  D13, D18, D13
    FMIN  H10, H21, H29
    FMINNM  D29, D15, D24
    FMAXNM  S0, S30, S12
    FMAXNM  H19, H26, H17
    FMIN  S2, S5, S16
    FMAX  H2, H11, H3
    FMAXNM  D17, D31, D10
    FMAX  S11, S21, S15
    FMIN  H28, H16, H14
    FMIN  S13, S28, S9
    FMAXNM  S9, S29, S10
    FMAXNM  D7, D31, D3
    FMAXNM  D11, D31, D8
    FMAXNM  S7, S11, S16
    FMAX  H9, H1, H25
    FMIN  H11, H20, H31
    FMINNM  H17, H29, H18
    FMAX  H18, H29, H17
    FMAXNM  D23, D10, D19
    FMAX  H26, H5, H30
    FMAX  S4, S7, S11
    FMIN  S21, S10, S15
    FMINNM  H22, H19, H9
    FMAXNM  S9, S28, S25
    FMAXNM  D9, D13, D24
    FMAX  D16, D3, D23
    FMINNM  S17, S23, S8
    FMAX  D12, D16, D27
    FMAX  S6, S1, S20
    FMIN  S11, S23, S11
    FMIN  H17, H28, H30
    FMINNM  D2, D11, D14
    FMAXNM  D18, D20, D5
    FMIN  D4, D4, D27
    FMAX  H29, H17, H28
    FMIN  D28, D9, D14
    FMAX  S2, S4, S3
    FMINNM  S18, S21, S30
    FMAXNM  H26, H21, H7
    FMAXNM  H26, H8, H7
    FMAX  H7, H8, H23
    FMINNM  H8, H24, H24
    FMIN  S24, S4, S12
    FMIN  S31, S3, S22
    FMAX  H12, H1, H10
    FMAXNM  S22, S25, S23
    FMAX  D29, D24, D0
    FMAXNM  D14, D28, D22
    FMINNM  H19, H14, H5
    FMAX  D22, D22, D23
    FMAXNM  S27, S9, S26
    FMAXNM  D24, D5, D31
    FMAXNM  S11, S9, S3
    FMINNM  S20, S30, S1
    FMAX  D11, D7, D4
    FMIN  D31, D20, D4
    FMAX  S3, S17, S14
    FMIN  S10, S29, S21
    FMINNM  H24, H4, H20
    FMINNM  D8, D23, D4
    FMAXNM  H29, H31, H18
    FMAXNM  S1, S19, S2
    FMINNM  D1, D26, D3
    FMAX  S26, S22, S11
    FMIN  S24, S30, S9
    FMINNM  D20, D24, D19
    FMAXNM  H17, H22, H29
    FMAX  S17, S23, S24
    FMAXNM  H25, H4, H14
    FMIN  D10, D3, D27
    FMAXNM  S22, S23, S29
    FMAX  D28, D31, D21
    FMINNM  S28, S8, S4
    FMIN  H15, H14, H8
    FMIN  S1, S28, S28
    FMAX  S5, S0, S1
    FMAX  D21, D27, D5
    FMAXNM  D1, D11, D27
    FMINNM  S17, S29, S4
    FMAX  S2, S20, S21
    FMIN  H1, H25, H2
    FMINNM  H28, H6, H27
    FMAXNM  H14, H18, H30
    FMIN  H20, H7, H1
    FMAX  S23, S11, S7
    FMAXNM  S26, S6, S13
    SUBS  X13, X13, #0x1
    B.NE  TaishanFpMovMaddP01_label_657
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X19, X4, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X2, X14, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X10, X16, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X25, X15, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X28, X5, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X24, X14, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X7, X3, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X21, X10, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X23, X6, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X22, X15, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X15, X13, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X7, X29, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X19, X11, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X22, D14
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D20
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D29
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0xe568, LSL #0
    MOVK  X2, #0x2397, LSL #16
    MOVK  X2, #0x6a8, LSL #32
    MOVK  X2, #0xb854, LSL #48
    MOVZ  X3, #0xd5ae, LSL #0
    MOVK  X3, #0x33c4, LSL #16
    MOVK  X3, #0x7658, LSL #32
    MOVK  X3, #0xf386, LSL #48
    MOVZ  X4, #0xc61f, LSL #0
    MOVK  X4, #0x45c7, LSL #16
    MOVK  X4, #0x24ad, LSL #32
    MOVK  X4, #0x9519, LSL #48
    MOVZ  X5, #0x273, LSL #0
    MOVK  X5, #0x406d, LSL #16
    MOVK  X5, #0xb3c6, LSL #32
    MOVK  X5, #0x9e69, LSL #48
    MOVZ  X6, #0x93d6, LSL #0
    MOVK  X6, #0xa056, LSL #16
    MOVK  X6, #0xcbdc, LSL #32
    MOVK  X6, #0x985, LSL #48
    MOVZ  X7, #0xe9c5, LSL #0
    MOVK  X7, #0x7db, LSL #16
    MOVK  X7, #0x1d62, LSL #32
    MOVK  X7, #0xec90, LSL #48
    MOVZ  X8, #0x8100, LSL #0
    MOVK  X8, #0x9c96, LSL #16
    MOVK  X8, #0x5ce3, LSL #32
    MOVK  X8, #0x5085, LSL #48
    MOVZ  X9, #0xcb8, LSL #0
    MOVK  X9, #0x28df, LSL #16
    MOVK  X9, #0xf344, LSL #32
    MOVK  X9, #0xe781, LSL #48
    MOVZ  X10, #0x1f56, LSL #0
    MOVK  X10, #0x2a5f, LSL #16
    MOVK  X10, #0x66c, LSL #32
    MOVK  X10, #0xc5b3, LSL #48
    MOVZ  X11, #0x6788, LSL #0
    MOVK  X11, #0x1057, LSL #16
    MOVK  X11, #0x7ce7, LSL #32
    MOVK  X11, #0x51eb, LSL #48
    MOVZ  X13, #0x3a29, LSL #0
    MOVK  X13, #0x881f, LSL #16
    MOVK  X13, #0x8043, LSL #32
    MOVK  X13, #0x9729, LSL #48
    MOVZ  X14, #0x5f25, LSL #0
    MOVK  X14, #0xa21e, LSL #16
    MOVK  X14, #0x6d0c, LSL #32
    MOVK  X14, #0xbfc8, LSL #48
    MOVZ  X15, #0xed99, LSL #0
    MOVK  X15, #0x8c38, LSL #16
    MOVK  X15, #0x60fa, LSL #32
    MOVK  X15, #0x8032, LSL #48
    MOVZ  X16, #0x9b40, LSL #0
    MOVK  X16, #0x9e69, LSL #16
    MOVK  X16, #0xba30, LSL #32
    MOVK  X16, #0x4ed5, LSL #48
    MOVZ  X17, #0x1bde, LSL #0
    MOVK  X17, #0x194d, LSL #16
    MOVK  X17, #0xd7dc, LSL #32
    MOVK  X17, #0x5d7b, LSL #48
    MOVZ  X18, #0x8fe4, LSL #0
    MOVK  X18, #0x1f08, LSL #16
    MOVK  X18, #0x304e, LSL #32
    MOVK  X18, #0x71f8, LSL #48
    MOVZ  X19, #0x7732, LSL #0
    MOVK  X19, #0x5a53, LSL #16
    MOVK  X19, #0x3638, LSL #32
    MOVK  X19, #0xaf62, LSL #48
    MOVZ  X20, #0x16b2, LSL #0
    MOVK  X20, #0x7b7f, LSL #16
    MOVK  X20, #0x91f0, LSL #32
    MOVK  X20, #0x529c, LSL #48
    MOVZ  X21, #0xba3c, LSL #0
    MOVK  X21, #0x83f4, LSL #16
    MOVK  X21, #0xf1ec, LSL #32
    MOVK  X21, #0xcf49, LSL #48
    MOVZ  X22, #0xfa46, LSL #0
    MOVK  X22, #0x9a4e, LSL #16
    MOVK  X22, #0x3a6c, LSL #32
    MOVK  X22, #0x5ce4, LSL #48
    MOVZ  X23, #0x2a17, LSL #0
    MOVK  X23, #0x65c3, LSL #16
    MOVK  X23, #0x37da, LSL #32
    MOVK  X23, #0xa651, LSL #48
    MOVZ  X24, #0xbd84, LSL #0
    MOVK  X24, #0xfbe0, LSL #16
    MOVK  X24, #0x5fbf, LSL #32
    MOVK  X24, #0xcb21, LSL #48
    MOVZ  X25, #0xaa4d, LSL #0
    MOVK  X25, #0x3a7b, LSL #16
    MOVK  X25, #0x2e0c, LSL #32
    MOVK  X25, #0x1d09, LSL #48
    MOVZ  X26, #0xddf9, LSL #0
    MOVK  X26, #0x2eec, LSL #16
    MOVK  X26, #0x33a3, LSL #32
    MOVK  X26, #0x882a, LSL #48
    MOVZ  X27, #0xff4e, LSL #0
    MOVK  X27, #0x34c3, LSL #16
    MOVK  X27, #0x3763, LSL #32
    MOVK  X27, #0x7456, LSL #48
    MOVZ  X28, #0xe33a, LSL #0
    MOVK  X28, #0x6489, LSL #16
    MOVK  X28, #0x1e72, LSL #32
    MOVK  X28, #0xde16, LSL #48
    MOVZ  X29, #0xcfc3, LSL #0
    MOVK  X29, #0x7ae9, LSL #16
    MOVK  X29, #0x4a29, LSL #32
    MOVK  X29, #0x3654, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X9
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X16
    FMOV  V2.D[1], X17
    FMOV  D3, X21
    FMOV  V3.D[1], X7
    FMOV  D4, X8
    FMOV  V4.D[1], X2
    FMOV  D5, X7
    FMOV  V5.D[1], X29
    FMOV  D6, X14
    FMOV  V6.D[1], X10
    FMOV  D7, X28
    FMOV  V7.D[1], X10
    FMOV  D8, X24
    FMOV  V8.D[1], X20
    FMOV  D9, X24
    FMOV  V9.D[1], X14
    FMOV  D10, X11
    FMOV  V10.D[1], X28
    FMOV  D11, X13
    FMOV  V11.D[1], X20
    FMOV  D12, X25
    FMOV  V12.D[1], X19
    FMOV  D13, X24
    FMOV  V13.D[1], X16
    FMOV  D14, X11
    FMOV  V14.D[1], X23
    FMOV  D15, X15
    FMOV  V15.D[1], X15
    FMOV  D16, X16
    FMOV  V16.D[1], X14
    FMOV  D17, X21
    FMOV  V17.D[1], X26
    FMOV  D18, X17
    FMOV  V18.D[1], X9
    FMOV  D19, X10
    FMOV  V19.D[1], X10
    FMOV  D20, X27
    FMOV  V20.D[1], X5
    FMOV  D21, X15
    FMOV  V21.D[1], X28
    FMOV  D22, X29
    FMOV  V22.D[1], X17
    FMOV  D23, X25
    FMOV  V23.D[1], X10
    FMOV  D24, X15
    FMOV  V24.D[1], X3
    FMOV  D25, X11
    FMOV  V25.D[1], X28
    FMOV  D26, X29
    FMOV  V26.D[1], X22
    FMOV  D27, X5
    FMOV  V27.D[1], X2
    FMOV  D28, X29
    FMOV  V28.D[1], X4
    FMOV  D29, X19
    FMOV  V29.D[1], X18
    FMOV  D30, X19
    FMOV  V30.D[1], X17
    FMOV  D31, X4
    FMOV  V31.D[1], X18
    MOVZ  X23, #0xa, LSL #0
TaishanFpMovMaddP01_label_739:
    FMIN  H1, H6, H12
    FMINNM  H2, H18, H1
    FMIN  D19, D29, D4
    FMAX  D28, D31, D2
    FMAX  S8, S25, S11
    FMINNM  H5, H30, H7
    FMAX  D19, D10, D0
    FMIN  S6, S18, S15
    FMIN  H6, H12, H5
    FMAX  S27, S7, S0
    FMAXNM  S31, S29, S25
    FMINNM  S28, S30, S5
    FMAXNM  H22, H2, H15
    FMAX  D8, D27, D15
    FMAXNM  S9, S14, S7
    FMAX  H13, H10, H5
    FMINNM  H11, H16, H12
    FMAXNM  S8, S28, S12
    FMINNM  D2, D12, D0
    FMAX  D10, D31, D7
    FMAX  D25, D18, D30
    FMINNM  D29, D25, D11
    FMAXNM  D13, D18, D7
    FMIN  S9, S4, S6
    FMAXNM  H23, H12, H9
    FMAX  H12, H11, H4
    FMAXNM  H3, H30, H29
    FMAXNM  S12, S21, S16
    FMIN  H9, H9, H30
    FMINNM  S24, S13, S30
    FMIN  S0, S6, S9
    FMIN  D8, D22, D21
    FMAXNM  S13, S26, S7
    FMIN  S7, S28, S29
    FMAX  H6, H15, H24
TaishanFpMovMaddP01_label_235:
    FMIN  S22, S20, S28
    FMINNM  H9, H29, H10
    FMINNM  S20, S18, S18
    FMAX  S17, S2, S31
    FMINNM  D8, D21, D25
    FMIN  H8, H3, H17
    FMAX  D10, D9, D10
    FMIN  S29, S17, S20
    FMAXNM  S17, S29, S0
    FMIN  S16, S9, S20
    FMAX  H1, H22, H6
    FMINNM  D28, D0, D4
    FMAX  D17, D8, D18
    FMAX  S21, S2, S5
    FMINNM  D29, D11, D28
    FMAX  H16, H13, H8
    FMIN  H29, H18, H16
    FMINNM  H28, H21, H24
    FMIN  H7, H1, H4
    FMAX  S10, S28, S25
    FMAXNM  S11, S13, S7
    FMAXNM  S20, S29, S27
    FMINNM  D17, D29, D9
    FMAXNM  H14, H12, H8
    FMAXNM  H27, H28, H0
    FMINNM  H10, H12, H22
    FMAX  D22, D6, D11
    FMINNM  H10, H17, H12
    FMINNM  H10, H10, H27
    FMAX  H20, H6, H24
    FMAX  D2, D27, D6
    FMAXNM  D14, D20, D1
    FMAX  H26, H5, H16
    FMAX  D4, D19, D14
    FMIN  H7, H4, H18
    FMAX  H4, H9, H2
    FMINNM  H9, H9, H21
    FMIN  H30, H27, H21
    FMIN  H30, H3, H14
    FMAXNM  H15, H30, H20
    FMIN  H15, H11, H4
    FMAX  S0, S11, S26
    FMIN  H1, H6, H10
    FMAX  D13, D3, D13
    FMAXNM  H16, H4, H3
    FMINNM  H28, H1, H12
    FMINNM  H14, H14, H13
    FMINNM  H7, H5, H31
    FMIN  D3, D22, D29
    FMAX  D24, D13, D24
    FMIN  H6, H3, H4
    FMAX  S6, S19, S7
    FMAXNM  H10, H24, H31
    FMIN  D5, D30, D11
    FMIN  D18, D20, D15
    FMIN  D18, D15, D22
    FMAXNM  S30, S0, S16
    FMINNM  H11, H1, H21
    FMAXNM  S20, S5, S5
    FMAX  H1, H15, H22
    FMINNM  H27, H10, H29
    FMIN  H10, H3, H26
    FMINNM  S28, S20, S12
    FMAX  S19, S26, S14
    FMINNM  D9, D11, D12
    FMAXNM  S31, S18, S24
    FMINNM  D23, D16, D23
    FMINNM  D11, D4, D6
    FMINNM  H8, H27, H7
    FMAXNM  H9, H12, H4
    FMINNM  S9, S0, S18
    FMINNM  S6, S6, S12
    FMIN  D2, D5, D10
    FMAXNM  H21, H6, H7
    FMIN  H26, H18, H24
    FMAX  S5, S15, S14
    FMAXNM  S20, S14, S5
    FMINNM  H21, H10, H0
    FMIN  D26, D26, D11
    FMIN  H19, H22, H16
    FMAXNM  D4, D0, D9
    FMINNM  D1, D30, D2
    FMAX  S5, S9, S9
    FMINNM  H21, H5, H27
    FMINNM  S28, S8, S15
    FMAX  S12, S22, S21
    FMIN  S30, S9, S31
    FMAXNM  S4, S19, S3
    FMAX  D6, D16, D22
    FMIN  H27, H26, H27
    FMIN  S30, S7, S10
    FMAX  S23, S30, S15
    FMINNM  S23, S16, S7
    FMINNM  S1, S13, S30
    FMIN  D29, D6, D20
    FMAXNM  D13, D18, D31
    FMINNM  D8, D23, D7
    FMIN  D19, D27, D19
    FMINNM  S24, S13, S4
    FMIN  S12, S24, S21
    FMAXNM  D12, D20, D10
    FMAX  D13, D3, D10
    FMINNM  H6, H20, H29
    FMINNM  S6, S1, S8
    FMINNM  H13, H25, H7
    FMINNM  H11, H16, H21
    FMIN  H3, H6, H22
    FMIN  H11, H19, H23
    FMINNM  S16, S24, S12
    FMAX  H18, H16, H4
    FMIN  D17, D5, D5
    FMINNM  D7, D14, D6
    FMINNM  D26, D23, D17
    FMAXNM  S30, S4, S14
    FMIN  H28, H17, H28
    FMIN  S3, S23, S28
    FMIN  S18, S8, S1
    FMAX  D0, D20, D31
    FMAXNM  H11, H9, H0
    FMIN  S18, S4, S26
    FMINNM  S12, S19, S18
    FMAXNM  S16, S11, S4
    FMIN  H28, H0, H21
    FMINNM  H23, H8, H20
    FMAX  S18, S19, S0
    FMINNM  S14, S19, S22
    FMAX  S12, S7, S22
    FMINNM  S5, S20, S6
    FMIN  H21, H20, H4
    FMAX  D17, D21, D14
    FMAXNM  S6, S8, S11
    FMINNM  H22, H12, H26
    FMAXNM  S6, S10, S19
    FMIN  H17, H10, H9
    FMINNM  H29, H3, H30
    FMAXNM  S8, S8, S11
    FMINNM  D17, D6, D20
    FMAXNM  D27, D4, D1
    FMAXNM  D9, D11, D14
    FMINNM  D17, D29, D9
    FMAXNM  H24, H13, H31
    FMAXNM  S11, S30, S7
    FMIN  D23, D23, D23
    FMAX  D13, D11, D29
    FMINNM  H11, H2, H31
    FMIN  D23, D31, D9
    FMINNM  H19, H31, H26
    FMIN  D8, D8, D28
    FMAXNM  H19, H30, H7
    FMINNM  D31, D23, D5
    FMIN  S14, S15, S23
    FMIN  H29, H16, H19
    FMINNM  H12, H12, H24
    FMINNM  D1, D27, D12
    FMIN  D22, D8, D1
    FMAX  H17, H22, H30
    FMAX  S29, S1, S5
    FMAX  D17, D28, D8
    FMAXNM  H14, H4, H3
    FMIN  S4, S23, S17
    FMINNM  D29, D12, D17
    FMAX  S30, S24, S2
    FMIN  H13, H28, H17
    FMINNM  S30, S4, S16
    FMAX  D12, D18, D10
    SUBS  X23, X23, #0x1
    B.NE  TaishanFpMovMaddP01_label_739
    MOVZ  X23, #0xe568, LSL #0
    MOVK  X23, #0x2397, LSL #16
    MOVK  X23, #0x6a8, LSL #32
    MOVK  X23, #0xb854, LSL #48
    SUB  X11, X23, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0xd5ae, LSL #0
    MOVK  X15, #0x33c4, LSL #16
    MOVK  X15, #0x7658, LSL #32
    MOVK  X15, #0xf386, LSL #48
    SUB  X10, X15, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0xc61f, LSL #0
    MOVK  X19, #0x45c7, LSL #16
    MOVK  X19, #0x24ad, LSL #32
    MOVK  X19, #0x9519, LSL #48
    SUB  X27, X19, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x273, LSL #0
    MOVK  X3, #0x406d, LSL #16
    MOVK  X3, #0xb3c6, LSL #32
    MOVK  X3, #0x9e69, LSL #48
    SUB  X21, X3, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x93d6, LSL #0
    MOVK  X20, #0xa056, LSL #16
    MOVK  X20, #0xcbdc, LSL #32
    MOVK  X20, #0x985, LSL #48
    SUB  X4, X20, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0xe9c5, LSL #0
    MOVK  X23, #0x7db, LSL #16
    MOVK  X23, #0x1d62, LSL #32
    MOVK  X23, #0xec90, LSL #48
    SUB  X9, X23, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x8100, LSL #0
    MOVK  X26, #0x9c96, LSL #16
    MOVK  X26, #0x5ce3, LSL #32
    MOVK  X26, #0x5085, LSL #48
    SUB  X6, X26, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x3a29, LSL #0
    MOVK  X28, #0x881f, LSL #16
    MOVK  X28, #0x8043, LSL #32
    MOVK  X28, #0x9729, LSL #48
    SUB  X10, X28, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0x5f25, LSL #0
    MOVK  X25, #0xa21e, LSL #16
    MOVK  X25, #0x6d0c, LSL #32
    MOVK  X25, #0xbfc8, LSL #48
    SUB  X28, X25, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0xd5ae, LSL #0
    MOVK  X17, #0x33c4, LSL #16
    MOVK  X17, #0x7658, LSL #32
    MOVK  X17, #0xf386, LSL #48
    SUB  X13, X17, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x9b40, LSL #0
    MOVK  X23, #0x9e69, LSL #16
    MOVK  X23, #0xba30, LSL #32
    MOVK  X23, #0x4ed5, LSL #48
    SUB  X20, X23, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0xd5ae, LSL #0
    MOVK  X14, #0x33c4, LSL #16
    MOVK  X14, #0x7658, LSL #32
    MOVK  X14, #0xf386, LSL #48
    SUB  X23, X14, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x8fe4, LSL #0
    MOVK  X28, #0x1f08, LSL #16
    MOVK  X28, #0x304e, LSL #32
    MOVK  X28, #0x71f8, LSL #48
    SUB  X21, X28, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0xfa46, LSL #0
    MOVK  X5, #0x9a4e, LSL #16
    MOVK  X5, #0x3a6c, LSL #32
    MOVK  X5, #0x5ce4, LSL #48
    SUB  X8, X5, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x8100, LSL #0
    MOVK  X24, #0x9c96, LSL #16
    MOVK  X24, #0x5ce3, LSL #32
    MOVK  X24, #0x5085, LSL #48
    SUB  X9, X24, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x8fe4, LSL #0
    MOVK  X8, #0x1f08, LSL #16
    MOVK  X8, #0x304e, LSL #32
    MOVK  X8, #0x71f8, LSL #48
    SUB  X2, X8, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0xcfc3, LSL #0
    MOVK  X22, #0x7ae9, LSL #16
    MOVK  X22, #0x4a29, LSL #32
    MOVK  X22, #0x3654, LSL #48
    SUB  X13, X22, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X3
TaishanFpMovMaddP01_label_685:
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D9
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D15
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X21
    FMOV  V0.D[1], X6
    FMOV  D1, X16
    FMOV  V1.D[1], X19
    FMOV  D2, X9
    FMOV  V2.D[1], X21
    FMOV  D3, X27
    FMOV  V3.D[1], X25
    FMOV  D4, X18
    FMOV  V4.D[1], X18
    FMOV  D5, X8
    FMOV  V5.D[1], X25
    FMOV  D6, X24
    FMOV  V6.D[1], X11
    FMOV  D7, X19
    FMOV  V7.D[1], X22
    FMOV  D8, X27
    FMOV  V8.D[1], X4
    FMOV  D9, X16
    FMOV  V9.D[1], X29
    FMOV  D10, X6
    FMOV  V10.D[1], X2
    FMOV  D11, X20
    FMOV  V11.D[1], X3
    FMOV  D12, X19
    FMOV  V12.D[1], X18
TaishanFpMovMaddP01_label_328:
    FMOV  D13, X29
TaishanFpMovMaddP01_label_593:
    FMOV  V13.D[1], X11
    FMOV  D14, X14
    FMOV  V14.D[1], X28
TaishanFpMovMaddP01_label_733:
    FMOV  D15, X21
    FMOV  V15.D[1], X24
    FMOV  D16, X24
    FMOV  V16.D[1], X23
    FMOV  D17, X5
    FMOV  V17.D[1], X25
    FMOV  D18, X19
    FMOV  V18.D[1], X24
    FMOV  D19, X6
    FMOV  V19.D[1], X20
    FMOV  D20, X16
    FMOV  V20.D[1], X18
    FMOV  D21, X19
    FMOV  V21.D[1], X23
    FMOV  D22, X18
    FMOV  V22.D[1], X15
    FMOV  D23, X25
    FMOV  V23.D[1], X25
    FMOV  D24, X4
    FMOV  V24.D[1], X16
    FMOV  D25, X8
    FMOV  V25.D[1], X5
    FMOV  D26, X20
    FMOV  V26.D[1], X23
    FMOV  D27, X24
    FMOV  V27.D[1], X24
    FMOV  D28, X29
    FMOV  V28.D[1], X24
    FMOV  D29, X14
    FMOV  V29.D[1], X29
    FMOV  D30, X14
    FMOV  V30.D[1], X24
    FMOV  D31, X18
    FMOV  V31.D[1], X22
    MOVZ  X17, #0xa, LSL #0
TaishanFpMovMaddP01_label_820:
    FMAX  H10, H12, H5
    FMAXNM  S26, S15, S27
    FMINNM  D2, D25, D26
    FMAX  D10, D0, D26
    FMIN  H6, H8, H21
    FMAXNM  D18, D30, D6
    FMAXNM  S21, S16, S8
    FMAXNM  D1, D14, D30
    FMAXNM  S12, S21, S18
    FMINNM  H10, H30, H0
    FMIN  H20, H11, H31
    FMAX  H20, H27, H26
    FMIN  D12, D13, D8
    FMIN  S3, S10, S6
    FMIN  D19, D13, D30
    FMINNM  D16, D28, D7
    FMAX  S4, S5, S18
    FMIN  H28, H14, H12
    FMAXNM  D31, D14, D11
    FMINNM  D19, D6, D20
    FMIN  S3, S23, S2
    FMAXNM  H7, H27, H1
    FMIN  H5, H18, H24
    FMAXNM  D21, D30, D16
    FMAX  D18, D4, D14
    FMAXNM  H23, H28, H15
    FMINNM  H30, H24, H1
    FMAX  S8, S7, S19
    FMINNM  S28, S19, S26
    FMIN  S8, S27, S7
    FMAXNM  D2, D31, D18
    FMINNM  H2, H9, H21
    FMIN  S14, S10, S20
    FMINNM  H9, H28, H6
    FMAXNM  H10, H10, H2
    FMAXNM  S24, S11, S2
    FMINNM  S29, S24, S7
    FMAX  S30, S30, S11
    FMAXNM  S26, S5, S22
    FMAX  S3, S23, S9
    FMAX  H19, H11, H27
    FMAX  S3, S10, S12
    FMIN  S7, S31, S6
    FMIN  D21, D11, D8
    FMAXNM  D6, D4, D8
    FMAX  D17, D18, D26
    FMAX  S19, S13, S9
    FMAX  D23, D7, D29
    FMAXNM  S13, S21, S9
    FMAX  H17, H8, H10
    FMAXNM  D17, D29, D20
    FMAX  H10, H29, H30
    FMAXNM  D21, D10, D24
    FMIN  D30, D13, D16
    FMIN  H21, H4, H26
    FMAX  S9, S29, S17
    FMAXNM  S16, S15, S29
    FMIN  D20, D6, D23
    FMAX  S4, S16, S8
    FMAX  S27, S22, S12
    FMAX  D30, D0, D11
    FMAX  S2, S8, S20
    FMAXNM  D10, D21, D19
    FMAXNM  S5, S29, S25
    FMAXNM  S10, S31, S10
    FMINNM  S21, S3, S16
    FMAX  D9, D21, D30
    FMAXNM  D8, D20, D17
    FMINNM  D17, D7, D4
    FMAXNM  S6, S15, S16
    FMAXNM  H1, H31, H13
    FMIN  S22, S10, S0
    FMAXNM  D6, D2, D15
    FMAX  H29, H15, H22
    FMAXNM  H26, H31, H25
    FMIN  D6, D28, D20
    FMAXNM  D3, D12, D17
    FMIN  S10, S13, S23
    FMIN  D30, D25, D22
    FMINNM  H19, H19, H9
    FMINNM  D16, D21, D12
    FMAX  D3, D28, D10
    FMAXNM  H21, H21, H17
    FMIN  H14, H28, H14
    FMAXNM  D1, D26, D13
    FMAXNM  H18, H10, H23
    FMINNM  H20, H17, H25
    FMAX  H2, H0, H13
    FMAXNM  H3, H22, H22
    FMAX  S0, S7, S31
    FMAX  S9, S19, S31
    FMAXNM  S26, S4, S4
    FMAX  S18, S28, S10
    FMIN  D12, D14, D4
    FMIN  H16, H10, H5
    FMIN  D5, D1, D12
    FMINNM  D13, D29, D11
    FMAXNM  D4, D22, D18
    FMINNM  H25, H30, H20
    FMIN  D25, D1, D19
    FMIN  H16, H1, H5
    FMAXNM  S13, S23, S29
    FMAXNM  S27, S0, S8
    FMAXNM  D2, D23, D27
    FMIN  H13, H3, H3
    FMINNM  D2, D13, D20
    FMINNM  H9, H4, H7
    FMAX  H3, H10, H3
    FMAXNM  S7, S6, S24
    FMAXNM  H27, H3, H16
    FMAXNM  H6, H1, H15
    FMAXNM  D7, D15, D26
    FMAX  D6, D9, D10
    FMAXNM  H20, H7, H10
    FMAX  S9, S7, S23
    FMAX  S3, S14, S5
    FMAXNM  S20, S21, S19
    FMIN  H25, H25, H26
    FMINNM  D27, D30, D24
    FMIN  D29, D8, D29
    FMAXNM  H27, H20, H23
    FMAXNM  H10, H4, H15
    FMINNM  H30, H16, H2
    FMAX  D1, D28, D15
    FMIN  H24, H11, H6
    FMAXNM  H5, H28, H15
    FMINNM  H14, H25, H17
    FMAX  S24, S25, S6
    FMINNM  S23, S4, S6
    FMAXNM  S20, S5, S29
    FMIN  S31, S5, S5
    FMINNM  D0, D5, D10
    FMINNM  H6, H1, H5
    FMIN  D7, D24, D16
    FMAXNM  S21, S4, S27
    FMAXNM  D25, D31, D26
    FMAXNM  D7, D21, D15
    FMAXNM  D6, D9, D24
    FMIN  D3, D24, D15
    FMINNM  S3, S0, S10
TaishanFpMovMaddP01_label_727:
    FMIN  S25, S29, S23
    FMINNM  H16, H12, H10
    FMINNM  S22, S10, S0
    FMAXNM  H0, H5, H17
    FMINNM  S17, S14, S17
    FMAX  H20, H28, H10
    FMINNM  H9, H16, H29
    FMAX  D16, D9, D1
    FMIN  S1, S30, S13
    FMINNM  D18, D3, D26
    FMAXNM  H4, H5, H29
    FMAXNM  H31, H17, H17
    FMAXNM  H4, H17, H17
    FMAX  S0, S7, S28
    FMIN  H24, H21, H16
    FMAX  S19, S27, S16
    FMIN  S30, S12, S17
    FMIN  S17, S24, S18
    FMAXNM  H16, H1, H9
    FMAX  D4, D20, D12
    FMIN  H15, H17, H15
    FMAX  S17, S6, S31
    FMAX  D25, D4, D31
    FMAXNM  S9, S30, S29
    FMAX  S31, S15, S4
    FMAXNM  S28, S29, S9
    FMINNM  S16, S9, S12
    FMINNM  S29, S30, S14
    FMAX  H16, H19, H11
    FMAXNM  D26, D24, D0
    FMAX  H17, H19, H17
    FMAXNM  H10, H7, H24
    FMAXNM  D3, D28, D28
    FMIN  S26, S17, S3
    FMAXNM  S6, S1, S17
    FMAXNM  D6, D12, D27
    FMINNM  H16, H5, H3
    FMAXNM  S1, S30, S13
    FMIN  H31, H16, H28
    FMINNM  D15, D8, D25
    FMIN  S10, S2, S16
    FMIN  D17, D8, D16
    FMAX  H7, H18, H0
    FMAXNM  S0, S9, S18
    FMIN  D28, D18, D21
    FMAX  H28, H21, H2
    FMIN  H10, H17, H6
    FMINNM  S4, S25, S2
    FMAXNM  S31, S5, S25
    FMAX  H16, H3, H16
    FMAXNM  S15, S15, S25
    FMAXNM  S9, S25, S17
    FMIN  S4, S4, S3
    FMAX  D27, D19, D28
    FMAX  H0, H19, H15
    FMIN  D27, D10, D25
    FMAXNM  D25, D25, D16
    FMIN  S11, S27, S5
    FMIN  H11, H21, H7
    FMINNM  S4, S8, S20
    SUBS  X17, X17, #0x1
    B.NE  TaishanFpMovMaddP01_label_820
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D2
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D5
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D11
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D15
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D24
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D28
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X21
    FMOV  D1, X28
    FMOV  V1.D[1], X18
    FMOV  D2, X22
    FMOV  V2.D[1], X22
    FMOV  D3, X16
    FMOV  V3.D[1], X16
    FMOV  D4, X26
    FMOV  V4.D[1], X3
    FMOV  D5, X26
    FMOV  V5.D[1], X19
    FMOV  D6, X23
    FMOV  V6.D[1], X23
    FMOV  D7, X21
    FMOV  V7.D[1], X11
    FMOV  D8, X18
    FMOV  V8.D[1], X16
    FMOV  D9, X9
    FMOV  V9.D[1], X6
    FMOV  D10, X3
    FMOV  V10.D[1], X3
    FMOV  D11, X2
    FMOV  V11.D[1], X25
    FMOV  D12, X19
    FMOV  V12.D[1], X15
    FMOV  D13, X17
    FMOV  V13.D[1], X4
    FMOV  D14, X2
    FMOV  V14.D[1], X25
    FMOV  D15, X6
    FMOV  V15.D[1], X18
    FMOV  D16, X7
    FMOV  V16.D[1], X28
    FMOV  D17, X28
    FMOV  V17.D[1], X27
    FMOV  D18, X15
    FMOV  V18.D[1], X4
    FMOV  D19, X2
    FMOV  V19.D[1], X9
    FMOV  D20, X19
    FMOV  V20.D[1], X8
    FMOV  D21, X21
    FMOV  V21.D[1], X13
    FMOV  D22, X21
    FMOV  V22.D[1], X22
    FMOV  D23, X21
    FMOV  V23.D[1], X15
    FMOV  D24, X24
    FMOV  V24.D[1], X18
    FMOV  D25, X10
    FMOV  V25.D[1], X7
    FMOV  D26, X29
    FMOV  V26.D[1], X2
    FMOV  D27, X22
    FMOV  V27.D[1], X22
    FMOV  D28, X28
    FMOV  V28.D[1], X7
    FMOV  D29, X25
    FMOV  V29.D[1], X14
    FMOV  D30, X29
    FMOV  V30.D[1], X23
    FMOV  D31, X3
    FMOV  V31.D[1], X25
    MOVZ  X21, #0xf, LSL #0
TaishanFpMovMaddP01_label_896:
    FMINNM  D6, D30, D24
    FMIN  S1, S29, S25
    FMINNM  S5, S5, S2
    FMAXNM  S28, S25, S13
    FMAXNM  S7, S30, S20
    FMIN  D18, D28, D30
    FMIN  H30, H17, H30
    FMAX  H17, H16, H29
    FMAX  H31, H9, H0
    FMAXNM  D8, D7, D14
    FMAX  D25, D18, D22
    FMINNM  S9, S20, S20
    FMIN  S18, S16, S1
    FMIN  H16, H13, H5
    FMIN  S16, S10, S0
    FMIN  S15, S25, S10
    FMIN  D0, D6, D14
    FMAXNM  S22, S6, S21
    FMIN  H1, H30, H5
    FMINNM  S20, S31, S12
    FMAXNM  H25, H8, H31
    FMAXNM  D18, D20, D30
    FMAXNM  H21, H1, H3
    FMINNM  S21, S12, S19
    FMINNM  S23, S28, S11
    FMINNM  H14, H3, H0
    FMIN  H14, H27, H0
    FMAXNM  D28, D2, D20
    FMINNM  S22, S8, S23
    FMINNM  H9, H25, H7
    FMINNM  S15, S15, S0
    FMAXNM  S27, S16, S12
    FMAXNM  D28, D31, D0
    FMINNM  H3, H16, H3
    FMAX  S17, S15, S15
    FMAXNM  D29, D5, D13
    FMINNM  S7, S27, S7
    FMINNM  D15, D22, D2
    FMAXNM  D18, D15, D9
    FMIN  S12, S22, S5
    FMINNM  S1, S28, S18
    FMAX  H14, H21, H4
    FMIN  H24, H29, H4
    FMINNM  D6, D4, D21
    FMIN  S29, S26, S14
    FMINNM  H10, H10, H18
    FMAX  H24, H18, H22
    FMINNM  H16, H9, H16
    FMAXNM  H2, H0, H23
    FMIN  H2, H1, H21
    FMAX  S21, S25, S31
    FMIN  S2, S28, S5
    FMAXNM  H2, H23, H21
    FMAXNM  D24, D27, D0
    FMAXNM  D12, D3, D7
    FMINNM  H8, H16, H16
    FMINNM  S14, S26, S14
    FMINNM  S19, S7, S0
    FMAXNM  H17, H30, H9
    FMAXNM  H30, H12, H27
    FMAXNM  S22, S1, S27
    FMAX  S21, S26, S10
    FMIN  S18, S5, S22
    FMAX  S16, S30, S29
    FMINNM  D24, D17, D15
    FMAX  S15, S24, S0
    FMAX  H7, H22, H17
    FMIN  D24, D21, D22
    FMAX  D1, D26, D27
    FMAXNM  S31, S25, S24
    FMIN  H4, H9, H30
    FMINNM  D18, D16, D18
    FMAX  S7, S28, S25
    FMAXNM  D14, D10, D27
    FMIN  D2, D29, D7
    FMAX  D13, D29, D15
    FMIN  D19, D24, D24
    FMINNM  D21, D20, D0
    FMAX  S0, S20, S26
    FMIN  H4, H28, H0
    FMAX  S9, S6, S19
    FMIN  H1, H0, H29
    FMAXNM  H0, H21, H18
    FMINNM  H3, H27, H1
    FMAXNM  D18, D1, D23
    FMAX  S11, S19, S27
    FMINNM  S0, S3, S11
    FMINNM  H13, H26, H10
    FMAX  D19, D31, D6
    FMAX  S18, S6, S19
    FMAX  H4, H10, H1
    FMAX  D18, D26, D13
    FMIN  S28, S5, S4
    FMAXNM  H9, H21, H11
    FMAX  S26, S0, S11
    FMINNM  D14, D6, D18
    FMAXNM  H6, H10, H18
    FMAXNM  H16, H6, H28
    FMIN  D0, D9, D16
    FMAXNM  H11, H1, H9
    FMIN  D28, D2, D6
    FMIN  S2, S21, S9
    FMAX  D2, D24, D1
    FMIN  D0, D24, D1
    FMAX  D28, D27, D20
    FMAX  S26, S12, S19
    FMAXNM  D11, D14, D15
    FMINNM  D16, D29, D8
    FMINNM  S10, S17, S26
    FMAXNM  D2, D4, D11
    FMAX  H18, H27, H0
    FMINNM  D27, D5, D13
    FMAXNM  S8, S4, S14
    FMAXNM  S16, S23, S28
    FMAX  D10, D27, D8
    FMINNM  S17, S20, S25
    FMIN  D20, D31, D22
    FMIN  S25, S10, S6
    FMAX  D26, D0, D2
    FMAXNM  S28, S0, S16
    FMINNM  S14, S1, S12
    FMIN  D8, D11, D0
    FMAX  H11, H5, H10
    FMIN  D22, D24, D8
    FMINNM  H0, H12, H29
    FMINNM  H13, H2, H18
    FMIN  H21, H10, H6
    FMAXNM  D24, D2, D28
    FMAX  S16, S21, S6
    FMINNM  S27, S2, S10
    FMINNM  H12, H18, H31
    FMAX  H24, H23, H19
    FMIN  D17, D13, D2
    FMAX  D3, D7, D30
    FMAXNM  H5, H11, H25
    FMIN  S26, S17, S9
    FMAX  H9, H8, H21
    FMINNM  H26, H1, H17
    FMAX  D5, D23, D2
    FMAX  S2, S26, S2
    FMINNM  H4, H0, H27
    FMIN  H2, H7, H12
    FMINNM  H5, H28, H23
    FMAX  H27, H7, H8
    FMAXNM  D24, D4, D12
    FMAXNM  H7, H5, H27
    FMINNM  D27, D1, D26
    FMAX  S3, S26, S28
    FMIN  H14, H20, H28
    FMIN  H22, H24, H17
    FMINNM  D1, D4, D10
    FMAX  S12, S17, S3
    FMAXNM  D13, D9, D28
    FMAXNM  D7, D19, D10
    FMINNM  H25, H25, H0
    FMAXNM  D21, D29, D12
    FMIN  S3, S21, S16
    FMIN  H9, H2, H16
    FMAX  S6, S8, S26
    FMAX  D15, D15, D20
    FMINNM  H20, H26, H22
    FMAXNM  H10, H28, H6
    FMAX  S8, S27, S4
    FMAX  D30, D12, D7
    FMINNM  D11, D2, D16
    FMAX  D5, D11, D10
    FMAXNM  H19, H17, H9
    FMAXNM  H3, H31, H24
    FMINNM  S26, S18, S3
    FMAXNM  S3, S15, S18
    FMINNM  H25, H29, H0
    FMAX  D2, D22, D10
    FMINNM  H7, H22, H9
    FMAXNM  S9, S14, S23
    FMAX  H9, H29, H20
    FMIN  H17, H7, H8
    FMIN  S15, S28, S31
    FMAX  S15, S31, S9
    FMIN  H31, H26, H6
    FMAXNM  D24, D5, D30
    FMAX  S15, S17, S10
    FMINNM  S18, S5, S4
    FMAX  H3, H10, H19
    FMAX  H26, H28, H22
    FMAXNM  D19, D18, D16
    FMAXNM  H20, H27, H14
    FMINNM  D0, D28, D31
    FMAX  H10, H23, H3
    FMAX  D21, D7, D30
    FMAXNM  D6, D28, D21
    FMINNM  D5, D31, D4
    FMIN  S6, S25, S19
    FMAX  H13, H26, H13
    FMAX  D2, D6, D1
    FMAX  H28, H2, H30
    FMIN  S26, S20, S31
    FMINNM  D15, D24, D1
    FMAX  D19, D23, D6
    FMIN  H0, H31, H17
    FMAX  D6, D25, D0
    SUBS  X21, X21, #0x1
    B.NE  TaishanFpMovMaddP01_label_896
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X14, X17, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X27, X8, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X21, X20, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X15, X26, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X18, X4, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X18, X10, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X10, X4, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X25, X28, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X7, X13, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X10, X9, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X18, X5, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X27, X3, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X27, X13, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X21
TaishanFpMovMaddP01_label_491:
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X19, X17, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X28, X20, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X15, X26, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X22, X17, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D26
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D29
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x4b94, LSL #0
    MOVK  X2, #0x8304, LSL #16
    MOVK  X2, #0x125, LSL #32
    MOVK  X2, #0xc46a, LSL #48
    MOVZ  X3, #0x5b09, LSL #0
    MOVK  X3, #0x8fad, LSL #16
    MOVK  X3, #0x75f9, LSL #32
    MOVK  X3, #0x60c3, LSL #48
    MOVZ  X4, #0x2603, LSL #0
    MOVK  X4, #0xda9c, LSL #16
    MOVK  X4, #0x6759, LSL #32
    MOVK  X4, #0xf859, LSL #48
    MOVZ  X5, #0xdfdb, LSL #0
    MOVK  X5, #0x5437, LSL #16
    MOVK  X5, #0xe0ad, LSL #32
    MOVK  X5, #0x57c7, LSL #48
    MOVZ  X6, #0xd22f, LSL #0
    MOVK  X6, #0xd328, LSL #16
    MOVK  X6, #0xdb04, LSL #32
    MOVK  X6, #0xac63, LSL #48
    MOVZ  X7, #0x190e, LSL #0
    MOVK  X7, #0x46a1, LSL #16
    MOVK  X7, #0x7b59, LSL #32
    MOVK  X7, #0x9ad0, LSL #48
    MOVZ  X8, #0xcbb4, LSL #0
    MOVK  X8, #0xc0f4, LSL #16
    MOVK  X8, #0x57c0, LSL #32
    MOVK  X8, #0x350b, LSL #48
    MOVZ  X9, #0x65b4, LSL #0
    MOVK  X9, #0x8452, LSL #16
    MOVK  X9, #0x9d61, LSL #32
    MOVK  X9, #0xa55f, LSL #48
    MOVZ  X10, #0xf6a3, LSL #0
    MOVK  X10, #0xfdd0, LSL #16
    MOVK  X10, #0xcb6f, LSL #32
    MOVK  X10, #0xa201, LSL #48
    MOVZ  X11, #0x5276, LSL #0
    MOVK  X11, #0x55e1, LSL #16
    MOVK  X11, #0xa8af, LSL #32
    MOVK  X11, #0x9a06, LSL #48
    MOVZ  X13, #0x634f, LSL #0
    MOVK  X13, #0x8764, LSL #16
    MOVK  X13, #0x41cd, LSL #32
    MOVK  X13, #0x9a98, LSL #48
    MOVZ  X14, #0x1ef0, LSL #0
    MOVK  X14, #0xa682, LSL #16
    MOVK  X14, #0x2197, LSL #32
    MOVK  X14, #0xd73b, LSL #48
    MOVZ  X15, #0xee62, LSL #0
    MOVK  X15, #0x5d91, LSL #16
    MOVK  X15, #0x76db, LSL #32
    MOVK  X15, #0x7500, LSL #48
    MOVZ  X16, #0x2314, LSL #0
    MOVK  X16, #0xbfdb, LSL #16
    MOVK  X16, #0xf22d, LSL #32
    MOVK  X16, #0x2a41, LSL #48
    MOVZ  X17, #0xd37f, LSL #0
    MOVK  X17, #0x630f, LSL #16
    MOVK  X17, #0x83e4, LSL #32
    MOVK  X17, #0x6a5a, LSL #48
    MOVZ  X18, #0x9068, LSL #0
    MOVK  X18, #0x44d4, LSL #16
    MOVK  X18, #0x607c, LSL #32
    MOVK  X18, #0x198c, LSL #48
    MOVZ  X19, #0xb5a3, LSL #0
    MOVK  X19, #0xa3cc, LSL #16
    MOVK  X19, #0xfa59, LSL #32
    MOVK  X19, #0x8e3a, LSL #48
    MOVZ  X20, #0xa014, LSL #0
    MOVK  X20, #0x1f9f, LSL #16
    MOVK  X20, #0x33c1, LSL #32
    MOVK  X20, #0xb4d2, LSL #48
    MOVZ  X21, #0xd438, LSL #0
    MOVK  X21, #0xa2ea, LSL #16
    MOVK  X21, #0x19cc, LSL #32
    MOVK  X21, #0xf3fe, LSL #48
    MOVZ  X22, #0x1b74, LSL #0
    MOVK  X22, #0xc25c, LSL #16
    MOVK  X22, #0x745, LSL #32
    MOVK  X22, #0x132d, LSL #48
    MOVZ  X23, #0x7ff4, LSL #0
    MOVK  X23, #0xbf80, LSL #16
    MOVK  X23, #0x85e0, LSL #32
    MOVK  X23, #0x89d8, LSL #48
    MOVZ  X24, #0x44fb, LSL #0
    MOVK  X24, #0x64b1, LSL #16
    MOVK  X24, #0xa0c, LSL #32
    MOVK  X24, #0x2688, LSL #48
    MOVZ  X25, #0x11e1, LSL #0
    MOVK  X25, #0x4c55, LSL #16
    MOVK  X25, #0x3c4b, LSL #32
    MOVK  X25, #0x4e9b, LSL #48
    MOVZ  X26, #0xe409, LSL #0
    MOVK  X26, #0xd31c, LSL #16
    MOVK  X26, #0xa9d2, LSL #32
    MOVK  X26, #0xe96f, LSL #48
    MOVZ  X27, #0x3543, LSL #0
    MOVK  X27, #0xe60b, LSL #16
    MOVK  X27, #0x686, LSL #32
    MOVK  X27, #0x746d, LSL #48
    MOVZ  X28, #0x92c3, LSL #0
    MOVK  X28, #0xc782, LSL #16
    MOVK  X28, #0xe68f, LSL #32
    MOVK  X28, #0x7362, LSL #48
    MOVZ  X29, #0x1964, LSL #0
    MOVK  X29, #0xf108, LSL #16
    MOVK  X29, #0x11c8, LSL #32
    MOVK  X29, #0xc533, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X11
    FMOV  D1, X16
    FMOV  V1.D[1], X28
    FMOV  D2, X17
    FMOV  V2.D[1], X11
    FMOV  D3, X29
    FMOV  V3.D[1], X3
    FMOV  D4, X17
    FMOV  V4.D[1], X22
    FMOV  D5, X3
    FMOV  V5.D[1], X14
    FMOV  D6, X11
    FMOV  V6.D[1], X17
    FMOV  D7, X29
    FMOV  V7.D[1], X3
    FMOV  D8, X4
    FMOV  V8.D[1], X27
    FMOV  D9, X17
    FMOV  V9.D[1], X16
    FMOV  D10, X11
    FMOV  V10.D[1], X25
    FMOV  D11, X10
    FMOV  V11.D[1], X16
    FMOV  D12, X3
    FMOV  V12.D[1], X18
    FMOV  D13, X22
    FMOV  V13.D[1], X9
    FMOV  D14, X15
    FMOV  V14.D[1], X4
    FMOV  D15, X11
    FMOV  V15.D[1], X2
    FMOV  D16, X21
    FMOV  V16.D[1], X15
    FMOV  D17, X28
    FMOV  V17.D[1], X7
    FMOV  D18, X3
    FMOV  V18.D[1], X7
    FMOV  D19, X3
    FMOV  V19.D[1], X28
    FMOV  D20, X10
    FMOV  V20.D[1], X24
    FMOV  D21, X8
    FMOV  V21.D[1], X24
    FMOV  D22, X15
    FMOV  V22.D[1], X17
    FMOV  D23, X5
    FMOV  V23.D[1], X23
    FMOV  D24, X3
    FMOV  V24.D[1], X16
    FMOV  D25, X7
    FMOV  V25.D[1], X28
    FMOV  D26, X9
    FMOV  V26.D[1], X22
    FMOV  D27, X15
    FMOV  V27.D[1], X29
    FMOV  D28, X23
    FMOV  V28.D[1], X8
    FMOV  D29, X14
    FMOV  V29.D[1], X4
    FMOV  D30, X21
    FMOV  V30.D[1], X20
    FMOV  D31, X14
    FMOV  V31.D[1], X9
    MOVZ  X18, #0xa, LSL #0
TaishanFpMovMaddP01_label_973:
    FMAX  S0, S9, S26
    FMINNM  S14, S3, S0
    FMINNM  H31, H31, H24
    FMIN  H24, H25, H13
    FMAXNM  D1, D7, D1
    FMAX  S31, S25, S19
    FMIN  H15, H21, H15
    FMAXNM  H4, H23, H3
    FMAX  S25, S30, S9
    FMIN  D27, D18, D1
    FMINNM  S30, S15, S28
    FMINNM  D28, D29, D19
    FMAX  H13, H27, H13
    FMAX  H30, H21, H28
    FMIN  H9, H5, H9
    FMINNM  S9, S31, S14
    FMIN  H9, H12, H8
    FMAXNM  S13, S21, S23
    FMAX  D15, D4, D18
    FMINNM  S29, S6, S28
    FMIN  S6, S1, S15
    FMINNM  S26, S23, S28
    FMAXNM  S9, S28, S19
    FMAX  H0, H23, H26
    FMINNM  H23, H0, H26
    FMAX  D27, D0, D6
    FMIN  D17, D14, D23
    FMAXNM  H7, H8, H30
    FMINNM  S25, S30, S24
    FMAX  S18, S13, S9
    FMIN  S4, S27, S0
    FMAXNM  S7, S25, S12
    FMAXNM  D4, D2, D2
    FMINNM  H6, H11, H2
    FMIN  D3, D7, D12
    FMINNM  S18, S18, S22
    FMAXNM  H19, H17, H21
    FMIN  D15, D30, D0
    FMAX  D21, D18, D2
    FMAX  S5, S24, S25
    FMINNM  S11, S14, S30
    FMAXNM  S29, S21, S1
    FMAXNM  S31, S23, S22
    FMINNM  D15, D23, D29
    FMINNM  D15, D13, D17
    FMINNM  H25, H11, H22
    FMIN  S13, S1, S19
    FMIN  S8, S19, S30
    FMAXNM  D17, D14, D13
    FMAXNM  S14, S2, S21
    FMAX  D15, D26, D22
    FMAXNM  H26, H17, H15
    FMINNM  H9, H13, H11
    FMAX  S28, S31, S9
    FMAXNM  S27, S24, S4
    FMIN  D8, D9, D30
    FMINNM  S19, S0, S30
    FMINNM  H27, H0, H21
    FMINNM  H9, H23, H25
    FMAX  H20, H21, H14
    FMAX  H11, H18, H16
    FMIN  D29, D3, D25
    FMAX  D31, D11, D21
    FMIN  D6, D11, D14
    FMAX  H13, H11, H21
    FMINNM  D27, D22, D15
    FMINNM  H28, H13, H21
    FMAX  S11, S25, S1
    FMIN  D8, D30, D26
    FMAX  D30, D2, D10
    FMAX  H31, H20, H13
    FMINNM  H24, H15, H4
    FMIN  S12, S15, S30
    FMIN  S29, S4, S5
    FMIN  S9, S2, S29
    FMINNM  D17, D18, D30
    FMIN  H29, H24, H28
    FMIN  S15, S14, S29
    FMIN  D7, D29, D18
    FMAXNM  S28, S17, S19
    FMINNM  D29, D28, D17
    FMAX  D25, D10, D7
    FMIN  D17, D7, D22
    FMIN  D8, D6, D29
    FMINNM  S3, S4, S23
    FMAX  D9, D2, D30
    FMAX  H3, H12, H19
    FMAX  H6, H2, H24
    FMINNM  D28, D4, D7
    FMIN  D12, D20, D22
    FMAX  H24, H7, H19
    FMIN  S14, S5, S10
    FMAX  S8, S6, S29
    FMAXNM  H15, H23, H20
    FMAX  D31, D8, D3
    FMIN  H4, H15, H27
    FMIN  H24, H22, H20
    FMAXNM  H6, H13, H23
    FMIN  S11, S1, S2
    FMAXNM  D20, D3, D14
    FMAX  S20, S9, S19
    FMAX  H4, H11, H10
    FMINNM  S18, S4, S29
    FMAX  D18, D8, D13
    FMAXNM  S4, S18, S9
    FMAX  D29, D8, D26
    FMAXNM  S20, S29, S19
    FMIN  D6, D15, D4
    FMAX  S5, S22, S25
    FMAXNM  S3, S30, S20
    FMINNM  D11, D27, D15
    FMAX  D30, D5, D24
    FMAX  D30, D12, D15
    FMIN  H15, H28, H12
    FMINNM  H0, H27, H24
    FMIN  D27, D3, D13
    FMINNM  S0, S3, S19
    FMINNM  D6, D11, D17
    FMAXNM  D8, D28, D11
    FMIN  H28, H3, H30
    FMINNM  H17, H14, H16
    FMIN  H25, H22, H11
    FMINNM  S13, S31, S20
    FMINNM  S25, S22, S28
    FMIN  S16, S8, S9
    FMAXNM  D15, D4, D29
    FMIN  H1, H12, H7
    FMAXNM  S13, S0, S17
    FMIN  S18, S11, S24
    FMAX  H25, H7, H29
    FMIN  D6, D24, D29
    FMAXNM  H11, H15, H25
    FMINNM  S23, S1, S31
    FMAX  H27, H9, H18
    FMAXNM  S0, S31, S10
    FMAX  D28, D7, D18
    FMAXNM  S14, S30, S15
    FMINNM  D5, D16, D24
    FMINNM  D4, D5, D10
    FMIN  S5, S5, S4
    FMIN  S11, S5, S5
    FMAXNM  D6, D25, D20
    FMINNM  S25, S1, S5
    FMAXNM  D16, D31, D25
    FMAX  S27, S11, S2
    FMIN  D13, D16, D19
    FMAX  H17, H15, H23
    FMINNM  H27, H18, H13
    FMAXNM  S16, S19, S4
    FMINNM  D29, D4, D5
    FMIN  H30, H12, H12
    FMIN  H31, H7, H8
    FMAXNM  D19, D22, D5
    FMINNM  D26, D2, D30
    FMIN  S18, S2, S30
    FMIN  D28, D0, D29
    FMAX  H6, H2, H22
    FMIN  S7, S29, S24
    FMAXNM  S19, S26, S11
    FMAXNM  H1, H29, H7
    FMIN  S20, S3, S13
    FMINNM  H14, H28, H13
    FMINNM  H24, H15, H29
    FMAXNM  D26, D2, D23
    FMIN  S16, S12, S26
    FMAX  H22, H18, H7
    FMINNM  H6, H12, H27
    FMIN  D16, D8, D28
    FMAX  H27, H17, H3
    FMAXNM  S24, S6, S27
    FMINNM  H31, H2, H26
    FMIN  S17, S19, S16
    FMINNM  S20, S12, S24
    FMAX  H19, H11, H24
    FMAX  H14, H22, H29
    FMINNM  H13, H0, H8
    FMIN  S13, S7, S23
    FMINNM  S0, S19, S15
    FMAX  H31, H6, H1
    FMAXNM  H14, H26, H15
    FMINNM  H19, H29, H10
    FMAXNM  H11, H4, H20
    FMAXNM  H27, H7, H15
    FMAX  D26, D13, D0
    FMAXNM  D13, D29, D23
    FMIN  S8, S17, S29
    FMAXNM  S3, S18, S31
    FMAXNM  S3, S31, S10
    FMIN  H30, H14, H27
    FMINNM  S16, S7, S28
    FMAXNM  D15, D15, D29
    FMAX  D27, D30, D29
    FMAXNM  H2, H2, H21
    FMIN  D13, D1, D26
    FMINNM  S30, S7, S26
    FMIN  H21, H19, H23
    FMINNM  H8, H15, H3
    FMINNM  S3, S2, S26
    FMINNM  D30, D22, D4
    FMAX  S6, S30, S16
    SUBS  X18, X18, #0x1
    B.NE  TaishanFpMovMaddP01_label_973
    MOVZ  X25, #0x4b94, LSL #0
    MOVK  X25, #0x8304, LSL #16
    MOVK  X25, #0x125, LSL #32
    MOVK  X25, #0xc46a, LSL #48
    SUB  X23, X25, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x5b09, LSL #0
    MOVK  X14, #0x8fad, LSL #16
    MOVK  X14, #0x75f9, LSL #32
    MOVK  X14, #0x60c3, LSL #48
    SUB  X27, X14, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0x2603, LSL #0
    MOVK  X25, #0xda9c, LSL #16
    MOVK  X25, #0x6759, LSL #32
    MOVK  X25, #0xf859, LSL #48
    SUB  X27, X25, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0xdfdb, LSL #0
    MOVK  X18, #0x5437, LSL #16
    MOVK  X18, #0xe0ad, LSL #32
    MOVK  X18, #0x57c7, LSL #48
    SUB  X20, X18, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0xd22f, LSL #0
    MOVK  X9, #0xd328, LSL #16
    MOVK  X9, #0xdb04, LSL #32
    MOVK  X9, #0xac63, LSL #48
    SUB  X15, X9, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x190e, LSL #0
    MOVK  X20, #0x46a1, LSL #16
    MOVK  X20, #0x7b59, LSL #32
    MOVK  X20, #0x9ad0, LSL #48
    SUB  X7, X20, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0xcbb4, LSL #0
    MOVK  X22, #0xc0f4, LSL #16
    MOVK  X22, #0x57c0, LSL #32
    MOVK  X22, #0x350b, LSL #48
    SUB  X5, X22, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0xd22f, LSL #0
    MOVK  X28, #0xd328, LSL #16
    MOVK  X28, #0xdb04, LSL #32
    MOVK  X28, #0xac63, LSL #48
    SUB  X13, X28, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0xf6a3, LSL #0
    MOVK  X8, #0xfdd0, LSL #16
    MOVK  X8, #0xcb6f, LSL #32
    MOVK  X8, #0xa201, LSL #48
    SUB  X11, X8, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x5b09, LSL #0
    MOVK  X20, #0x8fad, LSL #16
    MOVK  X20, #0x75f9, LSL #32
    MOVK  X20, #0x60c3, LSL #48
    SUB  X2, X20, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x2314, LSL #0
    MOVK  X23, #0xbfdb, LSL #16
    MOVK  X23, #0xf22d, LSL #32
    MOVK  X23, #0x2a41, LSL #48
    SUB  X13, X23, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0xd37f, LSL #0
    MOVK  X29, #0x630f, LSL #16
    MOVK  X29, #0x83e4, LSL #32
    MOVK  X29, #0x6a5a, LSL #48
    SUB  X4, X29, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0xdfdb, LSL #0
    MOVK  X26, #0x5437, LSL #16
    MOVK  X26, #0xe0ad, LSL #32
    MOVK  X26, #0x57c7, LSL #48
    SUB  X22, X26, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0xb5a3, LSL #0
    MOVK  X16, #0xa3cc, LSL #16
    MOVK  X16, #0xfa59, LSL #32
    MOVK  X16, #0x8e3a, LSL #48
    SUB  X22, X16, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x5b09, LSL #0
    MOVK  X15, #0x8fad, LSL #16
    MOVK  X15, #0x75f9, LSL #32
    MOVK  X15, #0x60c3, LSL #48
    SUB  X13, X15, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x2314, LSL #0
    MOVK  X13, #0xbfdb, LSL #16
    MOVK  X13, #0xf22d, LSL #32
    MOVK  X13, #0x2a41, LSL #48
    SUB  X5, X13, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x44fb, LSL #0
    MOVK  X8, #0x64b1, LSL #16
    MOVK  X8, #0xa0c, LSL #32
    MOVK  X8, #0x2688, LSL #48
    SUB  X5, X8, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0xdfdb, LSL #0
    MOVK  X14, #0x5437, LSL #16
    MOVK  X14, #0xe0ad, LSL #32
    MOVK  X14, #0x57c7, LSL #48
    SUB  X18, X14, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0xd37f, LSL #0
    MOVK  X29, #0x630f, LSL #16
    MOVK  X29, #0x83e4, LSL #32
    MOVK  X29, #0x6a5a, LSL #48
    SUB  X27, X29, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D4
    MOVZ  X3, #0x5276, LSL #0
    MOVK  X3, #0x55e1, LSL #16
    MOVK  X3, #0xa8af, LSL #32
    MOVK  X3, #0x9a06, LSL #48
    SUB  X6, X3, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D6
    MOVZ  X29, #0x5276, LSL #0
    MOVK  X29, #0x55e1, LSL #16
    SUB  X21, X29, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X21, #0x11e1, LSL #0
    MOVK  X21, #0x4c55, LSL #16
    MOVK  X21, #0x3c4b, LSL #32
    MOVK  X21, #0x4e9b, LSL #48
    SUB  X22, X21, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D10
    MOVZ  X21, #0x5276, LSL #0
    MOVK  X21, #0x55e1, LSL #16
    MOVK  X21, #0xa8af, LSL #32
    MOVK  X21, #0x9a06, LSL #48
    SUB  X22, X21, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D11
    MOVZ  X8, #0x5276, LSL #0
    SUB  X16, X8, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D14
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D17
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D19
    MOVZ  X21, #0x5276, LSL #0
    SUB  X5, X21, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D26
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D28
    MOVZ  X2, #0x5276, LSL #0
    MOVK  X2, #0x55e1, LSL #16
    MOVK  X2, #0xa8af, LSL #32
    MOVK  X2, #0x9a06, LSL #48
    SUB  X24, X2, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D29
    MOVZ  X16, #0x5276, LSL #0
    MOVK  X16, #0x55e1, LSL #16
    MOVK  X16, #0xa8af, LSL #32
    MOVK  X16, #0x9a06, LSL #48
    SUB  X10, X16, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X14
    FMOV  V0.D[1], X10
    FMOV  D1, X6
    FMOV  V1.D[1], X23
    FMOV  D2, X16
    FMOV  V2.D[1], X14
    FMOV  D3, X17
    FMOV  V3.D[1], X24
    FMOV  D4, X17
    FMOV  V4.D[1], X21
    FMOV  D5, X2
    FMOV  V5.D[1], X5
    FMOV  D6, X11
    FMOV  V6.D[1], X14
    FMOV  D7, X15
    FMOV  V7.D[1], X2
    FMOV  D8, X24
    FMOV  V8.D[1], X18
    FMOV  D9, X16
    FMOV  V9.D[1], X22
    FMOV  D10, X8
    FMOV  V10.D[1], X2
    FMOV  D11, X29
    FMOV  V11.D[1], X17
    FMOV  D12, X23
    FMOV  V12.D[1], X25
    FMOV  D13, X8
    FMOV  V13.D[1], X7
    FMOV  D14, X8
    FMOV  V14.D[1], X17
    FMOV  D15, X5
    FMOV  V15.D[1], X8
    FMOV  D16, X10
    FMOV  V16.D[1], X6
    FMOV  D17, X17
    FMOV  V17.D[1], X4
    FMOV  D18, X13
    FMOV  V18.D[1], X17
    FMOV  D19, X14
    FMOV  V19.D[1], X20
    FMOV  D20, X26
    FMOV  V20.D[1], X22
    FMOV  D21, X8
    FMOV  V21.D[1], X9
    FMOV  D22, X29
    FMOV  V22.D[1], X23
    FMOV  D23, X10
    FMOV  V23.D[1], X25
    FMOV  D24, X6
    FMOV  V24.D[1], X26
    FMOV  D25, X14
    FMOV  V25.D[1], X21
    FMOV  D26, X21
    FMOV  V26.D[1], X25
    FMOV  D27, X20
    FMOV  V27.D[1], X18
    FMOV  D28, X22
    FMOV  V28.D[1], X15
    FMOV  D29, X14
    FMOV  V29.D[1], X6
    FMOV  D30, X14
    FMOV  V30.D[1], X23
    FMOV  D31, X21
    FMOV  V31.D[1], X9
    MOVZ  X8, #0xa, LSL #0
TaishanFpMovMaddP01_label_1053:
    FMINNM  S24, S4, S31
    FMIN  H24, H16, H19
    FMIN  S26, S24, S27
    FMIN  D5, D30, D15
    FMIN  H18, H13, H24
    FMIN  S31, S28, S8
    FMIN  H6, H24, H19
    FMAX  D24, D29, D7
    FMAX  S14, S17, S28
    FMINNM  H18, H14, H26
    FMAX  H10, H26, H9
    FMIN  H9, H19, H17
    FMINNM  H4, H9, H29
    FMAXNM  D7, D11, D26
    FMAX  S11, S11, S0
    FMIN  H2, H22, H11
    FMAX  D9, D18, D14
    FMIN  D1, D18, D15
    FMINNM  S20, S17, S20
    FMINNM  S27, S25, S1
    FMAX  S25, S31, S9
    FMIN  H20, H19, H11
    FMAXNM  S18, S11, S27
    FMINNM  H21, H19, H4
    FMINNM  S14, S29, S6
    FMIN  H30, H14, H6
    FMIN  D20, D1, D28
    FMIN  S12, S15, S9
    FMINNM  D3, D2, D1
    FMAXNM  H22, H20, H7
    FMAX  S17, S22, S4
    FMIN  D25, D17, D17
    FMAX  D9, D20, D15
    FMAXNM  H10, H26, H6
    FMAX  H0, H31, H7
    FMAX  S31, S0, S29
    FMAX  S20, S26, S12
    FMIN  D14, D2, D27
    FMIN  D25, D30, D11
    FMINNM  S30, S0, S28
    FMINNM  H27, H17, H11
    FMIN  D4, D11, D22
    FMINNM  S17, S10, S20
    FMINNM  D10, D22, D12
    FMIN  S24, S24, S28
    FMIN  S25, S1, S11
    FMAX  S23, S4, S0
    FMAX  H25, H24, H2
    FMAX  H25, H9, H27
    FMAX  D22, D12, D0
    FMAXNM  S25, S29, S23
    FMAX  D29, D22, D1
    FMINNM  S8, S2, S22
    FMINNM  D8, D15, D28
    FMAX  D8, D7, D22
    FMAXNM  S12, S22, S27
    FMAX  S25, S7, S16
    FMAXNM  H12, H12, H1
    FMAXNM  D1, D11, D4
    FMINNM  H30, H30, H11
    FMIN  D8, D0, D14
    FMIN  H11, H15, H20
    FMIN  H2, H15, H27
    FMAXNM  H26, H1, H9
    FMINNM  H30, H24, H18
    FMAX  D12, D29, D10
    FMAX  D7, D31, D2
    FMAX  D14, D17, D23
    FMINNM  S8, S24, S28
    FMINNM  H31, H0, H26
    FMAXNM  D20, D25, D8
    FMINNM  S19, S1, S26
    FMAX  S4, S26, S24
    FMIN  H4, H22, H11
    FMIN  H26, H18, H17
    FMAX  S5, S30, S26
    FMAX  S12, S24, S27
    FMIN  S18, S6, S16
    FMIN  D11, D23, D10
    FMAXNM  H8, H19, H20
    FMAX  S23, S14, S20
    FMINNM  H16, H28, H8
    FMAXNM  S19, S22, S15
    FMAX  D30, D15, D19
    FMAXNM  S14, S8, S1
    FMINNM  H18, H21, H14
    FMAX  H5, H27, H12
    FMIN  S23, S0, S11
    FMAX  H0, H4, H2
    FMAX  D23, D19, D13
    FMAXNM  H24, H23, H10
    FMIN  H7, H9, H26
    FMAX  D31, D7, D1
    FMINNM  S6, S21, S18
    FMIN  D21, D17, D25
    FMAXNM  H8, H7, H17
    FMAX  H21, H17, H3
    FMAXNM  S15, S1, S21
    FMIN  S16, S17, S12
    FMINNM  D29, D22, D3
    FMINNM  S4, S23, S6
    FMIN  D8, D2, D21
    FMIN  S14, S11, S23
    FMIN  D1, D12, D24
    FMAX  S22, S1, S16
    FMAXNM  D27, D25, D2
    FMAXNM  S27, S12, S1
    FMIN  H3, H15, H31
    FMINNM  D5, D10, D29
    FMIN  H5, H29, H2
    FMINNM  D24, D7, D5
    FMAXNM  S12, S7, S4
    FMAX  H5, H25, H17
    FMAX  D9, D28, D20
    FMAXNM  S29, S2, S6
    FMAXNM  D26, D3, D2
    FMAX  H1, H11, H19
    FMAX  D9, D26, D21
    FMIN  H31, H19, H19
    FMAXNM  H11, H11, H14
    FMAXNM  H1, H27, H31
    FMINNM  S28, S29, S18
    FMINNM  S16, S8, S19
    FMAX  H3, H4, H0
    FMIN  D13, D12, D24
    FMAX  D23, D13, D3
    FMINNM  S5, S21, S13
    FMAX  S24, S20, S12
    FMAX  S6, S17, S6
    FMINNM  D13, D23, D22
    FMAX  S0, S17, S16
    FMINNM  S10, S18, S22
    FMAX  H23, H8, H21
    FMINNM  H5, H28, H27
    FMINNM  D19, D7, D20
    FMAX  S13, S6, S10
    FMIN  H1, H23, H26
    FMAXNM  S5, S29, S13
    FMIN  H30, H4, H28
    FMAX  D20, D6, D24
    FMAXNM  S20, S24, S31
    FMAXNM  S3, S16, S27
    FMAX  H19, H5, H25
    FMIN  D15, D19, D15
    FMAXNM  H30, H2, H0
    FMAX  D27, D22, D12
    FMINNM  H1, H8, H19
    FMINNM  D14, D8, D23
    FMIN  H18, H14, H14
    FMIN  H20, H11, H12
    FMAX  S20, S5, S0
    FMAXNM  D3, D30, D26
    FMIN  H25, H6, H17
    FMIN  D16, D15, D4
    FMINNM  H20, H17, H12
    FMAXNM  S11, S1, S24
    FMAXNM  D18, D0, D10
    FMAXNM  H4, H26, H12
    FMAXNM  D15, D18, D6
    FMINNM  S4, S27, S27
    FMINNM  H14, H12, H29
    FMAX  H19, H23, H28
    FMAX  H21, H20, H12
    FMAX  H20, H18, H9
    FMAXNM  D2, D23, D23
    FMAX  H26, H27, H13
    FMAX  H10, H17, H14
    FMAXNM  D8, D17, D25
    FMINNM  S18, S7, S9
    FMIN  H29, H28, H4
    FMIN  S11, S16, S20
    FMAXNM  D25, D13, D10
    FMINNM  S18, S11, S13
    FMIN  D11, D11, D1
    FMINNM  D9, D13, D19
    FMAX  D18, D26, D26
    FMINNM  H19, H22, H21
    FMAXNM  D8, D5, D28
    FMAXNM  H22, H3, H2
    FMAXNM  H31, H18, H16
    FMINNM  H16, H1, H25
    FMINNM  H17, H7, H14
    FMAX  H18, H4, H14
    FMAX  S27, S6, S20
    FMIN  D21, D25, D29
    FMAXNM  D24, D12, D30
    FMAXNM  S28, S0, S20
    FMAXNM  D24, D8, D15
    FMIN  S9, S5, S30
    FMAX  D11, D19, D14
    FMINNM  H1, H14, H16
    FMINNM  D30, D3, D0
    FMAXNM  S4, S31, S31
    FMAX  S26, S4, S11
    FMAXNM  S26, S22, S0
    FMIN  H24, H13, H0
    FMAX  H13, H16, H12
    FMIN  S13, S27, S2
    FMAXNM  H18, H19, H15
    FMAXNM  H24, H2, H28
    SUBS  X8, X8, #0x1
    B.NE  TaishanFpMovMaddP01_label_1053
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D10
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D13
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D15
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D16
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
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
    FMOV  D0, X15
    FMOV  V0.D[1], X22
    FMOV  D1, X25
    FMOV  V1.D[1], X19
    FMOV  D2, X3
    FMOV  V2.D[1], X19
    FMOV  D3, X10
    FMOV  V3.D[1], X24
    FMOV  D4, X29
    FMOV  V4.D[1], X9
    FMOV  D5, X4
    FMOV  V5.D[1], X21
    FMOV  D6, X28
    FMOV  V6.D[1], X5
    FMOV  D7, X26
    FMOV  V7.D[1], X6
    FMOV  D8, X4
    FMOV  V8.D[1], X9
    FMOV  D9, X15
    FMOV  V9.D[1], X13
    FMOV  D10, X16
    FMOV  V10.D[1], X8
    FMOV  D11, X20
    FMOV  V11.D[1], X15
    FMOV  D12, X9
    FMOV  V12.D[1], X14
    FMOV  D13, X23
    FMOV  V13.D[1], X2
    FMOV  D14, X15
    FMOV  V14.D[1], X16
    FMOV  D15, X13
    FMOV  V15.D[1], X9
    FMOV  D16, X23
    FMOV  V16.D[1], X4
    FMOV  D17, X6
    FMOV  V17.D[1], X15
    FMOV  D18, X16
    FMOV  V18.D[1], X20
    FMOV  D19, X2
    FMOV  V19.D[1], X24
    FMOV  D20, X8
    FMOV  V20.D[1], X4
    FMOV  D21, X14
    FMOV  V21.D[1], X9
    FMOV  D22, X18
    FMOV  V22.D[1], X22
    FMOV  D23, X24
TaishanFpMovMaddP01_label_229:
    FMOV  V23.D[1], X6
    FMOV  D24, X11
    FMOV  V24.D[1], X23
    FMOV  D25, X28
    FMOV  V25.D[1], X4
    FMOV  D26, X23
    FMOV  V26.D[1], X17
    FMOV  D27, X11
    FMOV  V27.D[1], X28
    FMOV  D28, X10
    FMOV  V28.D[1], X16
    FMOV  D29, X8
    FMOV  V29.D[1], X19
    FMOV  D30, X7
    FMOV  V30.D[1], X9
    FMOV  D31, X14
    FMOV  V31.D[1], X27
    MOVZ  X16, #0xf, LSL #0
TaishanFpMovMaddP01_label_1130:
    FMAXNM  S14, S8, S19
    FMINNM  H2, H27, H18
    FMAX  D29, D10, D29
    FMIN  S23, S7, S1
    FMIN  H23, H29, H15
    FMAXNM  D24, D1, D11
    FMINNM  H11, H3, H20
    FMIN  H31, H31, H26
    FMIN  D8, D21, D5
    FMIN  S10, S28, S3
    FMAX  H30, H21, H13
    FMINNM  S26, S10, S15
    FMIN  D30, D7, D6
    FMAX  D18, D16, D19
    FMINNM  D29, D20, D24
    FMINNM  S29, S24, S9
    FMAX  H17, H11, H29
    FMAXNM  H1, H29, H9
    FMAXNM  S25, S18, S26
    FMIN  H10, H19, H8
    FMAX  H24, H27, H19
    FMIN  H18, H9, H19
    FMAXNM  S18, S1, S15
    FMINNM  H1, H21, H14
    FMINNM  H29, H14, H8
    FMIN  D17, D20, D24
    FMINNM  S18, S7, S26
    FMINNM  H30, H30, H11
    FMAXNM  D20, D26, D11
    FMAX  H2, H8, H17
    FMAXNM  S24, S25, S14
    FMAXNM  H0, H15, H8
    FMAXNM  S8, S14, S12
    FMAX  H27, H22, H14
    FMINNM  S28, S11, S23
    FMAXNM  S26, S30, S19
    FMAXNM  H19, H21, H15
    FMIN  D11, D8, D11
    FMINNM  H23, H30, H20
    FMINNM  H25, H20, H28
    FMAXNM  S6, S21, S7
    FMINNM  S4, S19, S29
    FMAXNM  H4, H12, H4
    FMIN  D11, D29, D4
    FMAX  S7, S22, S10
    FMAXNM  S17, S10, S6
    FMAXNM  S4, S30, S6
    FMAXNM  D10, D6, D4
    FMINNM  D18, D25, D28
    FMAXNM  H29, H11, H16
    FMAXNM  D6, D1, D18
    FMAX  D5, D28, D31
    FMINNM  S17, S15, S0
    FMAX  S7, S8, S28
    FMAXNM  D6, D26, D19
    FMIN  H20, H7, H30
    FMIN  H12, H20, H28
    FMAX  D5, D23, D18
    FMIN  D29, D17, D5
    FMAX  H1, H18, H24
    FMAX  S14, S20, S18
    FMINNM  D20, D22, D12
    FMAX  D1, D20, D24
    FMAXNM  S15, S2, S11
    FMAXNM  D21, D1, D25
    FMINNM  H19, H29, H30
    FMINNM  D13, D6, D13
    FMAXNM  S2, S21, S18
    FMAX  H15, H7, H6
    FMINNM  D16, D5, D4
    FMINNM  H3, H30, H0
    FMINNM  D18, D27, D31
    FMIN  H24, H14, H22
    FMIN  D12, D17, D14
    FMAXNM  H23, H7, H21
    FMINNM  D31, D10, D26
    FMAX  H28, H13, H15
    FMAX  S26, S1, S10
    FMIN  D16, D28, D10
    FMINNM  S8, S29, S3
    FMIN  S25, S24, S9
    FMIN  H6, H16, H18
    FMINNM  H12, H23, H17
    FMINNM  D21, D10, D18
    FMAXNM  S25, S26, S26
    FMIN  S13, S27, S27
    FMAX  S11, S15, S19
    FMAX  H19, H13, H11
    FMAXNM  S16, S14, S16
    FMAX  H27, H10, H6
    FMIN  H27, H28, H14
    FMINNM  D17, D27, D31
    FMINNM  S2, S3, S14
    FMIN  H5, H11, H21
    FMINNM  H30, H5, H22
    FMINNM  H26, H7, H31
    FMAX  H4, H16, H5
    FMIN  S24, S9, S27
    FMAXNM  H6, H4, H2
    FMAXNM  D29, D31, D2
    FMIN  D0, D26, D29
    FMAXNM  D30, D21, D16
    FMAX  S20, S8, S25
    FMAXNM  D24, D20, D15
    FMIN  S29, S31, S7
    FMIN  H30, H19, H5
    FMAXNM  S27, S30, S9
    FMAXNM  S5, S14, S0
    FMIN  H19, H23, H17
    FMAX  D2, D2, D23
    FMAX  S27, S7, S31
    FMAX  D0, D15, D15
    FMINNM  S28, S24, S6
    FMAXNM  S1, S7, S30
    FMAX  S12, S1, S8
    FMIN  D5, D16, D16
    FMAX  S12, S30, S15
    FMIN  D6, D13, D12
    FMIN  H25, H22, H16
    FMAXNM  D19, D11, D8
    FMINNM  D7, D18, D13
    FMAX  S16, S14, S30
    FMAXNM  D27, D11, D23
    FMIN  S16, S27, S18
    FMAXNM  H13, H27, H31
    FMINNM  S11, S7, S14
    FMINNM  D4, D19, D28
    FMINNM  D22, D25, D21
    FMINNM  D29, D2, D31
    FMIN  S13, S18, S29
    FMAX  H25, H21, H11
    FMAX  D27, D19, D4
    FMIN  S6, S22, S28
    FMAX  D1, D27, D8
    FMAX  H1, H21, H24
    FMAX  S6, S30, S26
    FMAXNM  H31, H6, H26
    FMAX  H16, H15, H25
    FMAX  D15, D17, D23
    FMAXNM  D1, D4, D11
    FMIN  H18, H19, H4
    FMAX  S29, S2, S27
    FMINNM  D15, D15, D23
    FMIN  D9, D7, D10
    FMIN  D0, D5, D31
    FMINNM  S24, S28, S16
    FMAX  D21, D16, D8
    FMINNM  D28, D29, D5
    FMINNM  D26, D24, D25
    FMAXNM  H16, H12, H15
    FMIN  H17, H20, H1
    FMINNM  H18, H28, H13
    FMIN  S2, S6, S27
    FMIN  S14, S13, S31
    FMAXNM  H4, H25, H12
    FMAXNM  H8, H15, H0
    FMINNM  D1, D18, D13
    FMAX  D9, D18, D9
    FMAXNM  D9, D21, D28
    FMIN  S31, S3, S6
    FMIN  H23, H25, H2
    FMINNM  S24, S29, S4
    FMAXNM  S7, S14, S15
    FMIN  H17, H13, H4
    FMIN  S8, S5, S27
    FMAX  S26, S29, S19
    FMINNM  S16, S14, S21
    FMAX  S27, S17, S10
    FMAXNM  H4, H11, H11
    FMAXNM  H9, H24, H26
    FMINNM  S26, S8, S1
    FMINNM  D31, D29, D22
    FMAXNM  S20, S1, S11
    FMAXNM  D26, D31, D7
    FMIN  H23, H13, H30
    FMAXNM  H23, H5, H24
    FMIN  D20, D26, D19
    FMIN  S26, S19, S6
    FMAXNM  S7, S7, S0
    FMIN  D9, D1, D2
    FMINNM  H12, H16, H16
    FMAXNM  D27, D19, D20
    FMAX  H15, H8, H24
    FMAXNM  H29, H20, H8
    FMIN  S4, S15, S7
    FMINNM  S7, S29, S1
    FMAXNM  S8, S10, S14
    FMIN  H1, H27, H29
    FMIN  H1, H6, H11
    FMAXNM  S8, S4, S4
    FMAXNM  D4, D26, D12
    FMAXNM  S9, S13, S3
    FMIN  H14, H26, H6
    FMIN  H27, H3, H13
    FMAXNM  H3, H16, H14
    FMINNM  D19, D20, D6
    FMIN  D0, D1, D17
    FMIN  D19, D12, D23
    FMAXNM  H19, H7, H15
    FMAX  H19, H3, H4
    SUBS  X16, X16, #0x1
    B.NE  TaishanFpMovMaddP01_label_1130
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X28, X27, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X29, X26, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X29, X18, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X7, X14, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X18, X16, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X11, X5, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X20, X21, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X27, X26, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X26, X17, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X13, X15, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X19, X9, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X8, X29, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X16, X6, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X14, X22, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X5, X17, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X17, X21, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X18, X4, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X7, X23, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D6
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D8
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D9
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D15
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D20
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D27
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x6820, LSL #0
    MOVK  X2, #0xbeca, LSL #16
    MOVK  X2, #0xddcf, LSL #32
    MOVK  X2, #0x509c, LSL #48
    MOVZ  X3, #0x16b1, LSL #0
    MOVK  X3, #0x3e9e, LSL #16
    MOVK  X3, #0x93f1, LSL #32
    MOVK  X3, #0xdc32, LSL #48
    MOVZ  X4, #0xec, LSL #0
    MOVK  X4, #0xd73a, LSL #16
    MOVK  X4, #0x288c, LSL #32
    MOVK  X4, #0x9230, LSL #48
    MOVZ  X5, #0x4a94, LSL #0
    MOVK  X5, #0x7084, LSL #16
    MOVK  X5, #0x3c34, LSL #32
    MOVK  X5, #0x879c, LSL #48
    MOVZ  X6, #0x59a1, LSL #0
    MOVK  X6, #0x86a, LSL #16
    MOVK  X6, #0x196e, LSL #32
    MOVK  X6, #0x35ca, LSL #48
    MOVZ  X7, #0x47f9, LSL #0
    MOVK  X7, #0xf012, LSL #16
    MOVK  X7, #0x2f9, LSL #32
    MOVK  X7, #0x6a74, LSL #48
    MOVZ  X8, #0x97b8, LSL #0
    MOVK  X8, #0x2fd2, LSL #16
    MOVK  X8, #0x3797, LSL #32
    MOVK  X8, #0xfc00, LSL #48
    MOVZ  X9, #0xa59f, LSL #0
    MOVK  X9, #0xcbf4, LSL #16
    MOVK  X9, #0x9aba, LSL #32
    MOVK  X9, #0xb12b, LSL #48
    MOVZ  X10, #0x6bb2, LSL #0
    MOVK  X10, #0xff4d, LSL #16
    MOVK  X10, #0xd123, LSL #32
    MOVK  X10, #0x3e57, LSL #48
    MOVZ  X11, #0xb485, LSL #0
    MOVK  X11, #0xd3ed, LSL #16
    MOVK  X11, #0x2e24, LSL #32
    MOVK  X11, #0x341c, LSL #48
    MOVZ  X13, #0xd878, LSL #0
    MOVK  X13, #0x7b5a, LSL #16
    MOVK  X13, #0x83eb, LSL #32
    MOVK  X13, #0xba3c, LSL #48
    MOVZ  X14, #0x270c, LSL #0
    MOVK  X14, #0xde28, LSL #16
    MOVK  X14, #0xbedb, LSL #32
    MOVK  X14, #0x68e1, LSL #48
    MOVZ  X15, #0x770f, LSL #0
    MOVK  X15, #0xa33, LSL #16
    MOVK  X15, #0x5912, LSL #32
    MOVK  X15, #0xe707, LSL #48
    MOVZ  X16, #0x2edc, LSL #0
    MOVK  X16, #0xcf63, LSL #16
    MOVK  X16, #0xd47, LSL #32
    MOVK  X16, #0xbaf7, LSL #48
    MOVZ  X17, #0x3ee4, LSL #0
    MOVK  X17, #0x388f, LSL #16
    MOVK  X17, #0xfd79, LSL #32
    MOVK  X17, #0xf577, LSL #48
    MOVZ  X18, #0x542f, LSL #0
    MOVK  X18, #0x54a1, LSL #16
    MOVK  X18, #0xec4f, LSL #32
    MOVK  X18, #0x1452, LSL #48
    MOVZ  X19, #0x5803, LSL #0
    MOVK  X19, #0x4574, LSL #16
    MOVK  X19, #0x572c, LSL #32
    MOVK  X19, #0xafbe, LSL #48
    MOVZ  X20, #0x1c07, LSL #0
    MOVK  X20, #0x8885, LSL #16
    MOVK  X20, #0x833, LSL #32
    MOVK  X20, #0xe7e5, LSL #48
    MOVZ  X21, #0x123e, LSL #0
    MOVK  X21, #0x2058, LSL #16
    MOVK  X21, #0xf889, LSL #32
    MOVK  X21, #0x561a, LSL #48
    MOVZ  X22, #0xa3e8, LSL #0
    MOVK  X22, #0xc33d, LSL #16
    MOVK  X22, #0x2f95, LSL #32
    MOVK  X22, #0x56b1, LSL #48
    MOVZ  X23, #0x6b7f, LSL #0
    MOVK  X23, #0xf68b, LSL #16
    MOVK  X23, #0xbd27, LSL #32
    MOVK  X23, #0xb077, LSL #48
    MOVZ  X24, #0x980c, LSL #0
    MOVK  X24, #0x4806, LSL #16
    MOVK  X24, #0x96b, LSL #32
    MOVK  X24, #0xeeda, LSL #48
    MOVZ  X25, #0xd270, LSL #0
TaishanFpMovMaddP01_label_28:
    MOVK  X25, #0x9f27, LSL #16
    MOVK  X25, #0xb80e, LSL #32
    MOVK  X25, #0xbd00, LSL #48
    MOVZ  X26, #0xc511, LSL #0
    MOVK  X26, #0xd1a6, LSL #16
    MOVK  X26, #0x84e, LSL #32
    MOVK  X26, #0x4b52, LSL #48
    MOVZ  X27, #0xed0e, LSL #0
    MOVK  X27, #0x203a, LSL #16
    MOVK  X27, #0x8254, LSL #32
    MOVK  X27, #0xfbc2, LSL #48
    MOVZ  X28, #0x7daa, LSL #0
    MOVK  X28, #0x5012, LSL #16
    MOVK  X28, #0xe571, LSL #32
    MOVK  X28, #0xa9ea, LSL #48
    MOVZ  X29, #0x74e8, LSL #0
    MOVK  X29, #0x4d5d, LSL #16
    MOVK  X29, #0x5275, LSL #32
    MOVK  X29, #0x13ad, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X22
    FMOV  D1, X6
    FMOV  V1.D[1], X29
    FMOV  D2, X29
    FMOV  V2.D[1], X21
    FMOV  D3, X29
    FMOV  V3.D[1], X28
    FMOV  D4, X27
    FMOV  V4.D[1], X23
    FMOV  D5, X6
    FMOV  V5.D[1], X6
    FMOV  D6, X20
    FMOV  V6.D[1], X6
    FMOV  D7, X27
    FMOV  V7.D[1], X25
    FMOV  D8, X28
    FMOV  V8.D[1], X9
    FMOV  D9, X18
    FMOV  V9.D[1], X11
    FMOV  D10, X6
    FMOV  V10.D[1], X8
    FMOV  D11, X3
    FMOV  V11.D[1], X29
    FMOV  D12, X15
    FMOV  V12.D[1], X28
    FMOV  D13, X20
    FMOV  V13.D[1], X11
    FMOV  D14, X24
    FMOV  V14.D[1], X26
    FMOV  D15, X4
    FMOV  V15.D[1], X22
    FMOV  D16, X20
    FMOV  V16.D[1], X20
    FMOV  D17, X18
    FMOV  V17.D[1], X19
    FMOV  D18, X27
    FMOV  V18.D[1], X20
    FMOV  D19, X21
    FMOV  V19.D[1], X27
    FMOV  D20, X11
    FMOV  V20.D[1], X14
    FMOV  D21, X24
    FMOV  V21.D[1], X21
    FMOV  D22, X20
    FMOV  V22.D[1], X21
    FMOV  D23, X24
    FMOV  V23.D[1], X29
    FMOV  D24, X15
    FMOV  V24.D[1], X15
    FMOV  D25, X29
    FMOV  V25.D[1], X21
    FMOV  D26, X3
    FMOV  V26.D[1], X26
    FMOV  D27, X19
    FMOV  V27.D[1], X28
    FMOV  D28, X19
    FMOV  V28.D[1], X3
    FMOV  D29, X26
    FMOV  V29.D[1], X17
    FMOV  D30, X7
    FMOV  V30.D[1], X7
    FMOV  D31, X9
    FMOV  V31.D[1], X20
    MOVZ  X15, #0xa, LSL #0
TaishanFpMovMaddP01_label_1203:
    FMAX  D19, D27, D20
    FMINNM  S21, S15, S19
    FMIN  D19, D2, D29
    FMINNM  D3, D0, D17
    FMAXNM  S22, S7, S12
    FMAXNM  H12, H13, H30
    FMIN  S24, S9, S24
    FMAXNM  H16, H25, H29
    FMINNM  D1, D9, D16
    FMIN  S3, S28, S2
    FMIN  S31, S9, S20
    FMAXNM  S26, S2, S9
    FMAX  D29, D5, D23
    FMAXNM  H5, H1, H13
    FMINNM  S13, S19, S27
    FMAXNM  S9, S5, S22
    FMAXNM  S21, S13, S28
    FMAX  D15, D16, D23
    FMINNM  D23, D27, D27
    FMINNM  H1, H5, H3
    FMAXNM  S17, S31, S12
    FMIN  H5, H25, H24
    FMIN  D17, D29, D2
    FMINNM  S11, S21, S12
    FMINNM  D0, D23, D20
    FMAXNM  D18, D30, D10
    FMIN  D31, D18, D7
    FMAX  S23, S11, S12
    FMAX  S27, S19, S11
    FMIN  S22, S11, S19
    FMINNM  D1, D16, D3
    FMAXNM  D30, D24, D31
    FMIN  S4, S7, S22
    FMIN  D27, D15, D27
TaishanFpMovMaddP01_label_344:
    FMINNM  D30, D25, D21
    FMAX  H26, H30, H27
    FMAXNM  D4, D2, D22
    FMINNM  D14, D26, D29
    FMAX  D10, D31, D4
    FMINNM  S2, S22, S11
    FMIN  H21, H0, H5
    FMINNM  S23, S1, S4
    FMAXNM  S24, S22, S22
    FMIN  D23, D0, D23
    FMAX  H19, H7, H23
    FMINNM  H6, H27, H20
    FMAXNM  S19, S7, S26
    FMAX  D31, D29, D2
    FMAX  D14, D4, D5
    FMINNM  H17, H13, H26
    FMIN  S1, S24, S10
    FMIN  S10, S20, S15
    FMINNM  D7, D31, D20
    FMAX  H19, H19, H25
    FMIN  S2, S19, S10
    FMIN  H29, H30, H0
    FMAXNM  S7, S14, S17
    FMAX  D27, D19, D12
    FMIN  S22, S5, S1
    FMAXNM  H7, H1, H7
    FMAX  D1, D23, D5
    FMINNM  H23, H18, H2
    FMIN  S17, S18, S2
    FMAX  S13, S29, S9
    FMINNM  S26, S24, S28
    FMAX  S13, S9, S25
    FMAXNM  H27, H29, H6
    FMAXNM  H0, H23, H18
    FMAXNM  H27, H11, H26
    FMIN  H5, H15, H26
    FMIN  H29, H2, H25
    FMAXNM  H0, H1, H15
    FMIN  H15, H19, H22
    FMINNM  H3, H0, H10
    FMIN  S21, S2, S30
    FMAXNM  D7, D15, D5
    FMAXNM  S27, S15, S19
    FMINNM  H28, H26, H28
    FMIN  S21, S13, S30
    FMINNM  S17, S9, S13
    FMAXNM  S13, S17, S17
    FMAX  S13, S27, S4
    FMIN  H8, H9, H0
    FMIN  S18, S15, S29
    FMIN  S13, S16, S24
    FMINNM  H30, H9, H16
    FMAX  S18, S29, S9
    FMAX  H16, H22, H10
    FMIN  S24, S30, S28
    FMAXNM  D14, D15, D21
    FMAX  S16, S26, S14
    FMINNM  S18, S3, S11
    FMAXNM  D19, D5, D8
    FMAX  H12, H9, H13
    FMAXNM  D2, D30, D10
    FMAX  S7, S14, S3
    FMAXNM  H14, H24, H22
    FMAX  H18, H16, H25
    FMAX  D12, D26, D27
    FMIN  H13, H1, H13
    FMAX  S24, S19, S5
    FMINNM  S15, S29, S21
    FMINNM  H6, H9, H28
    FMIN  D24, D11, D13
    FMAXNM  H19, H29, H22
    FMAXNM  H27, H15, H5
    FMAX  D31, D19, D26
    FMINNM  H11, H26, H9
    FMAXNM  H19, H19, H8
    FMINNM  D14, D26, D11
    FMAXNM  D27, D19, D31
    FMAX  S28, S14, S1
    FMAXNM  H28, H8, H29
    FMAX  H21, H24, H24
    FMAXNM  S11, S2, S29
    FMAXNM  D6, D26, D19
    FMINNM  S16, S3, S1
    FMAX  S30, S7, S7
    FMAX  S13, S16, S22
    FMIN  S12, S25, S29
    FMAX  D21, D29, D3
    FMIN  S25, S9, S22
    FMAX  S1, S15, S21
    FMINNM  D9, D22, D19
    FMIN  H25, H24, H5
    FMIN  D4, D15, D5
    FMIN  S13, S19, S13
    FMAX  S26, S12, S21
    FMAXNM  S7, S10, S31
    FMAX  S29, S10, S25
    FMAX  H25, H8, H11
    FMAX  S27, S31, S31
    FMINNM  S17, S30, S30
    FMAXNM  S3, S11, S7
    FMINNM  H2, H22, H9
    FMAX  D14, D27, D16
    FMIN  S4, S16, S19
    FMIN  H10, H7, H0
    FMIN  D3, D0, D13
    FMAXNM  H25, H30, H22
    FMAXNM  S2, S30, S30
    FMAXNM  D16, D7, D26
    FMAXNM  D6, D9, D20
    FMIN  H11, H2, H15
    FMAX  S22, S17, S25
    FMIN  S6, S14, S23
    FMAX  D18, D4, D12
    FMIN  H31, H30, H14
    FMINNM  S3, S22, S8
    FMIN  H29, H14, H9
    FMAX  H0, H21, H9
    FMINNM  S27, S9, S6
    FMAXNM  S16, S26, S12
    FMIN  H30, H30, H10
    FMINNM  D11, D21, D20
    FMAX  S19, S13, S18
    FMINNM  S20, S31, S1
    FMINNM  S12, S8, S17
    FMINNM  D16, D26, D7
    FMAXNM  D7, D25, D27
    FMINNM  D6, D20, D9
    FMIN  H16, H26, H14
    FMAXNM  H16, H0, H2
    FMAXNM  S2, S23, S21
    FMAXNM  S26, S11, S24
    FMAXNM  D7, D2, D25
    FMINNM  H14, H20, H22
    FMINNM  S25, S1, S27
    FMAX  H12, H29, H1
    FMAXNM  S16, S27, S30
    FMAX  H2, H19, H11
    FMINNM  D4, D23, D7
    FMAXNM  S1, S18, S24
    FMINNM  S18, S16, S21
    FMINNM  H22, H16, H21
    FMAX  D10, D12, D7
    FMAX  H22, H13, H15
    FMAX  D27, D26, D18
    FMAX  D28, D1, D2
    FMAX  H27, H30, H0
    FMIN  H5, H25, H4
    FMINNM  D5, D5, D11
    FMIN  H13, H3, H9
    FMIN  S26, S20, S11
    FMAXNM  H26, H6, H28
    FMAXNM  H18, H30, H11
    FMINNM  D29, D16, D26
    FMAXNM  S5, S14, S2
    FMINNM  H19, H21, H23
    FMAX  S22, S7, S23
    FMIN  H3, H29, H27
    FMAXNM  S27, S5, S21
    FMIN  S27, S22, S29
    FMAX  H11, H9, H12
    FMAXNM  H23, H23, H15
    FMIN  H3, H12, H18
    FMIN  H25, H31, H10
    FMIN  S7, S24, S31
    FMAX  H9, H7, H25
    FMAX  H10, H30, H24
    SUBS  X15, X15, #0x1
    B.NE  TaishanFpMovMaddP01_label_1203
    MOVZ  X24, #0x6820, LSL #0
    MOVK  X24, #0xbeca, LSL #16
    MOVK  X24, #0xddcf, LSL #32
    MOVK  X24, #0x509c, LSL #48
    SUB  X13, X24, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x16b1, LSL #0
    MOVK  X4, #0x3e9e, LSL #16
    MOVK  X4, #0x93f1, LSL #32
    MOVK  X4, #0xdc32, LSL #48
    SUB  X23, X4, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x16b1, LSL #0
    MOVK  X20, #0x3e9e, LSL #16
    MOVK  X20, #0x93f1, LSL #32
    MOVK  X20, #0xdc32, LSL #48
    SUB  X26, X20, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x4a94, LSL #0
    MOVK  X22, #0x7084, LSL #16
    MOVK  X22, #0x3c34, LSL #32
    MOVK  X22, #0x879c, LSL #48
    SUB  X19, X22, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x59a1, LSL #0
    MOVK  X19, #0x86a, LSL #16
    MOVK  X19, #0x196e, LSL #32
    MOVK  X19, #0x35ca, LSL #48
    SUB  X22, X19, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0x47f9, LSL #0
    MOVK  X10, #0xf012, LSL #16
    MOVK  X10, #0x2f9, LSL #32
    MOVK  X10, #0x6a74, LSL #48
    SUB  X2, X10, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x97b8, LSL #0
    MOVK  X5, #0x2fd2, LSL #16
    MOVK  X5, #0x3797, LSL #32
    MOVK  X5, #0xfc00, LSL #48
    SUB  X28, X5, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0xa59f, LSL #0
    MOVK  X20, #0xcbf4, LSL #16
    MOVK  X20, #0x9aba, LSL #32
    MOVK  X20, #0xb12b, LSL #48
    SUB  X22, X20, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x47f9, LSL #0
    MOVK  X17, #0xf012, LSL #16
    MOVK  X17, #0x2f9, LSL #32
    MOVK  X17, #0x6a74, LSL #48
    SUB  X24, X17, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0xb485, LSL #0
    MOVK  X11, #0xd3ed, LSL #16
    MOVK  X11, #0x2e24, LSL #32
    MOVK  X11, #0x341c, LSL #48
    SUB  X14, X11, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x2edc, LSL #0
    MOVK  X2, #0xcf63, LSL #16
    MOVK  X2, #0xd47, LSL #32
    MOVK  X2, #0xbaf7, LSL #48
    SUB  X25, X2, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x47f9, LSL #0
    MOVK  X8, #0xf012, LSL #16
    MOVK  X8, #0x2f9, LSL #32
    MOVK  X8, #0x6a74, LSL #48
    SUB  X27, X8, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x542f, LSL #0
    MOVK  X26, #0x54a1, LSL #16
    MOVK  X26, #0xec4f, LSL #32
    MOVK  X26, #0x1452, LSL #48
    SUB  X29, X26, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0xa59f, LSL #0
    MOVK  X16, #0xcbf4, LSL #16
    MOVK  X16, #0x9aba, LSL #32
    MOVK  X16, #0xb12b, LSL #48
    SUB  X23, X16, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x123e, LSL #0
    MOVK  X22, #0x2058, LSL #16
    MOVK  X22, #0xf889, LSL #32
    MOVK  X22, #0x561a, LSL #48
    SUB  X2, X22, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x123e, LSL #0
    MOVK  X17, #0x2058, LSL #16
    MOVK  X17, #0xf889, LSL #32
    MOVK  X17, #0x561a, LSL #48
    SUB  X15, X17, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x542f, LSL #0
    MOVK  X15, #0x54a1, LSL #16
    MOVK  X15, #0xec4f, LSL #32
    MOVK  X15, #0x1452, LSL #48
    SUB  X16, X15, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D3
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D4
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D5
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D15
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D20
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D23
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X22, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
TaishanFpMovMaddP01_label_963:
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
TaishanFpMovMaddP01_label_1048:
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X22
    FMOV  V0.D[1], X18
    FMOV  D1, X22
    FMOV  V1.D[1], X14
    FMOV  D2, X3
    FMOV  V2.D[1], X24
    FMOV  D3, X10
    FMOV  V3.D[1], X22
    FMOV  D4, X13
    FMOV  V4.D[1], X28
    FMOV  D5, X2
    FMOV  V5.D[1], X8
    FMOV  D6, X7
    FMOV  V6.D[1], X2
    FMOV  D7, X29
    FMOV  V7.D[1], X4
    FMOV  D8, X18
    FMOV  V8.D[1], X29
    FMOV  D9, X26
    FMOV  V9.D[1], X6
    FMOV  D10, X6
    FMOV  V10.D[1], X26
    FMOV  D11, X6
    FMOV  V11.D[1], X5
    FMOV  D12, X27
    FMOV  V12.D[1], X16
    FMOV  D13, X11
    FMOV  V13.D[1], X8
    FMOV  D14, X20
    FMOV  V14.D[1], X5
    FMOV  D15, X10
    FMOV  V15.D[1], X23
    FMOV  D16, X24
    FMOV  V16.D[1], X6
    FMOV  D17, X22
    FMOV  V17.D[1], X2
    FMOV  D18, X19
    FMOV  V18.D[1], X29
    FMOV  D19, X27
    FMOV  V19.D[1], X4
    FMOV  D20, X23
    FMOV  V20.D[1], X26
    FMOV  D21, X11
    FMOV  V21.D[1], X23
    FMOV  D22, X3
    FMOV  V22.D[1], X26
    FMOV  D23, X18
    FMOV  V23.D[1], X14
    FMOV  D24, X5
    FMOV  V24.D[1], X8
    FMOV  D25, X6
    FMOV  V25.D[1], X27
    FMOV  D26, X24
    FMOV  V26.D[1], X19
    FMOV  D27, X7
    FMOV  V27.D[1], X16
    FMOV  D28, X2
    FMOV  V28.D[1], X5
    FMOV  D29, X17
    FMOV  V29.D[1], X21
    FMOV  D30, X24
    FMOV  V30.D[1], X23
    FMOV  D31, X14
    FMOV  V31.D[1], X26
    MOVZ  X25, #0xa, LSL #0
TaishanFpMovMaddP01_label_1282:
    FMAX  D31, D17, D0
    FMINNM  H26, H27, H24
    FMINNM  H4, H14, H11
    FMAXNM  D25, D17, D13
    FMAXNM  D20, D10, D15
    FMIN  D5, D20, D13
    FMIN  H22, H24, H6
    FMAXNM  S10, S20, S21
    FMAXNM  S20, S2, S7
    FMAXNM  S30, S16, S22
    FMINNM  D10, D13, D24
    FMAX  S6, S8, S24
    FMAXNM  D12, D8, D15
    FMINNM  H28, H12, H19
    FMINNM  H15, H7, H3
    FMIN  D16, D3, D16
    FMAX  S17, S17, S11
    FMAXNM  H3, H28, H31
    FMAXNM  S24, S15, S4
    FMAX  S0, S27, S4
    FMINNM  S30, S25, S31
    FMIN  H4, H31, H9
    FMAXNM  H27, H24, H0
    FMAX  H28, H3, H15
    FMIN  H0, H4, H21
    FMIN  S7, S0, S2
    FMAXNM  D22, D5, D6
    FMIN  S2, S5, S6
    FMIN  D20, D3, D22
    FMINNM  D18, D31, D23
    FMAX  D3, D2, D4
    FMIN  D17, D23, D8
    FMAXNM  H25, H29, H27
    FMAX  H28, H31, H6
    FMAX  S16, S17, S26
    FMIN  S29, S1, S26
    FMAXNM  H30, H7, H12
    FMAX  H14, H6, H25
    FMAX  D14, D21, D22
    FMAX  H10, H15, H14
    FMAXNM  H22, H12, H1
    FMIN  S25, S4, S28
    FMAX  H2, H28, H31
    FMAX  S16, S12, S26
    FMINNM  S0, S6, S12
    FMINNM  S15, S18, S18
    FMINNM  D25, D18, D15
    FMAXNM  S18, S18, S14
    FMIN  D9, D0, D25
    FMINNM  H6, H9, H3
    FMAXNM  S29, S8, S6
    FMAXNM  D22, D1, D9
    FMIN  H3, H7, H27
    FMINNM  S30, S17, S6
    FMAX  S8, S22, S14
    FMINNM  S2, S0, S13
    FMAX  S9, S23, S0
    FMAX  D12, D22, D12
    FMINNM  S0, S2, S25
    FMAX  D21, D3, D27
    FMAXNM  H11, H16, H11
    FMAXNM  S31, S25, S15
    FMINNM  H18, H2, H3
    FMINNM  H30, H2, H18
    FMIN  H27, H13, H4
    FMIN  S29, S14, S22
    FMINNM  H16, H23, H22
    FMAX  D24, D17, D30
    FMAX  S4, S16, S15
    FMINNM  H6, H16, H9
    FMAX  H27, H29, H16
    FMIN  S24, S24, S24
    FMINNM  D13, D7, D13
    FMIN  D31, D4, D0
    FMINNM  H27, H24, H25
    FMAX  S6, S25, S4
    FMAX  D13, D14, D16
    FMINNM  H24, H5, H11
    FMAX  D26, D13, D12
    FMIN  S11, S6, S27
    FMAXNM  D22, D22, D26
    FMAXNM  D8, D21, D11
    FMIN  H22, H22, H10
    FMIN  S18, S24, S11
    FMAX  H8, H24, H11
    FMAXNM  H23, H6, H5
    FMIN  H1, H31, H6
    FMIN  S31, S23, S0
    FMAX  H17, H6, H9
    FMIN  H17, H25, H29
    FMIN  H11, H29, H10
    FMINNM  S5, S6, S31
    FMAX  D23, D26, D6
    FMIN  S28, S31, S30
    FMINNM  D4, D21, D6
    FMINNM  S22, S27, S11
    FMAX  H21, H13, H2
    FMINNM  H30, H30, H18
    FMAX  H22, H31, H5
    FMAXNM  H31, H1, H19
    FMAX  H30, H4, H25
    FMAX  D28, D30, D25
    FMINNM  H3, H6, H13
    FMAXNM  H19, H1, H22
    FMINNM  S10, S14, S16
    FMINNM  S8, S21, S15
    FMIN  D1, D30, D31
    FMIN  S3, S17, S17
    FMAX  D6, D13, D27
    FMIN  S24, S26, S31
    FMAXNM  D16, D22, D24
    FMIN  H12, H5, H26
    FMIN  S19, S30, S29
    FMAX  S29, S24, S25
    FMINNM  D7, D9, D18
    FMAX  D15, D17, D10
    FMIN  D8, D20, D5
    FMINNM  S5, S13, S20
    FMAX  H26, H12, H19
    FMAX  D0, D14, D3
    FMIN  D15, D21, D9
    FMIN  D31, D29, D3
    FMAX  H6, H6, H23
    FMINNM  D22, D13, D24
    FMINNM  D25, D24, D31
    FMAXNM  H16, H16, H13
    FMAXNM  S7, S17, S22
    FMAX  D8, D30, D25
    FMINNM  D7, D12, D0
    FMINNM  D3, D6, D7
    FMINNM  D11, D17, D8
    FMIN  S19, S28, S17
    FMIN  H30, H31, H15
    FMINNM  D11, D21, D14
    FMAXNM  S8, S4, S5
    FMIN  S26, S21, S3
    FMINNM  H25, H23, H16
    FMAX  D5, D30, D24
    FMIN  H8, H18, H9
    FMAX  D3, D27, D13
    FMAX  H25, H25, H14
    FMIN  H11, H29, H13
    FMAX  D14, D14, D25
    FMAXNM  H23, H3, H14
    FMAX  S9, S20, S8
    FMIN  D1, D12, D8
    FMINNM  H16, H20, H5
    FMIN  H4, H8, H11
    FMAXNM  D28, D22, D26
    FMAX  H25, H11, H12
    FMAX  H2, H30, H0
    FMINNM  H4, H28, H16
    FMAXNM  S23, S9, S24
    FMINNM  H9, H7, H2
    FMAX  S3, S23, S8
    FMAXNM  H27, H8, H7
    FMAXNM  S19, S11, S26
    FMAXNM  H16, H3, H26
    FMAXNM  D0, D31, D14
    FMAXNM  D21, D24, D0
    FMAXNM  S28, S1, S29
    FMAX  D3, D23, D26
    FMAXNM  D13, D26, D22
    FMINNM  D5, D10, D7
    FMAX  S14, S25, S16
    FMINNM  D29, D10, D3
    FMIN  H29, H9, H16
    FMAXNM  S3, S7, S19
    FMINNM  D11, D23, D1
    FMAXNM  D2, D16, D4
    FMAX  S17, S29, S23
    FMIN  D22, D4, D18
    FMAXNM  D18, D12, D13
    FMAX  D13, D24, D26
    FMAXNM  S8, S19, S3
    FMAXNM  S28, S9, S12
    FMAX  S3, S2, S17
    FMINNM  S5, S3, S13
    FMAX  D18, D10, D11
    FMINNM  S5, S21, S13
    FMAX  D25, D27, D18
    FMAXNM  S15, S25, S17
    FMAX  S15, S11, S14
    FMAXNM  D7, D18, D8
    FMAXNM  D18, D0, D26
    FMINNM  D7, D20, D8
    FMINNM  D29, D2, D8
    FMIN  H10, H26, H11
    FMAX  S29, S26, S20
    FMAXNM  H25, H1, H23
    FMAX  S26, S2, S29
    FMIN  S12, S5, S18
    FMINNM  S8, S11, S27
    FMAX  H12, H0, H27
    FMINNM  H30, H27, H1
    FMAXNM  D10, D14, D5
    FMIN  D29, D24, D27
    FMIN  S15, S12, S1
    FMINNM  S29, S20, S4
    FMAXNM  D20, D3, D23
    SUBS  X25, X25, #0x1
    B.NE  TaishanFpMovMaddP01_label_1282
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
TaishanFpMovMaddP01_label_49:
    SUB  X13, X15, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D9
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D10
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D15
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D19
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D25
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
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
TaishanFpMovMaddP01_label_804:
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
    FMOV  V0.D[1], X4
    FMOV  D1, X6
    FMOV  V1.D[1], X4
    FMOV  D2, X20
    FMOV  V2.D[1], X9
    FMOV  D3, X22
    FMOV  V3.D[1], X13
    FMOV  D4, X4
    FMOV  V4.D[1], X20
    FMOV  D5, X28
    FMOV  V5.D[1], X10
    FMOV  D6, X29
    FMOV  V6.D[1], X23
    FMOV  D7, X3
    FMOV  V7.D[1], X19
    FMOV  D8, X13
    FMOV  V8.D[1], X2
    FMOV  D9, X29
    FMOV  V9.D[1], X13
    FMOV  D10, X8
    FMOV  V10.D[1], X11
    FMOV  D11, X16
    FMOV  V11.D[1], X27
    FMOV  D12, X14
    FMOV  V12.D[1], X11
    FMOV  D13, X23
    FMOV  V13.D[1], X9
    FMOV  D14, X25
    FMOV  V14.D[1], X24
    FMOV  D15, X13
    FMOV  V15.D[1], X27
    FMOV  D16, X18
    FMOV  V16.D[1], X14
    FMOV  D17, X7
    FMOV  V17.D[1], X17
    FMOV  D18, X11
    FMOV  V18.D[1], X22
    FMOV  D19, X21
    FMOV  V19.D[1], X24
    FMOV  D20, X28
    FMOV  V20.D[1], X11
    FMOV  D21, X14
    FMOV  V21.D[1], X28
    FMOV  D22, X28
    FMOV  V22.D[1], X15
    FMOV  D23, X29
    FMOV  V23.D[1], X14
    FMOV  D24, X24
    FMOV  V24.D[1], X18
    FMOV  D25, X2
    FMOV  V25.D[1], X10
    FMOV  D26, X7
    FMOV  V26.D[1], X14
    FMOV  D27, X11
    FMOV  V27.D[1], X5
    FMOV  D28, X20
    FMOV  V28.D[1], X6
    FMOV  D29, X4
    FMOV  V29.D[1], X10
    FMOV  D30, X28
    FMOV  V30.D[1], X21
    FMOV  D31, X2
    FMOV  V31.D[1], X8
    MOVZ  X10, #0xf, LSL #0
TaishanFpMovMaddP01_label_1358:
    FMAX  H31, H28, H6
    FMINNM  S7, S14, S19
    FMAXNM  S26, S24, S19
    FMINNM  S28, S27, S21
    FMAX  H31, H9, H20
    FMAXNM  D26, D30, D17
    FMINNM  H22, H19, H26
    FMINNM  H24, H21, H14
    FMAX  D4, D21, D15
    FMINNM  S23, S20, S23
    FMIN  H16, H29, H31
    FMIN  H29, H31, H27
    FMAX  S12, S25, S8
    FMAX  D11, D12, D12
    FMINNM  D9, D23, D7
    FMINNM  H28, H29, H20
    FMAX  H2, H15, H11
    FMAX  S7, S9, S3
    FMIN  D6, D31, D10
    FMINNM  S24, S28, S26
    FMAXNM  H27, H2, H9
    FMIN  D17, D23, D9
    FMAXNM  H31, H19, H0
    FMINNM  H20, H25, H15
    FMAX  D14, D29, D15
    FMAXNM  D19, D6, D20
    FMIN  D0, D17, D6
    FMIN  S11, S31, S23
    FMINNM  H22, H26, H17
    FMIN  H8, H9, H18
    FMAXNM  S12, S28, S20
    FMAX  D8, D29, D14
    FMINNM  S6, S2, S31
    FMINNM  D31, D27, D19
    FMAX  D3, D9, D15
    FMAXNM  H18, H13, H14
    FMAXNM  H10, H17, H10
    FMAX  H3, H28, H27
    FMAXNM  S3, S8, S26
    FMINNM  D27, D10, D7
    FMAXNM  S22, S6, S1
    FMIN  H2, H23, H22
    FMIN  H7, H25, H30
    FMAX  D13, D20, D15
    FMINNM  H8, H16, H8
    FMINNM  D30, D1, D11
    FMINNM  S22, S3, S4
    FMIN  D10, D19, D15
    FMINNM  S19, S11, S15
    FMINNM  H1, H8, H9
    FMAXNM  S23, S9, S17
    FMINNM  S23, S5, S31
    FMAXNM  H6, H5, H8
    FMAXNM  S2, S27, S5
    FMIN  S17, S28, S7
    FMAX  D12, D29, D21
    FMAX  D6, D16, D10
    FMAX  D17, D2, D19
    FMIN  H10, H8, H22
    FMAX  D26, D16, D24
    FMAXNM  D27, D5, D24
    FMINNM  S18, S28, S8
    FMAXNM  D2, D1, D10
    FMAXNM  D20, D30, D18
    FMAX  H15, H7, H27
    FMAXNM  D22, D5, D16
    FMIN  D8, D24, D4
    FMIN  D28, D3, D27
    FMIN  D8, D21, D24
    FMAXNM  H0, H11, H22
    FMINNM  D22, D2, D15
    FMINNM  S28, S25, S30
    FMINNM  H19, H31, H20
    FMIN  S30, S16, S6
    FMAXNM  D4, D28, D0
    FMAX  H16, H31, H5
    FMIN  S17, S0, S24
    FMIN  D5, D4, D7
    FMINNM  H2, H17, H31
    FMAX  H1, H3, H10
    FMAX  S21, S18, S22
    FMAX  S4, S18, S15
    FMAXNM  D25, D8, D14
    FMAXNM  H13, H9, H11
    FMINNM  D13, D18, D15
    FMINNM  D21, D28, D17
    FMAXNM  D25, D13, D30
    FMIN  D10, D13, D4
    FMINNM  D21, D30, D5
    FMAX  H22, H11, H15
    FMIN  D5, D22, D5
    FMIN  H30, H11, H1
    FMINNM  H14, H24, H25
    FMIN  D10, D21, D16
    FMINNM  D17, D3, D23
    FMAX  D27, D31, D2
    FMIN  S28, S17, S23
    FMINNM  H6, H22, H26
    FMINNM  S28, S29, S6
    FMAXNM  S26, S28, S4
    FMAXNM  H22, H26, H30
    FMAX  S3, S23, S26
    FMAX  H24, H22, H14
    FMINNM  S5, S17, S9
    FMINNM  S30, S15, S4
    FMINNM  S27, S3, S14
    FMAXNM  D28, D24, D26
    FMAXNM  D5, D23, D30
    FMIN  H17, H10, H16
    FMINNM  S26, S9, S13
    FMIN  D27, D23, D23
    FMIN  H9, H21, H5
    FMAX  S19, S27, S24
    FMIN  S4, S28, S2
    FMAXNM  D17, D12, D27
    FMINNM  S25, S18, S11
    FMAX  S25, S22, S17
    FMAX  S9, S7, S4
    FMIN  H29, H31, H25
    FMAXNM  S22, S26, S24
    FMIN  D9, D2, D30
    FMIN  S18, S1, S14
    FMINNM  D29, D4, D4
    FMAX  H28, H30, H14
    FMINNM  D22, D15, D6
    FMIN  S8, S3, S18
    FMINNM  D30, D4, D2
    FMIN  S24, S2, S24
    FMAX  D1, D15, D24
    FMIN  S5, S20, S15
    FMAXNM  H19, H30, H21
    FMAX  S1, S25, S28
    FMAX  D20, D24, D9
    FMAXNM  S29, S12, S14
    FMAX  H12, H5, H21
    FMAX  S17, S6, S13
    FMINNM  S30, S21, S18
    FMINNM  D3, D19, D11
    FMINNM  H11, H4, H4
    FMAXNM  D0, D20, D1
    FMINNM  H20, H12, H23
    FMINNM  H24, H8, H3
    FMINNM  H26, H22, H29
TaishanFpMovMaddP01_label_1235:
    FMAXNM  D19, D8, D25
    FMAXNM  S17, S21, S13
    FMAX  D10, D12, D23
    FMIN  H22, H9, H10
    FMIN  S14, S21, S24
    FMAX  D23, D20, D18
    FMAXNM  S14, S27, S10
    FMINNM  D1, D9, D5
    FMAX  H18, H30, H17
    FMIN  D15, D22, D2
    FMAX  D15, D21, D30
    FMIN  H3, H21, H2
    FMINNM  S24, S4, S20
    FMIN  D17, D8, D5
    FMAX  D31, D14, D24
    FMIN  D15, D8, D28
    FMAXNM  H27, H7, H30
    FMINNM  H8, H19, H20
    FMAXNM  S3, S14, S9
    FMAX  D24, D27, D25
    FMINNM  S31, S13, S0
    FMIN  H28, H24, H24
    FMAX  D4, D27, D7
    FMAXNM  D22, D30, D0
    FMAXNM  D3, D7, D29
    FMINNM  S19, S3, S3
    FMAX  S23, S24, S4
    FMAXNM  H9, H17, H25
    FMAXNM  D16, D30, D7
    FMIN  S15, S22, S6
    FMAXNM  S10, S22, S27
    FMIN  D2, D0, D18
    FMAXNM  D27, D24, D27
    FMAX  S5, S2, S8
    FMINNM  H15, H3, H4
    FMIN  H19, H26, H9
    FMAX  H31, H15, H30
    FMAXNM  H29, H6, H14
    FMAX  H29, H31, H10
    FMIN  D27, D30, D31
    FMAXNM  S29, S25, S23
    FMAX  H29, H29, H30
    FMIN  H5, H26, H5
    FMAXNM  D6, D19, D19
    FMINNM  D7, D0, D2
    FMAXNM  H29, H15, H24
    FMINNM  D29, D22, D11
    FMAX  D9, D13, D25
    FMAX  D0, D9, D15
    FMAXNM  H28, H5, H16
    FMINNM  H0, H22, H17
    FMINNM  D3, D4, D11
    FMAX  H6, H24, H19
    FMIN  S29, S6, S3
    FMIN  D24, D10, D18
    FMAXNM  H7, H6, H26
    FMINNM  H28, H14, H10
    SUBS  X10, X10, #0x1
    B.NE  TaishanFpMovMaddP01_label_1358
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X27, X11, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X22, X24, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X18, X14, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X15, X13, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X19, X6, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X10, X9, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X22, X10, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X26, X9, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X10, X22, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X15, X18, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X25, X7, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X20, X13, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X7, X28, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X9, X8, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X23, X15, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X3, X8, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X17, X6, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D4
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D5
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X23, D6
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D7
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X13, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D13
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D15
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X20, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D19
TaishanFpMovMaddP01_label_824:
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X19, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D26
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D29
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0xe428, LSL #0
    MOVK  X2, #0xeae9, LSL #16
    MOVK  X2, #0x7b98, LSL #32
    MOVK  X2, #0x10dc, LSL #48
    MOVZ  X3, #0x6ec3, LSL #0
    MOVK  X3, #0x6a3d, LSL #16
    MOVK  X3, #0x66d, LSL #32
    MOVK  X3, #0xd681, LSL #48
    MOVZ  X4, #0x8e2, LSL #0
    MOVK  X4, #0xb4fc, LSL #16
    MOVK  X4, #0x358, LSL #32
    MOVK  X4, #0xbbf2, LSL #48
    MOVZ  X5, #0xae7e, LSL #0
    MOVK  X5, #0xbc79, LSL #16
    MOVK  X5, #0x92ae, LSL #32
    MOVK  X5, #0x78a9, LSL #48
    MOVZ  X6, #0x13e9, LSL #0
    MOVK  X6, #0x71d8, LSL #16
    MOVK  X6, #0x9edd, LSL #32
    MOVK  X6, #0x4777, LSL #48
    MOVZ  X7, #0xfbba, LSL #0
    MOVK  X7, #0x5131, LSL #16
    MOVK  X7, #0x22bc, LSL #32
    MOVK  X7, #0x5ce8, LSL #48
    MOVZ  X8, #0x1d01, LSL #0
    MOVK  X8, #0x2c77, LSL #16
    MOVK  X8, #0x78be, LSL #32
    MOVK  X8, #0x3430, LSL #48
    MOVZ  X9, #0xcd69, LSL #0
    MOVK  X9, #0x5c92, LSL #16
    MOVK  X9, #0x824d, LSL #32
    MOVK  X9, #0x9a29, LSL #48
    MOVZ  X10, #0xb6dc, LSL #0
    MOVK  X10, #0x9c3d, LSL #16
    MOVK  X10, #0x3cfa, LSL #32
    MOVK  X10, #0xe41e, LSL #48
    MOVZ  X11, #0x101a, LSL #0
    MOVK  X11, #0x1e1d, LSL #16
    MOVK  X11, #0xa06b, LSL #32
    MOVK  X11, #0x4391, LSL #48
    MOVZ  X13, #0x6667, LSL #0
    MOVK  X13, #0x8eee, LSL #16
    MOVK  X13, #0xc629, LSL #32
    MOVK  X13, #0x4eb, LSL #48
    MOVZ  X14, #0x2be, LSL #0
    MOVK  X14, #0x373d, LSL #16
    MOVK  X14, #0x69b8, LSL #32
    MOVK  X14, #0x208d, LSL #48
    MOVZ  X15, #0x4187, LSL #0
    MOVK  X15, #0x10f4, LSL #16
    MOVK  X15, #0xade0, LSL #32
    MOVK  X15, #0x17d7, LSL #48
    MOVZ  X16, #0x6dd8, LSL #0
    MOVK  X16, #0x817, LSL #16
    MOVK  X16, #0x131f, LSL #32
    MOVK  X16, #0xfb8a, LSL #48
    MOVZ  X17, #0x98db, LSL #0
    MOVK  X17, #0xa005, LSL #16
    MOVK  X17, #0xac80, LSL #32
    MOVK  X17, #0x3e2, LSL #48
    MOVZ  X18, #0x68e7, LSL #0
    MOVK  X18, #0x4461, LSL #16
    MOVK  X18, #0xe0a9, LSL #32
    MOVK  X18, #0xd1d8, LSL #48
    MOVZ  X19, #0x2728, LSL #0
    MOVK  X19, #0x27c3, LSL #16
    MOVK  X19, #0x2808, LSL #32
    MOVK  X19, #0xd92, LSL #48
    MOVZ  X20, #0x8a2c, LSL #0
    MOVK  X20, #0xcbb9, LSL #16
    MOVK  X20, #0x4f0e, LSL #32
    MOVK  X20, #0x2da8, LSL #48
    MOVZ  X21, #0xf2ff, LSL #0
    MOVK  X21, #0x6cf6, LSL #16
    MOVK  X21, #0xf0, LSL #32
    MOVK  X21, #0xf448, LSL #48
    MOVZ  X22, #0xd87b, LSL #0
    MOVK  X22, #0x15f5, LSL #16
    MOVK  X22, #0x225c, LSL #32
    MOVK  X22, #0x132d, LSL #48
    MOVZ  X23, #0xdd38, LSL #0
    MOVK  X23, #0x1a57, LSL #16
    MOVK  X23, #0x9786, LSL #32
    MOVK  X23, #0x87f0, LSL #48
    MOVZ  X24, #0x3846, LSL #0
    MOVK  X24, #0xed3c, LSL #16
    MOVK  X24, #0xfa63, LSL #32
    MOVK  X24, #0x899, LSL #48
    MOVZ  X25, #0x3c59, LSL #0
    MOVK  X25, #0x2ae1, LSL #16
    MOVK  X25, #0xe8e6, LSL #32
    MOVK  X25, #0x8373, LSL #48
    MOVZ  X26, #0x4e4d, LSL #0
    MOVK  X26, #0xb9ea, LSL #16
    MOVK  X26, #0x18de, LSL #32
    MOVK  X26, #0xefe7, LSL #48
    MOVZ  X27, #0x9993, LSL #0
    MOVK  X27, #0xe82e, LSL #16
    MOVK  X27, #0xe2ba, LSL #32
    MOVK  X27, #0xd278, LSL #48
    MOVZ  X28, #0xfb85, LSL #0
    MOVK  X28, #0x6ff8, LSL #16
    MOVK  X28, #0x5f41, LSL #32
    MOVK  X28, #0x7a59, LSL #48
    MOVZ  X29, #0x3c64, LSL #0
    MOVK  X29, #0xa66b, LSL #16
    MOVK  X29, #0x59fd, LSL #32
    MOVK  X29, #0xedaa, LSL #48
    FMOV  D0, X10
    FMOV  V0.D[1], X7
    FMOV  D1, X11
    FMOV  V1.D[1], X11
    FMOV  D2, X23
    FMOV  V2.D[1], X29
    FMOV  D3, X8
    FMOV  V3.D[1], X11
    FMOV  D4, X2
    FMOV  V4.D[1], X28
    FMOV  D5, X29
    FMOV  V5.D[1], X9
    FMOV  D6, X25
    FMOV  V6.D[1], X7
    FMOV  D7, X26
    FMOV  V7.D[1], X3
    FMOV  D8, X15
    FMOV  V8.D[1], X3
    FMOV  D9, X15
    FMOV  V9.D[1], X24
    FMOV  D10, X9
    FMOV  V10.D[1], X16
    FMOV  D11, X21
    FMOV  V11.D[1], X26
    FMOV  D12, X17
    FMOV  V12.D[1], X28
    FMOV  D13, X21
    FMOV  V13.D[1], X19
    FMOV  D14, X16
    FMOV  V14.D[1], X27
    FMOV  D15, X21
    FMOV  V15.D[1], X24
    FMOV  D16, X6
    FMOV  V16.D[1], X14
    FMOV  D17, X18
    FMOV  V17.D[1], X20
    FMOV  D18, X11
    FMOV  V18.D[1], X13
    FMOV  D19, X26
    FMOV  V19.D[1], X27
    FMOV  D20, X22
    FMOV  V20.D[1], X13
    FMOV  D21, X2
    FMOV  V21.D[1], X4
    FMOV  D22, X20
    FMOV  V22.D[1], X22
    FMOV  D23, X22
    FMOV  V23.D[1], X17
    FMOV  D24, X4
    FMOV  V24.D[1], X4
    FMOV  D25, X6
    FMOV  V25.D[1], X13
    FMOV  D26, X10
    FMOV  V26.D[1], X27
    FMOV  D27, X7
    FMOV  V27.D[1], X19
    FMOV  D28, X15
    FMOV  V28.D[1], X2
    FMOV  D29, X20
    FMOV  V29.D[1], X19
    FMOV  D30, X6
    FMOV  V30.D[1], X13
    FMOV  D31, X21
    FMOV  V31.D[1], X7
    MOVZ  X21, #0xa, LSL #0
TaishanFpMovMaddP01_label_1439:
    FMIN  S7, S21, S18
    FMAX  H11, H22, H5
    FMIN  S27, S6, S4
    FMIN  S3, S30, S5
    FMINNM  S1, S20, S7
    FMAXNM  H3, H21, H6
    FMAXNM  H1, H7, H9
    FMAXNM  H8, H26, H1
    FMAX  H28, H29, H4
    FMAXNM  D24, D20, D31
    FMINNM  S6, S23, S4
    FMIN  S23, S0, S8
    FMAX  D8, D11, D26
    FMAX  D1, D3, D17
    FMINNM  S24, S9, S29
    FMINNM  D10, D28, D2
    FMAX  D12, D27, D25
    FMAXNM  S21, S21, S17
    FMIN  S17, S10, S4
    FMIN  S22, S5, S19
    FMIN  H28, H20, H17
    FMAX  S2, S2, S29
    FMINNM  D31, D19, D23
    FMIN  H17, H30, H11
    FMAX  D24, D5, D23
    FMAXNM  S19, S2, S11
    FMINNM  S13, S14, S15
    FMAXNM  H8, H18, H29
    FMAXNM  S19, S23, S8
    FMINNM  S0, S8, S10
    FMINNM  D18, D28, D17
    FMAXNM  S22, S21, S15
    FMAX  H12, H6, H7
    FMINNM  S24, S24, S24
    FMAX  D0, D31, D22
    FMAXNM  H11, H12, H13
    FMIN  S11, S19, S21
    FMIN  S11, S17, S26
    FMINNM  H18, H18, H8
    FMAXNM  H8, H24, H27
    FMAXNM  S26, S24, S6
    FMIN  H15, H31, H21
    FMIN  D30, D15, D31
    FMINNM  S30, S24, S14
    FMAX  D29, D8, D10
    FMINNM  H31, H8, H29
    FMAX  H27, H0, H15
    FMINNM  S15, S2, S21
    FMAXNM  D6, D11, D19
    FMAX  H12, H7, H2
    FMINNM  D2, D14, D7
    FMAX  H20, H23, H22
    FMAX  D30, D12, D10
    FMIN  H18, H26, H23
    FMAX  S29, S6, S10
    FMAX  H7, H2, H4
    FMINNM  H22, H13, H17
    FMAX  H31, H9, H5
    FMAX  H24, H10, H2
    FMAXNM  H11, H1, H16
    FMAX  D3, D23, D12
    FMIN  H1, H7, H23
    FMINNM  S0, S29, S10
    FMIN  D20, D28, D8
    FMINNM  D11, D2, D6
    FMAX  S10, S19, S20
    FMINNM  H22, H29, H24
    FMAXNM  D26, D16, D25
    FMAX  H29, H27, H10
    FMINNM  H1, H24, H11
    FMIN  D29, D15, D26
    FMAXNM  H6, H26, H22
    FMAXNM  D14, D5, D15
    FMAX  D16, D26, D12
    FMINNM  S1, S19, S6
    FMAXNM  S4, S24, S10
    FMAX  H8, H31, H20
    FMINNM  H20, H25, H0
    FMAXNM  S23, S6, S1
    FMAX  D29, D28, D1
    FMAXNM  D27, D3, D23
    FMIN  H9, H0, H6
    FMAX  D27, D23, D11
    FMINNM  H10, H18, H22
    FMINNM  D13, D30, D3
    FMAX  D26, D2, D22
    FMINNM  D8, D5, D24
    FMAX  D9, D7, D19
    FMINNM  H14, H20, H4
    FMINNM  D25, D14, D12
    FMIN  D7, D28, D1
    FMAXNM  D4, D21, D29
    FMINNM  H27, H25, H16
    FMINNM  H7, H10, H24
    FMINNM  D12, D11, D8
    FMINNM  D20, D5, D31
    FMINNM  D28, D15, D20
    FMIN  H1, H4, H4
    FMINNM  S11, S19, S1
    FMINNM  S12, S6, S19
    FMAXNM  H19, H23, H18
    FMINNM  D18, D9, D0
    FMAX  S9, S0, S9
    FMAX  S16, S10, S27
    FMIN  S22, S24, S26
    FMIN  H1, H22, H28
    FMAXNM  S16, S25, S1
    FMAXNM  S31, S14, S18
    FMIN  D1, D5, D6
    FMIN  S3, S7, S27
    FMIN  D4, D19, D15
    FMAXNM  D4, D0, D6
    FMAXNM  S28, S9, S5
    FMIN  S20, S4, S27
    FMINNM  H21, H7, H10
    FMAXNM  D11, D4, D20
    FMAXNM  D29, D11, D19
TaishanFpMovMaddP01_label_1336:
    FMIN  S27, S5, S16
    FMIN  H7, H31, H8
    FMIN  D7, D31, D24
    FMINNM  S2, S14, S1
    FMAX  H27, H25, H3
    FMAXNM  H8, H2, H1
    FMIN  S18, S11, S12
    FMAX  D18, D4, D8
    FMAX  D17, D30, D18
    FMINNM  S28, S30, S7
    FMIN  H23, H18, H10
    FMAXNM  S8, S27, S26
    FMAX  S28, S19, S29
    FMINNM  H3, H19, H2
    FMAXNM  H5, H25, H3
    FMIN  D28, D16, D24
    FMINNM  H17, H24, H13
    FMIN  D13, D30, D6
    FMAXNM  D15, D9, D9
    FMIN  S31, S2, S1
    FMAX  S19, S7, S14
    FMAXNM  D14, D1, D24
    FMAX  S4, S23, S20
    FMIN  D29, D23, D4
    FMIN  H24, H0, H23
    FMAXNM  S0, S30, S1
    FMIN  H20, H8, H8
    FMAX  D22, D10, D4
    FMAXNM  H21, H8, H18
    FMINNM  S30, S11, S20
    FMINNM  S5, S30, S12
    FMINNM  D5, D1, D23
    FMIN  H12, H23, H18
    FMAX  S2, S19, S26
    FMIN  D6, D29, D20
    FMAXNM  H7, H20, H16
    FMIN  S17, S4, S4
    FMAXNM  D16, D15, D21
    FMIN  H28, H1, H23
    FMIN  H24, H30, H12
    FMINNM  D26, D24, D5
    FMINNM  D16, D20, D31
    FMAX  S26, S20, S12
    FMAX  S21, S21, S7
    FMAXNM  H0, H11, H0
    FMAX  S18, S27, S19
    FMINNM  D27, D29, D18
    FMINNM  S2, S29, S24
    FMINNM  H22, H31, H14
    FMINNM  D18, D2, D30
    FMAX  D27, D19, D31
    FMIN  D18, D5, D28
    FMIN  H24, H0, H12
    FMINNM  H31, H12, H30
    FMINNM  S2, S20, S1
    FMIN  H11, H21, H10
    FMIN  S7, S23, S6
    FMAX  D14, D1, D0
    FMAX  D7, D19, D6
    FMIN  H23, H9, H4
    FMIN  D23, D28, D27
    FMAX  H29, H12, H1
    FMAXNM  D17, D16, D5
    FMAXNM  D14, D25, D17
    FMINNM  D25, D5, D11
    FMAXNM  H24, H14, H31
    FMINNM  S30, S15, S20
    FMAXNM  S18, S11, S21
    FMIN  H16, H12, H6
    FMAX  S6, S3, S21
    FMIN  S12, S21, S25
    FMAXNM  S25, S10, S3
    FMINNM  H2, H24, H15
    FMAX  H29, H29, H7
    FMINNM  D30, D14, D27
    FMINNM  D2, D23, D6
    FMAX  H10, H14, H30
    FMINNM  H12, H16, H6
    FMAX  S12, S19, S1
    FMAXNM  S18, S26, S19
    FMIN  S18, S12, S4
    FMINNM  D28, D8, D27
    FMAXNM  H29, H25, H9
    SUBS  X21, X21, #0x1
    B.NE  TaishanFpMovMaddP01_label_1439
    MOVZ  X21, #0xe428, LSL #0
    MOVK  X21, #0xeae9, LSL #16
    MOVK  X21, #0x7b98, LSL #32
    MOVK  X21, #0x10dc, LSL #48
    SUB  X8, X21, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x6ec3, LSL #0
    MOVK  X22, #0x6a3d, LSL #16
    MOVK  X22, #0x66d, LSL #32
    MOVK  X22, #0xd681, LSL #48
    SUB  X14, X22, X3
TaishanFpMovMaddP01_label_1183:
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0x8e2, LSL #0
    MOVK  X7, #0xb4fc, LSL #16
    MOVK  X7, #0x358, LSL #32
    MOVK  X7, #0xbbf2, LSL #48
    SUB  X16, X7, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0xae7e, LSL #0
    MOVK  X24, #0xbc79, LSL #16
    MOVK  X24, #0x92ae, LSL #32
    MOVK  X24, #0x78a9, LSL #48
    SUB  X5, X24, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x13e9, LSL #0
    MOVK  X14, #0x71d8, LSL #16
    MOVK  X14, #0x9edd, LSL #32
    MOVK  X14, #0x4777, LSL #48
    SUB  X5, X14, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0x8e2, LSL #0
    MOVK  X10, #0xb4fc, LSL #16
    MOVK  X10, #0x358, LSL #32
    MOVK  X10, #0xbbf2, LSL #48
    SUB  X18, X10, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0xcd69, LSL #0
    MOVK  X28, #0x5c92, LSL #16
    MOVK  X28, #0x824d, LSL #32
    MOVK  X28, #0x9a29, LSL #48
    SUB  X5, X28, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x8e2, LSL #0
TaishanFpMovMaddP01_label_918:
    MOVK  X18, #0xb4fc, LSL #16
    MOVK  X18, #0x358, LSL #32
    MOVK  X18, #0xbbf2, LSL #48
    SUB  X9, X18, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x101a, LSL #0
    MOVK  X28, #0x1e1d, LSL #16
    MOVK  X28, #0xa06b, LSL #32
    MOVK  X28, #0x4391, LSL #48
    SUB  X24, X28, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x6667, LSL #0
    MOVK  X22, #0x8eee, LSL #16
    MOVK  X22, #0xc629, LSL #32
    MOVK  X22, #0x4eb, LSL #48
    SUB  X25, X22, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x13e9, LSL #0
    MOVK  X16, #0x71d8, LSL #16
    MOVK  X16, #0x9edd, LSL #32
    MOVK  X16, #0x4777, LSL #48
    SUB  X6, X16, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x4187, LSL #0
    MOVK  X15, #0x10f4, LSL #16
    MOVK  X15, #0xade0, LSL #32
    MOVK  X15, #0x17d7, LSL #48
    SUB  X9, X15, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0x13e9, LSL #0
    MOVK  X7, #0x71d8, LSL #16
    MOVK  X7, #0x9edd, LSL #32
    MOVK  X7, #0x4777, LSL #48
    SUB  X21, X7, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0x98db, LSL #0
    MOVK  X23, #0xa005, LSL #16
    MOVK  X23, #0xac80, LSL #32
    MOVK  X23, #0x3e2, LSL #48
    SUB  X10, X23, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X3, #0x8e2, LSL #0
    MOVK  X3, #0xb4fc, LSL #16
    MOVK  X3, #0x358, LSL #32
    MOVK  X3, #0xbbf2, LSL #48
    SUB  X10, X3, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x2728, LSL #0
    MOVK  X19, #0x27c3, LSL #16
    MOVK  X19, #0x2808, LSL #32
    MOVK  X19, #0xd92, LSL #48
    SUB  X6, X19, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x8a2c, LSL #0
    MOVK  X13, #0xcbb9, LSL #16
    MOVK  X13, #0x4f0e, LSL #32
    MOVK  X13, #0x2da8, LSL #48
    SUB  X24, X13, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x6667, LSL #0
    MOVK  X15, #0x8eee, LSL #16
    MOVK  X15, #0xc629, LSL #32
    MOVK  X15, #0x4eb, LSL #48
    SUB  X29, X15, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X9, #0x98db, LSL #0
    MOVK  X9, #0xa005, LSL #16
    MOVK  X9, #0xac80, LSL #32
    MOVK  X9, #0x3e2, LSL #48
    SUB  X17, X9, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D2
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X22, D5
    MOVZ  X2, #0x3c64, LSL #0
    MOVK  X2, #0xa66b, LSL #16
    MOVK  X2, #0x59fd, LSL #32
    MOVK  X2, #0xedaa, LSL #48
    SUB  X13, X2, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X25, V7.D[1]
TaishanFpMovMaddP01_label_1142:
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X25, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D11
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X22, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X16, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMovMaddP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X15, D26
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X18
    FMOV  V0.D[1], X14
    FMOV  D1, X18
    FMOV  V1.D[1], X2
    FMOV  D2, X8
    FMOV  V2.D[1], X3
    FMOV  D3, X20
    FMOV  V3.D[1], X14
    FMOV  D4, X23
    FMOV  V4.D[1], X29
    FMOV  D5, X29
    FMOV  V5.D[1], X6
    FMOV  D6, X29
    FMOV  V6.D[1], X19
    FMOV  D7, X26
    FMOV  V7.D[1], X23
    FMOV  D8, X28
    FMOV  V8.D[1], X20
    FMOV  D9, X11
    FMOV  V9.D[1], X27
    FMOV  D10, X21
    FMOV  V10.D[1], X16
    FMOV  D11, X20
    FMOV  V11.D[1], X3
    FMOV  D12, X16
    FMOV  V12.D[1], X5
    FMOV  D13, X14
    FMOV  V13.D[1], X20
    FMOV  D14, X27
    FMOV  V14.D[1], X14
    FMOV  D15, X11
    FMOV  V15.D[1], X11
    FMOV  D16, X29
    FMOV  V16.D[1], X3
    FMOV  D17, X19
    FMOV  V17.D[1], X22
    FMOV  D18, X19
    FMOV  V18.D[1], X20
    FMOV  D19, X21
    FMOV  V19.D[1], X4
    FMOV  D20, X6
    FMOV  V20.D[1], X3
    FMOV  D21, X28
    FMOV  V21.D[1], X14
    FMOV  D22, X6
    FMOV  V22.D[1], X24
    FMOV  D23, X26
    FMOV  V23.D[1], X8
    FMOV  D24, X21
    FMOV  V24.D[1], X27
    FMOV  D25, X27
    FMOV  V25.D[1], X9
    FMOV  D26, X23
    FMOV  V26.D[1], X2
    FMOV  D27, X16
    FMOV  V27.D[1], X18
    FMOV  D28, X3
    FMOV  V28.D[1], X24
    FMOV  D29, X22
    FMOV  V29.D[1], X10
    FMOV  D30, X24
    FMOV  V30.D[1], X28
    FMOV  D31, X4
    FMOV  V31.D[1], X13
    MOVZ  X17, #0xa, LSL #0
TaishanFpMovMaddP01_label_1514:
    FMIN  D25, D23, D16
    FMIN  S8, S28, S26
    FMAX  S18, S24, S9
    FMINNM  D31, D9, D31
    FMAXNM  S3, S21, S24
    FMINNM  H9, H15, H29
    FMAXNM  S12, S17, S29
    FMAX  S30, S2, S24
    FMAX  S10, S8, S12
    FMIN  D14, D21, D4
    FMAX  D2, D4, D28
    FMINNM  H31, H18, H2
    FMAXNM  H10, H1, H30
    FMAXNM  S16, S30, S9
    FMAXNM  S30, S20, S19
    FMINNM  H3, H5, H3
    FMAXNM  S29, S31, S8
    FMAXNM  H17, H27, H12
    FMAX  D18, D22, D8
    FMAX  H5, H16, H30
    FMAX  D31, D5, D3
    FMIN  H27, H31, H6
    FMAXNM  D9, D25, D19
    FMAXNM  S14, S25, S5
    FMAXNM  H2, H14, H29
    FMAX  S16, S15, S24
    FMAX  H27, H4, H19
    FMAXNM  S31, S14, S3
    FMIN  H7, H2, H24
    FMIN  D28, D6, D29
    FMIN  D24, D28, D20
    FMIN  H24, H17, H25
    FMIN  D26, D16, D16
    FMINNM  H15, H5, H26
    FMAX  H30, H2, H29
    FMINNM  D3, D1, D19
    FMAX  S26, S16, S5
    FMINNM  D13, D2, D27
    FMAX  D10, D7, D25
    FMAXNM  S18, S22, S13
    FMAXNM  S30, S16, S23
    FMINNM  D2, D31, D13
    FMAXNM  H28, H5, H30
    FMINNM  H24, H17, H15
    FMAX  D6, D2, D4
    FMAX  D24, D2, D16
    FMAX  S31, S17, S6
    FMIN  S31, S1, S28
    FMAXNM  H19, H31, H28
    FMINNM  H24, H15, H13
    FMINNM  S2, S15, S28
    FMAX  S4, S14, S28
    FMINNM  S0, S13, S3
    FMAX  D18, D18, D5
    FMAXNM  H17, H3, H31
    FMIN  D17, D23, D13
    FMAXNM  H0, H20, H14
    FMINNM  S4, S0, S4
    FMINNM  H18, H30, H13
    FMAX  H20, H24, H21
    FMAXNM  H21, H17, H1
    FMIN  H14, H31, H4
    FMAX  H5, H27, H2
    FMINNM  D27, D27, D19
    FMIN  D18, D28, D25
    FMINNM  D23, D26, D14
    FMAX  D24, D18, D24
    FMINNM  S20, S3, S2
    FMAX  H14, H0, H1
    FMAX  D6, D21, D20
    FMAXNM  H4, H14, H20
    FMAX  S19, S7, S17
    FMINNM  S13, S2, S13
    FMAX  S14, S20, S28
    FMAX  S5, S4, S23
    FMINNM  S5, S13, S14
    FMAX  S28, S17, S22
    FMIN  H10, H31, H10
    FMIN  D1, D7, D9
    FMAX  D17, D29, D24
    FMAXNM  S30, S29, S18
    FMAXNM  D24, D15, D8
    FMAX  D27, D31, D26
    FMAXNM  S28, S30, S7
    FMAX  H21, H10, H4
    FMAX  H0, H4, H3
    FMAX  S3, S23, S1
    FMIN  H17, H20, H24
    FMIN  D6, D9, D21
    FMAX  H1, H20, H30
    FMAX  H10, H1, H21
    FMAXNM  D28, D28, D28
    FMAX  H31, H25, H20
    FMAXNM  S2, S14, S12
    FMAX  H31, H18, H3
    FMAXNM  S8, S21, S1
    FMAX  S20, S27, S14
    FMIN  H21, H30, H3
    FMIN  H19, H25, H13
    FMINNM  D21, D5, D21
    FMAX  H18, H17, H29
    FMAX  H25, H11, H10
    FMAXNM  D9, D17, D31
    FMIN  S27, S10, S1
    FMAXNM  D5, D4, D5
    FMAXNM  H6, H16, H23
    FMIN  S3, S18, S17
    FMAXNM  H17, H13, H30
    FMAX  S17, S26, S4
    FMIN  H1, H2, H0
    FMIN  H13, H14, H30
    FMIN  D15, D31, D31
    FMAX  S15, S12, S29
    FMAX  S25, S28, S1
    FMIN  D15, D24, D13
    FMAX  D9, D6, D19
    FMAX  S8, S2, S24
    FMIN  D27, D21, D31
    FMIN  H3, H16, H18
    FMINNM  S14, S12, S25
    FMINNM  D21, D14, D13
    FMINNM  H11, H11, H28
    FMINNM  H7, H1, H28
    FMIN  H0, H17, H10
    FMAX  H20, H15, H28
    FMINNM  H14, H5, H22
    FMIN  H22, H25, H4
    FMINNM  S22, S0, S29
    FMAX  H17, H3, H29
    FMINNM  S19, S8, S22
    FMAXNM  H1, H29, H1
    FMINNM  H15, H31, H0
    FMINNM  H2, H5, H25
    FMAX  H14, H4, H7
    FMINNM  D9, D11, D30
    FMAXNM  S2, S21, S0
    FMAXNM  D13, D27, D26
    FMAX  D30, D11, D6
    FMAX  S24, S20, S6
    FMIN  D28, D9, D2
    FMAXNM  S11, S15, S31
    FMIN  S14, S6, S16
    FMAX  D6, D9, D6
    FMINNM  S10, S17, S18
    FMIN  S10, S19, S20
    FMAX  H24, H3, H17
    FMAX  H26, H21, H24
    FMAX  H4, H30, H6
    FMINNM  D26, D19, D24
    FMAXNM  S23, S4, S1
    FMINNM  H13, H10, H30
    FMINNM  H30, H26, H11
    FMINNM  H24, H17, H28
    FMAX  S26, S12, S24
    FMAX  H10, H23, H8
    FMINNM  D14, D5, D29
    FMINNM  S26, S15, S21
    FMINNM  S13, S5, S25
    FMAXNM  S6, S14, S9
    FMINNM  S3, S23, S24
    FMAXNM  S22, S20, S24
    FMAXNM  D5, D9, D8
    FMAXNM  S30, S1, S24
    FMAX  H30, H16, H24
    FMAX  H8, H6, H23
    FMAXNM  D10, D29, D29
    FMAX  S20, S7, S10
    FMIN  S5, S1, S10
    FMIN  H18, H18, H13
    FMAXNM  S25, S14, S31
    FMAXNM  S23, S30, S27
    FMAXNM  S10, S3, S4
    FMAXNM  S17, S1, S9
    FMAXNM  D1, D20, D9
    FMINNM  H15, H25, H20
    FMIN  S1, S13, S5
    FMAXNM  D25, D10, D17
    FMINNM  H21, H14, H3
    FMIN  S29, S20, S2
    FMAX  S15, S14, S6
    FMIN  S2, S29, S29
    FMIN  D10, D28, D7
    FMIN  H10, H13, H25
    FMIN  S21, S20, S3
    FMAX  H9, H5, H20
    FMIN  H25, H4, H4
    FMAX  S27, S15, S1
    FMIN  D21, D27, D27
    FMIN  D2, D3, D24
    FMAX  S17, S30, S3
    FMIN  H27, H6, H16
    FMAX  H10, H17, H21
    FMIN  H29, H13, H20
    FMINNM  H6, H29, H29
    FMIN  D1, D25, D2
    FMINNM  S12, S10, S27
    FMIN  D6, D21, D9
    FMIN  H28, H24, H30
    FMAX  S28, S18, S1
    FMIN  H10, H28, H12
    SUBS  X17, X17, #0x1
    B.NE  TaishanFpMovMaddP01_label_1514
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X14, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X17, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X22, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
TaishanFpMovMaddP01_label_144:
    SUB  X20, X19, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D17
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X10, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X7, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X5, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
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
    FMOV  D0, X9
    FMOV  V0.D[1], X23
    FMOV  D1, X9
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X14
    FMOV  D3, X14
    FMOV  V3.D[1], X10
    FMOV  D4, X2
    FMOV  V4.D[1], X7
TaishanFpMovMaddP01_label_1246:
    FMOV  D5, X7
    FMOV  V5.D[1], X15
    FMOV  D6, X20
    FMOV  V6.D[1], X29
    FMOV  D7, X28
    FMOV  V7.D[1], X9
TaishanFpMovMaddP01_label_576:
    FMOV  D8, X20
    FMOV  V8.D[1], X11
    FMOV  D9, X11
    FMOV  V9.D[1], X15
    FMOV  D10, X21
    FMOV  V10.D[1], X27
    FMOV  D11, X17
    FMOV  V11.D[1], X13
    FMOV  D12, X20
    FMOV  V12.D[1], X23
    FMOV  D13, X6
    FMOV  V13.D[1], X14
    FMOV  D14, X24
    FMOV  V14.D[1], X25
    FMOV  D15, X22
    FMOV  V15.D[1], X9
    FMOV  D16, X10
    FMOV  V16.D[1], X7
    FMOV  D17, X17
    FMOV  V17.D[1], X24
    FMOV  D18, X24
    FMOV  V18.D[1], X10
    FMOV  D19, X20
    FMOV  V19.D[1], X8
    FMOV  D20, X8
    FMOV  V20.D[1], X16
    FMOV  D21, X6
    FMOV  V21.D[1], X23
    FMOV  D22, X10
    FMOV  V22.D[1], X24
    FMOV  D23, X25
    FMOV  V23.D[1], X10
    FMOV  D24, X5
    FMOV  V24.D[1], X15
    FMOV  D25, X26
    FMOV  V25.D[1], X24
    FMOV  D26, X26
    FMOV  V26.D[1], X4
    FMOV  D27, X11
    FMOV  V27.D[1], X7
    FMOV  D28, X4
    FMOV  V28.D[1], X8
    FMOV  D29, X16
    FMOV  V29.D[1], X11
    FMOV  D30, X17
    FMOV  V30.D[1], X18
    FMOV  D31, X5
    FMOV  V31.D[1], X9
    MOVZ  X8, #0xf, LSL #0
TaishanFpMovMaddP01_label_1591:
    FMAXNM  D18, D23, D12
    FMAX  H9, H10, H26
    FMAX  D31, D3, D29
    FMAX  S11, S30, S31
    FMINNM  D0, D6, D22
    FMAX  S7, S29, S25
    FMINNM  S29, S27, S0
    FMIN  S0, S22, S5
    FMAXNM  S3, S0, S30
    FMIN  D30, D20, D10
    FMINNM  S27, S27, S6
    FMAX  S11, S18, S28
    FMAXNM  S25, S5, S9
    FMAX  H30, H25, H19
    FMINNM  S7, S7, S2
    FMINNM  D11, D2, D13
    FMIN  D24, D22, D11
    FMINNM  D2, D3, D27
    FMAX  S1, S10, S17
    FMAXNM  D29, D25, D24
    FMIN  H8, H7, H27
    FMAXNM  S27, S22, S24
    FMINNM  H6, H10, H30
    FMAXNM  S14, S1, S31
    FMAX  S22, S13, S14
    FMAX  H16, H19, H18
    FMIN  S16, S14, S0
    FMAX  H27, H16, H30
    FMAX  D9, D0, D7
    FMINNM  S10, S20, S3
    FMAX  S31, S3, S7
    FMAXNM  D18, D24, D17
    FMAX  H5, H5, H3
    FMAX  S4, S29, S29
    FMAX  H8, H14, H26
    FMAX  S23, S24, S5
    FMAX  D6, D11, D30
    FMAX  D10, D22, D26
    FMAX  H4, H2, H31
    FMIN  H28, H9, H0
    FMAX  D15, D22, D16
    FMINNM  D13, D0, D21
    FMIN  H13, H18, H14
    FMAXNM  H27, H15, H25
    FMINNM  S18, S22, S10
    FMINNM  D7, D5, D15
    FMINNM  S10, S17, S19
    FMAXNM  S22, S7, S14
    FMIN  S25, S27, S12
    FMIN  H16, H26, H29
    FMINNM  S19, S24, S19
    FMIN  H2, H5, H21
    FMAXNM  D19, D19, D28
    FMINNM  S25, S0, S14
    FMIN  H18, H14, H16
    FMINNM  D25, D2, D25
    FMAX  D9, D12, D24
    FMINNM  H19, H20, H30
    FMAXNM  H26, H4, H18
    FMINNM  S29, S15, S11
    FMAX  H20, H16, H12
    FMAXNM  D8, D10, D18
    FMIN  S24, S10, S11
    FMINNM  D7, D22, D14
    FMAXNM  D27, D0, D5
    FMAXNM  S5, S10, S27
    FMAXNM  D3, D11, D10
    FMINNM  S17, S5, S2
    FMINNM  H27, H6, H13
    FMAX  D27, D3, D13
    FMAX  H18, H15, H21
    FMIN  S27, S25, S14
    FMAXNM  D27, D28, D6
    FMINNM  S11, S21, S2
    FMAXNM  H27, H19, H21
    FMAXNM  H29, H9, H2
    FMIN  S19, S19, S27
    FMAXNM  H25, H14, H20
    FMAX  H15, H26, H29
    FMAX  H21, H17, H21
    FMAXNM  H11, H3, H5
    FMAX  H7, H17, H18
    FMIN  H19, H24, H20
    FMAXNM  D21, D21, D1
    FMIN  S7, S5, S1
    FMAX  H17, H6, H23
    FMAXNM  D5, D22, D15
    FMIN  D20, D21, D8
    FMAXNM  S7, S20, S6
    FMIN  H24, H10, H7
    FMINNM  H25, H28, H25
    FMIN  S25, S12, S11
    FMIN  H18, H14, H14
    FMIN  H11, H20, H9
    FMINNM  S3, S2, S28
    FMINNM  D22, D26, D14
    FMAXNM  H28, H11, H6
    FMAX  H19, H7, H6
    FMAXNM  H3, H16, H8
    FMIN  H8, H23, H1
    FMIN  H2, H7, H23
    FMAXNM  H19, H13, H15
    FMAX  S21, S23, S0
    FMAX  S19, S29, S14
    FMINNM  D3, D2, D27
    FMIN  H13, H15, H0
    FMIN  D9, D17, D3
    FMAXNM  S19, S11, S31
    FMIN  H27, H12, H18
    FMIN  D18, D30, D6
    FMINNM  H30, H15, H20
    FMIN  H5, H28, H17
    FMIN  H21, H4, H26
    FMINNM  H25, H6, H23
    FMINNM  S31, S20, S27
    FMAX  S1, S13, S22
    FMAX  S15, S10, S9
    FMINNM  S31, S14, S18
    FMAX  H4, H31, H2
    FMIN  S13, S16, S24
    FMAXNM  D31, D24, D15
    FMINNM  H0, H0, H8
    FMAX  H28, H21, H12
    FMAX  D18, D12, D18
    FMAX  S14, S1, S24
    FMINNM  D7, D8, D5
    FMINNM  H4, H18, H19
    FMINNM  S12, S11, S25
    FMAX  S4, S21, S25
    FMAX  S29, S12, S22
    FMIN  S31, S5, S16
    FMINNM  S25, S20, S31
    FMAX  H25, H24, H3
    FMAXNM  H15, H24, H28
    FMINNM  H25, H27, H19
    FMAX  H13, H6, H24
    FMAXNM  H30, H5, H2
    FMINNM  H19, H15, H30
    FMAXNM  D14, D6, D1
    FMAXNM  D24, D2, D10
    FMAXNM  S28, S14, S7
    FMINNM  H29, H3, H20
    FMINNM  H25, H13, H0
    FMIN  D23, D22, D3
    FMINNM  D4, D30, D27
    FMIN  H28, H11, H16
    FMAX  S1, S26, S13
    FMINNM  H17, H19, H26
    FMINNM  S22, S18, S30
    FMINNM  D15, D28, D15
    FMIN  H10, H30, H16
    FMAX  S6, S24, S7
    FMAXNM  S17, S16, S13
    FMAXNM  H11, H0, H7
    FMAX  S10, S25, S18
    FMINNM  D4, D8, D14
    FMAXNM  S12, S24, S7
    FMIN  D6, D16, D30
    FMINNM  D21, D17, D16
    FMINNM  D29, D18, D31
    FMINNM  D1, D29, D26
    FMINNM  H23, H3, H1
    FMINNM  S16, S4, S3
    FMINNM  D26, D18, D31
    FMAX  S1, S11, S29
    FMIN  H0, H10, H25
    FMINNM  H25, H29, H18
    FMAX  D15, D18, D28
    FMAXNM  S24, S29, S20
    FMIN  H1, H31, H20
    FMAX  S13, S1, S19
    FMINNM  S17, S13, S3
    FMIN  D27, D25, D22
    FMINNM  S14, S11, S2
    FMIN  D14, D29, D25
    FMIN  D27, D9, D4
    FMAX  H19, H24, H22
    FMINNM  S7, S7, S30
    FMIN  S16, S8, S16
    FMAXNM  D10, D14, D1
    FMINNM  H25, H2, H1
    FMIN  S26, S15, S8
    FMAXNM  D15, D17, D18
    FMAX  D27, D2, D7
    FMAXNM  S21, S2, S9
    FMAXNM  D17, D1, D10
    FMIN  H13, H31, H17
    FMINNM  D19, D0, D1
    FMIN  D3, D6, D7
    FMINNM  S9, S16, S28
    FMINNM  S10, S19, S15
    FMAXNM  S10, S14, S26
    FMAX  D15, D15, D17
    FMIN  S29, S29, S18
    FMIN  S27, S10, S16
    FMAXNM  D18, D7, D4
    FMAX  D11, D1, D22
    FMAXNM  H20, H0, H23
    FMAX  D10, D2, D27
    FMAX  H3, H5, H26
    SUBS  X8, X8, #0x1
    B.NE  TaishanFpMovMaddP01_label_1591
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMovMaddP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X20, X21, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMovMaddP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X18, X4, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X7, X8, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X5, X21, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X14, X28, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X19, X23, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X10, X6, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X28, X14, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X11, X7, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X13, X18, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X4, X19, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMovMaddP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X27, X5, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X27, X13, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMovMaddP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMovMaddP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X8, D6
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D9
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X26, D10
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMovMaddP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X28, D11
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMovMaddP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X2, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X29, X14, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D15
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D16
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D17
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMovMaddP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X27, D18
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMovMaddP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X21, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMovMaddP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X29, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X4, D21
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X9, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMovMaddP01_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X11, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMovMaddP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X3, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMovMaddP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X18, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMovMaddP01_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X24, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMovMaddP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail
    FMOV  X6, D29
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMovMaddP01_TestFail

TaishanFpMovMaddP01_TestEnd:
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
TaishanFpMovMaddP01_TestFail:
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