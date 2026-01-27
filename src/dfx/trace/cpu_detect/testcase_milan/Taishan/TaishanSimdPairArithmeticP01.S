.global TaishanSimdPairArithmeticP01

.text
.p2align 4

TaishanSimdPairArithmeticP01:

TaishanSimdPairArithmeticP01_TestBegin:
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
    MOVK  X2, #0xb024, LSL #48
    MOVK  X2, #0x6cfd, LSL #32
    MOVK  X2, #0x9918, LSL #16
    MOVK  X2, #0xd449, LSL #0
    MOVK  X3, #0xeb29, LSL #48
    MOVK  X3, #0x8e4a, LSL #32
    MOVK  X3, #0xc7c7, LSL #16
    MOVK  X3, #0x7703, LSL #0
    MOVK  X4, #0x533c, LSL #48
    MOVK  X4, #0x5dd6, LSL #32
    MOVK  X4, #0x8bc4, LSL #16
    MOVK  X4, #0xfd41, LSL #0
    MOVK  X5, #0xa512, LSL #48
    MOVK  X5, #0x11e8, LSL #32
    MOVK  X5, #0xf97f, LSL #16
    MOVK  X5, #0xe64e, LSL #0
    MOVK  X6, #0x7a91, LSL #48
    MOVK  X6, #0x74c1, LSL #32
    MOVK  X6, #0xfa17, LSL #16
    MOVK  X6, #0x229c, LSL #0
    MOVK  X7, #0xfcb4, LSL #48
    MOVK  X7, #0xaf59, LSL #32
    MOVK  X7, #0xd626, LSL #16
    MOVK  X7, #0xba33, LSL #0
    MOVK  X8, #0xd579, LSL #48
    MOVK  X8, #0x32c1, LSL #32
    MOVK  X8, #0x9c9c, LSL #16
    MOVK  X8, #0xde5b, LSL #0
    MOVK  X10, #0x5eac, LSL #48
    MOVK  X10, #0xfa07, LSL #32
    MOVK  X10, #0x62a3, LSL #16
    MOVK  X10, #0xc73e, LSL #0
    MOVK  X11, #0xd5d0, LSL #48
    MOVK  X11, #0x6dd1, LSL #32
    MOVK  X11, #0x60ff, LSL #16
    MOVK  X11, #0x1d1, LSL #0
    MOVK  X12, #0xce04, LSL #48
    MOVK  X12, #0x7e77, LSL #32
    MOVK  X12, #0xf1da, LSL #16
    MOVK  X12, #0x9686, LSL #0
    MOVK  X13, #0x347d, LSL #48
    MOVK  X13, #0x69f8, LSL #32
    MOVK  X13, #0x28a4, LSL #16
    MOVK  X13, #0x2b, LSL #0
    MOVK  X14, #0xbb58, LSL #48
    MOVK  X14, #0x83ba, LSL #32
    MOVK  X14, #0x3418, LSL #16
    MOVK  X14, #0x512e, LSL #0
    MOVK  X15, #0x3690, LSL #48
    MOVK  X15, #0xbca4, LSL #32
    MOVK  X15, #0xbdb6, LSL #16
    MOVK  X15, #0x916b, LSL #0
    MOVK  X16, #0x8f1d, LSL #48
    MOVK  X16, #0xc4c9, LSL #32
    MOVK  X16, #0x3b6, LSL #16
    MOVK  X16, #0x27ba, LSL #0
    MOVK  X17, #0xd770, LSL #48
    MOVK  X17, #0xb83f, LSL #32
    MOVK  X17, #0xf51e, LSL #16
    MOVK  X17, #0xae50, LSL #0
    MOVK  X18, #0x141b, LSL #48
    MOVK  X18, #0x69b9, LSL #32
    MOVK  X18, #0x5bf1, LSL #16
    MOVK  X18, #0xeaa1, LSL #0
    MOVK  X19, #0xa5c3, LSL #48
    MOVK  X19, #0xadaa, LSL #32
    MOVK  X19, #0xc96, LSL #16
    MOVK  X19, #0xb673, LSL #0
    MOVK  X20, #0xb143, LSL #48
    MOVK  X20, #0xe7de, LSL #32
    MOVK  X20, #0x6211, LSL #16
    MOVK  X20, #0x6f07, LSL #0
    MOVK  X21, #0xd1e1, LSL #48
    MOVK  X21, #0x36b1, LSL #32
    MOVK  X21, #0x7dc2, LSL #16
    MOVK  X21, #0xd7ea, LSL #0
    MOVK  X22, #0x9d4c, LSL #48
    MOVK  X22, #0x3300, LSL #32
    MOVK  X22, #0xa3fb, LSL #16
    MOVK  X22, #0xab82, LSL #0
    MOVK  X23, #0xeec1, LSL #48
    MOVK  X23, #0x8a57, LSL #32
    MOVK  X23, #0x37a9, LSL #16
    MOVK  X23, #0xf628, LSL #0
    MOVK  X24, #0xba50, LSL #48
    MOVK  X24, #0x4db9, LSL #32
    MOVK  X24, #0xdc58, LSL #16
    MOVK  X24, #0xe5b7, LSL #0
    MOVK  X25, #0x6581, LSL #48
    MOVK  X25, #0x48e6, LSL #32
    MOVK  X25, #0xd2dc, LSL #16
    MOVK  X25, #0xb7b0, LSL #0
    MOVK  X26, #0x144b, LSL #48
    MOVK  X26, #0x21b, LSL #32
    MOVK  X26, #0xaa9c, LSL #16
    MOVK  X26, #0x42e0, LSL #0
    MOVK  X27, #0x2357, LSL #48
    MOVK  X27, #0xb569, LSL #32
    MOVK  X27, #0x908b, LSL #16
    MOVK  X27, #0x74bb, LSL #0
    MOVK  X28, #0x2584, LSL #48
    MOVK  X28, #0x9420, LSL #32
    MOVK  X28, #0xd80f, LSL #16
    MOVK  X28, #0x1a08, LSL #0
    MOVK  X29, #0x8878, LSL #48
    MOVK  X29, #0x5da5, LSL #32
    MOVK  X29, #0xd08e, LSL #16
    MOVK  X29, #0x2826, LSL #0
    ANDS  W14, W2, #0x1fc0000
    MOVZ  X7, #0xdd22, LSL #0
    MOVK  X7, #0xc2b, LSL #16
    MSR  FPCR, X7
    MRS  X28, FPSR
    MOVZ  X23, #0xff60, LSL #0
    MOVK  X23, #0x7ff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    AND  X28, X28, X23
    MOVZ  X23, #0x0, LSL #0
    ORR  X28, X28, X23
    MSR  FPSR, X28
    ISB  SY
    MOVZ  X2, #0x3304, LSL #0
    MOVK  X2, #0xa28e, LSL #16
    MOVK  X2, #0xaf38, LSL #32
    MOVK  X2, #0xdb0b, LSL #48
    MOVZ  X3, #0xb930, LSL #0
    MOVK  X3, #0x1ef7, LSL #16
    MOVK  X3, #0x4dd7, LSL #32
    MOVK  X3, #0x2c16, LSL #48
    MOVZ  X4, #0x278c, LSL #0
    MOVK  X4, #0x72c8, LSL #16
    MOVK  X4, #0x1550, LSL #32
    MOVK  X4, #0x47bb, LSL #48
    MOVZ  X5, #0xf536, LSL #0
    MOVK  X5, #0x6c70, LSL #16
    MOVK  X5, #0xbe77, LSL #32
    MOVK  X5, #0xeeb5, LSL #48
    MOVZ  X6, #0x6a82, LSL #0
    MOVK  X6, #0x9da1, LSL #16
    MOVK  X6, #0x45c3, LSL #32
    MOVK  X6, #0x29e7, LSL #48
    MOVZ  X7, #0xe05f, LSL #0
    MOVK  X7, #0xe6a5, LSL #16
    MOVK  X7, #0x75e4, LSL #32
    MOVK  X7, #0x9f33, LSL #48
    MOVZ  X8, #0xcc2d, LSL #0
    MOVK  X8, #0x72f3, LSL #16
    MOVK  X8, #0xc1a1, LSL #32
    MOVK  X8, #0xda8f, LSL #48
    MOVZ  X10, #0xbe9d, LSL #0
    MOVK  X10, #0x394a, LSL #16
    MOVK  X10, #0x9a50, LSL #32
    MOVK  X10, #0xe6c6, LSL #48
    MOVZ  X11, #0xe6ce, LSL #0
    MOVK  X11, #0x211a, LSL #16
    MOVK  X11, #0xb8a8, LSL #32
    MOVK  X11, #0xd62b, LSL #48
    MOVZ  X12, #0x4031, LSL #0
    MOVK  X12, #0x5eae, LSL #16
    MOVK  X12, #0x4ddc, LSL #32
    MOVK  X12, #0x9810, LSL #48
    MOVZ  X13, #0xf223, LSL #0
    MOVK  X13, #0xa8a1, LSL #16
    MOVK  X13, #0x36b1, LSL #32
    MOVK  X13, #0xffda, LSL #48
    MOVZ  X14, #0xca4c, LSL #0
    MOVK  X14, #0x1a43, LSL #16
    MOVK  X14, #0xf80e, LSL #32
    MOVK  X14, #0xb473, LSL #48
    MOVZ  X15, #0x7381, LSL #0
    MOVK  X15, #0x27e0, LSL #16
    MOVK  X15, #0x3a71, LSL #32
    MOVK  X15, #0xd7f2, LSL #48
    MOVZ  X16, #0x6725, LSL #0
    MOVK  X16, #0x3307, LSL #16
    MOVK  X16, #0xccb6, LSL #32
    MOVK  X16, #0x875c, LSL #48
    MOVZ  X17, #0x8a37, LSL #0
    MOVK  X17, #0x2e77, LSL #16
    MOVK  X17, #0x355b, LSL #32
    MOVK  X17, #0x6431, LSL #48
    MOVZ  X18, #0x5e2, LSL #0
    MOVK  X18, #0x9215, LSL #16
    MOVK  X18, #0x36ab, LSL #32
    MOVK  X18, #0x5ed9, LSL #48
    MOVZ  X19, #0x44d2, LSL #0
    MOVK  X19, #0x9833, LSL #16
    MOVK  X19, #0x77a4, LSL #32
    MOVK  X19, #0x2080, LSL #48
    MOVZ  X20, #0xceb9, LSL #0
    MOVK  X20, #0xa18b, LSL #16
    MOVK  X20, #0xbd69, LSL #32
    MOVK  X20, #0xdb70, LSL #48
    MOVZ  X21, #0xe8b5, LSL #0
    MOVK  X21, #0xab0, LSL #16
    MOVK  X21, #0xeac, LSL #32
    MOVK  X21, #0x7f01, LSL #48
    MOVZ  X22, #0xf793, LSL #0
    MOVK  X22, #0x4657, LSL #16
    MOVK  X22, #0x9ad4, LSL #32
    MOVK  X22, #0x727, LSL #48
    MOVZ  X23, #0xa910, LSL #0
    MOVK  X23, #0xcb5a, LSL #16
    MOVK  X23, #0xc5c3, LSL #32
    MOVK  X23, #0x280f, LSL #48
    MOVZ  X24, #0x2427, LSL #0
    MOVK  X24, #0x3056, LSL #16
    MOVK  X24, #0x9a4b, LSL #32
    MOVK  X24, #0x35ad, LSL #48
    MOVZ  X25, #0xa14e, LSL #0
    MOVK  X25, #0x8547, LSL #16
    MOVK  X25, #0xc9f6, LSL #32
    MOVK  X25, #0x8679, LSL #48
    MOVZ  X26, #0xd65f, LSL #0
    MOVK  X26, #0x1029, LSL #16
    MOVK  X26, #0x49fb, LSL #32
    MOVK  X26, #0x16ed, LSL #48
    MOVZ  X27, #0xf291, LSL #0
    MOVK  X27, #0x5dd7, LSL #16
    MOVK  X27, #0xd199, LSL #32
    MOVK  X27, #0x90ae, LSL #48
    MOVZ  X28, #0xace0, LSL #0
    MOVK  X28, #0xb097, LSL #16
    MOVK  X28, #0xb719, LSL #32
    MOVK  X28, #0xef1c, LSL #48
    MOVZ  X29, #0x958, LSL #0
    MOVK  X29, #0xe2cd, LSL #16
    MOVK  X29, #0x2e15, LSL #32
    MOVK  X29, #0x4221, LSL #48
    FMOV  D0, X3
    FMOV  V0.D[1], X13
    FMOV  D1, X15
    FMOV  V1.D[1], X25
    FMOV  D2, X16
    FMOV  V2.D[1], X3
    FMOV  D3, X22
    FMOV  V3.D[1], X17
    FMOV  D4, X29
    FMOV  V4.D[1], X26
    FMOV  D5, X26
    FMOV  V5.D[1], X12
    FMOV  D6, X15
    FMOV  V6.D[1], X25
    FMOV  D7, X4
    FMOV  V7.D[1], X22
    FMOV  D8, X4
    FMOV  V8.D[1], X12
    FMOV  D9, X15
    FMOV  V9.D[1], X7
    FMOV  D10, X18
    FMOV  V10.D[1], X25
    FMOV  D11, X12
    FMOV  V11.D[1], X15
    FMOV  D12, X28
    FMOV  V12.D[1], X4
    FMOV  D13, X21
    FMOV  V13.D[1], X26
    FMOV  D14, X28
    FMOV  V14.D[1], X14
    FMOV  D15, X22
    FMOV  V15.D[1], X11
    FMOV  D16, X27
    FMOV  V16.D[1], X5
    FMOV  D17, X4
    FMOV  V17.D[1], X4
    FMOV  D18, X24
    FMOV  V18.D[1], X15
    FMOV  D19, X12
    FMOV  V19.D[1], X15
    FMOV  D20, X28
    FMOV  V20.D[1], X24
    FMOV  D21, X24
    FMOV  V21.D[1], X26
    FMOV  D22, X17
    FMOV  V22.D[1], X6
    FMOV  D23, X7
    FMOV  V23.D[1], X13
    FMOV  D24, X26
    FMOV  V24.D[1], X12
    FMOV  D25, X20
    FMOV  V25.D[1], X15
    FMOV  D26, X5
    FMOV  V26.D[1], X5
    FMOV  D27, X16
    FMOV  V27.D[1], X4
    FMOV  D28, X22
    FMOV  V28.D[1], X7
    FMOV  D29, X2
    FMOV  V29.D[1], X23
    FMOV  D30, X6
    FMOV  V30.D[1], X17
    FMOV  D31, X26
    FMOV  V31.D[1], X27
    MOVZ  X14, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_0:
    SSHL  V22.8H, V26.8H, V4.8H
    UQADD  D14, D9, D22
    URHADD  V13.2S, V30.2S, V15.2S
    URSHL  D15, D20, D7
    UQSUB  B28, B17, B28
    UQSUB  H16, H17, H4
    USHL  D9, D31, D19
    BIF  V13.16B, V14.16B, V15.16B
    FDIV  V11.2D, V1.2D, V6.2D
    SHSUB  V3.4H, V29.4H, V29.4H
    UHADD  V21.8H, V5.8H, V15.8H
    FMLA  V6.2S, V25.2S, V19.2S
    MOV  V23.16B, V10.16B
    SQADD  V23.4H, V7.4H, V9.4H
    BIF  V18.16B, V27.16B, V16.16B
    AND  V6.16B, V22.16B, V21.16B
    SUB  V2.4S, V28.4S, V10.4S
    ORR  V1.8B, V14.8B, V25.8B
    SQSUB  H30, H2, H17
    SUB  D7, D6, D14
    UQADD  V9.16B, V30.16B, V1.16B
    BIF  V24.16B, V17.16B, V1.16B
    SQSHL  V1.2S, V7.2S, V13.2S
    SQSUB  S3, S29, S15
    AND  V20.8B, V25.8B, V0.8B
    FMULX  D17, D16, D23
    FRSQRTS  S31, S3, S15
    ADD  D12, D10, D10
    BIC  V24.8B, V12.8B, V1.8B
    EOR  V27.8B, V18.8B, V3.8B
    URSHL  D31, D9, D19
    SSHL  V30.8B, V0.8B, V24.8B
    SRSHL  D29, D6, D9
    SQADD  V14.8H, V2.8H, V7.8H
    UMIN  V25.4S, V28.4S, V10.4S
    SRHADD  V17.4H, V2.4H, V11.4H
    EOR  V20.16B, V21.16B, V14.16B
    SQSHL  S1, S30, S17
    USHL  V31.2S, V1.2S, V25.2S
    SQADD  B27, B17, B29
    SABD  V27.4S, V7.4S, V5.4S
    SHSUB  V20.8B, V12.8B, V28.8B
    FRSQRTS  V28.4S, V31.4S, V8.4S
    FMAX  V23.2S, V27.2S, V31.2S
    SQSUB  V4.16B, V20.16B, V30.16B
    URSHL  V4.2D, V1.2D, V6.2D
    UQRSHL  B2, B18, B8
    SQSUB  V6.4H, V6.4H, V4.4H
    SQADD  V11.8B, V24.8B, V10.8B
    ORN  V1.16B, V6.16B, V3.16B
    FMINNM  V1.2S, V15.2S, V10.2S
    MUL  V6.8B, V21.8B, V11.8B
    AND  V24.8B, V21.8B, V9.8B
    SQSUB  B11, B27, B18
    FMAX  V0.2D, V11.2D, V17.2D
    BIT  V5.16B, V29.16B, V10.16B
    FMINNM  V11.2D, V11.2D, V6.2D
    ADD  D27, D13, D13
    SQSHL  B2, B19, B15
    SSHL  V15.8B, V2.8B, V0.8B
    FMLS  V21.2S, V4.2S, V17.2S
    UABA  V26.16B, V0.16B, V1.16B
    UQRSHL  H14, H12, H29
    FMAX  V4.2D, V0.2D, V2.2D
    UQADD  H11, H20, H18
    SHSUB  V14.2S, V9.2S, V24.2S
    URHADD  V12.8H, V3.8H, V8.8H
    BIF  V22.8B, V15.8B, V13.8B
    SQSUB  B15, B17, B17
    UHSUB  V9.16B, V5.16B, V24.16B
    UQRSHL  H27, H17, H30
    USHL  D27, D23, D26
    SQSUB  D27, D21, D6
    UQRSHL  B1, B28, B9
    UMIN  V30.4H, V3.4H, V26.4H
    UQSUB  V1.8B, V11.8B, V29.8B
    BIC  V10.16B, V8.16B, V24.16B
    UABA  V2.8H, V30.8H, V0.8H
    UQSUB  B18, B13, B6
    SQSUB  S10, S13, S5
    SQSHL  S20, S6, S15
    FABD  D17, D31, D7
    MLA  V15.4S, V14.4S, V4.4S
    AND  V14.8B, V27.8B, V0.8B
    AND  V11.16B, V31.16B, V31.16B
    UQADD  V26.16B, V19.16B, V26.16B
    SUB  D29, D4, D10
    BIC  V25.16B, V15.16B, V11.16B
    FMIN  V0.2S, V13.2S, V7.2S
    FABD  D0, D20, D7
    SQRSHL  V13.8H, V26.8H, V16.8H
    BIC  V3.8B, V1.8B, V23.8B
    UQRSHL  H5, H14, H18
    SSHL  D2, D0, D26
    SQSUB  D0, D5, D15
    FMULX  D19, D26, D11
    SQADD  H29, H28, H23
    SRSHL  V28.4S, V22.4S, V31.4S
    FMUL  V19.2D, V10.2D, V10.2D
    UQRSHL  V1.2D, V1.2D, V6.2D
    UQSUB  D9, D11, D18
    FMULX  D5, D0, D0
    SQSUB  D19, D18, D26
    UQADD  V22.2D, V15.2D, V5.2D
    SSHL  D21, D14, D3
    UQRSHL  B19, B0, B3
    SQADD  D22, D13, D21
    SQADD  V30.4S, V28.4S, V28.4S
    UQRSHL  D31, D18, D17
    SHSUB  V6.4S, V2.4S, V11.4S
    SQRSHL  S25, S26, S8
    FSUB  V19.2D, V6.2D, V7.2D
    SMIN  V29.4S, V10.4S, V9.4S
    SQSHL  V22.16B, V22.16B, V28.16B
    FMULX  S1, S21, S6
    UMAX  V0.8B, V2.8B, V29.8B
    BIC  V30.16B, V10.16B, V29.16B
    FRSQRTS  D13, D17, D26
    SRSHL  V3.4H, V1.4H, V3.4H
    SRHADD  V14.8H, V1.8H, V2.8H
    MUL  V1.4S, V14.4S, V22.4S
    SABDL  V31.2D, V1.2S, V25.2S
    FMULX  S31, S18, S5
    FRSQRTS  D10, D25, D8
    UQRSHL  H25, H11, H10
    FRECPE  D28, D12
    ADD  D28, D3, D9
    FMLA  V30.4S, V17.4S, V31.4S
    ORN  V2.16B, V14.16B, V7.16B
    FMULX  V6.4S, V26.4S, V12.4S
    FRSQRTS  D22, D25, D5
    URSHL  V13.8B, V9.8B, V4.8B
    SQSUB  B16, B14, B22
    UQADD  D17, D11, D17
    UQSUB  B22, B0, B5
    SHSUB  V24.2S, V26.2S, V28.2S
    EOR  V11.16B, V25.16B, V6.16B
    UHSUB  V11.16B, V30.16B, V1.16B
    SQADD  V29.16B, V1.16B, V11.16B
    USHL  V0.4S, V11.4S, V9.4S
    URHADD  V19.8H, V12.8H, V26.8H
    FMLA  V4.2S, V7.2S, V5.2S
    SQADD  H16, H14, H28
    BSL  V24.8B, V12.8B, V21.8B
    BIT  V24.16B, V15.16B, V25.16B
    FMAX  V4.2S, V31.2S, V31.2S
    UQADD  H2, H22, H29
    FABD  V11.2D, V10.2D, V21.2D
    FMLS  V15.2D, V25.2D, V10.2D
    FMULX  D25, D14, D11
    SHSUB  V19.8H, V19.8H, V26.8H
    FRECPE  D24, D2
    FMUL  V9.2D, V17.2D, V17.2D
    UMIN  V6.8B, V2.8B, V30.8B
    UMAX  V11.2S, V16.2S, V2.2S
    UQADD  S4, S0, S21
    URSHL  V6.2D, V12.2D, V7.2D
    FMAXNM  V1.4S, V13.4S, V11.4S
    SABDL  V18.8H, V10.8B, V15.8B
    MUL  V10.4H, V18.4H, V6.4H
    FMULX  S20, S24, S6
    URSHL  V28.8B, V14.8B, V11.8B
    SQSUB  B1, B9, B4
    ORR  V10.16B, V24.16B, V21.16B
    SABDL  V16.2D, V20.2S, V24.2S
    SQRSHL  D16, D15, D31
    SABDL2  V1.8H, V9.16B, V10.16B
    SQADD  S4, S9, S29
    BIC  V21.16B, V4.16B, V18.16B
    UQADD  B14, B11, B21
    SHSUB  V25.4H, V5.4H, V15.4H
    UMAX  V14.4S, V31.4S, V28.4S
    UMIN  V20.4H, V16.4H, V10.4H
    BSL  V6.8B, V7.8B, V9.8B
    UHSUB  V26.4H, V14.4H, V22.4H
    MLA  V1.8B, V15.8B, V13.8B
    UQADD  D15, D21, D20
    SRHADD  V27.4S, V25.4S, V0.4S
    UQRSHL  D6, D20, D6
    FRSQRTS  D4, D19, D20
    URHADD  V20.8B, V16.8B, V24.8B
    FMULX  V21.2S, V9.2S, V2.2S
    FABD  V26.2D, V29.2D, V25.2D
    SQRSHL  H11, H17, H28
    BSL  V12.16B, V8.16B, V30.16B
    FMIN  V21.4S, V30.4S, V1.4S
    UQADD  H31, H30, H10
    SHSUB  V6.4S, V15.4S, V2.4S
    UHADD  V21.2S, V7.2S, V3.2S
    ADD  V4.4H, V22.4H, V8.4H
    FRSQRTS  V31.2S, V10.2S, V28.2S
    SQADD  D19, D20, D19
    URHADD  V6.4H, V10.4H, V18.4H
    SQSUB  H15, H18, H9
    UQADD  S22, S0, S9
    SQADD  V20.4S, V4.4S, V10.4S
    SQSUB  B11, B7, B27
    EOR  V15.8B, V8.8B, V21.8B
    UQSUB  D3, D3, D30
    SRHADD  V1.8H, V27.8H, V4.8H
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_0
    MOVZ  X16, #0x3304, LSL #0
    MOVK  X16, #0xa28e, LSL #16
    MOVK  X16, #0xaf38, LSL #32
    MOVK  X16, #0xdb0b, LSL #48
    SUB  X19, X16, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0xb930, LSL #0
    MOVK  X20, #0x1ef7, LSL #16
    MOVK  X20, #0x4dd7, LSL #32
    MOVK  X20, #0x2c16, LSL #48
    SUB  X21, X20, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x278c, LSL #0
    MOVK  X28, #0x72c8, LSL #16
    MOVK  X28, #0x1550, LSL #32
    MOVK  X28, #0x47bb, LSL #48
    SUB  X8, X28, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0xf536, LSL #0
    MOVK  X3, #0x6c70, LSL #16
    MOVK  X3, #0xbe77, LSL #32
    MOVK  X3, #0xeeb5, LSL #48
    SUB  X6, X3, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0xe05f, LSL #0
    MOVK  X26, #0xe6a5, LSL #16
    MOVK  X26, #0x75e4, LSL #32
    MOVK  X26, #0x9f33, LSL #48
    SUB  X16, X26, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0xbe9d, LSL #0
    MOVK  X7, #0x394a, LSL #16
    MOVK  X7, #0x9a50, LSL #32
    MOVK  X7, #0xe6c6, LSL #48
    SUB  X29, X7, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x4031, LSL #0
    MOVK  X20, #0x5eae, LSL #16
    MOVK  X20, #0x4ddc, LSL #32
    MOVK  X20, #0x9810, LSL #48
    SUB  X23, X20, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0xf223, LSL #0
    MOVK  X12, #0xa8a1, LSL #16
    MOVK  X12, #0x36b1, LSL #32
    MOVK  X12, #0xffda, LSL #48
    SUB  X19, X12, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X26, X15, X15
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x8a37, LSL #0
    MOVK  X28, #0x2e77, LSL #16
    MOVK  X28, #0x355b, LSL #32
    MOVK  X28, #0x6431, LSL #48
    SUB  X15, X28, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x5e2, LSL #0
    MOVK  X28, #0x9215, LSL #16
    MOVK  X28, #0x36ab, LSL #32
    MOVK  X28, #0x5ed9, LSL #48
    SUB  X2, X28, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x4031, LSL #0
    MOVK  X25, #0x5eae, LSL #16
    MOVK  X25, #0x4ddc, LSL #32
    MOVK  X25, #0x9810, LSL #48
    SUB  X17, X25, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0xf793, LSL #0
    MOVK  X3, #0x4657, LSL #16
    MOVK  X3, #0x9ad4, LSL #32
    MOVK  X3, #0x727, LSL #48
    SUB  X20, X3, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x4031, LSL #0
    MOVK  X23, #0x5eae, LSL #16
    MOVK  X23, #0x4ddc, LSL #32
    MOVK  X23, #0x9810, LSL #48
    SUB  X12, X23, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0xf291, LSL #0
    MOVK  X11, #0x5dd7, LSL #16
    MOVK  X11, #0xd199, LSL #32
    MOVK  X11, #0x90ae, LSL #48
    SUB  X19, X11, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x5e2, LSL #0
    MOVK  X20, #0x9215, LSL #16
    MOVK  X20, #0x36ab, LSL #32
    MOVK  X20, #0x5ed9, LSL #48
    SUB  X28, X20, X28
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D2
    MOVZ  X20, #0x3680, LSL #0
    SUB  X5, X20, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D3
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D4
    MOVZ  X21, #0x278c, LSL #0
    MOVK  X21, #0x72c8, LSL #16
    MOVK  X21, #0x1550, LSL #32
    MOVK  X21, #0x47bb, LSL #48
    SUB  X28, X21, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D5
    MOVZ  X23, #0x3dab, LSL #0
    MOVK  X23, #0xddd, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X15, X23, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D6
    MOVZ  X5, #0x2f, LSL #0
    MOVK  X5, #0x21, LSL #16
    MOVK  X5, #0x11, LSL #32
    MOVK  X5, #0x3fff, LSL #48
    SUB  X2, X5, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D7
    MOVZ  X3, #0x9eab, LSL #0
    MOVK  X3, #0x5875, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0x7fff, LSL #48
    SUB  X27, X3, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X15, #0x4031, LSL #0
    MOVK  X15, #0x5eae, LSL #16
    MOVK  X15, #0x4ddc, LSL #32
    MOVK  X15, #0x9810, LSL #48
    SUB  X16, X15, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D8
    MOVZ  X15, #0x278c, LSL #0
    MOVK  X15, #0x72c8, LSL #16
    MOVK  X15, #0x1550, LSL #32
    MOVK  X15, #0x47bb, LSL #48
    SUB  X16, X15, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D10
    MOVZ  X6, #0x7, LSL #0
    MOVK  X6, #0x7ff0, LSL #48
    SUB  X20, X6, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D11
    MOVZ  X22, #0xd6, LSL #0
    SUB  X20, X22, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X2, #0x11, LSL #0
    MOVK  X2, #0xe06, LSL #16
    MOVK  X2, #0x4cc, LSL #32
    MOVK  X2, #0x800, LSL #48
    SUB  X4, X2, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D12
    MOVZ  X2, #0x2388, LSL #0
    MOVK  X2, #0x7048, LSL #16
    MOVK  X2, #0xf557, LSL #32
    MOVK  X2, #0x5fbb, LSL #48
    SUB  X4, X2, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X28, X15, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D13
    MOVZ  X15, #0xff55, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    SUB  X28, X15, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D14
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x961d, LSL #16
    MOVK  X28, #0x2000, LSL #48
    SUB  X4, X28, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D15
    MOVZ  X26, #0xe8d9, LSL #0
    MOVK  X26, #0x1ef2, LSL #16
    MOVK  X26, #0xeaaf, LSL #32
    MOVK  X26, #0x7844, LSL #48
    SUB  X27, X26, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D16
    MOVZ  X3, #0x4256, LSL #0
    MOVK  X3, #0xf222, LSL #16
    SUB  X6, X3, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D17
    MOVZ  X5, #0x9eaa, LSL #0
    MOVK  X5, #0xd875, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0x7fff, LSL #48
    SUB  X11, X5, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x8, LSL #32
    MOVK  X24, #0x3f, LSL #48
    SUB  X8, X24, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D18
    MOVZ  X24, #0x56, LSL #0
    MOVK  X24, #0x42, LSL #16
    MOVK  X24, #0x22, LSL #32
    MOVK  X24, #0xe, LSL #48
    SUB  X8, X24, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D19
    MOVZ  X7, #0xec22, LSL #0
    MOVK  X7, #0x5768, LSL #16
    MOVK  X7, #0xc2ab, LSL #32
    MOVK  X7, #0x9b0, LSL #48
    SUB  X10, X7, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D20
    MOVZ  X7, #0x2793, LSL #0
    MOVK  X7, #0x72c8, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X4, X7, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D21
    MOVZ  X29, #0xcf55, LSL #0
    MOVK  X29, #0x6c3a, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x3fff, LSL #48
    SUB  X23, X29, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D22
    MOVZ  X24, #0x9eaa, LSL #0
    MOVK  X24, #0xd875, LSL #16
    SUB  X26, X24, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D23
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0x7fff, LSL #16
    SUB  X20, X11, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D24
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7ff0, LSL #48
    SUB  X16, X22, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D25
    MOVZ  X4, #0xfdaa, LSL #0
    MOVK  X4, #0xddd, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D26
    MOVZ  X7, #0xfdaa, LSL #0
    MOVK  X7, #0xddd, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x7fff, LSL #48
    SUB  X3, X7, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D27
    MOVZ  X18, #0xfed5, LSL #0
    MOVK  X18, #0x6ee, LSL #16
    MOVK  X18, #0xbfbf, LSL #32
    MOVK  X18, #0xe7bf, LSL #48
    SUB  X8, X18, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D28
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x961d, LSL #16
    MOVK  X5, #0x2000, LSL #48
    SUB  X2, X5, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D29
    MOVZ  X21, #0x3680, LSL #0
    MOVK  X21, #0x8000, LSL #16
    MOVK  X21, #0x7f7f, LSL #32
    MOVK  X21, #0xaf7f, LSL #48
    SUB  X17, X21, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  D0, X7
    FMOV  V0.D[1], X25
    FMOV  D1, X18
    FMOV  V1.D[1], X12
    FMOV  D2, X22
    FMOV  V2.D[1], X10
    FMOV  D3, X28
    FMOV  V3.D[1], X8
    FMOV  D4, X5
    FMOV  V4.D[1], X20
    FMOV  D5, X21
    FMOV  V5.D[1], X27
    FMOV  D6, X26
    FMOV  V6.D[1], X26
    FMOV  D7, X13
    FMOV  V7.D[1], X8
    FMOV  D8, X6
    FMOV  V8.D[1], X14
    FMOV  D9, X29
    FMOV  V9.D[1], X6
    FMOV  D10, X16
    FMOV  V10.D[1], X29
    FMOV  D11, X13
    FMOV  V11.D[1], X20
    FMOV  D12, X13
    FMOV  V12.D[1], X27
    FMOV  D13, X26
    FMOV  V13.D[1], X13
    FMOV  D14, X24
    FMOV  V14.D[1], X15
    FMOV  D15, X20
    FMOV  V15.D[1], X3
    FMOV  D16, X2
    FMOV  V16.D[1], X17
    FMOV  D17, X18
    FMOV  V17.D[1], X17
    FMOV  D18, X3
    FMOV  V18.D[1], X20
    FMOV  D19, X17
    FMOV  V19.D[1], X6
    FMOV  D20, X29
    FMOV  V20.D[1], X19
    FMOV  D21, X24
    FMOV  V21.D[1], X6
    FMOV  D22, X29
    FMOV  V22.D[1], X28
    FMOV  D23, X8
    FMOV  V23.D[1], X27
    FMOV  D24, X15
    FMOV  V24.D[1], X14
    FMOV  D25, X6
    FMOV  V25.D[1], X18
    FMOV  D26, X28
    FMOV  V26.D[1], X8
    FMOV  D27, X14
    FMOV  V27.D[1], X28
    FMOV  D28, X25
    FMOV  V28.D[1], X8
    FMOV  D29, X10
    FMOV  V29.D[1], X19
    FMOV  D30, X10
    FMOV  V30.D[1], X8
    FMOV  D31, X23
    FMOV  V31.D[1], X14
    MOVZ  X4, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_83:
    UQRSHL  H24, H12, H9
    SQSHL  V28.16B, V28.16B, V2.16B
    SRSHL  D6, D4, D12
    SRSHL  D29, D20, D11
    UQRSHL  H22, H0, H24
    BIF  V31.16B, V30.16B, V2.16B
    MLA  V5.16B, V14.16B, V22.16B
    FADD  V5.4S, V28.4S, V28.4S
    UQADD  H6, H28, H16
    MLS  V26.8H, V0.8H, V30.8H
    UQADD  H12, H0, H11
    MLA  V9.4H, V20.4H, V29.4H
    BIT  V19.16B, V28.16B, V27.16B
    UMIN  V0.4S, V1.4S, V30.4S
    SQSHL  D11, D29, D29
    FMULX  V11.4S, V5.4S, V7.4S
    SQSHL  V6.2S, V3.2S, V21.2S
    SQADD  S12, S27, S15
    FSUB  V29.4S, V15.4S, V30.4S
    UQADD  B30, B16, B26
    UQSUB  S7, S5, S2
    FSUB  V26.4S, V3.4S, V19.4S
    URSHL  V20.8B, V6.8B, V8.8B
    BSL  V0.16B, V0.16B, V7.16B
    SSHL  D1, D30, D8
    FDIV  V19.2D, V9.2D, V27.2D
    UMIN  V19.16B, V20.16B, V29.16B
    MOV  V17.16B, V10.16B
    UQADD  B22, B14, B23
    FMINNM  V24.2D, V9.2D, V26.2D
    SQADD  V21.2D, V24.2D, V22.2D
    FABD  D16, D14, D24
    BIC  V30.16B, V7.16B, V2.16B
    UQRSHL  D3, D7, D21
    UQSUB  H5, H11, H0
    UQADD  H18, H29, H15
    SHADD  V18.2S, V7.2S, V5.2S
    SMIN  V13.8B, V1.8B, V19.8B
    SABDL  V19.2D, V17.2S, V30.2S
    FRSQRTS  V16.4S, V1.4S, V30.4S
    SQRSHL  V22.8B, V14.8B, V24.8B
    SQSHL  V13.2S, V29.2S, V25.2S
    SABD  V21.4S, V18.4S, V15.4S
    FRSQRTS  D18, D4, D8
    FRECPE  V19.2D, V9.2D
    SRSHL  D5, D12, D22
    SRHADD  V13.2S, V13.2S, V16.2S
    SQSUB  S25, S13, S25
    SHSUB  V19.2S, V27.2S, V13.2S
    USHL  D5, D5, D16
    SQSUB  V11.8H, V25.8H, V15.8H
    FRSQRTS  V27.2D, V30.2D, V5.2D
    FMIN  V22.4S, V3.4S, V15.4S
    ADD  D30, D3, D6
    SQSHL  H17, H6, H30
    FMULX  V11.4S, V24.4S, V13.4S
    SQRSHL  H19, H0, H18
    UQSUB  D15, D20, D3
    SQRSHL  B15, B14, B9
    UQSUB  S29, S28, S10
    AND  V8.16B, V17.16B, V22.16B
    SQSHL  V27.8B, V22.8B, V7.8B
    SABDL  V1.2D, V10.2S, V11.2S
    SQSHL  B11, B3, B13
    UQSUB  V19.8B, V7.8B, V25.8B
    SQADD  D5, D13, D6
    FABD  V29.2S, V12.2S, V8.2S
    ADD  D29, D12, D9
    SQADD  B21, B26, B4
    SHSUB  V30.4S, V29.4S, V0.4S
    SQSUB  V29.4H, V10.4H, V25.4H
    SQADD  D12, D5, D4
    URHADD  V9.4S, V24.4S, V11.4S
    UQSUB  S4, S12, S21
    UHSUB  V2.2S, V22.2S, V2.2S
    SQSUB  H26, H19, H27
    SABDL2  V2.2D, V14.4S, V4.4S
    SQSHL  B11, B25, B18
    SQSUB  V26.4S, V1.4S, V8.4S
    FMIN  V4.4S, V1.4S, V4.4S
    SABDL2  V3.2D, V14.4S, V0.4S
    FMIN  V9.4S, V19.4S, V29.4S
    FRSQRTS  V29.2S, V30.2S, V8.2S
    SQADD  B27, B27, B26
    SQSHL  S22, S4, S2
    URSHL  V9.4S, V28.4S, V1.4S
    MLS  V0.8H, V2.8H, V7.8H
    BIF  V0.16B, V15.16B, V23.16B
    SQADD  V9.8H, V8.8H, V22.8H
    UQADD  V3.2D, V24.2D, V4.2D
    SUB  V11.2D, V22.2D, V27.2D
    MLS  V9.2S, V15.2S, V31.2S
    ORN  V0.8B, V20.8B, V11.8B
    SQSHL  S9, S0, S24
    BIT  V26.16B, V15.16B, V11.16B
    BSL  V27.8B, V7.8B, V11.8B
    FMLA  V14.2S, V7.2S, V24.2S
    SQSHL  H15, H28, H31
    SQSUB  S28, S28, S17
    UQADD  V13.4H, V30.4H, V17.4H
    FRECPE  D31, D24
    SQRSHL  V3.8B, V4.8B, V22.8B
    UHSUB  V3.4H, V24.4H, V14.4H
    UQADD  B26, B27, B26
    UQADD  D9, D0, D20
    BIC  V3.16B, V3.16B, V16.16B
    FMAXNM  V0.4S, V15.4S, V4.4S
    SMIN  V29.16B, V9.16B, V21.16B
    URSHL  D26, D10, D12
    FMLA  V10.2S, V4.2S, V10.2S
    ADD  D24, D4, D8
    FMULX  V30.2D, V7.2D, V28.2D
    SQSUB  D9, D18, D31
    FMLS  V7.2D, V0.2D, V29.2D
    FMLS  V2.2S, V28.2S, V24.2S
    UQRSHL  V1.8H, V29.8H, V11.8H
    SQRSHL  D23, D26, D10
    FSUB  V7.2S, V3.2S, V13.2S
    MOV  V7.8B, V7.8B
    FRSQRTS  S7, S9, S30
    UQSUB  H22, H7, H18
    FMINNM  V28.2S, V2.2S, V25.2S
    UMIN  V28.2S, V11.2S, V14.2S
    UMAX  V27.8H, V23.8H, V11.8H
    UQRSHL  H27, H17, H26
    FMIN  V1.2S, V2.2S, V13.2S
    UQSUB  V2.2D, V22.2D, V11.2D
    SQRSHL  D19, D26, D31
    USHL  D3, D28, D13
    SQRSHL  H3, H18, H4
    SUB  V18.8H, V20.8H, V24.8H
    MLA  V14.16B, V6.16B, V21.16B
    FMAX  V16.2D, V0.2D, V14.2D
    BSL  V6.8B, V14.8B, V16.8B
    FABD  D14, D29, D23
    UABA  V12.2S, V25.2S, V12.2S
    SQRSHL  S27, S13, S28
    SABD  V1.16B, V19.16B, V8.16B
    EOR  V8.8B, V26.8B, V25.8B
    SQADD  H2, H1, H21
    SQRSHL  D29, D29, D29
    FRSQRTS  V7.4S, V31.4S, V9.4S
    UHSUB  V17.2S, V22.2S, V24.2S
    SRSHL  D31, D9, D14
    FMIN  V13.4S, V9.4S, V31.4S
    SQSUB  B12, B24, B9
    SRSHL  D16, D19, D25
    UQSUB  D19, D22, D14
    SQSUB  H13, H7, H7
    MOV  V31.16B, V23.16B
    UQRSHL  V0.4H, V3.4H, V31.4H
    FMULX  V14.2S, V27.2S, V9.2S
    MUL  V3.8B, V30.8B, V15.8B
    FMAX  V30.4S, V29.4S, V6.4S
    UQSUB  B20, B4, B28
    UQRSHL  B0, B11, B9
    FABD  V15.4S, V12.4S, V24.4S
    EOR  V10.8B, V20.8B, V7.8B
    SQRSHL  S15, S6, S16
    SQSHL  V7.16B, V24.16B, V1.16B
    SQRSHL  D24, D18, D17
    BIT  V10.16B, V21.16B, V25.16B
    FABD  V15.2S, V30.2S, V30.2S
    SQRSHL  S31, S2, S1
    UQADD  S0, S12, S18
    SQSHL  V22.2S, V2.2S, V21.2S
    UQRSHL  B8, B25, B0
    SRSHL  V17.8H, V22.8H, V13.8H
    UQADD  D12, D8, D6
    UQRSHL  B19, B13, B22
    FRECPE  S25, S0
    FRSQRTS  V21.2S, V12.2S, V18.2S
    FMIN  V1.2D, V11.2D, V28.2D
    UABA  V1.4H, V14.4H, V1.4H
    SUB  D3, D1, D1
    UMAX  V15.8B, V28.8B, V25.8B
    UHADD  V11.4S, V16.4S, V21.4S
    SQSHL  B4, B7, B24
    FRECPE  S31, S10
    FABD  D17, D10, D17
    FDIV  V4.2D, V11.2D, V18.2D
    SQSUB  V14.4S, V15.4S, V16.4S
    FABD  S24, S10, S1
    FMUL  V30.2S, V4.2S, V31.2S
    URSHL  D21, D11, D3
    FMULX  D20, D24, D20
    SQSUB  H21, H11, H20
    SQRSHL  D27, D4, D3
    UQADD  B29, B16, B19
    SQADD  D29, D29, D13
    ORN  V3.16B, V29.16B, V12.16B
    SABDL2  V26.2D, V21.4S, V10.4S
    SUB  V16.2D, V13.2D, V7.2D
    UHADD  V31.4H, V5.4H, V1.4H
    UQADD  H18, H5, H27
    SSHL  D6, D26, D20
    FADD  V22.4S, V0.4S, V24.4S
    SQRSHL  D24, D24, D21
    UQRSHL  D22, D4, D19
    SSHL  D6, D22, D20
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_83
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X3
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X3, X27, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D2
    MOVZ  X29, #0x18c, LSL #0
    SUB  X8, X29, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X12, X7, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D3
    MOVZ  X7, #0x4db3, LSL #0
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X12, X7, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7ff8, LSL #48
    SUB  X20, X29, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D4
    MOVZ  X29, #0x9c24, LSL #0
    MOVK  X29, #0x923a, LSL #16
    MOVK  X29, #0x92b, LSL #32
    MOVK  X29, #0x602f, LSL #48
    SUB  X20, X29, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D5
    MOVZ  X15, #0x8cf5, LSL #0
    MOVK  X15, #0x7fff, LSL #16
    MOVK  X15, #0x20ff, LSL #32
    MOVK  X15, #0x1fe0, LSL #48
    SUB  X22, X15, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D6
    MOVZ  X10, #0x9c24, LSL #0
    MOVK  X10, #0x923a, LSL #16
    MOVK  X10, #0x92b, LSL #32
    MOVK  X10, #0x602f, LSL #48
    SUB  X2, X10, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D7
    MOVZ  X20, #0x8cd4, LSL #0
    MOVK  X20, #0x1, LSL #32
    SUB  X29, X20, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D8
    MOVZ  X14, #0xff, LSL #0
    SUB  X28, X14, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D10
    MOVZ  X26, #0x738a, LSL #0
    MOVK  X26, #0xff80, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X3, X26, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D11
    MOVZ  X24, #0xd926, LSL #0
    MOVK  X24, #0x3fff, LSL #16
    MOVK  X24, #0x1fe0, LSL #48
    SUB  X18, X24, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D12
    MOVZ  X14, #0xb24c, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X4, X14, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D14
    MOVZ  X26, #0xb1d8, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X21, X26, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D15
    MOVZ  X20, #0xb1d8, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X22, X20, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D16
    MOVZ  X18, #0x732c, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xfffe, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X24, X18, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D17
    MOVZ  X24, #0x738a, LSL #0
    MOVK  X24, #0xff80, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0x7fff, LSL #48
    SUB  X7, X24, X22
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D18
    MOVZ  X5, #0xffff, LSL #0
    SUB  X2, X5, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D19
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D20
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D21
    MOVZ  X18, #0xd926, LSL #0
    SUB  X26, X18, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D22
    MOVZ  X6, #0x9c24, LSL #0
    MOVK  X6, #0x923a, LSL #16
    MOVK  X6, #0x92b, LSL #32
    MOVK  X6, #0x602f, LSL #48
    SUB  X18, X6, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D23
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D24
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0x7fff, LSL #48
    SUB  X20, X22, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D25
    MOVZ  X23, #0x3901, LSL #0
    MOVK  X23, #0x7fff, LSL #16
    SUB  X18, X23, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D27
    MOVZ  X18, #0x9c24, LSL #0
    MOVK  X18, #0x923a, LSL #16
    MOVK  X18, #0x92b, LSL #32
    MOVK  X18, #0x602f, LSL #48
    SUB  X15, X18, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X16, X15, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D28
    MOVZ  X15, #0xb1d8, LSL #0
    MOVK  X15, #0xffff, LSL #16
    SUB  X16, X15, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X8
    FMOV  V1.D[1], X5
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X6
    FMOV  V3.D[1], X2
    FMOV  D4, X8
    FMOV  V4.D[1], X22
    FMOV  D5, X2
    FMOV  V5.D[1], X22
    FMOV  D6, X19
    FMOV  V6.D[1], X29
    FMOV  D7, X12
    FMOV  V7.D[1], X16
    FMOV  D8, X26
    FMOV  V8.D[1], X7
    FMOV  D9, X28
    FMOV  V9.D[1], X8
    FMOV  D10, X24
    FMOV  V10.D[1], X7
    FMOV  D11, X25
    FMOV  V11.D[1], X7
    FMOV  D12, X25
    FMOV  V12.D[1], X17
    FMOV  D13, X28
    FMOV  V13.D[1], X7
    FMOV  D14, X25
    FMOV  V14.D[1], X13
    FMOV  D15, X21
    FMOV  V15.D[1], X21
    FMOV  D16, X6
    FMOV  V16.D[1], X6
    FMOV  D17, X27
    FMOV  V17.D[1], X7
    FMOV  D18, X28
    FMOV  V18.D[1], X5
    FMOV  D19, X26
    FMOV  V19.D[1], X17
    FMOV  D20, X15
    FMOV  V20.D[1], X8
    FMOV  D21, X17
    FMOV  V21.D[1], X12
    FMOV  D22, X2
    FMOV  V22.D[1], X21
    FMOV  D23, X25
    FMOV  V23.D[1], X25
    FMOV  D24, X15
    FMOV  V24.D[1], X22
    FMOV  D25, X28
    FMOV  V25.D[1], X13
    FMOV  D26, X18
    FMOV  V26.D[1], X21
    FMOV  D27, X8
    FMOV  V27.D[1], X25
    FMOV  D28, X5
    FMOV  V28.D[1], X24
    FMOV  D29, X17
    FMOV  V29.D[1], X8
    FMOV  D30, X5
    FMOV  V30.D[1], X15
    FMOV  D31, X13
    FMOV  V31.D[1], X24
    MOVZ  X27, #0xf, LSL #0
TaishanSimdPairArithmeticP01_label_166:
    SQSHL  D24, D29, D5
    SSHL  V20.2D, V14.2D, V20.2D
    UQRSHL  B15, B30, B28
    SQRSHL  V2.2D, V22.2D, V7.2D
    SQSUB  B26, B4, B2
    SABDL2  V21.2D, V2.4S, V31.4S
    SRSHL  V4.8B, V20.8B, V18.8B
    SQADD  D4, D24, D9
    UQRSHL  H15, H24, H0
    UQSUB  D21, D8, D30
    SQRSHL  S29, S13, S21
    SABDL2  V26.2D, V27.4S, V29.4S
    SQADD  B26, B17, B1
    FMAX  V4.2D, V3.2D, V26.2D
    UQRSHL  V11.8H, V25.8H, V4.8H
    UQRSHL  H13, H22, H14
    ADD  V2.16B, V4.16B, V18.16B
    SQSUB  B26, B7, B3
    AND  V1.8B, V8.8B, V7.8B
    SQRSHL  B25, B16, B21
    BIT  V31.8B, V0.8B, V8.8B
    SQSUB  S17, S17, S21
    UQADD  D0, D2, D17
    FMINNM  V5.2S, V3.2S, V5.2S
    FRECPE  S23, S20
    SQSHL  V23.4H, V23.4H, V20.4H
    USHL  D28, D18, D7
    FRSQRTS  S11, S31, S3
    UQADD  B17, B27, B16
    USHL  D0, D7, D6
    UQADD  S3, S22, S25
    SQSUB  H26, H28, H1
    ADD  D8, D13, D5
    FRECPE  V25.2S, V13.2S
    FRSQRTS  V6.4S, V10.4S, V7.4S
    SABDL  V6.4S, V14.4H, V20.4H
    MOV  V15.16B, V2.16B
    USHL  V25.4S, V26.4S, V25.4S
    FRSQRTS  V6.4S, V23.4S, V20.4S
    FSUB  V12.4S, V24.4S, V27.4S
    BIT  V24.8B, V17.8B, V21.8B
    SUB  V31.4S, V3.4S, V27.4S
    FMULX  S8, S21, S25
    UQADD  V12.16B, V29.16B, V28.16B
    UQRSHL  S31, S24, S1
    UMIN  V21.4S, V4.4S, V26.4S
    UQRSHL  V14.16B, V22.16B, V8.16B
    FMLS  V24.2S, V17.2S, V21.2S
    FMUL  V15.4S, V20.4S, V28.4S
    UQSUB  H20, H19, H1
    UMIN  V20.2S, V22.2S, V25.2S
    SRSHL  D22, D10, D20
    SQSHL  V24.8B, V20.8B, V24.8B
    UQSUB  V11.8H, V15.8H, V14.8H
    FADD  V19.4S, V15.4S, V27.4S
    FMAXNM  V6.4S, V25.4S, V20.4S
    SUB  D1, D10, D19
    UQSUB  B19, B8, B16
    UQRSHL  S3, S15, S22
    SQSHL  H27, H28, H6
    URHADD  V6.8H, V22.8H, V5.8H
    UQRSHL  S5, S17, S7
    BSL  V28.16B, V21.16B, V10.16B
    USHL  V0.8H, V31.8H, V5.8H
    BIF  V21.8B, V27.8B, V0.8B
    UQRSHL  S11, S17, S11
    SRSHL  V8.4H, V21.4H, V29.4H
    SABDL  V1.2D, V16.2S, V2.2S
    MOV  V3.16B, V18.16B
    BSL  V3.8B, V7.8B, V25.8B
    SRSHL  V21.8H, V29.8H, V6.8H
    BIT  V14.8B, V4.8B, V15.8B
    FMAXNM  V19.2S, V8.2S, V21.2S
    SABDL  V11.4S, V26.4H, V3.4H
    SUB  V23.8B, V30.8B, V28.8B
    UQSUB  B17, B3, B8
    UQSUB  V13.8H, V24.8H, V15.8H
    UQADD  S15, S31, S21
    SMIN  V19.8B, V1.8B, V12.8B
    FMULX  D27, D17, D5
    ORR  V11.16B, V10.16B, V29.16B
    SQSHL  B13, B17, B12
    UQRSHL  V23.8H, V25.8H, V20.8H
    MLA  V28.2S, V13.2S, V0.2S
    SRSHL  D12, D14, D16
    UQSUB  S31, S14, S21
    SHSUB  V14.8H, V11.8H, V18.8H
    UABA  V3.8H, V24.8H, V0.8H
    SQADD  S14, S4, S27
    UQADD  D19, D3, D27
    SQRSHL  H18, H14, H30
    FABD  V17.2S, V4.2S, V24.2S
    FMINNM  V29.4S, V5.4S, V11.4S
    FMLS  V31.2D, V3.2D, V25.2D
    SQSUB  B9, B1, B5
    UABA  V7.16B, V8.16B, V10.16B
    UQSUB  S23, S14, S13
    UQRSHL  S6, S28, S12
    FMAX  V29.2D, V4.2D, V30.2D
    UQADD  B2, B11, B15
    BIF  V25.16B, V8.16B, V31.16B
    FMULX  V22.2D, V13.2D, V29.2D
    UHSUB  V2.2S, V1.2S, V7.2S
    UMAX  V30.8B, V28.8B, V11.8B
    SQSUB  V29.4H, V20.4H, V7.4H
    BIT  V24.8B, V25.8B, V4.8B
    SQRSHL  B9, B9, B19
    SQRSHL  S11, S6, S31
    SMAX  V21.4S, V0.4S, V16.4S
    FRECPE  S27, S19
    UQADD  D24, D8, D29
    SQADD  B22, B29, B23
    UQSUB  V2.8B, V0.8B, V0.8B
    UQSUB  S30, S2, S22
    ADD  V2.8B, V19.8B, V21.8B
    SSHL  V27.8B, V21.8B, V12.8B
    SQSHL  B2, B10, B11
    BIC  V24.16B, V0.16B, V31.16B
    ADD  D24, D10, D4
    FADD  V27.2D, V11.2D, V27.2D
    SQADD  V12.16B, V6.16B, V5.16B
    MLS  V5.2S, V23.2S, V10.2S
    FMAX  V13.2D, V2.2D, V19.2D
    UQSUB  S26, S18, S1
    SHSUB  V27.2S, V8.2S, V21.2S
    FMULX  V3.2S, V25.2S, V6.2S
    MOV  V9.16B, V27.16B
    URSHL  D8, D9, D18
    BIC  V8.8B, V0.8B, V11.8B
    UQADD  V29.2D, V1.2D, V13.2D
    UQSUB  D27, D5, D19
    SQSHL  H24, H13, H12
    UQSUB  V7.4H, V5.4H, V7.4H
    SQADD  S9, S11, S3
    SQRSHL  D24, D26, D8
    FRECPE  S13, S23
    BIF  V22.16B, V24.16B, V7.16B
    SQADD  B24, B5, B3
    UQSUB  H28, H14, H24
    SQADD  S24, S22, S29
    SQRSHL  D12, D31, D26
    FABD  D21, D2, D3
    SRHADD  V1.4S, V11.4S, V29.4S
    MLS  V9.8H, V9.8H, V1.8H
    UQRSHL  H15, H20, H10
    MOV  V5.16B, V20.16B
    FMULX  V9.4S, V13.4S, V14.4S
    FRSQRTS  S11, S6, S5
    UQRSHL  D5, D11, D9
    SQRSHL  D30, D4, D13
    SQADD  D22, D27, D13
    FABD  S22, S30, S29
    SRSHL  V12.4H, V7.4H, V19.4H
    SQADD  H19, H4, H11
    MUL  V3.16B, V8.16B, V15.16B
    SQRSHL  B18, B0, B6
    UQRSHL  V19.4H, V26.4H, V29.4H
    SQRSHL  D31, D26, D26
    UQADD  H27, H18, H28
    SQSUB  S2, S12, S4
    UQADD  B24, B28, B5
    FMIN  V6.2S, V11.2S, V30.2S
    FSUB  V13.2S, V30.2S, V9.2S
    SQRSHL  H14, H26, H30
    UQSUB  B22, B5, B6
    FRECPE  S24, S3
    SQSHL  B19, B16, B14
    SQSUB  S19, S17, S9
    SUB  V15.4H, V25.4H, V0.4H
    URHADD  V21.2S, V24.2S, V12.2S
    USHL  D8, D25, D14
    USHL  V3.2S, V8.2S, V13.2S
    MLA  V2.4S, V1.4S, V30.4S
    SQSUB  V6.8H, V1.8H, V4.8H
    UQADD  B24, B30, B14
    UQSUB  B31, B3, B11
TaishanSimdPairArithmeticP01_label_65:
    ADD  V17.8B, V10.8B, V29.8B
    SSHL  D20, D10, D29
    SQADD  B14, B24, B17
    SQRSHL  D3, D9, D12
    SRSHL  D15, D31, D12
    UQRSHL  S29, S31, S20
    UQSUB  D5, D9, D30
    UQRSHL  H30, H11, H3
    SRSHL  D19, D2, D31
    UQSUB  D4, D16, D21
    ORN  V31.8B, V29.8B, V1.8B
    URSHL  D6, D24, D25
    MLA  V14.16B, V5.16B, V30.16B
    UQRSHL  D1, D5, D17
    UQSUB  H22, H4, H21
    UHADD  V5.4H, V17.4H, V15.4H
    URSHL  V25.8B, V19.8B, V2.8B
    FABD  S30, S24, S0
    SQSUB  H20, H28, H31
    SHADD  V28.8B, V27.8B, V10.8B
    UHSUB  V20.4S, V9.4S, V4.4S
    SQSHL  H22, H27, H5
    FMULX  D10, D24, D27
    FRECPE  V0.4S, V30.4S
    SUBS  X27, X27, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_166
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X15, X12, X2
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X2, X5, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X4, X26, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X11, X2, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X8, X29, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X5, X29, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X27, X25, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X24, X10, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X16, X2, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X26, X24, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X27, X13, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X15, X22, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X29, X20, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X23, X2, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X19, X2, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X21, X22, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X2, X3, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X10, X27, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D2
    MOVZ  X13, #0x5587, LSL #0
    MOVK  X13, #0x57fc, LSL #16
    SUB  X25, X13, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D3
    MOVZ  X27, #0xf741, LSL #0
    MOVK  X27, #0x1fbf, LSL #16
    SUB  X25, X27, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X10, X24, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D4
    MOVZ  X24, #0xff7f, LSL #0
    MOVK  X24, #0xc03f, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X6, X15, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D5
    MOVZ  X15, #0x1bae, LSL #0
    MOVK  X15, #0x1fc0, LSL #16
    SUB  X6, X15, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D6
    MOVZ  X18, #0x5c, LSL #0
    SUB  X19, X18, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D7
    MOVZ  X14, #0xff, LSL #0
    SUB  X22, X14, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D10
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D11
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x3fc0, LSL #16
    SUB  X23, X28, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X27, X3, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D12
    MOVZ  X3, #0xff, LSL #0
    SUB  X27, X3, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D13
    MOVZ  X18, #0x3700, LSL #0
    MOVK  X18, #0x3b00, LSL #16
    SUB  X19, X18, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D14
    MOVZ  X20, #0x7f, LSL #0
    SUB  X10, X20, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X25, X8, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D16
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X25, X8, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D17
    MOVZ  X8, #0x375d, LSL #0
    MOVK  X8, #0x3f80, LSL #16
    SUB  X10, X8, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D19
    MOVZ  X29, #0x5587, LSL #0
    MOVK  X29, #0x57fc, LSL #16
    SUB  X22, X29, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D20
    MOVZ  X27, #0xf781, LSL #0
    MOVK  X27, #0xbf9f, LSL #16
    MOVK  X27, #0x8000, LSL #48
    SUB  X18, X27, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X11, X28, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D21
    MOVZ  X28, #0x80, LSL #0
    MOVK  X28, #0x3fc0, LSL #16
    SUB  X11, X28, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D22
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D23
    MOVZ  X24, #0x375c, LSL #0
    MOVK  X24, #0x3f80, LSL #16
    SUB  X8, X24, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D24
    MOVZ  X7, #0x5c, LSL #0
    SUB  X26, X7, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D25
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x10, LSL #16
    SUB  X11, X24, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D27
    MOVZ  X7, #0x365d, LSL #0
    SUB  X3, X7, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D28
    MOVZ  X18, #0x1b2e, LSL #0
    SUB  X20, X18, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D29
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x1b62, LSL #0
    MOVK  X2, #0xd141, LSL #16
    MOVK  X2, #0xf9ec, LSL #32
    MOVK  X2, #0x20ce, LSL #48
    MOVZ  X3, #0x40e3, LSL #0
    MOVK  X3, #0x7808, LSL #16
    MOVK  X3, #0x7cca, LSL #32
    MOVK  X3, #0xe6b, LSL #48
    MOVZ  X4, #0xa417, LSL #0
    MOVK  X4, #0x3d27, LSL #16
    MOVK  X4, #0xec74, LSL #32
    MOVK  X4, #0x1a4e, LSL #48
    MOVZ  X5, #0xd3f3, LSL #0
    MOVK  X5, #0x7f29, LSL #16
    MOVK  X5, #0xdfde, LSL #32
    MOVK  X5, #0x933b, LSL #48
    MOVZ  X6, #0xd214, LSL #0
    MOVK  X6, #0xd6e9, LSL #16
    MOVK  X6, #0x3443, LSL #32
    MOVK  X6, #0x1ed4, LSL #48
    MOVZ  X7, #0x135, LSL #0
    MOVK  X7, #0x65ce, LSL #16
    MOVK  X7, #0xb6bc, LSL #32
    MOVK  X7, #0x4d33, LSL #48
    MOVZ  X8, #0xfc26, LSL #0
    MOVK  X8, #0x7de, LSL #16
    MOVK  X8, #0xa346, LSL #32
    MOVK  X8, #0x1bc5, LSL #48
    MOVZ  X10, #0x8e75, LSL #0
    MOVK  X10, #0x1938, LSL #16
    MOVK  X10, #0x3979, LSL #32
    MOVK  X10, #0x7afb, LSL #48
    MOVZ  X11, #0xe038, LSL #0
    MOVK  X11, #0x4fec, LSL #16
    MOVK  X11, #0xddd2, LSL #32
    MOVK  X11, #0xfe25, LSL #48
    MOVZ  X12, #0xe9b8, LSL #0
    MOVK  X12, #0x5b49, LSL #16
    MOVK  X12, #0x4b4, LSL #32
    MOVK  X12, #0x586c, LSL #48
    MOVZ  X13, #0x83fd, LSL #0
    MOVK  X13, #0xc4f1, LSL #16
    MOVK  X13, #0xfd65, LSL #32
    MOVK  X13, #0x5ddf, LSL #48
    MOVZ  X14, #0xb714, LSL #0
    MOVK  X14, #0xb2d7, LSL #16
    MOVK  X14, #0xcb98, LSL #32
    MOVK  X14, #0x759c, LSL #48
    MOVZ  X15, #0x722d, LSL #0
    MOVK  X15, #0x5aa9, LSL #16
    MOVK  X15, #0xc116, LSL #32
    MOVK  X15, #0x5d1, LSL #48
    MOVZ  X16, #0x67ad, LSL #0
    MOVK  X16, #0xd599, LSL #16
    MOVK  X16, #0xa636, LSL #32
    MOVK  X16, #0xdba, LSL #48
    MOVZ  X17, #0x7cc9, LSL #0
    MOVK  X17, #0x275a, LSL #16
    MOVK  X17, #0x4d43, LSL #32
    MOVK  X17, #0x726a, LSL #48
    MOVZ  X18, #0x19b6, LSL #0
    MOVK  X18, #0x6ec1, LSL #16
    MOVK  X18, #0x74c7, LSL #32
    MOVK  X18, #0xaee6, LSL #48
    MOVZ  X19, #0xdddd, LSL #0
    MOVK  X19, #0xc5c5, LSL #16
    MOVK  X19, #0x6f0d, LSL #32
    MOVK  X19, #0x92f, LSL #48
    MOVZ  X20, #0x9fd8, LSL #0
    MOVK  X20, #0xcf49, LSL #16
    MOVK  X20, #0x26d3, LSL #32
    MOVK  X20, #0x3bf7, LSL #48
    MOVZ  X21, #0x9ed3, LSL #0
    MOVK  X21, #0xaf96, LSL #16
    MOVK  X21, #0xeb6f, LSL #32
    MOVK  X21, #0x11d4, LSL #48
    MOVZ  X22, #0xd7cb, LSL #0
    MOVK  X22, #0xd19, LSL #16
    MOVK  X22, #0xc0e5, LSL #32
    MOVK  X22, #0xd145, LSL #48
    MOVZ  X23, #0x11b7, LSL #0
    MOVK  X23, #0x5dd1, LSL #16
    MOVK  X23, #0x9aa, LSL #32
    MOVK  X23, #0xa517, LSL #48
    MOVZ  X24, #0x29ba, LSL #0
    MOVK  X24, #0xae2c, LSL #16
    MOVK  X24, #0x17e1, LSL #32
    MOVK  X24, #0xfc1a, LSL #48
    MOVZ  X25, #0xc745, LSL #0
    MOVK  X25, #0xd179, LSL #16
    MOVK  X25, #0xb5d0, LSL #32
    MOVK  X25, #0x73e7, LSL #48
    MOVZ  X26, #0x11ce, LSL #0
    MOVK  X26, #0x318a, LSL #16
    MOVK  X26, #0xb19c, LSL #32
    MOVK  X26, #0x7e57, LSL #48
    MOVZ  X27, #0xf76f, LSL #0
    MOVK  X27, #0x9edc, LSL #16
    MOVK  X27, #0xe06, LSL #32
    MOVK  X27, #0x4d2a, LSL #48
    MOVZ  X28, #0xcd2c, LSL #0
    MOVK  X28, #0x6891, LSL #16
    MOVK  X28, #0x720, LSL #32
    MOVK  X28, #0x83b6, LSL #48
    MOVZ  X29, #0xaa1, LSL #0
    MOVK  X29, #0x3612, LSL #16
    MOVK  X29, #0x6bb9, LSL #32
    MOVK  X29, #0x4541, LSL #48
    FMOV  D0, X7
    FMOV  V0.D[1], X7
    FMOV  D1, X17
    FMOV  V1.D[1], X25
    FMOV  D2, X4
    FMOV  V2.D[1], X3
    FMOV  D3, X28
    FMOV  V3.D[1], X21
    FMOV  D4, X19
    FMOV  V4.D[1], X8
    FMOV  D5, X12
    FMOV  V5.D[1], X18
    FMOV  D6, X23
    FMOV  V6.D[1], X22
    FMOV  D7, X16
    FMOV  V7.D[1], X19
    FMOV  D8, X15
    FMOV  V8.D[1], X24
    FMOV  D9, X17
    FMOV  V9.D[1], X29
    FMOV  D10, X29
    FMOV  V10.D[1], X12
    FMOV  D11, X2
    FMOV  V11.D[1], X23
    FMOV  D12, X23
    FMOV  V12.D[1], X21
    FMOV  D13, X8
    FMOV  V13.D[1], X29
    FMOV  D14, X16
    FMOV  V14.D[1], X3
    FMOV  D15, X23
    FMOV  V15.D[1], X7
    FMOV  D16, X24
    FMOV  V16.D[1], X17
    FMOV  D17, X22
    FMOV  V17.D[1], X13
    FMOV  D18, X23
    FMOV  V18.D[1], X23
    FMOV  D19, X7
    FMOV  V19.D[1], X17
    FMOV  D20, X3
    FMOV  V20.D[1], X21
    FMOV  D21, X2
    FMOV  V21.D[1], X26
    FMOV  D22, X22
    FMOV  V22.D[1], X27
    FMOV  D23, X24
    FMOV  V23.D[1], X17
    FMOV  D24, X21
    FMOV  V24.D[1], X28
    FMOV  D25, X10
    FMOV  V25.D[1], X19
    FMOV  D26, X28
    FMOV  V26.D[1], X15
    FMOV  D27, X15
    FMOV  V27.D[1], X2
    FMOV  D28, X16
    FMOV  V28.D[1], X22
    FMOV  D29, X13
    FMOV  V29.D[1], X15
    FMOV  D30, X23
    FMOV  V30.D[1], X15
    FMOV  D31, X10
    FMOV  V31.D[1], X3
    MOVZ  X24, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_249:
    UABA  V4.16B, V3.16B, V27.16B
    FABD  S29, S31, S13
    SSHL  D29, D19, D12
    UMIN  V31.4S, V22.4S, V1.4S
    SQADD  D3, D18, D28
    SRHADD  V15.16B, V4.16B, V4.16B
    UQRSHL  H30, H25, H28
    SQRSHL  D3, D31, D26
    FRSQRTS  S7, S16, S0
    FMLA  V3.4S, V3.4S, V4.4S
    SHADD  V1.4H, V19.4H, V10.4H
    SMAX  V3.2S, V16.2S, V1.2S
    FMAXNM  V21.4S, V14.4S, V10.4S
    SQSUB  H21, H0, H13
    SUB  V4.4S, V28.4S, V17.4S
    BIF  V9.16B, V3.16B, V5.16B
    SQSHL  D25, D8, D5
    UQADD  S13, S23, S5
    FMUL  V15.4S, V25.4S, V28.4S
    SHADD  V6.2S, V2.2S, V13.2S
    SQADD  B11, B12, B0
    SQSHL  H24, H1, H5
    UQRSHL  B28, B0, B2
    FMUL  V29.4S, V21.4S, V29.4S
    USHL  V29.8B, V4.8B, V12.8B
    FABD  V7.2S, V17.2S, V19.2S
    FRSQRTS  D6, D12, D16
    FRECPE  S17, S27
    SQADD  B26, B20, B12
    UQRSHL  B11, B22, B9
    MLA  V15.4S, V22.4S, V9.4S
    FABD  S12, S20, S14
    SSHL  D29, D24, D13
    SQSHL  B6, B26, B4
    FMLA  V22.2S, V13.2S, V16.2S
    FABD  S12, S15, S23
    SMIN  V27.8B, V15.8B, V18.8B
    BIF  V9.8B, V28.8B, V3.8B
    FMUL  V25.2S, V11.2S, V3.2S
    AND  V0.8B, V3.8B, V27.8B
    EOR  V13.16B, V26.16B, V7.16B
    SMAX  V28.8H, V21.8H, V4.8H
    URHADD  V17.4S, V22.4S, V9.4S
    URSHL  V11.2D, V10.2D, V19.2D
    SQSUB  H0, H8, H9
    FMIN  V13.2S, V25.2S, V0.2S
    FMULX  D4, D6, D23
    URSHL  V29.4H, V12.4H, V22.4H
    SRSHL  V0.4H, V31.4H, V11.4H
    UQSUB  S9, S2, S28
    SQRSHL  H22, H31, H24
    UQRSHL  H25, H5, H4
    FRSQRTS  S0, S6, S18
    SQRSHL  S12, S25, S22
    SQRSHL  B5, B1, B9
    MLS  V7.8H, V2.8H, V29.8H
    SQRSHL  H10, H18, H29
    FMULX  D28, D1, D18
    SABD  V16.8B, V9.8B, V11.8B
    URHADD  V17.8B, V21.8B, V5.8B
    UQSUB  D13, D0, D14
    SQSUB  V11.2S, V20.2S, V13.2S
    UQADD  H11, H3, H11
    FSUB  V28.2D, V20.2D, V25.2D
    BIT  V22.8B, V24.8B, V28.8B
    UQRSHL  S26, S2, S3
    SQSUB  B28, B20, B20
    FABD  D6, D17, D17
    SQRSHL  H14, H11, H29
    BSL  V31.16B, V23.16B, V3.16B
    URSHL  D18, D12, D27
    SRHADD  V18.4S, V5.4S, V7.4S
    ORN  V18.8B, V11.8B, V27.8B
    UQADD  V20.2S, V29.2S, V5.2S
    ORR  V10.8B, V30.8B, V28.8B
    SABDL2  V24.4S, V14.8H, V28.8H
    FRECPE  V19.2S, V24.2S
    SHADD  V30.16B, V10.16B, V4.16B
    SQRSHL  B26, B30, B27
    MLS  V7.4H, V12.4H, V18.4H
    SQSHL  B11, B2, B13
    SHSUB  V1.2S, V6.2S, V6.2S
    SQRSHL  S7, S12, S13
    SQSUB  D31, D2, D6
    URSHL  V6.16B, V28.16B, V29.16B
    FMINNM  V2.2S, V12.2S, V26.2S
    SQSUB  B18, B9, B13
    FADD  V29.4S, V23.4S, V6.4S
    SQRSHL  B30, B30, B31
    UQRSHL  H24, H17, H7
    SRHADD  V5.4H, V1.4H, V10.4H
    FMLA  V14.2S, V20.2S, V19.2S
    SRHADD  V25.4H, V18.4H, V1.4H
    FMAXNM  V30.2D, V2.2D, V5.2D
    FRSQRTS  D17, D20, D25
    BSL  V20.8B, V1.8B, V17.8B
    USHL  V29.2S, V29.2S, V30.2S
    URSHL  V20.4S, V17.4S, V22.4S
    UQSUB  B25, B18, B19
    FMAXNM  V31.2D, V31.2D, V5.2D
    FMULX  S10, S11, S9
    SSHL  V10.2S, V2.2S, V22.2S
    UMAX  V5.8H, V27.8H, V21.8H
    FMAXNM  V1.4S, V12.4S, V25.4S
    FSUB  V0.4S, V22.4S, V2.4S
    FRECPE  V14.2D, V15.2D
    MLS  V19.4S, V14.4S, V9.4S
    SQSHL  H14, H16, H25
    URSHL  D16, D17, D25
    SQADD  B30, B9, B11
    FSUB  V0.2S, V26.2S, V8.2S
    FMINNM  V23.4S, V7.4S, V19.4S
    FSUB  V0.4S, V5.4S, V5.4S
    UQSUB  V27.4H, V27.4H, V7.4H
    SRSHL  D27, D29, D11
    USHL  D25, D8, D21
    UMIN  V8.2S, V11.2S, V13.2S
    ADD  V25.8H, V8.8H, V1.8H
    FADD  V23.4S, V24.4S, V3.4S
    ORR  V30.8B, V17.8B, V18.8B
    SMAX  V23.8H, V27.8H, V12.8H
    UQADD  V31.2S, V19.2S, V5.2S
    SQSHL  V7.4H, V17.4H, V30.4H
    SHSUB  V3.2S, V18.2S, V18.2S
    SABDL2  V22.4S, V20.8H, V28.8H
    ADD  V20.16B, V24.16B, V31.16B
    UMIN  V30.4S, V27.4S, V4.4S
    UQRSHL  D14, D17, D4
    USHL  D12, D30, D16
    BIT  V3.16B, V0.16B, V0.16B
    UQSUB  B26, B24, B14
    ORR  V2.8B, V24.8B, V16.8B
    FMULX  S20, S0, S1
    EOR  V30.8B, V14.8B, V11.8B
    FMINNM  V29.4S, V18.4S, V19.4S
    UQRSHL  H11, H4, H24
    SQSHL  S8, S0, S15
    SQRSHL  D3, D25, D7
    SUB  D23, D28, D17
    SUB  D22, D7, D10
    FRECPE  V31.4S, V21.4S
    FRSQRTS  D21, D8, D25
    MLS  V4.8B, V12.8B, V28.8B
    UQRSHL  H1, H27, H17
    SQSUB  S16, S27, S20
    UQSUB  V30.4H, V25.4H, V25.4H
    FRECPE  D19, D18
    BIF  V24.16B, V11.16B, V4.16B
    ORN  V11.16B, V16.16B, V19.16B
    FMULX  S8, S26, S8
    FMINNM  V8.4S, V10.4S, V20.4S
    UABA  V14.4S, V18.4S, V27.4S
    USHL  V27.8H, V28.8H, V10.8H
    ORR  V3.16B, V19.16B, V27.16B
    UQSUB  H26, H22, H2
    SRSHL  D18, D16, D10
    ORR  V16.16B, V31.16B, V18.16B
    SQRSHL  B7, B9, B19
    UQADD  H27, H15, H5
    UABA  V4.16B, V7.16B, V18.16B
    UHADD  V27.2S, V12.2S, V9.2S
    SQSUB  V9.8B, V13.8B, V30.8B
    SQRSHL  B14, B26, B23
    UQADD  V13.2S, V27.2S, V28.2S
    UQSUB  V4.2D, V8.2D, V18.2D
    FRSQRTS  D15, D20, D17
    SQSHL  V28.4S, V21.4S, V14.4S
    SQSHL  S23, S11, S5
    UMIN  V23.4H, V25.4H, V3.4H
    SQSHL  V20.8B, V7.8B, V19.8B
    FABD  V14.2S, V4.2S, V7.2S
    FMAXNM  V18.2D, V8.2D, V10.2D
    UQRSHL  D0, D25, D27
    ORN  V30.8B, V17.8B, V22.8B
    FRECPE  V28.2D, V16.2D
    SQRSHL  S11, S10, S17
    UQADD  S11, S23, S28
    SABDL  V19.2D, V31.2S, V20.2S
    SQADD  S7, S11, S19
    FMLS  V4.4S, V27.4S, V15.4S
    SSHL  V19.2S, V13.2S, V16.2S
    FDIV  V17.4S, V2.4S, V23.4S
    MOV  V3.8B, V30.8B
    UQSUB  D14, D0, D0
    MLS  V9.4S, V12.4S, V22.4S
    FMULX  S7, S12, S3
    UQADD  S10, S16, S19
    ORN  V20.16B, V1.16B, V25.16B
    SMAX  V18.4H, V30.4H, V23.4H
    URHADD  V14.4S, V23.4S, V4.4S
    FDIV  V23.4S, V10.4S, V27.4S
    FABD  D8, D25, D17
    UQSUB  V20.16B, V4.16B, V9.16B
    URSHL  V28.8B, V12.8B, V22.8B
    SQSUB  B11, B8, B18
    SQADD  B10, B5, B20
    MLA  V5.8B, V6.8B, V16.8B
    FMULX  D21, D22, D7
    SUB  D23, D4, D11
    SQSUB  S28, S16, S12
    SUBS  X24, X24, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_249
    MOVZ  X8, #0x1b62, LSL #0
    MOVK  X8, #0xd141, LSL #16
    MOVK  X8, #0xf9ec, LSL #32
    MOVK  X8, #0x20ce, LSL #48
    SUB  X11, X8, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x40e3, LSL #0
    MOVK  X20, #0x7808, LSL #16
    MOVK  X20, #0x7cca, LSL #32
    MOVK  X20, #0xe6b, LSL #48
    SUB  X16, X20, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0xa417, LSL #0
    MOVK  X27, #0x3d27, LSL #16
    MOVK  X27, #0xec74, LSL #32
    MOVK  X27, #0x1a4e, LSL #48
    SUB  X16, X27, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0xd3f3, LSL #0
    MOVK  X18, #0x7f29, LSL #16
    MOVK  X18, #0xdfde, LSL #32
    MOVK  X18, #0x933b, LSL #48
    SUB  X11, X18, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0xd214, LSL #0
    MOVK  X22, #0xd6e9, LSL #16
    MOVK  X22, #0x3443, LSL #32
    MOVK  X22, #0x1ed4, LSL #48
    SUB  X7, X22, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x1b62, LSL #0
    MOVK  X2, #0xd141, LSL #16
    MOVK  X2, #0xf9ec, LSL #32
    MOVK  X2, #0x20ce, LSL #48
    SUB  X29, X2, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0xe9b8, LSL #0
    MOVK  X16, #0x5b49, LSL #16
    MOVK  X16, #0x4b4, LSL #32
    MOVK  X16, #0x586c, LSL #48
    SUB  X14, X16, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x83fd, LSL #0
    MOVK  X12, #0xc4f1, LSL #16
    MOVK  X12, #0xfd65, LSL #32
    MOVK  X12, #0x5ddf, LSL #48
    SUB  X26, X12, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x722d, LSL #0
    MOVK  X24, #0x5aa9, LSL #16
    MOVK  X24, #0xc116, LSL #32
    MOVK  X24, #0x5d1, LSL #48
    SUB  X17, X24, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0xe9b8, LSL #0
    MOVK  X10, #0x5b49, LSL #16
    MOVK  X10, #0x4b4, LSL #32
    MOVK  X10, #0x586c, LSL #48
    SUB  X18, X10, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0xdddd, LSL #0
    MOVK  X8, #0xc5c5, LSL #16
    MOVK  X8, #0x6f0d, LSL #32
    MOVK  X8, #0x92f, LSL #48
    SUB  X21, X8, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x40e3, LSL #0
    MOVK  X12, #0x7808, LSL #16
    MOVK  X12, #0x7cca, LSL #32
    MOVK  X12, #0xe6b, LSL #48
    SUB  X11, X12, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0xc745, LSL #0
    MOVK  X2, #0xd179, LSL #16
    MOVK  X2, #0xb5d0, LSL #32
    MOVK  X2, #0x73e7, LSL #48
    SUB  X14, X2, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0xa417, LSL #0
    MOVK  X8, #0x3d27, LSL #16
    MOVK  X8, #0xec74, LSL #32
    MOVK  X8, #0x1a4e, LSL #48
    SUB  X20, X8, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D2
    MOVZ  X8, #0x1e25, LSL #0
    MOVK  X8, #0x1ffc, LSL #48
    SUB  X10, X8, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D3
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xfff8, LSL #48
    SUB  X2, X11, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D5
    MOVZ  X26, #0xef35, LSL #0
    MOVK  X26, #0x80, LSL #16
    SUB  X13, X26, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D6
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D7
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X20, X17, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D8
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7f80, LSL #16
    MOVK  X20, #0x7f80, LSL #48
    SUB  X7, X20, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D10
    MOVZ  X25, #0x35, LSL #0
    SUB  X12, X25, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D11
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D12
    MOVZ  X15, #0x0, LSL #0
    SUB  X29, X15, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D13
    MOVZ  X29, #0x7fff, LSL #0
    SUB  X3, X29, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D15
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x3ff8, LSL #48
    SUB  X12, X16, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7f80, LSL #16
    MOVK  X17, #0x7f80, LSL #48
    SUB  X15, X17, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D16
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7f80, LSL #16
    MOVK  X17, #0x7f80, LSL #48
    SUB  X15, X17, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    MOVK  X13, #0x7fc0, LSL #48
    SUB  X15, X13, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D17
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7f80, LSL #16
    MOVK  X13, #0x7f80, LSL #48
    SUB  X15, X13, X22
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D18
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X12, X20, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D19
    MOVZ  X20, #0x7fff, LSL #0
    SUB  X12, X20, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D22
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x3f, LSL #48
    SUB  X6, X29, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D23
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D25
    MOVZ  X28, #0xfd, LSL #0
    SUB  X8, X28, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D27
    MOVZ  X5, #0x7fff, LSL #0
    SUB  X17, X5, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D28
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7f80, LSL #16
    SUB  X29, X17, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D29
    MOVZ  X16, #0xff, LSL #0
    SUB  X14, X16, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  V0.D[1], X20
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X14
    FMOV  V2.D[1], X11
    FMOV  D3, X12
    FMOV  V3.D[1], X19
    FMOV  D4, X24
    FMOV  V4.D[1], X22
    FMOV  D5, X19
    FMOV  V5.D[1], X10
    FMOV  D6, X28
    FMOV  V6.D[1], X16
    FMOV  D7, X26
    FMOV  V7.D[1], X16
    FMOV  D8, X27
    FMOV  V8.D[1], X6
    FMOV  D9, X4
    FMOV  V9.D[1], X17
    FMOV  D10, X25
    FMOV  V10.D[1], X24
    FMOV  D11, X12
    FMOV  V11.D[1], X10
    FMOV  D12, X22
    FMOV  V12.D[1], X7
    FMOV  D13, X26
    FMOV  V13.D[1], X21
    FMOV  D14, X11
    FMOV  V14.D[1], X2
    FMOV  D15, X11
    FMOV  V15.D[1], X17
    FMOV  D16, X25
    FMOV  V16.D[1], X3
    FMOV  D17, X25
    FMOV  V17.D[1], X26
    FMOV  D18, X19
    FMOV  V18.D[1], X20
    FMOV  D19, X4
    FMOV  V19.D[1], X17
    FMOV  D20, X22
    FMOV  V20.D[1], X7
    FMOV  D21, X28
    FMOV  V21.D[1], X24
    FMOV  D22, X29
    FMOV  V22.D[1], X16
    FMOV  D23, X26
    FMOV  V23.D[1], X19
    FMOV  D24, X20
    FMOV  V24.D[1], X14
    FMOV  D25, X3
    FMOV  V25.D[1], X29
    FMOV  D26, X3
    FMOV  V26.D[1], X14
    FMOV  D27, X20
    FMOV  V27.D[1], X11
    FMOV  D28, X6
    FMOV  V28.D[1], X14
    FMOV  D29, X16
    FMOV  V29.D[1], X5
    FMOV  D30, X16
    FMOV  V30.D[1], X14
    FMOV  D31, X11
    FMOV  V31.D[1], X8
    MOVZ  X6, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_332:
    SQRSHL  H29, H13, H26
    MLA  V10.8B, V12.8B, V8.8B
    UQRSHL  V13.4S, V26.4S, V29.4S
    BIF  V0.8B, V14.8B, V12.8B
    SQSHL  B18, B13, B27
    UMAX  V28.2S, V1.2S, V28.2S
    FMULX  S22, S26, S18
    ADD  D19, D25, D10
    SQADD  B29, B19, B25
    ADD  V13.8B, V15.8B, V28.8B
    SQSUB  B8, B3, B26
    SQSUB  V29.8B, V13.8B, V27.8B
    SHADD  V19.4H, V13.4H, V27.4H
    FRSQRTS  D13, D7, D31
    SABDL  V24.4S, V17.4H, V22.4H
    UQADD  H0, H23, H25
    SRSHL  D2, D8, D12
    BIC  V12.8B, V29.8B, V12.8B
    SABDL  V18.2D, V6.2S, V18.2S
    UQADD  V30.2D, V24.2D, V31.2D
    FMULX  S24, S6, S4
    ORR  V4.16B, V23.16B, V9.16B
    FRSQRTS  V17.4S, V15.4S, V6.4S
    FMAX  V15.2S, V3.2S, V0.2S
    UQRSHL  D18, D19, D28
    FRSQRTS  S2, S30, S4
    UHSUB  V13.8H, V19.8H, V18.8H
    SMIN  V0.4S, V0.4S, V12.4S
    FMUL  V9.2D, V29.2D, V3.2D
    FRSQRTS  S24, S27, S9
    SSHL  D20, D8, D26
    EOR  V20.16B, V2.16B, V8.16B
    BIC  V26.8B, V7.8B, V9.8B
    UQRSHL  S19, S13, S30
    SQRSHL  D15, D22, D0
    FABD  S0, S10, S23
    USHL  V14.8B, V9.8B, V17.8B
    USHL  D5, D14, D31
    MLS  V30.2S, V20.2S, V1.2S
    URSHL  V30.16B, V29.16B, V31.16B
    SQSHL  D22, D6, D18
    URHADD  V3.16B, V14.16B, V19.16B
    SQADD  B23, B2, B5
    SQSHL  H1, H28, H13
    FRECPE  D29, D31
    SQRSHL  S7, S23, S20
    ADD  V5.8B, V29.8B, V25.8B
    SQSUB  H12, H3, H18
    UQADD  B1, B5, B31
    UQADD  H29, H19, H24
    FABD  V27.4S, V1.4S, V18.4S
    SQRSHL  H4, H27, H8
    AND  V29.8B, V12.8B, V12.8B
    SHSUB  V23.16B, V4.16B, V12.16B
    ADD  D31, D13, D29
    UQSUB  B26, B5, B9
    SQRSHL  S6, S26, S0
    SQSHL  B27, B7, B21
    SQADD  H8, H9, H18
    SQSHL  V1.8B, V30.8B, V21.8B
    FRECPE  D15, D16
    SABD  V21.4S, V12.4S, V21.4S
    SSHL  V14.4S, V29.4S, V11.4S
    UQSUB  B15, B6, B26
    FMULX  V28.4S, V1.4S, V23.4S
    UMIN  V17.16B, V17.16B, V24.16B
    SQADD  D1, D15, D20
    FMINNM  V19.2S, V29.2S, V14.2S
    SUB  V19.8B, V3.8B, V14.8B
    BIF  V5.16B, V19.16B, V4.16B
    ADD  D12, D7, D2
    FABD  S7, S28, S21
    UQADD  S1, S9, S20
    EOR  V9.16B, V31.16B, V15.16B
    SQRSHL  B23, B21, B26
    FRSQRTS  V25.2D, V17.2D, V6.2D
    UHADD  V7.8H, V6.8H, V3.8H
    FSUB  V5.2D, V16.2D, V8.2D
    SMAX  V18.2S, V12.2S, V5.2S
    ORR  V9.8B, V22.8B, V16.8B
    SQSHL  H9, H7, H2
    FMLA  V15.2D, V7.2D, V1.2D
    SABD  V21.2S, V13.2S, V8.2S
    FMULX  S27, S17, S13
    SUB  D4, D15, D23
    SQRSHL  S4, S18, S7
    FABD  V25.2D, V16.2D, V28.2D
    FRSQRTS  D5, D17, D4
    SQADD  B21, B28, B23
    FMIN  V5.2D, V12.2D, V31.2D
    SABDL2  V20.8H, V27.16B, V2.16B
    SSHL  D12, D14, D18
    UQSUB  B12, B12, B29
    FRECPE  V13.2S, V19.2S
    UMAX  V11.4S, V18.4S, V25.4S
    ADD  D26, D16, D21
    SQRSHL  H11, H28, H28
    FRSQRTS  V12.2S, V7.2S, V17.2S
    UHSUB  V17.16B, V17.16B, V11.16B
    FMLA  V2.4S, V8.4S, V23.4S
    ADD  V20.8B, V22.8B, V28.8B
    UQADD  H19, H5, H29
    FMAXNM  V17.2D, V2.2D, V13.2D
    SQSUB  V0.4H, V6.4H, V26.4H
    FRSQRTS  V27.2S, V25.2S, V7.2S
    BIC  V2.16B, V16.16B, V25.16B
    SSHL  V26.4S, V4.4S, V28.4S
    SRSHL  D12, D17, D17
    SQADD  D11, D13, D12
    FABD  D22, D0, D7
    BIF  V5.8B, V2.8B, V21.8B
    SSHL  D30, D3, D8
    FABD  V6.4S, V19.4S, V30.4S
    UABA  V2.8H, V10.8H, V4.8H
    FMAXNM  V20.4S, V4.4S, V18.4S
    FABD  D9, D4, D22
    FMULX  D23, D12, D30
    UQSUB  D23, D21, D8
    SQSUB  S2, S27, S14
    FMUL  V17.2D, V21.2D, V29.2D
    FRSQRTS  S4, S5, S2
    MUL  V5.2S, V8.2S, V20.2S
    ORN  V2.16B, V6.16B, V6.16B
    SRSHL  D0, D19, D11
    UQADD  D4, D26, D11
    MLS  V0.4H, V29.4H, V2.4H
    BIF  V21.16B, V8.16B, V1.16B
    SQADD  B26, B3, B20
    UQSUB  D17, D16, D20
    FMUL  V22.4S, V28.4S, V17.4S
    UQRSHL  V22.16B, V29.16B, V19.16B
    FRSQRTS  D0, D29, D16
    UABA  V24.8B, V15.8B, V0.8B
    SRSHL  V28.4S, V2.4S, V27.4S
    FMIN  V6.2D, V0.2D, V27.2D
    ORR  V23.8B, V9.8B, V6.8B
    UQADD  D18, D16, D31
    FRECPE  S29, S25
    SQSUB  S9, S5, S6
    FRECPE  V1.4S, V20.4S
    SABD  V2.8H, V17.8H, V27.8H
    USHL  V24.4H, V1.4H, V7.4H
    BSL  V4.8B, V16.8B, V17.8B
    FRSQRTS  D9, D21, D7
    UQSUB  B22, B24, B19
    SQSHL  D3, D6, D5
    FMLS  V29.2D, V24.2D, V14.2D
    MLS  V23.4S, V8.4S, V28.4S
    SQSUB  H18, H4, H25
    UQRSHL  D11, D14, D31
    AND  V2.16B, V1.16B, V11.16B
    FMIN  V26.2S, V12.2S, V9.2S
    SABDL2  V16.4S, V15.8H, V27.8H
    SMIN  V15.2S, V27.2S, V20.2S
    UQADD  S15, S22, S0
    FADD  V19.4S, V23.4S, V3.4S
    EOR  V11.16B, V2.16B, V4.16B
    ORN  V19.8B, V22.8B, V4.8B
    FADD  V31.4S, V2.4S, V2.4S
    SABDL  V0.8H, V18.8B, V0.8B
    URSHL  D7, D9, D14
    SRSHL  D0, D29, D13
    UQADD  V27.8H, V23.8H, V4.8H
    FMAXNM  V12.2S, V25.2S, V18.2S
    ORN  V0.8B, V15.8B, V23.8B
    SRSHL  V17.8H, V20.8H, V27.8H
    UQADD  D18, D6, D6
    SABD  V25.4H, V12.4H, V7.4H
    FDIV  V16.4S, V25.4S, V13.4S
    SSHL  D21, D2, D16
    SQSHL  V25.8B, V27.8B, V21.8B
    UHSUB  V6.2S, V11.2S, V3.2S
    BIC  V0.8B, V15.8B, V11.8B
    SSHL  D7, D17, D20
    SQSHL  D0, D12, D18
    UQRSHL  D30, D17, D12
    SQRSHL  H17, H1, H4
    SQRSHL  V28.4H, V25.4H, V18.4H
    ADD  V23.8H, V4.8H, V30.8H
    ORN  V21.8B, V16.8B, V27.8B
    FMIN  V13.2D, V0.2D, V22.2D
    MOV  V16.16B, V11.16B
    SQSUB  V5.8B, V30.8B, V20.8B
    FMLS  V5.2S, V21.2S, V24.2S
    BIC  V17.8B, V21.8B, V10.8B
    FRSQRTS  D15, D1, D24
    BIF  V16.16B, V23.16B, V31.16B
    SQADD  V6.4S, V9.4S, V3.4S
    UQRSHL  D19, D19, D12
    UQADD  H14, H29, H4
    SABD  V0.8H, V4.8H, V2.8H
    ADD  D5, D27, D29
    URSHL  V3.4S, V9.4S, V13.4S
    SQSUB  D4, D5, D31
    SSHL  D12, D0, D7
    FRECPE  V8.2D, V5.2D
    ORR  V19.16B, V16.16B, V31.16B
    UQRSHL  S15, S3, S28
    SQADD  S29, S14, S5
    FRECPE  V4.2D, V15.2D
    SUBS  X6, X6, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_332
    MOVZ  X25, #0x0, LSL #0
    SUB  X27, X25, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
TaishanSimdPairArithmeticP01_label_71:
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X25
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D3
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x3ff8, LSL #48
    SUB  X8, X12, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7ff0, LSL #48
    SUB  X23, X20, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D4
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7ff0, LSL #48
    SUB  X23, X20, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D5
    MOVZ  X24, #0x1fff, LSL #0
    MOVK  X24, #0x80bb, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xbd4c, LSL #48
    SUB  X19, X24, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D6
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xbff8, LSL #48
    SUB  X4, X14, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x7ff0, LSL #48
    SUB  X3, X7, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D8
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xb000, LSL #32
    MOVK  X7, #0xc291, LSL #48
    SUB  X3, X7, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D10
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xfe80, LSL #48
    SUB  X27, X29, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D11
    MOVZ  X27, #0xfffe, LSL #0
    MOVK  X27, #0xe3e, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X13, X27, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D12
    MOVZ  X14, #0x2, LSL #0
    MOVK  X14, #0xe3e, LSL #16
    MOVK  X14, #0x1, LSL #32
    MOVK  X14, #0x1, LSL #48
    SUB  X19, X14, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D14
    MOVZ  X21, #0xffff, LSL #0
    SUB  X8, X21, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D15
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D16
    MOVZ  X11, #0x25, LSL #0
    MOVK  X11, #0xe3e, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X7, X11, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D17
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xf1c1, LSL #16
    SUB  X11, X18, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D18
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X5, X21, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D19
    MOVZ  X8, #0x25, LSL #0
    MOVK  X8, #0xe3e, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X6, X8, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D20
    MOVZ  X3, #0x99, LSL #0
    MOVK  X3, #0x3fc0, LSL #16
    SUB  X17, X3, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D21
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xf1c1, LSL #16
    SUB  X14, X3, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D22
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D23
    MOVZ  X21, #0x25, LSL #0
    MOVK  X21, #0xe3e, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D24
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x3f2a, LSL #16
    MOVK  X18, #0x7f80, LSL #48
    SUB  X22, X18, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D25
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xe3e, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D26
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x3ff8, LSL #48
    SUB  X25, X4, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D27
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xe3e, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D28
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x71f, LSL #16
    SUB  X22, X2, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D29
    MOVZ  X17, #0x1ffe, LSL #0
    MOVK  X17, #0x80bc, LSL #16
    SUB  X6, X17, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  V0.D[1], X20
    FMOV  D1, X25
    FMOV  V1.D[1], X2
    FMOV  D2, X28
    FMOV  V2.D[1], X13
    FMOV  D3, X29
    FMOV  V3.D[1], X5
    FMOV  D4, X29
    FMOV  V4.D[1], X25
    FMOV  D5, X27
    FMOV  V5.D[1], X25
    FMOV  D6, X29
    FMOV  V6.D[1], X26
    FMOV  D7, X21
    FMOV  V7.D[1], X29
    FMOV  D8, X13
    FMOV  V8.D[1], X10
    FMOV  D9, X18
    FMOV  V9.D[1], X13
    FMOV  D10, X26
    FMOV  V10.D[1], X27
    FMOV  D11, X4
    FMOV  V11.D[1], X16
    FMOV  D12, X8
    FMOV  V12.D[1], X14
    FMOV  D13, X24
    FMOV  V13.D[1], X11
    FMOV  D14, X8
    FMOV  V14.D[1], X24
    FMOV  D15, X8
    FMOV  V15.D[1], X2
    FMOV  D16, X23
    FMOV  V16.D[1], X5
    FMOV  D17, X29
    FMOV  V17.D[1], X14
    FMOV  D18, X25
    FMOV  V18.D[1], X17
    FMOV  D19, X10
    FMOV  V19.D[1], X19
    FMOV  D20, X24
    FMOV  V20.D[1], X24
    FMOV  D21, X25
    FMOV  V21.D[1], X26
    FMOV  D22, X18
    FMOV  V22.D[1], X23
    FMOV  D23, X8
    FMOV  V23.D[1], X14
    FMOV  D24, X13
    FMOV  V24.D[1], X17
    FMOV  D25, X22
    FMOV  V25.D[1], X23
    FMOV  D26, X10
    FMOV  V26.D[1], X14
    FMOV  D27, X15
    FMOV  V27.D[1], X15
    FMOV  D28, X2
    FMOV  V28.D[1], X10
    FMOV  D29, X14
    FMOV  V29.D[1], X29
    FMOV  D30, X28
    FMOV  V30.D[1], X21
    FMOV  D31, X18
    FMOV  V31.D[1], X23
    MOVZ  X15, #0xf, LSL #0
TaishanSimdPairArithmeticP01_label_415:
    SABDL2  V18.8H, V9.16B, V14.16B
    FMULX  D7, D0, D3
    FRSQRTS  V16.2S, V30.2S, V4.2S
    SQADD  H28, H30, H4
    SRSHL  D16, D8, D27
    SQSUB  H4, H10, H16
    SQADD  B25, B8, B31
    FRSQRTS  S28, S18, S13
    FMAXNM  V23.2S, V7.2S, V13.2S
    MUL  V28.4S, V29.4S, V4.4S
    UHADD  V11.2S, V4.2S, V25.2S
    ADD  D24, D11, D11
    SQADD  H12, H8, H23
    MOV  V21.16B, V17.16B
    FSUB  V5.2D, V7.2D, V5.2D
    UQADD  H7, H5, H23
    SQSUB  S7, S17, S21
    SQADD  S12, S19, S20
    BSL  V26.16B, V8.16B, V24.16B
    FMAXNM  V27.4S, V23.4S, V30.4S
    FRECPE  S30, S12
    UQADD  H2, H8, H28
    SRSHL  D29, D5, D31
    UMAX  V3.8H, V5.8H, V12.8H
    BIT  V2.16B, V14.16B, V13.16B
    SQRSHL  V17.2D, V20.2D, V17.2D
    UHSUB  V9.2S, V7.2S, V8.2S
    SQSUB  B8, B1, B15
    UQADD  D12, D27, D0
    SQADD  V13.8B, V27.8B, V25.8B
    UQSUB  D26, D10, D15
    FMULX  D16, D26, D19
    FMINNM  V21.2S, V26.2S, V23.2S
    FMULX  D18, D0, D18
    SUB  V21.2D, V30.2D, V22.2D
    SABDL2  V10.4S, V22.8H, V29.8H
    UQRSHL  V30.8B, V10.8B, V1.8B
    SQRSHL  B0, B20, B18
    BIC  V24.8B, V12.8B, V24.8B
    FRECPE  D11, D26
    FRSQRTS  S15, S7, S6
    SQSHL  V16.2D, V9.2D, V10.2D
    FRECPE  V4.2S, V3.2S
    EOR  V9.8B, V6.8B, V24.8B
    ADD  D20, D19, D11
    UQSUB  B7, B28, B0
    SRSHL  D7, D12, D21
    FMAX  V13.4S, V28.4S, V26.4S
    SQRSHL  V13.16B, V23.16B, V25.16B
    EOR  V8.8B, V28.8B, V21.8B
    SABD  V17.8H, V0.8H, V4.8H
    SMAX  V7.8H, V15.8H, V17.8H
    URHADD  V13.4H, V16.4H, V24.4H
    FADD  V30.2S, V22.2S, V23.2S
    ADD  D9, D12, D31
    FADD  V30.2D, V17.2D, V28.2D
    UQSUB  H28, H30, H30
    SQRSHL  B14, B18, B13
    SQRSHL  S20, S5, S23
    FMLS  V8.4S, V7.4S, V31.4S
    SQRSHL  V11.2S, V8.2S, V11.2S
    SQSUB  S13, S2, S3
    UABA  V13.4S, V28.4S, V14.4S
    FRECPE  D19, D20
    BSL  V6.8B, V28.8B, V18.8B
    SMAX  V4.4S, V1.4S, V13.4S
    FMULX  V31.2S, V17.2S, V28.2S
    SABD  V17.8H, V26.8H, V27.8H
    UABA  V17.8B, V30.8B, V2.8B
    FRSQRTS  D4, D16, D24
    UQADD  V12.2S, V20.2S, V25.2S
    UQSUB  V1.8B, V9.8B, V31.8B
    BIT  V2.16B, V15.16B, V29.16B
    URHADD  V11.8B, V22.8B, V11.8B
    SQSUB  S18, S31, S19
    ORR  V6.8B, V5.8B, V20.8B
    FDIV  V17.2D, V20.2D, V7.2D
    SRSHL  D23, D4, D1
    FRSQRTS  D17, D9, D30
    FABD  D22, D1, D2
    SMAX  V27.2S, V2.2S, V22.2S
    FRECPE  V25.2D, V6.2D
    MLS  V0.8H, V27.8H, V6.8H
    SMIN  V13.8H, V16.8H, V5.8H
    URHADD  V11.4S, V5.4S, V2.4S
    ADD  V15.16B, V30.16B, V15.16B
    UQRSHL  B7, B8, B15
    SQADD  V15.2S, V1.2S, V26.2S
    UQADD  V15.8B, V24.8B, V1.8B
    FMULX  V25.2S, V17.2S, V19.2S
    SRHADD  V22.4H, V4.4H, V0.4H
    FMULX  D29, D25, D16
    FMAXNM  V3.2S, V30.2S, V30.2S
    SQRSHL  D7, D6, D29
    FMULX  S30, S18, S19
    SMIN  V25.8H, V0.8H, V3.8H
    ORN  V9.8B, V1.8B, V20.8B
    UQADD  D13, D17, D15
    SRSHL  V11.2D, V11.2D, V9.2D
    FMULX  V9.2D, V29.2D, V3.2D
    SQRSHL  D4, D11, D23
    UQADD  V14.8B, V30.8B, V28.8B
    UQSUB  B13, B9, B3
    UQADD  H13, H23, H6
    BIC  V5.16B, V12.16B, V31.16B
    BIC  V4.16B, V5.16B, V4.16B
    UQSUB  D30, D4, D26
    FRECPE  V15.4S, V2.4S
    UQSUB  S19, S24, S10
    UQADD  H31, H22, H5
    FABD  D26, D8, D1
    UQRSHL  D9, D19, D8
    SQSUB  S21, S12, S15
    SQSUB  H16, H12, H2
    SABD  V14.2S, V9.2S, V29.2S
    FADD  V7.2S, V29.2S, V28.2S
    UQRSHL  V16.4H, V30.4H, V13.4H
    UQADD  S15, S29, S25
    SRHADD  V15.8H, V26.8H, V3.8H
    SQSHL  B14, B9, B16
    FDIV  V18.2D, V28.2D, V25.2D
    SSHL  V30.2S, V0.2S, V31.2S
    SQRSHL  V16.4S, V20.4S, V23.4S
    UHSUB  V24.2S, V16.2S, V23.2S
    SABDL  V2.4S, V26.4H, V12.4H
    UQSUB  H14, H2, H10
    FRECPE  S11, S7
    UMIN  V8.4S, V15.4S, V28.4S
    UMAX  V6.8H, V6.8H, V19.8H
    SQADD  S3, S21, S11
    UQRSHL  S12, S19, S5
    UQRSHL  H16, H5, H25
    SQRSHL  B27, B8, B28
    BIF  V17.8B, V2.8B, V3.8B
    SABDL2  V30.2D, V27.4S, V18.4S
    SQADD  V27.2D, V5.2D, V21.2D
    FMULX  S30, S25, S14
    SQRSHL  H28, H13, H15
    UHADD  V0.4H, V23.4H, V17.4H
    MOV  V0.8B, V8.8B
    UQADD  S28, S10, S1
    SQADD  B28, B1, B20
    UMAX  V10.2S, V14.2S, V18.2S
    FRECPE  D30, D2
    MLA  V0.8B, V3.8B, V6.8B
    FABD  S12, S19, S16
    UQRSHL  V13.4S, V29.4S, V5.4S
    USHL  D10, D31, D27
    AND  V13.16B, V30.16B, V9.16B
    UQADD  S24, S27, S23
    FRECPE  S25, S14
    UHADD  V9.2S, V7.2S, V1.2S
    UQADD  S1, S3, S16
    FRECPE  S7, S11
    ADD  V4.2S, V5.2S, V22.2S
    SUB  D27, D26, D7
    SQSHL  B19, B18, B13
    SQADD  S31, S29, S27
    UQSUB  B12, B0, B20
    ORR  V15.16B, V23.16B, V31.16B
    SQSUB  S2, S7, S24
    URHADD  V28.8H, V19.8H, V25.8H
    FADD  V14.2S, V21.2S, V17.2S
    SQADD  V5.4S, V27.4S, V24.4S
    USHL  D4, D16, D18
    FADD  V21.2D, V0.2D, V19.2D
    ADD  D6, D9, D26
    SQSUB  S16, S12, S8
    EOR  V18.16B, V7.16B, V30.16B
    MLA  V15.2S, V1.2S, V28.2S
    SQSUB  B2, B10, B15
    FMAX  V16.2D, V11.2D, V22.2D
    UQADD  S5, S10, S22
    FMAXNM  V28.2D, V23.2D, V27.2D
    SHSUB  V30.4S, V22.4S, V27.4S
    USHL  D1, D5, D25
    UHSUB  V27.4S, V11.4S, V12.4S
    MLA  V15.4S, V18.4S, V25.4S
    FMULX  S14, S24, S24
    SQSHL  D6, D20, D25
    SHADD  V23.16B, V1.16B, V5.16B
    SABDL2  V8.2D, V10.4S, V2.4S
    SQADD  S12, S5, S12
    SQADD  S13, S5, S25
    UQADD  B26, B13, B12
    UQSUB  V17.16B, V5.16B, V21.16B
    SHSUB  V6.4S, V13.4S, V28.4S
    SQSUB  H31, H31, H4
    SQSHL  D11, D14, D15
    BIT  V7.8B, V9.8B, V4.8B
    SQADD  H2, H15, H9
    UHSUB  V28.2S, V14.2S, V20.2S
    BIF  V15.8B, V23.8B, V11.8B
    FSUB  V25.2D, V1.2D, V17.2D
    SABDL  V26.2D, V22.2S, V18.2S
    USHL  D1, D21, D19
    SABDL2  V18.8H, V17.16B, V29.16B
    SQSHL  V21.4H, V15.4H, V6.4H
    FADD  V10.4S, V13.4S, V17.4S
    SHADD  V25.4S, V14.4S, V31.4S
    SUBS  X15, X15, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_415
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X11, X4, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X11, X18, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X14, X22, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X27, X28, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X12, X8, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X27, X24, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X27, X14, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X23, X7, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X25, X10, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X26, X11, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X15, X21, X15
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X8, X29, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X25, X23, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X23, X29, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X27, X4, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X14, X4, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X15, X13, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X19, X24, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D2
    MOVZ  X29, #0x7fa1, LSL #0
    SUB  X22, X29, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D3
    MOVZ  X2, #0x42, LSL #0
    SUB  X11, X2, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D4
    MOVZ  X2, #0x42, LSL #0
    SUB  X14, X2, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D6
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xffe0, LSL #16
    MOVK  X7, #0xc020, LSL #48
    SUB  X12, X7, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D8
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D10
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7f80, LSL #16
    SUB  X26, X29, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D12
    MOVZ  X16, #0x0, LSL #0
    SUB  X13, X16, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D13
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x7f80, LSL #16
    SUB  X17, X22, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D15
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D16
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x1ffc, LSL #48
    SUB  X12, X13, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D20
    MOVZ  X17, #0x0, LSL #0
    SUB  X26, X17, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D22
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x1ffc, LSL #48
    SUB  X18, X19, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D23
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D24
    MOVZ  X18, #0x84, LSL #0
    MOVK  X18, #0x8080, LSL #16
    SUB  X7, X18, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D25
    MOVZ  X26, #0x7fdf, LSL #0
    SUB  X27, X26, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5ff4, LSL #16
    SUB  X8, X24, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D26
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D27
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3fc0, LSL #16
    SUB  X15, X23, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D29
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    MOVK  X25, #0x7ff8, LSL #48
    SUB  X5, X25, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0xa31b, LSL #0
    MOVK  X2, #0x72bf, LSL #16
    MOVK  X2, #0xb06f, LSL #32
    MOVK  X2, #0xbcef, LSL #48
    MOVZ  X3, #0xbfd8, LSL #0
    MOVK  X3, #0x2e65, LSL #16
    MOVK  X3, #0x1c11, LSL #32
    MOVK  X3, #0xc492, LSL #48
    MOVZ  X4, #0x1012, LSL #0
    MOVK  X4, #0x14ee, LSL #16
    MOVK  X4, #0xfe9f, LSL #32
    MOVK  X4, #0x2df3, LSL #48
    MOVZ  X5, #0x4c04, LSL #0
    MOVK  X5, #0x694, LSL #16
    MOVK  X5, #0x3a96, LSL #32
    MOVK  X5, #0x9ac8, LSL #48
    MOVZ  X6, #0xff09, LSL #0
    MOVK  X6, #0x8866, LSL #16
    MOVK  X6, #0xb3a3, LSL #32
    MOVK  X6, #0x2fce, LSL #48
    MOVZ  X7, #0x6915, LSL #0
    MOVK  X7, #0x3eb8, LSL #16
    MOVK  X7, #0x135d, LSL #32
    MOVK  X7, #0x4519, LSL #48
    MOVZ  X8, #0xa152, LSL #0
    MOVK  X8, #0xacba, LSL #16
    MOVK  X8, #0x2909, LSL #32
    MOVK  X8, #0x8bbc, LSL #48
    MOVZ  X10, #0xfd1a, LSL #0
    MOVK  X10, #0x9c49, LSL #16
    MOVK  X10, #0xee46, LSL #32
    MOVK  X10, #0x80ea, LSL #48
    MOVZ  X11, #0x4a51, LSL #0
    MOVK  X11, #0x2b13, LSL #16
    MOVK  X11, #0x3020, LSL #32
    MOVK  X11, #0xcf51, LSL #48
    MOVZ  X12, #0xf78c, LSL #0
    MOVK  X12, #0xa0a6, LSL #16
    MOVK  X12, #0x744, LSL #32
    MOVK  X12, #0x47ca, LSL #48
    MOVZ  X13, #0x7ce9, LSL #0
    MOVK  X13, #0x2680, LSL #16
    MOVK  X13, #0x7a45, LSL #32
    MOVK  X13, #0xc80d, LSL #48
    MOVZ  X14, #0x2b8d, LSL #0
    MOVK  X14, #0xa9df, LSL #16
    MOVK  X14, #0x3a60, LSL #32
    MOVK  X14, #0xb65a, LSL #48
    MOVZ  X15, #0x9417, LSL #0
    MOVK  X15, #0x13d7, LSL #16
    MOVK  X15, #0x1e7a, LSL #32
    MOVK  X15, #0xeb29, LSL #48
    MOVZ  X16, #0xc9bd, LSL #0
    MOVK  X16, #0x9812, LSL #16
    MOVK  X16, #0xfa92, LSL #32
    MOVK  X16, #0xcc96, LSL #48
    MOVZ  X17, #0x24eb, LSL #0
    MOVK  X17, #0x8530, LSL #16
    MOVK  X17, #0x101e, LSL #32
    MOVK  X17, #0x7645, LSL #48
    MOVZ  X18, #0xcc55, LSL #0
    MOVK  X18, #0xa059, LSL #16
    MOVK  X18, #0xcb49, LSL #32
    MOVK  X18, #0x6d9d, LSL #48
    MOVZ  X19, #0x859f, LSL #0
    MOVK  X19, #0xd90f, LSL #16
    MOVK  X19, #0x68cd, LSL #32
    MOVK  X19, #0xd68e, LSL #48
    MOVZ  X20, #0xc698, LSL #0
    MOVK  X20, #0x9355, LSL #16
    MOVK  X20, #0x365c, LSL #32
    MOVK  X20, #0xb1a, LSL #48
    MOVZ  X21, #0xf483, LSL #0
    MOVK  X21, #0x1733, LSL #16
    MOVK  X21, #0xb0dd, LSL #32
    MOVK  X21, #0xa789, LSL #48
    MOVZ  X22, #0x9cb5, LSL #0
    MOVK  X22, #0x8cce, LSL #16
    MOVK  X22, #0x8fc7, LSL #32
    MOVK  X22, #0xc240, LSL #48
    MOVZ  X23, #0xf5f6, LSL #0
    MOVK  X23, #0x7fbe, LSL #16
    MOVK  X23, #0xdd16, LSL #32
    MOVK  X23, #0x312, LSL #48
    MOVZ  X24, #0xa011, LSL #0
    MOVK  X24, #0xe9a9, LSL #16
    MOVK  X24, #0x38bb, LSL #32
    MOVK  X24, #0xba17, LSL #48
    MOVZ  X25, #0xf440, LSL #0
    MOVK  X25, #0xe1cc, LSL #16
    MOVK  X25, #0xabfe, LSL #32
    MOVK  X25, #0xe198, LSL #48
    MOVZ  X26, #0x100f, LSL #0
    MOVK  X26, #0x43aa, LSL #16
    MOVK  X26, #0x74e9, LSL #32
    MOVK  X26, #0xd458, LSL #48
    MOVZ  X27, #0xb1c, LSL #0
    MOVK  X27, #0x9f40, LSL #16
    MOVK  X27, #0xe3b0, LSL #32
    MOVK  X27, #0x844a, LSL #48
    MOVZ  X28, #0xc898, LSL #0
    MOVK  X28, #0x5025, LSL #16
    MOVK  X28, #0x452b, LSL #32
    MOVK  X28, #0xac2c, LSL #48
    MOVZ  X29, #0x209, LSL #0
    MOVK  X29, #0xabc0, LSL #16
    MOVK  X29, #0xf83a, LSL #32
    MOVK  X29, #0xedf0, LSL #48
    FMOV  D0, X13
    FMOV  V0.D[1], X26
    FMOV  D1, X12
    FMOV  V1.D[1], X23
    FMOV  D2, X14
    FMOV  V2.D[1], X8
    FMOV  D3, X26
    FMOV  V3.D[1], X25
    FMOV  D4, X14
    FMOV  V4.D[1], X22
    FMOV  D5, X10
    FMOV  V5.D[1], X10
    FMOV  D6, X29
    FMOV  V6.D[1], X7
    FMOV  D7, X28
    FMOV  V7.D[1], X27
    FMOV  D8, X8
    FMOV  V8.D[1], X7
    FMOV  D9, X14
    FMOV  V9.D[1], X12
    FMOV  D10, X10
    FMOV  V10.D[1], X4
    FMOV  D11, X10
    FMOV  V11.D[1], X16
    FMOV  D12, X23
    FMOV  V12.D[1], X4
    FMOV  D13, X25
    FMOV  V13.D[1], X23
    FMOV  D14, X25
    FMOV  V14.D[1], X12
    FMOV  D15, X23
    FMOV  V15.D[1], X23
    FMOV  D16, X28
    FMOV  V16.D[1], X16
    FMOV  D17, X7
    FMOV  V17.D[1], X27
    FMOV  D18, X6
    FMOV  V18.D[1], X25
    FMOV  D19, X6
    FMOV  V19.D[1], X10
    FMOV  D20, X23
    FMOV  V20.D[1], X19
    FMOV  D21, X16
    FMOV  V21.D[1], X28
    FMOV  D22, X15
    FMOV  V22.D[1], X17
    FMOV  D23, X2
    FMOV  V23.D[1], X17
    FMOV  D24, X7
    FMOV  V24.D[1], X2
    FMOV  D25, X10
    FMOV  V25.D[1], X2
    FMOV  D26, X8
    FMOV  V26.D[1], X11
    FMOV  D27, X26
    FMOV  V27.D[1], X27
    FMOV  D28, X23
    FMOV  V28.D[1], X18
    FMOV  D29, X17
    FMOV  V29.D[1], X19
    FMOV  D30, X2
    FMOV  V30.D[1], X6
    FMOV  D31, X12
    FMOV  V31.D[1], X19
    MOVZ  X8, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_498:
    SRSHL  V15.4S, V25.4S, V25.4S
    ADD  D20, D7, D28
    USHL  V7.4H, V8.4H, V11.4H
    FMAX  V4.2S, V8.2S, V24.2S
    UQADD  H31, H20, H16
    ADD  V27.16B, V27.16B, V7.16B
    UHADD  V22.4S, V30.4S, V20.4S
    FRSQRTS  V0.2S, V1.2S, V0.2S
    UQSUB  D15, D26, D0
    ADD  D8, D4, D29
    UHADD  V0.8B, V23.8B, V20.8B
    SSHL  D9, D0, D23
    ORN  V1.16B, V28.16B, V20.16B
    UMIN  V27.8B, V2.8B, V1.8B
    UQSUB  H15, H1, H3
    FMLS  V15.2D, V11.2D, V11.2D
    SQSHL  H9, H22, H17
    SQSUB  V8.4H, V25.4H, V8.4H
    SQSUB  S17, S9, S31
    FABD  V25.2S, V22.2S, V8.2S
    UHSUB  V15.2S, V16.2S, V25.2S
    UQADD  S27, S21, S18
    UQADD  H31, H17, H15
    FABD  V0.4S, V11.4S, V1.4S
    UHSUB  V27.4H, V29.4H, V9.4H
    UQADD  S29, S0, S31
    FRSQRTS  S29, S13, S2
    FMINNM  V29.2S, V22.2S, V19.2S
    SABD  V30.16B, V26.16B, V26.16B
    SQADD  D28, D28, D0
    UQADD  S30, S28, S7
    FMULX  V27.4S, V30.4S, V23.4S
    FMAXNM  V12.2S, V29.2S, V5.2S
    UQADD  H13, H4, H1
    FSUB  V26.2D, V17.2D, V27.2D
    FMULX  V23.2S, V9.2S, V26.2S
    UQSUB  B16, B31, B21
    EOR  V20.16B, V30.16B, V22.16B
    FMULX  V28.2S, V25.2S, V19.2S
    SQSHL  V4.2D, V23.2D, V5.2D
    SQSUB  S26, S29, S23
    SQADD  V8.4H, V7.4H, V4.4H
    FMIN  V27.2S, V16.2S, V29.2S
    SSHL  V17.8B, V15.8B, V20.8B
    SQRSHL  H16, H13, H24
    SQSUB  S4, S16, S9
    BIF  V21.16B, V4.16B, V13.16B
    MOV  V4.8B, V21.8B
    SSHL  V11.8H, V15.8H, V10.8H
    BSL  V7.8B, V23.8B, V22.8B
    SQSHL  H11, H27, H2
    FMUL  V11.2D, V6.2D, V13.2D
    ORN  V26.8B, V19.8B, V7.8B
    FMULX  S18, S7, S0
    BIT  V31.8B, V19.8B, V8.8B
    UQRSHL  D6, D24, D20
    ADD  D21, D29, D17
    ADD  V18.4S, V22.4S, V16.4S
    AND  V21.16B, V7.16B, V4.16B
    FDIV  V16.2S, V27.2S, V2.2S
    FRECPE  D21, D4
    MUL  V3.4H, V1.4H, V25.4H
    FRECPE  S28, S3
    ADD  D3, D9, D27
    UHADD  V2.8B, V2.8B, V25.8B
    FADD  V15.2D, V1.2D, V11.2D
    USHL  D20, D24, D19
    FADD  V17.4S, V25.4S, V20.4S
    FDIV  V0.2D, V16.2D, V11.2D
    SQADD  V22.4H, V0.4H, V14.4H
    UMAX  V26.16B, V9.16B, V16.16B
    UQRSHL  B10, B18, B12
    UQRSHL  D15, D29, D30
    USHL  D21, D26, D8
    UHSUB  V0.4S, V11.4S, V23.4S
    SQRSHL  V27.4S, V18.4S, V1.4S
    SQADD  D3, D6, D17
    SHADD  V17.4S, V1.4S, V1.4S
    SQSHL  D18, D22, D11
    FDIV  V4.2S, V7.2S, V21.2S
    SQADD  D22, D22, D28
    SQADD  H20, H3, H26
    SQSHL  D17, D3, D31
    SQSHL  B25, B7, B20
    UABA  V5.4H, V7.4H, V18.4H
    UQSUB  V27.4H, V23.4H, V31.4H
    SQADD  S6, S11, S11
    SQSUB  B1, B24, B6
    BIT  V5.16B, V9.16B, V23.16B
    UQRSHL  D4, D28, D15
    SQSUB  V28.4H, V12.4H, V30.4H
    FMINNM  V8.2D, V3.2D, V10.2D
    FDIV  V17.2D, V5.2D, V19.2D
    SSHL  V11.8B, V6.8B, V22.8B
    UQADD  H0, H24, H27
    BSL  V20.16B, V13.16B, V3.16B
    FDIV  V21.4S, V28.4S, V9.4S
    FMUL  V26.2S, V14.2S, V7.2S
    SQSUB  S26, S11, S5
    FABD  S19, S27, S13
    FMIN  V11.2S, V25.2S, V29.2S
    SRHADD  V18.8H, V20.8H, V16.8H
    UQSUB  S11, S19, S18
    URHADD  V14.8B, V18.8B, V22.8B
    ADD  D9, D19, D20
    SQSHL  V23.4H, V27.4H, V10.4H
    FADD  V11.2D, V28.2D, V21.2D
    SQRSHL  V17.2S, V22.2S, V11.2S
    SQADD  B12, B17, B14
    SMAX  V25.4H, V10.4H, V29.4H
    SQRSHL  B15, B26, B18
    MOV  V7.8B, V5.8B
    UQADD  S20, S0, S2
    FABD  S7, S24, S16
    UQSUB  H26, H1, H1
    SSHL  D5, D26, D7
    SABD  V2.4S, V2.4S, V23.4S
    UMIN  V13.2S, V28.2S, V20.2S
    ADD  V21.8H, V22.8H, V5.8H
    SQADD  D2, D6, D0
    SABD  V8.8H, V19.8H, V1.8H
    FMAX  V16.2S, V0.2S, V5.2S
    ORN  V12.16B, V12.16B, V12.16B
    SQRSHL  S19, S30, S27
    UQRSHL  S10, S30, S16
    FMAXNM  V18.2D, V14.2D, V31.2D
    FABD  S29, S19, S1
    UQADD  S24, S30, S8
    USHL  D27, D13, D25
    AND  V5.8B, V1.8B, V6.8B
    UQRSHL  V22.4H, V1.4H, V10.4H
    SABD  V3.16B, V3.16B, V8.16B
    SQSHL  H24, H21, H31
    SHADD  V3.8H, V19.8H, V13.8H
    MUL  V29.4S, V8.4S, V25.4S
    FMAX  V7.4S, V12.4S, V11.4S
    FMULX  D28, D24, D7
    SABDL2  V26.4S, V15.8H, V26.8H
    UQSUB  H14, H12, H5
    FSUB  V10.2S, V10.2S, V22.2S
    FDIV  V3.2S, V28.2S, V10.2S
    FMINNM  V31.4S, V29.4S, V20.4S
    FADD  V14.4S, V20.4S, V15.4S
    MLS  V26.16B, V14.16B, V3.16B
    UQRSHL  B22, B6, B31
    FADD  V21.2D, V21.2D, V24.2D
    SRHADD  V8.8H, V11.8H, V6.8H
    FRECPE  V26.2D, V26.2D
    URSHL  V25.8B, V19.8B, V16.8B
    FMIN  V21.4S, V22.4S, V11.4S
    BSL  V12.8B, V0.8B, V6.8B
    FMULX  V30.2S, V19.2S, V8.2S
    UQADD  B13, B30, B19
    FRSQRTS  V8.2S, V13.2S, V1.2S
    SHADD  V12.4S, V7.4S, V29.4S
    UQRSHL  S17, S3, S14
TaishanSimdPairArithmeticP01_label_37:
    SMAX  V20.8B, V3.8B, V3.8B
    MLA  V25.4H, V24.4H, V8.4H
    FADD  V3.2D, V2.2D, V13.2D
    UQADD  H16, H16, H25
    FMUL  V0.4S, V5.4S, V21.4S
    FMAX  V12.2D, V3.2D, V14.2D
    FABD  S20, S28, S12
    UQSUB  S22, S17, S2
    FDIV  V5.4S, V26.4S, V30.4S
    FSUB  V15.4S, V4.4S, V1.4S
    BIC  V3.16B, V21.16B, V6.16B
    SRSHL  D9, D3, D15
    FRSQRTS  S3, S21, S1
    USHL  V1.8B, V18.8B, V19.8B
    SMIN  V25.4S, V14.4S, V4.4S
    FMLS  V3.2D, V30.2D, V14.2D
    UQRSHL  B31, B11, B20
    SSHL  D5, D21, D23
    SMIN  V20.8H, V11.8H, V12.8H
    BIC  V2.16B, V25.16B, V31.16B
    ORN  V20.16B, V5.16B, V0.16B
    ADD  V7.8H, V25.8H, V1.8H
    SUB  V12.4S, V24.4S, V10.4S
    FMIN  V0.2D, V2.2D, V4.2D
    FRECPE  S6, S0
    UMIN  V21.4H, V1.4H, V18.4H
    SQRSHL  B1, B4, B19
    UMIN  V24.16B, V12.16B, V16.16B
    SQSHL  V6.4H, V0.4H, V1.4H
    SQSUB  S31, S14, S31
    SABDL2  V8.4S, V24.8H, V1.8H
    UQRSHL  B3, B18, B22
    UQRSHL  S3, S16, S8
    FMLA  V16.2S, V21.2S, V4.2S
    UQADD  V25.16B, V18.16B, V6.16B
    FABD  S6, S10, S14
    UMAX  V14.16B, V23.16B, V20.16B
    FABD  D31, D0, D4
    MLA  V15.4H, V28.4H, V1.4H
    SRSHL  V2.16B, V24.16B, V6.16B
    SQSUB  D7, D2, D16
    FMULX  S8, S15, S17
    UQADD  S8, S14, S19
    SQRSHL  V5.2S, V27.2S, V22.2S
    SUBS  X8, X8, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_498
    MOVZ  X13, #0xa31b, LSL #0
    MOVK  X13, #0x72bf, LSL #16
    MOVK  X13, #0xb06f, LSL #32
    MOVK  X13, #0xbcef, LSL #48
    SUB  X23, X13, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0xbfd8, LSL #0
    MOVK  X5, #0x2e65, LSL #16
    MOVK  X5, #0x1c11, LSL #32
    MOVK  X5, #0xc492, LSL #48
    SUB  X26, X5, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x1012, LSL #0
    MOVK  X14, #0x14ee, LSL #16
    MOVK  X14, #0xfe9f, LSL #32
    MOVK  X14, #0x2df3, LSL #48
    SUB  X15, X14, X4
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0xbfd8, LSL #0
    MOVK  X6, #0x2e65, LSL #16
    MOVK  X6, #0x1c11, LSL #32
    MOVK  X6, #0xc492, LSL #48
    SUB  X27, X6, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0xbfd8, LSL #0
    MOVK  X12, #0x2e65, LSL #16
    MOVK  X12, #0x1c11, LSL #32
    MOVK  X12, #0xc492, LSL #48
    SUB  X11, X12, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x6915, LSL #0
    MOVK  X4, #0x3eb8, LSL #16
    MOVK  X4, #0x135d, LSL #32
    MOVK  X4, #0x4519, LSL #48
    SUB  X15, X4, X7
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0xbfd8, LSL #0
    MOVK  X13, #0x2e65, LSL #16
    MOVK  X13, #0x1c11, LSL #32
    MOVK  X13, #0xc492, LSL #48
    SUB  X26, X13, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0xbfd8, LSL #0
    MOVK  X3, #0x2e65, LSL #16
    MOVK  X3, #0x1c11, LSL #32
    MOVK  X3, #0xc492, LSL #48
    SUB  X18, X3, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0xc9bd, LSL #0
    MOVK  X8, #0x9812, LSL #16
    MOVK  X8, #0xfa92, LSL #32
    MOVK  X8, #0xcc96, LSL #48
    SUB  X15, X8, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x24eb, LSL #0
    MOVK  X17, #0x8530, LSL #16
    MOVK  X17, #0x101e, LSL #32
    MOVK  X17, #0x7645, LSL #48
    SUB  X16, X17, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x859f, LSL #0
    MOVK  X19, #0xd90f, LSL #16
    MOVK  X19, #0x68cd, LSL #32
    MOVK  X19, #0xd68e, LSL #48
    SUB  X12, X19, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0xc698, LSL #0
    MOVK  X20, #0x9355, LSL #16
    MOVK  X20, #0x365c, LSL #32
    MOVK  X20, #0xb1a, LSL #48
    SUB  X18, X20, X20
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0xf440, LSL #0
    MOVK  X17, #0xe1cc, LSL #16
    MOVK  X17, #0xabfe, LSL #32
    MOVK  X17, #0xe198, LSL #48
    SUB  X23, X17, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0xc898, LSL #0
    MOVK  X15, #0x5025, LSL #16
    MOVK  X15, #0x452b, LSL #32
    MOVK  X15, #0xac2c, LSL #48
    SUB  X7, X15, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x209, LSL #0
    MOVK  X28, #0xabc0, LSL #16
    MOVK  X28, #0xf83a, LSL #32
    MOVK  X28, #0xedf0, LSL #48
    SUB  X10, X28, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X29, X12, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X16, X13, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D3
    MOVZ  X13, #0x9745, LSL #0
    SUB  X16, X13, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D4
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xff80, LSL #32
    SUB  X22, X6, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D5
    MOVZ  X25, #0xf7c2, LSL #0
    MOVK  X25, #0x1fbf, LSL #16
    SUB  X7, X25, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D6
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0x7fff, LSL #16
    SUB  X8, X17, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D7
    MOVZ  X18, #0x68bb, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0x7f7f, LSL #32
    MOVK  X18, #0x8017, LSL #48
    SUB  X25, X18, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D8
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X24, X6, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D10
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X15, X8, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7fc0, LSL #16
    MOVK  X8, #0x7fc0, LSL #48
    SUB  X22, X8, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D11
    MOVZ  X8, #0x2910, LSL #0
    MOVK  X8, #0x7fff, LSL #16
    MOVK  X8, #0x7fc0, LSL #48
    SUB  X22, X8, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D12
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x1, LSL #16
    SUB  X24, X20, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0x803f, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x803f, LSL #48
    SUB  X24, X29, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D14
    MOVZ  X29, #0xd6ef, LSL #0
    MOVK  X29, #0x8000, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0x803f, LSL #48
    SUB  X24, X29, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D15
    MOVZ  X29, #0x2, LSL #0
    MOVK  X29, #0x8000, LSL #16
    MOVK  X29, #0xff80, LSL #32
    SUB  X5, X29, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D16
    MOVZ  X22, #0x9745, LSL #0
    MOVK  X22, #0x8080, LSL #32
    MOVK  X22, #0x7fe8, LSL #48
    SUB  X10, X22, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D18
    MOVZ  X21, #0xdadf, LSL #0
    MOVK  X21, #0xbf9f, LSL #16
    MOVK  X21, #0x8080, LSL #32
    MOVK  X21, #0x7fe8, LSL #48
    SUB  X19, X21, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D19
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    SUB  X13, X14, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0x803f, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0x803f, LSL #48
    SUB  X29, X8, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D20
    MOVZ  X8, #0xd6ef, LSL #0
    MOVK  X8, #0x8000, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0x803f, LSL #48
    SUB  X29, X8, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D21
    MOVZ  X24, #0xdadf, LSL #0
    MOVK  X24, #0x9f, LSL #16
    MOVK  X24, #0x8080, LSL #32
    MOVK  X24, #0x7fe8, LSL #48
    SUB  X22, X24, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D22
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D23
    MOVZ  X8, #0x3ba1, LSL #0
    SUB  X10, X8, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D25
    MOVZ  X27, #0xdadf, LSL #0
    MOVK  X27, #0xbf9f, LSL #16
    MOVK  X27, #0x8080, LSL #32
    MOVK  X27, #0x7fe8, LSL #48
    SUB  X6, X27, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff0, LSL #48
    SUB  X4, X19, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D26
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff0, LSL #48
    SUB  X4, X19, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D27
    MOVZ  X2, #0xf7c2, LSL #0
    MOVK  X2, #0x1fbf, LSL #16
    SUB  X16, X2, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D28
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X19, X29, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D29
    MOVZ  X15, #0xceba, LSL #0
    MOVK  X15, #0x8930, LSL #16
    SUB  X4, X15, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  D0, X22
    FMOV  V0.D[1], X28
    FMOV  D1, X11
    FMOV  V1.D[1], X27
    FMOV  D2, X22
    FMOV  V2.D[1], X22
    FMOV  D3, X26
    FMOV  V3.D[1], X20
    FMOV  D4, X10
    FMOV  V4.D[1], X22
    FMOV  D5, X8
    FMOV  V5.D[1], X22
    FMOV  D6, X12
    FMOV  V6.D[1], X5
    FMOV  D7, X25
    FMOV  V7.D[1], X23
    FMOV  D8, X4
    FMOV  V8.D[1], X3
    FMOV  D9, X27
    FMOV  V9.D[1], X18
    FMOV  D10, X6
    FMOV  V10.D[1], X25
    FMOV  D11, X27
    FMOV  V11.D[1], X8
    FMOV  D12, X5
    FMOV  V12.D[1], X19
    FMOV  D13, X27
    FMOV  V13.D[1], X7
    FMOV  D14, X25
    FMOV  V14.D[1], X11
    FMOV  D15, X4
    FMOV  V15.D[1], X6
    FMOV  D16, X23
    FMOV  V16.D[1], X16
    FMOV  D17, X17
    FMOV  V17.D[1], X20
    FMOV  D18, X8
    FMOV  V18.D[1], X21
    FMOV  D19, X8
    FMOV  V19.D[1], X23
    FMOV  D20, X16
    FMOV  V20.D[1], X19
    FMOV  D21, X2
    FMOV  V21.D[1], X3
    FMOV  D22, X25
    FMOV  V22.D[1], X23
    FMOV  D23, X10
    FMOV  V23.D[1], X7
    FMOV  D24, X19
    FMOV  V24.D[1], X15
    FMOV  D25, X3
    FMOV  V25.D[1], X7
    FMOV  D26, X6
    FMOV  V26.D[1], X16
    FMOV  D27, X25
    FMOV  V27.D[1], X18
    FMOV  D28, X21
    FMOV  V28.D[1], X2
    FMOV  D29, X23
    FMOV  V29.D[1], X17
    FMOV  D30, X12
    FMOV  V30.D[1], X11
    FMOV  D31, X28
    FMOV  V31.D[1], X21
    MOVZ  X5, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_581:
    SQSHL  V29.4S, V17.4S, V7.4S
    UQADD  V26.8B, V18.8B, V28.8B
    SQSHL  H19, H17, H2
    SUB  D27, D22, D15
    FADD  V3.2S, V30.2S, V18.2S
    FABD  D24, D29, D10
    SQSUB  B3, B6, B25
    MOV  V1.16B, V29.16B
    SQSHL  B22, B20, B3
    UQSUB  S26, S30, S23
    SSHL  V11.16B, V15.16B, V27.16B
    SSHL  V7.2S, V11.2S, V23.2S
    FRECPE  D24, D11
    FRSQRTS  V13.2D, V8.2D, V30.2D
    SQSUB  H10, H23, H7
    ORN  V1.8B, V22.8B, V25.8B
    SMIN  V18.2S, V18.2S, V25.2S
    SQRSHL  H29, H25, H10
    MUL  V26.16B, V28.16B, V1.16B
    FMAXNM  V19.2D, V15.2D, V26.2D
    SQRSHL  H29, H2, H20
    ADD  V6.4H, V24.4H, V1.4H
    UQSUB  D3, D23, D15
    MUL  V26.4H, V21.4H, V4.4H
    UABA  V4.4S, V8.4S, V19.4S
    FMULX  D3, D2, D11
    SQSHL  V3.4S, V14.4S, V19.4S
    SQRSHL  V17.8H, V15.8H, V29.8H
    SQSUB  V21.2S, V0.2S, V18.2S
    SQSUB  H5, H22, H4
    SQADD  B17, B10, B3
    SUB  D27, D26, D5
    FDIV  V23.2D, V28.2D, V6.2D
    USHL  V16.16B, V7.16B, V21.16B
    FABD  D21, D17, D7
    FADD  V12.2S, V4.2S, V27.2S
    MLS  V25.16B, V10.16B, V4.16B
    FDIV  V3.2S, V19.2S, V0.2S
    URSHL  V9.2S, V13.2S, V12.2S
    UQSUB  B9, B30, B2
    MLS  V11.4S, V25.4S, V21.4S
    EOR  V31.8B, V22.8B, V4.8B
    SQSUB  V10.4H, V10.4H, V11.4H
    FRECPE  S10, S5
    USHL  V14.16B, V0.16B, V10.16B
    FABD  V18.2S, V22.2S, V3.2S
    SQRSHL  S25, S23, S5
    SABDL2  V19.8H, V21.16B, V26.16B
    FMULX  V16.2D, V3.2D, V28.2D
    UQRSHL  D26, D30, D0
    SUB  D18, D16, D7
    BIT  V25.8B, V29.8B, V1.8B
    SQRSHL  H19, H27, H8
    SQADD  B17, B10, B8
    UQRSHL  B2, B16, B27
    EOR  V17.16B, V13.16B, V26.16B
    FMAX  V18.2S, V10.2S, V29.2S
    FRSQRTS  V23.4S, V17.4S, V0.4S
    USHL  V22.4S, V10.4S, V30.4S
    FABD  V16.2D, V13.2D, V19.2D
    FMULX  V17.4S, V17.4S, V1.4S
    SQRSHL  V9.2S, V14.2S, V15.2S
    USHL  D3, D11, D11
    FMULX  S26, S28, S30
    USHL  D2, D2, D7
    FABD  D30, D9, D3
    FRSQRTS  D30, D12, D26
    SSHL  V23.16B, V16.16B, V17.16B
    UQSUB  D23, D9, D5
    FMINNM  V28.4S, V2.4S, V22.4S
    FRSQRTS  V25.2D, V30.2D, V17.2D
    BIF  V31.8B, V25.8B, V17.8B
    FDIV  V22.2D, V8.2D, V21.2D
    FABD  S5, S25, S31
    UQADD  B2, B27, B28
    BSL  V28.8B, V22.8B, V29.8B
    FABD  V17.4S, V16.4S, V27.4S
    UQSUB  S8, S22, S12
    SQSHL  B5, B22, B28
    FRECPE  D25, D31
    UQSUB  H15, H27, H16
    FADD  V4.4S, V16.4S, V25.4S
    UABA  V15.4S, V22.4S, V11.4S
    SQRSHL  H19, H23, H16
    FDIV  V25.2S, V15.2S, V22.2S
    SSHL  V21.16B, V9.16B, V3.16B
    SSHL  V27.2S, V30.2S, V4.2S
    UHSUB  V22.2S, V25.2S, V10.2S
    BSL  V28.16B, V20.16B, V9.16B
    FMAXNM  V19.2S, V7.2S, V11.2S
    MUL  V6.8B, V13.8B, V13.8B
    SRHADD  V16.8B, V4.8B, V16.8B
    ADD  D27, D25, D1
    ADD  D13, D21, D10
    UQSUB  H5, H18, H16
    SQADD  B4, B2, B15
    SQSHL  B22, B4, B13
    MOV  V8.8B, V20.8B
    UQRSHL  D2, D27, D17
    BSL  V30.8B, V27.8B, V10.8B
    ADD  V8.4S, V7.4S, V18.4S
    FRECPE  D2, D8
    SABDL2  V27.2D, V3.4S, V21.4S
    ORN  V19.16B, V16.16B, V7.16B
    FDIV  V6.2D, V21.2D, V22.2D
    USHL  D29, D5, D14
    SQSHL  D22, D19, D28
    SQSHL  D24, D10, D17
    SQRSHL  H22, H18, H3
    UQADD  B18, B25, B30
    SABDL  V21.4S, V19.4H, V1.4H
    SRSHL  D12, D9, D16
    SSHL  D28, D9, D15
    ADD  V28.2D, V22.2D, V23.2D
    UQADD  V8.2S, V15.2S, V7.2S
    UQRSHL  H15, H19, H20
    UQADD  H11, H15, H10
    FMAX  V24.4S, V14.4S, V18.4S
    UQADD  S7, S1, S13
    SQADD  D12, D7, D7
    FMAX  V30.2D, V11.2D, V13.2D
    UQSUB  H27, H24, H6
    USHL  V28.16B, V18.16B, V3.16B
    AND  V7.8B, V31.8B, V8.8B
    FMLA  V17.2S, V3.2S, V8.2S
    ADD  V21.4H, V19.4H, V19.4H
    SQADD  D21, D21, D13
    SQRSHL  H17, H1, H5
    SQADD  B14, B25, B21
    FADD  V0.4S, V7.4S, V12.4S
    UABA  V27.4S, V13.4S, V8.4S
    UQRSHL  V18.4S, V8.4S, V21.4S
    FMLA  V16.2D, V16.2D, V31.2D
    SQADD  B19, B11, B24
    UHADD  V16.8H, V18.8H, V16.8H
    UHADD  V11.2S, V23.2S, V0.2S
    SQADD  S27, S10, S25
    BIF  V3.16B, V6.16B, V14.16B
    USHL  D20, D26, D30
    UQRSHL  B22, B2, B24
    SQSUB  S16, S18, S9
    UQSUB  S30, S16, S26
    UQADD  B17, B21, B23
    SHADD  V13.16B, V28.16B, V20.16B
    SRHADD  V9.4S, V27.4S, V5.4S
    FRSQRTS  D23, D6, D11
    UQSUB  S14, S22, S0
    USHL  D8, D4, D12
    EOR  V26.16B, V9.16B, V19.16B
    BIF  V12.16B, V25.16B, V0.16B
    SSHL  V11.8B, V8.8B, V2.8B
    URSHL  V2.2D, V23.2D, V9.2D
    UQRSHL  D26, D6, D17
    SMAX  V1.8H, V1.8H, V11.8H
    FMAX  V24.2S, V20.2S, V31.2S
    UMIN  V15.2S, V27.2S, V23.2S
    USHL  V21.8H, V3.8H, V7.8H
    SQADD  V19.4H, V3.4H, V16.4H
    ORR  V31.8B, V5.8B, V22.8B
    FSUB  V29.2S, V25.2S, V31.2S
    SQRSHL  B20, B29, B20
    FMULX  V8.2S, V17.2S, V30.2S
    UQRSHL  D3, D28, D10
    SQSHL  V3.4S, V29.4S, V0.4S
    UQSUB  V14.16B, V26.16B, V21.16B
    SQSHL  H19, H21, H30
    SUB  D28, D3, D10
    UQSUB  V14.8B, V0.8B, V11.8B
    BIT  V5.8B, V10.8B, V9.8B
    ADD  V10.4H, V31.4H, V18.4H
    SRHADD  V26.8H, V10.8H, V2.8H
    SRSHL  V5.2S, V2.2S, V12.2S
    FMLA  V9.2D, V13.2D, V3.2D
    SQSUB  V9.8B, V27.8B, V16.8B
    UQSUB  B31, B7, B30
    FADD  V23.4S, V5.4S, V19.4S
    MLA  V8.2S, V8.2S, V18.2S
    SQADD  B31, B23, B1
    FMAXNM  V30.4S, V2.4S, V5.4S
    FMLA  V10.4S, V12.4S, V4.4S
    SQRSHL  B2, B27, B10
    UQRSHL  V25.4H, V9.4H, V1.4H
    FMULX  S19, S25, S4
    FMULX  D31, D8, D16
    UQRSHL  B20, B31, B28
    SQSHL  B17, B20, B30
    FMULX  V3.2D, V25.2D, V4.2D
    SSHL  V12.2S, V13.2S, V10.2S
    FMULX  V6.2D, V3.2D, V28.2D
    BIC  V3.8B, V2.8B, V22.8B
    SHSUB  V8.8H, V2.8H, V27.8H
    UMIN  V8.4S, V0.4S, V19.4S
    URSHL  D29, D13, D26
    BIC  V17.8B, V8.8B, V17.8B
    SRSHL  D6, D28, D2
    SSHL  D11, D27, D31
    FMAX  V26.2S, V31.2S, V25.2S
    SQSUB  B13, B29, B7
    SQSUB  V25.8B, V12.8B, V9.8B
    UQRSHL  H19, H5, H16
    SUBS  X5, X5, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_581
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X24
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X27
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X15, X24, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D4
    MOVZ  X22, #0xcc, LSL #0
    SUB  X17, X22, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D5
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff0, LSL #48
    SUB  X21, X16, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D6
    MOVZ  X27, #0x7f01, LSL #0
    MOVK  X27, #0x82c3, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0x7eff, LSL #48
    SUB  X29, X27, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D7
    MOVZ  X10, #0x2410, LSL #0
    MOVK  X10, #0x208a, LSL #16
    SUB  X22, X10, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D8
    MOVZ  X19, #0x97fe, LSL #0
    MOVK  X19, #0x384d, LSL #16
    SUB  X24, X19, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D10
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0x3502, LSL #32
    MOVK  X6, #0x20d0, LSL #48
    SUB  X5, X6, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D11
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0x7fff, LSL #16
    SUB  X3, X12, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D12
    MOVZ  X11, #0x7, LSL #0
    SUB  X26, X11, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D13
    MOVZ  X3, #0xfe, LSL #0
    SUB  X12, X3, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D14
    MOVZ  X23, #0xffcb, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0x1, LSL #32
    SUB  X19, X23, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D15
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D16
    MOVZ  X26, #0xb1e9, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X29, X26, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D17
    MOVZ  X18, #0x97fe, LSL #0
    MOVK  X18, #0x384d, LSL #16
    SUB  X7, X18, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D18
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0x3502, LSL #32
    MOVK  X6, #0x20d0, LSL #48
    SUB  X29, X6, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D20
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7ff8, LSL #48
    SUB  X24, X20, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D21
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x8580, LSL #32
    MOVK  X20, #0x4063, LSL #48
    SUB  X24, X20, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D23
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7ff0, LSL #48
    SUB  X17, X25, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D24
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D25
    MOVZ  X29, #0xb2f1, LSL #0
    MOVK  X29, #0x8100, LSL #16
    SUB  X21, X29, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D26
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0x7f00, LSL #16
    SUB  X27, X18, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D27
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0x7fff, LSL #16
    SUB  X12, X11, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D28
    MOVZ  X20, #0x7f01, LSL #0
    MOVK  X20, #0x82c3, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0x7eff, LSL #48
    SUB  X18, X20, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D29
    MOVZ  X24, #0xe, LSL #0
    SUB  X17, X24, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
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
TaishanSimdPairArithmeticP01_label_181:
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
    FMOV  D0, X2
    FMOV  V0.D[1], X24
    FMOV  D1, X10
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X27
    FMOV  V3.D[1], X29
    FMOV  D4, X6
    FMOV  V4.D[1], X19
    FMOV  D5, X8
    FMOV  V5.D[1], X18
    FMOV  D6, X17
    FMOV  V6.D[1], X29
    FMOV  D7, X18
    FMOV  V7.D[1], X28
    FMOV  D8, X10
    FMOV  V8.D[1], X21
    FMOV  D9, X21
    FMOV  V9.D[1], X18
    FMOV  D10, X10
    FMOV  V10.D[1], X26
    FMOV  D11, X15
    FMOV  V11.D[1], X4
    FMOV  D12, X15
    FMOV  V12.D[1], X4
    FMOV  D13, X14
    FMOV  V13.D[1], X13
    FMOV  D14, X17
    FMOV  V14.D[1], X24
    FMOV  D15, X28
    FMOV  V15.D[1], X21
    FMOV  D16, X22
    FMOV  V16.D[1], X5
    FMOV  D17, X23
    FMOV  V17.D[1], X10
    FMOV  D18, X19
    FMOV  V18.D[1], X4
    FMOV  D19, X19
    FMOV  V19.D[1], X25
    FMOV  D20, X14
    FMOV  V20.D[1], X18
    FMOV  D21, X27
    FMOV  V21.D[1], X2
    FMOV  D22, X21
    FMOV  V22.D[1], X22
    FMOV  D23, X8
    FMOV  V23.D[1], X18
    FMOV  D24, X22
    FMOV  V24.D[1], X13
    FMOV  D25, X11
    FMOV  V25.D[1], X16
    FMOV  D26, X12
    FMOV  V26.D[1], X14
    FMOV  D27, X10
    FMOV  V27.D[1], X20
    FMOV  D28, X2
    FMOV  V28.D[1], X3
    FMOV  D29, X14
    FMOV  V29.D[1], X18
    FMOV  D30, X27
    FMOV  V30.D[1], X13
    FMOV  D31, X23
    FMOV  V31.D[1], X15
    MOVZ  X24, #0xf, LSL #0
TaishanSimdPairArithmeticP01_label_664:
    UQSUB  H20, H4, H13
    UQADD  B3, B0, B25
    UQSUB  B18, B5, B25
    SRSHL  D12, D12, D3
    UQSUB  H22, H3, H18
    BIT  V21.16B, V28.16B, V28.16B
    FRSQRTS  V29.4S, V18.4S, V13.4S
    SSHL  D2, D3, D8
    EOR  V16.8B, V25.8B, V27.8B
    FABD  S22, S8, S30
    UQSUB  V18.4S, V8.4S, V25.4S
    MLS  V0.16B, V5.16B, V6.16B
    SQADD  S12, S11, S17
    ORN  V16.8B, V30.8B, V3.8B
    SQRSHL  B11, B27, B15
    SRHADD  V15.8H, V24.8H, V7.8H
    FABD  S1, S21, S10
    SQSHL  V26.4H, V26.4H, V25.4H
    SQADD  V24.4H, V11.4H, V3.4H
    FABD  S0, S3, S7
    UHSUB  V7.8B, V19.8B, V6.8B
    FRSQRTS  S6, S1, S3
    SHSUB  V12.8B, V21.8B, V10.8B
    UQRSHL  B24, B22, B17
    SRSHL  V30.2D, V24.2D, V21.2D
    UABA  V27.2S, V28.2S, V1.2S
    FMIN  V5.2S, V9.2S, V26.2S
    UQADD  B24, B19, B15
    SQADD  H21, H17, H22
    SMIN  V19.4S, V0.4S, V31.4S
    SQADD  B15, B1, B16
    MUL  V30.4H, V8.4H, V12.4H
    FRSQRTS  S5, S1, S16
    URHADD  V24.8B, V24.8B, V7.8B
    SRHADD  V25.16B, V24.16B, V10.16B
    USHL  D11, D9, D13
    FABD  D12, D21, D24
    ADD  D8, D3, D8
    UQRSHL  D26, D29, D2
    FDIV  V30.2D, V30.2D, V7.2D
    UQRSHL  V25.2S, V25.2S, V28.2S
    FABD  V11.2S, V3.2S, V30.2S
    SABD  V10.4H, V7.4H, V25.4H
    USHL  D9, D28, D20
    SMAX  V19.8B, V20.8B, V2.8B
    MLS  V7.4H, V29.4H, V20.4H
    UQSUB  V1.4H, V10.4H, V21.4H
    SQSHL  H6, H0, H26
    SQSHL  H22, H17, H5
    SABDL  V20.2D, V19.2S, V28.2S
    SQSHL  V11.4S, V24.4S, V24.4S
    SQRSHL  H16, H2, H9
    SRHADD  V2.4H, V25.4H, V22.4H
    FABD  S28, S17, S27
    UQRSHL  B5, B2, B21
    BIT  V10.8B, V31.8B, V31.8B
    UQRSHL  B8, B30, B9
    UQSUB  D28, D26, D22
    SQRSHL  B9, B0, B16
    SQRSHL  V20.8B, V7.8B, V15.8B
    AND  V25.16B, V31.16B, V17.16B
    SQRSHL  V11.2S, V11.2S, V31.2S
    UQSUB  H3, H24, H27
    UQADD  D31, D7, D10
    FRSQRTS  V12.2S, V21.2S, V9.2S
    MOV  V24.8B, V8.8B
    BSL  V9.16B, V8.16B, V31.16B
    SQSHL  B26, B21, B11
    UHADD  V22.8H, V20.8H, V8.8H
    UQRSHL  S18, S10, S8
    SABD  V20.4H, V19.4H, V13.4H
    FMUL  V4.2D, V27.2D, V13.2D
    SRSHL  D31, D28, D20
    SQRSHL  B8, B16, B12
    SSHL  V7.4S, V17.4S, V3.4S
    UQADD  V10.2D, V2.2D, V0.2D
    UHSUB  V3.16B, V17.16B, V16.16B
    SQRSHL  H13, H6, H22
    SQADD  S8, S3, S30
    USHL  V25.4S, V27.4S, V12.4S
    UABA  V7.8B, V14.8B, V1.8B
    UQRSHL  D6, D11, D7
    SRSHL  V25.8B, V20.8B, V23.8B
    MUL  V21.8B, V24.8B, V9.8B
    SQADD  H10, H17, H28
    SABDL2  V23.4S, V30.8H, V21.8H
    UHADD  V11.16B, V20.16B, V21.16B
    URHADD  V11.8B, V28.8B, V1.8B
    SQRSHL  D7, D14, D15
    FABD  D27, D13, D30
    SQSHL  S17, S20, S7
    FMAXNM  V6.4S, V3.4S, V2.4S
    SQADD  H15, H26, H12
    UQSUB  D21, D26, D8
    SQADD  B21, B21, B17
    UABA  V14.8H, V21.8H, V30.8H
    FMULX  S21, S30, S18
    AND  V21.8B, V9.8B, V12.8B
    SQRSHL  V1.8H, V23.8H, V15.8H
    FDIV  V13.2D, V27.2D, V0.2D
    UQADD  V23.2D, V18.2D, V20.2D
    FADD  V10.4S, V11.4S, V16.4S
    UQSUB  B9, B11, B15
    SQSHL  B9, B1, B17
    BIC  V12.8B, V14.8B, V14.8B
    SQSUB  S7, S14, S8
    SUB  V9.8B, V7.8B, V10.8B
    FMINNM  V8.2D, V9.2D, V10.2D
    BSL  V2.16B, V17.16B, V28.16B
    ORN  V25.8B, V14.8B, V27.8B
    FABD  S26, S25, S14
    MUL  V11.16B, V15.16B, V19.16B
    SUB  V15.4S, V19.4S, V30.4S
    SUB  D23, D6, D0
    UQRSHL  D17, D3, D16
    FDIV  V0.4S, V19.4S, V31.4S
    SQSUB  D13, D10, D0
    SHADD  V21.8B, V19.8B, V12.8B
    SUB  D27, D7, D21
    FDIV  V17.2S, V24.2S, V27.2S
    FMULX  D8, D22, D14
    BIF  V25.16B, V27.16B, V1.16B
    SQADD  S24, S31, S1
    UABA  V30.8B, V14.8B, V28.8B
    FRECPE  V8.4S, V5.4S
    UQADD  S11, S3, S12
    SQADD  V20.2D, V16.2D, V8.2D
    FDIV  V0.4S, V12.4S, V23.4S
    UQADD  B15, B9, B30
    SQRSHL  H22, H20, H21
    SUB  D21, D31, D9
    SRSHL  V15.4H, V24.4H, V3.4H
    ORR  V25.8B, V13.8B, V1.8B
    SQSUB  B16, B5, B15
    URSHL  D31, D18, D3
    URSHL  D12, D6, D10
    FABD  V28.4S, V27.4S, V17.4S
    SQSUB  B30, B16, B13
    URSHL  D6, D11, D16
    UABA  V25.2S, V19.2S, V0.2S
    FDIV  V12.2D, V22.2D, V21.2D
    SQRSHL  B8, B8, B5
    FRSQRTS  D31, D14, D11
    FMULX  S1, S11, S6
    UQSUB  D15, D1, D6
    SABDL2  V4.2D, V23.4S, V10.4S
    AND  V31.8B, V4.8B, V10.8B
    UQRSHL  D31, D8, D28
    SQSUB  D19, D26, D3
    SUB  D17, D6, D14
    UQSUB  H2, H19, H23
    UQADD  H17, H16, H8
    BIT  V30.8B, V17.8B, V30.8B
    UABA  V30.2S, V8.2S, V9.2S
    FMAX  V0.2D, V11.2D, V5.2D
    SABDL2  V6.4S, V18.8H, V15.8H
    SHADD  V30.8H, V12.8H, V5.8H
    FRECPE  S3, S28
    ORR  V30.16B, V23.16B, V14.16B
    AND  V10.16B, V28.16B, V28.16B
    SQSHL  D10, D8, D28
    FABD  S22, S24, S3
    UQSUB  S2, S0, S7
    FMULX  V16.2D, V14.2D, V6.2D
    UHADD  V18.2S, V5.2S, V29.2S
    FMINNM  V18.2S, V28.2S, V7.2S
    URSHL  V9.2S, V5.2S, V9.2S
    SQSUB  V21.16B, V30.16B, V5.16B
    URSHL  V16.2D, V1.2D, V22.2D
    SQADD  V27.8H, V23.8H, V1.8H
    FRECPE  S31, S11
    FMULX  S7, S5, S26
    BIT  V10.8B, V2.8B, V31.8B
    SABDL  V9.8H, V5.8B, V25.8B
    SQSHL  B5, B15, B29
    UQSUB  S20, S18, S6
    SQSHL  S30, S28, S11
    FABD  D29, D25, D26
    SQRSHL  V2.8H, V14.8H, V29.8H
    SQSHL  V15.16B, V31.16B, V14.16B
    MLA  V20.8H, V18.8H, V19.8H
    BIT  V0.16B, V12.16B, V20.16B
    FADD  V19.4S, V29.4S, V5.4S
    SQADD  V22.4S, V30.4S, V25.4S
    FMULX  D23, D8, D16
    MLS  V3.4S, V3.4S, V15.4S
    UQRSHL  B17, B22, B10
    UQRSHL  D21, D6, D6
    SUB  V1.2S, V18.2S, V8.2S
    ORR  V10.16B, V15.16B, V13.16B
    UHADD  V18.2S, V7.2S, V5.2S
    SQRSHL  S27, S19, S30
    SABD  V1.2S, V8.2S, V16.2S
    FMAX  V2.4S, V2.4S, V27.4S
    SQRSHL  H2, H11, H20
    MLA  V0.2S, V26.2S, V23.2S
    SQSUB  B29, B24, B13
    UABA  V17.2S, V29.2S, V22.2S
    FRSQRTS  V18.2D, V2.2D, V17.2D
    FRECPE  S26, S16
    SUBS  X24, X24, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_664
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
TaishanSimdPairArithmeticP01_label_502:
    MOVK  X3, #0xffff, LSL #48
    SUB  X17, X3, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X29, X6, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X13, X21, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X22, X26, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X11, X21, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X24, X18, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X2, X7, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X28, X7, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X14, X12, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X25, X7, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X15, X23, X23
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X20, X17, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X26, X27, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X15, X6, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D3
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xbf01, LSL #16
    SUB  X4, X12, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D5
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D6
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D7
    MOVZ  X23, #0x84a7, LSL #0
    MOVK  X23, #0x7fff, LSL #16
    SUB  X19, X23, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D10
    MOVZ  X5, #0x8156, LSL #0
    MOVK  X5, #0x5fff, LSL #16
    MOVK  X5, #0x80, LSL #32
    MOVK  X5, #0x2000, LSL #48
    SUB  X25, X5, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D11
    MOVZ  X10, #0xc0ff, LSL #0
    MOVK  X10, #0x4000, LSL #16
    SUB  X25, X10, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x7ff8, LSL #48
    SUB  X26, X20, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D12
    MOVZ  X20, #0x8765, LSL #0
    MOVK  X20, #0x946, LSL #16
    MOVK  X20, #0xfec3, LSL #32
    MOVK  X20, #0x1daf, LSL #48
    SUB  X26, X20, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D13
    MOVZ  X10, #0x156, LSL #0
    MOVK  X10, #0x4040, LSL #16
    MOVK  X10, #0x80, LSL #32
    MOVK  X10, #0x2000, LSL #48
    SUB  X4, X10, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0x7f87, LSL #48
    SUB  X12, X19, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D14
    MOVZ  X19, #0x4a7, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0x7ff7, LSL #48
    SUB  X12, X19, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D15
    MOVZ  X28, #0x8000, LSL #0
    MOVK  X28, #0x1fff, LSL #16
    SUB  X5, X28, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D17
    MOVZ  X26, #0x22d4, LSL #0
    MOVK  X26, #0xe03f, LSL #16
    MOVK  X26, #0x80, LSL #32
    MOVK  X26, #0x2000, LSL #48
    SUB  X2, X26, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x3ff8, LSL #48
    SUB  X14, X24, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D18
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x3ff8, LSL #48
    SUB  X14, X24, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D19
    MOVZ  X23, #0x156, LSL #0
    MOVK  X23, #0xc040, LSL #16
    MOVK  X23, #0x80, LSL #32
    MOVK  X23, #0x2000, LSL #48
    SUB  X28, X23, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D20
    MOVZ  X22, #0xa1e8, LSL #0
    MOVK  X22, #0xc002, LSL #16
    SUB  X11, X22, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D22
    MOVZ  X13, #0x232a, LSL #0
    MOVK  X13, #0xe03f, LSL #16
    MOVK  X13, #0x80, LSL #32
    MOVK  X13, #0x2000, LSL #48
    SUB  X19, X13, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D23
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D24
    MOVZ  X8, #0x80, LSL #0
    SUB  X20, X8, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D25
    MOVZ  X12, #0x156, LSL #0
    MOVK  X12, #0xc040, LSL #16
    MOVK  X12, #0x80, LSL #32
    MOVK  X12, #0x2000, LSL #48
    SUB  X22, X12, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D26
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7f80, LSL #16
    SUB  X17, X29, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D27
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D28
    MOVZ  X6, #0x43a8, LSL #0
    MOVK  X6, #0x3ffe, LSL #16
    MOVK  X6, #0x7fc0, LSL #48
    SUB  X18, X6, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D29
    MOVZ  X27, #0x80, LSL #0
    SUB  X2, X27, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x9e91, LSL #0
    MOVK  X2, #0xdb88, LSL #16
    MOVK  X2, #0x7b1e, LSL #32
    MOVK  X2, #0xfda2, LSL #48
    MOVZ  X3, #0xa205, LSL #0
    MOVK  X3, #0xde9, LSL #16
    MOVK  X3, #0xb2ac, LSL #32
    MOVK  X3, #0xd429, LSL #48
    MOVZ  X4, #0x8c9e, LSL #0
    MOVK  X4, #0x9442, LSL #16
    MOVK  X4, #0xcb8b, LSL #32
    MOVK  X4, #0x5842, LSL #48
    MOVZ  X5, #0xeabe, LSL #0
    MOVK  X5, #0xf494, LSL #16
    MOVK  X5, #0xd7a6, LSL #32
    MOVK  X5, #0xac09, LSL #48
    MOVZ  X6, #0x2307, LSL #0
    MOVK  X6, #0xf54c, LSL #16
    MOVK  X6, #0xaf29, LSL #32
    MOVK  X6, #0x182d, LSL #48
    MOVZ  X7, #0x242c, LSL #0
    MOVK  X7, #0x4a36, LSL #16
    MOVK  X7, #0x5f71, LSL #32
    MOVK  X7, #0xf835, LSL #48
    MOVZ  X8, #0x4650, LSL #0
    MOVK  X8, #0x7da0, LSL #16
    MOVK  X8, #0xc58e, LSL #32
    MOVK  X8, #0x8307, LSL #48
    MOVZ  X10, #0x72ad, LSL #0
    MOVK  X10, #0x3c10, LSL #16
    MOVK  X10, #0xcaf1, LSL #32
    MOVK  X10, #0xbbf1, LSL #48
    MOVZ  X11, #0x67ab, LSL #0
    MOVK  X11, #0x2e15, LSL #16
    MOVK  X11, #0x9113, LSL #32
    MOVK  X11, #0xbdee, LSL #48
    MOVZ  X12, #0x1a4f, LSL #0
    MOVK  X12, #0x473f, LSL #16
    MOVK  X12, #0x1d6e, LSL #32
    MOVK  X12, #0x1cc2, LSL #48
    MOVZ  X13, #0xc44f, LSL #0
    MOVK  X13, #0x357, LSL #16
    MOVK  X13, #0xe41d, LSL #32
    MOVK  X13, #0x3029, LSL #48
    MOVZ  X14, #0x8388, LSL #0
    MOVK  X14, #0x3391, LSL #16
    MOVK  X14, #0x1ff9, LSL #32
    MOVK  X14, #0x381c, LSL #48
    MOVZ  X15, #0x7fda, LSL #0
    MOVK  X15, #0x1b33, LSL #16
    MOVK  X15, #0x877f, LSL #32
    MOVK  X15, #0x7876, LSL #48
    MOVZ  X16, #0xf5f9, LSL #0
    MOVK  X16, #0x5a78, LSL #16
    MOVK  X16, #0x5727, LSL #32
    MOVK  X16, #0x6d90, LSL #48
    MOVZ  X17, #0x5699, LSL #0
    MOVK  X17, #0x7cd2, LSL #16
    MOVK  X17, #0x188e, LSL #32
    MOVK  X17, #0x3161, LSL #48
    MOVZ  X18, #0xf6e7, LSL #0
    MOVK  X18, #0x2886, LSL #16
    MOVK  X18, #0xf39e, LSL #32
    MOVK  X18, #0x3dea, LSL #48
    MOVZ  X19, #0x83ab, LSL #0
    MOVK  X19, #0x91c0, LSL #16
    MOVK  X19, #0x2d9d, LSL #32
    MOVK  X19, #0xc50e, LSL #48
    MOVZ  X20, #0xa284, LSL #0
    MOVK  X20, #0xb06, LSL #16
    MOVK  X20, #0x2a45, LSL #32
    MOVK  X20, #0xccbb, LSL #48
    MOVZ  X21, #0x7052, LSL #0
    MOVK  X21, #0xb4d3, LSL #16
    MOVK  X21, #0x199d, LSL #32
    MOVK  X21, #0x4682, LSL #48
    MOVZ  X22, #0xad7d, LSL #0
    MOVK  X22, #0xbc12, LSL #16
    MOVK  X22, #0xfc3d, LSL #32
    MOVK  X22, #0x342c, LSL #48
    MOVZ  X23, #0x335, LSL #0
    MOVK  X23, #0xc071, LSL #16
    MOVK  X23, #0x46b6, LSL #32
    MOVK  X23, #0x907, LSL #48
    MOVZ  X24, #0x2309, LSL #0
    MOVK  X24, #0x4560, LSL #16
    MOVK  X24, #0x7b07, LSL #32
    MOVK  X24, #0xe20b, LSL #48
    MOVZ  X25, #0xe97d, LSL #0
    MOVK  X25, #0x1633, LSL #16
    MOVK  X25, #0x838, LSL #32
    MOVK  X25, #0x8875, LSL #48
    MOVZ  X26, #0xbf2d, LSL #0
    MOVK  X26, #0xc70e, LSL #16
    MOVK  X26, #0xc5de, LSL #32
    MOVK  X26, #0x230f, LSL #48
    MOVZ  X27, #0x56ac, LSL #0
    MOVK  X27, #0xd13b, LSL #16
    MOVK  X27, #0x2a58, LSL #32
    MOVK  X27, #0x69f9, LSL #48
    MOVZ  X28, #0x6f2d, LSL #0
    MOVK  X28, #0xe2bc, LSL #16
    MOVK  X28, #0x7371, LSL #32
    MOVK  X28, #0xb5cf, LSL #48
    MOVZ  X29, #0x3656, LSL #0
    MOVK  X29, #0x16f7, LSL #16
    MOVK  X29, #0x8d8b, LSL #32
    MOVK  X29, #0xa35d, LSL #48
TaishanSimdPairArithmeticP01_label_135:
    FMOV  D0, X23
    FMOV  V0.D[1], X27
    FMOV  D1, X2
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X2
    FMOV  D3, X14
    FMOV  V3.D[1], X5
    FMOV  D4, X19
    FMOV  V4.D[1], X8
    FMOV  D5, X26
    FMOV  V5.D[1], X7
    FMOV  D6, X2
    FMOV  V6.D[1], X12
    FMOV  D7, X13
    FMOV  V7.D[1], X17
    FMOV  D8, X17
    FMOV  V8.D[1], X11
    FMOV  D9, X7
    FMOV  V9.D[1], X22
    FMOV  D10, X5
    FMOV  V10.D[1], X26
    FMOV  D11, X19
    FMOV  V11.D[1], X2
    FMOV  D12, X16
    FMOV  V12.D[1], X3
    FMOV  D13, X29
    FMOV  V13.D[1], X25
    FMOV  D14, X5
    FMOV  V14.D[1], X11
    FMOV  D15, X7
    FMOV  V15.D[1], X10
    FMOV  D16, X2
    FMOV  V16.D[1], X3
    FMOV  D17, X17
    FMOV  V17.D[1], X25
    FMOV  D18, X11
    FMOV  V18.D[1], X19
    FMOV  D19, X10
    FMOV  V19.D[1], X23
    FMOV  D20, X17
    FMOV  V20.D[1], X17
    FMOV  D21, X8
    FMOV  V21.D[1], X19
    FMOV  D22, X13
    FMOV  V22.D[1], X12
    FMOV  D23, X14
    FMOV  V23.D[1], X25
    FMOV  D24, X11
    FMOV  V24.D[1], X17
    FMOV  D25, X2
    FMOV  V25.D[1], X14
    FMOV  D26, X16
    FMOV  V26.D[1], X16
    FMOV  D27, X21
    FMOV  V27.D[1], X24
    FMOV  D28, X11
    FMOV  V28.D[1], X22
    FMOV  D29, X14
    FMOV  V29.D[1], X22
    FMOV  D30, X13
    FMOV  V30.D[1], X18
    FMOV  D31, X22
    FMOV  V31.D[1], X7
    MOVZ  X14, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_747:
    SQSUB  H9, H27, H11
    SRSHL  V23.2S, V4.2S, V31.2S
    SMIN  V22.8B, V13.8B, V17.8B
    UQSUB  V28.2D, V7.2D, V9.2D
    SSHL  D6, D30, D31
    SQSHL  B0, B20, B2
    SQSHL  S30, S13, S21
    FADD  V22.2D, V25.2D, V23.2D
    UQRSHL  V23.8B, V21.8B, V1.8B
    SQRSHL  V8.2D, V26.2D, V20.2D
    UHADD  V2.2S, V12.2S, V28.2S
    UQADD  S19, S3, S8
    FRECPE  S22, S1
    UQRSHL  H15, H1, H0
    EOR  V16.16B, V30.16B, V7.16B
    URSHL  V9.8H, V14.8H, V13.8H
    MUL  V30.4S, V17.4S, V12.4S
    SUB  D26, D15, D13
    FMINNM  V31.2S, V3.2S, V9.2S
    FDIV  V4.4S, V9.4S, V26.4S
    UMIN  V1.8B, V30.8B, V17.8B
    EOR  V8.16B, V1.16B, V25.16B
    FMUL  V26.2D, V13.2D, V11.2D
    BIT  V8.16B, V28.16B, V2.16B
    UQSUB  D25, D31, D29
    MUL  V28.8B, V3.8B, V2.8B
    FMULX  V4.2S, V19.2S, V16.2S
    SUB  D22, D30, D26
    UQADD  V23.8B, V28.8B, V0.8B
    FMUL  V5.2D, V11.2D, V18.2D
    SABDL2  V4.8H, V15.16B, V21.16B
    SQSHL  H31, H2, H6
    FSUB  V29.2S, V29.2S, V29.2S
    FDIV  V15.2S, V25.2S, V7.2S
    SQSUB  S30, S6, S2
    UQADD  B15, B21, B2
    FRSQRTS  D22, D6, D23
    UQADD  S1, S4, S9
    SQRSHL  V4.4S, V23.4S, V8.4S
    FRSQRTS  S26, S30, S5
    SQSUB  V12.16B, V23.16B, V20.16B
    SUB  D22, D1, D0
    ORN  V19.16B, V26.16B, V4.16B
    UQADD  D8, D8, D1
    FSUB  V21.4S, V11.4S, V2.4S
    SRSHL  D2, D8, D22
    BSL  V12.8B, V30.8B, V21.8B
    SQADD  B15, B29, B29
    UQADD  V25.16B, V6.16B, V5.16B
    SQSHL  S27, S9, S24
    ORN  V11.16B, V27.16B, V6.16B
    UQADD  H6, H3, H13
    UQADD  B6, B12, B4
    SQRSHL  V19.4S, V23.4S, V15.4S
    SRHADD  V14.4H, V27.4H, V25.4H
    SSHL  D9, D22, D8
    USHL  V4.8B, V2.8B, V4.8B
    SQADD  B9, B22, B16
    BIT  V24.16B, V24.16B, V3.16B
    FMIN  V24.2D, V24.2D, V31.2D
    ORN  V26.16B, V17.16B, V24.16B
    FMLS  V0.4S, V10.4S, V21.4S
    SQSHL  D9, D9, D25
    MOV  V7.16B, V29.16B
    UQRSHL  S4, S19, S15
    USHL  V26.4H, V22.4H, V3.4H
    FMULX  V11.4S, V22.4S, V5.4S
    SQSUB  B26, B11, B30
    SRHADD  V18.2S, V29.2S, V31.2S
    BSL  V8.8B, V5.8B, V23.8B
    UQADD  B4, B10, B11
    EOR  V1.8B, V8.8B, V28.8B
    FMUL  V2.2D, V25.2D, V26.2D
    SSHL  V19.4S, V4.4S, V1.4S
    EOR  V1.8B, V6.8B, V22.8B
    UQRSHL  H16, H0, H30
    USHL  D1, D11, D9
    BIF  V19.8B, V19.8B, V22.8B
    SQSUB  V19.4H, V7.4H, V31.4H
    SQSHL  V2.16B, V2.16B, V21.16B
    SRHADD  V14.4S, V18.4S, V10.4S
    UQRSHL  S11, S27, S14
    FMINNM  V1.2D, V11.2D, V12.2D
    UHSUB  V26.2S, V11.2S, V21.2S
    UHSUB  V1.2S, V3.2S, V26.2S
    SSHL  V1.4H, V28.4H, V11.4H
    MLS  V17.2S, V23.2S, V1.2S
    ADD  V0.16B, V25.16B, V16.16B
    FMAX  V21.2S, V17.2S, V9.2S
    SABD  V3.2S, V5.2S, V11.2S
    UHADD  V10.2S, V8.2S, V7.2S
    SABDL  V23.2D, V3.2S, V21.2S
    URSHL  D13, D10, D8
    UHADD  V23.4H, V13.4H, V30.4H
    SABDL2  V26.4S, V13.8H, V10.8H
    UQADD  H16, H25, H19
    UHSUB  V6.4H, V18.4H, V23.4H
    SQSUB  H7, H29, H17
    FMLA  V8.2D, V7.2D, V17.2D
    URSHL  D24, D2, D12
    UQRSHL  V2.8H, V15.8H, V5.8H
    SABDL  V31.2D, V24.2S, V12.2S
    UQADD  V28.8H, V31.8H, V23.8H
    SRHADD  V8.16B, V0.16B, V2.16B
    SSHL  D4, D14, D13
    SSHL  D10, D13, D16
    UQADD  V26.2D, V13.2D, V10.2D
    UQRSHL  H21, H2, H13
    SSHL  D24, D19, D21
    SHSUB  V28.8H, V24.8H, V6.8H
    SQSUB  S25, S14, S22
    UQSUB  B8, B26, B22
    SQSHL  B7, B23, B16
    SQRSHL  H13, H17, H11
    SQSHL  D11, D17, D22
    FADD  V1.4S, V27.4S, V8.4S
    FMAXNM  V26.2D, V2.2D, V24.2D
    URSHL  V8.2D, V26.2D, V4.2D
    UQADD  B22, B3, B3
    FABD  V23.4S, V24.4S, V6.4S
    FABD  S27, S19, S1
    SQADD  S11, S16, S10
    UQRSHL  B24, B5, B26
    SQADD  B27, B6, B26
    SQADD  H21, H28, H20
    SQADD  V4.8B, V11.8B, V3.8B
    BIF  V10.8B, V7.8B, V7.8B
    SSHL  D4, D0, D29
    SQSUB  V6.4S, V14.4S, V18.4S
    SUB  V4.8H, V17.8H, V31.8H
    URSHL  D10, D21, D27
    FRSQRTS  D24, D3, D17
    SHADD  V0.8B, V5.8B, V15.8B
    SHADD  V14.4H, V24.4H, V22.4H
    UQRSHL  H9, H16, H29
    UQSUB  V18.4S, V10.4S, V3.4S
    UQRSHL  S10, S23, S23
    SHSUB  V8.16B, V26.16B, V1.16B
    FRSQRTS  V12.4S, V10.4S, V0.4S
    USHL  D8, D5, D18
    MOV  V10.8B, V24.8B
    SQRSHL  B7, B25, B20
    EOR  V7.16B, V5.16B, V18.16B
    FMUL  V25.4S, V2.4S, V17.4S
    SMAX  V2.8H, V21.8H, V12.8H
    UQSUB  B21, B25, B14
    UQSUB  S17, S7, S31
    SQSHL  D23, D30, D9
    SQADD  D13, D4, D25
    FMULX  S2, S13, S13
    SHSUB  V19.4S, V13.4S, V24.4S
    USHL  D29, D31, D21
    SQADD  D24, D13, D28
    MOV  V10.16B, V10.16B
    FSUB  V31.2D, V28.2D, V18.2D
    FMLA  V18.4S, V10.4S, V8.4S
    UMAX  V13.2S, V14.2S, V5.2S
    FRECPE  V15.2S, V15.2S
    URSHL  V24.8B, V13.8B, V5.8B
    SQSUB  B2, B29, B8
    SUB  V14.16B, V7.16B, V18.16B
    SQRSHL  D14, D13, D30
    FMLA  V29.2S, V4.2S, V27.2S
    MLA  V25.8H, V30.8H, V31.8H
    SQSUB  D19, D21, D1
    SUB  V14.16B, V14.16B, V14.16B
    USHL  D22, D30, D6
    FMULX  V31.2S, V14.2S, V6.2S
    FMINNM  V5.4S, V10.4S, V30.4S
    SSHL  D2, D23, D0
    SHSUB  V19.4S, V29.4S, V8.4S
    UQRSHL  B10, B9, B25
    SMAX  V5.2S, V29.2S, V10.2S
    USHL  D17, D18, D24
    UQADD  H8, H14, H28
    URHADD  V20.2S, V22.2S, V17.2S
    MLA  V18.8B, V8.8B, V15.8B
    FMULX  D18, D10, D26
    SQRSHL  S6, S27, S31
    UQADD  D2, D31, D6
    SABDL  V24.2D, V18.2S, V13.2S
    FRECPE  S25, S26
    SRHADD  V30.8H, V29.8H, V30.8H
    FSUB  V0.4S, V5.4S, V12.4S
    MLS  V5.4S, V19.4S, V23.4S
    UABA  V17.8B, V8.8B, V17.8B
    SRSHL  V5.2S, V9.2S, V29.2S
    SMIN  V5.8B, V20.8B, V27.8B
    SQRSHL  S25, S9, S6
    FABD  V23.2S, V7.2S, V10.2S
    SUB  D6, D25, D18
    UQRSHL  H30, H18, H9
    FRSQRTS  S28, S27, S14
    URHADD  V25.4H, V5.4H, V5.4H
    UQADD  V28.4S, V31.4S, V4.4S
    SMAX  V15.4S, V11.4S, V24.4S
    FRSQRTS  S26, S22, S9
    UMAX  V22.2S, V14.2S, V22.2S
    SQSUB  D12, D6, D8
    FMLS  V6.4S, V19.4S, V17.4S
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_747
    MOVZ  X27, #0x9e91, LSL #0
    MOVK  X27, #0xdb88, LSL #16
    MOVK  X27, #0x7b1e, LSL #32
    MOVK  X27, #0xfda2, LSL #48
    SUB  X5, X27, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0xa205, LSL #0
    MOVK  X22, #0xde9, LSL #16
    MOVK  X22, #0xb2ac, LSL #32
    MOVK  X22, #0xd429, LSL #48
    SUB  X23, X22, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x8c9e, LSL #0
    MOVK  X23, #0x9442, LSL #16
    MOVK  X23, #0xcb8b, LSL #32
    MOVK  X23, #0x5842, LSL #48
    SUB  X22, X23, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x2307, LSL #0
    MOVK  X14, #0xf54c, LSL #16
    MOVK  X14, #0xaf29, LSL #32
    MOVK  X14, #0x182d, LSL #48
    SUB  X21, X14, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x242c, LSL #0
    MOVK  X21, #0x4a36, LSL #16
    MOVK  X21, #0x5f71, LSL #32
    MOVK  X21, #0xf835, LSL #48
    SUB  X17, X21, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x4650, LSL #0
    MOVK  X20, #0x7da0, LSL #16
    MOVK  X20, #0xc58e, LSL #32
    MOVK  X20, #0x8307, LSL #48
    SUB  X13, X20, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x72ad, LSL #0
    MOVK  X14, #0x3c10, LSL #16
    MOVK  X14, #0xcaf1, LSL #32
    MOVK  X14, #0xbbf1, LSL #48
    SUB  X19, X14, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x67ab, LSL #0
    MOVK  X16, #0x2e15, LSL #16
    MOVK  X16, #0x9113, LSL #32
    MOVK  X16, #0xbdee, LSL #48
    SUB  X24, X16, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x72ad, LSL #0
    MOVK  X5, #0x3c10, LSL #16
    MOVK  X5, #0xcaf1, LSL #32
    MOVK  X5, #0xbbf1, LSL #48
    SUB  X29, X5, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x7fda, LSL #0
    MOVK  X6, #0x1b33, LSL #16
    MOVK  X6, #0x877f, LSL #32
    MOVK  X6, #0x7876, LSL #48
    SUB  X20, X6, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x67ab, LSL #0
    MOVK  X4, #0x2e15, LSL #16
    MOVK  X4, #0x9113, LSL #32
    MOVK  X4, #0xbdee, LSL #48
    SUB  X26, X4, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X19
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x242c, LSL #0
    MOVK  X27, #0x4a36, LSL #16
    MOVK  X27, #0x5f71, LSL #32
    MOVK  X27, #0xf835, LSL #48
    SUB  X22, X27, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x8c9e, LSL #0
    MOVK  X28, #0x9442, LSL #16
    MOVK  X28, #0xcb8b, LSL #32
    MOVK  X28, #0x5842, LSL #48
    SUB  X19, X28, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0xe97d, LSL #0
    MOVK  X5, #0x1633, LSL #16
    MOVK  X5, #0x838, LSL #32
    MOVK  X5, #0x8875, LSL #48
    SUB  X4, X5, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x242c, LSL #0
    MOVK  X26, #0x4a36, LSL #16
    MOVK  X26, #0x5f71, LSL #32
    MOVK  X26, #0xf835, LSL #48
    SUB  X18, X26, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x8c9e, LSL #0
    MOVK  X17, #0x9442, LSL #16
    MOVK  X17, #0xcb8b, LSL #32
    MOVK  X17, #0x5842, LSL #48
    SUB  X26, X17, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D2
    MOVZ  X22, #0x22, LSL #0
    MOVK  X22, #0x8000, LSL #16
    SUB  X12, X22, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D3
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D4
    MOVZ  X17, #0xe761, LSL #0
    SUB  X24, X17, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D5
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x9ec0, LSL #32
    SUB  X2, X14, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X21, X3, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D6
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0x7fff, LSL #16
    SUB  X21, X3, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X4, X3, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D7
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x3d80, LSL #32
    MOVK  X3, #0x3, LSL #48
    SUB  X4, X3, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D8
    MOVZ  X25, #0xcf60, LSL #0
    SUB  X10, X25, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D10
    MOVZ  X19, #0xff, LSL #0
    SUB  X4, X19, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D11
    MOVZ  X12, #0xa271, LSL #0
    SUB  X21, X12, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D12
    MOVZ  X5, #0x309f, LSL #0
    MOVK  X5, #0x7fff, LSL #16
    SUB  X23, X5, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D13
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x1ffc, LSL #48
    SUB  X21, X24, X15
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x1ffc, LSL #16
    SUB  X21, X11, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D15
    MOVZ  X11, #0xa271, LSL #0
    SUB  X21, X11, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D16
    MOVZ  X7, #0xa271, LSL #0
    SUB  X14, X7, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D17
    MOVZ  X15, #0xcf60, LSL #0
    MOVK  X15, #0x7a00, LSL #32
    MOVK  X15, #0x6, LSL #48
    SUB  X7, X15, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D18
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X4, X23, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D19
    MOVZ  X23, #0x1629, LSL #0
    SUB  X4, X23, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D20
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x9ec0, LSL #32
    MOVK  X2, #0x1, LSL #48
    SUB  X4, X2, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D22
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D23
    MOVZ  X29, #0xff, LSL #0
    MOVK  X29, #0x3d80, LSL #32
    MOVK  X29, #0x3, LSL #48
    SUB  X10, X29, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x1ffc, LSL #16
    SUB  X16, X14, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X16, X14, X15
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D25
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x9ec0, LSL #32
    SUB  X15, X7, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D26
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x3fc0, LSL #16
    SUB  X4, X11, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D27
    MOVZ  X18, #0x22, LSL #0
    SUB  X4, X18, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D28
    MOVZ  X29, #0xe761, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X25, X29, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D29
    MOVZ  X14, #0x2c53, LSL #0
    SUB  X3, X14, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X11, #0x0, LSL #0
TaishanSimdPairArithmeticP01_label_121:
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
    FMOV  D0, X2
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X5
    FMOV  D2, X10
    FMOV  V2.D[1], X17
    FMOV  D3, X5
    FMOV  V3.D[1], X7
    FMOV  D4, X7
    FMOV  V4.D[1], X15
    FMOV  D5, X7
    FMOV  V5.D[1], X14
    FMOV  D6, X26
    FMOV  V6.D[1], X5
    FMOV  D7, X25
    FMOV  V7.D[1], X27
    FMOV  D8, X4
    FMOV  V8.D[1], X15
    FMOV  D9, X28
    FMOV  V9.D[1], X28
    FMOV  D10, X24
    FMOV  V10.D[1], X13
    FMOV  D11, X16
    FMOV  V11.D[1], X21
    FMOV  D12, X5
    FMOV  V12.D[1], X10
    FMOV  D13, X2
    FMOV  V13.D[1], X18
    FMOV  D14, X16
    FMOV  V14.D[1], X10
    FMOV  D15, X26
    FMOV  V15.D[1], X22
    FMOV  D16, X16
    FMOV  V16.D[1], X27
    FMOV  D17, X10
    FMOV  V17.D[1], X5
    FMOV  D18, X4
    FMOV  V18.D[1], X3
    FMOV  D19, X25
    FMOV  V19.D[1], X22
    FMOV  D20, X17
    FMOV  V20.D[1], X28
    FMOV  D21, X21
    FMOV  V21.D[1], X20
    FMOV  D22, X14
    FMOV  V22.D[1], X10
    FMOV  D23, X26
    FMOV  V23.D[1], X10
    FMOV  D24, X17
    FMOV  V24.D[1], X22
    FMOV  D25, X27
    FMOV  V25.D[1], X27
    FMOV  D26, X17
    FMOV  V26.D[1], X25
    FMOV  D27, X10
    FMOV  V27.D[1], X2
    FMOV  D28, X25
    FMOV  V28.D[1], X18
    FMOV  D29, X18
    FMOV  V29.D[1], X5
    FMOV  D30, X22
    FMOV  V30.D[1], X4
    FMOV  D31, X25
    FMOV  V31.D[1], X19
    MOVZ  X3, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_830:
    SQSHL  B28, B20, B7
    FMULX  D23, D27, D24
    SQSUB  D25, D27, D30
    FABD  S18, S3, S13
    FRECPE  V7.4S, V23.4S
    SQSUB  V31.8H, V18.8H, V28.8H
    BIC  V31.16B, V31.16B, V3.16B
    SQRSHL  V8.2D, V7.2D, V19.2D
    SQSHL  D11, D15, D14
    SRHADD  V30.2S, V7.2S, V27.2S
    UQADD  B0, B12, B29
    URHADD  V11.8H, V25.8H, V16.8H
    FMAXNM  V5.2S, V21.2S, V31.2S
    SMAX  V21.4H, V8.4H, V18.4H
    FDIV  V26.2D, V18.2D, V27.2D
    FABD  S26, S25, S8
    UQRSHL  H6, H30, H4
    UHSUB  V4.4H, V31.4H, V6.4H
    FRSQRTS  V31.2D, V7.2D, V29.2D
    SQSUB  D27, D4, D21
    ADD  D27, D23, D16
    UQADD  D7, D28, D0
    SQSHL  D5, D20, D13
    UQSUB  B3, B20, B14
    UQRSHL  S10, S31, S20
    UQSUB  D6, D31, D19
    UHADD  V25.4S, V7.4S, V26.4S
    FMLS  V10.2S, V5.2S, V22.2S
    FRECPE  V5.2D, V2.2D
    FRSQRTS  D30, D27, D6
    USHL  D7, D13, D21
    FMINNM  V24.4S, V30.4S, V7.4S
    FDIV  V8.2D, V14.2D, V21.2D
    SQSUB  D3, D8, D18
    FDIV  V15.4S, V7.4S, V21.4S
    UQSUB  V11.2D, V28.2D, V9.2D
    FRECPE  D1, D20
    UQSUB  B12, B12, B30
    URHADD  V18.16B, V30.16B, V2.16B
    UQADD  S17, S21, S27
    SQADD  D12, D29, D13
    ORN  V19.16B, V17.16B, V11.16B
    USHL  V13.2S, V14.2S, V7.2S
    UQRSHL  H7, H3, H13
    SHADD  V7.8H, V19.8H, V5.8H
    BIF  V18.16B, V7.16B, V17.16B
    FRECPE  D3, D2
    UQADD  V24.8H, V12.8H, V9.8H
    FABD  S8, S19, S6
    UQRSHL  S31, S3, S28
    FMIN  V5.2S, V1.2S, V21.2S
    FDIV  V29.4S, V21.4S, V23.4S
    FMULX  D21, D13, D10
    SUB  V5.4H, V2.4H, V24.4H
    SQRSHL  B26, B25, B1
    FMULX  V7.2S, V25.2S, V6.2S
    SRHADD  V5.16B, V17.16B, V25.16B
    FRECPE  S3, S27
    UQSUB  S7, S23, S29
    UQRSHL  V1.4H, V18.4H, V11.4H
    FRECPE  D23, D13
    FMLA  V6.2S, V6.2S, V15.2S
    SQSHL  H24, H2, H31
    SQADD  D13, D16, D10
    FABD  D31, D7, D6
    SRHADD  V9.4S, V9.4S, V25.4S
    FRSQRTS  D29, D2, D12
    FADD  V3.2D, V15.2D, V30.2D
    ADD  D28, D2, D2
    SQSUB  V1.4H, V9.4H, V11.4H
    BIF  V21.16B, V31.16B, V26.16B
    SQADD  S23, S25, S13
    UABA  V14.16B, V5.16B, V23.16B
    SQSHL  H22, H29, H23
    FRECPE  V21.2S, V9.2S
    URSHL  V3.2D, V17.2D, V24.2D
    SQRSHL  V5.4S, V3.4S, V25.4S
    SMAX  V18.8B, V27.8B, V10.8B
    URHADD  V30.8B, V17.8B, V29.8B
    SQSUB  D11, D28, D3
    UQRSHL  D13, D15, D22
    FABD  S15, S23, S25
    FMULX  V15.2D, V2.2D, V16.2D
    FMULX  V20.2D, V16.2D, V15.2D
    EOR  V18.16B, V9.16B, V16.16B
    FMULX  V3.2D, V10.2D, V15.2D
    SQSHL  D31, D1, D4
    SQRSHL  V6.4H, V10.4H, V21.4H
    SQSUB  D7, D14, D31
    MUL  V20.2S, V16.2S, V16.2S
    ADD  D27, D5, D12
TaishanSimdPairArithmeticP01_label_487:
    FRECPE  D18, D9
    FMINNM  V23.4S, V8.4S, V24.4S
    UQADD  D2, D19, D22
    SQSHL  S19, S17, S24
    SRSHL  D17, D18, D25
    ADD  V30.8B, V4.8B, V2.8B
    FRECPE  D10, D15
    FABD  S11, S17, S22
    FMULX  V4.2D, V18.2D, V4.2D
    FMAX  V1.4S, V7.4S, V24.4S
    EOR  V29.16B, V28.16B, V13.16B
    ORR  V29.16B, V9.16B, V2.16B
    USHL  D4, D3, D9
    SQSHL  D18, D31, D27
    FMAX  V23.2D, V18.2D, V0.2D
    UMIN  V3.2S, V31.2S, V18.2S
    SQRSHL  V30.2S, V23.2S, V29.2S
    SMIN  V20.4H, V2.4H, V31.4H
    FMULX  S8, S15, S20
    MLS  V8.8H, V8.8H, V6.8H
    SQADD  H13, H10, H7
    UQADD  D22, D24, D16
    SRSHL  D21, D21, D17
    SHADD  V28.8B, V10.8B, V13.8B
    ORN  V15.16B, V12.16B, V9.16B
    URHADD  V10.16B, V26.16B, V6.16B
    SABD  V13.16B, V20.16B, V12.16B
    SQADD  H8, H25, H17
    EOR  V6.8B, V26.8B, V31.8B
    SMIN  V4.2S, V7.2S, V2.2S
    UQSUB  V4.4H, V23.4H, V27.4H
    SQRSHL  D12, D20, D1
    UQRSHL  S8, S3, S12
    UQADD  D14, D6, D22
    SSHL  D23, D8, D17
    SSHL  D10, D29, D16
    SHADD  V5.8B, V13.8B, V2.8B
    SUB  V29.8H, V14.8H, V11.8H
    UQADD  S1, S30, S19
    FMIN  V14.2D, V1.2D, V15.2D
    UQADD  D5, D11, D9
    FMAXNM  V7.4S, V25.4S, V25.4S
    FRECPE  D11, D16
    SABD  V21.4H, V31.4H, V3.4H
    SQSUB  H2, H22, H29
    SQRSHL  B11, B10, B26
    FRECPE  D20, D14
    UQADD  V18.4S, V19.4S, V2.4S
    USHL  D2, D27, D8
    UQSUB  B12, B11, B29
    UHADD  V15.16B, V15.16B, V0.16B
    SQADD  D23, D20, D7
    SQRSHL  D9, D19, D19
    FDIV  V7.2D, V25.2D, V22.2D
    SQSUB  D13, D22, D30
    MOV  V6.8B, V3.8B
    SQRSHL  H14, H23, H23
    FRECPE  V8.4S, V13.4S
    SQADD  V15.2S, V26.2S, V10.2S
    BIC  V30.16B, V27.16B, V29.16B
    UQSUB  D19, D0, D11
    BSL  V6.8B, V25.8B, V9.8B
    UQSUB  B17, B2, B0
    FABD  V2.2D, V28.2D, V22.2D
    SQADD  D13, D27, D14
    UQADD  H22, H3, H1
    FRECPE  S15, S23
    SQSHL  B13, B8, B14
    UQRSHL  H22, H1, H8
    MLS  V15.2S, V13.2S, V9.2S
    SQSHL  H24, H4, H18
    SHADD  V2.8B, V4.8B, V15.8B
    FADD  V12.2D, V5.2D, V29.2D
    SQRSHL  D14, D27, D14
    FABD  V8.2S, V30.2S, V10.2S
    UHADD  V11.4S, V9.4S, V22.4S
    UQADD  B21, B11, B28
    SMAX  V20.8B, V15.8B, V12.8B
    SUB  D29, D11, D16
    ADD  V23.2D, V11.2D, V2.2D
    SABDL  V8.8H, V14.8B, V12.8B
    FRSQRTS  V5.2D, V13.2D, V1.2D
    UMIN  V17.4H, V21.4H, V28.4H
    SQSUB  H17, H21, H20
    SQADD  D12, D14, D5
    UABA  V14.4H, V18.4H, V28.4H
    UQADD  D3, D1, D21
    URSHL  V23.4S, V4.4S, V24.4S
    SQADD  B17, B9, B27
    SQSUB  H1, H30, H24
    SQSUB  V30.2D, V5.2D, V24.2D
    FMUL  V31.2D, V8.2D, V0.2D
    UQSUB  H12, H18, H29
    FABD  S31, S17, S27
    SQSUB  H12, H1, H29
    UABA  V17.2S, V8.2S, V26.2S
    FMULX  D27, D10, D7
    UQSUB  B25, B7, B17
    FRSQRTS  D15, D11, D10
    SHSUB  V13.4S, V31.4S, V31.4S
    SQADD  S6, S30, S9
    UQRSHL  B29, B23, B20
    UQSUB  S29, S11, S6
    UQSUB  D26, D8, D12
    FDIV  V28.2D, V9.2D, V20.2D
    SQRSHL  H29, H24, H30
    MUL  V19.8H, V21.8H, V27.8H
    BSL  V25.8B, V19.8B, V1.8B
    SQADD  V20.8H, V1.8H, V23.8H
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_830
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X15
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X18, X3, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X18
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D2
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xf00, LSL #16
    SUB  X24, X26, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D3
    MOVZ  X4, #0xfe, LSL #0
    MOVK  X4, #0x1, LSL #32
    SUB  X26, X4, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x3ff8, LSL #48
    SUB  X22, X7, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D5
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x3ff8, LSL #48
    SUB  X22, X7, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D6
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    SUB  X4, X16, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    SUB  X2, X11, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D7
    MOVZ  X11, #0x5555, LSL #0
    MOVK  X11, #0x5555, LSL #16
    MOVK  X11, #0x5555, LSL #32
    MOVK  X11, #0x40d5, LSL #48
    SUB  X2, X11, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X5, #0x1, LSL #0
    SUB  X21, X5, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D8
    MOVZ  X5, #0x1, LSL #0
    MOVK  X5, #0x3f, LSL #16
    MOVK  X5, #0x1, LSL #32
    MOVK  X5, #0x3f, LSL #48
    SUB  X21, X5, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D10
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D11
    MOVZ  X26, #0x7fff, LSL #0
    MOVK  X26, #0x4000, LSL #16
    SUB  X14, X26, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D12
    MOVZ  X14, #0xc000, LSL #0
    SUB  X21, X14, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D14
    MOVZ  X17, #0xf8fe, LSL #0
    MOVK  X17, #0xfffe, LSL #16
    MOVK  X17, #0x3ff8, LSL #48
    SUB  X28, X17, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D15
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X26
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D16
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D17
    MOVZ  X19, #0x100, LSL #0
    MOVK  X19, #0x3f, LSL #16
    MOVK  X19, #0x1, LSL #32
    MOVK  X19, #0x3f, LSL #48
    SUB  X12, X19, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D18
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X10, X17, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D19
    MOVZ  X12, #0xff01, LSL #0
    SUB  X4, X12, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D20
    MOVZ  X28, #0x3fff, LSL #0
    SUB  X10, X28, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D21
    MOVZ  X4, #0xff, LSL #0
    SUB  X8, X4, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D22
    MOVZ  X4, #0xffff, LSL #0
    SUB  X11, X4, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D25
    MOVZ  X17, #0x3fab, LSL #0
    SUB  X12, X17, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D26
    MOVZ  X28, #0x4001, LSL #0
    MOVK  X28, #0x3e, LSL #16
    MOVK  X28, #0x1, LSL #32
    MOVK  X28, #0x3f, LSL #48
    SUB  X19, X28, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D27
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X24, X19, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff8, LSL #48
    SUB  X13, X2, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D28
    MOVZ  X2, #0x8a42, LSL #0
    MOVK  X2, #0x5afb, LSL #16
    MOVK  X2, #0x8b26, LSL #32
    MOVK  X2, #0x3fdc, LSL #48
    SUB  X13, X2, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X19, X3, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X5
    FMOV  D2, X18
    FMOV  V2.D[1], X28
    FMOV  D3, X25
    FMOV  V3.D[1], X12
    FMOV  D4, X29
    FMOV  V4.D[1], X11
    FMOV  D5, X12
    FMOV  V5.D[1], X6
    FMOV  D6, X6
    FMOV  V6.D[1], X19
    FMOV  D7, X11
    FMOV  V7.D[1], X23
    FMOV  D8, X12
    FMOV  V8.D[1], X14
    FMOV  D9, X28
    FMOV  V9.D[1], X10
    FMOV  D10, X10
    FMOV  V10.D[1], X20
    FMOV  D11, X13
    FMOV  V11.D[1], X17
    FMOV  D12, X12
    FMOV  V12.D[1], X7
    FMOV  D13, X27
    FMOV  V13.D[1], X11
    FMOV  D14, X29
    FMOV  V14.D[1], X8
    FMOV  D15, X3
    FMOV  V15.D[1], X14
    FMOV  D16, X24
    FMOV  V16.D[1], X29
    FMOV  D17, X17
    FMOV  V17.D[1], X13
    FMOV  D18, X17
    FMOV  V18.D[1], X25
    FMOV  D19, X4
    FMOV  V19.D[1], X3
    FMOV  D20, X19
    FMOV  V20.D[1], X20
    FMOV  D21, X18
    FMOV  V21.D[1], X12
    FMOV  D22, X14
    FMOV  V22.D[1], X7
    FMOV  D23, X23
    FMOV  V23.D[1], X3
    FMOV  D24, X3
    FMOV  V24.D[1], X23
    FMOV  D25, X2
    FMOV  V25.D[1], X14
    FMOV  D26, X28
    FMOV  V26.D[1], X22
    FMOV  D27, X23
    FMOV  V27.D[1], X27
    FMOV  D28, X11
    FMOV  V28.D[1], X5
    FMOV  D29, X16
    FMOV  V29.D[1], X15
    FMOV  D30, X13
    FMOV  V30.D[1], X19
    FMOV  D31, X14
    FMOV  V31.D[1], X15
    MOVZ  X10, #0xf, LSL #0
TaishanSimdPairArithmeticP01_label_910:
    FMIN  V13.4S, V29.4S, V20.4S
    UABA  V0.16B, V30.16B, V20.16B
    SRSHL  V21.4S, V25.4S, V3.4S
    ORN  V5.16B, V27.16B, V2.16B
    FMLA  V14.2S, V23.2S, V8.2S
    SQSUB  V10.2D, V19.2D, V19.2D
    UQSUB  S28, S22, S5
    URHADD  V26.4S, V29.4S, V5.4S
    SABDL2  V11.8H, V5.16B, V23.16B
    FABD  D31, D6, D4
    SQRSHL  S22, S18, S18
    UQRSHL  S21, S26, S0
    FSUB  V19.2D, V18.2D, V11.2D
    UQADD  V6.4H, V16.4H, V21.4H
    SRSHL  V4.4H, V20.4H, V26.4H
    UQRSHL  B28, B25, B28
    SHSUB  V4.16B, V8.16B, V25.16B
    SSHL  D8, D10, D4
    UABA  V4.16B, V22.16B, V2.16B
    SQRSHL  D29, D2, D29
    SRSHL  D13, D11, D31
    SRSHL  D2, D8, D22
    SSHL  D31, D25, D2
    FABD  S30, S23, S24
    UQADD  H20, H1, H30
    FMUL  V27.4S, V12.4S, V3.4S
    UABA  V10.4H, V6.4H, V6.4H
    UMIN  V29.2S, V3.2S, V10.2S
    ADD  V10.8B, V21.8B, V4.8B
    UQADD  V19.16B, V13.16B, V9.16B
    FADD  V9.2S, V22.2S, V4.2S
    SMIN  V3.2S, V23.2S, V3.2S
    FMAX  V31.2S, V26.2S, V6.2S
    SQADD  S16, S12, S30
    SQSUB  V14.16B, V14.16B, V8.16B
    FMINNM  V13.2D, V6.2D, V26.2D
    SUB  V24.2S, V28.2S, V8.2S
    SABDL2  V7.8H, V20.16B, V18.16B
    FADD  V25.4S, V16.4S, V7.4S
    UQSUB  H14, H9, H29
    FMLA  V1.4S, V12.4S, V0.4S
    SRHADD  V29.4H, V25.4H, V0.4H
    FMAXNM  V14.2D, V27.2D, V18.2D
    EOR  V30.8B, V26.8B, V11.8B
    UQRSHL  D11, D17, D19
    UHSUB  V25.16B, V30.16B, V20.16B
    FSUB  V18.4S, V28.4S, V8.4S
    SQRSHL  D29, D4, D26
    SQSHL  H16, H10, H7
    SRHADD  V29.8H, V22.8H, V2.8H
    UQSUB  D14, D5, D12
    FMULX  S2, S27, S26
    SQADD  B3, B31, B30
    SRSHL  D18, D23, D22
    FDIV  V6.2S, V16.2S, V1.2S
    ADD  V25.8H, V13.8H, V18.8H
    UMIN  V16.8B, V19.8B, V27.8B
    FMLS  V8.4S, V11.4S, V14.4S
    SQSUB  B30, B11, B11
    SQRSHL  D18, D7, D14
    MOV  V7.8B, V24.8B
    FMAX  V17.2D, V26.2D, V9.2D
    SSHL  D13, D28, D5
    SRSHL  V18.8B, V16.8B, V19.8B
    UQSUB  D29, D30, D18
    SABDL  V27.4S, V28.4H, V14.4H
    FMIN  V20.4S, V22.4S, V0.4S
    MOV  V11.8B, V16.8B
    MLA  V17.4S, V14.4S, V14.4S
    SQSHL  V23.8B, V14.8B, V1.8B
    FRECPE  S14, S8
    FRSQRTS  V9.4S, V7.4S, V15.4S
    UHADD  V27.8H, V7.8H, V19.8H
    SQADD  H1, H8, H0
    SSHL  V31.4S, V2.4S, V20.4S
    SQSHL  H28, H11, H4
    UQADD  V20.16B, V14.16B, V26.16B
    FABD  D28, D8, D8
    SABDL2  V29.2D, V8.4S, V27.4S
    FRSQRTS  D4, D27, D13
    FADD  V18.2S, V22.2S, V6.2S
    SHSUB  V24.8H, V16.8H, V19.8H
    SMAX  V11.2S, V29.2S, V22.2S
    FDIV  V22.2S, V22.2S, V30.2S
    ORN  V27.16B, V31.16B, V23.16B
    UQADD  B15, B12, B24
    FRECPE  S9, S18
    SQSUB  S25, S1, S5
    SQSUB  V31.4H, V20.4H, V23.4H
    SQRSHL  V12.2S, V30.2S, V1.2S
    SQADD  D13, D30, D28
    BSL  V24.8B, V29.8B, V26.8B
    SSHL  V11.16B, V12.16B, V6.16B
    MUL  V24.4H, V22.4H, V18.4H
    ORN  V23.8B, V5.8B, V17.8B
    UQSUB  D23, D14, D12
    SRSHL  V29.4H, V2.4H, V3.4H
    SRSHL  D23, D15, D17
    UHSUB  V24.8H, V10.8H, V10.8H
    UMAX  V26.4S, V9.4S, V7.4S
    SRSHL  D0, D4, D4
    SQADD  D0, D7, D23
    BIF  V17.16B, V9.16B, V2.16B
    FMULX  V26.2S, V25.2S, V5.2S
    ORR  V10.16B, V28.16B, V25.16B
    SQSHL  H15, H25, H16
    ADD  V29.4S, V21.4S, V22.4S
    SQSHL  H21, H3, H26
    SQRSHL  H31, H24, H0
    UMIN  V23.8B, V14.8B, V26.8B
    SQADD  V11.2S, V18.2S, V6.2S
    SQRSHL  D4, D24, D12
    ORR  V1.16B, V7.16B, V11.16B
    UQSUB  V15.2S, V31.2S, V9.2S
    SQSUB  D29, D10, D26
    FABD  V6.2S, V30.2S, V25.2S
    ADD  D6, D10, D10
    FMULX  D31, D24, D13
    EOR  V28.8B, V20.8B, V24.8B
    BIC  V5.16B, V11.16B, V29.16B
    SRSHL  V4.4H, V30.4H, V5.4H
    ADD  V0.2S, V18.2S, V3.2S
    UMAX  V16.4S, V12.4S, V9.4S
    SQSHL  H18, H15, H12
    BSL  V18.8B, V26.8B, V7.8B
    SMAX  V26.8H, V19.8H, V7.8H
    ORR  V31.8B, V23.8B, V31.8B
    FDIV  V12.2D, V14.2D, V16.2D
    UQSUB  H24, H12, H1
    UHADD  V3.4H, V27.4H, V21.4H
    URSHL  V30.16B, V17.16B, V11.16B
    SQADD  B14, B7, B25
    SQSHL  V2.4S, V11.4S, V14.4S
    FRSQRTS  D10, D18, D11
    MLA  V12.2S, V9.2S, V19.2S
    UQADD  S7, S1, S6
    UMAX  V27.8H, V25.8H, V11.8H
    FRSQRTS  V26.4S, V16.4S, V0.4S
    SQRSHL  D30, D17, D23
    SSHL  V17.4H, V5.4H, V30.4H
    FMULX  D11, D22, D23
    FRECPE  V0.4S, V28.4S
    UQSUB  V25.8H, V1.8H, V11.8H
    BIT  V17.16B, V5.16B, V15.16B
TaishanSimdPairArithmeticP01_label_335:
    FMINNM  V4.2D, V16.2D, V22.2D
    SQSHL  V2.2S, V27.2S, V20.2S
    FABD  D18, D7, D4
    URHADD  V30.8H, V11.8H, V9.8H
    SQRSHL  H27, H4, H23
    SUB  V29.4S, V27.4S, V30.4S
    SQADD  D20, D0, D24
    SQSHL  S6, S26, S20
    SQSHL  V24.2S, V12.2S, V13.2S
    UQRSHL  H19, H25, H11
    EOR  V0.16B, V1.16B, V8.16B
    FADD  V30.2S, V31.2S, V28.2S
    BSL  V11.8B, V27.8B, V14.8B
    FRECPE  S12, S25
    UQSUB  V2.8H, V12.8H, V8.8H
    UQADD  H24, H24, H10
    USHL  V3.2D, V18.2D, V31.2D
    UABA  V12.4H, V13.4H, V1.4H
    SQSHL  D5, D13, D28
    SABDL  V23.8H, V5.8B, V15.8B
    MUL  V3.8H, V17.8H, V2.8H
    FDIV  V9.2S, V11.2S, V26.2S
    ORR  V11.8B, V28.8B, V18.8B
    URSHL  V21.8H, V10.8H, V27.8H
    UQRSHL  D6, D26, D7
    UQADD  S1, S6, S10
    SABDL2  V24.2D, V24.4S, V5.4S
    FMLS  V14.4S, V16.4S, V8.4S
    SQSHL  V10.8H, V17.8H, V31.8H
    UQRSHL  B28, B25, B16
    FABD  V12.2D, V25.2D, V0.2D
    SQSHL  H31, H31, H21
    SQSHL  B29, B14, B0
    UQADD  S0, S17, S2
    UQSUB  D23, D21, D26
    FMINNM  V1.2D, V13.2D, V21.2D
    FADD  V9.2S, V1.2S, V11.2S
    SUB  V12.8H, V6.8H, V8.8H
    USHL  V23.8B, V26.8B, V7.8B
    FABD  D11, D16, D17
    FABD  V30.2S, V3.2S, V16.2S
    SRHADD  V26.4H, V12.4H, V23.4H
    FSUB  V8.2S, V22.2S, V15.2S
    UQSUB  H12, H10, H8
    SQSHL  D30, D14, D18
    MLA  V29.2S, V6.2S, V24.2S
    UMIN  V25.4H, V17.4H, V11.4H
    FDIV  V8.2S, V0.2S, V17.2S
    SQRSHL  H1, H6, H26
    BIC  V12.16B, V14.16B, V7.16B
    FMIN  V3.4S, V13.4S, V8.4S
    SUB  D19, D27, D11
    URHADD  V18.4S, V29.4S, V20.4S
    SQSHL  S21, S21, S23
    MLS  V9.8B, V19.8B, V6.8B
    FMLA  V29.2D, V6.2D, V26.2D
    SUBS  X10, X10, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_910
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X25, X8, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X8, X25, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X11, X14, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X18, X29, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X23, X13, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X17, X6, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X20, X3, X15
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X20, X22, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X22, X7, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X4, X25, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X27, X11, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X10, X14, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X20, X13, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D3
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0x7fff, LSL #48
    SUB  X28, X8, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D5
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D6
    MOVZ  X3, #0x10, LSL #0
    MOVK  X3, #0xeff8, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xfff, LSL #48
    SUB  X23, X3, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D7
    MOVZ  X16, #0xfffd, LSL #0
    MOVK  X16, #0x8001, LSL #16
    SUB  X4, X16, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D8
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x3f80, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X25, X16, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D10
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0x7fff, LSL #48
    SUB  X14, X28, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D11
    MOVZ  X13, #0xfffe, LSL #0
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0x7fff, LSL #48
    SUB  X26, X13, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D12
    MOVZ  X23, #0x2, LSL #0
    MOVK  X23, #0x7ffe, LSL #16
    SUB  X2, X23, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D14
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    SUB  X15, X8, X17
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D15
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D17
    MOVZ  X10, #0xfffe, LSL #0
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X21, X10, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D18
    MOVZ  X3, #0x7f, LSL #0
    MOVK  X3, #0x8000, LSL #16
    MOVK  X3, #0x7fc0, LSL #48
    SUB  X20, X3, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D19
    MOVZ  X28, #0x2, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0x8000, LSL #48
    SUB  X23, X28, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D20
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xff80, LSL #48
    SUB  X25, X21, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D21
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0x7fff, LSL #16
    SUB  X6, X14, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D22
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7fc0, LSL #16
    MOVK  X28, #0x7fc0, LSL #48
    SUB  X5, X28, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D23
    MOVZ  X25, #0xf, LSL #0
    MOVK  X25, #0x80, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0x7fff, LSL #48
    SUB  X4, X25, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D25
    MOVZ  X23, #0xfffe, LSL #0
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0x7fff, LSL #48
    SUB  X13, X23, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D26
    MOVZ  X2, #0x10, LSL #0
    MOVK  X2, #0xf83d, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0x47ff, LSL #48
    SUB  X17, X2, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D27
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X15, X22, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D28
    MOVZ  X22, #0xff, LSL #0
    SUB  X15, X22, X18
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D29
    MOVZ  X11, #0x24, LSL #0
    MOVK  X11, #0xe835, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0x180f, LSL #48
    SUB  X13, X11, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0xfd14, LSL #0
    MOVK  X2, #0xc92f, LSL #16
    MOVK  X2, #0xc9c9, LSL #32
    MOVK  X2, #0xfb17, LSL #48
    MOVZ  X3, #0xf442, LSL #0
    MOVK  X3, #0xc6bf, LSL #16
    MOVK  X3, #0xf3a8, LSL #32
    MOVK  X3, #0x6527, LSL #48
    MOVZ  X4, #0x91e4, LSL #0
    MOVK  X4, #0xd756, LSL #16
    MOVK  X4, #0x9902, LSL #32
    MOVK  X4, #0x644a, LSL #48
    MOVZ  X5, #0xe70b, LSL #0
    MOVK  X5, #0x5ca3, LSL #16
    MOVK  X5, #0xd3b8, LSL #32
    MOVK  X5, #0x678, LSL #48
    MOVZ  X6, #0xf8c4, LSL #0
    MOVK  X6, #0x1080, LSL #16
    MOVK  X6, #0x3e4, LSL #32
    MOVK  X6, #0xbb16, LSL #48
    MOVZ  X7, #0x2920, LSL #0
    MOVK  X7, #0x94a6, LSL #16
    MOVK  X7, #0x3b56, LSL #32
    MOVK  X7, #0xd502, LSL #48
    MOVZ  X8, #0xc87e, LSL #0
    MOVK  X8, #0x9ff8, LSL #16
    MOVK  X8, #0x5b94, LSL #32
    MOVK  X8, #0x75ca, LSL #48
    MOVZ  X10, #0x2b4e, LSL #0
    MOVK  X10, #0x8ede, LSL #16
    MOVK  X10, #0x5b9c, LSL #32
    MOVK  X10, #0x8102, LSL #48
    MOVZ  X11, #0xddc1, LSL #0
    MOVK  X11, #0x2467, LSL #16
    MOVK  X11, #0x8a04, LSL #32
    MOVK  X11, #0x946a, LSL #48
    MOVZ  X12, #0xd927, LSL #0
    MOVK  X12, #0xca2, LSL #16
    MOVK  X12, #0x207e, LSL #32
    MOVK  X12, #0xf24e, LSL #48
    MOVZ  X13, #0x7106, LSL #0
    MOVK  X13, #0xb616, LSL #16
    MOVK  X13, #0x3a26, LSL #32
    MOVK  X13, #0xf1e6, LSL #48
    MOVZ  X14, #0xbcc6, LSL #0
    MOVK  X14, #0x4258, LSL #16
    MOVK  X14, #0x184b, LSL #32
    MOVK  X14, #0x1fa9, LSL #48
    MOVZ  X15, #0xa25f, LSL #0
    MOVK  X15, #0xa7a6, LSL #16
    MOVK  X15, #0x39fe, LSL #32
    MOVK  X15, #0xcce5, LSL #48
    MOVZ  X16, #0x5215, LSL #0
    MOVK  X16, #0xb9ab, LSL #16
    MOVK  X16, #0x23f2, LSL #32
    MOVK  X16, #0xf2af, LSL #48
    MOVZ  X17, #0x7fc7, LSL #0
    MOVK  X17, #0xac54, LSL #16
    MOVK  X17, #0xeba3, LSL #32
    MOVK  X17, #0x51c0, LSL #48
    MOVZ  X18, #0x678c, LSL #0
    MOVK  X18, #0x3d80, LSL #16
    MOVK  X18, #0x6d98, LSL #32
    MOVK  X18, #0xe259, LSL #48
    MOVZ  X19, #0x3275, LSL #0
    MOVK  X19, #0x91a2, LSL #16
    MOVK  X19, #0x39e8, LSL #32
    MOVK  X19, #0x30ca, LSL #48
    MOVZ  X20, #0xc4f5, LSL #0
    MOVK  X20, #0x665d, LSL #16
    MOVK  X20, #0x8ed5, LSL #32
    MOVK  X20, #0xdb50, LSL #48
    MOVZ  X21, #0x9a06, LSL #0
    MOVK  X21, #0x921f, LSL #16
    MOVK  X21, #0x7f89, LSL #32
    MOVK  X21, #0x7133, LSL #48
    MOVZ  X22, #0x5db, LSL #0
    MOVK  X22, #0x9694, LSL #16
    MOVK  X22, #0xaa6e, LSL #32
    MOVK  X22, #0xcfd6, LSL #48
    MOVZ  X23, #0xcf35, LSL #0
    MOVK  X23, #0x23b2, LSL #16
    MOVK  X23, #0x5c6c, LSL #32
    MOVK  X23, #0x4059, LSL #48
    MOVZ  X24, #0xa868, LSL #0
    MOVK  X24, #0x934f, LSL #16
    MOVK  X24, #0x7922, LSL #32
    MOVK  X24, #0xe237, LSL #48
    MOVZ  X25, #0x2fb6, LSL #0
    MOVK  X25, #0xa80d, LSL #16
    MOVK  X25, #0xf5cf, LSL #32
    MOVK  X25, #0xbce0, LSL #48
    MOVZ  X26, #0x7b5f, LSL #0
    MOVK  X26, #0x9d05, LSL #16
    MOVK  X26, #0xb75f, LSL #32
    MOVK  X26, #0x283d, LSL #48
    MOVZ  X27, #0xb74e, LSL #0
    MOVK  X27, #0xd100, LSL #16
    MOVK  X27, #0x4d49, LSL #32
    MOVK  X27, #0x1cb7, LSL #48
    MOVZ  X28, #0x5d9f, LSL #0
    MOVK  X28, #0x8ab5, LSL #16
    MOVK  X28, #0xd9a3, LSL #32
    MOVK  X28, #0x647d, LSL #48
    MOVZ  X29, #0x8433, LSL #0
    MOVK  X29, #0xca0b, LSL #16
    MOVK  X29, #0x9dbd, LSL #32
    MOVK  X29, #0xe777, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X10
    FMOV  D1, X24
    FMOV  V1.D[1], X5
    FMOV  D2, X13
    FMOV  V2.D[1], X22
    FMOV  D3, X8
    FMOV  V3.D[1], X25
    FMOV  D4, X4
    FMOV  V4.D[1], X2
    FMOV  D5, X2
    FMOV  V5.D[1], X7
    FMOV  D6, X29
    FMOV  V6.D[1], X17
    FMOV  D7, X8
    FMOV  V7.D[1], X26
    FMOV  D8, X14
    FMOV  V8.D[1], X19
    FMOV  D9, X16
    FMOV  V9.D[1], X26
    FMOV  D10, X18
    FMOV  V10.D[1], X23
    FMOV  D11, X4
    FMOV  V11.D[1], X10
    FMOV  D12, X21
    FMOV  V12.D[1], X16
    FMOV  D13, X13
    FMOV  V13.D[1], X20
    FMOV  D14, X23
    FMOV  V14.D[1], X7
    FMOV  D15, X23
    FMOV  V15.D[1], X14
    FMOV  D16, X13
    FMOV  V16.D[1], X25
    FMOV  D17, X10
    FMOV  V17.D[1], X20
    FMOV  D18, X23
    FMOV  V18.D[1], X16
    FMOV  D19, X2
    FMOV  V19.D[1], X29
    FMOV  D20, X10
    FMOV  V20.D[1], X26
    FMOV  D21, X17
    FMOV  V21.D[1], X23
    FMOV  D22, X21
    FMOV  V22.D[1], X2
    FMOV  D23, X24
    FMOV  V23.D[1], X28
    FMOV  D24, X26
    FMOV  V24.D[1], X25
    FMOV  D25, X25
    FMOV  V25.D[1], X7
    FMOV  D26, X10
    FMOV  V26.D[1], X18
    FMOV  D27, X20
    FMOV  V27.D[1], X3
    FMOV  D28, X21
    FMOV  V28.D[1], X17
    FMOV  D29, X20
    FMOV  V29.D[1], X14
    FMOV  D30, X12
    FMOV  V30.D[1], X3
    FMOV  D31, X18
    FMOV  V31.D[1], X11
    MOVZ  X17, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_993:
    SQADD  S24, S9, S28
    SQSHL  D29, D31, D3
    SABDL  V13.8H, V8.8B, V9.8B
    FRECPE  D16, D15
    SUB  V5.2D, V15.2D, V31.2D
    SQSHL  D0, D8, D7
    MLS  V16.8B, V17.8B, V25.8B
    FRSQRTS  V4.2S, V3.2S, V9.2S
    UQSUB  B17, B13, B10
    UQRSHL  S24, S4, S29
    SQADD  S11, S19, S19
    UQSUB  V3.2D, V30.2D, V0.2D
    FRSQRTS  V27.2D, V11.2D, V7.2D
    SMIN  V26.8B, V5.8B, V29.8B
    FADD  V27.2D, V1.2D, V16.2D
    SQRSHL  V27.2D, V5.2D, V10.2D
    SQRSHL  B5, B24, B18
    SHADD  V1.2S, V28.2S, V26.2S
    FABD  V23.2D, V25.2D, V26.2D
    UQSUB  B27, B29, B24
    USHL  D26, D1, D1
    SABDL2  V17.4S, V23.8H, V6.8H
    FRSQRTS  D9, D31, D26
    UQADD  H18, H28, H31
    AND  V18.8B, V3.8B, V30.8B
    SMIN  V9.8B, V15.8B, V11.8B
    SRHADD  V5.16B, V27.16B, V13.16B
    UABA  V5.8H, V18.8H, V30.8H
    ORN  V24.8B, V6.8B, V9.8B
    SQSHL  V10.2D, V2.2D, V7.2D
    FMLA  V20.2S, V26.2S, V23.2S
    ADD  V25.16B, V1.16B, V1.16B
    USHL  V8.8B, V5.8B, V1.8B
    SQSHL  S31, S19, S23
    SQSUB  B15, B25, B30
    MOV  V30.16B, V7.16B
    SQRSHL  H30, H31, H15
    FRSQRTS  S20, S25, S3
    MLS  V17.16B, V1.16B, V0.16B
    SSHL  V24.16B, V4.16B, V25.16B
    FMULX  V7.2D, V17.2D, V24.2D
    FMLS  V26.2D, V3.2D, V20.2D
    FMAXNM  V23.2D, V23.2D, V26.2D
    SQRSHL  B23, B29, B23
    FDIV  V17.2S, V26.2S, V28.2S
    SRHADD  V5.4S, V22.4S, V7.4S
    UABA  V24.4H, V24.4H, V25.4H
    UQSUB  B22, B9, B8
    MUL  V18.16B, V26.16B, V29.16B
    SSHL  V16.8B, V24.8B, V7.8B
    SQSUB  B30, B9, B16
    UQRSHL  B3, B16, B6
    FABD  D18, D9, D20
    FMAX  V27.2S, V26.2S, V17.2S
    ADD  V19.4S, V17.4S, V23.4S
    URHADD  V24.2S, V11.2S, V28.2S
    MOV  V24.8B, V20.8B
    FMIN  V5.2S, V4.2S, V18.2S
    MLS  V10.16B, V30.16B, V7.16B
    UQSUB  D9, D27, D0
    UQSUB  H30, H30, H22
    UQADD  H25, H18, H31
    SRHADD  V19.2S, V3.2S, V5.2S
    SHADD  V8.8H, V16.8H, V16.8H
    FMULX  D8, D31, D19
    UQSUB  V23.4H, V24.4H, V3.4H
    FABD  D2, D30, D15
    UQRSHL  B30, B16, B20
    FRECPE  S5, S3
    SQADD  H2, H25, H24
    FRSQRTS  V0.2S, V4.2S, V22.2S
    ORN  V15.8B, V7.8B, V19.8B
    UQADD  H7, H22, H20
    FADD  V4.4S, V12.4S, V8.4S
    USHL  V16.2D, V7.2D, V22.2D
    UQSUB  S23, S10, S0
    SQSHL  B28, B11, B30
    SABDL  V3.2D, V28.2S, V9.2S
    FMLS  V2.2D, V20.2D, V29.2D
    UQSUB  B28, B9, B19
    SQSUB  B2, B24, B24
    URSHL  V25.4S, V3.4S, V11.4S
    UMAX  V26.8H, V13.8H, V22.8H
    BIC  V27.16B, V23.16B, V18.16B
    SSHL  D25, D15, D2
    ORR  V30.16B, V20.16B, V14.16B
    MLA  V0.8B, V28.8B, V10.8B
    SQRSHL  D16, D28, D12
    SABD  V1.4H, V13.4H, V29.4H
    UMIN  V28.4S, V0.4S, V4.4S
    UQRSHL  H30, H9, H8
    SUB  V21.4H, V26.4H, V10.4H
    URSHL  V27.8B, V25.8B, V25.8B
    SQRSHL  V16.2D, V6.2D, V6.2D
    SQSHL  S22, S16, S7
    SQSHL  H18, H2, H8
    FDIV  V26.4S, V0.4S, V1.4S
    SQADD  D3, D30, D30
    SQADD  D8, D14, D20
    UQSUB  H29, H14, H13
    SQSUB  V17.2S, V10.2S, V23.2S
    SQADD  H4, H9, H26
    SQRSHL  D4, D21, D16
    SQSUB  V17.2S, V8.2S, V3.2S
    SQRSHL  B5, B8, B25
    UQSUB  V12.16B, V10.16B, V27.16B
    SQSUB  V13.16B, V12.16B, V12.16B
    SMIN  V12.8H, V16.8H, V14.8H
    UQRSHL  B29, B28, B20
    FSUB  V12.2S, V6.2S, V2.2S
    SQSUB  H20, H11, H20
    SQADD  V10.4H, V23.4H, V2.4H
    ORR  V4.8B, V25.8B, V25.8B
    UMAX  V0.8H, V13.8H, V15.8H
    SRSHL  V30.16B, V26.16B, V14.16B
    SQADD  H2, H3, H22
    FMIN  V13.4S, V7.4S, V22.4S
    BIC  V18.16B, V3.16B, V3.16B
    UABA  V30.2S, V18.2S, V17.2S
    SHSUB  V28.2S, V25.2S, V7.2S
    SQADD  S2, S2, S11
    FABD  D18, D29, D16
    SQSHL  H5, H17, H8
    FMULX  S16, S14, S8
    SQSUB  B14, B30, B10
    SUB  D2, D23, D11
    SRSHL  V23.4H, V10.4H, V19.4H
    SQSHL  B30, B28, B19
    UQADD  B18, B26, B5
    UMAX  V2.8B, V25.8B, V27.8B
    FMINNM  V2.2S, V30.2S, V24.2S
    UHADD  V15.16B, V13.16B, V4.16B
    SSHL  V23.8B, V24.8B, V24.8B
    SQSUB  B16, B22, B15
    USHL  D10, D16, D14
    SQADD  S12, S10, S1
    SQSUB  V4.8B, V29.8B, V8.8B
    UQRSHL  V0.8B, V14.8B, V11.8B
    FRECPE  D26, D26
    UQRSHL  H6, H5, H11
    BSL  V26.8B, V6.8B, V4.8B
    BSL  V2.8B, V21.8B, V28.8B
    UMIN  V18.4S, V22.4S, V3.4S
    ADD  D23, D28, D29
    FABD  D27, D12, D10
    BIF  V2.8B, V12.8B, V18.8B
    SABDL  V30.4S, V7.4H, V24.4H
    FMINNM  V21.4S, V28.4S, V21.4S
    UHADD  V25.4H, V0.4H, V3.4H
    FMLS  V8.2D, V21.2D, V26.2D
    UQADD  V25.2D, V2.2D, V15.2D
    UQSUB  S29, S30, S1
    SABD  V26.8H, V16.8H, V10.8H
    SQRSHL  S26, S5, S16
    UQRSHL  D18, D20, D23
    SABD  V26.2S, V21.2S, V27.2S
    UQRSHL  B14, B14, B29
    UQADD  B18, B8, B3
    SRSHL  D7, D4, D26
    SQSHL  D0, D2, D18
    SMIN  V6.4S, V0.4S, V9.4S
    SQRSHL  V9.2S, V27.2S, V12.2S
    SQSUB  B27, B9, B9
    SQSHL  B15, B10, B20
    FRECPE  V29.2S, V1.2S
    FMUL  V0.2D, V27.2D, V9.2D
    ORR  V0.8B, V4.8B, V30.8B
    SMAX  V29.16B, V8.16B, V24.16B
    FRECPE  D29, D10
    MLS  V0.16B, V22.16B, V29.16B
    UQADD  S22, S9, S14
    MUL  V2.8B, V12.8B, V5.8B
    UQRSHL  S9, S24, S28
    MLA  V16.4H, V1.4H, V26.4H
    ADD  D2, D18, D4
    BIC  V1.8B, V0.8B, V17.8B
    FABD  S15, S7, S25
    UMIN  V6.4H, V31.4H, V4.4H
    FABD  D18, D3, D10
    SSHL  D22, D10, D5
    URSHL  D21, D17, D24
    FMULX  D8, D20, D31
    SQSUB  V1.8B, V14.8B, V27.8B
    UQRSHL  D19, D13, D1
    ADD  V0.2D, V12.2D, V28.2D
    SQADD  H24, H30, H29
    UQSUB  B8, B22, B2
    FRECPE  V25.4S, V30.4S
    UMAX  V8.4H, V17.4H, V24.4H
    SSHL  V20.4S, V16.4S, V12.4S
    FMLS  V20.2D, V24.2D, V9.2D
    SQSHL  S2, S31, S5
    UHADD  V17.8B, V18.8B, V15.8B
    MLA  V24.8B, V26.8B, V21.8B
    SQRSHL  H1, H19, H9
    SQADD  V7.4H, V25.4H, V2.4H
    SABDL  V22.8H, V26.8B, V7.8B
    URHADD  V19.8H, V11.8H, V6.8H
    FMUL  V12.4S, V13.4S, V1.4S
    FRECPE  V23.2S, V14.2S
    SUBS  X17, X17, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_993
    MOVZ  X27, #0xfd14, LSL #0
    MOVK  X27, #0xc92f, LSL #16
    MOVK  X27, #0xc9c9, LSL #32
    MOVK  X27, #0xfb17, LSL #48
    SUB  X5, X27, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0xf442, LSL #0
    MOVK  X4, #0xc6bf, LSL #16
    MOVK  X4, #0xf3a8, LSL #32
    MOVK  X4, #0x6527, LSL #48
    SUB  X24, X4, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0xf442, LSL #0
    MOVK  X21, #0xc6bf, LSL #16
    MOVK  X21, #0xf3a8, LSL #32
    MOVK  X21, #0x6527, LSL #48
    SUB  X17, X21, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0xf8c4, LSL #0
    MOVK  X10, #0x1080, LSL #16
    MOVK  X10, #0x3e4, LSL #32
    MOVK  X10, #0xbb16, LSL #48
    SUB  X26, X10, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x2920, LSL #0
    MOVK  X11, #0x94a6, LSL #16
    MOVK  X11, #0x3b56, LSL #32
    MOVK  X11, #0xd502, LSL #48
    SUB  X13, X11, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0xc87e, LSL #0
    MOVK  X10, #0x9ff8, LSL #16
    MOVK  X10, #0x5b94, LSL #32
    MOVK  X10, #0x75ca, LSL #48
    SUB  X24, X10, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0xc87e, LSL #0
    MOVK  X6, #0x9ff8, LSL #16
    MOVK  X6, #0x5b94, LSL #32
    MOVK  X6, #0x75ca, LSL #48
    SUB  X15, X6, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x2920, LSL #0
    MOVK  X14, #0x94a6, LSL #16
    MOVK  X14, #0x3b56, LSL #32
    MOVK  X14, #0xd502, LSL #48
    SUB  X27, X14, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0xd927, LSL #0
    MOVK  X16, #0xca2, LSL #16
    MOVK  X16, #0x207e, LSL #32
    MOVK  X16, #0xf24e, LSL #48
    SUB  X2, X16, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X15
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0xd927, LSL #0
    MOVK  X12, #0xca2, LSL #16
    MOVK  X12, #0x207e, LSL #32
    MOVK  X12, #0xf24e, LSL #48
    SUB  X7, X12, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X17
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x678c, LSL #0
    MOVK  X6, #0x3d80, LSL #16
    MOVK  X6, #0x6d98, LSL #32
    MOVK  X6, #0xe259, LSL #48
    SUB  X24, X6, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0xc4f5, LSL #0
    MOVK  X8, #0x665d, LSL #16
    MOVK  X8, #0x8ed5, LSL #32
    MOVK  X8, #0xdb50, LSL #48
    SUB  X7, X8, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x5db, LSL #0
    MOVK  X10, #0x9694, LSL #16
    MOVK  X10, #0xaa6e, LSL #32
    MOVK  X10, #0xcfd6, LSL #48
    SUB  X22, X10, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x2fb6, LSL #0
    MOVK  X5, #0xa80d, LSL #16
    MOVK  X5, #0xf5cf, LSL #32
    MOVK  X5, #0xbce0, LSL #48
    SUB  X16, X5, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x5d9f, LSL #0
    MOVK  X6, #0x8ab5, LSL #16
    MOVK  X6, #0xd9a3, LSL #32
    MOVK  X6, #0x647d, LSL #48
    SUB  X16, X6, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x8433, LSL #0
    MOVK  X25, #0xca0b, LSL #16
    MOVK  X25, #0x9dbd, LSL #32
    MOVK  X25, #0xe777, LSL #48
    SUB  X14, X25, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D2
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D3
    MOVZ  X16, #0x2, LSL #0
    SUB  X25, X16, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D4
    MOVZ  X20, #0xb8, LSL #0
    MOVK  X20, #0xc140, LSL #16
    SUB  X28, X20, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D5
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X13, X12, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D7
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7f80, LSL #16
    MOVK  X29, #0x7f80, LSL #48
    SUB  X12, X29, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D8
    MOVZ  X13, #0xa0, LSL #0
    MOVK  X13, #0x3fc0, LSL #16
    SUB  X18, X13, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D11
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0x7fff, LSL #16
    SUB  X25, X2, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D13
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D14
    MOVZ  X25, #0x47, LSL #0
    SUB  X7, X25, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D15
    MOVZ  X18, #0x821f, LSL #0
    MOVK  X18, #0x7f6f, LSL #16
    SUB  X17, X18, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D16
    MOVZ  X22, #0x5321, LSL #0
    MOVK  X22, #0x3e0, LSL #16
    MOVK  X22, #0xf56e, LSL #32
    MOVK  X22, #0x7001, LSL #48
    SUB  X5, X22, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D17
    MOVZ  X5, #0x4110, LSL #0
    MOVK  X5, #0x3f37, LSL #16
    SUB  X24, X5, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D18
    MOVZ  X29, #0x2, LSL #0
    SUB  X20, X29, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D19
    MOVZ  X14, #0x8000, LSL #0
    MOVK  X14, #0x4000, LSL #16
    SUB  X2, X14, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D20
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xf56e, LSL #32
    MOVK  X7, #0x7001, LSL #48
    SUB  X2, X7, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D21
    MOVZ  X29, #0x46, LSL #0
    MOVK  X29, #0x3fc0, LSL #16
    SUB  X20, X29, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X5, #0x42, LSL #0
    MOVK  X5, #0x1, LSL #16
    MOVK  X5, #0x3f, LSL #32
    SUB  X23, X5, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D22
    MOVZ  X5, #0x7, LSL #0
    MOVK  X5, #0x12, LSL #16
    MOVK  X5, #0x9f, LSL #32
    MOVK  X5, #0x7f, LSL #48
    SUB  X23, X5, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D23
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7f80, LSL #16
    MOVK  X29, #0x7f80, LSL #48
    SUB  X5, X29, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D24
    MOVZ  X5, #0x8a, LSL #0
    MOVK  X5, #0x40, LSL #16
    SUB  X19, X5, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7f80, LSL #16
    MOVK  X8, #0x7f80, LSL #48
    SUB  X17, X8, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D25
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7f80, LSL #16
    MOVK  X8, #0x7f80, LSL #48
    SUB  X17, X8, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D26
    MOVZ  X19, #0x1207, LSL #0
    MOVK  X19, #0x1f, LSL #16
    MOVK  X19, #0xffbe, LSL #32
    MOVK  X19, #0x7fbf, LSL #48
    SUB  X17, X19, X15
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D27
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D28
    MOVZ  X26, #0xefa7, LSL #0
    MOVK  X26, #0xffcf, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X21, X26, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D29
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff0, LSL #48
    SUB  X28, X12, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  D0, X22
    FMOV  V0.D[1], X14
    FMOV  D1, X22
    FMOV  V1.D[1], X21
    FMOV  D2, X12
    FMOV  V2.D[1], X11
    FMOV  D3, X27
    FMOV  V3.D[1], X11
    FMOV  D4, X14
    FMOV  V4.D[1], X8
    FMOV  D5, X15
    FMOV  V5.D[1], X27
    FMOV  D6, X26
    FMOV  V6.D[1], X25
    FMOV  D7, X24
    FMOV  V7.D[1], X29
    FMOV  D8, X7
    FMOV  V8.D[1], X3
    FMOV  D9, X28
    FMOV  V9.D[1], X15
    FMOV  D10, X28
    FMOV  V10.D[1], X23
    FMOV  D11, X13
    FMOV  V11.D[1], X27
    FMOV  D12, X28
    FMOV  V12.D[1], X25
    FMOV  D13, X15
    FMOV  V13.D[1], X12
    FMOV  D14, X3
    FMOV  V14.D[1], X12
    FMOV  D15, X22
    FMOV  V15.D[1], X10
    FMOV  D16, X15
    FMOV  V16.D[1], X23
    FMOV  D17, X24
    FMOV  V17.D[1], X10
    FMOV  D18, X26
    FMOV  V18.D[1], X12
    FMOV  D19, X7
    FMOV  V19.D[1], X17
    FMOV  D20, X15
    FMOV  V20.D[1], X15
    FMOV  D21, X28
    FMOV  V21.D[1], X17
    FMOV  D22, X12
    FMOV  V22.D[1], X12
    FMOV  D23, X22
    FMOV  V23.D[1], X12
    FMOV  D24, X19
    FMOV  V24.D[1], X20
    FMOV  D25, X28
    FMOV  V25.D[1], X26
    FMOV  D26, X27
    FMOV  V26.D[1], X14
    FMOV  D27, X3
    FMOV  V27.D[1], X15
    FMOV  D28, X22
    FMOV  V28.D[1], X22
    FMOV  D29, X29
    FMOV  V29.D[1], X5
    FMOV  D30, X29
    FMOV  V30.D[1], X13
    FMOV  D31, X3
    FMOV  V31.D[1], X16
    MOVZ  X14, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_1075:
    URSHL  V20.8B, V23.8B, V26.8B
    EOR  V21.8B, V26.8B, V30.8B
    SQADD  D29, D4, D19
    MUL  V9.4S, V17.4S, V24.4S
    FABD  V27.2S, V24.2S, V28.2S
    USHL  V27.2D, V23.2D, V25.2D
    FRSQRTS  D5, D6, D22
    SABDL2  V23.2D, V0.4S, V26.4S
    FMULX  S11, S2, S18
    MUL  V6.4S, V18.4S, V7.4S
    USHL  V23.2S, V18.2S, V5.2S
    BIC  V9.8B, V17.8B, V17.8B
    FABD  D2, D29, D2
    SQSHL  H21, H29, H9
    BIF  V22.16B, V17.16B, V15.16B
    FABD  D23, D4, D23
    UQRSHL  H19, H8, H15
    SSHL  D5, D2, D5
    FRECPE  V17.4S, V20.4S
    FMULX  V31.2D, V6.2D, V4.2D
    ADD  D13, D2, D31
    UABA  V25.8H, V24.8H, V22.8H
    SUB  V23.4H, V30.4H, V17.4H
    MOV  V19.8B, V1.8B
    FMAX  V30.2D, V26.2D, V12.2D
    UQRSHL  D9, D22, D17
    SMIN  V22.8H, V5.8H, V13.8H
    USHL  D30, D0, D8
    MLS  V2.4S, V9.4S, V10.4S
    UQADD  D22, D28, D25
    SQSHL  S21, S22, S19
    SQSHL  V16.4H, V4.4H, V28.4H
    UQRSHL  V13.2S, V27.2S, V30.2S
    AND  V29.8B, V7.8B, V2.8B
    MOV  V29.16B, V21.16B
    EOR  V16.16B, V23.16B, V18.16B
    UQSUB  V8.16B, V29.16B, V28.16B
    UQSUB  V11.4H, V16.4H, V26.4H
    SQSUB  H10, H28, H11
    FDIV  V16.2S, V27.2S, V9.2S
    FMULX  D9, D27, D13
    AND  V10.16B, V30.16B, V19.16B
    BSL  V17.8B, V12.8B, V5.8B
    SQRSHL  D27, D19, D24
    EOR  V23.16B, V30.16B, V24.16B
    SQADD  B23, B5, B12
    SHADD  V10.4H, V31.4H, V17.4H
    SQADD  D15, D28, D18
    ORN  V24.16B, V5.16B, V25.16B
TaishanSimdPairArithmeticP01_label_153:
    SQADD  B25, B18, B24
    FDIV  V16.2S, V26.2S, V21.2S
    UHSUB  V21.8B, V15.8B, V29.8B
    BIF  V5.16B, V25.16B, V11.16B
    MUL  V0.8B, V5.8B, V16.8B
    FABD  V13.2D, V16.2D, V5.2D
    UQADD  D16, D31, D2
    SQSHL  D26, D9, D21
    SQSUB  D29, D21, D1
    FRECPE  V0.4S, V19.4S
    SABD  V12.2S, V22.2S, V9.2S
    SHADD  V29.4S, V4.4S, V26.4S
    SRSHL  D28, D30, D9
    UMIN  V24.4H, V7.4H, V17.4H
    SABD  V31.2S, V17.2S, V19.2S
    UQRSHL  B27, B6, B22
    URSHL  D20, D17, D4
    ORN  V10.16B, V9.16B, V21.16B
    SABDL  V18.4S, V23.4H, V20.4H
    SMIN  V27.16B, V21.16B, V17.16B
    FADD  V16.4S, V31.4S, V18.4S
    FADD  V6.2D, V0.2D, V0.2D
    SABDL  V18.2D, V4.2S, V6.2S
    SRHADD  V12.4H, V6.4H, V6.4H
    SRSHL  D20, D0, D27
    FMIN  V21.4S, V10.4S, V27.4S
    FRECPE  S3, S24
    MLA  V6.4H, V1.4H, V2.4H
    UQSUB  H18, H30, H19
    UQRSHL  H25, H22, H6
    BIT  V26.16B, V18.16B, V4.16B
    MOV  V31.8B, V16.8B
    UQSUB  B18, B27, B20
    SABDL2  V0.2D, V23.4S, V19.4S
    UMIN  V4.16B, V11.16B, V18.16B
    SMAX  V11.8H, V9.8H, V28.8H
    SRHADD  V24.4H, V21.4H, V10.4H
    SQADD  S15, S31, S24
    FMULX  D17, D4, D29
    FMULX  S8, S27, S6
    FMLS  V18.2S, V26.2S, V10.2S
    ORR  V26.16B, V2.16B, V15.16B
    FABD  V20.2S, V31.2S, V15.2S
    FMLS  V25.2D, V20.2D, V7.2D
    UHADD  V10.8B, V28.8B, V4.8B
    FDIV  V22.2D, V26.2D, V6.2D
    SQADD  V7.4S, V18.4S, V19.4S
    BIT  V29.16B, V20.16B, V29.16B
    UQADD  B12, B25, B14
    FRSQRTS  V31.2D, V3.2D, V3.2D
    SRSHL  V11.8B, V6.8B, V1.8B
    MOV  V8.16B, V0.16B
    BIC  V9.8B, V30.8B, V20.8B
    FRECPE  V8.4S, V16.4S
    FRSQRTS  D16, D8, D22
    SQRSHL  H29, H28, H10
    SMAX  V30.4H, V28.4H, V15.4H
    FRSQRTS  D30, D1, D14
    SQSHL  B25, B26, B22
    BIC  V24.16B, V30.16B, V23.16B
    AND  V25.8B, V0.8B, V24.8B
    UHSUB  V1.8H, V3.8H, V1.8H
    SRSHL  D12, D23, D31
    ORN  V4.8B, V28.8B, V18.8B
    SQSUB  S6, S31, S18
    SQADD  S11, S8, S0
    BIT  V13.16B, V27.16B, V9.16B
    UQSUB  D8, D27, D28
    UQRSHL  D8, D8, D27
    URSHL  D3, D0, D11
    FRSQRTS  V14.2S, V9.2S, V16.2S
    SUB  V12.4H, V16.4H, V8.4H
    SRHADD  V9.4H, V13.4H, V7.4H
    SABDL  V9.4S, V9.4H, V5.4H
    FMIN  V20.4S, V0.4S, V29.4S
    MLS  V23.4H, V3.4H, V1.4H
    FMLA  V9.2S, V0.2S, V25.2S
    FRSQRTS  D20, D10, D14
    FMIN  V24.2D, V6.2D, V6.2D
    FMAX  V10.2D, V24.2D, V1.2D
    UQRSHL  H16, H7, H31
    ORN  V27.8B, V5.8B, V18.8B
    FMLS  V17.4S, V14.4S, V0.4S
    SQADD  B4, B5, B11
    SQSHL  S29, S24, S27
    FRSQRTS  S14, S23, S24
    UQRSHL  D14, D13, D24
    UQADD  D0, D17, D9
    SQSUB  S24, S8, S10
    SQSUB  S8, S16, S0
    SQADD  S11, S13, S24
    SUB  D3, D14, D31
    URSHL  D29, D4, D21
    FABD  S20, S9, S5
    USHL  D31, D6, D20
    SQADD  H23, H16, H0
    SABD  V18.2S, V23.2S, V31.2S
    SQSUB  H30, H22, H18
    SHADD  V27.4H, V7.4H, V5.4H
    SRSHL  V22.4S, V7.4S, V2.4S
    UQRSHL  H12, H29, H6
    SQSHL  D10, D22, D30
    SABDL2  V19.2D, V27.4S, V14.4S
    SQSHL  V12.2S, V9.2S, V11.2S
    UMIN  V26.2S, V23.2S, V30.2S
    SUB  V25.4S, V29.4S, V22.4S
    FRECPE  V1.2D, V18.2D
    SMIN  V27.2S, V29.2S, V24.2S
    FRECPE  S8, S17
    UQADD  V6.4H, V2.4H, V16.4H
    SSHL  V1.16B, V30.16B, V9.16B
    FABD  D12, D27, D30
    SQRSHL  S1, S7, S2
    SQADD  B0, B24, B7
    SQSHL  D21, D30, D18
    SUB  D17, D6, D15
    URHADD  V26.8B, V5.8B, V14.8B
    FMIN  V8.2D, V7.2D, V19.2D
    FMINNM  V24.2D, V21.2D, V20.2D
    SRSHL  V25.4S, V14.4S, V9.4S
    SUB  D15, D2, D21
    ORN  V5.8B, V25.8B, V21.8B
    FRSQRTS  V21.2D, V18.2D, V26.2D
    SRSHL  V20.16B, V23.16B, V7.16B
    SQSHL  S16, S11, S1
    SQSUB  H11, H2, H23
    SQSUB  S9, S19, S3
    ORN  V6.8B, V1.8B, V1.8B
    SQRSHL  V27.2D, V9.2D, V22.2D
    UMIN  V19.8H, V1.8H, V18.8H
    FRSQRTS  V25.2D, V10.2D, V14.2D
    SQSHL  B19, B4, B7
    FRSQRTS  D7, D26, D3
    SABDL2  V9.4S, V28.8H, V30.8H
    FABD  D30, D4, D13
    FMAX  V29.2D, V6.2D, V7.2D
    UQRSHL  B2, B11, B8
    SQRSHL  D23, D3, D11
    UQADD  H5, H26, H6
    SQSHL  V25.2D, V24.2D, V3.2D
    FRSQRTS  S22, S28, S17
    SQRSHL  H10, H25, H10
    FRECPE  D19, D27
    SQRSHL  B4, B29, B15
    MOV  V2.8B, V11.8B
    UQADD  S31, S27, S29
    SQSUB  D31, D25, D25
    SQADD  B1, B14, B31
    MUL  V22.8H, V16.8H, V9.8H
    FRECPE  D29, D21
    UQRSHL  H28, H26, H2
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_1075
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X7, X14, X6
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X26, X10, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X15
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D2
    MOVZ  X12, #0x7fff, LSL #0
    SUB  X5, X12, X24
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D3
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xc007, LSL #48
    SUB  X21, X7, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D5
    MOVZ  X7, #0xffff, LSL #0
    SUB  X22, X7, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D6
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D7
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x3ff8, LSL #48
    SUB  X20, X3, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D8
    MOVZ  X17, #0x190, LSL #0
    MOVK  X17, #0xffa1, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X4, X17, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D10
    MOVZ  X22, #0x22aa, LSL #0
    SUB  X12, X22, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D11
    MOVZ  X29, #0x7fff, LSL #0
    SUB  X25, X29, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D12
    MOVZ  X21, #0x7fff, LSL #0
    SUB  X24, X21, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X5
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D13
    MOVZ  X7, #0xb919, LSL #0
    MOVK  X7, #0xbf7d, LSL #16
    MOVK  X7, #0x7f80, LSL #48
    SUB  X23, X7, X5
TaishanSimdPairArithmeticP01_label_1032:
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D14
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X27, X19, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D15
    MOVZ  X14, #0x7ff9, LSL #0
    MOVK  X14, #0xf7e5, LSL #16
    MOVK  X14, #0xfff0, LSL #48
    SUB  X22, X14, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X29, X8, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D16
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    SUB  X29, X8, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D17
    MOVZ  X16, #0x2d5f, LSL #0
    MOVK  X16, #0xf8a5, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0x7fef, LSL #48
    SUB  X4, X16, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D18
    MOVZ  X6, #0xa45c, LSL #0
    SUB  X7, X6, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D19
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7ff0, LSL #48
    SUB  X22, X28, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D20
    MOVZ  X8, #0x4800, LSL #0
    SUB  X2, X8, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x3ff8, LSL #48
    SUB  X15, X2, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D21
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x3ff8, LSL #48
    SUB  X15, X2, X12
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D23
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xe004, LSL #48
    SUB  X17, X3, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D24
    MOVZ  X10, #0x22ab, LSL #0
    SUB  X25, X10, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D25
    MOVZ  X29, #0x1155, LSL #0
    SUB  X17, X29, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D26
    MOVZ  X8, #0x8094, LSL #0
    MOVK  X8, #0x8080, LSL #16
    MOVK  X8, #0x8080, LSL #32
    MOVK  X8, #0x8080, LSL #48
    SUB  X7, X8, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D27
    MOVZ  X21, #0x4, LSL #0
    SUB  X2, X21, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D28
    MOVZ  X19, #0x404a, LSL #0
    SUB  X25, X19, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D29
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5000, LSL #32
    MOVK  X23, #0x3fe5, LSL #48
    SUB  X11, X23, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X23
    FMOV  D3, X27
    FMOV  V3.D[1], X19
    FMOV  D4, X26
    FMOV  V4.D[1], X23
    FMOV  D5, X2
    FMOV  V5.D[1], X28
    FMOV  D6, X28
    FMOV  V6.D[1], X20
    FMOV  D7, X24
    FMOV  V7.D[1], X23
    FMOV  D8, X5
    FMOV  V8.D[1], X21
    FMOV  D9, X2
    FMOV  V9.D[1], X29
    FMOV  D10, X15
    FMOV  V10.D[1], X8
    FMOV  D11, X4
    FMOV  V11.D[1], X20
    FMOV  D12, X11
    FMOV  V12.D[1], X8
    FMOV  D13, X20
    FMOV  V13.D[1], X22
    FMOV  D14, X23
    FMOV  V14.D[1], X4
    FMOV  D15, X6
    FMOV  V15.D[1], X25
    FMOV  D16, X23
    FMOV  V16.D[1], X7
    FMOV  D17, X26
    FMOV  V17.D[1], X25
    FMOV  D18, X26
    FMOV  V18.D[1], X28
    FMOV  D19, X27
    FMOV  V19.D[1], X22
    FMOV  D20, X2
    FMOV  V20.D[1], X24
    FMOV  D21, X14
    FMOV  V21.D[1], X21
    FMOV  D22, X8
    FMOV  V22.D[1], X17
    FMOV  D23, X19
    FMOV  V23.D[1], X29
    FMOV  D24, X4
    FMOV  V24.D[1], X5
    FMOV  D25, X14
    FMOV  V25.D[1], X10
    FMOV  D26, X20
    FMOV  V26.D[1], X10
    FMOV  D27, X21
    FMOV  V27.D[1], X5
TaishanSimdPairArithmeticP01_label_7:
    FMOV  D28, X19
    FMOV  V28.D[1], X6
    FMOV  D29, X28
    FMOV  V29.D[1], X25
    FMOV  D30, X29
    FMOV  V30.D[1], X24
    FMOV  D31, X23
    FMOV  V31.D[1], X26
    MOVZ  X23, #0xf, LSL #0
TaishanSimdPairArithmeticP01_label_1156:
    UQADD  B21, B26, B0
    BIC  V18.16B, V1.16B, V11.16B
    SQSHL  D29, D5, D13
    FMINNM  V25.2D, V5.2D, V30.2D
    UQRSHL  V15.16B, V25.16B, V31.16B
    SUB  V15.2S, V7.2S, V29.2S
    MLS  V20.8H, V5.8H, V1.8H
    UQRSHL  B10, B16, B11
    FMIN  V11.4S, V8.4S, V3.4S
    SMAX  V29.4H, V27.4H, V28.4H
    UQADD  V8.2S, V5.2S, V21.2S
    SSHL  D9, D15, D6
    SUB  D13, D6, D27
    URHADD  V30.8H, V23.8H, V21.8H
    UQRSHL  H15, H1, H11
    ADD  D26, D13, D25
    FMLA  V12.4S, V30.4S, V23.4S
    MOV  V31.8B, V1.8B
    SQADD  B10, B1, B12
    SQSHL  V18.2D, V27.2D, V29.2D
    FABD  V0.2D, V18.2D, V3.2D
    SABDL  V10.8H, V21.8B, V13.8B
    FMINNM  V15.2D, V8.2D, V28.2D
    SSHL  V2.4S, V26.4S, V20.4S
    UMAX  V17.4S, V28.4S, V2.4S
    SQSUB  V29.8B, V28.8B, V7.8B
    MUL  V15.4S, V16.4S, V23.4S
    SQRSHL  V8.8H, V3.8H, V24.8H
    FMULX  D0, D2, D17
    SRSHL  D11, D27, D22
    UMIN  V31.8H, V6.8H, V10.8H
    FABD  V22.2S, V9.2S, V5.2S
    SHADD  V22.8B, V15.8B, V11.8B
    FRECPE  S10, S15
    FMUL  V26.4S, V26.4S, V29.4S
    SABDL2  V31.4S, V2.8H, V13.8H
    FMINNM  V26.4S, V10.4S, V21.4S
    UHSUB  V20.16B, V28.16B, V28.16B
    FSUB  V28.2S, V31.2S, V26.2S
    EOR  V28.16B, V12.16B, V7.16B
    FMAXNM  V8.2S, V23.2S, V1.2S
    UQRSHL  S9, S5, S28
    SHADD  V2.4S, V24.4S, V12.4S
    UHSUB  V22.2S, V11.2S, V6.2S
    FADD  V9.2S, V6.2S, V31.2S
    MUL  V0.8B, V25.8B, V25.8B
    AND  V9.16B, V29.16B, V25.16B
    SQSUB  B27, B13, B20
    SRHADD  V24.8H, V28.8H, V30.8H
    SRHADD  V1.2S, V25.2S, V8.2S
    UHSUB  V20.4S, V18.4S, V14.4S
    UQADD  D22, D30, D4
    URSHL  V30.2S, V6.2S, V17.2S
    SQADD  S21, S26, S27
    SHSUB  V27.4S, V27.4S, V20.4S
    SMIN  V17.8B, V2.8B, V31.8B
    EOR  V29.16B, V15.16B, V24.16B
    FRECPE  D13, D28
    FMULX  D11, D13, D11
    URSHL  V19.2D, V23.2D, V13.2D
    FMLA  V6.2S, V17.2S, V3.2S
    UQSUB  V31.8B, V12.8B, V27.8B
    SSHL  V2.4H, V12.4H, V5.4H
    UQADD  H25, H4, H25
    SABD  V4.8H, V15.8H, V4.8H
    FMLA  V14.2S, V1.2S, V20.2S
    FDIV  V0.2S, V24.2S, V16.2S
    UQRSHL  V0.8B, V8.8B, V6.8B
    FMULX  V8.4S, V26.4S, V3.4S
    SABD  V7.2S, V1.2S, V4.2S
    MUL  V6.4S, V25.4S, V14.4S
    FRSQRTS  D16, D6, D26
    SQADD  V23.16B, V28.16B, V2.16B
    FMLA  V9.2D, V13.2D, V9.2D
    SRSHL  D15, D13, D28
    FABD  D5, D19, D7
    SQSHL  S10, S0, S16
    ADD  V24.4S, V24.4S, V0.4S
    SUB  V10.4S, V0.4S, V9.4S
    ADD  D5, D15, D27
    SABDL2  V23.4S, V24.8H, V11.8H
    FMIN  V9.4S, V29.4S, V31.4S
    UQADD  B1, B8, B19
    FMINNM  V10.2D, V9.2D, V0.2D
    SSHL  D23, D29, D20
    SQRSHL  S10, S16, S25
    SQADD  H2, H8, H29
    EOR  V15.8B, V22.8B, V31.8B
    FMINNM  V5.2S, V13.2S, V13.2S
    USHL  D12, D1, D14
    FRSQRTS  V24.2D, V4.2D, V12.2D
    BIC  V24.8B, V2.8B, V23.8B
    SQRSHL  S18, S15, S9
    BIF  V11.8B, V20.8B, V16.8B
    FMAX  V19.2D, V4.2D, V29.2D
    SQSUB  S15, S10, S19
    UQSUB  H19, H15, H27
    SQSHL  B10, B15, B5
    SRHADD  V20.8B, V16.8B, V23.8B
    SQSHL  S1, S10, S15
    UQADD  B8, B10, B4
    SQRSHL  S11, S10, S29
    SRHADD  V23.8B, V14.8B, V16.8B
    USHL  V1.8B, V26.8B, V23.8B
    USHL  D12, D19, D1
    FMULX  D9, D12, D0
    UHSUB  V20.2S, V27.2S, V3.2S
    SRSHL  D2, D4, D11
    UQADD  B18, B27, B16
    AND  V15.16B, V9.16B, V20.16B
    SQADD  V9.8B, V19.8B, V17.8B
    SQRSHL  S23, S2, S22
    SQSUB  H17, H8, H14
    ORR  V6.16B, V30.16B, V0.16B
    SABD  V31.4S, V4.4S, V7.4S
    SUB  D8, D11, D18
    SABD  V17.2S, V21.2S, V25.2S
    FMINNM  V11.2S, V0.2S, V21.2S
    FMAX  V29.2D, V12.2D, V30.2D
    USHL  D2, D29, D18
    UQRSHL  H16, H4, H18
    FRECPE  V26.2S, V18.2S
    URHADD  V3.16B, V14.16B, V2.16B
    UQADD  H26, H0, H2
    SQSHL  D30, D4, D11
    BIF  V10.16B, V9.16B, V30.16B
    BIF  V26.16B, V18.16B, V30.16B
    SABD  V31.4S, V17.4S, V13.4S
    SHADD  V11.16B, V9.16B, V21.16B
    FRSQRTS  S3, S15, S1
    SRSHL  V5.4H, V6.4H, V22.4H
    SQSHL  H22, H0, H2
    FMAX  V30.4S, V8.4S, V9.4S
    UQSUB  D15, D30, D25
    SRSHL  V26.2S, V13.2S, V15.2S
    SRSHL  V24.2D, V13.2D, V24.2D
    SQRSHL  H25, H8, H13
    SQSHL  B1, B10, B24
    ADD  V31.16B, V16.16B, V25.16B
    SQADD  B14, B8, B3
    FMULX  S16, S18, S26
    UHADD  V28.16B, V2.16B, V23.16B
    FRECPE  V4.2S, V10.2S
    UQADD  D2, D7, D11
    FMULX  D21, D6, D30
    SQSUB  V17.4S, V15.4S, V30.4S
    SQADD  H25, H31, H25
    UQSUB  B14, B8, B18
    UQADD  D23, D15, D4
    SRSHL  D26, D20, D8
    SABDL2  V28.2D, V13.4S, V17.4S
    UQSUB  S7, S3, S11
    EOR  V31.16B, V15.16B, V10.16B
    UHSUB  V31.4S, V6.4S, V12.4S
    FMULX  V14.2S, V10.2S, V24.2S
    UQRSHL  B9, B12, B15
    UQSUB  D23, D20, D12
    FMLS  V9.4S, V29.4S, V8.4S
    FRSQRTS  S9, S16, S25
    FABD  D23, D2, D7
    BIF  V16.16B, V21.16B, V30.16B
    FMINNM  V28.2D, V8.2D, V4.2D
    SABD  V19.2S, V7.2S, V14.2S
    UQADD  D24, D2, D30
    AND  V9.16B, V4.16B, V1.16B
    BIF  V10.8B, V29.8B, V6.8B
    UQRSHL  H10, H31, H2
    FMUL  V28.2S, V14.2S, V3.2S
    ADD  V31.2D, V25.2D, V21.2D
    SUB  D8, D1, D21
    FMULX  V18.4S, V24.4S, V9.4S
    BIC  V4.16B, V27.16B, V24.16B
    SQADD  H20, H28, H30
    FABD  V30.2S, V16.2S, V23.2S
    AND  V16.8B, V11.8B, V12.8B
    USHL  V16.4S, V6.4S, V11.4S
    UQRSHL  B15, B23, B5
    SQADD  V8.4H, V2.4H, V4.4H
    URSHL  D10, D4, D3
    UMIN  V5.4H, V16.4H, V16.4H
    FMAX  V14.4S, V2.4S, V7.4S
    SMIN  V12.4S, V2.4S, V0.4S
    UQADD  H21, H0, H22
    SRHADD  V23.2S, V25.2S, V12.2S
    SQADD  B7, B7, B7
    FMAX  V14.4S, V9.4S, V8.4S
    SRSHL  D15, D8, D20
    FRECPE  D2, D1
    MLS  V8.2S, V24.2S, V4.2S
    SQADD  B23, B9, B11
    UQRSHL  B22, B3, B30
    MLS  V6.4H, V8.4H, V27.4H
    URHADD  V14.4H, V23.4H, V26.4H
    UQRSHL  V23.2D, V23.2D, V6.2D
    SQADD  B7, B12, B21
    SQRSHL  V25.2S, V0.2S, V5.2S
    FADD  V12.4S, V10.4S, V9.4S
    SQADD  B29, B3, B16
    FMLS  V28.2D, V23.2D, V11.2D
    UQRSHL  B0, B2, B30
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_1156
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X13, X15, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X2, X5, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X11, X14, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X7, X3, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X4, X15, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X11, X23, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X3, X15, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X7, X15, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X15, X10, X14
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X15
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X7, X4, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X25, X3, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X28, X15, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X10, X18, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X10, X20, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X24, X3, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X16, X21, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X18, X5, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X15, X6, X26
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X15, X21, X27
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X29, X11, X29
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D2
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff0, LSL #48
    SUB  X26, X18, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D3
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3fc0, LSL #16
    SUB  X19, X23, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X16
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D5
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xf800, LSL #16
    MOVK  X12, #0x1470, LSL #48
    SUB  X26, X12, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D6
    MOVZ  X2, #0xff83, LSL #0
    MOVK  X2, #0x16, LSL #16
    MOVK  X2, #0x8e0, LSL #48
    SUB  X7, X2, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D7
    MOVZ  X6, #0xfe, LSL #0
    SUB  X17, X6, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D8
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X6, X3, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D11
    MOVZ  X20, #0xf513, LSL #0
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X6, X20, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D12
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D13
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x7ff0, LSL #48
    SUB  X20, X23, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D14
    MOVZ  X23, #0xa, LSL #0
    SUB  X19, X23, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D15
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X15, X5, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D16
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xf800, LSL #16
    MOVK  X5, #0x1470, LSL #48
    SUB  X15, X5, X28
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D17
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D18
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X24, X16, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X24, X15, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D19
    MOVZ  X15, #0xaed, LSL #0
    MOVK  X15, #0x3fbf, LSL #16
    MOVK  X15, #0x1, LSL #32
    SUB  X24, X15, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D20
    MOVZ  X23, #0xff7c, LSL #0
    SUB  X2, X23, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D21
    MOVZ  X18, #0xffff, LSL #0
    SUB  X6, X18, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D24
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X11, X14, X23
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D25
    MOVZ  X13, #0xff00, LSL #0
    MOVK  X13, #0x8, LSL #16
    SUB  X12, X13, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D27
    MOVZ  X10, #0x83, LSL #0
    MOVK  X10, #0xe, LSL #16
    MOVK  X10, #0xe000, LSL #48
    SUB  X11, X10, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X17, X10, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D28
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X17, X10, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D29
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x7cc9, LSL #0
    MOVK  X2, #0xa493, LSL #16
    MOVK  X2, #0x7007, LSL #32
    MOVK  X2, #0x3f2e, LSL #48
    MOVZ  X3, #0x7b1a, LSL #0
    MOVK  X3, #0x639f, LSL #16
    MOVK  X3, #0xaea5, LSL #32
    MOVK  X3, #0x1d3c, LSL #48
    MOVZ  X4, #0x7c5c, LSL #0
    MOVK  X4, #0x300d, LSL #16
    MOVK  X4, #0x7347, LSL #32
    MOVK  X4, #0x6a5a, LSL #48
    MOVZ  X5, #0x6f08, LSL #0
    MOVK  X5, #0x1029, LSL #16
    MOVK  X5, #0xeba6, LSL #32
    MOVK  X5, #0x14b9, LSL #48
    MOVZ  X6, #0xbe5b, LSL #0
    MOVK  X6, #0xa059, LSL #16
    MOVK  X6, #0xc012, LSL #32
    MOVK  X6, #0x30d0, LSL #48
    MOVZ  X7, #0xa806, LSL #0
    MOVK  X7, #0x4088, LSL #16
    MOVK  X7, #0x54bb, LSL #32
    MOVK  X7, #0x456c, LSL #48
    MOVZ  X8, #0xcf0b, LSL #0
    MOVK  X8, #0x69bc, LSL #16
    MOVK  X8, #0x4b1, LSL #32
    MOVK  X8, #0xed06, LSL #48
    MOVZ  X10, #0x46c9, LSL #0
    MOVK  X10, #0x613e, LSL #16
    MOVK  X10, #0x4974, LSL #32
    MOVK  X10, #0xbb6f, LSL #48
    MOVZ  X11, #0xfe0d, LSL #0
    MOVK  X11, #0x993f, LSL #16
    MOVK  X11, #0xa33a, LSL #32
    MOVK  X11, #0x3659, LSL #48
    MOVZ  X12, #0xa792, LSL #0
    MOVK  X12, #0x82c1, LSL #16
    MOVK  X12, #0xb42d, LSL #32
    MOVK  X12, #0xc69e, LSL #48
    MOVZ  X13, #0x9b5c, LSL #0
    MOVK  X13, #0xabb2, LSL #16
    MOVK  X13, #0x918e, LSL #32
    MOVK  X13, #0xa4a1, LSL #48
    MOVZ  X14, #0x2054, LSL #0
    MOVK  X14, #0x20f7, LSL #16
    MOVK  X14, #0xb6f9, LSL #32
    MOVK  X14, #0x7080, LSL #48
    MOVZ  X15, #0xfa10, LSL #0
    MOVK  X15, #0x98be, LSL #16
    MOVK  X15, #0x2f22, LSL #32
    MOVK  X15, #0x48ac, LSL #48
    MOVZ  X16, #0x46, LSL #0
    MOVK  X16, #0x718f, LSL #16
    MOVK  X16, #0xbbf1, LSL #32
    MOVK  X16, #0x7d3e, LSL #48
    MOVZ  X17, #0x463e, LSL #0
    MOVK  X17, #0x1146, LSL #16
    MOVK  X17, #0xae17, LSL #32
    MOVK  X17, #0xb402, LSL #48
    MOVZ  X18, #0xc834, LSL #0
    MOVK  X18, #0x69c2, LSL #16
    MOVK  X18, #0x2160, LSL #32
    MOVK  X18, #0xe29b, LSL #48
    MOVZ  X19, #0x371f, LSL #0
    MOVK  X19, #0x9d6a, LSL #16
    MOVK  X19, #0x2372, LSL #32
    MOVK  X19, #0x9a4b, LSL #48
    MOVZ  X20, #0x8533, LSL #0
    MOVK  X20, #0xe6c1, LSL #16
    MOVK  X20, #0x5f8d, LSL #32
    MOVK  X20, #0x7805, LSL #48
    MOVZ  X21, #0x2631, LSL #0
    MOVK  X21, #0xa97b, LSL #16
    MOVK  X21, #0x45f2, LSL #32
    MOVK  X21, #0xaa1b, LSL #48
    MOVZ  X22, #0xe65, LSL #0
    MOVK  X22, #0x8863, LSL #16
    MOVK  X22, #0xb015, LSL #32
    MOVK  X22, #0xe496, LSL #48
    MOVZ  X23, #0xb060, LSL #0
    MOVK  X23, #0xf75b, LSL #16
    MOVK  X23, #0x4fbe, LSL #32
    MOVK  X23, #0xa22c, LSL #48
    MOVZ  X24, #0x5e7a, LSL #0
    MOVK  X24, #0x7f48, LSL #16
    MOVK  X24, #0x526, LSL #32
    MOVK  X24, #0x10bf, LSL #48
    MOVZ  X25, #0xc9a4, LSL #0
    MOVK  X25, #0x5b46, LSL #16
    MOVK  X25, #0xf44, LSL #32
    MOVK  X25, #0x81ce, LSL #48
    MOVZ  X26, #0xdd4a, LSL #0
    MOVK  X26, #0xedb1, LSL #16
    MOVK  X26, #0x51dc, LSL #32
    MOVK  X26, #0xf50c, LSL #48
    MOVZ  X27, #0x13c5, LSL #0
    MOVK  X27, #0x1dbb, LSL #16
    MOVK  X27, #0x8514, LSL #32
    MOVK  X27, #0x91fd, LSL #48
    MOVZ  X28, #0x8801, LSL #0
    MOVK  X28, #0x41f3, LSL #16
    MOVK  X28, #0x6752, LSL #32
    MOVK  X28, #0xb67, LSL #48
    MOVZ  X29, #0xed8c, LSL #0
    MOVK  X29, #0x1a66, LSL #16
    MOVK  X29, #0x5193, LSL #32
    MOVK  X29, #0x9cc, LSL #48
    FMOV  D0, X15
    FMOV  V0.D[1], X14
    FMOV  D1, X18
    FMOV  V1.D[1], X17
    FMOV  D2, X19
    FMOV  V2.D[1], X6
    FMOV  D3, X27
    FMOV  V3.D[1], X2
    FMOV  D4, X27
    FMOV  V4.D[1], X24
    FMOV  D5, X28
    FMOV  V5.D[1], X6
    FMOV  D6, X11
    FMOV  V6.D[1], X29
    FMOV  D7, X3
    FMOV  V7.D[1], X12
    FMOV  D8, X11
    FMOV  V8.D[1], X16
    FMOV  D9, X12
    FMOV  V9.D[1], X4
    FMOV  D10, X28
    FMOV  V10.D[1], X5
    FMOV  D11, X28
    FMOV  V11.D[1], X28
    FMOV  D12, X28
    FMOV  V12.D[1], X27
    FMOV  D13, X15
    FMOV  V13.D[1], X22
    FMOV  D14, X28
    FMOV  V14.D[1], X27
    FMOV  D15, X4
    FMOV  V15.D[1], X27
    FMOV  D16, X5
    FMOV  V16.D[1], X21
    FMOV  D17, X10
    FMOV  V17.D[1], X25
    FMOV  D18, X28
    FMOV  V18.D[1], X26
    FMOV  D19, X21
    FMOV  V19.D[1], X3
    FMOV  D20, X15
    FMOV  V20.D[1], X28
    FMOV  D21, X14
    FMOV  V21.D[1], X16
    FMOV  D22, X27
    FMOV  V22.D[1], X12
    FMOV  D23, X20
    FMOV  V23.D[1], X2
    FMOV  D24, X12
    FMOV  V24.D[1], X2
    FMOV  D25, X24
    FMOV  V25.D[1], X14
    FMOV  D26, X19
    FMOV  V26.D[1], X22
    FMOV  D27, X10
    FMOV  V27.D[1], X4
    FMOV  D28, X22
    FMOV  V28.D[1], X6
    FMOV  D29, X20
    FMOV  V29.D[1], X20
    FMOV  D30, X25
    FMOV  V30.D[1], X29
    FMOV  D31, X4
    FMOV  V31.D[1], X22
    MOVZ  X11, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_1239:
    UQSUB  V27.4S, V20.4S, V30.4S
    AND  V29.16B, V0.16B, V23.16B
    SABDL  V29.2D, V25.2S, V21.2S
    USHL  D9, D19, D26
    UQADD  H22, H11, H11
    UQADD  V10.4H, V31.4H, V27.4H
    UHADD  V24.8H, V24.8H, V31.8H
    SQSHL  D26, D19, D2
    UQSUB  B24, B9, B29
    UABA  V8.2S, V28.2S, V9.2S
    SQSUB  S11, S8, S6
    SQADD  B11, B10, B4
    UQRSHL  S17, S20, S31
    SQADD  S30, S19, S1
    FMULX  S10, S18, S19
    FRSQRTS  S24, S21, S17
    MOV  V14.8B, V24.8B
    SQSHL  B19, B14, B22
    FMLS  V26.4S, V18.4S, V28.4S
    ADD  D2, D2, D28
TaishanSimdPairArithmeticP01_label_1172:
    FMIN  V9.4S, V8.4S, V7.4S
    ORN  V30.16B, V29.16B, V8.16B
    FMULX  V26.4S, V11.4S, V4.4S
    SSHL  D4, D10, D1
    URSHL  D20, D19, D7
    FMLA  V20.4S, V4.4S, V10.4S
    FRECPE  V30.4S, V12.4S
    UABA  V13.8H, V22.8H, V20.8H
    AND  V26.16B, V25.16B, V5.16B
    SQADD  B8, B15, B11
    SUB  V8.2D, V17.2D, V29.2D
    MLS  V30.8B, V6.8B, V2.8B
    MOV  V9.16B, V15.16B
    MOV  V28.8B, V21.8B
    FMIN  V24.2S, V17.2S, V26.2S
    ORR  V13.8B, V23.8B, V14.8B
    FMAX  V11.2D, V30.2D, V13.2D
    FRSQRTS  D13, D28, D10
    ORR  V9.16B, V28.16B, V29.16B
    FRSQRTS  S1, S7, S15
    BIF  V25.16B, V1.16B, V1.16B
    SMAX  V19.2S, V21.2S, V31.2S
    BIC  V23.8B, V1.8B, V31.8B
    UQRSHL  B2, B29, B12
    SMAX  V7.4S, V8.4S, V13.4S
    FRECPE  D17, D25
    UQSUB  V3.16B, V17.16B, V23.16B
    SABDL2  V12.2D, V23.4S, V13.4S
    FRECPE  V6.4S, V7.4S
    FMLS  V7.4S, V14.4S, V2.4S
    SQRSHL  B3, B4, B12
    SSHL  V12.8B, V3.8B, V9.8B
    FMULX  D6, D30, D14
    URHADD  V15.8B, V7.8B, V8.8B
    SRHADD  V8.2S, V17.2S, V7.2S
    FADD  V16.2S, V26.2S, V6.2S
    UQRSHL  V23.4H, V0.4H, V12.4H
    ORR  V3.16B, V15.16B, V8.16B
    BIF  V19.8B, V26.8B, V1.8B
    MLA  V1.4H, V27.4H, V27.4H
    SUB  V9.8B, V31.8B, V31.8B
    FABD  V1.4S, V9.4S, V29.4S
    SQADD  H14, H16, H6
    USHL  D19, D6, D31
    UQSUB  B31, B27, B20
    FABD  S8, S18, S17
    UMAX  V12.16B, V15.16B, V19.16B
    SQSUB  D21, D19, D3
    UQADD  D19, D6, D27
    SQSUB  V14.8B, V15.8B, V24.8B
    FMULX  S2, S27, S15
    FRSQRTS  V19.2S, V5.2S, V25.2S
    FDIV  V9.4S, V19.4S, V25.4S
    BIC  V18.8B, V3.8B, V1.8B
    FDIV  V11.2S, V16.2S, V15.2S
    UQSUB  H1, H15, H21
    SRHADD  V29.16B, V26.16B, V23.16B
    SRHADD  V14.4H, V31.4H, V16.4H
    SQADD  H22, H14, H3
    SSHL  V29.4H, V14.4H, V15.4H
    SUB  V22.4S, V30.4S, V12.4S
    SRHADD  V3.8H, V18.8H, V18.8H
    BSL  V26.16B, V0.16B, V20.16B
    MUL  V17.16B, V5.16B, V4.16B
    UQRSHL  D31, D29, D3
    SABDL  V29.4S, V22.4H, V20.4H
    UQADD  S26, S2, S26
    UQSUB  V9.4H, V6.4H, V9.4H
    SSHL  D24, D11, D18
    FMULX  V26.2D, V31.2D, V6.2D
    UQSUB  B27, B14, B30
    SRHADD  V1.8B, V25.8B, V12.8B
    UMAX  V16.16B, V0.16B, V26.16B
    ADD  V5.8B, V17.8B, V20.8B
    BIT  V15.8B, V31.8B, V20.8B
    FMULX  D12, D5, D0
    SQSUB  S4, S3, S24
    UQSUB  H9, H21, H27
    UQADD  S23, S19, S9
    MUL  V9.2S, V26.2S, V13.2S
    UQADD  S15, S8, S13
    SQRSHL  B15, B8, B2
    FMULX  S6, S4, S2
    SSHL  D24, D11, D16
    FABD  S31, S11, S19
    SABDL2  V31.4S, V29.8H, V14.8H
    UQSUB  H7, H7, H21
    UQSUB  V22.16B, V9.16B, V18.16B
    FMIN  V14.4S, V9.4S, V4.4S
    UQRSHL  S2, S8, S1
    SABDL  V25.2D, V29.2S, V20.2S
    UQRSHL  H28, H17, H16
    SQSUB  S4, S25, S21
    ADD  V21.8B, V16.8B, V23.8B
    FABD  V2.2D, V23.2D, V12.2D
    SRSHL  D30, D5, D8
    FDIV  V28.2S, V25.2S, V19.2S
    UQSUB  S11, S2, S10
    FMULX  D17, D21, D3
    SQSUB  D14, D19, D10
    USHL  V26.16B, V13.16B, V22.16B
    FMLS  V19.2D, V17.2D, V20.2D
    FMINNM  V15.2S, V17.2S, V7.2S
    FABD  D10, D7, D23
    FMAXNM  V29.2S, V24.2S, V15.2S
    FDIV  V24.4S, V5.4S, V30.4S
    SQSHL  D27, D12, D30
    FMULX  D6, D15, D2
    UQADD  V11.4H, V14.4H, V21.4H
    SMIN  V27.4S, V24.4S, V12.4S
    SQRSHL  S31, S11, S2
    SQRSHL  S5, S21, S5
    FRECPE  V7.2S, V15.2S
    SQRSHL  V25.8B, V24.8B, V6.8B
    FMULX  V5.2D, V21.2D, V22.2D
    UQADD  D12, D6, D1
    SQSHL  S6, S4, S2
    URSHL  V29.8B, V26.8B, V1.8B
    SHADD  V11.16B, V19.16B, V6.16B
    FRSQRTS  S27, S15, S6
    UMIN  V5.4S, V19.4S, V6.4S
    FMUL  V8.2S, V22.2S, V2.2S
    SABD  V8.8B, V14.8B, V26.8B
    SSHL  V20.2S, V17.2S, V23.2S
    FMIN  V31.2D, V23.2D, V14.2D
    UQRSHL  S25, S15, S23
    SRHADD  V24.16B, V24.16B, V19.16B
    SQRSHL  V8.16B, V22.16B, V22.16B
    SQRSHL  S1, S12, S11
    FRECPE  S5, S5
    SQRSHL  B3, B2, B29
    UQSUB  S8, S6, S11
    BIF  V15.8B, V3.8B, V25.8B
TaishanSimdPairArithmeticP01_label_421:
    SQSHL  H7, H2, H21
    SQSUB  H22, H6, H10
    SQRSHL  V20.2S, V4.2S, V31.2S
    SSHL  D16, D9, D11
    FMLA  V15.2D, V3.2D, V18.2D
    UQRSHL  D29, D8, D3
    ADD  V29.8B, V31.8B, V7.8B
    FMIN  V14.2S, V23.2S, V27.2S
    FRSQRTS  V26.2S, V20.2S, V14.2S
    SQRSHL  S26, S20, S1
    FRECPE  V29.2S, V19.2S
    SQADD  H29, H26, H20
    UQRSHL  S21, S20, S30
    ADD  D0, D31, D28
    UQSUB  D17, D4, D23
    BIF  V10.16B, V2.16B, V30.16B
    MLS  V11.2S, V2.2S, V12.2S
    FMINNM  V6.2S, V19.2S, V9.2S
    SQRSHL  V9.16B, V21.16B, V0.16B
    USHL  D1, D6, D9
    UHSUB  V2.2S, V9.2S, V14.2S
    UQRSHL  D29, D20, D31
    SQRSHL  D24, D10, D2
    BSL  V21.16B, V14.16B, V14.16B
    SSHL  V17.2D, V28.2D, V27.2D
    UQADD  V27.8B, V11.8B, V28.8B
    FABD  D27, D20, D9
    URHADD  V2.2S, V8.2S, V0.2S
    FMAX  V26.2D, V6.2D, V2.2D
    BIT  V10.8B, V14.8B, V1.8B
    SHSUB  V31.8H, V27.8H, V9.8H
    SQSHL  D31, D31, D31
    FMAX  V21.2D, V5.2D, V6.2D
    SABDL  V31.2D, V30.2S, V19.2S
    FMULX  D15, D1, D18
    MLS  V17.16B, V26.16B, V18.16B
    BIC  V24.8B, V26.8B, V10.8B
    AND  V26.16B, V29.16B, V29.16B
    FRSQRTS  S15, S26, S5
    SQRSHL  B24, B5, B4
    SQSUB  D2, D28, D0
    FMAXNM  V0.4S, V18.4S, V21.4S
    SQRSHL  D23, D5, D18
    USHL  D31, D8, D26
    SMAX  V15.8B, V29.8B, V21.8B
    FMINNM  V16.2S, V18.2S, V3.2S
    FMINNM  V29.4S, V17.4S, V5.4S
    SUBS  X11, X11, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_1239
    MOVZ  X22, #0x7cc9, LSL #0
    MOVK  X22, #0xa493, LSL #16
    MOVK  X22, #0x7007, LSL #32
    MOVK  X22, #0x3f2e, LSL #48
    SUB  X2, X22, X2
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x7b1a, LSL #0
    MOVK  X28, #0x639f, LSL #16
    MOVK  X28, #0xaea5, LSL #32
    MOVK  X28, #0x1d3c, LSL #48
    SUB  X5, X28, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x7c5c, LSL #0
    MOVK  X10, #0x300d, LSL #16
    MOVK  X10, #0x7347, LSL #32
    MOVK  X10, #0x6a5a, LSL #48
    SUB  X4, X10, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0xbe5b, LSL #0
    MOVK  X5, #0xa059, LSL #16
    MOVK  X5, #0xc012, LSL #32
    MOVK  X5, #0x30d0, LSL #48
    SUB  X2, X5, X6
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0xa806, LSL #0
    MOVK  X11, #0x4088, LSL #16
    MOVK  X11, #0x54bb, LSL #32
    MOVK  X11, #0x456c, LSL #48
    SUB  X16, X11, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0xcf0b, LSL #0
    MOVK  X24, #0x69bc, LSL #16
    MOVK  X24, #0x4b1, LSL #32
    MOVK  X24, #0xed06, LSL #48
    SUB  X15, X24, X8
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x7c5c, LSL #0
    MOVK  X28, #0x300d, LSL #16
    MOVK  X28, #0x7347, LSL #32
    MOVK  X28, #0x6a5a, LSL #48
    SUB  X20, X28, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0xa806, LSL #0
    MOVK  X25, #0x4088, LSL #16
    MOVK  X25, #0x54bb, LSL #32
    MOVK  X25, #0x456c, LSL #48
    SUB  X20, X25, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x9b5c, LSL #0
    MOVK  X5, #0xabb2, LSL #16
    MOVK  X5, #0x918e, LSL #32
    MOVK  X5, #0xa4a1, LSL #48
    SUB  X23, X5, X13
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x2054, LSL #0
    MOVK  X14, #0x20f7, LSL #16
    MOVK  X14, #0xb6f9, LSL #32
    MOVK  X14, #0x7080, LSL #48
    SUB  X29, X14, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X15
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x463e, LSL #0
    MOVK  X26, #0x1146, LSL #16
    MOVK  X26, #0xae17, LSL #32
    MOVK  X26, #0xb402, LSL #48
    SUB  X16, X26, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0xc834, LSL #0
    MOVK  X7, #0x69c2, LSL #16
    MOVK  X7, #0x2160, LSL #32
    MOVK  X7, #0xe29b, LSL #48
    SUB  X26, X7, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x371f, LSL #0
    MOVK  X17, #0x9d6a, LSL #16
    MOVK  X17, #0x2372, LSL #32
    MOVK  X17, #0x9a4b, LSL #48
    SUB  X25, X17, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x2631, LSL #0
    MOVK  X21, #0xa97b, LSL #16
    MOVK  X21, #0x45f2, LSL #32
    MOVK  X21, #0xaa1b, LSL #48
    SUB  X15, X21, X21
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x13c5, LSL #0
    MOVK  X2, #0x1dbb, LSL #16
    MOVK  X2, #0x8514, LSL #32
    MOVK  X2, #0x91fd, LSL #48
    SUB  X6, X2, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x7c5c, LSL #0
    MOVK  X6, #0x300d, LSL #16
    MOVK  X6, #0x7347, LSL #32
    MOVK  X6, #0x6a5a, LSL #48
    SUB  X29, X6, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D2
    MOVZ  X4, #0x3fef, LSL #0
    MOVK  X4, #0xc03f, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X17, X4, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D3
    MOVZ  X19, #0x11, LSL #0
    SUB  X10, X19, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X15, X18, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D4
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0x7fff, LSL #16
    SUB  X15, X18, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D5
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0x7fff, LSL #16
    SUB  X12, X4, X15
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D6
    MOVZ  X25, #0x3e83, LSL #0
    MOVK  X25, #0x80e4, LSL #16
    SUB  X23, X25, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D7
    MOVZ  X24, #0xffff, LSL #0
    SUB  X20, X24, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X23, X26, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D10
    MOVZ  X8, #0xc011, LSL #0
    MOVK  X8, #0x3fc0, LSL #16
    SUB  X7, X8, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X10, X28, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D11
    MOVZ  X28, #0x3ec1, LSL #0
    MOVK  X28, #0x3737, LSL #16
    MOVK  X28, #0xfffe, LSL #48
    SUB  X10, X28, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D12
    MOVZ  X4, #0xe000, LSL #0
    MOVK  X4, #0xd0fb, LSL #16
    MOVK  X4, #0x173e, LSL #48
    SUB  X11, X4, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
TaishanSimdPairArithmeticP01_label_467:
    FMOV  X2, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X22, X15, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D13
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3ff8, LSL #48
    SUB  X22, X15, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D14
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0x7fff, LSL #16
    SUB  X8, X22, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D15
    MOVZ  X28, #0x3e00, LSL #0
    MOVK  X28, #0xfffe, LSL #16
    SUB  X6, X28, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D16
    MOVZ  X18, #0x3e83, LSL #0
    MOVK  X18, #0x80e4, LSL #16
    SUB  X17, X18, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D17
    MOVZ  X16, #0xe112, LSL #0
    MOVK  X16, #0x2044, LSL #16
    SUB  X10, X16, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D18
    MOVZ  X21, #0x3e83, LSL #0
    MOVK  X21, #0x80e4, LSL #16
    MOVK  X21, #0x7ffc, LSL #48
    SUB  X12, X21, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D19
    MOVZ  X12, #0x3e83, LSL #0
    MOVK  X12, #0x80e4, LSL #16
    MOVK  X12, #0xfffc, LSL #48
    SUB  X28, X12, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D20
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0x7fff, LSL #16
    SUB  X12, X8, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D21
    MOVZ  X16, #0x3e83, LSL #0
    MOVK  X16, #0x80e4, LSL #16
    SUB  X20, X16, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D22
    MOVZ  X23, #0x7fb1, LSL #0
    SUB  X28, X23, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D25
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
TaishanSimdPairArithmeticP01_label_1311:
    SUB  X13, X3, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D26
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xfffe, LSL #16
    MOVK  X16, #0xffff, LSL #32
    SUB  X4, X16, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D27
    MOVZ  X12, #0xff7f, LSL #0
    MOVK  X12, #0x7f7f, LSL #16
    SUB  X13, X12, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D28
    MOVZ  X19, #0xca36, LSL #0
    MOVK  X19, #0x40a9, LSL #16
    SUB  X6, X19, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X2, X15, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D29
    MOVZ  X15, #0xe112, LSL #0
    MOVK  X15, #0x2044, LSL #16
    SUB  X2, X15, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  V0.D[1], X2
    FMOV  D1, X12
    FMOV  V1.D[1], X27
    FMOV  D2, X7
    FMOV  V2.D[1], X14
    FMOV  D3, X18
    FMOV  V3.D[1], X6
    FMOV  D4, X12
    FMOV  V4.D[1], X7
    FMOV  D5, X11
    FMOV  V5.D[1], X28
    FMOV  D6, X24
    FMOV  V6.D[1], X23
    FMOV  D7, X25
    FMOV  V7.D[1], X10
    FMOV  D8, X13
    FMOV  V8.D[1], X20
    FMOV  D9, X28
    FMOV  V9.D[1], X6
    FMOV  D10, X2
    FMOV  V10.D[1], X15
    FMOV  D11, X5
    FMOV  V11.D[1], X13
    FMOV  D12, X7
    FMOV  V12.D[1], X5
    FMOV  D13, X5
    FMOV  V13.D[1], X19
    FMOV  D14, X5
    FMOV  V14.D[1], X14
    FMOV  D15, X6
    FMOV  V15.D[1], X2
    FMOV  D16, X21
    FMOV  V16.D[1], X21
    FMOV  D17, X13
    FMOV  V17.D[1], X7
    FMOV  D18, X15
    FMOV  V18.D[1], X23
    FMOV  D19, X13
    FMOV  V19.D[1], X16
    FMOV  D20, X7
    FMOV  V20.D[1], X18
    FMOV  D21, X4
    FMOV  V21.D[1], X12
    FMOV  D22, X18
    FMOV  V22.D[1], X21
    FMOV  D23, X21
    FMOV  V23.D[1], X18
    FMOV  D24, X15
    FMOV  V24.D[1], X24
    FMOV  D25, X26
    FMOV  V25.D[1], X15
    FMOV  D26, X2
    FMOV  V26.D[1], X23
    FMOV  D27, X27
    FMOV  V27.D[1], X27
    FMOV  D28, X4
    FMOV  V28.D[1], X15
    FMOV  D29, X29
    FMOV  V29.D[1], X20
    FMOV  D30, X14
    FMOV  V30.D[1], X20
    FMOV  D31, X20
    FMOV  V31.D[1], X21
    MOVZ  X14, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_1321:
    FABD  S7, S15, S0
    SSHL  D28, D29, D5
    SQSHL  D13, D30, D31
    FRECPE  S25, S4
    SMAX  V14.4S, V12.4S, V19.4S
    SRHADD  V24.4H, V29.4H, V15.4H
    SQSUB  D18, D26, D7
    FMULX  D2, D5, D16
    FMIN  V11.2D, V14.2D, V21.2D
    URSHL  V21.2D, V15.2D, V0.2D
    SABDL2  V28.2D, V27.4S, V20.4S
    MLA  V10.8H, V12.8H, V23.8H
    FABD  D22, D7, D4
    SQSUB  V18.4S, V22.4S, V17.4S
    UQRSHL  S15, S6, S9
    FSUB  V25.2D, V20.2D, V15.2D
    MLS  V28.8H, V31.8H, V14.8H
    FMLS  V13.2D, V17.2D, V16.2D
    SQSHL  H14, H15, H9
    UQADD  B29, B30, B5
    SQADD  D19, D30, D31
    SMAX  V17.8H, V5.8H, V20.8H
    SQSUB  S9, S2, S15
    URHADD  V15.16B, V19.16B, V31.16B
    SQSHL  B19, B3, B24
    UQSUB  B23, B29, B29
    FMLS  V13.2S, V26.2S, V28.2S
    SUB  V4.4S, V19.4S, V29.4S
    ORN  V0.8B, V3.8B, V10.8B
    UQSUB  B25, B17, B3
    UQSUB  V15.2S, V6.2S, V13.2S
    SQADD  D6, D20, D9
    FRSQRTS  S25, S17, S15
    UQSUB  V3.4H, V9.4H, V25.4H
    SQSUB  D29, D23, D10
    UQSUB  B14, B7, B29
    SQADD  D23, D27, D22
    FMAX  V26.2S, V6.2S, V6.2S
    UMAX  V20.8B, V11.8B, V10.8B
    FRECPE  S23, S5
    BSL  V14.16B, V0.16B, V4.16B
    SQSHL  D25, D30, D26
    SQRSHL  H1, H20, H11
    USHL  D1, D1, D9
    FRSQRTS  D31, D8, D7
    FRSQRTS  S1, S6, S16
    SQSUB  S14, S10, S24
    SQADD  B10, B15, B25
    AND  V19.8B, V24.8B, V6.8B
    FMLS  V1.4S, V8.4S, V5.4S
    FABD  V9.2D, V13.2D, V3.2D
    FRSQRTS  V6.2D, V6.2D, V15.2D
    URHADD  V20.8H, V6.8H, V3.8H
    SQSUB  D16, D31, D22
    UQADD  B5, B6, B19
    URHADD  V25.8B, V18.8B, V29.8B
    UMAX  V9.8H, V30.8H, V7.8H
    SHSUB  V23.8B, V1.8B, V16.8B
    URSHL  V20.4S, V28.4S, V25.4S
    SQSUB  H3, H21, H6
    AND  V18.16B, V20.16B, V17.16B
    UABA  V10.4H, V22.4H, V14.4H
    UMAX  V16.8B, V1.8B, V5.8B
    SQRSHL  H5, H30, H5
    UQADD  D16, D2, D28
    SQADD  S31, S9, S18
    SHADD  V11.16B, V24.16B, V14.16B
    UQADD  S3, S2, S10
    SQSHL  H15, H28, H30
    FMLA  V24.4S, V6.4S, V4.4S
    SRHADD  V10.8B, V6.8B, V0.8B
    ORR  V19.8B, V1.8B, V4.8B
    URSHL  V1.4S, V18.4S, V13.4S
    UABA  V3.8H, V0.8H, V9.8H
    FMLA  V11.4S, V5.4S, V11.4S
    ORN  V30.8B, V3.8B, V6.8B
    MLA  V20.8B, V23.8B, V25.8B
    FRECPE  D0, D16
    UMAX  V12.8H, V14.8H, V4.8H
    UQRSHL  V25.4S, V8.4S, V5.4S
    UQRSHL  H23, H22, H3
    SABDL  V23.2D, V31.2S, V14.2S
    AND  V13.16B, V9.16B, V24.16B
    MUL  V31.2S, V0.2S, V16.2S
    SQSUB  B10, B11, B24
    SQSUB  H15, H9, H20
    SQSUB  V1.2D, V18.2D, V9.2D
    AND  V19.8B, V28.8B, V22.8B
    FRECPE  V19.2D, V5.2D
    SUB  V10.16B, V26.16B, V3.16B
    URSHL  D24, D6, D4
    USHL  V29.4S, V6.4S, V10.4S
    URSHL  V5.4H, V9.4H, V21.4H
    SHADD  V31.16B, V6.16B, V13.16B
    FMIN  V29.2D, V5.2D, V25.2D
    ORR  V9.8B, V28.8B, V3.8B
    SQRSHL  V5.4H, V5.4H, V12.4H
    UQSUB  D13, D5, D24
    FMAX  V16.2S, V3.2S, V1.2S
    FRSQRTS  V15.4S, V0.4S, V13.4S
    SQRSHL  D15, D26, D1
    UMIN  V22.4S, V11.4S, V30.4S
    SABDL2  V19.2D, V18.4S, V7.4S
    SUB  D23, D26, D30
    FABD  D29, D19, D30
    MLS  V6.4H, V11.4H, V12.4H
    UQSUB  B17, B26, B13
    USHL  D22, D16, D30
    FMULX  D12, D29, D29
    USHL  V15.8B, V6.8B, V28.8B
    UQRSHL  H31, H5, H10
    ADD  V18.2S, V29.2S, V22.2S
    FMLS  V15.2S, V20.2S, V17.2S
    USHL  V16.4H, V16.4H, V2.4H
    SQSHL  D17, D31, D4
    USHL  V14.2D, V30.2D, V1.2D
    UQSUB  B30, B21, B12
    SQRSHL  H2, H29, H11
    FMULX  V27.2D, V12.2D, V4.2D
    ORR  V24.8B, V11.8B, V16.8B
    UQADD  S21, S17, S29
    SQSUB  B12, B23, B13
    UQRSHL  S2, S13, S1
    FRECPE  S29, S17
    AND  V14.8B, V9.8B, V13.8B
    SRSHL  D21, D17, D7
    SQSHL  H27, H15, H31
    FABD  D3, D14, D30
    UQSUB  S30, S10, S20
    SQRSHL  V23.4S, V21.4S, V26.4S
    UHADD  V16.4H, V6.4H, V22.4H
    FRECPE  D12, D22
    FRECPE  S1, S27
    MOV  V19.8B, V26.8B
    FMULX  D11, D5, D29
    FMLA  V4.4S, V2.4S, V23.4S
    UQSUB  H6, H1, H18
    SQADD  B28, B15, B29
    BIF  V20.16B, V0.16B, V5.16B
    UQADD  H23, H13, H2
    UMAX  V11.4S, V14.4S, V1.4S
    SRSHL  D11, D14, D31
    SQADD  D0, D15, D31
    FMULX  D12, D12, D0
    SQSUB  S13, S31, S16
    SMIN  V8.4H, V30.4H, V27.4H
    SQSHL  D12, D0, D7
    ADD  V19.2S, V29.2S, V22.2S
    UQRSHL  D26, D27, D8
    SRSHL  D0, D6, D22
    SUB  D11, D1, D3
    FMAXNM  V17.2D, V23.2D, V4.2D
    SHSUB  V27.4H, V8.4H, V19.4H
    SABD  V11.4S, V12.4S, V25.4S
    MOV  V29.16B, V26.16B
    SQSHL  S12, S16, S28
    UQADD  H20, H15, H27
    UQRSHL  V5.2D, V7.2D, V13.2D
    UQADD  S28, S21, S5
    SRSHL  D24, D20, D23
    BIT  V28.16B, V25.16B, V13.16B
    SRHADD  V12.8H, V17.8H, V26.8H
    BIT  V0.8B, V6.8B, V13.8B
    SSHL  V5.8H, V9.8H, V0.8H
    SQADD  V14.4H, V6.4H, V13.4H
    UQRSHL  H22, H17, H25
    MUL  V6.2S, V31.2S, V17.2S
    SSHL  V16.8B, V17.8B, V26.8B
    UQSUB  S0, S0, S25
    FMINNM  V17.2S, V8.2S, V29.2S
    SQSUB  B19, B7, B20
    UQSUB  D3, D25, D8
    EOR  V2.16B, V10.16B, V31.16B
    FMULX  V6.2S, V18.2S, V22.2S
    FMLS  V26.4S, V1.4S, V9.4S
    FRECPE  V5.4S, V8.4S
    SQADD  H16, H22, H8
    SHADD  V21.4H, V14.4H, V19.4H
    UHADD  V15.8H, V27.8H, V13.8H
    UQSUB  H17, H18, H9
    SQADD  H7, H22, H29
    UQADD  H8, H4, H21
    SABD  V30.16B, V17.16B, V9.16B
    SQSHL  H2, H19, H29
    SQADD  B16, B15, B25
    UQSUB  V1.8H, V23.8H, V14.8H
    SQSHL  B18, B24, B5
    FSUB  V8.4S, V4.4S, V25.4S
    URSHL  V0.2D, V26.2D, V10.2D
    BSL  V7.8B, V29.8B, V19.8B
    SQADD  S6, S21, S15
    UHSUB  V20.4S, V30.4S, V14.4S
    SQADD  V25.2D, V23.2D, V27.2D
    FRSQRTS  S26, S18, S4
    UQSUB  D4, D3, D6
    FMULX  V25.2D, V16.2D, V31.2D
    SQRSHL  D30, D31, D14
    FABD  D13, D24, D28
    EOR  V4.8B, V18.8B, V26.8B
    SQRSHL  B2, B6, B3
    SUBS  X14, X14, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_1321
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X15
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X3, X7, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D2
    MOVZ  X24, #0x87, LSL #0
    SUB  X19, X24, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D3
    MOVZ  X15, #0x0, LSL #0
    SUB  X23, X15, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D4
    MOVZ  X28, #0x7b, LSL #0
    MOVK  X28, #0x3fc0, LSL #16
    SUB  X17, X28, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    MOVK  X15, #0x7f80, LSL #48
    SUB  X20, X15, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D5
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7f80, LSL #16
    MOVK  X15, #0x7f80, LSL #48
    SUB  X20, X15, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D6
    MOVZ  X22, #0xbb87, LSL #0
    MOVK  X22, #0xce17, LSL #16
    SUB  X29, X22, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D7
    MOVZ  X15, #0x1a6, LSL #0
    SUB  X17, X15, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D8
    MOVZ  X5, #0x0, LSL #0
    SUB  X28, X5, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D10
    MOVZ  X27, #0x2908, LSL #0
    MOVK  X27, #0x722, LSL #16
    MOVK  X27, #0xf17a, LSL #32
    MOVK  X27, #0x3517, LSL #48
    SUB  X25, X27, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D11
    MOVZ  X10, #0x1, LSL #0
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0x7fff, LSL #48
    SUB  X20, X10, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X16, X22, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D12
    MOVZ  X22, #0x81, LSL #0
    SUB  X16, X22, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D13
    MOVZ  X29, #0x5487, LSL #0
    MOVK  X29, #0x1f, LSL #16
    SUB  X10, X29, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D14
    MOVZ  X26, #0xd1f9, LSL #0
    MOVK  X26, #0x6adf, LSL #16
    SUB  X6, X26, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D15
    MOVZ  X21, #0xd239, LSL #0
    MOVK  X21, #0x98a7, LSL #16
    MOVK  X21, #0x6000, LSL #48
    SUB  X18, X21, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D16
    MOVZ  X11, #0x39, LSL #0
    SUB  X2, X11, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D17
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D18
    MOVZ  X5, #0x7b, LSL #0
    SUB  X23, X5, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D19
    MOVZ  X24, #0xa4, LSL #0
    SUB  X29, X24, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D20
    MOVZ  X28, #0x3c10, LSL #0
    MOVK  X28, #0xd731, LSL #16
    MOVK  X28, #0x272d, LSL #32
    MOVK  X28, #0x1381, LSL #48
    SUB  X24, X28, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D21
    MOVZ  X11, #0xe94e, LSL #0
    MOVK  X11, #0x356f, LSL #16
    SUB  X10, X11, X5
TaishanSimdPairArithmeticP01_label_926:
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D24
    MOVZ  X6, #0xd37b, LSL #0
    SUB  X11, X6, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D25
    MOVZ  X15, #0x0, LSL #0
    SUB  X10, X15, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D26
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x3fc0, LSL #16
    SUB  X6, X21, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D27
    MOVZ  X5, #0xd279, LSL #0
    MOVK  X5, #0xc66f, LSL #16
    MOVK  X5, #0xc000, LSL #48
    SUB  X10, X5, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D28
    MOVZ  X10, #0x2802, LSL #0
    MOVK  X10, #0x20, LSL #16
    SUB  X29, X10, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D29
    MOVZ  X27, #0x102, LSL #0
    SUB  X24, X27, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X21
    FMOV  V1.D[1], X6
    FMOV  D2, X17
    FMOV  V2.D[1], X19
    FMOV  D3, X3
    FMOV  V3.D[1], X5
    FMOV  D4, X25
    FMOV  V4.D[1], X28
    FMOV  D5, X15
    FMOV  V5.D[1], X3
    FMOV  D6, X16
    FMOV  V6.D[1], X18
    FMOV  D7, X27
    FMOV  V7.D[1], X29
    FMOV  D8, X15
    FMOV  V8.D[1], X27
    FMOV  D9, X7
    FMOV  V9.D[1], X18
    FMOV  D10, X28
    FMOV  V10.D[1], X22
    FMOV  D11, X6
    FMOV  V11.D[1], X25
    FMOV  D12, X11
    FMOV  V12.D[1], X26
    FMOV  D13, X5
    FMOV  V13.D[1], X26
    FMOV  D14, X27
    FMOV  V14.D[1], X18
    FMOV  D15, X25
    FMOV  V15.D[1], X13
    FMOV  D16, X2
    FMOV  V16.D[1], X24
    FMOV  D17, X11
    FMOV  V17.D[1], X23
TaishanSimdPairArithmeticP01_label_1060:
    FMOV  D18, X11
    FMOV  V18.D[1], X3
    FMOV  D19, X22
    FMOV  V19.D[1], X12
    FMOV  D20, X21
    FMOV  V20.D[1], X25
    FMOV  D21, X22
    FMOV  V21.D[1], X17
    FMOV  D22, X29
    FMOV  V22.D[1], X28
    FMOV  D23, X8
    FMOV  V23.D[1], X17
    FMOV  D24, X10
    FMOV  V24.D[1], X12
    FMOV  D25, X8
    FMOV  V25.D[1], X21
    FMOV  D26, X2
    FMOV  V26.D[1], X21
    FMOV  D27, X3
    FMOV  V27.D[1], X28
    FMOV  D28, X21
    FMOV  V28.D[1], X5
    FMOV  D29, X26
    FMOV  V29.D[1], X4
    FMOV  D30, X23
    FMOV  V30.D[1], X2
    FMOV  D31, X6
    FMOV  V31.D[1], X10
    MOVZ  X20, #0xf, LSL #0
TaishanSimdPairArithmeticP01_label_1403:
    ADD  D3, D27, D12
    FRECPE  S15, S10
    UQSUB  B28, B28, B30
    SQSHL  S13, S23, S1
    FABD  V29.4S, V13.4S, V18.4S
    SABDL  V19.4S, V24.4H, V17.4H
    FRSQRTS  D4, D24, D20
    SQSHL  H22, H26, H29
    SQADD  H7, H16, H11
    SABDL2  V25.2D, V8.4S, V7.4S
    FMAX  V1.2S, V8.2S, V30.2S
    UHADD  V15.2S, V12.2S, V13.2S
    SMAX  V20.8B, V28.8B, V15.8B
    ORR  V31.8B, V21.8B, V11.8B
    ADD  D3, D31, D3
    URHADD  V14.2S, V10.2S, V11.2S
    AND  V23.8B, V31.8B, V3.8B
    FMULX  S23, S22, S24
    SABDL2  V3.4S, V14.8H, V27.8H
    UQSUB  B14, B20, B25
    UMIN  V13.4S, V0.4S, V15.4S
    SQRSHL  B30, B15, B27
    FDIV  V14.2D, V9.2D, V1.2D
    SQADD  D21, D11, D12
    FRECPE  D15, D11
    ADD  V7.2S, V23.2S, V3.2S
    SMAX  V14.4S, V19.4S, V26.4S
    SQSHL  V13.4H, V18.4H, V13.4H
    FMAX  V10.4S, V28.4S, V17.4S
    USHL  D3, D16, D9
    UHSUB  V8.4H, V4.4H, V10.4H
    SUB  D29, D29, D5
    SQADD  V9.8H, V19.8H, V11.8H
    SQRSHL  H13, H15, H3
    UQRSHL  D28, D19, D6
    SABDL2  V22.4S, V31.8H, V20.8H
    FRSQRTS  D7, D28, D7
    FMIN  V0.4S, V27.4S, V9.4S
    SSHL  D14, D15, D13
    URSHL  D12, D27, D31
    FDIV  V28.4S, V19.4S, V20.4S
    SQADD  B6, B22, B8
    SQSUB  V3.4H, V6.4H, V23.4H
    SQRSHL  S9, S1, S30
    SQSUB  S5, S16, S24
    SQRSHL  H29, H7, H30
    SMIN  V22.8H, V29.8H, V8.8H
    FRECPE  D26, D9
    URHADD  V18.4H, V9.4H, V19.4H
    SQSUB  D25, D26, D2
    UMIN  V9.8H, V11.8H, V20.8H
    FRSQRTS  V20.4S, V20.4S, V14.4S
    SQRSHL  S16, S17, S10
    UQRSHL  H10, H29, H16
    FMINNM  V16.2D, V5.2D, V16.2D
    UQADD  S3, S30, S0
    FMLS  V1.4S, V14.4S, V16.4S
    FRSQRTS  V29.4S, V21.4S, V3.4S
    SRSHL  V7.8H, V13.8H, V9.8H
    ORR  V29.8B, V19.8B, V1.8B
    UMIN  V31.8H, V20.8H, V11.8H
    AND  V28.16B, V25.16B, V6.16B
    ADD  V28.8H, V19.8H, V23.8H
    SUB  D27, D31, D24
    FMLS  V19.2S, V11.2S, V26.2S
    UQRSHL  S10, S27, S0
    FMIN  V12.2S, V18.2S, V9.2S
    SHADD  V8.4H, V18.4H, V2.4H
    FMULX  V8.2D, V23.2D, V16.2D
    UQSUB  B2, B8, B31
    UMAX  V29.4S, V31.4S, V14.4S
    FABD  S16, S7, S6
    FSUB  V4.2S, V28.2S, V30.2S
    UMAX  V1.2S, V26.2S, V1.2S
    AND  V1.16B, V27.16B, V17.16B
    UABA  V15.16B, V2.16B, V19.16B
    SQRSHL  V6.4H, V30.4H, V1.4H
    BIF  V22.8B, V16.8B, V12.8B
    FRECPE  D25, D10
    SABDL2  V17.8H, V20.16B, V28.16B
    UHADD  V16.8B, V29.8B, V15.8B
    FMIN  V4.4S, V12.4S, V23.4S
    SQSUB  H3, H25, H9
    SMAX  V4.8H, V6.8H, V14.8H
    UQRSHL  B29, B28, B0
    SQADD  D29, D13, D26
    UQRSHL  B11, B11, B31
    SMIN  V20.4H, V21.4H, V4.4H
    SQADD  H14, H24, H1
    SQSUB  S9, S28, S11
    SQSHL  S4, S28, S12
    UQADD  B22, B27, B16
    UQSUB  B17, B25, B17
    URSHL  V9.8B, V2.8B, V21.8B
    SQADD  B27, B9, B22
    UQADD  V0.4S, V28.4S, V23.4S
    SQSHL  V20.4H, V6.4H, V25.4H
    URSHL  D23, D21, D6
    SUB  D13, D4, D14
    UQADD  V6.2S, V3.2S, V29.2S
    SUB  V4.4S, V17.4S, V29.4S
    URHADD  V13.2S, V27.2S, V0.2S
    UHADD  V7.4S, V3.4S, V26.4S
    FRSQRTS  V26.2D, V31.2D, V20.2D
    FRSQRTS  V15.2D, V1.2D, V21.2D
    BIC  V14.8B, V25.8B, V15.8B
    SQRSHL  S25, S5, S8
    FMINNM  V0.4S, V15.4S, V7.4S
    UQADD  V25.4S, V18.4S, V29.4S
    UHSUB  V21.8H, V1.8H, V12.8H
    UQRSHL  V31.16B, V18.16B, V29.16B
    SQSHL  B9, B12, B13
    FABD  D0, D16, D7
    UQRSHL  S15, S31, S20
    FRECPE  D31, D1
    UQSUB  V24.4H, V14.4H, V26.4H
    FSUB  V12.2S, V13.2S, V1.2S
    FRECPE  D18, D25
    UQSUB  B1, B17, B22
    SUB  V11.2D, V20.2D, V7.2D
    FMAXNM  V25.2S, V17.2S, V26.2S
    EOR  V31.8B, V0.8B, V2.8B
    SQSHL  B4, B15, B24
    MUL  V23.16B, V22.16B, V25.16B
    UQSUB  H15, H12, H11
    MLA  V25.16B, V4.16B, V18.16B
    SQSHL  S31, S29, S12
    UQSUB  B7, B1, B13
    ORR  V27.16B, V12.16B, V24.16B
    AND  V31.8B, V2.8B, V2.8B
    URSHL  D16, D23, D3
    SQRSHL  D26, D9, D8
    FRSQRTS  V30.4S, V16.4S, V15.4S
    MUL  V2.16B, V2.16B, V26.16B
    UHADD  V12.8H, V13.8H, V20.8H
    SQRSHL  D25, D14, D29
    URSHL  V25.2D, V11.2D, V5.2D
    MLA  V14.4S, V29.4S, V28.4S
    SQSUB  H18, H20, H9
    FSUB  V18.2S, V4.2S, V6.2S
    FMULX  S31, S10, S19
    UQADD  S27, S27, S27
TaishanSimdPairArithmeticP01_label_528:
    UQADD  V10.2S, V0.2S, V22.2S
    SQSHL  H15, H3, H5
    FRSQRTS  V29.4S, V30.4S, V1.4S
    FMAXNM  V26.2D, V16.2D, V6.2D
    UQRSHL  B24, B27, B11
    SUB  D25, D24, D7
    MLA  V2.8H, V18.8H, V0.8H
    FMINNM  V12.2S, V12.2S, V4.2S
    SSHL  D22, D22, D19
    FMULX  V22.4S, V3.4S, V21.4S
    BSL  V14.16B, V10.16B, V5.16B
    UQSUB  H19, H15, H15
    UMAX  V0.2S, V23.2S, V29.2S
    BIF  V9.16B, V20.16B, V28.16B
    FRSQRTS  V6.2D, V12.2D, V20.2D
    URSHL  D27, D27, D2
    SUB  V7.4S, V21.4S, V27.4S
    SQADD  S30, S10, S28
    FRSQRTS  D25, D16, D14
    SHADD  V16.16B, V26.16B, V30.16B
    UMAX  V2.2S, V4.2S, V23.2S
    FMIN  V22.2D, V29.2D, V29.2D
    FADD  V19.4S, V8.4S, V4.4S
    BIT  V7.16B, V11.16B, V15.16B
    UQRSHL  B2, B27, B25
    SQADD  V31.8B, V22.8B, V28.8B
    FMLS  V5.2S, V5.2S, V16.2S
    SHSUB  V24.2S, V2.2S, V15.2S
    UQSUB  B1, B3, B15
    FRECPE  D15, D20
    FRSQRTS  V26.2D, V26.2D, V22.2D
    SQADD  D28, D4, D3
    UQSUB  B17, B15, B2
    FRECPE  V24.4S, V24.4S
    FMIN  V17.2S, V1.2S, V25.2S
    FRECPE  D24, D12
    UQSUB  S27, S25, S26
    SQSUB  H14, H20, H28
    SQSUB  D20, D29, D1
    SQRSHL  H7, H16, H3
    ORR  V31.8B, V7.8B, V18.8B
    UMIN  V2.4H, V5.4H, V8.4H
    SQADD  B20, B12, B29
    SQADD  S5, S24, S16
    FMLS  V3.4S, V13.4S, V7.4S
    UQRSHL  V23.4S, V20.4S, V15.4S
    MLA  V18.2S, V29.2S, V8.2S
    URSHL  D19, D31, D6
    SQSHL  H19, H6, H2
    SHADD  V4.8B, V22.8B, V23.8B
    SQSHL  H10, H28, H9
    SQSHL  D13, D14, D26
    ORR  V26.16B, V25.16B, V20.16B
    FMIN  V31.4S, V22.4S, V18.4S
    UQADD  H16, H13, H19
    SQSHL  V16.8B, V10.8B, V28.8B
    UQRSHL  H3, H7, H9
    SQRSHL  H29, H31, H2
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_1403
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X12, X26, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X26, X21, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X5, X7, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X19, X13, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X3, X24, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X11, X17, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X6, X22, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X10, X20, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X6, X19, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X5, X11, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X3, X29, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X15, X17, X20
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X10, X18, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X4, X6, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X29, X17, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X8, X6, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D2
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X13, X18, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X15, X25, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D4
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x1fe0, LSL #16
    MOVK  X25, #0x1fe0, LSL #48
    SUB  X15, X25, X24
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x3ff8, LSL #48
    SUB  X24, X12, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D6
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x3ff8, LSL #48
    SUB  X24, X12, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X15, X7, X29
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D11
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xc008, LSL #48
    SUB  X27, X23, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D12
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D13
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D14
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D15
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff0, LSL #48
    SUB  X10, X11, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D18
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x7ff0, LSL #48
    SUB  X17, X19, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D19
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3fc0, LSL #16
    MOVK  X17, #0x3fc0, LSL #48
    SUB  X6, X17, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D22
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3fc0, LSL #16
    MOVK  X17, #0x3fc0, LSL #48
    SUB  X6, X17, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D23
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D24
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7ff0, LSL #48
    SUB  X17, X25, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D25
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3ff8, LSL #48
    SUB  X29, X6, X5
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D26
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3ff8, LSL #48
    SUB  X8, X15, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D29
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x2086, LSL #0
    MOVK  X2, #0x93c5, LSL #16
    MOVK  X2, #0x337c, LSL #32
    MOVK  X2, #0x20f4, LSL #48
    MOVZ  X3, #0x6f83, LSL #0
    MOVK  X3, #0xd591, LSL #16
    MOVK  X3, #0xa3cc, LSL #32
    MOVK  X3, #0x890a, LSL #48
    MOVZ  X4, #0xa270, LSL #0
    MOVK  X4, #0x5128, LSL #16
    MOVK  X4, #0x8b4c, LSL #32
    MOVK  X4, #0xed2c, LSL #48
    MOVZ  X5, #0xac1d, LSL #0
    MOVK  X5, #0x617d, LSL #16
    MOVK  X5, #0xfe3d, LSL #32
    MOVK  X5, #0x577a, LSL #48
    MOVZ  X6, #0x50fc, LSL #0
    MOVK  X6, #0xd0b4, LSL #16
    MOVK  X6, #0x422f, LSL #32
    MOVK  X6, #0xa50a, LSL #48
    MOVZ  X7, #0x3d30, LSL #0
    MOVK  X7, #0x839c, LSL #16
    MOVK  X7, #0x30ef, LSL #32
    MOVK  X7, #0xa4ab, LSL #48
    MOVZ  X8, #0xe92f, LSL #0
    MOVK  X8, #0xd976, LSL #16
    MOVK  X8, #0xec, LSL #32
    MOVK  X8, #0x3717, LSL #48
    MOVZ  X10, #0x2663, LSL #0
    MOVK  X10, #0xcc5a, LSL #16
    MOVK  X10, #0xbfbb, LSL #32
    MOVK  X10, #0x600a, LSL #48
    MOVZ  X11, #0x83a, LSL #0
    MOVK  X11, #0x27d8, LSL #16
    MOVK  X11, #0x4a94, LSL #32
    MOVK  X11, #0xe4b6, LSL #48
    MOVZ  X12, #0x8975, LSL #0
    MOVK  X12, #0xd889, LSL #16
    MOVK  X12, #0xb872, LSL #32
    MOVK  X12, #0xb6c1, LSL #48
    MOVZ  X13, #0x18b2, LSL #0
    MOVK  X13, #0x97e8, LSL #16
    MOVK  X13, #0x4c9e, LSL #32
    MOVK  X13, #0x3cd7, LSL #48
    MOVZ  X14, #0x271e, LSL #0
    MOVK  X14, #0xbcc9, LSL #16
    MOVK  X14, #0x315, LSL #32
    MOVK  X14, #0xfd6f, LSL #48
    MOVZ  X15, #0x272f, LSL #0
    MOVK  X15, #0xf292, LSL #16
    MOVK  X15, #0xa5, LSL #32
    MOVK  X15, #0xaa72, LSL #48
    MOVZ  X16, #0xd49f, LSL #0
    MOVK  X16, #0xfc52, LSL #16
    MOVK  X16, #0x5cd4, LSL #32
    MOVK  X16, #0x69b2, LSL #48
    MOVZ  X17, #0xe1ff, LSL #0
    MOVK  X17, #0x2243, LSL #16
    MOVK  X17, #0x6ebc, LSL #32
    MOVK  X17, #0x2470, LSL #48
    MOVZ  X18, #0xaab9, LSL #0
    MOVK  X18, #0xac21, LSL #16
    MOVK  X18, #0xcee9, LSL #32
    MOVK  X18, #0x22e, LSL #48
    MOVZ  X19, #0xcba5, LSL #0
    MOVK  X19, #0x866d, LSL #16
    MOVK  X19, #0x7852, LSL #32
    MOVK  X19, #0x2c7a, LSL #48
    MOVZ  X20, #0x885, LSL #0
    MOVK  X20, #0xcbcd, LSL #16
    MOVK  X20, #0xf45e, LSL #32
    MOVK  X20, #0x7977, LSL #48
    MOVZ  X21, #0x9c8f, LSL #0
    MOVK  X21, #0x455c, LSL #16
    MOVK  X21, #0x7907, LSL #32
    MOVK  X21, #0xdcf4, LSL #48
    MOVZ  X22, #0x4a53, LSL #0
    MOVK  X22, #0x213d, LSL #16
    MOVK  X22, #0x9cc1, LSL #32
    MOVK  X22, #0x3dba, LSL #48
    MOVZ  X23, #0x69cf, LSL #0
    MOVK  X23, #0x1145, LSL #16
    MOVK  X23, #0xe3b2, LSL #32
    MOVK  X23, #0x1fbe, LSL #48
    MOVZ  X24, #0xf09d, LSL #0
    MOVK  X24, #0x237d, LSL #16
    MOVK  X24, #0x91ec, LSL #32
    MOVK  X24, #0x5294, LSL #48
    MOVZ  X25, #0xb28c, LSL #0
    MOVK  X25, #0x9d1d, LSL #16
    MOVK  X25, #0x273c, LSL #32
    MOVK  X25, #0xbd0c, LSL #48
    MOVZ  X26, #0x52e9, LSL #0
    MOVK  X26, #0xa977, LSL #16
    MOVK  X26, #0x4258, LSL #32
    MOVK  X26, #0xf2f4, LSL #48
    MOVZ  X27, #0x67fb, LSL #0
    MOVK  X27, #0x415a, LSL #16
    MOVK  X27, #0x96cf, LSL #32
    MOVK  X27, #0x3b80, LSL #48
    MOVZ  X28, #0xab61, LSL #0
    MOVK  X28, #0xa07d, LSL #16
    MOVK  X28, #0x722b, LSL #32
    MOVK  X28, #0x1904, LSL #48
    MOVZ  X29, #0x9d23, LSL #0
    MOVK  X29, #0x6638, LSL #16
    MOVK  X29, #0x1d99, LSL #32
    MOVK  X29, #0x7624, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X12
    FMOV  D1, X23
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X13
    FMOV  D3, X26
    FMOV  V3.D[1], X14
    FMOV  D4, X18
    FMOV  V4.D[1], X27
    FMOV  D5, X6
    FMOV  V5.D[1], X22
    FMOV  D6, X17
    FMOV  V6.D[1], X5
    FMOV  D7, X2
    FMOV  V7.D[1], X5
    FMOV  D8, X13
    FMOV  V8.D[1], X3
    FMOV  D9, X20
    FMOV  V9.D[1], X27
    FMOV  D10, X28
    FMOV  V10.D[1], X2
    FMOV  D11, X10
    FMOV  V11.D[1], X23
    FMOV  D12, X2
    FMOV  V12.D[1], X20
    FMOV  D13, X19
    FMOV  V13.D[1], X25
    FMOV  D14, X29
    FMOV  V14.D[1], X15
    FMOV  D15, X28
    FMOV  V15.D[1], X8
    FMOV  D16, X3
    FMOV  V16.D[1], X4
    FMOV  D17, X2
    FMOV  V17.D[1], X24
    FMOV  D18, X26
    FMOV  V18.D[1], X11
    FMOV  D19, X7
    FMOV  V19.D[1], X12
    FMOV  D20, X18
    FMOV  V20.D[1], X24
    FMOV  D21, X17
    FMOV  V21.D[1], X26
    FMOV  D22, X26
    FMOV  V22.D[1], X24
    FMOV  D23, X19
    FMOV  V23.D[1], X20
    FMOV  D24, X8
    FMOV  V24.D[1], X18
    FMOV  D25, X11
    FMOV  V25.D[1], X11
    FMOV  D26, X3
    FMOV  V26.D[1], X15
    FMOV  D27, X21
    FMOV  V27.D[1], X3
    FMOV  D28, X4
    FMOV  V28.D[1], X22
    FMOV  D29, X8
    FMOV  V29.D[1], X3
    FMOV  D30, X24
    FMOV  V30.D[1], X10
    FMOV  D31, X16
    FMOV  V31.D[1], X18
    MOVZ  X29, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_1480:
    SRSHL  V1.16B, V15.16B, V7.16B
    UQRSHL  H20, H6, H10
    SQSUB  B13, B24, B7
    SQRSHL  S7, S25, S27
    SQSHL  B26, B29, B22
    BSL  V19.8B, V1.8B, V5.8B
    EOR  V22.8B, V2.8B, V11.8B
    FDIV  V24.2D, V30.2D, V8.2D
    UQSUB  H31, H29, H1
    SRSHL  D8, D29, D8
    MUL  V21.16B, V29.16B, V30.16B
    SQSUB  S6, S1, S4
    SQSUB  B20, B11, B25
    UQRSHL  H4, H15, H15
    UABA  V19.2S, V10.2S, V21.2S
    UABA  V3.4S, V15.4S, V17.4S
    UQRSHL  B12, B19, B2
    FRSQRTS  D23, D17, D22
    MUL  V22.16B, V15.16B, V23.16B
    SHSUB  V12.4H, V15.4H, V10.4H
    ADD  D19, D2, D28
    UQADD  D21, D19, D27
    SUB  V2.4S, V3.4S, V11.4S
    ADD  D26, D6, D21
    FRSQRTS  V5.2S, V28.2S, V22.2S
    FABD  V20.2S, V6.2S, V28.2S
    UQSUB  V8.16B, V25.16B, V29.16B
    URHADD  V21.8B, V2.8B, V1.8B
    FMLS  V21.4S, V11.4S, V31.4S
    SHSUB  V14.8B, V4.8B, V16.8B
    UHSUB  V21.16B, V4.16B, V3.16B
    FABD  S4, S16, S28
    UABA  V18.8H, V8.8H, V4.8H
    SQADD  B1, B25, B11
    SRHADD  V3.8H, V4.8H, V29.8H
    UQADD  B2, B26, B2
    UQRSHL  V23.4S, V19.4S, V17.4S
TaishanSimdPairArithmeticP01_label_841:
    FMULX  S22, S7, S6
    FMIN  V28.4S, V28.4S, V19.4S
    UQADD  H1, H21, H4
    ORN  V5.16B, V26.16B, V25.16B
    BIF  V21.16B, V3.16B, V4.16B
    SUB  V0.16B, V27.16B, V18.16B
    SQRSHL  B28, B27, B21
    FABD  D21, D2, D0
    UQRSHL  S2, S29, S26
    FSUB  V0.4S, V19.4S, V28.4S
    UQSUB  V14.4H, V6.4H, V11.4H
    SRHADD  V24.8B, V0.8B, V22.8B
    SQRSHL  B3, B7, B27
    SQSUB  H18, H4, H1
    SQSHL  B2, B23, B21
    SHSUB  V0.4H, V15.4H, V25.4H
    FDIV  V0.2S, V17.2S, V1.2S
    UQSUB  S5, S19, S9
    SSHL  V19.8H, V23.8H, V26.8H
    FABD  V27.4S, V11.4S, V18.4S
    URSHL  D18, D29, D14
    SQSUB  B24, B28, B8
    FABD  S22, S4, S26
    FRECPE  D3, D20
    SQRSHL  H28, H1, H21
    AND  V2.16B, V27.16B, V20.16B
    FRSQRTS  S4, S21, S7
    URHADD  V12.8H, V9.8H, V10.8H
    ORN  V30.8B, V5.8B, V27.8B
    FDIV  V18.2S, V11.2S, V31.2S
    SQRSHL  V13.4S, V25.4S, V12.4S
    SQSHL  V30.2S, V16.2S, V5.2S
    AND  V12.8B, V4.8B, V19.8B
    SABDL2  V20.2D, V3.4S, V7.4S
    FMLA  V5.2D, V0.2D, V13.2D
    SMIN  V5.8B, V28.8B, V31.8B
    UHADD  V30.8B, V20.8B, V18.8B
    USHL  V11.2D, V30.2D, V29.2D
    UHSUB  V15.2S, V14.2S, V9.2S
    SQSUB  B24, B7, B15
    SQSHL  B12, B2, B25
    SQSHL  S10, S30, S28
    SUB  D26, D4, D21
    FRSQRTS  S18, S20, S17
    ORN  V5.8B, V10.8B, V24.8B
    BIF  V14.16B, V26.16B, V9.16B
    UMIN  V30.4H, V29.4H, V17.4H
    MOV  V0.8B, V17.8B
    SMAX  V11.4S, V28.4S, V1.4S
    SQSHL  D4, D8, D18
    UQSUB  S14, S5, S12
    UHADD  V8.4H, V0.4H, V6.4H
    FMAX  V3.2S, V3.2S, V21.2S
    SQSUB  B16, B3, B0
    SQRSHL  H21, H15, H20
    UQSUB  V11.8B, V12.8B, V14.8B
    UQADD  V17.16B, V1.16B, V21.16B
    UABA  V16.8H, V15.8H, V26.8H
    SRSHL  V4.16B, V1.16B, V11.16B
    FADD  V7.4S, V29.4S, V19.4S
    UQSUB  S29, S19, S16
    FRSQRTS  V21.2D, V10.2D, V17.2D
    ADD  V9.4H, V24.4H, V27.4H
    MLS  V7.16B, V8.16B, V3.16B
    FABD  S17, S30, S0
    FMLS  V19.2D, V20.2D, V24.2D
    SMIN  V11.8B, V30.8B, V26.8B
    SQSUB  V20.2S, V5.2S, V7.2S
    FABD  S15, S11, S11
    UQSUB  V5.2S, V26.2S, V11.2S
    SQSUB  S28, S19, S8
    FMULX  V2.4S, V17.4S, V14.4S
    SQSHL  H20, H17, H4
    UQRSHL  B21, B9, B30
    SQRSHL  V15.8B, V22.8B, V5.8B
    UQSUB  H15, H7, H29
    SMAX  V8.8H, V29.8H, V4.8H
    SQSHL  V3.8H, V0.8H, V1.8H
    FRECPE  D7, D17
    SQSUB  V15.8B, V24.8B, V4.8B
    SQADD  H15, H31, H19
    FMULX  S19, S15, S5
    FMINNM  V16.2D, V8.2D, V15.2D
    URHADD  V28.8H, V8.8H, V10.8H
    SABDL2  V16.4S, V28.8H, V14.8H
    UQRSHL  D1, D12, D7
    UQRSHL  V31.2D, V5.2D, V20.2D
    UQRSHL  H2, H31, H26
    SSHL  V9.2S, V15.2S, V21.2S
    FADD  V5.2D, V5.2D, V0.2D
    FRECPE  S26, S16
    FMLA  V22.4S, V25.4S, V21.4S
    FMLS  V5.2D, V22.2D, V1.2D
    SQSHL  V20.2D, V5.2D, V11.2D
    UMAX  V1.4S, V22.4S, V28.4S
    UMAX  V3.4H, V27.4H, V19.4H
    SQADD  H19, H3, H8
    FMLA  V27.2S, V4.2S, V9.2S
    SSHL  D26, D2, D16
    SRHADD  V11.16B, V15.16B, V8.16B
TaishanSimdPairArithmeticP01_label_316:
    FMAXNM  V20.4S, V18.4S, V2.4S
    URSHL  D2, D12, D22
    SMAX  V14.4S, V5.4S, V0.4S
    SQSHL  D19, D2, D0
    FMLS  V1.4S, V26.4S, V9.4S
    SQRSHL  H20, H5, H11
    URSHL  D23, D21, D3
    SUB  D11, D27, D26
    UQRSHL  D25, D25, D6
    ORR  V12.8B, V12.8B, V30.8B
    UQSUB  H18, H26, H10
    SQSUB  D28, D27, D14
    UQRSHL  S19, S29, S9
    BSL  V11.16B, V1.16B, V28.16B
    SQRSHL  B16, B4, B14
    SQRSHL  V12.2D, V14.2D, V23.2D
    MUL  V31.8B, V14.8B, V20.8B
    SQSUB  H13, H17, H19
    SQRSHL  S15, S21, S7
    FABD  S18, S17, S11
    UQADD  V4.4S, V3.4S, V3.4S
    SABDL2  V31.8H, V27.16B, V16.16B
    SHADD  V12.16B, V19.16B, V26.16B
    SQSUB  V15.2D, V22.2D, V12.2D
    SQSUB  H28, H27, H27
    ADD  D15, D12, D7
    UQSUB  S25, S3, S4
    SHADD  V9.16B, V31.16B, V18.16B
    BIC  V17.16B, V3.16B, V7.16B
    FRECPE  V23.2S, V6.2S
    FMINNM  V0.2S, V3.2S, V18.2S
    SQSHL  S25, S23, S13
    USHL  V0.8H, V25.8H, V11.8H
    FRSQRTS  V2.4S, V4.4S, V12.4S
    FMUL  V22.4S, V3.4S, V13.4S
    FMAX  V1.2S, V5.2S, V30.2S
    FMULX  D22, D28, D3
    FABD  D17, D11, D17
    SQSHL  H15, H22, H30
    MLS  V0.4H, V23.4H, V24.4H
    SHADD  V3.4S, V2.4S, V2.4S
    FSUB  V15.4S, V9.4S, V9.4S
    SQSHL  V22.8B, V5.8B, V4.8B
    SQSHL  D16, D27, D30
    FMLS  V23.2S, V5.2S, V25.2S
    SHSUB  V15.16B, V17.16B, V1.16B
    SQRSHL  D11, D5, D13
    FMAXNM  V6.2D, V23.2D, V22.2D
    FRSQRTS  S1, S19, S8
    MLS  V11.16B, V28.16B, V10.16B
    SQADD  V17.2S, V24.2S, V28.2S
    ORR  V20.16B, V20.16B, V24.16B
    FSUB  V19.2S, V10.2S, V0.2S
    FMUL  V16.2S, V6.2S, V19.2S
    SMIN  V7.8H, V5.8H, V3.8H
    UQRSHL  D0, D26, D0
    BIT  V0.8B, V7.8B, V1.8B
    MLA  V0.8H, V24.8H, V7.8H
    SQSUB  D7, D3, D18
    FRSQRTS  D30, D21, D23
    UQSUB  H27, H11, H21
    UABA  V22.8H, V17.8H, V3.8H
    SABD  V20.8B, V17.8B, V22.8B
    SUBS  X29, X29, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_1480
    MOVZ  X25, #0x2086, LSL #0
    MOVK  X25, #0x93c5, LSL #16
    MOVK  X25, #0x337c, LSL #32
    MOVK  X25, #0x20f4, LSL #48
    SUB  X26, X25, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x6f83, LSL #0
    MOVK  X11, #0xd591, LSL #16
    MOVK  X11, #0xa3cc, LSL #32
    MOVK  X11, #0x890a, LSL #48
    SUB  X18, X11, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0xa270, LSL #0
    MOVK  X20, #0x5128, LSL #16
    MOVK  X20, #0x8b4c, LSL #32
    MOVK  X20, #0xed2c, LSL #48
    SUB  X8, X20, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0xac1d, LSL #0
    MOVK  X21, #0x617d, LSL #16
    MOVK  X21, #0xfe3d, LSL #32
    MOVK  X21, #0x577a, LSL #48
    SUB  X22, X21, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x50fc, LSL #0
    MOVK  X25, #0xd0b4, LSL #16
    MOVK  X25, #0x422f, LSL #32
    MOVK  X25, #0xa50a, LSL #48
    SUB  X18, X25, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0x3d30, LSL #0
    MOVK  X14, #0x839c, LSL #16
    MOVK  X14, #0x30ef, LSL #32
    MOVK  X14, #0xa4ab, LSL #48
    SUB  X11, X14, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x2663, LSL #0
    MOVK  X4, #0xcc5a, LSL #16
    MOVK  X4, #0xbfbb, LSL #32
    MOVK  X4, #0x600a, LSL #48
    SUB  X20, X4, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X21, X15, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x8975, LSL #0
    MOVK  X2, #0xd889, LSL #16
    MOVK  X2, #0xb872, LSL #32
    MOVK  X2, #0xb6c1, LSL #48
    SUB  X5, X2, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X17, #0x18b2, LSL #0
    MOVK  X17, #0x97e8, LSL #16
    MOVK  X17, #0x4c9e, LSL #32
    MOVK  X17, #0x3cd7, LSL #48
    SUB  X15, X17, X13
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x3d30, LSL #0
    MOVK  X16, #0x839c, LSL #16
    MOVK  X16, #0x30ef, LSL #32
    MOVK  X16, #0xa4ab, LSL #48
    SUB  X28, X16, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X15
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x3d30, LSL #0
    MOVK  X20, #0x839c, LSL #16
    MOVK  X20, #0x30ef, LSL #32
    MOVK  X20, #0xa4ab, LSL #48
    SUB  X5, X20, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X6, #0x18b2, LSL #0
    MOVK  X6, #0x97e8, LSL #16
    MOVK  X6, #0x4c9e, LSL #32
    MOVK  X6, #0x3cd7, LSL #48
    SUB  X4, X6, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0xcba5, LSL #0
    MOVK  X13, #0x866d, LSL #16
    MOVK  X13, #0x7852, LSL #32
    MOVK  X13, #0x2c7a, LSL #48
    SUB  X28, X13, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0x3d30, LSL #0
    MOVK  X15, #0x839c, LSL #16
    MOVK  X15, #0x30ef, LSL #32
    MOVK  X15, #0xa4ab, LSL #48
    SUB  X8, X15, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X11, X18, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0x69cf, LSL #0
    MOVK  X25, #0x1145, LSL #16
    MOVK  X25, #0xe3b2, LSL #32
    MOVK  X25, #0x1fbe, LSL #48
    SUB  X20, X25, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X25, #0xf09d, LSL #0
    MOVK  X25, #0x237d, LSL #16
    MOVK  X25, #0x91ec, LSL #32
    MOVK  X25, #0x5294, LSL #48
    SUB  X3, X25, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0xf09d, LSL #0
    MOVK  X10, #0x237d, LSL #16
    MOVK  X10, #0x91ec, LSL #32
    MOVK  X10, #0x5294, LSL #48
    SUB  X14, X10, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3fc0, LSL #16
    MOVK  X15, #0x3fc0, LSL #48
    SUB  X24, X15, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D2
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3fc0, LSL #16
    MOVK  X15, #0x3fc0, LSL #48
    SUB  X24, X15, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3fc0, LSL #16
    MOVK  X23, #0x3fc0, LSL #48
    SUB  X17, X23, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D3
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x3fc0, LSL #16
    MOVK  X23, #0x3fc0, LSL #48
    SUB  X17, X23, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X13, X15, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D4
    MOVZ  X15, #0xdffe, LSL #0
    MOVK  X15, #0x7e, LSL #16
    SUB  X13, X15, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D5
    MOVZ  X19, #0x34d8, LSL #0
    MOVK  X19, #0x21, LSL #16
    SUB  X29, X19, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D6
    MOVZ  X19, #0x8000, LSL #0
    MOVK  X19, #0x802a, LSL #16
    MOVK  X19, #0x7f80, LSL #48
    SUB  X14, X19, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D7
    MOVZ  X13, #0x854b, LSL #0
    MOVK  X13, #0x3fbf, LSL #16
    MOVK  X13, #0x3fc0, LSL #48
    SUB  X4, X13, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D8
    MOVZ  X3, #0x3818, LSL #0
    SUB  X17, X3, X22
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D10
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x3f40, LSL #16
    SUB  X25, X3, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D11
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0x7fff, LSL #48
    SUB  X20, X26, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D12
    MOVZ  X13, #0x1b0b, LSL #0
    MOVK  X13, #0xe024, LSL #16
    SUB  X10, X13, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D13
    MOVZ  X26, #0xc85a, LSL #0
    SUB  X14, X26, X15
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D14
    MOVZ  X24, #0x34d8, LSL #0
    MOVK  X24, #0x21, LSL #16
    SUB  X19, X24, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D15
    MOVZ  X3, #0xe000, LSL #0
    MOVK  X3, #0xe, LSL #16
    SUB  X12, X3, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D16
    MOVZ  X18, #0xe000, LSL #0
    MOVK  X18, #0x801f, LSL #16
    MOVK  X18, #0x7fc0, LSL #48
    SUB  X19, X18, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D17
    MOVZ  X4, #0x41, LSL #0
    SUB  X23, X4, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D18
    MOVZ  X8, #0x7ab5, LSL #0
    SUB  X5, X8, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, D19
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x3f40, LSL #16
    SUB  X21, X25, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X5, D20
    MOVZ  X26, #0x10a, LSL #0
    MOVK  X26, #0x403f, LSL #16
    MOVK  X26, #0x3f40, LSL #48
    SUB  X12, X26, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X7, D21
    MOVZ  X28, #0x40, LSL #0
    SUB  X24, X28, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x3fc0, LSL #16
    MOVK  X8, #0x3fc0, LSL #48
    SUB  X5, X8, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D22
    MOVZ  X8, #0x137, LSL #0
    MOVK  X8, #0x403f, LSL #16
    MOVK  X8, #0x3fc0, LSL #48
    SUB  X5, X8, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D23
    MOVZ  X19, #0x8000, LSL #0
    MOVK  X19, #0x802a, LSL #16
    MOVK  X19, #0x7f80, LSL #48
    SUB  X12, X19, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D24
    MOVZ  X5, #0x41, LSL #0
    SUB  X12, X5, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D25
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X18, X27, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X3, D26
    MOVZ  X2, #0xffff, LSL #0
    SUB  X27, X2, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D27
    MOVZ  X26, #0xffbf, LSL #0
    SUB  X8, X26, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D28
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D29
    MOVZ  X10, #0x3818, LSL #0
    MOVK  X10, #0xc048, LSL #16
    SUB  X3, X10, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X22
    FMOV  D2, X20
    FMOV  V2.D[1], X21
    FMOV  D3, X5
    FMOV  V3.D[1], X18
    FMOV  D4, X2
    FMOV  V4.D[1], X29
    FMOV  D5, X5
    FMOV  V5.D[1], X22
    FMOV  D6, X22
    FMOV  V6.D[1], X18
    FMOV  D7, X11
    FMOV  V7.D[1], X23
    FMOV  D8, X27
    FMOV  V8.D[1], X28
    FMOV  D9, X26
    FMOV  V9.D[1], X5
    FMOV  D10, X19
    FMOV  V10.D[1], X5
    FMOV  D11, X4
    FMOV  V11.D[1], X22
    FMOV  D12, X21
    FMOV  V12.D[1], X26
    FMOV  D13, X20
    FMOV  V13.D[1], X11
    FMOV  D14, X6
    FMOV  V14.D[1], X15
    FMOV  D15, X17
    FMOV  V15.D[1], X2
    FMOV  D16, X15
    FMOV  V16.D[1], X18
    FMOV  D17, X3
    FMOV  V17.D[1], X14
    FMOV  D18, X15
    FMOV  V18.D[1], X19
    FMOV  D19, X10
    FMOV  V19.D[1], X4
    FMOV  D20, X10
    FMOV  V20.D[1], X7
    FMOV  D21, X22
    FMOV  V21.D[1], X20
    FMOV  D22, X11
    FMOV  V22.D[1], X2
    FMOV  D23, X22
    FMOV  V23.D[1], X28
    FMOV  D24, X3
    FMOV  V24.D[1], X7
    FMOV  D25, X24
    FMOV  V25.D[1], X4
    FMOV  D26, X7
    FMOV  V26.D[1], X24
    FMOV  D27, X12
    FMOV  V27.D[1], X7
    FMOV  D28, X17
    FMOV  V28.D[1], X4
    FMOV  D29, X16
    FMOV  V29.D[1], X10
    FMOV  D30, X24
    FMOV  V30.D[1], X10
    FMOV  D31, X12
    FMOV  V31.D[1], X14
    MOVZ  X25, #0xa, LSL #0
TaishanSimdPairArithmeticP01_label_1561:
    FMULX  V30.2D, V31.2D, V7.2D
    SMIN  V25.16B, V22.16B, V17.16B
    BIF  V6.8B, V13.8B, V9.8B
    SQSHL  S5, S25, S19
    SQRSHL  S7, S26, S28
    MUL  V30.2S, V27.2S, V7.2S
    UHADD  V18.8H, V25.8H, V24.8H
    FMULX  V25.4S, V23.4S, V26.4S
    SQRSHL  S18, S25, S6
    SQADD  B5, B28, B24
    SUB  V3.8H, V16.8H, V4.8H
    UQRSHL  S29, S5, S4
    MLA  V25.16B, V23.16B, V30.16B
    MUL  V18.2S, V12.2S, V13.2S
    MOV  V17.8B, V3.8B
    USHL  V29.2D, V19.2D, V17.2D
    UHSUB  V18.8B, V7.8B, V30.8B
    BSL  V16.8B, V31.8B, V16.8B
    MOV  V17.8B, V18.8B
    SQSHL  H2, H9, H24
    USHL  D2, D23, D15
    UQADD  B26, B25, B5
    SMAX  V7.8H, V28.8H, V8.8H
    URSHL  V5.8H, V18.8H, V8.8H
    FMIN  V2.2S, V29.2S, V28.2S
    SQADD  V16.2S, V22.2S, V12.2S
    FRECPE  V31.4S, V23.4S
    UQSUB  H16, H8, H22
    SQSHL  H17, H24, H12
    FMIN  V1.4S, V4.4S, V26.4S
    SABD  V13.4S, V1.4S, V25.4S
    FRECPE  V15.4S, V16.4S
    SUB  D31, D26, D27
    SQADD  V15.8B, V10.8B, V28.8B
    FMLS  V19.4S, V0.4S, V30.4S
    MLS  V11.2S, V31.2S, V25.2S
    UQADD  V21.8B, V20.8B, V19.8B
    FRECPE  D19, D7
    SABDL2  V8.4S, V28.8H, V7.8H
    URSHL  D25, D25, D27
    SSHL  D14, D3, D12
    URHADD  V5.4S, V10.4S, V21.4S
    MOV  V13.8B, V18.8B
    SQRSHL  B14, B29, B15
    EOR  V9.8B, V14.8B, V21.8B
    SQSUB  V21.4H, V17.4H, V10.4H
    ORR  V29.16B, V3.16B, V12.16B
    UQSUB  H12, H12, H20
    UMAX  V19.4H, V2.4H, V29.4H
    USHL  V11.4S, V30.4S, V23.4S
    URSHL  V6.8H, V9.8H, V26.8H
    SABDL2  V7.4S, V30.8H, V6.8H
    SQRSHL  S22, S13, S23
    UMIN  V24.4S, V19.4S, V23.4S
    URSHL  D16, D29, D18
    UQSUB  S11, S23, S6
    UMAX  V21.8H, V11.8H, V15.8H
    UQRSHL  H8, H21, H5
    UQADD  H14, H11, H8
    UQSUB  D25, D24, D13
    SMAX  V12.4S, V24.4S, V9.4S
    FSUB  V25.4S, V4.4S, V29.4S
    URSHL  D7, D12, D16
    UQRSHL  B29, B31, B15
    UQRSHL  H29, H18, H11
    UQSUB  D3, D19, D7
    SQSHL  H29, H2, H18
    SQSUB  S30, S3, S1
    SHADD  V7.16B, V4.16B, V22.16B
    UQRSHL  V30.2D, V25.2D, V13.2D
    SQSHL  V18.4H, V4.4H, V4.4H
    FMLA  V7.4S, V24.4S, V23.4S
    ORR  V29.16B, V27.16B, V10.16B
    SABDL2  V29.8H, V29.16B, V14.16B
    UQSUB  H16, H29, H16
    ORR  V15.16B, V16.16B, V10.16B
    SQSUB  H19, H15, H7
    BIC  V7.8B, V10.8B, V27.8B
    SQRSHL  S19, S13, S30
    FABD  S14, S27, S7
    SHSUB  V7.8B, V14.8B, V17.8B
    ADD  D31, D18, D12
    SABDL2  V31.2D, V15.4S, V14.4S
    SRSHL  V31.4S, V22.4S, V1.4S
    SRSHL  V26.2D, V28.2D, V1.2D
    SQSHL  S1, S15, S31
    FRSQRTS  V21.4S, V5.4S, V30.4S
    UHADD  V13.16B, V6.16B, V26.16B
    UQADD  S25, S18, S5
    SQADD  B17, B25, B13
    FRSQRTS  V13.4S, V21.4S, V17.4S
    FRSQRTS  S19, S13, S12
    UQSUB  V1.2D, V25.2D, V29.2D
    UQSUB  V4.16B, V9.16B, V2.16B
    ORN  V27.8B, V30.8B, V3.8B
    UMAX  V26.16B, V4.16B, V22.16B
    BIC  V25.16B, V14.16B, V1.16B
    USHL  D27, D1, D16
    SQRSHL  H5, H27, H27
    FMULX  S9, S7, S18
    SABD  V15.4S, V5.4S, V10.4S
    UHADD  V21.4S, V10.4S, V15.4S
    UQSUB  H31, H19, H15
    FMIN  V23.2D, V26.2D, V17.2D
    SRHADD  V12.4H, V8.4H, V18.4H
    UQADD  H1, H6, H20
    FMULX  D11, D0, D4
    SSHL  V28.8H, V27.8H, V11.8H
    FRSQRTS  V1.4S, V5.4S, V10.4S
    SMAX  V10.4S, V5.4S, V23.4S
    UQADD  D2, D24, D18
    UQRSHL  B2, B7, B23
    UQADD  B20, B6, B13
    FABD  D4, D29, D20
    UQRSHL  S28, S28, S25
    FDIV  V1.2S, V17.2S, V31.2S
    UQRSHL  V14.16B, V5.16B, V2.16B
    SQSUB  S7, S17, S1
    UQRSHL  V4.4H, V0.4H, V6.4H
    UMIN  V4.16B, V7.16B, V30.16B
    SUB  D0, D15, D11
    MOV  V22.8B, V27.8B
    UQADD  S2, S22, S26
    MUL  V15.8B, V8.8B, V24.8B
    FABD  D8, D16, D11
    MLS  V30.16B, V19.16B, V27.16B
    FMINNM  V21.2S, V11.2S, V11.2S
    USHL  D30, D0, D27
    BSL  V23.8B, V31.8B, V22.8B
    SQADD  V22.8B, V26.8B, V28.8B
    SQSUB  B18, B14, B19
    URSHL  V8.2D, V18.2D, V4.2D
    URHADD  V3.4H, V18.4H, V2.4H
    SQSUB  B24, B26, B3
    SQSHL  B26, B12, B12
    SSHL  D18, D19, D27
    USHL  D29, D11, D15
    UQRSHL  S6, S11, S25
    UQRSHL  V2.2D, V29.2D, V1.2D
    SUB  D24, D2, D23
    ADD  V0.2S, V24.2S, V13.2S
    SQSHL  D28, D16, D25
    USHL  V14.8H, V25.8H, V6.8H
    SHADD  V25.16B, V8.16B, V8.16B
    SABDL2  V19.2D, V20.4S, V27.4S
    FMLS  V18.2D, V22.2D, V10.2D
    FMUL  V0.2S, V13.2S, V26.2S
    FRSQRTS  D10, D22, D28
    FRECPE  S14, S30
    UQSUB  B2, B25, B3
    SQSUB  D16, D28, D6
    FMIN  V24.2S, V7.2S, V19.2S
    SQADD  S2, S24, S21
    FRECPE  V29.2S, V30.2S
    URSHL  D2, D28, D2
    SUB  D29, D18, D17
    SQSUB  B26, B1, B23
    SSHL  D13, D8, D9
    SQSHL  V2.4S, V0.4S, V21.4S
    UQRSHL  H28, H31, H30
    UQSUB  H10, H22, H4
    SQADD  V20.2D, V11.2D, V5.2D
    UQRSHL  H30, H24, H13
    ORN  V22.8B, V23.8B, V20.8B
    ADD  V0.8H, V2.8H, V18.8H
    URHADD  V22.8B, V7.8B, V16.8B
    FSUB  V2.2S, V27.2S, V16.2S
    SUB  D29, D8, D3
    SQSHL  D12, D30, D7
    FRECPE  V27.2S, V22.2S
    FABD  V3.4S, V16.4S, V18.4S
    SUB  V20.2D, V18.2D, V10.2D
    FMIN  V26.4S, V18.4S, V13.4S
    SABDL  V10.8H, V0.8B, V9.8B
    MLS  V15.8H, V23.8H, V5.8H
    UQADD  H30, H26, H13
    FMULX  S24, S3, S11
    SABD  V19.4H, V16.4H, V7.4H
    FDIV  V26.4S, V27.4S, V5.4S
    SRHADD  V9.4H, V4.4H, V12.4H
    SQADD  H18, H31, H19
    MOV  V11.16B, V0.16B
    FRSQRTS  D29, D24, D12
    FMINNM  V19.4S, V0.4S, V16.4S
    SQSUB  H15, H5, H0
    UQSUB  V18.8B, V3.8B, V15.8B
    FABD  S28, S0, S2
    UHADD  V29.4H, V27.4H, V22.4H
    FABD  D28, D26, D26
    ORN  V19.16B, V8.16B, V11.16B
    SSHL  V23.8H, V29.8H, V10.8H
    UQADD  V8.4H, V2.4H, V15.4H
    SSHL  D13, D19, D19
    FMINNM  V12.4S, V30.4S, V20.4S
    SQSHL  V9.2S, V23.2S, V25.2S
    UQADD  B22, B17, B26
    FSUB  V7.4S, V18.4S, V2.4S
    SQSUB  V6.2D, V2.2D, V22.2D
    SQADD  S9, S10, S21
    MUL  V4.4S, V9.4S, V28.4S
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_1561
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X5, X15, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X15
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X20
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X14, X28, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X28, X25, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D2
    MOVZ  X25, #0xc, LSL #0
    MOVK  X25, #0x8007, LSL #16
    SUB  X28, X25, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D3
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3fc, LSL #32
    SUB  X16, X10, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D4
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D5
    MOVZ  X2, #0x7fff, LSL #0
    SUB  X25, X2, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D6
    MOVZ  X28, #0xffc0, LSL #0
    MOVK  X28, #0x8006, LSL #16
    SUB  X12, X28, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X6, X25, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X2, D7
    MOVZ  X25, #0xc, LSL #0
    MOVK  X25, #0x7, LSL #16
    MOVK  X25, #0x3fc, LSL #32
    SUB  X6, X25, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D8
    MOVZ  X5, #0x800b, LSL #0
    MOVK  X5, #0x8007, LSL #16
    SUB  X19, X5, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V10.D[1]
TaishanSimdPairArithmeticP01_label_1268:
    MOVZ  X25, #0x4, LSL #0
    MOVK  X25, #0x3, LSL #16
    SUB  X19, X25, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D10
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D11
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x3fc, LSL #32
    SUB  X13, X8, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X10
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D13
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xfe01, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X16, X8, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X13, D14
    MOVZ  X6, #0x8000, LSL #0
    MOVK  X6, #0x96fc, LSL #16
    SUB  X18, X6, X13
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X23, D15
    MOVZ  X5, #0x7fff, LSL #0
    SUB  X6, X5, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X10, D17
    MOVZ  X8, #0x4c, LSL #0
    SUB  X12, X8, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D18
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x3fc, LSL #32
    SUB  X13, X6, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D19
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xfc03, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X17, X24, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D20
    MOVZ  X28, #0xf0c3, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0x3fb, LSL #32
    SUB  X3, X28, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D22
    MOVZ  X29, #0x4c, LSL #0
    SUB  X11, X29, X17
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X8, X24, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D23
    MOVZ  X24, #0x4013, LSL #0
    MOVK  X24, #0x3f75, LSL #16
    MOVK  X24, #0x3fc0, LSL #48
    SUB  X8, X24, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X29, X28, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D25
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xff, LSL #48
    SUB  X29, X28, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    MOVK  X16, #0x7fc0, LSL #48
TaishanSimdPairArithmeticP01_label_1185:
    SUB  X12, X16, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X4, D26
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7f80, LSL #16
    MOVK  X16, #0x7f80, LSL #48
    SUB  X12, X16, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D27
    MOVZ  X4, #0x8000, LSL #0
    MOVK  X4, #0x3eaa, LSL #16
    MOVK  X4, #0x7f80, LSL #48
    SUB  X21, X4, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X16, D28
TaishanSimdPairArithmeticP01_label_744:
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X19, X24, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
TaishanSimdPairArithmeticP01_label_34:
    FMOV  X26, D29
    MOVZ  X24, #0x4013, LSL #0
    MOVK  X24, #0x3f75, LSL #16
    MOVK  X24, #0x3fc0, LSL #48
    SUB  X19, X24, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
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
    FMOV  D0, X21
    FMOV  V0.D[1], X10
    FMOV  D1, X13
    FMOV  V1.D[1], X24
    FMOV  D2, X7
    FMOV  V2.D[1], X29
    FMOV  D3, X28
    FMOV  V3.D[1], X26
    FMOV  D4, X25
    FMOV  V4.D[1], X12
    FMOV  D5, X21
    FMOV  V5.D[1], X25
    FMOV  D6, X5
    FMOV  V6.D[1], X18
    FMOV  D7, X12
    FMOV  V7.D[1], X12
    FMOV  D8, X17
    FMOV  V8.D[1], X4
    FMOV  D9, X4
    FMOV  V9.D[1], X12
    FMOV  D10, X28
    FMOV  V10.D[1], X24
    FMOV  D11, X11
    FMOV  V11.D[1], X6
    FMOV  D12, X2
    FMOV  V12.D[1], X10
    FMOV  D13, X17
    FMOV  V13.D[1], X13
    FMOV  D14, X8
    FMOV  V14.D[1], X15
    FMOV  D15, X11
    FMOV  V15.D[1], X3
    FMOV  D16, X4
    FMOV  V16.D[1], X19
    FMOV  D17, X2
    FMOV  V17.D[1], X15
    FMOV  D18, X6
    FMOV  V18.D[1], X19
    FMOV  D19, X7
    FMOV  V19.D[1], X2
    FMOV  D20, X3
    FMOV  V20.D[1], X15
    FMOV  D21, X16
    FMOV  V21.D[1], X16
    FMOV  D22, X2
    FMOV  V22.D[1], X14
    FMOV  D23, X26
    FMOV  V23.D[1], X27
    FMOV  D24, X8
    FMOV  V24.D[1], X10
    FMOV  D25, X15
    FMOV  V25.D[1], X19
    FMOV  D26, X7
    FMOV  V26.D[1], X20
    FMOV  D27, X10
    FMOV  V27.D[1], X27
    FMOV  D28, X12
    FMOV  V28.D[1], X14
    FMOV  D29, X10
    FMOV  V29.D[1], X27
    FMOV  D30, X8
    FMOV  V30.D[1], X28
    FMOV  D31, X18
    FMOV  V31.D[1], X10
    MOVZ  X26, #0xf, LSL #0
TaishanSimdPairArithmeticP01_label_1641:
    UQADD  B20, B23, B24
    UMIN  V24.2S, V14.2S, V21.2S
    FRSQRTS  S24, S20, S28
    FMULX  V4.4S, V31.4S, V8.4S
    BIC  V9.16B, V16.16B, V9.16B
    FSUB  V16.4S, V2.4S, V15.4S
    SQSUB  V3.4S, V28.4S, V20.4S
    FRECPE  S30, S1
    UQRSHL  V11.16B, V22.16B, V24.16B
    SABDL2  V11.2D, V20.4S, V16.4S
    BIC  V1.8B, V30.8B, V26.8B
    SHADD  V1.4H, V4.4H, V29.4H
    MLS  V30.8H, V24.8H, V4.8H
    SMIN  V4.4S, V24.4S, V30.4S
    ADD  D28, D28, D23
    FRECPE  D9, D12
    SQADD  H29, H27, H27
    UQSUB  V0.8H, V29.8H, V27.8H
    SUB  V0.2S, V22.2S, V11.2S
    BIT  V25.8B, V11.8B, V5.8B
    MOV  V28.16B, V29.16B
    SQSHL  S3, S14, S8
    FMIN  V10.2S, V26.2S, V19.2S
    UQADD  V16.2S, V15.2S, V8.2S
    FRECPE  D28, D12
    FRSQRTS  V0.2S, V25.2S, V14.2S
    FMUL  V27.2S, V6.2S, V5.2S
    SQSHL  S18, S16, S5
    FDIV  V5.4S, V30.4S, V17.4S
    FADD  V24.4S, V31.4S, V11.4S
    BIT  V31.16B, V22.16B, V13.16B
    ORR  V19.8B, V20.8B, V27.8B
    USHL  V11.4H, V30.4H, V25.4H
    SQADD  H13, H5, H8
    BIT  V28.8B, V9.8B, V7.8B
    FMIN  V3.2S, V2.2S, V30.2S
    FRSQRTS  D3, D14, D18
    FMLS  V22.2D, V13.2D, V24.2D
    FABD  S24, S10, S29
    SQRSHL  V28.4H, V12.4H, V8.4H
    MOV  V1.8B, V13.8B
    UQADD  H6, H28, H1
    FMULX  V31.2S, V6.2S, V0.2S
    BIT  V7.16B, V7.16B, V6.16B
    FRECPE  V19.2S, V24.2S
    SQADD  V14.8B, V17.8B, V15.8B
    SQSUB  V29.4H, V21.4H, V13.4H
    SQSHL  S5, S24, S19
    FABD  S19, S29, S22
    SABDL2  V15.4S, V14.8H, V6.8H
    USHL  V5.8H, V2.8H, V10.8H
    SRSHL  D16, D16, D14
    SHADD  V27.4S, V19.4S, V17.4S
    EOR  V17.16B, V0.16B, V7.16B
    UQRSHL  S14, S25, S25
    UQSUB  H18, H6, H2
    UQADD  B23, B20, B6
    ORR  V4.8B, V24.8B, V23.8B
    SQSHL  H21, H25, H0
    SHSUB  V9.16B, V29.16B, V14.16B
    UQADD  S29, S7, S7
    UQRSHL  D1, D15, D13
    SQSUB  H30, H1, H17
    SQRSHL  B26, B22, B25
    SQRSHL  S2, S6, S26
    FABD  S20, S13, S19
    FRECPE  V5.2S, V28.2S
    SQADD  V5.4S, V4.4S, V25.4S
    MLA  V15.8H, V25.8H, V22.8H
    SQSUB  V24.8H, V31.8H, V5.8H
    SQADD  B20, B10, B21
    FABD  S5, S4, S13
    FMAX  V19.4S, V22.4S, V20.4S
    UQRSHL  V22.16B, V15.16B, V12.16B
    ADD  V9.8B, V4.8B, V5.8B
    USHL  D28, D18, D27
TaishanSimdPairArithmeticP01_label_749:
    SHADD  V31.4H, V31.4H, V0.4H
    SMAX  V4.4S, V21.4S, V1.4S
    FMAXNM  V18.4S, V7.4S, V18.4S
    SQSUB  H4, H21, H5
    SSHL  V10.8B, V0.8B, V0.8B
    SQSHL  D24, D30, D15
    SQSHL  D17, D7, D28
    UQADD  V19.4S, V21.4S, V25.4S
    SRSHL  V21.8H, V28.8H, V7.8H
    MOV  V1.16B, V15.16B
    FDIV  V13.2D, V7.2D, V31.2D
    MUL  V9.2S, V7.2S, V4.2S
    SSHL  D31, D9, D23
    USHL  V21.4S, V21.4S, V16.4S
    SABDL  V21.2D, V4.2S, V15.2S
    MLS  V1.8B, V18.8B, V5.8B
    URHADD  V10.16B, V1.16B, V26.16B
    USHL  D2, D23, D24
    UMIN  V25.2S, V22.2S, V1.2S
    SQSHL  V10.4S, V18.4S, V27.4S
    SQSUB  S9, S0, S28
    SHSUB  V19.8B, V11.8B, V30.8B
    UQSUB  D29, D30, D10
    SQADD  V19.2S, V13.2S, V12.2S
    SMIN  V24.4S, V11.4S, V0.4S
    SABDL  V3.8H, V27.8B, V26.8B
    UQRSHL  B20, B16, B28
    ADD  D3, D21, D22
    UABA  V9.16B, V31.16B, V19.16B
    ADD  V19.16B, V17.16B, V17.16B
    FSUB  V24.4S, V10.4S, V20.4S
    FMLS  V24.2S, V6.2S, V30.2S
    UQRSHL  B29, B28, B24
    FABD  S29, S9, S6
    FRSQRTS  D9, D6, D2
    SHSUB  V13.8H, V30.8H, V20.8H
    SQRSHL  D29, D5, D17
    SQSHL  B27, B13, B25
    SQSHL  V5.2S, V13.2S, V16.2S
    UQRSHL  S3, S7, S29
    FMIN  V25.2D, V3.2D, V3.2D
    ADD  V9.8H, V19.8H, V1.8H
    UQSUB  S24, S14, S14
    FRSQRTS  D18, D19, D8
    SQSHL  V16.8H, V9.8H, V18.8H
    SQSUB  V4.4H, V27.4H, V7.4H
    SSHL  V20.2D, V6.2D, V31.2D
    EOR  V21.16B, V14.16B, V1.16B
    FABD  V8.2S, V4.2S, V28.2S
    ORN  V23.16B, V19.16B, V12.16B
    ORN  V5.8B, V7.8B, V9.8B
    UQRSHL  H7, H11, H18
    SRHADD  V6.8B, V1.8B, V5.8B
    UQADD  B24, B9, B27
    UQSUB  V12.8B, V0.8B, V16.8B
    USHL  V21.8H, V19.8H, V7.8H
    SQADD  V6.16B, V31.16B, V11.16B
    UHADD  V5.4H, V29.4H, V25.4H
    UQRSHL  S18, S11, S23
    USHL  V5.16B, V0.16B, V17.16B
    SQRSHL  H10, H5, H16
    ADD  D20, D24, D24
    FMULX  D22, D24, D28
    SQADD  S1, S12, S13
    FRSQRTS  D26, D1, D4
    UHADD  V21.16B, V29.16B, V30.16B
    SQSUB  D29, D24, D1
    ADD  D19, D21, D25
    FRSQRTS  S8, S10, S10
    SRSHL  V9.8H, V30.8H, V9.8H
    FABD  V4.2D, V22.2D, V2.2D
    SABDL  V28.2D, V8.2S, V19.2S
    SQSUB  H15, H24, H22
    SQSHL  D2, D23, D29
    SMAX  V7.4S, V2.4S, V6.4S
    FMLS  V2.2D, V5.2D, V31.2D
    SUB  D7, D26, D15
    UHSUB  V15.16B, V30.16B, V9.16B
    FRSQRTS  S30, S31, S18
    UQRSHL  V25.16B, V2.16B, V4.16B
    FABD  V2.2S, V20.2S, V5.2S
    SSHL  V28.4H, V13.4H, V28.4H
    FRSQRTS  D9, D7, D29
    FABD  D19, D9, D24
    SQSHL  D19, D7, D15
    FSUB  V23.2S, V4.2S, V28.2S
    FMAXNM  V19.2S, V0.2S, V13.2S
    URSHL  V19.4H, V13.4H, V15.4H
    UQADD  D13, D19, D30
    MLA  V17.8H, V6.8H, V16.8H
    SQADD  S18, S23, S17
    SQRSHL  H25, H9, H25
    ADD  D1, D31, D8
    BIF  V0.16B, V28.16B, V12.16B
    FMULX  D28, D25, D13
    FRSQRTS  D20, D8, D5
    SHSUB  V8.4H, V14.4H, V4.4H
    FMULX  S15, S9, S19
    FABD  D31, D3, D13
    FMAXNM  V8.2D, V18.2D, V27.2D
    UMAX  V15.4S, V9.4S, V26.4S
    FRECPE  V18.2D, V2.2D
    UQADD  D20, D4, D7
    URSHL  V18.8H, V12.8H, V1.8H
    UHSUB  V30.2S, V17.2S, V21.2S
    SQADD  V14.2D, V25.2D, V21.2D
    UQRSHL  D9, D15, D26
    FMULX  V9.2D, V15.2D, V20.2D
    SRSHL  V5.2S, V25.2S, V1.2S
    SQADD  S15, S10, S27
    SQSHL  D14, D31, D30
    SQADD  D15, D8, D23
    UQRSHL  H5, H5, H27
    UQADD  B9, B14, B28
    FMAX  V15.2D, V22.2D, V16.2D
    FMAX  V22.4S, V14.4S, V18.4S
    SQADD  D12, D29, D27
    SHSUB  V24.8H, V11.8H, V14.8H
    FMAX  V22.4S, V18.4S, V15.4S
    SQADD  S31, S15, S21
    FRSQRTS  S0, S23, S2
    MOV  V29.16B, V16.16B
    FMAX  V23.2D, V7.2D, V6.2D
    SQSHL  V30.2D, V16.2D, V23.2D
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdPairArithmeticP01_label_1641
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X5, X8, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X15, X20, X3
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
TaishanSimdPairArithmeticP01_label_1339:
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X14, X24, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X26, X14, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X17, X4, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X23, X29, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X12, X29, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X15, X21, X11
    ADD X1, X1, #1
    CBNZ   X15, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X16, X13, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X15
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X17, X10, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X3, X28, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X24, X10, X24
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X6, X23, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X18, X12, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D2
    MOVZ  X16, #0x7f00, LSL #0
    MOVK  X16, #0x7f7f, LSL #16
    MOVK  X16, #0x7f7f, LSL #32
    SUB  X20, X16, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X25, D3
    MOVZ  X27, #0xff08, LSL #0
    MOVK  X27, #0xffff, LSL #16
    SUB  X23, X27, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X27, D4
    MOVZ  X13, #0xe, LSL #0
    SUB  X20, X13, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X28, X23, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D6
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xbf2e, LSL #16
    MOVK  X2, #0x8e65, LSL #32
    MOVK  X2, #0x1ff2, LSL #48
    SUB  X25, X2, X15
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X14, D7
    MOVZ  X28, #0xff3b, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0x3ff7, LSL #48
    SUB  X25, X28, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D8
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    SUB  X22, X29, X15
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X22, X18, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X24, D10
    MOVZ  X18, #0x3f80, LSL #0
    SUB  X22, X18, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D11
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xbf2e, LSL #16
    SUB  X17, X27, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D12
    MOVZ  X4, #0x81c1, LSL #0
    MOVK  X4, #0xff7e, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X29, X4, X15
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D13
    MOVZ  X18, #0xf83f, LSL #0
    MOVK  X18, #0x1, LSL #32
    SUB  X23, X18, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X8, X17, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X22, D14
    MOVZ  X17, #0xe4dc, LSL #0
    MOVK  X17, #0x3, LSL #16
    SUB  X8, X17, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D15
    MOVZ  X29, #0x7fff, LSL #0
    MOVK  X29, #0xff7f, LSL #16
    MOVK  X29, #0xff7f, LSL #32
    MOVK  X29, #0x3f, LSL #48
    SUB  X26, X29, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X18, D16
    MOVZ  X17, #0x7fff, LSL #0
    MOVK  X17, #0xff7f, LSL #16
    MOVK  X17, #0xff7f, LSL #32
    MOVK  X17, #0x3f, LSL #48
    SUB  X11, X17, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X29, D17
    MOVZ  X20, #0xff08, LSL #0
    MOVK  X20, #0xa9d1, LSL #16
    MOVK  X20, #0x3f1a, LSL #32
    MOVK  X20, #0x1c85, LSL #48
    SUB  X23, X20, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X4, X15, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X19, D18
    MOVZ  X15, #0x8000, LSL #0
    MOVK  X15, #0x2, LSL #48
    SUB  X4, X15, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X22, X5, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X12, D19
    MOVZ  X5, #0xf840, LSL #0
    SUB  X22, X5, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X15, D20
    MOVZ  X11, #0xff49, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0x3ff7, LSL #48
    SUB  X23, X11, X15
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X19, X6, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X8, D21
    MOVZ  X6, #0x9f04, LSL #0
    MOVK  X6, #0x48, LSL #16
    SUB  X19, X6, X8
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X17, D22
    MOVZ  X19, #0x8000, LSL #0
    MOVK  X19, #0xff7f, LSL #32
    MOVK  X19, #0x3f, LSL #48
    SUB  X8, X19, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X22, X28, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D23
    MOVZ  X28, #0xff3b, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0x3ff7, LSL #48
    SUB  X22, X28, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X6, D24
    MOVZ  X14, #0xd92, LSL #0
    MOVK  X14, #0xdf95, LSL #16
    SUB  X8, X14, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X11, D25
    MOVZ  X19, #0xc0a1, LSL #0
    SUB  X18, X19, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X20
TaishanSimdPairArithmeticP01_label_703:
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X20, D26
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3ff8, LSL #48
    SUB  X21, X10, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D27
    MOVZ  X24, #0x80, LSL #0
    SUB  X5, X24, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X21, D28
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail
    FMOV  X28, D29
    MOVZ  X5, #0x7fff, LSL #0
    MOVK  X5, #0xff7f, LSL #16
    MOVK  X5, #0xff7f, LSL #32
    MOVK  X5, #0x3f, LSL #48
    SUB  X8, X5, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPairArithmeticP01_TestFail

TaishanSimdPairArithmeticP01_TestEnd:
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
TaishanSimdPairArithmeticP01_TestFail:
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
