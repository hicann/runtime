.global TSRTAdvsimdScalarFloatPointConvertToInteger

.text
.p2align 4

TSRTAdvsimdScalarFloatPointConvertToInteger:

TSRTAdvsimdScalarFloatPointConvertToInteger_TestBegin:
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
    MOVZ  X2, #0xafd8, LSL #0
    MOVK  X2, #0x7a4, LSL #16
    MOVK  X2, #0x9efa, LSL #32
    MOVK  X2, #0x5c55, LSL #48
    MOVZ  X4, #0x6016, LSL #0
    MOVK  X4, #0x34cc, LSL #16
    MOVK  X4, #0xf269, LSL #32
    MOVK  X4, #0x8d7c, LSL #48
    MOVZ  X5, #0x4397, LSL #0
    MOVK  X5, #0x4e98, LSL #16
    MOVK  X5, #0x4dbb, LSL #32
    MOVK  X5, #0xa192, LSL #48
    MOVZ  X6, #0xf5ac, LSL #0
    MOVK  X6, #0x4d61, LSL #16
    MOVK  X6, #0xb432, LSL #32
    MOVK  X6, #0x5818, LSL #48
    MOVZ  X7, #0x917c, LSL #0
    MOVK  X7, #0x3e78, LSL #16
    MOVK  X7, #0x2904, LSL #32
    MOVK  X7, #0xe427, LSL #48
    MOVZ  X8, #0x35a7, LSL #0
    MOVK  X8, #0xfe83, LSL #16
    MOVK  X8, #0xed, LSL #32
    MOVK  X8, #0xb3bf, LSL #48
    MOVZ  X9, #0x65b3, LSL #0
    MOVK  X9, #0x6130, LSL #16
    MOVK  X9, #0xe85, LSL #32
    MOVK  X9, #0x8d70, LSL #48
    MOVZ  X10, #0xb6eb, LSL #0
    MOVK  X10, #0xa2bb, LSL #16
    MOVK  X10, #0x3e78, LSL #32
    MOVK  X10, #0xbc02, LSL #48
    MOVZ  X12, #0xf64f, LSL #0
    MOVK  X12, #0x2b50, LSL #16
    MOVK  X12, #0xff59, LSL #32
    MOVK  X12, #0x2e9e, LSL #48
    MOVZ  X13, #0xab22, LSL #0
    MOVK  X13, #0xd7c2, LSL #16
    MOVK  X13, #0x6582, LSL #32
    MOVK  X13, #0x5325, LSL #48
    MOVZ  X14, #0x3dd5, LSL #0
    MOVK  X14, #0x1a6b, LSL #16
    MOVK  X14, #0xe17d, LSL #32
    MOVK  X14, #0xac6c, LSL #48
    MOVZ  X15, #0xbaf4, LSL #0
    MOVK  X15, #0x824d, LSL #16
    MOVK  X15, #0x10a7, LSL #32
    MOVK  X15, #0x90d0, LSL #48
    MOVZ  X16, #0x3db, LSL #0
    MOVK  X16, #0x64e, LSL #16
    MOVK  X16, #0x6c39, LSL #32
    MOVK  X16, #0x5eaf, LSL #48
    MOVZ  X17, #0xf866, LSL #0
    MOVK  X17, #0x503a, LSL #16
    MOVK  X17, #0xa1ac, LSL #32
    MOVK  X17, #0xc8a2, LSL #48
    MOVZ  X18, #0xae9b, LSL #0
    MOVK  X18, #0xb5db, LSL #16
    MOVK  X18, #0xe369, LSL #32
    MOVK  X18, #0x16c3, LSL #48
    MOVZ  X19, #0xcd4d, LSL #0
    MOVK  X19, #0x8526, LSL #16
    MOVK  X19, #0xfd3d, LSL #32
    MOVK  X19, #0x8404, LSL #48
    MOVZ  X20, #0x19e8, LSL #0
    MOVK  X20, #0xb785, LSL #16
    MOVK  X20, #0xb685, LSL #32
    MOVK  X20, #0xe6d3, LSL #48
    MOVZ  X21, #0x37f9, LSL #0
    MOVK  X21, #0x8438, LSL #16
    MOVK  X21, #0x7578, LSL #32
    MOVK  X21, #0xe3b5, LSL #48
    MOVZ  X22, #0xaaf7, LSL #0
    MOVK  X22, #0x83f8, LSL #16
    MOVK  X22, #0x9278, LSL #32
    MOVK  X22, #0xf30f, LSL #48
    MOVZ  X25, #0xabfb, LSL #0
    MOVK  X25, #0x2992, LSL #16
    MOVK  X25, #0x40da, LSL #32
    MOVK  X25, #0xf240, LSL #48
    MOVZ  X26, #0xb6d2, LSL #0
    MOVK  X26, #0x1b9e, LSL #16
    MOVK  X26, #0x970d, LSL #32
    MOVK  X26, #0x319, LSL #48
    MOVZ  X27, #0xfde4, LSL #0
    MOVK  X27, #0xa069, LSL #16
    MOVK  X27, #0xc905, LSL #32
    MOVK  X27, #0x4647, LSL #48
    MOVZ  X28, #0xbad4, LSL #0
    MOVK  X28, #0x673b, LSL #16
    MOVK  X28, #0xf853, LSL #32
    MOVK  X28, #0xf07f, LSL #48
    MOVZ  X29, #0x65e, LSL #0
    MOVK  X29, #0x1a58, LSL #16
    MOVK  X29, #0x5598, LSL #32
    MOVK  X29, #0x5d71, LSL #48
    MOVZ  X2, #0x75b7, LSL #0
    MOVK  X2, #0x6f66, LSL #16
    MOVK  X2, #0xf6b2, LSL #32
    MOVK  X2, #0xa53, LSL #48
    MSR  FPCR, X2
    MOVZ  X2, #0xaabc, LSL #0
    MOVK  X2, #0x94e7, LSL #16
    MOVK  X2, #0x7de4, LSL #32
    MOVK  X2, #0x419e, LSL #48
    MSR  FPSR, X2
    MRS  X22, FPSR
    MOVZ  X18, #0xff60, LSL #0
    MOVK  X18, #0x7ff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    AND  X22, X22, X18
    MOVZ  X18, #0x0, LSL #0
    ORR  X22, X22, X18
    MSR  FPSR, X22
    ISB  SY
    SUBS  W16, W28, W17, UXTX #4
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xc20, LSL #0
    MOVK  X2, #0xc223, LSL #16
    MOVK  X2, #0x9fba, LSL #32
    MOVK  X2, #0xfdf8, LSL #48
    MOVZ  X4, #0x6892, LSL #0
    MOVK  X4, #0x9571, LSL #16
    MOVK  X4, #0x8240, LSL #32
    MOVK  X4, #0xfcb5, LSL #48
    MOVZ  X5, #0x1f6b, LSL #0
    MOVK  X5, #0x57fa, LSL #16
    MOVK  X5, #0xe565, LSL #32
    MOVK  X5, #0xbf98, LSL #48
    MOVZ  X6, #0x4852, LSL #0
    MOVK  X6, #0x1edb, LSL #16
    MOVK  X6, #0x9d47, LSL #32
    MOVK  X6, #0x8811, LSL #48
    MOVZ  X7, #0x5090, LSL #0
    MOVK  X7, #0x37f9, LSL #16
    MOVK  X7, #0x6a1d, LSL #32
    MOVK  X7, #0xcaa8, LSL #48
    MOVZ  X8, #0xe23c, LSL #0
    MOVK  X8, #0xc54e, LSL #16
    MOVK  X8, #0x497c, LSL #32
    MOVK  X8, #0x8ddf, LSL #48
    MOVZ  X9, #0xb70b, LSL #0
    MOVK  X9, #0x9e1d, LSL #16
    MOVK  X9, #0xf917, LSL #32
    MOVK  X9, #0x733c, LSL #48
    MOVZ  X10, #0xd03f, LSL #0
    MOVK  X10, #0x8a6c, LSL #16
    MOVK  X10, #0xb8c6, LSL #32
    MOVK  X10, #0x9bf0, LSL #48
    MOVZ  X12, #0x4afc, LSL #0
    MOVK  X12, #0x9424, LSL #16
    MOVK  X12, #0xb6e6, LSL #32
    MOVK  X12, #0xfa4d, LSL #48
    MOVZ  X13, #0x54fb, LSL #0
    MOVK  X13, #0x2f50, LSL #16
    MOVK  X13, #0x438f, LSL #32
    MOVK  X13, #0x2176, LSL #48
    MOVZ  X14, #0xf140, LSL #0
    MOVK  X14, #0x646c, LSL #16
    MOVK  X14, #0xed58, LSL #32
    MOVK  X14, #0x9fb9, LSL #48
    MOVZ  X15, #0x93bc, LSL #0
    MOVK  X15, #0xbb6f, LSL #16
    MOVK  X15, #0x1d47, LSL #32
    MOVK  X15, #0xb805, LSL #48
    MOVZ  X16, #0x27a6, LSL #0
    MOVK  X16, #0x7f6d, LSL #16
    MOVK  X16, #0x73d6, LSL #32
    MOVK  X16, #0x5e5a, LSL #48
    MOVZ  X17, #0x42e6, LSL #0
    MOVK  X17, #0xd0e0, LSL #16
    MOVK  X17, #0xc79f, LSL #32
    MOVK  X17, #0x365c, LSL #48
    MOVZ  X18, #0x9791, LSL #0
    MOVK  X18, #0xabcb, LSL #16
    MOVK  X18, #0xc523, LSL #32
    MOVK  X18, #0xa94a, LSL #48
    MOVZ  X19, #0x9894, LSL #0
    MOVK  X19, #0x96ac, LSL #16
    MOVK  X19, #0xffa6, LSL #32
    MOVK  X19, #0xd07e, LSL #48
    MOVZ  X20, #0xcf0b, LSL #0
    MOVK  X20, #0x1138, LSL #16
    MOVK  X20, #0x8886, LSL #32
    MOVK  X20, #0x2f83, LSL #48
    MOVZ  X21, #0xda32, LSL #0
    MOVK  X21, #0x791e, LSL #16
    MOVK  X21, #0x88e2, LSL #32
    MOVK  X21, #0xb747, LSL #48
    MOVZ  X22, #0x530c, LSL #0
    MOVK  X22, #0x62fd, LSL #16
    MOVK  X22, #0xf5b0, LSL #32
    MOVK  X22, #0x1d73, LSL #48
    MOVZ  X25, #0x14dc, LSL #0
    MOVK  X25, #0x8488, LSL #16
    MOVK  X25, #0x95f, LSL #32
    MOVK  X25, #0x9df2, LSL #48
    MOVZ  X26, #0x2321, LSL #0
    MOVK  X26, #0x17cb, LSL #16
    MOVK  X26, #0xf7c9, LSL #32
    MOVK  X26, #0x84a4, LSL #48
    MOVZ  X27, #0xa49a, LSL #0
    MOVK  X27, #0x73b9, LSL #16
    MOVK  X27, #0xec5a, LSL #32
    MOVK  X27, #0x2791, LSL #48
    MOVZ  X28, #0x3bc2, LSL #0
    MOVK  X28, #0x4b6c, LSL #16
    MOVK  X28, #0xa7f7, LSL #32
    MOVK  X28, #0x9a29, LSL #48
    MOVZ  X29, #0xe5e3, LSL #0
    MOVK  X29, #0x4eb6, LSL #16
    MOVK  X29, #0x1b18, LSL #32
    MOVK  X29, #0xe68b, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X22
    FMOV  D3, X13
    FMOV  V3.D[1], X21
    FMOV  D4, X5
    FMOV  V4.D[1], X4
    FMOV  D5, X5
    FMOV  V5.D[1], X21
    FMOV  D6, X13
    FMOV  V6.D[1], X13
    FMOV  D7, X20
    FMOV  V7.D[1], X18
    FMOV  D8, X22
    FMOV  V8.D[1], X16
    FMOV  D9, X19
    FMOV  V9.D[1], X4
    FMOV  D10, X26
    FMOV  V10.D[1], X2
    FMOV  D11, X2
    FMOV  V11.D[1], X21
    FMOV  D12, X10
    FMOV  V12.D[1], X9
    FMOV  D13, X8
    FMOV  V13.D[1], X19
    FMOV  D14, X8
    FMOV  V14.D[1], X14
    FMOV  D15, X17
    FMOV  V15.D[1], X5
    FMOV  D16, X21
    FMOV  V16.D[1], X6
    FMOV  D17, X5
    FMOV  V17.D[1], X16
    FMOV  D18, X16
    FMOV  V18.D[1], X21
    FMOV  D19, X17
    FMOV  V19.D[1], X15
    FMOV  D20, X15
    FMOV  V20.D[1], X4
    FMOV  D21, X21
    FMOV  V21.D[1], X10
    FMOV  D22, X12
    FMOV  V22.D[1], X19
    FMOV  D23, X2
    FMOV  V23.D[1], X9
    FMOV  D24, X17
    FMOV  V24.D[1], X22
    FMOV  D25, X26
    FMOV  V25.D[1], X8
    FMOV  D26, X26
    FMOV  V26.D[1], X17
    FMOV  D27, X8
    FMOV  V27.D[1], X27
    FMOV  D28, X16
    FMOV  V28.D[1], X29
    FMOV  D29, X28
    FMOV  V29.D[1], X26
    FMOV  D30, X12
    FMOV  V30.D[1], X15
    FMOV  D31, X25
    FMOV  V31.D[1], X15
    MOVZ  X20, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_0:
    FCVTMS  S28, S29
    FCVTPU  H3, H22
    FCVTPS  S14, S31
    FCVTZU D27, D25, #58
    FCVTPS  H17, H14
    FCVTZU D13, D26, #45
    FCVTZS H10, H30, #1
    FCVTNU  H29, H10
    FCVTAS  D20, D28
    FCVTZU S7, S27, #15
    FCVTAU  S0, S29
    FCVTNU  S29, S20
    FCVTAS  H26, H7
    FCVTPS  H20, H17
    FCVTZU  D4, D20
    FCVTNS  S31, S0
    FCVTZU  S13, S3
    FCVTNU  S26, S26
    FCVTPU  D4, D31
    FCVTAS  H14, H29
    FCVTMU  D5, D14
    FCVTAS  S26, S27
    FCVTNU  S3, S5
    FCVTMS  D18, D4
    FCVTMS  H10, H3
    FCVTAS  H28, H13
    FCVTNS  D30, D26
    FCVTMU  H17, H18
    FCVTMS  H25, H17
    FCVTNU  H27, H25
    FCVTAS  S0, S27
    FCVTMU  H7, H0
    FCVTPU  H4, H7
    FCVTMU  S5, S30
    FCVTZU S31, S10, #10
    FCVTPS  H18, H26
    FCVTPS  D25, D5
    FCVTAU  D5, D25
    FCVTAS  H0, H5
    FCVTNS  D13, D31
    FCVTZU S27, S20, #1
    FCVTZS  H31, H28
    FCVTMU  H17, H18
    FCVTMS  S28, S4
    FCVTZS D29, D28, #38
    FCVTNS  H5, H13
    FCVTPU  S25, S0
    FCVTNS  D0, D31
    FCVTMU  D7, D5
    FCVTPU  H20, H0
    FCVTMS  S5, S20
    FCVTPS  S26, S17
    FCVTPU  H17, H25
    FCVTZS S18, S29, #29
    FCVTPU  D30, D5
    FCVTAS  D28, D17
    FCVTAU  S5, S27
    FCVTAU  D25, D5
    FCVTZS  D29, D7
    FCVTMU  D20, D29
    FCVTPU  S13, S25
    FCVTPS  H25, H23
    FCVTAU  D27, D25
    FCVTAU  D17, D26
    FCVTAS  D4, D20
    FCVTMU  H20, H18
    FCVTAS  D26, D13
    FCVTAS  H5, H26
    FCVTMS  H7, H27
    FCVTMS  D0, D5
    FCVTNU  D23, D4
    FCVTMU  D26, D0
    FCVTZS H29, H17, #7
    FCVTXN  S5, D20
    FCVTXN  S27, D26
    FCVTXN  S18, D28
    FCVTNS  S13, S23
    FCVTPS  D23, D5
    FCVTZU  S5, S23
    FCVTMU  S4, S7
    FCVTNS  H7, H29
    FCVTPS  S0, S5
    FCVTZU  H28, H4
    FCVTPS  H5, H0
    FCVTNU  H17, H13
    FCVTPS  S26, S7
    FCVTNU  D7, D27
    FCVTMS  D20, D28
    FCVTMU  D13, D20
    FCVTZS D27, D18, #14
    FCVTNS  S23, S5
    FCVTAU  H28, H23
    FCVTZU  D5, D28
    FCVTZU  D0, D5
    FCVTAU  H28, H17
    FCVTNS  H4, H26
    FCVTAS  H4, H7
    FCVTZS  S29, S4
    FCVTNS  H20, H27
    FCVTNU  H27, H13
    FCVTXN  S5, D20
    FCVTAS  S4, S5
    FCVTAU  H18, H28
    FCVTZS H23, H4, #1
    FCVTNS  S4, S0
    FCVTAU  D0, D4
    FCVTZS H13, H0, #9
    FCVTMU  H4, H13
    FCVTNU  H17, H18
    FCVTZU D21, D4, #48
    FCVTNU  H28, H27
    FCVTZS S7, S23, #11
    FCVTXN  S0, D29
    FCVTAU  D4, D0
    FCVTNU  H0, H4
    FCVTPU  H20, H28
    FCVTPS  D5, D21
    FCVTAU  H23, H0
    FCVTPS  D27, D7
    FCVTNU  H7, H27
    FCVTNU  D29, D7
    FCVTZU  D7, D8
    FCVTMU  S8, S23
    FCVTZU D13, D31, #19
    FCVTMS  H31, H29
    FCVTAU  H23, H20
    FCVTXN  S29, D17
    FCVTNS  H27, H7
    FCVTNS  H28, H27
    FCVTNS  S21, S5
    FCVTZS D7, D8, #50
    FCVTMU  S20, S13
    FCVTPS  S27, S23
    FCVTAU  D0, D1
    FCVTNS  D5, D31
    FCVTAU  D8, D7
    FCVTAU  S31, S27
    FCVTZU H27, H8, #5
    FCVTPS  D8, D29
    FCVTPS  H17, H8
    FCVTMS  D29, D20
    FCVTZS  S20, S29
    FCVTZU D29, D28, #4
    FCVTPS  D8, D23
    FCVTNU  D28, D21
    FCVTZS H23, H17, #16
    FCVTNU  H1, H27
    FCVTAU  S13, S5
    FCVTMS  S21, S20
    FCVTZU  D7, D23
    FCVTPS  H23, H13
    FCVTAS  D17, D23
    FCVTZS S27, S21, #31
    FCVTPU  D21, D0
    FCVTZS  S23, S8
    FCVTZS  S20, S31
    FCVTAU  S5, S17
    FCVTPS  H17, H1
    FCVTPS  H1, H7
    FCVTZU H31, H27, #7
    FCVTPS  S8, S8
    FCVTNS  D27, D1
    FCVTAU  D7, D29
    FCVTZS D1, D25, #2
    FCVTMS  S25, S28
    FCVTAS  D29, D17
    FCVTAS  D14, D21
    FCVTPS  S0, S23
    FCVTAU  D21, D25
    FCVTNU  D13, D1
    FCVTMS  S28, S14
    FCVTNU  H14, H27
    FCVTZU  S27, S29
    FCVTMU  D1, D8
    FCVTZS S17, S31, #14
    FCVTPU  D23, D28
    FCVTMS  H31, H13
    FCVTZU  H25, H23
    FCVTNU  D29, D14
    FCVTZU  D29, D0
    FCVTPS  H8, H5
    FCVTXN  S23, D1
    FCVTNU  S0, S17
    FCVTZS  D1, D0
    FCVTNU  S14, S23
    FCVTMU  H23, H27
    FCVTAS  D13, D21
    FCVTXN  S28, D23
    FCVTPU  S21, S8
    FCVTAU  S8, S29
    FCVTNS  S0, S31
    FCVTZU  S23, S1
    FCVTAU  H17, H23
    FCVTAS  D31, D28
    FCVTPU  D8, D13
    FCVTPU  H29, H25
    FCVTMS  S25, S17
    FCVTZU  S30, S31
    FCVTZU  S1, S30
    FCVTZS S5, S14, #13
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_0
    MOVZ  X17, #0xc20, LSL #0
    MOVK  X17, #0xc223, LSL #16
    MOVK  X17, #0x9fba, LSL #32
    MOVK  X17, #0xfdf8, LSL #48
    SUB  X25, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x6892, LSL #0
    MOVK  X17, #0x9571, LSL #16
    MOVK  X17, #0x8240, LSL #32
    MOVK  X17, #0xfcb5, LSL #48
    SUB  X25, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x1f6b, LSL #0
    MOVK  X17, #0x57fa, LSL #16
    MOVK  X17, #0xe565, LSL #32
    MOVK  X17, #0xbf98, LSL #48
    SUB  X25, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x4852, LSL #0
    MOVK  X17, #0x1edb, LSL #16
    MOVK  X17, #0x9d47, LSL #32
    MOVK  X17, #0x8811, LSL #48
    SUB  X25, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x5090, LSL #0
    MOVK  X17, #0x37f9, LSL #16
    MOVK  X17, #0x6a1d, LSL #32
    MOVK  X17, #0xcaa8, LSL #48
    SUB  X25, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xe23c, LSL #0
    MOVK  X17, #0xc54e, LSL #16
    MOVK  X17, #0x497c, LSL #32
    MOVK  X17, #0x8ddf, LSL #48
    SUB  X25, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xb70b, LSL #0
    MOVK  X17, #0x9e1d, LSL #16
    MOVK  X17, #0xf917, LSL #32
    MOVK  X17, #0x733c, LSL #48
    SUB  X25, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xd03f, LSL #0
    MOVK  X17, #0x8a6c, LSL #16
    MOVK  X17, #0xb8c6, LSL #32
    MOVK  X17, #0x9bf0, LSL #48
    SUB  X25, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x4afc, LSL #0
    MOVK  X17, #0x9424, LSL #16
    MOVK  X17, #0xb6e6, LSL #32
    MOVK  X17, #0xfa4d, LSL #48
    SUB  X25, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x54fb, LSL #0
    MOVK  X17, #0x2f50, LSL #16
    MOVK  X17, #0x438f, LSL #32
    MOVK  X17, #0x2176, LSL #48
    SUB  X25, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xf140, LSL #0
    MOVK  X17, #0x646c, LSL #16
    MOVK  X17, #0xed58, LSL #32
    MOVK  X17, #0x9fb9, LSL #48
    SUB  X25, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x93bc, LSL #0
    MOVK  X17, #0xbb6f, LSL #16
    MOVK  X17, #0x1d47, LSL #32
    MOVK  X17, #0xb805, LSL #48
    SUB  X25, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x27a6, LSL #0
    MOVK  X17, #0x7f6d, LSL #16
    MOVK  X17, #0x73d6, LSL #32
    MOVK  X17, #0x5e5a, LSL #48
    SUB  X25, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x9791, LSL #0
    MOVK  X17, #0xabcb, LSL #16
    MOVK  X17, #0xc523, LSL #32
    MOVK  X17, #0xa94a, LSL #48
    SUB  X25, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x9894, LSL #0
    MOVK  X17, #0x96ac, LSL #16
    MOVK  X17, #0xffa6, LSL #32
    MOVK  X17, #0xd07e, LSL #48
    SUB  X25, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xda32, LSL #0
    MOVK  X17, #0x791e, LSL #16
    MOVK  X17, #0x88e2, LSL #32
    MOVK  X17, #0xb747, LSL #48
    SUB  X25, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x530c, LSL #0
    MOVK  X17, #0x62fd, LSL #16
    MOVK  X17, #0xf5b0, LSL #32
    MOVK  X17, #0x1d73, LSL #48
    SUB  X25, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x2321, LSL #0
    MOVK  X17, #0x17cb, LSL #16
    MOVK  X17, #0xf7c9, LSL #32
    MOVK  X17, #0x84a4, LSL #48
    SUB  X25, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x3bc2, LSL #0
    MOVK  X17, #0x4b6c, LSL #16
    MOVK  X17, #0xa7f7, LSL #32
    MOVK  X17, #0x9a29, LSL #48
    SUB  X25, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xe5e3, LSL #0
    MOVK  X17, #0x4eb6, LSL #16
    MOVK  X17, #0x1b18, LSL #32
    MOVK  X17, #0xe68b, LSL #48
    SUB  X25, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x90, LSL #0
    MRS  X25, FPSR
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x530c, LSL #0
    MOVK  X17, #0x62fd, LSL #16
    MOVK  X17, #0xf5b0, LSL #32
    MOVK  X17, #0x1d73, LSL #48
    FMOV  X25, V2.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x2321, LSL #0
    MOVK  X17, #0x17cb, LSL #16
    MOVK  X17, #0xf7c9, LSL #32
    MOVK  X17, #0x84a4, LSL #48
    FMOV  X25, D2
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D5
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x54fb, LSL #0
    MOVK  X17, #0x2f50, LSL #16
    MOVK  X17, #0x438f, LSL #32
    MOVK  X17, #0x2176, LSL #48
    FMOV  X25, V6.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x54fb, LSL #0
    MOVK  X17, #0x2f50, LSL #16
    MOVK  X17, #0x438f, LSL #32
    MOVK  X17, #0x2176, LSL #48
    FMOV  X25, D6
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x6892, LSL #0
    MOVK  X17, #0x9571, LSL #16
    MOVK  X17, #0x8240, LSL #32
    MOVK  X17, #0xfcb5, LSL #48
    FMOV  X25, V9.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x9894, LSL #0
    MOVK  X17, #0x96ac, LSL #16
    MOVK  X17, #0xffa6, LSL #32
    MOVK  X17, #0xd07e, LSL #48
    FMOV  X25, D9
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xda32, LSL #0
    MOVK  X17, #0x791e, LSL #16
    MOVK  X17, #0x88e2, LSL #32
    MOVK  X17, #0xb747, LSL #48
    FMOV  X25, V11.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xc20, LSL #0
    MOVK  X17, #0xc223, LSL #16
    MOVK  X17, #0x9fba, LSL #32
    MOVK  X17, #0xfdf8, LSL #48
    FMOV  X25, D11
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xb70b, LSL #0
    MOVK  X17, #0x9e1d, LSL #16
    MOVK  X17, #0xf917, LSL #32
    MOVK  X17, #0x733c, LSL #48
    FMOV  X25, V12.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xd03f, LSL #0
    MOVK  X17, #0x8a6c, LSL #16
    MOVK  X17, #0xb8c6, LSL #32
    MOVK  X17, #0x9bf0, LSL #48
    FMOV  X25, D12
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x1f6b, LSL #0
    MOVK  X17, #0x57fa, LSL #16
    MOVK  X17, #0xe565, LSL #32
    MOVK  X17, #0xbf98, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x42e6, LSL #0
    MOVK  X17, #0xd0e0, LSL #16
    MOVK  X17, #0xc79f, LSL #32
    MOVK  X17, #0x365c, LSL #48
    FMOV  X25, D15
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x4852, LSL #0
    MOVK  X17, #0x1edb, LSL #16
    MOVK  X17, #0x9d47, LSL #32
    MOVK  X17, #0x8811, LSL #48
    FMOV  X25, V16.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xda32, LSL #0
    MOVK  X17, #0x791e, LSL #16
    MOVK  X17, #0x88e2, LSL #32
    MOVK  X17, #0xb747, LSL #48
    FMOV  X25, D16
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x93bc, LSL #0
    MOVK  X17, #0xbb6f, LSL #16
    MOVK  X17, #0x1d47, LSL #32
    MOVK  X17, #0xb805, LSL #48
    FMOV  X25, V19.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x42e6, LSL #0
    MOVK  X17, #0xd0e0, LSL #16
    MOVK  X17, #0xc79f, LSL #32
    MOVK  X17, #0x365c, LSL #48
    FMOV  X25, D19
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x9894, LSL #0
    MOVK  X17, #0x96ac, LSL #16
    MOVK  X17, #0xffa6, LSL #32
    MOVK  X17, #0xd07e, LSL #48
    FMOV  X25, V22.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x4afc, LSL #0
    MOVK  X17, #0x9424, LSL #16
    MOVK  X17, #0xb6e6, LSL #32
    MOVK  X17, #0xfa4d, LSL #48
    FMOV  X25, D22
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x530c, LSL #0
    MOVK  X17, #0x62fd, LSL #16
    MOVK  X17, #0xf5b0, LSL #32
    MOVK  X17, #0x1d73, LSL #48
    FMOV  X25, V24.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x42e6, LSL #0
    MOVK  X17, #0xd0e0, LSL #16
    MOVK  X17, #0xc79f, LSL #32
    MOVK  X17, #0x365c, LSL #48
    FMOV  X25, D24
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X27, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X4
    FMOV  V0.D[1], X13
    FMOV  D1, X28
    FMOV  V1.D[1], X15
    FMOV  D2, X16
    FMOV  V2.D[1], X29
    FMOV  D3, X27
    FMOV  V3.D[1], X17
    FMOV  D4, X20
    FMOV  V4.D[1], X21
    FMOV  D5, X26
    FMOV  V5.D[1], X25
    FMOV  D6, X22
    FMOV  V6.D[1], X14
    FMOV  D7, X17
    FMOV  V7.D[1], X21
    FMOV  D8, X12
    FMOV  V8.D[1], X12
    FMOV  D9, X20
    FMOV  V9.D[1], X7
    FMOV  D10, X14
    FMOV  V10.D[1], X21
    FMOV  D11, X25
    FMOV  V11.D[1], X10
    FMOV  D12, X7
    FMOV  V12.D[1], X16
    FMOV  D13, X15
    FMOV  V13.D[1], X28
    FMOV  D14, X2
    FMOV  V14.D[1], X17
    FMOV  D15, X27
    FMOV  V15.D[1], X22
    FMOV  D16, X25
    FMOV  V16.D[1], X25
    FMOV  D17, X26
    FMOV  V17.D[1], X13
    FMOV  D18, X6
    FMOV  V18.D[1], X25
    FMOV  D19, X25
    FMOV  V19.D[1], X25
    FMOV  D20, X18
    FMOV  V20.D[1], X6
    FMOV  D21, X8
    FMOV  V21.D[1], X26
    FMOV  D22, X8
    FMOV  V22.D[1], X4
    FMOV  D23, X29
    FMOV  V23.D[1], X27
    FMOV  D24, X20
    FMOV  V24.D[1], X9
    FMOV  D25, X26
    FMOV  V25.D[1], X21
    FMOV  D26, X29
    FMOV  V26.D[1], X12
    FMOV  D27, X4
    FMOV  V27.D[1], X25
    FMOV  D28, X14
    FMOV  V28.D[1], X10
    FMOV  D29, X20
    FMOV  V29.D[1], X8
    FMOV  D30, X15
    FMOV  V30.D[1], X5
    FMOV  D31, X25
    FMOV  V31.D[1], X21
    MOVZ  X5, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_1:
    FCVTAS  D19, D30
    FCVTPU  D16, D18
    FCVTXN  S8, D20
    FCVTZS H6, H26, #9
    FCVTXN  S9, D25
    FCVTZU D20, D19, #8
    FCVTZS  D8, D20
    FCVTZU  D14, D31
    FCVTZS  H11, H8
    FCVTNU  D11, D24
    FCVTNU  H23, H23
    FCVTMS  H28, H27
    FCVTAU  D4, D9
    FCVTZU  D22, D29
    FCVTZU D6, D23, #21
    FCVTAS  H15, H14
    FCVTAU  D27, D16
    FCVTMU  S11, S15
    FCVTPU  S16, S22
    FCVTNS  H8, H28
    FCVTZU S24, S8, #15
    FCVTAS  D9, D27
    FCVTAS  H20, H4
    FCVTZS H29, H6, #3
    FCVTZS  D14, D29
    FCVTZS  S8, S11
    FCVTMU  H27, H14
    FCVTNU  D23, D9
    FCVTAU  H15, H20
    FCVTNU  S28, S16
    FCVTAS  S4, S24
    FCVTPS  S11, S4
    FCVTMS  D4, D11
    FCVTNU  D22, D8
    FCVTNS  S24, S28
    FCVTPU  H14, H27
    FCVTZS D11, D27, #14
    FCVTPS  S28, S22
    FCVTZS D28, D4, #28
    FCVTZU H27, H24, #14
    FCVTZS H20, H15, #4
    FCVTNU  D29, D23
    FCVTAU  D23, D11
    FCVTMS  H1, H29
    FCVTPU  S15, S1
    FCVTAS  D16, D15
    FCVTZS  D15, D8
    FCVTAS  H24, H14
    FCVTZU  H14, H24
    FCVTPU  H8, H20
    FCVTPS  D1, D15
    FCVTNU  D15, D16
    FCVTPS  D9, D8
    FCVTPS  D8, D9
    FCVTAS  S16, S28
    FCVTAS  S29, S1
    FCVTPS  S1, S16
    FCVTNS  D11, D14
    FCVTZU  D28, D27
    FCVTAU  D20, D29
    FCVTNU  D16, D28
    FCVTAS  H24, H23
    FCVTMU  D28, D8
    FCVTPS  H14, H11
    FCVTAU  S9, S15
    FCVTAS  S29, S14
    FCVTAS  H14, H29
    FCVTNS  D22, D16
    FCVTZU S15, S9, #26
    FCVTNS  D16, D28
    FCVTMU  S11, S20
    FCVTZS  D29, D24
    FCVTMS  D20, D1
    FCVTMS  D23, D14
    FCVTPS  D8, D15
    FCVTPU  H27, H11
    FCVTZS  S11, S11
    FCVTZS S30, S29, #14
    FCVTMS  S15, S30
    FCVTZS  D28, D22
    FCVTZS S14, S28, #4
    FCVTZS  D22, D14
    FCVTAU  D14, D27
    FCVTNS  D24, D14
    FCVTPU  D9, D24
    FCVTMS  D28, D22
    FCVTPU  S29, S15
    FCVTAU  D27, D8
    FCVTNU  H14, H28
    FCVTZS S8, S20, #18
    FCVTMS  S30, S23
    FCVTPU  D1, D11
    FCVTZS  H28, H9
    FCVTZU  S15, S27
    FCVTNU  S22, S29
    FCVTMS  S20, S8
    FCVTNS  D0, D14
    FCVTZS  D11, D1
    FCVTPU  S24, S11
    FCVTAS  D8, D22
    FCVTZS  H23, H20
    FCVTMS  H29, H30
    FCVTZS S20, S29, #29
    FCVTPS  D22, D20
    FCVTXN  S11, D0
    FCVTZS  S1, S11
    FCVTZU S16, S28, #16
    FCVTPU  S9, S1
    FCVTMS  D1, D23
    FCVTZS H28, H1, #15
    FCVTAS  S27, S16
    FCVTZU H11, H15, #13
    FCVTXN  S29, D24
    FCVTZU S1, S22, #5
    FCVTZU D22, D9, #38
    FCVTZU  S0, S28
    FCVTZU  H30, H1
    FCVTAS  S15, S8
    FCVTPU  D16, D30
    FCVTMS  S20, S16
    FCVTPS  S16, S22
    FCVTNU  H24, H11
    FCVTNS  H8, H30
    FCVTZU D1, D24, #15
    FCVTPS  D24, D15
    FCVTZU  S14, S24
    FCVTZU  S22, S27
    FCVTMU  D15, D7
    FCVTZU S1, S16, #16
    FCVTMS  S28, S0
    FCVTNU  S11, S1
    FCVTAU  D1, D20
    FCVTZU  H24, H29
    FCVTAU  H20, H14
    FCVTAU  D27, D20
    FCVTZS  D7, D1
    FCVTNS  H29, H27
    FCVTPS  H16, H28
    FCVTAS  H30, H7
    FCVTZS  S7, S24
    FCVTZU D9, D11, #15
    FCVTMU  D11, D15
    FCVTZU S14, S9, #23
    FCVTZS H9, H11, #16
    FCVTZS D18, D29, #54
    FCVTZS H24, H14, #15
    FCVTMU  H0, H8
    FCVTZS S29, S16, #7
    FCVTAS  D9, D24
    FCVTZU  S27, S18
    FCVTPS  D15, D27
    FCVTZU  S14, S0
    FCVTZS  S27, S14
    FCVTZS H20, H27, #14
    FCVTNS  D14, D22
    FCVTMS  D24, D30
    FCVTPU  H30, H7
    FCVTZU H11, H29, #8
    FCVTZS H18, H11, #14
    FCVTPS  H22, H18
    FCVTAU  S29, S15
    FCVTPU  H0, H22
    FCVTPS  D8, D15
    FCVTNU  D18, D7
    FCVTPU  S11, S30
    FCVTMS  S30, S20
    FCVTAU  S27, S29
    FCVTZU  D22, D27
    FCVTZS D15, D24, #16
    FCVTXN  S24, D0
    FCVTMS  S7, S30
    FCVTMS  D20, D22
    FCVTNS  H30, H8
    FCVTMS  D22, D14
    FCVTMU  S16, S11
    FCVTXN  S11, D22
    FCVTMS  D29, D11
    FCVTPU  S27, S20
    FCVTMU  D23, D18
    FCVTAU  S18, S23
    FCVTPU  H23, H15
    FCVTAS  D15, D24
    FCVTZS D8, D18, #16
    FCVTZS  D0, D8
    FCVTAS  H14, H29
    FCVTZS  D29, D7
    FCVTAU  S22, S0
    FCVTPU  H11, H14
    FCVTZU S0, S27, #18
    FCVTZU  H8, H30
    FCVTAS  S24, S15
    FCVTZS H20, H29, #13
    FCVTPS  H18, H22
    FCVTZS D14, D0, #42
    FCVTMU  H0, H23
    FCVTPU  H7, H24
    FCVTMS  H24, H14
    FCVTZS  H30, H18
    FCVTAS  H29, H30
    FCVTMS  S14, S24
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_1
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x90, LSL #0
    MRS  X16, FPSR
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D10
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D16
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D20
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X17, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X12
    FMOV  V2.D[1], X14
    FMOV  D3, X17
    FMOV  V3.D[1], X8
    FMOV  D4, X16
    FMOV  V4.D[1], X29
    FMOV  D5, X17
    FMOV  V5.D[1], X10
    FMOV  D6, X22
    FMOV  V6.D[1], X18
    FMOV  D7, X7
    FMOV  V7.D[1], X22
    FMOV  D8, X4
    FMOV  V8.D[1], X25
    FMOV  D9, X16
    FMOV  V9.D[1], X4
    FMOV  D10, X18
    FMOV  V10.D[1], X2
    FMOV  D11, X9
    FMOV  V11.D[1], X28
    FMOV  D12, X26
    FMOV  V12.D[1], X15
    FMOV  D13, X12
    FMOV  V13.D[1], X18
    FMOV  D14, X4
    FMOV  V14.D[1], X21
    FMOV  D15, X25
    FMOV  V15.D[1], X7
    FMOV  D16, X4
    FMOV  V16.D[1], X7
    FMOV  D17, X19
    FMOV  V17.D[1], X7
    FMOV  D18, X27
    FMOV  V18.D[1], X28
    FMOV  D19, X18
    FMOV  V19.D[1], X15
    FMOV  D20, X27
    FMOV  V20.D[1], X25
    FMOV  D21, X10
    FMOV  V21.D[1], X4
    FMOV  D22, X6
    FMOV  V22.D[1], X21
    FMOV  D23, X15
    FMOV  V23.D[1], X7
    FMOV  D24, X8
    FMOV  V24.D[1], X18
    FMOV  D25, X8
    FMOV  V25.D[1], X18
    FMOV  D26, X5
    FMOV  V26.D[1], X19
    FMOV  D27, X28
    FMOV  V27.D[1], X25
    FMOV  D28, X14
    FMOV  V28.D[1], X16
    FMOV  D29, X25
    FMOV  V29.D[1], X25
    FMOV  D30, X26
    FMOV  V30.D[1], X22
    FMOV  D31, X7
    FMOV  V31.D[1], X16
    MOVZ  X16, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_2:
    FCVTZS D1, D31, #16
    FCVTZU  D19, D29
    FCVTMU  H17, H28
    FCVTZS D17, D30, #37
    FCVTPU  H16, H17
    FCVTPS  H17, H27
    FCVTNU  D6, D19
    FCVTNU  H10, H6
    FCVTNU  H14, H26
    FCVTZS D5, D10, #11
    FCVTZS H28, H5, #6
    FCVTPS  H2, H1
    FCVTPU  S16, S25
    FCVTAS  H6, H28
    FCVTMU  H23, H17
    FCVTNS  S20, S10
    FCVTNU  S31, S14
    FCVTAS  D10, D28
    FCVTNS  S4, S2
    FCVTMS  S16, S16
    FCVTNU  D28, D6
    FCVTAS  S22, S20
    FCVTAU  D6, D31
    FCVTMU  S0, S28
    FCVTZS  H21, H10
    FCVTMU  S14, S6
    FCVTMS  D25, D16
    FCVTNS  S17, S0
    FCVTAS  D31, D21
    FCVTAS  S21, S23
    FCVTNS  H29, H9
    FCVTNS  D1, D19
    FCVTNS  D9, D4
    FCVTMU  S20, S9
    FCVTAU  D28, D14
    FCVTNU  D4, D28
    FCVTNS  D10, D30
    FCVTPS  S6, S22
    FCVTPU  D19, D20
    FCVTNU  D9, D25
    FCVTZU H14, H9, #8
    FCVTZS S16, S29, #6
    FCVTZS S25, S14, #28
    FCVTMU  D23, D25
    FCVTZS  H25, H1
    FCVTZS S14, S19, #8
    FCVTZS D0, D31, #22
    FCVTPS  D28, D4
    FCVTZS  S4, S21
    FCVTPS  S1, S4
    FCVTPU  H9, H23
    FCVTAU  D31, D17
    FCVTZU  H17, H25
    FCVTAS  H29, H0
    FCVTPU  D26, D9
    FCVTZS  D0, D6
    FCVTZU  H4, H1
    FCVTMS  S19, S17
    FCVTXN  S21, D28
    FCVTZS  S23, S16
    FCVTXN  S6, D23
    FCVTAU  H17, H29
    FCVTZS S29, S6, #18
    FCVTZU D25, D19, #57
    FCVTMS  D1, D17
    FCVTZU D9, D31, #57
    FCVTXN  S19, D4
    FCVTMU  H22, H14
    FCVTZU S14, S21, #7
    FCVTZS  S23, S14
    FCVTZS  S6, S19
    FCVTPS  S19, S6
    FCVTAU  S6, S26
    FCVTZS D28, D6, #49
    FCVTMU  D14, D19
    FCVTZS H21, H22, #5
    FCVTMS  H4, H0
    FCVTPS  S26, S28
    FCVTZS  H19, H9
    FCVTMS  D31, D29
    FCVTXN  S28, D19
    FCVTMU  S29, S25
    FCVTAS  D6, D26
    FCVTMU  D0, D21
    FCVTAS  S19, S28
    FCVTZS  D22, D19
    FCVTMS  H19, H4
    FCVTZU  D25, D23
    FCVTZS S9, S31, #15
    FCVTMU  D21, D0
    FCVTZS D23, D14, #9
    FCVTZU S26, S1, #2
    FCVTZU S28, S9, #26
    FCVTPU  D0, D16
    FCVTZU D4, D29, #14
    FCVTNS  S9, S23
    FCVTMS  D3, D4
    FCVTZU  H16, H26
    FCVTZU  S26, S6
    FCVTNS  S6, S28
    FCVTNU  D15, D19
    FCVTZS  D28, D25
    FCVTPS  D14, D21
    FCVTNS  H19, H0
    FCVTPS  S21, S14
    FCVTAS  H25, H22
    FCVTZS  H1, H9
    FCVTZU  S29, S19
    FCVTNS  D4, D15
    FCVTZS  S15, S4
    FCVTAS  H14, H1
    FCVTZU  H31, H4
    FCVTAU  H4, H31
    FCVTNS  S31, S15
    FCVTNU  S22, S6
    FCVTNU  D23, D26
    FCVTAS  D0, D16
    FCVTZS H9, H0, #7
    FCVTZS H19, H29, #14
    FCVTMU  D29, D28
    FCVTZS  S26, S19
    FCVTMU  S16, S22
    FCVTNS  H15, H31
    FCVTPS  H6, H15
    FCVTAS  H31, H25
    FCVTMS  S15, S21
    FCVTZU  D25, D31
    FCVTAU  D1, D2
    FCVTPS  D0, D29
    FCVTMU  H29, H14
    FCVTNU  S0, S29
    FCVTZU H21, H26, #16
    FCVTAU  S26, S23
    FCVTMS  H29, H4
    FCVTZS H4, H16, #13
    FCVTZU D22, D1, #57
    FCVTMS  H14, H6
    FCVTAU  H31, H21
    FCVTPS  S21, S15
    FCVTZU H16, H25, #13
    FCVTXN  S28, D9
    FCVTNU  D23, D21
    FCVTZU S1, S0, #9
    FCVTMU  H2, H28
    FCVTAU  S6, S22
    FCVTZS  S15, S6
    FCVTPS  H25, H15
    FCVTPU  D9, D25
    FCVTMU  H25, H9
    FCVTPU  D19, D23
    FCVTMU  S6, S29
    FCVTZS  D21, D2
    FCVTPS  D30, D21
    FCVTMU  H23, H31
    FCVTMS  D21, D19
    FCVTNU  S0, S1
    FCVTAU  S19, S21
    FCVTNS  D29, D25
    FCVTAU  H18, H6
    FCVTMS  H21, H26
    FCVTMU  S31, S30
    FCVTMS  H9, H21
    FCVTPS  D6, D0
    FCVTAU  D15, D6
    FCVTAU  S25, S19
    FCVTXN  S28, D31
    FCVTZU D26, D29, #44
    FCVTZS D1, D15, #6
    FCVTPU  H19, H28
    FCVTNS  S21, S23
    FCVTZS D31, D18, #29
    FCVTMS  S15, S26
    FCVTPS  D28, D19
    FCVTMU  H2, H15
    FCVTMS  H30, H25
    FCVTNS  D25, D31
    FCVTPS  H31, H2
    FCVTZU  S26, S25
    FCVTMS  H0, H25
    FCVTZS H2, H26, #13
    FCVTMU  H6, H2
    FCVTAS  D26, D2
    FCVTZU  D25, D28
    FCVTNS  S2, S6
    FCVTZU  D28, D25
    FCVTXN  S6, D30
    FCVTMS  H29, H21
    FCVTPS  H25, H0
    FCVTNS  D0, D31
    FCVTAU  H30, H2
    FCVTZS  H21, H25
    FCVTNU  D15, D0
    FCVTZU  S31, S28
    FCVTNU  D2, D26
    FCVTPS  H26, H21
    FCVTNS  S21, S15
    FCVTMS  H25, H2
    FCVTAU  S15, S26
    FCVTZS  S2, S6
    FCVTMU  D18, D29
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_2
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X8, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x91, LSL #0
    MRS  X8, FPSR
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D0
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D1
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D2
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D3
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D4
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D5
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D6
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, V7.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, D7
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, V8.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, D8
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D9
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D10
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, D11
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, V12.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, D12
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, V13.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, D13
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D14
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V15.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D15
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D16
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D17
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D18
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D19
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D20
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D21
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D22
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D23
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, V24.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, D24
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D25
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D26
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, V27.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X8, D27
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D28
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D29
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D30
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X8, D31
    SUB  X6, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x9ca2, LSL #0
    MOVK  X2, #0x5696, LSL #16
    MOVK  X2, #0xea43, LSL #32
    MOVK  X2, #0x9cdc, LSL #48
    MOVZ  X4, #0xa20f, LSL #0
    MOVK  X4, #0x65e7, LSL #16
    MOVK  X4, #0xcfd4, LSL #32
    MOVK  X4, #0x933e, LSL #48
    MOVZ  X5, #0xf2b8, LSL #0
    MOVK  X5, #0x6a5c, LSL #16
    MOVK  X5, #0xf5fb, LSL #32
    MOVK  X5, #0x2c8a, LSL #48
    MOVZ  X6, #0x7077, LSL #0
    MOVK  X6, #0xe3bf, LSL #16
    MOVK  X6, #0x300a, LSL #32
    MOVK  X6, #0xd2e9, LSL #48
    MOVZ  X7, #0xb34e, LSL #0
    MOVK  X7, #0xe651, LSL #16
    MOVK  X7, #0xf5da, LSL #32
    MOVK  X7, #0x54c4, LSL #48
    MOVZ  X8, #0x4e69, LSL #0
    MOVK  X8, #0x3741, LSL #16
    MOVK  X8, #0x1c78, LSL #32
    MOVK  X8, #0x74b3, LSL #48
    MOVZ  X9, #0x1972, LSL #0
    MOVK  X9, #0x4727, LSL #16
    MOVK  X9, #0xfe9d, LSL #32
    MOVK  X9, #0x6015, LSL #48
    MOVZ  X10, #0x637a, LSL #0
    MOVK  X10, #0xc41b, LSL #16
    MOVK  X10, #0x1794, LSL #32
    MOVK  X10, #0xdbc8, LSL #48
    MOVZ  X12, #0x92e4, LSL #0
    MOVK  X12, #0xc168, LSL #16
    MOVK  X12, #0xa348, LSL #32
    MOVK  X12, #0x50e7, LSL #48
    MOVZ  X13, #0x3dec, LSL #0
    MOVK  X13, #0x304d, LSL #16
    MOVK  X13, #0xab0c, LSL #32
    MOVK  X13, #0xc801, LSL #48
    MOVZ  X14, #0x8367, LSL #0
    MOVK  X14, #0xc366, LSL #16
    MOVK  X14, #0x668, LSL #32
    MOVK  X14, #0xb159, LSL #48
    MOVZ  X15, #0xa707, LSL #0
    MOVK  X15, #0x8, LSL #16
    MOVK  X15, #0x64ba, LSL #32
    MOVK  X15, #0xd831, LSL #48
    MOVZ  X16, #0x670f, LSL #0
    MOVK  X16, #0x490a, LSL #16
    MOVK  X16, #0x4b9a, LSL #32
    MOVK  X16, #0xb45e, LSL #48
    MOVZ  X17, #0xea8a, LSL #0
    MOVK  X17, #0xce5c, LSL #16
    MOVK  X17, #0x514, LSL #32
    MOVK  X17, #0x1a5b, LSL #48
    MOVZ  X18, #0xa2dd, LSL #0
    MOVK  X18, #0xabcf, LSL #16
    MOVK  X18, #0xa44d, LSL #32
    MOVK  X18, #0x907f, LSL #48
    MOVZ  X19, #0x3702, LSL #0
    MOVK  X19, #0x81d, LSL #16
    MOVK  X19, #0xeed2, LSL #32
    MOVK  X19, #0x9b20, LSL #48
    MOVZ  X20, #0x65f4, LSL #0
    MOVK  X20, #0x76d9, LSL #16
    MOVK  X20, #0x2109, LSL #32
    MOVK  X20, #0x30b3, LSL #48
    MOVZ  X21, #0x1a49, LSL #0
    MOVK  X21, #0x22bb, LSL #16
    MOVK  X21, #0xc594, LSL #32
    MOVK  X21, #0x9929, LSL #48
    MOVZ  X22, #0x7270, LSL #0
    MOVK  X22, #0x8ab8, LSL #16
    MOVK  X22, #0x5ede, LSL #32
    MOVK  X22, #0xad8, LSL #48
    MOVZ  X25, #0x3f4e, LSL #0
    MOVK  X25, #0xc48e, LSL #16
    MOVK  X25, #0x103a, LSL #32
    MOVK  X25, #0xfe74, LSL #48
    MOVZ  X26, #0x1f97, LSL #0
    MOVK  X26, #0x1c71, LSL #16
    MOVK  X26, #0x346b, LSL #32
    MOVK  X26, #0xeb03, LSL #48
    MOVZ  X27, #0xdf48, LSL #0
    MOVK  X27, #0x81fa, LSL #16
    MOVK  X27, #0x27c, LSL #32
    MOVK  X27, #0x2028, LSL #48
    MOVZ  X28, #0xf3b2, LSL #0
    MOVK  X28, #0x7068, LSL #16
    MOVK  X28, #0xe0ff, LSL #32
    MOVK  X28, #0x6028, LSL #48
    MOVZ  X29, #0x6bc3, LSL #0
    MOVK  X29, #0xec16, LSL #16
    MOVK  X29, #0xeee6, LSL #32
    MOVK  X29, #0x1690, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X2
    FMOV  D3, X5
    FMOV  V3.D[1], X4
    FMOV  D4, X25
    FMOV  V4.D[1], X13
    FMOV  D5, X16
    FMOV  V5.D[1], X25
    FMOV  D6, X10
    FMOV  V6.D[1], X4
    FMOV  D7, X26
    FMOV  V7.D[1], X9
    FMOV  D8, X15
    FMOV  V8.D[1], X15
    FMOV  D9, X7
    FMOV  V9.D[1], X2
    FMOV  D10, X2
    FMOV  V10.D[1], X18
    FMOV  D11, X28
    FMOV  V11.D[1], X2
    FMOV  D12, X15
    FMOV  V12.D[1], X2
    FMOV  D13, X7
    FMOV  V13.D[1], X17
    FMOV  D14, X17
    FMOV  V14.D[1], X27
    FMOV  D15, X20
    FMOV  V15.D[1], X14
    FMOV  D16, X25
    FMOV  V16.D[1], X5
    FMOV  D17, X14
    FMOV  V17.D[1], X10
    FMOV  D18, X5
    FMOV  V18.D[1], X28
    FMOV  D19, X10
    FMOV  V19.D[1], X4
    FMOV  D20, X26
    FMOV  V20.D[1], X27
    FMOV  D21, X7
    FMOV  V21.D[1], X26
    FMOV  D22, X27
    FMOV  V22.D[1], X16
    FMOV  D23, X27
    FMOV  V23.D[1], X20
    FMOV  D24, X21
    FMOV  V24.D[1], X10
    FMOV  D25, X27
    FMOV  V25.D[1], X16
    FMOV  D26, X5
    FMOV  V26.D[1], X8
    FMOV  D27, X18
    FMOV  V27.D[1], X14
    FMOV  D28, X15
    FMOV  V28.D[1], X6
    FMOV  D29, X22
    FMOV  V29.D[1], X25
    FMOV  D30, X27
    FMOV  V30.D[1], X7
    FMOV  D31, X16
    FMOV  V31.D[1], X27
    MOVZ  X5, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_3:
    FCVTMS  S13, S30
    FCVTMS  S30, S20
    FCVTZS H9, H21, #15
    FCVTZU  D0, D9
    FCVTMU  S28, S0
    FCVTMS  S26, S25
    FCVTPS  S19, S29
    FCVTAU  S12, S22
    FCVTNU  H27, H24
    FCVTAU  D18, D31
    FCVTAU  D9, D13
    FCVTNU  S5, S30
    FCVTZU H23, H26, #5
    FCVTAS  S26, S23
    FCVTPS  D25, D27
    FCVTZS  H0, H12
    FCVTNU  H15, H0
    FCVTMS  H9, H19
    FCVTZS H30, H9, #16
    FCVTMU  H30, H15
    FCVTAS  D24, D5
    FCVTXN  S7, D18
    FCVTPS  H20, H24
    FCVTZS D5, D30, #1
    FCVTPS  S29, S5
    FCVTZU  H31, H29
    FCVTNS  H0, H7
    FCVTAU  S21, S26
    FCVTZS  S26, S31
    FCVTZS  S19, S25
    FCVTNS  H25, H19
    FCVTPS  S5, S20
    FCVTZS  H24, H0
    FCVTZU  H7, H5
    FCVTAS  D9, D21
    FCVTMS  S18, S25
    FCVTPS  D23, D7
    FCVTZU D19, D23, #21
    FCVTNU  D7, D24
    FCVTNU  D29, D19
    FCVTXN  S24, D18
    FCVTMU  S31, S7
    FCVTZU  D27, D26
    FCVTZS D20, D27, #8
    FCVTAS  S5, S24
    FCVTZS  D26, D29
    FCVTXN  S29, D22
    FCVTMS  H23, H31
    FCVTZS H7, H9, #13
    FCVTPU  S15, S5
    FCVTNS  S0, S15
    FCVTZS H22, H0, #8
    FCVTZS  H18, H7
    FCVTAU  H19, H20
    FCVTMS  S20, S26
    FCVTPS  D9, D20
    FCVTNS  D26, D29
    FCVTNS  H21, H26
    FCVTNS  S26, S23
    FCVTZS D24, D21, #36
    FCVTMS  D27, D24
    FCVTZU  H21, H0
    FCVTAS  H29, H27
    FCVTNU  H7, H29
    FCVTAS  S20, S7
    FCVTMU  D23, D20
    FCVTMU  S24, S21
    FCVTZU  S20, S23
    FCVTAS  H21, H9
    FCVTZU D23, D26, #63
    FCVTZU D9, D24, #41
    FCVTZU  H29, H20
    FCVTMU  H24, H19
    FCVTPU  D0, D24
    FCVTMS  S27, S29
    FCVTMU  H29, H21
    FCVTMU  D21, D29
    FCVTAS  D20, D21
    FCVTMU  S21, S18
    FCVTMU  S29, S23
    FCVTPU  D19, D29
    FCVTPU  D26, D22
    FCVTZU H24, H21, #11
    FCVTPS  H21, H28
    FCVTZU S29, S27, #31
    FCVTAS  S18, S20
    FCVTAU  S23, S9
    FCVTMU  H22, H19
    FCVTPU  H28, H24
    FCVTAS  H20, H21
    FCVTNS  D24, D0
    FCVTPS  S0, S18
    FCVTPS  H19, H13
    FCVTPU  S18, S26
    FCVTZS S26, S29, #26
    FCVTZS  S13, S23
    FCVTZU H23, H28, #7
    FCVTMU  H9, H26
    FCVTZU  D27, D9
    FCVTNS  D21, D22
    FCVTPS  S29, S27
    FCVTAS  H27, H29
    FCVTNU  S22, S24
    FCVTZU  H24, H27
    FCVTAU  H27, H14
    FCVTZS H29, H0, #5
    FCVTNS  H28, H13
    FCVTZU S9, S28, #2
    FCVTZU  S14, S19
    FCVTZU D26, D20, #44
    FCVTZS  D0, D26
    FCVTZU  D26, D27
    FCVTZU S27, S24, #31
    FCVTAS  H24, H0
    FCVTPS  H0, H9
    FCVTNU  D13, D24
    FCVTAU  S24, S0
    FCVTZU  H0, H29
    FCVTNU  D28, D27
    FCVTPS  D9, D28
    FCVTPU  S28, S13
    FCVTAU  S13, S9
    FCVTAS  S29, S22
    FCVTMS  D9, D24
    FCVTAU  H27, H0
    FCVTZU H0, H27, #15
    FCVTPU  H20, H14
    FCVTAU  H22, H13
    FCVTMU  D24, D26
    FCVTZU H27, H21, #4
    FCVTPS  H21, H27
    FCVTPS  H26, H8
    FCVTNS  S8, S21
    FCVTPU  H21, H0
    FCVTPS  S0, S24
    FCVTMS  H19, H0
    FCVTPS  D0, D29
    FCVTPU  D13, D28
    FCVTMS  H24, H21
    FCVTZU D29, D22, #22
    FCVTPU  H27, H13
    FCVTMS  H14, H20
    FCVTMS  H21, H8
    FCVTNU  H22, H26
    FCVTNS  S28, S0
    FCVTZS D8, D19, #48
    FCVTMS  S19, S14
    FCVTPU  H20, H22
    FCVTZU H22, H24, #6
    FCVTPU  H13, H29
    FCVTNS  D0, D9
    FCVTPU  D9, D13
    FCVTPU  D29, D20
    FCVTMU  S13, S19
    FCVTNS  S26, S9
    FCVTZU H24, H29, #5
    FCVTZU S3, S24, #9
    FCVTPU  S14, S8
    FCVTZU H19, H21, #6
    FCVTZS S8, S22, #7
    FCVTAU  S20, S27
    FCVTAS  S9, S14
    FCVTAS  H21, H8
    FCVTZU  S29, S13
    FCVTMU  D13, D3
    FCVTMU  S14, S0
    FCVTMU  H0, H21
    FCVTAS  H27, H14
    FCVTZU H22, H28, #13
    FCVTXN  S24, D26
    FCVTAU  D8, D22
    FCVTZU  H22, H9
    FCVTZU H9, H22, #14
    FCVTAU  D22, D27
    FCVTZS  H3, H29
    FCVTNU  S26, S31
    FCVTMU  D21, D20
    FCVTAS  D14, D13
    FCVTNU  S28, S3
    FCVTZU  H31, H21
    FCVTAS  H21, H19
    FCVTPS  H3, H31
    FCVTAS  D31, D0
    FCVTNU  D13, D29
    FCVTZS H29, H24, #16
    FCVTZU H19, H28, #2
    FCVTNS  H20, H22
    FCVTNS  S22, S26
    FCVTNS  H0, H8
    FCVTAS  D26, D14
    FCVTPU  H14, H31
    FCVTAS  H2, H9
    FCVTPS  D27, D21
    FCVTMS  D24, D19
    FCVTZU  D28, D29
    FCVTAS  D14, D2
    FCVTPU  S19, S24
    FCVTAS  H8, H0
    FCVTZS  D9, D8
    FCVTZU D8, D22, #39
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_3
    MOVZ  X18, #0x9ca2, LSL #0
    MOVK  X18, #0x5696, LSL #16
    MOVK  X18, #0xea43, LSL #32
    MOVK  X18, #0x9cdc, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xa20f, LSL #0
    MOVK  X18, #0x65e7, LSL #16
    MOVK  X18, #0xcfd4, LSL #32
    MOVK  X18, #0x933e, LSL #48
    SUB  X19, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x7077, LSL #0
    MOVK  X18, #0xe3bf, LSL #16
    MOVK  X18, #0x300a, LSL #32
    MOVK  X18, #0xd2e9, LSL #48
    SUB  X19, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xb34e, LSL #0
    MOVK  X18, #0xe651, LSL #16
    MOVK  X18, #0xf5da, LSL #32
    MOVK  X18, #0x54c4, LSL #48
    SUB  X19, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x4e69, LSL #0
    MOVK  X18, #0x3741, LSL #16
    MOVK  X18, #0x1c78, LSL #32
    MOVK  X18, #0x74b3, LSL #48
    SUB  X19, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x1972, LSL #0
    MOVK  X18, #0x4727, LSL #16
    MOVK  X18, #0xfe9d, LSL #32
    MOVK  X18, #0x6015, LSL #48
    SUB  X19, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x637a, LSL #0
    MOVK  X18, #0xc41b, LSL #16
    MOVK  X18, #0x1794, LSL #32
    MOVK  X18, #0xdbc8, LSL #48
    SUB  X19, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x92e4, LSL #0
    MOVK  X18, #0xc168, LSL #16
    MOVK  X18, #0xa348, LSL #32
    MOVK  X18, #0x50e7, LSL #48
    SUB  X19, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x3dec, LSL #0
    MOVK  X18, #0x304d, LSL #16
    MOVK  X18, #0xab0c, LSL #32
    MOVK  X18, #0xc801, LSL #48
    SUB  X19, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x8367, LSL #0
    MOVK  X18, #0xc366, LSL #16
    MOVK  X18, #0x668, LSL #32
    MOVK  X18, #0xb159, LSL #48
    SUB  X19, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xa707, LSL #0
    MOVK  X18, #0x8, LSL #16
    MOVK  X18, #0x64ba, LSL #32
    MOVK  X18, #0xd831, LSL #48
    SUB  X19, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x670f, LSL #0
    MOVK  X18, #0x490a, LSL #16
    MOVK  X18, #0x4b9a, LSL #32
    MOVK  X18, #0xb45e, LSL #48
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xea8a, LSL #0
    MOVK  X18, #0xce5c, LSL #16
    MOVK  X18, #0x514, LSL #32
    MOVK  X18, #0x1a5b, LSL #48
    SUB  X19, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x65f4, LSL #0
    MOVK  X18, #0x76d9, LSL #16
    MOVK  X18, #0x2109, LSL #32
    MOVK  X18, #0x30b3, LSL #48
    SUB  X19, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x1a49, LSL #0
    MOVK  X18, #0x22bb, LSL #16
    MOVK  X18, #0xc594, LSL #32
    MOVK  X18, #0x9929, LSL #48
    SUB  X19, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x7270, LSL #0
    MOVK  X18, #0x8ab8, LSL #16
    MOVK  X18, #0x5ede, LSL #32
    MOVK  X18, #0xad8, LSL #48
    SUB  X19, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x1f97, LSL #0
    MOVK  X18, #0x1c71, LSL #16
    MOVK  X18, #0x346b, LSL #32
    MOVK  X18, #0xeb03, LSL #48
    SUB  X19, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xdf48, LSL #0
    MOVK  X18, #0x81fa, LSL #16
    MOVK  X18, #0x27c, LSL #32
    MOVK  X18, #0x2028, LSL #48
    SUB  X19, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xf3b2, LSL #0
    MOVK  X18, #0x7068, LSL #16
    MOVK  X18, #0xe0ff, LSL #32
    MOVK  X18, #0x6028, LSL #48
    SUB  X19, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x6bc3, LSL #0
    MOVK  X18, #0xec16, LSL #16
    MOVK  X18, #0xeee6, LSL #32
    MOVK  X18, #0x1690, LSL #48
    SUB  X19, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x99, LSL #0
    MRS  X19, FPSR
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D0
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xdf48, LSL #0
    MOVK  X18, #0x81fa, LSL #16
    MOVK  X18, #0x27c, LSL #32
    MOVK  X18, #0x2028, LSL #48
    FMOV  X19, V1.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x3f4e, LSL #0
    MOVK  X18, #0xc48e, LSL #16
    MOVK  X18, #0x103a, LSL #32
    MOVK  X18, #0xfe74, LSL #48
    FMOV  X19, D1
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V2.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D2
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V3.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D3
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x3dec, LSL #0
    MOVK  X18, #0x304d, LSL #16
    MOVK  X18, #0xab0c, LSL #32
    MOVK  X18, #0xc801, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x3f4e, LSL #0
    MOVK  X18, #0xc48e, LSL #16
    MOVK  X18, #0x103a, LSL #32
    MOVK  X18, #0xfe74, LSL #48
    FMOV  X19, D4
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V5.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D5
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xa20f, LSL #0
    MOVK  X18, #0x65e7, LSL #16
    MOVK  X18, #0xcfd4, LSL #32
    MOVK  X18, #0x933e, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x637a, LSL #0
    MOVK  X18, #0xc41b, LSL #16
    MOVK  X18, #0x1794, LSL #32
    MOVK  X18, #0xdbc8, LSL #48
    FMOV  X19, D6
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D7
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D8
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D9
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xa2dd, LSL #0
    MOVK  X18, #0xabcf, LSL #16
    MOVK  X18, #0xa44d, LSL #32
    MOVK  X18, #0x907f, LSL #48
    FMOV  X19, V10.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x9ca2, LSL #0
    MOVK  X18, #0x5696, LSL #16
    MOVK  X18, #0xea43, LSL #32
    MOVK  X18, #0x9cdc, LSL #48
    FMOV  X19, D10
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x9ca2, LSL #0
    MOVK  X18, #0x5696, LSL #16
    MOVK  X18, #0xea43, LSL #32
    MOVK  X18, #0x9cdc, LSL #48
    FMOV  X19, V11.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xf3b2, LSL #0
    MOVK  X18, #0x7068, LSL #16
    MOVK  X18, #0xe0ff, LSL #32
    MOVK  X18, #0x6028, LSL #48
    FMOV  X19, D11
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D12
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V13.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D13
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V14.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D14
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D15
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xf2b8, LSL #0
    MOVK  X18, #0x6a5c, LSL #16
    MOVK  X18, #0xf5fb, LSL #32
    MOVK  X18, #0x2c8a, LSL #48
    FMOV  X19, V16.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x3f4e, LSL #0
    MOVK  X18, #0xc48e, LSL #16
    MOVK  X18, #0x103a, LSL #32
    MOVK  X18, #0xfe74, LSL #48
    FMOV  X19, D16
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x637a, LSL #0
    MOVK  X18, #0xc41b, LSL #16
    MOVK  X18, #0x1794, LSL #32
    MOVK  X18, #0xdbc8, LSL #48
    FMOV  X19, V17.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x8367, LSL #0
    MOVK  X18, #0xc366, LSL #16
    MOVK  X18, #0x668, LSL #32
    MOVK  X18, #0xb159, LSL #48
    FMOV  X19, D17
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V18.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D18
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V19.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D19
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D20
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V21.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D21
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V22.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D22
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V23.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D23
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V24.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D24
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V25.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D25
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D26
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V27.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D27
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V28.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D28
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V29.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D29
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D30
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X19, D31
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X17
    FMOV  V0.D[1], X16
    FMOV  D1, X21
    FMOV  V1.D[1], X13
    FMOV  D2, X4
    FMOV  V2.D[1], X19
    FMOV  D3, X27
    FMOV  V3.D[1], X20
    FMOV  D4, X25
    FMOV  V4.D[1], X22
    FMOV  D5, X18
    FMOV  V5.D[1], X26
    FMOV  D6, X15
    FMOV  V6.D[1], X14
    FMOV  D7, X28
    FMOV  V7.D[1], X6
    FMOV  D8, X29
    FMOV  V8.D[1], X22
    FMOV  D9, X4
    FMOV  V9.D[1], X19
    FMOV  D10, X13
    FMOV  V10.D[1], X5
    FMOV  D11, X21
    FMOV  V11.D[1], X16
    FMOV  D12, X17
    FMOV  V12.D[1], X5
    FMOV  D13, X2
    FMOV  V13.D[1], X14
    FMOV  D14, X26
    FMOV  V14.D[1], X2
    FMOV  D15, X6
    FMOV  V15.D[1], X15
    FMOV  D16, X17
    FMOV  V16.D[1], X25
    FMOV  D17, X6
    FMOV  V17.D[1], X6
    FMOV  D18, X14
    FMOV  V18.D[1], X28
    FMOV  D19, X17
    FMOV  V19.D[1], X15
    FMOV  D20, X9
    FMOV  V20.D[1], X7
    FMOV  D21, X10
    FMOV  V21.D[1], X9
    FMOV  D22, X27
    FMOV  V22.D[1], X27
    FMOV  D23, X16
    FMOV  V23.D[1], X4
    FMOV  D24, X26
    FMOV  V24.D[1], X25
    FMOV  D25, X13
    FMOV  V25.D[1], X29
    FMOV  D26, X9
    FMOV  V26.D[1], X12
    FMOV  D27, X12
    FMOV  V27.D[1], X29
    FMOV  D28, X13
    FMOV  V28.D[1], X27
    FMOV  D29, X12
    FMOV  V29.D[1], X20
    FMOV  D30, X20
    FMOV  V30.D[1], X13
    FMOV  D31, X7
    FMOV  V31.D[1], X17
    MOVZ  X8, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_4:
    FCVTZU S21, S26, #10
    FCVTMS  S9, S30
    FCVTNS  H15, H21
    FCVTPS  D22, D20
    FCVTAS  S21, S29
    FCVTPS  S16, S28
    FCVTXN  S1, D23
    FCVTAU  D12, D27
    FCVTZS D21, D25, #5
    FCVTMS  H11, H21
    FCVTZS  H27, H24
    FCVTNS  D24, D11
    FCVTZS H25, H31, #9
    FCVTNU  S0, S9
    FCVTZU H25, H16, #6
    FCVTXN  S0, D27
    FCVTAU  S20, S15
    FCVTZS  H11, H20
    FCVTZU S18, S0, #31
    FCVTZS S10, S24, #27
    FCVTZU  S15, S10
    FCVTPS  D28, D18
    FCVTNU  H27, H12
    FCVTAU  D19, D2
    FCVTAS  H21, H19
    FCVTZS S18, S1, #26
    FCVTMS  S20, S15
    FCVTAS  S15, S11
    FCVTNS  D31, D27
    FCVTMS  D9, D22
    FCVTPS  H30, H20
    FCVTZS  H11, H30
    FCVTNU  H1, H28
    FCVTZU S28, S15, #16
    FCVTMU  D24, D21
    FCVTZU S12, S24, #18
    FCVTMU  D30, D18
    FCVTZS  D2, D25
    FCVTZS  S27, S31
    FCVTZS  D10, D2
    FCVTZU  S21, S27
    FCVTMS  D25, D1
    FCVTXN  S19, D30
    FCVTPU  H30, H10
    FCVTMU  D16, D28
    FCVTPU  S22, S21
    FCVTZU  H21, H25
    FCVTAS  S31, S9
    FCVTZS H24, H10, #7
    FCVTPU  H27, H30
    FCVTZS D30, D16, #13
    FCVTMS  D16, D19
    FCVTAS  H25, H27
    FCVTPS  S27, S21
    FCVTAU  S21, S24
    FCVTXN  S15, D16
    FCVTAS  D20, D21
    FCVTNS  D19, D25
    FCVTZU  S28, S15
    FCVTNU  H16, H28
    FCVTNU  S10, S12
    FCVTNS  S9, S22
    FCVTZU  H22, H30
    FCVTZS  D30, D22
    FCVTNU  D22, D30
    FCVTNU  D21, D20
    FCVTNU  D15, D19
    FCVTZS  S1, S7
    FCVTNS  H12, H15
    FCVTPS  D25, D9
    FCVTZU D20, D10, #55
    FCVTNS  D28, D27
    FCVTNS  D27, D28
    FCVTZU  S30, S22
    FCVTAS  D15, D30
    FCVTMU  H22, H1
    FCVTAU  D9, D25
    FCVTMU  H19, H16
    FCVTNU  S16, S22
    FCVTPS  S22, S27
    FCVTAU  S10, S15
    FCVTAU  S27, S20
    FCVTZU  S25, S12
    FCVTZS H12, H9, #10
    FCVTZU S9, S30, #32
    FCVTPS  H1, H25
    FCVTAU  S17, S1
    FCVTNU  S7, S9
    FCVTZS  H15, H27
    FCVTZU  D27, D22
    FCVTPU  D28, D27
    FCVTNU  S20, S19
    FCVTZS S22, S28, #3
    FCVTZS D28, D12, #49
    FCVTAU  D30, D22
    FCVTZU S12, S28, #30
    FCVTMS  H26, H7
    FCVTZU S27, S12, #32
    FCVTPU  S1, S26
    FCVTZS  D28, D15
    FCVTMU  D9, D30
    FCVTZS H30, H9, #8
    FCVTPS  S19, S17
    FCVTZS  D17, D19
    FCVTZU  H9, H30
    FCVTMS  D25, D17
    FCVTPU  D19, D20
    FCVTNS  D22, D16
    FCVTZS  H15, H27
    FCVTZS  H20, H15
    FCVTMU  S12, S9
    FCVTPU  D7, D25
    FCVTMU  S26, S11
    FCVTAS  S11, S28
    FCVTZU  S30, S11
    FCVTPU  H9, H26
    FCVTNU  H26, H30
    FCVTZS S16, S19, #28
    FCVTZU  D19, D7
    FCVTZS  H0, H12
    FCVTZS  H12, H22
    FCVTNS  H28, H26
    FCVTMU  S25, S0
    FCVTZU  D15, D9
    FCVTPS  H17, H16
    FCVTAU  D30, D20
    FCVTMU  S27, S1
    FCVTNS  H1, H28
    FCVTPU  D0, D12
    FCVTMU  H12, H30
    FCVTMS  H11, H17
    FCVTPU  S7, S1
    FCVTNS  S22, S19
    FCVTNU  D9, D12
    FCVTPU  S12, S27
    FCVTNU  H30, H12
    FCVTZS H28, H15, #12
    FCVTZU  H20, H25
    FCVTPS  S25, S28
    FCVTPS  S19, S7
    FCVTMS  S17, S19
    FCVTMS  H26, H9
    FCVTNU  H16, H26
    FCVTMS  S19, S25
    FCVTZU D1, D16, #27
    FCVTZU H16, H0, #13
    FCVTZU D7, D22, #54
    FCVTAS  H15, H7
    FCVTAS  S3, S1
    FCVTXN  S25, D16
    FCVTMU  S28, S15
    FCVTZS H27, H11, #9
    FCVTPU  D7, D30
    FCVTZU  D0, D27
    FCVTPS  H18, H17
    FCVTZU D17, D19, #22
    FCVTAS  S27, S20
    FCVTPS  D9, D27
    FCVTZS  S11, S3
    FCVTNS  S15, S17
    FCVTPS  D26, D18
    FCVTNU  D19, D11
    FCVTAS  S1, S19
    FCVTMU  D11, D28
    FCVTZU  S27, S25
    FCVTNS  S30, S1
    FCVTMS  D17, D11
    FCVTZU  H18, H30
    FCVTAU  H25, H17
    FCVTMU  D28, D15
    FCVTAU  D17, D18
    FCVTAS  D20, D17
    FCVTAS  D11, D7
    FCVTMU  S7, S9
    FCVTMU  S15, S26
    FCVTNU  H9, H11
    FCVTMS  H18, H9
    FCVTNU  H16, H7
    FCVTMU  D11, D15
    FCVTXN  S9, D27
    FCVTZU S17, S0, #20
    FCVTAS  S3, S18
    FCVTPU  D27, D3
    FCVTXN  S30, D28
    FCVTZS  H26, H20
    FCVTAU  D3, D26
    FCVTNU  S1, S17
    FCVTZU H7, H25, #11
    FCVTZS D19, D27, #28
    FCVTZU D27, D19, #45
    FCVTNU  D19, D3
    FCVTZU S18, S27, #10
    FCVTZU  H0, H30
    FCVTPS  S15, S23
    FCVTAU  D28, D30
    FCVTPS  D20, D0
    FCVTMS  D26, D19
    FCVTAU  S17, S28
    FCVTAU  D25, D20
    FCVTMS  S20, S26
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_4
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x99, LSL #0
    MRS  X25, FPSR
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D5
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D24
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X10, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X8
    FMOV  V3.D[1], X29
    FMOV  D4, X8
    FMOV  V4.D[1], X28
    FMOV  D5, X29
    FMOV  V5.D[1], X7
    FMOV  D6, X15
    FMOV  V6.D[1], X22
    FMOV  D7, X9
    FMOV  V7.D[1], X2
    FMOV  D8, X27
    FMOV  V8.D[1], X8
    FMOV  D9, X4
    FMOV  V9.D[1], X7
    FMOV  D10, X25
    FMOV  V10.D[1], X18
    FMOV  D11, X5
    FMOV  V11.D[1], X13
    FMOV  D12, X20
    FMOV  V12.D[1], X8
    FMOV  D13, X29
    FMOV  V13.D[1], X28
    FMOV  D14, X21
    FMOV  V14.D[1], X28
    FMOV  D15, X28
    FMOV  V15.D[1], X20
    FMOV  D16, X6
    FMOV  V16.D[1], X16
    FMOV  D17, X26
    FMOV  V17.D[1], X28
    FMOV  D18, X8
    FMOV  V18.D[1], X19
    FMOV  D19, X18
    FMOV  V19.D[1], X5
    FMOV  D20, X22
    FMOV  V20.D[1], X4
    FMOV  D21, X21
    FMOV  V21.D[1], X29
    FMOV  D22, X27
    FMOV  V22.D[1], X2
    FMOV  D23, X2
    FMOV  V23.D[1], X13
    FMOV  D24, X14
    FMOV  V24.D[1], X27
    FMOV  D25, X29
    FMOV  V25.D[1], X22
    FMOV  D26, X21
    FMOV  V26.D[1], X20
    FMOV  D27, X21
    FMOV  V27.D[1], X16
    FMOV  D28, X5
    FMOV  V28.D[1], X9
    FMOV  D29, X9
    FMOV  V29.D[1], X9
    FMOV  D30, X20
    FMOV  V30.D[1], X15
    FMOV  D31, X14
    FMOV  V31.D[1], X27
    MOVZ  X6, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_5:
    FCVTZU S23, S24, #17
    FCVTNS  S9, S25
    FCVTMU  D11, D19
    FCVTPS  S18, S29
    FCVTPU  D1, D23
    FCVTPS  S4, S22
    FCVTZU  S5, S20
    FCVTPU  H15, H18
    FCVTZU  H19, H1
    FCVTZS  S10, S9
    FCVTZS D31, D10, #9
    FCVTPU  S31, S27
    FCVTZS  S12, S4
    FCVTNS  S22, S5
    FCVTAU  H11, H11
    FCVTZS H1, H12, #7
    FCVTZS  D30, D15
    FCVTMU  D11, D30
    FCVTMS  S14, S11
    FCVTMS  S24, S1
    FCVTAU  H30, H19
    FCVTPS  D29, D24
    FCVTPU  S25, S30
    FCVTAU  D10, D31
    FCVTMU  S9, S25
    FCVTPU  H5, H9
    FCVTZU D27, D14, #56
    FCVTZS H4, H0, #9
    FCVTMU  D19, D4
    FCVTMU  S4, S19
    FCVTPS  H12, H5
    FCVTXN  S1, D22
    FCVTAU  H11, H12
    FCVTNU  D12, D29
    FCVTAU  S5, S12
    FCVTZU  D15, D10
    FCVTNU  D25, D4
    FCVTNS  H29, H25
    FCVTNS  H22, H11
    FCVTPU  D31, D15
    FCVTZS  H11, H1
    FCVTMU  S12, S27
    FCVTMU  D25, D31
    FCVTMU  H15, H29
    FCVTPS  H19, H15
    FCVTMU  S27, S19
    FCVTMS  D10, D22
    FCVTZS H15, H11, #9
    FCVTPS  S11, S25
    FCVTZS  H22, H12
    FCVTAS  D19, D27
    FCVTPU  D4, D5
    FCVTZS  S31, S10
    FCVTMS  D29, D22
    FCVTNS  S12, S29
    FCVTZS  H29, H12
    FCVTAS  H1, H4
    FCVTPS  S22, S11
    FCVTAS  S4, S15
    FCVTZS  S15, S1
    FCVTMS  S1, S22
    FCVTXN  S10, D15
    FCVTNS  D25, D29
    FCVTZU H4, H3, #6
    FCVTNU  S27, S25
    FCVTZU D3, D19, #18
    FCVTNU  D15, D31
    FCVTZS  S12, S27
    FCVTNS  S5, S1
    FCVTAU  D11, D5
    FCVTNS  S19, S10
    FCVTPS  S22, S6
    FCVTPU  S6, S3
    FCVTXN  S10, D12
    FCVTNS  S25, S2
    FCVTZU  H5, H28
    FCVTXN  S29, D4
    FCVTAU  H2, H25
    FCVTZU  H25, H11
    FCVTPU  D11, D19
    FCVTPU  H31, H11
    FCVTMS  D12, D5
    FCVTAS  S11, S25
    FCVTMU  S27, S11
    FCVTZS D13, D22, #39
    FCVTXN  S3, D15
    FCVTMS  D19, D6
    FCVTAU  D6, D19
    FCVTNU  S5, S6
    FCVTPU  S28, S31
    FCVTZU D11, D29, #21
    FCVTPU  S31, S12
    FCVTMU  D12, D3
    FCVTNU  D29, D2
    FCVTPU  H22, H28
    FCVTZU S25, S29, #9
    FCVTMS  D15, D31
    FCVTMS  D2, D15
    FCVTZU D15, D11, #47
    FCVTPS  S6, S5
    FCVTAU  D19, D2
    FCVTZU  D3, D13
    FCVTNU  D5, D27
    FCVTZU  S11, S6
    FCVTMU  S6, S11
    FCVTAS  S13, S6
    FCVTZS  H27, H15
    FCVTMS  D2, D3
    FCVTNS  H3, H2
    FCVTZS H29, H3, #9
    FCVTPU  H19, H12
    FCVTAU  D3, D5
    FCVTZU  S6, S13
    FCVTPU  D21, D27
    FCVTPU  H5, H29
    FCVTNU  H15, H21
    FCVTNU  D27, D6
    FCVTAS  S28, S5
    FCVTMU  H29, H27
    FCVTPS  S11, S19
    FCVTMU  H5, H29
    FCVTZU  S29, S3
    FCVTAS  H31, H29
    FCVTZU S12, S22, #4
    FCVTZS  S22, S15
    FCVTPU  S2, S31
    FCVTZS D27, D12, #13
    FCVTZS  D3, D10
    FCVTAS  S29, S3
    FCVTZU H13, H22, #3
    FCVTZS S31, S27, #30
    FCVTZS  H10, H8
    FCVTPU  S15, S2
    FCVTZU  S12, S11
    FCVTZS  D3, D12
    FCVTPS  H6, H15
    FCVTNS  S22, S5
    FCVTXN  S11, D29
    FCVTAU  D12, D3
    FCVTAS  H19, H13
    FCVTNU  S15, S11
    FCVTZS H21, H15, #14
    FCVTZS  H13, H12
    FCVTAS  D12, D13
    FCVTAS  H3, H10
    FCVTZU  H10, H31
    FCVTNS  H11, H10
    FCVTPU  S15, S19
    FCVTAS  H8, H12
    FCVTNS  H31, H6
    FCVTAS  D5, D11
    FCVTZU S13, S7, #6
    FCVTZU  H10, H13
    FCVTMS  H27, H5
    FCVTZS H29, H22, #5
    FCVTZU  S22, S3
    FCVTNU  S2, S22
    FCVTNS  H7, H31
    FCVTPS  D31, D29
    FCVTZS  H29, H7
    FCVTMS  S6, S10
    FCVTZS H10, H29, #5
    FCVTAS  H13, H10
    FCVTMS  D3, D21
    FCVTAS  S29, S15
    FCVTMS  H7, H29
    FCVTAS  H5, H24
    FCVTNU  S11, S5
    FCVTZS S24, S27, #13
    FCVTNS  H5, H6
    FCVTZS  H6, H11
    FCVTNU  H10, H3
    FCVTZU  D21, D31
    FCVTZU  S27, S10
    FCVTAS  S11, S8
    FCVTMS  D22, D21
    FCVTZS  S3, S24
    FCVTZU H15, H6, #8
    FCVTMU  D10, D22
    FCVTPU  D21, D5
    FCVTAS  D31, D7
    FCVTZS H7, H31, #10
    FCVTPS  S8, S13
    FCVTMS  H31, H3
    FCVTAU  D3, D11
    FCVTMS  S6, S2
    FCVTZU  S22, S10
    FCVTAS  S13, S3
    FCVTAU  D5, D8
    FCVTZS  D24, D6
    FCVTMU  S6, S27
    FCVTPS  H2, H24
    FCVTMS  S8, S22
    FCVTAS  S3, S7
    FCVTMS  S10, S21
    FCVTZU H24, H13, #4
    FCVTZU  D13, D5
    FCVTNS  H22, H15
    FCVTAU  D27, D22
    FCVTZU  H11, H3
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_5
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X16, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x99, LSL #0
    MRS  X16, FPSR
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, D0
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D10
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, V16.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, D16
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, V17.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, D17
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, V20.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, D20
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, V26.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X16, D26
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X2, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x4020, LSL #0
    MOVK  X2, #0x580e, LSL #16
    MOVK  X2, #0xb0b0, LSL #32
    MOVK  X2, #0x59ce, LSL #48
    MOVZ  X4, #0x98c0, LSL #0
    MOVK  X4, #0xba39, LSL #16
    MOVK  X4, #0xebe9, LSL #32
    MOVK  X4, #0xa30c, LSL #48
    MOVZ  X5, #0xc928, LSL #0
    MOVK  X5, #0xbb75, LSL #16
    MOVK  X5, #0xedcd, LSL #32
    MOVK  X5, #0xf158, LSL #48
    MOVZ  X6, #0xa686, LSL #0
    MOVK  X6, #0x9b9a, LSL #16
    MOVK  X6, #0x5eb0, LSL #32
    MOVK  X6, #0x8bb3, LSL #48
    MOVZ  X7, #0xaded, LSL #0
    MOVK  X7, #0x40f4, LSL #16
    MOVK  X7, #0x1996, LSL #32
    MOVK  X7, #0x8e60, LSL #48
    MOVZ  X8, #0x34af, LSL #0
    MOVK  X8, #0x7ca, LSL #16
    MOVK  X8, #0x1c28, LSL #32
    MOVK  X8, #0x527a, LSL #48
    MOVZ  X9, #0x7167, LSL #0
    MOVK  X9, #0x4044, LSL #16
    MOVK  X9, #0xd25, LSL #32
    MOVK  X9, #0x2c63, LSL #48
    MOVZ  X10, #0x70e9, LSL #0
    MOVK  X10, #0xf2db, LSL #16
    MOVK  X10, #0xc431, LSL #32
    MOVK  X10, #0x9f06, LSL #48
    MOVZ  X12, #0x902e, LSL #0
    MOVK  X12, #0x4dbf, LSL #16
    MOVK  X12, #0xbad9, LSL #32
    MOVK  X12, #0x518, LSL #48
    MOVZ  X13, #0x3f98, LSL #0
    MOVK  X13, #0xacc4, LSL #16
    MOVK  X13, #0xeea4, LSL #32
    MOVK  X13, #0x80af, LSL #48
    MOVZ  X14, #0x8740, LSL #0
    MOVK  X14, #0x304f, LSL #16
    MOVK  X14, #0x83b6, LSL #32
    MOVK  X14, #0xec96, LSL #48
    MOVZ  X15, #0x849e, LSL #0
    MOVK  X15, #0x8535, LSL #16
    MOVK  X15, #0x172, LSL #32
    MOVK  X15, #0x24b4, LSL #48
    MOVZ  X16, #0x1671, LSL #0
    MOVK  X16, #0x752e, LSL #16
    MOVK  X16, #0xe2d1, LSL #32
    MOVK  X16, #0x7010, LSL #48
    MOVZ  X17, #0x2ca8, LSL #0
    MOVK  X17, #0xb786, LSL #16
    MOVK  X17, #0xa5f1, LSL #32
    MOVK  X17, #0xe3e9, LSL #48
    MOVZ  X18, #0x5323, LSL #0
    MOVK  X18, #0x488b, LSL #16
    MOVK  X18, #0x3575, LSL #32
    MOVK  X18, #0xe696, LSL #48
    MOVZ  X19, #0x6fd1, LSL #0
    MOVK  X19, #0x9491, LSL #16
    MOVK  X19, #0x61db, LSL #32
    MOVK  X19, #0x49bd, LSL #48
    MOVZ  X20, #0x1068, LSL #0
    MOVK  X20, #0x21ac, LSL #16
    MOVK  X20, #0xeaff, LSL #32
    MOVK  X20, #0xff7b, LSL #48
    MOVZ  X21, #0xaf5, LSL #0
    MOVK  X21, #0xf7fb, LSL #16
    MOVK  X21, #0x3677, LSL #32
    MOVK  X21, #0xbf9e, LSL #48
    MOVZ  X22, #0xcaa1, LSL #0
    MOVK  X22, #0x4166, LSL #16
    MOVK  X22, #0xf7df, LSL #32
    MOVK  X22, #0x50fc, LSL #48
    MOVZ  X25, #0xeced, LSL #0
    MOVK  X25, #0x2e11, LSL #16
    MOVK  X25, #0x251b, LSL #32
    MOVK  X25, #0x40e7, LSL #48
    MOVZ  X26, #0x71d3, LSL #0
    MOVK  X26, #0x2b27, LSL #16
    MOVK  X26, #0xbf6f, LSL #32
    MOVK  X26, #0x4f07, LSL #48
    MOVZ  X27, #0xd4c3, LSL #0
    MOVK  X27, #0x8526, LSL #16
    MOVK  X27, #0x5005, LSL #32
    MOVK  X27, #0xb3a1, LSL #48
    MOVZ  X28, #0xfdf6, LSL #0
    MOVK  X28, #0xbc4f, LSL #16
    MOVK  X28, #0x1071, LSL #32
    MOVK  X28, #0x8259, LSL #48
    MOVZ  X29, #0xa396, LSL #0
    MOVK  X29, #0x9156, LSL #16
    MOVK  X29, #0x1e4, LSL #32
    MOVK  X29, #0x6bae, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X21
    FMOV  D2, X27
    FMOV  V2.D[1], X22
    FMOV  D3, X29
    FMOV  V3.D[1], X6
    FMOV  D4, X8
    FMOV  V4.D[1], X9
    FMOV  D5, X16
    FMOV  V5.D[1], X13
    FMOV  D6, X16
    FMOV  V6.D[1], X5
    FMOV  D7, X22
    FMOV  V7.D[1], X14
    FMOV  D8, X20
    FMOV  V8.D[1], X13
    FMOV  D9, X10
    FMOV  V9.D[1], X27
    FMOV  D10, X13
    FMOV  V10.D[1], X14
    FMOV  D11, X21
    FMOV  V11.D[1], X8
    FMOV  D12, X7
    FMOV  V12.D[1], X19
    FMOV  D13, X20
    FMOV  V13.D[1], X7
    FMOV  D14, X4
    FMOV  V14.D[1], X10
    FMOV  D15, X12
    FMOV  V15.D[1], X18
    FMOV  D16, X9
    FMOV  V16.D[1], X15
    FMOV  D17, X5
    FMOV  V17.D[1], X28
    FMOV  D18, X15
    FMOV  V18.D[1], X8
    FMOV  D19, X27
    FMOV  V19.D[1], X8
    FMOV  D20, X12
    FMOV  V20.D[1], X5
    FMOV  D21, X12
    FMOV  V21.D[1], X22
    FMOV  D22, X16
    FMOV  V22.D[1], X17
    FMOV  D23, X21
    FMOV  V23.D[1], X29
    FMOV  D24, X28
    FMOV  V24.D[1], X9
    FMOV  D25, X22
    FMOV  V25.D[1], X18
    FMOV  D26, X14
    FMOV  V26.D[1], X2
    FMOV  D27, X28
    FMOV  V27.D[1], X29
    FMOV  D28, X29
    FMOV  V28.D[1], X12
    FMOV  D29, X10
    FMOV  V29.D[1], X18
    FMOV  D30, X18
    FMOV  V30.D[1], X22
    FMOV  D31, X2
    FMOV  V31.D[1], X7
    MOVZ  X21, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_6:
    FCVTNS  H1, H20
    FCVTZS  D6, D30
    FCVTZU D15, D27, #6
    FCVTPU  D4, D23
    FCVTPU  D30, D25
    FCVTZU D29, D28, #33
    FCVTNS  D7, D15
    FCVTMU  H9, H26
    FCVTZU  S5, S4
    FCVTMU  H29, H29
    FCVTNU  D27, D22
    FCVTPU  H7, H27
    FCVTNU  D19, D9
    FCVTMU  D9, D30
    FCVTPU  H21, H31
    FCVTZU  H29, H6
    FCVTNS  D2, D1
    FCVTMU  H31, H21
    FCVTMU  S28, S19
    FCVTMU  D7, D28
    FCVTZS D29, D31, #46
    FCVTZU D1, D9, #43
    FCVTZS  D4, D5
    FCVTNU  D26, D7
    FCVTMU  D15, D19
    FCVTMS  S6, S4
    FCVTNU  H25, H29
    FCVTAS  D27, D2
    FCVTMU  D21, D1
    FCVTPS  H20, H6
    FCVTAU  D23, D26
    FCVTMS  H9, H27
    FCVTPU  D19, D15
    FCVTAU  S15, S19
    FCVTMU  H28, H15
    FCVTPU  H31, H23
    FCVTZS  D7, D25
    FCVTNU  H5, H9
    FCVTMS  S4, S28
    FCVTZS H28, H4, #3
    FCVTMU  H6, H21
    FCVTMS  D9, D6
    FCVTMS  H21, H28
    FCVTNU  S26, S9
    FCVTNU  S29, S31
    FCVTAS  H23, H20
    FCVTMU  H1, H29
    FCVTAU  D6, D26
    FCVTZU  S25, S26
    FCVTNU  D27, D5
    FCVTMS  D4, D1
    FCVTNU  S1, S21
    FCVTPS  S2, S23
    FCVTZS D21, D1, #57
    FCVTNS  H15, H7
    FCVTZS H23, H27, #2
    FCVTZS D1, D15, #20
    FCVTMS  S7, S1
    FCVTMU  H20, H23
    FCVTNU  S27, S8
    FCVTNU  D29, D24
    FCVTZS  S28, S20
    FCVTZU D15, D7, #23
    FCVTAU  S31, S27
    FCVTAS  D5, D4
    FCVTMS  S8, S28
    FCVTPS  H1, H5
    FCVTZU D28, D2, #11
    FCVTMU  D26, D29
    FCVTAS  H2, H6
    FCVTAU  H29, H31
    FCVTMS  H7, H1
    FCVTNU  H5, H26
    FCVTAS  H9, H7
    FCVTMS  H26, H15
    FCVTZU  D4, D8
    FCVTZS  S23, S9
    FCVTZU  S24, S29
    FCVTPU  H27, H28
    FCVTMU  S6, S26
    FCVTNU  S20, S4
    FCVTZU  D15, D6
    FCVTPU  H25, H15
    FCVTAS  H4, H2
    FCVTZS  H6, H5
    FCVTZS S8, S6, #11
    FCVTMU  D19, D25
    FCVTZU  D7, D19
    FCVTMS  D6, D7
    FCVTAS  S28, S4
    FCVTZS  D25, D20
    FCVTPS  S19, S27
    FCVTAS  S7, S6
    FCVTMS  S1, S8
    FCVTXN  S31, D24
    FCVTZU  S0, S23
    FCVTZU H9, H28, #5
    FCVTNS  D6, D7
    FCVTAU  D8, D25
    FCVTZU  H24, H8
    FCVTPU  H27, H6
    FCVTZS D29, D19, #51
    FCVTAU  D2, D0
    FCVTZU S25, S22, #10
    FCVTMS  S8, S1
    FCVTMU  S19, S31
    FCVTNU  H31, H9
    FCVTZU  H26, H31
    FCVTMU  S20, S27
    FCVTXN  S15, D20
    FCVTMU  S7, S19
    FCVTNS  D23, D24
    FCVTZS  H24, H26
    FCVTZU  H20, H15
    FCVTPU  H22, H25
    FCVTNU  D26, D8
    FCVTPU  S25, S24
    FCVTZS S24, S21, #13
    FCVTZU  S4, S25
    FCVTZU H6, H4, #16
    FCVTZU H27, H7, #7
    FCVTZU  D25, D23
    FCVTNS  D7, D6
    FCVTMU  D9, D29
    FCVTNU  S31, S9
    FCVTAU  D19, D25
    FCVTZU  D15, D22
    FCVTPS  H9, H7
    FCVTAU  S7, S19
    FCVTAU  S0, S15
    FCVTPU  D15, D26
    FCVTAS  S29, S0
    FCVTMS  D0, D7
    FCVTNU  H8, H29
    FCVTZS  D19, D15
    FCVTNU  D22, D0
    FCVTZU  D21, D24
    FCVTPU  S4, S20
    FCVTZS  S29, S31
    FCVTNU  S26, S21
    FCVTZU  H23, H22
    FCVTPS  D24, D9
    FCVTZS  H31, H4
    FCVTZS S25, S29, #2
    FCVTNS  S9, S8
    FCVTXN  S7, D25
    FCVTNS  S21, S31
    FCVTPU  S31, S26
    FCVTMU  H6, H9
    FCVTZS S4, S23, #10
    FCVTNU  H20, H19
    FCVTPS  S22, S7
    FCVTMS  H7, H21
    FCVTZS S0, S12, #22
    FCVTAS  D15, D11
    FCVTPS  H12, H7
    FCVTAS  H21, H6
    FCVTNS  S11, S24
    FCVTMU  D8, D31
    FCVTMS  S9, S21
    FCVTXN  S29, D9
    FCVTZS  H6, H15
    FCVTZS  S26, S11
    FCVTNS  S30, S4
    FCVTPS  H25, H0
    FCVTMU  S24, S25
    FCVTZU S19, S30, #10
    FCVTMU  D30, D22
    FCVTNU  D11, D26
    FCVTZS S25, S20, #21
    FCVTNS  D26, D24
    FCVTZS S24, S6, #17
    FCVTPS  H21, H25
    FCVTNS  H25, H26
    FCVTMU  D0, D11
    FCVTAU  D22, D0
    FCVTPS  S26, S12
    FCVTZU  S4, S29
    FCVTZU  D9, D8
    FCVTMU  D11, D21
    FCVTZS S6, S22, #18
    FCVTZS  S7, S30
    FCVTPU  D30, D6
    FCVTAU  H21, H7
    FCVTZU  S29, S21
    FCVTZU H7, H29, #12
    FCVTNU  S0, S30
    FCVTAU  D12, D26
    FCVTZU  S8, S24
    FCVTNS  D15, D12
    FCVTMU  H29, H11
    FCVTZU H11, H7, #5
    FCVTNU  S30, S19
    FCVTPU  H19, H0
    FCVTAU  S0, S8
    FCVTPS  H8, H25
    FCVTNS  D21, D15
    FCVTAU  D22, D9
    FCVTZS D7, D4, #49
    FCVTNS  D15, D29
    SUBS  X21, X21, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_6
    MOVZ  X27, #0x4020, LSL #0
    MOVK  X27, #0x580e, LSL #16
    MOVK  X27, #0xb0b0, LSL #32
    MOVK  X27, #0x59ce, LSL #48
    SUB  X9, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x98c0, LSL #0
    MOVK  X27, #0xba39, LSL #16
    MOVK  X27, #0xebe9, LSL #32
    MOVK  X27, #0xa30c, LSL #48
    SUB  X9, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xc928, LSL #0
    MOVK  X27, #0xbb75, LSL #16
    MOVK  X27, #0xedcd, LSL #32
    MOVK  X27, #0xf158, LSL #48
    SUB  X9, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xa686, LSL #0
    MOVK  X27, #0x9b9a, LSL #16
    MOVK  X27, #0x5eb0, LSL #32
    MOVK  X27, #0x8bb3, LSL #48
    SUB  X9, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xaded, LSL #0
    MOVK  X27, #0x40f4, LSL #16
    MOVK  X27, #0x1996, LSL #32
    MOVK  X27, #0x8e60, LSL #48
    SUB  X9, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x34af, LSL #0
    MOVK  X27, #0x7ca, LSL #16
    MOVK  X27, #0x1c28, LSL #32
    MOVK  X27, #0x527a, LSL #48
    SUB  X9, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x70e9, LSL #0
    MOVK  X27, #0xf2db, LSL #16
    MOVK  X27, #0xc431, LSL #32
    MOVK  X27, #0x9f06, LSL #48
    SUB  X9, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x902e, LSL #0
    MOVK  X27, #0x4dbf, LSL #16
    MOVK  X27, #0xbad9, LSL #32
    MOVK  X27, #0x518, LSL #48
    SUB  X9, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x3f98, LSL #0
    MOVK  X27, #0xacc4, LSL #16
    MOVK  X27, #0xeea4, LSL #32
    MOVK  X27, #0x80af, LSL #48
    SUB  X9, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x8740, LSL #0
    MOVK  X27, #0x304f, LSL #16
    MOVK  X27, #0x83b6, LSL #32
    MOVK  X27, #0xec96, LSL #48
    SUB  X9, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x1671, LSL #0
    MOVK  X27, #0x752e, LSL #16
    MOVK  X27, #0xe2d1, LSL #32
    MOVK  X27, #0x7010, LSL #48
    SUB  X9, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x2ca8, LSL #0
    MOVK  X27, #0xb786, LSL #16
    MOVK  X27, #0xa5f1, LSL #32
    MOVK  X27, #0xe3e9, LSL #48
    SUB  X9, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x5323, LSL #0
    MOVK  X27, #0x488b, LSL #16
    MOVK  X27, #0x3575, LSL #32
    MOVK  X27, #0xe696, LSL #48
    SUB  X9, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x6fd1, LSL #0
    MOVK  X27, #0x9491, LSL #16
    MOVK  X27, #0x61db, LSL #32
    MOVK  X27, #0x49bd, LSL #48
    SUB  X9, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x1068, LSL #0
    MOVK  X27, #0x21ac, LSL #16
    MOVK  X27, #0xeaff, LSL #32
    MOVK  X27, #0xff7b, LSL #48
    SUB  X9, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xcaa1, LSL #0
    MOVK  X27, #0x4166, LSL #16
    MOVK  X27, #0xf7df, LSL #32
    MOVK  X27, #0x50fc, LSL #48
    SUB  X9, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xeced, LSL #0
    MOVK  X27, #0x2e11, LSL #16
    MOVK  X27, #0x251b, LSL #32
    MOVK  X27, #0x40e7, LSL #48
    SUB  X9, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x71d3, LSL #0
    MOVK  X27, #0x2b27, LSL #16
    MOVK  X27, #0xbf6f, LSL #32
    MOVK  X27, #0x4f07, LSL #48
    SUB  X9, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xfdf6, LSL #0
    MOVK  X27, #0xbc4f, LSL #16
    MOVK  X27, #0x1071, LSL #32
    MOVK  X27, #0x8259, LSL #48
    SUB  X9, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xa396, LSL #0
    MOVK  X27, #0x9156, LSL #16
    MOVK  X27, #0x1e4, LSL #32
    MOVK  X27, #0x6bae, LSL #48
    SUB  X9, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x99, LSL #0
    MRS  X9, FPSR
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D0
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D1
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D2
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xa686, LSL #0
    MOVK  X27, #0x9b9a, LSL #16
    MOVK  X27, #0x5eb0, LSL #32
    MOVK  X27, #0x8bb3, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xa396, LSL #0
    MOVK  X27, #0x9156, LSL #16
    MOVK  X27, #0x1e4, LSL #32
    MOVK  X27, #0x6bae, LSL #48
    FMOV  X9, D3
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D4
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D5
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D6
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D7
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D9
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x8740, LSL #0
    MOVK  X27, #0x304f, LSL #16
    MOVK  X27, #0x83b6, LSL #32
    MOVK  X27, #0xec96, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x3f98, LSL #0
    MOVK  X27, #0xacc4, LSL #16
    MOVK  X27, #0xeea4, LSL #32
    MOVK  X27, #0x80af, LSL #48
    FMOV  X9, D10
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D11
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D12
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xaded, LSL #0
    MOVK  X27, #0x40f4, LSL #16
    MOVK  X27, #0x1996, LSL #32
    MOVK  X27, #0x8e60, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x1068, LSL #0
    MOVK  X27, #0x21ac, LSL #16
    MOVK  X27, #0xeaff, LSL #32
    MOVK  X27, #0xff7b, LSL #48
    FMOV  X9, D13
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x70e9, LSL #0
    MOVK  X27, #0xf2db, LSL #16
    MOVK  X27, #0xc431, LSL #32
    MOVK  X27, #0x9f06, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x98c0, LSL #0
    MOVK  X27, #0xba39, LSL #16
    MOVK  X27, #0xebe9, LSL #32
    MOVK  X27, #0xa30c, LSL #48
    FMOV  X9, D14
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D15
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x849e, LSL #0
    MOVK  X27, #0x8535, LSL #16
    MOVK  X27, #0x172, LSL #32
    MOVK  X27, #0x24b4, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x7167, LSL #0
    MOVK  X27, #0x4044, LSL #16
    MOVK  X27, #0xd25, LSL #32
    MOVK  X27, #0x2c63, LSL #48
    FMOV  X9, D16
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xfdf6, LSL #0
    MOVK  X27, #0xbc4f, LSL #16
    MOVK  X27, #0x1071, LSL #32
    MOVK  X27, #0x8259, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0xc928, LSL #0
    MOVK  X27, #0xbb75, LSL #16
    MOVK  X27, #0xedcd, LSL #32
    MOVK  X27, #0xf158, LSL #48
    FMOV  X9, D17
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x34af, LSL #0
    MOVK  X27, #0x7ca, LSL #16
    MOVK  X27, #0x1c28, LSL #32
    MOVK  X27, #0x527a, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x849e, LSL #0
    MOVK  X27, #0x8535, LSL #16
    MOVK  X27, #0x172, LSL #32
    MOVK  X27, #0x24b4, LSL #48
    FMOV  X9, D18
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D19
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D20
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D21
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D22
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D23
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D24
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D25
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D26
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D27
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D28
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D29
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D30
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, D31
    SUB  X15, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X9
    FMOV  V0.D[1], X16
    FMOV  D1, X10
    FMOV  V1.D[1], X19
    FMOV  D2, X15
    FMOV  V2.D[1], X20
    FMOV  D3, X26
    FMOV  V3.D[1], X29
    FMOV  D4, X28
    FMOV  V4.D[1], X8
    FMOV  D5, X18
    FMOV  V5.D[1], X21
    FMOV  D6, X22
    FMOV  V6.D[1], X14
    FMOV  D7, X25
    FMOV  V7.D[1], X13
    FMOV  D8, X27
    FMOV  V8.D[1], X9
    FMOV  D9, X6
    FMOV  V9.D[1], X16
    FMOV  D10, X2
    FMOV  V10.D[1], X2
    FMOV  D11, X13
    FMOV  V11.D[1], X28
    FMOV  D12, X17
    FMOV  V12.D[1], X10
    FMOV  D13, X14
    FMOV  V13.D[1], X18
    FMOV  D14, X13
    FMOV  V14.D[1], X9
    FMOV  D15, X2
    FMOV  V15.D[1], X15
    FMOV  D16, X7
    FMOV  V16.D[1], X22
    FMOV  D17, X25
    FMOV  V17.D[1], X6
    FMOV  D18, X9
    FMOV  V18.D[1], X15
    FMOV  D19, X2
    FMOV  V19.D[1], X29
    FMOV  D20, X25
    FMOV  V20.D[1], X26
    FMOV  D21, X18
    FMOV  V21.D[1], X5
    FMOV  D22, X22
    FMOV  V22.D[1], X20
    FMOV  D23, X19
    FMOV  V23.D[1], X27
    FMOV  D24, X19
    FMOV  V24.D[1], X26
    FMOV  D25, X18
    FMOV  V25.D[1], X21
    FMOV  D26, X4
    FMOV  V26.D[1], X29
    FMOV  D27, X22
    FMOV  V27.D[1], X27
    FMOV  D28, X17
    FMOV  V28.D[1], X5
    FMOV  D29, X17
    FMOV  V29.D[1], X22
    FMOV  D30, X12
    FMOV  V30.D[1], X5
    FMOV  D31, X2
    FMOV  V31.D[1], X27
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_7:
    FCVTAU  S8, S24
    FCVTZU D30, D27, #21
    FCVTZS  S20, S29
    FCVTMS  D6, D26
    FCVTMS  D9, D30
    FCVTNS  D0, D25
    FCVTPS  H24, H9
    FCVTNU  D0, D21
    FCVTZU  D7, D28
    FCVTZS  H15, H22
    FCVTAS  D21, D24
    FCVTNS  S1, S6
    FCVTAU  H20, H0
    FCVTZS D12, D15, #55
    FCVTAS  D29, D12
    FCVTMU  D21, D20
    FCVTMU  S26, S21
    FCVTPS  H30, H8
    FCVTNU  S22, S31
    FCVTZU D6, D22, #45
    FCVTZS  H22, H6
    FCVTMU  S7, S1
    FCVTAU  H21, H7
    FCVTNU  H10, H22
    FCVTPS  H20, H10
    FCVTPS  D27, D20
    FCVTAS  H20, H30
    FCVTZS  D30, D21
    FCVTNS  D1, D30
    FCVTZU  S8, S1
    FCVTZS  H25, H8
    FCVTAS  H31, H26
    FCVTPU  D9, D20
    FCVTNS  H22, H27
    FCVTPS  H1, H25
    FCVTAS  D10, D31
    FCVTMU  H30, H9
    FCVTZS  D7, D29
    FCVTXN  S20, D22
    FCVTMS  S31, S13
    FCVTZU  S6, S29
    FCVTNU  D13, D1
    FCVTMU  H12, H30
    FCVTXN  S1, D12
    FCVTAS  D30, D10
    FCVTZS D8, D30, #20
    FCVTPU  H22, H1
    FCVTZU H1, H8, #3
    FCVTPS  H25, H7
    FCVTAS  S29, S25
    FCVTZS  D7, D6
    FCVTZS H9, H13, #15
    FCVTMS  S25, S31
    FCVTNS  D12, D1
    FCVTZU D21, D3, #13
    FCVTZU  H10, H20
    FCVTAU  D26, D25
    FCVTMU  S20, S10
    FCVTZU  H13, H26
    FCVTAU  H25, H22
    FCVTXN  S8, D20
    FCVTPS  H26, H25
    FCVTZU D6, D8, #4
    FCVTZU  D20, D6
    FCVTZS D27, D9, #30
    FCVTAS  H8, H29
    FCVTMU  S29, S12
    FCVTZU S31, S13, #6
    FCVTNS  H6, H8
    FCVTZU S10, S7, #31
    FCVTZS S9, S6, #6
    FCVTMS  S6, S29
    FCVTMU  D22, D20
    FCVTAS  D20, D6
    FCVTZS D8, D9, #43
    FCVTMS  S25, S20
    FCVTAU  D13, D10
    FCVTZU S10, S13, #5
    FCVTNU  D13, D31
    FCVTMU  H12, H13
    FCVTNS  S20, S12
    FCVTZS  H6, H26
    FCVTPU  S3, S27
    FCVTNS  D7, D3
    FCVTZU S29, S22, #9
    FCVTNS  H22, H29
    FCVTZS D29, D22, #26
    FCVTMS  D13, D26
    FCVTZU  H27, H25
    FCVTZS H25, H20, #9
    FCVTNU  H22, H21
    FCVTZS  S12, S6
    FCVTMU  S6, S10
    FCVTZS H26, H20, #14
    FCVTZS  H20, H30
    FCVTZU D21, D25, #58
    FCVTNU  D10, D6
    FCVTNU  H31, H7
    FCVTMU  D6, D22
    FCVTMU  D3, D12
    FCVTZS  S12, S21
    FCVTNS  H21, H12
    FCVTNS  H30, H8
    FCVTZU H7, H29, #12
    FCVTPU  D12, D30
    FCVTXN  S8, D17
    FCVTPU  H25, H13
    FCVTAS  D30, D3
    FCVTNS  D13, D27
    FCVTPS  S27, S10
    FCVTAU  H10, H7
    FCVTMU  D3, D27
    FCVTAS  S17, S8
    FCVTMS  D29, D31
    FCVTAS  S6, S6
    FCVTAS  H14, H17
    FCVTMS  S27, S21
    FCVTZS  D17, D30
    FCVTNS  S30, S13
    FCVTMU  S8, S14
    FCVTMU  S7, S25
    FCVTZS  D21, D6
    FCVTZS  D6, D10
    FCVTPU  S31, S27
    FCVTMS  S27, S12
    FCVTMS  H14, H7
    FCVTNS  H7, H17
    FCVTZS  S25, S21
    FCVTZU H13, H25, #10
    FCVTAU  D0, D6
    FCVTMU  D21, D29
    FCVTPS  D28, D10
    FCVTZU  D6, D28
    FCVTZU S12, S7, #24
    FCVTZU H28, H30, #7
    FCVTZU H30, H31, #13
    FCVTMU  D31, D30
    FCVTMS  D17, D3
    FCVTZU  D3, D21
    FCVTZS  D10, D12
    FCVTZU  S12, S6
    FCVTPU  S25, S12
    FCVTNS  H29, H13
    FCVTXN  S12, D28
    FCVTXN  S30, D0
    FCVTZU D13, D10, #27
    FCVTNU  D6, D3
    FCVTAS  D7, D6
    FCVTZS H10, H7, #5
    FCVTMU  D21, D25
    FCVTPS  D3, D12
    FCVTZS  D12, D10
    FCVTMU  S7, S17
    FCVTNS  S17, S12
    FCVTAS  S25, S29
    FCVTMS  H28, H30
    FCVTMU  S6, S25
    FCVTZU  S4, S7
    FCVTZS H0, H28, #6
    FCVTAU  S28, S0
    FCVTPU  S10, S28
    FCVTAS  H28, H21
    FCVTZS  S21, S4
    FCVTMS  D29, D21
    FCVTMS  S12, S13
    FCVTPU  H27, H29
    FCVTPS  S0, S17
    FCVTMS  S21, S10
    FCVTPS  H29, H6
    FCVTMS  S10, S27
    FCVTAS  D13, D12
    FCVTPU  S27, S0
    FCVTNU  H25, H21
    FCVTAS  D0, D25
    FCVTNU  H4, H13
    FCVTAU  S12, S29
    FCVTZU S17, S3, #26
    FCVTMU  H7, H27
    FCVTZS  D13, D7
    FCVTPU  S3, S0
    FCVTNU  H21, H28
    FCVTNS  S29, S10
    FCVTAS  H25, H21
    FCVTZS  S21, S29
    FCVTZS  H0, H21
    FCVTZU  S6, S5
    FCVTPU  S10, S3
    FCVTZU  H5, H0
    FCVTZU  S27, S25
    FCVTZU D25, D4, #9
    FCVTPS  S3, S12
    FCVTPS  S29, S17
    FCVTZS  D21, D13
    FCVTNU  D7, D10
    FCVTPU  D0, D3
    FCVTPU  H12, H0
    FCVTZU  S22, S7
    FCVTNS  D3, D2
    FCVTZS  S13, S3
    FCVTZU S3, S6, #6
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_7
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x99, LSL #0
    MRS  X13, FPSR
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D0
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D1
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D2
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D3
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D4
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D5
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D6
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D7
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D8
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D9
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D10
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D11
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D12
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D13
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D14
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D16
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D17
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D19
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D20
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D21
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D22
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D23
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D24
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D25
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D26
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D27
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D28
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D29
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D30
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X13, D31
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X2
    FMOV  D3, X15
    FMOV  V3.D[1], X20
    FMOV  D4, X15
    FMOV  V4.D[1], X4
    FMOV  D5, X12
    FMOV  V5.D[1], X25
    FMOV  D6, X27
    FMOV  V6.D[1], X22
    FMOV  D7, X17
    FMOV  V7.D[1], X27
    FMOV  D8, X13
    FMOV  V8.D[1], X21
    FMOV  D9, X20
    FMOV  V9.D[1], X18
    FMOV  D10, X10
    FMOV  V10.D[1], X5
    FMOV  D11, X29
    FMOV  V11.D[1], X7
    FMOV  D12, X25
    FMOV  V12.D[1], X12
    FMOV  D13, X15
    FMOV  V13.D[1], X20
    FMOV  D14, X19
    FMOV  V14.D[1], X16
    FMOV  D15, X4
    FMOV  V15.D[1], X14
    FMOV  D16, X4
    FMOV  V16.D[1], X14
    FMOV  D17, X20
    FMOV  V17.D[1], X15
    FMOV  D18, X22
    FMOV  V18.D[1], X18
    FMOV  D19, X7
    FMOV  V19.D[1], X17
    FMOV  D20, X10
    FMOV  V20.D[1], X18
    FMOV  D21, X29
    FMOV  V21.D[1], X8
    FMOV  D22, X26
    FMOV  V22.D[1], X21
    FMOV  D23, X26
    FMOV  V23.D[1], X7
    FMOV  D24, X22
    FMOV  V24.D[1], X19
    FMOV  D25, X7
    FMOV  V25.D[1], X14
    FMOV  D26, X5
    FMOV  V26.D[1], X8
    FMOV  D27, X15
    FMOV  V27.D[1], X14
    FMOV  D28, X12
    FMOV  V28.D[1], X15
    FMOV  D29, X10
    FMOV  V29.D[1], X25
    FMOV  D30, X17
    FMOV  V30.D[1], X17
    FMOV  D31, X9
    FMOV  V31.D[1], X13
    MOVZ  X6, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_8:
    FCVTMS  H5, H27
    FCVTMS  D16, D21
    FCVTNS  D10, D29
    FCVTNU  H30, H10
    FCVTNS  H5, H5
    FCVTAU  D7, D16
    FCVTAU  D3, D31
    FCVTPS  S8, S3
    FCVTAS  D27, D28
    FCVTPU  D15, D27
    FCVTAS  D10, D15
    FCVTZS S14, S5, #24
    FCVTAU  S31, S14
    FCVTMU  D19, D31
    FCVTMU  H30, H19
    FCVTNS  H11, H30
    FCVTAS  D15, D10
    FCVTZU  S8, S15
    FCVTMS  D11, D7
    FCVTAS  H9, H8
    FCVTZU  S27, S9
    FCVTPS  S28, S26
    FCVTZS H3, H2, #6
    FCVTZS  H14, H28
    FCVTXN  S29, D11
    FCVTZU  H30, H17
    FCVTMS  D16, D29
    FCVTNS  S26, S30
    FCVTZS S7, S27, #5
    FCVTXN  S10, D7
    FCVTZU  D21, D20
    FCVTZU D9, D10, #50
    FCVTAS  S10, S21
    FCVTMU  S30, S26
    FCVTZU D31, D14, #35
    FCVTMS  H29, H16
    FCVTNS  H8, H9
    FCVTZU H14, H15, #5
    FCVTNS  H27, H3
    FCVTNS  H5, H23
    FCVTPU  D28, D5
    FCVTMU  H11, H14
    FCVTZU H19, H11, #9
    FCVTNS  D11, D19
    FCVTPS  D21, D30
    FCVTMS  S23, S28
    FCVTAS  D28, D11
    FCVTZU S9, S31, #12
    FCVTPS  S11, S27
    FCVTZS  D31, D10
    FCVTNU  H19, H8
    FCVTAU  D8, D29
    FCVTNS  D16, D8
    FCVTMS  H17, H30
    FCVTMS  D3, D19
    FCVTPS  S15, S23
    FCVTZS  S23, S11
    FCVTPS  D27, D15
    FCVTZS D10, D31, #31
    FCVTZS  S19, S16
    FCVTNS  H30, H27
    FCVTNS  H14, H19
    FCVTAS  H11, H23
    FCVTZS H16, H10, #7
    FCVTNS  H29, H30
    FCVTPS  D8, D14
    FCVTZU  S19, S28
    FCVTZS H27, H16, #10
    FCVTZS  D5, D19
    FCVTNU  D10, D8
    FCVTAS  S15, S21
    FCVTZS S31, S10, #20
    FCVTZU  S28, S3
    FCVTAS  S8, S17
    FCVTMS  D21, D5
    FCVTPS  H5, H31
    FCVTZS S31, S28, #32
    FCVTAU  S26, S31
    FCVTPU  D28, D27
    FCVTMS  H31, H29
    FCVTAS  S10, S15
    FCVTZS  D15, D31
    FCVTNS  S30, S11
    FCVTPS  H3, H5
    FCVTXN  S31, D8
    FCVTZS D27, D28, #30
    FCVTMS  S28, S2
    FCVTZS H17, H21, #9
    FCVTMU  H21, H28
    FCVTNU  H8, H27
    FCVTMU  H27, H21
    FCVTPU  D2, D17
    FCVTZS D29, D15, #30
    FCVTZS D11, D2, #5
    FCVTPU  H17, H30
    FCVTAS  D5, D17
    FCVTPS  D21, D10
    FCVTAU  H17, H29
    FCVTNU  D10, D31
    FCVTPS  S28, S21
    FCVTZS  D7, D26
    FCVTZS S26, S17, #8
    FCVTZS H21, H3, #7
    FCVTZS D15, D21, #21
    FCVTAU  S30, S11
    FCVTMU  S3, S15
    FCVTPS  S31, S26
    FCVTPU  H29, H27
    FCVTZS  S21, S8
    FCVTMU  H26, H29
    FCVTPU  D11, D7
    FCVTNU  H7, H5
    FCVTAS  D0, D7
    FCVTZU  D22, D3
    FCVTAS  D3, D11
    FCVTPU  S11, S3
    FCVTPS  H29, H11
    FCVTZS S7, S26, #4
    FCVTMS  D5, D21
    FCVTAS  H27, H0
    FCVTPU  S3, S10
    FCVTZU  D26, D31
    FCVTZS H11, H30, #8
    FCVTNS  S30, S22
    FCVTAS  D15, D3
    FCVTNS  S17, S27
    FCVTZS D8, D28, #40
    FCVTAU  D28, D29
    FCVTZS  D31, D26
    FCVTZS S26, S11, #2
    FCVTAU  D17, D31
    FCVTPU  D21, D11
    FCVTZS D29, D26, #4
    FCVTAS  S22, S30
    FCVTPS  H31, H17
    FCVTZS  D26, D29
    FCVTAS  D30, D5
    FCVTPU  H5, H21
    FCVTNU  D10, D26
    FCVTZS  H11, H10
    FCVTNU  S29, S11
    FCVTPU  S27, S22
    FCVTAS  H21, H8
    FCVTZU  D0, D31
    FCVTZU S8, S7, #14
    FCVTZU S22, S29, #15
    FCVTZS D11, D5, #23
    FCVTPS  H17, H27
    FCVTPU  S31, S0
    FCVTPU  D29, D30
    FCVTMU  S7, S22
    FCVTAU  D3, D11
    FCVTAS  D22, D3
    FCVTZS H27, H21, #5
    FCVTPU  S26, S8
    FCVTPU  S10, S7
    FCVTNS  D5, D10
    FCVTPS  H10, H5
    FCVTZS  D23, D29
    FCVTNS  H0, H23
    FCVTPS  H8, H27
    FCVTMS  S30, S8
    FCVTZU  D11, D10
    FCVTPU  H19, H1
    FCVTAU  S1, S11
    FCVTZS H3, H0, #9
    FCVTZU  D0, D26
    FCVTZU S23, S0, #32
    FCVTNU  D21, D3
    FCVTZS  H3, H30
    FCVTNU  H11, H23
    FCVTZU  D18, D31
    FCVTPU  D30, D3
    FCVTZU  D5, D22
    FCVTAU  H0, H18
    FCVTPU  H26, H21
    FCVTPU  H10, H1
    FCVTPS  D7, D30
    FCVTNU  S27, S7
    FCVTAU  S8, S5
    FCVTMU  S1, S11
    FCVTZU  S11, S19
    FCVTNS  H5, H1
    FCVTZU  S7, S10
    FCVTPS  H31, H7
    FCVTZS  H19, H27
    FCVTNS  D23, D26
    FCVTAU  S27, S5
    FCVTNS  H5, H8
    FCVTNU  H1, H0
    FCVTZU D22, D1, #12
    FCVTNU  D10, D22
    FCVTZS D8, D10, #4
    FCVTAS  S3, S8
    FCVTMU  D26, D3
    FCVTMU  S0, S1
    FCVTAS  H10, H0
    FCVTZS H0, H11, #8
    FCVTAU  H11, H5
    FCVTZS S8, S27, #17
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_8
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x99, LSL #0
    MRS  X18, FPSR
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D0
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D1
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D2
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D3
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, V4.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, D4
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D5
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, D6
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D7
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D8
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D9
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D10
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D11
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, D12
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, V13.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, D13
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D14
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D15
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D16
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D17
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D18
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D19
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, V20.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, D20
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D21
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D22
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D23
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, V24.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, D24
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, V25.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X18, D25
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D26
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D27
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D28
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D29
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D30
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D31
    SUB  X22, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xc72e, LSL #0
    MOVK  X2, #0x51ab, LSL #16
    MOVK  X2, #0x6650, LSL #32
    MOVK  X2, #0x8c5, LSL #48
    MOVZ  X4, #0xddba, LSL #0
    MOVK  X4, #0x90c8, LSL #16
    MOVK  X4, #0x2648, LSL #32
    MOVK  X4, #0x8db9, LSL #48
    MOVZ  X5, #0x127e, LSL #0
    MOVK  X5, #0x94a5, LSL #16
    MOVK  X5, #0xe970, LSL #32
    MOVK  X5, #0x195e, LSL #48
    MOVZ  X6, #0xb8e2, LSL #0
    MOVK  X6, #0x3955, LSL #16
    MOVK  X6, #0xe76e, LSL #32
    MOVK  X6, #0x909c, LSL #48
    MOVZ  X7, #0xe671, LSL #0
    MOVK  X7, #0xfa68, LSL #16
    MOVK  X7, #0x5019, LSL #32
    MOVK  X7, #0xad77, LSL #48
    MOVZ  X8, #0x8ab6, LSL #0
    MOVK  X8, #0xba54, LSL #16
    MOVK  X8, #0x30b0, LSL #32
    MOVK  X8, #0xa11c, LSL #48
    MOVZ  X9, #0xac4b, LSL #0
    MOVK  X9, #0x5ec3, LSL #16
    MOVK  X9, #0x82d2, LSL #32
    MOVK  X9, #0x4a41, LSL #48
    MOVZ  X10, #0xfac8, LSL #0
    MOVK  X10, #0xbfe5, LSL #16
    MOVK  X10, #0x3fb, LSL #32
    MOVK  X10, #0x5de2, LSL #48
    MOVZ  X12, #0xb8fa, LSL #0
    MOVK  X12, #0x4c3b, LSL #16
    MOVK  X12, #0x6e77, LSL #32
    MOVK  X12, #0xb322, LSL #48
    MOVZ  X13, #0xae1e, LSL #0
    MOVK  X13, #0xbc75, LSL #16
    MOVK  X13, #0xd89d, LSL #32
    MOVK  X13, #0xf4fe, LSL #48
    MOVZ  X14, #0x4cc0, LSL #0
    MOVK  X14, #0x3e1, LSL #16
    MOVK  X14, #0x1dd6, LSL #32
    MOVK  X14, #0xa322, LSL #48
    MOVZ  X15, #0x70d9, LSL #0
    MOVK  X15, #0x967, LSL #16
    MOVK  X15, #0x2944, LSL #32
    MOVK  X15, #0x8927, LSL #48
    MOVZ  X16, #0xa09d, LSL #0
    MOVK  X16, #0x9ee5, LSL #16
    MOVK  X16, #0xb02d, LSL #32
    MOVK  X16, #0x4ae4, LSL #48
    MOVZ  X17, #0xbfd2, LSL #0
    MOVK  X17, #0x3df2, LSL #16
    MOVK  X17, #0xd4d8, LSL #32
    MOVK  X17, #0xbcaa, LSL #48
    MOVZ  X18, #0xa50a, LSL #0
    MOVK  X18, #0x2683, LSL #16
    MOVK  X18, #0x61b9, LSL #32
    MOVK  X18, #0xd8cd, LSL #48
    MOVZ  X19, #0x1a1f, LSL #0
    MOVK  X19, #0x12f4, LSL #16
    MOVK  X19, #0x92b8, LSL #32
    MOVK  X19, #0x71f2, LSL #48
    MOVZ  X20, #0xf56b, LSL #0
    MOVK  X20, #0x6c43, LSL #16
    MOVK  X20, #0xc930, LSL #32
    MOVK  X20, #0x9f97, LSL #48
    MOVZ  X21, #0xa3e0, LSL #0
    MOVK  X21, #0xd697, LSL #16
    MOVK  X21, #0x1eb, LSL #32
    MOVK  X21, #0xc50, LSL #48
    MOVZ  X22, #0xeb9, LSL #0
    MOVK  X22, #0x3c5b, LSL #16
    MOVK  X22, #0x2f96, LSL #32
    MOVK  X22, #0xc8d2, LSL #48
    MOVZ  X25, #0x2965, LSL #0
    MOVK  X25, #0x64c8, LSL #16
    MOVK  X25, #0xd64, LSL #32
    MOVK  X25, #0xa516, LSL #48
    MOVZ  X26, #0x43b5, LSL #0
    MOVK  X26, #0x87de, LSL #16
    MOVK  X26, #0xb162, LSL #32
    MOVK  X26, #0x8b86, LSL #48
    MOVZ  X27, #0x78e1, LSL #0
    MOVK  X27, #0x4ca7, LSL #16
    MOVK  X27, #0x6a27, LSL #32
    MOVK  X27, #0x1cfc, LSL #48
    MOVZ  X28, #0x38da, LSL #0
    MOVK  X28, #0x369c, LSL #16
    MOVK  X28, #0xc7b3, LSL #32
    MOVK  X28, #0xe657, LSL #48
    MOVZ  X29, #0x2834, LSL #0
    MOVK  X29, #0xd33a, LSL #16
    MOVK  X29, #0xe183, LSL #32
    MOVK  X29, #0x2902, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X22
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X27
    FMOV  V3.D[1], X10
    FMOV  D4, X16
    FMOV  V4.D[1], X15
    FMOV  D5, X18
    FMOV  V5.D[1], X4
    FMOV  D6, X6
    FMOV  V6.D[1], X20
    FMOV  D7, X27
    FMOV  V7.D[1], X9
    FMOV  D8, X13
    FMOV  V8.D[1], X9
    FMOV  D9, X19
    FMOV  V9.D[1], X27
    FMOV  D10, X13
    FMOV  V10.D[1], X22
    FMOV  D11, X18
    FMOV  V11.D[1], X8
    FMOV  D12, X5
    FMOV  V12.D[1], X12
    FMOV  D13, X19
    FMOV  V13.D[1], X9
    FMOV  D14, X15
    FMOV  V14.D[1], X7
    FMOV  D15, X14
    FMOV  V15.D[1], X2
    FMOV  D16, X20
    FMOV  V16.D[1], X12
    FMOV  D17, X20
    FMOV  V17.D[1], X10
    FMOV  D18, X15
    FMOV  V18.D[1], X4
    FMOV  D19, X10
    FMOV  V19.D[1], X12
    FMOV  D20, X27
    FMOV  V20.D[1], X29
    FMOV  D21, X2
    FMOV  V21.D[1], X12
    FMOV  D22, X14
    FMOV  V22.D[1], X28
    FMOV  D23, X5
    FMOV  V23.D[1], X4
    FMOV  D24, X7
    FMOV  V24.D[1], X17
    FMOV  D25, X2
    FMOV  V25.D[1], X12
    FMOV  D26, X7
    FMOV  V26.D[1], X16
    FMOV  D27, X16
    FMOV  V27.D[1], X21
    FMOV  D28, X21
    FMOV  V28.D[1], X29
    FMOV  D29, X27
    FMOV  V29.D[1], X17
    FMOV  D30, X17
    FMOV  V30.D[1], X22
    FMOV  D31, X7
    FMOV  V31.D[1], X8
    MOVZ  X13, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_9:
    FCVTMS  H21, H23
    FCVTZU  S27, S19
    FCVTZU  S29, S28
    FCVTZU S30, S26, #8
    FCVTPU  H16, H24
    FCVTZU  D7, D31
    FCVTAS  H12, H25
    FCVTPS  D7, D30
    FCVTNS  S16, S7
    FCVTPS  H31, H16
    FCVTZU H9, H29, #16
    FCVTAU  H20, H9
    FCVTMS  H25, H31
    FCVTZU D7, D25, #35
    FCVTMS  H15, H21
    FCVTXN  S25, D30
    FCVTPS  S26, S7
    FCVTPU  H20, H20
    FCVTAU  H15, H12
    FCVTMS  S29, S26
    FCVTAS  H3, H12
    FCVTZU S19, S25, #7
    FCVTZU  H19, H3
    FCVTZU  S16, S19
    FCVTZS H10, H20, #15
    FCVTMU  H27, H15
    FCVTZU  D20, D16
    FCVTMU  S3, S29
    FCVTZU D19, D20, #48
    FCVTPU  S7, S3
    FCVTZS S23, S19, #26
    FCVTPS  H19, H7
    FCVTAS  S30, S27
    FCVTZU  S29, S30
    FCVTZU  S9, S19
    FCVTMU  H3, H29
    FCVTZS S25, S3, #8
    FCVTNS  S20, S10
    FCVTZS S10, S20, #14
    FCVTAS  S15, S10
    FCVTNS  S20, S25
    FCVTPS  H27, H23
    FCVTZS  H19, H15
    FCVTZS  H3, H19
    FCVTZS  D23, D3
    FCVTPU  S15, S7
    FCVTZS H30, H27, #11
    FCVTZU S27, S30, #7
    FCVTXN  S7, D27
    FCVTZS  D25, D20
    FCVTPS  H30, H9
    FCVTMU  D3, D30
    FCVTMU  H19, H23
    FCVTZU D23, D7, #61
    FCVTAS  H27, H23
    FCVTNS  D23, D19
    FCVTZS H10, H15, #7
    FCVTZS  D7, D3
    FCVTZS D3, D27, #44
    FCVTZS S20, S7, #26
    FCVTNS  D29, D3
    FCVTMS  S11, S23
    FCVTNS  S9, S29
    FCVTZS H19, H16, #4
    FCVTZS H23, H25, #15
    FCVTZS  D31, D11
    FCVTZS D25, D9, #30
    FCVTZU D30, D19, #49
    FCVTZU  S16, S23
    FCVTNU  H29, H31
    FCVTMU  H26, H29
    FCVTMS  H29, H20
    FCVTZS  D9, D25
    FCVTNU  D23, D29
    FCVTNS  H31, H10
    FCVTNS  S3, S31
    FCVTPU  D25, D30
    FCVTXN  S19, D25
    FCVTZS H30, H19, #3
    FCVTPS  S7, S26
    FCVTMS  D25, D16
    FCVTNU  S11, S3
    FCVTPU  S26, S11
    FCVTAU  S11, S25
    FCVTAU  D31, D11
    FCVTAS  D11, D23
    FCVTZU H19, H26, #7
    FCVTAU  H27, H30
    FCVTNU  H8, H31
    FCVTZU  H10, H19
    FCVTPS  D13, D9
    FCVTMU  H30, H11
    FCVTAU  H23, H28
    FCVTAU  H16, H27
    FCVTPS  D11, D7
    FCVTZU  D28, D11
    FCVTNU  S26, S28
    FCVTZU S31, S8, #24
    FCVTAS  S25, S29
    FCVTMS  S20, S25
    FCVTAU  H27, H31
    FCVTAS  S9, S23
    FCVTNU  H19, H30
    FCVTMU  H28, H13
    FCVTZS  D13, D10
    FCVTPU  H3, H13
    FCVTMS  D10, D3
    FCVTNU  D13, D16
    FCVTPS  D31, D26
    FCVTNU  D3, D27
    FCVTMS  H30, H13
    FCVTZU  S23, S20
    FCVTNU  S7, S31
    FCVTMU  D18, D10
    FCVTAS  H26, H18
    FCVTAU  D8, D3
    FCVTMS  S25, S7
    FCVTPU  S31, S26
    FCVTMU  H16, H19
    FCVTZU S29, S30, #2
    FCVTZU  D20, D28
    FCVTNS  D11, D25
    FCVTNS  S27, S29
    FCVTMS  D29, D20
    FCVTXN  S18, D23
    FCVTAS  D13, D8
    FCVTPS  H20, H13
    FCVTNU  S28, S11
    FCVTNS  H23, H27
    FCVTAU  D25, D18
    FCVTPU  D26, D20
    FCVTZS H21, H31, #14
    FCVTAU  D27, D25
    FCVTPS  H20, H23
    FCVTNU  D19, D16
    FCVTAU  S11, S19
    FCVTMU  H18, H29
    FCVTZS  H30, H28
    FCVTZU  D29, D26
    FCVTAS  S13, S29
    FCVTMS  H29, H25
    FCVTNS  H28, H18
    FCVTPU  S23, S13
    FCVTNU  D26, D28
    FCVTXN  S25, D26
    FCVTXN  S18, D25
    FCVTNU  S8, S29
    FCVTPS  D25, D27
    FCVTMU  D16, D20
    FCVTAS  D26, D30
    FCVTMS  D29, D23
    FCVTPU  D23, D26
    FCVTAU  D28, D16
    FCVTNS  H16, H11
    FCVTPU  S11, S18
    FCVTMU  H13, H23
    FCVTNU  H30, H8
    FCVTZU H26, H30, #16
    FCVTZS D30, D11, #62
    FCVTZS D11, D25, #48
    FCVTNU  H18, H21
    FCVTZU  D25, D29
    FCVTMS  H8, H26
    FCVTZS  S20, S8
    FCVTZU H29, H20, #13
    FCVTZS  S8, S20
    FCVTZS H21, H25, #12
    FCVTZS  D26, D16
    FCVTZS H16, H15, #4
    FCVTMS  S25, S16
    FCVTNS  S20, S21
    FCVTZS  S15, S29
    FCVTMS  H23, H16
    FCVTAS  D21, D28
    FCVTNS  D27, D15
    FCVTZU  S15, S5
    FCVTPS  D29, D13
    FCVTZS  D28, D30
    FCVTPU  H13, H26
    FCVTAS  D30, D8
    FCVTPU  D16, D23
    FCVTAS  S24, S16
    FCVTAU  H8, H18
    FCVTNU  D18, D30
    FCVTAU  D16, D27
    FCVTMU  H23, H24
    FCVTMU  S30, S8
    FCVTAU  S8, S18
    FCVTAU  H26, H30
    FCVTAS  H5, H29
    FCVTZS H27, H23, #3
    FCVTMU  D24, D21
    FCVTNS  H18, H16
    FCVTZU  H3, H13
    FCVTPS  H21, H27
    FCVTMS  D27, D8
    FCVTZS  S30, S28
    FCVTMS  S16, S18
    FCVTZU  H28, H5
    FCVTAU  S29, S16
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_9
    MOVZ  X4, #0xc72e, LSL #0
    MOVK  X4, #0x51ab, LSL #16
    MOVK  X4, #0x6650, LSL #32
    MOVK  X4, #0x8c5, LSL #48
    SUB  X5, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xb8e2, LSL #0
    MOVK  X4, #0x3955, LSL #16
    MOVK  X4, #0xe76e, LSL #32
    MOVK  X4, #0x909c, LSL #48
    SUB  X5, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xe671, LSL #0
    MOVK  X4, #0xfa68, LSL #16
    MOVK  X4, #0x5019, LSL #32
    MOVK  X4, #0xad77, LSL #48
    SUB  X5, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x8ab6, LSL #0
    MOVK  X4, #0xba54, LSL #16
    MOVK  X4, #0x30b0, LSL #32
    MOVK  X4, #0xa11c, LSL #48
    SUB  X5, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xac4b, LSL #0
    MOVK  X4, #0x5ec3, LSL #16
    MOVK  X4, #0x82d2, LSL #32
    MOVK  X4, #0x4a41, LSL #48
    SUB  X5, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xfac8, LSL #0
    MOVK  X4, #0xbfe5, LSL #16
    MOVK  X4, #0x3fb, LSL #32
    MOVK  X4, #0x5de2, LSL #48
    SUB  X5, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xb8fa, LSL #0
    MOVK  X4, #0x4c3b, LSL #16
    MOVK  X4, #0x6e77, LSL #32
    MOVK  X4, #0xb322, LSL #48
    SUB  X5, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x4cc0, LSL #0
    MOVK  X4, #0x3e1, LSL #16
    MOVK  X4, #0x1dd6, LSL #32
    MOVK  X4, #0xa322, LSL #48
    SUB  X5, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x70d9, LSL #0
    MOVK  X4, #0x967, LSL #16
    MOVK  X4, #0x2944, LSL #32
    MOVK  X4, #0x8927, LSL #48
    SUB  X5, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xa09d, LSL #0
    MOVK  X4, #0x9ee5, LSL #16
    MOVK  X4, #0xb02d, LSL #32
    MOVK  X4, #0x4ae4, LSL #48
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xbfd2, LSL #0
    MOVK  X4, #0x3df2, LSL #16
    MOVK  X4, #0xd4d8, LSL #32
    MOVK  X4, #0xbcaa, LSL #48
    SUB  X5, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xa50a, LSL #0
    MOVK  X4, #0x2683, LSL #16
    MOVK  X4, #0x61b9, LSL #32
    MOVK  X4, #0xd8cd, LSL #48
    SUB  X5, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x1a1f, LSL #0
    MOVK  X4, #0x12f4, LSL #16
    MOVK  X4, #0x92b8, LSL #32
    MOVK  X4, #0x71f2, LSL #48
    SUB  X5, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xa3e0, LSL #0
    MOVK  X4, #0xd697, LSL #16
    MOVK  X4, #0x1eb, LSL #32
    MOVK  X4, #0xc50, LSL #48
    SUB  X5, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xeb9, LSL #0
    MOVK  X4, #0x3c5b, LSL #16
    MOVK  X4, #0x2f96, LSL #32
    MOVK  X4, #0xc8d2, LSL #48
    SUB  X5, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x2965, LSL #0
    MOVK  X4, #0x64c8, LSL #16
    MOVK  X4, #0xd64, LSL #32
    MOVK  X4, #0xa516, LSL #48
    SUB  X5, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x43b5, LSL #0
    MOVK  X4, #0x87de, LSL #16
    MOVK  X4, #0xb162, LSL #32
    MOVK  X4, #0x8b86, LSL #48
    SUB  X5, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x78e1, LSL #0
    MOVK  X4, #0x4ca7, LSL #16
    MOVK  X4, #0x6a27, LSL #32
    MOVK  X4, #0x1cfc, LSL #48
    SUB  X5, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x38da, LSL #0
    MOVK  X4, #0x369c, LSL #16
    MOVK  X4, #0xc7b3, LSL #32
    MOVK  X4, #0xe657, LSL #48
    SUB  X5, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x2834, LSL #0
    MOVK  X4, #0xd33a, LSL #16
    MOVK  X4, #0xe183, LSL #32
    MOVK  X4, #0x2902, LSL #48
    SUB  X5, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x99, LSL #0
    MRS  X5, FPSR
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x38da, LSL #0
    MOVK  X4, #0x369c, LSL #16
    MOVK  X4, #0xc7b3, LSL #32
    MOVK  X4, #0xe657, LSL #48
    FMOV  X5, V0.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x2965, LSL #0
    MOVK  X4, #0x64c8, LSL #16
    MOVK  X4, #0xd64, LSL #32
    MOVK  X4, #0xa516, LSL #48
    FMOV  X5, D0
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x43b5, LSL #0
    MOVK  X4, #0x87de, LSL #16
    MOVK  X4, #0xb162, LSL #32
    MOVK  X4, #0x8b86, LSL #48
    FMOV  X5, V1.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xeb9, LSL #0
    MOVK  X4, #0x3c5b, LSL #16
    MOVK  X4, #0x2f96, LSL #32
    MOVK  X4, #0xc8d2, LSL #48
    FMOV  X5, D1
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x78e1, LSL #0
    MOVK  X4, #0x4ca7, LSL #16
    MOVK  X4, #0x6a27, LSL #32
    MOVK  X4, #0x1cfc, LSL #48
    FMOV  X5, V2.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x2834, LSL #0
    MOVK  X4, #0xd33a, LSL #16
    MOVK  X4, #0xe183, LSL #32
    MOVK  X4, #0x2902, LSL #48
    FMOV  X5, D2
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V3.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D3
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x70d9, LSL #0
    MOVK  X4, #0x967, LSL #16
    MOVK  X4, #0x2944, LSL #32
    MOVK  X4, #0x8927, LSL #48
    FMOV  X5, V4.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xa09d, LSL #0
    MOVK  X4, #0x9ee5, LSL #16
    MOVK  X4, #0xb02d, LSL #32
    MOVK  X4, #0x4ae4, LSL #48
    FMOV  X5, D4
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V5.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D5
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xf56b, LSL #0
    MOVK  X4, #0x6c43, LSL #16
    MOVK  X4, #0xc930, LSL #32
    MOVK  X4, #0x9f97, LSL #48
    FMOV  X5, V6.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xb8e2, LSL #0
    MOVK  X4, #0x3955, LSL #16
    MOVK  X4, #0xe76e, LSL #32
    MOVK  X4, #0x909c, LSL #48
    FMOV  X5, D6
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V7.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D7
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V8.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D8
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V9.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D9
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D10
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D11
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D12
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V13.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D13
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xe671, LSL #0
    MOVK  X4, #0xfa68, LSL #16
    MOVK  X4, #0x5019, LSL #32
    MOVK  X4, #0xad77, LSL #48
    FMOV  X5, V14.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x70d9, LSL #0
    MOVK  X4, #0x967, LSL #16
    MOVK  X4, #0x2944, LSL #32
    MOVK  X4, #0x8927, LSL #48
    FMOV  X5, D14
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D15
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D16
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xfac8, LSL #0
    MOVK  X4, #0xbfe5, LSL #16
    MOVK  X4, #0x3fb, LSL #32
    MOVK  X4, #0x5de2, LSL #48
    FMOV  X5, V17.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0xf56b, LSL #0
    MOVK  X4, #0x6c43, LSL #16
    MOVK  X4, #0xc930, LSL #32
    MOVK  X4, #0x9f97, LSL #48
    FMOV  X5, D17
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V18.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D18
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V19.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D19
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D20
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D21
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x38da, LSL #0
    MOVK  X4, #0x369c, LSL #16
    MOVK  X4, #0xc7b3, LSL #32
    MOVK  X4, #0xe657, LSL #48
    FMOV  X5, V22.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x4cc0, LSL #0
    MOVK  X4, #0x3e1, LSL #16
    MOVK  X4, #0x1dd6, LSL #32
    MOVK  X4, #0xa322, LSL #48
    FMOV  X5, D22
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D23
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V24.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D24
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D25
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D26
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D27
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V28.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D28
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V29.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D29
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D30
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X5, D31
    SUB  X20, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X28
    FMOV  V0.D[1], X8
    FMOV  D1, X27
    FMOV  V1.D[1], X6
    FMOV  D2, X22
    FMOV  V2.D[1], X21
    FMOV  D3, X4
    FMOV  V3.D[1], X26
    FMOV  D4, X29
    FMOV  V4.D[1], X25
    FMOV  D5, X19
    FMOV  V5.D[1], X20
    FMOV  D6, X15
    FMOV  V6.D[1], X6
    FMOV  D7, X5
    FMOV  V7.D[1], X28
    FMOV  D8, X16
    FMOV  V8.D[1], X10
    FMOV  D9, X12
    FMOV  V9.D[1], X17
    FMOV  D10, X15
    FMOV  V10.D[1], X21
    FMOV  D11, X22
    FMOV  V11.D[1], X13
    FMOV  D12, X18
    FMOV  V12.D[1], X25
    FMOV  D13, X16
    FMOV  V13.D[1], X13
    FMOV  D14, X20
    FMOV  V14.D[1], X7
    FMOV  D15, X12
    FMOV  V15.D[1], X16
    FMOV  D16, X19
    FMOV  V16.D[1], X28
    FMOV  D17, X7
    FMOV  V17.D[1], X22
    FMOV  D18, X28
    FMOV  V18.D[1], X28
    FMOV  D19, X8
    FMOV  V19.D[1], X26
    FMOV  D20, X29
    FMOV  V20.D[1], X12
    FMOV  D21, X29
    FMOV  V21.D[1], X15
    FMOV  D22, X21
    FMOV  V22.D[1], X21
    FMOV  D23, X13
    FMOV  V23.D[1], X6
    FMOV  D24, X21
    FMOV  V24.D[1], X7
    FMOV  D25, X9
    FMOV  V25.D[1], X5
    FMOV  D26, X28
    FMOV  V26.D[1], X18
    FMOV  D27, X29
    FMOV  V27.D[1], X10
    FMOV  D28, X8
    FMOV  V28.D[1], X16
    FMOV  D29, X5
    FMOV  V29.D[1], X12
    FMOV  D30, X6
    FMOV  V30.D[1], X28
    FMOV  D31, X7
    FMOV  V31.D[1], X19
    MOVZ  X15, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_10:
    FCVTMS  D30, D27
    FCVTZS  H3, H23
    FCVTNU  H30, H25
    FCVTPU  H7, H3
    FCVTMU  S27, S24
    FCVTZS S6, S26, #6
    FCVTZS D15, D29, #38
    FCVTAS  H22, H31
    FCVTNS  H27, H6
    FCVTMS  S5, S30
    FCVTNU  H27, H3
    FCVTAS  S18, S28
    FCVTZU  D11, D7
    FCVTMU  D3, D5
    FCVTPS  H18, H15
    FCVTPS  S5, S3
    FCVTZS  S30, S22
    FCVTMS  H26, H27
    FCVTMS  D16, D30
    FCVTPU  S19, S16
    FCVTZS  S9, S26
    FCVTZU D25, D11, #54
    FCVTNU  D30, D10
    FCVTZU D28, D18, #9
    FCVTNU  D23, D5
    FCVTMS  S27, S30
    FCVTPU  S16, S23
    FCVTPS  S31, S16
    FCVTMU  H11, H25
    FCVTMS  S24, S19
    FCVTZU D7, D9, #60
    FCVTPS  H18, H28
    FCVTAS  S22, S11
    FCVTNU  H23, H7
    FCVTPU  H6, H31
    FCVTZS H11, H6, #15
    FCVTPS  D26, D24
    FCVTMU  S10, S27
    FCVTZS S19, S22, #10
    FCVTMS  S24, S23
    FCVTPS  D22, D26
    FCVTNU  H9, H22
    FCVTAU  H22, H5
    FCVTPU  H5, H18
    FCVTMU  H30, H11
    FCVTMU  D28, D5
    FCVTZU  D31, D10
    FCVTAU  H30, H19
    FCVTNS  S6, S24
    FCVTNS  H23, H16
    FCVTMU  S10, S6
    FCVTNU  H25, H10
    FCVTPU  H5, H9
    FCVTZU S7, S22, #15
    FCVTZU  H22, H5
    FCVTNS  S18, S23
    FCVTNS  S10, S18
    FCVTPU  S9, S11
    FCVTMU  S6, S28
    FCVTMS  D16, D21
    FCVTZU  D26, D31
    FCVTMS  H18, H25
    FCVTZU D31, D7, #61
    FCVTPU  H25, H18
    FCVTZU  H21, H26
    FCVTMU  S7, S9
    FCVTNS  H27, H25
    FCVTZU  H28, H10
    FCVTMS  D5, D27
    FCVTZS  S11, S6
    FCVTNU  S25, S5
    FCVTMU  S23, S7
    FCVTZS  H18, H21
    FCVTZU  S27, S11
    FCVTNS  H24, H27
    FCVTMU  D11, D25
    FCVTAU  H19, H16
    FCVTPU  H26, H19
    FCVTAS  D27, D24
    FCVTMU  D10, D28
    FCVTZU  H6, H22
    FCVTNS  H9, H6
    FCVTZS  D24, D26
    FCVTAS  S25, S24
    FCVTMU  H28, H18
    FCVTZU  D16, D10
    FCVTXN  S10, D27
    FCVTZS S18, S25, #23
    FCVTNS  S31, S28
    FCVTAS  H19, H9
    FCVTZS  D22, D19
    FCVTNU  D5, D31
    FCVTZU  H25, H18
    FCVTMU  H31, H5
    FCVTAS  H26, H23
    FCVTZS  S6, S11
    FCVTPU  D27, D10
    FCVTZS  S19, S16
    FCVTPS  S7, S25
    FCVTZU H18, H31, #16
    FCVTZU  D11, D18
    FCVTNU  S10, S27
    FCVTZU H31, H6, #2
    FCVTPU  S18, S26
    FCVTZU  S26, S19
    FCVTAU  H5, H26
    FCVTNS  H6, H31
    FCVTMU  H26, H11
    FCVTNU  D16, D3
    FCVTMS  S9, S22
    FCVTMS  H25, H7
    FCVTPU  H27, H18
    FCVTNS  D18, D26
    FCVTMU  S28, S18
    FCVTPU  H23, H16
    FCVTZU  H5, H10
    FCVTZS S17, S5, #19
    FCVTNS  S11, S17
    FCVTZU  D18, D23
    FCVTZS  H10, H25
    FCVTPU  S17, S28
    FCVTAS  S16, S17
    FCVTZS H26, H9, #8
    FCVTMS  H17, H6
    FCVTPS  D25, D11
    FCVTZS  H19, H16
    FCVTZS  S7, S19
    FCVTZS H16, H24, #2
    FCVTPS  D5, D26
    FCVTZS S26, S11, #24
    FCVTZU  S3, S26
    FCVTZS H31, H16, #14
    FCVTPU  D9, D25
    FCVTZU D6, D27, #58
    FCVTMS  H28, H6
    FCVTNS  H19, H3
    FCVTZS D27, D19, #30
    FCVTZS D11, D10, #54
    FCVTZS  S3, S11
    FCVTPS  D11, D7
    FCVTNU  S7, S18
    FCVTNU  D16, D7
    FCVTAS  H26, H3
    FCVTNU  S18, S11
    FCVTNU  D11, D18
    FCVTZS  S24, S9
    FCVTAU  H6, H16
    FCVTZS S25, S24, #27
    FCVTPS  D10, D26
    FCVTNU  D9, D25
    FCVTZS H25, H9, #8
    FCVTZU  S16, S17
    FCVTZS D17, D11, #50
    FCVTMU  S26, S28
    FCVTNU  D9, D6
    FCVTZS H6, H10, #8
    FCVTNU  S18, S31
    FCVTZU  S11, S25
    FCVTZS H10, H27, #14
    FCVTZU  H28, H11
    FCVTZS D31, D17, #1
    FCVTZU  H25, H6
    FCVTPS  S17, S28
    FCVTAS  S28, S16
    FCVTZU D24, D31, #59
    FCVTAU  D11, D24
    FCVTNU  S16, S18
    FCVTZS  D27, D10
    FCVTPS  H10, H9
    FCVTPS  D24, D25
    FCVTZS S6, S10, #9
    FCVTMU  H10, H13
    FCVTZS  H13, H26
    FCVTZS D18, D17, #30
    FCVTNU  H9, H18
    FCVTNS  D31, D13
    FCVTZU  H25, H31
    FCVTAS  D31, D31
    FCVTMS  H26, H11
    FCVTMU  H17, H31
    FCVTMU  D18, D10
    FCVTZU H10, H28, #4
    FCVTPU  H11, H24
    FCVTZS  S13, S9
    FCVTXN  S24, D10
    FCVTNU  S28, S26
    FCVTPS  S28, S18
    FCVTZS D10, D25, #37
    FCVTMS  D25, D17
    FCVTZU  S0, S6
    FCVTMU  H9, H0
    FCVTNS  S31, S16
    FCVTNS  H20, H9
    FCVTPU  H16, H27
    FCVTMS  S0, S18
    FCVTAS  H18, H0
    FCVTNS  D13, D25
    FCVTNU  H6, H16
    FCVTPS  D26, D24
    FCVTAS  S16, S26
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_10
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x99, LSL #0
    MRS  X27, FPSR
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V0.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D0
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V1.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D1
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D2
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D3
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V4.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D4
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D5
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D6
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V7.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D7
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D8
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D9
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V10.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D10
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D11
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V12.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D12
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D13
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D14
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D15
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D16
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D17
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V18.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D18
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V19.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D19
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V20.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D20
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D21
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D22
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D23
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D24
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D25
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D26
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D27
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D28
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D29
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V30.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D30
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, D31
    SUB  X4, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    FMOV  V0.D[1], X21
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X4
    FMOV  D3, X10
    FMOV  V3.D[1], X27
    FMOV  D4, X26
    FMOV  V4.D[1], X5
    FMOV  D5, X19
    FMOV  V5.D[1], X18
    FMOV  D6, X17
    FMOV  V6.D[1], X2
    FMOV  D7, X16
    FMOV  V7.D[1], X28
    FMOV  D8, X21
    FMOV  V8.D[1], X9
    FMOV  D9, X12
    FMOV  V9.D[1], X6
    FMOV  D10, X19
    FMOV  V10.D[1], X4
    FMOV  D11, X6
    FMOV  V11.D[1], X9
    FMOV  D12, X20
    FMOV  V12.D[1], X16
    FMOV  D13, X17
    FMOV  V13.D[1], X27
    FMOV  D14, X2
    FMOV  V14.D[1], X22
    FMOV  D15, X25
    FMOV  V15.D[1], X19
    FMOV  D16, X28
    FMOV  V16.D[1], X16
    FMOV  D17, X8
    FMOV  V17.D[1], X6
    FMOV  D18, X22
    FMOV  V18.D[1], X26
    FMOV  D19, X6
    FMOV  V19.D[1], X25
    FMOV  D20, X12
    FMOV  V20.D[1], X2
    FMOV  D21, X5
    FMOV  V21.D[1], X21
    FMOV  D22, X21
    FMOV  V22.D[1], X13
    FMOV  D23, X26
    FMOV  V23.D[1], X22
    FMOV  D24, X27
    FMOV  V24.D[1], X19
    FMOV  D25, X7
    FMOV  V25.D[1], X14
    FMOV  D26, X29
    FMOV  V26.D[1], X10
    FMOV  D27, X20
    FMOV  V27.D[1], X7
    FMOV  D28, X7
    FMOV  V28.D[1], X28
    FMOV  D29, X29
    FMOV  V29.D[1], X2
    FMOV  D30, X9
    FMOV  V30.D[1], X5
    FMOV  D31, X15
    FMOV  V31.D[1], X5
    MOVZ  X27, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_11:
    FCVTZU S0, S28, #32
    FCVTNU  H17, H0
    FCVTMS  D23, D27
    FCVTZU S15, S29, #17
    FCVTAU  H25, H21
    FCVTNS  S17, S30
    FCVTNS  D6, D26
    FCVTAU  D27, D6
    FCVTZS  H28, H31
    FCVTXN  S8, D24
    FCVTZU  D18, D23
    FCVTXN  S10, D28
    FCVTPS  D7, D12
    FCVTNU  D9, D27
    FCVTZS  D11, D29
    FCVTPU  H25, H18
    FCVTPU  D29, D15
    FCVTPS  H29, H17
    FCVTZU D13, D29, #63
    FCVTNU  H26, H9
    FCVTZS  H23, H8
    FCVTMU  H29, H10
    FCVTMS  D10, D7
    FCVTXN  S0, D10
    FCVTMS  H29, H11
    FCVTAS  S28, S29
    FCVTAU  D15, D26
    FCVTAU  H29, H15
    FCVTAS  D17, D0
    FCVTXN  S31, D13
    FCVTZU  H18, H23
    FCVTNS  S13, S25
    FCVTAU  H24, H31
    FCVTAS  S6, S9
    FCVTMS  H26, H17
    FCVTPS  S9, S29
    FCVTMS  S8, S28
    FCVTZU H15, H8, #4
    FCVTZS  S8, S28
    FCVTMS  S0, S18
    FCVTPS  S11, S6
    FCVTPS  S10, S13
    FCVTZU S7, S11, #21
    FCVTPS  H23, H10
    FCVTZS H13, H8, #4
    FCVTXN  S8, D13
    FCVTMS  S28, S15
    FCVTXN  S29, D24
    FCVTMS  S24, S7
    FCVTNS  H28, H26
    FCVTZU  H17, H29
    FCVTZS  S25, S23
    FCVTPS  S18, S25
    FCVTPU  S25, S18
    FCVTNS  D18, D0
    FCVTZS  S10, S25
    FCVTNS  D25, D8
    FCVTZS  S6, S28
    FCVTNU  S26, S6
    FCVTZU D8, D26, #13
    FCVTPU  D28, D24
    FCVTNU  H29, H9
    FCVTPU  D11, D25
    FCVTZU  S14, S17
    FCVTAU  D25, D18
    FCVTPU  S9, S25
    FCVTMS  H6, H9
    FCVTNU  H23, H6
    FCVTPU  S6, S23
    FCVTAU  S0, S6
    FCVTPS  D23, D14
    FCVTNU  S7, S23
    FCVTZU S15, S11, #22
    FCVTPS  S13, S10
    FCVTZS H26, H29, #12
    FCVTPU  H11, H28
    FCVTPS  S23, S7
    FCVTNS  H24, H21
    FCVTZU S10, S8, #12
    FCVTXN  S9, D13
    FCVTNS  D14, D1
    FCVTZS  S6, S10
    FCVTAS  H25, H23
    FCVTAU  S29, S15
    FCVTZU  D18, D6
    FCVTPS  H7, H26
    FCVTAS  S26, S0
    FCVTZS  H0, H11
    FCVTNU  H28, H0
    FCVTZS S17, S26, #9
    FCVTPU  S23, S25
    FCVTZS  H0, H9
    FCVTNU  S25, S28
    FCVTZS  D28, D25
    FCVTAU  H11, H28
    FCVTPU  S28, S7
    FCVTZU  S15, S0
    FCVTAU  H10, H14
    FCVTXN  S25, D28
    FCVTNS  S7, S24
    FCVTPS  H9, H17
    FCVTZS D26, D9, #53
    FCVTNU  H0, H12
    FCVTAS  S1, S23
    FCVTPU  S24, S18
    FCVTAU  H28, H11
    FCVTZU D11, D29, #1
    FCVTZS  D14, D26
    FCVTZU H8, H24, #4
    FCVTAU  S24, S11
    FCVTNU  S9, S24
    FCVTNS  H17, H14
    FCVTNU  D14, D25
    FCVTMU  D12, D14
    FCVTAU  H23, H0
    FCVTZU  S0, S8
    FCVTAU  D24, D22
    FCVTZU  H14, H12
    FCVTZU S18, S17, #8
    FCVTMU  D29, D18
    FCVTAS  H11, H9
    FCVTZS S25, S23, #22
    FCVTPU  D9, D28
    FCVTMU  D8, D14
    FCVTMU  D26, D29
    FCVTPS  S29, S25
    FCVTPU  S22, S9
    FCVTMU  D28, D29
    FCVTXN  S12, D11
    FCVTXN  S14, D12
    FCVTNU  D23, D22
    FCVTZS D29, D26, #5
    FCVTNU  H26, H1
    FCVTZS D18, D29, #64
    FCVTZS  D29, D19
    FCVTMS  H21, H14
    FCVTPU  H22, H8
    FCVTAU  D9, D24
    FCVTAU  H14, H9
    FCVTNU  H11, H29
    FCVTZU S8, S28, #11
    FCVTNS  S28, S14
    FCVTAU  H25, H26
    FCVTPS  S12, S28
    FCVTNU  S26, S22
    FCVTZU S19, S11, #21
    FCVTMS  S1, S30
    FCVTZS  D24, D23
    FCVTMS  H22, H21
    FCVTMS  H28, H18
    FCVTZS D30, D19, #8
    FCVTZS S11, S22, #21
    FCVTMU  S8, S28
    FCVTZU D14, D16, #28
    FCVTNS  D9, D25
    FCVTNU  D29, D9
    FCVTXN  S9, D26
    FCVTZS  S18, S11
    FCVTZU  H21, H11
    FCVTNU  D23, D12
    FCVTZU  H12, H1
    FCVTZU  S22, S29
    FCVTMS  S29, S23
    FCVTAS  S23, S8
    FCVTPS  H8, H22
    FCVTZS  S28, S8
    FCVTAS  D19, D6
    FCVTNS  S16, S14
    FCVTAS  H6, H19
    FCVTAS  S19, S29
    FCVTNS  D26, D23
    FCVTZU  H29, H24
    FCVTNU  D11, D12
    FCVTNS  S18, S9
    FCVTAU  D1, D29
    FCVTNS  S23, S1
    FCVTZS S8, S16, #30
    FCVTNU  H29, H26
    FCVTNU  H24, H21
    FCVTPS  S14, S18
    FCVTZU  H9, H8
    FCVTZU  D22, D11
    FCVTPU  D8, D9
    FCVTNU  H12, H8
    FCVTZU  D18, D14
    FCVTZU S1, S29, #32
    FCVTPS  H29, H24
    FCVTPU  D11, D19
    FCVTAS  D9, D23
    FCVTMS  S23, S22
    FCVTNS  D24, D29
    FCVTZS  S19, S24
    FCVTMS  H22, H18
    FCVTZS S24, S9, #7
    FCVTNS  D9, D22
    FCVTPU  S9, S24
    FCVTMS  S16, S6
    FCVTZS S26, S12, #13
    FCVTZU  S8, S26
    FCVTPU  S12, S9
    SUBS  X27, X27, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_11
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x99, LSL #0
    MRS  X13, FPSR
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D0
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D1
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, V2.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, D2
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, V3.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, D3
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, V4.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, D4
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, V5.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, D5
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D6
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D7
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D8
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D9
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D10
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D11
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D12
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D13
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D14
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D16
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D17
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D19
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, V20.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X13, D20
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D21
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D22
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D23
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D24
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D25
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D26
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D27
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D28
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D29
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D30
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, D31
    SUB  X18, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xc1b5, LSL #0
    MOVK  X2, #0x4048, LSL #16
    MOVK  X2, #0x4bcc, LSL #32
    MOVK  X2, #0xe5e4, LSL #48
    MOVZ  X4, #0xd2ae, LSL #0
    MOVK  X4, #0xe0c2, LSL #16
    MOVK  X4, #0xc195, LSL #32
    MOVK  X4, #0x2a18, LSL #48
    MOVZ  X5, #0x75c9, LSL #0
    MOVK  X5, #0xa7fb, LSL #16
    MOVK  X5, #0x7d5b, LSL #32
    MOVK  X5, #0xaf79, LSL #48
    MOVZ  X6, #0x8ca1, LSL #0
    MOVK  X6, #0xf479, LSL #16
    MOVK  X6, #0xfd7a, LSL #32
    MOVK  X6, #0x299d, LSL #48
    MOVZ  X7, #0xe27e, LSL #0
    MOVK  X7, #0xa9c0, LSL #16
    MOVK  X7, #0x4fba, LSL #32
    MOVK  X7, #0x3918, LSL #48
    MOVZ  X8, #0xe418, LSL #0
    MOVK  X8, #0xdf43, LSL #16
    MOVK  X8, #0xa4cb, LSL #32
    MOVK  X8, #0xcc2, LSL #48
    MOVZ  X9, #0x82c5, LSL #0
    MOVK  X9, #0xac3b, LSL #16
    MOVK  X9, #0xbc34, LSL #32
    MOVK  X9, #0x12b, LSL #48
    MOVZ  X10, #0x78db, LSL #0
    MOVK  X10, #0x4a90, LSL #16
    MOVK  X10, #0x7c4b, LSL #32
    MOVK  X10, #0x1057, LSL #48
    MOVZ  X12, #0xb5c5, LSL #0
    MOVK  X12, #0x7463, LSL #16
    MOVK  X12, #0x1214, LSL #32
    MOVK  X12, #0x6809, LSL #48
    MOVZ  X13, #0x8bf7, LSL #0
    MOVK  X13, #0x4ef3, LSL #16
    MOVK  X13, #0x87b2, LSL #32
    MOVK  X13, #0x6143, LSL #48
    MOVZ  X14, #0xaaa3, LSL #0
    MOVK  X14, #0x61ab, LSL #16
    MOVK  X14, #0x7df1, LSL #32
    MOVK  X14, #0x6f91, LSL #48
    MOVZ  X15, #0x13e4, LSL #0
    MOVK  X15, #0x21bf, LSL #16
    MOVK  X15, #0x5632, LSL #32
    MOVK  X15, #0xb590, LSL #48
    MOVZ  X16, #0x74b, LSL #0
    MOVK  X16, #0x5675, LSL #16
    MOVK  X16, #0xafb9, LSL #32
    MOVK  X16, #0x3637, LSL #48
    MOVZ  X17, #0xfbf2, LSL #0
    MOVK  X17, #0xf0cb, LSL #16
    MOVK  X17, #0x1518, LSL #32
    MOVK  X17, #0x26f1, LSL #48
    MOVZ  X18, #0x506e, LSL #0
    MOVK  X18, #0x349d, LSL #16
    MOVK  X18, #0xb638, LSL #32
    MOVK  X18, #0x174, LSL #48
    MOVZ  X19, #0x39aa, LSL #0
    MOVK  X19, #0xe9fc, LSL #16
    MOVK  X19, #0x9829, LSL #32
    MOVK  X19, #0xc164, LSL #48
    MOVZ  X20, #0x7fc9, LSL #0
    MOVK  X20, #0xe03b, LSL #16
    MOVK  X20, #0xbb9e, LSL #32
    MOVK  X20, #0x84e7, LSL #48
    MOVZ  X21, #0xffe8, LSL #0
    MOVK  X21, #0xd815, LSL #16
    MOVK  X21, #0x1fa, LSL #32
    MOVK  X21, #0xf61a, LSL #48
    MOVZ  X22, #0x4e42, LSL #0
    MOVK  X22, #0x79a9, LSL #16
    MOVK  X22, #0xe8, LSL #32
    MOVK  X22, #0x1a46, LSL #48
    MOVZ  X25, #0xed8e, LSL #0
    MOVK  X25, #0xc9d4, LSL #16
    MOVK  X25, #0x2c19, LSL #32
    MOVK  X25, #0xc0cf, LSL #48
    MOVZ  X26, #0x4888, LSL #0
    MOVK  X26, #0x7ae2, LSL #16
    MOVK  X26, #0xbb26, LSL #32
    MOVK  X26, #0x8f84, LSL #48
    MOVZ  X27, #0x7d59, LSL #0
    MOVK  X27, #0x1ff9, LSL #16
    MOVK  X27, #0xdfcd, LSL #32
    MOVK  X27, #0xfc2c, LSL #48
    MOVZ  X28, #0x9d60, LSL #0
    MOVK  X28, #0xe477, LSL #16
    MOVK  X28, #0xaf9b, LSL #32
    MOVK  X28, #0x64d5, LSL #48
    MOVZ  X29, #0xf79a, LSL #0
    MOVK  X29, #0x9e49, LSL #16
    MOVK  X29, #0x8391, LSL #32
    MOVK  X29, #0xa0f7, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X22
    FMOV  D1, X21
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X15
    FMOV  V3.D[1], X5
    FMOV  D4, X10
    FMOV  V4.D[1], X22
    FMOV  D5, X2
    FMOV  V5.D[1], X20
    FMOV  D6, X20
    FMOV  V6.D[1], X8
    FMOV  D7, X7
    FMOV  V7.D[1], X16
    FMOV  D8, X6
    FMOV  V8.D[1], X13
    FMOV  D9, X7
    FMOV  V9.D[1], X18
    FMOV  D10, X2
    FMOV  V10.D[1], X13
    FMOV  D11, X2
    FMOV  V11.D[1], X10
    FMOV  D12, X27
    FMOV  V12.D[1], X22
    FMOV  D13, X20
    FMOV  V13.D[1], X10
    FMOV  D14, X9
    FMOV  V14.D[1], X19
    FMOV  D15, X2
    FMOV  V15.D[1], X12
    FMOV  D16, X7
    FMOV  V16.D[1], X21
    FMOV  D17, X17
    FMOV  V17.D[1], X16
    FMOV  D18, X22
    FMOV  V18.D[1], X4
    FMOV  D19, X4
    FMOV  V19.D[1], X22
    FMOV  D20, X15
    FMOV  V20.D[1], X25
    FMOV  D21, X21
    FMOV  V21.D[1], X19
    FMOV  D22, X18
    FMOV  V22.D[1], X2
    FMOV  D23, X2
    FMOV  V23.D[1], X14
    FMOV  D24, X18
    FMOV  V24.D[1], X5
    FMOV  D25, X6
    FMOV  V25.D[1], X12
    FMOV  D26, X19
    FMOV  V26.D[1], X2
    FMOV  D27, X21
    FMOV  V27.D[1], X27
    FMOV  D28, X20
    FMOV  V28.D[1], X25
    FMOV  D29, X18
    FMOV  V29.D[1], X15
    FMOV  D30, X15
    FMOV  V30.D[1], X18
    FMOV  D31, X13
    FMOV  V31.D[1], X22
    MOVZ  X9, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_12:
    FCVTMS  S23, S28
    FCVTZU  H9, H27
    FCVTZS  D27, D23
    FCVTMS  H27, H9
    FCVTMS  S23, S25
    FCVTZU S18, S29, #22
    FCVTPU  H31, H20
    FCVTNU  S14, S26
    FCVTPU  H12, H14
    FCVTMS  S2, S31
    FCVTPS  H14, H2
    FCVTPU  S11, S14
    FCVTZU  D6, D12
    FCVTMU  D28, D27
    FCVTZS  H27, H18
    FCVTNS  D28, D23
    FCVTZS  H6, H28
    FCVTZS S17, S6, #21
    FCVTMS  D5, D27
    FCVTZS S7, S11, #21
    FCVTXN  S20, D17
    FCVTZS  H12, H20
    FCVTMS  D23, D30
    FCVTZU S26, S5, #14
    FCVTNS  S9, S7
    FCVTXN  S18, D9
    FCVTMS  D5, D26
    FCVTZU  D25, D12
    FCVTAS  S27, S25
    FCVTNU  D31, D27
    FCVTMU  D26, D5
    FCVTNS  H20, H23
    FCVTAU  H17, H18
    FCVTPS  D6, D17
    FCVTNU  H5, H6
    FCVTZS  H23, H26
    FCVTMU  D28, D23
    FCVTNU  H14, H28
    FCVTNS  H17, H12
    FCVTAS  S23, S31
    FCVTPU  S28, S23
    FCVTZU H7, H20, #7
    FCVTNU  D6, D17
    FCVTPU  H18, H14
    FCVTAU  H20, H7
    FCVTAS  S9, S5
    FCVTPS  D25, D9
    FCVTZS S7, S28, #4
    FCVTMS  S27, S18
    FCVTNS  D5, D11
    FCVTAU  S12, S5
    FCVTZS  H11, H27
    FCVTZS  D26, D6
    FCVTPU  H6, H28
    FCVTZS  D31, D17
    FCVTZS  H17, H25
    FCVTPS  S23, S4
    FCVTZU  S25, S20
    FCVTNU  S28, S7
    FCVTZU S20, S23, #32
    FCVTAU  H23, H17
    FCVTNS  D27, D26
    FCVTZU S4, S27, #16
    FCVTPU  S14, S31
    FCVTMS  S31, S4
    FCVTAS  S18, S6
    FCVTZU  S7, S20
    FCVTZU  H5, H25
    FCVTAS  S17, S18
    FCVTMU  D18, D12
    FCVTZU  H26, H23
    FCVTMS  D27, D11
    FCVTNS  H4, H27
    FCVTNU  D27, D4
    FCVTZS H25, H26, #2
    FCVTZU H6, H5, #10
    FCVTNU  H12, H14
    FCVTZS S23, S25, #11
    FCVTPU  D5, D17
    FCVTAU  D27, D23
    FCVTNU  S20, S7
    FCVTMU  D25, D18
    FCVTNU  D7, D27
    FCVTNU  S17, S31
    FCVTZU  S14, S28
    FCVTZU  D31, D17
    FCVTPU  S11, S12
    FCVTNS  H12, H31
    FCVTPU  H18, H6
    FCVTMS  S6, S25
    FCVTZS  D23, D11
    FCVTZU S25, S14, #15
    FCVTMU  H17, H5
    FCVTMU  H26, H12
    FCVTAS  H27, H6
    FCVTAS  S31, S20
    FCVTZS  H12, H17
    FCVTNU  D20, D31
    FCVTNS  D14, D7
    FCVTXN  S4, D14
    FCVTPU  H7, H18
    FCVTZS D17, D25, #2
    FCVTAU  S31, S17
    FCVTAS  D17, D31
    FCVTMS  H5, H4
    FCVTAS  D14, D12
    FCVTAU  S12, S27
    FCVTMU  D6, D5
    FCVTNS  D25, D26
    FCVTMS  D31, D25
    FCVTNS  D26, D31
    FCVTPU  S25, S26
    FCVTXN  S18, D25
    FCVTAS  H27, H18
    FCVTZS D5, D12, #39
    FCVTAS  S12, S20
    FCVTAS  H11, H6
    FCVTPS  H4, H5
    FCVTAU  S31, S11
    FCVTNU  H26, H12
    FCVTMU  D25, D4
    FCVTNU  S4, S14
    FCVTMU  H13, H27
    FCVTZS  S27, S31
    FCVTNS  H12, H26
    FCVTAU  S26, S25
    FCVTZS S18, S4, #4
    FCVTNU  S4, S18
    FCVTZS  D25, D13
    FCVTZS  D13, D27
    FCVTPS  H20, H25
    FCVTNS  S11, S20
    FCVTAU  H11, H26
    FCVTZS  S25, S11
    FCVTZS S31, S13, #3
    FCVTPS  H18, H31
    FCVTAU  H27, H4
    FCVTPU  S20, S12
    FCVTPU  S14, S27
    FCVTZS  H27, H18
    FCVTPS  S26, S14
    FCVTAU  S31, S25
    FCVTNU  H6, H26
    FCVTMU  H18, H26
    FCVTMS  S5, S27
    FCVTNU  D27, D18
    FCVTAU  D26, D27
    FCVTZU  D25, D26
    FCVTAU  S0, S25
    FCVTZS D14, D31, #21
    FCVTZU  S4, S0
    FCVTZU  D26, D5
    FCVTAU  S27, S20
    FCVTAS  H0, H27
    FCVTAS  S18, S14
    FCVTPU  H25, H6
    FCVTNU  H31, H4
    FCVTAU  D4, D26
    FCVTZS  H5, H0
    FCVTPU  D6, D25
    FCVTPU  D20, D22
    FCVTZU  D27, D20
    FCVTMU  D25, D31
    FCVTMU  S22, S27
    FCVTMU  S26, S25
    FCVTZS H14, H22, #8
    FCVTNU  D0, D5
    FCVTAU  S5, S0
    FCVTMU  S20, S4
    FCVTAS  S31, S20
    FCVTNS  S25, S26
    FCVTZS H27, H6, #7
    FCVTPU  D6, D27
    FCVTNU  S4, S10
    FCVTPU  D15, D14
    FCVTNS  S14, S25
    FCVTZU D20, D18, #14
    FCVTNS  D22, D25
    FCVTMS  D5, D31
    FCVTZS  H0, H4
    FCVTPS  H15, H6
    FCVTZU  H26, H15
    FCVTMS  H5, H14
    FCVTZU  S10, S25
    FCVTPS  D26, D10
    FCVTPS  D15, D20
    FCVTMU  H20, H15
    FCVTPS  H4, H0
    FCVTPU  D0, D4
    FCVTPS  D28, D25
    FCVTMS  D10, D22
    FCVTMS  D18, D0
    FCVTNS  S27, S18
    FCVTZS  H15, H26
    FCVTZS S22, S15, #23
    FCVTZS D31, D20, #29
    FCVTPS  D26, D31
    FCVTPU  D0, D26
    FCVTNU  S4, S22
    FCVTZU H31, H28, #5
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_12
    MOVZ  X6, #0xc1b5, LSL #0
    MOVK  X6, #0x4048, LSL #16
    MOVK  X6, #0x4bcc, LSL #32
    MOVK  X6, #0xe5e4, LSL #48
    SUB  X13, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xd2ae, LSL #0
    MOVK  X6, #0xe0c2, LSL #16
    MOVK  X6, #0xc195, LSL #32
    MOVK  X6, #0x2a18, LSL #48
    SUB  X13, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x75c9, LSL #0
    MOVK  X6, #0xa7fb, LSL #16
    MOVK  X6, #0x7d5b, LSL #32
    MOVK  X6, #0xaf79, LSL #48
    SUB  X13, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xe27e, LSL #0
    MOVK  X6, #0xa9c0, LSL #16
    MOVK  X6, #0x4fba, LSL #32
    MOVK  X6, #0x3918, LSL #48
    SUB  X13, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xe418, LSL #0
    MOVK  X6, #0xdf43, LSL #16
    MOVK  X6, #0xa4cb, LSL #32
    MOVK  X6, #0xcc2, LSL #48
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x78db, LSL #0
    MOVK  X6, #0x4a90, LSL #16
    MOVK  X6, #0x7c4b, LSL #32
    MOVK  X6, #0x1057, LSL #48
    SUB  X13, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xb5c5, LSL #0
    MOVK  X6, #0x7463, LSL #16
    MOVK  X6, #0x1214, LSL #32
    MOVK  X6, #0x6809, LSL #48
    SUB  X13, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xaaa3, LSL #0
    MOVK  X6, #0x61ab, LSL #16
    MOVK  X6, #0x7df1, LSL #32
    MOVK  X6, #0x6f91, LSL #48
    SUB  X13, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x13e4, LSL #0
    MOVK  X6, #0x21bf, LSL #16
    MOVK  X6, #0x5632, LSL #32
    MOVK  X6, #0xb590, LSL #48
    SUB  X13, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x74b, LSL #0
    MOVK  X6, #0x5675, LSL #16
    MOVK  X6, #0xafb9, LSL #32
    MOVK  X6, #0x3637, LSL #48
    SUB  X13, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xfbf2, LSL #0
    MOVK  X6, #0xf0cb, LSL #16
    MOVK  X6, #0x1518, LSL #32
    MOVK  X6, #0x26f1, LSL #48
    SUB  X13, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x506e, LSL #0
    MOVK  X6, #0x349d, LSL #16
    MOVK  X6, #0xb638, LSL #32
    MOVK  X6, #0x174, LSL #48
    SUB  X13, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x39aa, LSL #0
    MOVK  X6, #0xe9fc, LSL #16
    MOVK  X6, #0x9829, LSL #32
    MOVK  X6, #0xc164, LSL #48
    SUB  X13, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x7fc9, LSL #0
    MOVK  X6, #0xe03b, LSL #16
    MOVK  X6, #0xbb9e, LSL #32
    MOVK  X6, #0x84e7, LSL #48
    SUB  X13, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffe8, LSL #0
    MOVK  X6, #0xd815, LSL #16
    MOVK  X6, #0x1fa, LSL #32
    MOVK  X6, #0xf61a, LSL #48
    SUB  X13, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x4e42, LSL #0
    MOVK  X6, #0x79a9, LSL #16
    MOVK  X6, #0xe8, LSL #32
    MOVK  X6, #0x1a46, LSL #48
    SUB  X13, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xed8e, LSL #0
    MOVK  X6, #0xc9d4, LSL #16
    MOVK  X6, #0x2c19, LSL #32
    MOVK  X6, #0xc0cf, LSL #48
    SUB  X13, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x4888, LSL #0
    MOVK  X6, #0x7ae2, LSL #16
    MOVK  X6, #0xbb26, LSL #32
    MOVK  X6, #0x8f84, LSL #48
    SUB  X13, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x7d59, LSL #0
    MOVK  X6, #0x1ff9, LSL #16
    MOVK  X6, #0xdfcd, LSL #32
    MOVK  X6, #0xfc2c, LSL #48
    SUB  X13, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xf79a, LSL #0
    MOVK  X6, #0x9e49, LSL #16
    MOVK  X6, #0x8391, LSL #32
    MOVK  X6, #0xa0f7, LSL #48
    SUB  X13, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x99, LSL #0
    MRS  X13, FPSR
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D0
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x7d59, LSL #0
    MOVK  X6, #0x1ff9, LSL #16
    MOVK  X6, #0xdfcd, LSL #32
    MOVK  X6, #0xfc2c, LSL #48
    FMOV  X13, V1.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffe8, LSL #0
    MOVK  X6, #0xd815, LSL #16
    MOVK  X6, #0x1fa, LSL #32
    MOVK  X6, #0xf61a, LSL #48
    FMOV  X13, D1
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D2
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x75c9, LSL #0
    MOVK  X6, #0xa7fb, LSL #16
    MOVK  X6, #0x7d5b, LSL #32
    MOVK  X6, #0xaf79, LSL #48
    FMOV  X13, V3.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x13e4, LSL #0
    MOVK  X6, #0x21bf, LSL #16
    MOVK  X6, #0x5632, LSL #32
    MOVK  X6, #0xb590, LSL #48
    FMOV  X13, D3
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D4
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D5
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D6
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D7
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x8bf7, LSL #0
    MOVK  X6, #0x4ef3, LSL #16
    MOVK  X6, #0x87b2, LSL #32
    MOVK  X6, #0x6143, LSL #48
    FMOV  X13, V8.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x8ca1, LSL #0
    MOVK  X6, #0xf479, LSL #16
    MOVK  X6, #0xfd7a, LSL #32
    MOVK  X6, #0x299d, LSL #48
    FMOV  X13, D8
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D9
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D10
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D11
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D12
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D13
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D14
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffe8, LSL #0
    MOVK  X6, #0xd815, LSL #16
    MOVK  X6, #0x1fa, LSL #32
    MOVK  X6, #0xf61a, LSL #48
    FMOV  X13, V16.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xe27e, LSL #0
    MOVK  X6, #0xa9c0, LSL #16
    MOVK  X6, #0x4fba, LSL #32
    MOVK  X6, #0x3918, LSL #48
    FMOV  X13, D16
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D17
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x4e42, LSL #0
    MOVK  X6, #0x79a9, LSL #16
    MOVK  X6, #0xe8, LSL #32
    MOVK  X6, #0x1a46, LSL #48
    FMOV  X13, V19.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xd2ae, LSL #0
    MOVK  X6, #0xe0c2, LSL #16
    MOVK  X6, #0xc195, LSL #32
    MOVK  X6, #0x2a18, LSL #48
    FMOV  X13, D19
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D20
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x39aa, LSL #0
    MOVK  X6, #0xe9fc, LSL #16
    MOVK  X6, #0x9829, LSL #32
    MOVK  X6, #0xc164, LSL #48
    FMOV  X13, V21.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0xffe8, LSL #0
    MOVK  X6, #0xd815, LSL #16
    MOVK  X6, #0x1fa, LSL #32
    MOVK  X6, #0xf61a, LSL #48
    FMOV  X13, D21
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D22
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D23
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x75c9, LSL #0
    MOVK  X6, #0xa7fb, LSL #16
    MOVK  X6, #0x7d5b, LSL #32
    MOVK  X6, #0xaf79, LSL #48
    FMOV  X13, V24.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x506e, LSL #0
    MOVK  X6, #0x349d, LSL #16
    MOVK  X6, #0xb638, LSL #32
    MOVK  X6, #0x174, LSL #48
    FMOV  X13, D24
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D25
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D26
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D27
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D28
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x13e4, LSL #0
    MOVK  X6, #0x21bf, LSL #16
    MOVK  X6, #0x5632, LSL #32
    MOVK  X6, #0xb590, LSL #48
    FMOV  X13, V29.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x506e, LSL #0
    MOVK  X6, #0x349d, LSL #16
    MOVK  X6, #0xb638, LSL #32
    MOVK  X6, #0x174, LSL #48
    FMOV  X13, D29
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x506e, LSL #0
    MOVK  X6, #0x349d, LSL #16
    MOVK  X6, #0xb638, LSL #32
    MOVK  X6, #0x174, LSL #48
    FMOV  X13, V30.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x13e4, LSL #0
    MOVK  X6, #0x21bf, LSL #16
    MOVK  X6, #0x5632, LSL #32
    MOVK  X6, #0xb590, LSL #48
    FMOV  X13, D30
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, D31
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X25
    FMOV  V0.D[1], X10
    FMOV  D1, X19
    FMOV  V1.D[1], X21
    FMOV  D2, X20
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X15
    FMOV  D4, X17
    FMOV  V4.D[1], X29
    FMOV  D5, X26
    FMOV  V5.D[1], X22
    FMOV  D6, X6
    FMOV  V6.D[1], X13
    FMOV  D7, X13
    FMOV  V7.D[1], X4
    FMOV  D8, X16
    FMOV  V8.D[1], X18
    FMOV  D9, X17
    FMOV  V9.D[1], X19
    FMOV  D10, X8
    FMOV  V10.D[1], X5
    FMOV  D11, X25
    FMOV  V11.D[1], X14
    FMOV  D12, X18
    FMOV  V12.D[1], X29
    FMOV  D13, X7
    FMOV  V13.D[1], X9
    FMOV  D14, X20
    FMOV  V14.D[1], X17
    FMOV  D15, X27
    FMOV  V15.D[1], X2
    FMOV  D16, X17
    FMOV  V16.D[1], X9
    FMOV  D17, X28
    FMOV  V17.D[1], X5
    FMOV  D18, X27
    FMOV  V18.D[1], X15
    FMOV  D19, X25
    FMOV  V19.D[1], X25
    FMOV  D20, X14
    FMOV  V20.D[1], X17
    FMOV  D21, X17
    FMOV  V21.D[1], X12
    FMOV  D22, X21
    FMOV  V22.D[1], X21
    FMOV  D23, X16
    FMOV  V23.D[1], X28
    FMOV  D24, X21
    FMOV  V24.D[1], X19
    FMOV  D25, X7
    FMOV  V25.D[1], X25
    FMOV  D26, X19
    FMOV  V26.D[1], X5
    FMOV  D27, X8
    FMOV  V27.D[1], X6
    FMOV  D28, X29
    FMOV  V28.D[1], X28
    FMOV  D29, X5
    FMOV  V29.D[1], X16
    FMOV  D30, X21
    FMOV  V30.D[1], X27
    FMOV  D31, X7
    FMOV  V31.D[1], X16
    MOVZ  X25, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_13:
    FCVTMU  S0, S21
    FCVTZU S20, S0, #17
    FCVTZS S16, S26, #8
    FCVTZS D0, D20, #42
    FCVTZU  H25, H30
    FCVTZU  S0, S25
    FCVTZU S18, S31, #6
    FCVTPS  D31, D16
    FCVTMU  D27, D27
    FCVTNS  H27, H29
    FCVTMS  D10, D27
    FCVTNU  S6, S23
    FCVTNS  H9, H10
    FCVTZS  D19, D0
    FCVTZS H30, H6, #4
    FCVTNU  S21, S18
    FCVTNU  D4, D31
    FCVTMU  H15, H30
    FCVTZU  D28, D9
    FCVTAU  D28, D28
    FCVTZU D28, D21, #48
    FCVTMU  D29, D18
    FCVTPU  S0, S29
    FCVTAU  H21, H4
    FCVTZS  D26, D24
    FCVTZS  D30, D19
    FCVTXN  S16, D26
    FCVTPS  H18, H28
    FCVTZU S24, S0, #29
    FCVTPU  H0, H15
    FCVTZS S4, S21, #5
    FCVTAS  D26, D16
    FCVTPU  D16, D26
    FCVTZS S31, S30, #20
    FCVTPS  D26, D0
    FCVTMS  D21, D26
    FCVTMS  S26, S18
    FCVTAU  H9, H4
    FCVTNU  S28, S31
    FCVTNS  D30, D28
    FCVTZS  H18, H26
    FCVTZS  H26, H24
    FCVTPS  S19, S30
    FCVTZS  D0, D16
    FCVTZS S31, S21, #26
    FCVTPS  H29, H31
    FCVTZS S4, S0, #26
    FCVTAU  S31, S29
    FCVTNU  D31, D9
    FCVTMS  S21, S26
    FCVTMS  H29, H19
    FCVTNS  D26, D21
    FCVTZS D30, D26, #20
    FCVTZU H21, H31, #9
    FCVTAU  D31, D29
    FCVTNU  H28, H18
    FCVTMU  D29, D31
    FCVTZS  S18, S21
    FCVTNS  D31, D28
    FCVTPU  S9, S30
    FCVTPS  S19, S29
    FCVTAS  S28, S4
    FCVTZU  S16, S27
    FCVTXN  S29, D16
    FCVTZU  D4, D28
    FCVTNS  H26, H4
    FCVTNS  H21, H31
    FCVTMS  H31, H18
    FCVTZU D24, D9, #51
    FCVTZU  D27, D26
    FCVTNS  H26, H29
    FCVTXN  S4, D27
    FCVTAU  S28, S24
    FCVTNU  S29, S19
    FCVTZS  H30, H26
    FCVTNS  S18, S28
    FCVTNU  H28, H4
    FCVTMU  D4, D28
    FCVTNU  H26, H31
    FCVTNU  D24, D18
    FCVTAU  H16, H24
    FCVTZS  S31, S21
    FCVTMU  D19, D30
    FCVTNS  H9, H4
    FCVTAU  S27, S9
    FCVTPU  S18, S27
    FCVTZS  D28, D29
    FCVTNS  S4, S19
    FCVTZS  S29, S31
    FCVTZS S19, S26, #19
    FCVTPU  S31, S19
    FCVTZU  S31, S28
    FCVTZS  D21, D4
    FCVTAU  S19, S18
    FCVTNS  H18, H19
    FCVTXN  S4, D18
    FCVTPS  S9, S16
    FCVTZS  H27, H19
    FCVTZS  H18, H9
    FCVTMS  D28, D31
    FCVTZU D26, D27, #57
    FCVTZU H30, H18, #8
    FCVTZU S16, S29, #21
    FCVTMU  D19, D4
    FCVTPU  D29, D21
    FCVTMS  D9, D28
    FCVTAS  D28, D29
    FCVTZS H27, H16, #16
    FCVTNU  H29, H26
    FCVTNU  S18, S28
    FCVTZU D4, D9, #44
    FCVTZS  S31, S18
    FCVTZS S0, S27, #12
    FCVTZS  H28, H29
    FCVTZS  H9, H28
    FCVTZU  S16, S19
    FCVTNS  S27, S0
    FCVTAU  H21, H16
    FCVTNS  S18, S21
    FCVTAU  H6, H30
    FCVTAS  H18, H4
    FCVTMS  S29, S6
    FCVTAS  D22, D9
    FCVTAS  D7, D18
    FCVTPU  H26, H31
    FCVTPS  D0, D7
    FCVTAS  H4, H0
    FCVTAS  S6, S26
    FCVTAS  S31, S6
    FCVTMS  D29, D4
    FCVTAS  S21, S27
    FCVTZS H9, H6, #3
    FCVTMS  H30, H9
    FCVTPU  S16, S30
    FCVTPU  D4, D16
    FCVTZS  S16, S21
    FCVTMU  H21, H22
    FCVTNU  S30, S31
    FCVTXN  S7, D16
    FCVTNU  H31, H29
    FCVTNU  D18, D21
    FCVTNS  H26, H18
    FCVTNS  S27, S3
    FCVTNU  D3, D31
    FCVTPU  H9, H26
    FCVTAS  H6, H7
    FCVTMU  H21, H3
    FCVTMU  D26, D30
    FCVTAS  S31, S14
    FCVTZS  S0, S26
    FCVTNS  D7, D26
    FCVTZS D14, D27, #57
    FCVTPU  H27, H6
    FCVTMS  S26, S27
    FCVTNS  D30, D4
    FCVTNU  S18, S9
    FCVTNU  D3, D14
    FCVTMS  H29, H2
    FCVTNU  S16, S18
    FCVTMU  S6, S16
    FCVTMU  S2, S4
    FCVTPS  D4, D21
    FCVTMU  H14, H4
    FCVTNU  H27, H7
    FCVTNU  D9, D26
    FCVTMU  S21, S30
    FCVTMS  D26, D3
    FCVTZS D21, D14, #60
    FCVTPS  D14, D6
    FCVTNU  D4, D26
    FCVTMS  H18, H27
    FCVTMS  D26, D29
    FCVTAU  D16, D18
    FCVTMS  S2, S2
    FCVTNU  H18, H14
    FCVTMS  H7, H9
    FCVTPU  D9, D21
    FCVTZS S29, S7, #27
    FCVTXN  S30, D4
    FCVTAS  D21, D16
    FCVTZS S7, S21, #13
    FCVTNU  D3, D26
    FCVTNU  S27, S2
    FCVTZS  S8, S13
    FCVTZU H4, H18, #16
    FCVTZU H2, H4, #6
    FCVTNU  D26, D3
    FCVTMS  D29, D9
    FCVTZU D8, D30, #27
    FCVTAS  H16, H8
    FCVTPU  D21, D7
    FCVTZU  H6, H16
    FCVTZS  D30, D21
    FCVTNS  S9, S26
    FCVTMU  H3, H6
    FCVTPS  D14, D8
    FCVTPS  D7, D2
    FCVTMS  D2, D27
    FCVTZS H6, H2, #1
    FCVTPS  D21, D29
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_13
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x99, LSL #0
    MRS  X29, FPSR
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D0
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D1
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D2
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D3
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D4
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D5
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D6
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D7
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D8
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D9
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D10
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D11
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D12
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D13
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D14
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D15
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D16
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D17
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D18
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D19
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D20
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D21
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D22
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D23
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D24
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D25
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D26
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D27
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D28
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D29
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D30
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D31
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X28
    FMOV  D3, X20
    FMOV  V3.D[1], X9
    FMOV  D4, X7
    FMOV  V4.D[1], X9
    FMOV  D5, X15
    FMOV  V5.D[1], X19
    FMOV  D6, X15
    FMOV  V6.D[1], X16
    FMOV  D7, X7
    FMOV  V7.D[1], X21
    FMOV  D8, X14
    FMOV  V8.D[1], X26
    FMOV  D9, X13
    FMOV  V9.D[1], X16
    FMOV  D10, X19
    FMOV  V10.D[1], X5
    FMOV  D11, X16
    FMOV  V11.D[1], X20
    FMOV  D12, X13
    FMOV  V12.D[1], X15
    FMOV  D13, X15
    FMOV  V13.D[1], X19
    FMOV  D14, X25
    FMOV  V14.D[1], X25
    FMOV  D15, X25
    FMOV  V15.D[1], X17
    FMOV  D16, X18
    FMOV  V16.D[1], X10
    FMOV  D17, X27
    FMOV  V17.D[1], X27
    FMOV  D18, X9
    FMOV  V18.D[1], X27
    FMOV  D19, X18
    FMOV  V19.D[1], X12
    FMOV  D20, X18
    FMOV  V20.D[1], X18
    FMOV  D21, X13
    FMOV  V21.D[1], X9
    FMOV  D22, X10
    FMOV  V22.D[1], X16
    FMOV  D23, X12
    FMOV  V23.D[1], X28
    FMOV  D24, X7
    FMOV  V24.D[1], X22
    FMOV  D25, X4
    FMOV  V25.D[1], X13
    FMOV  D26, X4
    FMOV  V26.D[1], X29
    FMOV  D27, X17
    FMOV  V27.D[1], X5
    FMOV  D28, X2
    FMOV  V28.D[1], X5
    FMOV  D29, X16
    FMOV  V29.D[1], X12
    FMOV  D30, X16
    FMOV  V30.D[1], X15
    FMOV  D31, X27
    FMOV  V31.D[1], X17
    MOVZ  X22, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_14:
    FCVTZS S9, S29, #12
    FCVTZS S27, S22, #14
    FCVTPS  H28, H28
    FCVTNS  H4, H27
    FCVTPS  H0, H30
    FCVTAU  D9, D0
    FCVTPS  S8, S28
    FCVTZS H14, H4, #3
    FCVTAS  H3, H9
    FCVTAU  H29, H31
    FCVTPS  D10, D23
    FCVTNU  D26, D10
    FCVTMU  H9, H26
    FCVTAU  H2, H8
    FCVTZU  H7, H14
    FCVTMU  S20, S7
    FCVTAU  S20, S3
    FCVTZS H15, H29, #1
    FCVTNU  H10, H15
    FCVTNU  H12, H19
    FCVTAS  S30, S20
    FCVTNS  H15, H12
    FCVTZU S8, S10, #9
    FCVTPU  H7, H9
    FCVTNS  H31, H2
    FCVTZS  S9, S15
    FCVTPU  D14, D30
    FCVTNS  H20, H7
    FCVTAS  H19, H8
    FCVTPU  S10, S19
    FCVTZS  S29, S20
    FCVTMU  H3, H14
    FCVTNS  S12, S31
    FCVTNS  S31, S3
    FCVTMS  S20, S12
    FCVTNU  S8, S20
    FCVTXN  S20, D8
    FCVTZU S8, S9, #3
    FCVTZS D3, D2, #51
    FCVTAS  D12, D3
    FCVTZS  H9, H31
    FCVTNU  D19, D10
    FCVTMU  S14, S9
    FCVTMS  S10, S14
    FCVTNU  D2, D10
    FCVTAS  S3, S2
    FCVTNS  H14, H20
    FCVTXN  S7, D29
    FCVTNU  S31, S7
    FCVTZS H9, H12, #9
    FCVTZS  S2, S8
    FCVTMS  S20, S7
    FCVTMU  S29, S20
    FCVTAU  D20, D9
    FCVTMS  H12, H29
    FCVTZS  H10, H14
    FCVTZS  D14, D12
    FCVTZS  D12, D31
    FCVTAU  S8, S19
    FCVTNS  S7, S14
    FCVTMU  D9, D7
    FCVTNU  D19, D8
    FCVTZS  H26, H10
    FCVTMS  D8, D12
    FCVTPU  S7, S2
    FCVTPS  D5, D9
    FCVTNS  H2, H7
    FCVTPU  H7, H2
    FCVTMS  H14, H20
    FCVTPS  D9, D8
    FCVTZS  D10, D14
    FCVTNS  H20, H3
    FCVTZS H31, H20, #1
    FCVTNU  D12, D19
    FCVTZS  S2, S26
    FCVTZU D8, D31, #17
    FCVTNU  S31, S12
    FCVTPS  H14, H3
    FCVTNU  H3, H8
    FCVTAS  S20, S2
    FCVTPU  S29, S7
    FCVTMU  S19, S9
    FCVTNU  H7, H10
    FCVTMS  D8, D3
    FCVTZS  D2, D20
    FCVTMS  H26, H14
    FCVTZU D10, D26, #16
    FCVTPU  H3, H7
    FCVTMS  S26, S5
    FCVTNS  H20, H26
    FCVTPS  H9, H31
    FCVTAS  D1, D3
    FCVTZS  D26, D1
    FCVTAS  S12, S26
    FCVTZU  S1, S2
    FCVTZU S14, S8, #5
    FCVTPU  D7, D20
    FCVTNU  D5, D19
    FCVTAU  D8, D9
    FCVTMS  H9, H7
    FCVTAS  D31, D0
    FCVTAS  D19, D29
    FCVTNU  S29, S9
    FCVTMU  S20, S5
    FCVTPU  S3, S14
    FCVTNS  S14, S1
    FCVTZS  S5, S10
    FCVTMS  S0, S20
    FCVTZU D10, D19, #61
    FCVTZS D9, D29, #37
    FCVTPU  S29, S3
    FCVTAU  D3, D5
    FCVTPS  S2, S31
    FCVTMS  D28, D12
    FCVTNS  S5, S9
    FCVTMS  S26, S10
    FCVTZS H9, H8, #1
    FCVTMU  H20, H14
    FCVTPU  S31, S0
    FCVTZU  D12, D29
    FCVTZS H0, H20, #13
    FCVTPU  H1, H2
    FCVTPU  D7, D1
    FCVTMS  H19, H29
    FCVTZS  D20, D7
    FCVTMS  H2, H31
    FCVTXN  S10, D12
    FCVTMU  H12, H10
    FCVTAS  H1, H2
    FCVTZU D2, D19, #17
    FCVTZS  S8, S28
    FCVTPS  S28, S9
    FCVTMU  D7, D3
    FCVTMS  S9, S2
    FCVTAS  S14, S26
    FCVTPU  D2, D7
    FCVTAS  H31, H5
    FCVTMS  H26, H29
    FCVTNU  D5, D1
    FCVTZU S7, S29, #17
    FCVTAU  D1, D5
    FCVTMU  D5, D20
    FCVTNS  S29, S0
    FCVTPS  D3, D2
    FCVTAS  S20, S5
    FCVTAS  D5, D28
    FCVTAU  S28, S12
    FCVTPS  D0, D1
    FCVTAU  S1, S14
    FCVTNU  D2, D0
    FCVTMS  H19, H1
    FCVTZS  S1, S29
    FCVTZS D12, D2, #60
    FCVTZS  H14, H31
    FCVTPS  S31, S26
    FCVTPS  D26, D20
    FCVTNU  H20, H7
    FCVTZU  D2, D19
    FCVTZU S19, S28, #8
    FCVTZU H3, H14, #10
    FCVTMU  H29, H12
    FCVTNU  S14, S3
    FCVTZS H0, H26, #6
    FCVTPU  D26, D9
    FCVTZU  D7, D20
    FCVTNS  S28, S1
    FCVTZU  S12, S31
    FCVTNU  S17, S2
    FCVTPS  S31, S0
    FCVTPS  S2, S19
    FCVTNS  H0, H29
    FCVTPS  H19, H14
    FCVTZU D1, D2, #4
    FCVTMS  H29, H1
    FCVTMU  H20, H0
    FCVTAS  D2, D26
    FCVTMU  S1, S19
    FCVTMU  H4, H1
    FCVTMS  D26, D7
    FCVTAU  H0, H29
    FCVTPU  S29, S17
    FCVTMS  H14, H12
    FCVTZS S9, S31, #21
    FCVTMS  S19, S0
    FCVTAU  S12, S9
    FCVTZS  S1, S2
    FCVTPU  D0, D1
    FCVTPS  H17, H0
    FCVTZS  D0, D14
    FCVTZS  H7, H17
    FCVTNS  H31, H4
    FCVTAS  H4, H28
    FCVTNS  D2, D29
    FCVTZS H9, H19, #16
    FCVTNS  S19, S26
    FCVTMS  S26, S12
    FCVTZS  S1, S20
    FCVTZU H20, H7, #12
    FCVTZS D14, D20, #14
    FCVTPS  H29, H19
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_14
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x99, LSL #0
    MRS  X28, FPSR
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D0
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D1
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D2
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D3
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D4
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V5.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D5
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D6
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D7
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D8
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D9
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D10
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D11
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D12
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D13
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D14
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D15
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D16
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D17
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V18.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D18
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D19
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D20
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V21.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D21
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D22
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D23
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D24
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X28, D25
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D26
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D27
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D28
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D29
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D30
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V31.D[1]
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D31
    SUB  X10, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xfc59, LSL #0
    MOVK  X2, #0xae5, LSL #16
    MOVK  X2, #0xcd34, LSL #32
    MOVK  X2, #0x8d28, LSL #48
    MOVZ  X4, #0xcb7b, LSL #0
    MOVK  X4, #0x757d, LSL #16
    MOVK  X4, #0xe5b1, LSL #32
    MOVK  X4, #0x9c47, LSL #48
    MOVZ  X5, #0x3bb4, LSL #0
    MOVK  X5, #0x7b37, LSL #16
    MOVK  X5, #0x4ee8, LSL #32
    MOVK  X5, #0x4107, LSL #48
    MOVZ  X6, #0xd617, LSL #0
    MOVK  X6, #0x7c5a, LSL #16
    MOVK  X6, #0x578b, LSL #32
    MOVK  X6, #0xff1c, LSL #48
    MOVZ  X7, #0xa89b, LSL #0
    MOVK  X7, #0x3d9a, LSL #16
    MOVK  X7, #0xb545, LSL #32
    MOVK  X7, #0x385e, LSL #48
    MOVZ  X8, #0x1774, LSL #0
    MOVK  X8, #0x28d7, LSL #16
    MOVK  X8, #0x954b, LSL #32
    MOVK  X8, #0xd4d3, LSL #48
    MOVZ  X9, #0x6322, LSL #0
    MOVK  X9, #0xe43f, LSL #16
    MOVK  X9, #0x2657, LSL #32
    MOVK  X9, #0xfbf3, LSL #48
    MOVZ  X10, #0x40dc, LSL #0
    MOVK  X10, #0x51ef, LSL #16
    MOVK  X10, #0xc19, LSL #32
    MOVK  X10, #0x5834, LSL #48
    MOVZ  X12, #0xe247, LSL #0
    MOVK  X12, #0x9c72, LSL #16
    MOVK  X12, #0x5515, LSL #32
    MOVK  X12, #0x4739, LSL #48
    MOVZ  X13, #0x56dc, LSL #0
    MOVK  X13, #0x669e, LSL #16
    MOVK  X13, #0x3fc0, LSL #32
    MOVK  X13, #0x432c, LSL #48
    MOVZ  X14, #0xfe23, LSL #0
    MOVK  X14, #0x892f, LSL #16
    MOVK  X14, #0x864e, LSL #32
    MOVK  X14, #0x451, LSL #48
    MOVZ  X15, #0xcb4, LSL #0
    MOVK  X15, #0xad75, LSL #16
    MOVK  X15, #0x3ddd, LSL #32
    MOVK  X15, #0xff7c, LSL #48
    MOVZ  X16, #0xfb4b, LSL #0
    MOVK  X16, #0x3b3a, LSL #16
    MOVK  X16, #0x470, LSL #32
    MOVK  X16, #0x3e69, LSL #48
    MOVZ  X17, #0xbd81, LSL #0
    MOVK  X17, #0x2a75, LSL #16
    MOVK  X17, #0xbcbf, LSL #32
    MOVK  X17, #0x940e, LSL #48
    MOVZ  X18, #0x55ff, LSL #0
    MOVK  X18, #0x4100, LSL #16
    MOVK  X18, #0x1f2f, LSL #32
    MOVK  X18, #0xfe2d, LSL #48
    MOVZ  X19, #0x5126, LSL #0
    MOVK  X19, #0xbeaa, LSL #16
    MOVK  X19, #0x1760, LSL #32
    MOVK  X19, #0xb47, LSL #48
    MOVZ  X20, #0x46ba, LSL #0
    MOVK  X20, #0xa174, LSL #16
    MOVK  X20, #0xbccc, LSL #32
    MOVK  X20, #0x2b6f, LSL #48
    MOVZ  X21, #0x8b49, LSL #0
    MOVK  X21, #0x3c25, LSL #16
    MOVK  X21, #0xc699, LSL #32
    MOVK  X21, #0xb4d8, LSL #48
    MOVZ  X22, #0xe58f, LSL #0
    MOVK  X22, #0xa2c3, LSL #16
    MOVK  X22, #0x1753, LSL #32
    MOVK  X22, #0x8ed4, LSL #48
    MOVZ  X25, #0x3e35, LSL #0
    MOVK  X25, #0xc869, LSL #16
    MOVK  X25, #0x7913, LSL #32
    MOVK  X25, #0xc0ee, LSL #48
    MOVZ  X26, #0xcb3c, LSL #0
    MOVK  X26, #0x92b7, LSL #16
    MOVK  X26, #0xf6c0, LSL #32
    MOVK  X26, #0x350f, LSL #48
    MOVZ  X27, #0x72e7, LSL #0
    MOVK  X27, #0x92d6, LSL #16
    MOVK  X27, #0xffbf, LSL #32
    MOVK  X27, #0xcd8d, LSL #48
    MOVZ  X28, #0x8559, LSL #0
    MOVK  X28, #0xe437, LSL #16
    MOVK  X28, #0xf26e, LSL #32
    MOVK  X28, #0xf0ac, LSL #48
    MOVZ  X29, #0x478d, LSL #0
    MOVK  X29, #0xb2b1, LSL #16
    MOVK  X29, #0x2d74, LSL #32
    MOVK  X29, #0x418, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X19
    FMOV  D3, X15
    FMOV  V3.D[1], X22
    FMOV  D4, X10
    FMOV  V4.D[1], X2
    FMOV  D5, X5
    FMOV  V5.D[1], X28
    FMOV  D6, X10
    FMOV  V6.D[1], X17
    FMOV  D7, X10
    FMOV  V7.D[1], X12
    FMOV  D8, X17
    FMOV  V8.D[1], X12
    FMOV  D9, X12
    FMOV  V9.D[1], X15
    FMOV  D10, X18
    FMOV  V10.D[1], X2
    FMOV  D11, X20
    FMOV  V11.D[1], X25
    FMOV  D12, X10
    FMOV  V12.D[1], X4
    FMOV  D13, X27
    FMOV  V13.D[1], X10
    FMOV  D14, X15
    FMOV  V14.D[1], X10
    FMOV  D15, X13
    FMOV  V15.D[1], X5
    FMOV  D16, X20
    FMOV  V16.D[1], X4
    FMOV  D17, X16
    FMOV  V17.D[1], X2
    FMOV  D18, X27
    FMOV  V18.D[1], X4
    FMOV  D19, X7
    FMOV  V19.D[1], X15
    FMOV  D20, X19
    FMOV  V20.D[1], X13
    FMOV  D21, X18
    FMOV  V21.D[1], X27
    FMOV  D22, X20
    FMOV  V22.D[1], X17
    FMOV  D23, X22
    FMOV  V23.D[1], X16
    FMOV  D24, X9
    FMOV  V24.D[1], X4
    FMOV  D25, X15
    FMOV  V25.D[1], X26
    FMOV  D26, X16
    FMOV  V26.D[1], X7
    FMOV  D27, X13
    FMOV  V27.D[1], X2
    FMOV  D28, X9
    FMOV  V28.D[1], X13
    FMOV  D29, X5
    FMOV  V29.D[1], X22
    FMOV  D30, X19
    FMOV  V30.D[1], X22
    FMOV  D31, X12
    FMOV  V31.D[1], X18
    MOVZ  X5, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_15:
    FCVTZS D10, D30, #17
    FCVTZS S30, S26, #28
    FCVTZU  S22, S25
    FCVTAU  S9, S24
    FCVTAU  S1, S31
    FCVTPU  D2, D10
    FCVTZU  S12, S29
    FCVTAS  S23, S22
    FCVTZU S14, S27, #27
    FCVTZU D19, D14, #55
    FCVTPU  S16, S9
    FCVTPS  D19, D23
    FCVTZS  S1, S16
    FCVTAS  H28, H1
    FCVTMS  S10, S2
    FCVTZS H14, H28, #1
    FCVTZS D10, D14, #14
    FCVTAS  D1, D19
    FCVTZS  D18, D10
    FCVTZU H1, H1, #1
    FCVTNU  H9, H12
    FCVTPU  H26, H30
    FCVTNS  S20, S1
    FCVTZU D10, D18, #29
    FCVTNS  H19, H20
    FCVTNU  D31, D19
    FCVTZS D29, D10, #25
    FCVTZU  H19, H26
    FCVTZS S12, S31, #26
    FCVTPU  S1, S9
    FCVTMS  D14, D1
    FCVTZU S28, S14, #16
    FCVTAS  H22, H19
    FCVTPS  S31, S12
    FCVTZU  S14, S29
    FCVTZS  D30, D14
    FCVTNS  D27, D28
    FCVTZU  S18, S27
    FCVTNU  S10, S15
    FCVTZS  S15, S31
    FCVTAS  S26, S2
    FCVTMU  D27, D21
    FCVTAS  H29, H27
    FCVTPU  S14, S0
    FCVTZS  H12, H18
    FCVTZU  S28, S26
    FCVTZS  D19, D22
    FCVTNU  H31, H14
    FCVTNS  D9, D31
    FCVTZS  D0, D30
    FCVTMU  S14, S9
    FCVTZS  H2, H28
    FCVTAS  H31, H10
    FCVTAS  H18, H0
    FCVTZU D27, D15, #40
    FCVTAU  S21, S29
    FCVTNU  H29, H18
    FCVTNU  H26, H12
    FCVTPU  D12, D19
    FCVTAS  H19, H27
    FCVTZU S18, S19, #17
    FCVTXN  S27, D18
    FCVTZS  H28, H14
    FCVTZS  H9, H28
    FCVTZU  H30, H21
    FCVTZS H22, H2, #3
    FCVTPS  D28, D31
    FCVTNU  D19, D16
    FCVTZS S18, S12, #28
    FCVTAU  D15, D26
    FCVTMU  H21, H18
    FCVTNU  D14, D29
    FCVTMU  H12, H27
    FCVTZU  H2, H22
    FCVTMS  H31, H19
    FCVTMS  H10, H15
    FCVTAU  D26, D21
    FCVTPU  D21, D2
    FCVTNU  D19, D28
    FCVTZS  D16, D19
    FCVTAU  D28, D30
    FCVTZS H27, H21, #9
    FCVTZS  S15, S28
    FCVTNU  H2, H31
    FCVTZS S21, S9, #30
    FCVTAS  H31, H14
    FCVTZS D22, D10, #59
    FCVTPS  D15, D12
    FCVTPU  D9, D8
    FCVTPS  S29, S2
    FCVTZU  D12, D9
    FCVTPU  H9, H21
    FCVTZU  D28, D9
    FCVTXN  S8, D28
    FCVTMU  D9, D29
    FCVTZS D14, D16, #49
    FCVTMS  S16, S14
    FCVTMU  S19, S16
    FCVTZU  D10, D12
    FCVTZU  H2, H22
    FCVTZU D16, D8, #4
    FCVTNU  H12, H31
    FCVTNU  D22, D12
    FCVTZU D31, D27, #30
    FCVTNS  D30, D2
    FCVTZU S28, S26, #15
    FCVTNS  H0, H15
    FCVTPS  D12, D30
    FCVTMU  H8, H10
    FCVTAS  S27, S9
    FCVTZU  H2, H31
    FCVTZS S15, S19, #5
    FCVTAU  H10, H15
    FCVTPS  D9, D8
    FCVTZU  S14, S11
    FCVTAS  S31, S10
    FCVTZU D8, D22, #32
    FCVTMS  H29, H9
    FCVTXN  S9, D28
    FCVTAS  H19, H29
    FCVTMU  H10, H8
    FCVTNU  H22, H19
    FCVTZS S30, S0, #22
    FCVTZU  H29, H14
    FCVTZU H0, H2, #6
    FCVTAS  S11, S27
    FCVTZS  D14, D11
    FCVTPU  H11, H16
    FCVTNS  D19, D14
    FCVTMS  S8, S10
    FCVTZU  D15, D9
    FCVTAU  D28, D31
    FCVTNU  H14, H12
    FCVTZU H12, H0, #6
    FCVTNU  S27, S12
    FCVTMS  D2, D30
    FCVTZS  S12, S27
    FCVTPU  S16, S2
    FCVTPS  D10, D16
    FCVTAS  S0, S12
    FCVTNS  H30, H14
    FCVTAS  D31, D10
    FCVTZS D12, D15, #25
    FCVTZU  D15, D30
    FCVTZS  D27, D28
    FCVTNU  S9, S11
    FCVTZS H2, H8, #13
    FCVTMU  H10, H19
    FCVTMU  S16, S10
    FCVTZU D30, D27, #17
    FCVTMU  S28, S29
    FCVTNS  S29, S12
    FCVTZS S10, S16, #8
    FCVTNU  D27, D10
    FCVTZS  S12, S2
    FCVTXN  S2, D31
    FCVTMU  D16, D30
    FCVTPS  D10, D9
    FCVTZU S9, S12, #12
    FCVTMS  H11, H2
    FCVTZU D31, D10, #46
    FCVTMU  D2, D29
    FCVTMU  S19, S15
    FCVTNS  H12, H11
    FCVTZU  H8, H9
    FCVTMS  H30, H0
    FCVTZS  H0, H2
    FCVTZU D11, D7, #8
    FCVTZS D10, D0, #8
    FCVTNU  H9, H27
    FCVTAS  S2, S8
    FCVTMU  S8, S2
    FCVTZU  D27, D31
    FCVTAU  D0, D30
    FCVTAS  S30, S12
    FCVTZS S31, S11, #6
    FCVTZS S29, S8, #21
    FCVTZS  S15, S9
    FCVTMU  S2, S19
    FCVTZU S7, S29, #21
    FCVTZS H29, H10, #10
    FCVTAU  S11, S31
    FCVTNU  S31, S0
    FCVTZU  D0, D29
    FCVTMS  S19, S27
    FCVTNU  S12, S15
    FCVTPS  D8, D12
    FCVTAS  D22, D19
    FCVTZS  S12, S7
    FCVTMS  D7, D12
    FCVTNU  H9, H11
    FCVTAS  H27, H7
    FCVTAS  H19, H22
    FCVTNU  S15, S2
    FCVTAU  H12, H31
    FCVTZS  H11, H0
    FCVTAS  H29, H12
    FCVTMU  D14, D8
    FCVTZS  H5, H29
    FCVTAU  D22, D5
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_15
    MOVZ  X18, #0xfc59, LSL #0
    MOVK  X18, #0xae5, LSL #16
    MOVK  X18, #0xcd34, LSL #32
    MOVK  X18, #0x8d28, LSL #48
    SUB  X4, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xd617, LSL #0
    MOVK  X18, #0x7c5a, LSL #16
    MOVK  X18, #0x578b, LSL #32
    MOVK  X18, #0xff1c, LSL #48
    SUB  X4, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xa89b, LSL #0
    MOVK  X18, #0x3d9a, LSL #16
    MOVK  X18, #0xb545, LSL #32
    MOVK  X18, #0x385e, LSL #48
    SUB  X4, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x1774, LSL #0
    MOVK  X18, #0x28d7, LSL #16
    MOVK  X18, #0x954b, LSL #32
    MOVK  X18, #0xd4d3, LSL #48
    SUB  X4, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x6322, LSL #0
    MOVK  X18, #0xe43f, LSL #16
    MOVK  X18, #0x2657, LSL #32
    MOVK  X18, #0xfbf3, LSL #48
    SUB  X4, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x40dc, LSL #0
    MOVK  X18, #0x51ef, LSL #16
    MOVK  X18, #0xc19, LSL #32
    MOVK  X18, #0x5834, LSL #48
    SUB  X4, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xe247, LSL #0
    MOVK  X18, #0x9c72, LSL #16
    MOVK  X18, #0x5515, LSL #32
    MOVK  X18, #0x4739, LSL #48
    SUB  X4, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x56dc, LSL #0
    MOVK  X18, #0x669e, LSL #16
    MOVK  X18, #0x3fc0, LSL #32
    MOVK  X18, #0x432c, LSL #48
    SUB  X4, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xfe23, LSL #0
    MOVK  X18, #0x892f, LSL #16
    MOVK  X18, #0x864e, LSL #32
    MOVK  X18, #0x451, LSL #48
    SUB  X4, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xcb4, LSL #0
    MOVK  X18, #0xad75, LSL #16
    MOVK  X18, #0x3ddd, LSL #32
    MOVK  X18, #0xff7c, LSL #48
    SUB  X4, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xfb4b, LSL #0
    MOVK  X18, #0x3b3a, LSL #16
    MOVK  X18, #0x470, LSL #32
    MOVK  X18, #0x3e69, LSL #48
    SUB  X4, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xbd81, LSL #0
    MOVK  X18, #0x2a75, LSL #16
    MOVK  X18, #0xbcbf, LSL #32
    MOVK  X18, #0x940e, LSL #48
    SUB  X4, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x5126, LSL #0
    MOVK  X18, #0xbeaa, LSL #16
    MOVK  X18, #0x1760, LSL #32
    MOVK  X18, #0xb47, LSL #48
    SUB  X4, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x46ba, LSL #0
    MOVK  X18, #0xa174, LSL #16
    MOVK  X18, #0xbccc, LSL #32
    MOVK  X18, #0x2b6f, LSL #48
    SUB  X4, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xe58f, LSL #0
    MOVK  X18, #0xa2c3, LSL #16
    MOVK  X18, #0x1753, LSL #32
    MOVK  X18, #0x8ed4, LSL #48
    SUB  X4, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x3e35, LSL #0
    MOVK  X18, #0xc869, LSL #16
    MOVK  X18, #0x7913, LSL #32
    MOVK  X18, #0xc0ee, LSL #48
    SUB  X4, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xcb3c, LSL #0
    MOVK  X18, #0x92b7, LSL #16
    MOVK  X18, #0xf6c0, LSL #32
    MOVK  X18, #0x350f, LSL #48
    SUB  X4, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x72e7, LSL #0
    MOVK  X18, #0x92d6, LSL #16
    MOVK  X18, #0xffbf, LSL #32
    MOVK  X18, #0xcd8d, LSL #48
    SUB  X4, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x8559, LSL #0
    MOVK  X18, #0xe437, LSL #16
    MOVK  X18, #0xf26e, LSL #32
    MOVK  X18, #0xf0ac, LSL #48
    SUB  X4, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x478d, LSL #0
    MOVK  X18, #0xb2b1, LSL #16
    MOVK  X18, #0x2d74, LSL #32
    MOVK  X18, #0x418, LSL #48
    SUB  X4, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x99, LSL #0
    MRS  X4, FPSR
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D0
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D1
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D2
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xe58f, LSL #0
    MOVK  X18, #0xa2c3, LSL #16
    MOVK  X18, #0x1753, LSL #32
    MOVK  X18, #0x8ed4, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xcb4, LSL #0
    MOVK  X18, #0xad75, LSL #16
    MOVK  X18, #0x3ddd, LSL #32
    MOVK  X18, #0xff7c, LSL #48
    FMOV  X4, D3
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xfc59, LSL #0
    MOVK  X18, #0xae5, LSL #16
    MOVK  X18, #0xcd34, LSL #32
    MOVK  X18, #0x8d28, LSL #48
    FMOV  X4, V4.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x40dc, LSL #0
    MOVK  X18, #0x51ef, LSL #16
    MOVK  X18, #0xc19, LSL #32
    MOVK  X18, #0x5834, LSL #48
    FMOV  X4, D4
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D5
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xbd81, LSL #0
    MOVK  X18, #0x2a75, LSL #16
    MOVK  X18, #0xbcbf, LSL #32
    MOVK  X18, #0x940e, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x40dc, LSL #0
    MOVK  X18, #0x51ef, LSL #16
    MOVK  X18, #0xc19, LSL #32
    MOVK  X18, #0x5834, LSL #48
    FMOV  X4, D6
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D7
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D8
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D9
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D10
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D11
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V12.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D12
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x40dc, LSL #0
    MOVK  X18, #0x51ef, LSL #16
    MOVK  X18, #0xc19, LSL #32
    MOVK  X18, #0x5834, LSL #48
    FMOV  X4, V13.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x72e7, LSL #0
    MOVK  X18, #0x92d6, LSL #16
    MOVK  X18, #0xffbf, LSL #32
    MOVK  X18, #0xcd8d, LSL #48
    FMOV  X4, D13
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D14
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V15.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D15
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D16
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xfc59, LSL #0
    MOVK  X18, #0xae5, LSL #16
    MOVK  X18, #0xcd34, LSL #32
    MOVK  X18, #0x8d28, LSL #48
    FMOV  X4, V17.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xfb4b, LSL #0
    MOVK  X18, #0x3b3a, LSL #16
    MOVK  X18, #0x470, LSL #32
    MOVK  X18, #0x3e69, LSL #48
    FMOV  X4, D17
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V18.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D18
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D19
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V20.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D20
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D21
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D22
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D23
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xcb7b, LSL #0
    MOVK  X18, #0x757d, LSL #16
    MOVK  X18, #0xe5b1, LSL #32
    MOVK  X18, #0x9c47, LSL #48
    FMOV  X4, V24.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x6322, LSL #0
    MOVK  X18, #0xe43f, LSL #16
    MOVK  X18, #0x2657, LSL #32
    MOVK  X18, #0xfbf3, LSL #48
    FMOV  X4, D24
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xcb3c, LSL #0
    MOVK  X18, #0x92b7, LSL #16
    MOVK  X18, #0xf6c0, LSL #32
    MOVK  X18, #0x350f, LSL #48
    FMOV  X4, V25.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0xcb4, LSL #0
    MOVK  X18, #0xad75, LSL #16
    MOVK  X18, #0x3ddd, LSL #32
    MOVK  X18, #0xff7c, LSL #48
    FMOV  X4, D25
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D26
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D27
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V28.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D28
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D29
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D30
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X4, D31
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X4
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X17
    FMOV  D2, X22
    FMOV  V2.D[1], X16
    FMOV  D3, X18
    FMOV  V3.D[1], X28
    FMOV  D4, X12
    FMOV  V4.D[1], X29
    FMOV  D5, X19
    FMOV  V5.D[1], X21
    FMOV  D6, X20
    FMOV  V6.D[1], X27
    FMOV  D7, X27
    FMOV  V7.D[1], X18
    FMOV  D8, X16
    FMOV  V8.D[1], X16
    FMOV  D9, X19
    FMOV  V9.D[1], X16
    FMOV  D10, X29
    FMOV  V10.D[1], X21
    FMOV  D11, X12
    FMOV  V11.D[1], X12
    FMOV  D12, X5
    FMOV  V12.D[1], X28
    FMOV  D13, X5
    FMOV  V13.D[1], X8
    FMOV  D14, X15
    FMOV  V14.D[1], X22
    FMOV  D15, X25
    FMOV  V15.D[1], X15
    FMOV  D16, X15
    FMOV  V16.D[1], X10
    FMOV  D17, X17
    FMOV  V17.D[1], X19
    FMOV  D18, X5
    FMOV  V18.D[1], X25
    FMOV  D19, X28
    FMOV  V19.D[1], X12
    FMOV  D20, X28
    FMOV  V20.D[1], X7
    FMOV  D21, X28
    FMOV  V21.D[1], X7
    FMOV  D22, X9
    FMOV  V22.D[1], X17
    FMOV  D23, X16
    FMOV  V23.D[1], X20
    FMOV  D24, X12
    FMOV  V24.D[1], X28
    FMOV  D25, X15
    FMOV  V25.D[1], X29
    FMOV  D26, X25
    FMOV  V26.D[1], X14
    FMOV  D27, X4
    FMOV  V27.D[1], X4
    FMOV  D28, X18
    FMOV  V28.D[1], X16
    FMOV  D29, X22
    FMOV  V29.D[1], X4
    FMOV  D30, X9
    FMOV  V30.D[1], X21
    FMOV  D31, X12
    FMOV  V31.D[1], X8
    MOVZ  X21, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_16:
    FCVTMU  H19, H23
    FCVTZS S0, S29, #24
    FCVTZS S31, S24, #8
    FCVTAU  D3, D0
    FCVTPS  S21, S3
    FCVTNU  S14, S22
    FCVTMS  D17, D30
    FCVTXN  S29, D26
    FCVTNU  S5, S27
    FCVTPS  D30, D25
    FCVTZU  D27, D19
    FCVTPS  D25, D5
    FCVTZU  H22, H31
    FCVTAU  D8, D17
    FCVTZU D12, D28, #29
    FCVTAS  D18, D6
    FCVTAS  D13, D18
    FCVTNS  S25, S30
    FCVTPU  D30, D13
    FCVTZS  D26, D14
    FCVTNU  D31, D12
    FCVTPU  S1, S25
    FCVTNS  D23, D1
    FCVTZS  H17, H23
    FCVTZU  D21, D14
    FCVTAS  D1, D27
    FCVTAU  S15, S29
    FCVTAS  D27, D31
    FCVTPU  H5, H19
    FCVTZU H25, H30, #4
    FCVTNU  H31, H21
    FCVTZU D13, D17, #49
    FCVTZS  D21, D22
    FCVTZU  H3, H8
    FCVTZU  S28, S27
    FCVTZU  D12, D28
    FCVTZU H23, H21, #5
    FCVTZU H18, H5, #16
    FCVTMS  H30, H3
    FCVTNU  H29, H31
    FCVTMU  D31, D15
    FCVTZU H27, H30, #3
    FCVTPS  H28, H1
    FCVTZS  H19, H13
    FCVTNS  H8, H31
    FCVTPU  D31, D28
    FCVTMU  D17, D31
    FCVTMU  S28, S17
    FCVTPS  H31, H23
    FCVTAU  D5, D26
    FCVTZU  H22, H29
    FCVTAS  S13, S12
    FCVTZS D14, D25, #53
    FCVTMU  S25, S22
    FCVTZU  D22, D13
    FCVTPS  H13, H18
    FCVTZU H18, H13, #11
    FCVTPU  D26, D28
    FCVTNS  S3, S5
    FCVTNS  S15, S3
    FCVTZU  D13, D15
    FCVTMS  H12, H22
    FCVTZS D17, D14, #23
    FCVTPS  S15, S31
    FCVTZS S29, S25, #12
    FCVTPS  D1, D18
    FCVTMS  H14, H12
    FCVTMU  S30, S14
    FCVTAU  H18, H15
    FCVTZS D28, D29, #33
    FCVTZU D29, D27, #44
    FCVTMS  D3, D30
    FCVTAS  S25, S29
    FCVTPU  S12, S17
    FCVTMS  H17, H26
    FCVTNU  S14, S25
    FCVTZS S15, S18, #16
    FCVTZU D5, D3, #30
    FCVTNS  H26, H15
    FCVTAS  S22, S12
    FCVTAS  D18, D5
    FCVTNS  S15, S28
    FCVTNS  S12, S22
    FCVTAU  D27, D13
    FCVTNS  D30, D1
    FCVTMU  S13, S30
    FCVTNU  D1, D17
    FCVTZS S30, S27, #3
    FCVTMS  D22, D6
    FCVTMS  H25, H15
    FCVTPU  H3, H26
    FCVTZS H29, H12, #3
    FCVTZS S6, S29, #9
    FCVTZS S26, S14, #19
    FCVTMS  D14, D13
    FCVTNS  S12, S18
    FCVTZU H5, H7, #3
    FCVTZS  S28, S22
    FCVTPU  H17, H26
    FCVTZS  D30, D14
    FCVTNU  S7, S12
    FCVTNS  H22, H1
    FCVTZS S21, S28, #3
    FCVTNS  S29, S21
    FCVTZS D27, D25, #46
    FCVTZU S21, S7, #15
    FCVTZS  H1, H27
    FCVTZU H14, H9, #2
    FCVTPS  H18, H3
    FCVTZS S9, S5, #27
    FCVTMS  S25, S17
    FCVTNU  H3, H9
    FCVTZU S28, S6, #29
    FCVTZU  H12, H14
    FCVTMS  S7, S30
    FCVTZU H27, H18, #6
    FCVTMU  S13, S12
    FCVTNU  S17, S29
    FCVTZU  S29, S13
    FCVTPS  S15, S28
    FCVTNS  D9, D15
    FCVTNS  D18, D25
    FCVTMS  D5, D22
    FCVTZS  D26, D29
    FCVTAU  S28, S26
    FCVTZU D27, D18, #13
    FCVTNU  H15, H1
    FCVTZS H13, H17, #16
    FCVTPU  D6, D9
    FCVTZU D22, D5, #15
    FCVTXN  S25, D28
    FCVTMS  D12, D22
    FCVTAS  H14, H7
    FCVTNU  D7, D14
    FCVTMS  H5, H25
    FCVTMU  D26, D21
    FCVTMS  D28, D27
    FCVTNU  S30, S28
    FCVTZU S14, S26, #1
    FCVTPU  H25, H30
    FCVTMS  H17, H6
    FCVTPU  D6, D17
    FCVTPS  S9, S15
    FCVTXN  S28, D9
    FCVTZU D27, D25, #60
    FCVTAU  H9, H12
    FCVTZS  H30, H13
    FCVTNS  H22, H14
    FCVTMS  S26, S5
    FCVTZS  D14, D23
    FCVTZS H5, H6, #2
    FCVTZU  S13, S7
    FCVTMS  H21, H14
    FCVTMU  D14, D9
    FCVTZS  D25, D16
    FCVTZU H16, H13, #15
    FCVTPS  S13, S16
    FCVTMU  D7, D25
    FCVTNS  S12, S14
    FCVTNU  S6, S21
    FCVTNS  D14, D30
    FCVTAS  D23, D28
    FCVTAU  S25, S27
    FCVTZU H9, H14, #7
    FCVTMU  H17, H23
    FCVTNU  H27, H5
    FCVTAU  H5, H17
    FCVTPU  H16, H14
    FCVTZS S14, S13, #21
    FCVTAU  S13, S14
    FCVTNU  D21, D27
    FCVTMU  H14, H26
    FCVTZU  S30, S14
    FCVTNS  D23, D12
    FCVTNS  H28, H25
    FCVTPS  D26, D6
    FCVTZU H17, H5, #2
    FCVTXN  S27, D9
    FCVTNS  S5, S17
    FCVTAU  H17, H16
    FCVTZS  H14, H7
    FCVTZS  S6, S8
    FCVTZS  S12, S23
    FCVTPU  S23, S6
    FCVTPS  S25, S13
    FCVTPU  H8, H14
    FCVTZS  H16, H30
    FCVTZS  D14, D28
    FCVTXN  S9, D26
    FCVTMS  H26, H8
    FCVTNU  H30, H23
    FCVTZU S8, S12, #18
    FCVTZS S7, S5, #16
    FCVTAU  D5, D27
    FCVTAS  H23, H5
    FCVTNS  S5, S17
    FCVTZU H28, H25, #11
    FCVTNS  S6, S21
    FCVTMS  D27, D7
    FCVTNS  S12, S16
    SUBS  X21, X21, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_16
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x99, LSL #0
    MRS  X6, FPSR
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D0
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D1
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D2
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D3
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D4
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D5
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D6
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D8
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D10
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D11
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D12
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D13
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D14
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D16
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D17
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D20
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D21
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D23
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D27
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D29
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X6, D31
    SUB  X7, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X20
    FMOV  D3, X22
    FMOV  V3.D[1], X16
    FMOV  D4, X21
    FMOV  V4.D[1], X9
    FMOV  D5, X8
    FMOV  V5.D[1], X27
    FMOV  D6, X27
    FMOV  V6.D[1], X17
    FMOV  D7, X7
    FMOV  V7.D[1], X13
    FMOV  D8, X15
    FMOV  V8.D[1], X10
    FMOV  D9, X25
    FMOV  V9.D[1], X27
    FMOV  D10, X6
    FMOV  V10.D[1], X9
    FMOV  D11, X26
    FMOV  V11.D[1], X20
    FMOV  D12, X5
    FMOV  V12.D[1], X10
    FMOV  D13, X7
    FMOV  V13.D[1], X18
    FMOV  D14, X17
    FMOV  V14.D[1], X22
    FMOV  D15, X16
    FMOV  V15.D[1], X22
    FMOV  D16, X20
    FMOV  V16.D[1], X20
    FMOV  D17, X22
    FMOV  V17.D[1], X25
    FMOV  D18, X4
    FMOV  V18.D[1], X6
    FMOV  D19, X15
    FMOV  V19.D[1], X18
    FMOV  D20, X21
    FMOV  V20.D[1], X18
    FMOV  D21, X10
    FMOV  V21.D[1], X5
    FMOV  D22, X27
    FMOV  V22.D[1], X7
    FMOV  D23, X4
    FMOV  V23.D[1], X14
    FMOV  D24, X2
    FMOV  V24.D[1], X15
    FMOV  D25, X20
    FMOV  V25.D[1], X16
    FMOV  D26, X16
    FMOV  V26.D[1], X5
    FMOV  D27, X9
    FMOV  V27.D[1], X13
    FMOV  D28, X28
    FMOV  V28.D[1], X20
    FMOV  D29, X16
    FMOV  V29.D[1], X10
    FMOV  D30, X16
    FMOV  V30.D[1], X12
    FMOV  D31, X2
    FMOV  V31.D[1], X8
    MOVZ  X14, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_17:
    FCVTPS  D9, D28
    FCVTZU H28, H23, #15
    FCVTPU  S4, S25
    FCVTMU  S28, S9
    FCVTNS  H29, H31
    FCVTAU  S12, S4
    FCVTPS  D20, D28
    FCVTMU  H14, H24
    FCVTZU  H14, H29
    FCVTAU  D13, D27
    FCVTZU S4, S12, #14
    FCVTXN  S8, D14
    FCVTXN  S8, D26
    FCVTAU  S27, S20
    FCVTNS  S22, S27
    FCVTNU  S20, S30
    FCVTZU H10, H8, #3
    FCVTMS  S25, S13
    FCVTPS  D27, D11
    FCVTZU S24, S22, #11
    FCVTZU  S22, S4
    FCVTZS  H30, H27
    FCVTMU  S16, S20
    FCVTNS  D8, D10
    FCVTNS  D23, D22
    FCVTZU  H22, H23
    FCVTMU  H21, H24
    FCVTNU  H14, H21
    FCVTAU  H26, H8
    FCVTNU  D13, D25
    FCVTZS S12, S30, #14
    FCVTAU  D21, D26
    FCVTAS  H27, H16
    FCVTAU  D25, D13
    FCVTMU  S8, S14
    FCVTMU  H30, H22
    FCVTXN  S14, D21
    FCVTPS  H24, H12
    FCVTZU  S4, S25
    FCVTNU  D26, D4
    FCVTZU S13, S30, #19
    FCVTNU  D30, D14
    FCVTAU  D23, D24
    FCVTMS  D10, D27
    FCVTAU  H21, H26
    FCVTNU  S25, S23
    FCVTNU  S20, S8
    FCVTZS H14, H25, #4
    FCVTZS D25, D20, #56
    FCVTPU  D31, D25
    FCVTZU  H12, H31
    FCVTZU  S4, S21
    FCVTZS S26, S13, #23
    FCVTZU  S22, S26
    FCVTAU  S24, S12
    FCVTMU  H12, H12
    FCVTAS  D27, D4
    FCVTZU  H4, H27
    FCVTNS  S23, S4
    FCVTAU  D27, D10
    FCVTZS S25, S27, #26
    FCVTAU  S27, S30
    FCVTPU  S13, S24
    FCVTZS  S20, S13
    FCVTMU  D10, D12
    FCVTAU  S4, S10
    FCVTPS  H30, H27
    FCVTNU  S8, S14
    FCVTMU  D31, D8
    FCVTAS  D26, D30
    FCVTPU  H30, H26
    FCVTZU  H8, H22
    FCVTAU  H12, H4
    FCVTPU  D22, D23
    FCVTMU  D24, D30
    FCVTZU  S21, S31
    FCVTMU  S23, S16
    FCVTNU  D4, D4
    FCVTAS  D31, D8
    FCVTNS  H16, H21
    FCVTZS  H21, H12
    FCVTPU  H8, H22
    FCVTZS  D30, D24
    FCVTPS  D10, D20
    FCVTAU  H24, H23
    FCVTZU  H27, H24
    FCVTZS D26, D25, #49
    FCVTZU  H12, H26
    FCVTZU  D13, D10
    FCVTPS  D26, D13
    FCVTMU  H13, H12
    FCVTNS  S14, S27
    FCVTMS  D27, D4
    FCVTMU  H10, H21
    FCVTMU  H22, H26
    FCVTMS  H23, H13
    FCVTMU  D13, D22
    FCVTZU  H12, H13
    FCVTNU  S24, S14
    FCVTMS  S21, S27
    FCVTAS  S20, S21
    FCVTMS  H14, H24
    FCVTMS  H24, H31
    FCVTPS  H31, H20
    FCVTMU  H21, H16
    FCVTAS  H22, H30
    FCVTAS  H22, H21
    FCVTAS  H21, H14
    FCVTMU  D27, D21
    FCVTAS  D4, D24
    FCVTNS  H16, H10
    FCVTZU  D10, D22
    FCVTZU H14, H16, #1
    FCVTPU  H30, H27
    FCVTPS  H20, H12
    FCVTZS H21, H20, #1
    FCVTMS  H24, H14
    FCVTZS  S16, S30
    FCVTMS  H30, H24
    FCVTPS  D24, D4
    FCVTZU  D22, D24
    FCVTPS  S12, S21
    FCVTPS  H20, H31
    FCVTZU H27, H16, #9
    FCVTZS  H31, H30
    FCVTZU  D13, D12
    FCVTMS  D14, D31
    FCVTPU  D4, D10
    FCVTAS  D21, D23
    FCVTPS  D12, D14
    FCVTZS S18, S21, #23
    FCVTNS  D24, D22
    FCVTMS  S21, S20
    FCVTNU  S22, S12
    FCVTNS  D16, D27
    FCVTZS D12, D21, #47
    FCVTNS  D20, D12
    FCVTPS  S27, S16
    FCVTXN  S23, D20
    FCVTNU  D21, D22
    FCVTZU  S20, S18
    FCVTAU  D16, D20
    FCVTPS  D12, D23
    FCVTAS  S31, S16
    FCVTAU  S18, S12
    FCVTNU  S14, S4
    FCVTZS D23, D27, #53
    FCVTPS  D10, D13
    FCVTMS  H13, H24
    FCVTPS  D12, D16
    FCVTZS H30, H23, #13
    FCVTMS  D6, D13
    FCVTZU S4, S21, #16
    FCVTPS  S22, S31
    FCVTMS  S16, S18
    FCVTZU D27, D6, #1
    FCVTXN  S21, D16
    FCVTPU  S6, S15
    FCVTZS H23, H4, #5
    FCVTNU  D31, D23
    FCVTAS  H15, H30
    FCVTNS  D20, D12
    FCVTZS H13, H31, #5
    FCVTPS  S16, S10
    FCVTZU D9, D14, #55
    FCVTNU  S18, S27
    FCVTNU  D24, D18
    FCVTNS  D23, D21
    FCVTMS  H30, H15
    FCVTPS  H12, H22
    FCVTZS D10, D12, #12
    FCVTPS  D14, D3
    FCVTPU  H1, H6
    FCVTZU H3, H1, #15
    FCVTPS  S1, S20
    FCVTZS  S20, S24
    FCVTXN  S27, D21
    FCVTMS  S24, S16
    FCVTNS  H12, H24
    FCVTAU  H4, H17
    FCVTMU  D21, D12
    FCVTAS  S18, S3
    FCVTZS D17, D27, #37
    FCVTAU  D6, D13
    FCVTNS  D27, D18
    FCVTAS  H12, H9
    FCVTNU  D16, D20
    FCVTPS  D3, D17
    FCVTAS  D22, D14
    FCVTMS  D14, D1
    FCVTNU  D24, D22
    FCVTZU H1, H6, #9
    FCVTZU S17, S3, #2
    FCVTPS  S3, S4
    FCVTZS H18, H27, #10
    FCVTZS  D22, D18
    FCVTAS  S13, S10
    FCVTZS  D4, D14
    FCVTPU  D15, D4
    FCVTZU  H27, H12
    SUBS  X14, X14, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_17
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X13, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x99, LSL #0
    MRS  X13, FPSR
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, V0.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, D0
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D1
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, V2.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, D2
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D3
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D4
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, V5.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, D5
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D6
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, V7.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, D7
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D8
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D9
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D10
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, V11.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, D11
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D12
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D13
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D14
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D16
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D17
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, V19.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X13, D19
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D20
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D21
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D22
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D23
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D24
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D25
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D26
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D27
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D28
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D29
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D30
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X13, D31
    SUB  X19, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x817, LSL #0
    MOVK  X2, #0xb40, LSL #16
    MOVK  X2, #0x500b, LSL #32
    MOVK  X2, #0x9c86, LSL #48
    MOVZ  X4, #0x9e80, LSL #0
    MOVK  X4, #0x8d2c, LSL #16
    MOVK  X4, #0xc36f, LSL #32
    MOVK  X4, #0x56c2, LSL #48
    MOVZ  X5, #0xa2fe, LSL #0
    MOVK  X5, #0x7ec6, LSL #16
    MOVK  X5, #0xa437, LSL #32
    MOVK  X5, #0xa59c, LSL #48
    MOVZ  X6, #0x114e, LSL #0
    MOVK  X6, #0x86cf, LSL #16
    MOVK  X6, #0xf136, LSL #32
    MOVK  X6, #0x1fbf, LSL #48
    MOVZ  X7, #0xad66, LSL #0
    MOVK  X7, #0x9a85, LSL #16
    MOVK  X7, #0x1bb1, LSL #32
    MOVK  X7, #0xd6d1, LSL #48
    MOVZ  X8, #0x33bb, LSL #0
    MOVK  X8, #0xd0f, LSL #16
    MOVK  X8, #0xa583, LSL #32
    MOVK  X8, #0x67d, LSL #48
    MOVZ  X9, #0x1de9, LSL #0
    MOVK  X9, #0x9b5d, LSL #16
    MOVK  X9, #0x50f1, LSL #32
    MOVK  X9, #0x1f94, LSL #48
    MOVZ  X10, #0x22a3, LSL #0
    MOVK  X10, #0x5d78, LSL #16
    MOVK  X10, #0xa4ad, LSL #32
    MOVK  X10, #0xd70a, LSL #48
    MOVZ  X12, #0x6cc2, LSL #0
    MOVK  X12, #0xb11f, LSL #16
    MOVK  X12, #0x7df0, LSL #32
    MOVK  X12, #0x3b5e, LSL #48
    MOVZ  X13, #0xf020, LSL #0
    MOVK  X13, #0x2dd6, LSL #16
    MOVK  X13, #0xf70b, LSL #32
    MOVK  X13, #0xa854, LSL #48
    MOVZ  X14, #0xacd7, LSL #0
    MOVK  X14, #0x3f68, LSL #16
    MOVK  X14, #0xf91b, LSL #32
    MOVK  X14, #0xfa8a, LSL #48
    MOVZ  X15, #0xe6b6, LSL #0
    MOVK  X15, #0xe7f2, LSL #16
    MOVK  X15, #0x1ee7, LSL #32
    MOVK  X15, #0x3390, LSL #48
    MOVZ  X16, #0x6bd2, LSL #0
    MOVK  X16, #0x4138, LSL #16
    MOVK  X16, #0xc28a, LSL #32
    MOVK  X16, #0x8fb9, LSL #48
    MOVZ  X17, #0x6d7b, LSL #0
    MOVK  X17, #0xb303, LSL #16
    MOVK  X17, #0xc6d9, LSL #32
    MOVK  X17, #0x2c73, LSL #48
    MOVZ  X18, #0xba71, LSL #0
    MOVK  X18, #0x6b12, LSL #16
    MOVK  X18, #0x937d, LSL #32
    MOVK  X18, #0x50b6, LSL #48
    MOVZ  X19, #0xaf8a, LSL #0
    MOVK  X19, #0xc145, LSL #16
    MOVK  X19, #0xcccf, LSL #32
    MOVK  X19, #0x7df3, LSL #48
    MOVZ  X20, #0xb20b, LSL #0
    MOVK  X20, #0xbd05, LSL #16
    MOVK  X20, #0x253c, LSL #32
    MOVK  X20, #0x6863, LSL #48
    MOVZ  X21, #0x241, LSL #0
    MOVK  X21, #0x7db7, LSL #16
    MOVK  X21, #0x1bd3, LSL #32
    MOVK  X21, #0xd36d, LSL #48
    MOVZ  X22, #0xf5c5, LSL #0
    MOVK  X22, #0xb768, LSL #16
    MOVK  X22, #0x5ed1, LSL #32
    MOVK  X22, #0xf55, LSL #48
    MOVZ  X25, #0xb522, LSL #0
    MOVK  X25, #0xbd6f, LSL #16
    MOVK  X25, #0x3849, LSL #32
    MOVK  X25, #0xf6e8, LSL #48
    MOVZ  X26, #0x9db9, LSL #0
    MOVK  X26, #0x307, LSL #16
    MOVK  X26, #0x1eba, LSL #32
    MOVK  X26, #0x9f41, LSL #48
    MOVZ  X27, #0x6cb1, LSL #0
    MOVK  X27, #0x273b, LSL #16
    MOVK  X27, #0x10e9, LSL #32
    MOVK  X27, #0x31ca, LSL #48
    MOVZ  X28, #0xfdc7, LSL #0
    MOVK  X28, #0xa221, LSL #16
    MOVK  X28, #0x66c4, LSL #32
    MOVK  X28, #0xa54a, LSL #48
    MOVZ  X29, #0xdfe7, LSL #0
    MOVK  X29, #0x8781, LSL #16
    MOVK  X29, #0x7ec0, LSL #32
    MOVK  X29, #0x5f4d, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X21
    FMOV  D3, X4
    FMOV  V3.D[1], X6
    FMOV  D4, X22
    FMOV  V4.D[1], X2
    FMOV  D5, X14
    FMOV  V5.D[1], X21
    FMOV  D6, X20
    FMOV  V6.D[1], X26
    FMOV  D7, X26
    FMOV  V7.D[1], X25
    FMOV  D8, X8
    FMOV  V8.D[1], X21
    FMOV  D9, X15
    FMOV  V9.D[1], X16
    FMOV  D10, X17
    FMOV  V10.D[1], X25
    FMOV  D11, X18
    FMOV  V11.D[1], X13
    FMOV  D12, X2
    FMOV  V12.D[1], X12
    FMOV  D13, X7
    FMOV  V13.D[1], X26
    FMOV  D14, X2
    FMOV  V14.D[1], X17
    FMOV  D15, X10
    FMOV  V15.D[1], X7
    FMOV  D16, X6
    FMOV  V16.D[1], X27
    FMOV  D17, X2
    FMOV  V17.D[1], X5
    FMOV  D18, X29
    FMOV  V18.D[1], X8
    FMOV  D19, X29
    FMOV  V19.D[1], X22
    FMOV  D20, X15
    FMOV  V20.D[1], X20
    FMOV  D21, X22
    FMOV  V21.D[1], X15
    FMOV  D22, X20
    FMOV  V22.D[1], X21
    FMOV  D23, X21
    FMOV  V23.D[1], X8
    FMOV  D24, X27
    FMOV  V24.D[1], X10
    FMOV  D25, X28
    FMOV  V25.D[1], X20
    FMOV  D26, X27
    FMOV  V26.D[1], X15
    FMOV  D27, X27
    FMOV  V27.D[1], X29
    FMOV  D28, X19
    FMOV  V28.D[1], X25
    FMOV  D29, X25
    FMOV  V29.D[1], X16
    FMOV  D30, X13
    FMOV  V30.D[1], X5
    FMOV  D31, X9
    FMOV  V31.D[1], X4
    MOVZ  X16, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_18:
    FCVTNU  D25, D26
    FCVTPS  H1, H31
    FCVTNS  S3, S27
    FCVTPU  S29, S29
    FCVTMS  D2, D29
    FCVTPU  H7, H20
    FCVTNS  S14, S25
    FCVTNS  H4, H3
    FCVTZS S7, S28, #22
    FCVTPU  H31, H30
    FCVTAU  S8, S22
    FCVTAU  H5, H1
    FCVTAS  S26, S5
    FCVTZS H26, H8, #15
    FCVTPU  D8, D2
    FCVTAS  S20, S8
    FCVTNU  H8, H4
    FCVTZU H24, H31, #8
    FCVTZU  D5, D26
    FCVTMS  S13, S4
    FCVTMS  D30, D14
    FCVTPU  D25, D7
    FCVTZS H8, H20, #4
    FCVTAS  H25, H8
    FCVTZU H31, H24, #3
    FCVTNU  D28, D5
    FCVTNS  S27, S25
    FCVTXN  S22, D30
    FCVTAS  H1, H22
    FCVTXN  S17, D13
    FCVTXN  S26, D31
    FCVTPU  H14, H26
    FCVTPU  D22, D14
    FCVTMU  H3, H22
    FCVTNU  H5, H3
    FCVTPU  H14, H5
    FCVTZS S20, S27, #27
    FCVTZS S4, S20, #4
    FCVTZS D3, D17, #4
    FCVTNU  H20, H30
    FCVTZS S27, S4, #11
    FCVTNS  H2, H14
    FCVTNS  H26, H20
    FCVTAU  D5, D3
    FCVTZU  D14, D28
    FCVTZS  D20, D14
    FCVTZS H7, H26, #7
    FCVTNS  H22, H5
    FCVTZS D30, D20, #55
    FCVTNS  D28, D22
    FCVTPU  H3, H27
    FCVTZU  S25, S1
    FCVTZU  D17, D28
    FCVTZU  S28, S7
    FCVTNU  D7, D2
    FCVTAU  D1, D18
    FCVTAU  H4, H1
    FCVTZU D14, D30, #59
    FCVTZU  D1, D17
    FCVTMU  S26, S7
    FCVTZU D22, D28, #46
    FCVTPU  S7, S6
    FCVTAS  S27, S26
    FCVTMU  D30, D27
    FCVTPU  D28, D22
    FCVTAS  H5, H25
    FCVTZU H26, H4, #3
    FCVTNS  D6, D14
    FCVTMU  S2, S1
    FCVTPS  H1, H7
    FCVTZS  S14, S30
    FCVTAU  S20, S6
    FCVTNS  H22, H20
    FCVTZS  S20, S1
    FCVTMU  D4, D26
    FCVTNS  D17, D28
    FCVTZU  D7, D17
    FCVTXN  S6, D14
    FCVTMU  H1, H5
    FCVTNU  S5, S4
    FCVTPS  H4, H5
    FCVTNS  H18, H2
    FCVTZS S14, S4, #25
    FCVTMU  D2, D6
    FCVTAU  S30, S15
    FCVTMU  H5, H22
    FCVTZS H22, H18, #3
    FCVTMS  H18, H2
    FCVTPU  H28, H30
    FCVTMU  H17, H28
    FCVTZU  D6, D7
    FCVTPU  H2, H1
    FCVTZS  D4, D6
    FCVTPU  D1, D20
    FCVTNS  D26, D18
    FCVTMS  D28, D26
    FCVTZS D30, D14, #61
    FCVTMS  S0, S28
    FCVTNS  S7, S0
    FCVTAS  D29, D1
    FCVTPU  D18, D5
    FCVTNU  H2, H30
    FCVTZU D20, D21, #64
    FCVTNU  S30, S2
    FCVTMU  S22, S17
    FCVTMU  S0, S29
    FCVTZS S29, S24, #6
    FCVTMS  H21, H7
    FCVTAU  S14, S18
    FCVTZU D28, D0, #2
    FCVTZU  D1, D8
    FCVTPU  D2, D29
    FCVTZS S26, S28, #23
    FCVTZU D15, D26, #1
    FCVTZU H28, H20, #2
    FCVTZS S0, S15, #12
    FCVTZS  H17, H4
    FCVTNU  S24, S22
    FCVTZU  D29, D30
    FCVTZU S7, S14, #6
    FCVTNS  S18, S29
    FCVTMU  H26, H28
    FCVTPU  S15, S1
    FCVTAS  H4, H17
    FCVTZU H20, H15, #15
    FCVTAU  H15, H21
    FCVTZS D22, D0, #58
    FCVTZU  H0, H2
    FCVTPS  H5, H20
    FCVTZU  D1, D24
    FCVTPU  S17, S4
    FCVTXN  S8, D26
    FCVTZS  S14, S8
    FCVTAS  D21, D15
    FCVTAS  S30, S7
    FCVTNS  H2, H0
    FCVTMS  H29, H18
    FCVTNS  D26, D1
    FCVTMU  D1, D2
    FCVTPS  D24, D29
    FCVTPU  D15, D26
    FCVTZU H4, H14, #3
    FCVTAS  H14, H17
    FCVTAS  D17, D5
    FCVTAS  S8, S1
    FCVTAS  H5, H8
    FCVTNS  S2, S22
    FCVTAS  D26, D19
    FCVTPU  H0, H24
    FCVTNU  H24, H5
    FCVTPU  S22, S24
    FCVTPS  H7, H14
    FCVTPU  S29, S17
    FCVTNU  H20, H0
    FCVTMU  H19, H15
    FCVTAS  S1, S20
    FCVTPU  S0, S2
    FCVTAU  D2, D22
    FCVTXN  S5, D7
    FCVTMS  D22, D4
    FCVTAU  S7, S19
    FCVTZU  S18, S22
    FCVTPS  H17, H26
    FCVTAS  H20, H29
    FCVTMU  D4, D30
    FCVTMU  S24, S1
    FCVTPU  S19, S0
    FCVTNU  D15, D24
    FCVTAU  S22, S19
    FCVTZS  D30, D23
    FCVTMU  H1, H4
    FCVTNS  S14, S22
    FCVTPU  H8, H20
    FCVTPS  D4, D8
    FCVTPS  S29, S4
    FCVTAU  D26, D29
    FCVTZS D4, D15, #7
    FCVTAU  S22, S30
    FCVTNU  D20, D1
    FCVTPS  H0, H5
    FCVTMU  D1, D22
    FCVTMU  S24, S1
    FCVTMS  H23, H20
    FCVTMS  S8, S26
    FCVTZU  D19, D14
    FCVTZU  S14, S4
    FCVTAU  H30, H23
    FCVTNS  D5, D24
    FCVTXN  S24, D5
    FCVTMU  D23, D19
    FCVTZS D20, D23, #56
    FCVTAS  H29, H0
    FCVTAS  S15, S14
    FCVTMU  H22, H15
    FCVTNS  S5, S8
    FCVTZU D1, D5, #13
    FCVTNS  S15, S1
    FCVTAS  D5, D24
    FCVTAS  H14, H5
    FCVTZS  D23, D30
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_18
    MOVZ  X10, #0x817, LSL #0
    MOVK  X10, #0xb40, LSL #16
    MOVK  X10, #0x500b, LSL #32
    MOVK  X10, #0x9c86, LSL #48
    SUB  X13, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x9e80, LSL #0
    MOVK  X10, #0x8d2c, LSL #16
    MOVK  X10, #0xc36f, LSL #32
    MOVK  X10, #0x56c2, LSL #48
    SUB  X13, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xa2fe, LSL #0
    MOVK  X10, #0x7ec6, LSL #16
    MOVK  X10, #0xa437, LSL #32
    MOVK  X10, #0xa59c, LSL #48
    SUB  X13, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x114e, LSL #0
    MOVK  X10, #0x86cf, LSL #16
    MOVK  X10, #0xf136, LSL #32
    MOVK  X10, #0x1fbf, LSL #48
    SUB  X13, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xad66, LSL #0
    MOVK  X10, #0x9a85, LSL #16
    MOVK  X10, #0x1bb1, LSL #32
    MOVK  X10, #0xd6d1, LSL #48
    SUB  X13, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x33bb, LSL #0
    MOVK  X10, #0xd0f, LSL #16
    MOVK  X10, #0xa583, LSL #32
    MOVK  X10, #0x67d, LSL #48
    SUB  X13, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x1de9, LSL #0
    MOVK  X10, #0x9b5d, LSL #16
    MOVK  X10, #0x50f1, LSL #32
    MOVK  X10, #0x1f94, LSL #48
    SUB  X13, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xacd7, LSL #0
    MOVK  X10, #0x3f68, LSL #16
    MOVK  X10, #0xf91b, LSL #32
    MOVK  X10, #0xfa8a, LSL #48
    SUB  X13, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xe6b6, LSL #0
    MOVK  X10, #0xe7f2, LSL #16
    MOVK  X10, #0x1ee7, LSL #32
    MOVK  X10, #0x3390, LSL #48
    SUB  X13, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x6d7b, LSL #0
    MOVK  X10, #0xb303, LSL #16
    MOVK  X10, #0xc6d9, LSL #32
    MOVK  X10, #0x2c73, LSL #48
    SUB  X13, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xba71, LSL #0
    MOVK  X10, #0x6b12, LSL #16
    MOVK  X10, #0x937d, LSL #32
    MOVK  X10, #0x50b6, LSL #48
    SUB  X13, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xaf8a, LSL #0
    MOVK  X10, #0xc145, LSL #16
    MOVK  X10, #0xcccf, LSL #32
    MOVK  X10, #0x7df3, LSL #48
    SUB  X13, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xb20b, LSL #0
    MOVK  X10, #0xbd05, LSL #16
    MOVK  X10, #0x253c, LSL #32
    MOVK  X10, #0x6863, LSL #48
    SUB  X13, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x241, LSL #0
    MOVK  X10, #0x7db7, LSL #16
    MOVK  X10, #0x1bd3, LSL #32
    MOVK  X10, #0xd36d, LSL #48
    SUB  X13, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xf5c5, LSL #0
    MOVK  X10, #0xb768, LSL #16
    MOVK  X10, #0x5ed1, LSL #32
    MOVK  X10, #0xf55, LSL #48
    SUB  X13, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xb522, LSL #0
    MOVK  X10, #0xbd6f, LSL #16
    MOVK  X10, #0x3849, LSL #32
    MOVK  X10, #0xf6e8, LSL #48
    SUB  X13, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x9db9, LSL #0
    MOVK  X10, #0x307, LSL #16
    MOVK  X10, #0x1eba, LSL #32
    MOVK  X10, #0x9f41, LSL #48
    SUB  X13, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x6cb1, LSL #0
    MOVK  X10, #0x273b, LSL #16
    MOVK  X10, #0x10e9, LSL #32
    MOVK  X10, #0x31ca, LSL #48
    SUB  X13, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xfdc7, LSL #0
    MOVK  X10, #0xa221, LSL #16
    MOVK  X10, #0x66c4, LSL #32
    MOVK  X10, #0xa54a, LSL #48
    SUB  X13, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xdfe7, LSL #0
    MOVK  X10, #0x8781, LSL #16
    MOVK  X10, #0x7ec0, LSL #32
    MOVK  X10, #0x5f4d, LSL #48
    SUB  X13, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x99, LSL #0
    MRS  X13, FPSR
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D0
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D1
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D2
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D3
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D4
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D5
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D6
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D7
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D8
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x6bd2, LSL #0
    MOVK  X10, #0x4138, LSL #16
    MOVK  X10, #0xc28a, LSL #32
    MOVK  X10, #0x8fb9, LSL #48
    FMOV  X13, V9.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xe6b6, LSL #0
    MOVK  X10, #0xe7f2, LSL #16
    MOVK  X10, #0x1ee7, LSL #32
    MOVK  X10, #0x3390, LSL #48
    FMOV  X13, D9
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xb522, LSL #0
    MOVK  X10, #0xbd6f, LSL #16
    MOVK  X10, #0x3849, LSL #32
    MOVK  X10, #0xf6e8, LSL #48
    FMOV  X13, V10.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x6d7b, LSL #0
    MOVK  X10, #0xb303, LSL #16
    MOVK  X10, #0xc6d9, LSL #32
    MOVK  X10, #0x2c73, LSL #48
    FMOV  X13, D10
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xf020, LSL #0
    MOVK  X10, #0x2dd6, LSL #16
    MOVK  X10, #0xf70b, LSL #32
    MOVK  X10, #0xa854, LSL #48
    FMOV  X13, V11.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0xba71, LSL #0
    MOVK  X10, #0x6b12, LSL #16
    MOVK  X10, #0x937d, LSL #32
    MOVK  X10, #0x50b6, LSL #48
    FMOV  X13, D11
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x6cc2, LSL #0
    MOVK  X10, #0xb11f, LSL #16
    MOVK  X10, #0x7df0, LSL #32
    MOVK  X10, #0x3b5e, LSL #48
    FMOV  X13, V12.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x817, LSL #0
    MOVK  X10, #0xb40, LSL #16
    MOVK  X10, #0x500b, LSL #32
    MOVK  X10, #0x9c86, LSL #48
    FMOV  X13, D12
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D13
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D14
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x6cb1, LSL #0
    MOVK  X10, #0x273b, LSL #16
    MOVK  X10, #0x10e9, LSL #32
    MOVK  X10, #0x31ca, LSL #48
    FMOV  X13, V16.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x114e, LSL #0
    MOVK  X10, #0x86cf, LSL #16
    MOVK  X10, #0xf136, LSL #32
    MOVK  X10, #0x1fbf, LSL #48
    FMOV  X13, D16
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D17
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D19
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D20
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D21
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D22
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D23
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D24
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D25
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D26
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D27
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D28
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D29
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D30
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D31
    SUB  X12, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
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
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X21
    FMOV  V0.D[1], X26
    FMOV  D1, X20
    FMOV  V1.D[1], X27
    FMOV  D2, X15
    FMOV  V2.D[1], X28
    FMOV  D3, X18
    FMOV  V3.D[1], X17
    FMOV  D4, X25
    FMOV  V4.D[1], X19
    FMOV  D5, X29
    FMOV  V5.D[1], X22
    FMOV  D6, X19
    FMOV  V6.D[1], X22
    FMOV  D7, X28
    FMOV  V7.D[1], X16
    FMOV  D8, X18
    FMOV  V8.D[1], X29
    FMOV  D9, X19
    FMOV  V9.D[1], X19
    FMOV  D10, X27
    FMOV  V10.D[1], X29
    FMOV  D11, X10
    FMOV  V11.D[1], X19
    FMOV  D12, X12
    FMOV  V12.D[1], X27
    FMOV  D13, X15
    FMOV  V13.D[1], X29
    FMOV  D14, X13
    FMOV  V14.D[1], X19
    FMOV  D15, X9
    FMOV  V15.D[1], X28
    FMOV  D16, X26
    FMOV  V16.D[1], X28
    FMOV  D17, X13
    FMOV  V17.D[1], X6
    FMOV  D18, X26
    FMOV  V18.D[1], X27
    FMOV  D19, X29
    FMOV  V19.D[1], X6
    FMOV  D20, X29
    FMOV  V20.D[1], X6
    FMOV  D21, X5
    FMOV  V21.D[1], X20
    FMOV  D22, X21
    FMOV  V22.D[1], X22
    FMOV  D23, X10
    FMOV  V23.D[1], X13
    FMOV  D24, X15
    FMOV  V24.D[1], X5
    FMOV  D25, X13
    FMOV  V25.D[1], X25
    FMOV  D26, X8
    FMOV  V26.D[1], X14
    FMOV  D27, X13
    FMOV  V27.D[1], X2
    FMOV  D28, X8
    FMOV  V28.D[1], X29
    FMOV  D29, X29
    FMOV  V29.D[1], X2
    FMOV  D30, X12
    FMOV  V30.D[1], X6
    FMOV  D31, X9
    FMOV  V31.D[1], X18
    MOVZ  X25, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_19:
    FCVTZS  S3, S25
    FCVTPU  H30, H27
    FCVTZS D25, D31, #36
    FCVTXN  S20, D29
    FCVTMU  S21, S26
    FCVTZU D2, D28, #41
    FCVTPU  H0, H25
    FCVTZS  S1, S0
    FCVTMS  S19, S2
    FCVTZS  S1, S20
    FCVTNS  H16, H19
    FCVTAS  D31, D3
    FCVTAU  S8, S31
    FCVTZS  D10, D16
    FCVTZU  D12, D1
    FCVTAU  S19, S30
    FCVTAU  D12, D10
    FCVTNS  H4, H8
    FCVTPU  S0, S21
    FCVTZU  S24, S0
    FCVTZU H30, H19, #5
    FCVTMU  H10, H4
    FCVTZS  H4, H10
    FCVTZU H26, H4, #10
    FCVTAS  D0, D26
    FCVTZU  S21, S30
    FCVTMU  D2, D12
    FCVTZS  D26, D2
    FCVTNU  S19, S24
    FCVTZU  S24, S21
    FCVTXN  S3, D19
    FCVTZS  H30, H23
    FCVTMU  H8, H0
    FCVTAS  H1, H24
    FCVTAU  D24, D8
    FCVTAS  S16, S24
    FCVTNU  H21, H1
    FCVTZU  S10, S10
    FCVTZU  S0, S26
    FCVTAS  D19, D21
    FCVTZU S8, S3, #19
    FCVTAS  S24, S19
    FCVTMU  D2, D24
    FCVTZU D3, D2, #31
    FCVTMU  D4, D3
    FCVTMS  S1, S30
    FCVTAS  D12, D10
    FCVTZS  S23, S16
    FCVTAU  H21, H1
    FCVTPU  D26, D21
    FCVTPU  H19, H4
    FCVTAS  D24, D8
    FCVTPS  S1, S24
    FCVTPS  D3, D23
    FCVTZU  S4, S19
    FCVTAU  D10, D12
    FCVTZU H2, H26, #7
    FCVTZS D19, D0, #25
    FCVTZS H0, H16, #13
    FCVTNS  H30, H19
    FCVTZS H16, H3, #16
    FCVTMS  H5, H0
    FCVTZS H8, H5, #6
    FCVTZU D5, D2, #43
    FCVTAU  D10, D10
    FCVTAU  D0, D1
    FCVTNU  S24, S4
    FCVTNU  D21, D30
    FCVTZU  D7, D21
    FCVTAS  D21, D16
    FCVTZU D16, D27, #54
    FCVTAS  D26, D5
    FCVTMS  S3, S7
    FCVTZS  S30, S24
    FCVTPS  D4, D21
    FCVTZU  H27, H30
    FCVTAU  D19, D27
    FCVTAS  H2, H14
    FCVTNU  S30, S10
    FCVTZU D1, D31, #33
    FCVTNS  H27, H26
    FCVTZU S14, S6, #5
    FCVTPU  H6, H26
    FCVTZU H24, H6, #8
    FCVTZU S31, S0, #32
    FCVTZS  S12, S4
    FCVTMS  H9, H8
    FCVTZS H26, H16, #16
    FCVTAS  S7, S24
    FCVTNU  H10, H19
    FCVTMS  H21, H30
    FCVTAS  H19, H10
    FCVTMU  H5, H21
    FCVTAU  S21, S9
    FCVTPU  H18, H19
    FCVTNU  H6, H31
    FCVTZU  D0, D12
    FCVTMU  H16, H0
    FCVTAS  S8, S2
    FCVTPS  S19, S3
    FCVTXN  S10, D5
    FCVTZS H12, H21, #14
    FCVTZU  H9, H8
    FCVTZS D4, D26, #11
    FCVTXN  S24, D4
    FCVTZS  S31, S9
    FCVTAS  S13, S7
    FCVTZU  S30, S13
    FCVTAU  S15, S16
    FCVTAS  H16, H15
    FCVTAS  H12, H12
    FCVTPS  H15, H19
    FCVTZU  H8, H24
    FCVTXN  S7, D30
    FCVTPU  D24, D31
    FCVTZS H13, H12, #6
    FCVTZS H26, H15, #2
    FCVTZS  D9, D16
    FCVTZU  D30, D26
    FCVTMU  H21, H30
    FCVTXN  S4, D10
    FCVTZU  H10, H9
    FCVTZS  S9, S10
    FCVTPU  H16, H7
    FCVTZU  H7, H21
    FCVTAS  D19, D13
    FCVTMS  D5, D24
    FCVTZS  D26, D8
    FCVTZU S24, S4, #10
    FCVTPU  S30, S24
    FCVTPS  S10, S16
    FCVTAU  D31, D10
    FCVTMU  H10, H5
    FCVTPU  H4, H30
    FCVTAS  H13, H26
    FCVTZU  D15, D7
    FCVTPU  S21, S4
    FCVTNU  D16, D21
    FCVTAS  H21, H19
    FCVTZS H7, H10, #9
    FCVTNU  S4, S9
    FCVTMS  S5, S31
    FCVTZU S12, S7, #13
    FCVTNU  D9, D2
    FCVTMU  H30, H9
    FCVTMS  S9, S30
    FCVTMU  H2, H9
    FCVTNU  S8, S13
    FCVTZU  S4, S12
    FCVTZS S24, S0, #10
    FCVTZS  D30, D2
    FCVTZU S26, S15, #2
    FCVTZS  H31, H16
    FCVTMU  H16, H5
    FCVTAU  H0, H16
    FCVTPS  H2, H0
    FCVTMS  H12, H21
    FCVTNS  D16, D12
    FCVTPS  S7, S16
    FCVTNU  D13, D24
    FCVTZS  H9, H13
    FCVTZU  H21, H2
    FCVTZU  H0, H21
    FCVTZU H21, H26, #14
    FCVTPS  S15, S14
    FCVTZS D14, D30, #42
    FCVTPS  S5, S4
    FCVTZU  H16, H31
    FCVTNS  H2, H16
    FCVTZS S16, S15, #25
    FCVTMS  D15, D21
    FCVTAS  D21, D15
    FCVTMU  S26, S9
    FCVTNS  D13, D2
    FCVTMS  D24, D13
    FCVTNS  D9, D7
    FCVTZS H12, H0, #7
    FCVTNU  D0, D9
    FCVTPS  D9, D21
    FCVTAS  S7, S12
    FCVTNU  S31, S14
    FCVTZS D30, D5, #43
    FCVTPU  D2, D0
    FCVTPU  H14, H0
    FCVTZS D27, D30, #53
    FCVTZS  H15, H24
    FCVTZU  D5, D26
    FCVTMU  S13, S9
    FCVTNU  S26, S5
    FCVTZU S21, S16, #19
    FCVTZS  S0, S7
    FCVTPS  S16, S21
    FCVTPS  H7, H14
    FCVTAU  H24, H7
    FCVTMU  D12, D13
    FCVTMU  H30, H31
    FCVTAS  S9, S0
    FCVTZU S31, S9, #3
    FCVTAU  S7, S4
    FCVTZU  H0, H26
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_19
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x99, LSL #0
    MRS  X17, FPSR
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D0
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D3
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D4
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D5
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D7
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D11
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D13
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D16
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D17
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D19
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D21
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D30
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, D31
    SUB  X2, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X10
    FMOV  D3, X13
    FMOV  V3.D[1], X15
    FMOV  D4, X26
    FMOV  V4.D[1], X27
    FMOV  D5, X13
    FMOV  V5.D[1], X2
    FMOV  D6, X29
    FMOV  V6.D[1], X29
    FMOV  D7, X26
    FMOV  V7.D[1], X15
    FMOV  D8, X16
    FMOV  V8.D[1], X5
    FMOV  D9, X16
    FMOV  V9.D[1], X21
    FMOV  D10, X21
    FMOV  V10.D[1], X21
    FMOV  D11, X27
    FMOV  V11.D[1], X2
    FMOV  D12, X29
    FMOV  V12.D[1], X20
    FMOV  D13, X10
    FMOV  V13.D[1], X25
    FMOV  D14, X14
    FMOV  V14.D[1], X18
    FMOV  D15, X6
    FMOV  V15.D[1], X18
    FMOV  D16, X19
    FMOV  V16.D[1], X17
    FMOV  D17, X10
    FMOV  V17.D[1], X15
    FMOV  D18, X20
    FMOV  V18.D[1], X28
    FMOV  D19, X5
    FMOV  V19.D[1], X19
    FMOV  D20, X9
    FMOV  V20.D[1], X20
    FMOV  D21, X25
    FMOV  V21.D[1], X22
    FMOV  D22, X20
    FMOV  V22.D[1], X9
    FMOV  D23, X8
    FMOV  V23.D[1], X27
    FMOV  D24, X7
    FMOV  V24.D[1], X18
    FMOV  D25, X15
    FMOV  V25.D[1], X21
    FMOV  D26, X16
    FMOV  V26.D[1], X10
    FMOV  D27, X20
    FMOV  V27.D[1], X5
    FMOV  D28, X16
    FMOV  V28.D[1], X16
    FMOV  D29, X7
    FMOV  V29.D[1], X25
    FMOV  D30, X16
    FMOV  V30.D[1], X22
    FMOV  D31, X19
    FMOV  V31.D[1], X9
    MOVZ  X9, #0xf, LSL #0
