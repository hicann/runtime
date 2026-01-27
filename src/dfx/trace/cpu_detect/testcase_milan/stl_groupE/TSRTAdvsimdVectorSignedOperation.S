.global TSRTAdvsimdVectorSignedOperation

.text
.p2align 4

TSRTAdvsimdVectorSignedOperation:

TSRTAdvsimdVectorSignedOperation_TestBegin:
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
    MOVZ  X3, #0x7c28, LSL #0
    MOVK  X3, #0x56e1, LSL #16
    MOVK  X3, #0x4cb7, LSL #32
    MOVK  X3, #0x6337, LSL #48
    MOVZ  X4, #0x9b61, LSL #0
    MOVK  X4, #0x44e8, LSL #16
    MOVK  X4, #0x6f67, LSL #32
    MOVK  X4, #0x1012, LSL #48
    MOVZ  X5, #0xce89, LSL #0
    MOVK  X5, #0xb05c, LSL #16
    MOVK  X5, #0x84dc, LSL #32
    MOVK  X5, #0x1390, LSL #48
    MOVZ  X6, #0x844a, LSL #0
    MOVK  X6, #0x238d, LSL #16
    MOVK  X6, #0x7ca9, LSL #32
    MOVK  X6, #0xce63, LSL #48
    MOVZ  X7, #0x4ece, LSL #0
    MOVK  X7, #0x8321, LSL #16
    MOVK  X7, #0x3428, LSL #32
    MOVK  X7, #0xca34, LSL #48
    MOVZ  X10, #0x2e2e, LSL #0
    MOVK  X10, #0x49d8, LSL #16
    MOVK  X10, #0x10d0, LSL #32
    MOVK  X10, #0xcd9e, LSL #48
    MOVZ  X11, #0x613, LSL #0
    MOVK  X11, #0x5085, LSL #16
    MOVK  X11, #0x4e6d, LSL #32
    MOVK  X11, #0xd4f8, LSL #48
    MOVZ  X12, #0xc74b, LSL #0
    MOVK  X12, #0x5a09, LSL #16
    MOVK  X12, #0xf4a7, LSL #32
    MOVK  X12, #0x2755, LSL #48
    MOVZ  X13, #0x7a7, LSL #0
    MOVK  X13, #0xd35c, LSL #16
    MOVK  X13, #0xd566, LSL #32
    MOVK  X13, #0x541e, LSL #48
    MOVZ  X14, #0x31cb, LSL #0
    MOVK  X14, #0x63be, LSL #16
    MOVK  X14, #0x3d41, LSL #32
    MOVK  X14, #0xa99, LSL #48
    MOVZ  X15, #0x7f85, LSL #0
    MOVK  X15, #0xc4ff, LSL #16
    MOVK  X15, #0x5769, LSL #32
    MOVK  X15, #0x9cba, LSL #48
    MOVZ  X16, #0xd3f0, LSL #0
    MOVK  X16, #0x79dc, LSL #16
    MOVK  X16, #0x284a, LSL #32
    MOVK  X16, #0x40a6, LSL #48
    MOVZ  X17, #0x6041, LSL #0
    MOVK  X17, #0x2aab, LSL #16
    MOVK  X17, #0x3fea, LSL #32
    MOVK  X17, #0x8543, LSL #48
    MOVZ  X18, #0xc755, LSL #0
    MOVK  X18, #0x34c0, LSL #16
    MOVK  X18, #0x958b, LSL #32
    MOVK  X18, #0x9eb2, LSL #48
    MOVZ  X19, #0x392b, LSL #0
    MOVK  X19, #0xc14f, LSL #16
    MOVK  X19, #0x397, LSL #32
    MOVK  X19, #0xdc13, LSL #48
    MOVZ  X20, #0xf389, LSL #0
    MOVK  X20, #0x15ba, LSL #16
    MOVK  X20, #0x44f9, LSL #32
    MOVK  X20, #0xf065, LSL #48
    MOVZ  X21, #0x737e, LSL #0
    MOVK  X21, #0x87d9, LSL #16
    MOVK  X21, #0x4c28, LSL #32
    MOVK  X21, #0x8479, LSL #48
    MOVZ  X22, #0x67, LSL #0
    MOVK  X22, #0x87e4, LSL #16
    MOVK  X22, #0xa8c8, LSL #32
    MOVK  X22, #0xa21b, LSL #48
    MOVZ  X23, #0xea0a, LSL #0
    MOVK  X23, #0x4bd5, LSL #16
    MOVK  X23, #0x857a, LSL #32
    MOVK  X23, #0x4213, LSL #48
    MOVZ  X24, #0x83d0, LSL #0
    MOVK  X24, #0x8efb, LSL #16
    MOVK  X24, #0x6d7f, LSL #32
    MOVK  X24, #0xcb3a, LSL #48
    MOVZ  X25, #0x5b67, LSL #0
    MOVK  X25, #0xaf73, LSL #16
    MOVK  X25, #0x8d70, LSL #32
    MOVK  X25, #0x580e, LSL #48
    MOVZ  X26, #0x6c81, LSL #0
    MOVK  X26, #0x2d53, LSL #16
    MOVK  X26, #0xcc5a, LSL #32
    MOVK  X26, #0xd99, LSL #48
    MOVZ  X28, #0xc02e, LSL #0
    MOVK  X28, #0xbd31, LSL #16
    MOVK  X28, #0x6b0a, LSL #32
    MOVK  X28, #0x137e, LSL #48
    MOVZ  X29, #0xa248, LSL #0
    MOVK  X29, #0x82d6, LSL #16
    MOVK  X29, #0x8261, LSL #32
    MOVK  X29, #0xf484, LSL #48
    MOVZ  X29, #0x8110, LSL #0
    MOVK  X29, #0x2cc5, LSL #16
    MOVK  X29, #0x7fc0, LSL #32
    MOVK  X29, #0x7f8a, LSL #48
    MSR  FPCR, X29
    MOVZ  X29, #0xe4fb, LSL #0
    MOVK  X29, #0x3693, LSL #16
    MOVK  X29, #0xc503, LSL #32
    MOVK  X29, #0x7437, LSL #48
    MSR  FPSR, X29
    MRS  X5, FPSR
    MOVZ  X16, #0xff60, LSL #0
    MOVK  X16, #0x7ff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    AND  X5, X5, X16
    MOVZ  X16, #0x0, LSL #0
    ORR  X5, X5, X16
    MSR  FPSR, X5
    ISB  SY
    ANDS  W17, W23, W26, LSL #29
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X3, #0x9bee, LSL #0
    MOVK  X3, #0xb64d, LSL #16
    MOVK  X3, #0x3840, LSL #32
    MOVK  X3, #0x20ab, LSL #48
    MOVZ  X4, #0xbcd7, LSL #0
    MOVK  X4, #0xe1d1, LSL #16
    MOVK  X4, #0x2e3f, LSL #32
    MOVK  X4, #0x430d, LSL #48
    MOVZ  X5, #0xfae5, LSL #0
    MOVK  X5, #0x1e96, LSL #16
    MOVK  X5, #0x245d, LSL #32
    MOVK  X5, #0xb70, LSL #48
    MOVZ  X6, #0xc5b, LSL #0
    MOVK  X6, #0x1ddf, LSL #16
    MOVK  X6, #0xe3ce, LSL #32
    MOVK  X6, #0x24ea, LSL #48
    MOVZ  X7, #0x3ab8, LSL #0
    MOVK  X7, #0x2674, LSL #16
    MOVK  X7, #0x585b, LSL #32
    MOVK  X7, #0x5de3, LSL #48
    MOVZ  X10, #0xa040, LSL #0
    MOVK  X10, #0x7c46, LSL #16
    MOVK  X10, #0xcc2, LSL #32
    MOVK  X10, #0x76ee, LSL #48
    MOVZ  X11, #0x5932, LSL #0
    MOVK  X11, #0x480e, LSL #16
    MOVK  X11, #0x5a6a, LSL #32
    MOVK  X11, #0x3773, LSL #48
    MOVZ  X12, #0xb19d, LSL #0
    MOVK  X12, #0x737b, LSL #16
    MOVK  X12, #0x800c, LSL #32
    MOVK  X12, #0x1898, LSL #48
    MOVZ  X13, #0x1a3c, LSL #0
    MOVK  X13, #0xb7e9, LSL #16
    MOVK  X13, #0xb166, LSL #32
    MOVK  X13, #0xca57, LSL #48
    MOVZ  X14, #0xfc04, LSL #0
    MOVK  X14, #0x3fa, LSL #16
    MOVK  X14, #0xe8b3, LSL #32
    MOVK  X14, #0xf7be, LSL #48
    MOVZ  X15, #0xe8a5, LSL #0
    MOVK  X15, #0xaec6, LSL #16
    MOVK  X15, #0xbd51, LSL #32
    MOVK  X15, #0x4438, LSL #48
    MOVZ  X16, #0x90fc, LSL #0
    MOVK  X16, #0x6f64, LSL #16
    MOVK  X16, #0x7e9f, LSL #32
    MOVK  X16, #0xd851, LSL #48
    MOVZ  X17, #0x6179, LSL #0
    MOVK  X17, #0x18d0, LSL #16
    MOVK  X17, #0x88ae, LSL #32
    MOVK  X17, #0x2b2, LSL #48
    MOVZ  X18, #0x1415, LSL #0
    MOVK  X18, #0xa5d0, LSL #16
    MOVK  X18, #0xddb9, LSL #32
    MOVK  X18, #0x2585, LSL #48
    MOVZ  X19, #0x224e, LSL #0
    MOVK  X19, #0x5eef, LSL #16
    MOVK  X19, #0x5d1b, LSL #32
    MOVK  X19, #0x358, LSL #48
    MOVZ  X20, #0x78c5, LSL #0
    MOVK  X20, #0x3572, LSL #16
    MOVK  X20, #0x831d, LSL #32
    MOVK  X20, #0x7c3c, LSL #48
    MOVZ  X21, #0x5909, LSL #0
    MOVK  X21, #0x21d2, LSL #16
    MOVK  X21, #0xb658, LSL #32
    MOVK  X21, #0x1346, LSL #48
    MOVZ  X22, #0x6f3a, LSL #0
    MOVK  X22, #0x1609, LSL #16
    MOVK  X22, #0x1e1a, LSL #32
    MOVK  X22, #0xd10, LSL #48
    MOVZ  X23, #0xa24, LSL #0
    MOVK  X23, #0xcaec, LSL #16
    MOVK  X23, #0x9b30, LSL #32
    MOVK  X23, #0x4da6, LSL #48
    MOVZ  X24, #0x8343, LSL #0
    MOVK  X24, #0xf8ac, LSL #16
    MOVK  X24, #0xedad, LSL #32
    MOVK  X24, #0xbf4f, LSL #48
    MOVZ  X25, #0x5215, LSL #0
    MOVK  X25, #0x775d, LSL #16
    MOVK  X25, #0x3452, LSL #32
    MOVK  X25, #0xc41e, LSL #48
    MOVZ  X26, #0x82cd, LSL #0
    MOVK  X26, #0x772c, LSL #16
    MOVK  X26, #0x2aaa, LSL #32
    MOVK  X26, #0x12de, LSL #48
    MOVZ  X28, #0x6320, LSL #0
    MOVK  X28, #0xcaea, LSL #16
    MOVK  X28, #0x8560, LSL #32
    MOVK  X28, #0xe397, LSL #48
    MOVZ  X29, #0x41b0, LSL #0
    MOVK  X29, #0x59a4, LSL #16
    MOVK  X29, #0xddf3, LSL #32
    MOVK  X29, #0x4278, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X12
    FMOV  D3, X20
    FMOV  V3.D[1], X14
    FMOV  D4, X28
    FMOV  V4.D[1], X23
    FMOV  D5, X14
    FMOV  V5.D[1], X29
    FMOV  D6, X15
    FMOV  V6.D[1], X22
    FMOV  D7, X21
    FMOV  V7.D[1], X25
    FMOV  D8, X6
    FMOV  V8.D[1], X7
    FMOV  D9, X11
    FMOV  V9.D[1], X24
    FMOV  D10, X25
    FMOV  V10.D[1], X10
    FMOV  D11, X3
    FMOV  V11.D[1], X5
    FMOV  D12, X23
    FMOV  V12.D[1], X23
    FMOV  D13, X17
    FMOV  V13.D[1], X12
    FMOV  D14, X6
    FMOV  V14.D[1], X17
    FMOV  D15, X6
    FMOV  V15.D[1], X26
    FMOV  D16, X3
    FMOV  V16.D[1], X17
    FMOV  D17, X26
    FMOV  V17.D[1], X24
    FMOV  D18, X26
    FMOV  V18.D[1], X15
    FMOV  D19, X20
    FMOV  V19.D[1], X7
    FMOV  D20, X11
    FMOV  V20.D[1], X17
    FMOV  D21, X14
    FMOV  V21.D[1], X4
    FMOV  D22, X4
    FMOV  V22.D[1], X11
    FMOV  D23, X11
    FMOV  V23.D[1], X24
    FMOV  D24, X29
    FMOV  V24.D[1], X19
    FMOV  D25, X20
    FMOV  V25.D[1], X6
    FMOV  D26, X4
    FMOV  V26.D[1], X26
    FMOV  D27, X25
    FMOV  V27.D[1], X21
    FMOV  D28, X4
    FMOV  V28.D[1], X17
    FMOV  D29, X23
    FMOV  V29.D[1], X21
    FMOV  D30, X26
    FMOV  V30.D[1], X22
    FMOV  D31, X4
    FMOV  V31.D[1], X23
    MOVZ  X29, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_0:
    SMOV W17, V18.B[0x8]
    SMULL V21.2D, V28.2S, V28.S[0x0]
    SQRDMULH  V29.4H, V26.4H, V14.H[0x0]
    SQDMULL V5.4S, V24.4H, V9.H[0x2]
    SQDMULL V9.2D, V25.2S, V30.S[0x1]
    SQRSHRN2 V2.16B, V31.8H, #5
    SSRA  V7.4S, V27.4S, #30
    SQDMLSL2 V15.2D, V7.4S, V2.S[0x3]
    SQSHLU  V9.4H, V21.4H, #0xa
    SADALP  V29.4S, V29.8H
    SRSHR  V10.2S, V29.2S, #18
    SQDMLSL2 V11.4S, V9.8H, V10.H[0x3]
    SADALP  V28.1D, V15.2S
    SQDMLSL2  V27.2D, V28.4S, V5.4S
    SQADD  V30.4H, V11.4H, V11.4H
    SQSHRUN V18.4H, V5.4S, #12
    SQXTUN  V2.8B, V26.8H
    SQRSHRUN V21.8B, V2.8H, #5
    SADALP  V26.1D, V27.2S
    SABA  V29.8B, V21.8B, V26.8B
    SSHR V7.2D, V29.2D, #37
    SQXTUN2  V10.8H, V7.4S
    SQDMULL2 V29.4S, V10.8H, V10.H[0x7]
    SSRA  V31.16B, V29.16B, #8
    SQSHLU V2.2D, V31.2D, #0xc
    SSHR  V5.4S, V2.4S, #15
    SQDMLAL2  V2.2D, V30.4S, V5.4S
    SUQADD  V9.4S, V2.4S
    SMLAL  V25.8H, V9.8B, V9.8B
    SQDMULL S28, H18, V6.H[0x2]
    SMULL2 V11.4S, V25.8H, V5.H[0x0]
    SQDMULH S10, S28, V28.S[0x3]
    SQRSHRUN V21.8B, V10.8H, #2
    SMOV W19, V21.B[0x5]
    SQRDMULH  V5.4H, V10.4H, V11.H[0x2]
    SQRSHRUN2 V29.4S, V12.2D, #31
    SQDMULH  V10.2S, V4.2S, V25.2S
    SMLAL2  V15.8H, V7.16B, V5.16B
    SRSRA  V31.4H, V13.4H, #2
    SQXTN  V25.8B, V3.8H
    SQDMLAL S21, H23, V13.H[0x7]
    SQSHRN2 V6.4S, V6.2D, #6
    SQRSHRUN V23.2S, V21.2D, #6
    SSRA V9.2D, V7.2D, #57
    SMLSL V13.4S, V18.4H, V8.H[0x0]
    SRSRA  V2.4S, V6.4S, #14
    SADDW  V18.2D, V9.2D, V6.2S
    SXTL2 V8.2D, V13.4S
    SMLSL  V26.4S, V18.4H, V29.4H
    SRSHR V28.2D, V23.2D, #17
    SQDMULH  V7.4S, V31.4S, V8.S[0x0]
    SQSHL V23.2D, V7.2D, #0x11
    SQDMULL D3, S2, V25.S[0x2]
    SMULL  V21.4S, V26.4H, V26.4H
    SQSUB  V5.4H, V23.4H, V23.4H
    SMLSL V13.4S, V15.4H, V5.H[0x5]
    SQRSHRUN V5.2S, V13.2D, #21
    SQSHLU V9.2D, V5.2D, #0x23
    SQSHLU V7.2D, V9.2D, #0x2b
    SSHLL V15.8H, V28.8B, #0x6
    SSHR  V11.8B, V15.8B, #2
    SQDMLAL D9, S7, V3.S[0x3]
    SQXTUN  V5.8B, V9.8H
    SQRDMULH S6, S21, V21.S[0x2]
    SQDMLSL2 V3.2D, V6.4S, V5.S[0x3]
    SMLAL2 V8.2D, V11.4S, V3.S[0x3]
    SQDMULL S21, H8, V8.H[0x6]
    SQDMLAL S3, H17, V1.H[0x5]
    SMULL2 V18.2D, V3.4S, V21.S[0x3]
    SQDMLAL V6.4S, V12.4H, V8.H[0x7]
    SADDL  V17.8H, V13.8B, V4.8B
    SQDMULH  V28.4H, V31.4H, V0.H[0x0]
    SRSRA  V8.16B, V1.16B, #6
    SXTL V0.4S, V17.4H
    SABDL2  V7.4S, V6.8H, V6.8H
    SRSRA  V9.16B, V18.16B, #2
    SMULL V18.2D, V18.2S, V23.S[0x0]
    SQSHRN V11.4H, V23.4S, #10
    SQSHRUN V5.2S, V28.2D, #27
    SADDLV  S3, V14.4H
    SADDL2  V4.4S, V18.8H, V17.8H
    SMLSL  V23.4S, V21.4H, V23.4H
    SQDMLSL2 V14.4S, V9.8H, V9.H[0x7]
    SRSHR  V21.2S, V23.2S, #4
    SMLSL  V6.4S, V8.4H, V8.4H
    SQXTUN  V28.2S, V14.2D
    SQXTUN  V17.4H, V0.4S
    SQSHLU  V23.8B, V3.8B, #0x5
    SADDLV  S1, V17.4H
    SQSHRUN V0.8B, V7.8H, #5
    SXTL2 V3.2D, V0.4S
    SQSHRUN2 V14.16B, V3.8H, #2
    SQSHL  V0.4S, V4.4S, #0xb
    SQSHRUN2 V18.16B, V11.8H, #7
    SMOV  X23, V21.B[0x9]
    SQDMLSL2 V3.4S, V5.8H, V0.H[0x2]
    SQXTN  V9.4H, V15.4S
    SQSHLU  V8.8H, V14.8H, #0x7
    SMLAL2 V14.2D, V23.4S, V18.S[0x3]
    SADDW2  V18.4S, V6.4S, V14.8H
    SQADD  V4.4S, V9.4S, V1.4S
    SQDMLAL2 V15.4S, V28.8H, V4.H[0x6]
    SMLSL  V9.8H, V3.8B, V15.8B
    SQSHRN V15.2S, V9.2D, #29
    SQSHRN V2.8B, V15.8H, #3
    SXTL V15.8H, V7.8B
    SADDW  V4.8H, V8.8H, V8.8B
    SQRDMULH  V1.4H, V18.4H, V4.H[0x2]
    SSUBW  V17.4S, V1.4S, V2.4H
    SQSHRUN V2.8B, V15.8H, #3
    SABD  V9.2S, V2.2S, V17.2S
    SMULL  V23.2D, V19.2S, V1.2S
    SXTL2 V6.2D, V21.4S
    SXTL V3.8H, V25.8B
    SHADD  V14.4S, V11.4S, V15.4S
    SQSHL V7.2D, V29.2D, #0x14
    SABAL2  V8.8H, V27.16B, V29.16B
    SMOV  X6, V30.H[0x7]
    SQRSHRN2 V25.16B, V17.8H, #3
    SADDL2  V21.4S, V6.8H, V3.8H
    SQDMULH H11, H23, V9.H[0x5]
    SQSHRN2 V5.8H, V13.4S, #16
    SXTL V2.4S, V31.4H
    SQRSHRUN V23.4H, V3.4S, #7
    SABAL2  V30.4S, V7.8H, V7.8H
    SMOV  X4, V5.S[0x0]
    SSRA  V6.8H, V8.8H, #14
    SQRSHRUN V28.8B, V2.8H, #3
    SADDLV  S7, V11.8H
    SQRSHRUN2 V17.16B, V7.8H, #5
    SQXTUN2  V9.16B, V14.8H
    SMOV  X28, V9.B[0x5]
    SRSHR  V27.2S, V30.2S, #31
    SQSHRUN2 V18.4S, V27.2D, #1
    SHADD  V15.16B, V17.16B, V18.16B
    SQSHRN V29.4H, V23.4S, #16
    SQRSHRUN2 V23.16B, V28.8H, #7
    SADDLV  D19, V6.4S
    SQSHRN V9.4H, V21.4S, #2
    SQRDMULH  V17.4H, V9.4H, V25.4H
    SQSHRN2 V25.4S, V23.2D, #8
    SSHR  V6.4H, V15.4H, #7
    SQXTUN  V15.4H, V29.4S
    SRSRA  V7.4S, V26.4S, #5
    SQDMULL  V11.2D, V19.2S, V15.2S
    SXTL V3.8H, V25.8B
    SADDL  V18.2D, V31.2S, V11.2S
    SMLSL  V28.4S, V18.4H, V7.4H
    SQDMULL V14.2D, V3.2S, V28.S[0x0]
    SQRSHRN2 V27.4S, V17.2D, #11
    SQRSHRN2 V30.8H, V14.4S, #3
    SSHLL V21.2D, V17.2S, #0x1a
    SQDMULL D7, S27, V30.S[0x3]
    SMLSL2 V17.4S, V17.8H, V6.H[0x1]
    SQRSHRN2 V19.16B, V17.8H, #6
    SQSHL  V14.4S, V7.4S, #0x10
    SSRA V23.2D, V21.2D, #48
    SQSHL  V21.8H, V23.8H, #0x5
    SMLAL2 V23.4S, V19.8H, V14.H[0x2]
    SADDLV  D17, V29.4S
    SMLAL2 V26.2D, V11.4S, V23.S[0x3]
    SQSHRUN2 V15.4S, V26.2D, #5
    SSHR V29.2D, V15.2D, #48
    SQSHRUN V7.8B, V17.8H, #8
    SABDL2  V14.2D, V19.4S, V7.4S
    SQSHRN2 V30.8H, V29.4S, #4
    SQDMLAL2 V26.4S, V30.8H, V14.H[0x5]
    SSHR  V31.4S, V26.4S, #26
    SQDMLSL V17.2D, V31.2S, V4.S[0x0]
    SMLAL2 V6.4S, V17.8H, V1.H[0x2]
    SQDMLAL V29.2D, V6.2S, V21.S[0x3]
    SSHLL2 V27.2D, V26.4S, #0x1a
    SSUBL2  V11.8H, V28.16B, V19.16B
    SQDMLAL2  V1.4S, V30.8H, V0.8H
    SABA  V25.4H, V4.4H, V24.4H
    SQSHRUN2 V24.8H, V1.4S, #8
    SMLSL  V21.4S, V30.4H, V29.4H
    SMOV  X26, V11.B[0x6]
    SQRSHL  V4.8H, V26.8H, V23.8H
    SQRDMULH H23, H24, V5.H[0x7]
    SRSHR  V14.4S, V30.4S, #18
    SMULL2  V26.8H, V18.16B, V24.16B
    SQDMLAL S5, H3, V1.H[0x2]
    SQRDMULH S0, S2, V15.S[0x0]
    SMLSL  V30.2D, V27.2S, V5.2S
    SSRA  V27.4S, V25.4S, #17
    SQDMLAL2 V19.4S, V27.8H, V0.H[0x2]
    SMLAL V1.2D, V14.2S, V4.S[0x1]
    SRSHR  V7.16B, V1.16B, #6
    SSHR  V28.4H, V7.4H, #5
    SQDMLSL2  V6.2D, V30.4S, V30.4S
    SRSRA  V2.2S, V23.2S, #7
    SQRSHRUN2 V15.4S, V26.2D, #16
    SQRSHRUN V3.8B, V6.8H, #7
    SQSHRUN2 V14.16B, V29.8H, #4
    SQDMLAL V31.4S, V28.4H, V15.H[0x1]
    SHSUB  V28.2S, V26.2S, V19.2S
    SQDMLAL2  V4.4S, V2.8H, V2.8H
    SQRSHRN2 V15.16B, V4.8H, #2
    SMLAL V18.4S, V15.4H, V14.H[0x4]
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_0
    MOVZ  X12, #0x9bee, LSL #0
    MOVK  X12, #0xb64d, LSL #16
    MOVK  X12, #0x3840, LSL #32
    MOVK  X12, #0x20ab, LSL #48
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x3ab8, LSL #0
    MOVK  X12, #0x2674, LSL #16
    MOVK  X12, #0x585b, LSL #32
    MOVK  X12, #0x5de3, LSL #48
    SUB  X16, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0xa040, LSL #0
    MOVK  X12, #0x7c46, LSL #16
    MOVK  X12, #0xcc2, LSL #32
    MOVK  X12, #0x76ee, LSL #48
    SUB  X16, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x5932, LSL #0
    MOVK  X12, #0x480e, LSL #16
    MOVK  X12, #0x5a6a, LSL #32
    MOVK  X12, #0x3773, LSL #48
    SUB  X16, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x1a3c, LSL #0
    MOVK  X12, #0xb7e9, LSL #16
    MOVK  X12, #0xb166, LSL #32
    MOVK  X12, #0xca57, LSL #48
    SUB  X16, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0xfc04, LSL #0
    MOVK  X12, #0x3fa, LSL #16
    MOVK  X12, #0xe8b3, LSL #32
    MOVK  X12, #0xf7be, LSL #48
    SUB  X16, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0xe8a5, LSL #0
    MOVK  X12, #0xaec6, LSL #16
    MOVK  X12, #0xbd51, LSL #32
    MOVK  X12, #0x4438, LSL #48
    SUB  X16, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x42, LSL #0
    SUB  X16, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x1415, LSL #0
    MOVK  X12, #0xa5d0, LSL #16
    MOVK  X12, #0xddb9, LSL #32
    MOVK  X12, #0x2585, LSL #48
    SUB  X16, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x78c5, LSL #0
    MOVK  X12, #0x3572, LSL #16
    MOVK  X12, #0x831d, LSL #32
    MOVK  X12, #0x7c3c, LSL #48
    SUB  X16, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x5909, LSL #0
    MOVK  X12, #0x21d2, LSL #16
    MOVK  X12, #0xb658, LSL #32
    MOVK  X12, #0x1346, LSL #48
    SUB  X16, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x6f3a, LSL #0
    MOVK  X12, #0x1609, LSL #16
    MOVK  X12, #0x1e1a, LSL #32
    MOVK  X12, #0xd10, LSL #48
    SUB  X16, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x8343, LSL #0
    MOVK  X12, #0xf8ac, LSL #16
    MOVK  X12, #0xedad, LSL #32
    MOVK  X12, #0xbf4f, LSL #48
    SUB  X16, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x5215, LSL #0
    MOVK  X12, #0x775d, LSL #16
    MOVK  X12, #0x3452, LSL #32
    MOVK  X12, #0xc41e, LSL #48
    SUB  X16, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x800, LSL #16
    MRS  X16, FPSR
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x1b8e, LSL #0
    MOVK  X12, #0x634, LSL #32
    FMOV  X16, D2
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x1, LSL #16
    FMOV  X16, D3
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x4e0e, LSL #0
    FMOV  X16, D4
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0xffcc, LSL #0
    MOVK  X12, #0xffc3, LSL #16
    MOVK  X12, #0x43, LSL #32
    MOVK  X12, #0xffcb, LSL #48
    FMOV  X16, D6
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x62, LSL #0
    MOVK  X12, #0x36, LSL #16
    MOVK  X12, #0x4d, LSL #32
    MOVK  X12, #0x65, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x62, LSL #0
    MOVK  X12, #0x36, LSL #16
    MOVK  X12, #0x4d, LSL #32
    MOVK  X12, #0x65, LSL #48
    FMOV  X16, D8
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x36a9, LSL #0
    FMOV  X16, D10
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0xa24, LSL #0
    MOVK  X12, #0xcaec, LSL #16
    MOVK  X12, #0x9b30, LSL #32
    MOVK  X12, #0x4da6, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0xa24, LSL #0
    MOVK  X12, #0xcaec, LSL #16
    MOVK  X12, #0x9b30, LSL #32
    MOVK  X12, #0x4da6, LSL #48
    FMOV  X16, D12
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x82dd, LSL #0
    MOVK  X12, #0x737b, LSL #16
    MOVK  X12, #0x8c67, LSL #32
    MOVK  X12, #0x1898, LSL #48
    FMOV  X16, V13.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x6dd4, LSL #0
    MOVK  X12, #0x18d0, LSL #16
    MOVK  X12, #0x9509, LSL #32
    MOVK  X12, #0x2b2, LSL #48
    FMOV  X16, D13
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x7f, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x6179, LSL #0
    MOVK  X12, #0x18d0, LSL #16
    MOVK  X12, #0x88ae, LSL #32
    MOVK  X12, #0x2b2, LSL #48
    FMOV  X16, V16.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x9bee, LSL #0
    MOVK  X12, #0xb64d, LSL #16
    MOVK  X12, #0x3840, LSL #32
    MOVK  X12, #0x20ab, LSL #48
    FMOV  X16, D16
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0xe542, LSL #0
    MOVK  X12, #0xad, LSL #16
    FMOV  X16, V18.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x1b75, LSL #0
    MOVK  X12, #0x634, LSL #16
    FMOV  X16, D18
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x6179, LSL #0
    MOVK  X12, #0x18d0, LSL #16
    MOVK  X12, #0x88ae, LSL #32
    MOVK  X12, #0x2b2, LSL #48
    FMOV  X16, V20.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x5932, LSL #0
    MOVK  X12, #0x480e, LSL #16
    MOVK  X12, #0x5a6a, LSL #32
    MOVK  X12, #0x3773, LSL #48
    FMOV  X16, D20
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x4040, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x4000, LSL #0
    FMOV  X16, D21
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x5932, LSL #0
    MOVK  X12, #0x480e, LSL #16
    MOVK  X12, #0x5a6a, LSL #32
    MOVK  X12, #0x3773, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0xbcd7, LSL #0
    MOVK  X12, #0xe1d1, LSL #16
    MOVK  X12, #0x2e3f, LSL #32
    MOVK  X12, #0x430d, LSL #48
    FMOV  X16, D22
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0xc9f, LSL #0
    FMOV  X16, D23
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x41b0, LSL #0
    MOVK  X12, #0x59a4, LSL #16
    MOVK  X12, #0xddf3, LSL #32
    MOVK  X12, #0x4278, LSL #48
    FMOV  X16, D24
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x42b0, LSL #0
    MOVK  X12, #0x59a4, LSL #16
    MOVK  X12, #0x220d, LSL #32
    MOVK  X12, #0x4278, LSL #48
    FMOV  X16, D25
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x2cd2, LSL #0
    MOVK  X12, #0x213c, LSL #32
    FMOV  X16, D27
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X5, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X16
    FMOV  V0.D[1], X12
    FMOV  D1, X22
    FMOV  V1.D[1], X26
    FMOV  D2, X23
    FMOV  V2.D[1], X15
    FMOV  D3, X21
    FMOV  V3.D[1], X29
    FMOV  D4, X20
    FMOV  V4.D[1], X28
    FMOV  D5, X19
    FMOV  V5.D[1], X25
    FMOV  D6, X24
    FMOV  V6.D[1], X26
    FMOV  D7, X13
    FMOV  V7.D[1], X24
    FMOV  D8, X14
    FMOV  V8.D[1], X3
    FMOV  D9, X13
    FMOV  V9.D[1], X26
    FMOV  D10, X13
    FMOV  V10.D[1], X5
    FMOV  D11, X13
    FMOV  V11.D[1], X4
    FMOV  D12, X22
    FMOV  V12.D[1], X24
    FMOV  D13, X16
    FMOV  V13.D[1], X7
    FMOV  D14, X17
    FMOV  V14.D[1], X29
    FMOV  D15, X26
    FMOV  V15.D[1], X6
    FMOV  D16, X15
    FMOV  V16.D[1], X19
    FMOV  D17, X5
    FMOV  V17.D[1], X15
    FMOV  D18, X28
    FMOV  V18.D[1], X18
    FMOV  D19, X19
    FMOV  V19.D[1], X17
    FMOV  D20, X21
    FMOV  V20.D[1], X22
    FMOV  D21, X14
    FMOV  V21.D[1], X18
    FMOV  D22, X22
    FMOV  V22.D[1], X20
    FMOV  D23, X29
    FMOV  V23.D[1], X13
    FMOV  D24, X16
    FMOV  V24.D[1], X3
    FMOV  D25, X19
    FMOV  V25.D[1], X7
    FMOV  D26, X7
    FMOV  V26.D[1], X10
    FMOV  D27, X18
    FMOV  V27.D[1], X20
    FMOV  D28, X13
    FMOV  V28.D[1], X12
    FMOV  D29, X22
    FMOV  V29.D[1], X12
    FMOV  D30, X26
    FMOV  V30.D[1], X4
    FMOV  D31, X25
    FMOV  V31.D[1], X17
    MOVZ  X25, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_1:
    SQRDMULH S17, S27, V23.S[0x2]
    SQDMLAL2 V14.2D, V30.4S, V29.S[0x3]
    SQSHRN2 V6.16B, V17.8H, #1
    SMLAL2 V11.2D, V19.4S, V26.S[0x2]
    SXTL V7.4S, V22.4H
    SRSHR  V8.8H, V31.8H, #5
    SQSHRUN2 V14.8H, V28.4S, #11
    SMULL V20.4S, V14.4H, V2.H[0x1]
    SRSRA  V28.4H, V6.4H, #15
    SRSHR  V22.16B, V28.16B, #8
    SQDMLSL V14.4S, V8.4H, V11.H[0x1]
    SQDMLAL2 V27.2D, V14.4S, V24.S[0x2]
    SQDMLAL2  V2.2D, V22.4S, V27.4S
    SQDMULL2  V23.4S, V25.8H, V2.8H
    SXTL2 V2.8H, V7.16B
    SQSHL V29.2D, V2.2D, #0x11
    SSHR  V26.8B, V20.8B, #3
    SADDLV  S30, V29.8H
    SSRA  V17.2S, V23.2S, #20
    SABDL  V23.2D, V30.2S, V17.2S
    SRSHR  V25.8B, V23.8B, #4
    SQDMULH S27, S25, V26.S[0x0]
    SRSHL  V6.2S, V1.2S, V6.2S
    SQDMLSL2 V2.4S, V3.8H, V13.H[0x2]
    SQRDMULH  V28.8H, V3.8H, V22.8H
    SQRDMULH  V23.4S, V24.4S, V6.S[0x2]
    SQDMLSL D7, S5, V5.S[0x2]
    SADDL2  V8.4S, V6.8H, V17.8H
    SQDMULH  V5.4H, V0.4H, V6.4H
    SMLAL  V26.4S, V22.4H, V31.4H
    SRSHR  V19.4S, V31.4S, #2
    SABAL  V11.8H, V23.8B, V5.8B
    SQDMULL V14.2D, V21.2S, V28.S[0x1]
    SMLSL2  V0.8H, V14.16B, V4.16B
    SSRA  V7.8H, V23.8H, #12
    SQSHRN2 V31.4S, V7.2D, #16
    SXTL V23.2D, V27.2S
    SMLSL2  V4.8H, V0.16B, V23.16B
    SQSHRUN V22.4H, V8.4S, #11
    SMULL V17.2D, V22.2S, V24.S[0x0]
    SSRA  V14.16B, V13.16B, #8
    SQDMULL D21, S2, V4.S[0x3]
    SMLAL2 V2.4S, V25.8H, V8.H[0x5]
    SXTL V1.4S, V21.4H
    SMULL  V7.4S, V26.4H, V14.4H
    SQDMLSL V26.2D, V1.2S, V31.S[0x0]
    SQDMLAL2 V6.4S, V17.8H, V7.H[0x6]
    SSHR  V30.4H, V6.4H, #8
    SADDW  V8.8H, V26.8H, V2.8B
    SADDLV  H25, V19.16B
    SMLSL  V6.2D, V11.2S, V11.2S
    SMOV  X14, V6.S[0x3]
    SSHLL2 V14.8H, V30.16B, #0x2
    SXTL2 V31.2D, V14.4S
    SQDMLAL V1.2D, V25.2S, V25.S[0x0]
    SSHR  V23.4S, V1.4S, #3
    SMOV W28, V23.H[0x6]
    SXTL V19.8H, V8.8B
    SQDMULH  V13.2S, V31.2S, V31.S[0x0]
    SQSHRN V26.2S, V5.2D, #22
    SQSHL V5.2D, V19.2D, #0x12
    SSUBW  V17.8H, V13.8H, V13.8B
    SMLAL2 V23.4S, V5.8H, V5.H[0x6]
    SSHLL2 V19.4S, V12.8H, #0x5
    SQDMLSL2 V6.2D, V19.4S, V26.S[0x1]
    SQDMULH S25, S17, V6.S[0x3]
    SSHLL V2.2D, V23.2S, #0x1a
    SRSRA V5.2D, V2.2D, #45
    SMLSL2 V23.2D, V25.4S, V5.S[0x2]
    SHSUB  V31.16B, V18.16B, V18.16B
    SQSHLU  V14.16B, V9.16B, #0x0
    SSHLL V21.4S, V8.4H, #0x5
    SMLAL2 V30.2D, V17.4S, V20.S[0x2]
    SQDMLSL2 V7.4S, V25.8H, V9.H[0x6]
    SMULL V25.4S, V20.4H, V7.H[0x2]
    SQDMLSL V17.2D, V14.2S, V0.S[0x2]
    SQSHRUN2 V9.16B, V0.8H, #2
    SMOV  X19, V0.B[0x9]
    SMLSL2 V20.2D, V21.4S, V23.S[0x3]
    SQXTN  V1.8B, V18.8H
    SQDMLAL2 V2.2D, V25.4S, V20.S[0x3]
    SQSHL V14.2D, V0.2D, #0x38
    SSHR  V7.8B, V29.8B, #5
    SQRSHL  V8.4H, V24.4H, V27.4H
    SQDMLSL D23, S17, V21.S[0x3]
    SQDMLSL2 V25.2D, V30.4S, V2.S[0x3]
    SABDL2  V2.2D, V14.4S, V7.4S
    SSHR  V18.8H, V2.8H, #3
    SSHR  V2.4H, V31.4H, #14
    SMULL2 V17.2D, V9.4S, V8.S[0x1]
    SMLAL  V20.8H, V2.8B, V17.8B
    SSHR V2.2D, V1.2D, #42
    SQDMULH  V9.8H, V25.8H, V25.8H
    SQDMLSL2  V6.2D, V2.4S, V23.4S
    SSHLL V23.4S, V18.4H, #0xd
    SADDW2  V5.8H, V28.8H, V23.16B
    SQRSHRUN V8.2S, V6.2D, #8
    SQDMULH  V28.4H, V20.4H, V9.H[0x0]
    SQRSHRN2 V2.4S, V5.2D, #22
    SQDMLSL S30, H2, V8.H[0x4]
    SMULL V9.2D, V28.2S, V30.S[0x0]
    SADDW2  V24.2D, V1.2D, V0.4S
    SQSHRUN V28.8B, V17.8H, #1
    SABDL  V31.2D, V22.2S, V29.2S
    SMLAL2  V18.2D, V19.4S, V8.4S
    SQRDMULH  V25.4H, V21.4H, V27.4H
    SSRA  V19.16B, V31.16B, #8
    SSHR  V7.16B, V13.16B, #2
    SADDW  V8.2D, V13.2D, V31.2S
    SXTL V2.4S, V20.4H
    SRSRA  V17.8B, V9.8B, #4
    SQXTN  V21.4H, V17.4S
    SQRSHRN V9.2S, V0.2D, #5
    SQABS  V22.16B, V20.16B
    SQXTUN  V23.8B, V22.8H
    SQDMLAL2 V20.4S, V18.8H, V5.H[0x1]
    SQRDMULH  V29.2S, V28.2S, V28.S[0x3]
    SQDMLSL2  V18.2D, V24.4S, V21.4S
    SQRDMULH S24, S15, V8.S[0x1]
    SQDMLSL2 V31.4S, V9.8H, V7.H[0x5]
    SQSHRN2 V8.8H, V31.4S, #7
    SMLAL  V0.2D, V18.2S, V23.2S
    SQNEG  V17.2S, V24.2S
    SMULL2  V5.4S, V29.8H, V29.8H
    SMULL V27.2D, V0.2S, V5.S[0x3]
    SUQADD  V21.16B, V27.16B
    SMLAL V6.2D, V19.2S, V21.S[0x2]
    SQRSHRUN V21.8B, V8.8H, #7
    SQRSHRUN2 V22.4S, V21.2D, #3
    SRSHR  V18.16B, V17.16B, #1
    SSHR  V23.8H, V6.8H, #11
    SSHR V15.2D, V18.2D, #49
    SQRSHRUN V31.8B, V15.8H, #3
    SRSHR  V13.16B, V20.16B, #6
    SQXTUN2  V18.8H, V13.4S
    SMLAL  V7.8H, V18.8B, V23.8B
    SMOV  X24, V7.S[0x3]
    SSUBL  V19.8H, V31.8B, V31.8B
    SQRSHL  V27.8H, V22.8H, V19.8H
    SQRSHRN2 V28.8H, V27.4S, #4
    SQRSHRN2 V22.16B, V28.8H, #1
    SSHLL2 V0.8H, V22.16B, #0x3
    SQSHRN2 V27.4S, V31.2D, #21
    SXTL2 V17.2D, V14.4S
    SMLAL V5.2D, V4.2S, V19.S[0x1]
    SMLAL2 V8.4S, V21.8H, V15.H[0x0]
    SQDMULH S7, S23, V16.S[0x1]
    SSUBW2  V9.8H, V23.8H, V29.16B
    SQDMULL  V24.4S, V13.4H, V5.4H
    SQDMULL V5.4S, V7.4H, V10.H[0x6]
    SQXTN  V29.2S, V7.2D
    SQDMLSL S7, H13, V8.H[0x6]
    SSHL  V31.8B, V16.8B, V20.8B
    SQDMLSL2 V23.2D, V0.4S, V31.S[0x3]
    SSHR  V0.16B, V17.16B, #6
    SSHLL2 V6.8H, V0.16B, #0x2
    SSRA  V14.8H, V9.8H, #9
    SQDMLSL D15, S14, V5.S[0x0]
    SSHLL V28.2D, V7.2S, #0x16
    SQSHRN V14.4H, V23.4S, #5
    SQDMLAL2 V20.4S, V24.8H, V14.H[0x6]
    SSHR  V19.16B, V15.16B, #7
    SMLSL2 V4.2D, V28.4S, V6.S[0x1]
    SSHLL2 V5.8H, V19.16B, #0x5
    SQSHRN2 V28.4S, V27.2D, #12
    SXTL V21.2D, V5.2S
    SQSUB  V0.4S, V21.4S, V29.4S
    SRSHR  V5.8B, V28.8B, #6
    SADDW  V10.4S, V5.4S, V5.4H
    SQRSHRUN V14.8B, V4.8H, #7
    SMULL2  V28.2D, V20.4S, V31.4S
    SQSUB  V27.4S, V0.4S, V28.4S
    SSHLL2 V13.2D, V10.4S, #0x10
    SQSHRUN V15.2S, V27.2D, #11
    SSHR  V6.8B, V15.8B, #6
    SQSHL  V24.2S, V6.2S, #0x8
    SQDMULL2 V4.4S, V13.8H, V13.H[0x5]
    SQDMLAL D31, S14, V4.S[0x2]
    SMLSL  V23.2D, V31.2S, V24.2S
    SQSHL  V31.16B, V27.16B, #0x3
    SADDLV  H6, V10.8B
    SXTL V4.4S, V4.4H
    SQDMULH H5, H31, V8.H[0x5]
    SRSHR V29.2D, V6.2D, #1
    SHADD  V27.4H, V7.4H, V23.4H
    SQRSHRUN2 V7.4S, V19.2D, #3
    SQRSHRUN V9.8B, V14.8H, #3
    SMLSL2 V6.4S, V12.8H, V0.H[0x0]
    SRSHR V13.2D, V30.2D, #50
    SQDMLSL  V23.2D, V5.2S, V31.2S
    SMOV  X21, V23.B[0xf]
    SQSHL  V5.4S, V30.4S, V16.4S
    SRSHR  V24.8H, V28.8H, #8
    SQRSHRUN2 V10.4S, V5.2D, #2
    SSHLL2 V12.2D, V24.4S, #0x1c
    SMLSL  V14.2D, V4.2S, V13.2S
    SQSHL V8.2D, V9.2D, #0x8
    SQSUB  V9.4H, V10.4H, V6.4H
    SADDW  V15.8H, V7.8H, V27.8B
    SSHLL V16.8H, V9.8B, #0x5
    SUBS  X25, X25, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_1
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x800, LSL #16
    MRS  X6, FPSR
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D0
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D1
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D2
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D3
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D4
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D5
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D6
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D8
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D10
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D11
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D12
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D13
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D14
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D16
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D17
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D20
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D21
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D23
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D27
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D29
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X6, D31
    SUB  X26, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X23
    FMOV  D3, X19
    FMOV  V3.D[1], X11
    FMOV  D4, X6
    FMOV  V4.D[1], X14
    FMOV  D5, X12
    FMOV  V5.D[1], X10
    FMOV  D6, X21
    FMOV  V6.D[1], X10
    FMOV  D7, X7
    FMOV  V7.D[1], X17
    FMOV  D8, X7
    FMOV  V8.D[1], X24
    FMOV  D9, X19
    FMOV  V9.D[1], X10
    FMOV  D10, X7
    FMOV  V10.D[1], X28
    FMOV  D11, X3
    FMOV  V11.D[1], X4
    FMOV  D12, X23
    FMOV  V12.D[1], X24
    FMOV  D13, X14
    FMOV  V13.D[1], X6
    FMOV  D14, X14
    FMOV  V14.D[1], X10
    FMOV  D15, X13
    FMOV  V15.D[1], X20
    FMOV  D16, X5
    FMOV  V16.D[1], X10
    FMOV  D17, X5
    FMOV  V17.D[1], X19
    FMOV  D18, X5
    FMOV  V18.D[1], X5
    FMOV  D19, X7
    FMOV  V19.D[1], X13
    FMOV  D20, X19
    FMOV  V20.D[1], X24
    FMOV  D21, X12
    FMOV  V21.D[1], X24
    FMOV  D22, X20
    FMOV  V22.D[1], X17
    FMOV  D23, X16
    FMOV  V23.D[1], X19
    FMOV  D24, X18
    FMOV  V24.D[1], X10
    FMOV  D25, X3
    FMOV  V25.D[1], X26
    FMOV  D26, X11
    FMOV  V26.D[1], X3
    FMOV  D27, X19
    FMOV  V27.D[1], X24
    FMOV  D28, X4
    FMOV  V28.D[1], X7
    FMOV  D29, X16
    FMOV  V29.D[1], X26
    FMOV  D30, X10
    FMOV  V30.D[1], X24
    FMOV  D31, X13
    FMOV  V31.D[1], X21
    MOVZ  X15, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_2:
    SQSHRN2 V15.16B, V25.8H, #6
    SADDLP  V20.2D, V24.4S
    SADALP  V3.1D, V31.2S
    SADDW  V15.2D, V28.2D, V21.2S
    SQRDMULH S2, S26, V15.S[0x3]
    SRSRA  V0.4H, V20.4H, #11
    SSRA  V24.8H, V0.8H, #7
    SADDLV  H3, V3.8B
    SABDL2  V31.8H, V29.16B, V29.16B
    SMULL V8.4S, V2.4H, V12.H[0x5]
    SQSHRUN2 V31.16B, V24.8H, #5
    SADALP  V16.2S, V3.4H
    SADDLP  V1.2D, V8.4S
    SQDMLSL S1, H30, V15.H[0x1]
    SABA  V9.8H, V1.8H, V16.8H
    SSHL  V12.2S, V9.2S, V31.2S
    SQSHRUN V31.2S, V27.2D, #3
    SXTL2 V28.4S, V12.8H
    SXTL2 V29.2D, V31.4S
    SXTL V1.2D, V28.2S
    SQRDMULH  V21.4H, V14.4H, V29.4H
    SQDMULL2 V2.4S, V21.8H, V1.H[0x6]
    SQDMLSL V1.4S, V11.4H, V13.H[0x3]
    SQXTN  V13.2S, V1.2D
    SQSHRN2 V0.8H, V31.4S, #10
    SSHR  V15.4H, V19.4H, #3
    SQDMLSL S28, H30, V1.H[0x3]
    SRSRA V1.2D, V3.2D, #41
    SSRA V16.2D, V2.2D, #37
    SQDMULL2  V20.4S, V30.8H, V8.8H
    SQSHRUN2 V31.16B, V19.8H, #4
    SSUBW2  V19.4S, V7.4S, V26.8H
    SSRA  V2.8B, V28.8B, #4
    SSRA  V30.8B, V13.8B, #4
    SQXTN2  V3.4S, V0.2D
    SSHR V26.2D, V15.2D, #54
    SQDMLSL  V15.2D, V26.2S, V20.2S
    SQSHLU V11.2D, V30.2D, #0x2c
    SABA  V8.4H, V3.4H, V3.4H
    SQRSHRUN V28.8B, V8.8H, #7
    SQSHLU  V20.8H, V2.8H, #0xf
    SQSHL  V2.8B, V1.8B, #0x0
    SRSHR  V3.2S, V19.2S, #11
    SMLSL2 V14.2D, V15.4S, V11.S[0x3]
    SQXTUN  V0.2S, V31.2D
    SQXTN2  V7.4S, V20.2D
    SQSHL  V19.4S, V28.4S, #0x9
    SMULL V20.4S, V14.4H, V3.H[0x2]
    SSUBW  V1.2D, V2.2D, V19.2S
    SQDMLSL2 V8.2D, V20.4S, V0.S[0x2]
    SABDL2  V21.8H, V7.16B, V1.16B
    SQRDMULH  V11.4H, V21.4H, V8.H[0x6]
    SMLSL2 V28.2D, V16.4S, V11.S[0x1]
    SABD  V30.4S, V3.4S, V0.4S
    SRSRA  V0.16B, V11.16B, #5
    SQSHL  V19.4H, V29.4H, #0x4
    SMOV  X17, V29.H[0x5]
    SSHLL V31.2D, V28.2S, #0x8
    SSHLL V29.2D, V26.2S, #0xd
    SSHLL V13.4S, V0.4H, #0x9
    SRSHR V15.2D, V31.2D, #16
    SQSHLU  V31.8H, V29.8H, #0xe
    SMLAL2 V8.4S, V11.8H, V6.H[0x1]
    SQSHRUN V16.2S, V27.2D, #7
    SSUBL2  V14.4S, V17.8H, V24.8H
    SXTL V19.8H, V27.8B
    SADDLP  V27.8H, V27.16B
    SQADD  V3.2S, V30.2S, V14.2S
    SQDMULL2 V7.4S, V3.8H, V9.H[0x6]
    SQDMULL2 V6.4S, V15.8H, V15.H[0x2]
    SSHLL2 V24.8H, V31.16B, #0x5
    SQDMLSL  V26.4S, V8.4H, V7.4H
    SQDMLAL  V17.2D, V13.2S, V16.2S
    SQRSHRN2 V9.8H, V24.4S, #13
    SQRSHRN V2.4H, V19.4S, #6
    SQDMLSL2  V14.4S, V2.8H, V9.8H
    SABD  V13.8B, V27.8B, V27.8B
    SQDMULH H0, H17, V14.H[0x6]
    SXTL V2.2D, V7.2S
    SQRSHRUN V31.4H, V6.4S, #14
    SABDL2  V17.2D, V0.4S, V2.4S
    SQSHLU  V21.4S, V26.4S, #0xa
    SQRDMULH  V14.4S, V31.4S, V13.4S
    SQDMULH H3, H21, V14.H[0x6]
    SSUBL  V7.2D, V3.2S, V3.2S
    SRSHR V3.2D, V7.2D, #53
    SQSHRN2 V26.4S, V17.2D, #5
    SQSHRUN V27.4H, V26.4S, #6
    SRSRA  V26.2S, V3.2S, #20
    SRSHR  V17.4H, V27.4H, #4
    SRSHR V16.2D, V26.2D, #52
    SQSHRN V3.4H, V17.4S, #12
    SRSRA  V24.4S, V16.4S, #12
    SADDLV  H7, V15.8B
    SQXTUN2  V14.4S, V7.2D
    SSHR  V21.2S, V14.2S, #22
    SQDMULH S17, S21, V24.S[0x1]
    SSHLL2 V24.8H, V13.16B, #0x7
    SQSHRN V27.4H, V3.4S, #10
    SQDMLAL2  V15.2D, V1.4S, V27.4S
    SQSHRUN2 V14.16B, V15.8H, #7
    SQSHL V26.2D, V14.2D, #0x1b
    SQDMLSL V16.2D, V17.2S, V22.S[0x1]
    SQRSHRUN V7.4H, V26.4S, #15
    SADDL  V2.8H, V7.8B, V24.8B
    SMULL V1.4S, V2.4H, V14.H[0x1]
    SQABS  V7.8H, V16.8H
    SSHLL V3.4S, V7.4H, #0x8
    SUQADD  V24.16B, V1.16B
    SSHR  V16.8B, V3.8B, #3
    SABDL2  V22.8H, V24.16B, V24.16B
    SRHADD  V21.4H, V22.4H, V22.4H
    SQRSHRUN V1.2S, V21.2D, #31
    SQDMULL2 V17.2D, V1.4S, V1.S[0x2]
    SRSRA  V15.8H, V16.8H, #2
    SHSUB  V22.8B, V17.8B, V15.8B
    SQDMLAL S22, H21, V3.H[0x7]
    SRSRA V27.2D, V2.2D, #3
    SQRSHRN V26.8B, V20.8H, #8
    SQRSHRUN2 V3.16B, V26.8H, #3
    SQRSHRUN V14.2S, V17.2D, #20
    SQDMULH  V13.4S, V3.4S, V15.S[0x2]
    SMULL V24.4S, V7.4H, V8.H[0x7]
    SQABS  V2.4H, V12.4H
    SQDMLAL2 V8.2D, V15.4S, V7.S[0x3]
    SQRDMULH  V15.4H, V30.4H, V9.4H
    SMULL2 V17.4S, V21.8H, V0.H[0x4]
    SSHR  V30.8H, V31.8H, #10
    SQRDMULH  V31.4H, V8.4H, V22.4H
    SQRSHRUN2 V8.16B, V31.8H, #6
    SQDMULL V20.2D, V24.2S, V15.S[0x0]
    SABDL2  V24.4S, V2.8H, V14.8H
    SUQADD  V15.4S, V27.4S
    SQDMULL D3, S24, V17.S[0x3]
    SXTL V16.2D, V20.2S
    SSUBL  V21.4S, V31.4H, V13.4H
    SQRSHRN2 V26.4S, V15.2D, #19
    SSUBW2  V20.2D, V30.2D, V26.4S
    SQDMLAL S0, H8, V9.H[0x2]
    SRSHL  V13.4S, V0.4S, V0.4S
    SADDL2  V24.2D, V13.4S, V21.4S
    SQRSHRN V8.2S, V16.2D, #13
    SXTL2 V7.8H, V20.16B
    SMLAL  V21.8H, V3.8B, V3.8B
    SMOV W24, V21.B[0x0]
    SMLAL  V26.8H, V8.8B, V7.8B
    SABA  V7.4S, V24.4S, V26.4S
    SUQADD  V20.2D, V3.2D
    SQSHRUN2 V31.4S, V0.2D, #9
    SRSRA  V9.8B, V16.8B, #1
    SQSHRUN2 V24.16B, V16.8H, #6
    SQDMULH  V22.8H, V19.8H, V9.H[0x7]
    SQRSHRUN2 V12.8H, V14.4S, #2
    SQRSHL  V0.8B, V27.8B, V9.8B
    SQSHRN V13.8B, V16.8H, #3
    SQNEG  V16.8H, V21.8H
    SHSUB  V8.4S, V16.4S, V7.4S
    SRHADD  V21.4H, V13.4H, V8.4H
    SMLAL  V3.2D, V24.2S, V12.2S
    SHADD  V13.4S, V31.4S, V21.4S
    SRSRA  V16.8H, V13.8H, #6
    SMLAL2  V13.4S, V22.8H, V0.8H
    SXTL V8.2D, V16.2S
    SQSHRN V22.8B, V20.8H, #3
    SXTL V20.2D, V22.2S
    SSUBL2  V9.2D, V8.4S, V8.4S
    SSUBW2  V21.4S, V3.4S, V13.8H
    SHADD  V0.8B, V20.8B, V9.8B
    SQDMLSL2  V26.2D, V21.4S, V21.4S
    SQSHLU  V20.4H, V0.4H, #0xf
    SQDMULL D22, S20, V20.S[0x3]
    SQSHRN2 V19.8H, V26.4S, #7
    SQDMULL  V22.2D, V22.2S, V22.2S
    SQSHL  V13.8H, V19.8H, #0x2
    SMLSL V9.4S, V13.4H, V13.H[0x4]
    SQXTN2  V21.16B, V22.8H
    SMLAL2 V8.2D, V21.4S, V9.S[0x3]
    SQDMLAL2 V22.4S, V6.8H, V13.H[0x3]
    SQDMULH H31, H26, V15.H[0x4]
    SQNEG  V19.2S, V19.2S
    SSHLL V20.4S, V26.4H, #0x3
    SQDMULH S6, S2, V15.S[0x0]
    SSHL  V13.2S, V6.2S, V10.2S
    SMLSL2 V3.4S, V3.8H, V8.H[0x5]
    SMOV  X12, V26.B[0x8]
    SXTL V9.2D, V30.2S
    SQDMLAL V0.2D, V25.2S, V6.S[0x1]
    SQDMLAL2 V21.2D, V25.4S, V27.S[0x2]
    SQSHL  V6.2S, V21.2S, #0xb
    SQSUB  V2.16B, V9.16B, V3.16B
    SADDL  V16.8H, V0.8B, V22.8B
    SSHLL2 V3.8H, V20.16B, #0x6
    SMLSL V27.2D, V19.2S, V6.S[0x0]
    SADDW2  V26.2D, V23.2D, V27.4S
    SXTL V30.2D, V16.2S
    SSRA  V9.2S, V2.2S, #13
    SQSHLU  V15.8B, V30.8B, #0x0
    SMLSL2 V30.4S, V15.8H, V15.H[0x6]
    SSRA  V21.8B, V9.8B, #5
    SQDMLSL  V23.2D, V3.2S, V26.2S
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_2
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X22, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X22, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x800, LSL #16
    MRS  X22, FPSR
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D0
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V1.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D1
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D2
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D3
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, V4.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, D4
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, V5.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, D5
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D6
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D7
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D8
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D9
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, V10.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, D10
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D11
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D12
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D13
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V14.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D14
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D15
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D16
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D17
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, V18.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, D18
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D20
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D21
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D22
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, V23.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, D23
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, V25.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, D25
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, V26.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    FMOV  X22, D26
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D27
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D28
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D29
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D30
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X22, D31
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x24d, LSL #0
    MOVK  X3, #0xa2c9, LSL #16
    MOVK  X3, #0x4bb7, LSL #32
    MOVK  X3, #0x247a, LSL #48
    MOVZ  X4, #0x8221, LSL #0
    MOVK  X4, #0x9cd3, LSL #16
    MOVK  X4, #0x8840, LSL #32
    MOVK  X4, #0x75c9, LSL #48
    MOVZ  X5, #0x143d, LSL #0
    MOVK  X5, #0x5eb4, LSL #16
    MOVK  X5, #0xaf2b, LSL #32
    MOVK  X5, #0x642a, LSL #48
    MOVZ  X6, #0x22a8, LSL #0
    MOVK  X6, #0x5599, LSL #16
    MOVK  X6, #0xb65f, LSL #32
    MOVK  X6, #0xe5ba, LSL #48
    MOVZ  X7, #0xee88, LSL #0
    MOVK  X7, #0x52ed, LSL #16
    MOVK  X7, #0xde5, LSL #32
    MOVK  X7, #0x4cb9, LSL #48
    MOVZ  X10, #0x89e3, LSL #0
    MOVK  X10, #0x370e, LSL #16
    MOVK  X10, #0x849c, LSL #32
    MOVK  X10, #0x9fc9, LSL #48
    MOVZ  X11, #0x44b8, LSL #0
    MOVK  X11, #0x7347, LSL #16
    MOVK  X11, #0xf30d, LSL #32
    MOVK  X11, #0xc8f8, LSL #48
    MOVZ  X12, #0xc2c8, LSL #0
    MOVK  X12, #0x9170, LSL #16
    MOVK  X12, #0xaae, LSL #32
    MOVK  X12, #0x4082, LSL #48
    MOVZ  X13, #0x7398, LSL #0
    MOVK  X13, #0xaa00, LSL #16
    MOVK  X13, #0x1767, LSL #32
    MOVK  X13, #0xf586, LSL #48
    MOVZ  X14, #0x4a68, LSL #0
    MOVK  X14, #0xe90, LSL #16
    MOVK  X14, #0xaa29, LSL #32
    MOVK  X14, #0x15d8, LSL #48
    MOVZ  X15, #0xaace, LSL #0
    MOVK  X15, #0xe2b0, LSL #16
    MOVK  X15, #0x5834, LSL #32
    MOVK  X15, #0xd7bb, LSL #48
    MOVZ  X16, #0xf651, LSL #0
    MOVK  X16, #0x9447, LSL #16
    MOVK  X16, #0xfde5, LSL #32
    MOVK  X16, #0x3dc6, LSL #48
    MOVZ  X17, #0xca22, LSL #0
    MOVK  X17, #0x2edd, LSL #16
    MOVK  X17, #0xdf1c, LSL #32
    MOVK  X17, #0x7496, LSL #48
    MOVZ  X18, #0x5ee3, LSL #0
    MOVK  X18, #0xa86d, LSL #16
    MOVK  X18, #0xf1dc, LSL #32
    MOVK  X18, #0x6412, LSL #48
    MOVZ  X19, #0x4e40, LSL #0
    MOVK  X19, #0x320a, LSL #16
    MOVK  X19, #0x72aa, LSL #32
    MOVK  X19, #0x8f5d, LSL #48
    MOVZ  X20, #0xb689, LSL #0
    MOVK  X20, #0x6db3, LSL #16
    MOVK  X20, #0xcb0e, LSL #32
    MOVK  X20, #0xf99b, LSL #48
    MOVZ  X21, #0xbdb5, LSL #0
    MOVK  X21, #0x897e, LSL #16
    MOVK  X21, #0xf085, LSL #32
    MOVK  X21, #0x48d8, LSL #48
    MOVZ  X22, #0xc51c, LSL #0
    MOVK  X22, #0xbdf1, LSL #16
    MOVK  X22, #0x32c3, LSL #32
    MOVK  X22, #0x1105, LSL #48
    MOVZ  X23, #0xb122, LSL #0
    MOVK  X23, #0x2698, LSL #16
    MOVK  X23, #0xb5, LSL #32
    MOVK  X23, #0xb713, LSL #48
    MOVZ  X24, #0x522, LSL #0
    MOVK  X24, #0xa947, LSL #16
    MOVK  X24, #0x77a7, LSL #32
    MOVK  X24, #0xe425, LSL #48
    MOVZ  X25, #0xf72a, LSL #0
    MOVK  X25, #0x1cbb, LSL #16
    MOVK  X25, #0x7290, LSL #32
    MOVK  X25, #0xe06, LSL #48
    MOVZ  X26, #0xe254, LSL #0
    MOVK  X26, #0x468f, LSL #16
    MOVK  X26, #0x8dd, LSL #32
    MOVK  X26, #0x2645, LSL #48
    MOVZ  X28, #0x3373, LSL #0
    MOVK  X28, #0xb822, LSL #16
    MOVK  X28, #0x3b49, LSL #32
    MOVK  X28, #0xee71, LSL #48
    MOVZ  X29, #0x889f, LSL #0
    MOVK  X29, #0x9006, LSL #16
    MOVK  X29, #0xbf04, LSL #32
    MOVK  X29, #0x4a8, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X25
    FMOV  D3, X22
    FMOV  V3.D[1], X16
    FMOV  D4, X29
    FMOV  V4.D[1], X29
    FMOV  D5, X17
    FMOV  V5.D[1], X17
    FMOV  D6, X15
    FMOV  V6.D[1], X19
    FMOV  D7, X14
    FMOV  V7.D[1], X23
    FMOV  D8, X10
    FMOV  V8.D[1], X10
    FMOV  D9, X15
    FMOV  V9.D[1], X23
    FMOV  D10, X3
    FMOV  V10.D[1], X6
    FMOV  D11, X12
    FMOV  V11.D[1], X6
    FMOV  D12, X25
    FMOV  V12.D[1], X13
    FMOV  D13, X5
    FMOV  V13.D[1], X28
    FMOV  D14, X14
    FMOV  V14.D[1], X10
    FMOV  D15, X14
    FMOV  V15.D[1], X16
    FMOV  D16, X5
    FMOV  V16.D[1], X4
    FMOV  D17, X23
    FMOV  V17.D[1], X22
    FMOV  D18, X18
    FMOV  V18.D[1], X10
    FMOV  D19, X5
    FMOV  V19.D[1], X26
    FMOV  D20, X3
    FMOV  V20.D[1], X19
    FMOV  D21, X29
    FMOV  V21.D[1], X10
    FMOV  D22, X17
    FMOV  V22.D[1], X15
    FMOV  D23, X12
    FMOV  V23.D[1], X7
    FMOV  D24, X7
    FMOV  V24.D[1], X6
    FMOV  D25, X28
    FMOV  V25.D[1], X17
    FMOV  D26, X25
    FMOV  V26.D[1], X28
    FMOV  D27, X12
    FMOV  V27.D[1], X20
    FMOV  D28, X14
    FMOV  V28.D[1], X20
    FMOV  D29, X23
    FMOV  V29.D[1], X11
    FMOV  D30, X16
    FMOV  V30.D[1], X12
    FMOV  D31, X20
    FMOV  V31.D[1], X14
    MOVZ  X15, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_3:
    SMULL  V20.4S, V22.4H, V25.4H
    SQRSHRN2 V6.8H, V29.4S, #4
    SUQADD  V23.16B, V6.16B
    SQSHRUN V24.4H, V30.4S, #4
    SADDLP  V26.2D, V28.4S
    SMLSL2 V2.4S, V24.8H, V11.H[0x2]
    SMLSL V17.2D, V20.2S, V26.S[0x3]
    SMULL  V30.8H, V31.8B, V2.8B
    SQRDMULH S18, S27, V23.S[0x1]
    SMULL2  V31.2D, V30.4S, V18.4S
    SRSHR  V18.4S, V1.4S, #9
    SQSHLU  V28.4S, V17.4S, #0x1a
    SSHR  V21.8H, V28.8H, #6
    SADALP  V17.2S, V21.4H
    SMLSL V21.2D, V5.2S, V18.S[0x2]
    SQDMLSL  V18.4S, V31.4H, V31.4H
    SRSRA  V26.4H, V17.4H, #15
    SMLAL2 V25.4S, V21.8H, V0.H[0x5]
    SQRSHRUN2 V5.4S, V24.2D, #24
    SSUBL2  V20.2D, V18.4S, V5.4S
    SXTL V18.2D, V22.2S
    SQADD  V28.4S, V18.4S, V18.4S
    SQRDMULH  V17.4S, V26.4S, V20.S[0x3]
    SMLSL V6.4S, V17.4H, V1.H[0x2]
    SQSHRUN V29.2S, V28.2D, #5
    SQDMULL V0.2D, V6.2S, V25.S[0x3]
    SXTL2 V30.4S, V0.8H
    SQDMLAL V11.4S, V30.4H, V15.H[0x6]
    SQDMLSL2 V31.2D, V11.4S, V29.S[0x0]
    SXTL2 V21.2D, V22.4S
    SMOV W10, V0.H[0x4]
    SXTL V0.2D, V12.2S
    SXTL2 V24.2D, V29.4S
    SQRSHRUN V18.8B, V11.8H, #8
    SRSRA V12.2D, V16.2D, #22
    SQXTN  V25.4H, V15.4S
    SUQADD  V2.2D, V25.2D
    SQDMULL  V26.2D, V6.2S, V21.2S
    SQDMULL2 V6.4S, V14.8H, V15.H[0x5]
    SABA  V20.4H, V19.4H, V1.4H
    SQDMLSL D22, S0, V18.S[0x3]
    SQSHRN2 V17.16B, V29.8H, #1
    SQRDMULH H18, H20, V2.H[0x5]
    SQDMULL2  V19.2D, V18.4S, V31.4S
    SSRA V1.2D, V12.2D, #60
    SRSHR V11.2D, V24.2D, #53
    SMULL2  V16.8H, V6.16B, V11.16B
    SXTL V6.2D, V23.2S
    SSRA  V29.4H, V6.4H, #1
    SQSHRUN V28.4H, V16.4S, #10
    SXTL V30.4S, V1.4H
    SQNEG  V21.8H, V26.8H
    SRSHL  V6.4H, V30.4H, V28.4H
    SQSHL  V1.2D, V19.2D, V6.2D
    SMULL2 V24.2D, V22.4S, V1.S[0x3]
    SMULL V1.2D, V29.2S, V24.S[0x2]
    SQDMLAL  V15.2D, V21.2S, V21.2S
    SADDW2  V14.8H, V1.8H, V1.16B
    SUQADD  V25.8B, V18.8B
    SRSHR  V0.16B, V25.16B, #1
    SABA  V26.8H, V14.8H, V15.8H
    SQRSHRN V19.8B, V0.8H, #6
    SSUBW  V11.2D, V17.2D, V26.2S
    SQSHRN2 V12.4S, V19.2D, #8
    SQDMLSL2 V0.4S, V12.8H, V12.H[0x2]
    SSUBW2  V28.8H, V0.8H, V11.16B
    SABDL2  V6.4S, V22.8H, V0.8H
    SQRSHRUN2 V24.16B, V12.8H, #8
    SQDMULL2 V20.2D, V26.4S, V7.S[0x3]
    SSRA  V30.4H, V13.4H, #10
    SQDMLAL  V14.2D, V27.2S, V7.2S
    SQDMULH  V27.4S, V28.4S, V13.4S
    SXTL2 V1.8H, V13.16B
    SRSRA  V18.2S, V17.2S, #6
    SQDMULL2 V21.4S, V27.8H, V1.H[0x0]
    SQDMULH H15, H31, V15.H[0x6]
    SQSHRN2 V23.4S, V26.2D, #19
    SABA  V11.4S, V30.4S, V24.4S
    SQRDMULH  V16.2S, V11.2S, V15.S[0x1]
    SADDLV  S11, V16.4H
    SADDLV  H13, V23.16B
    SSUBW2  V17.2D, V14.2D, V6.4S
    SABA  V30.8H, V20.8H, V12.8H
    SMULL2 V27.4S, V15.8H, V13.H[0x0]
    SQDMLAL2 V0.4S, V11.8H, V12.H[0x7]
    SSHR V22.2D, V17.2D, #49
    SMLAL  V16.8H, V18.8B, V18.8B
    SQRSHRN V1.2S, V22.2D, #31
    SQSHLU V23.2D, V27.2D, #0x3d
    SQRSHRUN V19.8B, V16.8H, #5
    SMLAL V13.4S, V1.4H, V1.H[0x4]
    SRSHR  V15.4H, V13.4H, #3
    SQSHRN V31.8B, V8.8H, #4
    SSHLL V7.2D, V31.2S, #0xe
    SQRSHRUN2 V31.16B, V7.8H, #1
    SQSHL V1.2D, V21.2D, #0x38
    SQDMULL2 V26.2D, V30.4S, V30.S[0x0]
    SXTL2 V20.8H, V23.16B
    SQRSHRN V23.4H, V20.4S, #12
    SQDMLAL D18, S0, V0.S[0x2]
    SSHR V21.2D, V15.2D, #55
    SQDMULL2 V16.4S, V19.8H, V2.H[0x6]
    SQADD  V27.2D, V31.2D, V26.2D
    SMOV W21, V23.B[0x6]
    SMLSL  V20.8H, V21.8B, V18.8B
    SABAL  V15.4S, V1.4H, V1.4H
    SQDMLSL  V7.4S, V16.4H, V16.4H
    SQDMULH S21, S27, V27.S[0x1]
    SQDMLAL S27, H4, V7.H[0x0]
    SMOV  X11, V21.B[0x5]
    SMULL  V18.8H, V20.8B, V27.8B
    SUQADD  V8.8H, V18.8H
    SADDLV  H27, V8.8B
    SADDLV  D11, V27.4S
    SSHLL V13.4S, V11.4H, #0xc
    SXTL V19.4S, V18.4H
    SRSHR  V23.4H, V15.4H, #7
    SSHLL2 V18.4S, V13.8H, #0xd
    SQSHL V1.2D, V18.2D, #0x2f
    SQDMLAL D30, S1, V19.S[0x2]
    SQSHLU  V19.16B, V23.16B, #0x0
    SSRA  V23.4H, V19.4H, #4
    SMULL V31.4S, V30.4H, V7.H[0x0]
    SSHR  V8.2S, V31.2S, #4
    SSHL  V11.4S, V8.4S, V8.4S
    SSUBW2  V27.8H, V11.8H, V23.16B
    SQSHRN2 V21.4S, V1.2D, #2
    SQSHRN V4.8B, V19.8H, #6
    SQRSHRUN2 V11.4S, V3.2D, #26
    SSRA  V8.2S, V4.2S, #10
    SSUBW2  V23.8H, V2.8H, V18.16B
    SQXTN  V19.8B, V11.8H
    SQRSHRUN V30.2S, V15.2D, #8
    SMULL2 V20.2D, V13.4S, V18.S[0x1]
    SSHLL2 V11.8H, V19.16B, #0x2
    SMULL2  V16.8H, V25.16B, V13.16B
    SMLSL2 V31.2D, V8.4S, V17.S[0x3]
    SSHR V7.2D, V27.2D, #19
    SQSHL  V1.4S, V29.4S, #0x1c
    SABDL2  V19.4S, V21.8H, V16.8H
    SQSHRUN2 V15.8H, V30.4S, #7
    SQSHLU  V21.8B, V15.8B, #0x0
    SQSHRUN2 V8.8H, V1.4S, #8
    SADALP  V17.2D, V8.4S
    SMOV  X3, V17.S[0x2]
    SMULL2 V16.4S, V1.8H, V11.H[0x0]
    SRSRA  V3.16B, V23.16B, #2
    SQSHRUN2 V18.4S, V20.2D, #12
    SSHLL2 V30.4S, V21.8H, #0x1
    SQDMLAL V25.4S, V3.4H, V7.H[0x5]
    SQDMULL2  V11.4S, V19.8H, V31.8H
    SRSRA V29.2D, V11.2D, #3
    SMULL2  V20.2D, V25.4S, V25.4S
    SMLSL V1.2D, V30.2S, V18.S[0x3]
    SQRSHL  V18.8H, V29.8H, V1.8H
    SSHLL2 V17.4S, V16.8H, #0x9
    SQSHRN2 V19.4S, V20.2D, #29
    SADDLV  D8, V19.4S
    SQDMLAL  V15.4S, V8.4H, V17.4H
    SADALP  V11.1D, V15.2S
    SQSHRUN2 V15.4S, V30.2D, #14
    SABDL  V27.2D, V18.2S, V12.2S
    SQDMLSL2  V18.2D, V27.4S, V15.4S
    SQDMLAL D8, S18, V18.S[0x2]
    SSHLL V12.8H, V8.8B, #0x7
    SQDMULL2 V8.2D, V11.4S, V11.S[0x1]
    SMOV W23, V12.H[0x3]
    SQDMULL2 V31.2D, V30.4S, V15.S[0x3]
    SMOV W16, V30.H[0x5]
    SQDMLSL D3, S23, V23.S[0x3]
    SMLAL V15.2D, V3.2S, V15.S[0x2]
    SADDLV  H18, V6.8B
    SMLSL V20.2D, V2.2S, V0.S[0x3]
    SUQADD  V11.8B, V6.8B
    SABD  V21.4H, V17.4H, V20.4H
    SQDMLAL  V12.4S, V16.4H, V17.4H
    SQDMLSL2  V27.4S, V2.8H, V7.8H
    SQSHLU  V25.2S, V0.2S, #0x19
    SQSHRN2 V20.16B, V8.8H, #1
    SQSHLU  V17.8B, V31.8B, #0x4
    SADDLV  D0, V15.4S
    SQDMLSL V6.4S, V27.4H, V12.H[0x3]
    SQRDMULH  V30.4S, V0.4S, V11.S[0x0]
    SXTL V19.8H, V6.8B
    SQDMLAL S23, H19, V12.H[0x1]
    SQDMLSL2 V15.4S, V23.8H, V9.H[0x0]
    SQRSHRUN2 V3.8H, V15.4S, #10
    SSHR V27.2D, V18.2D, #3
    SQSHRUN2 V23.16B, V17.8H, #3
    SQSHRUN V18.8B, V21.8H, #3
    SQDMULH  V8.8H, V3.8H, V10.8H
    SMLAL2 V10.2D, V30.4S, V2.S[0x2]
    SADDLV  H21, V25.16B
    SRSHR  V30.8B, V21.8B, #2
    SQRDMULH  V31.8H, V20.8H, V8.H[0x3]
    SXTL2 V20.2D, V23.4S
    SQDMLAL2  V8.2D, V20.4S, V20.4S
    SSUBW  V17.2D, V31.2D, V8.2S
    SQSHRN2 V11.16B, V27.8H, #5
    SQDMULL S0, H30, V14.H[0x0]
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_3
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x8221, LSL #0
    MOVK  X20, #0x9cd3, LSL #16
    MOVK  X20, #0x8840, LSL #32
    MOVK  X20, #0x75c9, LSL #48
    SUB  X14, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x143d, LSL #0
    MOVK  X20, #0x5eb4, LSL #16
    MOVK  X20, #0xaf2b, LSL #32
    MOVK  X20, #0x642a, LSL #48
    SUB  X14, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x22a8, LSL #0
    MOVK  X20, #0x5599, LSL #16
    MOVK  X20, #0xb65f, LSL #32
    MOVK  X20, #0xe5ba, LSL #48
    SUB  X14, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xee88, LSL #0
    MOVK  X20, #0x52ed, LSL #16
    MOVK  X20, #0xde5, LSL #32
    MOVK  X20, #0x4cb9, LSL #48
    SUB  X14, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xc2c8, LSL #0
    MOVK  X20, #0x9170, LSL #16
    MOVK  X20, #0xaae, LSL #32
    MOVK  X20, #0x4082, LSL #48
    SUB  X14, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x7398, LSL #0
    MOVK  X20, #0xaa00, LSL #16
    MOVK  X20, #0x1767, LSL #32
    MOVK  X20, #0xf586, LSL #48
    SUB  X14, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xca22, LSL #0
    MOVK  X20, #0x2edd, LSL #16
    MOVK  X20, #0xdf1c, LSL #32
    MOVK  X20, #0x7496, LSL #48
    SUB  X14, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x5ee3, LSL #0
    MOVK  X20, #0xa86d, LSL #16
    MOVK  X20, #0xf1dc, LSL #32
    MOVK  X20, #0x6412, LSL #48
    SUB  X14, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xc51c, LSL #0
    MOVK  X20, #0xbdf1, LSL #16
    MOVK  X20, #0x32c3, LSL #32
    MOVK  X20, #0x1105, LSL #48
    SUB  X14, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x522, LSL #0
    MOVK  X20, #0xa947, LSL #16
    MOVK  X20, #0x77a7, LSL #32
    MOVK  X20, #0xe425, LSL #48
    SUB  X14, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xf72a, LSL #0
    MOVK  X20, #0x1cbb, LSL #16
    MOVK  X20, #0x7290, LSL #32
    MOVK  X20, #0xe06, LSL #48
    SUB  X14, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xe254, LSL #0
    MOVK  X20, #0x468f, LSL #16
    MOVK  X20, #0x8dd, LSL #32
    MOVK  X20, #0x2645, LSL #48
    SUB  X14, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x3373, LSL #0
    MOVK  X20, #0xb822, LSL #16
    MOVK  X20, #0x3b49, LSL #32
    MOVK  X20, #0xee71, LSL #48
    SUB  X14, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x889f, LSL #0
    MOVK  X20, #0x9006, LSL #16
    MOVK  X20, #0xbf04, LSL #32
    MOVK  X20, #0x4a8, LSL #48
    SUB  X14, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x800, LSL #16
    MRS  X14, FPSR
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xf000, LSL #16
    MOVK  X20, #0xf000, LSL #48
    FMOV  X14, D1
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xf72a, LSL #0
    MOVK  X20, #0x1cbb, LSL #16
    MOVK  X20, #0x7290, LSL #32
    MOVK  X20, #0xe06, LSL #48
    FMOV  X14, V2.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0x7fff, LSL #48
    FMOV  X14, D2
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x31fc, LSL #0
    MOVK  X20, #0x62b3, LSL #16
    MOVK  X20, #0x32c5, LSL #32
    MOVK  X20, #0xf105, LSL #48
    FMOV  X14, D3
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xca22, LSL #0
    MOVK  X20, #0x2edd, LSL #16
    MOVK  X20, #0xdf1c, LSL #32
    MOVK  X20, #0x7496, LSL #48
    FMOV  X14, D5
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x1fff, LSL #0
    FMOV  X14, D7
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xe6, LSL #0
    MOVK  X20, #0xb81f, LSL #16
    MOVK  X20, #0x1e08, LSL #32
    MOVK  X20, #0xfbbb, LSL #48
    FMOV  X14, D8
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xb122, LSL #0
    MOVK  X20, #0x2698, LSL #16
    MOVK  X20, #0xb5, LSL #32
    MOVK  X20, #0xb713, LSL #48
    FMOV  X14, V9.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xaace, LSL #0
    MOVK  X20, #0xe2b0, LSL #16
    MOVK  X20, #0x5834, LSL #32
    MOVK  X20, #0xd7bb, LSL #48
    FMOV  X14, D9
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x22a8, LSL #0
    MOVK  X20, #0x5599, LSL #16
    MOVK  X20, #0xb65f, LSL #32
    MOVK  X20, #0xe5ba, LSL #48
    FMOV  X14, V10.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x24d, LSL #0
    MOVK  X20, #0xa2c9, LSL #16
    MOVK  X20, #0x4bb7, LSL #32
    MOVK  X20, #0x247a, LSL #48
    FMOV  X14, D10
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D11
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D12
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xf000, LSL #0
    MOVK  X20, #0xfff6, LSL #16
    FMOV  X14, D13
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xe1f8, LSL #0
    MOVK  X20, #0x444, LSL #16
    FMOV  X14, V17.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xff1a, LSL #0
    MOVK  X20, #0x47e0, LSL #16
    FMOV  X14, D17
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D19
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D20
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D22
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    FMOV  X14, D23
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X14, D29
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, D31
    SUB  X19, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X23
    FMOV  V0.D[1], X3
    FMOV  D1, X14
    FMOV  V1.D[1], X19
    FMOV  D2, X20
    FMOV  V2.D[1], X17
    FMOV  D3, X16
    FMOV  V3.D[1], X28
    FMOV  D4, X21
    FMOV  V4.D[1], X15
    FMOV  D5, X29
    FMOV  V5.D[1], X26
    FMOV  D6, X22
    FMOV  V6.D[1], X24
    FMOV  D7, X25
    FMOV  V7.D[1], X25
    FMOV  D8, X12
    FMOV  V8.D[1], X29
    FMOV  D9, X15
    FMOV  V9.D[1], X15
    FMOV  D10, X13
    FMOV  V10.D[1], X5
    FMOV  D11, X4
    FMOV  V11.D[1], X6
    FMOV  D12, X12
    FMOV  V12.D[1], X14
    FMOV  D13, X3
    FMOV  V13.D[1], X13
    FMOV  D14, X19
    FMOV  V14.D[1], X18
    FMOV  D15, X4
    FMOV  V15.D[1], X13
    FMOV  D16, X12
    FMOV  V16.D[1], X25
    FMOV  D17, X11
    FMOV  V17.D[1], X20
    FMOV  D18, X3
    FMOV  V18.D[1], X19
    FMOV  D19, X12
    FMOV  V19.D[1], X23
    FMOV  D20, X22
    FMOV  V20.D[1], X28
    FMOV  D21, X21
    FMOV  V21.D[1], X14
    FMOV  D22, X16
    FMOV  V22.D[1], X22
    FMOV  D23, X15
    FMOV  V23.D[1], X20
    FMOV  D24, X6
    FMOV  V24.D[1], X4
    FMOV  D25, X25
    FMOV  V25.D[1], X26
    FMOV  D26, X3
    FMOV  V26.D[1], X5
    FMOV  D27, X15
    FMOV  V27.D[1], X5
    FMOV  D28, X28
    FMOV  V28.D[1], X20
    FMOV  D29, X29
    FMOV  V29.D[1], X16
    FMOV  D30, X13
    FMOV  V30.D[1], X24
    FMOV  D31, X4
    FMOV  V31.D[1], X28
    MOVZ  X3, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_4:
    SSHR  V29.8B, V25.8B, #5
    SQABS  V30.8B, V31.8B
    SHSUB  V29.4S, V26.4S, V26.4S
    SXTL2 V26.8H, V30.16B
    SQRSHRN V17.4H, V24.4S, #5
    SQDMULH  V10.2S, V26.2S, V28.S[0x3]
    SMOV  X26, V29.B[0xa]
    SSUBW  V4.4S, V27.4S, V10.4H
    SXTL V7.8H, V4.8B
    SQRSHRUN V11.4H, V7.4S, #2
    SSHLL2 V0.8H, V11.16B, #0x7
    SQSHRUN V0.4H, V0.4S, #3
    SQDMLSL  V0.2D, V17.2S, V0.2S
    SSHR V20.2D, V0.2D, #11
    SQSHRN2 V0.4S, V20.2D, #20
    SQRSHRN2 V31.4S, V21.2D, #30
    SSHLL V13.4S, V4.4H, #0x8
    SMLSL2 V17.2D, V11.4S, V2.S[0x3]
    SQSHLU  V27.4S, V19.4S, #0x19
    SQDMULH S21, S9, V22.S[0x2]
    SMOV  X28, V23.H[0x2]
    SQSHL  V25.2S, V29.2S, #0xa
    SQRSHRUN2 V19.8H, V28.4S, #1
    SQSHRUN V2.8B, V25.8H, #7
    SSHR V29.2D, V29.2D, #51
    SSUBW2  V23.4S, V0.4S, V0.8H
    SRSHR  V20.2S, V27.2S, #24
    SQRSHRUN V25.4H, V29.4S, #13
    SQRSHRN2 V9.8H, V31.4S, #15
    SMOV  X7, V9.H[0x2]
    SQDMLAL2 V28.2D, V20.4S, V13.S[0x1]
    SQXTUN  V20.2S, V19.2D
    SQABS  V11.2D, V28.2D
    SMLAL2 V13.2D, V2.4S, V11.S[0x3]
    SQDMLAL2 V19.2D, V21.4S, V21.S[0x0]
    SRSRA  V28.16B, V17.16B, #2
    SSHR V22.2D, V23.2D, #37
    SQXTUN  V23.4H, V25.4S
    SMLSL V17.2D, V19.2S, V20.S[0x0]
    SXTL V25.2D, V13.2S
    SSUBL  V29.2D, V17.2S, V28.2S
    SQSHRUN2 V31.4S, V25.2D, #22
    SQSHRN2 V21.16B, V22.8H, #1
    SXTL2 V4.8H, V29.16B
    SQRSHRN2 V20.16B, V31.8H, #4
    SSHR  V0.8B, V23.8B, #7
    SQRSHRN2 V9.16B, V21.8H, #2
    SSHLL V29.2D, V9.2S, #0x9
    SQABS  V11.2D, V0.2D
    SSUBW  V31.2D, V13.2D, V30.2S
    SQDMLSL  V25.4S, V29.4H, V4.4H
    SQRSHRUN V22.4H, V20.4S, #5
    SSRA V0.2D, V22.2D, #48
    SQXTN  V28.8B, V31.8H
    SQDMLAL  V17.4S, V28.4H, V11.4H
    SSHR  V21.4S, V17.4S, #7
    SQSHL  V9.8B, V0.8B, #0x6
    SQSHRN2 V4.8H, V25.4S, #15
    SSHLL2 V2.4S, V9.8H, #0x4
    SXTL2 V25.2D, V21.4S
    SQSHL  V0.4S, V4.4S, #0x10
    SQSHRN2 V23.8H, V0.4S, #13
    SSHR  V20.4H, V23.4H, #7
    SQSHRUN2 V17.16B, V20.8H, #8
    SQDMULH  V29.8H, V17.8H, V2.H[0x1]
    SQSHRUN2 V21.8H, V11.4S, #12
    SQDMLSL D19, S25, V21.S[0x1]
    SSHLL2 V23.4S, V19.8H, #0xa
    SMLSL V21.2D, V29.2S, V23.S[0x0]
    SSHLL2 V0.2D, V14.4S, #0x1d
    SQRDMULH  V9.4S, V30.4S, V7.S[0x1]
    SQRSHL  V2.2D, V0.2D, V24.2D
    SQDMULL D20, S14, V10.S[0x3]
    SQRDMULH  V11.4S, V3.4S, V5.4S
    SQRDMULH H23, H14, V5.H[0x4]
    SQSHRUN V24.4H, V16.4S, #13
    SMLAL  V17.4S, V1.4H, V11.4H
    SRSHR V16.2D, V14.2D, #15
    SMLSL2  V11.4S, V15.8H, V1.8H
    SQDMLSL2 V4.4S, V17.8H, V2.H[0x1]
    SMLAL2  V5.8H, V11.16B, V16.16B
    SQRDMULH  V30.4H, V5.4H, V21.4H
    SQSHRUN V25.8B, V30.8H, #4
    SQDMULH S19, S23, V4.S[0x2]
    SRSHL  V1.8H, V20.8H, V20.8H
    SMLSL  V16.2D, V5.2S, V19.2S
    SQRSHRN V0.2S, V9.2D, #4
    SSHR  V2.16B, V1.16B, #2
    SSHL  V20.2S, V16.2S, V25.2S
    SQDMLSL2  V1.2D, V0.4S, V17.4S
    SQDMULH  V10.4S, V20.4S, V2.S[0x0]
    SQXTN  V14.4H, V10.4S
    SXTL V4.4S, V14.4H
    SMULL  V15.4S, V1.4H, V1.4H
    SMLSL V20.4S, V4.4H, V15.H[0x0]
    SSRA  V0.8B, V24.8B, #4
    SRSHR  V15.4H, V0.4H, #4
    SABAL  V0.4S, V15.4H, V21.4H
    SABAL2  V30.8H, V0.16B, V20.16B
    SABAL  V1.4S, V0.4H, V31.4H
    SABDL  V16.8H, V21.8B, V29.8B
    SMOV  X24, V17.H[0x2]
    SXTL2 V17.2D, V15.4S
    SQRSHRN V29.2S, V23.2D, #26
    SQSUB  V9.8H, V20.8H, V15.8H
    SXTL V20.8H, V1.8B
    SMULL2  V21.2D, V26.4S, V11.4S
    SRSRA V4.2D, V27.2D, #2
    SABD  V27.4S, V4.4S, V30.4S
    SQDMLSL2 V19.2D, V10.4S, V27.S[0x1]
    SQRDMULH H4, H25, V3.H[0x4]
    SSHR V14.2D, V15.2D, #45
    SSRA  V31.8B, V16.8B, #3
    SHADD  V3.2S, V17.2S, V20.2S
    SSRA  V15.2S, V21.2S, #18
    SADDL  V25.2D, V19.2S, V19.2S
    SQDMLAL V17.4S, V25.4H, V4.H[0x6]
    SQDMLSL D16, S15, V3.S[0x3]
    SQDMLSL2 V1.2D, V31.4S, V17.S[0x2]
    SSHLL V10.8H, V16.8B, #0x3
    SQRSHRUN V21.2S, V26.2D, #19
    SMLSL2 V19.2D, V9.4S, V1.S[0x3]
    SMLSL V20.4S, V14.4H, V14.H[0x0]
    SQRDMULH S4, S10, V21.S[0x0]
    SQABS  V3.2S, V20.2S
    SQDMULL2 V17.2D, V3.4S, V19.S[0x3]
    SRSRA  V9.4H, V29.4H, #9
    SXTL V0.4S, V4.4H
    SQDMULH  V27.8H, V0.8H, V0.H[0x6]
    SQRDMULH  V29.8H, V17.8H, V4.8H
    SABAL2  V4.4S, V9.8H, V9.8H
    SQSHLU  V15.16B, V27.16B, #0x0
    SQXTUN  V1.4H, V15.4S
    SMLAL V23.2D, V2.2S, V1.S[0x1]
    SABA  V26.8H, V29.8H, V4.8H
    SMLAL  V19.8H, V23.8B, V23.8B
    SADDLV  S2, V26.8H
    SRSRA  V3.4H, V2.4H, #9
    SQRSHRUN V0.4H, V19.4S, #12
    SQDMLSL S29, H3, V3.H[0x0]
    SQDMLAL S1, H29, V0.H[0x6]
    SQSHRUN2 V19.16B, V23.8H, #2
    SMOV  X21, V3.H[0x3]
    SQXTUN2  V4.16B, V16.8H
    SQDMULH S29, S6, V17.S[0x2]
    SMLAL V6.2D, V8.2S, V16.S[0x0]
    SQRSHRUN2 V0.8H, V17.4S, #15
    SMLAL2 V26.2D, V15.4S, V4.S[0x2]
    SQRSHRUN V2.2S, V30.2D, #31
    SQSHRN V30.2S, V10.2D, #9
    SQSHRUN V21.4H, V6.4S, #14
    SADALP  V15.1D, V10.2S
    SRSHR  V14.8H, V1.8H, #10
    SRSHR  V6.4S, V14.4S, #20
    SQXTN2  V1.8H, V19.4S
    SSHLL V8.2D, V29.2S, #0x5
    SSHR  V23.4H, V24.4H, #6
    SQADD  V9.4H, V0.4H, V2.4H
    SADDLV  D2, V1.4S
    SQRSHRUN2 V4.16B, V25.8H, #6
    SSHLL2 V24.8H, V5.16B, #0x3
    SMULL2 V17.4S, V4.8H, V5.H[0x3]
    SSRA V10.2D, V6.2D, #8
    SQDMULL V3.4S, V17.4H, V11.H[0x3]
    SQRDMULH  V29.4H, V3.4H, V2.H[0x3]
    SQSHL V14.2D, V26.2D, #0x10
    SHADD  V1.8B, V2.8B, V29.8B
    SMLAL  V16.4S, V15.4H, V9.4H
    SQSHL V4.2D, V24.2D, #0x28
    SQDMLSL  V25.2D, V21.2S, V10.2S
    SQSHLU V19.2D, V4.2D, #0x3c
    SRHADD  V21.8H, V25.8H, V23.8H
    SQSHLU  V6.2S, V21.2S, #0xd
    SQDMULH  V21.4H, V1.4H, V1.4H
    SSRA  V4.4S, V14.4S, #32
    SMLSL2 V5.2D, V8.4S, V4.S[0x0]
    SQRSHRN V0.8B, V16.8H, #7
    SRSHR  V25.16B, V21.16B, #2
    SQDMULH  V21.4H, V25.4H, V5.H[0x4]
    SQRSHRUN V26.8B, V21.8H, #2
    SQSHL V4.2D, V19.2D, #0x2f
    SRSHR  V29.4H, V26.4H, #16
    SRSRA  V2.4S, V0.4S, #4
    SQDMLSL2 V1.2D, V6.4S, V22.S[0x1]
    SABDL  V6.4S, V1.4H, V1.4H
    SQDMLAL2 V25.4S, V2.8H, V4.H[0x4]
    SQSUB  V11.8B, V29.8B, V29.8B
    SSHR  V1.8B, V11.8B, #6
    SMULL2  V23.4S, V6.8H, V6.8H
    SSUBW  V0.2D, V25.2D, V23.2S
    SMULL2 V22.4S, V6.8H, V0.H[0x0]
    SSHL  V25.8H, V1.8H, V22.8H
    SQXTUN2  V23.16B, V12.8H
    SHADD  V26.4H, V0.4H, V9.4H
    SQRSHRUN2 V15.8H, V1.4S, #6
    SQSHL  V8.8B, V4.8B, V26.8B
    SQSHLU  V14.8B, V22.8B, #0x3
    SMLAL  V6.8H, V31.8B, V21.8B
    SQSHL  V29.8H, V8.8H, #0x5
    SMOV W17, V8.B[0x0]
    SUBS  X3, X3, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_4
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x800, LSL #16
    MRS  X16, FPSR
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D3
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D9
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D10
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D11
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D16
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D20
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X6, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSignedOperation_TestFail
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
    FMOV  D1, X29
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X23
    FMOV  V3.D[1], X10
    FMOV  D4, X11
    FMOV  V4.D[1], X13
    FMOV  D5, X6
    FMOV  V5.D[1], X29
    FMOV  D6, X25
    FMOV  V6.D[1], X3
    FMOV  D7, X18
    FMOV  V7.D[1], X15
    FMOV  D8, X16
    FMOV  V8.D[1], X26
    FMOV  D9, X12
    FMOV  V9.D[1], X11
    FMOV  D10, X17
    FMOV  V10.D[1], X28
    FMOV  D11, X25
    FMOV  V11.D[1], X10
    FMOV  D12, X21
    FMOV  V12.D[1], X10
    FMOV  D13, X6
    FMOV  V13.D[1], X16
    FMOV  D14, X10
    FMOV  V14.D[1], X23
    FMOV  D15, X16
    FMOV  V15.D[1], X6
    FMOV  D16, X13
    FMOV  V16.D[1], X28
    FMOV  D17, X21
    FMOV  V17.D[1], X19
    FMOV  D18, X23
    FMOV  V18.D[1], X19
    FMOV  D19, X20
    FMOV  V19.D[1], X22
    FMOV  D20, X22
    FMOV  V20.D[1], X29
    FMOV  D21, X20
    FMOV  V21.D[1], X24
    FMOV  D22, X23
    FMOV  V22.D[1], X12
    FMOV  D23, X25
    FMOV  V23.D[1], X11
    FMOV  D24, X20
    FMOV  V24.D[1], X29
    FMOV  D25, X20
    FMOV  V25.D[1], X22
    FMOV  D26, X6
    FMOV  V26.D[1], X26
    FMOV  D27, X29
    FMOV  V27.D[1], X28
    FMOV  D28, X4
    FMOV  V28.D[1], X10
    FMOV  D29, X29
    FMOV  V29.D[1], X12
    FMOV  D30, X29
    FMOV  V30.D[1], X10
    FMOV  D31, X25
    FMOV  V31.D[1], X17
    MOVZ  X18, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_5:
    SADALP  V5.8H, V25.16B
    SSHLL V28.4S, V31.4H, #0x5
    SQRDMULH  V13.4H, V24.4H, V15.H[0x7]
    SQDMLSL  V3.2D, V29.2S, V26.2S
    SQDMLAL D22, S28, V30.S[0x2]
    SMLSL2  V5.2D, V23.4S, V22.4S
    SQSUB  V25.2D, V27.2D, V20.2D
    SQRSHL  V8.16B, V13.16B, V25.16B
    SSHL  V31.2S, V3.2S, V21.2S
    SQDMULH  V27.2S, V8.2S, V14.S[0x3]
    SQRSHRN V13.2S, V5.2D, #7
    SSRA  V3.8B, V13.8B, #2
    SQXTUN2  V14.16B, V3.8H
    SQDMLSL S3, H14, V14.H[0x6]
    SQDMLAL2 V25.2D, V27.4S, V3.S[0x0]
    SSUBL  V23.4S, V25.4H, V31.4H
    SRSHR  V25.8H, V8.8H, #3
    SQDMLSL V28.2D, V31.2S, V7.S[0x1]
    SSHR V11.2D, V11.2D, #32
    SQSHLU  V13.4S, V5.4S, #0x6
    SQSHLU V31.2D, V29.2D, #0xb
    SQDMLAL  V8.2D, V28.2S, V6.2S
    SQRDMULH H29, H25, V7.H[0x6]
    SMLSL2  V3.8H, V2.16B, V31.16B
    SQSHLU V21.2D, V21.2D, #0x3b
    SUQADD  V31.2D, V11.2D
    SQRDMULH H5, H18, V6.H[0x6]
    SMOV W21, V8.H[0x7]
    SMULL2 V27.4S, V23.8H, V12.H[0x6]
    SQSHRN V2.2S, V10.2D, #2
    SQDMULH S12, S30, V11.S[0x1]
    SQRDMULH  V14.8H, V27.8H, V13.H[0x6]
    SQDMLSL  V13.2D, V21.2S, V29.2S
    SQSHRUN2 V29.8H, V5.4S, #7
    SMULL V22.2D, V13.2S, V21.S[0x1]
    SRSHR  V20.2S, V2.2S, #16
    SQSHRUN V2.4H, V31.4S, #12
    SMLSL2 V31.4S, V3.8H, V3.H[0x0]
    SRSHR  V14.4S, V20.4S, #22
    SQDMLSL V13.4S, V31.4H, V14.H[0x1]
    SSHR  V27.4S, V10.4S, #3
    SSRA  V18.4H, V29.4H, #10
    SXTL V14.8H, V2.8B
    SHSUB  V8.8H, V13.8H, V30.8H
    SADALP  V11.4H, V18.8B
    SQSHRN V5.2S, V8.2D, #22
    SMULL2  V25.8H, V11.16B, V22.16B
    SMLSL2  V23.2D, V12.4S, V12.4S
    SQSHRUN2 V30.16B, V14.8H, #7
    SQRSHRUN V31.2S, V30.2D, #5
    SSRA  V18.8H, V27.8H, #11
    SQSHRN2 V22.16B, V25.8H, #6
    SMLSL  V29.2D, V24.2S, V5.2S
    SQSHLU  V10.2S, V23.2S, #0x1a
    SQRSHRN2 V2.8H, V31.4S, #6
    SQDMULL  V21.2D, V10.2S, V18.2S
    SSUBW  V11.2D, V21.2D, V21.2S
    SADDL  V21.4S, V11.4H, V11.4H
    SMLSL V8.4S, V22.4H, V1.H[0x1]
    SQDMLSL V27.4S, V2.4H, V8.H[0x4]
    SXTL2 V2.4S, V15.8H
    SXTL V20.2D, V25.2S
    SQDMLSL  V13.4S, V21.4H, V29.4H
    SQDMLSL V15.2D, V13.2S, V5.S[0x0]
    SRSHR  V24.16B, V20.16B, #3
    SQDMLAL2  V5.4S, V27.8H, V24.8H
    SQDMLAL V20.4S, V15.4H, V2.H[0x1]
    SQSHLU  V13.2S, V20.2S, #0x9
    SQDMLSL V21.2D, V5.2S, V13.S[0x0]
    SQSHRN2 V18.16B, V24.8H, #8
    SQXTN  V20.2S, V2.2D
    SQXTN  V22.2S, V21.2D
    SMULL  V1.8H, V8.8B, V8.8B
    SADDLP  V12.1D, V13.2S
    SRSRA  V11.2S, V22.2S, #11
    SABD  V8.8H, V17.8H, V20.8H
    SQSHRN2 V25.16B, V23.8H, #7
    SMLSL  V27.4S, V18.4H, V23.4H
    SMULL V23.4S, V4.4H, V4.H[0x4]
    SRSHL  V31.8B, V24.8B, V29.8B
    SSHLL V13.4S, V11.4H, #0xb
    SQSHRN2 V10.16B, V3.8H, #2
    SQRSHRUN2 V29.4S, V25.2D, #27
    SQRSHRUN2 V2.4S, V27.2D, #15
    SSHLL V20.2D, V1.2S, #0x16
    SSHLL V21.2D, V27.2S, #0x4
    SQDMULL D18, S8, V21.S[0x3]
    SRSRA  V24.4S, V2.4S, #16
    SRSRA  V4.2S, V23.2S, #2
    SSUBW  V27.2D, V13.2D, V24.2S
    SQDMLSL2 V3.2D, V12.4S, V20.S[0x2]
    SSRA  V20.16B, V31.16B, #4
    SQRSHRN2 V25.4S, V20.2D, #21
    SABAL2  V1.2D, V3.4S, V3.4S
    SQRDMULH  V5.4H, V25.4H, V10.H[0x6]
    SQSHLU  V20.8B, V27.8B, #0x2
    SSRA V12.2D, V20.2D, #44
    SSRA V21.2D, V4.2D, #29
    SQSHLU  V3.2S, V1.2S, #0xd
    SQDMULL2 V10.2D, V29.4S, V11.S[0x1]
    SQSHL  V11.2S, V3.2S, #0x5
    SQSUB  V23.8H, V11.8H, V17.8H
    SQADD  V17.4S, V2.4S, V23.4S
    SQDMLAL  V23.4S, V21.4H, V18.4H
    SQSHRUN2 V21.16B, V10.8H, #7
    SXTL2 V27.4S, V5.8H
    SQDMLSL  V29.4S, V23.4H, V17.4H
    SMULL2 V18.2D, V12.4S, V21.S[0x2]
    SQSHRN V21.8B, V27.8H, #3
    SMOV  X16, V29.S[0x1]
    SRSHR  V25.8H, V25.8H, #15
    SRSRA  V3.16B, V18.16B, #1
    SQRSHRN V31.8B, V3.8H, #4
    SQDMLAL2  V29.2D, V31.4S, V31.4S
    SQDMLSL S10, H29, V12.H[0x5]
    SQRSHRUN V24.4H, V25.4S, #9
    SSUBW  V3.8H, V21.8H, V21.8B
    SQRSHRUN2 V20.4S, V3.2D, #5
    SQRSHRN V18.2S, V10.2D, #30
    SABD  V4.16B, V24.16B, V20.16B
    SQSHL  V17.8H, V4.8H, V4.8H
    SABA  V20.16B, V18.16B, V17.16B
    SQSHLU  V12.8H, V0.8H, #0xa
    SMULL2 V24.2D, V21.4S, V12.S[0x2]
    SADDL  V31.4S, V22.4H, V6.4H
    SMULL V6.2D, V26.2S, V17.S[0x2]
    SRSHR  V26.8H, V0.8H, #10
    SQDMLAL2 V2.4S, V17.8H, V3.H[0x3]
    SQDMULL  V18.4S, V6.4H, V20.4H
    SSRA V23.2D, V26.2D, #25
    SADDLV  D11, V18.4S
    SSRA  V4.8B, V13.8B, #8
    SQRSHRN V21.8B, V18.8H, #7
    SQRSHRN2 V10.4S, V13.2D, #3
    SQRSHRUN V12.4H, V25.4S, #6
    SQDMLAL2 V18.2D, V24.4S, V24.S[0x2]
    SSHR V20.2D, V31.2D, #2
    SQRSHRUN V31.4H, V21.4S, #9
    SQSHRUN V21.2S, V18.2D, #2
    SMLAL2  V29.2D, V10.4S, V31.4S
    SQSHL  V22.16B, V2.16B, #0x1
    SQDMLSL D21, S22, V12.S[0x1]
    SMLAL2  V2.4S, V23.8H, V23.8H
    SABDL2  V13.2D, V21.4S, V4.4S
    SSHLL2 V25.8H, V13.16B, #0x3
    SMLSL V26.2D, V2.2S, V11.S[0x1]
    SMLSL  V31.4S, V25.4H, V29.4H
    SXTL2 V18.2D, V20.4S
    SQDMULL2 V2.2D, V26.4S, V31.S[0x3]
    SMLSL V24.4S, V2.4H, V2.H[0x5]
    SSHLL2 V11.4S, V24.8H, #0xb
    SSRA V24.2D, V11.2D, #58
    SQSHRN2 V6.4S, V18.2D, #25
    SQDMULH  V12.8H, V6.8H, V24.8H
    SQSHRN V13.2S, V23.2D, #21
    SQSUB  V22.4H, V17.4H, V7.4H
    SQXTUN2  V4.4S, V16.2D
    SQDMLAL V20.2D, V18.2S, V26.S[0x1]
    SQSHL  V31.2S, V18.2S, #0xc
    SSHLL2 V7.2D, V14.4S, #0x1f
    SABAL2  V10.2D, V3.4S, V11.4S
    SSRA  V14.4S, V18.4S, #19
    SRSHR V3.2D, V14.2D, #9
    SQDMLSL S21, H12, V11.H[0x3]
    SQSHRN2 V6.16B, V13.8H, #8
    SQSHL  V23.2D, V22.2D, V31.2D
    SSHLL2 V18.4S, V4.8H, #0x2
    SMLSL  V14.2D, V20.2S, V20.2S
    SSHLL V24.8H, V7.8B, #0x7
    SQRDMULH  V26.4H, V21.4H, V7.H[0x2]
    SQSHL  V13.2S, V10.2S, #0x12
    SADDLV  S2, V14.4H
    SQDMLAL2 V29.2D, V3.4S, V25.S[0x2]
    SHADD  V22.8H, V13.8H, V6.8H
    SUQADD  V13.2D, V18.2D
    SQSHL  V25.8B, V13.8B, #0x1
    SADALP  V17.2D, V23.4S
    SMLSL V10.2D, V29.2S, V25.S[0x1]
    SQSHL  V18.16B, V22.16B, #0x1
    SMLSL V16.4S, V18.4H, V0.H[0x0]
    SRSRA V11.2D, V2.2D, #56
    SQRSHRN V0.8B, V17.8H, #2
    SQRSHRUN V22.2S, V16.2D, #25
    SADDLV  D12, V22.4S
    SQSHRN2 V13.8H, V24.4S, #5
    SRSRA V20.2D, V11.2D, #58
    SMULL2  V7.4S, V26.8H, V10.8H
    SQSHLU  V2.16B, V13.16B, #0x2
    SMLAL V22.2D, V20.2S, V12.S[0x1]
    SRSRA V11.2D, V7.2D, #38
    SADDLV  H26, V16.8B
    SQDMULL S13, H26, V2.H[0x3]
    SQDMLSL2  V6.4S, V13.8H, V0.8H
    SQDMULL2  V24.2D, V22.4S, V6.4S
    SMLAL2 V7.4S, V24.8H, V11.H[0x7]
    SHADD  V10.16B, V29.16B, V25.16B
    SQDMULL V20.2D, V8.2S, V4.S[0x3]
    SQDMULL D12, S26, V1.S[0x3]
    SQDMULL2 V18.4S, V19.8H, V12.H[0x7]
    SXTL V13.8H, V23.8B
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_5
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x800, LSL #16
    MRS  X10, FPSR
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D0
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D1
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D2
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D3
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D4
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D5
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D6
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D7
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x1, LSL #0
    MOVK  X13, #0x1, LSL #16
    MOVK  X13, #0x1, LSL #32
    MOVK  X13, #0x1, LSL #48
    FMOV  X10, D8
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X10, V9.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X10, D9
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D10
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D11
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D12
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D13
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D14
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X10, V15.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X10, D15
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X10, V16.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X10, D16
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D17
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D18
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X10, V19.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X10, D19
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D20
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D21
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D22
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D23
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D24
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D25
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xfff8, LSL #0
    FMOV  X10, D26
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D27
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D28
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D29
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X10, D30
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X10, D31
    SUB  X20, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x1370, LSL #0
    MOVK  X3, #0xc6d7, LSL #16
    MOVK  X3, #0x86f8, LSL #32
    MOVK  X3, #0xa4c, LSL #48
    MOVZ  X4, #0x56f6, LSL #0
    MOVK  X4, #0x553b, LSL #16
    MOVK  X4, #0x9d77, LSL #32
    MOVK  X4, #0x198a, LSL #48
    MOVZ  X5, #0x94a6, LSL #0
    MOVK  X5, #0xe822, LSL #16
    MOVK  X5, #0x4e40, LSL #32
    MOVK  X5, #0xf6ef, LSL #48
    MOVZ  X6, #0x26f8, LSL #0
    MOVK  X6, #0x3440, LSL #16
    MOVK  X6, #0xa1c8, LSL #32
    MOVK  X6, #0xdf1b, LSL #48
    MOVZ  X7, #0x8882, LSL #0
    MOVK  X7, #0xf237, LSL #16
    MOVK  X7, #0x4f5f, LSL #32
    MOVK  X7, #0xdfe1, LSL #48
    MOVZ  X10, #0xe678, LSL #0
    MOVK  X10, #0x7c67, LSL #16
    MOVK  X10, #0x7612, LSL #32
    MOVK  X10, #0xfe74, LSL #48
    MOVZ  X11, #0xdf2a, LSL #0
    MOVK  X11, #0x70be, LSL #16
    MOVK  X11, #0x74e9, LSL #32
    MOVK  X11, #0x7577, LSL #48
    MOVZ  X12, #0x5e52, LSL #0
    MOVK  X12, #0x4b56, LSL #16
    MOVK  X12, #0x48d3, LSL #32
    MOVK  X12, #0x65ab, LSL #48
    MOVZ  X13, #0x1940, LSL #0
    MOVK  X13, #0x81d9, LSL #16
    MOVK  X13, #0xbfd0, LSL #32
    MOVK  X13, #0x5136, LSL #48
    MOVZ  X14, #0x431e, LSL #0
    MOVK  X14, #0x6dc1, LSL #16
    MOVK  X14, #0x216c, LSL #32
    MOVK  X14, #0xa087, LSL #48
    MOVZ  X15, #0xd1c, LSL #0
    MOVK  X15, #0xe19b, LSL #16
    MOVK  X15, #0x18e7, LSL #32
    MOVK  X15, #0x64c, LSL #48
    MOVZ  X16, #0xb0cd, LSL #0
    MOVK  X16, #0xd08f, LSL #16
    MOVK  X16, #0x476, LSL #32
    MOVK  X16, #0xfc04, LSL #48
    MOVZ  X17, #0xb0a3, LSL #0
    MOVK  X17, #0xcd0d, LSL #16
    MOVK  X17, #0xa4d6, LSL #32
    MOVK  X17, #0xc5a5, LSL #48
    MOVZ  X18, #0x31d2, LSL #0
    MOVK  X18, #0xec1a, LSL #16
    MOVK  X18, #0xec51, LSL #32
    MOVK  X18, #0x4320, LSL #48
    MOVZ  X19, #0x1ee0, LSL #0
    MOVK  X19, #0x4556, LSL #16
    MOVK  X19, #0x914e, LSL #32
    MOVK  X19, #0x232, LSL #48
    MOVZ  X20, #0x9366, LSL #0
    MOVK  X20, #0xe35a, LSL #16
    MOVK  X20, #0x76a3, LSL #32
    MOVK  X20, #0xf914, LSL #48
    MOVZ  X21, #0xd45a, LSL #0
    MOVK  X21, #0xa8a4, LSL #16
    MOVK  X21, #0x489, LSL #32
    MOVK  X21, #0xb38e, LSL #48
    MOVZ  X22, #0x48db, LSL #0
    MOVK  X22, #0xac31, LSL #16
    MOVK  X22, #0xed98, LSL #32
    MOVK  X22, #0x9dc5, LSL #48
    MOVZ  X23, #0x4425, LSL #0
    MOVK  X23, #0x6a83, LSL #16
    MOVK  X23, #0x71d1, LSL #32
    MOVK  X23, #0x6606, LSL #48
    MOVZ  X24, #0x3b21, LSL #0
    MOVK  X24, #0x261b, LSL #16
    MOVK  X24, #0x29d9, LSL #32
    MOVK  X24, #0x81d6, LSL #48
    MOVZ  X25, #0x6755, LSL #0
    MOVK  X25, #0x41f9, LSL #16
    MOVK  X25, #0xb277, LSL #32
    MOVK  X25, #0xfc36, LSL #48
    MOVZ  X26, #0xff75, LSL #0
    MOVK  X26, #0xa951, LSL #16
    MOVK  X26, #0xbcca, LSL #32
    MOVK  X26, #0xe312, LSL #48
    MOVZ  X28, #0xc072, LSL #0
    MOVK  X28, #0xb9fb, LSL #16
    MOVK  X28, #0x9dd6, LSL #32
    MOVK  X28, #0x1098, LSL #48
    MOVZ  X29, #0x7685, LSL #0
    MOVK  X29, #0xb0ac, LSL #16
    MOVK  X29, #0xd073, LSL #32
    MOVK  X29, #0x6801, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X29
    FMOV  D3, X15
    FMOV  V3.D[1], X20
    FMOV  D4, X17
    FMOV  V4.D[1], X25
    FMOV  D5, X26
    FMOV  V5.D[1], X4
    FMOV  D6, X29
    FMOV  V6.D[1], X18
    FMOV  D7, X6
    FMOV  V7.D[1], X19
    FMOV  D8, X22
    FMOV  V8.D[1], X26
    FMOV  D9, X29
    FMOV  V9.D[1], X24
    FMOV  D10, X16
    FMOV  V10.D[1], X23
    FMOV  D11, X23
    FMOV  V11.D[1], X4
    FMOV  D12, X12
    FMOV  V12.D[1], X13
    FMOV  D13, X29
    FMOV  V13.D[1], X18
    FMOV  D14, X3
    FMOV  V14.D[1], X6
    FMOV  D15, X29
    FMOV  V15.D[1], X15
    FMOV  D16, X12
    FMOV  V16.D[1], X21
    FMOV  D17, X19
    FMOV  V17.D[1], X3
    FMOV  D18, X15
    FMOV  V18.D[1], X21
    FMOV  D19, X14
    FMOV  V19.D[1], X29
    FMOV  D20, X3
    FMOV  V20.D[1], X25
    FMOV  D21, X24
    FMOV  V21.D[1], X10
    FMOV  D22, X24
    FMOV  V22.D[1], X24
    FMOV  D23, X14
    FMOV  V23.D[1], X19
    FMOV  D24, X3
    FMOV  V24.D[1], X18
    FMOV  D25, X21
    FMOV  V25.D[1], X11
    FMOV  D26, X13
    FMOV  V26.D[1], X25
    FMOV  D27, X18
    FMOV  V27.D[1], X21
    FMOV  D28, X23
    FMOV  V28.D[1], X15
    FMOV  D29, X22
    FMOV  V29.D[1], X14
    FMOV  D30, X17
    FMOV  V30.D[1], X25
    FMOV  D31, X24
    FMOV  V31.D[1], X20
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_6:
    SQRSHL  V9.16B, V25.16B, V30.16B
    SADDLV  D28, V9.4S
    SMLAL2 V3.4S, V28.8H, V12.H[0x1]
    SQRDMULH  V18.2S, V24.2S, V27.2S
    SQRSHRN V31.2S, V3.2D, #15
    SMULL2  V31.8H, V29.16B, V31.16B
    SABD  V21.8B, V18.8B, V21.8B
    SSRA  V9.4S, V26.4S, #26
    SQDMLSL2 V3.2D, V22.4S, V9.S[0x0]
    SMLAL V1.2D, V3.2S, V23.S[0x0]
    SSHLL2 V22.4S, V1.8H, #0xa
    SMLAL2 V23.4S, V31.8H, V0.H[0x1]
    SQRSHRUN2 V1.8H, V23.4S, #7
    SRSHL  V5.2D, V24.2D, V21.2D
    SQRSHRN2 V26.4S, V22.2D, #18
    SQSHRN V29.2S, V26.2D, #32
    SQSHLU  V0.8H, V5.8H, #0x4
    SQSHRN V8.4H, V1.4S, #5
    SQSHLU  V24.4H, V0.4H, #0x0
    SMLAL V12.4S, V24.4H, V12.H[0x7]
    SQDMULL2 V6.4S, V8.8H, V12.H[0x3]
    SQDMLAL V18.4S, V6.4H, V6.H[0x7]
    SQDMLAL S26, H29, V12.H[0x5]
    SHSUB  V31.8B, V26.8B, V18.8B
    SMLSL  V22.8H, V2.8B, V31.8B
    SSHR V5.2D, V16.2D, #53
    SQDMULL S24, H23, V8.H[0x6]
    SQSHRUN V31.8B, V21.8H, #2
    SQRDMULH  V23.2S, V7.2S, V30.S[0x0]
    SQDMULL2  V16.4S, V19.8H, V26.8H
    SADDLV  S1, V4.8H
    SABAL  V0.8H, V30.8B, V10.8B
    SQDMLAL V21.4S, V29.4H, V5.H[0x0]
    SQSHRN2 V8.8H, V12.4S, #6
    SQDMULL S12, H31, V14.H[0x2]
    SQDMLSL2  V10.4S, V22.8H, V22.8H
    SQDMLAL  V2.2D, V24.2S, V24.2S
    SSHLL2 V31.4S, V23.8H, #0x4
    SSHL  V24.8H, V8.8H, V10.8H
    SMLSL V6.2D, V12.2S, V31.S[0x0]
    SADDW  V18.8H, V6.8H, V16.8B
    SQDMLAL V12.2D, V1.2S, V18.S[0x1]
    SQSUB  V16.2S, V10.2S, V2.2S
    SMLSL2  V4.2D, V24.4S, V0.4S
    SQDMULL V14.4S, V21.4H, V12.H[0x2]
    SQRDMULH  V29.4H, V16.4H, V16.4H
    SQDMLSL V7.4S, V27.4H, V14.H[0x2]
    SQRDMULH S23, S4, V7.S[0x3]
    SQDMULL2 V10.4S, V23.8H, V13.H[0x4]
    SXTL V0.4S, V10.4H
    SQRSHRUN V26.8B, V15.8H, #4
    SQSHL V6.2D, V26.2D, #0x3b
    SSHL  V31.4S, V20.4S, V22.4S
    SRSHR  V20.4H, V29.4H, #6
    SSUBL2  V26.4S, V20.8H, V20.8H
    SQSHLU  V10.4S, V0.4S, #0x7
    SQXTN  V0.4H, V10.4S
    SSHR  V24.4H, V31.4H, #6
    SABA  V15.2S, V26.2S, V0.2S
    SMULL V23.4S, V24.4H, V6.H[0x7]
    SMLSL  V22.4S, V17.4H, V23.4H
    SQSHRN2 V23.16B, V28.8H, #1
    SQDMULL2 V6.4S, V22.8H, V15.H[0x4]
    SQDMLAL  V2.2D, V6.2S, V6.2S
    SRSRA V4.2D, V2.2D, #11
    SRSRA  V27.8B, V23.8B, #6
    SQRSHRUN2 V15.8H, V4.4S, #11
    SQDMULL2 V6.2D, V27.4S, V15.S[0x2]
    SQSHRUN2 V15.8H, V13.4S, #7
    SSHLL2 V27.4S, V5.8H, #0x6
    SQDMULH  V22.8H, V10.8H, V0.H[0x5]
    SQDMULL  V20.2D, V4.2S, V4.2S
    SQDMULH H24, H2, V1.H[0x6]
    SQSHRUN V23.4H, V4.4S, #2
    SQSHRN2 V13.8H, V19.4S, #8
    SMLAL V1.4S, V16.4H, V6.H[0x1]
    SQDMULH H17, H31, V0.H[0x2]
    SQDMLAL2  V5.2D, V15.4S, V23.4S
    SQDMULH H29, H27, V13.H[0x5]
    SSUBL  V10.8H, V29.8B, V29.8B
    SQDMULL D16, S1, V22.S[0x0]
    SQNEG  V26.4H, V17.4H
    SHADD  V28.2S, V26.2S, V10.2S
    SQXTN2  V2.4S, V20.2D
    SSUBW  V13.8H, V28.8H, V16.8B
    SHADD  V26.16B, V2.16B, V30.16B
    SSRA V15.2D, V13.2D, #16
    SQRSHRUN V4.4H, V24.4S, #14
    SSHR  V22.2S, V4.2S, #16
    SMLAL V27.4S, V22.4H, V5.H[0x5]
    SQDMULL V19.4S, V27.4H, V8.H[0x7]
    SQDMULH  V0.8H, V15.8H, V15.8H
    SQSHLU  V2.8B, V0.8B, #0x1
    SMOV W11, V2.B[0xc]
    SQRSHRUN2 V22.16B, V19.8H, #3
    SQSHL  V4.8B, V22.8B, V22.8B
    SADDLV  H15, V19.8B
    SSHR  V13.2S, V26.2S, #2
    SMLSL2 V29.4S, V13.8H, V4.H[0x5]
    SMLSL V2.2D, V15.2S, V29.S[0x0]
    SQSHL  V16.2S, V0.2S, #0x19
    SRSHR V28.2D, V26.2D, #51
    SQXTUN2  V27.16B, V20.8H
    SQSHRN V30.8B, V28.8H, #6
    SQSHRUN V0.4H, V25.4S, #11
    SADDL2  V20.8H, V11.16B, V18.16B
    SQXTN2  V29.16B, V16.8H
    SMULL V4.4S, V22.4H, V11.H[0x4]
    SQSHL  V13.8B, V31.8B, #0x4
    SXTL2 V15.2D, V5.4S
    SQDMLAL V18.4S, V29.4H, V0.H[0x1]
    SMOV W11, V2.B[0x1]
    SQDMLSL V28.2D, V15.2S, V30.S[0x3]
    SMLSL V26.2D, V29.2S, V20.S[0x2]
    SQSHRN2 V31.16B, V27.8H, #3
    SSHR  V19.4S, V4.4S, #30
    SMLSL2 V8.2D, V19.4S, V18.S[0x2]
    SQDMULL V2.2D, V7.2S, V13.S[0x0]
    SQSHL  V4.8B, V31.8B, #0x6
    SQSUB  V19.8B, V4.8B, V26.8B
    SMOV  X3, V28.B[0x6]
    SSHR V11.2D, V8.2D, #14
    SSHR  V28.4H, V2.4H, #2
    SMLAL2 V16.4S, V28.8H, V9.H[0x4]
    SQSHL  V30.4S, V19.4S, #0x15
    SQRSHRN2 V29.8H, V11.4S, #8
    SRSRA V2.2D, V30.2D, #13
    SMLAL2 V7.2D, V16.4S, V16.S[0x1]
    SQSHL  V31.8H, V29.8H, #0xc
    SQSHL  V13.4H, V2.4H, #0x4
    SQDMULL S29, H13, V5.H[0x2]
    SSRA V15.2D, V29.2D, #9
    SXTL V4.4S, V15.4H
    SQSHLU V27.2D, V4.2D, #0x3b
    SQXTUN2  V2.4S, V27.2D
    SRSRA  V9.8B, V2.8B, #4
    SMULL V18.2D, V9.2S, V7.S[0x0]
    SHADD  V22.8B, V31.8B, V31.8B
    SSHLL2 V7.8H, V22.16B, #0x6
    SMOV  X14, V7.H[0x3]
    SQRSHRN V28.8B, V14.8H, #4
    SQDMLSL S16, H20, V15.H[0x5]
    SSHR V2.2D, V30.2D, #19
    SXTL V7.4S, V29.4H
    SQDMLSL D29, S7, V29.S[0x0]
    SADALP  V14.1D, V25.2S
    SQRSHRUN V5.4H, V15.4S, #8
    SRSRA V13.2D, V7.2D, #48
    SQDMLAL S31, H22, V9.H[0x5]
    SQSHRN2 V15.16B, V31.8H, #1
    SQSHRUN V19.8B, V13.8H, #1
    SMULL V27.2D, V27.2S, V29.S[0x2]
    SQSHRUN V20.8B, V14.8H, #6
    SMLSL V30.2D, V5.2S, V16.S[0x1]
    SXTL2 V14.4S, V18.8H
    SQRDMULH S7, S2, V2.S[0x0]
    SRSHR  V13.4S, V14.4S, #30
    SQDMLAL V25.2D, V19.2S, V15.S[0x0]
    SQDMLAL V16.4S, V28.4H, V14.H[0x0]
    SMLAL V29.2D, V7.2S, V7.S[0x0]
    SADDL  V31.8H, V27.8B, V25.8B
    SQDMULL D22, S13, V31.S[0x0]
    SMULL2 V31.2D, V30.4S, V16.S[0x1]
    SABA  V9.8H, V22.8H, V27.8H
    SQDMULL  V27.4S, V31.4H, V20.4H
    SSUBL2  V5.4S, V29.8H, V27.8H
    SSUBW  V15.4S, V9.4S, V9.4H
    SMOV  X11, V15.S[0x3]
    SQSHL  V18.8B, V12.8B, #0x3
    SQSHRN V12.2S, V26.2D, #1
    SMULL2  V31.4S, V5.8H, V9.8H
    SQSHRN2 V16.4S, V5.2D, #27
    SADDL2  V30.2D, V5.4S, V13.4S
    SADALP  V20.4H, V21.8B
    SADDL2  V2.8H, V24.16B, V11.16B
    SADDLV  S15, V15.8H
    SSRA  V27.8B, V20.8B, #2
    SMLSL V20.4S, V8.4H, V7.H[0x3]
    SRSRA V19.2D, V16.2D, #23
    SQSUB  V25.8B, V12.8B, V18.8B
    SMULL V5.4S, V19.4H, V15.H[0x1]
    SQSHL  V9.8H, V31.8H, #0x2
    SSRA V26.2D, V18.2D, #41
    SQXTN2  V21.8H, V27.4S
    SADDLP  V11.1D, V20.2S
    SMULL V29.4S, V21.4H, V9.H[0x2]
    SQSUB  V9.16B, V2.16B, V11.16B
    SMULL V27.4S, V26.4H, V1.H[0x3]
    SRHADD  V22.4S, V27.4S, V30.4S
    SADDW  V19.4S, V22.4S, V22.4H
    SQSHRN V16.2S, V29.2D, #28
    SABDL2  V13.8H, V9.16B, V30.16B
    SRSHR  V7.4H, V16.4H, #7
    SQDMLAL2  V2.4S, V5.8H, V25.8H
    SMULL V16.4S, V2.4H, V13.H[0x7]
    SSUBW  V1.4S, V9.4S, V19.4H
    SQDMLAL2 V5.4S, V16.8H, V1.H[0x2]
    SQRSHRUN V13.4H, V5.4S, #8
    SQXTUN  V12.4H, V7.4S
    SQDMLSL S27, H12, V12.H[0x6]
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_6
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x56f6, LSL #0
    MOVK  X18, #0x553b, LSL #16
    MOVK  X18, #0x9d77, LSL #32
    MOVK  X18, #0x198a, LSL #48
    SUB  X16, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x94a6, LSL #0
    MOVK  X18, #0xe822, LSL #16
    MOVK  X18, #0x4e40, LSL #32
    MOVK  X18, #0xf6ef, LSL #48
    SUB  X16, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x26f8, LSL #0
    MOVK  X18, #0x3440, LSL #16
    MOVK  X18, #0xa1c8, LSL #32
    MOVK  X18, #0xdf1b, LSL #48
    SUB  X16, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x8882, LSL #0
    MOVK  X18, #0xf237, LSL #16
    MOVK  X18, #0x4f5f, LSL #32
    MOVK  X18, #0xdfe1, LSL #48
    SUB  X16, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xe678, LSL #0
    MOVK  X18, #0x7c67, LSL #16
    MOVK  X18, #0x7612, LSL #32
    MOVK  X18, #0xfe74, LSL #48
    SUB  X16, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x5e52, LSL #0
    MOVK  X18, #0x4b56, LSL #16
    MOVK  X18, #0x48d3, LSL #32
    MOVK  X18, #0x65ab, LSL #48
    SUB  X16, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x1940, LSL #0
    MOVK  X18, #0x81d9, LSL #16
    MOVK  X18, #0xbfd0, LSL #32
    MOVK  X18, #0x5136, LSL #48
    SUB  X16, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xd1c, LSL #0
    MOVK  X18, #0xe19b, LSL #16
    MOVK  X18, #0x18e7, LSL #32
    MOVK  X18, #0x64c, LSL #48
    SUB  X16, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xb0a3, LSL #0
    MOVK  X18, #0xcd0d, LSL #16
    MOVK  X18, #0xa4d6, LSL #32
    MOVK  X18, #0xc5a5, LSL #48
    SUB  X16, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x9366, LSL #0
    MOVK  X18, #0xe35a, LSL #16
    MOVK  X18, #0x76a3, LSL #32
    MOVK  X18, #0xf914, LSL #48
    SUB  X16, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xd45a, LSL #0
    MOVK  X18, #0xa8a4, LSL #16
    MOVK  X18, #0x489, LSL #32
    MOVK  X18, #0xb38e, LSL #48
    SUB  X16, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x48db, LSL #0
    MOVK  X18, #0xac31, LSL #16
    MOVK  X18, #0xed98, LSL #32
    MOVK  X18, #0x9dc5, LSL #48
    SUB  X16, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x4425, LSL #0
    MOVK  X18, #0x6a83, LSL #16
    MOVK  X18, #0x71d1, LSL #32
    MOVK  X18, #0x6606, LSL #48
    SUB  X16, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x6755, LSL #0
    MOVK  X18, #0x41f9, LSL #16
    MOVK  X18, #0xb277, LSL #32
    MOVK  X18, #0xfc36, LSL #48
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xff75, LSL #0
    MOVK  X18, #0xa951, LSL #16
    MOVK  X18, #0xbcca, LSL #32
    MOVK  X18, #0xe312, LSL #48
    SUB  X16, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xc072, LSL #0
    MOVK  X18, #0xb9fb, LSL #16
    MOVK  X18, #0x9dd6, LSL #32
    MOVK  X18, #0x1098, LSL #48
    SUB  X16, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x7685, LSL #0
    MOVK  X18, #0xb0ac, LSL #16
    MOVK  X18, #0xd073, LSL #32
    MOVK  X18, #0x6801, LSL #48
    SUB  X16, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x800, LSL #16
    MRS  X16, FPSR
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D0
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x22, LSL #0
    MOVK  X18, #0xff9f, LSL #16
    FMOV  X16, D1
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x9a6, LSL #0
    MOVK  X18, #0x7fe5, LSL #16
    MOVK  X18, #0xa05a, LSL #32
    MOVK  X18, #0xf992, LSL #48
    FMOV  X16, V3.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xd55c, LSL #0
    MOVK  X18, #0x4769, LSL #16
    MOVK  X18, #0xfdb6, LSL #32
    MOVK  X18, #0x625, LSL #48
    FMOV  X16, D3
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x8000, LSL #0
    FMOV  X16, D8
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x22, LSL #0
    MOVK  X18, #0xff9f, LSL #16
    FMOV  X16, D9
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D10
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xde, LSL #0
    MOVK  X18, #0x161, LSL #16
    FMOV  X16, D11
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D13
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D14
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D16
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D18
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x8e, LSL #0
    MOVK  X18, #0x7b, LSL #16
    MOVK  X18, #0x50, LSL #32
    MOVK  X18, #0xe6, LSL #48
    FMOV  X16, D20
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x7fff, LSL #0
    MOVK  X18, #0x7fff, LSL #16
    FMOV  X16, V21.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x2866, LSL #0
    MOVK  X18, #0x1c5f, LSL #16
    MOVK  X18, #0x460a, LSL #32
    MOVK  X18, #0x7a6c, LSL #48
    FMOV  X16, D21
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D26
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D27
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D28
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X19, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X11
    FMOV  V1.D[1], X12
    FMOV  D2, X16
    FMOV  V2.D[1], X19
    FMOV  D3, X18
    FMOV  V3.D[1], X23
    FMOV  D4, X25
    FMOV  V4.D[1], X20
    FMOV  D5, X15
    FMOV  V5.D[1], X22
    FMOV  D6, X29
    FMOV  V6.D[1], X26
    FMOV  D7, X21
    FMOV  V7.D[1], X7
    FMOV  D8, X13
    FMOV  V8.D[1], X6
    FMOV  D9, X21
    FMOV  V9.D[1], X25
    FMOV  D10, X23
    FMOV  V10.D[1], X7
    FMOV  D11, X15
    FMOV  V11.D[1], X21
    FMOV  D12, X12
    FMOV  V12.D[1], X11
    FMOV  D13, X6
    FMOV  V13.D[1], X13
    FMOV  D14, X14
    FMOV  V14.D[1], X13
    FMOV  D15, X28
    FMOV  V15.D[1], X28
    FMOV  D16, X4
    FMOV  V16.D[1], X25
    FMOV  D17, X15
    FMOV  V17.D[1], X18
    FMOV  D18, X10
    FMOV  V18.D[1], X28
    FMOV  D19, X13
    FMOV  V19.D[1], X3
    FMOV  D20, X14
    FMOV  V20.D[1], X16
    FMOV  D21, X24
    FMOV  V21.D[1], X6
    FMOV  D22, X29
    FMOV  V22.D[1], X17
    FMOV  D23, X19
    FMOV  V23.D[1], X3
    FMOV  D24, X29
    FMOV  V24.D[1], X11
    FMOV  D25, X13
    FMOV  V25.D[1], X26
    FMOV  D26, X6
    FMOV  V26.D[1], X25
    FMOV  D27, X18
    FMOV  V27.D[1], X3
    FMOV  D28, X12
    FMOV  V28.D[1], X4
    FMOV  D29, X5
    FMOV  V29.D[1], X14
    FMOV  D30, X4
    FMOV  V30.D[1], X5
    FMOV  D31, X11
    FMOV  V31.D[1], X20
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_7:
    SQSHL  V14.4H, V26.4H, #0x1
    SMOV  X29, V28.H[0x7]
    SQDMULL2 V9.4S, V27.8H, V14.H[0x1]
    SQXTN  V22.4H, V25.4S
    SQDMLSL2  V9.2D, V24.4S, V29.4S
    SQDMLSL S14, H22, V9.H[0x3]
    SSHR  V15.4H, V21.4H, #11
    SABD  V27.8H, V30.8H, V15.8H
    SMULL2 V16.4S, V14.8H, V14.H[0x4]
    SRSHR  V21.2S, V23.2S, #17
    SABAL2  V2.2D, V31.4S, V16.4S
    SQDMLAL2 V31.4S, V2.8H, V2.H[0x1]
    SQDMLAL V4.4S, V27.4H, V8.H[0x3]
    SMLAL2 V16.2D, V31.4S, V4.S[0x3]
    SMOV  X4, V16.B[0xb]
    SMLAL  V28.2D, V18.2S, V1.2S
    SQDMLSL D2, S25, V10.S[0x1]
    SQDMULL S10, H5, V7.H[0x4]
    SMULL2  V1.4S, V23.8H, V25.8H
    SADDLV  D16, V23.4S
    SQSHL  V29.8B, V23.8B, V27.8B
    SQDMULH  V4.4S, V20.4S, V29.S[0x1]
    SMOV W12, V19.H[0x5]
    SQDMLAL D8, S14, V6.S[0x1]
    SQSUB  V25.8H, V0.8H, V26.8H
    SSHR  V19.2S, V25.2S, #9
    SRSRA  V31.4S, V16.4S, #3
    SMULL V15.4S, V28.4H, V9.H[0x5]
    SQDMULH  V18.8H, V2.8H, V15.8H
    SQDMLSL S30, H19, V8.H[0x2]
    SQDMULL D23, S10, V30.S[0x0]
    SRSRA  V25.8B, V21.8B, #4
    SMLAL2 V26.2D, V25.4S, V1.S[0x3]
    SQDMULH  V2.2S, V26.2S, V31.S[0x0]
    SADDW  V0.4S, V18.4S, V26.4H
    SQDMLAL2 V27.2D, V0.4S, V23.S[0x3]
    SQSHLU  V30.8H, V4.8H, #0x3
    SQDMULL V0.2D, V30.2S, V2.S[0x3]
    SQABS  V31.8H, V27.8H
    SRSRA  V27.4S, V4.4S, #8
    SSUBW  V5.2D, V0.2D, V0.2S
    SQSHRUN V10.4H, V31.4S, #5
    SQSHRN V26.8B, V10.8H, #2
    SSHR  V19.8H, V27.8H, #12
    SRSHR V4.2D, V5.2D, #6
    SQDMLAL2 V27.4S, V4.8H, V4.H[0x4]
    SMLSL2 V8.4S, V19.8H, V7.H[0x7]
    SQSHRN V1.2S, V26.2D, #31
    SQRSHRUN2 V18.16B, V27.8H, #5
    SQRSHL  V2.2D, V8.2D, V8.2D
    SQDMULH  V0.4H, V18.4H, V2.4H
    SSHL  V4.2D, V23.2D, V0.2D
    SQRSHRUN2 V25.8H, V4.4S, #9
    SMULL2  V30.2D, V15.4S, V25.4S
    SQDMLSL V25.2D, V1.2S, V30.S[0x3]
    SRHADD  V0.2S, V30.2S, V26.2S
    SMLSL2 V15.4S, V28.8H, V12.H[0x2]
    SQSHRUN2 V5.8H, V5.4S, #10
    SQDMULL V2.4S, V27.4H, V10.H[0x5]
    SMLSL V26.2D, V25.2S, V28.S[0x1]
    SRSHL  V27.8H, V28.8H, V14.8H
    SQSHL  V10.16B, V14.16B, #0x4
    SMLAL  V23.4S, V10.4H, V23.4H
    SHADD  V28.8B, V0.8B, V5.8B
    SQRSHRUN2 V0.4S, V30.2D, #3
    SQRSHRUN V1.2S, V28.2D, #19
    SQDMULL  V28.4S, V27.4H, V8.4H
    SABDL  V12.4S, V17.4H, V28.4H
    SQRSHRUN V18.8B, V26.8H, #7
    SSHL  V27.8H, V24.8H, V19.8H
    SQDMULH  V5.8H, V20.8H, V22.8H
    SSUBW  V10.8H, V5.8H, V18.8B
    SQSHRUN V7.8B, V15.8H, #2
    SQSUB  V18.8H, V1.8H, V23.8H
    SQSHL  V22.4H, V5.4H, #0x9
    SQSHRN V30.8B, V22.8H, #8
    SADDW2  V25.4S, V12.4S, V30.8H
    SQDMLSL2 V8.2D, V10.4S, V0.S[0x2]
    SSHR  V24.8H, V25.8H, #1
    SMULL V14.2D, V8.2S, V27.S[0x3]
    SXTL2 V19.2D, V18.4S
    SQDMLSL  V28.4S, V14.4H, V24.4H
    SSHLL2 V5.8H, V7.16B, #0x7
    SQSHLU V15.2D, V19.2D, #0x37
    SSUBL2  V0.8H, V15.16B, V5.16B
    SRSRA  V27.8H, V0.8H, #9
    SADDLV  S8, V27.8H
    SQRSHRN2 V0.4S, V2.2D, #31
    SQSHL  V24.8B, V8.8B, V0.8B
    SABAL  V5.8H, V28.8B, V28.8B
    SRSHR  V20.16B, V24.16B, #1
    SQRSHRUN2 V22.8H, V20.4S, #14
    SABAL  V14.8H, V22.8B, V5.8B
    SQSHLU  V30.4H, V4.4H, #0x3
    SQSHRN2 V25.4S, V21.2D, #25
    SRHADD  V10.8B, V27.8B, V2.8B
    SQRSHL  V7.2D, V30.2D, V16.2D
    SQDMULH  V20.2S, V7.2S, V11.S[0x3]
    SQSHRN V11.4H, V21.4S, #11
    SSHR  V21.4S, V30.4S, #30
    SMOV  X5, V21.S[0x1]
    SMLAL  V0.2D, V23.2S, V18.2S
    SMLAL V23.4S, V2.4H, V10.H[0x4]
    SQSHLU  V22.4S, V20.4S, #0x4
    SQRDMULH  V24.2S, V24.2S, V25.S[0x3]
    SQDMLAL V18.2D, V1.2S, V17.S[0x1]
    SMLSL  V8.2D, V2.2S, V14.2S
    SQRSHRN2 V30.16B, V6.8H, #8
    SQDMLAL V21.2D, V29.2S, V18.S[0x2]
    SMLAL2 V4.4S, V2.8H, V1.H[0x4]
    SQRSHRUN V20.4H, V0.4S, #14
    SADDW  V1.4S, V21.4S, V8.4H
    SQRSHRUN2 V25.8H, V22.4S, #2
    SSUBL  V16.8H, V24.8B, V25.8B
    SQRSHRUN2 V18.16B, V23.8H, #2
    SABAL2  V5.2D, V16.4S, V11.4S
    SSRA  V11.8H, V4.8H, #4
    SSHR  V28.4S, V31.4S, #29
    SADDW2  V0.2D, V5.2D, V30.4S
    SABAL  V31.4S, V1.4H, V11.4H
    SSUBW2  V29.8H, V28.8H, V13.16B
    SMULL V6.4S, V0.4H, V0.H[0x5]
    SQDMLAL S10, H20, V6.H[0x3]
    SQDMULL2 V24.2D, V31.4S, V18.S[0x1]
    SQSHRN2 V21.8H, V10.4S, #4
    SQSHL  V30.2S, V10.2S, #0x16
    SQSHLU  V5.8H, V30.8H, #0x8
    SQSHL  V8.8H, V29.8H, #0x1
    SADDL  V22.8H, V3.8B, V27.8B
    SSHR V4.2D, V24.2D, #23
    SQDMULH  V17.8H, V26.8H, V8.H[0x4]
    SMLSL2 V24.2D, V17.4S, V21.S[0x2]
    SADDW  V0.4S, V24.4S, V4.4H
    SSHR  V21.16B, V5.16B, #6
    SQDMLSL2 V11.4S, V0.8H, V14.H[0x4]
    SRSRA  V16.8B, V2.8B, #1
    SMLSL V25.4S, V22.4H, V11.H[0x6]
    SRSHR  V27.8H, V21.8H, #4
    SQRDMULH  V22.2S, V27.2S, V29.2S
    SQRSHRUN2 V24.4S, V22.2D, #20
    SABDL2  V4.2D, V24.4S, V16.4S
    SQDMULL2  V8.2D, V4.4S, V4.4S
    SMOV W3, V25.B[0x4]
    SQNEG  V16.2D, V29.2D
    SQDMULH  V24.8H, V2.8H, V30.8H
    SQSHLU  V10.8B, V25.8B, #0x1
    SMULL V3.4S, V11.4H, V6.H[0x7]
    SMLAL V4.4S, V14.4H, V10.H[0x7]
    SQDMLSL V25.4S, V29.4H, V0.H[0x6]
    SQSHRN V0.2S, V31.2D, #16
    SSUBW  V20.4S, V23.4S, V31.4H
    SMOV W28, V21.B[0x4]
    SQSHL  V5.16B, V14.16B, #0x2
    SQADD  V27.8H, V8.8H, V19.8H
    SQSHLU  V22.4H, V27.4H, #0xc
    SMULL2 V27.4S, V3.8H, V12.H[0x0]
    SSHLL V2.4S, V0.4H, #0x5
    SSHLL2 V30.2D, V22.4S, #0x2
    SQSHRN V12.2S, V16.2D, #2
    SQRDMULH  V29.4H, V24.4H, V5.H[0x2]
    SRSHL  V8.8B, V1.8B, V27.8B
    SQSHL  V11.8H, V4.8H, #0x8
    SRSHR  V16.4H, V6.4H, #7
    SSHLL V6.2D, V8.2S, #0xb
    SQDMLAL2 V27.4S, V6.8H, V13.H[0x4]
    SSRA  V8.8B, V2.8B, #4
    SSHR  V12.16B, V16.16B, #8
    SXTL2 V24.8H, V8.16B
    SQSHL  V31.16B, V20.16B, #0x2
    SQDMLSL  V21.2D, V31.2S, V12.2S
    SADDW  V16.2D, V21.2D, V21.2S
    SQXTUN  V5.8B, V16.8H
    SRSRA  V23.2S, V27.2S, #10
    SQDMLAL  V21.4S, V24.4H, V30.4H
    SSHLL2 V3.4S, V21.8H, #0x4
    SMOV  X22, V3.S[0x0]
    SMOV  X24, V29.H[0x4]
    SSHR  V3.4H, V11.4H, #7
    SQNEG  V24.8B, V5.8B
    SQABS  V8.2D, V23.2D
    SQDMLAL S4, H8, V8.H[0x1]
    SMOV W18, V3.H[0x5]
    SQDMULH S20, S4, V4.S[0x3]
    SRSHR  V13.8B, V20.8B, #5
    SMLSL  V8.2D, V24.2S, V24.2S
    SABA  V2.16B, V12.16B, V8.16B
    SQRSHRUN2 V23.8H, V2.4S, #11
    SQRSHRUN V30.8B, V13.8H, #3
    SQDMLSL V16.4S, V30.4H, V6.H[0x3]
    SQSHRUN V24.8B, V23.8H, #8
    SQSHRN2 V31.16B, V24.8H, #1
    SQDMULL2  V12.4S, V31.8H, V16.8H
    SMLSL V4.4S, V14.4H, V8.H[0x0]
    SQSHL  V27.8H, V7.8H, #0xb
    SABD  V21.2S, V16.2S, V25.2S
    SQDMULH  V5.2S, V25.2S, V16.S[0x1]
    SADDL2  V13.2D, V18.4S, V10.4S
    SADDLV  H8, V22.8B
    SSHR  V14.16B, V12.16B, #8
    SQSHRUN2 V18.16B, V21.8H, #3
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_7
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x800, LSL #16
    MRS  X17, FPSR
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D0
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D3
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D4
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D5
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D7
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D11
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D13
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D16
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D17
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D19
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D21
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D30
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X17, D31
    SUB  X16, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSignedOperation_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X21
    FMOV  D1, X28
    FMOV  V1.D[1], X24
    FMOV  D2, X25
    FMOV  V2.D[1], X29
    FMOV  D3, X24
    FMOV  V3.D[1], X3
    FMOV  D4, X10
    FMOV  V4.D[1], X19
    FMOV  D5, X7
    FMOV  V5.D[1], X22
    FMOV  D6, X29
    FMOV  V6.D[1], X18
    FMOV  D7, X6
    FMOV  V7.D[1], X18
    FMOV  D8, X7
    FMOV  V8.D[1], X15
    FMOV  D9, X6
    FMOV  V9.D[1], X18
    FMOV  D10, X28
    FMOV  V10.D[1], X13
    FMOV  D11, X11
    FMOV  V11.D[1], X13
    FMOV  D12, X11
    FMOV  V12.D[1], X10
    FMOV  D13, X14
    FMOV  V13.D[1], X3
    FMOV  D14, X3
    FMOV  V14.D[1], X7
    FMOV  D15, X21
    FMOV  V15.D[1], X25
    FMOV  D16, X16
    FMOV  V16.D[1], X5
    FMOV  D17, X22
    FMOV  V17.D[1], X25
    FMOV  D18, X24
    FMOV  V18.D[1], X26
    FMOV  D19, X15
    FMOV  V19.D[1], X4
    FMOV  D20, X7
    FMOV  V20.D[1], X4
    FMOV  D21, X25
    FMOV  V21.D[1], X20
    FMOV  D22, X24
    FMOV  V22.D[1], X28
    FMOV  D23, X28
    FMOV  V23.D[1], X28
    FMOV  D24, X6
    FMOV  V24.D[1], X20
    FMOV  D25, X28
    FMOV  V25.D[1], X18
    FMOV  D26, X15
    FMOV  V26.D[1], X28
    FMOV  D27, X16
    FMOV  V27.D[1], X23
    FMOV  D28, X22
    FMOV  V28.D[1], X29
    FMOV  D29, X3
    FMOV  V29.D[1], X17
    FMOV  D30, X3
    FMOV  V30.D[1], X13
    FMOV  D31, X21
    FMOV  V31.D[1], X10
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_8:
    SSHR  V15.4H, V29.4H, #1
    SQDMLSL2 V18.4S, V20.8H, V12.H[0x7]
    SSHR  V19.4S, V18.4S, #23
    SQDMLAL V18.2D, V24.2S, V21.S[0x3]
    SMOV W13, V27.B[0x5]
    SSRA  V8.2S, V26.2S, #21
    SABDL2  V31.4S, V30.8H, V15.8H
    SADDL  V17.4S, V18.4H, V18.4H
    SQDMLSL  V7.4S, V8.4H, V19.4H
    SABDL2  V1.2D, V17.4S, V31.4S
    SQDMLSL2  V3.4S, V1.8H, V25.8H
    SQXTUN  V18.4H, V3.4S
    SQDMULL2 V1.2D, V7.4S, V7.S[0x0]
    SQDMULH  V27.2S, V18.2S, V18.S[0x3]
    SQSHRUN2 V21.16B, V1.8H, #6
    SQRDMULH  V16.4H, V27.4H, V11.H[0x2]
    SQRSHRUN2 V27.16B, V16.8H, #8
    SXTL2 V24.4S, V27.8H
    SSHL  V19.16B, V21.16B, V28.16B
    SMOV W5, V19.B[0x4]
    SSRA V8.2D, V27.2D, #30
    SQXTN2  V26.4S, V18.2D
    SMLSL V27.2D, V10.2S, V26.S[0x0]
    SMULL V1.4S, V0.4H, V6.H[0x5]
    SSHLL2 V16.8H, V25.16B, #0x1
    SMULL2  V21.8H, V5.16B, V28.16B
    SQDMULL V31.4S, V26.4H, V0.H[0x7]
    SQSHRUN V19.8B, V27.8H, #7
    SMULL2 V12.2D, V18.4S, V5.S[0x1]
    SQRSHRN2 V28.4S, V24.2D, #27
    SADDL  V3.4S, V9.4H, V5.4H
    SQSHL  V10.4H, V19.4H, #0xe
    SQDMULL V11.4S, V8.4H, V8.H[0x2]
    SQDMULL2  V24.2D, V31.4S, V26.4S
    SXTL2 V9.4S, V28.8H
    SMLSL  V31.2D, V28.2S, V9.2S
    SQSHRUN2 V25.16B, V31.8H, #8
    SADALP  V0.4H, V16.8B
    SQDMULL S17, H10, V9.H[0x0]
    SMLSL2 V26.4S, V8.8H, V1.H[0x4]
    SSHLL V27.8H, V26.8B, #0x4
    SSHLL2 V6.8H, V0.16B, #0x1
    SQDMLAL2  V1.4S, V17.8H, V11.8H
    SQSHL  V18.16B, V12.16B, #0x0
    SRSHR V0.2D, V25.2D, #45
    SQRSHRUN2 V19.8H, V0.4S, #10
    SSRA V0.2D, V19.2D, #24
    SRSHL  V12.2S, V24.2S, V0.2S
    SABAL  V28.8H, V6.8B, V18.8B
    SQRSHRN2 V5.8H, V28.4S, #12
    SABDL  V31.4S, V3.4H, V5.4H
    SQABS  V6.16B, V31.16B
    SRSHR V26.2D, V12.2D, #4
    SQSHL  V8.2S, V21.2S, #0x13
    SQSUB  V25.4H, V26.4H, V26.4H
    SQSHL  V26.4S, V8.4S, #0x2
    SMLSL V23.4S, V26.4H, V6.H[0x2]
    SSHR V10.2D, V27.2D, #55
    SADDLV  S11, V23.8H
    SQDMLSL2 V27.2D, V10.4S, V10.S[0x0]
    SQRSHRN V19.2S, V25.2D, #25
    SMLSL V6.4S, V11.4H, V1.H[0x1]
    SQDMLSL V31.2D, V25.2S, V27.S[0x1]
    SMLAL2 V27.2D, V19.4S, V19.S[0x0]
    SQSHRN V18.2S, V31.2D, #16
    SRSHR  V24.2S, V6.2S, #32
    SQRDMULH H31, H0, V12.H[0x6]
    SQRSHRN2 V6.16B, V24.8H, #1
    SQRDMULH  V24.4S, V27.4S, V22.S[0x3]
    SQRSHRN2 V8.16B, V24.8H, #4
    SQSHRUN2 V17.16B, V18.8H, #5
    SQDMULL  V19.2D, V6.2S, V31.2S
    SSHLL2 V1.2D, V19.4S, #0x8
    SQRSHL  V27.8H, V1.8H, V1.8H
    SADDW  V0.2D, V27.2D, V3.2S
    SMULL V18.4S, V8.4H, V1.H[0x0]
    SQSHLU  V28.2S, V17.2S, #0x10
    SADDL  V23.2D, V15.2S, V28.2S
    SQRSHRN V25.4H, V18.4S, #7
    SHADD  V17.2S, V0.2S, V12.2S
    SSUBL  V21.4S, V17.4H, V17.4H
    SQDMLAL S19, H23, V12.H[0x1]
    SQSHRN V27.2S, V19.2D, #17
    SXTL2 V11.8H, V25.16B
    SABAL  V1.4S, V27.4H, V27.4H
    SQRDMULH S22, S1, V18.S[0x2]
    SQDMLSL  V26.2D, V21.2S, V22.2S
    SQSHRUN2 V24.16B, V11.8H, #3
    SABA  V27.4S, V20.4S, V26.4S
    SRSHR  V15.2S, V27.2S, #16
    SXTL V6.2D, V24.2S
    SSHLL V24.2D, V15.2S, #0x1d
    SXTL2 V0.4S, V24.8H
    SXTL V8.8H, V0.8B
    SMULL  V3.4S, V8.4H, V6.4H
    SSRA  V24.4H, V8.4H, #12
    SQRDMULH H15, H24, V9.H[0x2]
    SHADD  V18.4S, V7.4S, V18.4S
    SQDMLSL2 V9.2D, V3.4S, V10.S[0x2]
    SMOV W28, V25.B[0x5]
    SSHL  V12.2D, V0.2D, V11.2D
    SQDMULL2 V31.2D, V4.4S, V21.S[0x1]
    SQSHRN2 V22.4S, V1.2D, #22
    SQDMLAL D1, S5, V11.S[0x3]
    SSHL  V4.2S, V17.2S, V17.2S
    SQRSHRN2 V11.16B, V11.8H, #5
    SQDMULL2 V17.4S, V4.8H, V4.H[0x1]
    SQRDMULH  V3.2S, V17.2S, V9.S[0x2]
    SQRSHRUN V25.2S, V18.2D, #13
    SQABS  V21.2D, V3.2D
    SQRSHRUN2 V10.8H, V25.4S, #15
    SQRSHRN V0.8B, V31.8H, #7
    SQRDMULH H25, H6, V12.H[0x3]
    SQSHL  V4.8H, V10.8H, #0x1
    SABAL2  V7.8H, V21.16B, V22.16B
    SSUBL2  V5.2D, V1.4S, V7.4S
    SQSHRN V12.4H, V11.4S, #7
    SQRSHRUN V18.8B, V25.8H, #3
    SSHL  V31.8B, V0.8B, V5.8B
    SQDMULL S9, H18, V12.H[0x1]
    SQSHL  V12.4S, V15.4S, #0x18
    SSHR  V24.4H, V23.4H, #7
    SQDMLSL V15.2D, V22.2S, V24.S[0x2]
    SQDMULH  V10.4S, V4.4S, V4.S[0x0]
    SABAL  V7.2D, V31.2S, V15.2S
    SMLAL2  V23.8H, V7.16B, V7.16B
    SABA  V3.4S, V10.4S, V23.4S
    SQDMLSL S0, H12, V3.H[0x3]
    SQRDMULH  V17.8H, V0.8H, V9.H[0x2]
    SSRA  V23.8B, V21.8B, #4
    SQSHLU  V29.16B, V3.16B, #0x4
    SQRDMULH H24, H29, V4.H[0x7]
    SQABS  V29.4H, V23.4H
    SQRDMULH  V5.4S, V17.4S, V23.4S
    SQDMULH  V0.8H, V7.8H, V6.H[0x3]
    SABDL  V22.2D, V5.2S, V7.2S
    SQXTN2  V9.4S, V21.2D
    SMULL2 V31.2D, V26.4S, V22.S[0x0]
    SQDMLSL V17.4S, V25.4H, V15.H[0x0]
    SMLAL  V25.4S, V14.4H, V24.4H
    SMLSL V21.2D, V24.2S, V5.S[0x1]
    SQSHL  V3.8H, V2.8H, #0x9
    SQDMULL  V15.4S, V15.4H, V5.4H
    SSHL  V5.16B, V17.16B, V9.16B
    SQSHL  V18.8B, V29.8B, #0x6
    SQSHRUN V29.4H, V3.4S, #14
    SXTL V9.2D, V29.2S
    SQXTUN2  V24.8H, V9.4S
    SSUBL  V17.2D, V24.2S, V31.2S
    SABAL2  V2.2D, V15.4S, V5.4S
    SSHLL V6.2D, V17.2S, #0x1
    SQDMULH  V23.8H, V15.8H, V1.H[0x3]
    SQSHL V14.2D, V0.2D, #0x19
    SQDMLSL V7.2D, V6.2S, V21.S[0x3]
    SSHLL V24.8H, V2.8B, #0x7
    SMLAL V31.4S, V7.4H, V14.H[0x1]
    SQSHLU  V6.16B, V31.16B, #0x5
    SQRSHRUN V1.2S, V18.2D, #22
    SQDMLAL S31, H24, V6.H[0x7]
    SMULL V14.2D, V31.2S, V23.S[0x3]
    SQRSHL  V31.8H, V14.8H, V14.8H
    SQXTN  V14.2S, V31.2D
    SQSHL  V21.4H, V14.4H, #0x7
    SRSHL  V29.8H, V1.8H, V1.8H
    SQDMLAL D5, S21, V29.S[0x2]
    SQRSHRN2 V2.16B, V25.8H, #6
    SQRSHL  V7.4H, V5.4H, V5.4H
    SQRSHRN2 V31.16B, V2.8H, #8
    SQSHRUN V14.4H, V7.4S, #12
    SRSHR V7.2D, V31.2D, #28
    SQRSHRUN2 V0.4S, V26.2D, #25
    SQSHLU  V31.16B, V7.16B, #0x3
    SQDMULH S1, S14, V14.S[0x3]
    SQDMULH  V14.8H, V31.8H, V1.H[0x0]
    SXTL V21.2D, V0.2S
    SRSRA  V26.8H, V14.8H, #2
    SRSRA  V0.4S, V29.4S, #11
    SQABS  V29.4H, V21.4H
    SQSHL V7.2D, V29.2D, #0x8
    SQSHRN V14.4H, V7.4S, #11
    SXTL V25.2D, V14.2S
    SQXTN  V2.8B, V25.8H
    SQSHLU  V7.8B, V26.8B, #0x6
    SQDMULL S14, H7, V7.H[0x5]
    SSRA  V21.4S, V2.4S, #15
    SQDMULL2  V2.4S, V14.8H, V21.8H
    SQRSHRN2 V5.16B, V22.8H, #2
    SSUBL  V29.2D, V18.2S, V0.2S
    SQABS  V21.4S, V5.4S
    SABDL  V31.4S, V8.4H, V5.4H
    SQDMULL D8, S31, V2.S[0x2]
    SMLAL  V26.4S, V29.4H, V3.4H
    SQDMULH  V25.4S, V8.4S, V21.S[0x3]
    SSHR V1.2D, V25.2D, #59
    SABDL  V25.8H, V1.8B, V1.8B
    SSHLL2 V7.4S, V25.8H, #0x1
    SMLAL2  V22.8H, V7.16B, V7.16B
    SMULL  V5.4S, V22.4H, V22.4H
    SQDMLAL D29, S15, V18.S[0x2]
    SADDW2  V0.4S, V13.4S, V5.8H
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_8
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x800, LSL #16
    MRS  X25, FPSR
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X25, V0.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X25, D0
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D5
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X25, V13.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X25, D13
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x7f, LSL #0
    FMOV  X25, D18
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X25, V20.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X25, D20
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D24
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x1, LSL #0
    MOVK  X19, #0x1, LSL #32
    FMOV  X25, V27.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x1, LSL #0
    MOVK  X19, #0x1, LSL #32
    FMOV  X25, D27
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x7f, LSL #0
    FMOV  X25, D29
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X25, V30.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    FMOV  X25, D30
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X20, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0xfdc6, LSL #0
    MOVK  X3, #0xb508, LSL #16
    MOVK  X3, #0xf90b, LSL #32
    MOVK  X3, #0x74a5, LSL #48
    MOVZ  X4, #0x7576, LSL #0
    MOVK  X4, #0xfd36, LSL #16
    MOVK  X4, #0xb9c1, LSL #32
    MOVK  X4, #0x5544, LSL #48
    MOVZ  X5, #0x9f05, LSL #0
    MOVK  X5, #0x69b0, LSL #16
    MOVK  X5, #0x4598, LSL #32
    MOVK  X5, #0x9ebd, LSL #48
    MOVZ  X6, #0xb50c, LSL #0
    MOVK  X6, #0x4b65, LSL #16
    MOVK  X6, #0x274c, LSL #32
    MOVK  X6, #0x23af, LSL #48
    MOVZ  X7, #0x4879, LSL #0
    MOVK  X7, #0x3d7e, LSL #16
    MOVK  X7, #0xe1aa, LSL #32
    MOVK  X7, #0x332f, LSL #48
    MOVZ  X10, #0x9bb3, LSL #0
    MOVK  X10, #0x2571, LSL #16
    MOVK  X10, #0x27de, LSL #32
    MOVK  X10, #0x699f, LSL #48
    MOVZ  X11, #0x8f33, LSL #0
    MOVK  X11, #0x5064, LSL #16
    MOVK  X11, #0x3c02, LSL #32
    MOVK  X11, #0x74d2, LSL #48
    MOVZ  X12, #0x1f0, LSL #0
    MOVK  X12, #0x659d, LSL #16
    MOVK  X12, #0xb411, LSL #32
    MOVK  X12, #0x5d76, LSL #48
    MOVZ  X13, #0x8a18, LSL #0
    MOVK  X13, #0xcd79, LSL #16
    MOVK  X13, #0x322c, LSL #32
    MOVK  X13, #0x11cd, LSL #48
    MOVZ  X14, #0x3be5, LSL #0
    MOVK  X14, #0x1316, LSL #16
    MOVK  X14, #0xffd4, LSL #32
    MOVK  X14, #0x228a, LSL #48
    MOVZ  X15, #0x40be, LSL #0
    MOVK  X15, #0x7fcd, LSL #16
    MOVK  X15, #0xc172, LSL #32
    MOVK  X15, #0x3efb, LSL #48
    MOVZ  X16, #0xe964, LSL #0
    MOVK  X16, #0x75e, LSL #16
    MOVK  X16, #0x10fd, LSL #32
    MOVK  X16, #0x3741, LSL #48
    MOVZ  X17, #0x3ed2, LSL #0
    MOVK  X17, #0xa03a, LSL #16
    MOVK  X17, #0x46a5, LSL #32
    MOVK  X17, #0x36fb, LSL #48
    MOVZ  X18, #0xeade, LSL #0
    MOVK  X18, #0x44cc, LSL #16
    MOVK  X18, #0x737f, LSL #32
    MOVK  X18, #0xd84a, LSL #48
    MOVZ  X19, #0xf7d4, LSL #0
    MOVK  X19, #0x1aae, LSL #16
    MOVK  X19, #0xd965, LSL #32
    MOVK  X19, #0x3a9b, LSL #48
    MOVZ  X20, #0x9397, LSL #0
    MOVK  X20, #0x1f2d, LSL #16
    MOVK  X20, #0x674e, LSL #32
    MOVK  X20, #0xda6e, LSL #48
    MOVZ  X21, #0x713, LSL #0
    MOVK  X21, #0x35e0, LSL #16
    MOVK  X21, #0x192e, LSL #32
    MOVK  X21, #0xe13, LSL #48
    MOVZ  X22, #0x1de2, LSL #0
    MOVK  X22, #0xab55, LSL #16
    MOVK  X22, #0xa881, LSL #32
    MOVK  X22, #0x8989, LSL #48
    MOVZ  X23, #0x4a8, LSL #0
    MOVK  X23, #0x4557, LSL #16
    MOVK  X23, #0x453f, LSL #32
    MOVK  X23, #0x4b61, LSL #48
    MOVZ  X24, #0xf05c, LSL #0
    MOVK  X24, #0x6513, LSL #16
    MOVK  X24, #0xae1b, LSL #32
    MOVK  X24, #0x68f, LSL #48
    MOVZ  X25, #0xadf7, LSL #0
    MOVK  X25, #0x29dd, LSL #16
    MOVK  X25, #0x9b4c, LSL #32
    MOVK  X25, #0xa31, LSL #48
    MOVZ  X26, #0x60ef, LSL #0
    MOVK  X26, #0xb5fe, LSL #16
    MOVK  X26, #0xaecb, LSL #32
    MOVK  X26, #0xc127, LSL #48
    MOVZ  X28, #0x722, LSL #0
    MOVK  X28, #0xa52b, LSL #16
    MOVK  X28, #0x6357, LSL #32
    MOVK  X28, #0x2704, LSL #48
    MOVZ  X29, #0xc3e9, LSL #0
    MOVK  X29, #0x6826, LSL #16
    MOVK  X29, #0x6085, LSL #32
    MOVK  X29, #0x5da6, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X11
    FMOV  V3.D[1], X28
    FMOV  D4, X18
    FMOV  V4.D[1], X18
    FMOV  D5, X25
    FMOV  V5.D[1], X29
    FMOV  D6, X3
    FMOV  V6.D[1], X16
    FMOV  D7, X17
    FMOV  V7.D[1], X25
    FMOV  D8, X14
    FMOV  V8.D[1], X25
    FMOV  D9, X13
    FMOV  V9.D[1], X14
    FMOV  D10, X12
    FMOV  V10.D[1], X3
    FMOV  D11, X5
    FMOV  V11.D[1], X18
    FMOV  D12, X5
    FMOV  V12.D[1], X20
    FMOV  D13, X20
    FMOV  V13.D[1], X28
    FMOV  D14, X29
    FMOV  V14.D[1], X10
    FMOV  D15, X7
    FMOV  V15.D[1], X28
    FMOV  D16, X15
    FMOV  V16.D[1], X24
    FMOV  D17, X18
    FMOV  V17.D[1], X13
    FMOV  D18, X4
    FMOV  V18.D[1], X4
    FMOV  D19, X20
    FMOV  V19.D[1], X29
    FMOV  D20, X13
    FMOV  V20.D[1], X3
    FMOV  D21, X23
    FMOV  V21.D[1], X29
    FMOV  D22, X20
    FMOV  V22.D[1], X17
    FMOV  D23, X28
    FMOV  V23.D[1], X17
    FMOV  D24, X28
    FMOV  V24.D[1], X20
    FMOV  D25, X28
    FMOV  V25.D[1], X4
    FMOV  D26, X11
    FMOV  V26.D[1], X21
    FMOV  D27, X16
    FMOV  V27.D[1], X23
    FMOV  D28, X4
    FMOV  V28.D[1], X17
    FMOV  D29, X12
    FMOV  V29.D[1], X29
    FMOV  D30, X16
    FMOV  V30.D[1], X3
    FMOV  D31, X29
    FMOV  V31.D[1], X20
    MOVZ  X18, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_9:
    SMLAL2 V28.4S, V25.8H, V0.H[0x2]
    SMLSL V20.4S, V30.4H, V9.H[0x3]
    SABDL  V13.2D, V24.2S, V29.2S
    SQSHRUN V27.4H, V26.4S, #12
    SQRSHRN V9.8B, V31.8H, #7
    SSHLL V0.8H, V13.8B, #0x3
    SSRA  V21.8H, V28.8H, #7
    SSHLL2 V21.4S, V22.8H, #0x4
    SQSHLU V27.2D, V20.2D, #0x35
    SQRSHL  V11.4S, V21.4S, V23.4S
    SQDMULL2 V20.4S, V9.8H, V9.H[0x0]
    SSHL  V9.8H, V27.8H, V20.8H
    SMOV W3, V0.B[0xe]
    SQSHRN V30.4H, V11.4S, #2
    SMLAL  V1.2D, V9.2S, V0.2S
    SQDMLAL V13.2D, V30.2S, V30.S[0x3]
    SQSHL  V25.8B, V1.8B, #0x5
    SQDMULH  V21.2S, V13.2S, V13.S[0x0]
    SQABS  V28.4H, V21.4H
    SQDMLAL2 V1.2D, V25.4S, V25.S[0x3]
    SRSHR  V23.8B, V28.8B, #1
    SQDMULH  V31.4S, V1.4S, V1.S[0x0]
    SADDW  V0.4S, V23.4S, V23.4H
    SQRDMULH H26, H31, V0.H[0x3]
    SSRA  V1.8B, V25.8B, #2
    SMOV W10, V26.B[0xa]
    SSHR V28.2D, V3.2D, #41
    SQRSHRN2 V9.16B, V29.8H, #1
    SMULL2 V26.2D, V25.4S, V21.S[0x3]
    SABAL  V31.2D, V18.2S, V2.2S
    SMLSL V25.4S, V24.4H, V13.H[0x5]
    SMULL V22.4S, V25.4H, V11.H[0x4]
    SMLAL  V29.2D, V23.2S, V1.2S
    SMLSL2 V27.2D, V18.4S, V28.S[0x2]
    SRSHR  V20.4S, V25.4S, #27
    SMOV  X21, V22.S[0x0]
    SQDMULH  V3.8H, V4.8H, V13.8H
    SADDLV  S24, V10.8H
    SADDLV  H30, V11.8B
    SMOV  X15, V14.S[0x2]
    SRSHR V22.2D, V3.2D, #8
    SSRA V10.2D, V20.2D, #37
    SADALP  V20.8H, V27.16B
    SMLSL V3.4S, V31.4H, V5.H[0x5]
    SQSHLU V21.2D, V10.2D, #0xf
    SSRA V0.2D, V30.2D, #13
    SSHR  V2.4H, V21.4H, #16
    SXTL2 V14.4S, V24.8H
    SQSHRUN2 V21.16B, V9.8H, #5
    SQSHL  V18.16B, V22.16B, #0x0
    SMLAL2 V9.4S, V2.8H, V13.H[0x1]
    SQXTUN  V24.2S, V3.2D
    SMOV W6, V26.H[0x6]
    SMLSL  V23.4S, V24.4H, V21.4H
    SABAL  V25.2D, V0.2S, V23.2S
    SRSHR  V11.8B, V20.8B, #6
    SSHLL V4.2D, V11.2S, #0x15
    SQDMULH S28, S18, V29.S[0x2]
    SQRDMULH S11, S24, V25.S[0x2]
    SQDMLAL2 V26.4S, V11.8H, V14.H[0x0]
    SADDW  V22.4S, V4.4S, V9.4H
    SQRSHRUN V30.8B, V28.8H, #5
    SSHR  V1.8H, V26.8H, #11
    SMLAL2 V25.4S, V1.8H, V1.H[0x6]
    SQDMLAL2  V0.4S, V30.8H, V25.8H
    SXTL2 V20.8H, V22.16B
    SQRSHRN V31.8B, V20.8H, #2
    SMLSL2  V22.8H, V31.16B, V12.16B
    SQDMLAL2 V12.4S, V22.8H, V0.H[0x7]
    SQDMLAL V1.2D, V5.2S, V29.S[0x3]
    SQRSHRN2 V29.8H, V29.4S, #9
    SMLSL V26.2D, V17.2S, V21.S[0x3]
    SQXTN  V22.2S, V10.2D
    SSHLL V10.2D, V18.2S, #0x7
    SMOV W20, V19.B[0xd]
    SADDLV  D19, V30.4S
    SMLSL2  V5.2D, V17.4S, V11.4S
    SMLAL2 V25.4S, V24.8H, V6.H[0x6]
    SQDMLSL V11.4S, V26.4H, V1.H[0x0]
    SQSHL  V26.16B, V5.16B, #0x5
    SQRSHRN2 V0.16B, V2.8H, #7
    SQSHRN2 V28.16B, V30.8H, #8
    SQDMLSL2 V21.4S, V11.8H, V0.H[0x2]
    SSUBL2  V30.2D, V21.4S, V25.4S
    SSHLL V6.8H, V22.8B, #0x6
    SQDMLSL  V2.4S, V29.4H, V26.4H
    SQDMULL2 V20.4S, V30.8H, V10.H[0x2]
    SADDLV  S22, V12.8H
    SQDMLSL V4.2D, V20.2S, V19.S[0x0]
    SQDMULH  V11.4H, V2.4H, V28.4H
    SRSHL  V17.8B, V6.8B, V11.8B
    SMULL V21.2D, V4.2S, V17.S[0x3]
    SSHL  V5.8B, V21.8B, V21.8B
    SQSHRN V0.8B, V22.8H, #1
    SSUBL2  V20.8H, V5.16B, V0.16B
    SQRSHRUN V18.4H, V30.4S, #16
    SMLAL2 V22.4S, V3.8H, V12.H[0x0]
    SQDMLSL S1, H2, V15.H[0x6]
    SXTL V26.2D, V29.2S
    SMLAL  V19.4S, V25.4H, V4.4H
    SABAL  V5.8H, V9.8B, V18.8B
    SQDMULL2 V29.2D, V1.4S, V24.S[0x0]
    SSHR  V4.16B, V23.16B, #5
    SQSHRN V25.2S, V8.2D, #23
    SQRSHRN2 V3.16B, V22.8H, #8
    SQDMULH  V8.4S, V3.4S, V0.S[0x3]
    SABAL  V11.2D, V19.2S, V0.2S
    SQRDMULH H3, H14, V13.H[0x0]
    SADDLV  S10, V3.4H
    SADDL2  V30.4S, V25.8H, V8.8H
    SQRSHRUN V28.2S, V4.2D, #1
    SQDMLSL2 V22.2D, V29.4S, V11.S[0x1]
    SMULL2 V23.2D, V22.4S, V22.S[0x2]
    SMLAL V24.2D, V26.2S, V5.S[0x1]
    SQDMLSL2 V12.2D, V10.4S, V20.S[0x3]
    SSRA V14.2D, V23.2D, #43
    SQDMULL S21, H30, V9.H[0x3]
    SSUBW  V13.4S, V12.4S, V12.4H
    SSHR  V10.8H, V13.8H, #12
    SQDMULH  V4.8H, V28.8H, V14.H[0x6]
    SSRA  V14.16B, V4.16B, #7
    SQXTN2  V15.16B, V14.8H
    SQDMULL V25.4S, V13.4H, V15.H[0x7]
    SSHR  V12.2S, V25.2S, #17
    SQDMLAL  V3.2D, V12.2S, V21.2S
    SMLAL V0.4S, V10.4H, V3.H[0x1]
    SXTL V28.4S, V0.4H
    SQABS  V20.8B, V24.8B
    SQDMULL S15, H28, V7.H[0x5]
    SSUBW2  V21.4S, V20.4S, V15.8H
    SMLAL2 V4.4S, V3.8H, V15.H[0x4]
    SXTL V14.4S, V14.4H
    SQDMULL S13, H27, V3.H[0x3]
    SQRSHRUN V8.4H, V6.4S, #5
    SQDMLAL D0, S1, V12.S[0x1]
    SQDMLAL S9, H29, V13.H[0x7]
    SQDMLSL2 V1.4S, V17.8H, V7.H[0x1]
    SQRSHRUN2 V6.16B, V16.8H, #1
    SRSHR  V20.4H, V25.4H, #6
    SQRSHL  V28.4H, V21.4H, V20.4H
    SQRDMULH  V10.2S, V4.2S, V0.S[0x2]
    SMLSL2 V0.4S, V16.8H, V0.H[0x1]
    SSHR  V25.4H, V0.4H, #4
    SQRDMULH  V13.4S, V10.4S, V8.4S
    SQRDMULH  V0.4S, V28.4S, V9.S[0x3]
    SQRSHRUN V28.4H, V1.4S, #10
    SMLSL2  V1.8H, V14.16B, V13.16B
    SQABS  V24.2D, V1.2D
    SSRA  V29.8H, V6.8H, #4
    SADDL2  V15.4S, V29.8H, V29.8H
    SMLAL2 V21.4S, V15.8H, V7.H[0x1]
    SSHLL V10.4S, V29.4H, #0x8
    SRSHR  V3.8B, V24.8B, #5
    SQDMLSL V17.2D, V25.2S, V28.S[0x1]
    SMULL V28.4S, V14.4H, V2.H[0x3]
    SQABS  V9.4S, V12.4S
    SADDLV  S20, V21.8H
    SQRSHRUN2 V29.4S, V10.2D, #17
    SSUBL2  V8.8H, V29.16B, V29.16B
    SQSHRN V6.8B, V8.8H, #5
    SSUBW  V10.2D, V17.2D, V28.2S
    SQDMULH S4, S3, V3.S[0x0]
    SQSHRN2 V3.16B, V0.8H, #2
    SQDMULH H25, H6, V9.H[0x2]
    SSUBW  V16.8H, V10.8H, V25.8B
    SQDMLSL S0, H16, V3.H[0x0]
    SQXTN  V16.4H, V20.4S
    SXTL V28.2D, V16.2S
    SHADD  V17.16B, V28.16B, V28.16B
    SQDMULH  V28.4S, V0.4S, V17.S[0x3]
    SADDLV  H9, V4.8B
    SQDMLAL  V20.2D, V28.2S, V28.2S
    SADALP  V2.1D, V13.2S
    SQRDMULH  V3.2S, V9.2S, V9.2S
    SQSHLU  V4.16B, V20.16B, #0x7
    SQDMULL V17.2D, V3.2S, V3.S[0x3]
    SRHADD  V15.8H, V2.8H, V4.8H
    SSUBL2  V6.4S, V15.8H, V15.8H
    SMOV W14, V17.H[0x7]
    SRSHL  V28.8B, V30.8B, V31.8B
    SRSRA  V0.2S, V26.2S, #22
    SQSHRN V16.2S, V22.2D, #21
    SQRSHRN V26.2S, V11.2D, #10
    SQRSHRUN2 V12.16B, V29.8H, #3
    SRSHR V25.2D, V6.2D, #22
    SQDMLAL V6.4S, V6.4H, V10.H[0x5]
    SQRSHRN2 V29.4S, V30.2D, #10
    SMULL2 V10.2D, V12.4S, V5.S[0x0]
    SQSHLU V12.2D, V3.2D, #0x35
    SQSHRN V31.8B, V0.8H, #5
    SQSHRUN V22.8B, V12.8H, #6
    SRSHR V17.2D, V10.2D, #29
    SABA  V13.2S, V28.2S, V26.2S
    SSHLL V26.8H, V25.8B, #0x6
    SQNEG  V15.4S, V31.4S
    SSHLL2 V2.2D, V29.4S, #0x19
    SSHR  V25.4S, V17.4S, #25
    SQDMLAL2 V17.4S, V6.8H, V3.H[0x5]
    SMULL2 V11.2D, V22.4S, V16.S[0x0]
    SADDLV  H30, V25.8B
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_9
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x7576, LSL #0
    MOVK  X17, #0xfd36, LSL #16
    MOVK  X17, #0xb9c1, LSL #32
    MOVK  X17, #0x5544, LSL #48
    SUB  X29, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x9f05, LSL #0
    MOVK  X17, #0x69b0, LSL #16
    MOVK  X17, #0x4598, LSL #32
    MOVK  X17, #0x9ebd, LSL #48
    SUB  X29, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x4879, LSL #0
    MOVK  X17, #0x3d7e, LSL #16
    MOVK  X17, #0xe1aa, LSL #32
    MOVK  X17, #0x332f, LSL #48
    SUB  X29, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x8f33, LSL #0
    MOVK  X17, #0x5064, LSL #16
    MOVK  X17, #0x3c02, LSL #32
    MOVK  X17, #0x74d2, LSL #48
    SUB  X29, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x1f0, LSL #0
    MOVK  X17, #0x659d, LSL #16
    MOVK  X17, #0xb411, LSL #32
    MOVK  X17, #0x5d76, LSL #48
    SUB  X29, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x8a18, LSL #0
    MOVK  X17, #0xcd79, LSL #16
    MOVK  X17, #0x322c, LSL #32
    MOVK  X17, #0x11cd, LSL #48
    SUB  X29, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xe964, LSL #0
    MOVK  X17, #0x75e, LSL #16
    MOVK  X17, #0x10fd, LSL #32
    MOVK  X17, #0x3741, LSL #48
    SUB  X29, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xf7d4, LSL #0
    MOVK  X17, #0x1aae, LSL #16
    MOVK  X17, #0xd965, LSL #32
    MOVK  X17, #0x3a9b, LSL #48
    SUB  X29, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x4a8, LSL #0
    MOVK  X17, #0x4557, LSL #16
    MOVK  X17, #0x453f, LSL #32
    MOVK  X17, #0x4b61, LSL #48
    SUB  X29, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xf05c, LSL #0
    MOVK  X17, #0x6513, LSL #16
    MOVK  X17, #0xae1b, LSL #32
    MOVK  X17, #0x68f, LSL #48
    SUB  X29, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xadf7, LSL #0
    MOVK  X17, #0x29dd, LSL #16
    MOVK  X17, #0x9b4c, LSL #32
    MOVK  X17, #0xa31, LSL #48
    SUB  X29, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x60ef, LSL #0
    MOVK  X17, #0xb5fe, LSL #16
    MOVK  X17, #0xaecb, LSL #32
    MOVK  X17, #0xc127, LSL #48
    SUB  X29, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x722, LSL #0
    MOVK  X17, #0xa52b, LSL #16
    MOVK  X17, #0x6357, LSL #32
    MOVK  X17, #0x2704, LSL #48
    SUB  X29, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x800, LSL #16
    MRS  X29, FPSR
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xfedf, LSL #0
    MOVK  X17, #0xffff, LSL #16
    FMOV  X29, D0
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D1
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D2
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D3
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x80, LSL #16
    FMOV  X29, D4
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x2, LSL #0
    MOVK  X17, #0x1, LSL #16
    MOVK  X17, #0x1, LSL #32
    MOVK  X17, #0x1, LSL #48
    FMOV  X29, V5.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x1, LSL #0
    MOVK  X17, #0x1, LSL #16
    MOVK  X17, #0x1, LSL #32
    MOVK  X17, #0x1, LSL #48
    FMOV  X29, D5
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D6
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xadf7, LSL #0
    MOVK  X17, #0x29dd, LSL #16
    MOVK  X17, #0x9b4c, LSL #32
    MOVK  X17, #0xa31, LSL #48
    FMOV  X29, V7.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x3ed2, LSL #0
    MOVK  X17, #0xa03a, LSL #16
    MOVK  X17, #0x46a5, LSL #32
    MOVK  X17, #0x36fb, LSL #48
    FMOV  X29, D7
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D8
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D9
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4000, LSL #16
    MOVK  X17, #0x4000, LSL #32
    FMOV  X29, D10
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D11
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D12
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D13
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D14
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xa, LSL #0
    MOVK  X17, #0xffff, LSL #16
    FMOV  X29, D15
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D16
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x2, LSL #0
    MOVK  X17, #0x2, LSL #16
    FMOV  X29, D17
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x1, LSL #32
    FMOV  X29, D18
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D19
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x303, LSL #0
    MOVK  X17, #0x1, LSL #16
    FMOV  X29, D20
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x4b45, LSL #0
    MOVK  X17, #0x6d71, LSL #16
    MOVK  X17, #0x494c, LSL #32
    MOVK  X17, #0x101, LSL #48
    FMOV  X29, D21
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D22
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D23
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D24
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D25
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D26
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    FMOV  X29, D27
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D28
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xfffc, LSL #0
    MOVK  X17, #0xfffc, LSL #16
    MOVK  X17, #0xfffc, LSL #32
    MOVK  X17, #0x1fc, LSL #48
    FMOV  X29, D29
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, D30
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X17, #0xfff6, LSL #0
    FMOV  X29, D31
    SUB  X22, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X20
    FMOV  V0.D[1], X29
    FMOV  D1, X11
    FMOV  V1.D[1], X26
    FMOV  D2, X23
    FMOV  V2.D[1], X17
    FMOV  D3, X25
    FMOV  V3.D[1], X28
    FMOV  D4, X22
    FMOV  V4.D[1], X21
    FMOV  D5, X19
    FMOV  V5.D[1], X24
    FMOV  D6, X23
    FMOV  V6.D[1], X13
    FMOV  D7, X18
    FMOV  V7.D[1], X23
    FMOV  D8, X16
    FMOV  V8.D[1], X4
    FMOV  D9, X29
    FMOV  V9.D[1], X20
    FMOV  D10, X20
    FMOV  V10.D[1], X23
    FMOV  D11, X10
    FMOV  V11.D[1], X3
    FMOV  D12, X23
    FMOV  V12.D[1], X11
    FMOV  D13, X20
    FMOV  V13.D[1], X12
    FMOV  D14, X15
    FMOV  V14.D[1], X13
    FMOV  D15, X24
    FMOV  V15.D[1], X22
    FMOV  D16, X16
    FMOV  V16.D[1], X28
    FMOV  D17, X18
    FMOV  V17.D[1], X21
    FMOV  D18, X4
    FMOV  V18.D[1], X12
    FMOV  D19, X26
    FMOV  V19.D[1], X12
    FMOV  D20, X19
    FMOV  V20.D[1], X3
    FMOV  D21, X10
    FMOV  V21.D[1], X21
    FMOV  D22, X7
    FMOV  V22.D[1], X16
    FMOV  D23, X7
    FMOV  V23.D[1], X28
    FMOV  D24, X14
    FMOV  V24.D[1], X15
    FMOV  D25, X24
    FMOV  V25.D[1], X18
    FMOV  D26, X3
    FMOV  V26.D[1], X20
    FMOV  D27, X10
    FMOV  V27.D[1], X28
    FMOV  D28, X17
    FMOV  V28.D[1], X7
    FMOV  D29, X4
    FMOV  V29.D[1], X15
    FMOV  D30, X5
    FMOV  V30.D[1], X4
    FMOV  D31, X23
    FMOV  V31.D[1], X23
    MOVZ  X20, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_10:
    SSHL  V20.4S, V25.4S, V31.4S
    SMOV  X26, V27.S[0x1]
    SQDMULH S9, S24, V30.S[0x2]
    SXTL2 V31.8H, V9.16B
    SMLSL2  V15.4S, V20.8H, V19.8H
    SSUBW  V19.2D, V29.2D, V26.2S
    SQDMLAL  V13.4S, V28.4H, V19.4H
    SHSUB  V6.4H, V31.4H, V31.4H
    SSHR  V21.4S, V13.4S, #23
    SQRSHL  V2.16B, V15.16B, V15.16B
    SQSHL V23.2D, V23.2D, #0xa
    SQDMULH  V4.4H, V23.4H, V23.4H
    SQSHRUN2 V7.16B, V2.8H, #5
    SSRA  V27.4H, V4.4H, #4
    SQRSHRN2 V25.16B, V27.8H, #1
    SQRSHL  V31.16B, V6.16B, V7.16B
    SRSHR  V30.4H, V31.4H, #7
    SQDMULL2 V19.2D, V30.4S, V21.S[0x3]
    SQDMULH S13, S19, V19.S[0x2]
    SQRSHRUN V21.8B, V25.8H, #1
    SQRDMULH  V15.4H, V13.4H, V13.4H
    SQDMLSL2  V4.4S, V15.8H, V21.8H
    SXTL V29.4S, V13.4H
    SSHR V23.2D, V23.2D, #26
    SSUBW  V7.2D, V24.2D, V10.2S
    SQSHRN2 V19.16B, V16.8H, #2
    SQXTN2  V27.4S, V1.2D
    SQADD  V31.16B, V21.16B, V6.16B
    SQDMLAL S2, H3, V10.H[0x5]
    SXTL V13.8H, V3.8B
    SMLSL V24.4S, V27.4H, V0.H[0x5]
    SMLAL V0.2D, V13.2S, V23.S[0x0]
    SMULL V30.2D, V31.2S, V4.S[0x1]
    SABAL2  V6.8H, V30.16B, V7.16B
    SSHLL V3.2D, V6.2S, #0x14
    SMULL V6.2D, V2.2S, V30.S[0x3]
    SQDMLAL  V10.4S, V29.4H, V19.4H
    SQDMULH S4, S24, V10.S[0x2]
    SSRA  V17.8H, V3.8H, #4
    SRHADD  V3.16B, V17.16B, V4.16B
    SQDMULH H1, H0, V0.H[0x2]
    SSUBL2  V16.2D, V1.4S, V3.4S
    SABAL  V25.8H, V6.8B, V6.8B
    SQDMLSL S31, H25, V12.H[0x6]
    SQDMULL V2.2D, V31.2S, V31.S[0x0]
    SQSUB  V31.2D, V2.2D, V2.2D
    SQRDMULH  V25.8H, V31.8H, V13.H[0x7]
    SMOV  X6, V16.H[0x5]
    SSHLL V15.8H, V26.8B, #0x3
    SMLSL V4.4S, V20.4H, V13.H[0x3]
    SQDMULL2 V1.2D, V7.4S, V23.S[0x3]
    SQDMULH  V29.8H, V7.8H, V1.H[0x5]
    SQDMLAL D24, S3, V12.S[0x2]
    SMLSL2 V31.2D, V12.4S, V3.S[0x2]
    SABAL2  V16.2D, V17.4S, V12.4S
    SQDMLAL V3.2D, V27.2S, V21.S[0x0]
    SMOV W7, V23.B[0x9]
    SMLAL  V20.8H, V9.8B, V11.8B
    SMULL V7.2D, V16.2S, V15.S[0x1]
    SQSHLU  V30.8B, V7.8B, #0x1
    SQSHLU  V7.4H, V25.4H, #0x8
    SRSRA V2.2D, V7.2D, #4
    SXTL2 V6.8H, V30.16B
    SABAL  V23.2D, V29.2S, V31.2S
    SQRDMULH  V16.4H, V20.4H, V8.H[0x7]
    SABDL2  V7.8H, V4.16B, V24.16B
    SSUBL  V13.2D, V7.2S, V16.2S
    SQSHL  V20.16B, V3.16B, #0x4
    SSHLL V0.4S, V20.4H, #0xa
    SXTL2 V9.2D, V0.4S
    SQSUB  V0.8B, V9.8B, V6.8B
    SABA  V3.8B, V23.8B, V13.8B
    SMOV  X23, V3.H[0x3]
    SQSHLU  V11.4H, V2.4H, #0x3
    SSUBL  V25.4S, V0.4H, V11.4H
    SMLAL2 V20.2D, V24.4S, V9.S[0x2]
    SQSHL  V24.4S, V29.4S, #0x10
    SMLSL V2.2D, V10.2S, V7.S[0x1]
    SXTL2 V30.8H, V11.16B
    SQDMLSL2  V31.4S, V15.8H, V5.8H
    SMLSL2 V8.2D, V7.4S, V10.S[0x2]
    SQSUB  V11.8H, V21.8H, V27.8H
    SMLSL V6.4S, V21.4H, V12.H[0x7]
    SSUBW  V15.8H, V31.8H, V0.8B
    SQDMLAL V10.4S, V25.4H, V2.H[0x2]
    SUQADD  V29.2D, V24.2D
    SQDMULL V16.4S, V30.4H, V9.H[0x3]
    SHADD  V5.4H, V16.4H, V15.4H
    SXTL V21.2D, V20.2S
    SQSHRN2 V7.16B, V5.8H, #6
    SQDMULH  V15.2S, V8.2S, V29.S[0x1]
    SADDL2  V27.8H, V11.16B, V15.16B
    SQSHRUN2 V20.16B, V27.8H, #4
    SQRDMULH  V2.4S, V7.4S, V6.S[0x3]
    SXTL2 V8.8H, V21.16B
    SXTL2 V0.8H, V20.16B
    SXTL V12.2D, V10.2S
    SQSHRN2 V10.4S, V2.2D, #27
    SQNEG  V27.4S, V8.4S
    SRSRA V13.2D, V12.2D, #53
    SQDMULH  V12.4H, V24.4H, V0.H[0x5]
    SQRSHRUN V20.8B, V31.8H, #2
    SQSHL  V29.4H, V10.4H, #0x4
    SQSHRUN V10.2S, V31.2D, #9
    SQRDMULH  V0.4S, V12.4S, V29.4S
    SSHLL2 V30.4S, V27.8H, #0x7
    SQDMLSL2  V25.2D, V18.4S, V11.4S
    SQDMULL2 V8.2D, V25.4S, V25.S[0x3]
    SSHR  V24.4S, V8.4S, #4
    SSHLL2 V5.4S, V24.8H, #0x3
    SSHLL V16.8H, V10.8B, #0x1
    SQSHRUN V9.8B, V13.8H, #2
    SSHR  V15.16B, V30.16B, #8
    SQSHL  V15.4S, V16.4S, #0x6
    SQDMULH  V11.8H, V0.8H, V5.H[0x4]
    SQDMULL V13.2D, V11.2S, V9.S[0x3]
    SQRSHRUN V18.8B, V15.8H, #5
    SSRA  V15.8B, V13.8B, #3
    SQDMLSL  V24.2D, V20.2S, V15.2S
    SHSUB  V16.2S, V24.2S, V18.2S
    SQDMLSL2 V25.2D, V9.4S, V28.S[0x1]
    SQSHRN V18.4H, V21.4S, #5
    SQDMULH S10, S27, V5.S[0x1]
    SQDMULL2 V29.2D, V11.4S, V3.S[0x2]
    SXTL2 V27.4S, V15.8H
    SQDMLSL S8, H12, V3.H[0x4]
    SXTL2 V21.4S, V12.8H
    SMULL V20.4S, V13.4H, V11.H[0x2]
    SQDMLAL2 V5.2D, V27.4S, V27.S[0x0]
    SSUBW2  V0.8H, V20.8H, V8.16B
    SXTL V30.4S, V16.4H
    SQDMULL V31.2D, V18.2S, V21.S[0x3]
    SQDMLAL2  V28.4S, V30.8H, V25.8H
    SQSHL  V13.16B, V28.16B, #0x7
    SQRSHRUN V2.8B, V10.8H, #7
    SMLSL2 V12.4S, V5.8H, V2.H[0x6]
    SSUBW2  V18.2D, V29.2D, V13.4S
    SSHR  V16.4S, V18.4S, #12
    SMULL V11.4S, V16.4H, V0.H[0x1]
    SQDMLAL V18.2D, V11.2S, V11.S[0x2]
    SQXTN2  V10.16B, V12.8H
    SQDMULH  V21.4S, V10.4S, V31.4S
    SSRA  V10.4S, V30.4S, #1
    SQDMLSL2 V28.2D, V10.4S, V21.S[0x2]
    SADALP  V31.4H, V2.8B
    SQSHL  V0.4H, V31.4H, V31.4H
    SMOV W12, V18.H[0x7]
    SQXTUN2  V25.16B, V0.8H
    SQSHL  V8.16B, V25.16B, #0x4
    SQRSHRN2 V31.16B, V8.8H, #4
    SQSHLU  V27.16B, V28.16B, #0x2
    SRSRA  V11.8H, V31.8H, #11
    SSUBL  V16.4S, V11.4H, V11.4H
    SQDMLAL2  V12.4S, V28.8H, V19.8H
    SQRDMULH  V21.8H, V27.8H, V12.H[0x4]
    SQRDMULH  V3.8H, V21.8H, V6.H[0x6]
    SQSHRUN V13.2S, V16.2D, #12
    SQSHL  V12.4S, V3.4S, #0x1d
    SQXTN2  V25.16B, V12.8H
    SQSHL  V30.4H, V25.4H, #0xd
    SADDLV  H10, V30.8B
    SQSHRUN2 V28.4S, V10.2D, #5
    SMULL2  V27.4S, V17.8H, V13.8H
    SRHADD  V12.8H, V28.8H, V28.8H
    SQRDMULH H5, H27, V12.H[0x0]
    SQRSHRUN2 V18.16B, V10.8H, #7
    SQDMULH  V11.2S, V31.2S, V17.2S
    SRSHR  V28.8H, V4.8H, #3
    SRSHR  V19.8H, V24.8H, #15
    SQRSHRN2 V12.4S, V24.2D, #18
    SQDMULL2  V24.4S, V9.8H, V25.8H
    SQRDMULH H13, H25, V5.H[0x0]
    SABDL  V5.8H, V27.8B, V18.8B
    SSHR  V4.4S, V9.4S, #21
    SXTL V18.2D, V18.2S
    SQRSHRUN2 V31.16B, V13.8H, #1
    SQRDMULH S17, S11, V11.S[0x0]
    SSUBL2  V10.8H, V24.16B, V5.16B
    SMLSL2  V25.4S, V28.8H, V31.8H
    SADDW2  V9.8H, V4.8H, V4.16B
    SRSHR  V11.16B, V19.16B, #5
    SQSUB  V24.4H, V16.4H, V18.4H
    SQABS  V5.16B, V10.16B
    SSRA  V31.4H, V17.4H, #5
    SQDMULL2 V16.4S, V11.8H, V9.H[0x5]
    SQSHLU V27.2D, V12.2D, #0xc
    SQRSHRN2 V13.8H, V27.4S, #8
    SXTL V28.2D, V13.2S
    SMLSL  V17.2D, V28.2S, V5.2S
    SQDMULL V4.2D, V25.2S, V24.S[0x0]
    SMULL2  V5.8H, V16.16B, V4.16B
    SUQADD  V19.4H, V31.4H
    SQDMULL  V12.2D, V23.2S, V17.2S
    SQRDMULH H0, H5, V12.H[0x3]
    SHSUB  V10.8H, V0.8H, V0.8H
    SMULL2 V18.4S, V10.8H, V10.H[0x4]
    SSHR  V0.8H, V18.8H, #1
    SMULL V13.2D, V0.2S, V19.S[0x1]
    SMLAL V4.2D, V7.2S, V13.S[0x2]
    SSHLL2 V21.8H, V12.16B, #0x1
    SUBS  X20, X20, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_10
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x800, LSL #16
    MRS  X29, FPSR
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D0
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D1
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D2
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D3
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D4
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D5
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D6
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D7
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D8
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D9
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D10
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D11
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D12
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D13
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D14
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D15
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D16
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D17
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D18
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D19
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D20
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D21
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D22
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D23
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D24
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D25
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D26
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D27
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D28
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D29
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D30
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D31
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSignedOperation_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X25
    FMOV  D1, X22
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X29
    FMOV  D3, X15
    FMOV  V3.D[1], X3
    FMOV  D4, X18
    FMOV  V4.D[1], X15
    FMOV  D5, X29
    FMOV  V5.D[1], X13
    FMOV  D6, X6
    FMOV  V6.D[1], X24
    FMOV  D7, X10
    FMOV  V7.D[1], X26
    FMOV  D8, X21
    FMOV  V8.D[1], X12
    FMOV  D9, X23
    FMOV  V9.D[1], X19
    FMOV  D10, X3
    FMOV  V10.D[1], X17
    FMOV  D11, X12
    FMOV  V11.D[1], X6
    FMOV  D12, X23
    FMOV  V12.D[1], X5
    FMOV  D13, X17
    FMOV  V13.D[1], X19
    FMOV  D14, X5
    FMOV  V14.D[1], X10
    FMOV  D15, X23
    FMOV  V15.D[1], X16
    FMOV  D16, X13
    FMOV  V16.D[1], X6
    FMOV  D17, X19
    FMOV  V17.D[1], X22
    FMOV  D18, X4
    FMOV  V18.D[1], X16
    FMOV  D19, X28
    FMOV  V19.D[1], X15
    FMOV  D20, X6
    FMOV  V20.D[1], X29
    FMOV  D21, X20
    FMOV  V21.D[1], X24
    FMOV  D22, X6
    FMOV  V22.D[1], X25
    FMOV  D23, X6
    FMOV  V23.D[1], X7
    FMOV  D24, X22
    FMOV  V24.D[1], X3
    FMOV  D25, X16
    FMOV  V25.D[1], X7
    FMOV  D26, X19
    FMOV  V26.D[1], X17
    FMOV  D27, X28
    FMOV  V27.D[1], X24
    FMOV  D28, X3
    FMOV  V28.D[1], X19
    FMOV  D29, X21
    FMOV  V29.D[1], X23
    FMOV  D30, X14
    FMOV  V30.D[1], X24
    FMOV  D31, X26
    FMOV  V31.D[1], X21
    MOVZ  X15, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_11:
    SQDMLAL S9, H20, V0.H[0x7]
    SQSHL V30.2D, V9.2D, #0x31
    SMLAL2 V7.4S, V30.8H, V0.H[0x7]
    SQDMULL V30.4S, V28.4H, V7.H[0x1]
    SQSHRN V23.4H, V31.4S, #4
    SQSHRN2 V9.16B, V26.8H, #7
    SHADD  V27.2S, V25.2S, V27.2S
    SABDL2  V0.4S, V9.8H, V30.8H
    SQDMULL D8, S0, V23.S[0x1]
    SADDLV  D1, V8.4S
    SQRDMULH S15, S29, V29.S[0x0]
    SQRSHRN V26.4H, V24.4S, #1
    SMLSL V30.4S, V26.4H, V1.H[0x6]
    SMLAL2 V14.2D, V30.4S, V30.S[0x2]
    SMLSL  V26.8H, V14.8B, V14.8B
    SADDLV  S28, V9.4H
    SQXTUN2  V9.4S, V27.2D
    SMULL2 V11.4S, V15.8H, V1.H[0x7]
    SQRSHRN V27.2S, V28.2D, #18
    SQDMLSL V1.2D, V9.2S, V11.S[0x3]
    SQNEG  V31.2S, V1.2S
    SQRSHRN2 V7.4S, V26.2D, #25
    SQSHL  V24.8H, V27.8H, V27.8H
    SQADD  V29.4H, V31.4H, V24.4H
    SQSHL V30.2D, V29.2D, #0x1b
    SQDMLAL2 V26.2D, V7.4S, V7.S[0x2]
    SQSHRUN V15.2S, V30.2D, #7
    SQDMULL V14.4S, V15.4H, V15.H[0x5]
    SRSHR  V28.2S, V26.2S, #16
    SMLSL2 V7.2D, V14.4S, V14.S[0x1]
    SQSHL  V14.8H, V28.8H, V7.8H
    SMLSL V11.4S, V17.4H, V12.H[0x1]
    SQSHRUN V30.4H, V17.4S, #7
    SSUBW2  V27.8H, V9.8H, V27.16B
    SQADD  V31.2S, V27.2S, V23.2S
    SMLSL V1.4S, V24.4H, V8.H[0x7]
    SQRSHRUN2 V29.4S, V1.2D, #20
    SMLSL V7.4S, V30.4H, V12.H[0x0]
    SQDMLSL S15, H29, V9.H[0x0]
    SHSUB  V9.4S, V5.4S, V17.4S
    SQDMLSL  V5.2D, V4.2S, V23.2S
    SADDLV  H1, V26.16B
    SQSHLU V27.2D, V15.2D, #0x13
    SQRSHRUN2 V26.4S, V7.2D, #3
    SQRSHRUN V7.2S, V28.2D, #5
    SQRSHRN2 V8.4S, V11.2D, #30
    SXTL2 V24.2D, V14.4S
    SMLAL V28.4S, V9.4H, V9.H[0x3]
    SSHR  V28.8H, V27.8H, #2
    SSRA  V23.8B, V28.8B, #5
    SMULL2 V26.4S, V13.8H, V8.H[0x3]
    SQXTN  V11.4H, V1.4S
    SQRSHRN V1.2S, V31.2D, #2
    SQRSHRUN V15.8B, V1.8H, #6
    SQDMLSL S12, H7, V5.H[0x0]
    SRHADD  V17.4H, V12.4H, V26.4H
    SQSHL  V14.8H, V23.8H, #0x8
    SMOV W17, V24.B[0x2]
    SQSHL V9.2D, V17.2D, #0x30
    SABD  V5.16B, V15.16B, V14.16B
    SQSHLU V17.2D, V9.2D, #0x3d
    SQDMLAL2 V9.2D, V17.4S, V11.S[0x0]
    SSUBL2  V11.4S, V9.8H, V22.8H
    SQRDMULH H27, H5, V11.H[0x5]
    SQDMLAL  V31.2D, V21.2S, V28.2S
    SQRSHRUN V30.2S, V22.2D, #26
    SADDW  V24.8H, V18.8H, V14.8B
    SQSHRUN V29.2S, V2.2D, #6
    SQDMLSL  V7.4S, V6.4H, V5.4H
    SMOV  X11, V18.H[0x5]
    SQRDMULH  V1.8H, V27.8H, V7.H[0x1]
    SRSHR V2.2D, V14.2D, #3
    SMLAL2 V6.2D, V31.4S, V28.S[0x2]
    SQSHRN2 V9.4S, V6.2D, #32
    SQDMLAL D15, S19, V4.S[0x0]
    SRHADD  V14.4H, V4.4H, V27.4H
    SABDL2  V6.2D, V25.4S, V25.4S
    SMLSL V25.2D, V30.2S, V15.S[0x2]
    SQSHRUN2 V30.16B, V24.8H, #4
    SQSHRUN V5.8B, V9.8H, #2
    SABD  V18.4S, V14.4S, V25.4S
    SQSHRN2 V27.8H, V6.4S, #13
    SQDMULH  V15.4H, V2.4H, V2.H[0x2]
    SMLAL V2.2D, V30.2S, V29.S[0x3]
    SQDMLSL  V19.2D, V1.2S, V18.2S
    SSRA  V22.2S, V5.2S, #29
    SQSHL  V6.8B, V22.8B, #0x4
    SSHLL V5.8H, V6.8B, #0x1
    SHSUB  V31.8H, V19.8H, V5.8H
    SQDMLAL  V29.2D, V2.2S, V31.2S
    SQSHRN V18.4H, V29.4S, #4
    SQDMLSL2 V4.2D, V27.4S, V27.S[0x1]
    SSUBL  V27.8H, V19.8B, V18.8B
    SQRSHRN2 V24.4S, V2.2D, #22
    SQRDMULH S29, S4, V24.S[0x1]
    SQRSHRUN2 V9.16B, V29.8H, #4
    SSUBL  V1.4S, V15.4H, V27.4H
    SQDMULL D14, S10, V12.S[0x1]
    SQDMLAL  V30.4S, V1.4H, V1.4H
    SHADD  V29.8H, V16.8H, V9.8H
    SSHR  V10.16B, V29.16B, #6
    SQDMLSL V29.2D, V10.2S, V14.S[0x0]
    SQABS  V31.2S, V30.2S
    SABD  V19.16B, V29.16B, V31.16B
    SQDMLAL  V25.4S, V29.4H, V29.4H
    SMULL2  V10.2D, V7.4S, V25.4S
    SRSHR  V14.4S, V14.4S, #22
    SQDMLSL V18.2D, V2.2S, V6.S[0x0]
    SQXTN2  V30.4S, V11.2D
    SQSHRN V4.4H, V8.4S, #3
    SQDMLAL D1, S25, V26.S[0x3]
    SQRDMULH  V11.2S, V23.2S, V5.2S
    SMLAL2 V6.2D, V6.4S, V14.S[0x1]
    SQSHL  V26.8B, V28.8B, V29.8B
    SQRSHRN2 V22.8H, V8.4S, #10
    SMLSL V27.4S, V6.4H, V4.H[0x4]
    SQDMLAL2  V29.2D, V27.4S, V16.4S
    SQRSHRN V4.8B, V10.8H, #1
    SQRDMULH  V28.4H, V29.4H, V11.H[0x3]
    SXTL2 V11.2D, V4.4S
    SMLSL2 V4.4S, V22.8H, V4.H[0x1]
    SQSHL  V22.2S, V19.2S, #0x10
    SSHR  V5.4H, V3.4H, #7
    SQDMLAL V6.4S, V4.4H, V4.H[0x7]
    SQSHRUN2 V2.4S, V22.2D, #28
    SQSHLU  V9.4H, V18.4H, #0x3
    SQDMLAL2  V19.2D, V11.4S, V28.4S
    SQSHL  V25.16B, V6.16B, V6.16B
    SABDL  V3.4S, V26.4H, V19.4H
    SQRSHRN2 V22.4S, V9.2D, #16
    SRSRA  V4.4S, V1.4S, #25
    SQSHRN2 V11.8H, V5.4S, #1
    SQDMULH  V6.4H, V11.4H, V30.4H
    SXTL2 V8.4S, V2.8H
    SADDLP  V16.8H, V25.16B
    SABDL  V29.2D, V16.2S, V3.2S
    SSRA  V30.8H, V22.8H, #8
    SQRSHRN V10.8B, V30.8H, #8
    SABAL2  V18.4S, V10.8H, V4.8H
    SQDMLSL2 V9.2D, V6.4S, V6.S[0x1]
    SMLAL  V2.8H, V18.8B, V18.8B
    SQDMLAL2  V4.2D, V8.4S, V9.4S
    SQDMULH S9, S4, V4.S[0x0]
    SMLAL V27.2D, V29.2S, V29.S[0x3]
    SQRSHRUN V8.4H, V2.4S, #9
    SQSHRN V9.8B, V8.8H, #8
    SABAL  V8.2D, V9.2S, V27.2S
    SABAL  V16.4S, V16.4H, V21.4H
    SMLSL V11.2D, V15.2S, V3.S[0x3]
    SSUBL2  V19.2D, V2.4S, V25.4S
    SMOV  X23, V6.B[0x6]
    SQSHL  V1.8H, V8.8H, #0x5
    SQDMLAL2 V21.4S, V11.8H, V3.H[0x7]
    SMLAL V18.4S, V31.4H, V2.H[0x7]
    SQSHRN V22.4H, V16.4S, #8
    SADALP  V2.8H, V12.16B
    SQDMLAL2  V30.2D, V16.4S, V16.4S
    SQDMULL V6.4S, V11.4H, V14.H[0x1]
    SQABS  V3.2D, V2.2D
    SQDMLAL2 V29.2D, V3.4S, V9.S[0x2]
    SQDMULL2 V27.4S, V23.8H, V12.H[0x7]
    SQRSHRUN V10.4H, V30.4S, #11
    SQADD  V14.8B, V22.8B, V6.8B
    SSUBL2  V8.8H, V29.16B, V17.16B
    SQDMULH  V23.8H, V18.8H, V9.H[0x5]
    SQSHL  V22.4H, V0.4H, #0x3
    SXTL2 V31.8H, V23.16B
    SSHR  V4.8H, V19.8H, #16
    SMLAL2  V12.4S, V21.8H, V21.8H
    SADDLP  V19.8H, V12.16B
    SQSUB  V30.8B, V29.8B, V31.8B
    SQSHRN V29.4H, V24.4S, #15
    SQDMLSL D25, S30, V1.S[0x2]
    SQSHRUN2 V30.8H, V10.4S, #2
    SXTL V0.4S, V19.4H
    SQSHLU  V12.8B, V22.8B, #0x0
    SSHLL V16.8H, V14.8B, #0x3
    SMLAL2 V10.4S, V27.8H, V8.H[0x7]
    SRSHL  V17.8B, V25.8B, V10.8B
    SRSHR V6.2D, V4.2D, #5
    SSUBW2  V4.2D, V17.2D, V12.4S
    SSRA  V31.8H, V0.8H, #2
    SQSHL V1.2D, V4.2D, #0x3b
    SSUBL  V23.2D, V31.2S, V1.2S
    SQXTN  V21.2S, V6.2D
    SSUBW2  V22.8H, V16.8H, V30.16B
    SRSRA  V30.8B, V22.8B, #4
    SQSUB  V22.2S, V30.2S, V29.2S
    SMULL2 V2.4S, V22.8H, V10.H[0x7]
    SMLSL2 V22.2D, V23.4S, V2.S[0x1]
    SQDMLSL  V16.2D, V21.2S, V21.2S
    SQSHRUN V31.4H, V2.4S, #11
    SQDMLAL2 V2.4S, V16.8H, V13.H[0x2]
    SQXTUN2  V17.16B, V22.8H
    SSHLL2 V6.2D, V17.4S, #0x8
    SMLAL2 V19.2D, V6.4S, V2.S[0x1]
    SMLAL2  V21.2D, V19.4S, V31.4S
    SQSHRUN2 V4.16B, V8.8H, #3
    SQRSHL  V1.4S, V11.4S, V27.4S
    SQSHLU V0.2D, V23.2D, #0x11
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_11
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X24, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x800, LSL #16
    MRS  X24, FPSR
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x2, LSL #16
    FMOV  X24, D0
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D1
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D2
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D3
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7f, LSL #0
    MOVK  X29, #0x7f, LSL #16
    FMOV  X24, D4
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D5
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7f00, LSL #0
    MOVK  X29, #0x7e, LSL #16
    FMOV  X24, D6
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xfe08, LSL #0
    MOVK  X29, #0x7ff, LSL #16
    FMOV  X24, D7
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x4, LSL #0
    MOVK  X29, #0x1, LSL #16
    FMOV  X24, D8
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D9
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x1000, LSL #0
    FMOV  X24, D10
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D11
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D12
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X24, V13.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X24, D13
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7f00, LSL #0
    FMOV  X24, D14
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D15
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x3f8, LSL #16
    FMOV  X24, D16
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7e7f, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7f, LSL #0
    MOVK  X29, #0x7f, LSL #16
    FMOV  X24, D17
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D18
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D19
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X24, V20.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X24, D20
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7f, LSL #0
    MOVK  X29, #0x7e, LSL #16
    FMOV  X24, D22
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x1, LSL #0
    MOVK  X29, #0x8000, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  X24, V23.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x1, LSL #0
    FMOV  X24, D23
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D24
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7f, LSL #0
    MOVK  X29, #0x7f, LSL #16
    FMOV  X24, D25
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D26
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D27
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D28
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D29
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x7f, LSL #0
    MOVK  X29, #0x7e, LSL #16
    FMOV  X24, D30
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X26, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x4cb3, LSL #0
    MOVK  X3, #0x2ced, LSL #16
    MOVK  X3, #0xb63a, LSL #32
    MOVK  X3, #0x91e6, LSL #48
    MOVZ  X4, #0xec87, LSL #0
    MOVK  X4, #0x637c, LSL #16
    MOVK  X4, #0x768b, LSL #32
    MOVK  X4, #0xffc1, LSL #48
    MOVZ  X5, #0xd861, LSL #0
    MOVK  X5, #0x14ea, LSL #16
    MOVK  X5, #0xa96c, LSL #32
    MOVK  X5, #0x9173, LSL #48
    MOVZ  X6, #0xd871, LSL #0
    MOVK  X6, #0xc556, LSL #16
    MOVK  X6, #0x5e6d, LSL #32
    MOVK  X6, #0x7831, LSL #48
    MOVZ  X7, #0x6ce5, LSL #0
    MOVK  X7, #0x6d56, LSL #16
    MOVK  X7, #0xff66, LSL #32
    MOVK  X7, #0x3631, LSL #48
    MOVZ  X10, #0xd11, LSL #0
    MOVK  X10, #0xba22, LSL #16
    MOVK  X10, #0x47b4, LSL #32
    MOVK  X10, #0x1f69, LSL #48
    MOVZ  X11, #0xad56, LSL #0
    MOVK  X11, #0x6758, LSL #16
    MOVK  X11, #0x8223, LSL #32
    MOVK  X11, #0xd9dd, LSL #48
    MOVZ  X12, #0xff79, LSL #0
    MOVK  X12, #0x5839, LSL #16
    MOVK  X12, #0x35f7, LSL #32
    MOVK  X12, #0x2b19, LSL #48
    MOVZ  X13, #0xb2a2, LSL #0
    MOVK  X13, #0x257a, LSL #16
    MOVK  X13, #0x8d76, LSL #32
    MOVK  X13, #0x438b, LSL #48
    MOVZ  X14, #0xfd75, LSL #0
    MOVK  X14, #0x7d5a, LSL #16
    MOVK  X14, #0x15a7, LSL #32
    MOVK  X14, #0x467b, LSL #48
    MOVZ  X15, #0xd20e, LSL #0
    MOVK  X15, #0x894e, LSL #16
    MOVK  X15, #0xa654, LSL #32
    MOVK  X15, #0x1a79, LSL #48
    MOVZ  X16, #0x9850, LSL #0
    MOVK  X16, #0x1170, LSL #16
    MOVK  X16, #0xb4ed, LSL #32
    MOVK  X16, #0x33fb, LSL #48
    MOVZ  X17, #0x8c03, LSL #0
    MOVK  X17, #0xd64b, LSL #16
    MOVK  X17, #0xc5b0, LSL #32
    MOVK  X17, #0x672b, LSL #48
    MOVZ  X18, #0x8126, LSL #0
    MOVK  X18, #0xd76c, LSL #16
    MOVK  X18, #0xa51, LSL #32
    MOVK  X18, #0x603b, LSL #48
    MOVZ  X19, #0xae55, LSL #0
    MOVK  X19, #0xc15e, LSL #16
    MOVK  X19, #0xbf18, LSL #32
    MOVK  X19, #0x7715, LSL #48
    MOVZ  X20, #0x36ec, LSL #0
    MOVK  X20, #0x7c88, LSL #16
    MOVK  X20, #0x10dd, LSL #32
    MOVK  X20, #0x425e, LSL #48
    MOVZ  X21, #0x304a, LSL #0
    MOVK  X21, #0x9168, LSL #16
    MOVK  X21, #0xc1dc, LSL #32
    MOVK  X21, #0x1f60, LSL #48
    MOVZ  X22, #0xa55c, LSL #0
    MOVK  X22, #0x6080, LSL #16
    MOVK  X22, #0x2634, LSL #32
    MOVK  X22, #0x89ca, LSL #48
    MOVZ  X23, #0x32ce, LSL #0
    MOVK  X23, #0xfe68, LSL #16
    MOVK  X23, #0x8e50, LSL #32
    MOVK  X23, #0x28fd, LSL #48
    MOVZ  X24, #0xb5ab, LSL #0
    MOVK  X24, #0x9a7b, LSL #16
    MOVK  X24, #0x9b29, LSL #32
    MOVK  X24, #0x22f9, LSL #48
    MOVZ  X25, #0x375f, LSL #0
    MOVK  X25, #0x5f6d, LSL #16
    MOVK  X25, #0x8b12, LSL #32
    MOVK  X25, #0xb2c, LSL #48
    MOVZ  X26, #0xacd9, LSL #0
    MOVK  X26, #0x5ff8, LSL #16
    MOVK  X26, #0x2887, LSL #32
    MOVK  X26, #0x6cf, LSL #48
    MOVZ  X28, #0x7440, LSL #0
    MOVK  X28, #0x21ff, LSL #16
    MOVK  X28, #0x98ae, LSL #32
    MOVK  X28, #0xc64c, LSL #48
    MOVZ  X29, #0x481e, LSL #0
    MOVK  X29, #0x7da2, LSL #16
    MOVK  X29, #0xbdb1, LSL #32
    MOVK  X29, #0x3bf3, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X24
    FMOV  V3.D[1], X26
    FMOV  D4, X19
    FMOV  V4.D[1], X11
    FMOV  D5, X16
    FMOV  V5.D[1], X23
    FMOV  D6, X17
    FMOV  V6.D[1], X12
    FMOV  D7, X4
    FMOV  V7.D[1], X10
    FMOV  D8, X5
    FMOV  V8.D[1], X4
    FMOV  D9, X4
    FMOV  V9.D[1], X3
    FMOV  D10, X20
    FMOV  V10.D[1], X17
    FMOV  D11, X29
    FMOV  V11.D[1], X25
    FMOV  D12, X25
    FMOV  V12.D[1], X4
    FMOV  D13, X23
    FMOV  V13.D[1], X22
    FMOV  D14, X4
    FMOV  V14.D[1], X3
    FMOV  D15, X24
    FMOV  V15.D[1], X28
    FMOV  D16, X23
    FMOV  V16.D[1], X13
    FMOV  D17, X21
    FMOV  V17.D[1], X15
    FMOV  D18, X12
    FMOV  V18.D[1], X14
    FMOV  D19, X15
    FMOV  V19.D[1], X19
    FMOV  D20, X14
    FMOV  V20.D[1], X12
    FMOV  D21, X6
    FMOV  V21.D[1], X6
    FMOV  D22, X4
    FMOV  V22.D[1], X20
    FMOV  D23, X21
    FMOV  V23.D[1], X7
    FMOV  D24, X20
    FMOV  V24.D[1], X7
    FMOV  D25, X16
    FMOV  V25.D[1], X25
    FMOV  D26, X17
    FMOV  V26.D[1], X29
    FMOV  D27, X16
    FMOV  V27.D[1], X11
    FMOV  D28, X10
    FMOV  V28.D[1], X20
    FMOV  D29, X18
    FMOV  V29.D[1], X10
    FMOV  D30, X4
    FMOV  V30.D[1], X25
    FMOV  D31, X10
    FMOV  V31.D[1], X26
    MOVZ  X11, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_12:
    SQDMULL2  V21.2D, V29.4S, V29.4S
    SRSHR  V1.16B, V31.16B, #7
    SQSHRN2 V1.8H, V19.4S, #10
    SQDMLAL V13.2D, V24.2S, V1.S[0x3]
    SQRSHRUN2 V9.4S, V25.2D, #2
    SQRSHRUN V14.8B, V27.8H, #8
    SXTL2 V5.8H, V14.16B
    SSHR V6.2D, V9.2D, #48
    SQDMLAL2 V18.2D, V26.4S, V6.S[0x3]
    SABD  V15.2S, V28.2S, V5.2S
    SQDMULL2 V14.4S, V30.8H, V13.H[0x7]
    SSHR  V13.16B, V18.16B, #6
    SRSHR V16.2D, V21.2D, #49
    SQDMLAL  V16.2D, V15.2S, V15.2S
    SMOV  X4, V13.S[0x2]
    SRSHR V19.2D, V16.2D, #29
    SQDMULH  V31.8H, V19.8H, V6.H[0x5]
    SSHL  V29.2S, V31.2S, V31.2S
    SQDMLSL D12, S14, V29.S[0x1]
    SRSHR V18.2D, V18.2D, #1
    SQDMLAL2 V26.2D, V6.4S, V19.S[0x3]
    SRSHR V29.2D, V29.2D, #3
    SQRSHRUN2 V25.8H, V8.4S, #2
    SQDMLAL V13.2D, V11.2S, V12.S[0x3]
    SMOV W4, V31.H[0x1]
    SQDMLAL  V30.2D, V25.2S, V1.2S
    SMULL V19.2D, V7.2S, V4.S[0x3]
    SXTL V15.2D, V27.2S
    SRSRA  V27.8H, V7.8H, #7
    SXTL2 V21.8H, V7.16B
    SADDLV  S1, V29.4H
    SQABS  V5.8H, V27.8H
    SABDL2  V11.2D, V20.4S, V1.4S
    SQRDMULH S31, S26, V11.S[0x3]
    SQRSHL  V4.16B, V18.16B, V31.16B
    SQDMULL V7.4S, V30.4H, V4.H[0x0]
    SSUBW2  V25.4S, V21.4S, V21.8H
    SADDW  V27.8H, V15.8H, V15.8B
    SMLAL2 V21.4S, V13.8H, V13.H[0x5]
    SMLAL V13.4S, V5.4H, V5.H[0x7]
    SMLSL  V1.8H, V19.8B, V19.8B
    SQDMLAL2 V16.2D, V7.4S, V7.S[0x3]
    SQSHRUN V26.2S, V16.2D, #23
    SQDMLAL S6, H26, V13.H[0x2]
    SQDMULH H30, H21, V6.H[0x1]
    SQDMULH  V20.8H, V1.8H, V1.H[0x5]
    SQRSHRUN V5.4H, V25.4S, #10
    SXTL2 V13.4S, V30.8H
    SRSHR V16.2D, V13.2D, #29
    SQABS  V19.16B, V27.16B
    SMLAL V27.2D, V19.2S, V16.S[0x2]
    SSHLL V16.4S, V5.4H, #0x6
    SMLAL2 V15.2D, V27.4S, V20.S[0x2]
    SQSHRUN V29.2S, V16.2D, #20
    SABAL  V20.4S, V6.4H, V15.4H
    SXTL2 V7.8H, V20.16B
    SQDMLSL2 V6.2D, V29.4S, V29.S[0x3]
    SQRSHRN2 V5.8H, V6.4S, #10
    SQADD  V1.16B, V5.16B, V5.16B
    SMLSL2  V5.8H, V7.16B, V1.16B
    SQDMLSL D29, S17, V7.S[0x2]
    SABD  V26.4H, V0.4H, V4.4H
    SQDMULH  V19.4S, V7.4S, V12.S[0x3]
    SQDMLSL V27.4S, V21.4H, V8.H[0x3]
    SABDL  V15.2D, V28.2S, V4.2S
    SADDW2  V30.8H, V23.8H, V12.16B
    SQSHL V12.2D, V14.2D, #0x30
    SQSHRUN V23.4H, V6.4S, #2
    SMULL2 V16.2D, V15.4S, V19.S[0x3]
    SQSHLU  V6.4S, V23.4S, #0x8
    SRSHR V25.2D, V2.2D, #16
    SQRSHRN V7.4H, V5.4S, #14
    SQDMULL V17.4S, V7.4H, V6.H[0x7]
    SMLSL2 V14.4S, V27.8H, V12.H[0x7]
    SMOV  X28, V30.S[0x3]
    SSUBW2  V1.8H, V26.8H, V26.16B
    SABAL  V7.8H, V17.8B, V25.8B
    SQDMLAL V8.4S, V16.4H, V0.H[0x6]
    SQSHRUN V15.8B, V8.8H, #8
    SQSHRUN V21.8B, V29.8H, #3
    SQDMLAL  V0.4S, V26.4H, V21.4H
    SQSHRUN V17.4H, V14.4S, #3
    SRSHR  V6.2S, V17.2S, #13
    SQRDMULH  V28.8H, V1.8H, V4.H[0x4]
    SQDMULH H17, H15, V11.H[0x5]
    SXTL V27.8H, V7.8B
    SSHR  V11.8B, V0.8B, #4
    SQSHLU  V5.16B, V11.16B, #0x3
    SADDL2  V14.4S, V6.8H, V5.8H
    SMOV  X3, V14.S[0x3]
    SMOV  X7, V17.H[0x4]
    SQDMULL  V14.2D, V27.2S, V27.2S
    SQRSHRUN V30.8B, V14.8H, #5
    SABAL2  V12.2D, V30.4S, V28.4S
    SQSHRUN2 V8.8H, V3.4S, #10
    SQDMULH  V26.8H, V22.8H, V5.H[0x4]
    SQDMLAL D0, S1, V13.S[0x1]
    SSUBL2  V1.4S, V27.8H, V8.8H
    SQRDMULH  V5.4H, V21.4H, V8.H[0x6]
    SQRSHRN2 V14.8H, V3.4S, #3
    SABAL  V3.8H, V5.8B, V1.8B
    SQDMULL2 V21.2D, V16.4S, V15.S[0x0]
    SQDMLSL2 V22.4S, V23.8H, V10.H[0x0]
    SQABS  V28.4H, V25.4H
    SMOV  X16, V12.B[0x1]
    SQRSHRUN2 V11.4S, V17.2D, #16
    SADDLV  H5, V23.16B
    SRSRA  V6.8H, V5.8H, #9
    SRSRA  V30.8B, V26.8B, #6
    SQDMULL2 V26.2D, V0.4S, V11.S[0x1]
    SMOV W20, V21.H[0x5]
    SQSHRUN2 V1.4S, V26.2D, #7
    SMLAL V23.2D, V3.2S, V1.S[0x2]
    SXTL V13.8H, V22.8B
    SQADD  V27.2S, V14.2S, V28.2S
    SQRDMULH  V22.2S, V27.2S, V23.S[0x0]
    SSHLL V25.4S, V13.4H, #0x5
    SHSUB  V3.8H, V22.8H, V25.8H
    SQSHRUN V14.4H, V6.4S, #9
    SQRSHRN V10.8B, V30.8H, #1
    SABDL  V5.8H, V3.8B, V14.8B
    SRSHR V22.2D, V10.2D, #19
    SRSRA  V3.8B, V19.8B, #5
    SQRSHRN2 V19.8H, V3.4S, #4
    SQDMLAL2 V26.2D, V19.4S, V19.S[0x1]
    SADDW2  V6.8H, V26.8H, V26.16B
    SRSRA  V3.4H, V22.4H, #9
    SQRSHRUN2 V28.4S, V20.2D, #6
    SQRDMULH  V13.2S, V28.2S, V6.S[0x1]
    SQRSHRUN V22.8B, V13.8H, #7
    SQSHRUN2 V10.4S, V3.2D, #4
    SMULL V25.4S, V10.4H, V5.H[0x5]
    SQDMLSL2  V6.2D, V25.4S, V22.4S
    SADALP  V21.4S, V28.8H
    SQDMLAL2 V14.2D, V15.4S, V11.S[0x2]
    SQDMULL V11.2D, V12.2S, V18.S[0x1]
    SQDMLAL2 V28.4S, V15.8H, V4.H[0x3]
    SSHR  V5.4S, V25.4S, #5
    SQSHL  V13.4H, V28.4H, #0x6
    SMOV W14, V15.B[0xf]
    SQSHRUN2 V28.4S, V20.2D, #20
    SRSRA V19.2D, V15.2D, #6
    SQDMLSL V25.4S, V10.4H, V15.H[0x2]
    SQDMLAL2  V26.4S, V6.8H, V25.8H
    SSHLL2 V25.4S, V13.8H, #0xb
    SMOV  X5, V25.H[0x6]
    SMLSL2 V25.2D, V5.4S, V26.S[0x0]
    SMLSL2 V20.4S, V30.8H, V11.H[0x4]
    SQRDMULH H3, H19, V12.H[0x1]
    SADDW2  V12.2D, V25.2D, V14.4S
    SQSHRN V15.2S, V20.2D, #20
    SQRSHL  V26.16B, V15.16B, V15.16B
    SQSHL  V22.16B, V12.16B, #0x6
    SQADD  V4.2D, V9.2D, V10.2D
    SSHR  V19.8H, V22.8H, #13
    SQDMULL S18, H4, V9.H[0x1]
    SADDLV  H4, V28.8B
    SQDMLSL V25.4S, V26.4H, V4.H[0x3]
    SSRA  V13.8B, V18.8B, #2
    SQSHRN2 V10.8H, V25.4S, #13
    SQDMULH  V5.2S, V19.2S, V10.S[0x3]
    SSUBW  V28.4S, V13.4S, V5.4H
    SMOV  X6, V3.B[0x8]
    SSHLL V3.4S, V28.4H, #0x8
    SMULL2 V9.2D, V3.4S, V11.S[0x3]
    SQRDMULH  V11.4H, V9.4H, V9.H[0x1]
    SQDMLAL2 V28.2D, V6.4S, V27.S[0x3]
    SQDMULL V13.2D, V13.2S, V1.S[0x2]
    SQSHL V6.2D, V22.2D, #0x10
    SQDMLAL  V30.4S, V9.4H, V27.4H
    SQDMLAL2  V5.2D, V25.4S, V3.4S
    SQRSHRN V10.8B, V24.8H, #2
    SQSHRUN2 V1.16B, V26.8H, #8
    SQDMLAL S27, H0, V6.H[0x3]
    SSHLL V6.8H, V25.8B, #0x5
    SQDMULH  V19.4S, V6.4S, V5.S[0x2]
    SQDMULH  V18.4S, V19.4S, V13.S[0x1]
    SABAL  V3.2D, V30.2S, V11.2S
    SRSHR  V22.8B, V26.8B, #5
    SQSHRN2 V9.8H, V10.4S, #16
    SQXTN  V6.2S, V3.2D
    SMOV W20, V28.B[0xa]
    SSUBL2  V28.4S, V1.8H, V26.8H
    SQSHLU  V3.8B, V6.8B, #0x7
    SQDMLSL2 V24.4S, V3.8H, V13.H[0x5]
    SXTL2 V6.4S, V22.8H
    SMLSL  V19.4S, V24.4H, V24.4H
    SQDMULH  V4.8H, V19.8H, V14.H[0x4]
    SQRSHRUN V10.4H, V27.4S, #9
    SQRSHRN2 V1.4S, V18.2D, #16
    SQSHRN2 V19.4S, V6.2D, #17
    SHSUB  V6.8H, V10.8H, V10.8H
    SADDLP  V11.8H, V9.16B
    SQDMLAL S10, H19, V4.H[0x1]
    SQXTN2  V30.16B, V28.8H
    SRSHR  V19.8B, V10.8B, #4
    SSHR  V27.4H, V19.4H, #9
    SQSHLU  V4.4S, V11.4S, #0x14
    SMULL2 V14.2D, V30.4S, V4.S[0x1]
    SHADD  V24.16B, V1.16B, V1.16B
    SUBS  X11, X11, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_12
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xd11, LSL #0
    MOVK  X15, #0xba22, LSL #16
    MOVK  X15, #0x47b4, LSL #32
    MOVK  X15, #0x1f69, LSL #48
    SUB  X17, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xff79, LSL #0
    MOVK  X15, #0x5839, LSL #16
    MOVK  X15, #0x35f7, LSL #32
    MOVK  X15, #0x2b19, LSL #48
    SUB  X17, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xb2a2, LSL #0
    MOVK  X15, #0x257a, LSL #16
    MOVK  X15, #0x8d76, LSL #32
    MOVK  X15, #0x438b, LSL #48
    SUB  X17, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x8126, LSL #0
    MOVK  X15, #0xd76c, LSL #16
    MOVK  X15, #0xa51, LSL #32
    MOVK  X15, #0x603b, LSL #48
    SUB  X17, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xae55, LSL #0
    MOVK  X15, #0xc15e, LSL #16
    MOVK  X15, #0xbf18, LSL #32
    MOVK  X15, #0x7715, LSL #48
    SUB  X17, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xa55c, LSL #0
    MOVK  X15, #0x6080, LSL #16
    MOVK  X15, #0x2634, LSL #32
    MOVK  X15, #0x89ca, LSL #48
    SUB  X17, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x32ce, LSL #0
    MOVK  X15, #0xfe68, LSL #16
    MOVK  X15, #0x8e50, LSL #32
    MOVK  X15, #0x28fd, LSL #48
    SUB  X17, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xb5ab, LSL #0
    MOVK  X15, #0x9a7b, LSL #16
    MOVK  X15, #0x9b29, LSL #32
    MOVK  X15, #0x22f9, LSL #48
    SUB  X17, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x375f, LSL #0
    MOVK  X15, #0x5f6d, LSL #16
    MOVK  X15, #0x8b12, LSL #32
    MOVK  X15, #0xb2c, LSL #48
    SUB  X17, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xacd9, LSL #0
    MOVK  X15, #0x5ff8, LSL #16
    MOVK  X15, #0x2887, LSL #32
    MOVK  X15, #0x6cf, LSL #48
    SUB  X17, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x481e, LSL #0
    MOVK  X15, #0x7da2, LSL #16
    MOVK  X15, #0xbdb1, LSL #32
    MOVK  X15, #0x3bf3, LSL #48
    SUB  X17, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x800, LSL #16
    MRS  X17, FPSR
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x2520, LSL #0
    MOVK  X15, #0x7cc4, LSL #16
    MOVK  X15, #0xc01, LSL #32
    MOVK  X15, #0x3b56, LSL #48
    FMOV  X17, D0
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x52, LSL #0
    FMOV  X17, D1
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x481e, LSL #0
    MOVK  X15, #0x7da2, LSL #16
    MOVK  X15, #0xbdb1, LSL #32
    MOVK  X15, #0x3bf3, LSL #48
    FMOV  X17, V2.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x7440, LSL #0
    MOVK  X15, #0x21ff, LSL #16
    MOVK  X15, #0x98ae, LSL #32
    MOVK  X15, #0xc64c, LSL #48
    FMOV  X17, D2
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xff00, LSL #16
    MOVK  X15, #0xff00, LSL #48
    FMOV  X17, D3
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D4
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D5
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x4c, LSL #0
    MOVK  X15, #0x3a, LSL #16
    MOVK  X15, #0x1, LSL #32
    MOVK  X15, #0x1, LSL #48
    FMOV  X17, V7.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x1, LSL #0
    MOVK  X15, #0x21, LSL #16
    MOVK  X15, #0x52, LSL #32
    MOVK  X15, #0x68, LSL #48
    FMOV  X17, D7
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xd861, LSL #0
    MOVK  X15, #0x14ea, LSL #16
    MOVK  X15, #0xa96c, LSL #32
    MOVK  X15, #0x9173, LSL #48
    FMOV  X17, D8
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    FMOV  X17, D10
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D11
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D13
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D16
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D17
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D19
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x8951, LSL #0
    MOVK  X15, #0x39b5, LSL #32
    FMOV  X17, D21
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x52, LSL #0
    FMOV  X17, D24
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x44, LSL #32
    FMOV  X17, D30
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D31
    SUB  X21, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X17
    FMOV  V1.D[1], X13
    FMOV  D2, X15
    FMOV  V2.D[1], X22
    FMOV  D3, X11
    FMOV  V3.D[1], X23
    FMOV  D4, X25
    FMOV  V4.D[1], X21
    FMOV  D5, X20
    FMOV  V5.D[1], X29
    FMOV  D6, X24
    FMOV  V6.D[1], X29
    FMOV  D7, X10
    FMOV  V7.D[1], X29
    FMOV  D8, X15
    FMOV  V8.D[1], X10
    FMOV  D9, X19
    FMOV  V9.D[1], X5
    FMOV  D10, X12
    FMOV  V10.D[1], X13
    FMOV  D11, X4
    FMOV  V11.D[1], X5
    FMOV  D12, X15
    FMOV  V12.D[1], X6
    FMOV  D13, X5
    FMOV  V13.D[1], X11
    FMOV  D14, X15
    FMOV  V14.D[1], X11
    FMOV  D15, X14
    FMOV  V15.D[1], X23
    FMOV  D16, X15
    FMOV  V16.D[1], X29
    FMOV  D17, X6
    FMOV  V17.D[1], X15
    FMOV  D18, X23
    FMOV  V18.D[1], X12
    FMOV  D19, X3
    FMOV  V19.D[1], X10
    FMOV  D20, X7
    FMOV  V20.D[1], X28
    FMOV  D21, X28
    FMOV  V21.D[1], X7
    FMOV  D22, X14
    FMOV  V22.D[1], X28
    FMOV  D23, X20
    FMOV  V23.D[1], X29
    FMOV  D24, X25
    FMOV  V24.D[1], X24
    FMOV  D25, X3
    FMOV  V25.D[1], X5
    FMOV  D26, X7
    FMOV  V26.D[1], X10
    FMOV  D27, X10
    FMOV  V27.D[1], X24
    FMOV  D28, X11
    FMOV  V28.D[1], X22
    FMOV  D29, X10
    FMOV  V29.D[1], X16
    FMOV  D30, X25
    FMOV  V30.D[1], X24
    FMOV  D31, X26
    FMOV  V31.D[1], X22
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_13:
    SADDLP  V21.4S, V29.8H
    SQSHRUN2 V24.8H, V23.4S, #5
    SQDMLSL2  V8.4S, V26.8H, V25.8H
    SQDMULH  V13.2S, V8.2S, V27.S[0x2]
    SQDMLSL  V13.4S, V31.4H, V21.4H
    SMLAL2 V4.4S, V13.8H, V14.H[0x2]
    SMLAL2 V4.2D, V28.4S, V4.S[0x1]
    SQDMULL V11.4S, V24.4H, V4.H[0x2]
    SQDMLSL  V6.2D, V11.2S, V30.2S
    SMLAL V29.4S, V6.4H, V6.H[0x6]
    SADDLV  H24, V29.8B
    SRSHL  V11.4S, V24.4S, V24.4S
    SRSRA  V24.8H, V11.8H, #11
    SQDMULL2  V31.4S, V16.8H, V17.8H
    SQRSHRN V25.8B, V18.8H, #6
    SMULL2 V26.4S, V22.8H, V7.H[0x3]
    SADDLP  V7.4S, V0.8H
    SSHLL2 V23.4S, V15.8H, #0xd
    SABA  V13.8B, V22.8B, V12.8B
    SADDLV  D11, V24.4S
    SMLAL V6.4S, V7.4H, V8.H[0x4]
    SQDMULH  V30.2S, V23.2S, V17.2S
    SABA  V0.4S, V25.4S, V17.4S
    SQSHRN V18.8B, V12.8H, #7
    SMLSL2 V29.2D, V30.4S, V9.S[0x3]
    SQSHRN2 V15.8H, V30.4S, #5
    SQDMULL2 V22.4S, V15.8H, V11.H[0x7]
    SQDMLAL2 V16.2D, V29.4S, V29.S[0x1]
    SQXTUN  V12.2S, V26.2D
    SQSHRN V24.2S, V22.2D, #32
    SADDLV  H15, V11.16B
    SQXTN2  V30.16B, V13.8H
    SQDMULL2  V4.4S, V15.8H, V15.8H
    SMULL V22.2D, V4.2S, V0.S[0x1]
    SQXTN2  V4.16B, V16.8H
    SABA  V16.4H, V22.4H, V6.4H
    SQDMLSL D29, S16, V16.S[0x2]
    SSHLL2 V5.4S, V30.8H, #0xb
    SRSHL  V0.8B, V12.8B, V18.8B
    SADDLV  H9, V24.8B
    SQDMULL  V23.4S, V9.4H, V31.4H
    SSUBW2  V22.2D, V0.2D, V4.4S
    SQSHLU V25.2D, V23.2D, #0x2
    SQDMULH S11, S29, V5.S[0x3]
    SSHLL V0.2D, V22.2S, #0x1c
    SQSHRUN2 V13.4S, V25.2D, #23
    SQXTN2  V25.16B, V30.8H
    SADDL  V24.8H, V25.8B, V11.8B
    SQSHRN V31.4H, V13.4S, #15
    SQSHRUN V17.2S, V0.2D, #32
    SQRDMULH S12, S17, V17.S[0x1]
    SQDMLSL V13.4S, V16.4H, V12.H[0x1]
    SMULL V30.4S, V13.4H, V13.H[0x1]
    SQADD  V4.4S, V30.4S, V24.4S
    SQDMLAL2 V9.2D, V4.4S, V31.S[0x3]
    SQDMULL2 V24.2D, V13.4S, V12.S[0x2]
    SQRSHRN V23.4H, V8.4S, #12
    SADDW  V4.8H, V19.8H, V14.8B
    SMOV W6, V21.H[0x0]
    SQSHRUN V21.2S, V29.2D, #18
    SQXTUN2  V16.16B, V11.8H
    SADDLP  V22.4S, V30.8H
    SXTL V11.2D, V24.2S
    SSHLL V29.8H, V12.8B, #0x7
    SABD  V14.2S, V1.2S, V21.2S
    SXTL V19.2D, V20.2S
    SABD  V12.2S, V9.2S, V19.2S
    SXTL V8.2D, V11.2S
    SUQADD  V17.4H, V23.4H
    SQRDMULH  V0.4H, V14.4H, V11.H[0x3]
    SQRSHRUN2 V14.8H, V16.4S, #6
    SADDW  V9.8H, V4.8H, V29.8B
    SMOV  X6, V0.S[0x3]
    SMULL2  V13.4S, V8.8H, V8.8H
    SQDMLAL D30, S22, V12.S[0x0]
    SXTL V12.2D, V9.2S
    SQDMULL2  V9.2D, V13.4S, V12.4S
    SMULL  V11.2D, V17.2S, V30.2S
    SRHADD  V20.8H, V14.8H, V14.8H
    SQRSHRN V0.4H, V9.4S, #16
    SADDL  V19.2D, V0.2S, V30.2S
    SMULL V8.2D, V19.2S, V13.S[0x2]
    SHADD  V23.2S, V20.2S, V11.2S
    SQSHL  V21.4H, V23.4H, V2.4H
    SQDMLSL2 V11.2D, V21.4S, V21.S[0x0]
    SXTL2 V20.8H, V8.16B
    SRHADD  V2.4S, V11.4S, V20.4S
    SSHLL2 V1.2D, V27.4S, #0x2
    SQDMULL  V29.4S, V15.4H, V13.4H
    SMLSL  V8.4S, V4.4H, V19.4H
    SMLSL2  V14.4S, V12.8H, V11.8H
    SQDMULL  V23.4S, V21.4H, V9.4H
    SQDMLSL S27, H26, V2.H[0x6]
    SQRSHRN2 V20.16B, V22.8H, #3
    SQSHRN V15.4H, V1.4S, #15
    SQSHL  V11.8B, V24.8B, V16.8B
    SQXTN  V13.2S, V14.2D
    SMULL  V30.8H, V19.8B, V3.8B
    SQRSHRN V3.8B, V27.8H, #2
    SQDMLAL2 V4.2D, V29.4S, V3.S[0x0]
    SHSUB  V12.4H, V13.4H, V8.4H
    SXTL V13.2D, V15.2S
    SQDMULL S15, H13, V4.H[0x2]
    SQDMLAL D21, S15, V24.S[0x2]
    SMLAL V8.2D, V11.2S, V12.S[0x1]
    SABAL2  V0.2D, V20.4S, V0.4S
    SRHADD  V24.4S, V0.4S, V23.4S
    SXTL2 V9.2D, V30.4S
    SSRA V23.2D, V24.2D, #55
    SQDMULH H30, H23, V9.H[0x2]
    SQRDMULH H0, H21, V11.H[0x7]
    SQDMLAL2 V13.2D, V8.4S, V8.S[0x1]
    SABD  V24.2S, V13.2S, V0.2S
    SQRSHRUN V22.8B, V30.8H, #1
    SQDMLAL V2.2D, V22.2S, V24.S[0x3]
    SSHR  V24.16B, V26.16B, #6
    SHSUB  V11.4S, V9.4S, V16.4S
    SMLAL2 V23.2D, V14.4S, V7.S[0x0]
    SMLAL V22.2D, V4.2S, V22.S[0x3]
    SABDL2  V15.2D, V13.4S, V22.4S
    SQDMULL D26, S23, V9.S[0x3]
    SQSHL V13.2D, V2.2D, #0x3d
    SQDMLSL D20, S17, V10.S[0x3]
    SSHR  V30.4S, V22.4S, #12
    SMLAL2 V21.2D, V9.4S, V15.S[0x1]
    SADDL  V8.2D, V23.2S, V29.2S
    SSRA V0.2D, V14.2D, #55
    SQSHRN2 V16.8H, V20.4S, #5
    SQSHRN2 V15.8H, V24.4S, #2
    SQRSHRUN V7.4H, V30.4S, #13
    SMLAL  V2.8H, V4.8B, V8.8B
    SQDMULL2 V12.4S, V16.8H, V4.H[0x5]
    SQRSHRUN2 V14.16B, V2.8H, #2
    SQRSHRUN2 V30.16B, V7.8H, #5
    SQRSHRN V22.8B, V0.8H, #8
    SQDMLSL D9, S26, V27.S[0x1]
    SQSHL  V20.4H, V21.4H, #0xa
    SXTL V4.4S, V15.4H
    SQSHRUN2 V7.4S, V13.2D, #10
    SQDMULL2  V0.4S, V7.8H, V30.8H
    SQDMLAL V30.2D, V20.2S, V0.S[0x2]
    SMLSL V10.2D, V30.2S, V11.S[0x2]
    SXTL2 V12.4S, V4.8H
    SHSUB  V8.8B, V9.8B, V22.8B
    SQSHRUN V13.2S, V8.2D, #32
    SQDMULH S24, S30, V10.S[0x3]
    SQRSHRUN2 V2.4S, V1.2D, #30
    SQDMULL S11, H12, V2.H[0x7]
    SADDLV  D17, V13.4S
    SQSHL  V23.2D, V11.2D, V14.2D
    SQDMULH S7, S20, V18.S[0x2]
    SMULL V8.4S, V17.4H, V7.H[0x5]
    SMULL  V13.4S, V24.4H, V24.4H
    SMLAL V29.2D, V13.2S, V13.S[0x3]
    SADDLV  S1, V23.8H
    SRSRA  V27.4H, V29.4H, #7
    SMLAL2 V12.4S, V27.8H, V1.H[0x5]
    SSHR V4.2D, V8.2D, #34
    SRHADD  V8.4S, V12.4S, V12.4S
    SXTL2 V11.4S, V4.8H
    SADDL2  V27.4S, V11.8H, V11.8H
    SSHR  V1.16B, V8.16B, #7
    SSRA  V30.8B, V27.8B, #8
    SQDMULL V24.4S, V30.4H, V1.H[0x0]
    SQDMULH H10, H22, V8.H[0x4]
    SADDW2  V8.8H, V13.8H, V18.16B
    SABAL2  V29.2D, V15.4S, V22.4S
    SSUBL  V11.4S, V27.4H, V1.4H
    SQRSHRUN V23.8B, V3.8H, #2
    SMLSL V3.4S, V12.4H, V14.H[0x5]
    SQADD  V12.2S, V9.2S, V10.2S
    SQRSHRN V17.8B, V8.8H, #6
    SQRDMULH  V1.4S, V9.4S, V20.S[0x0]
    SQDMLAL2 V4.4S, V23.8H, V11.H[0x0]
    SQRSHRN V13.2S, V8.2D, #20
    SQDMULH  V7.4H, V5.4H, V11.H[0x4]
    SMLAL2 V5.4S, V7.8H, V3.H[0x7]
    SQADD  V8.2S, V0.2S, V17.2S
    SQSHRUN2 V17.8H, V8.4S, #9
    SQRDMULH  V9.4S, V12.4S, V12.S[0x1]
    SQSHLU V30.2D, V5.2D, #0xa
    SQRSHL  V12.2D, V13.2D, V24.2D
    SSHR  V3.2S, V4.2S, #11
    SQDMLAL D8, S29, V1.S[0x3]
    SADDL2  V20.4S, V8.8H, V17.8H
    SMULL2 V24.2D, V14.4S, V3.S[0x0]
    SUQADD  V18.2D, V30.2D
    SQDMULH  V15.2S, V9.2S, V18.S[0x3]
    SQSHL  V30.4S, V12.4S, #0xf
    SQRSHRN2 V1.4S, V15.2D, #20
    SSRA  V27.8H, V24.8H, #14
    SHSUB  V9.4S, V20.4S, V20.4S
    SQRSHL  V13.8H, V30.8H, V30.8H
    SSHR  V5.2S, V1.2S, #11
    SMLSL2 V14.4S, V17.8H, V3.H[0x0]
    SMOV W13, V14.H[0x1]
    SSHLL V24.2D, V5.2S, #0xb
    SQDMLSL V29.4S, V13.4H, V13.H[0x5]
    SADDW  V20.2D, V29.2D, V29.2S
    SRSRA  V14.4H, V27.4H, #1
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_13
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x800, LSL #16
    MRS  X7, FPSR
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D0
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D1
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D2
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D3
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D4
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D5
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D6
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D7
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D8
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D9
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V10.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D10
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V11.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D11
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D12
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D13
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D14
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D15
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D16
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D17
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D18
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D19
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D20
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D21
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D22
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D23
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D24
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D25
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D26
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D27
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D28
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D29
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D30
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, D31
    SUB  X20, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
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
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X22
    FMOV  D3, X25
    FMOV  V3.D[1], X16
    FMOV  D4, X21
    FMOV  V4.D[1], X13
    FMOV  D5, X10
    FMOV  V5.D[1], X15
    FMOV  D6, X3
    FMOV  V6.D[1], X15
    FMOV  D7, X13
    FMOV  V7.D[1], X24
    FMOV  D8, X28
    FMOV  V8.D[1], X6
    FMOV  D9, X24
    FMOV  V9.D[1], X10
    FMOV  D10, X13
    FMOV  V10.D[1], X7
    FMOV  D11, X25
    FMOV  V11.D[1], X5
    FMOV  D12, X25
    FMOV  V12.D[1], X6
    FMOV  D13, X21
    FMOV  V13.D[1], X14
    FMOV  D14, X13
    FMOV  V14.D[1], X14
    FMOV  D15, X13
    FMOV  V15.D[1], X23
    FMOV  D16, X3
    FMOV  V16.D[1], X26
    FMOV  D17, X16
    FMOV  V17.D[1], X17
    FMOV  D18, X28
    FMOV  V18.D[1], X16
    FMOV  D19, X5
    FMOV  V19.D[1], X14
    FMOV  D20, X3
    FMOV  V20.D[1], X14
    FMOV  D21, X3
    FMOV  V21.D[1], X25
    FMOV  D22, X11
    FMOV  V22.D[1], X29
    FMOV  D23, X22
    FMOV  V23.D[1], X14
    FMOV  D24, X29
    FMOV  V24.D[1], X28
    FMOV  D25, X26
    FMOV  V25.D[1], X22
    FMOV  D26, X18
    FMOV  V26.D[1], X20
    FMOV  D27, X13
    FMOV  V27.D[1], X3
    FMOV  D28, X23
    FMOV  V28.D[1], X6
    FMOV  D29, X12
    FMOV  V29.D[1], X29
    FMOV  D30, X5
    FMOV  V30.D[1], X17
    FMOV  D31, X26
    FMOV  V31.D[1], X21
    MOVZ  X18, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_14:
    SRSHR V15.2D, V26.2D, #53
    SADDLV  H31, V24.16B
    SQDMLSL2 V0.2D, V25.4S, V18.S[0x1]
    SSHL  V30.16B, V28.16B, V30.16B
    SQRSHRUN V28.4H, V30.4S, #4
    SQRSHRN2 V27.8H, V29.4S, #9
    SADDLP  V17.4H, V23.8B
    SXTL V8.2D, V15.2S
    SADDW  V1.2D, V8.2D, V8.2S
    SMOV  X3, V31.S[0x3]
    SABDL  V25.4S, V22.4H, V0.4H
    SQRSHRUN2 V1.16B, V28.8H, #1
    SQSHRUN2 V0.4S, V1.2D, #11
    SRSRA  V11.4S, V17.4S, #16
    SMULL2 V30.4S, V22.8H, V6.H[0x3]
    SQDMLAL V13.2D, V27.2S, V25.S[0x1]
    SQDMULL  V17.4S, V0.4H, V0.4H
    SADDLV  S31, V17.8H
    SQDMLSL D29, S11, V13.S[0x0]
    SSHR  V18.2S, V10.2S, #9
    SQSHRN V28.4H, V30.4S, #6
    SMLAL  V30.4S, V31.4H, V31.4H
    SQSHRN2 V25.8H, V30.4S, #7
    SUQADD  V17.2S, V29.2S
    SMOV  X26, V12.B[0xe]
    SQDMLSL S1, H28, V10.H[0x2]
    SQDMLAL D8, S25, V18.S[0x3]
    SRSHL  V11.8B, V17.8B, V1.8B
    SQRSHRUN V17.2S, V8.2D, #11
    SRSHL  V24.4H, V11.4H, V11.4H
    SQDMLSL S1, H24, V10.H[0x7]
    SMULL V29.2D, V17.2S, V17.S[0x3]
    SQSHLU V0.2D, V29.2D, #0x22
    SQXTN2  V8.4S, V1.2D
    SABAL  V29.8H, V0.8B, V0.8B
    SSRA  V12.2S, V8.2S, #25
    SRSRA  V15.16B, V29.16B, #3
    SSHR  V25.8H, V12.8H, #4
    SQSHRUN2 V28.8H, V15.4S, #1
    SQRSHRUN V0.4H, V25.4S, #14
    SQRSHRN V18.8B, V0.8H, #6
    SXTL2 V29.8H, V18.16B
    SHSUB  V8.16B, V28.16B, V29.16B
    SRSRA  V28.4H, V15.4H, #2
    SQSHLU V13.2D, V19.2D, #0x1a
    SQDMULL V31.4S, V20.4H, V15.H[0x6]
    SXTL2 V24.4S, V9.8H
    SQDMLAL2  V11.4S, V10.8H, V8.8H
    SSHR  V25.8B, V15.8B, #6
    SQRSHRN V30.8B, V17.8H, #2
    SMOV W4, V11.H[0x2]
    SMLSL2  V1.2D, V23.4S, V31.4S
    SRSHR  V11.4S, V15.4S, #9
    SSUBL2  V18.2D, V6.4S, V7.4S
    SQRSHRUN2 V29.8H, V22.4S, #2
    SMOV W22, V13.B[0x8]
    SQXTUN2  V8.4S, V11.2D
    SQRDMULH S9, S29, V30.S[0x0]
    SMOV  X5, V7.B[0xe]
    SADDW2  V15.4S, V28.4S, V25.8H
    SQDMLSL V30.2D, V15.2S, V18.S[0x0]
    SXTL V20.4S, V30.4H
    SQSHRUN V6.2S, V1.2D, #10
    SSHLL2 V17.2D, V9.4S, #0x14
    SQDMLSL2  V23.4S, V24.8H, V24.8H
    SSHR  V10.8B, V6.8B, #5
    SQRDMULH  V0.2S, V10.2S, V20.S[0x1]
    SHSUB  V18.4S, V17.4S, V8.4S
    SQRSHRN2 V1.16B, V23.8H, #6
    SADDLP  V22.2D, V0.4S
    SQRSHRN2 V31.4S, V22.2D, #25
    SADALP  V23.8H, V31.16B
    SQSHLU  V19.8H, V23.8H, #0x0
    SMLSL V10.4S, V18.4H, V1.H[0x5]
    SQSHL  V30.4H, V19.4H, #0x1
    SQSHRN V15.4H, V10.4S, #14
    SMLAL V24.2D, V15.2S, V30.S[0x3]
    SQDMLAL2 V9.4S, V9.8H, V6.H[0x4]
    SQRDMULH  V25.4H, V14.4H, V11.H[0x6]
    SXTL2 V1.2D, V20.4S
    SQSHL  V8.2S, V4.2S, V31.2S
    SXTL2 V23.4S, V23.8H
    SXTL2 V6.8H, V30.16B
    SQDMLAL2 V11.2D, V28.4S, V17.S[0x3]
    SABD  V30.2S, V29.2S, V5.2S
    SQSHRUN2 V5.8H, V6.4S, #8
    SMOV  X23, V24.B[0x8]
    SMLSL2 V22.4S, V5.8H, V8.H[0x7]
    SSUBW  V24.4S, V1.4S, V9.4H
    SQXTUN  V29.4H, V30.4S
    SMLSL2 V18.4S, V25.8H, V11.H[0x1]
    SQDMULH  V4.2S, V29.2S, V23.S[0x3]
    SQSHRUN V28.4H, V4.4S, #8
    SQDMULH S9, S24, V24.S[0x3]
    SQSHRUN2 V5.4S, V28.2D, #10
    SQDMLSL2 V17.4S, V5.8H, V5.H[0x2]
    SQDMLSL2 V6.4S, V17.8H, V9.H[0x1]
    SQRSHRUN2 V8.8H, V6.4S, #6
    SSHR V1.2D, V8.2D, #35
    SMLAL2 V30.4S, V1.8H, V1.H[0x0]
    SMLSL V31.4S, V30.4H, V6.H[0x1]
    SQSHRN2 V29.8H, V18.4S, #16
    SABD  V6.8B, V22.8B, V22.8B
    SMOV W12, V31.B[0x7]
    SQSHRUN2 V17.4S, V6.2D, #20
    SQDMULL2 V11.2D, V7.4S, V29.S[0x3]
    SMLSL2 V25.4S, V5.8H, V11.H[0x6]
    SRSRA  V29.16B, V17.16B, #3
    SQSHL  V9.16B, V29.16B, #0x5
    SABAL2  V1.2D, V25.4S, V17.4S
    SXTL V7.2D, V9.2S
    SQDMULH  V9.4S, V22.4S, V7.S[0x2]
    SADDW  V6.4S, V21.4S, V1.4H
    SRSHR  V28.4H, V9.4H, #15
    SQSHRN V17.8B, V28.8H, #3
    SQDMLSL S18, H6, V6.H[0x1]
    SSRA V8.2D, V18.2D, #38
    SQXTUN  V6.2S, V8.2D
    SQSHL  V4.16B, V6.16B, #0x6
    SRSHR  V9.8H, V4.8H, #15
    SXTL V31.4S, V28.4H
    SSRA  V24.4H, V17.4H, #1
    SQDMULL D28, S24, V9.S[0x0]
    SSHLL2 V18.2D, V28.4S, #0x7
    SSUBL2  V4.2D, V18.4S, V31.4S
    SSUBL  V25.4S, V5.4H, V28.4H
    SMULL2 V21.4S, V1.8H, V14.H[0x7]
    SQDMULL2 V24.2D, V20.4S, V30.S[0x1]
    SMLSL V6.2D, V20.2S, V3.S[0x1]
    SQDMLAL S9, H3, V1.H[0x2]
    SSHLL2 V31.2D, V21.4S, #0x1f
    SUQADD  V8.8H, V26.8H
    SMLAL2  V1.2D, V5.4S, V14.4S
    SRSHR  V28.8H, V14.8H, #7
    SQSHRN2 V14.4S, V9.2D, #6
    SQXTUN2  V18.4S, V1.2D
    SQSHL  V30.16B, V6.16B, #0x5
    SQSHRUN2 V7.16B, V24.8H, #2
    SSHLL V21.8H, V4.8B, #0x3
    SQRSHRN2 V20.16B, V31.8H, #6
    SSHLL2 V9.2D, V20.4S, #0xa
    SQRSHRUN V3.2S, V31.2D, #27
    SADDLV  D31, V14.4S
    SRHADD  V6.2S, V30.2S, V25.2S
    SQSHLU V1.2D, V3.2D, #0xa
    SQDMLSL2 V4.4S, V8.8H, V2.H[0x6]
    SMULL V8.4S, V18.4H, V3.H[0x7]
    SQRDMULH H25, H2, V6.H[0x3]
    SQSHRN V30.8B, V31.8H, #7
    SRSHR V3.2D, V1.2D, #9
    SADDL2  V6.2D, V3.4S, V28.4S
    SMLSL V28.2D, V21.2S, V9.S[0x0]
    SQABS  V14.2D, V7.2D
    SMOV W28, V30.B[0x1]
    SQXTN2  V5.8H, V25.4S
    SQRDMULH  V24.2S, V5.2S, V6.S[0x1]
    SQRSHRUN V6.2S, V8.2D, #32
    SQDMULL V8.4S, V4.4H, V14.H[0x3]
    SRSRA V18.2D, V8.2D, #25
    SMLSL V21.4S, V18.4H, V9.H[0x3]
    SSHLL2 V14.2D, V21.4S, #0xe
    SQRSHRUN2 V20.4S, V14.2D, #32
    SQSHL V8.2D, V20.2D, #0xc
    SQSHRN2 V21.16B, V24.8H, #2
    SMULL2 V30.2D, V21.4S, V28.S[0x1]
    SQDMULL2 V18.4S, V8.8H, V6.H[0x5]
    SQDMULL V2.2D, V30.2S, V18.S[0x2]
    SQSUB  V3.2D, V17.2D, V0.2D
    SQDMLAL V1.2D, V12.2S, V28.S[0x1]
    SADDL  V7.2D, V5.2S, V26.2S
    SSHL  V31.8H, V19.8H, V4.8H
    SRSHR  V28.8B, V4.8B, #8
    SQSHRUN V20.4H, V14.4S, #7
    SSHR  V17.4H, V28.4H, #8
    SQDMULL V25.4S, V29.4H, V7.H[0x0]
    SADALP  V9.4S, V21.8H
    SSUBL2  V12.2D, V17.4S, V17.4S
    SQRDMULH S7, S25, V9.S[0x1]
    SQDMLAL2 V17.2D, V14.4S, V23.S[0x2]
    SQXTN2  V0.16B, V8.8H
    SQDMULL V6.2D, V1.2S, V31.S[0x2]
    SQDMLAL2 V30.4S, V6.8H, V1.H[0x4]
    SQDMLAL  V9.4S, V2.4H, V18.4H
    SQSHRN V24.2S, V7.2D, #11
    SSRA V7.2D, V3.2D, #2
    SQSHL  V23.16B, V9.16B, V9.16B
    SSHR  V8.4H, V20.4H, #1
    SQDMULL S2, H23, V7.H[0x5]
    SQSUB  V5.8H, V24.8H, V30.8H
    SSUBL2  V14.2D, V0.4S, V17.4S
    SRSRA  V26.4H, V5.4H, #3
    SQRSHRN V18.8B, V12.8H, #6
    SQSHLU V0.2D, V2.2D, #0x34
    SQSHRUN2 V6.8H, V8.4S, #13
    SMLSL V25.4S, V14.4H, V6.H[0x3]
    SABA  V2.2S, V25.2S, V0.2S
    SQRDMULH  V17.4H, V23.4H, V12.H[0x7]
    SQRDMULH  V31.4H, V18.4H, V2.H[0x6]
    SQSHRN2 V8.8H, V31.4S, #16
    SRSRA  V19.8B, V26.8B, #3
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_14
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X17, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x800, LSL #16
    MRS  X17, FPSR
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D0
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D3
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D4
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D5
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D7
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D11
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D13
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X17, V16.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X17, D16
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D17
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D19
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D21
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D25
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X17, D26
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X17, D27
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D30
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D31
    SUB  X29, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0xaca3, LSL #0
    MOVK  X3, #0x6c55, LSL #16
    MOVK  X3, #0xfa0a, LSL #32
    MOVK  X3, #0x342b, LSL #48
    MOVZ  X4, #0xbc79, LSL #0
    MOVK  X4, #0x9e53, LSL #16
    MOVK  X4, #0xc9e1, LSL #32
    MOVK  X4, #0xcf79, LSL #48
    MOVZ  X5, #0x81e3, LSL #0
    MOVK  X5, #0xb6d7, LSL #16
    MOVK  X5, #0x8373, LSL #32
    MOVK  X5, #0xdb83, LSL #48
    MOVZ  X6, #0xe6fa, LSL #0
    MOVK  X6, #0x7aad, LSL #16
    MOVK  X6, #0x5ce9, LSL #32
    MOVK  X6, #0xd1a0, LSL #48
    MOVZ  X7, #0x6799, LSL #0
    MOVK  X7, #0x6d03, LSL #16
    MOVK  X7, #0xb18, LSL #32
    MOVK  X7, #0xda58, LSL #48
    MOVZ  X10, #0x5497, LSL #0
    MOVK  X10, #0x661, LSL #16
    MOVK  X10, #0x2b0f, LSL #32
    MOVK  X10, #0x7f94, LSL #48
    MOVZ  X11, #0x9d06, LSL #0
    MOVK  X11, #0x7816, LSL #16
    MOVK  X11, #0x658a, LSL #32
    MOVK  X11, #0x1b8d, LSL #48
    MOVZ  X12, #0xd947, LSL #0
    MOVK  X12, #0x6f4a, LSL #16
    MOVK  X12, #0x4542, LSL #32
    MOVK  X12, #0xfe9c, LSL #48
    MOVZ  X13, #0xf821, LSL #0
    MOVK  X13, #0x5477, LSL #16
    MOVK  X13, #0xf1f, LSL #32
    MOVK  X13, #0x43f4, LSL #48
    MOVZ  X14, #0xb160, LSL #0
    MOVK  X14, #0xe0d0, LSL #16
    MOVK  X14, #0x31a9, LSL #32
    MOVK  X14, #0x2341, LSL #48
    MOVZ  X15, #0xb766, LSL #0
    MOVK  X15, #0x8d2c, LSL #16
    MOVK  X15, #0x4c2, LSL #32
    MOVK  X15, #0xa665, LSL #48
    MOVZ  X16, #0x73b8, LSL #0
    MOVK  X16, #0x14bb, LSL #16
    MOVK  X16, #0x1ff2, LSL #32
    MOVK  X16, #0x38d3, LSL #48
    MOVZ  X17, #0xc79f, LSL #0
    MOVK  X17, #0xa6f7, LSL #16
    MOVK  X17, #0x5221, LSL #32
    MOVK  X17, #0x11a2, LSL #48
    MOVZ  X18, #0xbf00, LSL #0
    MOVK  X18, #0x636c, LSL #16
    MOVK  X18, #0x3c76, LSL #32
    MOVK  X18, #0x2832, LSL #48
    MOVZ  X19, #0xf686, LSL #0
    MOVK  X19, #0x1185, LSL #16
    MOVK  X19, #0xc585, LSL #32
    MOVK  X19, #0x4573, LSL #48
    MOVZ  X20, #0x2e0, LSL #0
    MOVK  X20, #0x2d42, LSL #16
    MOVK  X20, #0xbb34, LSL #32
    MOVK  X20, #0x6117, LSL #48
    MOVZ  X21, #0x4207, LSL #0
    MOVK  X21, #0xb9bd, LSL #16
    MOVK  X21, #0x23e2, LSL #32
    MOVK  X21, #0x1415, LSL #48
    MOVZ  X22, #0x5b3a, LSL #0
    MOVK  X22, #0xb25f, LSL #16
    MOVK  X22, #0xcb0c, LSL #32
    MOVK  X22, #0xaca6, LSL #48
    MOVZ  X23, #0x3ea0, LSL #0
    MOVK  X23, #0xc752, LSL #16
    MOVK  X23, #0xc355, LSL #32
    MOVK  X23, #0x6736, LSL #48
    MOVZ  X24, #0xcfc2, LSL #0
    MOVK  X24, #0xc8ba, LSL #16
    MOVK  X24, #0x1261, LSL #32
    MOVK  X24, #0x6607, LSL #48
    MOVZ  X25, #0xea37, LSL #0
    MOVK  X25, #0x1ed4, LSL #16
    MOVK  X25, #0x36d8, LSL #32
    MOVK  X25, #0x4364, LSL #48
    MOVZ  X26, #0xbd53, LSL #0
    MOVK  X26, #0xe2f7, LSL #16
    MOVK  X26, #0x2613, LSL #32
    MOVK  X26, #0xce7b, LSL #48
    MOVZ  X28, #0xe870, LSL #0
    MOVK  X28, #0x8457, LSL #16
    MOVK  X28, #0x2a9e, LSL #32
    MOVK  X28, #0x3f04, LSL #48
    MOVZ  X29, #0x5ab0, LSL #0
    MOVK  X29, #0x4f40, LSL #16
    MOVK  X29, #0x34c9, LSL #32
    MOVK  X29, #0xf270, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X23
    FMOV  V3.D[1], X5
    FMOV  D4, X21
    FMOV  V4.D[1], X23
    FMOV  D5, X4
    FMOV  V5.D[1], X3
    FMOV  D6, X20
    FMOV  V6.D[1], X29
    FMOV  D7, X15
    FMOV  V7.D[1], X6
    FMOV  D8, X29
    FMOV  V8.D[1], X11
    FMOV  D9, X11
    FMOV  V9.D[1], X15
    FMOV  D10, X20
    FMOV  V10.D[1], X26
    FMOV  D11, X29
    FMOV  V11.D[1], X12
    FMOV  D12, X28
    FMOV  V12.D[1], X6
    FMOV  D13, X28
    FMOV  V13.D[1], X28
    FMOV  D14, X28
    FMOV  V14.D[1], X25
    FMOV  D15, X19
    FMOV  V15.D[1], X21
    FMOV  D16, X28
    FMOV  V16.D[1], X17
    FMOV  D17, X18
    FMOV  V17.D[1], X28
    FMOV  D18, X23
    FMOV  V18.D[1], X21
    FMOV  D19, X18
    FMOV  V19.D[1], X7
    FMOV  D20, X25
    FMOV  V20.D[1], X28
    FMOV  D21, X3
    FMOV  V21.D[1], X4
    FMOV  D22, X17
    FMOV  V22.D[1], X26
    FMOV  D23, X16
    FMOV  V23.D[1], X22
    FMOV  D24, X16
    FMOV  V24.D[1], X28
    FMOV  D25, X25
    FMOV  V25.D[1], X29
    FMOV  D26, X14
    FMOV  V26.D[1], X29
    FMOV  D27, X6
    FMOV  V27.D[1], X3
    FMOV  D28, X21
    FMOV  V28.D[1], X13
    FMOV  D29, X12
    FMOV  V29.D[1], X21
    FMOV  D30, X24
    FMOV  V30.D[1], X28
    FMOV  D31, X22
    FMOV  V31.D[1], X14
    MOVZ  X29, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_15:
    SQABS  V20.2D, V31.2D
    SQDMLSL2  V14.2D, V27.4S, V24.4S
    SQDMULH  V4.4H, V25.4H, V11.H[0x7]
    SMULL2  V13.8H, V30.16B, V30.16B
    SXTL V18.4S, V20.4H
    SQSHL  V19.2D, V4.2D, V23.2D
    SADDW  V23.2D, V28.2D, V19.2S
    SQRSHRN2 V12.16B, V14.8H, #6
    SQSHRN2 V6.8H, V29.4S, #10
    SADDLV  D27, V13.4S
    SQDMULH H17, H23, V12.H[0x4]
    SQSUB  V15.4H, V26.4H, V17.4H
    SSHLL V11.4S, V15.4H, #0x5
    SABD  V28.4S, V6.4S, V18.4S
    SQDMULL D12, S11, V27.S[0x0]
    SRSHL  V29.4H, V28.4H, V28.4H
    SSHLL2 V11.2D, V17.4S, #0x19
    SSHLL2 V14.4S, V11.8H, #0x2
    SSRA  V27.16B, V12.16B, #3
    SQDMLSL  V23.2D, V27.2S, V29.2S
    SQSHRN V24.8B, V14.8H, #1
    SQSHRUN V31.8B, V24.8H, #1
    SQRDMULH H13, H31, V15.H[0x3]
    SQDMULL2 V18.4S, V23.8H, V13.H[0x4]
    SQDMLSL2 V14.4S, V0.8H, V7.H[0x7]
    SQSHLU V26.2D, V12.2D, #0x22
    SQSHRN2 V15.4S, V18.2D, #28
    SQSHLU V23.2D, V3.2D, #0x4
    SSUBL  V13.4S, V13.4H, V26.4H
    SQRSHRN2 V26.8H, V23.4S, #9
    SSHLL V23.4S, V18.4H, #0x8
    SQDMULL  V11.4S, V24.4H, V7.4H
    SMLSL  V31.8H, V1.8B, V5.8B
    SADALP  V12.2S, V31.4H
    SQDMLAL V31.2D, V17.2S, V24.S[0x0]
    SSHLL2 V0.4S, V17.8H, #0x5
    SXTL2 V1.8H, V26.16B
    SQDMULH  V26.4H, V31.4H, V11.H[0x0]
    SADDLP  V28.2S, V13.4H
    SSUBL2  V13.8H, V12.16B, V1.16B
    SMOV W12, V28.H[0x4]
    SSRA  V5.4H, V15.4H, #3
    SMOV  X13, V5.S[0x3]
    SRSRA  V5.4H, V14.4H, #10
    SQSHL V15.2D, V26.2D, #0x18
    SQSHRUN V14.2S, V10.2D, #18
    SRSRA V26.2D, V0.2D, #13
    SSUBL2  V12.4S, V23.8H, V23.8H
    SMULL2  V11.8H, V13.16B, V8.16B
    SQSHRN2 V10.4S, V15.2D, #31
    SQSHLU  V0.2S, V10.2S, #0x1c
    SQABS  V23.4S, V5.4S
    SMLSL2  V24.8H, V11.16B, V11.16B
    SRSRA  V13.2S, V14.2S, #20
    SQDMLSL2  V17.2D, V16.4S, V12.4S
    SMLAL  V18.2D, V17.2S, V13.2S
    SSRA V10.2D, V24.2D, #4
    SSHLL V17.8H, V9.8B, #0x2
    SHADD  V13.2S, V18.2S, V0.2S
    SABDL  V9.4S, V13.4H, V23.4H
    SHADD  V5.8B, V17.8B, V26.8B
    SMLSL  V26.8H, V10.8B, V5.8B
    SMOV  X3, V26.B[0xa]
    SHADD  V14.16B, V0.16B, V0.16B
    SSUBW  V10.4S, V5.4S, V5.4H
    SADDLV  H28, V11.8B
    SSUBL2  V16.8H, V5.16B, V19.16B
    SQSHL  V8.16B, V31.16B, V27.16B
    SSHLL V12.2D, V0.2S, #0x1a
    SMLSL V31.4S, V31.4H, V11.H[0x4]
    SQNEG  V17.8B, V5.8B
    SQDMLAL D26, S28, V10.S[0x2]
    SQDMLAL S23, H14, V8.H[0x4]
    SQRSHRUN2 V10.4S, V17.2D, #3
    SADDLV  S24, V12.4H
    SQSHRUN2 V28.4S, V31.2D, #20
    SMLAL2 V18.4S, V16.8H, V3.H[0x2]
    SSHR V0.2D, V26.2D, #53
    SQDMLAL S15, H9, V10.H[0x3]
    SQRDMULH H13, H23, V15.H[0x4]
    SRSRA  V26.4H, V13.4H, #11
    SRHADD  V11.8H, V24.8H, V24.8H
    SSHLL V10.4S, V11.4H, #0x6
    SRSHR  V9.4S, V26.4S, #14
    SQSHRN V26.8B, V28.8H, #7
    SSHLL V23.4S, V10.4H, #0x2
    SQSHL  V15.2S, V18.2S, #0x19
    SQDMLAL V18.2D, V26.2S, V9.S[0x3]
    SQDMULH  V19.4S, V0.4S, V30.4S
    SMLSL2 V31.4S, V23.8H, V6.H[0x5]
    SMLAL V13.2D, V15.2S, V31.S[0x1]
    SQDMLSL2  V5.2D, V16.4S, V13.4S
    SQDMULL D16, S18, V18.S[0x2]
    SQDMLSL2 V9.2D, V19.4S, V30.S[0x2]
    SQSHLU  V13.8H, V9.8H, #0x3
    SQSHLU  V17.4H, V13.4H, #0x7
    SABDL  V6.2D, V5.2S, V17.2S
    SQRDMULH  V23.4H, V6.4H, V6.H[0x0]
    SRSHR  V18.16B, V16.16B, #8
    SMLSL V13.4S, V18.4H, V10.H[0x7]
    SSRA  V15.4H, V13.4H, #12
    SRSHL  V3.2D, V23.2D, V23.2D
    SQDMLAL2  V23.2D, V15.4S, V15.4S
    SQRSHRN2 V26.4S, V23.2D, #4
    SMLAL V13.2D, V26.2S, V3.S[0x0]
    SQRDMULH  V18.4H, V19.4H, V10.H[0x2]
    SMULL2  V10.8H, V21.16B, V8.16B
    SSUBL  V3.2D, V20.2S, V21.2S
    SXTL2 V16.4S, V5.8H
    SQDMULH H21, H20, V5.H[0x3]
    SSHLL2 V15.2D, V9.4S, #0x9
    SABD  V0.16B, V30.16B, V12.16B
    SRHADD  V19.4S, V1.4S, V15.4S
    SQRSHRUN V9.2S, V20.2D, #27
    SMLSL V23.4S, V18.4H, V13.H[0x6]
    SMLAL V5.2D, V21.2S, V23.S[0x3]
    SQDMULL S23, H3, V10.H[0x4]
    SSHR V26.2D, V23.2D, #12
    SSHL  V23.16B, V9.16B, V26.16B
    SRSHR  V9.8H, V16.8H, #1
    SSUBW2  V12.4S, V25.4S, V9.8H
    SQSHL  V8.8H, V0.8H, #0x8
    SQSHRUN2 V1.16B, V23.8H, #7
    SADDL  V20.8H, V19.8B, V5.8B
    SQDMULH H16, H12, V13.H[0x6]
    SQDMLSL S17, H8, V8.H[0x6]
    SUQADD  V25.2S, V20.2S
    SQRDMULH  V21.8H, V1.8H, V1.8H
    SQDMLAL S30, H21, V0.H[0x5]
    SMULL  V10.2D, V25.2S, V30.2S
    SSUBW  V30.2D, V16.2D, V16.2S
    SMLSL  V18.8H, V10.8B, V30.8B
    SQNEG  V25.8H, V18.8H
    SMULL2  V15.4S, V25.8H, V17.8H
    SQDMULL V23.2D, V24.2S, V13.S[0x2]
    SMLAL2 V26.2D, V17.4S, V17.S[0x3]
    SXTL V10.2D, V17.2S
    SQRSHRN V5.2S, V22.2D, #28
    SSHLL V17.4S, V25.4H, #0xf
    SQRDMULH  V25.2S, V9.2S, V11.S[0x2]
    SSUBW2  V3.8H, V7.8H, V22.16B
    SMOV  X6, V23.S[0x2]
    SUQADD  V23.4S, V31.4S
    SADDLP  V12.2S, V2.4H
    SQDMLSL2 V8.2D, V23.4S, V23.S[0x2]
    SQRSHRUN2 V19.4S, V15.2D, #1
    SXTL V14.8H, V3.8B
    SQDMULL S20, H12, V14.H[0x0]
    SQRDMULH  V1.4H, V8.4H, V5.H[0x5]
    SRSRA  V9.2S, V19.2S, #13
    SQABS  V7.4S, V20.4S
    SMULL V20.4S, V1.4H, V10.H[0x1]
    SRHADD  V24.2S, V9.2S, V9.2S
    SMULL V1.4S, V25.4H, V7.H[0x5]
    SQDMLAL D30, S17, V20.S[0x3]
    SMOV W14, V26.H[0x2]
    SSRA  V19.4S, V30.4S, #21
    SQXTN  V30.8B, V1.8H
    SQDMULL V10.2D, V24.2S, V30.S[0x1]
    SQDMLSL V13.4S, V26.4H, V11.H[0x5]
    SQDMLSL S9, H19, V3.H[0x6]
    SQSHL  V23.16B, V10.16B, #0x6
    SQRSHRN V3.8B, V23.8H, #7
    SMULL2 V25.4S, V13.8H, V13.H[0x7]
    SMOV W24, V9.B[0x2]
    SQSHRUN2 V8.16B, V3.8H, #2
    SQDMULL2 V3.2D, V25.4S, V25.S[0x2]
    SQDMULL2 V30.4S, V3.8H, V4.H[0x4]
    SADDW2  V14.4S, V30.4S, V30.8H
    SQRSHRN V30.2S, V8.2D, #3
    SMOV  X7, V14.B[0x9]
    SQSHL  V4.2S, V0.2S, #0x1d
    SSUBW2  V1.4S, V23.4S, V3.8H
    SQDMULH  V0.2S, V0.2S, V18.2S
    SADDLV  H18, V21.8B
    SADDLV  D21, V23.4S
    SSUBW  V25.2D, V7.2D, V9.2S
    SXTL2 V26.4S, V28.8H
    SMOV  X15, V19.B[0x8]
    SQABS  V8.16B, V3.16B
    SRSHR  V13.16B, V21.16B, #6
    SMULL2 V23.2D, V18.4S, V30.S[0x1]
    SQDMLSL V28.4S, V26.4H, V8.H[0x4]
    SMLAL V8.4S, V4.4H, V0.H[0x7]
    SSRA  V9.8B, V25.8B, #7
    SMOV W23, V1.B[0xe]
    SQDMULH  V1.4H, V9.4H, V9.H[0x0]
    SQXTUN2  V18.8H, V1.4S
    SRSRA V4.2D, V18.2D, #13
    SSHLL2 V21.4S, V8.8H, #0x3
    SSRA V26.2D, V21.2D, #62
    SRSRA  V21.4H, V13.4H, #2
    SQDMULH  V30.8H, V4.8H, V1.H[0x2]
    SQDMULL D0, S26, V28.S[0x0]
    SSRA  V14.16B, V21.16B, #4
    SMOV  X21, V30.B[0x9]
    SQRSHRUN2 V25.16B, V23.8H, #4
    SMULL V9.4S, V25.4H, V0.H[0x4]
    SSRA  V30.4H, V14.4H, #16
    SSHR  V14.4H, V9.4H, #16
    SUBS  X29, X29, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_15
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xbc79, LSL #0
    MOVK  X25, #0x9e53, LSL #16
    MOVK  X25, #0xc9e1, LSL #32
    MOVK  X25, #0xcf79, LSL #48
    SUB  X26, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x81e3, LSL #0
    MOVK  X25, #0xb6d7, LSL #16
    MOVK  X25, #0x8373, LSL #32
    MOVK  X25, #0xdb83, LSL #48
    SUB  X26, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x5497, LSL #0
    MOVK  X25, #0x661, LSL #16
    MOVK  X25, #0x2b0f, LSL #32
    MOVK  X25, #0x7f94, LSL #48
    SUB  X26, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x9d06, LSL #0
    MOVK  X25, #0x7816, LSL #16
    MOVK  X25, #0x658a, LSL #32
    MOVK  X25, #0x1b8d, LSL #48
    SUB  X26, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x73b8, LSL #0
    MOVK  X25, #0x14bb, LSL #16
    MOVK  X25, #0x1ff2, LSL #32
    MOVK  X25, #0x38d3, LSL #48
    SUB  X26, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xc79f, LSL #0
    MOVK  X25, #0xa6f7, LSL #16
    MOVK  X25, #0x5221, LSL #32
    MOVK  X25, #0x11a2, LSL #48
    SUB  X26, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xbf00, LSL #0
    MOVK  X25, #0x636c, LSL #16
    MOVK  X25, #0x3c76, LSL #32
    MOVK  X25, #0x2832, LSL #48
    SUB  X26, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xf686, LSL #0
    MOVK  X25, #0x1185, LSL #16
    MOVK  X25, #0xc585, LSL #32
    MOVK  X25, #0x4573, LSL #48
    SUB  X26, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x2e0, LSL #0
    MOVK  X25, #0x2d42, LSL #16
    MOVK  X25, #0xbb34, LSL #32
    MOVK  X25, #0x6117, LSL #48
    SUB  X26, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xe870, LSL #0
    MOVK  X25, #0x8457, LSL #16
    MOVK  X25, #0x2a9e, LSL #32
    MOVK  X25, #0x3f04, LSL #48
    SUB  X26, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x800, LSL #16
    MRS  X26, FPSR
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D0
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x2, LSL #0
    FMOV  X26, D1
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xea37, LSL #0
    MOVK  X25, #0x1ed4, LSL #16
    MOVK  X25, #0x36d8, LSL #32
    MOVK  X25, #0x4364, LSL #48
    FMOV  X26, V2.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xbd53, LSL #0
    MOVK  X25, #0xe2f7, LSL #16
    MOVK  X25, #0x2613, LSL #32
    MOVK  X25, #0xce7b, LSL #48
    FMOV  X26, D2
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D3
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D4
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0x7fff, LSL #16
    MOVK  X25, #0x8000, LSL #48
    FMOV  X26, D5
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D6
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x9a6c, LSL #0
    MOVK  X25, #0x30, LSL #16
    FMOV  X26, D7
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D8
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D9
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D10
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D11
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xa04a, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xf48e, LSL #32
    MOVK  X25, #0xffff, LSL #48
    FMOV  X26, D12
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D13
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D14
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D15
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V16.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D16
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D17
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x2, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D18
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D19
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D20
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D21
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xbd53, LSL #0
    MOVK  X25, #0xe2f7, LSL #16
    MOVK  X25, #0x2613, LSL #32
    MOVK  X25, #0xce7b, LSL #48
    FMOV  X26, V22.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0xc79f, LSL #0
    MOVK  X25, #0xa6f7, LSL #16
    MOVK  X25, #0x5221, LSL #32
    MOVK  X25, #0x11a2, LSL #48
    FMOV  X26, D22
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D23
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D24
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x9a6c, LSL #0
    MOVK  X25, #0x30, LSL #16
    FMOV  X26, D25
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D26
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D27
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V28.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D28
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D29
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V30.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, D30
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X25, #0x1, LSL #0
    FMOV  X26, D31
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X21
    FMOV  V0.D[1], X29
    FMOV  D1, X17
    FMOV  V1.D[1], X28
    FMOV  D2, X19
    FMOV  V2.D[1], X15
    FMOV  D3, X23
    FMOV  V3.D[1], X11
    FMOV  D4, X18
    FMOV  V4.D[1], X22
    FMOV  D5, X26
    FMOV  V5.D[1], X25
    FMOV  D6, X20
    FMOV  V6.D[1], X24
    FMOV  D7, X16
    FMOV  V7.D[1], X18
    FMOV  D8, X25
    FMOV  V8.D[1], X13
    FMOV  D9, X19
    FMOV  V9.D[1], X29
    FMOV  D10, X13
    FMOV  V10.D[1], X3
    FMOV  D11, X19
    FMOV  V11.D[1], X6
    FMOV  D12, X20
    FMOV  V12.D[1], X28
    FMOV  D13, X15
    FMOV  V13.D[1], X18
    FMOV  D14, X12
    FMOV  V14.D[1], X15
    FMOV  D15, X16
    FMOV  V15.D[1], X4
    FMOV  D16, X21
    FMOV  V16.D[1], X7
    FMOV  D17, X18
    FMOV  V17.D[1], X19
    FMOV  D18, X21
    FMOV  V18.D[1], X4
    FMOV  D19, X24
    FMOV  V19.D[1], X24
    FMOV  D20, X26
    FMOV  V20.D[1], X6
    FMOV  D21, X11
    FMOV  V21.D[1], X7
    FMOV  D22, X14
    FMOV  V22.D[1], X16
    FMOV  D23, X21
    FMOV  V23.D[1], X24
    FMOV  D24, X10
    FMOV  V24.D[1], X17
    FMOV  D25, X11
    FMOV  V25.D[1], X7
    FMOV  D26, X28
    FMOV  V26.D[1], X25
    FMOV  D27, X7
    FMOV  V27.D[1], X15
    FMOV  D28, X24
    FMOV  V28.D[1], X12
    FMOV  D29, X5
    FMOV  V29.D[1], X23
    FMOV  D30, X5
    FMOV  V30.D[1], X28
    FMOV  D31, X11
    FMOV  V31.D[1], X10
    MOVZ  X15, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_16:
    SMULL2  V22.8H, V23.16B, V22.16B
    SQRSHRN V20.2S, V29.2D, #2
    SQRDMULH  V29.4S, V30.4S, V24.S[0x1]
    SQDMLAL S25, H29, V1.H[0x5]
    SQDMLSL S8, H25, V12.H[0x7]
    SMLAL  V16.2D, V8.2S, V21.2S
    SQDMULH  V6.8H, V20.8H, V16.8H
    SUQADD  V23.2D, V6.2D
    SQDMLAL V28.2D, V23.2S, V26.S[0x1]
    SADDW  V13.2D, V22.2D, V29.2S
    SQSHRN V7.8B, V27.8H, #4
    SQDMLSL V27.2D, V28.2S, V28.S[0x2]
    SMULL V26.2D, V13.2S, V31.S[0x1]
    SQDMULL S24, H7, V10.H[0x6]
    SQSHRUN V19.4H, V24.4S, #5
    SQSHL  V24.8H, V27.8H, V27.8H
    SADDLV  S6, V24.8H
    SQABS  V16.2D, V26.2D
    SQDMULH  V10.4H, V19.4H, V6.H[0x3]
    SSRA  V27.2S, V10.2S, #12
    SQDMLAL V8.2D, V16.2S, V16.S[0x2]
    SQRSHRN V23.2S, V27.2D, #27
    SQXTN  V16.2S, V8.2D
    SMULL2  V13.8H, V16.16B, V16.16B
    SSUBW2  V22.2D, V13.2D, V5.4S
    SSUBL2  V25.8H, V23.16B, V22.16B
    SQSHL V29.2D, V31.2D, #0x35
    SXTL V24.4S, V25.4H
    SADDW2  V7.2D, V23.2D, V7.4S
    SMLSL2  V25.2D, V23.4S, V2.4S
    SQNEG  V22.16B, V2.16B
    SADDLV  H2, V2.16B
    SQXTN2  V23.16B, V5.8H
    SMLSL V21.2D, V4.2S, V29.S[0x3]
    SRSRA  V5.8H, V28.8H, #13
    SADDL  V28.4S, V17.4H, V13.4H
    SADDW  V6.2D, V25.2D, V22.2S
    SSHR  V27.4S, V8.4S, #16
    SQRSHRUN V31.4H, V27.4S, #2
    SMULL V27.4S, V31.4H, V6.H[0x6]
    SQSUB  V13.8B, V28.8B, V23.8B
    SSHLL2 V19.4S, V5.8H, #0x6
    SQDMULL2 V16.2D, V24.4S, V2.S[0x3]
    SRSHR V5.2D, V19.2D, #51
    SSRA V8.2D, V13.2D, #4
    SADDLV  H10, V7.16B
    SXTL2 V17.4S, V8.8H
    SSHR  V25.4S, V21.4S, #31
    SSHLL2 V28.2D, V27.4S, #0x1e
    SQRSHRN V21.2S, V5.2D, #24
    SADDLV  S29, V16.8H
    SADALP  V28.2D, V10.4S
    SQRSHRUN V19.8B, V17.8H, #2
    SQSHRUN2 V31.16B, V29.8H, #4
    SADDLV  S6, V28.8H
    SQRSHRUN2 V16.8H, V25.4S, #4
    SQRDMULH  V23.8H, V21.8H, V6.H[0x4]
    SMULL2  V25.8H, V16.16B, V19.16B
    SSHLL2 V2.2D, V25.4S, #0x1e
    SQDMULL V7.2D, V31.2S, V31.S[0x0]
    SQSUB  V13.2D, V2.2D, V23.2D
    SMULL2 V27.4S, V7.8H, V7.H[0x4]
    SRSHR  V4.8H, V13.8H, #4
    SMOV  X16, V4.B[0x7]
    SADDLV  D8, V13.4S
    SQRSHL  V10.16B, V13.16B, V28.16B
    SSUBW  V28.8H, V7.8H, V10.8B
    SQDMULL S7, H0, V6.H[0x0]
    SQRSHRN2 V6.16B, V17.8H, #8
    SMLAL2 V31.4S, V4.8H, V8.H[0x3]
    SSRA V29.2D, V14.2D, #1
    SRSHR V10.2D, V3.2D, #47
    SMLAL V0.4S, V27.4H, V4.H[0x6]
    SMLSL V16.4S, V15.4H, V11.H[0x6]
    SMLAL2  V3.4S, V0.8H, V19.8H
    SQDMLSL V23.2D, V30.2S, V14.S[0x0]
    SRSRA  V17.8B, V28.8B, #6
    SQNEG  V2.16B, V7.16B
    SMLSL V4.2D, V23.2S, V2.S[0x3]
    SUQADD  V21.4S, V31.4S
    SQRSHRN2 V7.8H, V17.4S, #9
    SABAL2  V0.2D, V3.4S, V29.4S
    SQRSHRUN V11.4H, V6.4S, #6
    SQDMLSL2 V23.2D, V21.4S, V10.S[0x1]
    SSHR  V14.16B, V23.16B, #6
    SQDMLSL V21.2D, V7.2S, V16.S[0x3]
    SQSHRUN V13.4H, V0.4S, #1
    SSHR  V17.8B, V4.8B, #6
    SRSRA  V8.4H, V17.4H, #13
    SMLSL V17.4S, V11.4H, V11.H[0x5]
    SQDMLSL2 V30.4S, V14.8H, V13.H[0x6]
    SHADD  V11.8H, V30.8H, V21.8H
    SMOV W18, V8.H[0x0]
    SSRA V31.2D, V11.2D, #14
    SQADD  V8.8B, V30.8B, V31.8B
    SMULL2  V27.2D, V17.4S, V8.4S
    SADDL  V7.4S, V22.4H, V23.4H
    SSHL  V21.8B, V28.8B, V25.8B
    SQDMLSL  V11.4S, V7.4H, V21.4H
    SQDMLAL V13.2D, V8.2S, V27.S[0x3]
    SABDL  V29.2D, V25.2S, V13.2S
    SQDMULL D4, S13, V13.S[0x0]
    SQDMULH S19, S21, V8.S[0x2]
    SQSUB  V10.4H, V19.4H, V30.4H
    SSHR  V27.8H, V20.8H, #16
    SQDMLSL2 V20.4S, V1.8H, V13.H[0x2]
    SSHLL2 V6.4S, V15.8H, #0xb
    SQDMULH H14, H24, V9.H[0x7]
    SQSHRN2 V1.16B, V31.8H, #7
    SQRDMULH  V19.8H, V6.8H, V6.8H
    SQNEG  V17.8H, V21.8H
    SMLSL2 V23.2D, V19.4S, V20.S[0x1]
    SQRSHRN V19.2S, V11.2D, #28
    SQDMULL2 V15.2D, V1.4S, V17.S[0x1]
    SSHLL V0.8H, V19.8B, #0x5
    SMULL2 V16.2D, V14.4S, V14.S[0x2]
    SQRDMULH S13, S27, V30.S[0x0]
    SQRSHRUN V20.2S, V10.2D, #21
    SQRSHRN2 V30.4S, V29.2D, #14
    SRSHR V29.2D, V16.2D, #21
    SSHR  V8.4S, V13.4S, #24
    SADDLP  V11.4H, V20.8B
    SQDMLAL2 V27.2D, V11.4S, V29.S[0x2]
    SADDL  V10.2D, V23.2S, V0.2S
    SQDMULH  V11.8H, V8.8H, V10.H[0x7]
    SMLSL V19.2D, V15.2S, V15.S[0x2]
    SQSHLU V7.2D, V4.2D, #0xb
    SMULL V28.4S, V27.4H, V7.H[0x0]
    SQRSHRN2 V27.8H, V30.4S, #8
    SQSHL V14.2D, V28.2D, #0x2c
    SQRSHRUN V1.2S, V11.2D, #31
    SQSHL  V7.8B, V14.8B, #0x1
    SRSRA  V30.8B, V7.8B, #1
    SQRSHRUN V0.2S, V30.2D, #29
    SMOV  X17, V27.H[0x3]
    SMULL2 V27.4S, V1.8H, V6.H[0x7]
    SQRSHL  V15.2S, V0.2S, V19.2S
    SQSHLU  V0.4H, V27.4H, #0x5
    SQDMULH  V16.8H, V0.8H, V0.8H
    SSUBL  V28.4S, V1.4H, V16.4H
    SMLAL V16.2D, V26.2S, V15.S[0x2]
    SSRA V1.2D, V16.2D, #2
    SQDMLSL D15, S28, V28.S[0x1]
    SQRSHRUN V16.2S, V15.2D, #22
    SMLAL V11.4S, V1.4H, V1.H[0x4]
    SXTL V27.8H, V16.8B
    SQRSHRN V7.4H, V11.4S, #8
    SMLAL2  V28.4S, V7.8H, V27.8H
    SXTL2 V19.4S, V31.8H
    SRSRA  V1.16B, V31.16B, #7
    SQDMLAL2  V6.4S, V15.8H, V10.8H
    SSHLL2 V30.8H, V17.16B, #0x5
    SABAL  V26.4S, V9.4H, V7.4H
    SQXTN2  V31.4S, V17.2D
    SSHR V10.2D, V29.2D, #35
    SMLAL2  V16.2D, V20.4S, V4.4S
    SQRDMULH  V17.2S, V10.2S, V16.S[0x1]
    SSHLL V27.4S, V19.4H, #0xa
    SQSHRN V15.4H, V2.4S, #10
    SQRSHRUN2 V7.8H, V16.4S, #6
    SQRSHRN2 V14.4S, V30.2D, #5
    SXTL V4.8H, V14.8B
    SMOV W21, V17.B[0xa]
    SXTL V2.2D, V7.2S
    SQSHRN2 V0.8H, V15.4S, #10
    SMLSL  V15.4S, V6.4H, V28.4H
    SADALP  V28.2D, V15.4S
    SQDMLAL2 V9.4S, V31.8H, V0.H[0x6]
    SQRSHRN2 V30.8H, V1.4S, #7
    SQRDMULH S7, S2, V4.S[0x1]
    SQSHRUN V1.4H, V27.4S, #16
    SQDMLSL V16.4S, V28.4H, V1.H[0x7]
    SXTL V17.4S, V8.4H
    SABD  V6.8H, V7.8H, V7.8H
    SQSHL  V14.8B, V6.8B, #0x3
    SQSHRN2 V15.4S, V9.2D, #3
    SMLSL2 V31.4S, V15.8H, V15.H[0x5]
    SQSHRN2 V29.16B, V17.8H, #2
    SQRSHRN2 V17.16B, V29.8H, #5
    SQRSHRUN V9.8B, V26.8H, #4
    SMLAL2 V8.2D, V14.4S, V30.S[0x3]
    SQDMULH H0, H17, V7.H[0x6]
    SQDMLSL2  V17.2D, V31.4S, V0.4S
    SSRA  V31.2S, V16.2S, #30
    SQRSHRUN V4.4H, V31.4S, #5
    SQSUB  V20.8B, V4.8B, V23.8B
    SQDMULL  V27.4S, V9.4H, V17.4H
    SQRSHRUN V15.4H, V27.4S, #8
    SQSHRN2 V28.8H, V8.4S, #6
    SQRSHRUN V8.8B, V28.8H, #5
    SQSHLU  V17.16B, V8.16B, #0x6
    SQRSHRUN2 V2.16B, V17.8H, #5
    SADDLV  D9, V2.4S
    SADALP  V2.8H, V9.16B
    SQSHRN V17.2S, V2.2D, #15
    SQABS  V29.2S, V20.2S
    SMOV  X20, V29.H[0x0]
    SSHLL V2.4S, V17.4H, #0x2
    SQSHRUN V9.2S, V7.2D, #13
    SABA  V0.4S, V2.4S, V11.4S
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_16
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x800, LSL #16
    MRS  X23, FPSR
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V0.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D0
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V1.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D1
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D2
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V3.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D3
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D4
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D5
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D6
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V7.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D7
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D8
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D9
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D10
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V11.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D11
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V12.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D12
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V13.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D13
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D14
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D15
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D16
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V17.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D17
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V18.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D18
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D19
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V20.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D20
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V21.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D21
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D22
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D23
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V24.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D24
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D25
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D26
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D27
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V28.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D28
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D29
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D30
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X23, D31
    SUB  X4, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTAdvsimdVectorSignedOperation_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X17
    FMOV  D3, X24
    FMOV  V3.D[1], X5
    FMOV  D4, X20
    FMOV  V4.D[1], X7
    FMOV  D5, X24
    FMOV  V5.D[1], X13
    FMOV  D6, X24
    FMOV  V6.D[1], X16
    FMOV  D7, X10
    FMOV  V7.D[1], X10
    FMOV  D8, X23
    FMOV  V8.D[1], X11
    FMOV  D9, X5
    FMOV  V9.D[1], X11
    FMOV  D10, X22
    FMOV  V10.D[1], X17
    FMOV  D11, X20
    FMOV  V11.D[1], X7
    FMOV  D12, X26
    FMOV  V12.D[1], X11
    FMOV  D13, X18
    FMOV  V13.D[1], X10
    FMOV  D14, X22
    FMOV  V14.D[1], X16
    FMOV  D15, X11
    FMOV  V15.D[1], X26
    FMOV  D16, X22
    FMOV  V16.D[1], X21
    FMOV  D17, X26
    FMOV  V17.D[1], X23
    FMOV  D18, X28
    FMOV  V18.D[1], X25
    FMOV  D19, X7
    FMOV  V19.D[1], X29
    FMOV  D20, X10
    FMOV  V20.D[1], X28
    FMOV  D21, X23
    FMOV  V21.D[1], X26
    FMOV  D22, X23
    FMOV  V22.D[1], X23
    FMOV  D23, X22
    FMOV  V23.D[1], X19
    FMOV  D24, X16
    FMOV  V24.D[1], X22
    FMOV  D25, X17
    FMOV  V25.D[1], X24
    FMOV  D26, X15
    FMOV  V26.D[1], X28
    FMOV  D27, X28
    FMOV  V27.D[1], X12
    FMOV  D28, X17
    FMOV  V28.D[1], X22
    FMOV  D29, X23
    FMOV  V29.D[1], X17
    FMOV  D30, X5
    FMOV  V30.D[1], X16
    FMOV  D31, X17
    FMOV  V31.D[1], X5
    MOVZ  X7, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_17:
    SSRA  V22.8B, V23.8B, #3
    SXTL V15.4S, V24.4H
    SQABS  V1.2D, V28.2D
    SQDMLSL2  V16.2D, V26.4S, V29.4S
    SADDLP  V11.4S, V27.8H
    SRSRA  V22.2S, V31.2S, #9
    SQSHRN V30.2S, V15.2D, #13
    SMOV  X5, V30.B[0x8]
    SQDMULH S15, S16, V1.S[0x2]
    SQDMULL S4, H22, V11.H[0x7]
    SQSHL  V29.8H, V15.8H, #0x8
    SADDLP  V13.4H, V29.8B
    SQDMLAL V6.2D, V13.2S, V13.S[0x0]
    SQDMULH  V12.4H, V4.4H, V6.H[0x6]
    SXTL2 V26.8H, V12.16B
    SQDMLSL V12.2D, V26.2S, V26.S[0x1]
    SRHADD  V22.4H, V12.4H, V25.4H
    SQRSHRN V28.2S, V23.2D, #25
    SQSHRN2 V24.4S, V10.2D, #21
    SQDMULH  V6.4S, V31.4S, V21.S[0x1]
    SQSHL V16.2D, V26.2D, #0x39
    SQDMULH  V27.4S, V17.4S, V30.S[0x1]
    SQSHL  V4.16B, V4.16B, #0x7
    SQSHRN V15.2S, V23.2D, #5
    SQDMLSL V29.4S, V31.4H, V5.H[0x4]
    SUQADD  V31.8H, V29.8H
    SQSHRN V11.4H, V22.4S, #12
    SHSUB  V30.2S, V24.2S, V27.2S
    SMOV  X4, V28.B[0x4]
    SMULL2  V24.2D, V6.4S, V6.4S
    SSHLL V5.2D, V30.2S, #0x16
    SSUBL2  V13.4S, V16.8H, V5.8H
    SQDMULL  V26.2D, V1.2S, V4.2S
    SMOV  X29, V31.B[0xe]
    SQDMULL  V6.4S, V25.4H, V15.4H
    SQSHRN2 V1.16B, V24.8H, #5
    SABDL2  V22.8H, V26.16B, V1.16B
    SQDMULL2 V12.4S, V6.8H, V6.H[0x4]
    SMOV  X22, V13.H[0x6]
    SMULL V23.2D, V12.2S, V6.S[0x3]
    SQSHRN2 V13.4S, V11.2D, #28
    SQRSHL  V21.4S, V22.4S, V22.4S
    SQDMLAL2  V31.2D, V23.4S, V23.4S
    SUQADD  V29.8B, V13.8B
    SXTL V12.2D, V21.2S
    SQSHLU  V5.8B, V31.8B, #0x0
    SQSHRUN2 V24.4S, V29.2D, #10
    SQDMULH H10, H12, V12.H[0x5]
    SQDMULH S15, S10, V5.S[0x0]
    SQDMLSL2 V26.4S, V24.8H, V15.H[0x6]
    SQSHL  V29.4S, V13.4S, V31.4S
    SMLAL V1.4S, V19.4H, V5.H[0x0]
    SQRDMULH  V27.2S, V22.2S, V11.2S
    SMLSL2 V11.4S, V14.8H, V5.H[0x6]
    SADALP  V16.2D, V24.4S
    SMLAL2  V10.4S, V19.8H, V4.8H
    SSHLL V21.4S, V11.4H, #0xf
    SQRSHRUN V31.2S, V1.2D, #12
    SQSHLU  V15.16B, V20.16B, #0x0
    SRSHR V23.2D, V7.2D, #35
    SMLAL V19.4S, V27.4H, V14.H[0x2]
    SUQADD  V27.8B, V21.8B
    SQSHRUN V12.8B, V26.8H, #2
    SQSHRUN2 V1.16B, V27.8H, #1
    SQRSHRUN V25.8B, V31.8H, #3
    SXTL V22.4S, V25.4H
    SSHR  V21.8H, V19.8H, #6
    SADDW2  V14.8H, V12.8H, V23.16B
    SMLAL V31.2D, V15.2S, V14.S[0x2]
    SQDMLAL S13, H31, V1.H[0x7]
    SMOV W13, V21.H[0x3]
    SQDMULL V5.2D, V22.2S, V16.S[0x0]
    SQDMULL V7.2D, V10.2S, V10.S[0x3]
    SSRA  V24.8H, V5.8H, #2
    SQRDMULH S21, S13, V24.S[0x2]
    SXTL V11.4S, V29.4H
    SQDMLAL2 V16.4S, V21.8H, V7.H[0x3]
    SMLAL2 V7.2D, V11.4S, V11.S[0x3]
    SABDL  V27.4S, V7.4H, V14.4H
    SQRSHRN2 V24.16B, V27.8H, #7
    SQXTUN2  V12.8H, V16.4S
    SABDL2  V10.2D, V24.4S, V24.4S
    SQRSHRN2 V7.4S, V12.2D, #12
    SQDMLAL  V27.4S, V10.4H, V10.4H
    SQDMLAL2 V15.2D, V7.4S, V27.S[0x1]
    SQDMULH  V7.8H, V31.8H, V1.H[0x2]
    SQSHL  V13.8B, V19.8B, #0x2
    SQDMULL V5.2D, V15.2S, V0.S[0x2]
    SQDMULL V15.2D, V29.2S, V29.S[0x2]
    SSHLL2 V14.2D, V1.4S, #0x1e
    SXTL2 V24.4S, V3.8H
    SSHR  V3.4S, V28.4S, #24
    SQDMLSL2 V21.2D, V3.4S, V6.S[0x0]
    SQRDMULH H16, H22, V2.H[0x2]
    SQDMULL V12.2D, V29.2S, V17.S[0x3]
    SQSHLU  V22.8B, V12.8B, #0x6
    SADALP  V23.2S, V24.4H
    SQSHRN V24.8B, V28.8H, #8
    SSHR  V28.4H, V5.4H, #14
    SQSHL  V17.4S, V24.4S, #0x2
    SXTL2 V10.8H, V28.16B
    SQSHRUN V24.8B, V13.8H, #3
    SXTL2 V28.2D, V23.4S
    SQDMLSL  V12.4S, V15.4H, V17.4H
    SMLAL2 V5.4S, V22.8H, V12.H[0x3]
    SMLSL  V15.4S, V10.4H, V14.4H
    SMULL V27.2D, V16.2S, V16.S[0x0]
    SMOV  X18, V7.H[0x4]
    SRSRA  V22.8B, V21.8B, #4
    SQDMLSL D19, S24, V24.S[0x3]
    SADDLV  H29, V28.16B
    SSRA  V28.2S, V22.2S, #12
    SQDMULH  V13.4H, V28.4H, V5.H[0x6]
    SQRSHRUN2 V7.4S, V15.2D, #22
    SHSUB  V14.4S, V29.4S, V29.4S
    SRSHR  V24.4S, V22.4S, #22
    SADDLP  V16.2S, V7.4H
    SSHR  V7.8B, V13.8B, #8
    SQDMULL  V21.2D, V7.2S, V24.2S
    SSHLL V28.2D, V14.2S, #0x7
    SQNEG  V3.2D, V6.2D
    SQRSHRUN V24.8B, V28.8H, #4
    SQDMLAL2 V10.4S, V16.8H, V3.H[0x5]
    SMULL2 V29.2D, V10.4S, V27.S[0x0]
    SMULL  V15.8H, V24.8B, V22.8B
    SQRSHRN2 V27.16B, V15.8H, #1
    SSHR  V5.4H, V19.4H, #5
    SQSHRUN2 V13.16B, V21.8H, #6
    SQDMULL V14.4S, V13.4H, V13.H[0x7]
    SMOV W22, V5.H[0x4]
    SQDMLAL2 V5.4S, V29.8H, V8.H[0x3]
    SMLSL V16.4S, V27.4H, V8.H[0x7]
    SQADD  V28.2S, V14.2S, V14.2S
    SSRA  V6.4H, V28.4H, #14
    SRSHR  V22.2S, V6.2S, #18
    SQRSHRN2 V10.16B, V22.8H, #5
    SMULL2  V21.4S, V10.8H, V28.8H
    SSRA  V3.4H, V5.4H, #1
    SQSHL  V24.4S, V16.4S, #0x13
    SQADD  V19.8B, V21.8B, V3.8B
    SQDMULL2 V7.4S, V24.8H, V5.H[0x5]
    SRHADD  V13.4H, V19.4H, V19.4H
    SRSHR  V15.4H, V13.4H, #5
    SQRSHRN V20.4H, V15.4S, #6
    SQXTN  V18.4H, V20.4S
    SADDLV  D16, V7.4S
    SABAL2  V13.4S, V16.8H, V16.8H
    SSHR  V16.8B, V31.8B, #8
    SQSHLU V15.2D, V16.2D, #0x18
    SSHLL V22.8H, V15.8B, #0x2
    SQSHRUN V21.2S, V18.2D, #12
    SQRSHRN2 V16.4S, V13.2D, #23
    SRSRA  V31.8H, V22.8H, #14
    SQSHL V20.2D, V31.2D, #0x4
    SQDMLSL  V29.4S, V16.4H, V16.4H
    SQSUB  V18.2D, V20.2D, V21.2D
    SXTL V13.8H, V29.8B
    SSRA  V15.8H, V13.8H, #7
    SSUBL  V13.2D, V15.2S, V15.2S
    SXTL V7.2D, V18.2S
    SQXTUN  V15.4H, V7.4S
    SABD  V29.4S, V13.4S, V15.4S
    SQSHLU V16.2D, V0.2D, #0x1c
    SSHLL2 V3.4S, V5.8H, #0x7
    SQRDMULH H22, H10, V1.H[0x5]
    SRSHL  V24.2S, V15.2S, V5.2S
    SQRSHRN2 V5.8H, V12.4S, #8
    SQSHL  V0.16B, V15.16B, #0x3
    SSHLL V21.4S, V2.4H, #0xa
    SQDMULL2 V12.2D, V7.4S, V17.S[0x2]
    SMOV  X12, V12.B[0x9]
    SMLSL  V18.8H, V29.8B, V21.8B
    SQRSHRN V12.8B, V16.8H, #2
    SSRA V1.2D, V5.2D, #38
    SSRA  V31.16B, V1.16B, #7
    SSUBW  V5.4S, V24.4S, V16.4H
    SQRSHRUN V17.4H, V0.4S, #14
    SQADD  V7.4S, V31.4S, V3.4S
    SSHLL2 V10.2D, V22.4S, #0xb
    SSHLL V1.8H, V10.8B, #0x5
    SQSHRUN2 V15.8H, V18.4S, #2
    SQDMLAL V18.4S, V1.4H, V15.H[0x0]
    SQDMULL  V29.4S, V18.4H, V12.4H
    SABA  V18.4S, V7.4S, V1.4S
    SSUBW  V31.4S, V5.4S, V5.4H
    SRSHL  V21.16B, V29.16B, V14.16B
    SQSHL  V2.4S, V18.4S, V17.4S
    SSUBW  V17.4S, V31.4S, V31.4H
    SQSUB  V7.2S, V21.2S, V21.2S
    SQSHL  V24.4S, V7.4S, #0x13
    SQRDMULH  V5.8H, V17.8H, V2.H[0x3]
    SSHR  V31.2S, V9.2S, #6
    SQSHLU  V0.4S, V31.4S, #0x1b
    SQSHRUN2 V27.16B, V0.8H, #3
    SQSHRN V0.4H, V27.4S, #4
    SQSHRN2 V14.4S, V0.2D, #17
    SMLSL  V29.2D, V24.2S, V11.2S
    SQSHLU V18.2D, V5.2D, #0x18
    SRSHR V17.2D, V18.2D, #53
    SQDMULH S15, S14, V17.S[0x0]
    SUBS  X7, X7, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_17
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    SUB  X20, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x800, LSL #16
    MRS  X20, FPSR
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V0.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D0
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V1.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D1
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V2.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x1, LSL #0
    MOVK  X10, #0x1, LSL #32
    FMOV  X20, D2
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V3.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D3
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D4
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V5.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D5
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V6.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D6
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V7.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D7
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X20, V8.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X20, D8
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X20, V9.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X20, D9
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V10.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D10
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V11.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D11
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V12.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D12
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V13.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D13
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V14.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D14
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V15.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D15
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V16.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D16
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V17.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D17
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V18.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D18
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V19.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X20, D19
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V20.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D20
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V21.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D21
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V22.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D22
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V23.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D23
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V24.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D24
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V25.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D25
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V26.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D26
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V27.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D27
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V28.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D28
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D29
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, D30
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X20, V31.D[1]
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    FMOV  X20, D31
    SUB  X26, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x817a, LSL #0
    MOVK  X3, #0x324e, LSL #16
    MOVK  X3, #0xcf54, LSL #32
    MOVK  X3, #0xc86c, LSL #48
    MOVZ  X4, #0x3554, LSL #0
    MOVK  X4, #0x7bd2, LSL #16
    MOVK  X4, #0x4808, LSL #32
    MOVK  X4, #0xe0db, LSL #48
    MOVZ  X5, #0xbb3f, LSL #0
    MOVK  X5, #0xd781, LSL #16
    MOVK  X5, #0xfb00, LSL #32
    MOVK  X5, #0x3fd3, LSL #48
    MOVZ  X6, #0xfd5b, LSL #0
    MOVK  X6, #0x5d08, LSL #16
    MOVK  X6, #0x9b94, LSL #32
    MOVK  X6, #0x5d6e, LSL #48
    MOVZ  X7, #0x7e67, LSL #0
    MOVK  X7, #0xdc36, LSL #16
    MOVK  X7, #0x6a4a, LSL #32
    MOVK  X7, #0xddb9, LSL #48
    MOVZ  X10, #0x1baf, LSL #0
    MOVK  X10, #0x4a81, LSL #16
    MOVK  X10, #0x6bcb, LSL #32
    MOVK  X10, #0x3520, LSL #48
    MOVZ  X11, #0xd69f, LSL #0
    MOVK  X11, #0x8387, LSL #16
    MOVK  X11, #0xc344, LSL #32
    MOVK  X11, #0xbbe7, LSL #48
    MOVZ  X12, #0x39a6, LSL #0
    MOVK  X12, #0x4c6e, LSL #16
    MOVK  X12, #0xb79a, LSL #32
    MOVK  X12, #0x4937, LSL #48
    MOVZ  X13, #0x3aa9, LSL #0
    MOVK  X13, #0xe17c, LSL #16
    MOVK  X13, #0xc9c2, LSL #32
    MOVK  X13, #0x1477, LSL #48
    MOVZ  X14, #0xad1a, LSL #0
    MOVK  X14, #0xf84, LSL #16
    MOVK  X14, #0x55ce, LSL #32
    MOVK  X14, #0x3de1, LSL #48
    MOVZ  X15, #0xccc0, LSL #0
    MOVK  X15, #0x612e, LSL #16
    MOVK  X15, #0x17ea, LSL #32
    MOVK  X15, #0xe7a6, LSL #48
    MOVZ  X16, #0xe33d, LSL #0
    MOVK  X16, #0x6102, LSL #16
    MOVK  X16, #0x90ee, LSL #32
    MOVK  X16, #0x2311, LSL #48
    MOVZ  X17, #0xf1e6, LSL #0
    MOVK  X17, #0x329d, LSL #16
    MOVK  X17, #0x5e84, LSL #32
    MOVK  X17, #0xcd61, LSL #48
    MOVZ  X18, #0xea74, LSL #0
    MOVK  X18, #0xe2e2, LSL #16
    MOVK  X18, #0x6433, LSL #32
    MOVK  X18, #0xaabc, LSL #48
    MOVZ  X19, #0xf590, LSL #0
    MOVK  X19, #0x5a15, LSL #16
    MOVK  X19, #0xd00c, LSL #32
    MOVK  X19, #0x3ea6, LSL #48
    MOVZ  X20, #0x18bc, LSL #0
    MOVK  X20, #0x9180, LSL #16
    MOVK  X20, #0xf7af, LSL #32
    MOVK  X20, #0x53b3, LSL #48
    MOVZ  X21, #0x7900, LSL #0
    MOVK  X21, #0x523e, LSL #16
    MOVK  X21, #0xe87c, LSL #32
    MOVK  X21, #0xa413, LSL #48
    MOVZ  X22, #0x2d8a, LSL #0
    MOVK  X22, #0xaa89, LSL #16
    MOVK  X22, #0x1010, LSL #32
    MOVK  X22, #0x22e0, LSL #48
    MOVZ  X23, #0x3699, LSL #0
    MOVK  X23, #0xd329, LSL #16
    MOVK  X23, #0xa7f4, LSL #32
    MOVK  X23, #0x1b5, LSL #48
    MOVZ  X24, #0x1aab, LSL #0
    MOVK  X24, #0xfa4, LSL #16
    MOVK  X24, #0x3692, LSL #32
    MOVK  X24, #0xd6c3, LSL #48
    MOVZ  X25, #0xb8e0, LSL #0
    MOVK  X25, #0xeb60, LSL #16
    MOVK  X25, #0x46e1, LSL #32
    MOVK  X25, #0x18d0, LSL #48
    MOVZ  X26, #0x878b, LSL #0
    MOVK  X26, #0xf431, LSL #16
    MOVK  X26, #0xb6e6, LSL #32
    MOVK  X26, #0x42fa, LSL #48
    MOVZ  X28, #0xe609, LSL #0
    MOVK  X28, #0x3bec, LSL #16
    MOVK  X28, #0x80b9, LSL #32
    MOVK  X28, #0xf0c6, LSL #48
    MOVZ  X29, #0x5904, LSL #0
    MOVK  X29, #0xc7d2, LSL #16
    MOVK  X29, #0xb91, LSL #32
    MOVK  X29, #0x45fc, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X18
    FMOV  D3, X12
    FMOV  V3.D[1], X10
    FMOV  D4, X24
    FMOV  V4.D[1], X29
    FMOV  D5, X3
    FMOV  V5.D[1], X3
    FMOV  D6, X6
    FMOV  V6.D[1], X19
    FMOV  D7, X26
    FMOV  V7.D[1], X10
    FMOV  D8, X7
    FMOV  V8.D[1], X13
    FMOV  D9, X4
    FMOV  V9.D[1], X17
    FMOV  D10, X20
    FMOV  V10.D[1], X29
    FMOV  D11, X28
    FMOV  V11.D[1], X4
    FMOV  D12, X10
    FMOV  V12.D[1], X6
    FMOV  D13, X23
    FMOV  V13.D[1], X16
    FMOV  D14, X11
    FMOV  V14.D[1], X3
    FMOV  D15, X26
    FMOV  V15.D[1], X11
    FMOV  D16, X14
    FMOV  V16.D[1], X25
    FMOV  D17, X23
    FMOV  V17.D[1], X29
    FMOV  D18, X4
    FMOV  V18.D[1], X10
    FMOV  D19, X19
    FMOV  V19.D[1], X11
    FMOV  D20, X13
    FMOV  V20.D[1], X7
    FMOV  D21, X12
    FMOV  V21.D[1], X23
    FMOV  D22, X16
    FMOV  V22.D[1], X26
    FMOV  D23, X25
    FMOV  V23.D[1], X23
    FMOV  D24, X3
    FMOV  V24.D[1], X20
    FMOV  D25, X18
    FMOV  V25.D[1], X4
    FMOV  D26, X13
    FMOV  V26.D[1], X23
    FMOV  D27, X22
    FMOV  V27.D[1], X3
    FMOV  D28, X6
    FMOV  V28.D[1], X16
    FMOV  D29, X17
    FMOV  V29.D[1], X28
    FMOV  D30, X22
    FMOV  V30.D[1], X20
    FMOV  D31, X7
    FMOV  V31.D[1], X21
    MOVZ  X22, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_18:
    SQSHLU  V28.2S, V20.2S, #0x9
    SSHLL V23.2D, V24.2S, #0x1
    SSRA  V25.8B, V31.8B, #8
    SQSHL V22.2D, V28.2D, #0x2
    SQSHL V13.2D, V29.2D, #0x31
    SQSHRUN V11.4H, V27.4S, #13
    SQSHL V24.2D, V21.2D, #0x6
    SQSHRN2 V18.8H, V24.4S, #2
    SQDMLSL2 V9.4S, V11.8H, V11.H[0x0]
    SQDMLAL2  V0.2D, V9.4S, V30.4S
    SQDMULL  V28.2D, V18.2S, V23.2S
    SQSHLU V6.2D, V13.2D, #0x1
    SSHLL2 V3.2D, V28.4S, #0x16
    SXTL2 V19.4S, V6.8H
    SADDLV  S13, V0.8H
    SQRDMULH  V3.2S, V22.2S, V22.S[0x2]
    SHSUB  V27.16B, V26.16B, V25.16B
    SSHLL V26.8H, V13.8B, #0x2
    SRSHR V11.2D, V26.2D, #4
    SQRDMULH  V24.4H, V17.4H, V17.4H
    SMLAL2 V0.2D, V27.4S, V19.S[0x2]
    SXTL V19.4S, V0.4H
    SADDLV  D31, V3.4S
    SSHLL2 V27.2D, V11.4S, #0x10
    SQRDMULH H9, H10, V0.H[0x1]
    SQDMULL D22, S9, V24.S[0x3]
    SSHL  V25.8B, V22.8B, V19.8B
    SQSHL  V10.8H, V31.8H, V31.8H
    SQRSHRUN V26.8B, V27.8H, #3
    SSHLL2 V18.8H, V26.16B, #0x5
    SRSRA  V20.4S, V18.4S, #28
    SABAL2  V21.2D, V25.4S, V10.4S
    SQXTUN2  V23.16B, V20.8H
    SQNEG  V24.2S, V21.2S
    SMULL V27.2D, V26.2S, V24.S[0x2]
    SQDMLSL V9.4S, V23.4H, V2.H[0x7]
    SSRA  V10.16B, V27.16B, #3
    SQDMULH  V17.2S, V10.2S, V10.S[0x3]
    SQRSHRUN V10.2S, V9.2D, #3
    SADDLV  S31, V10.8H
    SQSHRUN2 V3.16B, V31.8H, #8
    SQDMULH S18, S3, V17.S[0x0]
    SQRSHRN V24.4H, V3.4S, #10
    SQDMULH  V19.8H, V28.8H, V20.8H
    SQDMULH  V17.2S, V4.2S, V18.2S
    SQDMLAL2 V9.2D, V17.4S, V16.S[0x0]
    SQRDMULH S26, S26, V17.S[0x2]
    SQSHRUN V4.8B, V8.8H, #1
    SSUBW2  V23.2D, V27.2D, V21.4S
    SSHLL2 V10.8H, V4.16B, #0x7
    SSUBW2  V3.2D, V2.2D, V11.4S
    SQSHRUN2 V20.8H, V15.4S, #8
    SQSHL  V0.16B, V30.16B, #0x7
    SQDMULH H30, H10, V10.H[0x3]
    SADDLV  H10, V24.8B
    SQDMULL V11.2D, V30.2S, V27.S[0x2]
    SQRSHRUN V27.2S, V26.2D, #4
    SQSHRN2 V17.4S, V11.2D, #21
    SQSHRN2 V31.8H, V3.4S, #10
    SMULL2 V24.4S, V27.8H, V9.H[0x0]
    SQRSHRUN2 V15.4S, V19.2D, #3
    SMLAL2  V3.2D, V20.4S, V24.4S
    SQSHLU V2.2D, V15.2D, #0x3c
    SRSHR V21.2D, V2.2D, #33
    SADDLV  S4, V3.8H
    SMLAL2  V16.4S, V0.8H, V0.8H
    SQSHLU  V30.2S, V16.2S, #0x9
    SHSUB  V11.8B, V30.8B, V30.8B
    SQSHLU  V26.4H, V21.4H, #0x5
    SQSHRUN V9.2S, V11.2D, #18
    SQSHLU  V27.16B, V4.16B, #0x6
    SXTL V30.2D, V26.2S
    SQDMLAL S18, H9, V10.H[0x4]
    SQDMULL2 V2.2D, V17.4S, V17.S[0x3]
    SMLAL2 V17.2D, V30.4S, V2.S[0x0]
    SMLSL V30.2D, V17.2S, V31.S[0x3]
    SXTL2 V16.8H, V27.16B
    SMLSL V26.4S, V18.4H, V2.H[0x5]
    SHADD  V4.8B, V30.8B, V16.8B
    SSRA V16.2D, V26.2D, #5
    SQDMULL V27.4S, V4.4H, V7.H[0x6]
    SRSHR  V20.8H, V16.8H, #3
    SADDL2  V16.2D, V20.4S, V27.4S
    SMLAL V21.4S, V17.4H, V6.H[0x3]
    SRSHR  V4.16B, V1.16B, #8
    SQSHLU  V18.4S, V18.4S, #0x1a
    SQDMULH H7, H19, V9.H[0x5]
    SRSHR V19.2D, V5.2D, #54
    SSHR V31.2D, V17.2D, #25
    SMLSL2  V1.2D, V17.4S, V9.4S
    SQDMLSL V6.4S, V0.4H, V0.H[0x4]
    SQRSHRN2 V10.16B, V18.8H, #5
    SQDMLSL2 V2.4S, V7.8H, V10.H[0x3]
    SQDMLAL S11, H16, V6.H[0x2]
    SQDMLSL V5.4S, V19.4H, V2.H[0x2]
    SQSHL  V30.2S, V4.2S, #0xa
    SRSRA  V17.4S, V31.4S, #19
    SQSHRUN2 V4.8H, V17.4S, #2
    SADDW2  V31.4S, V1.4S, V5.8H
    SRSRA  V2.4S, V4.4S, #26
    SQSHRN V1.4H, V21.4S, #5
    SXTL V21.4S, V11.4H
    SSRA  V17.8H, V30.8H, #11
    SQRSHL  V18.4S, V31.4S, V17.4S
    SQDMULL V30.2D, V21.2S, V2.S[0x2]
    SQDMLSL S0, H6, V1.H[0x0]
    SQDMULH H11, H18, V0.H[0x7]
    SMLAL V16.4S, V11.4H, V13.H[0x5]
    SADDW2  V27.8H, V30.8H, V1.16B
    SQSHLU  V10.8H, V27.8H, #0x2
    SQRDMULH  V17.4H, V16.4H, V10.H[0x1]
    SQRSHRUN V30.4H, V1.4S, #11
    SQDMLAL S5, H13, V5.H[0x3]
    SSHR  V27.8H, V31.8H, #13
    SQXTUN  V19.4H, V19.4S
    SQRSHRN2 V4.8H, V13.4S, #16
    SADALP  V9.2S, V2.4H
    SQRSHRUN V18.8B, V0.8H, #8
    SADDL2  V1.4S, V0.8H, V14.8H
    SRSRA  V2.4H, V4.4H, #5
    SQDMLAL S21, H9, V5.H[0x5]
    SQSHRUN2 V31.4S, V27.2D, #17
    SQSHL  V27.16B, V31.16B, #0x2
    SQDMLAL S11, H17, V1.H[0x6]
    SQDMLAL V31.2D, V30.2S, V2.S[0x0]
    SQDMLAL D16, S19, V21.S[0x2]
    SADDW2  V4.4S, V18.4S, V18.8H
    SQSHRUN2 V9.4S, V16.2D, #26
    SHSUB  V2.2S, V11.2S, V31.2S
    SQDMLSL2 V11.2D, V2.4S, V2.S[0x2]
    SADDW2  V30.2D, V27.2D, V4.4S
    SMLSL2  V27.2D, V11.4S, V22.4S
    SMLAL V11.4S, V9.4H, V9.H[0x6]
    SQSUB  V17.2D, V30.2D, V30.2D
    SRSRA V21.2D, V17.2D, #52
    SQRSHL  V0.8B, V27.8B, V27.8B
    SQSHRUN V14.2S, V21.2D, #6
    SXTL2 V9.4S, V14.8H
    SQRSHRN2 V5.4S, V12.2D, #12
    SQDMULH  V19.2S, V5.2S, V11.S[0x2]
    SQABS  V4.4H, V9.4H
    SQDMLAL S16, H8, V0.H[0x6]
    SMULL2 V13.4S, V16.8H, V2.H[0x0]
    SABDL2  V14.8H, V4.16B, V24.16B
    SMULL  V30.8H, V14.8B, V14.8B
    SQDMULH  V9.4S, V19.4S, V19.S[0x1]
    SSHLL2 V31.4S, V13.8H, #0xa
    SQSHRUN V11.2S, V30.2D, #13
    SQSHLU  V22.16B, V31.16B, #0x0
    SQSHRN2 V21.8H, V22.4S, #5
    SXTL2 V5.2D, V11.4S
    SQDMLSL V11.2D, V9.2S, V21.S[0x1]
    SQSHRN V12.4H, V4.4S, #2
    SQDMULL V16.4S, V12.4H, V12.H[0x3]
    SABDL2  V27.4S, V0.8H, V16.8H
    SQRSHRUN2 V22.4S, V3.2D, #6
    SADDW  V21.4S, V22.4S, V11.4H
    SQDMLSL V30.2D, V27.2S, V21.S[0x0]
    SQRSHRN2 V0.8H, V5.4S, #7
    SQDMULL D17, S0, V30.S[0x3]
    SADDW  V2.2D, V22.2D, V19.2S
    SQXTUN  V31.4H, V15.4S
    SQSHRN V9.8B, V18.8H, #7
    SQDMLAL  V18.4S, V11.4H, V26.4H
    SQRDMULH  V30.4S, V24.4S, V11.S[0x0]
    SQDMLAL2 V4.2D, V1.4S, V15.S[0x3]
    SQSHRN V16.4H, V31.4S, #3
    SQSHRN2 V11.8H, V16.4S, #11
    SQDMULL2 V16.2D, V13.4S, V24.S[0x1]
    SQDMLSL2 V27.4S, V30.8H, V11.H[0x1]
    SQRSHRUN V12.2S, V16.2D, #25
    SQRDMULH H8, H22, V1.H[0x0]
    SSRA  V0.4S, V16.4S, #18
    SSHLL2 V21.4S, V0.8H, #0xa
    SMULL V5.2D, V9.2S, V12.S[0x0]
    SSRA  V30.4S, V18.4S, #4
    SQRDMULH  V18.2S, V2.2S, V27.S[0x0]
    SSHLL2 V15.2D, V21.4S, #0x7
    SRSRA V16.2D, V4.2D, #10
    SMULL2 V0.4S, V24.8H, V8.H[0x2]
    SMOV  X26, V5.H[0x0]
    SQDMLSL2 V8.4S, V0.8H, V0.H[0x5]
    SUQADD  V27.8H, V8.8H
    SQSHRN V12.8B, V15.8H, #6
    SMOV W5, V30.H[0x4]
    SQSHRUN V9.2S, V17.2D, #9
    SSRA  V26.2S, V9.2S, #2
    SQRSHRUN2 V24.16B, V12.8H, #8
    SUQADD  V0.4S, V18.4S
    SSHLL2 V30.2D, V27.4S, #0x2
    SQSHL  V4.2S, V26.2S, #0x1d
    SQDMLSL V27.4S, V4.4H, V7.H[0x7]
    SMULL2 V8.4S, V0.8H, V0.H[0x0]
    SRSHL  V21.8H, V11.8H, V8.8H
    SUQADD  V8.2S, V30.2S
    SQDMULH  V30.4H, V24.4H, V8.H[0x5]
    SSRA  V26.16B, V6.16B, #7
    SQSHRN2 V18.4S, V27.2D, #32
    SRSRA  V6.16B, V21.16B, #8
    SQDMULL V27.2D, V18.2S, V30.S[0x3]
    SUBS  X22, X22, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_18
    MOVZ  X16, #0x817a, LSL #0
    MOVK  X16, #0x324e, LSL #16
    MOVK  X16, #0xcf54, LSL #32
    MOVK  X16, #0xc86c, LSL #48
    SUB  X14, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x3554, LSL #0
    MOVK  X16, #0x7bd2, LSL #16
    MOVK  X16, #0x4808, LSL #32
    MOVK  X16, #0xe0db, LSL #48
    SUB  X14, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xfd5b, LSL #0
    MOVK  X16, #0x5d08, LSL #16
    MOVK  X16, #0x9b94, LSL #32
    MOVK  X16, #0x5d6e, LSL #48
    SUB  X14, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x7e67, LSL #0
    MOVK  X16, #0xdc36, LSL #16
    MOVK  X16, #0x6a4a, LSL #32
    MOVK  X16, #0xddb9, LSL #48
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x1baf, LSL #0
    MOVK  X16, #0x4a81, LSL #16
    MOVK  X16, #0x6bcb, LSL #32
    MOVK  X16, #0x3520, LSL #48
    SUB  X14, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x39a6, LSL #0
    MOVK  X16, #0x4c6e, LSL #16
    MOVK  X16, #0xb79a, LSL #32
    MOVK  X16, #0x4937, LSL #48
    SUB  X14, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x3aa9, LSL #0
    MOVK  X16, #0xe17c, LSL #16
    MOVK  X16, #0xc9c2, LSL #32
    MOVK  X16, #0x1477, LSL #48
    SUB  X14, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xccc0, LSL #0
    MOVK  X16, #0x612e, LSL #16
    MOVK  X16, #0x17ea, LSL #32
    MOVK  X16, #0xe7a6, LSL #48
    SUB  X14, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xf1e6, LSL #0
    MOVK  X16, #0x329d, LSL #16
    MOVK  X16, #0x5e84, LSL #32
    MOVK  X16, #0xcd61, LSL #48
    SUB  X14, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xea74, LSL #0
    MOVK  X16, #0xe2e2, LSL #16
    MOVK  X16, #0x6433, LSL #32
    MOVK  X16, #0xaabc, LSL #48
    SUB  X14, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xf590, LSL #0
    MOVK  X16, #0x5a15, LSL #16
    MOVK  X16, #0xd00c, LSL #32
    MOVK  X16, #0x3ea6, LSL #48
    SUB  X14, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x18bc, LSL #0
    MOVK  X16, #0x9180, LSL #16
    MOVK  X16, #0xf7af, LSL #32
    MOVK  X16, #0x53b3, LSL #48
    SUB  X14, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x7900, LSL #0
    MOVK  X16, #0x523e, LSL #16
    MOVK  X16, #0xe87c, LSL #32
    MOVK  X16, #0xa413, LSL #48
    SUB  X14, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x3699, LSL #0
    MOVK  X16, #0xd329, LSL #16
    MOVK  X16, #0xa7f4, LSL #32
    MOVK  X16, #0x1b5, LSL #48
    SUB  X14, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x1aab, LSL #0
    MOVK  X16, #0xfa4, LSL #16
    MOVK  X16, #0x3692, LSL #32
    MOVK  X16, #0xd6c3, LSL #48
    SUB  X14, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xb8e0, LSL #0
    MOVK  X16, #0xeb60, LSL #16
    MOVK  X16, #0x46e1, LSL #32
    MOVK  X16, #0x18d0, LSL #48
    SUB  X14, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xe609, LSL #0
    MOVK  X16, #0x3bec, LSL #16
    MOVK  X16, #0x80b9, LSL #32
    MOVK  X16, #0xf0c6, LSL #48
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x5904, LSL #0
    MOVK  X16, #0xc7d2, LSL #16
    MOVK  X16, #0xb91, LSL #32
    MOVK  X16, #0x45fc, LSL #48
    SUB  X14, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x800, LSL #16
    MRS  X14, FPSR
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D1
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D3
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D8
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D9
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D10
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D11
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D12
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D19
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D20
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D22
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xe609, LSL #0
    MOVK  X16, #0x3bec, LSL #16
    MOVK  X16, #0x80b9, LSL #32
    MOVK  X16, #0xf0c6, LSL #48
    FMOV  X14, V29.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0xf1e6, LSL #0
    MOVK  X16, #0x329d, LSL #16
    MOVK  X16, #0x5e84, LSL #32
    MOVK  X16, #0xcd61, LSL #48
    FMOV  X14, D29
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X14, D31
    SUB  X11, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X22
    FMOV  V0.D[1], X20
    FMOV  D1, X24
    FMOV  V1.D[1], X21
    FMOV  D2, X26
    FMOV  V2.D[1], X14
    FMOV  D3, X15
    FMOV  V3.D[1], X18
    FMOV  D4, X25
    FMOV  V4.D[1], X23
    FMOV  D5, X29
    FMOV  V5.D[1], X28
    FMOV  D6, X5
    FMOV  V6.D[1], X12
    FMOV  D7, X18
    FMOV  V7.D[1], X17
    FMOV  D8, X16
    FMOV  V8.D[1], X29
    FMOV  D9, X24
    FMOV  V9.D[1], X24
    FMOV  D10, X26
    FMOV  V10.D[1], X6
    FMOV  D11, X16
    FMOV  V11.D[1], X16
    FMOV  D12, X6
    FMOV  V12.D[1], X20
    FMOV  D13, X26
    FMOV  V13.D[1], X4
    FMOV  D14, X11
    FMOV  V14.D[1], X5
    FMOV  D15, X18
    FMOV  V15.D[1], X22
    FMOV  D16, X17
    FMOV  V16.D[1], X28
    FMOV  D17, X14
    FMOV  V17.D[1], X6
    FMOV  D18, X12
    FMOV  V18.D[1], X21
    FMOV  D19, X18
    FMOV  V19.D[1], X12
    FMOV  D20, X25
    FMOV  V20.D[1], X7
    FMOV  D21, X10
    FMOV  V21.D[1], X23
    FMOV  D22, X23
    FMOV  V22.D[1], X24
    FMOV  D23, X24
    FMOV  V23.D[1], X17
    FMOV  D24, X22
    FMOV  V24.D[1], X6
    FMOV  D25, X15
    FMOV  V25.D[1], X22
    FMOV  D26, X23
    FMOV  V26.D[1], X23
    FMOV  D27, X7
    FMOV  V27.D[1], X15
    FMOV  D28, X19
    FMOV  V28.D[1], X7
    FMOV  D29, X4
    FMOV  V29.D[1], X23
    FMOV  D30, X17
    FMOV  V30.D[1], X15
    FMOV  D31, X15
    FMOV  V31.D[1], X6
    MOVZ  X15, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_19:
    SRSRA  V18.8B, V31.8B, #2
    SQXTUN2  V8.8H, V18.4S
    SADALP  V12.1D, V30.2S
    SQSHLU  V24.2S, V20.2S, #0x5
    SSHLL V17.2D, V29.2S, #0xf
    SSRA  V10.4S, V27.4S, #18
    SMOV W6, V23.B[0x7]
    SQDMLSL2 V1.2D, V12.4S, V8.S[0x1]
    SSHL  V3.4H, V24.4H, V1.4H
    SQRSHRN V2.2S, V10.2D, #17
    SQSHRUN V5.8B, V2.8H, #5
    SADDLV  D7, V28.4S
    SMLAL2 V7.4S, V26.8H, V3.H[0x0]
    SQRSHRUN2 V29.16B, V5.8H, #2
    SSHR  V24.16B, V17.16B, #1
    SADDLV  S23, V29.8H
    SQSHRUN2 V30.8H, V25.4S, #8
    SADDLV  S5, V30.8H
    SQABS  V10.2D, V7.2D
    SSRA  V1.4H, V10.4H, #12
    SQSHLU V20.2D, V11.2D, #0x3e
    SMOV W24, V5.H[0x3]
    SQDMULL V5.2D, V19.2S, V1.S[0x2]
    SSHLL2 V12.2D, V5.4S, #0x18
    SQDMLAL2 V19.4S, V20.8H, V12.H[0x5]
    SMLSL2 V2.2D, V19.4S, V24.S[0x0]
    SMLSL2 V29.4S, V2.8H, V2.H[0x3]
    SRHADD  V10.16B, V23.16B, V23.16B
    SADDLV  D17, V10.4S
    SMULL2  V11.2D, V17.4S, V29.4S
    SMLSL V24.4S, V20.4H, V1.H[0x2]
    SQSHRUN V17.4H, V1.4S, #10
    SQDMULL S26, H27, V14.H[0x3]
    SQDMLAL2  V2.4S, V23.8H, V30.8H
    SQADD  V5.16B, V12.16B, V14.16B
    SQRDMULH H23, H26, V7.H[0x3]
    SABD  V20.8B, V28.8B, V8.8B
    SQDMLSL2  V8.2D, V1.4S, V18.4S
    SMULL  V1.2D, V6.2S, V21.2S
    SMLAL2  V25.8H, V11.16B, V1.16B
    SQADD  V29.8B, V20.8B, V24.8B
    SQDMULL S3, H8, V5.H[0x6]
    SQSHRUN V25.2S, V25.2D, #13
    SSHR  V11.8B, V17.8B, #1
    SQSHL  V5.8B, V29.8B, #0x3
    SQDMLSL V28.2D, V29.2S, V25.S[0x2]
    SQRSHRN2 V19.4S, V2.2D, #26
    SMULL2 V10.2D, V0.4S, V19.S[0x1]
    SQRSHRN2 V14.8H, V10.4S, #3
    SMLAL  V2.2D, V14.2S, V5.2S
    SXTL2 V8.2D, V31.4S
    SRSHL  V1.2S, V7.2S, V2.2S
    SQRSHRN V17.4H, V23.4S, #1
    SQDMLSL V14.2D, V11.2S, V11.S[0x2]
    SQXTN  V20.8B, V3.8H
    SQSHL  V2.4S, V8.4S, #0x9
    SQSHLU  V23.4S, V28.4S, #0x10
    SQDMLAL D3, S17, V1.S[0x3]
    SQDMLAL D24, S3, V3.S[0x2]
    SQDMULL2  V5.2D, V20.4S, V24.4S
    SQSHRUN V10.8B, V2.8H, #1
    SSHLL2 V29.4S, V25.8H, #0x5
    SQDMULH  V24.2S, V14.2S, V5.2S
    SQXTN2  V14.16B, V14.8H
    SABD  V8.8H, V23.8H, V10.8H
    SMLAL  V10.2D, V8.2S, V29.2S
    SRHADD  V31.16B, V24.16B, V10.16B
    SQDMULL S2, H14, V12.H[0x0]
    SQDMLSL2  V12.2D, V2.4S, V0.4S
    SSHLL V5.2D, V31.2S, #0x10
    SQSHRN2 V11.16B, V12.8H, #5
    SQDMULL2  V10.4S, V11.8H, V11.8H
    SMOV  X19, V10.B[0x8]
    SQRSHRUN V20.2S, V5.2D, #32
    SSHL  V1.2S, V6.2S, V1.2S
    SSUBW2  V25.8H, V25.8H, V22.16B
    SSRA  V12.4S, V11.4S, #23
    SQADD  V31.8B, V1.8B, V1.8B
    SQSHRN2 V3.8H, V2.4S, #7
    SMLAL V1.4S, V13.4H, V5.H[0x6]
    SQDMULL2  V11.4S, V12.8H, V30.8H
    SQABS  V10.16B, V23.16B
    SMLSL  V13.2D, V5.2S, V19.2S
    SRSHR  V6.2S, V31.2S, #11
    SMLAL V22.4S, V10.4H, V9.H[0x4]
    SQDMLAL V28.2D, V30.2S, V6.S[0x1]
    SQRDMULH  V19.4H, V18.4H, V10.H[0x3]
    SQSHRN V10.4H, V19.4S, #15
    SADDLV  S0, V10.4H
    SABD  V30.4H, V13.4H, V13.4H
    SQABS  V14.16B, V0.16B
    SQSHRUN2 V29.16B, V1.8H, #6
    SQSHRN2 V18.4S, V22.2D, #26
    SABAL  V13.2D, V3.2S, V28.2S
    SMULL V3.2D, V25.2S, V13.S[0x1]
    SQADD  V19.8B, V11.8B, V14.8B
    SQDMULL2  V5.2D, V3.4S, V30.4S
    SQDMULL V31.4S, V20.4H, V10.H[0x1]
    SMULL V6.4S, V29.4H, V3.H[0x4]
    SHADD  V25.8B, V6.8B, V5.8B
    SQSHLU  V22.4H, V18.4H, #0xd
    SQRSHRUN2 V0.4S, V22.2D, #8
    SQSHL  V9.4H, V0.4H, #0xe
    SQDMLSL V0.4S, V19.4H, V9.H[0x0]
    SRSHL  V30.2D, V0.2D, V0.2D
    SSHLL2 V29.8H, V31.16B, #0x6
    SQDMLSL V31.2D, V25.2S, V29.S[0x0]
    SQRSHRUN V1.8B, V30.8H, #8
    SMLAL V13.4S, V22.4H, V1.H[0x7]
    SMULL2  V30.8H, V26.16B, V13.16B
    SABDL2  V9.8H, V30.16B, V30.16B
    SMULL2 V3.4S, V31.8H, V9.H[0x1]
    SQSHL  V19.8H, V30.8H, #0x2
    SQSHRUN V6.2S, V20.2D, #11
    SQDMLSL S26, H21, V4.H[0x1]
    SRSHR V28.2D, V21.2D, #32
    SRSHR  V5.2S, V22.2S, #2
    SADDLV  H13, V25.16B
    SQXTUN  V18.8B, V7.8H
    SSRA  V20.8B, V8.8B, #6
    SMLSL2 V9.4S, V6.8H, V3.H[0x2]
    SRSHL  V25.8B, V11.8B, V19.8B
    SQSHL V21.2D, V25.2D, #0x3c
    SMLAL V10.4S, V26.4H, V15.H[0x6]
    SQSHLU V19.2D, V21.2D, #0xb
    SMLAL V8.2D, V19.2S, V19.S[0x3]
    SQDMULH  V22.4H, V13.4H, V8.H[0x2]
    SMLSL  V26.8H, V18.8B, V22.8B
    SQDMLSL  V30.2D, V10.2S, V28.2S
    SQABS  V19.16B, V26.16B
    SQSHRUN V4.8B, V5.8H, #5
    SRSRA V18.2D, V2.2D, #12
    SQSHL V22.2D, V20.2D, #0x3c
    SQDMLSL2 V8.4S, V4.8H, V8.H[0x3]
    SQSHL  V21.8B, V19.8B, V18.8B
    SQDMLAL S2, H30, V9.H[0x5]
    SQSHL V15.2D, V22.2D, #0x23
    SQDMULL2 V26.2D, V8.4S, V15.S[0x2]
    SQDMLAL D18, S2, V2.S[0x1]
    SSUBL2  V9.8H, V18.16B, V18.16B
    SQDMULL2  V7.2D, V21.4S, V21.4S
    SABA  V31.16B, V7.16B, V7.16B
    SQDMLAL V11.2D, V26.2S, V26.S[0x0]
    SSHLL V10.8H, V11.8B, #0x6
    SMULL V11.2D, V10.2S, V9.S[0x1]
    SQDMLSL V26.4S, V11.4H, V4.H[0x0]
    SQSHLU V18.2D, V26.2D, #0x4
    SMLAL V28.2D, V31.2S, V28.S[0x1]
    SQRDMULH S13, S13, V28.S[0x1]
    SMULL2  V7.4S, V18.8H, V13.8H
    SMLAL V5.4S, V17.4H, V11.H[0x5]
    SQXTUN  V19.8B, V12.8H
    SRSRA  V11.4S, V29.4S, #4
    SQSHRN V26.2S, V7.2D, #6
    SQSHRN2 V31.8H, V10.4S, #6
    SXTL V10.2D, V8.2S
    SQRSHRN2 V15.4S, V21.2D, #28
    SQRDMULH S18, S7, V0.S[0x1]
    SSHLL2 V7.8H, V5.16B, #0x7
    SSHL  V29.4S, V22.4S, V14.4S
    SABAL2  V2.4S, V26.8H, V29.8H
    SQSHRN V12.4H, V18.4S, #7
    SABAL  V17.2D, V10.2S, V12.2S
    SQRDMULH H8, H19, V11.H[0x5]
    SMLAL2 V9.2D, V31.4S, V26.S[0x0]
    SQDMULH  V13.4S, V17.4S, V15.S[0x2]
    SSHR  V28.4H, V7.4H, #15
    SQDMULH H0, H2, V2.H[0x6]
    SSUBW  V19.2D, V8.2D, V8.2S
    SQSHRN V21.4H, V3.4S, #11
    SMOV  X4, V13.H[0x6]
    SSHLL2 V10.8H, V21.16B, #0x3
    SSUBW  V8.4S, V10.4S, V28.4H
    SQSHRN2 V10.16B, V8.8H, #6
    SQDMULH S21, S13, V10.S[0x3]
    SQABS  V31.16B, V9.16B
    SQDMULL2  V17.2D, V0.4S, V19.4S
    SMLAL  V26.4S, V31.4H, V17.4H
    SMLAL2  V22.4S, V26.8H, V21.8H
    SQSHL  V10.8H, V9.8H, #0x1
    SABDL2  V7.8H, V30.16B, V26.16B
    SABDL  V12.4S, V14.4H, V13.4H
    SQRDMULH  V18.2S, V25.2S, V15.S[0x1]
    SMULL2 V31.4S, V6.8H, V9.H[0x7]
    SQDMULL D26, S11, V31.S[0x2]
    SQRSHRN2 V3.8H, V26.4S, #16
    SSHLL2 V2.8H, V0.16B, #0x6
    SQRDMULH  V15.8H, V23.8H, V13.H[0x4]
    SMLAL2 V13.4S, V22.8H, V14.H[0x2]
    SABA  V21.4S, V21.4S, V3.4S
    SQDMLAL  V19.2D, V6.2S, V27.2S
    SRSHR  V8.16B, V26.16B, #1
    SQDMLAL2 V9.2D, V7.4S, V13.S[0x1]
    SQRSHRUN2 V22.8H, V19.4S, #10
    SQDMULL V6.4S, V21.4H, V10.H[0x0]
    SQDMLSL V11.4S, V0.4H, V9.H[0x6]
    SMLSL2 V27.4S, V12.8H, V6.H[0x7]
    SXTL V30.4S, V22.4H
    SMLAL V17.2D, V18.2S, V30.S[0x1]
    SQDMLAL V6.4S, V2.4H, V8.H[0x2]
    SUBS  X15, X15, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_19
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x800, LSL #16
    MRS  X14, FPSR
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D1
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D3
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D8
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D9
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D10
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D11
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D12
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D19
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D20
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D22
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X14, D31
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSignedOperation_TestFail
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
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X17
    FMOV  D3, X7
    FMOV  V3.D[1], X25
    FMOV  D4, X14
    FMOV  V4.D[1], X5
    FMOV  D5, X13
    FMOV  V5.D[1], X18
    FMOV  D6, X21
    FMOV  V6.D[1], X18
    FMOV  D7, X12
    FMOV  V7.D[1], X12
    FMOV  D8, X17
    FMOV  V8.D[1], X28
    FMOV  D9, X3
    FMOV  V9.D[1], X10
    FMOV  D10, X14
    FMOV  V10.D[1], X3
    FMOV  D11, X20
    FMOV  V11.D[1], X28
    FMOV  D12, X18
    FMOV  V12.D[1], X3
    FMOV  D13, X19
    FMOV  V13.D[1], X26
    FMOV  D14, X28
    FMOV  V14.D[1], X12
    FMOV  D15, X17
    FMOV  V15.D[1], X11
    FMOV  D16, X15
    FMOV  V16.D[1], X21
    FMOV  D17, X17
    FMOV  V17.D[1], X4
    FMOV  D18, X10
    FMOV  V18.D[1], X7
    FMOV  D19, X28
    FMOV  V19.D[1], X18
    FMOV  D20, X20
    FMOV  V20.D[1], X15
    FMOV  D21, X10
    FMOV  V21.D[1], X12
    FMOV  D22, X6
    FMOV  V22.D[1], X17
    FMOV  D23, X15
    FMOV  V23.D[1], X10
    FMOV  D24, X20
    FMOV  V24.D[1], X6
    FMOV  D25, X21
    FMOV  V25.D[1], X23
    FMOV  D26, X7
    FMOV  V26.D[1], X23
    FMOV  D27, X16
    FMOV  V27.D[1], X12
    FMOV  D28, X12
    FMOV  V28.D[1], X7
    FMOV  D29, X3
    FMOV  V29.D[1], X22
    FMOV  D30, X10
    FMOV  V30.D[1], X29
    FMOV  D31, X13
    FMOV  V31.D[1], X28
    MOVZ  X5, #0xf, LSL #0
TSRTAdvsimdVectorSignedOperation_label_20:
    SMLAL V19.4S, V29.4H, V1.H[0x6]
    SQDMULL V30.4S, V19.4H, V11.H[0x2]
    SQDMLSL S21, H31, V14.H[0x6]
    SQDMLSL  V21.4S, V21.4H, V30.4H
    SABD  V26.4H, V25.4H, V22.4H
    SSHLL V26.2D, V28.2S, #0x1c
    SQSHL  V23.4H, V27.4H, #0x0
    SQSHRN2 V6.8H, V21.4S, #3
    SQXTN2  V16.4S, V26.2D
    SRSHR  V12.4H, V16.4H, #10
    SQSHRN V11.8B, V12.8H, #5
    SXTL V16.8H, V11.8B
    SSUBW2  V20.4S, V6.4S, V23.8H
    SQDMULL  V29.2D, V20.2S, V20.2S
    SRSHR  V25.16B, V29.16B, #1
    SQDMULH S26, S25, V23.S[0x1]
    SXTL V7.2D, V26.2S
    SRHADD  V23.16B, V7.16B, V16.16B
    SQSHLU  V10.2S, V24.2S, #0x7
    SQDMULL V25.4S, V0.4H, V14.H[0x5]
    SSHLL2 V7.4S, V15.8H, #0x1
    SQDMLSL2 V30.4S, V27.8H, V12.H[0x3]
    SSHLL V6.4S, V21.4H, #0x7
    SMLSL2 V0.2D, V13.4S, V31.S[0x0]
    SQSHRUN2 V11.4S, V30.2D, #27
    SQRSHRN2 V20.4S, V9.2D, #29
    SMLAL2  V24.8H, V18.16B, V25.16B
    SQDMULL S29, H9, V14.H[0x7]
    SRHADD  V15.16B, V31.16B, V4.16B
    SQDMULL  V19.2D, V7.2S, V23.2S
    SQDMULL V28.2D, V29.2S, V10.S[0x1]
    SADDLV  S22, V28.8H
    SQDMLAL2  V30.2D, V6.4S, V6.4S
    SQDMLAL2  V13.2D, V24.4S, V30.4S
    SQSHL  V9.4H, V25.4H, V22.4H
    SADDW2  V18.8H, V13.8H, V11.16B
    SQDMLAL D12, S19, V0.S[0x2]
    SQDMLAL2 V26.2D, V9.4S, V9.S[0x0]
    SSHR  V21.4H, V20.4H, #14
    SADALP  V16.4S, V11.8H
    SSUBW2  V13.8H, V12.8H, V16.16B
    SQDMLSL D14, S26, V15.S[0x1]
    SMULL2 V6.4S, V6.8H, V9.H[0x7]
    SQRSHRUN2 V31.8H, V18.4S, #6
    SMOV  X14, V21.B[0x6]
    SSRA  V24.4S, V31.4S, #29
    SQABS  V15.2S, V13.2S
    SADDL  V11.2D, V24.2S, V14.2S
    SQSUB  V27.4S, V11.4S, V15.4S
    SQDMLAL D22, S6, V6.S[0x0]
    SMOV  X14, V27.B[0x4]
    SXTL V7.4S, V6.4H
    SMOV W26, V10.B[0xd]
    SXTL V12.4S, V21.4H
    SRHADD  V27.8H, V21.8H, V20.8H
    SMLAL V19.2D, V15.2S, V21.S[0x2]
    SQRDMULH  V6.8H, V8.8H, V12.H[0x4]
    SQRSHRN2 V15.8H, V13.4S, #1
    SMLAL2 V21.4S, V15.8H, V10.H[0x4]
    SQDMLSL D26, S30, V6.S[0x0]
    SQRSHRUN2 V31.8H, V28.4S, #16
    SQSHRN V11.4H, V14.4S, #16
    SQDMLAL V20.4S, V1.4H, V12.H[0x2]
    SMLAL2  V8.2D, V19.4S, V19.4S
    SQRSHRUN2 V28.8H, V7.4S, #8
    SQDMLSL  V10.4S, V27.4H, V26.4H
    SRHADD  V13.4H, V28.4H, V21.4H
    SRHADD  V24.4S, V31.4S, V22.4S
    SQRSHRN2 V15.4S, V10.2D, #19
    SABAL  V10.8H, V13.8B, V11.8B
    SQSHRUN V28.4H, V15.4S, #8
    SQDMULH  V15.2S, V20.2S, V21.S[0x1]
    SQDMULH H13, H21, V8.H[0x5]
    SQRDMULH S8, S10, V24.S[0x0]
    SQSHLU V30.2D, V8.2D, #0x0
    SADDLP  V11.8H, V28.16B
    SSRA  V24.8H, V0.8H, #11
    SQDMULH  V8.8H, V24.8H, V24.8H
    SQDMLSL2 V12.4S, V8.8H, V13.H[0x3]
    SQDMLAL2  V0.4S, V12.8H, V30.8H
    SQRSHRUN2 V6.16B, V11.8H, #8
    SSHLL V28.4S, V12.4H, #0x6
    SMLAL2 V20.2D, V28.4S, V0.S[0x2]
    SQSHRUN V26.2S, V6.2D, #31
    SMOV  X4, V20.H[0x7]
    SQADD  V28.2S, V26.2S, V15.2S
    SMOV W24, V20.B[0x5]
    SSHR  V20.8B, V10.8B, #2
    SMLAL V11.2D, V4.2S, V7.S[0x3]
    SXTL V21.8H, V18.8B
    SQSHRUN V10.8B, V1.8H, #3
    SQXTN2  V30.16B, V10.8H
    SMLSL2 V31.4S, V6.8H, V3.H[0x7]
    SQRDMULH  V0.4H, V22.4H, V14.H[0x4]
    SSHR  V10.4S, V10.4S, #27
    SUQADD  V8.16B, V10.16B
    SQRSHRN V15.8B, V27.8H, #2
    SQSHRN V14.2S, V0.2D, #31
    SADDW2  V24.2D, V15.2D, V28.4S
    SQDMLAL V15.2D, V14.2S, V11.S[0x0]
    SQRSHRUN2 V26.8H, V21.4S, #15
    SADALP  V21.8H, V15.16B
    SADALP  V18.8H, V0.16B
    SMOV W14, V20.B[0x4]
    SSUBW2  V1.8H, V30.8H, V24.16B
    SADDLV  H7, V18.16B
    SRSHL  V18.8B, V8.8B, V9.8B
    SABAL2  V15.2D, V7.4S, V26.4S
    SRSRA  V10.4S, V1.4S, #2
    SUQADD  V3.4S, V31.4S
    SQRSHL  V31.2S, V10.2S, V21.2S
    SSHLL2 V22.8H, V18.16B, #0x2
    SMULL2  V28.8H, V22.16B, V15.16B
    SQRDMULH S27, S31, V28.S[0x0]
    SRSHL  V9.4S, V27.4S, V3.4S
    SADDLV  H11, V5.8B
    SQSHRUN2 V8.8H, V12.4S, #14
    SMULL  V30.4S, V25.4H, V5.4H
    SQRSHRUN2 V27.4S, V17.2D, #3
    SQSHLU  V28.4S, V19.4S, #0x6
    SMULL2 V22.4S, V29.8H, V4.H[0x3]
    SQDMULL2 V25.2D, V28.4S, V22.S[0x3]
    SQRSHRN V18.4H, V7.4S, #6
    SQSHL  V3.8H, V7.8H, V8.8H
    SQDMLSL2 V31.2D, V11.4S, V30.S[0x2]
    SADDLV  H8, V9.8B
    SQSHL V0.2D, V18.2D, #0x3f
    SQDMULL V18.2D, V6.2S, V21.S[0x2]
    SMLSL  V30.2D, V18.2S, V14.2S
    SMULL2  V29.8H, V31.16B, V1.16B
    SSRA  V6.16B, V24.16B, #3
    SQDMULL V22.2D, V23.2S, V23.S[0x3]
    SRSHR V31.2D, V8.2D, #37
    SSHR  V11.2S, V27.2S, #10
    SSHR  V1.4S, V11.4S, #22
    SQRSHRN2 V24.4S, V2.2D, #22
    SQRSHRUN V19.8B, V24.8H, #5
    SQDMULL2 V11.2D, V0.4S, V30.S[0x3]
    SMLAL2 V15.4S, V29.8H, V1.H[0x5]
    SMLSL2 V12.2D, V15.4S, V5.S[0x1]
    SQSHRUN2 V2.4S, V25.2D, #32
    SADDL  V7.2D, V12.2S, V11.2S
    SXTL2 V9.4S, V19.8H
    SQSHRN2 V27.8H, V2.4S, #12
    SMULL2 V4.2D, V3.4S, V7.S[0x3]
    SQSHRUN V8.2S, V6.2D, #9
    SQNEG  V5.2D, V9.2D
    SSHLL2 V24.8H, V27.16B, #0x4
    SSHLL2 V3.2D, V24.4S, #0x10
    SQDMULH  V11.4H, V31.4H, V8.H[0x4]
    SSHR  V1.4H, V5.4H, #3
    SMOV  X7, V4.B[0x8]
    SMLSL2 V4.4S, V22.8H, V3.H[0x1]
    SSHR  V7.8H, V4.8H, #9
    SQRSHRN2 V19.16B, V7.8H, #5
    SQDMLAL2 V4.4S, V1.8H, V1.H[0x6]
    SQDMULH  V6.4S, V4.4S, V4.S[0x1]
    SQDMULH  V4.2S, V6.2S, V6.2S
    SMLAL V24.4S, V19.4H, V4.H[0x7]
    SQSHRN2 V7.8H, V11.4S, #12
    SSRA V11.2D, V7.2D, #2
    SQDMULH H8, H11, V11.H[0x3]
    SRSRA V6.2D, V24.2D, #5
    SQXTN  V9.8B, V8.8H
    SMLSL  V11.2D, V9.2S, V6.2S
    SQDMULH H1, H17, V11.H[0x3]
    SQSHL  V19.8B, V25.8B, #0x3
    SRSRA  V24.2S, V24.2S, #28
    SRSRA  V11.8H, V24.8H, #7
    SADDLV  D5, V25.4S
    SQRSHRN2 V4.4S, V5.2D, #6
    SUQADD  V7.16B, V15.16B
    SQRSHRN2 V24.8H, V5.4S, #11
    SQSHRUN2 V17.8H, V0.4S, #15
    SABDL2  V0.4S, V5.8H, V5.8H
    SMLSL2 V27.4S, V28.8H, V7.H[0x5]
    SQDMLAL  V31.4S, V3.4H, V24.4H
    SADDLV  H5, V21.8B
    SRSHR  V24.16B, V5.16B, #5
    SMULL2  V9.8H, V11.16B, V1.16B
    SSRA V11.2D, V4.2D, #35
    SQDMLAL2 V3.4S, V31.8H, V14.H[0x1]
    SQRSHRN2 V4.8H, V17.4S, #14
    SQDMULL2  V25.4S, V9.8H, V24.8H
    SSRA V7.2D, V3.2D, #45
    SQRSHRUN2 V1.16B, V19.8H, #1
    SABA  V28.16B, V27.16B, V4.16B
    SQRSHRUN V15.4H, V1.4S, #4
    SQDMLSL2 V21.4S, V28.8H, V7.H[0x0]
    SQDMLAL2 V7.2D, V25.4S, V25.S[0x2]
    SQDMULL2 V14.4S, V7.8H, V15.H[0x7]
    SHADD  V5.4S, V21.4S, V14.4S
    SQRSHRUN V6.2S, V11.2D, #8
    SSUBL2  V8.4S, V0.8H, V0.8H
    SSUBL2  V7.2D, V8.4S, V5.4S
    SQNEG  V8.8B, V7.8B
    SQDMLAL V7.2D, V8.2S, V8.S[0x0]
    SQSHLU V28.2D, V6.2D, #0x23
    SQDMULL S3, H28, V7.H[0x5]
    SSHLL2 V15.4S, V1.8H, #0xa
    SUBS  X5, X5, #0x1
    B.NE  TSRTAdvsimdVectorSignedOperation_label_20
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x800, LSL #16
    MRS  X25, FPSR
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X25, D2
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D5
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X25, D17
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D24
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    FMOV  X25, V27.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X19, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSignedOperation_TestFail

TSRTAdvsimdVectorSignedOperation_TestEnd:
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
TSRTAdvsimdVectorSignedOperation_TestFail:
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
