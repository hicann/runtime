.global TSRTFloatFloatPointRoundToInteger

.text
.p2align 4

TSRTFloatFloatPointRoundToInteger:

TSRTFloatFloatPointRoundToInteger_TestBegin:
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
    MOVZ  X2, #0xf805, LSL #0
    MOVK  X2, #0x975f, LSL #16
    MOVK  X2, #0x2287, LSL #32
    MOVK  X2, #0x3253, LSL #48
    MOVZ  X3, #0x3551, LSL #0
    MOVK  X3, #0xe2f0, LSL #16
    MOVK  X3, #0xac07, LSL #32
    MOVK  X3, #0xaad6, LSL #48
    MOVZ  X4, #0x4eff, LSL #0
    MOVK  X4, #0x9b53, LSL #16
    MOVK  X4, #0xeb2b, LSL #32
    MOVK  X4, #0xe20b, LSL #48
    MOVZ  X5, #0x44c7, LSL #0
    MOVK  X5, #0x5f5c, LSL #16
    MOVK  X5, #0x3f95, LSL #32
    MOVK  X5, #0x7dab, LSL #48
    MOVZ  X6, #0x2e33, LSL #0
    MOVK  X6, #0x6418, LSL #16
    MOVK  X6, #0xef7a, LSL #32
    MOVK  X6, #0x4e91, LSL #48
    MOVZ  X7, #0xe8cb, LSL #0
    MOVK  X7, #0x5cca, LSL #16
    MOVK  X7, #0x70b2, LSL #32
    MOVK  X7, #0xd471, LSL #48
    MOVZ  X9, #0xe123, LSL #0
    MOVK  X9, #0xd099, LSL #16
    MOVK  X9, #0xe685, LSL #32
    MOVK  X9, #0xd7e7, LSL #48
    MOVZ  X10, #0x1c88, LSL #0
    MOVK  X10, #0x67a2, LSL #16
    MOVK  X10, #0x9a5b, LSL #32
    MOVK  X10, #0xc364, LSL #48
    MOVZ  X11, #0x43d3, LSL #0
    MOVK  X11, #0x3198, LSL #16
    MOVK  X11, #0x263b, LSL #32
    MOVK  X11, #0xfcb0, LSL #48
    MOVZ  X12, #0xcad8, LSL #0
    MOVK  X12, #0xca5d, LSL #16
    MOVK  X12, #0xd56e, LSL #32
    MOVK  X12, #0x4911, LSL #48
    MOVZ  X13, #0xd727, LSL #0
    MOVK  X13, #0x7338, LSL #16
    MOVK  X13, #0x320f, LSL #32
    MOVK  X13, #0xb103, LSL #48
    MOVZ  X14, #0xf2d6, LSL #0
    MOVK  X14, #0xb9a1, LSL #16
    MOVK  X14, #0xf7cd, LSL #32
    MOVK  X14, #0xd9a1, LSL #48
    MOVZ  X15, #0xfb9a, LSL #0
    MOVK  X15, #0x621d, LSL #16
    MOVK  X15, #0x2210, LSL #32
    MOVK  X15, #0xa5a, LSL #48
    MOVZ  X16, #0x8a57, LSL #0
    MOVK  X16, #0x8b89, LSL #16
    MOVK  X16, #0x52bf, LSL #32
    MOVK  X16, #0x39a7, LSL #48
    MOVZ  X17, #0x432c, LSL #0
    MOVK  X17, #0xb8cd, LSL #16
    MOVK  X17, #0x2fab, LSL #32
    MOVK  X17, #0x6b23, LSL #48
    MOVZ  X18, #0xf8ba, LSL #0
    MOVK  X18, #0x702, LSL #16
    MOVK  X18, #0x9187, LSL #32
    MOVK  X18, #0x1dc, LSL #48
    MOVZ  X19, #0xecf0, LSL #0
    MOVK  X19, #0x8f25, LSL #16
    MOVK  X19, #0x8c03, LSL #32
    MOVK  X19, #0xf3b0, LSL #48
    MOVZ  X21, #0xd160, LSL #0
    MOVK  X21, #0x1345, LSL #16
    MOVK  X21, #0xb4ee, LSL #32
    MOVK  X21, #0x5914, LSL #48
    MOVZ  X22, #0x74fb, LSL #0
    MOVK  X22, #0xa37f, LSL #16
    MOVK  X22, #0xcc72, LSL #32
    MOVK  X22, #0xeabe, LSL #48
    MOVZ  X24, #0x6729, LSL #0
    MOVK  X24, #0x3358, LSL #16
    MOVK  X24, #0x2afe, LSL #32
    MOVK  X24, #0xc56f, LSL #48
    MOVZ  X25, #0x1717, LSL #0
    MOVK  X25, #0xafc8, LSL #16
    MOVK  X25, #0x7bbe, LSL #32
    MOVK  X25, #0xd59c, LSL #48
    MOVZ  X27, #0xa0ee, LSL #0
    MOVK  X27, #0x2ff0, LSL #16
    MOVK  X27, #0xc5d1, LSL #32
    MOVK  X27, #0xd19f, LSL #48
    MOVZ  X28, #0x7e96, LSL #0
    MOVK  X28, #0x61c7, LSL #16
    MOVK  X28, #0x5017, LSL #32
    MOVK  X28, #0x3865, LSL #48
    MOVZ  X29, #0x5160, LSL #0
    MOVK  X29, #0x6a6b, LSL #16
    MOVK  X29, #0xbb50, LSL #32
    MOVK  X29, #0x3afc, LSL #48
    MOVZ  X28, #0x2386, LSL #0
    MOVK  X28, #0xb003, LSL #16
    MOVK  X28, #0x1ffe, LSL #32
    MOVK  X28, #0x9b65, LSL #48
    MSR  FPCR, X28
    MOVZ  X28, #0x6e4e, LSL #0
    MOVK  X28, #0xad09, LSL #16
    MOVK  X28, #0x24c0, LSL #32
    MOVK  X28, #0x7d1c, LSL #48
    MSR  FPSR, X28
    MRS  X21, FPSR
    MOVZ  X25, #0xff60, LSL #0
    MOVK  X25, #0x7ff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    AND  X21, X21, X25
    MOVZ  X25, #0x0, LSL #0
    ORR  X21, X21, X25
    MSR  FPSR, X21
    ISB  SY
    SUBS  W5, W22, W13, LSL #12
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x2734, LSL #0
    MOVK  X2, #0xdc50, LSL #16
    MOVK  X2, #0x6f96, LSL #32
    MOVK  X2, #0x96f7, LSL #48
    MOVZ  X3, #0x102f, LSL #0
    MOVK  X3, #0xfc76, LSL #16
    MOVK  X3, #0x156, LSL #32
    MOVK  X3, #0x5cc9, LSL #48
    MOVZ  X4, #0xd453, LSL #0
    MOVK  X4, #0x2a3e, LSL #16
    MOVK  X4, #0x4c6e, LSL #32
    MOVK  X4, #0x61b8, LSL #48
    MOVZ  X5, #0xadfc, LSL #0
    MOVK  X5, #0x75e4, LSL #16
    MOVK  X5, #0x97e4, LSL #32
    MOVK  X5, #0xb230, LSL #48
    MOVZ  X6, #0xdeb2, LSL #0
    MOVK  X6, #0xfec8, LSL #16
    MOVK  X6, #0x491b, LSL #32
    MOVK  X6, #0x3586, LSL #48
    MOVZ  X7, #0x26c8, LSL #0
    MOVK  X7, #0x154a, LSL #16
    MOVK  X7, #0x70c3, LSL #32
    MOVK  X7, #0x3ce, LSL #48
    MOVZ  X9, #0xa154, LSL #0
    MOVK  X9, #0xeb85, LSL #16
    MOVK  X9, #0xaa78, LSL #32
    MOVK  X9, #0x38d5, LSL #48
    MOVZ  X10, #0x48b7, LSL #0
    MOVK  X10, #0x6cc6, LSL #16
    MOVK  X10, #0xc434, LSL #32
    MOVK  X10, #0x51ce, LSL #48
    MOVZ  X11, #0xc07f, LSL #0
    MOVK  X11, #0x60e5, LSL #16
    MOVK  X11, #0x5e0e, LSL #32
    MOVK  X11, #0x325a, LSL #48
    MOVZ  X12, #0x9f68, LSL #0
    MOVK  X12, #0x1eca, LSL #16
    MOVK  X12, #0xb1e3, LSL #32
    MOVK  X12, #0xe8d8, LSL #48
    MOVZ  X13, #0x7813, LSL #0
    MOVK  X13, #0xbdda, LSL #16
    MOVK  X13, #0xf85f, LSL #32
    MOVK  X13, #0xf3f6, LSL #48
    MOVZ  X14, #0x1822, LSL #0
    MOVK  X14, #0x6f62, LSL #16
    MOVK  X14, #0x9034, LSL #32
    MOVK  X14, #0xee01, LSL #48
    MOVZ  X15, #0x3f39, LSL #0
    MOVK  X15, #0xec6a, LSL #16
    MOVK  X15, #0x4d39, LSL #32
    MOVK  X15, #0xa5f2, LSL #48
    MOVZ  X16, #0xad25, LSL #0
    MOVK  X16, #0x8de5, LSL #16
    MOVK  X16, #0xadcd, LSL #32
    MOVK  X16, #0xff82, LSL #48
    MOVZ  X17, #0x4792, LSL #0
    MOVK  X17, #0xf177, LSL #16
    MOVK  X17, #0xc7a, LSL #32
    MOVK  X17, #0x4a76, LSL #48
    MOVZ  X18, #0x23a4, LSL #0
    MOVK  X18, #0xa753, LSL #16
    MOVK  X18, #0xe108, LSL #32
    MOVK  X18, #0x4b25, LSL #48
    MOVZ  X19, #0x249c, LSL #0
    MOVK  X19, #0xc6ba, LSL #16
    MOVK  X19, #0x85d9, LSL #32
    MOVK  X19, #0xb9e1, LSL #48
    MOVZ  X21, #0x3576, LSL #0
    MOVK  X21, #0xb7e0, LSL #16
    MOVK  X21, #0xa56e, LSL #32
    MOVK  X21, #0x3068, LSL #48
    MOVZ  X22, #0x3f11, LSL #0
    MOVK  X22, #0x65a, LSL #16
    MOVK  X22, #0x8e10, LSL #32
    MOVK  X22, #0x27ae, LSL #48
    MOVZ  X24, #0xc408, LSL #0
    MOVK  X24, #0xf4e5, LSL #16
    MOVK  X24, #0x4f8a, LSL #32
    MOVK  X24, #0xdf11, LSL #48
    MOVZ  X25, #0xfdb2, LSL #0
    MOVK  X25, #0x2669, LSL #16
    MOVK  X25, #0x65c0, LSL #32
    MOVK  X25, #0x5917, LSL #48
    MOVZ  X27, #0xb776, LSL #0
    MOVK  X27, #0x3127, LSL #16
    MOVK  X27, #0xee95, LSL #32
    MOVK  X27, #0x1f15, LSL #48
    MOVZ  X28, #0xdb05, LSL #0
    MOVK  X28, #0x64aa, LSL #16
    MOVK  X28, #0xd10e, LSL #32
    MOVK  X28, #0x4fe2, LSL #48
    MOVZ  X29, #0xdf77, LSL #0
    MOVK  X29, #0xd26d, LSL #16
    MOVK  X29, #0x7a73, LSL #32
    MOVK  X29, #0x6ae8, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X21
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X25
    FMOV  D3, X22
    FMOV  V3.D[1], X11
    FMOV  D4, X22
    FMOV  V4.D[1], X22
    FMOV  D5, X24
    FMOV  V5.D[1], X3
    FMOV  D6, X17
    FMOV  V6.D[1], X12
    FMOV  D7, X24
    FMOV  V7.D[1], X17
    FMOV  D8, X12
    FMOV  V8.D[1], X29
    FMOV  D9, X15
    FMOV  V9.D[1], X17
    FMOV  D10, X15
    FMOV  V10.D[1], X27
    FMOV  D11, X18
    FMOV  V11.D[1], X11
    FMOV  D12, X17
    FMOV  V12.D[1], X16
    FMOV  D13, X19
    FMOV  V13.D[1], X17
    FMOV  D14, X24
    FMOV  V14.D[1], X2
    FMOV  D15, X24
    FMOV  V15.D[1], X13
    FMOV  D16, X4
    FMOV  V16.D[1], X15
    FMOV  D17, X6
    FMOV  V17.D[1], X19
    FMOV  D18, X16
    FMOV  V18.D[1], X13
    FMOV  D19, X7
    FMOV  V19.D[1], X4
    FMOV  D20, X10
    FMOV  V20.D[1], X22
    FMOV  D21, X29
    FMOV  V21.D[1], X11
    FMOV  D22, X6
    FMOV  V22.D[1], X9
    FMOV  D23, X7
    FMOV  V23.D[1], X7
    FMOV  D24, X13
    FMOV  V24.D[1], X18
    FMOV  D25, X29
    FMOV  V25.D[1], X4
    FMOV  D26, X14
    FMOV  V26.D[1], X2
    FMOV  D27, X19
    FMOV  V27.D[1], X16
    FMOV  D28, X25
    FMOV  V28.D[1], X14
    FMOV  D29, X5
    FMOV  V29.D[1], X27
    FMOV  D30, X22
    FMOV  V30.D[1], X17
    FMOV  D31, X5
    FMOV  V31.D[1], X24
    MOVZ  X19, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_0:
    FRINTX  D24, D25
    FRINTM  H26, H26
    FRINTI  H7, H23
    FRINTN  H5, H21
    FRINTX  S14, S7
    FRINTZ  D9, D26
    FRINTX  D4, D30
    FRINTN  S9, S28
    FRINTA  H31, H24
    FRINTX  S3, S22
    FRINTP  S29, S4
    FRINTP  S0, S5
    FRINTN  D29, D14
    FRINTI  S16, S0
    FRINTM  S20, S16
    FRINTZ  S23, S20
    FRINTI  S10, S31
    FRINTA  D30, D3
    FRINTM  H21, H29
    FRINTN  D14, D23
    FRINTM  H11, H14
    FRINTA  H4, H30
    FRINTX  S23, S10
    FRINTN  D24, D9
    FRINTI  S29, S11
    FRINTM  S20, S24
    FRINTM  D5, D20
    FRINTA  H11, H29
    FRINTX  D31, D21
    FRINTN  H20, H31
    FRINTI  D3, D5
    FRINTM  S29, S4
    FRINTM  S28, S29
    FRINTN  D0, D20
    FRINTX  S16, S8
    FRINTP  H14, H3
    FRINTN  S3, S11
    FRINTN  H5, H28
    FRINTZ  S8, S16
    FRINTZ  H22, H8
    FRINTP  D20, D9
    FRINTZ  S16, S14
    FRINTA  D10, D10
    FRINTM  H11, H3
    FRINTZ  S14, S22
    FRINTX  S3, S0
    FRINTI  H22, H5
    FRINTX  D5, D22
    FRINTP  D0, D10
    FRINTP  D29, D11
    FRINTP  S11, S0
    FRINTN  H28, H16
    FRINTP  S31, S29
    FRINTI  D22, D28
    FRINTN  S10, S20
    FRINTP  H0, H22
    FRINTP  S16, S3
    FRINTA  H29, H14
    FRINTI  H4, H10
    FRINTP  D20, D0
    FRINTI  S9, S30
    FRINTN  S22, S9
    FRINTP  S9, S5
    FRINTN  H14, H22
    FRINTM  S5, S14
    FRINTZ  S8, S9
    FRINTM  D14, D5
    FRINTP  D30, D8
    FRINTI  S3, S31
    FRINTX  D10, D14
    FRINTN  S0, S29
    FRINTA  H14, H20
    FRINTA  H28, H30
    FRINTA  D31, D28
    FRINTI  S27, S4
    FRINTI  S22, S27
    FRINTX  S8, S31
    FRINTI  D31, D3
    FRINTI  H3, H31
    FRINTA  H28, H3
    FRINTN  S5, S8
    FRINTX  H20, H16
    FRINTZ  H8, H14
    FRINTN  H16, H13
    FRINTI  D31, D13
    FRINTM  D27, D28
    FRINTX  H4, H0
    FRINTM  H30, H13
    FRINTI  D29, D9
    FRINTI  S3, S5
    FRINTX  D14, D29
    FRINTA  H29, H31
    FRINTP  H5, H10
    FRINTX  H28, H15
    FRINTI  H31, H4
    FRINTX  H4, H3
    FRINTP  H15, H27
    FRINTP  S0, S4
    FRINTA  S8, S8
    FRINTP  H9, H16
    FRINTA  H13, H15
    FRINTX  D27, D22
    FRINTI  D20, D30
    FRINTI  H22, H14
    FRINTZ  D10, D29
    FRINTN  D14, D9
    FRINTI  H29, H20
    FRINTP  D4, D29
    FRINTP  S30, S27
    FRINTN  D1, D31
    FRINTX  D9, D28
    FRINTP  H28, H30
    FRINTA  H31, H5
    FRINTN  S30, S1
    FRINTM  S29, S14
    FRINTI  H27, H9
    FRINTZ  H3, H4
    FRINTP  S9, S28
    FRINTP  H15, H29
    FRINTN  D14, D9
    FRINTP  D28, D3
    FRINTM  D29, D31
    FRINTA  D3, D28
    FRINTZ  D28, D10
    FRINTP  D5, D14
    FRINTP  D20, D30
    FRINTA  D30, D20
    FRINTX  H14, H27
    FRINTM  D9, D30
    FRINTX  H10, H29
    FRINTZ  D31, D9
    FRINTZ  H20, H15
    FRINTN  H30, H20
    FRINTP  D20, D3
    FRINTN  D29, D31
    FRINTP  D27, D30
    FRINTN  H30, H27
    FRINTI  D3, D30
    FRINTZ  S30, S3
    FRINTP  H27, H14
    FRINTP  D14, D10
    FRINTP  H10, H5
    FRINTZ  H5, H30
    FRINTI  S31, S27
    FRINTZ  H15, H14
    FRINTA  D3, D31
    FRINTX  S30, S10
    FRINTM  S14, S28
    FRINTX  D27, D30
    FRINTI  D28, D29
    FRINTN  D9, D15
    FRINTX  S15, S20
    FRINTI  S20, S28
    FRINTN  D10, D9
    FRINTA  D8, D3
    FRINTX  S28, S7
    FRINTI  H31, H28
    FRINTP  H11, H5
    FRINTX  D3, D15
    FRINTM  D30, D31
    FRINTM  S28, S20
    FRINTI  S29, S27
    FRINTA  H27, H14
    FRINTM  H15, H30
    FRINTI  S30, S9
    FRINTM  D31, D30
    FRINTA  D9, D31
    FRINTX  D7, D10
    FRINTP  H14, H29
    FRINTP  S29, S9
    FRINTZ  S15, S15
    FRINTI  H9, H14
    FRINTX  H31, H28
    FRINTN  S14, S9
    FRINTP  D20, D29
    FRINTN  S28, S7
    FRINTP  H5, H28
    FRINTZ  D28, D20
    FRINTA  H20, H27
    FRINTN  S9, S20
    FRINTM  H7, H9
    FRINTZ  H10, H15
    FRINTI  S31, S3
    FRINTZ  H27, H31
    FRINTN  S9, S10
    FRINTI  S10, S9
    FRINTP  H29, H27
    FRINTI  D30, D29
    FRINTI  S29, S7
    FRINTI  S24, S30
    FRINTM  D31, D29
    FRINTN  S3, S14
    FRINTZ  D7, D5
    FRINTX  D29, D7
    FRINTN  D20, D31
    FRINTZ  H30, H28
    FRINTA  H31, H30
    FRINTI  S7, S3
    FRINTN  H14, H7
    FRINTZ  D15, D24
    SUBS  X19, X19, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_0
    MOVZ  X10, #0x2734, LSL #0
    MOVK  X10, #0xdc50, LSL #16
    MOVK  X10, #0x6f96, LSL #32
    MOVK  X10, #0x96f7, LSL #48
    SUB  X24, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x102f, LSL #0
    MOVK  X10, #0xfc76, LSL #16
    MOVK  X10, #0x156, LSL #32
    MOVK  X10, #0x5cc9, LSL #48
    SUB  X24, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xd453, LSL #0
    MOVK  X10, #0x2a3e, LSL #16
    MOVK  X10, #0x4c6e, LSL #32
    MOVK  X10, #0x61b8, LSL #48
    SUB  X24, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xadfc, LSL #0
    MOVK  X10, #0x75e4, LSL #16
    MOVK  X10, #0x97e4, LSL #32
    MOVK  X10, #0xb230, LSL #48
    SUB  X24, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xdeb2, LSL #0
    MOVK  X10, #0xfec8, LSL #16
    MOVK  X10, #0x491b, LSL #32
    MOVK  X10, #0x3586, LSL #48
    SUB  X24, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x26c8, LSL #0
    MOVK  X10, #0x154a, LSL #16
    MOVK  X10, #0x70c3, LSL #32
    MOVK  X10, #0x3ce, LSL #48
    SUB  X24, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xa154, LSL #0
    MOVK  X10, #0xeb85, LSL #16
    MOVK  X10, #0xaa78, LSL #32
    MOVK  X10, #0x38d5, LSL #48
    SUB  X24, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xc07f, LSL #0
    MOVK  X10, #0x60e5, LSL #16
    MOVK  X10, #0x5e0e, LSL #32
    MOVK  X10, #0x325a, LSL #48
    SUB  X24, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x9f68, LSL #0
    MOVK  X10, #0x1eca, LSL #16
    MOVK  X10, #0xb1e3, LSL #32
    MOVK  X10, #0xe8d8, LSL #48
    SUB  X24, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x7813, LSL #0
    MOVK  X10, #0xbdda, LSL #16
    MOVK  X10, #0xf85f, LSL #32
    MOVK  X10, #0xf3f6, LSL #48
    SUB  X24, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x1822, LSL #0
    MOVK  X10, #0x6f62, LSL #16
    MOVK  X10, #0x9034, LSL #32
    MOVK  X10, #0xee01, LSL #48
    SUB  X24, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x3f39, LSL #0
    MOVK  X10, #0xec6a, LSL #16
    MOVK  X10, #0x4d39, LSL #32
    MOVK  X10, #0xa5f2, LSL #48
    SUB  X24, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xad25, LSL #0
    MOVK  X10, #0x8de5, LSL #16
    MOVK  X10, #0xadcd, LSL #32
    MOVK  X10, #0xff82, LSL #48
    SUB  X24, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x4792, LSL #0
    MOVK  X10, #0xf177, LSL #16
    MOVK  X10, #0xc7a, LSL #32
    MOVK  X10, #0x4a76, LSL #48
    SUB  X24, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x23a4, LSL #0
    MOVK  X10, #0xa753, LSL #16
    MOVK  X10, #0xe108, LSL #32
    MOVK  X10, #0x4b25, LSL #48
    SUB  X24, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x3f11, LSL #0
    MOVK  X10, #0x65a, LSL #16
    MOVK  X10, #0x8e10, LSL #32
    MOVK  X10, #0x27ae, LSL #48
    SUB  X24, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xfdb2, LSL #0
    MOVK  X10, #0x2669, LSL #16
    MOVK  X10, #0x65c0, LSL #32
    MOVK  X10, #0x5917, LSL #48
    SUB  X24, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xb776, LSL #0
    MOVK  X10, #0x3127, LSL #16
    MOVK  X10, #0xee95, LSL #32
    MOVK  X10, #0x1f15, LSL #48
    SUB  X24, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xdb05, LSL #0
    MOVK  X10, #0x64aa, LSL #16
    MOVK  X10, #0xd10e, LSL #32
    MOVK  X10, #0x4fe2, LSL #48
    SUB  X24, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xdf77, LSL #0
    MOVK  X10, #0xd26d, LSL #16
    MOVK  X10, #0x7a73, LSL #32
    MOVK  X10, #0x6ae8, LSL #48
    SUB  X24, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x10, LSL #0
    MRS  X24, FPSR
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D0
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D1
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xfdb2, LSL #0
    MOVK  X10, #0x2669, LSL #16
    MOVK  X10, #0x65c0, LSL #32
    MOVK  X10, #0x5917, LSL #48
    FMOV  X24, V2.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xb776, LSL #0
    MOVK  X10, #0x3127, LSL #16
    MOVK  X10, #0xee95, LSL #32
    MOVK  X10, #0x1f15, LSL #48
    FMOV  X24, D2
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D3
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D4
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D5
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x9f68, LSL #0
    MOVK  X10, #0x1eca, LSL #16
    MOVK  X10, #0xb1e3, LSL #32
    MOVK  X10, #0xe8d8, LSL #48
    FMOV  X24, V6.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x4792, LSL #0
    MOVK  X10, #0xf177, LSL #16
    MOVK  X10, #0xc7a, LSL #32
    MOVK  X10, #0x4a76, LSL #48
    FMOV  X24, D6
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D7
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D8
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D9
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D10
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D11
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xad25, LSL #0
    MOVK  X10, #0x8de5, LSL #16
    MOVK  X10, #0xadcd, LSL #32
    MOVK  X10, #0xff82, LSL #48
    FMOV  X24, V12.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x4792, LSL #0
    MOVK  X10, #0xf177, LSL #16
    MOVK  X10, #0xc7a, LSL #32
    MOVK  X10, #0x4a76, LSL #48
    FMOV  X24, D12
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D13
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D14
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D15
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D16
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x249c, LSL #0
    MOVK  X10, #0xc6ba, LSL #16
    MOVK  X10, #0x85d9, LSL #32
    MOVK  X10, #0xb9e1, LSL #48
    FMOV  X24, V17.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xdeb2, LSL #0
    MOVK  X10, #0xfec8, LSL #16
    MOVK  X10, #0x491b, LSL #32
    MOVK  X10, #0x3586, LSL #48
    FMOV  X24, D17
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x7813, LSL #0
    MOVK  X10, #0xbdda, LSL #16
    MOVK  X10, #0xf85f, LSL #32
    MOVK  X10, #0xf3f6, LSL #48
    FMOV  X24, V18.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xad25, LSL #0
    MOVK  X10, #0x8de5, LSL #16
    MOVK  X10, #0xadcd, LSL #32
    MOVK  X10, #0xff82, LSL #48
    FMOV  X24, D18
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xd453, LSL #0
    MOVK  X10, #0x2a3e, LSL #16
    MOVK  X10, #0x4c6e, LSL #32
    MOVK  X10, #0x61b8, LSL #48
    FMOV  X24, V19.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x26c8, LSL #0
    MOVK  X10, #0x154a, LSL #16
    MOVK  X10, #0x70c3, LSL #32
    MOVK  X10, #0x3ce, LSL #48
    FMOV  X24, D19
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D20
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D22
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D23
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D24
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xd453, LSL #0
    MOVK  X10, #0x2a3e, LSL #16
    MOVK  X10, #0x4c6e, LSL #32
    MOVK  X10, #0x61b8, LSL #48
    FMOV  X24, V25.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0xdf77, LSL #0
    MOVK  X10, #0xd26d, LSL #16
    MOVK  X10, #0x7a73, LSL #32
    MOVK  X10, #0x6ae8, LSL #48
    FMOV  X24, D25
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D26
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D27
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D28
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D29
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D30
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X11
    FMOV  V0.D[1], X7
    FMOV  D1, X10
    FMOV  V1.D[1], X19
    FMOV  D2, X21
    FMOV  V2.D[1], X12
    FMOV  D3, X22
    FMOV  V3.D[1], X5
    FMOV  D4, X14
    FMOV  V4.D[1], X27
    FMOV  D5, X29
    FMOV  V5.D[1], X18
    FMOV  D6, X24
    FMOV  V6.D[1], X28
    FMOV  D7, X25
    FMOV  V7.D[1], X24
    FMOV  D8, X17
    FMOV  V8.D[1], X13
    FMOV  D9, X13
    FMOV  V9.D[1], X21
    FMOV  D10, X5
    FMOV  V10.D[1], X7
    FMOV  D11, X19
    FMOV  V11.D[1], X16
    FMOV  D12, X24
    FMOV  V12.D[1], X10
    FMOV  D13, X10
    FMOV  V13.D[1], X2
    FMOV  D14, X21
    FMOV  V14.D[1], X2
    FMOV  D15, X3
    FMOV  V15.D[1], X22
    FMOV  D16, X22
    FMOV  V16.D[1], X24
    FMOV  D17, X27
    FMOV  V17.D[1], X3
    FMOV  D18, X16
    FMOV  V18.D[1], X2
    FMOV  D19, X17
    FMOV  V19.D[1], X29
    FMOV  D20, X27
    FMOV  V20.D[1], X13
    FMOV  D21, X28
    FMOV  V21.D[1], X19
    FMOV  D22, X16
    FMOV  V22.D[1], X15
    FMOV  D23, X5
    FMOV  V23.D[1], X21
    FMOV  D24, X16
    FMOV  V24.D[1], X2
    FMOV  D25, X28
    FMOV  V25.D[1], X4
    FMOV  D26, X3
    FMOV  V26.D[1], X13
    FMOV  D27, X13
    FMOV  V27.D[1], X17
    FMOV  D28, X28
    FMOV  V28.D[1], X25
    FMOV  D29, X6
    FMOV  V29.D[1], X7
    FMOV  D30, X5
    FMOV  V30.D[1], X15
    FMOV  D31, X28
    FMOV  V31.D[1], X11
    MOVZ  X28, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_1:
    FRINTX  S30, S27
    FRINTZ  H11, H22
    FRINTZ  D27, D31
    FRINTP  H10, H25
    FRINTA  S6, S30
    FRINTZ  D10, D27
    FRINTP  D11, D26
    FRINTA  H6, H11
    FRINTP  D3, D29
    FRINTX  H2, H28
    FRINTI  S26, S6
    FRINTN  D14, D26
    FRINTP  S1, S3
    FRINTN  D30, D2
    FRINTP  H13, H10
    FRINTN  H22, H14
    FRINTM  S7, S16
    FRINTA  H26, H1
    FRINTP  D28, D30
    FRINTA  S22, S13
    FRINTM  S8, S26
    FRINTX  S27, S8
    FRINTA  S25, S7
    FRINTI  D26, D22
    FRINTI  H31, H28
    FRINTZ  D3, D26
    FRINTI  H6, H0
    FRINTI  H1, H6
    FRINTP  H2, H27
    FRINTP  S16, S25
    FRINTI  S11, S19
    FRINTP  H10, H31
    FRINTZ  H14, H10
    FRINTP  S6, S1
    FRINTN  D13, D6
    FRINTZ  S28, S3
    FRINTX  S30, S28
    FRINTP  D1, D13
    FRINTI  S31, S1
    FRINTI  H0, H30
    FRINTZ  H30, H14
    FRINTX  D25, D16
    FRINTA  D8, D11
    FRINTZ  H26, H8
    FRINTZ  D1, D25
    FRINTN  D27, D0
    FRINTI  H14, H1
    FRINTN  S13, S31
    FRINTI  D8, D30
    FRINTX  S22, S13
    FRINTX  H7, H2
    FRINTN  S6, S27
    FRINTX  S19, S17
    FRINTZ  H16, H8
    FRINTP  D27, D26
    FRINTZ  S0, S19
    FRINTP  S2, S14
    FRINTM  S13, S2
    FRINTI  H11, H0
    FRINTX  D30, D16
    FRINTP  D26, D13
    FRINTP  S16, S7
    FRINTP  S14, S30
    FRINTA  S13, S27
    FRINTZ  S2, S13
    FRINTI  D31, D6
    FRINTM  D1, D14
    FRINTX  H13, H2
    FRINTX  H0, H11
    FRINTZ  H11, H13
    FRINTI  H8, H26
    FRINTX  S6, S8
    FRINTP  D25, D16
    FRINTM  S19, S22
    FRINTA  S7, S11
    FRINTI  D11, D1
    FRINTX  D17, D11
    FRINTM  D2, D19
    FRINTZ  D22, D0
    FRINTZ  S13, S22
    FRINTM  D27, D6
    FRINTM  D6, D27
    FRINTM  S14, S8
    FRINTI  S1, S17
    FRINTI  D0, D31
    FRINTM  S31, S13
    FRINTP  D27, D2
    FRINTZ  H26, H1
    FRINTI  H17, H12
    FRINTA  S19, S31
    FRINTN  H31, H6
    FRINTN  D8, D31
    FRINTZ  H22, H25
    FRINTM  H12, H25
    FRINTA  H11, H7
    FRINTM  S7, S11
    FRINTM  S16, S8
    FRINTZ  S8, S27
    FRINTZ  S13, S7
    FRINTI  S31, S11
    FRINTI  H2, H17
    FRINTP  H1, H13
    FRINTP  S6, S22
    FRINTN  S22, S26
    FRINTZ  H26, H0
    FRINTX  S25, S31
    FRINTX  D27, D14
    FRINTP  H11, H27
    FRINTM  D27, D11
    FRINTA  H7, H25
    FRINTA  H13, H26
    FRINTM  S25, S27
    FRINTN  S12, S1
    FRINTM  H31, H16
    FRINTZ  S29, S2
    FRINTM  S2, S22
    FRINTA  S22, S25
    FRINTI  H27, H19
    FRINTA  H19, H13
    FRINTI  H0, H31
    FRINTN  H16, H2
    FRINTA  D2, D16
    FRINTZ  H14, H6
    FRINTP  D1, D12
    FRINTP  H17, H29
    FRINTI  S25, S8
    FRINTN  H11, H7
    FRINTZ  D7, D25
    FRINTP  S13, S14
    FRINTM  D31, D7
    FRINTN  D26, D31
    FRINTP  S25, S9
    FRINTZ  H8, H14
    FRINTX  D9, D12
    FRINTA  D14, D2
    FRINTN  H7, H19
    FRINTA  H29, H17
    FRINTI  S31, S0
    FRINTX  H0, H1
    FRINTM  S6, S26
    FRINTX  D12, D0
    FRINTA  H16, H11
    FRINTP  S17, S22
    FRINTM  S19, S6
    FRINTN  D18, D12
    FRINTI  H1, H25
    FRINTX  S26, S18
    FRINTP  S22, S1
    FRINTX  S2, S22
    FRINTN  H0, H19
    FRINTI  H22, H16
    FRINTA  D12, D8
    FRINTI  S16, S7
    FRINTA  D7, D2
    FRINTI  H18, H14
    FRINTX  D8, D22
    FRINTZ  H1, H7
    FRINTN  S2, S26
    FRINTZ  D6, D17
    FRINTP  S5, S9
    FRINTN  S26, S6
    FRINTA  H22, H26
    FRINTM  D9, D1
    FRINTP  S19, S18
    FRINTX  D25, D22
    FRINTP  D17, D8
    FRINTN  D8, D5
    FRINTN  H7, H0
    FRINTI  H14, H17
    FRINTZ  S6, S8
    FRINTM  H26, H6
    FRINTI  S6, S9
    FRINTA  H22, H26
    FRINTP  D18, D6
    FRINTZ  H9, H2
    FRINTI  D21, D18
    FRINTP  S0, S7
    FRINTI  D9, D14
    FRINTP  D31, D9
    FRINTX  D5, D0
    FRINTN  S2, S22
    FRINTA  H17, H21
    FRINTZ  D8, D25
    FRINTA  D0, D19
    FRINTA  D7, D0
    FRINTZ  H26, H2
    FRINTN  D9, D7
    FRINTM  S19, S11
    FRINTZ  D1, D19
    FRINTA  S21, S9
    FRINTP  D2, D6
    FRINTP  H25, H21
    FRINTI  H21, H25
    FRINTZ  S14, S2
    FRINTN  S6, S26
    FRINTP  D22, D1
    FRINTN  D1, D17
    FRINTI  S2, S21
    FRINTN  D26, D8
    FRINTP  S0, S5
    SUBS  X28, X28, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_1
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x10, LSL #0
    MRS  X24, FPSR
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D0
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D1
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D2
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D3
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D4
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D5
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D6
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D7
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D8
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D9
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D10
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D11
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D12
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D13
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D14
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D15
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D16
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D17
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D18
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D19
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D20
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D22
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D23
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D24
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D25
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D26
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D27
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D28
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D29
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D30
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X5, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatFloatPointRoundToInteger_TestFail
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
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X7
    FMOV  V2.D[1], X10
    FMOV  D3, X15
    FMOV  V3.D[1], X6
    FMOV  D4, X6
    FMOV  V4.D[1], X16
    FMOV  D5, X12
    FMOV  V5.D[1], X9
    FMOV  D6, X6
    FMOV  V6.D[1], X28
    FMOV  D7, X13
    FMOV  V7.D[1], X14
    FMOV  D8, X11
    FMOV  V8.D[1], X9
    FMOV  D9, X25
    FMOV  V9.D[1], X7
    FMOV  D10, X21
    FMOV  V10.D[1], X13
    FMOV  D11, X5
    FMOV  V11.D[1], X18
    FMOV  D12, X19
    FMOV  V12.D[1], X3
    FMOV  D13, X17
    FMOV  V13.D[1], X24
    FMOV  D14, X10
    FMOV  V14.D[1], X5
    FMOV  D15, X7
    FMOV  V15.D[1], X7
    FMOV  D16, X13
    FMOV  V16.D[1], X13
    FMOV  D17, X19
    FMOV  V17.D[1], X3
    FMOV  D18, X15
    FMOV  V18.D[1], X7
    FMOV  D19, X9
    FMOV  V19.D[1], X18
    FMOV  D20, X9
    FMOV  V20.D[1], X4
    FMOV  D21, X9
    FMOV  V21.D[1], X16
    FMOV  D22, X4
    FMOV  V22.D[1], X12
    FMOV  D23, X4
    FMOV  V23.D[1], X16
    FMOV  D24, X17
    FMOV  V24.D[1], X6
    FMOV  D25, X17
    FMOV  V25.D[1], X3
    FMOV  D26, X14
    FMOV  V26.D[1], X7
    FMOV  D27, X7
    FMOV  V27.D[1], X6
    FMOV  D28, X27
    FMOV  V28.D[1], X18
    FMOV  D29, X11
    FMOV  V29.D[1], X2
    FMOV  D30, X16
    FMOV  V30.D[1], X16
    FMOV  D31, X24
    FMOV  V31.D[1], X25
    MOVZ  X3, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_2:
    FRINTN  H2, H24
    FRINTN  D3, D20
    FRINTN  D14, D18
    FRINTA  D24, D29
    FRINTX  H8, H31
    FRINTX  H3, H25
    FRINTA  D12, D27
    FRINTX  S25, S26
    FRINTX  S0, S28
    FRINTP  S30, S14
    FRINTP  D20, D2
    FRINTN  S10, S12
    FRINTP  S29, S10
    FRINTZ  D27, D25
    FRINTI  S3, S0
    FRINTZ  S22, S30
    FRINTP  H20, H3
    FRINTP  S15, S20
    FRINTA  D0, D15
    FRINTN  D8, D29
    FRINTI  S17, S24
    FRINTP  H15, H27
    FRINTA  D15, D22
    FRINTA  H18, H15
    FRINTZ  D25, D0
    FRINTM  H10, H25
    FRINTI  H30, H18
    FRINTX  D12, D8
    FRINTZ  D8, D30
    FRINTA  S18, S8
    FRINTN  H27, H12
    FRINTN  D20, D21
    FRINTZ  H29, H17
    FRINTM  S8, S10
    FRINTX  S10, S18
    FRINTZ  H17, H10
    FRINTA  D12, D17
    FRINTI  D17, D8
    FRINTI  S25, S1
    FRINTZ  D2, D12
    FRINTM  D18, D17
    FRINTM  S12, S20
    FRINTA  H20, H25
    FRINTI  S15, S20
    FRINTP  D20, D18
    FRINTI  H10, H29
    FRINTZ  H18, H12
    FRINTI  S25, S2
    FRINTP  H21, H15
    FRINTI  S2, S20
    FRINTA  H1, H27
    FRINTI  D12, D25
    FRINTZ  D29, D15
    FRINTX  S20, S10
    FRINTX  D10, D1
    FRINTN  S15, S23
    FRINTN  H17, H18
    FRINTN  H30, H17
    FRINTI  H27, H12
    FRINTZ  H8, H29
    FRINTA  H29, H21
    FRINTN  S12, S27
    FRINTP  H31, H15
    FRINTZ  H24, H10
    FRINTM  H18, H2
    FRINTI  S1, S8
    FRINTX  D8, D23
    FRINTX  H25, H20
    FRINTM  D20, D29
    FRINTZ  H29, H30
    FRINTA  H10, H18
    FRINTI  H30, H10
    FRINTX  D17, D20
    FRINTP  D20, D12
    FRINTN  H2, H17
    FRINTN  H27, H31
    FRINTX  S21, S20
    FRINTI  D17, D30
    FRINTZ  D31, D21
    FRINTI  S15, S25
    FRINTA  D25, D8
    FRINTA  S21, S2
    FRINTM  D23, D1
    FRINTP  S18, S15
    FRINTZ  H15, H29
    FRINTN  D10, D15
    FRINTP  H15, H27
    FRINTX  S27, S23
    FRINTA  H23, H31
    FRINTP  H17, H23
    FRINTN  H8, H15
    FRINTM  S29, S24
    FRINTA  H2, H25
    FRINTM  D30, D18
    FRINTZ  S1, S10
    FRINTI  H31, H1
    FRINTM  H15, H8
    FRINTZ  D23, D27
    FRINTX  D1, D17
    FRINTZ  H17, H29
    FRINTZ  H18, H23
    FRINTI  D12, D30
    FRINTN  H24, H31
    FRINTA  S23, S1
    FRINTN  S1, S17
    FRINTN  H17, H15
    FRINTN  H15, H18
    FRINTP  S31, S21
    FRINTM  D8, D17
    FRINTN  H30, H0
    FRINTM  H17, H12
    FRINTM  S18, S30
    FRINTA  H21, H2
    FRINTN  S2, S18
    FRINTZ  S30, S24
    FRINTP  S12, S21
    FRINTA  S21, S8
    FRINTP  D27, D30
    FRINTN  D24, D12
    FRINTX  S29, S17
    FRINTI  D30, D29
    FRINTN  D0, D31
    FRINTA  H31, H0
    FRINTI  D17, D21
    FRINTP  S18, S17
    FRINTI  D17, D2
    FRINTP  H21, H27
    FRINTM  D27, D24
    FRINTX  H0, H21
    FRINTA  H24, H17
    FRINTM  S26, S30
    FRINTA  H21, H27
    FRINTN  S27, S31
    FRINTI  S17, S27
    FRINTZ  D2, D26
    FRINTI  H30, H2
    FRINTM  D12, D30
    FRINTZ  S26, S24
    FRINTN  S27, S17
    FRINTN  H2, H27
    FRINTI  S31, S26
    FRINTA  S17, S31
    FRINTM  S29, S17
    FRINTM  H17, H18
    FRINTM  H18, H17
    FRINTZ  S24, S2
    FRINTP  D27, D21
    FRINTI  H30, H12
    FRINTX  S26, S18
    FRINTA  H18, H26
    FRINTI  H31, H24
    FRINTI  H12, H27
    FRINTN  S26, S29
    FRINTP  S29, S30
    FRINTX  H9, H29
    FRINTZ  S7, S9
    FRINTM  H17, H12
    FRINTP  D2, D18
    FRINTN  S21, S26
    FRINTA  H18, H26
    FRINTM  D27, D18
    FRINTM  S24, S7
    FRINTN  D26, D31
    FRINTM  S12, S21
    FRINTI  S21, S24
    FRINTA  H18, H2
    FRINTI  H17, H16
    FRINTA  H24, H27
    FRINTX  H2, H12
    FRINTA  S7, S17
    FRINTM  S29, S21
    FRINTI  D9, D2
    FRINTZ  D16, D19
    FRINTM  S31, S9
    FRINTM  H2, H18
    FRINTA  D9, D31
    FRINTN  S18, S26
    FRINTX  D31, D18
    FRINTM  S30, S9
    FRINTA  H18, H31
    FRINTX  S19, S24
    FRINTN  S24, S31
    FRINTN  H21, H30
    FRINTX  D30, D7
    FRINTM  S27, S31
    FRINTN  S17, S19
    FRINTA  D12, D29
    FRINTI  H26, H2
    FRINTP  S2, S17
    FRINTN  S24, S18
    FRINTX  S7, S12
    FRINTZ  D17, D31
    FRINTI  D31, D30
    FRINTN  H8, H16
    FRINTI  D30, D27
    FRINTX  S9, S17
    FRINTX  D16, D31
    FRINTP  S31, S24
    FRINTN  D24, D31
    FRINTM  H31, H24
    SUBS  X3, X3, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_2
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x10, LSL #0
    MRS  X12, FPSR
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D0
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D1
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D2
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    FMOV  X12, D3
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, V4.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, D4
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, D5
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, V6.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, D6
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D7
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D8
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D9
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D10
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, V11.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, D11
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D12
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, D13
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D14
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D15
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D16
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D17
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D18
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D19
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D20
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D21
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D22
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D23
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D24
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D25
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D26
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D27
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, V28.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X12, D28
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D29
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D30
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X12, D31
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x8bc8, LSL #0
    MOVK  X2, #0x2696, LSL #16
    MOVK  X2, #0x667c, LSL #32
    MOVK  X2, #0x7a8c, LSL #48
    MOVZ  X3, #0xa9ae, LSL #0
    MOVK  X3, #0xaf5c, LSL #16
    MOVK  X3, #0x3d8a, LSL #32
    MOVK  X3, #0x7ee4, LSL #48
    MOVZ  X4, #0xd9b9, LSL #0
    MOVK  X4, #0x1555, LSL #16
    MOVK  X4, #0x9f09, LSL #32
    MOVK  X4, #0x402e, LSL #48
    MOVZ  X5, #0x9e91, LSL #0
    MOVK  X5, #0x9c03, LSL #16
    MOVK  X5, #0x5709, LSL #32
    MOVK  X5, #0x8d29, LSL #48
    MOVZ  X6, #0x2b07, LSL #0
    MOVK  X6, #0x7eca, LSL #16
    MOVK  X6, #0x6d86, LSL #32
    MOVK  X6, #0xd7a3, LSL #48
    MOVZ  X7, #0x2360, LSL #0
    MOVK  X7, #0x1001, LSL #16
    MOVK  X7, #0xcfc2, LSL #32
    MOVK  X7, #0x4fba, LSL #48
    MOVZ  X9, #0x671, LSL #0
    MOVK  X9, #0x8a4, LSL #16
    MOVK  X9, #0x3693, LSL #32
    MOVK  X9, #0x94b3, LSL #48
    MOVZ  X10, #0xcf76, LSL #0
    MOVK  X10, #0x2808, LSL #16
    MOVK  X10, #0xc2e8, LSL #32
    MOVK  X10, #0x33ac, LSL #48
    MOVZ  X11, #0x618b, LSL #0
    MOVK  X11, #0x2f29, LSL #16
    MOVK  X11, #0x9f90, LSL #32
    MOVK  X11, #0xfc54, LSL #48
    MOVZ  X12, #0x782b, LSL #0
    MOVK  X12, #0x20ad, LSL #16
    MOVK  X12, #0x3cb4, LSL #32
    MOVK  X12, #0xebf1, LSL #48
    MOVZ  X13, #0x46fd, LSL #0
    MOVK  X13, #0xd95e, LSL #16
    MOVK  X13, #0x88c3, LSL #32
    MOVK  X13, #0x24, LSL #48
    MOVZ  X14, #0x8f67, LSL #0
    MOVK  X14, #0xbb03, LSL #16
    MOVK  X14, #0x8639, LSL #32
    MOVK  X14, #0xb15d, LSL #48
    MOVZ  X15, #0x9379, LSL #0
    MOVK  X15, #0x5b83, LSL #16
    MOVK  X15, #0x51b7, LSL #32
    MOVK  X15, #0x6f47, LSL #48
    MOVZ  X16, #0xc0ec, LSL #0
    MOVK  X16, #0xf94a, LSL #16
    MOVK  X16, #0xcaca, LSL #32
    MOVK  X16, #0x591c, LSL #48
    MOVZ  X17, #0x8073, LSL #0
    MOVK  X17, #0x359a, LSL #16
    MOVK  X17, #0xfe93, LSL #32
    MOVK  X17, #0x13ed, LSL #48
    MOVZ  X18, #0x9a2e, LSL #0
    MOVK  X18, #0x422a, LSL #16
    MOVK  X18, #0xcc51, LSL #32
    MOVK  X18, #0x84d3, LSL #48
    MOVZ  X19, #0xc585, LSL #0
    MOVK  X19, #0xfbb4, LSL #16
    MOVK  X19, #0xbd6a, LSL #32
    MOVK  X19, #0x1062, LSL #48
    MOVZ  X21, #0xbb57, LSL #0
    MOVK  X21, #0xe6f7, LSL #16
    MOVK  X21, #0xfc17, LSL #32
    MOVK  X21, #0xb0a3, LSL #48
    MOVZ  X22, #0xdd38, LSL #0
    MOVK  X22, #0x4647, LSL #16
    MOVK  X22, #0x7ac0, LSL #32
    MOVK  X22, #0x887f, LSL #48
    MOVZ  X24, #0x5c04, LSL #0
    MOVK  X24, #0xe54c, LSL #16
    MOVK  X24, #0xf424, LSL #32
    MOVK  X24, #0x90ad, LSL #48
    MOVZ  X25, #0x24d2, LSL #0
    MOVK  X25, #0x6f29, LSL #16
    MOVK  X25, #0xd588, LSL #32
    MOVK  X25, #0xff94, LSL #48
    MOVZ  X27, #0x155b, LSL #0
    MOVK  X27, #0xb67b, LSL #16
    MOVK  X27, #0x5b42, LSL #32
    MOVK  X27, #0x3605, LSL #48
    MOVZ  X28, #0x76dd, LSL #0
    MOVK  X28, #0x853a, LSL #16
    MOVK  X28, #0xe9f6, LSL #32
    MOVK  X28, #0xcda7, LSL #48
    MOVZ  X29, #0x2b1f, LSL #0
    MOVK  X29, #0xa79e, LSL #16
    MOVK  X29, #0xa973, LSL #32
    MOVK  X29, #0x2e4d, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X14
    FMOV  V3.D[1], X12
    FMOV  D4, X6
    FMOV  V4.D[1], X7
    FMOV  D5, X7
    FMOV  V5.D[1], X9
    FMOV  D6, X3
    FMOV  V6.D[1], X3
    FMOV  D7, X16
    FMOV  V7.D[1], X11
    FMOV  D8, X22
    FMOV  V8.D[1], X11
    FMOV  D9, X15
    FMOV  V9.D[1], X2
    FMOV  D10, X5
    FMOV  V10.D[1], X27
    FMOV  D11, X27
    FMOV  V11.D[1], X11
    FMOV  D12, X21
    FMOV  V12.D[1], X15
    FMOV  D13, X15
    FMOV  V13.D[1], X7
    FMOV  D14, X22
    FMOV  V14.D[1], X11
    FMOV  D15, X10
    FMOV  V15.D[1], X29
    FMOV  D16, X7
    FMOV  V16.D[1], X25
    FMOV  D17, X3
    FMOV  V17.D[1], X7
    FMOV  D18, X28
    FMOV  V18.D[1], X16
    FMOV  D19, X6
    FMOV  V19.D[1], X9
    FMOV  D20, X28
    FMOV  V20.D[1], X24
    FMOV  D21, X7
    FMOV  V21.D[1], X7
    FMOV  D22, X3
    FMOV  V22.D[1], X12
    FMOV  D23, X9
    FMOV  V23.D[1], X16
    FMOV  D24, X9
    FMOV  V24.D[1], X7
    FMOV  D25, X10
    FMOV  V25.D[1], X29
    FMOV  D26, X21
    FMOV  V26.D[1], X14
    FMOV  D27, X27
    FMOV  V27.D[1], X11
    FMOV  D28, X22
    FMOV  V28.D[1], X11
    FMOV  D29, X22
    FMOV  V29.D[1], X25
    FMOV  D30, X7
    FMOV  V30.D[1], X6
    FMOV  D31, X14
    FMOV  V31.D[1], X19
    MOVZ  X12, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_3:
    FRINTZ  S11, S29
    FRINTI  S30, S19
    FRINTI  H29, H31
    FRINTA  H27, H28
    FRINTX  S7, S27
    FRINTA  H22, H11
    FRINTX  S0, S26
    FRINTP  H0, H22
    FRINTX  D3, D30
    FRINTM  D27, D0
    FRINTP  H9, H29
    FRINTN  H17, H9
    FRINTN  H0, H17
    FRINTZ  H3, H3
    FRINTA  S21, S3
    FRINTZ  S20, S7
    FRINTX  H29, H20
    FRINTZ  S20, S0
    FRINTZ  D19, D20
    FRINTN  D7, D21
    FRINTN  H8, H19
    FRINTA  H6, H7
    FRINTN  S25, S18
    FRINTM  D0, D25
    FRINTP  D19, D29
    FRINTM  S26, S8
    FRINTP  D18, D19
    FRINTZ  S25, S6
    FRINTX  H28, H27
    FRINTN  S17, S0
    FRINTI  S7, S17
    FRINTP  H9, H26
    FRINTM  D26, D25
    FRINTX  H25, H18
    FRINTN  D20, D28
    FRINTN  H6, H20
    FRINTN  S19, S6
    FRINTN  H6, H26
    FRINTM  S29, S6
    FRINTA  S21, S29
    FRINTZ  H6, H19
    FRINTI  D27, D7
    FRINTM  S18, S21
    FRINTP  D21, D9
    FRINTX  D9, D21
    FRINTP  S21, S1
    FRINTA  S29, S21
    FRINTI  H8, H6
    FRINTN  D7, D25
    FRINTN  D17, D18
    FRINTA  D28, D27
    FRINTZ  H20, H9
    FRINTN  D21, D29
    FRINTI  S26, S8
    FRINTZ  S1, S26
    FRINTZ  D19, D7
    FRINTA  D7, D17
    FRINTN  H17, H1
    FRINTI  D1, D17
    FRINTX  D29, D28
    FRINTA  D28, D19
    FRINTA  H6, H7
    FRINTA  S7, S6
    FRINTA  S9, S20
    FRINTA  D18, D21
    FRINTA  S27, S1
    FRINTZ  D6, D29
    FRINTM  D8, D29
    FRINTP  S19, S8
    FRINTN  H26, H27
    FRINTX  D29, D17
    FRINTI  H21, H20
    FRINTM  D17, D29
    FRINTP  S29, S18
    FRINTN  D8, D28
    FRINTA  H28, H7
    FRINTP  D7, D17
    FRINTX  D18, D19
    FRINTP  H20, H2
    FRINTN  H2, H20
    FRINTI  S27, S8
    FRINTI  S19, S21
    FRINTX  D21, D7
    FRINTN  H1, H9
    FRINTZ  H20, H6
    FRINTX  S8, S1
    FRINTN  D1, D27
    FRINTP  D7, D26
    FRINTN  D17, D20
    FRINTN  S20, S1
    FRINTZ  H6, H20
    FRINTI  S9, S6
    FRINTN  H1, H8
    FRINTP  H27, H7
    FRINTZ  S26, S1
    FRINTZ  S6, S2
    FRINTA  D20, D9
    FRINTI  S8, S26
    FRINTZ  D9, D8
    FRINTX  H26, H21
    FRINTA  S2, S17
    FRINTP  D17, D19
    FRINTZ  D8, D27
    FRINTI  S21, S9
    FRINTX  H9, H6
    FRINTA  S19, S20
    FRINTN  H7, H26
    FRINTA  D27, D8
    FRINTZ  S1, S2
    FRINTA  H8, H7
    FRINTA  H6, H27
    FRINTN  H27, H1
    FRINTN  D20, D27
    FRINTA  H26, H30
    FRINTX  D2, D8
    FRINTP  D1, D2
    FRINTZ  H6, H19
    FRINTX  S7, S17
    FRINTA  H2, H1
    FRINTN  S30, S6
    FRINTI  H17, H30
    FRINTZ  S1, S9
    FRINTM  D30, D20
    FRINTP  D19, D17
    FRINTZ  H17, H1
    FRINTI  S27, S21
    FRINTP  D8, D26
    FRINTP  H26, H8
    FRINTN  H0, H7
    FRINTN  D21, D0
    FRINTZ  S8, S2
    FRINTA  D2, D30
    FRINTX  D7, D23
    FRINTP  H1, H19
    FRINTP  D30, D26
    FRINTI  D9, D2
    FRINTZ  S19, S1
    FRINTP  S6, S19
    FRINTM  S0, S27
    FRINTX  S20, S0
    FRINTX  S19, S8
    FRINTP  H27, H19
    FRINTM  D19, D20
    FRINTP  D1, D27
    FRINTZ  S4, S9
    FRINTN  H10, H4
    FRINTN  D9, D7
    FRINTM  D21, D6
    FRINTX  S20, S19
    FRINTZ  H23, H30
    FRINTN  S26, S1
    FRINTM  S30, S10
    FRINTP  H2, H20
    FRINTI  D0, D26
    FRINTN  D1, D0
    FRINTX  D8, D30
    FRINTZ  H27, H2
    FRINTP  D10, D27
    FRINTX  H19, H23
    FRINTA  S4, S21
    FRINTZ  D7, D20
    FRINTP  H6, H19
    FRINTP  H23, H4
    FRINTX  D2, D9
    FRINTA  D26, D7
    FRINTM  H7, H6
    FRINTX  H20, H26
    FRINTM  H12, H23
    FRINTA  S0, S27
    FRINTP  D23, D10
    FRINTI  S30, S2
    FRINTN  H2, H12
    FRINTA  H21, H20
    FRINTA  H12, H0
    FRINTX  D10, D8
    FRINTX  S9, S7
    FRINTA  D7, D2
    FRINTM  H6, H7
    FRINTI  H0, H23
    FRINTZ  D23, D12
    FRINTZ  H19, H23
    FRINTP  S2, S9
    FRINTP  H8, H21
    FRINTI  D9, D10
    FRINTZ  D23, D9
    FRINTP  S20, S0
    FRINTI  H7, H30
    FRINTI  D21, D2
    FRINTZ  D10, D23
    FRINTI  D9, D2
    FRINTI  D4, D8
    FRINTM  S12, S6
    FRINTA  S0, S7
    FRINTZ  H2, H19
    FRINTN  H19, H12
    FRINTP  D23, D7
    FRINTA  H7, H20
    FRINTA  H12, H7
    FRINTZ  D27, D9
    FRINTA  D9, D19
    SUBS  X12, X12, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_3
    MOVZ  X11, #0xa9ae, LSL #0
    MOVK  X11, #0xaf5c, LSL #16
    MOVK  X11, #0x3d8a, LSL #32
    MOVK  X11, #0x7ee4, LSL #48
    SUB  X2, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xd9b9, LSL #0
    MOVK  X11, #0x1555, LSL #16
    MOVK  X11, #0x9f09, LSL #32
    MOVK  X11, #0x402e, LSL #48
    SUB  X2, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x9e91, LSL #0
    MOVK  X11, #0x9c03, LSL #16
    MOVK  X11, #0x5709, LSL #32
    MOVK  X11, #0x8d29, LSL #48
    SUB  X2, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x2b07, LSL #0
    MOVK  X11, #0x7eca, LSL #16
    MOVK  X11, #0x6d86, LSL #32
    MOVK  X11, #0xd7a3, LSL #48
    SUB  X2, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x2360, LSL #0
    MOVK  X11, #0x1001, LSL #16
    MOVK  X11, #0xcfc2, LSL #32
    MOVK  X11, #0x4fba, LSL #48
    SUB  X2, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x671, LSL #0
    MOVK  X11, #0x8a4, LSL #16
    MOVK  X11, #0x3693, LSL #32
    MOVK  X11, #0x94b3, LSL #48
    SUB  X2, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xcf76, LSL #0
    MOVK  X11, #0x2808, LSL #16
    MOVK  X11, #0xc2e8, LSL #32
    MOVK  X11, #0x33ac, LSL #48
    SUB  X2, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x46fd, LSL #0
    MOVK  X11, #0xd95e, LSL #16
    MOVK  X11, #0x88c3, LSL #32
    MOVK  X11, #0x24, LSL #48
    SUB  X2, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x8f67, LSL #0
    MOVK  X11, #0xbb03, LSL #16
    MOVK  X11, #0x8639, LSL #32
    MOVK  X11, #0xb15d, LSL #48
    SUB  X2, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x9379, LSL #0
    MOVK  X11, #0x5b83, LSL #16
    MOVK  X11, #0x51b7, LSL #32
    MOVK  X11, #0x6f47, LSL #48
    SUB  X2, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xc0ec, LSL #0
    MOVK  X11, #0xf94a, LSL #16
    MOVK  X11, #0xcaca, LSL #32
    MOVK  X11, #0x591c, LSL #48
    SUB  X2, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x8073, LSL #0
    MOVK  X11, #0x359a, LSL #16
    MOVK  X11, #0xfe93, LSL #32
    MOVK  X11, #0x13ed, LSL #48
    SUB  X2, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x9a2e, LSL #0
    MOVK  X11, #0x422a, LSL #16
    MOVK  X11, #0xcc51, LSL #32
    MOVK  X11, #0x84d3, LSL #48
    SUB  X2, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xc585, LSL #0
    MOVK  X11, #0xfbb4, LSL #16
    MOVK  X11, #0xbd6a, LSL #32
    MOVK  X11, #0x1062, LSL #48
    SUB  X2, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xbb57, LSL #0
    MOVK  X11, #0xe6f7, LSL #16
    MOVK  X11, #0xfc17, LSL #32
    MOVK  X11, #0xb0a3, LSL #48
    SUB  X2, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xdd38, LSL #0
    MOVK  X11, #0x4647, LSL #16
    MOVK  X11, #0x7ac0, LSL #32
    MOVK  X11, #0x887f, LSL #48
    SUB  X2, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x24d2, LSL #0
    MOVK  X11, #0x6f29, LSL #16
    MOVK  X11, #0xd588, LSL #32
    MOVK  X11, #0xff94, LSL #48
    SUB  X2, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x155b, LSL #0
    MOVK  X11, #0xb67b, LSL #16
    MOVK  X11, #0x5b42, LSL #32
    MOVK  X11, #0x3605, LSL #48
    SUB  X2, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x76dd, LSL #0
    MOVK  X11, #0x853a, LSL #16
    MOVK  X11, #0xe9f6, LSL #32
    MOVK  X11, #0xcda7, LSL #48
    SUB  X2, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x2b1f, LSL #0
    MOVK  X11, #0xa79e, LSL #16
    MOVK  X11, #0xa973, LSL #32
    MOVK  X11, #0x2e4d, LSL #48
    SUB  X2, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x10, LSL #0
    MRS  X2, FPSR
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D0
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D1
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D2
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D3
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D4
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x671, LSL #0
    MOVK  X11, #0x8a4, LSL #16
    MOVK  X11, #0x3693, LSL #32
    MOVK  X11, #0x94b3, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x2360, LSL #0
    MOVK  X11, #0x1001, LSL #16
    MOVK  X11, #0xcfc2, LSL #32
    MOVK  X11, #0x4fba, LSL #48
    FMOV  X2, D5
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D6
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D7
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D8
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D9
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D10
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D11
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D12
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x2360, LSL #0
    MOVK  X11, #0x1001, LSL #16
    MOVK  X11, #0xcfc2, LSL #32
    MOVK  X11, #0x4fba, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x9379, LSL #0
    MOVK  X11, #0x5b83, LSL #16
    MOVK  X11, #0x51b7, LSL #32
    MOVK  X11, #0x6f47, LSL #48
    FMOV  X2, D13
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x618b, LSL #0
    MOVK  X11, #0x2f29, LSL #16
    MOVK  X11, #0x9f90, LSL #32
    MOVK  X11, #0xfc54, LSL #48
    FMOV  X2, V14.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xdd38, LSL #0
    MOVK  X11, #0x4647, LSL #16
    MOVK  X11, #0x7ac0, LSL #32
    MOVK  X11, #0x887f, LSL #48
    FMOV  X2, D14
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x2b1f, LSL #0
    MOVK  X11, #0xa79e, LSL #16
    MOVK  X11, #0xa973, LSL #32
    MOVK  X11, #0x2e4d, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xcf76, LSL #0
    MOVK  X11, #0x2808, LSL #16
    MOVK  X11, #0xc2e8, LSL #32
    MOVK  X11, #0x33ac, LSL #48
    FMOV  X2, D15
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x24d2, LSL #0
    MOVK  X11, #0x6f29, LSL #16
    MOVK  X11, #0xd588, LSL #32
    MOVK  X11, #0xff94, LSL #48
    FMOV  X2, V16.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x2360, LSL #0
    MOVK  X11, #0x1001, LSL #16
    MOVK  X11, #0xcfc2, LSL #32
    MOVK  X11, #0x4fba, LSL #48
    FMOV  X2, D16
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D17
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D18
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D19
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D20
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V21.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D21
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V22.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D22
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D23
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x2360, LSL #0
    MOVK  X11, #0x1001, LSL #16
    MOVK  X11, #0xcfc2, LSL #32
    MOVK  X11, #0x4fba, LSL #48
    FMOV  X2, V24.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x671, LSL #0
    MOVK  X11, #0x8a4, LSL #16
    MOVK  X11, #0x3693, LSL #32
    MOVK  X11, #0x94b3, LSL #48
    FMOV  X2, D24
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D25
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D26
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D27
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D29
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D30
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0xc585, LSL #0
    MOVK  X11, #0xfbb4, LSL #16
    MOVK  X11, #0xbd6a, LSL #32
    MOVK  X11, #0x1062, LSL #48
    FMOV  X2, V31.D[1]
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x8f67, LSL #0
    MOVK  X11, #0xbb03, LSL #16
    MOVK  X11, #0x8639, LSL #32
    MOVK  X11, #0xb15d, LSL #48
    FMOV  X2, D31
    SUB  X24, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X22
    FMOV  V0.D[1], X21
    FMOV  D1, X19
    FMOV  V1.D[1], X29
    FMOV  D2, X24
    FMOV  V2.D[1], X12
    FMOV  D3, X28
    FMOV  V3.D[1], X18
    FMOV  D4, X17
    FMOV  V4.D[1], X13
    FMOV  D5, X27
    FMOV  V5.D[1], X25
    FMOV  D6, X3
    FMOV  V6.D[1], X3
    FMOV  D7, X25
    FMOV  V7.D[1], X3
    FMOV  D8, X14
    FMOV  V8.D[1], X7
    FMOV  D9, X28
    FMOV  V9.D[1], X24
    FMOV  D10, X18
    FMOV  V10.D[1], X3
    FMOV  D11, X28
    FMOV  V11.D[1], X25
    FMOV  D12, X15
    FMOV  V12.D[1], X4
    FMOV  D13, X3
    FMOV  V13.D[1], X21
    FMOV  D14, X25
    FMOV  V14.D[1], X6
    FMOV  D15, X10
    FMOV  V15.D[1], X10
    FMOV  D16, X4
    FMOV  V16.D[1], X21
    FMOV  D17, X16
    FMOV  V17.D[1], X16
    FMOV  D18, X28
    FMOV  V18.D[1], X11
    FMOV  D19, X14
    FMOV  V19.D[1], X10
    FMOV  D20, X16
    FMOV  V20.D[1], X28
    FMOV  D21, X27
    FMOV  V21.D[1], X15
    FMOV  D22, X24
    FMOV  V22.D[1], X10
    FMOV  D23, X24
    FMOV  V23.D[1], X10
    FMOV  D24, X12
    FMOV  V24.D[1], X19
    FMOV  D25, X11
    FMOV  V25.D[1], X5
    FMOV  D26, X15
    FMOV  V26.D[1], X7
    FMOV  D27, X25
    FMOV  V27.D[1], X24
    FMOV  D28, X11
    FMOV  V28.D[1], X21
    FMOV  D29, X22
    FMOV  V29.D[1], X29
    FMOV  D30, X13
    FMOV  V30.D[1], X13
    FMOV  D31, X19
    FMOV  V31.D[1], X29
    MOVZ  X29, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_4:
    FRINTM  S12, S24
    FRINTM  S7, S25
    FRINTN  S7, S23
    FRINTP  D30, D30
    FRINTX  H13, H30
    FRINTA  S2, S26
    FRINTI  H4, H2
    FRINTI  H20, H27
    FRINTN  S16, S4
    FRINTX  S15, S22
    FRINTI  S4, S16
    FRINTZ  S30, S1
    FRINTZ  S9, S15
    FRINTZ  S19, S28
    FRINTZ  S12, S13
    FRINTX  S28, S4
    FRINTN  H2, H31
    FRINTI  H3, H2
    FRINTM  H31, H29
    FRINTA  H10, H9
    FRINTA  D20, D20
    FRINTA  D10, D3
    FRINTM  H2, H13
    FRINTZ  H23, H31
    FRINTA  D9, D20
    FRINTM  D24, D28
    FRINTX  S22, S12
    FRINTZ  D25, D24
    FRINTI  H28, H25
    FRINTA  D29, D19
    FRINTA  H16, H30
    FRINTZ  D15, D29
    FRINTA  S4, S15
    FRINTI  S20, S22
    FRINTI  S12, S20
    FRINTA  S29, S10
    FRINTP  S10, S4
    FRINTN  D30, D23
    FRINTN  H20, H12
    FRINTX  S19, S28
    FRINTM  S31, S19
    FRINTZ  D19, D8
    FRINTX  D3, D30
    FRINTM  S28, S31
    FRINTM  H30, H10
    FRINTA  S24, S16
    FRINTA  D22, D3
    FRINTN  H25, H22
    FRINTN  S8, S30
    FRINTN  D15, D20
    FRINTA  D20, D8
    FRINTI  H3, H20
    FRINTX  D31, D19
    FRINTP  H4, H24
    FRINTI  S22, S4
    FRINTI  S12, S29
    FRINTI  S23, S15
    FRINTX  H4, H31
    FRINTA  D19, D23
    FRINTM  H10, H28
    FRINTX  D20, D10
    FRINTI  D24, D22
    FRINTA  D16, D19
    FRINTX  H23, H12
    FRINTN  S12, S24
    FRINTN  H29, H20
    FRINTA  H28, H3
    FRINTI  S31, S4
    FRINTI  S19, S25
    FRINTN  H24, H16
    FRINTP  D8, D28
    FRINTN  S16, S8
    FRINTI  S3, S16
    FRINTA  H4, H23
    FRINTX  H25, H19
    FRINTN  H20, H12
    FRINTI  H22, H3
    FRINTN  S15, S20
    FRINTX  S28, S4
    FRINTN  D10, D28
    FRINTM  D8, D22
    FRINTI  H20, H31
    FRINTN  D16, D24
    FRINTM  S3, S29
    FRINTX  S29, S0
    FRINTX  D29, D29
    FRINTX  D23, D3
    FRINTA  S19, S15
    FRINTA  S28, S20
    FRINTN  S15, S10
    FRINTM  D31, D16
    FRINTI  S16, S25
    FRINTA  D10, D29
    FRINTP  D0, D19
    FRINTM  H3, H28
    FRINTP  S4, S10
    FRINTP  D22, D31
    FRINTP  S12, S23
    FRINTX  D24, D0
    FRINTM  D25, D24
    FRINTA  H0, H8
    FRINTI  D24, D3
    FRINTX  S20, S15
    FRINTX  S29, S25
    FRINTN  D28, D22
    FRINTM  D19, D12
    FRINTX  D15, D19
    FRINTZ  H31, H24
    FRINTI  H23, H28
    FRINTM  H7, H23
    FRINTZ  D25, D15
    FRINTX  S10, S16
    FRINTZ  D19, D4
    FRINTN  H8, H19
    FRINTX  S15, S29
    FRINTN  H3, H15
    FRINTX  S22, S10
    FRINTP  H29, H0
    FRINTZ  H15, H25
    FRINTX  H25, H20
    FRINTP  D12, D22
    FRINTA  S22, S7
    FRINTZ  H15, H8
    FRINTX  S22, S29
    FRINTM  S28, S22
    FRINTN  S19, S15
    FRINTM  D7, D12
    FRINTP  D23, D31
    FRINTI  S29, S23
    FRINTP  H20, H25
    FRINTM  D4, D7
    FRINTA  D31, D29
    FRINTI  H8, H19
    FRINTI  H0, H31
    FRINTN  D24, D20
    FRINTN  D10, D3
    FRINTI  H3, H0
    FRINTM  H7, H28
    FRINTN  D22, D4
    FRINTI  D31, D10
    FRINTI  D23, D3
    FRINTP  H3, H8
    FRINTA  D25, D6
    FRINTA  S12, S25
    FRINTX  H8, H23
    FRINTI  S20, S31
    FRINTA  S31, S7
    FRINTN  S6, S24
    FRINTP  D25, D22
    FRINTA  H22, H8
    FRINTN  H23, H12
    FRINTM  H4, H6
    FRINTA  D15, D4
    FRINTP  S8, S15
    FRINTZ  S6, S20
    FRINTN  S15, S8
    FRINTA  S12, S5
    FRINTX  D10, D22
    FRINTA  H8, H6
    FRINTZ  D4, D31
    FRINTI  S7, S12
    FRINTZ  D24, D7
    FRINTZ  D7, D8
    FRINTI  D8, D4
    FRINTZ  D20, D24
    FRINTX  S24, S10
    FRINTZ  H10, H15
    FRINTA  D31, D25
    FRINTX  H25, H3
    FRINTI  H4, H23
    FRINTZ  S5, S4
    FRINTM  H22, H31
    FRINTP  S4, S25
    FRINTZ  D12, D24
    FRINTM  D6, D26
    FRINTX  H15, H5
    FRINTP  S5, S4
    FRINTN  S31, S10
    FRINTM  S10, S21
    FRINTA  D19, D20
    FRINTM  D25, D15
    FRINTI  H24, H25
    FRINTX  S21, S22
    FRINTA  H3, H21
    FRINTI  H23, H7
    FRINTP  H22, H8
    FRINTM  H26, H5
    FRINTP  S15, S23
    FRINTZ  S23, S15
    FRINTM  D5, D24
    FRINTM  D8, D31
    FRINTN  H24, H8
    FRINTN  D15, D3
    FRINTZ  H7, H15
    FRINTP  H29, H19
    FRINTX  H31, H23
    FRINTN  H15, H22
    FRINTI  S20, S7
    FRINTA  H8, H10
    FRINTZ  H21, H31
    SUBS  X29, X29, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_4
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x10, LSL #0
    MRS  X28, FPSR
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D0
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D1
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D2
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D3
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D4
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V5.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D5
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D6
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D7
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D8
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D9
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D10
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D11
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D12
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D13
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D14
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D15
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D16
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D17
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D18
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D19
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D20
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D21
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D22
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D23
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D24
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D25
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D26
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D27
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D28
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D29
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D30
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, V31.D[1]
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X28, D31
    SUB  X15, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
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
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X29
    FMOV  D3, X29
    FMOV  V3.D[1], X2
    FMOV  D4, X29
    FMOV  V4.D[1], X14
    FMOV  D5, X27
    FMOV  V5.D[1], X25
    FMOV  D6, X5
    FMOV  V6.D[1], X16
    FMOV  D7, X28
    FMOV  V7.D[1], X14
    FMOV  D8, X7
    FMOV  V8.D[1], X6
    FMOV  D9, X10
    FMOV  V9.D[1], X12
    FMOV  D10, X21
    FMOV  V10.D[1], X5
    FMOV  D11, X11
    FMOV  V11.D[1], X16
    FMOV  D12, X19
    FMOV  V12.D[1], X22
    FMOV  D13, X17
    FMOV  V13.D[1], X24
    FMOV  D14, X27
    FMOV  V14.D[1], X7
    FMOV  D15, X12
    FMOV  V15.D[1], X16
    FMOV  D16, X27
    FMOV  V16.D[1], X17
    FMOV  D17, X22
    FMOV  V17.D[1], X14
    FMOV  D18, X6
    FMOV  V18.D[1], X6
    FMOV  D19, X19
    FMOV  V19.D[1], X22
    FMOV  D20, X3
    FMOV  V20.D[1], X6
    FMOV  D21, X2
    FMOV  V21.D[1], X2
    FMOV  D22, X7
    FMOV  V22.D[1], X17
    FMOV  D23, X21
    FMOV  V23.D[1], X5
    FMOV  D24, X7
    FMOV  V24.D[1], X15
    FMOV  D25, X27
    FMOV  V25.D[1], X12
    FMOV  D26, X27
    FMOV  V26.D[1], X4
    FMOV  D27, X9
    FMOV  V27.D[1], X17
    FMOV  D28, X2
    FMOV  V28.D[1], X9
    FMOV  D29, X11
    FMOV  V29.D[1], X4
    FMOV  D30, X12
    FMOV  V30.D[1], X27
    FMOV  D31, X11
    FMOV  V31.D[1], X2
    MOVZ  X12, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_5:
    FRINTM  H9, H26
    FRINTN  D29, D30
    FRINTX  D30, D19
    FRINTM  S0, S28
    FRINTN  S30, S24
    FRINTN  H26, H27
    FRINTM  H19, H22
    FRINTN  S8, S25
    FRINTX  S16, S31
    FRINTZ  S22, S29
    FRINTM  H10, H26
    FRINTI  S30, S30
    FRINTI  H31, H16
    FRINTN  H24, H22
    FRINTI  S6, S31
    FRINTM  H27, H10
    FRINTN  H27, H24
    FRINTA  D22, D8
    FRINTZ  H2, H19
    FRINTI  S6, S9
    FRINTI  H26, H3
    FRINTM  D17, D26
    FRINTI  S18, S2
    FRINTX  H3, H7
    FRINTZ  H22, H22
    FRINTI  H29, H30
    FRINTX  H10, H27
    FRINTN  D20, D17
    FRINTZ  H24, H22
    FRINTZ  S25, S20
    FRINTP  S24, S10
    FRINTZ  S7, S18
    FRINTZ  H20, H25
    FRINTA  H2, H7
    FRINTA  S18, S2
    FRINTN  H16, H6
    FRINTN  S25, S16
    FRINTN  H19, H25
    FRINTP  S2, S18
    FRINTI  D31, D24
    FRINTX  D17, D20
    FRINTI  S8, S29
    FRINTM  D20, D31
    FRINTN  S10, S19
    FRINTI  S9, S10
    FRINTA  D19, D2
    FRINTZ  D22, D8
    FRINTX  S8, S22
    FRINTM  S7, S9
    FRINTN  S6, S20
    FRINTX  S22, S6
    FRINTZ  H29, H3
    FRINTM  H6, H7
    FRINTA  H24, H6
    FRINTM  H31, H22
    FRINTZ  D10, D8
    FRINTM  H18, H17
    FRINTN  H16, H31
    FRINTZ  H31, H24
    FRINTM  H20, H10
    FRINTA  D9, D18
    FRINTZ  S25, S16
    FRINTM  D2, D31
    FRINTP  D18, D20
    FRINTA  H20, H29
    FRINTM  S29, S25
    FRINTP  D23, D29
    FRINTN  S16, S2
    FRINTM  S22, S18
    FRINTZ  D10, D9
    FRINTN  S31, S10
    FRINTZ  H6, H23
    FRINTA  H24, H31
    FRINTP  S17, S24
    FRINTX  S24, S16
    FRINTI  H18, H24
    FRINTP  S2, S20
    FRINTM  H20, H18
    FRINTP  S23, S6
    FRINTA  S6, S22
    FRINTA  H22, H2
    FRINTM  H24, H22
    FRINTX  S16, S17
    FRINTZ  S31, S5
    FRINTX  S9, S31
    FRINTZ  S8, S20
    FRINTN  S18, S8
    FRINTZ  D10, D16
    FRINTP  S5, S9
    FRINTN  S9, S9
    FRINTM  H2, H30
    FRINTP  S30, S6
    FRINTZ  D22, D5
    FRINTN  D6, D23
    FRINTA  S17, S6
    FRINTI  D5, D24
    FRINTX  H31, H22
    FRINTZ  S20, S31
    FRINTP  D8, D20
    FRINTP  S24, S17
    FRINTP  H16, H24
    FRINTI  D17, D30
    FRINTZ  S6, S10
    FRINTP  D18, D24
    FRINTA  S20, S9
    FRINTN  S23, S18
    FRINTM  H9, H8
    FRINTM  S30, S17
    FRINTA  S24, S2
    FRINTP  D31, D30
    FRINTM  H22, H16
    FRINTP  S8, S9
    FRINTX  S16, S23
    FRINTA  D17, D24
    FRINTN  H17, H6
    FRINTX  D10, D20
    FRINTN  D20, D31
    FRINTM  S31, S22
    FRINTN  D18, D10
    FRINTZ  D2, D8
    FRINTA  S22, S18
    FRINTX  H9, H20
    FRINTN  S18, S2
    FRINTM  D23, D18
    FRINTM  H10, H23
    FRINTX  H30, H31
    FRINTP  H6, H17
    FRINTN  D24, D16
    FRINTP  D16, D20
    FRINTA  S8, S22
    FRINTI  S22, S10
    FRINTI  H10, H4
    FRINTN  H2, H9
    FRINTN  D31, D30
    FRINTN  D23, D16
    FRINTN  D20, D23
    FRINTX  H4, H6
    FRINTX  D6, D4
    FRINTA  S9, S24
    FRINTZ  H17, H22
    FRINTN  D22, D10
    FRINTM  D18, D8
    FRINTI  S30, S22
    FRINTZ  S23, S30
    FRINTP  D16, D23
    FRINTZ  D24, D9
    FRINTP  S4, S31
    FRINTP  H31, H16
    FRINTM  D23, D17
    FRINTM  D18, D20
    FRINTZ  D9, D18
    FRINTZ  D10, D6
    FRINTA  H6, H23
    FRINTP  S30, S9
    FRINTI  S23, S6
    FRINTM  S9, S24
    FRINTP  S24, S9
    FRINTA  D8, D24
    FRINTX  D22, D8
    FRINTZ  D9, D31
    FRINTM  D24, D9
    FRINTN  D8, D10
    FRINTX  H20, H30
    FRINTZ  S16, S8
    FRINTI  H6, H23
    FRINTZ  S17, S24
    FRINTN  S31, S4
    FRINTX  H30, H22
    FRINTN  H9, H30
    FRINTA  H8, H20
    FRINTZ  H30, H4
    FRINTA  S10, S6
    FRINTA  S4, S10
    FRINTZ  S18, S29
    FRINTN  D22, D16
    FRINTA  D20, D4
    FRINTZ  D20, D17
    FRINTX  D24, D18
    FRINTN  D18, D30
    FRINTA  S17, S8
    FRINTN  S29, S31
    FRINTP  S10, S12
    FRINTZ  H10, H10
    FRINTN  H16, H9
    FRINTX  H14, H20
    FRINTN  D23, D24
    FRINTI  S30, S3
    FRINTI  H4, H14
    FRINTX  H3, H16
    FRINTZ  H16, H22
    FRINTM  D8, D17
    FRINTZ  H31, H8
    FRINTZ  S22, S23
    FRINTZ  D24, D7
    FRINTX  D20, D16
    FRINTI  S16, S18
    FRINTA  H12, H30
    FRINTX  S30, S4
    FRINTX  S18, S24
    FRINTP  S24, S18
    SUBS  X12, X12, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_5
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x10, LSL #0
    MRS  X7, FPSR
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    FMOV  X7, D0
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, V1.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, D1
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D2
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D3
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D4
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D5
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D6
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D7
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D8
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D9
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V10.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D10
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, D11
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D12
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, V13.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, D13
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D14
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, V15.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, D15
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D16
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D17
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D18
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D19
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D20
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, V21.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, D21
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D22
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D23
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D24
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D25
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D26
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D27
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, V28.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X7, D28
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D29
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D30
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, D31
    SUB  X6, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x8469, LSL #0
    MOVK  X2, #0x6de0, LSL #16
    MOVK  X2, #0xc7b6, LSL #32
    MOVK  X2, #0xbfb6, LSL #48
    MOVZ  X3, #0xee03, LSL #0
    MOVK  X3, #0xaf08, LSL #16
    MOVK  X3, #0xb615, LSL #32
    MOVK  X3, #0x21c7, LSL #48
    MOVZ  X4, #0x4c1b, LSL #0
    MOVK  X4, #0x4789, LSL #16
    MOVK  X4, #0x9869, LSL #32
    MOVK  X4, #0xd75e, LSL #48
    MOVZ  X5, #0x69e6, LSL #0
    MOVK  X5, #0xe29c, LSL #16
    MOVK  X5, #0x8500, LSL #32
    MOVK  X5, #0x99b1, LSL #48
    MOVZ  X6, #0x686e, LSL #0
    MOVK  X6, #0xc931, LSL #16
    MOVK  X6, #0x93d5, LSL #32
    MOVK  X6, #0xf236, LSL #48
    MOVZ  X7, #0x2748, LSL #0
    MOVK  X7, #0xc1e, LSL #16
    MOVK  X7, #0x8c64, LSL #32
    MOVK  X7, #0x241d, LSL #48
    MOVZ  X9, #0xb324, LSL #0
    MOVK  X9, #0xcf80, LSL #16
    MOVK  X9, #0xbe86, LSL #32
    MOVK  X9, #0x1eb4, LSL #48
    MOVZ  X10, #0xd1b2, LSL #0
    MOVK  X10, #0xe731, LSL #16
    MOVK  X10, #0x1d5c, LSL #32
    MOVK  X10, #0x402d, LSL #48
    MOVZ  X11, #0x64e9, LSL #0
    MOVK  X11, #0x809, LSL #16
    MOVK  X11, #0xb0f4, LSL #32
    MOVK  X11, #0xe218, LSL #48
    MOVZ  X12, #0x2503, LSL #0
    MOVK  X12, #0x3b16, LSL #16
    MOVK  X12, #0x4594, LSL #32
    MOVK  X12, #0x8b11, LSL #48
    MOVZ  X13, #0x8b0a, LSL #0
    MOVK  X13, #0x3711, LSL #16
    MOVK  X13, #0x12e7, LSL #32
    MOVK  X13, #0xf73d, LSL #48
    MOVZ  X14, #0x21e7, LSL #0
    MOVK  X14, #0xf694, LSL #16
    MOVK  X14, #0x93fd, LSL #32
    MOVK  X14, #0xf2d7, LSL #48
    MOVZ  X15, #0x3cbf, LSL #0
    MOVK  X15, #0xd069, LSL #16
    MOVK  X15, #0xdaa0, LSL #32
    MOVK  X15, #0x7ee, LSL #48
    MOVZ  X16, #0xc8be, LSL #0
    MOVK  X16, #0x450b, LSL #16
    MOVK  X16, #0x97c, LSL #32
    MOVK  X16, #0x5151, LSL #48
    MOVZ  X17, #0x6f15, LSL #0
    MOVK  X17, #0x1b75, LSL #16
    MOVK  X17, #0x67e5, LSL #32
    MOVK  X17, #0x8e95, LSL #48
    MOVZ  X18, #0xa81, LSL #0
    MOVK  X18, #0xfe03, LSL #16
    MOVK  X18, #0xdb11, LSL #32
    MOVK  X18, #0x6a4, LSL #48
    MOVZ  X19, #0x4b45, LSL #0
    MOVK  X19, #0xd39e, LSL #16
    MOVK  X19, #0xf4f, LSL #32
    MOVK  X19, #0xef61, LSL #48
    MOVZ  X21, #0xf015, LSL #0
    MOVK  X21, #0x43b4, LSL #16
    MOVK  X21, #0x6f47, LSL #32
    MOVK  X21, #0x5c36, LSL #48
    MOVZ  X22, #0xaf26, LSL #0
    MOVK  X22, #0xef7f, LSL #16
    MOVK  X22, #0x93d3, LSL #32
    MOVK  X22, #0x751c, LSL #48
    MOVZ  X24, #0x22d0, LSL #0
    MOVK  X24, #0x25b8, LSL #16
    MOVK  X24, #0xa16e, LSL #32
    MOVK  X24, #0x377a, LSL #48
    MOVZ  X25, #0x97b2, LSL #0
    MOVK  X25, #0xe5ea, LSL #16
    MOVK  X25, #0x27f0, LSL #32
    MOVK  X25, #0x137e, LSL #48
    MOVZ  X27, #0x8e90, LSL #0
    MOVK  X27, #0xefa2, LSL #16
    MOVK  X27, #0xb075, LSL #32
    MOVK  X27, #0x5139, LSL #48
    MOVZ  X28, #0xc755, LSL #0
    MOVK  X28, #0xb6db, LSL #16
    MOVK  X28, #0x61c8, LSL #32
    MOVK  X28, #0xdde3, LSL #48
    MOVZ  X29, #0xf359, LSL #0
    MOVK  X29, #0x65fa, LSL #16
    MOVK  X29, #0x8ada, LSL #32
    MOVK  X29, #0x9851, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X5
    FMOV  V2.D[1], X7
    FMOV  D3, X25
    FMOV  V3.D[1], X10
    FMOV  D4, X25
    FMOV  V4.D[1], X3
    FMOV  D5, X14
    FMOV  V5.D[1], X5
    FMOV  D6, X24
    FMOV  V6.D[1], X25
    FMOV  D7, X18
    FMOV  V7.D[1], X18
    FMOV  D8, X10
    FMOV  V8.D[1], X15
    FMOV  D9, X21
    FMOV  V9.D[1], X10
    FMOV  D10, X25
    FMOV  V10.D[1], X21
    FMOV  D11, X11
    FMOV  V11.D[1], X19
    FMOV  D12, X28
    FMOV  V12.D[1], X27
    FMOV  D13, X12
    FMOV  V13.D[1], X25
    FMOV  D14, X4
    FMOV  V14.D[1], X5
    FMOV  D15, X25
    FMOV  V15.D[1], X17
    FMOV  D16, X10
    FMOV  V16.D[1], X12
    FMOV  D17, X11
    FMOV  V17.D[1], X15
    FMOV  D18, X18
    FMOV  V18.D[1], X4
    FMOV  D19, X19
    FMOV  V19.D[1], X29
    FMOV  D20, X16
    FMOV  V20.D[1], X14
    FMOV  D21, X21
    FMOV  V21.D[1], X29
    FMOV  D22, X29
    FMOV  V22.D[1], X3
    FMOV  D23, X14
    FMOV  V23.D[1], X5
    FMOV  D24, X16
    FMOV  V24.D[1], X16
    FMOV  D25, X10
    FMOV  V25.D[1], X4
    FMOV  D26, X18
    FMOV  V26.D[1], X28
    FMOV  D27, X16
    FMOV  V27.D[1], X4
    FMOV  D28, X7
    FMOV  V28.D[1], X21
    FMOV  D29, X15
    FMOV  V29.D[1], X5
    FMOV  D30, X14
    FMOV  V30.D[1], X21
    FMOV  D31, X2
    FMOV  V31.D[1], X19
    MOVZ  X25, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_6:
    FRINTM  H19, H29
    FRINTZ  H9, H26
    FRINTM  H12, H9
    FRINTI  S21, S12
    FRINTX  S19, S30
    FRINTP  H7, H31
    FRINTN  S23, S25
    FRINTZ  H7, H23
    FRINTI  S11, S22
    FRINTI  H31, H28
    FRINTN  D23, D27
    FRINTZ  H17, H31
    FRINTX  H19, H19
    FRINTZ  S5, S17
    FRINTM  H29, H7
    FRINTZ  S16, S29
    FRINTA  D10, D11
    FRINTZ  S4, S21
    FRINTP  H11, H4
    FRINTP  D31, D11
    FRINTI  D27, D19
    FRINTI  H20, H27
    FRINTA  D29, D5
    FRINTZ  S30, S29
    FRINTA  H29, H20
    FRINTI  S7, S31
    FRINTA  D5, D23
    FRINTP  H20, H16
    FRINTN  S17, S5
    FRINTX  S28, S30
    FRINTN  H30, H7
    FRINTN  S27, S27
    FRINTN  S16, S30
    FRINTZ  D31, D17
    FRINTP  S25, S29
    FRINTN  H23, H13
    FRINTX  H11, H20
    FRINTX  H13, H27
    FRINTN  D4, D13
    FRINTM  H19, H31
    FRINTA  S31, S4
    FRINTP  H4, H25
    FRINTN  S5, S28
    FRINTX  S21, S4
    FRINTZ  D20, D19
    FRINTX  S4, S20
    FRINTM  H19, H23
    FRINTX  D27, D16
    FRINTA  H29, H21
    FRINTM  H7, H31
    FRINTP  S13, S19
    FRINTA  D31, D11
    FRINTX  S20, S4
    FRINTP  S30, S5
    FRINTA  D21, D20
    FRINTZ  S5, S21
    FRINTI  D23, D27
    FRINTI  S11, S7
    FRINTI  D27, D11
    FRINTI  S20, S13
    FRINTN  S28, S30
    FRINTN  H21, H20
    FRINTM  D17, D29
    FRINTM  H25, H28
    FRINTN  H29, H23
    FRINTI  H19, H21
    FRINTI  H23, H31
    FRINTZ  H8, H5
    FRINTN  H7, H17
    FRINTM  S17, S7
    FRINTZ  S4, S23
    FRINTM  S11, S29
    FRINTZ  D7, D8
    FRINTP  D21, D17
    FRINTN  S17, S25
    FRINTX  H31, H7
    FRINTX  S8, S27
    FRINTP  H28, H11
    FRINTA  S8, S19
    FRINTA  D23, D21
    FRINTM  H20, H31
    FRINTN  H21, H16
    FRINTI  D27, D17
    FRINTI  H19, H25
    FRINTA  D7, D20
    FRINTZ  S16, S19
    FRINTX  H17, H4
    FRINTP  H29, H27
    FRINTX  H4, H28
    FRINTP  D5, D8
    FRINTN  S11, S23
    FRINTN  S31, S4
    FRINTP  H4, H21
    FRINTP  H8, H4
    FRINTX  D20, D5
    FRINTI  D27, D17
    FRINTN  H4, H20
    FRINTP  S5, S4
    FRINTI  S25, S7
    FRINTP  D17, D16
    FRINTZ  S23, S8
    FRINTZ  S7, S14
    FRINTZ  S16, S27
    FRINTX  H28, H23
    FRINTP  D20, D25
    FRINTI  S19, S31
    FRINTA  S31, S11
    FRINTX  H25, H20
    FRINTZ  D27, D17
    FRINTX  S23, S5
    FRINTA  D4, D28
    FRINTA  D14, D31
    FRINTI  H8, H27
    FRINTX  S20, S23
    FRINTN  S11, S20
    FRINTZ  S20, S8
    FRINTZ  D5, D14
    FRINTX  S21, S4
    FRINTX  D4, D25
    FRINTI  H8, H19
    FRINTI  H17, H7
    FRINTN  H23, H14
    FRINTP  S19, S21
    FRINTN  S27, S19
    FRINTZ  H19, H8
    FRINTZ  S25, S4
    FRINTM  D31, D25
    FRINTP  H14, H23
    FRINTN  S26, S17
    FRINTA  D8, D27
    FRINTZ  S25, S20
    FRINTA  D28, D16
    FRINTP  D20, D25
    FRINTI  D17, D20
    FRINTP  D20, D19
    FRINTZ  S4, S20
    FRINTI  D21, D31
    FRINTP  H25, H8
    FRINTA  S23, S17
    FRINTN  D20, D21
    FRINTZ  D8, D11
    FRINTZ  D27, D28
    FRINTP  D31, D26
    FRINTM  D26, D27
    FRINTP  S28, S14
    FRINTN  S7, S28
    FRINTN  H17, H5
    FRINTI  D27, D17
    FRINTI  H16, H31
    FRINTI  D19, D2
    FRINTX  D11, D31
    FRINTI  D21, D27
    FRINTA  H28, H20
    FRINTN  S31, S23
    FRINTZ  D14, D25
    FRINTA  S5, S7
    FRINTZ  D17, D4
    FRINTN  S2, S14
    FRINTP  S19, S8
    FRINTZ  D8, D5
    FRINTA  S23, S11
    FRINTN  H25, H23
    FRINTM  D23, D28
    FRINTI  H4, H17
    FRINTZ  H17, H4
    FRINTM  S14, S19
    FRINTA  H20, H16
    FRINTI  S28, S21
    FRINTI  S19, S31
    FRINTM  H4, H8
    FRINTX  S31, S4
    FRINTN  H21, H17
    FRINTI  S16, S14
    FRINTI  S4, S28
    FRINTM  D11, D31
    FRINTP  H7, H21
    FRINTM  S8, S23
    FRINTN  H5, H8
    FRINTP  H8, H11
    FRINTZ  H17, H4
    FRINTZ  D11, D7
    FRINTZ  S21, S5
    FRINTM  S14, S21
    FRINTM  D23, D16
    FRINTN  S28, S14
    FRINTA  S4, S20
    FRINTM  S7, S17
    FRINTX  H31, H19
    FRINTN  D5, D8
    FRINTM  D14, D25
    FRINTA  D16, D7
    FRINTZ  D17, D4
    FRINTM  H7, H31
    FRINTP  S21, S19
    FRINTM  S12, S5
    FRINTI  H8, H21
    FRINTM  H31, H14
    FRINTZ  H20, H28
    FRINTM  D14, D16
    FRINTZ  S16, S8
    SUBS  X25, X25, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_6
    MOVZ  X12, #0x8469, LSL #0
    MOVK  X12, #0x6de0, LSL #16
    MOVK  X12, #0xc7b6, LSL #32
    MOVK  X12, #0xbfb6, LSL #48
    SUB  X4, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xee03, LSL #0
    MOVK  X12, #0xaf08, LSL #16
    MOVK  X12, #0xb615, LSL #32
    MOVK  X12, #0x21c7, LSL #48
    SUB  X4, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x69e6, LSL #0
    MOVK  X12, #0xe29c, LSL #16
    MOVK  X12, #0x8500, LSL #32
    MOVK  X12, #0x99b1, LSL #48
    SUB  X4, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x686e, LSL #0
    MOVK  X12, #0xc931, LSL #16
    MOVK  X12, #0x93d5, LSL #32
    MOVK  X12, #0xf236, LSL #48
    SUB  X4, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x2748, LSL #0
    MOVK  X12, #0xc1e, LSL #16
    MOVK  X12, #0x8c64, LSL #32
    MOVK  X12, #0x241d, LSL #48
    SUB  X4, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xb324, LSL #0
    MOVK  X12, #0xcf80, LSL #16
    MOVK  X12, #0xbe86, LSL #32
    MOVK  X12, #0x1eb4, LSL #48
    SUB  X4, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xd1b2, LSL #0
    MOVK  X12, #0xe731, LSL #16
    MOVK  X12, #0x1d5c, LSL #32
    MOVK  X12, #0x402d, LSL #48
    SUB  X4, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x64e9, LSL #0
    MOVK  X12, #0x809, LSL #16
    MOVK  X12, #0xb0f4, LSL #32
    MOVK  X12, #0xe218, LSL #48
    SUB  X4, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x8b0a, LSL #0
    MOVK  X12, #0x3711, LSL #16
    MOVK  X12, #0x12e7, LSL #32
    MOVK  X12, #0xf73d, LSL #48
    SUB  X4, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x3cbf, LSL #0
    MOVK  X12, #0xd069, LSL #16
    MOVK  X12, #0xdaa0, LSL #32
    MOVK  X12, #0x7ee, LSL #48
    SUB  X4, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xc8be, LSL #0
    MOVK  X12, #0x450b, LSL #16
    MOVK  X12, #0x97c, LSL #32
    MOVK  X12, #0x5151, LSL #48
    SUB  X4, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x6f15, LSL #0
    MOVK  X12, #0x1b75, LSL #16
    MOVK  X12, #0x67e5, LSL #32
    MOVK  X12, #0x8e95, LSL #48
    SUB  X4, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xa81, LSL #0
    MOVK  X12, #0xfe03, LSL #16
    MOVK  X12, #0xdb11, LSL #32
    MOVK  X12, #0x6a4, LSL #48
    SUB  X4, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x4b45, LSL #0
    MOVK  X12, #0xd39e, LSL #16
    MOVK  X12, #0xf4f, LSL #32
    MOVK  X12, #0xef61, LSL #48
    SUB  X4, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xf015, LSL #0
    MOVK  X12, #0x43b4, LSL #16
    MOVK  X12, #0x6f47, LSL #32
    MOVK  X12, #0x5c36, LSL #48
    SUB  X4, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xaf26, LSL #0
    MOVK  X12, #0xef7f, LSL #16
    MOVK  X12, #0x93d3, LSL #32
    MOVK  X12, #0x751c, LSL #48
    SUB  X4, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x22d0, LSL #0
    MOVK  X12, #0x25b8, LSL #16
    MOVK  X12, #0xa16e, LSL #32
    MOVK  X12, #0x377a, LSL #48
    SUB  X4, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x8e90, LSL #0
    MOVK  X12, #0xefa2, LSL #16
    MOVK  X12, #0xb075, LSL #32
    MOVK  X12, #0x5139, LSL #48
    SUB  X4, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xc755, LSL #0
    MOVK  X12, #0xb6db, LSL #16
    MOVK  X12, #0x61c8, LSL #32
    MOVK  X12, #0xdde3, LSL #48
    SUB  X4, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xf359, LSL #0
    MOVK  X12, #0x65fa, LSL #16
    MOVK  X12, #0x8ada, LSL #32
    MOVK  X12, #0x9851, LSL #48
    SUB  X4, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x10, LSL #0
    MRS  X4, FPSR
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x8e90, LSL #0
    MOVK  X12, #0xefa2, LSL #16
    MOVK  X12, #0xb075, LSL #32
    MOVK  X12, #0x5139, LSL #48
    FMOV  X4, V0.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x97b2, LSL #0
    MOVK  X12, #0xe5ea, LSL #16
    MOVK  X12, #0x27f0, LSL #32
    MOVK  X12, #0x137e, LSL #48
    FMOV  X4, D0
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xf359, LSL #0
    MOVK  X12, #0x65fa, LSL #16
    MOVK  X12, #0x8ada, LSL #32
    MOVK  X12, #0x9851, LSL #48
    FMOV  X4, V1.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xc755, LSL #0
    MOVK  X12, #0xb6db, LSL #16
    MOVK  X12, #0x61c8, LSL #32
    MOVK  X12, #0xdde3, LSL #48
    FMOV  X4, D1
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D2
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xd1b2, LSL #0
    MOVK  X12, #0xe731, LSL #16
    MOVK  X12, #0x1d5c, LSL #32
    MOVK  X12, #0x402d, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x97b2, LSL #0
    MOVK  X12, #0xe5ea, LSL #16
    MOVK  X12, #0x27f0, LSL #32
    MOVK  X12, #0x137e, LSL #48
    FMOV  X4, D3
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D4
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D5
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x97b2, LSL #0
    MOVK  X12, #0xe5ea, LSL #16
    MOVK  X12, #0x27f0, LSL #32
    MOVK  X12, #0x137e, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x22d0, LSL #0
    MOVK  X12, #0x25b8, LSL #16
    MOVK  X12, #0xa16e, LSL #32
    MOVK  X12, #0x377a, LSL #48
    FMOV  X4, D6
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D7
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D8
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D9
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D10
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D11
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V12.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D12
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V13.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D13
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D14
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x6f15, LSL #0
    MOVK  X12, #0x1b75, LSL #16
    MOVK  X12, #0x67e5, LSL #32
    MOVK  X12, #0x8e95, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x97b2, LSL #0
    MOVK  X12, #0xe5ea, LSL #16
    MOVK  X12, #0x27f0, LSL #32
    MOVK  X12, #0x137e, LSL #48
    FMOV  X4, D15
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D16
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D17
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x4c1b, LSL #0
    MOVK  X12, #0x4789, LSL #16
    MOVK  X12, #0x9869, LSL #32
    MOVK  X12, #0xd75e, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xa81, LSL #0
    MOVK  X12, #0xfe03, LSL #16
    MOVK  X12, #0xdb11, LSL #32
    MOVK  X12, #0x6a4, LSL #48
    FMOV  X4, D18
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D19
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V20.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D20
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D21
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xee03, LSL #0
    MOVK  X12, #0xaf08, LSL #16
    MOVK  X12, #0xb615, LSL #32
    MOVK  X12, #0x21c7, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xf359, LSL #0
    MOVK  X12, #0x65fa, LSL #16
    MOVK  X12, #0x8ada, LSL #32
    MOVK  X12, #0x9851, LSL #48
    FMOV  X4, D22
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D23
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xc8be, LSL #0
    MOVK  X12, #0x450b, LSL #16
    MOVK  X12, #0x97c, LSL #32
    MOVK  X12, #0x5151, LSL #48
    FMOV  X4, V24.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0xc8be, LSL #0
    MOVK  X12, #0x450b, LSL #16
    MOVK  X12, #0x97c, LSL #32
    MOVK  X12, #0x5151, LSL #48
    FMOV  X4, D24
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D25
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D26
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D27
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V28.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D28
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D29
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D30
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X4, D31
    SUB  X14, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X16
    FMOV  V0.D[1], X29
    FMOV  D1, X11
    FMOV  V1.D[1], X21
    FMOV  D2, X17
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X22
    FMOV  D4, X19
    FMOV  V4.D[1], X25
    FMOV  D5, X24
    FMOV  V5.D[1], X18
    FMOV  D6, X10
    FMOV  V6.D[1], X11
    FMOV  D7, X3
    FMOV  V7.D[1], X19
    FMOV  D8, X24
    FMOV  V8.D[1], X11
    FMOV  D9, X27
    FMOV  V9.D[1], X28
    FMOV  D10, X27
    FMOV  V10.D[1], X28
    FMOV  D11, X3
    FMOV  V11.D[1], X6
    FMOV  D12, X6
    FMOV  V12.D[1], X11
    FMOV  D13, X29
    FMOV  V13.D[1], X12
    FMOV  D14, X3
    FMOV  V14.D[1], X24
    FMOV  D15, X11
    FMOV  V15.D[1], X28
    FMOV  D16, X6
    FMOV  V16.D[1], X17
    FMOV  D17, X21
    FMOV  V17.D[1], X10
    FMOV  D18, X25
    FMOV  V18.D[1], X7
    FMOV  D19, X6
    FMOV  V19.D[1], X16
    FMOV  D20, X25
    FMOV  V20.D[1], X13
    FMOV  D21, X27
    FMOV  V21.D[1], X22
    FMOV  D22, X25
    FMOV  V22.D[1], X4
    FMOV  D23, X25
    FMOV  V23.D[1], X6
    FMOV  D24, X10
    FMOV  V24.D[1], X24
    FMOV  D25, X18
    FMOV  V25.D[1], X17
    FMOV  D26, X29
    FMOV  V26.D[1], X27
    FMOV  D27, X14
    FMOV  V27.D[1], X2
    FMOV  D28, X6
    FMOV  V28.D[1], X13
    FMOV  D29, X12
    FMOV  V29.D[1], X21
    FMOV  D30, X28
    FMOV  V30.D[1], X7
    FMOV  D31, X16
    FMOV  V31.D[1], X27
    MOVZ  X15, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_7:
    FRINTM  D11, D27
    FRINTI  H14, H29
    FRINTI  H21, H26
    FRINTA  H28, H31
    FRINTX  H22, H24
    FRINTA  S23, S30
    FRINTM  H4, H20
    FRINTA  D9, D22
    FRINTA  D18, D9
    FRINTI  D22, D28
    FRINTI  S16, S14
    FRINTA  S8, S16
    FRINTA  S21, S11
    FRINTI  H23, H21
    FRINTA  D12, D18
    FRINTZ  H20, H25
    FRINTM  H21, H23
    FRINTX  S25, S4
    FRINTX  S16, S12
    FRINTI  S4, S3
    FRINTP  H4, H9
    FRINTZ  H9, H16
    FRINTX  S5, S20
    FRINTN  D18, D25
    FRINTN  D14, D4
    FRINTP  H4, H22
    FRINTM  D30, D18
    FRINTI  H3, H21
    FRINTA  S18, S14
    FRINTA  H25, H30
    FRINTX  D11, D9
    FRINTZ  S16, S5
    FRINTA  H12, H11
    FRINTM  S23, S12
    FRINTP  S22, S8
    FRINTN  S12, S25
    FRINTA  H20, H12
    FRINTX  H8, H23
    FRINTA  H28, H16
    FRINTZ  H14, H8
    FRINTP  D5, D18
    FRINTI  H25, H1
    FRINTZ  D12, D26
    FRINTM  D8, D4
    FRINTM  S18, S25
    FRINTN  D21, D20
    FRINTM  S23, S3
    FRINTM  H3, H28
    FRINTM  H1, H8
    FRINTN  S16, S14
    FRINTN  D11, D22
    FRINTA  D28, D3
    FRINTZ  D14, D12
    FRINTA  D3, D5
    FRINTX  S26, S3
    FRINTA  H3, H18
    FRINTM  S12, S14
    FRINTN  D18, D1
    FRINTZ  S22, S11
    FRINTI  S4, S17
    FRINTZ  H25, H16
    FRINTA  D16, D22
    FRINTM  S5, S26
    FRINTZ  D17, D28
    FRINTP  H8, H18
    FRINTP  H18, H23
    FRINTM  S28, S21
    FRINTN  S20, S18
    FRINTN  S18, S25
    FRINTP  D22, D18
    FRINTM  D26, D4
    FRINTN  S4, S3
    FRINTP  D1, D26
    FRINTP  S21, S16
    FRINTX  D23, D8
    FRINTA  H14, H22
    FRINTP  D25, D1
    FRINTX  H18, H23
    FRINTX  S3, S21
    FRINTP  H22, H14
    FRINTZ  D1, D18
    FRINTM  S18, S5
    FRINTA  H23, H18
    FRINTM  S26, S12
    FRINTN  H5, H3
    FRINTM  S16, S4
    FRINTI  S4, S17
    FRINTM  H18, H23
    FRINTM  H21, H25
    FRINTX  S23, S22
    FRINTN  H25, H23
    FRINTA  H23, H25
    FRINTP  H8, H26
    FRINTI  D12, D1
    FRINTA  H17, H12
    FRINTA  S3, S18
    FRINTI  D22, D20
    FRINTP  S26, S17
    FRINTN  S14, S5
    FRINTZ  H17, H3
    FRINTZ  H25, H16
    FRINTZ  D1, D22
    FRINTP  S22, S1
    FRINTP  H16, H23
    FRINTM  H20, H16
    FRINTA  D16, D26
    FRINTZ  H8, H17
    FRINTA  H29, H4
    FRINTX  D26, D14
    FRINTI  D18, D26
    FRINTP  D14, D22
    FRINTN  D1, D29
    FRINTM  H26, H21
    FRINTN  S11, S25
    FRINTZ  D30, D16
    FRINTZ  D3, D8
    FRINTX  S17, S18
    FRINTN  S16, S17
    FRINTI  D25, D26
    FRINTN  H5, H1
    FRINTX  S1, S20
    FRINTN  H26, H14
    FRINTA  D18, D26
    FRINTI  D29, D11
    FRINTP  D17, D29
    FRINTP  H26, H18
    FRINTN  H14, H1
    FRINTP  D22, D14
    FRINTM  S14, S25
    FRINTN  D29, D16
    FRINTM  H11, H17
    FRINTX  S8, S26
    FRINTZ  H4, H8
    FRINTZ  S18, S20
    FRINTI  H20, H4
    FRINTI  D1, D22
    FRINTZ  H25, H5
    FRINTM  S8, S14
    FRINTA  H16, H20
    FRINTP  H21, H29
    FRINTM  H14, H21
    FRINTM  S29, S1
    FRINTN  S17, S11
    FRINTM  S26, S29
    FRINTX  H20, H17
    FRINTA  D11, D25
    FRINTX  S4, S8
    FRINTX  H29, H14
    FRINTA  D22, D11
    FRINTM  S5, S16
    FRINTN  H21, H29
    FRINTX  S1, S18
    FRINTX  D17, D1
    FRINTA  H1, H21
    FRINTA  D29, D26
    FRINTN  D21, D20
    FRINTA  S18, S17
    FRINTZ  H17, H18
    FRINTI  H11, H1
    FRINTP  S25, S5
    FRINTI  D26, D21
    FRINTZ  D18, D17
    FRINTZ  D16, D22
    FRINTA  D14, D29
    FRINTN  S22, S16
    FRINTX  D20, D4
    FRINTM  S29, S11
    FRINTI  D5, D29
    FRINTN  H21, H26
    FRINTN  S8, S22
    FRINTA  S1, S4
    FRINTA  H17, H20
    FRINTP  H20, H18
    FRINTA  D22, D25
    FRINTN  D26, D17
    FRINTM  H16, H25
    FRINTM  D18, D1
    FRINTX  D29, D20
    FRINTN  S11, S22
    FRINTZ  S22, S14
    FRINTX  S20, S22
    FRINTI  S4, S20
    FRINTN  H1, H26
    FRINTX  H25, H11
    FRINTP  D26, D4
    FRINTA  S14, S1
    FRINTM  S1, S8
    FRINTA  S4, S16
    FRINTN  S11, S4
    FRINTX  S16, S11
    FRINTM  D20, D5
    FRINTZ  S4, S21
    FRINTP  D22, D4
    FRINTN  H17, H26
    FRINTZ  S3, S20
    FRINTA  D24, D1
    FRINTX  D8, D25
    FRINTX  D4, D22
    FRINTP  D5, D24
    FRINTM  S21, S5
    SUBS  X15, X15, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_7
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x10, LSL #0
    MRS  X12, FPSR
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D0
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D1
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D2
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D3
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D4
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D5
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D6
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D7
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D8
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D9
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D10
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D11
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D12
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D13
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D14
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D15
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D16
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D17
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D18
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D19
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D20
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D21
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D22
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D23
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D24
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D25
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D26
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D27
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D28
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D29
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D30
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X12, D31
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X3
    FMOV  V2.D[1], X12
    FMOV  D3, X4
    FMOV  V3.D[1], X29
    FMOV  D4, X22
    FMOV  V4.D[1], X17
    FMOV  D5, X7
    FMOV  V5.D[1], X28
    FMOV  D6, X16
    FMOV  V6.D[1], X25
    FMOV  D7, X14
    FMOV  V7.D[1], X7
    FMOV  D8, X25
    FMOV  V8.D[1], X28
    FMOV  D9, X6
    FMOV  V9.D[1], X16
    FMOV  D10, X3
    FMOV  V10.D[1], X2
    FMOV  D11, X16
    FMOV  V11.D[1], X27
    FMOV  D12, X29
    FMOV  V12.D[1], X25
    FMOV  D13, X16
    FMOV  V13.D[1], X27
    FMOV  D14, X18
    FMOV  V14.D[1], X11
    FMOV  D15, X24
    FMOV  V15.D[1], X15
    FMOV  D16, X17
    FMOV  V16.D[1], X17
    FMOV  D17, X27
    FMOV  V17.D[1], X15
    FMOV  D18, X19
    FMOV  V18.D[1], X16
    FMOV  D19, X15
    FMOV  V19.D[1], X15
    FMOV  D20, X24
    FMOV  V20.D[1], X17
    FMOV  D21, X29
    FMOV  V21.D[1], X27
    FMOV  D22, X3
    FMOV  V22.D[1], X13
    FMOV  D23, X16
    FMOV  V23.D[1], X4
    FMOV  D24, X24
    FMOV  V24.D[1], X17
    FMOV  D25, X21
    FMOV  V25.D[1], X11
    FMOV  D26, X21
    FMOV  V26.D[1], X12
    FMOV  D27, X5
    FMOV  V27.D[1], X21
    FMOV  D28, X17
    FMOV  V28.D[1], X13
    FMOV  D29, X12
    FMOV  V29.D[1], X9
    FMOV  D30, X25
    FMOV  V30.D[1], X3
    FMOV  D31, X18
    FMOV  V31.D[1], X2
    MOVZ  X29, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_8:
    FRINTI  D9, D27
    FRINTZ  H0, H25
    FRINTM  D30, D28
    FRINTA  D15, D26
    FRINTX  D12, D30
    FRINTZ  S13, S0
    FRINTZ  D28, D29
    FRINTA  H7, H15
    FRINTX  H27, H9
    FRINTI  H31, H31
    FRINTZ  H18, H12
    FRINTN  H16, H18
    FRINTA  D7, D13
    FRINTA  D12, D27
    FRINTZ  D12, D12
    FRINTX  H3, H21
    FRINTN  D8, D31
    FRINTP  S29, S7
    FRINTI  H27, H28
    FRINTP  D17, D16
    FRINTN  D0, D17
    FRINTX  D11, D16
    FRINTM  S30, S1
    FRINTZ  S21, S0
    FRINTM  H15, H30
    FRINTZ  H31, H12
    FRINTA  S17, S3
    FRINTP  H13, H17
    FRINTZ  H29, H31
    FRINTM  D13, D11
    FRINTA  D28, D5
    FRINTI  D5, D29
    FRINTM  H1, H5
    FRINTA  H30, H27
    FRINTI  H12, H1
    FRINTM  S0, S8
    FRINTI  H18, H0
    FRINTA  D16, D15
    FRINTN  H8, H9
    FRINTN  H15, H16
    FRINTZ  D27, D21
    FRINTN  D17, D15
    FRINTA  S7, S18
    FRINTM  H9, H7
    FRINTI  D15, D8
    FRINTN  S16, S13
    FRINTI  D0, D13
    FRINTP  D5, D17
    FRINTM  H1, H30
    FRINTN  D18, D5
    FRINTN  S21, S12
    FRINTX  H12, H1
    FRINTN  S1, S12
    FRINTZ  D31, D1
    FRINTN  D7, D15
    FRINTN  S13, S0
    FRINTX  H12, H21
    FRINTM  H17, H7
    FRINTX  H8, H31
    FRINTI  H5, H9
    FRINTM  D1, D5
    FRINTA  H29, H16
    FRINTN  D16, D29
    FRINTN  S30, S1
    FRINTN  D31, D13
    FRINTP  H29, H31
    FRINTP  D31, D18
    FRINTX  D0, D16
    FRINTI  D21, D12
    FRINTA  H15, H8
    FRINTP  D9, D30
    FRINTX  H16, H0
    FRINTA  S11, S17
    FRINTN  S18, S31
    FRINTM  D30, D29
    FRINTP  D8, D21
    FRINTN  H17, H9
    FRINTX  H26, H8
    FRINTP  S1, S15
    FRINTP  D15, D16
    FRINTM  H8, H11
    FRINTA  D12, D26
    FRINTX  D29, D18
    FRINTM  D0, D15
    FRINTM  H7, H8
    FRINTI  S31, S12
    FRINTP  S15, S17
    FRINTZ  S17, S0
    FRINTI  D0, D17
    FRINTX  H18, H0
    FRINTZ  D16, D1
    FRINTA  D21, D16
    FRINTZ  S11, S29
    FRINTZ  D1, D30
    FRINTP  H29, H1
    FRINTX  D30, D29
    FRINTI  H12, H31
    FRINTI  D26, D12
    FRINTP  H17, H15
    FRINTM  S31, S17
    FRINTN  D9, D11
    FRINTZ  D1, D18
    FRINTM  S17, S30
    FRINTM  S8, S1
    FRINTP  D15, D8
    FRINTA  H29, H9
    FRINTM  D18, D17
    FRINTA  S27, S21
    FRINTI  D11, D31
    FRINTP  D9, D26
    FRINTP  D26, D15
    FRINTZ  S30, S26
    FRINTA  H12, H30
    FRINTX  H15, H12
    FRINTI  D12, D18
    FRINTA  S17, S12
    FRINTI  H12, H17
    FRINTN  D26, D17
    FRINTA  D30, D27
    FRINTX  D21, D9
    FRINTA  D17, D12
    FRINTZ  S8, S24
    FRINTA  S31, S15
    FRINTX  D24, D21
    FRINTX  S1, S24
    FRINTP  S18, S26
    FRINTZ  D9, D1
    FRINTN  H26, H18
    FRINTX  D27, D30
    FRINTA  H15, H31
    FRINTN  H1, H17
    FRINTI  D21, D27
    FRINTZ  D12, D8
    FRINTA  H18, H12
    FRINTP  S24, S18
    FRINTN  D30, D24
    FRINTZ  D12, D21
    FRINTN  D27, D9
    FRINTP  S11, S1
    FRINTZ  S1, S26
    FRINTX  H18, H15
    FRINTI  H24, H18
    FRINTN  S17, S24
    FRINTI  S21, S12
    FRINTN  S26, S30
    FRINTA  S15, S2
    FRINTX  D8, D26
    FRINTX  S18, S16
    FRINTA  S31, S18
    FRINTP  H31, H11
    FRINTP  D9, D8
    FRINTN  S8, S17
    FRINTM  D16, D15
    FRINTM  H15, H21
    FRINTA  S17, S15
    FRINTM  D30, D1
    FRINTA  S2, S1
    FRINTP  D26, D2
    FRINTM  H21, H26
    FRINTI  H24, H21
    FRINTZ  H13, H30
    FRINTZ  S15, S31
    FRINTZ  H11, H24
    FRINTA  D12, D11
    FRINTX  H2, H12
    FRINTN  D30, D17
    FRINTP  S17, S8
    FRINTX  D1, D27
    FRINTN  S23, S13
    FRINTM  D26, D9
    FRINTP  D21, D2
    FRINTP  S2, S21
    FRINTA  S31, S12
    FRINTZ  H24, H30
    FRINTZ  H13, H1
    FRINTZ  H30, H17
    FRINTN  D21, D15
    FRINTX  S15, S2
    FRINTI  S18, S15
    FRINTZ  D2, D23
    FRINTZ  H15, H30
    FRINTA  H17, H2
    FRINTX  S23, S24
    FRINTN  D9, D13
    FRINTP  D13, D31
    FRINTA  S12, S14
    FRINTP  D1, D21
    FRINTP  H24, H18
    FRINTI  D27, D15
    FRINTX  D30, D9
    FRINTI  H9, H30
    FRINTM  H11, H1
    FRINTA  S18, S27
    FRINTP  H8, H26
    FRINTI  H2, H13
    FRINTA  H31, H23
    FRINTP  H21, H24
    FRINTI  S13, S17
    FRINTX  D17, D18
    FRINTA  D27, D12
    SUBS  X29, X29, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_8
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x10, LSL #0
    MRS  X21, FPSR
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D0
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D1
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V2.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D2
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D3
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, D4
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D5
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, D6
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D7
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D8
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D9
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, D10
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D11
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    FMOV  X21, D12
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D13
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, D14
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D15
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D16
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D17
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D18
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, D19
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, V20.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, D20
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D21
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, V22.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, D22
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D23
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D24
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, V25.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    FMOV  X21, D25
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D26
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D27
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D28
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D29
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D30
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X21, D31
    SUB  X13, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x4024, LSL #0
    MOVK  X2, #0xa2b6, LSL #16
    MOVK  X2, #0xf408, LSL #32
    MOVK  X2, #0xdf9c, LSL #48
    MOVZ  X3, #0xd7c7, LSL #0
    MOVK  X3, #0x6ea1, LSL #16
    MOVK  X3, #0x7e5d, LSL #32
    MOVK  X3, #0x46c4, LSL #48
    MOVZ  X4, #0xba3c, LSL #0
    MOVK  X4, #0x79e8, LSL #16
    MOVK  X4, #0x1ee6, LSL #32
    MOVK  X4, #0x4279, LSL #48
    MOVZ  X5, #0xbd78, LSL #0
    MOVK  X5, #0x45e6, LSL #16
    MOVK  X5, #0xf1c6, LSL #32
    MOVK  X5, #0x5e87, LSL #48
    MOVZ  X6, #0x749c, LSL #0
    MOVK  X6, #0x33b9, LSL #16
    MOVK  X6, #0x2470, LSL #32
    MOVK  X6, #0x4d1c, LSL #48
    MOVZ  X7, #0x1448, LSL #0
    MOVK  X7, #0x9212, LSL #16
    MOVK  X7, #0x88b0, LSL #32
    MOVK  X7, #0xbd7d, LSL #48
    MOVZ  X9, #0x4a75, LSL #0
    MOVK  X9, #0x5b6b, LSL #16
    MOVK  X9, #0x4260, LSL #32
    MOVK  X9, #0x4729, LSL #48
    MOVZ  X10, #0x5131, LSL #0
    MOVK  X10, #0x5352, LSL #16
    MOVK  X10, #0x9256, LSL #32
    MOVK  X10, #0x6b23, LSL #48
    MOVZ  X11, #0x1651, LSL #0
    MOVK  X11, #0x2e1b, LSL #16
    MOVK  X11, #0xc20a, LSL #32
    MOVK  X11, #0xfc34, LSL #48
    MOVZ  X12, #0x7c04, LSL #0
    MOVK  X12, #0xe539, LSL #16
    MOVK  X12, #0x766d, LSL #32
    MOVK  X12, #0xaeac, LSL #48
    MOVZ  X13, #0x7aa0, LSL #0
    MOVK  X13, #0x26bb, LSL #16
    MOVK  X13, #0x8191, LSL #32
    MOVK  X13, #0x8957, LSL #48
    MOVZ  X14, #0x8cbc, LSL #0
    MOVK  X14, #0x5cd0, LSL #16
    MOVK  X14, #0xb5c1, LSL #32
    MOVK  X14, #0xed1f, LSL #48
    MOVZ  X15, #0x66ff, LSL #0
    MOVK  X15, #0xcb17, LSL #16
    MOVK  X15, #0xb118, LSL #32
    MOVK  X15, #0xd265, LSL #48
    MOVZ  X16, #0xf5ef, LSL #0
    MOVK  X16, #0x79f4, LSL #16
    MOVK  X16, #0x48c4, LSL #32
    MOVK  X16, #0x9f03, LSL #48
    MOVZ  X17, #0x4d17, LSL #0
    MOVK  X17, #0x982d, LSL #16
    MOVK  X17, #0x1fa3, LSL #32
    MOVK  X17, #0x7aa8, LSL #48
    MOVZ  X18, #0x9af8, LSL #0
    MOVK  X18, #0x840a, LSL #16
    MOVK  X18, #0x720e, LSL #32
    MOVK  X18, #0xde9d, LSL #48
    MOVZ  X19, #0x5c1b, LSL #0
    MOVK  X19, #0x7175, LSL #16
    MOVK  X19, #0xdf57, LSL #32
    MOVK  X19, #0xc17b, LSL #48
    MOVZ  X21, #0xd40a, LSL #0
    MOVK  X21, #0x60b6, LSL #16
    MOVK  X21, #0xa48e, LSL #32
    MOVK  X21, #0xf140, LSL #48
    MOVZ  X22, #0x48e7, LSL #0
    MOVK  X22, #0xdc0b, LSL #16
    MOVK  X22, #0xe149, LSL #32
    MOVK  X22, #0xcce2, LSL #48
    MOVZ  X24, #0xa4d8, LSL #0
    MOVK  X24, #0x18dd, LSL #16
    MOVK  X24, #0x93d2, LSL #32
    MOVK  X24, #0x2cdb, LSL #48
    MOVZ  X25, #0xc6fc, LSL #0
    MOVK  X25, #0x68f, LSL #16
    MOVK  X25, #0xad65, LSL #32
    MOVK  X25, #0xc316, LSL #48
    MOVZ  X27, #0xdad2, LSL #0
    MOVK  X27, #0xd05c, LSL #16
    MOVK  X27, #0x9a63, LSL #32
    MOVK  X27, #0xf53, LSL #48
    MOVZ  X28, #0x656f, LSL #0
    MOVK  X28, #0x6f98, LSL #16
    MOVK  X28, #0xeabd, LSL #32
    MOVK  X28, #0x9d50, LSL #48
    MOVZ  X29, #0x26c1, LSL #0
    MOVK  X29, #0x7529, LSL #16
    MOVK  X29, #0x7438, LSL #32
    MOVK  X29, #0x2500, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X22
    FMOV  D2, X29
    FMOV  V2.D[1], X4
    FMOV  D3, X17
    FMOV  V3.D[1], X3
    FMOV  D4, X6
    FMOV  V4.D[1], X7
    FMOV  D5, X4
    FMOV  V5.D[1], X13
    FMOV  D6, X28
    FMOV  V6.D[1], X6
    FMOV  D7, X27
    FMOV  V7.D[1], X16
    FMOV  D8, X9
    FMOV  V8.D[1], X15
    FMOV  D9, X19
    FMOV  V9.D[1], X25
    FMOV  D10, X13
    FMOV  V10.D[1], X3
    FMOV  D11, X29
    FMOV  V11.D[1], X25
    FMOV  D12, X21
    FMOV  V12.D[1], X16
    FMOV  D13, X16
    FMOV  V13.D[1], X5
    FMOV  D14, X22
    FMOV  V14.D[1], X27
    FMOV  D15, X3
    FMOV  V15.D[1], X17
    FMOV  D16, X3
    FMOV  V16.D[1], X5
    FMOV  D17, X4
    FMOV  V17.D[1], X5
    FMOV  D18, X10
    FMOV  V18.D[1], X3
    FMOV  D19, X13
    FMOV  V19.D[1], X2
    FMOV  D20, X15
    FMOV  V20.D[1], X15
    FMOV  D21, X14
    FMOV  V21.D[1], X16
    FMOV  D22, X28
    FMOV  V22.D[1], X10
    FMOV  D23, X16
    FMOV  V23.D[1], X17
    FMOV  D24, X13
    FMOV  V24.D[1], X22
    FMOV  D25, X16
    FMOV  V25.D[1], X4
    FMOV  D26, X22
    FMOV  V26.D[1], X13
    FMOV  D27, X9
    FMOV  V27.D[1], X17
    FMOV  D28, X24
    FMOV  V28.D[1], X7
    FMOV  D29, X16
    FMOV  V29.D[1], X11
    FMOV  D30, X15
    FMOV  V30.D[1], X16
    FMOV  D31, X16
    FMOV  V31.D[1], X10
    MOVZ  X16, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_9:
    FRINTA  D16, D24
    FRINTZ  H8, H28
    FRINTA  S5, S16
    FRINTX  H3, H26
    FRINTA  D13, D22
    FRINTZ  H20, H8
    FRINTA  H14, H20
    FRINTI  S31, S5
    FRINTM  D15, D27
    FRINTZ  H12, H25
    FRINTA  H9, H13
    FRINTA  D19, D9
    FRINTX  D6, D14
    FRINTX  S12, S12
    FRINTM  S8, S30
    FRINTZ  S8, S19
    FRINTI  H25, H8
    FRINTI  H30, H31
    FRINTM  H7, H3
    FRINTZ  S14, S7
    FRINTA  S26, S14
    FRINTZ  H24, H15
    FRINTI  D8, D12
    FRINTI  H16, H8
    FRINTA  H22, H25
    FRINTM  H13, H16
    FRINTZ  D28, D13
    FRINTI  D14, D22
    FRINTM  H7, H6
    FRINTM  S19, S14
    FRINTZ  H22, H30
    FRINTM  D31, D24
    FRINTA  D24, D19
    FRINTM  H16, H7
    FRINTX  H3, H31
    FRINTX  H19, H24
    FRINTZ  H30, H16
    FRINTX  S5, S28
    FRINTZ  S9, S3
    FRINTZ  S3, S19
    FRINTZ  S6, S22
    FRINTA  S15, S30
    FRINTP  H13, H3
    FRINTP  S30, S5
    FRINTZ  D14, D30
    FRINTI  S12, S14
    FRINTX  D31, D13
    FRINTP  H7, H31
    FRINTI  H24, H9
    FRINTZ  S19, S24
    FRINTP  H16, H19
    FRINTN  D22, D16
    FRINTP  S16, S12
    FRINTX  H5, H15
    FRINTX  D28, D7
    FRINTA  H19, H16
    FRINTP  D24, D22
    FRINTA  S13, S5
    FRINTZ  D3, D6
    FRINTI  S30, S28
    FRINTM  H7, H24
    FRINTM  S22, S19
    FRINTI  D24, D7
    FRINTA  S28, S27
    FRINTP  S5, S24
    FRINTI  D16, D30
    FRINTX  D14, D16
    FRINTM  S30, S13
    FRINTN  D13, D14
    FRINTX  S9, S30
    FRINTI  H24, H9
    FRINTM  S7, S24
    FRINTN  S16, S7
    FRINTM  D6, D13
    FRINTM  D14, D3
    FRINTP  D27, D22
    FRINTA  D3, D27
    FRINTZ  H30, H14
    FRINTN  D14, D16
    FRINTZ  H27, H30
    FRINTZ  H13, H3
    FRINTZ  D24, D6
    FRINTZ  D16, D5
    FRINTP  H7, H9
    FRINTI  D30, D14
    FRINTN  H22, H27
    FRINTI  S9, S13
    FRINTA  S14, S9
    FRINTZ  D5, D24
    FRINTX  D3, D16
    FRINTX  D9, D5
    FRINTX  D5, D22
    FRINTM  S6, S3
    FRINTN  H3, H28
    FRINTN  S24, S7
    FRINTZ  D13, D27
    FRINTX  S23, S3
    FRINTM  S3, S5
    FRINTA  D11, D9
    FRINTI  D27, D13
    FRINTM  D16, D27
    FRINTI  S27, S24
    FRINTP  D13, D11
    FRINTN  H11, H3
    FRINTM  D9, D14
    FRINTZ  H7, H11
    FRINTA  S28, S6
    FRINTM  S6, S7
    FRINTP  S22, S13
    FRINTN  H7, H16
    FRINTI  H5, H23
    FRINTM  D24, D5
    FRINTX  H16, H30
    FRINTM  H3, H27
    FRINTI  H27, H24
    FRINTN  D14, D9
    FRINTI  S9, S3
    FRINTA  D3, D27
    FRINTA  H11, H9
    FRINTX  S13, S28
    FRINTA  D24, D3
    FRINTX  D9, D11
    FRINTP  H3, H24
    FRINTZ  S16, S9
    FRINTI  H28, H3
    FRINTZ  H5, H7
    FRINTX  H27, H14
    FRINTZ  D24, D13
    FRINTN  S3, S5
    FRINTX  S8, S3
    FRINTA  H9, H8
    FRINTZ  H23, H16
    FRINTA  D21, D23
    FRINTZ  H5, H6
    FRINTZ  S11, S24
    FRINTZ  S3, S28
    FRINTM  H28, H3
    FRINTI  S13, S28
    FRINTM  H6, H5
    FRINTZ  S23, S21
    FRINTX  H16, H23
    FRINTN  H3, H11
    FRINTP  D23, D13
    FRINTN  H8, H6
    FRINTI  H14, H9
    FRINTN  S7, S8
    FRINTX  H24, H16
    FRINTM  D21, D3
    FRINTP  S8, S24
    FRINTA  D11, D14
    FRINTA  H5, H21
    FRINTM  S28, S5
    FRINTP  S24, S28
    FRINTI  S28, S27
    FRINTX  S13, S28
    FRINTP  H28, H13
    FRINTN  D5, D28
    FRINTZ  D6, D26
    FRINTA  H26, H24
    FRINTZ  H13, H8
    FRINTI  D8, D6
    FRINTN  S24, S13
    FRINTA  S29, S8
    FRINTP  H28, H7
    FRINTN  H6, H23
    FRINTM  H27, H29
    FRINTP  D21, D14
    FRINTP  H3, H6
    FRINTI  H14, H5
    FRINTA  D23, D24
    FRINTP  S29, S14
    FRINTM  D7, D3
    FRINTZ  D6, D21
    FRINTN  H21, H23
    FRINTP  D3, D11
    FRINTZ  D5, D25
    FRINTA  S11, S29
    FRINTI  H8, H7
    FRINTZ  D13, D21
    FRINTM  H14, H11
    FRINTN  S11, S14
    FRINTZ  D14, D11
    FRINTA  D23, D13
    FRINTM  D13, D3
    FRINTA  D24, D26
    FRINTI  S11, S28
    FRINTA  H28, H11
    FRINTI  D21, D6
    FRINTA  H3, H13
    FRINTX  S7, S27
    FRINTM  H29, H3
    FRINTX  D3, D14
    FRINTA  H6, H7
    FRINTP  S7, S6
    FRINTX  H6, H24
    FRINTN  S25, S3
    FRINTI  H0, H23
    FRINTI  H14, H21
    FRINTX  H11, H28
    FRINTP  S13, S25
    SUBS  X16, X16, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_9
    MOVZ  X5, #0x4024, LSL #0
    MOVK  X5, #0xa2b6, LSL #16
    MOVK  X5, #0xf408, LSL #32
    MOVK  X5, #0xdf9c, LSL #48
    SUB  X29, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xd7c7, LSL #0
    MOVK  X5, #0x6ea1, LSL #16
    MOVK  X5, #0x7e5d, LSL #32
    MOVK  X5, #0x46c4, LSL #48
    SUB  X29, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xba3c, LSL #0
    MOVK  X5, #0x79e8, LSL #16
    MOVK  X5, #0x1ee6, LSL #32
    MOVK  X5, #0x4279, LSL #48
    SUB  X29, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x749c, LSL #0
    MOVK  X5, #0x33b9, LSL #16
    MOVK  X5, #0x2470, LSL #32
    MOVK  X5, #0x4d1c, LSL #48
    SUB  X29, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x1448, LSL #0
    MOVK  X5, #0x9212, LSL #16
    MOVK  X5, #0x88b0, LSL #32
    MOVK  X5, #0xbd7d, LSL #48
    SUB  X29, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x4a75, LSL #0
    MOVK  X5, #0x5b6b, LSL #16
    MOVK  X5, #0x4260, LSL #32
    MOVK  X5, #0x4729, LSL #48
    SUB  X29, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x5131, LSL #0
    MOVK  X5, #0x5352, LSL #16
    MOVK  X5, #0x9256, LSL #32
    MOVK  X5, #0x6b23, LSL #48
    SUB  X29, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x1651, LSL #0
    MOVK  X5, #0x2e1b, LSL #16
    MOVK  X5, #0xc20a, LSL #32
    MOVK  X5, #0xfc34, LSL #48
    SUB  X29, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x7c04, LSL #0
    MOVK  X5, #0xe539, LSL #16
    MOVK  X5, #0x766d, LSL #32
    MOVK  X5, #0xaeac, LSL #48
    SUB  X29, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x7aa0, LSL #0
    MOVK  X5, #0x26bb, LSL #16
    MOVK  X5, #0x8191, LSL #32
    MOVK  X5, #0x8957, LSL #48
    SUB  X29, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x8cbc, LSL #0
    MOVK  X5, #0x5cd0, LSL #16
    MOVK  X5, #0xb5c1, LSL #32
    MOVK  X5, #0xed1f, LSL #48
    SUB  X29, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x66ff, LSL #0
    MOVK  X5, #0xcb17, LSL #16
    MOVK  X5, #0xb118, LSL #32
    MOVK  X5, #0xd265, LSL #48
    SUB  X29, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x4d17, LSL #0
    MOVK  X5, #0x982d, LSL #16
    MOVK  X5, #0x1fa3, LSL #32
    MOVK  X5, #0x7aa8, LSL #48
    SUB  X29, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x9af8, LSL #0
    MOVK  X5, #0x840a, LSL #16
    MOVK  X5, #0x720e, LSL #32
    MOVK  X5, #0xde9d, LSL #48
    SUB  X29, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x5c1b, LSL #0
    MOVK  X5, #0x7175, LSL #16
    MOVK  X5, #0xdf57, LSL #32
    MOVK  X5, #0xc17b, LSL #48
    SUB  X29, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x48e7, LSL #0
    MOVK  X5, #0xdc0b, LSL #16
    MOVK  X5, #0xe149, LSL #32
    MOVK  X5, #0xcce2, LSL #48
    SUB  X29, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xa4d8, LSL #0
    MOVK  X5, #0x18dd, LSL #16
    MOVK  X5, #0x93d2, LSL #32
    MOVK  X5, #0x2cdb, LSL #48
    SUB  X29, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xc6fc, LSL #0
    MOVK  X5, #0x68f, LSL #16
    MOVK  X5, #0xad65, LSL #32
    MOVK  X5, #0xc316, LSL #48
    SUB  X29, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xdad2, LSL #0
    MOVK  X5, #0xd05c, LSL #16
    MOVK  X5, #0x9a63, LSL #32
    MOVK  X5, #0xf53, LSL #48
    SUB  X29, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x656f, LSL #0
    MOVK  X5, #0x6f98, LSL #16
    MOVK  X5, #0xeabd, LSL #32
    MOVK  X5, #0x9d50, LSL #48
    SUB  X29, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x10, LSL #0
    MRS  X29, FPSR
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D0
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x48e7, LSL #0
    MOVK  X5, #0xdc0b, LSL #16
    MOVK  X5, #0xe149, LSL #32
    MOVK  X5, #0xcce2, LSL #48
    FMOV  X29, V1.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xdad2, LSL #0
    MOVK  X5, #0xd05c, LSL #16
    MOVK  X5, #0x9a63, LSL #32
    MOVK  X5, #0xf53, LSL #48
    FMOV  X29, D1
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xba3c, LSL #0
    MOVK  X5, #0x79e8, LSL #16
    MOVK  X5, #0x1ee6, LSL #32
    MOVK  X5, #0x4279, LSL #48
    FMOV  X29, V2.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x26c1, LSL #0
    MOVK  X5, #0x7529, LSL #16
    MOVK  X5, #0x7438, LSL #32
    MOVK  X5, #0x2500, LSL #48
    FMOV  X29, D2
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D3
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x1448, LSL #0
    MOVK  X5, #0x9212, LSL #16
    MOVK  X5, #0x88b0, LSL #32
    MOVK  X5, #0xbd7d, LSL #48
    FMOV  X29, V4.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x749c, LSL #0
    MOVK  X5, #0x33b9, LSL #16
    MOVK  X5, #0x2470, LSL #32
    MOVK  X5, #0x4d1c, LSL #48
    FMOV  X29, D4
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D5
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D6
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D7
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D8
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D9
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xd7c7, LSL #0
    MOVK  X5, #0x6ea1, LSL #16
    MOVK  X5, #0x7e5d, LSL #32
    MOVK  X5, #0x46c4, LSL #48
    FMOV  X29, V10.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x7aa0, LSL #0
    MOVK  X5, #0x26bb, LSL #16
    MOVK  X5, #0x8191, LSL #32
    MOVK  X5, #0x8957, LSL #48
    FMOV  X29, D10
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D11
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D12
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D13
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D14
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D15
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D16
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xbd78, LSL #0
    MOVK  X5, #0x45e6, LSL #16
    MOVK  X5, #0xf1c6, LSL #32
    MOVK  X5, #0x5e87, LSL #48
    FMOV  X29, V17.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xba3c, LSL #0
    MOVK  X5, #0x79e8, LSL #16
    MOVK  X5, #0x1ee6, LSL #32
    MOVK  X5, #0x4279, LSL #48
    FMOV  X29, D17
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xd7c7, LSL #0
    MOVK  X5, #0x6ea1, LSL #16
    MOVK  X5, #0x7e5d, LSL #32
    MOVK  X5, #0x46c4, LSL #48
    FMOV  X29, V18.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x5131, LSL #0
    MOVK  X5, #0x5352, LSL #16
    MOVK  X5, #0x9256, LSL #32
    MOVK  X5, #0x6b23, LSL #48
    FMOV  X29, D18
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D19
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D20
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D21
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D22
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D23
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D24
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D25
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D26
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D27
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D28
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D29
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D30
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X29, D31
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X6
    FMOV  V0.D[1], X17
    FMOV  D1, X15
    FMOV  V1.D[1], X10
    FMOV  D2, X18
    FMOV  V2.D[1], X25
    FMOV  D3, X13
    FMOV  V3.D[1], X27
    FMOV  D4, X16
    FMOV  V4.D[1], X12
    FMOV  D5, X14
    FMOV  V5.D[1], X9
    FMOV  D6, X29
    FMOV  V6.D[1], X19
    FMOV  D7, X24
    FMOV  V7.D[1], X28
    FMOV  D8, X6
    FMOV  V8.D[1], X22
    FMOV  D9, X5
    FMOV  V9.D[1], X9
    FMOV  D10, X11
    FMOV  V10.D[1], X7
    FMOV  D11, X3
    FMOV  V11.D[1], X4
    FMOV  D12, X3
    FMOV  V12.D[1], X12
    FMOV  D13, X5
    FMOV  V13.D[1], X24
    FMOV  D14, X9
    FMOV  V14.D[1], X9
    FMOV  D15, X10
    FMOV  V15.D[1], X7
    FMOV  D16, X25
    FMOV  V16.D[1], X2
    FMOV  D17, X25
    FMOV  V17.D[1], X2
    FMOV  D18, X10
    FMOV  V18.D[1], X13
    FMOV  D19, X16
    FMOV  V19.D[1], X19
    FMOV  D20, X16
    FMOV  V20.D[1], X27
    FMOV  D21, X3
    FMOV  V21.D[1], X22
    FMOV  D22, X11
    FMOV  V22.D[1], X7
    FMOV  D23, X5
    FMOV  V23.D[1], X4
    FMOV  D24, X15
    FMOV  V24.D[1], X17
    FMOV  D25, X14
    FMOV  V25.D[1], X14
    FMOV  D26, X29
    FMOV  V26.D[1], X27
    FMOV  D27, X7
    FMOV  V27.D[1], X4
    FMOV  D28, X2
    FMOV  V28.D[1], X28
    FMOV  D29, X18
    FMOV  V29.D[1], X5
    FMOV  D30, X22
    FMOV  V30.D[1], X25
    FMOV  D31, X15
    FMOV  V31.D[1], X21
    MOVZ  X17, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_10:
    FRINTZ  H15, H27
    FRINTX  D0, D29
    FRINTA  D29, D30
    FRINTN  D31, D31
    FRINTM  D5, D15
    FRINTN  H2, H0
    FRINTA  D12, D29
    FRINTP  H20, H12
    FRINTN  S24, S28
    FRINTA  H17, H2
    FRINTP  S29, S20
    FRINTP  D16, D31
    FRINTZ  S7, S5
    FRINTA  H0, H24
    FRINTX  D14, D17
    FRINTP  D8, D26
    FRINTP  H10, H7
    FRINTI  D30, D10
    FRINTA  S2, S8
    FRINTM  H19, H14
    FRINTI  H30, H30
    FRINTI  H10, H29
    FRINTX  H13, H10
    FRINTA  D27, D13
    FRINTX  H31, H30
    FRINTX  D30, D31
    FRINTX  H15, H3
    FRINTA  D24, D19
    FRINTN  D17, D0
    FRINTA  S19, S27
    FRINTM  S8, S15
    FRINTI  S28, S2
    FRINTX  D3, D19
    FRINTA  H13, H30
    FRINTA  H30, H13
    FRINTZ  H31, H28
    FRINTA  H14, H24
    FRINTZ  D15, D17
    FRINTI  D19, D8
    FRINTN  H0, H16
    FRINTX  S16, S0
    FRINTZ  D5, D19
    FRINTZ  D2, D5
    FRINTI  H0, H16
    FRINTI  H19, H6
    FRINTX  H13, H3
    FRINTI  D8, D30
    FRINTM  H5, H2
    FRINTN  S17, S0
    FRINTA  S3, S14
    FRINTA  H28, H31
    FRINTP  H14, H15
    FRINTZ  D2, D14
    FRINTM  H15, H2
    FRINTI  D30, D28
    FRINTI  D27, D19
    FRINTM  H19, H5
    FRINTA  D14, D27
    FRINTI  H6, H23
    FRINTN  S23, S14
    FRINTP  S14, S8
    FRINTZ  H27, H30
    FRINTI  D5, D27
    FRINTZ  D28, D15
    FRINTN  D8, D6
    FRINTZ  S16, S13
    FRINTP  H6, H5
    FRINTA  H31, H19
    FRINTP  S2, S3
    FRINTP  S13, S23
    FRINTP  S27, S28
    FRINTZ  H15, H17
    FRINTX  S3, S14
    FRINTA  S14, S2
    FRINTP  H30, H31
    FRINTX  S17, S30
    FRINTI  S5, S14
    FRINTP  D23, D8
    FRINTZ  D28, D5
    FRINTI  S5, S3
    FRINTX  H3, H13
    FRINTZ  S2, S27
    FRINTA  H14, H17
    FRINTN  H8, H23
    FRINTM  S31, S8
    FRINTN  H30, H28
    FRINTN  D0, D31
    FRINTA  S13, S5
    FRINTA  S28, S13
    FRINTI  S5, S2
    FRINTP  D19, D3
    FRINTX  H3, H14
    FRINTA  D31, D3
    FRINTP  S13, S31
    FRINTP  H2, H19
    FRINTM  H19, H2
    FRINTP  S17, S0
    FRINTP  S13, S5
    FRINTZ  D27, D13
    FRINTI  S2, S27
    FRINTM  S0, S15
    FRINTZ  D27, D30
    FRINTX  D5, D28
    FRINTN  S13, S0
    FRINTM  D28, D13
    FRINTP  H30, H2
    FRINTZ  D15, D27
    FRINTZ  H31, H5
    FRINTN  D14, D31
    FRINTX  D0, D15
    FRINTX  S23, S0
    FRINTA  D13, D23
    FRINTZ  S15, S28
    FRINTA  H0, H17
    FRINTN  D31, D13
    FRINTI  D2, D30
    FRINTN  S13, S0
    FRINTX  S28, S2
    FRINTX  H23, H15
    FRINTX  H5, H23
    FRINTA  S15, S13
    FRINTA  H17, H15
    FRINTA  D23, D14
    FRINTM  H27, H5
    FRINTP  S5, S31
    FRINTX  D30, D19
    FRINTM  S2, S30
    FRINTX  D19, D2
    FRINTX  D30, D19
    FRINTP  S31, S5
    FRINTN  H0, H17
    FRINTI  D13, D18
    FRINTN  S14, S13
    FRINTX  S15, S23
    FRINTI  D23, D27
    FRINTZ  S17, S30
    FRINTX  H27, H17
    FRINTA  H2, H15
    FRINTA  H19, H0
    FRINTM  D0, D31
    FRINTI  S18, S14
    FRINTZ  S14, S28
    FRINTA  S2, S18
    FRINTM  S27, S7
    FRINTP  S30, S23
    FRINTN  H18, H30
    FRINTA  S7, S27
    FRINTA  D30, D19
    FRINTI  S28, S0
    FRINTP  D27, D28
    FRINTM  H23, H7
    FRINTM  D13, D14
    FRINTA  H5, H20
    FRINTI  D20, D5
    FRINTI  D7, D2
    FRINTX  H2, H27
    FRINTX  S20, S20
    FRINTX  D19, D18
    FRINTI  D14, D13
    FRINTZ  H18, H14
    FRINTN  S0, S18
    FRINTA  D5, D23
    FRINTA  D15, D7
    FRINTN  H28, H20
    FRINTM  H31, H2
    FRINTN  D20, D19
    FRINTZ  S19, S0
    FRINTZ  S18, S30
    FRINTX  S23, S15
    FRINTA  D2, D5
    FRINTI  D14, D19
    FRINTI  D13, D14
    FRINTI  D29, D28
    FRINTA  H7, H29
    FRINTZ  D27, D0
    FRINTN  H30, H23
    FRINTZ  S23, S20
    FRINTP  H15, H23
    FRINTP  S20, S13
    FRINTI  D23, D30
    FRINTN  H19, H24
    FRINTP  S29, S31
    FRINTA  S5, S29
    FRINTP  H8, H27
    FRINTM  S12, S20
    FRINTP  D7, D15
    FRINTP  S15, S8
    FRINTM  S14, S20
    FRINTP  H20, H5
    FRINTM  D29, D23
    FRINTP  S13, S29
    FRINTP  H27, H7
    FRINTA  H5, H13
    FRINTM  D8, D12
    FRINTN  D29, D19
    FRINTX  H7, H29
    FRINTX  H30, H2
    FRINTA  D19, D30
    FRINTX  S2, S27
    FRINTI  H24, H19
    SUBS  X17, X17, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_10
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x10, LSL #0
    MRS  X10, FPSR
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D0
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D1
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D2
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D3
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D4
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D5
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D6
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D7
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D8
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D9
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D10
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D11
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D12
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D13
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D14
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D15
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D16
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D17
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D18
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D19
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D20
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D21
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D22
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D23
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D24
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D25
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D26
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D27
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D28
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D29
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D30
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, D31
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatFloatPointRoundToInteger_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X21
    FMOV  D2, X25
    FMOV  V2.D[1], X27
    FMOV  D3, X21
    FMOV  V3.D[1], X29
    FMOV  D4, X28
    FMOV  V4.D[1], X15
    FMOV  D5, X14
    FMOV  V5.D[1], X14
    FMOV  D6, X10
    FMOV  V6.D[1], X13
    FMOV  D7, X19
    FMOV  V7.D[1], X2
    FMOV  D8, X27
    FMOV  V8.D[1], X2
    FMOV  D9, X24
    FMOV  V9.D[1], X17
    FMOV  D10, X3
    FMOV  V10.D[1], X2
    FMOV  D11, X11
    FMOV  V11.D[1], X27
    FMOV  D12, X2
    FMOV  V12.D[1], X13
    FMOV  D13, X4
    FMOV  V13.D[1], X21
    FMOV  D14, X27
    FMOV  V14.D[1], X5
    FMOV  D15, X24
    FMOV  V15.D[1], X4
    FMOV  D16, X13
    FMOV  V16.D[1], X25
    FMOV  D17, X24
    FMOV  V17.D[1], X22
    FMOV  D18, X12
    FMOV  V18.D[1], X21
    FMOV  D19, X27
    FMOV  V19.D[1], X9
    FMOV  D20, X18
    FMOV  V20.D[1], X6
    FMOV  D21, X22
    FMOV  V21.D[1], X10
    FMOV  D22, X14
    FMOV  V22.D[1], X18
    FMOV  D23, X6
    FMOV  V23.D[1], X25
    FMOV  D24, X10
    FMOV  V24.D[1], X5
    FMOV  D25, X14
    FMOV  V25.D[1], X5
    FMOV  D26, X13
    FMOV  V26.D[1], X24
    FMOV  D27, X27
    FMOV  V27.D[1], X9
    FMOV  D28, X28
    FMOV  V28.D[1], X27
    FMOV  D29, X6
    FMOV  V29.D[1], X13
    FMOV  D30, X21
    FMOV  V30.D[1], X17
    FMOV  D31, X7
    FMOV  V31.D[1], X13
    MOVZ  X29, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_11:
    FRINTX  S2, S30
    FRINTX  S7, S21
    FRINTM  D3, D28
    FRINTA  S29, S27
    FRINTI  D24, D22
    FRINTI  H19, H20
    FRINTI  D20, D31
    FRINTM  D14, D26
    FRINTN  S25, S20
    FRINTI  S20, S19
    FRINTZ  D30, D23
    FRINTZ  D26, D30
    FRINTZ  D28, D2
    FRINTI  D2, D28
    FRINTI  H18, H25
    FRINTX  H26, H26
    FRINTM  H22, H29
    FRINTZ  D19, D22
    FRINTP  S1, S18
    FRINTX  S29, S2
    FRINTM  H19, H24
    FRINTX  S24, S7
    FRINTM  S19, S14
    FRINTI  H0, H20
    FRINTI  S25, S26
    FRINTX  D23, D25
    FRINTN  H21, H1
    FRINTM  D6, D29
    FRINTA  H19, H21
    FRINTZ  S25, S24
    FRINTI  H1, H6
    FRINTZ  H28, H1
    FRINTI  S6, S3
    FRINTP  H20, H25
    FRINTN  S22, S6
    FRINTM  S7, S0
    FRINTI  D18, D23
    FRINTX  H24, H28
    FRINTM  H28, H22
    FRINTN  H22, H19
    FRINTM  S21, S20
    FRINTI  S14, S21
    FRINTI  D3, D22
    FRINTI  H2, H14
    FRINTX  H19, H28
    FRINTZ  D26, D18
    FRINTP  D29, D26
    FRINTI  H23, H7
    FRINTZ  H26, H19
    FRINTX  D25, D28
    FRINTX  S30, S24
    FRINTP  D7, D3
    FRINTN  H0, H2
    FRINTZ  H3, H0
    FRINTX  S20, S23
    FRINTA  S24, S7
    FRINTA  S23, S30
    FRINTX  H7, H23
    FRINTI  D1, D7
    FRINTM  D18, D26
    FRINTP  H30, H29
    FRINTI  D28, D20
    FRINTI  S0, S3
    FRINTP  H6, H1
    FRINTZ  S23, S30
    FRINTM  S7, S25
    FRINTA  H26, H17
    FRINTP  D2, D26
    FRINTM  S19, S23
    FRINTN  S3, S25
    FRINTN  S17, S6
    FRINTA  D6, D28
    FRINTX  S29, S18
    FRINTM  D18, D24
    FRINTI  H25, H0
    FRINTM  D30, D29
    FRINTM  S29, S18
    FRINTM  S0, S19
    FRINTM  D19, D29
    FRINTA  D1, D2
    FRINTZ  D1, D19
    FRINTN  S29, S29
    FRINTI  S23, S25
    FRINTA  D2, D6
    FRINTP  D28, D7
    FRINTA  D25, D0
    FRINTA  H18, H3
    FRINTN  H3, H2
    FRINTM  H2, H30
    FRINTX  D26, D3
    FRINTZ  H19, H17
    FRINTI  S3, S19
    FRINTM  S30, S28
    FRINTA  S26, S3
    FRINTM  S28, S18
    FRINTZ  H18, H25
    FRINTX  H7, H28
    FRINTX  H28, H7
    FRINTP  H3, H18
    FRINTN  S25, S23
    FRINTN  D7, D2
    FRINTI  S23, S29
    FRINTX  H24, H25
    FRINTZ  H2, H24
    FRINTM  S6, S3
    FRINTP  S0, S28
    FRINTX  D19, D7
    FRINTA  S28, S6
    FRINTM  S17, S0
    FRINTZ  D24, D23
    FRINTP  D29, D1
    FRINTN  S25, S28
    FRINTM  S18, S19
    FRINTP  H3, H26
    FRINTM  H6, H2
    FRINTP  S0, S30
    FRINTA  H30, H0
    FRINTA  D28, D18
    FRINTZ  S30, S17
    FRINTN  D18, D12
    FRINTX  H0, H24
    FRINTP  D19, D0
    FRINTI  D0, D19
    FRINTM  H24, H0
    FRINTZ  D23, D6
    FRINTN  D12, D29
    FRINTM  S6, S24
    FRINTP  H26, H23
    FRINTN  S1, S4
    FRINTP  S2, S18
    FRINTX  H23, H3
    FRINTP  H0, H12
    FRINTP  D19, D1
    FRINTX  S4, S26
    FRINTX  S3, S23
    FRINTI  S17, S28
    FRINTI  D29, D3
    FRINTM  D24, D17
    FRINTP  H3, H19
    FRINTX  S19, S6
    FRINTI  D6, D2
    FRINTZ  S12, S29
    FRINTM  D26, D6
    FRINTI  S20, S4
    FRINTP  S29, S26
    FRINTZ  H18, H3
    FRINTN  D2, D12
    FRINTN  S26, S2
    FRINTN  H1, H0
    FRINTX  S6, S1
    FRINTN  D28, D29
    FRINTX  H29, H20
    FRINTN  S2, S28
    FRINTA  D20, D2
    FRINTZ  H23, H24
    FRINTP  S12, S18
    FRINTI  H18, H29
    FRINTZ  S29, S23
    FRINTA  S4, S21
    FRINTI  S28, S4
    FRINTX  D24, D28
    FRINTA  D28, D12
    FRINTI  S21, S24
    FRINTA  H0, H20
    FRINTN  S20, S18
    FRINTA  H17, H0
    FRINTI  D3, D6
    FRINTA  H1, H26
    FRINTN  D4, D28
    FRINTM  S28, S21
    FRINTP  S6, S4
    FRINTZ  S23, S3
    FRINTI  S12, S20
    FRINTZ  H4, H6
    FRINTX  S6, S29
    FRINTI  S29, S1
    FRINTX  S20, S23
    FRINTA  H3, H4
    FRINTP  D26, D2
    FRINTI  D24, D6
    FRINTN  D4, D29
    FRINTZ  S23, S26
    FRINTA  H1, H20
    FRINTN  H6, H17
    FRINTX  D0, D28
    FRINTZ  H21, H3
    FRINTZ  H2, H1
    FRINTN  H28, H23
    FRINTX  S1, S24
    FRINTP  S26, S4
    FRINTX  H4, H1
    FRINTP  H3, H26
    FRINTI  D24, D1
    FRINTP  H23, H24
    FRINTX  S24, S6
    FRINTI  S19, S2
    FRINTZ  S2, S0
    FRINTI  S20, S2
    FRINTA  H0, H21
    FRINTI  H26, H3
    SUBS  X29, X29, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_11
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x10, LSL #0
    MRS  X14, FPSR
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D1
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D3
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V5.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D5
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V8.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D8
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V9.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D9
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V10.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D10
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V11.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D11
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D12
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V13.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D13
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V15.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D15
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V16.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D16
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D19
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D20
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D22
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V27.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D27
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, V31.D[1]
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    FMOV  X14, D31
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x9fad, LSL #0
    MOVK  X2, #0x97a6, LSL #16
    MOVK  X2, #0x89fc, LSL #32
    MOVK  X2, #0xd379, LSL #48
    MOVZ  X3, #0xa8d6, LSL #0
    MOVK  X3, #0x3669, LSL #16
    MOVK  X3, #0xda8d, LSL #32
    MOVK  X3, #0x524c, LSL #48
    MOVZ  X4, #0x73fa, LSL #0
    MOVK  X4, #0x4b71, LSL #16
    MOVK  X4, #0xe56e, LSL #32
    MOVK  X4, #0x3363, LSL #48
    MOVZ  X5, #0xf83c, LSL #0
    MOVK  X5, #0xe8bf, LSL #16
    MOVK  X5, #0xe687, LSL #32
    MOVK  X5, #0xea18, LSL #48
    MOVZ  X6, #0xd414, LSL #0
    MOVK  X6, #0xa67b, LSL #16
    MOVK  X6, #0x9bc4, LSL #32
    MOVK  X6, #0x6abf, LSL #48
    MOVZ  X7, #0xeb3e, LSL #0
    MOVK  X7, #0xeddc, LSL #16
    MOVK  X7, #0x7767, LSL #32
    MOVK  X7, #0xf9cf, LSL #48
    MOVZ  X9, #0xf50e, LSL #0
    MOVK  X9, #0xaa68, LSL #16
    MOVK  X9, #0xbd1, LSL #32
    MOVK  X9, #0x5356, LSL #48
    MOVZ  X10, #0x9227, LSL #0
    MOVK  X10, #0xa09a, LSL #16
    MOVK  X10, #0x1de9, LSL #32
    MOVK  X10, #0x6096, LSL #48
    MOVZ  X11, #0xf823, LSL #0
    MOVK  X11, #0xb91f, LSL #16
    MOVK  X11, #0x5091, LSL #32
    MOVK  X11, #0x8c2, LSL #48
    MOVZ  X12, #0x108c, LSL #0
    MOVK  X12, #0xf18f, LSL #16
    MOVK  X12, #0xdae6, LSL #32
    MOVK  X12, #0x5fcf, LSL #48
    MOVZ  X13, #0x3294, LSL #0
    MOVK  X13, #0xb7f, LSL #16
    MOVK  X13, #0x67d, LSL #32
    MOVK  X13, #0x666d, LSL #48
    MOVZ  X14, #0xefa2, LSL #0
    MOVK  X14, #0xcbf3, LSL #16
    MOVK  X14, #0x17bc, LSL #32
    MOVK  X14, #0x6106, LSL #48
    MOVZ  X15, #0x653f, LSL #0
    MOVK  X15, #0xc809, LSL #16
    MOVK  X15, #0x5448, LSL #32
    MOVK  X15, #0x24dd, LSL #48
    MOVZ  X16, #0x2f1f, LSL #0
    MOVK  X16, #0x31e9, LSL #16
    MOVK  X16, #0x8cd4, LSL #32
    MOVK  X16, #0xe405, LSL #48
    MOVZ  X17, #0x64ad, LSL #0
    MOVK  X17, #0x6b68, LSL #16
    MOVK  X17, #0x63a6, LSL #32
    MOVK  X17, #0xf034, LSL #48
    MOVZ  X18, #0x1255, LSL #0
    MOVK  X18, #0x3465, LSL #16
    MOVK  X18, #0x9077, LSL #32
    MOVK  X18, #0x121d, LSL #48
    MOVZ  X19, #0x1c9e, LSL #0
    MOVK  X19, #0x88dd, LSL #16
    MOVK  X19, #0xc4ed, LSL #32
    MOVK  X19, #0x234e, LSL #48
    MOVZ  X21, #0xb56d, LSL #0
    MOVK  X21, #0x990e, LSL #16
    MOVK  X21, #0xa324, LSL #32
    MOVK  X21, #0xd35b, LSL #48
    MOVZ  X22, #0xb2c4, LSL #0
    MOVK  X22, #0x10e9, LSL #16
    MOVK  X22, #0xdfb3, LSL #32
    MOVK  X22, #0x8b62, LSL #48
    MOVZ  X24, #0xb3e9, LSL #0
    MOVK  X24, #0xb75c, LSL #16
    MOVK  X24, #0xbe72, LSL #32
    MOVK  X24, #0x96fc, LSL #48
    MOVZ  X25, #0x147e, LSL #0
    MOVK  X25, #0x14d6, LSL #16
    MOVK  X25, #0x4855, LSL #32
    MOVK  X25, #0xd96e, LSL #48
    MOVZ  X27, #0x7783, LSL #0
    MOVK  X27, #0x711, LSL #16
    MOVK  X27, #0xb150, LSL #32
    MOVK  X27, #0x465f, LSL #48
    MOVZ  X28, #0x94ad, LSL #0
    MOVK  X28, #0x997e, LSL #16
    MOVK  X28, #0xce18, LSL #32
    MOVK  X28, #0xac45, LSL #48
    MOVZ  X29, #0xe161, LSL #0
    MOVK  X29, #0xd4a6, LSL #16
    MOVK  X29, #0x7aec, LSL #32
    MOVK  X29, #0xa0a4, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X4
    FMOV  V2.D[1], X28
    FMOV  D3, X16
    FMOV  V3.D[1], X22
    FMOV  D4, X12
    FMOV  V4.D[1], X5
    FMOV  D5, X21
    FMOV  V5.D[1], X11
    FMOV  D6, X7
    FMOV  V6.D[1], X14
    FMOV  D7, X3
    FMOV  V7.D[1], X2
    FMOV  D8, X7
    FMOV  V8.D[1], X25
    FMOV  D9, X28
    FMOV  V9.D[1], X27
    FMOV  D10, X6
    FMOV  V10.D[1], X6
    FMOV  D11, X9
    FMOV  V11.D[1], X22
    FMOV  D12, X28
    FMOV  V12.D[1], X16
    FMOV  D13, X14
    FMOV  V13.D[1], X5
    FMOV  D14, X15
    FMOV  V14.D[1], X19
    FMOV  D15, X5
    FMOV  V15.D[1], X5
    FMOV  D16, X17
    FMOV  V16.D[1], X3
    FMOV  D17, X11
    FMOV  V17.D[1], X14
    FMOV  D18, X29
    FMOV  V18.D[1], X14
    FMOV  D19, X5
    FMOV  V19.D[1], X18
    FMOV  D20, X10
    FMOV  V20.D[1], X2
    FMOV  D21, X19
    FMOV  V21.D[1], X6
    FMOV  D22, X10
    FMOV  V22.D[1], X29
    FMOV  D23, X9
    FMOV  V23.D[1], X3
    FMOV  D24, X21
    FMOV  V24.D[1], X19
    FMOV  D25, X3
    FMOV  V25.D[1], X7
    FMOV  D26, X17
    FMOV  V26.D[1], X10
    FMOV  D27, X29
    FMOV  V27.D[1], X22
    FMOV  D28, X17
    FMOV  V28.D[1], X6
    FMOV  D29, X4
    FMOV  V29.D[1], X22
    FMOV  D30, X2
    FMOV  V30.D[1], X28
    FMOV  D31, X12
    FMOV  V31.D[1], X18
    MOVZ  X6, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_12:
    FRINTX  S26, S26
    FRINTA  D5, D24
    FRINTX  S30, S26
    FRINTI  S19, S5
    FRINTA  S12, S25
    FRINTN  D3, D23
    FRINTP  D4, D19
    FRINTN  H0, H27
    FRINTM  H23, H28
    FRINTA  H5, H23
    FRINTA  S25, S12
    FRINTI  D21, D3
    FRINTN  S8, S31
    FRINTP  H14, H30
    FRINTP  D1, D8
    FRINTZ  D26, D0
    FRINTX  D25, D1
    FRINTI  H8, H5
    FRINTN  S8, S4
    FRINTX  H13, H8
    FRINTI  D18, D29
    FRINTX  H24, H26
    FRINTZ  H30, H25
    FRINTZ  H27, H30
    FRINTX  S30, S14
    FRINTP  S1, S21
    FRINTM  D0, D13
    FRINTP  D21, D0
    FRINTP  H4, H21
    FRINTI  S25, S18
    FRINTA  S5, S24
    FRINTP  S31, S30
    FRINTP  S0, S31
    FRINTN  H30, H4
    FRINTN  H29, H30
    FRINTI  D13, D1
    FRINTM  D1, D27
    FRINTZ  D12, D5
    FRINTN  S31, S25
    FRINTN  H21, H5
    FRINTP  D18, D21
    FRINTP  D21, D9
    FRINTA  D24, D29
    FRINTX  D25, D13
    FRINTP  D8, D31
    FRINTX  H31, H25
    FRINTI  H13, H18
    FRINTA  D4, D1
    FRINTI  H5, H13
    FRINTI  S13, S31
    FRINTI  H9, H13
    FRINTM  H31, H12
    FRINTX  H29, H0
    FRINTN  D25, D4
    FRINTP  D13, D25
    FRINTZ  S0, S5
    FRINTP  D5, D31
    FRINTZ  S4, S8
    FRINTN  D8, D9
    FRINTA  S9, S5
    FRINTZ  D1, D8
    FRINTX  D31, D4
    FRINTN  D18, D1
    FRINTX  S25, S29
    FRINTZ  S29, S21
    FRINTN  D1, D29
    FRINTP  S27, S9
    FRINTA  D4, D27
    FRINTA  S5, S13
    FRINTX  H8, H25
    FRINTX  D12, D4
    FRINTI  S9, S18
    FRINTA  H21, H24
    FRINTP  S29, S5
    FRINTZ  H27, H8
    FRINTZ  D18, D0
    FRINTN  H25, H29
    FRINTP  D24, D31
    FRINTZ  S8, S24
    FRINTN  D29, D8
    FRINTZ  D13, D25
    FRINTN  S4, S9
    FRINTI  S25, S4
    FRINTA  H8, H18
    FRINTX  H5, H27
    FRINTM  H27, H8
    FRINTI  D0, D5
    FRINTM  D4, D12
    FRINTA  S13, S29
    FRINTI  S18, S0
    FRINTM  S8, S25
    FRINTM  H5, H18
    FRINTN  H31, H1
    FRINTA  H29, H27
    FRINTI  H1, H5
    FRINTZ  H24, H21
    FRINTX  D27, D12
    FRINTZ  H9, H4
    FRINTA  S5, S13
    FRINTI  D0, D1
    FRINTM  D1, D7
    FRINTM  H21, H1
    FRINTZ  H11, H15
    FRINTI  S12, S8
    FRINTZ  D1, D7
    FRINTX  H18, H29
    FRINTP  D29, D1
    FRINTZ  S4, S11
    FRINTI  D13, D4
    FRINTM  D25, D21
    FRINTP  H11, H29
    FRINTA  D15, D24
    FRINTI  S7, S11
    FRINTI  S11, S13
    FRINTA  H13, H15
    FRINTM  S11, S31
    FRINTM  S15, S7
    FRINTN  H8, H9
    FRINTN  H31, H25
    FRINTP  H25, H8
    FRINTP  D9, D18
    FRINTI  D17, D13
    FRINTZ  H1, H11
    FRINTA  D8, D15
    FRINTM  S7, S17
    FRINTN  D4, D7
    FRINTX  H7, H4
    FRINTZ  D15, D25
    FRINTX  D24, D5
    FRINTP  H8, H8
    FRINTM  H4, H12
    FRINTZ  D18, D4
    FRINTZ  D13, D1
    FRINTX  H5, H8
    FRINTI  S1, S18
    FRINTM  H12, H7
    FRINTZ  D25, D31
    FRINTA  D4, D15
    FRINTN  H15, H9
    FRINTX  S18, S5
    FRINTP  H7, H15
    FRINTP  D8, D4
    FRINTN  D17, D1
    FRINTZ  D9, D17
    FRINTP  S17, S24
    FRINTI  S31, S13
    FRINTZ  H24, H7
    FRINTP  D5, D9
    FRINTX  D9, D8
    FRINTZ  S13, S21
    FRINTI  D4, D13
    FRINTI  H7, H31
    FRINTP  D21, D4
    FRINTN  D8, D13
    FRINTM  H15, H17
    FRINTA  D4, D24
    FRINTZ  D31, D7
    FRINTM  H1, H4
    FRINTZ  H4, H15
    FRINTP  H17, H31
    FRINTA  S7, S17
    FRINTN  H24, H5
    FRINTP  D15, D7
    FRINTN  D7, D21
    FRINTX  S17, S15
    FRINTN  H13, H18
    FRINTX  D15, D9
    FRINTI  S18, S15
    FRINTA  D21, D20
    FRINTN  H5, H21
    FRINTZ  H15, H5
    FRINTM  S31, S24
    FRINTI  D24, D15
    FRINTA  S15, S4
    FRINTX  H4, H13
    FRINTX  D9, D17
    FRINTM  D13, D8
    FRINTN  S17, S7
    FRINTI  D7, D17
    FRINTZ  H8, H7
    FRINTM  H22, H15
    FRINTA  S15, S4
    FRINTZ  D5, D18
    FRINTN  S18, S5
    FRINTX  H4, H1
    FRINTM  D1, D4
    FRINTA  H4, H31
    FRINTX  S20, S4
    FRINTI  D17, D24
    FRINTN  H5, H13
    FRINTZ  D13, D18
    FRINTI  D31, D10
    FRINTM  H7, H15
    FRINTN  H10, H1
    FRINTM  S24, S8
    FRINTZ  S1, S24
    FRINTA  S24, S22
    FRINTI  S22, S20
    FRINTI  S20, S22
    FRINTI  S15, S7
    SUBS  X6, X6, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_12
    MOVZ  X15, #0x9fad, LSL #0
    MOVK  X15, #0x97a6, LSL #16
    MOVK  X15, #0x89fc, LSL #32
    MOVK  X15, #0xd379, LSL #48
    SUB  X29, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xa8d6, LSL #0
    MOVK  X15, #0x3669, LSL #16
    MOVK  X15, #0xda8d, LSL #32
    MOVK  X15, #0x524c, LSL #48
    SUB  X29, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x73fa, LSL #0
    MOVK  X15, #0x4b71, LSL #16
    MOVK  X15, #0xe56e, LSL #32
    MOVK  X15, #0x3363, LSL #48
    SUB  X29, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xf83c, LSL #0
    MOVK  X15, #0xe8bf, LSL #16
    MOVK  X15, #0xe687, LSL #32
    MOVK  X15, #0xea18, LSL #48
    SUB  X29, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xf50e, LSL #0
    MOVK  X15, #0xaa68, LSL #16
    MOVK  X15, #0xbd1, LSL #32
    MOVK  X15, #0x5356, LSL #48
    SUB  X29, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x9227, LSL #0
    MOVK  X15, #0xa09a, LSL #16
    MOVK  X15, #0x1de9, LSL #32
    MOVK  X15, #0x6096, LSL #48
    SUB  X29, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xf823, LSL #0
    MOVK  X15, #0xb91f, LSL #16
    MOVK  X15, #0x5091, LSL #32
    MOVK  X15, #0x8c2, LSL #48
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x108c, LSL #0
    MOVK  X15, #0xf18f, LSL #16
    MOVK  X15, #0xdae6, LSL #32
    MOVK  X15, #0x5fcf, LSL #48
    SUB  X29, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x3294, LSL #0
    MOVK  X15, #0xb7f, LSL #16
    MOVK  X15, #0x67d, LSL #32
    MOVK  X15, #0x666d, LSL #48
    SUB  X29, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xefa2, LSL #0
    MOVK  X15, #0xcbf3, LSL #16
    MOVK  X15, #0x17bc, LSL #32
    MOVK  X15, #0x6106, LSL #48
    SUB  X29, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x2f1f, LSL #0
    MOVK  X15, #0x31e9, LSL #16
    MOVK  X15, #0x8cd4, LSL #32
    MOVK  X15, #0xe405, LSL #48
    SUB  X29, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x64ad, LSL #0
    MOVK  X15, #0x6b68, LSL #16
    MOVK  X15, #0x63a6, LSL #32
    MOVK  X15, #0xf034, LSL #48
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x1255, LSL #0
    MOVK  X15, #0x3465, LSL #16
    MOVK  X15, #0x9077, LSL #32
    MOVK  X15, #0x121d, LSL #48
    SUB  X29, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x1c9e, LSL #0
    MOVK  X15, #0x88dd, LSL #16
    MOVK  X15, #0xc4ed, LSL #32
    MOVK  X15, #0x234e, LSL #48
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xb56d, LSL #0
    MOVK  X15, #0x990e, LSL #16
    MOVK  X15, #0xa324, LSL #32
    MOVK  X15, #0xd35b, LSL #48
    SUB  X29, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xb2c4, LSL #0
    MOVK  X15, #0x10e9, LSL #16
    MOVK  X15, #0xdfb3, LSL #32
    MOVK  X15, #0x8b62, LSL #48
    SUB  X29, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xb3e9, LSL #0
    MOVK  X15, #0xb75c, LSL #16
    MOVK  X15, #0xbe72, LSL #32
    MOVK  X15, #0x96fc, LSL #48
    SUB  X29, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x147e, LSL #0
    MOVK  X15, #0x14d6, LSL #16
    MOVK  X15, #0x4855, LSL #32
    MOVK  X15, #0xd96e, LSL #48
    SUB  X29, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x7783, LSL #0
    MOVK  X15, #0x711, LSL #16
    MOVK  X15, #0xb150, LSL #32
    MOVK  X15, #0x465f, LSL #48
    SUB  X29, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x94ad, LSL #0
    MOVK  X15, #0x997e, LSL #16
    MOVK  X15, #0xce18, LSL #32
    MOVK  X15, #0xac45, LSL #48
    SUB  X29, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x10, LSL #0
    MRS  X29, FPSR
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D0
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D1
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x94ad, LSL #0
    MOVK  X15, #0x997e, LSL #16
    MOVK  X15, #0xce18, LSL #32
    MOVK  X15, #0xac45, LSL #48
    FMOV  X29, V2.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x73fa, LSL #0
    MOVK  X15, #0x4b71, LSL #16
    MOVK  X15, #0xe56e, LSL #32
    MOVK  X15, #0x3363, LSL #48
    FMOV  X29, D2
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D3
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D4
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D5
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xefa2, LSL #0
    MOVK  X15, #0xcbf3, LSL #16
    MOVK  X15, #0x17bc, LSL #32
    MOVK  X15, #0x6106, LSL #48
    FMOV  X29, V6.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xeb3e, LSL #0
    MOVK  X15, #0xeddc, LSL #16
    MOVK  X15, #0x7767, LSL #32
    MOVK  X15, #0xf9cf, LSL #48
    FMOV  X29, D6
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D7
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D8
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D9
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D10
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D11
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D12
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D13
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D14
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D15
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xa8d6, LSL #0
    MOVK  X15, #0x3669, LSL #16
    MOVK  X15, #0xda8d, LSL #32
    MOVK  X15, #0x524c, LSL #48
    FMOV  X29, V16.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x64ad, LSL #0
    MOVK  X15, #0x6b68, LSL #16
    MOVK  X15, #0x63a6, LSL #32
    MOVK  X15, #0xf034, LSL #48
    FMOV  X29, D16
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D17
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D18
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D19
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D20
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D21
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D22
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x64ad, LSL #0
    FMOV  X29, D23
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D24
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D25
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D26
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D27
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0xd414, LSL #0
    MOVK  X15, #0xa67b, LSL #16
    MOVK  X15, #0x9bc4, LSL #32
    MOVK  X15, #0x6abf, LSL #48
    FMOV  X29, V28.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x64ad, LSL #0
    MOVK  X15, #0x6b68, LSL #16
    MOVK  X15, #0x63a6, LSL #32
    MOVK  X15, #0xf034, LSL #48
    FMOV  X29, D28
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D29
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D30
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X29, D31
    SUB  X7, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X14
    FMOV  V0.D[1], X7
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X17
    FMOV  V2.D[1], X12
    FMOV  D3, X5
    FMOV  V3.D[1], X10
    FMOV  D4, X15
    FMOV  V4.D[1], X16
    FMOV  D5, X29
    FMOV  V5.D[1], X18
    FMOV  D6, X19
    FMOV  V6.D[1], X13
    FMOV  D7, X28
    FMOV  V7.D[1], X25
    FMOV  D8, X25
    FMOV  V8.D[1], X7
    FMOV  D9, X14
    FMOV  V9.D[1], X21
    FMOV  D10, X11
    FMOV  V10.D[1], X15
    FMOV  D11, X21
    FMOV  V11.D[1], X4
    FMOV  D12, X22
    FMOV  V12.D[1], X16
    FMOV  D13, X9
    FMOV  V13.D[1], X25
    FMOV  D14, X14
    FMOV  V14.D[1], X6
    FMOV  D15, X19
    FMOV  V15.D[1], X21
    FMOV  D16, X27
    FMOV  V16.D[1], X16
    FMOV  D17, X2
    FMOV  V17.D[1], X5
    FMOV  D18, X12
    FMOV  V18.D[1], X14
    FMOV  D19, X19
    FMOV  V19.D[1], X15
    FMOV  D20, X29
    FMOV  V20.D[1], X4
    FMOV  D21, X25
    FMOV  V21.D[1], X9
    FMOV  D22, X24
    FMOV  V22.D[1], X11
    FMOV  D23, X12
    FMOV  V23.D[1], X21
    FMOV  D24, X9
    FMOV  V24.D[1], X19
    FMOV  D25, X10
    FMOV  V25.D[1], X18
    FMOV  D26, X29
    FMOV  V26.D[1], X4
    FMOV  D27, X11
    FMOV  V27.D[1], X25
    FMOV  D28, X18
    FMOV  V28.D[1], X17
    FMOV  D29, X4
    FMOV  V29.D[1], X14
    FMOV  D30, X2
    FMOV  V30.D[1], X16
    FMOV  D31, X25
    FMOV  V31.D[1], X3
    MOVZ  X7, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_13:
    FRINTM  S9, S25
    FRINTA  D31, D30
    FRINTA  S23, S24
    FRINTA  S6, S27
    FRINTI  H18, H23
    FRINTM  D25, D26
    FRINTZ  D30, D25
    FRINTA  H30, H21
    FRINTI  D25, D18
    FRINTX  D31, D22
    FRINTA  S12, S28
    FRINTI  D7, D9
    FRINTP  S27, S12
    FRINTA  H4, H30
    FRINTN  S29, S6
    FRINTI  D28, D31
    FRINTI  D24, D27
    FRINTN  H11, H23
    FRINTI  D15, D24
    FRINTA  H28, H28
    FRINTP  D10, D28
    FRINTP  H24, H15
    FRINTZ  H31, H11
    FRINTX  H13, H31
    FRINTI  S15, S4
    FRINTI  H12, H29
    FRINTM  S3, S7
    FRINTA  H4, H15
    FRINTX  S18, S11
    FRINTZ  S11, S12
    FRINTX  S22, S18
    FRINTN  H30, H10
    FRINTN  H10, H30
    FRINTZ  H27, H3
    FRINTA  S9, S25
    FRINTM  S7, S4
    FRINTP  D18, D13
    FRINTN  H12, H22
    FRINTX  S30, S9
    FRINTX  S6, S20
    FRINTI  D15, D7
    FRINTM  S25, S6
    FRINTZ  D6, D12
    FRINTP  S3, S30
    FRINTP  H12, H10
    FRINTI  H4, H24
    FRINTX  H29, H18
    FRINTI  S13, S27
    FRINTX  H7, H3
    FRINTN  S3, S14
    FRINTN  S9, S3
    FRINTM  D24, D9
    FRINTI  D3, D15
    FRINTX  D30, D11
    FRINTX  S20, S25
    FRINTM  S22, S6
    FRINTM  S27, S12
    FRINTA  S15, S30
    FRINTX  H10, H20
    FRINTM  D14, D4
    FRINTZ  D12, D24
    FRINTZ  H11, H22
    FRINTA  S11, S3
    FRINTA  H4, H27
    FRINTI  S24, S13
    FRINTA  S22, S12
    FRINTM  D30, D24
    FRINTA  D27, D10
    FRINTI  S3, S29
    FRINTP  S24, S15
    FRINTN  H6, H14
    FRINTP  S25, S6
    FRINTI  D29, D4
    FRINTI  D10, D30
    FRINTI  H6, H10
    FRINTI  S4, S24
    FRINTN  S15, S7
    FRINTZ  D13, D17
    FRINTA  S14, S2
    FRINTX  H20, H15
    FRINTI  S10, S4
    FRINTN  S30, S27
    FRINTN  H12, H30
    FRINTM  H15, H25
    FRINTA  D25, D3
    FRINTZ  S30, S10
    FRINTA  D30, D15
    FRINTX  H7, H13
    FRINTP  H10, H30
    FRINTA  D13, D6
    FRINTI  H17, H7
    FRINTI  D4, D20
    FRINTX  D3, D4
    FRINTA  S2, S25
    FRINTX  H15, H13
    FRINTX  H24, H10
    FRINTA  H6, H17
    FRINTN  S13, S3
    FRINTX  H27, H12
    FRINTX  H12, H27
    FRINTN  S4, S12
    FRINTX  S12, S2
    FRINTX  D30, D12
    FRINTN  D3, D14
    FRINTN  S0, S3
    FRINTA  H3, H4
    FRINTN  D20, D15
    FRINTX  D14, D24
    FRINTI  S27, S3
    FRINTX  H12, H20
    FRINTX  D24, D13
    FRINTA  D2, D30
    FRINTA  S17, S0
    FRINTA  H20, H14
    FRINTX  H25, H24
    FRINTI  H14, H2
    FRINTI  S0, S27
    FRINTI  S4, S6
    FRINTA  H6, H4
    FRINTP  D10, D20
    FRINTN  D15, D6
    FRINTN  S13, S31
    FRINTI  D6, D5
    FRINTI  D9, D0
    FRINTZ  S24, S17
    FRINTI  S17, S24
    FRINTZ  S31, S9
    FRINTP  D4, D12
    FRINTZ  H20, H4
    FRINTA  H9, H17
    FRINTX  D5, D14
    FRINTZ  H17, H4
    FRINTZ  D0, D9
    FRINTX  D30, D1
    FRINTX  S3, S10
    FRINTM  H27, H20
    FRINTN  S2, S5
    FRINTN  S12, S25
    FRINTM  D4, D17
    FRINTA  H5, H31
    FRINTP  H25, H6
    FRINTX  D10, D13
    FRINTI  H4, H27
    FRINTA  S31, S25
    FRINTN  D9, D4
    FRINTM  D6, D0
    FRINTN  H13, H30
    FRINTM  S4, S6
    FRINTA  S0, S12
    FRINTI  D27, D15
    FRINTP  S17, S3
    FRINTA  D30, D4
    FRINTP  D25, D31
    FRINTA  H6, H13
    FRINTM  S3, S25
    FRINTA  S4, S9
    FRINTP  H15, H0
    FRINTA  D25, D17
    FRINTZ  H13, H4
    FRINTX  S4, S27
    FRINTX  S12, S30
    FRINTP  D30, D6
    FRINTA  D31, D13
    FRINTA  D13, D30
    FRINTM  S30, S13
    FRINTI  D13, D3
    FRINTM  H16, H15
    FRINTA  H6, H13
    FRINTM  H9, H12
    FRINTI  S0, S25
    FRINTN  S17, S16
    FRINTA  S15, S6
    FRINTM  H12, H15
    FRINTN  H16, H1
    FRINTM  H6, H4
    FRINTZ  D25, D0
    FRINTX  S27, S9
    FRINTZ  S3, S31
    FRINTN  H11, H6
    FRINTN  S13, S17
    FRINTZ  S4, S3
    FRINTP  D3, D30
    FRINTA  H17, H12
    FRINTX  H9, H13
    FRINTZ  H13, H17
    FRINTA  S15, S9
    FRINTP  D9, D25
    FRINTM  S17, S16
    FRINTI  D31, D11
    FRINTA  D30, D9
    FRINTX  D0, D4
    FRINTN  D9, D31
    FRINTI  H1, H27
    FRINTM  H25, H13
    FRINTP  H13, H30
    FRINTZ  D25, D17
    FRINTX  H16, H15
    FRINTX  H11, H1
    FRINTM  S14, S0
    FRINTX  S6, S9
    SUBS  X7, X7, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_13
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x10, LSL #0
    MRS  X3, FPSR
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D1
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D2
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D3
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D5
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D7
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D8
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D9
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D11
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D12
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D15
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D16
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D18
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D19
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D20
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D21
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D22
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D24
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D25
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D26
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D27
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D28
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D29
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D30
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X3, D31
    SUB  X4, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
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
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X6
    FMOV  D3, X25
    FMOV  V3.D[1], X24
    FMOV  D4, X3
    FMOV  V4.D[1], X6
    FMOV  D5, X2
    FMOV  V5.D[1], X29
    FMOV  D6, X27
    FMOV  V6.D[1], X17
    FMOV  D7, X12
    FMOV  V7.D[1], X5
    FMOV  D8, X19
    FMOV  V8.D[1], X14
    FMOV  D9, X25
    FMOV  V9.D[1], X16
    FMOV  D10, X13
    FMOV  V10.D[1], X29
    FMOV  D11, X10
    FMOV  V11.D[1], X6
    FMOV  D12, X5
    FMOV  V12.D[1], X17
    FMOV  D13, X6
    FMOV  V13.D[1], X25
    FMOV  D14, X12
    FMOV  V14.D[1], X22
    FMOV  D15, X19
    FMOV  V15.D[1], X15
    FMOV  D16, X3
    FMOV  V16.D[1], X22
    FMOV  D17, X16
    FMOV  V17.D[1], X15
    FMOV  D18, X19
    FMOV  V18.D[1], X27
    FMOV  D19, X11
    FMOV  V19.D[1], X15
    FMOV  D20, X5
    FMOV  V20.D[1], X5
    FMOV  D21, X2
    FMOV  V21.D[1], X4
    FMOV  D22, X11
    FMOV  V22.D[1], X19
    FMOV  D23, X7
    FMOV  V23.D[1], X17
    FMOV  D24, X17
    FMOV  V24.D[1], X16
    FMOV  D25, X10
    FMOV  V25.D[1], X2
    FMOV  D26, X14
    FMOV  V26.D[1], X6
    FMOV  D27, X28
    FMOV  V27.D[1], X14
    FMOV  D28, X12
    FMOV  V28.D[1], X24
    FMOV  D29, X14
    FMOV  V29.D[1], X21
    FMOV  D30, X19
    FMOV  V30.D[1], X7
    FMOV  D31, X17
    FMOV  V31.D[1], X10
    MOVZ  X17, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_14:
    FRINTZ  D23, D22
    FRINTP  H14, H24
    FRINTZ  S0, S31
    FRINTP  D25, D14
    FRINTA  H17, H29
    FRINTX  S20, S28
    FRINTP  H21, H0
    FRINTN  H29, H21
    FRINTZ  D17, D23
    FRINTM  D14, D27
    FRINTA  H13, H14
    FRINTI  D31, D13
    FRINTN  H18, H17
    FRINTZ  H9, H20
    FRINTX  D4, D30
    FRINTM  H21, H31
    FRINTM  H0, H21
    FRINTZ  S12, S26
    FRINTM  S20, S6
    FRINTX  H25, H18
    FRINTM  D0, D9
    FRINTX  H6, H29
    FRINTN  S28, S23
    FRINTN  S18, S17
    FRINTI  D14, D18
    FRINTN  H17, H14
    FRINTN  S13, S17
    FRINTA  H29, H13
    FRINTZ  D30, D29
    FRINTI  D9, D12
    FRINTZ  H14, H28
    FRINTP  D29, D20
    FRINTN  D12, D21
    FRINTX  H27, H4
    FRINTX  S18, S27
    FRINTP  D21, D31
    FRINTX  H4, H6
    FRINTX  S27, S29
    FRINTI  D31, D25
    FRINTA  H26, H0
    FRINTA  D28, D18
    FRINTN  H20, H26
    FRINTN  S13, S31
    FRINTA  H31, H28
    FRINTN  H29, H21
    FRINTA  S26, S13
    FRINTX  D28, D27
    FRINTP  D13, D4
    FRINTN  D21, D12
    FRINTI  S4, S14
    FRINTP  D12, D31
    FRINTM  S6, S4
    FRINTN  S18, S26
    FRINTZ  S0, S18
    FRINTI  H25, H0
    FRINTN  D4, D12
    FRINTI  H12, H28
    FRINTX  H28, H21
    FRINTA  S27, S28
    FRINTZ  D21, D6
    FRINTN  H28, H13
    FRINTN  H0, H29
    FRINTM  D29, D25
    FRINTN  D6, D29
    FRINTX  S31, S20
    FRINTA  S14, S7
    FRINTA  D26, D6
    FRINTM  H18, H4
    FRINTP  D25, D16
    FRINTM  S16, S12
    FRINTA  D7, D27
    FRINTN  S27, S15
    FRINTI  S4, S21
    FRINTZ  D12, D14
    FRINTM  H13, H18
    FRINTI  D6, D26
    FRINTN  S10, S31
    FRINTZ  H8, H7
    FRINTA  S29, S10
    FRINTX  D23, D29
    FRINTZ  H7, H27
    FRINTZ  S31, S23
    FRINTM  S26, S16
    FRINTX  H21, H28
    FRINTP  D10, D25
    FRINTZ  H20, H8
    FRINTX  D25, D10
    FRINTX  H27, H26
    FRINTZ  H28, H21
    FRINTM  D18, D25
    FRINTP  H14, H0
    FRINTX  H21, H4
    FRINTX  S15, S20
    FRINTM  H20, H7
    FRINTM  S29, S27
    FRINTA  S16, S12
    FRINTA  H4, H15
    FRINTA  H8, H18
    FRINTN  D7, D28
    FRINTZ  H0, H8
    FRINTA  S25, S0
    FRINTA  H8, H29
    FRINTP  H15, H7
    FRINTN  D26, D14
    FRINTX  S0, S25
    FRINTZ  S14, S6
    FRINTP  H7, H26
    FRINTX  H28, H7
    FRINTI  H27, H0
    FRINTP  S0, S31
    FRINTN  H25, H21
    FRINTZ  D18, D16
    FRINTA  D10, D0
    FRINTM  D29, D4
    FRINTP  H21, H29
    FRINTZ  S0, S8
    FRINTZ  D7, D28
    FRINTA  S31, S10
    FRINTP  S16, S18
    FRINTX  H26, H14
    FRINTZ  D6, D27
    FRINTX  S27, S20
    FRINTX  H29, H21
    FRINTX  S12, S29
    FRINTP  H1, H16
    FRINTN  D14, D12
    FRINTN  D21, D25
    FRINTI  D12, D27
    FRINTA  H18, H1
    FRINTX  H10, H21
    FRINTA  H16, H14
    FRINTZ  H21, H16
    FRINTA  D25, D21
    FRINTA  H8, H26
    FRINTN  D27, D12
    FRINTM  D26, D27
    FRINTM  H21, H6
    FRINTX  D20, D10
    FRINTZ  S12, S20
    FRINTP  H27, H12
    FRINTN  D1, D18
    FRINTA  H18, H0
    FRINTA  D20, D21
    FRINTZ  H12, H20
    FRINTI  D16, D25
    FRINTZ  S25, S8
    FRINTA  D10, D12
    FRINTX  S29, S10
    FRINTN  H14, H29
    FRINTI  S6, S1
    FRINTX  H21, H26
    FRINTP  H8, H6
    FRINTZ  S29, S18
    FRINTP  H12, H14
    FRINTM  S10, S29
    FRINTN  D1, D10
    FRINTP  D0, D8
    FRINTX  H8, H0
    FRINTI  H29, H21
    FRINTI  S21, S25
    FRINTI  H14, H8
    FRINTZ  H20, H12
    FRINTA  H11, H21
    FRINTP  S10, S16
    FRINTN  S6, S1
    FRINTM  D1, D10
    FRINTN  H2, H6
    FRINTM  S25, S1
    FRINTP  H0, H25
    FRINTX  S16, S11
    FRINTM  S18, S9
    FRINTA  S6, S14
    FRINTI  H25, H18
    FRINTZ  H12, H16
    FRINTZ  D16, D20
    FRINTM  H9, H12
    FRINTN  D8, D29
    FRINTN  H29, H2
    FRINTN  D1, D16
    FRINTZ  D12, D8
    FRINTP  D8, D6
    FRINTA  S11, S0
    FRINTM  D2, D29
    FRINTA  D16, D1
    FRINTA  S29, S12
    FRINTM  D18, D9
    FRINTM  D21, D25
    FRINTZ  S0, S16
    FRINTM  S16, S0
    FRINTN  D6, D16
    FRINTP  D1, D6
    FRINTM  H9, H29
    FRINTP  S12, S30
    FRINTX  S14, S8
    FRINTI  D16, D14
    FRINTP  D25, D21
    FRINTN  H0, H9
    FRINTI  S8, S2
    FRINTN  H21, H16
    FRINTA  S6, S12
    SUBS  X17, X17, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_14
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x10, LSL #0
    MRS  X25, FPSR
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, V3.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, D3
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, V5.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, D5
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, V19.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, D19
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, V22.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, D22
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, V24.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    FMOV  X25, D24
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x9c9c, LSL #0
    MOVK  X2, #0x7e91, LSL #16
    MOVK  X2, #0xc09, LSL #32
    MOVK  X2, #0x12a7, LSL #48
    MOVZ  X3, #0xddda, LSL #0
    MOVK  X3, #0x379e, LSL #16
    MOVK  X3, #0x539e, LSL #32
    MOVK  X3, #0xc4ec, LSL #48
    MOVZ  X4, #0x3c17, LSL #0
    MOVK  X4, #0x8c41, LSL #16
    MOVK  X4, #0xa0e9, LSL #32
    MOVK  X4, #0x59f8, LSL #48
    MOVZ  X5, #0x1680, LSL #0
    MOVK  X5, #0xa9ff, LSL #16
    MOVK  X5, #0xb467, LSL #32
    MOVK  X5, #0xff2, LSL #48
    MOVZ  X6, #0xea21, LSL #0
    MOVK  X6, #0xc824, LSL #16
    MOVK  X6, #0x1dc4, LSL #32
    MOVK  X6, #0x2d0e, LSL #48
    MOVZ  X7, #0x2a26, LSL #0
    MOVK  X7, #0xe8eb, LSL #16
    MOVK  X7, #0x994, LSL #32
    MOVK  X7, #0x20df, LSL #48
    MOVZ  X9, #0x94d0, LSL #0
    MOVK  X9, #0x136, LSL #16
    MOVK  X9, #0xcd11, LSL #32
    MOVK  X9, #0xe1e8, LSL #48
    MOVZ  X10, #0x4f2c, LSL #0
    MOVK  X10, #0xaa6b, LSL #16
    MOVK  X10, #0x9a1d, LSL #32
    MOVK  X10, #0x2439, LSL #48
    MOVZ  X11, #0x2603, LSL #0
    MOVK  X11, #0xd536, LSL #16
    MOVK  X11, #0xcaf2, LSL #32
    MOVK  X11, #0xd40, LSL #48
    MOVZ  X12, #0xbecf, LSL #0
    MOVK  X12, #0xe149, LSL #16
    MOVK  X12, #0x83a5, LSL #32
    MOVK  X12, #0x5439, LSL #48
    MOVZ  X13, #0x3af9, LSL #0
    MOVK  X13, #0x4ccd, LSL #16
    MOVK  X13, #0x87c3, LSL #32
    MOVK  X13, #0xdb75, LSL #48
    MOVZ  X14, #0x2e69, LSL #0
    MOVK  X14, #0xabd0, LSL #16
    MOVK  X14, #0xd60e, LSL #32
    MOVK  X14, #0xb733, LSL #48
    MOVZ  X15, #0x701b, LSL #0
    MOVK  X15, #0x91bc, LSL #16
    MOVK  X15, #0xd0d1, LSL #32
    MOVK  X15, #0x3f33, LSL #48
    MOVZ  X16, #0x1040, LSL #0
    MOVK  X16, #0x98cb, LSL #16
    MOVK  X16, #0x5c18, LSL #32
    MOVK  X16, #0xe70a, LSL #48
    MOVZ  X17, #0x4784, LSL #0
    MOVK  X17, #0xb473, LSL #16
    MOVK  X17, #0xf0e3, LSL #32
    MOVK  X17, #0x87b5, LSL #48
    MOVZ  X18, #0xd975, LSL #0
    MOVK  X18, #0x560e, LSL #16
    MOVK  X18, #0xce38, LSL #32
    MOVK  X18, #0x7d6a, LSL #48
    MOVZ  X19, #0x2fa1, LSL #0
    MOVK  X19, #0x1f6, LSL #16
    MOVK  X19, #0x626c, LSL #32
    MOVK  X19, #0x17fb, LSL #48
    MOVZ  X21, #0xd9f, LSL #0
    MOVK  X21, #0xf9db, LSL #16
    MOVK  X21, #0x2298, LSL #32
    MOVK  X21, #0xbf3e, LSL #48
    MOVZ  X22, #0xd2cc, LSL #0
    MOVK  X22, #0xe9ef, LSL #16
    MOVK  X22, #0x275e, LSL #32
    MOVK  X22, #0xb3c6, LSL #48
    MOVZ  X24, #0xfb8, LSL #0
    MOVK  X24, #0x5f0c, LSL #16
    MOVK  X24, #0xe4d6, LSL #32
    MOVK  X24, #0xea41, LSL #48
    MOVZ  X25, #0xbf89, LSL #0
    MOVK  X25, #0xc36e, LSL #16
    MOVK  X25, #0xcf6d, LSL #32
    MOVK  X25, #0xb51, LSL #48
    MOVZ  X27, #0xee3e, LSL #0
    MOVK  X27, #0x954a, LSL #16
    MOVK  X27, #0x8fbe, LSL #32
    MOVK  X27, #0x9d39, LSL #48
    MOVZ  X28, #0x8025, LSL #0
    MOVK  X28, #0x96f9, LSL #16
    MOVK  X28, #0xe1e5, LSL #32
    MOVK  X28, #0xd0f1, LSL #48
    MOVZ  X29, #0x91ce, LSL #0
    MOVK  X29, #0x5d89, LSL #16
    MOVK  X29, #0x8329, LSL #32
    MOVK  X29, #0xcc59, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X7
    FMOV  D3, X10
    FMOV  V3.D[1], X17
    FMOV  D4, X3
    FMOV  V4.D[1], X9
    FMOV  D5, X13
    FMOV  V5.D[1], X17
    FMOV  D6, X19
    FMOV  V6.D[1], X2
    FMOV  D7, X2
    FMOV  V7.D[1], X24
    FMOV  D8, X16
    FMOV  V8.D[1], X3
    FMOV  D9, X4
    FMOV  V9.D[1], X10
    FMOV  D10, X10
    FMOV  V10.D[1], X9
    FMOV  D11, X29
    FMOV  V11.D[1], X27
    FMOV  D12, X13
    FMOV  V12.D[1], X13
    FMOV  D13, X12
    FMOV  V13.D[1], X15
    FMOV  D14, X13
    FMOV  V14.D[1], X12
    FMOV  D15, X6
    FMOV  V15.D[1], X7
    FMOV  D16, X14
    FMOV  V16.D[1], X4
    FMOV  D17, X9
    FMOV  V17.D[1], X28
    FMOV  D18, X29
    FMOV  V18.D[1], X18
    FMOV  D19, X21
    FMOV  V19.D[1], X25
    FMOV  D20, X19
    FMOV  V20.D[1], X12
    FMOV  D21, X17
    FMOV  V21.D[1], X3
    FMOV  D22, X7
    FMOV  V22.D[1], X16
    FMOV  D23, X22
    FMOV  V23.D[1], X10
    FMOV  D24, X15
    FMOV  V24.D[1], X21
    FMOV  D25, X9
    FMOV  V25.D[1], X6
    FMOV  D26, X13
    FMOV  V26.D[1], X11
    FMOV  D27, X9
    FMOV  V27.D[1], X22
    FMOV  D28, X19
    FMOV  V28.D[1], X25
    FMOV  D29, X25
    FMOV  V29.D[1], X7
    FMOV  D30, X5
    FMOV  V30.D[1], X13
    FMOV  D31, X22
    FMOV  V31.D[1], X12
    MOVZ  X5, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_15:
    FRINTI  S1, S31
    FRINTX  H26, H28
    FRINTM  S11, S27
    FRINTM  S21, S29
    FRINTZ  H10, H22
    FRINTZ  S25, S1
    FRINTM  H6, H10
    FRINTA  S13, S21
    FRINTI  S31, S26
    FRINTN  S31, S31
    FRINTA  D4, D13
    FRINTX  D23, D30
    FRINTZ  D9, D25
    FRINTZ  H11, H9
    FRINTI  S22, S11
    FRINTI  D15, D23
    FRINTA  D6, D31
    FRINTZ  H20, H6
    FRINTP  D28, D20
    FRINTN  D29, D15
    FRINTA  D25, D29
    FRINTX  D13, D22
    FRINTZ  S17, S28
    FRINTX  D22, D4
    FRINTX  H20, H25
    FRINTN  D23, D20
    FRINTA  H30, H23
    FRINTX  D31, D13
    FRINTN  H1, H31
    FRINTA  S20, S22
    FRINTI  S6, S9
    FRINTZ  D25, D6
    FRINTM  D22, D25
    FRINTM  H31, H20
    FRINTZ  D13, D17
    FRINTP  D11, D13
    FRINTX  H23, H22
    FRINTP  H13, H11
    FRINTZ  H15, H13
    FRINTX  D28, D23
    FRINTZ  S4, S31
    FRINTM  H17, H27
    FRINTN  S23, S4
    FRINTN  H20, H26
    FRINTN  D9, D1
    FRINTI  H26, H17
    FRINTN  H17, H23
    FRINTM  S25, S15
    FRINTP  D31, D9
    FRINTZ  S4, S28
    FRINTZ  H23, H20
    FRINTP  S13, S26
    FRINTM  S15, S30
    FRINTP  H30, H17
    FRINTX  D9, D23
    FRINTP  H23, H25
    FRINTZ  H11, H9
    FRINTA  S25, S15
    FRINTA  D15, D31
    FRINTN  D20, D11
    FRINTP  D28, D7
    FRINTA  S9, S4
    FRINTP  D4, D13
    FRINTN  H1, H30
    FRINTM  H17, H25
    FRINTN  S25, S4
    FRINTI  H30, H23
    FRINTX  S27, S20
    FRINTX  S26, S28
    FRINTP  D4, D15
    FRINTI  H11, H4
    FRINTI  D4, D26
    FRINTP  S7, S30
    FRINTZ  H31, H4
    FRINTN  S23, S1
    FRINTP  D1, D27
    FRINTX  S15, S19
    FRINTP  H19, H7
    FRINTZ  D7, D31
    FRINTZ  S27, S7
    FRINTX  S30, S25
    FRINTM  H4, H23
    FRINTN  D20, D9
    FRINTA  H23, H11
    FRINTM  D7, D17
    FRINTM  D26, D7
    FRINTM  D31, D26
    FRINTN  D7, D19
    FRINTZ  S25, S27
    FRINTA  S26, S30
    FRINTX  H11, H1
    FRINTN  S9, S21
    FRINTI  H19, H7
    FRINTP  D27, D19
    FRINTP  S17, S15
    FRINTA  S30, S25
    FRINTA  S1, S11
    FRINTX  H11, H8
    FRINTA  S21, S30
    FRINTI  S19, S17
    FRINTA  S30, S31
    FRINTP  D8, D8
    FRINTN  H25, H4
    FRINTZ  D17, D27
    FRINTX  S13, S1
    FRINTN  D31, D17
    FRINTN  D7, D11
    FRINTN  H1, H9
    FRINTM  D17, D21
    FRINTX  D21, D19
    FRINTI  D9, D21
    FRINTN  D21, D9
    FRINTA  S15, S8
    FRINTZ  D18, D15
    FRINTX  S15, S18
    FRINTX  D9, D17
    FRINTI  H18, H26
    FRINTZ  D11, D30
    FRINTM  D17, D11
    FRINTA  S26, S1
    FRINTZ  H11, H15
    FRINTI  D14, D0
    FRINTN  S15, S25
    FRINTA  H25, H7
    FRINTX  S0, S26
    FRINTZ  H19, H31
    FRINTA  D1, D13
    FRINTM  H30, H17
    FRINTI  H8, H15
    FRINTI  D4, D19
    FRINTN  S7, S14
    FRINTI  H19, H25
    FRINTI  S26, S0
    FRINTN  S31, S8
    FRINTA  D14, D19
    FRINTZ  S15, S1
    FRINTN  D17, D11
    FRINTZ  H13, H26
    FRINTN  S8, S31
    FRINTM  S28, S14
    FRINTM  H19, H28
    FRINTA  D25, D30
    FRINTP  H31, H4
    FRINTZ  D21, D13
    FRINTN  H18, H21
    FRINTM  H14, H19
    FRINTP  S13, S25
    FRINTA  S4, S31
    FRINTP  S21, S7
    FRINTZ  H31, H21
    FRINTZ  H30, H31
    FRINTI  D26, D18
    FRINTP  D28, D14
    FRINTM  H18, H26
    FRINTZ  S7, S13
    FRINTZ  D11, D15
    FRINTN  D26, D11
    FRINTN  D0, D4
    FRINTN  S4, S8
    FRINTI  H13, H4
    FRINTN  S25, S26
    FRINTA  S19, S28
    FRINTM  H21, H30
    FRINTZ  S26, S17
    FRINTZ  S14, S26
    FRINTA  H4, H14
    FRINTA  S31, S25
    FRINTP  D15, D13
    FRINTI  H13, H29
    FRINTI  S17, S4
    FRINTP  H14, H15
    FRINTP  S26, S31
    FRINTN  D31, D0
    FRINTM  H29, H26
    FRINTI  H0, H21
    FRINTZ  S30, S0
    FRINTN  H25, H14
    FRINTZ  S26, S25
    FRINTM  S28, S31
    FRINTX  S4, S13
    FRINTZ  H14, H17
    FRINTA  H13, H4
    FRINTN  S25, S26
    FRINTZ  D21, D29
    FRINTI  S0, S25
    FRINTM  H26, H0
    FRINTM  H4, H13
    FRINTP  H25, H14
    FRINTX  H8, H30
    FRINTP  D0, D8
    FRINTP  D17, D0
    FRINTZ  D8, D26
    FRINTZ  S15, S25
    FRINTX  S30, S8
    FRINTM  H0, H4
    FRINTI  D31, D0
    FRINTX  S25, S15
    FRINTA  H8, H17
    FRINTX  S26, S1
    FRINTP  S14, S21
    SUBS  X5, X5, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_15
    MOVZ  X19, #0x9c9c, LSL #0
    MOVK  X19, #0x7e91, LSL #16
    MOVK  X19, #0xc09, LSL #32
    MOVK  X19, #0x12a7, LSL #48
    SUB  X12, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0xddda, LSL #0
    MOVK  X19, #0x379e, LSL #16
    MOVK  X19, #0x539e, LSL #32
    MOVK  X19, #0xc4ec, LSL #48
    SUB  X12, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x3c17, LSL #0
    MOVK  X19, #0x8c41, LSL #16
    MOVK  X19, #0xa0e9, LSL #32
    MOVK  X19, #0x59f8, LSL #48
    SUB  X12, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0xea21, LSL #0
    MOVK  X19, #0xc824, LSL #16
    MOVK  X19, #0x1dc4, LSL #32
    MOVK  X19, #0x2d0e, LSL #48
    SUB  X12, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x2a26, LSL #0
    MOVK  X19, #0xe8eb, LSL #16
    MOVK  X19, #0x994, LSL #32
    MOVK  X19, #0x20df, LSL #48
    SUB  X12, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x94d0, LSL #0
    MOVK  X19, #0x136, LSL #16
    MOVK  X19, #0xcd11, LSL #32
    MOVK  X19, #0xe1e8, LSL #48
    SUB  X12, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x4f2c, LSL #0
    MOVK  X19, #0xaa6b, LSL #16
    MOVK  X19, #0x9a1d, LSL #32
    MOVK  X19, #0x2439, LSL #48
    SUB  X12, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x2603, LSL #0
    MOVK  X19, #0xd536, LSL #16
    MOVK  X19, #0xcaf2, LSL #32
    MOVK  X19, #0xd40, LSL #48
    SUB  X12, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x3af9, LSL #0
    MOVK  X19, #0x4ccd, LSL #16
    MOVK  X19, #0x87c3, LSL #32
    MOVK  X19, #0xdb75, LSL #48
    SUB  X12, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x2e69, LSL #0
    MOVK  X19, #0xabd0, LSL #16
    MOVK  X19, #0xd60e, LSL #32
    MOVK  X19, #0xb733, LSL #48
    SUB  X12, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x701b, LSL #0
    MOVK  X19, #0x91bc, LSL #16
    MOVK  X19, #0xd0d1, LSL #32
    MOVK  X19, #0x3f33, LSL #48
    SUB  X12, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x1040, LSL #0
    MOVK  X19, #0x98cb, LSL #16
    MOVK  X19, #0x5c18, LSL #32
    MOVK  X19, #0xe70a, LSL #48
    SUB  X12, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x4784, LSL #0
    MOVK  X19, #0xb473, LSL #16
    MOVK  X19, #0xf0e3, LSL #32
    MOVK  X19, #0x87b5, LSL #48
    SUB  X12, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0xd975, LSL #0
    MOVK  X19, #0x560e, LSL #16
    MOVK  X19, #0xce38, LSL #32
    MOVK  X19, #0x7d6a, LSL #48
    SUB  X12, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0xd9f, LSL #0
    MOVK  X19, #0xf9db, LSL #16
    MOVK  X19, #0x2298, LSL #32
    MOVK  X19, #0xbf3e, LSL #48
    SUB  X12, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0xfb8, LSL #0
    MOVK  X19, #0x5f0c, LSL #16
    MOVK  X19, #0xe4d6, LSL #32
    MOVK  X19, #0xea41, LSL #48
    SUB  X12, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0xbf89, LSL #0
    MOVK  X19, #0xc36e, LSL #16
    MOVK  X19, #0xcf6d, LSL #32
    MOVK  X19, #0xb51, LSL #48
    SUB  X12, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0xee3e, LSL #0
    MOVK  X19, #0x954a, LSL #16
    MOVK  X19, #0x8fbe, LSL #32
    MOVK  X19, #0x9d39, LSL #48
    SUB  X12, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x8025, LSL #0
    MOVK  X19, #0x96f9, LSL #16
    MOVK  X19, #0xe1e5, LSL #32
    MOVK  X19, #0xd0f1, LSL #48
    SUB  X12, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x91ce, LSL #0
    MOVK  X19, #0x5d89, LSL #16
    MOVK  X19, #0x8329, LSL #32
    MOVK  X19, #0xcc59, LSL #48
    SUB  X12, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x10, LSL #0
    MRS  X12, FPSR
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D0
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D1
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x2a26, LSL #0
    MOVK  X19, #0xe8eb, LSL #16
    MOVK  X19, #0x994, LSL #32
    MOVK  X19, #0x20df, LSL #48
    FMOV  X12, V2.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0xee3e, LSL #0
    MOVK  X19, #0x954a, LSL #16
    MOVK  X19, #0x8fbe, LSL #32
    MOVK  X19, #0x9d39, LSL #48
    FMOV  X12, D2
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x4784, LSL #0
    MOVK  X19, #0xb473, LSL #16
    MOVK  X19, #0xf0e3, LSL #32
    MOVK  X19, #0x87b5, LSL #48
    FMOV  X12, V3.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x4f2c, LSL #0
    MOVK  X19, #0xaa6b, LSL #16
    MOVK  X19, #0x9a1d, LSL #32
    MOVK  X19, #0x2439, LSL #48
    FMOV  X12, D3
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D4
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x4784, LSL #0
    MOVK  X19, #0xb473, LSL #16
    MOVK  X19, #0xf0e3, LSL #32
    MOVK  X19, #0x87b5, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x3af9, LSL #0
    MOVK  X19, #0x4ccd, LSL #16
    MOVK  X19, #0x87c3, LSL #32
    MOVK  X19, #0xdb75, LSL #48
    FMOV  X12, D5
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D6
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D7
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D8
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D9
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D10
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D11
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x3af9, LSL #0
    MOVK  X19, #0x4ccd, LSL #16
    MOVK  X19, #0x87c3, LSL #32
    MOVK  X19, #0xdb75, LSL #48
    FMOV  X12, V12.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x3af9, LSL #0
    MOVK  X19, #0x4ccd, LSL #16
    MOVK  X19, #0x87c3, LSL #32
    MOVK  X19, #0xdb75, LSL #48
    FMOV  X12, D12
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D13
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D14
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D15
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x3c17, LSL #0
    MOVK  X19, #0x8c41, LSL #16
    MOVK  X19, #0xa0e9, LSL #32
    MOVK  X19, #0x59f8, LSL #48
    FMOV  X12, V16.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x2e69, LSL #0
    MOVK  X19, #0xabd0, LSL #16
    MOVK  X19, #0xd60e, LSL #32
    MOVK  X19, #0xb733, LSL #48
    FMOV  X12, D16
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D17
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D18
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D19
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D20
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D21
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D22
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D23
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0xd9f, LSL #0
    MOVK  X19, #0xf9db, LSL #16
    MOVK  X19, #0x2298, LSL #32
    MOVK  X19, #0xbf3e, LSL #48
    FMOV  X12, V24.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x701b, LSL #0
    MOVK  X19, #0x91bc, LSL #16
    MOVK  X19, #0xd0d1, LSL #32
    MOVK  X19, #0x3f33, LSL #48
    FMOV  X12, D24
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D25
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D26
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D27
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D28
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D29
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D30
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, D31
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X3
    FMOV  V0.D[1], X16
    FMOV  D1, X6
    FMOV  V1.D[1], X17
    FMOV  D2, X13
    FMOV  V2.D[1], X19
    FMOV  D3, X2
    FMOV  V3.D[1], X14
    FMOV  D4, X28
    FMOV  V4.D[1], X18
    FMOV  D5, X21
    FMOV  V5.D[1], X27
    FMOV  D6, X29
    FMOV  V6.D[1], X22
    FMOV  D7, X25
    FMOV  V7.D[1], X24
    FMOV  D8, X24
    FMOV  V8.D[1], X29
    FMOV  D9, X15
    FMOV  V9.D[1], X29
    FMOV  D10, X9
    FMOV  V10.D[1], X13
    FMOV  D11, X22
    FMOV  V11.D[1], X16
    FMOV  D12, X28
    FMOV  V12.D[1], X19
    FMOV  D13, X16
    FMOV  V13.D[1], X6
    FMOV  D14, X21
    FMOV  V14.D[1], X11
    FMOV  D15, X12
    FMOV  V15.D[1], X21
    FMOV  D16, X9
    FMOV  V16.D[1], X7
    FMOV  D17, X21
    FMOV  V17.D[1], X19
    FMOV  D18, X21
    FMOV  V18.D[1], X15
    FMOV  D19, X19
    FMOV  V19.D[1], X28
    FMOV  D20, X17
    FMOV  V20.D[1], X24
    FMOV  D21, X29
    FMOV  V21.D[1], X21
    FMOV  D22, X4
    FMOV  V22.D[1], X18
    FMOV  D23, X22
    FMOV  V23.D[1], X22
    FMOV  D24, X28
    FMOV  V24.D[1], X21
    FMOV  D25, X21
    FMOV  V25.D[1], X14
    FMOV  D26, X7
    FMOV  V26.D[1], X4
    FMOV  D27, X3
    FMOV  V27.D[1], X21
    FMOV  D28, X24
    FMOV  V28.D[1], X17
    FMOV  D29, X7
    FMOV  V29.D[1], X16
    FMOV  D30, X28
    FMOV  V30.D[1], X2
    FMOV  D31, X9
    FMOV  V31.D[1], X22
    MOVZ  X29, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_16:
    FRINTA  S21, S26
    FRINTN  S0, S21
    FRINTI  S13, S29
    FRINTA  H0, H27
    FRINTM  D4, D13
    FRINTA  D26, D30
    FRINTZ  S0, S22
    FRINTP  H25, H28
    FRINTN  H6, H25
    FRINTI  H30, H6
    FRINTN  S8, S30
    FRINTZ  S13, S23
    FRINTX  D5, D13
    FRINTM  D11, D31
    FRINTX  H0, H0
    FRINTP  H4, H5
    FRINTI  H18, H8
    FRINTA  S29, S0
    FRINTZ  S19, S29
    FRINTN  D10, D19
    FRINTA  D18, D11
    FRINTN  S0, S4
    FRINTN  S11, S10
    FRINTM  D22, D0
    FRINTP  H30, H18
    FRINTM  H0, H22
    FRINTA  S31, S0
    FRINTP  S4, S30
    FRINTP  S18, S31
    FRINTI  H31, H11
    FRINTP  S5, S4
    FRINTP  S19, S26
    FRINTA  S30, S18
    FRINTX  S11, S30
    FRINTZ  D22, D31
    FRINTX  H31, H22
    FRINTN  D28, D19
    FRINTP  S19, S28
    FRINTP  H10, H11
    FRINTZ  D18, D10
    FRINTI  S22, S5
    FRINTN  H0, H31
    FRINTA  H31, H19
    FRINTZ  S11, S18
    FRINTM  H4, H22
    FRINTM  S5, S4
    FRINTP  S28, S31
    FRINTA  D30, D0
    FRINTN  D10, D30
    FRINTZ  H26, H11
    FRINTA  S11, S5
    FRINTP  D0, D26
    FRINTM  H31, H24
    FRINTM  D30, D31
    FRINTX  H31, H28
    FRINTP  H28, H30
    FRINTN  D18, D0
    FRINTP  S22, S28
    FRINTA  H26, H11
    FRINTA  D0, D10
    FRINTI  D18, D0
    FRINTN  H30, H31
    FRINTZ  S24, S30
    FRINTX  D28, D26
    FRINTM  H4, H18
    FRINTN  D10, D22
    FRINTM  D22, D28
    FRINTX  S5, S4
    FRINTA  D11, D24
    FRINTP  S0, S10
    FRINTA  S24, S0
    FRINTX  S0, S5
    FRINTM  S31, S0
    FRINTX  H10, H24
    FRINTX  S30, S22
    FRINTZ  D24, D31
    FRINTN  H20, H11
    FRINTI  H4, H20
    FRINTI  S26, S20
    FRINTN  S30, S10
    FRINTX  D10, D31
    FRINTX  S11, S24
    FRINTN  D5, D11
    FRINTX  S0, S5
    FRINTI  H24, H4
    FRINTI  D11, D26
    FRINTP  H5, H24
    FRINTA  S22, S10
    FRINTZ  S20, S30
    FRINTX  S30, S20
    FRINTN  S20, S0
    FRINTX  D10, D20
    FRINTN  S31, S7
    FRINTI  D7, D30
    FRINTM  S26, S22
    FRINTI  D4, D7
    FRINTX  S28, S27
    FRINTZ  D30, D11
    FRINTN  D22, D4
    FRINTI  H4, H5
    FRINTI  H24, H22
    FRINTN  S0, S24
    FRINTP  D20, D28
    FRINTN  S5, S26
    FRINTP  S28, S20
    FRINTX  H20, H4
    FRINTX  S22, S5
    FRINTI  S7, S30
    FRINTZ  H24, H10
    FRINTX  H11, H0
    FRINTA  S27, S31
    FRINTX  D23, D22
    FRINTI  D29, D28
    FRINTP  H22, H11
    FRINTN  H31, H24
    FRINTZ  S30, S20
    FRINTX  D28, D7
    FRINTI  S26, S28
    FRINTX  H5, H30
    FRINTM  S11, S5
    FRINTA  D4, D11
    FRINTM  H24, H27
    FRINTX  S28, S29
    FRINTP  D20, D26
    FRINTX  D26, D28
    FRINTA  H29, H20
    FRINTI  D7, D23
    FRINTZ  S15, S26
    FRINTP  H0, H4
    FRINTP  H10, H31
    FRINTA  S5, S10
    FRINTZ  H30, H5
    FRINTZ  H10, H30
    FRINTA  S16, S29
    FRINTP  H20, H10
    FRINTM  D29, D16
    FRINTA  D16, D20
    FRINTZ  D10, D22
    FRINTA  S20, S26
    FRINTP  D26, D16
    FRINTM  D28, D29
    FRINTM  S30, S20
    FRINTN  H4, H15
    FRINTP  S22, S28
    FRINTN  H28, H7
    FRINTZ  H7, H24
    FRINTP  D5, D22
    FRINTP  H22, H7
    FRINTN  S23, S10
    FRINTM  H31, H28
    FRINTZ  D24, D5
    FRINTZ  D20, D22
    FRINTA  D28, D30
    FRINTP  D10, D23
    FRINTX  D20, D26
    FRINTP  S7, S4
    FRINTA  H15, H0
    FRINTN  S30, S20
    FRINTP  H23, H30
    FRINTN  S5, S7
    FRINTA  D29, D10
    FRINTI  S10, S24
    FRINTX  D4, D15
    FRINTA  H7, H4
    FRINTI  H22, H13
    FRINTZ  S20, S7
    FRINTM  H4, H31
    FRINTM  H0, H22
    FRINTM  H26, H29
    FRINTN  S31, S0
    FRINTP  H7, H4
    FRINTI  H29, H20
    FRINTZ  H13, H26
    FRINTM  H26, H10
    FRINTI  H30, H31
    FRINTM  D31, D28
    FRINTZ  H20, H26
    FRINTZ  D22, D30
    FRINTX  D30, D22
    FRINTZ  H24, H29
    FRINTM  S26, S24
    FRINTX  S29, S5
    FRINTM  S24, S13
    FRINTM  H0, H7
    FRINTN  H7, H0
    FRINTN  S4, S7
    FRINTA  H28, H30
    FRINTN  H10, H24
    FRINTN  H30, H31
    FRINTZ  S31, S30
    FRINTP  S13, S26
    FRINTP  H22, H13
    FRINTZ  S7, S29
    FRINTA  D30, D14
    FRINTX  S5, S31
    FRINTA  D24, D4
    FRINTI  S0, S5
    FRINTA  S26, S28
    FRINTI  S14, S26
    FRINTN  S28, S10
    SUBS  X29, X29, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_16
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x10, LSL #0
    MRS  X4, FPSR
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D0
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D1
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D2
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V3.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D3
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D4
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D5
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V6.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D6
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D7
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D8
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D9
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D10
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D11
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V12.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D12
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V13.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D13
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D14
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V15.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D15
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D16
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D17
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V18.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D18
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D19
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V20.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D20
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D21
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D22
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D23
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D24
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D25
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D26
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D27
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V28.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D28
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D29
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D30
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X4, D31
    SUB  X17, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatFloatPointRoundToInteger_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X21
    FMOV  D3, X13
    FMOV  V3.D[1], X13
    FMOV  D4, X27
    FMOV  V4.D[1], X12
    FMOV  D5, X21
    FMOV  V5.D[1], X17
    FMOV  D6, X17
    FMOV  V6.D[1], X11
    FMOV  D7, X3
    FMOV  V7.D[1], X14
    FMOV  D8, X21
    FMOV  V8.D[1], X28
    FMOV  D9, X9
    FMOV  V9.D[1], X5
    FMOV  D10, X24
    FMOV  V10.D[1], X29
    FMOV  D11, X18
    FMOV  V11.D[1], X14
    FMOV  D12, X17
    FMOV  V12.D[1], X19
    FMOV  D13, X10
    FMOV  V13.D[1], X6
    FMOV  D14, X24
    FMOV  V14.D[1], X2
    FMOV  D15, X3
    FMOV  V15.D[1], X22
    FMOV  D16, X7
    FMOV  V16.D[1], X14
    FMOV  D17, X27
    FMOV  V17.D[1], X13
    FMOV  D18, X6
    FMOV  V18.D[1], X21
    FMOV  D19, X6
    FMOV  V19.D[1], X2
    FMOV  D20, X19
    FMOV  V20.D[1], X15
    FMOV  D21, X24
    FMOV  V21.D[1], X13
    FMOV  D22, X11
    FMOV  V22.D[1], X13
    FMOV  D23, X11
    FMOV  V23.D[1], X7
    FMOV  D24, X6
    FMOV  V24.D[1], X2
    FMOV  D25, X27
    FMOV  V25.D[1], X7
    FMOV  D26, X11
    FMOV  V26.D[1], X10
    FMOV  D27, X4
    FMOV  V27.D[1], X6
    FMOV  D28, X12
    FMOV  V28.D[1], X3
    FMOV  D29, X10
    FMOV  V29.D[1], X18
    FMOV  D30, X25
    FMOV  V30.D[1], X14
    FMOV  D31, X25
    FMOV  V31.D[1], X17
    MOVZ  X14, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_17:
    FRINTP  S1, S26
    FRINTX  H28, H31
    FRINTP  D17, D1
    FRINTM  S23, S27
    FRINTX  H31, H25
    FRINTP  H28, H31
    FRINTI  D0, D29
    FRINTN  S8, S30
    FRINTA  H16, H8
    FRINTI  S20, S17
    FRINTN  S26, S16
    FRINTN  H6, H26
    FRINTZ  H28, H23
    FRINTI  S14, S28
    FRINTZ  D3, D6
    FRINTN  H9, H0
    FRINTN  D13, D9
    FRINTZ  H28, H13
    FRINTI  S31, S20
    FRINTA  S13, S14
    FRINTZ  S8, S31
    FRINTA  S23, S3
    FRINTM  H29, H13
    FRINTM  H31, H29
    FRINTZ  S20, S8
    FRINTN  H3, H23
    FRINTX  H25, H28
    FRINTX  D8, D20
    FRINTI  H30, H31
    FRINTZ  S6, S30
    FRINTP  S30, S3
    FRINTI  S29, S30
    FRINTM  S30, S25
    FRINTM  S20, S30
    FRINTM  H28, H20
    FRINTZ  H31, H6
    FRINTX  D23, D8
    FRINTP  S25, S23
    FRINTN  S13, S25
    FRINTN  D3, D29
    FRINTI  S30, S3
    FRINTN  D23, D28
    FRINTA  H8, H31
    FRINTM  S31, S13
    FRINTM  S6, S31
    FRINTN  S20, S30
    FRINTZ  D28, D20
    FRINTA  H3, H23
    FRINTM  S23, S3
    FRINTN  D25, D6
    FRINTX  H29, H19
    FRINTM  H24, H29
    FRINTP  H25, H28
    FRINTP  S30, S23
    FRINTM  D6, D30
    FRINTN  D28, D6
    FRINTI  D31, D8
    FRINTA  D29, D31
    FRINTN  D6, D13
    FRINTN  S20, S29
    FRINTA  H3, H25
    FRINTX  H8, H24
    FRINTM  S25, S28
    FRINTX  H31, H8
    FRINTM  D19, D29
    FRINTA  S28, S20
    FRINTP  H1, H15
    FRINTP  D20, D31
    FRINTP  S23, S20
    FRINTM  D13, D23
    FRINTI  D24, D1
    FRINTP  H2, H25
    FRINTI  D31, D3
    FRINTI  S28, S19
    FRINTP  H30, H13
    FRINTA  S8, S24
    FRINTI  H24, H6
    FRINTN  D15, D30
    FRINTP  S26, S2
    FRINTN  S29, S14
    FRINTN  S20, S26
    FRINTP  S2, S28
    FRINTZ  S25, S31
    FRINTP  D19, D8
    FRINTP  S1, S19
    FRINTN  D8, D24
    FRINTA  H23, H8
    FRINTA  H19, H23
    FRINTX  S13, S2
    FRINTA  D24, D25
    FRINTA  H3, H15
    FRINTZ  S28, S1
    FRINTA  S15, S28
    FRINTN  D30, D24
    FRINTP  S31, S19
    FRINTM  D0, D13
    FRINTA  H23, H29
    FRINTN  H29, H23
    FRINTZ  H8, H3
    FRINTM  H26, H8
    FRINTP  D2, D15
    FRINTI  S13, S30
    FRINTI  H1, H29
    FRINTM  D29, D0
    FRINTI  H24, H26
    FRINTI  S19, S31
    FRINTN  S3, S24
    FRINTZ  S26, S20
    FRINTM  H25, H29
    FRINTI  H14, H26
    FRINTZ  S20, S23
    FRINTZ  D29, D13
    FRINTA  D26, D29
    FRINTI  D0, D3
    FRINTI  S31, S26
    FRINTI  H24, H25
    FRINTN  D25, D14
    FRINTN  S3, S24
    FRINTN  D30, D19
    FRINTA  D24, D1
    FRINTA  H14, H31
    FRINTA  D13, D25
    FRINTI  S23, S3
    FRINTX  D26, D23
    FRINTI  D1, D30
    FRINTM  H29, H14
    FRINTZ  H14, H29
    FRINTX  D15, D26
    FRINTN  S3, S20
    FRINTP  S25, S1
    FRINTP  D21, D24
    FRINTZ  S1, S21
    FRINTZ  D31, D0
    FRINTN  D23, D14
    FRINTN  D19, D13
    FRINTZ  H0, H7
    FRINTI  S26, S15
    FRINTA  S24, S25
    FRINTX  H20, H3
    FRINTZ  D21, D23
    FRINTM  D0, D24
    FRINTM  D14, D1
    FRINTX  D1, D31
    FRINTZ  D2, D19
    FRINTA  S31, S14
    FRINTP  D14, D2
    FRINTI  H24, H7
    FRINTI  H23, H21
    FRINTN  D21, D24
    FRINTP  H2, H20
    FRINTA  H24, H31
    FRINTZ  S3, S1
    FRINTA  D31, D3
    FRINTM  H29, H24
    FRINTN  D15, D2
    FRINTZ  H19, H29
    FRINTA  H7, H0
    FRINTN  H20, H19
    FRINTX  S2, S14
    FRINTI  H0, H20
    FRINTA  D13, D31
    FRINTM  H24, H26
    FRINTP  H26, H0
    FRINTZ  S25, S2
    FRINTN  S1, S15
    FRINTP  H19, H25
    FRINTM  H2, H21
    FRINTI  H14, H23
    FRINTM  H23, H7
    FRINTI  H27, H1
    FRINTP  D0, D13
    FRINTA  D25, D19
    FRINTZ  D19, D24
    FRINTP  H20, H0
    FRINTP  H1, H2
    FRINTP  H29, H1
    FRINTI  H7, H24
    FRINTA  S31, S20
    FRINTN  D1, D23
    FRINTZ  S0, S29
    FRINTN  D2, D1
    FRINTA  D21, D14
    FRINTX  S29, S21
    FRINTX  D1, D25
    FRINTX  S24, S26
    FRINTX  S23, S7
    FRINTP  D21, D27
    FRINTZ  H7, H24
    FRINTP  D20, D29
    FRINTP  S29, S1
    FRINTA  D1, D2
    FRINTZ  S2, S0
    FRINTM  H26, H19
    FRINTP  D19, D2
    FRINTI  S0, S31
    FRINTZ  S14, S1
    FRINTZ  S24, S14
    FRINTA  H2, H6
    FRINTI  H14, H2
    FRINTI  S2, S12
    SUBS  X14, X14, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_17
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X15, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x10, LSL #0
    MRS  X15, FPSR
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D0
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D1
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    FMOV  X15, D2
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D3
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, V4.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, D4
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, V5.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, D5
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D6
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D8
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, V10.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, D10
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, V11.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, D11
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, V12.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, D12
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D13
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D16
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D17
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, V18.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, D18
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D20
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, V22.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X15, D22
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D23
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D24
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D26
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D27
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D29
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D30
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X15, D31
    SUB  X27, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0xc7b2, LSL #0
    MOVK  X2, #0x1e6d, LSL #16
    MOVK  X2, #0x754d, LSL #32
    MOVK  X2, #0x5905, LSL #48
    MOVZ  X3, #0xe049, LSL #0
    MOVK  X3, #0x449d, LSL #16
    MOVK  X3, #0xca00, LSL #32
    MOVK  X3, #0x3dd5, LSL #48
    MOVZ  X4, #0x722, LSL #0
    MOVK  X4, #0xd9cf, LSL #16
    MOVK  X4, #0x8f14, LSL #32
    MOVK  X4, #0x3bc1, LSL #48
    MOVZ  X5, #0x1720, LSL #0
    MOVK  X5, #0x14c6, LSL #16
    MOVK  X5, #0xa648, LSL #32
    MOVK  X5, #0xedc4, LSL #48
    MOVZ  X6, #0x2a75, LSL #0
    MOVK  X6, #0x86e0, LSL #16
    MOVK  X6, #0xb01b, LSL #32
    MOVK  X6, #0x7ca, LSL #48
    MOVZ  X7, #0x93d1, LSL #0
    MOVK  X7, #0x488b, LSL #16
    MOVK  X7, #0xbaa2, LSL #32
    MOVK  X7, #0x789a, LSL #48
    MOVZ  X9, #0xc589, LSL #0
    MOVK  X9, #0xa7d, LSL #16
    MOVK  X9, #0x9cd6, LSL #32
    MOVK  X9, #0xf919, LSL #48
    MOVZ  X10, #0x3e11, LSL #0
    MOVK  X10, #0xc3cb, LSL #16
    MOVK  X10, #0x428e, LSL #32
    MOVK  X10, #0xeff7, LSL #48
    MOVZ  X11, #0x416c, LSL #0
    MOVK  X11, #0xce2e, LSL #16
    MOVK  X11, #0x54c, LSL #32
    MOVK  X11, #0xecc0, LSL #48
    MOVZ  X12, #0x2f17, LSL #0
    MOVK  X12, #0xeeaf, LSL #16
    MOVK  X12, #0xd175, LSL #32
    MOVK  X12, #0xb9af, LSL #48
    MOVZ  X13, #0xece, LSL #0
    MOVK  X13, #0x28a0, LSL #16
    MOVK  X13, #0xc0fd, LSL #32
    MOVK  X13, #0x8ec, LSL #48
    MOVZ  X14, #0x3e6f, LSL #0
    MOVK  X14, #0xd683, LSL #16
    MOVK  X14, #0x19a7, LSL #32
    MOVK  X14, #0xb924, LSL #48
    MOVZ  X15, #0x7c4f, LSL #0
    MOVK  X15, #0xd5f5, LSL #16
    MOVK  X15, #0xd904, LSL #32
    MOVK  X15, #0x31f5, LSL #48
    MOVZ  X16, #0x8caa, LSL #0
    MOVK  X16, #0xa0f9, LSL #16
    MOVK  X16, #0x96bb, LSL #32
    MOVK  X16, #0xf4c1, LSL #48
    MOVZ  X17, #0x3956, LSL #0
    MOVK  X17, #0xa10a, LSL #16
    MOVK  X17, #0xa5f, LSL #32
    MOVK  X17, #0xb620, LSL #48
    MOVZ  X18, #0xb85, LSL #0
    MOVK  X18, #0xf8b6, LSL #16
    MOVK  X18, #0xaa49, LSL #32
    MOVK  X18, #0xa8ac, LSL #48
    MOVZ  X19, #0x46d0, LSL #0
    MOVK  X19, #0xbd1, LSL #16
    MOVK  X19, #0xec46, LSL #32
    MOVK  X19, #0x23a8, LSL #48
    MOVZ  X21, #0x145d, LSL #0
    MOVK  X21, #0xb3dc, LSL #16
    MOVK  X21, #0x7843, LSL #32
    MOVK  X21, #0x8d23, LSL #48
    MOVZ  X22, #0x79da, LSL #0
    MOVK  X22, #0xc76f, LSL #16
    MOVK  X22, #0x7361, LSL #32
    MOVK  X22, #0xc7d9, LSL #48
    MOVZ  X24, #0x116f, LSL #0
    MOVK  X24, #0xe1b, LSL #16
    MOVK  X24, #0xe218, LSL #32
    MOVK  X24, #0x704f, LSL #48
    MOVZ  X25, #0xa29, LSL #0
    MOVK  X25, #0xe2ac, LSL #16
    MOVK  X25, #0x8c28, LSL #32
    MOVK  X25, #0x42b7, LSL #48
    MOVZ  X27, #0x65e1, LSL #0
    MOVK  X27, #0x333f, LSL #16
    MOVK  X27, #0x6886, LSL #32
    MOVK  X27, #0xc2e4, LSL #48
    MOVZ  X28, #0xe413, LSL #0
    MOVK  X28, #0x6efc, LSL #16
    MOVK  X28, #0xab9d, LSL #32
    MOVK  X28, #0x437e, LSL #48
    MOVZ  X29, #0x7bfd, LSL #0
    MOVK  X29, #0x9376, LSL #16
    MOVK  X29, #0x4d48, LSL #32
    MOVK  X29, #0xb49e, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X5
    FMOV  V2.D[1], X11
    FMOV  D3, X9
    FMOV  V3.D[1], X24
    FMOV  D4, X6
    FMOV  V4.D[1], X10
    FMOV  D5, X4
    FMOV  V5.D[1], X27
    FMOV  D6, X2
    FMOV  V6.D[1], X27
    FMOV  D7, X29
    FMOV  V7.D[1], X9
    FMOV  D8, X9
    FMOV  V8.D[1], X3
    FMOV  D9, X5
    FMOV  V9.D[1], X15
    FMOV  D10, X28
    FMOV  V10.D[1], X22
    FMOV  D11, X22
    FMOV  V11.D[1], X18
    FMOV  D12, X17
    FMOV  V12.D[1], X19
    FMOV  D13, X4
    FMOV  V13.D[1], X21
    FMOV  D14, X5
    FMOV  V14.D[1], X4
    FMOV  D15, X18
    FMOV  V15.D[1], X19
    FMOV  D16, X24
    FMOV  V16.D[1], X4
    FMOV  D17, X11
    FMOV  V17.D[1], X19
    FMOV  D18, X19
    FMOV  V18.D[1], X11
    FMOV  D19, X9
    FMOV  V19.D[1], X29
    FMOV  D20, X27
    FMOV  V20.D[1], X15
    FMOV  D21, X4
    FMOV  V21.D[1], X5
    FMOV  D22, X2
    FMOV  V22.D[1], X13
    FMOV  D23, X2
    FMOV  V23.D[1], X3
    FMOV  D24, X6
    FMOV  V24.D[1], X16
    FMOV  D25, X11
    FMOV  V25.D[1], X6
    FMOV  D26, X27
    FMOV  V26.D[1], X14
    FMOV  D27, X5
    FMOV  V27.D[1], X19
    FMOV  D28, X24
    FMOV  V28.D[1], X16
    FMOV  D29, X16
    FMOV  V29.D[1], X7
    FMOV  D30, X7
    FMOV  V30.D[1], X29
    FMOV  D31, X21
    FMOV  V31.D[1], X3
    MOVZ  X16, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_18:
    FRINTP  S3, S17
    FRINTI  H21, H27
    FRINTM  S16, S19
    FRINTA  D13, D30
    FRINTM  S1, S26
    FRINTP  H15, H29
    FRINTZ  S2, S16
    FRINTP  D16, D31
    FRINTN  D21, D3
    FRINTI  H13, H28
    FRINTP  D11, D1
    FRINTA  H22, H23
    FRINTN  D15, D2
    FRINTN  S9, S22
    FRINTN  S15, S21
    FRINTZ  S0, S13
    FRINTX  S1, S15
    FRINTZ  H30, H16
    FRINTP  S19, S9
    FRINTI  H26, H19
    FRINTP  D9, D11
    FRINTM  H28, H24
    FRINTP  H22, H0
    FRINTP  S3, S1
    FRINTM  S15, S3
    FRINTN  D17, D15
    FRINTZ  S19, S7
    FRINTM  D3, D9
    FRINTP  H7, H19
    FRINTA  D16, D30
    FRINTN  S2, S16
    FRINTM  D19, D22
    FRINTN  H13, H17
    FRINTI  D22, D26
    FRINTP  D30, D3
    FRINTZ  D15, D13
    FRINTZ  H21, H28
    FRINTX  S23, S21
    FRINTA  S0, S30
    FRINTP  S21, S26
    FRINTI  H1, H0
    FRINTM  H17, H1
    FRINTM  D0, D2
    FRINTI  D9, D2
    FRINTM  H16, H0
    FRINTI  S13, S22
    FRINTI  D1, D19
    FRINTA  H26, H16
    FRINTP  S2, S26
    FRINTA  D26, D21
    FRINTP  H21, H26
    FRINTN  S0, S1
    FRINTI  H3, H21
    FRINTI  H0, H17
    FRINTA  D1, D9
    FRINTX  D21, D23
    FRINTI  D16, D3
    FRINTM  D22, D0
    FRINTI  H28, H16
    FRINTA  D30, D21
    FRINTP  S21, S28
    FRINTN  S23, S1
    FRINTI  S16, S22
    FRINTX  H20, H15
    FRINTI  S17, S20
    FRINTZ  H3, H2
    FRINTA  S9, S16
    FRINTI  D19, D3
    FRINTX  D0, D19
    FRINTP  S28, S23
    FRINTA  H2, H0
    FRINTN  D1, D13
    FRINTI  S13, S21
    FRINTX  S20, S9
    FRINTA  S19, S13
    FRINTA  D15, D19
    FRINTM  H19, H28
    FRINTM  S16, S24
    FRINTM  H24, H20
    FRINTN  D20, D30
    FRINTM  H0, H17
    FRINTN  H30, H19
    FRINTZ  D22, D1
    FRINTN  D19, D16
    FRINTA  D1, D1
    FRINTZ  D28, D2
    FRINTA  D21, D28
    FRINTA  D17, D22
    FRINTI  H23, H17
    FRINTI  S17, S15
    FRINTZ  H15, H21
    FRINTZ  S13, S23
    FRINTP  D23, D13
    FRINTA  D16, D30
    FRINTI  H2, H0
    FRINTI  H13, H17
    FRINTN  S21, S16
    FRINTN  H3, H21
    FRINTM  S17, S20
    FRINTA  H9, H19
    FRINTA  S0, S24
    FRINTN  S20, S2
    FRINTA  S21, S20
    FRINTA  D22, D13
    FRINTN  D28, D1
    FRINTA  H24, H3
    FRINTP  D19, D24
    FRINTZ  H3, H9
    FRINTP  H20, H11
    FRINTX  S30, S22
    FRINTP  S1, S23
    FRINTM  S24, S15
    FRINTZ  H1, H20
    FRINTX  H9, H21
    FRINTM  S22, S27
    FRINTX  D27, D19
    FRINTP  S19, S28
    FRINTI  S2, S24
    FRINTX  S11, S19
    FRINTA  H13, H11
    FRINTP  D21, D1
    FRINTZ  D11, D30
    FRINTX  D20, D11
    FRINTP  S11, S20
    FRINTI  S30, S27
    FRINTI  D19, D3
    FRINTX  H24, H19
    FRINTX  D19, D21
    FRINTN  H15, H13
    FRINTX  H21, H0
    FRINTI  H23, H6
    FRINTA  H20, H21
    FRINTM  H21, H9
    FRINTP  D3, D2
    FRINTM  H27, H3
    FRINTZ  H29, H22
    FRINTM  D22, D20
    FRINTM  D1, D27
    FRINTZ  S13, S30
    FRINTP  H0, H15
    FRINTX  D30, D13
    FRINTX  H6, H21
    FRINTP  D9, D29
    FRINTI  H29, H11
    FRINTZ  S21, S23
    FRINTM  S11, S4
    FRINTN  H3, H22
    FRINTA  H4, H21
    FRINTP  S21, S24
    FRINTN  D22, D1
    FRINTI  D2, D30
    FRINTX  S15, S2
    FRINTI  H23, H15
    FRINTI  H31, H19
    FRINTN  S13, S5
    FRINTM  S24, S21
    FRINTZ  H15, H16
    FRINTM  H30, H22
    FRINTI  D1, D24
    FRINTI  D16, D11
    FRINTM  S11, S1
    FRINTI  H24, H23
    FRINTA  H2, H30
    FRINTN  D19, D15
    FRINTN  S15, S29
    FRINTM  S1, S16
    FRINTN  D16, D4
    FRINTA  H29, H15
    FRINTX  S30, S24
    FRINTI  S21, S16
    FRINTP  H23, H3
    FRINTP  D3, D30
    FRINTX  S5, S11
    FRINTZ  S4, S21
    FRINTM  S30, S29
    FRINTI  H22, H2
    FRINTI  H21, H23
    FRINTA  D29, D30
    FRINTZ  H15, H1
    FRINTP  H24, H5
    FRINTI  D2, D3
    FRINTN  H11, H22
    FRINTI  D22, D4
    FRINTN  H16, H11
    FRINTP  S3, S21
    FRINTZ  D23, D3
    FRINTP  D3, D16
    FRINTZ  S16, S2
    FRINTN  S2, S23
    FRINTA  H23, H2
    FRINTX  H4, H16
    FRINTA  H5, H15
    FRINTI  H11, H4
    FRINTI  D16, D22
    FRINTN  H21, H23
    FRINTX  D23, D5
    FRINTM  D30, D24
    FRINTI  D2, D29
    FRINTA  S29, S11
    FRINTI  D4, D16
    SUBS  X16, X16, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_18
    MOVZ  X13, #0xc7b2, LSL #0
    MOVK  X13, #0x1e6d, LSL #16
    MOVK  X13, #0x754d, LSL #32
    MOVK  X13, #0x5905, LSL #48
    SUB  X22, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0xe049, LSL #0
    MOVK  X13, #0x449d, LSL #16
    MOVK  X13, #0xca00, LSL #32
    MOVK  X13, #0x3dd5, LSL #48
    SUB  X22, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x722, LSL #0
    MOVK  X13, #0xd9cf, LSL #16
    MOVK  X13, #0x8f14, LSL #32
    MOVK  X13, #0x3bc1, LSL #48
    SUB  X22, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x1720, LSL #0
    MOVK  X13, #0x14c6, LSL #16
    MOVK  X13, #0xa648, LSL #32
    MOVK  X13, #0xedc4, LSL #48
    SUB  X22, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x2a75, LSL #0
    MOVK  X13, #0x86e0, LSL #16
    MOVK  X13, #0xb01b, LSL #32
    MOVK  X13, #0x7ca, LSL #48
    SUB  X22, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x93d1, LSL #0
    MOVK  X13, #0x488b, LSL #16
    MOVK  X13, #0xbaa2, LSL #32
    MOVK  X13, #0x789a, LSL #48
    SUB  X22, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x3e11, LSL #0
    MOVK  X13, #0xc3cb, LSL #16
    MOVK  X13, #0x428e, LSL #32
    MOVK  X13, #0xeff7, LSL #48
    SUB  X22, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x416c, LSL #0
    MOVK  X13, #0xce2e, LSL #16
    MOVK  X13, #0x54c, LSL #32
    MOVK  X13, #0xecc0, LSL #48
    SUB  X22, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x2f17, LSL #0
    MOVK  X13, #0xeeaf, LSL #16
    MOVK  X13, #0xd175, LSL #32
    MOVK  X13, #0xb9af, LSL #48
    SUB  X22, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x3e6f, LSL #0
    MOVK  X13, #0xd683, LSL #16
    MOVK  X13, #0x19a7, LSL #32
    MOVK  X13, #0xb924, LSL #48
    SUB  X22, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x7c4f, LSL #0
    MOVK  X13, #0xd5f5, LSL #16
    MOVK  X13, #0xd904, LSL #32
    MOVK  X13, #0x31f5, LSL #48
    SUB  X22, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x3956, LSL #0
    MOVK  X13, #0xa10a, LSL #16
    MOVK  X13, #0xa5f, LSL #32
    MOVK  X13, #0xb620, LSL #48
    SUB  X22, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0xb85, LSL #0
    MOVK  X13, #0xf8b6, LSL #16
    MOVK  X13, #0xaa49, LSL #32
    MOVK  X13, #0xa8ac, LSL #48
    SUB  X22, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x46d0, LSL #0
    MOVK  X13, #0xbd1, LSL #16
    MOVK  X13, #0xec46, LSL #32
    MOVK  X13, #0x23a8, LSL #48
    SUB  X22, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x145d, LSL #0
    MOVK  X13, #0xb3dc, LSL #16
    MOVK  X13, #0x7843, LSL #32
    MOVK  X13, #0x8d23, LSL #48
    SUB  X22, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x116f, LSL #0
    MOVK  X13, #0xe1b, LSL #16
    MOVK  X13, #0xe218, LSL #32
    MOVK  X13, #0x704f, LSL #48
    SUB  X22, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0xa29, LSL #0
    MOVK  X13, #0xe2ac, LSL #16
    MOVK  X13, #0x8c28, LSL #32
    MOVK  X13, #0x42b7, LSL #48
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x65e1, LSL #0
    MOVK  X13, #0x333f, LSL #16
    MOVK  X13, #0x6886, LSL #32
    MOVK  X13, #0xc2e4, LSL #48
    SUB  X22, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0xe413, LSL #0
    MOVK  X13, #0x6efc, LSL #16
    MOVK  X13, #0xab9d, LSL #32
    MOVK  X13, #0x437e, LSL #48
    SUB  X22, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x7bfd, LSL #0
    MOVK  X13, #0x9376, LSL #16
    MOVK  X13, #0x4d48, LSL #32
    MOVK  X13, #0xb49e, LSL #48
    SUB  X22, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x10, LSL #0
    MRS  X22, FPSR
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D0
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V1.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D1
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D2
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D3
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D4
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D5
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D6
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D7
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0xe049, LSL #0
    MOVK  X13, #0x449d, LSL #16
    MOVK  X13, #0xca00, LSL #32
    MOVK  X13, #0x3dd5, LSL #48
    FMOV  X22, V8.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0xc589, LSL #0
    MOVK  X13, #0xa7d, LSL #16
    MOVK  X13, #0x9cd6, LSL #32
    MOVK  X13, #0xf919, LSL #48
    FMOV  X22, D8
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D9
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x79da, LSL #0
    MOVK  X13, #0xc76f, LSL #16
    MOVK  X13, #0x7361, LSL #32
    MOVK  X13, #0xc7d9, LSL #48
    FMOV  X22, V10.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0xe413, LSL #0
    MOVK  X13, #0x6efc, LSL #16
    MOVK  X13, #0xab9d, LSL #32
    MOVK  X13, #0x437e, LSL #48
    FMOV  X22, D10
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D11
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x46d0, LSL #0
    MOVK  X13, #0xbd1, LSL #16
    MOVK  X13, #0xec46, LSL #32
    MOVK  X13, #0x23a8, LSL #48
    FMOV  X22, V12.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x3956, LSL #0
    MOVK  X13, #0xa10a, LSL #16
    MOVK  X13, #0xa5f, LSL #32
    MOVK  X13, #0xb620, LSL #48
    FMOV  X22, D12
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D13
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x722, LSL #0
    MOVK  X13, #0xd9cf, LSL #16
    MOVK  X13, #0x8f14, LSL #32
    MOVK  X13, #0x3bc1, LSL #48
    FMOV  X22, V14.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x1720, LSL #0
    MOVK  X13, #0x14c6, LSL #16
    MOVK  X13, #0xa648, LSL #32
    MOVK  X13, #0xedc4, LSL #48
    FMOV  X22, D14
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D15
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D16
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D17
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x416c, LSL #0
    MOVK  X13, #0xce2e, LSL #16
    MOVK  X13, #0x54c, LSL #32
    MOVK  X13, #0xecc0, LSL #48
    FMOV  X22, V18.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x46d0, LSL #0
    MOVK  X13, #0xbd1, LSL #16
    MOVK  X13, #0xec46, LSL #32
    MOVK  X13, #0x23a8, LSL #48
    FMOV  X22, D18
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D20
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D21
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D22
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D23
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x2a75, LSL #0
    MOVK  X13, #0x86e0, LSL #16
    MOVK  X13, #0xb01b, LSL #32
    MOVK  X13, #0x7ca, LSL #48
    FMOV  X22, V25.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x416c, LSL #0
    MOVK  X13, #0xce2e, LSL #16
    MOVK  X13, #0x54c, LSL #32
    MOVK  X13, #0xecc0, LSL #48
    FMOV  X22, D25
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D26
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D27
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D28
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D29
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D30
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, D31
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X13
    FMOV  V0.D[1], X22
    FMOV  D1, X11
    FMOV  V1.D[1], X6
    FMOV  D2, X12
    FMOV  V2.D[1], X18
    FMOV  D3, X17
    FMOV  V3.D[1], X15
    FMOV  D4, X29
    FMOV  V4.D[1], X5
    FMOV  D5, X19
    FMOV  V5.D[1], X27
    FMOV  D6, X28
    FMOV  V6.D[1], X16
    FMOV  D7, X25
    FMOV  V7.D[1], X24
    FMOV  D8, X21
    FMOV  V8.D[1], X6
    FMOV  D9, X12
    FMOV  V9.D[1], X13
    FMOV  D10, X22
    FMOV  V10.D[1], X15
    FMOV  D11, X25
    FMOV  V11.D[1], X29
    FMOV  D12, X25
    FMOV  V12.D[1], X16
    FMOV  D13, X18
    FMOV  V13.D[1], X13
    FMOV  D14, X10
    FMOV  V14.D[1], X16
    FMOV  D15, X11
    FMOV  V15.D[1], X5
    FMOV  D16, X5
    FMOV  V16.D[1], X28
    FMOV  D17, X13
    FMOV  V17.D[1], X6
    FMOV  D18, X17
    FMOV  V18.D[1], X7
    FMOV  D19, X16
    FMOV  V19.D[1], X5
    FMOV  D20, X2
    FMOV  V20.D[1], X6
    FMOV  D21, X22
    FMOV  V21.D[1], X6
    FMOV  D22, X4
    FMOV  V22.D[1], X21
    FMOV  D23, X15
    FMOV  V23.D[1], X10
    FMOV  D24, X7
    FMOV  V24.D[1], X6
    FMOV  D25, X17
    FMOV  V25.D[1], X21
    FMOV  D26, X5
    FMOV  V26.D[1], X28
    FMOV  D27, X21
    FMOV  V27.D[1], X5
    FMOV  D28, X11
    FMOV  V28.D[1], X21
    FMOV  D29, X21
    FMOV  V29.D[1], X3
    FMOV  D30, X21
    FMOV  V30.D[1], X24
    FMOV  D31, X25
    FMOV  V31.D[1], X13
    MOVZ  X6, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_19:
    FRINTX  S21, S27
    FRINTN  S2, S24
    FRINTP  D0, D18
    FRINTA  H15, H31
    FRINTZ  H3, H29
    FRINTZ  H28, H25
    FRINTI  S23, S2
    FRINTA  H15, H30
    FRINTI  H11, H21
    FRINTX  S24, S0
    FRINTA  H20, H24
    FRINTN  H31, H3
    FRINTA  H27, H31
    FRINTI  S12, S28
    FRINTA  D3, D11
    FRINTX  S1, S23
    FRINTP  D12, D15
    FRINTX  H9, H20
    FRINTA  H8, H9
    FRINTI  D20, D26
    FRINTZ  D29, D1
    FRINTM  D26, D29
    FRINTZ  S24, S3
    FRINTZ  D30, D27
    FRINTZ  D9, D12
    FRINTA  D29, D24
    FRINTX  S24, S21
    FRINTM  D28, D30
    FRINTN  H31, H20
    FRINTN  S23, S31
    FRINTX  H21, H23
    FRINTA  S1, S26
    FRINTZ  D11, D21
    FRINTM  H23, H28
    FRINTP  S15, S23
    FRINTX  H21, H15
    FRINTN  H2, H8
    FRINTX  S26, S1
    FRINTM  H30, H23
    FRINTX  D8, D21
    FRINTA  D15, D11
    FRINTP  D12, D2
    FRINTN  D9, D30
    FRINTA  H27, H15
    FRINTX  S23, S26
    FRINTA  D2, D24
    FRINTP  D31, D8
    FRINTX  H1, H12
    FRINTZ  D12, D9
    FRINTZ  S26, S23
    FRINTM  S8, S2
    FRINTP  D30, D1
    FRINTX  S21, S30
    FRINTP  H20, H21
    FRINTN  S11, S27
    FRINTA  S1, S11
    FRINTN  S9, S26
    FRINTA  H24, H9
    FRINTA  H9, H31
    FRINTZ  S26, S20
    FRINTX  S30, S26
    FRINTI  S26, S8
    FRINTP  H20, H24
    FRINTN  D23, D30
    FRINTZ  H21, H9
    FRINTM  D24, D12
    FRINTA  S11, S20
    FRINTP  S31, S11
    FRINTX  S20, S1
    FRINTI  H27, H23
    FRINTX  S9, S26
    FRINTM  S26, S27
    FRINTN  H11, H26
    FRINTX  S8, S31
    FRINTN  D1, D24
    FRINTM  S26, S30
    FRINTZ  D12, D21
    FRINTZ  H21, H8
    FRINTI  D27, D11
    FRINTI  H11, H20
    FRINTA  H23, H26
    FRINTP  S31, S18
    FRINTA  S24, S9
    FRINTN  S30, S23
    FRINTI  D8, D27
    FRINTA  D9, D12
    FRINTZ  D12, D11
    FRINTA  S20, S21
    FRINTN  S26, S25
    FRINTA  S11, S24
    FRINTM  S18, S12
    FRINTA  S12, S20
    FRINTN  S27, S6
    FRINTI  H19, H9
    FRINTM  H20, H27
    FRINTN  S24, S31
    FRINTZ  H23, H24
    FRINTX  D31, D23
    FRINTZ  D0, D11
    FRINTM  D21, D12
    FRINTX  H8, H20
    FRINTN  D20, D31
    FRINTI  D24, D18
    FRINTX  S25, S26
    FRINTN  H12, H8
    FRINTZ  S18, S12
    FRINTN  D12, D20
    FRINTN  H6, H21
    FRINTX  S20, S6
    FRINTX  H8, H24
    FRINTX  D26, D19
    FRINTA  S11, S18
    FRINTA  H23, H0
    FRINTZ  S9, S30
    FRINTZ  D31, D25
    FRINTN  S30, S9
    FRINTN  D9, D26
    FRINTZ  S0, S11
    FRINTX  D6, D12
    FRINTX  H25, H3
    FRINTM  S27, S20
    FRINTM  D26, D8
    FRINTI  H8, H25
    FRINTI  H19, H31
    FRINTX  S21, S27
    FRINTI  S12, S0
    FRINTA  S11, S26
    FRINTI  H18, H21
    FRINTI  S3, S23
    FRINTA  S25, S30
    FRINTI  D20, D9
    FRINTZ  D9, D19
    FRINTZ  D19, D18
    FRINTZ  D27, D25
    FRINTI  D25, D3
    FRINTA  H26, H11
    FRINTN  S31, S11
    FRINTA  H30, H8
    FRINTP  S24, S9
    FRINTZ  S0, S12
    FRINTP  D23, D24
    FRINTX  H21, H0
    FRINTZ  D9, D19
    FRINTZ  H19, H6
    FRINTX  D11, D26
    FRINTZ  S18, S21
    FRINTI  D12, D20
    FRINTA  H8, H9
    FRINTA  H24, H23
    FRINTX  H3, H30
    FRINTX  H23, H12
    FRINTI  S13, S23
    FRINTN  H6, H24
    FRINTN  S0, S31
    FRINTZ  H31, H19
    FRINTP  D24, D3
    FRINTN  D31, D0
    FRINTX  S12, S13
    FRINTZ  S26, S11
    FRINTM  S19, S25
    FRINTN  S20, S18
    FRINTM  H30, H8
    FRINTN  S9, S19
    FRINTX  D3, D26
    FRINTI  D0, D6
    FRINTP  H21, H30
    FRINTX  S18, S21
    FRINTM  H21, H18
    FRINTI  H26, H24
    FRINTN  D30, D0
    FRINTP  D24, D21
    FRINTI  D13, D12
    FRINTM  H12, H24
    FRINTA  D8, D3
    FRINTP  S0, S31
    FRINTP  D23, D20
    FRINTZ  H20, H0
    FRINTZ  H24, H20
    FRINTZ  H20, H26
    FRINTZ  D21, D15
    FRINTN  S0, S21
    FRINTA  D6, D9
    FRINTN  S3, S23
    FRINTP  S31, S30
    FRINTA  D21, D13
    FRINTN  D18, D8
    FRINTZ  D25, D12
    FRINTA  S13, S0
    FRINTP  D11, D3
    FRINTN  S15, S13
    FRINTX  S26, S18
    FRINTN  H9, H21
    FRINTX  H13, H9
    FRINTX  D9, D31
    FRINTI  S23, S9
    FRINTA  H30, H19
    FRINTX  H8, H6
    FRINTI  D12, D26
    FRINTX  D31, D13
    FRINTX  D26, D25
    SUBS  X6, X6, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_19
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x10, LSL #0
    MRS  X11, FPSR
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V0.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D0
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D1
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D2
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D3
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D4
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V5.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D5
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V6.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D6
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D7
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D8
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V9.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D9
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D10
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D11
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D12
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D13
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D14
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D15
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D16
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D17
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V18.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D18
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D19
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D20
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D21
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D22
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D23
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D24
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D25
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D26
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D27
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D28
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D29
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D30
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X11, D31
    SUB  X15, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatFloatPointRoundToInteger_TestFail
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
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X19
    FMOV  D3, X18
    FMOV  V3.D[1], X28
    FMOV  D4, X5
    FMOV  V4.D[1], X6
    FMOV  D5, X14
    FMOV  V5.D[1], X6
    FMOV  D6, X9
    FMOV  V6.D[1], X5
    FMOV  D7, X29
    FMOV  V7.D[1], X29
    FMOV  D8, X11
    FMOV  V8.D[1], X3
    FMOV  D9, X14
    FMOV  V9.D[1], X9
    FMOV  D10, X29
    FMOV  V10.D[1], X22
    FMOV  D11, X25
    FMOV  V11.D[1], X22
    FMOV  D12, X12
    FMOV  V12.D[1], X9
    FMOV  D13, X14
    FMOV  V13.D[1], X12
    FMOV  D14, X9
    FMOV  V14.D[1], X18
    FMOV  D15, X4
    FMOV  V15.D[1], X17
    FMOV  D16, X14
    FMOV  V16.D[1], X16
    FMOV  D17, X28
    FMOV  V17.D[1], X10
    FMOV  D18, X28
    FMOV  V18.D[1], X6
    FMOV  D19, X29
    FMOV  V19.D[1], X5
    FMOV  D20, X28
    FMOV  V20.D[1], X18
    FMOV  D21, X4
    FMOV  V21.D[1], X12
    FMOV  D22, X19
    FMOV  V22.D[1], X14
    FMOV  D23, X18
    FMOV  V23.D[1], X11
    FMOV  D24, X14
    FMOV  V24.D[1], X21
    FMOV  D25, X2
    FMOV  V25.D[1], X10
    FMOV  D26, X15
    FMOV  V26.D[1], X29
    FMOV  D27, X7
    FMOV  V27.D[1], X22
    FMOV  D28, X28
    FMOV  V28.D[1], X14
    FMOV  D29, X13
    FMOV  V29.D[1], X16
    FMOV  D30, X11
    FMOV  V30.D[1], X21
    FMOV  D31, X18
    FMOV  V31.D[1], X27
    MOVZ  X6, #0xf, LSL #0