TSRTAdvsimdScalarFloatPointConvertToInteger_label_20:
    FCVTZS D31, D21, #51
    FCVTNU  D22, D23
    FCVTPU  S5, S24
    FCVTZU  D1, D25
    FCVTZS S12, S26, #26
    FCVTPU  S7, S12
    FCVTNS  S3, S27
    FCVTZU  D0, D31
    FCVTPS  D7, D22
    FCVTMU  H31, H30
    FCVTNU  H5, H7
    FCVTMU  S25, S5
    FCVTZU H4, H29, #15
    FCVTMU  S4, S1
    FCVTMU  H2, H31
    FCVTAS  D2, D28
    FCVTZS  S7, S2
    FCVTZU D9, D7, #29
    FCVTNS  H24, H3
    FCVTAS  D4, D25
    FCVTZU  S12, S0
    FCVTAU  S25, S9
    FCVTPU  S1, S24
    FCVTNU  D29, D4
    FCVTXN  S26, D1
    FCVTZU S9, S25, #19
    FCVTAU  S28, S12
    FCVTNS  D22, D29
    FCVTPS  D29, D26
    FCVTNS  H7, H9
    FCVTZS  H27, H22
    FCVTZU  S5, S28
    FCVTZS S30, S27, #17
    FCVTMS  H26, H30
    FCVTPU  D22, D29
    FCVTPU  S1, S5
    FCVTMS  D27, D7
    FCVTNU  H9, H26
    FCVTNU  H4, H9
    FCVTZS D31, D4, #6
    FCVTZS D12, D29, #20
    FCVTNS  S5, S27
    FCVTZS  D25, D1
    FCVTAS  H3, H22
    FCVTAS  S22, S31
    FCVTAS  H2, H22
    FCVTNS  S28, S27
    FCVTNS  H27, H3
    FCVTMS  S7, S27
    FCVTAU  H26, H7
    FCVTNU  D31, D23
    FCVTZU  S29, S20
    FCVTZU  D20, D13
    FCVTPS  S4, S2
    FCVTNU  H23, H25
    FCVTZU S27, S23, #14
    FCVTZU  D30, D12
    FCVTZS  D23, D4
    FCVTAU  D25, D23
    FCVTNU  S3, S28
    FCVTAS  D22, D5
    FCVTNS  H4, H29
    FCVTMU  S7, S26
    FCVTZU S12, S7, #24
    FCVTZS S7, S27, #32
    FCVTAS  D1, D7
    FCVTAS  S2, S30
    FCVTMU  D23, D3
    FCVTPS  S7, S25
    FCVTZS  D27, D31
    FCVTZS  H26, H29
    FCVTAS  D5, D1
    FCVTAU  S3, S7
    FCVTNU  S31, S26
    FCVTNS  H7, H2
    FCVTZS  H25, H7
    FCVTNU  S26, S25
    FCVTNU  S7, S27
    FCVTZU D28, D5, #62
    FCVTMU  H29, H26
    FCVTPU  H26, H22
    FCVTAU  H22, H28
    FCVTAU  H28, H20
    FCVTZU H1, H4, #3
    FCVTZU S5, S26, #10
    FCVTMU  D2, D7
    FCVTZS S27, S22, #7
    FCVTMU  S22, S28
    FCVTAS  D4, D1
    FCVTAS  H1, H31
    FCVTZU S30, S3, #22
    FCVTZS  H31, H12
    FCVTMS  S20, S23
    FCVTZS  H25, H29
    FCVTNS  S7, S30
    FCVTPS  D12, D22
    FCVTZU H22, H12, #8
    FCVTPS  H29, H4
    FCVTAS  S26, S24
    FCVTNU  D26, D25
    FCVTZS H3, H26, #16
    FCVTMU  H26, H31
    FCVTMS  S4, S26
    FCVTNS  H12, H29
    FCVTZU  S24, S5
    FCVTNS  D28, D20
    FCVTNU  S26, S2
    FCVTZU H30, H22, #9
    FCVTPS  D23, D1
    FCVTNU  S25, S3
    FCVTZU  D2, D12
    FCVTMS  D12, D2
    FCVTMS  D20, D7
    FCVTZU  D7, D4
    FCVTAU  H11, H26
    FCVTMS  H22, H24
    FCVTNU  S31, S22
    FCVTAU  H22, H13
    FCVTAS  H26, H12
    FCVTNU  D13, D26
    FCVTMS  H4, H23
    FCVTZS D23, D0, #52
    FCVTXN  S24, D4
    FCVTNU  S12, S23
    FCVTAU  S2, S11
    FCVTZU  D1, D26
    FCVTPS  H26, H22
    FCVTZS D29, D31, #28
    FCVTAU  D3, D2
    FCVTAS  S2, S29
    FCVTMS  S29, S26
    FCVTZS H4, H29, #11
    FCVTZS  S0, S24
    FCVTXN  S26, D3
    FCVTZS S3, S0, #27
    FCVTPS  S29, S2
    FCVTZS H22, H4, #1
    FCVTNS  S11, S13
    FCVTAU  S2, S11
    FCVTZS  H24, H29
    FCVTPU  H13, H12
    FCVTPU  D31, D13
    FCVTAS  H12, H7
    FCVTZU  S13, S31
    FCVTZU H31, H12, #13
    FCVTPS  D0, D3
    FCVTNS  H3, H0
    FCVTMU  H0, H22
    FCVTAU  D22, D0
    FCVTPS  D4, D22
    FCVTZS  S11, S4
    FCVTNU  D29, D1
    FCVTZU  S7, S11
    FCVTXN  S0, D24
    FCVTNU  S24, S0
    FCVTZU D11, D29, #44
    FCVTMU  S22, S31
    FCVTZS  S12, S13
    FCVTMU  D0, D2
    FCVTZU  S4, S7
    FCVTZU H29, H22, #12
    FCVTZS  D1, D29
    FCVTPS  H31, H0
    FCVTZU S0, S24, #1
    FCVTZU  S2, S4
    FCVTNU  S29, S11
    FCVTZS  D13, D2
    FCVTAS  S7, S12
    FCVTMS  H22, H0
    FCVTAS  H20, H7
    FCVTMU  H24, H31
    FCVTZS  D31, D22
    FCVTZS  H11, H20
    FCVTZU  H10, H24
    FCVTMS  D4, D31
    FCVTAU  D22, D13
    FCVTZU  S2, S1
    FCVTPU  H7, H29
    FCVTNU  H13, H11
    FCVTZS D31, D2, #4
    FCVTPS  D1, D7
    FCVTZU  H2, H4
    FCVTNU  S17, S10
    FCVTPS  H7, H22
    FCVTZS  H24, H7
    FCVTZS  S7, S13
    FCVTMU  H4, H7
    FCVTZS  H0, H2
    FCVTZU  D2, D9
    FCVTNS  S22, S0
    FCVTZU  D20, D1
    FCVTAU  D12, D24
    FCVTZS  S10, S20
    FCVTPS  H1, H17
    FCVTNS  H7, H10
    FCVTNU  D13, D12
    FCVTAS  S11, S31
    FCVTZS D20, D9, #48
    FCVTAS  D29, D4
    FCVTNS  S0, S11
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdScalarFloatPointConvertToInteger_label_20
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x99, LSL #0
    MRS  X7, FPSR
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D0
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D1
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D2
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D3
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D4
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D5
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V6.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D6
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D7
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V8.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D8
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D9
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V10.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D10
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V11.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D11
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D12
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D13
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V14.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D14
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V15.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D15
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V16.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D16
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D17
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V18.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D18
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V19.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D19
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D20
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, V21.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X7, D21
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D22
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D23
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D24
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D25
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D26
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D27
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D28
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D29
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D30
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X7, D31
    SUB  X8, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail

TSRTAdvsimdScalarFloatPointConvertToInteger_TestEnd:
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
TSRTAdvsimdScalarFloatPointConvertToInteger_TestFail:
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
