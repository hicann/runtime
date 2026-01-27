.global TSRTAdvsimdVectorFloatingPointOperation

.text
.p2align 4

TSRTAdvsimdVectorFloatingPointOperation:

TSRTAdvsimdVectorFloatingPointOperation_TestBegin:
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
    MOVZ  X2, #0xd3a0, LSL #0
    MOVK  X2, #0x7b16, LSL #16
    MOVK  X2, #0xa121, LSL #32
    MOVK  X2, #0x73d1, LSL #48
    MOVZ  X3, #0xd13a, LSL #0
    MOVK  X3, #0xf91f, LSL #16
    MOVK  X3, #0xdccd, LSL #32
    MOVK  X3, #0x9f2e, LSL #48
    MOVZ  X4, #0x1843, LSL #0
    MOVK  X4, #0xcdb0, LSL #16
    MOVK  X4, #0x585a, LSL #32
    MOVK  X4, #0x1b2f, LSL #48
    MOVZ  X5, #0x876, LSL #0
    MOVK  X5, #0xfcce, LSL #16
    MOVK  X5, #0x2cc2, LSL #32
    MOVK  X5, #0xd63d, LSL #48
    MOVZ  X6, #0x8f33, LSL #0
    MOVK  X6, #0xdcf9, LSL #16
    MOVK  X6, #0x76cc, LSL #32
    MOVK  X6, #0xf7d2, LSL #48
    MOVZ  X7, #0xe8ca, LSL #0
    MOVK  X7, #0xb565, LSL #16
    MOVK  X7, #0x4904, LSL #32
    MOVK  X7, #0xf6d6, LSL #48
    MOVZ  X8, #0x796f, LSL #0
    MOVK  X8, #0x101c, LSL #16
    MOVK  X8, #0x7b85, LSL #32
    MOVK  X8, #0xc54c, LSL #48
    MOVZ  X10, #0xd5a6, LSL #0
    MOVK  X10, #0x9919, LSL #16
    MOVK  X10, #0xe7d8, LSL #32
    MOVK  X10, #0xa5ba, LSL #48
    MOVZ  X11, #0x578e, LSL #0
    MOVK  X11, #0xb9d3, LSL #16
    MOVK  X11, #0x7f69, LSL #32
    MOVK  X11, #0x8faf, LSL #48
    MOVZ  X12, #0xf6fc, LSL #0
    MOVK  X12, #0x26ea, LSL #16
    MOVK  X12, #0x2c79, LSL #32
    MOVK  X12, #0x3170, LSL #48
    MOVZ  X13, #0x71b2, LSL #0
    MOVK  X13, #0x20d4, LSL #16
    MOVK  X13, #0xabe7, LSL #32
    MOVK  X13, #0x4a46, LSL #48
    MOVZ  X14, #0xa32c, LSL #0
    MOVK  X14, #0xfdf, LSL #16
    MOVK  X14, #0x707d, LSL #32
    MOVK  X14, #0x9998, LSL #48
    MOVZ  X15, #0xc995, LSL #0
    MOVK  X15, #0x7d67, LSL #16
    MOVK  X15, #0x651a, LSL #32
    MOVK  X15, #0xb943, LSL #48
    MOVZ  X16, #0x7483, LSL #0
    MOVK  X16, #0xafd7, LSL #16
    MOVK  X16, #0xd29b, LSL #32
    MOVK  X16, #0xe23f, LSL #48
    MOVZ  X17, #0xb312, LSL #0
    MOVK  X17, #0x9723, LSL #16
    MOVK  X17, #0x2a8f, LSL #32
    MOVK  X17, #0xb9a9, LSL #48
    MOVZ  X18, #0x8617, LSL #0
    MOVK  X18, #0x5ea, LSL #16
    MOVK  X18, #0x8196, LSL #32
    MOVK  X18, #0x938a, LSL #48
    MOVZ  X20, #0x1894, LSL #0
    MOVK  X20, #0x9c33, LSL #16
    MOVK  X20, #0x63db, LSL #32
    MOVK  X20, #0x3fb0, LSL #48
    MOVZ  X21, #0x7fbd, LSL #0
    MOVK  X21, #0xb42, LSL #16
    MOVK  X21, #0x8df2, LSL #32
    MOVK  X21, #0xbdaf, LSL #48
    MOVZ  X22, #0x7a24, LSL #0
    MOVK  X22, #0x826d, LSL #16
    MOVK  X22, #0x6a40, LSL #32
    MOVK  X22, #0x5729, LSL #48
    MOVZ  X23, #0x91b0, LSL #0
    MOVK  X23, #0x29a5, LSL #16
    MOVK  X23, #0x9bf3, LSL #32
    MOVK  X23, #0xc744, LSL #48
    MOVZ  X24, #0xbd4a, LSL #0
    MOVK  X24, #0x3300, LSL #16
    MOVK  X24, #0xca76, LSL #32
    MOVK  X24, #0x46e, LSL #48
    MOVZ  X25, #0x23db, LSL #0
    MOVK  X25, #0xd4ce, LSL #16
    MOVK  X25, #0x435d, LSL #32
    MOVK  X25, #0x85e0, LSL #48
    MOVZ  X27, #0xdddb, LSL #0
    MOVK  X27, #0x799c, LSL #16
    MOVK  X27, #0x8737, LSL #32
    MOVK  X27, #0x5271, LSL #48
    MOVZ  X28, #0xa207, LSL #0
    MOVK  X28, #0xc5b, LSL #16
    MOVK  X28, #0xea5c, LSL #32
    MOVK  X28, #0x93eb, LSL #48
    MOVZ  X2, #0xce56, LSL #0
    MOVK  X2, #0xe646, LSL #16
    MOVK  X2, #0xb34f, LSL #32
    MOVK  X2, #0x67dd, LSL #48
    MSR  FPCR, X2
    MOVZ  X2, #0x76a5, LSL #0
    MOVK  X2, #0xa133, LSL #16
    MOVK  X2, #0x7748, LSL #32
    MOVK  X2, #0x4322, LSL #48
    MSR  FPSR, X2
    MRS  X20, FPSR
    MOVZ  X5, #0xff60, LSL #0
    MOVK  X5, #0x7ff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    AND  X20, X20, X5
    MOVZ  X5, #0x0, LSL #0
    ORR  X20, X20, X5
    MSR  FPSR, X20
    ISB  SY
    ADDS  X14, X28, X21, SXTX #1
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x4397, LSL #0
    MOVK  X2, #0xfa1, LSL #16
    MOVK  X2, #0x34eb, LSL #32
    MOVK  X2, #0x33b, LSL #48
    MOVZ  X3, #0x8d7f, LSL #0
    MOVK  X3, #0x9954, LSL #16
    MOVK  X3, #0xa0a5, LSL #32
    MOVK  X3, #0x424e, LSL #48
    MOVZ  X4, #0x2a98, LSL #0
    MOVK  X4, #0x5ad4, LSL #16
    MOVK  X4, #0x3f3d, LSL #32
    MOVK  X4, #0x17e8, LSL #48
    MOVZ  X5, #0x9e0f, LSL #0
    MOVK  X5, #0x92a4, LSL #16
    MOVK  X5, #0xcc1f, LSL #32
    MOVK  X5, #0x6ee4, LSL #48
    MOVZ  X6, #0x9566, LSL #0
    MOVK  X6, #0x5807, LSL #16
    MOVK  X6, #0xda86, LSL #32
    MOVK  X6, #0x8f6e, LSL #48
    MOVZ  X7, #0x5eb9, LSL #0
    MOVK  X7, #0x84c0, LSL #16
    MOVK  X7, #0xa42e, LSL #32
    MOVK  X7, #0x2547, LSL #48
    MOVZ  X8, #0x6e74, LSL #0
    MOVK  X8, #0x28c9, LSL #16
    MOVK  X8, #0xe69, LSL #32
    MOVK  X8, #0xe433, LSL #48
    MOVZ  X10, #0x90e6, LSL #0
    MOVK  X10, #0x4648, LSL #16
    MOVK  X10, #0x275a, LSL #32
    MOVK  X10, #0x300f, LSL #48
    MOVZ  X11, #0xd41c, LSL #0
    MOVK  X11, #0x8420, LSL #16
    MOVK  X11, #0x3558, LSL #32
    MOVK  X11, #0xc654, LSL #48
    MOVZ  X12, #0xc51d, LSL #0
    MOVK  X12, #0x18a1, LSL #16
    MOVK  X12, #0x7b60, LSL #32
    MOVK  X12, #0x7dc3, LSL #48
    MOVZ  X13, #0x7c11, LSL #0
    MOVK  X13, #0x7714, LSL #16
    MOVK  X13, #0x768e, LSL #32
    MOVK  X13, #0x270e, LSL #48
    MOVZ  X14, #0x5473, LSL #0
    MOVK  X14, #0x4b3e, LSL #16
    MOVK  X14, #0xa115, LSL #32
    MOVK  X14, #0xee5a, LSL #48
    MOVZ  X15, #0xd0c5, LSL #0
    MOVK  X15, #0xc14d, LSL #16
    MOVK  X15, #0x7fdc, LSL #32
    MOVK  X15, #0x3e1e, LSL #48
    MOVZ  X16, #0x5957, LSL #0
    MOVK  X16, #0x2937, LSL #16
    MOVK  X16, #0x29a6, LSL #32
    MOVK  X16, #0x6d13, LSL #48
    MOVZ  X17, #0x2491, LSL #0
    MOVK  X17, #0x4f1b, LSL #16
    MOVK  X17, #0x404b, LSL #32
    MOVK  X17, #0xa193, LSL #48
    MOVZ  X18, #0x51c6, LSL #0
    MOVK  X18, #0x8bb4, LSL #16
    MOVK  X18, #0xe27c, LSL #32
    MOVK  X18, #0xd85, LSL #48
    MOVZ  X20, #0x87a9, LSL #0
    MOVK  X20, #0x6090, LSL #16
    MOVK  X20, #0x9d2, LSL #32
    MOVK  X20, #0xd1d7, LSL #48
    MOVZ  X21, #0x28ec, LSL #0
    MOVK  X21, #0x2fa3, LSL #16
    MOVK  X21, #0xb88d, LSL #32
    MOVK  X21, #0x1e0e, LSL #48
    MOVZ  X22, #0xc88b, LSL #0
    MOVK  X22, #0x839f, LSL #16
    MOVK  X22, #0x2da9, LSL #32
    MOVK  X22, #0xa29, LSL #48
    MOVZ  X23, #0x453, LSL #0
    MOVK  X23, #0xf77d, LSL #16
    MOVK  X23, #0x792f, LSL #32
    MOVK  X23, #0xdd20, LSL #48
    MOVZ  X24, #0xb97f, LSL #0
    MOVK  X24, #0xffa8, LSL #16
    MOVK  X24, #0x9611, LSL #32
    MOVK  X24, #0x1f72, LSL #48
    MOVZ  X25, #0x1c97, LSL #0
    MOVK  X25, #0x15b, LSL #16
    MOVK  X25, #0x3b80, LSL #32
    MOVK  X25, #0x5a7a, LSL #48
    MOVZ  X27, #0x38ff, LSL #0
    MOVK  X27, #0xa4a9, LSL #16
    MOVK  X27, #0x27aa, LSL #32
    MOVK  X27, #0xec7c, LSL #48
    MOVZ  X28, #0xaab7, LSL #0
    MOVK  X28, #0x1f92, LSL #16
    MOVK  X28, #0xd6a2, LSL #32
    MOVK  X28, #0x7276, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X23
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X5
    FMOV  D3, X3
    FMOV  V3.D[1], X20
    FMOV  D4, X21
    FMOV  V4.D[1], X25
    FMOV  D5, X18
    FMOV  V5.D[1], X15
    FMOV  D6, X22
    FMOV  V6.D[1], X21
    FMOV  D7, X13
    FMOV  V7.D[1], X4
    FMOV  D8, X15
    FMOV  V8.D[1], X25
    FMOV  D9, X16
    FMOV  V9.D[1], X14
    FMOV  D10, X28
    FMOV  V10.D[1], X13
    FMOV  D11, X5
    FMOV  V11.D[1], X4
    FMOV  D12, X21
    FMOV  V12.D[1], X20
    FMOV  D13, X24
    FMOV  V13.D[1], X20
    FMOV  D14, X18
    FMOV  V14.D[1], X20
    FMOV  D15, X12
    FMOV  V15.D[1], X23
    FMOV  D16, X27
    FMOV  V16.D[1], X15
    FMOV  D17, X18
    FMOV  V17.D[1], X24
    FMOV  D18, X14
    FMOV  V18.D[1], X22
    FMOV  D19, X21
    FMOV  V19.D[1], X13
    FMOV  D20, X24
    FMOV  V20.D[1], X27
    FMOV  D21, X15
    FMOV  V21.D[1], X23
    FMOV  D22, X27
    FMOV  V22.D[1], X6
    FMOV  D23, X27
    FMOV  V23.D[1], X13
    FMOV  D24, X15
    FMOV  V24.D[1], X25
    FMOV  D25, X23
    FMOV  V25.D[1], X15
    FMOV  D26, X20
    FMOV  V26.D[1], X17
    FMOV  D27, X4
    FMOV  V27.D[1], X20
    FMOV  D28, X16
    FMOV  V28.D[1], X8
    FMOV  D29, X20
    FMOV  V29.D[1], X23
    FMOV  D30, X11
    FMOV  V30.D[1], X10
    FMOV  D31, X25
    FMOV  V31.D[1], X28
    MOVZ  X25, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_0:
    FRSQRTE  V15.2D, V26.2D
    FACGE  V26.8H, V29.8H, V29.8H
    FMOV  V18.4S, #0.48437500
    FSQRT  V13.4H, V24.4H
    FABD  V2.4H, V31.4H, V18.4H
    FSUB  V13.2D, V13.2D, V21.2D
    FACGT  V29.2D, V25.2D, V20.2D
    FMUL  V14.4S, V15.4S, V30.4S
    FDIV  V0.2S, V2.2S, V26.2S
    FMLA  V23.2S, V13.2S, V28.2S
    FRSQRTS  V29.4S, V29.4S, V0.4S
    FMLS D3, D23, V27.D[0x0]
    FACGE  V30.4H, V14.4H, V6.4H
    FMUL  V20.2S, V29.2S, V24.2S
    FMLS V18.8H, V3.8H, V3.H[0x6]
    FMLA H24, H18, V4.H[0x6]
    FADDP H26, V30.2H
    FMUL V17.2D, V20.2D, V20.D[0x0]
    FMULX V15.2D, V26.2D, V17.D[0x1]
    FABD  V23.8H, V15.8H, V24.8H
    FADD  V25.4S, V28.4S, V16.4S
    FMULX D30, D30, V30.D[0x0]
    FADDP H18, V5.2H
    FMLA  V21.2S, V22.2S, V29.2S
    FABS  V4.8H, V14.8H
    FDIV  V14.4H, V14.4H, V20.4H
    FACGE  V20.4H, V27.4H, V0.4H
    FMLS  V2.2S, V19.2S, V27.2S
    FMULX H17, H30, V2.H[0x0]
    FMLS S30, S23, V11.S[0x3]
    FACGE  V3.2D, V17.2D, V18.2D
    FABD  V5.4S, V30.4S, V14.4S
    FABD  V29.2D, V5.2D, V25.2D
    FMLA V5.8H, V29.8H, V3.H[0x3]
    FADDP  V26.2S, V20.2S, V5.2S
    FADD  V0.8H, V26.8H, V4.8H
    FSQRT  V5.4H, V21.4H
    FRSQRTE  V19.2D, V0.2D
    FMULX V11.4H, V19.4H, V5.H[0x3]
    FDIV  V23.4H, V2.4H, V4.4H
    FACGT  V27.4H, V13.4H, V10.4H
    FMULX S17, S30, V27.S[0x3]
    FNEG  V30.8H, V21.8H
    FABS  V18.4S, V31.4S
    FMLS S31, S0, V19.S[0x2]
    FRECPS  V14.4H, V16.4H, V26.4H
    FMULX D15, D10, V21.D[0x0]
    FMLA D3, D2, V12.D[0x1]
    FSUB  V16.8H, V3.8H, V15.8H
    FMUL H29, H11, V9.H[0x0]
    FSQRT  V22.4H, V16.4H
    FMLA V20.2S, V29.2S, V10.S[0x3]
    FMULX V13.4H, V23.4H, V14.H[0x6]
    FMLS  V11.2D, V22.2D, V22.2D
    FMLA V22.2D, V21.2D, V13.D[0x1]
    FMUL V23.2D, V17.2D, V30.D[0x0]
    FRSQRTS  V17.4H, V18.4H, V15.4H
    FRSQRTE  V9.2S, V20.2S
    FABD  V27.4H, V31.4H, V16.4H
    FMLS H3, H27, V9.H[0x0]
    FMLA V25.4S, V3.4S, V11.S[0x3]
    FMLS H12, H26, V9.H[0x5]
    FACGE  V19.4H, V13.4H, V12.4H
    FMUL V14.2D, V19.2D, V25.D[0x0]
    FMLS S18, S18, V23.S[0x1]
    FMUL V23.2D, V17.2D, V14.D[0x0]
    FACGE  V29.4H, V22.4H, V18.4H
    FMLS V26.4H, V10.4H, V12.H[0x3]
    FADD  V21.2D, V26.2D, V23.2D
    FADDP H26, V21.2H
    FACGT  V21.4S, V26.4S, V26.4S
    FADDP  V3.2S, V21.2S, V21.2S
    FMUL  V25.4H, V3.4H, V29.4H
    FRSQRTS  V15.2S, V24.2S, V29.2S
    FADD  V2.8H, V29.8H, V27.8H
    FMLA  V11.2S, V7.2S, V16.2S
    FMULX V17.4H, V2.4H, V7.H[0x7]
    FMLA H16, H11, V4.H[0x5]
    FRSQRTS  V26.4S, V17.4S, V23.4S
    FACGT  V30.4H, V12.4H, V1.4H
    FMOV  V21.8H, #2.50000000
    FRECPE  V9.2D, V0.2D
    FMOV  V11.2D, #-1.68750000
    FRECPS  V31.8H, V28.8H, V16.8H
    FMLS S29, S22, V18.S[0x3]
    FMULX V3.2D, V25.2D, V25.D[0x0]
    FACGE  V10.8H, V31.8H, V3.8H
    FMUL H13, H11, V11.H[0x3]
    FNEG  V3.4H, V9.4H
    FMLA V19.4S, V10.4S, V26.S[0x0]
    FMLS S22, S15, V21.S[0x3]
    FMUL V31.4S, V30.4S, V30.S[0x1]
    FMLA  V24.4H, V29.4H, V13.4H
    FSQRT  V14.4S, V22.4S
    FMUL V1.2D, V14.2D, V19.D[0x1]
    FDIV  V27.2S, V3.2S, V1.2S
    FRECPS  V11.2D, V24.2D, V31.2D
    FMUL V24.8H, V27.8H, V11.H[0x2]
    FSQRT  V27.2S, V9.2S
    FMLA S26, S12, V20.S[0x0]
    FADDP  V3.4S, V5.4S, V8.4S
    FABD  V30.4H, V4.4H, V9.4H
    FMLA V11.2S, V12.2S, V24.S[0x0]
    FABD  V8.2S, V4.2S, V20.2S
    FMOV  V19.2D, #-9.50000000
    FMULX  V1.8H, V12.8H, V19.8H
    FMLA S18, S8, V28.S[0x3]
    FMUL S10, S25, V7.S[0x1]
    FMULX V4.2D, V26.2D, V22.D[0x0]
    FMOV  V15.2S, #2.87500000
    FMLS  V5.4S, V30.4S, V18.4S
    FMUL D22, D5, V11.D[0x0]
    FMOV  V26.2D, #-4.00000000
    FMULX D29, D3, V21.D[0x0]
    FMUL  V18.4H, V10.4H, V15.4H
    FACGT  V12.8H, V16.8H, V4.8H
    FABS  V7.2D, V29.2D
    FRECPE  V21.8H, V30.8H
    FMLS  V15.8H, V1.8H, V27.8H
    FSQRT  V11.4S, V12.4S
    FMLS V5.2D, V22.2D, V11.D[0x1]
    FMUL  V14.4H, V5.4H, V21.4H
    FMLS D29, D14, V14.D[0x0]
    FMOV  V30.2S, #0.15625000
    FABD  V5.8H, V15.8H, V15.8H
    FABD  V25.8H, V7.8H, V5.8H
    FADD  V7.4H, V18.4H, V25.4H
    FACGE  V12.2D, V25.2D, V7.2D
    FRECPS  V15.4H, V26.4H, V26.4H
    FMUL S14, S15, V30.S[0x0]
    FMLA D18, D14, V29.D[0x0]
    FMLS V1.4H, V12.4H, V14.H[0x5]
    FABD  V25.8H, V18.8H, V1.8H
    FRSQRTE  V21.2D, V4.2D
    FMULX D14, D16, V4.D[0x0]
    FACGE  V5.8H, V27.8H, V14.8H
    FMLS V22.4S, V17.4S, V22.S[0x0]
    FMULX  V10.4H, V7.4H, V2.4H
    FDIV  V29.2S, V27.2S, V11.2S
    FACGT  V26.4H, V31.4H, V18.4H
    FMUL V18.8H, V22.8H, V5.H[0x4]
    FRECPS  V14.8H, V17.8H, V30.8H
    FABD  V31.4H, V3.4H, V7.4H
    FACGT  V10.4H, V9.4H, V0.4H
    FMULX  V30.4H, V27.4H, V6.4H
    FMOV  V6.4H, #25.00000000
    FMULX V27.2D, V20.2D, V14.D[0x1]
    FMULX  V22.8H, V26.8H, V31.8H
    FMLA D31, D30, V22.D[0x1]
    FACGT  V0.4H, V6.4H, V27.4H
    FMULX D3, D29, V10.D[0x1]
    FMLS  V16.2S, V31.2S, V25.2S
    FMLS  V6.4S, V16.4S, V3.4S
    FADDP S7, V19.2S
    FRSQRTS  V15.4H, V6.4H, V0.4H
    FABD  V16.4H, V18.4H, V18.4H
    FMLS S31, S15, V7.S[0x2]
    FMLA D7, D31, V31.D[0x1]
    FMULX  V25.4H, V7.4H, V7.4H
    FMLS H5, H16, V4.H[0x4]
    FADD  V30.2D, V25.2D, V25.2D
    FMLS V18.4S, V5.4S, V5.S[0x2]
    FRSQRTE  V22.4H, V30.4H
    FABD  V7.4H, V18.4H, V22.4H
    FNEG  V2.8H, V7.8H
    FMULX  V29.2D, V3.2D, V2.2D
    FRSQRTE  V11.2S, V12.2S
    FRSQRTE  V12.8H, V12.8H
    FADDP  V27.2D, V27.2D, V3.2D
    FMUL V4.4S, V26.4S, V25.S[0x3]
    FADD  V7.8H, V31.8H, V5.8H
    FMULX V30.2D, V7.2D, V24.D[0x1]
    FABD  V3.4H, V25.4H, V23.4H
    FMLA V7.8H, V10.8H, V13.H[0x6]
    FRECPE  V16.4H, V28.4H
    FADD  V28.4S, V1.4S, V16.4S
    FRSQRTE  V15.2S, V28.2S
    FMULX V1.4S, V7.4S, V3.S[0x0]
    FRECPE  V3.4S, V15.4S
    FABD  V15.4H, V30.4H, V30.4H
    FDIV  V18.4S, V23.4S, V29.4S
    FMUL  V28.4S, V1.4S, V4.4S
    FRECPE  V2.2S, V13.2S
    FMUL V30.2S, V2.2S, V3.S[0x2]
    FMULX V5.8H, V27.8H, V15.H[0x0]
    FMLS  V23.8H, V12.8H, V11.8H
    FSUB  V16.2S, V18.2S, V18.2S
    FSUB  V7.4H, V5.4H, V30.4H
    FMULX H31, H23, V7.H[0x2]
    FSQRT  V12.2D, V16.2D
    FABS  V29.2D, V28.2D
    FMLA  V11.2S, V31.2S, V29.2S
    FSQRT  V24.2D, V11.2D
    FMULX  V16.4S, V12.4S, V24.4S
    FMLS D18, D3, V4.D[0x1]
    FNEG  V1.2D, V10.2D
    FMLS  V29.2D, V0.2D, V18.2D
    FMLA H13, H14, V3.H[0x1]
    FMOV  V27.2S, #0.43750000
    FMUL V2.2D, V4.2D, V20.D[0x1]
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_0
    MOVZ  X3, #0x2a98, LSL #0
    MOVK  X3, #0x5ad4, LSL #16
    MOVK  X3, #0x3f3d, LSL #32
    MOVK  X3, #0x17e8, LSL #48
    SUB  X12, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x9e0f, LSL #0
    MOVK  X3, #0x92a4, LSL #16
    MOVK  X3, #0xcc1f, LSL #32
    MOVK  X3, #0x6ee4, LSL #48
    SUB  X12, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x9566, LSL #0
    MOVK  X3, #0x5807, LSL #16
    MOVK  X3, #0xda86, LSL #32
    MOVK  X3, #0x8f6e, LSL #48
    SUB  X12, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x5eb9, LSL #0
    MOVK  X3, #0x84c0, LSL #16
    MOVK  X3, #0xa42e, LSL #32
    MOVK  X3, #0x2547, LSL #48
    SUB  X12, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x6e74, LSL #0
    MOVK  X3, #0x28c9, LSL #16
    MOVK  X3, #0xe69, LSL #32
    MOVK  X3, #0xe433, LSL #48
    SUB  X12, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x90e6, LSL #0
    MOVK  X3, #0x4648, LSL #16
    MOVK  X3, #0x275a, LSL #32
    MOVK  X3, #0x300f, LSL #48
    SUB  X12, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xd41c, LSL #0
    MOVK  X3, #0x8420, LSL #16
    MOVK  X3, #0x3558, LSL #32
    MOVK  X3, #0xc654, LSL #48
    SUB  X12, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7c11, LSL #0
    MOVK  X3, #0x7714, LSL #16
    MOVK  X3, #0x768e, LSL #32
    MOVK  X3, #0x270e, LSL #48
    SUB  X12, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x5473, LSL #0
    MOVK  X3, #0x4b3e, LSL #16
    MOVK  X3, #0xa115, LSL #32
    MOVK  X3, #0xee5a, LSL #48
    SUB  X12, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xd0c5, LSL #0
    MOVK  X3, #0xc14d, LSL #16
    MOVK  X3, #0x7fdc, LSL #32
    MOVK  X3, #0x3e1e, LSL #48
    SUB  X12, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x5957, LSL #0
    MOVK  X3, #0x2937, LSL #16
    MOVK  X3, #0x29a6, LSL #32
    MOVK  X3, #0x6d13, LSL #48
    SUB  X12, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x2491, LSL #0
    MOVK  X3, #0x4f1b, LSL #16
    MOVK  X3, #0x404b, LSL #32
    MOVK  X3, #0xa193, LSL #48
    SUB  X12, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x51c6, LSL #0
    MOVK  X3, #0x8bb4, LSL #16
    MOVK  X3, #0xe27c, LSL #32
    MOVK  X3, #0xd85, LSL #48
    SUB  X12, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x87a9, LSL #0
    MOVK  X3, #0x6090, LSL #16
    MOVK  X3, #0x9d2, LSL #32
    MOVK  X3, #0xd1d7, LSL #48
    SUB  X12, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x28ec, LSL #0
    MOVK  X3, #0x2fa3, LSL #16
    MOVK  X3, #0xb88d, LSL #32
    MOVK  X3, #0x1e0e, LSL #48
    SUB  X12, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xc88b, LSL #0
    MOVK  X3, #0x839f, LSL #16
    MOVK  X3, #0x2da9, LSL #32
    MOVK  X3, #0xa29, LSL #48
    SUB  X12, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x453, LSL #0
    MOVK  X3, #0xf77d, LSL #16
    MOVK  X3, #0x792f, LSL #32
    MOVK  X3, #0xdd20, LSL #48
    SUB  X12, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xb97f, LSL #0
    MOVK  X3, #0xffa8, LSL #16
    MOVK  X3, #0x9611, LSL #32
    MOVK  X3, #0x1f72, LSL #48
    SUB  X12, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x38ff, LSL #0
    MOVK  X3, #0xa4a9, LSL #16
    MOVK  X3, #0x27aa, LSL #32
    MOVK  X3, #0xec7c, LSL #48
    SUB  X12, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xaab7, LSL #0
    MOVK  X3, #0x1f92, LSL #16
    MOVK  X3, #0xd6a2, LSL #32
    MOVK  X3, #0x7276, LSL #48
    SUB  X12, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x1f, LSL #0
    MRS  X12, FPSR
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    FMOV  X12, D0
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #48
    FMOV  X12, D1
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, D2
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7f80, LSL #16
    MOVK  X3, #0x7f80, LSL #48
    FMOV  X12, V3.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x8000, LSL #0
    MOVK  X3, #0x5eb5, LSL #16
    MOVK  X3, #0x8000, LSL #32
    MOVK  X3, #0x5db5, LSL #48
    FMOV  X12, D3
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, D4
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, D5
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x4e40, LSL #0
    MOVK  X3, #0x4e40, LSL #16
    MOVK  X3, #0x4e40, LSL #32
    MOVK  X3, #0x4e40, LSL #48
    FMOV  X12, D6
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    MOVK  X3, #0x7e00, LSL #48
    FMOV  X12, D7
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7fc0, LSL #16
    MOVK  X3, #0x7fc0, LSL #48
    FMOV  X12, D8
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xf000, LSL #32
    MOVK  X3, #0x1df, LSL #48
    FMOV  X12, V9.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x1000, LSL #32
    MOVK  X3, #0x1df, LSL #48
    FMOV  X12, D9
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, D10
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7fc0, LSL #16
    MOVK  X3, #0x7f80, LSL #48
    FMOV  X12, D11
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7376, LSL #0
    MOVK  X3, #0xc0d4, LSL #16
    MOVK  X3, #0xa09e, LSL #32
    MOVK  X3, #0x5fd6, LSL #48
    FMOV  X12, D12
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    FMOV  X12, D13
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x4000, LSL #0
    MOVK  X3, #0x4000, LSL #16
    MOVK  X3, #0x4000, LSL #32
    MOVK  X3, #0x4000, LSL #48
    FMOV  X12, V14.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    MOVK  X3, #0x7e00, LSL #32
    MOVK  X3, #0x7e00, LSL #48
    FMOV  X12, D14
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, D15
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x4f70, LSL #0
    MOVK  X3, #0x4230, LSL #16
    MOVK  X3, #0x7f80, LSL #48
    FMOV  X12, D16
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    MOVK  X3, #0x7e00, LSL #32
    MOVK  X3, #0x7e00, LSL #48
    FMOV  X12, D17
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xff80, LSL #16
    MOVK  X3, #0xff80, LSL #48
    FMOV  X12, D18
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xc023, LSL #48
    FMOV  X12, V19.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xc023, LSL #48
    FMOV  X12, D19
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #32
    FMOV  X12, D20
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff0, LSL #48
    FMOV  X12, V21.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xf000, LSL #32
    MOVK  X3, #0x617f, LSL #48
    FMOV  X12, D21
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7c00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    MOVK  X3, #0x7c00, LSL #32
    MOVK  X3, #0x7c00, LSL #48
    FMOV  X12, D22
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    MOVK  X3, #0x7e00, LSL #32
    MOVK  X3, #0x7e00, LSL #48
    FMOV  X12, V23.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    MOVK  X3, #0x7e00, LSL #32
    MOVK  X3, #0x7e00, LSL #48
    FMOV  X12, D23
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7376, LSL #0
    MOVK  X3, #0xc0d4, LSL #16
    MOVK  X3, #0xa09e, LSL #32
    MOVK  X3, #0x5fb6, LSL #48
    FMOV  X12, D24
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x4448, LSL #16
    FMOV  X12, D25
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, D26
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x3ee0, LSL #16
    MOVK  X3, #0x3ee0, LSL #48
    FMOV  X12, D27
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7fc0, LSL #16
    FMOV  X12, D28
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff8, LSL #48
    FMOV  X12, D29
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7f80, LSL #16
    MOVK  X3, #0x7f80, LSL #48
    FMOV  X12, D30
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    FMOV  X12, D31
    SUB  X2, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X20
    FMOV  V0.D[1], X2
    FMOV  D1, X23
    FMOV  V1.D[1], X10
    FMOV  D2, X6
    FMOV  V2.D[1], X28
    FMOV  D3, X21
    FMOV  V3.D[1], X24
    FMOV  D4, X16
    FMOV  V4.D[1], X18
    FMOV  D5, X27
    FMOV  V5.D[1], X25
    FMOV  D6, X22
    FMOV  V6.D[1], X12
    FMOV  D7, X22
    FMOV  V7.D[1], X15
    FMOV  D8, X11
    FMOV  V8.D[1], X21
    FMOV  D9, X7
    FMOV  V9.D[1], X8
    FMOV  D10, X18
    FMOV  V10.D[1], X8
    FMOV  D11, X3
    FMOV  V11.D[1], X25
    FMOV  D12, X23
    FMOV  V12.D[1], X21
    FMOV  D13, X11
    FMOV  V13.D[1], X11
    FMOV  D14, X17
    FMOV  V14.D[1], X6
    FMOV  D15, X5
    FMOV  V15.D[1], X8
    FMOV  D16, X21
    FMOV  V16.D[1], X24
    FMOV  D17, X4
    FMOV  V17.D[1], X3
    FMOV  D18, X22
    FMOV  V18.D[1], X21
    FMOV  D19, X7
    FMOV  V19.D[1], X20
    FMOV  D20, X5
    FMOV  V20.D[1], X14
    FMOV  D21, X2
    FMOV  V21.D[1], X12
    FMOV  D22, X20
    FMOV  V22.D[1], X13
    FMOV  D23, X11
    FMOV  V23.D[1], X25
    FMOV  D24, X23
    FMOV  V24.D[1], X21
    FMOV  D25, X12
    FMOV  V25.D[1], X4
    FMOV  D26, X14
    FMOV  V26.D[1], X3
    FMOV  D27, X21
    FMOV  V27.D[1], X13
    FMOV  D28, X4
    FMOV  V28.D[1], X21
    FMOV  D29, X27
    FMOV  V29.D[1], X20
    FMOV  D30, X22
    FMOV  V30.D[1], X8
    FMOV  D31, X25
    FMOV  V31.D[1], X25
    MOVZ  X28, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_1:
    FMLA D1, D21, V26.D[0x1]
    FMLA V27.2D, V27.2D, V24.D[0x1]
    FABD  V22.2S, V20.2S, V27.2S
    FRECPS  V29.8H, V25.8H, V31.8H
    FRSQRTS  V19.2S, V29.2S, V22.2S
    FRECPE  V25.8H, V28.8H
    FMLA S5, S19, V30.S[0x0]
    FMLS V12.2S, V1.2S, V25.S[0x2]
    FMULX S14, S5, V5.S[0x3]
    FRSQRTS  V25.8H, V12.8H, V12.8H
    FMULX S10, S25, V25.S[0x1]
    FMULX  V22.8H, V10.8H, V10.8H
    FMLS  V21.4S, V14.4S, V22.4S
    FMLA V5.4S, V21.4S, V21.S[0x2]
    FRSQRTE  V26.2S, V5.2S
    FMULX D28, D27, V17.D[0x1]
    FADDP S1, V19.2S
    FRECPE  V19.2D, V1.2D
    FMUL V30.2D, V0.2D, V22.D[0x0]
    FMLS  V17.2S, V4.2S, V29.2S
    FMLS D22, D26, V18.D[0x1]
    FDIV  V12.2S, V0.2S, V9.2S
    FMUL  V0.8H, V7.8H, V18.8H
    FRSQRTS  V1.8H, V11.8H, V30.8H
    FACGT  V25.2D, V27.2D, V18.2D
    FRECPS  V26.4S, V20.4S, V4.4S
    FMULX V20.4S, V17.4S, V26.S[0x3]
    FMLA S29, S29, V28.S[0x1]
    FMUL V17.2D, V25.2D, V19.D[0x1]
    FMUL D5, D14, V12.D[0x0]
    FMULX D4, D25, V20.D[0x0]
    FMUL  V14.4H, V0.4H, V4.4H
    FMOV  V9.4S, #3.12500000
    FSQRT  V21.2D, V29.2D
    FMLA S29, S1, V5.S[0x3]
    FMOV  V7.8H, #-2.62500000
    FRECPE  V20.4H, V17.4H
    FMULX V17.2D, V22.2D, V4.D[0x0]
    FMOV  V30.4H, #1.75000000
    FACGE  V5.4H, V21.4H, V14.4H
    FADDP S0, V20.2S
    FACGE  V1.2D, V9.2D, V7.2D
    FACGT  V4.2D, V30.2D, V0.2D
    FRSQRTS  V21.4H, V4.4H, V1.4H
    FNEG  V30.4H, V21.4H
    FACGT  V22.4H, V17.4H, V29.4H
    FMOV  V19.4H, #0.28125000
    FDIV  V1.4H, V19.4H, V19.4H
    FADDP H21, V5.2H
    FMLS V14.4H, V22.4H, V11.H[0x1]
    FDIV  V22.2S, V30.2S, V14.2S
    FMLA V0.2S, V1.2S, V21.S[0x0]
    FACGT  V7.8H, V22.8H, V0.8H
    FADDP S29, V2.2S
    FMLA V5.2D, V10.2D, V25.D[0x0]
    FMUL V20.2D, V31.2D, V30.D[0x1]
    FMLS S31, S14, V9.S[0x1]
    FABD  V25.8H, V20.8H, V16.8H
    FRSQRTS  V2.2D, V19.2D, V12.2D
    FABS  V19.4H, V22.4H
    FSQRT  V10.2S, V15.2S
    FMLA  V16.4H, V12.4H, V4.4H
    FSUB  V20.2S, V19.2S, V5.2S
    FMLS S20, S7, V7.S[0x3]
    FMLA  V11.2D, V2.2D, V29.2D
    FADDP  V26.2D, V31.2D, V20.2D
    FMLA V14.2D, V25.2D, V26.D[0x0]
    FABS  V25.2S, V10.2S
    FMULX V17.2D, V11.2D, V25.D[0x1]
    FACGT  V25.4S, V14.4S, V17.4S
    FABD  V20.4S, V16.4S, V16.4S
    FADDP H26, V20.2H
    FNEG  V9.8H, V26.8H
    FMLA V31.2S, V9.2S, V25.S[0x3]
    FMUL V19.2D, V7.2D, V6.D[0x0]
    FMUL  V16.2D, V5.2D, V8.2D
    FABS  V5.4H, V0.4H
    FRECPS  V25.4H, V20.4H, V23.4H
    FMUL D30, D29, V30.D[0x0]
    FABD  V2.2S, V28.2S, V13.2S
    FADDP  V10.2S, V4.2S, V5.2S
    FABS  V26.2S, V22.2S
    FMULX D20, D7, V24.D[0x0]
    FMULX V13.2S, V19.2S, V19.S[0x3]
    FABS  V17.8H, V20.8H
    FACGE  V6.2D, V25.2D, V25.2D
    FACGT  V24.4H, V31.4H, V17.4H
    FNEG  V28.4H, V16.4H
    FRSQRTS  V17.2D, V13.2D, V2.2D
    FACGT  V11.8H, V30.8H, V28.8H
    FSQRT  V12.4H, V28.4H
    FSQRT  V0.8H, V12.8H
    FADD  V31.2S, V0.2S, V0.2S
    FMLS  V23.8H, V26.8H, V24.8H
    FRSQRTS  V30.4S, V23.4S, V11.4S
    FMULX D9, D17, V30.D[0x1]
    FRECPS  V20.8H, V9.8H, V2.8H
    FMUL H9, H6, V6.H[0x5]
    FACGT  V6.4S, V31.4S, V10.4S
    FMULX V14.2D, V20.2D, V6.D[0x0]
    FMULX  V28.8H, V9.8H, V14.8H
    FADDP  V8.4S, V18.4S, V24.4S
    FADDP  V7.8H, V6.8H, V20.8H
    FMLA S13, S26, V27.S[0x1]
    FRECPS  V4.4S, V2.4S, V18.4S
    FSUB  V11.4S, V10.4S, V8.4S
    FMLA  V31.2D, V16.2D, V25.2D
    FMLA V30.8H, V26.8H, V7.H[0x3]
    FMLA  V7.4H, V21.4H, V26.4H
    FMULX V27.2D, V9.2D, V19.D[0x1]
    FMOV  V24.2D, #-13.00000000
    FRECPS  V25.2D, V13.2D, V7.2D
    FADDP  V13.8H, V11.8H, V4.8H
    FACGE  V0.2D, V13.2D, V28.2D
    FMULX V14.2D, V31.2D, V10.D[0x1]
    FSQRT  V18.4S, V24.4S
    FMULX V16.2S, V30.2S, V14.S[0x0]
    FSQRT  V11.4H, V16.4H
    FSUB  V30.4S, V18.4S, V25.4S
    FMUL V2.8H, V30.8H, V4.H[0x6]
    FACGT  V7.4H, V27.4H, V20.4H
    FACGE  V24.8H, V2.8H, V1.8H
    FMUL V14.2D, V11.2D, V24.D[0x0]
    FMUL V17.2D, V14.2D, V14.D[0x1]
    FMLS  V6.4S, V0.4S, V7.4S
    FRECPE  V24.2D, V6.2D
    FMUL  V16.4S, V23.4S, V24.4S
    FMOV  V4.2D, #1.93750000
    FMULX V2.2S, V17.2S, V4.S[0x1]
    FRSQRTE  V0.8H, V16.8H
    FRECPS  V17.8H, V2.8H, V2.8H
    FMUL S8, S17, V6.S[0x2]
    FRECPE  V4.8H, V0.8H
    FMLA H20, H25, V8.H[0x5]
    FRSQRTS  V6.4H, V4.4H, V20.4H
    FRECPE  V17.2D, V22.2D
    FACGT  V18.4S, V30.4S, V29.4S
    FMLS V29.2S, V27.2S, V6.S[0x0]
    FMLS H24, H30, V7.H[0x6]
    FABS  V11.4H, V25.4H
    FDIV  V23.4H, V19.4H, V26.4H
    FRSQRTE  V25.8H, V23.8H
    FRECPE  V16.2S, V9.2S
    FABD  V9.2S, V31.2S, V13.2S
    FACGE  V2.2D, V8.2D, V12.2D
    FMLA V0.2D, V18.2D, V22.D[0x0]
    FMULX  V20.4H, V0.4H, V0.4H
    FSUB  V18.8H, V20.8H, V11.8H
    FSUB  V20.4H, V8.4H, V17.4H
    FABS  V12.2S, V18.2S
    FMUL V23.4H, V29.4H, V12.H[0x0]
    FMLS  V26.2D, V25.2D, V25.2D
    FSUB  V25.2S, V30.2S, V20.2S
    FMLA  V30.2S, V16.2S, V25.2S
    FADDP  V0.2S, V24.2S, V23.2S
    FMLS V11.4S, V9.4S, V30.S[0x3]
    FMLA V18.8H, V2.8H, V3.H[0x7]
    FMULX  V4.2S, V11.2S, V11.2S
    FDIV  V20.8H, V26.8H, V21.8H
    FACGT  V25.2S, V4.2S, V20.2S
    FMLA V13.8H, V0.8H, V8.H[0x0]
    FADD  V29.8H, V25.8H, V18.8H
    FRSQRTE  V12.2D, V13.2D
    FMUL D9, D29, V12.D[0x1]
    FSQRT  V24.2D, V2.2D
    FADDP D0, V7.2D
    FRECPS  V25.2S, V7.2S, V20.2S
    FRSQRTE  V7.4H, V30.4H
    FDIV  V26.2D, V21.2D, V3.2D
    FMLS H3, H1, V14.H[0x7]
    FABD  V20.4H, V7.4H, V1.4H
    FMULX V2.4S, V25.4S, V25.S[0x0]
    FRECPS  V31.8H, V8.8H, V31.8H
    FMUL H17, H12, V8.H[0x4]
    FSUB  V13.4H, V0.4H, V9.4H
    FMULX V7.2S, V13.2S, V24.S[0x3]
    FRECPE  V12.8H, V26.8H
    FMLS D26, D5, V20.D[0x1]
    FMOV  V29.2D, #-0.16406250
    FMULX  V11.2D, V25.2D, V25.2D
    FMLA V18.8H, V11.8H, V2.H[0x7]
    FNEG  V8.2D, V31.2D
    FABS  V14.8H, V29.8H
    FMLA V20.2D, V3.2D, V17.D[0x0]
    FMUL H3, H7, V8.H[0x2]
    FSQRT  V29.2S, V3.2S
    FMLS D4, D18, V26.D[0x0]
    FSQRT  V8.8H, V14.8H
    FMLA V1.2S, V29.2S, V8.S[0x2]
    FDIV  V7.2D, V12.2D, V12.2D
    FDIV  V17.4S, V1.4S, V7.4S
    FMLA V30.4H, V9.4H, V6.H[0x7]
    FMULX  V3.8H, V30.8H, V20.8H
    FMLA S25, S17, V4.S[0x0]
    FMOV  V8.4S, #-0.20312500
    FSQRT  V31.8H, V3.8H
    FMLS V14.2D, V31.2D, V25.D[0x1]
    FMLS H0, H14, V14.H[0x6]
    FRECPE  V29.8H, V8.8H
    FRECPE  V26.4S, V29.4S
    SUBS  X28, X28, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_1
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x1f, LSL #0
    MRS  X13, FPSR
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D0
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x3c00, LSL #0
    MOVK  X10, #0x3c00, LSL #16
    MOVK  X10, #0x3c00, LSL #32
    MOVK  X10, #0x3c00, LSL #48
    FMOV  X13, D1
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x4080, LSL #16
    MOVK  X10, #0x4080, LSL #48
    FMOV  X13, D2
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x4000, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x4000, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X13, D3
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    MOVK  X10, #0x7fc0, LSL #48
    FMOV  X13, D4
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x3c0, LSL #0
    MOVK  X10, #0x7e08, LSL #16
    FMOV  X13, D5
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x3e00, LSL #16
    MOVK  X10, #0x3e00, LSL #32
    MOVK  X10, #0x3e00, LSL #48
    FMOV  X13, D6
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3ff0, LSL #48
    FMOV  X13, V7.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3ff0, LSL #48
    FMOV  X13, D7
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xbe50, LSL #16
    MOVK  X10, #0xbe50, LSL #48
    FMOV  X13, V8.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xbe50, LSL #16
    MOVK  X10, #0xbe50, LSL #48
    FMOV  X13, D8
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xb0b2, LSL #0
    MOVK  X10, #0xb0b2, LSL #16
    MOVK  X10, #0xbcb2, LSL #32
    MOVK  X10, #0xbd4c, LSL #48
    FMOV  X13, D9
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    MOVK  X10, #0x3c0, LSL #32
    MOVK  X10, #0x7e08, LSL #48
    FMOV  X13, D10
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x100, LSL #0
    MOVK  X10, #0x8000, LSL #16
    MOVK  X10, #0x4010, LSL #48
    FMOV  X13, D11
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7c00, LSL #0
    MOVK  X10, #0x7c00, LSL #16
    MOVK  X10, #0x7c00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X13, V12.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7c00, LSL #0
    MOVK  X10, #0x7c00, LSL #16
    MOVK  X10, #0x7c00, LSL #32
    MOVK  X10, #0x7c00, LSL #48
    FMOV  X13, D12
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x30b2, LSL #0
    MOVK  X10, #0x30b2, LSL #16
    MOVK  X10, #0x3cb2, LSL #32
    MOVK  X10, #0x3d4c, LSL #48
    FMOV  X13, D13
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3fc5, LSL #48
    FMOV  X13, V14.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3fc5, LSL #48
    FMOV  X13, D14
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7f80, LSL #16
    MOVK  X10, #0x7f80, LSL #48
    FMOV  X13, D16
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    FMOV  X13, V17.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7f80, LSL #16
    MOVK  X10, #0xc889, LSL #32
    MOVK  X10, #0x3b88, LSL #48
    FMOV  X13, D17
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7e00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X13, V18.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7e00, LSL #32
    MOVK  X10, #0xbd54, LSL #48
    FMOV  X13, D18
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D19
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7c00, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7c00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X13, D20
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D21
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7f82, LSL #0
    MOVK  X10, #0xbf80, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xff7f, LSL #48
    FMOV  X13, D22
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7e00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X13, D23
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    FMOV  X13, V24.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D24
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    FMOV  X13, D25
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xc5e3, LSL #16
    MOVK  X10, #0xc5e3, LSL #48
    FMOV  X13, V26.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xc5e3, LSL #16
    MOVK  X10, #0xc5e3, LSL #48
    FMOV  X13, D26
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, D27
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X13, V28.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X13, D28
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7c00, LSL #0
    MOVK  X10, #0xb910, LSL #16
    MOVK  X10, #0x7c00, LSL #32
    MOVK  X10, #0xb910, LSL #48
    FMOV  X13, V29.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7c00, LSL #0
    MOVK  X10, #0xb910, LSL #16
    MOVK  X10, #0x7c00, LSL #32
    MOVK  X10, #0xb910, LSL #48
    FMOV  X13, D29
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X13, D30
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x3da9, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x3da9, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X13, D31
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X16
    FMOV  D3, X2
    FMOV  V3.D[1], X11
    FMOV  D4, X21
    FMOV  V4.D[1], X6
    FMOV  D5, X11
    FMOV  V5.D[1], X15
    FMOV  D6, X13
    FMOV  V6.D[1], X10
    FMOV  D7, X28
    FMOV  V7.D[1], X22
    FMOV  D8, X25
    FMOV  V8.D[1], X23
    FMOV  D9, X10
    FMOV  V9.D[1], X25
    FMOV  D10, X28
    FMOV  V10.D[1], X3
    FMOV  D11, X3
    FMOV  V11.D[1], X7
    FMOV  D12, X24
    FMOV  V12.D[1], X22
    FMOV  D13, X15
    FMOV  V13.D[1], X2
    FMOV  D14, X6
    FMOV  V14.D[1], X13
    FMOV  D15, X25
    FMOV  V15.D[1], X16
    FMOV  D16, X21
    FMOV  V16.D[1], X28
    FMOV  D17, X13
    FMOV  V17.D[1], X15
    FMOV  D18, X12
    FMOV  V18.D[1], X18
    FMOV  D19, X13
    FMOV  V19.D[1], X5
    FMOV  D20, X25
    FMOV  V20.D[1], X24
    FMOV  D21, X16
    FMOV  V21.D[1], X28
    FMOV  D22, X27
    FMOV  V22.D[1], X25
    FMOV  D23, X18
    FMOV  V23.D[1], X22
    FMOV  D24, X2
    FMOV  V24.D[1], X3
    FMOV  D25, X10
    FMOV  V25.D[1], X5
    FMOV  D26, X27
    FMOV  V26.D[1], X14
    FMOV  D27, X16
    FMOV  V27.D[1], X27
    FMOV  D28, X28
    FMOV  V28.D[1], X23
    FMOV  D29, X27
    FMOV  V29.D[1], X24
    FMOV  D30, X20
    FMOV  V30.D[1], X24
    FMOV  D31, X20
    FMOV  V31.D[1], X12
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_2:
    FMOV  V22.8H, #-15.00000000
    FMUL D8, D26, V29.D[0x0]
    FDIV  V26.8H, V23.8H, V27.8H
    FMUL  V5.4H, V25.4H, V30.4H
    FSUB  V29.4S, V28.4S, V28.4S
    FMUL  V26.4H, V26.4H, V29.4H
    FMOV  V2.4S, #-0.21875000
    FMLS V5.2D, V31.2D, V22.D[0x1]
    FMLS V27.4S, V5.4S, V5.S[0x2]
    FMLS V31.2S, V27.2S, V24.S[0x2]
    FMUL D22, D26, V8.D[0x0]
    FMULX S10, S2, V22.S[0x1]
    FACGE  V19.8H, V10.8H, V10.8H
    FMULX V28.4H, V19.4H, V3.H[0x7]
    FMLA S30, S31, V31.S[0x1]
    FMULX  V26.4H, V30.4H, V30.4H
    FNEG  V17.2D, V26.2D
    FMLS V30.2D, V28.2D, V17.D[0x1]
    FACGT  V26.4H, V21.4H, V27.4H
    FMUL V28.2D, V14.2D, V2.D[0x1]
    FMLS V29.4S, V29.4S, V27.S[0x2]
    FADD  V23.8H, V25.8H, V8.8H
    FMLS  V8.2S, V14.2S, V25.2S
    FABS  V2.4H, V18.4H
    FMUL  V17.4S, V28.4S, V15.4S
    FRECPE  V21.8H, V30.8H
    FMLS V14.2D, V12.2D, V12.D[0x0]
    FRECPS  V30.4H, V1.4H, V0.4H
    FSUB  V27.8H, V17.8H, V29.8H
    FACGT  V1.4H, V2.4H, V2.4H
    FMLS V12.8H, V31.8H, V6.H[0x7]
    FMLA H29, H27, V8.H[0x2]
    FDIV  V17.4H, V14.4H, V9.4H
    FMLA V5.2D, V1.2D, V21.D[0x1]
    FRECPS  V9.4S, V12.4S, V23.4S
    FABS  V12.2D, V9.2D
    FABD  V0.8H, V30.8H, V26.8H
    FADDP H22, V17.2H
    FADD  V2.8H, V0.8H, V29.8H
    FMLS S15, S22, V2.S[0x2]
    FMLA  V6.8H, V15.8H, V15.8H
    FRSQRTS  V0.8H, V5.8H, V12.8H
    FMLA  V19.4H, V18.4H, V0.4H
    FMLS  V12.8H, V19.8H, V19.8H
    FADDP S27, V12.2S
    FRSQRTE  V25.4H, V27.4H
    FRSQRTS  V29.4H, V25.4H, V25.4H
    FACGE  V28.4H, V29.4H, V6.4H
    FADD  V9.8H, V0.8H, V1.8H
    FRECPE  V17.4S, V15.4S
    FMLA D1, D27, V17.D[0x1]
    FACGE  V18.2S, V30.2S, V5.2S
    FMLS V2.2D, V1.2D, V30.D[0x1]
    FACGT  V29.4H, V19.4H, V16.4H
    FSUB  V25.4H, V29.4H, V15.4H
    FNEG  V16.4S, V21.4S
    FMULX H5, H9, V13.H[0x4]
    FMUL H30, H28, V10.H[0x3]
    FMUL D15, D13, V22.D[0x0]
    FMLS V29.4S, V13.4S, V16.S[0x3]
    FADD  V27.4H, V6.4H, V30.4H
    FABS  V0.8H, V9.8H
    FMULX S22, S7, V16.S[0x1]
    FRSQRTE  V7.2D, V18.2D
    FMLS H18, H27, V0.H[0x1]
    FADD  V13.2S, V7.2S, V2.2S
    FNEG  V9.2D, V18.2D
    FSQRT  V1.4H, V15.4H
    FMLA D17, D14, V13.D[0x0]
    FMULX S2, S29, V9.S[0x0]
    FADDP  V13.8H, V5.8H, V22.8H
    FMUL D21, D18, V13.D[0x1]
    FACGE  V18.2D, V25.2D, V25.2D
    FNEG  V14.4S, V18.4S
    FMLS V12.4S, V21.4S, V17.S[0x2]
    FMLA D19, D2, V2.D[0x1]
    FMLS V7.2D, V1.2D, V1.D[0x0]
    FMLS H22, H19, V12.H[0x4]
    FADD  V13.4S, V14.4S, V14.4S
    FACGE  V28.2S, V13.2S, V22.2S
    FMLS D22, D7, V7.D[0x0]
    FMLS V2.2S, V28.2S, V22.S[0x0]
    FRECPE  V16.2D, V31.2D
    FSUB  V17.2D, V19.2D, V16.2D
    FDIV  V29.4H, V24.4H, V5.4H
    FSQRT  V19.2S, V18.2S
    FMLS V13.4S, V2.4S, V29.S[0x3]
    FADD  V25.2S, V0.2S, V19.2S
    FMUL S21, S4, V8.S[0x1]
    FSQRT  V28.4S, V6.4S
    FABD  V7.2D, V15.2D, V23.2D
    FRECPS  V9.8H, V12.8H, V8.8H
    FACGE  V0.4S, V18.4S, V29.4S
    FRECPE  V14.2D, V12.2D
    FMLS V1.2D, V13.2D, V0.D[0x0]
    FMOV  V18.2D, #-1.50000000
    FACGE  V2.8H, V25.8H, V7.8H
    FSUB  V23.4H, V1.4H, V2.4H
    FMLS S17, S14, V28.S[0x3]
    FSQRT  V13.2D, V9.2D
    FRSQRTE  V22.2D, V11.2D
    FMLA S11, S23, V18.S[0x2]
    FMULX D16, D22, V11.D[0x0]
    FMLS V31.4S, V16.4S, V21.S[0x1]
    FMUL V8.8H, V31.8H, V15.H[0x0]
    FMUL  V0.4H, V17.4H, V13.4H
    FMUL H6, H19, V8.H[0x6]
    FMLS V31.2S, V28.2S, V7.S[0x3]
    FMULX S9, S18, V31.S[0x3]
    FADDP S18, V0.2S
    FADDP  V29.2D, V6.2D, V18.2D
    FDIV  V15.4S, V29.4S, V16.4S
    FMULX V19.4H, V15.4H, V15.H[0x4]
    FMOV  V14.8H, #2.75000000
    FMLS V8.4H, V14.4H, V14.H[0x0]
    FMLA V12.2S, V19.2S, V9.S[0x1]
    FMLA V13.2D, V8.2D, V12.D[0x1]
    FMLS V29.8H, V6.8H, V3.H[0x3]
    FDIV  V31.2S, V0.2S, V23.2S
    FMLA S9, S15, V2.S[0x2]
    FMLA V28.2S, V5.2S, V1.S[0x0]
    FMUL V25.8H, V2.8H, V2.H[0x4]
    FMUL  V22.2S, V16.2S, V10.2S
    FRSQRTE  V0.8H, V15.8H
    FMLS D11, D12, V28.D[0x0]
    FMOV  V5.2D, #4.00000000
    FMULX V2.2D, V21.2D, V5.D[0x1]
    FMULX V7.4S, V9.4S, V13.S[0x1]
    FNEG  V5.2S, V7.2S
    FMULX V8.2D, V13.2D, V29.D[0x1]
    FRSQRTS  V12.8H, V22.8H, V8.8H
    FMUL V16.4H, V0.4H, V12.H[0x0]
    FMULX H10, H25, V14.H[0x3]
    FMLA  V18.4S, V5.4S, V16.4S
    FRSQRTS  V7.4H, V18.4H, V18.4H
    FMLS H14, H2, V10.H[0x1]
    FRSQRTE  V25.8H, V31.8H
    FMULX V28.4H, V11.4H, V11.H[0x1]
    FSUB  V19.2D, V7.2D, V28.2D
    FMLS H31, H19, V9.H[0x6]
    FNEG  V5.4H, V14.4H
    FMLS V15.2D, V31.2D, V31.D[0x0]
    FMULX  V11.4S, V15.4S, V15.4S
    FACGT  V14.4H, V25.4H, V25.4H
    FMOV  V31.4H, #24.00000000
    FMLA S28, S15, V31.S[0x2]
    FMULX V8.8H, V28.8H, V5.H[0x7]
    FADD  V31.8H, V8.8H, V14.8H
    FMLA H25, H11, V11.H[0x3]
    FMUL H21, H31, V1.H[0x4]
    FMULX D22, D25, V25.D[0x1]
    FMLS D12, D21, V21.D[0x0]
    FDIV  V28.8H, V22.8H, V22.8H
    FADDP D14, V12.2D
    FADDP  V31.8H, V28.8H, V14.8H
    FMLA H15, H7, V9.H[0x7]
    FMUL V5.4H, V17.4H, V10.H[0x4]
    FMLA S25, S18, V24.S[0x1]
    FMLS V19.4H, V29.4H, V5.H[0x5]
    FMLA  V9.2D, V16.2D, V0.2D
    FMUL  V29.4H, V17.4H, V10.4H
    FMLA D21, D7, V3.D[0x1]
    FRECPE  V5.2D, V1.2D
    FNEG  V2.4H, V16.4H
    FMULX V22.4S, V9.4S, V25.S[0x0]
    FMULX V28.2D, V23.2D, V22.D[0x1]
    FDIV  V11.4H, V5.4H, V5.4H
    FRSQRTE  V1.8H, V28.8H
    FDIV  V17.8H, V29.8H, V2.8H
    FMLS V7.2S, V15.2S, V1.S[0x3]
    FDIV  V24.4S, V21.4S, V17.4S
    FMLA V22.2D, V19.2D, V19.D[0x1]
    FMOV  V3.4S, #-0.15625000
    FACGE  V10.4H, V24.4H, V7.4H
    FMOV  V12.2D, #0.22656250
    FRSQRTE  V25.4H, V12.4H
    FMULX V16.2S, V25.2S, V11.S[0x1]
    FMOV  V14.8H, #-0.46875000
    FACGT  V29.2D, V14.2D, V14.2D
    FACGE  V14.8H, V10.8H, V22.8H
    FRSQRTE  V18.8H, V3.8H
    FRSQRTE  V1.4H, V29.4H
    FMULX V15.8H, V31.8H, V14.H[0x7]
    FACGE  V0.4S, V18.4S, V16.4S
    FRSQRTE  V23.8H, V15.8H
    FRSQRTE  V9.2D, V1.2D
    FACGE  V25.2D, V0.2D, V0.2D
    FMLS  V22.8H, V23.8H, V25.8H
    FSUB  V31.2S, V22.2S, V22.2S
    FRECPE  V24.2D, V31.2D
    FMLA V17.2D, V9.2D, V24.D[0x0]
    FMLS  V11.8H, V31.8H, V26.8H
    FNEG  V5.4H, V16.4H
    FACGT  V25.4H, V26.4H, V25.4H
    FADD  V18.2D, V13.2D, V22.2D
    FMULX V13.2D, V23.2D, V21.D[0x1]
    FMOV  V15.2S, #-0.81250000
    FRSQRTS  V3.8H, V9.8H, V18.8H
    FADDP  V10.2S, V13.2S, V9.2S
    FADDP S29, V11.2S
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_2
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x1f, LSL #0
    MRS  X3, FPSR
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X3, V0.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X3, D0
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7c00, LSL #0
    MOVK  X12, #0x7c00, LSL #16
    MOVK  X12, #0x7c00, LSL #32
    MOVK  X12, #0x7c00, LSL #48
    FMOV  X3, D1
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xfc00, LSL #0
    MOVK  X12, #0xfc00, LSL #16
    MOVK  X12, #0xfc00, LSL #32
    MOVK  X12, #0xfe00, LSL #48
    FMOV  X3, D2
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    FMOV  X3, V3.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    FMOV  X3, D3
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X3, V4.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X3, D4
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x8000, LSL #0
    MOVK  X12, #0xff80, LSL #16
    MOVK  X12, #0xb58b, LSL #32
    MOVK  X12, #0xf83d, LSL #48
    FMOV  X3, D5
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x3e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x3e00, LSL #32
    MOVK  X12, #0x3e00, LSL #48
    FMOV  X3, D7
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x4000, LSL #0
    MOVK  X12, #0x4000, LSL #16
    FMOV  X3, D8
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff0, LSL #48
    FMOV  X3, V9.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5000, LSL #32
    MOVK  X12, #0x21e6, LSL #48
    FMOV  X3, D9
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5000, LSL #32
    MOVK  X12, #0x21e6, LSL #48
    FMOV  X3, D10
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    FMOV  X3, D11
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x3fcd, LSL #48
    FMOV  X3, V12.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x3fcd, LSL #48
    FMOV  X3, D12
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #32
    FMOV  X3, V14.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #32
    FMOV  X3, D14
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xbf50, LSL #16
    MOVK  X12, #0xbf50, LSL #48
    FMOV  X3, D15
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7f80, LSL #16
    MOVK  X12, #0x358b, LSL #32
    MOVK  X12, #0x783d, LSL #48
    FMOV  X3, D16
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff0, LSL #48
    FMOV  X3, V17.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff0, LSL #48
    FMOV  X3, D17
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e01, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    FMOV  X3, V18.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e01, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    FMOV  X3, D18
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    FMOV  X3, D19
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X3, V20.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X3, D20
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x43b1, LSL #0
    MOVK  X12, #0x41c9, LSL #16
    MOVK  X12, #0xbde9, LSL #32
    MOVK  X12, #0x7c10, LSL #48
    FMOV  X3, D21
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    FMOV  X3, V22.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    FMOV  X3, D22
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7c00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7c00, LSL #32
    MOVK  X12, #0x7c00, LSL #48
    FMOV  X3, V23.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e00, LSL #16
    MOVK  X12, #0x7e00, LSL #32
    MOVK  X12, #0x7e00, LSL #48
    FMOV  X3, D23
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff0, LSL #48
    FMOV  X3, V24.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff0, LSL #48
    FMOV  X3, D24
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D25
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #32
    FMOV  X3, D26
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x42b0, LSL #16
    FMOV  X3, D27
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xfb82, LSL #16
    MOVK  X12, #0x8000, LSL #32
    MOVK  X12, #0x3f8f, LSL #48
    FMOV  X3, D28
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    MOVK  X12, #0x7e80, LSL #16
    FMOV  X3, D29
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D30
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X3, D31
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0xbe94, LSL #0
    MOVK  X2, #0xa3e3, LSL #16
    MOVK  X2, #0x74a5, LSL #32
    MOVK  X2, #0xad82, LSL #48
    MOVZ  X3, #0x9b64, LSL #0
    MOVK  X3, #0xea79, LSL #16
    MOVK  X3, #0x49fc, LSL #32
    MOVK  X3, #0x9f77, LSL #48
    MOVZ  X4, #0x7964, LSL #0
    MOVK  X4, #0x767, LSL #16
    MOVK  X4, #0x68a9, LSL #32
    MOVK  X4, #0x56c9, LSL #48
    MOVZ  X5, #0x7641, LSL #0
    MOVK  X5, #0x542e, LSL #16
    MOVK  X5, #0x378, LSL #32
    MOVK  X5, #0x8baa, LSL #48
    MOVZ  X6, #0x3756, LSL #0
    MOVK  X6, #0x28ff, LSL #16
    MOVK  X6, #0x9d8c, LSL #32
    MOVK  X6, #0x31b9, LSL #48
    MOVZ  X7, #0x2cd3, LSL #0
    MOVK  X7, #0x8662, LSL #16
    MOVK  X7, #0xd44d, LSL #32
    MOVK  X7, #0x4c5f, LSL #48
    MOVZ  X8, #0xf488, LSL #0
    MOVK  X8, #0x8024, LSL #16
    MOVK  X8, #0x1958, LSL #32
    MOVK  X8, #0x7d0e, LSL #48
    MOVZ  X10, #0x6963, LSL #0
    MOVK  X10, #0x2a39, LSL #16
    MOVK  X10, #0x9363, LSL #32
    MOVK  X10, #0xedef, LSL #48
    MOVZ  X11, #0x83d7, LSL #0
    MOVK  X11, #0x9ad0, LSL #16
    MOVK  X11, #0x3328, LSL #32
    MOVK  X11, #0xbd5d, LSL #48
    MOVZ  X12, #0x6886, LSL #0
    MOVK  X12, #0x7b3d, LSL #16
    MOVK  X12, #0x27f8, LSL #32
    MOVK  X12, #0x114, LSL #48
    MOVZ  X13, #0xa390, LSL #0
    MOVK  X13, #0xe8c0, LSL #16
    MOVK  X13, #0x7509, LSL #32
    MOVK  X13, #0xce59, LSL #48
    MOVZ  X14, #0xcf70, LSL #0
    MOVK  X14, #0xf612, LSL #16
    MOVK  X14, #0x6574, LSL #32
    MOVK  X14, #0x8b66, LSL #48
    MOVZ  X15, #0xe5d3, LSL #0
    MOVK  X15, #0x2331, LSL #16
    MOVK  X15, #0xd4d1, LSL #32
    MOVK  X15, #0xf92c, LSL #48
    MOVZ  X16, #0x1aff, LSL #0
    MOVK  X16, #0x411f, LSL #16
    MOVK  X16, #0xecba, LSL #32
    MOVK  X16, #0xeda2, LSL #48
    MOVZ  X17, #0x7a31, LSL #0
    MOVK  X17, #0x101b, LSL #16
    MOVK  X17, #0x15b1, LSL #32
    MOVK  X17, #0x3390, LSL #48
    MOVZ  X18, #0x53c6, LSL #0
    MOVK  X18, #0xa262, LSL #16
    MOVK  X18, #0xf3fc, LSL #32
    MOVK  X18, #0xc47, LSL #48
    MOVZ  X20, #0xc361, LSL #0
    MOVK  X20, #0xc902, LSL #16
    MOVK  X20, #0x2917, LSL #32
    MOVK  X20, #0xcdaa, LSL #48
    MOVZ  X21, #0xb6f5, LSL #0
    MOVK  X21, #0xa21c, LSL #16
    MOVK  X21, #0x69e0, LSL #32
    MOVK  X21, #0x4ed4, LSL #48
    MOVZ  X22, #0x1dc7, LSL #0
    MOVK  X22, #0x77b3, LSL #16
    MOVK  X22, #0xcbdd, LSL #32
    MOVK  X22, #0xb552, LSL #48
    MOVZ  X23, #0x823b, LSL #0
    MOVK  X23, #0x1202, LSL #16
    MOVK  X23, #0x797b, LSL #32
    MOVK  X23, #0xdb96, LSL #48
    MOVZ  X24, #0xcd07, LSL #0
    MOVK  X24, #0x663d, LSL #16
    MOVK  X24, #0xecb4, LSL #32
    MOVK  X24, #0x3484, LSL #48
    MOVZ  X25, #0xbf18, LSL #0
    MOVK  X25, #0x18c6, LSL #16
    MOVK  X25, #0x60e0, LSL #32
    MOVK  X25, #0x6f25, LSL #48
    MOVZ  X27, #0xde29, LSL #0
    MOVK  X27, #0x1da4, LSL #16
    MOVK  X27, #0x2696, LSL #32
    MOVK  X27, #0x432d, LSL #48
    MOVZ  X28, #0x2bd4, LSL #0
    MOVK  X28, #0x1aba, LSL #16
    MOVK  X28, #0x9640, LSL #32
    MOVK  X28, #0xdc83, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X22
    FMOV  D3, X15
    FMOV  V3.D[1], X20
    FMOV  D4, X16
    FMOV  V4.D[1], X5
    FMOV  D5, X8
    FMOV  V5.D[1], X8
    FMOV  D6, X8
    FMOV  V6.D[1], X8
    FMOV  D7, X4
    FMOV  V7.D[1], X6
    FMOV  D8, X13
    FMOV  V8.D[1], X20
    FMOV  D9, X28
    FMOV  V9.D[1], X14
    FMOV  D10, X10
    FMOV  V10.D[1], X23
    FMOV  D11, X22
    FMOV  V11.D[1], X14
    FMOV  D12, X8
    FMOV  V12.D[1], X16
    FMOV  D13, X22
    FMOV  V13.D[1], X27
    FMOV  D14, X5
    FMOV  V14.D[1], X11
    FMOV  D15, X2
    FMOV  V15.D[1], X13
    FMOV  D16, X23
    FMOV  V16.D[1], X18
    FMOV  D17, X22
    FMOV  V17.D[1], X17
    FMOV  D18, X17
    FMOV  V18.D[1], X3
    FMOV  D19, X24
    FMOV  V19.D[1], X18
    FMOV  D20, X23
    FMOV  V20.D[1], X25
    FMOV  D21, X3
    FMOV  V21.D[1], X23
    FMOV  D22, X3
    FMOV  V22.D[1], X2
    FMOV  D23, X2
    FMOV  V23.D[1], X8
    FMOV  D24, X25
    FMOV  V24.D[1], X23
    FMOV  D25, X2
    FMOV  V25.D[1], X10
    FMOV  D26, X11
    FMOV  V26.D[1], X4
    FMOV  D27, X3
    FMOV  V27.D[1], X23
    FMOV  D28, X23
    FMOV  V28.D[1], X7
    FMOV  D29, X25
    FMOV  V29.D[1], X3
    FMOV  D30, X11
    FMOV  V30.D[1], X20
    FMOV  D31, X11
    FMOV  V31.D[1], X13
    MOVZ  X4, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_3:
    FMULX D9, D31, V31.D[0x1]
    FABD  V6.8H, V23.8H, V24.8H
    FRECPS  V8.4S, V25.4S, V28.4S
    FMUL V24.2D, V30.2D, V30.D[0x0]
    FMLS V11.4S, V8.4S, V6.S[0x1]
    FMUL V17.4H, V9.4H, V11.H[0x4]
    FMLA V7.2D, V27.2D, V29.D[0x0]
    FMLA V8.2D, V26.2D, V17.D[0x1]
    FRSQRTE  V24.2D, V24.2D
    FMLA V21.8H, V7.8H, V8.H[0x5]
    FMLS  V4.2D, V21.2D, V24.2D
    FMOV  V26.2D, #-0.39062500
    FRECPE  V23.8H, V26.8H
    FSQRT  V21.2S, V23.2S
    FMLS D26, D4, V4.D[0x1]
    FMULX D4, D26, V26.D[0x0]
    FNEG  V26.2S, V21.2S
    FMULX S24, S10, V4.S[0x0]
    FMLS V11.2D, V26.2D, V26.D[0x1]
    FRSQRTS  V25.2S, V15.2S, V11.2S
    FADD  V31.8H, V25.8H, V25.8H
    FMULX V25.4H, V24.4H, V9.H[0x4]
    FADD  V28.8H, V25.8H, V9.8H
    FMLS V30.2S, V31.2S, V31.S[0x3]
    FMLS D7, D28, V30.D[0x0]
    FMUL S9, S24, V17.S[0x0]
    FRECPE  V27.4H, V10.4H
    FMLS  V24.4H, V9.4H, V13.4H
    FADDP  V9.4S, V7.4S, V23.4S
    FMUL D23, D5, V31.D[0x1]
    FACGT  V5.4S, V21.4S, V26.4S
    FMOV  V8.2S, #2.75000000
    FRECPS  V30.8H, V4.8H, V24.8H
    FACGE  V4.4H, V22.4H, V30.4H
    FMLS D24, D9, V12.D[0x0]
    FACGE  V13.2S, V10.2S, V3.2S
    FMUL H29, H6, V6.H[0x7]
    FMLS V6.2D, V11.2D, V5.D[0x0]
    FMLA H26, H15, V6.H[0x6]
    FMLS V30.8H, V14.8H, V8.H[0x0]
    FMLA V8.2D, V0.2D, V8.D[0x1]
    FADDP D14, V4.2D
    FMLA D25, D24, V23.D[0x0]
    FMUL  V17.2D, V14.2D, V8.2D
    FRSQRTS  V15.2D, V30.2D, V27.2D
    FMULX V7.4S, V17.4S, V15.S[0x1]
    FMLA  V22.4H, V7.4H, V24.4H
    FMLA V28.2D, V13.2D, V22.D[0x1]
    FRSQRTS  V13.2S, V0.2S, V28.2S
    FADDP H31, V29.2H
    FRECPE  V11.8H, V26.8H
    FMLS V4.4S, V13.4S, V25.S[0x3]
    FRECPE  V27.2D, V4.2D
    FMLA  V6.4S, V27.4S, V31.4S
    FACGT  V17.4S, V3.4S, V11.4S
    FMOV  V30.4S, #0.39062500
    FMULX  V25.2D, V6.2D, V30.2D
    FDIV  V23.4S, V19.4S, V19.4S
    FMULX H4, H17, V5.H[0x5]
    FMULX D8, D4, V4.D[0x1]
    FADDP  V28.4S, V8.4S, V2.4S
    FRECPE  V14.4S, V25.4S
    FRSQRTS  V31.4H, V23.4H, V23.4H
    FMOV  V25.2D, #-3.87500000
    FRSQRTE  V24.8H, V14.8H
    FMLS V27.2D, V24.2D, V28.D[0x0]
    FMULX  V15.2S, V31.2S, V27.2S
    FRECPS  V29.4S, V25.4S, V25.4S
    FMUL V22.8H, V9.8H, V15.H[0x1]
    FMUL V26.2D, V29.2D, V30.D[0x0]
    FACGE  V3.8H, V22.8H, V26.8H
    FRSQRTE  V2.2S, V7.2S
    FMOV  V7.4S, #0.96875000
    FMLA V28.8H, V6.8H, V13.H[0x1]
    FNEG  V13.4H, V15.4H
    FMLA V26.2D, V4.2D, V12.D[0x0]
    FRECPS  V4.4H, V7.4H, V30.4H
    FMLS D0, D3, V25.D[0x1]
    FRSQRTE  V23.8H, V25.8H
    FABD  V9.2D, V14.2D, V12.2D
    FABD  V25.4H, V27.4H, V14.4H
    FADD  V29.8H, V4.8H, V25.8H
    FDIV  V22.8H, V2.8H, V29.8H
    FMUL S3, S22, V28.S[0x1]
    FMULX V2.2S, V26.2S, V3.S[0x3]
    FMUL  V3.4H, V0.4H, V13.4H
    FACGE  V31.2D, V15.2D, V9.2D
    FMLA V6.8H, V31.8H, V2.H[0x7]
    FMLS V30.2S, V6.2S, V6.S[0x1]
    FMLA S12, S23, V30.S[0x3]
    FMLA H9, H12, V3.H[0x3]
    FABS  V31.4H, V24.4H
    FMLS V14.4S, V8.4S, V26.S[0x0]
    FMLA V21.4S, V29.4S, V17.S[0x2]
    FMUL V27.4S, V29.4S, V29.S[0x1]
    FMOV  V4.8H, #-0.45312500
    FMOV  V12.2S, #1.62500000
    FMLS H30, H25, V8.H[0x3]
    FRSQRTS  V24.4H, V23.4H, V16.4H
    FMUL V8.2D, V30.2D, V24.D[0x1]
    FMUL D29, D9, V9.D[0x1]
    FMLA V23.4S, V14.4S, V31.S[0x1]
    FMLA V30.4S, V4.4S, V21.S[0x2]
    FMUL V6.2D, V13.2D, V23.D[0x0]
    FMLA  V24.8H, V6.8H, V29.8H
    FMLS  V3.4S, V12.4S, V12.4S
    FABS  V15.2S, V27.2S
    FNEG  V26.2S, V3.2S
    FABD  V4.8H, V26.8H, V24.8H
    FMLA  V21.4H, V8.4H, V15.4H
    FMOV  V25.8H, #-1.50000000
    FMUL  V29.2D, V25.2D, V25.2D
    FMLS V15.2S, V29.2S, V29.S[0x0]
    FMLS  V26.8H, V30.8H, V15.8H
    FMUL V3.4H, V26.4H, V4.H[0x0]
    FRSQRTS  V24.8H, V3.8H, V21.8H
    FACGT  V14.4S, V5.4S, V25.4S
    FADDP S9, V30.2S
    FMLS V27.2S, V14.2S, V17.S[0x0]
    FMUL S15, S19, V1.S[0x0]
    FRECPS  V21.4H, V29.4H, V7.4H
    FACGT  V4.2D, V31.2D, V3.2D
    FADDP  V31.4H, V0.4H, V19.4H
    FMOV  V0.2D, #-1.62500000
    FMULX S8, S17, V2.S[0x1]
    FMLA  V2.2D, V15.2D, V24.2D
    FRSQRTE  V26.4S, V9.4S
    FMLA  V5.2S, V2.2S, V27.2S
    FMUL V24.2D, V21.2D, V28.D[0x0]
    FMULX V23.4S, V31.4S, V4.S[0x0]
    FMLS V9.2S, V23.2S, V26.S[0x3]
    FSUB  V21.8H, V5.8H, V5.8H
    FMLA V30.2D, V0.2D, V21.D[0x0]
    FMULX V3.2S, V30.2S, V24.S[0x1]
    FSQRT  V15.2S, V8.2S
    FMULX  V5.4H, V15.4H, V15.4H
    FRSQRTE  V2.2D, V9.2D
    FNEG  V25.4H, V3.4H
    FRSQRTE  V23.8H, V2.8H
    FRSQRTS  V26.4H, V23.4H, V23.4H
    FMULX  V2.2S, V25.2S, V25.2S
    FSQRT  V9.4H, V4.4H
    FMULX V3.2D, V5.2D, V9.D[0x1]
    FMULX S31, S3, V3.S[0x0]
    FRSQRTE  V23.8H, V26.8H
    FADDP H28, V31.2H
    FMLS D25, D28, V28.D[0x1]
    FDIV  V7.2D, V2.2D, V23.2D
    FABS  V8.2D, V7.2D
    FABD  V28.8H, V8.8H, V25.8H
    FABS  V3.2S, V27.2S
    FRSQRTS  V26.4S, V29.4S, V21.4S
    FACGE  V9.2D, V6.2D, V16.2D
    FMLS S4, S23, V29.S[0x2]
    FABS  V5.8H, V1.8H
    FRECPE  V2.2S, V3.2S
    FMLA D25, D21, V4.D[0x1]
    FMLS  V31.4S, V24.4S, V26.4S
    FMLS V3.2D, V5.2D, V7.D[0x0]
    FRECPE  V5.4H, V28.4H
    FMOV  V7.8H, #-17.00000000
    FABS  V28.4S, V9.4S
    FRSQRTE  V24.4H, V11.4H
    FMLA V1.8H, V9.8H, V2.H[0x5]
    FMULX V4.8H, V27.8H, V7.H[0x3]
    FRECPE  V6.4S, V7.4S
    FMULX D11, D25, V25.D[0x0]
    FMULX D22, D31, V11.D[0x0]
    FABD  V25.4S, V1.4S, V22.4S
    FMLS  V11.4S, V25.4S, V24.4S
    FSQRT  V26.2S, V5.2S
    FRSQRTE  V29.2D, V11.2D
    FABD  V21.4S, V3.4S, V3.4S
    FMLS V1.2S, V28.2S, V6.S[0x1]
    FMLS S23, S26, V26.S[0x3]
    FMULX V25.2S, V4.2S, V4.S[0x0]
    FMLA  V6.8H, V28.8H, V25.8H
    FMLA  V24.4H, V6.4H, V6.4H
    FNEG  V5.4H, V29.4H
    FADDP H16, V5.2H
    FDIV  V31.8H, V21.8H, V10.8H
    FSQRT  V26.4H, V24.4H
    FRSQRTE  V27.2S, V1.2S
    FABD  V29.2D, V31.2D, V16.2D
    FMUL V16.4H, V23.4H, V4.H[0x1]
    FMULX  V1.4S, V26.4S, V27.4S
    FSUB  V6.4H, V1.4H, V29.4H
    FMUL  V10.8H, V6.8H, V16.8H
    FSUB  V24.2D, V24.2D, V9.2D
    FMLA  V9.2S, V4.2S, V7.2S
    FMULX V29.8H, V30.8H, V14.H[0x7]
    FMULX H11, H27, V12.H[0x5]
    FADD  V14.4H, V8.4H, V22.4H
    FMLS H6, H31, V1.H[0x1]
    FMLA  V16.8H, V17.8H, V18.8H
    FMLS S3, S0, V27.S[0x1]
    FMLS S26, S16, V9.S[0x3]
    FSUB  V5.4H, V3.4H, V26.4H
    FMULX V1.4S, V29.4S, V14.S[0x2]
    FRECPE  V28.4S, V6.4S
    SUBS  X4, X4, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_3
    MOVZ  X3, #0xbe94, LSL #0
    MOVK  X3, #0xa3e3, LSL #16
    MOVK  X3, #0x74a5, LSL #32
    MOVK  X3, #0xad82, LSL #48
    SUB  X7, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7641, LSL #0
    MOVK  X3, #0x542e, LSL #16
    MOVK  X3, #0x378, LSL #32
    MOVK  X3, #0x8baa, LSL #48
    SUB  X7, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x3756, LSL #0
    MOVK  X3, #0x28ff, LSL #16
    MOVK  X3, #0x9d8c, LSL #32
    MOVK  X3, #0x31b9, LSL #48
    SUB  X7, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xf488, LSL #0
    MOVK  X3, #0x8024, LSL #16
    MOVK  X3, #0x1958, LSL #32
    MOVK  X3, #0x7d0e, LSL #48
    SUB  X7, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x6963, LSL #0
    MOVK  X3, #0x2a39, LSL #16
    MOVK  X3, #0x9363, LSL #32
    MOVK  X3, #0xedef, LSL #48
    SUB  X7, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x83d7, LSL #0
    MOVK  X3, #0x9ad0, LSL #16
    MOVK  X3, #0x3328, LSL #32
    MOVK  X3, #0xbd5d, LSL #48
    SUB  X7, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x6886, LSL #0
    MOVK  X3, #0x7b3d, LSL #16
    MOVK  X3, #0x27f8, LSL #32
    MOVK  X3, #0x114, LSL #48
    SUB  X7, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xa390, LSL #0
    MOVK  X3, #0xe8c0, LSL #16
    MOVK  X3, #0x7509, LSL #32
    MOVK  X3, #0xce59, LSL #48
    SUB  X7, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xcf70, LSL #0
    MOVK  X3, #0xf612, LSL #16
    MOVK  X3, #0x6574, LSL #32
    MOVK  X3, #0x8b66, LSL #48
    SUB  X7, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x1aff, LSL #0
    MOVK  X3, #0x411f, LSL #16
    MOVK  X3, #0xecba, LSL #32
    MOVK  X3, #0xeda2, LSL #48
    SUB  X7, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7a31, LSL #0
    MOVK  X3, #0x101b, LSL #16
    MOVK  X3, #0x15b1, LSL #32
    MOVK  X3, #0x3390, LSL #48
    SUB  X7, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x53c6, LSL #0
    MOVK  X3, #0xa262, LSL #16
    MOVK  X3, #0xf3fc, LSL #32
    MOVK  X3, #0xc47, LSL #48
    SUB  X7, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xc361, LSL #0
    MOVK  X3, #0xc902, LSL #16
    MOVK  X3, #0x2917, LSL #32
    MOVK  X3, #0xcdaa, LSL #48
    SUB  X7, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xb6f5, LSL #0
    MOVK  X3, #0xa21c, LSL #16
    MOVK  X3, #0x69e0, LSL #32
    MOVK  X3, #0x4ed4, LSL #48
    SUB  X7, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x1dc7, LSL #0
    MOVK  X3, #0x77b3, LSL #16
    MOVK  X3, #0xcbdd, LSL #32
    MOVK  X3, #0xb552, LSL #48
    SUB  X7, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x823b, LSL #0
    MOVK  X3, #0x1202, LSL #16
    MOVK  X3, #0x797b, LSL #32
    MOVK  X3, #0xdb96, LSL #48
    SUB  X7, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xcd07, LSL #0
    MOVK  X3, #0x663d, LSL #16
    MOVK  X3, #0xecb4, LSL #32
    MOVK  X3, #0x3484, LSL #48
    SUB  X7, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xbf18, LSL #0
    MOVK  X3, #0x18c6, LSL #16
    MOVK  X3, #0x60e0, LSL #32
    MOVK  X3, #0x6f25, LSL #48
    SUB  X7, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xde29, LSL #0
    MOVK  X3, #0x1da4, LSL #16
    MOVK  X3, #0x2696, LSL #32
    MOVK  X3, #0x432d, LSL #48
    SUB  X7, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x2bd4, LSL #0
    MOVK  X3, #0x1aba, LSL #16
    MOVK  X3, #0x9640, LSL #32
    MOVK  X3, #0xdc83, LSL #48
    SUB  X7, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x1f, LSL #0
    MRS  X7, FPSR
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xbffa, LSL #48
    FMOV  X7, V0.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xbffa, LSL #48
    FMOV  X7, D0
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, D1
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x4514, LSL #16
    MOVK  X3, #0x4514, LSL #48
    FMOV  X7, D2
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7fc0, LSL #16
    FMOV  X7, D3
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x8000, LSL #0
    MOVK  X3, #0x8000, LSL #16
    MOVK  X3, #0x8000, LSL #32
    MOVK  X3, #0x8000, LSL #48
    FMOV  X7, V4.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xf7ad, LSL #0
    MOVK  X3, #0xca3a, LSL #16
    MOVK  X3, #0x36cc, LSL #32
    MOVK  X3, #0xca3a, LSL #48
    FMOV  X7, D4
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    FMOV  X7, D5
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    FMOV  X7, D6
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xcc40, LSL #0
    MOVK  X3, #0xcc40, LSL #16
    MOVK  X3, #0xcc40, LSL #32
    MOVK  X3, #0xcc40, LSL #48
    FMOV  X7, V7.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xcc40, LSL #0
    MOVK  X3, #0xcc40, LSL #16
    MOVK  X3, #0xcc40, LSL #32
    MOVK  X3, #0xcc40, LSL #48
    FMOV  X7, D7
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x1, LSL #0
    FMOV  X7, D8
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7fc0, LSL #16
    MOVK  X3, #0x7fc0, LSL #48
    FMOV  X7, D9
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V10.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    MOVK  X3, #0x7e00, LSL #32
    MOVK  X3, #0x7e00, LSL #48
    FMOV  X7, D10
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V11.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, D11
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x3fd0, LSL #16
    MOVK  X3, #0x3fd0, LSL #48
    FMOV  X7, D12
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x8000, LSL #0
    MOVK  X3, #0x8000, LSL #32
    FMOV  X7, D13
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xef63, LSL #0
    MOVK  X3, #0x7924, LSL #16
    MOVK  X3, #0xe000, LSL #32
    MOVK  X3, #0xa9bf, LSL #48
    FMOV  X7, D14
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    FMOV  X7, D15
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    FMOV  X7, D16
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, D17
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x9b64, LSL #0
    MOVK  X3, #0xea79, LSL #16
    MOVK  X3, #0x49fc, LSL #32
    MOVK  X3, #0x9f77, LSL #48
    FMOV  X7, V18.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7a31, LSL #0
    MOVK  X3, #0x101b, LSL #16
    MOVK  X3, #0x15b1, LSL #32
    MOVK  X3, #0x3390, LSL #48
    FMOV  X7, D18
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x53c6, LSL #0
    MOVK  X3, #0xa262, LSL #16
    MOVK  X3, #0xf3fc, LSL #32
    MOVK  X3, #0xc47, LSL #48
    FMOV  X7, V19.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xcd07, LSL #0
    MOVK  X3, #0x663d, LSL #16
    MOVK  X3, #0xecb4, LSL #32
    MOVK  X3, #0x3484, LSL #48
    FMOV  X7, D19
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xbf18, LSL #0
    MOVK  X3, #0x18c6, LSL #16
    MOVK  X3, #0x60e0, LSL #32
    MOVK  X3, #0x6f25, LSL #48
    FMOV  X7, V20.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x823b, LSL #0
    MOVK  X3, #0x1202, LSL #16
    MOVK  X3, #0x797b, LSL #32
    MOVK  X3, #0xdb96, LSL #48
    FMOV  X7, D20
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, D21
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0xef64, LSL #0
    MOVK  X3, #0x7924, LSL #16
    MOVK  X3, #0xe000, LSL #32
    MOVK  X3, #0xa9bf, LSL #48
    FMOV  X7, D22
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    FMOV  X7, D23
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff8, LSL #48
    FMOV  X7, V24.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff8, LSL #48
    FMOV  X7, D24
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x8cd8, LSL #0
    MOVK  X3, #0x5508, LSL #16
    MOVK  X3, #0xfff9, LSL #32
    MOVK  X3, #0x5507, LSL #48
    FMOV  X7, D25
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    FMOV  X7, D26
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7fc0, LSL #16
    MOVK  X3, #0x7fc0, LSL #48
    FMOV  X7, D27
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7f80, LSL #16
    MOVK  X3, #0x7f80, LSL #48
    FMOV  X7, V28.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7f80, LSL #16
    MOVK  X3, #0x7f80, LSL #48
    FMOV  X7, D28
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    FMOV  X7, D29
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    FMOV  X7, D30
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    MOVK  X3, #0x7e00, LSL #32
    MOVK  X3, #0x7e00, LSL #48
    FMOV  X7, V31.D[1]
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    MOVK  X3, #0x7e00, LSL #16
    MOVK  X3, #0x7e00, LSL #32
    MOVK  X3, #0x7e00, LSL #48
    FMOV  X7, D31
    SUB  X15, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X21
    FMOV  V0.D[1], X28
    FMOV  D1, X8
    FMOV  V1.D[1], X15
    FMOV  D2, X12
    FMOV  V2.D[1], X24
    FMOV  D3, X23
    FMOV  V3.D[1], X17
    FMOV  D4, X7
    FMOV  V4.D[1], X11
    FMOV  D5, X18
    FMOV  V5.D[1], X27
    FMOV  D6, X20
    FMOV  V6.D[1], X22
    FMOV  D7, X25
    FMOV  V7.D[1], X4
    FMOV  D8, X13
    FMOV  V8.D[1], X22
    FMOV  D9, X17
    FMOV  V9.D[1], X16
    FMOV  D10, X10
    FMOV  V10.D[1], X12
    FMOV  D11, X4
    FMOV  V11.D[1], X28
    FMOV  D12, X22
    FMOV  V12.D[1], X22
    FMOV  D13, X14
    FMOV  V13.D[1], X13
    FMOV  D14, X16
    FMOV  V14.D[1], X14
    FMOV  D15, X17
    FMOV  V15.D[1], X28
    FMOV  D16, X20
    FMOV  V16.D[1], X8
    FMOV  D17, X28
    FMOV  V17.D[1], X27
    FMOV  D18, X18
    FMOV  V18.D[1], X27
    FMOV  D19, X25
    FMOV  V19.D[1], X28
    FMOV  D20, X27
    FMOV  V20.D[1], X7
    FMOV  D21, X25
    FMOV  V21.D[1], X16
    FMOV  D22, X25
    FMOV  V22.D[1], X27
    FMOV  D23, X15
    FMOV  V23.D[1], X7
    FMOV  D24, X28
    FMOV  V24.D[1], X8
    FMOV  D25, X2
    FMOV  V25.D[1], X15
    FMOV  D26, X7
    FMOV  V26.D[1], X17
    FMOV  D27, X17
    FMOV  V27.D[1], X3
    FMOV  D28, X27
    FMOV  V28.D[1], X21
    FMOV  D29, X15
    FMOV  V29.D[1], X24
    FMOV  D30, X3
    FMOV  V30.D[1], X6
    FMOV  D31, X11
    FMOV  V31.D[1], X13
    MOVZ  X22, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_4:
    FMUL H5, H28, V8.H[0x5]
    FMOV  V27.8H, #-0.28125000
    FMLS V14.2D, V23.2D, V23.D[0x0]
    FSQRT  V0.4H, V5.4H
    FADDP S10, V26.2S
    FMULX V6.2D, V31.2D, V14.D[0x1]
    FMULX S16, S21, V6.S[0x1]
    FRSQRTE  V19.2S, V16.2S
    FRSQRTS  V7.2S, V30.2S, V27.2S
    FMLA V12.4H, V0.4H, V0.H[0x7]
    FMLS  V7.4S, V29.4S, V22.4S
    FRSQRTE  V26.4S, V10.4S
    FACGE  V5.8H, V26.8H, V26.8H
    FRSQRTE  V31.8H, V19.8H
    FMLS V23.2D, V5.2D, V31.D[0x1]
    FDIV  V16.4H, V12.4H, V23.4H
    FRSQRTS  V14.4H, V7.4H, V7.4H
    FMLS D23, D16, V14.D[0x1]
    FRECPE  V15.4S, V23.4S
    FMLA  V21.8H, V9.8H, V13.8H
    FSQRT  V13.4S, V23.4S
    FMLS  V10.2D, V28.2D, V1.2D
    FRSQRTS  V16.4H, V30.4H, V14.4H
    FADDP  V22.4H, V5.4H, V6.4H
    FMLS  V9.2S, V17.2S, V25.2S
    FNEG  V23.2D, V22.2D
    FRSQRTE  V28.8H, V15.8H
    FRSQRTE  V7.2S, V5.2S
    FMUL V22.8H, V30.8H, V11.H[0x6]
    FMLS H5, H21, V9.H[0x6]
    FMOV  V11.4H, #0.81250000
    FMULX  V12.2S, V22.2S, V23.2S
    FADDP  V0.8H, V10.8H, V12.8H
    FMLS  V10.2D, V16.2D, V5.2D
    FADDP  V12.2S, V0.2S, V6.2S
    FMULX S30, S13, V28.S[0x0]
    FRSQRTS  V25.8H, V30.8H, V12.8H
    FMUL V30.2S, V25.2S, V11.S[0x2]
    FACGE  V0.4H, V10.4H, V30.4H
    FNEG  V15.4H, V7.4H
    FMLS V13.4H, V15.4H, V0.H[0x4]
    FMLS D31, D25, V17.D[0x1]
    FMOV  V14.8H, #-2.00000000
    FMLS H19, H29, V7.H[0x7]
    FMLS V21.4H, V17.4H, V7.H[0x1]
    FMOV  V1.4S, #0.12500000
    FNEG  V23.2D, V28.2D
    FMOV  V22.8H, #-0.87500000
    FACGE  V0.2D, V27.2D, V1.2D
    FABS  V29.2D, V0.2D
    FRSQRTE  V11.4H, V4.4H
    FMLS H5, H11, V9.H[0x5]
    FMLA H22, H19, V14.H[0x2]
    FRSQRTE  V12.8H, V31.8H
    FMLA V11.2S, V5.2S, V13.S[0x3]
    FRECPS  V7.8H, V22.8H, V22.8H
    FDIV  V17.2S, V12.2S, V21.2S
    FABS  V6.4S, V17.4S
    FACGE  V31.2D, V23.2D, V25.2D
    FADD  V0.8H, V6.8H, V31.8H
    FRECPS  V27.2S, V7.2S, V7.2S
    FRECPE  V25.4H, V11.4H
    FADDP S12, V27.2S
    FMULX  V17.4H, V0.4H, V12.4H
    FSQRT  V4.8H, V29.8H
    FSQRT  V11.2S, V17.2S
    FACGE  V23.4H, V4.4H, V25.4H
    FABS  V25.4H, V23.4H
    FMLS S17, S11, V11.S[0x0]
    FABS  V9.4H, V25.4H
    FMLS V21.2S, V17.2S, V9.S[0x1]
    FMOV  V7.2D, #-5.50000000
    FMOV  V28.4S, #0.87500000
    FADDP D29, V27.2D
    FMULX V31.4S, V18.4S, V11.S[0x1]
    FMLA  V6.4H, V28.4H, V31.4H
    FNEG  V12.4S, V24.4S
    FMLS V28.2D, V26.2D, V17.D[0x0]
    FMLA S4, S17, V15.S[0x2]
    FRECPS  V11.2D, V24.2D, V13.2D
    FMLS H14, H6, V1.H[0x4]
    FMUL V24.2S, V9.2S, V23.S[0x1]
    FMUL V23.4S, V24.4S, V28.S[0x3]
    FSUB  V5.2D, V4.2D, V21.2D
    FMLS V4.4S, V29.4S, V23.S[0x2]
    FRSQRTE  V22.8H, V11.8H
    FADD  V9.8H, V5.8H, V4.8H
    FMUL V13.2D, V22.2D, V7.D[0x0]
    FSQRT  V31.4S, V9.4S
    FMLS V17.2D, V13.2D, V27.D[0x1]
    FMLS V11.2S, V12.2S, V31.S[0x2]
    FMULX H15, H11, V14.H[0x1]
    FMUL  V25.2S, V15.2S, V17.2S
    FMLA H18, H7, V4.H[0x4]
    FMULX D26, D4, V1.D[0x0]
    FABD  V27.2D, V21.2D, V29.2D
    FACGE  V1.4S, V12.4S, V22.4S
    FNEG  V14.8H, V18.8H
    FRSQRTS  V9.4S, V18.4S, V30.4S
    FRECPE  V13.4H, V29.4H
    FMLA V28.2S, V16.2S, V11.S[0x3]
    FRSQRTE  V6.2S, V23.2S
    FMUL S10, S13, V25.S[0x1]
    FMUL V22.4S, V27.4S, V26.S[0x0]
    FNEG  V31.2S, V6.2S
    FSQRT  V7.4H, V1.4H
    FMLA S16, S28, V28.S[0x0]
    FABS  V12.4H, V14.4H
    FMLA D6, D10, V31.D[0x0]
    FMULX H23, H9, V9.H[0x3]
    FABD  V1.2D, V23.2D, V7.2D
    FADDP  V7.8H, V12.8H, V1.8H
    FRSQRTS  V17.8H, V7.8H, V29.8H
    FRSQRTE  V25.2D, V16.2D
    FABS  V30.4S, V6.4S
    FMLS V16.2D, V30.2D, V17.D[0x0]
    FMLS V5.8H, V30.8H, V8.H[0x5]
    FRECPS  V27.4S, V25.4S, V16.4S
    FMLS H14, H27, V5.H[0x5]
    FMLA S12, S14, V22.S[0x2]
    FACGT  V29.4H, V19.4H, V20.4H
    FABS  V8.2S, V24.2S
    FADDP  V17.4H, V1.4H, V11.4H
    FSUB  V26.2D, V22.2D, V8.2D
    FADDP H7, V20.2H
    FMLA V22.4H, V22.4H, V11.H[0x1]
    FMULX D27, D12, V3.D[0x1]
    FADDP D31, V0.2D
    FRECPE  V19.4H, V14.4H
    FMLS D6, D19, V11.D[0x1]
    FMLS H30, H27, V0.H[0x1]
    FMULX H1, H2, V12.H[0x6]
    FADD  V16.4H, V29.4H, V31.4H
    FMOV  V25.2D, #-31.00000000
    FMLA V24.4H, V26.4H, V12.H[0x1]
    FABS  V12.2S, V24.2S
    FMLA V5.4H, V16.4H, V1.H[0x3]
    FADDP H10, V30.2H
    FMUL  V3.4S, V22.4S, V10.4S
    FABD  V2.2S, V6.2S, V7.2S
    FADDP H20, V17.2H
    FMLA D1, D20, V12.D[0x1]
    FMUL V12.4H, V25.4H, V7.H[0x6]
    FADD  V30.8H, V3.8H, V18.8H
    FMLS V11.4S, V12.4S, V2.S[0x2]
    FMLA  V22.2S, V5.2S, V2.2S
    FMUL  V26.2S, V22.2S, V22.2S
    FDIV  V5.2S, V30.2S, V1.2S
    FMULX S29, S26, V5.S[0x3]
    FMUL V7.2D, V29.2D, V7.D[0x0]
    FSUB  V22.2D, V7.2D, V10.2D
    FNEG  V31.8H, V7.8H
    FMULX V30.8H, V11.8H, V11.H[0x4]
    FADDP  V10.4H, V7.4H, V30.4H
    FMLA V11.8H, V31.8H, V10.H[0x5]
    FMOV  V20.2S, #1.25000000
    FMLA  V31.4H, V22.4H, V20.4H
    FDIV  V22.8H, V11.8H, V11.8H
    FMULX V11.2D, V31.2D, V22.D[0x0]
    FMLS V1.8H, V23.8H, V6.H[0x4]
    FMOV  V30.4S, #31.00000000
    FADDP D7, V13.2D
    FMLS V12.8H, V7.8H, V1.H[0x3]
    FNEG  V31.2S, V4.2S
    FMLS V10.4S, V0.4S, V29.S[0x0]
    FACGT  V29.8H, V30.8H, V19.8H
    FMULX H0, H26, V10.H[0x1]
    FMULX V1.4S, V20.4S, V26.S[0x0]
    FADD  V22.8H, V6.8H, V30.8H
    FABS  V23.4H, V8.4H
    FMLA  V8.4H, V13.4H, V7.4H
    FNEG  V13.4H, V22.4H
    FRSQRTE  V26.8H, V23.8H
    FACGT  V30.4S, V31.4S, V0.4S
    FMLS  V22.2S, V12.2S, V26.2S
    FADDP  V0.8H, V30.8H, V11.8H
    FRECPE  V26.2S, V1.2S
    FNEG  V20.2D, V13.2D
    FMLA S1, S22, V8.S[0x3]
    FRECPE  V6.4S, V26.4S
    FMULX  V11.8H, V7.8H, V1.8H
    FADD  V8.4H, V29.4H, V29.4H
    FMLA H23, H16, V9.H[0x6]
    FADD  V22.4S, V11.4S, V0.4S
    FMLA V4.4S, V23.4S, V20.S[0x3]
    FMLS H14, H22, V6.H[0x0]
    FADDP S6, V14.2S
    FADD  V30.8H, V6.8H, V6.8H
    FADDP S12, V30.2S
    FABD  V30.2S, V8.2S, V12.2S
    FMUL V1.4H, V4.4H, V5.H[0x4]
    FMUL  V16.2S, V1.2S, V30.2S
    FMOV  V31.2D, #0.59375000
    FACGE  V13.8H, V10.8H, V0.8H
    FMLS  V9.4H, V20.4H, V29.4H
    FNEG  V7.2D, V2.2D
    FMOV  V26.2D, #-12.50000000
    FADDP S6, V8.2S
    FRECPS  V0.4S, V26.4S, V9.4S
    FADDP D12, V10.2D
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_4
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x1f, LSL #0
    MRS  X13, FPSR
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x4000, LSL #16
    MOVK  X14, #0x4000, LSL #48
    FMOV  X13, V0.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x4000, LSL #16
    MOVK  X14, #0x1, LSL #32
    MOVK  X14, #0x7ea9, LSL #48
    FMOV  X13, D0
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D1
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    MOVK  X14, #0x7fc0, LSL #48
    FMOV  X13, D2
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xf810, LSL #0
    MOVK  X14, #0x3afc, LSL #16
    FMOV  X13, D3
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D4
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7f80, LSL #16
    MOVK  X14, #0x7fc0, LSL #48
    FMOV  X13, D5
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D6
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    FMOV  X13, V7.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    MOVK  X14, #0xffc0, LSL #48
    FMOV  X13, D7
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D8
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x7e00, LSL #48
    FMOV  X13, D9
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    MOVK  X14, #0x7fc0, LSL #48
    FMOV  X13, V10.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    MOVK  X14, #0x7fc0, LSL #48
    FMOV  X13, D10
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x8000, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x4000, LSL #32
    MOVK  X14, #0x8000, LSL #48
    FMOV  X13, D11
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    MOVK  X14, #0x7fd0, LSL #48
    FMOV  X13, D12
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xffff, LSL #32
    FMOV  X13, V13.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #32
    FMOV  X13, D13
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D14
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D16
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7e00, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    FMOV  X13, D17
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xfc00, LSL #0
    MOVK  X14, #0x7c00, LSL #16
    MOVK  X14, #0x7c00, LSL #32
    MOVK  X14, #0x7c00, LSL #48
    FMOV  X13, D19
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    FMOV  X13, V20.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x8000, LSL #0
    MOVK  X14, #0xfe00, LSL #16
    MOVK  X14, #0x8000, LSL #32
    MOVK  X14, #0x7e00, LSL #48
    FMOV  X13, D20
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    MOVK  X14, #0x7fc0, LSL #48
    FMOV  X13, D21
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x7e00, LSL #0
    MOVK  X14, #0x2800, LSL #16
    FMOV  X13, V22.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x8000, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x4000, LSL #32
    MOVK  X14, #0x8000, LSL #48
    FMOV  X13, D22
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x7e00, LSL #0
    FMOV  X13, D23
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7e00, LSL #16
    MOVK  X14, #0x7e00, LSL #48
    FMOV  X13, D24
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xc03f, LSL #48
    FMOV  X13, V25.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xc03f, LSL #48
    FMOV  X13, D25
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xc029, LSL #48
    FMOV  X13, V26.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xc029, LSL #48
    FMOV  X13, D26
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D27
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0xf5c8, LSL #0
    MOVK  X14, #0x4894, LSL #16
    MOVK  X14, #0xffe2, LSL #32
    MOVK  X14, #0x3f5f, LSL #48
    FMOV  X13, D28
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #48
    FMOV  X13, V29.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D29
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X13, D30
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3fe3, LSL #48
    FMOV  X13, V31.D[1]
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3fe3, LSL #48
    FMOV  X13, D31
    SUB  X15, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X24
    FMOV  V2.D[1], X4
    FMOV  D3, X27
    FMOV  V3.D[1], X21
    FMOV  D4, X4
    FMOV  V4.D[1], X6
    FMOV  D5, X24
    FMOV  V5.D[1], X24
    FMOV  D6, X25
    FMOV  V6.D[1], X14
    FMOV  D7, X15
    FMOV  V7.D[1], X23
    FMOV  D8, X23
    FMOV  V8.D[1], X18
    FMOV  D9, X16
    FMOV  V9.D[1], X3
    FMOV  D10, X27
    FMOV  V10.D[1], X16
    FMOV  D11, X15
    FMOV  V11.D[1], X2
    FMOV  D12, X8
    FMOV  V12.D[1], X23
    FMOV  D13, X15
    FMOV  V13.D[1], X4
    FMOV  D14, X8
    FMOV  V14.D[1], X6
    FMOV  D15, X17
    FMOV  V15.D[1], X4
    FMOV  D16, X4
    FMOV  V16.D[1], X10
    FMOV  D17, X5
    FMOV  V17.D[1], X8
    FMOV  D18, X5
    FMOV  V18.D[1], X25
    FMOV  D19, X4
    FMOV  V19.D[1], X5
    FMOV  D20, X8
    FMOV  V20.D[1], X15
    FMOV  D21, X24
    FMOV  V21.D[1], X20
    FMOV  D22, X2
    FMOV  V22.D[1], X17
    FMOV  D23, X12
    FMOV  V23.D[1], X13
    FMOV  D24, X28
    FMOV  V24.D[1], X21
    FMOV  D25, X11
    FMOV  V25.D[1], X13
    FMOV  D26, X20
    FMOV  V26.D[1], X5
    FMOV  D27, X22
    FMOV  V27.D[1], X16
    FMOV  D28, X11
    FMOV  V28.D[1], X14
    FMOV  D29, X22
    FMOV  V29.D[1], X4
    FMOV  D30, X22
    FMOV  V30.D[1], X7
    FMOV  D31, X20
    FMOV  V31.D[1], X7
    MOVZ  X18, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_5:
    FMLS V11.2S, V23.2S, V28.S[0x1]
    FSUB  V9.4S, V25.4S, V29.4S
    FACGT  V25.2D, V9.2D, V31.2D
    FRECPE  V24.4H, V27.4H
    FMULX V5.8H, V30.8H, V11.H[0x7]
    FMUL V14.4S, V26.4S, V24.S[0x3]
    FMLA  V11.2S, V5.2S, V14.2S
    FMLA V4.4H, V25.4H, V11.H[0x7]
    FABS  V30.8H, V21.8H
    FMUL  V13.8H, V30.8H, V4.8H
    FNEG  V26.4S, V13.4S
    FADDP  V27.2D, V26.2D, V26.2D
    FMLS V26.2D, V27.2D, V27.D[0x0]
    FNEG  V27.4H, V31.4H
    FRSQRTS  V9.2D, V14.2D, V22.2D
    FMULX V24.8H, V8.8H, V15.H[0x4]
    FMLA H25, H16, V2.H[0x6]
    FACGE  V22.8H, V1.8H, V18.8H
    FMLA V29.2D, V2.2D, V6.D[0x1]
    FADDP D23, V19.2D
    FMULX S2, S25, V8.S[0x2]
    FMLA S14, S1, V11.S[0x3]
    FRECPE  V6.4H, V27.4H
    FMUL V28.2S, V23.2S, V26.S[0x1]
    FMOV  V11.2D, #0.90625000
    FMULX H26, H22, V11.H[0x6]
    FRSQRTE  V31.2S, V14.2S
    FMULX V18.4H, V31.4H, V2.H[0x2]
    FADDP  V14.4H, V6.4H, V9.4H
    FMLS S1, S28, V19.S[0x3]
    FABD  V9.4H, V26.4H, V1.4H
    FRECPS  V27.4S, V18.4S, V29.4S
    FRSQRTS  V25.2S, V9.2S, V27.2S
    FRECPS  V23.4H, V24.4H, V24.4H
    FMLS D5, D23, V23.D[0x0]
    FMLA V6.4S, V14.4S, V5.S[0x1]
    FMUL V21.4H, V6.4H, V6.H[0x4]
    FMUL V15.2D, V21.2D, V25.D[0x1]
    FMULX V8.2S, V6.2S, V1.S[0x2]
    FSQRT  V9.4H, V24.4H
    FMUL S23, S26, V26.S[0x1]
    FADDP D2, V9.2D
    FADDP  V5.8H, V12.8H, V24.8H
    FACGT  V27.4S, V31.4S, V17.4S
    FRECPE  V28.8H, V25.8H
    FADDP  V9.4S, V8.4S, V10.4S
    FMUL  V14.8H, V5.8H, V25.8H
    FMLS  V18.4H, V12.4H, V2.4H
    FMULX  V25.4S, V6.4S, V20.4S
    FADD  V5.4S, V29.4S, V29.4S
    FMLA D31, D27, V27.D[0x0]
    FMLS V27.2D, V31.2D, V5.D[0x1]
    FABD  V12.8H, V9.8H, V29.8H
    FMUL D6, D23, V18.D[0x0]
    FSUB  V31.2S, V28.2S, V14.2S
    FNEG  V10.4S, V31.4S
    FMLS  V23.8H, V6.8H, V12.8H
    FRECPE  V9.2S, V27.2S
    FMLS V20.2S, V15.2S, V10.S[0x1]
    FADDP S6, V23.2S
    FMLA H15, H6, V6.H[0x0]
    FADDP  V24.4H, V15.4H, V25.4H
    FSUB  V26.4H, V24.4H, V9.4H
    FMULX H2, H20, V8.H[0x6]
    FRECPS  V23.4S, V26.4S, V26.4S
    FSQRT  V15.2D, V2.2D
    FMOV  V10.2S, #4.75000000
    FADDP  V24.4S, V10.4S, V5.4S
    FMULX H12, H24, V15.H[0x5]
    FMULX  V10.4H, V17.4H, V23.4H
    FADDP S5, V10.2S
    FADDP  V25.8H, V12.8H, V12.8H
    FRECPS  V2.4H, V21.4H, V5.4H
    FSQRT  V24.2D, V25.2D
    FMUL V23.2D, V16.2D, V2.D[0x0]
    FMLA V25.8H, V23.8H, V10.H[0x2]
    FRSQRTE  V21.8H, V2.8H
    FRECPE  V27.8H, V25.8H
    FMOV  V6.4H, #0.56250000
    FMLA V2.8H, V24.8H, V9.H[0x1]
    FNEG  V26.4H, V27.4H
    FABS  V16.8H, V6.8H
    FADDP H6, V22.2H
    FMUL V8.8H, V21.8H, V6.H[0x5]
    FMULX  V25.8H, V2.8H, V26.8H
    FABS  V12.4H, V8.4H
    FABD  V2.2S, V12.2S, V25.2S
    FMLS V5.2D, V2.2D, V2.D[0x1]
    FRSQRTS  V20.2S, V5.2S, V5.2S
    FMLS V22.2S, V16.2S, V16.S[0x1]
    FRECPE  V8.4S, V20.4S
    FMULX H23, H8, V8.H[0x7]
    FABS  V6.4S, V29.4S
    FMLA S10, S22, V22.S[0x1]
    FADDP  V12.2D, V6.2D, V10.2D
    FMLA  V24.8H, V12.8H, V23.8H
    FRSQRTS  V17.4S, V26.4S, V21.4S
    FMOV  V2.4H, #-0.16406250
    FRECPS  V22.4H, V18.4H, V21.4H
    FMULX D11, D14, V11.D[0x1]
    FMUL V10.4H, V30.4H, V10.H[0x6]
    FRECPS  V25.2D, V17.2D, V2.2D
    FMUL V23.2S, V30.2S, V13.S[0x2]
    FRECPE  V20.8H, V1.8H
    FMULX H14, H4, V3.H[0x2]
    FMLS V1.2D, V30.2D, V19.D[0x1]
    FSUB  V29.2S, V11.2S, V25.2S
    FMOV  V5.4H, #0.17968750
    FACGE  V19.8H, V14.8H, V5.8H
    FSQRT  V27.4H, V19.4H
    FRECPE  V14.2S, V1.2S
    FMULX V8.2D, V22.2D, V14.D[0x0]
    FRSQRTE  V6.4S, V10.4S
    FMLS  V3.2D, V6.2D, V23.2D
    FMLS  V10.2S, V27.2S, V3.2S
    FMLA V19.4H, V24.4H, V10.H[0x0]
    FABD  V3.2S, V8.2S, V29.2S
    FADDP D4, V19.2D
    FDIV  V19.8H, V3.8H, V28.8H
    FMLA V17.2D, V20.2D, V4.D[0x1]
    FRSQRTS  V22.2S, V17.2S, V19.2S
    FMULX V27.2S, V6.2S, V26.S[0x3]
    FRECPS  V13.8H, V24.8H, V7.8H
    FADD  V20.2S, V22.2S, V14.2S
    FSUB  V4.2S, V20.2S, V7.2S
    FMUL  V2.2D, V27.2D, V21.2D
    FMLS H1, H4, V0.H[0x0]
    FMULX  V7.2S, V10.2S, V1.2S
    FMLS H24, H7, V1.H[0x1]
    FMULX V14.8H, V17.8H, V3.H[0x1]
    FMOV  V1.2S, #-1.00000000
    FMLS  V28.4H, V31.4H, V20.4H
    FABD  V26.4H, V16.4H, V15.4H
    FMULX V4.4H, V17.4H, V10.H[0x4]
    FMLA  V3.8H, V23.8H, V11.8H
    FSQRT  V17.4H, V2.4H
    FRSQRTS  V27.4S, V1.4S, V28.4S
    FMUL H20, H26, V9.H[0x3]
    FMULX  V15.2S, V25.2S, V3.2S
    FMLS  V31.8H, V27.8H, V15.8H
    FMLS V16.4H, V1.4H, V14.H[0x7]
    FMULX S11, S24, V24.S[0x0]
    FMLA  V3.4S, V19.4S, V4.4S
    FMUL V25.4H, V11.4H, V7.H[0x7]
    FNEG  V0.4S, V25.4S
    FADDP  V25.2S, V3.2S, V20.2S
    FMOV  V15.4S, #0.75000000
    FRECPS  V28.2S, V16.2S, V0.2S
    FMUL V6.2D, V25.2D, V17.D[0x1]
    FMOV  V10.2D, #28.00000000
    FMLS  V26.8H, V6.8H, V15.8H
    FADDP H0, V31.2H
    FADD  V2.2D, V28.2D, V26.2D
    FMLS S7, S31, V0.S[0x1]
    FMULX H0, H7, V2.H[0x5]
    FRECPE  V15.2D, V26.2D
    FADDP H27, V10.2H
    FSUB  V25.2S, V27.2S, V15.2S
    FMLA V3.2S, V0.2S, V0.S[0x1]
    FACGT  V31.2S, V3.2S, V25.2S
    FACGE  V28.4S, V26.4S, V27.4S
    FMULX V26.2D, V19.2D, V10.D[0x0]
    FABD  V27.2D, V30.2D, V25.2D
    FMLS S25, S18, V5.S[0x2]
    FMLS D0, D7, V1.D[0x1]
    FMLA D17, D29, V29.D[0x1]
    FRECPS  V19.8H, V9.8H, V30.8H
    FMOV  V29.4S, #-4.25000000
    FABS  V9.2D, V31.2D
    FMOV  V2.4H, #3.87500000
    FMUL V24.2D, V26.2D, V17.D[0x0]
    FADDP  V18.4H, V2.4H, V18.4H
    FMUL H30, H18, V8.H[0x1]
    FADDP H17, V30.2H
    FMLA  V2.8H, V28.8H, V13.8H
    FMUL  V13.2S, V17.2S, V27.2S
    FMLA V18.2S, V13.2S, V0.S[0x3]
    FSUB  V16.2S, V18.2S, V9.2S
    FABD  V15.8H, V19.8H, V5.8H
    FMUL S8, S24, V16.S[0x2]
    FRECPE  V31.8H, V2.8H
    FMUL S2, S13, V8.S[0x1]
    FMUL H19, H25, V10.H[0x4]
    FADDP  V26.8H, V29.8H, V15.8H
    FMULX H8, H3, V9.H[0x5]
    FADD  V0.8H, V31.8H, V26.8H
    FMLA S30, S0, V0.S[0x2]
    FMLA V9.4S, V19.4S, V2.S[0x2]
    FADDP D18, V9.2D
    FADDP D10, V8.2D
    FMUL S28, S18, V30.S[0x3]
    FMULX V9.8H, V10.8H, V10.H[0x4]
    FDIV  V25.4H, V28.4H, V17.4H
    FMULX  V0.2S, V9.2S, V9.2S
    FADDP H16, V8.2H
    FRSQRTE  V31.8H, V16.8H
    FADDP H16, V31.2H
    FMLS S13, S16, V0.S[0x1]
    FRECPS  V24.4S, V13.4S, V25.4S
    FMLS V29.4H, V27.4H, V5.H[0x0]
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_5
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x1f, LSL #0
    MRS  X3, FPSR
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xbf80, LSL #16
    MOVK  X23, #0xbf80, LSL #48
    FMOV  X3, D1
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D2
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7f80, LSL #16
    MOVK  X23, #0x7f80, LSL #48
    FMOV  X3, D3
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x7e00, LSL #48
    FMOV  X3, D4
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x31c0, LSL #0
    MOVK  X23, #0x31c0, LSL #16
    MOVK  X23, #0x31c0, LSL #32
    MOVK  X23, #0x31c0, LSL #48
    FMOV  X3, D5
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    FMOV  X3, D7
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D8
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D9
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x1, LSL #0
    FMOV  X3, D11
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7e01, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    FMOV  X3, V12.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0xb00d, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    FMOV  X3, D12
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x75ff, LSL #16
    MOVK  X23, #0x75ff, LSL #48
    FMOV  X3, V14.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x7e00, LSL #48
    FMOV  X3, D14
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x4000, LSL #0
    MOVK  X23, #0x4000, LSL #16
    MOVK  X23, #0x4000, LSL #32
    MOVK  X23, #0x4000, LSL #48
    FMOV  X3, V15.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x3f48, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    FMOV  X3, D15
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7c00, LSL #0
    FMOV  X3, D16
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    MOVK  X23, #0x7fc0, LSL #48
    FMOV  X3, D18
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D19
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7e00, LSL #0
    FMOV  X3, D20
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7c00, LSL #0
    MOVK  X23, #0x7c00, LSL #16
    MOVK  X23, #0x7c00, LSL #32
    MOVK  X23, #0x7c00, LSL #48
    FMOV  X3, V21.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x39a4, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    FMOV  X3, D21
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xff80, LSL #16
    MOVK  X23, #0xff80, LSL #48
    FMOV  X3, D22
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7f80, LSL #16
    MOVK  X23, #0x7f80, LSL #48
    FMOV  X3, D23
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x4000, LSL #16
    MOVK  X23, #0x4000, LSL #48
    FMOV  X3, V24.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x4000, LSL #16
    MOVK  X23, #0x4000, LSL #48
    FMOV  X3, D24
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x7e00, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    FMOV  X3, D25
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x4400, LSL #32
    MOVK  X23, #0x4400, LSL #48
    FMOV  X3, V26.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0xc088, LSL #0
    MOVK  X23, #0xc088, LSL #16
    MOVK  X23, #0xc088, LSL #32
    MOVK  X23, #0xc088, LSL #48
    FMOV  X3, D26
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7c00, LSL #0
    MOVK  X23, #0x7c00, LSL #16
    MOVK  X23, #0x7c00, LSL #32
    MOVK  X23, #0x7c00, LSL #48
    FMOV  X3, V27.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7e01, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0x39a4, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    FMOV  X3, D27
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7fc0, LSL #16
    FMOV  X3, D28
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7e00, LSL #0
    MOVK  X23, #0x7e00, LSL #16
    MOVK  X23, #0xb00d, LSL #32
    MOVK  X23, #0x7e00, LSL #48
    FMOV  X3, D29
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7f80, LSL #16
    FMOV  X3, D30
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7c00, LSL #0
    MOVK  X23, #0x7c00, LSL #16
    MOVK  X23, #0x7c00, LSL #32
    MOVK  X23, #0x7c00, LSL #48
    FMOV  X3, V31.D[1]
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X23, #0x7c00, LSL #0
    MOVK  X23, #0x7c00, LSL #16
    MOVK  X23, #0x7c00, LSL #32
    MOVK  X23, #0x7c00, LSL #48
    FMOV  X3, D31
    SUB  X16, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0xa1ce, LSL #0
    MOVK  X2, #0xe5cf, LSL #16
    MOVK  X2, #0x2664, LSL #32
    MOVK  X2, #0x1c8d, LSL #48
    MOVZ  X3, #0x1106, LSL #0
    MOVK  X3, #0x41c6, LSL #16
    MOVK  X3, #0xa270, LSL #32
    MOVK  X3, #0xad3c, LSL #48
    MOVZ  X4, #0x9d72, LSL #0
    MOVK  X4, #0x92cc, LSL #16
    MOVK  X4, #0xa094, LSL #32
    MOVK  X4, #0x6ad5, LSL #48
    MOVZ  X5, #0xf5f3, LSL #0
    MOVK  X5, #0x1a90, LSL #16
    MOVK  X5, #0x7d21, LSL #32
    MOVK  X5, #0xe580, LSL #48
    MOVZ  X6, #0x6561, LSL #0
    MOVK  X6, #0x226b, LSL #16
    MOVK  X6, #0x8d2e, LSL #32
    MOVK  X6, #0x9c03, LSL #48
    MOVZ  X7, #0x6972, LSL #0
    MOVK  X7, #0x7e6, LSL #16
    MOVK  X7, #0xa944, LSL #32
    MOVK  X7, #0xb356, LSL #48
    MOVZ  X8, #0xd084, LSL #0
    MOVK  X8, #0x6b35, LSL #16
    MOVK  X8, #0x866f, LSL #32
    MOVK  X8, #0x3a75, LSL #48
    MOVZ  X10, #0xa7e0, LSL #0
    MOVK  X10, #0xccc6, LSL #16
    MOVK  X10, #0xf4d0, LSL #32
    MOVK  X10, #0xa2f4, LSL #48
    MOVZ  X11, #0x23f9, LSL #0
    MOVK  X11, #0x833b, LSL #16
    MOVK  X11, #0x3ef, LSL #32
    MOVK  X11, #0x577c, LSL #48
    MOVZ  X12, #0xc918, LSL #0
    MOVK  X12, #0x15bd, LSL #16
    MOVK  X12, #0x3cbf, LSL #32
    MOVK  X12, #0x181b, LSL #48
    MOVZ  X13, #0xe459, LSL #0
    MOVK  X13, #0x7b6c, LSL #16
    MOVK  X13, #0xb89b, LSL #32
    MOVK  X13, #0x9868, LSL #48
    MOVZ  X14, #0xbb5a, LSL #0
    MOVK  X14, #0x11d4, LSL #16
    MOVK  X14, #0xffb5, LSL #32
    MOVK  X14, #0x7e9a, LSL #48
    MOVZ  X15, #0xceaf, LSL #0
    MOVK  X15, #0xac90, LSL #16
    MOVK  X15, #0xee22, LSL #32
    MOVK  X15, #0xd22f, LSL #48
    MOVZ  X16, #0xffe5, LSL #0
    MOVK  X16, #0x5d25, LSL #16
    MOVK  X16, #0x5ffd, LSL #32
    MOVK  X16, #0xcf8d, LSL #48
    MOVZ  X17, #0x83f2, LSL #0
    MOVK  X17, #0x7a2b, LSL #16
    MOVK  X17, #0xdcb3, LSL #32
    MOVK  X17, #0xed2f, LSL #48
    MOVZ  X18, #0x6bf6, LSL #0
    MOVK  X18, #0xa699, LSL #16
    MOVK  X18, #0xe026, LSL #32
    MOVK  X18, #0x348e, LSL #48
    MOVZ  X20, #0x3203, LSL #0
    MOVK  X20, #0x4265, LSL #16
    MOVK  X20, #0xcb45, LSL #32
    MOVK  X20, #0x64c0, LSL #48
    MOVZ  X21, #0xebb4, LSL #0
    MOVK  X21, #0x9474, LSL #16
    MOVK  X21, #0xe9b3, LSL #32
    MOVK  X21, #0xacce, LSL #48
    MOVZ  X22, #0xae9, LSL #0
    MOVK  X22, #0x1bc1, LSL #16
    MOVK  X22, #0xe87c, LSL #32
    MOVK  X22, #0x561f, LSL #48
    MOVZ  X23, #0x2349, LSL #0
    MOVK  X23, #0xf962, LSL #16
    MOVK  X23, #0x87bb, LSL #32
    MOVK  X23, #0xa6db, LSL #48
    MOVZ  X24, #0xe91, LSL #0
    MOVK  X24, #0xe623, LSL #16
    MOVK  X24, #0xd3b0, LSL #32
    MOVK  X24, #0x3f08, LSL #48
    MOVZ  X25, #0xab7c, LSL #0
    MOVK  X25, #0xf84f, LSL #16
    MOVK  X25, #0x99e2, LSL #32
    MOVK  X25, #0xff95, LSL #48
    MOVZ  X27, #0xdef4, LSL #0
    MOVK  X27, #0xba73, LSL #16
    MOVK  X27, #0xf98e, LSL #32
    MOVK  X27, #0x5931, LSL #48
    MOVZ  X28, #0x1a9e, LSL #0
    MOVK  X28, #0x2d89, LSL #16
    MOVK  X28, #0xb652, LSL #32
    MOVK  X28, #0xff7f, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X23
    FMOV  V1.D[1], X25
    FMOV  D2, X24
    FMOV  V2.D[1], X3
    FMOV  D3, X14
    FMOV  V3.D[1], X27
    FMOV  D4, X20
    FMOV  V4.D[1], X4
    FMOV  D5, X4
    FMOV  V5.D[1], X24
    FMOV  D6, X18
    FMOV  V6.D[1], X14
    FMOV  D7, X23
    FMOV  V7.D[1], X6
    FMOV  D8, X16
    FMOV  V8.D[1], X22
    FMOV  D9, X10
    FMOV  V9.D[1], X7
    FMOV  D10, X12
    FMOV  V10.D[1], X18
    FMOV  D11, X7
    FMOV  V11.D[1], X22
    FMOV  D12, X18
    FMOV  V12.D[1], X28
    FMOV  D13, X28
    FMOV  V13.D[1], X24
    FMOV  D14, X27
    FMOV  V14.D[1], X13
    FMOV  D15, X5
    FMOV  V15.D[1], X20
    FMOV  D16, X28
    FMOV  V16.D[1], X23
    FMOV  D17, X17
    FMOV  V17.D[1], X27
    FMOV  D18, X12
    FMOV  V18.D[1], X11
    FMOV  D19, X11
    FMOV  V19.D[1], X6
    FMOV  D20, X24
    FMOV  V20.D[1], X11
    FMOV  D21, X13
    FMOV  V21.D[1], X18
    FMOV  D22, X8
    FMOV  V22.D[1], X7
    FMOV  D23, X20
    FMOV  V23.D[1], X12
    FMOV  D24, X18
    FMOV  V24.D[1], X7
    FMOV  D25, X14
    FMOV  V25.D[1], X27
    FMOV  D26, X6
    FMOV  V26.D[1], X27
    FMOV  D27, X4
    FMOV  V27.D[1], X3
    FMOV  D28, X28
    FMOV  V28.D[1], X28
    FMOV  D29, X22
    FMOV  V29.D[1], X21
    FMOV  D30, X27
    FMOV  V30.D[1], X22
    FMOV  D31, X8
    FMOV  V31.D[1], X8
    MOVZ  X13, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_6:
    FMOV  V3.4S, #0.62500000
    FRECPE  V30.4H, V30.4H
    FMLS V3.4S, V19.4S, V25.S[0x3]
    FACGT  V28.4S, V21.4S, V24.4S
    FMUL D6, D26, V3.D[0x0]
    FMULX D28, D30, V27.D[0x0]
    FSUB  V26.8H, V22.8H, V29.8H
    FRSQRTE  V25.8H, V26.8H
    FMLA S11, S6, V25.S[0x1]
    FRSQRTS  V25.4S, V28.4S, V23.4S
    FRSQRTE  V19.4S, V25.4S
    FMULX S12, S31, V19.S[0x2]
    FADDP D22, V11.2D
    FRECPE  V9.2S, V12.2S
    FMLA V12.2D, V9.2D, V9.D[0x1]
    FADDP S20, V12.2S
    FMULX  V11.2S, V20.2S, V20.2S
    FMULX S31, S22, V22.S[0x0]
    FMULX  V20.2D, V31.2D, V31.2D
    FMULX V29.4S, V11.4S, V8.S[0x1]
    FDIV  V30.4H, V29.4H, V29.4H
    FABD  V21.2S, V20.2S, V30.2S
    FRECPE  V5.2S, V26.2S
    FMULX  V11.4S, V26.4S, V12.4S
    FMOV  V26.8H, #-2.37500000
    FMLA V6.2D, V10.2D, V13.D[0x1]
    FMLS  V23.4H, V19.4H, V2.4H
    FRECPE  V9.4H, V1.4H
    FMLA S30, S30, V19.S[0x1]
    FMULX  V25.4H, V29.4H, V13.4H
    FMULX D29, D21, V6.D[0x1]
    FADDP D19, V25.2D
    FRSQRTS  V8.2S, V19.2S, V1.2S
    FMULX  V22.4H, V29.4H, V26.4H
    FMLS S26, S22, V0.S[0x0]
    FMOV  V20.8H, #0.65625000
    FADDP D19, V11.2D
    FMLA V31.4S, V30.4S, V30.S[0x1]
    FADDP D28, V26.2D
    FADDP S12, V8.2S
    FMLA S26, S20, V28.S[0x2]
    FMUL  V6.4S, V12.4S, V31.4S
    FMULX  V22.2D, V9.2D, V5.2D
    FMOV  V13.4H, #-1.25000000
    FMULX V2.4H, V23.4H, V6.H[0x0]
    FRSQRTS  V23.8H, V26.8H, V19.8H
    FMULX V19.4S, V23.4S, V23.S[0x1]
    FNEG  V5.2S, V22.2S
    FMLA  V20.8H, V25.8H, V19.8H
    FNEG  V21.4S, V20.4S
    FMULX  V23.8H, V2.8H, V31.8H
    FADDP  V20.8H, V23.8H, V5.8H
    FABS  V19.8H, V20.8H
    FRSQRTS  V11.2S, V13.2S, V13.2S
    FMLA  V8.2D, V21.2D, V5.2D
    FABS  V28.4H, V8.4H
    FMUL D9, D28, V28.D[0x1]
    FABS  V26.4H, V19.4H
    FMULX V6.2S, V26.2S, V11.S[0x0]
    FACGE  V25.2D, V6.2D, V9.2D
    FNEG  V1.4S, V4.4S
    FMLA  V19.2S, V4.2S, V4.2S
    FRSQRTS  V28.8H, V17.8H, V26.8H
    FADDP H22, V11.2H
    FADD  V13.8H, V12.8H, V19.8H
    FMLA  V26.4S, V3.4S, V1.4S
    FMLS  V6.4H, V8.4H, V6.4H
    FMULX  V30.8H, V8.8H, V24.8H
    FSQRT  V24.2D, V13.2D
    FMULX V31.4S, V18.4S, V15.S[0x2]
    FACGT  V21.8H, V16.8H, V7.8H
    FRSQRTS  V7.2D, V28.2D, V6.2D
    FMLS  V18.4H, V25.4H, V31.4H
    FNEG  V5.2D, V21.2D
    FRSQRTS  V8.8H, V26.8H, V5.8H
    FRECPS  V16.4H, V8.4H, V22.4H
    FMOV  V25.2D, #0.87500000
    FRSQRTE  V26.4H, V25.4H
    FMOV  V9.2D, #-0.84375000
    FMLA  V15.2D, V9.2D, V16.2D
    FRECPE  V20.4S, V30.4S
    FADD  V16.4H, V20.4H, V18.4H
    FRECPS  V20.4H, V16.4H, V16.4H
    FADDP  V17.4H, V24.4H, V20.4H
    FACGT  V16.2D, V15.2D, V27.2D
    FMLA V5.4S, V17.4S, V26.S[0x2]
    FMULX  V3.4S, V16.4S, V5.4S
    FMUL  V24.2S, V7.2S, V7.2S
    FMULX S8, S3, V24.S[0x1]
    FRECPS  V20.8H, V2.8H, V29.8H
    FRSQRTS  V29.8H, V24.8H, V19.8H
    FMLA D11, D6, V30.D[0x0]
    FACGE  V19.8H, V21.8H, V13.8H
    FADDP S5, V22.2S
    FMULX V25.4H, V2.4H, V7.H[0x7]
    FMLA H24, H19, V1.H[0x1]
    FACGE  V19.4S, V23.4S, V4.4S
    FADDP D26, V27.2D
    FADD  V18.4S, V24.4S, V24.4S
    FMULX  V23.4H, V18.4H, V18.4H
    FABD  V3.4S, V11.4S, V23.4S
    FMLA H23, H26, V0.H[0x0]
    FMUL D31, D19, V5.D[0x0]
    FABD  V19.4S, V31.4S, V23.4S
    FMUL V31.2S, V3.2S, V19.S[0x3]
    FMLA H19, H20, V7.H[0x6]
    FMOV  V4.4H, #-2.25000000
    FABD  V0.4S, V31.4S, V29.4S
    FMOV  V16.2D, #-0.43750000
    FMUL H5, H0, V4.H[0x7]
    FMLS S18, S8, V19.S[0x2]
    FMLS D26, D16, V18.D[0x0]
    FABS  V3.4H, V27.4H
    FMUL  V29.4H, V25.4H, V26.4H
    FDIV  V23.2D, V3.2D, V3.2D
    FMULX V19.8H, V23.8H, V5.H[0x2]
    FMLS S0, S25, V19.S[0x1]
    FMULX H27, H0, V0.H[0x5]
    FMLA  V31.2S, V29.2S, V29.2S
    FRSQRTE  V4.2S, V31.2S
    FSQRT  V5.2S, V4.2S
    FMLA V3.8H, V27.8H, V5.H[0x2]
    FMLS  V20.2S, V2.2S, V8.2S
    FMLA V5.2D, V23.2D, V31.D[0x0]
    FRECPE  V16.2S, V11.2S
    FMLS D11, D19, V6.D[0x1]
    FMOV  V19.4S, #1.31250000
    FACGT  V31.4S, V24.4S, V25.4S
    FSQRT  V29.4S, V6.4S
    FMLA V27.4H, V13.4H, V7.H[0x3]
    FMUL D26, D3, V27.D[0x0]
    FMLS H4, H16, V11.H[0x5]
    FDIV  V6.4H, V20.4H, V19.4H
    FMLA V0.4H, V6.4H, V5.H[0x5]
    FMLA V8.4S, V0.4S, V4.S[0x1]
    FABD  V2.8H, V8.8H, V26.8H
    FMUL D20, D29, V29.D[0x1]
    FMUL H13, H2, V2.H[0x1]
    FRSQRTS  V18.2S, V20.2S, V9.2S
    FACGT  V20.4H, V31.4H, V18.4H
    FRSQRTS  V26.4S, V13.4S, V20.4S
    FMULX H9, H28, V9.H[0x5]
    FMULX  V4.4S, V23.4S, V14.4S
    FMLS V3.4S, V9.4S, V18.S[0x1]
    FMUL H29, H0, V12.H[0x1]
    FABD  V13.8H, V9.8H, V6.8H
    FSUB  V31.2D, V0.2D, V16.2D
    FRECPE  V4.8H, V29.8H
    FSQRT  V2.2D, V26.2D
    FMOV  V12.2D, #0.16406250
    FACGT  V6.2D, V24.2D, V15.2D
    FMUL V28.2S, V22.2S, V21.S[0x0]
    FNEG  V22.8H, V20.8H
    FMLA V8.2D, V3.2D, V22.D[0x0]
    FADDP  V20.8H, V31.8H, V2.8H
    FMLS V21.4S, V8.4S, V28.S[0x0]
    FMUL D14, D21, V18.D[0x0]
    FNEG  V23.2S, V14.2S
    FMLS D9, D6, V13.D[0x1]
    FMUL V3.2D, V9.2D, V20.D[0x1]
    FMULX V11.8H, V23.8H, V12.H[0x4]
    FSUB  V26.4H, V11.4H, V3.4H
    FMLA  V20.4H, V26.4H, V4.4H
    FMULX V5.2D, V3.2D, V6.D[0x0]
    FNEG  V29.4H, V22.4H
    FADDP  V18.8H, V16.8H, V8.8H
    FMULX H20, H13, V8.H[0x1]
    FACGT  V26.4H, V6.4H, V26.4H
    FSUB  V8.2S, V28.2S, V8.2S
    FMLA V0.4S, V2.4S, V7.S[0x1]
    FRECPS  V13.4H, V4.4H, V13.4H
    FMLA  V16.2D, V26.2D, V22.2D
    FDIV  V12.8H, V23.8H, V26.8H
    FMUL V24.2D, V18.2D, V12.D[0x0]
    FMUL  V21.4S, V16.4S, V8.4S
    FNEG  V9.4H, V15.4H
    FMLS  V31.2D, V20.2D, V13.2D
    FRECPE  V9.8H, V0.8H
    FADD  V15.4S, V29.4S, V5.4S
    FMLS  V14.4H, V24.4H, V24.4H
    FMOV  V10.8H, #-0.23437500
    FMLS D5, D21, V10.D[0x1]
    FMUL H28, H14, V15.H[0x0]
    FRECPS  V4.8H, V31.8H, V28.8H
    FMLA S29, S4, V4.S[0x0]
    FMLA V14.8H, V29.8H, V0.H[0x6]
    FMLA  V15.8H, V9.8H, V5.8H
    FMLA V3.2S, V14.2S, V15.S[0x2]
    FMUL V15.2S, V6.2S, V2.S[0x2]
    FABD  V12.2D, V22.2D, V15.2D
    FMLA  V16.8H, V25.8H, V11.8H
    FMOV  V23.4H, #-1.56250000
    FNEG  V14.4H, V15.4H
    FRSQRTE  V20.2S, V13.2S
    FABD  V9.4H, V28.4H, V29.4H
    FADD  V5.4H, V1.4H, V1.4H
    FMOV  V0.2D, #6.25000000
    FADD  V15.4S, V0.4S, V20.4S
    FNEG  V20.4H, V5.4H
    FMLS H25, H3, V8.H[0x2]
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_6
    MOVZ  X11, #0xa1ce, LSL #0
    MOVK  X11, #0xe5cf, LSL #16
    MOVK  X11, #0x2664, LSL #32
    MOVK  X11, #0x1c8d, LSL #48
    SUB  X27, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x1106, LSL #0
    MOVK  X11, #0x41c6, LSL #16
    MOVK  X11, #0xa270, LSL #32
    MOVK  X11, #0xad3c, LSL #48
    SUB  X27, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x9d72, LSL #0
    MOVK  X11, #0x92cc, LSL #16
    MOVK  X11, #0xa094, LSL #32
    MOVK  X11, #0x6ad5, LSL #48
    SUB  X27, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x6561, LSL #0
    MOVK  X11, #0x226b, LSL #16
    MOVK  X11, #0x8d2e, LSL #32
    MOVK  X11, #0x9c03, LSL #48
    SUB  X27, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x6972, LSL #0
    MOVK  X11, #0x7e6, LSL #16
    MOVK  X11, #0xa944, LSL #32
    MOVK  X11, #0xb356, LSL #48
    SUB  X27, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xd084, LSL #0
    MOVK  X11, #0x6b35, LSL #16
    MOVK  X11, #0x866f, LSL #32
    MOVK  X11, #0x3a75, LSL #48
    SUB  X27, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xa7e0, LSL #0
    MOVK  X11, #0xccc6, LSL #16
    MOVK  X11, #0xf4d0, LSL #32
    MOVK  X11, #0xa2f4, LSL #48
    SUB  X27, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xc918, LSL #0
    MOVK  X11, #0x15bd, LSL #16
    MOVK  X11, #0x3cbf, LSL #32
    MOVK  X11, #0x181b, LSL #48
    SUB  X27, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xbb5a, LSL #0
    MOVK  X11, #0x11d4, LSL #16
    MOVK  X11, #0xffb5, LSL #32
    MOVK  X11, #0x7e9a, LSL #48
    SUB  X27, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xceaf, LSL #0
    MOVK  X11, #0xac90, LSL #16
    MOVK  X11, #0xee22, LSL #32
    MOVK  X11, #0xd22f, LSL #48
    SUB  X27, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xffe5, LSL #0
    MOVK  X11, #0x5d25, LSL #16
    MOVK  X11, #0x5ffd, LSL #32
    MOVK  X11, #0xcf8d, LSL #48
    SUB  X27, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x83f2, LSL #0
    MOVK  X11, #0x7a2b, LSL #16
    MOVK  X11, #0xdcb3, LSL #32
    MOVK  X11, #0xed2f, LSL #48
    SUB  X27, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x6bf6, LSL #0
    MOVK  X11, #0xa699, LSL #16
    MOVK  X11, #0xe026, LSL #32
    MOVK  X11, #0x348e, LSL #48
    SUB  X27, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x3203, LSL #0
    MOVK  X11, #0x4265, LSL #16
    MOVK  X11, #0xcb45, LSL #32
    MOVK  X11, #0x64c0, LSL #48
    SUB  X27, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xebb4, LSL #0
    MOVK  X11, #0x9474, LSL #16
    MOVK  X11, #0xe9b3, LSL #32
    MOVK  X11, #0xacce, LSL #48
    SUB  X27, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xae9, LSL #0
    MOVK  X11, #0x1bc1, LSL #16
    MOVK  X11, #0xe87c, LSL #32
    MOVK  X11, #0x561f, LSL #48
    SUB  X27, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x2349, LSL #0
    MOVK  X11, #0xf962, LSL #16
    MOVK  X11, #0x87bb, LSL #32
    MOVK  X11, #0xa6db, LSL #48
    SUB  X27, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xe91, LSL #0
    MOVK  X11, #0xe623, LSL #16
    MOVK  X11, #0xd3b0, LSL #32
    MOVK  X11, #0x3f08, LSL #48
    SUB  X27, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xab7c, LSL #0
    MOVK  X11, #0xf84f, LSL #16
    MOVK  X11, #0x99e2, LSL #32
    MOVK  X11, #0xff95, LSL #48
    SUB  X27, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x1a9e, LSL #0
    MOVK  X11, #0x2d89, LSL #16
    MOVK  X11, #0xb652, LSL #32
    MOVK  X11, #0xff7f, LSL #48
    SUB  X27, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x1f, LSL #0
    MRS  X27, FPSR
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4019, LSL #48
    FMOV  X27, V0.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4019, LSL #48
    FMOV  X27, D0
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x4000, LSL #0
    MOVK  X11, #0xc000, LSL #16
    MOVK  X11, #0x4000, LSL #32
    MOVK  X11, #0xc000, LSL #48
    FMOV  X27, V1.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x4000, LSL #0
    MOVK  X11, #0xfe00, LSL #16
    MOVK  X11, #0x4000, LSL #32
    MOVK  X11, #0xfe00, LSL #48
    FMOV  X27, D1
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x3730, LSL #0
    MOVK  X11, #0x9393, LSL #16
    MOVK  X11, #0xa09e, LSL #32
    MOVK  X11, #0x3fd6, LSL #48
    FMOV  X27, V2.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x3730, LSL #0
    MOVK  X11, #0x9393, LSL #16
    MOVK  X11, #0xa09e, LSL #32
    MOVK  X11, #0x3fd6, LSL #48
    FMOV  X27, D2
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7f80, LSL #16
    MOVK  X11, #0x83c1, LSL #32
    MOVK  X11, #0xfc4b, LSL #48
    FMOV  X27, D3
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x4000, LSL #0
    MOVK  X11, #0x4000, LSL #16
    MOVK  X11, #0x4000, LSL #32
    MOVK  X11, #0x4000, LSL #48
    FMOV  X27, V4.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x4000, LSL #0
    MOVK  X11, #0x7e00, LSL #16
    MOVK  X11, #0x4000, LSL #32
    MOVK  X11, #0x7e00, LSL #48
    FMOV  X27, D4
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x4400, LSL #0
    MOVK  X11, #0x7e00, LSL #16
    MOVK  X11, #0x4400, LSL #32
    MOVK  X11, #0x7e00, LSL #48
    FMOV  X27, D5
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, D6
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x3ff8, LSL #48
    FMOV  X27, V7.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffef, LSL #48
    FMOV  X27, D7
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x7a00, LSL #0
    MOVK  X11, #0x7c11, LSL #16
    MOVK  X11, #0x7e10, LSL #32
    MOVK  X11, #0x3dd0, LSL #48
    FMOV  X27, D8
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7e00, LSL #16
    FMOV  X27, D9
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xb380, LSL #0
    MOVK  X11, #0xb380, LSL #16
    MOVK  X11, #0xb380, LSL #32
    MOVK  X11, #0xb380, LSL #48
    FMOV  X27, V10.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xb380, LSL #0
    MOVK  X11, #0xb380, LSL #16
    MOVK  X11, #0xb380, LSL #32
    MOVK  X11, #0xb380, LSL #48
    FMOV  X27, D10
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    MOVK  X11, #0x8000, LSL #48
    FMOV  X27, D11
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x8000, LSL #0
    MOVK  X11, #0x8000, LSL #16
    MOVK  X11, #0x8000, LSL #32
    FMOV  X27, V12.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x8000, LSL #0
    MOVK  X11, #0x8000, LSL #32
    FMOV  X27, D12
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x7e00, LSL #0
    MOVK  X11, #0x7e00, LSL #16
    MOVK  X11, #0xfc00, LSL #32
    MOVK  X11, #0x7e00, LSL #48
    FMOV  X27, D13
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x8000, LSL #0
    MOVK  X11, #0x8000, LSL #32
    FMOV  X27, D14
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4019, LSL #48
    FMOV  X27, V15.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x8000, LSL #0
    MOVK  X11, #0x2034, LSL #16
    MOVK  X11, #0x1, LSL #32
    MOVK  X11, #0x4019, LSL #48
    FMOV  X27, D15
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7e00, LSL #16
    MOVK  X11, #0x7e00, LSL #48
    FMOV  X27, D16
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xbfcd, LSL #0
    MOVK  X11, #0x5ef6, LSL #16
    MOVK  X11, #0x7e00, LSL #32
    MOVK  X11, #0x7e00, LSL #48
    FMOV  X27, D17
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x7e00, LSL #0
    MOVK  X11, #0x7e00, LSL #16
    FMOV  X27, V18.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x7e00, LSL #0
    MOVK  X11, #0x7e00, LSL #16
    FMOV  X27, D18
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x3fa8, LSL #16
    MOVK  X11, #0x3fa8, LSL #48
    FMOV  X27, V19.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x3fa8, LSL #16
    MOVK  X11, #0x3fa8, LSL #48
    FMOV  X27, D19
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V20.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xc400, LSL #0
    MOVK  X11, #0xfe00, LSL #16
    MOVK  X11, #0xc400, LSL #32
    MOVK  X11, #0xfe00, LSL #48
    FMOV  X27, D20
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7f80, LSL #16
    MOVK  X11, #0x7fc0, LSL #48
    FMOV  X27, D21
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x8000, LSL #0
    MOVK  X11, #0x8000, LSL #16
    MOVK  X11, #0x8000, LSL #32
    MOVK  X11, #0x8000, LSL #48
    FMOV  X27, V22.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x8000, LSL #0
    MOVK  X11, #0x8000, LSL #16
    MOVK  X11, #0x8000, LSL #32
    MOVK  X11, #0x8000, LSL #48
    FMOV  X27, D22
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xbe40, LSL #0
    MOVK  X11, #0xbe40, LSL #16
    MOVK  X11, #0xbe40, LSL #32
    MOVK  X11, #0xbe40, LSL #48
    FMOV  X27, D23
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xf811, LSL #0
    MOVK  X11, #0xb810, LSL #16
    MOVK  X11, #0x3c18, LSL #32
    MOVK  X11, #0x3cd0, LSL #48
    FMOV  X27, V24.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0xf811, LSL #0
    MOVK  X11, #0xb810, LSL #16
    MOVK  X11, #0x3c18, LSL #32
    MOVK  X11, #0x3cd0, LSL #48
    FMOV  X27, D24
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x7e00, LSL #0
    FMOV  X27, D25
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, D26
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x7e00, LSL #0
    MOVK  X11, #0x7e00, LSL #16
    MOVK  X11, #0x7e00, LSL #32
    MOVK  X11, #0x7e00, LSL #48
    FMOV  X27, D27
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x8000, LSL #0
    FMOV  X27, D28
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7f80, LSL #16
    FMOV  X27, D29
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x8000, LSL #0
    MOVK  X11, #0x8000, LSL #16
    FMOV  X27, V30.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x7e00, LSL #0
    MOVK  X11, #0x7e00, LSL #16
    MOVK  X11, #0x7e00, LSL #32
    MOVK  X11, #0x7e00, LSL #48
    FMOV  X27, D30
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X11, #0x1ff8, LSL #0
    MOVK  X11, #0x7e78, LSL #16
    MOVK  X11, #0xffc0, LSL #48
    FMOV  X27, D31
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X27
    FMOV  V1.D[1], X21
    FMOV  D2, X22
    FMOV  V2.D[1], X23
    FMOV  D3, X18
    FMOV  V3.D[1], X28
    FMOV  D4, X7
    FMOV  V4.D[1], X16
    FMOV  D5, X20
    FMOV  V5.D[1], X24
    FMOV  D6, X17
    FMOV  V6.D[1], X6
    FMOV  D7, X13
    FMOV  V7.D[1], X18
    FMOV  D8, X10
    FMOV  V8.D[1], X13
    FMOV  D9, X14
    FMOV  V9.D[1], X6
    FMOV  D10, X20
    FMOV  V10.D[1], X24
    FMOV  D11, X11
    FMOV  V11.D[1], X25
    FMOV  D12, X22
    FMOV  V12.D[1], X15
    FMOV  D13, X2
    FMOV  V13.D[1], X8
    FMOV  D14, X11
    FMOV  V14.D[1], X14
    FMOV  D15, X10
    FMOV  V15.D[1], X27
    FMOV  D16, X28
    FMOV  V16.D[1], X5
    FMOV  D17, X8
    FMOV  V17.D[1], X6
    FMOV  D18, X12
    FMOV  V18.D[1], X13
    FMOV  D19, X21
    FMOV  V19.D[1], X4
    FMOV  D20, X17
    FMOV  V20.D[1], X14
    FMOV  D21, X5
    FMOV  V21.D[1], X11
    FMOV  D22, X2
    FMOV  V22.D[1], X15
    FMOV  D23, X28
    FMOV  V23.D[1], X15
    FMOV  D24, X27
    FMOV  V24.D[1], X11
    FMOV  D25, X27
    FMOV  V25.D[1], X8
    FMOV  D26, X3
    FMOV  V26.D[1], X12
    FMOV  D27, X24
    FMOV  V27.D[1], X17
    FMOV  D28, X4
    FMOV  V28.D[1], X24
    FMOV  D29, X16
    FMOV  V29.D[1], X10
    FMOV  D30, X2
    FMOV  V30.D[1], X22
    FMOV  D31, X11
    FMOV  V31.D[1], X2
    MOVZ  X3, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_7:
    FRSQRTE  V9.4H, V27.4H
    FMLA V16.4H, V20.4H, V8.H[0x6]
    FMLS V12.8H, V16.8H, V3.H[0x2]
    FMLS H9, H28, V9.H[0x0]
    FSQRT  V3.4S, V21.4S
    FNEG  V5.2D, V23.2D
    FMLS  V17.2S, V3.2S, V24.2S
    FRECPE  V0.2D, V26.2D
    FADDP H10, V9.2H
    FMULX V5.2D, V30.2D, V22.D[0x0]
    FMLA  V28.8H, V0.8H, V0.8H
    FMULX S24, S17, V17.S[0x1]
    FMLS S5, S31, V25.S[0x3]
    FMULX S25, S13, V10.S[0x2]
    FRECPE  V23.4S, V28.4S
    FSQRT  V22.4S, V24.4S
    FRSQRTE  V3.8H, V29.8H
    FMULX H31, H5, V7.H[0x4]
    FRSQRTS  V3.2S, V31.2S, V25.2S
    FMULX V13.2S, V12.2S, V22.S[0x0]
    FMOV  V10.4H, #-3.75000000
    FMOV  V16.8H, #-4.00000000
    FMLS V5.2D, V16.2D, V10.D[0x1]
    FMULX S28, S3, V25.S[0x1]
    FSQRT  V24.2S, V28.2S
    FSUB  V17.4S, V5.4S, V13.4S
    FMLS  V29.8H, V17.8H, V23.8H
    FMUL D28, D29, V24.D[0x0]
    FMLA D31, D19, V31.D[0x0]
    FABS  V25.8H, V1.8H
    FMUL  V12.4H, V28.4H, V10.4H
    FMUL V22.4H, V8.4H, V10.H[0x3]
    FRSQRTS  V7.4S, V9.4S, V8.4S
    FMLA  V8.4H, V9.4H, V25.4H
    FMUL H3, H16, V6.H[0x6]
    FACGT  V10.4H, V21.4H, V29.4H
    FABS  V0.2S, V14.2S
    FMUL D14, D8, V17.D[0x0]
    FMUL V13.2D, V27.2D, V24.D[0x1]
    FMLA  V27.8H, V7.8H, V7.8H
    FMULX D6, D31, V22.D[0x1]
    FMOV  V16.2S, #-3.87500000
    FDIV  V25.4H, V27.4H, V14.4H
    FMUL V14.8H, V12.8H, V10.H[0x1]
    FDIV  V1.4H, V16.4H, V3.4H
    FMUL  V5.2S, V1.2S, V0.2S
    FMOV  V0.4H, #-8.50000000
    FACGE  V1.4H, V13.4H, V13.4H
    FMLS V7.2D, V0.2D, V1.D[0x0]
    FACGE  V28.4S, V25.4S, V7.4S
    FADDP  V25.8H, V6.8H, V14.8H
    FADD  V14.4H, V5.4H, V5.4H
    FMULX H12, H14, V14.H[0x5]
    FRECPE  V7.2D, V25.2D
    FSUB  V13.4S, V7.4S, V7.4S
    FMUL  V8.4S, V13.4S, V12.4S
    FRECPS  V31.8H, V8.8H, V5.8H
    FDIV  V6.2D, V28.2D, V28.2D
    FRECPS  V3.4H, V31.4H, V31.4H
    FMULX V7.4S, V3.4S, V3.S[0x1]
    FMULX  V14.8H, V7.8H, V6.8H
    FMLS H3, H26, V9.H[0x0]
    FMLS H8, H8, V9.H[0x6]
    FMUL V28.8H, V16.8H, V13.H[0x6]
    FSUB  V12.2D, V11.2D, V3.2D
    FNEG  V25.8H, V14.8H
    FMULX S7, S13, V15.S[0x3]
    FMUL H5, H26, V3.H[0x1]
    FMULX V31.2D, V9.2D, V25.D[0x0]
    FMUL  V14.8H, V24.8H, V1.8H
    FMLA S0, S6, V11.S[0x3]
    FABS  V16.8H, V14.8H
    FRECPS  V27.8H, V22.8H, V17.8H
    FMLS V14.4H, V14.4H, V10.H[0x5]
    FACGE  V24.2S, V28.2S, V12.2S
    FACGE  V15.4S, V0.4S, V14.4S
    FACGE  V14.4S, V24.4S, V7.4S
    FMUL H0, H27, V8.H[0x7]
    FMLS D25, D16, V16.D[0x1]
    FMLS V24.4H, V14.4H, V0.H[0x4]
    FSQRT  V24.8H, V31.8H
    FRECPE  V9.2D, V24.2D
    FRECPS  V8.4H, V15.4H, V4.4H
    FDIV  V17.4H, V9.4H, V9.4H
    FABS  V22.2D, V5.2D
    FRECPS  V4.8H, V8.8H, V22.8H
    FSQRT  V10.4S, V4.4S
    FMULX H22, H17, V10.H[0x3]
    FMOV  V15.8H, #-4.75000000
    FMUL S24, S18, V22.S[0x2]
    FADD  V27.4S, V24.4S, V15.4S
    FABD  V31.8H, V27.8H, V25.8H
    FABS  V3.8H, V18.8H
    FABS  V14.4S, V31.4S
    FSQRT  V0.8H, V6.8H
    FRSQRTE  V15.8H, V30.8H
    FACGE  V31.8H, V24.8H, V8.8H
    FMUL D16, D8, V18.D[0x1]
    FACGT  V1.2S, V20.2S, V28.2S
    FMULX  V25.4H, V13.4H, V12.4H
    FADDP H27, V22.2H
    FRSQRTS  V13.2S, V31.2S, V14.2S
    FMULX  V7.4H, V3.4H, V1.4H
    FADDP D31, V25.2D
    FMULX S4, S31, V5.S[0x2]
    FMLS S12, S0, V4.S[0x0]
    FMLA V6.2D, V7.2D, V7.D[0x1]
    FABD  V4.8H, V6.8H, V13.8H
    FMLA  V24.2D, V15.2D, V16.2D
    FRSQRTS  V6.4H, V24.4H, V24.4H
    FMUL  V13.8H, V12.8H, V4.8H
    FMUL V30.8H, V6.8H, V13.H[0x4]
    FADD  V28.4H, V27.4H, V27.4H
    FMULX H0, H28, V10.H[0x1]
    FMULX  V5.2D, V0.2D, V0.2D
    FADDP  V17.4H, V30.4H, V30.4H
    FNEG  V31.8H, V17.8H
    FMLS D10, D5, V5.D[0x1]
    FDIV  V28.4H, V6.4H, V10.4H
    FMULX D3, D28, V31.D[0x1]
    FADDP  V14.4H, V11.4H, V14.4H
    FMLS H1, H18, V0.H[0x4]
    FMLA V4.2D, V24.2D, V12.D[0x1]
    FMLA  V13.4S, V23.4S, V19.4S
    FMOV  V24.8H, #0.21093750
    FABD  V8.2S, V10.2S, V24.2S
    FMULX V17.2D, V20.2D, V22.D[0x0]
    FMOV  V0.2S, #0.17187500
    FMULX S12, S5, V9.S[0x1]
    FMULX V19.2S, V17.2S, V12.S[0x1]
    FABD  V18.8H, V3.8H, V19.8H
    FMLS H7, H14, V14.H[0x2]
    FRSQRTS  V14.2D, V1.2D, V13.2D
    FSQRT  V30.2D, V8.2D
    FRSQRTS  V8.2D, V14.2D, V0.2D
    FMULX  V24.8H, V8.8H, V4.8H
    FABS  V1.4S, V30.4S
    FMOV  V6.2D, #-16.00000000
    FMUL  V19.8H, V7.8H, V24.8H
    FMLA  V9.2D, V3.2D, V18.2D
    FRECPE  V30.4H, V6.4H
    FMUL  V17.4H, V30.4H, V30.4H
    FMUL D13, D9, V17.D[0x0]
    FMULX V18.2D, V13.2D, V1.D[0x0]
    FADDP  V24.4H, V18.4H, V18.4H
    FABD  V17.2S, V19.2S, V19.2S
    FABD  V5.8H, V17.8H, V24.8H
    FSQRT  V14.2D, V29.2D
    FMLA V23.4S, V10.4S, V10.S[0x2]
    FMULX S7, S20, V17.S[0x0]
    FMLS V19.8H, V18.8H, V4.H[0x3]
    FMOV  V0.4H, #0.93750000
    FRECPS  V17.8H, V11.8H, V1.8H
    FMLS V1.2S, V18.2S, V17.S[0x3]
    FMLS  V6.4H, V1.4H, V25.4H
    FACGT  V13.2D, V25.2D, V13.2D
    FMLS D3, D22, V24.D[0x1]
    FDIV  V24.8H, V6.8H, V6.8H
    FABD  V1.4H, V0.4H, V7.4H
    FADDP D9, V23.2D
    FMULX S17, S19, V13.S[0x2]
    FMUL S11, S9, V14.S[0x3]
    FMULX V9.8H, V3.8H, V11.H[0x6]
    FMLA  V30.4H, V17.4H, V5.4H
    FADDP S18, V30.2S
    FDIV  V20.8H, V24.8H, V25.8H
    FMULX V29.2D, V16.2D, V9.D[0x1]
    FMLA V17.2S, V1.2S, V20.S[0x0]
    FDIV  V0.8H, V18.8H, V18.8H
    FACGE  V5.2D, V29.2D, V29.2D
    FACGE  V6.4H, V17.4H, V17.4H
    FADDP D22, V6.2D
    FMLS V25.2S, V0.2S, V0.S[0x3]
    FMUL V23.2D, V25.2D, V25.D[0x0]
    FMLS V29.4S, V23.4S, V5.S[0x0]
    FMUL V1.4H, V29.4H, V10.H[0x7]
    FMULX  V11.8H, V1.8H, V1.8H
    FMULX D24, D22, V11.D[0x0]
    FMUL V20.8H, V5.8H, V11.H[0x2]
    FMUL V14.4S, V23.4S, V4.S[0x3]
    FMLA V19.2D, V3.2D, V16.D[0x0]
    FRECPS  V11.4H, V3.4H, V19.4H
    FRECPE  V4.2S, V14.2S
    FADD  V23.8H, V19.8H, V17.8H
    FSUB  V10.2S, V18.2S, V22.2S
    FMOV  V3.2S, #0.59375000
    FMLA  V6.2S, V4.2S, V28.2S
    FACGT  V14.2D, V31.2D, V15.2D
    FMLS  V25.4S, V12.4S, V8.4S
    FADDP  V19.2S, V23.2S, V24.2S
    FABD  V30.4H, V19.4H, V10.4H
    FADDP S19, V20.2S
    FMLA S8, S11, V11.S[0x3]
    FABS  V17.4S, V8.4S
    FADDP S20, V3.2S
    FMLS V12.8H, V30.8H, V2.H[0x1]
    FNEG  V5.4S, V25.4S
    FABD  V15.8H, V5.8H, V5.8H
    FMULX S16, S12, V17.S[0x3]
    FNEG  V28.4H, V15.4H
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_7
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x1f, LSL #0
    MRS  X11, FPSR
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X11, V0.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X11, D0
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X11, D1
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, D2
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x3f18, LSL #16
    MOVK  X21, #0x3f18, LSL #48
    FMOV  X11, D3
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7f80, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    FMOV  X11, D4
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #16
    MOVK  X21, #0x8000, LSL #48
    FMOV  X11, V5.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xfffe, LSL #0
    MOVK  X21, #0x7f7f, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0x7f7f, LSL #48
    FMOV  X11, D5
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V6.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    FMOV  X11, D6
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, D7
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xfffe, LSL #0
    MOVK  X21, #0xff3f, LSL #16
    FMOV  X11, D8
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V9.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #48
    FMOV  X11, D9
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7c00, LSL #0
    MOVK  X21, #0x7c00, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    FMOV  X11, D10
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x4000, LSL #48
    FMOV  X11, D11
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X11, D12
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X11, D13
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, D14
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X11, D15
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, D16
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xfffe, LSL #0
    MOVK  X21, #0x7f3f, LSL #16
    FMOV  X11, D17
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V18.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7c00, LSL #0
    MOVK  X21, #0x7c00, LSL #16
    FMOV  X11, D18
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e80, LSL #16
    FMOV  X11, D19
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x3f98, LSL #16
    FMOV  X11, D20
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, D21
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7ff8, LSL #48
    FMOV  X11, D22
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7a00, LSL #48
    FMOV  X11, D23
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7ff8, LSL #48
    FMOV  X11, D24
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xfffe, LSL #0
    MOVK  X21, #0xff7f, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xff7f, LSL #48
    FMOV  X11, D25
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, D26
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    FMOV  X11, D27
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xfe00, LSL #0
    MOVK  X21, #0xfe00, LSL #16
    MOVK  X21, #0xfe00, LSL #32
    MOVK  X21, #0xfe00, LSL #48
    FMOV  X11, D28
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    FMOV  X11, V29.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    FMOV  X11, D29
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X11, D30
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x8000, LSL #0
    MOVK  X21, #0x8000, LSL #16
    MOVK  X21, #0x8000, LSL #32
    MOVK  X21, #0x8000, LSL #48
    FMOV  X11, V31.D[1]
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x8000, LSL #0
    MOVK  X21, #0x8000, LSL #16
    MOVK  X21, #0x8000, LSL #32
    MOVK  X21, #0x8000, LSL #48
    FMOV  X11, D31
    SUB  X22, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X23
    FMOV  D1, X25
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X24
    FMOV  D3, X16
    FMOV  V3.D[1], X15
    FMOV  D4, X25
    FMOV  V4.D[1], X22
    FMOV  D5, X27
    FMOV  V5.D[1], X11
    FMOV  D6, X7
    FMOV  V6.D[1], X11
    FMOV  D7, X10
    FMOV  V7.D[1], X6
    FMOV  D8, X13
    FMOV  V8.D[1], X10
    FMOV  D9, X24
    FMOV  V9.D[1], X28
    FMOV  D10, X14
    FMOV  V10.D[1], X25
    FMOV  D11, X8
    FMOV  V11.D[1], X7
    FMOV  D12, X15
    FMOV  V12.D[1], X15
    FMOV  D13, X23
    FMOV  V13.D[1], X20
    FMOV  D14, X20
    FMOV  V14.D[1], X16
    FMOV  D15, X23
    FMOV  V15.D[1], X27
    FMOV  D16, X24
    FMOV  V16.D[1], X17
    FMOV  D17, X28
    FMOV  V17.D[1], X10
    FMOV  D18, X13
    FMOV  V18.D[1], X25
    FMOV  D19, X21
    FMOV  V19.D[1], X15
    FMOV  D20, X21
    FMOV  V20.D[1], X11
    FMOV  D21, X14
    FMOV  V21.D[1], X20
    FMOV  D22, X5
    FMOV  V22.D[1], X6
    FMOV  D23, X17
    FMOV  V23.D[1], X7
    FMOV  D24, X24
    FMOV  V24.D[1], X11
    FMOV  D25, X25
    FMOV  V25.D[1], X4
    FMOV  D26, X20
    FMOV  V26.D[1], X23
    FMOV  D27, X16
    FMOV  V27.D[1], X3
    FMOV  D28, X3
    FMOV  V28.D[1], X3
    FMOV  D29, X5
    FMOV  V29.D[1], X15
    FMOV  D30, X13
    FMOV  V30.D[1], X28
    FMOV  D31, X7
    FMOV  V31.D[1], X3
    MOVZ  X17, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_8:
    FMLS V15.4S, V29.4S, V30.S[0x0]
    FMLS S27, S28, V20.S[0x3]
    FMOV  V22.4H, #-6.25000000
    FADDP  V28.8H, V26.8H, V15.8H
    FMLS V2.4H, V24.4H, V10.H[0x6]
    FMUL H14, H31, V2.H[0x6]
    FMULX D30, D22, V27.D[0x0]
    FNEG  V20.4S, V30.4S
    FADDP S7, V28.2S
    FRECPE  V20.4S, V7.4S
    FMLS  V22.4H, V14.4H, V20.4H
    FADDP H30, V22.2H
    FMLA V9.4H, V30.4H, V5.H[0x4]
    FMLA V28.2S, V9.2S, V9.S[0x3]
    FACGT  V5.8H, V28.8H, V28.8H
    FACGT  V28.4H, V5.4H, V5.4H
    FABS  V23.8H, V28.8H
    FABD  V7.4S, V23.4S, V23.4S
    FMLA D20, D7, V7.D[0x0]
    FMUL V30.4H, V28.4H, V2.H[0x7]
    FACGE  V7.2D, V3.2D, V31.2D
    FABD  V31.8H, V23.8H, V29.8H
    FSUB  V9.2S, V9.2S, V5.2S
    FACGT  V14.2D, V7.2D, V29.2D
    FMUL D26, D10, V31.D[0x0]
    FADDP D28, V11.2D
    FMLA S22, S7, V0.S[0x1]
    FMULX  V7.8H, V17.8H, V30.8H
    FMUL V2.4S, V26.4S, V10.S[0x1]
    FRECPS  V3.4S, V9.4S, V21.4S
    FMLA V0.2D, V10.2D, V2.D[0x1]
    FDIV  V24.4H, V28.4H, V13.4H
    FSUB  V5.2S, V27.2S, V8.2S
    FMLS D15, D13, V12.D[0x1]
    FRECPS  V30.8H, V15.8H, V17.8H
    FMLS D20, D20, V20.D[0x1]
    FACGE  V31.4H, V30.4H, V20.4H
    FSQRT  V10.2S, V31.2S
    FDIV  V23.8H, V5.8H, V14.8H
    FSQRT  V29.2S, V24.2S
    FNEG  V27.2S, V0.2S
    FADDP  V30.4H, V29.4H, V3.4H
    FRSQRTS  V8.2S, V30.2S, V7.2S
    FABD  V30.2D, V22.2D, V10.2D
    FMULX  V10.2D, V23.2D, V23.2D
    FADDP S12, V10.2S
    FRECPE  V23.4H, V27.4H
    FACGE  V11.4S, V12.4S, V8.4S
    FMULX S17, S20, V11.S[0x2]
    FMULX  V26.4S, V17.4S, V30.4S
    FMLS V17.2D, V26.2D, V23.D[0x1]
    FMULX  V28.2D, V10.2D, V14.2D
    FDIV  V7.8H, V21.8H, V30.8H
    FMUL  V22.2D, V22.2D, V24.2D
    FACGT  V27.8H, V16.8H, V28.8H
    FMLS V3.2D, V3.2D, V9.D[0x0]
    FRSQRTE  V12.8H, V24.8H
    FDIV  V8.8H, V12.8H, V20.8H
    FRSQRTS  V30.8H, V24.8H, V25.8H
    FMULX D10, D3, V10.D[0x0]
    FADDP  V24.8H, V19.8H, V12.8H
    FRECPE  V21.2D, V24.2D
    FADDP  V9.2D, V3.2D, V7.2D
    FSUB  V20.4H, V30.4H, V27.4H
    FMUL H7, H4, V15.H[0x1]
    FMLS V16.8H, V12.8H, V6.H[0x2]
    FADDP D5, V7.2D
    FMLS V6.2D, V21.2D, V22.D[0x0]
    FADDP H7, V8.2H
    FMUL S27, S17, V10.S[0x1]
    FRSQRTE  V14.4S, V5.4S
    FMLS  V10.2S, V6.2S, V9.2S
    FMUL D3, D10, V10.D[0x0]
    FSQRT  V30.4H, V3.4H
    FMUL D8, D14, V30.D[0x1]
    FADD  V30.4H, V8.4H, V27.4H
    FSUB  V12.2D, V16.2D, V30.2D
    FMULX S4, S20, V12.S[0x1]
    FACGE  V21.4S, V7.4S, V4.4S
    FSQRT  V17.4S, V15.4S
    FMLA V27.4S, V10.4S, V6.S[0x0]
    FADDP S6, V12.2S
    FRECPS  V15.4H, V28.4H, V9.4H
    FMLS S25, S1, V20.S[0x0]
    FADDP H24, V15.2H
    FADDP S1, V3.2S
    FSUB  V9.2D, V2.2D, V22.2D
    FMLA D7, D1, V1.D[0x0]
    FMOV  V19.2D, #-0.15625000
    FNEG  V14.4S, V7.4S
    FADD  V1.4H, V21.4H, V27.4H
    FABS  V8.4H, V6.4H
    FMOV  V22.4S, #0.21875000
    FDIV  V3.2S, V19.2S, V8.2S
    FMOV  V5.8H, #-31.00000000
    FSQRT  V6.2D, V5.2D
    FADD  V19.2D, V24.2D, V6.2D
    FMULX H7, H3, V5.H[0x5]
    FMLA V8.4H, V9.4H, V14.H[0x2]
    FMULX  V4.4H, V25.4H, V8.4H
    FACGE  V14.8H, V1.8H, V19.8H
    FMULX  V6.8H, V14.8H, V22.8H
    FACGT  V8.4S, V6.4S, V17.4S
    FMUL V10.4H, V4.4H, V4.H[0x0]
    FNEG  V4.4H, V7.4H
    FNEG  V27.4H, V4.4H
    FMUL V16.2D, V8.2D, V8.D[0x0]
    FMLA  V5.8H, V10.8H, V27.8H
    FADD  V6.2S, V5.2S, V16.2S
    FABD  V17.4H, V5.4H, V5.4H
    FMLA S2, S12, V21.S[0x3]
    FACGE  V9.4S, V12.4S, V5.4S
    FSQRT  V25.2S, V20.2S
    FMLA S1, S15, V20.S[0x3]
    FACGE  V3.4S, V6.4S, V14.4S
    FACGT  V24.8H, V30.8H, V24.8H
    FMULX V19.2D, V16.2D, V30.D[0x1]
    FMOV  V21.2D, #-9.50000000
    FACGT  V15.8H, V21.8H, V1.8H
    FMLA V12.2D, V0.2D, V26.D[0x1]
    FMULX  V5.8H, V15.8H, V9.8H
    FMULX V1.2D, V24.2D, V19.D[0x1]
    FMUL S15, S5, V17.S[0x0]
    FADD  V10.2D, V3.2D, V25.2D
    FMOV  V9.4S, #-7.50000000
    FMOV  V19.2S, #-31.00000000
    FMULX D30, D12, V15.D[0x1]
    FSQRT  V24.8H, V19.8H
    FADD  V17.8H, V2.8H, V9.8H
    FDIV  V20.2S, V1.2S, V17.2S
    FADDP D6, V24.2D
    FMLS V14.8H, V26.8H, V6.H[0x1]
    FNEG  V21.8H, V14.8H
    FMUL V2.4H, V30.4H, V12.H[0x6]
    FMULX H27, H3, V15.H[0x5]
    FMULX V15.4H, V2.4H, V10.H[0x0]
    FMLS H24, H15, V7.H[0x3]
    FNEG  V19.4S, V24.4S
    FMOV  V14.2D, #-4.50000000
    FRSQRTE  V3.8H, V20.8H
    FMULX H30, H3, V14.H[0x7]
    FACGT  V17.4H, V21.4H, V19.4H
    FADDP S21, V30.2S
    FMLS V15.2D, V27.2D, V27.D[0x0]
    FMULX D9, D20, V17.D[0x0]
    FMLS V2.2S, V9.2S, V9.S[0x1]
    FMLS  V10.4S, V15.4S, V21.4S
    FMUL V19.8H, V2.8H, V10.H[0x6]
    FADDP D27, V26.2D
    FMULX S3, S16, V16.S[0x3]
    FSQRT  V14.2D, V27.2D
    FRECPE  V15.2S, V22.2S
    FABD  V9.4S, V27.4S, V15.4S
    FMULX V1.2D, V12.2D, V8.D[0x0]
    FMLS S2, S5, V17.S[0x3]
    FRECPS  V16.2D, V14.2D, V7.2D
    FMLS H8, H28, V1.H[0x5]
    FMLS V26.4H, V11.4H, V8.H[0x3]
    FMOV  V20.8H, #16.00000000
    FNEG  V8.4H, V14.4H
    FNEG  V22.4H, V0.4H
    FRSQRTE  V11.4S, V2.4S
    FMULX  V12.4H, V9.4H, V22.4H
    FMUL  V7.4H, V3.4H, V11.4H
    FMLA  V0.4H, V12.4H, V19.4H
    FABS  V10.8H, V23.8H
    FMLS V15.2D, V16.2D, V12.D[0x0]
    FADD  V21.8H, V20.8H, V8.8H
    FMLA H14, H7, V7.H[0x7]
    FMOV  V7.2D, #0.23437500
    FMULX V22.2S, V0.2S, V26.S[0x3]
    FACGT  V23.4S, V14.4S, V10.4S
    FMLA V8.2D, V23.2D, V15.D[0x0]
    FSQRT  V2.4S, V22.4S
    FACGE  V26.4S, V2.4S, V21.4S
    FRSQRTE  V15.4S, V26.4S
    FRSQRTE  V20.2D, V15.2D
    FACGE  V9.4H, V20.4H, V20.4H
    FMLS  V22.4S, V7.4S, V9.4S
    FSQRT  V27.2D, V8.2D
    FMULX V15.8H, V1.8H, V13.H[0x3]
    FABD  V28.2S, V27.2S, V22.2S
    FSQRT  V3.2S, V18.2S
    FMULX S0, S3, V3.S[0x0]
    FMOV  V16.2S, #-7.00000000
    FNEG  V12.4H, V12.4H
    FABD  V3.4S, V15.4S, V27.4S
    FMUL  V21.2S, V28.2S, V16.2S
    FMULX H20, H21, V0.H[0x7]
    FSQRT  V26.2D, V20.2D
    FMUL D20, D12, V3.D[0x1]
    FABD  V12.4H, V26.4H, V26.4H
    FMULX V23.8H, V20.8H, V12.H[0x7]
    FADDP D7, V24.2D
    FNEG  V27.4H, V27.4H
    FSQRT  V28.2S, V31.2S
    FADD  V15.8H, V21.8H, V18.8H
    FACGT  V14.4H, V3.4H, V2.4H
    FMOV  V20.2D, #-0.65625000
    FMUL V21.2S, V21.2S, V20.S[0x2]
    SUBS  X17, X17, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_8
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x1f, LSL #0
    MRS  X8, FPSR
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    FMOV  X8, D0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7df0, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x3ce0, LSL #48
    FMOV  X8, V1.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7df0, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x3ce0, LSL #48
    FMOV  X8, D1
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, D2
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X8, V3.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    FMOV  X8, D3
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #16
    MOVK  X21, #0x8000, LSL #32
    MOVK  X21, #0x8000, LSL #48
    FMOV  X8, D4
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X8, V5.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X8, D5
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X8, D6
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    FMOV  X8, D7
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xd964, LSL #0
    MOVK  X21, #0x9b3, LSL #16
    MOVK  X21, #0x1af5, LSL #32
    MOVK  X21, #0x9f56, LSL #48
    FMOV  X8, D8
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X8, D9
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7c00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7c00, LSL #32
    MOVK  X21, #0x7c00, LSL #48
    FMOV  X8, D10
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7f80, LSL #16
    MOVK  X21, #0x7f80, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x8000, LSL #0
    MOVK  X21, #0x2034, LSL #16
    MOVK  X21, #0x7f80, LSL #48
    FMOV  X8, D11
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, D12
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X8, V13.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X8, D13
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, D14
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X8, D15
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xc0e0, LSL #16
    MOVK  X21, #0xc0e0, LSL #48
    FMOV  X8, D16
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, D17
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X8, V18.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    FMOV  X8, D18
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    MOVK  X21, #0x7e00, LSL #32
    MOVK  X21, #0x7e00, LSL #48
    FMOV  X8, D19
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xbfe5, LSL #48
    FMOV  X8, V20.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xbfe5, LSL #48
    FMOV  X8, D20
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    FMOV  X8, D21
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    MOVK  X21, #0x7fc0, LSL #48
    FMOV  X8, D22
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    MOVK  X21, #0x7e00, LSL #16
    FMOV  X8, D23
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    FMOV  X8, D24
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x5df6, LSL #0
    MOVK  X21, #0x5eb5, LSL #16
    MOVK  X21, #0x5df6, LSL #32
    MOVK  X21, #0x5eb5, LSL #48
    FMOV  X8, D25
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, D26
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x8000, LSL #0
    MOVK  X21, #0x8000, LSL #16
    MOVK  X21, #0x8000, LSL #32
    MOVK  X21, #0xfff8, LSL #48
    FMOV  X8, D27
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x499, LSL #0
    MOVK  X21, #0x1e35, LSL #16
    MOVK  X21, #0x499, LSL #32
    MOVK  X21, #0x1e35, LSL #48
    FMOV  X8, D28
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x5df6, LSL #0
    MOVK  X21, #0x5eb5, LSL #16
    MOVK  X21, #0x5df6, LSL #32
    MOVK  X21, #0x5eb5, LSL #48
    FMOV  X8, D29
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xfc00, LSL #0
    FMOV  X8, D30
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #32
    FMOV  X8, D31
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x15db, LSL #0
    MOVK  X2, #0x4011, LSL #16
    MOVK  X2, #0x188c, LSL #32
    MOVK  X2, #0x1914, LSL #48
    MOVZ  X3, #0x19e2, LSL #0
    MOVK  X3, #0x12b3, LSL #16
    MOVK  X3, #0xfcbd, LSL #32
    MOVK  X3, #0x98a, LSL #48
    MOVZ  X4, #0xa99e, LSL #0
    MOVK  X4, #0x2764, LSL #16
    MOVK  X4, #0xf19f, LSL #32
    MOVK  X4, #0x6690, LSL #48
    MOVZ  X5, #0xffd8, LSL #0
    MOVK  X5, #0xbf6d, LSL #16
    MOVK  X5, #0xb418, LSL #32
    MOVK  X5, #0x4429, LSL #48
    MOVZ  X6, #0xb918, LSL #0
    MOVK  X6, #0x7052, LSL #16
    MOVK  X6, #0x80e8, LSL #32
    MOVK  X6, #0x3821, LSL #48
    MOVZ  X7, #0xb1ea, LSL #0
    MOVK  X7, #0x236, LSL #16
    MOVK  X7, #0xd4df, LSL #32
    MOVK  X7, #0x8d74, LSL #48
    MOVZ  X8, #0xde08, LSL #0
    MOVK  X8, #0xe9bb, LSL #16
    MOVK  X8, #0xbcff, LSL #32
    MOVK  X8, #0xf277, LSL #48
    MOVZ  X10, #0x22c5, LSL #0
    MOVK  X10, #0x22, LSL #16
    MOVK  X10, #0xcf47, LSL #32
    MOVK  X10, #0xdf8e, LSL #48
    MOVZ  X11, #0x1d7d, LSL #0
    MOVK  X11, #0xb98f, LSL #16
    MOVK  X11, #0x4a2b, LSL #32
    MOVK  X11, #0x5fe1, LSL #48
    MOVZ  X12, #0x1a8f, LSL #0
    MOVK  X12, #0x86ec, LSL #16
    MOVK  X12, #0x15be, LSL #32
    MOVK  X12, #0x2aa, LSL #48
    MOVZ  X13, #0xd602, LSL #0
    MOVK  X13, #0x2e80, LSL #16
    MOVK  X13, #0x1701, LSL #32
    MOVK  X13, #0xe348, LSL #48
    MOVZ  X14, #0x2301, LSL #0
    MOVK  X14, #0x85a3, LSL #16
    MOVK  X14, #0xd901, LSL #32
    MOVK  X14, #0x8200, LSL #48
    MOVZ  X15, #0xe56b, LSL #0
    MOVK  X15, #0x98a8, LSL #16
    MOVK  X15, #0xb3cb, LSL #32
    MOVK  X15, #0x43b, LSL #48
    MOVZ  X16, #0x1d50, LSL #0
    MOVK  X16, #0xfe92, LSL #16
    MOVK  X16, #0xc434, LSL #32
    MOVK  X16, #0x548f, LSL #48
    MOVZ  X17, #0xa3f8, LSL #0
    MOVK  X17, #0x7179, LSL #16
    MOVK  X17, #0x5eae, LSL #32
    MOVK  X17, #0x3364, LSL #48
    MOVZ  X18, #0x4217, LSL #0
    MOVK  X18, #0x5639, LSL #16
    MOVK  X18, #0xffc1, LSL #32
    MOVK  X18, #0x4492, LSL #48
    MOVZ  X20, #0xd8c9, LSL #0
    MOVK  X20, #0x710a, LSL #16
    MOVK  X20, #0x19a5, LSL #32
    MOVK  X20, #0x30d4, LSL #48
    MOVZ  X21, #0xecb9, LSL #0
    MOVK  X21, #0xd78e, LSL #16
    MOVK  X21, #0x483, LSL #32
    MOVK  X21, #0xcf9a, LSL #48
    MOVZ  X22, #0xdf01, LSL #0
    MOVK  X22, #0x1c58, LSL #16
    MOVK  X22, #0x383d, LSL #32
    MOVK  X22, #0x8a35, LSL #48
    MOVZ  X23, #0xaafa, LSL #0
    MOVK  X23, #0xbe88, LSL #16
    MOVK  X23, #0x9ecd, LSL #32
    MOVK  X23, #0x3e54, LSL #48
    MOVZ  X24, #0x2d23, LSL #0
    MOVK  X24, #0x19f2, LSL #16
    MOVK  X24, #0x677d, LSL #32
    MOVK  X24, #0x7260, LSL #48
    MOVZ  X25, #0x8db6, LSL #0
    MOVK  X25, #0xe6d7, LSL #16
    MOVK  X25, #0x6e26, LSL #32
    MOVK  X25, #0x6297, LSL #48
    MOVZ  X27, #0x92db, LSL #0
    MOVK  X27, #0x8efd, LSL #16
    MOVK  X27, #0x120b, LSL #32
    MOVK  X27, #0xe99c, LSL #48
    MOVZ  X28, #0xb679, LSL #0
    MOVK  X28, #0xd44a, LSL #16
    MOVK  X28, #0xc4d, LSL #32
    MOVK  X28, #0x199a, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X7
    FMOV  V3.D[1], X28
    FMOV  D4, X25
    FMOV  V4.D[1], X2
    FMOV  D5, X23
    FMOV  V5.D[1], X28
    FMOV  D6, X13
    FMOV  V6.D[1], X18
    FMOV  D7, X20
    FMOV  V7.D[1], X25
    FMOV  D8, X11
    FMOV  V8.D[1], X4
    FMOV  D9, X28
    FMOV  V9.D[1], X3
    FMOV  D10, X16
    FMOV  V10.D[1], X4
    FMOV  D11, X16
    FMOV  V11.D[1], X13
    FMOV  D12, X3
    FMOV  V12.D[1], X25
    FMOV  D13, X13
    FMOV  V13.D[1], X25
    FMOV  D14, X6
    FMOV  V14.D[1], X4
    FMOV  D15, X16
    FMOV  V15.D[1], X18
    FMOV  D16, X14
    FMOV  V16.D[1], X6
    FMOV  D17, X11
    FMOV  V17.D[1], X7
    FMOV  D18, X2
    FMOV  V18.D[1], X2
    FMOV  D19, X21
    FMOV  V19.D[1], X27
    FMOV  D20, X6
    FMOV  V20.D[1], X13
    FMOV  D21, X12
    FMOV  V21.D[1], X21
    FMOV  D22, X3
    FMOV  V22.D[1], X28
    FMOV  D23, X18
    FMOV  V23.D[1], X4
    FMOV  D24, X21
    FMOV  V24.D[1], X14
    FMOV  D25, X20
    FMOV  V25.D[1], X16
    FMOV  D26, X10
    FMOV  V26.D[1], X21
    FMOV  D27, X18
    FMOV  V27.D[1], X23
    FMOV  D28, X5
    FMOV  V28.D[1], X15
    FMOV  D29, X8
    FMOV  V29.D[1], X22
    FMOV  D30, X12
    FMOV  V30.D[1], X12
    FMOV  D31, X6
    FMOV  V31.D[1], X12
    MOVZ  X6, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_9:
    FADDP  V22.8H, V30.8H, V19.8H
    FABS  V20.4H, V27.4H
    FADD  V0.4S, V23.4S, V18.4S
    FADDP D16, V25.2D
    FACGT  V4.2S, V0.2S, V26.2S
    FMLA V2.2D, V31.2D, V28.D[0x0]
    FABS  V7.4H, V24.4H
    FMLA D22, D29, V2.D[0x0]
    FSUB  V6.8H, V21.8H, V21.8H
    FMLS  V31.2S, V16.2S, V6.2S
    FMLA  V19.2D, V31.2D, V4.2D
    FABD  V24.2D, V20.2D, V22.2D
    FMLS V25.4H, V19.4H, V7.H[0x5]
    FMLS  V12.2D, V24.2D, V24.2D
    FADDP H2, V12.2H
    FMOV  V21.2S, #-23.00000000
    FABS  V20.4S, V25.4S
    FMUL  V31.4H, V2.4H, V20.4H
    FSQRT  V19.2D, V31.2D
    FNEG  V0.8H, V19.8H
    FMULX H20, H0, V0.H[0x7]
    FMLA V25.2D, V21.2D, V20.D[0x1]
    FMLA S31, S13, V16.S[0x1]
    FACGE  V26.8H, V15.8H, V15.8H
    FMLA V18.2D, V12.2D, V14.D[0x0]
    FADDP  V12.2D, V18.2D, V13.2D
    FMULX  V28.2S, V8.2S, V14.2S
    FACGT  V19.2S, V8.2S, V16.2S
    FRSQRTE  V6.4S, V23.4S
    FMUL H24, H19, V5.H[0x2]
    FMLS  V5.4H, V7.4H, V30.4H
    FSQRT  V2.8H, V22.8H
    FRSQRTE  V20.2S, V12.2S
    FMUL V0.8H, V31.8H, V5.H[0x1]
    FADDP  V5.2S, V0.2S, V28.2S
    FMLA V21.4H, V20.4H, V5.H[0x4]
    FACGT  V14.2D, V2.2D, V25.2D
    FDIV  V4.2S, V6.2S, V24.2S
    FMLS V19.2D, V26.2D, V21.D[0x0]
    FABD  V0.8H, V14.8H, V19.8H
    FRECPS  V23.8H, V4.8H, V13.8H
    FRSQRTS  V21.4H, V0.4H, V0.4H
    FMLS  V12.4S, V21.4S, V23.4S
    FRSQRTE  V21.4S, V12.4S
    FADD  V12.4H, V16.4H, V3.4H
    FABD  V26.2S, V16.2S, V12.2S
    FSQRT  V7.4S, V23.4S
    FSUB  V16.2S, V19.2S, V7.2S
    FMLA  V19.8H, V18.8H, V12.8H
    FRSQRTS  V0.2D, V5.2D, V8.2D
    FMLS  V22.4H, V16.4H, V1.4H
    FABD  V5.2D, V21.2D, V28.2D
    FMUL V3.8H, V20.8H, V1.H[0x3]
    FMUL H20, H19, V12.H[0x2]
    FADDP  V19.8H, V8.8H, V20.8H
    FMULX V25.2D, V22.2D, V19.D[0x1]
    FMOV  V13.2D, #2.00000000
    FADD  V22.8H, V19.8H, V30.8H
    FADDP H12, V14.2H
    FABD  V20.2D, V1.2D, V6.2D
    FMLA V7.2D, V26.2D, V3.D[0x0]
    FMULX D8, D7, V7.D[0x0]
    FDIV  V19.2D, V12.2D, V12.2D
    FABD  V18.4H, V25.4H, V20.4H
    FACGE  V26.2S, V19.2S, V14.2S
    FMOV  V21.2D, #7.00000000
    FMLS V28.2D, V8.2D, V0.D[0x0]
    FABD  V25.4H, V23.4H, V26.4H
    FABS  V30.4H, V25.4H
    FRECPE  V8.4H, V13.4H
    FMLS S6, S28, V28.S[0x2]
    FACGE  V23.4H, V30.4H, V5.4H
    FADDP  V1.4H, V23.4H, V23.4H
    FMULX D16, D21, V18.D[0x1]
    FADDP  V0.2S, V8.2S, V22.2S
    FRSQRTE  V19.8H, V6.8H
    FMLA V30.2S, V1.2S, V1.S[0x3]
    FABD  V26.4H, V19.4H, V16.4H
    FMUL D14, D0, V26.D[0x1]
    FMLA V21.4S, V30.4S, V14.S[0x3]
    FMLA  V26.4S, V2.4S, V13.4S
    FACGT  V3.2D, V14.2D, V20.2D
    FADDP H25, V14.2H
    FNEG  V20.4S, V26.4S
    FMLA  V28.4S, V8.4S, V28.4S
    FNEG  V26.2S, V13.2S
    FNEG  V8.2S, V23.2S
    FADDP S23, V17.2S
    FMULX V6.8H, V22.8H, V4.H[0x3]
    FMLA D13, D17, V3.D[0x0]
    FADDP  V12.2S, V23.2S, V25.2S
    FNEG  V0.2S, V8.2S
    FMLS  V3.2S, V0.2S, V0.2S
    FMULX  V5.4S, V3.4S, V21.4S
    FADDP  V22.2D, V20.2D, V20.2D
    FRSQRTE  V4.2S, V6.2S
    FMULX  V20.4S, V26.4S, V22.4S
    FADDP H6, V16.2H
    FDIV  V17.4H, V28.4H, V6.4H
    FMOV  V16.4S, #-15.50000000
    FADDP D21, V17.2D
    FMOV  V17.2S, #-6.75000000
    FSQRT  V23.4S, V5.4S
    FMLA  V3.4S, V20.4S, V13.4S
    FMLA  V25.4H, V12.4H, V21.4H
    FMLS V28.8H, V25.8H, V6.H[0x5]
    FMUL S20, S4, V4.S[0x2]
    FADDP H5, V16.2H
    FMOV  V13.2D, #0.24218750
    FRSQRTE  V16.2S, V13.2S
    FMUL V22.8H, V5.8H, V8.H[0x6]
    FMLS  V6.2S, V13.2S, V20.2S
    FDIV  V0.2D, V16.2D, V17.2D
    FMOV  V5.2S, #-1.62500000
    FMLS V8.2S, V23.2S, V5.S[0x3]
    FMLA S21, S3, V15.S[0x2]
    FMUL V20.2D, V29.2D, V6.D[0x0]
    FMUL D13, D22, V28.D[0x0]
    FADDP  V6.2D, V0.2D, V8.2D
    FMLA V15.2D, V6.2D, V6.D[0x0]
    FMULX  V4.8H, V15.8H, V30.8H
    FACGE  V22.4H, V20.4H, V4.4H
    FMUL  V20.2S, V13.2S, V13.2S
    FMOV  V15.8H, #-0.81250000
    FSQRT  V17.8H, V21.8H
    FRECPE  V21.2S, V10.2S
    FDIV  V12.4H, V22.4H, V17.4H
    FMUL V25.8H, V12.8H, V12.H[0x0]
    FMULX S16, S15, V25.S[0x1]
    FRECPE  V22.4H, V16.4H
    FMOV  V23.2S, #0.28125000
    FADDP S15, V20.2S
    FACGE  V10.4H, V21.4H, V15.4H
    FMOV  V29.2D, #-19.00000000
    FMLA  V6.4S, V22.4S, V2.4S
    FABD  V3.4S, V11.4S, V23.4S
    FMULX S16, S6, V3.S[0x0]
    FABD  V17.4S, V10.4S, V14.4S
    FABD  V0.8H, V17.8H, V29.8H
    FRSQRTE  V17.4H, V0.4H
    FRECPE  V28.2S, V17.2S
    FMLA D15, D28, V28.D[0x1]
    FMLA H14, H16, V14.H[0x4]
    FADD  V3.8H, V21.8H, V14.8H
    FMOV  V16.4S, #0.81250000
    FMLA D12, D15, V30.D[0x1]
    FMULX V29.4H, V12.4H, V3.H[0x2]
    FNEG  V15.8H, V29.8H
    FABD  V6.2D, V16.2D, V16.2D
    FMLS  V3.2S, V9.2S, V15.2S
    FRSQRTE  V15.2D, V19.2D
    FMLA  V13.4S, V21.4S, V6.4S
    FRECPE  V19.4S, V27.4S
    FMLS S0, S19, V3.S[0x1]
    FMLA  V12.4S, V0.4S, V3.4S
    FMLA V29.2S, V12.2S, V12.S[0x2]
    FSUB  V20.8H, V29.8H, V15.8H
    FACGE  V9.2S, V20.2S, V13.2S
    FABS  V27.4H, V11.4H
    FMLA  V19.8H, V14.8H, V29.8H
    FACGE  V15.2S, V14.2S, V4.2S
    FMLA V20.8H, V1.8H, V3.H[0x5]
    FMLS H13, H31, V1.H[0x7]
    FMULX V12.2D, V7.2D, V13.D[0x0]
    FADDP  V17.8H, V8.8H, V31.8H
    FDIV  V7.4H, V5.4H, V26.4H
    FACGE  V21.2D, V2.2D, V9.2D
    FMLS V8.2D, V29.2D, V21.D[0x1]
    FMULX V0.4S, V14.4S, V4.S[0x0]
    FADDP  V3.4H, V0.4H, V0.4H
    FMUL  V31.8H, V20.8H, V12.8H
    FMUL S0, S27, V15.S[0x3]
    FADDP H21, V19.2H
    FMULX V11.4S, V17.4S, V17.S[0x0]
    FADDP S4, V0.2S
    FMUL V9.4H, V4.4H, V11.H[0x1]
    FMLA  V16.2S, V3.2S, V9.2S
    FMUL V12.2S, V16.2S, V7.S[0x2]
    FSUB  V6.4H, V12.4H, V12.4H
    FMLA H13, H8, V15.H[0x4]
    FRECPS  V7.2S, V6.2S, V31.2S
    FMLS V8.4S, V7.4S, V21.S[0x2]
    FADDP S15, V13.2S
    FMUL D2, D8, V15.D[0x0]
    FMLS H1, H9, V9.H[0x7]
    FMUL V12.4S, V5.4S, V28.S[0x3]
    FSUB  V16.4H, V4.4H, V28.4H
    FMLA V9.8H, V17.8H, V14.H[0x6]
    FMUL D3, D9, V15.D[0x0]
    FRECPE  V6.2S, V14.2S
    FABS  V8.8H, V9.8H
    FMLS V7.2S, V22.2S, V27.S[0x2]
    FMLA H22, H30, V5.H[0x7]
    FMOV  V5.2S, #14.00000000
    FMUL V13.8H, V1.8H, V3.H[0x0]
    FABD  V31.4S, V13.4S, V6.4S
    FMULX V4.4H, V16.4H, V5.H[0x3]
    FABD  V20.8H, V7.8H, V31.8H
    FACGT  V21.2S, V8.2S, V20.2S
    FACGT  V28.4H, V12.4H, V2.4H
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_9
    MOVZ  X25, #0x15db, LSL #0
    MOVK  X25, #0x4011, LSL #16
    MOVK  X25, #0x188c, LSL #32
    MOVK  X25, #0x1914, LSL #48
    SUB  X12, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x19e2, LSL #0
    MOVK  X25, #0x12b3, LSL #16
    MOVK  X25, #0xfcbd, LSL #32
    MOVK  X25, #0x98a, LSL #48
    SUB  X12, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xa99e, LSL #0
    MOVK  X25, #0x2764, LSL #16
    MOVK  X25, #0xf19f, LSL #32
    MOVK  X25, #0x6690, LSL #48
    SUB  X12, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xffd8, LSL #0
    MOVK  X25, #0xbf6d, LSL #16
    MOVK  X25, #0xb418, LSL #32
    MOVK  X25, #0x4429, LSL #48
    SUB  X12, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xb1ea, LSL #0
    MOVK  X25, #0x236, LSL #16
    MOVK  X25, #0xd4df, LSL #32
    MOVK  X25, #0x8d74, LSL #48
    SUB  X12, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xde08, LSL #0
    MOVK  X25, #0xe9bb, LSL #16
    MOVK  X25, #0xbcff, LSL #32
    MOVK  X25, #0xf277, LSL #48
    SUB  X12, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x22c5, LSL #0
    MOVK  X25, #0x22, LSL #16
    MOVK  X25, #0xcf47, LSL #32
    MOVK  X25, #0xdf8e, LSL #48
    SUB  X12, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x1d7d, LSL #0
    MOVK  X25, #0xb98f, LSL #16
    MOVK  X25, #0x4a2b, LSL #32
    MOVK  X25, #0x5fe1, LSL #48
    SUB  X12, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xd602, LSL #0
    MOVK  X25, #0x2e80, LSL #16
    MOVK  X25, #0x1701, LSL #32
    MOVK  X25, #0xe348, LSL #48
    SUB  X12, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x2301, LSL #0
    MOVK  X25, #0x85a3, LSL #16
    MOVK  X25, #0xd901, LSL #32
    MOVK  X25, #0x8200, LSL #48
    SUB  X12, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xe56b, LSL #0
    MOVK  X25, #0x98a8, LSL #16
    MOVK  X25, #0xb3cb, LSL #32
    MOVK  X25, #0x43b, LSL #48
    SUB  X12, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x1d50, LSL #0
    MOVK  X25, #0xfe92, LSL #16
    MOVK  X25, #0xc434, LSL #32
    MOVK  X25, #0x548f, LSL #48
    SUB  X12, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xa3f8, LSL #0
    MOVK  X25, #0x7179, LSL #16
    MOVK  X25, #0x5eae, LSL #32
    MOVK  X25, #0x3364, LSL #48
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x4217, LSL #0
    MOVK  X25, #0x5639, LSL #16
    MOVK  X25, #0xffc1, LSL #32
    MOVK  X25, #0x4492, LSL #48
    SUB  X12, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xd8c9, LSL #0
    MOVK  X25, #0x710a, LSL #16
    MOVK  X25, #0x19a5, LSL #32
    MOVK  X25, #0x30d4, LSL #48
    SUB  X12, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xecb9, LSL #0
    MOVK  X25, #0xd78e, LSL #16
    MOVK  X25, #0x483, LSL #32
    MOVK  X25, #0xcf9a, LSL #48
    SUB  X12, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xdf01, LSL #0
    MOVK  X25, #0x1c58, LSL #16
    MOVK  X25, #0x383d, LSL #32
    MOVK  X25, #0x8a35, LSL #48
    SUB  X12, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xaafa, LSL #0
    MOVK  X25, #0xbe88, LSL #16
    MOVK  X25, #0x9ecd, LSL #32
    MOVK  X25, #0x3e54, LSL #48
    SUB  X12, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x2d23, LSL #0
    MOVK  X25, #0x19f2, LSL #16
    MOVK  X25, #0x677d, LSL #32
    MOVK  X25, #0x7260, LSL #48
    SUB  X12, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x92db, LSL #0
    MOVK  X25, #0x8efd, LSL #16
    MOVK  X25, #0x120b, LSL #32
    MOVK  X25, #0xe99c, LSL #48
    SUB  X12, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x1f, LSL #0
    MRS  X12, FPSR
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, D0
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    FMOV  X12, D1
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #32
    MOVK  X25, #0x3d8f, LSL #48
    FMOV  X12, D2
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7c08, LSL #0
    MOVK  X25, #0x7c08, LSL #16
    MOVK  X25, #0x3c08, LSL #32
    MOVK  X25, #0x3bd0, LSL #48
    FMOV  X12, D3
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8806, LSL #16
    MOVK  X25, #0xcb59, LSL #48
    FMOV  X12, D4
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x4160, LSL #16
    MOVK  X25, #0x4160, LSL #48
    FMOV  X12, D5
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7f80, LSL #16
    MOVK  X25, #0x7f80, LSL #48
    FMOV  X12, D6
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x4000, LSL #16
    MOVK  X25, #0x4000, LSL #48
    FMOV  X12, D7
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, D8
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, D9
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #32
    FMOV  X12, D10
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x3afc, LSL #16
    FMOV  X12, V11.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7f80, LSL #16
    FMOV  X12, D11
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    MOVK  X25, #0x8000, LSL #48
    FMOV  X12, D12
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, D13
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, D14
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    FMOV  X12, D15
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x82ff, LSL #16
    MOVK  X25, #0xc578, LSL #48
    FMOV  X12, D16
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    FMOV  X12, D17
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7810, LSL #0
    MOVK  X25, #0x7810, LSL #16
    MOVK  X25, #0x3c09, LSL #48
    FMOV  X12, D18
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, V19.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, D19
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, V20.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, D20
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X12, D21
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    FMOV  X12, D22
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x3e90, LSL #16
    MOVK  X25, #0x3e90, LSL #48
    FMOV  X12, D23
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, D24
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, D25
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    MOVK  X25, #0xc000, LSL #48
    FMOV  X12, D26
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, D27
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, D28
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, D29
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x4000, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, D30
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    MOVK  X25, #0x7e00, LSL #16
    MOVK  X25, #0x7e00, LSL #32
    MOVK  X25, #0x7e00, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7f80, LSL #16
    MOVK  X25, #0x7f80, LSL #48
    FMOV  X12, D31
    SUB  X28, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X7
    FMOV  V0.D[1], X22
    FMOV  D1, X15
    FMOV  V1.D[1], X16
    FMOV  D2, X8
    FMOV  V2.D[1], X6
    FMOV  D3, X28
    FMOV  V3.D[1], X23
    FMOV  D4, X27
    FMOV  V4.D[1], X21
    FMOV  D5, X20
    FMOV  V5.D[1], X18
    FMOV  D6, X12
    FMOV  V6.D[1], X11
    FMOV  D7, X24
    FMOV  V7.D[1], X17
    FMOV  D8, X14
    FMOV  V8.D[1], X25
    FMOV  D9, X5
    FMOV  V9.D[1], X25
    FMOV  D10, X25
    FMOV  V10.D[1], X14
    FMOV  D11, X28
    FMOV  V11.D[1], X3
    FMOV  D12, X10
    FMOV  V12.D[1], X18
    FMOV  D13, X14
    FMOV  V13.D[1], X25
    FMOV  D14, X25
    FMOV  V14.D[1], X22
    FMOV  D15, X10
    FMOV  V15.D[1], X13
    FMOV  D16, X23
    FMOV  V16.D[1], X14
    FMOV  D17, X16
    FMOV  V17.D[1], X21
    FMOV  D18, X14
    FMOV  V18.D[1], X28
    FMOV  D19, X14
    FMOV  V19.D[1], X6
    FMOV  D20, X14
    FMOV  V20.D[1], X22
    FMOV  D21, X27
    FMOV  V21.D[1], X28
    FMOV  D22, X5
    FMOV  V22.D[1], X24
    FMOV  D23, X23
    FMOV  V23.D[1], X28
    FMOV  D24, X25
    FMOV  V24.D[1], X23
    FMOV  D25, X22
    FMOV  V25.D[1], X6
    FMOV  D26, X4
    FMOV  V26.D[1], X17
    FMOV  D27, X15
    FMOV  V27.D[1], X17
    FMOV  D28, X21
    FMOV  V28.D[1], X7
    FMOV  D29, X7
    FMOV  V29.D[1], X8
    FMOV  D30, X17
    FMOV  V30.D[1], X8
    FMOV  D31, X4
    FMOV  V31.D[1], X4
    MOVZ  X28, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_10:
    FMUL  V1.4H, V31.4H, V30.4H
    FRECPE  V4.4H, V25.4H
    FADDP D30, V29.2D
    FMLS D23, D1, V4.D[0x1]
    FACGT  V2.2D, V30.2D, V23.2D
    FADDP  V8.4H, V2.4H, V26.4H
    FMLA V12.8H, V28.8H, V8.H[0x0]
    FMULX D14, D27, V27.D[0x0]
    FADD  V1.4H, V12.4H, V14.4H
    FADD  V13.4S, V1.4S, V1.4S
    FMOV  V20.4S, #24.00000000
    FRECPS  V29.8H, V20.8H, V20.8H
    FRSQRTE  V12.8H, V29.8H
    FRECPE  V28.4S, V12.4S
    FRECPE  V30.8H, V28.8H
    FMLA V11.2D, V13.2D, V13.D[0x1]
    FMOV  V27.4S, #12.00000000
    FMULX  V13.8H, V6.8H, V30.8H
    FABS  V4.4H, V3.4H
    FMLA V2.2D, V4.2D, V4.D[0x0]
    FMULX V29.8H, V2.8H, V11.H[0x7]
    FMULX V3.8H, V13.8H, V3.H[0x7]
    FADD  V8.4S, V3.4S, V27.4S
    FMULX  V27.4H, V29.4H, V3.4H
    FRECPE  V14.4H, V27.4H
    FMUL D27, D14, V14.D[0x0]
    FMUL  V1.2S, V27.2S, V27.2S
    FMUL  V29.8H, V28.8H, V15.8H
    FMUL H23, H1, V1.H[0x2]
    FMLS H27, H23, V15.H[0x4]
    FMLA  V30.4H, V29.4H, V8.4H
    FMULX V12.2D, V1.2D, V7.D[0x0]
    FRECPS  V4.4H, V27.4H, V12.4H
    FMLS V3.2S, V30.2S, V30.S[0x0]
    FRECPE  V30.2S, V3.2S
    FADDP D14, V30.2D
    FMOV  V6.2S, #4.75000000
    FMLS S3, S14, V6.S[0x0]
    FADD  V15.4H, V3.4H, V3.4H
    FMUL H23, H4, V15.H[0x6]
    FRSQRTS  V28.4H, V25.4H, V14.4H
    FMLA H3, H17, V8.H[0x3]
    FACGT  V7.4H, V22.4H, V20.4H
    FMLA D29, D17, V5.D[0x1]
    FMULX V8.8H, V4.8H, V15.H[0x0]
    FSUB  V13.2D, V2.2D, V4.2D
    FMOV  V1.2D, #0.22656250
    FNEG  V4.4H, V23.4H
    FMLS S15, S21, V1.S[0x2]
    FMUL  V21.2D, V6.2D, V27.2D
    FADDP H20, V21.2H
    FRSQRTS  V30.4H, V28.4H, V7.4H
    FMULX  V25.2D, V8.2D, V3.2D
    FMULX  V8.8H, V30.8H, V4.8H
    FDIV  V2.8H, V29.8H, V8.8H
    FADDP S7, V25.2S
    FADD  V23.2D, V20.2D, V10.2D
    FMLS V1.2D, V14.2D, V7.D[0x0]
    FACGE  V14.4H, V13.4H, V15.4H
    FMULX V5.2D, V14.2D, V2.D[0x1]
    FMULX V21.4H, V1.4H, V5.H[0x5]
    FACGE  V17.4H, V21.4H, V21.4H
    FRSQRTS  V14.8H, V17.8H, V1.8H
    FMULX V3.4H, V23.4H, V14.H[0x4]
    FSQRT  V5.8H, V3.8H
    FACGE  V30.4H, V19.4H, V19.4H
    FABS  V1.8H, V11.8H
    FMLA S2, S1, V0.S[0x0]
    FSUB  V22.2S, V19.2S, V30.2S
    FADDP S21, V0.2S
    FMLS H7, H26, V1.H[0x0]
    FMULX S17, S7, V31.S[0x3]
    FRSQRTE  V23.2D, V12.2D
    FMULX D14, D1, V18.D[0x0]
    FMOV  V26.2D, #-9.00000000
    FMUL S3, S23, V12.S[0x3]
    FDIV  V13.2D, V5.2D, V20.2D
    FABS  V5.8H, V9.8H
    FMUL  V23.2S, V26.2S, V17.2S
    FMULX  V9.4H, V14.4H, V21.4H
    FABD  V14.2D, V9.2D, V22.2D
    FMULX V17.2D, V2.2D, V2.D[0x0]
    FMUL S2, S23, V23.S[0x3]
    FABD  V11.2D, V3.2D, V3.2D
    FRECPE  V9.2S, V2.2S
    FMLS  V0.8H, V14.8H, V13.8H
    FMLS V26.2D, V0.2D, V5.D[0x1]
    FMLS S22, S17, V9.S[0x3]
    FMLS  V1.2S, V22.2S, V22.2S
    FMLA  V12.4S, V26.4S, V1.4S
    FMLA S14, S11, V30.S[0x3]
    FSQRT  V30.8H, V12.8H
    FMUL  V0.4H, V14.4H, V14.4H
    FMLA V18.4S, V0.4S, V23.S[0x0]
    FADDP  V3.2S, V30.2S, V18.2S
    FSQRT  V11.2D, V13.2D
    FRECPS  V12.4S, V22.4S, V19.4S
    FMLA D0, D31, V15.D[0x0]
    FMUL D7, D9, V14.D[0x0]
    FABD  V14.4S, V26.4S, V21.4S
    FMLS  V15.2S, V18.2S, V19.2S
    FMUL V1.2S, V11.2S, V24.S[0x3]
    FMULX S24, S27, V2.S[0x3]
    FNEG  V2.4S, V11.4S
    FMULX  V20.4H, V15.4H, V2.4H
    FACGT  V11.4H, V12.4H, V10.4H
    FRSQRTS  V5.4H, V24.4H, V24.4H
    FMULX  V31.4S, V13.4S, V5.4S
    FSQRT  V12.2S, V20.2S
    FMULX V23.2D, V0.2D, V1.D[0x0]
    FMUL D22, D14, V14.D[0x1]
    FSUB  V15.2S, V11.2S, V23.2S
    FMLS H9, H15, V14.H[0x1]
    FABS  V27.4S, V31.4S
    FADDP H19, V27.2H
    FMUL H26, H7, V7.H[0x6]
    FABD  V20.2D, V3.2D, V12.2D
    FADDP S30, V20.2S
    FMLS S18, S30, V30.S[0x0]
    FABD  V27.8H, V26.8H, V22.8H
    FMOV  V13.4S, #-7.00000000
    FRECPE  V26.2D, V9.2D
    FMULX  V2.4H, V26.4H, V19.4H
    FMLA S31, S18, V18.S[0x2]
    FMOV  V20.4H, #-0.25000000
    FADDP H9, V27.2H
    FMLS V22.4H, V9.4H, V13.H[0x6]
    FMLS V19.2S, V20.2S, V22.S[0x2]
    FSUB  V30.2D, V19.2D, V19.2D
    FRSQRTE  V21.4H, V30.4H
    FMUL V24.8H, V21.8H, V2.H[0x0]
    FMLS V19.4H, V31.4H, V13.H[0x7]
    FMLA V13.8H, V24.8H, V0.H[0x1]
    FMLA D30, D13, V24.D[0x0]
    FMLA D9, D19, V19.D[0x1]
    FACGT  V20.4H, V9.4H, V9.4H
    FRSQRTE  V7.2S, V20.2S
    FMLS H12, H30, V7.H[0x4]
    FMULX  V20.8H, V0.8H, V24.8H
    FNEG  V7.2S, V23.2S
    FADDP  V13.2S, V6.2S, V29.2S
    FMUL V31.2D, V13.2D, V7.D[0x1]
    FMLA  V9.8H, V19.8H, V10.8H
    FADDP S2, V12.2S
    FMLA H18, H31, V2.H[0x3]
    FMLA V30.8H, V8.8H, V14.H[0x7]
    FMLA V14.2S, V4.2S, V18.S[0x3]
    FADDP S21, V15.2S
    FADDP H8, V22.2H
    FMLS S4, S4, V18.S[0x3]
    FMUL V0.4H, V9.4H, V6.H[0x0]
    FNEG  V18.2S, V9.2S
    FADDP D10, V28.2D
    FABS  V9.4H, V20.4H
    FSUB  V15.4S, V9.4S, V14.4S
    FSQRT  V24.8H, V15.8H
    FRECPS  V19.2D, V24.2D, V30.2D
    FMUL  V12.2S, V21.2S, V21.2S
    FACGT  V6.2D, V4.2D, V19.2D
    FSQRT  V2.4H, V6.4H
    FMOV  V28.4H, #-2.75000000
    FMLS V30.2S, V28.2S, V12.S[0x0]
    FMULX S13, S18, V8.S[0x3]
    FADDP D6, V2.2D
    FACGE  V7.8H, V13.8H, V10.8H
    FMULX V4.8H, V0.8H, V6.H[0x2]
    FMULX V28.2D, V30.2D, V7.D[0x1]
    FMLA V7.4H, V28.4H, V4.H[0x3]
    FMULX  V2.8H, V22.8H, V12.8H
    FMLS V13.4H, V7.4H, V9.H[0x3]
    FRSQRTE  V9.2D, V15.2D
    FRECPS  V31.8H, V2.8H, V3.8H
    FMLA D24, D2, V18.D[0x0]
    FMUL H8, H22, V7.H[0x1]
    FABD  V19.4H, V25.4H, V9.4H
    FMULX V7.4S, V11.4S, V4.S[0x0]
    FABS  V18.8H, V1.8H
    FADDP S22, V12.2S
    FACGE  V0.8H, V10.8H, V5.8H
    FRECPE  V6.2D, V24.2D
    FDIV  V15.2S, V0.2S, V8.2S
    FMLA V28.2D, V22.2D, V13.D[0x1]
    FADDP D30, V15.2D
    FMOV  V15.2S, #0.31250000
    FMLA D22, D10, V7.D[0x1]
    FMUL V10.8H, V22.8H, V15.H[0x2]
    FMLS  V2.2S, V28.2S, V10.2S
    FRECPS  V28.8H, V30.8H, V2.8H
    FMLA D3, D28, V28.D[0x0]
    FMLS V9.4H, V19.4H, V4.H[0x4]
    FACGT  V7.4H, V6.4H, V6.4H
    FMLS  V19.2D, V9.2D, V18.2D
    FMLA  V2.4S, V7.4S, V7.4S
    FADDP D6, V2.2D
    FADD  V8.8H, V3.8H, V3.8H
    FRSQRTE  V7.4S, V31.4S
    FMUL V30.2S, V19.2S, V7.S[0x2]
    FMULX V22.2D, V30.2D, V8.D[0x0]
    FRSQRTE  V5.4S, V12.4S
    FACGT  V9.8H, V22.8H, V2.8H
    SUBS  X28, X28, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_10
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x1f, LSL #0
    MRS  X10, FPSR
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X10, V0.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X10, D0
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #48
    FMOV  X10, D1
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    FMOV  X10, D2
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff0, LSL #48
    FMOV  X10, D3
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    FMOV  X10, D4
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7f80, LSL #16
    MOVK  X7, #0x7f80, LSL #48
    FMOV  X10, V5.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x7f80, LSL #48
    FMOV  X10, D5
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    MOVK  X7, #0x7fc0, LSL #48
    FMOV  X10, D6
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x8000, LSL #0
    MOVK  X7, #0x3f34, LSL #16
    MOVK  X7, #0x8000, LSL #32
    MOVK  X7, #0x3f34, LSL #48
    FMOV  X10, V7.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x8000, LSL #0
    MOVK  X7, #0x2034, LSL #16
    MOVK  X7, #0x8000, LSL #32
    MOVK  X7, #0x2034, LSL #48
    FMOV  X10, D7
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7e00, LSL #48
    FMOV  X10, D8
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, D9
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    FMOV  X10, D10
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xffff, LSL #48
    FMOV  X10, D11
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    FMOV  X10, D12
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x7e00, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    MOVK  X7, #0x7e00, LSL #32
    MOVK  X7, #0x7e00, LSL #48
    FMOV  X10, D13
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    MOVK  X7, #0x4022, LSL #48
    FMOV  X10, D14
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x3ea0, LSL #16
    MOVK  X7, #0x3ea0, LSL #48
    FMOV  X10, D15
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, D16
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x1, LSL #0
    FMOV  X10, D17
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #48
    FMOV  X10, D18
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x7dff, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    MOVK  X7, #0x5000, LSL #32
    MOVK  X7, #0xe0b6, LSL #48
    FMOV  X10, D19
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x7e00, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    MOVK  X7, #0x7e00, LSL #32
    MOVK  X7, #0x7e00, LSL #48
    FMOV  X10, D20
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7fc0, LSL #16
    FMOV  X10, D21
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffef, LSL #48
    FMOV  X10, D22
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x3fe1, LSL #0
    MOVK  X7, #0x7dc1, LSL #16
    MOVK  X7, #0x37e0, LSL #32
    MOVK  X7, #0x7ca0, LSL #48
    FMOV  X10, D23
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    MOVK  X7, #0x7e00, LSL #32
    MOVK  X7, #0x7e00, LSL #48
    FMOV  X10, D24
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x7c08, LSL #0
    MOVK  X7, #0x7c08, LSL #16
    MOVK  X7, #0x3c08, LSL #32
    MOVK  X7, #0x3bd0, LSL #48
    FMOV  X10, D25
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff0, LSL #48
    FMOV  X10, V26.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff0, LSL #48
    FMOV  X10, D26
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xfb8, LSL #16
    MOVK  X7, #0x4000, LSL #32
    MOVK  X7, #0x4054, LSL #48
    FMOV  X10, D27
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x4000, LSL #0
    MOVK  X7, #0x4000, LSL #16
    MOVK  X7, #0x4000, LSL #32
    MOVK  X7, #0x4000, LSL #48
    FMOV  X10, V28.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x4000, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    MOVK  X7, #0x4000, LSL #32
    MOVK  X7, #0x7e00, LSL #48
    FMOV  X10, D28
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x1, LSL #0
    MOVK  X7, #0x7f80, LSL #16
    MOVK  X7, #0x3c60, LSL #48
    FMOV  X10, D29
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x31ad, LSL #0
    MOVK  X7, #0x7db5, LSL #16
    MOVK  X7, #0x8b68, LSL #32
    MOVK  X7, #0xe080, LSL #48
    FMOV  X10, D30
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x4000, LSL #0
    MOVK  X7, #0x4000, LSL #16
    MOVK  X7, #0x4000, LSL #32
    MOVK  X7, #0x4000, LSL #48
    FMOV  X10, V31.D[1]
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X7, #0x4000, LSL #0
    MOVK  X7, #0x7e00, LSL #16
    MOVK  X7, #0x4000, LSL #32
    MOVK  X7, #0x7e00, LSL #48
    FMOV  X10, D31
    SUB  X8, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X22
    FMOV  D2, X24
    FMOV  V2.D[1], X27
    FMOV  D3, X21
    FMOV  V3.D[1], X10
    FMOV  D4, X20
    FMOV  V4.D[1], X27
    FMOV  D5, X14
    FMOV  V5.D[1], X4
    FMOV  D6, X16
    FMOV  V6.D[1], X4
    FMOV  D7, X3
    FMOV  V7.D[1], X25
    FMOV  D8, X2
    FMOV  V8.D[1], X5
    FMOV  D9, X24
    FMOV  V9.D[1], X24
    FMOV  D10, X16
    FMOV  V10.D[1], X24
    FMOV  D11, X24
    FMOV  V11.D[1], X11
    FMOV  D12, X16
    FMOV  V12.D[1], X28
    FMOV  D13, X27
    FMOV  V13.D[1], X24
    FMOV  D14, X20
    FMOV  V14.D[1], X12
    FMOV  D15, X7
    FMOV  V15.D[1], X28
    FMOV  D16, X20
    FMOV  V16.D[1], X4
    FMOV  D17, X3
    FMOV  V17.D[1], X17
    FMOV  D18, X18
    FMOV  V18.D[1], X25
    FMOV  D19, X13
    FMOV  V19.D[1], X7
    FMOV  D20, X23
    FMOV  V20.D[1], X28
    FMOV  D21, X16
    FMOV  V21.D[1], X6
    FMOV  D22, X25
    FMOV  V22.D[1], X14
    FMOV  D23, X13
    FMOV  V23.D[1], X4
    FMOV  D24, X5
    FMOV  V24.D[1], X27
    FMOV  D25, X7
    FMOV  V25.D[1], X27
    FMOV  D26, X17
    FMOV  V26.D[1], X21
    FMOV  D27, X23
    FMOV  V27.D[1], X3
    FMOV  D28, X14
    FMOV  V28.D[1], X2
    FMOV  D29, X22
    FMOV  V29.D[1], X23
    FMOV  D30, X2
    FMOV  V30.D[1], X18
    FMOV  D31, X18
    FMOV  V31.D[1], X16
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_11:
    FRSQRTS  V21.2D, V22.2D, V22.2D
    FMLA V20.8H, V20.8H, V2.H[0x1]
    FADD  V10.2S, V29.2S, V23.2S
    FADDP  V17.8H, V31.8H, V28.8H
    FMLS V22.2D, V21.2D, V27.D[0x0]
    FMULX V16.2D, V25.2D, V30.D[0x0]
    FMULX V20.4S, V22.4S, V20.S[0x3]
    FADDP S13, V24.2S
    FRSQRTE  V27.4S, V17.4S
    FMLS V0.4S, V10.4S, V27.S[0x2]
    FACGT  V23.2D, V26.2D, V16.2D
    FADDP H25, V0.2H
    FRSQRTS  V29.8H, V25.8H, V20.8H
    FADDP  V17.4S, V29.4S, V23.4S
    FMLA D31, D8, V17.D[0x0]
    FMLA  V22.8H, V13.8H, V13.8H
    FMLS H28, H31, V3.H[0x2]
    FMLA S8, S28, V28.S[0x3]
    FADDP H27, V8.2H
    FMULX  V12.8H, V27.8H, V26.8H
    FACGE  V10.4S, V12.4S, V11.4S
    FMUL D2, D10, V14.D[0x1]
    FSQRT  V14.4H, V2.4H
    FMLS V17.4H, V14.4H, V14.H[0x3]
    FMUL  V25.4S, V17.4S, V17.4S
    FMOV  V11.2D, #0.50000000
    FABD  V23.4S, V22.4S, V11.4S
    FMLS  V31.2D, V25.2D, V25.2D
    FMLS S16, S23, V31.S[0x1]
    FMLA H8, H21, V5.H[0x5]
    FRSQRTE  V28.2D, V16.2D
    FSUB  V30.4S, V28.4S, V9.4S
    FMUL V21.8H, V24.8H, V11.H[0x4]
    FMLS V17.8H, V1.8H, V12.H[0x3]
    FMULX V14.2D, V9.2D, V7.D[0x1]
    FADD  V22.2D, V6.2D, V12.2D
    FMULX V0.4H, V9.4H, V3.H[0x5]
    FACGE  V23.2D, V19.2D, V17.2D
    FMLA V7.2D, V5.2D, V11.D[0x1]
    FADD  V29.8H, V3.8H, V28.8H
    FMUL V9.4H, V22.4H, V0.H[0x2]
    FABS  V17.2S, V9.2S
    FMLA V9.4H, V17.4H, V7.H[0x6]
    FMULX V7.8H, V21.8H, V9.H[0x0]
    FMUL  V12.4H, V29.4H, V8.4H
    FMOV  V3.2D, #0.21093750
    FADDP S31, V2.2S
    FMLA S17, S7, V30.S[0x2]
    FMULX H30, H23, V12.H[0x4]
    FADDP H10, V14.2H
    FRSQRTE  V11.4H, V10.4H
    FADDP H28, V11.2H
    FMLA  V1.4S, V28.4S, V3.4S
    FSUB  V28.4H, V1.4H, V31.4H
    FSQRT  V5.4S, V31.4S
    FADD  V19.8H, V30.8H, V17.8H
    FRSQRTE  V31.4S, V19.4S
    FRSQRTE  V10.8H, V31.8H
    FADDP D19, V10.2D
    FMULX D8, D5, V28.D[0x0]
    FMULX V21.2S, V8.2S, V8.S[0x1]
    FSUB  V10.4S, V3.4S, V19.4S
    FADDP  V9.8H, V21.8H, V21.8H
    FMLS  V6.4S, V10.4S, V9.4S
    FMLA H22, H26, V12.H[0x5]
    FMLS S2, S5, V8.S[0x2]
    FNEG  V7.4S, V19.4S
    FMULX S28, S28, V10.S[0x0]
    FDIV  V31.8H, V31.8H, V12.8H
    FRECPE  V9.4H, V0.4H
    FMLS D17, D22, V7.D[0x0]
    FADD  V3.8H, V21.8H, V14.8H
    FMLA V26.2D, V7.2D, V15.D[0x1]
    FSQRT  V8.4H, V31.4H
    FMLS H7, H25, V12.H[0x3]
    FMUL V21.2D, V6.2D, V26.D[0x1]
    FRECPE  V22.2S, V21.2S
    FADDP H5, V8.2H
    FACGE  V10.8H, V5.8H, V22.8H
    FMUL V5.2D, V7.2D, V10.D[0x1]
    FABS  V21.2D, V2.2D
    FABD  V22.4H, V31.4H, V17.4H
    FADDP H0, V23.2H
    FRECPS  V14.4H, V28.4H, V22.4H
    FSUB  V15.2S, V5.2S, V24.2S
    FACGT  V25.4S, V14.4S, V9.4S
    FMOV  V19.4S, #7.50000000
    FMOV  V28.4H, #0.46875000
    FADD  V7.8H, V21.8H, V19.8H
    FADDP  V8.8H, V10.8H, V0.8H
    FMLA S21, S7, V15.S[0x3]
    FSUB  V9.8H, V25.8H, V3.8H
    FMLA S22, S8, V21.S[0x2]
    FDIV  V19.4H, V22.4H, V28.4H
    FMUL H14, H19, V9.H[0x7]
    FMUL H25, H25, V6.H[0x4]
    FSUB  V2.2D, V29.2D, V27.2D
    FMLS D31, D10, V5.D[0x0]
    FMUL V23.2D, V0.2D, V21.D[0x1]
    FNEG  V7.8H, V29.8H
    FRECPS  V29.8H, V3.8H, V2.8H
    FMLA  V8.4S, V9.4S, V28.4S
    FNEG  V24.2S, V26.2S
    FADD  V10.8H, V7.8H, V2.8H
    FMOV  V27.2D, #5.75000000
    FABD  V2.4S, V27.4S, V14.4S
    FRSQRTE  V6.2D, V17.2D
    FDIV  V7.2D, V19.2D, V29.2D
    FMLA V22.2D, V2.2D, V8.D[0x0]
    FRECPE  V8.8H, V25.8H
    FACGE  V17.2D, V22.2D, V22.2D
    FMOV  V21.2D, #-0.65625000
    FRECPE  V5.4H, V24.4H
    FRECPE  V3.4H, V10.4H
    FDIV  V15.8H, V5.8H, V27.8H
    FDIV  V26.8H, V23.8H, V3.8H
    FABD  V23.2S, V6.2S, V31.2S
    FMLA V0.4H, V8.4H, V0.H[0x1]
    FDIV  V31.2D, V7.2D, V26.2D
    FMULX H25, H21, V3.H[0x6]
    FADD  V26.4S, V17.4S, V15.4S
    FMULX V8.8H, V26.8H, V0.H[0x0]
    FMUL  V29.8H, V31.8H, V23.8H
    FRECPE  V23.8H, V25.8H
    FRSQRTS  V7.4S, V8.4S, V8.4S
    FMLS  V6.4H, V29.4H, V23.4H
    FNEG  V23.8H, V6.8H
    FABD  V10.2S, V20.2S, V23.2S
    FMLS V3.8H, V10.8H, V7.H[0x4]
    FRECPE  V23.2S, V6.2S
    FABS  V10.2D, V24.2D
    FMUL V0.4H, V13.4H, V2.H[0x2]
    FMLS V22.4H, V28.4H, V8.H[0x3]
    FABS  V26.8H, V2.8H
    FNEG  V6.2D, V25.2D
    FRSQRTS  V28.2D, V30.2D, V6.2D
    FMLS V31.4S, V4.4S, V15.S[0x3]
    FMUL D15, D3, V1.D[0x1]
    FMULX V29.2S, V23.2S, V29.S[0x1]
    FADDP S21, V30.2S
    FADDP H25, V29.2H
    FRSQRTS  V3.2S, V0.2S, V25.2S
    FMLS V7.4H, V3.4H, V15.H[0x4]
    FMULX  V25.4S, V10.4S, V26.4S
    FMUL V27.8H, V7.8H, V5.H[0x4]
    FADDP H8, V28.2H
    FMOV  V13.2D, #24.00000000
    FMOV  V20.4S, #-2.87500000
    FMULX V15.8H, V27.8H, V8.H[0x0]
    FADDP  V8.2D, V15.2D, V25.2D
    FADD  V23.4H, V31.4H, V20.4H
    FMLA V6.2D, V13.2D, V22.D[0x0]
    FACGT  V2.2D, V21.2D, V24.2D
    FMLS H28, H23, V8.H[0x3]
    FABD  V27.4H, V2.4H, V2.4H
    FMUL V5.2S, V6.2S, V27.S[0x2]
    FMULX D8, D28, V5.D[0x0]
    FABD  V7.4S, V3.4S, V23.4S
    FMUL  V2.2D, V11.2D, V28.2D
    FRSQRTE  V4.8H, V20.8H
    FMLA  V27.2S, V31.2S, V5.2S
    FACGE  V5.8H, V8.8H, V1.8H
    FMUL H31, H17, V6.H[0x2]
    FADD  V8.2D, V26.2D, V18.2D
    FRSQRTE  V3.8H, V7.8H
    FMULX H7, H11, V2.H[0x3]
    FRSQRTS  V1.4S, V13.4S, V5.4S
    FACGT  V28.2D, V26.2D, V18.2D
    FMULX V2.4H, V16.4H, V13.H[0x5]
    FDIV  V21.2D, V1.2D, V8.2D
    FABS  V5.8H, V21.8H
    FMULX S16, S2, V5.S[0x3]
    FSQRT  V20.2D, V28.2D
    FMULX V23.2D, V7.2D, V10.D[0x0]
    FRECPS  V17.2S, V20.2S, V23.2S
    FMUL  V24.8H, V3.8H, V3.8H
    FMLA  V13.4H, V4.4H, V4.4H
    FRECPS  V11.8H, V17.8H, V17.8H
    FMLA V6.4S, V31.4S, V18.S[0x1]
    FABD  V15.2D, V27.2D, V6.2D
    FACGE  V26.2D, V28.2D, V13.2D
    FRSQRTE  V1.2S, V24.2S
    FRSQRTS  V27.4S, V11.4S, V11.4S
    FMULX V2.4S, V15.4S, V16.S[0x3]
    FRECPE  V5.2S, V26.2S
    FRSQRTS  V21.2D, V1.2D, V5.2D
    FRECPS  V17.4H, V21.4H, V21.4H
    FACGE  V3.4S, V17.4S, V27.4S
    FACGE  V10.4H, V2.4H, V3.4H
    FMUL H2, H16, V1.H[0x3]
    FMLA D5, D29, V8.D[0x1]
    FMULX  V7.8H, V5.8H, V9.8H
    FABS  V18.4H, V16.4H
    FRECPE  V23.8H, V14.8H
    FMLS  V26.2S, V21.2S, V17.2S
    FMUL H27, H15, V15.H[0x1]
    FNEG  V11.4H, V20.4H
    FDIV  V21.4S, V5.4S, V14.4S
    FMOV  V16.2D, #2.87500000
    FADDP H1, V10.2H
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_11
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X16, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x1f, LSL #0
    MRS  X16, FPSR
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    FMOV  X16, D3
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X16, D4
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x1, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    MOVK  X15, #0x7f80, LSL #48
    FMOV  X16, D5
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xbd00, LSL #0
    MOVK  X15, #0xbd00, LSL #16
    MOVK  X15, #0xbd00, LSL #32
    MOVK  X15, #0x7e48, LSL #48
    FMOV  X16, V6.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xbd00, LSL #0
    MOVK  X15, #0xbd00, LSL #16
    MOVK  X15, #0xbd00, LSL #32
    MOVK  X15, #0x7e48, LSL #48
    FMOV  X16, D6
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X16, V7.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X16, D7
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4017, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e01, LSL #0
    MOVK  X15, #0x4017, LSL #48
    FMOV  X16, D8
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X16, D9
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X16, D10
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x8000, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0xfff8, LSL #48
    FMOV  X16, D11
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    FMOV  X16, D12
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X16, D13
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X16, D14
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xbd00, LSL #0
    MOVK  X15, #0xbd00, LSL #16
    MOVK  X15, #0xbd00, LSL #32
    MOVK  X15, #0x7e48, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xbd00, LSL #0
    MOVK  X15, #0xbd00, LSL #16
    MOVK  X15, #0xbd00, LSL #32
    MOVK  X15, #0x7e48, LSL #48
    FMOV  X16, D15
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4007, LSL #48
    FMOV  X16, V16.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4007, LSL #48
    FMOV  X16, D16
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X16, D17
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    FMOV  X16, D18
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    FMOV  X16, D19
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X16, V20.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X16, D20
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7fc0, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7f80, LSL #48
    FMOV  X16, D21
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X16, D22
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c00, LSL #0
    MOVK  X15, #0x7c00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7c00, LSL #48
    FMOV  X16, V23.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7c00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7c00, LSL #48
    FMOV  X16, D23
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c00, LSL #0
    MOVK  X15, #0x7c00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7c00, LSL #48
    FMOV  X16, V24.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x42b7, LSL #0
    MOVK  X15, #0x2817, LSL #16
    MOVK  X15, #0x746b, LSL #32
    MOVK  X15, #0x381d, LSL #48
    FMOV  X16, D24
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7fc0, LSL #48
    FMOV  X16, D25
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x7fc0, LSL #48
    FMOV  X16, D26
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x3e40, LSL #0
    FMOV  X16, D27
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X16, V28.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X16, D28
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x3f7f, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x3f7f, LSL #48
    FMOV  X16, D29
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X16, D31
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0xbb6c, LSL #0
    MOVK  X2, #0x674f, LSL #16
    MOVK  X2, #0x2ccf, LSL #32
    MOVK  X2, #0xe482, LSL #48
    MOVZ  X3, #0x9dec, LSL #0
    MOVK  X3, #0x6d64, LSL #16
    MOVK  X3, #0x9cba, LSL #32
    MOVK  X3, #0xe5e4, LSL #48
    MOVZ  X4, #0x15da, LSL #0
    MOVK  X4, #0xc394, LSL #16
    MOVK  X4, #0xe118, LSL #32
    MOVK  X4, #0x9db7, LSL #48
    MOVZ  X5, #0x223d, LSL #0
    MOVK  X5, #0xf039, LSL #16
    MOVK  X5, #0xa00b, LSL #32
    MOVK  X5, #0xc4ac, LSL #48
    MOVZ  X6, #0x5b13, LSL #0
    MOVK  X6, #0x5fae, LSL #16
    MOVK  X6, #0x7b42, LSL #32
    MOVK  X6, #0x6b2a, LSL #48
    MOVZ  X7, #0x1b9c, LSL #0
    MOVK  X7, #0xec60, LSL #16
    MOVK  X7, #0xe119, LSL #32
    MOVK  X7, #0x16a3, LSL #48
    MOVZ  X8, #0xb896, LSL #0
    MOVK  X8, #0xd87, LSL #16
    MOVK  X8, #0x7d1e, LSL #32
    MOVK  X8, #0xacf7, LSL #48
    MOVZ  X10, #0x7479, LSL #0
    MOVK  X10, #0x9c1a, LSL #16
    MOVK  X10, #0x85cc, LSL #32
    MOVK  X10, #0xa370, LSL #48
    MOVZ  X11, #0xac27, LSL #0
    MOVK  X11, #0x657d, LSL #16
    MOVK  X11, #0xc1fe, LSL #32
    MOVK  X11, #0xf307, LSL #48
    MOVZ  X12, #0xfdd7, LSL #0
    MOVK  X12, #0x5332, LSL #16
    MOVK  X12, #0x2615, LSL #32
    MOVK  X12, #0x5a7b, LSL #48
    MOVZ  X13, #0x1958, LSL #0
    MOVK  X13, #0x7ddd, LSL #16
    MOVK  X13, #0x1277, LSL #32
    MOVK  X13, #0x52db, LSL #48
    MOVZ  X14, #0x61f5, LSL #0
    MOVK  X14, #0x2267, LSL #16
    MOVK  X14, #0x5526, LSL #32
    MOVK  X14, #0x6148, LSL #48
    MOVZ  X15, #0x2428, LSL #0
    MOVK  X15, #0x644, LSL #16
    MOVK  X15, #0x4bf, LSL #32
    MOVK  X15, #0x1861, LSL #48
    MOVZ  X16, #0x6151, LSL #0
    MOVK  X16, #0xbebe, LSL #16
    MOVK  X16, #0xf0a4, LSL #32
    MOVK  X16, #0xb4ac, LSL #48
    MOVZ  X17, #0xe3f1, LSL #0
    MOVK  X17, #0x8a25, LSL #16
    MOVK  X17, #0x35af, LSL #32
    MOVK  X17, #0xd746, LSL #48
    MOVZ  X18, #0xab9f, LSL #0
    MOVK  X18, #0x7f4c, LSL #16
    MOVK  X18, #0x908d, LSL #32
    MOVK  X18, #0x6638, LSL #48
    MOVZ  X20, #0x7348, LSL #0
    MOVK  X20, #0xec94, LSL #16
    MOVK  X20, #0x83a3, LSL #32
    MOVK  X20, #0xc393, LSL #48
    MOVZ  X21, #0x676d, LSL #0
    MOVK  X21, #0x61c3, LSL #16
    MOVK  X21, #0x1773, LSL #32
    MOVK  X21, #0x369e, LSL #48
    MOVZ  X22, #0x5009, LSL #0
    MOVK  X22, #0xa822, LSL #16
    MOVK  X22, #0x7234, LSL #32
    MOVK  X22, #0xd19f, LSL #48
    MOVZ  X23, #0xa0a9, LSL #0
    MOVK  X23, #0x45bc, LSL #16
    MOVK  X23, #0x5bed, LSL #32
    MOVK  X23, #0x7561, LSL #48
    MOVZ  X24, #0x9ea4, LSL #0
    MOVK  X24, #0xd769, LSL #16
    MOVK  X24, #0x5adb, LSL #32
    MOVK  X24, #0xc321, LSL #48
    MOVZ  X25, #0x5cc, LSL #0
    MOVK  X25, #0x7bbc, LSL #16
    MOVK  X25, #0xac7d, LSL #32
    MOVK  X25, #0xeb26, LSL #48
    MOVZ  X27, #0xbb95, LSL #0
    MOVK  X27, #0x58f9, LSL #16
    MOVK  X27, #0x7b7f, LSL #32
    MOVK  X27, #0x98d4, LSL #48
    MOVZ  X28, #0x7754, LSL #0
    MOVK  X28, #0xd3f5, LSL #16
    MOVK  X28, #0xf55c, LSL #32
    MOVK  X28, #0xbd8, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X21
    FMOV  D2, X25
    FMOV  V2.D[1], X21
    FMOV  D3, X12
    FMOV  V3.D[1], X3
    FMOV  D4, X18
    FMOV  V4.D[1], X4
    FMOV  D5, X7
    FMOV  V5.D[1], X22
    FMOV  D6, X21
    FMOV  V6.D[1], X21
    FMOV  D7, X2
    FMOV  V7.D[1], X7
    FMOV  D8, X15
    FMOV  V8.D[1], X6
    FMOV  D9, X4
    FMOV  V9.D[1], X7
    FMOV  D10, X25
    FMOV  V10.D[1], X11
    FMOV  D11, X22
    FMOV  V11.D[1], X7
    FMOV  D12, X20
    FMOV  V12.D[1], X24
    FMOV  D13, X7
    FMOV  V13.D[1], X5
    FMOV  D14, X22
    FMOV  V14.D[1], X24
    FMOV  D15, X10
    FMOV  V15.D[1], X14
    FMOV  D16, X28
    FMOV  V16.D[1], X7
    FMOV  D17, X10
    FMOV  V17.D[1], X13
    FMOV  D18, X27
    FMOV  V18.D[1], X28
    FMOV  D19, X16
    FMOV  V19.D[1], X22
    FMOV  D20, X28
    FMOV  V20.D[1], X23
    FMOV  D21, X12
    FMOV  V21.D[1], X20
    FMOV  D22, X28
    FMOV  V22.D[1], X23
    FMOV  D23, X6
    FMOV  V23.D[1], X10
    FMOV  D24, X2
    FMOV  V24.D[1], X27
    FMOV  D25, X14
    FMOV  V25.D[1], X24
    FMOV  D26, X27
    FMOV  V26.D[1], X10
    FMOV  D27, X27
    FMOV  V27.D[1], X10
    FMOV  D28, X15
    FMOV  V28.D[1], X27
    FMOV  D29, X14
    FMOV  V29.D[1], X28
    FMOV  D30, X12
    FMOV  V30.D[1], X12
    FMOV  D31, X13
    FMOV  V31.D[1], X10
    MOVZ  X12, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_12:
    FACGT  V30.4H, V27.4H, V30.4H
    FMUL V16.4H, V28.4H, V3.H[0x6]
    FDIV  V6.4H, V25.4H, V22.4H
    FMLS H8, H23, V6.H[0x7]
    FRSQRTS  V8.8H, V19.8H, V8.8H
    FMUL D0, D16, V29.D[0x1]
    FACGT  V27.2S, V30.2S, V31.2S
    FMULX  V28.8H, V8.8H, V8.8H
    FACGT  V6.2S, V28.2S, V27.2S
    FMUL V29.4S, V0.4S, V6.S[0x0]
    FABD  V12.4S, V29.4S, V29.4S
    FMLA H20, H12, V12.H[0x1]
    FMLS D28, D20, V20.D[0x1]
    FSUB  V0.2D, V24.2D, V28.2D
    FMLA  V31.2S, V0.2S, V0.2S
    FSQRT  V27.2D, V31.2D
    FADD  V24.2D, V27.2D, V26.2D
    FRSQRTS  V29.4H, V23.4H, V28.4H
    FRSQRTS  V26.4H, V18.4H, V23.4H
    FNEG  V23.4H, V11.4H
    FMULX  V9.2D, V6.2D, V23.2D
    FMUL H18, H26, V7.H[0x0]
    FMUL  V25.2D, V5.2D, V21.2D
    FMUL V3.8H, V14.8H, V0.H[0x6]
    FMUL H7, H18, V3.H[0x5]
    FMLA V28.2D, V25.2D, V7.D[0x1]
    FSQRT  V25.8H, V11.8H
    FMOV  V8.4H, #0.46875000
    FABS  V26.4S, V5.4S
    FMUL D31, D28, V30.D[0x1]
    FMLS  V6.4H, V8.4H, V3.4H
    FRSQRTE  V3.2S, V12.2S
    FMLA D11, D23, V7.D[0x1]
    FMUL  V27.4H, V26.4H, V29.4H
    FRSQRTS  V21.2S, V6.2S, V31.2S
    FRECPS  V26.4S, V27.4S, V3.4S
    FRSQRTS  V30.2S, V20.2S, V18.2S
    FSUB  V12.4S, V9.4S, V30.4S
    FMUL V0.2S, V21.2S, V12.S[0x1]
    FMOV  V20.2S, #-0.18750000
    FACGT  V25.8H, V25.8H, V26.8H
    FMULX V12.4H, V25.4H, V11.H[0x3]
    FADDP  V28.8H, V12.8H, V12.8H
    FMUL  V9.4S, V0.4S, V0.4S
    FACGE  V14.4H, V20.4H, V28.4H
    FSQRT  V29.4H, V14.4H
    FDIV  V21.2D, V29.2D, V9.2D
    FMOV  V5.4H, #-0.40625000
    FMUL D8, D21, V5.D[0x0]
    FMOV  V14.2D, #20.00000000
    FMLS S12, S26, V12.S[0x2]
    FMUL  V0.4S, V25.4S, V26.4S
    FMUL  V27.2D, V24.2D, V8.2D
    FMULX V25.2S, V12.2S, V25.S[0x1]
    FMLA V9.2S, V27.2S, V19.S[0x1]
    FMOV  V23.2D, #7.00000000
    FABD  V7.2D, V24.2D, V11.2D
    FMLA H30, H9, V14.H[0x7]
    FADDP H29, V13.2H
    FRECPE  V13.4H, V14.4H
    FDIV  V12.8H, V0.8H, V6.8H
    FADDP S28, V14.2S
    FRSQRTE  V11.8H, V4.8H
    FSQRT  V24.4H, V7.4H
    FRECPE  V20.8H, V13.8H
    FMLS V5.4H, V29.4H, V5.H[0x1]
    FMUL V4.4H, V28.4H, V11.H[0x6]
    FMUL  V0.2S, V24.2S, V5.2S
    FMLA S9, S20, V0.S[0x3]
    FMLS V7.8H, V23.8H, V12.H[0x3]
    FADDP  V14.8H, V30.8H, V8.8H
    FSQRT  V0.4H, V16.4H
    FSQRT  V29.8H, V7.8H
    FABS  V24.8H, V9.8H
    FADD  V6.4H, V4.4H, V14.4H
    FMLA H13, H6, V0.H[0x1]
    FABS  V8.4H, V24.4H
    FMULX D28, D29, V13.D[0x0]
    FSUB  V13.8H, V8.8H, V8.8H
    FMUL V11.4S, V25.4S, V28.S[0x2]
    FACGE  V25.2S, V13.2S, V11.2S
    FRECPS  V12.8H, V17.8H, V14.8H
    FADDP  V11.8H, V8.8H, V27.8H
    FRECPE  V19.4H, V10.4H
    FMLS  V28.4H, V17.4H, V16.4H
    FMLA S7, S14, V2.S[0x0]
    FMOV  V27.2S, #14.00000000
    FACGE  V30.4H, V25.4H, V11.4H
    FADDP  V14.8H, V24.8H, V10.8H
    FADD  V5.4H, V22.4H, V28.4H
    FMLA H6, H15, V15.H[0x2]
    FMLA  V28.2S, V0.2S, V12.2S
    FMUL D22, D7, V5.D[0x0]
    FNEG  V2.2S, V15.2S
    FMLS V29.8H, V4.8H, V4.H[0x4]
    FMUL V11.2S, V30.2S, V4.S[0x1]
    FMULX V9.2S, V19.2S, V6.S[0x0]
    FRSQRTE  V25.4H, V9.4H
    FRSQRTS  V13.8H, V12.8H, V22.8H
    FMULX V6.2S, V28.2S, V13.S[0x0]
    FMLA  V10.2D, V6.2D, V27.2D
    FMLA H8, H10, V2.H[0x2]
    FACGE  V17.4H, V29.4H, V15.4H
    FSQRT  V16.8H, V8.8H
    FMUL S16, S7, V17.S[0x1]
    FMLS  V15.8H, V14.8H, V16.8H
    FACGT  V19.4H, V15.4H, V25.4H
    FSUB  V5.4H, V19.4H, V19.4H
    FMLS H0, H11, V11.H[0x3]
    FADDP S17, V0.2S
    FMULX  V15.8H, V17.8H, V5.8H
    FMUL D16, D9, V29.D[0x1]
    FMUL  V25.4S, V27.4S, V29.4S
    FSQRT  V11.4H, V30.4H
    FNEG  V7.2D, V0.2D
    FMULX S28, S8, V26.S[0x0]
    FMULX D19, D9, V24.D[0x0]
    FMLS V5.8H, V27.8H, V14.H[0x5]
    FMUL  V12.2D, V22.2D, V27.2D
    FMLA D26, D6, V15.D[0x1]
    FMLS V22.8H, V1.8H, V15.H[0x6]
    FRECPE  V15.8H, V10.8H
    FABS  V4.4H, V28.4H
    FACGE  V17.8H, V26.8H, V19.8H
    FMOV  V1.8H, #-0.46875000
    FMLS V29.2D, V25.2D, V12.D[0x0]
    FMLA  V14.8H, V4.8H, V29.8H
    FRECPE  V4.4S, V14.4S
    FMUL V29.2D, V11.2D, V1.D[0x1]
    FMLA  V30.2S, V22.2S, V22.2S
    FACGE  V6.8H, V15.8H, V17.8H
    FMULX  V27.2D, V29.2D, V31.2D
    FACGE  V22.4S, V4.4S, V7.4S
    FABS  V12.2D, V22.2D
    FMUL  V11.2S, V5.2S, V5.2S
    FMLA  V5.8H, V30.8H, V30.8H
    FMLA H31, H6, V11.H[0x0]
    FADDP  V30.8H, V31.8H, V31.8H
    FRSQRTE  V4.2S, V27.2S
    FMULX D6, D4, V4.D[0x0]
    FMULX S7, S6, V12.S[0x0]
    FRECPE  V17.2S, V5.2S
    FNEG  V4.8H, V7.8H
    FRSQRTS  V12.8H, V30.8H, V17.8H
    FMLA S29, S3, V9.S[0x0]
    FRSQRTS  V9.2D, V3.2D, V29.2D
    FDIV  V30.4H, V4.4H, V4.4H
    FMUL  V29.2D, V12.2D, V30.2D
    FMUL H15, H29, V9.H[0x3]
    FMUL D22, D17, V9.D[0x1]
    FMLA S17, S26, V10.S[0x1]
    FMLS D3, D29, V8.D[0x0]
    FABS  V30.4S, V28.4S
    FMUL  V12.4S, V13.4S, V15.4S
    FADDP H11, V7.2H
    FMLS  V6.8H, V3.8H, V31.8H
    FRSQRTE  V4.8H, V27.8H
    FSQRT  V26.4H, V30.4H
    FMLS V5.2D, V26.2D, V9.D[0x1]
    FMUL V3.2S, V28.2S, V14.S[0x3]
    FMUL  V27.2D, V19.2D, V13.2D
    FADD  V7.2S, V29.2S, V3.2S
    FMUL D29, D11, V7.D[0x0]
    FMLA V10.2D, V29.2D, V5.D[0x1]
    FMUL V5.4S, V4.4S, V27.S[0x2]
    FABD  V27.4S, V22.4S, V17.4S
    FMLS V22.4S, V27.4S, V27.S[0x1]
    FNEG  V8.8H, V10.8H
    FMULX H26, H5, V12.H[0x1]
    FNEG  V4.8H, V22.8H
    FMULX S12, S31, V8.S[0x1]
    FSQRT  V15.4H, V6.4H
    FRSQRTS  V3.2D, V12.2D, V15.2D
    FMLA H4, H26, V4.H[0x6]
    FMLS D9, D3, V3.D[0x1]
    FACGT  V0.2D, V9.2D, V9.2D
    FACGT  V11.4S, V0.4S, V0.4S
    FRSQRTE  V30.4S, V11.4S
    FRSQRTS  V11.4H, V4.4H, V30.4H
    FMOV  V3.8H, #23.00000000
    FNEG  V14.8H, V3.8H
    FMLA V19.2D, V23.2D, V30.D[0x1]
    FADDP  V4.4H, V10.4H, V7.4H
    FACGT  V26.4S, V15.4S, V8.4S
    FMULX V0.8H, V12.8H, V5.H[0x2]
    FACGE  V9.4S, V3.4S, V6.4S
    FRSQRTS  V10.8H, V3.8H, V13.8H
    FSUB  V12.2D, V8.2D, V3.2D
    FMLA  V6.2D, V14.2D, V12.2D
    FMLA V13.2S, V0.2S, V6.S[0x1]
    FMULX  V0.2S, V9.2S, V11.2S
    FMLS S30, S19, V10.S[0x0]
    FSQRT  V27.4S, V0.4S
    FMLS  V14.4H, V26.4H, V13.4H
    FACGT  V13.4S, V14.4S, V4.4S
    FMUL D0, D13, V13.D[0x0]
    FACGE  V6.4S, V30.4S, V0.4S
    FADDP D23, V27.2D
    FMLA  V31.8H, V6.8H, V6.8H
    FMLA  V27.4H, V31.4H, V23.4H
    SUBS  X12, X12, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_12
    MOVZ  X10, #0xbb6c, LSL #0
    MOVK  X10, #0x674f, LSL #16
    MOVK  X10, #0x2ccf, LSL #32
    MOVK  X10, #0xe482, LSL #48
    SUB  X3, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x15da, LSL #0
    MOVK  X10, #0xc394, LSL #16
    MOVK  X10, #0xe118, LSL #32
    MOVK  X10, #0x9db7, LSL #48
    SUB  X3, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x223d, LSL #0
    MOVK  X10, #0xf039, LSL #16
    MOVK  X10, #0xa00b, LSL #32
    MOVK  X10, #0xc4ac, LSL #48
    SUB  X3, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x5b13, LSL #0
    MOVK  X10, #0x5fae, LSL #16
    MOVK  X10, #0x7b42, LSL #32
    MOVK  X10, #0x6b2a, LSL #48
    SUB  X3, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x1b9c, LSL #0
    MOVK  X10, #0xec60, LSL #16
    MOVK  X10, #0xe119, LSL #32
    MOVK  X10, #0x16a3, LSL #48
    SUB  X3, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xb896, LSL #0
    MOVK  X10, #0xd87, LSL #16
    MOVK  X10, #0x7d1e, LSL #32
    MOVK  X10, #0xacf7, LSL #48
    SUB  X3, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xac27, LSL #0
    MOVK  X10, #0x657d, LSL #16
    MOVK  X10, #0xc1fe, LSL #32
    MOVK  X10, #0xf307, LSL #48
    SUB  X3, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x1958, LSL #0
    MOVK  X10, #0x7ddd, LSL #16
    MOVK  X10, #0x1277, LSL #32
    MOVK  X10, #0x52db, LSL #48
    SUB  X3, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x61f5, LSL #0
    MOVK  X10, #0x2267, LSL #16
    MOVK  X10, #0x5526, LSL #32
    MOVK  X10, #0x6148, LSL #48
    SUB  X3, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x2428, LSL #0
    MOVK  X10, #0x644, LSL #16
    MOVK  X10, #0x4bf, LSL #32
    MOVK  X10, #0x1861, LSL #48
    SUB  X3, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x6151, LSL #0
    MOVK  X10, #0xbebe, LSL #16
    MOVK  X10, #0xf0a4, LSL #32
    MOVK  X10, #0xb4ac, LSL #48
    SUB  X3, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xe3f1, LSL #0
    MOVK  X10, #0x8a25, LSL #16
    MOVK  X10, #0x35af, LSL #32
    MOVK  X10, #0xd746, LSL #48
    SUB  X3, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xab9f, LSL #0
    MOVK  X10, #0x7f4c, LSL #16
    MOVK  X10, #0x908d, LSL #32
    MOVK  X10, #0x6638, LSL #48
    SUB  X3, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7348, LSL #0
    MOVK  X10, #0xec94, LSL #16
    MOVK  X10, #0x83a3, LSL #32
    MOVK  X10, #0xc393, LSL #48
    SUB  X3, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x676d, LSL #0
    MOVK  X10, #0x61c3, LSL #16
    MOVK  X10, #0x1773, LSL #32
    MOVK  X10, #0x369e, LSL #48
    SUB  X3, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x5009, LSL #0
    MOVK  X10, #0xa822, LSL #16
    MOVK  X10, #0x7234, LSL #32
    MOVK  X10, #0xd19f, LSL #48
    SUB  X3, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xa0a9, LSL #0
    MOVK  X10, #0x45bc, LSL #16
    MOVK  X10, #0x5bed, LSL #32
    MOVK  X10, #0x7561, LSL #48
    SUB  X3, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x9ea4, LSL #0
    MOVK  X10, #0xd769, LSL #16
    MOVK  X10, #0x5adb, LSL #32
    MOVK  X10, #0xc321, LSL #48
    SUB  X3, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x5cc, LSL #0
    MOVK  X10, #0x7bbc, LSL #16
    MOVK  X10, #0xac7d, LSL #32
    MOVK  X10, #0xeb26, LSL #48
    SUB  X3, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7754, LSL #0
    MOVK  X10, #0xd3f5, LSL #16
    MOVK  X10, #0xf55c, LSL #32
    MOVK  X10, #0xbd8, LSL #48
    SUB  X3, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x1f, LSL #0
    MRS  X3, FPSR
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x1, LSL #0
    FMOV  X3, D0
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xb780, LSL #0
    MOVK  X10, #0xb780, LSL #16
    MOVK  X10, #0xb780, LSL #32
    MOVK  X10, #0xb780, LSL #48
    FMOV  X3, V1.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xb780, LSL #0
    MOVK  X10, #0xb780, LSL #16
    MOVK  X10, #0xb780, LSL #32
    MOVK  X10, #0xb780, LSL #48
    FMOV  X3, D1
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xfe00, LSL #16
    MOVK  X10, #0xfe00, LSL #48
    FMOV  X3, D2
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x4dc0, LSL #0
    MOVK  X10, #0x4dc0, LSL #16
    MOVK  X10, #0x4dc0, LSL #32
    MOVK  X10, #0x4dc0, LSL #48
    FMOV  X3, V3.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x4dc0, LSL #0
    MOVK  X10, #0x4dc0, LSL #16
    MOVK  X10, #0x4dc0, LSL #32
    MOVK  X10, #0x4dc0, LSL #48
    FMOV  X3, D3
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x6dcd, LSL #0
    MOVK  X10, #0x7bc0, LSL #16
    MOVK  X10, #0x7e00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X3, D4
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #48
    FMOV  X3, V5.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #48
    FMOV  X3, D5
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X3, V6.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X3, D6
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    MOVK  X10, #0xbde8, LSL #32
    MOVK  X10, #0x7c10, LSL #48
    FMOV  X3, D7
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x4be0, LSL #0
    MOVK  X10, #0x4be0, LSL #16
    MOVK  X10, #0x4be0, LSL #32
    MOVK  X10, #0x4be0, LSL #48
    FMOV  X3, V8.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xedcd, LSL #0
    MOVK  X10, #0x4371, LSL #16
    MOVK  X10, #0x20e6, LSL #32
    MOVK  X10, #0xfbc0, LSL #48
    FMOV  X3, D8
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X3, V9.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, D9
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xcbe0, LSL #0
    MOVK  X10, #0xcbe0, LSL #16
    MOVK  X10, #0xcbe0, LSL #32
    MOVK  X10, #0xcbe0, LSL #48
    FMOV  X3, V10.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xcbe0, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0xcbe0, LSL #32
    MOVK  X10, #0xcbe0, LSL #48
    FMOV  X3, D10
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x3e00, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x3e00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X3, D11
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x1e3e, LSL #0
    MOVK  X10, #0x4d7f, LSL #16
    MOVK  X10, #0x4dc0, LSL #32
    MOVK  X10, #0xcdc0, LSL #48
    FMOV  X3, V12.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xedcd, LSL #0
    MOVK  X10, #0x4371, LSL #16
    MOVK  X10, #0x20e6, LSL #32
    MOVK  X10, #0xfbc0, LSL #48
    FMOV  X3, D12
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    FMOV  X3, D13
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7e00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X3, D14
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X3, D15
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x5e19, LSL #0
    MOVK  X10, #0xbe1a, LSL #16
    MOVK  X10, #0x66ef, LSL #32
    MOVK  X10, #0xbcbe, LSL #48
    FMOV  X3, D16
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    FMOV  X3, D17
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, D18
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xdf20, LSL #16
    MOVK  X10, #0x7fac, LSL #48
    FMOV  X3, V19.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xdf20, LSL #16
    MOVK  X10, #0x7fac, LSL #48
    FMOV  X3, D19
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7c00, LSL #0
    MOVK  X10, #0x7c00, LSL #16
    MOVK  X10, #0x7c00, LSL #32
    MOVK  X10, #0x7c00, LSL #48
    FMOV  X3, V20.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x4034, LSL #48
    FMOV  X3, D20
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    FMOV  X3, V21.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xfc1c, LSL #0
    MOVK  X10, #0x7c51, LSL #16
    MOVK  X10, #0x7dff, LSL #32
    MOVK  X10, #0x3e30, LSL #48
    FMOV  X3, D21
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    MOVK  X10, #0x8000, LSL #32
    MOVK  X10, #0x29a9, LSL #48
    FMOV  X3, D22
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    FMOV  X3, D24
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7f80, LSL #16
    MOVK  X10, #0x7f80, LSL #48
    FMOV  X3, D25
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X3, D26
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7e00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X3, D27
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    FMOV  X3, D28
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xddc1, LSL #16
    MOVK  X10, #0x7af0, LSL #32
    MOVK  X10, #0x39e0, LSL #48
    FMOV  X3, D29
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7f80, LSL #16
    FMOV  X3, D30
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7e00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X3, V31.D[1]
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    MOVK  X10, #0x7e00, LSL #16
    MOVK  X10, #0x7e00, LSL #32
    MOVK  X10, #0x7e00, LSL #48
    FMOV  X3, D31
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X22
    FMOV  V0.D[1], X27
    FMOV  D1, X14
    FMOV  V1.D[1], X18
    FMOV  D2, X11
    FMOV  V2.D[1], X24
    FMOV  D3, X13
    FMOV  V3.D[1], X23
    FMOV  D4, X25
    FMOV  V4.D[1], X20
    FMOV  D5, X28
    FMOV  V5.D[1], X21
    FMOV  D6, X21
    FMOV  V6.D[1], X16
    FMOV  D7, X6
    FMOV  V7.D[1], X15
    FMOV  D8, X18
    FMOV  V8.D[1], X27
    FMOV  D9, X14
    FMOV  V9.D[1], X16
    FMOV  D10, X21
    FMOV  V10.D[1], X24
    FMOV  D11, X22
    FMOV  V11.D[1], X11
    FMOV  D12, X7
    FMOV  V12.D[1], X27
    FMOV  D13, X8
    FMOV  V13.D[1], X7
    FMOV  D14, X23
    FMOV  V14.D[1], X24
    FMOV  D15, X12
    FMOV  V15.D[1], X11
    FMOV  D16, X8
    FMOV  V16.D[1], X21
    FMOV  D17, X28
    FMOV  V17.D[1], X4
    FMOV  D18, X22
    FMOV  V18.D[1], X7
    FMOV  D19, X8
    FMOV  V19.D[1], X13
    FMOV  D20, X21
    FMOV  V20.D[1], X22
    FMOV  D21, X16
    FMOV  V21.D[1], X23
    FMOV  D22, X25
    FMOV  V22.D[1], X21
    FMOV  D23, X15
    FMOV  V23.D[1], X2
    FMOV  D24, X17
    FMOV  V24.D[1], X4
    FMOV  D25, X12
    FMOV  V25.D[1], X7
    FMOV  D26, X21
    FMOV  V26.D[1], X18
    FMOV  D27, X21
    FMOV  V27.D[1], X18
    FMOV  D28, X20
    FMOV  V28.D[1], X12
    FMOV  D29, X11
    FMOV  V29.D[1], X7
    FMOV  D30, X3
    FMOV  V30.D[1], X24
    FMOV  D31, X18
    FMOV  V31.D[1], X28
    MOVZ  X15, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_13:
    FRECPE  V13.4S, V24.4S
    FRECPS  V6.4H, V25.4H, V30.4H
    FABD  V8.2D, V6.2D, V31.2D
    FMLA  V24.2D, V13.2D, V29.2D
    FSQRT  V13.8H, V26.8H
    FMOV  V9.2D, #6.00000000
    FACGE  V6.4H, V28.4H, V13.4H
    FMLS V15.2S, V27.2S, V8.S[0x1]
    FMLA S29, S9, V24.S[0x1]
    FMUL V24.2S, V29.2S, V15.S[0x2]
    FADDP D29, V24.2D
    FMLA V30.2S, V6.2S, V29.S[0x2]
    FADD  V17.2S, V23.2S, V30.2S
    FADDP S23, V21.2S
    FMUL  V26.4H, V7.4H, V25.4H
    FADDP D23, V2.2D
    FMULX D2, D13, V4.D[0x0]
    FMUL H21, H20, V5.H[0x6]
    FRECPE  V4.4H, V4.4H
    FRSQRTE  V29.2D, V8.2D
    FMLS S8, S3, V19.S[0x2]
    FADDP H24, V24.2H
    FNEG  V28.8H, V24.8H
    FABD  V24.2S, V4.2S, V8.2S
    FRSQRTE  V19.2S, V17.2S
    FACGT  V8.4H, V29.4H, V28.4H
    FDIV  V6.8H, V8.8H, V26.8H
    FMLS V30.4H, V24.4H, V2.H[0x6]
    FMLA S24, S30, V6.S[0x3]
    FADDP  V20.2S, V24.2S, V23.2S
    FRECPS  V23.2D, V21.2D, V21.2D
    FNEG  V4.8H, V19.8H
    FABS  V24.8H, V20.8H
    FMUL H28, H24, V4.H[0x6]
    FMLS H9, H23, V5.H[0x6]
    FMLA V29.2D, V28.2D, V9.D[0x0]
    FACGE  V4.2D, V31.2D, V21.2D
    FACGE  V6.8H, V13.8H, V22.8H
    FMUL V21.2S, V16.2S, V7.S[0x3]
    FMLA  V31.2S, V8.2S, V17.2S
    FMLA H3, H24, V14.H[0x6]
    FMUL D28, D1, V13.D[0x1]
    FMLS  V20.2D, V0.2D, V13.2D
    FMULX  V17.8H, V3.8H, V10.8H
    FACGE  V14.2S, V12.2S, V20.2S
    FMLA V20.2D, V19.2D, V21.D[0x0]
    FMLS V30.2D, V24.2D, V28.D[0x0]
    FADDP S24, V25.2S
    FMULX  V12.4H, V17.4H, V4.4H
    FADDP H17, V14.2H
    FMUL V9.4S, V17.4S, V17.S[0x0]
    FMLS V3.2D, V9.2D, V9.D[0x0]
    FMLS S2, S3, V29.S[0x1]
    FRECPS  V9.2D, V2.2D, V12.2D
    FRECPS  V19.8H, V6.8H, V20.8H
    FNEG  V10.2D, V24.2D
    FMLA  V20.8H, V31.8H, V31.8H
    FMLA D7, D20, V21.D[0x0]
    FMLS  V29.4H, V30.4H, V9.4H
    FMLA V9.4S, V7.4S, V18.S[0x2]
    FNEG  V13.4S, V25.4S
    FSUB  V0.2D, V19.2D, V19.2D
    FMULX S17, S10, V13.S[0x2]
    FMLA H28, H17, V10.H[0x6]
    FMUL V17.4H, V29.4H, V8.H[0x2]
    FNEG  V21.4S, V17.4S
    FDIV  V31.4S, V21.4S, V9.4S
    FRECPS  V3.4S, V0.4S, V31.4S
    FRSQRTS  V14.8H, V3.8H, V18.8H
    FMLS V8.2D, V28.2D, V28.D[0x1]
    FABS  V7.2S, V8.2S
    FMULX H1, H7, V7.H[0x4]
    FMUL V24.4H, V1.4H, V1.H[0x5]
    FMLA  V19.4H, V14.4H, V14.4H
    FMULX  V6.8H, V19.8H, V24.8H
    FMUL  V0.4H, V20.4H, V9.4H
    FACGT  V29.2S, V3.2S, V7.2S
    FRSQRTE  V30.8H, V27.8H
    FNEG  V31.2D, V21.2D
    FNEG  V8.4H, V20.4H
    FMLA V25.2S, V18.2S, V15.S[0x0]
    FRECPE  V3.8H, V15.8H
    FRSQRTS  V10.8H, V16.8H, V8.8H
    FACGE  V28.2S, V17.2S, V11.2S
    FMOV  V1.4S, #-0.31250000
    FMULX  V17.8H, V29.8H, V8.8H
    FMLS H11, H6, V1.H[0x2]
    FSQRT  V16.4S, V11.4S
    FMLS  V20.4H, V0.4H, V28.4H
    FNEG  V15.4S, V17.4S
    FMLA H0, H30, V0.H[0x4]
    FMLS V27.4H, V3.4H, V15.H[0x7]
    FACGE  V24.2S, V31.2S, V27.2S
    FMULX V28.4S, V16.4S, V16.S[0x3]
    FSUB  V11.4H, V28.4H, V25.4H
    FMUL D18, D11, V3.D[0x1]
    FSUB  V3.4S, V20.4S, V24.4S
    FMLS  V17.2S, V3.2S, V10.2S
    FMLS V31.4H, V17.4H, V0.H[0x2]
    FRECPS  V29.4H, V18.4H, V31.4H
    FRSQRTE  V15.8H, V26.8H
    FMUL H26, H3, V10.H[0x7]
    FMUL  V30.8H, V2.8H, V3.8H
    FSUB  V6.2D, V19.2D, V22.2D
    FABD  V28.2S, V24.2S, V23.2S
    FMOV  V18.2D, #-9.50000000
    FMLA  V31.8H, V2.8H, V27.8H
    FMULX S0, S24, V3.S[0x0]
    FMULX V21.2D, V29.2D, V6.D[0x1]
    FMULX H10, H15, V0.H[0x5]
    FMUL V17.2D, V26.2D, V31.D[0x1]
    FMLS V19.2S, V10.2S, V17.S[0x1]
    FMLA V6.4S, V1.4S, V28.S[0x1]
    FADDP  V20.4H, V30.4H, V30.4H
    FMLS D25, D20, V21.D[0x1]
    FMLA V17.2D, V6.2D, V25.D[0x1]
    FMLA V10.2D, V18.2D, V19.D[0x1]
    FRSQRTE  V0.2S, V17.2S
    FADDP  V18.4H, V6.4H, V0.4H
    FACGE  V15.4S, V18.4S, V9.4S
    FMULX S31, S10, V10.S[0x1]
    FMLS V19.2S, V31.2S, V31.S[0x2]
    FMLA H3, H15, V15.H[0x3]
    FMUL H17, H19, V3.H[0x7]
    FMLS V26.4S, V1.4S, V17.S[0x2]
    FMLA  V11.2S, V18.2S, V1.2S
    FMULX V17.2D, V3.2D, V31.D[0x0]
    FRECPS  V24.2S, V12.2S, V5.2S
    FMLA D2, D25, V13.D[0x1]
    FRSQRTS  V0.2S, V25.2S, V10.2S
    FMOV  V19.8H, #3.75000000
    FMLA V15.4H, V7.4H, V5.H[0x4]
    FMOV  V10.4S, #0.65625000
    FRECPE  V6.2S, V2.2S
    FACGE  V29.2S, V24.2S, V6.2S
    FSQRT  V13.4S, V29.4S
    FMLS V20.2D, V21.2D, V17.D[0x1]
    FRECPS  V28.8H, V0.8H, V20.8H
    FMLA V30.2D, V13.2D, V26.D[0x1]
    FMOV  V29.4H, #0.37500000
    FMLS D3, D10, V30.D[0x0]
    FACGE  V12.4H, V19.4H, V11.4H
    FMUL V25.8H, V28.8H, V3.H[0x1]
    FMLS V2.2S, V12.2S, V12.S[0x1]
    FABD  V5.8H, V25.8H, V23.8H
    FADDP D12, V29.2D
    FADDP S0, V2.2S
    FRSQRTS  V26.4S, V5.4S, V5.4S
    FRECPE  V5.2D, V0.2D
    FRECPS  V3.4H, V15.4H, V15.4H
    FMLS V21.4S, V3.4S, V12.S[0x1]
    FMULX V17.4S, V21.4S, V26.S[0x2]
    FMUL  V7.2D, V5.2D, V17.2D
    FMOV  V6.4H, #-0.17968750
    FACGE  V28.4H, V7.4H, V12.4H
    FMLA S13, S18, V7.S[0x0]
    FMUL  V29.2S, V26.2S, V31.2S
    FABS  V20.8H, V14.8H
    FRECPE  V14.8H, V27.8H
    FMUL V21.2D, V10.2D, V7.D[0x1]
    FMLA  V24.8H, V26.8H, V15.8H
    FMUL  V17.8H, V11.8H, V23.8H
    FACGE  V5.2D, V14.2D, V17.2D
    FRECPE  V2.2S, V3.2S
    FMLA V30.4H, V2.4H, V5.H[0x6]
    FMUL V3.2D, V24.2D, V30.D[0x1]
    FMUL D25, D3, V9.D[0x1]
    FMLS S12, S6, V13.S[0x3]
    FSUB  V23.2S, V22.2S, V28.2S
    FADD  V27.8H, V12.8H, V12.8H
    FMLA H19, H21, V15.H[0x0]
    FMLA  V14.4H, V20.4H, V29.4H
    FMLS  V29.2S, V14.2S, V25.2S
    FMUL V10.8H, V19.8H, V13.H[0x4]
    FMLA H0, H27, V10.H[0x2]
    FMUL V19.2D, V23.2D, V29.D[0x0]
    FRSQRTE  V30.4S, V0.4S
    FMLS V0.4S, V30.4S, V30.S[0x3]
    FACGT  V21.4S, V0.4S, V0.4S
    FDIV  V2.4H, V19.4H, V21.4H
    FRSQRTE  V9.4H, V7.4H
    FACGE  V19.2D, V23.2D, V14.2D
    FMULX H5, H4, V13.H[0x6]
    FSUB  V24.2S, V13.2S, V8.2S
    FMLS S28, S29, V15.S[0x2]
    FMLS H31, H10, V12.H[0x6]
    FMULX  V13.4S, V27.4S, V1.4S
    FMLS  V3.2S, V12.2S, V0.2S
    FMLA V1.8H, V19.8H, V5.H[0x1]
    FADD  V0.4S, V28.4S, V13.4S
    FMUL S20, S0, V7.S[0x0]
    FMULX S0, S31, V30.S[0x1]
    FDIV  V6.4H, V3.4H, V2.4H
    FRSQRTE  V3.8H, V1.8H
    FMLS D12, D6, V20.D[0x1]
    FRSQRTS  V27.4H, V31.4H, V9.4H
    FMULX V21.4H, V24.4H, V12.H[0x4]
    FMLA  V13.4H, V3.4H, V3.4H
    FNEG  V14.4H, V13.4H
    FDIV  V23.8H, V14.8H, V17.8H
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_13
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x1f, LSL #0
    MRS  X27, FPSR
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V0.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x4000, LSL #16
    FMOV  X27, D0
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, V1.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xbea0, LSL #16
    MOVK  X28, #0xbea0, LSL #48
    FMOV  X27, D1
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D2
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, V3.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7c00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7c00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D3
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X27, V4.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X27, D4
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    FMOV  X27, D5
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D6
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xfff0, LSL #48
    FMOV  X27, V7.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7ff0, LSL #48
    FMOV  X27, D7
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x8000, LSL #0
    MOVK  X28, #0xfe00, LSL #16
    MOVK  X28, #0xfe00, LSL #32
    MOVK  X28, #0xfe00, LSL #48
    FMOV  X27, D8
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7c00, LSL #0
    MOVK  X28, #0x7c00, LSL #16
    MOVK  X28, #0x7c00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D9
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V10.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, D10
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0xad40, LSL #0
    MOVK  X28, #0x7db0, LSL #16
    MOVK  X28, #0xad40, LSL #32
    MOVK  X28, #0x7db0, LSL #48
    FMOV  X27, D11
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V12.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x3600, LSL #0
    MOVK  X28, #0x3600, LSL #16
    FMOV  X27, D12
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7c00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7c00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D13
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0xfc00, LSL #0
    MOVK  X28, #0xfe00, LSL #16
    MOVK  X28, #0xfc00, LSL #32
    MOVK  X28, #0xfe00, LSL #48
    FMOV  X27, D14
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D15
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0xfdfc, LSL #0
    MOVK  X28, #0x1dfd, LSL #16
    FMOV  X27, D16
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x8000, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x8000, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D17
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V18.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D18
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  X27, V19.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, D19
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V20.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    FMOV  X27, D20
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D21
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, D22
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, V23.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x7c00, LSL #0
    MOVK  X28, #0x7e00, LSL #16
    MOVK  X28, #0x7c00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D23
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7fc0, LSL #16
    MOVK  X28, #0xfe00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D24
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, D25
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xff7f, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xff7f, LSL #48
    FMOV  X27, V26.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xff7f, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xff7f, LSL #48
    FMOV  X27, D26
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x3e00, LSL #0
    MOVK  X28, #0x3e00, LSL #16
    MOVK  X28, #0x3e00, LSL #32
    MOVK  X28, #0x7e00, LSL #48
    FMOV  X27, D27
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, D28
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    MOVK  X28, #0x8000, LSL #48
    FMOV  X27, D29
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7f80, LSL #16
    MOVK  X28, #0x7f80, LSL #48
    FMOV  X27, V30.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7f80, LSL #16
    MOVK  X28, #0x7f80, LSL #48
    FMOV  X27, D30
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X27, D31
    SUB  X13, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X20
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X17
    FMOV  D3, X20
    FMOV  V3.D[1], X3
    FMOV  D4, X6
    FMOV  V4.D[1], X6
    FMOV  D5, X18
    FMOV  V5.D[1], X16
    FMOV  D6, X17
    FMOV  V6.D[1], X13
    FMOV  D7, X12
    FMOV  V7.D[1], X24
    FMOV  D8, X15
    FMOV  V8.D[1], X16
    FMOV  D9, X18
    FMOV  V9.D[1], X7
    FMOV  D10, X23
    FMOV  V10.D[1], X22
    FMOV  D11, X8
    FMOV  V11.D[1], X23
    FMOV  D12, X16
    FMOV  V12.D[1], X18
    FMOV  D13, X8
    FMOV  V13.D[1], X10
    FMOV  D14, X25
    FMOV  V14.D[1], X4
    FMOV  D15, X14
    FMOV  V15.D[1], X24
    FMOV  D16, X27
    FMOV  V16.D[1], X15
    FMOV  D17, X2
    FMOV  V17.D[1], X23
    FMOV  D18, X5
    FMOV  V18.D[1], X5
    FMOV  D19, X8
    FMOV  V19.D[1], X12
    FMOV  D20, X2
    FMOV  V20.D[1], X6
    FMOV  D21, X18
    FMOV  V21.D[1], X18
    FMOV  D22, X21
    FMOV  V22.D[1], X3
    FMOV  D23, X23
    FMOV  V23.D[1], X24
    FMOV  D24, X11
    FMOV  V24.D[1], X15
    FMOV  D25, X24
    FMOV  V25.D[1], X13
    FMOV  D26, X3
    FMOV  V26.D[1], X16
    FMOV  D27, X23
    FMOV  V27.D[1], X8
    FMOV  D28, X28
    FMOV  V28.D[1], X6
    FMOV  D29, X12
    FMOV  V29.D[1], X7
    FMOV  D30, X14
    FMOV  V30.D[1], X16
    FMOV  D31, X3
    FMOV  V31.D[1], X12
    MOVZ  X5, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_14:
    FMLS  V4.4S, V23.4S, V22.4S
    FMULX V10.4S, V28.4S, V26.S[0x1]
    FABS  V0.2D, V24.2D
    FACGT  V21.4H, V10.4H, V4.4H
    FMLS V30.2D, V21.2D, V27.D[0x1]
    FMLS  V30.8H, V20.8H, V29.8H
    FMLA  V14.4H, V25.4H, V25.4H
    FSQRT  V10.2D, V0.2D
    FRSQRTE  V0.4S, V10.4S
    FMULX  V24.8H, V0.8H, V31.8H
    FMLS  V1.8H, V24.8H, V30.8H
    FNEG  V22.2S, V1.2S
    FMOV  V5.2D, #0.23437500
    FMUL V10.2D, V22.2D, V30.D[0x1]
    FMUL  V23.2S, V5.2S, V16.2S
    FMUL V1.8H, V23.8H, V10.H[0x1]
    FMLS H21, H18, V14.H[0x1]
    FADDP H16, V21.2H
    FMLA V18.2D, V1.2D, V1.D[0x0]
    FRECPS  V1.8H, V16.8H, V16.8H
    FMULX V5.2S, V18.2S, V1.S[0x3]
    FMUL  V16.2S, V5.2S, V17.2S
    FMLA  V30.2D, V22.2D, V0.2D
    FRSQRTS  V18.2S, V31.2S, V26.2S
    FMUL H21, H10, V8.H[0x0]
    FSUB  V17.2D, V2.2D, V19.2D
    FMLS D20, D13, V26.D[0x1]
    FMLS V19.2D, V8.2D, V10.D[0x0]
    FMUL V14.2D, V24.2D, V12.D[0x1]
    FRECPE  V5.2D, V16.2D
    FMULX V13.2D, V5.2D, V5.D[0x0]
    FSUB  V28.4H, V6.4H, V16.4H
    FRSQRTS  V1.2S, V28.2S, V13.2S
    FMLS V24.4S, V19.4S, V6.S[0x0]
    FMULX V28.8H, V1.8H, V6.H[0x4]
    FSUB  V8.2S, V30.2S, V14.2S
    FMLA D30, D17, V17.D[0x0]
    FACGT  V31.4H, V18.4H, V18.4H
    FABS  V19.4S, V20.4S
    FADD  V20.8H, V28.8H, V24.8H
    FRSQRTS  V18.4H, V20.4H, V31.4H
    FMLA  V2.4H, V21.4H, V8.4H
    FMULX D28, D25, V18.D[0x0]
    FMULX D17, D28, V31.D[0x0]
    FMUL D16, D17, V30.D[0x0]
    FRSQRTS  V13.2D, V19.2D, V16.2D
    FRSQRTS  V20.8H, V2.8H, V13.8H
    FMLA D25, D28, V3.D[0x1]
    FMLS V19.4H, V13.4H, V9.H[0x5]
    FMOV  V17.4H, #-0.28125000
    FRECPS  V18.2S, V0.2S, V11.2S
    FMLA  V30.8H, V25.8H, V17.8H
    FRECPS  V0.2S, V27.2S, V23.2S
    FMLA V12.2D, V31.2D, V10.D[0x0]
    FRECPS  V31.2S, V6.2S, V6.2S
    FMULX  V25.4S, V28.4S, V2.4S
    FRSQRTS  V17.2S, V23.2S, V3.2S
    FMLS S16, S30, V16.S[0x2]
    FMULX V14.8H, V20.8H, V12.H[0x6]
    FMOV  V24.4S, #0.20312500
    FMLA  V9.4H, V25.4H, V18.4H
    FRSQRTS  V8.4S, V16.4S, V0.4S
    FRECPE  V23.4H, V19.4H
    FMULX V18.4H, V17.4H, V14.H[0x0]
    FMLS V28.2D, V24.2D, V31.D[0x0]
    FMLS D12, D28, V19.D[0x1]
    FADDP H10, V8.2H
    FRSQRTS  V3.2D, V9.2D, V23.2D
    FADDP H21, V3.2H
    FRECPS  V3.2D, V21.2D, V21.2D
    FMUL D8, D10, V18.D[0x1]
    FRSQRTS  V25.8H, V8.8H, V22.8H
    FRSQRTS  V23.2S, V12.2S, V12.2S
    FMLS V27.2S, V4.2S, V25.S[0x0]
    FMLS D13, D3, V27.D[0x1]
    FDIV  V14.2D, V24.2D, V23.2D
    FABD  V21.4H, V14.4H, V14.4H
    FABD  V14.4H, V21.4H, V13.4H
    FACGT  V18.2D, V13.2D, V12.2D
    FMLS V10.2D, V14.2D, V5.D[0x1]
    FADDP S9, V6.2S
    FMLA S8, S9, V4.S[0x2]
    FMLS V16.2D, V12.2D, V16.D[0x0]
    FMUL H19, H19, V14.H[0x3]
    FABD  V0.4H, V12.4H, V0.4H
    FSQRT  V22.8H, V17.8H
    FADDP S23, V3.2S
    FADDP S25, V10.2S
    FACGE  V27.4H, V23.4H, V12.4H
    FADDP  V24.4H, V20.4H, V17.4H
    FMLS V23.2D, V18.2D, V25.D[0x1]
    FMULX H10, H8, V0.H[0x3]
    FSUB  V14.2S, V16.2S, V16.2S
    FACGT  V12.2D, V19.2D, V19.2D
    FABS  V25.8H, V12.8H
    FMLA D4, D27, V22.D[0x0]
    FDIV  V19.4S, V4.4S, V3.4S
    FMLS V3.4H, V24.4H, V10.H[0x4]
    FABD  V13.8H, V14.8H, V13.8H
    FSUB  V5.4H, V7.4H, V13.4H
    FMLS D6, D5, V5.D[0x1]
    FMLS V21.8H, V6.8H, V2.H[0x2]
    FMULX D6, D19, V21.D[0x0]
    FMUL H20, H3, V6.H[0x3]
    FRECPS  V0.4H, V25.4H, V25.4H
    FMULX D18, D20, V20.D[0x1]
    FNEG  V24.4S, V23.4S
    FMULX  V16.8H, V24.8H, V18.8H
    FDIV  V21.4H, V16.4H, V16.4H
    FMUL V12.2S, V0.2S, V21.S[0x3]
    FMLA H17, H7, V5.H[0x1]
    FMUL V23.2D, V12.2D, V31.D[0x0]
    FRSQRTE  V20.4S, V12.4S
    FMULX  V24.4H, V3.4H, V4.4H
    FSQRT  V5.2S, V21.2S
    FMOV  V0.8H, #7.00000000
    FMULX  V12.8H, V7.8H, V31.8H
    FRECPE  V16.2D, V22.2D
    FABD  V2.2S, V1.2S, V16.2S
    FSUB  V1.2S, V11.2S, V15.2S
    FMLS H25, H1, V1.H[0x6]
    FMLA  V31.4H, V5.4H, V23.4H
    FMOV  V18.2D, #-0.15625000
    FADDP D6, V20.2D
    FMUL S21, S0, V17.S[0x1]
    FMLA V5.2D, V12.2D, V31.D[0x0]
    FMULX S7, S24, V25.S[0x0]
    FADDP H10, V7.2H
    FMLA S4, S2, V2.S[0x1]
    FMLS S31, S21, V18.S[0x1]
    FNEG  V19.8H, V10.8H
    FNEG  V22.4S, V19.4S
    FDIV  V18.2D, V22.2D, V5.2D
    FABD  V29.4H, V6.4H, V6.4H
    FACGE  V12.2D, V4.2D, V29.2D
    FADD  V0.4S, V31.4S, V12.4S
    FMULX  V21.2D, V27.2D, V22.2D
    FADDP D5, V6.2D
    FMLA  V23.4S, V21.4S, V0.4S
    FMLA  V10.2S, V18.2S, V23.2S
    FABS  V6.4H, V10.4H
    FMOV  V4.8H, #0.26562500
    FMULX H23, H4, V4.H[0x7]
    FMLS S2, S6, V5.S[0x1]
    FRECPE  V5.4S, V2.4S
    FMLA  V22.4S, V5.4S, V5.4S
    FMOV  V29.4H, #28.00000000
    FMLA V0.4S, V23.4S, V1.S[0x0]
    FADDP  V19.4H, V29.4H, V22.4H
    FMLS  V10.2S, V19.2S, V19.2S
    FMLS S27, S0, V0.S[0x2]
    FMLA  V0.2S, V19.2S, V27.2S
    FMUL V4.2S, V0.2S, V10.S[0x0]
    FMLS D18, D16, V22.D[0x0]
    FADD  V29.4H, V14.4H, V4.4H
    FMLS V19.8H, V25.8H, V7.H[0x6]
    FRSQRTS  V0.2S, V31.2S, V20.2S
    FRSQRTE  V2.8H, V24.8H
    FMLA V23.4H, V27.4H, V7.H[0x3]
    FMLA S24, S17, V14.S[0x1]
    FMULX S27, S25, V3.S[0x2]
    FMLS V20.8H, V28.8H, V6.H[0x5]
    FSUB  V1.4H, V0.4H, V18.4H
    FSQRT  V16.2S, V29.2S
    FMULX H10, H16, V2.H[0x5]
    FADDP S22, V24.2S
    FMLA S14, S1, V23.S[0x3]
    FMULX V29.2S, V10.2S, V19.S[0x0]
    FADDP S3, V20.2S
    FMULX V1.2D, V3.2D, V0.D[0x1]
    FMUL V5.2D, V27.2D, V22.D[0x1]
    FADDP D19, V1.2D
    FMLS  V20.2D, V19.2D, V14.2D
    FADD  V23.8H, V29.8H, V20.8H
    FABS  V4.4H, V5.4H
    FADDP D20, V4.2D
    FRECPE  V3.2D, V23.2D
    FMULX V29.2S, V3.2S, V3.S[0x0]
    FADD  V14.8H, V29.8H, V29.8H
    FMUL S2, S20, V20.S[0x2]
    FMOV  V27.8H, #22.00000000
    FMOV  V4.2D, #-23.00000000
    FMUL V24.2D, V27.2D, V4.D[0x0]
    FRSQRTS  V4.4H, V2.4H, V2.4H
    FMOV  V28.2D, #1.56250000
    FABD  V7.2D, V24.2D, V28.2D
    FNEG  V1.4H, V4.4H
    FDIV  V3.4S, V7.4S, V1.4S
    FMUL V0.2S, V3.2S, V3.S[0x3]
    FMLA V3.2S, V14.2S, V0.S[0x2]
    FRSQRTE  V23.4H, V0.4H
    FADDP H5, V2.2H
    FMLA V19.4S, V6.4S, V8.S[0x3]
    FABS  V4.8H, V8.8H
    FMULX S8, S16, V22.S[0x2]
    FNEG  V1.4H, V12.4H
    FADDP H28, V11.2H
    FMLA D10, D11, V10.D[0x0]
    FMULX D27, D20, V10.D[0x1]
    FMUL V29.8H, V5.8H, V1.H[0x3]
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_14
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X17, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x1f, LSL #0
    MRS  X17, FPSR
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xff80, LSL #16
    MOVK  X16, #0xff80, LSL #48
    FMOV  X17, D0
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    MOVK  X16, #0x8000, LSL #16
    MOVK  X16, #0x8000, LSL #32
    MOVK  X16, #0x8000, LSL #48
    FMOV  X17, D1
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x185f, LSL #0
    MOVK  X16, #0xf0e7, LSL #16
    MOVK  X16, #0x4913, LSL #32
    MOVK  X16, #0xcf46, LSL #48
    FMOV  X17, D3
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X17, D4
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D5
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #48
    FMOV  X17, D6
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x6f68, LSL #0
    MOVK  X16, #0x6f68, LSL #16
    MOVK  X16, #0x6f68, LSL #32
    MOVK  X16, #0x4dc7, LSL #48
    FMOV  X17, V7.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x6f68, LSL #0
    MOVK  X16, #0x6f68, LSL #16
    MOVK  X16, #0x6f68, LSL #32
    MOVK  X16, #0x4dc7, LSL #48
    FMOV  X17, D7
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X17, D9
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    FMOV  X17, D10
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X17, V11.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X17, D11
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X17, V12.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7e00, LSL #48
    FMOV  X17, D13
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X17, V15.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X17, D15
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x4f4, LSL #0
    MOVK  X16, #0x5eb5, LSL #16
    MOVK  X16, #0x4f4, LSL #32
    MOVK  X16, #0x5eb5, LSL #48
    FMOV  X17, D16
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x7c00, LSL #0
    FMOV  X17, D17
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xc000, LSL #0
    MOVK  X16, #0x863c, LSL #16
    MOVK  X16, #0xd000, LSL #32
    MOVK  X16, #0xea60, LSL #48
    FMOV  X17, D18
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #48
    FMOV  X17, D19
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    FMOV  X17, D21
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7e00, LSL #16
    FMOV  X17, D22
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x7c00, LSL #0
    MOVK  X16, #0x7e00, LSL #16
    MOVK  X16, #0x7c00, LSL #32
    MOVK  X16, #0x7e00, LSL #48
    FMOV  X17, D23
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x6f68, LSL #0
    MOVK  X16, #0x6f68, LSL #16
    MOVK  X16, #0x6f68, LSL #32
    MOVK  X16, #0xcdc7, LSL #48
    FMOV  X17, V24.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x6f68, LSL #0
    MOVK  X16, #0x6f68, LSL #16
    MOVK  X16, #0x6f68, LSL #32
    MOVK  X16, #0xcdc7, LSL #48
    FMOV  X17, D24
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X17, V26.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X17, D26
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X17, D28
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    MOVK  X16, #0x8000, LSL #16
    MOVK  X16, #0x8000, LSL #32
    MOVK  X16, #0x8000, LSL #48
    FMOV  X17, V29.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    MOVK  X16, #0x8000, LSL #16
    MOVK  X16, #0x8000, LSL #32
    MOVK  X16, #0x8000, LSL #48
    FMOV  X17, D29
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7e00, LSL #48
    FMOV  X17, D30
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4000, LSL #16
    FMOV  X17, D31
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0xd3b7, LSL #0
    MOVK  X2, #0xcb30, LSL #16
    MOVK  X2, #0xf856, LSL #32
    MOVK  X2, #0xefda, LSL #48
    MOVZ  X3, #0x302a, LSL #0
    MOVK  X3, #0x7d1c, LSL #16
    MOVK  X3, #0x5f78, LSL #32
    MOVK  X3, #0x118b, LSL #48
    MOVZ  X4, #0x4513, LSL #0
    MOVK  X4, #0xe1e, LSL #16
    MOVK  X4, #0x7885, LSL #32
    MOVK  X4, #0x14e9, LSL #48
    MOVZ  X5, #0x53b8, LSL #0
    MOVK  X5, #0x22a6, LSL #16
    MOVK  X5, #0x9c6d, LSL #32
    MOVK  X5, #0x88e5, LSL #48
    MOVZ  X6, #0x7118, LSL #0
    MOVK  X6, #0x142, LSL #16
    MOVK  X6, #0x53a0, LSL #32
    MOVK  X6, #0xe950, LSL #48
    MOVZ  X7, #0xbb80, LSL #0
    MOVK  X7, #0x819a, LSL #16
    MOVK  X7, #0xbf63, LSL #32
    MOVK  X7, #0x5ea6, LSL #48
    MOVZ  X8, #0x9da1, LSL #0
    MOVK  X8, #0x852f, LSL #16
    MOVK  X8, #0x1ca2, LSL #32
    MOVK  X8, #0x9db6, LSL #48
    MOVZ  X10, #0xb06a, LSL #0
    MOVK  X10, #0x41b3, LSL #16
    MOVK  X10, #0x2996, LSL #32
    MOVK  X10, #0x88ad, LSL #48
    MOVZ  X11, #0x7d20, LSL #0
    MOVK  X11, #0xc7d9, LSL #16
    MOVK  X11, #0xd325, LSL #32
    MOVK  X11, #0x3750, LSL #48
    MOVZ  X12, #0x23cd, LSL #0
    MOVK  X12, #0x9d2a, LSL #16
    MOVK  X12, #0x3426, LSL #32
    MOVK  X12, #0xf604, LSL #48
    MOVZ  X13, #0x8a94, LSL #0
    MOVK  X13, #0xa144, LSL #16
    MOVK  X13, #0xc3bf, LSL #32
    MOVK  X13, #0x93eb, LSL #48
    MOVZ  X14, #0xe236, LSL #0
    MOVK  X14, #0x799c, LSL #16
    MOVK  X14, #0x868b, LSL #32
    MOVK  X14, #0xbb62, LSL #48
    MOVZ  X15, #0x5c52, LSL #0
    MOVK  X15, #0x1640, LSL #16
    MOVK  X15, #0x2186, LSL #32
    MOVK  X15, #0x1e63, LSL #48
    MOVZ  X16, #0x20fd, LSL #0
    MOVK  X16, #0xa37, LSL #16
    MOVK  X16, #0x82a8, LSL #32
    MOVK  X16, #0x8f71, LSL #48
    MOVZ  X17, #0x19e9, LSL #0
    MOVK  X17, #0xe13, LSL #16
    MOVK  X17, #0xfabb, LSL #32
    MOVK  X17, #0xf521, LSL #48
    MOVZ  X18, #0xf5a8, LSL #0
    MOVK  X18, #0x7010, LSL #16
    MOVK  X18, #0x12c5, LSL #32
    MOVK  X18, #0x5b9, LSL #48
    MOVZ  X20, #0x550e, LSL #0
    MOVK  X20, #0x7e4a, LSL #16
    MOVK  X20, #0x1bba, LSL #32
    MOVK  X20, #0xe43a, LSL #48
    MOVZ  X21, #0x8423, LSL #0
    MOVK  X21, #0x9c09, LSL #16
    MOVK  X21, #0xa53, LSL #32
    MOVK  X21, #0xf056, LSL #48
    MOVZ  X22, #0x91ea, LSL #0
    MOVK  X22, #0xe409, LSL #16
    MOVK  X22, #0x5a4b, LSL #32
    MOVK  X22, #0xe793, LSL #48
    MOVZ  X23, #0x89af, LSL #0
    MOVK  X23, #0x294b, LSL #16
    MOVK  X23, #0x6655, LSL #32
    MOVK  X23, #0xa882, LSL #48
    MOVZ  X24, #0x87c1, LSL #0
    MOVK  X24, #0x7216, LSL #16
    MOVK  X24, #0xe3ad, LSL #32
    MOVK  X24, #0x56a8, LSL #48
    MOVZ  X25, #0x93ab, LSL #0
    MOVK  X25, #0x5ed4, LSL #16
    MOVK  X25, #0x4e2d, LSL #32
    MOVK  X25, #0x2692, LSL #48
    MOVZ  X27, #0xe9c7, LSL #0
    MOVK  X27, #0xa6a2, LSL #16
    MOVK  X27, #0xcbf4, LSL #32
    MOVK  X27, #0x4eb1, LSL #48
    MOVZ  X28, #0xcbf9, LSL #0
    MOVK  X28, #0x8fa1, LSL #16
    MOVK  X28, #0x15b2, LSL #32
    MOVK  X28, #0x2f56, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X23
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X24
    FMOV  V2.D[1], X20
    FMOV  D3, X18
    FMOV  V3.D[1], X20
    FMOV  D4, X25
    FMOV  V4.D[1], X3
    FMOV  D5, X28
    FMOV  V5.D[1], X6
    FMOV  D6, X14
    FMOV  V6.D[1], X25
    FMOV  D7, X21
    FMOV  V7.D[1], X2
    FMOV  D8, X15
    FMOV  V8.D[1], X7
    FMOV  D9, X13
    FMOV  V9.D[1], X28
    FMOV  D10, X13
    FMOV  V10.D[1], X25
    FMOV  D11, X17
    FMOV  V11.D[1], X7
    FMOV  D12, X7
    FMOV  V12.D[1], X14
    FMOV  D13, X28
    FMOV  V13.D[1], X6
    FMOV  D14, X27
    FMOV  V14.D[1], X28
    FMOV  D15, X25
    FMOV  V15.D[1], X13
    FMOV  D16, X15
    FMOV  V16.D[1], X14
    FMOV  D17, X27
    FMOV  V17.D[1], X11
    FMOV  D18, X14
    FMOV  V18.D[1], X10
    FMOV  D19, X6
    FMOV  V19.D[1], X11
    FMOV  D20, X13
    FMOV  V20.D[1], X18
    FMOV  D21, X15
    FMOV  V21.D[1], X18
    FMOV  D22, X20
    FMOV  V22.D[1], X24
    FMOV  D23, X8
    FMOV  V23.D[1], X23
    FMOV  D24, X23
    FMOV  V24.D[1], X11
    FMOV  D25, X10
    FMOV  V25.D[1], X7
    FMOV  D26, X8
    FMOV  V26.D[1], X4
    FMOV  D27, X8
    FMOV  V27.D[1], X2
    FMOV  D28, X21
    FMOV  V28.D[1], X6
    FMOV  D29, X25
    FMOV  V29.D[1], X4
    FMOV  D30, X2
    FMOV  V30.D[1], X3
    FMOV  D31, X17
    FMOV  V31.D[1], X11
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_15:
    FADDP D24, V22.2D
    FABD  V15.2D, V29.2D, V21.2D
    FMUL V15.8H, V31.8H, V15.H[0x7]
    FRSQRTS  V16.2D, V30.2D, V26.2D
    FMLA S17, S15, V24.S[0x1]
    FRSQRTS  V16.4S, V16.4S, V16.4S
    FMLA  V10.8H, V17.8H, V27.8H
    FACGE  V12.4S, V16.4S, V10.4S
    FDIV  V6.2D, V28.2D, V12.2D
    FMLS D27, D23, V6.D[0x1]
    FADDP  V22.2D, V27.2D, V27.2D
    FMOV  V15.4S, #-2.00000000
    FABS  V23.8H, V22.8H
    FMLS S6, S15, V23.S[0x2]
    FDIV  V17.4H, V6.4H, V25.4H
    FMLA  V24.4H, V14.4H, V31.4H
    FABS  V29.4H, V17.4H
    FMUL S17, S5, V9.S[0x0]
    FADDP H30, V18.2H
    FMLS V11.2D, V3.2D, V23.D[0x1]
    FMLS S21, S8, V25.S[0x0]
    FMLA V18.8H, V8.8H, V15.H[0x5]
    FRSQRTE  V14.2D, V15.2D
    FMUL S23, S3, V31.S[0x1]
    FADDP  V25.4H, V11.4H, V13.4H
    FRSQRTE  V9.4S, V25.4S
    FRSQRTE  V22.2S, V9.2S
    FMLS S25, S23, V22.S[0x1]
    FMULX D15, D14, V18.D[0x1]
    FABD  V8.2S, V30.2S, V21.2S
    FMUL H6, H17, V13.H[0x3]
    FABD  V17.4H, V12.4H, V24.4H
    FSQRT  V3.8H, V29.8H
    FADD  V22.4H, V3.4H, V3.4H
    FADD  V11.4H, V6.4H, V25.4H
    FMLA  V9.8H, V15.8H, V17.8H
    FMUL S17, S8, V22.S[0x0]
    FSUB  V5.8H, V11.8H, V9.8H
    FADDP  V14.4S, V5.4S, V17.4S
    FMLS V23.2D, V9.2D, V27.D[0x0]
    FADDP  V19.8H, V12.8H, V26.8H
    FMLA V29.2D, V13.2D, V18.D[0x0]
    FRECPE  V31.4S, V10.4S
    FMLA  V10.2D, V1.2D, V31.2D
    FMULX  V24.4S, V15.4S, V23.4S
    FRECPE  V1.8H, V12.8H
    FMLA  V5.2D, V0.2D, V3.2D
    FMUL  V9.2D, V27.2D, V11.2D
    FMUL V26.2S, V18.2S, V8.S[0x0]
    FMULX  V22.4S, V10.4S, V14.4S
    FMULX  V6.2S, V22.2S, V24.2S
    FMLS V21.2D, V6.2D, V6.D[0x0]
    FMLA V31.4H, V1.4H, V5.H[0x2]
    FADDP S25, V19.2S
    FRSQRTS  V19.4H, V29.4H, V25.4H
    FMOV  V27.2S, #-0.17187500
    FMUL  V17.8H, V27.8H, V19.8H
    FNEG  V8.4H, V17.4H
    FADDP H23, V8.2H
    FMLA H19, H31, V1.H[0x2]
    FRECPS  V6.4S, V21.4S, V21.4S
    FMULX D11, D26, V23.D[0x1]
    FADD  V8.8H, V11.8H, V9.8H
    FABD  V27.4H, V11.4H, V8.4H
    FRECPE  V12.4H, V31.4H
    FADDP  V8.4S, V6.4S, V12.4S
    FMLS V29.4H, V8.4H, V8.H[0x3]
    FMULX V17.8H, V4.8H, V1.H[0x4]
    FMOV  V22.8H, #0.12500000
    FMOV  V24.2D, #0.17187500
    FMLA H23, H19, V2.H[0x7]
    FMULX D25, D23, V17.D[0x0]
    FMLA V26.2S, V27.2S, V3.S[0x2]
    FMOV  V1.2S, #0.40625000
    FMLS D12, D1, V29.D[0x1]
    FADDP D8, V24.2D
    FADDP  V6.4H, V25.4H, V22.4H
    FADDP S24, V12.2S
    FMULX  V22.4H, V24.4H, V8.4H
    FMUL V3.2D, V26.2D, V26.D[0x0]
    FMLS  V24.8H, V22.8H, V6.8H
    FRSQRTS  V31.8H, V24.8H, V3.8H
    FMUL V4.4S, V3.4S, V22.S[0x0]
    FABD  V11.4S, V8.4S, V31.4S
    FADDP  V31.8H, V15.8H, V8.8H
    FMULX  V27.4S, V6.4S, V12.4S
    FNEG  V3.2S, V14.2S
    FRSQRTS  V8.4H, V4.4H, V18.4H
    FACGE  V2.8H, V3.8H, V20.8H
    FACGE  V25.4H, V28.4H, V30.4H
    FMOV  V22.2D, #-0.21875000
    FMLA V24.2S, V7.2S, V18.S[0x1]
    FMLA  V20.4H, V13.4H, V9.4H
    FDIV  V1.8H, V25.8H, V20.8H
    FSUB  V30.4H, V8.4H, V8.4H
    FRECPS  V9.4H, V22.4H, V1.4H
    FMLS H26, H31, V9.H[0x5]
    FMLS D13, D11, V24.D[0x0]
    FADD  V28.4H, V27.4H, V2.4H
    FMUL D31, D30, V13.D[0x0]
    FMLA  V3.8H, V29.8H, V26.8H
    FABD  V14.4S, V28.4S, V3.4S
    FABS  V8.8H, V25.8H
    FSUB  V20.4S, V31.4S, V8.4S
    FSQRT  V29.2S, V14.2S
    FMLS  V7.2S, V20.2S, V29.2S
    FMUL S4, S17, V0.S[0x0]
    FMLS H8, H5, V12.H[0x4]
    FRSQRTE  V26.2S, V15.2S
    FRECPE  V1.8H, V29.8H
    FRECPS  V5.4H, V17.4H, V9.4H
    FSQRT  V11.4H, V8.4H
    FRSQRTE  V8.8H, V22.8H
    FMLA  V20.2D, V31.2D, V1.2D
    FMUL  V28.2D, V26.2D, V30.2D
    FMLA S14, S2, V16.S[0x2]
    FSQRT  V0.4H, V22.4H
    FMOV  V13.2D, #1.00000000
    FABD  V29.4H, V13.4H, V20.4H
    FMUL V16.2D, V7.2D, V28.D[0x0]
    FSUB  V2.8H, V14.8H, V26.8H
    FMLA  V1.2S, V25.2S, V2.2S
    FMUL V27.2D, V13.2D, V1.D[0x0]
    FMLS V20.2D, V4.2D, V4.D[0x1]
    FMLA  V24.4H, V0.4H, V29.4H
    FRSQRTS  V25.4S, V2.4S, V5.4S
    FMLS D5, D20, V27.D[0x0]
    FRSQRTS  V13.2D, V5.2D, V24.2D
    FMUL V1.2D, V25.2D, V25.D[0x1]
    FMULX D25, D16, V16.D[0x0]
    FMULX V17.4S, V11.4S, V25.S[0x3]
    FMUL V28.4S, V17.4S, V8.S[0x3]
    FMUL  V2.2S, V28.2S, V1.2S
    FMLS  V1.4S, V2.4S, V13.4S
    FMUL S22, S10, V11.S[0x1]
    FMLA H28, H9, V15.H[0x5]
    FNEG  V31.2D, V29.2D
    FRSQRTS  V26.8H, V24.8H, V29.8H
    FMLS V11.2D, V2.2D, V28.D[0x0]
    FMULX V24.2D, V23.2D, V14.D[0x0]
    FACGE  V15.2D, V2.2D, V30.2D
    FMULX H7, H20, V10.H[0x0]
    FMULX V4.8H, V11.8H, V14.H[0x2]
    FMLS S9, S16, V17.S[0x2]
    FACGT  V0.4H, V24.4H, V17.4H
    FDIV  V13.2S, V9.2S, V1.2S
    FMUL H29, H26, V15.H[0x2]
    FMULX  V5.2S, V21.2S, V13.2S
    FMUL V20.2D, V4.2D, V22.D[0x0]
    FSUB  V27.4H, V0.4H, V7.4H
    FMULX  V15.8H, V20.8H, V5.8H
    FMOV  V28.8H, #2.00000000
    FRSQRTS  V23.2D, V29.2D, V31.2D
    FMULX  V13.8H, V28.8H, V15.8H
    FMLA  V30.2S, V27.2S, V27.2S
    FMULX H1, H30, V13.H[0x0]
    FMULX S7, S23, V1.S[0x3]
    FMLS S30, S22, V8.S[0x0]
    FMOV  V2.2S, #-0.12500000
    FADDP D10, V15.2D
    FMLA S5, S17, V10.S[0x2]
    FMULX S1, S13, V3.S[0x0]
    FMULX V29.2S, V25.2S, V18.S[0x0]
    FMULX V3.2D, V27.2D, V29.D[0x1]
    FMLS V29.2S, V24.2S, V17.S[0x3]
    FMOV  V22.2D, #-2.62500000
    FRECPS  V26.4S, V27.4S, V13.4S
    FACGT  V15.8H, V22.8H, V26.8H
    FMUL V11.2D, V30.2D, V15.D[0x1]
    FMULX H25, H5, V3.H[0x0]
    FMLS H23, H25, V7.H[0x7]
    FMUL V22.2D, V29.2D, V3.D[0x0]
    FACGT  V28.2S, V1.2S, V1.2S
    FADDP D13, V11.2D
    FADDP S29, V2.2S
    FMLS D10, D29, V12.D[0x1]
    FACGT  V3.8H, V13.8H, V23.8H
    FMUL D13, D28, V28.D[0x0]
    FRECPE  V11.4H, V13.4H
    FMLA V13.8H, V11.8H, V10.H[0x2]
    FRECPS  V20.2D, V31.2D, V3.2D
    FADD  V26.8H, V13.8H, V22.8H
    FADD  V17.4S, V20.4S, V20.4S
    FRSQRTE  V27.4H, V17.4H
    FNEG  V28.4S, V27.4S
    FRSQRTE  V5.4H, V26.4H
    FMUL  V26.4H, V5.4H, V5.4H
    FMLS S15, S28, V28.S[0x0]
    FMUL V18.8H, V29.8H, V15.H[0x7]
    FMULX H5, H26, V11.H[0x0]
    FSUB  V24.4H, V5.4H, V18.4H
    FADDP D30, V19.2D
    FMUL  V10.4S, V22.4S, V17.4S
    FMLA D17, D16, V6.D[0x1]
    FABD  V6.8H, V15.8H, V17.8H
    FMUL V29.8H, V27.8H, V6.H[0x1]
    FMUL  V26.4H, V9.4H, V18.4H
    FSQRT  V13.4S, V5.4S
    FACGT  V19.2D, V28.2D, V12.2D
    FRSQRTE  V9.4S, V8.4S
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_15
    MOVZ  X22, #0xd3b7, LSL #0
    MOVK  X22, #0xcb30, LSL #16
    MOVK  X22, #0xf856, LSL #32
    MOVK  X22, #0xefda, LSL #48
    SUB  X6, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x302a, LSL #0
    MOVK  X22, #0x7d1c, LSL #16
    MOVK  X22, #0x5f78, LSL #32
    MOVK  X22, #0x118b, LSL #48
    SUB  X6, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x4513, LSL #0
    MOVK  X22, #0xe1e, LSL #16
    MOVK  X22, #0x7885, LSL #32
    MOVK  X22, #0x14e9, LSL #48
    SUB  X6, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x53b8, LSL #0
    MOVK  X22, #0x22a6, LSL #16
    MOVK  X22, #0x9c6d, LSL #32
    MOVK  X22, #0x88e5, LSL #48
    SUB  X6, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x9da1, LSL #0
    MOVK  X22, #0x852f, LSL #16
    MOVK  X22, #0x1ca2, LSL #32
    MOVK  X22, #0x9db6, LSL #48
    SUB  X6, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7d20, LSL #0
    MOVK  X22, #0xc7d9, LSL #16
    MOVK  X22, #0xd325, LSL #32
    MOVK  X22, #0x3750, LSL #48
    SUB  X6, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x23cd, LSL #0
    MOVK  X22, #0x9d2a, LSL #16
    MOVK  X22, #0x3426, LSL #32
    MOVK  X22, #0xf604, LSL #48
    SUB  X6, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x8a94, LSL #0
    MOVK  X22, #0xa144, LSL #16
    MOVK  X22, #0xc3bf, LSL #32
    MOVK  X22, #0x93eb, LSL #48
    SUB  X6, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0xe236, LSL #0
    MOVK  X22, #0x799c, LSL #16
    MOVK  X22, #0x868b, LSL #32
    MOVK  X22, #0xbb62, LSL #48
    SUB  X6, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x5c52, LSL #0
    MOVK  X22, #0x1640, LSL #16
    MOVK  X22, #0x2186, LSL #32
    MOVK  X22, #0x1e63, LSL #48
    SUB  X6, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x20fd, LSL #0
    MOVK  X22, #0xa37, LSL #16
    MOVK  X22, #0x82a8, LSL #32
    MOVK  X22, #0x8f71, LSL #48
    SUB  X6, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x19e9, LSL #0
    MOVK  X22, #0xe13, LSL #16
    MOVK  X22, #0xfabb, LSL #32
    MOVK  X22, #0xf521, LSL #48
    SUB  X6, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0xf5a8, LSL #0
    MOVK  X22, #0x7010, LSL #16
    MOVK  X22, #0x12c5, LSL #32
    MOVK  X22, #0x5b9, LSL #48
    SUB  X6, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x550e, LSL #0
    MOVK  X22, #0x7e4a, LSL #16
    MOVK  X22, #0x1bba, LSL #32
    MOVK  X22, #0xe43a, LSL #48
    SUB  X6, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x8423, LSL #0
    MOVK  X22, #0x9c09, LSL #16
    MOVK  X22, #0xa53, LSL #32
    MOVK  X22, #0xf056, LSL #48
    SUB  X6, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x89af, LSL #0
    MOVK  X22, #0x294b, LSL #16
    MOVK  X22, #0x6655, LSL #32
    MOVK  X22, #0xa882, LSL #48
    SUB  X6, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x87c1, LSL #0
    MOVK  X22, #0x7216, LSL #16
    MOVK  X22, #0xe3ad, LSL #32
    MOVK  X22, #0x56a8, LSL #48
    SUB  X6, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x93ab, LSL #0
    MOVK  X22, #0x5ed4, LSL #16
    MOVK  X22, #0x4e2d, LSL #32
    MOVK  X22, #0x2692, LSL #48
    SUB  X6, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0xe9c7, LSL #0
    MOVK  X22, #0xa6a2, LSL #16
    MOVK  X22, #0xcbf4, LSL #32
    MOVK  X22, #0x4eb1, LSL #48
    SUB  X6, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0xcbf9, LSL #0
    MOVK  X22, #0x8fa1, LSL #16
    MOVK  X22, #0x15b2, LSL #32
    MOVK  X22, #0x2f56, LSL #48
    SUB  X6, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x1f, LSL #0
    MRS  X6, FPSR
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    FMOV  X6, D0
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7f80, LSL #16
    FMOV  X6, D1
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xbe00, LSL #16
    MOVK  X22, #0xbe00, LSL #48
    FMOV  X6, D2
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, D3
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7e00, LSL #0
    FMOV  X6, D4
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7e00, LSL #0
    FMOV  X6, D5
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7e00, LSL #0
    MOVK  X22, #0x7e00, LSL #16
    MOVK  X22, #0x7e00, LSL #48
    FMOV  X6, D6
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7c00, LSL #0
    MOVK  X22, #0x7c00, LSL #16
    MOVK  X22, #0x7c00, LSL #32
    MOVK  X22, #0x7e00, LSL #48
    FMOV  X6, V8.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7c00, LSL #0
    MOVK  X22, #0x7c00, LSL #16
    MOVK  X22, #0x7c00, LSL #32
    MOVK  X22, #0x7e00, LSL #48
    FMOV  X6, D8
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x8000, LSL #0
    MOVK  X22, #0x2134, LSL #16
    MOVK  X22, #0x8000, LSL #32
    MOVK  X22, #0x2034, LSL #48
    FMOV  X6, V9.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x8000, LSL #0
    MOVK  X22, #0x2134, LSL #16
    MOVK  X22, #0x8000, LSL #32
    MOVK  X22, #0x2034, LSL #48
    FMOV  X6, D9
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, D10
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7c00, LSL #0
    MOVK  X22, #0x7c00, LSL #16
    MOVK  X22, #0x7c00, LSL #32
    MOVK  X22, #0x7c00, LSL #48
    FMOV  X6, D11
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7e00, LSL #0
    MOVK  X22, #0x7e00, LSL #16
    MOVK  X22, #0x7e00, LSL #32
    MOVK  X22, #0x7e00, LSL #48
    FMOV  X6, D12
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0xfdfc, LSL #0
    MOVK  X22, #0x1dfd, LSL #16
    FMOV  X6, D13
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x1800, LSL #0
    MOVK  X22, #0x789a, LSL #16
    FMOV  X6, D14
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xff7f, LSL #16
    FMOV  X6, D15
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    FMOV  X6, V16.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff0, LSL #48
    FMOV  X6, D16
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff8, LSL #48
    FMOV  X6, D17
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #16
    FMOV  X6, D18
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X6, V19.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x4000, LSL #48
    FMOV  X6, V20.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x4000, LSL #48
    FMOV  X6, D20
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffef, LSL #48
    FMOV  X6, D21
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x1, LSL #0
    FMOV  X6, D23
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7e00, LSL #0
    FMOV  X6, D24
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7e00, LSL #0
    MOVK  X22, #0x7e00, LSL #16
    FMOV  X6, D26
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7c00, LSL #0
    MOVK  X22, #0x7c00, LSL #16
    MOVK  X22, #0x7c00, LSL #32
    MOVK  X22, #0x3954, LSL #48
    FMOV  X6, D27
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #16
    MOVK  X22, #0x8000, LSL #48
    FMOV  X6, V28.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7c00, LSL #0
    MOVK  X22, #0xfc00, LSL #16
    MOVK  X22, #0x7c00, LSL #32
    MOVK  X22, #0xb954, LSL #48
    FMOV  X6, D28
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7e00, LSL #0
    MOVK  X22, #0x7e00, LSL #16
    MOVK  X22, #0x7e00, LSL #32
    MOVK  X22, #0x7e00, LSL #48
    FMOV  X6, V29.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7e00, LSL #0
    MOVK  X22, #0x7e00, LSL #16
    MOVK  X22, #0x7e00, LSL #32
    MOVK  X22, #0x7e00, LSL #48
    FMOV  X6, D29
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x7e00, LSL #0
    FMOV  X6, D30
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x8000, LSL #48
    FMOV  X6, V31.D[1]
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7e00, LSL #16
    MOVK  X22, #0xfe00, LSL #48
    FMOV  X6, D31
    SUB  X10, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X13
    FMOV  V0.D[1], X7
    FMOV  D1, X8
    FMOV  V1.D[1], X28
    FMOV  D2, X24
    FMOV  V2.D[1], X5
    FMOV  D3, X16
    FMOV  V3.D[1], X14
    FMOV  D4, X6
    FMOV  V4.D[1], X18
    FMOV  D5, X27
    FMOV  V5.D[1], X20
    FMOV  D6, X23
    FMOV  V6.D[1], X25
    FMOV  D7, X22
    FMOV  V7.D[1], X8
    FMOV  D8, X8
    FMOV  V8.D[1], X21
    FMOV  D9, X25
    FMOV  V9.D[1], X6
    FMOV  D10, X17
    FMOV  V10.D[1], X27
    FMOV  D11, X13
    FMOV  V11.D[1], X25
    FMOV  D12, X4
    FMOV  V12.D[1], X13
    FMOV  D13, X12
    FMOV  V13.D[1], X10
    FMOV  D14, X4
    FMOV  V14.D[1], X5
    FMOV  D15, X27
    FMOV  V15.D[1], X22
    FMOV  D16, X28
    FMOV  V16.D[1], X22
    FMOV  D17, X16
    FMOV  V17.D[1], X6
    FMOV  D18, X21
    FMOV  V18.D[1], X13
    FMOV  D19, X12
    FMOV  V19.D[1], X7
    FMOV  D20, X7
    FMOV  V20.D[1], X8
    FMOV  D21, X16
    FMOV  V21.D[1], X2
    FMOV  D22, X15
    FMOV  V22.D[1], X12
    FMOV  D23, X25
    FMOV  V23.D[1], X16
    FMOV  D24, X28
    FMOV  V24.D[1], X18
    FMOV  D25, X4
    FMOV  V25.D[1], X5
    FMOV  D26, X28
    FMOV  V26.D[1], X16
    FMOV  D27, X14
    FMOV  V27.D[1], X25
    FMOV  D28, X20
    FMOV  V28.D[1], X27
    FMOV  D29, X12
    FMOV  V29.D[1], X23
    FMOV  D30, X5
    FMOV  V30.D[1], X17
    FMOV  D31, X11
    FMOV  V31.D[1], X20
    MOVZ  X13, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_16:
    FMOV  V15.2D, #1.00000000
    FSUB  V10.2D, V23.2D, V31.2D
    FMULX D5, D28, V29.D[0x1]
    FABS  V10.4H, V25.4H
    FSUB  V6.4H, V30.4H, V27.4H
    FMLA  V24.8H, V15.8H, V15.8H
    FMUL  V9.4H, V5.4H, V22.4H
    FMULX  V10.4S, V24.4S, V21.4S
    FADDP  V4.4H, V26.4H, V26.4H
    FMLA S17, S6, V4.S[0x0]
    FRSQRTE  V30.2D, V23.2D
    FACGT  V28.2D, V31.2D, V9.2D
    FMLS V29.4S, V28.4S, V17.S[0x3]
    FMOV  V28.2D, #-0.90625000
    FMLS V31.4H, V28.4H, V11.H[0x6]
    FMLS  V15.2D, V30.2D, V29.2D
    FRSQRTS  V11.4H, V15.4H, V31.4H
    FDIV  V6.4H, V10.4H, V10.4H
    FADDP D27, V6.2D
    FMLS V5.4H, V27.4H, V13.H[0x1]
    FABS  V25.8H, V11.8H
    FADDP  V6.4H, V25.4H, V5.4H
    FRSQRTS  V24.4S, V28.4S, V4.4S
    FMLS V17.4S, V9.4S, V6.S[0x1]
    FMUL V11.4H, V12.4H, V10.H[0x6]
    FSQRT  V10.2D, V13.2D
    FMUL S13, S3, V11.S[0x1]
    FMLA  V22.4H, V29.4H, V14.4H
    FMLA D28, D9, V23.D[0x0]
    FMLS  V3.2D, V28.2D, V24.2D
    FMUL D27, D17, V29.D[0x1]
    FSQRT  V26.2D, V8.2D
    FMLA V4.4S, V24.4S, V20.S[0x1]
    FMLA  V8.2D, V0.2D, V15.2D
    FSUB  V29.8H, V8.8H, V22.8H
    FABS  V5.2D, V5.2D
    FMULX  V12.4S, V3.4S, V3.4S
    FADDP D17, V25.2D
    FSQRT  V6.4S, V10.4S
    FABD  V22.8H, V6.8H, V17.8H
    FABD  V17.8H, V27.8H, V27.8H
    FACGE  V10.4S, V5.4S, V13.4S
    FMLA V27.2S, V31.2S, V29.S[0x1]
    FMLA H31, H26, V4.H[0x3]
    FMULX V11.8H, V12.8H, V10.H[0x2]
    FADDP  V8.4H, V22.4H, V22.4H
    FABD  V24.8H, V8.8H, V2.8H
    FMLS S29, S17, V24.S[0x0]
    FABS  V26.8H, V27.8H
    FMULX V3.2D, V31.2D, V31.D[0x0]
    FMLS D25, D26, V3.D[0x1]
    FMLS D8, D11, V25.D[0x0]
    FMUL  V20.4H, V29.4H, V8.4H
    FRSQRTE  V15.4H, V13.4H
    FADDP S5, V15.2S
    FMULX  V27.8H, V5.8H, V8.8H
    FADDP D14, V31.2D
    FMULX S3, S22, V12.S[0x0]
    FSUB  V4.4S, V14.4S, V23.4S
    FMOV  V6.4H, #0.90625000
    FNEG  V2.4H, V19.4H
    FADD  V29.2S, V3.2S, V3.2S
    FMOV  V17.2S, #0.96875000
    FMULX D0, D7, V31.D[0x1]
    FMLA  V19.2D, V2.2D, V22.2D
    FMLA  V10.4H, V8.4H, V28.4H
    FMULX  V8.8H, V19.8H, V20.8H
    FMLS  V24.4H, V0.4H, V29.4H
    FMUL S22, S10, V17.S[0x3]
    FABD  V20.4H, V27.4H, V8.4H
    FMLA V7.4S, V24.4S, V4.S[0x3]
    FMLA  V3.4H, V22.4H, V6.4H
    FMLS H15, H20, V10.H[0x6]
    FRSQRTE  V2.4H, V15.4H
    FRECPS  V13.4S, V7.4S, V3.4S
    FMULX V14.2D, V13.2D, V2.D[0x0]
    FRSQRTS  V2.4H, V24.4H, V16.4H
    FABS  V16.2S, V12.2S
    FNEG  V31.4H, V0.4H
    FMLS S17, S22, V0.S[0x3]
    FMULX V22.4H, V11.4H, V6.H[0x1]
    FRSQRTS  V12.4H, V23.4H, V0.4H
    FDIV  V13.4H, V5.4H, V28.4H
    FMULX S19, S6, V26.S[0x0]
    FACGT  V15.4H, V16.4H, V31.4H
    FMUL H24, H19, V13.H[0x3]
    FMOV  V20.2S, #-0.43750000
    FMUL D27, D2, V24.D[0x1]
    FMLA H11, H14, V14.H[0x3]
    FMULX V4.2D, V27.2D, V27.D[0x0]
    FMLA  V29.4S, V12.4S, V4.4S
    FMOV  V0.4H, #-2.62500000
    FMOV  V19.2S, #0.37500000
    FMOV  V31.8H, #28.00000000
    FRECPS  V8.2S, V11.2S, V20.2S
    FMULX V13.2D, V22.2D, V0.D[0x0]
    FMUL V3.4S, V8.4S, V29.S[0x1]
    FRSQRTS  V5.2D, V17.2D, V13.2D
    FRECPS  V17.8H, V19.8H, V15.8H
    FMLA V28.2D, V5.2D, V31.D[0x1]
    FMLA V14.4S, V28.4S, V3.S[0x3]
    FMLS V0.2D, V17.2D, V17.D[0x1]
    FMLA V27.8H, V14.8H, V14.H[0x2]
    FMLA V20.2D, V27.2D, V0.D[0x0]
    FMUL V22.2D, V24.2D, V16.D[0x0]
    FMULX  V27.8H, V7.8H, V18.8H
    FACGE  V6.4S, V15.4S, V22.4S
    FMUL  V0.2S, V0.2S, V7.2S
    FMLS D23, D25, V26.D[0x1]
    FMULX V29.4S, V14.4S, V21.S[0x0]
    FMUL H16, H14, V2.H[0x7]
    FSQRT  V8.2S, V18.2S
    FMULX V18.8H, V19.8H, V9.H[0x3]
    FMULX V19.2D, V18.2D, V6.D[0x0]
    FMULX H9, H27, V14.H[0x1]
    FMUL S18, S0, V19.S[0x3]
    FRECPE  V31.2D, V9.2D
    FRSQRTE  V21.4S, V31.4S
    FRECPS  V31.2D, V20.2D, V20.2D
    FMUL V17.2D, V23.2D, V21.D[0x1]
    FMLS  V24.4H, V18.4H, V17.4H
    FMLA  V18.2D, V8.2D, V8.2D
    FMULX H2, H31, V8.H[0x7]
    FMLS  V6.2D, V2.2D, V29.2D
    FMULX S2, S16, V6.S[0x1]
    FADDP  V21.4H, V2.4H, V24.4H
    FSUB  V27.4H, V21.4H, V18.4H
    FSQRT  V24.8H, V2.8H
    FMULX V6.2D, V9.2D, V16.D[0x0]
    FMOV  V22.2D, #-1.31250000
    FMUL V16.2S, V8.2S, V20.S[0x3]
    FMLA H8, H5, V9.H[0x2]
    FADD  V15.8H, V23.8H, V17.8H
    FMLA D29, D20, V6.D[0x0]
    FADD  V5.2D, V15.2D, V2.2D
    FMLA V19.4S, V15.4S, V3.S[0x0]
    FMLA S21, S23, V6.S[0x0]
    FMOV  V3.8H, #-0.75000000
    FRSQRTS  V15.4S, V24.4S, V8.4S
    FNEG  V9.4S, V3.4S
    FNEG  V31.2S, V21.2S
    FSUB  V2.8H, V19.8H, V27.8H
    FADDP S23, V16.2S
    FMLA  V27.2S, V23.2S, V8.2S
    FDIV  V20.2S, V22.2S, V15.2S
    FMLS D3, D5, V2.D[0x0]
    FNEG  V8.4H, V9.4H
    FACGT  V9.2S, V27.2S, V3.2S
    FMLS D17, D29, V20.D[0x1]
    FRSQRTS  V5.8H, V2.8H, V8.8H
    FRECPS  V22.2D, V31.2D, V31.2D
    FRSQRTE  V18.4H, V17.4H
    FMLA V17.4S, V22.4S, V9.S[0x1]
    FMOV  V6.4H, #0.34375000
    FMULX  V3.4S, V5.4S, V6.4S
    FMUL V27.8H, V18.8H, V10.H[0x7]
    FSQRT  V5.8H, V25.8H
    FMUL H15, H17, V5.H[0x4]
    FRECPE  V16.2S, V27.2S
    FMUL  V27.4H, V15.4H, V16.4H
    FMLS D18, D3, V3.D[0x0]
    FACGT  V24.2D, V18.2D, V27.2D
    FNEG  V3.4S, V12.4S
    FMUL V25.2D, V2.2D, V7.D[0x1]
    FADDP  V6.8H, V13.8H, V20.8H
    FNEG  V22.2D, V22.2D
    FMLS H23, H17, V11.H[0x0]
    FMLS V17.2D, V10.2D, V18.D[0x0]
    FMLS  V8.4H, V2.4H, V8.4H
    FMUL D9, D29, V0.D[0x1]
    FMOV  V16.2D, #4.00000000
    FMLS  V5.4H, V8.4H, V22.4H
    FSQRT  V29.2D, V3.2D
    FABD  V31.4H, V9.4H, V24.4H
    FMUL V3.8H, V16.8H, V9.H[0x6]
    FMUL V2.4H, V5.4H, V3.H[0x1]
    FDIV  V12.4S, V2.4S, V25.4S
    FMLA  V25.4H, V6.4H, V23.4H
    FMUL V23.4S, V25.4S, V31.S[0x0]
    FADD  V31.4H, V17.4H, V16.4H
    FMULX D7, D20, V31.D[0x0]
    FRECPS  V25.4H, V12.4H, V23.4H
    FMLS H13, H29, V11.H[0x5]
    FMLS H2, H13, V13.H[0x2]
    FMUL V5.8H, V7.8H, V2.H[0x3]
    FADDP  V31.2D, V25.2D, V25.2D
    FMULX H3, H31, V5.H[0x0]
    FADD  V22.2D, V24.2D, V18.2D
    FMUL V18.4H, V3.4H, V11.H[0x5]
    FRSQRTS  V6.4H, V21.4H, V5.4H
    FMLA V23.8H, V20.8H, V15.H[0x0]
    FMLA V13.2D, V23.2D, V20.D[0x0]
    FABD  V9.4S, V29.4S, V6.4S
    FMLS S24, S8, V30.S[0x3]
    FDIV  V8.2D, V1.2D, V27.2D
    FMLA S10, S21, V20.S[0x3]
    FMUL D25, D2, V2.D[0x0]
    FMLS D12, D2, V20.D[0x1]
    FADDP S30, V24.2S
    FMULX H11, H9, V13.H[0x1]
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_16
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x1f, LSL #0
    MRS  X28, FPSR
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x3d09, LSL #0
    MOVK  X5, #0x6869, LSL #16
    MOVK  X5, #0xb264, LSL #32
    MOVK  X5, #0xf9c6, LSL #48
    FMOV  X28, D0
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, D1
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, D2
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x8000, LSL #0
    FMOV  X28, D3
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, D4
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V5.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x8000, LSL #0
    MOVK  X5, #0x8000, LSL #16
    MOVK  X5, #0x8000, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    FMOV  X28, D5
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x3e00, LSL #0
    MOVK  X5, #0x3e00, LSL #16
    MOVK  X5, #0x3e00, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    FMOV  X28, D6
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x959f, LSL #0
    MOVK  X5, #0x95a0, LSL #16
    MOVK  X5, #0xed95, LSL #32
    MOVK  X5, #0xfdb3, LSL #48
    FMOV  X28, D7
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7ff8, LSL #48
    FMOV  X28, V8.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, D8
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x3e00, LSL #0
    MOVK  X5, #0x3e00, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    FMOV  X28, D9
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x7e00, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    FMOV  X28, D10
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x722, LSL #0
    FMOV  X28, D11
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7f80, LSL #16
    MOVK  X5, #0x7f80, LSL #48
    FMOV  X28, D12
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0xfed6, LSL #0
    MOVK  X5, #0x4c1, LSL #16
    MOVK  X5, #0x8000, LSL #48
    FMOV  X28, D13
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x7ff1, LSL #0
    MOVK  X5, #0xbdf0, LSL #16
    MOVK  X5, #0x7c00, LSL #32
    MOVK  X5, #0x7c10, LSL #48
    FMOV  X28, V14.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x4474, LSL #0
    MOVK  X5, #0xc8c7, LSL #16
    MOVK  X5, #0x7c00, LSL #32
    MOVK  X5, #0x7c10, LSL #48
    FMOV  X28, D14
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, D15
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4010, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x4010, LSL #48
    FMOV  X28, D16
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffef, LSL #48
    FMOV  X28, D17
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x8000, LSL #0
    FMOV  X28, D18
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7df0, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    MOVK  X5, #0x3ce0, LSL #48
    FMOV  X28, V19.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7df0, LSL #16
    MOVK  X5, #0x7e00, LSL #32
    MOVK  X5, #0x3ce0, LSL #48
    FMOV  X28, D19
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x5555, LSL #32
    MOVK  X5, #0xbfa3, LSL #48
    FMOV  X28, D20
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, D21
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7ff8, LSL #48
    FMOV  X28, D22
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    FMOV  X28, D23
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    FMOV  X28, D24
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, D25
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    MOVK  X5, #0x7fc0, LSL #48
    FMOV  X28, D26
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x8000, LSL #0
    MOVK  X5, #0x8000, LSL #32
    FMOV  X28, D27
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x7680, LSL #0
    MOVK  X5, #0x7680, LSL #16
    MOVK  X5, #0x7680, LSL #32
    MOVK  X5, #0x4f08, LSL #48
    FMOV  X28, V28.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x60a3, LSL #0
    MOVK  X5, #0x76a3, LSL #16
    MOVK  X5, #0x7680, LSL #32
    MOVK  X5, #0x4f08, LSL #48
    FMOV  X28, D28
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7ff8, LSL #48
    FMOV  X28, V29.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7ff8, LSL #48
    FMOV  X28, D29
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x7fc0, LSL #16
    FMOV  X28, D30
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x4000, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x4000, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X5, #0x4000, LSL #0
    MOVK  X5, #0x7e00, LSL #16
    MOVK  X5, #0x4000, LSL #32
    MOVK  X5, #0x7e00, LSL #48
    FMOV  X28, D31
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X12
    FMOV  V2.D[1], X13
    FMOV  D3, X15
    FMOV  V3.D[1], X7
    FMOV  D4, X25
    FMOV  V4.D[1], X8
    FMOV  D5, X28
    FMOV  V5.D[1], X16
    FMOV  D6, X28
    FMOV  V6.D[1], X24
    FMOV  D7, X12
    FMOV  V7.D[1], X28
    FMOV  D8, X11
    FMOV  V8.D[1], X14
    FMOV  D9, X11
    FMOV  V9.D[1], X3
    FMOV  D10, X12
    FMOV  V10.D[1], X6
    FMOV  D11, X8
    FMOV  V11.D[1], X20
    FMOV  D12, X18
    FMOV  V12.D[1], X8
    FMOV  D13, X24
    FMOV  V13.D[1], X15
    FMOV  D14, X21
    FMOV  V14.D[1], X25
    FMOV  D15, X11
    FMOV  V15.D[1], X25
    FMOV  D16, X14
    FMOV  V16.D[1], X5
    FMOV  D17, X27
    FMOV  V17.D[1], X22
    FMOV  D18, X24
    FMOV  V18.D[1], X27
    FMOV  D19, X10
    FMOV  V19.D[1], X28
    FMOV  D20, X22
    FMOV  V20.D[1], X12
    FMOV  D21, X24
    FMOV  V21.D[1], X7
    FMOV  D22, X24
    FMOV  V22.D[1], X20
    FMOV  D23, X10
    FMOV  V23.D[1], X10
    FMOV  D24, X3
    FMOV  V24.D[1], X22
    FMOV  D25, X7
    FMOV  V25.D[1], X4
    FMOV  D26, X7
    FMOV  V26.D[1], X7
    FMOV  D27, X23
    FMOV  V27.D[1], X4
    FMOV  D28, X21
    FMOV  V28.D[1], X3
    FMOV  D29, X3
    FMOV  V29.D[1], X17
    FMOV  D30, X4
    FMOV  V30.D[1], X20
    FMOV  D31, X10
    FMOV  V31.D[1], X12
    MOVZ  X12, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_17:
    FMULX V7.4H, V30.4H, V8.H[0x3]
    FRSQRTS  V0.8H, V29.8H, V29.8H
    FMOV  V3.2S, #12.50000000
    FABD  V26.8H, V31.8H, V28.8H
    FMOV  V7.2D, #-10.50000000
    FMLA  V24.8H, V27.8H, V26.8H
    FMLA V0.8H, V7.8H, V3.H[0x3]
    FADDP  V10.2D, V0.2D, V24.2D
    FMULX  V26.4S, V10.4S, V10.4S
    FADDP  V18.2S, V26.2S, V26.2S
    FADDP H31, V18.2H
    FACGE  V28.8H, V31.8H, V31.8H
    FSUB  V7.2S, V28.2S, V25.2S
    FABD  V28.4H, V7.4H, V7.4H
    FACGE  V3.2D, V28.2D, V28.2D
    FMULX V24.8H, V7.8H, V9.H[0x7]
    FMULX V15.2D, V21.2D, V23.D[0x0]
    FMULX  V21.4S, V9.4S, V6.4S
    FMLS  V26.8H, V5.8H, V5.8H
    FMUL D10, D26, V4.D[0x1]
    FRSQRTE  V6.2S, V31.2S
    FADDP S29, V4.2S
    FMULX V28.8H, V3.8H, V2.H[0x0]
    FMLS S8, S28, V22.S[0x0]
    FRSQRTE  V25.8H, V28.8H
    FMLA V0.4H, V8.4H, V13.H[0x3]
    FRSQRTE  V4.8H, V10.8H
    FMLS  V18.8H, V2.8H, V8.8H
    FMLS V8.4S, V18.4S, V24.S[0x0]
    FMLA V13.8H, V4.8H, V9.H[0x6]
    FMLA D5, D29, V29.D[0x1]
    FMLA V28.4S, V6.4S, V25.S[0x3]
    FMLA S23, S8, V30.S[0x3]
    FMOV  V18.4H, #2.50000000
    FDIV  V6.2S, V21.2S, V21.2S
    FMULX S24, S0, V0.S[0x2]
    FSUB  V31.8H, V13.8H, V5.8H
    FADDP D26, V31.2D
    FMUL  V25.4S, V6.4S, V23.4S
    FMLS V10.4S, V28.4S, V28.S[0x2]
    FMLA V0.4H, V24.4H, V10.H[0x0]
    FACGE  V7.2D, V0.2D, V25.2D
    FADDP H21, V18.2H
    FABS  V18.2D, V26.2D
    FSUB  V5.4H, V7.4H, V15.4H
    FMUL S22, S5, V21.S[0x0]
    FRSQRTE  V2.4S, V18.4S
    FDIV  V28.4H, V22.4H, V30.4H
    FABD  V13.4H, V2.4H, V28.4H
    FMUL V3.2D, V2.2D, V20.D[0x0]
    FADDP D8, V10.2D
    FMULX D10, D8, V1.D[0x1]
    FMLS D0, D22, V28.D[0x1]
    FMLA D8, D18, V12.D[0x0]
    FMLA  V26.8H, V8.8H, V3.8H
    FACGT  V21.4H, V24.4H, V22.4H
    FMULX D7, D21, V21.D[0x1]
    FMULX  V20.4S, V7.4S, V18.4S
    FACGE  V1.8H, V8.8H, V11.8H
    FMLA D28, D10, V15.D[0x1]
    FACGT  V12.2D, V5.2D, V17.2D
    FMLS  V31.4S, V11.4S, V25.4S
    FMLA V3.8H, V22.8H, V13.H[0x0]
    FADDP H5, V17.2H
    FDIV  V24.2S, V1.2S, V5.2S
    FMLA H2, H24, V2.H[0x4]
    FMOV  V30.4S, #-12.50000000
    FMUL V7.2D, V31.2D, V30.D[0x0]
    FMLS H17, H28, V7.H[0x1]
    FACGE  V21.4H, V20.4H, V0.4H
    FABD  V24.4H, V21.4H, V17.4H
    FMUL H13, H9, V3.H[0x5]
    FMUL D9, D2, V24.D[0x1]
    FMULX  V8.2D, V12.2D, V12.2D
    FMLA  V0.8H, V9.8H, V31.8H
    FMUL  V5.8H, V0.8H, V13.8H
    FABD  V9.8H, V5.8H, V8.8H
    FACGE  V7.8H, V9.8H, V9.8H
    FADDP  V2.4H, V7.4H, V7.4H
    FMLA D18, D2, V26.D[0x0]
    FMLA V28.4S, V23.4S, V18.S[0x2]
    FMLA H31, H3, V14.H[0x4]
    FACGE  V20.4H, V10.4H, V9.4H
    FSQRT  V2.8H, V0.8H
    FMLS S7, S0, V5.S[0x1]
    FMUL S24, S8, V0.S[0x2]
    FRSQRTE  V26.2D, V31.2D
    FRSQRTS  V13.4H, V10.4H, V24.4H
    FMLS  V23.8H, V26.8H, V14.8H
    FADDP H12, V10.2H
    FRECPE  V0.2D, V0.2D
    FMLA V10.8H, V28.8H, V2.H[0x5]
    FMULX S2, S11, V12.S[0x0]
    FMLA S12, S15, V31.S[0x0]
    FMUL  V18.2S, V9.2S, V25.2S
    FMUL V8.2D, V3.2D, V13.D[0x1]
    FRECPE  V31.2D, V10.2D
    FNEG  V17.2S, V31.2S
    FRECPS  V24.4S, V7.4S, V17.4S
    FSQRT  V14.4H, V2.4H
    FMULX  V21.2D, V0.2D, V27.2D
    FACGE  V10.4S, V12.4S, V20.4S
    FMLS  V0.2S, V8.2S, V20.2S
    FMLA  V17.2D, V18.2D, V10.2D
    FSUB  V8.2D, V24.2D, V0.2D
    FSUB  V2.4H, V8.4H, V23.4H
    FACGE  V13.2S, V14.2S, V14.2S
    FMULX  V14.2D, V21.2D, V2.2D
    FRECPE  V31.2D, V13.2D
    FMULX V7.4S, V31.4S, V17.S[0x2]
    FMLS S3, S7, V7.S[0x1]
    FRSQRTS  V10.8H, V3.8H, V14.8H
    FMOV  V11.2S, #-18.00000000
    FMLS V27.4H, V17.4H, V9.H[0x1]
    FMLA  V18.4S, V6.4S, V28.4S
    FRSQRTS  V28.4H, V27.4H, V24.4H
    FMLA S12, S11, V9.S[0x3]
    FABS  V0.4H, V28.4H
    FMULX D3, D10, V5.D[0x1]
    FMULX  V15.4H, V28.4H, V31.4H
    FMOV  V21.4H, #2.62500000
    FACGE  V11.4S, V29.4S, V12.4S
    FDIV  V13.2S, V20.2S, V18.2S
    FNEG  V7.4H, V2.4H
    FACGT  V25.2D, V9.2D, V14.2D
    FSUB  V7.4S, V4.4S, V9.4S
    FMLA V2.4H, V6.4H, V7.H[0x5]
    FMLA S17, S10, V28.S[0x3]
    FMUL  V27.2D, V2.2D, V13.2D
    FRECPS  V5.4H, V25.4H, V17.4H
    FACGT  V12.2S, V3.2S, V5.2S
    FRECPS  V9.2D, V0.2D, V27.2D
    FABD  V6.4S, V11.4S, V15.4S
    FMLA H20, H6, V6.H[0x2]
    FMUL V6.2S, V20.2S, V21.S[0x2]
    FMLA V14.2S, V6.2S, V7.S[0x3]
    FMLA D31, D9, V14.D[0x1]
    FMULX H6, H12, V12.H[0x2]
    FMUL S11, S31, V6.S[0x1]
    FMUL S15, S17, V2.S[0x0]
    FDIV  V0.4H, V20.4H, V6.4H
    FMUL  V17.4S, V23.4S, V1.4S
    FMLS S6, S7, V0.S[0x0]
    FMLS S9, S23, V19.S[0x0]
    FSQRT  V5.8H, V26.8H
    FMUL V21.2D, V29.2D, V7.D[0x0]
    FMUL  V2.8H, V25.8H, V27.8H
    FNEG  V3.8H, V12.8H
    FMLA H1, H17, V6.H[0x6]
    FMLS V14.4H, V15.4H, V15.H[0x1]
    FMLA H15, H11, V11.H[0x5]
    FADDP  V20.2S, V9.2S, V1.2S
    FMUL S9, S2, V3.S[0x1]
    FSQRT  V12.8H, V20.8H
    FNEG  V31.4S, V12.4S
    FMUL D19, D26, V15.D[0x1]
    FMLS  V1.4S, V3.4S, V14.4S
    FMLS H11, H21, V5.H[0x4]
    FMUL D25, D11, V9.D[0x1]
    FMLA  V14.4H, V19.4H, V31.4H
    FMLA V21.2D, V1.2D, V25.D[0x0]
    FMLA V2.2D, V21.2D, V14.D[0x0]
    FADDP D0, V9.2D
    FACGT  V7.8H, V13.8H, V11.8H
    FNEG  V14.4H, V5.4H
    FNEG  V23.4H, V23.4H
    FMULX S29, S1, V9.S[0x3]
    FMLA  V20.2D, V29.2D, V24.2D
    FMULX V6.4S, V18.4S, V11.S[0x0]
    FMULX V12.2S, V9.2S, V10.S[0x0]
    FMOV  V10.4H, #5.75000000
    FSQRT  V27.4H, V23.4H
    FNEG  V21.2D, V2.2D
    FMLS V3.8H, V6.8H, V12.H[0x5]
    FADDP S17, V12.2S
    FACGE  V15.4H, V0.4H, V0.4H
    FRSQRTE  V13.4H, V7.4H
    FMLA  V26.4H, V21.4H, V17.4H
    FMUL V2.4H, V10.4H, V3.H[0x3]
    FSQRT  V0.2S, V20.2S
    FRECPS  V29.2D, V14.2D, V14.2D
    FRECPS  V6.2D, V26.2D, V29.2D
    FADDP  V14.8H, V15.8H, V2.8H
    FMLA H5, H0, V6.H[0x1]
    FADDP  V3.4H, V14.4H, V29.4H
    FSQRT  V14.4H, V5.4H
    FRSQRTE  V10.4H, V13.4H
    FRSQRTE  V2.8H, V3.8H
    FMUL V13.4H, V2.4H, V2.H[0x1]
    FRSQRTE  V29.4H, V27.4H
    FMOV  V17.4S, #1.50000000
    FMUL  V1.4S, V10.4S, V14.4S
    FMLA D23, D1, V13.D[0x0]
    FMUL  V27.4H, V29.4H, V29.4H
    FMULX H21, H27, V4.H[0x1]
    FMUL V14.4S, V21.4S, V21.S[0x3]
    FMLS V2.4H, V23.4H, V11.H[0x3]
    FMULX  V21.8H, V17.8H, V17.8H
    FMLA H5, H14, V14.H[0x6]
    FRECPE  V7.2S, V2.2S
    SUBS  X12, X12, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_17
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X3, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x1f, LSL #0
    MRS  X3, FPSR
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x4f4, LSL #0
    MOVK  X17, #0x1cb5, LSL #16
    MOVK  X17, #0xfefe, LSL #32
    MOVK  X17, #0x1dfd, LSL #48
    FMOV  X3, D0
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, D1
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    MOVK  X17, #0x7e00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x7e00, LSL #48
    FMOV  X3, D2
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    MOVK  X17, #0xdffb, LSL #32
    MOVK  X17, #0x7e00, LSL #48
    FMOV  X3, D3
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x7c00, LSL #0
    MOVK  X17, #0x7c00, LSL #16
    MOVK  X17, #0x7c00, LSL #32
    MOVK  X17, #0x7c00, LSL #48
    FMOV  X3, V4.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x7c00, LSL #0
    MOVK  X17, #0x7c00, LSL #16
    MOVK  X17, #0x7c00, LSL #32
    MOVK  X17, #0x7e00, LSL #48
    FMOV  X3, D4
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, D5
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4000, LSL #48
    FMOV  X3, V6.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff0, LSL #48
    FMOV  X3, D6
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x8000, LSL #0
    MOVK  X17, #0xff, LSL #16
    MOVK  X17, #0x8000, LSL #32
    MOVK  X17, #0xff, LSL #48
    FMOV  X3, D7
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4000, LSL #16
    MOVK  X17, #0x4000, LSL #48
    FMOV  X3, V8.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4000, LSL #16
    MOVK  X17, #0x4000, LSL #48
    FMOV  X3, D8
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    MOVK  X17, #0xbb00, LSL #16
    FMOV  X3, D9
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, D11
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xbc3d, LSL #0
    MOVK  X17, #0xf980, LSL #16
    FMOV  X3, D12
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    MOVK  X17, #0x7c00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x7e00, LSL #48
    FMOV  X3, D13
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X3, D15
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X3, V16.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X3, D16
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3fc0, LSL #16
    MOVK  X17, #0x3fc0, LSL #48
    FMOV  X3, V17.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3fc0, LSL #16
    MOVK  X17, #0x3fc0, LSL #48
    FMOV  X3, D17
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7fc0, LSL #16
    MOVK  X17, #0x7fc0, LSL #48
    FMOV  X3, D18
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, D19
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x400, LSL #0
    MOVK  X17, #0x7e01, LSL #32
    FMOV  X3, D20
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4382, LSL #16
    MOVK  X17, #0x4382, LSL #48
    FMOV  X3, V21.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4382, LSL #16
    MOVK  X17, #0x4382, LSL #48
    FMOV  X3, D21
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x966e, LSL #0
    MOVK  X17, #0x381f, LSL #16
    FMOV  X3, D22
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x8000, LSL #0
    MOVK  X17, #0xfe00, LSL #16
    MOVK  X17, #0x8000, LSL #32
    MOVK  X17, #0x8000, LSL #48
    FMOV  X3, D23
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4000, LSL #16
    MOVK  X17, #0x4000, LSL #48
    FMOV  X3, V24.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4000, LSL #16
    MOVK  X17, #0x4000, LSL #48
    FMOV  X3, D24
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, D25
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    MOVK  X17, #0x7e00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x7e00, LSL #48
    FMOV  X3, D26
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x7c00, LSL #0
    MOVK  X17, #0x7e00, LSL #16
    MOVK  X17, #0x7c00, LSL #32
    MOVK  X17, #0x7c00, LSL #48
    FMOV  X3, D27
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    MOVK  X17, #0x7e00, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x7e00, LSL #48
    FMOV  X3, D28
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0xfc00, LSL #0
    MOVK  X17, #0x7e00, LSL #16
    MOVK  X17, #0xfc00, LSL #32
    MOVK  X17, #0xfc00, LSL #48
    FMOV  X3, D29
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc148, LSL #16
    MOVK  X17, #0xc148, LSL #48
    FMOV  X3, V30.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc148, LSL #16
    MOVK  X17, #0xc148, LSL #48
    FMOV  X3, D30
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    MOVK  X17, #0x8000, LSL #48
    FMOV  X3, V31.D[1]
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    MOVK  X17, #0x7e00, LSL #32
    MOVK  X17, #0x8000, LSL #48
    FMOV  X3, D31
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0xc602, LSL #0
    MOVK  X2, #0xa476, LSL #16
    MOVK  X2, #0x3505, LSL #32
    MOVK  X2, #0x8ed0, LSL #48
    MOVZ  X3, #0x1ef, LSL #0
    MOVK  X3, #0xbcf3, LSL #16
    MOVK  X3, #0xa170, LSL #32
    MOVK  X3, #0x1bad, LSL #48
    MOVZ  X4, #0x38f5, LSL #0
    MOVK  X4, #0xaab3, LSL #16
    MOVK  X4, #0x5b61, LSL #32
    MOVK  X4, #0x9ec2, LSL #48
    MOVZ  X5, #0xc81f, LSL #0
    MOVK  X5, #0x829, LSL #16
    MOVK  X5, #0x6d06, LSL #32
    MOVK  X5, #0x61e2, LSL #48
    MOVZ  X6, #0xdd5a, LSL #0
    MOVK  X6, #0x7072, LSL #16
    MOVK  X6, #0xc1b7, LSL #32
    MOVK  X6, #0x879, LSL #48
    MOVZ  X7, #0xa6f, LSL #0
    MOVK  X7, #0xb503, LSL #16
    MOVK  X7, #0x8e46, LSL #32
    MOVK  X7, #0x3d0d, LSL #48
    MOVZ  X8, #0x691b, LSL #0
    MOVK  X8, #0xe37a, LSL #16
    MOVK  X8, #0xb132, LSL #32
    MOVK  X8, #0x2fa, LSL #48
    MOVZ  X10, #0xb4bc, LSL #0
    MOVK  X10, #0x58ad, LSL #16
    MOVK  X10, #0xdec3, LSL #32
    MOVK  X10, #0x614f, LSL #48
    MOVZ  X11, #0x4f6d, LSL #0
    MOVK  X11, #0x478a, LSL #16
    MOVK  X11, #0xddcd, LSL #32
    MOVK  X11, #0x23b1, LSL #48
    MOVZ  X12, #0x7791, LSL #0
    MOVK  X12, #0x3de9, LSL #16
    MOVK  X12, #0x83a2, LSL #32
    MOVK  X12, #0x1af, LSL #48
    MOVZ  X13, #0x8d7e, LSL #0
    MOVK  X13, #0x1e6e, LSL #16
    MOVK  X13, #0xa96b, LSL #32
    MOVK  X13, #0xedf2, LSL #48
    MOVZ  X14, #0xffed, LSL #0
    MOVK  X14, #0xc06f, LSL #16
    MOVK  X14, #0x5603, LSL #32
    MOVK  X14, #0x6800, LSL #48
    MOVZ  X15, #0x575e, LSL #0
    MOVK  X15, #0x5b6f, LSL #16
    MOVK  X15, #0xdee7, LSL #32
    MOVK  X15, #0xf32e, LSL #48
    MOVZ  X16, #0xaf27, LSL #0
    MOVK  X16, #0xe5e, LSL #16
    MOVK  X16, #0x737e, LSL #32
    MOVK  X16, #0x7ebf, LSL #48
    MOVZ  X17, #0x8bd8, LSL #0
    MOVK  X17, #0x333f, LSL #16
    MOVK  X17, #0x5360, LSL #32
    MOVK  X17, #0x7dfc, LSL #48
    MOVZ  X18, #0x74bf, LSL #0
    MOVK  X18, #0x31dc, LSL #16
    MOVK  X18, #0x5963, LSL #32
    MOVK  X18, #0xddca, LSL #48
    MOVZ  X20, #0x17de, LSL #0
    MOVK  X20, #0x96d5, LSL #16
    MOVK  X20, #0xdf29, LSL #32
    MOVK  X20, #0x4649, LSL #48
    MOVZ  X21, #0x28cc, LSL #0
    MOVK  X21, #0xcbf1, LSL #16
    MOVK  X21, #0x1431, LSL #32
    MOVK  X21, #0xb78d, LSL #48
    MOVZ  X22, #0x819, LSL #0
    MOVK  X22, #0xa7d8, LSL #16
    MOVK  X22, #0xa950, LSL #32
    MOVK  X22, #0x6580, LSL #48
    MOVZ  X23, #0x2662, LSL #0
    MOVK  X23, #0xcb00, LSL #16
    MOVK  X23, #0x2f54, LSL #32
    MOVK  X23, #0x811f, LSL #48
    MOVZ  X24, #0xc969, LSL #0
    MOVK  X24, #0xad8f, LSL #16
    MOVK  X24, #0x80be, LSL #32
    MOVK  X24, #0x37b, LSL #48
    MOVZ  X25, #0xeaab, LSL #0
    MOVK  X25, #0x7df9, LSL #16
    MOVK  X25, #0x3d48, LSL #32
    MOVK  X25, #0x59a7, LSL #48
    MOVZ  X27, #0xcbb9, LSL #0
    MOVK  X27, #0xf448, LSL #16
    MOVK  X27, #0xfec9, LSL #32
    MOVK  X27, #0x5e75, LSL #48
    MOVZ  X28, #0x1599, LSL #0
    MOVK  X28, #0xd033, LSL #16
    MOVK  X28, #0x744e, LSL #32
    MOVK  X28, #0xf78e, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X18
    FMOV  V2.D[1], X17
    FMOV  D3, X5
    FMOV  V3.D[1], X5
    FMOV  D4, X12
    FMOV  V4.D[1], X10
    FMOV  D5, X7
    FMOV  V5.D[1], X11
    FMOV  D6, X24
    FMOV  V6.D[1], X20
    FMOV  D7, X16
    FMOV  V7.D[1], X13
    FMOV  D8, X8
    FMOV  V8.D[1], X28
    FMOV  D9, X5
    FMOV  V9.D[1], X25
    FMOV  D10, X25
    FMOV  V10.D[1], X7
    FMOV  D11, X15
    FMOV  V11.D[1], X5
    FMOV  D12, X18
    FMOV  V12.D[1], X3
    FMOV  D13, X6
    FMOV  V13.D[1], X16
    FMOV  D14, X27
    FMOV  V14.D[1], X28
    FMOV  D15, X15
    FMOV  V15.D[1], X14
    FMOV  D16, X11
    FMOV  V16.D[1], X16
    FMOV  D17, X4
    FMOV  V17.D[1], X2
    FMOV  D18, X3
    FMOV  V18.D[1], X3
    FMOV  D19, X17
    FMOV  V19.D[1], X20
    FMOV  D20, X7
    FMOV  V20.D[1], X21
    FMOV  D21, X23
    FMOV  V21.D[1], X20
    FMOV  D22, X10
    FMOV  V22.D[1], X12
    FMOV  D23, X21
    FMOV  V23.D[1], X10
    FMOV  D24, X17
    FMOV  V24.D[1], X11
    FMOV  D25, X11
    FMOV  V25.D[1], X28
    FMOV  D26, X8
    FMOV  V26.D[1], X27
    FMOV  D27, X13
    FMOV  V27.D[1], X3
    FMOV  D28, X5
    FMOV  V28.D[1], X14
    FMOV  D29, X13
    FMOV  V29.D[1], X2
    FMOV  D30, X16
    FMOV  V30.D[1], X20
    FMOV  D31, X27
    FMOV  V31.D[1], X15
    MOVZ  X14, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_18:
    FDIV  V26.4S, V26.4S, V30.4S
    FMLS V20.2D, V23.2D, V26.D[0x1]
    FNEG  V20.4H, V24.4H
    FMOV  V18.8H, #-1.81250000
    FMULX V25.2S, V31.2S, V28.S[0x0]
    FMLA V9.2S, V29.2S, V29.S[0x2]
    FDIV  V24.4S, V20.4S, V20.4S
    FMUL V26.2S, V18.2S, V24.S[0x1]
    FABS  V9.2D, V27.2D
    FMULX H19, H25, V9.H[0x5]
    FRSQRTE  V0.2S, V19.2S
    FMUL  V22.8H, V0.8H, V0.8H
    FMLA  V8.4H, V26.4H, V22.4H
    FDIV  V28.8H, V12.8H, V31.8H
    FMLA S9, S18, V29.S[0x1]
    FADDP  V26.4S, V7.4S, V28.4S
    FMLS V29.2D, V2.2D, V19.D[0x1]
    FADDP H25, V5.2H
    FACGE  V24.4H, V21.4H, V16.4H
    FMOV  V20.2S, #-0.34375000
    FADDP  V27.8H, V25.8H, V19.8H
    FMLA S0, S27, V12.S[0x0]
    FSUB  V28.2S, V6.2S, V20.2S
    FRSQRTE  V23.4H, V10.4H
    FRECPE  V19.4S, V22.4S
    FMLA D31, D19, V8.D[0x1]
    FMLA  V7.2S, V24.2S, V9.2S
    FRECPE  V22.4H, V31.4H
    FMLS V12.2D, V7.2D, V23.D[0x0]
    FRECPE  V21.2S, V28.2S
    FSQRT  V27.8H, V0.8H
    FMLS V6.4H, V21.4H, V12.H[0x4]
    FMUL V2.2S, V27.2S, V26.S[0x3]
    FDIV  V25.4S, V13.4S, V22.4S
    FRECPS  V19.8H, V25.8H, V29.8H
    FACGT  V28.4H, V19.4H, V6.4H
    FRSQRTS  V7.2D, V2.2D, V2.2D
    FSUB  V31.8H, V21.8H, V28.8H
    FMULX  V13.4S, V31.4S, V12.4S
    FRECPS  V24.4H, V13.4H, V13.4H
    FSUB  V2.2D, V24.2D, V7.2D
    FABS  V23.8H, V22.8H
    FMLS V9.4S, V13.4S, V22.S[0x0]
    FMLS  V28.2S, V24.2S, V10.2S
    FABS  V27.8H, V15.8H
    FMULX D21, D23, V18.D[0x0]
    FRSQRTS  V22.8H, V22.8H, V3.8H
    FRECPE  V3.2S, V25.2S
    FSUB  V29.2D, V3.2D, V8.2D
    FRSQRTE  V18.8H, V30.8H
    FACGT  V6.4H, V1.4H, V6.4H
    FADDP  V10.8H, V6.8H, V6.8H
    FABD  V20.2D, V2.2D, V28.2D
    FMLA  V23.8H, V22.8H, V21.8H
    FMLS  V21.2D, V1.2D, V20.2D
    FACGT  V7.4S, V9.4S, V27.4S
    FMLS  V20.4S, V29.4S, V7.4S
    FDIV  V19.2D, V18.2D, V18.2D
    FADDP H24, V14.2H
    FRSQRTE  V26.4H, V20.4H
    FMUL V15.8H, V24.8H, V10.H[0x0]
    FABD  V7.4S, V15.4S, V19.4S
    FMLA H24, H23, V4.H[0x3]
    FACGT  V19.4S, V24.4S, V7.4S
    FMLS D1, D21, V21.D[0x0]
    FMLS S15, S26, V19.S[0x2]
    FRECPE  V23.4H, V15.4H
    FNEG  V8.2S, V23.2S
    FRSQRTE  V22.2D, V8.2D
    FACGE  V28.8H, V22.8H, V22.8H
    FMULX V19.2D, V28.2D, V6.D[0x0]
    FADDP S29, V1.2S
    FACGT  V2.2S, V29.2S, V19.2S
    FMUL H8, H18, V13.H[0x7]
    FNEG  V18.2S, V5.2S
    FRSQRTS  V3.8H, V24.8H, V23.8H
    FACGT  V5.4H, V6.4H, V12.4H
    FMLA S9, S10, V17.S[0x2]
    FMULX  V7.2S, V8.2S, V1.2S
    FMLS  V21.8H, V3.8H, V27.8H
    FADDP  V10.4S, V21.4S, V27.4S
    FMULX  V8.4S, V22.4S, V10.4S
    FMUL D6, D28, V24.D[0x1]
    FMLA V13.4S, V10.4S, V28.S[0x2]
    FRSQRTE  V26.8H, V24.8H
    FMULX H3, H9, V7.H[0x4]
    FMLS V29.4H, V13.4H, V6.H[0x1]
    FRSQRTE  V19.2D, V2.2D
    FDIV  V2.4H, V29.4H, V19.4H
    FABS  V6.8H, V2.8H
    FMLA V13.2D, V26.2D, V3.D[0x0]
    FMLS  V1.4S, V5.4S, V31.4S
    FMLA V31.4H, V18.4H, V8.H[0x7]
    FADD  V19.2D, V31.2D, V13.2D
    FMLA D17, D6, V6.D[0x0]
    FMUL  V7.8H, V1.8H, V17.8H
    FRECPE  V12.4H, V19.4H
    FMOV  V19.8H, #-6.00000000
    FABD  V9.8H, V19.8H, V14.8H
    FMLS H19, H9, V12.H[0x6]
    FRSQRTS  V9.4H, V7.4H, V19.4H
    FMLA V2.4S, V21.4S, V7.S[0x3]
    FMULX  V19.2S, V6.2S, V9.2S
    FMLS D5, D10, V7.D[0x1]
    FMLS V14.2D, V18.2D, V25.D[0x0]
    FSQRT  V24.2S, V17.2S
    FMLA D17, D14, V22.D[0x1]
    FADDP S21, V23.2S
    FADDP  V10.4S, V26.4S, V22.4S
    FMLA  V3.2D, V16.2D, V4.2D
    FMUL  V14.8H, V19.8H, V21.8H
    FMLS S28, S27, V23.S[0x2]
    FMULX V31.8H, V12.8H, V5.H[0x0]
    FMLS  V9.8H, V15.8H, V15.8H
    FMULX V15.2D, V3.2D, V6.D[0x0]
    FMOV  V6.4S, #9.00000000
    FMLS  V29.4S, V28.4S, V14.4S
    FRSQRTS  V28.8H, V10.8H, V2.8H
    FMOV  V26.4S, #0.37500000
    FRECPE  V22.4H, V26.4H
    FMUL V16.2S, V9.2S, V31.S[0x1]
    FMULX V31.4S, V24.4S, V1.S[0x0]
    FRECPE  V19.2D, V31.2D
    FDIV  V2.8H, V28.8H, V22.8H
    FMLA S23, S29, V29.S[0x0]
    FMULX  V29.2S, V6.2S, V6.2S
    FABS  V22.8H, V19.8H
    FADDP S25, V15.2S
    FMUL H18, H25, V2.H[0x4]
    FRECPS  V28.2D, V16.2D, V23.2D
    FRSQRTE  V3.8H, V18.8H
    FMOV  V27.2D, #-1.56250000
    FADD  V12.8H, V27.8H, V29.8H
    FACGT  V15.2S, V28.2S, V28.2S
    FRSQRTE  V19.4H, V15.4H
    FRECPS  V14.2S, V19.2S, V19.2S
    FACGE  V29.4H, V22.4H, V22.4H
    FMULX D5, D14, V3.D[0x0]
    FNEG  V9.4H, V12.4H
    FMOV  V14.8H, #0.39062500
    FMUL D23, D29, V14.D[0x0]
    FABS  V3.4S, V5.4S
    FMLS S19, S9, V3.S[0x1]
    FMLA V25.8H, V23.8H, V15.H[0x5]
    FACGE  V16.2D, V25.2D, V25.2D
    FMLS  V3.8H, V16.8H, V19.8H
    FABS  V9.2D, V24.2D
    FADD  V22.4H, V30.4H, V21.4H
    FMULX V2.4H, V26.4H, V7.H[0x3]
    FRSQRTE  V12.8H, V16.8H
    FSUB  V29.4H, V10.4H, V21.4H
    FMULX V23.2S, V31.2S, V14.S[0x1]
    FMLA S31, S1, V1.S[0x3]
    FACGT  V28.2D, V6.2D, V23.2D
    FMULX V15.2S, V1.2S, V31.S[0x1]
    FMULX H24, H16, V13.H[0x5]
    FADDP D23, V3.2D
    FMUL S16, S9, V15.S[0x2]
    FMLS D15, D28, V29.D[0x1]
    FMLA D26, D24, V23.D[0x1]
    FMULX  V6.4H, V2.4H, V2.4H
    FACGE  V24.8H, V6.8H, V22.8H
    FMUL  V23.2S, V12.2S, V12.2S
    FSQRT  V7.8H, V16.8H
    FACGE  V29.4S, V15.4S, V23.4S
    FACGE  V19.2D, V29.2D, V7.2D
    FMUL H25, H30, V2.H[0x7]
    FMOV  V30.2S, #-0.62500000
    FMLS V28.2D, V26.2D, V24.D[0x0]
    FADDP  V16.8H, V19.8H, V25.8H
    FADDP S19, V16.2S
    FDIV  V23.4S, V19.4S, V28.4S
    FSUB  V15.2D, V30.2D, V30.2D
    FMUL S19, S15, V23.S[0x2]
    FMULX H31, H16, V15.H[0x0]
    FMULX V25.2D, V30.2D, V22.D[0x1]
    FABD  V3.4H, V16.4H, V11.4H
    FMOV  V7.4S, #0.19531250
    FMUL  V29.8H, V21.8H, V18.8H
    FMLS S15, S20, V21.S[0x3]
    FACGE  V28.8H, V24.8H, V10.8H
    FMOV  V26.8H, #0.21093750
    FMULX  V6.4S, V29.4S, V19.4S
    FMOV  V22.2S, #1.87500000
    FMULX V11.2D, V28.2D, V22.D[0x1]
    FMULX  V28.2S, V3.2S, V17.2S
    FMLS V12.2D, V25.2D, V25.D[0x1]
    FACGE  V23.8H, V12.8H, V7.8H
    FMLA  V25.4H, V28.4H, V15.4H
    FSQRT  V30.8H, V11.8H
    FMULX V16.2S, V26.2S, V30.S[0x2]
    FABS  V10.8H, V6.8H
    FSUB  V6.2S, V23.2S, V23.2S
    FMULX D21, D25, V31.D[0x0]
    FMLA V2.2S, V16.2S, V16.S[0x3]
    FMLS H25, H2, V2.H[0x4]
    FMLA  V18.4S, V29.4S, V21.4S
    FRSQRTS  V12.8H, V10.8H, V18.8H
    FMULX V15.2D, V12.2D, V6.D[0x0]
    FMUL  V26.2D, V15.2D, V15.2D
    SUBS  X14, X14, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_18
    MOVZ  X13, #0xc602, LSL #0
    MOVK  X13, #0xa476, LSL #16
    MOVK  X13, #0x3505, LSL #32
    MOVK  X13, #0x8ed0, LSL #48
    SUB  X17, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x1ef, LSL #0
    MOVK  X13, #0xbcf3, LSL #16
    MOVK  X13, #0xa170, LSL #32
    MOVK  X13, #0x1bad, LSL #48
    SUB  X17, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x38f5, LSL #0
    MOVK  X13, #0xaab3, LSL #16
    MOVK  X13, #0x5b61, LSL #32
    MOVK  X13, #0x9ec2, LSL #48
    SUB  X17, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xc81f, LSL #0
    MOVK  X13, #0x829, LSL #16
    MOVK  X13, #0x6d06, LSL #32
    MOVK  X13, #0x61e2, LSL #48
    SUB  X17, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xdd5a, LSL #0
    MOVK  X13, #0x7072, LSL #16
    MOVK  X13, #0xc1b7, LSL #32
    MOVK  X13, #0x879, LSL #48
    SUB  X17, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xa6f, LSL #0
    MOVK  X13, #0xb503, LSL #16
    MOVK  X13, #0x8e46, LSL #32
    MOVK  X13, #0x3d0d, LSL #48
    SUB  X17, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x691b, LSL #0
    MOVK  X13, #0xe37a, LSL #16
    MOVK  X13, #0xb132, LSL #32
    MOVK  X13, #0x2fa, LSL #48
    SUB  X17, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xb4bc, LSL #0
    MOVK  X13, #0x58ad, LSL #16
    MOVK  X13, #0xdec3, LSL #32
    MOVK  X13, #0x614f, LSL #48
    SUB  X17, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x4f6d, LSL #0
    MOVK  X13, #0x478a, LSL #16
    MOVK  X13, #0xddcd, LSL #32
    MOVK  X13, #0x23b1, LSL #48
    SUB  X17, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7791, LSL #0
    MOVK  X13, #0x3de9, LSL #16
    MOVK  X13, #0x83a2, LSL #32
    MOVK  X13, #0x1af, LSL #48
    SUB  X17, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xaf27, LSL #0
    MOVK  X13, #0xe5e, LSL #16
    MOVK  X13, #0x737e, LSL #32
    MOVK  X13, #0x7ebf, LSL #48
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x74bf, LSL #0
    MOVK  X13, #0x31dc, LSL #16
    MOVK  X13, #0x5963, LSL #32
    MOVK  X13, #0xddca, LSL #48
    SUB  X17, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x17de, LSL #0
    MOVK  X13, #0x96d5, LSL #16
    MOVK  X13, #0xdf29, LSL #32
    MOVK  X13, #0x4649, LSL #48
    SUB  X17, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x28cc, LSL #0
    MOVK  X13, #0xcbf1, LSL #16
    MOVK  X13, #0x1431, LSL #32
    MOVK  X13, #0xb78d, LSL #48
    SUB  X17, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x819, LSL #0
    MOVK  X13, #0xa7d8, LSL #16
    MOVK  X13, #0xa950, LSL #32
    MOVK  X13, #0x6580, LSL #48
    SUB  X17, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x2662, LSL #0
    MOVK  X13, #0xcb00, LSL #16
    MOVK  X13, #0x2f54, LSL #32
    MOVK  X13, #0x811f, LSL #48
    SUB  X17, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xc969, LSL #0
    MOVK  X13, #0xad8f, LSL #16
    MOVK  X13, #0x80be, LSL #32
    MOVK  X13, #0x37b, LSL #48
    SUB  X17, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xeaab, LSL #0
    MOVK  X13, #0x7df9, LSL #16
    MOVK  X13, #0x3d48, LSL #32
    MOVK  X13, #0x59a7, LSL #48
    SUB  X17, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xcbb9, LSL #0
    MOVK  X13, #0xf448, LSL #16
    MOVK  X13, #0xfec9, LSL #32
    MOVK  X13, #0x5e75, LSL #48
    SUB  X17, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x1599, LSL #0
    MOVK  X13, #0xd033, LSL #16
    MOVK  X13, #0x744e, LSL #32
    MOVK  X13, #0xf78e, LSL #48
    SUB  X17, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x1f, LSL #0
    MRS  X17, FPSR
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7f80, LSL #16
    FMOV  X17, D0
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X17, D1
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x7e00, LSL #32
    MOVK  X13, #0x7e00, LSL #48
    FMOV  X17, D2
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    FMOV  X17, D3
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xb4bc, LSL #0
    MOVK  X13, #0x58ad, LSL #16
    MOVK  X13, #0xdec3, LSL #32
    MOVK  X13, #0x614f, LSL #48
    FMOV  X17, V4.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7791, LSL #0
    MOVK  X13, #0x3de9, LSL #16
    MOVK  X13, #0x83a2, LSL #32
    MOVK  X13, #0x1af, LSL #48
    FMOV  X17, D4
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffef, LSL #48
    FMOV  X17, D5
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3e48, LSL #16
    MOVK  X13, #0x3e48, LSL #48
    FMOV  X17, V7.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3e48, LSL #16
    MOVK  X13, #0x3e48, LSL #48
    FMOV  X17, D7
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X17, V8.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X17, D8
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X17, D9
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    FMOV  X17, D10
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D11
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x3e00, LSL #0
    MOVK  X13, #0x3e00, LSL #16
    MOVK  X13, #0x3e00, LSL #32
    MOVK  X13, #0x3e00, LSL #48
    FMOV  X17, V12.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x3e00, LSL #32
    MOVK  X13, #0x3e00, LSL #48
    FMOV  X17, D12
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X17, V13.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X17, D13
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x3640, LSL #0
    MOVK  X13, #0x3640, LSL #16
    MOVK  X13, #0x3640, LSL #32
    MOVK  X13, #0x3640, LSL #48
    FMOV  X17, V14.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x3640, LSL #0
    MOVK  X13, #0x3640, LSL #16
    MOVK  X13, #0x3640, LSL #32
    MOVK  X13, #0x3640, LSL #48
    FMOV  X17, D14
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D16
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff8, LSL #48
    FMOV  X17, D17
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    FMOV  X17, D18
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    FMOV  X17, D19
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3ff8, LSL #48
    FMOV  X17, V20.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x4000, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X17, D20
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #32
    MOVK  X13, #0x3bcf, LSL #48
    FMOV  X17, D21
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3ff0, LSL #16
    MOVK  X13, #0x3ff0, LSL #48
    FMOV  X17, D22
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X17, V24.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    FMOV  X17, D25
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xbff9, LSL #48
    FMOV  X17, V27.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xbff9, LSL #48
    FMOV  X17, D27
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X17, D28
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    FMOV  X17, D29
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, D30
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    FMOV  X17, D31
    SUB  X15, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
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
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X22
    FMOV  V0.D[1], X18
    FMOV  D1, X7
    FMOV  V1.D[1], X13
    FMOV  D2, X20
    FMOV  V2.D[1], X21
    FMOV  D3, X25
    FMOV  V3.D[1], X17
    FMOV  D4, X8
    FMOV  V4.D[1], X15
    FMOV  D5, X27
    FMOV  V5.D[1], X24
    FMOV  D6, X28
    FMOV  V6.D[1], X23
    FMOV  D7, X21
    FMOV  V7.D[1], X2
    FMOV  D8, X14
    FMOV  V8.D[1], X2
    FMOV  D9, X21
    FMOV  V9.D[1], X14
    FMOV  D10, X8
    FMOV  V10.D[1], X17
    FMOV  D11, X10
    FMOV  V11.D[1], X16
    FMOV  D12, X22
    FMOV  V12.D[1], X24
    FMOV  D13, X28
    FMOV  V13.D[1], X3
    FMOV  D14, X24
    FMOV  V14.D[1], X27
    FMOV  D15, X7
    FMOV  V15.D[1], X8
    FMOV  D16, X5
    FMOV  V16.D[1], X11
    FMOV  D17, X18
    FMOV  V17.D[1], X17
    FMOV  D18, X3
    FMOV  V18.D[1], X11
    FMOV  D19, X18
    FMOV  V19.D[1], X18
    FMOV  D20, X15
    FMOV  V20.D[1], X16
    FMOV  D21, X17
    FMOV  V21.D[1], X12
    FMOV  D22, X15
    FMOV  V22.D[1], X8
    FMOV  D23, X3
    FMOV  V23.D[1], X23
    FMOV  D24, X20
    FMOV  V24.D[1], X27
    FMOV  D25, X12
    FMOV  V25.D[1], X3
    FMOV  D26, X16
    FMOV  V26.D[1], X24
    FMOV  D27, X7
    FMOV  V27.D[1], X16
    FMOV  D28, X6
    FMOV  V28.D[1], X8
    FMOV  D29, X3
    FMOV  V29.D[1], X13
    FMOV  D30, X16
    FMOV  V30.D[1], X15
    FMOV  D31, X27
    FMOV  V31.D[1], X2
    MOVZ  X21, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_19:
    FMUL  V2.2D, V25.2D, V22.2D
    FADDP  V4.2S, V24.2S, V2.2S
    FMUL S23, S28, V23.S[0x0]
    FADDP H5, V23.2H
    FRECPE  V8.2S, V31.2S
    FMULX V9.2D, V29.2D, V30.D[0x0]
    FSUB  V18.8H, V9.8H, V5.8H
    FRSQRTS  V3.4H, V21.4H, V18.4H
    FMLS V10.2D, V8.2D, V27.D[0x0]
    FABS  V29.2S, V4.2S
    FRSQRTS  V4.4S, V10.4S, V29.4S
    FMLA D2, D3, V3.D[0x1]
    FMLA S3, S2, V2.S[0x0]
    FMLA D24, D4, V3.D[0x0]
    FMUL H14, H24, V10.H[0x7]
    FMLA S27, S14, V26.S[0x0]
    FADDP S14, V6.2S
    FMULX V31.2D, V7.2D, V14.D[0x1]
    FSUB  V8.2D, V6.2D, V2.2D
    FMULX V4.2S, V4.2S, V4.S[0x2]
    FMULX D6, D17, V29.D[0x1]
    FMLS  V28.2D, V30.2D, V12.2D
    FRSQRTS  V18.4H, V15.4H, V9.4H
    FMULX V9.8H, V24.8H, V8.H[0x6]
    FMLA  V21.2D, V18.2D, V28.2D
    FADDP  V26.2S, V11.2S, V5.2S
    FADD  V29.4H, V23.4H, V18.4H
    FACGE  V7.4S, V1.4S, V27.4S
    FMLA  V24.4H, V22.4H, V20.4H
    FADDP H8, V6.2H
    FRECPE  V10.4H, V7.4H
    FMLA H12, H21, V14.H[0x3]
    FADDP  V7.8H, V26.8H, V26.8H
    FMLA V3.2D, V31.2D, V29.D[0x1]
    FDIV  V6.4H, V8.4H, V3.4H
    FNEG  V28.4H, V9.4H
    FMUL V15.4S, V6.4S, V24.S[0x2]
    FMLA V11.4S, V10.4S, V10.S[0x1]
    FACGT  V10.2D, V19.2D, V12.2D
    FSUB  V30.4H, V28.4H, V15.4H
    FADD  V2.4H, V4.4H, V7.4H
    FACGT  V17.2S, V11.2S, V15.2S
    FACGT  V15.4H, V10.4H, V30.4H
    FMOV  V22.2D, #-23.00000000
    FSUB  V6.4H, V2.4H, V15.4H
    FMULX V9.2D, V11.2D, V17.D[0x1]
    FRSQRTE  V5.4H, V6.4H
    FMUL S28, S5, V5.S[0x1]
    FMLA V4.2D, V9.2D, V28.D[0x0]
    FRECPS  V8.2D, V13.2D, V4.2D
    FMULX  V1.4H, V8.4H, V22.4H
    FMUL  V20.4S, V30.4S, V2.4S
    FADD  V24.4S, V9.4S, V30.4S
    FMLA V17.4S, V15.4S, V3.S[0x3]
    FNEG  V6.2S, V13.2S
    FMULX V7.2D, V13.2D, V22.D[0x0]
    FMUL V13.2D, V26.2D, V10.D[0x0]
    FMULX V14.2D, V9.2D, V30.D[0x0]
    FMLA  V10.4S, V18.4S, V23.4S
    FABS  V9.2D, V1.2D
    FMULX V2.2D, V13.2D, V7.D[0x1]
    FRSQRTE  V4.8H, V13.8H
    FRECPS  V23.4S, V20.4S, V24.4S
    FADDP S1, V6.2S
    FABS  V8.4S, V1.4S
    FMOV  V19.2S, #-0.18750000
    FMULX  V26.4H, V23.4H, V23.4H
    FRECPE  V3.8H, V26.8H
    FADD  V20.4H, V10.4H, V17.4H
    FMLA V1.2D, V4.2D, V19.D[0x0]
    FMLA H22, H9, V1.H[0x2]
    FMLA V9.8H, V14.8H, V2.H[0x2]
    FMUL V10.2S, V20.2S, V8.S[0x1]
    FMLA H4, H3, V15.H[0x3]
    FSQRT  V1.2S, V22.2S
    FMLS  V19.8H, V4.8H, V9.8H
    FABS  V6.4H, V1.4H
    FABS  V1.2S, V19.2S
    FADD  V28.4S, V1.4S, V6.4S
    FMOV  V24.2D, #-1.68750000
    FMULX H23, H10, V10.H[0x1]
    FMLA V10.2D, V23.2D, V23.D[0x0]
    FMULX V20.8H, V8.8H, V10.H[0x1]
    FMOV  V30.4H, #13.00000000
    FSQRT  V13.2D, V28.2D
    FMULX D17, D24, V24.D[0x0]
    FDIV  V10.2S, V20.2S, V30.2S
    FMLS  V26.8H, V17.8H, V10.8H
    FMULX V2.4S, V26.4S, V26.S[0x2]
    FACGE  V10.8H, V13.8H, V2.8H
    FRSQRTE  V22.2D, V12.2D
    FMULX V2.2D, V14.2D, V16.D[0x0]
    FMULX V9.2D, V8.2D, V23.D[0x0]
    FNEG  V15.4H, V11.4H
    FDIV  V24.2S, V6.2S, V11.2S
    FMLS V17.2S, V21.2S, V31.S[0x0]
    FMOV  V30.4S, #0.32812500
    FMUL  V16.2D, V20.2D, V7.2D
    FMLA  V21.4H, V2.4H, V10.4H
    FMLS D8, D9, V22.D[0x1]
    FDIV  V1.4S, V16.4S, V21.4S
    FRECPE  V31.4S, V15.4S
    FRSQRTE  V26.4H, V8.4H
    FMULX V9.2S, V26.2S, V24.S[0x1]
    FMOV  V26.2D, #0.34375000
    FMLS V23.2S, V17.2S, V1.S[0x1]
    FMULX D20, D23, V23.D[0x1]
    FMLS V1.8H, V31.8H, V2.H[0x1]
    FMUL V15.4H, V30.4H, V9.H[0x4]
    FMLA V10.2D, V15.2D, V20.D[0x0]
    FSQRT  V9.4H, V26.4H
    FNEG  V2.8H, V9.8H
    FRECPE  V26.2S, V10.2S
    FRECPE  V6.8H, V2.8H
    FMUL V20.2D, V2.2D, V6.D[0x0]
    FRSQRTS  V8.2S, V1.2S, V3.2S
    FMLS D7, D26, V26.D[0x0]
    FMLA  V31.4S, V8.4S, V7.4S
    FADDP  V2.8H, V20.8H, V20.8H
    FMLS V8.2S, V31.2S, V31.S[0x1]
    FACGT  V7.2S, V2.2S, V28.2S
    FMOV  V11.2D, #-28.00000000
    FMUL  V6.8H, V8.8H, V7.8H
    FMLS V20.8H, V11.8H, V6.H[0x3]
    FDIV  V9.4S, V22.4S, V5.4S
    FSQRT  V31.4H, V28.4H
    FABS  V28.4H, V11.4H
    FMLA S15, S29, V20.S[0x0]
    FADDP D2, V1.2D
    FRSQRTS  V3.2S, V6.2S, V16.2S
    FMULX D26, D27, V15.D[0x0]
    FMOV  V15.4H, #-1.12500000
    FMUL V8.8H, V1.8H, V0.H[0x2]
    FSQRT  V6.4S, V28.4S
    FMLS V1.8H, V15.8H, V4.H[0x3]
    FMLS V0.2S, V24.2S, V18.S[0x0]
    FABD  V18.4S, V6.4S, V1.4S
    FABS  V27.4S, V9.4S
    FMLA S16, S2, V27.S[0x3]
    FNEG  V4.4S, V3.4S
    FRSQRTS  V22.8H, V4.8H, V8.8H
    FSUB  V9.2S, V16.2S, V26.2S
    FMULX S27, S31, V31.S[0x1]
    FRECPE  V6.4H, V27.4H
    FADDP D27, V18.2D
    FABS  V3.8H, V6.8H
    FACGT  V11.8H, V12.8H, V16.8H
    FRSQRTS  V16.2D, V22.2D, V0.2D
    FMLS S4, S27, V9.S[0x0]
    FMLA  V6.2D, V8.2D, V3.2D
    FSUB  V15.4S, V11.4S, V16.4S
    FMOV  V24.2D, #0.46875000
    FADDP  V3.2S, V4.2S, V24.2S
    FMLA H16, H3, V3.H[0x1]
    FRECPE  V27.8H, V15.8H
    FADD  V9.2S, V16.2S, V27.2S
    FMULX D4, D9, V6.D[0x1]
    FMLA  V31.4H, V17.4H, V26.4H
    FSUB  V27.2S, V11.2S, V9.2S
    FMLA  V12.8H, V6.8H, V13.8H
    FRSQRTS  V26.2S, V20.2S, V6.2S
    FMUL H6, H21, V0.H[0x1]
    FMLS V28.4S, V11.4S, V21.S[0x3]
    FSUB  V11.4S, V23.4S, V2.4S
    FMOV  V1.2D, #-3.00000000
    FSQRT  V21.4S, V4.4S
    FADDP  V23.2D, V21.2D, V21.2D
    FMULX  V24.4S, V11.4S, V23.4S
    FMUL V15.4H, V28.4H, V12.H[0x1]
    FABS  V0.2D, V24.2D
    FMLS H4, H26, V3.H[0x1]
    FRSQRTE  V2.2D, V6.2D
    FMLS  V20.8H, V31.8H, V1.8H
    FSQRT  V28.8H, V27.8H
    FMUL D16, D15, V15.D[0x0]
    FACGT  V13.2S, V16.2S, V0.2S
    FMUL H21, H4, V6.H[0x0]
    FACGT  V16.8H, V2.8H, V21.8H
    FADD  V12.4S, V13.4S, V30.4S
    FMLS  V30.8H, V22.8H, V12.8H
    FMLS V23.2S, V20.2S, V16.S[0x3]
    FMULX H4, H28, V14.H[0x3]
    FMLS V0.4S, V4.4S, V4.S[0x1]
    FMLA D16, D0, V0.D[0x1]
    FRECPE  V12.8H, V23.8H
    FNEG  V2.4H, V12.4H
    FRSQRTE  V1.4S, V30.4S
    FNEG  V6.2S, V16.2S
    FDIV  V21.2D, V6.2D, V6.2D
    FMULX V24.2D, V21.2D, V2.D[0x1]
    FADD  V6.4H, V24.4H, V1.4H
    FACGE  V0.8H, V9.8H, V27.8H
    FMULX H31, H3, V8.H[0x5]
    FSQRT  V4.8H, V15.8H
    FMLA H15, H24, V3.H[0x7]
    FMLA D21, D14, V24.D[0x1]
    FMUL V14.4S, V21.4S, V1.S[0x1]
    FMUL V23.2D, V1.2D, V7.D[0x1]
    FACGT  V8.2S, V0.2S, V14.2S
    FRSQRTE  V24.2S, V1.2S
    SUBS  X21, X21, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_19
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x1f, LSL #0
    MRS  X13, FPSR
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X13, V0.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xffff, LSL #32
    FMOV  X13, D0
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x2034, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x2034, LSL #48
    FMOV  X13, V1.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x2034, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x2034, LSL #48
    FMOV  X13, D1
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0xfc00, LSL #0
    MOVK  X15, #0xfc00, LSL #16
    MOVK  X15, #0xfc00, LSL #32
    MOVK  X15, #0xfc00, LSL #48
    FMOV  X13, D2
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    MOVK  X15, #0x3fde, LSL #48
    FMOV  X13, D3
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, D4
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x399c, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, D5
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x2034, LSL #16
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, D6
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, D7
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, D8
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c01, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, D9
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X13, V10.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X13, D10
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xfe00, LSL #16
    MOVK  X15, #0x7fc0, LSL #48
    FMOV  X13, D11
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c00, LSL #0
    MOVK  X15, #0x7c00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7c00, LSL #48
    FMOV  X13, V12.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c00, LSL #0
    MOVK  X15, #0x7c00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7c00, LSL #48
    FMOV  X13, D12
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, D13
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #48
    FMOV  X13, D14
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, D15
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X13, D16
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #48
    FMOV  X13, D17
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, V18.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7dff, LSL #48
    FMOV  X13, D18
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0xbe40, LSL #16
    MOVK  X15, #0xbe40, LSL #48
    FMOV  X13, D19
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, V20.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, D20
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X13, D21
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, V22.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, D22
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, D23
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x4f18, LSL #16
    MOVK  X15, #0x8000, LSL #32
    MOVK  X15, #0x4f18, LSL #48
    FMOV  X13, D24
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, D25
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3fc0, LSL #16
    MOVK  X15, #0x7fc0, LSL #48
    FMOV  X13, D26
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c00, LSL #0
    MOVK  X15, #0xfe00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0xfe00, LSL #48
    FMOV  X13, D27
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7c00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7c00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, D28
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x3e00, LSL #0
    MOVK  X15, #0x3e00, LSL #16
    MOVK  X15, #0x3e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, D29
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, V30.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x7e00, LSL #16
    MOVK  X15, #0x7e00, LSL #32
    MOVK  X15, #0x7e00, LSL #48
    FMOV  X13, D30
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X13, D31
    SUB  X20, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorFloatingPointOperation_TestFail
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
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X23
    FMOV  V2.D[1], X22
    FMOV  D3, X20
    FMOV  V3.D[1], X14
    FMOV  D4, X27
    FMOV  V4.D[1], X16
    FMOV  D5, X7
    FMOV  V5.D[1], X8
    FMOV  D6, X25
    FMOV  V6.D[1], X10
    FMOV  D7, X14
    FMOV  V7.D[1], X13
    FMOV  D8, X16
    FMOV  V8.D[1], X25
    FMOV  D9, X16
    FMOV  V9.D[1], X4
    FMOV  D10, X7
    FMOV  V10.D[1], X8
    FMOV  D11, X5
    FMOV  V11.D[1], X11
    FMOV  D12, X2
    FMOV  V12.D[1], X12
    FMOV  D13, X28
    FMOV  V13.D[1], X14
    FMOV  D14, X20
    FMOV  V14.D[1], X20
    FMOV  D15, X5
    FMOV  V15.D[1], X13
    FMOV  D16, X8
    FMOV  V16.D[1], X10
    FMOV  D17, X12
    FMOV  V17.D[1], X7
    FMOV  D18, X12
    FMOV  V18.D[1], X23
    FMOV  D19, X21
    FMOV  V19.D[1], X12
    FMOV  D20, X17
    FMOV  V20.D[1], X2
    FMOV  D21, X23
    FMOV  V21.D[1], X11
    FMOV  D22, X22
    FMOV  V22.D[1], X15
    FMOV  D23, X15
    FMOV  V23.D[1], X22
    FMOV  D24, X5
    FMOV  V24.D[1], X14
    FMOV  D25, X2
    FMOV  V25.D[1], X18
    FMOV  D26, X14
    FMOV  V26.D[1], X23
    FMOV  D27, X20
    FMOV  V27.D[1], X3
    FMOV  D28, X4
    FMOV  V28.D[1], X25
    FMOV  D29, X12
    FMOV  V29.D[1], X12
    FMOV  D30, X25
    FMOV  V30.D[1], X2
    FMOV  D31, X15
    FMOV  V31.D[1], X22
    MOVZ  X4, #0xf, LSL #0
TSRTAdvsimdVectorFloatingPointOperation_label_20:
    FDIV  V25.4H, V23.4H, V26.4H
    FDIV  V15.8H, V30.8H, V28.8H
    FSUB  V29.4H, V25.4H, V31.4H
    FRSQRTS  V2.4H, V27.4H, V27.4H
    FMOV  V27.2S, #-8.00000000
    FMLA H17, H2, V12.H[0x3]
    FMLS S7, S15, V27.S[0x3]
    FRSQRTE  V3.4H, V17.4H
    FMLA H16, H29, V7.H[0x6]
    FMLA H19, H16, V2.H[0x0]
    FADDP H14, V24.2H
    FDIV  V23.4S, V3.4S, V3.4S
    FMLS  V26.2S, V23.2S, V23.2S
    FNEG  V24.2S, V19.2S
    FABD  V19.2D, V14.2D, V11.2D
    FACGT  V29.4S, V19.4S, V24.4S
    FDIV  V15.4S, V29.4S, V29.4S
    FMUL V16.2D, V15.2D, V26.D[0x1]
    FMLA S23, S8, V5.S[0x0]
    FMLA H14, H27, V12.H[0x7]
    FSUB  V15.4S, V28.4S, V10.4S
    FMUL  V28.4H, V20.4H, V14.4H
    FMUL V27.2D, V27.2D, V19.D[0x1]
    FSQRT  V8.4S, V14.4S
    FMLS V17.2D, V3.2D, V31.D[0x1]
    FDIV  V25.8H, V17.8H, V18.8H
    FABD  V14.8H, V29.8H, V12.8H
    FMLS V29.8H, V19.8H, V1.H[0x6]
    FMUL  V2.8H, V16.8H, V15.8H
    FMULX D20, D27, V2.D[0x1]
    FSUB  V5.8H, V23.8H, V23.8H
    FMLS  V3.8H, V14.8H, V5.8H
    FDIV  V31.2S, V29.2S, V28.2S
    FMUL  V26.2S, V25.2S, V25.2S
    FMUL  V24.8H, V31.8H, V3.8H
    FDIV  V3.4S, V24.4S, V26.4S
    FADDP  V10.4S, V5.4S, V3.4S
    FMLS V18.8H, V8.8H, V10.H[0x4]
    FMULX  V14.4S, V23.4S, V28.4S
    FMUL  V28.4H, V18.4H, V18.4H
    FRECPS  V18.8H, V20.8H, V28.8H
    FSQRT  V27.4H, V14.4H
    FADDP D2, V27.2D
    FSUB  V14.8H, V15.8H, V2.8H
    FMLS  V25.2S, V18.2S, V18.2S
    FRSQRTE  V1.8H, V23.8H
    FMLS V8.2S, V1.2S, V14.S[0x2]
    FRSQRTE  V17.4H, V25.4H
    FMUL H18, H8, V8.H[0x0]
    FMLS V3.4H, V17.4H, V0.H[0x0]
    FACGE  V20.2S, V3.2S, V3.2S
    FMUL  V25.4H, V20.4H, V17.4H
    FRSQRTS  V8.2S, V25.2S, V25.2S
    FMULX  V31.4H, V18.4H, V8.4H
    FRECPE  V27.2D, V9.2D
    FADDP  V28.2S, V29.2S, V28.2S
    FMLS V1.4S, V30.4S, V7.S[0x2]
    FMULX  V20.8H, V9.8H, V1.8H
    FMLA D3, D10, V25.D[0x0]
    FMLS  V18.2S, V31.2S, V13.2S
    FMULX D0, D21, V25.D[0x0]
    FMLS V29.2D, V30.2D, V3.D[0x1]
    FMUL  V26.2D, V28.2D, V8.2D
    FMLS D8, D22, V23.D[0x0]
    FMLS V2.2D, V6.2D, V13.D[0x1]
    FADDP D7, V27.2D
    FMUL V14.4H, V30.4H, V11.H[0x4]
    FRSQRTS  V28.8H, V2.8H, V20.8H
    FMUL V1.4S, V26.4S, V29.S[0x0]
    FMULX  V9.2D, V1.2D, V7.2D
    FABS  V26.8H, V0.8H
    FMLA V7.2D, V18.2D, V8.D[0x0]
    FMUL  V10.4H, V14.4H, V28.4H
    FMLA V18.2D, V30.2D, V10.D[0x0]
    FMLA  V11.8H, V9.8H, V9.8H
    FDIV  V9.4H, V18.4H, V18.4H
    FRECPE  V3.2D, V26.2D
    FADD  V29.2D, V3.2D, V11.2D
    FDIV  V17.4H, V9.4H, V9.4H
    FMLS H13, H29, V7.H[0x7]
    FMLS V14.2D, V17.2D, V13.D[0x1]
    FMLA V13.8H, V10.8H, V5.H[0x3]
    FMULX H17, H11, V15.H[0x2]
    FMLS V8.8H, V11.8H, V3.H[0x5]
    FMUL S23, S31, V4.S[0x3]
    FACGE  V7.2D, V31.2D, V6.2D
    FMUL H11, H16, V11.H[0x3]
    FRECPS  V5.4H, V14.4H, V4.4H
    FMUL V28.4H, V31.4H, V13.H[0x4]
    FACGT  V16.4S, V31.4S, V19.4S
    FRSQRTE  V26.4H, V15.4H
    FRSQRTS  V0.4H, V11.4H, V8.4H
    FMLS V15.2S, V17.2S, V0.S[0x0]
    FMOV  V9.8H, #1.68750000
    FABD  V14.8H, V23.8H, V28.8H
    FNEG  V30.4H, V5.4H
    FRECPS  V11.4S, V30.4S, V26.4S
    FABD  V10.4H, V9.4H, V7.4H
    FACGE  V1.4S, V10.4S, V10.4S
    FMLS H3, H16, V15.H[0x6]
    FMLS S29, S14, V14.S[0x0]
    FMLS H16, H11, V3.H[0x5]
    FACGE  V19.8H, V1.8H, V16.8H
    FSUB  V9.2S, V29.2S, V29.2S
    FADDP H18, V16.2H
    FADDP S15, V18.2S
    FACGT  V14.8H, V19.8H, V19.8H
    FDIV  V11.4H, V15.4H, V14.4H
    FACGT  V29.8H, V9.8H, V11.8H
    FABD  V1.4S, V11.4S, V3.4S
    FMLS V18.2D, V25.2D, V31.D[0x0]
    FRECPE  V13.8H, V23.8H
    FMLS H28, H1, V4.H[0x4]
    FMLA  V16.8H, V30.8H, V15.8H
    FMLS  V15.4H, V26.4H, V31.4H
    FRSQRTE  V8.2D, V27.2D
    FMUL V19.2D, V7.2D, V1.D[0x0]
    FMUL S1, S10, V9.S[0x1]
    FMOV  V10.8H, #10.50000000
    FRECPS  V30.2D, V29.2D, V1.2D
    FNEG  V17.4S, V19.4S
    FACGE  V1.2S, V10.2S, V28.2S
    FMLA V25.2S, V17.2S, V18.S[0x2]
    FADDP H3, V1.2H
    FADD  V27.4H, V10.4H, V25.4H
    FMULX V23.2S, V8.2S, V15.S[0x0]
    FDIV  V4.4H, V3.4H, V30.4H
    FRSQRTE  V18.4S, V16.4S
    FMULX  V19.4S, V4.4S, V13.4S
    FMOV  V14.4H, #-20.00000000
    FRSQRTE  V7.2S, V14.2S
    FMUL V15.2D, V7.2D, V7.D[0x1]
    FABS  V31.8H, V15.8H
    FMUL V11.2S, V19.2S, V31.S[0x1]
    FMUL V14.4H, V0.4H, V11.H[0x5]
    FMULX S8, S27, V14.S[0x1]
    FADDP  V29.2D, V8.2D, V18.2D
    FACGE  V25.4H, V23.4H, V23.4H
    FABS  V0.4S, V14.4S
    FMOV  V10.2S, #-0.23437500
    FADD  V7.4H, V10.4H, V0.4H
    FRECPE  V18.2D, V7.2D
    FMLA H10, H29, V9.H[0x2]
    FMULX S19, S18, V25.S[0x2]
    FRSQRTS  V14.4S, V19.4S, V10.4S
    FMULX S25, S28, V22.S[0x3]
    FRSQRTS  V9.4S, V2.4S, V16.4S
    FMLS  V15.8H, V1.8H, V13.8H
    FABD  V0.2D, V8.2D, V21.2D
    FMUL V23.2D, V19.2D, V30.D[0x1]
    FACGE  V4.2S, V18.2S, V19.2S
    FRECPE  V31.4S, V7.4S
    FSUB  V10.4S, V10.4S, V0.4S
    FMLA  V21.8H, V4.8H, V8.8H
    FMULX  V30.2D, V14.2D, V14.2D
    FMLA V11.8H, V22.8H, V2.H[0x4]
    FABS  V13.4S, V17.4S
    FMULX H28, H9, V9.H[0x4]
    FMLS  V22.4S, V25.4S, V13.4S
    FMULX V29.4H, V21.4H, V15.H[0x7]
    FMLS  V18.4H, V23.4H, V22.4H
    FMOV  V22.4H, #0.56250000
    FMLS  V2.8H, V22.8H, V22.8H
    FMLS  V22.4H, V29.4H, V10.4H
    FMLA  V7.2S, V22.2S, V15.2S
    FADDP  V19.4S, V28.4S, V31.4S
    FMULX  V9.4S, V11.4S, V19.4S
    FMLA D16, D18, V14.D[0x0]
    FACGE  V1.2S, V30.2S, V20.2S
    FMLA D21, D9, V8.D[0x1]
    FRSQRTS  V30.4H, V1.4H, V21.4H
    FMLS H21, H2, V5.H[0x4]
    FMLS  V4.8H, V7.8H, V25.8H
    FMOV  V31.4H, #27.00000000
    FRECPS  V7.8H, V16.8H, V21.8H
    FMOV  V16.2D, #16.00000000
    FMUL D13, D16, V30.D[0x0]
    FMULX H1, H31, V4.H[0x7]
    FRSQRTE  V21.8H, V1.8H
    FMULX  V18.8H, V7.8H, V7.8H
    FMLS  V16.8H, V21.8H, V21.8H
    FMLA V7.4H, V13.4H, V13.H[0x0]
    FNEG  V9.8H, V16.8H
    FMLA S14, S18, V9.S[0x0]
    FMLS V5.8H, V7.8H, V7.H[0x5]
    FMUL  V18.4H, V14.4H, V14.4H
    FMLA H14, H18, V9.H[0x6]
    FMULX  V25.2D, V14.2D, V5.2D
    FACGT  V30.4S, V6.4S, V10.4S
    FMULX V21.2D, V11.2D, V9.D[0x0]
    FMUL  V6.4S, V19.4S, V24.4S
    FMUL V2.4S, V15.4S, V12.S[0x1]
    FACGE  V24.8H, V15.8H, V21.8H
    FMULX  V11.4S, V30.4S, V6.4S
    FMULX V18.4S, V23.4S, V26.S[0x3]
    FRSQRTS  V7.2D, V12.2D, V26.2D
    FRSQRTS  V23.2D, V12.2D, V3.2D
    FMLS V16.2D, V31.2D, V26.D[0x0]
    FMULX V4.2D, V10.2D, V2.D[0x0]
    FMULX D10, D18, V24.D[0x0]
    SUBS  X4, X4, #0x1
    B.NE  TSRTAdvsimdVectorFloatingPointOperation_label_20
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x1f, LSL #0
    MRS  X25, FPSR
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff0, LSL #48
    FMOV  X25, D0
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X25, V2.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X25, D2
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    FMOV  X25, D3
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff0, LSL #48
    FMOV  X25, D4
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x7e00, LSL #32
    MOVK  X13, #0x7e00, LSL #48
    FMOV  X25, D5
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x3dc1, LSL #0
    MOVK  X13, #0x4000, LSL #16
    MOVK  X13, #0x7f80, LSL #48
    FMOV  X25, V6.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xf810, LSL #0
    MOVK  X13, #0x3afc, LSL #16
    FMOV  X25, D6
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff8, LSL #48
    FMOV  X25, V7.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff8, LSL #48
    FMOV  X25, D7
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7f80, LSL #16
    FMOV  X25, D8
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7c00, LSL #0
    MOVK  X13, #0x7c00, LSL #16
    MOVK  X13, #0x7c00, LSL #32
    MOVK  X13, #0x7c00, LSL #48
    FMOV  X25, V9.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7c00, LSL #0
    MOVK  X13, #0x7c00, LSL #16
    MOVK  X13, #0x7c00, LSL #32
    MOVK  X13, #0x7c00, LSL #48
    FMOV  X25, D9
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    MOVK  X13, #0x7fc0, LSL #48
    FMOV  X25, V11.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    FMOV  X25, D11
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X25, V12.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X25, D12
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x7e00, LSL #32
    MOVK  X13, #0x7e40, LSL #48
    FMOV  X25, D13
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    FMOV  X25, D14
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x7e00, LSL #32
    MOVK  X13, #0x7e00, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x7e00, LSL #32
    MOVK  X13, #0x7e00, LSL #48
    FMOV  X25, D15
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xfc00, LSL #0
    MOVK  X13, #0xfc00, LSL #16
    MOVK  X13, #0xfc00, LSL #32
    MOVK  X13, #0xfc00, LSL #48
    FMOV  X25, V16.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffef, LSL #48
    FMOV  X25, D16
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    MOVK  X13, #0x8000, LSL #48
    FMOV  X25, V17.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    MOVK  X13, #0xfff8, LSL #48
    FMOV  X25, D17
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x8000, LSL #0
    MOVK  X13, #0x17f, LSL #16
    MOVK  X13, #0x7f80, LSL #48
    FMOV  X25, V19.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    FMOV  X25, D19
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x4000, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x4000, LSL #32
    MOVK  X13, #0x7e00, LSL #48
    FMOV  X25, V20.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x4000, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x7c00, LSL #32
    MOVK  X13, #0x7c00, LSL #48
    FMOV  X25, D20
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff0, LSL #48
    FMOV  X25, D21
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x7e00, LSL #32
    MOVK  X13, #0x7e00, LSL #48
    FMOV  X25, D22
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff8, LSL #48
    FMOV  X25, V23.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff8, LSL #48
    FMOV  X25, D23
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, D24
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7c08, LSL #0
    MOVK  X13, #0x7c08, LSL #16
    MOVK  X13, #0x3c08, LSL #32
    MOVK  X13, #0x3bd0, LSL #48
    FMOV  X25, D25
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7c00, LSL #16
    MOVK  X13, #0x7c00, LSL #32
    MOVK  X13, #0x7c00, LSL #48
    FMOV  X25, D26
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x4940, LSL #32
    MOVK  X13, #0x7e00, LSL #48
    FMOV  X25, D27
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    FMOV  X25, D28
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    MOVK  X13, #0x7e00, LSL #16
    MOVK  X13, #0x7e00, LSL #32
    MOVK  X13, #0x7e00, LSL #48
    FMOV  X25, D29
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X25, V30.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    FMOV  X25, D30
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail
    MOVZ  X13, #0x4ec0, LSL #0
    MOVK  X13, #0x4ec0, LSL #16
    MOVK  X13, #0x4ec0, LSL #32
    MOVK  X13, #0x4ec0, LSL #48
    FMOV  X25, D31
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorFloatingPointOperation_TestFail

TSRTAdvsimdVectorFloatingPointOperation_TestEnd:
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
TSRTAdvsimdVectorFloatingPointOperation_TestFail:
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