TSRTFloatFloatPointRoundToInteger_label_20:
    FRINTX  H2, H26
    FRINTA  S16, S27
    FRINTN  S8, S24
    FRINTZ  H6, H30
    FRINTX  H15, H8
    FRINTI  H1, H25
    FRINTN  D0, D2
    FRINTX  H30, H29
    FRINTM  D23, D22
    FRINTP  S17, S31
    FRINTN  S7, S16
    FRINTI  S8, S6
    FRINTZ  H27, H11
    FRINTM  D16, D0
    FRINTA  D3, D28
    FRINTM  H4, H30
    FRINTX  D20, D7
    FRINTN  S14, S4
    FRINTN  S10, S20
    FRINTZ  D7, D10
    FRINTA  H25, H14
    FRINTI  S0, S16
    FRINTA  D22, D0
    FRINTA  H0, H22
    FRINTM  S20, S1
    FRINTM  D4, D15
    FRINTM  H22, H12
    FRINTN  S16, S27
    FRINTX  D14, D22
    FRINTI  D10, D4
    FRINTI  H27, H17
    FRINTM  D6, D8
    FRINTA  D30, D6
    FRINTA  S17, S20
    FRINTI  H12, H0
    FRINTX  H22, H30
    FRINTA  S1, S3
    FRINTN  H11, H17
    FRINTX  H17, H27
    FRINTM  S20, S10
    FRINTX  S30, S17
    FRINTN  D17, D22
    FRINTN  D4, D14
    FRINTX  H10, H12
    FRINTM  D3, D1
    FRINTP  D1, D4
    FRINTP  S4, S1
    FRINTI  D14, D25
    FRINTM  D1, D4
    FRINTN  H8, H14
    FRINTZ  H27, H20
    FRINTM  S20, S10
    FRINTZ  D12, D30
    FRINTA  D10, D11
    FRINTM  H15, H17
    FRINTP  S17, S3
    FRINTX  D3, D16
    FRINTX  S22, S27
    FRINTM  D30, D1
    FRINTN  S4, S3
    FRINTI  S3, S8
    FRINTZ  D25, D3
    FRINTM  S16, S10
    FRINTI  S11, S22
    FRINTI  D1, D30
    FRINTA  H10, H1
    FRINTZ  D27, D17
    FRINTA  H3, H4
    FRINTA  D8, D25
    FRINTP  H22, H27
    FRINTA  H30, H3
    FRINTM  D1, D22
    FRINTZ  D22, D30
    FRINTZ  S4, S16
    FRINTP  D16, D11
    FRINTP  D11, D8
    FRINTX  D8, D1
    FRINTM  D25, D15
    FRINTN  H15, H20
    FRINTN  H27, H22
    FRINTP  S17, S15
    FRINTP  S20, S25
    FRINTI  D17, D4
    FRINTA  H4, H10
    FRINTN  H22, H4
    FRINTM  D1, D16
    FRINTA  D3, D27
    FRINTZ  H27, H1
    FRINTN  H15, H27
    FRINTM  S19, S17
    FRINTM  S30, S22
    FRINTP  S22, S0
    FRINTN  D0, D30
    FRINTZ  S16, S15
    FRINTX  S10, S16
    FRINTN  H4, H4
    FRINTP  D1, D3
    FRINTP  S30, S20
    FRINTA  S16, S0
    FRINTZ  H25, H4
    FRINTN  S17, S1
    FRINTN  H15, H22
    FRINTN  S14, S15
    FRINTM  S22, S8
    FRINTI  S15, S17
    FRINTN  H3, H30
    FRINTZ  S4, S3
    FRINTX  H27, H15
    FRINTX  S15, S16
    FRINTA  D17, D25
    FRINTZ  S25, S27
    FRINTX  H27, H14
    FRINTI  H3, H19
    FRINTZ  H0, H27
    FRINTN  H14, H4
    FRINTA  S27, S22
    FRINTN  D19, D0
    FRINTN  S22, S17
    FRINTA  D1, D22
    FRINTP  S20, S1
    FRINTN  D1, D15
    FRINTI  S8, S27
    FRINTI  D0, D25
    FRINTP  H25, H0
    FRINTI  D15, D3
    FRINTA  H0, H15
    FRINTX  D15, D19
    FRINTN  D16, D14
    FRINTX  D30, D20
    FRINTN  S3, S8
    FRINTP  D4, D25
    FRINTZ  D22, D0
    FRINTZ  D25, D22
    FRINTP  H27, H3
    FRINTI  H17, H1
    FRINTZ  D3, D17
    FRINTP  H22, H27
    FRINTM  H1, H15
    FRINTA  D8, D4
    FRINTI  H17, H13
    FRINTX  H27, H25
    FRINTI  S20, S3
    FRINTM  H14, H8
    FRINTI  H31, H17
    FRINTP  D18, D20
    FRINTM  H19, H18
    FRINTZ  H3, H30
    FRINTI  D15, D27
    FRINTA  S27, S22
    FRINTM  H0, H3
    FRINTI  D8, D16
    FRINTZ  D13, D27
    FRINTN  D4, D19
    FRINTA  H16, H14
    FRINTZ  S17, S31
    FRINTP  H30, H4
    FRINTM  H22, H28
    FRINTP  D28, D16
    FRINTP  S3, S1
    FRINTA  D25, D3
    FRINTI  H3, H15
    FRINTM  D15, D25
    FRINTA  D19, D28
    FRINTP  D1, D30
    FRINTI  D31, D8
    FRINTN  S25, S15
    FRINTX  H14, H6
    FRINTM  H27, H17
    FRINTX  S16, S13
    FRINTA  H18, H0
    FRINTM  H15, H1
    FRINTP  S28, S27
    FRINTI  S30, S14
    FRINTX  H8, H3
    FRINTA  D27, D16
    FRINTZ  H0, H28
    FRINTI  S16, S19
    FRINTA  H6, H25
    FRINTZ  H25, H18
    FRINTX  H28, H16
    FRINTX  H17, H0
    FRINTP  S13, S31
    FRINTM  D31, D13
    FRINTN  H13, H31
    FRINTN  D19, D15
    FRINTN  H3, H22
    FRINTI  S14, S4
    FRINTM  H18, H17
    FRINTN  H4, H25
    FRINTX  D23, D28
    FRINTM  D17, D8
    FRINTA  H22, H6
    FRINTX  S6, S19
    FRINTP  S19, S13
    FRINTA  D13, D22
    FRINTZ  H0, H18
    FRINTM  H15, H13
    FRINTA  S8, S14
    FRINTM  H22, H15
    FRINTN  D31, D4
    SUBS  X6, X6, #0x1
    B.NE  TSRTFloatFloatPointRoundToInteger_label_20
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X28, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x10, LSL #0
    MRS  X28, FPSR
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D0
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D1
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    FMOV  X28, D2
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D3
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D4
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, D5
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D6
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D7
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D8
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, D9
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D10
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D11
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D12
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D13
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D14
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D15
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D16
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D17
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D18
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D19
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D20
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, V21.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, D21
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D22
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D23
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, D24
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D25
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, D26
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D27
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D28
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, V29.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X28, D29
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D30
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V31.D[1]
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, D31
    SUB  X4, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatFloatPointRoundToInteger_TestFail

TSRTFloatFloatPointRoundToInteger_TestEnd:
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
TSRTFloatFloatPointRoundToInteger_TestFail:
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
