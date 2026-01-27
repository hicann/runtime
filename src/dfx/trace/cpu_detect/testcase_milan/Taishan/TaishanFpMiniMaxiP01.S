.global TaishanFpMiniMaxiP01

.text
.p2align 4

TaishanFpMiniMaxiP01:

TaishanFpMiniMaxiP01_TestBegin:
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
    MOVK  X2, #0x619a, LSL #48
    MOVK  X2, #0xe3f, LSL #32
    MOVK  X2, #0xb65, LSL #16
    MOVK  X2, #0xf8f2, LSL #0
    MOVK  X3, #0xcca8, LSL #48
    MOVK  X3, #0x9373, LSL #32
    MOVK  X3, #0xa6e0, LSL #16
    MOVK  X3, #0x5a61, LSL #0
    MOVK  X4, #0x2558, LSL #48
    MOVK  X4, #0xebe3, LSL #32
    MOVK  X4, #0xa80, LSL #16
    MOVK  X4, #0x1b95, LSL #0
    MOVK  X5, #0x791, LSL #48
    MOVK  X5, #0x6484, LSL #32
    MOVK  X5, #0x5f83, LSL #16
    MOVK  X5, #0xddf, LSL #0
    MOVK  X6, #0x78b6, LSL #48
    MOVK  X6, #0xd703, LSL #32
    MOVK  X6, #0xe369, LSL #16
    MOVK  X6, #0xa4b4, LSL #0
    MOVK  X7, #0xadb, LSL #48
    MOVK  X7, #0xcce8, LSL #32
    MOVK  X7, #0x9020, LSL #16
    MOVK  X7, #0x2fd4, LSL #0
    MOVK  X8, #0xc1f7, LSL #48
    MOVK  X8, #0xa889, LSL #32
    MOVK  X8, #0xd858, LSL #16
    MOVK  X8, #0xba8d, LSL #0
    MOVK  X9, #0xa3fd, LSL #48
    MOVK  X9, #0x281, LSL #32
    MOVK  X9, #0x631a, LSL #16
    MOVK  X9, #0x8b7b, LSL #0
    MOVK  X10, #0xe5c8, LSL #48
    MOVK  X10, #0x852f, LSL #32
    MOVK  X10, #0x3f53, LSL #16
    MOVK  X10, #0x1767, LSL #0
    MOVK  X11, #0xa00c, LSL #48
    MOVK  X11, #0xfb05, LSL #32
    MOVK  X11, #0x6ce6, LSL #16
    MOVK  X11, #0x5078, LSL #0
    MOVK  X12, #0x8ac9, LSL #48
    MOVK  X12, #0xd494, LSL #32
    MOVK  X12, #0x44ca, LSL #16
    MOVK  X12, #0x5873, LSL #0
    MOVK  X13, #0x7a53, LSL #48
    MOVK  X13, #0x532, LSL #32
    MOVK  X13, #0xfc97, LSL #16
    MOVK  X13, #0xefdb, LSL #0
    MOVK  X14, #0x25cd, LSL #48
    MOVK  X14, #0xd84f, LSL #32
    MOVK  X14, #0x7035, LSL #16
    MOVK  X14, #0x79ae, LSL #0
    MOVK  X15, #0x81ad, LSL #48
    MOVK  X15, #0x6498, LSL #32
    MOVK  X15, #0xbdda, LSL #16
    MOVK  X15, #0x4f52, LSL #0
    MOVK  X16, #0x3a46, LSL #48
    MOVK  X16, #0xcb50, LSL #32
    MOVK  X16, #0xf951, LSL #16
    MOVK  X16, #0x2484, LSL #0
    MOVK  X17, #0xf522, LSL #48
    MOVK  X17, #0x721c, LSL #32
    MOVK  X17, #0x7857, LSL #16
    MOVK  X17, #0xc154, LSL #0
    MOVK  X18, #0xfff0, LSL #48
    MOVK  X18, #0xbea1, LSL #32
    MOVK  X18, #0xd4d9, LSL #16
    MOVK  X18, #0x3581, LSL #0
    MOVK  X19, #0xcb82, LSL #48
    MOVK  X19, #0x28cd, LSL #32
    MOVK  X19, #0xd0af, LSL #16
    MOVK  X19, #0xa1a9, LSL #0
    MOVK  X20, #0xe24d, LSL #48
    MOVK  X20, #0x5657, LSL #32
    MOVK  X20, #0x156b, LSL #16
    MOVK  X20, #0x129e, LSL #0
    MOVK  X21, #0x3396, LSL #48
    MOVK  X21, #0x493f, LSL #32
    MOVK  X21, #0x9cb4, LSL #16
    MOVK  X21, #0x7b86, LSL #0
    MOVK  X22, #0x7749, LSL #48
    MOVK  X22, #0x8526, LSL #32
    MOVK  X22, #0x6a0a, LSL #16
    MOVK  X22, #0x790b, LSL #0
    MOVK  X23, #0x4f97, LSL #48
    MOVK  X23, #0x7c9e, LSL #32
    MOVK  X23, #0xf1ff, LSL #16
    MOVK  X23, #0xeaea, LSL #0
    MOVK  X24, #0x2200, LSL #48
    MOVK  X24, #0x70c5, LSL #32
    MOVK  X24, #0x1f7, LSL #16
    MOVK  X24, #0x7e32, LSL #0
    MOVK  X25, #0xed11, LSL #48
    MOVK  X25, #0x4822, LSL #32
    MOVK  X25, #0xba4a, LSL #16
    MOVK  X25, #0xb2c8, LSL #0
    MOVK  X26, #0x76f3, LSL #48
    MOVK  X26, #0x2705, LSL #32
    MOVK  X26, #0x856d, LSL #16
    MOVK  X26, #0xc6e1, LSL #0
    MOVK  X27, #0x943, LSL #48
    MOVK  X27, #0xd235, LSL #32
    MOVK  X27, #0xab9c, LSL #16
    MOVK  X27, #0x90fb, LSL #0
    MOVK  X28, #0x1ddc, LSL #48
    MOVK  X28, #0xb11d, LSL #32
    MOVK  X28, #0x841a, LSL #16
    MOVK  X28, #0x74f4, LSL #0
    MOVK  X29, #0x6a85, LSL #48
    MOVK  X29, #0x9765, LSL #32
    MOVK  X29, #0xb015, LSL #16
    MOVK  X29, #0x2ba0, LSL #0
    SUBS  W8, W25, W23, UXTB #2
    MOVZ  X6, #0x68db, LSL #0
    MOVK  X6, #0x7869, LSL #16
    MSR  FPCR, X6
    MRS  X15, FPSR
    MOVZ  X2, #0xff60, LSL #0
    MOVK  X2, #0x7ff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    AND  X15, X15, X2
    MOVZ  X2, #0x0, LSL #0
    ORR  X15, X15, X2
    MSR  FPSR, X15
    ISB  SY
    MOVZ  X2, #0x1328, LSL #0
    MOVK  X2, #0xc8d8, LSL #16
    MOVK  X2, #0xc70a, LSL #32
    MOVK  X2, #0x1921, LSL #48
    MOVZ  X3, #0xfef4, LSL #0
    MOVK  X3, #0x8cf9, LSL #16
    MOVK  X3, #0xe1b9, LSL #32
    MOVK  X3, #0xd79a, LSL #48
    MOVZ  X4, #0x70d5, LSL #0
    MOVK  X4, #0x1fd1, LSL #16
    MOVK  X4, #0x28c7, LSL #32
    MOVK  X4, #0x9cb3, LSL #48
    MOVZ  X5, #0x3bf4, LSL #0
    MOVK  X5, #0xbe65, LSL #16
    MOVK  X5, #0x21c3, LSL #32
    MOVK  X5, #0x6f78, LSL #48
    MOVZ  X6, #0x41b3, LSL #0
    MOVK  X6, #0x77d6, LSL #16
    MOVK  X6, #0x3de5, LSL #32
    MOVK  X6, #0xcc0d, LSL #48
    MOVZ  X7, #0x5322, LSL #0
    MOVK  X7, #0x3a8d, LSL #16
    MOVK  X7, #0x304d, LSL #32
    MOVK  X7, #0xb32c, LSL #48
    MOVZ  X8, #0x9e65, LSL #0
    MOVK  X8, #0x7270, LSL #16
    MOVK  X8, #0x4ca, LSL #32
    MOVK  X8, #0xeb87, LSL #48
    MOVZ  X9, #0x58ea, LSL #0
    MOVK  X9, #0x4ed2, LSL #16
    MOVK  X9, #0xb4a6, LSL #32
    MOVK  X9, #0x5567, LSL #48
    MOVZ  X10, #0x7c02, LSL #0
    MOVK  X10, #0x1904, LSL #16
    MOVK  X10, #0xb8cf, LSL #32
    MOVK  X10, #0x64fa, LSL #48
    MOVZ  X11, #0x9077, LSL #0
    MOVK  X11, #0xbb38, LSL #16
    MOVK  X11, #0xa845, LSL #32
    MOVK  X11, #0xaafb, LSL #48
    MOVZ  X12, #0x3388, LSL #0
    MOVK  X12, #0xe83, LSL #16
    MOVK  X12, #0x86f2, LSL #32
    MOVK  X12, #0x5844, LSL #48
    MOVZ  X13, #0xb082, LSL #0
    MOVK  X13, #0xc0fa, LSL #16
    MOVK  X13, #0x3b25, LSL #32
    MOVK  X13, #0x3ff0, LSL #48
    MOVZ  X14, #0x4f11, LSL #0
    MOVK  X14, #0xf142, LSL #16
    MOVK  X14, #0xa3bc, LSL #32
    MOVK  X14, #0x4a3c, LSL #48
    MOVZ  X15, #0xacb5, LSL #0
    MOVK  X15, #0x400f, LSL #16
    MOVK  X15, #0x8614, LSL #32
    MOVK  X15, #0x6e75, LSL #48
    MOVZ  X16, #0x36e6, LSL #0
    MOVK  X16, #0xf7d9, LSL #16
    MOVK  X16, #0xcbf4, LSL #32
    MOVK  X16, #0x3d02, LSL #48
    MOVZ  X17, #0x1e15, LSL #0
    MOVK  X17, #0x6543, LSL #16
    MOVK  X17, #0x4d15, LSL #32
    MOVK  X17, #0x2070, LSL #48
    MOVZ  X18, #0x6feb, LSL #0
    MOVK  X18, #0x7d38, LSL #16
    MOVK  X18, #0xd26a, LSL #32
    MOVK  X18, #0xb6f9, LSL #48
    MOVZ  X19, #0x7aa5, LSL #0
    MOVK  X19, #0xc9c7, LSL #16
    MOVK  X19, #0xa966, LSL #32
    MOVK  X19, #0x3829, LSL #48
    MOVZ  X20, #0xd518, LSL #0
    MOVK  X20, #0x95b1, LSL #16
    MOVK  X20, #0xf534, LSL #32
    MOVK  X20, #0x9328, LSL #48
    MOVZ  X21, #0x1f42, LSL #0
    MOVK  X21, #0xc27f, LSL #16
    MOVK  X21, #0xaac4, LSL #32
    MOVK  X21, #0x6b6a, LSL #48
    MOVZ  X22, #0x9ad2, LSL #0
    MOVK  X22, #0x2be8, LSL #16
    MOVK  X22, #0x6997, LSL #32
    MOVK  X22, #0x1849, LSL #48
    MOVZ  X23, #0xca4d, LSL #0
    MOVK  X23, #0xc0a9, LSL #16
    MOVK  X23, #0xed5d, LSL #32
    MOVK  X23, #0x97f, LSL #48
    MOVZ  X24, #0xfd3f, LSL #0
    MOVK  X24, #0xc67, LSL #16
    MOVK  X24, #0x1b0d, LSL #32
    MOVK  X24, #0x5463, LSL #48
    MOVZ  X25, #0x7328, LSL #0
    MOVK  X25, #0x6c5a, LSL #16
    MOVK  X25, #0x8ce3, LSL #32
    MOVK  X25, #0xb6de, LSL #48
    MOVZ  X26, #0x99ef, LSL #0
    MOVK  X26, #0xcb6c, LSL #16
    MOVK  X26, #0xc6a1, LSL #32
    MOVK  X26, #0xdf86, LSL #48
    MOVZ  X27, #0xd228, LSL #0
    MOVK  X27, #0x246a, LSL #16
    MOVK  X27, #0xaa7, LSL #32
    MOVK  X27, #0x648e, LSL #48
    MOVZ  X28, #0x4c67, LSL #0
    MOVK  X28, #0xfc88, LSL #16
    MOVK  X28, #0x154c, LSL #32
    MOVK  X28, #0xeb9c, LSL #48
    MOVZ  X29, #0xafe4, LSL #0
    MOVK  X29, #0xbc88, LSL #16
    MOVK  X29, #0x215d, LSL #32
    MOVK  X29, #0x5f84, LSL #48
    FMOV  D0, X17
    FMOV  V0.D[1], X29
    FMOV  D1, X2
    FMOV  V1.D[1], X25
    FMOV  D2, X13
    FMOV  V2.D[1], X16
    FMOV  D3, X28
    FMOV  V3.D[1], X4
    FMOV  D4, X11
    FMOV  V4.D[1], X17
    FMOV  D5, X29
    FMOV  V5.D[1], X24
    FMOV  D6, X18
    FMOV  V6.D[1], X2
    FMOV  D7, X24
    FMOV  V7.D[1], X21
    FMOV  D8, X5
    FMOV  V8.D[1], X2
    FMOV  D9, X4
    FMOV  V9.D[1], X17
    FMOV  D10, X12
    FMOV  V10.D[1], X6
    FMOV  D11, X13
    FMOV  V11.D[1], X2
    FMOV  D12, X21
    FMOV  V12.D[1], X14
    FMOV  D13, X23
    FMOV  V13.D[1], X6
    FMOV  D14, X3
    FMOV  V14.D[1], X13
    FMOV  D15, X16
    FMOV  V15.D[1], X13
    FMOV  D16, X28
    FMOV  V16.D[1], X12
    FMOV  D17, X22
    FMOV  V17.D[1], X23
    FMOV  D18, X13
    FMOV  V18.D[1], X14
    FMOV  D19, X22
    FMOV  V19.D[1], X22
    FMOV  D20, X12
    FMOV  V20.D[1], X17
    FMOV  D21, X29
    FMOV  V21.D[1], X11
    FMOV  D22, X8
    FMOV  V22.D[1], X2
    FMOV  D23, X10
    FMOV  V23.D[1], X7
    FMOV  D24, X17
    FMOV  V24.D[1], X17
    FMOV  D25, X29
    FMOV  V25.D[1], X29
    FMOV  D26, X18
    FMOV  V26.D[1], X6
    FMOV  D27, X27
    FMOV  V27.D[1], X15
    FMOV  D28, X28
    FMOV  V28.D[1], X2
    FMOV  D29, X4
    FMOV  V29.D[1], X7
    FMOV  D30, X24
    FMOV  V30.D[1], X10
    FMOV  D31, X23
    FMOV  V31.D[1], X9
    MOVZ  X7, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_0:
    FMOV  D22, X19
    FNMSUB  H26, H9, H31, H12
    FMOV  W6, S28
    FMOV  D26, D22
    FMOV  S6, #-1.87500000
    FMOV  W18, S8
    FMOV  W6, H26
    FMSUB  D6, D5, D20, D30
    FMOV  D6, #13.50000000
    FMOV  W22, S3
    FMOV  S5, S27
    FMOV  H14, X5
    FMOV  D13, X5
    FMSUB  S2, S30, S8, S25
    FNMSUB  S18, S22, S23, S22
    FMOV  H11, W17
    FMOV  H24, H5
    FNMSUB  S19, S9, S17, S8
    FMOV  H20, H3
    FMSUB  H28, H5, H7, H11
    FNMADD  H26, H25, H7, H20
    FMOV  H3, #-30.00000000
    FMOV  S24, W7
    FMOV  D25, X17
    FMOV  H22, X26
    FMOV  S0, S3
    FNMSUB  D6, D29, D18, D5
    FMOV  S26, S27
    FNMSUB  H9, H23, H30, H9
    FMSUB  H8, H31, H24, H23
    FMADD  S17, S19, S16, S0
    FMSUB  S5, S5, S6, S20
    FMOV  X18, H20
    FMOV  D13, D3
    FNMSUB  H22, H3, H25, H27
    FMOV  H4, W19
    FMOV  X24, H19
    FNMADD  D14, D18, D27, D8
    FMOV  X19, D23
    FMADD  D22, D1, D7, D3
    FMOV  D17, D29
    FNMADD  S7, S10, S22, S11
    FMOV  H25, H14
    FNMADD  D14, D3, D1, D9
    FNMSUB  D19, D0, D0, D22
    FMADD  H13, H31, H17, H20
    FMOV  D29, #-0.65625000
    FMADD  H4, H14, H19, H6
    FMOV  H28, #0.32812500
    FMADD  S26, S31, S27, S11
    FMADD  S19, S13, S19, S4
    FNMADD  D9, D19, D9, D1
    FMOV  D0, D15
    FMOV  H15, X22
    FNMADD  S23, S30, S10, S29
    FMADD  S4, S28, S14, S29
    FMOV  D8, #-1.18750000
    FMSUB  H29, H6, H24, H1
    FMOV  H23, X23
    FMOV  H11, #2.50000000
    FMOV  S8, #30.00000000
    FNMSUB  H24, H31, H19, H1
    FMOV  H26, W12
    FMOV  D2, D24
    FMADD  S16, S2, S11, S22
    FNMADD  H16, H13, H2, H13
    FMOV  D28, #6.00000000
    FMOV  D2, D16
    FMSUB  S30, S13, S31, S14
    FMOV  D29, X22
    FMOV  S15, S22
    FMOV  S30, #-28.00000000
    FNMSUB  H26, H5, H25, H4
    FMADD  H27, H21, H3, H19
    FMOV  D21, #-0.29687500
    FMOV  D1, X8
    FMADD  S31, S6, S12, S5
    FMOV  H18, H18
    FMSUB  H11, H1, H8, H0
    FMADD  S13, S10, S30, S30
    FMOV  W2, S9
    FMADD  S7, S8, S15, S2
    FNMADD  S27, S7, S0, S31
    FMOV  X12, H6
    FMOV  H13, W27
    FMOV  D20, #-1.93750000
    FMADD  D13, D7, D23, D3
    FNMADD  D1, D23, D21, D8
    FMSUB  H15, H15, H18, H11
    FMOV  S4, W26
    FMADD  S15, S24, S2, S27
    FMOV  W2, S24
    FMOV  X18, D3
    FMOV  X21, D5
    FNMSUB  H10, H22, H3, H6
    FNMADD  D13, D1, D1, D28
    FMOV  X29, D11
    FMADD  D14, D25, D27, D23
    FMOV  H29, #3.00000000
    FMADD  D7, D15, D4, D30
    FMOV  W27, H11
    FMOV  H27, W26
    FMADD  S31, S21, S27, S26
    FMOV  S19, W18
    FMOV  D24, X3
    FNMSUB  D10, D14, D27, D28
    FMOV  S3, W15
    FMOV  H30, X11
    FMOV  D29, #-8.50000000
    FMOV  H12, #0.34375000
    FNMSUB  S19, S30, S11, S19
    FMOV  H29, X7
    FMADD  S28, S7, S23, S25
    FNMADD  S27, S28, S24, S19
    FNMSUB  H3, H27, H4, H2
    FMOV  H11, H14
    FMOV  X18, D19
    FMOV  W26, S5
    FMSUB  D3, D24, D10, D19
    FMOV  D21, #-0.34375000
    FNMSUB  S21, S5, S26, S30
    FNMSUB  D2, D8, D21, D23
    FMOV  D17, D5
    FMOV  S15, #-0.56250000
    FMADD  D26, D1, D1, D16
    FMOV  H10, X19
    FMOV  S8, S5
    FNMSUB  S0, S2, S26, S3
    FMADD  S8, S22, S22, S18
    FMOV  X8, H19
    FMSUB  S9, S25, S30, S24
    FNMSUB  D14, D22, D9, D8
    FNMADD  H13, H18, H24, H8
    FMADD  D12, D23, D22, D4
    FMOV  S12, W17
    FNMSUB  H15, H17, H7, H28
    FMADD  H14, H1, H10, H1
    FMOV  H0, X5
    FNMADD  D12, D23, D11, D17
    FMOV  S13, W3
    FNMADD  H11, H0, H26, H20
    FMOV  S18, W25
    FMSUB  H4, H17, H3, H10
    FMOV  D26, #-2.12500000
    FMADD  H31, H14, H4, H30
    FMADD  D30, D6, D18, D9
    FMADD  S2, S9, S20, S17
    FNMSUB  D10, D15, D4, D27
    FMADD  D21, D30, D26, D3
    FMOV  H1, #8.50000000
    FNMSUB  D6, D0, D31, D29
    FMOV  S27, S14
    FNMSUB  S13, S21, S18, S29
    FNMADD  D30, D8, D4, D31
    FMADD  H13, H24, H10, H12
    FMOV  S0, W9
    FMOV  W9, H1
    FMOV  D29, X20
    FMOV  D23, D31
    FMOV  S8, S31
    FNMSUB  D29, D2, D3, D2
    FMADD  S26, S15, S12, S29
    FNMSUB  H29, H28, H31, H12
    FMOV  W26, H21
    FMOV  X11, H17
    FMOV  H15, #-12.00000000
    FMOV  H27, H23
    FNMSUB  H27, H22, H26, H12
    FMSUB  H26, H20, H16, H23
    FMOV  H6, X29
    FMOV  S1, S8
    FMOV  H23, #13.50000000
    FMOV  D14, X2
    FNMADD  S29, S6, S16, S1
    FNMSUB  S20, S15, S16, S23
    FNMSUB  D4, D13, D3, D7
    FMOV  H4, #-0.43750000
    FNMSUB  S29, S21, S29, S30
    FMOV  W8, S1
    FNMADD  D31, D24, D15, D24
    FMOV  S16, #0.16406250
    FMOV  S6, S7
    FNMSUB  S28, S17, S25, S15
    FMOV  H21, W22
    FMOV  W27, S3
    FMOV  W15, H9
    FMOV  D27, D3
    FNMSUB  D0, D22, D27, D14
    FMOV  X14, H1
    FMOV  H28, W20
    FMOV  H31, H24
    FMADD  H25, H11, H3, H8
    FNMSUB  D5, D0, D18, D1
    FMOV  H12, X23
    FNMADD  S31, S28, S4, S23
    FMOV  X2, D21
    FNMADD  D26, D29, D8, D5
    FMADD  H23, H20, H5, H13
    FNMADD  D5, D22, D4, D15
    FMOV  S19, S11
    SUBS  X7, X7, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_0
    MOVZ  X15, #0x7f36, LSL #0
    SUB  X7, X15, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0xfef4, LSL #0
    MOVK  X28, #0x8cf9, LSL #16
    MOVK  X28, #0xe1b9, LSL #32
    MOVK  X28, #0xd79a, LSL #48
    SUB  X9, X28, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x70d5, LSL #0
    MOVK  X23, #0x1fd1, LSL #16
    MOVK  X23, #0x28c7, LSL #32
    MOVK  X23, #0x9cb3, LSL #48
    SUB  X12, X23, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x3bf4, LSL #0
    MOVK  X28, #0xbe65, LSL #16
    MOVK  X28, #0x21c3, LSL #32
    MOVK  X28, #0x6f78, LSL #48
    SUB  X29, X28, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0xfef4, LSL #0
    SUB  X20, X18, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0xfef4, LSL #0
    SUB  X12, X17, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x7c02, LSL #0
    MOVK  X3, #0x1904, LSL #16
    MOVK  X3, #0xb8cf, LSL #32
    MOVK  X3, #0x64fa, LSL #48
    SUB  X23, X3, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0xb082, LSL #0
    MOVK  X29, #0xc0fa, LSL #16
    MOVK  X29, #0x3b25, LSL #32
    MOVK  X29, #0x3ff0, LSL #48
    SUB  X19, X29, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0xfef4, LSL #0
    SUB  X4, X24, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x7f36, LSL #0
    SUB  X28, X29, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x36e6, LSL #0
    MOVK  X15, #0xf7d9, LSL #16
    MOVK  X15, #0xcbf4, LSL #32
    MOVK  X15, #0x3d02, LSL #48
    SUB  X4, X15, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0xfef4, LSL #0
    SUB  X27, X2, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0xfef4, LSL #0
    SUB  X15, X19, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0xfef4, LSL #0
    SUB  X29, X10, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x7f36, LSL #0
    MOVK  X5, #0x29bb, LSL #16
    SUB  X11, X5, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0xfef4, LSL #0
    SUB  X6, X8, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X27
    B  TaishanFpMiniMaxiP01_label_26
TaishanFpMiniMaxiP01_label_26:
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D2
    MOVZ  X15, #0x5317, LSL #0
    MOVK  X15, #0x9409, LSL #16
    SUB  X16, X15, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D3
    MOVZ  X11, #0x7f36, LSL #0
    MOVK  X11, #0x29bb, LSL #16
    MOVK  X11, #0x294b, LSL #32
    MOVK  X11, #0xd7c4, LSL #48
    SUB  X5, X11, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D4
    MOVZ  X21, #0xb700, LSL #0
    SUB  X25, X21, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D5
    MOVZ  X27, #0xca00, LSL #0
    MOVK  X27, #0x8000, LSL #48
    SUB  X20, X27, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D6
    MOVZ  X4, #0x1, LSL #0
    MOVK  X4, #0xc1e0, LSL #16
    SUB  X19, X4, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D7
    MOVZ  X27, #0x1, LSL #0
    MOVK  X27, #0xc1e0, LSL #16
    SUB  X24, X27, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D8
    MOVZ  X13, #0xfef4, LSL #0
    SUB  X7, X13, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D9
    MOVZ  X11, #0xfef4, LSL #0
    MOVK  X11, #0x8cf9, LSL #16
    SUB  X13, X11, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D10
    MOVZ  X19, #0xcf7e, LSL #0
    MOVK  X19, #0x8000, LSL #48
    SUB  X12, X19, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D11
    MOVZ  X7, #0xff37, LSL #0
    SUB  X4, X7, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D12
    MOVZ  X18, #0xca4d, LSL #0
    SUB  X24, X18, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D13
    MOVZ  X8, #0xfef4, LSL #0
    SUB  X22, X8, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D14
    MOVZ  X23, #0x7ef4, LSL #0
    SUB  X7, X23, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D15
    MOVZ  X22, #0xca00, LSL #0
    SUB  X12, X22, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D16
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x3e28, LSL #16
    SUB  X6, X11, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D17
    MOVZ  X16, #0x5317, LSL #0
    MOVK  X16, #0x9409, LSL #16
    SUB  X14, X16, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D18
    MOVZ  X4, #0x7328, LSL #0
    MOVK  X4, #0x6c5a, LSL #16
    SUB  X9, X4, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D19
    MOVZ  X10, #0xff37, LSL #0
    SUB  X2, X10, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D20
    MOVZ  X25, #0x4abf, LSL #0
    MOVK  X25, #0x8000, LSL #16
    SUB  X17, X25, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D21
    MOVZ  X2, #0x7f36, LSL #0
    SUB  X12, X2, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D22
    MOVZ  X7, #0xcf81, LSL #0
    SUB  X10, X7, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D23
    MOVZ  X9, #0xfef4, LSL #0
    SUB  X25, X9, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D24
    MOVZ  X18, #0xfef4, LSL #0
    MOVK  X18, #0x8cf9, LSL #16
    MOVK  X18, #0xe1b9, LSL #32
    MOVK  X18, #0xd79a, LSL #48
    SUB  X14, X18, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D25
    MOVZ  X29, #0xfef4, LSL #0
    SUB  X16, X29, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D26
    MOVZ  X2, #0xfef4, LSL #0
    SUB  X4, X2, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D27
    MOVZ  X14, #0x7f36, LSL #0
    MOVK  X14, #0x29bb, LSL #16
    MOVK  X14, #0x294b, LSL #32
    MOVK  X14, #0xd7c4, LSL #48
    SUB  X20, X14, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D28
    MOVZ  X18, #0xd518, LSL #0
    SUB  X5, X18, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D29
    MOVZ  X11, #0xfef4, LSL #0
    MOVK  X11, #0x8000, LSL #16
    SUB  X10, X11, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X21
    FMOV  V0.D[1], X22
    FMOV  D1, X28
    FMOV  V1.D[1], X4
    FMOV  D2, X3
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X13
    FMOV  D4, X5
    FMOV  V4.D[1], X17
    FMOV  D5, X12
    FMOV  V5.D[1], X23
    FMOV  D6, X28
    FMOV  V6.D[1], X27
    FMOV  D7, X7
    FMOV  V7.D[1], X25
    FMOV  D8, X29
    FMOV  V8.D[1], X28
    FMOV  D9, X18
    FMOV  V9.D[1], X24
    FMOV  D10, X11
    FMOV  V10.D[1], X25
    FMOV  D11, X22
    FMOV  V11.D[1], X29
    FMOV  D12, X29
    FMOV  V12.D[1], X2
    FMOV  D13, X2
    FMOV  V13.D[1], X16
    FMOV  D14, X2
    FMOV  V14.D[1], X7
    FMOV  D15, X15
    FMOV  V15.D[1], X9
    FMOV  D16, X12
    FMOV  V16.D[1], X3
    FMOV  D17, X26
    FMOV  V17.D[1], X16
    FMOV  D18, X7
    FMOV  V18.D[1], X3
    FMOV  D19, X14
    FMOV  V19.D[1], X7
    FMOV  D20, X15
    FMOV  V20.D[1], X20
    FMOV  D21, X11
    FMOV  V21.D[1], X6
    FMOV  D22, X23
    FMOV  V22.D[1], X19
    FMOV  D23, X9
    FMOV  V23.D[1], X12
    FMOV  D24, X25
    FMOV  V24.D[1], X14
    FMOV  D25, X24
    FMOV  V25.D[1], X3
    FMOV  D26, X3
    FMOV  V26.D[1], X22
    FMOV  D27, X15
    FMOV  V27.D[1], X16
    FMOV  D28, X22
    FMOV  V28.D[1], X7
    FMOV  D29, X7
    FMOV  V29.D[1], X27
    FMOV  D30, X10
    FMOV  V30.D[1], X19
    FMOV  D31, X7
    FMOV  V31.D[1], X26
    MOVZ  X20, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_87:
    FMOV  X9, H27
    FMOV  H14, W23
    FNMSUB  S5, S30, S24, S15
    FNMSUB  H12, H13, H19, H18
    FMSUB  D12, D24, D14, D4
    FNMSUB  H1, H25, H8, H14
    FMOV  D15, X22
    FNMADD  H25, H3, H18, H29
    FNMADD  S19, S21, S29, S31
    FNMADD  H12, H6, H15, H15
    FMOV  H18, #8.50000000
    FMOV  S22, #-7.25000000
    FMOV  W15, S0
    FNMSUB  S28, S25, S8, S19
    FMADD  D22, D29, D25, D1
    FMOV  W21, H20
    FMOV  D22, X21
    FMOV  S26, W15
    FMOV  H8, W28
    FMOV  H6, X20
    FNMSUB  D5, D5, D18, D28
    FMOV  X23, H3
    FMSUB  S20, S25, S26, S26
    FMOV  H30, X5
    FMOV  S9, #0.78125000
    FMOV  D29, #28.00000000
    FMOV  W25, H9
    FMADD  S15, S14, S18, S10
    FMSUB  S14, S27, S4, S13
    FMOV  S16, #4.50000000
    FMSUB  S22, S16, S23, S4
    FNMADD  H3, H12, H20, H20
    FMOV  D12, X15
    FMOV  H15, W6
    FMOV  W4, H23
    FMOV  H15, #8.00000000
    FMOV  D23, X20
    FMOV  X27, D21
    FNMSUB  D14, D26, D27, D17
    FMADD  S27, S0, S31, S23
    FMOV  H3, X20
    FMADD  H28, H0, H20, H1
    FNMSUB  H12, H22, H31, H14
    FMOV  X29, H6
    FNMSUB  S18, S22, S8, S29
    FNMADD  H3, H27, H4, H21
    FNMSUB  D2, D21, D10, D25
    FMOV  X15, H25
    FMOV  D10, X16
    FNMADD  D5, D12, D29, D14
    FNMADD  H10, H16, H12, H2
    FMOV  S5, W12
    FMOV  X13, H29
    FMADD  D3, D23, D1, D3
    FMADD  H0, H17, H29, H20
    FMSUB  D3, D25, D25, D2
    FMSUB  H15, H9, H22, H20
    FMOV  D22, D26
    FMOV  H2, #-1.81250000
    FMOV  H0, W13
    FMSUB  S11, S31, S31, S29
    FMOV  W12, S31
    FMADD  H6, H21, H27, H0
    FMOV  S14, #-0.93750000
    FMOV  H29, #-13.00000000
    FNMSUB  H5, H31, H12, H13
    FNMSUB  D29, D30, D17, D20
    FMOV  S21, W6
    FMOV  H13, #-0.35937500
    FNMSUB  H30, H22, H10, H20
    FMADD  S4, S17, S29, S1
    FMSUB  S5, S21, S31, S21
    FMOV  H21, #-0.34375000
    FMOV  W6, S10
    FMADD  H26, H31, H31, H20
    FNMADD  D20, D17, D31, D31
    FMOV  W17, H19
    FMOV  S19, S28
    FMOV  X19, D18
    FMSUB  D10, D27, D28, D29
    FNMSUB  S5, S29, S31, S11
    FMADD  D27, D9, D13, D21
    FNMSUB  D14, D7, D1, D3
    FNMADD  D19, D26, D21, D22
    FMSUB  H2, H10, H20, H27
    FMOV  W4, S24
    FMSUB  H25, H6, H30, H21
    FMOV  X24, H21
    FMOV  S15, W28
    FMADD  H9, H17, H5, H16
    FNMADD  D15, D1, D7, D31
    FMOV  S25, W4
    FMADD  D14, D21, D25, D21
    FMOV  H18, X23
    FMADD  H22, H19, H19, H2
    FMADD  S1, S0, S14, S16
    FMADD  H5, H25, H11, H9
    FMSUB  D22, D18, D3, D5
    FMOV  H22, W15
    FMOV  D28, D5
    FNMADD  S20, S3, S1, S31
    FMOV  H17, #-10.00000000
    FMOV  W11, H22
    FMOV  S26, W28
    FMOV  S7, #-0.96875000
    FNMSUB  D8, D12, D4, D11
    FMOV  S14, #-10.50000000
    FMSUB  S30, S4, S10, S26
    FMOV  H15, W15
    FMADD  H26, H3, H0, H13
    FMOV  X13, D28
    FNMSUB  S29, S7, S26, S26
    FMOV  S10, W24
    FNMSUB  S31, S10, S27, S4
    FMOV  S13, #3.87500000
    FNMSUB  H29, H25, H1, H4
    FMADD  H13, H15, H2, H22
    FMADD  S16, S7, S31, S2
    FNMADD  S17, S11, S30, S30
    FMOV  H26, H25
    FMSUB  H19, H26, H31, H31
    FMSUB  H19, H25, H1, H8
    FMOV  D10, D15
    FNMADD  S12, S7, S12, S20
    FMOV  W7, S18
    FMOV  D14, D22
    FMOV  S11, S25
    FMOV  W24, H4
    FNMADD  D5, D29, D26, D5
    FMOV  X28, H29
    FMOV  H2, X13
    FMOV  D5, X15
    FMOV  D18, #-23.00000000
    FMADD  D19, D26, D29, D2
    FNMSUB  H21, H17, H14, H6
    FMOV  H19, X28
    FMOV  S29, #-2.50000000
    FMOV  H7, W27
    FMSUB  H30, H13, H6, H1
    FMADD  H12, H6, H6, H14
    FMOV  D30, #1.25000000
    FNMADD  H31, H24, H12, H17
    FMOV  S30, W16
    FMOV  S3, S30
    FNMSUB  H31, H29, H27, H7
    FMOV  W14, S2
    FMOV  D27, X3
    FMOV  W16, S30
    FNMSUB  D11, D10, D20, D25
    FMSUB  S12, S19, S5, S15
    FMOV  H27, W13
    FMADD  H26, H20, H18, H27
    FMOV  S29, W4
    FMOV  H1, H2
    FNMSUB  D1, D28, D28, D2
    FMOV  H30, X2
    FMOV  X6, D19
    FNMADD  D1, D7, D1, D31
    FMOV  H25, #1.37500000
    FMOV  S20, #-3.37500000
    FMOV  W16, S29
    FMOV  D27, X14
    FNMSUB  S20, S25, S27, S13
    FMADD  S10, S28, S3, S1
    FMOV  S29, W21
    FNMSUB  D5, D26, D4, D6
    FNMSUB  S22, S2, S22, S23
    FMSUB  H26, H23, H12, H15
    FMOV  S28, S30
    FMOV  W9, S5
    FMSUB  H18, H29, H2, H20
    FMOV  H28, X28
    FNMADD  D0, D31, D16, D20
    FMSUB  H31, H20, H4, H6
    FMSUB  S1, S4, S27, S3
    FNMSUB  S9, S4, S6, S28
    FNMADD  D26, D25, D6, D22
    FMADD  H7, H14, H18, H18
    FMOV  H11, H20
    FMADD  D9, D30, D11, D12
    FMOV  S11, W23
    FMOV  S12, W2
    FMOV  H29, W18
    FMSUB  S26, S0, S25, S5
    FMOV  S24, S6
    FMSUB  H8, H20, H22, H12
    FMOV  D13, X23
    FMADD  D0, D2, D17, D2
    FMOV  D1, X11
    FMOV  H3, H30
    FNMSUB  H20, H21, H8, H23
    FMOV  D28, #12.00000000
    FMOV  X29, D9
    FNMADD  S5, S13, S23, S8
    FNMSUB  D11, D9, D4, D25
    FMADD  H9, H2, H21, H4
    FNMADD  S11, S6, S31, S1
    FMOV  D19, X10
    FMOV  S27, #-1.00000000
    FMSUB  S23, S26, S15, S13
    SUBS  X20, X20, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_87
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X11, X25, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x8000, LSL #0
    SUB  X3, X9, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x8000, LSL #0
    SUB  X19, X10, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x8000, LSL #0
    SUB  X3, X17, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x8000, LSL #0
    SUB  X2, X23, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D4
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D5
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #16
    SUB  X24, X2, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D6
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D11
    MOVZ  X25, #0x8000, LSL #0
    MOVK  X25, #0x8000, LSL #16
    SUB  X24, X25, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D12
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D14
    MOVZ  X18, #0x8000, LSL #0
    SUB  X12, X18, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D15
    MOVZ  X19, #0x8000, LSL #0
    SUB  X2, X19, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D16
    MOVZ  X18, #0xb581, LSL #0
    SUB  X29, X18, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D17
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X12, X19, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D19
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D20
    MOVZ  X28, #0x8000, LSL #0
    SUB  X21, X28, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D21
    MOVZ  X12, #0x8000, LSL #0
    SUB  X16, X12, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D22
    MOVZ  X12, #0x1, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X24, X12, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D25
    MOVZ  X24, #0x3d80, LSL #0
    SUB  X17, X24, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X28, X7, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D27
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xbf80, LSL #16
    SUB  X28, X7, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D28
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4028, LSL #48
    SUB  X13, X17, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X16
    FMOV  V0.D[1], X29
    FMOV  D1, X18
    FMOV  V1.D[1], X12
    FMOV  D2, X29
    FMOV  V2.D[1], X24
    FMOV  D3, X5
    FMOV  V3.D[1], X5
    FMOV  D4, X3
    FMOV  V4.D[1], X27
    FMOV  D5, X16
    FMOV  V5.D[1], X22
    FMOV  D6, X6
    FMOV  V6.D[1], X5
    FMOV  D7, X14
    FMOV  V7.D[1], X16
    FMOV  D8, X17
    FMOV  V8.D[1], X7
    FMOV  D9, X5
    FMOV  V9.D[1], X26
    FMOV  D10, X4
    FMOV  V10.D[1], X13
    FMOV  D11, X29
    FMOV  V11.D[1], X9
    FMOV  D12, X12
    FMOV  V12.D[1], X4
    FMOV  D13, X24
    FMOV  V13.D[1], X11
    FMOV  D14, X13
    FMOV  V14.D[1], X18
    FMOV  D15, X11
    FMOV  V15.D[1], X23
    FMOV  D16, X29
    FMOV  V16.D[1], X14
    FMOV  D17, X13
    FMOV  V17.D[1], X22
    FMOV  D18, X23
    FMOV  V18.D[1], X2
    FMOV  D19, X5
    FMOV  V19.D[1], X5
    FMOV  D20, X21
    FMOV  V20.D[1], X2
    FMOV  D21, X29
    FMOV  V21.D[1], X17
    FMOV  D22, X19
    FMOV  V22.D[1], X6
    FMOV  D23, X21
    FMOV  V23.D[1], X20
    FMOV  D24, X16
    FMOV  V24.D[1], X23
    FMOV  D25, X11
    FMOV  V25.D[1], X15
    FMOV  D26, X2
    FMOV  V26.D[1], X21
    FMOV  D27, X11
    FMOV  V27.D[1], X22
    FMOV  D28, X2
    FMOV  V28.D[1], X23
    FMOV  D29, X29
    FMOV  V29.D[1], X6
    FMOV  D30, X27
    FMOV  V30.D[1], X12
    FMOV  D31, X20
    FMOV  V31.D[1], X14
    MOVZ  X2, #0xf, LSL #0
TaishanFpMiniMaxiP01_label_173:
    FMOV  D21, #-0.12500000
    FNMADD  S18, S24, S20, S26
    FMOV  H7, X17
    FMOV  X28, H1
    FNMADD  H15, H9, H24, H29
    FMOV  H20, #-0.25000000
    FMOV  W21, H30
    FNMSUB  H20, H4, H2, H14
    FMSUB  S3, S1, S19, S10
    FNMADD  S15, S27, S28, S5
    FMOV  S8, W29
    FMOV  S18, #1.81250000
    FMOV  D15, D11
    FMOV  D27, #-26.00000000
    FMOV  S13, W5
    FNMSUB  H23, H11, H14, H31
    FMADD  S3, S16, S17, S14
    FMOV  H31, W11
    FMOV  D7, X29
    FMOV  S9, W10
    FMOV  S1, W27
    FMOV  X3, D13
    FMOV  S1, S20
    FNMSUB  S21, S18, S23, S10
    FMSUB  D3, D29, D23, D1
    FNMADD  S8, S13, S10, S8
    FMOV  D27, #-0.71875000
    FMSUB  S22, S0, S7, S9
    FMOV  X20, D1
    FMOV  H1, H8
    FMOV  S26, #-7.75000000
    FNMSUB  S2, S27, S31, S10
    FMOV  S26, S29
    FMOV  D15, X6
    FMOV  S29, S18
    FNMSUB  S5, S3, S8, S22
    FNMADD  D18, D13, D29, D29
    FMOV  W7, H17
    FMOV  H18, #-1.12500000
    FMOV  H23, #2.12500000
    FNMADD  H30, H11, H10, H9
    FMOV  X22, H8
    FMADD  D29, D7, D13, D23
    FMOV  D2, #5.75000000
    FMADD  D6, D20, D23, D23
    FMSUB  D21, D12, D14, D22
    FMOV  S13, #-16.00000000
    FNMADD  H11, H23, H26, H18
    FMOV  D27, X5
    FMOV  W7, S13
    FMADD  H19, H29, H2, H20
    FMADD  S17, S12, S20, S31
    FMSUB  D30, D13, D0, D22
    FNMADD  S8, S11, S22, S19
    FMSUB  H11, H28, H16, H3
    FMSUB  S1, S24, S17, S27
    FMOV  H22, H21
    FMOV  H2, H24
    FNMADD  D9, D24, D18, D20
    FMADD  D19, D24, D10, D3
    FMOV  X20, D25
    FMADD  H1, H6, H14, H11
    FMOV  W6, S21
    FMOV  X5, H4
    FMADD  S12, S25, S29, S21
    FMADD  H28, H22, H20, H12
    FMADD  S23, S24, S30, S30
    FMSUB  H8, H31, H18, H17
    FMADD  H0, H20, H10, H0
    FMOV  S17, S2
    FMOV  S4, #-4.00000000
    FMOV  S2, #-0.78125000
    FMADD  H10, H11, H23, H26
    FMOV  X12, H28
    FNMSUB  D1, D13, D17, D30
    FMOV  W4, H24
    FMSUB  H9, H9, H20, H31
    FMOV  D13, #-3.62500000
    FMOV  S22, S28
    FNMSUB  H21, H27, H21, H1
    FMOV  H29, H6
    FMADD  H1, H16, H28, H22
    FMOV  D8, X2
    FMOV  X20, H18
    FMOV  X24, D26
    FMOV  D12, D27
    FNMADD  S19, S9, S2, S26
    FMADD  H12, H21, H26, H16
    FMOV  H13, H31
    FMOV  S12, W12
    FNMSUB  S27, S20, S12, S19
    FMOV  X12, D21
    FMSUB  H22, H20, H10, H23
    FMOV  S9, W24
    FMOV  S14, W29
    FMOV  W13, H12
    FNMADD  H3, H24, H21, H22
    FMADD  H14, H14, H0, H11
    FNMADD  D4, D31, D6, D31
    FNMADD  D4, D26, D2, D11
    FNMADD  D30, D28, D8, D28
    FNMSUB  D27, D29, D31, D1
    FMSUB  S8, S31, S15, S24
    FNMADD  H14, H4, H3, H16
    FMOV  W6, S23
    FMOV  W22, H29
    FNMADD  S20, S27, S9, S27
    FMOV  X9, H10
    FMADD  H8, H12, H20, H24
    FMOV  S21, W14
    FMOV  D7, #0.46875000
    FMOV  W15, S0
    FMOV  H8, W20
    FNMSUB  S19, S23, S7, S1
    FMSUB  S28, S21, S15, S14
    FNMSUB  H29, H2, H1, H23
    FMADD  H23, H11, H8, H22
    FMOV  S12, S19
    FMOV  H2, W3
    FMOV  H12, X16
    FNMSUB  S27, S15, S0, S25
    FNMSUB  H19, H2, H18, H19
    FMOV  S7, #7.50000000
    FMOV  S0, #-13.00000000
    FMOV  H26, X19
    FNMSUB  S28, S20, S26, S25
    FMOV  S3, S28
    FMADD  H15, H13, H6, H13
    FMOV  H18, X12
    FNMADD  H0, H2, H11, H3
    FMOV  D15, #1.12500000
    FMSUB  S23, S22, S0, S23
    FMOV  S22, W27
    FMOV  H1, H10
    FMSUB  H12, H11, H25, H23
    FMOV  H14, X13
    FMOV  W13, S5
    FMOV  W10, S7
    FMOV  S5, W12
    FMADD  D28, D19, D13, D26
    FMADD  S21, S11, S1, S6
    FNMADD  S28, S23, S30, S1
    FMADD  D26, D23, D15, D7
    FMOV  D24, X2
    FMOV  X29, D28
    FMOV  W16, S29
    FMOV  D23, #-3.00000000
    FMOV  X17, D24
    FMOV  X6, D30
    FMOV  W8, S7
    FMADD  S1, S24, S30, S11
    FMOV  S0, W21
    FMSUB  S7, S3, S22, S31
    FMOV  H24, W10
    FMOV  S28, #-2.50000000
    FMADD  H0, H19, H19, H15
    FNMSUB  D20, D24, D31, D5
    FNMSUB  D18, D5, D7, D25
    FMOV  H2, W14
    FMOV  H23, X17
    FMOV  W12, S18
    FMOV  D22, #-7.50000000
    FMOV  S4, W8
    FMOV  D18, D7
    FMOV  S14, #-3.25000000
    FNMADD  D10, D26, D17, D1
    FMOV  H27, X3
    FMOV  X10, H17
    FMOV  S14, S5
    FMOV  H25, H27
    FMOV  S17, W27
    FMADD  H17, H8, H2, H28
    FMSUB  H20, H3, H11, H2
    FMSUB  H8, H27, H30, H19
    FNMSUB  S22, S19, S27, S31
    FMOV  W5, H15
    FNMADD  D17, D14, D31, D31
    FMOV  H20, X26
    FMOV  S26, W5
    FMOV  D5, D9
    FNMADD  H12, H22, H22, H20
    FMOV  S1, S14
    FMADD  D25, D10, D10, D9
    FMSUB  D3, D23, D6, D7
    FMSUB  D3, D26, D4, D19
    FMOV  W8, H9
    FMOV  H26, #1.12500000
    FMOV  S27, S25
    FNMADD  H23, H5, H8, H17
    FMADD  D31, D30, D1, D4
    FMADD  D8, D31, D21, D0
    FMOV  W5, S30
    FMSUB  S14, S1, S2, S12
    FMSUB  S7, S31, S26, S6
    FNMSUB  D28, D11, D25, D3
    FMOV  W4, H16
    FNMSUB  D14, D1, D10, D21
    FNMADD  H11, H14, H21, H25
    FMOV  W13, H27
    FMOV  H2, H2
    SUBS  X2, X2, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_173
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    SUB  X17, X8, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    SUB  X2, X27, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    SUB  X12, X6, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    SUB  X27, X16, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xc180, LSL #16
    SUB  X10, X12, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    SUB  X12, X3, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    SUB  X27, X10, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    SUB  X18, X11, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    SUB  X16, X15, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X13, X16, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    SUB  X28, X14, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X29, X5, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X15, X10, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0xbc80, LSL #0
    SUB  X3, X25, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    SUB  X20, X25, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X12, X7, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    SUB  X8, X16, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X21, X7, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D2
    MOVZ  X21, #0xffff, LSL #0
    SUB  X23, X21, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D3
    MOVZ  X27, #0x7fff, LSL #0
    SUB  X19, X27, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D4
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x40f0, LSL #16
    SUB  X28, X9, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D5
    MOVZ  X3, #0xffff, LSL #0
    SUB  X7, X3, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D6
    MOVZ  X22, #0x4041, LSL #0
    SUB  X7, X22, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D7
    MOVZ  X8, #0x857f, LSL #0
    MOVK  X8, #0x8001, LSL #16
    SUB  X17, X8, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D8
    MOVZ  X19, #0x8000, LSL #0
    SUB  X13, X19, X15
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D9
    MOVZ  X25, #0xffff, LSL #0
    SUB  X5, X25, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D10
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x1, LSL #16
    MOVK  X29, #0x8000, LSL #48
    SUB  X15, X29, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D11
    MOVZ  X20, #0xc488, LSL #0
    SUB  X18, X20, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D12
    MOVZ  X2, #0x7fff, LSL #0
    SUB  X7, X2, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D13
    MOVZ  X21, #0xffff, LSL #0
    SUB  X6, X21, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D14
    MOVZ  X6, #0x4042, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X9, X6, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D15
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x3ff2, LSL #48
    SUB  X14, X16, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D16
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X20, X29, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D17
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x8000, LSL #48
    SUB  X5, X27, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D18
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X28, X14, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D19
    MOVZ  X11, #0x7fff, LSL #0
    SUB  X13, X11, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D20
    MOVZ  X22, #0xffff, LSL #0
    SUB  X25, X22, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D21
    MOVZ  X9, #0x4042, LSL #0
    SUB  X5, X9, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D22
    MOVZ  X3, #0xfffe, LSL #0
    MOVK  X3, #0x8000, LSL #16
    SUB  X24, X3, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D23
    MOVZ  X27, #0x7fff, LSL #0
    SUB  X26, X27, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D25
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x1, LSL #16
    SUB  X18, X5, X15
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D26
    MOVZ  X13, #0x3c80, LSL #0
    SUB  X4, X13, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D27
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x1, LSL #16
    SUB  X26, X14, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D28
    MOVZ  X6, #0x7ffe, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X12, X6, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D29
    MOVZ  X15, #0xffff, LSL #0
    SUB  X10, X15, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0xaad7, LSL #0
    MOVK  X2, #0x1291, LSL #16
    MOVK  X2, #0x1e07, LSL #32
    MOVK  X2, #0xdc7c, LSL #48
    MOVZ  X3, #0x8904, LSL #0
    MOVK  X3, #0xd4b, LSL #16
    MOVK  X3, #0xede7, LSL #32
    MOVK  X3, #0xc6d8, LSL #48
    MOVZ  X4, #0x793, LSL #0
    MOVK  X4, #0x2a1d, LSL #16
    MOVK  X4, #0x980c, LSL #32
    MOVK  X4, #0xd7c4, LSL #48
    MOVZ  X5, #0xdd94, LSL #0
    MOVK  X5, #0xaf21, LSL #16
    MOVK  X5, #0xd3dd, LSL #32
    MOVK  X5, #0xd8cb, LSL #48
    MOVZ  X6, #0x706b, LSL #0
    MOVK  X6, #0x28da, LSL #16
    MOVK  X6, #0xeaa, LSL #32
    MOVK  X6, #0x3462, LSL #48
    MOVZ  X7, #0x91f0, LSL #0
    MOVK  X7, #0xfed5, LSL #16
    MOVK  X7, #0xe1d8, LSL #32
    MOVK  X7, #0x94ba, LSL #48
    MOVZ  X8, #0xc4fb, LSL #0
    MOVK  X8, #0x6fd5, LSL #16
    MOVK  X8, #0xfbc5, LSL #32
    MOVK  X8, #0x4f40, LSL #48
    MOVZ  X9, #0x7af6, LSL #0
    MOVK  X9, #0x3887, LSL #16
    MOVK  X9, #0x610e, LSL #32
    MOVK  X9, #0x71ac, LSL #48
    MOVZ  X10, #0xe850, LSL #0
    MOVK  X10, #0x3846, LSL #16
    MOVK  X10, #0x39f0, LSL #32
    MOVK  X10, #0x74fa, LSL #48
    MOVZ  X11, #0x9b17, LSL #0
    MOVK  X11, #0x24bf, LSL #16
    MOVK  X11, #0x7056, LSL #32
    MOVK  X11, #0xc2f0, LSL #48
    MOVZ  X12, #0xd3f2, LSL #0
    MOVK  X12, #0x17, LSL #16
    MOVK  X12, #0x72c5, LSL #32
    MOVK  X12, #0x5aad, LSL #48
    MOVZ  X13, #0xae4f, LSL #0
    MOVK  X13, #0x49b7, LSL #16
    MOVK  X13, #0x6cc6, LSL #32
    MOVK  X13, #0xba3, LSL #48
    MOVZ  X14, #0xf3f7, LSL #0
    MOVK  X14, #0xfb72, LSL #16
    MOVK  X14, #0x86c1, LSL #32
    MOVK  X14, #0x42f1, LSL #48
    MOVZ  X15, #0x8c74, LSL #0
    MOVK  X15, #0xa03a, LSL #16
    MOVK  X15, #0x3e31, LSL #32
    MOVK  X15, #0xba76, LSL #48
    MOVZ  X16, #0xb951, LSL #0
    MOVK  X16, #0xb9bc, LSL #16
    MOVK  X16, #0xff94, LSL #32
    MOVK  X16, #0x6709, LSL #48
    MOVZ  X17, #0xf321, LSL #0
    MOVK  X17, #0x4886, LSL #16
    MOVK  X17, #0xd0cd, LSL #32
    MOVK  X17, #0x896b, LSL #48
    MOVZ  X18, #0x2f1d, LSL #0
    MOVK  X18, #0xfce8, LSL #16
    MOVK  X18, #0xd4f, LSL #32
    MOVK  X18, #0x7937, LSL #48
    MOVZ  X19, #0x147c, LSL #0
    MOVK  X19, #0x4eb3, LSL #16
    MOVK  X19, #0xa0ef, LSL #32
    MOVK  X19, #0x4cf1, LSL #48
    MOVZ  X20, #0x6510, LSL #0
    MOVK  X20, #0x86a5, LSL #16
    MOVK  X20, #0xce15, LSL #32
    MOVK  X20, #0x4f1d, LSL #48
    MOVZ  X21, #0x932a, LSL #0
    MOVK  X21, #0x7305, LSL #16
    MOVK  X21, #0x6b22, LSL #32
    MOVK  X21, #0x9e71, LSL #48
    MOVZ  X22, #0x8f6f, LSL #0
    MOVK  X22, #0xfaa2, LSL #16
    MOVK  X22, #0x765f, LSL #32
    MOVK  X22, #0x95cd, LSL #48
    MOVZ  X23, #0x51a1, LSL #0
    MOVK  X23, #0x2a71, LSL #16
    MOVK  X23, #0x1287, LSL #32
    MOVK  X23, #0x2eb7, LSL #48
    MOVZ  X24, #0x77d4, LSL #0
    MOVK  X24, #0xb282, LSL #16
    MOVK  X24, #0x8492, LSL #32
    MOVK  X24, #0xf930, LSL #48
    MOVZ  X25, #0x645c, LSL #0
    MOVK  X25, #0x784e, LSL #16
    MOVK  X25, #0xbdca, LSL #32
    MOVK  X25, #0x648d, LSL #48
    MOVZ  X26, #0xe6e5, LSL #0
    MOVK  X26, #0x447e, LSL #16
    MOVK  X26, #0x4e46, LSL #32
    MOVK  X26, #0x5eb8, LSL #48
    MOVZ  X27, #0x5404, LSL #0
    MOVK  X27, #0x57e7, LSL #16
    MOVK  X27, #0xdf59, LSL #32
    MOVK  X27, #0x3c05, LSL #48
    MOVZ  X28, #0x1fa2, LSL #0
    MOVK  X28, #0x720a, LSL #16
    MOVK  X28, #0xfb0b, LSL #32
    MOVK  X28, #0xa771, LSL #48
    MOVZ  X29, #0x5485, LSL #0
    MOVK  X29, #0x8c8a, LSL #16
    MOVK  X29, #0xa185, LSL #32
    MOVK  X29, #0x4c0d, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X8
    FMOV  D1, X15
    FMOV  V1.D[1], X29
    FMOV  D2, X16
    FMOV  V2.D[1], X26
    FMOV  D3, X29
    FMOV  V3.D[1], X27
    FMOV  D4, X26
    FMOV  V4.D[1], X13
    FMOV  D5, X7
    FMOV  V5.D[1], X3
    FMOV  D6, X14
    FMOV  V6.D[1], X16
    FMOV  D7, X4
    FMOV  V7.D[1], X28
    FMOV  D8, X27
    FMOV  V8.D[1], X28
    FMOV  D9, X6
    FMOV  V9.D[1], X10
    FMOV  D10, X9
    FMOV  V10.D[1], X5
    FMOV  D11, X18
    FMOV  V11.D[1], X22
    FMOV  D12, X25
    FMOV  V12.D[1], X25
    FMOV  D13, X5
    FMOV  V13.D[1], X16
    FMOV  D14, X14
    FMOV  V14.D[1], X24
    FMOV  D15, X14
    FMOV  V15.D[1], X23
    FMOV  D16, X9
    FMOV  V16.D[1], X18
    FMOV  D17, X13
    FMOV  V17.D[1], X20
    FMOV  D18, X5
    FMOV  V18.D[1], X26
    FMOV  D19, X12
    FMOV  V19.D[1], X26
    FMOV  D20, X8
    FMOV  V20.D[1], X25
    FMOV  D21, X16
    FMOV  V21.D[1], X13
    FMOV  D22, X24
    FMOV  V22.D[1], X28
    FMOV  D23, X20
    FMOV  V23.D[1], X9
    FMOV  D24, X17
    FMOV  V24.D[1], X25
    FMOV  D25, X10
    FMOV  V25.D[1], X22
    FMOV  D26, X3
    FMOV  V26.D[1], X2
    FMOV  D27, X25
    FMOV  V27.D[1], X24
    FMOV  D28, X3
    FMOV  V28.D[1], X16
    FMOV  D29, X25
    FMOV  V29.D[1], X25
    FMOV  D30, X2
    FMOV  V30.D[1], X13
    FMOV  D31, X21
    FMOV  V31.D[1], X5
    MOVZ  X20, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_259:
    FMADD  S6, S6, S30, S24
    FNMADD  H12, H12, H23, H8
    FNMSUB  S6, S4, S28, S1
    FMOV  H0, H28
    FMSUB  S29, S28, S13, S29
    FMOV  H21, #-29.00000000
    FNMADD  S29, S2, S4, S13
    FNMSUB  S0, S11, S19, S14
    FMOV  H26, #13.00000000
    FMOV  H3, X16
    FMSUB  S29, S10, S12, S27
    FMADD  H31, H0, H21, H3
    FNMSUB  S21, S16, S16, S30
    FMOV  H25, X5
    FMSUB  H28, H6, H11, H6
    FMOV  X25, D27
    FNMSUB  H18, H21, H29, H28
    FMOV  D14, #-1.25000000
    FNMSUB  S2, S3, S2, S11
    FMSUB  H14, H8, H10, H11
    FNMSUB  H10, H26, H6, H17
    FMOV  X4, D2
    FMOV  H3, W21
    FMADD  S13, S14, S6, S4
    FMSUB  S9, S19, S31, S4
    FMADD  H9, H6, H14, H15
    FMOV  D0, #-1.68750000
    FMOV  H15, W5
    FMSUB  H8, H25, H28, H5
    FMSUB  D18, D8, D8, D9
    FMADD  S27, S12, S24, S26
    FMOV  H18, H5
    FMOV  H10, H3
    FMOV  X19, D0
    FMOV  W13, H10
    FNMADD  D9, D30, D27, D19
    FMOV  W3, H17
    FMSUB  H23, H3, H8, H17
    FMOV  S18, S21
    FMOV  H0, H9
    FMSUB  S31, S10, S9, S6
    FMOV  H31, #1.18750000
    FMOV  H30, H4
    FMSUB  H29, H13, H20, H15
    FMOV  W2, S23
    FMADD  H18, H3, H4, H2
    FMOV  X17, H28
    FNMSUB  D21, D19, D25, D11
    FMOV  D4, D0
    FNMADD  D26, D21, D4, D18
    FMOV  X19, D7
    FMOV  S15, S19
    FNMSUB  D5, D8, D29, D23
    FMOV  H5, #26.00000000
    FMOV  W28, S14
    FNMSUB  H12, H21, H5, H8
    FMADD  D13, D21, D8, D12
    FMOV  X26, H13
    FMOV  D27, X11
    FMOV  D9, #0.29687500
    FMOV  H26, X4
    FMOV  D15, #-2.50000000
    FMOV  X24, H15
    FMOV  S21, #-27.00000000
    FMADD  S30, S9, S12, S21
    FNMSUB  H29, H9, H26, H0
    FMSUB  D25, D28, D27, D27
    FMOV  S10, #4.75000000
    FMOV  D21, #-6.25000000
    FMOV  S21, W28
    FMOV  D15, X16
    FNMSUB  S6, S15, S22, S5
    FMOV  X23, H21
    FMOV  H10, #-23.00000000
    FMOV  H22, X8
    FMOV  S22, S29
    FMOV  D22, D4
    FNMSUB  H28, H3, H23, H28
    FNMSUB  D15, D2, D31, D15
    FMOV  W16, S11
    FNMADD  D28, D19, D4, D26
    FMOV  H29, #0.34375000
    FMOV  D28, X6
    FMOV  H10, X5
    FNMADD  D30, D31, D14, D10
    FNMADD  S0, S5, S11, S6
    FMOV  X6, D29
    FMADD  S3, S0, S11, S28
    FMOV  H19, X25
    FMSUB  S19, S24, S11, S0
    FMADD  H30, H13, H17, H29
    FNMADD  S27, S11, S8, S20
    FMOV  H25, H23
    FMOV  H30, W19
    FMOV  S10, W28
    FMOV  X28, H6
    FNMSUB  H5, H3, H22, H11
    FMOV  H25, H4
    FMADD  D21, D20, D14, D6
    FMADD  D5, D13, D5, D8
    FMOV  W16, S21
    FNMADD  S10, S29, S26, S19
    FMSUB  H5, H30, H25, H6
    FNMSUB  D24, D5, D26, D27
    FNMSUB  D24, D24, D21, D28
    FMOV  S18, #0.84375000
    FNMADD  H25, H10, H6, H19
    FMOV  D8, #-1.56250000
    FMOV  W23, H0
    FMSUB  D26, D27, D17, D18
    FNMADD  S8, S20, S30, S6
    FNMADD  S5, S6, S1, S26
    FMOV  S25, S8
    FMOV  W27, H10
    FMADD  D14, D10, D24, D8
    FNMSUB  D26, D29, D30, D23
    FMOV  S1, #-0.90625000
    FNMADD  D14, D20, D9, D8
    FMOV  S10, S10
    FNMSUB  H4, H4, H1, H5
    FNMADD  S30, S4, S3, S7
    FMSUB  D2, D26, D27, D5
    FMOV  H13, X17
    FMOV  W21, H14
    FNMSUB  D27, D10, D12, D24
    FMOV  D12, #1.12500000
    FMADD  S24, S18, S29, S7
    FMOV  H16, H19
    FNMSUB  H30, H14, H20, H5
    FMOV  H14, H4
    FMOV  S8, W15
    FMSUB  H12, H9, H3, H14
    FMOV  H2, #18.00000000
    FNMSUB  D26, D29, D10, D7
    FMOV  H1, X8
    FMOV  S26, S29
    FMSUB  H29, H25, H2, H2
    FMOV  H2, X6
    FMADD  D11, D15, D18, D5
    FMOV  D5, X26
    FMOV  H31, W10
    FMOV  S14, #-18.00000000
    FMADD  D6, D29, D20, D28
    FMOV  H14, H18
    FMADD  S9, S29, S16, S18
    FMOV  W7, H4
    FMOV  S31, S20
    FMADD  H17, H14, H20, H10
    FMOV  X6, H4
    FMOV  H20, W2
    FNMSUB  H8, H8, H15, H28
    FMOV  H18, W7
    FMSUB  H24, H22, H25, H11
    FMOV  D1, D23
    FMOV  S7, S1
    FNMADD  S21, S20, S1, S17
    FMOV  S25, S26
    FMOV  D17, D12
    FMOV  X23, H5
    FNMADD  D25, D12, D8, D23
    FMSUB  H28, H21, H18, H27
    FMOV  H4, X26
    FMOV  D23, #0.39062500
    FMOV  W11, H31
    FMOV  D1, X17
    FMOV  X24, D7
    FNMSUB  H24, H8, H14, H18
    FMSUB  D1, D4, D12, D27
    FMOV  D12, #-8.50000000
    FMOV  H12, W20
    FMOV  W6, H23
    FNMSUB  D25, D12, D4, D29
    FNMSUB  S12, S24, S24, S28
    FNMSUB  S12, S1, S3, S5
    FMOV  S28, S25
    FNMSUB  D17, D6, D23, D7
    FMSUB  S26, S4, S1, S18
    FMADD  S26, S12, S12, S7
    FMOV  D2, X6
    FMOV  D27, D24
    FMOV  H12, #-0.22656250
    FMOV  X28, D23
    FMSUB  D18, D28, D30, D19
    FNMADD  D29, D16, D29, D2
    FMOV  H30, #28.00000000
    FMOV  D16, X16
    FNMADD  S26, S8, S6, S14
    FMOV  D6, X8
    FNMADD  D3, D23, D21, D25
    FMOV  H8, X9
    FMOV  S12, #-4.75000000
    FMSUB  H25, H14, H22, H12
    FMOV  H24, X24
    FMOV  X26, H11
    FMOV  S13, S10
    FMADD  S9, S23, S21, S21
    FMOV  D10, #0.14843750
    FNMSUB  D8, D17, D18, D12
    FMOV  H17, W3
    FMOV  H22, H20
    SUBS  X20, X20, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_259
    MOVZ  X14, #0x7e01, LSL #0
    SUB  X6, X14, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0xae4f, LSL #0
    SUB  X8, X2, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0x3f57, LSL #16
    SUB  X20, X12, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0xdd94, LSL #0
    MOVK  X23, #0xaf21, LSL #16
    MOVK  X23, #0xd3dd, LSL #32
    MOVK  X23, #0xd8cb, LSL #48
    SUB  X8, X23, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x7fff, LSL #0
    SUB  X18, X14, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x7af6, LSL #0
    MOVK  X24, #0x3887, LSL #16
    MOVK  X24, #0x610e, LSL #32
    MOVK  X24, #0x71ac, LSL #48
    SUB  X23, X24, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0x3f57, LSL #16
    SUB  X24, X23, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x4e81, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X4, X12, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    SUB  X16, X24, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0xfe01, LSL #0
    SUB  X27, X5, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X22
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    SUB  X19, X27, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    SUB  X9, X12, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    SUB  X11, X3, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x5485, LSL #0
    MOVK  X6, #0x8c8a, LSL #16
    MOVK  X6, #0xa185, LSL #32
    MOVK  X6, #0x4c0d, LSL #48
    SUB  X28, X6, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D3
    MOVZ  X6, #0x8431, LSL #0
    MOVK  X6, #0x31ff, LSL #16
    MOVK  X6, #0x8000, LSL #48
    SUB  X17, X6, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D4
    MOVZ  X12, #0xfe01, LSL #0
    SUB  X17, X12, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D5
    MOVZ  X7, #0xfe01, LSL #0
    SUB  X16, X7, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D6
    MOVZ  X23, #0xc4fb, LSL #0
    MOVK  X23, #0x6fd5, LSL #16
    MOVK  X23, #0xfbc5, LSL #32
    MOVK  X23, #0x4f40, LSL #48
    SUB  X14, X23, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D7
    MOVZ  X29, #0x7e01, LSL #0
    SUB  X27, X29, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D8
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc098, LSL #16
    MOVK  X17, #0x8000, LSL #48
    SUB  X9, X17, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X15, X19, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D9
    MOVZ  X19, #0xfe01, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X15, X19, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D10
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x3fc3, LSL #48
    SUB  X15, X21, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D11
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xbf57, LSL #16
    SUB  X24, X25, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D12
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xc098, LSL #16
    SUB  X19, X2, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D13
    MOVZ  X20, #0x670d, LSL #0
    MOVK  X20, #0x8001, LSL #16
    SUB  X10, X20, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D14
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D15
    MOVZ  X13, #0x4e80, LSL #0
    MOVK  X13, #0x8000, LSL #16
    MOVK  X13, #0x8000, LSL #48
    SUB  X24, X13, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D16
    MOVZ  X12, #0x4e81, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X11, X12, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D17
    MOVZ  X3, #0xae4f, LSL #0
    SUB  X19, X3, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D18
    MOVZ  X28, #0x670d, LSL #0
    MOVK  X28, #0x1, LSL #16
    SUB  X25, X28, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D19
    MOVZ  X25, #0x670d, LSL #0
    MOVK  X25, #0x1, LSL #16
    SUB  X21, X25, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D20
    MOVZ  X8, #0x7e01, LSL #0
    SUB  X26, X8, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D21
    MOVZ  X25, #0xfe01, LSL #0
    MOVK  X25, #0x8000, LSL #16
    SUB  X3, X25, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D22
    MOVZ  X7, #0x7e01, LSL #0
    SUB  X27, X7, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D23
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3fd9, LSL #48
    SUB  X25, X10, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D24
    MOVZ  X16, #0x7e01, LSL #0
    SUB  X11, X16, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D25
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D26
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x8000, LSL #16
    SUB  X5, X9, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D27
    MOVZ  X18, #0xffff, LSL #0
    SUB  X17, X18, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D28
    MOVZ  X2, #0xdf07, LSL #0
    SUB  X4, X2, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D29
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #48
    SUB  X19, X8, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X24
    FMOV  V0.D[1], X7
    FMOV  D1, X8
    FMOV  V1.D[1], X27
    FMOV  D2, X19
    FMOV  V2.D[1], X23
    FMOV  D3, X24
    FMOV  V3.D[1], X3
    FMOV  D4, X19
    FMOV  V4.D[1], X22
    FMOV  D5, X9
    FMOV  V5.D[1], X16
    FMOV  D6, X11
    FMOV  V6.D[1], X27
    FMOV  D7, X21
    FMOV  V7.D[1], X28
    FMOV  D8, X22
    FMOV  V8.D[1], X18
    FMOV  D9, X3
    FMOV  V9.D[1], X17
    FMOV  D10, X24
    FMOV  V10.D[1], X2
    FMOV  D11, X25
    FMOV  V11.D[1], X27
    FMOV  D12, X28
    FMOV  V12.D[1], X6
    FMOV  D13, X2
    FMOV  V13.D[1], X26
    FMOV  D14, X11
    FMOV  V14.D[1], X11
    FMOV  D15, X4
    FMOV  V15.D[1], X7
    FMOV  D16, X11
    FMOV  V16.D[1], X9
    FMOV  D17, X11
    FMOV  V17.D[1], X25
    FMOV  D18, X9
    FMOV  V18.D[1], X22
    FMOV  D19, X5
    FMOV  V19.D[1], X8
    FMOV  D20, X4
    FMOV  V20.D[1], X29
    FMOV  D21, X21
    FMOV  V21.D[1], X25
    FMOV  D22, X25
    FMOV  V22.D[1], X18
    FMOV  D23, X25
    FMOV  V23.D[1], X27
    FMOV  D24, X11
    FMOV  V24.D[1], X21
    FMOV  D25, X20
    FMOV  V25.D[1], X13
    FMOV  D26, X22
    FMOV  V26.D[1], X15
    FMOV  D27, X11
    FMOV  V27.D[1], X29
    FMOV  D28, X3
    FMOV  V28.D[1], X18
    FMOV  D29, X25
    FMOV  V29.D[1], X26
    FMOV  D30, X24
    FMOV  V30.D[1], X24
    FMOV  D31, X5
    FMOV  V31.D[1], X13
    MOVZ  X8, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_344:
    FMOV  H5, X10
    FMSUB  D27, D10, D2, D10
    FNMADD  D30, D14, D29, D25
    FMOV  H7, X21
    FNMADD  H12, H9, H19, H6
    FMSUB  H8, H19, H22, H19
    FNMADD  D31, D13, D20, D10
    FNMADD  D28, D13, D5, D4
    FMOV  W15, S10
    FMADD  D6, D6, D22, D9
    FMOV  H7, H25
    FMOV  S28, #-2.12500000
    FMOV  S18, W23
    FMOV  H28, #4.75000000
    FNMSUB  D25, D26, D8, D14
    FMOV  H21, H31
    FMSUB  S31, S9, S15, S10
    FMADD  S13, S4, S27, S11
    FMOV  D31, X21
    FMSUB  H27, H27, H30, H0
    FMSUB  S22, S28, S18, S2
    FMOV  H23, #-0.59375000
    FNMADD  D0, D16, D12, D20
    FMADD  S29, S20, S22, S5
    FNMSUB  H3, H19, H8, H18
    FMOV  S25, W23
    FNMADD  H22, H3, H12, H5
    FNMADD  S31, S31, S22, S12
    FNMSUB  H1, H21, H23, H23
    FMOV  H5, X14
    FNMSUB  H15, H27, H24, H27
    FNMSUB  D19, D2, D29, D12
    FMOV  H9, #1.31250000
    FMOV  X2, H28
    FMOV  W14, S29
    FMOV  D31, X21
    FMOV  D31, X18
    FMOV  X25, H9
    FMOV  H17, X10
    FMOV  S0, W11
    FMOV  H3, W23
    FMOV  X24, H7
    FMOV  D17, #0.68750000
    FMOV  H19, X4
    FMADD  S15, S31, S31, S7
    FNMSUB  S5, S13, S3, S29
    FNMADD  S0, S28, S22, S19
    FMOV  W16, S1
    FNMADD  H17, H18, H9, H31
    FMOV  X5, D15
    FMADD  S27, S10, S3, S7
    FMOV  H5, #-2.00000000
    FNMADD  H24, H31, H19, H0
    FMADD  H13, H31, H18, H3
    FMOV  S21, W11
    FMADD  H10, H0, H13, H19
    FMOV  H29, X21
    FMADD  S5, S19, S29, S13
    FNMSUB  H0, H24, H0, H21
    FMOV  S21, #-22.00000000
    FNMSUB  S9, S24, S14, S10
    FMOV  H28, H7
    FMOV  D26, X23
    FNMSUB  H31, H29, H19, H21
    FMOV  S24, W4
    FMOV  X6, D28
    FNMSUB  D15, D2, D28, D22
    FMADD  S16, S21, S7, S22
    FMADD  H27, H20, H23, H26
    FMOV  D13, X22
    FMADD  H12, H15, H18, H15
    FNMADD  S31, S30, S2, S14
    FMSUB  H10, H12, H6, H10
    FNMADD  S6, S22, S14, S12
    FMOV  D11, D6
    FMOV  D29, D1
    FMSUB  S24, S0, S1, S31
    FMSUB  D28, D17, D29, D10
    FMADD  S29, S31, S0, S9
    FNMADD  D15, D7, D18, D10
    FNMADD  D28, D5, D6, D28
    FMADD  S18, S12, S6, S28
    FMOV  W12, S19
    FMOV  D14, D12
    FMSUB  D25, D20, D17, D24
    FMSUB  S28, S22, S12, S26
    FNMSUB  D13, D22, D3, D13
    FMOV  S24, W24
    FMOV  D12, D4
    FMOV  D12, #-3.37500000
    FMOV  X9, D30
    FMOV  H5, H20
    FMADD  D23, D15, D21, D17
    FMSUB  H25, H14, H0, H3
    FMOV  H12, W16
    FMADD  S10, S17, S16, S28
    FMOV  D29, #-2.25000000
    FMOV  X20, H24
    FNMSUB  S1, S18, S14, S5
    FMSUB  H19, H25, H27, H3
    FMOV  H17, W2
    FNMADD  H2, H6, H1, H14
    FMOV  S29, #-5.25000000
    FMADD  H4, H0, H13, H25
    FNMSUB  S0, S24, S24, S23
    FMOV  D24, D31
    FMOV  S28, W19
    FMOV  H3, #1.37500000
    FNMADD  S3, S7, S1, S9
    FMOV  W11, H26
    FNMSUB  D3, D29, D15, D26
    FMOV  S26, S0
    FMSUB  D28, D1, D30, D26
    FNMADD  H10, H29, H20, H19
    FMOV  S21, S18
    FMOV  D1, X20
    FMOV  H17, H14
    FMSUB  H20, H6, H12, H7
    FMADD  H6, H2, H22, H23
    FMADD  S13, S16, S16, S31
    FMOV  X24, D2
    FMOV  S16, S15
    FMOV  D10, D11
    FMOV  S9, S16
    FMOV  H22, W10
    FMOV  H16, H23
    FMOV  H26, X9
    FMADD  D25, D27, D30, D21
    FNMSUB  S3, S13, S0, S31
    FNMADD  S24, S7, S2, S5
    FMOV  H3, X26
    FMSUB  D0, D1, D30, D0
    FMOV  X14, D28
    FMSUB  H30, H13, H15, H6
    FNMADD  D10, D12, D15, D21
    FMOV  D14, X20
    FMOV  H7, H11
    FMOV  D9, #0.23437500
    FMOV  W5, H30
    FNMADD  S21, S21, S25, S19
    FMOV  H15, W13
    FNMADD  S6, S2, S25, S15
    FNMSUB  S17, S7, S17, S21
    FMOV  D4, D3
    FNMSUB  S28, S1, S9, S18
    FMOV  S12, S24
    FNMADD  D19, D23, D12, D23
    FMOV  H13, W14
    FMADD  D31, D21, D0, D21
    FMOV  H16, X10
    FMOV  W29, H9
    FNMADD  H31, H18, H22, H23
    FMSUB  D19, D12, D22, D16
    FMADD  H18, H25, H12, H9
    FMSUB  D22, D8, D17, D3
    FMOV  D6, D21
    FMOV  H6, H24
    FMOV  H18, H2
    FMOV  X5, D4
    FMOV  H25, X15
    FNMADD  D3, D30, D7, D29
    FMOV  D20, X23
    FMOV  D22, X2
    FMOV  S9, W9
    FMOV  S20, #-2.37500000
    FMOV  D24, X18
    FMOV  H21, W2
    FMADD  H8, H13, H12, H6
    FMSUB  S25, S19, S27, S28
    FMOV  D13, D22
    FMOV  W16, H17
    FMADD  H6, H25, H10, H16
    FMOV  S22, #-13.50000000
    FMOV  S9, S12
    FMOV  S24, W6
    FMSUB  S4, S2, S7, S31
    FNMADD  D25, D14, D18, D17
    FMSUB  H24, H19, H4, H8
    FMADD  S24, S4, S30, S23
    FMOV  H20, W23
    FMOV  D1, D30
    FMADD  H0, H14, H14, H18
    FMOV  S11, W17
    FMSUB  H24, H21, H23, H8
    FMOV  X27, D13
    FMSUB  S29, S18, S0, S28
    FMADD  S19, S28, S28, S28
    FNMSUB  D4, D24, D17, D10
    FMOV  D2, X2
    FMOV  W27, S14
    FMOV  D0, D30
    FMOV  H21, #0.21875000
    FMOV  X7, D20
    FMOV  W11, H5
    FNMSUB  H0, H28, H4, H30
    FNMADD  H10, H25, H3, H18
    FMOV  H30, H6
    FMADD  S28, S2, S28, S29
    FMOV  S15, #-7.50000000
    FMOV  D1, D24
    SUBS  X8, X8, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_344
    MOVZ  X22, #0x44c0, LSL #0
    SUB  X7, X22, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x8000, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X17, X29, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x3d40, LSL #0
    SUB  X24, X15, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0x8000, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X10, X27, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D2
    MOVZ  X5, #0x44c0, LSL #0
    SUB  X11, X5, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D3
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xc0a8, LSL #16
    MOVK  X29, #0x8000, LSL #48
    SUB  X17, X29, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D4
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D8
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D9
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #16
    SUB  X5, X22, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D12
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X20, X28, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D13
    MOVZ  X2, #0x44c0, LSL #0
    SUB  X11, X2, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D14
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D15
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xc0f0, LSL #16
    SUB  X18, X4, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D18
    MOVZ  X4, #0x8000, LSL #0
    SUB  X6, X4, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D19
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D20
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D21
    MOVZ  X6, #0x3300, LSL #0
    SUB  X16, X6, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D22
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xc158, LSL #16
    SUB  X20, X16, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D23
    MOVZ  X8, #0x8000, LSL #0
    SUB  X16, X8, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D25
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X14, X6, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D27
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D28
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X12
    FMOV  D1, X6
    FMOV  V1.D[1], X29
    FMOV  D2, X22
    FMOV  V2.D[1], X12
    FMOV  D3, X10
    FMOV  V3.D[1], X23
    FMOV  D4, X11
    FMOV  V4.D[1], X6
    FMOV  D5, X27
    FMOV  V5.D[1], X19
    FMOV  D6, X22
    FMOV  V6.D[1], X11
    FMOV  D7, X6
    FMOV  V7.D[1], X4
    FMOV  D8, X22
    FMOV  V8.D[1], X15
    FMOV  D9, X15
    FMOV  V9.D[1], X16
    FMOV  D10, X14
    FMOV  V10.D[1], X8
    FMOV  D11, X18
    FMOV  V11.D[1], X27
    FMOV  D12, X23
    FMOV  V12.D[1], X15
    FMOV  D13, X8
    FMOV  V13.D[1], X15
    FMOV  D14, X11
    FMOV  V14.D[1], X12
    FMOV  D15, X19
    FMOV  V15.D[1], X17
    FMOV  D16, X12
TaishanFpMiniMaxiP01_label_428:
    FMOV  V16.D[1], X21
    FMOV  D17, X25
    FMOV  V17.D[1], X3
    FMOV  D18, X20
TaishanFpMiniMaxiP01_label_319:
    FMOV  V18.D[1], X19
    FMOV  D19, X24
    FMOV  V19.D[1], X7
    FMOV  D20, X27
    FMOV  V20.D[1], X25
    FMOV  D21, X9
    FMOV  V21.D[1], X24
    FMOV  D22, X18
    FMOV  V22.D[1], X12
    FMOV  D23, X13
    FMOV  V23.D[1], X11
    FMOV  D24, X8
    FMOV  V24.D[1], X25
    FMOV  D25, X28
    FMOV  V25.D[1], X17
    FMOV  D26, X6
    FMOV  V26.D[1], X9
    FMOV  D27, X3
    FMOV  V27.D[1], X7
    FMOV  D28, X6
    FMOV  V28.D[1], X4
    FMOV  D29, X8
    FMOV  V29.D[1], X24
    FMOV  D30, X6
    FMOV  V30.D[1], X28
    FMOV  D31, X13
    FMOV  V31.D[1], X25
    MOVZ  X22, #0xf, LSL #0
TaishanFpMiniMaxiP01_label_430:
    FMOV  S24, #27.00000000
    FMOV  W19, H17
    FMOV  D17, X5
    FMSUB  S7, S31, S17, S30
    FNMSUB  S19, S1, S29, S15
    FMADD  H27, H28, H17, H26
    FNMSUB  D17, D22, D19, D21
    FMOV  S7, W5
    FMADD  H24, H7, H26, H14
    FMOV  W15, H20
    FMADD  H27, H24, H0, H17
    FMOV  H27, W7
    FMOV  D3, D14
    FMADD  S14, S3, S18, S3
    FNMADD  D1, D18, D27, D0
    FMADD  D14, D25, D5, D13
    FMOV  D5, D25
    FMOV  H9, W9
    FMADD  S0, S1, S25, S9
    FMSUB  H5, H15, H25, H0
    FMADD  S4, S16, S29, S17
    FMOV  X14, H28
    FNMSUB  D4, D2, D21, D29
    FMSUB  D19, D3, D17, D21
    FMOV  X9, D1
    FMOV  D14, D19
    FMSUB  D28, D7, D26, D18
    FNMSUB  S17, S5, S5, S25
    FNMSUB  S0, S2, S29, S4
    FMOV  W7, S11
    FMOV  W16, S0
    FMSUB  D6, D17, D14, D23
    FMOV  D1, X23
    FNMSUB  H21, H3, H22, H29
    FMOV  H16, W7
    FMOV  H26, #0.20312500
    FNMSUB  S29, S10, S16, S23
    FMOV  D29, X25
    FMOV  H21, #-0.45312500
    FNMADD  D31, D23, D10, D18
    FMOV  S20, #2.12500000
    FMOV  X20, D7
    FNMADD  S28, S19, S26, S20
    FMOV  D25, X12
    FNMADD  H5, H31, H5, H0
    FMOV  S2, W12
    FMOV  D7, D5
    FNMSUB  S19, S9, S28, S29
    FMOV  H0, #0.96875000
    FMADD  S1, S21, S25, S7
    FMOV  H14, #-1.00000000
    FNMSUB  D30, D10, D11, D23
    FMOV  X18, D9
    FNMADD  D21, D3, D10, D24
    FNMADD  S3, S1, S14, S2
    FMOV  D29, D24
    FNMSUB  S24, S20, S13, S0
    FMOV  D30, D6
    FMADD  D9, D26, D28, D22
    FMOV  H0, H14
    FMOV  D6, D29
    FMOV  X13, H19
    FMOV  D21, X11
    FNMADD  D29, D7, D10, D0
    FMOV  S2, W16
    FNMSUB  S24, S23, S5, S30
    FMOV  X7, H11
    FMOV  H28, X28
    FMOV  X24, H3
    FNMADD  S20, S9, S20, S20
    FMOV  H20, H25
    FMOV  D5, X3
    FMOV  D16, #-0.29687500
    FMOV  D4, X15
    FMOV  S12, S21
    FMSUB  D29, D12, D10, D6
    FNMADD  S22, S23, S24, S3
    FMOV  H5, H2
    FMOV  S11, W6
    FMOV  S7, W19
    FNMADD  D7, D11, D6, D4
    FMOV  X3, H23
    FMADD  S23, S4, S28, S10
    FMSUB  D26, D24, D21, D11
    FMOV  X6, H6
    FNMADD  H24, H14, H22, H6
    FNMSUB  H4, H17, H13, H28
    FMOV  W3, H5
    FMOV  H16, #6.25000000
    FMOV  D5, X17
    FNMSUB  H4, H15, H2, H27
    FMADD  H24, H9, H24, H21
    FNMADD  H7, H9, H10, H12
    FMOV  X7, D14
    FMADD  S31, S26, S17, S2
    FMOV  X7, H3
    FMOV  X18, D11
    FNMADD  D0, D31, D25, D16
    FNMSUB  S13, S28, S13, S30
    FMOV  W25, H9
    FMOV  S8, S9
    FMSUB  D30, D6, D13, D7
    FMOV  S28, W28
    FNMSUB  S27, S8, S3, S5
    FMADD  S23, S19, S3, S22
    FMOV  H31, H3
    FMOV  X20, D31
    FMOV  H28, #-17.00000000
    FNMSUB  S2, S30, S10, S24
    FMOV  H0, X18
    FMOV  W4, S23
    FMOV  S26, W7
    FMOV  H25, #9.50000000
    FMSUB  S27, S4, S23, S8
    FNMSUB  S1, S6, S25, S23
    FMSUB  H2, H16, H13, H20
    FMOV  H8, #-0.75000000
    FMADD  D28, D26, D13, D5
    FMOV  S31, W25
    FMADD  H30, H24, H19, H29
    FMOV  H5, X18
    FMSUB  D1, D6, D5, D16
    FNMSUB  D0, D17, D1, D12
    FMADD  H12, H10, H22, H31
    FMSUB  D4, D12, D25, D0
    FMOV  H3, W13
    FMOV  S30, #-13.50000000
    FMOV  H24, W25
    FNMADD  D28, D11, D26, D2
    FMOV  S11, #0.45312500
    FMOV  X18, D24
    FMOV  D18, #-14.50000000
    FMOV  W4, H12
    FMSUB  S27, S31, S25, S9
    FMOV  H19, H9
    FMADD  S20, S4, S16, S21
    FMADD  D15, D24, D22, D13
    FMADD  H27, H3, H19, H6
    FMOV  H31, #3.50000000
    FMOV  S18, S17
    FMOV  S8, W25
    FNMADD  D18, D8, D1, D15
    FMOV  W25, H7
    FMADD  D0, D28, D2, D12
    FMOV  S31, W6
    FMOV  D19, X7
    FMSUB  H31, H18, H10, H7
    FMOV  D28, #-14.50000000
    FMOV  W15, H4
    FMOV  H0, H0
    FNMSUB  S12, S11, S17, S6
    FNMADD  H12, H24, H11, H9
    FNMADD  D5, D11, D28, D20
    FMSUB  H6, H30, H20, H14
    FMOV  S4, #14.50000000
    FMOV  S23, W2
    FNMSUB  D10, D21, D23, D16
    FNMSUB  D0, D19, D30, D20
    FNMADD  H29, H19, H26, H7
    FMOV  D1, #0.71875000
    FMOV  D31, X9
    FNMSUB  H27, H15, H21, H22
    FMOV  S21, W23
    FMOV  S12, S12
    FMADD  S21, S5, S30, S9
    FMOV  H7, X7
    FMOV  X26, D18
    FMOV  H31, W15
    FMOV  S23, S1
    FNMADD  D6, D31, D30, D22
    FNMADD  H6, H7, H27, H29
    FNMADD  H17, H28, H28, H6
    FMOV  D21, #0.15625000
    FMADD  H5, H9, H3, H21
    FNMSUB  D28, D20, D25, D13
    FMSUB  H26, H14, H6, H28
    FNMSUB  H22, H12, H27, H15
    FMADD  H0, H25, H6, H17
    FMOV  H19, H13
    FMOV  D9, X15
    FMADD  D17, D20, D18, D28
    FMADD  D15, D15, D28, D6
    FMOV  W28, S22
    FMSUB  H31, H19, H12, H25
    FMOV  S16, W21
    FNMADD  D17, D3, D17, D5
    FMOV  D23, D21
    FMOV  X24, H17
    FMSUB  H27, H26, H23, H24
    FMSUB  S17, S26, S30, S16
    FNMSUB  D20, D14, D7, D9
    FMOV  S27, W13
    FMOV  W13, H27
    FNMADD  S0, S18, S17, S13
    FMOV  S23, #-0.68750000
    FNMSUB  D6, D26, D13, D7
    FMOV  H4, X22
    FMOV  W19, S20
    FNMSUB  D18, D10, D4, D14
    FNMADD  S24, S18, S11, S10
    SUBS  X22, X22, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_430
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X23, X22, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0xd7fe, LSL #0
    SUB  X22, X16, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    SUB  X7, X27, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    SUB  X15, X5, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X18, X26, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X2, X13, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X26, X6, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X24, X5, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0x7fff, LSL #48
    SUB  X15, X14, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X22, X7, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0xd7fe, LSL #0
    SUB  X12, X11, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0xfffd, LSL #0
    SUB  X28, X18, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    SUB  X28, X22, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X25, X6, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    SUB  X13, X28, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    SUB  X12, X24, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D2
    MOVZ  X7, #0xffff, LSL #0
    SUB  X17, X7, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D3
    MOVZ  X4, #0x9ffc, LSL #0
    SUB  X29, X4, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D4
    MOVZ  X26, #0x1, LSL #0
    SUB  X16, X26, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D6
    MOVZ  X12, #0xfffe, LSL #0
    MOVK  X12, #0x8000, LSL #48
    SUB  X7, X12, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D7
    MOVZ  X5, #0xffff, LSL #0
    SUB  X26, X5, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D8
    MOVZ  X2, #0x8000, LSL #0
    SUB  X17, X2, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D9
    MOVZ  X10, #0xfffe, LSL #0
    SUB  X22, X10, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D10
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X21, X17, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D11
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3ee8, LSL #16
    SUB  X10, X14, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D12
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D13
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x7fff, LSL #16
    SUB  X14, X4, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D14
    MOVZ  X3, #0xbc00, LSL #0
    SUB  X12, X3, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D15
    MOVZ  X6, #0x7fff, LSL #0
    SUB  X22, X6, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D16
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    SUB  X5, X29, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D17
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X16, X7, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D18
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D19
    MOVZ  X24, #0xffff, LSL #0
    SUB  X7, X24, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D20
    MOVZ  X24, #0xfffd, LSL #0
    MOVK  X24, #0x8000, LSL #48
    SUB  X16, X24, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D21
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3fc4, LSL #48
    SUB  X4, X6, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D22
    MOVZ  X18, #0x7fff, LSL #0
    SUB  X10, X18, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D23
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xbf30, LSL #16
    SUB  X26, X8, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D24
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    SUB  X2, X15, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D25
    MOVZ  X18, #0x48c0, LSL #0
    SUB  X24, X18, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D26
    MOVZ  X10, #0xfffe, LSL #0
    SUB  X23, X10, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D27
    MOVZ  X8, #0x9ffc, LSL #0
    SUB  X9, X8, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D28
    MOVZ  X9, #0xfffe, LSL #0
    MOVK  X9, #0x7fff, LSL #16
    MOVK  X9, #0x8000, LSL #48
    SUB  X16, X9, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D29
    MOVZ  X27, #0xffff, LSL #0
    SUB  X12, X27, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0xddeb, LSL #0
    MOVK  X2, #0xb77c, LSL #16
    MOVK  X2, #0x56f7, LSL #32
    MOVK  X2, #0xada2, LSL #48
    MOVZ  X3, #0x7314, LSL #0
    MOVK  X3, #0x6696, LSL #16
    MOVK  X3, #0xfc86, LSL #32
    MOVK  X3, #0xbba3, LSL #48
    MOVZ  X4, #0x32d, LSL #0
    MOVK  X4, #0x970d, LSL #16
    MOVK  X4, #0xa516, LSL #32
    MOVK  X4, #0xbf0e, LSL #48
    MOVZ  X5, #0x6c3c, LSL #0
    MOVK  X5, #0xee14, LSL #16
    MOVK  X5, #0x85bb, LSL #32
    MOVK  X5, #0x7246, LSL #48
    MOVZ  X6, #0x1f56, LSL #0
    MOVK  X6, #0xdf6a, LSL #16
    MOVK  X6, #0x3e6c, LSL #32
    MOVK  X6, #0x2bd0, LSL #48
    MOVZ  X7, #0x5866, LSL #0
    MOVK  X7, #0xc507, LSL #16
    MOVK  X7, #0x5eaf, LSL #32
    MOVK  X7, #0x7b18, LSL #48
    MOVZ  X8, #0x244a, LSL #0
    MOVK  X8, #0xa841, LSL #16
    MOVK  X8, #0xdfaa, LSL #32
    MOVK  X8, #0x2850, LSL #48
    MOVZ  X9, #0xdc11, LSL #0
    MOVK  X9, #0xa4c2, LSL #16
    MOVK  X9, #0x3314, LSL #32
    MOVK  X9, #0xaf1d, LSL #48
    MOVZ  X10, #0x8bca, LSL #0
    MOVK  X10, #0x56d7, LSL #16
    MOVK  X10, #0xcda, LSL #32
    MOVK  X10, #0x4c6a, LSL #48
    MOVZ  X11, #0x3bb3, LSL #0
    MOVK  X11, #0x3d1b, LSL #16
    MOVK  X11, #0xfb19, LSL #32
    MOVK  X11, #0xc5a2, LSL #48
    MOVZ  X12, #0x9042, LSL #0
    MOVK  X12, #0xba03, LSL #16
    MOVK  X12, #0xd66a, LSL #32
    MOVK  X12, #0xcf4f, LSL #48
    MOVZ  X13, #0xd8d6, LSL #0
    MOVK  X13, #0xff7b, LSL #16
    MOVK  X13, #0x2dad, LSL #32
    MOVK  X13, #0x722e, LSL #48
    MOVZ  X14, #0x51b1, LSL #0
    MOVK  X14, #0xd971, LSL #16
    MOVK  X14, #0x4b0e, LSL #32
    MOVK  X14, #0xcc9d, LSL #48
    MOVZ  X15, #0xb698, LSL #0
    MOVK  X15, #0x2d2f, LSL #16
    MOVK  X15, #0xc559, LSL #32
    MOVK  X15, #0x85db, LSL #48
    MOVZ  X16, #0x646d, LSL #0
    MOVK  X16, #0x2219, LSL #16
    MOVK  X16, #0x4c27, LSL #32
    MOVK  X16, #0x456b, LSL #48
    MOVZ  X17, #0xae26, LSL #0
    MOVK  X17, #0x3d83, LSL #16
    MOVK  X17, #0x192a, LSL #32
    MOVK  X17, #0x2d64, LSL #48
    MOVZ  X18, #0x34c1, LSL #0
    MOVK  X18, #0x62d9, LSL #16
    MOVK  X18, #0xcca8, LSL #32
    MOVK  X18, #0x446e, LSL #48
    MOVZ  X19, #0x46db, LSL #0
    MOVK  X19, #0xa548, LSL #16
    MOVK  X19, #0xfdd, LSL #32
    MOVK  X19, #0xa5cc, LSL #48
    MOVZ  X20, #0x875f, LSL #0
    MOVK  X20, #0x6e42, LSL #16
    MOVK  X20, #0x86fa, LSL #32
    MOVK  X20, #0xa848, LSL #48
    MOVZ  X21, #0xea02, LSL #0
    MOVK  X21, #0x2211, LSL #16
    MOVK  X21, #0x74a0, LSL #32
    MOVK  X21, #0x986e, LSL #48
    MOVZ  X22, #0x4390, LSL #0
    MOVK  X22, #0x4f66, LSL #16
    MOVK  X22, #0x4cfa, LSL #32
    MOVK  X22, #0x4a5a, LSL #48
    MOVZ  X23, #0x26a1, LSL #0
    MOVK  X23, #0xf4ab, LSL #16
    MOVK  X23, #0x9418, LSL #32
    MOVK  X23, #0xe161, LSL #48
    MOVZ  X24, #0xfd35, LSL #0
    MOVK  X24, #0xc27e, LSL #16
    MOVK  X24, #0x5cf0, LSL #32
    MOVK  X24, #0xf146, LSL #48
    MOVZ  X25, #0xc428, LSL #0
    MOVK  X25, #0xce1c, LSL #16
    MOVK  X25, #0xfae, LSL #32
    MOVK  X25, #0xa0d3, LSL #48
    MOVZ  X26, #0xbe61, LSL #0
    MOVK  X26, #0xf2ee, LSL #16
    MOVK  X26, #0xd4d8, LSL #32
    MOVK  X26, #0x9948, LSL #48
    MOVZ  X27, #0x1763, LSL #0
    MOVK  X27, #0x17e8, LSL #16
    MOVK  X27, #0xd29a, LSL #32
    MOVK  X27, #0x2a72, LSL #48
    MOVZ  X28, #0x391c, LSL #0
    MOVK  X28, #0xecd8, LSL #16
    MOVK  X28, #0x7b32, LSL #32
    MOVK  X28, #0x4bfc, LSL #48
    MOVZ  X29, #0xb539, LSL #0
    MOVK  X29, #0x78e6, LSL #16
    MOVK  X29, #0x4755, LSL #32
    MOVK  X29, #0x3ce8, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X13
    FMOV  D1, X14
    FMOV  V1.D[1], X20
    FMOV  D2, X13
    FMOV  V2.D[1], X24
    FMOV  D3, X16
    FMOV  V3.D[1], X3
    FMOV  D4, X10
    FMOV  V4.D[1], X27
    FMOV  D5, X8
    FMOV  V5.D[1], X21
    FMOV  D6, X16
    FMOV  V6.D[1], X18
    FMOV  D7, X20
    FMOV  V7.D[1], X27
    FMOV  D8, X20
    FMOV  V8.D[1], X29
    FMOV  D9, X18
    FMOV  V9.D[1], X6
    FMOV  D10, X28
    FMOV  V10.D[1], X20
    FMOV  D11, X15
    FMOV  V11.D[1], X3
    FMOV  D12, X22
    FMOV  V12.D[1], X8
    FMOV  D13, X17
    FMOV  V13.D[1], X5
    FMOV  D14, X25
    FMOV  V14.D[1], X6
    FMOV  D15, X16
    FMOV  V15.D[1], X18
    FMOV  D16, X27
    FMOV  V16.D[1], X22
    FMOV  D17, X19
    FMOV  V17.D[1], X10
    FMOV  D18, X6
    FMOV  V18.D[1], X10
    FMOV  D19, X26
    FMOV  V19.D[1], X24
    FMOV  D20, X15
    FMOV  V20.D[1], X23
    FMOV  D21, X15
    FMOV  V21.D[1], X28
    FMOV  D22, X16
    FMOV  V22.D[1], X7
    FMOV  D23, X23
    FMOV  V23.D[1], X8
    FMOV  D24, X19
    FMOV  V24.D[1], X29
    FMOV  D25, X17
    FMOV  V25.D[1], X21
    FMOV  D26, X29
    FMOV  V26.D[1], X6
    FMOV  D27, X10
    FMOV  V27.D[1], X28
    FMOV  D28, X16
    FMOV  V28.D[1], X13
    FMOV  D29, X26
    FMOV  V29.D[1], X15
    FMOV  D30, X23
    FMOV  V30.D[1], X6
    FMOV  D31, X24
    FMOV  V31.D[1], X6
    MOVZ  X6, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_515:
    FMOV  D29, #0.43750000
    FMADD  S28, S2, S2, S27
    FNMSUB  D29, D16, D25, D23
    FMOV  X10, H10
    FMSUB  S26, S26, S21, S15
    FMOV  X14, D26
    FNMADD  S30, S27, S29, S31
    FMOV  D26, X15
    FMOV  W24, S31
    FMOV  W9, H1
    FNMADD  D19, D8, D27, D8
    FMOV  D2, #2.12500000
    FNMSUB  H13, H26, H25, H16
    FMOV  W23, S2
    FMOV  D24, #-1.56250000
    FMOV  W24, S29
    FMOV  S19, #0.75000000
    FMOV  X29, H30
    FMOV  H13, H2
    FMOV  X15, H25
    FMOV  H27, H26
    FNMADD  S18, S27, S13, S0
    FNMSUB  H1, H10, H5, H4
    FMADD  S8, S0, S17, S9
    FMSUB  H8, H4, H30, H8
    FMOV  D24, X13
    FMOV  S30, W7
    FMOV  S8, W3
    FNMADD  S8, S15, S2, S15
    FNMSUB  D9, D6, D3, D14
    FNMADD  H19, H26, H2, H19
    FNMADD  D6, D19, D20, D29
    FMOV  S8, W20
    FMOV  H4, W7
    FMOV  S12, W14
    FMOV  H10, X28
    FMSUB  D10, D0, D15, D9
    FMOV  S31, S15
    FMOV  H18, H0
    FMOV  S2, S31
    FMOV  S2, W14
    FNMADD  H13, H15, H22, H5
    FMOV  X18, H16
    FNMSUB  H27, H24, H20, H29
    FNMADD  D6, D23, D20, D13
    FMOV  W22, S23
    FMOV  X12, D23
    FMOV  D2, #-0.25000000
    FMOV  H13, X28
    FMSUB  H2, H25, H23, H18
    FMOV  X26, H6
    FMOV  H29, W11
    FMSUB  D0, D4, D9, D29
    FMOV  H27, X2
    FMOV  H20, H25
    FMADD  H27, H6, H29, H31
    FMOV  X2, H5
    FMOV  D0, X4
    FNMADD  H27, H22, H1, H4
    FMOV  S2, S4
    FMADD  S30, S11, S24, S20
    FMOV  X4, D29
    FMOV  W11, S29
    FMOV  S27, S1
    FNMSUB  S7, S9, S25, S8
    FMOV  D13, D30
    FMADD  H2, H13, H27, H0
    FMOV  H7, #-0.81250000
    FNMADD  S18, S2, S19, S25
    FMADD  D17, D23, D6, D25
    FMSUB  H19, H14, H5, H26
    FMOV  H3, H13
    FNMADD  H13, H11, H27, H22
    FMOV  S18, S28
    FMSUB  H30, H7, H30, H14
    FNMADD  S29, S25, S1, S22
    FMSUB  H16, H12, H3, H14
    FMADD  D23, D5, D13, D18
    FMOV  S9, S18
    FMADD  S11, S31, S8, S26
    FMOV  S30, W11
    FMADD  D31, D23, D19, D25
    FMOV  S24, S25
    FMADD  H9, H25, H24, H24
    FMOV  X23, H30
    FMOV  X28, H1
    FMSUB  D29, D15, D17, D15
    FMOV  H22, W18
    FMSUB  H15, H3, H0, H17
    FMOV  H25, #-0.20312500
    FMADD  S2, S7, S11, S11
    FMOV  H29, H23
    FMSUB  H0, H9, H11, H14
    FNMSUB  D16, D9, D29, D28
    FMOV  S31, #9.00000000
    FNMSUB  S21, S28, S0, S7
    FNMSUB  H8, H16, H20, H6
    FMOV  S4, S8
    FMOV  X9, D4
    FNMSUB  S20, S13, S9, S28
    FMOV  S11, S28
    FMOV  H2, #-22.00000000
    FMOV  D26, #1.50000000
    FMADD  D2, D29, D8, D12
    FMOV  X2, D3
    FMOV  D30, X11
    FMADD  H31, H30, H21, H11
    FMSUB  H24, H9, H24, H6
    FMOV  H17, W2
    FNMSUB  S26, S7, S23, S19
    FMSUB  S15, S16, S26, S16
    FMOV  D28, #-1.25000000
    FMOV  H20, X19
    FMOV  D16, #0.29687500
    FMOV  S24, W4
    FNMSUB  S11, S19, S2, S23
    FMOV  X19, H30
    FMADD  D7, D11, D17, D4
    FMADD  H28, H31, H20, H11
    FMOV  H13, X16
    FNMADD  S8, S9, S10, S20
    FMOV  D20, #0.12500000
    FMADD  S26, S11, S24, S28
    FNMSUB  H9, H17, H6, H9
    FNMADD  D21, D26, D27, D21
    FMOV  X23, D23
    FMOV  S9, W20
    FMADD  S17, S3, S25, S27
    FMADD  S10, S19, S11, S10
    FMOV  H3, X25
    FMOV  H19, X11
    FNMSUB  D26, D15, D7, D27
    FMOV  S9, W14
    FMOV  S0, W9
    FMOV  X2, H31
    FMADD  H12, H27, H30, H9
    FNMADD  S23, S19, S6, S19
    FMOV  D0, D24
    FMSUB  D8, D16, D20, D2
    FMOV  X22, H3
    FNMADD  S19, S17, S10, S21
    FMSUB  D12, D21, D11, D24
    FNMADD  S24, S17, S20, S3
    FMADD  H20, H21, H25, H24
    FMADD  H21, H21, H11, H30
    FNMADD  S3, S28, S19, S9
    FMSUB  H3, H9, H13, H24
    FMADD  D27, D12, D11, D7
    FNMADD  H26, H22, H0, H24
    FMOV  X26, D29
    FMOV  S21, W26
    FMSUB  D1, D29, D26, D6
    FNMSUB  S23, S19, S12, S1
    FMOV  D11, #6.75000000
    FMOV  X20, D24
    FMSUB  S4, S20, S12, S0
    FMOV  D3, #9.50000000
    FNMADD  D20, D6, D6, D9
    FMOV  D28, D15
    FMADD  H27, H24, H7, H27
    FMSUB  D13, D29, D27, D27
    FNMSUB  S7, S22, S29, S14
    FMOV  H21, H26
    FNMSUB  S17, S15, S0, S8
    FMOV  D27, X26
    FNMSUB  H13, H5, H26, H21
    FNMSUB  H5, H7, H10, H26
    FNMSUB  S4, S0, S2, S0
    FMOV  X12, D11
    FNMSUB  H5, H23, H14, H7
    FMSUB  D10, D1, D21, D23
    FMOV  D26, #5.25000000
    FMSUB  S6, S6, S12, S8
    FMOV  X20, H18
    FNMADD  D15, D6, D27, D5
    FMOV  H10, #-0.46875000
    FMOV  X13, D8
    FMOV  D20, X19
    FMOV  H28, #-0.48437500
    FMADD  H30, H16, H30, H27
    FMADD  S25, S4, S9, S4
    FMADD  D30, D24, D30, D27
    FMOV  X21, D27
    FNMSUB  D29, D27, D5, D10
    FMADD  H29, H29, H20, H8
    FMOV  D27, D27
    FMOV  W27, H1
    FMOV  S21, S7
    FNMADD  H26, H1, H26, H30
    FMOV  D13, D28
    FMOV  D21, X12
    FMSUB  S1, S22, S25, S22
    FMSUB  H29, H20, H3, H22
    FMOV  W24, H4
    FNMADD  H16, H23, H16, H6
    FNMSUB  H24, H7, H21, H1
    FMOV  D1, D12
    FNMADD  H17, H26, H22, H13
    FMOV  D8, X24
    FMADD  H28, H7, H20, H24
    SUBS  X6, X6, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_515
    MOVZ  X23, #0xba40, LSL #0
    SUB  X15, X23, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x7314, LSL #0
    MOVK  X13, #0x6696, LSL #16
    MOVK  X13, #0xfc86, LSL #32
    MOVK  X13, #0xbba3, LSL #48
    SUB  X24, X13, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x3bb3, LSL #0
    SUB  X20, X28, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x6c3c, LSL #0
    MOVK  X20, #0xee14, LSL #16
    MOVK  X20, #0x85bb, LSL #32
    MOVK  X20, #0x7246, LSL #48
    SUB  X3, X20, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x5866, LSL #0
    MOVK  X7, #0xc507, LSL #16
    MOVK  X7, #0x5eaf, LSL #32
    MOVK  X7, #0x7b18, LSL #48
    SUB  X12, X7, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x244a, LSL #0
    MOVK  X7, #0xa841, LSL #16
    MOVK  X7, #0xdfaa, LSL #32
    MOVK  X7, #0x2850, LSL #48
    SUB  X9, X7, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0xb780, LSL #0
    SUB  X11, X24, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x7314, LSL #0
    MOVK  X5, #0x6696, LSL #16
    MOVK  X5, #0xfc86, LSL #32
    MOVK  X5, #0xbba3, LSL #48
    SUB  X21, X5, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x646d, LSL #0
    MOVK  X2, #0x2219, LSL #16
    MOVK  X2, #0x4c27, LSL #32
    MOVK  X2, #0x456b, LSL #48
    SUB  X16, X2, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x7fff, LSL #0
    SUB  X10, X29, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x3bb3, LSL #0
    SUB  X29, X10, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0xc428, LSL #0
    SUB  X19, X4, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0xb780, LSL #0
    SUB  X10, X15, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0xc428, LSL #0
    MOVK  X21, #0xce1c, LSL #16
    MOVK  X21, #0xfae, LSL #32
    MOVK  X21, #0xa0d3, LSL #48
    SUB  X13, X21, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x11, LSL #0
    SUB  X9, X7, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D2
    MOVZ  X9, #0x7ff9, LSL #0
    SUB  X28, X9, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D3
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x4023, LSL #48
    SUB  X21, X13, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D4
    MOVZ  X15, #0x3bb2, LSL #0
    MOVK  X15, #0x8000, LSL #16
    SUB  X23, X15, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D5
    MOVZ  X24, #0xfff7, LSL #0
    SUB  X13, X24, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D6
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X24, X2, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D7
    MOVZ  X10, #0xc429, LSL #0
    MOVK  X10, #0x4e1c, LSL #16
    SUB  X29, X10, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D8
    MOVZ  X10, #0x3bb2, LSL #0
    SUB  X29, X10, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D9
    MOVZ  X29, #0x7ff8, LSL #0
    SUB  X13, X29, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D10
    MOVZ  X20, #0xb780, LSL #0
    SUB  X6, X20, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D11
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x401b, LSL #48
    SUB  X28, X2, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D12
    MOVZ  X17, #0x3bb4, LSL #0
    SUB  X8, X17, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D13
    MOVZ  X8, #0xb7c0, LSL #0
    SUB  X28, X8, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X26, #0x1f56, LSL #0
    MOVK  X26, #0xdf6a, LSL #16
    MOVK  X26, #0x3e6c, LSL #32
    MOVK  X26, #0x2bd0, LSL #48
    SUB  X17, X26, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D14
    MOVZ  X26, #0xc428, LSL #0
    MOVK  X26, #0xce1c, LSL #16
    MOVK  X26, #0xfae, LSL #32
    MOVK  X26, #0xa0d3, LSL #48
    SUB  X17, X26, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D15
    MOVZ  X13, #0xfff7, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X14, X13, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D16
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X7, X12, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D17
    MOVZ  X26, #0xfff8, LSL #0
    SUB  X3, X26, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D18
    MOVZ  X7, #0x10, LSL #0
    SUB  X15, X7, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D19
    MOVZ  X12, #0xbb98, LSL #0
    MOVK  X12, #0xb1c, LSL #16
    SUB  X7, X12, X29
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D20
    MOVZ  X26, #0x3bb3, LSL #0
    SUB  X3, X26, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D21
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x401b, LSL #48
    SUB  X8, X7, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D22
    MOVZ  X23, #0x7fff, LSL #0
    SUB  X17, X23, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D23
    MOVZ  X25, #0xfff7, LSL #0
    MOVK  X25, #0x8000, LSL #16
    SUB  X3, X25, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D24
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D25
    MOVZ  X21, #0x3bb2, LSL #0
    MOVK  X21, #0x8000, LSL #16
    SUB  X5, X21, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D26
    MOVZ  X15, #0x7ff8, LSL #0
    SUB  X4, X15, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D27
    MOVZ  X23, #0x11, LSL #0
    SUB  X11, X23, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D28
    MOVZ  X3, #0xc400, LSL #0
    SUB  X17, X3, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D29
    MOVZ  X6, #0x7fff, LSL #0
    SUB  X26, X6, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X10
    FMOV  V0.D[1], X17
    FMOV  D1, X21
    FMOV  V1.D[1], X24
    FMOV  D2, X23
    FMOV  V2.D[1], X20
    FMOV  D3, X8
    FMOV  V3.D[1], X27
    FMOV  D4, X5
    FMOV  V4.D[1], X29
    FMOV  D5, X27
    FMOV  V5.D[1], X6
    FMOV  D6, X28
    FMOV  V6.D[1], X25
    FMOV  D7, X13
    FMOV  V7.D[1], X2
    FMOV  D8, X19
    FMOV  V8.D[1], X21
    FMOV  D9, X23
    FMOV  V9.D[1], X29
    FMOV  D10, X9
    FMOV  V10.D[1], X24
    FMOV  D11, X18
    FMOV  V11.D[1], X6
    FMOV  D12, X7
    FMOV  V12.D[1], X12
    FMOV  D13, X20
    FMOV  V13.D[1], X25
    FMOV  D14, X22
    FMOV  V14.D[1], X12
    FMOV  D15, X28
    FMOV  V15.D[1], X19
    FMOV  D16, X25
    FMOV  V16.D[1], X25
    FMOV  D17, X12
    FMOV  V17.D[1], X28
    FMOV  D18, X7
    FMOV  V18.D[1], X12
    FMOV  D19, X16
    FMOV  V19.D[1], X23
    FMOV  D20, X28
    FMOV  V20.D[1], X3
    FMOV  D21, X13
    FMOV  V21.D[1], X19
    FMOV  D22, X5
    FMOV  V22.D[1], X25
    FMOV  D23, X20
    FMOV  V23.D[1], X12
    FMOV  D24, X5
    FMOV  V24.D[1], X10
    FMOV  D25, X19
    FMOV  V25.D[1], X27
    FMOV  D26, X13
    FMOV  V26.D[1], X27
    FMOV  D27, X4
    FMOV  V27.D[1], X18
    FMOV  D28, X3
    FMOV  V28.D[1], X16
    FMOV  D29, X19
    FMOV  V29.D[1], X12
    FMOV  D30, X26
    FMOV  V30.D[1], X4
    FMOV  D31, X27
    FMOV  V31.D[1], X11
    MOVZ  X18, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_601:
    FMADD  H25, H28, H25, H30
    FMOV  H0, X3
    FMADD  D21, D31, D22, D11
    FMADD  S25, S9, S28, S1
    FNMSUB  H26, H20, H31, H5
    FNMSUB  D29, D31, D16, D16
    FMOV  S15, W6
    FNMSUB  D10, D20, D11, D18
    FNMADD  H13, H15, H9, H0
    FMOV  H3, H25
    FMOV  X5, D17
    FMADD  S29, S24, S16, S5
    FNMSUB  S3, S8, S24, S30
    FMOV  D10, X25
    FMSUB  H22, H25, H24, H26
    FMOV  H6, #-0.14843750
    FNMADD  H28, H17, H21, H14
    FMOV  H11, W6
    FMOV  H6, #-0.71875000
    FNMADD  D5, D24, D10, D21
    FNMSUB  S6, S15, S31, S13
    FMADD  S18, S29, S3, S5
    FNMADD  D20, D12, D31, D12
    FMOV  X27, H11
    FMADD  D11, D18, D1, D20
    FMOV  H14, X11
    FMOV  D2, #0.17187500
    FMOV  W27, S22
    FMOV  H6, #-21.00000000
    FMADD  D17, D20, D28, D14
    FNMSUB  D24, D1, D17, D30
    FMADD  H2, H11, H6, H7
    FMOV  D5, D3
    FMOV  X6, H6
    FNMADD  D27, D18, D12, D24
    FMSUB  D27, D14, D7, D27
    FMOV  D18, X13
    FNMADD  S5, S27, S29, S9
    FMADD  H12, H1, H26, H5
    FNMADD  S19, S2, S10, S4
    FMSUB  S24, S4, S6, S13
    FMOV  D15, #1.43750000
    FMOV  H28, H30
    FMOV  S21, S3
    FNMADD  D27, D15, D26, D22
    FMADD  S21, S22, S25, S7
    FMOV  X27, H11
    FMOV  H16, X24
    FMOV  W10, S26
    FMOV  W16, S3
    FMOV  S29, #-3.75000000
    FMOV  H28, #-1.06250000
    FMOV  W22, S17
    FMOV  S24, W8
    FMOV  D6, X24
    FMSUB  S1, S21, S17, S27
    FMOV  H16, H20
    FMOV  S24, W6
    FNMSUB  H16, H8, H14, H21
    FMOV  W29, H16
    FNMADD  D13, D10, D11, D17
    FNMSUB  S21, S3, S16, S14
    FNMADD  H24, H3, H2, H18
    FNMSUB  H8, H19, H19, H8
    FMOV  D3, X22
    FMOV  S8, #6.50000000
    FNMADD  D13, D28, D2, D24
    FMOV  H27, W13
    FMOV  W4, H4
    FMOV  X22, D29
    FMOV  D1, D2
    FMOV  H29, #-0.96875000
    FMOV  S2, W9
    FMOV  H20, W2
    FMOV  D14, #-2.87500000
    FMOV  H20, W11
    FMOV  H8, #0.48437500
    FNMADD  H4, H26, H11, H1
    FMADD  S25, S18, S9, S20
    FMADD  H23, H14, H7, H23
    FMSUB  D18, D24, D5, D29
    FMOV  S18, W13
    FNMADD  D28, D24, D4, D2
    FMOV  W15, H3
    FMSUB  S9, S21, S3, S23
    FMOV  S1, S24
    FMOV  W16, H31
    FMSUB  S19, S2, S13, S7
    FMOV  H18, W9
    FMOV  S23, S28
    FNMSUB  S2, S28, S19, S14
    FMOV  S15, #-0.14843750
    FMSUB  S19, S5, S14, S11
    FMOV  W13, S5
    FMOV  D7, D8
    FMSUB  H14, H19, H5, H27
    FMSUB  D0, D22, D29, D20
    FMSUB  S7, S4, S19, S2
    FMADD  H25, H25, H0, H23
    FMOV  H3, H18
    FMADD  D9, D3, D27, D3
    FMOV  W12, H15
    FMOV  D6, #0.15625000
    FMOV  D25, #4.75000000
    FMADD  H22, H21, H2, H0
    FMADD  S2, S7, S9, S14
    FMOV  S3, S21
    FMOV  H22, W5
    FMOV  D15, X5
    FNMADD  D13, D13, D29, D29
    FNMADD  S16, S24, S15, S18
    FMOV  X29, D0
    FMSUB  H26, H18, H19, H6
    FMOV  H27, H1
    FMOV  X29, H27
    FMOV  H27, X4
    FMOV  H14, #1.68750000
    FMOV  X22, H7
    FMSUB  S0, S25, S14, S19
    FMADD  S5, S6, S7, S1
    FMOV  S3, #-5.00000000
    FMOV  X13, D2
    FMSUB  D3, D7, D16, D3
    FMADD  D27, D9, D3, D5
    FNMSUB  H22, H14, H26, H27
    FMOV  H0, X6
    FMOV  S8, S18
    FMOV  X8, D17
    FMOV  H2, X27
    FNMSUB  S5, S18, S16, S13
    FNMADD  D3, D17, D17, D20
    FMOV  S8, W12
    FMADD  H3, H16, H25, H26
    FMOV  H22, X24
    FNMSUB  S0, S9, S23, S28
    FMOV  X13, D31
    FMOV  H16, X10
    FMOV  S15, S2
    FMSUB  H24, H17, H4, H7
    FMADD  H8, H26, H15, H0
    FMOV  S5, W7
    FMOV  H16, W29
    FMADD  H19, H8, H3, H27
    FNMADD  S23, S13, S13, S25
    FMOV  H13, W7
    FMOV  D3, X11
    FMSUB  H4, H4, H16, H5
    FNMADD  H1, H26, H31, H4
    FMADD  S24, S13, S8, S13
    FMSUB  H23, H26, H13, H24
    FMADD  S17, S24, S26, S26
    FMOV  D17, X22
    FNMSUB  H13, H25, H5, H13
    FMOV  X6, D26
    FMSUB  H12, H2, H1, H30
    FNMSUB  D8, D21, D14, D15
    FMOV  H3, W27
    FMOV  H23, H27
    FMSUB  H25, H19, H9, H21
    FMOV  H0, X17
    FMOV  S4, #-0.45312500
    FMOV  W16, S20
    FMOV  H4, W6
    FMOV  S1, #-1.37500000
    FMOV  H5, W25
    FMOV  D13, #-4.75000000
    FNMSUB  H8, H17, H24, H11
    FMOV  H17, H11
    FMSUB  S21, S5, S1, S22
    FNMADD  S15, S21, S28, S5
    FMOV  H24, H28
    FNMSUB  S8, S26, S17, S1
    FMSUB  H0, H10, H0, H0
    FNMSUB  D2, D7, D7, D22
    FMOV  H8, H11
    FMOV  H21, #16.00000000
    FMSUB  S22, S10, S11, S19
    FMOV  W8, H11
    FMOV  H17, #-0.46875000
    FMOV  H12, W12
    FNMADD  D26, D22, D22, D17
    FMSUB  D13, D8, D9, D16
    FMOV  X6, D3
    FMSUB  H4, H12, H15, H22
    FNMADD  H25, H26, H19, H5
    FMOV  D2, D21
    FMOV  S25, W9
    FMOV  W9, H16
    FMOV  D24, D22
    FMOV  W3, H28
    FNMSUB  H2, H5, H7, H29
    FMOV  D21, D2
    FMOV  S4, W14
    FNMADD  S8, S11, S2, S12
    FNMSUB  H10, H19, H4, H29
    FNMSUB  H19, H17, H6, H22
    FNMADD  S28, S13, S30, S28
    FNMADD  S5, S17, S21, S8
    FMOV  D13, #0.15625000
    FMOV  S13, #-1.06250000
    SUBS  X18, X18, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_601
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X28, X25, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0xb780, LSL #0
    SUB  X13, X22, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X20, X9, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X15
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X16
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D2
    MOVZ  X13, #0x3bc0, LSL #0
    SUB  X27, X13, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D4
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D5
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8000, LSL #16
    SUB  X29, X24, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D6
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x3fc4, LSL #48
    SUB  X9, X5, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D7
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x8000, LSL #16
    SUB  X10, X4, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D8
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X16, X12, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D9
    MOVZ  X8, #0x8000, LSL #0
    SUB  X20, X8, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D10
    MOVZ  X13, #0x7fff, LSL #0
    SUB  X11, X13, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D13
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xbf88, LSL #16
    SUB  X11, X12, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D14
    MOVZ  X3, #0x3ec0, LSL #0
    SUB  X28, X3, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D15
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X22, X14, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D16
    MOVZ  X17, #0x8000, LSL #0
    SUB  X22, X17, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D17
    MOVZ  X22, #0xb780, LSL #0
    SUB  X18, X22, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D18
    MOVZ  X9, #0x8000, LSL #0
    SUB  X7, X9, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D19
    MOVZ  X4, #0xffff, LSL #0
    SUB  X24, X4, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D21
    MOVZ  X29, #0x3bc0, LSL #0
    SUB  X5, X29, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D22
    MOVZ  X28, #0x7fff, LSL #0
    SUB  X14, X28, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D23
    MOVZ  X13, #0x8001, LSL #0
    SUB  X29, X13, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D24
    MOVZ  X14, #0x7fff, LSL #0
    SUB  X6, X14, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D25
    MOVZ  X27, #0x8000, LSL #0
    SUB  X20, X27, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D26
    MOVZ  X9, #0xb780, LSL #0
    MOVK  X9, #0x8000, LSL #48
    SUB  X17, X9, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D27
    MOVZ  X15, #0x8001, LSL #0
    SUB  X8, X15, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D28
    MOVZ  X8, #0x8000, LSL #0
    MOVK  X8, #0x8000, LSL #16
    SUB  X10, X8, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D29
    MOVZ  X23, #0xbbc0, LSL #0
    SUB  X17, X23, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X7
    FMOV  V0.D[1], X11
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X19
    FMOV  D3, X25
    FMOV  V3.D[1], X13
    FMOV  D4, X28
    FMOV  V4.D[1], X13
    FMOV  D5, X11
    FMOV  V5.D[1], X26
    FMOV  D6, X27
    FMOV  V6.D[1], X11
    FMOV  D7, X20
    FMOV  V7.D[1], X2
    FMOV  D8, X2
    FMOV  V8.D[1], X2
    FMOV  D9, X19
    FMOV  V9.D[1], X26
    FMOV  D10, X19
    FMOV  V10.D[1], X8
    FMOV  D11, X14
    FMOV  V11.D[1], X29
    FMOV  D12, X14
    FMOV  V12.D[1], X11
    FMOV  D13, X16
    FMOV  V13.D[1], X3
    FMOV  D14, X8
    FMOV  V14.D[1], X5
    FMOV  D15, X6
    FMOV  V15.D[1], X19
    FMOV  D16, X3
    FMOV  V16.D[1], X21
    FMOV  D17, X6
    FMOV  V17.D[1], X16
    FMOV  D18, X3
    FMOV  V18.D[1], X11
    FMOV  D19, X15
    FMOV  V19.D[1], X15
    FMOV  D20, X2
    FMOV  V20.D[1], X14
    FMOV  D21, X26
    FMOV  V21.D[1], X10
    FMOV  D22, X19
    FMOV  V22.D[1], X13
    FMOV  D23, X21
    FMOV  V23.D[1], X26
    FMOV  D24, X12
    FMOV  V24.D[1], X13
    FMOV  D25, X2
    FMOV  V25.D[1], X14
    FMOV  D26, X13
    FMOV  V26.D[1], X2
    FMOV  D27, X5
    FMOV  V27.D[1], X24
    FMOV  D28, X8
    FMOV  V28.D[1], X11
    FMOV  D29, X11
    FMOV  V29.D[1], X27
    FMOV  D30, X29
    FMOV  V30.D[1], X25
    FMOV  D31, X5
    FMOV  V31.D[1], X26
    MOVZ  X25, #0xf, LSL #0
TaishanFpMiniMaxiP01_label_687:
    FNMSUB  H3, H20, H28, H28
    FMOV  H11, X3
    FMOV  S28, #1.12500000
    FMOV  D13, X22
    FMOV  X14, D17
    FNMADD  S17, S27, S12, S13
    FMOV  X21, D31
    FMOV  S31, S26
    FNMADD  S15, S21, S5, S24
    FMADD  D19, D25, D24, D3
    FNMSUB  D5, D30, D6, D1
    FMOV  X17, D20
    FNMADD  D20, D18, D9, D4
    FNMSUB  S31, S20, S26, S25
    FMSUB  S26, S5, S19, S16
    FMSUB  S16, S29, S27, S19
    FNMSUB  S25, S11, S28, S2
    FMOV  D21, #-0.13281250
    FNMADD  D1, D10, D1, D18
    FMADD  S14, S4, S15, S4
    FNMADD  D12, D13, D14, D30
    FMOV  D19, X5
    FMSUB  H5, H19, H20, H17
    FNMSUB  D18, D7, D28, D17
    FMOV  X5, D11
    FMOV  S25, S11
    FNMSUB  D27, D2, D13, D8
    FMOV  D2, #-1.62500000
    FMOV  S7, #-0.17968750
    FMOV  S7, #-6.75000000
    FNMADD  D12, D12, D11, D26
    FMSUB  S6, S6, S21, S27
    FMOV  X4, H10
    FNMADD  H31, H4, H31, H7
    FMADD  D18, D13, D18, D2
    FMOV  D31, #-3.25000000
    FMOV  H5, #-4.75000000
    FMOV  D19, X26
    FMADD  D24, D7, D12, D27
    FMSUB  D20, D17, D28, D4
    FNMSUB  S30, S2, S7, S7
    FMOV  S5, W7
    FNMSUB  D12, D3, D16, D31
    FMOV  W10, S21
    FMOV  H9, W2
    FMADD  S25, S7, S29, S20
    FMADD  H26, H7, H9, H18
    FMSUB  D30, D10, D1, D22
    FMOV  S7, W29
    FNMADD  D28, D30, D12, D7
    FNMADD  S19, S4, S15, S22
    FMOV  X9, D16
    FMOV  H9, W12
    FNMADD  D20, D15, D13, D2
    FMOV  W9, H26
    FMOV  D29, X29
    FMSUB  D29, D16, D19, D22
    FNMADD  H22, H19, H17, H20
    FMSUB  H9, H20, H10, H9
    FNMADD  S2, S17, S10, S14
    FMOV  D4, X7
    FNMSUB  H0, H31, H27, H14
    FMADD  H3, H13, H7, H24
    FMSUB  H23, H14, H7, H14
    FNMADD  D25, D15, D5, D29
    FMSUB  H13, H17, H23, H1
    FMADD  H15, H11, H26, H10
    FMOV  X3, H23
    FNMSUB  H19, H12, H21, H19
    FMOV  S25, S7
    FMADD  H22, H4, H18, H9
    FNMSUB  H16, H12, H7, H22
    FNMADD  H30, H23, H28, H16
    FMOV  W10, S15
    FMOV  S5, W21
    FNMSUB  D3, D11, D10, D25
    FMOV  H2, H31
    FMADD  H20, H9, H22, H15
    FMOV  S23, #-15.00000000
    FMOV  W8, S6
    FMOV  H0, #5.25000000
    FMADD  S24, S25, S31, S5
    FMOV  D4, X8
    FMADD  H31, H15, H29, H28
    FNMADD  D31, D5, D9, D19
    FMADD  S17, S31, S13, S26
    FNMSUB  S24, S0, S18, S28
    FMOV  S30, W23
    FNMSUB  S18, S9, S1, S23
    FMOV  S9, W23
    FMOV  H6, H21
    FNMSUB  S1, S1, S18, S24
    FMADD  H25, H0, H1, H3
    FNMSUB  D28, D22, D8, D26
    FMSUB  H31, H23, H29, H16
    FNMADD  H31, H31, H22, H7
    FNMADD  H6, H10, H12, H9
    FMOV  H17, #0.96875000
    FMOV  H16, W19
    FMOV  H19, X7
    FMADD  S0, S30, S0, S29
    FMSUB  D25, D19, D17, D26
    FMSUB  S22, S22, S26, S16
    FMSUB  S1, S4, S16, S0
    FMOV  W10, S19
    FMOV  H16, H18
    FMOV  H31, H22
    FMOV  H6, H16
    FMOV  X13, D20
    FMOV  D16, X6
    FNMSUB  S25, S29, S27, S7
    FMOV  H28, X10
    FMOV  H14, H3
    FNMADD  S25, S28, S30, S25
    FMSUB  D31, D26, D15, D17
    FMSUB  H19, H6, H12, H1
    FNMADD  H5, H29, H11, H8
    FMOV  H10, H21
    FMSUB  D8, D9, D18, D8
    FMOV  S25, W23
    FMOV  S25, W3
    FMSUB  D17, D25, D26, D26
    FNMADD  S30, S19, S4, S5
    FMSUB  S16, S17, S31, S20
    FMSUB  H7, H18, H23, H25
    FNMSUB  D11, D10, D14, D15
    FMADD  S9, S21, S11, S17
    FMOV  H7, #0.42187500
    FNMADD  S13, S30, S15, S0
    FMOV  D23, D17
    FMOV  H30, #-10.00000000
    FMOV  H10, #-0.29687500
    FMOV  X2, D17
    FNMADD  S2, S27, S13, S29
    FMOV  S11, W9
    FNMSUB  D20, D17, D15, D24
    FMOV  D0, #1.00000000
    FMSUB  S26, S4, S31, S30
    FNMADD  H8, H2, H13, H15
    FMADD  D10, D5, D8, D23
    FMOV  H27, #-0.81250000
    FNMADD  S27, S6, S1, S31
    FMSUB  S7, S1, S23, S14
    FNMSUB  D16, D11, D31, D3
    FMSUB  D31, D24, D8, D9
    FMOV  X20, H21
    FNMADD  D10, D6, D29, D4
    FMADD  D12, D6, D24, D11
    FMOV  S25, W19
    FMSUB  D25, D3, D24, D5
    FMOV  D28, #-10.00000000
    FMOV  S6, #-8.00000000
    FMOV  S3, W16
    FNMADD  H16, H9, H29, H11
    FMOV  S6, W8
    FMADD  S14, S25, S13, S22
    FMOV  H14, #-1.37500000
    FNMADD  S29, S20, S1, S11
    FMOV  S3, S15
    FMSUB  H18, H8, H0, H26
    FMOV  D4, #-2.50000000
    FMSUB  D28, D4, D16, D1
    FMSUB  D0, D16, D1, D18
    FMOV  W19, S29
    FNMSUB  S2, S17, S19, S28
    FMOV  X24, D2
    FMOV  D11, D4
    FNMADD  D31, D21, D18, D10
    FNMADD  H6, H16, H11, H0
    FMOV  D23, D2
    FMOV  X16, D15
    FMOV  D6, D6
    FNMADD  D4, D25, D4, D11
    FNMSUB  D28, D3, D3, D17
    FMOV  D12, #-0.12500000
    FNMSUB  H6, H18, H29, H6
    FMOV  X19, D23
    FNMADD  S18, S31, S13, S17
    FMSUB  H10, H3, H9, H2
    FMSUB  S14, S8, S12, S1
    FMSUB  S20, S5, S15, S26
    FMOV  H8, X6
    FMOV  X22, H13
    FMOV  X18, H1
    FMOV  S27, W13
    FNMADD  H4, H13, H19, H3
    FMADD  H1, H1, H13, H12
    FMSUB  D17, D28, D8, D28
    FMSUB  S26, S23, S30, S22
    FMOV  X6, D27
    FMSUB  D5, D16, D12, D26
    FNMADD  D26, D15, D12, D27
    FMOV  H7, H29
    FNMSUB  D14, D24, D14, D15
    FMADD  D21, D19, D8, D20
    FMOV  W16, S15
    FNMSUB  S26, S20, S11, S25
    FMOV  S28, #0.84375000
    FMOV  X23, H4
    FMOV  H13, H27
    SUBS  X25, X25, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_687
    MOVZ  X3, #0xffff, LSL #0
    SUB  X12, X3, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    SUB  X21, X6, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x7ff3, LSL #0
    SUB  X10, X28, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0xfff4, LSL #0
    SUB  X14, X25, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    SUB  X5, X4, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X8, X24, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    SUB  X7, X24, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X13, X11, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x7ff3, LSL #0
    SUB  X21, X29, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0xffee, LSL #0
    MOVK  X16, #0x8001, LSL #16
    SUB  X19, X16, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0xbff0, LSL #0
    SUB  X25, X27, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0xfff3, LSL #0
    SUB  X5, X19, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    SUB  X28, X23, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0xbff0, LSL #0
    SUB  X21, X25, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x7ff3, LSL #0
    SUB  X13, X28, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D2
    MOVZ  X24, #0xffee, LSL #0
    MOVK  X24, #0x8001, LSL #16
    SUB  X5, X24, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D3
    MOVZ  X10, #0x7ff3, LSL #0
    SUB  X28, X10, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D4
    MOVZ  X10, #0xfff3, LSL #0
    SUB  X29, X10, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D5
    MOVZ  X28, #0xcff2, LSL #0
    SUB  X3, X28, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D6
    MOVZ  X27, #0x7ff3, LSL #0
    SUB  X11, X27, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D7
    MOVZ  X21, #0xfffe, LSL #0
    SUB  X15, X21, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D8
    MOVZ  X12, #0xfff3, LSL #0
    SUB  X11, X12, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D9
    MOVZ  X15, #0xffff, LSL #0
    SUB  X19, X15, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D10
    MOVZ  X2, #0xffee, LSL #0
    SUB  X11, X2, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D11
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xc004, LSL #48
    SUB  X8, X14, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D12
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xbfc0, LSL #48
    SUB  X26, X27, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D13
    MOVZ  X10, #0x7ff3, LSL #0
    SUB  X16, X10, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D14
    MOVZ  X6, #0x7ff2, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X22, X6, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D15
    MOVZ  X23, #0x7ff3, LSL #0
    SUB  X19, X23, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D16
    MOVZ  X17, #0x7fff, LSL #0
    SUB  X18, X17, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D17
    MOVZ  X16, #0xfffd, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X13, X16, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D18
    MOVZ  X27, #0xfffe, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X25, X27, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D19
    MOVZ  X13, #0xbff1, LSL #0
    SUB  X17, X13, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D20
    MOVZ  X29, #0xc900, LSL #0
    SUB  X6, X29, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D21
    MOVZ  X19, #0xc901, LSL #0
    SUB  X28, X19, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D22
    MOVZ  X23, #0xbff1, LSL #0
    SUB  X28, X23, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D23
    MOVZ  X4, #0xffee, LSL #0
    MOVK  X4, #0x8001, LSL #16
    SUB  X17, X4, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D24
    MOVZ  X26, #0x6fce, LSL #0
    MOVK  X26, #0x8002, LSL #16
    SUB  X29, X26, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D25
    MOVZ  X7, #0xfff4, LSL #0
    SUB  X8, X7, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D26
    MOVZ  X14, #0xfff4, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X20, X14, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X3, X18, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D27
    MOVZ  X18, #0x7ff3, LSL #0
    SUB  X3, X18, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D28
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x3f58, LSL #16
    SUB  X9, X20, X15
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D29
    MOVZ  X19, #0xfffe, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X10, X19, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x2b6b, LSL #0
    MOVK  X2, #0xd276, LSL #16
    MOVK  X2, #0x5096, LSL #32
    MOVK  X2, #0xfaf2, LSL #48
    MOVZ  X3, #0x9bcf, LSL #0
    MOVK  X3, #0x1ea2, LSL #16
    MOVK  X3, #0x8319, LSL #32
    MOVK  X3, #0xc580, LSL #48
    MOVZ  X4, #0x3e11, LSL #0
    MOVK  X4, #0x405e, LSL #16
    MOVK  X4, #0x7b73, LSL #32
    MOVK  X4, #0xad9f, LSL #48
    MOVZ  X5, #0x990f, LSL #0
    MOVK  X5, #0xd4d2, LSL #16
    MOVK  X5, #0x1bb9, LSL #32
    MOVK  X5, #0xcecc, LSL #48
    MOVZ  X6, #0x62cc, LSL #0
    MOVK  X6, #0x7854, LSL #16
    MOVK  X6, #0x45e4, LSL #32
    MOVK  X6, #0x88b7, LSL #48
    MOVZ  X7, #0xf117, LSL #0
    MOVK  X7, #0xd790, LSL #16
    MOVK  X7, #0x8978, LSL #32
    MOVK  X7, #0xb176, LSL #48
    MOVZ  X8, #0xdd10, LSL #0
    MOVK  X8, #0x61d0, LSL #16
    MOVK  X8, #0x7c11, LSL #32
    MOVK  X8, #0x4edd, LSL #48
    MOVZ  X9, #0x8745, LSL #0
    MOVK  X9, #0xac8d, LSL #16
    MOVK  X9, #0xaa8d, LSL #32
    MOVK  X9, #0x6e14, LSL #48
    MOVZ  X10, #0xdf47, LSL #0
    MOVK  X10, #0x6b15, LSL #16
    MOVK  X10, #0x496f, LSL #32
    MOVK  X10, #0x4507, LSL #48
    MOVZ  X11, #0xdd66, LSL #0
    MOVK  X11, #0x196, LSL #16
    MOVK  X11, #0xcc58, LSL #32
    MOVK  X11, #0x96fa, LSL #48
    MOVZ  X12, #0xca59, LSL #0
    MOVK  X12, #0x22e5, LSL #16
    MOVK  X12, #0xa7c2, LSL #32
    MOVK  X12, #0x57e9, LSL #48
    MOVZ  X13, #0xd65e, LSL #0
    MOVK  X13, #0xf54a, LSL #16
    MOVK  X13, #0x4162, LSL #32
    MOVK  X13, #0xab1f, LSL #48
    MOVZ  X14, #0xb29a, LSL #0
    MOVK  X14, #0xa7b8, LSL #16
    MOVK  X14, #0x30e6, LSL #32
    MOVK  X14, #0x1e3f, LSL #48
    MOVZ  X15, #0xb276, LSL #0
    MOVK  X15, #0x5ec5, LSL #16
    MOVK  X15, #0xb996, LSL #32
    MOVK  X15, #0x470, LSL #48
    MOVZ  X16, #0xda85, LSL #0
    MOVK  X16, #0x3220, LSL #16
    MOVK  X16, #0x9eb4, LSL #32
    MOVK  X16, #0x9f93, LSL #48
    MOVZ  X17, #0x9b06, LSL #0
    MOVK  X17, #0xf4b6, LSL #16
    MOVK  X17, #0x49d3, LSL #32
    MOVK  X17, #0x76bc, LSL #48
    MOVZ  X18, #0x941, LSL #0
    MOVK  X18, #0x920, LSL #16
    MOVK  X18, #0x5a26, LSL #32
    MOVK  X18, #0xc59a, LSL #48
    MOVZ  X19, #0xea0a, LSL #0
    MOVK  X19, #0x9334, LSL #16
    MOVK  X19, #0x3ae2, LSL #32
    MOVK  X19, #0x93d4, LSL #48
    MOVZ  X20, #0x7d0c, LSL #0
    MOVK  X20, #0xcd57, LSL #16
    MOVK  X20, #0x538a, LSL #32
    MOVK  X20, #0xfa3a, LSL #48
    MOVZ  X21, #0xdbec, LSL #0
    MOVK  X21, #0xa8a6, LSL #16
    MOVK  X21, #0x10f4, LSL #32
    MOVK  X21, #0xb170, LSL #48
    MOVZ  X22, #0x8033, LSL #0
    MOVK  X22, #0x373b, LSL #16
    MOVK  X22, #0x6d28, LSL #32
    MOVK  X22, #0x306a, LSL #48
    MOVZ  X23, #0xd608, LSL #0
    MOVK  X23, #0xb479, LSL #16
    MOVK  X23, #0x9e4d, LSL #32
    MOVK  X23, #0x1542, LSL #48
    MOVZ  X24, #0xc9f2, LSL #0
    MOVK  X24, #0xd26d, LSL #16
    MOVK  X24, #0x90cc, LSL #32
    MOVK  X24, #0x840c, LSL #48
    MOVZ  X25, #0x39c, LSL #0
    MOVK  X25, #0xa466, LSL #16
    MOVK  X25, #0x8c27, LSL #32
    MOVK  X25, #0x75b0, LSL #48
    MOVZ  X26, #0xb382, LSL #0
    MOVK  X26, #0x671a, LSL #16
    MOVK  X26, #0xe835, LSL #32
    MOVK  X26, #0xe9b7, LSL #48
    MOVZ  X27, #0x477, LSL #0
    MOVK  X27, #0xa056, LSL #16
    MOVK  X27, #0xf88, LSL #32
    MOVK  X27, #0xf04c, LSL #48
    MOVZ  X28, #0xe8d9, LSL #0
    MOVK  X28, #0x7ea7, LSL #16
    MOVK  X28, #0x9f8b, LSL #32
    MOVK  X28, #0x5d00, LSL #48
    MOVZ  X29, #0xba6f, LSL #0
    MOVK  X29, #0xebc8, LSL #16
    MOVK  X29, #0xab8c, LSL #32
    MOVK  X29, #0xbfa4, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X28
    FMOV  D1, X14
    FMOV  V1.D[1], X27
    FMOV  D2, X23
    FMOV  V2.D[1], X3
    FMOV  D3, X10
    FMOV  V3.D[1], X19
    FMOV  D4, X12
    FMOV  V4.D[1], X22
    FMOV  D5, X4
    FMOV  V5.D[1], X29
    FMOV  D6, X23
    FMOV  V6.D[1], X14
    FMOV  D7, X13
    FMOV  V7.D[1], X25
    FMOV  D8, X8
    FMOV  V8.D[1], X25
    FMOV  D9, X28
    FMOV  V9.D[1], X6
    FMOV  D10, X8
    FMOV  V10.D[1], X2
    FMOV  D11, X28
    FMOV  V11.D[1], X29
    FMOV  D12, X17
    FMOV  V12.D[1], X12
    FMOV  D13, X19
    FMOV  V13.D[1], X22
    FMOV  D14, X17
    FMOV  V14.D[1], X13
    FMOV  D15, X4
    FMOV  V15.D[1], X15
    FMOV  D16, X2
    FMOV  V16.D[1], X17
    FMOV  D17, X24
    FMOV  V17.D[1], X15
    FMOV  D18, X12
    FMOV  V18.D[1], X8
    FMOV  D19, X8
    FMOV  V19.D[1], X3
    FMOV  D20, X4
    FMOV  V20.D[1], X21
    FMOV  D21, X24
    FMOV  V21.D[1], X26
    FMOV  D22, X11
    FMOV  V22.D[1], X7
    FMOV  D23, X26
    FMOV  V23.D[1], X19
    FMOV  D24, X10
    FMOV  V24.D[1], X8
    FMOV  D25, X4
    FMOV  V25.D[1], X5
    FMOV  D26, X2
    FMOV  V26.D[1], X26
    FMOV  D27, X11
    FMOV  V27.D[1], X22
    FMOV  D28, X9
    FMOV  V28.D[1], X25
    FMOV  D29, X20
    FMOV  V29.D[1], X14
    FMOV  D30, X10
    FMOV  V30.D[1], X18
    FMOV  D31, X10
    FMOV  V31.D[1], X19
    MOVZ  X2, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_772:
    FNMADD  H30, H27, H4, H10
    FMOV  D11, #0.42187500
    FMOV  H31, #23.00000000
    FMSUB  D11, D17, D29, D23
    FMOV  W4, H17
    FMOV  S9, #5.75000000
    FMSUB  D25, D28, D20, D13
    FMSUB  H13, H4, H16, H30
    FMADD  D28, D24, D11, D14
    FMOV  H0, X9
    FMOV  D27, #12.50000000
    FMOV  H9, H12
    FMOV  X14, D16
    FNMADD  D13, D3, D26, D9
    FNMSUB  H6, H11, H7, H17
    FMADD  D0, D6, D17, D27
    FMOV  D0, D6
    FMOV  H2, W9
    FMOV  X7, H14
    FMOV  H10, #-0.26562500
    FMOV  D28, X9
    FMOV  S17, S31
    FMOV  H8, #6.50000000
    FMOV  S7, #3.00000000
    FMADD  S28, S1, S27, S4
    FNMSUB  H20, H6, H7, H17
    FMOV  D28, #-0.18750000
    FMOV  X16, H30
    FMOV  H0, H13
    FMOV  S12, #0.40625000
    FNMADD  H15, H27, H5, H6
    FMOV  D25, X8
    FMADD  D13, D10, D19, D7
    FMADD  H4, H26, H8, H14
    FMOV  D31, X10
    FMOV  H5, W13
    FMADD  S2, S14, S25, S23
    FMOV  D19, X27
    FMOV  H10, #-20.00000000
    FMADD  S3, S22, S25, S18
    FNMSUB  H18, H27, H1, H13
    FMOV  H21, W5
    FNMSUB  D0, D23, D18, D30
    FNMADD  H12, H18, H10, H25
    FMOV  D30, #2.00000000
    FMOV  X21, H22
    FMOV  X7, D18
    FMSUB  H5, H3, H10, H28
    FMOV  X18, D5
    FMOV  D27, #-2.75000000
    FMOV  D3, D21
    FMOV  S12, S13
    FMOV  S5, W25
    FMOV  D0, D14
    FMOV  H0, H20
    FMADD  S10, S2, S30, S26
    FNMSUB  H5, H4, H1, H10
    FMOV  S15, S25
    FMSUB  D15, D23, D19, D3
    FNMSUB  H22, H8, H18, H27
    FMOV  X17, D12
    FMSUB  D8, D14, D28, D7
    FNMSUB  H26, H10, H10, H13
    FMOV  D7, D0
    FMOV  H1, #6.50000000
    FNMSUB  D7, D16, D11, D25
    FNMSUB  S25, S20, S0, S3
    FMSUB  D28, D2, D14, D22
    FMOV  D2, D16
    FMOV  H18, W23
    FMADD  S16, S5, S9, S1
    FMADD  S26, S30, S2, S9
    FNMADD  D13, D21, D21, D22
    FMOV  X10, H10
    FMOV  S20, W11
    FMADD  H17, H12, H23, H13
    FMOV  W8, H8
    FMOV  S27, #-1.06250000
    FMADD  S20, S20, S16, S21
    FMOV  H16, H22
    FNMADD  D17, D27, D11, D5
    FMADD  S1, S31, S25, S4
    FMOV  D29, X8
    FMSUB  H18, H21, H10, H17
    FMOV  S0, S10
    FMOV  D6, X20
    FMOV  X20, D24
    FMOV  S26, #-14.00000000
    FMOV  H22, #7.25000000
    FMOV  W10, H28
    FNMADD  H7, H19, H31, H11
    FMADD  H0, H21, H6, H20
    FNMSUB  D18, D20, D20, D18
    FMOV  H11, H22
    FMADD  S6, S9, S9, S28
    FMOV  S30, W17
    FMOV  D16, #0.96875000
    FNMADD  D31, D26, D9, D23
    FMOV  S24, #4.25000000
    FMADD  D1, D12, D7, D6
    FMOV  W12, S7
    FNMADD  D22, D25, D8, D26
    FMOV  D25, X5
    FNMADD  H19, H1, H8, H14
    FMSUB  S29, S2, S15, S21
    FMOV  S25, W29
    FMOV  D28, X16
    FMSUB  H7, H20, H24, H1
    FMOV  H21, W8
    FMOV  H29, W25
    FMOV  H27, #0.87500000
    FMOV  S21, S1
    FMSUB  S10, S31, S19, S20
    FMOV  S16, S17
    FMOV  S8, S11
    FMOV  H9, H11
    FMSUB  D13, D28, D25, D24
    FMOV  W26, S25
    FMOV  D8, X3
    FMOV  S5, W3
    FMOV  W10, H21
    FNMSUB  S3, S20, S19, S14
    FMSUB  S14, S22, S3, S19
    FNMSUB  D27, D6, D21, D21
    FMOV  H6, #-0.17968750
    FMOV  W17, S1
    FMSUB  D0, D28, D12, D31
    FMOV  S4, W13
    FMADD  D25, D4, D11, D22
    FMOV  H29, W7
    FNMADD  D23, D1, D29, D8
    FMOV  W22, S14
    FMSUB  S4, S28, S20, S23
    FMOV  S19, W22
    FMOV  H1, H0
    FMOV  H25, W7
    FNMSUB  S13, S1, S6, S5
    FMADD  S0, S4, S16, S5
    FNMSUB  H4, H19, H22, H9
    FMOV  W12, S20
    FNMADD  S26, S25, S24, S15
    FMOV  X17, H4
    FMOV  S28, #0.25000000
    FMOV  H3, W12
    FMADD  D28, D25, D12, D31
    FMOV  D23, #0.78125000
    FNMSUB  H20, H22, H16, H30
    FMOV  S18, W27
    FMSUB  D3, D26, D14, D10
    FMOV  H20, #15.00000000
    FMOV  S22, #11.50000000
    FMSUB  S13, S22, S0, S3
    FMOV  H21, H30
    FMSUB  S4, S18, S28, S15
    FMOV  H29, #0.68750000
    FMOV  W29, S10
    FNMSUB  H8, H24, H1, H23
    FNMADD  H20, H20, H3, H12
    FMOV  S3, S31
    FMSUB  H13, H31, H19, H29
    FMOV  D7, X12
    FNMADD  S12, S3, S14, S15
    FMOV  S10, W7
    FNMADD  D15, D6, D7, D26
    FMOV  X7, H1
    FNMSUB  S15, S0, S18, S26
    FNMSUB  S22, S3, S28, S4
    FMSUB  H31, H26, H0, H13
    FMOV  X25, D2
    FNMSUB  S5, S31, S5, S23
    FNMSUB  D15, D10, D28, D24
    FNMSUB  H15, H0, H4, H23
    FMOV  D18, D21
    FMOV  W10, S15
    FMOV  H20, X17
    FMOV  H22, H21
    FNMSUB  H11, H5, H26, H23
    FMOV  D27, #8.00000000
    FNMSUB  S28, S3, S14, S9
    FMOV  H25, H12
    FMOV  X9, H22
    FMOV  W26, S6
    FNMSUB  H25, H15, H31, H27
    FMOV  D7, #-0.34375000
    FMOV  X14, H16
    FMOV  S13, W14
    FMOV  H8, H22
    FNMSUB  D11, D22, D11, D22
    FMOV  S5, W15
    FMOV  S8, W5
    FNMSUB  H6, H22, H18, H16
    FMADD  H2, H11, H19, H16
    FMOV  S8, S15
    FMSUB  D3, D2, D23, D7
    FMADD  S28, S28, S11, S27
    FNMSUB  H25, H20, H27, H14
    FMOV  S17, W4
    FMOV  S8, S5
    FNMADD  D28, D18, D21, D8
    FNMSUB  S15, S0, S23, S25
    SUBS  X2, X2, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_772
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x9bcf, LSL #0
    MOVK  X29, #0x1ea2, LSL #16
    MOVK  X29, #0x8319, LSL #32
    MOVK  X29, #0xc580, LSL #48
    SUB  X20, X29, X3
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0xc9f2, LSL #0
    SUB  X18, X29, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x990f, LSL #0
    MOVK  X20, #0xd4d2, LSL #16
    MOVK  X20, #0x1bb9, LSL #32
    MOVK  X20, #0xcecc, LSL #48
    SUB  X7, X20, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x62cc, LSL #0
    MOVK  X20, #0x7854, LSL #16
    MOVK  X20, #0x45e4, LSL #32
    MOVK  X20, #0x88b7, LSL #48
    SUB  X2, X20, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x934f, LSL #0
    SUB  X2, X9, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0xdd66, LSL #0
    MOVK  X20, #0x196, LSL #16
    MOVK  X20, #0xcc58, LSL #32
    MOVK  X20, #0x96fa, LSL #48
    SUB  X5, X20, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x9910, LSL #0
    SUB  X20, X23, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0xb276, LSL #0
    MOVK  X3, #0x5ec5, LSL #16
    MOVK  X3, #0xb996, LSL #32
    MOVK  X3, #0x470, LSL #48
    SUB  X23, X3, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0xc740, LSL #0
    SUB  X16, X23, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0xea0a, LSL #0
    MOVK  X25, #0x9334, LSL #16
    MOVK  X25, #0x3ae2, LSL #32
    MOVK  X25, #0x93d4, LSL #48
    SUB  X14, X25, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X15, X29, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0xc740, LSL #0
    SUB  X14, X26, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0xea0a, LSL #0
    MOVK  X24, #0x9334, LSL #16
    MOVK  X24, #0x3ae2, LSL #32
    MOVK  X24, #0x93d4, LSL #48
    SUB  X7, X24, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0xc740, LSL #0
    SUB  X20, X17, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x477, LSL #0
    MOVK  X3, #0xa056, LSL #16
    MOVK  X3, #0xf88, LSL #32
    MOVK  X3, #0xf04c, LSL #48
    SUB  X24, X3, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D2
    MOVZ  X13, #0x4000, LSL #0
    SUB  X24, X13, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D3
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xbfd6, LSL #48
    SUB  X23, X20, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D4
    MOVZ  X23, #0x337d, LSL #0
    MOVK  X23, #0xbd43, LSL #16
    SUB  X3, X23, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D5
    MOVZ  X20, #0xb276, LSL #0
    MOVK  X20, #0x5ec5, LSL #16
    SUB  X28, X20, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D6
    MOVZ  X12, #0xc000, LSL #0
    SUB  X10, X12, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D7
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xbfd6, LSL #48
    SUB  X22, X14, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D8
    MOVZ  X25, #0xb276, LSL #0
    MOVK  X25, #0x5ec5, LSL #16
    SUB  X24, X25, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D9
    MOVZ  X15, #0x4740, LSL #0
    SUB  X3, X15, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X7, X13, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D11
    MOVZ  X13, #0x1, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X7, X13, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D12
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7fc0, LSL #16
    SUB  X2, X11, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D13
    MOVZ  X2, #0x4000, LSL #0
    SUB  X5, X2, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D14
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7f80, LSL #16
    SUB  X8, X21, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D15
    MOVZ  X4, #0x8000, LSL #0
    MOVK  X4, #0x8000, LSL #16
    SUB  X17, X4, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D16
    MOVZ  X20, #0x4000, LSL #0
    MOVK  X20, #0x95a2, LSL #16
    SUB  X7, X20, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D17
    MOVZ  X8, #0xc9f2, LSL #0
    SUB  X14, X8, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D18
    MOVZ  X5, #0x1, LSL #0
    SUB  X12, X5, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D19
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7f80, LSL #16
    SUB  X8, X29, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D20
    MOVZ  X21, #0xc740, LSL #0
    SUB  X18, X21, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D21
    MOVZ  X28, #0x1, LSL #0
    SUB  X13, X28, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D22
    MOVZ  X5, #0x1, LSL #0
    SUB  X13, X5, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D23
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x3fe9, LSL #48
    SUB  X3, X7, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D24
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x4088, LSL #16
    SUB  X23, X10, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D25
    MOVZ  X29, #0x8000, LSL #0
    SUB  X14, X29, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
TaishanFpMiniMaxiP01_label_606:
    FMOV  X17, D26
    MOVZ  X18, #0x337d, LSL #0
    MOVK  X18, #0x3d43, LSL #16
    SUB  X16, X18, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D27
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x4020, LSL #48
    SUB  X15, X20, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D28
    MOVZ  X21, #0xb276, LSL #0
    MOVK  X21, #0x5ec5, LSL #16
    MOVK  X21, #0x8000, LSL #48
    SUB  X17, X21, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X9, X20, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D29
    MOVZ  X20, #0x3980, LSL #0
    SUB  X9, X20, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X19
    FMOV  V0.D[1], X25
    FMOV  D1, X14
    FMOV  V1.D[1], X20
    FMOV  D2, X21
    FMOV  V2.D[1], X8
    FMOV  D3, X23
    FMOV  V3.D[1], X8
    FMOV  D4, X18
    FMOV  V4.D[1], X26
    FMOV  D5, X22
    FMOV  V5.D[1], X17
    FMOV  D6, X28
    FMOV  V6.D[1], X15
    FMOV  D7, X20
    FMOV  V7.D[1], X3
    FMOV  D8, X10
    FMOV  V8.D[1], X14
    FMOV  D9, X4
    FMOV  V9.D[1], X4
    FMOV  D10, X15
    FMOV  V10.D[1], X10
    FMOV  D11, X4
    FMOV  V11.D[1], X17
    FMOV  D12, X14
    FMOV  V12.D[1], X20
    FMOV  D13, X22
    FMOV  V13.D[1], X24
    FMOV  D14, X14
    FMOV  V14.D[1], X4
    FMOV  D15, X3
    FMOV  V15.D[1], X11
    FMOV  D16, X22
    FMOV  V16.D[1], X20
    FMOV  D17, X29
    FMOV  V17.D[1], X20
    FMOV  D18, X7
    FMOV  V18.D[1], X23
    FMOV  D19, X28
    FMOV  V19.D[1], X26
    FMOV  D20, X22
    FMOV  V20.D[1], X20
    FMOV  D21, X7
    FMOV  V21.D[1], X17
    FMOV  D22, X20
    FMOV  V22.D[1], X22
    FMOV  D23, X14
    FMOV  V23.D[1], X22
    FMOV  D24, X7
    FMOV  V24.D[1], X24
    FMOV  D25, X19
    FMOV  V25.D[1], X16
    FMOV  D26, X8
    FMOV  V26.D[1], X21
    FMOV  D27, X7
    FMOV  V27.D[1], X23
    FMOV  D28, X12
    FMOV  V28.D[1], X24
    FMOV  D29, X4
    FMOV  V29.D[1], X23
    FMOV  D30, X15
    FMOV  V30.D[1], X28
    FMOV  D31, X17
    FMOV  V31.D[1], X15
    MOVZ  X19, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_856:
    FMOV  H17, #0.87500000
    FMADD  H19, H28, H14, H13
    FNMADD  H10, H9, H24, H29
    FMSUB  S10, S7, S1, S21
    FMADD  D13, D21, D9, D21
    FMOV  H20, H21
    FMSUB  S5, S28, S20, S10
    FMADD  D2, D5, D28, D25
    FNMSUB  H9, H10, H1, H25
    FNMSUB  D8, D9, D14, D23
    FMOV  H22, W3
    FMOV  D6, #-8.00000000
    FMOV  H13, W24
    FNMADD  H17, H28, H8, H19
    FMOV  D23, #-2.87500000
    FMOV  D28, #0.71875000
    FNMADD  H15, H14, H7, H7
    FMADD  S19, S9, S25, S26
    FMOV  X10, D26
    FNMSUB  S21, S8, S24, S2
    FMSUB  S15, S17, S14, S22
    FMOV  X27, H17
    FMOV  D1, #-0.25000000
    FMOV  H29, #1.81250000
    FMOV  W18, H21
    FNMSUB  D20, D10, D3, D9
    FNMADD  H5, H28, H2, H9
    FMOV  H19, X14
    FMOV  H23, H23
    FNMSUB  H19, H8, H11, H23
    FMADD  S6, S13, S7, S0
    FMOV  W14, H25
    FMOV  S19, W12
    FMSUB  S22, S21, S20, S30
    FMADD  S24, S24, S13, S3
    FMSUB  D17, D15, D12, D17
    FMOV  S31, #-19.00000000
    FMSUB  H14, H29, H11, H28
    FMOV  H9, #-0.93750000
    FNMADD  H8, H19, H25, H0
    FMADD  S13, S13, S18, S9
    FMSUB  H31, H27, H9, H10
    FNMSUB  S30, S18, S27, S10
    FNMSUB  D18, D0, D22, D28
    FNMSUB  S6, S5, S24, S1
    FMOV  S18, W10
    FMOV  H6, H16
    FMOV  S25, S23
    FMADD  S23, S9, S17, S0
    FMSUB  H25, H5, H24, H6
    FMADD  D4, D8, D11, D10
    FMOV  W13, H17
    FMOV  X12, H26
    FMSUB  S29, S17, S29, S12
    FMOV  W24, H17
    FMADD  D29, D18, D19, D12
    FNMSUB  H14, H27, H23, H17
    FMOV  X16, D1
    FMOV  H15, H8
    FMOV  S15, S17
    FMOV  S24, #-1.81250000
    FMOV  H6, #0.15625000
    FMOV  H22, X15
    FMOV  X13, H25
    FMOV  X5, D13
    FMOV  H10, #-0.65625000
    FMOV  W27, S28
    FMOV  X20, H18
    FMADD  H15, H10, H12, H29
    FNMADD  H24, H28, H15, H19
    FMOV  H16, W4
    FMSUB  H13, H1, H12, H6
    FMSUB  H24, H0, H4, H26
    FMOV  D20, X23
    FMOV  D8, #3.12500000
    FMOV  H27, H14
    FMOV  H7, #-0.65625000
    FNMSUB  H25, H7, H7, H22
    FMOV  D1, D4
    FNMADD  D21, D9, D1, D23
    FMOV  W2, H8
    FMOV  H20, W11
    FMADD  D20, D2, D0, D20
    FNMADD  S30, S9, S17, S28
    FMOV  S30, S0
    FNMADD  D22, D1, D21, D4
    FMSUB  H29, H23, H21, H12
    FMADD  S4, S18, S27, S2
    FMOV  S0, S1
    FMOV  H0, H25
    FNMSUB  D15, D17, D6, D12
    FMOV  D1, X9
    FMOV  D18, X11
    FMOV  X25, H14
    FMSUB  H30, H25, H20, H15
    FMADD  H30, H26, H17, H3
    FNMADD  D21, D28, D24, D30
    FNMSUB  D8, D12, D22, D27
    FMOV  H14, W2
    FMOV  W25, S20
    FMOV  D22, #25.00000000
    FMOV  H18, W4
    FMOV  H25, X21
    FMSUB  D16, D15, D15, D18
    FMADD  D30, D16, D1, D4
    FMOV  H8, H18
    FNMSUB  S20, S6, S26, S17
    FMOV  H11, W29
    FMSUB  H30, H8, H12, H19
    FMOV  D27, #-0.42187500
    FMOV  W21, H17
    FMADD  S26, S18, S19, S28
    FMADD  D7, D19, D11, D8
    FMOV  H15, H8
    FMOV  X21, H27
    FMOV  S20, W16
    FNMSUB  D12, D21, D30, D22
    FMSUB  H0, H8, H19, H26
    FMOV  W21, H27
    FMSUB  H25, H6, H22, H7
    FMOV  D16, #0.28125000
    FMSUB  H25, H22, H16, H10
    FMOV  W12, H21
    FMOV  H19, X8
    FMOV  X10, H3
    FMOV  S20, W17
    FMOV  X9, H15
    FMADD  H16, H27, H20, H19
    FNMADD  D15, D24, D30, D12
    FMOV  D4, X17
    FNMADD  D18, D22, D19, D4
    FMOV  S31, W3
    FMSUB  H20, H22, H20, H0
    FNMADD  D18, D15, D10, D18
    FMOV  H8, H18
    FNMSUB  S17, S11, S24, S20
    FMOV  H18, #-7.00000000
    FMOV  H30, H18
    FMOV  W9, S10
    FMSUB  S8, S22, S7, S18
    FNMSUB  H20, H8, H6, H11
    FMOV  H14, X7
    FMADD  H4, H23, H25, H26
    FMOV  S13, #2.00000000
    FMADD  S12, S21, S27, S19
    FMOV  D10, #10.00000000
    FMSUB  D27, D11, D26, D30
    FNMSUB  H17, H13, H1, H1
    FMOV  S7, S26
    FMSUB  H31, H1, H31, H13
    FMOV  D24, X15
    FMOV  S22, #17.00000000
    FMOV  D21, D0
    FMOV  D0, #-2.00000000
    FMADD  S2, S12, S19, S27
    FMSUB  S1, S12, S15, S29
    FNMSUB  D27, D3, D27, D12
    FMADD  S14, S24, S4, S22
    FMOV  D10, #-1.18750000
    FMOV  X24, H1
    FMOV  H7, W7
    FNMADD  H16, H13, H7, H16
    FMOV  X28, D16
    FNMSUB  D3, D10, D20, D0
    FNMSUB  D29, D15, D30, D26
    FMOV  H27, W9
    FMOV  H31, X17
    FMOV  S9, W13
    FNMSUB  D11, D10, D28, D26
    FNMADD  D12, D6, D17, D1
    FMSUB  H4, H20, H8, H6
    FMOV  X12, D30
    FNMSUB  S2, S28, S28, S8
    FMOV  D26, D3
    FMOV  W14, S11
    FMSUB  S7, S12, S9, S9
    FMADD  D29, D4, D29, D0
    FMOV  S1, #-30.00000000
    FMADD  S11, S20, S14, S2
    FMOV  H6, X14
    FMADD  H30, H5, H13, H26
    FMADD  H24, H19, H1, H21
    FMOV  H6, X22
    FMADD  D12, D7, D11, D18
    FNMADD  H19, H27, H31, H27
    FMADD  H19, H9, H3, H15
    FMOV  X6, D25
    FMOV  S29, #0.93750000
    FMOV  W7, H1
    FMADD  H29, H4, H6, H19
    FMOV  D26, #-22.00000000
    FMOV  D3, #-0.20312500
    FMOV  X6, H29
    FMADD  D30, D21, D17, D30
    FMOV  D30, #0.96875000
    FMOV  W18, S19
    FMOV  S26, S11
    FMOV  W29, S10
    FMOV  W25, S5
    FMOV  W14, H5
    SUBS  X19, X19, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_856
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0xbb81, LSL #0
    SUB  X15, X26, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0xb940, LSL #0
    SUB  X16, X27, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0xc700, LSL #0
    SUB  X14, X26, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D2
    MOVZ  X10, #0xc700, LSL #0
    MOVK  X10, #0x8000, LSL #16
    SUB  X6, X10, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D3
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xbfca, LSL #48
    SUB  X19, X14, X22
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D4
    MOVZ  X11, #0xc780, LSL #0
    SUB  X2, X11, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D5
    MOVZ  X21, #0xb940, LSL #0
    SUB  X14, X21, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D7
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D8
    MOVZ  X15, #0xc700, LSL #0
    SUB  X24, X15, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D10
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xbff3, LSL #48
    SUB  X23, X15, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D11
    MOVZ  X24, #0xbb60, LSL #0
    MOVK  X24, #0xb, LSL #16
    SUB  X12, X24, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D12
    MOVZ  X15, #0xc700, LSL #0
    SUB  X25, X15, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D13
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x4000, LSL #16
    SUB  X12, X27, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D14
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4188, LSL #16
    SUB  X10, X15, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D15
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x4039, LSL #48
    SUB  X10, X24, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D16
    MOVZ  X11, #0x8000, LSL #0
    SUB  X15, X11, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D17
    MOVZ  X15, #0x3940, LSL #0
    SUB  X7, X15, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D18
    MOVZ  X15, #0xc700, LSL #0
    SUB  X21, X15, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D19
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D20
    MOVZ  X24, #0xbc60, LSL #0
    SUB  X15, X24, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D21
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D22
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x4188, LSL #16
    SUB  X25, X9, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D23
    MOVZ  X13, #0x1, LSL #0
    SUB  X6, X13, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D24
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D25
    MOVZ  X4, #0xb940, LSL #0
    SUB  X17, X4, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D26
    MOVZ  X21, #0xbb60, LSL #0
    MOVK  X21, #0xb, LSL #16
    SUB  X25, X21, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D27
    MOVZ  X22, #0xb940, LSL #0
    SUB  X7, X22, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X27, X9, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D28
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x3fe7, LSL #48
    SUB  X27, X9, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D29
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
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
TaishanFpMiniMaxiP01_label_608:
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
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X2
    FMOV  D1, X9
    FMOV  V1.D[1], X26
    FMOV  D2, X7
    FMOV  V2.D[1], X27
    FMOV  D3, X26
    FMOV  V3.D[1], X25
    FMOV  D4, X29
    FMOV  V4.D[1], X19
    FMOV  D5, X21
    FMOV  V5.D[1], X19
    FMOV  D6, X15
    FMOV  V6.D[1], X7
    FMOV  D7, X28
    FMOV  V7.D[1], X23
    FMOV  D8, X24
    FMOV  V8.D[1], X19
    FMOV  D9, X3
    FMOV  V9.D[1], X17
    FMOV  D10, X5
    FMOV  V10.D[1], X10
    FMOV  D11, X13
    FMOV  V11.D[1], X15
    FMOV  D12, X28
    FMOV  V12.D[1], X4
    FMOV  D13, X25
    FMOV  V13.D[1], X7
    FMOV  D14, X9
    FMOV  V14.D[1], X18
    FMOV  D15, X22
    FMOV  V15.D[1], X2
    FMOV  D16, X7
    FMOV  V16.D[1], X21
    FMOV  D17, X29
    FMOV  V17.D[1], X4
    FMOV  D18, X21
    FMOV  V18.D[1], X5
    FMOV  D19, X3
    FMOV  V19.D[1], X4
    FMOV  D20, X11
    FMOV  V20.D[1], X5
    FMOV  D21, X5
    FMOV  V21.D[1], X28
    FMOV  D22, X23
    FMOV  V22.D[1], X26
    FMOV  D23, X2
    FMOV  V23.D[1], X17
    FMOV  D24, X17
    FMOV  V24.D[1], X20
    FMOV  D25, X14
    FMOV  V25.D[1], X22
    FMOV  D26, X6
    FMOV  V26.D[1], X11
    FMOV  D27, X22
    FMOV  V27.D[1], X19
    FMOV  D28, X7
    FMOV  V28.D[1], X23
    FMOV  D29, X9
    FMOV  V29.D[1], X29
    FMOV  D30, X14
    FMOV  V30.D[1], X23
    FMOV  D31, X28
    FMOV  V31.D[1], X23
    MOVZ  X27, #0xf, LSL #0
TaishanFpMiniMaxiP01_label_940:
    FNMADD  D4, D8, D6, D8
    FNMADD  S3, S25, S17, S28
    FMOV  S30, W7
    FMOV  S17, #-0.56250000
    FMOV  D23, #-29.00000000
    FNMADD  D17, D23, D22, D5
    FMADD  H7, H26, H17, H26
    FMOV  S29, W12
    FMOV  S2, W20
    FNMADD  S15, S19, S18, S27
    FMOV  W15, S19
    FNMSUB  S16, S2, S28, S4
    FNMSUB  H11, H21, H3, H6
    FNMADD  D26, D22, D18, D15
    FMOV  W13, H24
    FMOV  W8, S9
    FMOV  D8, X11
    FMOV  H20, H20
    FMOV  W7, S5
    FMOV  W20, H21
    FNMSUB  H16, H12, H25, H8
    FMOV  S7, S10
    FMSUB  S30, S9, S31, S29
    FNMADD  H9, H26, H11, H9
    FNMSUB  D21, D29, D1, D26
    FMOV  W16, S22
    FMOV  X3, D21
    FMOV  S27, W16
    FMOV  S6, S9
    FMOV  H6, W4
    FNMADD  D26, D13, D16, D23
    FNMSUB  D18, D7, D7, D5
    FNMSUB  S24, S1, S9, S22
    FMSUB  S22, S24, S25, S17
    FMSUB  D27, D5, D9, D21
    FMOV  X18, D6
    FMOV  H7, H2
    FMOV  W24, S31
    FMSUB  H30, H30, H30, H28
    FMOV  S5, #-0.34375000
    FNMSUB  S3, S30, S13, S7
    FNMSUB  D18, D16, D2, D25
    FMADD  S2, S29, S3, S0
    FNMADD  D18, D14, D23, D9
    FMOV  W17, S11
    FMOV  H21, #2.25000000
    FMOV  X4, H23
    FMOV  X28, D21
    FMADD  H6, H24, H29, H23
    FMOV  X11, H3
    FMOV  X24, D2
    FMOV  H5, X17
    FMOV  W5, S27
    FMOV  S17, #-0.87500000
    FMSUB  H2, H11, H14, H17
    FMOV  H8, X24
    FMOV  H30, #-0.25000000
    FMOV  W17, H18
    FMOV  S28, S2
    FMOV  X19, H28
    FMOV  D14, X17
    FMSUB  D20, D8, D2, D5
    FMOV  D9, #-0.15625000
    FMOV  S13, S7
    FMADD  S13, S0, S9, S9
    FMOV  H19, X19
    FMOV  D4, X6
    FMOV  W5, H25
    FMOV  W5, S7
    FNMSUB  H16, H19, H19, H5
    FMOV  D26, #6.75000000
    FNMSUB  H28, H13, H2, H25
    FNMADD  H13, H5, H12, H29
    FMOV  S13, S26
    FMSUB  D14, D3, D29, D9
    FNMADD  H13, H3, H2, H0
    FMADD  D31, D3, D9, D24
    FNMADD  H12, H21, H9, H19
    FMOV  S12, #-0.96875000
    FMOV  H12, #3.00000000
    FMOV  H19, #0.81250000
    FMSUB  S24, S4, S26, S23
    FMOV  X29, D20
    FNMADD  D20, D31, D14, D30
    FNMADD  H0, H3, H17, H8
    FMOV  X11, H28
    FMADD  D13, D20, D9, D22
    FMOV  X25, D5
    FNMSUB  H10, H18, H31, H4
    FMSUB  H10, H7, H10, H26
    FMOV  H16, X12
    FMOV  D0, D18
    FNMADD  D25, D31, D11, D16
    FMOV  H3, #3.87500000
    FNMADD  D20, D23, D12, D22
    FMOV  H1, H24
    FMOV  D28, X12
    FNMADD  H28, H1, H26, H13
    FMOV  W7, H17
    FMOV  S19, W14
    FMOV  X3, H12
    FMSUB  S25, S10, S14, S9
    FNMSUB  D20, D23, D16, D3
    FMOV  S17, S23
    FMSUB  S0, S21, S25, S23
    FNMADD  H27, H30, H26, H17
    FMOV  X25, D27
    FMSUB  H25, H8, H29, H0
    FNMSUB  D19, D10, D9, D2
    FMOV  W15, S26
    FMOV  W14, H13
    FNMSUB  S31, S20, S22, S19
    FNMADD  S5, S5, S29, S20
    FMOV  H25, W3
    FMADD  S1, S1, S8, S3
    FMSUB  S21, S0, S9, S31
    FNMADD  S6, S16, S12, S1
    FMOV  D28, X7
    FMOV  S11, #-8.00000000
    FMSUB  D5, D25, D12, D1
    FNMSUB  D23, D2, D3, D30
    FMOV  W6, S1
    FMOV  S24, W29
    FNMADD  H16, H10, H23, H27
    FMSUB  D10, D15, D20, D2
    FMOV  H23, #0.23437500
    FMOV  H27, H2
    FMOV  W13, H4
    FNMADD  D12, D28, D25, D8
    FNMSUB  D2, D26, D29, D28
    FMOV  S12, W14
    FNMSUB  D28, D6, D11, D17
    FMOV  H2, #-12.00000000
    FMOV  H10, H30
    FMOV  W13, H28
    FMOV  X20, D6
    FMOV  S23, #-1.37500000
    FMADD  S17, S12, S6, S22
    FMOV  H10, X20
    FMOV  S29, #-0.75000000
    FNMSUB  S13, S12, S18, S24
    FMOV  H28, H15
    FMOV  D27, X13
    FNMSUB  H3, H4, H8, H17
    FMADD  H22, H7, H10, H14
    FMOV  H3, H26
    FMOV  W20, H19
    FMSUB  S24, S0, S20, S3
    FMOV  D20, D2
    FMOV  H9, #4.75000000
    FMOV  D9, D8
    FMOV  W16, H29
    FMSUB  S0, S1, S27, S29
    FMADD  S14, S8, S5, S0
    FMOV  X7, H2
    FNMADD  H12, H23, H20, H17
    FMOV  D7, #15.50000000
    FMOV  S18, W2
    FNMSUB  D27, D5, D7, D15
    FMOV  X11, D31
    FMOV  H3, W21
    FMOV  X12, H16
    FMOV  D7, D8
    FMOV  D8, X5
    FMOV  H10, W24
    FNMADD  H19, H11, H6, H22
    FMOV  S7, W25
    FMADD  H19, H14, H10, H2
    FMSUB  H24, H25, H27, H12
    FMOV  D4, X22
    FNMSUB  H13, H9, H23, H23
    FMSUB  S3, S13, S18, S1
    FMOV  S6, #-0.21875000
    FMOV  H6, #-8.00000000
    FNMADD  D20, D26, D31, D19
    FMOV  X13, H7
    FNMADD  S12, S10, S25, S26
    FMADD  D0, D15, D22, D18
    FNMSUB  H24, H12, H31, H11
    FMOV  S11, W14
    FMADD  H20, H15, H18, H29
    FNMSUB  S31, S21, S16, S31
    FMOV  X17, D22
    FMOV  S8, S22
    FMOV  X13, H7
    FMOV  S31, #-1.50000000
    FNMSUB  H25, H15, H4, H24
    FNMADD  H5, H19, H15, H6
    FNMSUB  S4, S7, S30, S13
    FNMADD  D26, D18, D31, D14
    FNMSUB  D28, D25, D10, D3
    FNMADD  H1, H9, H13, H12
    FMOV  D24, D10
    FMOV  X17, H21
    FMOV  H26, X12
    FMADD  D14, D26, D21, D11
    FMOV  W5, H3
    FMADD  D5, D10, D5, D8
    FMOV  W12, H26
    FNMSUB  D18, D10, D20, D27
    SUBS  X27, X27, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_940
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X28, X20, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x4200, LSL #0
    SUB  X12, X5, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x4200, LSL #0
    SUB  X29, X22, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x43c0, LSL #0
    SUB  X18, X21, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0xca00, LSL #0
    SUB  X17, X8, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0xca00, LSL #0
    SUB  X11, X18, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
TaishanFpMiniMaxiP01_label_605:
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X17, X10, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X16, X14, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X20, X23, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0xca00, LSL #0
    SUB  X11, X16, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x43c0, LSL #0
    SUB  X6, X26, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x4200, LSL #0
    SUB  X11, X18, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X12, X3, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x43c0, LSL #0
    SUB  X21, X18, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D2
    MOVZ  X26, #0xca00, LSL #0
    SUB  X5, X26, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D3
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X22, X15, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D4
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D5
    MOVZ  X10, #0xa0fc, LSL #0
    SUB  X23, X10, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D6
    MOVZ  X25, #0xc800, LSL #0
    SUB  X12, X25, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D7
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D8
    MOVZ  X4, #0xa0fc, LSL #0
    SUB  X25, X4, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D9
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D11
    MOVZ  X20, #0x4b8b, LSL #0
    SUB  X27, X20, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D12
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #16
    SUB  X25, X5, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D13
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D14
    MOVZ  X23, #0x4b8c, LSL #0
    SUB  X26, X23, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D15
    MOVZ  X9, #0x922f, LSL #0
    MOVK  X9, #0x7fc6, LSL #16
    SUB  X5, X9, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D16
    MOVZ  X23, #0x98fb, LSL #0
    SUB  X27, X23, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D17
    MOVZ  X24, #0x9bad, LSL #0
    MOVK  X24, #0x11, LSL #16
    SUB  X11, X24, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D18
    MOVZ  X21, #0x780f, LSL #0
    MOVK  X21, #0x7fc2, LSL #16
    SUB  X23, X21, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D19
    MOVZ  X14, #0xca00, LSL #0
    SUB  X23, X14, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D20
    MOVZ  X22, #0xffff, LSL #0
    SUB  X11, X22, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D21
    MOVZ  X20, #0x9925, LSL #0
    MOVK  X20, #0x8000, LSL #16
    SUB  X12, X20, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D22
    MOVZ  X26, #0xa0fc, LSL #0
    SUB  X14, X26, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D23
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xbfb0, LSL #16
    SUB  X19, X21, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D24
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D25
    MOVZ  X7, #0xffff, LSL #0
    SUB  X22, X7, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D26
    MOVZ  X17, #0x98fb, LSL #0
    SUB  X19, X17, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D27
    MOVZ  X16, #0x780f, LSL #0
    MOVK  X16, #0x7fc2, LSL #16
    MOVK  X16, #0x8000, LSL #48
    SUB  X13, X16, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D28
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0x8000, LSL #48
    SUB  X18, X7, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D29
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xbf40, LSL #16
    SUB  X3, X4, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x853b, LSL #0
    MOVK  X2, #0x3064, LSL #16
    MOVK  X2, #0x9d05, LSL #32
    MOVK  X2, #0x6d5a, LSL #48
    MOVZ  X3, #0x205a, LSL #0
    MOVK  X3, #0xc6b4, LSL #16
    MOVK  X3, #0x1250, LSL #32
    MOVK  X3, #0x2d8d, LSL #48
    MOVZ  X4, #0x6a1a, LSL #0
    MOVK  X4, #0xfb10, LSL #16
    MOVK  X4, #0xade1, LSL #32
    MOVK  X4, #0xc0b0, LSL #48
    MOVZ  X5, #0x1cd1, LSL #0
    MOVK  X5, #0x39fc, LSL #16
    MOVK  X5, #0xfc10, LSL #32
    MOVK  X5, #0xca7b, LSL #48
    MOVZ  X6, #0xbda0, LSL #0
    MOVK  X6, #0x2b63, LSL #16
    MOVK  X6, #0xcc04, LSL #32
    MOVK  X6, #0x4b29, LSL #48
    MOVZ  X7, #0x732, LSL #0
    MOVK  X7, #0x7a70, LSL #16
    MOVK  X7, #0x26e5, LSL #32
    MOVK  X7, #0xa144, LSL #48
    MOVZ  X8, #0x87f1, LSL #0
    MOVK  X8, #0x1cf2, LSL #16
    MOVK  X8, #0x3065, LSL #32
    MOVK  X8, #0xcc56, LSL #48
    MOVZ  X9, #0x5ecd, LSL #0
    MOVK  X9, #0xaec4, LSL #16
    MOVK  X9, #0x62fd, LSL #32
    MOVK  X9, #0xfa63, LSL #48
    MOVZ  X10, #0xd476, LSL #0
    MOVK  X10, #0xee8c, LSL #16
    MOVK  X10, #0xd86d, LSL #32
    MOVK  X10, #0xe6a0, LSL #48
    MOVZ  X11, #0x51ad, LSL #0
    MOVK  X11, #0x4660, LSL #16
    MOVK  X11, #0xb7f1, LSL #32
    MOVK  X11, #0x45ee, LSL #48
    MOVZ  X12, #0x978b, LSL #0
    MOVK  X12, #0xaa9b, LSL #16
    MOVK  X12, #0xcb97, LSL #32
    MOVK  X12, #0x1479, LSL #48
    MOVZ  X13, #0xa3dc, LSL #0
    MOVK  X13, #0x2450, LSL #16
    MOVK  X13, #0x303, LSL #32
    MOVK  X13, #0x256d, LSL #48
    MOVZ  X14, #0x9969, LSL #0
    MOVK  X14, #0xff32, LSL #16
    MOVK  X14, #0x76d4, LSL #32
    MOVK  X14, #0x653b, LSL #48
    MOVZ  X15, #0xd917, LSL #0
    MOVK  X15, #0x8853, LSL #16
    MOVK  X15, #0x893e, LSL #32
    MOVK  X15, #0xad52, LSL #48
    MOVZ  X16, #0xd1e3, LSL #0
    MOVK  X16, #0x54d8, LSL #16
    MOVK  X16, #0x8bc2, LSL #32
    MOVK  X16, #0x7517, LSL #48
    MOVZ  X17, #0x68e4, LSL #0
    MOVK  X17, #0xb2e6, LSL #16
    MOVK  X17, #0xbde, LSL #32
    MOVK  X17, #0x4323, LSL #48
    MOVZ  X18, #0xc74b, LSL #0
    MOVK  X18, #0xca2b, LSL #16
    MOVK  X18, #0xcb3, LSL #32
    MOVK  X18, #0xb777, LSL #48
    MOVZ  X19, #0x4c8b, LSL #0
    MOVK  X19, #0x9f1a, LSL #16
    MOVK  X19, #0x7a6, LSL #32
    MOVK  X19, #0x2571, LSL #48
    MOVZ  X20, #0x1b59, LSL #0
    MOVK  X20, #0x89e7, LSL #16
    MOVK  X20, #0x561b, LSL #32
    MOVK  X20, #0xe467, LSL #48
    MOVZ  X21, #0x34ac, LSL #0
    MOVK  X21, #0xec99, LSL #16
    MOVK  X21, #0x85b1, LSL #32
    MOVK  X21, #0x6c08, LSL #48
    MOVZ  X22, #0x43bc, LSL #0
    MOVK  X22, #0x9c8a, LSL #16
    MOVK  X22, #0xb21e, LSL #32
    MOVK  X22, #0xe82b, LSL #48
    MOVZ  X23, #0x21a2, LSL #0
    MOVK  X23, #0x54f6, LSL #16
    MOVK  X23, #0xb00f, LSL #32
    MOVK  X23, #0x1da8, LSL #48
    MOVZ  X24, #0xe8d2, LSL #0
    MOVK  X24, #0xce7c, LSL #16
    MOVK  X24, #0x1b66, LSL #32
    MOVK  X24, #0x2ad1, LSL #48
    MOVZ  X25, #0x9410, LSL #0
    MOVK  X25, #0xe3a2, LSL #16
    MOVK  X25, #0xf328, LSL #32
    MOVK  X25, #0x8918, LSL #48
    MOVZ  X26, #0x33f7, LSL #0
    MOVK  X26, #0xe8fc, LSL #16
    MOVK  X26, #0xf32, LSL #32
    MOVK  X26, #0x5ea9, LSL #48
    MOVZ  X27, #0xe643, LSL #0
    MOVK  X27, #0xc76c, LSL #16
    MOVK  X27, #0x9239, LSL #32
    MOVK  X27, #0x74b4, LSL #48
    MOVZ  X28, #0x7e, LSL #0
    MOVK  X28, #0xcd28, LSL #16
    MOVK  X28, #0x7972, LSL #32
    MOVK  X28, #0x6ce9, LSL #48
    MOVZ  X29, #0x34d6, LSL #0
    MOVK  X29, #0xaa10, LSL #16
    MOVK  X29, #0xdaa8, LSL #32
    MOVK  X29, #0x6a98, LSL #48
    FMOV  D0, X14
    FMOV  V0.D[1], X25
    FMOV  D1, X7
    FMOV  V1.D[1], X5
    FMOV  D2, X3
    FMOV  V2.D[1], X6
    FMOV  D3, X8
    FMOV  V3.D[1], X26
    FMOV  D4, X28
    FMOV  V4.D[1], X9
    FMOV  D5, X27
    FMOV  V5.D[1], X28
    FMOV  D6, X23
    FMOV  V6.D[1], X18
    FMOV  D7, X28
    FMOV  V7.D[1], X28
    FMOV  D8, X2
    FMOV  V8.D[1], X8
    FMOV  D9, X23
    FMOV  V9.D[1], X13
    FMOV  D10, X27
    FMOV  V10.D[1], X20
    FMOV  D11, X22
    FMOV  V11.D[1], X13
    FMOV  D12, X5
    FMOV  V12.D[1], X20
    FMOV  D13, X25
    FMOV  V13.D[1], X7
    FMOV  D14, X28
    FMOV  V14.D[1], X14
    FMOV  D15, X8
    FMOV  V15.D[1], X11
    FMOV  D16, X28
    FMOV  V16.D[1], X24
    FMOV  D17, X5
    FMOV  V17.D[1], X18
    FMOV  D18, X3
    FMOV  V18.D[1], X16
    FMOV  D19, X5
    FMOV  V19.D[1], X28
    FMOV  D20, X14
    FMOV  V20.D[1], X2
    FMOV  D21, X16
    FMOV  V21.D[1], X18
    FMOV  D22, X4
    FMOV  V22.D[1], X14
    FMOV  D23, X20
    FMOV  V23.D[1], X24
    FMOV  D24, X18
    FMOV  V24.D[1], X4
    FMOV  D25, X9
    FMOV  V25.D[1], X26
    FMOV  D26, X24
    FMOV  V26.D[1], X2
    FMOV  D27, X16
    FMOV  V27.D[1], X3
    FMOV  D28, X6
    FMOV  V28.D[1], X29
    FMOV  D29, X19
    FMOV  V29.D[1], X24
    FMOV  D30, X8
    FMOV  V30.D[1], X3
    FMOV  D31, X29
    FMOV  V31.D[1], X20
    MOVZ  X28, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_1026:
    FMOV  S16, S23
    FMADD  S29, S29, S26, S29
    FMOV  H29, X13
    FMOV  X6, H18
    FMOV  X4, H15
    FNMSUB  H19, H19, H16, H27
    FMOV  S10, W13
    FMSUB  S5, S10, S23, S9
    FMOV  X10, H30
    FMADD  D30, D8, D24, D30
    FMOV  S20, W27
    FMOV  D9, X17
    FNMSUB  D18, D5, D9, D6
    FMOV  S24, W4
    FMOV  S9, W10
    FMADD  S16, S19, S30, S28
    FMOV  X2, D11
    FMOV  H21, #21.00000000
    FNMADD  S5, S10, S3, S5
    FNMADD  D21, D13, D2, D31
    FMOV  S30, S27
    FMOV  D4, X17
    FMADD  D16, D9, D24, D20
    FMADD  D16, D19, D1, D20
    FMOV  H16, #4.50000000
    FMOV  X23, D22
    FMOV  X3, D15
    FMOV  X3, H18
    FMADD  S16, S25, S29, S30
    FMADD  S25, S31, S17, S8
    FMOV  W5, S13
    FMOV  H2, X17
    FMOV  X3, D9
    FMOV  D1, X24
    FMOV  D16, #-0.37500000
    FMOV  H23, #-3.37500000
    FMOV  H11, H31
    FMSUB  S15, S14, S25, S30
    FMOV  D25, D19
    FMOV  S30, S2
    FMSUB  D20, D9, D18, D25
    FNMSUB  H11, H29, H9, H11
    FNMSUB  D22, D22, D14, D20
    FMSUB  H28, H8, H11, H31
    FNMSUB  H29, H19, H22, H22
    FMOV  H31, #6.00000000
    FMOV  H17, #-1.50000000
    FNMSUB  H4, H16, H16, H14
    FNMSUB  D21, D16, D30, D27
    FMSUB  H18, H13, H20, H25
    FMOV  D5, X6
    FMOV  H15, #-4.25000000
    FMOV  S18, #0.43750000
    FMOV  H2, #-28.00000000
    FNMADD  D19, D4, D11, D18
    FMOV  D31, #12.50000000
    FMOV  S17, #19.00000000
    FMOV  H2, H20
    FNMSUB  D21, D13, D3, D13
    FNMSUB  S29, S13, S16, S3
    FMOV  W25, H15
    FMOV  D27, X25
    FMOV  H15, #0.43750000
    FMOV  X11, H20
    FMOV  D13, D5
    FMADD  D15, D25, D15, D18
    FMOV  H12, #-1.25000000
    FMOV  D18, X29
    FMADD  D4, D30, D4, D16
    FMADD  D17, D19, D19, D22
    FMOV  S4, #-0.71875000
    FMOV  D15, D24
    FMOV  W5, H26
    FMOV  D12, D11
    FMOV  W16, S7
    FNMADD  H20, H25, H14, H14
    FMSUB  H17, H30, H15, H20
    FMOV  X23, D27
    FMOV  H4, H13
    FMOV  D29, X8
    FNMADD  D27, D6, D9, D12
    FMOV  D2, #-2.62500000
    FMOV  H5, #-3.87500000
    FNMADD  D31, D13, D23, D19
    FMADD  S17, S13, S14, S17
    FNMADD  S18, S20, S30, S26
    FNMADD  S28, S20, S25, S28
    FMOV  H28, X22
    FMSUB  S10, S9, S17, S17
    FMOV  D15, D13
    FMOV  W19, H27
    FMOV  X21, D6
    FNMSUB  H24, H9, H0, H29
    FMOV  W13, H28
    FMOV  H23, H21
    FMOV  D16, X29
    FNMSUB  S7, S27, S3, S4
    FMSUB  S0, S7, S28, S14
    FMOV  H25, H20
    FMOV  S15, #0.22656250
    FNMADD  H2, H16, H30, H16
    FMOV  W3, S15
    FMOV  S7, #31.00000000
    FMOV  H30, W16
    FMOV  D28, X5
    FMOV  D6, X21
    FMOV  S29, S10
    FMOV  H12, W5
    FMADD  H25, H26, H21, H2
    FMADD  H27, H13, H27, H31
    FNMSUB  S19, S13, S27, S29
    FNMADD  S9, S3, S31, S19
    FMOV  S21, #-6.75000000
    FMOV  W10, H23
    FMOV  X16, H15
    FNMADD  D18, D26, D31, D17
    FMOV  H30, H16
    FMOV  S26, #2.62500000
    FMADD  D25, D30, D5, D5
    FMOV  H21, #-0.14062500
    FMOV  X13, D5
    FMOV  X15, D24
    FMADD  S31, S13, S4, S0
    FMOV  D28, #3.87500000
    FMOV  W24, H5
    FMOV  D9, #0.18750000
    FMOV  H17, X13
    FMSUB  D13, D29, D28, D3
    FMOV  W7, H15
    FMADD  S11, S13, S11, S4
    FNMADD  S15, S5, S22, S20
    FNMSUB  D14, D23, D13, D10
    FMOV  W14, H29
    FMOV  X7, H21
    FNMSUB  H0, H8, H12, H22
    FMOV  S4, S18
    FNMSUB  H14, H22, H26, H23
    FMOV  S16, S14
    FNMSUB  D10, D15, D12, D6
    FMADD  D17, D6, D19, D6
    FMSUB  S28, S27, S30, S13
    FMOV  S0, S3
    FMOV  S8, #-19.00000000
    FMOV  H23, W10
    FMOV  X3, D9
    FMOV  H17, W17
    FMOV  S1, S11
    FMOV  S22, S4
    FNMADD  H8, H22, H6, H8
    FNMADD  H10, H3, H13, H16
    FNMADD  S31, S17, S6, S16
    FMSUB  S18, S0, S9, S1
    FMADD  S15, S17, S2, S28
    FMSUB  D0, D25, D30, D30
    FMOV  W24, H23
    FMOV  D25, D14
    FMOV  X8, D6
    FMSUB  D8, D30, D4, D11
    FNMADD  H14, H15, H23, H12
    FNMSUB  H4, H10, H0, H30
    FMADD  D12, D7, D4, D8
    FMOV  H28, W11
    FMADD  D28, D10, D14, D5
    FMADD  D13, D28, D31, D24
    FMOV  S12, #2.87500000
    FMOV  D20, D28
    FMOV  D4, D4
    FNMADD  S20, S24, S31, S6
    FMOV  S31, S1
    FMOV  W26, H6
    FNMSUB  H25, H12, H30, H22
    FNMSUB  H20, H2, H13, H29
    FNMSUB  H18, H21, H15, H15
    FMOV  H4, #-24.00000000
    FMOV  W6, S21
    FNMSUB  H22, H23, H30, H25
    FNMADD  H11, H20, H9, H31
    FMSUB  S31, S11, S9, S4
    FMOV  S18, S7
    FMOV  W29, S13
    FMOV  W9, H25
    FMOV  H29, W10
    FMOV  W25, S17
    FMSUB  H2, H29, H22, H6
    FMOV  W29, S29
    FMOV  S18, W13
    FNMADD  S0, S31, S18, S5
    FMSUB  S5, S2, S2, S26
    FMADD  S28, S17, S0, S9
    FMOV  W15, S12
    FMOV  H18, #-0.37500000
    FMOV  H1, W28
    FMADD  S30, S1, S26, S0
    FMOV  D23, #0.68750000
    FMOV  S1, #26.00000000
    FMOV  D17, #2.25000000
    FMADD  S15, S9, S22, S8
    FNMSUB  D24, D4, D5, D18
    FMADD  H9, H11, H22, H24
    FMSUB  S13, S11, S0, S29
    SUBS  X28, X28, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_1026
    MOVZ  X7, #0x3601, LSL #0
    SUB  X13, X7, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x3fc8, LSL #48
    SUB  X3, X25, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0xb601, LSL #0
    SUB  X11, X17, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0xb080, LSL #0
    SUB  X18, X27, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x3601, LSL #0
    SUB  X9, X18, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x21a2, LSL #0
    MOVK  X4, #0x54f6, LSL #16
    MOVK  X4, #0xb00f, LSL #32
    MOVK  X4, #0x1da8, LSL #48
    SUB  X5, X4, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x3217, LSL #0
    SUB  X25, X17, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x6359, LSL #0
    SUB  X29, X14, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4038, LSL #16
    SUB  X26, X5, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x3601, LSL #0
    SUB  X5, X16, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x50e0, LSL #0
    SUB  X11, X10, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x21a2, LSL #0
    MOVK  X11, #0x54f6, LSL #16
    MOVK  X11, #0xb00f, LSL #32
    MOVK  X11, #0x1da8, LSL #48
    SUB  X14, X11, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x43bc, LSL #0
    MOVK  X11, #0x9c8a, LSL #16
    MOVK  X11, #0xb21e, LSL #32
    MOVK  X11, #0xe82b, LSL #48
    SUB  X20, X11, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0xc440, LSL #0
    SUB  X27, X4, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D2
    MOVZ  X17, #0xd999, LSL #0
    SUB  X24, X17, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X5, #0x33f7, LSL #0
    MOVK  X5, #0xe8fc, LSL #16
    MOVK  X5, #0xf32, LSL #32
    MOVK  X5, #0x5ea9, LSL #48
    SUB  X9, X5, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D3
    MOVZ  X5, #0x87f1, LSL #0
    MOVK  X5, #0x1cf2, LSL #16
    MOVK  X5, #0x3065, LSL #32
    MOVK  X5, #0xcc56, LSL #48
    SUB  X9, X5, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D4
    MOVZ  X2, #0xce00, LSL #0
    SUB  X17, X2, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D5
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x4028, LSL #16
    SUB  X22, X12, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D6
    MOVZ  X15, #0x21a2, LSL #0
    MOVK  X15, #0x54f6, LSL #16
    MOVK  X15, #0xb00f, LSL #32
    MOVK  X15, #0x1da8, LSL #48
    SUB  X17, X15, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D7
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x41f8, LSL #16
    SUB  X26, X8, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D8
    MOVZ  X29, #0xb601, LSL #0
    SUB  X22, X29, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D9
    MOVZ  X27, #0x5d84, LSL #0
    SUB  X24, X27, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D10
    MOVZ  X11, #0x3217, LSL #0
    SUB  X18, X11, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D11
    MOVZ  X16, #0x3601, LSL #0
    SUB  X8, X16, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D12
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x4038, LSL #16
    SUB  X11, X7, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D13
    MOVZ  X7, #0x3218, LSL #0
    SUB  X8, X7, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D15
    MOVZ  X7, #0xb601, LSL #0
    SUB  X20, X7, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D16
    MOVZ  X13, #0xb217, LSL #0
    SUB  X5, X13, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D17
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x4002, LSL #48
    SUB  X19, X26, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D18
    MOVZ  X13, #0xb600, LSL #0
    SUB  X21, X13, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D19
    MOVZ  X14, #0x6358, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X7, X14, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D20
    MOVZ  X18, #0xfbff, LSL #0
    SUB  X5, X18, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D21
    MOVZ  X10, #0xb080, LSL #0
    SUB  X29, X10, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D22
    MOVZ  X25, #0x635b, LSL #0
    SUB  X14, X25, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D23
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x3fe6, LSL #48
    SUB  X17, X3, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D24
    MOVZ  X16, #0xb5ff, LSL #0
    MOVK  X16, #0x8000, LSL #48
    SUB  X2, X16, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D25
    MOVZ  X12, #0xe359, LSL #0
    SUB  X13, X12, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D26
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4028, LSL #16
    SUB  X16, X29, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D27
    MOVZ  X24, #0xcb50, LSL #0
    SUB  X12, X24, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X9, X22, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D28
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #16
    SUB  X9, X22, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D29
    MOVZ  X2, #0x3217, LSL #0
    SUB  X25, X2, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X13
    FMOV  V0.D[1], X18
    FMOV  D1, X21
    FMOV  V1.D[1], X14
    FMOV  D2, X19
    FMOV  V2.D[1], X15
    FMOV  D3, X25
    FMOV  V3.D[1], X4
    FMOV  D4, X11
    FMOV  V4.D[1], X20
    FMOV  D5, X25
    FMOV  V5.D[1], X13
    FMOV  D6, X29
    FMOV  V6.D[1], X24
    FMOV  D7, X12
    FMOV  V7.D[1], X21
    FMOV  D8, X17
    FMOV  V8.D[1], X22
    FMOV  D9, X29
    FMOV  V9.D[1], X26
    FMOV  D10, X5
    FMOV  V10.D[1], X2
    FMOV  D11, X24
    FMOV  V11.D[1], X2
    FMOV  D12, X25
    FMOV  V12.D[1], X18
    FMOV  D13, X24
    FMOV  V13.D[1], X13
    FMOV  D14, X8
    FMOV  V14.D[1], X4
    FMOV  D15, X6
    FMOV  V15.D[1], X24
    FMOV  D16, X10
    FMOV  V16.D[1], X26
    FMOV  D17, X24
    FMOV  V17.D[1], X3
    FMOV  D18, X26
    FMOV  V18.D[1], X10
    FMOV  D19, X16
    FMOV  V19.D[1], X6
    FMOV  D20, X21
    FMOV  V20.D[1], X29
    FMOV  D21, X20
    FMOV  V21.D[1], X16
    FMOV  D22, X6
    FMOV  V22.D[1], X13
    FMOV  D23, X12
    FMOV  V23.D[1], X3
    FMOV  D24, X29
    FMOV  V24.D[1], X17
    FMOV  D25, X20
    FMOV  V25.D[1], X9
    FMOV  D26, X10
    FMOV  V26.D[1], X21
    FMOV  D27, X5
    FMOV  V27.D[1], X16
    FMOV  D28, X12
    FMOV  V28.D[1], X19
    FMOV  D29, X27
    FMOV  V29.D[1], X23
    FMOV  D30, X23
    FMOV  V30.D[1], X15
    FMOV  D31, X18
    FMOV  V31.D[1], X25
    MOVZ  X17, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_1112:
    FMOV  H14, H6
    FMOV  H29, #7.25000000
    FMOV  W9, S15
    FMSUB  S3, S3, S1, S0
    FNMADD  D14, D16, D15, D8
    FMOV  D21, X19
    FMOV  D15, X6
    FMOV  X5, H5
    FMOV  S26, #-7.25000000
    FMADD  H21, H12, H27, H9
    FMOV  H20, #0.53125000
    FMOV  D10, X15
    FMOV  S24, W20
    FMOV  H24, W28
    FMSUB  D30, D2, D25, D13
    FNMADD  H13, H15, H14, H10
    FMOV  D20, D22
    FMOV  H14, X29
    FMOV  D28, X22
    FMOV  S6, #3.12500000
    FMSUB  S12, S26, S29, S5
    FMSUB  D16, D16, D4, D9
    FNMADD  S15, S2, S28, S2
    FNMADD  H22, H31, H5, H27
    FNMADD  D14, D16, D12, D4
    FMADD  S13, S4, S15, S13
    FMSUB  S15, S29, S15, S10
    FMOV  D13, D7
    FNMADD  S15, S0, S7, S16
    FMOV  H30, H6
    FMOV  X3, H26
    FMADD  D12, D22, D25, D15
    FMOV  S31, #-0.59375000
    FMOV  H18, #-3.00000000
    FMSUB  S1, S15, S18, S13
    FMOV  S1, S5
    FNMADD  D11, D14, D14, D1
    FMOV  X24, D3
    FMADD  S5, S15, S11, S16
    FNMADD  S10, S17, S29, S1
    FMADD  S4, S1, S13, S31
    FMOV  D4, D29
    FMOV  H20, W4
    FMOV  X29, H9
    FMSUB  D4, D7, D27, D7
    FMOV  S11, S27
    FMSUB  S9, S6, S16, S16
    FMOV  H26, W3
    FMOV  H30, X23
    FMSUB  D10, D7, D19, D1
    FMSUB  H19, H19, H5, H3
    FMOV  S5, S27
    FMOV  W28, H17
    FMOV  X18, H8
    FMOV  D25, D3
    FMOV  H0, H8
    FMOV  H17, H15
    FMOV  H25, W7
    FMOV  X22, H20
    FMOV  H17, #0.32812500
    FMOV  X11, H0
    FMADD  D0, D11, D10, D16
    FMOV  W13, S8
    FNMSUB  D25, D14, D0, D7
    FMOV  D24, D26
    FMADD  S25, S24, S29, S5
    FMOV  D5, D28
    FNMSUB  H23, H9, H28, H1
    FMOV  X25, D17
    FMADD  H4, H20, H30, H19
    FMOV  D4, #1.87500000
    FMOV  S10, W9
    FNMADD  S2, S10, S9, S25
    FMOV  H28, X2
    FMOV  W28, H8
    FMADD  H15, H28, H26, H3
    FMOV  S29, #0.42187500
    FMOV  X27, H8
    FNMADD  H25, H12, H26, H8
    FMSUB  H19, H29, H29, H14
    FMSUB  S19, S12, S8, S26
    FMOV  W24, S11
    FMOV  X28, H28
    FMOV  D12, D4
    FMOV  W27, H9
    FMOV  S23, #3.00000000
    FMADD  S16, S1, S26, S14
    FMADD  H10, H22, H27, H14
    FMOV  D20, #0.50000000
    FMOV  W27, H30
    FMADD  S30, S29, S2, S17
    FNMADD  D21, D14, D10, D3
    FMOV  H20, H18
    FMOV  X29, H13
    FNMSUB  H18, H24, H25, H7
    FNMSUB  S24, S17, S2, S20
    FNMSUB  H9, H17, H22, H16
    FNMSUB  S21, S15, S4, S7
    FMOV  H5, X2
    FNMADD  S31, S14, S22, S25
    FMOV  H17, W21
    FMADD  D8, D4, D6, D3
    FMSUB  S7, S17, S31, S11
    FNMADD  S8, S31, S14, S24
    FMOV  S5, W6
    FNMSUB  D30, D2, D0, D2
    FNMSUB  D30, D28, D15, D17
    FNMSUB  H5, H0, H2, H5
    FMOV  S5, #-1.06250000
    FNMSUB  S2, S4, S25, S13
    FMOV  H31, W29
    FMADD  D1, D20, D0, D4
    FMOV  S26, S26
    FMOV  H11, W9
    FMOV  X6, H11
    FMSUB  S6, S2, S7, S4
    FNMADD  S8, S20, S22, S13
    FMOV  S7, S5
    FNMSUB  D8, D18, D14, D13
    FMOV  D9, D8
    FMADD  S16, S16, S6, S14
    FNMADD  H26, H18, H8, H11
    FMOV  H9, W14
    FMOV  X3, D13
    FMOV  W2, H1
    FMOV  W2, H9
    FNMSUB  H12, H4, H26, H5
    FMOV  H23, #5.75000000
    FMOV  W8, H2
    FMOV  S26, S24
    FMOV  D30, D18
    FNMADD  S5, S24, S20, S11
    FMOV  H10, X12
    FMOV  D10, #0.90625000
    FMOV  W18, S12
    FNMADD  H7, H20, H15, H16
    FMADD  H6, H30, H10, H26
    FMOV  S13, W3
    FNMSUB  D2, D16, D20, D6
    FMOV  X3, H27
    FMOV  W14, S1
    FMOV  D4, D20
    FMOV  S1, W15
    FMOV  H15, W16
    FNMADD  S2, S22, S12, S8
    FMOV  H8, H29
    FMSUB  D12, D29, D23, D2
    FMOV  H13, W21
    FMADD  D9, D5, D1, D3
    FMADD  S14, S22, S22, S3
    FMADD  S8, S3, S20, S8
    FMOV  S15, W16
    FMOV  D7, X27
    FMOV  D3, X16
    FMOV  S12, W20
    FMSUB  S26, S12, S15, S27
    FMOV  S10, #5.75000000
    FMOV  W25, S8
    FNMADD  S29, S18, S23, S31
    FMOV  D14, D4
    FMOV  W6, H29
    FNMSUB  H21, H28, H2, H2
    FMOV  D23, D0
    FMOV  S22, S17
    FMOV  H22, X8
    FMADD  S9, S5, S30, S0
    FMOV  D3, D26
    FNMADD  H29, H13, H3, H5
    FMOV  X5, D23
    FMOV  D26, #1.56250000
    FNMSUB  H27, H26, H17, H12
    FMADD  H28, H3, H17, H10
    FMOV  H14, H5
    FMOV  H19, H15
    FMOV  S14, #-0.65625000
    FMADD  H23, H17, H2, H18
    FMOV  D21, X18
    FMADD  H11, H10, H5, H10
    FMOV  H18, X5
    FMOV  H29, H14
    FMADD  H27, H7, H2, H26
    FMOV  X11, D8
    FMOV  D17, X16
    FMOV  W6, S11
    FNMSUB  H18, H10, H1, H13
    FNMSUB  H19, H3, H0, H2
    FNMSUB  S3, S7, S0, S16
    FNMADD  S8, S9, S18, S11
    FMADD  H7, H28, H8, H28
    FMSUB  S0, S16, S21, S24
    FMOV  X4, H30
    FMOV  X6, H14
    FMSUB  D19, D21, D26, D10
    FMOV  H2, X6
    FMOV  W11, H8
    FNMSUB  S3, S23, S31, S5
    FMOV  W4, H11
    FMOV  H12, X7
    FMOV  D0, D6
    FMOV  X9, H15
    SUBS  X17, X17, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_1112
    MOVZ  X13, #0x1, LSL #0
    SUB  X3, X13, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x9, LSL #0
    SUB  X14, X12, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
TaishanFpMiniMaxiP01_label_1109:
    SUB  X10, X14, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x1, LSL #0
    SUB  X12, X23, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D3
    MOVZ  X21, #0x1, LSL #0
    MOVK  X21, #0x8000, LSL #16
    SUB  X11, X21, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D4
    MOVZ  X10, #0xc200, LSL #0
    SUB  X2, X10, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D5
    MOVZ  X6, #0x1, LSL #0
    SUB  X27, X6, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D6
    MOVZ  X24, #0xc200, LSL #0
    SUB  X11, X24, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D7
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D8
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    SUB  X29, X3, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D9
    MOVZ  X13, #0xa, LSL #0
    SUB  X8, X13, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D10
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x40b8, LSL #16
    SUB  X3, X23, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D13
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D14
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xbf28, LSL #16
    SUB  X9, X4, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D15
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D16
    MOVZ  X4, #0xc200, LSL #0
    SUB  X2, X4, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D19
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x40b8, LSL #16
    SUB  X4, X15, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D20
    MOVZ  X21, #0xc200, LSL #0
    SUB  X9, X21, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D22
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D24
    MOVZ  X21, #0xc200, LSL #0
    MOVK  X21, #0x8000, LSL #16
    SUB  X12, X21, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D25
    MOVZ  X14, #0x8000, LSL #0
    SUB  X8, X14, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D26
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3ff9, LSL #48
    SUB  X15, X14, X5
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D29
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X18
    FMOV  D1, X13
    FMOV  V1.D[1], X17
    FMOV  D2, X27
    FMOV  V2.D[1], X24
    FMOV  D3, X23
    FMOV  V3.D[1], X4
    FMOV  D4, X28
    FMOV  V4.D[1], X8
    FMOV  D5, X29
    FMOV  V5.D[1], X2
    FMOV  D6, X22
    FMOV  V6.D[1], X25
    FMOV  D7, X2
    FMOV  V7.D[1], X22
    FMOV  D8, X13
    FMOV  V8.D[1], X13
    FMOV  D9, X12
    FMOV  V9.D[1], X9
    FMOV  D10, X6
    FMOV  V10.D[1], X8
    FMOV  D11, X22
    FMOV  V11.D[1], X13
    FMOV  D12, X14
    FMOV  V12.D[1], X20
    FMOV  D13, X25
    FMOV  V13.D[1], X29
    FMOV  D14, X19
    FMOV  V14.D[1], X25
    FMOV  D15, X22
    FMOV  V15.D[1], X23
    FMOV  D16, X2
    FMOV  V16.D[1], X26
    FMOV  D17, X26
    FMOV  V17.D[1], X14
    FMOV  D18, X13
    FMOV  V18.D[1], X28
    FMOV  D19, X15
    FMOV  V19.D[1], X14
    FMOV  D20, X17
    FMOV  V20.D[1], X22
    FMOV  D21, X12
    FMOV  V21.D[1], X17
    FMOV  D22, X20
    FMOV  V22.D[1], X25
    FMOV  D23, X22
    FMOV  V23.D[1], X3
    FMOV  D24, X6
    FMOV  V24.D[1], X19
    FMOV  D25, X10
    FMOV  V25.D[1], X15
    FMOV  D26, X18
    FMOV  V26.D[1], X29
    FMOV  D27, X20
    FMOV  V27.D[1], X9
    FMOV  D28, X18
    FMOV  V28.D[1], X8
    FMOV  D29, X6
    FMOV  V29.D[1], X21
    FMOV  D30, X8
    FMOV  V30.D[1], X7
    FMOV  D31, X10
    FMOV  V31.D[1], X20
    MOVZ  X9, #0xf, LSL #0
TaishanFpMiniMaxiP01_label_1197:
    FMOV  S13, S17
    FNMSUB  S2, S5, S1, S4
    FMADD  S22, S30, S29, S27
    FMOV  W7, S31
    FMADD  D2, D22, D24, D28
    FMSUB  H17, H12, H0, H8
    FMOV  D26, #-0.50000000
    FNMSUB  S17, S13, S21, S26
    FMOV  X21, H6
    FMOV  H9, W18
    FMOV  S6, W18
    FMADD  D7, D6, D6, D26
    FMOV  S23, W9
    FNMADD  S13, S5, S2, S25
    FNMADD  S12, S30, S3, S23
    FMSUB  H9, H14, H2, H12
    FNMADD  S9, S4, S13, S2
    FMOV  D14, #5.25000000
    FMADD  H15, H20, H27, H19
    FNMSUB  H5, H16, H17, H25
    FNMADD  H20, H0, H11, H21
    FNMSUB  D30, D11, D13, D9
    FNMSUB  H22, H6, H30, H31
    FMSUB  H12, H21, H26, H20
    FNMADD  S14, S19, S21, S2
    FMOV  W14, H28
    FMSUB  S16, S15, S4, S17
    FMOV  X13, H27
    FMOV  S6, S11
    FMOV  W15, S26
    FMOV  D6, #-11.00000000
    FNMSUB  H13, H20, H2, H16
    FNMADD  D27, D6, D0, D13
    FMOV  X25, D6
    FMADD  H7, H3, H7, H7
    FMOV  H27, H14
    FMADD  S26, S4, S14, S12
    FMOV  D27, #-3.62500000
    FMADD  S15, S31, S28, S0
    FMOV  X5, H24
    FMOV  X6, H27
    FNMSUB  H30, H30, H15, H23
    FNMADD  S21, S8, S22, S23
    FMSUB  S21, S27, S15, S16
    FNMSUB  S20, S19, S6, S4
    FMADD  S30, S0, S7, S1
    FMOV  H21, H15
    FNMADD  D7, D21, D26, D14
    FMSUB  S20, S24, S1, S16
    FMADD  S30, S16, S11, S26
    FMOV  D29, D7
    FMOV  S7, #12.00000000
    FMSUB  D16, D28, D20, D18
    FMOV  S26, S16
    FNMADD  D5, D3, D12, D19
    FMOV  S1, W16
    FMOV  S9, S30
    FMADD  S0, S7, S6, S11
    FMOV  H8, W21
    FMOV  D0, #0.20312500
    FNMSUB  D27, D13, D5, D31
    FMOV  S22, W12
    FMOV  X25, H24
    FMSUB  H29, H2, H6, H4
    FMOV  S28, #29.00000000
    FMOV  D16, D13
    FMOV  H4, W7
    FMOV  S1, #-12.00000000
    FMOV  D1, X8
    FNMADD  S0, S6, S24, S3
    FMOV  W11, H3
    FMOV  D28, #2.25000000
    FMOV  D21, #-0.25000000
    FMOV  S15, S17
    FMOV  H19, H19
    FMOV  H13, H13
    FMSUB  S30, S14, S18, S29
    FMOV  D11, #10.50000000
    FMOV  D3, D24
    FMSUB  H12, H5, H4, H16
    FMOV  H18, W7
    FMSUB  D21, D0, D29, D19
    FMOV  W17, S22
    FMOV  S20, #-0.48437500
    FMOV  D30, D31
    FNMADD  S22, S17, S12, S31
    FMOV  S5, W12
    FMOV  D16, X15
    FNMSUB  D22, D11, D3, D12
    FMOV  H1, W29
    FMOV  W18, H27
    FMSUB  H2, H18, H2, H11
    FMOV  D26, X9
    FMOV  X19, D20
    FNMSUB  S2, S6, S16, S26
    FNMSUB  D2, D11, D16, D12
    FNMADD  S1, S3, S8, S7
    FNMSUB  S22, S19, S26, S1
    FNMSUB  H4, H21, H2, H0
    FMOV  X2, D22
    FNMADD  D5, D19, D4, D30
    FMOV  S29, #-13.00000000
    FMOV  S5, W4
    FNMSUB  D22, D31, D24, D1
    FMOV  D8, D20
    FMSUB  D29, D23, D31, D18
    FMOV  S0, W17
    FMOV  S25, W18
    FMOV  H5, X9
    FMOV  X15, H15
    FMSUB  S20, S14, S22, S22
    FMOV  D0, X8
    FMADD  D8, D27, D17, D1
    FNMADD  D6, D15, D1, D30
    FMOV  W24, H31
    FNMADD  H29, H22, H13, H26
    FNMSUB  D17, D27, D24, D0
    FMOV  X2, H17
    FMOV  H5, #31.00000000
    FMOV  D28, X17
    FMOV  D30, #1.62500000
    FMSUB  D4, D24, D17, D23
    FNMSUB  D6, D16, D6, D17
    FMOV  S1, #0.20312500
    FMSUB  S8, S15, S5, S8
    FNMSUB  H6, H3, H6, H26
    FMSUB  H22, H14, H25, H25
    FMOV  D25, X14
    FMOV  H29, X27
    FMOV  X24, D29
    FMSUB  D23, D13, D31, D28
    FMOV  W10, H27
    FMOV  H8, X4
    FMSUB  H0, H6, H15, H26
    FMADD  D16, D20, D8, D29
    FMSUB  D27, D25, D18, D6
    FMSUB  D1, D18, D20, D29
    FMOV  D11, #-11.50000000
    FMOV  S11, S22
    FMSUB  S16, S11, S2, S12
    FMSUB  S20, S17, S26, S10
    FMADD  S9, S17, S4, S3
    FMSUB  D20, D3, D19, D17
    FMADD  D26, D5, D8, D2
    FMOV  H16, W15
    FMOV  D0, #-2.50000000
    FMOV  D30, X7
    FNMADD  D29, D28, D20, D7
    FMOV  H27, H1
    FMOV  D23, #-3.62500000
    FMOV  X3, H16
    FMOV  D4, X26
    FMOV  W8, H29
    FMADD  H9, H23, H16, H18
    FMOV  W10, H27
    FMADD  S17, S24, S4, S27
    FMOV  X20, D2
    FMOV  S13, #28.00000000
    FMOV  H26, W29
    FMOV  X13, D26
    FMADD  H3, H27, H20, H5
    FMOV  S25, S24
    FNMADD  H13, H25, H11, H5
    FNMADD  D12, D9, D19, D16
    FMOV  W12, S13
    FMOV  H22, H18
    FMOV  W28, S30
    FMOV  D22, #23.00000000
    FNMADD  S10, S26, S22, S2
    FMOV  D24, X24
    FNMSUB  S17, S25, S3, S29
    FMOV  D17, D27
    FMOV  X3, H14
    FMOV  X19, D27
    FMOV  W8, H28
    FMOV  D10, #1.06250000
    FMOV  W14, S24
    FMOV  X5, H15
    FMOV  W15, S19
    FMOV  D18, #0.56250000
    FNMADD  S5, S6, S1, S22
    FMOV  H17, H23
    FMOV  D24, X17
    FMOV  W26, H3
    FMOV  D17, #-0.18750000
    FNMSUB  S14, S30, S3, S21
    FMSUB  D25, D18, D10, D29
    FNMSUB  H27, H1, H3, H21
    FNMADD  S31, S13, S6, S3
    FMOV  S17, #5.00000000
    FMOV  S0, S13
    FMOV  S25, W29
    FNMADD  H27, H15, H30, H10
    FMOV  X26, H10
    FNMSUB  S24, S4, S28, S26
    FMOV  W5, H21
    FMOV  D16, D5
    FNMADD  H20, H2, H19, H23
    FMOV  X26, D19
    FMOV  X8, D15
    SUBS  X9, X9, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_1197
    MOVZ  X14, #0xfffb, LSL #0
    SUB  X23, X14, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x7fff, LSL #0
    SUB  X13, X15, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X10, X3, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    SUB  X5, X24, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X22, X16, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0xfffb, LSL #0
    MOVK  X9, #0x4, LSL #16
    SUB  X12, X9, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0xfffb, LSL #0
    MOVK  X28, #0x4, LSL #16
    SUB  X18, X28, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    SUB  X3, X23, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0xfffb, LSL #0
    SUB  X13, X6, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x7fff, LSL #0
    SUB  X11, X13, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x8000, LSL #16
    SUB  X23, X10, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x7ffe, LSL #0
    SUB  X15, X23, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0xfffe, LSL #0
    SUB  X28, X22, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0xfffe, LSL #0
    SUB  X5, X12, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x7ffe, LSL #0
    SUB  X22, X17, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    SUB  X4, X5, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0xfffe, LSL #0
    SUB  X18, X13, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    SUB  X3, X8, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X12, X7, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X11, X15, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D2
    MOVZ  X6, #0x7ffb, LSL #0
    MOVK  X6, #0x8000, LSL #48
    SUB  X10, X6, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D3
    MOVZ  X13, #0xffff, LSL #0
    SUB  X26, X13, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D4
    MOVZ  X2, #0xffff, LSL #0
    SUB  X16, X2, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D5
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x8000, LSL #16
    SUB  X24, X26, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D6
    MOVZ  X7, #0xfffe, LSL #0
    SUB  X12, X7, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D7
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x4140, LSL #16
    SUB  X22, X19, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D8
    MOVZ  X18, #0xffff, LSL #0
    SUB  X16, X18, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D9
    MOVZ  X12, #0xffff, LSL #0
    SUB  X13, X12, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D10
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3ff1, LSL #48
    SUB  X4, X6, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D11
    MOVZ  X12, #0xffff, LSL #0
    SUB  X21, X12, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D12
    MOVZ  X13, #0xfffb, LSL #0
    MOVK  X13, #0x8000, LSL #48
    SUB  X15, X13, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D13
    MOVZ  X15, #0x7ffe, LSL #0
    SUB  X11, X15, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D14
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0x8000, LSL #16
    SUB  X22, X3, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D15
    MOVZ  X5, #0xfffb, LSL #0
    MOVK  X5, #0x4, LSL #16
    SUB  X8, X5, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D16
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    SUB  X2, X11, X15
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D17
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x40a0, LSL #16
    SUB  X20, X12, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D18
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x3fe2, LSL #48
    SUB  X29, X21, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D19
    MOVZ  X26, #0xffff, LSL #0
    SUB  X29, X26, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D20
    MOVZ  X3, #0xfffb, LSL #0
    SUB  X26, X3, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D21
    MOVZ  X9, #0xffff, LSL #0
    SUB  X28, X9, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D22
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x4037, LSL #48
    SUB  X5, X18, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D23
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc00d, LSL #48
    SUB  X7, X24, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D24
    MOVZ  X11, #0xfffe, LSL #0
    MOVK  X11, #0x8000, LSL #16
    SUB  X28, X11, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D25
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X21, X4, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D26
    MOVZ  X22, #0xffff, LSL #0
    SUB  X16, X22, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D27
    MOVZ  X23, #0x7ffb, LSL #0
    SUB  X22, X23, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D28
    MOVZ  X19, #0x7ffe, LSL #0
    SUB  X25, X19, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D29
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0x413f, LSL #16
    MOVK  X27, #0x8000, LSL #48
    SUB  X2, X27, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0xa212, LSL #0
    MOVK  X2, #0xb46b, LSL #16
    MOVK  X2, #0x7d1, LSL #32
    MOVK  X2, #0x515d, LSL #48
    MOVZ  X3, #0x585d, LSL #0
    MOVK  X3, #0x1b2a, LSL #16
    MOVK  X3, #0x6087, LSL #32
    MOVK  X3, #0x3750, LSL #48
    MOVZ  X4, #0x6665, LSL #0
    MOVK  X4, #0xcabc, LSL #16
    MOVK  X4, #0x7c9f, LSL #32
    MOVK  X4, #0x9ec7, LSL #48
    MOVZ  X5, #0x812a, LSL #0
    MOVK  X5, #0x2dba, LSL #16
    MOVK  X5, #0x6122, LSL #32
    MOVK  X5, #0x3f81, LSL #48
    MOVZ  X6, #0xecda, LSL #0
    MOVK  X6, #0x4253, LSL #16
    MOVK  X6, #0xd316, LSL #32
    MOVK  X6, #0x816b, LSL #48
    MOVZ  X7, #0xa98c, LSL #0
    MOVK  X7, #0xea5f, LSL #16
    MOVK  X7, #0xf107, LSL #32
    MOVK  X7, #0x981, LSL #48
    MOVZ  X8, #0x1e58, LSL #0
    MOVK  X8, #0x17f6, LSL #16
    MOVK  X8, #0xfb23, LSL #32
    MOVK  X8, #0x19bc, LSL #48
    MOVZ  X9, #0x8b4, LSL #0
    MOVK  X9, #0x4bd3, LSL #16
    MOVK  X9, #0x7605, LSL #32
    MOVK  X9, #0xd9f6, LSL #48
    MOVZ  X10, #0x4920, LSL #0
    MOVK  X10, #0x3d5c, LSL #16
    MOVK  X10, #0x2e76, LSL #32
    MOVK  X10, #0xb0a, LSL #48
    MOVZ  X11, #0x251a, LSL #0
    MOVK  X11, #0x1508, LSL #16
    MOVK  X11, #0xf448, LSL #32
    MOVK  X11, #0x5033, LSL #48
    MOVZ  X12, #0xdfbe, LSL #0
    MOVK  X12, #0x578f, LSL #16
    MOVK  X12, #0x8fcd, LSL #32
    MOVK  X12, #0x800c, LSL #48
    MOVZ  X13, #0x633d, LSL #0
    MOVK  X13, #0xed88, LSL #16
    MOVK  X13, #0xe7, LSL #32
    MOVK  X13, #0x7481, LSL #48
    MOVZ  X14, #0x997e, LSL #0
    MOVK  X14, #0xf40c, LSL #16
    MOVK  X14, #0x29c7, LSL #32
    MOVK  X14, #0xbd87, LSL #48
    MOVZ  X15, #0x3470, LSL #0
    MOVK  X15, #0x47e5, LSL #16
    MOVK  X15, #0x7557, LSL #32
    MOVK  X15, #0x5535, LSL #48
    MOVZ  X16, #0x183d, LSL #0
    MOVK  X16, #0x6010, LSL #16
    MOVK  X16, #0x7902, LSL #32
    MOVK  X16, #0x16b8, LSL #48
    MOVZ  X17, #0x484a, LSL #0
    MOVK  X17, #0x558, LSL #16
    MOVK  X17, #0xbe59, LSL #32
    MOVK  X17, #0x6f7c, LSL #48
    MOVZ  X18, #0x904, LSL #0
    MOVK  X18, #0xf4d3, LSL #16
    MOVK  X18, #0x682c, LSL #32
    MOVK  X18, #0x27ce, LSL #48
    MOVZ  X19, #0x3922, LSL #0
    MOVK  X19, #0x700b, LSL #16
    MOVK  X19, #0x7a04, LSL #32
    MOVK  X19, #0x4dce, LSL #48
    MOVZ  X20, #0x35b7, LSL #0
    MOVK  X20, #0xad8b, LSL #16
    MOVK  X20, #0xb7e1, LSL #32
    MOVK  X20, #0x38f3, LSL #48
    MOVZ  X21, #0xa9ad, LSL #0
    MOVK  X21, #0x6971, LSL #16
    MOVK  X21, #0x5200, LSL #32
    MOVK  X21, #0x91cb, LSL #48
    MOVZ  X22, #0x682d, LSL #0
    MOVK  X22, #0xb2dc, LSL #16
    MOVK  X22, #0x4bf5, LSL #32
    MOVK  X22, #0x1385, LSL #48
    MOVZ  X23, #0xd82f, LSL #0
    MOVK  X23, #0xa3ff, LSL #16
    MOVK  X23, #0x3c1a, LSL #32
    MOVK  X23, #0x75e0, LSL #48
    MOVZ  X24, #0xcf7c, LSL #0
    MOVK  X24, #0x43a9, LSL #16
    MOVK  X24, #0x1576, LSL #32
    MOVK  X24, #0xee13, LSL #48
    MOVZ  X25, #0x371, LSL #0
    MOVK  X25, #0x2428, LSL #16
    MOVK  X25, #0x8765, LSL #32
    MOVK  X25, #0xd9a8, LSL #48
    MOVZ  X26, #0x6ddd, LSL #0
    MOVK  X26, #0xf886, LSL #16
    MOVK  X26, #0xd80a, LSL #32
    MOVK  X26, #0xd357, LSL #48
    MOVZ  X27, #0x5a57, LSL #0
    MOVK  X27, #0xd3d9, LSL #16
    MOVK  X27, #0xd7fa, LSL #32
    MOVK  X27, #0x5624, LSL #48
    MOVZ  X28, #0x9159, LSL #0
    MOVK  X28, #0x11e6, LSL #16
    MOVK  X28, #0x30d8, LSL #32
    MOVK  X28, #0x9213, LSL #48
    MOVZ  X29, #0x947a, LSL #0
    MOVK  X29, #0x8f0b, LSL #16
    MOVK  X29, #0xa153, LSL #32
    MOVK  X29, #0xa8d7, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X4
    FMOV  D1, X22
    FMOV  V1.D[1], X17
    FMOV  D2, X23
    FMOV  V2.D[1], X23
    FMOV  D3, X14
    FMOV  V3.D[1], X27
    FMOV  D4, X19
    FMOV  V4.D[1], X24
    FMOV  D5, X29
    FMOV  V5.D[1], X7
    FMOV  D6, X26
    FMOV  V6.D[1], X18
    FMOV  D7, X4
    FMOV  V7.D[1], X4
    FMOV  D8, X12
    FMOV  V8.D[1], X22
    FMOV  D9, X9
    FMOV  V9.D[1], X12
    FMOV  D10, X23
    FMOV  V10.D[1], X21
    FMOV  D11, X15
    FMOV  V11.D[1], X4
    FMOV  D12, X22
    FMOV  V12.D[1], X3
    FMOV  D13, X7
    FMOV  V13.D[1], X14
    FMOV  D14, X12
    FMOV  V14.D[1], X29
    FMOV  D15, X18
    FMOV  V15.D[1], X7
    FMOV  D16, X13
    FMOV  V16.D[1], X13
    FMOV  D17, X19
    FMOV  V17.D[1], X24
    FMOV  D18, X22
    FMOV  V18.D[1], X27
    FMOV  D19, X10
    FMOV  V19.D[1], X8
    FMOV  D20, X4
    FMOV  V20.D[1], X9
    FMOV  D21, X14
    FMOV  V21.D[1], X8
    FMOV  D22, X7
    FMOV  V22.D[1], X6
    FMOV  D23, X18
    FMOV  V23.D[1], X27
    FMOV  D24, X19
    FMOV  V24.D[1], X23
    FMOV  D25, X23
    FMOV  V25.D[1], X17
    FMOV  D26, X25
    FMOV  V26.D[1], X25
    FMOV  D27, X12
    FMOV  V27.D[1], X12
    FMOV  D28, X5
    FMOV  V28.D[1], X24
    FMOV  D29, X14
    FMOV  V29.D[1], X24
    FMOV  D30, X23
    FMOV  V30.D[1], X6
    FMOV  D31, X24
    FMOV  V31.D[1], X6
    MOVZ  X26, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_1283:
    FMOV  W29, H23
    FMOV  H12, X12
    FMOV  D17, D4
    FMOV  H22, W5
    FMSUB  D27, D16, D16, D20
    FMOV  H8, X19
    FNMSUB  D24, D0, D1, D22
    FNMSUB  S10, S24, S12, S30
    FMOV  H19, W12
    FMOV  D15, D12
    FNMSUB  H9, H7, H5, H6
    FMOV  H2, X13
    FMOV  W24, S5
    FNMADD  H29, H31, H30, H1
    FNMSUB  D15, D17, D16, D12
    FMSUB  D10, D7, D16, D10
    FMSUB  D3, D19, D31, D30
    FMOV  S19, #-14.00000000
    FNMADD  D22, D16, D15, D27
    FMSUB  S20, S30, S13, S6
    FMOV  H9, W2
    FMOV  S18, #0.29687500
    FMSUB  D11, D14, D13, D0
    FMOV  D3, #-0.22656250
    FMOV  H17, X22
    FMOV  H5, X5
    FMOV  X15, D24
    FMOV  S22, W6
    FMOV  S5, S6
    FNMSUB  D1, D27, D5, D5
    FMOV  S25, S2
    FMOV  W3, H31
    FNMSUB  H15, H25, H15, H17
    FMOV  S13, S7
    FNMSUB  H1, H22, H15, H1
    FNMSUB  S22, S28, S28, S9
    FNMADD  H2, H22, H31, H13
    FMADD  D19, D18, D14, D7
    FMADD  S1, S11, S7, S28
    FMOV  X11, D3
    FMOV  D9, D19
    FMOV  X17, D3
    FMOV  W22, H29
    FNMADD  S28, S29, S16, S25
    FMSUB  S26, S1, S16, S15
    FMOV  H1, #-25.00000000
    FMOV  H12, W23
    FMADD  H29, H5, H29, H18
    FMSUB  H22, H20, H6, H29
    FMOV  W6, H31
    FNMADD  S24, S12, S28, S20
    FMOV  X4, D18
    FMSUB  H2, H26, H29, H28
    FMOV  H27, H9
    FMADD  S24, S26, S24, S11
    FNMADD  H19, H19, H3, H19
    FMOV  D13, X8
    FMOV  D18, D0
    FMOV  S9, #-0.81250000
    FNMADD  H21, H31, H27, H22
    FMOV  H15, X21
    FMADD  H25, H12, H15, H25
    FMOV  H11, W4
    FMSUB  S26, S3, S15, S14
    FMSUB  S21, S0, S14, S26
    FMOV  D15, D5
    FMOV  S26, #0.23437500
    FMOV  H1, X15
    FMOV  D19, X8
    FMOV  W2, H10
    FNMSUB  S24, S5, S8, S16
    FMSUB  D23, D22, D5, D15
    FMOV  S7, W6
    FMOV  D7, X5
    FMOV  W8, S14
    FMOV  S22, W25
    FMSUB  H2, H6, H14, H7
    FMOV  X3, H0
    FMOV  X9, D27
    FNMSUB  S14, S3, S28, S3
    FMSUB  D8, D6, D0, D9
    FMOV  H28, W13
    FMSUB  H27, H22, H2, H15
    FMOV  X22, D27
    FNMSUB  H31, H5, H16, H28
    FNMADD  S22, S24, S3, S7
    FMOV  D9, X12
    FMADD  H5, H10, H20, H25
    FMSUB  D4, D3, D10, D0
    FMADD  S21, S14, S27, S21
    FMOV  D15, #-11.00000000
    FMOV  H28, #-3.00000000
    FMADD  H4, H20, H29, H20
    FMOV  W8, S3
    FMOV  X14, H15
    FNMADD  D8, D20, D31, D16
    FMOV  H6, #6.25000000
    FMSUB  H6, H9, H29, H9
    FMOV  H0, #3.25000000
    FNMADD  H27, H4, H19, H6
    FMOV  X4, D21
    FMOV  H1, X24
    FMADD  D22, D10, D13, D3
    FMOV  X7, D7
    FMOV  D29, #12.00000000
    FMADD  H29, H8, H7, H25
    FMOV  S20, S12
    FMADD  S2, S14, S27, S10
    FMOV  W10, H18
    FNMADD  S28, S27, S22, S19
    FNMSUB  S1, S7, S14, S3
    FMOV  D1, #-0.14843750
    FNMSUB  S8, S28, S17, S28
    FMOV  H11, #3.00000000
    FMOV  X18, D24
    FMSUB  S23, S6, S2, S13
    FMSUB  S11, S12, S21, S16
    FMOV  X21, D31
    FMOV  W24, S2
    FNMSUB  H11, H19, H20, H6
    FMSUB  D30, D3, D25, D0
    FMOV  H0, X29
    FNMSUB  S29, S1, S18, S12
    FMOV  H30, H29
    FMOV  D28, #0.17187500
    FMOV  H29, #2.00000000
    FMOV  S23, S21
    FMOV  X25, D6
    FMADD  S10, S11, S19, S16
    FMSUB  S26, S16, S22, S8
    FMOV  D24, #-6.75000000
    FNMADD  S7, S4, S1, S20
    FMOV  H6, H16
    FMOV  D22, D16
    FMSUB  D2, D28, D0, D11
    FMSUB  D30, D24, D23, D31
    FMOV  S20, #-27.00000000
    FMOV  X22, D26
    FMOV  H15, H18
    FNMSUB  D28, D30, D0, D12
    FMOV  H17, H14
    FNMADD  D11, D18, D10, D14
    FMSUB  H15, H27, H15, H28
    FNMSUB  S10, S28, S27, S23
    FMOV  D7, X21
    FMADD  S19, S9, S2, S23
    FMSUB  D30, D0, D11, D2
    FMOV  D8, #-0.96875000
    FMOV  S31, #-25.00000000
    FNMSUB  H8, H20, H17, H31
    FMSUB  S27, S5, S25, S3
    FMOV  W15, S21
    FMOV  D10, #24.00000000
    FMOV  S3, S8
    FMSUB  D16, D27, D28, D19
    FMOV  S7, W14
    FMOV  S6, W26
    FMSUB  D7, D13, D7, D22
    FMOV  W28, S22
    FNMADD  S7, S1, S27, S7
    FMADD  S1, S10, S21, S0
    FMADD  H3, H28, H17, H16
    FNMADD  H11, H15, H30, H21
    FMOV  D12, D12
    FMOV  H1, W23
    FMOV  S12, W7
    FMOV  X10, H11
    FMOV  S4, S6
    FMADD  H24, H18, H29, H8
    FNMSUB  S22, S30, S14, S18
    FMOV  H22, H5
    FMOV  D7, D6
    FMOV  W5, S27
    FMADD  H8, H13, H10, H2
    FMOV  S9, S3
    FMADD  S4, S6, S25, S9
    FNMADD  S24, S22, S15, S23
    FMOV  H23, H9
    FMADD  S20, S19, S10, S16
    FMOV  W9, S9
    FMOV  X27, D30
    FMSUB  D19, D2, D7, D25
    FMOV  S26, #-0.43750000
    FMOV  S26, W29
    FNMADD  D3, D1, D26, D11
    FNMSUB  H10, H10, H6, H9
    FNMSUB  D27, D11, D7, D24
    FMADD  D13, D31, D3, D18
    FMOV  D10, #0.68750000
    FMOV  H16, W13
    FMOV  S31, W12
    FMOV  S3, S30
    FMOV  D27, X20
    FNMSUB  D10, D26, D27, D20
    FNMADD  S25, S8, S2, S11
    FMOV  D14, #-1.56250000
    FMOV  S19, S23
    FMOV  D12, X27
    FMOV  S27, S14
    FMOV  W24, H3
    SUBS  X26, X26, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_1283
    MOVZ  X17, #0x47b7, LSL #0
    SUB  X10, X17, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x8bcd, LSL #0
    SUB  X21, X25, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X23, X13, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0xdfbe, LSL #0
    SUB  X15, X4, X6
TaishanFpMiniMaxiP01_label_901:
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    SUB  X10, X25, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0xc091, LSL #0
    SUB  X23, X26, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xbfcd, LSL #48
    SUB  X3, X28, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0xdfbe, LSL #0
    MOVK  X10, #0x578f, LSL #16
    MOVK  X10, #0x8fcd, LSL #32
    MOVK  X10, #0x800c, LSL #48
    SUB  X28, X10, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    SUB  X16, X13, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X27, X13, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x47b7, LSL #0
    SUB  X4, X17, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x633c, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X23, X16, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x3922, LSL #0
    MOVK  X10, #0x700b, LSL #16
    MOVK  X10, #0x7a04, LSL #32
    MOVK  X10, #0x4dce, LSL #48
    SUB  X12, X10, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x35b7, LSL #0
    MOVK  X10, #0xad8b, LSL #16
    MOVK  X10, #0xb7e1, LSL #32
    MOVK  X10, #0x38f3, LSL #48
    SUB  X11, X10, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X27
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x379c, LSL #0
    SUB  X23, X21, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D2
    MOVZ  X3, #0x5630, LSL #0
    SUB  X16, X3, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D3
    MOVZ  X16, #0x5631, LSL #0
    SUB  X18, X16, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D4
    MOVZ  X27, #0xc092, LSL #0
    SUB  X10, X27, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D5
    MOVZ  X18, #0x7c00, LSL #0
    SUB  X13, X18, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D6
    MOVZ  X15, #0x1, LSL #0
    SUB  X10, X15, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D7
    MOVZ  X2, #0x1, LSL #0
    SUB  X12, X2, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D8
    MOVZ  X24, #0x5630, LSL #0
    SUB  X19, X24, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D9
    MOVZ  X7, #0xc091, LSL #0
    SUB  X15, X7, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D10
    MOVZ  X6, #0xc090, LSL #0
    MOVK  X6, #0x1441, LSL #16
    MOVK  X6, #0x8000, LSL #48
    SUB  X2, X6, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D11
    MOVZ  X14, #0x7277, LSL #0
    SUB  X23, X14, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D12
    MOVZ  X15, #0x5631, LSL #0
    SUB  X11, X15, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D13
    MOVZ  X2, #0x8bcd, LSL #0
    SUB  X26, X2, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D14
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xbff9, LSL #48
    SUB  X25, X27, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D15
    MOVZ  X24, #0xd82d, LSL #0
    SUB  X19, X24, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D16
    MOVZ  X20, #0x633d, LSL #0
    SUB  X18, X20, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D18
    MOVZ  X24, #0x8bcd, LSL #0
    SUB  X3, X24, X25
TaishanFpMiniMaxiP01_label_730:
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D19
    MOVZ  X23, #0xc091, LSL #0
    SUB  X14, X23, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D20
    MOVZ  X27, #0xc091, LSL #0
    MOVK  X27, #0x1441, LSL #16
    SUB  X3, X27, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D22
    MOVZ  X15, #0x7c00, LSL #0
    SUB  X27, X15, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D23
    MOVZ  X12, #0xc091, LSL #0
    SUB  X27, X12, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D24
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X20, X28, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D25
    MOVZ  X6, #0x7277, LSL #0
    MOVK  X6, #0x8000, LSL #16
    SUB  X29, X6, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D26
    MOVZ  X2, #0x379c, LSL #0
    SUB  X18, X2, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D28
    MOVZ  X8, #0xd82e, LSL #0
    MOVK  X8, #0x8000, LSL #48
    SUB  X20, X8, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D29
    MOVZ  X24, #0x4000, LSL #0
    SUB  X7, X24, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X14
    FMOV  V0.D[1], X12
    FMOV  D1, X13
    FMOV  V1.D[1], X6
    FMOV  D2, X22
    FMOV  V2.D[1], X12
    FMOV  D3, X23
    FMOV  V3.D[1], X27
    FMOV  D4, X18
    FMOV  V4.D[1], X11
    FMOV  D5, X9
    FMOV  V5.D[1], X21
    FMOV  D6, X24
    FMOV  V6.D[1], X19
    FMOV  D7, X18
    FMOV  V7.D[1], X17
    FMOV  D8, X29
    FMOV  V8.D[1], X28
    FMOV  D9, X22
    FMOV  V9.D[1], X7
    FMOV  D10, X20
    FMOV  V10.D[1], X4
    FMOV  D11, X15
    FMOV  V11.D[1], X16
    FMOV  D12, X5
    FMOV  V12.D[1], X18
    FMOV  D13, X7
    FMOV  V13.D[1], X7
    FMOV  D14, X18
    FMOV  V14.D[1], X18
    FMOV  D15, X14
    FMOV  V15.D[1], X27
    FMOV  D16, X19
    FMOV  V16.D[1], X13
    FMOV  D17, X5
    FMOV  V17.D[1], X26
    FMOV  D18, X9
    FMOV  V18.D[1], X13
    FMOV  D19, X27
    FMOV  V19.D[1], X4
    FMOV  D20, X17
    FMOV  V20.D[1], X3
    FMOV  D21, X11
    FMOV  V21.D[1], X14
    FMOV  D22, X17
    FMOV  V22.D[1], X16
    FMOV  D23, X10
    FMOV  V23.D[1], X28
    FMOV  D24, X11
    FMOV  V24.D[1], X28
    FMOV  D25, X13
    FMOV  V25.D[1], X13
    FMOV  D26, X24
    FMOV  V26.D[1], X17
    FMOV  D27, X9
    FMOV  V27.D[1], X9
    FMOV  D28, X10
    FMOV  V28.D[1], X22
    FMOV  D29, X7
    FMOV  V29.D[1], X18
    FMOV  D30, X3
    FMOV  V30.D[1], X2
    FMOV  D31, X9
    FMOV  V31.D[1], X9
    MOVZ  X28, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_1366:
    FMOV  H20, #0.45312500
    FMSUB  H7, H6, H13, H6
    FNMSUB  D6, D13, D27, D28
    FMSUB  D18, D14, D17, D28
    FMADD  S20, S23, S2, S29
    FMADD  H22, H18, H31, H27
    FMOV  H17, X13
    FNMADD  S16, S15, S16, S24
    FMOV  D24, D8
    FMOV  S28, S13
    FMOV  H31, #0.24218750
    FMOV  H10, X25
    FMOV  W13, S16
    FMOV  D0, X17
    FNMSUB  D17, D12, D1, D0
    FMSUB  H28, H12, H5, H24
    FMOV  S24, #0.37500000
    FMOV  S19, S17
    FMOV  X10, H12
    FNMADD  S14, S31, S4, S26
    FMSUB  H6, H16, H14, H22
    FMOV  W16, H28
    FNMADD  S31, S30, S13, S10
    FNMADD  D7, D5, D31, D23
    FNMADD  H14, H27, H24, H3
    FMADD  D6, D19, D1, D6
    FMOV  H6, W12
    FMOV  H31, W15
    FNMSUB  D7, D0, D1, D7
    FMOV  X25, D11
    FMOV  H13, W12
    FNMADD  D23, D19, D12, D0
    FMADD  S19, S12, S19, S20
    FMOV  S26, W17
    FMADD  S24, S20, S3, S16
    FMOV  D28, #-0.24218750
    FMOV  H15, #0.15625000
    FMADD  H27, H14, H15, H11
    FNMADD  S16, S20, S10, S31
    FNMSUB  H20, H24, H5, H10
    FMOV  X21, H28
    FMOV  H27, H26
    FNMADD  H16, H5, H7, H14
    FMOV  W9, H16
    FMOV  X19, H0
    FNMADD  H1, H22, H22, H16
    FMOV  S14, S21
    FMADD  S26, S24, S5, S11
    FNMADD  D30, D22, D29, D12
    FMOV  D2, X5
    FMOV  D20, X21
    FMOV  W3, S14
    FMADD  S16, S0, S27, S29
    FMADD  D20, D21, D16, D7
    FMOV  S21, S13
    FMSUB  D31, D3, D16, D2
    FMSUB  S30, S25, S22, S23
    FNMADD  D20, D25, D12, D31
    FNMADD  S22, S26, S9, S6
    FMOV  H10, X5
    FNMADD  H10, H1, H29, H30
    FMOV  W8, H3
    FNMSUB  S19, S24, S30, S14
    FMOV  H0, X29
    FMADD  H6, H20, H2, H13
    FMOV  X9, H10
    FMOV  H3, W29
    FNMSUB  S22, S20, S2, S9
    FMOV  H4, H6
    FMOV  H9, W24
    FMOV  D31, D10
    FMOV  D30, X10
    FMSUB  D12, D2, D2, D22
    FMOV  X20, H10
    FNMADD  H11, H24, H26, H27
    FMADD  H13, H6, H25, H12
    FMADD  S5, S1, S30, S7
    FMOV  H11, #-0.34375000
    FMOV  X6, D4
    FMOV  X24, D5
    FMSUB  D13, D16, D0, D14
    FNMSUB  D18, D5, D22, D3
    FMOV  D11, #-28.00000000
    FNMADD  S31, S27, S31, S31
    FMOV  S23, #0.87500000
    FMOV  H14, W17
    FMOV  X27, H21
    FMOV  X17, H22
    FMOV  W26, H5
    FMOV  X25, H4
    FMSUB  D31, D5, D22, D4
    FNMSUB  H25, H23, H28, H26
    FMADD  D14, D6, D31, D2
    FMOV  H25, X7
    FNMADD  D16, D2, D15, D16
    FMOV  S16, W28
    FNMADD  D18, D16, D16, D22
    FNMSUB  S23, S23, S18, S16
    FNMADD  D22, D11, D30, D9
    FMOV  D18, X20
    FMOV  D8, X17
    FMOV  W29, S12
    FMOV  W22, S17
    FMOV  S26, #13.50000000
    FMSUB  D6, D9, D5, D20
    FMOV  D20, D23
    FMADD  D21, D9, D24, D22
    FMOV  D16, #-0.28125000
    FMOV  S0, S20
    FNMADD  S11, S23, S5, S24
    FMOV  D8, D26
    FNMADD  D8, D6, D12, D25
    FNMSUB  D16, D7, D31, D14
    FMOV  H10, #0.24218750
    FNMADD  S1, S7, S23, S21
    FMOV  H28, #2.50000000
    FMOV  H8, W22
    FMADD  D31, D30, D24, D29
    FMOV  X27, D18
    FMOV  H16, H27
    FMADD  D12, D7, D1, D14
    FMOV  S13, S27
    FNMSUB  H1, H12, H28, H31
    FNMSUB  D30, D1, D29, D16
    FNMSUB  H15, H18, H0, H23
    FNMSUB  H15, H3, H9, H1
    FMADD  H4, H4, H30, H27
    FMSUB  H27, H29, H28, H29
    FNMSUB  D25, D20, D2, D2
    FNMADD  H26, H1, H31, H20
    FMADD  H25, H21, H9, H7
    FNMADD  S17, S11, S16, S26
    FMOV  X12, D4
    FMOV  D30, #28.00000000
    FNMADD  D4, D3, D10, D10
    FMADD  H16, H30, H15, H4
    FMSUB  S31, S19, S30, S0
    FMADD  D22, D25, D12, D17
    FMOV  D7, D18
    FNMSUB  S13, S3, S29, S2
    FNMADD  H13, H31, H2, H22
    FMOV  H29, H10
    FMADD  S7, S25, S15, S29
    FMOV  X24, D26
    FMOV  H4, H27
    FMOV  W21, H30
    FNMSUB  D29, D7, D13, D12
    FMOV  H26, #-0.35937500
    FMOV  X24, D30
    FMOV  X9, D5
    FMSUB  H31, H24, H16, H13
    FNMADD  H21, H16, H1, H26
    FNMSUB  S15, S4, S8, S27
    FMSUB  S19, S23, S2, S29
    FMSUB  H3, H14, H31, H20
    FMOV  S26, #-11.00000000
    FMSUB  H4, H31, H23, H7
    FMOV  X19, D28
    FMADD  D18, D7, D26, D8
    FMOV  W15, S22
    FNMSUB  S18, S27, S11, S6
    FMOV  S17, W21
    FMADD  H15, H26, H21, H20
    FMSUB  H15, H16, H14, H5
    FMOV  S15, W8
    FMOV  D28, D19
    FMSUB  S21, S0, S8, S6
    FNMSUB  D10, D23, D24, D18
    FMADD  H3, H6, H30, H19
    FNMADD  D12, D12, D30, D21
    FMSUB  H5, H9, H15, H27
    FMOV  W17, H2
    FMOV  H5, #0.21093750
    FMOV  H30, #-0.12500000
    FMOV  S28, S23
    FMOV  D29, X17
    FNMADD  D5, D26, D25, D28
    FMOV  W15, H10
    FMOV  S11, #-3.62500000
    FMOV  D17, X10
    FMOV  S3, S29
    FMOV  D24, #11.50000000
    FMOV  D14, #-15.50000000
    FMADD  H31, H17, H2, H31
    FMOV  X6, H25
    FNMADD  S24, S19, S8, S25
    FMOV  D11, D23
    FMOV  D18, #3.87500000
    FMOV  X22, H11
    FNMSUB  D16, D30, D31, D12
    FMSUB  S13, S25, S24, S9
    FMOV  H24, #0.42187500
    FMOV  D9, #-0.48437500
    FNMADD  S20, S17, S21, S29
    FMOV  D0, D16
    FMADD  D17, D11, D11, D24
    FMADD  S0, S14, S29, S20
    FMOV  W21, H10
    FNMSUB  H18, H5, H4, H21
    FMOV  S10, #-0.43750000
    SUBS  X28, X28, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_1366
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
TaishanFpMiniMaxiP01_label_497:
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X21, X29, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x36c0, LSL #0
    MOVK  X19, #0x8000, LSL #16
    SUB  X22, X19, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x1, LSL #0
    SUB  X6, X29, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x36c0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    SUB  X26, X3, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D3
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D4
    MOVZ  X21, #0x33c0, LSL #0
    SUB  X24, X21, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D5
    MOVZ  X22, #0x1, LSL #0
    MOVK  X22, #0x8000, LSL #16
    MOVK  X22, #0x8000, LSL #48
    SUB  X26, X22, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D7
    MOVZ  X16, #0x33c0, LSL #0
    SUB  X14, X16, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D9
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xbfdf, LSL #48
    SUB  X2, X20, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D10
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xbee0, LSL #16
    SUB  X21, X5, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D11
    MOVZ  X29, #0x1, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X22, X29, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D12
    MOVZ  X11, #0x1c, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X14, X11, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D14
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xc02f, LSL #48
    SUB  X22, X13, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D15
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D16
    MOVZ  X26, #0x1d, LSL #0
    SUB  X21, X26, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X15, X14, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D17
    MOVZ  X14, #0x36c1, LSL #0
    SUB  X15, X14, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X9, X15, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D19
    MOVZ  X15, #0x1, LSL #0
    SUB  X9, X15, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D20
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X8, X12, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D22
    MOVZ  X24, #0x8000, LSL #0
    MOVK  X24, #0x8000, LSL #16
    SUB  X25, X24, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D23
    MOVZ  X10, #0x1, LSL #0
    MOVK  X10, #0x8000, LSL #16
    SUB  X29, X10, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D24
    MOVZ  X15, #0x36c0, LSL #0
    SUB  X13, X15, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X19, X22, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D26
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xc130, LSL #16
    SUB  X19, X22, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X12, X14, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D28
    MOVZ  X14, #0x1, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X12, X14, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
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
TaishanFpMiniMaxiP01_label_424:
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
    FMOV  V0.D[1], X17
    FMOV  D1, X19
    FMOV  V1.D[1], X27
    FMOV  D2, X24
    FMOV  V2.D[1], X18
    FMOV  D3, X26
    FMOV  V3.D[1], X19
    FMOV  D4, X29
    FMOV  V4.D[1], X6
    FMOV  D5, X25
    FMOV  V5.D[1], X8
    FMOV  D6, X24
    FMOV  V6.D[1], X18
    FMOV  D7, X25
    FMOV  V7.D[1], X19
    FMOV  D8, X17
    FMOV  V8.D[1], X16
    FMOV  D9, X23
    FMOV  V9.D[1], X20
    FMOV  D10, X21
    FMOV  V10.D[1], X10
    FMOV  D11, X17
    FMOV  V11.D[1], X24
    FMOV  D12, X21
    FMOV  V12.D[1], X3
    FMOV  D13, X17
    FMOV  V13.D[1], X11
    FMOV  D14, X29
    FMOV  V14.D[1], X29
    FMOV  D15, X19
    FMOV  V15.D[1], X24
    FMOV  D16, X18
    FMOV  V16.D[1], X12
    FMOV  D17, X16
    FMOV  V17.D[1], X25
    FMOV  D18, X12
    FMOV  V18.D[1], X6
    FMOV  D19, X28
    FMOV  V19.D[1], X18
    FMOV  D20, X15
    FMOV  V20.D[1], X10
    FMOV  D21, X23
    FMOV  V21.D[1], X24
    FMOV  D22, X28
    FMOV  V22.D[1], X25
    FMOV  D23, X12
    FMOV  V23.D[1], X15
    FMOV  D24, X19
    FMOV  V24.D[1], X10
    FMOV  D25, X5
    FMOV  V25.D[1], X18
TaishanFpMiniMaxiP01_label_1299:
    FMOV  D26, X19
    FMOV  V26.D[1], X28
    FMOV  D27, X13
    FMOV  V27.D[1], X22
    FMOV  D28, X3
    FMOV  V28.D[1], X28
    FMOV  D29, X12
    FMOV  V29.D[1], X20
    FMOV  D30, X22
TaishanFpMiniMaxiP01_label_1432:
    FMOV  V30.D[1], X26
    FMOV  D31, X2
    FMOV  V31.D[1], X26
    MOVZ  X24, #0xf, LSL #0
TaishanFpMiniMaxiP01_label_1451:
    FNMADD  S17, S30, S25, S14
    FMOV  H9, W16
    FMOV  W18, S23
    FMOV  H19, #0.59375000
    FMOV  S2, W7
    FMOV  H8, #-11.00000000
    FMSUB  H8, H29, H17, H24
    FMOV  D30, X7
    FMOV  W13, H15
    FMADD  D31, D17, D2, D2
    FMOV  H6, X21
    FMOV  X25, H24
    FMOV  S29, #23.00000000
    FMADD  H31, H16, H2, H15
    FNMSUB  D26, D3, D20, D18
    FNMADD  D19, D28, D8, D19
    FNMADD  H9, H19, H31, H19
    FNMSUB  S8, S6, S31, S14
    FNMSUB  D18, D29, D1, D22
    FMOV  X7, H1
    FMADD  D3, D23, D18, D11
    FMOV  W19, S12
    FNMADD  D25, D16, D31, D19
    FMOV  X26, H1
    FMOV  D28, #-0.84375000
    FMSUB  H15, H7, H30, H12
    FMOV  H19, #2.25000000
    FMOV  S13, #-2.25000000
    FMOV  D24, #-1.00000000
    FMOV  S18, W24
    FMOV  W27, H1
    FNMADD  S24, S24, S25, S15
    FMOV  S1, W24
    FMOV  H6, W27
    FMOV  H23, X15
    FNMSUB  H3, H16, H19, H22
    FMOV  D26, D24
    FMOV  W25, H16
    FMSUB  S13, S0, S6, S22
    FMOV  X15, H17
    FMOV  D10, D3
    FMOV  X15, D10
    FMOV  W22, S7
    FMSUB  S14, S18, S25, S3
    FNMADD  S27, S3, S18, S6
    FMADD  H23, H30, H20, H15
    FMOV  S14, W21
    FMOV  D20, X5
    FMOV  H24, W24
    FMOV  D29, #-1.12500000
    FMOV  W13, S23
    FMOV  X20, H17
    FMADD  H23, H19, H12, H15
    FMADD  D8, D30, D15, D10
    FMOV  S25, W28
    FMOV  S22, #-0.59375000
    FMOV  D12, D11
    FNMSUB  S27, S3, S8, S4
    FNMADD  H12, H0, H11, H23
    FMOV  H3, X25
    FMSUB  D23, D24, D11, D2
    FNMSUB  D16, D7, D25, D8
    FMOV  D25, X4
    FMOV  X14, H8
    FMSUB  S10, S11, S22, S16
    FMOV  X16, H17
    FMOV  H17, #18.00000000
    FMOV  D14, #0.35937500
    FMSUB  D18, D22, D3, D20
    FMOV  H21, #-25.00000000
    FMADD  D9, D13, D11, D23
    FMSUB  D11, D2, D6, D10
    FNMSUB  D5, D6, D29, D12
    FMOV  H3, #-23.00000000
    FNMSUB  S10, S19, S1, S9
    FMOV  H14, W21
    FMOV  H27, W25
    FMSUB  D27, D17, D12, D19
    FMOV  H11, X29
    FMOV  D25, #2.62500000
    FMOV  D21, D6
    FNMSUB  S22, S9, S22, S10
    FMADD  H30, H4, H12, H20
    FMSUB  H1, H19, H26, H3
    FNMSUB  D16, D0, D4, D11
    FNMSUB  S6, S28, S2, S11
    FMOV  S14, #3.00000000
    FMOV  H12, X3
    FMSUB  H15, H18, H25, H31
    FMOV  H2, H11
    FMADD  H26, H27, H31, H14
    FNMADD  S30, S12, S24, S7
    FMOV  H6, X12
    FMSUB  S5, S2, S12, S4
    FMOV  W14, H23
    FMADD  D19, D0, D0, D8
    FMSUB  H6, H14, H1, H1
    FMOV  H15, X28
    FMADD  S6, S11, S15, S21
    FMOV  H2, H10
    FNMADD  D30, D11, D4, D14
    FMADD  D30, D26, D17, D21
    FMOV  H9, #-3.37500000
    FNMSUB  D12, D2, D14, D23
    FMOV  H1, X8
    FMADD  S12, S17, S2, S12
    FNMADD  S0, S23, S5, S19
    FMOV  S12, #-7.75000000
    FMSUB  S20, S7, S12, S0
    FMOV  W26, H26
    FNMADD  H20, H20, H28, H25
    FMOV  H31, X24
    FMOV  X14, H7
    FMOV  W18, S20
    FMOV  S7, S31
    FMOV  X8, H20
    FNMSUB  H25, H5, H30, H5
    FMOV  S1, W4
    FNMADD  S18, S12, S20, S14
    FNMADD  D25, D10, D18, D29
    FNMADD  D2, D21, D22, D4
    FMOV  H1, X24
    FMSUB  S20, S11, S5, S18
    FNMADD  H28, H20, H14, H27
    FMOV  D6, #-2.75000000
    FNMSUB  H26, H9, H17, H29
    FMOV  W19, H9
    FMOV  X29, D14
    FMOV  H16, W2
    FMOV  H2, X26
    FMOV  H28, X18
    FMOV  H23, W2
    FMOV  S20, S29
    FMADD  H8, H27, H16, H11
    FMADD  S31, S25, S15, S6
    FMOV  X8, H23
    FMOV  D21, D10
    FMOV  D28, #0.87500000
    FNMADD  H19, H9, H24, H12
    FNMSUB  S14, S14, S22, S2
    FMOV  X25, H23
    FMOV  D0, D16
    FNMSUB  S29, S11, S21, S26
    FMOV  X16, H8
    FMOV  W17, H7
    FNMSUB  H24, H29, H20, H16
    FMOV  D20, X26
    FMSUB  H0, H8, H20, H24
    FMOV  H23, X4
    FNMSUB  S20, S23, S12, S26
    FNMADD  H26, H2, H18, H0
    FMOV  H3, W17
    FMOV  X23, H14
    FMOV  S31, W23
    FMOV  H1, W5
    FMADD  S14, S31, S13, S27
    FMOV  D3, #23.00000000
    FMOV  H8, X10
    FMOV  W11, H19
    FMOV  D10, #13.50000000
    FMOV  W21, S26
    FMSUB  D4, D25, D22, D12
    FMOV  S8, S18
    FMOV  H2, X13
    FMOV  W20, H11
    FMADD  H12, H7, H17, H24
    FMADD  D16, D14, D20, D4
    FNMSUB  D7, D28, D18, D3
    FNMADD  S11, S19, S20, S28
    FMOV  D0, D29
    FMOV  D7, D23
    FMOV  S17, S21
    FMSUB  D8, D31, D0, D29
    FMSUB  D27, D3, D17, D25
    FMOV  H10, #23.00000000
    FMOV  D7, D27
    FMOV  D11, X11
    FMOV  D23, D30
    FMSUB  H29, H25, H14, H11
    FMOV  H5, W9
    FMOV  H5, H23
    FMSUB  D12, D16, D30, D27
    FMSUB  H29, H5, H8, H1
    FMOV  W21, H2
    FMOV  H28, W14
    FMOV  H8, #-11.00000000
    FNMSUB  H31, H22, H13, H9
    FNMSUB  D18, D23, D28, D6
    FMSUB  S23, S12, S10, S16
    FMOV  D22, D21
    FNMSUB  H22, H15, H17, H29
    FMOV  S13, S28
    FMOV  X20, D8
    FNMSUB  S8, S13, S27, S23
    FMOV  H22, H0
    FMSUB  H16, H14, H2, H31
    FMOV  S8, #-0.17187500
    FMOV  X23, H23
    FMOV  D17, #3.37500000
    FMOV  W15, S18
    SUBS  X24, X24, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_1451
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X8, X3, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X2, X9, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X10, X7, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X26, X29, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X13, X8, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x1, LSL #0
    SUB  X12, X8, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X24, X15, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    SUB  X12, X8, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X28
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D2
    MOVZ  X4, #0xffff, LSL #0
    SUB  X28, X4, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D3
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x4037, LSL #48
    SUB  X26, X24, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D4
    MOVZ  X21, #0x8b02, LSL #0
    MOVK  X21, #0xc0f7, LSL #16
    SUB  X17, X21, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D5
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D6
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc006, LSL #48
    SUB  X5, X17, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D7
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x3ff2, LSL #48
    SUB  X28, X20, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D8
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xbe30, LSL #16
    SUB  X5, X13, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D9
    MOVZ  X7, #0xc2c0, LSL #0
    SUB  X12, X7, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D10
    MOVZ  X16, #0x4dc0, LSL #0
    SUB  X7, X16, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D12
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3ff2, LSL #48
    SUB  X6, X14, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D14
    MOVZ  X24, #0x4081, LSL #0
    SUB  X3, X24, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D15
    MOVZ  X13, #0xffff, LSL #0
    SUB  X19, X13, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D16
    MOVZ  X19, #0xffff, LSL #0
    SUB  X12, X19, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D17
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x400b, LSL #48
    SUB  X25, X10, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D18
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4006, LSL #48
    SUB  X8, X4, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D19
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D20
    MOVZ  X9, #0x9390, LSL #0
    MOVK  X9, #0x8008, LSL #16
    SUB  X6, X9, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D21
    MOVZ  X7, #0xfffe, LSL #0
    MOVK  X7, #0x8000, LSL #16
    SUB  X27, X7, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D22
    MOVZ  X9, #0xd398, LSL #0
    SUB  X8, X9, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D23
    MOVZ  X26, #0x8b03, LSL #0
    MOVK  X26, #0xc0f7, LSL #16
    SUB  X29, X26, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D24
    MOVZ  X10, #0x7fff, LSL #0
    SUB  X9, X10, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X9, D25
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x3ff2, LSL #48
    SUB  X29, X24, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D26
    MOVZ  X13, #0xffff, LSL #0
    SUB  X10, X13, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D27
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3ff2, LSL #48
    SUB  X8, X6, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D29
    MOVZ  X28, #0xffff, LSL #0
    SUB  X4, X28, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0xc09f, LSL #0
    MOVK  X2, #0xab6c, LSL #16
    MOVK  X2, #0xf3ff, LSL #32
    MOVK  X2, #0x570b, LSL #48
    MOVZ  X3, #0x1b8f, LSL #0
    MOVK  X3, #0x948f, LSL #16
    MOVK  X3, #0xc0ab, LSL #32
    MOVK  X3, #0xd6cf, LSL #48
    MOVZ  X4, #0xaad8, LSL #0
    MOVK  X4, #0x683c, LSL #16
    MOVK  X4, #0x63d2, LSL #32
    MOVK  X4, #0x3704, LSL #48
    MOVZ  X5, #0x98bb, LSL #0
    MOVK  X5, #0x1979, LSL #16
    MOVK  X5, #0x2ce8, LSL #32
    MOVK  X5, #0x2ca8, LSL #48
    MOVZ  X6, #0x6dd3, LSL #0
    MOVK  X6, #0x596d, LSL #16
    MOVK  X6, #0x4368, LSL #32
    MOVK  X6, #0x9a0f, LSL #48
    MOVZ  X7, #0xca9c, LSL #0
    MOVK  X7, #0x18e6, LSL #16
    MOVK  X7, #0x8e24, LSL #32
    MOVK  X7, #0xf2b4, LSL #48
    MOVZ  X8, #0xbf9b, LSL #0
    MOVK  X8, #0x3845, LSL #16
    MOVK  X8, #0x454d, LSL #32
    MOVK  X8, #0x7048, LSL #48
    MOVZ  X9, #0x198c, LSL #0
    MOVK  X9, #0x4780, LSL #16
    MOVK  X9, #0x79ac, LSL #32
    MOVK  X9, #0xbccf, LSL #48
    MOVZ  X10, #0xf9ae, LSL #0
    MOVK  X10, #0x634b, LSL #16
    MOVK  X10, #0x6c08, LSL #32
    MOVK  X10, #0x537f, LSL #48
    MOVZ  X11, #0xc45, LSL #0
    MOVK  X11, #0xff34, LSL #16
    MOVK  X11, #0xf8c1, LSL #32
    MOVK  X11, #0x2700, LSL #48
    MOVZ  X12, #0x2086, LSL #0
    MOVK  X12, #0xcc45, LSL #16
    MOVK  X12, #0xbece, LSL #32
    MOVK  X12, #0x92b6, LSL #48
    MOVZ  X13, #0xcea3, LSL #0
    MOVK  X13, #0x568, LSL #16
    MOVK  X13, #0x155e, LSL #32
    MOVK  X13, #0xb52b, LSL #48
    MOVZ  X14, #0xa8bc, LSL #0
    MOVK  X14, #0xcb73, LSL #16
    MOVK  X14, #0x1df6, LSL #32
    MOVK  X14, #0xfe6e, LSL #48
    MOVZ  X15, #0x517e, LSL #0
    MOVK  X15, #0x78fc, LSL #16
    MOVK  X15, #0x838e, LSL #32
    MOVK  X15, #0x148c, LSL #48
    MOVZ  X16, #0x14f9, LSL #0
    MOVK  X16, #0x5cd2, LSL #16
    MOVK  X16, #0x852e, LSL #32
    MOVK  X16, #0xfdee, LSL #48
    MOVZ  X17, #0xdc9b, LSL #0
    MOVK  X17, #0x9475, LSL #16
    MOVK  X17, #0xd61a, LSL #32
    MOVK  X17, #0x397b, LSL #48
    MOVZ  X18, #0x7e0, LSL #0
    MOVK  X18, #0xd289, LSL #16
    MOVK  X18, #0xf992, LSL #32
    MOVK  X18, #0xe92b, LSL #48
    MOVZ  X19, #0xc8df, LSL #0
    MOVK  X19, #0x9869, LSL #16
    MOVK  X19, #0x26b6, LSL #32
    MOVK  X19, #0xb27a, LSL #48
    MOVZ  X20, #0xfc1f, LSL #0
    MOVK  X20, #0xc3a, LSL #16
    MOVK  X20, #0xd082, LSL #32
    MOVK  X20, #0xd61, LSL #48
    MOVZ  X21, #0x1754, LSL #0
    MOVK  X21, #0xa7f4, LSL #16
    MOVK  X21, #0xfd70, LSL #32
    MOVK  X21, #0x36a8, LSL #48
    MOVZ  X22, #0x673f, LSL #0
    MOVK  X22, #0xed32, LSL #16
    MOVK  X22, #0xae9b, LSL #32
    MOVK  X22, #0x150b, LSL #48
    MOVZ  X23, #0x2374, LSL #0
    MOVK  X23, #0x300b, LSL #16
    MOVK  X23, #0x6a17, LSL #32
    MOVK  X23, #0x1918, LSL #48
    MOVZ  X24, #0x4a15, LSL #0
    MOVK  X24, #0xd16f, LSL #16
    MOVK  X24, #0x2437, LSL #32
    MOVK  X24, #0x85ae, LSL #48
    MOVZ  X25, #0xe98e, LSL #0
    MOVK  X25, #0xe8fd, LSL #16
    MOVK  X25, #0xc169, LSL #32
    MOVK  X25, #0x1f11, LSL #48
    MOVZ  X26, #0x10e4, LSL #0
    MOVK  X26, #0x4d11, LSL #16
    MOVK  X26, #0x6b9, LSL #32
    MOVK  X26, #0x607b, LSL #48
    MOVZ  X27, #0xfb6d, LSL #0
    MOVK  X27, #0xcfe3, LSL #16
    MOVK  X27, #0x9f3, LSL #32
    MOVK  X27, #0xd870, LSL #48
    MOVZ  X28, #0xa0d9, LSL #0
    MOVK  X28, #0xa7d6, LSL #16
    MOVK  X28, #0xfcff, LSL #32
    MOVK  X28, #0x936f, LSL #48
    MOVZ  X29, #0x3dec, LSL #0
    MOVK  X29, #0xaa58, LSL #16
    MOVK  X29, #0xd2df, LSL #32
    MOVK  X29, #0x36b0, LSL #48
    FMOV  D0, X11
    FMOV  V0.D[1], X3
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X23
    FMOV  V2.D[1], X26
    FMOV  D3, X26
    FMOV  V3.D[1], X7
    FMOV  D4, X3
    FMOV  V4.D[1], X17
    FMOV  D5, X29
    FMOV  V5.D[1], X25
    FMOV  D6, X10
    FMOV  V6.D[1], X8
    FMOV  D7, X25
    FMOV  V7.D[1], X9
    FMOV  D8, X19
    FMOV  V8.D[1], X12
    FMOV  D9, X4
    FMOV  V9.D[1], X27
    FMOV  D10, X4
    FMOV  V10.D[1], X6
    FMOV  D11, X26
    FMOV  V11.D[1], X17
    FMOV  D12, X13
    FMOV  V12.D[1], X15
    FMOV  D13, X4
    FMOV  V13.D[1], X28
    FMOV  D14, X23
    FMOV  V14.D[1], X9
    FMOV  D15, X4
    FMOV  V15.D[1], X11
    FMOV  D16, X26
    FMOV  V16.D[1], X13
    FMOV  D17, X2
    FMOV  V17.D[1], X13
    FMOV  D18, X14
    FMOV  V18.D[1], X19
    FMOV  D19, X19
    FMOV  V19.D[1], X18
    FMOV  D20, X23
    FMOV  V20.D[1], X14
    FMOV  D21, X4
    FMOV  V21.D[1], X16
    FMOV  D22, X14
    FMOV  V22.D[1], X27
    FMOV  D23, X16
    FMOV  V23.D[1], X5
    FMOV  D24, X26
    FMOV  V24.D[1], X21
    FMOV  D25, X10
    FMOV  V25.D[1], X4
    FMOV  D26, X16
    FMOV  V26.D[1], X9
    FMOV  D27, X18
    FMOV  V27.D[1], X19
    FMOV  D28, X12
    FMOV  V28.D[1], X26
    FMOV  D29, X26
    FMOV  V29.D[1], X9
    FMOV  D30, X7
    FMOV  V30.D[1], X3
    FMOV  D31, X26
    FMOV  V31.D[1], X26
    MOVZ  X18, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_1534:
    FMOV  H9, X5
    FMOV  X17, H2
    FMOV  H14, H7
    FMSUB  D9, D18, D18, D10
    FMOV  H21, #-4.50000000
    FMOV  H13, H24
    FMADD  S27, S1, S0, S22
    FMOV  H30, X14
    FMOV  H5, W29
    FMOV  D31, #0.23437500
    FMOV  W19, H16
    FMOV  D31, #-0.18750000
    FMOV  S13, #-0.17187500
    FNMADD  D20, D10, D0, D27
    FMADD  D8, D29, D10, D21
    FMOV  S0, W7
    FMOV  W21, H5
    FMOV  X29, D28
    FNMSUB  H29, H20, H4, H30
    FNMSUB  H14, H20, H2, H5
    FNMSUB  S2, S22, S19, S14
    FMOV  D19, X2
    FMOV  W7, S21
    FMADD  D0, D22, D30, D23
    FMOV  W15, H29
    FNMADD  H10, H25, H12, H18
    FMADD  H5, H2, H8, H15
    FMOV  X13, D22
    FMOV  D5, D28
    FMADD  D7, D6, D31, D30
    FMOV  H5, #13.00000000
    FMOV  W14, S11
    FMOV  H0, #-1.50000000
    FMOV  X27, D15
    FMOV  W17, H29
    FMADD  D19, D0, D7, D10
    FMOV  S22, S5
    FMOV  W26, H22
    FMOV  H19, X21
    FMOV  H17, X11
    FMOV  S19, S22
    FMOV  H10, #-4.50000000
    FNMSUB  H19, H21, H16, H22
    FMOV  D5, #-4.50000000
    FMOV  H19, W2
    FMOV  W28, H12
    FMOV  X10, D22
    FMOV  D30, #-7.50000000
    FNMADD  H14, H11, H27, H11
    FMOV  H16, W2
    FNMSUB  H13, H6, H8, H24
    FNMADD  D28, D14, D15, D16
    FNMSUB  H1, H13, H30, H24
    FMOV  X26, D11
    FMSUB  D13, D19, D30, D21
    FMOV  W16, S17
    FMOV  H10, #1.68750000
    FMOV  D7, D28
    FMOV  H14, H7
    FNMADD  D24, D8, D16, D25
    FMOV  S5, W15
    FNMADD  H28, H31, H12, H13
    FMOV  W11, S8
    FMOV  S27, W11
    FMOV  S17, S24
    FMOV  H12, H6
    FMSUB  S19, S23, S14, S21
    FMOV  S30, W21
    FMOV  H28, X9
    FMOV  X8, H14
    FMOV  D28, D27
    FMOV  H23, #5.00000000
    FMOV  H11, X26
    FMSUB  H19, H6, H13, H17
    FMOV  H6, #-0.81250000
    FMSUB  H0, H1, H24, H1
    FMOV  W8, H27
    FNMSUB  S9, S23, S0, S21
    FMOV  H15, W17
    FMADD  H19, H12, H9, H5
    FMOV  H29, H31
    FMOV  W13, H30
    FNMSUB  S11, S28, S30, S12
    FMOV  S6, S2
    FMADD  S16, S31, S1, S13
    FMOV  D21, X8
    FMOV  H19, #-11.50000000
    FNMSUB  D3, D16, D7, D21
    FMOV  H3, W25
    FMSUB  H19, H24, H19, H2
    FMADD  S8, S2, S28, S19
    FMOV  S25, #-7.50000000
    FMSUB  S29, S14, S30, S22
    FMOV  H13, #-0.26562500
    FMSUB  D29, D26, D12, D18
    FMADD  H2, H11, H31, H13
    FMOV  W2, H0
    FMADD  H7, H14, H23, H1
    FMOV  S8, #2.25000000
    FNMSUB  D29, D8, D2, D19
    FNMSUB  H28, H0, H0, H29
    FMOV  S21, W21
    FMSUB  S31, S7, S25, S15
    FNMSUB  D1, D18, D30, D6
    FMADD  S27, S12, S31, S21
    FNMSUB  H19, H18, H15, H1
    FMOV  D4, X23
    FNMADD  H5, H23, H11, H25
    FMOV  X10, D6
    FMOV  D21, #-1.81250000
    FMOV  S31, #-2.25000000
    FMOV  D23, X13
    FMOV  S19, W12
    FNMADD  S15, S31, S30, S20
    FMOV  S23, S2
    FMOV  D6, X27
    FMOV  H10, X5
    FMOV  S17, #8.50000000
    FMOV  W16, S7
    FMOV  D25, X21
    FMADD  D19, D9, D20, D1
    FMOV  S27, W24
    FNMADD  S21, S15, S23, S30
    FMOV  W16, H21
    FMOV  S27, #0.78125000
    FMOV  H5, W19
    FMADD  H13, H2, H1, H11
    FMOV  D24, X25
    FMOV  D14, #-2.25000000
    FMOV  S14, S3
    FMOV  D21, X5
    FMOV  W5, S12
    FMOV  D4, X9
    FMADD  D25, D3, D4, D17
    FMOV  D22, X22
    FMOV  S2, #-0.93750000
    FNMSUB  S20, S3, S25, S12
    FMOV  S2, #9.50000000
    FNMSUB  D26, D5, D22, D7
    FMOV  S26, S24
    FMOV  X27, H9
    FMOV  W24, H12
    FMOV  S31, W3
    FNMADD  H12, H8, H15, H11
    FMOV  S31, #-0.45312500
    FMOV  S23, S10
    FNMSUB  H25, H15, H10, H18
    FMOV  H15, H14
    FMOV  H21, W16
    FNMADD  S31, S8, S3, S14
    FMSUB  S31, S21, S22, S8
    FMSUB  H13, H7, H17, H2
    FMOV  S0, #23.00000000
    FNMADD  D1, D27, D15, D10
    FMOV  S5, S14
    FMSUB  S13, S23, S25, S26
    FNMADD  H9, H11, H18, H17
    FMOV  H8, H25
    FMSUB  H22, H8, H23, H18
    FMOV  D22, X10
    FMOV  H3, H6
    FMOV  H22, H16
    FMOV  H17, #-26.00000000
    FMOV  H17, X28
    FMOV  X13, D12
    FMADD  H21, H9, H17, H25
    FNMSUB  H26, H31, H14, H8
    FNMADD  H28, H21, H1, H24
    FMADD  H21, H5, H24, H24
    FMOV  D5, D21
    FMOV  S18, W20
    FMOV  S21, W29
    FMADD  D1, D13, D21, D4
    FMOV  X21, H18
    FMSUB  H16, H10, H3, H12
    FMSUB  S16, S16, S2, S6
    FMOV  H28, X12
    FMOV  D25, D8
    FMOV  H15, H28
    FNMSUB  D12, D25, D14, D16
    FMOV  S16, W11
    FNMSUB  S29, S5, S23, S1
    FMOV  D30, #-0.24218750
    FMOV  H25, #-10.50000000
    FMADD  S16, S7, S13, S2
    FMOV  D30, #-7.50000000
    FMOV  W22, S1
    FMSUB  H19, H29, H9, H7
    FNMSUB  H8, H11, H24, H19
    FMOV  S4, S12
    FMADD  S4, S21, S4, S17
    FMSUB  H30, H0, H22, H13
    FMSUB  H20, H19, H23, H15
    FNMADD  H29, H12, H28, H20
    FNMSUB  H28, H29, H20, H23
    FMSUB  D28, D16, D11, D5
    FNMSUB  S7, S13, S17, S17
    FMSUB  D20, D0, D28, D12
    FMADD  S20, S24, S3, S5
    FMADD  S15, S0, S7, S2
TaishanFpMiniMaxiP01_label_457:
    SUBS  X18, X18, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_1534
    MOVZ  X9, #0x77fd, LSL #0
    SUB  X25, X9, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x1b8f, LSL #0
    MOVK  X26, #0x948f, LSL #16
    MOVK  X26, #0xc0ab, LSL #32
    MOVK  X26, #0xd6cf, LSL #48
    SUB  X11, X26, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0xaad8, LSL #0
    MOVK  X21, #0x683c, LSL #16
    MOVK  X21, #0x63d2, LSL #32
    MOVK  X21, #0x3704, LSL #48
    SUB  X28, X21, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x6dd3, LSL #0
    MOVK  X11, #0x596d, LSL #16
    MOVK  X11, #0x4368, LSL #32
    MOVK  X11, #0x9a0f, LSL #48
    SUB  X7, X11, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X11, #0x77fd, LSL #0
    SUB  X12, X11, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0xfbff, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X23, X27, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x77fd, LSL #0
    SUB  X26, X22, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X18, #0x1, LSL #0
    SUB  X16, X18, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x8000, LSL #0
    SUB  X5, X2, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0x1, LSL #0
    SUB  X11, X4, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0xfc1f, LSL #0
    MOVK  X2, #0xc3a, LSL #16
    MOVK  X2, #0xd082, LSL #32
    MOVK  X2, #0xd61, LSL #48
    SUB  X17, X2, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x77fd, LSL #0
    SUB  X27, X15, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0x7c00, LSL #0
    SUB  X16, X20, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D2
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4118, LSL #16
    SUB  X22, X4, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D4
    MOVZ  X8, #0x99ff, LSL #0
    MOVK  X8, #0x5, LSL #16
    SUB  X28, X8, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D5
    MOVZ  X7, #0x7c00, LSL #0
    SUB  X26, X7, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D6
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4118, LSL #16
    SUB  X23, X11, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D7
    MOVZ  X19, #0xe890, LSL #0
    MOVK  X19, #0xa67d, LSL #16
    SUB  X11, X19, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D8
    MOVZ  X4, #0x7e1f, LSL #0
    SUB  X12, X4, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D9
    MOVZ  X20, #0xfe1f, LSL #0
    SUB  X3, X20, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D11
    MOVZ  X26, #0x1, LSL #0
    SUB  X14, X26, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D12
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0x4117, LSL #16
    MOVK  X6, #0x8000, LSL #48
    SUB  X27, X6, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D13
    MOVZ  X17, #0xe98e, LSL #0
    MOVK  X17, #0xe8fd, LSL #16
    SUB  X23, X17, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X2, D14
    MOVZ  X13, #0xe98e, LSL #0
    SUB  X17, X13, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X14, D15
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x4118, LSL #16
    SUB  X18, X4, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D16
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x4118, LSL #16
    SUB  X3, X23, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X25, X15, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X27, D17
    MOVZ  X15, #0xffff, LSL #0
    SUB  X25, X15, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D18
    MOVZ  X27, #0xfc1f, LSL #0
    MOVK  X27, #0xc3a, LSL #16
    SUB  X21, X27, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D19
    MOVZ  X20, #0xfe1f, LSL #0
    SUB  X14, X20, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D20
    MOVZ  X26, #0x7c00, LSL #0
    SUB  X3, X26, X15
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D21
    MOVZ  X24, #0x7c00, LSL #0
    SUB  X29, X24, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D22
    MOVZ  X13, #0x486a, LSL #0
    SUB  X10, X13, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D24
    MOVZ  X21, #0xe98e, LSL #0
    MOVK  X21, #0xe8fd, LSL #16
    MOVK  X21, #0xc169, LSL #32
    MOVK  X21, #0x1f11, LSL #48
    SUB  X5, X21, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D25
    MOVZ  X22, #0xc940, LSL #0
    SUB  X12, X22, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X23, X24, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X21, D26
    MOVZ  X24, #0xfe1f, LSL #0
    SUB  X23, X24, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D27
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3f48, LSL #16
    SUB  X23, X17, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D28
    MOVZ  X21, #0x7c00, LSL #0
    SUB  X15, X21, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D29
    MOVZ  X17, #0xfe1f, LSL #0
    SUB  X24, X17, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
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
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X17
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X15
    FMOV  D2, X11
    FMOV  V2.D[1], X21
TaishanFpMiniMaxiP01_label_409:
    FMOV  D3, X16
    FMOV  V3.D[1], X15
    FMOV  D4, X12
    FMOV  V4.D[1], X20
    FMOV  D5, X11
    FMOV  V5.D[1], X24
    FMOV  D6, X23
    FMOV  V6.D[1], X23
    FMOV  D7, X28
    FMOV  V7.D[1], X24
    FMOV  D8, X15
    FMOV  V8.D[1], X29
    FMOV  D9, X5
    FMOV  V9.D[1], X26
    FMOV  D10, X7
    FMOV  V10.D[1], X11
    FMOV  D11, X5
    FMOV  V11.D[1], X29
    FMOV  D12, X12
    FMOV  V12.D[1], X17
    FMOV  D13, X11
    FMOV  V13.D[1], X19
    FMOV  D14, X23
    FMOV  V14.D[1], X7
    FMOV  D15, X24
    FMOV  V15.D[1], X21
    FMOV  D16, X6
    FMOV  V16.D[1], X28
    FMOV  D17, X23
    FMOV  V17.D[1], X5
    FMOV  D18, X21
    FMOV  V18.D[1], X8
    FMOV  D19, X17
    FMOV  V19.D[1], X26
    FMOV  D20, X2
    FMOV  V20.D[1], X15
    FMOV  D21, X9
    FMOV  V21.D[1], X17
    FMOV  D22, X12
    FMOV  V22.D[1], X8
    FMOV  D23, X21
    FMOV  V23.D[1], X6
    FMOV  D24, X24
    FMOV  V24.D[1], X11
    FMOV  D25, X24
    FMOV  V25.D[1], X15
    FMOV  D26, X12
    FMOV  V26.D[1], X16
    FMOV  D27, X28
    FMOV  V27.D[1], X2
    FMOV  D28, X27
    FMOV  V28.D[1], X15
    FMOV  D29, X4
    FMOV  V29.D[1], X28
    FMOV  D30, X27
    FMOV  V30.D[1], X4
    FMOV  D31, X13
    FMOV  V31.D[1], X16
    MOVZ  X27, #0xa, LSL #0
TaishanFpMiniMaxiP01_label_1619:
    FMADD  H25, H13, H26, H12
    FMOV  D24, #1.81250000
    FMOV  X6, D18
    FMOV  S13, #22.00000000
    FMOV  S30, #-0.48437500
    FMOV  H20, H29
    FMSUB  D21, D24, D5, D3
    FMADD  D5, D12, D18, D4
    FMSUB  D13, D19, D28, D1
    FMOV  S13, W14
    FMADD  H22, H19, H31, H19
    FMSUB  S30, S20, S22, S4
    FMOV  S30, W24
    FMOV  H11, X29
    FNMADD  H26, H19, H4, H9
    FMOV  X10, D3
    FNMSUB  D15, D27, D31, D31
    FMOV  D7, #-0.42187500
    FMSUB  D29, D31, D27, D17
    FMOV  X14, D24
    FMOV  S11, #6.00000000
    FMOV  H6, H25
    FMOV  S15, S28
    FMOV  D25, #-3.87500000
    FNMADD  S6, S21, S4, S17
    FMOV  D20, X2
    FMOV  S20, S22
    FNMADD  S9, S11, S4, S20
    FNMSUB  D6, D27, D5, D6
    FMOV  D5, D21
    FMOV  X15, H5
    FNMSUB  H28, H6, H12, H18
    FMOV  S15, #-8.00000000
    FMOV  H13, #3.25000000
    FNMADD  H23, H9, H12, H10
    FMOV  S16, #1.06250000
    FMSUB  S18, S2, S31, S27
    FMSUB  S25, S28, S21, S0
    FMADD  H18, H4, H23, H6
    FMOV  D9, D6
    FMADD  S12, S6, S22, S17
    FMOV  D13, D18
    FNMSUB  H9, H26, H3, H14
    FMOV  X5, D0
    FNMSUB  H25, H7, H9, H15
    FMOV  H0, X13
    FMOV  H9, X24
    FMOV  H31, X27
    FNMADD  D27, D24, D23, D21
    FMADD  D7, D16, D8, D31
    FMOV  S28, W11
    FNMSUB  S6, S0, S17, S31
    FMOV  S11, W5
    FMOV  S7, S27
    FMOV  W10, H12
    FMADD  S22, S22, S2, S27
    FMOV  W23, S29
    FNMSUB  S26, S16, S22, S26
    FMADD  S9, S17, S9, S19
    FMOV  S11, #5.50000000
    FMADD  H5, H4, H25, H19
    FMOV  H29, #-3.00000000
    FMOV  D10, #-0.15625000
    FNMADD  D0, D27, D16, D5
    FNMADD  H26, H25, H9, H21
    FMOV  X22, H28
    FMOV  H2, #27.00000000
    FMOV  D13, D13
    FMOV  H2, H19
    FMOV  D0, X13
    FMOV  H10, X10
    FMADD  D10, D6, D26, D12
    FNMADD  S19, S8, S9, S7
    FNMSUB  D4, D25, D25, D12
    FMADD  H17, H18, H12, H26
    FMOV  D16, #-4.25000000
    FMOV  D6, X5
    FNMSUB  D12, D26, D2, D31
    FMSUB  H11, H24, H6, H24
    FMOV  D8, X24
    FMOV  W21, H3
    FNMSUB  D26, D12, D7, D6
    FNMADD  S5, S2, S26, S10
    FMOV  H3, X2
    FMOV  H11, W24
    FMOV  H31, X17
    FMOV  W6, S8
    FMADD  S27, S6, S9, S7
    FMOV  W18, H5
    FMOV  D8, D6
    FNMSUB  H26, H10, H28, H7
    FMOV  X29, H12
    FMOV  W5, S11
    FMADD  H21, H27, H24, H4
    FNMADD  H21, H16, H16, H0
    FMOV  X22, D18
    FMOV  D15, X3
    FMOV  X29, D4
    FMADD  D9, D3, D20, D10
    FMOV  X21, D8
    FNMSUB  H12, H22, H15, H31
    FNMADD  H11, H19, H12, H12
    FNMADD  S4, S19, S25, S26
    FMADD  D8, D17, D19, D27
    FMADD  S18, S21, S19, S7
    FNMSUB  S11, S18, S21, S25
    FMOV  X12, D16
    FMOV  X8, D17
    FMOV  D7, X17
    FNMSUB  D4, D12, D4, D6
    FMSUB  D8, D27, D24, D11
    FNMSUB  H9, H12, H11, H7
    FMADD  S4, S27, S16, S4
    FMOV  W14, H25
    FNMADD  S19, S8, S4, S24
    FMOV  X7, D27
    FMOV  D8, #-27.00000000
    FMADD  D8, D6, D14, D31
    FNMSUB  H25, H2, H30, H5
    FNMADD  S2, S12, S0, S7
    FNMSUB  D27, D9, D7, D22
    FNMADD  S5, S0, S4, S20
    FMOV  X22, D6
    FMOV  H28, #-0.46875000
    FMOV  W17, S21
    FMOV  X28, H19
    FMADD  D11, D26, D24, D7
    FNMSUB  H0, H28, H30, H5
    FMOV  H27, H30
    FMSUB  H11, H2, H19, H11
    FMADD  D11, D8, D19, D8
    FMOV  W28, H24
    FMOV  H22, X18
    FMOV  H28, X18
    FNMSUB  S25, S21, S25, S0
    FMOV  D15, D4
    FMOV  X28, H12
    FMOV  H23, H2
    FMSUB  H12, H0, H4, H15
    FNMSUB  S22, S22, S23, S0
    FMADD  S27, S25, S0, S17
    FMADD  D5, D11, D27, D12
    FMOV  S15, #-0.68750000
    FMOV  W10, S8
    FMOV  W11, H17
    FNMSUB  H17, H21, H24, H10
    FMOV  H5, X21
    FMOV  H30, H22
    FMADD  D10, D1, D22, D31
    FMOV  D28, D1
    FMADD  D18, D22, D6, D9
    FNMADD  H18, H19, H18, H4
    FNMADD  H5, H8, H10, H19
    FNMSUB  D31, D13, D19, D5
    FMADD  H1, H22, H2, H3
    FMOV  H11, #-27.00000000
    FMSUB  H11, H12, H30, H11
    FMOV  X4, D16
    FMSUB  D4, D8, D21, D28
    FNMSUB  H16, H27, H16, H23
    FNMADD  S31, S15, S29, S28
    FNMSUB  D24, D7, D16, D7
    FNMADD  H20, H17, H22, H30
    FMOV  H0, H6
    FNMADD  D26, D31, D9, D13
    FMADD  S13, S5, S24, S12
    FMADD  D30, D1, D20, D6
    FMOV  X23, H30
    FMSUB  D10, D28, D4, D0
    FNMADD  S26, S11, S10, S10
    FMOV  H28, W19
    FMADD  H13, H22, H16, H31
    FNMSUB  H22, H25, H25, H18
    FMADD  S8, S0, S25, S9
    FNMADD  D13, D21, D26, D31
    FMOV  H13, W4
    FMOV  H25, X23
    FNMADD  H29, H15, H5, H7
    FMOV  W24, H4
    FMOV  H11, W23
    FNMSUB  H1, H20, H17, H3
    FMADD  H27, H16, H16, H17
    FNMADD  D24, D21, D24, D22
    FMOV  H11, #1.75000000
    FMADD  D22, D3, D19, D5
    FMSUB  H27, H22, H22, H7
    FMOV  H17, H31
    FMOV  D29, D3
    FMSUB  D8, D13, D15, D30
    FMOV  S5, #-4.00000000
    FNMSUB  H21, H4, H29, H9
    FNMADD  D18, D11, D5, D25
    FMOV  D21, D20
    FMSUB  D29, D16, D29, D13
    FMOV  W12, S7
    FMOV  S23, W7
    FMOV  H0, #0.19531250
    FMOV  S17, S27
    FMOV  S0, S18
    FNMADD  H26, H10, H1, H28
    SUBS  X27, X27, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_1619
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xc011, LSL #48
    SUB  X27, X24, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0xfbff, LSL #0
    SUB  X6, X9, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X27, #0xdb7f, LSL #0
    MOVK  X27, #0xfffe, LSL #16
    SUB  X15, X27, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x7c00, LSL #0
    SUB  X21, X3, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X20, #0xfbff, LSL #0
    SUB  X23, X20, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x8000, LSL #0
    SUB  X2, X21, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x7c00, LSL #0
    SUB  X12, X16, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X27, X15, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X15
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x7c00, LSL #0
    SUB  X20, X28, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x8000, LSL #0
    SUB  X2, X8, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0xfb07, LSL #0
    SUB  X4, X28, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
TaishanFpMiniMaxiP01_label_1362:
    SUB  X20, X22, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0xfb07, LSL #0
    SUB  X10, X24, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D2
    MOVZ  X8, #0x8000, LSL #0
    MOVK  X8, #0x8000, LSL #16
    SUB  X23, X8, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
TaishanFpMiniMaxiP01_label_477:
    SUB  X11, X9, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D3
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D4
    MOVZ  X20, #0xfbff, LSL #0
    SUB  X28, X20, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D5
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xc080, LSL #16
    SUB  X15, X7, X6
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D7
    MOVZ  X28, #0x8000, LSL #0
    SUB  X5, X28, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X8, D10
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    SUB  X27, X12, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D11
    MOVZ  X2, #0x3f00, LSL #0
    SUB  X4, X2, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D12
    MOVZ  X15, #0x7c00, LSL #0
    SUB  X8, X15, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D13
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D15
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xbf30, LSL #16
    SUB  X12, X23, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D16
    MOVZ  X22, #0x7e00, LSL #0
    SUB  X6, X22, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D17
    MOVZ  X4, #0xfb06, LSL #0
    SUB  X14, X4, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D18
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    SUB  X2, X15, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D19
    MOVZ  X25, #0xdb7f, LSL #0
    MOVK  X25, #0xfffe, LSL #16
    SUB  X11, X25, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D20
    MOVZ  X26, #0xfbff, LSL #0
    SUB  X7, X26, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X15, D21
    MOVZ  X2, #0xfbff, LSL #0
    SUB  X24, X2, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D22
    MOVZ  X9, #0x5b7f, LSL #0
    SUB  X21, X9, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D23
    MOVZ  X15, #0xdb7f, LSL #0
    MOVK  X15, #0xfffe, LSL #16
    SUB  X20, X15, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X11, D24
    MOVZ  X4, #0x7bff, LSL #0
    MOVK  X4, #0x8000, LSL #48
    SUB  X23, X4, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D26
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D27
    MOVZ  X24, #0xfb06, LSL #0
    SUB  X18, X24, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X3, D28
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
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
TaishanFpMiniMaxiP01_label_1010:
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
    FMOV  D0, X13
    FMOV  V0.D[1], X16
    FMOV  D1, X13
    FMOV  V1.D[1], X11
    FMOV  D2, X20
    FMOV  V2.D[1], X28
    FMOV  D3, X8
    FMOV  V3.D[1], X26
    FMOV  D4, X25
    FMOV  V4.D[1], X10
    FMOV  D5, X9
    FMOV  V5.D[1], X4
    FMOV  D6, X10
    FMOV  V6.D[1], X7
    FMOV  D7, X20
    FMOV  V7.D[1], X24
    FMOV  D8, X15
    FMOV  V8.D[1], X25
    FMOV  D9, X9
    FMOV  V9.D[1], X13
    FMOV  D10, X28
    FMOV  V10.D[1], X23
    FMOV  D11, X22
    FMOV  V11.D[1], X2
    FMOV  D12, X22
    FMOV  V12.D[1], X11
    FMOV  D13, X2
    FMOV  V13.D[1], X8
    FMOV  D14, X27
    FMOV  V14.D[1], X4
    FMOV  D15, X20
    FMOV  V15.D[1], X15
    FMOV  D16, X18
    FMOV  V16.D[1], X11
    FMOV  D17, X14
    FMOV  V17.D[1], X11
    FMOV  D18, X12
    FMOV  V18.D[1], X3
    FMOV  D19, X26
    FMOV  V19.D[1], X8
    FMOV  D20, X14
    FMOV  V20.D[1], X7
    FMOV  D21, X16
    FMOV  V21.D[1], X3
    FMOV  D22, X14
    FMOV  V22.D[1], X8
    FMOV  D23, X8
    FMOV  V23.D[1], X8
    FMOV  D24, X16
    FMOV  V24.D[1], X20
    FMOV  D25, X12
    FMOV  V25.D[1], X27
    FMOV  D26, X11
    FMOV  V26.D[1], X26
    FMOV  D27, X4
    FMOV  V27.D[1], X27
    FMOV  D28, X26
    FMOV  V28.D[1], X25
    FMOV  D29, X17
    FMOV  V29.D[1], X29
    FMOV  D30, X22
    FMOV  V30.D[1], X12
    FMOV  D31, X20
    FMOV  V31.D[1], X20
    MOVZ  X19, #0xf, LSL #0
TaishanFpMiniMaxiP01_label_1703:
    FMOV  W26, S24
    FMADD  S12, S6, S5, S25
    FMOV  D0, D16
    FMOV  H14, W27
    FMADD  S3, S30, S18, S10
    FNMADD  S31, S1, S22, S7
    FMSUB  D17, D16, D22, D11
    FNMSUB  H20, H8, H10, H12
    FMOV  X20, D2
    FMOV  W26, S7
    FMOV  W2, S1
    FMOV  X17, H3
    FMOV  W14, S26
    FNMSUB  D13, D27, D23, D17
    FMOV  X2, D15
    FNMADD  S15, S13, S31, S24
    FMSUB  H15, H18, H3, H8
    FMOV  S16, W7
    FMOV  D4, #8.50000000
    FMOV  H1, W19
    FMOV  X4, H15
    FMOV  W20, S1
    FNMSUB  H15, H22, H19, H5
    FNMADD  D14, D1, D18, D23
    FMADD  D7, D28, D18, D2
    FNMSUB  D30, D8, D0, D16
    FMSUB  S16, S4, S10, S1
    FMSUB  H6, H15, H9, H1
    FMOV  X7, D14
    FMSUB  D16, D17, D7, D18
    FMOV  W12, S14
    FMOV  X28, D27
    FMSUB  H0, H6, H8, H16
    FMADD  S3, S10, S15, S4
    FNMSUB  D25, D20, D15, D0
    FMOV  H8, W7
    FMOV  S16, S8
    FMOV  D18, #0.19531250
    FMOV  D27, D23
    FMOV  S15, S8
    FMOV  X8, H19
    FNMSUB  H24, H3, H15, H6
    FMOV  D1, D25
    FMOV  S17, S28
    FMADD  S0, S20, S11, S23
    FMOV  X8, H1
    FMOV  X23, H11
    FMOV  H28, X12
    FMOV  H16, #5.25000000
    FNMSUB  D13, D5, D11, D2
    FMOV  S28, W6
    FMADD  S17, S31, S0, S2
    FMOV  H16, W2
    FMOV  S0, W10
    FNMSUB  S19, S25, S13, S13
    FMOV  S16, #3.50000000
    FMOV  X8, H29
    FMSUB  D0, D24, D9, D28
    FMOV  X10, H22
    FMOV  W11, H6
    FMOV  S29, #0.14062500
    FMOV  D28, #-1.75000000
    FMOV  H11, X7
    FMOV  H11, W23
    FMOV  D18, X24
    FMOV  W11, S18
    FMADD  D18, D19, D4, D4
    FMSUB  H11, H23, H5, H3
    FMSUB  S25, S0, S11, S6
    FMOV  W23, H12
    FMSUB  D13, D13, D6, D17
    FMADD  H24, H22, H4, H6
    FNMADD  D16, D25, D29, D22
    FMOV  D13, X13
    FMOV  H7, #0.39062500
    FMSUB  D19, D13, D25, D21
    FMOV  S18, W10
    FMOV  X5, D27
    FMOV  X26, H5
    FMOV  D27, #-3.62500000
    FMSUB  D8, D26, D28, D10
    FNMADD  S15, S5, S17, S25
    FMOV  X7, D28
    FNMSUB  D25, D24, D26, D31
    FMOV  S4, #-0.50000000
    FNMSUB  D18, D16, D26, D31
    FMOV  S27, #16.00000000
    FNMADD  H2, H12, H12, H1
    FMOV  H13, W21
    FNMSUB  D17, D12, D21, D4
    FMSUB  H18, H4, H21, H8
    FMOV  S3, #-1.25000000
    FMOV  X11, D3
    FMADD  S6, S8, S13, S15
    FMOV  W8, S1
    FNMSUB  H27, H25, H16, H5
    FNMADD  H30, H4, H4, H0
    FMOV  W23, S10
    FMOV  D6, D10
    FMOV  W8, S4
    FMOV  H14, H11
    FMADD  D26, D7, D27, D24
    FNMSUB  D1, D11, D3, D14
    FMSUB  S26, S18, S10, S20
    FNMADD  H5, H15, H30, H23
    FMOV  S11, W26
    FMOV  S16, #8.50000000
    FMOV  H9, X23
    FMSUB  H0, H23, H26, H27
    FMOV  H0, #-10.00000000
    FMOV  H13, H6
    FNMSUB  D18, D4, D13, D14
    FMOV  X17, H12
    FMOV  X8, H14
    FMOV  S6, W27
    FMADD  D31, D7, D1, D13
    FMOV  X24, D25
    FMOV  S23, S4
    FMOV  H4, W24
    FMOV  W5, S1
    FMADD  H1, H6, H4, H7
    FMOV  H6, #-0.53125000
    FMOV  S25, W27
    FMOV  D19, #5.75000000
    FNMADD  H23, H22, H20, H18
    FMADD  H31, H7, H3, H15
    FMOV  S5, #2.87500000
    FMADD  D7, D26, D0, D1
    FMADD  D13, D9, D12, D22
    FMOV  H8, #2.25000000
    FMOV  S4, #-1.25000000
    FMOV  X16, D4
    FNMADD  S16, S11, S11, S12
    FMOV  X4, H24
    FMOV  S23, W9
    FMOV  D24, X7
    FMADD  H9, H22, H21, H14
    FNMADD  S18, S4, S9, S17
    FMOV  D23, #19.00000000
    FMADD  H15, H16, H6, H26
    FMOV  D4, X27
    FMADD  S11, S14, S23, S12
    FNMSUB  D3, D8, D16, D17
    FMOV  X16, H26
    FNMADD  H17, H21, H28, H6
    FMOV  H10, X20
    FMOV  S13, W18
    FMOV  D13, #-0.56250000
TaishanFpMiniMaxiP01_label_847:
    FMOV  H24, #-8.50000000
    FMOV  H2, X19
    FMOV  D4, X16
    FNMADD  H25, H16, H1, H20
    FMOV  H29, W17
    FMOV  H14, H13
    FMOV  S28, S21
    FMSUB  D15, D15, D24, D2
    FMOV  D22, X26
    FMADD  D23, D12, D2, D18
    FMOV  S17, #0.12500000
    FMOV  D18, D31
    FMSUB  D22, D19, D9, D10
    FNMSUB  S18, S8, S17, S19
    FMOV  D19, D9
    FMOV  X11, D9
    FMOV  H19, H14
    FNMSUB  H26, H5, H26, H29
    FNMADD  D11, D7, D31, D10
    FMADD  S8, S4, S28, S6
    FMOV  H31, X13
    FMOV  D8, D18
    FNMADD  S25, S8, S16, S14
    FMOV  W2, H17
    FNMADD  H2, H23, H0, H5
    FMADD  D26, D8, D16, D0
    FMOV  D2, D27
    FMOV  W4, H29
    FNMADD  H15, H0, H14, H17
    FMOV  D30, X12
    FMOV  H15, X27
    FMOV  X7, H15
    FMOV  H19, X21
    FMSUB  S2, S0, S22, S5
    FMOV  H29, #0.15625000
    FMOV  S18, #-0.15625000
    FMADD  D8, D14, D23, D10
    FMOV  X17, D2
    FNMSUB  H17, H23, H9, H17
    FNMSUB  H25, H10, H2, H20
    FMADD  H18, H12, H30, H5
    FMADD  H21, H28, H25, H17
    FNMADD  S24, S7, S5, S22
    FNMSUB  S3, S18, S18, S29
    FMOV  W10, S8
    FMADD  D27, D8, D20, D6
    FMSUB  D4, D2, D6, D19
    FMOV  H7, H17
    FMOV  H12, X15
    FMOV  D29, X22
    FMOV  X27, D29
    FMSUB  H31, H8, H17, H14
    SUBS  X19, X19, #0x1
    B.NE  TaishanFpMiniMaxiP01_label_1703
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
TaishanFpMiniMaxiP01_label_220:
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X6, X4, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X16, X26, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x1, LSL #0
    SUB  X20, X3, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X27, X7, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X26, #0xc901, LSL #0
    SUB  X17, X26, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X6, #0x2, LSL #0
    SUB  X24, X6, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X14, X15, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X3, #0xc901, LSL #0
    SUB  X5, X3, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanFpMiniMaxiP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D2
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x4038, LSL #16
    SUB  X15, X28, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D3
    MOVZ  X5, #0x3100, LSL #0
    MOVK  X5, #0x8000, LSL #16
    SUB  X6, X5, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X16, D4
    MOVZ  X3, #0xffff, LSL #0
    SUB  X24, X3, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D5
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x4038, LSL #16
    SUB  X14, X8, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D6
    MOVZ  X29, #0xb840, LSL #0
    SUB  X2, X29, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D7
    MOVZ  X19, #0xffff, LSL #0
    SUB  X21, X19, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X18, D8
    MOVZ  X29, #0x1, LSL #0
    SUB  X4, X29, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X28, D9
    MOVZ  X3, #0xffff, LSL #0
    SUB  X4, X3, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D10
    MOVZ  X7, #0x1, LSL #0
    SUB  X2, X7, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X6, D11
    MOVZ  X14, #0x1, LSL #0
    MOVK  X14, #0x8000, LSL #48
    SUB  X20, X14, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D12
    MOVZ  X4, #0xffff, LSL #0
    SUB  X14, X4, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X23, D13
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xbfe2, LSL #48
    SUB  X7, X9, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X5, D14
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X26, D15
    MOVZ  X16, #0xffff, LSL #0
    SUB  X6, X16, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X13, D16
    MOVZ  X11, #0xfa0f, LSL #0
    MOVK  X11, #0x8002, LSL #16
    SUB  X23, X11, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X25, D17
    MOVZ  X5, #0xffff, LSL #0
    SUB  X12, X5, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X12, D18
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D19
    MOVZ  X4, #0xffff, LSL #0
    SUB  X5, X4, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X10, D20
    MOVZ  X27, #0x7a0f, LSL #0
    SUB  X23, X27, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X29, D21
    MOVZ  X17, #0xffff, LSL #0
    SUB  X16, X17, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X24, D22
    MOVZ  X14, #0xbff9, LSL #0
    MOVK  X14, #0x5, LSL #16
    MOVK  X14, #0x8000, LSL #48
    SUB  X5, X14, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X4, D23
    MOVZ  X12, #0x1, LSL #0
    MOVK  X12, #0x3f00, LSL #16
    SUB  X10, X12, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D24
    MOVZ  X14, #0x9ff9, LSL #0
    MOVK  X14, #0x8008, LSL #16
    SUB  X10, X14, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X7, D25
    MOVZ  X3, #0xfa0f, LSL #0
    SUB  X4, X3, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X19, D26
    MOVZ  X12, #0xc901, LSL #0
    SUB  X11, X12, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X17, D27
    MOVZ  X2, #0xb841, LSL #0
    SUB  X14, X2, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X22, D28
    MOVZ  X9, #0xffff, LSL #0
    SUB  X8, X9, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail
    FMOV  X20, D29
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X26, X19, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanFpMiniMaxiP01_TestFail

TaishanFpMiniMaxiP01_TestEnd:
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
TaishanFpMiniMaxiP01_TestFail:
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