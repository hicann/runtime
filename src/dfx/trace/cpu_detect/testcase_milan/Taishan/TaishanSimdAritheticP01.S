.global TaishanSimdAritheticP01

.text
.p2align 4

TaishanSimdAritheticP01:

TaishanSimdAritheticP01_TestBegin:
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
    MOVK  X2, #0x76af, LSL #48
    MOVK  X2, #0x7c39, LSL #32
    MOVK  X2, #0x1150, LSL #16
    MOVK  X2, #0x1132, LSL #0
    MOVK  X3, #0x8530, LSL #48
    MOVK  X3, #0x7d87, LSL #32
    MOVK  X3, #0x7ba3, LSL #16
    MOVK  X3, #0xdaec, LSL #0
    MOVK  X4, #0xbb14, LSL #48
    MOVK  X4, #0xe034, LSL #32
    MOVK  X4, #0x1c8c, LSL #16
    MOVK  X4, #0xa291, LSL #0
    MOVK  X5, #0x98f4, LSL #48
    MOVK  X5, #0xefc0, LSL #32
    MOVK  X5, #0x5c82, LSL #16
    MOVK  X5, #0xaf4e, LSL #0
    MOVK  X6, #0xde5f, LSL #48
    MOVK  X6, #0xe408, LSL #32
    MOVK  X6, #0x16bc, LSL #16
    MOVK  X6, #0xeff6, LSL #0
    MOVK  X7, #0x3beb, LSL #48
    MOVK  X7, #0xdb0, LSL #32
    MOVK  X7, #0x26ca, LSL #16
    MOVK  X7, #0xfbb0, LSL #0
    MOVK  X8, #0xe5e8, LSL #48
    MOVK  X8, #0xdcab, LSL #32
    MOVK  X8, #0x4dd5, LSL #16
    MOVK  X8, #0xe179, LSL #0
    MOVK  X9, #0x570b, LSL #48
    MOVK  X9, #0x99db, LSL #32
    MOVK  X9, #0xb7b0, LSL #16
    MOVK  X9, #0x38c3, LSL #0
    MOVK  X10, #0x9416, LSL #48
    MOVK  X10, #0x9957, LSL #32
    MOVK  X10, #0x6d6d, LSL #16
    MOVK  X10, #0x3a18, LSL #0
    MOVK  X11, #0x7f3c, LSL #48
    MOVK  X11, #0x557, LSL #32
    MOVK  X11, #0x5fac, LSL #16
    MOVK  X11, #0x575b, LSL #0
    MOVK  X12, #0x2cad, LSL #48
    MOVK  X12, #0x400b, LSL #32
    MOVK  X12, #0x1836, LSL #16
    MOVK  X12, #0x96, LSL #0
    MOVK  X13, #0x2f17, LSL #48
    MOVK  X13, #0xee90, LSL #32
    MOVK  X13, #0xaea2, LSL #16
    MOVK  X13, #0xfe77, LSL #0
    MOVK  X14, #0xa492, LSL #48
    MOVK  X14, #0x1269, LSL #32
    MOVK  X14, #0x6336, LSL #16
    MOVK  X14, #0x8342, LSL #0
    MOVK  X15, #0x28e0, LSL #48
    MOVK  X15, #0x9157, LSL #32
    MOVK  X15, #0x4f44, LSL #16
    MOVK  X15, #0xb5cf, LSL #0
    MOVK  X16, #0xc183, LSL #48
    MOVK  X16, #0x6aa5, LSL #32
    MOVK  X16, #0x6d54, LSL #16
    MOVK  X16, #0x72d5, LSL #0
    MOVK  X17, #0x6178, LSL #48
    MOVK  X17, #0x73bb, LSL #32
    MOVK  X17, #0xbe38, LSL #16
    MOVK  X17, #0xb261, LSL #0
    MOVK  X18, #0xdde8, LSL #48
    MOVK  X18, #0xd425, LSL #32
    MOVK  X18, #0x49ab, LSL #16
    MOVK  X18, #0xcafd, LSL #0
    MOVK  X19, #0xd03d, LSL #48
    MOVK  X19, #0xb6de, LSL #32
    MOVK  X19, #0xa969, LSL #16
    MOVK  X19, #0x7416, LSL #0
    MOVK  X20, #0x589, LSL #48
    MOVK  X20, #0xf9d1, LSL #32
    MOVK  X20, #0x4687, LSL #16
    MOVK  X20, #0xcbca, LSL #0
    MOVK  X21, #0xc83c, LSL #48
    MOVK  X21, #0x73b5, LSL #32
    MOVK  X21, #0xfce, LSL #16
    MOVK  X21, #0x83ac, LSL #0
    MOVK  X22, #0xc799, LSL #48
    MOVK  X22, #0xa891, LSL #32
    MOVK  X22, #0x158b, LSL #16
    MOVK  X22, #0xd626, LSL #0
    MOVK  X23, #0x9a83, LSL #48
    MOVK  X23, #0x835a, LSL #32
    MOVK  X23, #0xdd2a, LSL #16
    MOVK  X23, #0xdd22, LSL #0
    MOVK  X24, #0xa5c5, LSL #48
    MOVK  X24, #0x5e10, LSL #32
    MOVK  X24, #0x9a63, LSL #16
    MOVK  X24, #0x6a49, LSL #0
    MOVK  X25, #0x80c6, LSL #48
    MOVK  X25, #0xf46e, LSL #32
    MOVK  X25, #0x6948, LSL #16
    MOVK  X25, #0x4051, LSL #0
    MOVK  X26, #0xb965, LSL #48
    MOVK  X26, #0xe24e, LSL #32
    MOVK  X26, #0xca7e, LSL #16
    MOVK  X26, #0xc7a1, LSL #0
    MOVK  X27, #0x1187, LSL #48
    MOVK  X27, #0x3613, LSL #32
    MOVK  X27, #0x9300, LSL #16
    MOVK  X27, #0xc1e3, LSL #0
    MOVK  X28, #0x137, LSL #48
    MOVK  X28, #0x79b2, LSL #32
    MOVK  X28, #0xb28f, LSL #16
    MOVK  X28, #0xb9f9, LSL #0
    ADDS  X15, X11, X28, LSR #49
    MOVZ  X16, #0x81ad, LSL #0
    MOVK  X16, #0x265f, LSL #16
    MSR  FPCR, X16
    MRS  X7, FPSR
    MOVZ  X3, #0xff60, LSL #0
    MOVK  X3, #0x7ff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X7, X7, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X7, X7, X3
    MSR  FPSR, X7
    ISB  SY
    MOVZ  X2, #0x601d, LSL #0
    MOVK  X2, #0xfb20, LSL #16
    MOVK  X2, #0xfc1, LSL #32
    MOVK  X2, #0x98e6, LSL #48
    MOVZ  X3, #0x1626, LSL #0
    MOVK  X3, #0xfce6, LSL #16
    MOVK  X3, #0xb50, LSL #32
    MOVK  X3, #0x1719, LSL #48
    MOVZ  X4, #0x2d00, LSL #0
    MOVK  X4, #0xbac6, LSL #16
    MOVK  X4, #0x7ebd, LSL #32
    MOVK  X4, #0x3f9f, LSL #48
    MOVZ  X5, #0xb2a1, LSL #0
    MOVK  X5, #0xac9e, LSL #16
    MOVK  X5, #0xc142, LSL #32
    MOVK  X5, #0x1d5d, LSL #48
    MOVZ  X6, #0xe3a1, LSL #0
    MOVK  X6, #0xfc7a, LSL #16
    MOVK  X6, #0x3a92, LSL #32
    MOVK  X6, #0x972d, LSL #48
    MOVZ  X7, #0xc4c, LSL #0
    MOVK  X7, #0x81a5, LSL #16
    MOVK  X7, #0x456b, LSL #32
    MOVK  X7, #0x6553, LSL #48
    MOVZ  X8, #0x6dca, LSL #0
    MOVK  X8, #0xf923, LSL #16
    MOVK  X8, #0xed59, LSL #32
    MOVK  X8, #0x2317, LSL #48
    MOVZ  X9, #0xaf2a, LSL #0
    MOVK  X9, #0xf8e, LSL #16
    MOVK  X9, #0xbce5, LSL #32
    MOVK  X9, #0x5694, LSL #48
    MOVZ  X10, #0x9ec2, LSL #0
    MOVK  X10, #0xa9e7, LSL #16
    MOVK  X10, #0x453d, LSL #32
    MOVK  X10, #0x2139, LSL #48
    MOVZ  X11, #0x62ca, LSL #0
    MOVK  X11, #0xabf3, LSL #16
    MOVK  X11, #0xdc52, LSL #32
    MOVK  X11, #0xbca0, LSL #48
    MOVZ  X12, #0xf8b4, LSL #0
    MOVK  X12, #0xd7e6, LSL #16
    MOVK  X12, #0x4fcc, LSL #32
    MOVK  X12, #0x8592, LSL #48
    MOVZ  X13, #0xbe78, LSL #0
    MOVK  X13, #0x11d7, LSL #16
    MOVK  X13, #0xcf5d, LSL #32
    MOVK  X13, #0x5f47, LSL #48
    MOVZ  X14, #0x87e0, LSL #0
    MOVK  X14, #0xe486, LSL #16
    MOVK  X14, #0x6119, LSL #32
    MOVK  X14, #0xab58, LSL #48
    MOVZ  X15, #0x23ce, LSL #0
    MOVK  X15, #0xd443, LSL #16
    MOVK  X15, #0xe19, LSL #32
    MOVK  X15, #0xbd78, LSL #48
    MOVZ  X16, #0xcb65, LSL #0
    MOVK  X16, #0x9230, LSL #16
    MOVK  X16, #0x3e35, LSL #32
    MOVK  X16, #0xe79d, LSL #48
    MOVZ  X17, #0x73d3, LSL #0
    MOVK  X17, #0xf4a6, LSL #16
    MOVK  X17, #0x7fb6, LSL #32
    MOVK  X17, #0xbf6d, LSL #48
    MOVZ  X18, #0x909, LSL #0
    MOVK  X18, #0x9dfe, LSL #16
    MOVK  X18, #0xe474, LSL #32
    MOVK  X18, #0xf41a, LSL #48
    MOVZ  X19, #0x122b, LSL #0
    MOVK  X19, #0x3ef4, LSL #16
    MOVK  X19, #0xa1e5, LSL #32
    MOVK  X19, #0xda29, LSL #48
    MOVZ  X20, #0x16b8, LSL #0
    MOVK  X20, #0xba67, LSL #16
    MOVK  X20, #0x6599, LSL #32
    MOVK  X20, #0x2f51, LSL #48
    MOVZ  X21, #0x6ad, LSL #0
    MOVK  X21, #0x9bd9, LSL #16
    MOVK  X21, #0xb951, LSL #32
    MOVK  X21, #0xf725, LSL #48
    MOVZ  X22, #0x41d8, LSL #0
    MOVK  X22, #0xb06b, LSL #16
    MOVK  X22, #0x1f3a, LSL #32
    MOVK  X22, #0x8935, LSL #48
    MOVZ  X23, #0xd495, LSL #0
    MOVK  X23, #0x3df9, LSL #16
    MOVK  X23, #0xd1dc, LSL #32
    MOVK  X23, #0xbf10, LSL #48
    MOVZ  X24, #0xc4, LSL #0
    MOVK  X24, #0x8601, LSL #16
    MOVK  X24, #0x27b7, LSL #32
    MOVK  X24, #0xc174, LSL #48
    MOVZ  X25, #0xa6bd, LSL #0
    MOVK  X25, #0xa321, LSL #16
    MOVK  X25, #0xebe0, LSL #32
    MOVK  X25, #0x40e6, LSL #48
    MOVZ  X26, #0xc7e6, LSL #0
    MOVK  X26, #0x28d1, LSL #16
    MOVK  X26, #0x6d0, LSL #32
    MOVK  X26, #0xed4e, LSL #48
    MOVZ  X27, #0xbf96, LSL #0
    MOVK  X27, #0xff86, LSL #16
    MOVK  X27, #0xf0d1, LSL #32
    MOVK  X27, #0xe1f6, LSL #48
    MOVZ  X28, #0xd8e5, LSL #0
    MOVK  X28, #0xda37, LSL #16
    MOVK  X28, #0x334f, LSL #32
    MOVK  X28, #0xac96, LSL #48
    FMOV  D0, X2
    FMOV  V0.D[1], X13
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X5
    FMOV  V2.D[1], X27
    FMOV  D3, X3
    FMOV  V3.D[1], X10
    FMOV  D4, X18
    FMOV  V4.D[1], X20
    FMOV  D5, X18
    FMOV  V5.D[1], X9
    FMOV  D6, X6
    FMOV  V6.D[1], X5
    FMOV  D7, X7
    FMOV  V7.D[1], X18
    FMOV  D8, X5
    FMOV  V8.D[1], X18
    FMOV  D9, X11
    FMOV  V9.D[1], X4
    FMOV  D10, X24
    FMOV  V10.D[1], X27
    FMOV  D11, X3
    FMOV  V11.D[1], X26
    FMOV  D12, X28
    FMOV  V12.D[1], X4
    FMOV  D13, X2
    FMOV  V13.D[1], X14
    FMOV  D14, X17
    FMOV  V14.D[1], X11
    FMOV  D15, X6
    FMOV  V15.D[1], X18
    FMOV  D16, X21
    FMOV  V16.D[1], X15
    FMOV  D17, X9
    FMOV  V17.D[1], X8
    FMOV  D18, X25
    FMOV  V18.D[1], X22
    FMOV  D19, X21
    FMOV  V19.D[1], X26
    FMOV  D20, X11
    FMOV  V20.D[1], X10
    FMOV  D21, X4
    FMOV  V21.D[1], X9
    FMOV  D22, X10
    FMOV  V22.D[1], X23
    FMOV  D23, X9
    FMOV  V23.D[1], X25
    FMOV  D24, X6
    FMOV  V24.D[1], X21
    FMOV  D25, X21
    FMOV  V25.D[1], X23
    FMOV  D26, X4
    FMOV  V26.D[1], X25
    FMOV  D27, X12
    FMOV  V27.D[1], X12
    FMOV  D28, X8
    FMOV  V28.D[1], X17
    FMOV  D29, X16
    FMOV  V29.D[1], X26
    FMOV  D30, X7
    FMOV  V30.D[1], X17
    FMOV  D31, X9
    FMOV  V31.D[1], X10
    MOVZ  X19, #0xa, LSL #0
TaishanSimdAritheticP01_label_0:
    UQSHRN2 V12.8H, V17.4S, #3
    SQSHLU S2, S20, #0xe
    FMOV  V2.2D, #-2.37500000
    UQSHRN V14.8B, V31.8H, #7
    SRSHR  V12.4H, V25.4H, #6
    SSHLL2 V18.4S, V12.8H, #0xa
    MOVI  V26.4S, #0xa8, LSL #16
    UQRSHRN B11, H15, #5
    SQSHL D24, D0, #0x1
    UQSHL H7, H11, #0x6
    RSHRN2 V30.16B, V15.8H, #1
    USRA D27, D22, #36
    ORR  V29.4S, #0x18, LSL #24
    SQSHLU B29, B22, #0x1
    SSHLL V2.2D, V5.2S, #0x14
    SHL  V4.4S, V6.4S, #0x13
    UQSHRN V14.2S, V4.2D, #14
    SQSHRN H8, S7, #11
    SSHR  V26.4H, V31.4H, #8
    SQSHRUN V8.8B, V6.8H, #8
    UQSHRN H12, S28, #4
    UQSHL  V26.16B, V11.16B, #0x2
    SQSHRN V29.4H, V18.4S, #1
    SRSRA  V29.4S, V26.4S, #28
    SSHR V9.2D, V2.2D, #1
    SQRSHRUN H25, S20, #9
    SQRSHRUN V2.4H, V27.4S, #14
    SRSRA  V24.4S, V24.4S, #27
    USHLL V29.4S, V10.4H, #0x9
    USHLL2 V7.2D, V20.4S, #0x2
    SQSHRN2 V24.16B, V8.8H, #3
    SQSHL D13, D6, #0x31
    SRSRA D26, D29, #8
    SHRN V13.4H, V27.4S, #7
    UQRSHRN B2, H26, #6
    SSHR  V13.2S, V28.2S, #17
    MVNI  V6.2S, #0xa8, MSL #16
    MOVI  V21.2D, #16776960
    RSHRN V12.4H, V25.4S, #2
    MOVI  V0.2S, #0x64, MSL #8
    SQSHRUN V4.2S, V7.2D, #7
    SQSHL  V2.2S, V0.2S, #0x1b
    SQSHLU H4, H8, #0x9
    UQSHRN2 V24.8H, V2.4S, #9
    SSRA  V20.16B, V3.16B, #8
    SQRSHRN2 V3.8H, V13.4S, #3
    SSHR  V3.4H, V20.4H, #15
    UQSHRN V7.4H, V4.4S, #1
    SRSRA  V7.4S, V21.4S, #10
    SQSHRUN2 V24.16B, V1.8H, #3
    URSRA  V24.8H, V20.8H, #12
    SHRN2 V19.4S, V14.2D, #9
    UQSHRN2 V18.8H, V6.4S, #12
    USHR  V3.4H, V19.4H, #4
    UQSHL S12, S26, #0x11
    SRSHR  V3.8B, V12.8B, #1
    SRI D20, D7, #21
    SRSRA V12.2D, V24.2D, #18
    URSHR  V2.4S, V14.4S, #23
    UQSHRN2 V10.4S, V8.2D, #8
    RSHRN V30.4H, V13.4S, #11
    SRSHR V2.2D, V6.2D, #17
    SSRA D22, D21, #11
    UQSHRN V10.2S, V22.2D, #16
    SRSRA  V30.4S, V19.4S, #19
    SHL D3, D19, #0x3
    SQRSHRN S0, D16, #10
    SRI  V20.2S, V30.2S, #4
    SSHR  V1.8B, V26.8B, #7
    USHLL V6.4S, V30.4H, #0x6
    SQRSHRN B19, H6, #8
    SQSHL V18.2D, V27.2D, #0xa
    URSHR D24, D27, #49
    USRA  V8.2S, V2.2S, #11
    UQSHRN2 V30.16B, V13.8H, #1
    SQSHRN S28, D21, #23
    SQSHRUN2 V18.16B, V12.8H, #2
    USHLL2 V31.8H, V22.16B, #0x6
    SQSHRN H10, S4, #7
    SQRSHRUN V4.4H, V23.4S, #6
    SQSHL B15, B24, #0x2
    UQRSHRN2 V17.4S, V26.2D, #22
    SQSHLU  V26.2S, V4.2S, #0x18
    URSHR V26.2D, V24.2D, #11
    SRSHR V31.2D, V4.2D, #38
    MOVI  V4.4S, #0x8f, LSL #24
    SHL D27, D2, #0x1b
    UQRSHRN2 V14.4S, V18.2D, #32
    UQRSHRN V10.4H, V9.4S, #4
    UQRSHRN2 V24.4S, V20.2D, #17
    UQSHRN V8.8B, V4.8H, #2
    USHR  V25.8H, V16.8H, #13
    USRA  V10.2S, V10.2S, #28
    SQRSHRN V6.4H, V14.4S, #1
    SQRSHRUN H4, S10, #14
    UQRSHRN2 V12.8H, V28.4S, #10
    FMOV  V31.2S, #-0.21875000
    SQSHLU  V29.4S, V0.4S, #0x0
    SHL  V29.16B, V20.16B, #0x4
    UQSHL H17, H27, #0xd
    UQSHL  V2.8B, V22.8B, #0x6
    SRSRA  V22.8H, V12.8H, #10
    RSHRN2 V24.4S, V0.2D, #15
    SQRSHRUN B7, H24, #1
    SRSRA V17.2D, V9.2D, #46
    URSHR V11.2D, V24.2D, #15
    SHL  V30.2S, V28.2S, #0x6
    SQRSHRN2 V14.8H, V23.4S, #9
    SQSHLU  V27.8H, V30.8H, #0x4
    SQSHRN2 V25.4S, V4.2D, #11
    URSHR  V5.4H, V1.4H, #2
    USHLL2 V20.4S, V6.8H, #0xe
    UQSHRN V23.2S, V24.2D, #2
    SSRA  V20.16B, V21.16B, #3
    MOVI  V18.8B, #0xba
    RSHRN V8.2S, V30.2D, #15
    UQSHL V25.2D, V25.2D, #0x30
    SHL  V1.2S, V16.2S, #0x16
    SSHLL2 V13.4S, V28.8H, #0x7
    UQSHL  B11, B16, B1
    USHLL V14.4S, V28.4H, #0xd
    SRI  V0.8B, V17.8B, #8
    SQRSHRUN V6.8B, V23.8H, #5
    SRSRA  V30.4H, V30.4H, #13
    SQRSHRN H17, S10, #11
    RSHRN V2.4H, V0.4S, #8
    SQSHLU D16, D14, #0x2b
    SRSRA D10, D16, #64
    SSRA  V16.8B, V28.8B, #1
    SRI D9, D6, #5
    SHRN2 V31.4S, V0.2D, #11
    SRSRA  V27.8B, V30.8B, #3
    MOVI  V23.4H, #0x87
    SRSRA D7, D0, #8
    SHRN V0.8B, V19.8H, #5
    SQSHRN2 V14.4S, V26.2D, #31
    MOVI  V12.8B, #0x9b
    SHL  V24.8H, V7.8H, #0x4
    SLI V0.2D, V11.2D, #0xb
    USHLL V4.4S, V9.4H, #0xf
    SQSHRUN V17.8B, V2.8H, #7
    URSRA  V27.4H, V5.4H, #4
    SQSHRN V4.2S, V19.2D, #10
    SQRSHRN S4, D10, #22
    SHLL  V3.4S, V1.4H, #16
    MOVI  V4.8B, #0x1c
    SRI  V31.4H, V9.4H, #6
    USHR  V19.8B, V4.8B, #7
    SQSHLU V31.2D, V29.2D, #0xf
    SLI  V28.4S, V21.4S, #0x8
    USHR  V4.4H, V0.4H, #7
    UQRSHRN2 V26.8H, V12.4S, #11
    USRA  V15.16B, V26.16B, #5
    SQRSHRUN2 V21.8H, V12.4S, #12
    USRA V29.2D, V11.2D, #54
    UQSHL  V17.2S, V26.2S, #0x6
    SQRSHRN V25.8B, V15.8H, #6
    SQSHRN H17, S23, #2
    UQSHRN V25.8B, V9.8H, #6
    USRA V4.2D, V1.2D, #35
    RSHRN2 V26.4S, V19.2D, #28
    UQSHL B7, B27, #0x6
    SQRSHRUN V27.8B, V11.8H, #7
    USRA  V11.2S, V14.2S, #9
    SRSHR  V31.8H, V4.8H, #10
    SLI V12.2D, V26.2D, #0x19
    SQRSHRN B7, H4, #7
    SQRSHRUN S0, D27, #13
    USRA D30, D13, #58
    USHLL2 V9.4S, V13.8H, #0x3
    SQSHRN B15, H14, #7
    SSHLL2 V8.4S, V17.8H, #0x9
    SHL  V4.4S, V10.4S, #0x17
    SQSHRUN V28.2S, V10.2D, #2
    SQSHRN S7, D24, #25
    SHRN V15.4H, V11.4S, #12
    SQRSHRUN2 V8.16B, V13.8H, #2
    SQRSHRUN2 V30.8H, V26.4S, #4
    SHRN2 V7.8H, V30.4S, #3
    SRSHR  V22.16B, V8.16B, #2
    UQSHL  V15.4S, V25.4S, #0x9
    BIC  V18.4H, #0x10
    UQRSHRN H2, S27, #13
    SHL D7, D15, #0x14
    UQSHRN2 V14.16B, V24.8H, #4
    UQSHL  H19, H31, H17
    UQSHL  H19, H28, H12
    UQSHRN2 V12.4S, V10.2D, #9
    SHRN2 V2.8H, V2.4S, #14
    UQSHL D14, D0, #0x12
    SSHLL V19.4S, V2.4H, #0xe
    MOVI  V4.2S, #0xe2, MSL #16
    UQSHRN H17, S18, #3
    SQSHRN2 V24.4S, V24.2D, #26
    SQSHLU  V25.16B, V4.16B, #0x2
    UQSHRN V12.8B, V25.8H, #3
    SHL  V6.2S, V26.2S, #0x15
    URSHR  V23.4H, V21.4H, #14
    SQRSHRN2 V9.8H, V25.4S, #12
    SHL  V9.4S, V6.4S, #0x14
    SUBS  X19, X19, #0x1
    B.NE  TaishanSimdAritheticP01_label_0
    MOVZ  X18, #0x601d, LSL #0
    MOVK  X18, #0xfb20, LSL #16
    MOVK  X18, #0xfc1, LSL #32
    MOVK  X18, #0x98e6, LSL #48
    SUB  X3, X18, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x2d00, LSL #0
    MOVK  X12, #0xbac6, LSL #16
    MOVK  X12, #0x7ebd, LSL #32
    MOVK  X12, #0x3f9f, LSL #48
    SUB  X6, X12, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0xb2a1, LSL #0
    MOVK  X24, #0xac9e, LSL #16
    MOVK  X24, #0xc142, LSL #32
    MOVK  X24, #0x1d5d, LSL #48
    SUB  X5, X24, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x6dca, LSL #0
    MOVK  X26, #0xf923, LSL #16
    MOVK  X26, #0xed59, LSL #32
    MOVK  X26, #0x2317, LSL #48
    SUB  X18, X26, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0xaf2a, LSL #0
    MOVK  X28, #0xf8e, LSL #16
    MOVK  X28, #0xbce5, LSL #32
    MOVK  X28, #0x5694, LSL #48
    SUB  X11, X28, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x9ec2, LSL #0
    MOVK  X2, #0xa9e7, LSL #16
    MOVK  X2, #0x453d, LSL #32
    MOVK  X2, #0x2139, LSL #48
    SUB  X3, X2, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x2d00, LSL #0
    MOVK  X17, #0xbac6, LSL #16
    MOVK  X17, #0x7ebd, LSL #32
    MOVK  X17, #0x3f9f, LSL #48
    SUB  X4, X17, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0xbe78, LSL #0
    MOVK  X18, #0x11d7, LSL #16
    MOVK  X18, #0xcf5d, LSL #32
    MOVK  X18, #0x5f47, LSL #48
    SUB  X19, X18, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0xcb65, LSL #0
    MOVK  X25, #0x9230, LSL #16
    MOVK  X25, #0x3e35, LSL #32
    MOVK  X25, #0xe79d, LSL #48
    SUB  X23, X25, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x2d00, LSL #0
    MOVK  X10, #0xbac6, LSL #16
    MOVK  X10, #0x7ebd, LSL #32
    MOVK  X10, #0x3f9f, LSL #48
    SUB  X19, X10, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0xbe78, LSL #0
    MOVK  X4, #0x11d7, LSL #16
    MOVK  X4, #0xcf5d, LSL #32
    MOVK  X4, #0x5f47, LSL #48
    SUB  X15, X4, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x16b8, LSL #0
    MOVK  X23, #0xba67, LSL #16
    MOVK  X23, #0x6599, LSL #32
    MOVK  X23, #0x2f51, LSL #48
    SUB  X15, X23, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x41d8, LSL #0
    MOVK  X27, #0xb06b, LSL #16
    MOVK  X27, #0x1f3a, LSL #32
    MOVK  X27, #0x8935, LSL #48
    SUB  X23, X27, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0xcb65, LSL #0
    MOVK  X9, #0x9230, LSL #16
    MOVK  X9, #0x3e35, LSL #32
    MOVK  X9, #0xe79d, LSL #48
    SUB  X23, X9, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x41d8, LSL #0
    MOVK  X5, #0xb06b, LSL #16
    MOVK  X5, #0x1f3a, LSL #32
    MOVK  X5, #0x8935, LSL #48
    SUB  X11, X5, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0xaf2a, LSL #0
    MOVK  X19, #0xf8e, LSL #16
    MOVK  X19, #0xbce5, LSL #32
    MOVK  X19, #0x5694, LSL #48
    SUB  X10, X19, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D4
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xe2, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xe2, LSL #48
    SUB  X21, X3, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X18, X15, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D5
    MOVZ  X15, #0x40, LSL #0
    SUB  X18, X15, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D7
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xe000, LSL #16
    MOVK  X28, #0x1f, LSL #32
    SUB  X20, X28, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D10
    MOVZ  X20, #0xffff, LSL #0
    SUB  X21, X20, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D11
    MOVZ  X19, #0x10, LSL #0
    SUB  X26, X19, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D12
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D15
    MOVZ  X12, #0xfe00, LSL #0
    MOVK  X12, #0x1, LSL #16
    SUB  X22, X12, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D16
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x100, LSL #48
    SUB  X23, X12, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D17
    MOVZ  X14, #0xffff, LSL #0
    SUB  X7, X14, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D18
    MOVZ  X8, #0xbaaa, LSL #0
    MOVK  X8, #0xbaaa, LSL #16
    MOVK  X8, #0xbaaa, LSL #32
    MOVK  X8, #0xbaaa, LSL #48
    SUB  X10, X8, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X8, #0xff00, LSL #0
    MOVK  X8, #0xff, LSL #16
    SUB  X2, X8, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D20
    MOVZ  X8, #0xff00, LSL #0
    MOVK  X8, #0xff, LSL #16
    SUB  X2, X8, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D21
    MOVZ  X2, #0xff00, LSL #0
    MOVK  X2, #0xff, LSL #16
    SUB  X23, X2, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D22
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D23
    MOVZ  X15, #0x4, LSL #0
    SUB  X3, X15, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X17, #0x2, LSL #0
    SUB  X3, X17, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D24
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x800, LSL #16
    SUB  X3, X17, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D27
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D28
    MOVZ  X13, #0x3fff, LSL #0
    SUB  X4, X13, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X19
    FMOV  V0.D[1], X14
    FMOV  D1, X26
    FMOV  V1.D[1], X12
    FMOV  D2, X2
    FMOV  V2.D[1], X6
    FMOV  D3, X25
    FMOV  V3.D[1], X22
    FMOV  D4, X11
    FMOV  V4.D[1], X9
    FMOV  D5, X6
    FMOV  V5.D[1], X28
    FMOV  D6, X7
    FMOV  V6.D[1], X3
    FMOV  D7, X22
    FMOV  V7.D[1], X10
    FMOV  D8, X27
    FMOV  V8.D[1], X25
    FMOV  D9, X2
    FMOV  V9.D[1], X26
    FMOV  D10, X28
    FMOV  V10.D[1], X5
    FMOV  D11, X27
    FMOV  V11.D[1], X14
    FMOV  D12, X6
    FMOV  V12.D[1], X15
    FMOV  D13, X16
    FMOV  V13.D[1], X26
    FMOV  D14, X17
    FMOV  V14.D[1], X13
    FMOV  D15, X7
    FMOV  V15.D[1], X24
    FMOV  D16, X20
    FMOV  V16.D[1], X7
    FMOV  D17, X23
    FMOV  V17.D[1], X13
    FMOV  D18, X28
    FMOV  V18.D[1], X10
    FMOV  D19, X7
    FMOV  V19.D[1], X3
    FMOV  D20, X13
    FMOV  V20.D[1], X22
    FMOV  D21, X15
    FMOV  V21.D[1], X19
    FMOV  D22, X13
    FMOV  V22.D[1], X26
    FMOV  D23, X7
    FMOV  V23.D[1], X9
    FMOV  D24, X5
    FMOV  V24.D[1], X20
    FMOV  D25, X22
    FMOV  V25.D[1], X21
    FMOV  D26, X26
    FMOV  V26.D[1], X3
    FMOV  D27, X4
    FMOV  V27.D[1], X14
    FMOV  D28, X28
    FMOV  V28.D[1], X9
    FMOV  D29, X7
    FMOV  V29.D[1], X19
    FMOV  D30, X4
    FMOV  V30.D[1], X9
    FMOV  D31, X6
    FMOV  V31.D[1], X24
    MOVZ  X27, #0xa, LSL #0
TaishanSimdAritheticP01_label_83:
    UQSHL  V13.16B, V13.16B, #0x3
    SSHLL V23.2D, V20.2S, #0xf
    SSRA  V26.8H, V17.8H, #4
    MOVI  D19, #18446744069431296255
    UQRSHRN2 V13.16B, V14.8H, #2
    USHR  V25.16B, V15.16B, #5
    SQSHL H20, H30, #0x5
    SHLL  V20.2D, V26.2S, #32
    SQSHRN2 V24.8H, V20.4S, #15
    MOVI  V27.4S, #0x59, MSL #8
    SHLL  V25.8H, V21.8B, #8
    SRSHR D1, D3, #43
    SQRSHRN B7, H18, #3
    SRSHR V18.2D, V0.2D, #36
    SQSHLU  V27.8B, V9.8B, #0x4
    ORR  V2.8H, #0x1
    SSRA  V23.8H, V8.8H, #3
    SHL  V3.8H, V11.8H, #0xd
    UQRSHRN V28.2S, V29.2D, #11
    SHRN V0.2S, V27.2D, #18
    SQRSHRUN2 V31.8H, V8.4S, #10
    SQRSHRUN2 V18.4S, V22.2D, #19
    SRSRA  V24.8B, V17.8B, #2
    USHR  V24.16B, V17.16B, #5
    SSHLL V6.8H, V19.8B, #0x5
    SQRSHRN V4.4H, V15.4S, #6
    MOVI  V30.2S, #0x70, MSL #8
    FMOV  V10.2S, #1.12500000
    SRI  V13.2S, V12.2S, #2
    SQSHL D25, D28, #0x2b
    SRSHR  V21.8H, V15.8H, #2
    UQSHRN B17, H14, #3
    MOVI  V16.4H, #0x8b, LSL #8
    SHL V14.2D, V28.2D, #0x35
    SHRN2 V3.8H, V21.4S, #7
    SRSHR  V15.4S, V2.4S, #23
    USHLL2 V13.8H, V26.16B, #0x1
    URSRA  V26.4H, V3.4H, #9
    URSRA  V6.2S, V5.2S, #12
    SQSHLU  V11.8B, V26.8B, #0x6
    USHLL V17.2D, V21.2S, #0xd
    URSRA  V9.16B, V24.16B, #3
    SSHLL V12.8H, V19.8B, #0x2
    SSHR D14, D17, #62
    USHLL V15.4S, V9.4H, #0x2
    SHLL  V19.8H, V9.8B, #8
    UQSHL  V2.16B, V21.16B, #0x5
    RSHRN V28.8B, V21.8H, #3
    SRSRA V2.2D, V12.2D, #40
    MOVI  V21.4S, #0xf8
    MOVI  V22.8B, #0x76
    SQRSHRUN V17.8B, V9.8H, #1
    UQRSHRN V16.2S, V24.2D, #26
    SQSHL H9, H26, #0xe
    SHL  V12.4H, V1.4H, #0xc
    SQSHRN V12.8B, V1.8H, #5
    SSHR D2, D18, #32
    SQSHRUN B30, H7, #7
    SQSHRUN S22, D5, #31
    UQSHL S25, S7, #0xb
    UQSHRN2 V24.16B, V26.8H, #8
    SRI  V11.4S, V17.4S, #32
    SSHLL2 V6.2D, V7.4S, #0x10
    SSHLL V4.2D, V7.2S, #0x4
    SQSHRUN V8.8B, V30.8H, #7
    SSHR D29, D12, #19
    SHLL  V5.4S, V14.4H, #16
    SRI D25, D19, #31
    UQRSHRN V18.2S, V22.2D, #14
    SSRA D19, D18, #26
    SRSRA D22, D15, #13
    SRSRA D2, D2, #42
    SHL  V29.2S, V5.2S, #0x11
    UQRSHRN V2.2S, V9.2D, #29
    SQSHRUN2 V28.16B, V4.8H, #1
    SSHLL V3.8H, V7.8B, #0x4
    SSHR V11.2D, V29.2D, #5
    SRSHR  V6.16B, V17.16B, #5
    SHRN V2.2S, V14.2D, #26
    SRI V28.2D, V24.2D, #14
    SQSHRUN2 V14.4S, V17.2D, #5
    SLI D29, D21, #0xb
    UQSHRN2 V7.16B, V7.8H, #7
    UQRSHRN2 V30.16B, V3.8H, #5
    UQRSHRN H11, S1, #8
    SLI  V25.16B, V26.16B, #0x7
    SQRSHRN V8.4H, V17.4S, #4
    SQSHLU  V24.8H, V7.8H, #0x9
    UQSHRN V30.8B, V2.8H, #3
    URSRA  V15.2S, V26.2S, #24
    SLI  V14.16B, V11.16B, #0x1
    USHLL2 V3.4S, V26.8H, #0x3
    SRSHR  V18.16B, V30.16B, #8
    SHL  V29.8B, V13.8B, #0x3
    RSHRN V4.2S, V4.2D, #15
    SQSHLU  V16.4H, V27.4H, #0x1
    USHR  V18.4H, V1.4H, #5
    MVNI  V21.2S, #0x1e, LSL #24
    SHRN V6.2S, V4.2D, #19
    BIC  V26.4H, #0x12, LSL #8
    SQRSHRUN B10, H25, #4
    SQRSHRN V1.2S, V20.2D, #32
    SHLL2  V2.4S, V26.8H, #16
    SLI D2, D13, #0x15
    SRSRA V0.2D, V30.2D, #13
    SRI D20, D14, #11
    SSHLL V0.8H, V20.8B, #0x6
    SRSHR  V29.8H, V13.8H, #14
    URSHR  V7.4S, V7.4S, #20
    SSHR  V4.16B, V6.16B, #5
    SQRSHRN2 V26.16B, V0.8H, #7
    USHLL2 V17.4S, V3.8H, #0x4
    MVNI  V28.4S, #0x4f, LSL #8
    URSRA  V11.8H, V6.8H, #5
    SQSHL H20, H28, #0x7
    UQSHRN2 V21.8H, V5.4S, #2
    USHLL V21.2D, V31.2S, #0x6
    SQSHRN H31, S4, #12
    SQSHRN2 V14.16B, V23.8H, #6
    USRA  V28.2S, V2.2S, #4
    SHRN V29.8B, V1.8H, #7
    USHR V6.2D, V13.2D, #19
    SQSHRUN V25.4H, V4.4S, #3
    SQSHLU S7, S29, #0x10
    URSHR  V4.16B, V0.16B, #2
    SHRN V28.2S, V28.2D, #28
    SQSHRUN H13, S23, #9
    UQRSHRN S14, D13, #4
    URSRA  V10.16B, V8.16B, #6
    BIC  V13.2S, #0x28
    UQSHL V7.2D, V6.2D, #0x37
    SQRSHRN V6.8B, V8.8H, #7
    URSHR  V27.2S, V6.2S, #4
    SRI V10.2D, V2.2D, #46
    SHRN2 V11.16B, V13.8H, #8
    SQSHRUN2 V20.4S, V0.2D, #13
    MVNI  V7.4H, #0xff
    SRSHR  V19.4H, V25.4H, #3
    UQSHL  S25, S5, S20
    SSHLL2 V9.8H, V4.16B, #0x6
    SQRSHRN S1, D1, #12
    UQRSHRN2 V28.8H, V1.4S, #8
    UQSHL  V1.16B, V10.16B, V13.16B
    MOVI  V21.2S, #0x4, MSL #8
    SRSRA  V14.8H, V23.8H, #7
    SQRSHRN V19.4H, V22.4S, #14
    UQSHL B4, B17, #0x2
    SRSRA V28.2D, V21.2D, #12
    SSHLL2 V13.4S, V12.8H, #0xa
    SQSHLU  V10.4H, V31.4H, #0x2
    RSHRN2 V5.16B, V26.8H, #4
    SRI D29, D15, #2
    UQSHRN2 V20.16B, V12.8H, #5
    SSRA V23.2D, V0.2D, #58
    UQSHRN2 V25.4S, V14.2D, #23
    UQSHRN S29, D26, #16
    SHRN V21.2S, V29.2D, #26
    UQSHL H20, H22, #0xa
    SSRA  V13.8H, V1.8H, #7
    SSHLL V8.8H, V19.8B, #0x2
    URSRA  V26.4H, V30.4H, #1
    URSRA  V26.8B, V18.8B, #2
    SQRSHRN S28, D31, #28
    SSHR D23, D30, #12
    URSHR  V30.8H, V31.8H, #11
    MVNI  V6.2S, #0xd, LSL #8
    SSRA  V10.8H, V22.8H, #4
    RSHRN2 V10.16B, V11.8H, #5
    SHL  V24.4S, V13.4S, #0x0
    MOVI  V14.2D, #18374966855153418495
    MVNI  V18.2S, #0x86
    USHLL2 V15.8H, V20.16B, #0x6
    UQRSHRN V1.8B, V12.8H, #1
    SHL V8.2D, V26.2D, #0x1b
    SQRSHRN2 V10.8H, V1.4S, #7
    URSHR D0, D4, #18
    SHLL2  V29.8H, V3.16B, #8
    SHL V5.2D, V24.2D, #0x13
    UQSHL  D5, D31, D13
    SHL  V20.8H, V15.8H, #0x0
    SHRN V5.8B, V31.8H, #2
    RSHRN2 V13.16B, V16.8H, #3
    MVNI  V19.4H, #0xba
    SQRSHRUN2 V19.8H, V19.4S, #10
    ORR  V19.4S, #0xad, LSL #24
    UQSHL V12.2D, V3.2D, #0x3d
    SQSHRUN B18, H8, #2
    UQSHL  V10.8B, V26.8B, #0x0
    SQSHRUN V23.2S, V4.2D, #25
    SQRSHRN S5, D14, #16
    SQSHLU B23, B16, #0x5
    SQRSHRUN2 V1.8H, V16.4S, #5
    SRSRA  V29.16B, V21.16B, #4
    URSRA  V17.4S, V14.4S, #25
    URSHR  V7.4S, V11.4S, #5
    USRA V26.2D, V15.2D, #46
    UQSHL H6, H11, #0xa
    UQSHL  H29, H18, H20
    UQRSHRN V31.8B, V0.8H, #2
    UQSHL V1.2D, V7.2D, #0x1
    SUBS  X27, X27, #0x1
    B.NE  TaishanSimdAritheticP01_label_83
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D4
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D5
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X2, X23, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D8
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x4000, LSL #48
    SUB  X7, X2, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D10
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x48, LSL #32
    SUB  X7, X24, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D12
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D13
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X4, #0xff, LSL #0
    MOVK  X4, #0xff, LSL #16
    MOVK  X4, #0xff00, LSL #32
    MOVK  X4, #0xff00, LSL #48
    SUB  X7, X4, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D14
    MOVZ  X4, #0xff, LSL #0
    MOVK  X4, #0xff, LSL #16
    MOVK  X4, #0xff00, LSL #32
    MOVK  X4, #0xff00, LSL #48
    SUB  X7, X4, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D15
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x80, LSL #32
    SUB  X2, X7, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D17
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x80, LSL #32
    SUB  X2, X7, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xad00, LSL #16
    MOVK  X26, #0xad00, LSL #48
    SUB  X9, X26, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D19
    MOVZ  X26, #0xff45, LSL #0
    MOVK  X26, #0xff45, LSL #16
    MOVK  X26, #0xff45, LSL #32
    MOVK  X26, #0xff45, LSL #48
    SUB  X9, X26, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D22
    MOVZ  X17, #0x1, LSL #0
    SUB  X21, X17, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D26
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x48, LSL #32
    SUB  X23, X28, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D27
    MOVZ  X15, #0x202, LSL #0
    SUB  X5, X15, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D28
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
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
    FMOV  D0, X11
    FMOV  V0.D[1], X16
    FMOV  D1, X13
    FMOV  V1.D[1], X27
    FMOV  D2, X20
    FMOV  V2.D[1], X15
    FMOV  D3, X14
    FMOV  V3.D[1], X4
    FMOV  D4, X26
    FMOV  V4.D[1], X13
    FMOV  D5, X11
    FMOV  V5.D[1], X16
    FMOV  D6, X23
    FMOV  V6.D[1], X8
    FMOV  D7, X19
    FMOV  V7.D[1], X22
    FMOV  D8, X15
    FMOV  V8.D[1], X6
    FMOV  D9, X15
    FMOV  V9.D[1], X20
    FMOV  D10, X9
    FMOV  V10.D[1], X15
    FMOV  D11, X24
    FMOV  V11.D[1], X4
    FMOV  D12, X4
    FMOV  V12.D[1], X6
    FMOV  D13, X24
    FMOV  V13.D[1], X19
    FMOV  D14, X11
    FMOV  V14.D[1], X26
    FMOV  D15, X10
    FMOV  V15.D[1], X18
    FMOV  D16, X15
    FMOV  V16.D[1], X12
    FMOV  D17, X10
    FMOV  V17.D[1], X23
    FMOV  D18, X12
    FMOV  V18.D[1], X28
    FMOV  D19, X20
    FMOV  V19.D[1], X18
    FMOV  D20, X9
    FMOV  V20.D[1], X18
    FMOV  D21, X6
    FMOV  V21.D[1], X24
    FMOV  D22, X2
    FMOV  V22.D[1], X25
    FMOV  D23, X22
    FMOV  V23.D[1], X25
    FMOV  D24, X2
    FMOV  V24.D[1], X12
    FMOV  D25, X11
    FMOV  V25.D[1], X3
    FMOV  D26, X22
    FMOV  V26.D[1], X9
    FMOV  D27, X3
    FMOV  V27.D[1], X3
    FMOV  D28, X13
    FMOV  V28.D[1], X25
    FMOV  D29, X18
    FMOV  V29.D[1], X19
    FMOV  D30, X24
    FMOV  V30.D[1], X26
    FMOV  D31, X3
    FMOV  V31.D[1], X3
    MOVZ  X22, #0xf, LSL #0
TaishanSimdAritheticP01_label_166:
    UQRSHRN V0.2S, V10.2D, #2
    SQSHRUN V23.8B, V17.8H, #7
    UQRSHRN2 V28.4S, V14.2D, #1
    MOVI  V29.2S, #0xb4
    USRA  V22.4H, V5.4H, #13
    SQSHL H0, H31, #0x9
    SLI  V3.8H, V5.8H, #0x4
    MVNI  V17.4H, #0x6, LSL #8
    SRSHR V18.2D, V29.2D, #41
    SQSHRUN V16.2S, V30.2D, #29
    SQSHLU S15, S19, #0x5
    MOVI  V24.16B, #0x2a
    UQSHL  V3.8B, V23.8B, #0x3
    URSHR D0, D3, #17
    SSRA  V28.4H, V24.4H, #13
    SQSHL D18, D7, #0x30
    USHR  V22.4H, V26.4H, #6
    UQSHRN S6, D10, #15
    SQSHL D10, D22, #0x2
    SHL D13, D7, #0x11
    UQSHL  S0, S30, S10
    SQSHLU V18.2D, V26.2D, #0x39
    SQSHRN V15.2S, V27.2D, #2
    UQSHRN S18, D29, #13
    UQSHRN S7, D6, #31
    UQSHL H30, H27, #0xc
    UQRSHRN V23.8B, V0.8H, #5
    RSHRN2 V1.8H, V1.4S, #11
    SQSHLU H0, H7, #0xd
    UQRSHRN V12.8B, V2.8H, #5
    SSHR D18, D17, #30
    UQSHRN2 V24.16B, V1.8H, #6
    MOVI  V3.8H, #0xd0
    SQSHL  V31.8B, V18.8B, #0x1
    UQRSHRN H24, S1, #3
    UQSHL  V21.8B, V19.8B, #0x6
    SQSHRUN V20.4H, V21.4S, #12
    SQSHRN S3, D10, #3
    SQRSHRN2 V8.4S, V7.2D, #20
    SQSHLU V12.2D, V17.2D, #0xd
    ORR  V25.2S, #0x3d
    SRI  V10.2S, V27.2S, #31
    SQRSHRUN B23, H29, #4
    UQSHL  V29.16B, V9.16B, #0x5
    MOVI  V24.2D, #18374966855136706560
    SQSHRN V14.8B, V6.8H, #1
    USHR D12, D9, #18
    SRSRA  V8.8H, V15.8H, #13
    SQSHRUN2 V22.16B, V4.8H, #7
    SQRSHRUN B19, H8, #4
    SLI  V0.8H, V27.8H, #0xe
    SRSRA V19.2D, V29.2D, #6
    SSRA  V5.2S, V31.2S, #6
    UQSHL V29.2D, V2.2D, #0x36
    SQRSHRUN2 V10.8H, V25.4S, #5
    USHLL2 V1.4S, V30.8H, #0xd
    RSHRN2 V24.8H, V27.4S, #6
    SRI  V20.16B, V12.16B, #6
    UQSHL  D11, D12, D3
    USRA  V15.16B, V17.16B, #3
    UQSHL  V23.4H, V9.4H, #0x0
    UQSHRN2 V10.8H, V17.4S, #5
    SQSHRUN V6.4H, V9.4S, #13
    SRSRA  V10.4H, V15.4H, #8
    SQSHRUN V12.8B, V22.8H, #4
    SHL  V31.8B, V13.8B, #0x4
    URSHR  V31.8H, V17.8H, #16
    MOVI  D0, #4278190080
    SQRSHRUN S19, D27, #4
    SSRA  V9.4S, V15.4S, #14
    UQRSHRN2 V18.8H, V6.4S, #7
    SHLL2  V3.4S, V22.8H, #16
    SQSHRUN B4, H3, #8
    USHLL V7.4S, V24.4H, #0x4
    USHR  V26.8H, V6.8H, #2
    SQSHLU H11, H2, #0xa
    UQSHRN2 V23.16B, V10.8H, #8
    SRSRA  V24.8H, V0.8H, #11
    SQSHL S29, S26, #0xf
    SQRSHRN H7, S24, #14
    SLI D12, D3, #0xb
    SQSHRUN B7, H30, #5
    SQSHRN2 V19.8H, V27.4S, #6
    USRA V21.2D, V26.2D, #9
    UQRSHRN2 V2.16B, V2.8H, #8
    UQRSHRN2 V22.16B, V17.8H, #6
    SQSHL  V5.16B, V20.16B, #0x7
    SQSHL B15, B24, #0x1
    UQRSHRN2 V18.8H, V9.4S, #7
    USHR  V25.4H, V20.4H, #16
    SQSHRUN S29, D31, #3
    SQRSHRUN2 V24.16B, V13.8H, #5
    SRSHR V13.2D, V23.2D, #30
    SRSHR V29.2D, V20.2D, #11
    SSHLL2 V29.2D, V11.4S, #0xc
    SQRSHRUN B4, H25, #3
    SQSHRUN2 V23.4S, V9.2D, #9
    UQRSHRN H17, S27, #12
    SHRN V0.2S, V20.2D, #1
    SHRN V18.8B, V20.8H, #3
    SQSHRUN2 V30.16B, V3.8H, #4
    SQSHLU  V13.8H, V19.8H, #0x7
    UQSHRN V11.8B, V21.8H, #7
    SHRN2 V29.8H, V23.4S, #16
    MOVI  V24.8H, #0x4e, LSL #8
    SRSRA D6, D16, #11
    URSHR  V23.8B, V6.8B, #8
    USHR  V15.4H, V28.4H, #3
    UQRSHRN2 V17.16B, V23.8H, #8
    SQSHRUN V20.8B, V0.8H, #3
    SQSHL D11, D25, #0x1e
    SHL  V19.8H, V13.8H, #0x3
    MOVI  D16, #18446463698227757055
    MOVI  V6.4H, #0xb9
    SRI D3, D20, #6
    SSHR D13, D31, #11
    SSHR  V13.4S, V21.4S, #9
    SSHLL V23.8H, V22.8B, #0x3
    SLI V18.2D, V9.2D, #0x22
    USHR  V27.4S, V17.4S, #26
    SQRSHRN S21, D3, #2
    SLI  V26.16B, V5.16B, #0x2
    MOVI  V2.4H, #0x44, LSL #8
    SQSHRUN2 V26.8H, V21.4S, #2
    SQSHLU H27, H3, #0xe
    SRSHR  V20.8B, V19.8B, #5
    UQSHL  B21, B16, B7
    SQSHRN B2, H6, #8
    URSHR V28.2D, V28.2D, #26
    ORR  V21.4H, #0x58, LSL #8
    UQSHL S9, S28, #0x15
    UQSHL  S25, S4, S5
    SLI  V31.16B, V15.16B, #0x4
    UQSHL V9.2D, V15.2D, #0x20
    SHRN2 V25.4S, V7.2D, #7
    SQRSHRN2 V0.16B, V5.8H, #5
    SQSHRUN2 V2.8H, V28.4S, #14
    UQSHRN2 V13.16B, V4.8H, #3
    SQRSHRN V3.2S, V17.2D, #24
    UQSHL  V3.8B, V25.8B, #0x0
    SLI  V11.2S, V1.2S, #0x7
    SSHR D18, D30, #15
    UQSHL  V6.16B, V30.16B, #0x5
    USHLL2 V9.4S, V3.8H, #0xe
    SQSHRUN2 V11.4S, V13.2D, #5
    SQSHRUN2 V3.4S, V9.2D, #1
    URSHR  V16.16B, V1.16B, #6
    SQSHRN2 V20.8H, V20.4S, #3
    UQRSHRN V5.8B, V3.8H, #2
    SRSRA  V1.4S, V16.4S, #26
    UQSHL H30, H31, #0xa
    BIC  V27.2S, #0x93, LSL #8
    SSRA V29.2D, V5.2D, #4
    SQSHRUN2 V7.16B, V26.8H, #4
    SQSHRN V23.2S, V3.2D, #9
    USHLL2 V13.8H, V11.16B, #0x1
    USHR  V13.4H, V31.4H, #15
    UQSHL D20, D20, #0xf
    SQSHLU  V24.4H, V23.4H, #0x8
    SSHLL2 V24.2D, V15.4S, #0xf
    URSRA  V19.4H, V4.4H, #8
    SQRSHRN V17.2S, V10.2D, #23
    UQSHL  V23.2S, V27.2S, #0xb
    USRA  V9.2S, V11.2S, #23
    UQSHRN V1.8B, V12.8H, #8
    UQSHL  V8.2S, V20.2S, V7.2S
    SSRA V26.2D, V10.2D, #60
    SRI V26.2D, V12.2D, #42
    SQSHRN V5.8B, V29.8H, #4
    SSHLL V3.8H, V15.8B, #0x7
    SLI  V26.4H, V14.4H, #0x7
    USHLL2 V9.2D, V19.4S, #0x10
    SQSHLU D0, D10, #0x7
    SRSHR V24.2D, V14.2D, #11
    UQRSHRN2 V31.4S, V12.2D, #27
    SQSHRN B26, H11, #8
    UQSHRN V13.2S, V4.2D, #2
    SSHLL2 V27.2D, V29.4S, #0x19
    SHRN V27.2S, V7.2D, #2
    SQSHL  V30.2S, V20.2S, #0x10
    SQSHLU  V9.2S, V2.2S, #0x0
    USHLL2 V24.4S, V18.8H, #0x2
    FMOV  V15.4S, #0.87500000
    SSRA  V18.8H, V8.8H, #7
    URSRA V13.2D, V13.2D, #17
    SSHR  V5.8H, V27.8H, #13
    RSHRN V3.2S, V20.2D, #16
    UQRSHRN V29.8B, V20.8H, #7
    SRSHR D23, D1, #62
    USHLL2 V25.8H, V29.16B, #0x1
    SSHLL2 V22.8H, V1.16B, #0x4
    SQRSHRN V29.4H, V3.4S, #16
    SQSHRN2 V7.4S, V2.2D, #1
    ORR  V7.8H, #0x52
    URSRA  V13.4H, V31.4H, #7
    SQSHRUN2 V0.16B, V20.8H, #8
    SQSHRN V7.4H, V27.4S, #13
    SSHR  V20.4S, V23.4S, #25
    SRSHR  V13.16B, V5.16B, #1
    RSHRN2 V29.4S, V8.2D, #4
    SUBS  X22, X22, #0x1
    B.NE  TaishanSimdAritheticP01_label_166
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X15, X14, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X10, X3, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X17, X18, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X9, X5, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X8, X3, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X6, X27, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X5, X7, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X11, X16, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X25, X2, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X27, X18, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X27, #0x100, LSL #0
    SUB  X12, X27, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D5
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D9
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D10
    MOVZ  X5, #0x1f, LSL #0
    MOVK  X5, #0x1f, LSL #16
    MOVK  X5, #0x1f, LSL #32
    MOVK  X5, #0x1f, LSL #48
    SUB  X23, X5, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D14
    MOVZ  X19, #0xffff, LSL #0
    SUB  X26, X19, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x3f60, LSL #16
    MOVK  X27, #0x3f60, LSL #48
    SUB  X17, X27, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D15
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x3f60, LSL #16
    MOVK  X27, #0x3f60, LSL #48
    SUB  X17, X27, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D16
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D17
    MOVZ  X19, #0x3e00, LSL #0
    MOVK  X19, #0x3e00, LSL #16
    SUB  X3, X19, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D21
    MOVZ  X5, #0x58ff, LSL #0
    MOVK  X5, #0x5800, LSL #16
    MOVK  X5, #0x5800, LSL #32
    MOVK  X5, #0x5800, LSL #48
    SUB  X26, X5, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D23
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D24
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D28
    MOVZ  X16, #0x40, LSL #0
    MOVK  X16, #0x40, LSL #16
    SUB  X17, X16, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x2aca, LSL #0
    MOVK  X2, #0xbecb, LSL #16
    MOVK  X2, #0x5f6, LSL #32
    MOVK  X2, #0x9933, LSL #48
    MOVZ  X3, #0xefb2, LSL #0
    MOVK  X3, #0x475c, LSL #16
    MOVK  X3, #0x8825, LSL #32
    MOVK  X3, #0xd113, LSL #48
    MOVZ  X4, #0x9e72, LSL #0
    MOVK  X4, #0xf340, LSL #16
    MOVK  X4, #0xbe92, LSL #32
    MOVK  X4, #0x70b5, LSL #48
    MOVZ  X5, #0x383, LSL #0
    MOVK  X5, #0x5b97, LSL #16
    MOVK  X5, #0xcdac, LSL #32
    MOVK  X5, #0xf441, LSL #48
    MOVZ  X6, #0x3553, LSL #0
    MOVK  X6, #0xf96e, LSL #16
    MOVK  X6, #0x4ae1, LSL #32
    MOVK  X6, #0xec5, LSL #48
    MOVZ  X7, #0x4a19, LSL #0
    MOVK  X7, #0x2a86, LSL #16
    MOVK  X7, #0xb939, LSL #32
    MOVK  X7, #0xb82d, LSL #48
    MOVZ  X8, #0x67db, LSL #0
    MOVK  X8, #0x78bd, LSL #16
    MOVK  X8, #0xe7ce, LSL #32
    MOVK  X8, #0xf5cf, LSL #48
    MOVZ  X9, #0x4225, LSL #0
    MOVK  X9, #0xcd6e, LSL #16
    MOVK  X9, #0xa7ac, LSL #32
    MOVK  X9, #0x6eef, LSL #48
    MOVZ  X10, #0xa6ee, LSL #0
    MOVK  X10, #0xe748, LSL #16
    MOVK  X10, #0xc40, LSL #32
    MOVK  X10, #0x9f5e, LSL #48
    MOVZ  X11, #0x3626, LSL #0
    MOVK  X11, #0xd299, LSL #16
    MOVK  X11, #0xb312, LSL #32
    MOVK  X11, #0x87a6, LSL #48
    MOVZ  X12, #0x4b86, LSL #0
    MOVK  X12, #0xe79f, LSL #16
    MOVK  X12, #0x8267, LSL #32
    MOVK  X12, #0x25d3, LSL #48
    MOVZ  X13, #0x842f, LSL #0
    MOVK  X13, #0x997c, LSL #16
    MOVK  X13, #0x5026, LSL #32
    MOVK  X13, #0x1315, LSL #48
    MOVZ  X14, #0x3fcb, LSL #0
    MOVK  X14, #0x9b0d, LSL #16
    MOVK  X14, #0xedb7, LSL #32
    MOVK  X14, #0x5fb7, LSL #48
    MOVZ  X15, #0x3932, LSL #0
    MOVK  X15, #0xe32, LSL #16
    MOVK  X15, #0x4f0b, LSL #32
    MOVK  X15, #0x1beb, LSL #48
    MOVZ  X16, #0x8f18, LSL #0
    MOVK  X16, #0xb634, LSL #16
    MOVK  X16, #0x2cd9, LSL #32
    MOVK  X16, #0x34a6, LSL #48
    MOVZ  X17, #0x609c, LSL #0
    MOVK  X17, #0xf7b1, LSL #16
    MOVK  X17, #0x6220, LSL #32
    MOVK  X17, #0x1b4c, LSL #48
    MOVZ  X18, #0xeb37, LSL #0
    MOVK  X18, #0x262a, LSL #16
    MOVK  X18, #0x4867, LSL #32
    MOVK  X18, #0x4dba, LSL #48
    MOVZ  X19, #0x6f3a, LSL #0
    MOVK  X19, #0x8550, LSL #16
    MOVK  X19, #0xd90b, LSL #32
    MOVK  X19, #0xccf1, LSL #48
    MOVZ  X20, #0x8e45, LSL #0
    MOVK  X20, #0xd4a2, LSL #16
    MOVK  X20, #0x16e3, LSL #32
    MOVK  X20, #0x1493, LSL #48
    MOVZ  X21, #0xff2b, LSL #0
    MOVK  X21, #0x2ffe, LSL #16
    MOVK  X21, #0x1b8a, LSL #32
    MOVK  X21, #0xe92b, LSL #48
    MOVZ  X22, #0x5b42, LSL #0
    MOVK  X22, #0xac09, LSL #16
    MOVK  X22, #0x73a1, LSL #32
    MOVK  X22, #0xbf1c, LSL #48
    MOVZ  X23, #0x94f5, LSL #0
    MOVK  X23, #0x7542, LSL #16
    MOVK  X23, #0xa26c, LSL #32
    MOVK  X23, #0x5098, LSL #48
    MOVZ  X24, #0x1c54, LSL #0
    MOVK  X24, #0xe4, LSL #16
    MOVK  X24, #0x17ac, LSL #32
    MOVK  X24, #0x1738, LSL #48
    MOVZ  X25, #0xd3f7, LSL #0
    MOVK  X25, #0x2d3a, LSL #16
    MOVK  X25, #0xa49b, LSL #32
    MOVK  X25, #0x44bc, LSL #48
    MOVZ  X26, #0xb36a, LSL #0
    MOVK  X26, #0x12da, LSL #16
    MOVK  X26, #0x30f2, LSL #32
    MOVK  X26, #0x747a, LSL #48
    MOVZ  X27, #0x8d07, LSL #0
    MOVK  X27, #0x7ff2, LSL #16
    MOVK  X27, #0xb0, LSL #32
    MOVK  X27, #0xb715, LSL #48
    MOVZ  X28, #0xfd1c, LSL #0
    MOVK  X28, #0x9a62, LSL #16
    MOVK  X28, #0x95b5, LSL #32
    MOVK  X28, #0xf94, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X25
    FMOV  D1, X11
    FMOV  V1.D[1], X13
    FMOV  D2, X14
    FMOV  V2.D[1], X28
    FMOV  D3, X20
    FMOV  V3.D[1], X9
    FMOV  D4, X26
    FMOV  V4.D[1], X19
    FMOV  D5, X13
    FMOV  V5.D[1], X27
    FMOV  D6, X5
    FMOV  V6.D[1], X18
    FMOV  D7, X23
    FMOV  V7.D[1], X9
    FMOV  D8, X7
    FMOV  V8.D[1], X17
    FMOV  D9, X6
    FMOV  V9.D[1], X25
    FMOV  D10, X6
    FMOV  V10.D[1], X23
    FMOV  D11, X5
    FMOV  V11.D[1], X4
    FMOV  D12, X16
    FMOV  V12.D[1], X9
    FMOV  D13, X7
    FMOV  V13.D[1], X10
    FMOV  D14, X10
    FMOV  V14.D[1], X18
    FMOV  D15, X26
    FMOV  V15.D[1], X7
    FMOV  D16, X18
    FMOV  V16.D[1], X22
    FMOV  D17, X17
    FMOV  V17.D[1], X4
    FMOV  D18, X6
    FMOV  V18.D[1], X19
    FMOV  D19, X26
    FMOV  V19.D[1], X25
    FMOV  D20, X10
    FMOV  V20.D[1], X5
    FMOV  D21, X25
    FMOV  V21.D[1], X23
    FMOV  D22, X20
    FMOV  V22.D[1], X7
    FMOV  D23, X24
    FMOV  V23.D[1], X11
    FMOV  D24, X12
    FMOV  V24.D[1], X14
    FMOV  D25, X6
    FMOV  V25.D[1], X22
    FMOV  D26, X4
    FMOV  V26.D[1], X21
    FMOV  D27, X15
    FMOV  V27.D[1], X2
    FMOV  D28, X8
    FMOV  V28.D[1], X5
    FMOV  D29, X11
    FMOV  V29.D[1], X21
    FMOV  D30, X21
    FMOV  V30.D[1], X25
    FMOV  D31, X21
    FMOV  V31.D[1], X5
    MOVZ  X9, #0xa, LSL #0
TaishanSimdAritheticP01_label_249:
    SSRA D22, D10, #35
    UQRSHRN2 V21.4S, V20.2D, #25
    MVNI  V24.4S, #0xa5, MSL #8
    SSRA  V16.8H, V27.8H, #5
    SSRA D10, D15, #27
    SRI  V15.8B, V15.8B, #6
    MVNI  V23.2S, #0x18, LSL #24
    MVNI  V28.4S, #0xa4, MSL #16
    SRI  V28.8H, V22.8H, #2
    SQSHLU S26, S30, #0x16
    URSRA D6, D26, #9
    URSHR V6.2D, V1.2D, #32
    SHL  V23.8H, V29.8H, #0x9
    SHLL2  V8.8H, V27.16B, #8
    SQRSHRUN2 V21.4S, V27.2D, #12
    SQRSHRUN2 V16.16B, V14.8H, #7
    SQSHL  V19.4H, V16.4H, #0xb
    URSRA V9.2D, V22.2D, #14
    UQRSHRN V4.2S, V28.2D, #23
    SRSHR  V4.16B, V21.16B, #2
    USRA D11, D12, #14
    SQRSHRN2 V31.8H, V6.4S, #3
    SSRA  V26.2S, V26.2S, #31
    SHL V15.2D, V13.2D, #0xe
    SLI  V4.8B, V7.8B, #0x6
    SRI  V29.16B, V18.16B, #8
    SQSHLU  V27.4S, V7.4S, #0x18
    URSHR V18.2D, V15.2D, #21
    UQSHL  V7.4S, V5.4S, #0x15
    SQSHRUN V12.4H, V22.4S, #15
    SQSHRUN V13.4H, V7.4S, #10
    URSRA  V9.4S, V13.4S, #3
    SHRN2 V21.4S, V3.2D, #32
    UQSHL  S27, S9, S19
    FMOV  V18.4S, #1.37500000
    USHLL2 V0.4S, V30.8H, #0xd
    SHRN V3.2S, V21.2D, #11
    SHL D12, D9, #0x37
    SQRSHRUN H26, S0, #7
    UQSHL S2, S29, #0x5
    SRSHR  V6.8H, V24.8H, #10
    URSRA  V27.8B, V4.8B, #1
    SQSHL  V25.8B, V25.8B, #0x3
    RSHRN V10.2S, V21.2D, #10
    SQRSHRUN V4.2S, V25.2D, #25
    SQRSHRUN S2, D21, #5
    SRSHR  V15.8H, V22.8H, #5
    USRA D9, D2, #63
    SQRSHRUN2 V17.16B, V24.8H, #7
    SSRA  V12.4H, V13.4H, #9
    SRI V5.2D, V0.2D, #6
    SQRSHRN2 V29.8H, V12.4S, #15
    UQRSHRN B19, H3, #1
    SQRSHRN2 V18.8H, V3.4S, #16
    SQRSHRN2 V20.8H, V6.4S, #6
    URSHR  V25.8B, V5.8B, #3
    ORR  V22.4H, #0xa5
    URSHR  V20.8B, V3.8B, #7
    USHLL2 V20.4S, V29.8H, #0x1
    MOVI  D29, #71777218572779775
    SSHR D18, D9, #2
    SRSRA V14.2D, V23.2D, #60
    SHRN V10.4H, V19.4S, #10
    UQSHL B31, B20, #0x0
    SQSHL V31.2D, V5.2D, #0x6
    SHL  V0.8H, V28.8H, #0x5
    SHRN2 V24.16B, V25.8H, #7
    UQSHL  V28.8B, V15.8B, #0x7
    SQRSHRUN B21, H27, #8
    SSHLL V9.2D, V10.2S, #0x12
    SQSHL S2, S10, #0x13
    SQRSHRN V27.2S, V0.2D, #26
    URSRA V13.2D, V19.2D, #13
    SQSHRUN S22, D3, #1
    SQRSHRN H10, S25, #7
    MVNI  V29.4S, #0x59, LSL #24
    SHRN2 V19.4S, V26.2D, #24
    SHL D29, D14, #0x0
    SQRSHRUN2 V15.4S, V30.2D, #21
    UQRSHRN2 V21.4S, V3.2D, #27
    SQSHL  V24.2S, V15.2S, #0x0
    SRSHR  V21.8H, V0.8H, #10
    URSRA D30, D11, #64
    SRSHR V28.2D, V31.2D, #56
    SQSHRUN V20.8B, V12.8H, #7
    SSHLL2 V27.4S, V23.8H, #0x8
    SQSHLU V7.2D, V20.2D, #0x2
    SQSHRUN V5.8B, V3.8H, #5
    SRSRA  V7.4S, V25.4S, #29
    SRSRA D25, D28, #29
    SQSHL V23.2D, V18.2D, #0x30
    SSHLL V18.4S, V16.4H, #0x8
    MOVI  V17.8B, #0x88
    SQSHRN2 V9.16B, V16.8H, #2
    SHRN2 V26.8H, V31.4S, #1
    RSHRN V7.4H, V13.4S, #16
    UQSHL H9, H29, #0x2
    UQSHL  V14.4S, V17.4S, #0x9
    SSHLL2 V23.2D, V20.4S, #0x15
    SQRSHRUN V11.4H, V31.4S, #7
    SLI V22.2D, V4.2D, #0x3
    UQSHL V18.2D, V15.2D, #0x1b
    SQSHRUN S22, D28, #22
    USHLL2 V18.8H, V23.16B, #0x6
    USRA  V20.4S, V25.4S, #7
    SQSHLU V9.2D, V4.2D, #0x11
    SQSHL V20.2D, V14.2D, #0x29
    USRA  V31.16B, V28.16B, #8
    USRA D12, D15, #9
    SRI  V30.4H, V9.4H, #9
    UQSHL  V28.8B, V30.8B, #0x6
    SSHLL V11.8H, V26.8B, #0x1
    UQRSHRN H9, S29, #16
    SQSHRN V27.4H, V3.4S, #11
    UQSHL  H17, H7, H3
    UQSHL  B8, B9, B12
    SQSHLU H31, H14, #0x4
    SSHR  V5.16B, V15.16B, #1
    USHR V4.2D, V14.2D, #16
    SQRSHRN B30, H7, #4
    SRSRA V21.2D, V5.2D, #30
    USHR  V12.8H, V18.8H, #12
    BIC  V28.4S, #0xa0, LSL #24
    SQRSHRN2 V27.8H, V11.4S, #2
    SQSHRUN2 V0.16B, V14.8H, #7
    SQSHL  V21.4S, V31.4S, #0x13
    UQRSHRN H2, S5, #9
    USHR V9.2D, V13.2D, #38
    SSRA  V13.4H, V26.4H, #8
    SHRN2 V12.16B, V9.8H, #3
    SQSHLU D30, D11, #0x3d
    SRSRA  V29.8H, V12.8H, #4
    SQSHL B11, B12, #0x3
    USRA  V28.2S, V5.2S, #15
    SQSHRN S25, D4, #14
    SQSHRUN V26.2S, V18.2D, #3
    SQRSHRUN V3.8B, V16.8H, #8
    BIC  V25.4S, #0x2
    SQSHLU B8, B10, #0x7
    MOVI  V19.2S, #0xcc, LSL #16
    SRI  V22.8H, V18.8H, #14
    USRA D0, D9, #44
    MVNI  V10.4S, #0xb5, MSL #16
    SRI V9.2D, V17.2D, #18
    SQSHRN2 V9.4S, V15.2D, #15
    UQRSHRN2 V10.8H, V2.4S, #8
    USHLL V3.4S, V31.4H, #0x8
    URSRA  V2.16B, V19.16B, #3
    USHR V9.2D, V14.2D, #28
    SRI  V26.4H, V14.4H, #15
    FMOV  V5.4S, #1.62500000
    SQRSHRUN B4, H14, #7
    RSHRN2 V1.4S, V11.2D, #14
    SSRA V15.2D, V18.2D, #5
    SQSHL B1, B13, #0x6
    SQSHL D11, D3, #0x1d
    SSHR D8, D8, #29
    SQSHRUN S1, D1, #28
    RSHRN2 V17.8H, V15.4S, #1
    URSHR V14.2D, V6.2D, #30
    SSHR  V6.2S, V26.2S, #22
    SRSRA D12, D16, #52
    SSRA  V31.8B, V18.8B, #6
    SSHR  V7.4H, V20.4H, #13
    SQSHRUN S14, D30, #30
    SQSHL  V13.16B, V30.16B, #0x0
    SQSHLU B12, B8, #0x3
    MOVI  V11.4H, #0xf2
    USHR  V30.4H, V31.4H, #11
    SQSHRN V29.2S, V1.2D, #28
    SHL D21, D15, #0x3e
    UQSHRN V20.4H, V17.4S, #5
    UQRSHRN V21.4H, V7.4S, #13
    SSRA  V26.4S, V8.4S, #20
    FMOV  V29.2D, #-0.18750000
    SQRSHRUN H25, S23, #16
    SRSHR V1.2D, V6.2D, #45
    SHLL  V1.2D, V29.2S, #32
    RSHRN V21.8B, V23.8H, #5
    SQSHRUN2 V20.4S, V0.2D, #32
    UQSHRN2 V7.16B, V6.8H, #6
    MOVI  V7.8H, #0x7d, LSL #8
    RSHRN V23.4H, V23.4S, #15
    BIC  V3.4S, #0x29
    ORR  V13.8H, #0x70, LSL #8
    MOVI  V0.2S, #0xff, MSL #16
    SQRSHRUN S6, D8, #26
    UQSHRN2 V16.4S, V12.2D, #29
    SQSHRUN V3.2S, V30.2D, #31
    SRI  V30.16B, V12.16B, #2
    SRI D31, D24, #12
    SQSHLU  V15.8H, V20.8H, #0xe
    SLI  V21.8B, V6.8B, #0x0
    SHRN2 V9.4S, V19.2D, #24
    UQRSHRN B1, H8, #4
    USHR  V24.16B, V2.16B, #4
    SQSHRN V7.8B, V18.8H, #4
    RSHRN V23.2S, V17.2D, #12
    SRSRA D25, D10, #28
    SQSHRN V20.8B, V11.8H, #5
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdAritheticP01_label_249
    MOVZ  X28, #0x2aca, LSL #0
    MOVK  X28, #0xbecb, LSL #16
    MOVK  X28, #0x5f6, LSL #32
    MOVK  X28, #0x9933, LSL #48
    SUB  X12, X28, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0xefb2, LSL #0
    MOVK  X3, #0x475c, LSL #16
    MOVK  X3, #0x8825, LSL #32
    MOVK  X3, #0xd113, LSL #48
    SUB  X6, X3, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x9e72, LSL #0
    MOVK  X8, #0xf340, LSL #16
    MOVK  X8, #0xbe92, LSL #32
    MOVK  X8, #0x70b5, LSL #48
    SUB  X22, X8, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x383, LSL #0
    MOVK  X14, #0x5b97, LSL #16
    MOVK  X14, #0xcdac, LSL #32
    MOVK  X14, #0xf441, LSL #48
    SUB  X21, X14, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x4a19, LSL #0
    MOVK  X16, #0x2a86, LSL #16
    MOVK  X16, #0xb939, LSL #32
    MOVK  X16, #0xb82d, LSL #48
    SUB  X14, X16, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x9e72, LSL #0
    MOVK  X26, #0xf340, LSL #16
    MOVK  X26, #0xbe92, LSL #32
    MOVK  X26, #0x70b5, LSL #48
    SUB  X5, X26, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0xa6ee, LSL #0
    MOVK  X5, #0xe748, LSL #16
    MOVK  X5, #0xc40, LSL #32
    MOVK  X5, #0x9f5e, LSL #48
    SUB  X23, X5, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x3626, LSL #0
    MOVK  X11, #0xd299, LSL #16
    MOVK  X11, #0xb312, LSL #32
    MOVK  X11, #0x87a6, LSL #48
    SUB  X14, X11, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x842f, LSL #0
    MOVK  X15, #0x997c, LSL #16
    MOVK  X15, #0x5026, LSL #32
    MOVK  X15, #0x1315, LSL #48
    SUB  X27, X15, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x842f, LSL #0
    MOVK  X10, #0x997c, LSL #16
    MOVK  X10, #0x5026, LSL #32
    MOVK  X10, #0x1315, LSL #48
    SUB  X5, X10, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x4a19, LSL #0
    MOVK  X23, #0x2a86, LSL #16
    MOVK  X23, #0xb939, LSL #32
    MOVK  X23, #0xb82d, LSL #48
    SUB  X5, X23, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x609c, LSL #0
    MOVK  X14, #0xf7b1, LSL #16
    MOVK  X14, #0x6220, LSL #32
    MOVK  X14, #0x1b4c, LSL #48
    SUB  X8, X14, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0xeb37, LSL #0
    MOVK  X8, #0x262a, LSL #16
    MOVK  X8, #0x4867, LSL #32
    MOVK  X8, #0x4dba, LSL #48
    SUB  X12, X8, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x6f3a, LSL #0
    MOVK  X16, #0x8550, LSL #16
    MOVK  X16, #0xd90b, LSL #32
    MOVK  X16, #0xccf1, LSL #48
    SUB  X20, X16, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x4a19, LSL #0
    MOVK  X23, #0x2a86, LSL #16
    MOVK  X23, #0xb939, LSL #32
    MOVK  X23, #0xb82d, LSL #48
    SUB  X18, X23, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x9e72, LSL #0
    MOVK  X17, #0xf340, LSL #16
    MOVK  X17, #0xbe92, LSL #32
    MOVK  X17, #0x70b5, LSL #48
    SUB  X2, X17, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x2aca, LSL #0
    MOVK  X25, #0xbecb, LSL #16
    MOVK  X25, #0x5f6, LSL #32
    MOVK  X25, #0x9933, LSL #48
    SUB  X27, X25, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D2
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0x1a, LSL #16
    MOVK  X24, #0x1a, LSL #48
    SUB  X28, X24, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3fd0, LSL #16
    MOVK  X6, #0x3fd0, LSL #48
    SUB  X14, X6, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D5
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3fd0, LSL #16
    MOVK  X6, #0x3fd0, LSL #48
    SUB  X14, X6, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D8
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xcc00, LSL #16
    SUB  X6, X27, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D9
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xf, LSL #32
    SUB  X6, X27, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X16, #0x100, LSL #0
    SUB  X25, X16, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D10
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xff4a, LSL #16
    MOVK  X16, #0xff4a, LSL #48
    SUB  X25, X16, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D11
    MOVZ  X12, #0xf2, LSL #0
    MOVK  X12, #0xf2, LSL #16
    MOVK  X12, #0xf2, LSL #32
    MOVK  X12, #0xf2, LSL #48
    SUB  X28, X12, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X10, #0x7000, LSL #0
    MOVK  X10, #0x7000, LSL #16
    MOVK  X10, #0x7000, LSL #32
    MOVK  X10, #0x7000, LSL #48
    SUB  X12, X10, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D13
    MOVZ  X10, #0x7000, LSL #0
    MOVK  X10, #0x7000, LSL #16
    MOVK  X10, #0x7000, LSL #32
    MOVK  X10, #0x7000, LSL #48
    SUB  X12, X10, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D15
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xffff, LSL #32
    SUB  X26, X18, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D16
    MOVZ  X14, #0xe900, LSL #0
    MOVK  X14, #0x229b, LSL #16
    MOVK  X14, #0x4adf, LSL #32
    MOVK  X14, #0x4e99, LSL #48
    SUB  X11, X14, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X26, #0x8100, LSL #0
    SUB  X23, X26, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D18
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D19
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xcc, LSL #16
    MOVK  X28, #0xcc, LSL #48
    SUB  X3, X28, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D20
    MOVZ  X7, #0x707, LSL #0
    MOVK  X7, #0x707, LSL #16
    SUB  X28, X7, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D22
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D23
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8, LSL #32
    SUB  X20, X28, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D24
    MOVZ  X16, #0xf0f, LSL #0
    MOVK  X16, #0x1, LSL #16
    MOVK  X16, #0x1, LSL #48
    SUB  X19, X16, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D25
    MOVZ  X20, #0x10, LSL #0
    MOVK  X20, #0xf4a0, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
TaishanSimdAritheticP01_label_158:
    SUB  X28, X20, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D26
    MOVZ  X11, #0x1, LSL #0
    MOVK  X11, #0x1, LSL #16
    MOVK  X11, #0x1, LSL #32
    MOVK  X11, #0x1, LSL #48
    SUB  X9, X11, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D27
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D28
    MOVZ  X4, #0xfffe, LSL #0
    MOVK  X4, #0x1, LSL #16
    SUB  X21, X4, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X17
    FMOV  V0.D[1], X28
    FMOV  D1, X20
    FMOV  V1.D[1], X21
    FMOV  D2, X5
    FMOV  V2.D[1], X7
    FMOV  D3, X26
    FMOV  V3.D[1], X12
    FMOV  D4, X18
    FMOV  V4.D[1], X24
    FMOV  D5, X6
    FMOV  V5.D[1], X11
    FMOV  D6, X16
    FMOV  V6.D[1], X16
    FMOV  D7, X25
    FMOV  V7.D[1], X7
    FMOV  D8, X5
    FMOV  V8.D[1], X27
    FMOV  D9, X27
    FMOV  V9.D[1], X11
    FMOV  D10, X3
    FMOV  V10.D[1], X17
    FMOV  D11, X5
    FMOV  V11.D[1], X17
    FMOV  D12, X12
    FMOV  V12.D[1], X14
    FMOV  D13, X15
    FMOV  V13.D[1], X10
    FMOV  D14, X11
    FMOV  V14.D[1], X17
    FMOV  D15, X15
    FMOV  V15.D[1], X10
    FMOV  D16, X28
    FMOV  V16.D[1], X24
    FMOV  D17, X15
    FMOV  V17.D[1], X24
    FMOV  D18, X25
    FMOV  V18.D[1], X7
    FMOV  D19, X9
    FMOV  V19.D[1], X28
    FMOV  D20, X14
    FMOV  V20.D[1], X20
    FMOV  D21, X6
    FMOV  V21.D[1], X15
    FMOV  D22, X22
    FMOV  V22.D[1], X6
    FMOV  D23, X25
    FMOV  V23.D[1], X28
    FMOV  D24, X11
    FMOV  V24.D[1], X15
    FMOV  D25, X14
    FMOV  V25.D[1], X23
    FMOV  D26, X5
    FMOV  V26.D[1], X28
    FMOV  D27, X12
    FMOV  V27.D[1], X12
    FMOV  D28, X16
    FMOV  V28.D[1], X27
    FMOV  D29, X18
    FMOV  V29.D[1], X17
    FMOV  D30, X23
    FMOV  V30.D[1], X17
    FMOV  D31, X7
    FMOV  V31.D[1], X27
    MOVZ  X10, #0xa, LSL #0
TaishanSimdAritheticP01_label_332:
    SRI  V16.4H, V13.4H, #7
    SQSHL S21, S24, #0x5
    SRSRA D28, D26, #13
    UQRSHRN V13.8B, V25.8H, #1
    USHR V1.2D, V28.2D, #52
    USRA V11.2D, V7.2D, #24
    URSHR  V8.16B, V22.16B, #5
    USHR  V19.8B, V4.8B, #2
    SHRN2 V2.8H, V2.4S, #10
    SQRSHRN V21.4H, V16.4S, #10
    ORR  V31.4S, #0x77, LSL #24
    SQSHRN S30, D16, #27
    SQSHLU V30.2D, V29.2D, #0xc
    UQRSHRN S16, D21, #12
    URSHR  V15.8B, V30.8B, #5
    SQSHRN V3.2S, V12.2D, #32
    SQSHLU B28, B21, #0x2
    SSHLL V9.4S, V22.4H, #0x8
    SQSHRN2 V21.4S, V1.2D, #13
    UQSHL  S22, S19, S5
    SQRSHRN H13, S18, #13
    USRA  V16.2S, V7.2S, #29
    UQRSHRN H30, S26, #12
    SQSHRUN V3.8B, V18.8H, #7
    SQSHL  V22.4H, V11.4H, #0x2
    UQSHL  V20.8B, V13.8B, #0x1
    USRA  V21.4H, V8.4H, #7
    SHL D5, D12, #0x2
    SQRSHRN V10.8B, V27.8H, #7
    SHRN V0.2S, V25.2D, #18
    SRSRA V25.2D, V13.2D, #9
    FMOV  V18.4S, #7.00000000
    SSRA  V26.16B, V30.16B, #6
    SHLL2  V23.8H, V13.16B, #8
    MOVI  V0.2D, #72057589743026175
    SQRSHRUN S5, D25, #6
    SHL  V25.4S, V30.4S, #0x14
    MOVI  V24.16B, #0xac
    URSRA D9, D18, #52
    SLI  V0.4H, V19.4H, #0x4
    UQRSHRN2 V1.8H, V28.4S, #5
    UQSHL  H20, H3, H5
    SSRA  V22.4S, V2.4S, #26
    UQSHL  B7, B26, B3
    RSHRN2 V14.4S, V21.2D, #9
    SQSHLU D10, D27, #0x13
    SRSHR  V0.4H, V19.4H, #2
    UQRSHRN H25, S1, #7
    SSHR  V13.8H, V25.8H, #8
    URSRA D5, D30, #44
    MOVI  V12.4H, #0xc8
    MVNI  V20.4H, #0x9, LSL #8
    SQSHL  V23.4H, V30.4H, #0x7
    SQSHL D25, D12, #0x27
    SHRN2 V4.8H, V16.4S, #15
    URSHR V28.2D, V30.2D, #62
    SQSHLU B23, B24, #0x7
    SSHR  V19.2S, V18.2S, #16
    USRA  V10.4H, V27.4H, #14
    URSRA  V10.8B, V29.8B, #5
    SQRSHRUN H20, S14, #1
    SSHR D19, D18, #48
    SQRSHRUN H24, S6, #11
    SQSHRUN V21.4H, V17.4S, #14
    SQRSHRN S20, D21, #30
    SLI  V15.2S, V23.2S, #0x5
    UQSHRN2 V30.16B, V13.8H, #4
    URSHR  V18.16B, V12.16B, #3
    UQSHRN V3.8B, V12.8H, #2
    SRSRA D18, D11, #7
    SQSHRN S0, D9, #13
    SRSRA  V17.4S, V0.4S, #15
    SSRA  V19.2S, V29.2S, #28
    UQRSHRN V16.2S, V29.2D, #26
    SQRSHRN V14.4H, V4.4S, #2
    MVNI  V4.4H, #0xc5, LSL #8
    SQSHRN S20, D9, #27
    SRSHR  V14.2S, V23.2S, #7
    SQSHLU S27, S2, #0x16
    SLI  V25.8H, V26.8H, #0x7
    SHRN V31.2S, V4.2D, #23
    SSRA  V3.4S, V20.4S, #6
    SQSHL  V15.16B, V15.16B, #0x4
    USHR D30, D0, #24
    USHLL2 V9.8H, V9.16B, #0x2
    UQSHRN V4.8B, V26.8H, #3
    SQRSHRUN2 V11.16B, V22.8H, #2
    USHLL2 V13.8H, V11.16B, #0x5
    UQRSHRN S29, D13, #20
    SSRA D0, D7, #33
    SQSHRUN V9.8B, V0.8H, #4
    SQSHRN H16, S11, #12
    SQSHLU V24.2D, V22.2D, #0x1f
    URSHR V12.2D, V6.2D, #43
    SHRN V4.8B, V13.8H, #6
    SQRSHRN2 V6.16B, V17.8H, #2
    SQSHRN2 V12.16B, V19.8H, #4
    SHL  V22.2S, V6.2S, #0x16
    SQRSHRUN S20, D3, #3
    SQSHLU D30, D15, #0x33
    UQSHL S24, S9, #0x18
    SQRSHRUN V6.8B, V15.8H, #5
    SSRA D2, D15, #14
    SHRN V13.8B, V29.8H, #1
    UQSHL V12.2D, V21.2D, #0x38
    SQSHRUN S16, D9, #11
    URSHR D9, D28, #19
    SQSHLU B27, B29, #0x1
    ORR  V26.2S, #0x7a
    SQSHLU H17, H9, #0x3
    SLI  V9.8H, V14.8H, #0xe
    SQSHRUN V19.8B, V9.8H, #5
    SQSHLU S9, S17, #0x13
    SQRSHRUN H20, S5, #9
    UQSHL  S27, S31, S26
    URSHR  V20.16B, V5.16B, #7
    SLI  V25.8B, V7.8B, #0x2
    SQSHLU B7, B29, #0x2
    URSRA D16, D18, #63
    SRSRA V15.2D, V13.2D, #39
    SRI  V18.4H, V3.4H, #12
    SQSHLU H9, H12, #0x1
    SLI  V19.16B, V16.16B, #0x0
    SHRN2 V15.4S, V12.2D, #7
    SQSHLU  V10.2S, V29.2S, #0x17
    MVNI  V2.2S, #0xdc, LSL #8
    UQRSHRN2 V11.16B, V0.8H, #6
    USRA  V31.4S, V11.4S, #24
    UQRSHRN2 V14.4S, V6.2D, #12
    SSRA  V10.8B, V28.8B, #3
    ORR  V16.8H, #0x7f
    SHLL2  V20.8H, V15.16B, #8
    UQRSHRN S30, D0, #12
    UQSHL  D5, D20, D7
    SRSHR  V0.8B, V11.8B, #2
    SQSHRN2 V15.8H, V28.4S, #3
    SRSRA  V29.4H, V1.4H, #4
    USHLL V12.2D, V3.2S, #0x18
    SQRSHRUN H13, S14, #4
    SQRSHRN B12, H27, #4
    RSHRN2 V12.16B, V4.8H, #3
    UQSHL H13, H20, #0xe
    UQSHL  V28.2S, V24.2S, #0x1e
    UQSHL H2, H1, #0xc
    SQSHL B23, B15, #0x1
    SQSHRN V24.8B, V19.8H, #4
    UQSHL  S26, S25, S29
    SRI  V15.4H, V0.4H, #2
    SSRA  V8.4H, V18.4H, #9
    SHRN V3.4H, V21.4S, #4
    SSHR V5.2D, V1.2D, #26
    UQSHL S12, S20, #0x0
    SQRSHRUN H19, S12, #12
    UQSHRN S20, D28, #30
    SQRSHRN H27, S14, #10
    UQSHRN V18.4H, V10.4S, #1
    SQRSHRUN B6, H16, #6
    SSRA D24, D16, #16
    URSRA V27.2D, V4.2D, #14
    USHR V21.2D, V6.2D, #55
    USHR  V19.16B, V4.16B, #4
    URSRA  V2.4H, V1.4H, #2
    SSRA  V26.4H, V7.4H, #13
    SQSHRUN V27.8B, V7.8H, #7
    UQRSHRN2 V30.8H, V7.4S, #10
    SQSHLU S19, S15, #0x1e
    UQSHL  S7, S25, S25
    SHRN2 V12.16B, V13.8H, #3
    UQSHRN V24.2S, V24.2D, #28
    SQRSHRUN B29, H13, #1
    SSHR V0.2D, V28.2D, #5
    USHR D15, D0, #26
    USHLL2 V4.4S, V6.8H, #0x8
    RSHRN V1.8B, V23.8H, #8
    USHLL2 V30.8H, V0.16B, #0x6
    SQSHLU B4, B15, #0x5
    SHL V20.2D, V21.2D, #0x2
    SQSHRUN2 V23.16B, V23.8H, #7
    SQSHRUN S23, D16, #27
    UQSHL V15.2D, V27.2D, #0x37
    SQRSHRN S20, D26, #30
    SQRSHRN2 V1.4S, V27.2D, #14
    RSHRN2 V5.16B, V14.8H, #6
    UQRSHRN V17.4H, V6.4S, #1
    BIC  V3.4H, #0x7, LSL #8
    SQSHL  V6.8H, V30.8H, #0x3
    USHLL2 V13.8H, V15.16B, #0x4
    UQSHL  V23.4S, V4.4S, #0x0
    SQSHLU  V17.16B, V27.16B, #0x6
    SQSHL D24, D15, #0x13
    SHL D22, D3, #0x28
    SQSHRN V4.8B, V20.8H, #8
    UQSHL S15, S30, #0xf
    RSHRN2 V30.4S, V19.2D, #14
    RSHRN V17.8B, V12.8H, #1
    SHRN V30.4H, V3.4S, #15
    SLI  V1.2S, V29.2S, #0x9
    USHR  V18.4H, V24.4H, #15
    SQRSHRUN V30.4H, V2.4S, #4
    SQSHLU  V12.8H, V22.8H, #0x7
    SUBS  X10, X10, #0x1
    B.NE  TaishanSimdAritheticP01_label_332
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D4
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D5
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D6
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D7
    MOVZ  X11, #0x81ff, LSL #0
    MOVK  X11, #0x81, LSL #16
    SUB  X28, X11, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D11
    MOVZ  X16, #0x1fe, LSL #0
    SUB  X13, X16, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D15
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X21, #0x7f, LSL #0
    MOVK  X21, #0x7f, LSL #16
    MOVK  X21, #0x7f, LSL #32
    MOVK  X21, #0x7f, LSL #48
    SUB  X27, X21, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D16
    MOVZ  X21, #0x7f, LSL #0
    MOVK  X21, #0x7f, LSL #16
    MOVK  X21, #0x7f, LSL #32
    MOVK  X21, #0x7f, LSL #48
    SUB  X27, X21, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D17
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D24
    MOVZ  X26, #0x0, LSL #0
    SUB  X9, X26, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X15, X3, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D25
    MOVZ  X3, #0x3ff, LSL #0
    MOVK  X3, #0x103, LSL #16
    MOVK  X3, #0x3, LSL #32
    MOVK  X3, #0x3, LSL #48
    SUB  X15, X3, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D26
    MOVZ  X11, #0x3ff, LSL #0
    MOVK  X11, #0x103, LSL #16
    SUB  X5, X11, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D27
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
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
    FMOV  D0, X8
    FMOV  V0.D[1], X2
    FMOV  D1, X20
    FMOV  V1.D[1], X21
    FMOV  D2, X4
    FMOV  V2.D[1], X25
    FMOV  D3, X24
    FMOV  V3.D[1], X21
    FMOV  D4, X25
    FMOV  V4.D[1], X28
    FMOV  D5, X5
    FMOV  V5.D[1], X25
    FMOV  D6, X22
    FMOV  V6.D[1], X16
    FMOV  D7, X27
    FMOV  V7.D[1], X27
    FMOV  D8, X27
    FMOV  V8.D[1], X19
    FMOV  D9, X23
    FMOV  V9.D[1], X5
    FMOV  D10, X23
    FMOV  V10.D[1], X24
    FMOV  D11, X2
    FMOV  V11.D[1], X19
    FMOV  D12, X23
    FMOV  V12.D[1], X20
    FMOV  D13, X2
    FMOV  V13.D[1], X17
    FMOV  D14, X21
    FMOV  V14.D[1], X26
    FMOV  D15, X13
    FMOV  V15.D[1], X9
    FMOV  D16, X23
    FMOV  V16.D[1], X22
    FMOV  D17, X12
    FMOV  V17.D[1], X26
    FMOV  D18, X22
    FMOV  V18.D[1], X13
    FMOV  D19, X2
    FMOV  V19.D[1], X3
    FMOV  D20, X22
    FMOV  V20.D[1], X23
    FMOV  D21, X10
    FMOV  V21.D[1], X16
    FMOV  D22, X17
    FMOV  V22.D[1], X10
    FMOV  D23, X26
    FMOV  V23.D[1], X4
    FMOV  D24, X26
    FMOV  V24.D[1], X28
    FMOV  D25, X25
    FMOV  V25.D[1], X12
    FMOV  D26, X27
    FMOV  V26.D[1], X12
    FMOV  D27, X15
    FMOV  V27.D[1], X10
    FMOV  D28, X28
    FMOV  V28.D[1], X22
    FMOV  D29, X19
    FMOV  V29.D[1], X27
    FMOV  D30, X12
    FMOV  V30.D[1], X14
    FMOV  D31, X10
    FMOV  V31.D[1], X5
    MOVZ  X7, #0xf, LSL #0
TaishanSimdAritheticP01_label_414:
    SRSRA  V26.8B, V25.8B, #7
    UQSHL H29, H24, #0x3
    SQRSHRUN2 V25.8H, V28.4S, #10
    USHR D1, D7, #26
    SQSHRUN V4.4H, V24.4S, #1
    UQSHRN H9, S13, #6
    USHR D13, D4, #5
    URSRA  V29.4H, V2.4H, #8
    SRSRA V0.2D, V10.2D, #22
    SRSHR D17, D0, #58
    SSHR  V10.4S, V1.4S, #7
    SQRSHRN H5, S8, #10
    UQSHL D27, D27, #0x1a
    SHRN2 V26.4S, V27.2D, #32
    RSHRN2 V22.4S, V24.2D, #32
    URSHR D20, D19, #45
    SQRSHRUN V6.2S, V4.2D, #22
    FMOV  V1.4S, #14.00000000
    UQSHL  V17.8H, V27.8H, V22.8H
    USHR  V25.4H, V20.4H, #5
    SHLL  V26.4S, V28.4H, #16
    URSHR V0.2D, V5.2D, #22
    UQSHL V28.2D, V0.2D, #0x2a
    UQSHRN S0, D9, #15
    SRI D14, D11, #8
    SRSHR  V11.2S, V4.2S, #22
    SQSHL S8, S17, #0x17
    SSRA D4, D26, #64
    SQSHRUN2 V13.4S, V21.2D, #30
    SQSHRN V3.4H, V4.4S, #1
    UQRSHRN B5, H21, #6
    SQSHLU B0, B13, #0x3
    UQSHL  V8.4H, V0.4H, V20.4H
    SSHLL V24.4S, V1.4H, #0xc
    SQRSHRN2 V4.8H, V23.4S, #2
    UQRSHRN V1.4H, V17.4S, #15
    URSHR D18, D4, #17
    UQRSHRN V1.8B, V28.8H, #1
    UQSHRN V30.4H, V27.4S, #7
    SSHLL2 V13.2D, V17.4S, #0x1d
    SSHR D28, D17, #64
    SQSHL  V27.8H, V8.8H, #0x9
    SSHLL2 V22.4S, V13.8H, #0x8
    SQRSHRN H31, S9, #5
    UQSHRN2 V3.8H, V8.4S, #11
    SQRSHRUN B3, H5, #6
    SRI D11, D27, #43
    SQSHLU  V15.8B, V19.8B, #0x0
    BIC  V15.2S, #0xe3, LSL #24
    UQRSHRN2 V3.8H, V8.4S, #13
    SQRSHRUN H29, S1, #16
    SRSRA  V10.2S, V0.2S, #16
    SRI D28, D12, #59
    SQSHLU S20, S26, #0x1
    UQRSHRN S19, D19, #32
    BIC  V6.2S, #0x4
    SRI  V18.8H, V19.8H, #15
    SHL  V16.16B, V4.16B, #0x4
    UQSHL  V31.16B, V24.16B, #0x1
    SQSHLU V4.2D, V14.2D, #0x3b
    SQRSHRUN2 V2.8H, V26.4S, #4
    UQRSHRN V10.4H, V5.4S, #4
    SQSHLU H12, H3, #0xf
    SHL  V12.16B, V11.16B, #0x1
    SQRSHRUN2 V3.16B, V28.8H, #1
    USHLL V29.8H, V19.8B, #0x3
    SQSHLU S10, S26, #0x1a
    UQSHRN V20.4H, V2.4S, #2
    URSHR  V30.8B, V1.8B, #8
    UQRSHRN B30, H25, #1
    UQSHL  D28, D30, D24
    SQSHL H0, H25, #0x0
    SSRA D4, D16, #39
    SQSHLU  V4.16B, V22.16B, #0x7
    SQSHRUN2 V27.4S, V8.2D, #27
    UQSHRN H6, S23, #5
    SQSHLU  V19.4S, V16.4S, #0x12
    UQRSHRN B8, H16, #5
    SQSHRN B0, H6, #5
    URSHR D12, D9, #10
    SRSRA  V11.4S, V4.4S, #24
    SQSHL  V14.8B, V3.8B, #0x4
    USHLL V0.4S, V14.4H, #0x4
    SHRN2 V2.8H, V1.4S, #13
    SRSHR  V12.2S, V23.2S, #3
    UQSHRN V3.4H, V29.4S, #8
    URSRA  V24.8H, V22.8H, #3
    USHR V23.2D, V18.2D, #22
    UQSHRN2 V7.8H, V5.4S, #4
    SQSHLU  V27.8H, V5.8H, #0x6
    URSRA V30.2D, V13.2D, #61
    SRSRA V11.2D, V29.2D, #21
    URSRA V29.2D, V11.2D, #42
    SRI  V11.8H, V26.8H, #14
    SQSHRUN B26, H29, #2
    SSHLL2 V13.8H, V9.16B, #0x4
    SRSHR  V8.2S, V17.2S, #19
    MVNI  V8.4S, #0x9a, LSL #8
    SQSHLU V22.2D, V27.2D, #0x12
    SSHLL2 V3.4S, V29.8H, #0xd
    RSHRN2 V18.16B, V7.8H, #1
    SQSHRN H19, S6, #12
    SQRSHRN2 V26.4S, V13.2D, #20
    SRSHR D23, D12, #5
    MOVI  D27, #71776123339472895
    SQSHRN V23.4H, V1.4S, #11
    UQRSHRN2 V29.8H, V31.4S, #3
    BIC  V12.8H, #0x67, LSL #8
    BIC  V13.8H, #0xed
    ORR  V27.8H, #0x10, LSL #8
    BIC  V13.4H, #0xe3
    SRI  V18.2S, V1.2S, #9
    UQSHL  V18.16B, V5.16B, #0x5
    RSHRN2 V19.16B, V8.8H, #7
    UQSHL  S24, S24, S26
    USRA V21.2D, V5.2D, #25
    SQSHLU D14, D31, #0xb
    MOVI  D0, #18446462598749552895
    SHLL2  V21.2D, V12.4S, #32
    SQSHRUN V0.8B, V22.8H, #5
    SQSHL  V30.2S, V29.2S, #0x15
    SRSHR  V17.4S, V4.4S, #1
    SQSHRN V11.8B, V22.8H, #3
    SSRA  V10.8H, V1.8H, #7
    USRA V3.2D, V4.2D, #9
    SRSHR  V29.2S, V4.2S, #24
    SLI D24, D2, #0x19
    MOVI  V8.4H, #0xe5, LSL #8
    UQSHL H24, H10, #0x5
    URSRA  V9.8H, V3.8H, #12
    SSRA D28, D22, #54
    SSHLL V29.2D, V29.2S, #0xb
    FMOV  V20.2S, #-4.25000000
    URSHR  V27.4S, V6.4S, #3
    SRSHR V2.2D, V9.2D, #37
    UQSHL  H7, H2, H24
    SRI D8, D9, #19
    SQSHRN V28.4H, V14.4S, #9
    SQRSHRN2 V12.8H, V10.4S, #10
    USRA V30.2D, V22.2D, #40
    SLI  V7.4H, V27.4H, #0x8
    SQRSHRN S17, D21, #30
    SQSHRUN V20.4H, V28.4S, #11
    SSHLL2 V12.8H, V14.16B, #0x7
    SQRSHRUN H3, S12, #14
    MOVI  V11.2D, #71777218572844800
    SHRN2 V12.16B, V13.8H, #8
    UQRSHRN V7.4H, V13.4S, #12
    UQSHL S31, S16, #0x1a
    SQRSHRN S25, D14, #21
    SQSHRN H9, S29, #9
    FMOV  V14.2D, #13.50000000
    SQSHRN V28.4H, V0.4S, #6
    SQSHL B4, B8, #0x5
    SQRSHRUN B22, H4, #7
    SSHR  V24.2S, V26.2S, #18
    SSHR  V8.4S, V7.4S, #18
    UQSHL D26, D22, #0x7
    SQSHLU  V3.16B, V27.16B, #0x0
    SSHR  V12.8H, V0.8H, #16
    URSHR  V0.8B, V13.8B, #1
    USHLL2 V13.4S, V16.8H, #0xa
    SRSRA D0, D4, #29
    SQRSHRUN V17.8B, V4.8H, #4
    UQRSHRN2 V4.8H, V29.4S, #10
    UQSHL  D24, D17, D17
    URSRA V5.2D, V12.2D, #58
    URSHR  V13.4H, V6.4H, #12
    SQSHRN H28, S0, #9
    UQSHRN2 V6.4S, V13.2D, #7
    SHL  V31.4H, V25.4H, #0x8
    MOVI  D28, #281470698455040
    UQSHL V25.2D, V10.2D, #0x22
    USHLL V16.8H, V11.8B, #0x2
    MOVI  V15.16B, #0xb3
    RSHRN2 V17.16B, V11.8H, #3
    SSHR  V10.8B, V30.8B, #3
    SSRA D12, D10, #22
    SRI  V23.8B, V28.8B, #6
    SQSHRUN S6, D28, #1
    SQSHL S8, S28, #0x15
    SRSHR  V24.4S, V1.4S, #13
    SQRSHRN2 V28.4S, V25.2D, #29
    UQSHRN V19.2S, V19.2D, #12
    UQSHRN V8.4H, V12.4S, #11
    UQSHL  V1.4S, V1.4S, V0.4S
    SQSHRN S17, D28, #24
    USRA  V5.4H, V13.4H, #12
    SQSHL  V23.16B, V18.16B, #0x7
    UQSHRN V27.8B, V10.8H, #5
    SSHR V31.2D, V25.2D, #37
    URSRA  V13.16B, V5.16B, #7
    SQSHRUN2 V19.8H, V12.4S, #8
    UQSHL D5, D13, #0x9
    SSHLL2 V11.4S, V12.8H, #0xf
    SQSHLU B16, B18, #0x0
    USHLL2 V27.4S, V28.8H, #0x3
    RSHRN V30.4H, V10.4S, #4
    URSHR  V24.8H, V5.8H, #1
    BIC  V29.4S, #0x4c, LSL #24
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdAritheticP01_label_414
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
TaishanSimdAritheticP01_label_275:
    SUB  X21, X24, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X2, X12, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X23, X9, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X12, X22, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X3, X25, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X9, X11, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X7, X27, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X9, X13, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X26, X11, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X13, X15, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X26, X24, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X18, X25, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X13, X11, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X24, X10, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X21, X16, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X17, X12, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D3
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D6
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X14, X24, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D8
    MOVZ  X19, #0xffff, LSL #0
    SUB  X12, X19, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D9
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D10
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xfff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xfff, LSL #48
    SUB  X18, X25, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D11
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D12
    MOVZ  X22, #0xfc3f, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0x3f, LSL #32
    SUB  X19, X22, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x402b, LSL #48
    SUB  X23, X24, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D14
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x402b, LSL #48
    SUB  X23, X24, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X22, #0xb3b3, LSL #0
    MOVK  X22, #0xb3b3, LSL #16
    MOVK  X22, #0xb3b3, LSL #32
    MOVK  X22, #0xb3b3, LSL #48
    SUB  X21, X22, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D15
    MOVZ  X22, #0xb3b3, LSL #0
    MOVK  X22, #0xb3b3, LSL #16
    MOVK  X22, #0xb3b3, LSL #32
    MOVK  X22, #0xb3b3, LSL #48
    SUB  X21, X22, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D17
    MOVZ  X12, #0xff00, LSL #0
    MOVK  X12, #0xff, LSL #16
    SUB  X19, X12, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D19
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X2, X27, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D20
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D25
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D27
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D28
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    SUB  X5, X24, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0xa0e2, LSL #0
    MOVK  X2, #0xa5ca, LSL #16
    MOVK  X2, #0x23cd, LSL #32
    MOVK  X2, #0xd38f, LSL #48
    MOVZ  X3, #0xdbed, LSL #0
    MOVK  X3, #0xc8b0, LSL #16
    MOVK  X3, #0xc02d, LSL #32
    MOVK  X3, #0xe47b, LSL #48
    MOVZ  X4, #0xe195, LSL #0
    MOVK  X4, #0x437e, LSL #16
    MOVK  X4, #0xcd9c, LSL #32
    MOVK  X4, #0xc99d, LSL #48
    MOVZ  X5, #0xec33, LSL #0
    MOVK  X5, #0x9fa9, LSL #16
    MOVK  X5, #0x47b2, LSL #32
    MOVK  X5, #0x243e, LSL #48
    MOVZ  X6, #0xf41c, LSL #0
    MOVK  X6, #0xb4a9, LSL #16
    MOVK  X6, #0x297d, LSL #32
    MOVK  X6, #0x5a08, LSL #48
    MOVZ  X7, #0x92fa, LSL #0
    MOVK  X7, #0x53b1, LSL #16
    MOVK  X7, #0xde64, LSL #32
    MOVK  X7, #0xe293, LSL #48
    MOVZ  X8, #0xadf2, LSL #0
    MOVK  X8, #0x7a5c, LSL #16
    MOVK  X8, #0xb574, LSL #32
    MOVK  X8, #0x6fcf, LSL #48
    MOVZ  X9, #0xbed8, LSL #0
    MOVK  X9, #0x9fb4, LSL #16
    MOVK  X9, #0x83f1, LSL #32
    MOVK  X9, #0x4636, LSL #48
    MOVZ  X10, #0x3dae, LSL #0
    MOVK  X10, #0x84b, LSL #16
    MOVK  X10, #0xc834, LSL #32
    MOVK  X10, #0x3a7d, LSL #48
    MOVZ  X11, #0x27e0, LSL #0
    MOVK  X11, #0xbb3d, LSL #16
    MOVK  X11, #0x5b5b, LSL #32
    MOVK  X11, #0x6e9d, LSL #48
    MOVZ  X12, #0x1170, LSL #0
    MOVK  X12, #0x809c, LSL #16
    MOVK  X12, #0x54bb, LSL #32
    MOVK  X12, #0xc65b, LSL #48
    MOVZ  X13, #0xe5bf, LSL #0
    MOVK  X13, #0x568c, LSL #16
    MOVK  X13, #0xd009, LSL #32
    MOVK  X13, #0x3c9e, LSL #48
    MOVZ  X14, #0x67b3, LSL #0
    MOVK  X14, #0x44b, LSL #16
    MOVK  X14, #0x63b3, LSL #32
    MOVK  X14, #0x682d, LSL #48
    MOVZ  X15, #0x2d29, LSL #0
    MOVK  X15, #0x4460, LSL #16
    MOVK  X15, #0x1c47, LSL #32
    MOVK  X15, #0x914d, LSL #48
    MOVZ  X16, #0x9a8e, LSL #0
    MOVK  X16, #0x32c1, LSL #16
    MOVK  X16, #0xd9e3, LSL #32
    MOVK  X16, #0x3192, LSL #48
    MOVZ  X17, #0xb499, LSL #0
    MOVK  X17, #0xccfa, LSL #16
    MOVK  X17, #0x7219, LSL #32
    MOVK  X17, #0x311d, LSL #48
    MOVZ  X18, #0xafd9, LSL #0
    MOVK  X18, #0xa118, LSL #16
    MOVK  X18, #0x4e23, LSL #32
    MOVK  X18, #0xfc2e, LSL #48
    MOVZ  X19, #0x9178, LSL #0
    MOVK  X19, #0xdb59, LSL #16
    MOVK  X19, #0xda19, LSL #32
    MOVK  X19, #0x1626, LSL #48
    MOVZ  X20, #0xcc68, LSL #0
    MOVK  X20, #0x570f, LSL #16
    MOVK  X20, #0x7970, LSL #32
    MOVK  X20, #0xcf77, LSL #48
    MOVZ  X21, #0x4f7c, LSL #0
    MOVK  X21, #0x961a, LSL #16
    MOVK  X21, #0x83c5, LSL #32
    MOVK  X21, #0x7fba, LSL #48
    MOVZ  X22, #0x6259, LSL #0
    MOVK  X22, #0xdb02, LSL #16
    MOVK  X22, #0x9232, LSL #32
    MOVK  X22, #0x15e4, LSL #48
    MOVZ  X23, #0x27a7, LSL #0
    MOVK  X23, #0x2c48, LSL #16
    MOVK  X23, #0x2cda, LSL #32
    MOVK  X23, #0x7dc6, LSL #48
    MOVZ  X24, #0x1c4c, LSL #0
    MOVK  X24, #0x20d4, LSL #16
TaishanSimdAritheticP01_label_214:
    MOVK  X24, #0x606d, LSL #32
    MOVK  X24, #0x74bc, LSL #48
    MOVZ  X25, #0xb582, LSL #0
    MOVK  X25, #0x62ce, LSL #16
    MOVK  X25, #0x8ea0, LSL #32
    MOVK  X25, #0x3fc7, LSL #48
    MOVZ  X26, #0xb25a, LSL #0
    MOVK  X26, #0x9cb1, LSL #16
    MOVK  X26, #0x6f05, LSL #32
    MOVK  X26, #0x8907, LSL #48
    MOVZ  X27, #0x1912, LSL #0
    MOVK  X27, #0x29b2, LSL #16
    MOVK  X27, #0x1dbe, LSL #32
    MOVK  X27, #0x5648, LSL #48
    MOVZ  X28, #0xe24a, LSL #0
    MOVK  X28, #0x4d55, LSL #16
    MOVK  X28, #0xf55a, LSL #32
    MOVK  X28, #0x4a74, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X10
    FMOV  D1, X9
    FMOV  V1.D[1], X9
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X17
    FMOV  V3.D[1], X2
    FMOV  D4, X4
    FMOV  V4.D[1], X4
    FMOV  D5, X28
    FMOV  V5.D[1], X2
    FMOV  D6, X24
    FMOV  V6.D[1], X3
    FMOV  D7, X14
    FMOV  V7.D[1], X14
    FMOV  D8, X20
    FMOV  V8.D[1], X9
    FMOV  D9, X8
    FMOV  V9.D[1], X12
    FMOV  D10, X7
    FMOV  V10.D[1], X23
    FMOV  D11, X8
    FMOV  V11.D[1], X4
    FMOV  D12, X5
    FMOV  V12.D[1], X5
    FMOV  D13, X7
    FMOV  V13.D[1], X7
    FMOV  D14, X21
    FMOV  V14.D[1], X19
    FMOV  D15, X3
    FMOV  V15.D[1], X10
    FMOV  D16, X12
    FMOV  V16.D[1], X9
    FMOV  D17, X9
    FMOV  V17.D[1], X19
    FMOV  D18, X7
    FMOV  V18.D[1], X25
    FMOV  D19, X21
    FMOV  V19.D[1], X12
    FMOV  D20, X3
    FMOV  V20.D[1], X21
    FMOV  D21, X11
    FMOV  V21.D[1], X24
    FMOV  D22, X25
    FMOV  V22.D[1], X25
    FMOV  D23, X12
    FMOV  V23.D[1], X14
    FMOV  D24, X16
    FMOV  V24.D[1], X24
    FMOV  D25, X27
    FMOV  V25.D[1], X12
    FMOV  D26, X10
    FMOV  V26.D[1], X21
    FMOV  D27, X9
    FMOV  V27.D[1], X7
    FMOV  D28, X27
    FMOV  V28.D[1], X6
    FMOV  D29, X7
    FMOV  V29.D[1], X6
    FMOV  D30, X14
    FMOV  V30.D[1], X10
    FMOV  D31, X11
    FMOV  V31.D[1], X27
    MOVZ  X4, #0xa, LSL #0
TaishanSimdAritheticP01_label_496:
    SQRSHRUN2 V18.16B, V15.8H, #8
    UQSHRN S12, D23, #23
    SSHLL V25.8H, V11.8B, #0x4
    URSHR  V12.4S, V16.4S, #11
    SQRSHRN V0.2S, V26.2D, #12
    SQRSHRUN V11.4H, V26.4S, #9
    SQSHRN B14, H11, #1
    UQSHL  H25, H22, H5
    SQSHRN2 V9.16B, V30.8H, #5
    SHLL  V26.8H, V31.8B, #8
    USHLL V25.2D, V22.2S, #0x1d
    SSHR D13, D13, #12
    SQRSHRUN S22, D23, #27
    SQRSHRUN V3.8B, V11.8H, #7
    SQSHRN2 V20.4S, V5.2D, #32
    MVNI  V26.4S, #0x77, MSL #16
    SQRSHRUN V7.8B, V25.8H, #6
    SQSHRUN2 V1.8H, V29.4S, #16
    SRSHR D28, D16, #13
    SSRA  V27.16B, V1.16B, #4
    SRSHR D11, D28, #19
    SQSHRUN2 V8.4S, V11.2D, #22
    UQSHL V27.2D, V2.2D, #0x1
    SSHLL V11.8H, V23.8B, #0x2
    SQRSHRUN2 V6.16B, V19.8H, #4
    SSHR D7, D7, #42
    SSHLL2 V2.4S, V12.8H, #0xb
    UQSHRN V1.8B, V12.8H, #8
    SQSHL  V30.8B, V11.8B, #0x2
    UQSHRN V27.8B, V7.8H, #6
    SSHR  V2.2S, V18.2S, #25
    UQSHL  B26, B3, B5
    SQRSHRUN S3, D19, #10
    SSHLL2 V4.8H, V1.16B, #0x5
    SQRSHRUN V13.4H, V14.4S, #7
    SQRSHRUN2 V4.16B, V27.8H, #1
    SRI D29, D14, #30
    SQSHRUN V30.2S, V25.2D, #8
    SQRSHRN V28.4H, V23.4S, #9
    SSHR  V11.8B, V12.8B, #8
    SSHLL V25.2D, V12.2S, #0x6
    UQSHL D18, D25, #0x12
    URSRA V5.2D, V6.2D, #51
    SQSHLU  V5.8B, V19.8B, #0x7
    SRSRA  V20.8B, V11.8B, #5
    UQSHL  V29.16B, V23.16B, #0x0
    SQSHRUN2 V26.4S, V25.2D, #23
    SQSHRUN V2.4H, V29.4S, #9
    SRI  V10.16B, V6.16B, #7
    SQRSHRUN2 V6.4S, V29.2D, #32
    RSHRN V17.4H, V2.4S, #10
    SQSHRN H23, S12, #9
    SRI V14.2D, V11.2D, #12
    SSRA  V30.4S, V2.4S, #13
    SQRSHRN2 V11.8H, V22.4S, #4
    SHRN V6.8B, V10.8H, #8
    SRI  V4.4S, V2.4S, #29
    SQRSHRUN2 V28.8H, V4.4S, #10
    SQSHRN V1.4H, V12.4S, #1
    SQSHRUN2 V27.16B, V30.8H, #6
    SQSHLU V4.2D, V22.2D, #0xf
    RSHRN2 V30.16B, V15.8H, #1
    MOVI  D22, #280379743272960
    RSHRN V6.8B, V10.8H, #7
    RSHRN2 V5.16B, V14.8H, #2
    SSRA  V28.8H, V25.8H, #4
    UQSHL  S10, S20, S31
    SRSHR  V6.2S, V30.2S, #27
    SHRN V23.2S, V1.2D, #6
    UQRSHRN2 V12.4S, V31.2D, #15
    RSHRN V4.4H, V1.4S, #6
    BIC  V20.4H, #0xc6
    UQSHRN H10, S17, #1
    SRSHR D23, D23, #14
    FMOV  V6.2D, #-1.00000000
    SRSRA  V3.2S, V3.2S, #17
    UQRSHRN2 V12.4S, V1.2D, #12
    SHRN2 V5.4S, V9.2D, #17
    SQRSHRN2 V9.4S, V24.2D, #16
    UQSHL  V12.2S, V24.2S, V3.2S
    SHRN V14.4H, V31.4S, #1
    SQSHLU  V12.16B, V28.16B, #0x5
    UQSHRN2 V20.16B, V10.8H, #1
    SLI  V21.4H, V26.4H, #0x5
    USRA  V12.8H, V6.8H, #11
    SHLL  V24.8H, V14.8B, #8
    MOVI  V7.2S, #0xdb
    SQRSHRUN V5.2S, V28.2D, #15
    UQSHL  V1.8H, V31.8H, #0x9
    SQSHL B4, B1, #0x7
    USHLL2 V8.2D, V10.4S, #0xd
    SQSHLU D10, D4, #0x10
    USHLL V3.4S, V26.4H, #0x6
    SQRSHRN B27, H8, #2
    SQRSHRN V3.8B, V25.8H, #7
    SQSHRN2 V22.8H, V9.4S, #15
    SQRSHRN H4, S6, #7
    UQSHL H12, H15, #0xb
    SQSHRUN2 V14.16B, V10.8H, #1
    UQSHL  S26, S31, S7
    SRSHR  V24.4H, V7.4H, #5
    SQSHLU H5, H28, #0x3
    SQSHRUN H23, S0, #2
    URSHR D3, D0, #55
    URSHR V22.2D, V25.2D, #50
    SQSHL  V8.8B, V7.8B, #0x1
    SQRSHRN V15.4H, V28.4S, #7
    SQSHRUN2 V21.16B, V26.8H, #5
    SRSRA D29, D8, #22
    USHR  V21.4S, V4.4S, #31
    ORR  V0.4S, #0x21, LSL #24
    SRI V13.2D, V19.2D, #4
    SQSHLU  V7.16B, V10.16B, #0x5
    UQSHL  V29.8H, V6.8H, #0xf
    SRI  V5.8H, V18.8H, #1
    URSRA V31.2D, V31.2D, #8
    UQRSHRN V5.8B, V0.8H, #5
    SQSHLU  V29.2S, V28.2S, #0x1f
    UQSHRN V10.4H, V2.4S, #15
    URSHR V22.2D, V9.2D, #2
    SHRN2 V25.4S, V31.2D, #23
    SQSHRUN V20.4H, V8.4S, #16
    FMOV  V26.4S, #-3.37500000
    SLI  V29.4S, V17.4S, #0x8
    RSHRN V11.8B, V23.8H, #8
    UQSHL H25, H15, #0x4
    UQSHL  D17, D27, D15
    URSHR D23, D13, #20
    SRSHR  V3.4S, V5.4S, #26
    SQSHRN V24.8B, V20.8H, #1
    MOVI  V1.4S, #0x1c, LSL #24
    SSHLL V27.8H, V21.8B, #0x6
    FMOV  V11.4S, #0.28125000
    SLI D29, D28, #0x1f
    UQSHRN V10.2S, V25.2D, #13
    SSHLL2 V28.2D, V7.4S, #0x9
    SRSHR  V3.4H, V26.4H, #7
    SQSHLU  V20.8H, V14.8H, #0xd
    SQRSHRN2 V15.16B, V7.8H, #8
    SRSHR  V3.2S, V5.2S, #7
    UQRSHRN B22, H13, #1
    SSRA V6.2D, V28.2D, #25
    SQSHL  V23.16B, V8.16B, #0x3
    UQSHL  D24, D16, D25
    UQSHL V27.2D, V17.2D, #0x0
    UQSHL  V21.8B, V25.8B, #0x2
    USHR  V2.2S, V1.2S, #16
    USHLL2 V14.8H, V10.16B, #0x1
    SQRSHRUN V15.4H, V3.4S, #13
    SQSHRN2 V11.16B, V31.8H, #5
    SQRSHRN V7.2S, V1.2D, #17
    UQRSHRN V19.2S, V23.2D, #14
    SQSHRN V3.4H, V30.4S, #2
    SHRN V27.2S, V25.2D, #9
    SHRN V7.8B, V29.8H, #1
    SRSHR D31, D31, #50
    RSHRN2 V12.8H, V7.4S, #4
    FMOV  V19.2D, #-22.00000000
    SQSHL  V18.2S, V19.2S, #0x4
    UQSHRN2 V22.16B, V1.8H, #2
    SLI D24, D17, #0x7
    SHRN2 V2.16B, V5.8H, #8
    SLI  V15.16B, V7.16B, #0x4
    SRSHR V24.2D, V26.2D, #45
    SSRA  V24.4S, V5.4S, #22
    UQSHRN S15, D11, #27
    USHLL V0.8H, V5.8B, #0x6
    MVNI  V9.4S, #0x13, MSL #16
    SSHR D7, D19, #6
    SSHR  V9.4S, V11.4S, #11
    SQSHL  V11.4H, V12.4H, #0x3
    MOVI  V31.8H, #0x6e
    USHLL V5.4S, V23.4H, #0x3
    SHRN V2.8B, V13.8H, #4
    UQSHL B28, B1, #0x2
    UQSHL  V11.8B, V17.8B, #0x7
    SQSHLU  V13.8B, V30.8B, #0x7
    SQRSHRN2 V12.8H, V1.4S, #13
    SQRSHRUN H2, S6, #7
    URSRA V17.2D, V19.2D, #42
    UQSHRN B6, H19, #6
    SQSHRN S30, D7, #32
    MOVI  V18.16B, #0xec
    SSRA V26.2D, V19.2D, #12
    URSRA  V10.16B, V26.16B, #8
    SQSHRN V1.2S, V26.2D, #1
    URSHR  V18.4H, V19.4H, #15
    UQSHL  S6, S7, S18
    SQSHRN V3.2S, V0.2D, #29
    UQSHRN V1.8B, V23.8H, #6
    URSRA V11.2D, V23.2D, #52
    SQSHRUN2 V25.8H, V29.4S, #13
    SQSHLU  V6.8H, V22.8H, #0xe
    URSHR  V12.4H, V21.4H, #1
    USHR D2, D8, #36
    SHRN V12.8B, V6.8H, #7
    SSHR V31.2D, V10.2D, #51
    UQSHL  H23, H26, H17
    URSHR D7, D13, #55
    URSHR  V19.8B, V6.8B, #8
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdAritheticP01_label_496
    MOVZ  X26, #0xa0e2, LSL #0
    MOVK  X26, #0xa5ca, LSL #16
    MOVK  X26, #0x23cd, LSL #32
    MOVK  X26, #0xd38f, LSL #48
    SUB  X8, X26, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0xdbed, LSL #0
    MOVK  X13, #0xc8b0, LSL #16
    MOVK  X13, #0xc02d, LSL #32
    MOVK  X13, #0xe47b, LSL #48
    SUB  X14, X13, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0xec33, LSL #0
    MOVK  X17, #0x9fa9, LSL #16
    MOVK  X17, #0x47b2, LSL #32
    MOVK  X17, #0x243e, LSL #48
    SUB  X9, X17, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x92fa, LSL #0
    MOVK  X7, #0x53b1, LSL #16
    MOVK  X7, #0xde64, LSL #32
    MOVK  X7, #0xe293, LSL #48
    SUB  X14, X7, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x3dae, LSL #0
    MOVK  X16, #0x84b, LSL #16
    MOVK  X16, #0xc834, LSL #32
    MOVK  X16, #0x3a7d, LSL #48
    SUB  X4, X16, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x27e0, LSL #0
    MOVK  X21, #0xbb3d, LSL #16
    MOVK  X21, #0x5b5b, LSL #32
    MOVK  X21, #0x6e9d, LSL #48
    SUB  X16, X21, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x1170, LSL #0
    MOVK  X8, #0x809c, LSL #16
    MOVK  X8, #0x54bb, LSL #32
    MOVK  X8, #0xc65b, LSL #48
    SUB  X21, X8, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0xdbed, LSL #0
    MOVK  X15, #0xc8b0, LSL #16
    MOVK  X15, #0xc02d, LSL #32
    MOVK  X15, #0xe47b, LSL #48
    SUB  X19, X15, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0xdbed, LSL #0
    MOVK  X18, #0xc8b0, LSL #16
    MOVK  X18, #0xc02d, LSL #32
    MOVK  X18, #0xe47b, LSL #48
    SUB  X2, X18, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0xec33, LSL #0
    MOVK  X14, #0x9fa9, LSL #16
    MOVK  X14, #0x47b2, LSL #32
    MOVK  X14, #0x243e, LSL #48
    SUB  X26, X14, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0xdbed, LSL #0
    MOVK  X26, #0xc8b0, LSL #16
    MOVK  X26, #0xc02d, LSL #32
    MOVK  X26, #0xe47b, LSL #48
    SUB  X6, X26, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x6259, LSL #0
    MOVK  X24, #0xdb02, LSL #16
    MOVK  X24, #0x9232, LSL #32
    MOVK  X24, #0x15e4, LSL #48
    SUB  X21, X24, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x27a7, LSL #0
    MOVK  X15, #0x2c48, LSL #16
    MOVK  X15, #0x2cda, LSL #32
    MOVK  X15, #0x7dc6, LSL #48
    SUB  X13, X15, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x6259, LSL #0
    MOVK  X6, #0xdb02, LSL #16
    MOVK  X6, #0x9232, LSL #32
    MOVK  X6, #0x15e4, LSL #48
    SUB  X17, X6, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0xb582, LSL #0
    MOVK  X14, #0x62ce, LSL #16
    MOVK  X14, #0x8ea0, LSL #32
    MOVK  X14, #0x3fc7, LSL #48
    SUB  X13, X14, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0xdbed, LSL #0
    MOVK  X4, #0xc8b0, LSL #16
    MOVK  X4, #0xc02d, LSL #32
    MOVK  X4, #0xe47b, LSL #48
    SUB  X24, X4, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0xe24a, LSL #0
    MOVK  X24, #0x4d55, LSL #16
    MOVK  X24, #0xf55a, LSL #32
    MOVK  X24, #0x4a74, LSL #48
    SUB  X10, X24, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D2
    MOVZ  X9, #0xb, LSL #0
    SUB  X17, X9, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D3
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X26, X7, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D4
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X7, #0x400, LSL #0
    SUB  X16, X7, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D5
    MOVZ  X7, #0x400, LSL #0
    SUB  X16, X7, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D6
    MOVZ  X8, #0xffff, LSL #0
    SUB  X18, X8, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D7
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D8
    MOVZ  X10, #0xb6, LSL #0
    MOVK  X10, #0xb6, LSL #32
    SUB  X26, X10, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D9
    MOVZ  X4, #0xd200, LSL #0
    MOVK  X4, #0x7, LSL #16
    MOVK  X4, #0xd200, LSL #32
    MOVK  X4, #0x7, LSL #48
    SUB  X8, X4, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x100, LSL #16
    MOVK  X8, #0x100, LSL #48
    SUB  X20, X8, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D10
    MOVZ  X8, #0x7, LSL #0
    MOVK  X8, #0x100, LSL #16
    MOVK  X8, #0x100, LSL #48
    SUB  X20, X8, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D11
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D12
    MOVZ  X6, #0xff, LSL #0
    SUB  X27, X6, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D13
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X19, X27, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D15
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    SUB  X16, X25, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X2, #0xbed8, LSL #0
    MOVK  X2, #0x9fb4, LSL #16
    MOVK  X2, #0x83f1, LSL #32
    MOVK  X2, #0x4636, LSL #48
    SUB  X27, X2, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D16
    MOVZ  X2, #0x1170, LSL #0
    MOVK  X2, #0x809c, LSL #16
    MOVK  X2, #0x54bb, LSL #32
    MOVK  X2, #0xc65b, LSL #48
    SUB  X27, X2, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X10, #0xd80, LSL #0
    MOVK  X10, #0x30, LSL #16
    SUB  X2, X10, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D17
    MOVZ  X10, #0xd80, LSL #0
    MOVK  X10, #0x30, LSL #16
    SUB  X2, X10, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D18
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x2, LSL #48
    SUB  X16, X15, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D19
    MOVZ  X27, #0x101, LSL #0
    SUB  X9, X27, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D20
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #32
    SUB  X22, X9, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D21
    MOVZ  X23, #0xffff, LSL #0
    SUB  X4, X23, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X9, #0xff00, LSL #0
    MOVK  X9, #0xff00, LSL #16
    MOVK  X9, #0xff00, LSL #32
    MOVK  X9, #0xff00, LSL #48
    SUB  X27, X9, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D22
    MOVZ  X9, #0x8, LSL #0
    SUB  X27, X9, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D23
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X22, #0x2c0, LSL #0
    MOVK  X22, #0xfffe, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X19, X22, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D24
    MOVZ  X22, #0x2bc, LSL #0
    MOVK  X22, #0xfffe, LSL #16
    MOVK  X22, #0xfffb, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X19, X22, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x103, LSL #16
    SUB  X13, X7, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D25
    MOVZ  X7, #0xffff, LSL #0
    SUB  X13, X7, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xc058, LSL #16
    MOVK  X10, #0x360, LSL #32
    MOVK  X10, #0xc054, LSL #48
    SUB  X9, X10, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D26
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xc058, LSL #16
    MOVK  X10, #0x360, LSL #32
    MOVK  X10, #0xc054, LSL #48
    SUB  X9, X10, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D27
    MOVZ  X18, #0x7f, LSL #0
    SUB  X4, X18, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D28
    MOVZ  X9, #0x0, LSL #0
    SUB  X15, X9, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X17
    FMOV  V0.D[1], X25
    FMOV  D1, X7
    FMOV  V1.D[1], X4
    FMOV  D2, X11
    FMOV  V2.D[1], X28
    FMOV  D3, X23
    FMOV  V3.D[1], X9
    FMOV  D4, X4
    FMOV  V4.D[1], X5
    FMOV  D5, X4
    FMOV  V5.D[1], X24
    FMOV  D6, X21
    FMOV  V6.D[1], X3
    FMOV  D7, X19
    FMOV  V7.D[1], X27
    FMOV  D8, X7
    FMOV  V8.D[1], X8
    FMOV  D9, X8
    FMOV  V9.D[1], X4
    FMOV  D10, X10
    FMOV  V10.D[1], X23
    FMOV  D11, X13
    FMOV  V11.D[1], X17
    FMOV  D12, X24
    FMOV  V12.D[1], X27
    FMOV  D13, X5
    FMOV  V13.D[1], X16
    FMOV  D14, X21
    FMOV  V14.D[1], X28
    FMOV  D15, X7
    FMOV  V15.D[1], X11
    FMOV  D16, X7
    FMOV  V16.D[1], X23
    FMOV  D17, X10
    FMOV  V17.D[1], X3
    FMOV  D18, X4
    FMOV  V18.D[1], X14
    FMOV  D19, X24
    FMOV  V19.D[1], X2
    FMOV  D20, X4
    FMOV  V20.D[1], X24
    FMOV  D21, X14
    FMOV  V21.D[1], X18
    FMOV  D22, X21
    FMOV  V22.D[1], X19
    FMOV  D23, X13
    FMOV  V23.D[1], X13
    FMOV  D24, X22
    FMOV  V24.D[1], X7
    FMOV  D25, X12
    FMOV  V25.D[1], X2
    FMOV  D26, X27
    FMOV  V26.D[1], X22
    FMOV  D27, X9
    FMOV  V27.D[1], X3
    FMOV  D28, X9
    FMOV  V28.D[1], X8
    FMOV  D29, X6
    FMOV  V29.D[1], X27
    FMOV  D30, X27
    FMOV  V30.D[1], X6
    FMOV  D31, X4
    FMOV  V31.D[1], X26
    MOVZ  X26, #0xa, LSL #0
TaishanSimdAritheticP01_label_579:
    SQRSHRUN B30, H14, #7
    MVNI  V22.4S, #0xf, LSL #16
    MOVI  V16.2D, #18446742978476114175
    UQSHL  V26.8H, V16.8H, #0x8
    SQRSHRUN V18.8B, V0.8H, #8
    SSHR V22.2D, V8.2D, #23
    MOVI  V11.8H, #0xd6
    SQRSHRN S9, D13, #3
    SSHLL2 V11.8H, V30.16B, #0x7
    USHR  V22.4H, V30.4H, #14
    SQRSHRN S21, D7, #8
    SQSHLU B14, B26, #0x7
    SQSHRUN S16, D18, #6
    SQRSHRUN2 V24.8H, V0.4S, #6
    UQSHRN S4, D9, #27
    SSHLL2 V28.2D, V20.4S, #0x10
    UQSHL  B11, B5, B27
    SSHR V30.2D, V28.2D, #47
    URSHR  V16.8H, V21.8H, #5
    MVNI  V20.4H, #0x39, LSL #8
    SQRSHRN V20.4H, V5.4S, #2
    SQSHLU B11, B24, #0x2
    SQSHL V14.2D, V18.2D, #0x10
    SRSHR  V13.16B, V22.16B, #7
    UQRSHRN2 V26.16B, V5.8H, #4
    SSHLL2 V26.8H, V8.16B, #0x4
    RSHRN2 V18.8H, V14.4S, #1
    SQSHRUN S4, D23, #10
    SHLL2  V29.8H, V5.16B, #8
    RSHRN2 V23.4S, V18.2D, #13
    SQSHLU  V18.2S, V4.2S, #0x1c
    SHL  V30.8B, V18.8B, #0x6
    UQSHL  V19.4H, V23.4H, #0x1
    SRSHR D29, D23, #18
    SQSHRUN V10.4H, V26.4S, #7
    MVNI  V30.4S, #0x67, MSL #8
    URSRA  V12.4H, V11.4H, #9
    SHL  V5.8H, V24.8H, #0xe
    USHLL V21.8H, V0.8B, #0x5
    SRSRA  V0.4S, V9.4S, #29
    SQSHLU  V7.8B, V12.8B, #0x5
    UQSHL  V9.4H, V19.4H, V22.4H
    SHLL2  V19.8H, V18.16B, #8
    USRA V7.2D, V5.2D, #58
    SQRSHRN2 V26.4S, V11.2D, #22
    UQSHL B23, B10, #0x0
    RSHRN2 V24.16B, V28.8H, #7
    SRI V17.2D, V23.2D, #28
    SQSHRUN2 V31.16B, V13.8H, #1
    USRA V4.2D, V27.2D, #9
    URSHR  V0.4H, V4.4H, #3
    USHLL2 V5.2D, V21.4S, #0x1f
    SHRN V29.4H, V16.4S, #13
    SRSRA  V4.2S, V10.2S, #11
    MVNI  V22.2S, #0xa5, MSL #16
    USHLL2 V31.8H, V29.16B, #0x1
    UQSHRN2 V14.16B, V22.8H, #8
    SRSHR  V17.8B, V18.8B, #8
    UQRSHRN2 V6.4S, V8.2D, #17
    ORR  V4.4S, #0x83
    USHR  V30.16B, V29.16B, #2
    SQSHRUN V0.4H, V12.4S, #3
    USHR V5.2D, V21.2D, #46
    SQSHRUN S11, D27, #13
    SHL  V17.4S, V15.4S, #0x1a
    SRSHR  V3.4H, V14.4H, #9
    URSHR  V20.16B, V27.16B, #4
    UQSHL  V11.16B, V1.16B, V3.16B
    RSHRN V13.4H, V1.4S, #1
    SQRSHRN2 V6.4S, V22.2D, #24
    UQSHL  V12.2S, V20.2S, #0x18
    SQSHRUN2 V5.16B, V28.8H, #1
    SLI  V31.8B, V10.8B, #0x5
    USHLL V29.4S, V14.4H, #0xe
    SQRSHRUN H2, S12, #10
    SRI  V17.4H, V6.4H, #5
    SLI  V6.16B, V8.16B, #0x6
    SQSHL V18.2D, V14.2D, #0x3e
    UQSHL  D0, D17, D27
    SHRN V14.8B, V18.8H, #8
    SSHLL2 V8.2D, V7.4S, #0x1
    SLI  V8.8B, V31.8B, #0x3
    SQSHLU  V10.8B, V15.8B, #0x1
    UQRSHRN V17.8B, V24.8H, #5
    USRA  V20.8B, V15.8B, #7
    SHL  V27.4H, V17.4H, #0x4
    SQSHRUN B21, H7, #5
    FMOV  V11.4S, #-0.78125000
    SRSRA  V25.2S, V30.2S, #25
    SRSHR  V21.4S, V30.4S, #2
    UQRSHRN V7.8B, V8.8H, #6
    USRA V10.2D, V21.2D, #4
    BIC  V29.4S, #0x7f, LSL #24
    UQRSHRN V27.4H, V0.4S, #16
    SHRN2 V7.16B, V17.8H, #6
    SHL  V10.8B, V10.8B, #0x1
    SQSHRUN V28.2S, V24.2D, #31
    SQSHRN S30, D14, #25
TaishanSimdAritheticP01_label_156:
    SQSHLU  V26.2S, V31.2S, #0x1
    SQSHL D12, D29, #0x38
    USHLL2 V28.8H, V25.16B, #0x5
    RSHRN2 V9.8H, V0.4S, #16
    SRI  V24.2S, V31.2S, #5
    USHR D2, D9, #34
    SRSRA D25, D1, #63
    SQRSHRN2 V21.4S, V1.2D, #16
    SQRSHRN V3.4H, V29.4S, #1
    SQRSHRN V14.2S, V15.2D, #30
    SRSRA D15, D20, #62
    UQSHL  V0.8B, V11.8B, #0x0
    SQSHRUN V31.2S, V8.2D, #9
    SHRN V8.8B, V9.8H, #3
    SLI D27, D5, #0x23
    UQSHL S18, S13, #0xd
    ORR  V9.4S, #0xf7, LSL #8
    UQRSHRN V24.4H, V18.4S, #12
    FMOV  V6.2D, #23.00000000
    UQSHL B27, B12, #0x6
    SQSHRN H12, S22, #5
    SQSHRN V2.8B, V28.8H, #7
    SHLL  V15.2D, V24.2S, #32
    SSHLL2 V29.4S, V20.8H, #0xf
    RSHRN V11.8B, V16.8H, #4
    SRI  V25.4H, V13.4H, #15
    USHLL2 V31.4S, V1.8H, #0xb
    USRA  V14.8H, V10.8H, #13
    SRI  V22.4H, V18.4H, #3
    SRSHR V15.2D, V27.2D, #41
    UQSHL  V8.4S, V29.4S, #0x13
    SQRSHRUN2 V25.8H, V0.4S, #10
    RSHRN V28.4H, V15.4S, #15
    USRA V16.2D, V5.2D, #8
    UQSHL  B24, B15, B16
    SQSHRN B1, H22, #4
    SQSHLU  V2.16B, V4.16B, #0x0
    SQRSHRUN S11, D3, #13
    SQSHRN2 V13.16B, V24.8H, #2
    SSHR  V5.8B, V5.8B, #5
    SQSHRN B1, H12, #1
    UQSHRN2 V20.4S, V10.2D, #18
    SSHLL V4.4S, V25.4H, #0x5
    RSHRN2 V3.8H, V25.4S, #3
    UQSHL  H11, H23, H8
    USHR  V13.8B, V0.8B, #8
    SQRSHRUN H5, S2, #6
    MOVI  V8.8B, #0xe1
    SQRSHRN2 V4.16B, V12.8H, #8
    SSRA  V0.2S, V1.2S, #23
    SQSHRN H28, S4, #13
    RSHRN2 V14.4S, V14.2D, #3
    ORR  V20.4H, #0x7c
    SQSHLU  V8.4S, V20.4S, #0x1b
    SQSHLU S10, S8, #0x2
    SSHLL2 V20.2D, V20.4S, #0x7
    SHL  V14.4S, V13.4S, #0x10
    RSHRN V18.8B, V26.8H, #7
    SQRSHRN V4.4H, V19.4S, #2
    SQSHLU D0, D26, #0x31
    SSRA V31.2D, V31.2D, #29
    UQSHRN V14.8B, V3.8H, #4
    UQSHRN V21.4H, V4.4S, #3
    SHL  V19.8H, V18.8H, #0x1
    SQSHL  V6.8B, V28.8B, #0x3
    SHL  V10.8H, V31.8H, #0x5
    SHLL2  V29.4S, V20.8H, #16
    MVNI  V8.2S, #0x4a, LSL #8
    SLI  V14.8H, V16.8H, #0x3
    ORR  V4.4H, #0xff
    RSHRN V5.8B, V14.8H, #8
    SLI  V5.2S, V18.2S, #0x15
    USHLL2 V31.4S, V20.8H, #0xd
    MOVI  V25.16B, #0x2
    SQSHRUN2 V29.4S, V14.2D, #3
    ORR  V19.4S, #0x17, LSL #16
    UQRSHRN2 V2.4S, V19.2D, #27
    UQRSHRN2 V15.4S, V28.2D, #10
    SQRSHRN S10, D15, #14
    USRA  V8.8B, V28.8B, #7
    SSRA  V27.4H, V17.4H, #9
    SRI  V21.4S, V17.4S, #28
    SQSHLU H13, H13, #0x3
    UQSHRN V8.4H, V16.4S, #16
    SQRSHRUN S8, D21, #12
    SHL V5.2D, V19.2D, #0x34
    BIC  V19.2S, #0x25, LSL #24
    SQSHRN2 V29.8H, V29.4S, #14
    USHR  V16.16B, V10.16B, #2
    SRI  V28.4S, V0.4S, #5
    SSHR D2, D22, #14
    SLI  V4.16B, V4.16B, #0x6
    SSHLL V22.2D, V22.2S, #0x10
    SQSHRN V1.2S, V21.2D, #17
    SRSRA  V19.2S, V13.2S, #14
    SHRN V13.8B, V22.8H, #2
    SQRSHRN B26, H3, #6
    SQSHRUN V13.4H, V2.4S, #7
    USHR  V27.16B, V14.16B, #3
    FMOV  V29.2D, #-6.50000000
    SSHR  V21.8H, V15.8H, #15
    ORR  V30.4H, #0x3c
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdAritheticP01_label_579
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D2
    MOVZ  X21, #0x8000, LSL #0
    MOVK  X21, #0x3, LSL #16
    MOVK  X21, #0x8000, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X18, X21, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X23, #0x4040, LSL #0
    MOVK  X23, #0x4040, LSL #16
    SUB  X5, X23, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D4
    MOVZ  X6, #0xff, LSL #0
    MOVK  X6, #0xff, LSL #16
    MOVK  X6, #0xff, LSL #32
    MOVK  X6, #0xff, LSL #48
    SUB  X21, X6, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D6
    MOVZ  X25, #0x10, LSL #0
    SUB  X19, X25, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X8, #0xf700, LSL #0
    MOVK  X8, #0xf700, LSL #32
    SUB  X12, X8, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D9
    MOVZ  X8, #0xf700, LSL #0
    MOVK  X8, #0xf700, LSL #32
    SUB  X12, X8, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D12
    MOVZ  X24, #0x8000, LSL #0
    SUB  X26, X24, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D13
    MOVZ  X19, #0x700, LSL #0
    SUB  X7, X19, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D14
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7, LSL #32
    SUB  X18, X9, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D16
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D19
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x17, LSL #16
    MOVK  X14, #0x17, LSL #48
    SUB  X7, X14, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D20
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xe000, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X26, X20, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D22
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xe000, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X26, X20, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D23
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X23, #0x202, LSL #0
    MOVK  X23, #0x202, LSL #16
    MOVK  X23, #0x202, LSL #32
    MOVK  X23, #0x202, LSL #48
    SUB  X5, X23, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D25
    MOVZ  X23, #0x202, LSL #0
    MOVK  X23, #0x202, LSL #16
    MOVK  X23, #0x202, LSL #32
    MOVK  X23, #0x202, LSL #48
    SUB  X5, X23, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D26
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X24
    FMOV  D1, X7
    FMOV  V1.D[1], X26
    FMOV  D2, X10
    FMOV  V2.D[1], X23
    FMOV  D3, X14
    FMOV  V3.D[1], X27
    FMOV  D4, X4
    FMOV  V4.D[1], X20
    FMOV  D5, X22
    FMOV  V5.D[1], X4
    FMOV  D6, X8
    FMOV  V6.D[1], X17
    FMOV  D7, X23
    FMOV  V7.D[1], X9
    FMOV  D8, X23
    FMOV  V8.D[1], X15
    FMOV  D9, X15
    FMOV  V9.D[1], X8
    FMOV  D10, X9
    FMOV  V10.D[1], X2
    FMOV  D11, X13
    FMOV  V11.D[1], X2
    FMOV  D12, X18
    FMOV  V12.D[1], X18
    FMOV  D13, X14
    FMOV  V13.D[1], X18
    FMOV  D14, X20
    FMOV  V14.D[1], X24
    FMOV  D15, X6
    FMOV  V15.D[1], X10
    FMOV  D16, X26
    FMOV  V16.D[1], X6
    FMOV  D17, X22
    FMOV  V17.D[1], X2
    FMOV  D18, X9
    FMOV  V18.D[1], X26
    FMOV  D19, X10
    FMOV  V19.D[1], X3
    FMOV  D20, X7
    FMOV  V20.D[1], X15
    FMOV  D21, X19
    FMOV  V21.D[1], X10
    FMOV  D22, X15
    FMOV  V22.D[1], X13
    FMOV  D23, X3
    FMOV  V23.D[1], X27
    FMOV  D24, X27
    FMOV  V24.D[1], X6
    FMOV  D25, X10
    FMOV  V25.D[1], X27
    FMOV  D26, X26
    FMOV  V26.D[1], X20
    FMOV  D27, X11
    FMOV  V27.D[1], X24
    FMOV  D28, X14
    FMOV  V28.D[1], X24
    FMOV  D29, X26
    FMOV  V29.D[1], X7
    FMOV  D30, X6
    FMOV  V30.D[1], X9
    FMOV  D31, X16
    FMOV  V31.D[1], X26
    MOVZ  X13, #0xf, LSL #0
TaishanSimdAritheticP01_label_662:
    SHL  V5.8B, V26.8B, #0x2
    MOVI  D30, #18446462603027808255
    SSHLL2 V10.2D, V4.4S, #0x6
    UQRSHRN2 V30.16B, V17.8H, #5
    SQRSHRUN V31.8B, V15.8H, #2
    SRSHR V29.2D, V27.2D, #10
    SHRN2 V28.16B, V15.8H, #8
    SQSHRUN2 V16.8H, V17.4S, #13
    SRSHR D17, D9, #46
    URSRA  V4.8H, V21.8H, #14
    MOVI  V25.4S, #0x8d, LSL #24
    UQSHL  H7, H12, H16
    MVNI  V4.4S, #0x9b
    SQRSHRN2 V3.16B, V23.8H, #8
    URSRA  V26.8B, V6.8B, #7
    SRSHR  V9.8H, V7.8H, #1
    SQSHL H27, H24, #0x5
    SQSHLU S7, S9, #0x1d
    SQSHL D12, D2, #0x21
    MVNI  V13.4S, #0xf8, MSL #16
    SQRSHRUN V25.2S, V24.2D, #28
    SQSHL S14, S19, #0x16
    SLI V2.2D, V24.2D, #0x24
    SLI  V17.4H, V29.4H, #0x3
    SQRSHRN2 V9.4S, V10.2D, #25
    URSRA  V19.2S, V11.2S, #16
    RSHRN2 V19.16B, V2.8H, #2
    UQSHL H30, H1, #0xf
    SRSHR  V31.8B, V5.8B, #6
    SSRA  V3.8B, V1.8B, #8
    URSRA V11.2D, V5.2D, #40
    UQRSHRN2 V30.16B, V21.8H, #1
    MOVI  V30.4H, #0xdb
    SHL  V8.4S, V4.4S, #0x19
    RSHRN2 V29.16B, V11.8H, #7
    SQSHL  V24.8B, V11.8B, #0x6
    RSHRN V7.4H, V2.4S, #9
    SSRA D17, D24, #1
    SRI  V4.4H, V9.4H, #2
    SSHR  V21.8H, V4.8H, #9
    SQSHRUN V9.2S, V3.2D, #12
    RSHRN V9.4H, V19.4S, #9
    SLI  V6.8B, V15.8B, #0x0
    UQSHL B21, B10, #0x6
    SQSHRUN V5.8B, V31.8H, #8
    USHLL2 V6.2D, V16.4S, #0x4
    SQRSHRN S4, D2, #9
    SQSHRUN2 V2.8H, V21.4S, #16
    SQSHL B12, B3, #0x2
    SQRSHRN B26, H18, #8
    BIC  V6.8H, #0xce
    USHLL V12.4S, V21.4H, #0x1
    SSHR  V18.4H, V18.4H, #9
    SHL  V8.16B, V30.16B, #0x0
    UQSHL B27, B11, #0x2
    SHRN2 V4.16B, V17.8H, #3
    SHL  V30.16B, V18.16B, #0x4
    UQSHL V17.2D, V1.2D, #0x10
    URSRA  V5.4H, V17.4H, #6
    SSHLL2 V26.8H, V6.16B, #0x1
    SQSHL  V16.8H, V1.8H, #0x1
    MVNI  V18.4S, #0xcc, MSL #8
    USHLL V18.2D, V2.2S, #0x11
    UQSHRN2 V25.16B, V16.8H, #8
    SQRSHRN H13, S11, #10
    SQRSHRUN V25.8B, V9.8H, #5
    SQSHRUN V13.2S, V7.2D, #25
    UQSHL  S26, S13, S19
    URSHR D16, D14, #47
    SHL  V14.16B, V26.16B, #0x7
    UQSHL  V31.8B, V30.8B, #0x7
    MVNI  V0.4S, #0x17, LSL #16
    SHRN V18.2S, V22.2D, #30
    SHRN V19.8B, V16.8H, #6
    SHL D30, D22, #0x1b
    URSRA D27, D14, #52
    SQRSHRN S2, D27, #30
    SQSHLU B5, B22, #0x4
    SQRSHRN V13.4H, V17.4S, #13
    MOVI  V12.2D, #18374967954631622655
    SSRA  V12.16B, V20.16B, #4
    SRI  V15.8B, V0.8B, #6
    SQSHLU V18.2D, V30.2D, #0x33
    USRA  V22.4S, V14.4S, #28
    SQRSHRUN V7.4H, V25.4S, #7
    SHRN2 V13.4S, V7.2D, #5
    USHR D7, D20, #1
    ORR  V20.2S, #0x62
    SQRSHRN V26.4H, V28.4S, #7
    RSHRN2 V17.4S, V27.2D, #15
    MVNI  V20.8H, #0x65
    RSHRN2 V7.4S, V22.2D, #26
    SQRSHRN2 V0.8H, V9.4S, #15
    SQSHL H14, H30, #0xd
    SRI  V19.16B, V24.16B, #2
    SHRN2 V10.8H, V0.4S, #12
    SLI  V0.16B, V22.16B, #0x5
    URSRA  V7.8H, V2.8H, #2
    MOVI  V0.2D, #1095233437695
    USRA D14, D18, #3
    SHLL2  V20.4S, V26.8H, #16
    MOVI  V22.2S, #0x62, LSL #16
    USHLL2 V25.4S, V30.8H, #0x1
    SQSHRUN S15, D8, #18
    SSRA  V24.16B, V27.16B, #3
    SHRN V10.4H, V30.4S, #14
    SQSHLU D9, D2, #0x10
    URSRA V20.2D, V28.2D, #17
    SSHR  V31.16B, V9.16B, #5
    SQRSHRN2 V28.16B, V30.8H, #5
    SQRSHRN B10, H31, #7
    SQSHLU S18, S23, #0x4
    UQSHRN V2.4H, V21.4S, #11
    SSRA  V9.8H, V24.8H, #10
    ORR  V9.4H, #0x53
    URSHR V8.2D, V29.2D, #19
    RSHRN2 V25.4S, V26.2D, #16
    MVNI  V21.4S, #0x8e, MSL #8
    UQSHRN2 V29.4S, V19.2D, #22
    RSHRN2 V26.16B, V3.8H, #8
    UQSHRN V10.4H, V24.4S, #8
    URSHR V18.2D, V17.2D, #57
TaishanSimdAritheticP01_label_359:
    URSRA  V26.8H, V20.8H, #9
    UQSHL V11.2D, V19.2D, #0x8
    BIC  V11.4H, #0x29
    RSHRN2 V28.4S, V3.2D, #17
    SSRA  V28.16B, V15.16B, #6
    USHLL V10.8H, V18.8B, #0x2
    SQSHRN H3, S29, #9
    SQSHL  V27.4S, V2.4S, #0x2
    SQSHRN2 V17.16B, V16.8H, #6
    SQSHL  V11.4H, V2.4H, #0xf
    SQRSHRN S6, D9, #11
    SSHR V2.2D, V26.2D, #63
    UQRSHRN H31, S11, #3
    SQSHRUN2 V5.4S, V21.2D, #21
    URSRA V20.2D, V25.2D, #49
    UQSHRN V12.4H, V31.4S, #9
    SQSHLU  V1.2S, V20.2S, #0x15
    UQSHL B20, B25, #0x0
    UQRSHRN V28.2S, V17.2D, #12
    SHL  V12.4H, V15.4H, #0x6
    SHL  V29.2S, V19.2S, #0x8
    SQSHLU S7, S16, #0x10
    SHL V24.2D, V5.2D, #0x2f
    SHL  V7.8H, V28.8H, #0x5
    USHR  V16.16B, V6.16B, #6
    UQSHL  V20.4S, V14.4S, #0x1f
    SRI D3, D17, #17
    FMOV  V30.4S, #-0.31250000
    SQRSHRN V23.4H, V3.4S, #8
    SSRA D3, D6, #58
    UQRSHRN H1, S19, #13
    UQRSHRN S9, D25, #23
    SQRSHRN H18, S18, #9
    UQSHL  B9, B23, B9
    USRA D31, D3, #24
    UQSHL  V6.8B, V27.8B, #0x7
    SSRA  V2.16B, V25.16B, #5
    SQSHRUN V24.4H, V28.4S, #15
    URSHR  V11.16B, V5.16B, #4
    SRSHR V21.2D, V15.2D, #15
    SLI  V23.2S, V21.2S, #0x0
    BIC  V14.8H, #0x9f, LSL #8
    SQSHRN H5, S19, #8
    SSHR D30, D6, #46
    SHL V13.2D, V3.2D, #0x27
    UQSHRN2 V15.4S, V0.2D, #10
    MOVI  D18, #281474976710400
    BIC  V20.2S, #0x73, LSL #16
    SRI V5.2D, V1.2D, #63
    SRSRA  V0.4H, V13.4H, #14
    UQSHL  V24.4H, V9.4H, #0x9
    SQSHL D28, D29, #0x4
    UQRSHRN V1.8B, V25.8H, #1
    SSHLL V15.4S, V2.4H, #0x7
    UQSHL H2, H26, #0xe
    UQRSHRN V22.8B, V1.8H, #8
    SRI  V20.8B, V21.8B, #1
    SQSHRUN V15.4H, V27.4S, #8
    USHR V1.2D, V9.2D, #3
    UQSHL  V0.2S, V12.2S, V11.2S
    SSHLL2 V7.4S, V12.8H, #0x2
    SQSHL B17, B14, #0x2
    SHRN V26.4H, V13.4S, #11
    RSHRN V24.8B, V1.8H, #8
    SQSHRN2 V17.4S, V28.2D, #9
    SQSHL V5.2D, V12.2D, #0x22
    SHL  V11.8B, V26.8B, #0x4
    USRA  V8.2S, V20.2S, #25
    UQSHL  V29.8B, V22.8B, #0x4
    SSHR  V16.8B, V8.8B, #7
    SQSHRN V27.2S, V26.2D, #1
    UQSHL  S1, S11, S14
    SHL V24.2D, V1.2D, #0x35
    SHRN2 V2.8H, V10.4S, #9
    UQRSHRN2 V14.8H, V18.4S, #10
    UQSHRN V9.8B, V13.8H, #2
    UQSHL  D19, D3, D25
    USHLL V25.2D, V30.2S, #0x10
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdAritheticP01_label_662
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X19, X20, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X5, X18, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X15, X19, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X25, X5, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X19, X8, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X12, X26, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X28, X25, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X10, X6, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X16, X21, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X17, X23, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X11, X5, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X11, X24, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X20, X16, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X21, X26, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X9, X21, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X12, X23, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
TaishanSimdAritheticP01_label_592:
    SUB  X9, X21, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D3
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D5
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0x7fff, LSL #48
    SUB  X25, X3, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
TaishanSimdAritheticP01_label_632:
    FMOV  X25, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D8
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D9
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D11
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D12
    MOVZ  X5, #0xffc0, LSL #0
    MOVK  X5, #0xffc0, LSL #16
    SUB  X26, X5, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x40, LSL #16
    SUB  X28, X4, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D15
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D16
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D18
    MOVZ  X10, #0xff00, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    SUB  X12, X10, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D20
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x1, LSL #16
    SUB  X27, X23, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D21
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x2, LSL #16
    SUB  X11, X26, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D23
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x2, LSL #16
    SUB  X6, X21, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X4
TaishanSimdAritheticP01_label_159:
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D27
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x4a49, LSL #0
    MOVK  X2, #0xdc19, LSL #16
    MOVK  X2, #0xe775, LSL #32
    MOVK  X2, #0xf1be, LSL #48
    MOVZ  X3, #0xc0da, LSL #0
    MOVK  X3, #0xd27e, LSL #16
    MOVK  X3, #0xbebe, LSL #32
    MOVK  X3, #0x8171, LSL #48
    MOVZ  X4, #0x7e5, LSL #0
    MOVK  X4, #0x4368, LSL #16
    MOVK  X4, #0xa700, LSL #32
    MOVK  X4, #0x49e5, LSL #48
    MOVZ  X5, #0x5d18, LSL #0
    MOVK  X5, #0x71bb, LSL #16
    MOVK  X5, #0xfc60, LSL #32
    MOVK  X5, #0x4407, LSL #48
    MOVZ  X6, #0xe4f5, LSL #0
    MOVK  X6, #0x99b5, LSL #16
    MOVK  X6, #0x5879, LSL #32
    MOVK  X6, #0xad76, LSL #48
    MOVZ  X7, #0xf326, LSL #0
    MOVK  X7, #0x3f55, LSL #16
    MOVK  X7, #0xfa60, LSL #32
    MOVK  X7, #0xf5ad, LSL #48
    MOVZ  X8, #0xe83e, LSL #0
    MOVK  X8, #0x8752, LSL #16
    MOVK  X8, #0xfb61, LSL #32
    MOVK  X8, #0xd205, LSL #48
    MOVZ  X9, #0x56f9, LSL #0
    MOVK  X9, #0x6088, LSL #16
    MOVK  X9, #0xf6ed, LSL #32
    MOVK  X9, #0xe639, LSL #48
    MOVZ  X10, #0x9632, LSL #0
    MOVK  X10, #0x4e17, LSL #16
    MOVK  X10, #0x7af7, LSL #32
    MOVK  X10, #0xae59, LSL #48
    MOVZ  X11, #0xc7d7, LSL #0
    MOVK  X11, #0xfe37, LSL #16
    MOVK  X11, #0x32b7, LSL #32
    MOVK  X11, #0x2d39, LSL #48
    MOVZ  X12, #0x2fa2, LSL #0
    MOVK  X12, #0x2575, LSL #16
    MOVK  X12, #0x7a2f, LSL #32
    MOVK  X12, #0xec1c, LSL #48
    MOVZ  X13, #0x572d, LSL #0
    MOVK  X13, #0x219c, LSL #16
    MOVK  X13, #0xc81f, LSL #32
    MOVK  X13, #0x220b, LSL #48
    MOVZ  X14, #0x725d, LSL #0
    MOVK  X14, #0xa601, LSL #16
    MOVK  X14, #0xa909, LSL #32
    MOVK  X14, #0x6835, LSL #48
    MOVZ  X15, #0x4bc8, LSL #0
    MOVK  X15, #0x7e3a, LSL #16
    MOVK  X15, #0x561c, LSL #32
    MOVK  X15, #0xed12, LSL #48
    MOVZ  X16, #0x63a6, LSL #0
    MOVK  X16, #0x925b, LSL #16
    MOVK  X16, #0xedd1, LSL #32
    MOVK  X16, #0x79cd, LSL #48
    MOVZ  X17, #0x9059, LSL #0
    MOVK  X17, #0xf6dc, LSL #16
    MOVK  X17, #0xd75, LSL #32
    MOVK  X17, #0x422f, LSL #48
    MOVZ  X18, #0x99e1, LSL #0
    MOVK  X18, #0x80b9, LSL #16
    MOVK  X18, #0x74be, LSL #32
    MOVK  X18, #0x721c, LSL #48
    MOVZ  X19, #0xa26d, LSL #0
    MOVK  X19, #0x3a05, LSL #16
    MOVK  X19, #0x9118, LSL #32
    MOVK  X19, #0x1d94, LSL #48
    MOVZ  X20, #0xef1a, LSL #0
    MOVK  X20, #0x1883, LSL #16
    MOVK  X20, #0xac18, LSL #32
    MOVK  X20, #0xebb7, LSL #48
    MOVZ  X21, #0xec49, LSL #0
    MOVK  X21, #0x1004, LSL #16
    MOVK  X21, #0xce61, LSL #32
    MOVK  X21, #0xf14, LSL #48
    MOVZ  X22, #0x661e, LSL #0
    MOVK  X22, #0x5609, LSL #16
    MOVK  X22, #0x43a3, LSL #32
    MOVK  X22, #0x4141, LSL #48
    MOVZ  X23, #0x9132, LSL #0
    MOVK  X23, #0xff2c, LSL #16
    MOVK  X23, #0xd47b, LSL #32
    MOVK  X23, #0xb200, LSL #48
    MOVZ  X24, #0xd5b, LSL #0
    MOVK  X24, #0xce32, LSL #16
    MOVK  X24, #0x113d, LSL #32
    MOVK  X24, #0x5cb6, LSL #48
    MOVZ  X25, #0x3997, LSL #0
    MOVK  X25, #0x70bd, LSL #16
    MOVK  X25, #0x6145, LSL #32
    MOVK  X25, #0x31de, LSL #48
    MOVZ  X26, #0x9025, LSL #0
    MOVK  X26, #0x7b75, LSL #16
    MOVK  X26, #0xee0f, LSL #32
    MOVK  X26, #0xcec, LSL #48
    MOVZ  X27, #0x32e8, LSL #0
    MOVK  X27, #0xac1d, LSL #16
    MOVK  X27, #0x657f, LSL #32
    MOVK  X27, #0x393a, LSL #48
    MOVZ  X28, #0xfd84, LSL #0
    MOVK  X28, #0xd9a5, LSL #16
    MOVK  X28, #0xae71, LSL #32
    MOVK  X28, #0x7caf, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X2
    FMOV  D1, X10
    FMOV  V1.D[1], X24
    FMOV  D2, X6
    FMOV  V2.D[1], X3
    FMOV  D3, X25
    FMOV  V3.D[1], X14
    FMOV  D4, X28
    FMOV  V4.D[1], X19
    FMOV  D5, X8
    FMOV  V5.D[1], X22
    FMOV  D6, X28
    FMOV  V6.D[1], X21
    FMOV  D7, X19
    FMOV  V7.D[1], X13
    FMOV  D8, X18
    FMOV  V8.D[1], X19
    FMOV  D9, X14
    FMOV  V9.D[1], X21
    FMOV  D10, X16
    FMOV  V10.D[1], X21
    FMOV  D11, X17
    FMOV  V11.D[1], X20
    FMOV  D12, X8
    FMOV  V12.D[1], X18
    FMOV  D13, X18
    FMOV  V13.D[1], X2
    FMOV  D14, X2
    FMOV  V14.D[1], X25
    FMOV  D15, X6
    FMOV  V15.D[1], X15
    FMOV  D16, X8
    FMOV  V16.D[1], X8
    FMOV  D17, X12
    FMOV  V17.D[1], X22
    FMOV  D18, X14
    FMOV  V18.D[1], X8
    FMOV  D19, X20
    FMOV  V19.D[1], X3
    FMOV  D20, X22
    FMOV  V20.D[1], X9
    FMOV  D21, X22
    FMOV  V21.D[1], X4
    FMOV  D22, X8
    FMOV  V22.D[1], X13
    FMOV  D23, X15
    FMOV  V23.D[1], X15
    FMOV  D24, X13
    FMOV  V24.D[1], X7
    FMOV  D25, X5
    FMOV  V25.D[1], X16
    FMOV  D26, X20
    FMOV  V26.D[1], X7
    FMOV  D27, X11
    FMOV  V27.D[1], X22
    FMOV  D28, X20
    FMOV  V28.D[1], X12
    FMOV  D29, X7
    FMOV  V29.D[1], X7
    FMOV  D30, X15
    FMOV  V30.D[1], X11
    FMOV  D31, X14
    FMOV  V31.D[1], X23
    MOVZ  X6, #0xa, LSL #0
TaishanSimdAritheticP01_label_745:
    SQSHRUN V22.8B, V28.8H, #7
    SQSHRN2 V6.16B, V29.8H, #8
    UQSHL  V21.2S, V25.2S, #0x18
    MOVI  V10.2D, #72056498821267200
    SQSHLU D1, D22, #0x3c
    FMOV  V21.2D, #0.81250000
    RSHRN V8.4H, V30.4S, #8
    USRA  V21.4S, V14.4S, #24
    UQSHL  B14, B20, B1
    URSRA  V6.2S, V31.2S, #24
    UQRSHRN2 V6.16B, V5.8H, #4
    SQSHRN B20, H1, #4
    UQSHL D4, D0, #0x0
    SHRN2 V16.8H, V25.4S, #16
    UQRSHRN V15.4H, V1.4S, #1
    MOVI  V19.16B, #0xc7
    SQSHRN2 V27.4S, V10.2D, #19
    SSRA D12, D29, #1
    UQSHL  B18, B26, B28
    FMOV  V10.2D, #3.87500000
    SSHLL V17.2D, V1.2S, #0x1e
    SQRSHRUN S2, D31, #6
    SRSRA D16, D8, #35
    SQSHRUN2 V20.4S, V13.2D, #15
    SHRN V27.4H, V19.4S, #14
    SQRSHRUN2 V14.8H, V9.4S, #12
    UQRSHRN2 V2.8H, V12.4S, #13
    SQRSHRN2 V29.4S, V31.2D, #3
    SQRSHRUN2 V19.4S, V2.2D, #22
    UQRSHRN V20.2S, V26.2D, #15
    UQRSHRN2 V10.16B, V29.8H, #2
    FMOV  V10.2S, #-1.56250000
    SQSHLU  V17.4S, V8.4S, #0x17
    USHLL V26.8H, V13.8B, #0x2
    SQSHL S22, S27, #0xa
    SQSHLU  V27.8H, V11.8H, #0x4
    UQSHRN B20, H21, #5
    ORR  V31.2S, #0x1, LSL #8
    UQSHL  V29.2S, V2.2S, #0xd
    SLI D0, D11, #0x28
    SSHR D19, D2, #60
    SQRSHRN V26.8B, V27.8H, #3
    USRA  V3.16B, V10.16B, #5
    UQSHL  V3.4S, V29.4S, #0x12
    UQSHL  S14, S30, S26
    UQSHL  S22, S19, S29
    SSRA  V9.8B, V0.8B, #7
    SLI D29, D21, #0x3
    SQSHLU  V17.16B, V10.16B, #0x0
    SQSHL D19, D0, #0x1a
    RSHRN V0.2S, V19.2D, #9
    BIC  V14.2S, #0xdc, LSL #8
    SQSHRUN2 V30.16B, V11.8H, #3
    SHL  V11.16B, V2.16B, #0x1
    SQRSHRUN V11.4H, V31.4S, #9
    SQRSHRUN2 V19.8H, V29.4S, #10
    SQRSHRUN B4, H26, #8
    SRSHR D26, D9, #13
    SQRSHRUN2 V31.8H, V13.4S, #16
    UQRSHRN V4.8B, V9.8H, #2
    SQSHRN2 V17.4S, V3.2D, #27
    SQSHRUN2 V28.8H, V0.4S, #14
    SSHR  V10.4H, V8.4H, #10
    SSRA  V21.4S, V15.4S, #21
    RSHRN V11.2S, V0.2D, #30
    UQSHRN S18, D20, #23
    USRA  V31.2S, V29.2S, #18
    MOVI  V2.2S, #0x29, MSL #8
    SHRN2 V15.16B, V2.8H, #8
    SQSHRN H27, S20, #4
    UQSHRN2 V23.16B, V22.8H, #6
    SQSHRUN2 V23.4S, V25.2D, #9
    ORR  V8.8H, #0x3e
    SQSHRN S26, D13, #8
    SHL V30.2D, V4.2D, #0x20
    UQSHL S9, S30, #0x1b
    USHLL2 V16.4S, V24.8H, #0xa
    MVNI  V19.4S, #0x61, LSL #24
    UQRSHRN H19, S18, #8
    SQRSHRUN2 V15.4S, V31.2D, #16
    UQSHL  V11.2D, V27.2D, V12.2D
    UQRSHRN2 V11.8H, V11.4S, #16
    RSHRN2 V5.8H, V9.4S, #15
    UQRSHRN B13, H19, #4
    SRI  V25.2S, V31.2S, #29
    UQSHL S23, S27, #0x1b
    SQSHRN2 V24.4S, V30.2D, #26
    SQRSHRN B31, H5, #3
    RSHRN2 V25.8H, V18.4S, #12
    USRA  V2.4H, V8.4H, #1
    USRA D14, D11, #15
    SQSHL S13, S17, #0x1c
    SQSHRN2 V15.8H, V14.4S, #7
    FMOV  V25.2S, #7.25000000
    MOVI  V26.8H, #0x88
    SHRN2 V0.8H, V27.4S, #16
    UQSHRN2 V22.4S, V25.2D, #19
    SSHLL2 V19.2D, V1.4S, #0x15
    SQSHLU H11, H29, #0x6
    SSRA  V15.2S, V16.2S, #24
    MOVI  V15.8H, #0x14, LSL #8
    USRA  V13.8H, V5.8H, #1
    SQRSHRUN B24, H9, #8
    SHRN V30.4H, V19.4S, #9
    SQSHRUN V2.8B, V14.8H, #8
    USRA  V17.4S, V23.4S, #2
    ORR  V13.4H, #0x81, LSL #8
    SQRSHRUN S7, D20, #11
    SQRSHRUN B31, H18, #1
    SLI  V14.2S, V13.2S, #0xa
    FMOV  V21.2S, #-13.00000000
    SRI  V18.16B, V9.16B, #4
    SQSHRUN V13.2S, V14.2D, #14
    RSHRN V7.2S, V13.2D, #14
    UQSHRN V18.2S, V3.2D, #7
    SQSHRN2 V1.4S, V15.2D, #17
    FMOV  V21.2D, #-7.25000000
    SQSHRN2 V3.16B, V17.8H, #3
    UQSHRN H30, S1, #10
    SRSRA  V1.4S, V2.4S, #19
    SQSHRUN2 V13.8H, V26.4S, #8
    UQSHL  B25, B4, B7
    SHRN2 V28.16B, V24.8H, #3
    RSHRN2 V26.16B, V13.8H, #7
    SRSRA  V5.8H, V6.8H, #4
    SQSHRUN V7.4H, V29.4S, #15
    SQSHRUN V18.4H, V1.4S, #15
    MVNI  V15.4H, #0xa5, LSL #8
    SLI  V16.16B, V17.16B, #0x2
    URSHR V28.2D, V29.2D, #48
    ORR  V0.8H, #0x62
    UQSHL H21, H2, #0x5
    URSRA  V11.4H, V16.4H, #3
    BIC  V28.4S, #0x81, LSL #24
    UQSHL S24, S26, #0xb
    UQRSHRN V26.4H, V27.4S, #5
    USRA  V23.8H, V26.8H, #10
    SQRSHRUN B24, H26, #8
    SQSHRUN2 V0.16B, V28.8H, #4
    SSRA  V30.16B, V6.16B, #4
    RSHRN2 V3.4S, V16.2D, #11
    USHLL V8.8H, V11.8B, #0x5
    UQSHRN2 V5.4S, V24.2D, #19
    SQSHL S7, S28, #0x2
    SSRA  V19.4S, V7.4S, #14
    SQSHRN2 V14.8H, V6.4S, #8
    URSRA  V1.16B, V27.16B, #8
    SHRN V23.4H, V16.4S, #4
    SSHLL V26.8H, V19.8B, #0x2
    SQRSHRN2 V10.16B, V26.8H, #4
    SSHR D2, D16, #21
    SLI  V6.2S, V11.2S, #0xc
    UQSHL H13, H10, #0x4
    FMOV  V5.4S, #-1.56250000
    URSHR V5.2D, V14.2D, #24
    SSHR  V21.8B, V24.8B, #3
    USHR D6, D20, #11
    UQSHL  V12.4H, V15.4H, #0x2
    SRSRA V3.2D, V3.2D, #13
    SQRSHRUN2 V24.4S, V8.2D, #8
    SRSRA D23, D5, #50
    MVNI  V20.4H, #0xae, LSL #8
    SQRSHRUN V4.4H, V21.4S, #16
    UQRSHRN S22, D4, #24
    SQSHRN2 V2.16B, V20.8H, #3
    SRI V16.2D, V1.2D, #34
    SRSRA D21, D27, #22
    USHLL V16.8H, V9.8B, #0x5
    SRSRA D11, D6, #46
    SSHLL V10.2D, V20.2S, #0x15
    SQRSHRN V31.8B, V11.8H, #5
    UQRSHRN2 V15.4S, V21.2D, #1
    USRA  V27.8B, V3.8B, #2
    MOVI  D12, #18374966855136706560
    SSRA  V4.16B, V4.16B, #8
    UQRSHRN2 V23.4S, V1.2D, #30
    SRSHR D19, D8, #12
    UQSHRN S20, D17, #32
    SRSHR V5.2D, V16.2D, #41
    FMOV  V2.2S, #20.00000000
    URSRA D27, D0, #4
    SQRSHRN V5.4H, V4.4S, #12
    SQSHL S10, S1, #0xc
    URSRA  V6.16B, V14.16B, #1
    UQSHRN2 V11.8H, V16.4S, #16
    SQSHLU  V15.8H, V13.8H, #0x2
    SRSHR  V6.2S, V2.2S, #12
    SSHR  V17.4S, V26.4S, #7
    RSHRN2 V23.8H, V21.4S, #15
    URSHR  V11.16B, V29.16B, #7
    SHL D19, D13, #0x2d
    SQSHLU H12, H2, #0xf
    USRA D23, D3, #18
    UQSHL  D11, D21, D15
    SLI  V1.2S, V22.2S, #0x13
    SQSHRN2 V6.16B, V14.8H, #7
    RSHRN V1.8B, V20.8H, #4
    MVNI  V0.4H, #0xbb
    UQRSHRN S17, D22, #8
    MVNI  V26.4S, #0x33, LSL #24
    SUBS  X6, X6, #0x1
    B.NE  TaishanSimdAritheticP01_label_745
    MOVZ  X21, #0x4a49, LSL #0
    MOVK  X21, #0xdc19, LSL #16
    MOVK  X21, #0xe775, LSL #32
    MOVK  X21, #0xf1be, LSL #48
    SUB  X25, X21, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0xc0da, LSL #0
    MOVK  X19, #0xd27e, LSL #16
    MOVK  X19, #0xbebe, LSL #32
    MOVK  X19, #0x8171, LSL #48
    SUB  X6, X19, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x7e5, LSL #0
    MOVK  X6, #0x4368, LSL #16
    MOVK  X6, #0xa700, LSL #32
    MOVK  X6, #0x49e5, LSL #48
    SUB  X15, X6, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x5d18, LSL #0
    MOVK  X11, #0x71bb, LSL #16
    MOVK  X11, #0xfc60, LSL #32
    MOVK  X11, #0x4407, LSL #48
    SUB  X16, X11, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x7e5, LSL #0
    MOVK  X7, #0x4368, LSL #16
    MOVK  X7, #0xa700, LSL #32
    MOVK  X7, #0x49e5, LSL #48
    SUB  X3, X7, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x7e5, LSL #0
    MOVK  X7, #0x4368, LSL #16
    MOVK  X7, #0xa700, LSL #32
    MOVK  X7, #0x49e5, LSL #48
    SUB  X2, X7, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0xe83e, LSL #0
    MOVK  X3, #0x8752, LSL #16
    MOVK  X3, #0xfb61, LSL #32
    MOVK  X3, #0xd205, LSL #48
    SUB  X9, X3, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x5d18, LSL #0
    MOVK  X15, #0x71bb, LSL #16
    MOVK  X15, #0xfc60, LSL #32
    MOVK  X15, #0x4407, LSL #48
    SUB  X11, X15, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x2fa2, LSL #0
    MOVK  X20, #0x2575, LSL #16
    MOVK  X20, #0x7a2f, LSL #32
    MOVK  X20, #0xec1c, LSL #48
    SUB  X23, X20, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x725d, LSL #0
    MOVK  X11, #0xa601, LSL #16
    MOVK  X11, #0xa909, LSL #32
    MOVK  X11, #0x6835, LSL #48
    SUB  X27, X11, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x5d18, LSL #0
    MOVK  X7, #0x71bb, LSL #16
    MOVK  X7, #0xfc60, LSL #32
    MOVK  X7, #0x4407, LSL #48
    SUB  X13, X7, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x9059, LSL #0
    MOVK  X26, #0xf6dc, LSL #16
    MOVK  X26, #0xd75, LSL #32
    MOVK  X26, #0x422f, LSL #48
    SUB  X11, X26, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0xc0da, LSL #0
    MOVK  X22, #0xd27e, LSL #16
    MOVK  X22, #0xbebe, LSL #32
    MOVK  X22, #0x8171, LSL #48
    SUB  X24, X22, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x2fa2, LSL #0
    MOVK  X25, #0x2575, LSL #16
    MOVK  X25, #0x7a2f, LSL #32
    MOVK  X25, #0xec1c, LSL #48
    SUB  X12, X25, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x4a49, LSL #0
    MOVK  X15, #0xdc19, LSL #16
    MOVK  X15, #0xe775, LSL #32
    MOVK  X15, #0xf1be, LSL #48
    SUB  X12, X15, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0xc0da, LSL #0
    MOVK  X11, #0xd27e, LSL #16
    MOVK  X11, #0xbebe, LSL #32
    MOVK  X11, #0x8171, LSL #48
    SUB  X4, X11, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x2fa2, LSL #0
    MOVK  X20, #0x2575, LSL #16
    MOVK  X20, #0x7a2f, LSL #32
    MOVK  X20, #0xec1c, LSL #48
    SUB  X22, X20, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x9059, LSL #0
    MOVK  X4, #0xf6dc, LSL #16
    MOVK  X4, #0xd75, LSL #32
    MOVK  X4, #0x422f, LSL #48
    SUB  X19, X4, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D2
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x41a0, LSL #16
    MOVK  X6, #0x41a0, LSL #48
    SUB  X3, X6, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X7, #0x6063, LSL #0
    MOVK  X7, #0x300, LSL #16
    MOVK  X7, #0x6063, LSL #32
    SUB  X13, X7, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D3
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0x7, LSL #16
    MOVK  X7, #0x1, LSL #32
    SUB  X13, X7, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D4
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X16, #0x402, LSL #0
    MOVK  X16, #0x400, LSL #16
    MOVK  X16, #0x808, LSL #32
    SUB  X26, X16, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D6
    MOVZ  X16, #0x1a00, LSL #0
    MOVK  X16, #0x4, LSL #16
    MOVK  X16, #0x1a00, LSL #32
    MOVK  X16, #0x4, LSL #48
    SUB  X26, X16, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D7
    MOVZ  X2, #0xfd40, LSL #0
    MOVK  X2, #0x3, LSL #16
    SUB  X17, X2, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V8.D[1]
TaishanSimdAritheticP01_label_299:
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xc00, LSL #32
    SUB  X18, X22, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D8
    MOVZ  X22, #0x1800, LSL #0
    MOVK  X22, #0xa0, LSL #16
    MOVK  X22, #0xc00, LSL #32
    SUB  X18, X22, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D10
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X20, #0x41a, LSL #0
    MOVK  X20, #0x41a, LSL #16
    SUB  X27, X20, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D14
    MOVZ  X20, #0x100, LSL #0
    MOVK  X20, #0x204, LSL #16
    MOVK  X20, #0x204, LSL #48
    SUB  X27, X20, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D15
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D18
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X11, X16, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D23
    MOVZ  X16, #0x7001, LSL #0
    MOVK  X16, #0x3000, LSL #16
    MOVK  X16, #0x3007, LSL #32
    MOVK  X16, #0x3000, LSL #48
    SUB  X9, X16, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X20, X16, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D25
    MOVZ  X14, #0xff, LSL #0
    SUB  X23, X14, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xccff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xccff, LSL #48
    SUB  X2, X9, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D26
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xccff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xccff, LSL #48
    SUB  X2, X9, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D27
    MOVZ  X22, #0x5f45, LSL #0
    MOVK  X22, #0x2007, LSL #16
    MOVK  X22, #0x2006, LSL #32
    MOVK  X22, #0x6, LSL #48
    SUB  X3, X22, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D28
    MOVZ  X25, #0xff50, LSL #0
    SUB  X24, X25, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X5
    FMOV  V0.D[1], X2
    FMOV  D1, X27
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X3
    FMOV  D3, X10
    FMOV  V3.D[1], X23
    FMOV  D4, X18
    FMOV  V4.D[1], X16
    FMOV  D5, X16
    FMOV  V5.D[1], X20
    FMOV  D6, X15
    FMOV  V6.D[1], X6
    FMOV  D7, X21
    FMOV  V7.D[1], X16
    FMOV  D8, X22
    FMOV  V8.D[1], X16
    FMOV  D9, X21
    FMOV  V9.D[1], X22
    FMOV  D10, X4
    FMOV  V10.D[1], X25
    FMOV  D11, X18
    FMOV  V11.D[1], X23
    FMOV  D12, X12
    FMOV  V12.D[1], X20
    FMOV  D13, X16
    FMOV  V13.D[1], X2
    FMOV  D14, X2
    FMOV  V14.D[1], X22
    FMOV  D15, X22
    FMOV  V15.D[1], X9
    FMOV  D16, X16
    FMOV  V16.D[1], X6
    FMOV  D17, X21
    FMOV  V17.D[1], X7
    FMOV  D18, X4
    FMOV  V18.D[1], X28
    FMOV  D19, X12
    FMOV  V19.D[1], X13
    FMOV  D20, X20
    FMOV  V20.D[1], X6
    FMOV  D21, X17
    FMOV  V21.D[1], X5
    FMOV  D22, X27
    FMOV  V22.D[1], X17
    FMOV  D23, X28
    FMOV  V23.D[1], X28
    FMOV  D24, X18
    FMOV  V24.D[1], X2
    FMOV  D25, X12
    FMOV  V25.D[1], X4
    FMOV  D26, X15
    FMOV  V26.D[1], X26
    FMOV  D27, X7
    FMOV  V27.D[1], X16
    FMOV  D28, X24
    FMOV  V28.D[1], X25
    FMOV  D29, X23
    FMOV  V29.D[1], X20
    FMOV  D30, X11
    FMOV  V30.D[1], X2
    FMOV  D31, X20
    FMOV  V31.D[1], X2
    MOVZ  X13, #0xa, LSL #0
TaishanSimdAritheticP01_label_827:
    SRSHR V24.2D, V13.2D, #43
    UQSHRN V31.8B, V6.8H, #6
    UQSHL  B30, B22, B25
    SQSHRUN B24, H23, #6
    USRA D26, D24, #13
    SRI  V14.4H, V28.4H, #3
    SHL  V20.2S, V13.2S, #0x1b
    UQRSHRN H18, S1, #3
    SSHR  V10.2S, V5.2S, #24
    SRSRA  V30.4S, V12.4S, #27
    SRI D29, D21, #63
    UQSHRN H7, S14, #9
    UQSHL H26, H29, #0xf
    URSHR D7, D10, #33
    SRSHR V15.2D, V30.2D, #14
    SQRSHRUN V29.4H, V31.4S, #2
    URSRA V2.2D, V29.2D, #49
    UQSHL  V25.16B, V13.16B, #0x4
    USRA D29, D27, #6
    UQSHL  V14.2S, V26.2S, #0x14
    SQRSHRN2 V25.8H, V31.4S, #9
    SRI  V15.4S, V1.4S, #10
    UQRSHRN S31, D29, #31
    SSHR D18, D1, #63
    UQSHL  V30.8H, V2.8H, #0x4
    SQSHRN2 V4.4S, V12.2D, #21
    UQSHRN V0.2S, V19.2D, #15
    SSRA V15.2D, V24.2D, #27
    SRSHR  V22.8B, V1.8B, #5
    SRSHR  V9.16B, V13.16B, #8
    USHR  V23.8H, V14.8H, #14
    UQRSHRN V16.2S, V2.2D, #13
    SLI  V12.4H, V5.4H, #0x3
    SQRSHRN2 V24.4S, V17.2D, #15
    SRSHR V8.2D, V4.2D, #6
    SHLL2  V20.8H, V23.16B, #8
    MVNI  V18.4S, #0xcd, LSL #8
    SHL  V6.2S, V22.2S, #0x6
    UQRSHRN V7.2S, V23.2D, #9
    SRSRA D24, D26, #60
    BIC  V3.8H, #0xf, LSL #8
    URSRA D22, D3, #62
    SRSHR D31, D19, #61
    SRI  V2.4S, V0.4S, #30
    SQSHLU V18.2D, V27.2D, #0x1e
    RSHRN2 V21.4S, V3.2D, #2
    SSRA D3, D25, #8
    SQRSHRUN V3.4H, V31.4S, #8
    UQSHRN V25.8B, V23.8H, #1
    UQSHRN S10, D26, #23
    SSHR  V1.4S, V4.4S, #1
    UQSHL  H3, H19, H10
    SQRSHRUN2 V17.16B, V6.8H, #7
    URSRA  V0.4S, V1.4S, #32
    SSRA  V25.4S, V19.4S, #3
    SQSHRUN2 V1.4S, V11.2D, #25
    UQSHRN2 V7.8H, V22.4S, #10
    SQSHRN2 V2.4S, V9.2D, #21
    SSHR  V21.4H, V0.4H, #1
    RSHRN V27.4H, V4.4S, #13
    SSHR  V15.2S, V10.2S, #1
    SLI D25, D19, #0x2d
    SHL  V26.8H, V17.8H, #0xc
    SQSHL D11, D8, #0x5
    SHRN V15.2S, V15.2D, #21
    SQRSHRN2 V20.16B, V0.8H, #2
    SRSRA V16.2D, V0.2D, #25
    ORR  V19.4H, #0x4b
    UQSHL  V14.8B, V20.8B, #0x1
    UQRSHRN2 V10.16B, V6.8H, #6
    USRA D7, D20, #1
    UQSHL S14, S25, #0xc
    USRA  V13.4S, V24.4S, #2
    UQSHL  H18, H7, H15
    SSHR  V21.4S, V10.4S, #7
    SRI  V9.4S, V3.4S, #14
    SQSHLU V9.2D, V6.2D, #0x1c
    SRSRA D5, D7, #6
    SQRSHRN2 V30.16B, V7.8H, #8
    SQSHRN B6, H21, #1
    MOVI  V19.2D, #18446463693949566720
    SSRA D30, D25, #64
    SSHR D25, D23, #26
    URSRA  V14.16B, V13.16B, #1
    USRA  V21.16B, V8.16B, #3
    SQSHRN B10, H14, #8
    SRSHR  V9.4S, V5.4S, #5
    URSRA V3.2D, V24.2D, #35
    SRSRA  V14.8H, V26.8H, #14
    SLI  V18.8H, V5.8H, #0x3
    SSRA  V21.8B, V3.8B, #8
    RSHRN V19.8B, V14.8H, #2
    BIC  V6.4S, #0xbe, LSL #24
    SHRN V30.2S, V8.2D, #22
    SQSHLU  V25.4H, V5.4H, #0xc
    SLI  V26.4H, V25.4H, #0x2
    SQSHL  V30.8B, V15.8B, #0x3
    UQSHL S11, S23, #0x15
    SQSHRUN V10.8B, V8.8H, #5
    URSRA  V26.4H, V15.4H, #6
    BIC  V16.4S, #0xf5
    SSHLL2 V30.4S, V23.8H, #0x3
    SRSRA V5.2D, V5.2D, #25
    SHLL2  V11.2D, V2.4S, #32
    SHRN2 V20.4S, V27.2D, #26
    SQSHL V7.2D, V23.2D, #0x0
    UQSHRN V2.2S, V18.2D, #21
    SHL V16.2D, V14.2D, #0x12
    MVNI  V1.2S, #0x1b, LSL #16
    SSRA D16, D8, #19
    SQRSHRUN2 V3.8H, V12.4S, #8
    UQRSHRN S17, D24, #16
    SQSHL B11, B14, #0x0
    SQRSHRN H8, S25, #11
    SQSHRUN2 V15.16B, V1.8H, #5
    MOVI  V3.8B, #0x4
    USRA  V1.2S, V23.2S, #16
    MVNI  V15.2S, #0xe4
    SSHLL2 V8.2D, V6.4S, #0x13
    SRI V26.2D, V9.2D, #3
    SRSHR D11, D1, #25
    UQSHRN S0, D26, #25
    SQRSHRUN B17, H7, #7
    UQSHRN V21.8B, V23.8H, #5
    SQSHRN V4.8B, V6.8H, #3
    SQRSHRN2 V29.4S, V12.2D, #32
    SQSHL S28, S24, #0xa
    SRSRA  V11.16B, V3.16B, #7
    USHR  V20.4S, V8.4S, #30
    MOVI  D26, #18374966855136771840
    URSRA  V5.8H, V1.8H, #4
    MOVI  V10.8B, #0x66
    SHL  V10.4H, V23.4H, #0x3
    RSHRN V24.2S, V4.2D, #30
    UQSHL V13.2D, V31.2D, #0x4
    SHRN2 V19.4S, V17.2D, #14
    SQRSHRUN B3, H12, #2
    SQSHRUN B25, H24, #6
    SHL  V14.2S, V9.2S, #0x1c
    UQSHL  H4, H8, H14
    SLI  V20.8H, V13.8H, #0x0
    SLI  V19.8B, V3.8B, #0x0
    URSHR V10.2D, V21.2D, #31
    USRA  V28.8B, V6.8B, #1
    UQSHL  D7, D12, D12
    SQSHL V7.2D, V20.2D, #0x3c
    UQSHL  V12.8B, V22.8B, V31.8B
    SSRA V14.2D, V2.2D, #27
    SRI  V8.4S, V24.4S, #25
    SQSHRN V23.4H, V7.4S, #4
    SRI V9.2D, V17.2D, #63
    SSHR  V25.8B, V17.8B, #2
    UQSHL  D13, D8, D14
    SQSHRUN2 V27.8H, V27.4S, #13
    URSRA  V28.8B, V1.8B, #6
    MOVI  V15.2S, #0xfe, MSL #8
    RSHRN V3.4H, V10.4S, #11
    SQRSHRUN H31, S30, #9
    SRI  V22.16B, V14.16B, #7
    MOVI  V3.2D, #4278190335
    RSHRN2 V5.16B, V27.8H, #6
    SQSHRN2 V20.4S, V0.2D, #2
    UQSHL B21, B2, #0x0
    UQSHL V17.2D, V2.2D, #0x9
    UQSHRN V22.2S, V1.2D, #14
    SQRSHRUN2 V17.4S, V30.2D, #3
    USRA  V10.8H, V22.8H, #16
    SRI D20, D16, #47
    SQRSHRN2 V23.16B, V24.8H, #4
    SSHR V7.2D, V29.2D, #2
    UQSHRN H7, S21, #1
    USHLL V20.4S, V20.4H, #0xb
    SQSHRN H31, S20, #13
    SHL  V5.2S, V8.2S, #0xc
    SQRSHRN H1, S9, #8
    SHL D0, D9, #0x3e
    MOVI  D0, #71776123339407360
    SQSHRN2 V8.4S, V8.2D, #11
    MOVI  V20.4S, #0xe1, MSL #16
    BIC  V6.2S, #0xfe, LSL #16
    SQRSHRUN V14.2S, V8.2D, #29
    SQSHL  V1.8B, V5.8B, #0x7
    UQRSHRN V7.8B, V24.8H, #6
    MOVI  V31.2D, #71776119077928960
    UQSHL  V26.16B, V20.16B, #0x7
    SRI  V9.8B, V21.8B, #6
    UQSHRN2 V2.4S, V10.2D, #21
    RSHRN V10.8B, V8.8H, #4
    UQSHL  V6.2S, V15.2S, #0x1c
    RSHRN V14.4H, V16.4S, #16
    SSHR  V16.2S, V29.2S, #25
    URSHR V29.2D, V27.2D, #28
    SQSHRN V22.4H, V21.4S, #11
    UQSHRN B20, H1, #4
    SQSHL  V31.8H, V19.8H, #0x4
    SSHLL V17.2D, V25.2S, #0x18
    SQSHL B20, B26, #0x4
    SSRA  V27.8B, V13.8B, #2
    USHLL2 V13.2D, V10.4S, #0x8
    USHLL2 V0.4S, V15.8H, #0x1
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdAritheticP01_label_827
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X17, X11, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X27, #0xff, LSL #0
    MOVK  X27, #0xff00, LSL #16
    SUB  X24, X27, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D3
    MOVZ  X27, #0xff, LSL #0
    MOVK  X27, #0xff00, LSL #16
    SUB  X24, X27, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D6
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X14, X25, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D7
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D9
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D11
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xf280, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X22, X13, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D15
    MOVZ  X17, #0xfeff, LSL #0
    MOVK  X17, #0xfeff, LSL #32
    SUB  X5, X17, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D20
    MOVZ  X13, #0xf0, LSL #0
    SUB  X2, X13, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D21
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D25
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xff, LSL #48
    SUB  X28, X8, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D26
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xff, LSL #48
    SUB  X28, X8, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D28
    MOVZ  X7, #0x404, LSL #0
    MOVK  X7, #0x404, LSL #16
    MOVK  X7, #0x404, LSL #32
    MOVK  X7, #0x404, LSL #48
    SUB  X17, X7, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
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
TaishanSimdAritheticP01_label_217:
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
    FMOV  D0, X27
    FMOV  V0.D[1], X11
    FMOV  D1, X6
    FMOV  V1.D[1], X26
    FMOV  D2, X25
    FMOV  V2.D[1], X22
    FMOV  D3, X5
    FMOV  V3.D[1], X21
    FMOV  D4, X10
    FMOV  V4.D[1], X4
    FMOV  D5, X13
    FMOV  V5.D[1], X28
    FMOV  D6, X26
    FMOV  V6.D[1], X12
    FMOV  D7, X21
    FMOV  V7.D[1], X25
    FMOV  D8, X5
    FMOV  V8.D[1], X14
    FMOV  D9, X23
    FMOV  V9.D[1], X26
    FMOV  D10, X11
    FMOV  V10.D[1], X13
    FMOV  D11, X28
    FMOV  V11.D[1], X21
    FMOV  D12, X12
    FMOV  V12.D[1], X25
    FMOV  D13, X4
    FMOV  V13.D[1], X19
    FMOV  D14, X24
    FMOV  V14.D[1], X10
    FMOV  D15, X20
    FMOV  V15.D[1], X26
    FMOV  D16, X4
    FMOV  V16.D[1], X8
    FMOV  D17, X7
    FMOV  V17.D[1], X28
    FMOV  D18, X12
    FMOV  V18.D[1], X8
    FMOV  D19, X25
    FMOV  V19.D[1], X13
    FMOV  D20, X22
    FMOV  V20.D[1], X21
    FMOV  D21, X23
    FMOV  V21.D[1], X17
    FMOV  D22, X22
    FMOV  V22.D[1], X9
    FMOV  D23, X28
    FMOV  V23.D[1], X11
    FMOV  D24, X7
    FMOV  V24.D[1], X7
    FMOV  D25, X26
    FMOV  V25.D[1], X21
    FMOV  D26, X4
    FMOV  V26.D[1], X11
    FMOV  D27, X13
    FMOV  V27.D[1], X19
    FMOV  D28, X3
    FMOV  V28.D[1], X23
    FMOV  D29, X22
    FMOV  V29.D[1], X9
    FMOV  D30, X21
    FMOV  V30.D[1], X28
    FMOV  D31, X28
    FMOV  V31.D[1], X7
    MOVZ  X17, #0xf, LSL #0
TaishanSimdAritheticP01_label_909:
    SQSHL H18, H26, #0xb
    SQRSHRUN V17.2S, V0.2D, #21
    USHLL2 V4.8H, V9.16B, #0x5
    SSRA  V14.8H, V24.8H, #9
    SHLL  V18.4S, V4.4H, #16
    USHR  V23.4S, V14.4S, #20
    MVNI  V22.4S, #0x2
    SQSHL S17, S21, #0x1
    SQSHL  V11.16B, V5.16B, #0x6
    RSHRN2 V28.4S, V23.2D, #5
    SSHR  V5.4H, V14.4H, #13
    SRSRA D11, D9, #53
    SQRSHRN V30.8B, V28.8H, #3
    UQSHRN2 V26.4S, V6.2D, #14
    MOVI  V26.4H, #0xd8
    SQSHL V21.2D, V14.2D, #0x3e
    SLI V30.2D, V26.2D, #0x33
    SQSHRN V9.4H, V27.4S, #3
    USHR  V31.16B, V23.16B, #8
    SLI  V18.4H, V0.4H, #0x3
    SSRA  V22.4H, V6.4H, #5
    URSRA V5.2D, V21.2D, #51
    SSHLL V22.4S, V25.4H, #0xd
    RSHRN V22.2S, V29.2D, #16
    SSHLL V26.4S, V11.4H, #0xb
    SQSHRN B22, H0, #7
    SQSHLU  V3.8B, V24.8B, #0x0
    SQSHRUN2 V29.16B, V15.8H, #5
    URSHR  V16.2S, V1.2S, #17
    UQSHL H17, H18, #0xb
    UQSHL D31, D28, #0x2d
    SQSHL S15, S27, #0x18
    SSRA V19.2D, V28.2D, #21
    SQRSHRUN H13, S0, #14
    SRSRA D3, D2, #36
    UQSHL B8, B22, #0x4
    UQSHL B28, B22, #0x3
    MOVI  V8.2S, #0xa4
    SRI D8, D14, #30
    SRSRA V24.2D, V29.2D, #9
    SSHLL V17.8H, V17.8B, #0x1
    SSHLL V23.8H, V4.8B, #0x3
    SQRSHRN V14.2S, V4.2D, #8
    RSHRN2 V27.16B, V13.8H, #5
    SQRSHRN2 V15.4S, V18.2D, #28
    SQRSHRN S0, D22, #22
    UQSHRN2 V8.4S, V22.2D, #12
    SHL  V31.8B, V30.8B, #0x5
    UQSHRN V28.8B, V25.8H, #7
    UQRSHRN S3, D13, #18
    SRSHR  V15.16B, V2.16B, #8
    SSHLL2 V11.8H, V21.16B, #0x3
    SRI D19, D29, #36
    ORR  V15.8H, #0x37
    FMOV  V9.2D, #-1.06250000
    USHR  V1.16B, V25.16B, #2
    MOVI  V20.2D, #281470681808640
    SQSHL B14, B12, #0x4
    MVNI  V13.4S, #0x10, LSL #24
    RSHRN2 V22.8H, V8.4S, #8
    ORR  V9.4H, #0x30
    SQRSHRN2 V2.8H, V22.4S, #11
    SQRSHRUN2 V31.8H, V15.4S, #7
    SHL V6.2D, V0.2D, #0x10
    SQSHL  V1.8H, V29.8H, #0x4
    USRA D17, D9, #64
    SSHR  V5.4H, V4.4H, #15
    SQSHLU H0, H13, #0x6
    SSRA V6.2D, V22.2D, #46
    UQSHL  V22.16B, V15.16B, #0x6
    SQSHL  V4.16B, V1.16B, #0x5
    SQSHRUN B28, H12, #7
    SQSHRUN H19, S11, #7
    UQSHRN V29.4H, V26.4S, #14
    SSHR V25.2D, V23.2D, #17
    SRSRA V18.2D, V6.2D, #31
    SRSHR  V13.4S, V11.4S, #12
    SQRSHRUN V6.2S, V10.2D, #4
    SLI  V20.4S, V20.4S, #0xc
    SQRSHRN H16, S1, #2
    UQSHRN S29, D7, #10
    URSRA  V2.4S, V20.4S, #10
    SHLL2  V3.2D, V12.4S, #32
    SQSHRUN2 V9.16B, V10.8H, #8
    SRSRA  V0.2S, V9.2S, #30
    SSRA  V22.16B, V29.16B, #2
    USHLL2 V3.8H, V30.16B, #0x2
    USRA  V18.8H, V2.8H, #2
    UQRSHRN2 V18.8H, V26.4S, #12
    UQSHL H9, H8, #0x7
    SQSHLU V15.2D, V24.2D, #0x19
    SQRSHRUN H10, S6, #8
    UQSHL  V1.8B, V8.8B, #0x5
    SQRSHRUN2 V29.4S, V8.2D, #17
    SQSHRN2 V26.16B, V2.8H, #4
    SSHLL2 V5.4S, V20.8H, #0x6
    SSHR  V5.8H, V0.8H, #10
    SSRA  V13.8H, V5.8H, #9
    UQSHL  B20, B23, B24
    SQSHLU S25, S6, #0xe
    SQSHRN V24.4H, V18.4S, #4
    USHLL V5.8H, V24.8B, #0x2
    SRI  V26.8B, V25.8B, #7
    SSHR  V6.4S, V26.4S, #20
    SQRSHRN B17, H0, #4
    SQRSHRN2 V7.16B, V23.8H, #4
    SHRN V17.2S, V2.2D, #21
    SSRA  V27.16B, V26.16B, #7
    SQRSHRN2 V18.16B, V22.8H, #2
    UQSHRN2 V2.8H, V24.4S, #4
    UQSHRN V18.2S, V2.2D, #18
    UQRSHRN V3.4H, V12.4S, #8
    SQSHLU S21, S19, #0x7
    SRI D22, D22, #48
    SQSHL B11, B31, #0x2
    URSRA V11.2D, V20.2D, #9
    USHLL2 V20.2D, V11.4S, #0x13
    SRSHR V18.2D, V25.2D, #60
    UQSHL S21, S16, #0x0
    SRI  V29.4H, V10.4H, #10
    UQSHRN V5.4H, V19.4S, #2
    FMOV  V15.2D, #-5.00000000
    SSHLL V19.4S, V20.4H, #0xc
    SQSHLU  V11.2S, V27.2S, #0xc
    UQRSHRN V22.8B, V10.8H, #4
    UQSHL  V17.2S, V6.2S, #0x1c
    USRA  V26.8B, V27.8B, #3
    SQSHRN2 V16.8H, V22.4S, #10
    SQSHRN2 V27.8H, V0.4S, #5
    UQRSHRN2 V3.16B, V22.8H, #5
    MOVI  V0.2S, #0x52, LSL #24
    SQRSHRUN H23, S25, #3
    MOVI  D13, #16711935
    UQRSHRN V12.8B, V0.8H, #6
    MOVI  V12.8B, #0x39
    SSHR V23.2D, V18.2D, #10
    SQSHL B22, B12, #0x0
    MVNI  V28.4S, #0x97, LSL #24
    SQSHRN V22.2S, V27.2D, #24
    SLI V17.2D, V26.2D, #0x21
    UQRSHRN B6, H11, #5
    SHRN2 V10.16B, V19.8H, #4
    SRI  V27.16B, V27.16B, #8
    USRA  V7.4H, V16.4H, #8
    UQSHRN S23, D26, #29
    FMOV  V24.2D, #-14.50000000
    SRSRA  V25.16B, V6.16B, #6
    SSRA  V3.2S, V3.2S, #28
    RSHRN2 V22.8H, V31.4S, #11
    UQSHL  D3, D30, D17
    UQSHL  D28, D22, D13
    SRSHR D28, D28, #16
    USHLL2 V30.8H, V7.16B, #0x7
    UQRSHRN V15.8B, V18.8H, #4
    UQSHL D30, D4, #0x27
    UQRSHRN V23.8B, V0.8H, #2
    UQRSHRN V26.8B, V1.8H, #8
    URSRA  V14.4H, V11.4H, #13
    SSHR V2.2D, V28.2D, #57
    SQSHRUN V28.4H, V19.4S, #5
    SRSRA  V24.8B, V18.8B, #3
    USRA  V23.16B, V10.16B, #3
    SRSRA V15.2D, V27.2D, #13
    SHL D13, D2, #0xd
    UQSHL  B30, B27, B10
    UQSHL V0.2D, V3.2D, #0x13
    UQSHRN V15.8B, V21.8H, #6
    SQSHLU B22, B20, #0x4
    SHL  V4.4S, V5.4S, #0x3
    SQSHLU  V25.4H, V30.4H, #0xd
    UQSHRN H13, S9, #4
    SQSHRN2 V13.8H, V25.4S, #1
    SQSHLU D12, D5, #0xe
    SQRSHRUN V26.2S, V2.2D, #25
    SQRSHRUN H14, S3, #8
    SRSHR  V14.4S, V21.4S, #19
    UQRSHRN B22, H28, #8
    UQSHL  V16.2S, V22.2S, #0x17
    URSHR V0.2D, V25.2D, #64
    SQSHRN V18.8B, V23.8H, #7
    UQSHL S15, S22, #0x1c
    SRSRA  V6.2S, V8.2S, #17
    SQSHRN V24.8B, V7.8H, #4
    USHLL V17.8H, V4.8B, #0x2
    UQSHL B23, B14, #0x5
    SQSHLU D21, D9, #0xc
    RSHRN2 V9.16B, V20.8H, #6
    USHR  V25.8H, V5.8H, #15
    SQSHLU B19, B19, #0x3
    SQSHRUN S12, D17, #27
    SRSRA D28, D31, #4
    SQRSHRN2 V5.8H, V8.4S, #11
    SSHR  V22.8B, V19.8B, #6
    USHR  V25.8B, V9.8B, #2
    SQRSHRUN2 V24.8H, V5.4S, #16
    UQSHL  B23, B9, B24
    SHRN V4.8B, V3.8H, #1
    SSHLL2 V28.2D, V15.4S, #0x2
    UQSHL  B0, B21, B7
    URSRA  V31.8H, V0.8H, #11
    SUBS  X17, X17, #0x1
    B.NE  TaishanSimdAritheticP01_label_909
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X25, X22, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X26, X10, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X18, X16, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X26, X28, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X11, X9, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X17, X21, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X8, X10, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X9, X4, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X10, X18, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X11, X21, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X25, X15, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X19, X8, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X3, X9, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X8, X7, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X10, X12, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D3
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x10, LSL #32
    MOVK  X28, #0x6c0, LSL #48
    SUB  X6, X28, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D4
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x6008, LSL #16
    SUB  X24, X14, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D7
    MOVZ  X14, #0x77f, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X18, X14, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D8
    MOVZ  X20, #0x3, LSL #0
    MOVK  X20, #0xa4, LSL #32
    SUB  X19, X20, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X16, X25, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D9
    MOVZ  X25, #0x180, LSL #0
    SUB  X16, X25, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X9, #0x7fff, LSL #0
    SUB  X26, X9, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D13
    MOVZ  X9, #0x18, LSL #0
    SUB  X26, X9, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D14
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D16
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D18
TaishanSimdAritheticP01_label_315:
    MOVZ  X27, #0xfefe, LSL #0
    SUB  X17, X27, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D21
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x18, LSL #16
    SUB  X9, X16, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D23
    MOVZ  X20, #0xff, LSL #0
    SUB  X24, X20, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D24
    MOVZ  X28, #0xff77, LSL #0
    MOVK  X28, #0xffff, LSL #16
    SUB  X17, X28, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D25
    MOVZ  X11, #0x20, LSL #0
    SUB  X3, X11, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D26
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X20, X9, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D27
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xfeff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xfeff, LSL #48
    SUB  X20, X9, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0xd4d1, LSL #0
    MOVK  X2, #0xc3c, LSL #16
    MOVK  X2, #0x7777, LSL #32
    MOVK  X2, #0xb868, LSL #48
    MOVZ  X3, #0xeb07, LSL #0
    MOVK  X3, #0x541a, LSL #16
    MOVK  X3, #0x6632, LSL #32
    MOVK  X3, #0xa1d0, LSL #48
    MOVZ  X4, #0x9b7f, LSL #0
    MOVK  X4, #0x193d, LSL #16
    MOVK  X4, #0x7cd4, LSL #32
    MOVK  X4, #0x7470, LSL #48
    MOVZ  X5, #0xcb3a, LSL #0
    MOVK  X5, #0xe553, LSL #16
    MOVK  X5, #0x6823, LSL #32
    MOVK  X5, #0x81ea, LSL #48
    MOVZ  X6, #0xe89e, LSL #0
    MOVK  X6, #0x8624, LSL #16
    MOVK  X6, #0x2722, LSL #32
    MOVK  X6, #0x865d, LSL #48
    MOVZ  X7, #0xd34c, LSL #0
    MOVK  X7, #0x356f, LSL #16
    MOVK  X7, #0x9f18, LSL #32
    MOVK  X7, #0x6585, LSL #48
    MOVZ  X8, #0x2d3b, LSL #0
    MOVK  X8, #0x24f6, LSL #16
    MOVK  X8, #0x79b1, LSL #32
    MOVK  X8, #0x82e7, LSL #48
    MOVZ  X9, #0x7a52, LSL #0
    MOVK  X9, #0x5ba4, LSL #16
    MOVK  X9, #0xd738, LSL #32
    MOVK  X9, #0xbc7e, LSL #48
    MOVZ  X10, #0xab5c, LSL #0
    MOVK  X10, #0x266a, LSL #16
    MOVK  X10, #0x78c9, LSL #32
    MOVK  X10, #0x7d6f, LSL #48
    MOVZ  X11, #0xf3c7, LSL #0
    MOVK  X11, #0xe88, LSL #16
    MOVK  X11, #0x630d, LSL #32
    MOVK  X11, #0x2067, LSL #48
    MOVZ  X12, #0xfd04, LSL #0
    MOVK  X12, #0x1ae3, LSL #16
    MOVK  X12, #0x9c26, LSL #32
    MOVK  X12, #0x7a21, LSL #48
    MOVZ  X13, #0x7f1b, LSL #0
    MOVK  X13, #0x2e62, LSL #16
    MOVK  X13, #0x5758, LSL #32
    MOVK  X13, #0xaed7, LSL #48
    MOVZ  X14, #0xc02a, LSL #0
    MOVK  X14, #0xac92, LSL #16
    MOVK  X14, #0xff84, LSL #32
    MOVK  X14, #0x1fbe, LSL #48
    MOVZ  X15, #0xcd00, LSL #0
    MOVK  X15, #0x3b87, LSL #16
    MOVK  X15, #0xe185, LSL #32
    MOVK  X15, #0xa0cb, LSL #48
    MOVZ  X16, #0x5d3a, LSL #0
    MOVK  X16, #0x2d2a, LSL #16
    MOVK  X16, #0x336b, LSL #32
    MOVK  X16, #0x978f, LSL #48
    MOVZ  X17, #0x8c3c, LSL #0
    MOVK  X17, #0xb427, LSL #16
    MOVK  X17, #0xc7e2, LSL #32
    MOVK  X17, #0xac78, LSL #48
    MOVZ  X18, #0xcdf4, LSL #0
    MOVK  X18, #0x516d, LSL #16
    MOVK  X18, #0x893b, LSL #32
    MOVK  X18, #0xd0e4, LSL #48
    MOVZ  X19, #0x9ea7, LSL #0
    MOVK  X19, #0xce45, LSL #16
    MOVK  X19, #0xfe33, LSL #32
    MOVK  X19, #0xc87, LSL #48
    MOVZ  X20, #0xd5bf, LSL #0
    MOVK  X20, #0x4b33, LSL #16
    MOVK  X20, #0x4f54, LSL #32
    MOVK  X20, #0x3e39, LSL #48
    MOVZ  X21, #0x8483, LSL #0
    MOVK  X21, #0xa337, LSL #16
    MOVK  X21, #0x3946, LSL #32
    MOVK  X21, #0xc6c4, LSL #48
    MOVZ  X22, #0xdd21, LSL #0
    MOVK  X22, #0x7a56, LSL #16
    MOVK  X22, #0x5088, LSL #32
    MOVK  X22, #0x250d, LSL #48
    MOVZ  X23, #0x4d, LSL #0
    MOVK  X23, #0x4652, LSL #16
    MOVK  X23, #0xffc5, LSL #32
    MOVK  X23, #0x866e, LSL #48
    MOVZ  X24, #0xca58, LSL #0
    MOVK  X24, #0xf200, LSL #16
TaishanSimdAritheticP01_label_18:
    MOVK  X24, #0xdad5, LSL #32
    MOVK  X24, #0x9c2f, LSL #48
    MOVZ  X25, #0xeed2, LSL #0
    MOVK  X25, #0x5772, LSL #16
    MOVK  X25, #0x4ae3, LSL #32
    MOVK  X25, #0x58f2, LSL #48
    MOVZ  X26, #0x6b23, LSL #0
    MOVK  X26, #0x61b6, LSL #16
    MOVK  X26, #0x5a87, LSL #32
    MOVK  X26, #0xd5df, LSL #48
    MOVZ  X27, #0xf5c9, LSL #0
    MOVK  X27, #0x19af, LSL #16
    MOVK  X27, #0x6521, LSL #32
    MOVK  X27, #0x4158, LSL #48
    MOVZ  X28, #0xb0af, LSL #0
    MOVK  X28, #0x8862, LSL #16
    MOVK  X28, #0xad5e, LSL #32
    MOVK  X28, #0xe312, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X9
    FMOV  D1, X26
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X21
    FMOV  V3.D[1], X4
    FMOV  D4, X10
    FMOV  V4.D[1], X17
    FMOV  D5, X2
    FMOV  V5.D[1], X14
    FMOV  D6, X13
    FMOV  V6.D[1], X27
    FMOV  D7, X27
    FMOV  V7.D[1], X20
    FMOV  D8, X18
    FMOV  V8.D[1], X3
    FMOV  D9, X3
    FMOV  V9.D[1], X7
    FMOV  D10, X23
    FMOV  V10.D[1], X28
    FMOV  D11, X21
    FMOV  V11.D[1], X16
    FMOV  D12, X27
    FMOV  V12.D[1], X8
    FMOV  D13, X14
    FMOV  V13.D[1], X21
    FMOV  D14, X9
    FMOV  V14.D[1], X21
    FMOV  D15, X10
    FMOV  V15.D[1], X28
    FMOV  D16, X11
    FMOV  V16.D[1], X3
    FMOV  D17, X18
    FMOV  V17.D[1], X27
    FMOV  D18, X13
    FMOV  V18.D[1], X7
    FMOV  D19, X21
    FMOV  V19.D[1], X12
    FMOV  D20, X10
    FMOV  V20.D[1], X27
    FMOV  D21, X3
    FMOV  V21.D[1], X13
    FMOV  D22, X21
    FMOV  V22.D[1], X15
    FMOV  D23, X21
    FMOV  V23.D[1], X25
    FMOV  D24, X20
    FMOV  V24.D[1], X26
    FMOV  D25, X6
    FMOV  V25.D[1], X2
    FMOV  D26, X2
    FMOV  V26.D[1], X24
    FMOV  D27, X16
    FMOV  V27.D[1], X7
    FMOV  D28, X16
    FMOV  V28.D[1], X20
    FMOV  D29, X12
    FMOV  V29.D[1], X25
    FMOV  D30, X9
    FMOV  V30.D[1], X23
    FMOV  D31, X22
    FMOV  V31.D[1], X10
    MOVZ  X20, #0xa, LSL #0
TaishanSimdAritheticP01_label_992:
    SQRSHRN V11.2S, V20.2D, #20
    USRA  V26.2S, V25.2S, #30
    UQRSHRN H23, S24, #15
    SRSRA  V17.4S, V24.4S, #20
    SSHR  V15.4H, V5.4H, #12
    UQSHRN2 V10.8H, V24.4S, #6
    SQSHLU  V23.8H, V2.8H, #0xe
    SQRSHRUN B16, H22, #4
    SQSHRN H22, S22, #4
    SRI  V26.4H, V13.4H, #6
    SSRA D6, D7, #31
    UQRSHRN2 V8.4S, V23.2D, #15
    UQRSHRN2 V30.4S, V22.2D, #29
    SRI V16.2D, V11.2D, #29
    RSHRN V9.8B, V31.8H, #6
    SHL D18, D2, #0x14
    SRSHR  V30.8B, V26.8B, #3
    UQSHRN2 V24.4S, V15.2D, #20
    MVNI  V22.4S, #0x82
    SQSHLU B10, B0, #0x3
    UQRSHRN2 V18.16B, V12.8H, #6
    SHRN V23.8B, V2.8H, #3
    BIC  V15.4H, #0x4d, LSL #8
    SSHLL2 V0.4S, V18.8H, #0xc
    SQRSHRN V27.2S, V23.2D, #13
    USHLL V9.2D, V4.2S, #0xe
    SQSHL B14, B28, #0x0
    SRSRA  V8.4H, V29.4H, #7
    SQSHL H30, H15, #0x9
    SSHLL2 V16.8H, V6.16B, #0x3
    SQSHLU V26.2D, V2.2D, #0x3a
    SSHLL V18.2D, V2.2S, #0xd
    MVNI  V12.4H, #0x81
    URSHR D14, D23, #16
    SQRSHRN B10, H9, #4
    UQSHL B0, B2, #0x6
    SQRSHRUN H5, S5, #10
    UQSHL V18.2D, V16.2D, #0xd
    SQSHLU S8, S24, #0x8
    SLI V12.2D, V21.2D, #0x3b
    SHLL  V2.8H, V13.8B, #8
    SQSHRN S27, D14, #26
    UQSHL  B31, B5, B12
    SSHR D29, D1, #26
    RSHRN2 V1.16B, V0.8H, #2
    UQSHL  D12, D4, D23
    SRI  V10.4H, V22.4H, #8
    UQSHL  V19.4S, V28.4S, V23.4S
    USHR  V19.8B, V27.8B, #3
    SRSHR V10.2D, V26.2D, #18
    SSRA  V16.4S, V7.4S, #30
    SHLL2  V10.8H, V29.16B, #8
    URSHR V5.2D, V4.2D, #33
    URSRA  V14.4S, V16.4S, #27
    UQSHRN B1, H16, #5
    SRI  V2.2S, V23.2S, #16
    SQSHRUN2 V11.16B, V13.8H, #3
    SQSHRUN V29.8B, V4.8H, #1
    URSRA V31.2D, V10.2D, #5
    SHRN2 V29.4S, V6.2D, #5
    FMOV  V0.2D, #-6.25000000
    SLI  V21.4H, V26.4H, #0x0
    URSRA D31, D0, #10
    MOVI  V19.2S, #0xfa, MSL #16
    SQSHLU H21, H16, #0x6
    UQRSHRN B29, H7, #2
    SQSHLU B18, B19, #0x1
    USHR V26.2D, V18.2D, #33
    SQSHL V21.2D, V21.2D, #0x27
    FMOV  V5.2D, #-2.87500000
    USRA D0, D9, #5
    SHRN V10.4H, V26.4S, #4
    SQSHL  V17.16B, V11.16B, #0x0
    MOVI  V20.8H, #0x41, LSL #8
    SQSHRUN2 V2.4S, V1.2D, #11
    SQSHL H18, H16, #0x9
    SHRN V6.8B, V27.8H, #8
    SSHR  V16.4H, V26.4H, #5
    SQSHRN B21, H3, #2
    SRSRA  V13.8B, V19.8B, #8
    SQSHRN V9.4H, V16.4S, #8
    SSHR  V13.4H, V8.4H, #8
    SQSHLU S4, S14, #0x10
    SQSHLU  V26.2S, V18.2S, #0x1c
    SQRSHRN2 V23.8H, V13.4S, #5
    RSHRN2 V17.8H, V14.4S, #13
    UQSHL  V22.2D, V6.2D, V14.2D
    SRI  V19.8B, V1.8B, #8
    SLI  V9.8B, V3.8B, #0x2
    SQRSHRUN H19, S11, #11
    SHRN2 V14.4S, V6.2D, #7
    USHLL2 V20.8H, V21.16B, #0x1
    SRSRA  V21.8B, V29.8B, #8
    SSHR  V31.2S, V22.2S, #11
    URSHR V7.2D, V5.2D, #27
    SRSHR  V31.4S, V11.4S, #28
    SQSHL  V11.16B, V21.16B, #0x7
    MOVI  V25.2S, #0x5b, LSL #16
    SHL D30, D7, #0x24
    SLI V29.2D, V3.2D, #0x9
    SSHLL V22.2D, V21.2S, #0x2
    SQSHRUN H11, S22, #8
    MVNI  V7.8H, #0xb3, LSL #8
    UQSHRN V1.2S, V24.2D, #11
    SQRSHRUN V5.2S, V13.2D, #10
    SHRN V2.8B, V29.8H, #2
    USHLL2 V3.4S, V0.8H, #0xa
    RSHRN2 V28.4S, V11.2D, #2
    UQRSHRN V11.2S, V22.2D, #28
    SQRSHRUN2 V1.8H, V12.4S, #10
    SQRSHRN2 V16.4S, V26.2D, #7
    ORR  V27.4S, #0x4d, LSL #8
    BIC  V3.8H, #0xbd, LSL #8
    USHR  V24.4S, V5.4S, #32
    URSHR V0.2D, V4.2D, #40
    MOVI  V22.8B, #0xde
    SQSHLU  V5.4H, V18.4H, #0x2
    USRA  V29.2S, V20.2S, #4
    SSHR  V27.2S, V13.2S, #26
    URSRA D22, D27, #17
    SQSHL H0, H18, #0xe
    SSRA D3, D5, #14
    SHLL2  V5.2D, V22.4S, #32
    BIC  V3.2S, #0xf9, LSL #8
    UQSHL  V2.4H, V26.4H, #0x6
    SQSHLU D30, D22, #0x33
    SHL V31.2D, V5.2D, #0x17
    SSRA D2, D19, #58
    SRSHR  V12.4S, V31.4S, #29
    USHR  V24.4H, V30.4H, #9
    USHLL2 V22.2D, V8.4S, #0x1d
    UQSHRN V26.4H, V22.4S, #16
    UQSHL  D23, D2, D0
    SSHLL V11.2D, V11.2S, #0x19
    SQRSHRN2 V8.16B, V27.8H, #5
    SQSHL B15, B26, #0x0
    SQRSHRN H23, S15, #13
    SQRSHRN B28, H8, #6
    SQSHRUN2 V0.16B, V12.8H, #8
    SRSHR V4.2D, V15.2D, #11
    SQSHL B11, B5, #0x4
    UQSHL  D17, D14, D9
    SQSHLU S28, S24, #0x7
    SHL  V28.16B, V17.16B, #0x1
    SQRSHRN2 V28.16B, V28.8H, #7
    SSRA D27, D3, #29
    SHRN V17.8B, V4.8H, #5
    SQSHRUN2 V18.16B, V14.8H, #3
    UQSHL V7.2D, V20.2D, #0x2
    RSHRN2 V7.8H, V24.4S, #2
    RSHRN2 V3.4S, V8.2D, #23
    SSHR D23, D13, #10
    USHR V19.2D, V13.2D, #47
    RSHRN V24.4H, V7.4S, #13
    SQRSHRUN2 V17.16B, V8.8H, #3
    SQSHRN V25.4H, V27.4S, #11
    URSRA  V20.4S, V25.4S, #28
    USRA  V12.4S, V28.4S, #30
    SQRSHRN2 V10.8H, V14.4S, #4
    SSRA D10, D27, #39
    UQSHL V25.2D, V18.2D, #0x1
    SQSHLU V2.2D, V7.2D, #0x35
    RSHRN V17.4H, V11.4S, #10
    SQSHRUN V30.4H, V0.4S, #6
    SQSHRN S8, D28, #20
    URSRA V31.2D, V28.2D, #35
    FMOV  V3.2S, #2.50000000
    SQSHL  V4.8B, V2.8B, #0x7
    UQRSHRN V17.2S, V23.2D, #32
    RSHRN2 V23.16B, V8.8H, #6
    SQSHRN V4.8B, V28.8H, #6
    UQRSHRN V4.8B, V20.8H, #6
    SQSHL  V31.8H, V31.8H, #0xa
    RSHRN2 V23.8H, V22.4S, #7
    UQRSHRN2 V14.8H, V28.4S, #1
    USRA  V6.8H, V27.8H, #5
    SQRSHRUN H7, S24, #15
    SQSHRN V11.4H, V8.4S, #11
    SQRSHRN2 V27.4S, V8.2D, #12
    SQRSHRN V19.2S, V2.2D, #20
    UQRSHRN S6, D1, #15
    SRI D20, D21, #51
    SQRSHRN2 V12.8H, V22.4S, #1
    ORR  V4.2S, #0xd5, LSL #16
    SSHR  V13.2S, V6.2S, #22
    SHL  V4.16B, V10.16B, #0x7
    USHR  V24.4H, V8.4H, #15
    SQSHRN2 V18.16B, V4.8H, #1
    SQRSHRN V13.8B, V22.8H, #6
    UQSHRN S23, D5, #14
    SRSHR D22, D21, #61
    SQSHLU D5, D17, #0x39
    SHRN V13.8B, V12.8H, #2
    SRI V2.2D, V7.2D, #39
    SQSHL  V6.8H, V16.8H, #0x8
    RSHRN V20.2S, V10.2D, #12
    SQSHRN V9.8B, V12.8H, #6
    UQSHL H1, H26, #0x5
    SQRSHRUN2 V13.16B, V20.8H, #1
    USHLL2 V29.8H, V5.16B, #0x1
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdAritheticP01_label_992
    MOVZ  X5, #0xd4d1, LSL #0
    MOVK  X5, #0xc3c, LSL #16
    MOVK  X5, #0x7777, LSL #32
    MOVK  X5, #0xb868, LSL #48
    SUB  X20, X5, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0xeb07, LSL #0
    MOVK  X14, #0x541a, LSL #16
    MOVK  X14, #0x6632, LSL #32
    MOVK  X14, #0xa1d0, LSL #48
    SUB  X23, X14, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x9b7f, LSL #0
    MOVK  X8, #0x193d, LSL #16
    MOVK  X8, #0x7cd4, LSL #32
    MOVK  X8, #0x7470, LSL #48
    SUB  X2, X8, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0xd4d1, LSL #0
    MOVK  X13, #0xc3c, LSL #16
    MOVK  X13, #0x7777, LSL #32
    MOVK  X13, #0xb868, LSL #48
    SUB  X28, X13, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0xe89e, LSL #0
    MOVK  X23, #0x8624, LSL #16
    MOVK  X23, #0x2722, LSL #32
    MOVK  X23, #0x865d, LSL #48
    SUB  X24, X23, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0xd34c, LSL #0
    MOVK  X27, #0x356f, LSL #16
    MOVK  X27, #0x9f18, LSL #32
    MOVK  X27, #0x6585, LSL #48
    SUB  X13, X27, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x9b7f, LSL #0
    MOVK  X6, #0x193d, LSL #16
    MOVK  X6, #0x7cd4, LSL #32
    MOVK  X6, #0x7470, LSL #48
    SUB  X18, X6, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x7a52, LSL #0
    MOVK  X3, #0x5ba4, LSL #16
    MOVK  X3, #0xd738, LSL #32
    MOVK  X3, #0xbc7e, LSL #48
    SUB  X13, X3, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0xab5c, LSL #0
    MOVK  X13, #0x266a, LSL #16
    MOVK  X13, #0x78c9, LSL #32
    MOVK  X13, #0x7d6f, LSL #48
    SUB  X12, X13, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0xf3c7, LSL #0
    MOVK  X11, #0xe88, LSL #16
    MOVK  X11, #0x630d, LSL #32
    MOVK  X11, #0x2067, LSL #48
    SUB  X23, X11, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0xab5c, LSL #0
    MOVK  X7, #0x266a, LSL #16
    MOVK  X7, #0x78c9, LSL #32
    MOVK  X7, #0x7d6f, LSL #48
    SUB  X22, X7, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0xeb07, LSL #0
    MOVK  X2, #0x541a, LSL #16
    MOVK  X2, #0x6632, LSL #32
    MOVK  X2, #0xa1d0, LSL #48
    SUB  X28, X2, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0xcd00, LSL #0
    MOVK  X22, #0x3b87, LSL #16
    MOVK  X22, #0xe185, LSL #32
    MOVK  X22, #0xa0cb, LSL #48
    SUB  X14, X22, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x5d3a, LSL #0
    MOVK  X12, #0x2d2a, LSL #16
    MOVK  X12, #0x336b, LSL #32
    MOVK  X12, #0x978f, LSL #48
    SUB  X11, X12, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x8c3c, LSL #0
    MOVK  X24, #0xb427, LSL #16
    MOVK  X24, #0xc7e2, LSL #32
    MOVK  X24, #0xac78, LSL #48
    SUB  X13, X24, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x9ea7, LSL #0
    MOVK  X5, #0xce45, LSL #16
    MOVK  X5, #0xfe33, LSL #32
    MOVK  X5, #0xc87, LSL #48
    SUB  X25, X5, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x8483, LSL #0
    MOVK  X18, #0xa337, LSL #16
    MOVK  X18, #0x3946, LSL #32
    MOVK  X18, #0xc6c4, LSL #48
    SUB  X22, X18, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x8c3c, LSL #0
    MOVK  X27, #0xb427, LSL #16
    MOVK  X27, #0xc7e2, LSL #32
    MOVK  X27, #0xac78, LSL #48
    SUB  X14, X27, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x6b23, LSL #0
    MOVK  X26, #0x61b6, LSL #16
    MOVK  X26, #0x5a87, LSL #32
    MOVK  X26, #0xd5df, LSL #48
    SUB  X11, X26, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x8c3c, LSL #0
    MOVK  X24, #0xb427, LSL #16
    MOVK  X24, #0xc7e2, LSL #32
    MOVK  X24, #0xac78, LSL #48
    SUB  X9, X24, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
TaishanSimdAritheticP01_label_190:
    SUB  X19, X25, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D3
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x4020, LSL #16
    MOVK  X19, #0x4020, LSL #48
    SUB  X25, X19, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D4
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D6
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D20
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D23
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D25
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D27
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D28
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X14
    FMOV  V0.D[1], X11
    FMOV  D1, X21
    FMOV  V1.D[1], X28
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X26
    FMOV  V3.D[1], X14
    FMOV  D4, X19
    FMOV  V4.D[1], X9
    FMOV  D5, X3
    FMOV  V5.D[1], X18
    FMOV  D6, X25
    FMOV  V6.D[1], X2
    FMOV  D7, X12
    FMOV  V7.D[1], X19
    FMOV  D8, X14
    FMOV  V8.D[1], X26
    FMOV  D9, X27
    FMOV  V9.D[1], X25
    FMOV  D10, X21
    FMOV  V10.D[1], X23
    FMOV  D11, X12
    FMOV  V11.D[1], X7
    FMOV  D12, X23
    FMOV  V12.D[1], X27
    FMOV  D13, X27
    FMOV  V13.D[1], X11
    FMOV  D14, X23
    FMOV  V14.D[1], X9
    FMOV  D15, X19
    FMOV  V15.D[1], X11
    FMOV  D16, X6
    FMOV  V16.D[1], X27
    FMOV  D17, X9
    FMOV  V17.D[1], X12
    FMOV  D18, X8
    FMOV  V18.D[1], X8
    FMOV  D19, X16
    FMOV  V19.D[1], X21
    FMOV  D20, X9
    FMOV  V20.D[1], X5
    FMOV  D21, X16
    FMOV  V21.D[1], X24
    FMOV  D22, X18
    FMOV  V22.D[1], X19
    FMOV  D23, X12
    FMOV  V23.D[1], X4
    FMOV  D24, X14
    FMOV  V24.D[1], X16
    FMOV  D25, X2
    FMOV  V25.D[1], X11
    FMOV  D26, X22
    FMOV  V26.D[1], X26
    FMOV  D27, X16
    FMOV  V27.D[1], X22
    FMOV  D28, X7
    FMOV  V28.D[1], X25
    FMOV  D29, X5
    FMOV  V29.D[1], X16
    FMOV  D30, X16
    FMOV  V30.D[1], X19
    FMOV  D31, X17
    FMOV  V31.D[1], X8
    MOVZ  X10, #0xa, LSL #0
TaishanSimdAritheticP01_label_1075:
    SQSHL  V28.8H, V6.8H, #0x0
    SHRN2 V23.4S, V24.2D, #6
    USHR  V16.4S, V7.4S, #12
    MOVI  V21.16B, #0xf1
    USHLL V29.8H, V18.8B, #0x7
    MOVI  V16.4H, #0xfa, LSL #8
    SSHLL2 V28.8H, V8.16B, #0x3
    UQSHRN2 V31.8H, V17.4S, #11
    USHLL V30.8H, V12.8B, #0x5
    SQRSHRN B16, H23, #6
    SQRSHRN V18.2S, V2.2D, #25
    UQSHL B31, B22, #0x5
    UQSHL  V2.16B, V18.16B, #0x3
    SQSHRN V23.2S, V30.2D, #15
    USHLL2 V16.2D, V9.4S, #0xd
    SQRSHRN S30, D31, #10
    USHLL2 V11.4S, V8.8H, #0x3
    SQSHLU B27, B16, #0x4
    USRA  V21.8B, V26.8B, #7
    SHL  V4.2S, V9.2S, #0x19
    SHL D1, D23, #0xf
    USHR  V31.8B, V26.8B, #1
    USHR  V19.4S, V31.4S, #11
    SSHLL V22.4S, V30.4H, #0x3
    USHR  V15.4H, V21.4H, #9
    MOVI  V7.4S, #0x0, MSL #16
    SQSHRN V17.4H, V2.4S, #14
    SQSHLU B21, B14, #0x6
    SSHR  V30.2S, V11.2S, #32
    UQRSHRN2 V21.16B, V22.8H, #4
    UQSHRN2 V15.8H, V29.4S, #10
    UQSHL S16, S15, #0x9
    SQSHL V22.2D, V13.2D, #0x21
    SQSHLU V16.2D, V29.2D, #0x23
    SRSHR  V21.2S, V1.2S, #13
    UQSHL S29, S17, #0x1e
    SQSHRUN H29, S7, #9
    UQSHL  V11.4S, V0.4S, #0x4
    UQRSHRN V19.8B, V27.8H, #8
    ORR  V5.4H, #0x5c, LSL #8
    SQSHL B14, B19, #0x6
    USHLL2 V15.8H, V26.16B, #0x5
    UQSHL  V11.8H, V19.8H, #0x2
    USRA D2, D9, #55
    SQRSHRN S7, D14, #17
    SQSHL H2, H20, #0x3
    USHR D24, D20, #48
    UQSHL D4, D20, #0x2e
    SQSHLU B11, B22, #0x7
    USHR  V13.8H, V29.8H, #9
    UQSHL  S22, S28, S4
    URSRA V11.2D, V6.2D, #31
    UQSHL S15, S13, #0x16
    SHRN V4.4H, V18.4S, #13
    SQSHRN V26.4H, V23.4S, #1
    USHLL V20.8H, V28.8B, #0x5
    SLI  V20.2S, V9.2S, #0x13
    UQSHL  V2.4S, V24.4S, #0x16
    SQSHL  V30.4H, V27.4H, #0xd
    URSRA  V15.4H, V5.4H, #12
    UQSHRN2 V12.16B, V24.8H, #6
    UQSHL  V21.8H, V14.8H, V22.8H
    UQSHL D11, D0, #0x1b
    SSHLL2 V2.2D, V7.4S, #0xa
    SHL  V28.16B, V17.16B, #0x5
    SQRSHRUN2 V11.8H, V25.4S, #16
    RSHRN2 V0.16B, V8.8H, #6
    SRSHR  V2.2S, V29.2S, #23
    SHRN2 V30.4S, V19.2D, #8
    SSHLL2 V8.4S, V15.8H, #0xb
    SLI  V8.8B, V4.8B, #0x0
    SSRA D24, D16, #29
    USRA  V25.8B, V24.8B, #2
    SLI D12, D15, #0x3f
    SQSHLU D30, D2, #0xd
    URSRA  V16.2S, V20.2S, #3
    SQRSHRUN2 V28.8H, V22.4S, #11
    UQSHRN2 V15.4S, V26.2D, #6
    SQSHRUN V20.8B, V6.8H, #5
    SQSHRN V22.4H, V3.4S, #12
    SQSHLU  V6.4S, V25.4S, #0x9
    SSHR  V17.8B, V16.8B, #7
    SQSHRUN2 V18.8H, V4.4S, #3
    RSHRN2 V17.8H, V6.4S, #14
    MVNI  V31.4H, #0x9b, LSL #8
    SSRA  V29.8H, V28.8H, #3
    UQSHRN B0, H16, #2
    MVNI  V23.2S, #0x60, MSL #8
    SQSHL  V30.8B, V30.8B, #0x2
    USRA D30, D30, #9
    SHLL2  V1.8H, V27.16B, #8
    SQSHRUN2 V29.16B, V11.8H, #5
    URSHR  V8.16B, V12.16B, #3
    URSHR  V7.8H, V30.8H, #13
    SSHR  V16.4S, V0.4S, #17
    RSHRN2 V14.4S, V25.2D, #15
    URSRA  V27.8B, V13.8B, #4
    ORR  V12.8H, #0xb3, LSL #8
    SHL D31, D11, #0x36
    BIC  V22.4S, #0x5d, LSL #16
    MOVI  V30.16B, #0x9b
    SSRA  V28.2S, V28.2S, #22
    UQSHL B25, B16, #0x5
    SSHLL2 V22.2D, V22.4S, #0xd
    MVNI  V25.4H, #0x86, LSL #8
    USHR D5, D11, #28
    SRSRA D13, D29, #20
    SQSHRUN S12, D15, #29
    SHRN V5.2S, V7.2D, #27
    USHLL2 V9.4S, V11.8H, #0xd
    ORR  V1.2S, #0xc
    MOVI  V0.2D, #18446463693966278655
    SQSHRN2 V14.16B, V26.8H, #2
    SRI D29, D0, #49
    SHRN2 V0.4S, V11.2D, #29
    USRA V2.2D, V19.2D, #54
    USHLL V26.4S, V17.4H, #0x9
    USHR  V26.2S, V17.2S, #12
    URSHR V13.2D, V19.2D, #45
    SRI D12, D22, #26
    SQSHLU  V23.8H, V0.8H, #0xa
    SQRSHRUN B25, H2, #4
    UQSHL D18, D22, #0x25
    SQRSHRN2 V11.4S, V13.2D, #23
    UQSHL H13, H5, #0x8
    SRI D30, D2, #19
    MOVI  V2.2S, #0x3c, MSL #8
    SQSHRUN V2.2S, V28.2D, #4
    UQSHL H28, H13, #0x0
    UQSHRN2 V0.4S, V13.2D, #11
    SQSHRUN V25.4H, V20.4S, #8
    SLI D5, D29, #0x2a
    UQSHL  H0, H0, H0
    UQSHRN2 V29.4S, V18.2D, #30
    SSRA V20.2D, V24.2D, #36
    SSHR V7.2D, V18.2D, #48
    SSHLL2 V22.8H, V31.16B, #0x3
    UQSHL  V13.4S, V28.4S, #0x1e
    SHRN2 V9.16B, V2.8H, #3
    SQSHRUN V25.4H, V29.4S, #1
    SQSHRUN2 V7.4S, V2.2D, #11
    SQSHL S9, S27, #0x11
    SQSHRUN V9.2S, V18.2D, #4
    SHRN2 V15.16B, V2.8H, #6
    UQSHL  H20, H0, H29
    MVNI  V30.2S, #0x4b, MSL #16
    UQSHL  V22.2S, V28.2S, #0x9
    SQSHLU D31, D4, #0x11
    SQRSHRUN S13, D4, #23
    UQSHRN2 V19.8H, V1.4S, #16
    USHR  V9.2S, V6.2S, #17
    SHRN V2.4H, V13.4S, #2
    SQSHLU  V28.4H, V27.4H, #0xb
    SLI  V22.8H, V4.8H, #0x2
    UQSHL  B2, B17, B25
    UQSHL  V23.8B, V1.8B, V24.8B
    URSRA D3, D15, #36
    SQSHL D15, D15, #0x7
    SQRSHRN B25, H22, #6
    SQSHLU V17.2D, V29.2D, #0x23
    FMOV  V3.2S, #16.00000000
    SQSHL S15, S6, #0x1a
    SQSHL  V0.4S, V4.4S, #0x10
    SRI V11.2D, V3.2D, #26
    SHLL2  V21.4S, V2.8H, #16
    SQRSHRUN2 V2.16B, V13.8H, #8
    MOVI  D20, #1099494915840
    SHL  V27.2S, V13.2S, #0xc
    UQSHRN2 V15.8H, V27.4S, #6
    SHL D6, D22, #0x19
    SLI  V19.8H, V25.8H, #0x4
    URSRA D26, D2, #52
    SQSHRN V3.8B, V9.8H, #3
    SQSHRUN B3, H0, #4
    UQSHRN V0.8B, V14.8H, #2
    USRA  V23.2S, V29.2S, #13
    SRSHR V25.2D, V9.2D, #3
    SQSHL  V4.4H, V11.4H, #0xc
    SLI  V11.4H, V2.4H, #0x9
    RSHRN V25.8B, V29.8H, #2
    UQSHL B30, B15, #0x2
    SQSHL H15, H13, #0x5
    USHLL2 V1.4S, V14.8H, #0xb
    SSHR  V10.4S, V29.4S, #3
    UQRSHRN2 V21.16B, V8.8H, #6
    SRI V21.2D, V14.2D, #34
    UQRSHRN H1, S4, #7
    URSHR  V8.8B, V15.8B, #3
    SQSHL D30, D27, #0x24
    URSHR  V22.4H, V12.4H, #14
    SQSHLU  V24.4H, V14.4H, #0xa
    MOVI  V1.2D, #4278190335
    USHLL2 V22.8H, V24.16B, #0x5
    RSHRN2 V21.16B, V19.8H, #6
    SQRSHRN S13, D12, #7
    URSHR  V15.8H, V14.8H, #7
    UQRSHRN2 V19.16B, V21.8H, #4
    UQSHRN2 V0.8H, V26.4S, #15
    SHL  V30.4S, V16.4S, #0x8
    SSRA  V1.4S, V8.4S, #26
    SUBS  X10, X10, #0x1
    B.NE  TaishanSimdAritheticP01_label_1075
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D3
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D4
    MOVZ  X7, #0x7fff, LSL #0
    MOVK  X7, #0x7fff, LSL #16
    MOVK  X7, #0x7fff, LSL #32
    SUB  X10, X7, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D5
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xfc00, LSL #32
    MOVK  X18, #0x1ff, LSL #48
    SUB  X14, X18, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D6
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D8
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D10
    MOVZ  X21, #0xfff, LSL #0
    SUB  X23, X21, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D11
    MOVZ  X2, #0x10, LSL #0
    MOVK  X2, #0x10, LSL #32
    SUB  X25, X2, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D17
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xfff8, LSL #32
    MOVK  X21, #0x3, LSL #48
    SUB  X18, X21, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D18
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D19
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D20
    MOVZ  X13, #0xff00, LSL #0
    MOVK  X13, #0xff00, LSL #16
    MOVK  X13, #0xff, LSL #32
    SUB  X2, X13, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D23
    MOVZ  X24, #0xf, LSL #0
    MOVK  X24, #0xc, LSL #32
    SUB  X8, X24, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D24
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D25
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D27
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D28
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
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
    FMOV  D0, X3
    FMOV  V0.D[1], X5
    FMOV  D1, X26
    FMOV  V1.D[1], X26
    FMOV  D2, X16
    FMOV  V2.D[1], X23
    FMOV  D3, X5
    FMOV  V3.D[1], X3
    FMOV  D4, X16
    FMOV  V4.D[1], X26
    FMOV  D5, X24
    FMOV  V5.D[1], X27
    FMOV  D6, X11
    FMOV  V6.D[1], X20
    FMOV  D7, X4
    FMOV  V7.D[1], X25
    FMOV  D8, X6
    FMOV  V8.D[1], X10
    FMOV  D9, X13
    FMOV  V9.D[1], X9
    FMOV  D10, X4
    FMOV  V10.D[1], X21
    FMOV  D11, X17
    FMOV  V11.D[1], X23
    FMOV  D12, X6
    FMOV  V12.D[1], X17
    FMOV  D13, X25
    FMOV  V13.D[1], X5
    FMOV  D14, X25
    FMOV  V14.D[1], X23
    FMOV  D15, X20
    FMOV  V15.D[1], X13
    FMOV  D16, X7
    FMOV  V16.D[1], X23
    FMOV  D17, X17
    FMOV  V17.D[1], X2
    FMOV  D18, X23
    FMOV  V18.D[1], X8
    FMOV  D19, X23
    FMOV  V19.D[1], X17
    FMOV  D20, X20
    FMOV  V20.D[1], X10
    FMOV  D21, X24
    FMOV  V21.D[1], X5
    FMOV  D22, X12
    FMOV  V22.D[1], X28
    FMOV  D23, X24
    FMOV  V23.D[1], X12
    FMOV  D24, X21
    FMOV  V24.D[1], X9
    FMOV  D25, X15
    FMOV  V25.D[1], X18
    FMOV  D26, X18
    FMOV  V26.D[1], X15
    FMOV  D27, X10
    FMOV  V27.D[1], X16
    FMOV  D28, X17
    FMOV  V28.D[1], X18
    FMOV  D29, X23
    FMOV  V29.D[1], X19
    FMOV  D30, X8
    FMOV  V30.D[1], X25
    FMOV  D31, X20
    FMOV  V31.D[1], X21
    MOVZ  X14, #0xf, LSL #0
TaishanSimdAritheticP01_label_1155:
    SQSHRN H7, S26, #14
    SQSHRUN2 V18.4S, V13.2D, #14
    URSRA  V31.4S, V15.4S, #25
    SQSHRUN V24.8B, V24.8H, #1
    UQRSHRN B11, H4, #3
    SQRSHRUN V1.8B, V2.8H, #1
    SSRA  V22.4S, V9.4S, #6
    SSRA  V3.4S, V22.4S, #23
    UQSHL  S22, S1, S0
    SRSRA  V3.2S, V0.2S, #7
    SSHLL2 V18.4S, V26.8H, #0x6
    SQSHRUN H28, S30, #5
    SRI  V25.2S, V10.2S, #27
    SQSHRN H30, S16, #2
    SQSHRN H22, S23, #6
    UQSHL  V5.2S, V28.2S, #0x18
    SQRSHRN V19.4H, V26.4S, #11
    UQRSHRN2 V26.8H, V18.4S, #3
    SQSHRN2 V7.16B, V14.8H, #3
    SQSHRUN V23.8B, V18.8H, #6
    UQSHRN V9.4H, V22.4S, #4
    SQRSHRN V2.8B, V21.8H, #3
    URSHR  V1.4H, V1.4H, #13
    BIC  V5.4S, #0x81
    UQSHRN2 V16.16B, V28.8H, #1
    SQSHLU  V23.2S, V18.2S, #0x2
    RSHRN V30.2S, V22.2D, #13
    MOVI  V19.8B, #0xdf
    SRSRA  V23.16B, V7.16B, #1
    UQSHRN V30.2S, V28.2D, #20
    SRSRA  V29.4H, V30.4H, #11
    USHLL2 V17.2D, V29.4S, #0xd
    SHLL  V17.2D, V26.2S, #32
    SRI  V28.16B, V16.16B, #7
    SQSHLU B8, B25, #0x7
    SSHR  V21.8B, V3.8B, #2
    UQRSHRN B0, H8, #4
    RSHRN V19.2S, V28.2D, #21
    SQRSHRN V7.4H, V5.4S, #14
    URSHR  V17.4S, V2.4S, #14
    MOVI  V27.8H, #0xf
    URSHR  V21.2S, V5.2S, #18
    UQSHRN V29.4H, V27.4S, #15
    UQSHL B19, B23, #0x5
    SQSHLU  V20.8B, V15.8B, #0x5
    SQSHRUN B31, H29, #6
    URSHR V28.2D, V2.2D, #41
    SQRSHRN2 V18.4S, V19.2D, #25
    SQRSHRN V18.2S, V18.2D, #21
    SRSHR  V2.4H, V0.4H, #8
    USHLL V18.2D, V7.2S, #0x9
    SQSHLU  V21.2S, V31.2S, #0x1b
    UQSHRN H27, S17, #3
    SQRSHRN H14, S29, #10
    SQSHRUN V16.4H, V23.4S, #3
    SSRA V28.2D, V26.2D, #34
    SRSHR D20, D11, #58
    SQRSHRUN S20, D27, #4
    SQSHRN S26, D27, #13
    SHRN V22.8B, V21.8H, #8
    SQSHRUN S26, D25, #9
    MOVI  V16.8B, #0x6a
    USHR  V2.2S, V23.2S, #23
    SSHLL2 V11.2D, V25.4S, #0x3
    USRA V27.2D, V29.2D, #36
    FMOV  V13.2S, #0.24218750
    SRI  V16.16B, V4.16B, #4
    UQSHRN B7, H2, #3
    USHR V21.2D, V17.2D, #12
    UQRSHRN2 V14.4S, V18.2D, #10
    UQSHRN S12, D15, #31
    RSHRN2 V14.16B, V26.8H, #5
    SQSHL D17, D22, #0x6
    USHR  V18.2S, V7.2S, #32
    MOVI  V1.4S, #0x15, LSL #16
    UQSHRN2 V13.16B, V12.8H, #6
    UQSHL  V11.8H, V18.8H, #0x8
    UQRSHRN V16.2S, V20.2D, #24
    UQSHL  V18.16B, V24.16B, #0x2
    UQSHL D28, D29, #0x1a
    SQRSHRN V4.2S, V0.2D, #11
    SQSHL  V30.16B, V27.16B, #0x1
    SSRA  V20.8B, V21.8B, #6
    SQRSHRN2 V1.4S, V22.2D, #11
    ORR  V29.4H, #0xce
    UQSHL H17, H11, #0x9
    SRSHR D11, D12, #60
    SQSHRUN2 V18.8H, V21.4S, #10
    SQSHRUN V13.2S, V11.2D, #29
    SQRSHRUN V19.4H, V27.4S, #14
    SQRSHRUN S28, D28, #12
    RSHRN2 V4.16B, V0.8H, #2
    SQSHRUN2 V4.8H, V18.4S, #7
    USHR  V13.8H, V24.8H, #16
    SQRSHRN V26.8B, V30.8H, #7
    USHLL V25.2D, V8.2S, #0x2
    SQSHRUN2 V27.16B, V20.8H, #5
    UQSHL  V20.4S, V24.4S, #0x13
    SHRN2 V8.4S, V21.2D, #1
    RSHRN2 V23.16B, V29.8H, #7
    UQRSHRN S12, D31, #21
    UQSHL  H28, H11, H1
    SQRSHRN V22.4H, V16.4S, #2
    SQSHRN2 V17.4S, V19.2D, #17
    UQSHL H18, H1, #0x5
    SSRA D3, D14, #17
    UQSHL V15.2D, V14.2D, #0x22
    SQSHL S11, S8, #0x7
    MOVI  V16.4S, #0x61, LSL #8
    USRA  V13.4H, V27.4H, #5
    SQSHL  V20.4H, V12.4H, #0x0
    SHL  V22.8B, V31.8B, #0x4
    SSRA D4, D2, #42
    UQSHL D13, D7, #0x21
    SQSHLU  V3.16B, V2.16B, #0x7
    UQSHL B31, B24, #0x6
    UQRSHRN B19, H5, #8
    UQRSHRN V0.4H, V13.4S, #9
    SRI  V26.4H, V12.4H, #4
    SQSHRN2 V14.4S, V12.2D, #22
    SHL  V24.8B, V9.8B, #0x3
    SQSHRN V28.8B, V24.8H, #4
    USHLL2 V24.8H, V4.16B, #0x1
    SRSHR  V9.8B, V0.8B, #5
    UQSHL  B7, B19, B25
    SSRA V14.2D, V4.2D, #61
    USHR  V22.8H, V0.8H, #6
    USRA V3.2D, V16.2D, #38
    UQSHRN2 V25.16B, V16.8H, #2
    UQSHRN V28.4H, V8.4S, #16
    SQSHRUN S14, D24, #14
    SQRSHRUN2 V15.8H, V11.4S, #10
    USHR V13.2D, V11.2D, #21
    SSRA  V20.4H, V3.4H, #14
    SQSHL  V29.4S, V24.4S, #0x4
    UQSHL  V13.8H, V11.8H, #0xb
    SQSHRN V31.8B, V24.8H, #3
    SHLL2  V4.4S, V18.8H, #16
    MOVI  D19, #281474976645120
    SQRSHRUN B24, H19, #6
    SRSRA  V5.2S, V25.2S, #10
    URSHR D16, D28, #7
    SHRN2 V14.8H, V14.4S, #15
    SQSHRUN B30, H12, #5
    SQSHRUN V27.2S, V13.2D, #2
    SQSHL D15, D13, #0x16
    USRA  V19.8B, V25.8B, #3
    UQSHRN2 V4.8H, V25.4S, #1
    SQSHL  V3.4H, V17.4H, #0x1
    USHLL2 V25.2D, V13.4S, #0x11
    SLI V4.2D, V21.2D, #0x1d
    UQRSHRN B27, H24, #1
    SSHLL2 V19.4S, V20.8H, #0xe
    USHR  V15.4H, V10.4H, #8
    SQSHLU B18, B16, #0x6
    SQRSHRUN B28, H10, #3
    SQRSHRN V10.4H, V21.4S, #8
    SQSHRN V3.2S, V13.2D, #9
    SQSHRN V12.8B, V15.8H, #4
    MOVI  V21.16B, #0x1b
    SHLL  V4.2D, V3.2S, #32
    SQSHRN V15.4H, V14.4S, #12
    UQSHRN2 V9.8H, V20.4S, #14
    UQRSHRN S20, D24, #7
    USHR  V31.4S, V16.4S, #16
    SQSHLU B21, B31, #0x2
    SQSHRN2 V28.4S, V2.2D, #18
    UQRSHRN S22, D19, #32
    BIC  V25.8H, #0x4d, LSL #8
    SRSRA  V20.4S, V0.4S, #17
    UQSHL  H15, H5, H25
    FMOV  V9.2S, #-0.71875000
    SHL D12, D19, #0x2c
    UQRSHRN V5.4H, V31.4S, #4
    SQSHLU D29, D2, #0x1f
    SQRSHRN V13.8B, V12.8H, #4
    MVNI  V0.4H, #0xd6, LSL #8
    SHRN2 V3.16B, V22.8H, #8
    SQSHLU H31, H14, #0x5
    MOVI  V14.8B, #0x66
    URSHR  V9.8B, V28.8B, #3
    SQRSHRN B9, H28, #8
    MVNI  V25.4S, #0x63, LSL #8
    URSHR  V26.16B, V3.16B, #7
    SQSHLU  V14.8B, V14.8B, #0x4
    URSHR  V6.8B, V16.8B, #5
    SQSHLU D25, D25, #0x1e
    FMOV  V13.2D, #-0.65625000
    RSHRN V29.4H, V16.4S, #5
    UQSHL  V16.4H, V26.4H, #0x8
    SSHLL2 V21.2D, V16.4S, #0x6
    UQSHL  B23, B20, B20
    SSHLL2 V22.4S, V10.8H, #0x3
    UQSHRN V19.8B, V29.8H, #8
    SSHR  V9.4S, V16.4S, #14
    SQSHRUN2 V7.4S, V31.2D, #30
    SSRA D0, D22, #12
    UQSHL  V11.2D, V24.2D, V23.2D
    SQRSHRN B31, H7, #6
    SRSRA  V15.4H, V4.4H, #12
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdAritheticP01_label_1155
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X24, X12, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X15, X20, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X24, X4, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X8, X11, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X15, X12, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X5, X19, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X23, X7, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X10, X26, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X4, X14, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X27, X11, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X16, X4, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X23, X15, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D2
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D6
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xbfe5, LSL #48
    SUB  X18, X2, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D13
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xbfe5, LSL #48
    SUB  X18, X2, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D14
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X18, X24, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D15
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D16
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D18
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D22
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D24
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D25
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D26
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D28
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x6e85, LSL #0
    MOVK  X2, #0x4547, LSL #16
    MOVK  X2, #0xbb7b, LSL #32
    MOVK  X2, #0x2a02, LSL #48
    MOVZ  X3, #0x5e36, LSL #0
    MOVK  X3, #0xd3c6, LSL #16
    MOVK  X3, #0x4b8, LSL #32
    MOVK  X3, #0x2a06, LSL #48
    MOVZ  X4, #0xd6fc, LSL #0
    MOVK  X4, #0xb912, LSL #16
    MOVK  X4, #0x77e4, LSL #32
    MOVK  X4, #0x72bf, LSL #48
    MOVZ  X5, #0x3d4d, LSL #0
    MOVK  X5, #0x339f, LSL #16
    MOVK  X5, #0xa2ce, LSL #32
    MOVK  X5, #0x7274, LSL #48
    MOVZ  X6, #0xad2c, LSL #0
    MOVK  X6, #0xe5ee, LSL #16
    MOVK  X6, #0xd5b5, LSL #32
    MOVK  X6, #0x1e0d, LSL #48
    MOVZ  X7, #0x1834, LSL #0
    MOVK  X7, #0x31b8, LSL #16
    MOVK  X7, #0x5a78, LSL #32
    MOVK  X7, #0xf6d9, LSL #48
    MOVZ  X8, #0xf626, LSL #0
    MOVK  X8, #0x20c5, LSL #16
    MOVK  X8, #0x28ba, LSL #32
    MOVK  X8, #0x35b7, LSL #48
    MOVZ  X9, #0x8494, LSL #0
    MOVK  X9, #0x2a0d, LSL #16
    MOVK  X9, #0x8cab, LSL #32
    MOVK  X9, #0x15e2, LSL #48
    MOVZ  X10, #0x5669, LSL #0
    MOVK  X10, #0x922c, LSL #16
    MOVK  X10, #0xd90b, LSL #32
    MOVK  X10, #0xfd8a, LSL #48
    MOVZ  X11, #0x1339, LSL #0
    MOVK  X11, #0x40fe, LSL #16
    MOVK  X11, #0xae31, LSL #32
    MOVK  X11, #0x5b31, LSL #48
    MOVZ  X12, #0x1bb5, LSL #0
    MOVK  X12, #0x93b0, LSL #16
    MOVK  X12, #0xb227, LSL #32
    MOVK  X12, #0x7028, LSL #48
    MOVZ  X13, #0x22e4, LSL #0
    MOVK  X13, #0xf5fe, LSL #16
    MOVK  X13, #0xb296, LSL #32
    MOVK  X13, #0xb262, LSL #48
    MOVZ  X14, #0x121e, LSL #0
    MOVK  X14, #0xfca7, LSL #16
    MOVK  X14, #0x5630, LSL #32
    MOVK  X14, #0x3950, LSL #48
    MOVZ  X15, #0x526, LSL #0
    MOVK  X15, #0x7481, LSL #16
    MOVK  X15, #0x34d7, LSL #32
    MOVK  X15, #0xea29, LSL #48
    MOVZ  X16, #0x286f, LSL #0
    MOVK  X16, #0x564, LSL #16
    MOVK  X16, #0x5876, LSL #32
    MOVK  X16, #0xc9a6, LSL #48
    MOVZ  X17, #0x5625, LSL #0
    MOVK  X17, #0x2ecc, LSL #16
    MOVK  X17, #0x2e7c, LSL #32
    MOVK  X17, #0x1e26, LSL #48
    MOVZ  X18, #0xd474, LSL #0
    MOVK  X18, #0x3ce9, LSL #16
    MOVK  X18, #0x345a, LSL #32
    MOVK  X18, #0x853, LSL #48
    MOVZ  X19, #0x4f74, LSL #0
    MOVK  X19, #0x2fe8, LSL #16
    MOVK  X19, #0xb15b, LSL #32
    MOVK  X19, #0x5b92, LSL #48
    MOVZ  X20, #0x9a50, LSL #0
    MOVK  X20, #0xb567, LSL #16
    MOVK  X20, #0xa518, LSL #32
    MOVK  X20, #0x2176, LSL #48
    MOVZ  X21, #0x2485, LSL #0
    MOVK  X21, #0xfd76, LSL #16
    MOVK  X21, #0xb39, LSL #32
    MOVK  X21, #0x764a, LSL #48
    MOVZ  X22, #0x50d2, LSL #0
    MOVK  X22, #0x74e3, LSL #16
    MOVK  X22, #0xe1b3, LSL #32
    MOVK  X22, #0xc732, LSL #48
    MOVZ  X23, #0xe2db, LSL #0
    MOVK  X23, #0xfb05, LSL #16
    MOVK  X23, #0xa040, LSL #32
    MOVK  X23, #0x9757, LSL #48
    MOVZ  X24, #0xa237, LSL #0
    MOVK  X24, #0x3f3a, LSL #16
    MOVK  X24, #0x85ae, LSL #32
    MOVK  X24, #0xc1ef, LSL #48
    MOVZ  X25, #0x90ab, LSL #0
    MOVK  X25, #0xcfbc, LSL #16
    MOVK  X25, #0xeae7, LSL #32
    MOVK  X25, #0x93b3, LSL #48
    MOVZ  X26, #0x8919, LSL #0
    MOVK  X26, #0x19e0, LSL #16
    MOVK  X26, #0xd7c2, LSL #32
    MOVK  X26, #0x7f00, LSL #48
    MOVZ  X27, #0x8e5d, LSL #0
    MOVK  X27, #0x99dd, LSL #16
    MOVK  X27, #0x88c4, LSL #32
TaishanSimdAritheticP01_label_53:
    MOVK  X27, #0xed6b, LSL #48
    MOVZ  X28, #0xaf31, LSL #0
    MOVK  X28, #0x894c, LSL #16
    MOVK  X28, #0x7298, LSL #32
    MOVK  X28, #0xa962, LSL #48
    FMOV  D0, X3
    FMOV  V0.D[1], X6
    FMOV  D1, X18
    FMOV  V1.D[1], X11
    FMOV  D2, X13
    FMOV  V2.D[1], X19
    FMOV  D3, X27
    FMOV  V3.D[1], X26
    FMOV  D4, X28
    FMOV  V4.D[1], X6
    FMOV  D5, X14
    FMOV  V5.D[1], X4
    FMOV  D6, X14
    FMOV  V6.D[1], X11
    FMOV  D7, X12
    FMOV  V7.D[1], X18
    FMOV  D8, X6
    FMOV  V8.D[1], X15
    FMOV  D9, X25
    FMOV  V9.D[1], X11
    FMOV  D10, X18
    FMOV  V10.D[1], X28
    FMOV  D11, X25
    FMOV  V11.D[1], X17
    FMOV  D12, X14
    FMOV  V12.D[1], X23
    FMOV  D13, X19
    FMOV  V13.D[1], X13
    FMOV  D14, X13
    FMOV  V14.D[1], X16
    FMOV  D15, X28
    FMOV  V15.D[1], X17
    FMOV  D16, X16
    FMOV  V16.D[1], X17
    FMOV  D17, X18
    FMOV  V17.D[1], X15
    FMOV  D18, X7
    FMOV  V18.D[1], X18
    FMOV  D19, X23
    FMOV  V19.D[1], X16
    FMOV  D20, X21
    FMOV  V20.D[1], X22
    FMOV  D21, X17
    FMOV  V21.D[1], X9
    FMOV  D22, X10
    FMOV  V22.D[1], X13
    FMOV  D23, X26
    FMOV  V23.D[1], X17
    FMOV  D24, X6
    FMOV  V24.D[1], X27
    FMOV  D25, X3
    FMOV  V25.D[1], X22
    FMOV  D26, X22
    FMOV  V26.D[1], X18
    FMOV  D27, X10
    FMOV  V27.D[1], X10
    FMOV  D28, X16
    FMOV  V28.D[1], X3
    FMOV  D29, X10
    FMOV  V29.D[1], X28
    FMOV  D30, X28
    FMOV  V30.D[1], X18
    FMOV  D31, X6
    FMOV  V31.D[1], X20
    MOVZ  X20, #0xa, LSL #0
TaishanSimdAritheticP01_label_1236:
    SSHLL V5.8H, V29.8B, #0x1
    SQSHRN V0.4H, V24.4S, #11
    SQSHRN2 V24.16B, V27.8H, #4
    SLI  V23.8H, V28.8H, #0x0
    SHLL  V18.2D, V16.2S, #32
    SRSRA  V24.16B, V4.16B, #3
    SSRA  V16.16B, V30.16B, #7
    USHLL2 V12.8H, V15.16B, #0x3
    UQRSHRN V27.8B, V30.8H, #8
    SSRA V11.2D, V14.2D, #37
    SQSHRN2 V16.16B, V27.8H, #6
    BIC  V23.2S, #0x3b, LSL #16
    SQSHLU H15, H0, #0xc
    USHLL2 V1.2D, V18.4S, #0x5
    UQSHL  D13, D29, D15
    URSRA  V1.8H, V2.8H, #5
    SQRSHRUN V30.8B, V2.8H, #3
    SSHLL2 V0.4S, V8.8H, #0xd
    SQSHLU H13, H0, #0x2
    SSHLL2 V26.8H, V30.16B, #0x1
    SRI D9, D5, #28
    UQSHL  V16.8B, V30.8B, #0x0
    UQSHL H0, H11, #0x6
    SSHR  V4.2S, V5.2S, #15
    UQRSHRN H0, S11, #12
    UQSHRN V19.2S, V31.2D, #17
    MOVI  V2.4S, #0x78, LSL #8
    SQSHL  V4.2S, V27.2S, #0x1c
    USRA  V27.4S, V28.4S, #17
    SQSHRUN2 V30.8H, V20.4S, #16
    UQSHL V12.2D, V8.2D, #0x3e
    SQSHL  V19.8B, V28.8B, #0x3
    SHL  V18.8B, V9.8B, #0x0
    SQSHL  V3.2S, V28.2S, #0x8
    USRA D29, D4, #35
    USHR  V16.8B, V16.8B, #1
    USHLL2 V23.4S, V2.8H, #0xa
    SQSHRUN V9.2S, V5.2D, #30
    UQSHL  S9, S3, S30
    ORR  V13.4H, #0x80
    FMOV  V24.2D, #0.20312500
    SRSRA  V5.8B, V13.8B, #4
    UQSHL  B12, B9, B1
    USHLL2 V10.2D, V28.4S, #0x7
    SHLL  V16.8H, V24.8B, #8
    URSHR D14, D19, #39
    SRI V29.2D, V22.2D, #61
    SQSHRN V14.2S, V30.2D, #4
    SRI D11, D18, #18
    SQSHRUN S7, D29, #5
    UQSHL  H13, H14, H18
    UQSHRN2 V28.8H, V27.4S, #9
    SQSHRUN H10, S17, #4
    UQSHL  V5.8H, V30.8H, #0x6
    SQSHL S12, S16, #0x17
    URSRA  V14.8B, V31.8B, #4
    SHL  V23.4S, V26.4S, #0x7
    SQSHRUN V23.4H, V23.4S, #5
    SSHR  V19.8H, V9.8H, #16
    SQSHLU  V13.4H, V17.4H, #0xc
    SRI  V31.8H, V9.8H, #3
    SSRA D1, D29, #31
    SRSHR  V5.2S, V11.2S, #9
    SQRSHRN2 V17.16B, V17.8H, #7
    UQSHRN2 V24.4S, V14.2D, #10
    UQSHRN S31, D4, #24
    SQSHL  V15.4S, V6.4S, #0x1f
    SQSHL  V23.8H, V12.8H, #0xd
    SSRA D26, D27, #16
    MOVI  V2.2D, #281474959998975
    SQSHRN S28, D19, #26
    SRSHR V23.2D, V11.2D, #25
    SHRN2 V14.8H, V5.4S, #1
    MVNI  V5.8H, #0x10, LSL #8
    SQRSHRN H0, S8, #7
    SRI  V19.16B, V25.16B, #4
    SSHLL2 V15.2D, V24.4S, #0x14
    SQRSHRUN2 V31.4S, V7.2D, #2
    UQRSHRN B26, H4, #7
    UQSHRN2 V6.8H, V11.4S, #14
    SHRN2 V18.4S, V10.2D, #13
    SRSRA D11, D23, #56
    SQSHRN V17.4H, V17.4S, #1
    SQRSHRN2 V14.4S, V31.2D, #27
    UQSHL  H25, H23, H26
    SRI  V23.8B, V30.8B, #5
    UQSHL  V7.8H, V27.8H, #0xe
    SHL  V4.16B, V28.16B, #0x2
    MOVI  V10.2D, #18446742978492825855
    RSHRN V24.8B, V27.8H, #3
    URSHR V9.2D, V15.2D, #29
    UQSHL  D15, D28, D6
    SQSHRUN V11.2S, V24.2D, #1
    SQSHRUN2 V10.4S, V16.2D, #20
    SQSHL  V6.4H, V7.4H, #0x2
    SQSHRUN V21.8B, V11.8H, #7
    SQRSHRN B20, H23, #1
    SQSHRUN S20, D19, #10
    SSHLL2 V12.2D, V12.4S, #0x1e
    SRSHR V31.2D, V13.2D, #56
    SLI D16, D20, #0x21
    USHLL2 V20.4S, V8.8H, #0x1
    SQSHRN S25, D23, #10
    BIC  V9.2S, #0x39, LSL #16
    SLI  V9.4H, V11.4H, #0x7
    SQSHL B25, B20, #0x2
    SQRSHRN2 V27.4S, V4.2D, #13
    SQSHRUN S6, D0, #30
    UQSHL S4, S4, #0x9
    SQSHRUN2 V21.4S, V24.2D, #12
    MOVI  V13.4S, #0xa8, MSL #16
    USRA  V27.16B, V28.16B, #7
    SHRN2 V8.4S, V9.2D, #5
    URSHR  V4.16B, V19.16B, #7
TaishanSimdAritheticP01_label_492:
    MOVI  V3.8B, #0x6f
    SQRSHRUN B21, H16, #2
    URSRA V27.2D, V0.2D, #52
    UQSHL  D24, D12, D24
    SQSHL D6, D29, #0x36
    UQSHL  D10, D27, D8
    UQSHL  S0, S24, S23
    SHRN V19.8B, V0.8H, #8
    SHRN2 V31.8H, V7.4S, #14
    SRSRA  V10.8B, V12.8B, #1
    SQRSHRN2 V7.16B, V9.8H, #6
    UQSHL  B8, B25, B4
    SQRSHRUN2 V5.8H, V4.4S, #7
    UQSHRN2 V5.8H, V12.4S, #15
    SQSHRN V25.2S, V27.2D, #17
    UQSHRN B0, H24, #5
    SRSRA  V16.2S, V4.2S, #2
    SRSHR V0.2D, V31.2D, #37
    SRI  V10.2S, V11.2S, #25
    ORR  V0.8H, #0x13, LSL #8
    SQSHL H7, H6, #0x1
    SRI  V9.4H, V5.4H, #1
    SHL D19, D24, #0x34
    BIC  V25.8H, #0x4f, LSL #8
    USRA  V23.8H, V19.8H, #13
    RSHRN V9.2S, V8.2D, #19
    UQSHRN2 V14.4S, V1.2D, #12
    USRA  V4.8H, V4.8H, #10
    SRSHR  V11.8H, V1.8H, #7
    SQSHRN H28, S5, #1
    UQRSHRN S20, D4, #16
    SQSHL  V6.8B, V15.8B, #0x0
    SQSHRUN2 V17.8H, V28.4S, #12
    UQSHL V29.2D, V1.2D, #0xd
    RSHRN V3.2S, V25.2D, #18
    SQRSHRUN V19.8B, V6.8H, #1
    MOVI  V7.2D, #18446744073692839680
    SHRN V31.4H, V4.4S, #13
    UQRSHRN2 V15.16B, V17.8H, #7
    SRSRA  V10.8B, V0.8B, #7
    RSHRN2 V15.4S, V13.2D, #15
    SQSHLU V0.2D, V19.2D, #0x22
    SQRSHRUN V21.8B, V14.8H, #5
    SLI  V27.8H, V16.8H, #0x2
    SQSHRN H27, S29, #14
    SLI  V6.4S, V10.4S, #0x7
    UQSHL  B7, B28, B20
    UQSHRN2 V6.8H, V14.4S, #7
    USHLL V3.4S, V21.4H, #0x7
    UQSHL B7, B31, #0x6
    SQRSHRUN S6, D7, #15
    USHLL V17.2D, V20.2S, #0xa
    URSHR  V27.4S, V18.4S, #27
    SSRA  V17.4S, V17.4S, #13
    FMOV  V9.2D, #16.00000000
    FMOV  V0.2S, #0.21875000
    UQSHL  S9, S10, S8
    USHLL2 V15.4S, V13.8H, #0x1
    SQRSHRN V14.2S, V3.2D, #5
    SQSHRUN V20.2S, V27.2D, #31
    FMOV  V29.4S, #1.87500000
    USRA V1.2D, V29.2D, #41
    RSHRN V4.2S, V21.2D, #9
    MVNI  V22.8H, #0x2, LSL #8
    SRSRA  V14.8H, V15.8H, #12
    SRSHR D0, D10, #24
    UQRSHRN2 V13.8H, V14.4S, #14
    SQSHLU S9, S10, #0xe
    UQSHRN H1, S10, #5
    RSHRN2 V14.8H, V3.4S, #16
    USHR  V3.4H, V29.4H, #13
    SSRA V5.2D, V1.2D, #63
    SQSHRUN2 V18.8H, V8.4S, #9
    UQSHRN2 V16.8H, V2.4S, #4
    USHLL V8.2D, V22.2S, #0x19
    SQSHL  V7.2S, V8.2S, #0x14
    SQSHRN B3, H10, #6
    URSHR  V15.16B, V22.16B, #7
    SHL  V10.4H, V4.4H, #0xc
    SRSRA D7, D12, #60
    SHL V25.2D, V7.2D, #0x34
    USHR  V15.4H, V25.4H, #4
    UQSHL  S10, S22, S21
    UQRSHRN2 V11.4S, V27.2D, #4
    SSHR D9, D22, #54
    SSHR D14, D27, #61
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdAritheticP01_label_1236
    MOVZ  X6, #0x6e85, LSL #0
    MOVK  X6, #0x4547, LSL #16
TaishanSimdAritheticP01_label_794:
    MOVK  X6, #0xbb7b, LSL #32
    MOVK  X6, #0x2a02, LSL #48
    SUB  X18, X6, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x5e36, LSL #0
    MOVK  X16, #0xd3c6, LSL #16
    MOVK  X16, #0x4b8, LSL #32
    MOVK  X16, #0x2a06, LSL #48
    SUB  X3, X16, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0xd6fc, LSL #0
    MOVK  X21, #0xb912, LSL #16
    MOVK  X21, #0x77e4, LSL #32
    MOVK  X21, #0x72bf, LSL #48
    SUB  X15, X21, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x3d4d, LSL #0
    MOVK  X8, #0x339f, LSL #16
    MOVK  X8, #0xa2ce, LSL #32
    MOVK  X8, #0x7274, LSL #48
    SUB  X5, X8, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x6e85, LSL #0
    MOVK  X8, #0x4547, LSL #16
    MOVK  X8, #0xbb7b, LSL #32
    MOVK  X8, #0x2a02, LSL #48
    SUB  X5, X8, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x1834, LSL #0
    MOVK  X13, #0x31b8, LSL #16
    MOVK  X13, #0x5a78, LSL #32
    MOVK  X13, #0xf6d9, LSL #48
    SUB  X11, X13, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x6e85, LSL #0
    MOVK  X11, #0x4547, LSL #16
    MOVK  X11, #0xbb7b, LSL #32
    MOVK  X11, #0x2a02, LSL #48
    SUB  X13, X11, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x8494, LSL #0
    MOVK  X17, #0x2a0d, LSL #16
    MOVK  X17, #0x8cab, LSL #32
    MOVK  X17, #0x15e2, LSL #48
    SUB  X11, X17, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x5669, LSL #0
    MOVK  X19, #0x922c, LSL #16
    MOVK  X19, #0xd90b, LSL #32
    MOVK  X19, #0xfd8a, LSL #48
    SUB  X11, X19, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X11
TaishanSimdAritheticP01_label_717:
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x1bb5, LSL #0
    MOVK  X15, #0x93b0, LSL #16
    MOVK  X15, #0xb227, LSL #32
    MOVK  X15, #0x7028, LSL #48
    SUB  X22, X15, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x121e, LSL #0
    MOVK  X21, #0xfca7, LSL #16
    MOVK  X21, #0x5630, LSL #32
    MOVK  X21, #0x3950, LSL #48
    SUB  X20, X21, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x1bb5, LSL #0
    MOVK  X18, #0x93b0, LSL #16
    MOVK  X18, #0xb227, LSL #32
    MOVK  X18, #0x7028, LSL #48
    SUB  X20, X18, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x8494, LSL #0
    MOVK  X26, #0x2a0d, LSL #16
    MOVK  X26, #0x8cab, LSL #32
    MOVK  X26, #0x15e2, LSL #48
    SUB  X27, X26, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X12, X15, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
TaishanSimdAritheticP01_label_1018:
    MOVZ  X5, #0x5669, LSL #0
    MOVK  X5, #0x922c, LSL #16
    MOVK  X5, #0xd90b, LSL #32
    MOVK  X5, #0xfd8a, LSL #48
    SUB  X11, X5, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x121e, LSL #0
    MOVK  X3, #0xfca7, LSL #16
    MOVK  X3, #0x5630, LSL #32
    MOVK  X3, #0x3950, LSL #48
    SUB  X12, X3, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0xe2db, LSL #0
    MOVK  X21, #0xfb05, LSL #16
    MOVK  X21, #0xa040, LSL #32
    MOVK  X21, #0x9757, LSL #48
    SUB  X11, X21, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0xa237, LSL #0
    MOVK  X23, #0x3f3a, LSL #16
    MOVK  X23, #0x85ae, LSL #32
    MOVK  X23, #0xc1ef, LSL #48
    SUB  X19, X23, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x90ab, LSL #0
    MOVK  X19, #0xcfbc, LSL #16
    MOVK  X19, #0xeae7, LSL #32
    MOVK  X19, #0x93b3, LSL #48
    SUB  X13, X19, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x8494, LSL #0
    MOVK  X17, #0x2a0d, LSL #16
    MOVK  X17, #0x8cab, LSL #32
    MOVK  X17, #0x15e2, LSL #48
    SUB  X16, X17, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0xaf31, LSL #0
    MOVK  X10, #0x894c, LSL #16
    MOVK  X10, #0x7298, LSL #32
    MOVK  X10, #0xa962, LSL #48
    SUB  X9, X10, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xff00, LSL #16
    MOVK  X13, #0xffff, LSL #32
    SUB  X11, X13, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D2
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xff00, LSL #16
    MOVK  X13, #0xffff, LSL #32
    SUB  X11, X13, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D4
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x7f80, LSL #16
    SUB  X13, X27, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D5
    MOVZ  X26, #0xefff, LSL #0
    MOVK  X26, #0xefff, LSL #16
    MOVK  X26, #0xefff, LSL #32
    MOVK  X26, #0xefff, LSL #48
    SUB  X8, X26, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D6
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D7
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0x7fff, LSL #48
    SUB  X2, X11, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xfe00, LSL #16
    MOVK  X12, #0xfffb, LSL #32
    MOVK  X12, #0x1fb, LSL #48
    SUB  X18, X12, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D8
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xfe00, LSL #16
    MOVK  X12, #0xfffb, LSL #32
    MOVK  X12, #0x1fb, LSL #48
    SUB  X18, X12, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D9
TaishanSimdAritheticP01_label_228:
    MOVZ  X21, #0xfff7, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X5, X21, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D10
    MOVZ  X26, #0xfdff, LSL #0
    MOVK  X26, #0xfdff, LSL #16
    SUB  X13, X26, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X12, X16, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D11
    MOVZ  X16, #0x10, LSL #0
    MOVK  X16, #0xff10, LSL #16
    MOVK  X16, #0x10, LSL #32
    SUB  X12, X16, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D13
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xa8, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xa8, LSL #48
    SUB  X6, X28, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xfff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xfff, LSL #48
    SUB  X18, X28, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D17
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D18
    MOVZ  X23, #0xfe00, LSL #0
    MOVK  X23, #0x7ef, LSL #16
    MOVK  X23, #0xfff0, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X6, X23, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D20
    MOVZ  X14, #0x40, LSL #0
    SUB  X9, X14, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D21
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xff, LSL #32
    SUB  X19, X25, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X5, #0xfdff, LSL #0
    MOVK  X5, #0xfdff, LSL #16
    MOVK  X5, #0xfdff, LSL #32
    MOVK  X5, #0xfdff, LSL #48
    SUB  X23, X5, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D22
    MOVZ  X5, #0xfdff, LSL #0
    MOVK  X5, #0xfdff, LSL #16
    MOVK  X5, #0xfdff, LSL #32
    MOVK  X5, #0xfdff, LSL #48
    SUB  X23, X5, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D23
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x20, LSL #16
    SUB  X18, X5, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D24
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D27
    MOVZ  X26, #0x1, LSL #0
    MOVK  X26, #0x20, LSL #32
    SUB  X15, X26, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D28
    MOVZ  X23, #0x8000, LSL #0
    SUB  X21, X23, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X2
    FMOV  V0.D[1], X25
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X27
    FMOV  V2.D[1], X14
    FMOV  D3, X6
    FMOV  V3.D[1], X7
    FMOV  D4, X17
    FMOV  V4.D[1], X14
    FMOV  D5, X3
    FMOV  V5.D[1], X11
    FMOV  D6, X25
    FMOV  V6.D[1], X4
    FMOV  D7, X15
    FMOV  V7.D[1], X21
    FMOV  D8, X10
    FMOV  V8.D[1], X20
    FMOV  D9, X28
    FMOV  V9.D[1], X7
    FMOV  D10, X4
    FMOV  V10.D[1], X28
    FMOV  D11, X19
    FMOV  V11.D[1], X17
    FMOV  D12, X18
    FMOV  V12.D[1], X28
    FMOV  D13, X12
    FMOV  V13.D[1], X10
    FMOV  D14, X21
    FMOV  V14.D[1], X12
    FMOV  D15, X18
    FMOV  V15.D[1], X11
    FMOV  D16, X13
    FMOV  V16.D[1], X28
    FMOV  D17, X13
    FMOV  V17.D[1], X20
    FMOV  D18, X16
    FMOV  V18.D[1], X24
    FMOV  D19, X24
    FMOV  V19.D[1], X15
    FMOV  D20, X23
    FMOV  V20.D[1], X10
    FMOV  D21, X18
    FMOV  V21.D[1], X14
    FMOV  D22, X25
    FMOV  V22.D[1], X16
    FMOV  D23, X25
    FMOV  V23.D[1], X23
    FMOV  D24, X18
    FMOV  V24.D[1], X11
    FMOV  D25, X26
    FMOV  V25.D[1], X4
    FMOV  D26, X12
    FMOV  V26.D[1], X12
    FMOV  D27, X5
    FMOV  V27.D[1], X11
    FMOV  D28, X7
    FMOV  V28.D[1], X16
    FMOV  D29, X21
    FMOV  V29.D[1], X13
    FMOV  D30, X21
    FMOV  V30.D[1], X20
    FMOV  D31, X28
    FMOV  V31.D[1], X13
    MOVZ  X17, #0xa, LSL #0
TaishanSimdAritheticP01_label_1315:
    UQRSHRN V15.8B, V27.8H, #1
    SQSHLU S9, S17, #0x1a
    SHRN V13.4H, V19.4S, #16
    SSRA  V17.2S, V3.2S, #32
    SQSHRUN2 V6.4S, V1.2D, #3
    USHR  V1.8B, V24.8B, #6
    SQRSHRUN V14.4H, V13.4S, #8
    RSHRN2 V16.16B, V3.8H, #3
    SSRA  V4.8B, V25.8B, #4
    UQSHL  H2, H26, H26
    MOVI  V16.2S, #0x71, LSL #8
    SQSHRN B17, H13, #5
    USHR V0.2D, V25.2D, #48
    UQSHRN S22, D0, #29
    SQSHRUN2 V18.8H, V16.4S, #12
    UQSHRN V28.2S, V1.2D, #28
    SQRSHRN2 V3.4S, V24.2D, #21
    UQRSHRN V22.4H, V23.4S, #4
    UQRSHRN B28, H31, #7
    SHRN2 V6.4S, V9.2D, #21
    SQSHRN B0, H11, #2
    SQSHLU H5, H9, #0xf
    SRI  V17.16B, V20.16B, #7
    URSHR D30, D24, #13
    SSRA V17.2D, V16.2D, #13
    UQRSHRN V25.2S, V31.2D, #17
    RSHRN V12.2S, V4.2D, #26
    SQSHL  V30.8B, V23.8B, #0x3
    SQSHRN2 V5.8H, V12.4S, #7
    SQSHRUN V7.8B, V2.8H, #5
    SRSHR V20.2D, V7.2D, #8
    URSHR D23, D15, #21
    UQSHL V14.2D, V17.2D, #0x27
    SSRA V24.2D, V20.2D, #52
    SQSHLU V26.2D, V27.2D, #0x19
    SHL V27.2D, V6.2D, #0x2
    URSRA V13.2D, V1.2D, #25
    USHLL2 V3.8H, V8.16B, #0x2
    UQSHL  H25, H24, H16
    SHLL  V19.4S, V28.4H, #16
    SRSRA  V11.4H, V30.4H, #9
    URSRA  V3.16B, V1.16B, #6
    SQSHRUN2 V2.16B, V13.8H, #5
    SQRSHRUN B9, H30, #3
    SQSHRN V3.2S, V26.2D, #18
    UQRSHRN2 V10.16B, V6.8H, #3
    SSRA  V18.4H, V8.4H, #2
    SQSHRN V1.2S, V27.2D, #8
    SSHLL V19.8H, V23.8B, #0x3
    UQSHRN V19.4H, V15.4S, #1
    SQSHLU D24, D20, #0x6
    SQRSHRUN B17, H12, #2
    SQSHRUN S19, D28, #27
    SQSHRUN H1, S16, #2
    SQSHRUN2 V6.16B, V24.8H, #7
    SRI  V24.2S, V16.2S, #20
    USHR  V0.8B, V26.8B, #2
    BIC  V26.4S, #0xa7, LSL #24
    SQRSHRN2 V13.16B, V1.8H, #6
    SHLL  V26.8H, V21.8B, #8
    SRSRA  V18.8B, V11.8B, #1
    UQSHRN V2.4H, V27.4S, #13
    USHLL V30.8H, V6.8B, #0x5
    SLI  V14.16B, V24.16B, #0x3
    UQSHRN B9, H26, #7
    FMOV  V2.4S, #1.18750000
    UQSHL  V7.8H, V4.8H, #0xa
    SQRSHRN B19, H0, #6
    SQRSHRUN V0.4H, V18.4S, #3
    UQSHRN H19, S2, #2
    SHRN2 V30.8H, V11.4S, #4
    MOVI  V3.2D, #18374966859431673600
    SHL D1, D19, #0x27
    SQRSHRUN S19, D7, #18
    UQSHL V2.2D, V31.2D, #0x35
    UQRSHRN B6, H29, #2
    SSRA  V2.4S, V18.4S, #17
    USHLL V9.2D, V29.2S, #0x17
    URSRA V17.2D, V28.2D, #20
    SRI D23, D15, #39
    USRA V6.2D, V30.2D, #6
    URSHR D18, D29, #49
    SSHLL V29.4S, V20.4H, #0x8
    UQRSHRN2 V7.4S, V5.2D, #2
    SRSRA  V16.8B, V20.8B, #2
    SQSHLU  V14.2S, V2.2S, #0x1e
    SQRSHRN B28, H27, #1
    SSHLL2 V31.8H, V31.16B, #0x3
    SQSHRN V13.2S, V5.2D, #27
    USRA V8.2D, V30.2D, #10
    UQRSHRN S7, D17, #14
    SHRN V31.8B, V16.8H, #1
    SSRA V29.2D, V11.2D, #52
    SQSHL  V26.4S, V14.4S, #0x12
    SQRSHRUN V29.2S, V10.2D, #12
    SSHR  V12.8H, V1.8H, #8
    SQSHRN V10.8B, V21.8H, #5
    UQRSHRN V10.4H, V7.4S, #9
    SRSHR  V26.2S, V30.2S, #19
    ORR  V7.4H, #0xf3, LSL #8
    MOVI  V5.8H, #0x7d, LSL #8
    SQSHLU  V18.16B, V21.16B, #0x3
    USRA D20, D15, #63
    SSRA D20, D31, #3
    UQRSHRN H11, S13, #15
    USHLL V31.8H, V26.8B, #0x4
    SQRSHRUN V28.2S, V14.2D, #8
    USHLL V16.8H, V1.8B, #0x6
    SQRSHRN B10, H15, #4
    SRI D31, D12, #3
    SSRA  V17.16B, V18.16B, #8
    SRSHR D25, D6, #49
    UQRSHRN H12, S4, #9
    SLI V10.2D, V7.2D, #0x19
    SHLL2  V18.2D, V20.4S, #32
    SHL  V10.4H, V10.4H, #0x0
    URSRA D15, D10, #51
    UQSHL S25, S26, #0x19
    SQSHRUN V12.2S, V12.2D, #27
    SSRA  V13.4H, V9.4H, #13
    SHL D30, D17, #0x4
    SQSHL V16.2D, V16.2D, #0x31
    SSHR  V1.16B, V2.16B, #1
    SQSHL H31, H1, #0x8
    SQSHRUN B6, H9, #8
    UQSHL S10, S20, #0x7
    UQSHL B14, B1, #0x2
    SQSHLU D31, D10, #0x36
    SRSRA D18, D22, #22
    SSHR V23.2D, V15.2D, #62
    SQRSHRN H2, S23, #6
    FMOV  V27.2D, #-4.25000000
    SRSHR  V14.4H, V7.4H, #9
    USRA  V29.8H, V24.8H, #13
    ORR  V27.8H, #0xd9
    SSRA  V26.4S, V21.4S, #7
    USRA D14, D31, #31
    MVNI  V26.8H, #0x66
    UQSHL  B18, B13, B15
    SQRSHRUN S25, D6, #1
    MVNI  V8.8H, #0x94, LSL #8
    SQSHLU  V16.8H, V25.8H, #0x4
    MOVI  V30.4H, #0x52
    SQRSHRUN H9, S1, #2
    SSRA D27, D2, #24
    UQRSHRN V24.8B, V16.8H, #3
    SHRN2 V13.8H, V19.4S, #2
    SSHR  V12.2S, V23.2S, #24
    BIC  V23.2S, #0xf9, LSL #24
    SQRSHRN V2.4H, V7.4S, #15
    UQSHL  V25.4S, V30.4S, #0x16
    MVNI  V12.2S, #0xbf, MSL #8
    UQRSHRN S7, D26, #13
    SSHLL V22.2D, V1.2S, #0x11
    UQSHL  V29.8B, V7.8B, V3.8B
    SRSHR  V28.8B, V2.8B, #4
    SRSHR  V16.4S, V23.4S, #17
    SQRSHRUN V15.4H, V29.4S, #10
    URSHR  V9.2S, V23.2S, #18
    USHR  V22.8B, V26.8B, #3
    URSRA  V19.4S, V29.4S, #17
    SSHLL2 V6.8H, V16.16B, #0x5
    USRA V28.2D, V0.2D, #20
    SLI D7, D28, #0x2a
    SQSHL  V21.16B, V25.16B, #0x2
    SSHR  V20.4S, V0.4S, #29
    USRA V24.2D, V20.2D, #33
    SQRSHRUN2 V30.4S, V15.2D, #22
    SSRA D23, D9, #57
    SRSRA  V9.16B, V9.16B, #4
    MVNI  V25.2S, #0xde, MSL #16
    SHLL2  V7.8H, V13.16B, #8
    SSHLL V22.2D, V9.2S, #0x4
    SRSHR V22.2D, V0.2D, #6
    UQSHL  V1.8H, V1.8H, V25.8H
    SQSHRUN V6.8B, V28.8H, #6
    SSHLL2 V29.2D, V30.4S, #0x11
    SRI  V22.2S, V30.2S, #5
    SQSHRUN V7.4H, V29.4S, #11
    RSHRN V15.8B, V16.8H, #5
    USHLL V23.8H, V24.8B, #0x7
    SQRSHRUN2 V14.8H, V26.4S, #4
    SHL  V9.4H, V24.4H, #0x7
    SQSHLU B14, B1, #0x2
    URSRA V19.2D, V23.2D, #64
    SLI V6.2D, V18.2D, #0x28
    SQRSHRN V26.2S, V26.2D, #23
    SSRA D13, D6, #43
    SQRSHRUN2 V30.16B, V13.8H, #8
    SSRA V7.2D, V17.2D, #55
    MOVI  V3.4H, #0xdd
    UQSHL  S3, S4, S29
    UQSHL  V15.8H, V3.8H, V13.8H
    SHRN V23.4H, V4.4S, #9
    MOVI  V20.2D, #71777218556067840
    SQSHLU B24, B28, #0x6
    USHR  V1.4H, V19.4H, #3
    SQRSHRN V0.4H, V23.4S, #7
    SRSHR V16.2D, V30.2D, #20
    URSHR  V12.8H, V14.8H, #14
    SUBS  X17, X17, #0x1
    B.NE  TaishanSimdAritheticP01_label_1315
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D2
    MOVZ  X25, #0xe602, LSL #0
    MOVK  X25, #0xe602, LSL #16
    SUB  X19, X25, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D3
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xf712, LSL #16
    SUB  X26, X11, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D4
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xf712, LSL #16
    MOVK  X23, #0xf712, LSL #48
    SUB  X25, X23, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X4, #0x7d00, LSL #0
    MOVK  X4, #0x7d00, LSL #16
    MOVK  X4, #0x7d00, LSL #32
    MOVK  X4, #0x7d00, LSL #48
    SUB  X25, X4, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D5
    MOVZ  X4, #0x7d00, LSL #0
    MOVK  X4, #0x7d00, LSL #16
    MOVK  X4, #0x7d00, LSL #32
    MOVK  X4, #0x7d00, LSL #48
    SUB  X25, X4, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D6
    MOVZ  X20, #0x37, LSL #0
    SUB  X16, X20, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X5, #0x6bff, LSL #0
    MOVK  X5, #0x6bff, LSL #16
    MOVK  X5, #0x6bff, LSL #32
    MOVK  X5, #0x6bff, LSL #48
    SUB  X19, X5, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D8
    MOVZ  X5, #0x6bff, LSL #0
    MOVK  X5, #0x6bff, LSL #16
    MOVK  X5, #0x6bff, LSL #32
    MOVK  X5, #0x6bff, LSL #48
    SUB  X19, X5, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D10
    MOVZ  X27, #0x800, LSL #0
    MOVK  X27, #0x800, LSL #16
    SUB  X5, X27, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D14
    MOVZ  X16, #0xc, LSL #0
    SUB  X13, X16, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D15
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xf712, LSL #16
    SUB  X9, X12, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D16
    MOVZ  X7, #0x2005, LSL #0
    MOVK  X7, #0x2005, LSL #16
    MOVK  X7, #0x5, LSL #32
    SUB  X14, X7, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D17
    MOVZ  X26, #0x10, LSL #0
    SUB  X20, X26, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D19
    MOVZ  X2, #0x3fc0, LSL #0
    SUB  X25, X2, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xff00, LSL #16
    MOVK  X5, #0xff, LSL #32
    MOVK  X5, #0xff, LSL #48
    SUB  X19, X5, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D20
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xff00, LSL #16
    MOVK  X5, #0xff, LSL #32
    MOVK  X5, #0xff, LSL #48
    SUB  X19, X5, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D21
    MOVZ  X20, #0xfcfc, LSL #0
    MOVK  X20, #0xfcfc, LSL #16
    MOVK  X20, #0xfcfc, LSL #32
    MOVK  X20, #0xfcfc, LSL #48
    SUB  X11, X20, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D22
    MOVZ  X25, #0x9002, LSL #0
    MOVK  X25, #0x2, LSL #16
    MOVK  X25, #0x9002, LSL #32
    MOVK  X25, #0x2, LSL #48
    SUB  X13, X25, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D23
    MOVZ  X5, #0x8900, LSL #0
    MOVK  X5, #0x8900, LSL #16
    SUB  X8, X5, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D25
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xff21, LSL #16
    MOVK  X24, #0xff21, LSL #48
    SUB  X13, X24, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D26
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    SUB  X4, X15, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D27
    MOVZ  X4, #0xd9, LSL #0
    MOVK  X4, #0xd9, LSL #16
    MOVK  X4, #0xd9, LSL #32
    MOVK  X4, #0xc0d9, LSL #48
    SUB  X3, X4, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D28
    MOVZ  X26, #0xdff, LSL #0
    MOVK  X26, #0xfe01, LSL #16
    SUB  X20, X26, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
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
TaishanSimdAritheticP01_label_92:
    MOVK  X19, #0xffff, LSL #48
TaishanSimdAritheticP01_label_382:
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
    FMOV  D0, X26
    FMOV  V0.D[1], X13
    FMOV  D1, X9
    FMOV  V1.D[1], X2
    FMOV  D2, X18
    FMOV  V2.D[1], X12
    FMOV  D3, X20
    FMOV  V3.D[1], X3
    FMOV  D4, X28
    FMOV  V4.D[1], X28
    FMOV  D5, X10
    FMOV  V5.D[1], X2
    FMOV  D6, X3
    FMOV  V6.D[1], X25
    FMOV  D7, X8
    FMOV  V7.D[1], X27
    FMOV  D8, X6
    FMOV  V8.D[1], X10
    FMOV  D9, X25
    FMOV  V9.D[1], X19
    FMOV  D10, X17
    FMOV  V10.D[1], X27
    FMOV  D11, X27
    FMOV  V11.D[1], X17
    FMOV  D12, X12
    FMOV  V12.D[1], X27
    FMOV  D13, X14
    FMOV  V13.D[1], X19
    FMOV  D14, X6
    FMOV  V14.D[1], X13
    FMOV  D15, X26
    FMOV  V15.D[1], X20
    FMOV  D16, X9
    FMOV  V16.D[1], X12
    FMOV  D17, X8
    FMOV  V17.D[1], X23
    FMOV  D18, X28
    FMOV  V18.D[1], X23
    FMOV  D19, X19
    FMOV  V19.D[1], X7
    FMOV  D20, X2
    FMOV  V20.D[1], X28
    FMOV  D21, X23
    FMOV  V21.D[1], X16
    FMOV  D22, X18
    FMOV  V22.D[1], X20
    FMOV  D23, X19
    FMOV  V23.D[1], X24
    FMOV  D24, X28
    FMOV  V24.D[1], X28
    FMOV  D25, X8
    FMOV  V25.D[1], X20
    FMOV  D26, X21
    FMOV  V26.D[1], X9
    FMOV  D27, X3
    FMOV  V27.D[1], X12
    FMOV  D28, X15
    FMOV  V28.D[1], X3
    FMOV  D29, X17
    FMOV  V29.D[1], X18
    FMOV  D30, X22
    FMOV  V30.D[1], X13
    FMOV  D31, X3
    FMOV  V31.D[1], X28
    MOVZ  X9, #0xf, LSL #0
TaishanSimdAritheticP01_label_1397:
    USRA  V5.8H, V2.8H, #7
    SSHLL2 V22.2D, V30.4S, #0x6
    SRI  V31.4S, V3.4S, #24
    USHLL V21.4S, V3.4H, #0x1
    SQSHRUN V23.4H, V2.4S, #14
    SHRN V9.4H, V28.4S, #11
    URSHR  V16.4H, V8.4H, #16
    SSHR  V27.8H, V6.8H, #3
    SQSHRUN2 V25.16B, V15.8H, #4
    SQRSHRUN V29.4H, V24.4S, #16
    SQRSHRN V7.8B, V28.8H, #1
    RSHRN2 V12.4S, V23.2D, #26
    UQSHL  V5.8H, V24.8H, V26.8H
    UQSHL S30, S31, #0xe
    SQRSHRN2 V30.4S, V31.2D, #16
    ORR  V22.4H, #0x4a
    UQSHRN V25.8B, V29.8H, #4
    MVNI  V31.4H, #0x50, LSL #8
    UQSHL V8.2D, V12.2D, #0x3f
    USRA  V19.4H, V16.4H, #4
    SQRSHRUN2 V30.16B, V0.8H, #7
    USRA D31, D8, #28
    SQSHRUN V2.2S, V19.2D, #6
    SRI  V18.4S, V30.4S, #8
    SQSHRN V7.8B, V12.8H, #7
    SLI D12, D18, #0xf
    USHLL2 V4.2D, V24.4S, #0x1c
    SQSHRN2 V27.8H, V28.4S, #13
    ORR  V28.4S, #0xd9, LSL #24
    SQSHRN B27, H15, #5
    SQSHRUN2 V9.16B, V14.8H, #1
    SQSHL B15, B29, #0x4
    SQSHRN2 V12.4S, V25.2D, #29
    SQSHL D0, D23, #0x0
    SQSHLU B19, B30, #0x1
    UQSHRN2 V16.8H, V17.4S, #13
    BIC  V6.4H, #0xa0, LSL #8
    UQSHRN B16, H23, #4
    SRSHR  V22.8H, V16.8H, #6
    SSRA  V25.4S, V2.4S, #13
    USHLL V2.4S, V30.4H, #0x3
    SQSHRUN2 V9.4S, V24.2D, #29
    MOVI  V19.2D, #18446742978476114175
    SQRSHRUN V15.8B, V7.8H, #6
    SQSHRUN S22, D10, #31
    SHRN2 V30.16B, V10.8H, #2
    UQSHL  S27, S8, S10
    SSRA  V2.4H, V26.4H, #3
    SRSHR D13, D27, #41
    SRI  V0.2S, V4.2S, #19
    SSHLL V9.2D, V17.2S, #0x1d
    SRSRA  V5.8B, V31.8B, #5
    UQSHL D28, D15, #0x1a
    SLI  V17.4H, V9.4H, #0x8
    SHRN2 V30.16B, V6.8H, #4
    SQSHL B21, B8, #0x4
    SLI  V0.8H, V12.8H, #0x4
    SQSHRUN2 V1.8H, V7.4S, #9
    SRSRA  V10.4S, V9.4S, #25
    UQSHL H13, H30, #0xe
    MOVI  V27.4S, #0x45, MSL #8
    SRSRA  V10.8B, V17.8B, #7
    SQSHLU  V19.8H, V15.8H, #0xe
    SHL  V12.4S, V18.4S, #0xe
    URSHR  V22.4H, V24.4H, #7
    SRSHR V14.2D, V12.2D, #32
    SHL V1.2D, V12.2D, #0x6
    SSRA  V26.16B, V22.16B, #5
    SHL D20, D9, #0xf
    USHLL V27.8H, V11.8B, #0x7
    SQSHLU D7, D28, #0x2e
    USHLL2 V12.2D, V25.4S, #0x6
    UQRSHRN V16.4H, V15.4S, #6
    UQSHRN V16.8B, V21.8H, #4
    UQSHRN2 V21.8H, V17.4S, #2
    SSHR V15.2D, V22.2D, #22
    SLI D18, D30, #0x22
    RSHRN V19.8B, V25.8H, #7
    URSHR V8.2D, V10.2D, #4
    SQRSHRN V5.8B, V10.8H, #5
    UQSHL  B15, B28, B10
    ORR  V13.8H, #0x23, LSL #8
    SQSHL H2, H18, #0xd
    SQSHRN2 V25.4S, V3.2D, #24
    SQSHRN H8, S27, #11
    SQSHL D9, D28, #0x32
    SQRSHRN S28, D4, #21
    UQSHL S3, S11, #0x0
    UQSHL  H24, H6, H29
    UQRSHRN V30.4H, V29.4S, #8
    SHL  V17.2S, V4.2S, #0xc
    SHRN V16.2S, V16.2D, #26
    SHL  V2.8B, V23.8B, #0x3
    SRSRA V13.2D, V4.2D, #24
    SQRSHRN V31.8B, V16.8H, #2
    SHRN V26.4H, V28.4S, #3
    SRI D31, D9, #6
    SRI D24, D25, #20
    SSRA D15, D12, #57
    SSHR  V18.16B, V5.16B, #3
    SQSHRUN S14, D10, #18
    UQSHL  H5, H3, H7
    SSHLL V14.2D, V27.2S, #0xa
    URSHR V5.2D, V19.2D, #48
    SQSHRUN H4, S30, #13
    ORR  V4.2S, #0xb8, LSL #24
    SRSHR  V29.8B, V3.8B, #7
    USRA V6.2D, V18.2D, #33
    MOVI  D4, #18446742978476113920
    UQSHL  B26, B31, B13
    MOVI  V22.2S, #0xc2, MSL #8
    RSHRN2 V30.16B, V3.8H, #1
    SLI  V7.8B, V24.8B, #0x3
    SQRSHRN2 V22.16B, V21.8H, #4
    UQSHL D7, D27, #0xd
    SQRSHRUN2 V10.16B, V29.8H, #7
    SSRA  V27.8B, V4.8B, #5
    SHL D12, D8, #0x2
    USHR  V30.4S, V15.4S, #20
    UQSHL  V28.8H, V5.8H, V12.8H
    RSHRN2 V8.4S, V28.2D, #18
    USHLL V26.8H, V30.8B, #0x1
    UQSHL  V12.4H, V13.4H, #0x8
    SQRSHRN V18.4H, V11.4S, #15
    SQRSHRUN B5, H5, #6
    SQRSHRUN V8.2S, V14.2D, #28
    SRI  V14.4S, V22.4S, #1
    USHLL V16.8H, V16.8B, #0x6
    USHR D29, D3, #46
    SSHR  V22.4H, V28.4H, #10
    USRA  V9.8B, V10.8B, #6
    SHL  V5.4S, V18.4S, #0x7
    SQRSHRUN2 V27.8H, V31.4S, #15
    USHR D29, D12, #18
    SQRSHRUN V7.2S, V16.2D, #5
    USHLL V0.2D, V27.2S, #0x1f
    SQRSHRN2 V8.4S, V13.2D, #26
    SRSRA  V18.16B, V18.16B, #7
    SQSHLU  V0.8H, V18.8H, #0xb
    URSHR  V0.4S, V21.4S, #4
    UQRSHRN2 V29.4S, V7.2D, #25
    SHL  V8.2S, V1.2S, #0x15
    MOVI  V29.2D, #72057589759672575
    USHR V14.2D, V0.2D, #48
    SQSHL  V0.4H, V5.4H, #0x2
    USHR V27.2D, V24.2D, #17
    UQRSHRN2 V1.16B, V1.8H, #1
    URSHR  V11.8H, V24.8H, #9
    UQSHL  H1, H0, H11
    UQSHRN V6.2S, V20.2D, #6
    SRSRA  V12.4H, V7.4H, #16
    SRSHR  V16.4S, V1.4S, #3
    UQSHRN V21.2S, V7.2D, #2
    USHLL V11.4S, V16.4H, #0x8
    UQSHRN V5.2S, V1.2D, #17
    SQRSHRN V12.4H, V11.4S, #13
    SHL  V8.8B, V24.8B, #0x4
    SQRSHRUN H21, S1, #1
    SQSHL  V16.4S, V6.4S, #0x7
    RSHRN2 V12.4S, V5.2D, #19
    URSHR  V9.2S, V5.2S, #28
    URSRA D8, D10, #8
    SQSHRUN S21, D8, #1
    SQRSHRN V26.2S, V14.2D, #10
    UQSHL  D29, D16, D9
    SQSHRUN V19.4H, V21.4S, #1
    UQSHL V21.2D, V24.2D, #0x27
    SSHR  V26.4S, V24.4S, #4
    SQRSHRN V24.2S, V12.2D, #13
    RSHRN V5.2S, V23.2D, #23
    RSHRN2 V19.16B, V17.8H, #6
    SSRA V14.2D, V10.2D, #49
    USHLL2 V21.2D, V20.4S, #0xc
    SQRSHRN H18, S2, #10
    UQSHRN2 V29.8H, V2.4S, #6
    SQSHLU  V1.8B, V19.8B, #0x2
    UQSHL D23, D16, #0x2
    MVNI  V26.4S, #0x6b, LSL #16
    SQSHL  V9.4S, V3.4S, #0x16
    UQSHL  H9, H23, H12
    SQSHRN2 V27.8H, V4.4S, #16
    SQRSHRN V19.8B, V27.8H, #7
    UQSHL  S26, S20, S17
    ORR  V24.8H, #0x12
    MOVI  V11.2D, #280375465082880
    MVNI  V9.4S, #0x84
    SQRSHRUN B3, H1, #3
    SQRSHRUN V19.8B, V4.8H, #4
    MOVI  D6, #281474976710400
    SHRN V12.8B, V3.8H, #7
    USRA  V29.4S, V15.4S, #1
    SLI  V1.4H, V10.4H, #0xa
    SRSRA  V10.8B, V29.8B, #7
    URSRA V11.2D, V27.2D, #62
    SSRA  V16.2S, V22.2S, #25
    SQRSHRUN S19, D3, #8
    SQSHRUN2 V14.4S, V26.2D, #17
    SQSHL H0, H24, #0xf
    USHLL V0.8H, V21.8B, #0x3
    UQSHRN B0, H25, #8
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdAritheticP01_label_1397
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X25, X22, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X6, X15, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X27, X2, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X16, X8, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X28, X12, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X15, X28, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X5, X9, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X13, X12, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X20, X12, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X15, X16, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D4
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xff00, LSL #16
    MOVK  X18, #0xff00, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X13, X18, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D6
    MOVZ  X2, #0xff00, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    SUB  X14, X2, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D8
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x100, LSL #48
    SUB  X16, X5, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X12, #0xff7b, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xff7b, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X10, X12, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D9
    MOVZ  X12, #0xff7b, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xff7b, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X10, X12, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D10
    MOVZ  X18, #0xffee, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X12, X18, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xff00, LSL #32
    SUB  X20, X26, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D11
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xff00, LSL #32
    SUB  X20, X26, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X24, #0x2420, LSL #0
    MOVK  X24, #0x2420, LSL #16
    MOVK  X24, #0x2300, LSL #32
    MOVK  X24, #0x2300, LSL #48
    SUB  X8, X24, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D13
    MOVZ  X24, #0x2420, LSL #0
    MOVK  X24, #0x2420, LSL #16
    MOVK  X24, #0x2300, LSL #32
    MOVK  X24, #0x2300, LSL #48
    SUB  X8, X24, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D14
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X5, X23, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D15
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X10, D17
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x1000, LSL #32
    MOVK  X2, #0x1200, LSL #48
    SUB  X12, X2, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D18
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X15, #0x12, LSL #0
    MOVK  X15, #0x12, LSL #16
    MOVK  X15, #0x12, LSL #32
    MOVK  X15, #0x12, LSL #48
    SUB  X3, X15, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D24
    MOVZ  X15, #0x12, LSL #0
    MOVK  X15, #0x12, LSL #16
    MOVK  X15, #0x12, LSL #32
    MOVK  X15, #0x12, LSL #48
    SUB  X3, X15, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D25
    MOVZ  X11, #0x101, LSL #0
    MOVK  X11, #0x101, LSL #16
    SUB  X27, X11, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D26
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X21, #0xff00, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X25, X21, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0xf6e1, LSL #0
    MOVK  X2, #0x9ce4, LSL #16
    MOVK  X2, #0x6dff, LSL #32
    MOVK  X2, #0x4d13, LSL #48
    MOVZ  X3, #0xe70f, LSL #0
    MOVK  X3, #0x3e62, LSL #16
    MOVK  X3, #0x9152, LSL #32
    MOVK  X3, #0xe6f2, LSL #48
    MOVZ  X4, #0x18e7, LSL #0
    MOVK  X4, #0x334b, LSL #16
    MOVK  X4, #0x20d3, LSL #32
    MOVK  X4, #0x1997, LSL #48
    MOVZ  X5, #0xb496, LSL #0
    MOVK  X5, #0x75f1, LSL #16
    MOVK  X5, #0xf1b5, LSL #32
    MOVK  X5, #0x62c9, LSL #48
    MOVZ  X6, #0x45d, LSL #0
    MOVK  X6, #0xbaa6, LSL #16
    MOVK  X6, #0x3079, LSL #32
    MOVK  X6, #0xd17d, LSL #48
    MOVZ  X7, #0xa342, LSL #0
    MOVK  X7, #0x8a2e, LSL #16
    MOVK  X7, #0x83fe, LSL #32
    MOVK  X7, #0x448b, LSL #48
    MOVZ  X8, #0x84c2, LSL #0
    MOVK  X8, #0xb4ad, LSL #16
    MOVK  X8, #0x591c, LSL #32
    MOVK  X8, #0x702e, LSL #48
    MOVZ  X9, #0xef0c, LSL #0
    MOVK  X9, #0xdfe2, LSL #16
    MOVK  X9, #0xd7d, LSL #32
    MOVK  X9, #0xe861, LSL #48
    MOVZ  X10, #0x94d, LSL #0
    MOVK  X10, #0xce2c, LSL #16
    MOVK  X10, #0xac20, LSL #32
    MOVK  X10, #0xf5ba, LSL #48
    MOVZ  X11, #0x3910, LSL #0
    MOVK  X11, #0xd0da, LSL #16
    MOVK  X11, #0x23b9, LSL #32
    MOVK  X11, #0x5fc7, LSL #48
    MOVZ  X12, #0xe6d5, LSL #0
    MOVK  X12, #0x238, LSL #16
    MOVK  X12, #0xd493, LSL #32
    MOVK  X12, #0x2cdc, LSL #48
    MOVZ  X13, #0x3fbe, LSL #0
    MOVK  X13, #0x7c9, LSL #16
    MOVK  X13, #0x82e7, LSL #32
    MOVK  X13, #0x7e33, LSL #48
    MOVZ  X14, #0x71ec, LSL #0
    MOVK  X14, #0x5387, LSL #16
    MOVK  X14, #0xbcf, LSL #32
    MOVK  X14, #0xe740, LSL #48
    MOVZ  X15, #0xc73, LSL #0
    MOVK  X15, #0x8664, LSL #16
    MOVK  X15, #0x132, LSL #32
    MOVK  X15, #0x7556, LSL #48
    MOVZ  X16, #0x48df, LSL #0
    MOVK  X16, #0x72d2, LSL #16
    MOVK  X16, #0xc1a8, LSL #32
    MOVK  X16, #0x6684, LSL #48
    MOVZ  X17, #0x5e0c, LSL #0
    MOVK  X17, #0x4eb5, LSL #16
    MOVK  X17, #0x45fc, LSL #32
    MOVK  X17, #0xeea8, LSL #48
    MOVZ  X18, #0xa4b0, LSL #0
    MOVK  X18, #0x9a20, LSL #16
    MOVK  X18, #0x16fa, LSL #32
    MOVK  X18, #0xe75f, LSL #48
    MOVZ  X19, #0x4e5c, LSL #0
    MOVK  X19, #0xe73b, LSL #16
    MOVK  X19, #0x713b, LSL #32
    MOVK  X19, #0xeec9, LSL #48
    MOVZ  X20, #0xe35d, LSL #0
    MOVK  X20, #0x5873, LSL #16
    MOVK  X20, #0xeed5, LSL #32
    MOVK  X20, #0xdf8c, LSL #48
    MOVZ  X21, #0xfbc1, LSL #0
    MOVK  X21, #0xe603, LSL #16
    MOVK  X21, #0xea1c, LSL #32
    MOVK  X21, #0x7fe6, LSL #48
    MOVZ  X22, #0x7010, LSL #0
    MOVK  X22, #0x9a94, LSL #16
    MOVK  X22, #0x468c, LSL #32
    MOVK  X22, #0x3265, LSL #48
    MOVZ  X23, #0xf75b, LSL #0
    MOVK  X23, #0xf27f, LSL #16
    MOVK  X23, #0x58db, LSL #32
    MOVK  X23, #0x4193, LSL #48
    MOVZ  X24, #0xc0dc, LSL #0
    MOVK  X24, #0x177c, LSL #16
    MOVK  X24, #0x165, LSL #32
    MOVK  X24, #0xfdcb, LSL #48
    MOVZ  X25, #0x37b6, LSL #0
    MOVK  X25, #0xefb8, LSL #16
    MOVK  X25, #0xf1f6, LSL #32
    MOVK  X25, #0x963, LSL #48
    MOVZ  X26, #0xf819, LSL #0
    MOVK  X26, #0xa1c4, LSL #16
    MOVK  X26, #0xefb0, LSL #32
    MOVK  X26, #0x791, LSL #48
    MOVZ  X27, #0x3831, LSL #0
    MOVK  X27, #0xb399, LSL #16
    MOVK  X27, #0xde71, LSL #32
    MOVK  X27, #0xa36b, LSL #48
    MOVZ  X28, #0x2707, LSL #0
    MOVK  X28, #0x9f97, LSL #16
    MOVK  X28, #0x83b2, LSL #32
    MOVK  X28, #0x9243, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X2
    FMOV  V1.D[1], X26
    FMOV  D2, X17
    FMOV  V2.D[1], X23
    FMOV  D3, X23
    FMOV  V3.D[1], X7
    FMOV  D4, X16
    FMOV  V4.D[1], X25
    FMOV  D5, X10
    FMOV  V5.D[1], X28
    FMOV  D6, X8
    FMOV  V6.D[1], X7
    FMOV  D7, X7
    FMOV  V7.D[1], X17
    FMOV  D8, X20
    FMOV  V8.D[1], X2
    FMOV  D9, X9
    FMOV  V9.D[1], X4
    FMOV  D10, X24
    FMOV  V10.D[1], X6
    FMOV  D11, X26
    FMOV  V11.D[1], X19
    FMOV  D12, X24
    FMOV  V12.D[1], X22
    FMOV  D13, X13
    FMOV  V13.D[1], X18
    FMOV  D14, X6
    FMOV  V14.D[1], X10
    FMOV  D15, X11
    FMOV  V15.D[1], X13
    FMOV  D16, X3
    FMOV  V16.D[1], X13
    FMOV  D17, X23
    FMOV  V17.D[1], X5
    FMOV  D18, X25
    FMOV  V18.D[1], X20
    FMOV  D19, X19
    FMOV  V19.D[1], X20
    FMOV  D20, X13
    FMOV  V20.D[1], X11
    FMOV  D21, X14
    FMOV  V21.D[1], X16
    FMOV  D22, X25
    FMOV  V22.D[1], X25
    FMOV  D23, X24
    FMOV  V23.D[1], X18
    FMOV  D24, X10
    FMOV  V24.D[1], X15
    FMOV  D25, X11
    FMOV  V25.D[1], X14
    FMOV  D26, X17
    FMOV  V26.D[1], X19
    FMOV  D27, X17
    FMOV  V27.D[1], X13
    FMOV  D28, X5
    FMOV  V28.D[1], X27
    FMOV  D29, X12
    FMOV  V29.D[1], X15
    FMOV  D30, X3
    FMOV  V30.D[1], X21
    FMOV  D31, X24
    FMOV  V31.D[1], X8
    MOVZ  X13, #0xa, LSL #0
TaishanSimdAritheticP01_label_1476:
    SRSHR  V29.16B, V29.16B, #4
    USRA V11.2D, V18.2D, #25
    SQRSHRUN2 V11.8H, V23.4S, #1
    UQSHRN S24, D30, #32
    UQSHRN V30.4H, V15.4S, #1
    SQRSHRN2 V22.8H, V25.4S, #3
    SQSHRN S29, D27, #11
    SQSHRN V27.2S, V30.2D, #24
    SQSHRUN V28.8B, V18.8H, #4
    SQRSHRUN H31, S18, #13
    SSRA D0, D21, #58
    SHLL2  V26.8H, V5.16B, #8
    SQSHL  V13.4S, V19.4S, #0x6
    SQSHLU  V10.8H, V18.8H, #0x8
    SSHLL V12.8H, V4.8B, #0x1
    UQRSHRN V19.2S, V11.2D, #6
    SSRA  V1.2S, V8.2S, #30
    SHL V23.2D, V31.2D, #0x35
    SHRN2 V23.8H, V4.4S, #3
    UQSHL  V19.8B, V22.8B, #0x4
    SSHLL V24.2D, V19.2S, #0x15
    SQSHRN V9.8B, V27.8H, #7
    FMOV  V27.2D, #-2.25000000
    SQSHRUN H11, S31, #5
    SQSHRN2 V19.16B, V28.8H, #4
    URSRA  V19.2S, V7.2S, #10
    SRSRA  V0.2S, V6.2S, #29
    USHLL V8.4S, V2.4H, #0xa
    RSHRN V5.2S, V10.2D, #5
    SQSHRUN2 V15.8H, V2.4S, #16
    UQSHRN B21, H11, #8
    UQSHRN B25, H16, #5
    UQSHL  V5.4S, V26.4S, #0x4
    SSHLL2 V7.2D, V14.4S, #0x11
    SRI V15.2D, V17.2D, #15
    SHRN2 V0.8H, V7.4S, #10
    BIC  V10.4H, #0xf2, LSL #8
    RSHRN V19.2S, V26.2D, #8
    UQSHRN2 V8.16B, V14.8H, #8
    SSHLL2 V11.2D, V15.4S, #0x1d
    USHLL V28.4S, V10.4H, #0x9
    SRSRA V21.2D, V8.2D, #30
    SSHLL2 V25.8H, V25.16B, #0x2
    UQRSHRN V21.4H, V19.4S, #7
    UQSHRN S5, D17, #8
    USHR  V2.4S, V31.4S, #23
    RSHRN2 V3.8H, V0.4S, #14
    SRSRA D0, D23, #26
    UQSHRN2 V21.4S, V19.2D, #18
    SRI  V17.2S, V26.2S, #20
    MOVI  V3.4S, #0xe5
    SSHLL2 V14.8H, V5.16B, #0x3
    SQSHL B0, B17, #0x3
    SHL V29.2D, V1.2D, #0x1e
    SQRSHRN V31.2S, V8.2D, #23
    SLI  V0.8H, V23.8H, #0x3
    USHLL V5.2D, V2.2S, #0x1d
    SSRA V10.2D, V3.2D, #20
    RSHRN2 V3.8H, V0.4S, #15
    SQSHLU H15, H14, #0x5
    USHR  V11.4H, V23.4H, #3
    UQSHRN H4, S0, #16
    SSRA  V5.8H, V8.8H, #1
    SRSHR  V18.8H, V27.8H, #9
    SQSHLU  V8.8H, V23.8H, #0x9
    SRI D28, D29, #54
    SSHLL V0.2D, V1.2S, #0x15
    SSHLL V14.2D, V20.2S, #0x17
    ORR  V25.4S, #0x74, LSL #24
    MOVI  D31, #18446463698227691775
    USHR V23.2D, V0.2D, #31
    SQSHRUN2 V11.16B, V26.8H, #1
    SSRA  V22.16B, V23.16B, #8
    UQSHL  S21, S23, S15
    SQSHRUN V17.8B, V26.8H, #4
    SLI  V3.8B, V10.8B, #0x4
    SQRSHRUN2 V8.4S, V5.2D, #29
    FMOV  V5.2S, #-0.43750000
    USHLL2 V5.8H, V1.16B, #0x7
    SQRSHRUN V18.8B, V10.8H, #2
    SQRSHRUN2 V0.8H, V9.4S, #4
    USHR D4, D7, #4
    SSHR V20.2D, V26.2D, #9
    SLI  V2.4H, V20.4H, #0xf
    UQSHRN V31.2S, V8.2D, #10
    UQRSHRN S29, D8, #29
    MVNI  V1.8H, #0x93
    SQRSHRUN V2.4H, V2.4S, #5
    USRA  V20.2S, V15.2S, #20
    SQRSHRN2 V19.8H, V31.4S, #8
    SQSHL D11, D15, #0x5
    UQSHL V4.2D, V31.2D, #0x5
    UQSHL V18.2D, V15.2D, #0x26
    USHR  V11.16B, V3.16B, #5
    SQRSHRN V9.2S, V15.2D, #27
    SSHLL2 V22.2D, V16.4S, #0x6
    SHL  V12.4S, V2.4S, #0x0
    SQRSHRN B12, H18, #2
    FMOV  V6.2D, #1.06250000
    SSHLL V18.8H, V3.8B, #0x1
    URSHR  V20.8H, V2.8H, #1
    URSHR  V1.8B, V18.8B, #6
    SSRA D6, D1, #45
    UQRSHRN2 V17.16B, V3.8H, #8
    SQRSHRUN2 V13.4S, V30.2D, #22
    SQRSHRUN H13, S31, #3
    SQSHRUN B4, H0, #8
    SHL  V30.8H, V30.8H, #0x2
    URSRA  V30.4S, V6.4S, #5
    USHLL2 V9.2D, V1.4S, #0x18
    UQSHL  V3.16B, V26.16B, #0x5
    SHRN V14.4H, V6.4S, #16
    BIC  V6.2S, #0x6f
    SQSHL S22, S4, #0x1
    SHLL  V17.2D, V7.2S, #32
    USHR  V26.4H, V31.4H, #13
    SQRSHRN V27.8B, V26.8H, #1
    UQSHL D16, D17, #0xc
    UQSHRN V20.4H, V13.4S, #10
    UQSHL  V13.4S, V27.4S, #0xa
    SQSHLU  V8.4H, V17.4H, #0xe
    USHLL2 V30.4S, V8.8H, #0xf
    USHR  V18.8H, V5.8H, #4
    ORR  V11.2S, #0xaa
    SHLL  V21.2D, V29.2S, #32
    SRI D30, D14, #55
    SRSRA  V1.8H, V5.8H, #11
    URSRA  V8.4H, V20.4H, #15
    UQSHRN H10, S5, #9
    SRI  V16.4S, V15.4S, #8
    SSRA  V21.8B, V15.8B, #8
    UQSHRN2 V27.8H, V25.4S, #16
    MVNI  V7.4H, #0x40
    USHR  V13.4S, V20.4S, #30
    MOVI  V17.8H, #0xbc
    SQSHRUN S3, D17, #14
    URSRA D18, D26, #35
    SRSHR  V28.8H, V30.8H, #16
    SQSHL B9, B11, #0x1
    UQRSHRN B30, H29, #7
    SQRSHRN V17.4H, V22.4S, #15
    URSHR  V27.8B, V28.8B, #7
    URSRA  V28.8H, V26.8H, #2
    UQSHL S14, S18, #0xf
    SQRSHRN H27, S9, #10
    SQRSHRUN2 V18.4S, V9.2D, #32
    SQSHL B19, B17, #0x7
    RSHRN V2.4H, V25.4S, #7
    ORR  V28.4H, #0xb3, LSL #8
    SQRSHRN V15.2S, V20.2D, #24
    USRA V9.2D, V17.2D, #50
    SQSHL B22, B10, #0x1
    ORR  V19.8H, #0x5c, LSL #8
    UQSHL V11.2D, V20.2D, #0x29
    SLI  V7.2S, V25.2S, #0x9
    UQSHL S11, S6, #0x0
    SRSHR D1, D13, #61
    SQSHRUN2 V28.8H, V17.4S, #12
    UQRSHRN2 V9.4S, V18.2D, #31
    SQSHRUN2 V18.4S, V29.2D, #1
    USRA  V23.4H, V16.4H, #15
    UQSHRN V12.4H, V10.4S, #7
    USRA D20, D27, #16
    USHR  V11.2S, V23.2S, #23
    RSHRN2 V9.4S, V3.2D, #18
    SQRSHRN V29.4H, V16.4S, #2
    USRA V25.2D, V9.2D, #20
    SSHR D6, D8, #51
    SLI  V13.8B, V8.8B, #0x1
    URSRA D27, D7, #12
    SQRSHRUN2 V10.4S, V15.2D, #5
    SSHLL V14.8H, V18.8B, #0x3
    UQRSHRN H12, S4, #11
    MVNI  V30.4S, #0x8c, MSL #16
    SRI  V12.16B, V8.16B, #5
    UQRSHRN H23, S4, #4
    SQRSHRN2 V27.16B, V9.8H, #1
    MOVI  V31.4S, #0xf0, MSL #8
    SQRSHRN S7, D23, #8
    SQRSHRN B30, H12, #6
TaishanSimdAritheticP01_label_480:
    USRA  V23.8B, V27.8B, #3
    UQRSHRN V12.4H, V18.4S, #15
    MOVI  V18.2S, #0xe6, MSL #8
    SQRSHRUN V31.8B, V27.8H, #7
    SHL  V25.16B, V15.16B, #0x3
    USHLL V17.4S, V13.4H, #0xd
    BIC  V31.4S, #0x65, LSL #8
    SQSHLU  V29.8B, V28.8B, #0x1
    UQRSHRN2 V31.4S, V9.2D, #16
    SHRN2 V25.16B, V28.8H, #1
    SQSHRN V6.2S, V17.2D, #3
    SSRA  V19.8H, V13.8H, #7
    SQSHRN V24.2S, V10.2D, #12
    URSHR V26.2D, V30.2D, #50
    SSHLL V27.2D, V7.2S, #0x3
    SHRN V4.4H, V15.4S, #13
    SQSHRN S18, D4, #20
    URSHR  V15.2S, V14.2S, #3
    USHR  V28.4H, V25.4H, #1
    SRSHR  V12.4H, V30.4H, #16
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdAritheticP01_label_1476
    MOVZ  X25, #0xf6e1, LSL #0
    MOVK  X25, #0x9ce4, LSL #16
    MOVK  X25, #0x6dff, LSL #32
    MOVK  X25, #0x4d13, LSL #48
    SUB  X15, X25, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0xe70f, LSL #0
    MOVK  X8, #0x3e62, LSL #16
    MOVK  X8, #0x9152, LSL #32
    MOVK  X8, #0xe6f2, LSL #48
    SUB  X27, X8, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x18e7, LSL #0
    MOVK  X24, #0x334b, LSL #16
    MOVK  X24, #0x20d3, LSL #32
    MOVK  X24, #0x1997, LSL #48
    SUB  X18, X24, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X23, #0xb496, LSL #0
    MOVK  X23, #0x75f1, LSL #16
    MOVK  X23, #0xf1b5, LSL #32
    MOVK  X23, #0x62c9, LSL #48
    SUB  X16, X23, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x45d, LSL #0
    MOVK  X9, #0xbaa6, LSL #16
    MOVK  X9, #0x3079, LSL #32
    MOVK  X9, #0xd17d, LSL #48
    SUB  X13, X9, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0xa342, LSL #0
    MOVK  X17, #0x8a2e, LSL #16
    MOVK  X17, #0x83fe, LSL #32
    MOVK  X17, #0x448b, LSL #48
    SUB  X18, X17, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0xe70f, LSL #0
    MOVK  X18, #0x3e62, LSL #16
    MOVK  X18, #0x9152, LSL #32
    MOVK  X18, #0xe6f2, LSL #48
    SUB  X15, X18, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0x45d, LSL #0
    MOVK  X19, #0xbaa6, LSL #16
    MOVK  X19, #0x3079, LSL #32
    MOVK  X19, #0xd17d, LSL #48
    SUB  X3, X19, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x94d, LSL #0
    MOVK  X21, #0xce2c, LSL #16
    MOVK  X21, #0xac20, LSL #32
    MOVK  X21, #0xf5ba, LSL #48
    SUB  X27, X21, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x3910, LSL #0
    MOVK  X24, #0xd0da, LSL #16
    MOVK  X24, #0x23b9, LSL #32
    MOVK  X24, #0x5fc7, LSL #48
    SUB  X10, X24, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0xe6d5, LSL #0
    MOVK  X20, #0x238, LSL #16
    MOVK  X20, #0xd493, LSL #32
    MOVK  X20, #0x2cdc, LSL #48
    SUB  X10, X20, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x71ec, LSL #0
    MOVK  X11, #0x5387, LSL #16
    MOVK  X11, #0xbcf, LSL #32
    MOVK  X11, #0xe740, LSL #48
    SUB  X12, X11, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0xa342, LSL #0
    MOVK  X4, #0x8a2e, LSL #16
    MOVK  X4, #0x83fe, LSL #32
    MOVK  X4, #0x448b, LSL #48
    SUB  X14, X4, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0xe70f, LSL #0
    MOVK  X14, #0x3e62, LSL #16
    MOVK  X14, #0x9152, LSL #32
    MOVK  X14, #0xe6f2, LSL #48
    SUB  X18, X14, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x94d, LSL #0
    MOVK  X9, #0xce2c, LSL #16
    MOVK  X9, #0xac20, LSL #32
    MOVK  X9, #0xf5ba, LSL #48
    SUB  X11, X9, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0x7010, LSL #0
    MOVK  X28, #0x9a94, LSL #16
    MOVK  X28, #0x468c, LSL #32
    MOVK  X28, #0x3265, LSL #48
TaishanSimdAritheticP01_label_193:
    SUB  X11, X28, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0xb496, LSL #0
    MOVK  X7, #0x75f1, LSL #16
    MOVK  X7, #0xf1b5, LSL #32
    MOVK  X7, #0x62c9, LSL #48
    SUB  X23, X7, X23
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x3910, LSL #0
    MOVK  X14, #0xd0da, LSL #16
    MOVK  X14, #0x23b9, LSL #32
    MOVK  X14, #0x5fc7, LSL #48
    SUB  X24, X14, X24
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0xf6e1, LSL #0
    MOVK  X21, #0x9ce4, LSL #16
    MOVK  X21, #0x6dff, LSL #32
    MOVK  X21, #0x4d13, LSL #48
    SUB  X7, X21, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x7010, LSL #0
    MOVK  X11, #0x9a94, LSL #16
    MOVK  X11, #0x468c, LSL #32
    MOVK  X11, #0x3265, LSL #48
    SUB  X10, X11, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D3
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    SUB  X16, X19, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X15, X26, X9
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X27, #0x4000, LSL #0
    SUB  X12, X27, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D9
    MOVZ  X27, #0x80, LSL #0
    SUB  X12, X27, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D15
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D16
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X5, D18
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X8, #0x5c00, LSL #0
    MOVK  X8, #0x5c00, LSL #16
    MOVK  X8, #0x5c00, LSL #32
    MOVK  X8, #0x5c00, LSL #48
    SUB  X21, X8, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X6, D19
    MOVZ  X8, #0x5c00, LSL #0
    MOVK  X8, #0x5c00, LSL #16
    MOVK  X8, #0x5c00, LSL #32
    MOVK  X8, #0x5c00, LSL #48
    SUB  X21, X8, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D20
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D23
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x31e, LSL #16
    SUB  X20, X28, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X9, #0x8080, LSL #0
    MOVK  X9, #0x8080, LSL #16
    SUB  X14, X9, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D27
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D28
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
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
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X13
    FMOV  V0.D[1], X5
    FMOV  D1, X16
    FMOV  V1.D[1], X18
    FMOV  D2, X5
    FMOV  V2.D[1], X9
    FMOV  D3, X10
    FMOV  V3.D[1], X23
    FMOV  D4, X3
    FMOV  V4.D[1], X11
    FMOV  D5, X17
    FMOV  V5.D[1], X28
    FMOV  D6, X13
    FMOV  V6.D[1], X21
    FMOV  D7, X8
    FMOV  V7.D[1], X17
    FMOV  D8, X24
    FMOV  V8.D[1], X12
    FMOV  D9, X8
    FMOV  V9.D[1], X26
    FMOV  D10, X15
    FMOV  V10.D[1], X2
    FMOV  D11, X23
    FMOV  V11.D[1], X13
    FMOV  D12, X9
    FMOV  V12.D[1], X9
    FMOV  D13, X17
    FMOV  V13.D[1], X24
    FMOV  D14, X18
    FMOV  V14.D[1], X12
    FMOV  D15, X2
    FMOV  V15.D[1], X8
    FMOV  D16, X16
    FMOV  V16.D[1], X21
    FMOV  D17, X28
    FMOV  V17.D[1], X23
    FMOV  D18, X8
    FMOV  V18.D[1], X16
    FMOV  D19, X11
    FMOV  V19.D[1], X20
    FMOV  D20, X16
    FMOV  V20.D[1], X23
    FMOV  D21, X21
    FMOV  V21.D[1], X17
    FMOV  D22, X28
    FMOV  V22.D[1], X28
    FMOV  D23, X12
    FMOV  V23.D[1], X14
    FMOV  D24, X18
    FMOV  V24.D[1], X28
    FMOV  D25, X12
    FMOV  V25.D[1], X26
    FMOV  D26, X6
    FMOV  V26.D[1], X18
    FMOV  D27, X18
    FMOV  V27.D[1], X20
    FMOV  D28, X14
    FMOV  V28.D[1], X20
    FMOV  D29, X26
    FMOV  V29.D[1], X20
    FMOV  D30, X17
    FMOV  V30.D[1], X27
    FMOV  D31, X14
    FMOV  V31.D[1], X6
    MOVZ  X10, #0xa, LSL #0
TaishanSimdAritheticP01_label_1557:
    SQSHRN B0, H12, #1
    SRI  V8.2S, V15.2S, #7
    SHRN2 V28.4S, V4.2D, #30
    SSRA D14, D14, #14
    RSHRN2 V27.4S, V27.2D, #10
    RSHRN V21.2S, V16.2D, #10
    SHRN2 V29.16B, V2.8H, #1
    UQSHL  V24.4S, V0.4S, #0x0
    SRI  V30.4S, V25.4S, #24
    SQSHRN V30.8B, V6.8H, #6
    BIC  V30.2S, #0x17, LSL #8
    RSHRN V19.4H, V15.4S, #10
    SQRSHRN2 V25.8H, V18.4S, #14
    SHL  V19.8B, V18.8B, #0x0
    UQSHL  V2.2S, V17.2S, #0xe
    SQSHL  V24.4H, V21.4H, #0x5
    RSHRN2 V28.4S, V30.2D, #10
    SQSHRUN V8.4H, V7.4S, #10
    MOVI  V20.2S, #0xb8, LSL #24
    UQRSHRN2 V12.4S, V17.2D, #13
    SLI  V17.2S, V12.2S, #0x4
    SSRA  V4.8H, V17.8H, #15
    USHR  V21.2S, V23.2S, #21
    UQSHL D2, D21, #0x1f
    UQRSHRN2 V3.16B, V27.8H, #7
    UQSHRN2 V24.4S, V31.2D, #3
    USHLL V1.8H, V27.8B, #0x6
    SQSHL  V19.8H, V7.8H, #0x0
    SRI D25, D4, #22
    UQSHL D31, D22, #0x37
    SRSHR D28, D11, #13
    SSRA  V28.2S, V12.2S, #1
    UQSHRN B8, H12, #6
    URSRA D18, D31, #23
    SSHLL V12.2D, V3.2S, #0x18
    RSHRN2 V31.4S, V30.2D, #21
    MVNI  V30.2S, #0x7d, MSL #8
    MOVI  V20.2D, #71777214294589440
    SQSHRUN B3, H3, #4
    RSHRN V2.2S, V8.2D, #3
    SRSHR  V29.16B, V17.16B, #8
    UQSHRN V6.8B, V2.8H, #7
    SQSHRUN H5, S7, #7
    UQSHL  V8.8H, V17.8H, V14.8H
    FMOV  V17.4S, #-1.87500000
    SQSHRUN S20, D22, #26
    UQSHL B2, B4, #0x7
    UQSHRN V11.4H, V18.4S, #13
    UQSHRN B2, H16, #4
    SQSHRUN2 V30.4S, V8.2D, #32
    SRSRA  V25.16B, V10.16B, #4
    SLI V13.2D, V8.2D, #0x13
    SQRSHRN2 V20.8H, V13.4S, #13
    SHRN2 V22.8H, V23.4S, #14
    SSRA D31, D8, #57
    UQRSHRN2 V8.8H, V29.4S, #1
    URSRA D30, D3, #62
    SQSHLU  V21.2S, V31.2S, #0x1d
    SSHLL2 V29.4S, V31.8H, #0xf
    FMOV  V13.2D, #1.62500000
    SQSHLU  V31.16B, V13.16B, #0x7
    SHL  V7.16B, V25.16B, #0x0
    SQRSHRUN V3.8B, V3.8H, #8
    UQSHRN2 V7.4S, V7.2D, #9
    SRSRA  V21.8B, V4.8B, #2
    SSHLL V5.8H, V19.8B, #0x7
    SQSHRUN2 V15.4S, V6.2D, #22
    SSRA  V29.8B, V22.8B, #6
    FMOV  V15.2D, #0.26562500
    SHL  V3.8H, V6.8H, #0x2
    SHRN V21.2S, V23.2D, #4
    SRI D5, D18, #26
    SRSRA  V7.2S, V2.2S, #4
    SQRSHRN2 V4.16B, V0.8H, #5
    USHLL2 V13.8H, V28.16B, #0x1
    UQSHRN B13, H13, #4
    URSRA D30, D14, #62
    SSRA V6.2D, V22.2D, #17
    SHRN V14.8B, V8.8H, #3
    URSHR  V8.2S, V0.2S, #10
    SSHR  V18.4H, V18.4H, #15
    UQRSHRN V22.8B, V17.8H, #5
    SQSHL B17, B5, #0x3
    SQSHLU  V4.8H, V14.8H, #0x8
    SQRSHRN2 V6.8H, V23.4S, #16
    UQSHRN2 V17.8H, V15.4S, #6
    MOVI  V2.4H, #0xb9
    BIC  V11.2S, #0xd, LSL #8
    SQSHRUN B21, H25, #5
    UQSHRN2 V15.8H, V18.4S, #15
    RSHRN2 V25.4S, V11.2D, #28
    SSRA V2.2D, V7.2D, #23
    SHRN V25.8B, V17.8H, #3
    SQSHL H27, H28, #0xa
    USHR V26.2D, V30.2D, #62
    SQRSHRUN V9.4H, V31.4S, #8
    SRSRA  V5.8B, V18.8B, #7
    UQSHL  V25.4H, V26.4H, #0x7
    USHR  V6.2S, V30.2S, #8
    UQSHL  V26.2S, V2.2S, V1.2S
    SHL V22.2D, V31.2D, #0x19
    SQSHL  V9.2S, V2.2S, #0x6
    SHRN2 V24.16B, V27.8H, #4
    MOVI  V23.2S, #0x9c, LSL #24
    SLI  V31.8B, V22.8B, #0x5
    UQSHL  S25, S24, S29
    SQRSHRN2 V28.16B, V0.8H, #8
    USRA D23, D6, #23
    SRSRA  V16.4S, V16.4S, #9
    FMOV  V25.4S, #1.00000000
    SSHR V4.2D, V0.2D, #60
    MOVI  V23.4H, #0xef
    SHL V8.2D, V11.2D, #0x3b
    USHR  V11.8H, V11.8H, #12
    SQRSHRN H31, S15, #2
    ORR  V12.2S, #0x2a
    SLI  V23.8B, V4.8B, #0x6
    SQSHLU  V19.4H, V14.4H, #0x1
    SQSHRUN2 V29.16B, V30.8H, #5
    UQSHL  B16, B9, B12
    USHLL V29.8H, V29.8B, #0x1
    SQSHLU V26.2D, V0.2D, #0x34
    SQRSHRUN V28.8B, V0.8H, #5
    SLI  V4.8B, V11.8B, #0x2
    SSRA V0.2D, V31.2D, #4
    UQSHRN V13.8B, V27.8H, #4
    SQRSHRN V31.4H, V4.4S, #7
    SQRSHRUN2 V11.16B, V31.8H, #1
    SQSHRUN S12, D5, #3
    UQRSHRN S18, D23, #24
    SSHR V9.2D, V25.2D, #33
    SLI D9, D0, #0x37
    SRSHR  V12.16B, V26.16B, #6
    RSHRN2 V2.8H, V19.4S, #4
    UQSHL  S0, S24, S5
    UQSHL  V28.8H, V10.8H, #0x6
    SLI  V24.8B, V16.8B, #0x3
    USHR V14.2D, V24.2D, #8
    SRI D18, D30, #24
    URSRA V10.2D, V29.2D, #38
    SQSHRN H21, S11, #7
    SSRA V21.2D, V28.2D, #34
    USHLL2 V13.2D, V12.4S, #0x15
    UQSHRN S23, D14, #7
    SRSHR V3.2D, V31.2D, #48
    SSRA D15, D11, #46
    MVNI  V20.4S, #0xf4, MSL #16
    SRSRA D1, D2, #16
    SSRA V8.2D, V11.2D, #49
    UQSHRN V1.4H, V9.4S, #2
    SQRSHRUN2 V5.8H, V17.4S, #15
    BIC  V20.2S, #0xe0, LSL #16
    SRSHR  V27.8B, V25.8B, #6
    SRSHR V16.2D, V18.2D, #43
    USHR  V18.4S, V22.4S, #16
    UQSHL  V29.16B, V12.16B, #0x5
    UQSHL  V25.16B, V0.16B, #0x5
    SRI  V27.16B, V13.16B, #5
    UQSHRN V1.4H, V21.4S, #12
    SQSHLU H19, H9, #0x6
    UQSHL  V17.4H, V25.4H, #0x1
    UQSHL B20, B24, #0x3
    FMOV  V16.4S, #0.84375000
    SQSHLU H18, H16, #0x4
    SSHLL V3.8H, V24.8B, #0x3
    USHR V27.2D, V15.2D, #12
    URSHR D21, D29, #58
    UQSHRN V20.8B, V25.8H, #1
    UQSHL  H1, H30, H28
    SRSHR  V9.2S, V15.2S, #12
    RSHRN V18.8B, V19.8H, #3
    MOVI  V20.8B, #0x86
    SRSHR D23, D20, #12
    SSHLL V13.4S, V28.4H, #0x3
    SHL  V4.8B, V15.8B, #0x3
    SQRSHRUN S12, D19, #13
    SSRA  V6.8B, V13.8B, #6
    USHR D4, D6, #46
    SQSHRUN B13, H4, #6
    SRI  V23.8H, V22.8H, #13
    SHL  V21.8B, V22.8B, #0x0
    UQSHL B25, B0, #0x4
    SHLL  V27.4S, V15.4H, #16
    UQSHRN2 V19.8H, V28.4S, #5
    UQSHRN2 V3.8H, V3.4S, #8
    URSRA V22.2D, V15.2D, #55
    URSHR  V6.8B, V22.8B, #4
    SHL  V30.8H, V17.8H, #0xb
    SQSHL  V16.8B, V30.8B, #0x3
    SQRSHRUN2 V24.4S, V0.2D, #22
    UQRSHRN S26, D21, #32
    URSHR  V18.16B, V5.16B, #1
    UQRSHRN V29.4H, V9.4S, #12
    SLI  V18.4S, V6.4S, #0x1e
    SQSHRUN2 V25.8H, V29.4S, #13
    UQSHL S24, S23, #0x13
    SRSHR D10, D9, #47
    SQSHL S20, S6, #0x1c
    UQSHL  S3, S9, S22
    SQSHLU S18, S30, #0xb
    SUBS  X10, X10, #0x1
    B.NE  TaishanSimdAritheticP01_label_1557
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
TaishanSimdAritheticP01_label_736:
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D2
    MOVZ  X10, #0xb9, LSL #0
    MOVK  X10, #0xb9, LSL #16
    MOVK  X10, #0xb9, LSL #32
    MOVK  X10, #0xb9, LSL #48
    SUB  X23, X10, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D4
    MOVZ  X22, #0x3ff, LSL #0
    SUB  X2, X22, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D5
    MOVZ  X9, #0x2000, LSL #0
    SUB  X22, X9, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X22, D6
    MOVZ  X3, #0x8, LSL #0
    SUB  X24, X3, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X14, D7
    MOVZ  X12, #0x1, LSL #0
    SUB  X16, X12, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X4, X26, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D9
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xfd10, LSL #32
    MOVK  X16, #0x3, LSL #48
    SUB  X8, X16, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D10
    MOVZ  X9, #0x8, LSL #0
    SUB  X11, X9, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D11
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X7, D13
    MOVZ  X12, #0xf, LSL #0
    SUB  X27, X12, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D15
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x3fd1, LSL #48
    SUB  X19, X8, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D16
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D17
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D18
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X15, #0x10, LSL #0
    SUB  X22, X15, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X16, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D20
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x7fff, LSL #16
    SUB  X18, X6, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X23, D21
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X4, D22
    MOVZ  X27, #0x80, LSL #0
    SUB  X18, X27, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D23
    MOVZ  X22, #0x6868, LSL #0
    MOVK  X22, #0x6868, LSL #16
    MOVK  X22, #0x6868, LSL #32
    MOVK  X22, #0xfff8, LSL #48
TaishanSimdAritheticP01_label_1168:
    SUB  X14, X22, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D24
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X3, X11, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdAritheticP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X2, #0x200, LSL #0
    SUB  X24, X2, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X18, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X11, D26
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x3fd1, LSL #48
    SUB  X2, X22, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X26, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X20, D28
    MOVZ  X16, #0x200, LSL #0
    SUB  X2, X16, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
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
TaishanSimdAritheticP01_label_849:
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
TaishanSimdAritheticP01_label_667:
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
    FMOV  D0, X9
    FMOV  V0.D[1], X25
    FMOV  D1, X3
    FMOV  V1.D[1], X11
    FMOV  D2, X6
    FMOV  V2.D[1], X15
    FMOV  D3, X10
    FMOV  V3.D[1], X10
    FMOV  D4, X18
    FMOV  V4.D[1], X2
    FMOV  D5, X4
    FMOV  V5.D[1], X18
    FMOV  D6, X28
    FMOV  V6.D[1], X27
    FMOV  D7, X3
    FMOV  V7.D[1], X26
    FMOV  D8, X26
    FMOV  V8.D[1], X6
    FMOV  D9, X9
    FMOV  V9.D[1], X13
    FMOV  D10, X22
    FMOV  V10.D[1], X16
    FMOV  D11, X15
    FMOV  V11.D[1], X6
    FMOV  D12, X24
    FMOV  V12.D[1], X26
    FMOV  D13, X9
    FMOV  V13.D[1], X7
    FMOV  D14, X6
    FMOV  V14.D[1], X22
    FMOV  D15, X28
    FMOV  V15.D[1], X23
    FMOV  D16, X13
    FMOV  V16.D[1], X3
    FMOV  D17, X12
    FMOV  V17.D[1], X12
    FMOV  D18, X4
    FMOV  V18.D[1], X26
    FMOV  D19, X26
    FMOV  V19.D[1], X21
    FMOV  D20, X12
    FMOV  V20.D[1], X12
    FMOV  D21, X7
    FMOV  V21.D[1], X21
    FMOV  D22, X15
    FMOV  V22.D[1], X10
    FMOV  D23, X11
    FMOV  V23.D[1], X3
    FMOV  D24, X2
    FMOV  V24.D[1], X17
    FMOV  D25, X11
    FMOV  V25.D[1], X11
    FMOV  D26, X4
    FMOV  V26.D[1], X23
    FMOV  D27, X27
    FMOV  V27.D[1], X7
    FMOV  D28, X12
    FMOV  V28.D[1], X7
    FMOV  D29, X18
    FMOV  V29.D[1], X4
    FMOV  D30, X5
    FMOV  V30.D[1], X8
    FMOV  D31, X11
    FMOV  V31.D[1], X22
    MOVZ  X23, #0xf, LSL #0
TaishanSimdAritheticP01_label_1638:
    SSRA  V21.4H, V28.4H, #5
    UQRSHRN2 V2.16B, V5.8H, #4
    SQRSHRN H26, S21, #1
    SHRN2 V28.4S, V29.2D, #25
    UQSHRN2 V25.8H, V19.4S, #11
    UQSHL H12, H11, #0xe
    SQSHRN B30, H4, #2
    SQSHRUN2 V23.8H, V29.4S, #5
    USRA  V11.16B, V2.16B, #6
    UQSHL  H2, H30, H7
    SQSHRUN V0.8B, V23.8H, #8
    MOVI  V22.4S, #0x24, LSL #16
    SSRA  V14.8H, V10.8H, #14
    SRSHR  V1.16B, V28.16B, #1
    SSHLL V6.2D, V15.2S, #0xd
    SQSHLU S1, S14, #0x1f
    UQSHRN H3, S4, #7
    SQRSHRUN H0, S9, #6
    SSRA  V28.8B, V14.8B, #8
    SRSHR D2, D4, #31
    URSHR D11, D15, #24
    SQSHRUN2 V20.8H, V4.4S, #4
    SHL  V31.4H, V3.4H, #0x5
    SSHR  V20.4H, V6.4H, #4
    ORR  V28.2S, #0x7b, LSL #8
    SQRSHRN2 V6.16B, V13.8H, #4
    SRSRA D5, D10, #38
    UQRSHRN S10, D26, #20
    SRI V1.2D, V29.2D, #7
    SQRSHRN V8.8B, V22.8H, #3
    MOVI  V31.8H, #0xee, LSL #8
    UQSHL  V28.2S, V0.2S, V3.2S
    UQRSHRN B7, H24, #8
    UQSHL  B2, B24, B14
    SQRSHRN S20, D15, #28
    SQRSHRUN S0, D20, #6
    SRSHR  V20.8B, V25.8B, #1
    SQSHLU S2, S31, #0x14
    MOVI  V28.4S, #0x27, MSL #16
    UQSHL V29.2D, V14.2D, #0xf
    UQRSHRN H9, S14, #1
    SLI D28, D31, #0x14
    SQSHRUN2 V10.4S, V3.2D, #23
    SQSHL B15, B26, #0x7
    MVNI  V25.2S, #0xfa, LSL #24
    SHL V18.2D, V23.2D, #0x3b
    ORR  V25.2S, #0xbb, LSL #8
    SQSHLU D8, D22, #0x37
    SQRSHRUN H16, S20, #10
    USHLL V12.2D, V27.2S, #0x18
    URSRA  V2.16B, V28.16B, #8
    SQRSHRN B12, H15, #2
    SQSHRUN2 V21.4S, V27.2D, #18
    SSRA V3.2D, V12.2D, #48
    URSHR V17.2D, V10.2D, #48
    SSRA  V26.4H, V8.4H, #11
    SQRSHRN S14, D31, #22
    SQSHRN B21, H6, #6
    SQRSHRUN V5.2S, V29.2D, #1
    SQSHRN H23, S30, #7
    UQSHL  S20, S15, S5
    SQRSHRN2 V1.4S, V0.2D, #2
    SQSHRUN S22, D27, #12
    UQSHL  D4, D23, D27
    UQSHRN H9, S30, #1
    USHR  V14.2S, V30.2S, #7
    SQRSHRUN H6, S18, #2
    SSRA V16.2D, V4.2D, #28
    SLI  V4.4S, V3.4S, #0x1b
    SQRSHRUN2 V0.4S, V28.2D, #24
    SLI  V2.2S, V3.2S, #0x1b
    FMOV  V31.2D, #0.75000000
    ORR  V11.4H, #0x3d
    SRI D26, D29, #23
    SHL  V7.4H, V29.4H, #0x0
    SQRSHRN B28, H28, #7
    SRI  V21.16B, V31.16B, #7
    FMOV  V3.4S, #-0.78125000
    SQSHL B29, B10, #0x6
    SHL V3.2D, V19.2D, #0xc
    URSRA D6, D23, #47
    SQSHRUN2 V18.4S, V11.2D, #5
    SRSRA V19.2D, V23.2D, #63
    SHL V1.2D, V10.2D, #0x5
    SQSHL H28, H30, #0x2
    UQRSHRN2 V1.16B, V10.8H, #6
    MOVI  V21.2D, #71777214294654975
    SQSHRUN H30, S7, #6
    SQSHLU S3, S30, #0x1e
    UQSHRN H30, S31, #7
    SQSHRUN2 V24.16B, V8.8H, #8
    UQSHL V16.2D, V10.2D, #0x31
    UQSHL  H21, H19, H26
    MOVI  V13.2D, #72057594021150975
    USHLL V26.8H, V4.8B, #0x4
    SQRSHRN V3.8B, V8.8H, #4
    SQSHL S19, S23, #0x1
    URSHR  V19.4H, V20.4H, #1
    SQSHRUN V26.2S, V2.2D, #26
    SQRSHRN V22.4H, V6.4S, #10
    UQSHRN S11, D10, #28
    UQSHL  D8, D13, D3
    SHRN2 V3.4S, V28.2D, #11
    SRSHR D22, D19, #18
    SQSHLU D5, D14, #0x30
    SQRSHRN2 V22.16B, V14.8H, #3
    SQSHL H2, H15, #0x3
    UQSHRN V8.4H, V16.4S, #12
    SHRN V6.8B, V24.8H, #5
    USHR  V30.4H, V10.4H, #7
    SRSHR D31, D21, #60
    SLI  V13.8B, V22.8B, #0x4
    UQSHRN H26, S26, #16
    USHLL2 V16.8H, V25.16B, #0x5
    SQSHL H7, H25, #0xd
    SSHLL V23.8H, V26.8B, #0x4
    MOVI  V4.2S, #0xfa, LSL #24
    SRI D2, D6, #26
    UQRSHRN2 V14.4S, V21.2D, #19
    SHRN V5.4H, V2.4S, #13
    SHL V22.2D, V28.2D, #0x3e
    SQSHL D2, D22, #0x23
    SQRSHRN2 V9.4S, V8.2D, #2
    UQRSHRN H16, S26, #4
    UQSHRN2 V23.4S, V17.2D, #23
    UQSHL  B19, B22, B26
    USHLL V16.4S, V19.4H, #0xc
    SHRN2 V1.16B, V11.8H, #7
    URSHR  V4.8B, V25.8B, #2
    SHL V21.2D, V19.2D, #0x30
    SRSRA D28, D5, #47
    MVNI  V25.2S, #0xeb
    SQSHRUN V17.4H, V7.4S, #12
    SSRA  V30.4S, V31.4S, #7
    UQSHRN V7.4H, V27.4S, #7
    SRI  V0.4S, V7.4S, #23
    UQSHRN B25, H21, #4
    SHL  V31.8B, V10.8B, #0x7
    UQSHRN2 V23.4S, V21.2D, #2
    SSRA V4.2D, V22.2D, #3
    ORR  V14.2S, #0xcc, LSL #8
    USHR  V24.8H, V22.8H, #11
    SQSHLU  V2.4H, V9.4H, #0xb
    UQRSHRN2 V3.8H, V26.4S, #1
    SHRN V2.2S, V13.2D, #17
    USHLL V2.2D, V2.2S, #0x1b
    SQRSHRUN2 V30.16B, V12.8H, #8
    SHLL  V18.8H, V10.8B, #8
    URSHR V27.2D, V4.2D, #45
    USRA D29, D10, #10
    SLI  V17.16B, V21.16B, #0x7
    MVNI  V18.2S, #0x6e, MSL #8
    SHLL2  V30.4S, V4.8H, #16
    URSHR  V16.8B, V27.8B, #3
    MVNI  V22.4S, #0xa7
    UQRSHRN V28.8B, V10.8H, #2
    SQRSHRN2 V31.4S, V2.2D, #9
    SLI D22, D20, #0x1e
    UQSHL S18, S30, #0xd
    MVNI  V0.4S, #0x18, LSL #24
    USRA V9.2D, V2.2D, #36
    SQSHLU  V9.2S, V16.2S, #0xb
    SLI  V6.16B, V7.16B, #0x6
    URSHR  V24.2S, V6.2S, #24
    URSRA V25.2D, V14.2D, #3
    ORR  V15.2S, #0x6d
    USHLL V26.8H, V25.8B, #0x1
    SHL V29.2D, V4.2D, #0x9
    SQRSHRUN V17.2S, V13.2D, #9
    MVNI  V1.2S, #0x15
    SRI  V20.4S, V6.4S, #17
    SSRA  V4.4H, V10.4H, #15
    RSHRN2 V4.16B, V18.8H, #3
    URSRA  V22.4S, V18.4S, #4
    UQRSHRN2 V1.8H, V23.4S, #2
    SQRSHRUN H25, S20, #7
    SHRN V5.8B, V29.8H, #2
    SSRA V16.2D, V10.2D, #22
    SQSHRN2 V18.8H, V14.4S, #15
    UQSHRN H0, S5, #7
    SQSHL  V17.2S, V5.2S, #0x1f
    SQRSHRN S26, D26, #5
    SSHLL2 V5.2D, V14.4S, #0x1f
    UQSHRN V22.8B, V6.8H, #8
    SLI  V0.4S, V1.4S, #0x1d
    SSHR V4.2D, V22.2D, #48
    SQRSHRN H7, S25, #7
    SSHR  V30.16B, V12.16B, #2
    UQSHL  V11.4H, V21.4H, V7.4H
    SQSHLU V20.2D, V23.2D, #0x3f
    SRI  V2.4H, V28.4H, #11
    MOVI  V24.2D, #72057594037927935
    URSHR  V10.8H, V13.8H, #12
    SSRA  V11.8B, V20.8B, #4
    UQSHL B4, B12, #0x4
    SHL V23.2D, V11.2D, #0x2c
    BIC  V10.8H, #0xb8
    SQRSHRN V26.4H, V19.4S, #4
    SRI  V4.4S, V12.4S, #15
    URSRA  V30.16B, V30.16B, #5
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdAritheticP01_label_1638
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X10, X5, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X5, X7, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X11, X24, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X28, X13, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X22, X14, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
TaishanSimdAritheticP01_label_138:
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X4, X6, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdAritheticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X27, X8, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X12, X19, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X5, X12, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdAritheticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdAritheticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X10, X17, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X27, X16, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D2
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x3c20, LSL #32
    MOVK  X28, #0x420, LSL #48
    SUB  X6, X28, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X18, #0x2000, LSL #0
    SUB  X2, X18, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D5
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D6
    MOVZ  X24, #0x3f3f, LSL #0
    MOVK  X24, #0x73f, LSL #16
    SUB  X17, X24, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X13, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdAritheticP01_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X3, D9
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8, LSL #16
    SUB  X21, X11, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdAritheticP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X2, D10
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x1, LSL #16
    MOVK  X16, #0x1, LSL #32
    SUB  X19, X16, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdAritheticP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X8, D11
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X10, X4, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X15, D13
    MOVZ  X26, #0xf, LSL #0
    MOVK  X26, #0xf00, LSL #16
    MOVK  X26, #0xf0f, LSL #32
    MOVK  X26, #0xf, LSL #48
    SUB  X20, X26, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D14
    MOVZ  X22, #0xcc00, LSL #0
    MOVK  X22, #0xcc00, LSL #32
    SUB  X18, X22, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D15
    MOVZ  X22, #0x6d, LSL #0
    MOVK  X22, #0x6d, LSL #32
    SUB  X9, X22, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D16
    MOVZ  X13, #0x100, LSL #0
    SUB  X23, X13, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdAritheticP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X9, D17
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0x7fff, LSL #16
    SUB  X7, X26, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X21, #0x1, LSL #0
    MOVK  X21, #0x1, LSL #16
    SUB  X26, X21, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdAritheticP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X27, D19
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdAritheticP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X12, D20
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X2, X17, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D22
    MOVZ  X5, #0x73f, LSL #0
    SUB  X28, X5, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdAritheticP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X28, D23
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xf000, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X15, X6, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdAritheticP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xff, LSL #48
    SUB  X8, X13, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X19, D24
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xff, LSL #48
    SUB  X8, X13, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdAritheticP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X17, D25
    MOVZ  X6, #0x7, LSL #0
    SUB  X27, X6, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdAritheticP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X25, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdAritheticP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X24, D27
    MOVZ  X22, #0xa02, LSL #0
    SUB  X6, X22, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdAritheticP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail
    FMOV  X21, D28
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdAritheticP01_TestFail

TaishanSimdAritheticP01_TestEnd:
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
TaishanSimdAritheticP01_TestFail:
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