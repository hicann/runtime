.global DataReverseAdvsimdVectorP02

.text
.p2align 4

DataReverseAdvsimdVectorP02:

DataReverseAdvsimdVectorP02_TestBegin:
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
    MOVZ  X2, #0x57d5, LSL #0
    MOVK  X2, #0x11b1, LSL #16
    MOVK  X2, #0x2fe7, LSL #32
    MOVK  X2, #0x97fa, LSL #48
    MOVZ  X3, #0x2681, LSL #0
    MOVK  X3, #0x17e, LSL #16
    MOVK  X3, #0x8390, LSL #32
    MOVK  X3, #0x2705, LSL #48
    MOVZ  X4, #0x7763, LSL #0
    MOVK  X4, #0x5426, LSL #16
    MOVK  X4, #0xc14b, LSL #32
    MOVK  X4, #0x2aad, LSL #48
    MOVZ  X5, #0xc39, LSL #0
    MOVK  X5, #0x27cc, LSL #16
    MOVK  X5, #0xf293, LSL #32
    MOVK  X5, #0x359d, LSL #48
    MOVZ  X7, #0x979b, LSL #0
    MOVK  X7, #0xbcbb, LSL #16
    MOVK  X7, #0x7ad0, LSL #32
    MOVK  X7, #0xf782, LSL #48
    MOVZ  X9, #0xbe86, LSL #0
    MOVK  X9, #0x9a3, LSL #16
    MOVK  X9, #0x889a, LSL #32
    MOVK  X9, #0xacd8, LSL #48
    MOVZ  X10, #0x5fa6, LSL #0
    MOVK  X10, #0x802b, LSL #16
    MOVK  X10, #0xb3bd, LSL #32
    MOVK  X10, #0xc193, LSL #48
    MOVZ  X11, #0xc93b, LSL #0
    MOVK  X11, #0x11d2, LSL #16
    MOVK  X11, #0x15df, LSL #32
    MOVK  X11, #0xefc1, LSL #48
    MOVZ  X12, #0x90a3, LSL #0
    MOVK  X12, #0xe9b5, LSL #16
    MOVK  X12, #0x8066, LSL #32
    MOVK  X12, #0xc25b, LSL #48
    MOVZ  X13, #0xaa0, LSL #0
    MOVK  X13, #0x2e7, LSL #16
    MOVK  X13, #0x41df, LSL #32
    MOVK  X13, #0x3f35, LSL #48
    MOVZ  X14, #0x2af1, LSL #0
    MOVK  X14, #0x78a4, LSL #16
    MOVK  X14, #0x5e5e, LSL #32
    MOVK  X14, #0xbd1c, LSL #48
    MOVZ  X15, #0x6fdc, LSL #0
    MOVK  X15, #0x1feb, LSL #16
    MOVK  X15, #0x3e42, LSL #32
    MOVK  X15, #0xc12, LSL #48
    MOVZ  X16, #0xf69a, LSL #0
    MOVK  X16, #0xe322, LSL #16
    MOVK  X16, #0x5df1, LSL #32
    MOVK  X16, #0x9970, LSL #48
    MOVZ  X17, #0x3dc5, LSL #0
    MOVK  X17, #0xe0c0, LSL #16
    MOVK  X17, #0xcb94, LSL #32
    MOVK  X17, #0xc700, LSL #48
    MOVZ  X18, #0x6817, LSL #0
    MOVK  X18, #0xb05e, LSL #16
    MOVK  X18, #0x2de4, LSL #32
    MOVK  X18, #0x6d87, LSL #48
    MOVZ  X20, #0xd8c2, LSL #0
    MOVK  X20, #0xe00c, LSL #16
    MOVK  X20, #0x4281, LSL #32
    MOVK  X20, #0xfd45, LSL #48
    MOVZ  X21, #0x3ee0, LSL #0
    MOVK  X21, #0x2ada, LSL #16
    MOVK  X21, #0x985f, LSL #32
    MOVK  X21, #0x9e18, LSL #48
    MOVZ  X22, #0x2c15, LSL #0
    MOVK  X22, #0xbf7e, LSL #16
    MOVK  X22, #0x40f7, LSL #32
    MOVK  X22, #0x8618, LSL #48
    MOVZ  X23, #0xeed7, LSL #0
    MOVK  X23, #0x5049, LSL #16
    MOVK  X23, #0xe994, LSL #32
    MOVK  X23, #0xf7c5, LSL #48
    MOVZ  X24, #0xc539, LSL #0
    MOVK  X24, #0x1149, LSL #16
    MOVK  X24, #0x54e5, LSL #32
    MOVK  X24, #0x1ef3, LSL #48
    MOVZ  X25, #0xebe3, LSL #0
    MOVK  X25, #0x3762, LSL #16
    MOVK  X25, #0x4960, LSL #32
    MOVK  X25, #0x1be9, LSL #48
    MOVZ  X26, #0xe832, LSL #0
    MOVK  X26, #0xdc76, LSL #16
    MOVK  X26, #0xf430, LSL #32
    MOVK  X26, #0x8a50, LSL #48
    MOVZ  X28, #0xdf54, LSL #0
    MOVK  X28, #0x439, LSL #16
    MOVK  X28, #0xbaef, LSL #32
    MOVK  X28, #0xe388, LSL #48
    MOVZ  X29, #0xd49a, LSL #0
    MOVK  X29, #0xb066, LSL #16
    MOVK  X29, #0x5fcf, LSL #32
    MOVK  X29, #0x7c87, LSL #48
    MOVZ  X9, #0x23c3, LSL #0
    MOVK  X9, #0xc61a, LSL #16
    MOVK  X9, #0xbb64, LSL #32
    MOVK  X9, #0xb62f, LSL #48
    MSR  FPCR, X9
    MOVZ  X9, #0x4d01, LSL #0
    MOVK  X9, #0xcd59, LSL #16
    MOVK  X9, #0xf184, LSL #32
    MOVK  X9, #0xa148, LSL #48
    MSR  FPSR, X9
    MRS  X21, FPSR
    MOVZ  X9, #0xff60, LSL #0
    MOVK  X9, #0x7ff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    AND  X21, X21, X9
    MOVZ  X9, #0x0, LSL #0
    ORR  X21, X21, X9
    MSR  FPSR, X21
    ISB  SY
    SUBS  W14, W23, W29, LSL #28
    MOVZ  X1, #0x0, LSL #0
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
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
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
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X24
    FMOV  D3, X23
    FMOV  V3.D[1], X4
    FMOV  D4, X11
    FMOV  V4.D[1], X5
    FMOV  D5, X13
    FMOV  V5.D[1], X18
    FMOV  D6, X10
    FMOV  V6.D[1], X21
    FMOV  D7, X23
    FMOV  V7.D[1], X20
    FMOV  D8, X28
    FMOV  V8.D[1], X29
    FMOV  D9, X16
    FMOV  V9.D[1], X29
    FMOV  D10, X16
    FMOV  V10.D[1], X20
    FMOV  D11, X12
    FMOV  V11.D[1], X24
    FMOV  D12, X26
    FMOV  V12.D[1], X26
    FMOV  D13, X9
    FMOV  V13.D[1], X5
    FMOV  D14, X3
    FMOV  V14.D[1], X16
    FMOV  D15, X13
    FMOV  V15.D[1], X12
    FMOV  D16, X21
    FMOV  V16.D[1], X20
    FMOV  D17, X3
    FMOV  V17.D[1], X28
    FMOV  D18, X17
    FMOV  V18.D[1], X4
    FMOV  D19, X11
    FMOV  V19.D[1], X2
    FMOV  D20, X18
    FMOV  V20.D[1], X7
    FMOV  D21, X21
    FMOV  V21.D[1], X10
    FMOV  D22, X11
    FMOV  V22.D[1], X10
    FMOV  D23, X10
    FMOV  V23.D[1], X28
    FMOV  D24, X29
    FMOV  V24.D[1], X28
    FMOV  D25, X4
    FMOV  V25.D[1], X29
    FMOV  D26, X3
    FMOV  V26.D[1], X14
    FMOV  D27, X12
    FMOV  V27.D[1], X11
    FMOV  D28, X22
    FMOV  V28.D[1], X12
    FMOV  D29, X11
    FMOV  V29.D[1], X9
    FMOV  D30, X7
    FMOV  V30.D[1], X11
    FMOV  D31, X4
    FMOV  V31.D[1], X20
    FABD  V28.2D, V30.2D, V24.2D
    FABS  V30.2S, V27.2S
    FACGE  V16.2D, V22.2D, V26.2D
    FACGT  V25.2D, V23.2D, V20.2D
    FADD  V13.2S, V31.2S, V29.2S
    FADDP D2, V21.2D
    FADDP S0, V14.2S
    FADDP  V18.2S, V24.2S, V22.2S
    FDIV  V14.2S, V19.2S, V14.2S
    FMLA D19, D5, V23.D[0x1]
    FMLA S27, S22, V26.S[0x3]
    FMLA V15.2D, V8.2D, V26.D[0x1]
    FMLA V7.4S, V4.4S, V20.S[0x2]
    FMLA  V5.2S, V29.2S, V22.2S
    FMLS D8, D1, V23.D[0x0]
    FMLS S26, S26, V9.S[0x0]
    FMLS V12.2D, V9.2D, V23.D[0x1]
    FMLS V23.2S, V1.2S, V29.S[0x0]
    FMLS  V1.2S, V22.2S, V9.2S
    FMOV  V21.2D, #-6.75000000
    FMOV  V31.2S, #2.62500000
    FMUL D3, D11, V17.D[0x1]
    FMUL S24, S6, V24.S[0x0]
    FMUL V4.2D, V20.2D, V17.D[0x1]
    FMUL V22.4S, V9.4S, V20.S[0x3]
    FMUL  V9.2S, V20.2S, V9.2S
    FMULX D29, D17, V29.D[0x0]
    FMULX S10, S6, V11.S[0x1]
    FMULX V6.2D, V20.2D, V20.D[0x0]
    FMULX V20.2S, V11.2S, V17.S[0x2]
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x10, LSL #0
    MRS  X18, FPSR
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5ada, LSL #16
    FMOV  X18, D0
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0xf53a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0xf53a, LSL #48
    FMOV  X18, D1
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a6a, LSL #48
    FMOV  X18, D2
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0x74c5, LSL #48
    FMOV  X18, D3
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0x74c5, LSL #48
    FMOV  X18, V4.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0x74c5, LSL #48
    FMOV  X18, D4
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0x753a, LSL #48
    FMOV  X18, D5
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0x74c5, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0x74c5, LSL #48
    FMOV  X18, D6
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0x753a, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0x753a, LSL #48
    FMOV  X18, D7
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0xf4c5, LSL #48
    FMOV  X18, D8
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0x753a, LSL #48
    FMOV  X18, D9
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    FMOV  X18, D10
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D11
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0xf4c5, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0xf4c5, LSL #48
    FMOV  X18, D12
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5ada, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5ada, LSL #48
    FMOV  X18, D13
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3f80, LSL #16
    MOVK  X15, #0x3f80, LSL #48
    FMOV  X18, D14
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0x74c5, LSL #48
    FMOV  X18, V15.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0x74c5, LSL #48
    FMOV  X18, D15
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, V16.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D16
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V17.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D17
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5ada, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5ada, LSL #48
    FMOV  X18, D18
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0x74c5, LSL #48
    FMOV  X18, D19
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0x753a, LSL #48
    FMOV  X18, D20
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc01b, LSL #48
    FMOV  X18, V21.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc01b, LSL #48
    FMOV  X18, D21
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0x753a, LSL #48
    FMOV  X18, V22.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0x753a, LSL #48
    FMOV  X18, D22
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0xf53a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0xf53a, LSL #48
    FMOV  X18, D23
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    FMOV  X18, D24
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, D25
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0xf53a, LSL #16
    FMOV  X18, D26
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0x753a, LSL #16
    FMOV  X18, D27
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, D28
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c4a, LSL #0
    MOVK  X15, #0xf00e, LSL #16
    MOVK  X15, #0xb3d1, LSL #32
    MOVK  X15, #0x74c5, LSL #48
    FMOV  X18, D29
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4028, LSL #16
    MOVK  X15, #0x4028, LSL #48
    FMOV  X18, D31
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
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
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
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
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X23
    FMOV  D1, X22
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X11
    FMOV  D4, X11
    FMOV  V4.D[1], X4
    FMOV  D5, X12
    FMOV  V5.D[1], X29
    FMOV  D6, X11
    FMOV  V6.D[1], X28
    FMOV  D7, X21
    FMOV  V7.D[1], X22
    FMOV  D8, X29
    FMOV  V8.D[1], X11
    FMOV  D9, X4
    FMOV  V9.D[1], X4
    FMOV  D10, X20
    FMOV  V10.D[1], X23
    FMOV  D11, X28
    FMOV  V11.D[1], X13
    FMOV  D12, X3
    FMOV  V12.D[1], X29
    FMOV  D13, X11
    FMOV  V13.D[1], X20
    FMOV  D14, X26
    FMOV  V14.D[1], X2
    FMOV  D15, X2
    FMOV  V15.D[1], X24
    FMOV  D16, X7
    FMOV  V16.D[1], X3
    FMOV  D17, X2
    FMOV  V17.D[1], X7
    FMOV  D18, X23
    FMOV  V18.D[1], X7
    FMOV  D19, X29
    FMOV  V19.D[1], X20
    FMOV  D20, X2
    FMOV  V20.D[1], X5
    FMOV  D21, X23
    FMOV  V21.D[1], X23
    FMOV  D22, X24
    FMOV  V22.D[1], X26
    FMOV  D23, X7
    FMOV  V23.D[1], X7
    FMOV  D24, X26
    FMOV  V24.D[1], X11
    FMOV  D25, X11
    FMOV  V25.D[1], X7
    FMOV  D26, X28
    FMOV  V26.D[1], X5
    FMOV  D27, X23
    FMOV  V27.D[1], X11
    FMOV  D28, X17
    FMOV  V28.D[1], X5
    FMOV  D29, X4
    FMOV  V29.D[1], X29
    FMOV  D30, X12
    FMOV  V30.D[1], X14
    FMOV  D31, X20
    FMOV  V31.D[1], X11
    FNEG  V1.2D, V23.2D
    FRECPE  V28.2D, V27.2D
    FRECPS  V10.4S, V30.4S, V30.4S
    FRSQRTE  V23.2S, V29.2S
    FRSQRTS  V9.2S, V26.2S, V24.2S
    FSQRT  V15.2S, V31.2S
    FSUB  V4.2D, V8.2D, V4.2D
    FABD  V8.8H, V12.8H, V25.8H
    FABS  V14.8H, V25.8H
    FACGE  V31.8H, V2.8H, V21.8H
    FACGT  V18.4H, V2.4H, V26.4H
    FADD  V3.8H, V11.8H, V7.8H
    FADDP H11, V21.2H
    FADDP  V26.4H, V26.4H, V7.4H
    FDIV  V2.8H, V12.8H, V29.8H
    FMLA H20, H16, V13.H[0x2]
    FMLA V13.8H, V24.8H, V5.H[0x2]
    FMLA  V22.4H, V5.4H, V27.4H
    FMLS H12, H7, V6.H[0x1]
    FMLS V5.4H, V27.4H, V5.H[0x5]
    FMLS  V6.4H, V0.4H, V17.4H
    FMOV  V19.4H, #-0.17187500
    FMUL H30, H16, V0.H[0x2]
    FMUL V24.4H, V7.4H, V7.H[0x2]
    FMUL  V16.8H, V0.8H, V0.8H
    FMULX H17, H29, V0.H[0x1]
    FMULX V25.8H, V7.8H, V0.H[0x3]
    FMULX  V27.8H, V27.8H, V0.8H
    FNEG  V7.8H, V21.8H
    FRECPE  V29.8H, V21.8H
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x10, LSL #0
    MRS  X18, FPSR
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0xda5a, LSL #48
    FMOV  X18, V1.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0xda5a, LSL #48
    FMOV  X18, D1
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3c00, LSL #0
    MOVK  X15, #0x3c00, LSL #16
    MOVK  X15, #0x3c00, LSL #32
    MOVK  X15, #0x3c00, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3c00, LSL #0
    MOVK  X15, #0x3c00, LSL #16
    MOVK  X15, #0x3c00, LSL #32
    MOVK  X15, #0x3c00, LSL #48
    FMOV  X18, D2
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5e5a, LSL #0
    MOVK  X15, #0x5e5a, LSL #16
    MOVK  X15, #0x5e5a, LSL #32
    MOVK  X15, #0x5e5a, LSL #48
    FMOV  X18, V3.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5e5a, LSL #0
    MOVK  X15, #0x5e5a, LSL #16
    MOVK  X15, #0x5e5a, LSL #32
    MOVK  X15, #0x5e5a, LSL #48
    FMOV  X18, D3
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, D4
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xf905, LSL #0
    MOVK  X15, #0xf905, LSL #16
    MOVK  X15, #0xf905, LSL #32
    MOVK  X15, #0xf905, LSL #48
    FMOV  X18, D5
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xf905, LSL #0
    MOVK  X15, #0xf905, LSL #16
    MOVK  X15, #0xf905, LSL #32
    MOVK  X15, #0xf905, LSL #48
    FMOV  X18, D6
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xda5a, LSL #0
    MOVK  X15, #0xda5a, LSL #16
    MOVK  X15, #0xda5a, LSL #32
    MOVK  X15, #0xda5a, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xda5a, LSL #0
    MOVK  X15, #0xda5a, LSL #16
    MOVK  X15, #0xda5a, LSL #32
    MOVK  X15, #0xda5a, LSL #48
    FMOV  X18, D7
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, D8
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0xf4ba, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0xf4ba, LSL #48
    FMOV  X18, D9
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0xf53a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0xf53a, LSL #48
    FMOV  X18, V10.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e01, LSL #0
    MOVK  X15, #0xf53a, LSL #16
    MOVK  X15, #0x3e01, LSL #32
    MOVK  X15, #0xf53a, LSL #48
    FMOV  X18, D10
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5e5a, LSL #0
    FMOV  X18, D11
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xf905, LSL #0
    FMOV  X18, D12
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x7911, LSL #0
    MOVK  X15, #0x7911, LSL #16
    MOVK  X15, #0x7911, LSL #32
    MOVK  X15, #0x7911, LSL #48
    FMOV  X18, V13.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x7911, LSL #0
    MOVK  X15, #0x7911, LSL #16
    MOVK  X15, #0x7911, LSL #32
    MOVK  X15, #0x7911, LSL #48
    FMOV  X18, D13
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V14.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D14
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x6da7, LSL #0
    MOVK  X15, #0x4cec, LSL #16
    MOVK  X15, #0x6da7, LSL #32
    MOVK  X15, #0x4cec, LSL #48
    FMOV  X18, D15
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x790b, LSL #0
    MOVK  X15, #0x790b, LSL #16
    MOVK  X15, #0x790b, LSL #32
    MOVK  X15, #0x790b, LSL #48
    FMOV  X18, V16.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x790b, LSL #0
    MOVK  X15, #0x790b, LSL #16
    MOVK  X15, #0x790b, LSL #32
    MOVK  X15, #0x790b, LSL #48
    FMOV  X18, D16
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x790b, LSL #0
    FMOV  X18, D17
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, D18
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xb180, LSL #0
    MOVK  X15, #0xb180, LSL #16
    MOVK  X15, #0xb180, LSL #32
    MOVK  X15, #0xb180, LSL #48
    FMOV  X18, D19
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x7911, LSL #0
    FMOV  X18, D20
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V21.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D21
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x7911, LSL #0
    MOVK  X15, #0x7911, LSL #16
    MOVK  X15, #0x7911, LSL #32
    MOVK  X15, #0x7911, LSL #48
    FMOV  X18, D22
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x320a, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x320a, LSL #48
    FMOV  X18, D23
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x790b, LSL #0
    MOVK  X15, #0x790b, LSL #16
    MOVK  X15, #0x790b, LSL #32
    MOVK  X15, #0x790b, LSL #48
    FMOV  X18, D24
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x790b, LSL #0
    MOVK  X15, #0x790b, LSL #16
    MOVK  X15, #0x790b, LSL #32
    MOVK  X15, #0x790b, LSL #48
    FMOV  X18, V25.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x790b, LSL #0
    MOVK  X15, #0x790b, LSL #16
    MOVK  X15, #0x790b, LSL #32
    MOVK  X15, #0x790b, LSL #48
    FMOV  X18, D25
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5e5a, LSL #0
    MOVK  X15, #0x5e5a, LSL #16
    MOVK  X15, #0x5e5a, LSL #32
    MOVK  X15, #0x5e5a, LSL #48
    FMOV  X18, D26
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x790b, LSL #0
    MOVK  X15, #0x790b, LSL #16
    MOVK  X15, #0x790b, LSL #32
    MOVK  X15, #0x790b, LSL #48
    FMOV  X18, V27.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x790b, LSL #0
    MOVK  X15, #0x790b, LSL #16
    MOVK  X15, #0x790b, LSL #32
    MOVK  X15, #0x790b, LSL #48
    FMOV  X18, D27
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7000, LSL #32
    MOVK  X15, #0x2583, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7000, LSL #32
    MOVK  X15, #0x2583, LSL #48
    FMOV  X18, D28
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1d08, LSL #0
    MOVK  X15, #0x1d08, LSL #16
    MOVK  X15, #0x1d08, LSL #32
    MOVK  X15, #0x1d08, LSL #48
    FMOV  X18, V29.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1d08, LSL #0
    MOVK  X15, #0x1d08, LSL #16
    MOVK  X15, #0x1d08, LSL #32
    MOVK  X15, #0x1d08, LSL #48
    FMOV  X18, D29
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x790b, LSL #0
    FMOV  X18, D30
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, V31.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D31
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
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
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
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
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X13
    FMOV  D3, X7
    FMOV  V3.D[1], X22
    FMOV  D4, X14
    FMOV  V4.D[1], X21
    FMOV  D5, X26
    FMOV  V5.D[1], X29
    FMOV  D6, X22
    FMOV  V6.D[1], X4
    FMOV  D7, X3
    FMOV  V7.D[1], X20
    FMOV  D8, X29
    FMOV  V8.D[1], X22
    FMOV  D9, X10
    FMOV  V9.D[1], X21
    FMOV  D10, X10
    FMOV  V10.D[1], X11
    FMOV  D11, X7
    FMOV  V11.D[1], X28
    FMOV  D12, X16
    FMOV  V12.D[1], X26
    FMOV  D13, X13
    FMOV  V13.D[1], X26
    FMOV  D14, X5
    FMOV  V14.D[1], X26
    FMOV  D15, X28
    FMOV  V15.D[1], X20
    FMOV  D16, X23
    FMOV  V16.D[1], X2
    FMOV  D17, X16
    FMOV  V17.D[1], X14
    FMOV  D18, X23
    FMOV  V18.D[1], X5
    FMOV  D19, X13
    FMOV  V19.D[1], X21
    FMOV  D20, X28
    FMOV  V20.D[1], X12
    FMOV  D21, X21
    FMOV  V21.D[1], X10
    FMOV  D22, X10
    FMOV  V22.D[1], X5
    FMOV  D23, X29
    FMOV  V23.D[1], X23
    FMOV  D24, X20
    FMOV  V24.D[1], X26
    FMOV  D25, X21
    FMOV  V25.D[1], X21
    FMOV  D26, X26
    FMOV  V26.D[1], X22
    FMOV  D27, X17
    FMOV  V27.D[1], X12
    FMOV  D28, X13
    FMOV  V28.D[1], X5
    FMOV  D29, X3
    FMOV  V29.D[1], X13
    FMOV  D30, X3
    FMOV  V30.D[1], X17
    FMOV  D31, X10
    FMOV  V31.D[1], X23
    FRSQRTE  V15.4H, V25.4H
    FRSQRTS  V1.4H, V28.4H, V26.4H
    FSQRT  V9.4H, V24.4H
    FSUB  V21.8H, V29.8H, V7.8H
    FCVTAS  V24.2S, V30.2S
    FCVTAU  V25.2S, V27.2S
    FCVTL  V4.4S, V31.4H
    FCVTL2  V14.2D, V5.4S
    FCVTMS  V18.2S, V12.2S
    FCVTMU  V5.2D, V11.2D
    FCVTN  V6.2S, V31.2D
    FCVTN2  V10.8H, V29.4S
    FCVTNS  V3.4S, V7.4S
    FCVTNU  V22.4S, V11.4S
    FCVTPS  V17.2S, V29.2S
    FCVTPU  V2.4S, V0.4S
    FCVTXN  V30.2S, V31.2D
    FCVTXN2  V7.4S, V20.2D
    FCVTZS V13.2D, V20.2D, #37
    FCVTZS  V16.2S, V19.2S, #20
    FCVTZS  V11.2D, V12.2D
    FCVTZU V20.2D, V31.2D, #2
    FCVTZU  V23.4S, V29.4S, #32
    FCVTZU  V26.2D, V19.2D
    FCVTAS  V19.4H, V0.4H
    FCVTAU  V31.4H, V28.4H
    FCVTMS  V0.8H, V29.8H
    FCVTMU  V12.8H, V28.8H
    FCVTNS  V8.4H, V28.4H
    FCVTNU  V29.4H, V28.4H
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x15, LSL #0
    MRS  X18, FPSR
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, D0
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xf50b, LSL #0
    MOVK  X15, #0xf50b, LSL #16
    MOVK  X15, #0xf50b, LSL #32
    MOVK  X15, #0xf50b, LSL #48
    FMOV  X18, D1
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D2
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, V3.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, D3
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x4000, LSL #0
    MOVK  X15, #0x434b, LSL #16
    MOVK  X15, #0x4000, LSL #32
    MOVK  X15, #0x434b, LSL #48
    FMOV  X18, V4.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x4000, LSL #0
    MOVK  X15, #0x434b, LSL #16
    MOVK  X15, #0x4000, LSL #32
    MOVK  X15, #0x434b, LSL #48
    FMOV  X18, D4
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, V5.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D5
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    MOVK  X15, #0x7f80, LSL #48
    FMOV  X18, D6
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7f7f, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7f7f, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D7
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, D8
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x4b21, LSL #0
    MOVK  X15, #0x4b21, LSL #16
    MOVK  X15, #0x4b21, LSL #32
    MOVK  X15, #0x4b21, LSL #48
    FMOV  X18, D9
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x7fff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x7fff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, V10.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D10
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, D11
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, D12
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, V13.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, D13
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4000, LSL #16
    MOVK  X15, #0x4b4b, LSL #32
    MOVK  X15, #0x434b, LSL #48
    FMOV  X18, V14.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4000, LSL #16
    MOVK  X15, #0x4b4b, LSL #32
    MOVK  X15, #0x434b, LSL #48
    FMOV  X18, D14
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x2c7c, LSL #0
    MOVK  X15, #0x2c7c, LSL #16
    MOVK  X15, #0x2c7c, LSL #32
    MOVK  X15, #0x2c7c, LSL #48
    FMOV  X18, D15
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, D16
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, D17
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, D18
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, D19
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, V20.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D20
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, D21
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, V22.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D22
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, V23.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D23
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X18, D24
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D25
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, V26.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D26
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V27.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D27
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D28
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, D29
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0x7f7f, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7f7f, LSL #48
    FMOV  X18, D30
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, D31
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
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
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
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
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X23
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X3
    FMOV  D3, X28
    FMOV  V3.D[1], X22
    FMOV  D4, X21
    FMOV  V4.D[1], X13
    FMOV  D5, X22
    FMOV  V5.D[1], X21
    FMOV  D6, X26
    FMOV  V6.D[1], X9
    FMOV  D7, X9
    FMOV  V7.D[1], X2
    FMOV  D8, X28
    FMOV  V8.D[1], X7
    FMOV  D9, X24
    FMOV  V9.D[1], X13
    FMOV  D10, X10
    FMOV  V10.D[1], X26
    FMOV  D11, X28
    FMOV  V11.D[1], X23
    FMOV  D12, X5
    FMOV  V12.D[1], X12
    FMOV  D13, X22
    FMOV  V13.D[1], X12
    FMOV  D14, X14
    FMOV  V14.D[1], X2
    FMOV  D15, X26
    FMOV  V15.D[1], X7
    FMOV  D16, X2
    FMOV  V16.D[1], X17
    FMOV  D17, X20
    FMOV  V17.D[1], X29
    FMOV  D18, X9
    FMOV  V18.D[1], X7
    FMOV  D19, X16
    FMOV  V19.D[1], X14
    FMOV  D20, X17
    FMOV  V20.D[1], X24
    FMOV  D21, X22
    FMOV  V21.D[1], X24
    FMOV  D22, X13
    FMOV  V22.D[1], X13
    FMOV  D23, X9
    FMOV  V23.D[1], X28
    FMOV  D24, X4
    FMOV  V24.D[1], X14
    FMOV  D25, X28
    FMOV  V25.D[1], X11
    FMOV  D26, X7
    FMOV  V26.D[1], X3
    FMOV  D27, X29
    FMOV  V27.D[1], X13
    FMOV  D28, X9
    FMOV  V28.D[1], X7
    FMOV  D29, X21
    FMOV  V29.D[1], X16
    FMOV  D30, X13
    FMOV  V30.D[1], X22
    FMOV  D31, X10
    FMOV  V31.D[1], X21
    FCVTPU  V24.4H, V22.4H
    FCVTZS  V5.8H, V29.8H, #5
    FCVTZS  V22.4H, V31.4H
    FCVTZU  V4.8H, V19.8H, #11
    FCVTZU  V20.4H, V25.4H
    FRINTA  V31.4S, V30.4S
    FRINTI  V17.2S, V26.2S
    FRINTM  V28.2S, V14.2S
    FRINTN  V0.2D, V27.2D
    FRINTP  V19.2D, V30.2D
    FRINTX  V12.2S, V30.2S
    FRINTZ  V3.4S, V23.4S
    FRINTA  V16.4H, V8.4H
    FRINTI  V26.8H, V2.8H
    FRINTM  V23.8H, V14.8H
    FRINTN  V11.4H, V30.4H
    FRINTP  V21.4H, V8.4H
    FRINTX  V8.4H, V9.4H
    FRINTZ  V18.8H, V7.8H
    FMAX  V15.2D, V2.2D, V10.2D
    FMAXNM  V6.2D, V9.2D, V30.2D
    FMAXNMP D13, V27.2D
    FMAXNMP S25, V7.2S
    FMAXNMP  V29.2D, V27.2D, V29.2D
    FMAXNMV  S10, V30.4S
    FMAXP D27, V27.2D
    FMAXP S14, V7.2S
    FMAXP  V30.4S, V30.4S, V1.4S
    FMAXV  S1, V1.4S
    FMIN  V2.2D, V7.2D, V7.2D
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x15, LSL #0
    MRS  X18, FPSR
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D1
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D2
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V3.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D3
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, V4.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X18, D4
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1968, LSL #0
    MOVK  X15, #0x1968, LSL #16
    MOVK  X15, #0x1968, LSL #32
    MOVK  X15, #0x1968, LSL #48
    FMOV  X18, V5.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1968, LSL #0
    MOVK  X15, #0x1968, LSL #16
    MOVK  X15, #0x1968, LSL #32
    MOVK  X15, #0x1968, LSL #48
    FMOV  X18, D5
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D6
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D7
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a58, LSL #0
    MOVK  X15, #0x5a58, LSL #16
    MOVK  X15, #0x5a58, LSL #32
    MOVK  X15, #0x5a58, LSL #48
    FMOV  X18, D8
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V9.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D9
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D10
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a58, LSL #0
    MOVK  X15, #0x5a58, LSL #16
    MOVK  X15, #0x5a58, LSL #32
    MOVK  X15, #0x5a58, LSL #48
    FMOV  X18, D11
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D12
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D13
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D14
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V15.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D15
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a58, LSL #0
    MOVK  X15, #0x5a58, LSL #16
    MOVK  X15, #0x5a58, LSL #32
    MOVK  X15, #0x5a58, LSL #48
    FMOV  X18, D16
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D17
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a58, LSL #0
    MOVK  X15, #0x5a58, LSL #16
    MOVK  X15, #0x5a58, LSL #32
    MOVK  X15, #0x5a58, LSL #48
    FMOV  X18, V18.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a58, LSL #0
    MOVK  X15, #0x5a58, LSL #16
    MOVK  X15, #0x5a58, LSL #32
    MOVK  X15, #0x5a58, LSL #48
    FMOV  X18, D18
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D19
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, D20
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a60, LSL #0
    MOVK  X15, #0x5a60, LSL #16
    MOVK  X15, #0x5a60, LSL #32
    MOVK  X15, #0x5a60, LSL #48
    FMOV  X18, D21
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcb, LSL #0
    MOVK  X15, #0xcb, LSL #16
    MOVK  X15, #0xcb, LSL #32
    MOVK  X15, #0xcb, LSL #48
    FMOV  X18, D22
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a58, LSL #0
    MOVK  X15, #0x5a58, LSL #16
    MOVK  X15, #0x5a58, LSL #32
    MOVK  X15, #0x5a58, LSL #48
    FMOV  X18, V23.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a58, LSL #0
    MOVK  X15, #0x5a58, LSL #16
    MOVK  X15, #0x5a58, LSL #32
    MOVK  X15, #0x5a58, LSL #48
    FMOV  X18, D23
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xcc, LSL #0
    MOVK  X15, #0xcc, LSL #16
    MOVK  X15, #0xcc, LSL #32
    MOVK  X15, #0xcc, LSL #48
    FMOV  X18, D24
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D25
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a58, LSL #0
    MOVK  X15, #0x5a58, LSL #16
    MOVK  X15, #0x5a58, LSL #32
    MOVK  X15, #0x5a58, LSL #48
    FMOV  X18, V26.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a58, LSL #0
    MOVK  X15, #0x5a58, LSL #16
    MOVK  X15, #0x5a58, LSL #32
    MOVK  X15, #0x5a58, LSL #48
    FMOV  X18, D26
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D27
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D28
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V29.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D29
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V30.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V31.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D31
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
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
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
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
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X23
    FMOV  V1.D[1], X26
    FMOV  D2, X24
    FMOV  V2.D[1], X14
    FMOV  D3, X3
    FMOV  V3.D[1], X26
    FMOV  D4, X3
    FMOV  V4.D[1], X10
    FMOV  D5, X4
    FMOV  V5.D[1], X29
    FMOV  D6, X3
    FMOV  V6.D[1], X17
    FMOV  D7, X22
    FMOV  V7.D[1], X9
    FMOV  D8, X17
    FMOV  V8.D[1], X20
    FMOV  D9, X7
    FMOV  V9.D[1], X11
    FMOV  D10, X5
    FMOV  V10.D[1], X4
    FMOV  D11, X11
    FMOV  V11.D[1], X23
    FMOV  D12, X28
    FMOV  V12.D[1], X2
    FMOV  D13, X14
    FMOV  V13.D[1], X29
    FMOV  D14, X2
    FMOV  V14.D[1], X12
    FMOV  D15, X26
    FMOV  V15.D[1], X14
    FMOV  D16, X12
    FMOV  V16.D[1], X17
    FMOV  D17, X17
    FMOV  V17.D[1], X12
    FMOV  D18, X9
    FMOV  V18.D[1], X3
    FMOV  D19, X4
    FMOV  V19.D[1], X29
    FMOV  D20, X20
    FMOV  V20.D[1], X22
    FMOV  D21, X22
    FMOV  V21.D[1], X26
    FMOV  D22, X29
    FMOV  V22.D[1], X4
    FMOV  D23, X12
    FMOV  V23.D[1], X13
    FMOV  D24, X14
    FMOV  V24.D[1], X11
    FMOV  D25, X3
    FMOV  V25.D[1], X20
    FMOV  D26, X9
    FMOV  V26.D[1], X14
    FMOV  D27, X26
    FMOV  V27.D[1], X11
    FMOV  D28, X16
    FMOV  V28.D[1], X23
    FMOV  D29, X26
    FMOV  V29.D[1], X21
    FMOV  D30, X11
    FMOV  V30.D[1], X2
    FMOV  D31, X29
    FMOV  V31.D[1], X14
    FMINNMP D14, V17.2D
    FMINNMP S15, V24.2S
    FMINNMP  V24.2S, V29.2S, V23.2S
    FMINNMV  S10, V28.4S
    FMINP D16, V13.2D
    FMINP S23, V25.2S
    FMINP  V31.2D, V31.2D, V26.2D
    FMINV  S9, V27.4S
    FMAX  V30.8H, V11.8H, V27.8H
    FMAXNM  V0.8H, V18.8H, V12.8H
    FMAXNMP H27, V3.2H
    FMAXNMP  V19.8H, V22.8H, V17.8H
    FMAXNMV  H28, V17.8H
    FMAXP H25, V6.2H
    FMAXP  V21.4H, V4.4H, V26.4H
    FMAXV  H12, V22.4H
    FMIN  V6.4H, V13.4H, V1.4H
    FMINNM  V11.4H, V11.4H, V17.4H
    FMINNMP H17, V26.2H
    FMINNMP  V18.4H, V22.4H, V29.4H
    FMINNMV  H29, V29.4H
    FMINP H26, V7.2H
    FMINP  V13.4H, V5.4H, V1.4H
    FMINV  H22, V8.4H
    SMAX  V20.8B, V20.8B, V20.8B
    SMAXP  V4.8B, V7.8B, V3.8B
    SMAXV  B5, V1.8B
    SMAXV  H1, V8.8H
    SMAXV  S8, V7.4S
    SMIN  V7.8B, V2.8B, V3.8B
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x15, LSL #0
    MRS  X18, FPSR
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D1
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D2
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V3.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D3
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D4
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X18, D5
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D6
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D7
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D8
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D9
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D10
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D11
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D12
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D13
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D14
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D15
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D16
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D17
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D18
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D19
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D20
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D21
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D22
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D23
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D24
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D25
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D26
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D27
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D28
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D29
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V30.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V31.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D31
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
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
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
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
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X23
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X9
    FMOV  D3, X12
    FMOV  V3.D[1], X10
    FMOV  D4, X12
    FMOV  V4.D[1], X7
    FMOV  D5, X20
    FMOV  V5.D[1], X13
    FMOV  D6, X21
    FMOV  V6.D[1], X16
    FMOV  D7, X12
    FMOV  V7.D[1], X11
    FMOV  D8, X21
    FMOV  V8.D[1], X24
    FMOV  D9, X5
    FMOV  V9.D[1], X24
    FMOV  D10, X3
    FMOV  V10.D[1], X22
    FMOV  D11, X17
    FMOV  V11.D[1], X16
    FMOV  D12, X9
    FMOV  V12.D[1], X21
    FMOV  D13, X28
    FMOV  V13.D[1], X17
    FMOV  D14, X12
    FMOV  V14.D[1], X17
    FMOV  D15, X13
    FMOV  V15.D[1], X21
    FMOV  D16, X3
    FMOV  V16.D[1], X29
    FMOV  D17, X11
    FMOV  V17.D[1], X12
    FMOV  D18, X20
    FMOV  V18.D[1], X10
    FMOV  D19, X11
    FMOV  V19.D[1], X29
    FMOV  D20, X2
    FMOV  V20.D[1], X28
    FMOV  D21, X16
    FMOV  V21.D[1], X26
    FMOV  D22, X14
    FMOV  V22.D[1], X23
    FMOV  D23, X20
    FMOV  V23.D[1], X20
    FMOV  D24, X3
    FMOV  V24.D[1], X11
    FMOV  D25, X7
    FMOV  V25.D[1], X21
    FMOV  D26, X4
    FMOV  V26.D[1], X22
    FMOV  D27, X4
    FMOV  V27.D[1], X26
    FMOV  D28, X20
    FMOV  V28.D[1], X23
    FMOV  D29, X12
    FMOV  V29.D[1], X16
    FMOV  D30, X21
    FMOV  V30.D[1], X4
    FMOV  D31, X7
    FMOV  V31.D[1], X12
    SMINV  B3, V31.8B
    SMINV  H14, V27.8H
    SMINV  S26, V20.4S
    UMAX  V20.4H, V22.4H, V30.4H
    UMAXP  V17.8B, V29.8B, V28.8B
    UMAXV  B16, V31.16B
    UMAXV  H2, V2.4H
    UMAXV  S23, V23.4S
    UMIN  V19.4S, V1.4S, V30.4S
    UMINP  V12.2S, V29.2S, V8.2S
    UMINV  B21, V15.8B
    UMINV  H29, V31.8H
    UMINV  S9, V27.4S
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X18, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x15, LSL #0
    MRS  X18, FPSR
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V1.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D1
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D2
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X18, D3
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V4.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D4
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V5.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D5
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D6
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D7
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V8.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D8
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D9
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V10.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D10
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D11
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D12
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V13.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D13
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D14
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V15.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D15
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X18, D16
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D17
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V18.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D18
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D19
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D20
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a, LSL #0
    FMOV  X18, D21
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V22.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D22
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D23
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V24.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D24
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V25.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D25
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    FMOV  X18, D26
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V27.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D27
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D28
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    FMOV  X18, D29
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V30.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, V31.D[1]
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X18, D31
    SUB  X25, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X3
    FMOV  V2.D[1], X21
    FMOV  D3, X9
    FMOV  V3.D[1], X21
    FMOV  D4, X5
    FMOV  V4.D[1], X9
    FMOV  D5, X24
    FMOV  V5.D[1], X24
    FMOV  D6, X12
    FMOV  V6.D[1], X2
    FMOV  D7, X2
    FMOV  V7.D[1], X18
    FMOV  D8, X4
    FMOV  V8.D[1], X12
    FMOV  D9, X5
    FMOV  V9.D[1], X20
    FMOV  D10, X14
    FMOV  V10.D[1], X3
    FMOV  D11, X26
    FMOV  V11.D[1], X4
    FMOV  D12, X17
    FMOV  V12.D[1], X23
    FMOV  D13, X29
    FMOV  V13.D[1], X5
    FMOV  D14, X17
    FMOV  V14.D[1], X9
    FMOV  D15, X4
    FMOV  V15.D[1], X13
    FMOV  D16, X23
    FMOV  V16.D[1], X3
    FMOV  D17, X21
    FMOV  V17.D[1], X4
    FMOV  D18, X16
    FMOV  V18.D[1], X23
    FMOV  D19, X26
    FMOV  V19.D[1], X2
    FMOV  D20, X29
    FMOV  V20.D[1], X4
    FMOV  D21, X24
    FMOV  V21.D[1], X4
    FMOV  D22, X10
    FMOV  V22.D[1], X18
    FMOV  D23, X28
    FMOV  V23.D[1], X23
    FMOV  D24, X17
    FMOV  V24.D[1], X28
    FMOV  D25, X20
    FMOV  V25.D[1], X5
    FMOV  D26, X3
    FMOV  V26.D[1], X28
    FMOV  D27, X24
    FMOV  V27.D[1], X14
    FMOV  D28, X3
    FMOV  V28.D[1], X7
    FMOV  D29, X10
    FMOV  V29.D[1], X18
    FMOV  D30, X17
    FMOV  V30.D[1], X10
    FMOV  D31, X7
    FMOV  V31.D[1], X22
    FABD  V22.2D, V27.2D, V26.2D
    FABS  V15.2S, V30.2S
    FACGE  V24.2D, V23.2D, V24.2D
    FACGT  V8.2D, V28.2D, V31.2D
    FADD  V7.2D, V29.2D, V29.2D
    FADDP D25, V2.2D
    FADDP S28, V18.2S
    FADDP  V16.2D, V21.2D, V21.2D
    FDIV  V26.2D, V13.2D, V17.2D
    FMLA D29, D12, V19.D[0x0]
    FMLA S3, S30, V3.S[0x3]
    FMLA V1.2D, V6.2D, V5.D[0x1]
    FMLA V23.4S, V31.4S, V5.S[0x0]
    FMLA  V20.2D, V20.2D, V12.2D
    FMLS D17, D31, V9.D[0x1]
    FMLS S4, S30, V30.S[0x0]
    FMLS V5.2D, V9.2D, V0.D[0x0]
    FMLS V2.2S, V14.2S, V10.S[0x2]
    FMLS  V6.4S, V30.4S, V27.4S
    FMOV  V19.2D, #8.50000000
    FMOV  V0.2S, #-3.25000000
    FMUL D9, D18, V11.D[0x0]
    FMUL S18, S12, V21.S[0x2]
    FMUL V13.2D, V14.2D, V12.D[0x0]
    FMUL V30.4S, V10.4S, V12.S[0x0]
    FMUL  V27.2S, V31.2S, V11.2S
    FMULX D10, D21, V14.D[0x1]
    FMULX S14, S21, V14.S[0x1]
    FMULX V12.2D, V11.2D, V31.D[0x1]
    FMULX V21.2S, V11.2S, V31.S[0x1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x15, LSL #0
    MRS  X28, FPSR
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc050, LSL #16
    MOVK  X15, #0xc050, LSL #48
    FMOV  X28, D0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V1.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D1
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D2
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D3
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D4
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D5
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D6
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5b5, LSL #48
    FMOV  X28, V7.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5b5, LSL #48
    FMOV  X28, D7
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D8
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3a75, LSL #0
    MOVK  X15, #0xc1fe, LSL #16
    MOVK  X15, #0x4985, LSL #32
    MOVK  X15, #0xb5d, LSL #48
    FMOV  X28, D9
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3a75, LSL #0
    MOVK  X15, #0xc1fe, LSL #16
    MOVK  X15, #0x4985, LSL #32
    MOVK  X15, #0xb5d, LSL #48
    FMOV  X28, D10
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D11
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3a75, LSL #0
    MOVK  X15, #0xc1fe, LSL #16
    MOVK  X15, #0x4985, LSL #32
    MOVK  X15, #0xb5d, LSL #48
    FMOV  X28, V12.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3a75, LSL #0
    MOVK  X15, #0xc1fe, LSL #16
    MOVK  X15, #0x4985, LSL #32
    MOVK  X15, #0xb5d, LSL #48
    FMOV  X28, D12
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3a75, LSL #0
    MOVK  X15, #0xc1fe, LSL #16
    MOVK  X15, #0x4985, LSL #32
    MOVK  X15, #0xb5d, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3a75, LSL #0
    MOVK  X15, #0xc1fe, LSL #16
    MOVK  X15, #0x4985, LSL #32
    MOVK  X15, #0xb5d, LSL #48
    FMOV  X28, D13
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5de4, LSL #0
    MOVK  X15, #0xbd6, LSL #16
    FMOV  X28, D14
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0x25a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0x25a5, LSL #48
    FMOV  X28, D15
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5b5, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5b5, LSL #48
    FMOV  X28, D16
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5de4, LSL #0
    MOVK  X15, #0xbd6, LSL #16
    FMOV  X28, D18
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4021, LSL #48
    FMOV  X28, V19.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4021, LSL #48
    FMOV  X28, D19
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V20.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D20
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5de4, LSL #0
    MOVK  X15, #0xbd6, LSL #16
    MOVK  X15, #0x5de4, LSL #32
    MOVK  X15, #0xbd6, LSL #48
    FMOV  X28, D21
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D22
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D23
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X28, D24
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5b5, LSL #48
    FMOV  X28, D25
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3ff0, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3ff0, LSL #48
    FMOV  X28, D26
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5de4, LSL #0
    MOVK  X15, #0xbd6, LSL #16
    MOVK  X15, #0x5de4, LSL #32
    MOVK  X15, #0xbd6, LSL #48
    FMOV  X28, D27
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa625, LSL #16
    FMOV  X28, D28
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D29
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5de4, LSL #0
    MOVK  X15, #0xbd6, LSL #16
    MOVK  X15, #0x5de4, LSL #32
    MOVK  X15, #0xbd6, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x5de4, LSL #0
    MOVK  X15, #0xbd6, LSL #16
    MOVK  X15, #0x5de4, LSL #32
    MOVK  X15, #0xbd6, LSL #48
    FMOV  X28, D30
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D31
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
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
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X29
    FMOV  D1, X22
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X24
    FMOV  D3, X22
    FMOV  V3.D[1], X3
    FMOV  D4, X25
    FMOV  V4.D[1], X26
    FMOV  D5, X23
    FMOV  V5.D[1], X9
    FMOV  D6, X23
    FMOV  V6.D[1], X2
    FMOV  D7, X23
    FMOV  V7.D[1], X3
    FMOV  D8, X5
    FMOV  V8.D[1], X18
    FMOV  D9, X17
    FMOV  V9.D[1], X11
    FMOV  D10, X11
    FMOV  V10.D[1], X21
    FMOV  D11, X17
    FMOV  V11.D[1], X21
    FMOV  D12, X3
    FMOV  V12.D[1], X7
    FMOV  D13, X11
    FMOV  V13.D[1], X11
    FMOV  D14, X4
    FMOV  V14.D[1], X5
    FMOV  D15, X14
    FMOV  V15.D[1], X13
    FMOV  D16, X23
    FMOV  V16.D[1], X24
    FMOV  D17, X22
    FMOV  V17.D[1], X4
    FMOV  D18, X25
    FMOV  V18.D[1], X4
    FMOV  D19, X17
    FMOV  V19.D[1], X14
    FMOV  D20, X16
    FMOV  V20.D[1], X3
    FMOV  D21, X29
    FMOV  V21.D[1], X11
    FMOV  D22, X11
    FMOV  V22.D[1], X26
    FMOV  D23, X13
    FMOV  V23.D[1], X22
    FMOV  D24, X9
    FMOV  V24.D[1], X3
    FMOV  D25, X24
    FMOV  V25.D[1], X16
    FMOV  D26, X7
    FMOV  V26.D[1], X4
    FMOV  D27, X11
    FMOV  V27.D[1], X5
    FMOV  D28, X7
    FMOV  V28.D[1], X21
    FMOV  D29, X18
    FMOV  V29.D[1], X24
    FMOV  D30, X23
    FMOV  V30.D[1], X25
    FMOV  D31, X21
    FMOV  V31.D[1], X26
    FNEG  V22.2D, V25.2D
    FRECPE  V30.2D, V19.2D
    FRECPS  V1.2S, V29.2S, V20.2S
    FRSQRTE  V28.4S, V31.4S
    FRSQRTS  V31.2D, V23.2D, V27.2D
    FSQRT  V24.2D, V26.2D
    FSUB  V4.2D, V5.2D, V21.2D
    FABD  V9.4H, V29.4H, V0.4H
    FABS  V23.4H, V2.4H
    FACGE  V13.8H, V25.8H, V8.8H
    FACGT  V14.8H, V2.8H, V10.8H
    FADD  V27.8H, V21.8H, V15.8H
    FADDP H29, V29.2H
    FADDP  V5.8H, V21.8H, V17.8H
    FDIV  V25.8H, V3.8H, V25.8H
    FMLA H3, H8, V0.H[0x3]
    FMLA V11.8H, V21.8H, V0.H[0x6]
    FMLA  V26.4H, V16.4H, V6.4H
    FMLS H18, H8, V15.H[0x4]
    FMLS V20.8H, V21.8H, V0.H[0x3]
    FMLS  V12.4H, V15.4H, V19.4H
    FMOV  V19.4H, #-26.00000000
    FMUL H0, H6, V2.H[0x0]
    FMUL V17.4H, V16.4H, V15.H[0x1]
    FMUL  V7.4H, V15.4H, V21.4H
    FMULX H21, H2, V6.H[0x6]
    FMULX V10.4H, V2.4H, V6.H[0x7]
    FMULX  V2.8H, V2.8H, V15.8H
    FNEG  V16.8H, V8.8H
    FRECPE  V15.4H, V6.4H
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x15, LSL #0
    MRS  X28, FPSR
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xff7, LSL #0
    FMOV  X28, D0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4000, LSL #16
    MOVK  X15, #0x4000, LSL #48
    FMOV  X28, D1
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xff7, LSL #0
    MOVK  X15, #0xff7, LSL #16
    MOVK  X15, #0xff7, LSL #32
    MOVK  X15, #0xff7, LSL #48
    FMOV  X28, V2.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xff7, LSL #0
    MOVK  X15, #0xff7, LSL #16
    MOVK  X15, #0xff7, LSL #32
    MOVK  X15, #0xff7, LSL #48
    FMOV  X28, D2
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa585, LSL #0
    FMOV  X28, D3
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D4
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa9a5, LSL #0
    MOVK  X15, #0xa9a5, LSL #16
    MOVK  X15, #0xa9a5, LSL #32
    MOVK  X15, #0xa9a5, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa9a5, LSL #0
    MOVK  X15, #0xa9a5, LSL #16
    MOVK  X15, #0xa9a5, LSL #32
    MOVK  X15, #0xa9a5, LSL #48
    FMOV  X28, D5
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D6
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xff7, LSL #0
    MOVK  X15, #0xff7, LSL #16
    MOVK  X15, #0xff7, LSL #32
    MOVK  X15, #0xff7, LSL #48
    FMOV  X28, D7
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V8.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D8
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D9
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xff7, LSL #0
    MOVK  X15, #0xff7, LSL #16
    MOVK  X15, #0xff7, LSL #32
    MOVK  X15, #0xff7, LSL #48
    FMOV  X28, D10
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa585, LSL #0
    MOVK  X15, #0xa585, LSL #16
    MOVK  X15, #0xa585, LSL #32
    MOVK  X15, #0xa585, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa585, LSL #0
    MOVK  X15, #0xa585, LSL #16
    MOVK  X15, #0xa585, LSL #32
    MOVK  X15, #0xa585, LSL #48
    FMOV  X28, D11
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5c5, LSL #0
    MOVK  X15, #0xa5c5, LSL #16
    MOVK  X15, #0xa5c5, LSL #32
    MOVK  X15, #0xa5c5, LSL #48
    FMOV  X28, D12
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X28, D13
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D14
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xd1ac, LSL #0
    MOVK  X15, #0xd1ac, LSL #16
    MOVK  X15, #0xd1ac, LSL #32
    MOVK  X15, #0xd1ac, LSL #48
    FMOV  X28, D15
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x25a5, LSL #0
    MOVK  X15, #0x25a5, LSL #16
    MOVK  X15, #0x25a5, LSL #32
    MOVK  X15, #0x25a5, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x25a5, LSL #0
    MOVK  X15, #0x25a5, LSL #16
    MOVK  X15, #0x25a5, LSL #32
    MOVK  X15, #0x25a5, LSL #48
    FMOV  X28, D16
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xff7, LSL #0
    MOVK  X15, #0xff7, LSL #16
    MOVK  X15, #0xff7, LSL #32
    MOVK  X15, #0xff7, LSL #48
    FMOV  X28, D17
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5c5, LSL #0
    FMOV  X28, D18
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xce80, LSL #0
    MOVK  X15, #0xce80, LSL #16
    MOVK  X15, #0xce80, LSL #32
    MOVK  X15, #0xce80, LSL #48
    FMOV  X28, D19
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5c5, LSL #0
    MOVK  X15, #0xa5c5, LSL #16
    MOVK  X15, #0xa5c5, LSL #32
    MOVK  X15, #0xa5c5, LSL #48
    FMOV  X28, V20.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5c5, LSL #0
    MOVK  X15, #0xa5c5, LSL #16
    MOVK  X15, #0xa5c5, LSL #32
    MOVK  X15, #0xa5c5, LSL #48
    FMOV  X28, D20
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xff7, LSL #0
    FMOV  X28, D21
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0x25a5, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0x25a5, LSL #48
    FMOV  X28, D22
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x25a5, LSL #0
    MOVK  X15, #0x25a5, LSL #16
    MOVK  X15, #0x25a5, LSL #32
    MOVK  X15, #0x25a5, LSL #48
    FMOV  X28, D23
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X28, D24
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3c00, LSL #0
    MOVK  X15, #0x3c00, LSL #16
    MOVK  X15, #0x3c00, LSL #32
    MOVK  X15, #0x3c00, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3c00, LSL #0
    MOVK  X15, #0x3c00, LSL #16
    MOVK  X15, #0x3c00, LSL #32
    MOVK  X15, #0x3c00, LSL #48
    FMOV  X28, D25
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa585, LSL #0
    MOVK  X15, #0xa585, LSL #16
    MOVK  X15, #0xa585, LSL #32
    MOVK  X15, #0xa585, LSL #48
    FMOV  X28, D26
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa9a5, LSL #0
    MOVK  X15, #0xa9a5, LSL #16
    MOVK  X15, #0xa9a5, LSL #32
    MOVK  X15, #0xa9a5, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa9a5, LSL #0
    MOVK  X15, #0xa9a5, LSL #16
    MOVK  X15, #0xa9a5, LSL #32
    MOVK  X15, #0xa9a5, LSL #48
    FMOV  X28, D27
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7fc0, LSL #48
    FMOV  X28, V28.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7fc0, LSL #48
    FMOV  X28, D28
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa9a5, LSL #0
    FMOV  X28, D29
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa000, LSL #32
    MOVK  X15, #0xda37, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa000, LSL #32
    MOVK  X15, #0xda37, LSL #48
    FMOV  X28, D30
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3ff8, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3ff8, LSL #48
    FMOV  X28, D31
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
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
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X21
    FMOV  V1.D[1], X29
    FMOV  D2, X24
    FMOV  V2.D[1], X23
    FMOV  D3, X4
    FMOV  V3.D[1], X22
    FMOV  D4, X21
    FMOV  V4.D[1], X11
    FMOV  D5, X10
    FMOV  V5.D[1], X13
    FMOV  D6, X26
    FMOV  V6.D[1], X9
    FMOV  D7, X22
    FMOV  V7.D[1], X24
    FMOV  D8, X17
    FMOV  V8.D[1], X2
    FMOV  D9, X23
    FMOV  V9.D[1], X16
    FMOV  D10, X13
    FMOV  V10.D[1], X29
    FMOV  D11, X21
    FMOV  V11.D[1], X2
    FMOV  D12, X2
    FMOV  V12.D[1], X4
    FMOV  D13, X7
    FMOV  V13.D[1], X29
    FMOV  D14, X24
    FMOV  V14.D[1], X9
    FMOV  D15, X14
    FMOV  V15.D[1], X9
    FMOV  D16, X14
    FMOV  V16.D[1], X9
    FMOV  D17, X17
    FMOV  V17.D[1], X14
    FMOV  D18, X29
    FMOV  V18.D[1], X14
    FMOV  D19, X24
    FMOV  V19.D[1], X7
    FMOV  D20, X22
    FMOV  V20.D[1], X21
    FMOV  D21, X9
    FMOV  V21.D[1], X25
    FMOV  D22, X11
    FMOV  V22.D[1], X13
    FMOV  D23, X9
    FMOV  V23.D[1], X22
    FMOV  D24, X2
    FMOV  V24.D[1], X5
    FMOV  D25, X21
    FMOV  V25.D[1], X22
    FMOV  D26, X18
    FMOV  V26.D[1], X11
    FMOV  D27, X13
    FMOV  V27.D[1], X16
    FMOV  D28, X24
    FMOV  V28.D[1], X18
    FMOV  D29, X10
    FMOV  V29.D[1], X2
    FMOV  D30, X17
    FMOV  V30.D[1], X3
    FMOV  D31, X7
    FMOV  V31.D[1], X29
    FRSQRTE  V5.8H, V28.8H
    FRSQRTS  V19.8H, V23.8H, V22.8H
    FSQRT  V7.8H, V26.8H
    FSUB  V8.4H, V24.4H, V29.4H
    FCVTAS  V9.2D, V21.2D
    FCVTAU  V2.2S, V27.2S
    FCVTL  V25.4S, V30.4H
    FCVTL2  V3.4S, V6.8H
    FCVTMS  V29.2S, V21.2S
    FCVTMU  V13.4S, V18.4S
    FCVTN  V28.4H, V31.4S
    FCVTN2  V17.8H, V17.4S
    FCVTNS  V24.4S, V22.4S
    FCVTNU  V18.2D, V1.2D
    FCVTPS  V23.2S, V1.2S
    FCVTPU  V4.4S, V6.4S
    FCVTXN  V14.2S, V27.2D
    FCVTXN2  V1.4S, V6.2D
    FCVTZS V12.2D, V22.2D, #9
    FCVTZS  V15.4S, V30.4S, #1
    FCVTZS  V21.2D, V20.2D
    FCVTZU V16.2D, V6.2D, #14
    FCVTZU  V11.2S, V26.2S, #2
    FCVTZU  V0.4S, V20.4S
    FCVTAS  V31.8H, V6.8H
    FCVTAU  V22.4H, V6.4H
    FCVTMS  V30.8H, V30.8H
    FCVTMU  V26.4H, V10.4H
    FCVTNS  V6.8H, V10.8H
    FCVTNU  V10.4H, V10.4H
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1d, LSL #0
    MRS  X28, FPSR
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x1, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V1.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D1
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D2
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa000, LSL #0
    MOVK  X15, #0xbcb4, LSL #16
    MOVK  X15, #0xa000, LSL #32
    MOVK  X15, #0xbcb4, LSL #48
    FMOV  X28, V3.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa000, LSL #0
    MOVK  X15, #0xbcb4, LSL #16
    MOVK  X15, #0xa000, LSL #32
    MOVK  X15, #0xbcb4, LSL #48
    FMOV  X28, D3
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D4
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X28, D5
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D6
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X28, V7.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X28, D7
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D8
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D9
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D10
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D11
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D12
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D13
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x1, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D14
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D15
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D16
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D18
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e00, LSL #0
    MOVK  X15, #0x3e00, LSL #16
    MOVK  X15, #0x3e00, LSL #32
    MOVK  X15, #0x3e00, LSL #48
    FMOV  X28, V19.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x3e00, LSL #0
    MOVK  X15, #0x3e00, LSL #16
    MOVK  X15, #0x3e00, LSL #32
    MOVK  X15, #0x3e00, LSL #48
    FMOV  X28, D19
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V20.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D20
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D21
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D22
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D23
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D24
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa000, LSL #0
    MOVK  X15, #0xbcb4, LSL #16
    MOVK  X15, #0xa000, LSL #32
    MOVK  X15, #0xbcb4, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa000, LSL #0
    MOVK  X15, #0xbcb4, LSL #16
    MOVK  X15, #0xa000, LSL #32
    MOVK  X15, #0xbcb4, LSL #48
    FMOV  X28, D25
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D26
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D27
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D28
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X28, D29
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X28, D30
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V31.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D31
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
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
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X18
    FMOV  D3, X22
    FMOV  V3.D[1], X25
    FMOV  D4, X13
    FMOV  V4.D[1], X2
    FMOV  D5, X20
    FMOV  V5.D[1], X22
    FMOV  D6, X14
    FMOV  V6.D[1], X5
    FMOV  D7, X21
    FMOV  V7.D[1], X29
    FMOV  D8, X25
    FMOV  V8.D[1], X5
    FMOV  D9, X20
    FMOV  V9.D[1], X5
    FMOV  D10, X9
    FMOV  V10.D[1], X24
    FMOV  D11, X5
    FMOV  V11.D[1], X5
    FMOV  D12, X7
    FMOV  V12.D[1], X5
    FMOV  D13, X21
    FMOV  V13.D[1], X4
    FMOV  D14, X26
    FMOV  V14.D[1], X16
    FMOV  D15, X24
    FMOV  V15.D[1], X2
    FMOV  D16, X10
    FMOV  V16.D[1], X25
    FMOV  D17, X22
    FMOV  V17.D[1], X3
    FMOV  D18, X10
    FMOV  V18.D[1], X25
    FMOV  D19, X20
    FMOV  V19.D[1], X16
    FMOV  D20, X16
    FMOV  V20.D[1], X13
    FMOV  D21, X2
    FMOV  V21.D[1], X29
    FMOV  D22, X20
    FMOV  V22.D[1], X5
    FMOV  D23, X7
    FMOV  V23.D[1], X3
    FMOV  D24, X4
    FMOV  V24.D[1], X29
    FMOV  D25, X9
    FMOV  V25.D[1], X24
    FMOV  D26, X5
    FMOV  V26.D[1], X11
    FMOV  D27, X22
    FMOV  V27.D[1], X2
    FMOV  D28, X18
    FMOV  V28.D[1], X24
    FMOV  D29, X25
    FMOV  V29.D[1], X9
    FMOV  D30, X20
    FMOV  V30.D[1], X5
    FMOV  D31, X13
    FMOV  V31.D[1], X17
    FCVTPU  V15.8H, V26.8H
    FCVTZS  V23.4H, V29.4H, #4
    FCVTZS  V0.8H, V31.8H
    FCVTZU  V25.8H, V25.8H, #5
    FCVTZU  V7.8H, V28.8H
    FRINTA  V29.4S, V27.4S
    FRINTI  V28.2D, V30.2D
    FRINTM  V2.2S, V18.2S
    FRINTN  V11.2D, V19.2D
    FRINTP  V4.4S, V19.4S
    FRINTX  V26.4S, V5.4S
    FRINTZ  V21.2S, V12.2S
    FRINTA  V22.4H, V22.4H
    FRINTI  V12.8H, V30.8H
    FRINTM  V9.8H, V27.8H
    FRINTN  V6.4H, V14.4H
    FRINTP  V30.8H, V13.8H
    FRINTX  V31.8H, V14.8H
    FRINTZ  V10.8H, V24.8H
    FMAX  V19.4S, V14.4S, V20.4S
    FMAXNM  V5.4S, V27.4S, V20.4S
    FMAXNMP D8, V20.2D
    FMAXNMP S1, V24.2S
    FMAXNMP  V27.4S, V24.4S, V24.4S
    FMAXNMV  S16, V3.4S
    FMAXP D20, V3.2D
    FMAXP S13, V24.2S
    FMAXP  V17.2S, V3.2S, V17.2S
    FMAXV  S24, V14.4S
    FMIN  V3.2D, V18.2D, V18.2D
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1d, LSL #0
    MRS  X28, FPSR
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D1
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xbf80, LSL #16
    MOVK  X15, #0xbf80, LSL #48
    FMOV  X28, D2
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V3.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D3
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V4.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D4
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D5
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D6
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D7
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D8
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xbc00, LSL #0
    MOVK  X15, #0xbc00, LSL #16
    MOVK  X15, #0xbc00, LSL #32
    MOVK  X15, #0xbc00, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xbc00, LSL #0
    MOVK  X15, #0xbc00, LSL #16
    MOVK  X15, #0xbc00, LSL #32
    MOVK  X15, #0xbc00, LSL #48
    FMOV  X28, D9
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D10
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D11
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V12.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D12
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D13
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V14.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D14
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D15
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D16
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V18.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D18
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V19.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D19
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D20
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D21
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D22
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D23
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D24
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, D25
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D26
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D27
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V28.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D28
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V29.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D29
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D30
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x8000, LSL #48
    FMOV  X28, D31
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
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
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X24
    FMOV  V2.D[1], X7
    FMOV  D3, X22
    FMOV  V3.D[1], X2
    FMOV  D4, X22
    FMOV  V4.D[1], X29
    FMOV  D5, X23
    FMOV  V5.D[1], X16
    FMOV  D6, X11
    FMOV  V6.D[1], X18
    FMOV  D7, X25
    FMOV  V7.D[1], X25
    FMOV  D8, X13
    FMOV  V8.D[1], X3
    FMOV  D9, X26
    FMOV  V9.D[1], X2
    FMOV  D10, X25
    FMOV  V10.D[1], X29
    FMOV  D11, X11
    FMOV  V11.D[1], X26
    FMOV  D12, X24
    FMOV  V12.D[1], X16
    FMOV  D13, X29
    FMOV  V13.D[1], X23
    FMOV  D14, X24
    FMOV  V14.D[1], X10
    FMOV  D15, X21
    FMOV  V15.D[1], X14
    FMOV  D16, X16
    FMOV  V16.D[1], X22
    FMOV  D17, X3
    FMOV  V17.D[1], X10
    FMOV  D18, X26
    FMOV  V18.D[1], X23
    FMOV  D19, X21
    FMOV  V19.D[1], X18
    FMOV  D20, X29
    FMOV  V20.D[1], X3
    FMOV  D21, X4
    FMOV  V21.D[1], X18
    FMOV  D22, X7
    FMOV  V22.D[1], X26
    FMOV  D23, X24
    FMOV  V23.D[1], X17
    FMOV  D24, X9
    FMOV  V24.D[1], X24
    FMOV  D25, X26
    FMOV  V25.D[1], X11
    FMOV  D26, X22
    FMOV  V26.D[1], X13
    FMOV  D27, X2
    FMOV  V27.D[1], X4
    FMOV  D28, X3
    FMOV  V28.D[1], X11
    FMOV  D29, X7
    FMOV  V29.D[1], X14
    FMOV  D30, X13
    FMOV  V30.D[1], X18
    FMOV  D31, X25
    FMOV  V31.D[1], X14
    FMINNMP D3, V24.2D
    FMINNMP S21, V29.2S
    FMINNMP  V12.2S, V23.2S, V23.2S
    FMINNMV  S26, V28.4S
    FMINP D0, V27.2D
    FMINP S16, V30.2S
    FMINP  V5.4S, V25.4S, V31.4S
    FMINV  S19, V8.4S
    FMAX  V27.4H, V2.4H, V22.4H
    FMAXNM  V10.8H, V31.8H, V15.8H
    FMAXNMP H9, V4.2H
    FMAXNMP  V20.4H, V2.4H, V24.4H
    FMAXNMV  H24, V1.4H
    FMAXP H25, V18.2H
    FMAXP  V14.4H, V23.4H, V8.4H
    FMAXV  H13, V22.8H
    FMIN  V2.4H, V18.4H, V11.4H
    FMINNM  V7.8H, V28.8H, V18.8H
    FMINNMP H1, V28.2H
    FMINNMP  V8.4H, V11.4H, V8.4H
    FMINNMV  H4, V28.4H
    FMINP H28, V6.2H
    FMINP  V17.8H, V22.8H, V11.8H
    FMINV  H29, V6.4H
    SMAX  V6.8B, V6.8B, V15.8B
    SMAXP  V11.4H, V15.4H, V11.4H
    SMAXV  B15, V23.8B
    SMAXV  H31, V18.8H
    SMAXV  S30, V23.4S
    SMIN  V23.8H, V23.8H, V22.8H
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1d, LSL #0
    MRS  X28, FPSR
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D1
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D2
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D3
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D4
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D5
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D6
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V7.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D7
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D8
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D9
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D10
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D11
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D12
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D13
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D14
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5, LSL #0
    FMOV  X28, D15
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D16
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V18.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D18
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D19
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D20
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D21
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D22
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D23
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D24
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D25
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D26
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D27
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D28
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D29
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D30
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V31.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D31
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
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
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
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
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X25
    FMOV  V2.D[1], X10
    FMOV  D3, X14
    FMOV  V3.D[1], X7
    FMOV  D4, X20
    FMOV  V4.D[1], X22
    FMOV  D5, X5
    FMOV  V5.D[1], X20
    FMOV  D6, X25
    FMOV  V6.D[1], X3
    FMOV  D7, X13
    FMOV  V7.D[1], X11
    FMOV  D8, X5
    FMOV  V8.D[1], X7
    FMOV  D9, X13
    FMOV  V9.D[1], X13
    FMOV  D10, X14
    FMOV  V10.D[1], X2
    FMOV  D11, X7
    FMOV  V11.D[1], X26
    FMOV  D12, X16
    FMOV  V12.D[1], X10
    FMOV  D13, X26
    FMOV  V13.D[1], X20
    FMOV  D14, X13
    FMOV  V14.D[1], X5
    FMOV  D15, X23
    FMOV  V15.D[1], X21
    FMOV  D16, X4
    FMOV  V16.D[1], X22
    FMOV  D17, X9
    FMOV  V17.D[1], X26
    FMOV  D18, X2
    FMOV  V18.D[1], X24
    FMOV  D19, X4
    FMOV  V19.D[1], X3
    FMOV  D20, X2
    FMOV  V20.D[1], X7
    FMOV  D21, X9
    FMOV  V21.D[1], X14
    FMOV  D22, X18
    FMOV  V22.D[1], X17
    FMOV  D23, X5
    FMOV  V23.D[1], X10
    FMOV  D24, X25
    FMOV  V24.D[1], X24
    FMOV  D25, X18
    FMOV  V25.D[1], X24
    FMOV  D26, X13
    FMOV  V26.D[1], X25
    FMOV  D27, X26
    FMOV  V27.D[1], X29
    FMOV  D28, X3
    FMOV  V28.D[1], X21
    FMOV  D29, X25
    FMOV  V29.D[1], X20
    FMOV  D30, X13
    FMOV  V30.D[1], X20
    FMOV  D31, X10
    FMOV  V31.D[1], X10
    SMINV  B6, V31.16B
    SMINV  H29, V21.8H
    SMINV  S15, V23.4S
    UMAX  V1.2S, V30.2S, V26.2S
    UMAXP  V27.16B, V25.16B, V24.16B
    UMAXV  B14, V28.8B
    UMAXV  H7, V2.8H
    UMAXV  S0, V0.4S
    UMIN  V4.4S, V3.4S, V13.4S
    UMINP  V16.16B, V22.16B, V16.16B
    UMINV  B3, V25.8B
    UMINV  H24, V2.4H
    UMINV  S21, V22.4S
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X28, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x1d, LSL #0
    MRS  X28, FPSR
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D0
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D1
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V2.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D2
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5, LSL #0
    FMOV  X28, D3
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V4.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D4
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D5
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5, LSL #0
    FMOV  X28, D6
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D7
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V8.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D8
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D9
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D10
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D11
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V12.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D12
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D13
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5, LSL #0
    FMOV  X28, D14
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D15
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D16
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V18.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D18
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V19.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D19
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V20.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D20
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    FMOV  X28, D21
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D22
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D23
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D24
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D25
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D26
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D27
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V28.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D28
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    FMOV  X28, D29
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D30
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X28, D31
    SUB  X12, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, DataReverseAdvsimdVectorP02_TestFail

DataReverseAdvsimdVectorP02_TestEnd:
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
DataReverseAdvsimdVectorP02_TestFail:
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
