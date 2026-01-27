.global FpsimdLoadStoreP01

.text
.p2align 4

FpsimdLoadStoreP01:

FpsimdLoadStoreP01_TestBegin:
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
    MOVZ  X2, #0x3fd1, LSL #0
    MOVK  X2, #0x84d3, LSL #16
    MOVK  X2, #0xf6a7, LSL #32
    MOVK  X2, #0x4e9b, LSL #48
    MOVZ  X3, #0x4624, LSL #0
    MOVK  X3, #0x1d46, LSL #16
    MOVK  X3, #0xac26, LSL #32
    MOVK  X3, #0x89a8, LSL #48
    MOVZ  X5, #0x4f48, LSL #0
    MOVK  X5, #0x5dd0, LSL #16
    MOVK  X5, #0xfe31, LSL #32
    MOVK  X5, #0xfb81, LSL #48
    MOVZ  X6, #0x6a9b, LSL #0
    MOVK  X6, #0x54b4, LSL #16
    MOVK  X6, #0xadf7, LSL #32
    MOVK  X6, #0xdc03, LSL #48
    MOVZ  X7, #0x70df, LSL #0
    MOVK  X7, #0x9ff4, LSL #16
    MOVK  X7, #0x3f57, LSL #32
    MOVK  X7, #0xc7a, LSL #48
    MOVZ  X8, #0xe2a2, LSL #0
    MOVK  X8, #0x567a, LSL #16
    MOVK  X8, #0x60f6, LSL #32
    MOVK  X8, #0x52ba, LSL #48
    MOVZ  X9, #0xe9b, LSL #0
    MOVK  X9, #0xfaf5, LSL #16
    MOVK  X9, #0x309c, LSL #32
    MOVK  X9, #0xd4e7, LSL #48
    MOVZ  X10, #0xb9ed, LSL #0
    MOVK  X10, #0xf1d, LSL #16
    MOVK  X10, #0x1113, LSL #32
    MOVK  X10, #0x1ddb, LSL #48
    MOVZ  X11, #0xb800, LSL #0
    MOVK  X11, #0xe257, LSL #16
    MOVK  X11, #0x2b9d, LSL #32
    MOVK  X11, #0xc01d, LSL #48
    MOVZ  X14, #0xe, LSL #0
    MOVK  X14, #0x1162, LSL #16
    MOVK  X14, #0xb0f6, LSL #32
    MOVK  X14, #0x6cbb, LSL #48
    MOVZ  X15, #0xbdff, LSL #0
    MOVK  X15, #0xbceb, LSL #16
    MOVK  X15, #0x813f, LSL #32
    MOVK  X15, #0x8354, LSL #48
    MOVZ  X16, #0x7b29, LSL #0
    MOVK  X16, #0x4551, LSL #16
    MOVK  X16, #0xf93b, LSL #32
    MOVK  X16, #0xa936, LSL #48
    MOVZ  X17, #0xa5c6, LSL #0
    MOVK  X17, #0x7783, LSL #16
    MOVK  X17, #0x98c3, LSL #32
    MOVK  X17, #0x70bd, LSL #48
    MOVZ  X18, #0xfb4d, LSL #0
    MOVK  X18, #0xb612, LSL #16
    MOVK  X18, #0x3c5e, LSL #32
    MOVK  X18, #0x28aa, LSL #48
    MOVZ  X19, #0x34e4, LSL #0
    MOVK  X19, #0x313e, LSL #16
    MOVK  X19, #0xdcf7, LSL #32
    MOVK  X19, #0x9fc9, LSL #48
    MOVZ  X20, #0x84e, LSL #0
    MOVK  X20, #0xe052, LSL #16
    MOVK  X20, #0xb2c3, LSL #32
    MOVK  X20, #0xb888, LSL #48
    MOVZ  X21, #0xd0da, LSL #0
    MOVK  X21, #0xd770, LSL #16
    MOVK  X21, #0xc440, LSL #32
    MOVK  X21, #0xf99c, LSL #48
    MOVZ  X22, #0x5443, LSL #0
    MOVK  X22, #0x377f, LSL #16
    MOVK  X22, #0xaa73, LSL #32
    MOVK  X22, #0x7d14, LSL #48
    MOVZ  X23, #0x2f58, LSL #0
    MOVK  X23, #0xadb3, LSL #16
    MOVK  X23, #0x7681, LSL #32
    MOVK  X23, #0x375a, LSL #48
    MOVZ  X25, #0x4504, LSL #0
    MOVK  X25, #0xa3de, LSL #16
    MOVK  X25, #0x8128, LSL #32
    MOVK  X25, #0x1205, LSL #48
    MOVZ  X26, #0x24ca, LSL #0
    MOVK  X26, #0x1022, LSL #16
    MOVK  X26, #0x9dbf, LSL #32
    MOVK  X26, #0xeddd, LSL #48
    MOVZ  X27, #0xb382, LSL #0
    MOVK  X27, #0x7bb1, LSL #16
    MOVK  X27, #0xcf1d, LSL #32
    MOVK  X27, #0xca88, LSL #48
    MOVZ  X28, #0xb40c, LSL #0
    MOVK  X28, #0xe9ec, LSL #16
    MOVK  X28, #0x9fd9, LSL #32
    MOVK  X28, #0xd9da, LSL #48
    MOVZ  X29, #0xc0c7, LSL #0
    MOVK  X29, #0x92d8, LSL #16
    MOVK  X29, #0x10cd, LSL #32
    MOVK  X29, #0xe18f, LSL #48
    MOVZ  X29, #0x6cdf, LSL #0
    MOVK  X29, #0x9dff, LSL #16
    MOVK  X29, #0x3b23, LSL #32
    MOVK  X29, #0x1121, LSL #48
    MSR  FPCR, X29
    MOVZ  X29, #0x33f8, LSL #0
    MOVK  X29, #0xbf33, LSL #16
    MOVK  X29, #0x1f09, LSL #32
    MOVK  X29, #0xca99, LSL #48
    MSR  FPSR, X29
    MRS  X11, FPSR
    MOVZ  X22, #0xff60, LSL #0
    MOVK  X22, #0x7ff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    AND  X11, X11, X22
    MOVZ  X22, #0x0, LSL #0
    ORR  X11, X11, X22
    MSR  FPSR, X11
    ISB  SY
    SUBS  W16, W3, W27, ASR #24
    MOV  X30, X1
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X23
    FMOV  D3, X3
    FMOV  V3.D[1], X28
    FMOV  D4, X3
    FMOV  V4.D[1], X8
    FMOV  D5, X7
    FMOV  V5.D[1], X27
    FMOV  D6, X6
    FMOV  V6.D[1], X22
    FMOV  D7, X14
    FMOV  V7.D[1], X23
    FMOV  D8, X26
    FMOV  V8.D[1], X25
    FMOV  D9, X22
    FMOV  V9.D[1], X20
    FMOV  D10, X28
    FMOV  V10.D[1], X2
    FMOV  D11, X14
    FMOV  V11.D[1], X15
    FMOV  D12, X5
    FMOV  V12.D[1], X7
    FMOV  D13, X25
    FMOV  V13.D[1], X14
    FMOV  D14, X26
    FMOV  V14.D[1], X10
    FMOV  D15, X3
    FMOV  V15.D[1], X21
    FMOV  D16, X22
    FMOV  V16.D[1], X29
    FMOV  D17, X17
    FMOV  V17.D[1], X7
    FMOV  D18, X19
    FMOV  V18.D[1], X8
    FMOV  D19, X15
    FMOV  V19.D[1], X2
    FMOV  D20, X17
    FMOV  V20.D[1], X28
    FMOV  D21, X23
    FMOV  V21.D[1], X11
    FMOV  D22, X27
    FMOV  V22.D[1], X21
    FMOV  D23, X28
    FMOV  V23.D[1], X2
    FMOV  D24, X16
    FMOV  V24.D[1], X7
    FMOV  D25, X15
    FMOV  V25.D[1], X19
    FMOV  D26, X21
    FMOV  V26.D[1], X22
    FMOV  D27, X22
    FMOV  V27.D[1], X17
    FMOV  D28, X17
    FMOV  V28.D[1], X21
    FMOV  D29, X17
    FMOV  V29.D[1], X28
    FMOV  D30, X7
    FMOV  V30.D[1], X18
    FMOV  D31, X15
    FMOV  V31.D[1], X11
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X15, #0x20, LSL #0
    MOVZ  X5, #0x0, LSL #0
    ADD  X3, X30, X5
    STNP  Q29, Q25, [X3, #0]
    LDNP  Q9, Q14, [X3, #0]
    ADD  X3, X3, X15
    STNP  S14, S9, [X3, #0]
    LDNP  S14, S1, [X3, #0]
    ADD  X3, X3, X15
    STNP  D26, D30, [X3, #0]
    LDNP  D13, D6, [X3, #0]
    ADD  X3, X3, X15
    STP  Q31, Q31, [X3], #0
    LDP  Q30, Q26, [X3], #0
    ADD  X3, X3, X15, LSR #0
    STP  S1, S14, [X3], #0
    LDP  S29, S26, [X3], #0
    ADD  X3, X3, X15, LSR #0
    STP  D26, D6, [X3], #0
    LDP  D6, D22, [X3], #0
    ADD  X3, X3, X15, LSR #0
    STP  Q30, Q30, [X3, #0]!
    LDP  Q24, Q17, [X3, #0]!
    ADD  X3, X3, X15, ASR #0
    STP  S16, S29, [X3, #0]!
    LDP  S10, S19, [X3, #0]!
    ADD  X3, X3, X15, LSR #0
    STP  D17, D13, [X3, #0]!
    LDP  D26, D28, [X3, #0]!
    ADD  X3, X3, X15, ASR #0
    STP  Q25, Q24, [X3, #0]
    LDP  Q15, Q24, [X3, #0]
    ADD  X3, X3, X15
    STP  S6, S7, [X3, #0]
    LDP  S15, S3, [X3, #0]
    ADD  X3, X3, X15
    STP  D10, D22, [X3, #0]
    LDP  D14, D5, [X3, #0]
    ADD  X3, X3, X15, ASR #0
    STR  Q14, [X3], #0
    LDR  Q13, [X3], #0
    ADD  X3, X3, X15, ASR #0
    STR  H28, [X3], #0
    LDR  H12, [X3], #0
    ADD  X3, X3, X15, LSR #0
    STR  S24, [X3], #0
    LDR  S8, [X3], #0
    ADD  X3, X3, X15, LSR #0
    STR  D8, [X3], #0
    LDR  D1, [X3], #0
    ADD  X3, X3, X15
    STR  B19, [X3], #0
    LDR  B14, [X3], #0
    ADD  X3, X3, X15
    STR  Q26, [X3, #0]!
    LDR  Q21, [X3, #0]!
    ADD  X3, X3, X15
    STR  H21, [X3, #0]!
    LDR  H0, [X3, #0]!
    ADD  X3, X3, X15, LSR #0
    STR  S3, [X3, #0]!
    LDR  S24, [X3, #0]!
    ADD  X3, X3, X15, ASR #0
    STR  D0, [X3, #0]!
    LDR  D2, [X3, #0]!
    ADD  X3, X3, X15
    STR  B1, [X3, #0]!
    LDR  B4, [X3, #0]!
    ADD  X3, X3, X15
    STR  Q24, [X3, #0]
    LDR  Q31, [X3, #0]
    ADD  X3, X3, X15, ASR #0
    STR  H14, [X3, #0]
    LDR  H17, [X3, #0]
    ADD  X3, X3, X15, LSR #0
    STR  S31, [X3, #0]
    LDR  S20, [X3, #0]
    ADD  X3, X3, X15, ASR #0
    STR  D20, [X3, #0]
    LDR  D11, [X3, #0]
    ADD  X3, X3, X15, LSR #0
    STR  B11, [X3, #0]
    LDR  B8, [X3, #0]
    ADD  X3, X3, X15, LSR #0
    STR Q4, [X3, X9, LSL #0]
    LDR Q21, [X3, X9, LSL #0]
    ADD  X3, X3, X15
    STR Q2, [X3, W9, SXTW #0]
    LDR Q0, [X3, W9, SXTW #4]
    ADD  X3, X3, X15
    STR Q17, [X3, X9, SXTX #4]
    LDR Q26, [X3, X9, SXTX #0]
    ADD  X3, X3, X15
    STR Q26, [X3, W9, UXTW #0]
    LDR Q20, [X3, W9, UXTW #4]
    ADD  X3, X3, X15, ASR #0
    STR H20, [X3, X9, LSL #0]
    LDR H25, [X3, X9, LSL #1]
    ADD  X3, X3, X15, ASR #0
    STR H25, [X3, W9, SXTW #1]
    LDR H5, [X3, W9, SXTW #0]
    ADD  X3, X3, X15
    STR H8, [X3, X9, SXTX #1]
    LDR H21, [X3, X9, SXTX #1]
    ADD  X3, X3, X15, LSR #0
    STR H0, [X3, W9, UXTW #0]
    LDR H9, [X3, W9, UXTW #0]
    ADD  X3, X3, X15, ASR #0
    STR S5, [X3, X9, LSL #2]
    LDR S14, [X3, X9, LSL #2]
    ADD  X3, X3, X15, ASR #0
    STR S21, [X3, W9, SXTW #2]
    LDR S16, [X3, W9, SXTW #0]
    ADD  X3, X3, X15
    STR S9, [X3, X9, SXTX #2]
    LDR S28, [X3, X9, SXTX #2]
    ADD  X3, X3, X15
    STR S9, [X3, W9, UXTW #2]
    LDR S10, [X3, W9, UXTW #0]
    ADD  X3, X3, X15, LSR #0
    STR D14, [X3, X9, LSL #0]
    LDR D7, [X3, X9, LSL #0]
    ADD  X3, X3, X15
    STR D10, [X3, W9, SXTW #3]
    LDR D31, [X3, W9, SXTW #3]
    ADD  X3, X3, X15, LSR #0
    STR D28, [X3, X9, SXTX #0]
    LDR D11, [X3, X9, SXTX #0]
    ADD  X3, X3, X15
    STR D11, [X3, W9, UXTW #0]
    LDR D29, [X3, W9, UXTW #0]
    ADD  X3, X3, X15, ASR #0
    STR B29, [X3, X9, LSL #0]
    LDR B18, [X3, X9, LSL #0]
    ADD  X3, X3, X15, ASR #0
    STR B31, [X3, W9, SXTW #0]
    LDR B8, [X3, W9, SXTW #0]
    ADD  X3, X3, X15, ASR #0
    STR B18, [X3, X9, SXTX #0]
    LDR B16, [X3, X9, SXTX #0]
    ADD  X3, X3, X15
    STR B7, [X3, W9, UXTW #0]
    LDR B12, [X3, W9, UXTW #0]
    ADD  X3, X3, X15, ASR #0
    STUR  Q12, [X3, #0]
    LDUR  Q20, [X3, #0]
    ADD  X3, X3, X15
    STUR  H8, [X3, #0]
    LDUR  H26, [X3, #0]
    ADD  X3, X3, X15
    STUR  S16, [X3, #0]
    LDUR  S17, [X3, #0]
    ADD  X3, X3, X15, ASR #0
    STUR  D20, [X3, #0]
    LDUR  D4, [X3, #0]
    ADD  X3, X3, X15, ASR #0
    STUR  B21, [X3, #0]
    LDUR  B5, [X3, #0]
    ADD  X3, X3, X15, ASR #0
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V0.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    FMOV  X11, D0
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X11, D1
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    FMOV  X11, D2
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X11, D3
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D4
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V5.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D5
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V6.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X11, D6
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D7
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D8
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V9.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    FMOV  X11, D9
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    FMOV  X11, D10
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    FMOV  X11, D11
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D12
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X11, D13
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D14
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X11, D15
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D16
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D17
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V18.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D18
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X11, D19
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D20
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D21
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D22
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V23.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D23
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X11, D24
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D25
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X11, D26
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V27.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D27
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    FMOV  X11, D28
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    FMOV  X11, D29
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V30.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D30
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    FMOV  X11, D31
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X28
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X6
    FMOV  V2.D[1], X27
    FMOV  D3, X17
    FMOV  V3.D[1], X26
    FMOV  D4, X5
    FMOV  V4.D[1], X25
    FMOV  D5, X28
    FMOV  V5.D[1], X28
    FMOV  D6, X21
    FMOV  V6.D[1], X7
    FMOV  D7, X18
    FMOV  V7.D[1], X11
    FMOV  D8, X17
    FMOV  V8.D[1], X8
    FMOV  D9, X11
    FMOV  V9.D[1], X14
    FMOV  D10, X21
    FMOV  V10.D[1], X14
    FMOV  D11, X28
    FMOV  V11.D[1], X25
    FMOV  D12, X7
    FMOV  V12.D[1], X9
    FMOV  D13, X25
    FMOV  V13.D[1], X2
    FMOV  D14, X8
    FMOV  V14.D[1], X15
    FMOV  D15, X11
    FMOV  V15.D[1], X7
    FMOV  D16, X16
    FMOV  V16.D[1], X11
    FMOV  D17, X18
    FMOV  V17.D[1], X29
    FMOV  D18, X21
    FMOV  V18.D[1], X28
    FMOV  D19, X20
    FMOV  V19.D[1], X21
    FMOV  D20, X28
    FMOV  V20.D[1], X5
    FMOV  D21, X27
    FMOV  V21.D[1], X9
    FMOV  D22, X18
    FMOV  V22.D[1], X7
    FMOV  D23, X11
    FMOV  V23.D[1], X14
    FMOV  D24, X7
    FMOV  V24.D[1], X21
    FMOV  D25, X15
    FMOV  V25.D[1], X17
    FMOV  D26, X6
    FMOV  V26.D[1], X17
    FMOV  D27, X17
    FMOV  V27.D[1], X15
    FMOV  D28, X21
    FMOV  V28.D[1], X6
    FMOV  D29, X26
    FMOV  V29.D[1], X27
    FMOV  D30, X15
    FMOV  V30.D[1], X2
    FMOV  D31, X19
    FMOV  V31.D[1], X16
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X27, #0x20, LSL #0
    MOVZ  X14, #0x500, LSL #0
    ADD  X25, X30, X14, ASR #0
    STNP  Q24, Q29, [X25, #0]
    LDNP  Q7, Q30, [X25, #0]
    ADD  X25, X25, X27, ASR #0
    STNP  S31, S26, [X25, #0]
    LDNP  S17, S29, [X25, #0]
    ADD  X25, X25, X27
    STNP  D17, D25, [X25, #0]
    LDNP  D1, D4, [X25, #0]
    ADD  X25, X25, X27
    STP  Q28, Q23, [X25], #0
    LDP  Q1, Q22, [X25], #0
    ADD  X25, X25, X27, ASR #0
    STP  S30, S29, [X25], #0
    LDP  S30, S4, [X25], #0
    ADD  X25, X25, X27, LSR #0
    STP  D1, D27, [X25], #0
    LDP  D24, D4, [X25], #0
    ADD  X25, X25, X27, LSR #0
    STP  Q4, Q30, [X25, #0]!
    LDP  Q21, Q31, [X25, #0]!
    ADD  X25, X25, X27, ASR #0
    STP  S31, S7, [X25, #0]!
    LDP  S2, S23, [X25, #0]!
    ADD  X25, X25, X27, ASR #0
    STP  D22, D24, [X25, #0]!
    LDP  D2, D23, [X25, #0]!
    ADD  X25, X25, X27, LSR #0
    STP  Q29, Q21, [X25, #0]
    LDP  Q8, Q19, [X25, #0]
    ADD  X25, X25, X27, LSR #0
    STP  S19, S2, [X25, #0]
    LDP  S7, S24, [X25, #0]
    ADD  X25, X25, X27
    STP  D8, D23, [X25, #0]
    LDP  D29, D21, [X25, #0]
    ADD  X25, X25, X27, ASR #0
    STR  Q29, [X25], #0
    LDR  Q22, [X25], #0
    ADD  X25, X25, X27
    STR  H12, [X25], #0
    LDR  H31, [X25], #0
    ADD  X25, X25, X27, LSR #0
    STR  S21, [X25], #0
    LDR  S12, [X25], #0
    ADD  X25, X25, X27, ASR #0
    STR  D17, [X25], #0
    LDR  D8, [X25], #0
    ADD  X25, X25, X27, ASR #0
    STR  B24, [X25], #0
    LDR  B17, [X25], #0
    ADD  X25, X25, X27, ASR #0
    STR  Q8, [X25, #0]!
    LDR  Q23, [X25, #0]!
    ADD  X25, X25, X27, LSR #0
    STR  H7, [X25, #0]!
    LDR  H29, [X25, #0]!
    ADD  X25, X25, X27
    STR  S31, [X25, #0]!
    LDR  S7, [X25, #0]!
    ADD  X25, X25, X27, LSR #0
    STR  D7, [X25, #0]!
    LDR  D21, [X25, #0]!
    ADD  X25, X25, X27, LSR #0
    STR  B23, [X25, #0]!
    LDR  B24, [X25, #0]!
    ADD  X25, X25, X27
    STR  Q24, [X25, #0]
    LDR  Q8, [X25, #0]
    ADD  X25, X25, X27
    STR  H29, [X25, #0]
    LDR  H7, [X25, #0]
    ADD  X25, X25, X27, ASR #0
    STR  S8, [X25, #0]
    LDR  S23, [X25, #0]
    ADD  X25, X25, X27, ASR #0
    STR  D21, [X25, #0]
    LDR  D8, [X25, #0]
    ADD  X25, X25, X27, LSR #0
    STR  B17, [X25, #0]
    LDR  B31, [X25, #0]
    ADD  X25, X25, X27, ASR #0
    STR Q23, [X25, X29, LSL #4]
    LDR Q24, [X25, X29, LSL #4]
    ADD  X25, X25, X27
    STR Q31, [X25, W29, SXTW #0]
    LDR Q23, [X25, W29, SXTW #4]
    ADD  X25, X25, X27, LSR #0
    STR Q24, [X25, X29, SXTX #0]
    LDR Q21, [X25, X29, SXTX #0]
    ADD  X25, X25, X27, LSR #0
    STR Q7, [X25, W29, UXTW #4]
    LDR Q31, [X25, W29, UXTW #0]
    ADD  X25, X25, X27, ASR #0
    STR H8, [X25, X29, LSL #1]
    LDR H24, [X25, X29, LSL #1]
    ADD  X25, X25, X27, LSR #0
    STR H24, [X25, W29, SXTW #1]
    LDR H17, [X25, W29, SXTW #0]
    ADD  X25, X25, X27
    STR H29, [X25, X29, SXTX #1]
    LDR H29, [X25, X29, SXTX #0]
    ADD  X25, X25, X27
    STR H29, [X25, W29, UXTW #1]
    LDR H7, [X25, W29, UXTW #1]
    ADD  X25, X25, X27
    STR S7, [X25, X29, LSL #2]
    LDR S8, [X25, X29, LSL #0]
    ADD  X25, X25, X27, ASR #0
    STR S23, [X25, W29, SXTW #0]
    LDR S23, [X25, W29, SXTW #0]
    ADD  X25, X25, X27
    STR S31, [X25, X29, SXTX #2]
    LDR S24, [X25, X29, SXTX #2]
    ADD  X25, X25, X27
    STR S17, [X25, W29, UXTW #0]
    LDR S17, [X25, W29, UXTW #2]
    ADD  X25, X25, X27, LSR #0
    STR D8, [X25, X29, LSL #0]
    LDR D29, [X25, X29, LSL #0]
    ADD  X25, X25, X27, LSR #0
    STR D29, [X25, W29, SXTW #3]
    LDR D31, [X25, W29, SXTW #0]
    ADD  X25, X25, X27
    STR D1, [X25, X29, SXTX #0]
    LDR D29, [X25, X29, SXTX #3]
    ADD  X25, X25, X27
    STR D14, [X25, W29, UXTW #0]
    LDR D8, [X25, W29, UXTW #0]
    ADD  X25, X25, X27
    STR B8, [X25, X29, LSL #0]
    LDR B8, [X25, X29, LSL #0]
    ADD  X25, X25, X27, LSR #0
    STR B8, [X25, W29, SXTW #0]
    LDR B8, [X25, W29, SXTW #0]
    ADD  X25, X25, X27, LSR #0
    STR B29, [X25, X29, SXTX #0]
    LDR B14, [X25, X29, SXTX #0]
    ADD  X25, X25, X27, LSR #0
    STR B17, [X25, W29, UXTW #0]
    LDR B11, [X25, W29, UXTW #0]
    ADD  X25, X25, X27
    STUR  Q31, [X25, #0]
    LDUR  Q30, [X25, #0]
    ADD  X25, X25, X27, ASR #0
    STUR  H11, [X25, #0]
    LDUR  H11, [X25, #0]
    ADD  X25, X25, X27, ASR #0
    STUR  S11, [X25, #0]
    LDUR  S10, [X25, #0]
    ADD  X25, X25, X27, LSR #0
    STUR  D24, [X25, #0]
    LDUR  D5, [X25, #0]
    ADD  X25, X25, X27
    STUR  B14, [X25, #0]
    LDUR  B3, [X25, #0]
    ADD  X25, X25, X27, LSR #0
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X11, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V0.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D0
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V1.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D1
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D2
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X11, D3
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D4
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V5.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    FMOV  X11, D5
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V6.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D6
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    FMOV  X11, D7
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X11, D8
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V9.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D9
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X11, D10
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X11, D11
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    FMOV  X11, D12
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V13.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D13
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X11, D14
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V15.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D15
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V16.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D16
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    FMOV  X11, D17
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V18.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D18
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D19
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V20.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D20
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X11, D21
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    FMOV  X11, D22
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X11, D23
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    FMOV  X11, D24
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V25.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D25
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V26.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D26
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V27.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D27
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, V28.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D28
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X11, D29
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    FMOV  X11, D30
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    FMOV  X11, D31
    SUB  X28, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X11
    FMOV  D4, X6
    FMOV  V4.D[1], X5
    FMOV  D5, X28
    FMOV  V5.D[1], X22
    FMOV  D6, X11
    FMOV  V6.D[1], X6
    FMOV  D7, X21
    FMOV  V7.D[1], X17
    FMOV  D8, X5
    FMOV  V8.D[1], X7
    FMOV  D9, X29
    FMOV  V9.D[1], X25
    FMOV  D10, X11
    FMOV  V10.D[1], X5
    FMOV  D11, X29
    FMOV  V11.D[1], X26
    FMOV  D12, X19
    FMOV  V12.D[1], X6
    FMOV  D13, X20
    FMOV  V13.D[1], X25
    FMOV  D14, X29
    FMOV  V14.D[1], X21
    FMOV  D15, X3
    FMOV  V15.D[1], X14
    FMOV  D16, X11
    FMOV  V16.D[1], X7
    FMOV  D17, X22
    FMOV  V17.D[1], X11
    FMOV  D18, X18
    FMOV  V18.D[1], X29
    FMOV  D19, X26
    FMOV  V19.D[1], X23
    FMOV  D20, X15
    FMOV  V20.D[1], X26
    FMOV  D21, X15
    FMOV  V21.D[1], X20
    FMOV  D22, X15
    FMOV  V22.D[1], X3
    FMOV  D23, X2
    FMOV  V23.D[1], X8
    FMOV  D24, X21
    FMOV  V24.D[1], X20
    FMOV  D25, X29
    FMOV  V25.D[1], X25
    FMOV  D26, X6
    FMOV  V26.D[1], X19
    FMOV  D27, X25
    FMOV  V27.D[1], X28
    FMOV  D28, X23
    FMOV  V28.D[1], X5
    FMOV  D29, X11
    FMOV  V29.D[1], X28
    FMOV  D30, X22
    FMOV  V30.D[1], X11
    FMOV  D31, X18
    FMOV  V31.D[1], X2
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X19, #0x20, LSL #0
    MOVZ  X29, #0xa00, LSL #0
    ADD  X8, X30, X29, LSR #0
    STNP  Q29, Q25, [X8, #0]
    LDNP  Q26, Q15, [X8, #0]
    ADD  X8, X8, X19, LSR #0
    STNP  S27, S31, [X8, #0]
    LDNP  S23, S27, [X8, #0]
    ADD  X8, X8, X19
    STNP  D22, D28, [X8, #0]
    LDNP  D25, D29, [X8, #0]
    ADD  X8, X8, X19, LSR #0
    STP  Q24, Q30, [X8], #0
    LDP  Q31, Q26, [X8], #0
    ADD  X8, X8, X19, ASR #0
    STP  S27, S31, [X8], #0
    LDP  S6, S15, [X8], #0
    ADD  X8, X8, X19, LSR #0
    STP  D26, D6, [X8], #0
    LDP  D6, D29, [X8], #0
    ADD  X8, X8, X19
    STP  Q6, Q23, [X8, #0]!
    LDP  Q14, Q15, [X8, #0]!
    ADD  X8, X8, X19, LSR #0
    STP  S14, S25, [X8, #0]!
    LDP  S3, S9, [X8, #0]!
    ADD  X8, X8, X19
    STP  D15, D3, [X8, #0]!
    LDP  D22, D26, [X8, #0]!
    ADD  X8, X8, X19, LSR #0
    STP  Q27, Q9, [X8, #0]
    LDP  Q3, Q18, [X8, #0]
    ADD  X8, X8, X19, ASR #0
    STP  S26, S29, [X8, #0]
    LDP  S16, S12, [X8, #0]
    ADD  X8, X8, X19, LSR #0
    STP  D3, D26, [X8, #0]
    LDP  D30, D16, [X8, #0]
    ADD  X8, X8, X19
    STR  Q12, [X8], #0
    LDR  Q7, [X8], #0
    ADD  X8, X8, X19
    STR  H7, [X8], #0
    LDR  H29, [X8], #0
    ADD  X8, X8, X19
    STR  S29, [X8], #0
    LDR  S9, [X8], #0
    ADD  X8, X8, X19, LSR #0
    STR  D22, [X8], #0
    LDR  D5, [X8], #0
    ADD  X8, X8, X19, ASR #0
    STR  B30, [X8], #0
    LDR  B27, [X8], #0
    ADD  X8, X8, X19, LSR #0
    STR  Q18, [X8, #0]!
    LDR  Q3, [X8, #0]!
    ADD  X8, X8, X19, ASR #0
    STR  H16, [X8, #0]!
    LDR  H17, [X8, #0]!
    ADD  X8, X8, X19
    STR  S27, [X8, #0]!
    LDR  S5, [X8, #0]!
    ADD  X8, X8, X19
    STR  D3, [X8, #0]!
    LDR  D25, [X8, #0]!
    ADD  X8, X8, X19
    STR  B9, [X8, #0]!
    LDR  B28, [X8, #0]!
    ADD  X8, X8, X19, ASR #0
    STR  Q25, [X8, #0]
    LDR  Q3, [X8, #0]
    ADD  X8, X8, X19, ASR #0
    STR  H5, [X8, #0]
    LDR  H7, [X8, #0]
    ADD  X8, X8, X19
    STR  S7, [X8, #0]
    LDR  S17, [X8, #0]
    ADD  X8, X8, X19
    STR  D17, [X8, #0]
    LDR  D8, [X8, #0]
    ADD  X8, X8, X19, ASR #0
    STR  B23, [X8, #0]
    LDR  B21, [X8, #0]
    ADD  X8, X8, X19, ASR #0
    STR Q21, [X8, X10, LSL #4]
    LDR Q19, [X8, X10, LSL #4]
    ADD  X8, X8, X19
    STR Q8, [X8, W10, SXTW #0]
    LDR Q4, [X8, W10, SXTW #4]
    ADD  X8, X8, X19
    STR Q19, [X8, X10, SXTX #4]
    LDR Q11, [X8, X10, SXTX #4]
    ADD  X8, X8, X19, ASR #0
    STR Q11, [X8, W10, UXTW #4]
    LDR Q24, [X8, W10, UXTW #4]
    ADD  X8, X8, X19, ASR #0
    STR H4, [X8, X10, LSL #1]
    LDR H7, [X8, X10, LSL #1]
    ADD  X8, X8, X19
    STR H7, [X8, W10, SXTW #1]
    LDR H29, [X8, W10, SXTW #0]
    ADD  X8, X8, X19, LSR #0
    STR H24, [X8, X10, SXTX #1]
    LDR H6, [X8, X10, SXTX #0]
    ADD  X8, X8, X19, ASR #0
    STR H5, [X8, W10, UXTW #0]
    LDR H15, [X8, W10, UXTW #1]
    ADD  X8, X8, X19, LSR #0
    STR S8, [X8, X10, LSL #0]
    LDR S3, [X8, X10, LSL #0]
    ADD  X8, X8, X19, LSR #0
    STR S4, [X8, W10, SXTW #0]
    LDR S17, [X8, W10, SXTW #2]
    ADD  X8, X8, X19
    STR S22, [X8, X10, SXTX #0]
    LDR S28, [X8, X10, SXTX #2]
    ADD  X8, X8, X19, LSR #0
    STR S23, [X8, W10, UXTW #0]
    LDR S29, [X8, W10, UXTW #0]
    ADD  X8, X8, X19, LSR #0
    STR D26, [X8, X10, LSL #0]
    LDR D11, [X8, X10, LSL #3]
    ADD  X8, X8, X19, ASR #0
    STR D24, [X8, W10, SXTW #0]
    LDR D9, [X8, W10, SXTW #3]
    ADD  X8, X8, X19, LSR #0
    STR D8, [X8, X10, SXTX #0]
    LDR D23, [X8, X10, SXTX #3]
    ADD  X8, X8, X19, LSR #0
    STR D17, [X8, W10, UXTW #0]
    LDR D0, [X8, W10, UXTW #0]
    ADD  X8, X8, X19, ASR #0
    STR B11, [X8, X10, LSL #0]
    LDR B30, [X8, X10, LSL #0]
    ADD  X8, X8, X19, LSR #0
    STR B28, [X8, W10, SXTW #0]
    LDR B7, [X8, W10, SXTW #0]
    ADD  X8, X8, X19
    STR B30, [X8, X10, SXTX #0]
    LDR B29, [X8, X10, SXTX #0]
    ADD  X8, X8, X19, ASR #0
    STR B9, [X8, W10, UXTW #0]
    LDR B15, [X8, W10, UXTW #0]
    ADD  X8, X8, X19, LSR #0
    STUR  Q7, [X8, #0]
    LDUR  Q4, [X8, #0]
    ADD  X8, X8, X19, ASR #0
    STUR  H25, [X8, #0]
    LDUR  H22, [X8, #0]
    ADD  X8, X8, X19, ASR #0
    STUR  S29, [X8, #0]
    LDUR  S15, [X8, #0]
    ADD  X8, X8, X19
    STUR  D0, [X8, #0]
    LDUR  D26, [X8, #0]
    ADD  X8, X8, X19, ASR #0
    STUR  B4, [X8, #0]
    LDUR  B30, [X8, #0]
    ADD  X8, X8, X19, LSR #0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X7, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D0
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, V1.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, D1
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, V2.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, D2
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D3
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D4
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D5
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D6
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D7
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D8
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D9
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, D10
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V11.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X7, D11
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X7, D12
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, V13.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, D13
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, D14
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D15
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X7, D16
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D17
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X7, D18
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D19
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, V20.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, D20
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D21
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X7, D22
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D23
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D24
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X7, D25
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D26
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D27
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X7, D28
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D29
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X7, D30
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, V31.D[1]
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X7, D31
    SUB  X11, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X23
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X22
    FMOV  D3, X28
    FMOV  V3.D[1], X21
    FMOV  D4, X10
    FMOV  V4.D[1], X15
    FMOV  D5, X3
    FMOV  V5.D[1], X26
    FMOV  D6, X14
    FMOV  V6.D[1], X16
    FMOV  D7, X17
    FMOV  V7.D[1], X17
    FMOV  D8, X28
    FMOV  V8.D[1], X25
    FMOV  D9, X9
    FMOV  V9.D[1], X14
    FMOV  D10, X2
    FMOV  V10.D[1], X14
    FMOV  D11, X7
    FMOV  V11.D[1], X2
    FMOV  D12, X11
    FMOV  V12.D[1], X20
    FMOV  D13, X28
    FMOV  V13.D[1], X10
    FMOV  D14, X19
    FMOV  V14.D[1], X17
    FMOV  D15, X5
    FMOV  V15.D[1], X28
    FMOV  D16, X20
    FMOV  V16.D[1], X6
    FMOV  D17, X10
    FMOV  V17.D[1], X22
    FMOV  D18, X25
    FMOV  V18.D[1], X17
    FMOV  D19, X3
    FMOV  V19.D[1], X27
    FMOV  D20, X23
    FMOV  V20.D[1], X28
    FMOV  D21, X28
    FMOV  V21.D[1], X28
    FMOV  D22, X3
    FMOV  V22.D[1], X19
    FMOV  D23, X28
    FMOV  V23.D[1], X11
    FMOV  D24, X6
    FMOV  V24.D[1], X18
    FMOV  D25, X27
    FMOV  V25.D[1], X23
    FMOV  D26, X22
    FMOV  V26.D[1], X14
    FMOV  D27, X10
    FMOV  V27.D[1], X28
    FMOV  D28, X29
    FMOV  V28.D[1], X11
    FMOV  D29, X20
    FMOV  V29.D[1], X14
    FMOV  D30, X6
    FMOV  V30.D[1], X17
    FMOV  D31, X22
    FMOV  V31.D[1], X25
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X5, #0x20, LSL #0
    MOVZ  X28, #0xf00, LSL #0
    ADD  X11, X30, X28, LSR #0
    STNP  Q30, Q25, [X11, #0]
    LDNP  Q11, Q29, [X11, #0]
    ADD  X11, X11, X5, ASR #0
    STNP  S28, S21, [X11, #0]
    LDNP  S8, S26, [X11, #0]
    ADD  X11, X11, X5, LSR #0
    STNP  D24, D27, [X11, #0]
    LDNP  D31, D12, [X11, #0]
    ADD  X11, X11, X5, LSR #0
    STP  Q23, Q12, [X11], #0
    LDP  Q17, Q26, [X11], #0
    ADD  X11, X11, X5, LSR #0
    STP  S29, S31, [X11], #0
    LDP  S26, S14, [X11], #0
    ADD  X11, X11, X5
    STP  D17, D11, [X11], #0
    LDP  D1, D11, [X11], #0
    ADD  X11, X11, X5
    STP  Q1, Q8, [X11, #0]!
    LDP  Q19, Q13, [X11, #0]!
    ADD  X11, X11, X5
    STP  S30, S14, [X11, #0]!
    LDP  S6, S0, [X11, #0]!
    ADD  X11, X11, X5, ASR #0
    STP  D13, D13, [X11, #0]!
    LDP  D14, D1, [X11, #0]!
    ADD  X11, X11, X5
    STP  Q17, Q11, [X11, #0]
    LDP  Q8, Q13, [X11, #0]
    ADD  X11, X11, X5, ASR #0
    STP  S8, S6, [X11, #0]
    LDP  S11, S30, [X11, #0]
    ADD  X11, X11, X5
    STP  D30, D11, [X11, #0]
    LDP  D30, D11, [X11, #0]
    ADD  X11, X11, X5, ASR #0
    STR  Q11, [X11], #0
    LDR  Q11, [X11], #0
    ADD  X11, X11, X5, ASR #0
    STR  H30, [X11], #0
    LDR  H30, [X11], #0
    ADD  X11, X11, X5, ASR #0
    STR  S13, [X11], #0
    LDR  S8, [X11], #0
    ADD  X11, X11, X5, ASR #0
    STR  D1, [X11], #0
    LDR  D6, [X11], #0
    ADD  X11, X11, X5
    STR  B6, [X11], #0
    LDR  B6, [X11], #0
    ADD  X11, X11, X5, ASR #0
    STR  Q11, [X11, #0]!
    LDR  Q13, [X11, #0]!
    ADD  X11, X11, X5, LSR #0
    STR  H6, [X11, #0]!
    LDR  H1, [X11, #0]!
    ADD  X11, X11, X5, LSR #0
    STR  S13, [X11, #0]!
    LDR  S11, [X11, #0]!
    ADD  X11, X11, X5
    STR  D30, [X11, #0]!
    LDR  D24, [X11, #0]!
    ADD  X11, X11, X5
    STR  B31, [X11, #0]!
    LDR  B16, [X11, #0]!
    ADD  X11, X11, X5, ASR #0
    STR  Q16, [X11, #0]
    LDR  Q25, [X11, #0]
    ADD  X11, X11, X5, LSR #0
    STR  H25, [X11, #0]
    LDR  H29, [X11, #0]
    ADD  X11, X11, X5, ASR #0
    STR  S11, [X11, #0]
    LDR  S11, [X11, #0]
    ADD  X11, X11, X5, ASR #0
    STR  D1, [X11, #0]
    LDR  D4, [X11, #0]
    ADD  X11, X11, X5, LSR #0
    STR  B11, [X11, #0]
    LDR  B2, [X11, #0]
    ADD  X11, X11, X5, LSR #0
    STR Q4, [X11, X22, LSL #4]
    LDR Q10, [X11, X22, LSL #4]
    ADD  X11, X11, X5
    STR Q29, [X11, W22, SXTW #4]
    LDR Q30, [X11, W22, SXTW #4]
    ADD  X11, X11, X5, LSR #0
    STR Q24, [X11, X22, SXTX #4]
    LDR Q10, [X11, X22, SXTX #0]
    ADD  X11, X11, X5, LSR #0
    STR Q30, [X11, W22, UXTW #4]
    LDR Q2, [X11, W22, UXTW #4]
    ADD  X11, X11, X5, ASR #0
    STR H2, [X11, X22, LSL #1]
    LDR H2, [X11, X22, LSL #0]
    ADD  X11, X11, X5
    STR H22, [X11, W22, SXTW #0]
    LDR H12, [X11, W22, SXTW #1]
    ADD  X11, X11, X5
    STR H23, [X11, X22, SXTX #0]
    LDR H15, [X11, X22, SXTX #1]
    ADD  X11, X11, X5, ASR #0
    STR H24, [X11, W22, UXTW #1]
    LDR H10, [X11, W22, UXTW #0]
    ADD  X11, X11, X5, LSR #0
    STR S10, [X11, X22, LSL #0]
    LDR S10, [X11, X22, LSL #0]
    ADD  X11, X11, X5, LSR #0
    STR S14, [X11, W22, SXTW #0]
    LDR S10, [X11, W22, SXTW #2]
    ADD  X11, X11, X5
    STR S3, [X11, X22, SXTX #0]
    LDR S12, [X11, X22, SXTX #2]
    ADD  X11, X11, X5
    STR S25, [X11, W22, UXTW #0]
    LDR S4, [X11, W22, UXTW #2]
    ADD  X11, X11, X5, LSR #0
    STR D0, [X11, X22, LSL #3]
    LDR D15, [X11, X22, LSL #0]
    ADD  X11, X11, X5, LSR #0
    STR D1, [X11, W22, SXTW #0]
    LDR D3, [X11, W22, SXTW #3]
    ADD  X11, X11, X5, LSR #0
    STR D10, [X11, X22, SXTX #0]
    LDR D4, [X11, X22, SXTX #3]
    ADD  X11, X11, X5
    STR D0, [X11, W22, UXTW #3]
    LDR D19, [X11, W22, UXTW #3]
    ADD  X11, X11, X5
    STR B11, [X11, X22, LSL #0]
    LDR B10, [X11, X22, LSL #0]
    ADD  X11, X11, X5
    STR B21, [X11, W22, SXTW #0]
    LDR B3, [X11, W22, SXTW #0]
    ADD  X11, X11, X5, LSR #0
    STR B11, [X11, X22, SXTX #0]
    LDR B25, [X11, X22, SXTX #0]
    ADD  X11, X11, X5, LSR #0
    STR B24, [X11, W22, UXTW #0]
    LDR B5, [X11, W22, UXTW #0]
    ADD  X11, X11, X5, ASR #0
    STUR  Q13, [X11, #0]
    LDUR  Q2, [X11, #0]
    ADD  X11, X11, X5, LSR #0
    STUR  H4, [X11, #0]
    LDUR  H7, [X11, #0]
    ADD  X11, X11, X5, ASR #0
    STUR  S7, [X11, #0]
    LDUR  S21, [X11, #0]
    ADD  X11, X11, X5, LSR #0
    STUR  D10, [X11, #0]
    LDUR  D23, [X11, #0]
    ADD  X11, X11, X5
    STUR  B3, [X11, #0]
    LDUR  B23, [X11, #0]
    ADD  X11, X11, X5, LSR #0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X9, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D0
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D1
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D2
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D3
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D4
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D5
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D6
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    FMOV  X9, D7
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D8
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D10
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D11
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D12
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D13
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D14
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D15
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D16
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D19
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    FMOV  X9, D21
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D23
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    FMOV  X9, D24
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D25
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X9, D26
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D29
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5, LSL #0
    FMOV  X9, D30
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X10
    FMOV  D3, X28
    FMOV  V3.D[1], X17
    FMOV  D4, X15
    FMOV  V4.D[1], X8
    FMOV  D5, X2
    FMOV  V5.D[1], X26
    FMOV  D6, X10
    FMOV  V6.D[1], X22
    FMOV  D7, X10
    FMOV  V7.D[1], X17
    FMOV  D8, X5
    FMOV  V8.D[1], X3
    FMOV  D9, X21
    FMOV  V9.D[1], X11
    FMOV  D10, X16
    FMOV  V10.D[1], X16
    FMOV  D11, X15
    FMOV  V11.D[1], X14
    FMOV  D12, X7
    FMOV  V12.D[1], X7
    FMOV  D13, X8
    FMOV  V13.D[1], X25
    FMOV  D14, X23
    FMOV  V14.D[1], X23
    FMOV  D15, X20
    FMOV  V15.D[1], X23
    FMOV  D16, X29
    FMOV  V16.D[1], X14
    FMOV  D17, X26
    FMOV  V17.D[1], X27
    FMOV  D18, X26
    FMOV  V18.D[1], X5
    FMOV  D19, X14
    FMOV  V19.D[1], X15
    FMOV  D20, X25
    FMOV  V20.D[1], X5
    FMOV  D21, X9
    FMOV  V21.D[1], X19
    FMOV  D22, X18
    FMOV  V22.D[1], X26
    FMOV  D23, X25
    FMOV  V23.D[1], X8
    FMOV  D24, X23
    FMOV  V24.D[1], X14
    FMOV  D25, X6
    FMOV  V25.D[1], X11
    FMOV  D26, X11
    FMOV  V26.D[1], X17
    FMOV  D27, X10
    FMOV  V27.D[1], X20
    FMOV  D28, X22
    FMOV  V28.D[1], X20
    FMOV  D29, X29
    FMOV  V29.D[1], X23
    FMOV  D30, X8
    FMOV  V30.D[1], X22
    FMOV  D31, X20
    FMOV  V31.D[1], X16
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X28, #0x20, LSL #0
    MOVZ  X9, #0x1400, LSL #0
    ADD  X27, X30, X9
    STNP  Q30, Q30, [X27, #0]
    LDNP  Q29, Q5, [X27, #0]
    ADD  X27, X27, X28, ASR #0
    STNP  S29, S26, [X27, #0]
    LDNP  S8, S11, [X27, #0]
    ADD  X27, X27, X28, ASR #0
    STNP  D11, D27, [X27, #0]
    LDNP  D29, D6, [X27, #0]
    ADD  X27, X27, X28
    STP  Q8, Q31, [X27], #0
    LDP  Q11, Q30, [X27], #0
    ADD  X27, X27, X28, ASR #0
    STP  S11, S29, [X27], #0
    LDP  S16, S9, [X27], #0
    ADD  X27, X27, X28, ASR #0
    STP  D5, D16, [X27], #0
    LDP  D25, D23, [X27], #0
    ADD  X27, X27, X28, ASR #0
    STP  Q28, Q30, [X27, #0]!
    LDP  Q11, Q8, [X27, #0]!
    ADD  X27, X27, X28
    STP  S9, S11, [X27, #0]!
    LDP  S31, S20, [X27, #0]!
    ADD  X27, X27, X28, ASR #0
    STP  D31, D23, [X27, #0]!
    LDP  D29, D20, [X27, #0]!
    ADD  X27, X27, X28
    STP  Q11, Q20, [X27, #0]
    LDP  Q26, Q24, [X27, #0]
    ADD  X27, X27, X28, ASR #0
    STP  S29, S8, [X27, #0]
    LDP  S4, S24, [X27, #0]
    ADD  X27, X27, X28, ASR #0
    STP  D6, D25, [X27, #0]
    LDP  D19, D2, [X27, #0]
    ADD  X27, X27, X28, ASR #0
    STR  Q19, [X27], #0
    LDR  Q20, [X27], #0
    ADD  X27, X27, X28, LSR #0
    STR  H20, [X27], #0
    LDR  H29, [X27], #0
    ADD  X27, X27, X28, ASR #0
    STR  S26, [X27], #0
    LDR  S19, [X27], #0
    ADD  X27, X27, X28, ASR #0
    STR  D2, [X27], #0
    LDR  D20, [X27], #0
    ADD  X27, X27, X28, ASR #0
    STR  B20, [X27], #0
    LDR  B25, [X27], #0
    ADD  X27, X27, X28, LSR #0
    STR  Q24, [X27, #0]!
    LDR  Q2, [X27, #0]!
    ADD  X27, X27, X28, ASR #0
    STR  H29, [X27, #0]!
    LDR  H20, [X27, #0]!
    ADD  X27, X27, X28
    STR  S2, [X27, #0]!
    LDR  S2, [X27, #0]!
    ADD  X27, X27, X28, ASR #0
    STR  D25, [X27, #0]!
    LDR  D6, [X27, #0]!
    ADD  X27, X27, X28
    STR  B19, [X27, #0]!
    LDR  B25, [X27, #0]!
    ADD  X27, X27, X28, ASR #0
    STR  Q20, [X27, #0]
    LDR  Q29, [X27, #0]
    ADD  X27, X27, X28
    STR  H8, [X27, #0]
    LDR  H19, [X27, #0]
    ADD  X27, X27, X28
    STR  S6, [X27, #0]
    LDR  S8, [X27, #0]
    ADD  X27, X27, X28, ASR #0
    STR  D8, [X27, #0]
    LDR  D8, [X27, #0]
    ADD  X27, X27, X28, LSR #0
    STR  B8, [X27, #0]
    LDR  B24, [X27, #0]
    ADD  X27, X27, X28
    STR Q19, [X27, X8, LSL #4]
    LDR Q19, [X27, X8, LSL #0]
    ADD  X27, X27, X28, LSR #0
    STR Q2, [X27, W8, SXTW #0]
    LDR Q6, [X27, W8, SXTW #0]
    ADD  X27, X27, X28, LSR #0
    STR Q6, [X27, X8, SXTX #0]
    LDR Q6, [X27, X8, SXTX #0]
    ADD  X27, X27, X28, ASR #0
    STR Q19, [X27, W8, UXTW #4]
    LDR Q8, [X27, W8, UXTW #4]
    ADD  X27, X27, X28, ASR #0
    STR H24, [X27, X8, LSL #0]
    LDR H2, [X27, X8, LSL #0]
    ADD  X27, X27, X28, LSR #0
    STR H8, [X27, W8, SXTW #0]
    LDR H8, [X27, W8, SXTW #0]
    ADD  X27, X27, X28, LSR #0
    STR H2, [X27, X8, SXTX #1]
    LDR H20, [X27, X8, SXTX #0]
    ADD  X27, X27, X28, ASR #0
    STR H20, [X27, W8, UXTW #0]
    LDR H19, [X27, W8, UXTW #0]
    ADD  X27, X27, X28
    STR S20, [X27, X8, LSL #0]
    LDR S22, [X27, X8, LSL #2]
    ADD  X27, X27, X28
    STR S22, [X27, W8, SXTW #0]
    LDR S31, [X27, W8, SXTW #2]
    ADD  X27, X27, X28, LSR #0
    STR S31, [X27, X8, SXTX #0]
    LDR S25, [X27, X8, SXTX #0]
    ADD  X27, X27, X28, LSR #0
    STR S19, [X27, W8, UXTW #2]
    LDR S2, [X27, W8, UXTW #0]
    ADD  X27, X27, X28, ASR #0
    STR D8, [X27, X8, LSL #3]
    LDR D25, [X27, X8, LSL #3]
    ADD  X27, X27, X28, ASR #0
    STR D25, [X27, W8, SXTW #3]
    LDR D30, [X27, W8, SXTW #0]
    ADD  X27, X27, X28, ASR #0
    STR D27, [X27, X8, SXTX #0]
    LDR D7, [X27, X8, SXTX #0]
    ADD  X27, X27, X28, ASR #0
    STR D30, [X27, W8, UXTW #3]
    LDR D11, [X27, W8, UXTW #0]
    ADD  X27, X27, X28, ASR #0
    STR B8, [X27, X8, LSL #0]
    LDR B12, [X27, X8, LSL #0]
    ADD  X27, X27, X28, ASR #0
    STR B11, [X27, W8, SXTW #0]
    LDR B16, [X27, W8, SXTW #0]
    ADD  X27, X27, X28, LSR #0
    STR B6, [X27, X8, SXTX #0]
    LDR B9, [X27, X8, SXTX #0]
    ADD  X27, X27, X28, LSR #0
    STR B6, [X27, W8, UXTW #0]
    LDR B26, [X27, W8, UXTW #0]
    ADD  X27, X27, X28, ASR #0
    STUR  Q8, [X27, #0]
    LDUR  Q15, [X27, #0]
    ADD  X27, X27, X28
    STUR  H6, [X27, #0]
    LDUR  H1, [X27, #0]
    ADD  X27, X27, X28, ASR #0
    STUR  S13, [X27, #0]
    LDUR  S23, [X27, #0]
    ADD  X27, X27, X28
    STUR  D17, [X27, #0]
    LDUR  D15, [X27, #0]
    ADD  X27, X27, X28, ASR #0
    STUR  B14, [X27, #0]
    LDUR  B4, [X27, #0]
    ADD  X27, X27, X28
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X14, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V0.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D0
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    FMOV  X14, D1
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D2
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V3.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D3
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D4
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V5.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D5
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    FMOV  X14, D6
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D7
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    FMOV  X14, D8
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D9
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V10.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D10
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    FMOV  X14, D11
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D12
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V13.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D13
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V14.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D14
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D15
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D16
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V17.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D17
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V18.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D18
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D19
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D20
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V21.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D21
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D22
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    FMOV  X14, D23
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D24
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    FMOV  X14, D25
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D26
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V27.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D27
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, V28.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X14, D28
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    FMOV  X14, D29
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    FMOV  X14, D30
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a, LSL #0
    FMOV  X14, D31
    SUB  X6, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X22
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X3
    FMOV  V3.D[1], X6
    FMOV  D4, X16
    FMOV  V4.D[1], X22
    FMOV  D5, X29
    FMOV  V5.D[1], X20
    FMOV  D6, X18
    FMOV  V6.D[1], X9
    FMOV  D7, X21
    FMOV  V7.D[1], X26
    FMOV  D8, X6
    FMOV  V8.D[1], X7
    FMOV  D9, X26
    FMOV  V9.D[1], X3
    FMOV  D10, X25
    FMOV  V10.D[1], X26
    FMOV  D11, X25
    FMOV  V11.D[1], X3
    FMOV  D12, X17
    FMOV  V12.D[1], X20
    FMOV  D13, X26
    FMOV  V13.D[1], X5
    FMOV  D14, X3
    FMOV  V14.D[1], X19
    FMOV  D15, X18
    FMOV  V15.D[1], X26
    FMOV  D16, X22
    FMOV  V16.D[1], X29
    FMOV  D17, X2
    FMOV  V17.D[1], X14
    FMOV  D18, X16
    FMOV  V18.D[1], X2
    FMOV  D19, X10
    FMOV  V19.D[1], X21
    FMOV  D20, X17
    FMOV  V20.D[1], X7
    FMOV  D21, X29
    FMOV  V21.D[1], X23
    FMOV  D22, X2
    FMOV  V22.D[1], X10
    FMOV  D23, X17
    FMOV  V23.D[1], X15
    FMOV  D24, X11
    FMOV  V24.D[1], X28
    FMOV  D25, X2
    FMOV  V25.D[1], X29
    FMOV  D26, X10
    FMOV  V26.D[1], X23
    FMOV  D27, X11
    FMOV  V27.D[1], X17
    FMOV  D28, X7
    FMOV  V28.D[1], X3
    FMOV  D29, X3
    FMOV  V29.D[1], X6
    FMOV  D30, X10
    FMOV  V30.D[1], X26
    FMOV  D31, X25
    FMOV  V31.D[1], X29
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X27, #0x20, LSL #0
    MOVZ  X17, #0x1900, LSL #0
    ADD  X21, X30, X17
    STNP  Q19, Q29, [X21, #0]
    LDNP  Q16, Q2, [X21, #0]
    ADD  X21, X21, X27
    STNP  S25, S28, [X21, #0]
    LDNP  S27, S21, [X21, #0]
    ADD  X21, X21, X27
    STNP  D22, D31, [X21, #0]
    LDNP  D13, D15, [X21, #0]
    ADD  X21, X21, X27
    STP  Q2, Q30, [X21], #0
    LDP  Q0, Q6, [X21], #0
    ADD  X21, X21, X27, ASR #0
    STP  S13, S16, [X21], #0
    LDP  S13, S25, [X21], #0
    ADD  X21, X21, X27
    STP  D0, D15, [X21], #0
    LDP  D27, D25, [X21], #0
    ADD  X21, X21, X27
    STP  Q31, Q21, [X21, #0]!
    LDP  Q21, Q28, [X21, #0]!
    ADD  X21, X21, X27
    STP  S21, S27, [X21, #0]!
    LDP  S1, S6, [X21, #0]!
    ADD  X21, X21, X27, ASR #0
    STP  D25, D6, [X21, #0]!
    LDP  D21, D5, [X21, #0]!
    ADD  X21, X21, X27
    STP  Q1, Q13, [X21, #0]
    LDP  Q19, Q15, [X21, #0]
    ADD  X21, X21, X27, LSR #0
    STP  S19, S21, [X21, #0]
    LDP  S25, S17, [X21, #0]
    ADD  X21, X21, X27, LSR #0
    STP  D25, D28, [X21, #0]
    LDP  D23, D26, [X21, #0]
    ADD  X21, X21, X27, LSR #0
    STR  Q26, [X21], #0
    LDR  Q6, [X21], #0
    ADD  X21, X21, X27
    STR  H23, [X21], #0
    LDR  H13, [X21], #0
    ADD  X21, X21, X27, ASR #0
    STR  S6, [X21], #0
    LDR  S6, [X21], #0
    ADD  X21, X21, X27, LSR #0
    STR  D6, [X21], #0
    LDR  D25, [X21], #0
    ADD  X21, X21, X27, LSR #0
    STR  B17, [X21], #0
    LDR  B26, [X21], #0
    ADD  X21, X21, X27, ASR #0
    STR  Q26, [X21, #0]!
    LDR  Q28, [X21, #0]!
    ADD  X21, X21, X27, LSR #0
    STR  H25, [X21, #0]!
    LDR  H1, [X21, #0]!
    ADD  X21, X21, X27
    STR  S1, [X21, #0]!
    LDR  S1, [X21, #0]!
    ADD  X21, X21, X27, LSR #0
    STR  D13, [X21, #0]!
    LDR  D13, [X21, #0]!
    ADD  X21, X21, X27
    STR  B13, [X21, #0]!
    LDR  B23, [X21, #0]!
    ADD  X21, X21, X27, ASR #0
    STR  Q28, [X21, #0]
    LDR  Q25, [X21, #0]
    ADD  X21, X21, X27
    STR  H23, [X21, #0]
    LDR  H13, [X21, #0]
    ADD  X21, X21, X27
    STR  S1, [X21, #0]
    LDR  S28, [X21, #0]
    ADD  X21, X21, X27, ASR #0
    STR  D28, [X21, #0]
    LDR  D28, [X21, #0]
    ADD  X21, X21, X27, LSR #0
    STR  B25, [X21, #0]
    LDR  B26, [X21, #0]
    ADD  X21, X21, X27, ASR #0
    STR Q13, [X21, X20, LSL #0]
    LDR Q1, [X21, X20, LSL #4]
    ADD  X21, X21, X27, LSR #0
    STR Q28, [X21, W20, SXTW #0]
    LDR Q25, [X21, W20, SXTW #4]
    ADD  X21, X21, X27, ASR #0
    STR Q1, [X21, X20, SXTX #4]
    LDR Q23, [X21, X20, SXTX #4]
    ADD  X21, X21, X27, LSR #0
    STR Q23, [X21, W20, UXTW #0]
    LDR Q23, [X21, W20, UXTW #0]
    ADD  X21, X21, X27, ASR #0
    STR H25, [X21, X20, LSL #0]
    LDR H26, [X21, X20, LSL #0]
    ADD  X21, X21, X27
    STR H13, [X21, W20, SXTW #0]
    LDR H1, [X21, W20, SXTW #1]
    ADD  X21, X21, X27, ASR #0
    STR H26, [X21, X20, SXTX #0]
    LDR H26, [X21, X20, SXTX #0]
    ADD  X21, X21, X27
    STR H26, [X21, W20, UXTW #0]
    LDR H25, [X21, W20, UXTW #0]
    ADD  X21, X21, X27, ASR #0
    STR S25, [X21, X20, LSL #2]
    LDR S28, [X21, X20, LSL #2]
    ADD  X21, X21, X27, ASR #0
    STR S23, [X21, W20, SXTW #2]
    LDR S23, [X21, W20, SXTW #2]
    ADD  X21, X21, X27
    STR S1, [X21, X20, SXTX #2]
    LDR S26, [X21, X20, SXTX #2]
    ADD  X21, X21, X27, LSR #0
    STR S26, [X21, W20, UXTW #0]
    LDR S25, [X21, W20, UXTW #2]
    ADD  X21, X21, X27
    STR D28, [X21, X20, LSL #3]
    LDR D1, [X21, X20, LSL #3]
    ADD  X21, X21, X27, LSR #0
    STR D1, [X21, W20, SXTW #3]
    LDR D26, [X21, W20, SXTW #0]
    ADD  X21, X21, X27, ASR #0
    STR D23, [X21, X20, SXTX #0]
    LDR D23, [X21, X20, SXTX #3]
    ADD  X21, X21, X27
    STR D23, [X21, W20, UXTW #3]
    LDR D6, [X21, W20, UXTW #0]
    ADD  X21, X21, X27
    STR B25, [X21, X20, LSL #0]
    LDR B1, [X21, X20, LSL #0]
    ADD  X21, X21, X27, LSR #0
    STR B1, [X21, W20, SXTW #0]
    LDR B25, [X21, W20, SXTW #0]
    ADD  X21, X21, X27, LSR #0
    STR B26, [X21, X20, SXTX #0]
    LDR B28, [X21, X20, SXTX #0]
    ADD  X21, X21, X27, LSR #0
    STR B25, [X21, W20, UXTW #0]
    LDR B1, [X21, W20, UXTW #0]
    ADD  X21, X21, X27
    STUR  Q28, [X21, #0]
    LDUR  Q23, [X21, #0]
    ADD  X21, X21, X27, LSR #0
    STUR  H1, [X21, #0]
    LDUR  H26, [X21, #0]
    ADD  X21, X21, X27
    STUR  S23, [X21, #0]
    LDUR  S1, [X21, #0]
    ADD  X21, X21, X27
    STUR  D1, [X21, #0]
    LDUR  D28, [X21, #0]
    ADD  X21, X21, X27
    STUR  B28, [X21, #0]
    LDUR  B1, [X21, #0]
    ADD  X21, X21, X27, ASR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V0.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D0
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X10, D1
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V2.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D2
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V3.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D3
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V4.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D4
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X10, D5
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X10, D6
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V7.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D7
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V8.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D8
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V9.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D9
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V10.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D10
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V11.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D11
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V12.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D12
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X10, D13
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V14.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D14
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X10, D15
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V16.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D16
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X10, D17
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V18.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D18
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X10, D19
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V20.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D20
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D21
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V22.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D22
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X10, D23
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V24.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D24
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X10, D25
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X10, D26
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D27
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X10, D28
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V29.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D29
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V30.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D30
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V31.D[1]
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D31
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D0, X27
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X3
    FMOV  V2.D[1], X25
    FMOV  D3, X26
    FMOV  V3.D[1], X10
    FMOV  D4, X22
    FMOV  V4.D[1], X25
    FMOV  D5, X2
    FMOV  V5.D[1], X26
    FMOV  D6, X8
    FMOV  V6.D[1], X23
    FMOV  D7, X2
    FMOV  V7.D[1], X23
    FMOV  D8, X9
    FMOV  V8.D[1], X9
    FMOV  D9, X9
    FMOV  V9.D[1], X6
    FMOV  D10, X26
    FMOV  V10.D[1], X17
    FMOV  D11, X27
    FMOV  V11.D[1], X29
    FMOV  D12, X17
    FMOV  V12.D[1], X21
    FMOV  D13, X22
    FMOV  V13.D[1], X15
    FMOV  D14, X28
    FMOV  V14.D[1], X17
    FMOV  D15, X27
    FMOV  V15.D[1], X7
    FMOV  D16, X21
    FMOV  V16.D[1], X2
    FMOV  D17, X21
    FMOV  V17.D[1], X18
    FMOV  D18, X14
    FMOV  V18.D[1], X14
    FMOV  D19, X17
    FMOV  V19.D[1], X26
    FMOV  D20, X23
    FMOV  V20.D[1], X23
    FMOV  D21, X15
    FMOV  V21.D[1], X9
    FMOV  D22, X11
    FMOV  V22.D[1], X3
    FMOV  D23, X19
    FMOV  V23.D[1], X20
    FMOV  D24, X16
    FMOV  V24.D[1], X19
    FMOV  D25, X2
    FMOV  V25.D[1], X21
    FMOV  D26, X21
    FMOV  V26.D[1], X21
    FMOV  D27, X21
    FMOV  V27.D[1], X21
    FMOV  D28, X6
    FMOV  V28.D[1], X16
    FMOV  D29, X16
    FMOV  V29.D[1], X26
    FMOV  D30, X27
    FMOV  V30.D[1], X16
    FMOV  D31, X14
    FMOV  V31.D[1], X8
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X21, #0x20, LSL #0
    MOVZ  X7, #0x1e00, LSL #0
    ADD  X6, X30, X7
    STNP  Q28, Q31, [X6, #0]
    LDNP  Q19, Q4, [X6, #0]
    ADD  X6, X6, X21, ASR #0
    STNP  S23, S26, [X6, #0]
    LDNP  S22, S31, [X6, #0]
    ADD  X6, X6, X21, ASR #0
    STNP  D25, D4, [X6, #0]
    LDNP  D26, D30, [X6, #0]
    ADD  X6, X6, X21, LSR #0
    STP  Q31, Q30, [X6], #0
    LDP  Q12, Q22, [X6], #0
    ADD  X6, X6, X21
    STP  S19, S22, [X6], #0
    LDP  S8, S16, [X6], #0
    ADD  X6, X6, X21, ASR #0
    STP  D26, D8, [X6], #0
    LDP  D20, D9, [X6], #0
    ADD  X6, X6, X21, LSR #0
    STP  Q20, Q20, [X6, #0]!
    LDP  Q13, Q28, [X6, #0]!
    ADD  X6, X6, X21, LSR #0
    STP  S9, S12, [X6, #0]!
    LDP  S9, S25, [X6, #0]!
    ADD  X6, X6, X21, ASR #0
    STP  D25, D13, [X6, #0]!
    LDP  D23, D4, [X6, #0]!
    ADD  X6, X6, X21, LSR #0
    STP  Q18, Q23, [X6, #0]
    LDP  Q10, Q7, [X6, #0]
    ADD  X6, X6, X21, ASR #0
    STP  S9, S16, [X6, #0]
    LDP  S20, S16, [X6, #0]
    ADD  X6, X6, X21, ASR #0
    STP  D16, D28, [X6, #0]
    LDP  D15, D17, [X6, #0]
    ADD  X6, X6, X21, LSR #0
    STR  Q13, [X6], #0
    LDR  Q11, [X6], #0
    ADD  X6, X6, X21
    STR  H20, [X6], #0
    LDR  H12, [X6], #0
    ADD  X6, X6, X21, LSR #0
    STR  S20, [X6], #0
    LDR  S9, [X6], #0
    ADD  X6, X6, X21, ASR #0
    STR  D17, [X6], #0
    LDR  D20, [X6], #0
    ADD  X6, X6, X21, ASR #0
    STR  B12, [X6], #0
    LDR  B13, [X6], #0
    ADD  X6, X6, X21, LSR #0
    STR  Q11, [X6, #0]!
    LDR  Q17, [X6, #0]!
    ADD  X6, X6, X21
    STR  H15, [X6, #0]!
    LDR  H28, [X6, #0]!
    ADD  X6, X6, X21, LSR #0
    STR  S17, [X6, #0]!
    LDR  S12, [X6, #0]!
    ADD  X6, X6, X21, LSR #0
    STR  D20, [X6, #0]!
    LDR  D17, [X6, #0]!
    ADD  X6, X6, X21, ASR #0
    STR  B9, [X6, #0]!
    LDR  B0, [X6, #0]!
    ADD  X6, X6, X21, ASR #0
    STR  Q13, [X6, #0]
    LDR  Q15, [X6, #0]
    ADD  X6, X6, X21, LSR #0
    STR  H12, [X6, #0]
    LDR  H19, [X6, #0]
    ADD  X6, X6, X21, LSR #0
    STR  S19, [X6, #0]
    LDR  S9, [X6, #0]
    ADD  X6, X6, X21, LSR #0
    STR  D28, [X6, #0]
    LDR  D12, [X6, #0]
    ADD  X6, X6, X21, LSR #0
    STR  B9, [X6, #0]
    LDR  B19, [X6, #0]
    ADD  X6, X6, X21, ASR #0
    STR Q15, [X6, X3, LSL #4]
    LDR Q28, [X6, X3, LSL #4]
    ADD  X6, X6, X21
    STR Q0, [X6, W3, SXTW #0]
    LDR Q9, [X6, W3, SXTW #0]
    ADD  X6, X6, X21
    STR Q9, [X6, X3, SXTX #0]
    LDR Q15, [X6, X3, SXTX #0]
    ADD  X6, X6, X21
    STR Q17, [X6, W3, UXTW #0]
    LDR Q17, [X6, W3, UXTW #0]
    ADD  X6, X6, X21, ASR #0
    STR H31, [X6, X3, LSL #0]
    LDR H9, [X6, X3, LSL #1]
    ADD  X6, X6, X21, ASR #0
    STR H17, [X6, W3, SXTW #0]
    LDR H0, [X6, W3, SXTW #1]
    ADD  X6, X6, X21
    STR H15, [X6, X3, SXTX #1]
    LDR H29, [X6, X3, SXTX #0]
    ADD  X6, X6, X21
    STR H0, [X6, W3, UXTW #1]
    LDR H12, [X6, W3, UXTW #0]
    ADD  X6, X6, X21, LSR #0
    STR S12, [X6, X3, LSL #2]
    LDR S13, [X6, X3, LSL #0]
    ADD  X6, X6, X21
    STR S13, [X6, W3, SXTW #2]
    LDR S9, [X6, W3, SXTW #0]
    ADD  X6, X6, X21, LSR #0
    STR S9, [X6, X3, SXTX #2]
    LDR S17, [X6, X3, SXTX #0]
    ADD  X6, X6, X21, LSR #0
    STR S29, [X6, W3, UXTW #2]
    LDR S20, [X6, W3, UXTW #2]
    ADD  X6, X6, X21, ASR #0
    STR D18, [X6, X3, LSL #3]
    LDR D15, [X6, X3, LSL #0]
    ADD  X6, X6, X21, ASR #0
    STR D28, [X6, W3, SXTW #0]
    LDR D21, [X6, W3, SXTW #0]
    ADD  X6, X6, X21, ASR #0
    STR D13, [X6, X3, SXTX #0]
    LDR D16, [X6, X3, SXTX #0]
    ADD  X6, X6, X21
    STR D26, [X6, W3, UXTW #3]
    LDR D13, [X6, W3, UXTW #3]
    ADD  X6, X6, X21, LSR #0
    STR B4, [X6, X3, LSL #0]
    LDR B7, [X6, X3, LSL #0]
    ADD  X6, X6, X21, LSR #0
    STR B10, [X6, W3, SXTW #0]
    LDR B0, [X6, W3, SXTW #0]
    ADD  X6, X6, X21, LSR #0
    STR B21, [X6, X3, SXTX #0]
    LDR B4, [X6, X3, SXTX #0]
    ADD  X6, X6, X21, LSR #0
    STR B20, [X6, W3, UXTW #0]
    LDR B19, [X6, W3, UXTW #0]
    ADD  X6, X6, X21, LSR #0
    STUR  Q9, [X6, #0]
    LDUR  Q26, [X6, #0]
    ADD  X6, X6, X21, ASR #0
    STUR  H19, [X6, #0]
    LDUR  H27, [X6, #0]
    ADD  X6, X6, X21, ASR #0
    STUR  S4, [X6, #0]
    LDUR  S19, [X6, #0]
    ADD  X6, X6, X21
    STUR  D7, [X6, #0]
    LDUR  D22, [X6, #0]
    ADD  X6, X6, X21
    STUR  B19, [X6, #0]
    LDUR  B28, [X6, #0]
    ADD  X6, X6, X21, ASR #0
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D0
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, V1.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D1
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, V2.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D2
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, V3.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D3
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V4.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D4
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, V5.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D5
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D6
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D7
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X19, D8
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    FMOV  X19, D9
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, V10.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D10
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D11
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    FMOV  X19, D12
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V13.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D13
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D14
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D15
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V16.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    FMOV  X19, D16
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V17.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    FMOV  X19, D17
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, V18.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D18
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V19.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D19
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D20
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V21.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D21
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V22.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D22
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V23.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X19, D23
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, V24.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D24
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V25.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X19, D25
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    FMOV  X19, D26
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V27.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D27
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V28.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D28
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V29.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X19, D29
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X19, D30
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X19, D31
    SUB  X16, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X22
    FMOV  V2.D[1], X29
    FMOV  D3, X8
    FMOV  V3.D[1], X3
    FMOV  D4, X17
    FMOV  V4.D[1], X18
    FMOV  D5, X25
    FMOV  V5.D[1], X29
    FMOV  D6, X10
    FMOV  V6.D[1], X27
    FMOV  D7, X23
    FMOV  V7.D[1], X23
    FMOV  D8, X14
    FMOV  V8.D[1], X18
    FMOV  D9, X10
    FMOV  V9.D[1], X10
    FMOV  D10, X19
    FMOV  V10.D[1], X6
    FMOV  D11, X27
    FMOV  V11.D[1], X25
    FMOV  D12, X15
    FMOV  V12.D[1], X8
    FMOV  D13, X20
    FMOV  V13.D[1], X7
    FMOV  D14, X18
    FMOV  V14.D[1], X9
    FMOV  D15, X7
    FMOV  V15.D[1], X28
    FMOV  D16, X29
    FMOV  V16.D[1], X17
    FMOV  D17, X8
    FMOV  V17.D[1], X29
    FMOV  D18, X27
    FMOV  V18.D[1], X5
    FMOV  D19, X14
    FMOV  V19.D[1], X26
    FMOV  D20, X19
    FMOV  V20.D[1], X25
    FMOV  D21, X22
    FMOV  V21.D[1], X21
    FMOV  D22, X9
    FMOV  V22.D[1], X2
    FMOV  D23, X19
    FMOV  V23.D[1], X21
    FMOV  D24, X9
    FMOV  V24.D[1], X6
    FMOV  D25, X9
    FMOV  V25.D[1], X9
    FMOV  D26, X28
    FMOV  V26.D[1], X21
    FMOV  D27, X14
    FMOV  V27.D[1], X21
    FMOV  D28, X11
    FMOV  V28.D[1], X10
    FMOV  D29, X25
    FMOV  V29.D[1], X17
    FMOV  D30, X26
    FMOV  V30.D[1], X17
    FMOV  D31, X3
    FMOV  V31.D[1], X5
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X2, #0x20, LSL #0
    MOVZ  X19, #0x2300, LSL #0
    ADD  X18, X30, X19
    STNP  Q26, Q28, [X18, #0]
    LDNP  Q8, Q23, [X18, #0]
    ADD  X18, X18, X2, LSR #0
    STNP  S23, S31, [X18, #0]
    LDNP  S24, S18, [X18, #0]
    ADD  X18, X18, X2
    STNP  D8, D29, [X18, #0]
    LDNP  D1, D17, [X18, #0]
    ADD  X18, X18, X2, LSR #0
    STP  Q1, Q24, [X18], #0
    LDP  Q27, Q30, [X18], #0
    ADD  X18, X18, X2, ASR #0
    STP  S17, S30, [X18], #0
    LDP  S15, S25, [X18], #0
    ADD  X18, X18, X2, LSR #0
    STP  D25, D27, [X18], #0
    LDP  D19, D4, [X18], #0
    ADD  X18, X18, X2, LSR #0
    STP  Q19, Q19, [X18, #0]!
    LDP  Q24, Q30, [X18, #0]!
    ADD  X18, X18, X2
    STP  S24, S15, [X18, #0]!
    LDP  S23, S12, [X18, #0]!
    ADD  X18, X18, X2, ASR #0
    STP  D18, D28, [X18, #0]!
    LDP  D27, D15, [X18, #0]!
    ADD  X18, X18, X2, LSR #0
    STP  Q30, Q4, [X18, #0]
    LDP  Q19, Q25, [X18, #0]
    ADD  X18, X18, X2, LSR #0
    STP  S19, S23, [X18, #0]
    LDP  S4, S22, [X18, #0]
    ADD  X18, X18, X2
    STP  D22, D27, [X18, #0]
    LDP  D9, D16, [X18, #0]
    ADD  X18, X18, X2, ASR #0
    STR  Q15, [X18], #0
    LDR  Q31, [X18], #0
    ADD  X18, X18, X2
    STR  H16, [X18], #0
    LDR  H13, [X18], #0
    ADD  X18, X18, X2, ASR #0
    STR  S9, [X18], #0
    LDR  S12, [X18], #0
    ADD  X18, X18, X2, ASR #0
    STR  D13, [X18], #0
    LDR  D0, [X18], #0
    ADD  X18, X18, X2
    STR  B25, [X18], #0
    LDR  B0, [X18], #0
    ADD  X18, X18, X2, LSR #0
    STR  Q12, [X18, #0]!
    LDR  Q22, [X18, #0]!
    ADD  X18, X18, X2, ASR #0
    STR  H31, [X18, #0]!
    LDR  H11, [X18, #0]!
    ADD  X18, X18, X2, LSR #0
    STR  S11, [X18, #0]!
    LDR  S30, [X18, #0]!
    ADD  X18, X18, X2, ASR #0
    STR  D0, [X18, #0]!
    LDR  D15, [X18, #0]!
    ADD  X18, X18, X2, LSR #0
    STR  B22, [X18, #0]!
    LDR  B29, [X18, #0]!
    ADD  X18, X18, X2, ASR #0
    STR  Q16, [X18, #0]
    LDR  Q26, [X18, #0]
    ADD  X18, X18, X2
    STR  H26, [X18, #0]
    LDR  H9, [X18, #0]
    ADD  X18, X18, X2, ASR #0
    STR  S3, [X18, #0]
    LDR  S24, [X18, #0]
    ADD  X18, X18, X2, LSR #0
    STR  D24, [X18, #0]
    LDR  D26, [X18, #0]
    ADD  X18, X18, X2, LSR #0
    STR  B9, [X18, #0]
    LDR  B8, [X18, #0]
    ADD  X18, X18, X2, LSR #0
    STR Q26, [X18, X23, LSL #4]
    LDR Q26, [X18, X23, LSL #0]
    ADD  X18, X18, X2, LSR #0
    STR Q30, [X18, W23, SXTW #4]
    LDR Q27, [X18, W23, SXTW #4]
    ADD  X18, X18, X2, ASR #0
    STR Q8, [X18, X23, SXTX #0]
    LDR Q13, [X18, X23, SXTX #4]
    ADD  X18, X18, X2
    STR Q13, [X18, W23, UXTW #0]
    LDR Q20, [X18, W23, UXTW #4]
    ADD  X18, X18, X2
    STR H20, [X18, X23, LSL #1]
    LDR H18, [X18, X23, LSL #1]
    ADD  X18, X18, X2, LSR #0
    STR H18, [X18, W23, SXTW #1]
    LDR H21, [X18, W23, SXTW #0]
    ADD  X18, X18, X2, ASR #0
    STR H27, [X18, X23, SXTX #1]
    LDR H25, [X18, X23, SXTX #0]
    ADD  X18, X18, X2, LSR #0
    STR H21, [X18, W23, UXTW #0]
    LDR H19, [X18, W23, UXTW #1]
    ADD  X18, X18, X2, ASR #0
    STR S25, [X18, X23, LSL #0]
    LDR S27, [X18, X23, LSL #2]
    ADD  X18, X18, X2, LSR #0
    STR S19, [X18, W23, SXTW #0]
    LDR S31, [X18, W23, SXTW #0]
    ADD  X18, X18, X2, ASR #0
    STR S31, [X18, X23, SXTX #0]
    LDR S18, [X18, X23, SXTX #0]
    ADD  X18, X18, X2
    STR S27, [X18, W23, UXTW #0]
    LDR S10, [X18, W23, UXTW #2]
    ADD  X18, X18, X2
    STR D9, [X18, X23, LSL #3]
    LDR D21, [X18, X23, LSL #0]
    ADD  X18, X18, X2, LSR #0
    STR D22, [X18, W23, SXTW #0]
    LDR D25, [X18, W23, SXTW #0]
    ADD  X18, X18, X2
    STR D18, [X18, X23, SXTX #3]
    LDR D11, [X18, X23, SXTX #0]
    ADD  X18, X18, X2, ASR #0
    STR D19, [X18, W23, UXTW #3]
    LDR D20, [X18, W23, UXTW #3]
    ADD  X18, X18, X2, ASR #0
    STR B19, [X18, X23, LSL #0]
    LDR B13, [X18, X23, LSL #0]
    ADD  X18, X18, X2, LSR #0
    STR B27, [X18, W23, SXTW #0]
    LDR B9, [X18, W23, SXTW #0]
    ADD  X18, X18, X2
    STR B23, [X18, X23, SXTX #0]
    LDR B18, [X18, X23, SXTX #0]
    ADD  X18, X18, X2, LSR #0
    STR B18, [X18, W23, UXTW #0]
    LDR B27, [X18, W23, UXTW #0]
    ADD  X18, X18, X2
    STUR  Q14, [X18, #0]
    LDUR  Q28, [X18, #0]
    ADD  X18, X18, X2, LSR #0
    STUR  H11, [X18, #0]
    LDUR  H25, [X18, #0]
    ADD  X18, X18, X2, LSR #0
    STUR  S9, [X18, #0]
    LDUR  S6, [X18, #0]
    ADD  X18, X18, X2
    STUR  D28, [X18, #0]
    LDUR  D3, [X18, #0]
    ADD  X18, X18, X2, LSR #0
    STUR  B6, [X18, #0]
    LDUR  B23, [X18, #0]
    ADD  X18, X18, X2
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X21, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D0
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, D1
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, D2
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, D3
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    FMOV  X21, D4
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, V5.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, D5
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D6
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, D7
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D8
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D9
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    FMOV  X21, D10
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D11
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    FMOV  X21, D12
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D13
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, D14
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D15
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    FMOV  X21, D16
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, D17
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D18
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D19
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D20
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    FMOV  X21, D21
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    FMOV  X21, D22
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D23
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    FMOV  X21, D24
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D25
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    FMOV  X21, D26
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D27
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X21, D28
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D29
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    FMOV  X21, D30
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X27, #0xa5, LSL #0
    FMOV  X21, D31
    SUB  X28, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D0, X29
    FMOV  V0.D[1], X22
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X6
    FMOV  D3, X19
    FMOV  V3.D[1], X26
    FMOV  D4, X2
    FMOV  V4.D[1], X15
    FMOV  D5, X3
    FMOV  V5.D[1], X14
    FMOV  D6, X23
    FMOV  V6.D[1], X23
    FMOV  D7, X11
    FMOV  V7.D[1], X9
    FMOV  D8, X22
    FMOV  V8.D[1], X2
    FMOV  D9, X11
    FMOV  V9.D[1], X29
    FMOV  D10, X21
    FMOV  V10.D[1], X27
    FMOV  D11, X5
    FMOV  V11.D[1], X16
    FMOV  D12, X3
    FMOV  V12.D[1], X22
    FMOV  D13, X10
    FMOV  V13.D[1], X14
    FMOV  D14, X26
    FMOV  V14.D[1], X14
    FMOV  D15, X3
    FMOV  V15.D[1], X6
    FMOV  D16, X10
    FMOV  V16.D[1], X9
    FMOV  D17, X2
    FMOV  V17.D[1], X7
    FMOV  D18, X17
    FMOV  V18.D[1], X8
    FMOV  D19, X23
    FMOV  V19.D[1], X19
    FMOV  D20, X19
    FMOV  V20.D[1], X6
    FMOV  D21, X26
    FMOV  V21.D[1], X16
    FMOV  D22, X2
    FMOV  V22.D[1], X5
    FMOV  D23, X7
    FMOV  V23.D[1], X2
    FMOV  D24, X5
    FMOV  V24.D[1], X17
    FMOV  D25, X8
    FMOV  V25.D[1], X23
    FMOV  D26, X19
    FMOV  V26.D[1], X29
    FMOV  D27, X17
    FMOV  V27.D[1], X21
    FMOV  D28, X19
    FMOV  V28.D[1], X7
    FMOV  D29, X22
    FMOV  V29.D[1], X19
    FMOV  D30, X29
    FMOV  V30.D[1], X3
    FMOV  D31, X10
    FMOV  V31.D[1], X20
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x20, LSL #0
    MOVZ  X25, #0x2800, LSL #0
    ADD  X16, X30, X25, ASR #0
    STNP  Q25, Q24, [X16, #0]
    LDNP  Q1, Q9, [X16, #0]
    ADD  X16, X16, X22
    STNP  S21, S26, [X16, #0]
    LDNP  S14, S13, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STNP  D27, D31, [X16, #0]
    LDNP  D3, D29, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  Q1, Q9, [X16], #0
    LDP  Q15, Q3, [X16], #0
    ADD  X16, X16, X22, LSR #0
    STP  S14, S15, [X16], #0
    LDP  S26, S2, [X16], #0
    ADD  X16, X16, X22
    STP  D13, D30, [X16], #0
    LDP  D26, D5, [X16], #0
    ADD  X16, X16, X22, LSR #0
    STP  Q5, Q28, [X16, #0]!
    LDP  Q14, Q6, [X16, #0]!
    ADD  X16, X16, X22, ASR #0
    STP  S3, S29, [X16, #0]!
    LDP  S29, S13, [X16, #0]!
    ADD  X16, X16, X22
    STP  D14, D6, [X16, #0]!
    LDP  D18, D31, [X16, #0]!
    ADD  X16, X16, X22, ASR #0
    STP  Q31, Q18, [X16, #0]
    LDP  Q5, Q9, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STP  S9, S2, [X16, #0]
    LDP  S18, S2, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STP  D5, D2, [X16, #0]
    LDP  D5, D31, [X16, #0]
    ADD  X16, X16, X22
    STR  Q29, [X16], #0
    LDR  Q9, [X16], #0
    ADD  X16, X16, X22, ASR #0
    STR  H18, [X16], #0
    LDR  H3, [X16], #0
    ADD  X16, X16, X22
    STR  S31, [X16], #0
    LDR  S18, [X16], #0
    ADD  X16, X16, X22
    STR  D13, [X16], #0
    LDR  D31, [X16], #0
    ADD  X16, X16, X22, LSR #0
    STR  B31, [X16], #0
    LDR  B31, [X16], #0
    ADD  X16, X16, X22, ASR #0
    STR  Q9, [X16, #0]!
    LDR  Q29, [X16, #0]!
    ADD  X16, X16, X22, ASR #0
    STR  H18, [X16, #0]!
    LDR  H18, [X16, #0]!
    ADD  X16, X16, X22, ASR #0
    STR  S31, [X16, #0]!
    LDR  S13, [X16, #0]!
    ADD  X16, X16, X22, LSR #0
    STR  D29, [X16, #0]!
    LDR  D31, [X16, #0]!
    ADD  X16, X16, X22
    STR  B18, [X16, #0]!
    LDR  B9, [X16, #0]!
    ADD  X16, X16, X22, LSR #0
    STR  Q13, [X16, #0]
    LDR  Q8, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STR  H9, [X16, #0]
    LDR  H0, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STR  S8, [X16, #0]
    LDR  S20, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STR  D0, [X16, #0]
    LDR  D18, [X16, #0]
    ADD  X16, X16, X22
    STR  B31, [X16, #0]
    LDR  B14, [X16, #0]
    ADD  X16, X16, X22
    STR Q20, [X16, X21, LSL #0]
    LDR Q26, [X16, X21, LSL #4]
    ADD  X16, X16, X22
    STR Q18, [X16, W21, SXTW #0]
    LDR Q9, [X16, W21, SXTW #4]
    ADD  X16, X16, X22
    STR Q11, [X16, X21, SXTX #0]
    LDR Q18, [X16, X21, SXTX #0]
    ADD  X16, X16, X22
    STR Q14, [X16, W21, UXTW #4]
    LDR Q26, [X16, W21, UXTW #4]
    ADD  X16, X16, X22
    STR H18, [X16, X21, LSL #1]
    LDR H20, [X16, X21, LSL #0]
    ADD  X16, X16, X22, LSR #0
    STR H9, [X16, W21, SXTW #0]
    LDR H0, [X16, W21, SXTW #1]
    ADD  X16, X16, X22, ASR #0
    STR H3, [X16, X21, SXTX #1]
    LDR H23, [X16, X21, SXTX #1]
    ADD  X16, X16, X22, ASR #0
    STR H0, [X16, W21, UXTW #0]
    LDR H22, [X16, W21, UXTW #0]
    ADD  X16, X16, X22, LSR #0
    STR S26, [X16, X21, LSL #2]
    LDR S11, [X16, X21, LSL #0]
    ADD  X16, X16, X22, LSR #0
    STR S11, [X16, W21, SXTW #0]
    LDR S24, [X16, W21, SXTW #0]
    ADD  X16, X16, X22
    STR S20, [X16, X21, SXTX #0]
    LDR S29, [X16, X21, SXTX #0]
    ADD  X16, X16, X22, ASR #0
    STR S29, [X16, W21, UXTW #0]
    LDR S25, [X16, W21, UXTW #2]
    ADD  X16, X16, X22, LSR #0
    STR D24, [X16, X21, LSL #0]
    LDR D12, [X16, X21, LSL #0]
    ADD  X16, X16, X22
    STR D12, [X16, W21, SXTW #0]
    LDR D22, [X16, W21, SXTW #3]
    ADD  X16, X16, X22, LSR #0
    STR D25, [X16, X21, SXTX #3]
    LDR D19, [X16, X21, SXTX #3]
    ADD  X16, X16, X22, LSR #0
    STR D22, [X16, W21, UXTW #3]
    LDR D10, [X16, W21, UXTW #0]
    ADD  X16, X16, X22, LSR #0
    STR B10, [X16, X21, LSL #0]
    LDR B25, [X16, X21, LSL #0]
    ADD  X16, X16, X22, LSR #0
    STR B25, [X16, W21, SXTW #0]
    LDR B6, [X16, W21, SXTW #0]
    ADD  X16, X16, X22, ASR #0
    STR B11, [X16, X21, SXTX #0]
    LDR B29, [X16, X21, SXTX #0]
    ADD  X16, X16, X22, LSR #0
    STR B18, [X16, W21, UXTW #0]
    LDR B29, [X16, W21, UXTW #0]
    ADD  X16, X16, X22
    STUR  Q24, [X16, #0]
    LDUR  Q30, [X16, #0]
    ADD  X16, X16, X22
    STUR  H1, [X16, #0]
    LDUR  H14, [X16, #0]
    ADD  X16, X16, X22, ASR #0
    STUR  S25, [X16, #0]
    LDUR  S24, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STUR  D12, [X16, #0]
    LDUR  D23, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    STUR  B23, [X16, #0]
    LDUR  B18, [X16, #0]
    ADD  X16, X16, X22, LSR #0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X8, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D0
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, V1.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D1
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X8, D2
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X8, D3
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, V4.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D4
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D5
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D6
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, V7.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D7
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D8
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D9
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D10
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V11.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D11
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D12
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V13.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D13
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X8, D14
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D15
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, V16.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D16
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, V17.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D17
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D18
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X8, D19
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X8, D20
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, V21.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D21
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D22
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D23
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D24
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D25
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D26
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, V27.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D27
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, V28.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X8, D28
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D29
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X8, D30
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X8, D31
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X6
    FMOV  D3, X23
    FMOV  V3.D[1], X5
    FMOV  D4, X10
    FMOV  V4.D[1], X15
    FMOV  D5, X2
    FMOV  V5.D[1], X17
    FMOV  D6, X20
    FMOV  V6.D[1], X9
    FMOV  D7, X17
    FMOV  V7.D[1], X15
    FMOV  D8, X7
    FMOV  V8.D[1], X14
    FMOV  D9, X5
    FMOV  V9.D[1], X22
    FMOV  D10, X8
    FMOV  V10.D[1], X8
    FMOV  D11, X15
    FMOV  V11.D[1], X6
    FMOV  D12, X7
    FMOV  V12.D[1], X9
    FMOV  D13, X23
    FMOV  V13.D[1], X11
    FMOV  D14, X22
    FMOV  V14.D[1], X28
    FMOV  D15, X7
    FMOV  V15.D[1], X19
    FMOV  D16, X19
    FMOV  V16.D[1], X14
    FMOV  D17, X3
    FMOV  V17.D[1], X23
    FMOV  D18, X19
    FMOV  V18.D[1], X3
    FMOV  D19, X8
    FMOV  V19.D[1], X15
    FMOV  D20, X21
    FMOV  V20.D[1], X18
    FMOV  D21, X17
    FMOV  V21.D[1], X21
    FMOV  D22, X6
    FMOV  V22.D[1], X2
    FMOV  D23, X20
    FMOV  V23.D[1], X17
    FMOV  D24, X29
    FMOV  V24.D[1], X8
    FMOV  D25, X22
    FMOV  V25.D[1], X14
    FMOV  D26, X28
    FMOV  V26.D[1], X2
    FMOV  D27, X11
    FMOV  V27.D[1], X8
    FMOV  D28, X22
    FMOV  V28.D[1], X6
    FMOV  D29, X29
    FMOV  V29.D[1], X11
    FMOV  D30, X29
    FMOV  V30.D[1], X15
    FMOV  D31, X8
    FMOV  V31.D[1], X16
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X25, #0x20, LSL #0
    MOVZ  X11, #0x2d00, LSL #0
    ADD  X22, X30, X11, LSR #0
    STNP  Q31, Q30, [X22, #0]
    LDNP  Q12, Q16, [X22, #0]
    ADD  X22, X22, X25, LSR #0
    STNP  S29, S24, [X22, #0]
    LDNP  S1, S9, [X22, #0]
    ADD  X22, X22, X25
    STNP  D28, D9, [X22, #0]
    LDNP  D14, D3, [X22, #0]
    ADD  X22, X22, X25
    STP  Q12, Q14, [X22], #0
    LDP  Q4, Q21, [X22], #0
    ADD  X22, X22, X25
    STP  S1, S16, [X22], #0
    LDP  S13, S16, [X22], #0
    ADD  X22, X22, X25
    STP  D16, D16, [X22], #0
    LDP  D7, D26, [X22], #0
    ADD  X22, X22, X25
    STP  Q4, Q3, [X22, #0]!
    LDP  Q15, Q21, [X22, #0]!
    ADD  X22, X22, X25
    STP  S21, S13, [X22, #0]!
    LDP  S6, S5, [X22, #0]!
    ADD  X22, X22, X25, ASR #0
    STP  D15, D26, [X22, #0]!
    LDP  D30, D12, [X22, #0]!
    ADD  X22, X22, X25, ASR #0
    STP  Q6, Q4, [X22, #0]
    LDP  Q6, Q3, [X22, #0]
    ADD  X22, X22, X25, LSR #0
    STP  S3, S5, [X22, #0]
    LDP  S4, S3, [X22, #0]
    ADD  X22, X22, X25
    STP  D6, D4, [X22, #0]
    LDP  D13, D6, [X22, #0]
    ADD  X22, X22, X25, ASR #0
    STR  Q3, [X22], #0
    LDR  Q21, [X22], #0
    ADD  X22, X22, X25
    STR  H13, [X22], #0
    LDR  H26, [X22], #0
    ADD  X22, X22, X25, LSR #0
    STR  S6, [X22], #0
    LDR  S15, [X22], #0
    ADD  X22, X22, X25, LSR #0
    STR  D21, [X22], #0
    LDR  D5, [X22], #0
    ADD  X22, X22, X25
    STR  B26, [X22], #0
    LDR  B26, [X22], #0
    ADD  X22, X22, X25, LSR #0
    STR  Q26, [X22, #0]!
    LDR  Q3, [X22, #0]!
    ADD  X22, X22, X25, LSR #0
    STR  H15, [X22, #0]!
    LDR  H6, [X22, #0]!
    ADD  X22, X22, X25, LSR #0
    STR  S25, [X22, #0]!
    LDR  S15, [X22, #0]!
    ADD  X22, X22, X25
    STR  D5, [X22, #0]!
    LDR  D21, [X22, #0]!
    ADD  X22, X22, X25, ASR #0
    STR  B6, [X22, #0]!
    LDR  B6, [X22, #0]!
    ADD  X22, X22, X25, LSR #0
    STR  Q6, [X22, #0]
    LDR  Q6, [X22, #0]
    ADD  X22, X22, X25, ASR #0
    STR  H21, [X22, #0]
    LDR  H5, [X22, #0]
    ADD  X22, X22, X25
    STR  S15, [X22, #0]
    LDR  S21, [X22, #0]
    ADD  X22, X22, X25
    STR  D21, [X22, #0]
    LDR  D15, [X22, #0]
    ADD  X22, X22, X25, LSR #0
    STR  B3, [X22, #0]
    LDR  B3, [X22, #0]
    ADD  X22, X22, X25, LSR #0
    STR Q3, [X22, X18, LSL #4]
    LDR Q21, [X22, X18, LSL #0]
    ADD  X22, X22, X25, LSR #0
    STR Q6, [X22, W18, SXTW #4]
    LDR Q1, [X22, W18, SXTW #4]
    ADD  X22, X22, X25, LSR #0
    STR Q15, [X22, X18, SXTX #0]
    LDR Q27, [X22, X18, SXTX #0]
    ADD  X22, X22, X25, LSR #0
    STR Q21, [X22, W18, UXTW #0]
    LDR Q9, [X22, W18, UXTW #4]
    ADD  X22, X22, X25, ASR #0
    STR H1, [X22, X18, LSL #0]
    LDR H0, [X22, X18, LSL #1]
    ADD  X22, X22, X25, ASR #0
    STR H0, [X22, W18, SXTW #0]
    LDR H1, [X22, W18, SXTW #0]
    ADD  X22, X22, X25, LSR #0
    STR H1, [X22, X18, SXTX #0]
    LDR H19, [X22, X18, SXTX #1]
    ADD  X22, X22, X25, LSR #0
    STR H19, [X22, W18, UXTW #0]
    LDR H22, [X22, W18, UXTW #0]
    ADD  X22, X22, X25
    STR S22, [X22, X18, LSL #2]
    LDR S25, [X22, X18, LSL #2]
    ADD  X22, X22, X25, LSR #0
    STR S9, [X22, W18, SXTW #0]
    LDR S6, [X22, W18, SXTW #0]
    ADD  X22, X22, X25
    STR S25, [X22, X18, SXTX #2]
    LDR S9, [X22, X18, SXTX #2]
    ADD  X22, X22, X25, ASR #0
    STR S9, [X22, W18, UXTW #0]
    LDR S22, [X22, W18, UXTW #0]
    ADD  X22, X22, X25, LSR #0
    STR D6, [X22, X18, LSL #3]
    LDR D18, [X22, X18, LSL #0]
    ADD  X22, X22, X25
    STR D10, [X22, W18, SXTW #0]
    LDR D28, [X22, W18, SXTW #3]
    ADD  X22, X22, X25, LSR #0
    STR D22, [X22, X18, SXTX #0]
    LDR D11, [X22, X18, SXTX #3]
    ADD  X22, X22, X25, ASR #0
    STR D11, [X22, W18, UXTW #3]
    LDR D28, [X22, W18, UXTW #3]
    ADD  X22, X22, X25, LSR #0
    STR B15, [X22, X18, LSL #0]
    LDR B20, [X22, X18, LSL #0]
    ADD  X22, X22, X25
    STR B20, [X22, W18, SXTW #0]
    LDR B7, [X22, W18, SXTW #0]
    ADD  X22, X22, X25, ASR #0
    STR B18, [X22, X18, SXTX #0]
    LDR B16, [X22, X18, SXTX #0]
    ADD  X22, X22, X25, ASR #0
    STR B16, [X22, W18, UXTW #0]
    LDR B15, [X22, W18, UXTW #0]
    ADD  X22, X22, X25
    STUR  Q28, [X22, #0]
    LDUR  Q16, [X22, #0]
    ADD  X22, X22, X25, LSR #0
    STUR  H7, [X22, #0]
    LDUR  H3, [X22, #0]
    ADD  X22, X22, X25, LSR #0
    STUR  S16, [X22, #0]
    LDUR  S14, [X22, #0]
    ADD  X22, X22, X25
    STUR  D9, [X22, #0]
    LDUR  D26, [X22, #0]
    ADD  X22, X22, X25, LSR #0
    STUR  B3, [X22, #0]
    LDUR  B4, [X22, #0]
    ADD  X22, X22, X25
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X17, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D0
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D1
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, V2.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, D2
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D3
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D4
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    FMOV  X17, D5
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D6
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D7
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, V8.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, D8
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D9
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, V10.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, D10
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D11
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    FMOV  X17, D12
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    FMOV  X17, D13
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D14
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D15
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D16
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, V17.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, D17
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D18
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D19
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D20
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D21
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D22
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, V23.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, D23
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, V24.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, D24
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D25
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D26
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    FMOV  X17, D27
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5, LSL #0
    FMOV  X17, D28
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, V29.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, D29
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, D30
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, V31.D[1]
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X17, D31
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X8
    FMOV  V2.D[1], X9
    FMOV  D3, X11
    FMOV  V3.D[1], X14
    FMOV  D4, X23
    FMOV  V4.D[1], X9
    FMOV  D5, X17
    FMOV  V5.D[1], X23
    FMOV  D6, X8
    FMOV  V6.D[1], X10
    FMOV  D7, X27
    FMOV  V7.D[1], X11
    FMOV  D8, X9
    FMOV  V8.D[1], X2
    FMOV  D9, X23
    FMOV  V9.D[1], X14
    FMOV  D10, X3
    FMOV  V10.D[1], X28
    FMOV  D11, X17
    FMOV  V11.D[1], X21
    FMOV  D12, X2
    FMOV  V12.D[1], X22
    FMOV  D13, X23
    FMOV  V13.D[1], X9
    FMOV  D14, X25
    FMOV  V14.D[1], X7
    FMOV  D15, X10
    FMOV  V15.D[1], X28
    FMOV  D16, X25
    FMOV  V16.D[1], X8
    FMOV  D17, X21
    FMOV  V17.D[1], X3
    FMOV  D18, X16
    FMOV  V18.D[1], X8
    FMOV  D19, X22
    FMOV  V19.D[1], X11
    FMOV  D20, X7
    FMOV  V20.D[1], X22
    FMOV  D21, X9
    FMOV  V21.D[1], X17
    FMOV  D22, X15
    FMOV  V22.D[1], X6
    FMOV  D23, X28
    FMOV  V23.D[1], X17
    FMOV  D24, X15
    FMOV  V24.D[1], X11
    FMOV  D25, X9
    FMOV  V25.D[1], X15
    FMOV  D26, X2
    FMOV  V26.D[1], X21
    FMOV  D27, X9
    FMOV  V27.D[1], X16
    FMOV  D28, X7
    FMOV  V28.D[1], X22
    FMOV  D29, X26
    FMOV  V29.D[1], X28
    FMOV  D30, X16
    FMOV  V30.D[1], X18
    FMOV  D31, X21
    FMOV  V31.D[1], X29
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X29, #0x20, LSL #0
    MOVZ  X16, #0x0, LSL #0
    ADD  X8, X30, X16, ASR #0
    STNP  Q29, Q31, [X8, #0]
    LDNP  Q10, Q14, [X8, #0]
    ADD  X8, X8, X29, LSR #0
    STNP  S28, S14, [X8, #0]
    LDNP  S7, S2, [X8, #0]
    ADD  X8, X8, X29, ASR #0
    STNP  D27, D30, [X8, #0]
    LDNP  D9, D29, [X8, #0]
    ADD  X8, X8, X29
    STP  Q29, Q9, [X8], #0
    LDP  Q27, Q1, [X8], #0
    ADD  X8, X8, X29, LSR #0
    STP  S25, S10, [X8], #0
    LDP  S6, S25, [X8], #0
    ADD  X8, X8, X29
    STP  D26, D2, [X8], #0
    LDP  D22, D15, [X8], #0
    ADD  X8, X8, X29, LSR #0
    STP  Q22, Q25, [X8, #0]!
    LDP  Q30, Q27, [X8, #0]!
    ADD  X8, X8, X29, ASR #0
    STP  S6, S6, [X8, #0]!
    LDP  S20, S10, [X8, #0]!
    ADD  X8, X8, X29
    STP  D28, D30, [X8, #0]!
    LDP  D11, D0, [X8, #0]!
    ADD  X8, X8, X29
    STP  Q1, Q1, [X8, #0]
    LDP  Q3, Q13, [X8, #0]
    ADD  X8, X8, X29, ASR #0
    STP  S20, S20, [X8, #0]
    LDP  S22, S18, [X8, #0]
    ADD  X8, X8, X29
    STP  D13, D22, [X8, #0]
    LDP  D27, D9, [X8, #0]
    ADD  X8, X8, X29, ASR #0
    STR  Q11, [X8], #0
    LDR  Q31, [X8], #0
    ADD  X8, X8, X29
    STR  H31, [X8], #0
    LDR  H18, [X8], #0
    ADD  X8, X8, X29, LSR #0
    STR  S3, [X8], #0
    LDR  S3, [X8], #0
    ADD  X8, X8, X29, LSR #0
    STR  D3, [X8], #0
    LDR  D9, [X8], #0
    ADD  X8, X8, X29, ASR #0
    STR  B18, [X8], #0
    LDR  B10, [X8], #0
    ADD  X8, X8, X29
    STR  Q9, [X8, #0]!
    LDR  Q25, [X8, #0]!
    ADD  X8, X8, X29
    STR  H25, [X8, #0]!
    LDR  H30, [X8, #0]!
    ADD  X8, X8, X29
    STR  S30, [X8, #0]!
    LDR  S4, [X8, #0]!
    ADD  X8, X8, X29, ASR #0
    STR  D10, [X8, #0]!
    LDR  D3, [X8, #0]!
    ADD  X8, X8, X29, LSR #0
    STR  B4, [X8, #0]!
    LDR  B2, [X8, #0]!
    ADD  X8, X8, X29, ASR #0
    STR  Q2, [X8, #0]
    LDR  Q23, [X8, #0]
    ADD  X8, X8, X29, ASR #0
    STR  H4, [X8, #0]
    LDR  H13, [X8, #0]
    ADD  X8, X8, X29
    STR  S19, [X8, #0]
    LDR  S23, [X8, #0]
    ADD  X8, X8, X29
    STR  D0, [X8, #0]
    LDR  D9, [X8, #0]
    ADD  X8, X8, X29, ASR #0
    STR  B20, [X8, #0]
    LDR  B10, [X8, #0]
    ADD  X8, X8, X29
    STR Q11, [X8, X21, LSL #0]
    LDR Q8, [X8, X21, LSL #0]
    ADD  X8, X8, X29, ASR #0
    STR Q13, [X8, W21, SXTW #4]
    LDR Q1, [X8, W21, SXTW #4]
    ADD  X8, X8, X29, ASR #0
    STR Q9, [X8, X21, SXTX #0]
    LDR Q5, [X8, X21, SXTX #4]
    ADD  X8, X8, X29, LSR #0
    STR Q5, [X8, W21, UXTW #0]
    LDR Q8, [X8, W21, UXTW #0]
    ADD  X8, X8, X29, LSR #0
    STR H11, [X8, X21, LSL #0]
    LDR H18, [X8, X21, LSL #0]
    ADD  X8, X8, X29, ASR #0
    STR H18, [X8, W21, SXTW #0]
    LDR H31, [X8, W21, SXTW #0]
    ADD  X8, X8, X29, LSR #0
    STR H1, [X8, X21, SXTX #1]
    LDR H30, [X8, X21, SXTX #1]
    ADD  X8, X8, X29
    STR H17, [X8, W21, UXTW #1]
    LDR H5, [X8, W21, UXTW #1]
    ADD  X8, X8, X29
    STR S6, [X8, X21, LSL #0]
    LDR S23, [X8, X21, LSL #2]
    ADD  X8, X8, X29, ASR #0
    STR S30, [X8, W21, SXTW #2]
    LDR S24, [X8, W21, SXTW #2]
    ADD  X8, X8, X29
    STR S27, [X8, X21, SXTX #0]
    LDR S16, [X8, X21, SXTX #0]
    ADD  X8, X8, X29, LSR #0
    STR S3, [X8, W21, UXTW #0]
    LDR S14, [X8, W21, UXTW #2]
    ADD  X8, X8, X29
    STR D31, [X8, X21, LSL #0]
    LDR D30, [X8, X21, LSL #0]
    ADD  X8, X8, X29, LSR #0
    STR D13, [X8, W21, SXTW #3]
    LDR D23, [X8, W21, SXTW #0]
    ADD  X8, X8, X29, ASR #0
    STR D23, [X8, X21, SXTX #3]
    LDR D17, [X8, X21, SXTX #3]
    ADD  X8, X8, X29, LSR #0
    STR D14, [X8, W21, UXTW #3]
    LDR D22, [X8, W21, UXTW #0]
    ADD  X8, X8, X29, ASR #0
    STR B19, [X8, X21, LSL #0]
    LDR B11, [X8, X21, LSL #0]
    ADD  X8, X8, X29, LSR #0
    STR B17, [X8, W21, SXTW #0]
    LDR B28, [X8, W21, SXTW #0]
    ADD  X8, X8, X29, ASR #0
    STR B11, [X8, X21, SXTX #0]
    LDR B22, [X8, X21, SXTX #0]
    ADD  X8, X8, X29, ASR #0
    STR B14, [X8, W21, UXTW #0]
    LDR B20, [X8, W21, UXTW #0]
    ADD  X8, X8, X29, ASR #0
    STUR  Q17, [X8, #0]
    LDUR  Q29, [X8, #0]
    ADD  X8, X8, X29, ASR #0
    STUR  H16, [X8, #0]
    LDUR  H7, [X8, #0]
    ADD  X8, X8, X29
    STUR  S10, [X8, #0]
    LDUR  S2, [X8, #0]
    ADD  X8, X8, X29, LSR #0
    STUR  D28, [X8, #0]
    LDUR  D12, [X8, #0]
    ADD  X8, X8, X29, LSR #0
    STUR  B17, [X8, #0]
    LDUR  B8, [X8, #0]
    ADD  X8, X8, X29, LSR #0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X15, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X15, FPSR
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X15, D0
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D1
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D2
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D3
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D4
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D5
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    FMOV  X15, D6
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D7
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D8
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X15, D9
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D10
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D11
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D12
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D13
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D14
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    FMOV  X15, D15
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    FMOV  X15, D16
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D17
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D18
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X15, V19.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X15, D19
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D20
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X15, V21.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X15, D21
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D22
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D23
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D24
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    FMOV  X15, D25
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X15, D26
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X15, D27
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a, LSL #0
    FMOV  X15, D28
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D29
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D30
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X15, D31
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X19
    FMOV  D3, X27
    FMOV  V3.D[1], X10
    FMOV  D4, X9
    FMOV  V4.D[1], X23
    FMOV  D5, X9
    FMOV  V5.D[1], X2
    FMOV  D6, X17
    FMOV  V6.D[1], X27
    FMOV  D7, X22
    FMOV  V7.D[1], X29
    FMOV  D8, X2
    FMOV  V8.D[1], X15
    FMOV  D9, X10
    FMOV  V9.D[1], X29
    FMOV  D10, X29
    FMOV  V10.D[1], X9
    FMOV  D11, X8
    FMOV  V11.D[1], X22
    FMOV  D12, X20
    FMOV  V12.D[1], X20
    FMOV  D13, X17
    FMOV  V13.D[1], X16
    FMOV  D14, X7
    FMOV  V14.D[1], X18
    FMOV  D15, X25
    FMOV  V15.D[1], X20
    FMOV  D16, X21
    FMOV  V16.D[1], X19
    FMOV  D17, X3
    FMOV  V17.D[1], X18
    FMOV  D18, X11
    FMOV  V18.D[1], X6
    FMOV  D19, X20
    FMOV  V19.D[1], X19
    FMOV  D20, X2
    FMOV  V20.D[1], X9
    FMOV  D21, X22
    FMOV  V21.D[1], X8
    FMOV  D22, X20
    FMOV  V22.D[1], X8
    FMOV  D23, X26
    FMOV  V23.D[1], X3
    FMOV  D24, X16
    FMOV  V24.D[1], X21
    FMOV  D25, X8
    FMOV  V25.D[1], X28
    FMOV  D26, X10
    FMOV  V26.D[1], X27
    FMOV  D27, X17
    FMOV  V27.D[1], X8
    FMOV  D28, X14
    FMOV  V28.D[1], X9
    FMOV  D29, X20
    FMOV  V29.D[1], X18
    FMOV  D30, X11
    FMOV  V30.D[1], X14
    FMOV  D31, X2
    FMOV  V31.D[1], X7
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X17, #0x20, LSL #0
    MOVZ  X2, #0x500, LSL #0
    ADD  X23, X30, X2, LSR #0
    STNP  Q31, Q30, [X23, #0]
    LDNP  Q12, Q5, [X23, #0]
    ADD  X23, X23, X17, ASR #0
    STNP  S29, S21, [X23, #0]
    LDNP  S11, S14, [X23, #0]
    ADD  X23, X23, X17, ASR #0
    STNP  D14, D11, [X23, #0]
    LDNP  D28, D10, [X23, #0]
    ADD  X23, X23, X17
    STP  Q12, Q10, [X23], #0
    LDP  Q30, Q11, [X23], #0
    ADD  X23, X23, X17
    STP  S25, S5, [X23], #0
    LDP  S9, S16, [X23], #0
    ADD  X23, X23, X17, LSR #0
    STP  D28, D11, [X23], #0
    LDP  D24, D19, [X23], #0
    ADD  X23, X23, X17
    STP  Q24, Q16, [X23, #0]!
    LDP  Q2, Q5, [X23, #0]!
    ADD  X23, X23, X17, ASR #0
    STP  S19, S30, [X23, #0]!
    LDP  S30, S8, [X23, #0]!
    ADD  X23, X23, X17, ASR #0
    STP  D30, D2, [X23, #0]!
    LDP  D21, D29, [X23, #0]!
    ADD  X23, X23, X17, LSR #0
    STP  Q5, Q21, [X23, #0]
    LDP  Q15, Q25, [X23, #0]
    ADD  X23, X23, X17
    STP  S9, S25, [X23, #0]
    LDP  S9, S11, [X23, #0]
    ADD  X23, X23, X17, LSR #0
    STP  D8, D9, [X23, #0]
    LDP  D16, D12, [X23, #0]
    ADD  X23, X23, X17, ASR #0
    STR  Q11, [X23], #0
    LDR  Q11, [X23], #0
    ADD  X23, X23, X17, LSR #0
    STR  H11, [X23], #0
    LDR  H30, [X23], #0
    ADD  X23, X23, X17, LSR #0
    STR  S31, [X23], #0
    LDR  S21, [X23], #0
    ADD  X23, X23, X17
    STR  D15, [X23], #0
    LDR  D31, [X23], #0
    ADD  X23, X23, X17
    STR  B12, [X23], #0
    LDR  B8, [X23], #0
    ADD  X23, X23, X17
    STR  Q8, [X23, #0]!
    LDR  Q9, [X23, #0]!
    ADD  X23, X23, X17, LSR #0
    STR  H30, [X23, #0]!
    LDR  H12, [X23, #0]!
    ADD  X23, X23, X17, LSR #0
    STR  S12, [X23, #0]!
    LDR  S25, [X23, #0]!
    ADD  X23, X23, X17
    STR  D31, [X23, #0]!
    LDR  D11, [X23, #0]!
    ADD  X23, X23, X17
    STR  B25, [X23, #0]!
    LDR  B30, [X23, #0]!
    ADD  X23, X23, X17, ASR #0
    STR  Q11, [X23, #0]
    LDR  Q12, [X23, #0]
    ADD  X23, X23, X17, ASR #0
    STR  H9, [X23, #0]
    LDR  H31, [X23, #0]
    ADD  X23, X23, X17, ASR #0
    STR  S30, [X23, #0]
    LDR  S11, [X23, #0]
    ADD  X23, X23, X17
    STR  D31, [X23, #0]
    LDR  D9, [X23, #0]
    ADD  X23, X23, X17, LSR #0
    STR  B16, [X23, #0]
    LDR  B16, [X23, #0]
    ADD  X23, X23, X17, LSR #0
    STR Q16, [X23, X19, LSL #0]
    LDR Q16, [X23, X19, LSL #0]
    ADD  X23, X23, X17, ASR #0
    STR Q9, [X23, W19, SXTW #4]
    LDR Q9, [X23, W19, SXTW #4]
    ADD  X23, X23, X17, LSR #0
    STR Q3, [X23, X19, SXTX #4]
    LDR Q3, [X23, X19, SXTX #0]
    ADD  X23, X23, X17, LSR #0
    STR Q16, [X23, W19, UXTW #0]
    LDR Q16, [X23, W19, UXTW #4]
    ADD  X23, X23, X17, ASR #0
    STR H11, [X23, X19, LSL #0]
    LDR H31, [X23, X19, LSL #0]
    ADD  X23, X23, X17, ASR #0
    STR H31, [X23, W19, SXTW #1]
    LDR H8, [X23, W19, SXTW #1]
    ADD  X23, X23, X17, ASR #0
    STR H9, [X23, X19, SXTX #1]
    LDR H29, [X23, X19, SXTX #0]
    ADD  X23, X23, X17, LSR #0
    STR H29, [X23, W19, UXTW #0]
    LDR H17, [X23, W19, UXTW #1]
    ADD  X23, X23, X17, ASR #0
    STR S8, [X23, X19, LSL #0]
    LDR S5, [X23, X19, LSL #2]
    ADD  X23, X23, X17
    STR S16, [X23, W19, SXTW #2]
    LDR S16, [X23, W19, SXTW #2]
    ADD  X23, X23, X17, ASR #0
    STR S17, [X23, X19, SXTX #0]
    LDR S10, [X23, X19, SXTX #2]
    ADD  X23, X23, X17, LSR #0
    STR S5, [X23, W19, UXTW #2]
    LDR S27, [X23, W19, UXTW #0]
    ADD  X23, X23, X17, ASR #0
    STR D16, [X23, X19, LSL #0]
    LDR D14, [X23, X19, LSL #0]
    ADD  X23, X23, X17, LSR #0
    STR D27, [X23, W19, SXTW #3]
    LDR D7, [X23, W19, SXTW #3]
    ADD  X23, X23, X17
    STR D7, [X23, X19, SXTX #0]
    LDR D23, [X23, X19, SXTX #3]
    ADD  X23, X23, X17
    STR D14, [X23, W19, UXTW #0]
    LDR D31, [X23, W19, UXTW #0]
    ADD  X23, X23, X17
    STR B23, [X23, X19, LSL #0]
    LDR B19, [X23, X19, LSL #0]
    ADD  X23, X23, X17, LSR #0
    STR B19, [X23, W19, SXTW #0]
    LDR B0, [X23, W19, SXTW #0]
    ADD  X23, X23, X17, ASR #0
    STR B31, [X23, X19, SXTX #0]
    LDR B24, [X23, X19, SXTX #0]
    ADD  X23, X23, X17, LSR #0
    STR B24, [X23, W19, UXTW #0]
    LDR B10, [X23, W19, UXTW #0]
    ADD  X23, X23, X17, LSR #0
    STUR  Q0, [X23, #0]
    LDUR  Q24, [X23, #0]
    ADD  X23, X23, X17, ASR #0
    STUR  H30, [X23, #0]
    LDUR  H10, [X23, #0]
    ADD  X23, X23, X17
    STUR  S31, [X23, #0]
    LDUR  S9, [X23, #0]
    ADD  X23, X23, X17
    STUR  D9, [X23, #0]
    LDUR  D21, [X23, #0]
    ADD  X23, X23, X17, LSR #0
    STUR  B25, [X23, #0]
    LDUR  B2, [X23, #0]
    ADD  X23, X23, X17, ASR #0
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X6, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X6, FPSR
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D0
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, V1.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, D1
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D2
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, V3.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, D3
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, V4.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, D4
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D5
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, V6.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, D6
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D7
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D8
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D9
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D10
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D11
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X6, D12
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, V13.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, D13
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D14
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X6, D15
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D16
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D17
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, V18.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, D18
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D19
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, V20.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, D20
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D21
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, V22.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, D22
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D23
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D24
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    FMOV  X6, D25
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, V26.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X6, D26
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D27
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X6, D28
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D29
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D30
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X6, D31
    SUB  X25, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X20
    FMOV  D3, X7
    FMOV  V3.D[1], X19
    FMOV  D4, X27
    FMOV  V4.D[1], X19
    FMOV  D5, X10
    FMOV  V5.D[1], X18
    FMOV  D6, X25
    FMOV  V6.D[1], X21
    FMOV  D7, X23
    FMOV  V7.D[1], X3
    FMOV  D8, X28
    FMOV  V8.D[1], X3
    FMOV  D9, X5
    FMOV  V9.D[1], X17
    FMOV  D10, X14
    FMOV  V10.D[1], X6
    FMOV  D11, X26
    FMOV  V11.D[1], X7
    FMOV  D12, X20
    FMOV  V12.D[1], X26
    FMOV  D13, X15
    FMOV  V13.D[1], X21
    FMOV  D14, X6
    FMOV  V14.D[1], X14
    FMOV  D15, X2
    FMOV  V15.D[1], X11
    FMOV  D16, X10
    FMOV  V16.D[1], X2
    FMOV  D17, X14
    FMOV  V17.D[1], X23
    FMOV  D18, X26
    FMOV  V18.D[1], X5
    FMOV  D19, X20
    FMOV  V19.D[1], X6
    FMOV  D20, X22
    FMOV  V20.D[1], X8
    FMOV  D21, X25
    FMOV  V21.D[1], X5
    FMOV  D22, X16
    FMOV  V22.D[1], X3
    FMOV  D23, X25
    FMOV  V23.D[1], X29
    FMOV  D24, X21
    FMOV  V24.D[1], X26
    FMOV  D25, X2
    FMOV  V25.D[1], X28
    FMOV  D26, X25
    FMOV  V26.D[1], X14
    FMOV  D27, X3
    FMOV  V27.D[1], X16
    FMOV  D28, X10
    FMOV  V28.D[1], X18
    FMOV  D29, X22
    FMOV  V29.D[1], X16
    FMOV  D30, X18
    FMOV  V30.D[1], X10
    FMOV  D31, X27
    FMOV  V31.D[1], X7
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X14, #0x20, LSL #0
    MOVZ  X11, #0xa00, LSL #0
    ADD  X19, X30, X11
    STNP  Q31, Q26, [X19, #0]
    LDNP  Q5, Q6, [X19, #0]
    ADD  X19, X19, X14, LSR #0
    STNP  S25, S30, [X19, #0]
    LDNP  S10, S23, [X19, #0]
    ADD  X19, X19, X14, LSR #0
    STNP  D10, D5, [X19, #0]
    LDNP  D19, D23, [X19, #0]
    ADD  X19, X19, X14, LSR #0
    STP  Q19, Q28, [X19], #0
    LDP  Q29, Q26, [X19], #0
    ADD  X19, X19, X14, ASR #0
    STP  S23, S26, [X19], #0
    LDP  S30, S24, [X19], #0
    ADD  X19, X19, X14
    STP  D27, D29, [X19], #0
    LDP  D2, D14, [X19], #0
    ADD  X19, X19, X14, ASR #0
    STP  Q24, Q30, [X19, #0]!
    LDP  Q31, Q13, [X19, #0]!
    ADD  X19, X19, X14
    STP  S13, S14, [X19, #0]!
    LDP  S30, S11, [X19, #0]!
    ADD  X19, X19, X14, LSR #0
    STP  D2, D30, [X19, #0]!
    LDP  D18, D11, [X19, #0]!
    ADD  X19, X19, X14, ASR #0
    STP  Q18, Q31, [X19, #0]
    LDP  Q28, Q30, [X19, #0]
    ADD  X19, X19, X14, ASR #0
    STP  S11, S11, [X19, #0]
    LDP  S11, S23, [X19, #0]
    ADD  X19, X19, X14, ASR #0
    STP  D30, D23, [X19, #0]
    LDP  D23, D5, [X19, #0]
    ADD  X19, X19, X14
    STR  Q23, [X19], #0
    LDR  Q18, [X19], #0
    ADD  X19, X19, X14, LSR #0
    STR  H18, [X19], #0
    LDR  H2, [X19], #0
    ADD  X19, X19, X14
    STR  S2, [X19], #0
    LDR  S23, [X19], #0
    ADD  X19, X19, X14, ASR #0
    STR  D23, [X19], #0
    LDR  D2, [X19], #0
    ADD  X19, X19, X14, ASR #0
    STR  B11, [X19], #0
    LDR  B11, [X19], #0
    ADD  X19, X19, X14
    STR  Q28, [X19, #0]!
    LDR  Q23, [X19, #0]!
    ADD  X19, X19, X14, ASR #0
    STR  H23, [X19, #0]!
    LDR  H28, [X19, #0]!
    ADD  X19, X19, X14, LSR #0
    STR  S28, [X19, #0]!
    LDR  S18, [X19, #0]!
    ADD  X19, X19, X14, LSR #0
    STR  D11, [X19, #0]!
    LDR  D23, [X19, #0]!
    ADD  X19, X19, X14
    STR  B2, [X19, #0]!
    LDR  B2, [X19, #0]!
    ADD  X19, X19, X14
    STR  Q23, [X19, #0]
    LDR  Q13, [X19, #0]
    ADD  X19, X19, X14, LSR #0
    STR  H13, [X19, #0]
    LDR  H9, [X19, #0]
    ADD  X19, X19, X14, LSR #0
    STR  S9, [X19, #0]
    LDR  S4, [X19, #0]
    ADD  X19, X19, X14, LSR #0
    STR  D2, [X19, #0]
    LDR  D29, [X19, #0]
    ADD  X19, X19, X14
    STR  B18, [X19, #0]
    LDR  B17, [X19, #0]
    ADD  X19, X19, X14, ASR #0
    STR Q17, [X19, X5, LSL #4]
    LDR Q0, [X19, X5, LSL #0]
    ADD  X19, X19, X14, LSR #0
    STR Q13, [X19, W5, SXTW #4]
    LDR Q13, [X19, W5, SXTW #0]
    ADD  X19, X19, X14, ASR #0
    STR Q29, [X19, X5, SXTX #4]
    LDR Q7, [X19, X5, SXTX #0]
    ADD  X19, X19, X14
    STR Q4, [X19, W5, UXTW #4]
    LDR Q11, [X19, W5, UXTW #4]
    ADD  X19, X19, X14
    STR H11, [X19, X5, LSL #1]
    LDR H15, [X19, X5, LSL #1]
    ADD  X19, X19, X14, LSR #0
    STR H15, [X19, W5, SXTW #1]
    LDR H30, [X19, W5, SXTW #0]
    ADD  X19, X19, X14, ASR #0
    STR H13, [X19, X5, SXTX #0]
    LDR H26, [X19, X5, SXTX #0]
    ADD  X19, X19, X14
    STR H6, [X19, W5, UXTW #0]
    LDR H13, [X19, W5, UXTW #1]
    ADD  X19, X19, X14, ASR #0
    STR S0, [X19, X5, LSL #0]
    LDR S10, [X19, X5, LSL #0]
    ADD  X19, X19, X14
    STR S17, [X19, W5, SXTW #0]
    LDR S25, [X19, W5, SXTW #0]
    ADD  X19, X19, X14, LSR #0
    STR S30, [X19, X5, SXTX #2]
    LDR S22, [X19, X5, SXTX #2]
    ADD  X19, X19, X14, LSR #0
    STR S13, [X19, W5, UXTW #2]
    LDR S3, [X19, W5, UXTW #0]
    ADD  X19, X19, X14
    STR D22, [X19, X5, LSL #3]
    LDR D15, [X19, X5, LSL #0]
    ADD  X19, X19, X14, LSR #0
    STR D15, [X19, W5, SXTW #0]
    LDR D28, [X19, W5, SXTW #3]
    ADD  X19, X19, X14, LSR #0
    STR D10, [X19, X5, SXTX #3]
    LDR D9, [X19, X5, SXTX #3]
    ADD  X19, X19, X14, ASR #0
    STR D28, [X19, W5, UXTW #3]
    LDR D9, [X19, W5, UXTW #0]
    ADD  X19, X19, X14, ASR #0
    STR B9, [X19, X5, LSL #0]
    LDR B5, [X19, X5, LSL #0]
    ADD  X19, X19, X14
    STR B5, [X19, W5, SXTW #0]
    LDR B26, [X19, W5, SXTW #0]
    ADD  X19, X19, X14
    STR B26, [X19, X5, SXTX #0]
    LDR B18, [X19, X5, SXTX #0]
    ADD  X19, X19, X14, ASR #0
    STR B18, [X19, W5, UXTW #0]
    LDR B22, [X19, W5, UXTW #0]
    ADD  X19, X19, X14
    STUR  Q22, [X19, #0]
    LDUR  Q28, [X19, #0]
    ADD  X19, X19, X14, LSR #0
    STUR  H9, [X19, #0]
    LDUR  H0, [X19, #0]
    ADD  X19, X19, X14, LSR #0
    STUR  S10, [X19, #0]
    LDUR  S16, [X19, #0]
    ADD  X19, X19, X14
    STUR  D21, [X19, #0]
    LDUR  D13, [X19, #0]
    ADD  X19, X19, X14, LSR #0
    STUR  B5, [X19, #0]
    LDUR  B6, [X19, #0]
    ADD  X19, X19, X14, ASR #0
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X26, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D0
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, V1.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, D1
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D2
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    FMOV  X26, D3
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D4
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D5
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D6
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D7
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, V8.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, D8
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D9
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D10
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D11
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, V12.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, D12
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, D13
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    FMOV  X26, D14
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D15
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V16.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D16
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D17
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D18
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    FMOV  X26, D19
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, V20.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, D20
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, V21.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, D21
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D22
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D23
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    FMOV  X26, D24
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D25
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D26
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, V27.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X26, D27
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V28.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D28
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D29
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V30.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a, LSL #0
    FMOV  X26, D30
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    FMOV  X26, D31
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X16
    FMOV  D3, X22
    FMOV  V3.D[1], X9
    FMOV  D4, X14
    FMOV  V4.D[1], X21
    FMOV  D5, X22
    FMOV  V5.D[1], X19
    FMOV  D6, X5
    FMOV  V6.D[1], X26
    FMOV  D7, X25
    FMOV  V7.D[1], X6
    FMOV  D8, X28
    FMOV  V8.D[1], X2
    FMOV  D9, X21
    FMOV  V9.D[1], X11
    FMOV  D10, X6
    FMOV  V10.D[1], X16
    FMOV  D11, X7
    FMOV  V11.D[1], X10
    FMOV  D12, X22
    FMOV  V12.D[1], X8
    FMOV  D13, X29
    FMOV  V13.D[1], X19
    FMOV  D14, X29
    FMOV  V14.D[1], X28
    FMOV  D15, X18
    FMOV  V15.D[1], X25
    FMOV  D16, X11
    FMOV  V16.D[1], X23
    FMOV  D17, X18
    FMOV  V17.D[1], X18
    FMOV  D18, X16
    FMOV  V18.D[1], X23
    FMOV  D19, X3
    FMOV  V19.D[1], X20
    FMOV  D20, X18
    FMOV  V20.D[1], X29
    FMOV  D21, X15
    FMOV  V21.D[1], X19
    FMOV  D22, X21
    FMOV  V22.D[1], X10
    FMOV  D23, X5
    FMOV  V23.D[1], X10
    FMOV  D24, X2
    FMOV  V24.D[1], X19
    FMOV  D25, X10
    FMOV  V25.D[1], X27
    FMOV  D26, X11
    FMOV  V26.D[1], X19
    FMOV  D27, X7
    FMOV  V27.D[1], X11
    FMOV  D28, X19
    FMOV  V28.D[1], X18
    FMOV  D29, X11
    FMOV  V29.D[1], X17
    FMOV  D30, X21
    FMOV  V30.D[1], X23
    FMOV  D31, X29
    FMOV  V31.D[1], X15
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X29, #0x20, LSL #0
    MOVZ  X16, #0xf00, LSL #0
    ADD  X10, X30, X16, LSR #0
    STNP  Q25, Q30, [X10, #0]
    LDNP  Q25, Q11, [X10, #0]
    ADD  X10, X10, X29
    STNP  S22, S31, [X10, #0]
    LDNP  S21, S16, [X10, #0]
    ADD  X10, X10, X29
    STNP  D23, D27, [X10, #0]
    LDNP  D14, D18, [X10, #0]
    ADD  X10, X10, X29, ASR #0
    STP  Q25, Q25, [X10], #0
    LDP  Q0, Q10, [X10], #0
    ADD  X10, X10, X29
    STP  S16, S0, [X10], #0
    LDP  S4, S1, [X10], #0
    ADD  X10, X10, X29, ASR #0
    STP  D21, D21, [X10], #0
    LDP  D11, D6, [X10], #0
    ADD  X10, X10, X29, LSR #0
    STP  Q11, Q14, [X10, #0]!
    LDP  Q14, Q7, [X10, #0]!
    ADD  X10, X10, X29, ASR #0
    STP  S29, S7, [X10, #0]!
    LDP  S30, S27, [X10, #0]!
    ADD  X10, X10, X29
    STP  D30, D30, [X10, #0]!
    LDP  D1, D22, [X10, #0]!
    ADD  X10, X10, X29, ASR #0
    STP  Q18, Q10, [X10, #0]
    LDP  Q18, Q28, [X10, #0]
    ADD  X10, X10, X29, LSR #0
    STP  S6, S14, [X10, #0]
    LDP  S4, S31, [X10, #0]
    ADD  X10, X10, X29, ASR #0
    STP  D28, D31, [X10, #0]
    LDP  D27, D2, [X10, #0]
    ADD  X10, X10, X29
    STR  Q2, [X10], #0
    LDR  Q14, [X10], #0
    ADD  X10, X10, X29
    STR  H18, [X10], #0
    LDR  H31, [X10], #0
    ADD  X10, X10, X29
    STR  S1, [X10], #0
    LDR  S7, [X10], #0
    ADD  X10, X10, X29
    STR  D31, [X10], #0
    LDR  D6, [X10], #0
    ADD  X10, X10, X29, LSR #0
    STR  B14, [X10], #0
    LDR  B18, [X10], #0
    ADD  X10, X10, X29, ASR #0
    STR  Q6, [X10, #0]!
    LDR  Q14, [X10, #0]!
    ADD  X10, X10, X29, LSR #0
    STR  H27, [X10, #0]!
    LDR  H31, [X10, #0]!
    ADD  X10, X10, X29, LSR #0
    STR  S7, [X10, #0]!
    LDR  S1, [X10, #0]!
    ADD  X10, X10, X29
    STR  D18, [X10, #0]!
    LDR  D18, [X10, #0]!
    ADD  X10, X10, X29, ASR #0
    STR  B19, [X10, #0]!
    LDR  B19, [X10, #0]!
    ADD  X10, X10, X29, LSR #0
    STR  Q31, [X10, #0]
    LDR  Q7, [X10, #0]
    ADD  X10, X10, X29
    STR  H1, [X10, #0]
    LDR  H27, [X10, #0]
    ADD  X10, X10, X29, LSR #0
    STR  S14, [X10, #0]
    LDR  S1, [X10, #0]
    ADD  X10, X10, X29, LSR #0
    STR  D7, [X10, #0]
    LDR  D14, [X10, #0]
    ADD  X10, X10, X29
    STR  B27, [X10, #0]
    LDR  B7, [X10, #0]
    ADD  X10, X10, X29
    STR Q7, [X10, X3, LSL #4]
    LDR Q31, [X10, X3, LSL #4]
    ADD  X10, X10, X29, ASR #0
    STR Q19, [X10, W3, SXTW #0]
    LDR Q2, [X10, W3, SXTW #0]
    ADD  X10, X10, X29
    STR Q31, [X10, X3, SXTX #0]
    LDR Q9, [X10, X3, SXTX #0]
    ADD  X10, X10, X29
    STR Q1, [X10, W3, UXTW #4]
    LDR Q7, [X10, W3, UXTW #0]
    ADD  X10, X10, X29, LSR #0
    STR H7, [X10, X3, LSL #0]
    LDR H28, [X10, X3, LSL #0]
    ADD  X10, X10, X29, ASR #0
    STR H14, [X10, W3, SXTW #1]
    LDR H4, [X10, W3, SXTW #0]
    ADD  X10, X10, X29
    STR H4, [X10, X3, SXTX #1]
    LDR H25, [X10, X3, SXTX #1]
    ADD  X10, X10, X29
    STR H28, [X10, W3, UXTW #1]
    LDR H7, [X10, W3, UXTW #1]
    ADD  X10, X10, X29, ASR #0
    STR S25, [X10, X3, LSL #2]
    LDR S7, [X10, X3, LSL #0]
    ADD  X10, X10, X29, ASR #0
    STR S9, [X10, W3, SXTW #2]
    LDR S3, [X10, W3, SXTW #0]
    ADD  X10, X10, X29, ASR #0
    STR S2, [X10, X3, SXTX #0]
    LDR S16, [X10, X3, SXTX #2]
    ADD  X10, X10, X29, ASR #0
    STR S7, [X10, W3, UXTW #2]
    LDR S25, [X10, W3, UXTW #2]
    ADD  X10, X10, X29, ASR #0
    STR D3, [X10, X3, LSL #0]
    LDR D23, [X10, X3, LSL #3]
    ADD  X10, X10, X29, ASR #0
    STR D16, [X10, W3, SXTW #0]
    LDR D26, [X10, W3, SXTW #3]
    ADD  X10, X10, X29, ASR #0
    STR D25, [X10, X3, SXTX #3]
    LDR D10, [X10, X3, SXTX #3]
    ADD  X10, X10, X29, ASR #0
    STR D23, [X10, W3, UXTW #3]
    LDR D7, [X10, W3, UXTW #3]
    ADD  X10, X10, X29
    STR B26, [X10, X3, LSL #0]
    LDR B23, [X10, X3, LSL #0]
    ADD  X10, X10, X29, ASR #0
    STR B23, [X10, W3, SXTW #0]
    LDR B20, [X10, W3, SXTW #0]
    ADD  X10, X10, X29, ASR #0
    STR B10, [X10, X3, SXTX #0]
    LDR B3, [X10, X3, SXTX #0]
    ADD  X10, X10, X29, ASR #0
    STR B3, [X10, W3, UXTW #0]
    LDR B13, [X10, W3, UXTW #0]
    ADD  X10, X10, X29, LSR #0
    STUR  Q13, [X10, #0]
    LDUR  Q20, [X10, #0]
    ADD  X10, X10, X29, LSR #0
    STUR  H20, [X10, #0]
    LDUR  H31, [X10, #0]
    ADD  X10, X10, X29, LSR #0
    STUR  S30, [X10, #0]
    LDUR  S21, [X10, #0]
    ADD  X10, X10, X29, ASR #0
    STUR  D31, [X10, #0]
    LDUR  D14, [X10, #0]
    ADD  X10, X10, X29
    STUR  B3, [X10, #0]
    LDUR  B24, [X10, #0]
    ADD  X10, X10, X29
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, D0
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    FMOV  X21, D1
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V2.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D2
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D3
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    FMOV  X21, D4
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, V5.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, D5
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    FMOV  X21, D6
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D7
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, D8
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D9
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    FMOV  X21, D10
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    FMOV  X21, D11
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, V12.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, D12
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D13
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D14
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, V15.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, D15
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D16
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, D17
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D18
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D19
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D20
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    FMOV  X21, D21
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    FMOV  X21, D22
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D23
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D24
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    FMOV  X21, D25
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D26
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    FMOV  X21, D27
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    FMOV  X21, D28
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, V29.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X21, D29
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    FMOV  X21, D30
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X28, #0xa5, LSL #0
    FMOV  X21, D31
    SUB  X2, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X18
    FMOV  D3, X23
    FMOV  V3.D[1], X3
    FMOV  D4, X16
    FMOV  V4.D[1], X23
    FMOV  D5, X20
    FMOV  V5.D[1], X15
    FMOV  D6, X19
    FMOV  V6.D[1], X11
    FMOV  D7, X18
    FMOV  V7.D[1], X17
    FMOV  D8, X16
    FMOV  V8.D[1], X28
    FMOV  D9, X25
    FMOV  V9.D[1], X22
    FMOV  D10, X16
    FMOV  V10.D[1], X21
    FMOV  D11, X5
    FMOV  V11.D[1], X21
    FMOV  D12, X17
    FMOV  V12.D[1], X10
    FMOV  D13, X21
    FMOV  V13.D[1], X2
    FMOV  D14, X7
    FMOV  V14.D[1], X8
    FMOV  D15, X19
    FMOV  V15.D[1], X11
    FMOV  D16, X25
    FMOV  V16.D[1], X10
    FMOV  D17, X14
    FMOV  V17.D[1], X26
    FMOV  D18, X7
    FMOV  V18.D[1], X11
    FMOV  D19, X26
    FMOV  V19.D[1], X27
    FMOV  D20, X21
    FMOV  V20.D[1], X15
    FMOV  D21, X26
    FMOV  V21.D[1], X11
    FMOV  D22, X11
    FMOV  V22.D[1], X29
    FMOV  D23, X15
    FMOV  V23.D[1], X11
    FMOV  D24, X3
    FMOV  V24.D[1], X8
    FMOV  D25, X25
    FMOV  V25.D[1], X5
    FMOV  D26, X9
    FMOV  V26.D[1], X15
    FMOV  D27, X29
    FMOV  V27.D[1], X3
    FMOV  D28, X10
    FMOV  V28.D[1], X3
    FMOV  D29, X11
    FMOV  V29.D[1], X9
    FMOV  D30, X2
    FMOV  V30.D[1], X29
    FMOV  D31, X15
    FMOV  V31.D[1], X8
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X19, #0x20, LSL #0
    MOVZ  X25, #0x1400, LSL #0
    ADD  X18, X30, X25, LSR #0
    STNP  Q31, Q27, [X18, #0]
    LDNP  Q18, Q31, [X18, #0]
    ADD  X18, X18, X19, LSR #0
    STNP  S21, S30, [X18, #0]
    LDNP  S25, S26, [X18, #0]
    ADD  X18, X18, X19
    STNP  D25, D18, [X18, #0]
    LDNP  D3, D11, [X18, #0]
    ADD  X18, X18, X19
    STP  Q28, Q29, [X18], #0
    LDP  Q19, Q24, [X18], #0
    ADD  X18, X18, X19, LSR #0
    STP  S19, S26, [X18], #0
    LDP  S30, S13, [X18], #0
    ADD  X18, X18, X19, ASR #0
    STP  D31, D30, [X18], #0
    LDP  D2, D8, [X18], #0
    ADD  X18, X18, X19, LSR #0
    STP  Q11, Q26, [X18, #0]!
    LDP  Q26, Q24, [X18, #0]!
    ADD  X18, X18, X19
    STP  S26, S1, [X18, #0]!
    LDP  S28, S1, [X18, #0]!
    ADD  X18, X18, X19, ASR #0
    STP  D13, D3, [X18, #0]!
    LDP  D13, D11, [X18, #0]!
    ADD  X18, X18, X19, LSR #0
    STP  Q28, Q13, [X18, #0]
    LDP  Q0, Q25, [X18, #0]
    ADD  X18, X18, X19
    STP  S11, S8, [X18, #0]
    LDP  S25, S21, [X18, #0]
    ADD  X18, X18, X19, ASR #0
    STP  D24, D1, [X18, #0]
    LDP  D11, D13, [X18, #0]
    ADD  X18, X18, X19
    STR  Q30, [X18], #0
    LDR  Q17, [X18], #0
    ADD  X18, X18, X19, ASR #0
    STR  H25, [X18], #0
    LDR  H6, [X18], #0
    ADD  X18, X18, X19, ASR #0
    STR  S6, [X18], #0
    LDR  S21, [X18], #0
    ADD  X18, X18, X19, ASR #0
    STR  D0, [X18], #0
    LDR  D20, [X18], #0
    ADD  X18, X18, X19
    STR  B17, [X18], #0
    LDR  B8, [X18], #0
    ADD  X18, X18, X19, ASR #0
    STR  Q1, [X18, #0]!
    LDR  Q2, [X18, #0]!
    ADD  X18, X18, X19, LSR #0
    STR  H2, [X18, #0]!
    LDR  H14, [X18, #0]!
    ADD  X18, X18, X19, LSR #0
    STR  S8, [X18, #0]!
    LDR  S21, [X18, #0]!
    ADD  X18, X18, X19
    STR  D20, [X18, #0]!
    LDR  D18, [X18, #0]!
    ADD  X18, X18, X19, ASR #0
    STR  B14, [X18, #0]!
    LDR  B2, [X18, #0]!
    ADD  X18, X18, X19, ASR #0
    STR  Q18, [X18, #0]
    LDR  Q6, [X18, #0]
    ADD  X18, X18, X19, LSR #0
    STR  H6, [X18, #0]
    LDR  H23, [X18, #0]
    ADD  X18, X18, X19
    STR  S2, [X18, #0]
    LDR  S11, [X18, #0]
    ADD  X18, X18, X19
    STR  D18, [X18, #0]
    LDR  D7, [X18, #0]
    ADD  X18, X18, X19, LSR #0
    STR  B21, [X18, #0]
    LDR  B14, [X18, #0]
    ADD  X18, X18, X19, LSR #0
    STR Q1, [X18, X14, LSL #4]
    LDR Q22, [X18, X14, LSL #0]
    ADD  X18, X18, X19, ASR #0
    STR Q11, [X18, W14, SXTW #0]
    LDR Q31, [X18, W14, SXTW #0]
    ADD  X18, X18, X19, LSR #0
    STR Q13, [X18, X14, SXTX #0]
    LDR Q6, [X18, X14, SXTX #0]
    ADD  X18, X18, X19, ASR #0
    STR Q23, [X18, W14, UXTW #0]
    LDR Q26, [X18, W14, UXTW #0]
    ADD  X18, X18, X19, ASR #0
    STR H22, [X18, X14, LSL #1]
    LDR H19, [X18, X14, LSL #1]
    ADD  X18, X18, X19
    STR H6, [X18, W14, SXTW #0]
    LDR H4, [X18, W14, SXTW #1]
    ADD  X18, X18, X19, LSR #0
    STR H14, [X18, X14, SXTX #1]
    LDR H31, [X18, X14, SXTX #0]
    ADD  X18, X18, X19, LSR #0
    STR H26, [X18, W14, UXTW #1]
    LDR H30, [X18, W14, UXTW #1]
    ADD  X18, X18, X19
    STR S31, [X18, X14, LSL #0]
    LDR S4, [X18, X14, LSL #2]
    ADD  X18, X18, X19
    STR S19, [X18, W14, SXTW #2]
    LDR S0, [X18, W14, SXTW #2]
    ADD  X18, X18, X19, LSR #0
    STR S4, [X18, X14, SXTX #2]
    LDR S31, [X18, X14, SXTX #2]
    ADD  X18, X18, X19
    STR S0, [X18, W14, UXTW #2]
    LDR S18, [X18, W14, UXTW #0]
    ADD  X18, X18, X19, LSR #0
    STR D18, [X18, X14, LSL #0]
    LDR D6, [X18, X14, LSL #3]
    ADD  X18, X18, X19
    STR D30, [X18, W14, SXTW #0]
    LDR D22, [X18, W14, SXTW #3]
    ADD  X18, X18, X19
    STR D6, [X18, X14, SXTX #0]
    LDR D29, [X18, X14, SXTX #0]
    ADD  X18, X18, X19, LSR #0
    STR D31, [X18, W14, UXTW #0]
    LDR D28, [X18, W14, UXTW #3]
    ADD  X18, X18, X19
    STR B22, [X18, X14, LSL #0]
    LDR B18, [X18, X14, LSL #0]
    ADD  X18, X18, X19, LSR #0
    STR B29, [X18, W14, SXTW #0]
    LDR B12, [X18, W14, SXTW #0]
    ADD  X18, X18, X19, LSR #0
    STR B28, [X18, X14, SXTX #0]
    LDR B8, [X18, X14, SXTX #0]
    ADD  X18, X18, X19, LSR #0
    STR B18, [X18, W14, UXTW #0]
    LDR B15, [X18, W14, UXTW #0]
    ADD  X18, X18, X19
    STUR  Q15, [X18, #0]
    LDUR  Q19, [X18, #0]
    ADD  X18, X18, X19
    STUR  H15, [X18, #0]
    LDUR  H25, [X18, #0]
    ADD  X18, X18, X19, LSR #0
    STUR  S19, [X18, #0]
    LDUR  S0, [X18, #0]
    ADD  X18, X18, X19, ASR #0
    STUR  D25, [X18, #0]
    LDUR  D11, [X18, #0]
    ADD  X18, X18, X19
    STUR  B8, [X18, #0]
    LDUR  B31, [X18, #0]
    ADD  X18, X18, X19
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X26, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D0
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    FMOV  X26, D1
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D2
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    FMOV  X26, D3
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D4
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, V5.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, D5
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    FMOV  X26, D6
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    FMOV  X26, D7
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D8
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, V9.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, D9
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, V10.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, D10
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D11
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D12
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    FMOV  X26, D13
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D14
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D15
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, V16.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, D16
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    FMOV  X26, D17
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D18
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D19
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    FMOV  X26, D20
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D21
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    FMOV  X26, D22
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    FMOV  X26, D23
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    FMOV  X26, D24
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D25
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    FMOV  X26, D26
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, V27.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X26, D27
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V28.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D28
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    FMOV  X26, D29
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V30.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    FMOV  X26, D30
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x5a, LSL #0
    FMOV  X26, D31
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X17
    FMOV  D3, X5
    FMOV  V3.D[1], X28
    FMOV  D4, X22
    FMOV  V4.D[1], X14
    FMOV  D5, X20
    FMOV  V5.D[1], X14
    FMOV  D6, X28
    FMOV  V6.D[1], X21
    FMOV  D7, X3
    FMOV  V7.D[1], X8
    FMOV  D8, X20
    FMOV  V8.D[1], X18
    FMOV  D9, X10
    FMOV  V9.D[1], X15
    FMOV  D10, X25
    FMOV  V10.D[1], X16
    FMOV  D11, X9
    FMOV  V11.D[1], X2
    FMOV  D12, X21
    FMOV  V12.D[1], X26
    FMOV  D13, X11
    FMOV  V13.D[1], X26
    FMOV  D14, X23
    FMOV  V14.D[1], X28
    FMOV  D15, X15
    FMOV  V15.D[1], X19
    FMOV  D16, X2
    FMOV  V16.D[1], X2
    FMOV  D17, X3
    FMOV  V17.D[1], X23
    FMOV  D18, X27
    FMOV  V18.D[1], X9
    FMOV  D19, X10
    FMOV  V19.D[1], X2
    FMOV  D20, X16
    FMOV  V20.D[1], X29
    FMOV  D21, X6
    FMOV  V21.D[1], X23
    FMOV  D22, X27
    FMOV  V22.D[1], X27
    FMOV  D23, X11
    FMOV  V23.D[1], X15
    FMOV  D24, X18
    FMOV  V24.D[1], X10
    FMOV  D25, X22
    FMOV  V25.D[1], X6
    FMOV  D26, X6
    FMOV  V26.D[1], X29
    FMOV  D27, X3
    FMOV  V27.D[1], X14
    FMOV  D28, X14
    FMOV  V28.D[1], X11
    FMOV  D29, X27
    FMOV  V29.D[1], X26
    FMOV  D30, X23
    FMOV  V30.D[1], X8
    FMOV  D31, X20
    FMOV  V31.D[1], X18
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X6, #0x20, LSL #0
    MOVZ  X17, #0x1900, LSL #0
    ADD  X28, X30, X17, ASR #0
    STNP  Q25, Q29, [X28, #0]
    LDNP  Q27, Q24, [X28, #0]
    ADD  X28, X28, X6, LSR #0
    STNP  S22, S27, [X28, #0]
    LDNP  S27, S1, [X28, #0]
    ADD  X28, X28, X6
    STNP  D30, D31, [X28, #0]
    LDNP  D18, D1, [X28, #0]
    ADD  X28, X28, X6, ASR #0
    STP  Q24, Q1, [X28], #0
    LDP  Q9, Q1, [X28], #0
    ADD  X28, X28, X6, ASR #0
    STP  S27, S9, [X28], #0
    LDP  S16, S10, [X28], #0
    ADD  X28, X28, X6, ASR #0
    STP  D18, D16, [X28], #0
    LDP  D30, D5, [X28], #0
    ADD  X28, X28, X6, LSR #0
    STP  Q10, Q30, [X28, #0]!
    LDP  Q25, Q12, [X28, #0]!
    ADD  X28, X28, X6
    STP  S12, S5, [X28, #0]!
    LDP  S23, S16, [X28, #0]!
    ADD  X28, X28, X6, ASR #0
    STP  D25, D23, [X28, #0]!
    LDP  D13, D21, [X28, #0]!
    ADD  X28, X28, X6
    STP  Q1, Q13, [X28, #0]
    LDP  Q24, Q25, [X28, #0]
    ADD  X28, X28, X6
    STP  S16, S16, [X28, #0]
    LDP  S23, S31, [X28, #0]
    ADD  X28, X28, X6
    STP  D21, D21, [X28, #0]
    LDP  D18, D5, [X28, #0]
    ADD  X28, X28, X6
    STR  Q3, [X28], #0
    LDR  Q21, [X28], #0
    ADD  X28, X28, X6, ASR #0
    STR  H24, [X28], #0
    LDR  H12, [X28], #0
    ADD  X28, X28, X6, LSR #0
    STR  S9, [X28], #0
    LDR  S1, [X28], #0
    ADD  X28, X28, X6, ASR #0
    STR  D21, [X28], #0
    LDR  D24, [X28], #0
    ADD  X28, X28, X6
    STR  B12, [X28], #0
    LDR  B16, [X28], #0
    ADD  X28, X28, X6, ASR #0
    STR  Q18, [X28, #0]!
    LDR  Q9, [X28, #0]!
    ADD  X28, X28, X6, ASR #0
    STR  H1, [X28, #0]!
    LDR  H1, [X28, #0]!
    ADD  X28, X28, X6, ASR #0
    STR  S9, [X28, #0]!
    LDR  S21, [X28, #0]!
    ADD  X28, X28, X6, ASR #0
    STR  D24, [X28, #0]!
    LDR  D24, [X28, #0]!
    ADD  X28, X28, X6, ASR #0
    STR  B1, [X28, #0]!
    LDR  B9, [X28, #0]!
    ADD  X28, X28, X6, LSR #0
    STR  Q9, [X28, #0]
    LDR  Q9, [X28, #0]
    ADD  X28, X28, X6, LSR #0
    STR  H16, [X28, #0]
    LDR  H1, [X28, #0]
    ADD  X28, X28, X6, ASR #0
    STR  S21, [X28, #0]
    LDR  S21, [X28, #0]
    ADD  X28, X28, X6, ASR #0
    STR  D24, [X28, #0]
    LDR  D24, [X28, #0]
    ADD  X28, X28, X6, ASR #0
    STR  B21, [X28, #0]
    LDR  B21, [X28, #0]
    ADD  X28, X28, X6
    STR Q10, [X28, X18, LSL #0]
    LDR Q12, [X28, X18, LSL #0]
    ADD  X28, X28, X6, ASR #0
    STR Q24, [X28, W18, SXTW #0]
    LDR Q4, [X28, W18, SXTW #0]
    ADD  X28, X28, X6
    STR Q9, [X28, X18, SXTX #0]
    LDR Q30, [X28, X18, SXTX #4]
    ADD  X28, X28, X6
    STR Q21, [X28, W18, UXTW #4]
    LDR Q8, [X28, W18, UXTW #0]
    ADD  X28, X28, X6, LSR #0
    STR H12, [X28, X18, LSL #1]
    LDR H10, [X28, X18, LSL #1]
    ADD  X28, X28, X6
    STR H10, [X28, W18, SXTW #1]
    LDR H24, [X28, W18, SXTW #0]
    ADD  X28, X28, X6, LSR #0
    STR H8, [X28, X18, SXTX #0]
    LDR H31, [X28, X18, SXTX #1]
    ADD  X28, X28, X6, LSR #0
    STR H4, [X28, W18, UXTW #1]
    LDR H9, [X28, W18, UXTW #0]
    ADD  X28, X28, X6, ASR #0
    STR S31, [X28, X18, LSL #2]
    LDR S25, [X28, X18, LSL #0]
    ADD  X28, X28, X6, LSR #0
    STR S30, [X28, W18, SXTW #2]
    LDR S11, [X28, W18, SXTW #2]
    ADD  X28, X28, X6, ASR #0
    STR S11, [X28, X18, SXTX #2]
    LDR S5, [X28, X18, SXTX #2]
    ADD  X28, X28, X6
    STR S5, [X28, W18, UXTW #2]
    LDR S29, [X28, W18, UXTW #0]
    ADD  X28, X28, X6, LSR #0
    STR D24, [X28, X18, LSL #0]
    LDR D9, [X28, X18, LSL #0]
    ADD  X28, X28, X6, LSR #0
    STR D25, [X28, W18, SXTW #0]
    LDR D7, [X28, W18, SXTW #0]
    ADD  X28, X28, X6, LSR #0
    STR D29, [X28, X18, SXTX #0]
    LDR D11, [X28, X18, SXTX #0]
    ADD  X28, X28, X6, LSR #0
    STR D7, [X28, W18, UXTW #3]
    LDR D8, [X28, W18, UXTW #3]
    ADD  X28, X28, X6, LSR #0
    STR B9, [X28, X18, LSL #0]
    LDR B14, [X28, X18, LSL #0]
    ADD  X28, X28, X6, LSR #0
    STR B14, [X28, W18, SXTW #0]
    LDR B6, [X28, W18, SXTW #0]
    ADD  X28, X28, X6, LSR #0
    STR B8, [X28, X18, SXTX #0]
    LDR B5, [X28, X18, SXTX #0]
    ADD  X28, X28, X6, ASR #0
    STR B5, [X28, W18, UXTW #0]
    LDR B22, [X28, W18, UXTW #0]
    ADD  X28, X28, X6, ASR #0
    STUR  Q22, [X28, #0]
    LDUR  Q10, [X28, #0]
    ADD  X28, X28, X6, ASR #0
    STUR  H6, [X28, #0]
    LDUR  H12, [X28, #0]
    ADD  X28, X28, X6
    STUR  S10, [X28, #0]
    LDUR  S18, [X28, #0]
    ADD  X28, X28, X6
    STUR  D12, [X28, #0]
    LDUR  D28, [X28, #0]
    ADD  X28, X28, X6
    STUR  B28, [X28, #0]
    LDUR  B9, [X28, #0]
    ADD  X28, X28, X6, ASR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X21, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, D0
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D1
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, D2
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, V3.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, D3
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, D4
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D5
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D6
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D7
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D8
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D9
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D10
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D11
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D12
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X21, D13
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D14
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, V15.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, D15
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D16
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, D17
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D18
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, D19
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, V20.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, D20
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D21
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D22
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X21, D23
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    FMOV  X21, D24
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D25
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, V26.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X21, D26
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X21, D27
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D28
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D29
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D30
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X21, D31
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X2
    FMOV  D3, X20
    FMOV  V3.D[1], X9
    FMOV  D4, X14
    FMOV  V4.D[1], X28
    FMOV  D5, X17
    FMOV  V5.D[1], X16
    FMOV  D6, X19
    FMOV  V6.D[1], X14
    FMOV  D7, X29
    FMOV  V7.D[1], X17
    FMOV  D8, X18
    FMOV  V8.D[1], X23
    FMOV  D9, X10
    FMOV  V9.D[1], X20
    FMOV  D10, X17
    FMOV  V10.D[1], X5
    FMOV  D11, X29
    FMOV  V11.D[1], X5
    FMOV  D12, X7
    FMOV  V12.D[1], X7
    FMOV  D13, X23
    FMOV  V13.D[1], X2
    FMOV  D14, X10
    FMOV  V14.D[1], X20
    FMOV  D15, X2
    FMOV  V15.D[1], X22
    FMOV  D16, X20
    FMOV  V16.D[1], X21
    FMOV  D17, X5
    FMOV  V17.D[1], X6
    FMOV  D18, X15
    FMOV  V18.D[1], X5
    FMOV  D19, X10
    FMOV  V19.D[1], X22
    FMOV  D20, X9
    FMOV  V20.D[1], X14
    FMOV  D21, X8
    FMOV  V21.D[1], X5
    FMOV  D22, X8
    FMOV  V22.D[1], X16
    FMOV  D23, X18
    FMOV  V23.D[1], X17
    FMOV  D24, X25
    FMOV  V24.D[1], X28
    FMOV  D25, X10
    FMOV  V25.D[1], X20
    FMOV  D26, X10
    FMOV  V26.D[1], X10
    FMOV  D27, X15
    FMOV  V27.D[1], X29
    FMOV  D28, X18
    FMOV  V28.D[1], X2
    FMOV  D29, X29
    FMOV  V29.D[1], X15
    FMOV  D30, X6
    FMOV  V30.D[1], X15
    FMOV  D31, X8
    FMOV  V31.D[1], X9
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X2, #0x20, LSL #0
    MOVZ  X28, #0x1e00, LSL #0
    ADD  X7, X30, X28
    STNP  Q27, Q29, [X7, #0]
    LDNP  Q12, Q24, [X7, #0]
    ADD  X7, X7, X2, ASR #0
    STNP  S12, S12, [X7, #0]
    LDNP  S12, S17, [X7, #0]
    ADD  X7, X7, X2, ASR #0
    STNP  D12, D30, [X7, #0]
    LDNP  D15, D29, [X7, #0]
    ADD  X7, X7, X2
    STP  Q31, Q28, [X7], #0
    LDP  Q3, Q29, [X7], #0
    ADD  X7, X7, X2
    STP  S17, S24, [X7], #0
    LDP  S22, S24, [X7], #0
    ADD  X7, X7, X2, LSR #0
    STP  D3, D22, [X7], #0
    LDP  D18, D24, [X7], #0
    ADD  X7, X7, X2
    STP  Q15, Q29, [X7, #0]!
    LDP  Q15, Q3, [X7, #0]!
    ADD  X7, X7, X2, LSR #0
    STP  S24, S8, [X7, #0]!
    LDP  S21, S14, [X7, #0]!
    ADD  X7, X7, X2, LSR #0
    STP  D27, D18, [X7, #0]!
    LDP  D5, D16, [X7, #0]!
    ADD  X7, X7, X2, ASR #0
    STP  Q16, Q21, [X7, #0]
    LDP  Q4, Q14, [X7, #0]
    ADD  X7, X7, X2
    STP  S15, S15, [X7, #0]
    LDP  S19, S13, [X7, #0]
    ADD  X7, X7, X2, ASR #0
    STP  D13, D0, [X7, #0]
    LDP  D15, D16, [X7, #0]
    ADD  X7, X7, X2, LSR #0
    STR  Q19, [X7], #0
    LDR  Q19, [X7], #0
    ADD  X7, X7, X2, ASR #0
    STR  H19, [X7], #0
    LDR  H13, [X7], #0
    ADD  X7, X7, X2, LSR #0
    STR  S4, [X7], #0
    LDR  S21, [X7], #0
    ADD  X7, X7, X2, ASR #0
    STR  D16, [X7], #0
    LDR  D18, [X7], #0
    ADD  X7, X7, X2, LSR #0
    STR  B14, [X7], #0
    LDR  B14, [X7], #0
    ADD  X7, X7, X2
    STR  Q5, [X7, #0]!
    LDR  Q0, [X7, #0]!
    ADD  X7, X7, X2, ASR #0
    STR  H18, [X7, #0]!
    LDR  H18, [X7, #0]!
    ADD  X7, X7, X2, LSR #0
    STR  S21, [X7, #0]!
    LDR  S19, [X7, #0]!
    ADD  X7, X7, X2
    STR  D18, [X7, #0]!
    LDR  D5, [X7, #0]!
    ADD  X7, X7, X2, ASR #0
    STR  B0, [X7, #0]!
    LDR  B4, [X7, #0]!
    ADD  X7, X7, X2
    STR  Q14, [X7, #0]
    LDR  Q16, [X7, #0]
    ADD  X7, X7, X2
    STR  H19, [X7, #0]
    LDR  H14, [X7, #0]
    ADD  X7, X7, X2
    STR  S14, [X7, #0]
    LDR  S28, [X7, #0]
    ADD  X7, X7, X2, LSR #0
    STR  D28, [X7, #0]
    LDR  D0, [X7, #0]
    ADD  X7, X7, X2, LSR #0
    STR  B5, [X7, #0]
    LDR  B19, [X7, #0]
    ADD  X7, X7, X2
    STR Q16, [X7, X25, LSL #4]
    LDR Q5, [X7, X25, LSL #0]
    ADD  X7, X7, X2, ASR #0
    STR Q4, [X7, W25, SXTW #0]
    LDR Q28, [X7, W25, SXTW #0]
    ADD  X7, X7, X2
    STR Q0, [X7, X25, SXTX #4]
    LDR Q18, [X7, X25, SXTX #4]
    ADD  X7, X7, X2
    STR Q5, [X7, W25, UXTW #4]
    LDR Q14, [X7, W25, UXTW #4]
    ADD  X7, X7, X2, LSR #0
    STR H18, [X7, X25, LSL #1]
    LDR H16, [X7, X25, LSL #1]
    ADD  X7, X7, X2, ASR #0
    STR H16, [X7, W25, SXTW #1]
    LDR H0, [X7, W25, SXTW #1]
    ADD  X7, X7, X2, LSR #0
    STR H28, [X7, X25, SXTX #1]
    LDR H5, [X7, X25, SXTX #1]
    ADD  X7, X7, X2, ASR #0
    STR H5, [X7, W25, UXTW #0]
    LDR H1, [X7, W25, UXTW #1]
    ADD  X7, X7, X2
    STR S14, [X7, X25, LSL #0]
    LDR S5, [X7, X25, LSL #2]
    ADD  X7, X7, X2, ASR #0
    STR S19, [X7, W25, SXTW #2]
    LDR S4, [X7, W25, SXTW #0]
    ADD  X7, X7, X2
    STR S21, [X7, X25, SXTX #0]
    LDR S21, [X7, X25, SXTX #0]
    ADD  X7, X7, X2, ASR #0
    STR S0, [X7, W25, UXTW #0]
    LDR S18, [X7, W25, UXTW #0]
    ADD  X7, X7, X2, ASR #0
    STR D21, [X7, X25, LSL #3]
    LDR D28, [X7, X25, LSL #3]
    ADD  X7, X7, X2
    STR D28, [X7, W25, SXTW #3]
    LDR D0, [X7, W25, SXTW #3]
    ADD  X7, X7, X2
    STR D18, [X7, X25, SXTX #3]
    LDR D18, [X7, X25, SXTX #3]
    ADD  X7, X7, X2, ASR #0
    STR D1, [X7, W25, UXTW #0]
    LDR D14, [X7, W25, UXTW #0]
    ADD  X7, X7, X2, LSR #0
    STR B5, [X7, X25, LSL #0]
    LDR B21, [X7, X25, LSL #0]
    ADD  X7, X7, X2
    STR B14, [X7, W25, SXTW #0]
    LDR B28, [X7, W25, SXTW #0]
    ADD  X7, X7, X2, ASR #0
    STR B18, [X7, X25, SXTX #0]
    LDR B1, [X7, X25, SXTX #0]
    ADD  X7, X7, X2, LSR #0
    STR B21, [X7, W25, UXTW #0]
    LDR B21, [X7, W25, UXTW #0]
    ADD  X7, X7, X2, ASR #0
    STUR  Q1, [X7, #0]
    LDUR  Q14, [X7, #0]
    ADD  X7, X7, X2
    STUR  H28, [X7, #0]
    LDUR  H18, [X7, #0]
    ADD  X7, X7, X2
    STUR  S18, [X7, #0]
    LDUR  S1, [X7, #0]
    ADD  X7, X7, X2
    STUR  D21, [X7, #0]
    LDUR  D5, [X7, #0]
    ADD  X7, X7, X2, ASR #0
    STUR  B14, [X7, #0]
    LDUR  B14, [X7, #0]
    ADD  X7, X7, X2
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X17, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    FMOV  X17, D0
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    FMOV  X17, D1
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V2.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D2
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V3.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D3
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    FMOV  X17, D4
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    FMOV  X17, D5
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V6.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D6
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V7.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D7
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V8.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D8
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V9.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D9
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V10.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D10
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V11.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D11
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    FMOV  X17, D12
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    FMOV  X17, D13
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    FMOV  X17, D14
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    FMOV  X17, D15
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    FMOV  X17, D16
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    FMOV  X17, D17
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    FMOV  X17, D18
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    FMOV  X17, D19
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V20.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D20
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    FMOV  X17, D21
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    FMOV  X17, D22
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V23.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D23
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    FMOV  X17, D24
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V25.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D25
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V26.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D26
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V27.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D27
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a, LSL #0
    FMOV  X17, D28
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V29.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D29
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V30.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D30
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, V31.D[1]
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X17, D31
    SUB  X19, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X14
    FMOV  V3.D[1], X20
    FMOV  D4, X21
    FMOV  V4.D[1], X17
    FMOV  D5, X10
    FMOV  V5.D[1], X28
    FMOV  D6, X5
    FMOV  V6.D[1], X21
    FMOV  D7, X6
    FMOV  V7.D[1], X15
    FMOV  D8, X3
    FMOV  V8.D[1], X3
    FMOV  D9, X10
    FMOV  V9.D[1], X3
    FMOV  D10, X26
    FMOV  V10.D[1], X15
    FMOV  D11, X14
    FMOV  V11.D[1], X20
    FMOV  D12, X20
    FMOV  V12.D[1], X6
    FMOV  D13, X14
    FMOV  V13.D[1], X18
    FMOV  D14, X29
    FMOV  V14.D[1], X8
    FMOV  D15, X11
    FMOV  V15.D[1], X22
    FMOV  D16, X5
    FMOV  V16.D[1], X21
    FMOV  D17, X19
    FMOV  V17.D[1], X28
    FMOV  D18, X29
    FMOV  V18.D[1], X25
    FMOV  D19, X11
    FMOV  V19.D[1], X19
    FMOV  D20, X15
    FMOV  V20.D[1], X23
    FMOV  D21, X28
    FMOV  V21.D[1], X29
    FMOV  D22, X11
    FMOV  V22.D[1], X7
    FMOV  D23, X26
    FMOV  V23.D[1], X21
    FMOV  D24, X19
    FMOV  V24.D[1], X9
    FMOV  D25, X27
    FMOV  V25.D[1], X7
    FMOV  D26, X3
    FMOV  V26.D[1], X8
    FMOV  D27, X10
    FMOV  V27.D[1], X25
    FMOV  D28, X23
    FMOV  V28.D[1], X22
    FMOV  D29, X7
    FMOV  V29.D[1], X26
    FMOV  D30, X18
    FMOV  V30.D[1], X23
    FMOV  D31, X7
    FMOV  V31.D[1], X3
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X25, #0x20, LSL #0
    MOVZ  X9, #0x2300, LSL #0
    ADD  X16, X30, X9, LSR #0
    STNP  Q28, Q24, [X16, #0]
    LDNP  Q8, Q1, [X16, #0]
    ADD  X16, X16, X25, LSR #0
    STNP  S26, S27, [X16, #0]
    LDNP  S18, S9, [X16, #0]
    ADD  X16, X16, X25, ASR #0
    STNP  D9, D18, [X16, #0]
    LDNP  D3, D29, [X16, #0]
    ADD  X16, X16, X25
    STP  Q23, Q29, [X16], #0
    LDP  Q7, Q20, [X16], #0
    ADD  X16, X16, X25, ASR #0
    STP  S7, S8, [X16], #0
    LDP  S20, S3, [X16], #0
    ADD  X16, X16, X25
    STP  D1, D3, [X16], #0
    LDP  D29, D12, [X16], #0
    ADD  X16, X16, X25, LSR #0
    STP  Q29, Q20, [X16, #0]!
    LDP  Q9, Q13, [X16, #0]!
    ADD  X16, X16, X25, LSR #0
    STP  S12, S12, [X16, #0]!
    LDP  S27, S21, [X16, #0]!
    ADD  X16, X16, X25
    STP  D27, D31, [X16, #0]!
    LDP  D17, D2, [X16, #0]!
    ADD  X16, X16, X25, LSR #0
    STP  Q21, Q2, [X16, #0]
    LDP  Q27, Q2, [X16, #0]
    ADD  X16, X16, X25, ASR #0
    STP  S2, S9, [X16, #0]
    LDP  S18, S3, [X16, #0]
    ADD  X16, X16, X25, LSR #0
    STP  D13, D27, [X16, #0]
    LDP  D9, D31, [X16, #0]
    ADD  X16, X16, X25, ASR #0
    STR  Q3, [X16], #0
    LDR  Q27, [X16], #0
    ADD  X16, X16, X25
    STR  H9, [X16], #0
    LDR  H21, [X16], #0
    ADD  X16, X16, X25
    STR  S21, [X16], #0
    LDR  S2, [X16], #0
    ADD  X16, X16, X25
    STR  D31, [X16], #0
    LDR  D31, [X16], #0
    ADD  X16, X16, X25
    STR  B18, [X16], #0
    LDR  B21, [X16], #0
    ADD  X16, X16, X25
    STR  Q31, [X16, #0]!
    LDR  Q31, [X16, #0]!
    ADD  X16, X16, X25
    STR  H21, [X16, #0]!
    LDR  H21, [X16, #0]!
    ADD  X16, X16, X25
    STR  S31, [X16, #0]!
    LDR  S9, [X16, #0]!
    ADD  X16, X16, X25
    STR  D9, [X16, #0]!
    LDR  D13, [X16, #0]!
    ADD  X16, X16, X25
    STR  B2, [X16, #0]!
    LDR  B18, [X16, #0]!
    ADD  X16, X16, X25, LSR #0
    STR  Q18, [X16, #0]
    LDR  Q2, [X16, #0]
    ADD  X16, X16, X25, LSR #0
    STR  H13, [X16, #0]
    LDR  H31, [X16, #0]
    ADD  X16, X16, X25, LSR #0
    STR  S21, [X16, #0]
    LDR  S13, [X16, #0]
    ADD  X16, X16, X25, ASR #0
    STR  D13, [X16, #0]
    LDR  D9, [X16, #0]
    ADD  X16, X16, X25, LSR #0
    STR  B2, [X16, #0]
    LDR  B2, [X16, #0]
    ADD  X16, X16, X25
    STR Q2, [X16, X5, LSL #4]
    LDR Q13, [X16, X5, LSL #0]
    ADD  X16, X16, X25, ASR #0
    STR Q31, [X16, W5, SXTW #4]
    LDR Q31, [X16, W5, SXTW #4]
    ADD  X16, X16, X25, LSR #0
    STR Q13, [X16, X5, SXTX #4]
    LDR Q2, [X16, X5, SXTX #0]
    ADD  X16, X16, X25, ASR #0
    STR Q31, [X16, W5, UXTW #0]
    LDR Q31, [X16, W5, UXTW #0]
    ADD  X16, X16, X25
    STR H9, [X16, X5, LSL #0]
    LDR H9, [X16, X5, LSL #0]
    ADD  X16, X16, X25, LSR #0
    STR H21, [X16, W5, SXTW #1]
    LDR H13, [X16, W5, SXTW #0]
    ADD  X16, X16, X25
    STR H2, [X16, X5, SXTX #1]
    LDR H7, [X16, X5, SXTX #1]
    ADD  X16, X16, X25, ASR #0
    STR H31, [X16, W5, UXTW #1]
    LDR H31, [X16, W5, UXTW #1]
    ADD  X16, X16, X25
    STR S9, [X16, X5, LSL #2]
    LDR S28, [X16, X5, LSL #0]
    ADD  X16, X16, X25, LSR #0
    STR S13, [X16, W5, SXTW #0]
    LDR S2, [X16, W5, SXTW #2]
    ADD  X16, X16, X25, LSR #0
    STR S31, [X16, X5, SXTX #2]
    LDR S24, [X16, X5, SXTX #0]
    ADD  X16, X16, X25, LSR #0
    STR S24, [X16, W5, UXTW #2]
    LDR S7, [X16, W5, UXTW #2]
    ADD  X16, X16, X25, LSR #0
    STR D2, [X16, X5, LSL #3]
    LDR D22, [X16, X5, LSL #3]
    ADD  X16, X16, X25, ASR #0
    STR D7, [X16, W5, SXTW #3]
    LDR D0, [X16, W5, SXTW #0]
    ADD  X16, X16, X25, LSR #0
    STR D0, [X16, X5, SXTX #0]
    LDR D11, [X16, X5, SXTX #0]
    ADD  X16, X16, X25, LSR #0
    STR D22, [X16, W5, UXTW #0]
    LDR D13, [X16, W5, UXTW #3]
    ADD  X16, X16, X25, LSR #0
    STR B11, [X16, X5, LSL #0]
    LDR B1, [X16, X5, LSL #0]
    ADD  X16, X16, X25, ASR #0
    STR B1, [X16, W5, SXTW #0]
    LDR B7, [X16, W5, SXTW #0]
    ADD  X16, X16, X25
    STR B13, [X16, X5, SXTX #0]
    LDR B6, [X16, X5, SXTX #0]
    ADD  X16, X16, X25, ASR #0
    STR B7, [X16, W5, UXTW #0]
    LDR B4, [X16, W5, UXTW #0]
    ADD  X16, X16, X25, ASR #0
    STUR  Q31, [X16, #0]
    LDUR  Q5, [X16, #0]
    ADD  X16, X16, X25, LSR #0
    STUR  H9, [X16, #0]
    LDUR  H24, [X16, #0]
    ADD  X16, X16, X25, ASR #0
    STUR  S30, [X16, #0]
    LDUR  S23, [X16, #0]
    ADD  X16, X16, X25, LSR #0
    STUR  D14, [X16, #0]
    LDUR  D6, [X16, #0]
    ADD  X16, X16, X25, ASR #0
    STUR  B7, [X16, #0]
    LDUR  B0, [X16, #0]
    ADD  X16, X16, X25
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X26, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D0
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D1
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D2
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X26, D3
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D4
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    FMOV  X26, D5
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D6
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D7
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, V8.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D8
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D9
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, V10.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D10
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    FMOV  X26, D11
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X26, D12
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D13
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, V14.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D14
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, V15.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D15
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, V16.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D16
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X26, D17
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D18
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, V19.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D19
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X26, D20
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D21
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D22
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X26, D23
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D24
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, V25.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D25
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, V26.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D26
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X26, D27
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V28.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5, LSL #0
    FMOV  X26, D28
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D29
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, V30.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X26, D30
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    FMOV  X26, D31
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X16
    FMOV  D3, X5
    FMOV  V3.D[1], X23
    FMOV  D4, X17
    FMOV  V4.D[1], X25
    FMOV  D5, X20
    FMOV  V5.D[1], X27
    FMOV  D6, X29
    FMOV  V6.D[1], X23
    FMOV  D7, X3
    FMOV  V7.D[1], X6
    FMOV  D8, X11
    FMOV  V8.D[1], X5
    FMOV  D9, X14
    FMOV  V9.D[1], X19
    FMOV  D10, X10
    FMOV  V10.D[1], X3
    FMOV  D11, X5
    FMOV  V11.D[1], X8
    FMOV  D12, X8
    FMOV  V12.D[1], X29
    FMOV  D13, X11
    FMOV  V13.D[1], X17
    FMOV  D14, X6
    FMOV  V14.D[1], X28
    FMOV  D15, X26
    FMOV  V15.D[1], X26
    FMOV  D16, X5
    FMOV  V16.D[1], X28
    FMOV  D17, X23
    FMOV  V17.D[1], X5
    FMOV  D18, X15
    FMOV  V18.D[1], X26
    FMOV  D19, X29
    FMOV  V19.D[1], X3
    FMOV  D20, X7
    FMOV  V20.D[1], X25
    FMOV  D21, X10
    FMOV  V21.D[1], X8
    FMOV  D22, X15
    FMOV  V22.D[1], X9
    FMOV  D23, X27
    FMOV  V23.D[1], X17
    FMOV  D24, X9
    FMOV  V24.D[1], X28
    FMOV  D25, X26
    FMOV  V25.D[1], X23
    FMOV  D26, X2
    FMOV  V26.D[1], X25
    FMOV  D27, X21
    FMOV  V27.D[1], X16
    FMOV  D28, X22
    FMOV  V28.D[1], X9
    FMOV  D29, X3
    FMOV  V29.D[1], X3
    FMOV  D30, X21
    FMOV  V30.D[1], X18
    FMOV  D31, X14
    FMOV  V31.D[1], X19
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X8, #0x20, LSL #0
    MOVZ  X9, #0x2800, LSL #0
    ADD  X21, X30, X9
    STNP  Q19, Q24, [X21, #0]
    LDNP  Q27, Q9, [X21, #0]
    ADD  X21, X21, X8, ASR #0
    STNP  S31, S27, [X21, #0]
    LDNP  S21, S18, [X21, #0]
    ADD  X21, X21, X8, ASR #0
    STNP  D18, D9, [X21, #0]
    LDNP  D8, D14, [X21, #0]
    ADD  X21, X21, X8
    STP  Q29, Q30, [X21], #0
    LDP  Q27, Q21, [X21], #0
    ADD  X21, X21, X8, ASR #0
    STP  S14, S14, [X21], #0
    LDP  S10, S26, [X21], #0
    ADD  X21, X21, X8, LSR #0
    STP  D10, D10, [X21], #0
    LDP  D11, D5, [X21], #0
    ADD  X21, X21, X8
    STP  Q11, Q26, [X21, #0]!
    LDP  Q19, Q7, [X21, #0]!
    ADD  X21, X21, X8, LSR #0
    STP  S21, S21, [X21, #0]!
    LDP  S7, S18, [X21, #0]!
    ADD  X21, X21, X8
    STP  D19, D19, [X21, #0]!
    LDP  D16, D18, [X21, #0]!
    ADD  X21, X21, X8, ASR #0
    STP  Q7, Q16, [X21, #0]
    LDP  Q26, Q19, [X21, #0]
    ADD  X21, X21, X8
    STP  S19, S5, [X21, #0]
    LDP  S28, S25, [X21, #0]
    ADD  X21, X21, X8, ASR #0
    STP  D18, D26, [X21, #0]
    LDP  D25, D5, [X21, #0]
    ADD  X21, X21, X8, LSR #0
    STR  Q28, [X21], #0
    LDR  Q13, [X21], #0
    ADD  X21, X21, X8
    STR  H13, [X21], #0
    LDR  H20, [X21], #0
    ADD  X21, X21, X8, LSR #0
    STR  S5, [X21], #0
    LDR  S30, [X21], #0
    ADD  X21, X21, X8
    STR  D20, [X21], #0
    LDR  D26, [X21], #0
    ADD  X21, X21, X8, ASR #0
    STR  B26, [X21], #0
    LDR  B21, [X21], #0
    ADD  X21, X21, X8, LSR #0
    STR  Q5, [X21, #0]!
    LDR  Q17, [X21, #0]!
    ADD  X21, X21, X8, LSR #0
    STR  H30, [X21, #0]!
    LDR  H15, [X21, #0]!
    ADD  X21, X21, X8, ASR #0
    STR  S21, [X21, #0]!
    LDR  S11, [X21, #0]!
    ADD  X21, X21, X8
    STR  D11, [X21, #0]!
    LDR  D12, [X21, #0]!
    ADD  X21, X21, X8, ASR #0
    STR  B12, [X21, #0]!
    LDR  B30, [X21, #0]!
    ADD  X21, X21, X8, ASR #0
    STR  Q30, [X21, #0]
    LDR  Q8, [X21, #0]
    ADD  X21, X21, X8
    STR  H17, [X21, #0]
    LDR  H1, [X21, #0]
    ADD  X21, X21, X8, LSR #0
    STR  S12, [X21, #0]
    LDR  S18, [X21, #0]
    ADD  X21, X21, X8, ASR #0
    STR  D8, [X21, #0]
    LDR  D1, [X21, #0]
    ADD  X21, X21, X8
    STR  B18, [X21, #0]
    LDR  B19, [X21, #0]
    ADD  X21, X21, X8, LSR #0
    STR Q1, [X21, X26, LSL #0]
    LDR Q27, [X21, X26, LSL #0]
    ADD  X21, X21, X8, ASR #0
    STR Q19, [X21, W26, SXTW #4]
    LDR Q7, [X21, W26, SXTW #4]
    ADD  X21, X21, X8, ASR #0
    STR Q7, [X21, X26, SXTX #0]
    LDR Q2, [X21, X26, SXTX #4]
    ADD  X21, X21, X8, LSR #0
    STR Q13, [X21, W26, UXTW #4]
    LDR Q26, [X21, W26, UXTW #0]
    ADD  X21, X21, X8, LSR #0
    STR H6, [X21, X26, LSL #1]
    LDR H23, [X21, X26, LSL #1]
    ADD  X21, X21, X8, LSR #0
    STR H7, [X21, W26, SXTW #0]
    LDR H19, [X21, W26, SXTW #1]
    ADD  X21, X21, X8, ASR #0
    STR H8, [X21, X26, SXTX #1]
    LDR H12, [X21, X26, SXTX #0]
    ADD  X21, X21, X8
    STR H24, [X21, W26, UXTW #0]
    LDR H10, [X21, W26, UXTW #0]
    ADD  X21, X21, X8
    STR S21, [X21, X26, LSL #0]
    LDR S24, [X21, X26, LSL #0]
    ADD  X21, X21, X8, ASR #0
    STR S14, [X21, W26, SXTW #2]
    LDR S13, [X21, W26, SXTW #2]
    ADD  X21, X21, X8
    STR S23, [X21, X26, SXTX #2]
    LDR S31, [X21, X26, SXTX #0]
    ADD  X21, X21, X8, ASR #0
    STR S31, [X21, W26, UXTW #0]
    LDR S14, [X21, W26, UXTW #2]
    ADD  X21, X21, X8
    STR D13, [X21, X26, LSL #0]
    LDR D29, [X21, X26, LSL #0]
    ADD  X21, X21, X8, ASR #0
    STR D29, [X21, W26, SXTW #3]
    LDR D28, [X21, W26, SXTW #0]
    ADD  X21, X21, X8, ASR #0
    STR D19, [X21, X26, SXTX #3]
    LDR D16, [X21, X26, SXTX #0]
    ADD  X21, X21, X8, ASR #0
    STR D24, [X21, W26, UXTW #0]
    LDR D30, [X21, W26, UXTW #3]
    ADD  X21, X21, X8, ASR #0
    STR B14, [X21, X26, LSL #0]
    LDR B18, [X21, X26, LSL #0]
    ADD  X21, X21, X8, ASR #0
    STR B16, [X21, W26, SXTW #0]
    LDR B18, [X21, W26, SXTW #0]
    ADD  X21, X21, X8
    STR B18, [X21, X26, SXTX #0]
    LDR B27, [X21, X26, SXTX #0]
    ADD  X21, X21, X8
    STR B27, [X21, W26, UXTW #0]
    LDR B9, [X21, W26, UXTW #0]
    ADD  X21, X21, X8
    STUR  Q9, [X21, #0]
    LDUR  Q24, [X21, #0]
    ADD  X21, X21, X8
    STUR  H24, [X21, #0]
    LDUR  H19, [X21, #0]
    ADD  X21, X21, X8, LSR #0
    STUR  S19, [X21, #0]
    LDUR  S16, [X21, #0]
    ADD  X21, X21, X8, LSR #0
    STUR  D16, [X21, #0]
    LDUR  D1, [X21, #0]
    ADD  X21, X21, X8, ASR #0
    STUR  B1, [X21, #0]
    LDUR  B1, [X21, #0]
    ADD  X21, X21, X8, LSR #0
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X23, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    MRS  X23, FPSR
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, V0.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, D0
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V1.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D1
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D2
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, V3.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, D3
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, V4.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, D4
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X23, D5
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, V6.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, D6
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V7.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D7
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D8
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D9
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    FMOV  X23, D10
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V11.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D11
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V12.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D12
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V13.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X23, D13
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    FMOV  X23, D14
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    FMOV  X23, D15
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D16
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V17.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X23, D17
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V18.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D18
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D19
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V20.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    FMOV  X23, D20
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V21.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D21
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, V22.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X23, D22
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    FMOV  X23, D23
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V24.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D24
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X23, D25
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X23, D26
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D27
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V28.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X23, D28
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X23, D29
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a, LSL #0
    FMOV  X23, D30
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    FMOV  X23, D31
    SUB  X29, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X17
    FMOV  D3, X28
    FMOV  V3.D[1], X27
    FMOV  D4, X19
    FMOV  V4.D[1], X16
    FMOV  D5, X8
    FMOV  V5.D[1], X19
    FMOV  D6, X16
    FMOV  V6.D[1], X19
    FMOV  D7, X14
    FMOV  V7.D[1], X25
    FMOV  D8, X9
    FMOV  V8.D[1], X21
    FMOV  D9, X16
    FMOV  V9.D[1], X17
    FMOV  D10, X14
    FMOV  V10.D[1], X10
    FMOV  D11, X2
    FMOV  V11.D[1], X5
    FMOV  D12, X17
    FMOV  V12.D[1], X25
    FMOV  D13, X20
    FMOV  V13.D[1], X19
    FMOV  D14, X20
    FMOV  V14.D[1], X25
    FMOV  D15, X19
    FMOV  V15.D[1], X29
    FMOV  D16, X3
    FMOV  V16.D[1], X29
    FMOV  D17, X7
    FMOV  V17.D[1], X26
    FMOV  D18, X18
    FMOV  V18.D[1], X16
    FMOV  D19, X11
    FMOV  V19.D[1], X25
    FMOV  D20, X17
    FMOV  V20.D[1], X19
    FMOV  D21, X27
    FMOV  V21.D[1], X22
    FMOV  D22, X5
    FMOV  V22.D[1], X29
    FMOV  D23, X11
    FMOV  V23.D[1], X28
    FMOV  D24, X21
    FMOV  V24.D[1], X22
    FMOV  D25, X23
    FMOV  V25.D[1], X23
    FMOV  D26, X29
    FMOV  V26.D[1], X3
    FMOV  D27, X2
    FMOV  V27.D[1], X15
    FMOV  D28, X28
    FMOV  V28.D[1], X29
    FMOV  D29, X7
    FMOV  V29.D[1], X11
    FMOV  D30, X10
    FMOV  V30.D[1], X18
    FMOV  D31, X17
    FMOV  V31.D[1], X10
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X15, #0x20, LSL #0
    MOVZ  X18, #0x2d00, LSL #0
    ADD  X28, X30, X18
    STNP  Q24, Q24, [X28, #0]
    LDNP  Q10, Q28, [X28, #0]
    ADD  X28, X28, X15
    STNP  S31, S29, [X28, #0]
    LDNP  S8, S19, [X28, #0]
    ADD  X28, X28, X15, ASR #0
    STNP  D27, D27, [X28, #0]
    LDNP  D21, D29, [X28, #0]
    ADD  X28, X28, X15
    STP  Q10, Q10, [X28], #0
    LDP  Q3, Q14, [X28], #0
    ADD  X28, X28, X15, LSR #0
    STP  S25, S29, [X28], #0
    LDP  S4, S12, [X28], #0
    ADD  X28, X28, X15, ASR #0
    STP  D8, D28, [X28], #0
    LDP  D16, D20, [X28], #0
    ADD  X28, X28, X15
    STP  Q19, Q16, [X28, #0]!
    LDP  Q30, Q20, [X28, #0]!
    ADD  X28, X28, X15, ASR #0
    STP  S20, S30, [X28, #0]!
    LDP  S19, S5, [X28, #0]!
    ADD  X28, X28, X15, ASR #0
    STP  D12, D21, [X28, #0]!
    LDP  D6, D4, [X28, #0]!
    ADD  X28, X28, X15
    STP  Q14, Q6, [X28, #0]
    LDP  Q20, Q21, [X28, #0]
    ADD  X28, X28, X15, LSR #0
    STP  S20, S20, [X28, #0]
    LDP  S8, S29, [X28, #0]
    ADD  X28, X28, X15, LSR #0
    STP  D3, D21, [X28, #0]
    LDP  D30, D14, [X28, #0]
    ADD  X28, X28, X15
    STR  Q19, [X28], #0
    LDR  Q20, [X28], #0
    ADD  X28, X28, X15, LSR #0
    STR  H4, [X28], #0
    LDR  H21, [X28], #0
    ADD  X28, X28, X15, LSR #0
    STR  S29, [X28], #0
    LDR  S16, [X28], #0
    ADD  X28, X28, X15, ASR #0
    STR  D20, [X28], #0
    LDR  D3, [X28], #0
    ADD  X28, X28, X15, LSR #0
    STR  B5, [X28], #0
    LDR  B5, [X28], #0
    ADD  X28, X28, X15, LSR #0
    STR  Q3, [X28, #0]!
    LDR  Q6, [X28, #0]!
    ADD  X28, X28, X15
    STR  H30, [X28, #0]!
    LDR  H19, [X28, #0]!
    ADD  X28, X28, X15, LSR #0
    STR  S14, [X28, #0]!
    LDR  S20, [X28, #0]!
    ADD  X28, X28, X15, ASR #0
    STR  D5, [X28, #0]!
    LDR  D5, [X28, #0]!
    ADD  X28, X28, X15, LSR #0
    STR  B16, [X28, #0]!
    LDR  B4, [X28, #0]!
    ADD  X28, X28, X15, LSR #0
    STR  Q4, [X28, #0]
    LDR  Q30, [X28, #0]
    ADD  X28, X28, X15, ASR #0
    STR  H30, [X28, #0]
    LDR  H3, [X28, #0]
    ADD  X28, X28, X15, LSR #0
    STR  S19, [X28, #0]
    LDR  S16, [X28, #0]
    ADD  X28, X28, X15, LSR #0
    STR  D16, [X28, #0]
    LDR  D14, [X28, #0]
    ADD  X28, X28, X15, LSR #0
    STR  B3, [X28, #0]
    LDR  B4, [X28, #0]
    ADD  X28, X28, X15, LSR #0
    STR Q4, [X28, X2, LSL #0]
    LDR Q19, [X28, X2, LSL #0]
    ADD  X28, X28, X15, LSR #0
    STR Q14, [X28, W2, SXTW #0]
    LDR Q16, [X28, W2, SXTW #0]
    ADD  X28, X28, X15, ASR #0
    STR Q19, [X28, X2, SXTX #4]
    LDR Q19, [X28, X2, SXTX #4]
    ADD  X28, X28, X15, LSR #0
    STR Q16, [X28, W2, UXTW #4]
    LDR Q3, [X28, W2, UXTW #0]
    ADD  X28, X28, X15
    STR H3, [X28, X2, LSL #0]
    LDR H4, [X28, X2, LSL #1]
    ADD  X28, X28, X15, LSR #0
    STR H23, [X28, W2, SXTW #0]
    LDR H23, [X28, W2, SXTW #0]
    ADD  X28, X28, X15, LSR #0
    STR H3, [X28, X2, SXTX #0]
    LDR H16, [X28, X2, SXTX #0]
    ADD  X28, X28, X15, ASR #0
    STR H5, [X28, W2, UXTW #1]
    LDR H19, [X28, W2, UXTW #1]
    ADD  X28, X28, X15, LSR #0
    STR S19, [X28, X2, LSL #2]
    LDR S10, [X28, X2, LSL #0]
    ADD  X28, X28, X15
    STR S25, [X28, W2, SXTW #2]
    LDR S27, [X28, W2, SXTW #2]
    ADD  X28, X28, X15
    STR S19, [X28, X2, SXTX #0]
    LDR S29, [X28, X2, SXTX #2]
    ADD  X28, X28, X15, LSR #0
    STR S23, [X28, W2, UXTW #2]
    LDR S19, [X28, W2, UXTW #2]
    ADD  X28, X28, X15, ASR #0
    STR D26, [X28, X2, LSL #3]
    LDR D9, [X28, X2, LSL #0]
    ADD  X28, X28, X15, LSR #0
    STR D3, [X28, W2, SXTW #3]
    LDR D3, [X28, W2, SXTW #3]
    ADD  X28, X28, X15, LSR #0
    STR D7, [X28, X2, SXTX #0]
    LDR D23, [X28, X2, SXTX #0]
    ADD  X28, X28, X15
    STR D23, [X28, W2, UXTW #3]
    LDR D8, [X28, W2, UXTW #3]
    ADD  X28, X28, X15, LSR #0
    STR B27, [X28, X2, LSL #0]
    LDR B1, [X28, X2, LSL #0]
    ADD  X28, X28, X15, LSR #0
    STR B10, [X28, W2, SXTW #0]
    LDR B29, [X28, W2, SXTW #0]
    ADD  X28, X28, X15, LSR #0
    STR B1, [X28, X2, SXTX #0]
    LDR B21, [X28, X2, SXTX #0]
    ADD  X28, X28, X15, ASR #0
    STR B3, [X28, W2, UXTW #0]
    LDR B23, [X28, W2, UXTW #0]
    ADD  X28, X28, X15, ASR #0
    STUR  Q21, [X28, #0]
    LDUR  Q3, [X28, #0]
    ADD  X28, X28, X15, ASR #0
    STUR  H23, [X28, #0]
    LDUR  H18, [X28, #0]
    ADD  X28, X28, X15, LSR #0
    STUR  S29, [X28, #0]
    LDUR  S14, [X28, #0]
    ADD  X28, X28, X15, LSR #0
    STUR  D3, [X28, #0]
    LDUR  D16, [X28, #0]
    ADD  X28, X28, X15, ASR #0
    STUR  B18, [X28, #0]
    LDUR  B2, [X28, #0]
    ADD  X28, X28, X15, LSR #0
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X23, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    MRS  X23, FPSR
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V0.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D0
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V1.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D1
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D2
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V3.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D3
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    FMOV  X23, D4
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D5
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    FMOV  X23, D6
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V7.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D7
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D8
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D9
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D10
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V11.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D11
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V12.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    FMOV  X23, D12
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V13.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D13
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D14
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V15.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D15
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D16
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V17.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D17
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V18.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D18
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    FMOV  X23, D19
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V20.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    FMOV  X23, D20
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V21.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D21
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V22.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D22
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D23
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V24.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D24
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V25.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D25
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V26.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D26
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    FMOV  X23, D27
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V28.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D28
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D29
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5, LSL #0
    FMOV  X23, D30
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, V31.D[1]
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X23, D31
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, FpsimdLoadStoreP01_TestFail

FpsimdLoadStoreP01_TestEnd:
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
FpsimdLoadStoreP01_TestFail:
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
