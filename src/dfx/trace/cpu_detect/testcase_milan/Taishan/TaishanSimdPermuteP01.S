.global TaishanSimdPermuteP01

.text
.p2align 4

TaishanSimdPermuteP01:

TaishanSimdPermuteP01_TestBegin:
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
    MOVK  X2, #0xeea1, LSL #48
    MOVK  X2, #0x46b1, LSL #32
    MOVK  X2, #0xfed7, LSL #16
    MOVK  X2, #0x9d8f, LSL #0
    MOVK  X3, #0x7d7b, LSL #48
    MOVK  X3, #0x31cf, LSL #32
    MOVK  X3, #0x812f, LSL #16
    MOVK  X3, #0xb15b, LSL #0
    MOVK  X4, #0x3196, LSL #48
    MOVK  X4, #0x784d, LSL #32
    MOVK  X4, #0x591f, LSL #16
    MOVK  X4, #0x6b36, LSL #0
    MOVK  X5, #0x110f, LSL #48
    MOVK  X5, #0x1f7f, LSL #32
    MOVK  X5, #0xcc6, LSL #16
    MOVK  X5, #0xb368, LSL #0
    MOVK  X6, #0x2fce, LSL #48
    MOVK  X6, #0x264f, LSL #32
    MOVK  X6, #0x4694, LSL #16
    MOVK  X6, #0x1eb6, LSL #0
    MOVK  X7, #0xe1bf, LSL #48
    MOVK  X7, #0x8c64, LSL #32
    MOVK  X7, #0xf332, LSL #16
    MOVK  X7, #0xf4a9, LSL #0
    MOVK  X8, #0x4b91, LSL #48
    MOVK  X8, #0x227a, LSL #32
    MOVK  X8, #0x1f2d, LSL #16
    MOVK  X8, #0xd589, LSL #0
    MOVK  X9, #0xb1ae, LSL #48
    MOVK  X9, #0xb6bf, LSL #32
    MOVK  X9, #0xe1b8, LSL #16
    MOVK  X9, #0xa942, LSL #0
    MOVK  X10, #0xf6ab, LSL #48
    MOVK  X10, #0x26b8, LSL #32
    MOVK  X10, #0x38a6, LSL #16
    MOVK  X10, #0xfeba, LSL #0
    MOVK  X11, #0x7d9b, LSL #48
    MOVK  X11, #0x3951, LSL #32
    MOVK  X11, #0x1d7c, LSL #16
    MOVK  X11, #0xc0c8, LSL #0
    MOVK  X12, #0x6bb4, LSL #48
    MOVK  X12, #0x333e, LSL #32
    MOVK  X12, #0x35ad, LSL #16
    MOVK  X12, #0x53d6, LSL #0
    MOVK  X13, #0x1dde, LSL #48
    MOVK  X13, #0xea8e, LSL #32
    MOVK  X13, #0xf8a, LSL #16
    MOVK  X13, #0x5160, LSL #0
    MOVK  X14, #0xf8a2, LSL #48
    MOVK  X14, #0x537e, LSL #32
    MOVK  X14, #0xcf16, LSL #16
    MOVK  X14, #0x2944, LSL #0
    MOVK  X16, #0x855a, LSL #48
    MOVK  X16, #0x978c, LSL #32
    MOVK  X16, #0x8e70, LSL #16
    MOVK  X16, #0x8364, LSL #0
    MOVK  X17, #0x6d7c, LSL #48
    MOVK  X17, #0x247b, LSL #32
    MOVK  X17, #0xc7ee, LSL #16
    MOVK  X17, #0x2b70, LSL #0
    MOVK  X18, #0xb856, LSL #48
    MOVK  X18, #0x8e79, LSL #32
    MOVK  X18, #0x544, LSL #16
    MOVK  X18, #0xc61e, LSL #0
    MOVK  X19, #0x47e, LSL #48
    MOVK  X19, #0x3eae, LSL #32
    MOVK  X19, #0x9d24, LSL #16
    MOVK  X19, #0x11e4, LSL #0
    MOVK  X20, #0x8b43, LSL #48
    MOVK  X20, #0xd9e2, LSL #32
    MOVK  X20, #0x94bb, LSL #16
    MOVK  X20, #0x1fc, LSL #0
    MOVK  X21, #0xa21c, LSL #48
    MOVK  X21, #0xe8d6, LSL #32
    MOVK  X21, #0xc313, LSL #16
    MOVK  X21, #0xee66, LSL #0
    MOVK  X22, #0xefcd, LSL #48
    MOVK  X22, #0x94eb, LSL #32
    MOVK  X22, #0xce1, LSL #16
    MOVK  X22, #0x7bf8, LSL #0
    MOVK  X23, #0xd92f, LSL #48
    MOVK  X23, #0x676, LSL #32
    MOVK  X23, #0x3e13, LSL #16
    MOVK  X23, #0xb93e, LSL #0
    MOVK  X24, #0x770f, LSL #48
    MOVK  X24, #0x699c, LSL #32
    MOVK  X24, #0x991b, LSL #16
    MOVK  X24, #0xfe27, LSL #0
    MOVK  X25, #0xf552, LSL #48
    MOVK  X25, #0xb336, LSL #32
    MOVK  X25, #0x45aa, LSL #16
    MOVK  X25, #0x1cce, LSL #0
    MOVK  X26, #0x2d46, LSL #48
    MOVK  X26, #0x9ca2, LSL #32
    MOVK  X26, #0xe7ab, LSL #16
    MOVK  X26, #0x1ee1, LSL #0
    MOVK  X27, #0x879d, LSL #48
    MOVK  X27, #0x5397, LSL #32
    MOVK  X27, #0xd7fb, LSL #16
    MOVK  X27, #0x46dc, LSL #0
    MOVK  X28, #0xad24, LSL #48
    MOVK  X28, #0x88ca, LSL #32
    MOVK  X28, #0x5a2f, LSL #16
    MOVK  X28, #0x7f39, LSL #0
    MOVK  X29, #0x9c00, LSL #48
    MOVK  X29, #0x3b60, LSL #32
    MOVK  X29, #0xa222, LSL #16
    MOVK  X29, #0xdcee, LSL #0
    ANDS  X27, X12, #0xe000e000e000e
    MOVZ  X5, #0x45fa, LSL #0
    MOVK  X5, #0x17b3, LSL #16
    MSR  FPCR, X5
    MRS  X7, FPSR
    MOVZ  X27, #0xff60, LSL #0
    MOVK  X27, #0x7ff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    AND  X7, X7, X27
    MOVZ  X27, #0x0, LSL #0
    ORR  X7, X7, X27
    MSR  FPSR, X7
    ISB  SY
    MOVZ  X2, #0x53bd, LSL #0
    MOVK  X2, #0xb28b, LSL #16
    MOVK  X2, #0x889e, LSL #32
    MOVK  X2, #0x329e, LSL #48
    MOVZ  X3, #0xe2e9, LSL #0
    MOVK  X3, #0xcf6, LSL #16
    MOVK  X3, #0xe4d8, LSL #32
    MOVK  X3, #0xa9d7, LSL #48
    MOVZ  X4, #0x1bb4, LSL #0
    MOVK  X4, #0x27e9, LSL #16
    MOVK  X4, #0x8a2f, LSL #32
    MOVK  X4, #0x1cf5, LSL #48
    MOVZ  X5, #0xed3d, LSL #0
    MOVK  X5, #0xd26d, LSL #16
    MOVK  X5, #0x17be, LSL #32
    MOVK  X5, #0x5696, LSL #48
    MOVZ  X6, #0x63f7, LSL #0
    MOVK  X6, #0x2d23, LSL #16
    MOVK  X6, #0x6330, LSL #32
    MOVK  X6, #0x67f2, LSL #48
    MOVZ  X7, #0x141d, LSL #0
    MOVK  X7, #0xc537, LSL #16
    MOVK  X7, #0xacdb, LSL #32
    MOVK  X7, #0x45d, LSL #48
    MOVZ  X8, #0x44d8, LSL #0
    MOVK  X8, #0x3f7f, LSL #16
    MOVK  X8, #0x29d1, LSL #32
    MOVK  X8, #0xc9a, LSL #48
    MOVZ  X9, #0x4596, LSL #0
    MOVK  X9, #0x7c0, LSL #16
    MOVK  X9, #0x5b30, LSL #32
    MOVK  X9, #0xd19e, LSL #48
    MOVZ  X10, #0x1ba0, LSL #0
    MOVK  X10, #0x24d8, LSL #16
    MOVK  X10, #0x5e62, LSL #32
    MOVK  X10, #0xd5b0, LSL #48
    MOVZ  X11, #0x60ee, LSL #0
    MOVK  X11, #0x24e3, LSL #16
    MOVK  X11, #0xa770, LSL #32
    MOVK  X11, #0x592a, LSL #48
    MOVZ  X12, #0x6538, LSL #0
    MOVK  X12, #0xeb3, LSL #16
    MOVK  X12, #0xa839, LSL #32
    MOVK  X12, #0x5658, LSL #48
    MOVZ  X13, #0xfab, LSL #0
    MOVK  X13, #0xa4ed, LSL #16
    MOVK  X13, #0x8c82, LSL #32
    MOVK  X13, #0xeda9, LSL #48
    MOVZ  X14, #0xf2ed, LSL #0
    MOVK  X14, #0x6391, LSL #16
    MOVK  X14, #0x13b9, LSL #32
    MOVK  X14, #0xeed7, LSL #48
    MOVZ  X16, #0x28cf, LSL #0
    MOVK  X16, #0x1eac, LSL #16
    MOVK  X16, #0xa5b4, LSL #32
    MOVK  X16, #0x2801, LSL #48
    MOVZ  X17, #0x2637, LSL #0
    MOVK  X17, #0xc2dc, LSL #16
    MOVK  X17, #0x62bf, LSL #32
    MOVK  X17, #0xfb20, LSL #48
    MOVZ  X18, #0x6973, LSL #0
    MOVK  X18, #0xe20b, LSL #16
    MOVK  X18, #0xd529, LSL #32
    MOVK  X18, #0x6, LSL #48
    MOVZ  X19, #0xda7f, LSL #0
    MOVK  X19, #0x52a5, LSL #16
    MOVK  X19, #0x4d5d, LSL #32
    MOVK  X19, #0x12cb, LSL #48
    MOVZ  X20, #0xff5a, LSL #0
    MOVK  X20, #0x4018, LSL #16
    MOVK  X20, #0x53e3, LSL #32
    MOVK  X20, #0xec3c, LSL #48
    MOVZ  X21, #0xff20, LSL #0
    MOVK  X21, #0x84d7, LSL #16
    MOVK  X21, #0x6688, LSL #32
    MOVK  X21, #0x1caa, LSL #48
    MOVZ  X22, #0x6a63, LSL #0
    MOVK  X22, #0x4d4b, LSL #16
    MOVK  X22, #0xdd1e, LSL #32
    MOVK  X22, #0x9577, LSL #48
    MOVZ  X23, #0x4834, LSL #0
    MOVK  X23, #0xdcbb, LSL #16
    MOVK  X23, #0x8086, LSL #32
    MOVK  X23, #0x5f6a, LSL #48
    MOVZ  X24, #0xa4ae, LSL #0
    MOVK  X24, #0x3872, LSL #16
    MOVK  X24, #0x2266, LSL #32
    MOVK  X24, #0x8fbe, LSL #48
    MOVZ  X25, #0x2703, LSL #0
    MOVK  X25, #0x70f5, LSL #16
    MOVK  X25, #0x5c46, LSL #32
    MOVK  X25, #0x5fce, LSL #48
    MOVZ  X26, #0x2487, LSL #0
    MOVK  X26, #0x907d, LSL #16
    MOVK  X26, #0xd758, LSL #32
    MOVK  X26, #0x478c, LSL #48
    MOVZ  X27, #0x17da, LSL #0
    MOVK  X27, #0x79e7, LSL #16
    MOVK  X27, #0x781f, LSL #32
    MOVK  X27, #0x2b23, LSL #48
    MOVZ  X28, #0xa0d6, LSL #0
    MOVK  X28, #0x752, LSL #16
    MOVK  X28, #0xa820, LSL #32
    MOVK  X28, #0x7a61, LSL #48
    MOVZ  X29, #0x9599, LSL #0
    MOVK  X29, #0x9744, LSL #16
    MOVK  X29, #0xe2c9, LSL #32
    MOVK  X29, #0x7261, LSL #48
    FMOV  D0, X4
    FMOV  V0.D[1], X12
    FMOV  D1, X18
    FMOV  V1.D[1], X21
    FMOV  D2, X18
    FMOV  V2.D[1], X10
    FMOV  D3, X21
    FMOV  V3.D[1], X24
    FMOV  D4, X14
    FMOV  V4.D[1], X29
    FMOV  D5, X20
    FMOV  V5.D[1], X7
    FMOV  D6, X13
    FMOV  V6.D[1], X28
    FMOV  D7, X27
    FMOV  V7.D[1], X16
    FMOV  D8, X23
    FMOV  V8.D[1], X21
    FMOV  D9, X6
    FMOV  V9.D[1], X13
    FMOV  D10, X8
    FMOV  V10.D[1], X27
    FMOV  D11, X14
    FMOV  V11.D[1], X7
    FMOV  D12, X13
    FMOV  V12.D[1], X21
    FMOV  D13, X29
    FMOV  V13.D[1], X3
    FMOV  D14, X6
    FMOV  V14.D[1], X12
    FMOV  D15, X27
    FMOV  V15.D[1], X16
    FMOV  D16, X8
    FMOV  V16.D[1], X20
    FMOV  D17, X23
    FMOV  V17.D[1], X9
    FMOV  D18, X20
    FMOV  V18.D[1], X21
    FMOV  D19, X23
    FMOV  V19.D[1], X9
    FMOV  D20, X6
    FMOV  V20.D[1], X17
    FMOV  D21, X28
    FMOV  V21.D[1], X14
    FMOV  D22, X28
    FMOV  V22.D[1], X12
    FMOV  D23, X14
    FMOV  V23.D[1], X14
    FMOV  D24, X6
    FMOV  V24.D[1], X28
    FMOV  D25, X12
    FMOV  V25.D[1], X18
    FMOV  D26, X13
    FMOV  V26.D[1], X29
    FMOV  D27, X29
    FMOV  V27.D[1], X14
    FMOV  D28, X17
    FMOV  V28.D[1], X3
    FMOV  D29, X24
    FMOV  V29.D[1], X2
    FMOV  D30, X29
    FMOV  V30.D[1], X12
    FMOV  D31, X27
    FMOV  V31.D[1], X26
    MOVZ  X20, #0xa, LSL #0
TaishanSimdPermuteP01_label_0:
    CMLE  V27.2D, V9.2D, #0
    CMEQ  D9, D26, #0
    CMGE  D2, D30, #0
    FCMGT  V21.2S, V10.2S, #0.0
    CMGE  D21, D6, #0
    FACGE  V6.2S, V19.2S, V12.2S
    CMLE  D9, D21, #0
    FCMEQ  V11.2D, V9.2D, V28.2D
    FCMGE  S29, S28, S29
    FCMEQ  V1.2D, V12.2D, V24.2D
    CMGE  V8.16B, V1.16B, #0
    CMGE  D24, D21, #0
    FACGE  D25, D0, D10
    FACGT  V25.2S, V12.2S, V19.2S
    FCMGT  V6.2S, V19.2S, V13.2S
    FCMGE  V12.2D, V11.2D, V15.2D
    FCMGT  D18, D15, D8
    FACGE  V25.2D, V9.2D, V6.2D
    FCMEQ  V2.2S, V24.2S, #0.0
    CMGE  V1.8B, V10.8B, V13.8B
    FCMEQ  D11, D22, D27
    FCMGE  V16.2S, V21.2S, #0.0
    FACGT  V25.2S, V25.2S, V10.2S
    FCMLE  S19, S8, #0.0
    CMEQ  D26, D13, #0
    CMEQ  V5.2S, V8.2S, V16.2S
    FCMLE  V20.2S, V12.2S, #0.0
    CMGE  D5, D15, #0
    CMGE  V31.4H, V25.4H, V1.4H
    CMLE  D0, D11, #0
    CMHS  V7.4H, V29.4H, V22.4H
    CMGE  V28.2S, V4.2S, #0
    FCMEQ  S28, S2, #0.0
    FCMGE  D30, D20, D27
    CMGT  V28.16B, V10.16B, #0
    FCMEQ  V5.2D, V4.2D, V14.2D
    CMGT  D17, D7, #0
    CMHS  D5, D26, D24
    FCMEQ  S23, S5, #0.0
    FACGT  S25, S31, S30
    FCMEQ  D29, D4, D3
    CMHS  D7, D3, D10
    CMGT  D9, D0, #0
    CMLT  V28.16B, V5.16B, #0
    CMHI  V10.8B, V4.8B, V10.8B
    FCMEQ  D18, D5, D29
    FCMGT  S1, S27, S9
    CMGT  D26, D21, D26
    FACGE  S26, S7, S16
    FCMGE  S17, S10, #0.0
    FCMEQ  V22.2S, V25.2S, V23.2S
    CMTST  D31, D30, D16
    FCMGT  V2.2D, V1.2D, #0.0
    FACGT  V0.4S, V21.4S, V2.4S
    FCMGE  V1.2S, V15.2S, V23.2S
    CMGT  D5, D5, D25
    FCMGT  V26.2S, V8.2S, #0.0
    CMHS  D17, D18, D13
    FACGT  V15.4S, V28.4S, V27.4S
    FCMGT  V16.2S, V15.2S, #0.0
    CMGT  V22.8H, V13.8H, V10.8H
    FCMLT  D18, D22, #0.0
    CMGE  D25, D27, D0
    CMHS  D28, D25, D2
    FCMGT  S13, S22, S18
    FCMGT  V6.4S, V29.4S, #0.0
    CMHS  D5, D6, D17
    FCMGT  D29, D5, D19
    CMEQ  V17.8H, V18.8H, V26.8H
    FCMGE  S15, S12, #0.0
    FACGE  V25.2S, V2.2S, V22.2S
    FCMEQ  D1, D31, #0.0
    FACGT  D30, D10, D22
    CMEQ  V11.2S, V18.2S, #0
    FACGE  D13, D10, D12
    CMLT  D25, D11, #0
    FACGE  S21, S0, S18
    CMTST  D17, D2, D11
    FCMEQ  D6, D1, #0.0
    FCMGE  S9, S12, #0.0
    CMGT  V21.4S, V6.4S, #0
    CMHI  D25, D26, D18
    FACGT  V24.2D, V16.2D, V28.2D
    FCMGE  D29, D16, D3
    FCMLT  V27.2S, V4.2S, #0.0
    FCMGT  S12, S22, #0.0
    CMEQ  D8, D4, #0
    CMEQ  V13.4S, V18.4S, V11.4S
    FCMLE  S28, S14, #0.0
    FCMEQ  S25, S9, #0.0
    FCMGT  D5, D26, D29
    CMEQ  D17, D9, #0
    CMHS  V25.2D, V11.2D, V7.2D
    CMLE  D0, D5, #0
    CMTST  D19, D12, D16
    FCMGE  S24, S4, #0.0
    FCMGT  S15, S30, #0.0
    CMTST  V14.2D, V7.2D, V7.2D
    CMEQ  D6, D13, #0
    FCMLE  D28, D13, #0.0
    FCMLT  V22.4S, V5.4S, #0.0
    CMGE  V11.16B, V13.16B, V6.16B
    FCMGT  V16.4S, V16.4S, V0.4S
    FACGT  D26, D21, D27
    FCMGT  S29, S29, S24
    FCMGT  S29, S29, S12
    FCMGT  S12, S6, S29
    FACGT  D15, D4, D6
    CMHS  V7.2D, V8.2D, V2.2D
    CMEQ  D25, D16, #0
    CMHS  V20.2D, V12.2D, V17.2D
    FACGT  D4, D24, D12
    FACGT  S26, S5, S19
    FACGT  V14.2S, V30.2S, V20.2S
    CMTST  D6, D21, D13
    CMLT  V9.2S, V10.2S, #0
    FCMGE  D26, D25, D27
    CMGE  V26.2D, V16.2D, #0
    CMHI  V11.2S, V10.2S, V0.2S
    FCMLT  S17, S15, #0.0
    FACGT  S30, S17, S25
    CMLT  V5.8B, V5.8B, #0
    CMLT  V18.8B, V6.8B, #0
    CMLE  D28, D20, #0
    FCMGE  S19, S6, #0.0
    CMGT  V19.4H, V30.4H, #0
    CMEQ  D27, D23, D13
    CMLE  D4, D12, #0
    CMLE  V17.4H, V18.4H, #0
    FCMGE  S28, S9, S27
    CMGT  V18.2D, V16.2D, V26.2D
    FCMGT  D14, D28, D26
    CMEQ  D5, D3, D15
    FCMGE  S31, S27, S4
    CMEQ  V13.4S, V14.4S, V11.4S
    CMEQ  D13, D21, #0
    CMGE  V25.2D, V26.2D, #0
    FCMLE  S25, S5, #0.0
    CMGE  V29.8B, V28.8B, V24.8B
    FCMLT  S31, S27, #0.0
    FCMLT  D23, D31, #0.0
    FCMLE  V17.2S, V6.2S, #0.0
    FCMGE  V10.2D, V30.2D, #0.0
    CMGE  V3.2S, V12.2S, V2.2S
    FCMGE  V5.2S, V31.2S, V5.2S
    CMGE  V18.16B, V11.16B, V31.16B
    CMGE  V11.4S, V26.4S, #0
    FCMGT  V9.2S, V8.2S, V3.2S
    FCMGE  D31, D9, #0.0
    CMLT  V4.8H, V4.8H, #0
    CMTST  V22.2S, V6.2S, V11.2S
    FCMGE  V25.2S, V31.2S, V10.2S
    FACGT  V13.2D, V30.2D, V8.2D
    FCMGT  S13, S22, S2
    FCMEQ  V9.2S, V0.2S, #0.0
    FCMGT  V19.4S, V6.4S, V19.4S
    FCMGE  D18, D3, D1
    CMGE  D25, D26, D29
    FCMGE  D25, D0, #0.0
    FCMEQ  D16, D8, D22
    CMGE  D1, D7, D25
    FCMLE  S6, S2, #0.0
    FCMLE  V29.2S, V0.2S, #0.0
    CMTST  D3, D3, D28
    CMHS  V25.2D, V6.2D, V30.2D
    FCMEQ  S0, S27, #0.0
    FCMEQ  V26.4S, V26.4S, #0.0
    FCMEQ  D5, D27, #0.0
    FCMEQ  D12, D10, #0.0
    CMEQ  V22.4H, V17.4H, #0
    CMLE  V21.4S, V6.4S, #0
    FACGE  S0, S3, S28
    FCMEQ  D14, D9, #0.0
    FCMEQ  V17.2S, V27.2S, #0.0
    FCMGE  S2, S26, #0.0
    FCMGT  V6.2S, V2.2S, #0.0
    CMEQ  V11.16B, V30.16B, V16.16B
    CMLE  D25, D17, #0
    CMEQ  D7, D10, D7
    CMLE  V3.16B, V21.16B, #0
    FCMGT  V21.4S, V26.4S, V8.4S
    CMHI  V5.8H, V22.8H, V28.8H
    FACGT  S15, S31, S27
    FCMEQ  S0, S2, S6
    CMGT  D17, D10, #0
    CMEQ  V4.8H, V24.8H, #0
    FCMGE  V12.2D, V25.2D, #0.0
    FACGE  D25, D14, D21
    FACGT  V23.2S, V29.2S, V23.2S
    FCMLT  D4, D7, #0.0
    FCMEQ  S4, S27, S14
    CMLT  V4.2D, V16.2D, #0
    CMEQ  V29.2S, V2.2S, #0
    CMLT  V23.16B, V30.16B, #0
    CMGE  D19, D11, D4
    CMLT  V28.2S, V24.2S, #0
    CMEQ  D21, D25, #0
    FCMEQ  D21, D10, D5
    CMLE  V27.16B, V26.16B, #0
    CMEQ  V0.2D, V16.2D, V2.2D
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdPermuteP01_label_0
    MOVZ  X13, #0x53bd, LSL #0
    MOVK  X13, #0xb28b, LSL #16
    MOVK  X13, #0x889e, LSL #32
    MOVK  X13, #0x329e, LSL #48
    SUB  X16, X13, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0xe2e9, LSL #0
    MOVK  X27, #0xcf6, LSL #16
    MOVK  X27, #0xe4d8, LSL #32
    MOVK  X27, #0xa9d7, LSL #48
    SUB  X28, X27, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x1bb4, LSL #0
    MOVK  X10, #0x27e9, LSL #16
    MOVK  X10, #0x8a2f, LSL #32
    MOVK  X10, #0x1cf5, LSL #48
    SUB  X25, X10, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0xed3d, LSL #0
    MOVK  X4, #0xd26d, LSL #16
    MOVK  X4, #0x17be, LSL #32
    MOVK  X4, #0x5696, LSL #48
    SUB  X27, X4, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x63f7, LSL #0
    MOVK  X13, #0x2d23, LSL #16
    MOVK  X13, #0x6330, LSL #32
    MOVK  X13, #0x67f2, LSL #48
    SUB  X12, X13, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x141d, LSL #0
    MOVK  X11, #0xc537, LSL #16
    MOVK  X11, #0xacdb, LSL #32
    MOVK  X11, #0x45d, LSL #48
    SUB  X9, X11, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x44d8, LSL #0
    MOVK  X7, #0x3f7f, LSL #16
    MOVK  X7, #0x29d1, LSL #32
    MOVK  X7, #0xc9a, LSL #48
    SUB  X26, X7, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X9
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x1bb4, LSL #0
    MOVK  X25, #0x27e9, LSL #16
    MOVK  X25, #0x8a2f, LSL #32
    MOVK  X25, #0x1cf5, LSL #48
    SUB  X5, X25, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x141d, LSL #0
    MOVK  X4, #0xc537, LSL #16
    MOVK  X4, #0xacdb, LSL #32
    MOVK  X4, #0x45d, LSL #48
    SUB  X29, X4, X11
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x63f7, LSL #0
    MOVK  X2, #0x2d23, LSL #16
    MOVK  X2, #0x6330, LSL #32
    MOVK  X2, #0x67f2, LSL #48
    SUB  X6, X2, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x6973, LSL #0
    MOVK  X28, #0xe20b, LSL #16
    MOVK  X28, #0xd529, LSL #32
    MOVK  X28, #0x6, LSL #48
    SUB  X9, X28, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xda7f, LSL #0
    MOVK  X9, #0x52a5, LSL #16
    MOVK  X9, #0x4d5d, LSL #32
    MOVK  X9, #0x12cb, LSL #48
    SUB  X16, X9, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X25, X9, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0xa4ae, LSL #0
    MOVK  X29, #0x3872, LSL #16
    MOVK  X29, #0x2266, LSL #32
    MOVK  X29, #0x8fbe, LSL #48
    SUB  X21, X29, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X24, X9, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D2
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X22, X20, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X7, X26, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D3
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X7, X26, X16
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D4
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X17, X12, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D6
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D7
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X28, X9, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D8
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D9
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X23, X12, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D10
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X23, X12, X21
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X5, X6, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X8, X13, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D14
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X28, X3, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D16
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X23, X12, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D18
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D19
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X25, X7, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X5, X18, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D22
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D23
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D25
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X6, X10, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D27
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X6, X10, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D29
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X5, X11, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
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
    FMOV  D1, X2
    FMOV  V1.D[1], X16
    FMOV  D2, X23
    FMOV  V2.D[1], X5
    FMOV  D3, X12
    FMOV  V3.D[1], X14
    FMOV  D4, X21
    FMOV  V4.D[1], X5
    FMOV  D5, X16
    FMOV  V5.D[1], X25
    FMOV  D6, X24
    FMOV  V6.D[1], X26
    FMOV  D7, X4
    FMOV  V7.D[1], X13
    FMOV  D8, X28
    FMOV  V8.D[1], X21
    FMOV  D9, X29
    FMOV  V9.D[1], X29
    FMOV  D10, X20
    FMOV  V10.D[1], X19
    FMOV  D11, X17
    FMOV  V11.D[1], X2
    FMOV  D12, X7
    FMOV  V12.D[1], X18
    FMOV  D13, X20
    FMOV  V13.D[1], X19
    FMOV  D14, X14
    FMOV  V14.D[1], X28
    FMOV  D15, X21
    FMOV  V15.D[1], X9
    FMOV  D16, X20
    FMOV  V16.D[1], X7
    FMOV  D17, X22
    FMOV  V17.D[1], X7
    FMOV  D18, X23
    FMOV  V18.D[1], X21
    FMOV  D19, X26
    FMOV  V19.D[1], X8
    FMOV  D20, X2
    FMOV  V20.D[1], X21
    FMOV  D21, X14
    FMOV  V21.D[1], X18
    FMOV  D22, X19
    FMOV  V22.D[1], X13
    FMOV  D23, X19
    FMOV  V23.D[1], X4
    FMOV  D24, X2
    FMOV  V24.D[1], X14
    FMOV  D25, X6
    FMOV  V25.D[1], X20
    FMOV  D26, X20
    FMOV  V26.D[1], X2
    FMOV  D27, X19
    FMOV  V27.D[1], X27
    FMOV  D28, X13
    FMOV  V28.D[1], X3
    FMOV  D29, X8
    FMOV  V29.D[1], X25
    FMOV  D30, X12
    FMOV  V30.D[1], X14
    FMOV  D31, X5
    FMOV  V31.D[1], X6
    MOVZ  X29, #0xa, LSL #0
TaishanSimdPermuteP01_label_83:
    FCMLE  D24, D23, #0.0
    FCMGT  S22, S11, #0.0
    FACGT  D28, D3, D8
    FACGT  D20, D11, D31
    FCMLE  V14.2D, V7.2D, #0.0
    CMEQ  V26.2S, V1.2S, V24.2S
    FCMLT  S5, S8, #0.0
    CMEQ  V27.2S, V17.2S, V2.2S
    CMLE  V29.2S, V6.2S, #0
    FCMGT  D27, D0, D25
    FCMLT  D20, D9, #0.0
    FCMEQ  V29.2S, V20.2S, #0.0
    FCMEQ  V31.2S, V19.2S, V16.2S
    CMLT  D9, D6, #0
    FCMEQ  D13, D28, D11
    CMEQ  D28, D5, #0
    CMLE  V5.4H, V22.4H, #0
    FCMGE  D6, D31, D1
    CMHS  D31, D9, D27
    FCMGE  V6.4S, V24.4S, V0.4S
    CMGT  D7, D14, #0
    CMGE  V20.8B, V27.8B, V28.8B
    CMGE  V25.8B, V10.8B, #0
    FCMEQ  V6.4S, V3.4S, V23.4S
    FCMEQ  V23.2D, V28.2D, V10.2D
    CMHI  D11, D15, D4
    FCMGT  D31, D16, #0.0
    FCMGT  D23, D7, D17
    FCMGE  S17, S16, #0.0
    CMGE  V29.16B, V9.16B, V12.16B
    FCMEQ  S31, S11, #0.0
    CMGE  V9.16B, V13.16B, V10.16B
    CMGT  D5, D30, #0
    FCMGT  S26, S21, #0.0
    FCMGT  V15.2D, V18.2D, #0.0
    FCMLE  V29.2D, V0.2D, #0.0
    FCMEQ  S29, S13, S14
    CMLE  V21.2D, V9.2D, #0
    FCMGE  S14, S14, S11
    FCMGE  D22, D23, D6
    FCMGE  S12, S23, #0.0
    FACGE  V21.2S, V7.2S, V9.2S
    FCMGE  V5.2S, V13.2S, V19.2S
    CMEQ  V6.8B, V11.8B, V23.8B
    CMTST  D18, D4, D5
    CMGT  D3, D26, #0
    CMEQ  D25, D10, #0
    CMHI  V4.8H, V4.8H, V0.8H
    CMHS  D10, D26, D17
    CMEQ  V4.4H, V31.4H, #0
    FCMGE  S31, S22, S10
    CMGT  V10.4H, V27.4H, #0
    FCMEQ  D15, D12, D2
    FCMGT  V14.2D, V13.2D, #0.0
    CMLE  D11, D26, #0
    FACGE  S8, S3, S16
    CMEQ  V1.4H, V11.4H, #0
    CMGE  D0, D16, #0
    CMHI  V29.16B, V30.16B, V29.16B
    FCMGE  S31, S9, S13
    FCMEQ  S16, S28, S17
    FCMGE  V9.2D, V13.2D, #0.0
    CMLE  V24.2D, V10.2D, #0
    FACGT  S11, S24, S2
    CMTST  D22, D20, D5
    CMGT  D26, D24, D30
    FCMGT  D6, D17, D0
    FCMLT  V0.2S, V10.2S, #0.0
    CMEQ  V23.8B, V29.8B, #0
    CMLT  D20, D7, #0
    FCMGE  D12, D5, D22
    FCMLE  D9, D11, #0.0
    CMHS  V9.4H, V29.4H, V0.4H
    CMLT  D22, D5, #0
    FACGE  D28, D17, D7
    FCMGT  V31.2S, V29.2S, #0.0
    FCMGE  S5, S31, S0
    FCMLE  D3, D31, #0.0
    FCMEQ  V17.2D, V31.2D, #0.0
    FCMGE  S23, S8, S22
    FACGE  S6, S27, S5
    CMGE  V6.16B, V26.16B, V15.16B
    FCMEQ  D29, D14, #0.0
    FCMLE  V12.2D, V26.2D, #0.0
    FCMGE  V6.2D, V25.2D, #0.0
    FCMEQ  V6.2D, V13.2D, #0.0
    FCMLE  D18, D3, #0.0
    FCMGT  D14, D17, #0.0
    CMEQ  V0.8B, V8.8B, #0
    CMGT  V13.4S, V6.4S, #0
    FCMGT  V12.4S, V23.4S, V2.4S
    CMTST  D27, D28, D22
    FACGE  D19, D23, D15
    CMEQ  D7, D24, D20
    CMLE  D16, D5, #0
    CMGE  D14, D7, #0
    CMEQ  D25, D11, D1
    FCMGE  V23.4S, V22.4S, V22.4S
    CMHI  D19, D24, D24
    CMLT  D6, D15, #0
    CMGT  D11, D5, #0
    FCMEQ  D8, D21, D25
    CMGT  D26, D9, D26
    CMLE  V16.8B, V9.8B, #0
    FCMGE  S7, S3, S18
    FACGE  D21, D17, D6
    FCMGT  V19.2D, V2.2D, #0.0
    CMHI  D8, D1, D9
    CMHI  V28.2S, V9.2S, V6.2S
    CMLT  V17.8H, V13.8H, #0
    FACGT  S1, S11, S14
    FACGT  D7, D29, D2
    CMGE  V23.16B, V23.16B, #0
    FACGT  V26.2D, V28.2D, V8.2D
    CMGE  D28, D6, D3
    FCMGE  S13, S19, #0.0
    FCMGE  V16.2S, V29.2S, V28.2S
    CMHS  D15, D5, D24
    FCMGT  V26.2S, V0.2S, #0.0
    CMLT  D31, D13, #0
    CMEQ  V21.2D, V24.2D, V1.2D
    FCMGT  V31.2D, V9.2D, #0.0
    CMHI  D19, D17, D8
    CMLT  D12, D25, #0
    CMHS  V20.8B, V23.8B, V11.8B
    CMGE  D24, D16, #0
    CMEQ  V20.4S, V15.4S, #0
    FCMGT  D20, D22, #0.0
    CMEQ  D31, D1, #0
    CMHS  V20.2S, V24.2S, V27.2S
    CMTST  D6, D31, D26
    CMTST  V2.8B, V9.8B, V15.8B
    FACGE  D6, D20, D9
    FCMGT  V20.2S, V15.2S, #0.0
    CMLT  V8.8H, V3.8H, #0
    FCMEQ  V31.4S, V18.4S, #0.0
    CMGE  V5.2S, V15.2S, V14.2S
    CMHS  V16.16B, V5.16B, V24.16B
    FCMGE  V17.4S, V25.4S, #0.0
    FCMGT  D21, D14, #0.0
    FCMGT  D5, D16, D13
    FCMEQ  D14, D14, D4
    CMGE  V24.8B, V14.8B, V24.8B
    FCMGE  V6.4S, V8.4S, #0.0
    FCMGE  V0.2D, V13.2D, #0.0
    CMEQ  V25.4H, V18.4H, V31.4H
    CMGE  V25.8B, V23.8B, #0
    FCMEQ  S14, S16, #0.0
    CMHI  V16.2D, V12.2D, V15.2D
    FCMEQ  D1, D17, #0.0
    FCMEQ  D12, D8, #0.0
    FCMGT  S19, S0, #0.0
    FCMLE  D25, D18, #0.0
    FCMGT  D27, D12, #0.0
    FCMGE  D16, D21, #0.0
    CMGT  D5, D4, #0
    FACGE  S31, S15, S9
    FCMEQ  D31, D29, #0.0
    CMTST  D9, D24, D19
    FCMGE  S31, S27, #0.0
    FCMLE  D3, D7, #0.0
    FCMGT  S27, S16, S12
    CMHS  V0.16B, V18.16B, V20.16B
    CMTST  V4.8H, V8.8H, V15.8H
    CMLT  V4.16B, V21.16B, #0
    CMGE  V29.8B, V10.8B, V2.8B
    FCMGT  S2, S28, S10
    FCMLE  V6.2D, V2.2D, #0.0
    CMLT  V0.2S, V15.2S, #0
    FCMGE  D7, D0, #0.0
    FCMGT  D27, D24, #0.0
    CMLE  D28, D31, #0
    FCMGE  V26.4S, V21.4S, V22.4S
    CMGT  D21, D17, #0
    FCMGT  S18, S9, S30
    FCMGT  V22.2D, V28.2D, V26.2D
    CMLT  D6, D1, #0
    CMTST  V30.16B, V25.16B, V27.16B
    CMGE  V4.8B, V16.8B, #0
    FCMGE  D8, D23, #0.0
    FCMGT  S23, S29, #0.0
    FCMLE  V13.2S, V18.2S, #0.0
    CMGE  V22.2S, V24.2S, #0
    FCMEQ  S0, S20, #0.0
    CMGT  D9, D21, D16
    FCMEQ  V0.4S, V30.4S, V15.4S
    CMHS  V21.4H, V8.4H, V1.4H
    FACGE  D30, D20, D19
    FCMGT  V13.4S, V31.4S, #0.0
    FCMGE  D15, D1, D3
    FCMLE  D19, D13, #0.0
    FCMGE  V21.4S, V15.4S, V31.4S
    CMGT  V25.4S, V19.4S, #0
    CMHI  D7, D2, D23
    FCMEQ  S15, S17, S5
    CMHI  V4.8H, V16.8H, V30.8H
    FCMGE  V18.4S, V22.4S, #0.0
    FCMGT  D31, D25, #0.0
    CMGE  D14, D4, #0
    FCMGE  V25.2S, V27.2S, V14.2S
    SUBS  X29, X29, #0x1
    B.NE  TaishanSimdPermuteP01_label_83
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X8, X29, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X11, X14, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D3
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X25, X27, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D4
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D6
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X29, X17, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D8
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X9, X11, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D9
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X17, X20, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X12
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D11
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X28, X4, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X7, X26, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D14
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X7, X26, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D16
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X20, X5, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X13, X24, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X13, X24, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X25, X4, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D18
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X25, X4, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D19
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X16, X23, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X14, X13, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D21
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X14, X13, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D22
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D24
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X13, X9, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D26
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X22, X28, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D28
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D29
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X27, X22, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X24
    FMOV  D1, X2
    FMOV  V1.D[1], X5
    FMOV  D2, X19
    FMOV  V2.D[1], X7
    FMOV  D3, X25
    FMOV  V3.D[1], X28
    FMOV  D4, X29
    FMOV  V4.D[1], X16
    FMOV  D5, X28
    FMOV  V5.D[1], X17
    FMOV  D6, X13
    FMOV  V6.D[1], X5
    FMOV  D7, X18
    FMOV  V7.D[1], X21
    FMOV  D8, X18
    FMOV  V8.D[1], X17
    FMOV  D9, X14
    FMOV  V9.D[1], X23
    FMOV  D10, X13
    FMOV  V10.D[1], X22
    FMOV  D11, X22
    FMOV  V11.D[1], X27
    FMOV  D12, X7
    FMOV  V12.D[1], X3
    FMOV  D13, X11
    FMOV  V13.D[1], X22
    FMOV  D14, X10
    FMOV  V14.D[1], X27
    FMOV  D15, X17
    FMOV  V15.D[1], X7
    FMOV  D16, X29
    FMOV  V16.D[1], X20
    FMOV  D17, X16
    FMOV  V17.D[1], X29
    FMOV  D18, X11
    FMOV  V18.D[1], X27
    FMOV  D19, X11
    FMOV  V19.D[1], X4
    FMOV  D20, X13
    FMOV  V20.D[1], X20
    FMOV  D21, X26
    FMOV  V21.D[1], X8
    FMOV  D22, X23
    FMOV  V22.D[1], X20
    FMOV  D23, X8
    FMOV  V23.D[1], X10
    FMOV  D24, X2
    FMOV  V24.D[1], X25
    FMOV  D25, X10
    FMOV  V25.D[1], X25
    FMOV  D26, X29
    FMOV  V26.D[1], X5
    FMOV  D27, X6
    FMOV  V27.D[1], X6
    FMOV  D28, X28
    FMOV  V28.D[1], X16
    FMOV  D29, X5
    FMOV  V29.D[1], X23
    FMOV  D30, X23
    FMOV  V30.D[1], X6
    FMOV  D31, X6
    FMOV  V31.D[1], X4
    MOVZ  X19, #0xf, LSL #0
TaishanSimdPermuteP01_label_165:
    CMEQ  D7, D17, #0
    FCMEQ  D11, D18, D31
    FCMLE  V3.4S, V4.4S, #0.0
    FCMGT  S21, S17, S10
    FCMLT  D28, D20, #0.0
    FCMGT  D21, D9, D7
    FCMEQ  V16.2S, V4.2S, V11.2S
    FACGE  V25.2S, V28.2S, V4.2S
    CMGE  D16, D27, #0
    CMGT  V8.16B, V12.16B, #0
    CMHS  D7, D25, D29
    CMGT  D8, D0, #0
    CMLE  D26, D10, #0
    CMLT  D28, D24, #0
    CMGT  V8.8H, V3.8H, #0
    CMHS  V6.16B, V12.16B, V15.16B
    CMHI  D5, D18, D17
    FCMGT  V6.4S, V4.4S, #0.0
    CMEQ  D8, D1, D6
    CMGT  D31, D21, #0
    CMGE  V26.4H, V23.4H, #0
    FCMGT  D17, D21, #0.0
    CMTST  V29.8B, V21.8B, V18.8B
    CMLT  D7, D27, #0
    FCMGE  S5, S31, #0.0
    CMGT  V15.8H, V2.8H, #0
    FACGT  S11, S0, S15
    FCMGE  S22, S25, #0.0
    FCMLT  D21, D15, #0.0
    FACGE  S24, S12, S14
    CMGT  V20.16B, V29.16B, #0
    FCMGT  D20, D3, D22
    FCMLT  D3, D18, #0.0
    FCMGT  S4, S29, S4
    FCMLT  D26, D22, #0.0
    CMGT  D28, D31, #0
    CMLE  D4, D0, #0
    FCMLT  V6.4S, V16.4S, #0.0
    CMEQ  D15, D21, D27
    FCMGT  S18, S26, #0.0
    FACGE  D3, D1, D10
    FCMLE  V27.2D, V11.2D, #0.0
    FCMGE  V19.4S, V1.4S, V7.4S
    FCMLE  S6, S24, #0.0
    FCMGT  S18, S17, S28
    FCMEQ  S23, S20, S12
    FCMGE  S26, S18, S19
    FCMLT  S14, S3, #0.0
    CMEQ  D12, D10, #0
    FCMLT  V28.2D, V17.2D, #0.0
    FCMGT  V17.4S, V1.4S, V30.4S
    CMEQ  V2.4H, V6.4H, #0
    FACGT  V10.2D, V3.2D, V18.2D
    FCMLT  S4, S18, #0.0
    FCMGT  V12.4S, V31.4S, V24.4S
    FCMGT  V12.2S, V27.2S, V6.2S
    FCMLE  S28, S10, #0.0
    FCMGT  D16, D29, #0.0
    CMTST  D18, D21, D20
    FCMGT  V30.4S, V0.4S, V11.4S
    FCMLE  S26, S14, #0.0
    FCMLT  D1, D9, #0.0
    FCMGT  S28, S24, S23
    FACGT  V4.4S, V15.4S, V15.4S
    CMLT  V1.8H, V17.8H, #0
    FACGT  S1, S9, S7
    CMLE  V20.8H, V19.8H, #0
    CMGE  D19, D0, #0
    FCMEQ  D12, D8, #0.0
    FCMGE  S27, S28, S25
    CMTST  D15, D10, D31
    CMHS  V20.8B, V4.8B, V6.8B
    CMGT  D1, D6, #0
    FCMEQ  D20, D11, #0.0
    CMGE  V12.4H, V25.4H, #0
    CMGE  D16, D8, #0
    CMLE  V19.8B, V1.8B, #0
    FCMGT  V26.4S, V28.4S, #0.0
    CMGT  D5, D7, #0
    CMGE  D15, D2, #0
    FCMEQ  S12, S0, #0.0
    FCMGT  V9.2D, V15.2D, #0.0
    FACGT  V30.2S, V7.2S, V25.2S
    CMEQ  D30, D13, #0
    FACGE  D14, D17, D1
    CMHI  V26.16B, V25.16B, V1.16B
    FCMEQ  D31, D19, #0.0
    FACGT  D8, D19, D23
    FACGE  V17.4S, V13.4S, V24.4S
    FCMGT  D15, D31, #0.0
    FACGT  D2, D3, D9
    FCMGT  V0.4S, V2.4S, #0.0
    CMEQ  D17, D0, #0
    CMLE  V25.4H, V31.4H, #0
    FCMEQ  V23.4S, V11.4S, V13.4S
    FCMGE  S26, S7, #0.0
    FCMGT  D18, D24, D25
    CMLE  D1, D31, #0
    FCMLE  V5.2D, V6.2D, #0.0
    FCMGT  S1, S31, S10
    FCMLT  D31, D21, #0.0
    CMGT  D26, D18, D19
    FCMLE  D15, D5, #0.0
    CMHS  V10.16B, V26.16B, V18.16B
    FACGE  S25, S25, S23
    CMTST  V24.8B, V11.8B, V20.8B
    FCMGE  D14, D17, D4
    FCMGT  V23.2D, V24.2D, #0.0
    FACGE  V24.2S, V4.2S, V24.2S
    FCMEQ  D2, D15, D16
    CMHI  V1.4S, V18.4S, V2.4S
    FACGE  V20.2D, V9.2D, V1.2D
    FCMLT  D24, D14, #0.0
    FACGE  V10.2D, V22.2D, V4.2D
    FCMGT  S11, S10, S24
    FCMLT  D23, D20, #0.0
    FCMEQ  S11, S12, #0.0
    FACGT  S20, S5, S8
    FCMGE  V3.2D, V6.2D, V6.2D
    FCMLE  S13, S17, #0.0
    FCMGE  V12.2S, V3.2S, V25.2S
    CMTST  V21.4H, V18.4H, V2.4H
    FCMEQ  D19, D17, D31
    FCMLE  V4.4S, V11.4S, #0.0
    FCMGE  S4, S20, #0.0
    CMGT  D12, D10, #0
    FCMGT  V12.4S, V15.4S, #0.0
    CMGE  V12.8H, V17.8H, #0
    CMLT  D31, D9, #0
    FCMGE  D21, D31, #0.0
    FCMLE  S13, S7, #0.0
    CMHS  V29.8H, V11.8H, V23.8H
    FCMLE  V4.2D, V9.2D, #0.0
    FCMLT  S29, S5, #0.0
    CMGT  V26.8B, V7.8B, V19.8B
    FCMGT  D13, D12, D6
    FCMGT  D26, D21, D6
    CMGE  D0, D23, #0
    CMHS  D0, D16, D30
    FCMEQ  V26.2S, V7.2S, #0.0
    CMHS  D13, D25, D13
    FACGE  S4, S14, S12
    CMLE  D22, D4, #0
    FCMEQ  S29, S10, #0.0
    CMLE  V26.8B, V31.8B, #0
    CMLE  V12.8B, V28.8B, #0
    CMHS  D26, D13, D20
    FCMGE  D0, D29, #0.0
    CMHI  D23, D31, D30
    FCMGT  S6, S17, #0.0
    FCMGT  S15, S13, S2
    FCMLE  D16, D13, #0.0
    FACGT  S18, S5, S17
    FCMLT  V18.4S, V13.4S, #0.0
    CMEQ  D30, D28, #0
    CMEQ  V21.4S, V7.4S, V22.4S
    FCMLT  S4, S14, #0.0
    CMGT  V23.4H, V21.4H, V10.4H
    FCMGT  S22, S8, #0.0
    FCMEQ  S17, S13, #0.0
    FACGE  V25.2S, V27.2S, V3.2S
    FCMGT  V27.4S, V5.4S, #0.0
    CMHS  V4.16B, V22.16B, V25.16B
    CMLT  V3.2D, V24.2D, #0
    FCMGT  D26, D17, D17
    FCMLT  S5, S29, #0.0
    FCMLT  D20, D23, #0.0
    CMTST  D28, D21, D26
    CMLT  V22.8H, V18.8H, #0
    FCMLT  V6.2D, V20.2D, #0.0
    FACGT  V25.2S, V2.2S, V27.2S
    FACGT  D24, D7, D0
    FCMLT  V6.2S, V9.2S, #0.0
    CMEQ  V12.16B, V30.16B, #0
    FCMLT  S9, S29, #0.0
    FCMGE  S13, S14, #0.0
    CMGE  V18.2S, V17.2S, V18.2S
    FACGT  D3, D28, D18
    FCMEQ  D6, D4, D2
    FCMLE  V2.2S, V3.2S, #0.0
    FCMGT  V22.4S, V27.4S, #0.0
    FCMGT  S26, S30, S6
    FCMEQ  D10, D5, #0.0
    FACGT  S7, S1, S26
    FCMGE  S9, S17, S25
    FACGE  V19.2S, V1.2S, V6.2S
    FCMLE  S29, S3, #0.0
    FCMEQ  V19.4S, V14.4S, V30.4S
    CMGE  V27.4S, V28.4S, #0
    FCMEQ  V0.2S, V16.2S, #0.0
    FACGE  S18, S0, S8
    FCMLE  V4.4S, V30.4S, #0.0
    FCMGE  V12.2S, V27.2S, #0.0
    FACGE  V9.2D, V11.2D, V15.2D
    FCMEQ  V2.2D, V19.2D, V6.2D
    CMGE  V19.2S, V13.2S, #0
    FCMGE  V19.2D, V30.2D, V21.2D
    CMLE  D26, D31, #0
    FCMGE  D20, D0, #0.0
    FCMGT  V19.4S, V21.4S, #0.0
    SUBS  X19, X19, #0x1
    B.NE  TaishanSimdPermuteP01_label_165
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X6, X17, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X13, X8, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X8, X4, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X7, X26, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X16, X27, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X8, X29, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X21, X22, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X16, X21, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X14, X21, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X12, X16, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X24, X6, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X8, X14, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X17, X10, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X24
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X6, X8, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X19, X18, X26
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X4, X29, X27
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X27, X29, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D2
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X16, X12, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D3
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X7, X19, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D4
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D6
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D8
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D9
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D10
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X3, X22, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D11
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    SUB  X21, X12, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D13
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X21, X18, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D14
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D17
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D18
    MOVZ  X10, #0x0, LSL #0
    SUB  X9, X10, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D19
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X4, X6, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D23
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X5, X12, X9
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D26
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X2, X4, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X11, X17, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D27
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X11, X17, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X7, X5, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D29
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X7, X5, X14
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xeda5, LSL #0
    MOVK  X2, #0x16ad, LSL #16
    MOVK  X2, #0x1250, LSL #32
    MOVK  X2, #0x71bb, LSL #48
    MOVZ  X3, #0x83cb, LSL #0
    MOVK  X3, #0x47b4, LSL #16
    MOVK  X3, #0xa4fc, LSL #32
    MOVK  X3, #0xd919, LSL #48
    MOVZ  X4, #0x5893, LSL #0
    MOVK  X4, #0x73ec, LSL #16
    MOVK  X4, #0x2c90, LSL #32
    MOVK  X4, #0x47f3, LSL #48
    MOVZ  X5, #0x41cb, LSL #0
    MOVK  X5, #0x6154, LSL #16
    MOVK  X5, #0x84d6, LSL #32
    MOVK  X5, #0x2a0, LSL #48
    MOVZ  X6, #0x6cde, LSL #0
    MOVK  X6, #0x142c, LSL #16
    MOVK  X6, #0x2a63, LSL #32
    MOVK  X6, #0x5a05, LSL #48
    MOVZ  X7, #0xbfdb, LSL #0
    MOVK  X7, #0x2a92, LSL #16
    MOVK  X7, #0x4f57, LSL #32
    MOVK  X7, #0xf081, LSL #48
    MOVZ  X8, #0xd6ab, LSL #0
    MOVK  X8, #0x9354, LSL #16
    MOVK  X8, #0x8b2, LSL #32
    MOVK  X8, #0x767f, LSL #48
    MOVZ  X9, #0xeda3, LSL #0
    MOVK  X9, #0x656f, LSL #16
    MOVK  X9, #0xed82, LSL #32
    MOVK  X9, #0x61f5, LSL #48
    MOVZ  X10, #0xdbe9, LSL #0
    MOVK  X10, #0xde3e, LSL #16
    MOVK  X10, #0xbdf1, LSL #32
    MOVK  X10, #0xfe5, LSL #48
    MOVZ  X11, #0xceee, LSL #0
    MOVK  X11, #0x136d, LSL #16
    MOVK  X11, #0x79d2, LSL #32
    MOVK  X11, #0xd027, LSL #48
    MOVZ  X12, #0x28dc, LSL #0
    MOVK  X12, #0xb45c, LSL #16
    MOVK  X12, #0x15d5, LSL #32
    MOVK  X12, #0x4be3, LSL #48
    MOVZ  X13, #0x871f, LSL #0
    MOVK  X13, #0x1c3f, LSL #16
    MOVK  X13, #0x910e, LSL #32
    MOVK  X13, #0xfa7, LSL #48
    MOVZ  X14, #0x7993, LSL #0
    MOVK  X14, #0xd2dc, LSL #16
    MOVK  X14, #0x2f0a, LSL #32
    MOVK  X14, #0x3d82, LSL #48
    MOVZ  X16, #0xc2d5, LSL #0
    MOVK  X16, #0x8933, LSL #16
    MOVK  X16, #0xf09d, LSL #32
    MOVK  X16, #0x9132, LSL #48
    MOVZ  X17, #0x25d2, LSL #0
    MOVK  X17, #0x8ea5, LSL #16
    MOVK  X17, #0x9347, LSL #32
    MOVK  X17, #0xfffe, LSL #48
    MOVZ  X18, #0xc29f, LSL #0
    MOVK  X18, #0x4781, LSL #16
    MOVK  X18, #0x281f, LSL #32
    MOVK  X18, #0x9575, LSL #48
    MOVZ  X19, #0x8f83, LSL #0
    MOVK  X19, #0x3679, LSL #16
    MOVK  X19, #0xdb91, LSL #32
    MOVK  X19, #0xad15, LSL #48
    MOVZ  X20, #0x3f63, LSL #0
    MOVK  X20, #0xc3eb, LSL #16
    MOVK  X20, #0xc43c, LSL #32
    MOVK  X20, #0xfbbd, LSL #48
    MOVZ  X21, #0x8a8d, LSL #0
    MOVK  X21, #0xc89b, LSL #16
    MOVK  X21, #0x47ad, LSL #32
    MOVK  X21, #0xc74c, LSL #48
    MOVZ  X22, #0xa71e, LSL #0
    MOVK  X22, #0x2a56, LSL #16
    MOVK  X22, #0xeeff, LSL #32
    MOVK  X22, #0xa2e5, LSL #48
    MOVZ  X23, #0x6168, LSL #0
    MOVK  X23, #0x9c0e, LSL #16
    MOVK  X23, #0xd9fb, LSL #32
    MOVK  X23, #0x3985, LSL #48
    MOVZ  X24, #0xbcc4, LSL #0
    MOVK  X24, #0x64b1, LSL #16
    MOVK  X24, #0x48d3, LSL #32
    MOVK  X24, #0xe66d, LSL #48
    MOVZ  X25, #0xd6f5, LSL #0
    MOVK  X25, #0x9912, LSL #16
    MOVK  X25, #0xe65, LSL #32
    MOVK  X25, #0xe16c, LSL #48
    MOVZ  X26, #0x1c49, LSL #0
    MOVK  X26, #0x51d0, LSL #16
    MOVK  X26, #0x45ca, LSL #32
    MOVK  X26, #0x1cd, LSL #48
    MOVZ  X27, #0x106d, LSL #0
    MOVK  X27, #0x3ddc, LSL #16
    MOVK  X27, #0x7b3b, LSL #32
    MOVK  X27, #0x9697, LSL #48
    MOVZ  X28, #0x2e2a, LSL #0
    MOVK  X28, #0xd3e, LSL #16
    MOVK  X28, #0xe833, LSL #32
    MOVK  X28, #0xcc68, LSL #48
    MOVZ  X29, #0xcc8f, LSL #0
    MOVK  X29, #0x7e1b, LSL #16
    MOVK  X29, #0xde95, LSL #32
    MOVK  X29, #0x39f7, LSL #48
    FMOV  D0, X9
    FMOV  V0.D[1], X18
    FMOV  D1, X5
    FMOV  V1.D[1], X24
    FMOV  D2, X20
    FMOV  V2.D[1], X27
    FMOV  D3, X9
    FMOV  V3.D[1], X6
    FMOV  D4, X16
    FMOV  V4.D[1], X6
    FMOV  D5, X29
    FMOV  V5.D[1], X19
    FMOV  D6, X7
    FMOV  V6.D[1], X24
    FMOV  D7, X16
    FMOV  V7.D[1], X18
    FMOV  D8, X12
    FMOV  V8.D[1], X16
    FMOV  D9, X4
    FMOV  V9.D[1], X6
    FMOV  D10, X3
    FMOV  V10.D[1], X14
    FMOV  D11, X9
    FMOV  V11.D[1], X24
    FMOV  D12, X22
    FMOV  V12.D[1], X27
    FMOV  D13, X25
    FMOV  V13.D[1], X16
    FMOV  D14, X24
    FMOV  V14.D[1], X22
    FMOV  D15, X25
    FMOV  V15.D[1], X4
    FMOV  D16, X2
    FMOV  V16.D[1], X10
    FMOV  D17, X4
    FMOV  V17.D[1], X3
    FMOV  D18, X9
    FMOV  V18.D[1], X24
    FMOV  D19, X19
    FMOV  V19.D[1], X27
    FMOV  D20, X29
    FMOV  V20.D[1], X23
    FMOV  D21, X13
    FMOV  V21.D[1], X29
    FMOV  D22, X12
    FMOV  V22.D[1], X21
    FMOV  D23, X29
    FMOV  V23.D[1], X27
    FMOV  D24, X20
    FMOV  V24.D[1], X22
    FMOV  D25, X29
    FMOV  V25.D[1], X22
    FMOV  D26, X21
    FMOV  V26.D[1], X23
    FMOV  D27, X6
    FMOV  V27.D[1], X19
    FMOV  D28, X22
    FMOV  V28.D[1], X7
    FMOV  D29, X19
    FMOV  V29.D[1], X3
    FMOV  D30, X28
    FMOV  V30.D[1], X29
    FMOV  D31, X21
    FMOV  V31.D[1], X21
    MOVZ  X20, #0xa, LSL #0
TaishanSimdPermuteP01_label_247:
    FACGT  V14.4S, V8.4S, V3.4S
    FCMLE  V3.4S, V7.4S, #0.0
    FCMEQ  S31, S28, S27
    CMEQ  V12.4H, V29.4H, V5.4H
    CMGT  V9.2D, V30.2D, #0
    FCMEQ  S12, S16, #0.0
    FCMLE  D17, D17, #0.0
    FCMGE  D26, D28, #0.0
    FCMLT  V30.2D, V22.2D, #0.0
    FACGE  S22, S16, S11
    FCMGE  D21, D29, D15
    FCMLT  V10.4S, V30.4S, #0.0
    CMLE  V19.8H, V14.8H, #0
    FACGT  S19, S5, S3
    CMGT  D16, D21, D12
    FACGE  V24.2D, V18.2D, V23.2D
    CMHI  V5.4H, V8.4H, V31.4H
    FCMGT  S12, S6, #0.0
    CMLT  D5, D2, #0
    FCMLT  S30, S26, #0.0
    FACGE  S19, S15, S30
    FCMGE  D5, D25, #0.0
    CMLT  V15.8B, V19.8B, #0
    CMEQ  V12.8H, V25.8H, #0
    CMEQ  V31.8H, V12.8H, V30.8H
    FCMLT  V2.2S, V20.2S, #0.0
    FCMGE  D5, D16, D31
    FCMEQ  V3.4S, V8.4S, #0.0
    CMHI  D15, D30, D2
    FACGT  V12.2D, V0.2D, V17.2D
    FCMGE  S14, S4, #0.0
    FCMEQ  S1, S14, S8
    FACGT  V1.4S, V15.4S, V2.4S
    CMEQ  V15.2S, V19.2S, V1.2S
    CMGT  V6.2S, V28.2S, #0
    CMEQ  D12, D12, #0
    FACGE  S0, S3, S15
    FCMEQ  V5.2S, V7.2S, V13.2S
    FCMLE  S0, S16, #0.0
    FCMGE  V6.2D, V21.2D, #0.0
    FCMGT  D12, D17, D29
    FCMGT  D12, D25, D23
    FCMGE  V25.2D, V4.2D, V6.2D
    CMGE  D6, D16, D19
    FCMLE  V3.2S, V0.2S, #0.0
    CMHS  D0, D8, D15
    FACGT  S1, S8, S13
    FACGE  V31.2S, V12.2S, V21.2S
    FCMLT  D5, D23, #0.0
    FCMGT  V25.2D, V27.2D, #0.0
    FCMGE  V27.4S, V29.4S, #0.0
    FACGE  V3.4S, V4.4S, V9.4S
    FCMGE  V27.2D, V7.2D, #0.0
    CMTST  V16.2S, V30.2S, V6.2S
    CMLT  V12.8H, V28.8H, #0
    CMEQ  V2.8B, V21.8B, V6.8B
    FCMGT  D23, D11, #0.0
    FCMEQ  D24, D4, D17
    CMGT  V28.8H, V31.8H, V11.8H
    FACGE  D19, D7, D29
    FCMLE  S3, S7, #0.0
    CMHS  D17, D12, D11
    CMGT  V17.4H, V11.4H, #0
    CMGE  V11.8B, V16.8B, #0
    CMLT  D3, D2, #0
    CMHS  V1.8B, V14.8B, V2.8B
    CMLT  D29, D13, #0
    FCMEQ  S23, S30, S7
    FCMLT  S30, S4, #0.0
    CMLT  V14.2D, V31.2D, #0
    CMHS  D19, D18, D15
    FACGT  S11, S28, S14
    FCMGE  D20, D22, #0.0
    FCMEQ  D12, D24, #0.0
    FCMGE  V30.2D, V28.2D, V20.2D
    CMLE  D22, D28, #0
    CMTST  D25, D9, D14
    FCMGT  V26.2S, V9.2S, #0.0
    CMGT  V25.4H, V24.4H, #0
    FCMGE  S2, S28, #0.0
    FCMEQ  S16, S16, S28
    FCMLT  V4.4S, V19.4S, #0.0
    FCMEQ  S31, S7, #0.0
    CMGT  V16.4S, V7.4S, #0
    FCMGE  S12, S19, #0.0
    FACGT  D15, D6, D13
    FACGT  V7.4S, V23.4S, V25.4S
    CMGE  D18, D17, #0
    CMGT  V8.8H, V3.8H, #0
    CMHS  D4, D2, D27
    CMLE  D23, D21, #0
    FACGE  S20, S4, S31
    CMGT  V20.8B, V29.8B, V18.8B
    CMGE  D3, D16, D3
    CMTST  D30, D10, D8
    FCMGT  V0.2D, V0.2D, V27.2D
    CMLT  D31, D28, #0
    FACGT  D7, D3, D12
    FACGT  V20.2D, V12.2D, V25.2D
    CMGE  V27.4H, V17.4H, #0
    FCMGT  V7.2S, V29.2S, V19.2S
    FCMGT  V14.2S, V15.2S, #0.0
    FCMGT  S24, S9, #0.0
    FCMGT  D0, D20, D5
    FCMEQ  S28, S14, #0.0
    FCMGE  D10, D2, D22
    CMGT  D27, D10, #0
    CMLE  D30, D8, #0
    FCMGT  V22.2D, V31.2D, V8.2D
    FCMLT  V27.2D, V19.2D, #0.0
    CMGE  V0.16B, V18.16B, V9.16B
    CMGT  V18.8H, V5.8H, #0
    FACGE  V30.4S, V8.4S, V13.4S
    CMLT  V26.2S, V11.2S, #0
    FCMGE  D0, D25, #0.0
    FCMLT  D3, D22, #0.0
    CMGT  V20.4S, V21.4S, #0
    CMGE  V10.16B, V29.16B, #0
    FCMGT  S23, S14, #0.0
    FCMGT  V12.2D, V15.2D, V28.2D
    FCMEQ  V30.2D, V11.2D, V19.2D
    FCMEQ  D4, D3, D27
    FCMEQ  V24.2D, V29.2D, V28.2D
    CMHI  V9.2D, V11.2D, V7.2D
    CMGT  V9.16B, V29.16B, V10.16B
    FCMGE  V5.2S, V29.2S, #0.0
    CMTST  D0, D8, D21
    CMTST  V25.4H, V14.4H, V10.4H
    FCMGE  S10, S31, #0.0
    CMEQ  D31, D9, D28
    FCMLT  V12.2D, V2.2D, #0.0
    CMHS  D12, D17, D13
    CMHS  V31.2D, V9.2D, V22.2D
    FCMGE  S22, S5, #0.0
    CMHS  V28.8H, V6.8H, V27.8H
    CMGT  D30, D5, #0
    FACGE  V1.2S, V21.2S, V27.2S
    FCMGT  V6.4S, V25.4S, #0.0
    CMTST  V27.16B, V15.16B, V6.16B
    FACGE  D0, D10, D20
    FCMGE  S20, S18, S10
    CMLT  V2.4S, V20.4S, #0
    FCMEQ  S13, S29, #0.0
    CMHS  V5.8H, V17.8H, V12.8H
    CMHI  V20.8B, V4.8B, V8.8B
    FCMEQ  D9, D26, D29
    CMLE  D9, D13, #0
    FCMGT  V1.2D, V4.2D, #0.0
    FACGE  D4, D1, D7
    CMGE  D6, D23, #0
    FCMGT  S10, S12, #0.0
    FCMGE  S10, S14, S12
    CMGT  D4, D8, D9
    FCMLT  V23.2D, V9.2D, #0.0
    CMEQ  D13, D28, #0
    CMGE  D28, D10, D21
    FACGE  S16, S27, S18
    CMGE  V9.2S, V27.2S, V8.2S
    CMEQ  V17.4S, V22.4S, V20.4S
    CMHI  V2.2S, V11.2S, V26.2S
    CMGT  D23, D11, #0
    CMGT  D15, D31, D29
    FACGE  D22, D1, D11
    FACGT  V0.4S, V6.4S, V17.4S
    CMHS  V5.8H, V28.8H, V25.8H
    FCMGT  V3.4S, V11.4S, #0.0
    FCMGT  D16, D25, #0.0
    FACGT  V0.2S, V18.2S, V18.2S
    CMLE  D9, D29, #0
    CMGT  D25, D8, #0
    FCMGT  D30, D5, #0.0
    CMGE  V25.4S, V30.4S, #0
    FACGT  V4.2D, V30.2D, V9.2D
    FCMEQ  V29.2S, V19.2S, V11.2S
    FCMGE  D13, D15, #0.0
    FACGT  S14, S2, S22
    FCMLE  V19.4S, V12.4S, #0.0
    CMTST  D30, D13, D3
    CMLT  V23.2D, V29.2D, #0
    CMGE  V14.2D, V0.2D, #0
    CMEQ  V26.4H, V26.4H, #0
    FCMGE  V27.2D, V3.2D, V30.2D
    CMGT  D11, D29, D13
    FCMGE  V3.4S, V23.4S, V1.4S
    FACGE  S25, S16, S27
    CMGE  V20.2S, V0.2S, #0
    CMHS  D31, D26, D4
    FCMLT  S19, S26, #0.0
    CMEQ  V17.8B, V31.8B, V18.8B
    FCMLE  S18, S23, #0.0
    CMTST  D2, D14, D18
    FACGE  S2, S12, S8
    CMGE  V31.8B, V3.8B, V8.8B
    FCMLT  V21.2S, V2.2S, #0.0
    CMGE  D1, D2, D4
    FCMLT  D24, D13, #0.0
    CMHI  V6.8H, V16.8H, V19.8H
    FCMGT  D2, D2, #0.0
    FCMLT  D2, D7, #0.0
    CMHI  V10.8H, V8.8H, V21.8H
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdPermuteP01_label_247
    MOVZ  X29, #0xeda5, LSL #0
    MOVK  X29, #0x16ad, LSL #16
    MOVK  X29, #0x1250, LSL #32
    MOVK  X29, #0x71bb, LSL #48
    SUB  X19, X29, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x83cb, LSL #0
    MOVK  X16, #0x47b4, LSL #16
    MOVK  X16, #0xa4fc, LSL #32
    MOVK  X16, #0xd919, LSL #48
    SUB  X19, X16, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x5893, LSL #0
    MOVK  X17, #0x73ec, LSL #16
    MOVK  X17, #0x2c90, LSL #32
    MOVK  X17, #0x47f3, LSL #48
    SUB  X9, X17, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x41cb, LSL #0
    MOVK  X25, #0x6154, LSL #16
    MOVK  X25, #0x84d6, LSL #32
    MOVK  X25, #0x2a0, LSL #48
    SUB  X12, X25, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x6cde, LSL #0
    MOVK  X12, #0x142c, LSL #16
    MOVK  X12, #0x2a63, LSL #32
    MOVK  X12, #0x5a05, LSL #48
    SUB  X16, X12, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0xbfdb, LSL #0
    MOVK  X6, #0x2a92, LSL #16
    MOVK  X6, #0x4f57, LSL #32
    MOVK  X6, #0xf081, LSL #48
    SUB  X21, X6, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xd6ab, LSL #0
    MOVK  X9, #0x9354, LSL #16
    MOVK  X9, #0x8b2, LSL #32
    MOVK  X9, #0x767f, LSL #48
    SUB  X22, X9, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0xd6ab, LSL #0
    MOVK  X29, #0x9354, LSL #16
    MOVK  X29, #0x8b2, LSL #32
    MOVK  X29, #0x767f, LSL #48
    SUB  X24, X29, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0xdbe9, LSL #0
    MOVK  X4, #0xde3e, LSL #16
    MOVK  X4, #0xbdf1, LSL #32
    MOVK  X4, #0xfe5, LSL #48
    SUB  X11, X4, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x6cde, LSL #0
    MOVK  X22, #0x142c, LSL #16
    MOVK  X22, #0x2a63, LSL #32
    MOVK  X22, #0x5a05, LSL #48
    SUB  X29, X22, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x871f, LSL #0
    MOVK  X27, #0x1c3f, LSL #16
    MOVK  X27, #0x910e, LSL #32
    MOVK  X27, #0xfa7, LSL #48
    SUB  X11, X27, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x7993, LSL #0
    MOVK  X7, #0xd2dc, LSL #16
    MOVK  X7, #0x2f0a, LSL #32
    MOVK  X7, #0x3d82, LSL #48
    SUB  X8, X7, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X20, X11, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x5893, LSL #0
    MOVK  X6, #0x73ec, LSL #16
    MOVK  X6, #0x2c90, LSL #32
    MOVK  X6, #0x47f3, LSL #48
    SUB  X12, X6, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xc29f, LSL #0
    MOVK  X18, #0x4781, LSL #16
    MOVK  X18, #0x281f, LSL #32
    MOVK  X18, #0x9575, LSL #48
    SUB  X14, X18, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x6cde, LSL #0
    MOVK  X6, #0x142c, LSL #16
    MOVK  X6, #0x2a63, LSL #32
    MOVK  X6, #0x5a05, LSL #48
    SUB  X3, X6, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x6168, LSL #0
    MOVK  X18, #0x9c0e, LSL #16
    MOVK  X18, #0xd9fb, LSL #32
    MOVK  X18, #0x3985, LSL #48
    SUB  X29, X18, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x41cb, LSL #0
    MOVK  X6, #0x6154, LSL #16
    MOVK  X6, #0x84d6, LSL #32
    MOVK  X6, #0x2a0, LSL #48
    SUB  X7, X6, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x2e2a, LSL #0
    MOVK  X7, #0xd3e, LSL #16
    MOVK  X7, #0xe833, LSL #32
    MOVK  X7, #0xcc68, LSL #48
    SUB  X24, X7, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D2
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X21, X23, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X21, X23, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D4
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D5
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X6
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D6
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D9
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X6, X7, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D11
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X22, D13
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X21, X14, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D14
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D19
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D20
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X22, X25, X7
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D21
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D22
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X14, X11, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X10, X12, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D23
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X10, X12, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D25
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D26
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X24, X28, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X17, X19, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D27
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X17, X19, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D28
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D29
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X28, X12, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
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
    FMOV  D0, X20
    FMOV  V0.D[1], X24
    FMOV  D1, X5
    FMOV  V1.D[1], X9
    FMOV  D2, X7
    FMOV  V2.D[1], X9
    FMOV  D3, X28
    FMOV  V3.D[1], X4
    FMOV  D4, X25
    FMOV  V4.D[1], X22
    FMOV  D5, X7
    FMOV  V5.D[1], X6
    FMOV  D6, X26
    FMOV  V6.D[1], X18
    FMOV  D7, X22
    FMOV  V7.D[1], X8
    FMOV  D8, X14
    FMOV  V8.D[1], X8
    FMOV  D9, X28
    FMOV  V9.D[1], X7
    FMOV  D10, X28
    FMOV  V10.D[1], X17
    FMOV  D11, X29
    FMOV  V11.D[1], X13
    FMOV  D12, X14
    FMOV  V12.D[1], X16
    FMOV  D13, X9
    FMOV  V13.D[1], X19
    FMOV  D14, X19
    FMOV  V14.D[1], X25
    FMOV  D15, X12
    FMOV  V15.D[1], X20
    FMOV  D16, X21
    FMOV  V16.D[1], X9
    FMOV  D17, X9
    FMOV  V17.D[1], X12
    FMOV  D18, X8
    FMOV  V18.D[1], X11
    FMOV  D19, X7
    FMOV  V19.D[1], X12
    FMOV  D20, X28
    FMOV  V20.D[1], X21
    FMOV  D21, X17
    FMOV  V21.D[1], X18
    FMOV  D22, X8
    FMOV  V22.D[1], X27
    FMOV  D23, X3
    FMOV  V23.D[1], X29
    FMOV  D24, X4
    FMOV  V24.D[1], X20
    FMOV  D25, X19
    FMOV  V25.D[1], X20
    FMOV  D26, X11
    FMOV  V26.D[1], X22
    FMOV  D27, X23
    FMOV  V27.D[1], X12
    FMOV  D28, X13
    FMOV  V28.D[1], X12
    FMOV  D29, X12
    FMOV  V29.D[1], X22
    FMOV  D30, X22
    FMOV  V30.D[1], X20
    FMOV  D31, X28
    FMOV  V31.D[1], X12
    MOVZ  X28, #0xa, LSL #0
TaishanSimdPermuteP01_label_328:
    FCMEQ  D28, D5, D2
    FCMGE  S25, S12, S6
    FCMLE  D22, D27, #0.0
    CMGT  V9.2D, V2.2D, #0
    FCMLE  V28.4S, V13.4S, #0.0
    FCMGE  S8, S29, #0.0
    CMEQ  V16.2S, V6.2S, #0
    CMLT  D24, D2, #0
    CMLE  D11, D28, #0
    FACGT  V20.4S, V30.4S, V19.4S
    FCMEQ  D27, D20, #0.0
    FCMGE  D4, D5, D8
    FACGE  V17.2D, V4.2D, V15.2D
    FCMEQ  D4, D9, D0
    CMHS  D25, D26, D3
    CMGE  D28, D11, D13
    CMHS  D16, D30, D1
    CMGT  D14, D19, #0
    FCMGT  V16.4S, V15.4S, #0.0
    CMTST  D13, D24, D0
    CMGT  D13, D8, #0
    FCMGT  D31, D5, #0.0
    CMHI  V3.4S, V18.4S, V7.4S
    FCMGE  S26, S15, S22
    FACGT  S3, S8, S25
    FCMLE  S20, S8, #0.0
    CMHI  V17.8B, V30.8B, V16.8B
    FCMEQ  D13, D2, #0.0
    FCMGE  S11, S9, #0.0
    FACGT  V0.4S, V31.4S, V25.4S
    CMTST  V1.8H, V2.8H, V24.8H
    CMLE  V7.2S, V2.2S, #0
    CMGE  D25, D21, D11
    FCMGT  D24, D27, D20
    CMEQ  V24.2S, V14.2S, V30.2S
    CMTST  D21, D28, D29
    CMGT  D27, D28, #0
    FCMLE  V29.4S, V17.4S, #0.0
    FCMLT  S9, S8, #0.0
    CMGT  D1, D0, D19
    CMLE  D20, D9, #0
    FACGT  S0, S22, S14
    FCMGT  D30, D7, #0.0
    FCMEQ  D3, D28, #0.0
    FCMLE  V2.4S, V25.4S, #0.0
    FACGT  V24.4S, V14.4S, V29.4S
    CMGT  V25.4S, V28.4S, V16.4S
    FCMGT  V5.2D, V16.2D, #0.0
    FACGT  S3, S26, S27
    FCMEQ  V29.2S, V29.2S, V17.2S
    FCMGE  S8, S7, S17
    CMEQ  D3, D8, #0
    FCMGE  S2, S14, #0.0
    CMEQ  V22.8H, V30.8H, #0
    CMHI  V0.2D, V14.2D, V17.2D
    CMHS  D27, D13, D18
    CMGT  D28, D16, #0
    FCMLE  V5.4S, V7.4S, #0.0
    FACGE  D20, D6, D11
    FCMGE  S5, S31, S12
    CMHI  D27, D7, D12
    CMLT  D14, D12, #0
    FACGT  D4, D31, D1
    FCMEQ  V8.2S, V9.2S, #0.0
    CMTST  V3.4S, V18.4S, V10.4S
    FCMGT  D9, D18, D29
    FACGE  D28, D10, D5
    CMEQ  D28, D27, #0
    CMEQ  D28, D14, D30
    CMLE  D18, D25, #0
    FACGT  D10, D22, D4
    FACGT  D9, D27, D28
    CMLE  D8, D10, #0
    CMTST  D9, D18, D28
    FACGE  D17, D3, D14
    FCMGE  D24, D6, #0.0
    FCMGT  D3, D31, #0.0
    CMTST  D28, D27, D5
    CMLT  D6, D8, #0
    FCMGE  V5.4S, V12.4S, V4.4S
    CMGE  D1, D13, D9
    CMEQ  V24.8H, V6.8H, V0.8H
    FCMLT  D9, D22, #0.0
    FCMEQ  V7.2S, V15.2S, V12.2S
    CMLT  D31, D12, #0
    FCMGT  V15.4S, V17.4S, V18.4S
    FCMGE  S15, S13, S26
    FCMLT  D0, D1, #0.0
    FCMEQ  S7, S1, S31
    FACGE  D1, D4, D3
    FACGT  S12, S28, S3
    FCMEQ  V8.4S, V19.4S, #0.0
    CMLE  D30, D9, #0
    CMLE  V22.8B, V13.8B, #0
    FCMGE  S16, S3, S31
    FCMLE  V28.4S, V8.4S, #0.0
    FCMGT  S29, S22, #0.0
    CMGE  D17, D18, D2
    FCMGT  V5.4S, V1.4S, V31.4S
    FCMGT  V5.2S, V5.2S, V21.2S
    FACGT  D19, D30, D11
    FACGT  V14.2S, V27.2S, V7.2S
    FCMEQ  V6.4S, V11.4S, V24.4S
    FCMGT  S3, S30, #0.0
    CMHS  V6.4S, V27.4S, V13.4S
    FCMGT  S21, S3, #0.0
    CMGT  V19.8H, V16.8H, #0
    CMHS  D5, D31, D8
    FCMGE  D6, D13, #0.0
    CMLE  D17, D16, #0
    FCMLT  S2, S30, #0.0
    FCMLE  S27, S13, #0.0
    FCMGE  V18.2S, V11.2S, V19.2S
    CMLT  D0, D28, #0
    FCMEQ  V2.2D, V30.2D, V31.2D
    CMGT  D13, D4, D6
    FCMLT  D26, D5, #0.0
    CMEQ  V26.16B, V26.16B, #0
    FCMGE  V15.2D, V18.2D, V0.2D
    CMGE  V27.16B, V2.16B, #0
    FACGT  S16, S21, S31
    FACGE  D29, D25, D29
    CMLT  D20, D24, #0
    FCMEQ  S22, S0, #0.0
    CMLE  V29.2D, V22.2D, #0
    FCMLT  S11, S5, #0.0
    FCMEQ  V2.4S, V29.4S, V13.4S
    FCMGT  D24, D30, #0.0
    FACGE  D12, D26, D25
    FCMGT  S15, S5, S29
    FCMLE  D18, D31, #0.0
    FACGE  D20, D11, D29
    CMGE  V6.8B, V20.8B, V30.8B
    CMTST  V26.8B, V5.8B, V4.8B
    FCMEQ  D27, D26, #0.0
    CMGT  V12.16B, V1.16B, V26.16B
    CMHI  V28.16B, V16.16B, V24.16B
    FACGE  V19.2D, V10.2D, V20.2D
    CMLT  D5, D18, #0
    CMGT  D22, D8, #0
    FCMEQ  D30, D28, D20
    FCMGT  V16.4S, V18.4S, #0.0
    CMHI  D20, D7, D10
    FCMGT  V29.2S, V29.2S, #0.0
    FCMLT  S1, S8, #0.0
    FCMEQ  V24.4S, V16.4S, V1.4S
    FCMGT  V21.2D, V29.2D, V26.2D
    FCMGE  V25.2S, V10.2S, V30.2S
    CMHI  D6, D7, D15
    FCMLT  V7.2D, V3.2D, #0.0
    CMHI  D21, D11, D18
    FCMLE  V28.2D, V12.2D, #0.0
    FACGE  D22, D25, D5
    CMGE  V22.4S, V27.4S, #0
    FCMLE  V17.2S, V14.2S, #0.0
    FCMEQ  V17.2S, V24.2S, V27.2S
    FCMGE  V24.2S, V18.2S, V19.2S
    FACGE  V25.2S, V6.2S, V30.2S
    FCMGT  D20, D18, #0.0
    CMGT  V29.4H, V4.4H, V27.4H
    FCMGE  D31, D19, D21
    FACGT  V7.2D, V28.2D, V11.2D
    CMGT  V13.4H, V15.4H, #0
    FCMGE  V16.4S, V7.4S, #0.0
    CMLE  V10.2S, V16.2S, #0
    CMLE  D17, D19, #0
    CMHS  V12.4S, V1.4S, V9.4S
    FACGE  D8, D13, D11
    FCMEQ  S30, S10, #0.0
    FCMGE  V30.2S, V21.2S, V17.2S
    CMGE  V25.8H, V7.8H, #0
    FCMGT  D26, D24, #0.0
    FACGT  S25, S6, S4
    FCMGE  V21.4S, V20.4S, #0.0
    CMLE  D19, D12, #0
    CMEQ  V9.16B, V17.16B, V12.16B
    FCMGT  V9.2S, V27.2S, #0.0
    CMGT  V17.4H, V25.4H, #0
    CMGE  D17, D21, D13
    CMGT  D17, D1, #0
    CMLT  D21, D21, #0
    CMLE  D0, D8, #0
    CMGE  D0, D15, #0
    FCMEQ  V2.2D, V15.2D, #0.0
    CMGE  D7, D12, D23
    FCMEQ  V10.2D, V29.2D, V27.2D
    FCMGT  V19.2S, V31.2S, #0.0
    FCMGE  V10.2S, V1.2S, #0.0
    FCMGT  S20, S0, S1
    FCMGE  V28.2S, V13.2S, V14.2S
    FACGT  D25, D4, D30
    FACGE  D13, D16, D6
    FCMGE  V9.2S, V16.2S, V14.2S
    FCMEQ  D0, D21, #0.0
    FCMEQ  S6, S1, S15
    FCMLT  V24.4S, V28.4S, #0.0
    FACGE  S13, S25, S27
    FCMEQ  V13.2S, V16.2S, #0.0
    CMHI  V3.2D, V3.2D, V14.2D
    FCMEQ  V7.2S, V21.2S, V25.2S
    SUBS  X28, X28, #0x1
    B.NE  TaishanSimdPermuteP01_label_328
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X3, X22, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X11
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X11, X10, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X14, X20, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X8, X22, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X8, X10, X29
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X11, X3, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D2
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X11, X3, X4
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D6
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X3, X13, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X22, D7
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X4, X12, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D8
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X4, X12, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D10
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X6, X23, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X3, X28, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D12
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X3, X28, X13
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D13
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X19, X18, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D16
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X19, X18, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D18
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D19
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D20
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D21
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X3, X25, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X26, X19, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D22
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X29
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D27
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X16, X2, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D28
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X6, X23, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D29
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X20
    FMOV  D1, X10
    FMOV  V1.D[1], X26
    FMOV  D2, X18
    FMOV  V2.D[1], X19
    FMOV  D3, X6
    FMOV  V3.D[1], X27
    FMOV  D4, X29
    FMOV  V4.D[1], X14
    FMOV  D5, X28
    FMOV  V5.D[1], X14
    FMOV  D6, X9
    FMOV  V6.D[1], X11
    FMOV  D7, X21
    FMOV  V7.D[1], X16
    FMOV  D8, X8
    FMOV  V8.D[1], X28
    FMOV  D9, X25
    FMOV  V9.D[1], X25
    FMOV  D10, X26
    FMOV  V10.D[1], X26
    FMOV  D11, X28
    FMOV  V11.D[1], X21
    FMOV  D12, X25
    FMOV  V12.D[1], X7
    FMOV  D13, X24
    FMOV  V13.D[1], X12
    FMOV  D14, X20
    FMOV  V14.D[1], X18
    FMOV  D15, X13
    FMOV  V15.D[1], X16
    FMOV  D16, X16
    FMOV  V16.D[1], X25
    FMOV  D17, X5
    FMOV  V17.D[1], X14
    FMOV  D18, X4
    FMOV  V18.D[1], X8
    FMOV  D19, X13
    FMOV  V19.D[1], X16
    FMOV  D20, X24
    FMOV  V20.D[1], X24
    FMOV  D21, X22
    FMOV  V21.D[1], X29
    FMOV  D22, X10
    FMOV  V22.D[1], X18
    FMOV  D23, X5
    FMOV  V23.D[1], X4
    FMOV  D24, X9
    FMOV  V24.D[1], X4
    FMOV  D25, X12
    FMOV  V25.D[1], X6
    FMOV  D26, X6
    FMOV  V26.D[1], X29
    FMOV  D27, X5
    FMOV  V27.D[1], X10
    FMOV  D28, X24
    FMOV  V28.D[1], X12
    FMOV  D29, X22
    FMOV  V29.D[1], X2
    FMOV  D30, X18
    FMOV  V30.D[1], X20
    FMOV  D31, X5
    FMOV  V31.D[1], X29
    MOVZ  X7, #0xf, LSL #0
TaishanSimdPermuteP01_label_410:
    CMHS  D25, D31, D28
    CMTST  D25, D12, D27
    CMEQ  V6.4S, V7.4S, #0
    FCMGT  S20, S0, S20
    CMTST  D29, D27, D12
    FACGE  V30.2S, V15.2S, V27.2S
    FCMGT  S23, S11, #0.0
    FCMGE  S1, S8, S30
    CMEQ  D15, D16, D25
    FCMGE  D6, D2, D10
    FACGE  D11, D12, D29
    FCMEQ  D23, D3, D11
    CMGT  D12, D18, D26
    FCMLT  V12.2D, V30.2D, #0.0
    FCMGE  S13, S5, #0.0
    CMTST  D27, D23, D3
    FCMEQ  S30, S19, #0.0
    FCMLT  D5, D20, #0.0
    CMLE  V1.4H, V11.4H, #0
    CMGE  D21, D20, #0
    CMGE  D26, D8, #0
    CMHS  D14, D26, D25
    FACGT  S26, S18, S14
    FACGT  S30, S0, S27
    FCMGT  D7, D12, #0.0
    FCMEQ  D19, D9, D22
    FCMLE  V6.2D, V4.2D, #0.0
    FCMGT  V1.2S, V24.2S, #0.0
    CMHI  D19, D8, D21
    FCMGT  D5, D0, #0.0
    CMLT  D16, D7, #0
    FCMEQ  D13, D2, D2
    CMGE  V2.2S, V21.2S, V24.2S
    FCMGE  V4.2D, V11.2D, #0.0
    CMHS  D12, D15, D29
    CMLE  D12, D23, #0
    CMGT  D8, D12, D30
    CMLT  V16.16B, V6.16B, #0
    FCMEQ  D9, D9, D26
    CMLT  D23, D10, #0
    FCMEQ  D11, D23, #0.0
    FACGE  S8, S0, S19
    FCMGT  D9, D1, D31
    FCMGT  S13, S7, #0.0
    CMHS  V7.8H, V14.8H, V9.8H
    FCMGE  S10, S16, #0.0
    CMHI  D24, D12, D21
    FCMLE  D26, D7, #0.0
    CMTST  D31, D1, D14
    FCMGT  D30, D25, #0.0
    FCMGT  D11, D12, #0.0
    FCMEQ  V29.2D, V1.2D, #0.0
    FCMLT  V30.2S, V12.2S, #0.0
    FACGT  S24, S0, S21
    CMEQ  V4.4S, V29.4S, #0
    CMGT  V6.4S, V6.4S, #0
    CMHS  D6, D4, D19
    CMHS  D15, D16, D1
    FACGT  V14.2D, V6.2D, V14.2D
    FCMEQ  S5, S29, S10
    FCMGT  V17.4S, V19.4S, #0.0
    FCMGE  S11, S4, S12
    FCMLE  V15.2D, V24.2D, #0.0
    FCMLE  D29, D25, #0.0
    FCMGE  V5.2S, V2.2S, V8.2S
    FACGE  D14, D30, D14
    FCMLE  V5.2S, V26.2S, #0.0
    FCMEQ  V6.2S, V30.2S, V17.2S
    FCMEQ  D9, D11, D4
    FCMEQ  V24.2S, V10.2S, V15.2S
    FCMEQ  V6.2S, V24.2S, #0.0
    CMLE  V17.2D, V21.2D, #0
    FCMGE  D17, D28, #0.0
    FCMLE  D12, D10, #0.0
    CMLT  V8.16B, V8.16B, #0
    CMLE  D7, D6, #0
    CMGE  D15, D10, #0
    CMGE  V15.4H, V9.4H, V27.4H
    FCMEQ  V2.2S, V18.2S, V12.2S
    FCMGE  D1, D24, D14
    CMLE  D24, D21, #0
    FACGT  D13, D29, D0
    CMGE  D5, D26, #0
    FCMGT  D1, D18, D1
    CMTST  V16.16B, V28.16B, V23.16B
    FCMGT  D14, D11, D16
    FCMLT  D30, D18, #0.0
    CMGT  D31, D30, #0
    FACGE  D6, D14, D15
    FCMGE  D3, D11, #0.0
    CMLE  V21.16B, V2.16B, #0
    CMGE  V17.2S, V18.2S, #0
    CMEQ  V18.2S, V12.2S, #0
    FCMEQ  V16.4S, V25.4S, #0.0
    CMGT  D27, D23, #0
    FCMLT  S12, S17, #0.0
    CMEQ  D20, D0, D12
    CMGT  V30.8H, V22.8H, #0
    FCMLE  S9, S13, #0.0
    FCMLT  S31, S3, #0.0
    CMGE  D22, D13, D12
    CMGT  V30.2S, V26.2S, #0
    CMGT  D6, D17, #0
    CMHS  D3, D9, D3
    FCMGT  D24, D16, #0.0
    CMGT  D20, D22, D30
    CMGE  V28.4S, V16.4S, #0
    FCMGE  V13.2S, V26.2S, #0.0
    FACGT  V28.2D, V13.2D, V29.2D
    FCMLE  V28.2D, V29.2D, #0.0
    FCMEQ  V18.2S, V25.2S, V4.2S
    FCMGE  V22.4S, V2.4S, #0.0
    FCMGE  D31, D11, D14
    FACGE  V18.2S, V3.2S, V18.2S
    FCMEQ  S5, S29, S17
    FCMLE  S29, S30, #0.0
    FCMLE  D3, D28, #0.0
    CMEQ  D8, D9, #0
    CMGE  D23, D4, #0
    CMEQ  V29.4S, V23.4S, V6.4S
    FCMEQ  D12, D1, D17
    CMTST  V7.8B, V29.8B, V3.8B
    CMHS  V20.8B, V4.8B, V11.8B
    FCMEQ  D22, D28, #0.0
    FCMLE  D11, D6, #0.0
    FCMEQ  D11, D3, #0.0
    CMLT  V12.8H, V30.8H, #0
    CMGE  D15, D15, #0
    CMGE  V13.8B, V24.8B, V18.8B
    FCMGT  D20, D27, #0.0
    FCMEQ  D3, D17, #0.0
    CMTST  D3, D8, D14
    FACGT  D24, D5, D6
    FCMGE  S13, S7, S20
    CMLT  D8, D15, #0
    FACGT  V25.2S, V8.2S, V14.2S
    FCMEQ  V25.4S, V13.4S, V13.4S
    FCMGT  V12.2D, V30.2D, #0.0
    CMLE  V15.4H, V27.4H, #0
    CMGT  D31, D9, D6
    CMLT  D21, D6, #0
    FCMEQ  S26, S28, #0.0
    CMHS  D12, D23, D17
    FACGE  V25.2S, V4.2S, V11.2S
    CMEQ  D23, D15, #0
    FCMLT  V9.4S, V20.4S, #0.0
    FACGE  V6.2S, V17.2S, V29.2S
    CMLT  V20.8B, V3.8B, #0
    CMLE  V22.8H, V5.8H, #0
    FCMLT  D21, D31, #0.0
    CMLT  V7.4S, V24.4S, #0
    FCMEQ  V23.2D, V16.2D, V23.2D
    FCMLT  D17, D1, #0.0
    CMGE  V20.4H, V11.4H, #0
    FCMGE  D5, D0, D20
    FCMEQ  S24, S17, S23
    FCMGE  V5.2D, V29.2D, V14.2D
    CMGE  V4.16B, V31.16B, #0
    CMEQ  V12.2D, V20.2D, V7.2D
    FCMGE  S9, S17, #0.0
    FACGT  S31, S18, S9
    FCMGE  S25, S9, #0.0
    FCMGT  V13.4S, V15.4S, #0.0
    CMLT  V10.8H, V10.8H, #0
    FCMEQ  S7, S24, S19
    CMGT  D0, D24, #0
    CMEQ  D0, D23, #0
    FCMGT  V5.2D, V3.2D, V13.2D
    CMLE  D18, D30, #0
    FCMGE  S2, S18, S14
    CMEQ  D12, D29, #0
    CMLE  V31.8H, V30.8H, #0
    CMHS  V5.8H, V11.8H, V20.8H
    FCMLE  S4, S17, #0.0
    FCMGT  D7, D18, D10
    FCMLT  V19.2S, V2.2S, #0.0
    CMGT  D29, D20, #0
    CMEQ  V11.4S, V18.4S, V14.4S
    CMHS  D5, D13, D22
    CMGT  D27, D12, D16
    FCMEQ  V31.2S, V15.2S, #0.0
    FCMGE  V18.2S, V12.2S, V6.2S
    FCMGE  V10.2D, V6.2D, V31.2D
    FCMLE  V26.4S, V11.4S, #0.0
    FCMEQ  D10, D20, #0.0
    FCMGE  S22, S0, #0.0
    FACGE  D23, D28, D10
    FCMGE  D19, D4, D2
    FCMGT  S14, S8, #0.0
    FCMGT  D17, D31, #0.0
    CMLE  V2.8H, V20.8H, #0
    FCMEQ  D23, D28, D19
    FCMEQ  D0, D19, #0.0
    FCMEQ  D28, D22, #0.0
    FCMGT  V22.2D, V5.2D, #0.0
    CMHS  V27.2D, V3.2D, V10.2D
    FACGT  V19.2D, V3.2D, V2.2D
    CMGE  V21.4H, V30.4H, #0
    FCMGT  D19, D14, D14
    FCMGT  D12, D1, D31
    SUBS  X7, X7, #0x1
    B.NE  TaishanSimdPermuteP01_label_410
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X5, X17, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X26, X16, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X28, X7, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X7, X13, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X8, X10, X11
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X12, X27, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X11, X19, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X4, X3, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X20, X25, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X2, X9, X21
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X26, X7, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X8, X20, X23
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X19, X2, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X6, X3, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X26
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X18, X22, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X6, X8, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D2
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X6, X8, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D4
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X9, X6, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D5
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D8
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X9, X18, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D9
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X8, X20, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X29, X3, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D13
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D14
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D16
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X21, X9, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D18
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D19
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V20.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X16, X5, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D20
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X16, X5, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D21
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X24, X20, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D23
    MOVZ  X5, #0x0, LSL #0
    SUB  X8, X5, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D24
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    SUB  X12, X13, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D25
    MOVZ  X29, #0x0, LSL #0
    SUB  X12, X29, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D26
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X7, X24, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D27
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X7, X24, X17
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D28
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X20, X27, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X14
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xb20b, LSL #0
    MOVK  X2, #0x3427, LSL #16
    MOVK  X2, #0xbcaf, LSL #32
    MOVK  X2, #0x4e99, LSL #48
    MOVZ  X3, #0x7bc3, LSL #0
    MOVK  X3, #0x8837, LSL #16
    MOVK  X3, #0x6384, LSL #32
    MOVK  X3, #0x4175, LSL #48
    MOVZ  X4, #0x107a, LSL #0
    MOVK  X4, #0x98b7, LSL #16
    MOVK  X4, #0x2c91, LSL #32
    MOVK  X4, #0xdd20, LSL #48
    MOVZ  X5, #0x651d, LSL #0
    MOVK  X5, #0xcb99, LSL #16
    MOVK  X5, #0x269f, LSL #32
    MOVK  X5, #0x2440, LSL #48
    MOVZ  X6, #0x9043, LSL #0
    MOVK  X6, #0x5966, LSL #16
    MOVK  X6, #0x8001, LSL #32
    MOVK  X6, #0x9d6e, LSL #48
    MOVZ  X7, #0x4fe2, LSL #0
    MOVK  X7, #0x4ed8, LSL #16
    MOVK  X7, #0xf69d, LSL #32
    MOVK  X7, #0x1b24, LSL #48
    MOVZ  X8, #0xf542, LSL #0
    MOVK  X8, #0x7beb, LSL #16
    MOVK  X8, #0xf5d2, LSL #32
    MOVK  X8, #0x5bce, LSL #48
    MOVZ  X9, #0x74ea, LSL #0
    MOVK  X9, #0x961c, LSL #16
    MOVK  X9, #0xd8f9, LSL #32
    MOVK  X9, #0x3e27, LSL #48
    MOVZ  X10, #0x7686, LSL #0
    MOVK  X10, #0xd3eb, LSL #16
    MOVK  X10, #0x823d, LSL #32
    MOVK  X10, #0x610b, LSL #48
    MOVZ  X11, #0xb02b, LSL #0
    MOVK  X11, #0x5585, LSL #16
    MOVK  X11, #0x7b9e, LSL #32
    MOVK  X11, #0x3175, LSL #48
    MOVZ  X12, #0x5ed4, LSL #0
    MOVK  X12, #0x8101, LSL #16
    MOVK  X12, #0x9db9, LSL #32
    MOVK  X12, #0xdfda, LSL #48
    MOVZ  X13, #0xdf19, LSL #0
    MOVK  X13, #0xb49d, LSL #16
    MOVK  X13, #0xb77d, LSL #32
    MOVK  X13, #0x7335, LSL #48
    MOVZ  X14, #0x1197, LSL #0
    MOVK  X14, #0x1ee6, LSL #16
    MOVK  X14, #0xae27, LSL #32
    MOVK  X14, #0x4a37, LSL #48
    MOVZ  X16, #0xfed4, LSL #0
    MOVK  X16, #0x3eb4, LSL #16
    MOVK  X16, #0x9784, LSL #32
    MOVK  X16, #0x7876, LSL #48
    MOVZ  X17, #0xb415, LSL #0
    MOVK  X17, #0x7a8e, LSL #16
    MOVK  X17, #0x4b52, LSL #32
    MOVK  X17, #0xc3fc, LSL #48
    MOVZ  X18, #0x90f1, LSL #0
    MOVK  X18, #0x3946, LSL #16
    MOVK  X18, #0xc072, LSL #32
    MOVK  X18, #0x7f42, LSL #48
    MOVZ  X19, #0x20f3, LSL #0
    MOVK  X19, #0xc68e, LSL #16
    MOVK  X19, #0xa487, LSL #32
    MOVK  X19, #0x4037, LSL #48
    MOVZ  X20, #0xb8a4, LSL #0
    MOVK  X20, #0xbf15, LSL #16
    MOVK  X20, #0x1919, LSL #32
    MOVK  X20, #0xc06f, LSL #48
    MOVZ  X21, #0xd771, LSL #0
    MOVK  X21, #0xbb7e, LSL #16
    MOVK  X21, #0xc8dd, LSL #32
    MOVK  X21, #0xcf32, LSL #48
    MOVZ  X22, #0x452c, LSL #0
    MOVK  X22, #0xdd3f, LSL #16
    MOVK  X22, #0x82e7, LSL #32
    MOVK  X22, #0x2851, LSL #48
    MOVZ  X23, #0x9ab2, LSL #0
    MOVK  X23, #0xd96d, LSL #16
    MOVK  X23, #0xc3af, LSL #32
    MOVK  X23, #0xecd4, LSL #48
    MOVZ  X24, #0xa9ab, LSL #0
    MOVK  X24, #0xa108, LSL #16
    MOVK  X24, #0xae95, LSL #32
    MOVK  X24, #0xb8e6, LSL #48
    MOVZ  X25, #0x6c99, LSL #0
    MOVK  X25, #0xb651, LSL #16
    MOVK  X25, #0x14af, LSL #32
    MOVK  X25, #0x879c, LSL #48
    MOVZ  X26, #0x5239, LSL #0
    MOVK  X26, #0x6f56, LSL #16
    MOVK  X26, #0xf933, LSL #32
    MOVK  X26, #0x72d9, LSL #48
    MOVZ  X27, #0x9596, LSL #0
    MOVK  X27, #0xf8f, LSL #16
    MOVK  X27, #0x7882, LSL #32
    MOVK  X27, #0x2e96, LSL #48
    MOVZ  X28, #0x8cba, LSL #0
    MOVK  X28, #0x6969, LSL #16
    MOVK  X28, #0x9db7, LSL #32
    MOVK  X28, #0xddc4, LSL #48
    MOVZ  X29, #0x43ad, LSL #0
    MOVK  X29, #0xde49, LSL #16
    MOVK  X29, #0xc220, LSL #32
    MOVK  X29, #0xf63f, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X23
    FMOV  D1, X3
    FMOV  V1.D[1], X18
    FMOV  D2, X19
    FMOV  V2.D[1], X29
    FMOV  D3, X25
    FMOV  V3.D[1], X28
    FMOV  D4, X27
    FMOV  V4.D[1], X8
    FMOV  D5, X11
    FMOV  V5.D[1], X7
    FMOV  D6, X19
    FMOV  V6.D[1], X29
    FMOV  D7, X29
    FMOV  V7.D[1], X22
    FMOV  D8, X7
    FMOV  V8.D[1], X6
    FMOV  D9, X24
    FMOV  V9.D[1], X9
    FMOV  D10, X26
    FMOV  V10.D[1], X16
    FMOV  D11, X28
    FMOV  V11.D[1], X3
    FMOV  D12, X6
    FMOV  V12.D[1], X29
    FMOV  D13, X14
    FMOV  V13.D[1], X8
    FMOV  D14, X6
    FMOV  V14.D[1], X26
    FMOV  D15, X2
    FMOV  V15.D[1], X18
    FMOV  D16, X18
    FMOV  V16.D[1], X8
    FMOV  D17, X7
    FMOV  V17.D[1], X29
    FMOV  D18, X14
    FMOV  V18.D[1], X16
    FMOV  D19, X29
    FMOV  V19.D[1], X6
    FMOV  D20, X19
    FMOV  V20.D[1], X7
    FMOV  D21, X26
    FMOV  V21.D[1], X26
    FMOV  D22, X27
    FMOV  V22.D[1], X22
    FMOV  D23, X6
    FMOV  V23.D[1], X23
    FMOV  D24, X22
    FMOV  V24.D[1], X4
    FMOV  D25, X8
    FMOV  V25.D[1], X27
    FMOV  D26, X3
    FMOV  V26.D[1], X22
    FMOV  D27, X11
    FMOV  V27.D[1], X17
    FMOV  D28, X11
    FMOV  V28.D[1], X23
    FMOV  D29, X29
    FMOV  V29.D[1], X26
    FMOV  D30, X21
    FMOV  V30.D[1], X23
    FMOV  D31, X29
    FMOV  V31.D[1], X3
    MOVZ  X26, #0xa, LSL #0
TaishanSimdPermuteP01_label_491:
    FCMGT  V3.2D, V25.2D, #0.0
    FCMEQ  V4.2S, V30.2S, V10.2S
    FCMGE  S17, S29, #0.0
    FCMGE  V31.2S, V19.2S, V4.2S
    CMHS  V1.4H, V27.4H, V28.4H
    FCMEQ  S29, S18, #0.0
    FCMGE  D31, D28, D3
    FCMGT  S17, S26, #0.0
    CMLT  V13.8B, V23.8B, #0
    FCMLE  V13.4S, V16.4S, #0.0
    CMHI  V24.4H, V22.4H, V23.4H
    FCMGT  S8, S30, S10
    CMHI  V1.4H, V1.4H, V21.4H
    CMTST  D7, D17, D9
    FCMGT  S31, S17, S11
    FCMEQ  D20, D11, D1
    FCMGE  D13, D18, D31
    FCMGT  V27.2S, V18.2S, #0.0
    FCMEQ  D29, D8, #0.0
    FACGE  S2, S3, S20
    FCMEQ  S13, S4, #0.0
    FACGE  V5.2S, V31.2S, V22.2S
    FCMEQ  V24.2S, V5.2S, V23.2S
    FCMEQ  D15, D13, #0.0
    CMHI  V12.16B, V26.16B, V29.16B
    CMEQ  V10.4H, V28.4H, #0
    CMGE  V27.2S, V26.2S, #0
    FCMLE  D13, D20, #0.0
    CMGT  D15, D21, D18
    FACGT  D9, D26, D9
    CMLT  V17.8H, V26.8H, #0
    FCMGE  V19.4S, V27.4S, #0.0
    FCMGT  S31, S27, S13
    CMEQ  V11.4S, V3.4S, #0
    FCMGE  V10.2S, V19.2S, #0.0
    FCMGE  D16, D2, D22
    FCMGE  D7, D29, D2
    CMGT  D26, D19, #0
    FCMGE  V17.4S, V29.4S, V19.4S
    FCMLE  D17, D25, #0.0
    FCMEQ  D28, D14, #0.0
    CMTST  D2, D21, D13
    FACGT  D21, D10, D22
    CMGE  V8.4H, V22.4H, #0
    FACGE  D6, D3, D27
    FACGT  D20, D7, D29
    FCMLT  D19, D4, #0.0
    CMEQ  D31, D29, D7
    FCMGT  S10, S7, S26
    FACGE  V31.2D, V17.2D, V2.2D
    CMTST  D17, D16, D21
    FCMGE  S28, S10, #0.0
    CMEQ  V6.16B, V19.16B, V0.16B
    FCMEQ  V29.4S, V14.4S, V28.4S
    CMGT  V8.4S, V29.4S, V1.4S
    CMLT  V23.4S, V29.4S, #0
    FACGE  V3.4S, V21.4S, V23.4S
    FCMGE  S13, S16, #0.0
    CMLE  D2, D4, #0
    FCMGE  D19, D2, #0.0
    FCMLE  S19, S13, #0.0
    CMLT  D2, D22, #0
    CMGE  V5.4H, V22.4H, V9.4H
    FCMGE  S28, S24, S22
    FCMGE  V29.4S, V20.4S, #0.0
    CMEQ  V20.16B, V31.16B, V21.16B
    CMGE  V13.16B, V6.16B, #0
    FCMGE  S14, S14, S27
    CMGE  D20, D20, #0
    CMGE  V2.4H, V29.4H, V9.4H
    CMHS  V24.2D, V18.2D, V8.2D
    FCMEQ  V3.2S, V31.2S, #0.0
    FCMGT  V23.2S, V24.2S, #0.0
    FCMGE  V3.2D, V3.2D, V7.2D
    FCMGT  V5.2S, V26.2S, #0.0
    FCMEQ  D19, D26, #0.0
    CMGT  D8, D24, D7
    CMHI  V31.4H, V24.4H, V30.4H
    FCMGE  D6, D8, D11
    FCMEQ  V7.4S, V4.4S, #0.0
    FCMEQ  D15, D23, #0.0
    CMHI  V22.2S, V24.2S, V4.2S
    FCMGT  S26, S9, S4
    FCMEQ  V18.2S, V25.2S, #0.0
    FCMGE  S23, S20, #0.0
    FCMLT  S12, S19, #0.0
    CMGE  V15.8B, V19.8B, V30.8B
    FACGT  S27, S12, S29
    CMTST  D12, D24, D26
    CMTST  D7, D7, D29
    FCMGE  S12, S22, S31
    FCMLT  S22, S5, #0.0
    CMGT  V11.4H, V22.4H, V23.4H
    FCMLT  V20.4S, V12.4S, #0.0
    FCMEQ  D13, D20, #0.0
    FACGT  S25, S12, S3
    CMGT  V7.4S, V31.4S, #0
    CMLE  V14.4H, V12.4H, #0
    CMHS  V27.8B, V24.8B, V9.8B
    FACGE  V1.2D, V6.2D, V13.2D
    CMEQ  V15.4S, V19.4S, V18.4S
    FCMEQ  D28, D17, #0.0
    FACGT  S24, S27, S5
    CMGT  V13.4S, V30.4S, V6.4S
    CMEQ  V17.2S, V13.2S, #0
    CMEQ  V27.16B, V21.16B, #0
    CMTST  V8.2S, V9.2S, V27.2S
    CMGE  D9, D7, D1
    CMEQ  D24, D21, #0
    CMHS  D9, D19, D30
    CMGE  V6.8B, V14.8B, #0
    CMEQ  V12.8B, V8.8B, V31.8B
    FACGT  D3, D4, D4
    FCMGT  D11, D25, #0.0
    FCMEQ  S18, S17, S27
    CMLE  D6, D31, #0
    CMEQ  V29.4H, V6.4H, #0
    FCMEQ  D0, D30, D20
    CMGT  V12.8H, V19.8H, V23.8H
    CMHS  D2, D9, D19
    FCMGT  S13, S25, #0.0
    FACGE  D10, D5, D31
    CMEQ  D27, D0, #0
    CMHI  V10.4S, V24.4S, V25.4S
    CMLT  D0, D14, #0
    CMHI  D10, D10, D2
    CMLE  D31, D28, #0
    FACGT  S10, S21, S24
    FCMLE  V5.4S, V11.4S, #0.0
    FACGT  V18.2D, V15.2D, V24.2D
    FACGT  S18, S5, S25
    CMGE  V25.2S, V12.2S, #0
    CMEQ  V9.8B, V23.8B, #0
    FCMEQ  V18.2S, V9.2S, #0.0
    FCMGE  S19, S23, S23
    FCMGE  D3, D8, D22
    CMGT  D0, D18, D28
    FCMLT  S27, S3, #0.0
    FCMLE  D24, D8, #0.0
    FCMGE  V18.2S, V27.2S, V30.2S
    FACGE  S19, S20, S24
    FCMGT  D31, D0, D2
    FCMLT  V18.2S, V27.2S, #0.0
    CMGE  V20.2S, V27.2S, V10.2S
    FCMLT  S17, S19, #0.0
    CMGT  D8, D9, #0
    FCMEQ  V17.2D, V26.2D, #0.0
    CMHI  V25.2S, V13.2S, V5.2S
    CMGT  D12, D11, #0
    CMTST  D31, D11, D1
    FCMGE  V25.2D, V10.2D, V29.2D
    CMGE  V9.8H, V23.8H, V5.8H
    CMGE  D4, D19, #0
    FCMLE  V19.4S, V19.4S, #0.0
    CMGE  D30, D18, D18
    CMGT  V18.4S, V3.4S, V6.4S
    CMLE  D9, D13, #0
    FCMGE  D21, D3, #0.0
    CMGT  D7, D10, #0
    CMEQ  D17, D18, #0
    FACGT  S2, S25, S19
    CMEQ  V21.4H, V24.4H, #0
    CMLE  D7, D10, #0
    FCMGE  D5, D20, #0.0
    CMGT  V15.16B, V7.16B, #0
    CMTST  V8.2S, V18.2S, V30.2S
    CMTST  D17, D18, D28
    FACGE  V2.2D, V17.2D, V3.2D
    FCMEQ  S5, S21, S5
    FACGE  S0, S31, S28
    FCMLE  S15, S23, #0.0
    FCMEQ  V31.4S, V26.4S, #0.0
    FCMEQ  D10, D8, #0.0
    CMGT  V27.2S, V8.2S, V2.2S
    CMHI  V25.8B, V9.8B, V30.8B
    FACGT  S4, S7, S15
    CMHS  D20, D12, D5
    FCMLE  D3, D13, #0.0
    FCMGE  D2, D12, D0
    FCMLT  D16, D18, #0.0
    FACGE  D24, D31, D13
    CMHI  V1.8H, V9.8H, V20.8H
    FACGE  V25.4S, V17.4S, V4.4S
    FCMEQ  S31, S31, S13
    FCMGT  D2, D0, #0.0
    CMEQ  V18.8H, V22.8H, #0
    CMLE  D1, D23, #0
    CMLT  D20, D28, #0
    CMGE  V9.4S, V0.4S, #0
    CMGE  D18, D5, #0
    CMHI  V24.4H, V20.4H, V1.4H
    FCMGT  S22, S20, S7
    FCMEQ  V27.2D, V5.2D, V3.2D
    FACGE  V29.2S, V23.2S, V12.2S
    FCMGE  D12, D20, #0.0
    CMEQ  D2, D28, #0
    FACGE  S4, S25, S20
    FCMEQ  D2, D27, #0.0
    CMHS  D17, D13, D12
    FCMEQ  V24.4S, V14.4S, V26.4S
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdPermuteP01_label_491
    MOVZ  X13, #0xb20b, LSL #0
    MOVK  X13, #0x3427, LSL #16
    MOVK  X13, #0xbcaf, LSL #32
    MOVK  X13, #0x4e99, LSL #48
    SUB  X22, X13, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x7bc3, LSL #0
    MOVK  X28, #0x8837, LSL #16
    MOVK  X28, #0x6384, LSL #32
    MOVK  X28, #0x4175, LSL #48
    SUB  X27, X28, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x107a, LSL #0
    MOVK  X27, #0x98b7, LSL #16
    MOVK  X27, #0x2c91, LSL #32
    MOVK  X27, #0xdd20, LSL #48
    SUB  X22, X27, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x651d, LSL #0
    MOVK  X6, #0xcb99, LSL #16
    MOVK  X6, #0x269f, LSL #32
    MOVK  X6, #0x2440, LSL #48
    SUB  X3, X6, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x651d, LSL #0
    MOVK  X26, #0xcb99, LSL #16
    MOVK  X26, #0x269f, LSL #32
    MOVK  X26, #0x2440, LSL #48
    SUB  X29, X26, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x4fe2, LSL #0
    MOVK  X29, #0x4ed8, LSL #16
    MOVK  X29, #0xf69d, LSL #32
    MOVK  X29, #0x1b24, LSL #48
    SUB  X3, X29, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xf542, LSL #0
    MOVK  X9, #0x7beb, LSL #16
    MOVK  X9, #0xf5d2, LSL #32
    MOVK  X9, #0x5bce, LSL #48
    SUB  X11, X9, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xf542, LSL #0
    MOVK  X9, #0x7beb, LSL #16
    MOVK  X9, #0xf5d2, LSL #32
    MOVK  X9, #0x5bce, LSL #48
    SUB  X28, X9, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x7686, LSL #0
    MOVK  X28, #0xd3eb, LSL #16
    MOVK  X28, #0x823d, LSL #32
    MOVK  X28, #0x610b, LSL #48
    SUB  X3, X28, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x5ed4, LSL #0
    MOVK  X19, #0x8101, LSL #16
    MOVK  X19, #0x9db9, LSL #32
    MOVK  X19, #0xdfda, LSL #48
    SUB  X26, X19, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xb20b, LSL #0
    MOVK  X2, #0x3427, LSL #16
    MOVK  X2, #0xbcaf, LSL #32
    MOVK  X2, #0x4e99, LSL #48
    SUB  X21, X2, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x1197, LSL #0
    MOVK  X2, #0x1ee6, LSL #16
    MOVK  X2, #0xae27, LSL #32
    MOVK  X2, #0x4a37, LSL #48
    SUB  X18, X2, X14
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xfed4, LSL #0
    MOVK  X2, #0x3eb4, LSL #16
    MOVK  X2, #0x9784, LSL #32
    MOVK  X2, #0x7876, LSL #48
    SUB  X5, X2, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0xb415, LSL #0
    MOVK  X8, #0x7a8e, LSL #16
    MOVK  X8, #0x4b52, LSL #32
    MOVK  X8, #0xc3fc, LSL #48
    SUB  X16, X8, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x5ed4, LSL #0
    MOVK  X27, #0x8101, LSL #16
    MOVK  X27, #0x9db9, LSL #32
    MOVK  X27, #0xdfda, LSL #48
    SUB  X16, X27, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0xb8a4, LSL #0
    MOVK  X19, #0xbf15, LSL #16
    MOVK  X19, #0x1919, LSL #32
    MOVK  X19, #0xc06f, LSL #48
    SUB  X20, X19, X20
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X21
TaishanSimdPermuteP01_label_104:
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X2, X21, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0xa9ab, LSL #0
    MOVK  X29, #0xa108, LSL #16
    MOVK  X29, #0xae95, LSL #32
    MOVK  X29, #0xb8e6, LSL #48
    SUB  X6, X29, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x6c99, LSL #0
    MOVK  X20, #0xb651, LSL #16
    MOVK  X20, #0x14af, LSL #32
    MOVK  X20, #0x879c, LSL #48
    SUB  X17, X20, X25
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0x5ed4, LSL #0
    MOVK  X23, #0x8101, LSL #16
    MOVK  X23, #0x9db9, LSL #32
    MOVK  X23, #0xdfda, LSL #48
    SUB  X29, X23, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x7686, LSL #0
    MOVK  X21, #0xd3eb, LSL #16
    MOVK  X21, #0x823d, LSL #32
    MOVK  X21, #0x610b, LSL #48
    SUB  X22, X21, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D2
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X21, X27, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D3
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X10, X16, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D5
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X6, X23, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D6
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X25, X24, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D7
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X20, X19, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X25, X2, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D9
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X25, X2, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X2, X20, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D10
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X2, X20, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X13
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D14
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X21, X13, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X22, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D17
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D18
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X24, X26, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D19
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D20
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X16, X2, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D21
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D23
    MOVZ  X21, #0x0, LSL #0
    SUB  X22, X21, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X17, X14, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X24, X18, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D25
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X24, X18, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D26
    MOVZ  X21, #0x0, LSL #0
    SUB  X6, X21, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X10, X9, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D27
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D28
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X18, X20, X29
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D29
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X22, X25, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
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
    FMOV  V0.D[1], X7
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X10
    FMOV  D3, X10
    FMOV  V3.D[1], X16
    FMOV  D4, X21
    FMOV  V4.D[1], X8
    FMOV  D5, X24
    FMOV  V5.D[1], X18
    FMOV  D6, X29
    FMOV  V6.D[1], X25
    FMOV  D7, X27
    FMOV  V7.D[1], X19
    FMOV  D8, X9
    FMOV  V8.D[1], X5
    FMOV  D9, X2
    FMOV  V9.D[1], X8
    FMOV  D10, X9
    FMOV  V10.D[1], X19
    FMOV  D11, X8
    FMOV  V11.D[1], X23
    FMOV  D12, X9
    FMOV  V12.D[1], X8
    FMOV  D13, X19
    FMOV  V13.D[1], X10
    FMOV  D14, X25
    FMOV  V14.D[1], X24
    FMOV  D15, X9
    FMOV  V15.D[1], X13
    FMOV  D16, X3
    FMOV  V16.D[1], X26
    FMOV  D17, X21
    FMOV  V17.D[1], X11
    FMOV  D18, X5
    FMOV  V18.D[1], X16
    FMOV  D19, X20
    FMOV  V19.D[1], X18
    FMOV  D20, X18
    FMOV  V20.D[1], X16
    FMOV  D21, X27
    FMOV  V21.D[1], X5
    FMOV  D22, X25
    FMOV  V22.D[1], X4
    FMOV  D23, X9
    FMOV  V23.D[1], X16
    FMOV  D24, X28
    FMOV  V24.D[1], X11
    FMOV  D25, X29
    FMOV  V25.D[1], X14
    FMOV  D26, X11
    FMOV  V26.D[1], X29
    FMOV  D27, X8
    FMOV  V27.D[1], X17
    FMOV  D28, X28
    FMOV  V28.D[1], X26
    FMOV  D29, X3
    FMOV  V29.D[1], X18
    FMOV  D30, X26
    FMOV  V30.D[1], X23
    FMOV  D31, X19
    FMOV  V31.D[1], X20
    MOVZ  X10, #0xa, LSL #0
TaishanSimdPermuteP01_label_571:
    FCMGT  S4, S11, #0.0
    CMGT  D21, D6, D4
    FCMGT  D30, D1, #0.0
    FCMEQ  D19, D27, D17
    CMGT  V29.8H, V16.8H, V22.8H
    FCMEQ  D15, D17, D19
    CMGT  D23, D28, D4
    FCMGT  V6.2S, V3.2S, #0.0
    CMEQ  V30.8B, V0.8B, V5.8B
    CMGE  V13.8B, V7.8B, V26.8B
    CMGT  D29, D24, D30
    FCMGT  V31.2S, V26.2S, #0.0
    FCMLE  V13.2D, V8.2D, #0.0
    FCMGT  S7, S28, #0.0
    CMEQ  D25, D0, D23
    CMLT  D12, D27, #0
    FCMLE  V31.4S, V12.4S, #0.0
    CMGT  V21.16B, V31.16B, #0
    FCMLE  S4, S16, #0.0
    FCMGE  D4, D25, D15
    FCMGE  V13.2D, V0.2D, #0.0
    FACGE  V29.2S, V22.2S, V7.2S
    CMGE  V8.16B, V11.16B, V11.16B
    FCMLT  S13, S28, #0.0
    CMLT  D31, D28, #0
    CMGT  V19.8H, V5.8H, V23.8H
    FCMEQ  V31.2D, V27.2D, #0.0
    FACGE  S19, S19, S22
    FCMGE  S11, S8, S14
    FCMGT  D31, D17, #0.0
    CMTST  V6.4H, V2.4H, V15.4H
    CMLE  D25, D13, #0
    CMGT  D19, D10, #0
    CMLT  V17.8H, V16.8H, #0
    CMTST  D22, D10, D13
    FCMGT  V31.2D, V15.2D, #0.0
    FCMGE  D27, D2, D14
    CMHI  D28, D12, D22
    FACGE  D22, D31, D29
    CMGT  V17.4S, V29.4S, #0
    CMLT  V14.4S, V2.4S, #0
    CMEQ  D30, D22, #0
    FCMGT  S16, S7, S30
    CMLT  V20.8B, V6.8B, #0
    FCMLE  S21, S29, #0.0
    FCMLE  V24.4S, V16.4S, #0.0
    FACGT  S3, S8, S0
    FACGE  D20, D4, D23
    CMGT  D10, D16, #0
    CMTST  V8.2D, V14.2D, V12.2D
    FCMEQ  V6.2D, V14.2D, V15.2D
    FCMGT  D19, D5, D4
    FACGT  S7, S14, S20
    CMGT  D3, D1, D15
    CMGT  V21.4H, V8.4H, V10.4H
    CMGE  D14, D23, D20
    FCMGT  V25.4S, V19.4S, V19.4S
    FCMGT  V0.2S, V30.2S, V28.2S
    CMTST  V15.4H, V6.4H, V14.4H
    CMEQ  D17, D17, #0
    FCMGE  D8, D27, #0.0
    CMHS  D28, D22, D24
    CMTST  V3.2D, V16.2D, V7.2D
    FCMGT  V4.2S, V27.2S, V0.2S
    CMHS  V29.4H, V4.4H, V29.4H
    FCMGE  D21, D15, D18
    FCMGE  V20.4S, V3.4S, V30.4S
    CMGE  D15, D13, #0
    FCMEQ  V6.2D, V13.2D, V19.2D
    CMEQ  D1, D4, D17
    FACGE  V15.2D, V1.2D, V5.2D
    FACGT  D4, D4, D8
    CMLT  V14.2S, V11.2S, #0
    FCMLT  D29, D5, #0.0
    CMGE  V12.2D, V22.2D, V20.2D
    FCMEQ  S12, S29, S17
    FCMGT  D6, D11, D14
    CMGE  V19.8B, V30.8B, #0
    FCMGE  S26, S7, S5
    FCMLE  V25.4S, V21.4S, #0.0
    FCMEQ  V14.2S, V25.2S, V17.2S
    FACGT  V6.2S, V2.2S, V23.2S
    CMHS  V5.4H, V18.4H, V3.4H
    FCMLE  S23, S18, #0.0
    FACGE  D7, D23, D12
    FCMEQ  S3, S20, #0.0
    FCMGE  S16, S22, #0.0
    CMGT  V31.4S, V18.4S, #0
    CMGE  V31.2D, V3.2D, V11.2D
    FCMGE  D13, D24, D4
    FACGT  V17.4S, V27.4S, V17.4S
    FCMGT  S14, S0, S1
    FCMGE  D7, D4, #0.0
    FCMEQ  S30, S30, S2
    FCMLT  V23.4S, V9.4S, #0.0
    FACGT  S26, S14, S10
    FCMEQ  D25, D4, D8
    CMHI  D14, D12, D23
    FCMEQ  V18.2S, V22.2S, #0.0
    FCMEQ  S30, S30, #0.0
    FCMGT  D14, D27, #0.0
    FACGE  D26, D15, D14
    FCMEQ  S20, S3, S0
    CMEQ  D31, D3, D16
    CMLE  D30, D18, #0
    CMGT  D14, D21, #0
    FACGT  S28, S6, S7
    CMGT  V12.8B, V25.8B, #0
    CMGT  D17, D14, D12
    FACGT  D21, D31, D6
    CMGE  V18.8H, V20.8H, V11.8H
    FCMLE  V5.2D, V2.2D, #0.0
    CMGE  D2, D15, #0
    FCMEQ  V5.2D, V22.2D, V13.2D
    FCMEQ  S7, S16, S18
    CMEQ  D19, D0, #0
    CMLE  V17.4H, V5.4H, #0
    FCMLT  D8, D9, #0.0
    FACGE  S17, S12, S13
    CMGT  D14, D0, D22
    CMEQ  V24.2S, V2.2S, #0
    FCMGE  V19.2S, V29.2S, #0.0
    FCMGT  D14, D23, #0.0
    FCMGE  S27, S9, S31
    FCMLT  D20, D17, #0.0
    FCMGT  V28.2D, V7.2D, V21.2D
    FCMEQ  V28.2S, V18.2S, #0.0
    FCMEQ  V17.2S, V1.2S, V6.2S
    FCMGE  V11.2D, V24.2D, #0.0
    CMTST  V28.8B, V18.8B, V17.8B
    FCMEQ  S16, S13, S13
    CMEQ  D3, D17, D11
    CMHI  D23, D8, D2
    CMHI  D27, D7, D25
    CMHS  D31, D8, D30
    CMEQ  D22, D9, D5
    CMGE  D9, D6, D17
    CMHI  D3, D5, D27
    CMGT  V31.2D, V27.2D, #0
    CMTST  D28, D25, D6
    FCMGE  D13, D25, #0.0
    CMTST  D6, D20, D9
    FCMEQ  V15.2S, V2.2S, V15.2S
    FCMGE  D30, D23, D27
    CMGT  V13.16B, V21.16B, V28.16B
    FCMEQ  S16, S2, S9
    CMHI  V1.4S, V10.4S, V8.4S
    FCMEQ  D2, D6, D20
    FCMGT  S11, S26, S20
    CMLE  D15, D11, #0
    FCMLT  V7.2S, V21.2S, #0.0
    CMGT  V12.4H, V1.4H, V3.4H
    CMGT  V30.2S, V21.2S, V4.2S
    FCMEQ  D4, D31, D22
    CMGE  D14, D25, #0
    FCMEQ  D19, D0, D14
    FCMLE  S6, S5, #0.0
    CMHI  D10, D5, D2
    FCMGT  S10, S28, S31
    CMGT  V11.16B, V26.16B, V19.16B
    FCMGE  D4, D22, #0.0
    FCMGE  V16.2D, V25.2D, V16.2D
    CMGT  V29.2D, V29.2D, #0
    FCMEQ  S30, S21, #0.0
    FACGE  V13.2S, V20.2S, V13.2S
    CMEQ  D8, D14, D15
    FCMGT  D26, D22, #0.0
    FCMGT  S1, S27, S31
    CMEQ  V27.4H, V23.4H, #0
    FACGT  D20, D5, D27
    FCMEQ  V14.4S, V27.4S, V12.4S
    FCMGT  V8.4S, V13.4S, #0.0
    FCMGT  D13, D30, D19
    CMGE  D23, D20, #0
    FACGE  D18, D26, D19
    FACGT  V14.2S, V25.2S, V14.2S
    CMHS  D19, D2, D1
    CMHI  D6, D31, D17
    CMGT  D29, D30, D6
    CMEQ  D11, D4, #0
    FACGE  D15, D29, D27
    FCMGE  V9.2S, V13.2S, #0.0
    CMTST  V30.16B, V0.16B, V8.16B
    FCMEQ  V30.2S, V22.2S, V30.2S
    FCMGT  D11, D17, D2
    FCMEQ  V23.2D, V17.2D, V23.2D
    FACGT  S8, S24, S18
    FCMGE  S0, S10, #0.0
    FCMGT  D12, D6, D0
    FCMLT  V22.4S, V18.4S, #0.0
    CMEQ  V22.4S, V21.4S, V14.4S
    FCMEQ  V15.4S, V31.4S, #0.0
    FCMLT  D13, D20, #0.0
    CMEQ  D1, D30, #0
    FCMEQ  S2, S9, #0.0
    FCMLE  V19.4S, V22.4S, #0.0
    FCMGE  S16, S2, #0.0
    CMLT  V15.2S, V28.2S, #0
    FCMGE  S19, S4, S14
    FACGE  D23, D19, D29
    SUBS  X10, X10, #0x1
    B.NE  TaishanSimdPermuteP01_label_571
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X4, X24, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X2, X13, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X25
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X17, X6, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X29
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D4
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X20, X24, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X8, X21, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D5
    MOVZ  X21, #0x0, LSL #0
    SUB  X8, X21, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D6
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D7
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D8
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D9
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X18, X27, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D11
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X19
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D16
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    SUB  X20, X23, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D17
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X28, X11, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D20
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X4, X11, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D22
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X4, X11, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D24
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X8, X27, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D25
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X3, X4, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D26
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D27
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X6, X2, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D29
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X17, X25, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
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
    FMOV  D0, X17
    FMOV  V0.D[1], X3
    FMOV  D1, X7
    FMOV  V1.D[1], X2
    FMOV  D2, X26
    FMOV  V2.D[1], X4
    FMOV  D3, X6
    FMOV  V3.D[1], X12
    FMOV  D4, X22
    FMOV  V4.D[1], X6
    FMOV  D5, X24
    FMOV  V5.D[1], X20
    FMOV  D6, X10
    FMOV  V6.D[1], X7
    FMOV  D7, X29
    FMOV  V7.D[1], X19
    FMOV  D8, X14
    FMOV  V8.D[1], X6
    FMOV  D9, X13
    FMOV  V9.D[1], X25
    FMOV  D10, X26
    FMOV  V10.D[1], X16
    FMOV  D11, X4
    FMOV  V11.D[1], X6
    FMOV  D12, X7
    FMOV  V12.D[1], X12
    FMOV  D13, X8
    FMOV  V13.D[1], X3
    FMOV  D14, X13
    FMOV  V14.D[1], X6
    FMOV  D15, X4
    FMOV  V15.D[1], X13
    FMOV  D16, X25
    FMOV  V16.D[1], X14
    FMOV  D17, X9
    FMOV  V17.D[1], X24
    FMOV  D18, X13
    FMOV  V18.D[1], X29
    FMOV  D19, X5
    FMOV  V19.D[1], X3
    FMOV  D20, X2
    FMOV  V20.D[1], X2
    FMOV  D21, X26
    FMOV  V21.D[1], X13
    FMOV  D22, X25
    FMOV  V22.D[1], X27
    FMOV  D23, X23
    FMOV  V23.D[1], X25
    FMOV  D24, X2
    FMOV  V24.D[1], X16
    FMOV  D25, X28
    FMOV  V25.D[1], X13
    FMOV  D26, X19
    FMOV  V26.D[1], X13
    FMOV  D27, X14
    FMOV  V27.D[1], X6
    FMOV  D28, X29
    FMOV  V28.D[1], X26
    FMOV  D29, X6
    FMOV  V29.D[1], X3
    FMOV  D30, X7
    FMOV  V30.D[1], X27
    FMOV  D31, X29
    FMOV  V31.D[1], X18
    MOVZ  X20, #0xf, LSL #0
TaishanSimdPermuteP01_label_651:
    CMHS  V14.2S, V5.2S, V6.2S
    CMHS  V22.4S, V30.4S, V17.4S
    CMEQ  V21.8H, V30.8H, V24.8H
    CMGE  D28, D21, D29
    FCMEQ  D25, D25, #0.0
    FCMEQ  D4, D2, #0.0
    FACGT  D9, D31, D18
    CMEQ  D2, D12, D21
    FCMGE  V19.2S, V27.2S, V10.2S
    FCMGT  D16, D15, D22
    CMLT  V15.4S, V26.4S, #0
    FCMEQ  V9.4S, V24.4S, V2.4S
    CMLT  D30, D7, #0
    FACGT  V30.4S, V14.4S, V27.4S
    FCMGT  D8, D5, #0.0
    FCMGE  D13, D10, #0.0
    CMLE  V28.2D, V29.2D, #0
    CMGT  D16, D18, #0
    FCMGT  V25.4S, V25.4S, #0.0
    CMGT  D1, D27, D30
    FACGE  V12.2S, V31.2S, V20.2S
    FACGT  D19, D9, D22
    FCMGE  V9.2S, V21.2S, V13.2S
    FCMLE  D22, D30, #0.0
    FCMEQ  V4.2S, V1.2S, #0.0
    CMGT  D14, D12, D13
    FCMLE  D23, D27, #0.0
    CMGE  V3.2S, V21.2S, #0
    CMGE  V3.8B, V10.8B, V23.8B
    FCMLE  D13, D26, #0.0
    CMGE  D30, D27, D22
    CMHS  D23, D1, D7
    FACGT  S26, S0, S16
    FCMGE  V23.2S, V0.2S, #0.0
    FCMGT  V5.4S, V29.4S, #0.0
    FCMEQ  D6, D23, #0.0
    FACGE  V10.4S, V28.4S, V17.4S
    FCMGT  D23, D29, #0.0
    CMGE  D20, D15, D0
    FCMGE  D23, D20, D18
    FCMEQ  D18, D18, #0.0
    FACGT  D23, D12, D12
    CMHS  V27.4H, V8.4H, V0.4H
    CMGT  D1, D0, D6
    FCMEQ  D3, D3, #0.0
    FCMEQ  V15.4S, V5.4S, #0.0
    CMHI  D15, D8, D17
    FCMGE  V14.4S, V7.4S, V29.4S
    FCMEQ  V30.4S, V13.4S, V10.4S
    FCMLE  V29.2S, V28.2S, #0.0
    CMLT  V28.16B, V9.16B, #0
    CMLT  D3, D15, #0
    CMLT  D20, D8, #0
    FCMGT  S3, S28, S10
    CMGE  V14.2D, V14.2D, #0
    CMGT  V9.8B, V30.8B, V28.8B
    CMLT  D14, D5, #0
    FCMLE  D14, D5, #0.0
    CMGT  D5, D8, D28
    FCMGT  D29, D14, #0.0
    CMHS  D16, D14, D29
    FCMLE  D27, D20, #0.0
    CMGE  V14.2S, V9.2S, #0
    CMGT  V27.2D, V5.2D, V27.2D
    CMLT  D14, D3, #0
    FCMEQ  D20, D16, #0.0
    FACGT  V7.2D, V24.2D, V17.2D
    CMLT  V21.8B, V31.8B, #0
    CMHI  V0.16B, V20.16B, V6.16B
    FACGE  D5, D22, D7
    FCMGT  S30, S14, #0.0
    FCMEQ  S3, S8, #0.0
    CMGT  D15, D30, D15
    FCMGT  V24.2D, V24.2D, #0.0
    CMGE  D17, D27, #0
    FCMLE  D1, D9, #0.0
    CMGE  V1.8H, V17.8H, #0
    FCMLT  S21, S18, #0.0
    FCMGE  V17.2S, V18.2S, V24.2S
    CMGT  V0.4S, V18.4S, #0
    CMGT  D13, D31, #0
    FCMGT  D24, D12, D24
    CMLE  D0, D17, #0
    FACGE  D5, D8, D12
    CMEQ  V26.8H, V3.8H, V31.8H
    FCMEQ  D24, D22, D27
    CMEQ  V0.2D, V8.2D, V31.2D
    FCMGT  D3, D21, #0.0
    FCMGE  D24, D8, #0.0
    CMEQ  V25.2D, V26.2D, V3.2D
    FCMGT  V18.2S, V31.2S, #0.0
    CMEQ  D9, D3, D25
    FCMEQ  V7.2D, V25.2D, V16.2D
    CMLT  D10, D19, #0
    FACGT  D17, D3, D18
    FCMEQ  S4, S29, #0.0
    FCMLT  S3, S3, #0.0
    FCMGE  V29.2D, V26.2D, V30.2D
    CMGT  V25.2D, V5.2D, #0
    CMEQ  D7, D24, #0
    FACGT  S18, S10, S20
    FCMGT  S27, S9, #0.0
    CMGT  V12.2D, V10.2D, #0
    FACGE  S22, S23, S9
    FCMEQ  S0, S29, S8
    CMLT  D28, D18, #0
    FCMLT  D17, D13, #0.0
    FCMGE  D21, D10, #0.0
    FACGT  S18, S22, S3
    CMLE  D5, D12, #0
    FCMGE  S8, S1, #0.0
    CMGE  D19, D19, #0
    FCMEQ  D9, D21, #0.0
    FCMLE  D16, D19, #0.0
    FCMGE  S16, S12, S27
    CMHI  V0.4H, V0.4H, V28.4H
    FCMGE  V22.2S, V5.2S, V11.2S
    FCMEQ  S30, S9, S22
    FACGT  S22, S8, S26
    FACGT  D10, D2, D25
    CMTST  V15.4H, V10.4H, V17.4H
    FACGT  S8, S20, S21
    FCMGT  S31, S15, S24
    FCMEQ  S18, S1, S18
    FCMEQ  S23, S2, #0.0
    FCMGT  D8, D31, #0.0
    CMLE  D20, D11, #0
    FCMGT  D8, D15, D13
    FCMLT  V20.2S, V3.2S, #0.0
    FCMGT  D23, D15, #0.0
    CMHS  D0, D23, D24
    FACGE  S18, S5, S16
    FCMEQ  V18.2S, V1.2S, V8.2S
    CMGT  V27.2D, V15.2D, V1.2D
    FCMGT  S13, S17, #0.0
    FCMLE  V19.2D, V3.2D, #0.0
    FCMLE  V1.2S, V20.2S, #0.0
    CMHS  V30.8H, V2.8H, V3.8H
    CMEQ  V6.4H, V9.4H, #0
    CMGE  D19, D9, D22
    CMGE  V14.4H, V16.4H, V31.4H
    CMGE  V23.4H, V12.4H, #0
    FCMLT  S28, S27, #0.0
    CMGE  D1, D11, #0
    FCMEQ  V16.2S, V5.2S, V1.2S
    CMGT  V1.16B, V30.16B, V12.16B
    CMGE  V25.4H, V0.4H, V2.4H
    FCMEQ  V13.2D, V0.2D, V28.2D
    CMEQ  D27, D19, #0
    CMHS  V24.2S, V17.2S, V16.2S
    FACGT  S10, S15, S6
    CMEQ  D30, D2, #0
    CMLT  D24, D4, #0
    CMLT  D5, D4, #0
    CMGE  V7.16B, V12.16B, V27.16B
    FCMGE  V3.2D, V28.2D, #0.0
    CMEQ  D31, D15, D16
    FCMGE  V14.4S, V11.4S, V3.4S
    CMGT  V9.4H, V16.4H, #0
    FCMGE  D17, D0, #0.0
    CMEQ  V28.4S, V22.4S, V24.4S
    FACGT  V2.2D, V5.2D, V23.2D
    CMHS  D5, D1, D30
    CMEQ  V1.4S, V2.4S, V2.4S
    FCMLT  S13, S18, #0.0
    FACGE  V9.2D, V13.2D, V21.2D
    FCMGE  D10, D27, D31
    FACGE  V0.4S, V8.4S, V21.4S
    FCMEQ  D30, D6, #0.0
    FCMGE  V29.2D, V20.2D, V26.2D
    CMLT  D6, D31, #0
    FCMEQ  V16.4S, V9.4S, #0.0
    CMGT  V18.4S, V21.4S, #0
    CMTST  V1.4H, V31.4H, V5.4H
    CMEQ  D3, D29, #0
    CMGT  D27, D11, #0
    CMEQ  V0.8H, V21.8H, #0
    FCMEQ  D30, D25, D10
    FCMGT  V18.4S, V13.4S, #0.0
    CMGT  D15, D15, #0
    CMHI  V16.16B, V20.16B, V17.16B
    FCMEQ  S20, S28, S27
    FCMLT  V14.2S, V30.2S, #0.0
    CMEQ  V22.2S, V25.2S, #0
    FCMEQ  V30.4S, V2.4S, V10.4S
    FCMLE  S28, S6, #0.0
    CMGE  V6.4H, V9.4H, #0
    CMEQ  V7.4S, V15.4S, #0
    CMEQ  D18, D8, #0
    FCMGE  S21, S23, S25
    CMHI  D15, D11, D9
    CMEQ  D27, D11, #0
    FCMGT  V31.2S, V9.2S, #0.0
    FCMGT  S1, S2, S23
    FCMGT  D17, D6, D10
    FCMLE  D7, D18, #0.0
    FCMGE  S1, S6, #0.0
    CMGT  D3, D13, D8
    CMGT  V21.4S, V6.4S, V22.4S
    FCMGT  S13, S20, #0.0
    SUBS  X20, X20, #0x1
    B.NE  TaishanSimdPermuteP01_label_651
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X16, X22, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X7, X10, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X20, X10, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X6, X14, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X7, X29, X10
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X5, X16, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X14, X20, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X13
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X12, X27, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X24, X2, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X23, X26, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X12, X3, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X25, X20, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X11, X14, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X22, X12, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D3
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D4
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X21, X16, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D5
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D6
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X25, X3, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D7
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D8
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X22, X2, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X21, X25, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D11
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X21, X25, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D12
    MOVZ  X28, #0x0, LSL #0
    SUB  X26, X28, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D14
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D16
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X11
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D18
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X27, X16, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D19
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X2, X25, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D23
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X17, X2, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D24
    MOVZ  X14, #0x0, LSL #0
    SUB  X27, X14, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D25
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X18, X24, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X28, X4, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D26
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X28, X4, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X3, X4, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D29
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xf90f, LSL #0
    MOVK  X2, #0x27, LSL #16
    MOVK  X2, #0xe2b7, LSL #32
    MOVK  X2, #0xcd4, LSL #48
    MOVZ  X3, #0xc07, LSL #0
    MOVK  X3, #0xa6cb, LSL #16
    MOVK  X3, #0xe5e8, LSL #32
    MOVK  X3, #0x493c, LSL #48
    MOVZ  X4, #0x2138, LSL #0
    MOVK  X4, #0x8dab, LSL #16
    MOVK  X4, #0x7609, LSL #32
    MOVK  X4, #0x2fb8, LSL #48
    MOVZ  X5, #0xe5cc, LSL #0
    MOVK  X5, #0xcbfa, LSL #16
    MOVK  X5, #0xd87d, LSL #32
    MOVK  X5, #0x7728, LSL #48
    MOVZ  X6, #0x35ee, LSL #0
    MOVK  X6, #0x7344, LSL #16
    MOVK  X6, #0x5389, LSL #32
    MOVK  X6, #0x830f, LSL #48
    MOVZ  X7, #0x499d, LSL #0
    MOVK  X7, #0x578e, LSL #16
    MOVK  X7, #0x36b8, LSL #32
    MOVK  X7, #0x4473, LSL #48
    MOVZ  X8, #0x3320, LSL #0
    MOVK  X8, #0x8ac, LSL #16
    MOVK  X8, #0x3e28, LSL #32
    MOVK  X8, #0x6381, LSL #48
    MOVZ  X9, #0x8ad8, LSL #0
    MOVK  X9, #0x685d, LSL #16
    MOVK  X9, #0x2657, LSL #32
    MOVK  X9, #0x9ac8, LSL #48
    MOVZ  X10, #0x1d95, LSL #0
    MOVK  X10, #0x5fbe, LSL #16
    MOVK  X10, #0x34c4, LSL #32
    MOVK  X10, #0x1a00, LSL #48
    MOVZ  X11, #0x5130, LSL #0
    MOVK  X11, #0xe38c, LSL #16
    MOVK  X11, #0xa5b9, LSL #32
    MOVK  X11, #0x9a25, LSL #48
    MOVZ  X12, #0x3ea5, LSL #0
    MOVK  X12, #0x4ef0, LSL #16
    MOVK  X12, #0x5efe, LSL #32
    MOVK  X12, #0x15a9, LSL #48
    MOVZ  X13, #0xd0f0, LSL #0
    MOVK  X13, #0xd326, LSL #16
    MOVK  X13, #0x8a9, LSL #32
    MOVK  X13, #0x229c, LSL #48
    MOVZ  X14, #0x2fc0, LSL #0
    MOVK  X14, #0x2843, LSL #16
    MOVK  X14, #0x1490, LSL #32
    MOVK  X14, #0xae0b, LSL #48
    MOVZ  X16, #0xe7a7, LSL #0
    MOVK  X16, #0x696, LSL #16
    MOVK  X16, #0xc85a, LSL #32
    MOVK  X16, #0x2661, LSL #48
    MOVZ  X17, #0x2054, LSL #0
    MOVK  X17, #0x7698, LSL #16
    MOVK  X17, #0x33b3, LSL #32
    MOVK  X17, #0x79fb, LSL #48
    MOVZ  X18, #0xb32d, LSL #0
    MOVK  X18, #0xc31c, LSL #16
    MOVK  X18, #0xbc48, LSL #32
    MOVK  X18, #0xb7e6, LSL #48
    MOVZ  X19, #0xce06, LSL #0
    MOVK  X19, #0xc25, LSL #16
    MOVK  X19, #0x627, LSL #32
    MOVK  X19, #0xe304, LSL #48
    MOVZ  X20, #0xfeec, LSL #0
    MOVK  X20, #0x5650, LSL #16
    MOVK  X20, #0x1260, LSL #32
    MOVK  X20, #0x7959, LSL #48
    MOVZ  X21, #0xfcbd, LSL #0
    MOVK  X21, #0x8275, LSL #16
    MOVK  X21, #0x295f, LSL #32
    MOVK  X21, #0x21ac, LSL #48
    MOVZ  X22, #0x90b8, LSL #0
    MOVK  X22, #0xf219, LSL #16
    MOVK  X22, #0xa1c0, LSL #32
    MOVK  X22, #0xdaf6, LSL #48
    MOVZ  X23, #0x8574, LSL #0
    MOVK  X23, #0x5b16, LSL #16
    MOVK  X23, #0x6622, LSL #32
    MOVK  X23, #0x35af, LSL #48
    MOVZ  X24, #0x7103, LSL #0
    MOVK  X24, #0x8f75, LSL #16
    MOVK  X24, #0x99ae, LSL #32
    MOVK  X24, #0x3a41, LSL #48
    MOVZ  X25, #0x2fd4, LSL #0
    MOVK  X25, #0x7c5b, LSL #16
    MOVK  X25, #0xece6, LSL #32
    MOVK  X25, #0x63fc, LSL #48
    MOVZ  X26, #0x7029, LSL #0
    MOVK  X26, #0xd4d2, LSL #16
    MOVK  X26, #0x78be, LSL #32
    MOVK  X26, #0x9b53, LSL #48
    MOVZ  X27, #0x14eb, LSL #0
    MOVK  X27, #0x988, LSL #16
    MOVK  X27, #0x1828, LSL #32
    MOVK  X27, #0xf72b, LSL #48
    MOVZ  X28, #0x78fe, LSL #0
    MOVK  X28, #0x825c, LSL #16
    MOVK  X28, #0xe72f, LSL #32
    MOVK  X28, #0x445c, LSL #48
    MOVZ  X29, #0x78ac, LSL #0
    MOVK  X29, #0xb381, LSL #16
    MOVK  X29, #0x9459, LSL #32
    MOVK  X29, #0x3e8f, LSL #48
    FMOV  D0, X16
    FMOV  V0.D[1], X18
    FMOV  D1, X4
    FMOV  V1.D[1], X21
    FMOV  D2, X27
    FMOV  V2.D[1], X7
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X19
    FMOV  V4.D[1], X6
    FMOV  D5, X29
    FMOV  V5.D[1], X7
    FMOV  D6, X28
    FMOV  V6.D[1], X24
    FMOV  D7, X9
    FMOV  V7.D[1], X9
    FMOV  D8, X29
    FMOV  V8.D[1], X28
    FMOV  D9, X18
    FMOV  V9.D[1], X20
    FMOV  D10, X27
    FMOV  V10.D[1], X13
    FMOV  D11, X8
    FMOV  V11.D[1], X24
    FMOV  D12, X16
    FMOV  V12.D[1], X5
    FMOV  D13, X9
    FMOV  V13.D[1], X8
    FMOV  D14, X13
    FMOV  V14.D[1], X21
    FMOV  D15, X25
    FMOV  V15.D[1], X22
    FMOV  D16, X18
    FMOV  V16.D[1], X10
    FMOV  D17, X20
    FMOV  V17.D[1], X3
    FMOV  D18, X25
    FMOV  V18.D[1], X25
    FMOV  D19, X24
    FMOV  V19.D[1], X13
    FMOV  D20, X10
    FMOV  V20.D[1], X20
    FMOV  D21, X29
    FMOV  V21.D[1], X4
    FMOV  D22, X5
    FMOV  V22.D[1], X11
    FMOV  D23, X16
    FMOV  V23.D[1], X16
    FMOV  D24, X5
    FMOV  V24.D[1], X19
    FMOV  D25, X14
    FMOV  V25.D[1], X17
    FMOV  D26, X26
    FMOV  V26.D[1], X23
    FMOV  D27, X12
    FMOV  V27.D[1], X6
    FMOV  D28, X28
    FMOV  V28.D[1], X7
    FMOV  D29, X16
    FMOV  V29.D[1], X7
    FMOV  D30, X26
    FMOV  V30.D[1], X6
    FMOV  D31, X9
    FMOV  V31.D[1], X23
    MOVZ  X8, #0xa, LSL #0
TaishanSimdPermuteP01_label_729:
    CMEQ  D23, D22, #0
    CMTST  V23.8B, V29.8B, V19.8B
    CMHI  D0, D10, D23
    CMGE  D2, D28, D29
    FCMGE  D14, D14, #0.0
    CMLT  V23.16B, V31.16B, #0
    FCMGE  S11, S1, S12
    FCMGE  V3.2D, V17.2D, #0.0
    CMGT  V23.16B, V2.16B, V5.16B
    FACGE  S23, S15, S15
    FACGE  D2, D3, D30
    FCMEQ  D23, D8, D3
    FCMLT  D2, D6, #0.0
    FCMGE  D25, D8, #0.0
    FCMLT  D24, D25, #0.0
    FCMGT  V25.2D, V22.2D, V22.2D
    FCMEQ  S6, S14, S2
    FCMEQ  V19.2D, V15.2D, V4.2D
    FCMGE  D9, D1, D30
    FCMGT  S25, S30, #0.0
    FCMEQ  S4, S29, S19
    FCMGT  D20, D22, D17
    FCMEQ  V0.2D, V11.2D, #0.0
    CMGE  V27.8H, V31.8H, #0
    FACGE  S2, S31, S31
    CMGE  D31, D15, #0
    FCMGE  D30, D12, D7
    FCMLT  S14, S20, #0.0
    CMEQ  V24.4H, V1.4H, #0
    CMHI  V22.8B, V2.8B, V30.8B
    CMTST  D29, D1, D30
    CMGT  V8.16B, V0.16B, V23.16B
    FCMGE  V24.2S, V22.2S, #0.0
    FCMGE  S4, S25, #0.0
    FCMGE  V27.2S, V25.2S, #0.0
    FACGE  V2.4S, V8.4S, V24.4S
    FCMGE  S6, S23, S20
    CMHI  V10.8H, V16.8H, V2.8H
    FCMGE  S1, S14, #0.0
    CMHS  D27, D7, D25
    CMGE  V8.16B, V22.16B, V30.16B
    FCMEQ  D22, D27, D19
    CMTST  V25.4S, V5.4S, V21.4S
    CMGE  V30.4S, V6.4S, #0
    CMGT  V17.4H, V14.4H, #0
    FCMEQ  D18, D30, D25
    CMTST  V29.4H, V30.4H, V3.4H
    FCMGE  D21, D9, D12
    CMGT  D5, D17, #0
    FCMLE  S17, S3, #0.0
    FACGE  S31, S8, S15
    CMGT  D16, D23, #0
    FCMGE  V31.2D, V23.2D, #0.0
    FACGT  D0, D0, D27
    FCMEQ  V8.2D, V4.2D, #0.0
    FCMLT  S8, S17, #0.0
    CMLE  V4.4H, V3.4H, #0
    FACGE  V26.4S, V25.4S, V25.4S
    FCMGE  D29, D2, D2
    FACGT  V12.2D, V9.2D, V27.2D
    CMGE  D10, D18, #0
    FCMGT  S0, S29, S31
    CMGT  D0, D26, #0
    CMLT  D21, D26, #0
    FCMLE  D8, D12, #0.0
    CMGT  V0.16B, V14.16B, V17.16B
    CMLE  D12, D27, #0
    FCMGT  V2.2S, V20.2S, #0.0
    FCMGE  D9, D17, #0.0
    FCMLE  V16.2D, V21.2D, #0.0
    CMEQ  V23.8H, V10.8H, #0
    FCMGE  S18, S27, #0.0
    FCMLT  V16.4S, V30.4S, #0.0
    CMTST  D17, D31, D3
    FCMGE  D28, D9, D27
    CMHS  V20.8B, V10.8B, V26.8B
    CMEQ  D10, D16, D17
    FCMEQ  D18, D30, #0.0
    FCMGT  D28, D5, D11
    FCMEQ  V4.4S, V28.4S, #0.0
    FACGE  S24, S8, S22
    FCMGE  S7, S9, #0.0
    CMGE  V14.2D, V24.2D, #0
    FCMGE  D19, D28, D2
    FCMEQ  S1, S13, S23
    FCMLT  S16, S17, #0.0
    FCMLT  S2, S4, #0.0
    FACGE  V27.2D, V23.2D, V12.2D
    FCMEQ  D5, D0, #0.0
    FCMGT  D2, D9, #0.0
    CMHI  V12.16B, V28.16B, V25.16B
    FCMLT  S31, S11, #0.0
    FACGE  S2, S1, S24
    FCMGE  D6, D25, D18
    FCMGT  V30.4S, V8.4S, V28.4S
    CMEQ  V9.2S, V10.2S, V28.2S
    FCMLT  S27, S4, #0.0
    FCMGE  S20, S28, S12
    CMEQ  D16, D6, #0
    FACGT  S6, S10, S11
    CMHI  D28, D24, D13
    FCMGT  V12.2D, V14.2D, V8.2D
    FCMEQ  S4, S9, S2
    CMTST  D11, D26, D18
    FCMGT  V29.4S, V22.4S, V13.4S
    FCMLT  V17.2D, V8.2D, #0.0
    FCMLT  D10, D8, #0.0
    CMLE  D5, D13, #0
    FCMEQ  S4, S14, #0.0
    CMHS  V5.8H, V30.8H, V3.8H
    FCMGT  V27.4S, V30.4S, #0.0
    FCMGE  D20, D15, D13
    FCMGE  D12, D23, #0.0
    CMHS  V30.8B, V19.8B, V12.8B
    CMGT  V12.16B, V27.16B, #0
    FCMGE  V8.2S, V5.2S, V2.2S
    FCMGE  D0, D28, #0.0
    FACGE  S2, S0, S17
    FCMEQ  D8, D6, #0.0
    CMHI  D12, D5, D8
    CMLT  V21.2D, V19.2D, #0
    CMLE  V26.4S, V17.4S, #0
    CMTST  V29.4H, V25.4H, V23.4H
    CMLE  D27, D8, #0
    FACGT  D24, D30, D13
    FCMGE  V4.2D, V16.2D, #0.0
    CMGE  V28.4S, V27.4S, #0
    CMEQ  D12, D29, D9
    FCMEQ  S8, S25, #0.0
    CMLT  D31, D13, #0
    FACGE  D31, D20, D25
    FCMLE  D26, D5, #0.0
    CMGT  V29.8B, V8.8B, V30.8B
    CMHS  D1, D6, D1
    FCMEQ  V16.4S, V9.4S, V13.4S
    FACGE  S10, S1, S17
    FCMGT  D21, D21, D27
    CMGT  V18.2D, V2.2D, #0
    CMLE  D17, D4, #0
    FCMGT  V10.2D, V20.2D, #0.0
    CMLE  D17, D6, #0
    CMGE  V5.16B, V27.16B, V25.16B
    FCMLE  V8.2D, V4.2D, #0.0
    FACGE  V19.4S, V30.4S, V27.4S
    FCMGE  V9.4S, V19.4S, V3.4S
    CMTST  V9.2S, V18.2S, V28.2S
    CMLT  V12.4S, V10.4S, #0
    FCMGE  S12, S7, S1
    CMGT  D30, D6, #0
    CMGT  V17.8H, V15.8H, V29.8H
    FCMGT  S27, S31, #0.0
    FACGT  V12.2S, V0.2S, V27.2S
    FCMGT  D17, D31, #0.0
    FCMLT  D13, D7, #0.0
    CMTST  D27, D4, D8
    FCMEQ  V22.2D, V25.2D, V0.2D
    FCMEQ  D14, D25, D17
    CMGT  D13, D13, D8
    FCMEQ  V5.2S, V8.2S, #0.0
    FCMGE  V13.4S, V27.4S, V22.4S
    CMHI  D14, D17, D14
    FCMGE  V29.4S, V27.4S, V15.4S
    FCMGE  S7, S7, S5
    FCMEQ  V13.2D, V12.2D, #0.0
    FCMGE  D3, D29, D7
    CMGE  D20, D6, D14
    CMGT  D1, D21, D15
    CMHS  V3.16B, V14.16B, V10.16B
    CMGT  V18.8B, V0.8B, V30.8B
    FCMLT  V24.4S, V18.4S, #0.0
    CMTST  V7.16B, V1.16B, V20.16B
    CMGE  D24, D4, #0
    FACGT  V6.2D, V24.2D, V25.2D
    FCMLT  V27.2S, V11.2S, #0.0
    FCMGT  S28, S22, S15
    CMLE  V27.8B, V10.8B, #0
    FCMLE  V24.2S, V28.2S, #0.0
    CMLT  D5, D17, #0
    CMLE  V3.8B, V19.8B, #0
    CMGE  D17, D6, #0
    FCMLT  V27.4S, V25.4S, #0.0
    FCMLT  V0.2D, V16.2D, #0.0
    CMHS  D0, D16, D19
    FCMGE  S12, S24, #0.0
    FCMLE  V8.2S, V3.2S, #0.0
    FCMGE  S3, S1, #0.0
    FCMLE  D22, D9, #0.0
    FCMLT  D29, D28, #0.0
    FCMLT  D25, D5, #0.0
    CMTST  D12, D11, D24
    CMTST  V15.2S, V28.2S, V29.2S
    FACGE  D11, D15, D27
    CMHS  V1.16B, V3.16B, V16.16B
    CMHS  D10, D14, D10
    FCMGT  D27, D20, D5
    FACGT  V3.2S, V13.2S, V28.2S
    FCMEQ  V5.2D, V12.2D, V16.2D
    CMGT  D23, D3, #0
    FACGE  D12, D28, D27
    FCMLT  D17, D6, #0.0
    SUBS  X8, X8, #0x1
    B.NE  TaishanSimdPermuteP01_label_729
    MOVZ  X17, #0xf90f, LSL #0
    MOVK  X17, #0x27, LSL #16
    MOVK  X17, #0xe2b7, LSL #32
    MOVK  X17, #0xcd4, LSL #48
    SUB  X7, X17, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0xc07, LSL #0
    MOVK  X27, #0xa6cb, LSL #16
    MOVK  X27, #0xe5e8, LSL #32
    MOVK  X27, #0x493c, LSL #48
    SUB  X25, X27, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0x2138, LSL #0
    MOVK  X5, #0x8dab, LSL #16
    MOVK  X5, #0x7609, LSL #32
    MOVK  X5, #0x2fb8, LSL #48
    SUB  X18, X5, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x2138, LSL #0
    MOVK  X7, #0x8dab, LSL #16
    MOVK  X7, #0x7609, LSL #32
    MOVK  X7, #0x2fb8, LSL #48
    SUB  X27, X7, X5
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x35ee, LSL #0
    MOVK  X28, #0x7344, LSL #16
    MOVK  X28, #0x5389, LSL #32
    MOVK  X28, #0x830f, LSL #48
    SUB  X19, X28, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0x2138, LSL #0
    MOVK  X23, #0x8dab, LSL #16
    MOVK  X23, #0x7609, LSL #32
    MOVK  X23, #0x2fb8, LSL #48
    SUB  X29, X23, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X8
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x1d95, LSL #0
    MOVK  X14, #0x5fbe, LSL #16
    MOVK  X14, #0x34c4, LSL #32
    MOVK  X14, #0x1a00, LSL #48
    SUB  X22, X14, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x5130, LSL #0
    MOVK  X8, #0xe38c, LSL #16
    MOVK  X8, #0xa5b9, LSL #32
    MOVK  X8, #0x9a25, LSL #48
    SUB  X28, X8, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xd0f0, LSL #0
    MOVK  X2, #0xd326, LSL #16
    MOVK  X2, #0x8a9, LSL #32
    MOVK  X2, #0x229c, LSL #48
    SUB  X5, X2, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x1d95, LSL #0
    MOVK  X25, #0x5fbe, LSL #16
    MOVK  X25, #0x34c4, LSL #32
    MOVK  X25, #0x1a00, LSL #48
    SUB  X11, X25, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0xe7a7, LSL #0
    MOVK  X28, #0x696, LSL #16
    MOVK  X28, #0xc85a, LSL #32
    MOVK  X28, #0x2661, LSL #48
    SUB  X29, X28, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X6, X22, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0xfcbd, LSL #0
    MOVK  X23, #0x8275, LSL #16
    MOVK  X23, #0x295f, LSL #32
    MOVK  X23, #0x21ac, LSL #48
    SUB  X5, X23, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0xfcbd, LSL #0
    MOVK  X28, #0x8275, LSL #16
    MOVK  X28, #0x295f, LSL #32
    MOVK  X28, #0x21ac, LSL #48
    SUB  X4, X28, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x7103, LSL #0
    MOVK  X22, #0x8f75, LSL #16
    MOVK  X22, #0x99ae, LSL #32
    MOVK  X22, #0x3a41, LSL #48
    SUB  X28, X22, X24
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x1d95, LSL #0
    MOVK  X17, #0x5fbe, LSL #16
    MOVK  X17, #0x34c4, LSL #32
    MOVK  X17, #0x1a00, LSL #48
    SUB  X4, X17, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D3
    MOVZ  X24, #0x0, LSL #0
    SUB  X17, X24, X21
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X18, X6, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D4
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X18, X6, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D5
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X29, X20, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D7
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D10
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D11
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X19, X8, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X24, X26, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D12
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X24, X26, X20
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X10, X21, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D13
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X10, X21, X29
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D16
    MOVZ  X7, #0x0, LSL #0
    SUB  X12, X7, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D18
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X3, X9, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D20
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X19, X23, X24
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D22
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X3, X2, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D24
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D25
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D26
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X4, X13, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D27
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D28
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X25, X24, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X8
    FMOV  D1, X20
    FMOV  V1.D[1], X12
    FMOV  D2, X22
    FMOV  V2.D[1], X10
    FMOV  D3, X16
    FMOV  V3.D[1], X11
    FMOV  D4, X29
    FMOV  V4.D[1], X11
    FMOV  D5, X14
    FMOV  V5.D[1], X18
    FMOV  D6, X5
    FMOV  V6.D[1], X4
    FMOV  D7, X27
    FMOV  V7.D[1], X22
    FMOV  D8, X7
    FMOV  V8.D[1], X28
    FMOV  D9, X12
    FMOV  V9.D[1], X25
    FMOV  D10, X29
    FMOV  V10.D[1], X24
    FMOV  D11, X4
    FMOV  V11.D[1], X14
    FMOV  D12, X28
    FMOV  V12.D[1], X12
    FMOV  D13, X27
    FMOV  V13.D[1], X22
    FMOV  D14, X14
    FMOV  V14.D[1], X29
    FMOV  D15, X23
    FMOV  V15.D[1], X29
    FMOV  D16, X3
    FMOV  V16.D[1], X5
    FMOV  D17, X19
    FMOV  V17.D[1], X2
    FMOV  D18, X16
    FMOV  V18.D[1], X16
    FMOV  D19, X16
    FMOV  V19.D[1], X12
    FMOV  D20, X17
    FMOV  V20.D[1], X23
    FMOV  D21, X29
    FMOV  V21.D[1], X29
    FMOV  D22, X13
    FMOV  V22.D[1], X16
    FMOV  D23, X9
    FMOV  V23.D[1], X26
    FMOV  D24, X5
    FMOV  V24.D[1], X17
    FMOV  D25, X10
    FMOV  V25.D[1], X17
    FMOV  D26, X24
    FMOV  V26.D[1], X14
    FMOV  D27, X2
    FMOV  V27.D[1], X21
    FMOV  D28, X23
    FMOV  V28.D[1], X29
    FMOV  D29, X4
    FMOV  V29.D[1], X29
    FMOV  D30, X24
    FMOV  V30.D[1], X4
    FMOV  D31, X22
    FMOV  V31.D[1], X12
    MOVZ  X25, #0xa, LSL #0
TaishanSimdPermuteP01_label_806:
    CMGE  V5.8H, V19.8H, V22.8H
    FCMGE  V0.2S, V0.2S, V14.2S
    CMEQ  D3, D8, #0
    FCMGT  D14, D1, #0.0
    FCMLT  S31, S5, #0.0
    FCMGT  S0, S24, #0.0
    CMGT  V22.4H, V19.4H, #0
    CMGT  V19.16B, V23.16B, V13.16B
    FCMGT  S7, S28, #0.0
    FCMEQ  V12.2D, V21.2D, #0.0
    FCMGE  S25, S10, S1
    CMLE  D25, D6, #0
    FACGE  S16, S7, S3
    FCMEQ  S12, S30, S11
    CMLT  V14.8H, V9.8H, #0
    CMGT  V13.2D, V19.2D, V5.2D
    FCMEQ  S31, S5, S5
    FCMEQ  S9, S12, #0.0
    CMGE  V23.8B, V21.8B, V16.8B
    FACGT  D25, D24, D17
    FCMLT  S13, S13, #0.0
    FCMLT  V7.4S, V28.4S, #0.0
    CMEQ  V19.4H, V24.4H, V16.4H
    FCMEQ  D8, D21, #0.0
    FCMEQ  D25, D3, D17
    CMGT  V17.16B, V18.16B, V5.16B
    FCMEQ  V14.2D, V18.2D, V12.2D
    FCMLT  S23, S19, #0.0
    FCMGE  S13, S21, #0.0
    FCMLT  V25.2D, V28.2D, #0.0
    FCMGE  D11, D0, #0.0
    FACGT  V11.2D, V31.2D, V26.2D
    CMLT  V10.4S, V13.4S, #0
    CMLT  D3, D5, #0
    CMHS  V9.2D, V31.2D, V17.2D
    CMGE  V16.8B, V7.8B, V16.8B
    CMLE  V21.4S, V18.4S, #0
    FCMLT  D31, D5, #0.0
    CMGE  D30, D14, D8
    CMEQ  D21, D8, D20
    CMHI  V24.4H, V17.4H, V29.4H
    CMGT  D3, D0, #0
    FCMGE  D24, D25, D0
    FCMEQ  V23.2D, V21.2D, V24.2D
    FACGE  D27, D20, D22
    CMHI  D2, D11, D6
    CMGE  V19.8B, V29.8B, #0
    FCMEQ  D4, D28, #0.0
    FCMLT  D23, D20, #0.0
    FACGT  S30, S27, S3
    FCMEQ  S21, S29, #0.0
    FCMGE  V21.4S, V3.4S, #0.0
    FACGT  S20, S12, S24
    CMGT  V11.4S, V26.4S, #0
    FCMGE  V1.4S, V7.4S, #0.0
    CMEQ  V18.4S, V31.4S, #0
    FCMEQ  V6.2D, V7.2D, #0.0
    CMGE  D17, D26, #0
    FCMLT  D25, D18, #0.0
    FCMGT  S18, S2, S13
    FCMLT  S27, S16, #0.0
    FCMGT  S11, S21, #0.0
    CMLT  D6, D14, #0
    FCMGE  S3, S24, S16
    CMGE  D9, D28, D28
    CMHS  D28, D3, D30
    CMHS  V7.8B, V5.8B, V27.8B
    FCMLT  V21.2D, V1.2D, #0.0
    FCMGE  S27, S14, #0.0
    FCMGE  D7, D19, D2
    FCMLE  D18, D7, #0.0
    CMLE  D12, D17, #0
    CMEQ  D30, D18, #0
    CMEQ  D18, D2, #0
    FACGT  S3, S7, S20
    CMHI  V22.16B, V8.16B, V14.16B
    FCMLE  D14, D4, #0.0
    CMEQ  V24.2D, V13.2D, #0
    FCMGT  S12, S17, #0.0
    FACGE  S16, S6, S20
    FCMGT  D17, D7, #0.0
    CMEQ  D13, D4, D1
    FCMLT  V5.2D, V6.2D, #0.0
    FCMEQ  S2, S19, S7
    CMLE  V8.4S, V27.4S, #0
    CMLE  V1.2D, V8.2D, #0
    CMHI  V6.2D, V20.2D, V18.2D
    FACGT  S17, S14, S16
    FCMLE  S5, S4, #0.0
    CMGT  D29, D22, #0
    CMGE  D10, D19, D6
    FCMLT  D28, D27, #0.0
    FCMGE  S1, S1, #0.0
    FCMGT  D28, D29, D1
    FCMGT  V28.2S, V9.2S, #0.0
    CMGT  D31, D26, #0
    CMGT  D26, D15, D30
    CMGE  D15, D6, #0
    FCMEQ  S16, S9, S30
    CMEQ  V15.4H, V24.4H, V7.4H
    FACGE  S16, S7, S2
    CMHI  V4.2S, V8.2S, V9.2S
    CMEQ  V10.4S, V26.4S, V5.4S
    FCMGT  S8, S1, S6
TaishanSimdPermuteP01_label_297:
    CMEQ  V8.16B, V26.16B, #0
    FCMLT  D15, D17, #0.0
    FCMGE  V20.2S, V17.2S, #0.0
    FCMLE  D7, D8, #0.0
    CMEQ  V7.8H, V31.8H, V30.8H
    FCMGE  V18.4S, V12.4S, V29.4S
    CMHS  D5, D1, D30
    CMHS  V16.8B, V24.8B, V17.8B
    FCMEQ  S16, S5, S20
    FACGE  S8, S15, S27
    CMLT  V21.2D, V22.2D, #0
    CMLT  V1.4S, V20.4S, #0
    CMLE  D21, D7, #0
    CMGE  V10.16B, V26.16B, V21.16B
    CMEQ  D27, D2, #0
    FCMEQ  S18, S26, #0.0
    FCMEQ  S26, S27, S16
    FCMLE  S13, S2, #0.0
    CMLT  D24, D3, #0
    FCMGE  S25, S26, #0.0
    FCMEQ  D21, D8, #0.0
    FACGT  D27, D10, D21
    CMGT  D27, D0, #0
    CMTST  D10, D27, D4
    FCMGT  D20, D0, #0.0
    CMHI  D9, D24, D17
    FCMGT  D1, D17, D4
    FCMGE  D18, D16, D31
    CMGE  V18.8H, V2.8H, #0
    FCMGE  D27, D27, D27
    FCMLT  D25, D20, #0.0
    CMGE  V25.2D, V29.2D, V7.2D
    CMEQ  D13, D29, D31
    CMEQ  V11.2S, V24.2S, #0
    FCMGT  S15, S30, #0.0
    FCMGE  V13.2S, V12.2S, #0.0
    FCMGT  V14.2D, V10.2D, #0.0
    FACGE  S9, S26, S4
    CMGT  D24, D13, D16
    CMGE  D31, D1, #0
    FCMEQ  V29.2D, V30.2D, V9.2D
    FCMGT  V31.2D, V24.2D, V20.2D
    CMGT  D24, D16, #0
    CMEQ  V24.16B, V21.16B, V21.16B
    CMGE  V14.2S, V31.2S, V21.2S
    CMLE  V17.8B, V28.8B, #0
    FACGE  D15, D3, D17
    FCMLE  S11, S20, #0.0
    CMGE  V19.8H, V27.8H, V20.8H
    FCMGE  V26.2D, V13.2D, V1.2D
    FCMLT  S13, S7, #0.0
    CMGE  V2.2S, V14.2S, V8.2S
    CMGT  D16, D19, #0
    FCMLT  V14.2D, V17.2D, #0.0
    CMGE  V8.8H, V24.8H, V29.8H
    CMTST  V2.8H, V2.8H, V13.8H
    FCMEQ  D30, D31, #0.0
    FCMLE  D20, D30, #0.0
    FCMGE  S19, S29, S26
    FCMEQ  D22, D16, D20
    FCMGT  D5, D11, #0.0
    FCMGT  S29, S16, S15
    CMTST  D24, D14, D4
    CMGE  D8, D15, D14
    FCMLT  V10.2D, V25.2D, #0.0
    CMHI  V31.4S, V6.4S, V7.4S
    CMHI  V29.4H, V6.4H, V26.4H
    CMGE  D26, D1, D14
    FCMGE  D2, D10, #0.0
    CMGE  V3.16B, V1.16B, V6.16B
    FCMGT  V13.2D, V1.2D, V30.2D
    FACGE  V1.2D, V4.2D, V6.2D
    CMLE  V22.8H, V13.8H, #0
    FCMEQ  S5, S0, #0.0
    FACGT  V29.2D, V11.2D, V12.2D
    FCMGE  S13, S3, #0.0
    FCMGT  V13.2D, V31.2D, V14.2D
    FACGE  D19, D26, D10
    CMGE  V19.4S, V0.4S, #0
    FCMLE  D24, D22, #0.0
    CMGT  D26, D17, D30
    CMLT  V22.4S, V13.4S, #0
    FCMEQ  D3, D11, #0.0
    CMHI  D1, D16, D17
    CMHI  V29.16B, V14.16B, V3.16B
    CMGT  D30, D29, #0
    CMHI  V5.2D, V2.2D, V19.2D
    FCMLT  V5.4S, V8.4S, #0.0
    FCMGT  V8.4S, V25.4S, V7.4S
    CMLT  V8.2D, V31.2D, #0
    FCMGT  D26, D16, #0.0
    CMHS  V13.16B, V6.16B, V13.16B
    FCMGE  S26, S29, S2
    FCMGE  D1, D4, #0.0
    FACGT  V24.2D, V19.2D, V29.2D
    CMHI  D26, D17, D8
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdPermuteP01_label_806
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X20, X21, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X25, X11, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X13, X8, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X18, X10, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X16, X10, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D2
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X27, X18, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D3
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X9, X8, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D5
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D7
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X13, X19, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D8
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D9
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    SUB  X18, X2, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D10
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D11
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    SUB  X12, X4, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X2, X10, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D13
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X2, X10, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D14
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D17
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X2, X14, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X13, X20, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D18
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X13, X20, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X17, X3, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D19
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X17, X3, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X2, X14, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D21
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X2, X14, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D23
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X23, X13, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D25
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X23, X13, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D26
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X21, X29, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D27
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X4, X25, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
TaishanSimdPermuteP01_label_812:
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
    FMOV  V0.D[1], X10
    FMOV  D1, X8
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X19
    FMOV  D3, X7
    FMOV  V3.D[1], X28
    FMOV  D4, X17
    FMOV  V4.D[1], X21
    FMOV  D5, X18
    FMOV  V5.D[1], X27
    FMOV  D6, X17
    FMOV  V6.D[1], X23
    FMOV  D7, X28
    FMOV  V7.D[1], X9
    FMOV  D8, X4
    FMOV  V8.D[1], X11
    FMOV  D9, X7
    FMOV  V9.D[1], X8
    FMOV  D10, X6
    FMOV  V10.D[1], X20
    FMOV  D11, X7
    FMOV  V11.D[1], X22
    FMOV  D12, X8
    FMOV  V12.D[1], X18
    FMOV  D13, X21
    FMOV  V13.D[1], X23
    FMOV  D14, X8
    FMOV  V14.D[1], X6
    FMOV  D15, X11
    FMOV  V15.D[1], X7
    FMOV  D16, X6
    FMOV  V16.D[1], X21
    FMOV  D17, X11
    FMOV  V17.D[1], X5
    FMOV  D18, X7
    FMOV  V18.D[1], X14
    FMOV  D19, X18
    FMOV  V19.D[1], X2
    FMOV  D20, X26
    FMOV  V20.D[1], X8
    FMOV  D21, X6
    FMOV  V21.D[1], X8
    FMOV  D22, X18
    FMOV  V22.D[1], X6
    FMOV  D23, X14
    FMOV  V23.D[1], X2
    FMOV  D24, X5
    FMOV  V24.D[1], X21
    FMOV  D25, X16
    FMOV  V25.D[1], X19
    FMOV  D26, X18
    FMOV  V26.D[1], X27
    FMOV  D27, X14
    FMOV  V27.D[1], X10
    FMOV  D28, X6
    FMOV  V28.D[1], X16
    FMOV  D29, X6
    FMOV  V29.D[1], X14
    FMOV  D30, X23
    FMOV  V30.D[1], X19
    FMOV  D31, X27
    FMOV  V31.D[1], X12
    MOVZ  X18, #0xf, LSL #0
TaishanSimdPermuteP01_label_884:
    CMGE  D24, D28, #0
    FCMLT  V30.2S, V22.2S, #0.0
    CMHS  D1, D10, D23
    FACGT  S23, S9, S8
    FCMEQ  V11.2D, V25.2D, V4.2D
    FCMEQ  S0, S5, S20
    FCMEQ  D21, D23, D26
    FACGE  S31, S8, S24
    CMGE  V18.2D, V12.2D, #0
    FCMGT  V7.2S, V18.2S, V12.2S
    FCMGT  V16.2D, V11.2D, #0.0
    FCMGE  V10.2D, V7.2D, #0.0
    FCMGT  D4, D0, D24
    FACGE  S21, S7, S22
    CMEQ  D1, D4, #0
    CMGE  V24.2D, V16.2D, V26.2D
    FACGE  V14.2D, V31.2D, V14.2D
    FCMLT  V30.4S, V24.4S, #0.0
    FCMGE  D30, D24, D4
    FCMGE  D17, D11, D1
    FACGT  S9, S1, S14
    CMLE  V29.4H, V2.4H, #0
    FCMEQ  V24.2D, V4.2D, #0.0
    CMGE  V10.8B, V0.8B, V31.8B
    FACGE  D28, D19, D1
    FCMEQ  S19, S26, S6
    FCMLT  S6, S13, #0.0
    CMGE  D14, D23, #0
    CMGT  D31, D2, #0
    CMGT  V24.8B, V29.8B, #0
    CMHI  V9.8H, V27.8H, V0.8H
    FACGT  V11.2S, V11.2S, V10.2S
    FACGT  D25, D30, D1
    FCMGT  S20, S5, S0
    FCMEQ  D16, D16, D2
    FACGE  V12.2D, V7.2D, V13.2D
    FCMLE  D14, D14, #0.0
    FCMGT  V27.2D, V23.2D, V24.2D
    FACGT  V10.2D, V14.2D, V25.2D
    FCMLE  D29, D6, #0.0
    FCMLT  V31.4S, V0.4S, #0.0
    CMEQ  V26.16B, V20.16B, V27.16B
    FACGE  V22.2D, V11.2D, V18.2D
    FCMEQ  V19.2S, V31.2S, #0.0
    FCMLT  D16, D14, #0.0
    FCMEQ  V13.4S, V12.4S, V30.4S
    CMHS  D10, D26, D7
    CMEQ  V29.8H, V22.8H, V3.8H
    FCMEQ  V19.2S, V19.2S, V14.2S
    FCMEQ  V1.2S, V9.2S, V11.2S
    CMGE  D6, D19, D0
    CMTST  V1.8B, V24.8B, V25.8B
    FCMGT  V13.2D, V16.2D, #0.0
    CMTST  D7, D12, D3
    FCMEQ  S22, S25, #0.0
    CMGE  V13.2D, V6.2D, V2.2D
    CMGT  V29.4H, V0.4H, #0
    FCMEQ  D13, D23, D23
    FCMLE  S14, S17, #0.0
    FCMGT  V20.4S, V19.4S, #0.0
    FCMLE  V23.2S, V27.2S, #0.0
    FCMGE  S11, S4, S22
    FCMGT  V15.4S, V14.4S, #0.0
    CMHS  V15.2S, V24.2S, V26.2S
    CMGE  D1, D7, D13
    FCMGE  D14, D21, #0.0
    FCMLT  S9, S30, #0.0
    CMLE  D4, D4, #0
    FCMEQ  V20.2S, V10.2S, V22.2S
    CMHS  D9, D28, D29
    CMLT  V6.2S, V20.2S, #0
    CMHS  D11, D0, D15
    CMGT  V28.8B, V17.8B, #0
    FCMGE  S21, S21, #0.0
    FCMGT  V15.2D, V2.2D, V29.2D
    FCMGT  S11, S28, S4
    FCMEQ  S3, S1, S19
    FCMEQ  V22.4S, V14.4S, #0.0
    FCMGE  S22, S27, #0.0
    FCMLT  S29, S15, #0.0
    FCMEQ  D2, D7, #0.0
    CMTST  V4.4H, V15.4H, V23.4H
    FCMLT  S3, S8, #0.0
    FCMLT  D7, D25, #0.0
    FCMGE  S22, S22, #0.0
    FACGT  V11.2D, V9.2D, V20.2D
    CMLE  V11.2D, V17.2D, #0
    CMGE  D8, D23, D13
    FACGT  D11, D21, D9
    FCMEQ  S10, S24, S0
    FCMLE  S20, S29, #0.0
    FCMGT  V6.4S, V13.4S, V30.4S
    CMLT  V19.2D, V15.2D, #0
    FCMGE  S29, S13, #0.0
    FCMEQ  V2.2S, V16.2S, #0.0
    CMGE  V14.16B, V30.16B, #0
    FCMEQ  V6.4S, V20.4S, V8.4S
    CMTST  D16, D1, D21
    FCMGE  D28, D17, #0.0
    FCMLE  S2, S5, #0.0
    FCMGT  D1, D26, D31
    FCMGE  V10.4S, V26.4S, V4.4S
    CMLT  V8.2S, V12.2S, #0
    FACGE  D15, D9, D1
    CMHS  V27.2D, V29.2D, V12.2D
    FCMEQ  V28.4S, V16.4S, V12.4S
    FCMGT  S3, S17, S14
    FACGT  D0, D2, D26
    FCMEQ  D25, D28, #0.0
    FCMGT  V12.4S, V29.4S, #0.0
    FCMGT  S30, S1, #0.0
    CMEQ  D4, D8, #0
    FACGE  D24, D10, D6
    FCMGT  V25.2D, V27.2D, #0.0
    FCMLT  D26, D12, #0.0
    FCMGE  D15, D0, #0.0
    CMLT  V4.2D, V0.2D, #0
    CMHS  D29, D9, D18
    CMHI  D28, D27, D0
    FCMEQ  V3.2D, V28.2D, #0.0
    CMGE  D31, D15, D26
    CMGE  V25.4H, V15.4H, V10.4H
    CMGT  V5.16B, V21.16B, #0
    FCMEQ  S12, S17, S8
    FCMEQ  V23.2D, V5.2D, V15.2D
    FCMLT  S4, S1, #0.0
    CMGT  D23, D6, D9
    FCMEQ  D4, D12, D21
    FCMEQ  S23, S4, S15
    FACGE  S15, S9, S23
    FACGT  S23, S27, S2
    FCMGT  V6.2D, V7.2D, #0.0
    CMGE  D17, D4, #0
    FCMGT  V3.2S, V2.2S, V30.2S
    CMHI  V31.4S, V16.4S, V10.4S
    FCMGE  D21, D8, D23
    CMGT  V19.16B, V9.16B, V21.16B
    FCMGE  D24, D31, D16
    FCMLT  S3, S3, #0.0
    CMEQ  V3.2D, V21.2D, V4.2D
    FCMLT  V17.2S, V8.2S, #0.0
    CMTST  D27, D12, D6
    CMEQ  D16, D7, #0
    FCMEQ  D2, D18, D14
    CMTST  V15.8H, V15.8H, V1.8H
    FCMGT  V2.2D, V28.2D, #0.0
    CMTST  V3.2S, V28.2S, V29.2S
    CMHS  D3, D15, D21
    CMGT  D30, D22, #0
    CMLT  D23, D9, #0
    FCMLE  S14, S2, #0.0
    CMGT  V14.4S, V13.4S, V1.4S
    CMLE  V30.8H, V26.8H, #0
    FCMGT  S14, S6, #0.0
    FCMGT  S6, S19, S9
    CMEQ  V12.16B, V19.16B, V3.16B
    CMLT  D6, D8, #0
    FCMGE  S27, S0, #0.0
    FCMLE  D31, D30, #0.0
    CMGT  V28.8B, V3.8B, V14.8B
    CMEQ  V16.8H, V4.8H, #0
    FACGE  V24.2D, V2.2D, V22.2D
    CMTST  V12.16B, V13.16B, V13.16B
    CMGT  V15.2S, V6.2S, V10.2S
    CMTST  D16, D15, D15
    FCMEQ  V8.4S, V11.4S, V27.4S
    CMGE  D23, D4, #0
    FCMEQ  D5, D24, D24
    CMEQ  V11.4H, V12.4H, #0
    FACGT  S3, S21, S0
    CMGE  D4, D3, #0
    FCMGE  S31, S1, #0.0
    FCMLT  D27, D14, #0.0
    FCMLT  S19, S21, #0.0
    CMEQ  D16, D25, #0
    CMLT  D19, D5, #0
    CMGT  V7.16B, V5.16B, #0
    FACGE  D14, D21, D3
    FCMGT  D22, D0, #0.0
    CMGE  D19, D3, #0
    FCMLE  D22, D21, #0.0
    FCMGT  D17, D7, #0.0
    FCMGE  V30.4S, V0.4S, V4.4S
    CMTST  D16, D0, D1
    CMHI  V19.8B, V24.8B, V9.8B
    CMGT  V30.4H, V5.4H, #0
    FCMGE  D14, D3, #0.0
    CMTST  D26, D25, D30
    FACGT  D11, D12, D2
    FACGE  D26, D25, D16
    FCMLE  S20, S31, #0.0
    FCMGE  V22.4S, V30.4S, #0.0
    CMLE  D5, D15, #0
    FCMLE  V6.2D, V8.2D, #0.0
    CMEQ  V3.4H, V14.4H, V9.4H
    FACGT  S30, S27, S3
    FACGT  V12.2S, V25.2S, V11.2S
    FCMEQ  V25.4S, V0.4S, V24.4S
    CMGE  D11, D9, #0
    FCMGE  S14, S31, S1
    SUBS  X18, X18, #0x1
    B.NE  TaishanSimdPermuteP01_label_884
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X22, X5, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X21, X5, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X12, X2, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X22, X19, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X12, X6, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X18, X7, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X22, X12, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X4, X24, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X17, X2, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X16, X14, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X3, X14, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X13, X11, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X26, X2, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X9, X18, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X27, X3, X29
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D3
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X19, X18, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D4
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X21, X8, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D5
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X9, X11, X24
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D6
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D7
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X16, X13, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D8
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X16, X13, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D9
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X24, X13, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D13
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X14, X22, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X9, X25, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D18
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X9, X25, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D20
    MOVZ  X28, #0x0, LSL #0
    SUB  X4, X28, X2
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X2, X23, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D21
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X2, X23, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X21, X25, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D22
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X21, X25, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X25, X22, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D24
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X25, X22, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D26
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X13
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D29
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x8b6c, LSL #0
    MOVK  X2, #0xa3cf, LSL #16
    MOVK  X2, #0xa409, LSL #32
    MOVK  X2, #0x822f, LSL #48
    MOVZ  X3, #0xcb24, LSL #0
    MOVK  X3, #0xccb4, LSL #16
    MOVK  X3, #0xcc86, LSL #32
    MOVK  X3, #0x5175, LSL #48
    MOVZ  X4, #0xc928, LSL #0
    MOVK  X4, #0x8d28, LSL #16
    MOVK  X4, #0xa004, LSL #32
    MOVK  X4, #0xba36, LSL #48
    MOVZ  X5, #0x11b5, LSL #0
    MOVK  X5, #0xc242, LSL #16
    MOVK  X5, #0xe94b, LSL #32
    MOVK  X5, #0x4fa7, LSL #48
    MOVZ  X6, #0xf112, LSL #0
    MOVK  X6, #0xa1be, LSL #16
    MOVK  X6, #0x9852, LSL #32
    MOVK  X6, #0x20da, LSL #48
    MOVZ  X7, #0x7cec, LSL #0
    MOVK  X7, #0xfed1, LSL #16
    MOVK  X7, #0xb9ba, LSL #32
    MOVK  X7, #0xbfec, LSL #48
    MOVZ  X8, #0xca92, LSL #0
    MOVK  X8, #0x1d59, LSL #16
    MOVK  X8, #0x29eb, LSL #32
    MOVK  X8, #0x9935, LSL #48
    MOVZ  X9, #0x2aef, LSL #0
    MOVK  X9, #0x76c6, LSL #16
    MOVK  X9, #0xcd3f, LSL #32
    MOVK  X9, #0xede0, LSL #48
    MOVZ  X10, #0x64ac, LSL #0
    MOVK  X10, #0x8c79, LSL #16
    MOVK  X10, #0xf6e9, LSL #32
    MOVK  X10, #0x9213, LSL #48
    MOVZ  X11, #0x880a, LSL #0
    MOVK  X11, #0xcb03, LSL #16
    MOVK  X11, #0x9da5, LSL #32
    MOVK  X11, #0x5ccc, LSL #48
    MOVZ  X12, #0x2fcf, LSL #0
    MOVK  X12, #0x3484, LSL #16
    MOVK  X12, #0x8a23, LSL #32
    MOVK  X12, #0x8957, LSL #48
    MOVZ  X13, #0x2f62, LSL #0
    MOVK  X13, #0x4d25, LSL #16
    MOVK  X13, #0x8da2, LSL #32
    MOVK  X13, #0xde3d, LSL #48
    MOVZ  X14, #0xc5f3, LSL #0
    MOVK  X14, #0xa452, LSL #16
    MOVK  X14, #0x126d, LSL #32
    MOVK  X14, #0xee68, LSL #48
    MOVZ  X16, #0xa7ba, LSL #0
    MOVK  X16, #0x3815, LSL #16
    MOVK  X16, #0x2a00, LSL #32
    MOVK  X16, #0xf02b, LSL #48
    MOVZ  X17, #0x92e6, LSL #0
    MOVK  X17, #0x533c, LSL #16
    MOVK  X17, #0xe9f, LSL #32
    MOVK  X17, #0x88bb, LSL #48
    MOVZ  X18, #0x3f8d, LSL #0
    MOVK  X18, #0xc2eb, LSL #16
    MOVK  X18, #0xb879, LSL #32
    MOVK  X18, #0x4b54, LSL #48
    MOVZ  X19, #0x2937, LSL #0
    MOVK  X19, #0x4be0, LSL #16
    MOVK  X19, #0x2c14, LSL #32
    MOVK  X19, #0x8c7, LSL #48
    MOVZ  X20, #0xc29d, LSL #0
    MOVK  X20, #0xf448, LSL #16
    MOVK  X20, #0x859f, LSL #32
    MOVK  X20, #0xeff2, LSL #48
    MOVZ  X21, #0x8f38, LSL #0
    MOVK  X21, #0xb547, LSL #16
    MOVK  X21, #0x6a52, LSL #32
    MOVK  X21, #0xbc52, LSL #48
    MOVZ  X22, #0xa95e, LSL #0
    MOVK  X22, #0xbf24, LSL #16
    MOVK  X22, #0x8923, LSL #32
    MOVK  X22, #0x5fb8, LSL #48
    MOVZ  X23, #0x5696, LSL #0
    MOVK  X23, #0x3dfd, LSL #16
    MOVK  X23, #0xb5fc, LSL #32
    MOVK  X23, #0xa700, LSL #48
    MOVZ  X24, #0x6439, LSL #0
    MOVK  X24, #0x4b52, LSL #16
    MOVK  X24, #0xe69b, LSL #32
    MOVK  X24, #0x49e9, LSL #48
    MOVZ  X25, #0x1635, LSL #0
    MOVK  X25, #0xba50, LSL #16
    MOVK  X25, #0x96f7, LSL #32
    MOVK  X25, #0xfa63, LSL #48
    MOVZ  X26, #0xc019, LSL #0
    MOVK  X26, #0x751c, LSL #16
    MOVK  X26, #0x9b3, LSL #32
    MOVK  X26, #0x2244, LSL #48
    MOVZ  X27, #0x60d2, LSL #0
    MOVK  X27, #0xde02, LSL #16
    MOVK  X27, #0xb00c, LSL #32
    MOVK  X27, #0xa5b7, LSL #48
    MOVZ  X28, #0x556d, LSL #0
    MOVK  X28, #0x61d2, LSL #16
    MOVK  X28, #0x3186, LSL #32
    MOVK  X28, #0x2199, LSL #48
    MOVZ  X29, #0x7d37, LSL #0
    MOVK  X29, #0x6579, LSL #16
    MOVK  X29, #0x315, LSL #32
    MOVK  X29, #0x4c4f, LSL #48
    FMOV  D0, X16
    FMOV  V0.D[1], X14
    FMOV  D1, X25
    FMOV  V1.D[1], X21
    FMOV  D2, X21
    FMOV  V2.D[1], X26
    FMOV  D3, X19
    FMOV  V3.D[1], X6
    FMOV  D4, X18
    FMOV  V4.D[1], X4
    FMOV  D5, X4
    FMOV  V5.D[1], X18
    FMOV  D6, X16
    FMOV  V6.D[1], X29
    FMOV  D7, X9
    FMOV  V7.D[1], X13
    FMOV  D8, X28
    FMOV  V8.D[1], X4
TaishanSimdPermuteP01_label_542:
    FMOV  D9, X24
    FMOV  V9.D[1], X11
    FMOV  D10, X9
    FMOV  V10.D[1], X10
    FMOV  D11, X25
    FMOV  V11.D[1], X19
    FMOV  D12, X4
    FMOV  V12.D[1], X23
    FMOV  D13, X6
    FMOV  V13.D[1], X10
    FMOV  D14, X29
    FMOV  V14.D[1], X22
    FMOV  D15, X20
    FMOV  V15.D[1], X8
    FMOV  D16, X29
    FMOV  V16.D[1], X19
    FMOV  D17, X24
    FMOV  V17.D[1], X16
    FMOV  D18, X4
    FMOV  V18.D[1], X5
    FMOV  D19, X6
    FMOV  V19.D[1], X3
    FMOV  D20, X8
    FMOV  V20.D[1], X16
    FMOV  D21, X27
    FMOV  V21.D[1], X11
    FMOV  D22, X11
    FMOV  V22.D[1], X24
    FMOV  D23, X29
    FMOV  V23.D[1], X6
    FMOV  D24, X19
    FMOV  V24.D[1], X3
    FMOV  D25, X29
    FMOV  V25.D[1], X12
    FMOV  D26, X25
    FMOV  V26.D[1], X29
    FMOV  D27, X25
    FMOV  V27.D[1], X7
    FMOV  D28, X10
    FMOV  V28.D[1], X14
    FMOV  D29, X11
    FMOV  V29.D[1], X7
    FMOV  D30, X29
    FMOV  V30.D[1], X3
    FMOV  D31, X11
    FMOV  V31.D[1], X11
    MOVZ  X12, #0xa, LSL #0
TaishanSimdPermuteP01_label_962:
    CMGT  V6.2S, V28.2S, V6.2S
    FACGT  D25, D10, D14
    FCMLT  D27, D29, #0.0
    FCMGT  S21, S29, S17
    FCMGT  D26, D19, #0.0
    CMGT  D6, D21, D13
    CMLT  D15, D3, #0
    CMGT  D25, D20, #0
    FCMEQ  S3, S10, S15
    FCMGT  D27, D6, #0.0
    CMEQ  D24, D27, #0
    FCMEQ  V30.2S, V31.2S, #0.0
    CMLT  D7, D9, #0
    FCMGT  S12, S7, S29
    CMEQ  V18.2D, V13.2D, V30.2D
    FCMEQ  S29, S19, #0.0
    FCMGT  S30, S18, S25
    FCMEQ  S14, S5, S20
    CMGT  D13, D21, #0
    CMGE  D26, D31, #0
    FCMLE  V17.4S, V27.4S, #0.0
    FCMGE  V24.2D, V9.2D, #0.0
    FCMEQ  D12, D10, D18
    FACGE  D19, D17, D23
    FCMEQ  S3, S12, #0.0
    FCMLT  D16, D27, #0.0
    CMEQ  V2.8B, V7.8B, #0
    FCMGE  S22, S16, S14
    FCMEQ  V4.4S, V28.4S, #0.0
    FCMEQ  V6.2D, V30.2D, #0.0
    CMLT  V9.2D, V28.2D, #0
    CMEQ  V2.4S, V4.4S, #0
    FCMLT  V28.2D, V7.2D, #0.0
    CMHI  D2, D12, D13
    CMGT  D3, D21, D30
    CMGE  D11, D8, #0
    FCMEQ  S0, S22, #0.0
    CMHS  V22.4H, V12.4H, V3.4H
    CMHI  V29.2S, V29.2S, V25.2S
    CMGT  V10.8H, V25.8H, V23.8H
    FCMLE  V11.4S, V14.4S, #0.0
    FCMLE  D23, D18, #0.0
    FCMGT  V1.4S, V7.4S, V13.4S
    FCMGT  S28, S6, #0.0
    CMGT  V4.4S, V24.4S, V23.4S
    CMGT  V14.2D, V5.2D, #0
    CMLT  D10, D16, #0
    FCMGE  D1, D13, #0.0
    CMTST  V15.4H, V6.4H, V29.4H
    CMGE  D3, D28, #0
    FCMEQ  V15.2S, V9.2S, V1.2S
    FCMLT  S2, S14, #0.0
    CMGT  D8, D31, #0
    FCMEQ  D30, D12, D11
    CMGT  D8, D25, #0
    FACGE  S20, S25, S11
    FCMEQ  S15, S22, #0.0
    FCMGT  S1, S22, #0.0
    FACGE  D5, D11, D3
    FCMGE  S17, S6, #0.0
    CMGE  V8.2S, V24.2S, V15.2S
    CMLT  V5.2S, V0.2S, #0
    CMHS  V10.4H, V2.4H, V11.4H
    FACGE  V30.4S, V15.4S, V17.4S
    CMLT  V25.8H, V3.8H, #0
    FCMEQ  S10, S7, S30
    FCMLT  D29, D20, #0.0
    FCMGT  S7, S13, #0.0
    CMLT  V5.4H, V29.4H, #0
    CMLT  D28, D25, #0
    FCMGT  V1.2S, V5.2S, V10.2S
    FCMGE  D30, D26, #0.0
    FACGT  D12, D14, D20
    CMEQ  V4.8B, V12.8B, V23.8B
    CMGE  V1.8B, V7.8B, V8.8B
    FCMEQ  V9.4S, V21.4S, #0.0
    CMLT  V29.4H, V5.4H, #0
    FCMGT  D15, D27, #0.0
    CMGT  V22.16B, V28.16B, V10.16B
    FCMGT  V12.4S, V24.4S, #0.0
    FCMGT  V27.2S, V6.2S, V6.2S
    FACGT  V27.2D, V23.2D, V19.2D
    CMLE  V9.8H, V30.8H, #0
    CMHS  V5.8B, V31.8B, V16.8B
    FCMEQ  S16, S5, #0.0
    FCMEQ  V22.4S, V8.4S, V15.4S
    CMHI  V23.8B, V22.8B, V20.8B
    CMHI  V15.2D, V26.2D, V29.2D
    CMHI  D18, D7, D29
    FCMGE  V23.2D, V3.2D, V6.2D
    FCMGT  S23, S6, S28
    FCMLT  D15, D15, #0.0
    FCMLT  S16, S2, #0.0
    CMGE  V3.2S, V27.2S, V22.2S
    CMLE  D20, D12, #0
    FCMEQ  V7.2D, V15.2D, #0.0
    FCMLE  D7, D26, #0.0
    CMHS  D13, D18, D30
    FCMEQ  S5, S28, S2
    FCMGE  D21, D23, #0.0
    CMGE  V14.4S, V26.4S, #0
    FACGT  D22, D11, D29
    FCMGE  V18.4S, V3.4S, #0.0
    FCMGT  D20, D7, D27
    FCMGE  V2.2S, V19.2S, V3.2S
    CMGE  V10.2D, V6.2D, V4.2D
    FCMGT  D24, D7, D12
    FCMEQ  V24.2D, V23.2D, #0.0
    FCMGT  D9, D9, #0.0
    FCMEQ  D20, D7, #0.0
    CMHS  V31.8H, V31.8H, V25.8H
    FCMEQ  D14, D24, D4
    CMTST  V17.2S, V11.2S, V23.2S
    CMHS  V23.2D, V30.2D, V10.2D
    FCMGE  S12, S19, S12
    FCMGT  S18, S18, S5
    CMLT  V2.2S, V25.2S, #0
    CMGT  D20, D27, #0
    FCMGE  V23.2S, V19.2S, #0.0
    CMGE  D28, D12, #0
    CMGT  V29.2D, V5.2D, V24.2D
    FCMEQ  S11, S30, #0.0
    FACGE  V20.4S, V26.4S, V31.4S
    CMTST  V28.4S, V30.4S, V7.4S
    CMGE  V2.8H, V23.8H, V31.8H
    CMLT  D24, D9, #0
    FCMEQ  D15, D4, #0.0
    CMGE  V9.16B, V24.16B, V17.16B
    FACGT  D23, D27, D31
    FCMLT  V0.4S, V27.4S, #0.0
    CMHI  D0, D14, D15
    FCMLE  S3, S11, #0.0
    FCMLT  V11.2S, V18.2S, #0.0
    FCMLE  D7, D29, #0.0
    FCMLE  S10, S6, #0.0
    FCMEQ  D16, D13, D31
    FCMGT  S15, S26, #0.0
    CMGE  V14.2S, V7.2S, #0
    FCMLT  S16, S19, #0.0
    FCMGT  S6, S12, S16
    FCMGT  V2.2D, V16.2D, V17.2D
    FCMEQ  V20.2S, V21.2S, V18.2S
    CMLT  V13.4S, V20.4S, #0
    CMGT  V11.4H, V11.4H, #0
    CMEQ  D15, D18, #0
    FACGE  V10.2S, V26.2S, V26.2S
    FCMEQ  D15, D5, #0.0
    FCMGT  V29.2D, V6.2D, V8.2D
    FCMLE  S5, S26, #0.0
    FCMGT  S3, S10, S14
    FCMGE  S21, S15, S10
    CMGT  V2.2D, V17.2D, V9.2D
    FCMGT  D3, D19, D13
    FCMLT  S18, S21, #0.0
    CMHI  V5.8H, V6.8H, V13.8H
    FCMGT  S8, S21, #0.0
    FCMLE  V14.2D, V15.2D, #0.0
    CMEQ  D15, D15, D11
    FCMGT  D30, D19, #0.0
    FACGE  V28.4S, V19.4S, V3.4S
    CMHS  D21, D8, D15
    FCMGE  V6.2D, V10.2D, #0.0
    CMGT  D5, D28, #0
    CMGT  D3, D27, D28
    CMGT  D28, D3, D18
    CMEQ  V15.16B, V6.16B, #0
    CMHI  D18, D13, D13
    FACGT  S26, S30, S6
    FACGT  D3, D15, D2
    FCMEQ  D29, D0, #0.0
    FCMEQ  D5, D1, D9
    FCMGT  S8, S15, #0.0
    FACGE  S0, S12, S30
    FCMLT  S18, S21, #0.0
    FCMEQ  V18.4S, V9.4S, V9.4S
    FACGT  S2, S17, S8
    FACGE  V27.2S, V10.2S, V4.2S
    CMLE  D16, D29, #0
    FCMGT  D13, D10, #0.0
    CMHS  V18.16B, V29.16B, V26.16B
    CMGT  D8, D10, D20
    FCMEQ  S5, S5, S12
    CMGE  V24.8B, V31.8B, #0
    FCMGE  D14, D29, #0.0
    CMHI  D9, D24, D19
    FCMGE  S21, S11, #0.0
    FACGT  D21, D11, D0
    FCMGT  V26.4S, V5.4S, V31.4S
    FACGT  V25.4S, V26.4S, V14.4S
    CMHI  V19.4S, V12.4S, V6.4S
    CMHS  D15, D15, D23
    CMLT  V8.16B, V22.16B, #0
    FCMGT  S3, S10, S18
    FCMLE  V28.2S, V16.2S, #0.0
    CMEQ  D29, D0, D30
    CMGT  D13, D30, D26
    CMGE  D21, D2, D27
    FCMGE  D4, D20, D6
    FACGT  S29, S31, S23
    FCMEQ  V24.2D, V31.2D, V16.2D
    SUBS  X12, X12, #0x1
    B.NE  TaishanSimdPermuteP01_label_962
    MOVZ  X16, #0x8b6c, LSL #0
    MOVK  X16, #0xa3cf, LSL #16
    MOVK  X16, #0xa409, LSL #32
    MOVK  X16, #0x822f, LSL #48
    SUB  X11, X16, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0xcb24, LSL #0
    MOVK  X16, #0xccb4, LSL #16
    MOVK  X16, #0xcc86, LSL #32
    MOVK  X16, #0x5175, LSL #48
    SUB  X25, X16, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0xc928, LSL #0
    MOVK  X25, #0x8d28, LSL #16
    MOVK  X25, #0xa004, LSL #32
    MOVK  X25, #0xba36, LSL #48
    SUB  X18, X25, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x11b5, LSL #0
    MOVK  X28, #0xc242, LSL #16
    MOVK  X28, #0xe94b, LSL #32
    MOVK  X28, #0x4fa7, LSL #48
    SUB  X6, X28, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x7cec, LSL #0
    MOVK  X22, #0xfed1, LSL #16
    MOVK  X22, #0xb9ba, LSL #32
    MOVK  X22, #0xbfec, LSL #48
    SUB  X28, X22, X7
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0xca92, LSL #0
    MOVK  X19, #0x1d59, LSL #16
    MOVK  X19, #0x29eb, LSL #32
    MOVK  X19, #0x9935, LSL #48
    SUB  X12, X19, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x2aef, LSL #0
    MOVK  X22, #0x76c6, LSL #16
    MOVK  X22, #0xcd3f, LSL #32
    MOVK  X22, #0xede0, LSL #48
    SUB  X7, X22, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x64ac, LSL #0
    MOVK  X28, #0x8c79, LSL #16
    MOVK  X28, #0xf6e9, LSL #32
    MOVK  X28, #0x9213, LSL #48
    SUB  X29, X28, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X11
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x2f62, LSL #0
    MOVK  X12, #0x4d25, LSL #16
    MOVK  X12, #0x8da2, LSL #32
    MOVK  X12, #0xde3d, LSL #48
    SUB  X29, X12, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xc5f3, LSL #0
    MOVK  X9, #0xa452, LSL #16
    MOVK  X9, #0x126d, LSL #32
    MOVK  X9, #0xee68, LSL #48
    SUB  X16, X9, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X16, X2, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X19
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x8f38, LSL #0
    MOVK  X18, #0xb547, LSL #16
    MOVK  X18, #0x6a52, LSL #32
    MOVK  X18, #0xbc52, LSL #48
    SUB  X26, X18, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x2aef, LSL #0
    MOVK  X26, #0x76c6, LSL #16
    MOVK  X26, #0xcd3f, LSL #32
    MOVK  X26, #0xede0, LSL #48
    SUB  X12, X26, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x6439, LSL #0
    MOVK  X29, #0x4b52, LSL #16
    MOVK  X29, #0xe69b, LSL #32
    MOVK  X29, #0x49e9, LSL #48
    SUB  X3, X29, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x2aef, LSL #0
    MOVK  X27, #0x76c6, LSL #16
    MOVK  X27, #0xcd3f, LSL #32
    MOVK  X27, #0xede0, LSL #48
    SUB  X26, X27, X26
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x2aef, LSL #0
    MOVK  X27, #0x76c6, LSL #16
    MOVK  X27, #0xcd3f, LSL #32
    MOVK  X27, #0xede0, LSL #48
    SUB  X12, X27, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x64ac, LSL #0
    MOVK  X16, #0x8c79, LSL #16
    MOVK  X16, #0xf6e9, LSL #32
    MOVK  X16, #0x9213, LSL #48
    SUB  X27, X16, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0x6439, LSL #0
    MOVK  X24, #0x4b52, LSL #16
    MOVK  X24, #0xe69b, LSL #32
    MOVK  X24, #0x49e9, LSL #48
    SUB  X14, X24, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D4
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D5
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X2
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X22, X8, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D6
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X22, X8, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D9
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D10
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D12
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    SUB  X23, X5, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D14
    MOVZ  X17, #0x0, LSL #0
    SUB  X2, X17, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D16
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X3, X13, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X9, X12, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D18
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X9, X12, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X22, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X12, X27, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D21
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X3, X23, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D22
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D23
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D24
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X8
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D27
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X26, X29, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D28
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
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
    FMOV  V0.D[1], X12
    FMOV  D1, X3
    FMOV  V1.D[1], X3
    FMOV  D2, X10
    FMOV  V2.D[1], X22
    FMOV  D3, X16
    FMOV  V3.D[1], X11
    FMOV  D4, X21
    FMOV  V4.D[1], X23
    FMOV  D5, X24
    FMOV  V5.D[1], X25
    FMOV  D6, X2
    FMOV  V6.D[1], X19
    FMOV  D7, X27
    FMOV  V7.D[1], X28
    FMOV  D8, X11
    FMOV  V8.D[1], X17
    FMOV  D9, X29
    FMOV  V9.D[1], X17
    FMOV  D10, X14
    FMOV  V10.D[1], X28
    FMOV  D11, X9
    FMOV  V11.D[1], X8
    FMOV  D12, X8
    FMOV  V12.D[1], X24
    FMOV  D13, X17
    FMOV  V13.D[1], X3
    FMOV  D14, X6
    FMOV  V14.D[1], X27
    FMOV  D15, X18
    FMOV  V15.D[1], X23
    FMOV  D16, X16
    FMOV  V16.D[1], X6
    FMOV  D17, X14
    FMOV  V17.D[1], X2
    FMOV  D18, X12
    FMOV  V18.D[1], X28
    FMOV  D19, X29
    FMOV  V19.D[1], X11
    FMOV  D20, X29
    FMOV  V20.D[1], X12
    FMOV  D21, X9
    FMOV  V21.D[1], X17
    FMOV  D22, X3
    FMOV  V22.D[1], X29
    FMOV  D23, X10
    FMOV  V23.D[1], X5
    FMOV  D24, X22
    FMOV  V24.D[1], X2
    FMOV  D25, X27
    FMOV  V25.D[1], X6
    FMOV  D26, X19
    FMOV  V26.D[1], X14
    FMOV  D27, X13
    FMOV  V27.D[1], X13
    FMOV  D28, X26
    FMOV  V28.D[1], X8
    FMOV  D29, X10
    FMOV  V29.D[1], X24
    FMOV  D30, X4
    FMOV  V30.D[1], X5
    FMOV  D31, X9
    FMOV  V31.D[1], X4
    MOVZ  X23, #0xa, LSL #0
TaishanSimdPermuteP01_label_1040:
    FCMEQ  D24, D11, #0.0
    FCMLE  D31, D28, #0.0
    CMHI  V17.16B, V2.16B, V21.16B
    FCMLT  V9.2S, V13.2S, #0.0
    FCMLT  V18.2D, V26.2D, #0.0
    FCMGE  S7, S5, S25
    FCMEQ  S11, S19, #0.0
    FCMGT  S1, S27, #0.0
    CMGT  D18, D15, D20
    FACGT  S28, S1, S1
    CMHS  V5.8H, V10.8H, V3.8H
    FCMGT  V9.4S, V22.4S, V12.4S
    CMGE  V0.2S, V2.2S, V8.2S
    FCMGE  D17, D15, D4
    FACGT  V12.2S, V25.2S, V30.2S
    FACGE  D24, D30, D31
    CMEQ  V9.2D, V7.2D, V16.2D
    FCMGE  D12, D19, #0.0
    CMLT  D6, D29, #0
    FCMEQ  S22, S29, S27
    CMHS  D25, D7, D1
    CMEQ  D6, D28, #0
    FCMEQ  D29, D5, #0.0
    FCMLT  D27, D30, #0.0
    FCMEQ  S17, S9, S20
    FACGT  V30.4S, V30.4S, V3.4S
    FCMLE  V22.4S, V14.4S, #0.0
    FCMGE  S31, S14, #0.0
    FCMLE  V15.2S, V9.2S, #0.0
    FCMGT  S24, S27, #0.0
    FCMGT  S13, S7, S7
    CMGT  D3, D4, D16
    CMLE  V2.16B, V13.16B, #0
    CMGE  V31.8B, V23.8B, #0
    CMEQ  D5, D7, D14
    CMEQ  V31.4H, V9.4H, V4.4H
    CMTST  V25.16B, V15.16B, V13.16B
    FCMEQ  V14.2D, V25.2D, V6.2D
    FCMLE  D7, D7, #0.0
    CMGE  D15, D10, #0
    FCMEQ  D0, D1, #0.0
    CMHS  D1, D15, D14
    FCMGE  S25, S5, #0.0
    FCMGE  D10, D24, D27
    FACGE  V15.2D, V22.2D, V12.2D
    FCMLT  D3, D29, #0.0
    CMGE  D3, D13, D21
    FACGT  V30.2S, V22.2S, V28.2S
    FACGE  D2, D1, D7
    FCMEQ  D31, D10, D17
    FCMLE  S22, S26, #0.0
    FACGT  V11.4S, V19.4S, V22.4S
    CMGE  D17, D13, #0
    CMGT  V1.4S, V13.4S, #0
    CMHS  D7, D26, D28
    FACGE  D22, D31, D11
    FCMGE  S16, S13, S0
    FCMGE  S20, S30, S30
    FCMGT  D13, D19, D30
    FCMGE  V15.4S, V22.4S, #0.0
    FCMLE  V13.2D, V3.2D, #0.0
    CMLT  V19.4H, V12.4H, #0
    FCMEQ  V24.2S, V4.2S, V29.2S
    CMHS  D15, D16, D4
    FCMGE  D24, D5, D4
    FCMGE  D4, D24, #0.0
    CMLE  V4.4S, V20.4S, #0
    CMLT  D16, D2, #0
    FACGT  D4, D10, D9
    FCMLT  D7, D31, #0.0
    CMLT  D17, D29, #0
    FCMGE  V0.4S, V12.4S, V9.4S
    FACGT  V5.4S, V14.4S, V30.4S
    FCMGE  V14.2D, V1.2D, V12.2D
    FACGT  D5, D2, D16
    FCMEQ  D21, D7, D20
    FACGE  S20, S28, S7
    FCMGE  S24, S3, S2
    CMLE  D6, D8, #0
    FCMEQ  D23, D6, #0.0
    CMEQ  V31.2S, V29.2S, #0
    FCMEQ  D30, D5, D29
    FCMGT  S12, S15, #0.0
    CMEQ  D8, D13, D6
    CMHS  D15, D2, D5
    FCMLT  S7, S11, #0.0
    CMGE  D22, D21, #0
    FCMGE  V28.2D, V30.2D, #0.0
    CMTST  V9.4S, V4.4S, V8.4S
    FCMGT  D9, D3, D0
    FCMGE  D12, D9, #0.0
    CMTST  V16.2D, V10.2D, V16.2D
    CMHI  V22.8H, V28.8H, V16.8H
    CMLE  D5, D29, #0
    FCMEQ  V30.2D, V21.2D, #0.0
    CMEQ  V2.4S, V21.4S, V31.4S
    FCMGT  S23, S19, #0.0
    FCMEQ  S8, S2, #0.0
    FCMEQ  V3.4S, V5.4S, V30.4S
    FCMEQ  S13, S7, S1
    FCMGE  V7.2S, V2.2S, #0.0
    FCMGE  V3.4S, V17.4S, V4.4S
    FACGE  D10, D25, D2
    CMHS  D7, D13, D15
    CMGT  D28, D0, #0
    FACGT  V15.4S, V1.4S, V16.4S
    CMLT  D12, D15, #0
    FCMLT  V23.2S, V25.2S, #0.0
    CMGT  D16, D20, #0
    FCMLT  S19, S8, #0.0
    FCMGT  D5, D2, #0.0
    FACGT  V8.4S, V16.4S, V23.4S
    CMLT  V3.2S, V16.2S, #0
    CMGT  V29.8H, V12.8H, #0
    FACGE  V14.2S, V19.2S, V4.2S
    CMGE  D23, D5, D13
    FCMLT  V16.2D, V17.2D, #0.0
    FCMLE  S12, S29, #0.0
    FCMGE  D6, D10, D16
    CMEQ  D25, D6, #0
    FCMEQ  S2, S1, #0.0
    CMLE  V19.16B, V15.16B, #0
    FCMGT  V23.2D, V14.2D, V21.2D
    FCMLT  V24.4S, V19.4S, #0.0
    CMHI  V2.4H, V29.4H, V21.4H
    FCMEQ  D31, D18, D11
    FCMLT  S29, S12, #0.0
    CMEQ  V21.4H, V29.4H, V17.4H
    FACGT  V31.2D, V13.2D, V20.2D
    CMLE  D21, D14, #0
    FACGE  V0.2D, V13.2D, V23.2D
    FCMGE  S13, S21, #0.0
    FCMEQ  S24, S16, S27
    FCMGE  V4.2D, V10.2D, V4.2D
    CMGT  V29.8H, V25.8H, #0
    FCMGE  V25.2D, V26.2D, #0.0
    CMHI  V23.2D, V3.2D, V10.2D
    CMGE  D20, D0, #0
    CMEQ  V19.2S, V13.2S, #0
    FCMGE  D25, D14, #0.0
    FCMGT  S12, S26, #0.0
    FCMEQ  V4.2D, V23.2D, #0.0
    FCMLE  V3.4S, V31.4S, #0.0
    FACGE  V0.4S, V8.4S, V4.4S
    CMEQ  V10.2S, V4.2S, #0
    FACGT  V11.2S, V26.2S, V29.2S
    CMTST  D25, D15, D24
    CMLT  V20.8B, V4.8B, #0
    FACGE  V11.2S, V10.2S, V20.2S
    FACGE  D19, D18, D6
    FCMEQ  S12, S12, S2
    FCMGT  V24.4S, V25.4S, V0.4S
    FCMEQ  V20.4S, V31.4S, V26.4S
    CMHI  D29, D15, D5
    CMLE  V26.2S, V12.2S, #0
    FCMLE  D17, D18, #0.0
    FCMGT  V1.2S, V25.2S, #0.0
    CMGT  V26.2D, V13.2D, #0
    FACGE  S29, S25, S26
    FCMGE  D17, D24, D21
    FCMEQ  S16, S19, S25
    FCMGE  D6, D7, D18
    FCMGE  D3, D2, #0.0
    CMHI  V29.4S, V12.4S, V15.4S
    CMGT  V29.16B, V31.16B, V5.16B
    FCMGE  V22.4S, V27.4S, #0.0
    CMEQ  V14.2S, V25.2S, #0
    FACGE  V17.2D, V2.2D, V11.2D
    FCMLT  V8.2S, V15.2S, #0.0
    CMLE  D12, D8, #0
    FCMEQ  V13.2D, V2.2D, V28.2D
    CMLT  D25, D24, #0
    FCMLT  S22, S13, #0.0
    CMGE  V4.8H, V10.8H, #0
    FCMLT  V2.4S, V25.4S, #0.0
    CMEQ  V30.2D, V7.2D, V30.2D
    FCMLT  D15, D16, #0.0
    FCMGT  S17, S0, #0.0
    FCMLT  V9.2D, V14.2D, #0.0
    FCMEQ  S25, S0, #0.0
    FCMEQ  D2, D21, #0.0
    CMEQ  D30, D9, D5
    CMTST  V1.2S, V1.2S, V21.2S
    FCMLE  V1.2D, V14.2D, #0.0
    CMLT  D20, D15, #0
    FCMLE  V24.2D, V22.2D, #0.0
    FCMGE  V4.2S, V19.2S, V11.2S
    FCMGT  D2, D19, #0.0
    FCMGT  S28, S9, S11
    FACGE  V28.4S, V12.4S, V11.4S
    FCMEQ  D30, D11, #0.0
    CMHI  D2, D28, D9
    FACGT  V22.2D, V23.2D, V9.2D
    CMGT  D10, D15, #0
    CMLT  V10.4S, V11.4S, #0
    FCMGE  V28.4S, V2.4S, V1.4S
    FACGE  S18, S22, S8
    FACGE  V5.2S, V0.2S, V20.2S
    CMHS  D0, D12, D29
    FCMEQ  V23.4S, V10.4S, #0.0
    SUBS  X23, X23, #0x1
    B.NE  TaishanSimdPermuteP01_label_1040
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X24, X6, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X16, X27, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X7
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X5, X25, X14
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X17
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X6, X27, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X23
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X3, X12, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X27, X28, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X20, X27, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X19, X21, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X9, X28, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X22, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D3
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X6, X16, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D5
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D6
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X11, X13, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X29
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D10
    MOVZ  X19, #0x0, LSL #0
    SUB  X17, X19, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D11
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D12
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X9, X24, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V13.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X21, X7, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D13
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X21, X7, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D14
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X7, X8, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D17
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D18
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X7, X17, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D19
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X11, X17, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D21
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X8, X7, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X28, X9, X17
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X21, X10, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D23
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X21, X10, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D24
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X28, X20, X13
TaishanSimdPermuteP01_label_124:
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D25
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    SUB  X28, X20, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D28
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X29, X4, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X7
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
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
    FMOV  V0.D[1], X18
    FMOV  D1, X23
    FMOV  V1.D[1], X5
    FMOV  D2, X24
    FMOV  V2.D[1], X2
    FMOV  D3, X29
    FMOV  V3.D[1], X12
TaishanSimdPermuteP01_label_44:
    FMOV  D4, X20
    FMOV  V4.D[1], X28
    FMOV  D5, X8
    FMOV  V5.D[1], X10
    FMOV  D6, X19
    FMOV  V6.D[1], X12
    FMOV  D7, X8
    FMOV  V7.D[1], X23
    FMOV  D8, X2
    FMOV  V8.D[1], X4
    FMOV  D9, X17
    FMOV  V9.D[1], X18
    FMOV  D10, X11
    FMOV  V10.D[1], X21
    FMOV  D11, X7
    FMOV  V11.D[1], X19
    FMOV  D12, X6
    FMOV  V12.D[1], X4
    FMOV  D13, X28
    FMOV  V13.D[1], X18
    FMOV  D14, X6
    FMOV  V14.D[1], X24
    FMOV  D15, X16
    FMOV  V15.D[1], X22
    FMOV  D16, X29
    FMOV  V16.D[1], X19
    FMOV  D17, X13
    FMOV  V17.D[1], X24
    FMOV  D18, X11
    FMOV  V18.D[1], X7
    FMOV  D19, X27
    FMOV  V19.D[1], X3
    FMOV  D20, X12
    FMOV  V20.D[1], X8
    FMOV  D21, X4
    FMOV  V21.D[1], X14
    FMOV  D22, X4
    FMOV  V22.D[1], X19
    FMOV  D23, X20
    FMOV  V23.D[1], X7
    FMOV  D24, X4
    FMOV  V24.D[1], X10
    FMOV  D25, X19
    FMOV  V25.D[1], X16
    FMOV  D26, X11
    FMOV  V26.D[1], X13
    FMOV  D27, X17
    FMOV  V27.D[1], X8
    FMOV  D28, X2
    FMOV  V28.D[1], X2
    FMOV  D29, X8
    FMOV  V29.D[1], X26
    FMOV  D30, X14
    FMOV  V30.D[1], X20
    FMOV  D31, X3
    FMOV  V31.D[1], X3
    MOVZ  X29, #0xf, LSL #0
TaishanSimdPermuteP01_label_1117:
    CMTST  V28.2D, V31.2D, V14.2D
    FCMGT  S26, S29, #0.0
    CMTST  D17, D2, D24
    CMGE  D30, D24, D2
    CMHS  D9, D25, D3
    FCMEQ  D2, D5, #0.0
    FCMEQ  V1.2D, V4.2D, V5.2D
    CMGT  V1.4S, V22.4S, #0
    FCMGT  S24, S1, #0.0
    CMTST  D31, D27, D13
    FCMLT  S11, S23, #0.0
    FCMLE  S6, S0, #0.0
    FCMGE  D19, D18, #0.0
    CMLT  D29, D17, #0
    CMTST  V0.4H, V26.4H, V31.4H
    FCMGE  V21.2D, V4.2D, #0.0
    CMGE  D5, D9, D29
    FCMGT  V4.2D, V9.2D, V13.2D
    FACGE  S24, S27, S19
    FCMEQ  V30.4S, V2.4S, #0.0
    CMEQ  D21, D14, D29
    CMGT  D14, D27, #0
    FACGT  D11, D1, D21
    CMEQ  D0, D15, D20
    FCMGE  D7, D7, #0.0
    CMGE  V4.2S, V27.2S, #0
    CMHS  V26.4S, V24.4S, V4.4S
    FCMEQ  V5.4S, V0.4S, #0.0
    FCMLE  S30, S27, #0.0
    CMGE  V26.2S, V14.2S, V1.2S
    FCMEQ  D30, D2, D7
    CMHI  V5.8H, V18.8H, V9.8H
    FCMGE  S25, S11, #0.0
    FCMGE  S19, S29, #0.0
    FCMGE  V17.4S, V9.4S, #0.0
    CMGE  D4, D17, D21
    CMGT  D7, D16, #0
    FACGT  D15, D26, D27
    CMTST  V23.4S, V15.4S, V3.4S
    CMGE  D26, D15, #0
    FCMLT  V25.4S, V26.4S, #0.0
    FCMEQ  V22.2S, V12.2S, V19.2S
    FCMGT  S1, S30, #0.0
    CMLE  V21.8B, V15.8B, #0
    FCMEQ  V17.2S, V5.2S, #0.0
    FCMLE  S26, S15, #0.0
    FCMGE  S29, S5, S9
    FCMLT  S4, S13, #0.0
    CMLE  D5, D14, #0
    CMHI  V2.2D, V22.2D, V19.2D
    CMEQ  V21.2S, V21.2S, V25.2S
    FCMEQ  S29, S31, S20
    CMEQ  V5.4H, V9.4H, #0
    CMGT  V11.8H, V12.8H, V7.8H
    CMGT  V12.16B, V30.16B, #0
    FCMEQ  D23, D0, #0.0
    CMGE  V30.8B, V24.8B, #0
    FCMGE  V2.2D, V12.2D, V27.2D
    FCMGE  D20, D4, D27
    FCMGE  D18, D1, D22
    CMHS  V23.2S, V20.2S, V12.2S
    FCMGE  S29, S27, #0.0
    FCMEQ  D20, D14, #0.0
    CMGT  D30, D11, D18
    FCMGT  V16.4S, V10.4S, V26.4S
    CMGE  V10.4H, V6.4H, V10.4H
    CMHS  D1, D23, D11
    CMHI  D11, D29, D2
    FCMLT  V13.2D, V31.2D, #0.0
    CMTST  V25.16B, V17.16B, V11.16B
    CMGE  V0.8H, V0.8H, V21.8H
    CMTST  V10.8B, V30.8B, V11.8B
    CMHS  V10.2S, V18.2S, V20.2S
    FCMEQ  D16, D25, D14
    CMHS  V10.4H, V12.4H, V13.4H
    CMEQ  D6, D1, D16
    FCMEQ  V14.2D, V0.2D, #0.0
    CMLE  D10, D14, #0
    FCMEQ  V10.2S, V1.2S, #0.0
    FCMGE  D13, D20, #0.0
    FCMGT  S6, S18, #0.0
    FCMLE  V3.2S, V27.2S, #0.0
    FACGT  D12, D15, D1
    FCMGE  V5.2S, V4.2S, V17.2S
    CMGE  V4.2S, V2.2S, V13.2S
    FCMLT  S8, S25, #0.0
    CMEQ  V15.2D, V30.2D, V31.2D
    FCMGE  D22, D4, D9
    CMGE  D5, D22, #0
    CMEQ  V10.2S, V3.2S, V13.2S
    FCMLE  D28, D5, #0.0
    CMTST  D16, D1, D27
    CMLE  V13.4S, V27.4S, #0
    FCMGT  D22, D4, #0.0
    FCMLE  S17, S7, #0.0
    FCMGT  D4, D18, D15
    FCMEQ  D14, D30, #0.0
    FCMLE  D10, D1, #0.0
    CMTST  D22, D0, D25
    CMEQ  D11, D28, #0
    FACGT  D31, D13, D1
    FCMGT  V22.2S, V3.2S, #0.0
    FCMGT  D23, D27, D8
    FCMGE  D20, D2, D19
    CMGE  V28.8B, V25.8B, V31.8B
    CMGT  D22, D29, #0
    CMGT  V26.8B, V15.8B, #0
    FCMLE  V28.4S, V28.4S, #0.0
    FCMLE  D28, D22, #0.0
    FACGT  D23, D31, D21
    FCMLT  D9, D13, #0.0
    FCMLE  V17.2D, V25.2D, #0.0
    FCMGT  V10.2D, V2.2D, V3.2D
    FCMEQ  V17.2S, V8.2S, V19.2S
    FCMEQ  D18, D5, #0.0
    CMLE  D14, D18, #0
    CMEQ  V25.2S, V0.2S, #0
    FCMLT  V29.2S, V1.2S, #0.0
    FCMGE  D7, D8, #0.0
    CMTST  V1.4H, V15.4H, V4.4H
    FCMGT  S27, S11, S21
    FCMEQ  S14, S25, #0.0
    FCMEQ  D17, D28, D17
    FCMEQ  D23, D10, #0.0
    FCMLE  V30.4S, V10.4S, #0.0
    FCMEQ  D17, D1, #0.0
    CMEQ  D11, D2, D8
    CMEQ  D24, D8, #0
    FCMEQ  S27, S26, S14
    FCMGE  D15, D10, #0.0
    FCMGT  D6, D27, #0.0
    CMGT  D3, D6, D21
    FCMGE  D19, D27, #0.0
    CMEQ  V2.16B, V26.16B, #0
    CMGE  V10.2S, V21.2S, #0
    FCMGE  S8, S0, S2
    FCMLT  D13, D9, #0.0
    CMTST  V27.8H, V19.8H, V8.8H
    FACGT  V17.4S, V15.4S, V0.4S
    CMGE  V18.4H, V30.4H, V22.4H
    FCMGE  S23, S14, #0.0
    CMGT  D17, D15, D9
    FCMGE  V30.4S, V10.4S, #0.0
    FCMEQ  D21, D31, #0.0
    CMGT  D2, D7, D3
    CMGE  D30, D24, D24
    CMGE  D2, D24, #0
    FACGT  V25.2D, V11.2D, V4.2D
    FCMGT  V14.2D, V15.2D, #0.0
    FCMEQ  D21, D10, D19
    CMHS  V31.8B, V22.8B, V21.8B
    FCMEQ  D0, D6, D0
    CMGT  V10.4H, V21.4H, V26.4H
    FCMGT  S7, S18, S0
    FACGE  S5, S27, S26
    FCMLE  D0, D9, #0.0
    CMGE  V5.2S, V23.2S, V29.2S
    FCMEQ  D24, D12, D12
    FCMLE  S18, S3, #0.0
    CMGE  V26.4H, V6.4H, V7.4H
    FCMLT  V14.2D, V22.2D, #0.0
    FCMEQ  V28.4S, V4.4S, V4.4S
    FACGT  D17, D23, D22
    FCMLE  S13, S30, #0.0
    FCMGT  D8, D18, D27
    FCMEQ  S28, S31, S17
    FACGE  V12.4S, V20.4S, V12.4S
    FCMGE  S29, S23, S2
    FCMGE  S17, S24, #0.0
    FACGT  S3, S0, S29
    FCMEQ  D0, D6, #0.0
    CMGT  V25.4H, V24.4H, #0
    FCMEQ  S16, S13, #0.0
    FCMLE  D31, D11, #0.0
    FCMLT  S11, S31, #0.0
    FCMLE  S28, S2, #0.0
    CMHS  V15.4H, V29.4H, V22.4H
    FCMEQ  D22, D19, #0.0
    CMGE  V25.4H, V11.4H, V15.4H
    CMGE  V21.8B, V28.8B, V21.8B
    CMTST  V8.2D, V11.2D, V10.2D
    FACGT  V25.2D, V3.2D, V26.2D
    CMEQ  V29.8B, V17.8B, V17.8B
    FCMGT  D6, D29, D4
    CMEQ  V23.4S, V12.4S, V0.4S
    FACGE  D13, D2, D23
    FCMLE  D23, D10, #0.0
    FACGE  V29.2S, V1.2S, V10.2S
    CMGE  V24.16B, V10.16B, #0
    CMGT  V1.8B, V21.8B, #0
    FCMGT  D11, D10, #0.0
    FCMLT  V26.2S, V10.2S, #0.0
    FACGT  D29, D1, D26
    FCMEQ  S13, S15, S15
    FCMGE  V6.2S, V17.2S, V12.2S
    FCMLT  S31, S25, #0.0
    FCMGE  D12, D21, D30
    CMLE  V12.4H, V2.4H, #0
    CMGE  V11.4S, V1.4S, V12.4S
    CMGE  D17, D1, #0
    SUBS  X29, X29, #0x1
    B.NE  TaishanSimdPermuteP01_label_1117
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X27, X16, X2
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X14, X13, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X26, X25, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X18, X12, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X17, X3, X7
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X3, X5, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X25, X14, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X24, X9, X10
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X13, X18, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X25, X18, X12
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X28, X18, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X11, X18, X16
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X19, X28, X17
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X24, X8, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X17, X22, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X16, X4, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X7, X3, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X24
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X21, X29, X25
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X22, X9, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D2
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X2, X18, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D5
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X10, X13, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D8
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X14
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X22, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D10
    MOVZ  X5, #0x0, LSL #0
    SUB  X20, X5, X11
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X9, X4, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D11
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X9, X4, X19
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D12
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X28, X18, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D13
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X22, X26, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X22, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D16
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    SUB  X25, X3, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D17
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D18
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X21, X17, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D19
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X6, X11, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X23
TaishanSimdPermuteP01_label_1028:
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D21
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X19, X23, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X16, X19, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D23
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X16, X19, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D24
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X5, X25, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D25
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D26
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D28
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    SUB  X2, X9, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xc1cd, LSL #0
    MOVK  X2, #0x671, LSL #16
    MOVK  X2, #0x9fae, LSL #32
    MOVK  X2, #0x981c, LSL #48
    MOVZ  X3, #0xb509, LSL #0
    MOVK  X3, #0xf860, LSL #16
    MOVK  X3, #0x67d3, LSL #32
    MOVK  X3, #0x286, LSL #48
    MOVZ  X4, #0xc935, LSL #0
    MOVK  X4, #0xfeba, LSL #16
    MOVK  X4, #0x76e9, LSL #32
    MOVK  X4, #0x2305, LSL #48
    MOVZ  X5, #0xd880, LSL #0
    MOVK  X5, #0x4070, LSL #16
    MOVK  X5, #0x442f, LSL #32
    MOVK  X5, #0xf4a2, LSL #48
    MOVZ  X6, #0x7d8a, LSL #0
    MOVK  X6, #0x92ec, LSL #16
    MOVK  X6, #0x8244, LSL #32
    MOVK  X6, #0xc14, LSL #48
    MOVZ  X7, #0xd43d, LSL #0
    MOVK  X7, #0xb204, LSL #16
    MOVK  X7, #0x5337, LSL #32
    MOVK  X7, #0x84ca, LSL #48
    MOVZ  X8, #0xfa5b, LSL #0
    MOVK  X8, #0x4af2, LSL #16
    MOVK  X8, #0xb19c, LSL #32
    MOVK  X8, #0xa05b, LSL #48
    MOVZ  X9, #0xc042, LSL #0
    MOVK  X9, #0xdbc8, LSL #16
    MOVK  X9, #0x5066, LSL #32
    MOVK  X9, #0x7e25, LSL #48
    MOVZ  X10, #0x704e, LSL #0
    MOVK  X10, #0xd680, LSL #16
    MOVK  X10, #0x5115, LSL #32
    MOVK  X10, #0xf3bf, LSL #48
    MOVZ  X11, #0x376c, LSL #0
    MOVK  X11, #0xfa, LSL #16
    MOVK  X11, #0xa1c7, LSL #32
    MOVK  X11, #0x4cbd, LSL #48
    MOVZ  X12, #0x3b52, LSL #0
    MOVK  X12, #0x4745, LSL #16
    MOVK  X12, #0x4fed, LSL #32
    MOVK  X12, #0x5037, LSL #48
    MOVZ  X13, #0x4f50, LSL #0
    MOVK  X13, #0xba73, LSL #16
    MOVK  X13, #0x1da5, LSL #32
    MOVK  X13, #0x483d, LSL #48
    MOVZ  X14, #0xd54c, LSL #0
    MOVK  X14, #0xb807, LSL #16
    MOVK  X14, #0xf4a7, LSL #32
    MOVK  X14, #0xda83, LSL #48
    MOVZ  X16, #0x39f9, LSL #0
    MOVK  X16, #0xfa8b, LSL #16
    MOVK  X16, #0x266e, LSL #32
    MOVK  X16, #0xf947, LSL #48
    MOVZ  X17, #0x64e8, LSL #0
    MOVK  X17, #0x837b, LSL #16
    MOVK  X17, #0xcf2e, LSL #32
    MOVK  X17, #0xf2ff, LSL #48
    MOVZ  X18, #0x7644, LSL #0
    MOVK  X18, #0x67f4, LSL #16
    MOVK  X18, #0x1e0d, LSL #32
    MOVK  X18, #0x54d1, LSL #48
    MOVZ  X19, #0x19a7, LSL #0
    MOVK  X19, #0xe630, LSL #16
    MOVK  X19, #0xded7, LSL #32
    MOVK  X19, #0x3f2c, LSL #48
    MOVZ  X20, #0x42bd, LSL #0
    MOVK  X20, #0xbdc5, LSL #16
    MOVK  X20, #0xa840, LSL #32
    MOVK  X20, #0x8e74, LSL #48
    MOVZ  X21, #0x260f, LSL #0
    MOVK  X21, #0x4893, LSL #16
    MOVK  X21, #0x5fd0, LSL #32
    MOVK  X21, #0xc249, LSL #48
    MOVZ  X22, #0x1437, LSL #0
    MOVK  X22, #0xc258, LSL #16
    MOVK  X22, #0xa095, LSL #32
    MOVK  X22, #0xe444, LSL #48
    MOVZ  X23, #0x27f0, LSL #0
    MOVK  X23, #0x952a, LSL #16
    MOVK  X23, #0x54fb, LSL #32
    MOVK  X23, #0xc5d6, LSL #48
    MOVZ  X24, #0x2ef9, LSL #0
    MOVK  X24, #0x2053, LSL #16
    MOVK  X24, #0xb006, LSL #32
    MOVK  X24, #0x5ded, LSL #48
    MOVZ  X25, #0xf6ed, LSL #0
    MOVK  X25, #0xb0c, LSL #16
    MOVK  X25, #0x5acf, LSL #32
    MOVK  X25, #0x6421, LSL #48
    MOVZ  X26, #0x802e, LSL #0
    MOVK  X26, #0x69e9, LSL #16
    MOVK  X26, #0xe3d7, LSL #32
    MOVK  X26, #0x70a0, LSL #48
    MOVZ  X27, #0x6b69, LSL #0
    MOVK  X27, #0xb487, LSL #16
    MOVK  X27, #0xcf11, LSL #32
    MOVK  X27, #0x8e31, LSL #48
    MOVZ  X28, #0x8ff5, LSL #0
    MOVK  X28, #0x8206, LSL #16
    MOVK  X28, #0xc642, LSL #32
    MOVK  X28, #0xe4ff, LSL #48
    MOVZ  X29, #0x1717, LSL #0
    MOVK  X29, #0x5636, LSL #16
    MOVK  X29, #0x60d5, LSL #32
    MOVK  X29, #0xb0ae, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X5
    FMOV  D1, X24
    FMOV  V1.D[1], X21
    FMOV  D2, X6
    FMOV  V2.D[1], X24
    FMOV  D3, X28
    FMOV  V3.D[1], X26
    FMOV  D4, X24
    FMOV  V4.D[1], X4
    FMOV  D5, X11
    FMOV  V5.D[1], X29
    FMOV  D6, X13
    FMOV  V6.D[1], X11
    FMOV  D7, X7
    FMOV  V7.D[1], X13
    FMOV  D8, X22
    FMOV  V8.D[1], X17
    FMOV  D9, X4
    FMOV  V9.D[1], X23
    FMOV  D10, X22
    FMOV  V10.D[1], X21
    FMOV  D11, X6
    FMOV  V11.D[1], X27
    FMOV  D12, X24
TaishanSimdPermuteP01_label_831:
    FMOV  V12.D[1], X17
    FMOV  D13, X14
    FMOV  V13.D[1], X5
    FMOV  D14, X23
    FMOV  V14.D[1], X25
    FMOV  D15, X18
    FMOV  V15.D[1], X5
    FMOV  D16, X25
    FMOV  V16.D[1], X23
    FMOV  D17, X26
    FMOV  V17.D[1], X19
    FMOV  D18, X4
    FMOV  V18.D[1], X9
    FMOV  D19, X20
    FMOV  V19.D[1], X18
    FMOV  D20, X18
    FMOV  V20.D[1], X25
    FMOV  D21, X16
    FMOV  V21.D[1], X23
    FMOV  D22, X29
    FMOV  V22.D[1], X24
    FMOV  D23, X29
    FMOV  V23.D[1], X5
    FMOV  D24, X5
    FMOV  V24.D[1], X19
    FMOV  D25, X8
    FMOV  V25.D[1], X6
    FMOV  D26, X18
    FMOV  V26.D[1], X17
    FMOV  D27, X26
    FMOV  V27.D[1], X5
    FMOV  D28, X23
    FMOV  V28.D[1], X26
    FMOV  D29, X27
    FMOV  V29.D[1], X18
    FMOV  D30, X11
    FMOV  V30.D[1], X18
    FMOV  D31, X28
    FMOV  V31.D[1], X19
    MOVZ  X16, #0xa, LSL #0
TaishanSimdPermuteP01_label_1195:
    FCMLT  D29, D22, #0.0
    FCMLT  V18.2D, V31.2D, #0.0
    FCMEQ  S30, S30, S30
    FCMEQ  V22.2S, V19.2S, V9.2S
    FCMGE  D19, D19, #0.0
    CMLE  V9.4H, V6.4H, #0
    FACGT  D7, D20, D24
    CMEQ  V28.4S, V16.4S, V9.4S
    CMTST  V27.8B, V19.8B, V5.8B
    CMLT  D25, D10, #0
    FCMGT  V6.2D, V16.2D, #0.0
    FCMEQ  D2, D20, #0.0
    CMHI  V22.4S, V26.4S, V2.4S
    FCMGT  V28.2D, V6.2D, V2.2D
    CMGE  V18.8H, V27.8H, V9.8H
    FCMGE  S16, S13, #0.0
    CMHS  V12.8B, V7.8B, V22.8B
    CMGT  D27, D10, D22
    CMGT  D11, D11, D30
    CMLE  V13.16B, V17.16B, #0
    CMGE  V29.4H, V1.4H, #0
    FCMLE  V5.2D, V29.2D, #0.0
    CMEQ  D1, D17, #0
    FCMLE  V12.2D, V27.2D, #0.0
    FCMGT  V25.4S, V5.4S, #0.0
    CMGE  V1.16B, V26.16B, V27.16B
    CMGE  V9.16B, V25.16B, #0
    FCMLE  S2, S10, #0.0
    FCMGT  S27, S15, #0.0
    FCMGE  S16, S7, S22
    FCMLT  S13, S16, #0.0
    CMHS  V3.2S, V7.2S, V19.2S
    CMHS  D27, D24, D11
    FACGT  S5, S13, S22
    FCMGE  V18.2S, V17.2S, V30.2S
    FCMGE  V31.2S, V15.2S, V28.2S
    FCMGE  V16.4S, V26.4S, V19.4S
    FACGE  D6, D20, D0
    FCMGE  V6.2D, V16.2D, V30.2D
    FACGE  S28, S11, S9
    FCMLT  D28, D9, #0.0
    CMLE  V12.16B, V25.16B, #0
    FACGT  S26, S24, S28
    CMGE  D6, D15, D9
    FCMEQ  V28.4S, V18.4S, V30.4S
    CMLE  D12, D16, #0
    CMLT  V18.4S, V5.4S, #0
    FCMLE  D16, D26, #0.0
    FCMEQ  D2, D26, D20
    CMGT  D8, D29, D19
    CMGE  V31.16B, V16.16B, V18.16B
    FCMLE  D14, D0, #0.0
    FACGE  V10.2D, V6.2D, V12.2D
    FCMGE  V0.4S, V28.4S, #0.0
    FACGT  D30, D19, D24
    FCMLE  S28, S25, #0.0
    CMEQ  D9, D12, #0
    CMGE  D21, D30, D8
    FACGT  S22, S20, S6
    CMLT  D7, D4, #0
    FCMLT  S29, S19, #0.0
    CMGT  D22, D25, D26
    CMEQ  D18, D15, D7
    CMHI  V17.2D, V27.2D, V14.2D
    FACGE  V17.4S, V29.4S, V15.4S
    CMHI  V31.2D, V10.2D, V13.2D
    CMLE  V22.2S, V30.2S, #0
    FCMGT  D13, D3, D10
    CMHS  V18.8H, V25.8H, V20.8H
    CMLT  D27, D13, #0
    FCMEQ  S20, S23, #0.0
    CMLE  D17, D16, #0
    FCMGT  V29.2D, V9.2D, V16.2D
    CMHI  V31.8B, V12.8B, V13.8B
    CMLT  V28.4S, V29.4S, #0
    FCMLE  V5.4S, V30.4S, #0.0
    CMEQ  D20, D27, #0
    CMTST  D2, D24, D4
    CMHI  D23, D7, D28
    FCMGE  D15, D25, D24
    FCMEQ  D15, D25, #0.0
    FCMEQ  V13.4S, V16.4S, V15.4S
    CMGT  V3.16B, V12.16B, V23.16B
    CMGT  D4, D11, #0
    CMGE  V1.2S, V11.2S, V25.2S
    CMEQ  D15, D14, #0
    FCMGT  V4.2S, V29.2S, V26.2S
    CMLT  D24, D25, #0
    CMGE  V19.2S, V17.2S, V10.2S
    FCMGT  D20, D8, D9
    FACGT  S26, S6, S18
    CMLE  D5, D27, #0
    CMEQ  V18.2S, V23.2S, #0
    FCMLT  D26, D18, #0.0
    FCMLT  S13, S14, #0.0
    CMEQ  V22.8B, V6.8B, #0
    FACGT  D18, D21, D31
    FCMGT  S22, S27, S2
    FCMEQ  D6, D5, #0.0
    FACGT  S9, S28, S3
    FCMGT  D14, D31, D31
    FACGE  V14.2D, V0.2D, V6.2D
    CMHI  D0, D20, D7
    FCMLE  S14, S17, #0.0
    FCMGT  V10.2D, V13.2D, #0.0
    FCMLT  D17, D13, #0.0
    FCMGE  D25, D19, #0.0
    FCMLE  V12.4S, V28.4S, #0.0
    FACGT  D5, D10, D22
    FACGT  D20, D21, D23
    CMGE  D27, D0, D8
    FCMGE  V8.4S, V4.4S, #0.0
    FACGE  V30.2S, V29.2S, V12.2S
    CMGT  V23.8H, V18.8H, #0
    FCMEQ  V14.2D, V13.2D, #0.0
    CMTST  D21, D8, D9
    CMEQ  D21, D14, #0
    FACGT  V9.2S, V11.2S, V24.2S
    CMGT  V9.8H, V6.8H, V7.8H
    FACGE  S19, S21, S23
    FCMEQ  S7, S4, S30
    FACGE  D17, D17, D31
    FCMLT  S23, S31, #0.0
    CMGE  D8, D13, #0
    CMEQ  V17.16B, V22.16B, V8.16B
    CMEQ  D18, D3, #0
    FACGT  V13.2D, V9.2D, V9.2D
    CMEQ  D21, D12, D2
    CMTST  D18, D27, D31
    FCMGE  S31, S1, #0.0
    CMGT  V9.16B, V0.16B, #0
    FCMLE  V8.2S, V24.2S, #0.0
    CMHI  D22, D25, D20
    FACGE  D13, D21, D31
    FCMLT  S24, S19, #0.0
    CMTST  V21.2D, V23.2D, V20.2D
    FACGT  D18, D28, D31
    CMGE  D27, D12, D31
    CMEQ  D24, D29, #0
    CMLE  V30.8H, V24.8H, #0
    FCMGT  V2.2S, V20.2S, #0.0
    FCMGE  V20.4S, V2.4S, V0.4S
    CMGE  D21, D17, #0
    CMEQ  V29.8B, V24.8B, #0
    CMHS  V22.4H, V20.4H, V3.4H
    FCMEQ  V29.4S, V21.4S, #0.0
    CMEQ  V28.2D, V30.2D, V5.2D
    CMEQ  D8, D22, #0
    CMHI  V28.2D, V19.2D, V24.2D
    CMGE  V31.8H, V13.8H, V18.8H
    CMGT  D8, D13, #0
    FACGT  S21, S12, S3
    CMEQ  D15, D1, #0
    CMGE  D4, D13, #0
    CMTST  D15, D21, D23
    FCMGT  S29, S2, S17
    FCMGT  D30, D20, #0.0
    FCMGT  V8.2D, V28.2D, V5.2D
    CMHS  V3.4S, V31.4S, V0.4S
    CMGT  V12.4H, V18.4H, V20.4H
    FCMEQ  V24.2D, V5.2D, V22.2D
    CMGT  V15.4S, V20.4S, V24.4S
    FCMEQ  D23, D28, D23
    FCMGE  V5.2D, V12.2D, #0.0
    FCMGT  V29.2S, V18.2S, #0.0
    CMGE  V9.2S, V28.2S, #0
    FACGE  V6.2S, V31.2S, V15.2S
    FCMGT  S30, S7, S12
    CMLT  V4.16B, V7.16B, #0
    CMHI  V3.8H, V19.8H, V22.8H
    FCMGT  S14, S16, S26
    CMGE  D4, D22, D23
    FCMGE  D26, D18, D7
    CMGT  D24, D18, #0
    CMGE  V30.16B, V24.16B, V31.16B
    FCMGE  S2, S3, #0.0
    FCMLE  S29, S12, #0.0
    FCMGE  D25, D3, D16
    CMTST  D20, D15, D18
    CMEQ  D15, D6, D11
    CMEQ  D29, D13, #0
    FCMGE  V3.2S, V28.2S, V18.2S
    CMGE  D14, D4, D14
    CMLT  D7, D20, #0
    CMGT  D30, D24, #0
    FCMGT  S29, S11, #0.0
    CMGE  D30, D6, #0
    FCMGT  D18, D29, D30
    CMTST  D20, D4, D19
    CMHI  V16.2S, V21.2S, V7.2S
    CMGE  D9, D16, #0
    FCMGE  V29.4S, V3.4S, V4.4S
    CMGT  D7, D30, D4
    CMGE  D6, D0, D16
    FCMLT  V18.4S, V25.4S, #0.0
    FCMGE  D30, D20, D15
    CMHS  D6, D2, D3
    FCMGT  S5, S5, S0
    FCMLE  D4, D2, #0.0
    CMHI  D8, D23, D14
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdPermuteP01_label_1195
    MOVZ  X6, #0xc1cd, LSL #0
    MOVK  X6, #0x671, LSL #16
    MOVK  X6, #0x9fae, LSL #32
    MOVK  X6, #0x981c, LSL #48
    SUB  X19, X6, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0xb509, LSL #0
    MOVK  X4, #0xf860, LSL #16
    MOVK  X4, #0x67d3, LSL #32
    MOVK  X4, #0x286, LSL #48
    SUB  X8, X4, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0xb509, LSL #0
    MOVK  X17, #0xf860, LSL #16
    MOVK  X17, #0x67d3, LSL #32
    MOVK  X17, #0x286, LSL #48
    SUB  X13, X17, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0xd880, LSL #0
    MOVK  X12, #0x4070, LSL #16
    MOVK  X12, #0x442f, LSL #32
    MOVK  X12, #0xf4a2, LSL #48
    SUB  X10, X12, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0xc1cd, LSL #0
    MOVK  X8, #0x671, LSL #16
    MOVK  X8, #0x9fae, LSL #32
    MOVK  X8, #0x981c, LSL #48
    SUB  X25, X8, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xd43d, LSL #0
    MOVK  X9, #0xb204, LSL #16
    MOVK  X9, #0x5337, LSL #32
    MOVK  X9, #0x84ca, LSL #48
    SUB  X14, X9, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0xc1cd, LSL #0
    MOVK  X8, #0x671, LSL #16
    MOVK  X8, #0x9fae, LSL #32
    MOVK  X8, #0x981c, LSL #48
    SUB  X16, X8, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xd43d, LSL #0
    MOVK  X18, #0xb204, LSL #16
    MOVK  X18, #0x5337, LSL #32
    MOVK  X18, #0x84ca, LSL #48
    SUB  X29, X18, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0xd880, LSL #0
    MOVK  X25, #0x4070, LSL #16
    MOVK  X25, #0x442f, LSL #32
    MOVK  X25, #0xf4a2, LSL #48
    SUB  X20, X25, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X13
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xb509, LSL #0
    MOVK  X9, #0xf860, LSL #16
    MOVK  X9, #0x67d3, LSL #32
    MOVK  X9, #0x286, LSL #48
    SUB  X23, X9, X17
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0xd43d, LSL #0
    MOVK  X25, #0xb204, LSL #16
    MOVK  X25, #0x5337, LSL #32
    MOVK  X25, #0x84ca, LSL #48
    SUB  X20, X25, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X28, X3, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X20
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X22
TaishanSimdPermuteP01_label_1201:
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0xd43d, LSL #0
    MOVK  X7, #0xb204, LSL #16
    MOVK  X7, #0x5337, LSL #32
    MOVK  X7, #0x84ca, LSL #48
    SUB  X18, X7, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x6b69, LSL #0
    MOVK  X25, #0xb487, LSL #16
    MOVK  X25, #0xcf11, LSL #32
    MOVK  X25, #0x8e31, LSL #48
    SUB  X10, X25, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D2
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X26, X6, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X2, X9, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D3
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X2, X9, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D4
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X11, X2, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D6
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D7
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X25, X19, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D8
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X12, X17, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D9
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X28, X6, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D12
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X6, X7, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D13
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
TaishanSimdPermuteP01_label_997:
    MOVK  X4, #0xffff, LSL #48
    SUB  X24, X4, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D16
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X12
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X20, X18, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X20, X18, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D18
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D19
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    SUB  X6, X24, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D20
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X12, X3, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D21
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D22
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X16, X18, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D23
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X22, X7, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D24
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D26
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X21, X22, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D28
    MOVZ  X26, #0x0, LSL #0
    SUB  X18, X26, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X5, X16, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D29
    MOVZ  X16, #0x0, LSL #0
    SUB  X5, X16, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X12
    FMOV  D1, X14
    FMOV  V1.D[1], X25
    FMOV  D2, X19
    FMOV  V2.D[1], X9
    FMOV  D3, X2
    FMOV  V3.D[1], X8
    FMOV  D4, X25
    FMOV  V4.D[1], X10
    FMOV  D5, X29
    FMOV  V5.D[1], X22
    FMOV  D6, X8
    FMOV  V6.D[1], X19
    FMOV  D7, X22
    FMOV  V7.D[1], X26
    FMOV  D8, X18
    FMOV  V8.D[1], X29
    FMOV  D9, X13
    FMOV  V9.D[1], X4
    FMOV  D10, X22
    FMOV  V10.D[1], X8
    FMOV  D11, X19
    FMOV  V11.D[1], X10
    FMOV  D12, X26
    FMOV  V12.D[1], X19
    FMOV  D13, X17
    FMOV  V13.D[1], X16
    FMOV  D14, X21
    FMOV  V14.D[1], X19
    FMOV  D15, X14
    FMOV  V15.D[1], X26
    FMOV  D16, X14
    FMOV  V16.D[1], X11
    FMOV  D17, X14
    FMOV  V17.D[1], X2
    FMOV  D18, X9
TaishanSimdPermuteP01_label_387:
    FMOV  V18.D[1], X10
    FMOV  D19, X13
    FMOV  V19.D[1], X5
    FMOV  D20, X22
    FMOV  V20.D[1], X29
    FMOV  D21, X14
    FMOV  V21.D[1], X22
    FMOV  D22, X9
    FMOV  V22.D[1], X16
    FMOV  D23, X23
    FMOV  V23.D[1], X21
    FMOV  D24, X5
    FMOV  V24.D[1], X6
    FMOV  D25, X2
    FMOV  V25.D[1], X19
    FMOV  D26, X2
    FMOV  V26.D[1], X18
    FMOV  D27, X5
    FMOV  V27.D[1], X10
    FMOV  D28, X16
    FMOV  V28.D[1], X25
    FMOV  D29, X5
    FMOV  V29.D[1], X21
    FMOV  D30, X8
    FMOV  V30.D[1], X24
    FMOV  D31, X25
    FMOV  V31.D[1], X25
    MOVZ  X9, #0xa, LSL #0
TaishanSimdPermuteP01_label_1269:
    CMLT  V18.8H, V28.8H, #0
    CMEQ  V19.16B, V12.16B, V21.16B
    CMGE  D0, D23, #0
    CMGE  D7, D27, D28
    CMLE  V0.2S, V12.2S, #0
    CMLE  V12.2S, V12.2S, #0
    CMGE  D12, D9, D7
    CMGT  V24.4H, V9.4H, #0
    CMGE  D21, D31, D12
    CMEQ  V11.8B, V14.8B, #0
    FCMLE  V28.2S, V27.2S, #0.0
    CMGT  D13, D12, D18
    FCMEQ  S17, S4, S25
    CMGT  D2, D7, #0
    FCMLT  S30, S2, #0.0
    FCMGT  D25, D26, D15
    FCMEQ  S11, S28, #0.0
    FCMGT  S25, S7, S28
    FCMLT  V9.2S, V31.2S, #0.0
    CMTST  D18, D29, D2
    FCMEQ  D14, D12, D14
    CMLE  V29.2S, V30.2S, #0
    CMHS  V6.2D, V21.2D, V9.2D
    FCMLE  S28, S31, #0.0
    CMHS  D14, D5, D11
    FCMGE  S24, S25, #0.0
    FCMEQ  D19, D18, #0.0
    CMEQ  D18, D26, #0
    FCMEQ  V13.2D, V14.2D, #0.0
    FCMLT  S13, S14, #0.0
    FCMEQ  V12.2S, V8.2S, V10.2S
    CMTST  D13, D29, D4
    CMEQ  V13.2D, V11.2D, V14.2D
    CMHS  D14, D30, D2
    CMHI  D21, D12, D29
    FCMLE  D13, D5, #0.0
    CMEQ  D5, D12, #0
    CMEQ  V4.2D, V30.2D, V26.2D
    FCMLT  V13.2S, V12.2S, #0.0
    FCMEQ  S11, S6, S10
    FACGT  V18.2S, V2.2S, V31.2S
    CMGE  V13.2D, V23.2D, V20.2D
    CMEQ  V6.8B, V26.8B, V17.8B
    CMGT  D11, D0, #0
    CMEQ  D26, D11, #0
    FCMGE  D16, D6, #0.0
    FCMLT  S4, S8, #0.0
    CMLT  D27, D14, #0
    CMHS  V21.4S, V5.4S, V19.4S
    FCMGE  S2, S25, #0.0
    CMLT  V0.2S, V21.2S, #0
    CMTST  V5.2D, V25.2D, V29.2D
    FCMLT  S21, S0, #0.0
    FCMGT  S1, S27, S24
    CMEQ  D21, D11, D24
    CMGE  V4.4S, V6.4S, #0
    FCMGE  V19.4S, V26.4S, V16.4S
    FCMGE  V17.4S, V13.4S, #0.0
    CMLE  D24, D14, #0
    FCMEQ  D10, D18, #0.0
    CMTST  D2, D17, D2
    CMGT  D18, D14, D0
    CMLT  D8, D22, #0
    FCMEQ  S3, S4, #0.0
    CMHS  D20, D24, D12
    CMGT  D18, D29, D21
    CMGE  D5, D22, #0
    CMEQ  V1.4H, V28.4H, #0
    CMTST  V22.2D, V0.2D, V12.2D
    FCMEQ  S11, S4, #0.0
    CMGE  V25.4S, V18.4S, V17.4S
    FCMGE  V5.2S, V28.2S, #0.0
    FCMEQ  D22, D22, #0.0
    FCMGE  S29, S11, S15
    FCMGE  S29, S20, S27
    FACGE  S24, S0, S1
    FCMGE  S15, S17, S25
    FCMGE  S25, S6, S21
    CMTST  D1, D15, D31
    FACGE  V8.2D, V20.2D, V23.2D
    CMHI  V1.8H, V3.8H, V31.8H
    CMGE  V28.16B, V29.16B, #0
    FCMLT  S29, S10, #0.0
    CMGE  D24, D23, D12
    FCMGE  S17, S10, #0.0
    CMGE  V23.8B, V31.8B, V7.8B
    CMTST  D23, D28, D8
    FCMGE  S22, S6, S16
    CMLT  D25, D5, #0
    FCMGE  S10, S24, S6
    FCMLT  S7, S11, #0.0
    FCMGE  V5.2S, V12.2S, #0.0
    FACGE  S24, S6, S22
    FCMEQ  D5, D3, D27
    FCMGT  D25, D21, D25
    FCMEQ  S8, S5, #0.0
    CMTST  V24.8H, V6.8H, V15.8H
    FACGE  D13, D11, D12
    CMHS  D12, D24, D29
    FCMEQ  S17, S24, S17
    CMGT  D29, D27, #0
    CMHI  D20, D14, D28
    CMLT  D1, D23, #0
    CMTST  D4, D10, D3
    FCMGE  S24, S13, S20
    CMEQ  D19, D29, #0
    FACGT  S23, S20, S17
    CMEQ  V13.8B, V14.8B, #0
    CMGE  D11, D10, D20
    CMGT  D20, D29, #0
    CMLE  D28, D12, #0
    CMLT  D4, D5, #0
    CMGE  D4, D15, #0
    FCMGT  D30, D24, D23
    CMLE  V6.8H, V13.8H, #0
    CMGT  V2.2D, V17.2D, #0
    FCMGE  D16, D4, #0.0
    FCMEQ  D20, D30, D24
    CMGE  V6.4S, V8.4S, V1.4S
    FCMGT  S4, S2, S28
    CMHS  V25.4S, V19.4S, V22.4S
    CMGE  D14, D29, #0
    CMGE  D30, D22, #0
    CMGT  D17, D5, D19
    FCMGE  S16, S2, #0.0
    CMEQ  D16, D15, D2
    CMEQ  D6, D7, #0
    CMLE  V17.8H, V16.8H, #0
    FCMGE  V4.2S, V2.2S, #0.0
    FCMLT  V24.4S, V6.4S, #0.0
    CMHI  D14, D0, D7
    FCMLT  V30.2D, V2.2D, #0.0
    FCMGE  D25, D7, #0.0
    CMGE  V30.4H, V6.4H, #0
    CMGE  D22, D30, #0
    FCMGT  D11, D3, D23
    FACGE  D10, D26, D27
    FCMGE  S8, S5, S25
    FCMGT  D23, D4, #0.0
    CMHS  D10, D2, D2
    CMGT  V20.16B, V14.16B, V22.16B
    CMTST  D23, D1, D26
    FCMEQ  V4.4S, V22.4S, #0.0
    CMLE  V5.2D, V20.2D, #0
    FCMEQ  S4, S23, #0.0
    FCMLT  V16.2S, V10.2S, #0.0
    FACGE  V20.2D, V25.2D, V11.2D
    CMHS  D27, D6, D8
    CMLT  D24, D2, #0
    FCMGT  D16, D29, #0.0
    FCMEQ  D29, D5, D26
    CMGE  V29.8B, V10.8B, #0
    CMHS  D28, D28, D2
    FCMEQ  D22, D6, #0.0
    FCMGE  S29, S10, #0.0
    FCMGE  V2.2D, V19.2D, #0.0
    CMEQ  D29, D25, D30
    FCMGT  V16.2D, V29.2D, #0.0
    FCMGE  S4, S29, #0.0
    CMLT  D25, D21, #0
    FACGT  V7.2D, V5.2D, V22.2D
    FACGE  V11.4S, V1.4S, V13.4S
    FACGE  S18, S28, S3
    CMHI  D25, D22, D0
    CMHI  D1, D27, D19
    FCMEQ  D27, D9, #0.0
TaishanSimdPermuteP01_label_1121:
    CMTST  V0.2D, V16.2D, V15.2D
    CMEQ  D24, D3, D4
    CMEQ  V17.2D, V7.2D, #0
    FCMGE  V25.2S, V2.2S, V2.2S
    CMHI  V23.2D, V22.2D, V19.2D
    FCMGE  V31.2D, V2.2D, #0.0
    FCMGE  D14, D21, D16
    FCMGT  S25, S21, #0.0
    CMHI  V25.4H, V13.4H, V15.4H
    FCMLE  V16.2D, V27.2D, #0.0
    FCMGE  D10, D24, D12
    CMHI  V17.4S, V27.4S, V11.4S
    FACGE  S30, S5, S17
    FACGT  D25, D0, D31
    CMHI  D12, D31, D20
    FCMGT  D8, D10, #0.0
    FCMGE  V14.4S, V27.4S, #0.0
    CMEQ  V17.4S, V10.4S, #0
    CMLT  D10, D6, #0
    FCMLT  D0, D13, #0.0
    FCMGT  S8, S12, #0.0
    FCMGE  S3, S16, #0.0
    CMGE  V4.16B, V25.16B, #0
    CMHS  V30.4H, V9.4H, V11.4H
    FCMGT  S25, S8, S1
    CMLE  V19.4S, V27.4S, #0
    CMTST  D14, D11, D2
    FACGE  V22.2D, V16.2D, V15.2D
    FCMGE  V29.2D, V5.2D, V29.2D
    FCMGE  V23.4S, V28.4S, #0.0
    CMGT  V7.2D, V31.2D, #0
    FCMLE  S15, S30, #0.0
    CMTST  D15, D23, D12
    FACGE  S14, S3, S30
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdPermuteP01_label_1269
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X6
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X7, X27, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X23, X8, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X19, X8, X19
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X25, X19, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X26, X6, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X28, X29, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X3, X28, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X29, X13, X28
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X7, X11, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D2
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X4, X17, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D3
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    SUB  X4, X17, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X23, X20, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D4
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X23, X20, X12
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X4, X12, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D5
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X4, X12, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D6
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X18, X14, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X14, X16, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D9
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D10
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X6, X29, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X28, X18, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D11
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X28, X18, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X25, X8, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D12
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X25, X8, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X7, X19, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X9
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X21, X13, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V17.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X25, X2, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D17
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X25, X2, X19
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D18
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X6, X7, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D19
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X6, X7, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X10, X3, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D20
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D21
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D22
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X26, X5, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X13, X27, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D23
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D26
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X14, X7, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D27
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X14, X3, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D28
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
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
TaishanSimdPermuteP01_label_726:
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
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
TaishanSimdPermuteP01_label_517:
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
TaishanSimdPermuteP01_label_320:
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
TaishanSimdPermuteP01_label_266:
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
    FMOV  V0.D[1], X19
    FMOV  D1, X14
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X13
    FMOV  D3, X25
    FMOV  V3.D[1], X27
    FMOV  D4, X24
    FMOV  V4.D[1], X28
    FMOV  D5, X17
    FMOV  V5.D[1], X18
    FMOV  D6, X12
    FMOV  V6.D[1], X2
    FMOV  D7, X7
    FMOV  V7.D[1], X24
    FMOV  D8, X7
    FMOV  V8.D[1], X20
    FMOV  D9, X14
    FMOV  V9.D[1], X8
    FMOV  D10, X18
    FMOV  V10.D[1], X24
    FMOV  D11, X23
    FMOV  V11.D[1], X14
    FMOV  D12, X18
    FMOV  V12.D[1], X10
    FMOV  D13, X8
    FMOV  V13.D[1], X21
    FMOV  D14, X10
    FMOV  V14.D[1], X21
    FMOV  D15, X7
    FMOV  V15.D[1], X23
    FMOV  D16, X23
    FMOV  V16.D[1], X18
    FMOV  D17, X17
    FMOV  V17.D[1], X12
    FMOV  D18, X12
    FMOV  V18.D[1], X23
    FMOV  D19, X26
    FMOV  V19.D[1], X12
    FMOV  D20, X4
    FMOV  V20.D[1], X14
    FMOV  D21, X20
    FMOV  V21.D[1], X16
    FMOV  D22, X10
    FMOV  V22.D[1], X12
    FMOV  D23, X9
    FMOV  V23.D[1], X14
    FMOV  D24, X17
    FMOV  V24.D[1], X27
    FMOV  D25, X20
    FMOV  V25.D[1], X9
    FMOV  D26, X6
    FMOV  V26.D[1], X24
    FMOV  D27, X20
    FMOV  V27.D[1], X26
    FMOV  D28, X21
    FMOV  V28.D[1], X14
    FMOV  D29, X9
    FMOV  V29.D[1], X13
    FMOV  D30, X13
    FMOV  V30.D[1], X29
    FMOV  D31, X12
    FMOV  V31.D[1], X8
    MOVZ  X2, #0xf, LSL #0
TaishanSimdPermuteP01_label_1346:
    FCMGE  V21.4S, V25.4S, V23.4S
    FCMGE  S29, S10, #0.0
    CMHI  V12.4S, V10.4S, V29.4S
    CMGE  D4, D0, D1
    FCMEQ  D5, D21, #0.0
    CMHS  V27.2D, V22.2D, V24.2D
    FCMGT  S27, S21, #0.0
    CMGT  V20.8H, V18.8H, V18.8H
    CMLE  D12, D0, #0
    FACGE  D22, D26, D16
    CMEQ  D15, D25, #0
    CMEQ  D11, D2, #0
    FCMLT  D26, D8, #0.0
    CMEQ  V19.2S, V23.2S, V25.2S
    CMGE  V12.2D, V5.2D, #0
    CMLT  V12.16B, V7.16B, #0
    FACGT  V17.2S, V3.2S, V27.2S
    CMEQ  D8, D22, D23
    CMEQ  D10, D19, #0
    CMGE  V19.2S, V8.2S, V8.2S
    CMHS  D12, D16, D10
    CMLE  D5, D14, #0
    FACGT  S4, S14, S20
    FCMGT  D7, D2, #0.0
    FCMEQ  V27.2D, V14.2D, V7.2D
    FCMGT  S18, S5, #0.0
    FACGE  V26.2D, V18.2D, V9.2D
    FCMGE  V30.2S, V18.2S, V10.2S
    FCMEQ  V9.2D, V0.2D, V31.2D
    CMGT  D21, D3, D19
    FCMLE  D25, D23, #0.0
    FCMGT  V1.2S, V29.2S, V30.2S
    FCMGT  V20.4S, V14.4S, V17.4S
    CMHS  V14.8H, V14.8H, V26.8H
    FCMGT  S3, S14, #0.0
    FCMGE  S9, S3, S15
    CMGE  V10.4S, V12.4S, V21.4S
    FCMLT  V20.2S, V24.2S, #0.0
    FACGT  S30, S25, S19
    FCMGT  V28.4S, V28.4S, #0.0
    CMGE  V28.2S, V11.2S, #0
    CMGT  V25.4S, V22.4S, #0
    FCMGE  S23, S9, S31
    FCMGE  V21.2D, V5.2D, V4.2D
    FCMEQ  S7, S6, #0.0
    CMGE  D13, D11, D29
    FCMGT  D22, D25, #0.0
    CMTST  V9.8H, V25.8H, V15.8H
    FCMEQ  S0, S3, #0.0
    FACGE  V16.2D, V29.2D, V10.2D
    CMEQ  D17, D3, D30
    CMHI  V12.2D, V24.2D, V25.2D
    FCMLE  D12, D5, #0.0
    FCMEQ  V8.2S, V3.2S, #0.0
    FCMGE  S15, S17, #0.0
    FCMGT  V11.2D, V2.2D, #0.0
    CMGT  V11.8H, V12.8H, #0
    CMHI  V15.8B, V30.8B, V27.8B
    FACGE  D25, D16, D10
    FCMGT  V2.4S, V1.4S, V14.4S
    FCMGE  D25, D6, #0.0
    FCMEQ  S2, S3, S11
    FACGT  D21, D18, D18
    FCMEQ  S25, S21, S4
    FCMEQ  D4, D10, #0.0
    FCMGE  S15, S26, S14
    CMEQ  D8, D16, D25
    FCMGE  D8, D11, D26
    CMHI  D15, D21, D0
    CMGT  D23, D22, D21
    CMGE  D4, D17, #0
    CMHS  D10, D2, D4
    CMGT  V11.4H, V10.4H, V1.4H
    CMTST  D15, D3, D11
    FCMGT  S15, S30, S6
    CMTST  V15.8B, V14.8B, V16.8B
    FCMGT  V27.4S, V15.4S, #0.0
    CMHS  V18.2D, V8.2D, V0.2D
    CMGE  D2, D7, #0
    FCMLT  D14, D16, #0.0
    FCMEQ  V23.4S, V1.4S, V17.4S
    CMLE  V5.4S, V16.4S, #0
    FCMGE  D21, D5, #0.0
    FCMGE  V13.4S, V26.4S, #0.0
    CMEQ  D4, D10, #0
    FCMGT  S6, S15, S7
    CMGE  V19.4S, V13.4S, #0
    FCMLE  S21, S10, #0.0
    FCMGT  V11.2S, V14.2S, V12.2S
    FCMGE  D25, D29, #0.0
    FACGT  S17, S10, S25
    FACGT  V23.2D, V18.2D, V18.2D
    CMEQ  V22.8B, V4.8B, #0
    FCMGE  V19.4S, V26.4S, V18.4S
    FCMLE  V29.2S, V24.2S, #0.0
    CMGE  V31.4H, V18.4H, V29.4H
    FCMEQ  V3.2S, V18.2S, V2.2S
    CMLT  D19, D31, #0
    FACGE  S14, S16, S4
    FCMLT  S8, S8, #0.0
    FACGT  V26.4S, V20.4S, V26.4S
    FCMGE  D23, D5, D1
    CMHI  V3.16B, V8.16B, V29.16B
    FCMGE  V29.2D, V24.2D, #0.0
    FACGT  V31.2S, V27.2S, V22.2S
    FCMEQ  S6, S4, #0.0
    FCMEQ  V3.2D, V31.2D, V25.2D
    FCMLT  D4, D18, #0.0
    FCMEQ  D17, D6, #0.0
    CMHS  D28, D30, D10
    CMGE  V31.2D, V17.2D, #0
    CMHI  D26, D12, D10
    FCMEQ  D6, D14, #0.0
    FACGT  V20.2D, V29.2D, V19.2D
    FCMEQ  D25, D18, #0.0
    FCMGE  S4, S12, #0.0
    CMEQ  V5.4S, V28.4S, #0
    CMHI  D28, D20, D23
    CMGT  V28.2S, V6.2S, #0
    FCMGE  V2.2D, V21.2D, #0.0
    CMGT  D30, D22, #0
    CMHI  V15.4H, V26.4H, V17.4H
    CMGT  D31, D17, #0
    FCMLE  D0, D31, #0.0
    FCMLT  D27, D18, #0.0
    FCMEQ  S23, S14, #0.0
    CMEQ  V9.16B, V26.16B, V30.16B
    FCMLE  S3, S4, #0.0
    FCMEQ  S18, S9, #0.0
    CMEQ  V22.8B, V18.8B, V6.8B
    FCMGE  S10, S27, S29
    CMEQ  D27, D1, #0
    CMEQ  D0, D30, #0
    FCMGE  S1, S6, #0.0
    FACGE  S22, S8, S28
    CMLE  D2, D29, #0
    CMEQ  V22.4S, V9.4S, V1.4S
    FCMLT  V27.2S, V15.2S, #0.0
    FCMGT  S15, S17, S2
    CMLT  D21, D2, #0
    FCMLT  V10.2S, V22.2S, #0.0
    FACGE  S6, S22, S11
    CMHI  V31.2S, V31.2S, V28.2S
    CMLT  D10, D3, #0
    FCMEQ  S20, S22, #0.0
    CMHI  V14.4H, V0.4H, V22.4H
    CMEQ  D31, D2, #0
    CMTST  D23, D22, D14
    CMEQ  D22, D11, #0
    FACGT  S9, S17, S13
    FCMEQ  S30, S7, S30
    CMEQ  V26.2S, V18.2S, V12.2S
    FCMEQ  V4.4S, V20.4S, V24.4S
    CMHI  V2.8B, V14.8B, V27.8B
    FCMGE  S26, S14, S2
    FCMGE  D7, D26, #0.0
    FCMEQ  V12.2S, V29.2S, V25.2S
    FCMGE  V1.2S, V7.2S, V5.2S
    CMHS  V17.8H, V6.8H, V7.8H
    CMHI  D6, D15, D6
    FCMEQ  D21, D21, D16
    FCMLE  D25, D23, #0.0
    CMGE  V17.8B, V29.8B, #0
    FACGE  S10, S10, S5
    FCMEQ  D5, D20, D18
    FACGE  V22.2D, V13.2D, V8.2D
    FCMEQ  D16, D7, D27
    CMEQ  D29, D17, #0
    CMEQ  D20, D21, #0
    CMLE  V29.8H, V13.8H, #0
    FACGE  D7, D19, D21
    FCMEQ  V23.2D, V20.2D, V17.2D
    CMGT  D22, D2, D11
    CMLT  D5, D29, #0
    FCMGE  D28, D6, D19
    FCMLE  V25.4S, V18.4S, #0.0
    FCMLE  S1, S7, #0.0
    FCMEQ  D24, D23, #0.0
    FCMLE  D25, D5, #0.0
    FCMEQ  S22, S23, S23
    CMGE  D6, D1, D13
    CMGT  V5.2D, V13.2D, V1.2D
    CMTST  D24, D9, D16
    CMEQ  D22, D27, D13
    FCMGT  D6, D30, #0.0
    FCMEQ  S28, S8, S12
    FCMEQ  V0.4S, V19.4S, V24.4S
    CMLT  D0, D15, #0
    FACGE  V29.2D, V18.2D, V28.2D
    CMEQ  V25.2S, V3.2S, V27.2S
    CMGE  D25, D25, D7
    FCMLE  D30, D31, #0.0
    FCMGE  V2.2S, V14.2S, V7.2S
    FCMGE  D26, D0, #0.0
    FCMLT  V13.4S, V23.4S, #0.0
    FCMEQ  V12.2D, V8.2D, #0.0
    FCMGE  V0.4S, V4.4S, #0.0
    FCMEQ  V30.2D, V20.2D, #0.0
    CMTST  V31.4S, V4.4S, V19.4S
    FCMEQ  D6, D7, #0.0
    SUBS  X2, X2, #0x1
    B.NE  TaishanSimdPermuteP01_label_1346
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X2
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X4, X26, X4
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X20, X5, X5
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X14, X28, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X5, X12, X7
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X24, X12, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X10
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X7, X18, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X13
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X19, X5, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X18, X10, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X16, X2, X17
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X16, X29, X21
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X2, X5, X22
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X19, X5, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X17, X28, X24
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X22, X18, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X20, X9, X27
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
TaishanSimdPermuteP01_label_1326:
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X24, X6, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X9, X21, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D2
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X7, X11, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X6, X22, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D4
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X6, X22, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X14, X29, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X22, D6
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X23, X12, X22
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D7
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X10
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
TaishanSimdPermuteP01_label_1369:
    FMOV  X9, D8
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D9
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X24
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D11
    MOVZ  X4, #0x0, LSL #0
    SUB  X10, X4, X19
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D12
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X2, X10, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D14
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X2, X10, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D16
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D17
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X23, X12, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D19
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X28, X16, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D20
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X18, X28, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D22
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X20, X25, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X11, X16, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D23
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D26
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X29, X16, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D27
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X7
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X19, X26, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D28
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    SUB  X19, X26, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D29
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X4, X21, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x2e6, LSL #0
    MOVK  X2, #0x1486, LSL #16
    MOVK  X2, #0xd343, LSL #32
    MOVK  X2, #0xdbd, LSL #48
    MOVZ  X3, #0x47a3, LSL #0
    MOVK  X3, #0xa944, LSL #16
    MOVK  X3, #0x1f39, LSL #32
    MOVK  X3, #0x2431, LSL #48
    MOVZ  X4, #0x88b6, LSL #0
    MOVK  X4, #0xf563, LSL #16
    MOVK  X4, #0x1505, LSL #32
    MOVK  X4, #0x851f, LSL #48
    MOVZ  X5, #0x4e58, LSL #0
    MOVK  X5, #0x3bee, LSL #16
    MOVK  X5, #0xbe01, LSL #32
    MOVK  X5, #0xac03, LSL #48
    MOVZ  X6, #0x90f1, LSL #0
    MOVK  X6, #0x5a12, LSL #16
    MOVK  X6, #0xa9db, LSL #32
    MOVK  X6, #0x2f60, LSL #48
    MOVZ  X7, #0x547e, LSL #0
    MOVK  X7, #0xa2bf, LSL #16
    MOVK  X7, #0xf17, LSL #32
    MOVK  X7, #0x8546, LSL #48
    MOVZ  X8, #0x9f14, LSL #0
    MOVK  X8, #0xaceb, LSL #16
    MOVK  X8, #0x888b, LSL #32
    MOVK  X8, #0x99fa, LSL #48
    MOVZ  X9, #0x9a36, LSL #0
    MOVK  X9, #0x81a, LSL #16
    MOVK  X9, #0x591e, LSL #32
    MOVK  X9, #0xccc, LSL #48
    MOVZ  X10, #0xd138, LSL #0
    MOVK  X10, #0xf165, LSL #16
    MOVK  X10, #0xfb4d, LSL #32
    MOVK  X10, #0xa9bf, LSL #48
    MOVZ  X11, #0xb39a, LSL #0
    MOVK  X11, #0xdec4, LSL #16
    MOVK  X11, #0x69db, LSL #32
    MOVK  X11, #0xc96e, LSL #48
    MOVZ  X12, #0xbdc9, LSL #0
    MOVK  X12, #0x62b8, LSL #16
    MOVK  X12, #0x1487, LSL #32
    MOVK  X12, #0x1b51, LSL #48
    MOVZ  X13, #0x6ed7, LSL #0
    MOVK  X13, #0x7d06, LSL #16
    MOVK  X13, #0xe9b0, LSL #32
    MOVK  X13, #0x802f, LSL #48
    MOVZ  X14, #0x6ab4, LSL #0
    MOVK  X14, #0xc13a, LSL #16
    MOVK  X14, #0x8413, LSL #32
    MOVK  X14, #0x603d, LSL #48
    MOVZ  X16, #0x6881, LSL #0
    MOVK  X16, #0xaa4f, LSL #16
    MOVK  X16, #0x48b9, LSL #32
    MOVK  X16, #0xe3dd, LSL #48
    MOVZ  X17, #0x6ace, LSL #0
    MOVK  X17, #0x6f97, LSL #16
    MOVK  X17, #0xcef2, LSL #32
    MOVK  X17, #0xb3d9, LSL #48
    MOVZ  X18, #0x5b6c, LSL #0
    MOVK  X18, #0x2e2f, LSL #16
    MOVK  X18, #0x2204, LSL #32
    MOVK  X18, #0xdfd0, LSL #48
    MOVZ  X19, #0x2af8, LSL #0
    MOVK  X19, #0xcce6, LSL #16
    MOVK  X19, #0xf8ac, LSL #32
    MOVK  X19, #0x7821, LSL #48
    MOVZ  X20, #0xbce2, LSL #0
    MOVK  X20, #0xeb2f, LSL #16
    MOVK  X20, #0xe775, LSL #32
    MOVK  X20, #0x790f, LSL #48
    MOVZ  X21, #0x2caa, LSL #0
    MOVK  X21, #0x2e3b, LSL #16
    MOVK  X21, #0x3aa3, LSL #32
    MOVK  X21, #0x38e1, LSL #48
    MOVZ  X22, #0x2c6f, LSL #0
    MOVK  X22, #0x3a9d, LSL #16
    MOVK  X22, #0xf5ed, LSL #32
    MOVK  X22, #0xd256, LSL #48
    MOVZ  X23, #0x7e9b, LSL #0
    MOVK  X23, #0xe115, LSL #16
    MOVK  X23, #0xc591, LSL #32
    MOVK  X23, #0x82a9, LSL #48
    MOVZ  X24, #0x584, LSL #0
    MOVK  X24, #0x89c4, LSL #16
    MOVK  X24, #0xe123, LSL #32
    MOVK  X24, #0xeb4b, LSL #48
    MOVZ  X25, #0x4fb3, LSL #0
    MOVK  X25, #0xda42, LSL #16
    MOVK  X25, #0x1b98, LSL #32
    MOVK  X25, #0x8d55, LSL #48
    MOVZ  X26, #0x8eec, LSL #0
    MOVK  X26, #0x3cb0, LSL #16
    MOVK  X26, #0xb3c2, LSL #32
    MOVK  X26, #0x29c5, LSL #48
    MOVZ  X27, #0x9ebc, LSL #0
    MOVK  X27, #0x7a50, LSL #16
    MOVK  X27, #0x76e, LSL #32
    MOVK  X27, #0xc70, LSL #48
    MOVZ  X28, #0x9f52, LSL #0
    MOVK  X28, #0x864e, LSL #16
    MOVK  X28, #0xd7e3, LSL #32
    MOVK  X28, #0x1fe3, LSL #48
    MOVZ  X29, #0x47e8, LSL #0
    MOVK  X29, #0x5a34, LSL #16
    MOVK  X29, #0x4f72, LSL #32
    MOVK  X29, #0x6360, LSL #48
    FMOV  D0, X9
    FMOV  V0.D[1], X26
    FMOV  D1, X19
    FMOV  V1.D[1], X24
    FMOV  D2, X3
    FMOV  V2.D[1], X27
    FMOV  D3, X10
    FMOV  V3.D[1], X10
    FMOV  D4, X19
    FMOV  V4.D[1], X10
    FMOV  D5, X8
    FMOV  V5.D[1], X11
    FMOV  D6, X3
    FMOV  V6.D[1], X28
    FMOV  D7, X21
    FMOV  V7.D[1], X8
    FMOV  D8, X12
    FMOV  V8.D[1], X3
    FMOV  D9, X10
    FMOV  V9.D[1], X18
    FMOV  D10, X5
    FMOV  V10.D[1], X7
    FMOV  D11, X7
    FMOV  V11.D[1], X19
    FMOV  D12, X19
    FMOV  V12.D[1], X25
    FMOV  D13, X28
    FMOV  V13.D[1], X28
    FMOV  D14, X9
    FMOV  V14.D[1], X12
    FMOV  D15, X16
    FMOV  V15.D[1], X22
    FMOV  D16, X16
    FMOV  V16.D[1], X9
    FMOV  D17, X6
    FMOV  V17.D[1], X8
    FMOV  D18, X29
    FMOV  V18.D[1], X3
    FMOV  D19, X19
    FMOV  V19.D[1], X17
    FMOV  D20, X3
    FMOV  V20.D[1], X22
    FMOV  D21, X10
    FMOV  V21.D[1], X4
    FMOV  D22, X22
    FMOV  V22.D[1], X29
    FMOV  D23, X8
    FMOV  V23.D[1], X27
    FMOV  D24, X8
    FMOV  V24.D[1], X10
    FMOV  D25, X8
    FMOV  V25.D[1], X6
    FMOV  D26, X11
    FMOV  V26.D[1], X18
    FMOV  D27, X24
    FMOV  V27.D[1], X11
    FMOV  D28, X16
    FMOV  V28.D[1], X19
    FMOV  D29, X18
    FMOV  V29.D[1], X3
    FMOV  D30, X3
    FMOV  V30.D[1], X13
    FMOV  D31, X10
    FMOV  V31.D[1], X22
    MOVZ  X4, #0xa, LSL #0
TaishanSimdPermuteP01_label_1421:
    CMGE  V6.4H, V23.4H, #0
    FACGT  S15, S31, S30
    FCMLE  S27, S17, #0.0
    CMLT  D18, D29, #0
    FCMGT  D3, D22, D8
    FCMGT  S17, S22, #0.0
    CMEQ  D27, D24, D3
    FCMGT  D27, D19, #0.0
    CMGE  V26.8B, V27.8B, V8.8B
    FCMLT  S1, S29, #0.0
    CMGT  D18, D17, #0
    CMEQ  D31, D18, #0
    FCMGT  S26, S5, S9
    CMGT  D14, D15, D17
    FCMGT  D27, D10, #0.0
    CMLT  V2.2S, V28.2S, #0
    CMGT  D12, D2, D2
    FACGT  S22, S29, S2
    FACGE  V24.2D, V12.2D, V10.2D
    FCMGE  V23.4S, V1.4S, V18.4S
    FCMEQ  S22, S22, S26
    CMEQ  D2, D24, #0
    FCMEQ  S17, S24, #0.0
    FACGT  D21, D19, D9
    FCMLT  S27, S20, #0.0
    FCMGT  S27, S4, S12
    CMEQ  D24, D17, #0
    FCMEQ  V22.2S, V17.2S, V29.2S
    CMLT  D2, D22, #0
    FCMEQ  D10, D23, D14
    FCMLE  V11.2S, V10.2S, #0.0
    CMGE  V9.8B, V24.8B, #0
    FACGT  S21, S9, S15
    CMLE  D26, D13, #0
    FCMLE  S21, S31, #0.0
    CMLT  D25, D13, #0
    CMGE  D17, D15, D27
    CMGT  D15, D24, #0
    FCMLT  D20, D17, #0.0
    FACGT  D9, D15, D2
    CMGE  V15.2S, V21.2S, #0
    FCMEQ  V18.4S, V10.4S, V23.4S
    CMEQ  D9, D29, D27
    CMHS  D5, D2, D1
    FCMGE  S13, S5, #0.0
    CMLT  D28, D12, #0
    FCMGE  D23, D8, D5
    CMHS  D7, D10, D25
    FACGT  V25.2S, V28.2S, V17.2S
    FACGE  S21, S20, S10
    FCMGT  V24.2D, V16.2D, #0.0
    FACGT  V13.2D, V19.2D, V16.2D
    FCMGT  D2, D22, D20
    CMGE  V6.2D, V14.2D, V1.2D
    CMEQ  V27.4S, V15.4S, V3.4S
    CMHS  D25, D26, D15
    FCMEQ  S15, S8, #0.0
    FCMGE  S20, S12, #0.0
    FCMGE  D17, D0, #0.0
    FCMGT  D8, D10, #0.0
    FCMGT  D5, D31, D9
    FCMEQ  D7, D9, #0.0
    FCMLT  D6, D8, #0.0
    FCMGE  S19, S21, S7
    CMLT  V11.2D, V21.2D, #0
    FCMEQ  S8, S13, S19
    CMGE  D10, D25, D25
    CMHS  D9, D27, D30
    FCMGT  V12.2S, V15.2S, #0.0
    CMGT  V7.8H, V19.8H, V26.8H
    CMTST  D9, D18, D26
    FACGT  S3, S6, S15
    FCMLE  V13.2S, V3.2S, #0.0
    FACGE  V20.4S, V16.4S, V4.4S
    FCMEQ  D6, D19, #0.0
    FACGT  S19, S17, S25
    CMGT  V28.8B, V25.8B, #0
    CMEQ  V22.4H, V8.4H, V29.4H
    FCMEQ  V0.2D, V31.2D, V17.2D
    CMGT  V15.8H, V9.8H, #0
    FCMEQ  S9, S14, S31
    CMTST  V15.16B, V19.16B, V6.16B
    CMEQ  D3, D30, #0
    CMGE  D10, D21, #0
    FCMGT  V9.2S, V21.2S, #0.0
    FCMGT  V9.2S, V31.2S, #0.0
    FCMGT  S5, S3, #0.0
    CMEQ  V14.8H, V5.8H, #0
    CMLE  V5.8H, V10.8H, #0
    FCMLT  D22, D30, #0.0
    CMTST  V27.4S, V24.4S, V14.4S
    FCMGE  S18, S6, #0.0
    CMLT  V16.16B, V11.16B, #0
    CMHI  V2.4S, V0.4S, V0.4S
    FCMEQ  S11, S22, S16
    FACGE  S4, S8, S22
    CMLT  V19.2D, V20.2D, #0
    FCMEQ  V4.2S, V0.2S, #0.0
    CMTST  V19.16B, V24.16B, V29.16B
    FCMEQ  D15, D7, D27
    CMEQ  V17.2D, V20.2D, V27.2D
    FCMEQ  S18, S15, S11
    CMHS  D17, D5, D15
    CMLE  V18.2S, V8.2S, #0
    CMHI  V0.8H, V21.8H, V12.8H
    FCMGT  D24, D31, #0.0
    FCMGT  D0, D25, #0.0
    FCMEQ  D21, D14, #0.0
    CMEQ  D17, D26, #0
    CMEQ  V17.4S, V2.4S, #0
    FCMEQ  D29, D19, D4
    CMGT  V15.2D, V29.2D, V0.2D
    CMHS  D5, D21, D25
    FCMLE  D2, D9, #0.0
    CMGT  D15, D24, #0
    FACGE  S2, S18, S25
    FACGE  S16, S17, S19
    CMTST  V3.2D, V8.2D, V29.2D
    FACGE  D7, D27, D17
    FCMGT  V27.4S, V21.4S, V29.4S
    FCMLE  V27.4S, V30.4S, #0.0
    CMHS  D7, D5, D0
    CMHI  V7.2S, V2.2S, V14.2S
    CMEQ  D15, D7, D22
    FCMGT  V4.4S, V13.4S, V26.4S
    FCMEQ  V21.2S, V4.2S, #0.0
    FCMEQ  D15, D17, D9
    FCMGE  D11, D9, D20
    FCMGT  V28.2S, V11.2S, V5.2S
    FACGE  V22.2S, V10.2S, V21.2S
    FCMGE  S15, S13, S26
    FCMGT  D22, D30, #0.0
    CMTST  D9, D28, D31
    FCMGT  S20, S8, S14
    CMEQ  V15.8B, V16.8B, #0
    FCMGT  S16, S19, #0.0
    FCMGE  S4, S16, #0.0
    FCMEQ  V9.4S, V22.4S, #0.0
    CMLE  V5.4S, V6.4S, #0
    FCMEQ  D3, D3, #0.0
    CMGT  D20, D25, D31
    CMGE  D9, D31, #0
    FCMLT  V24.2S, V9.2S, #0.0
    CMGT  V2.8B, V17.8B, #0
    FCMEQ  D8, D15, D2
    FACGT  D11, D9, D30
    FCMGT  S11, S4, #0.0
    CMGE  D20, D27, D11
    CMEQ  V9.8B, V2.8B, #0
    FCMEQ  V29.2D, V11.2D, V2.2D
    FCMGE  S15, S15, #0.0
    FCMGE  V29.2S, V31.2S, #0.0
    FACGE  V2.2S, V6.2S, V4.2S
    FCMGE  D22, D10, #0.0
    FACGE  D31, D8, D17
    FCMLT  S24, S17, #0.0
    FCMLE  V22.4S, V28.4S, #0.0
    FACGT  D23, D4, D28
    CMGE  D28, D15, D20
    CMEQ  D21, D26, #0
    FCMGE  S9, S29, #0.0
    CMGT  V8.2S, V18.2S, #0
    FCMLT  S23, S8, #0.0
    CMHI  D16, D21, D6
    CMGT  D18, D25, D18
    CMGT  D18, D20, #0
    FCMLE  D20, D21, #0.0
    CMGT  D10, D20, #0
    CMLE  V10.8B, V2.8B, #0
    CMLE  V31.2S, V7.2S, #0
    FACGT  S4, S31, S2
    CMGE  D5, D9, #0
    FCMGT  V19.4S, V1.4S, V13.4S
    CMLE  V17.2D, V10.2D, #0
    CMGE  D28, D29, D18
    FACGE  S22, S13, S21
    FCMEQ  D23, D22, #0.0
    CMGT  V29.4H, V25.4H, #0
    CMGT  D6, D28, D15
    FCMLE  D26, D20, #0.0
    FCMGE  V19.4S, V24.4S, V30.4S
    FCMGE  S13, S5, #0.0
    CMGE  D1, D29, D18
    FCMGT  S12, S15, #0.0
    FCMGE  S31, S9, S16
    CMGT  V4.8H, V22.8H, V0.8H
    FACGE  S28, S1, S4
    CMGT  V26.2S, V11.2S, #0
    FCMLE  D8, D5, #0.0
    FCMGT  S31, S6, S14
    CMLT  D19, D17, #0
    FCMGE  V3.2D, V20.2D, #0.0
    CMLE  D4, D25, #0
    FCMEQ  V31.4S, V6.4S, #0.0
    CMLT  V21.8H, V22.8H, #0
    CMHS  V8.2S, V19.2S, V18.2S
    CMGT  D18, D0, #0
    FCMEQ  D22, D24, D21
    CMLE  V19.8B, V19.8B, #0
    FCMEQ  V5.2D, V8.2D, V30.2D
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdPermuteP01_label_1421
    MOVZ  X18, #0x2e6, LSL #0
    MOVK  X18, #0x1486, LSL #16
    MOVK  X18, #0xd343, LSL #32
    MOVK  X18, #0xdbd, LSL #48
    SUB  X13, X18, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x47a3, LSL #0
    MOVK  X29, #0xa944, LSL #16
    MOVK  X29, #0x1f39, LSL #32
    MOVK  X29, #0x2431, LSL #48
    SUB  X17, X29, X3
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x4e58, LSL #0
    MOVK  X13, #0x3bee, LSL #16
    MOVK  X13, #0xbe01, LSL #32
    MOVK  X13, #0xac03, LSL #48
    SUB  X28, X13, X5
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x90f1, LSL #0
    MOVK  X13, #0x5a12, LSL #16
    MOVK  X13, #0xa9db, LSL #32
    MOVK  X13, #0x2f60, LSL #48
    SUB  X23, X13, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x547e, LSL #0
    MOVK  X14, #0xa2bf, LSL #16
    MOVK  X14, #0xf17, LSL #32
    MOVK  X14, #0x8546, LSL #48
    SUB  X19, X14, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x9f14, LSL #0
    MOVK  X27, #0xaceb, LSL #16
    MOVK  X27, #0x888b, LSL #32
    MOVK  X27, #0x99fa, LSL #48
    SUB  X24, X27, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X9
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0xb39a, LSL #0
    MOVK  X5, #0xdec4, LSL #16
    MOVK  X5, #0x69db, LSL #32
    MOVK  X5, #0xc96e, LSL #48
    SUB  X7, X5, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0xbdc9, LSL #0
    MOVK  X17, #0x62b8, LSL #16
    MOVK  X17, #0x1487, LSL #32
    MOVK  X17, #0x1b51, LSL #48
    SUB  X16, X17, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x90f1, LSL #0
    MOVK  X26, #0x5a12, LSL #16
    MOVK  X26, #0xa9db, LSL #32
    MOVK  X26, #0x2f60, LSL #48
    SUB  X8, X26, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x547e, LSL #0
    MOVK  X26, #0xa2bf, LSL #16
    MOVK  X26, #0xf17, LSL #32
    MOVK  X26, #0x8546, LSL #48
    SUB  X3, X26, X14
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0xbdc9, LSL #0
    MOVK  X28, #0x62b8, LSL #16
    MOVK  X28, #0x1487, LSL #32
    MOVK  X28, #0x1b51, LSL #48
    SUB  X14, X28, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x2e6, LSL #0
    MOVK  X27, #0x1486, LSL #16
    MOVK  X27, #0xd343, LSL #32
    MOVK  X27, #0xdbd, LSL #48
    SUB  X29, X27, X18
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X19
TaishanSimdPermuteP01_label_1274:
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0xbce2, LSL #0
    MOVK  X16, #0xeb2f, LSL #16
    MOVK  X16, #0xe775, LSL #32
    MOVK  X16, #0x790f, LSL #48
    SUB  X2, X16, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X21, #0x2c6f, LSL #0
    MOVK  X21, #0x3a9d, LSL #16
    MOVK  X21, #0xf5ed, LSL #32
    MOVK  X21, #0xd256, LSL #48
    SUB  X10, X21, X22
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X23
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X24
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0x4fb3, LSL #0
    MOVK  X5, #0xda42, LSL #16
    MOVK  X5, #0x1b98, LSL #32
    MOVK  X5, #0x8d55, LSL #48
    SUB  X24, X5, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X26
TaishanSimdPermuteP01_label_49:
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x2e6, LSL #0
    MOVK  X6, #0x1486, LSL #16
    MOVK  X6, #0xd343, LSL #32
    MOVK  X6, #0xdbd, LSL #48
    SUB  X19, X6, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0xbdc9, LSL #0
    MOVK  X26, #0x62b8, LSL #16
    MOVK  X26, #0x1487, LSL #32
    MOVK  X26, #0x1b51, LSL #48
    SUB  X10, X26, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X6, X18, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X8, X2, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D4
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X13, X23, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D7
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D8
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X4, X18, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X20, X7, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D9
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    SUB  X20, X7, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D10
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X7, X21, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D11
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D12
    MOVZ  X8, #0x0, LSL #0
    SUB  X27, X8, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X28
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X23, X4, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D14
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X23, X4, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X12
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X26, X8, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D17
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X26, X8, X2
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X12, X24, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D19
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D20
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X24, X18, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X13, D21
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X25, X20, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D22
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X25, X20, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D23
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X10, X17, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D24
    MOVZ  X2, #0x0, LSL #0
    SUB  X10, X2, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X14, X24, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D25
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X14, X24, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X23
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X16, X14, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X29, D27
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    SUB  X16, X14, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X27, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X27
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0x0, LSL #0
TaishanSimdPermuteP01_label_768:
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
    FMOV  D0, X23
    FMOV  V0.D[1], X7
    FMOV  D1, X28
    FMOV  V1.D[1], X21
    FMOV  D2, X12
    FMOV  V2.D[1], X18
    FMOV  D3, X6
    FMOV  V3.D[1], X20
    FMOV  D4, X23
    FMOV  V4.D[1], X6
    FMOV  D5, X21
    FMOV  V5.D[1], X7
    FMOV  D6, X8
    FMOV  V6.D[1], X29
    FMOV  D7, X24
    FMOV  V7.D[1], X29
    FMOV  D8, X23
    FMOV  V8.D[1], X20
    FMOV  D9, X2
    FMOV  V9.D[1], X25
    FMOV  D10, X20
    FMOV  V10.D[1], X2
    FMOV  D11, X26
    FMOV  V11.D[1], X3
    FMOV  D12, X11
    FMOV  V12.D[1], X16
    FMOV  D13, X16
    FMOV  V13.D[1], X17
    FMOV  D14, X8
    FMOV  V14.D[1], X23
    FMOV  D15, X7
    FMOV  V15.D[1], X17
    FMOV  D16, X16
    FMOV  V16.D[1], X29
    FMOV  D17, X11
    FMOV  V17.D[1], X17
    FMOV  D18, X2
    FMOV  V18.D[1], X5
    FMOV  D19, X7
    FMOV  V19.D[1], X14
    FMOV  D20, X2
    FMOV  V20.D[1], X6
    FMOV  D21, X29
    FMOV  V21.D[1], X14
    FMOV  D22, X11
    FMOV  V22.D[1], X22
    FMOV  D23, X4
    FMOV  V23.D[1], X27
    FMOV  D24, X13
    FMOV  V24.D[1], X22
    FMOV  D25, X17
    FMOV  V25.D[1], X3
    FMOV  D26, X17
    FMOV  V26.D[1], X27
    FMOV  D27, X5
    FMOV  V27.D[1], X7
    FMOV  D28, X10
    FMOV  V28.D[1], X6
    FMOV  D29, X3
    FMOV  V29.D[1], X12
    FMOV  D30, X24
    FMOV  V30.D[1], X16
    FMOV  D31, X20
    FMOV  V31.D[1], X11
    MOVZ  X13, #0xa, LSL #0
TaishanSimdPermuteP01_label_1497:
    FCMGE  S29, S9, S24
    FCMLT  S22, S23, #0.0
    CMLE  V4.2S, V13.2S, #0
    CMGT  D0, D18, #0
    FACGE  V10.2D, V4.2D, V7.2D
    FCMLT  V0.2D, V30.2D, #0.0
    FCMGE  D24, D26, #0.0
    CMTST  V25.2D, V12.2D, V16.2D
    FCMGT  D27, D12, #0.0
    FACGT  V29.4S, V13.4S, V28.4S
    FCMGT  D19, D29, D9
    FCMLE  D27, D29, #0.0
    FCMLE  V28.2D, V31.2D, #0.0
    FCMGT  V7.2S, V16.2S, V23.2S
    CMLE  V30.4S, V12.4S, #0
    FCMGT  V0.4S, V28.4S, #0.0
    CMGT  V31.8B, V18.8B, V6.8B
    FCMLT  V24.2S, V0.2S, #0.0
    FACGT  V24.2S, V9.2S, V30.2S
    FCMGT  V5.2D, V25.2D, #0.0
    FCMLE  D8, D27, #0.0
    FCMLT  D24, D18, #0.0
    FCMGT  V20.2S, V23.2S, #0.0
    FCMGT  S6, S4, S2
    FCMGT  D8, D4, D28
    FCMEQ  S10, S31, S31
    FCMGT  D8, D16, D30
    FCMLT  D26, D23, #0.0
    FCMEQ  S2, S9, S7
    CMHS  V29.4S, V28.4S, V11.4S
    FACGT  V24.2D, V16.2D, V21.2D
    CMEQ  V17.2D, V5.2D, V24.2D
    FCMGT  D29, D19, D5
    FCMGT  S15, S27, S24
    FCMGE  S7, S26, S27
    CMGE  D6, D15, #0
    CMLT  V7.8H, V31.8H, #0
    FCMGE  S7, S16, #0.0
    FCMLE  S19, S16, #0.0
    FCMGE  V14.2D, V11.2D, #0.0
    CMEQ  D27, D12, #0
    FCMLE  S2, S15, #0.0
    FACGT  V15.2S, V12.2S, V25.2S
    CMHS  D31, D15, D19
    CMHS  D19, D9, D29
    FCMGT  V12.4S, V18.4S, V25.4S
    CMGT  V25.4H, V22.4H, #0
    CMEQ  V9.4H, V11.4H, V21.4H
    CMHS  V13.2S, V16.2S, V0.2S
TaishanSimdPermuteP01_label_256:
    CMEQ  V24.2S, V3.2S, V14.2S
    CMGT  V31.4H, V1.4H, #0
    FCMGE  D22, D22, D8
    FCMEQ  S22, S6, S31
    FACGT  D9, D19, D11
    CMGT  D23, D27, #0
    FCMGE  S16, S13, #0.0
    CMGE  D21, D18, D26
    FCMGT  S20, S24, S24
    FCMEQ  D7, D7, #0.0
    CMHI  D7, D13, D28
    FCMGT  D9, D0, #0.0
    CMEQ  D22, D26, D6
    CMHS  D31, D4, D5
    CMHS  D6, D28, D4
    CMTST  D5, D29, D16
    FCMGT  D14, D16, #0.0
    FCMLT  V10.2S, V20.2S, #0.0
    FCMEQ  V3.2S, V24.2S, #0.0
    FCMGT  D20, D22, #0.0
    FCMGE  V6.2S, V8.2S, V22.2S
    FCMEQ  V30.2S, V5.2S, #0.0
    FCMGT  S12, S9, S7
    FCMGE  S30, S8, S4
    FACGE  V26.2D, V25.2D, V12.2D
    FCMEQ  S19, S3, #0.0
    FCMGE  S28, S27, #0.0
    FCMEQ  D3, D3, #0.0
    FCMEQ  V0.4S, V5.4S, #0.0
    CMEQ  V3.16B, V4.16B, V7.16B
    FCMLT  D1, D16, #0.0
    CMGE  V10.16B, V4.16B, V2.16B
    CMGE  D1, D26, #0
    FCMGE  V10.2S, V0.2S, #0.0
    CMEQ  V11.2D, V30.2D, V12.2D
    FACGE  S25, S22, S28
    CMGE  V19.8B, V28.8B, #0
    FCMGE  V23.2D, V30.2D, #0.0
    FCMGT  V9.2S, V8.2S, #0.0
    FCMGE  D14, D17, D26
    CMLT  V27.8H, V22.8H, #0
    FACGT  V2.2S, V1.2S, V7.2S
    CMLE  D25, D20, #0
    CMGT  V0.16B, V18.16B, #0
    FCMLT  D13, D24, #0.0
    FCMGT  V9.4S, V3.4S, #0.0
    FCMGT  D6, D9, D28
    CMTST  D9, D13, D16
    FCMGE  D24, D22, D12
    CMHS  D2, D27, D1
    FCMEQ  D12, D9, D0
    CMEQ  D15, D6, D23
    FCMLT  S26, S2, #0.0
    CMGE  D19, D18, D23
    CMLT  V23.2S, V19.2S, #0
    CMHI  V20.8B, V10.8B, V17.8B
    CMGT  V9.8B, V15.8B, V7.8B
    FCMGT  V20.2S, V26.2S, #0.0
    CMTST  V21.16B, V7.16B, V0.16B
    CMHS  V9.16B, V14.16B, V6.16B
    CMGT  V3.16B, V4.16B, V9.16B
    FCMGT  V4.4S, V20.4S, V25.4S
    FCMGE  D25, D16, #0.0
    CMTST  D31, D18, D1
    CMEQ  D0, D31, D28
    CMLT  D22, D29, #0
    FCMLT  V26.4S, V5.4S, #0.0
    CMGE  V20.4S, V10.4S, #0
    FCMEQ  D13, D18, D14
    FCMEQ  V14.2S, V6.2S, #0.0
    FCMGE  V10.2S, V5.2S, #0.0
    CMHI  D4, D9, D10
    FCMGE  D31, D18, #0.0
    FCMGT  D1, D31, D0
    CMHI  V13.8H, V20.8H, V4.8H
    CMLT  V3.4H, V29.4H, #0
    FCMGE  S7, S29, S4
    CMHI  D28, D31, D16
    CMTST  V18.2S, V21.2S, V31.2S
    CMEQ  D10, D4, #0
    CMLT  D10, D31, #0
    CMGE  D15, D10, D20
    CMGT  D9, D14, #0
    FCMGE  D26, D0, D15
    FCMLE  S1, S26, #0.0
    FCMGE  S0, S27, S19
    CMGT  V27.4H, V19.4H, #0
    FCMEQ  V4.2D, V15.2D, V6.2D
    CMGT  D30, D5, #0
    CMLE  V11.8B, V3.8B, #0
    CMEQ  D24, D1, D4
    FACGE  V13.2S, V11.2S, V14.2S
    CMLT  V25.2D, V9.2D, #0
    CMGE  D27, D29, D2
    CMLE  D18, D20, #0
    FACGE  V30.2D, V30.2D, V2.2D
    FCMLE  D18, D9, #0.0
    FCMLT  V21.4S, V3.4S, #0.0
    FACGT  D16, D31, D3
    FCMLE  S26, S11, #0.0
    FCMEQ  V19.2S, V8.2S, V17.2S
    CMLT  D22, D26, #0
    FCMEQ  V15.2S, V14.2S, V26.2S
    FACGT  S26, S10, S21
    FACGE  S13, S1, S5
    FCMGE  V16.2S, V0.2S, #0.0
    FCMLT  D13, D8, #0.0
    CMEQ  D2, D21, #0
    CMGT  D25, D13, #0
    FCMGT  V1.4S, V27.4S, #0.0
    FCMEQ  S2, S18, #0.0
    CMLT  D11, D5, #0
    FCMEQ  V21.2S, V26.2S, V19.2S
    FACGT  V16.2D, V16.2D, V17.2D
    CMLE  D21, D15, #0
    FCMLE  D6, D16, #0.0
    FCMGE  S14, S20, S4
    FCMLE  S24, S19, #0.0
    FCMEQ  D16, D11, #0.0
    FCMEQ  S24, S17, #0.0
    CMGE  V25.8H, V18.8H, V1.8H
    FCMLE  D31, D14, #0.0
    FCMEQ  S31, S6, S18
    FCMGT  D15, D31, D16
    FCMLE  S30, S8, #0.0
    FCMLT  D23, D0, #0.0
    FACGT  S6, S3, S5
    CMHS  D14, D30, D26
    FACGE  S8, S7, S15
    CMGT  V27.2S, V22.2S, V0.2S
    FCMGT  V16.4S, V2.4S, V19.4S
    CMGT  D23, D16, D4
    FCMEQ  D30, D28, #0.0
    FCMLE  D8, D11, #0.0
    FCMEQ  S14, S22, S30
    FACGE  S30, S0, S5
    FCMLT  D24, D24, #0.0
    CMTST  V14.2S, V0.2S, V30.2S
    FCMEQ  S1, S11, S16
    CMGT  V28.8H, V25.8H, #0
    FACGT  S24, S30, S18
    FCMEQ  D29, D1, #0.0
    FACGE  V2.2D, V5.2D, V21.2D
    CMHI  D30, D6, D8
    FCMGT  D26, D31, D5
    FACGE  V0.2S, V7.2S, V2.2S
    FCMLT  S8, S6, #0.0
    CMEQ  D27, D24, D6
    CMGE  V4.4H, V0.4H, V9.4H
    FACGT  V23.2D, V2.2D, V9.2D
    FCMEQ  V27.2D, V20.2D, V30.2D
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdPermuteP01_label_1497
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X23, X11, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X4, X20, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X4, X13, X9
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X10
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdPermuteP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X18
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X28, X17, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X25, X13, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X6, X29, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X29, X17, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X10, X14, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X26
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X29, X26, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X29
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X14, X23, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X14, X23, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X20, D3
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D4
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    SUB  X27, X11, X9
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X19, X27, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D7
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    SUB  X5, X6, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D8
    MOVZ  X4, #0x0, LSL #0
    SUB  X5, X4, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D10
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X4, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X22, X13, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D12
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X22, X13, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
TaishanSimdPermuteP01_label_319:
    SUB  X16, X23, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X26, D13
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X26
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X22, D16
    MOVZ  X8, #0x0, LSL #0
    SUB  X12, X8, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D17
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X25, X13, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X22, X3, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D18
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X22, X3, X25
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D19
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X2
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X24, X6, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D20
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X24, X6, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D21
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X18, X25, X6
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V22.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D22
    MOVZ  X6, #0x0, LSL #0
    SUB  X14, X6, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X7, D23
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X28, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X3, X9, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X14, X10, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D25
    MOVZ  X10, #0x0, LSL #0
    SUB  X14, X10, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D27
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    FMOV  X23, D29
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X13, X26, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
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
    FMOV  V0.D[1], X23
    FMOV  D1, X10
    FMOV  V1.D[1], X4
    FMOV  D2, X2
    FMOV  V2.D[1], X16
    FMOV  D3, X5
    FMOV  V3.D[1], X29
    FMOV  D4, X12
    FMOV  V4.D[1], X8
    FMOV  D5, X24
    FMOV  V5.D[1], X9
    FMOV  D6, X7
    FMOV  V6.D[1], X28
    FMOV  D7, X27
    FMOV  V7.D[1], X6
    FMOV  D8, X10
    FMOV  V8.D[1], X17
    FMOV  D9, X6
    FMOV  V9.D[1], X10
    FMOV  D10, X23
    FMOV  V10.D[1], X6
    FMOV  D11, X2
    FMOV  V11.D[1], X13
    FMOV  D12, X29
    FMOV  V12.D[1], X17
    FMOV  D13, X25
    FMOV  V13.D[1], X10
    FMOV  D14, X25
    FMOV  V14.D[1], X27
    FMOV  D15, X16
    FMOV  V15.D[1], X29
    FMOV  D16, X4
    FMOV  V16.D[1], X26
    FMOV  D17, X10
    FMOV  V17.D[1], X14
    FMOV  D18, X3
    FMOV  V18.D[1], X28
    FMOV  D19, X20
    FMOV  V19.D[1], X13
    FMOV  D20, X28
    FMOV  V20.D[1], X20
    FMOV  D21, X21
    FMOV  V21.D[1], X14
    FMOV  D22, X4
    FMOV  V22.D[1], X29
    FMOV  D23, X5
    FMOV  V23.D[1], X9
    FMOV  D24, X19
    FMOV  V24.D[1], X22
    FMOV  D25, X23
    FMOV  V25.D[1], X7
    FMOV  D26, X12
    FMOV  V26.D[1], X7
    FMOV  D27, X6
    FMOV  V27.D[1], X4
    FMOV  D28, X25
    FMOV  V28.D[1], X16
    FMOV  D29, X27
    FMOV  V29.D[1], X19
    FMOV  D30, X7
    FMOV  V30.D[1], X27
    FMOV  D31, X10
    FMOV  V31.D[1], X9
    MOVZ  X28, #0xf, LSL #0
TaishanSimdPermuteP01_label_1574:
    CMTST  V24.16B, V11.16B, V2.16B
    FACGE  D26, D28, D23
    CMLE  D24, D8, #0
    CMLE  V28.2S, V30.2S, #0
    CMGT  V11.8B, V2.8B, #0
    FCMLT  S4, S9, #0.0
    FCMEQ  D11, D25, D28
    CMLE  V7.16B, V31.16B, #0
    CMEQ  V10.2D, V13.2D, #0
    FCMEQ  S7, S25, S8
    FACGT  D13, D24, D0
    CMGE  D12, D28, #0
    FCMLT  S5, S21, #0.0
    FACGT  S19, S11, S22
    FCMLE  S21, S7, #0.0
    FACGE  D21, D9, D12
    FCMEQ  D13, D13, #0.0
    FCMGE  V13.2S, V10.2S, #0.0
    FACGE  D16, D25, D5
    FCMGT  D0, D25, #0.0
    FCMGE  S21, S30, S4
    FCMGT  V13.2S, V28.2S, V24.2S
    FCMGT  S2, S5, S4
    FCMLT  V14.4S, V14.4S, #0.0
    CMEQ  V14.4H, V24.4H, V23.4H
    FCMGT  S12, S12, S0
    FCMGE  V8.4S, V31.4S, V21.4S
    FCMLE  V2.4S, V12.4S, #0.0
    FCMGT  V31.2S, V27.2S, V13.2S
    CMGE  D25, D16, D14
    FACGT  S8, S20, S29
    FCMGE  V4.2D, V28.2D, V30.2D
    CMGT  V10.8H, V27.8H, V25.8H
    FCMEQ  S27, S21, S9
    FCMGE  S7, S12, S8
    FACGT  V3.2D, V12.2D, V8.2D
    FCMGT  V27.4S, V20.4S, #0.0
    CMEQ  D18, D28, D7
    FCMGE  S10, S10, S7
    CMTST  D13, D11, D11
    CMHI  V9.8H, V17.8H, V0.8H
    FCMLT  D2, D27, #0.0
    CMHS  V25.2S, V19.2S, V17.2S
    FCMGE  D26, D25, D19
    FCMGT  D1, D3, #0.0
    CMHS  D12, D23, D3
    CMGT  V19.4H, V27.4H, #0
    FCMEQ  V14.2S, V7.2S, #0.0
    CMLE  D30, D27, #0
    FCMGE  D29, D16, #0.0
    CMEQ  V25.2D, V13.2D, #0
    FCMGT  V24.4S, V2.4S, V21.4S
    CMGE  V27.8H, V14.8H, #0
    FCMGT  V0.2D, V27.2D, V3.2D
    FCMGT  V30.4S, V7.4S, #0.0
    CMHS  D13, D5, D31
    CMHI  D17, D0, D14
    FACGT  D11, D0, D20
    FCMGE  V10.2D, V29.2D, V23.2D
    FCMLT  D0, D11, #0.0
    FCMEQ  V3.4S, V14.4S, #0.0
    FCMGE  D1, D0, D12
    FCMEQ  D4, D14, D29
    CMGT  V25.4H, V16.4H, V11.4H
    FCMEQ  D23, D30, #0.0
    CMHI  V23.2S, V11.2S, V11.2S
    CMHS  D4, D3, D7
    FCMLE  D9, D7, #0.0
    CMGE  V4.2S, V2.2S, V5.2S
    CMGE  V1.16B, V8.16B, V25.16B
    CMGT  D12, D12, #0
    FCMLT  D11, D4, #0.0
    CMHI  V24.16B, V1.16B, V23.16B
    FACGT  S9, S1, S13
    FCMEQ  D12, D31, D29
    CMGE  D19, D10, #0
    FACGE  V15.4S, V30.4S, V0.4S
    FACGE  V12.2D, V1.2D, V15.2D
    CMGT  V25.2D, V12.2D, V24.2D
    CMEQ  V23.4S, V19.4S, V30.4S
    FCMEQ  D5, D10, #0.0
    CMGE  V23.16B, V18.16B, V27.16B
    FCMLT  D11, D5, #0.0
    FACGE  S20, S19, S9
    CMGE  V19.8B, V10.8B, V30.8B
    CMGT  V10.16B, V28.16B, V11.16B
    FCMGE  V8.4S, V30.4S, V21.4S
    FCMLT  S20, S12, #0.0
    FCMEQ  D27, D14, #0.0
    FCMEQ  D4, D8, D5
    CMEQ  D25, D29, D14
    FCMEQ  D21, D23, #0.0
    CMTST  V20.16B, V28.16B, V13.16B
    FCMLT  D13, D28, #0.0
    FCMEQ  D1, D12, D15
    FCMLE  V29.2S, V21.2S, #0.0
    FCMGT  D1, D31, D18
    FCMLE  V1.4S, V11.4S, #0.0
    FCMGT  S19, S28, S21
    CMGT  V13.8B, V23.8B, V8.8B
    CMGT  D21, D5, D10
    FCMLT  S19, S4, #0.0
    FCMGT  V31.2D, V12.2D, V26.2D
    FCMLE  V12.2S, V20.2S, #0.0
    CMGE  V7.4S, V17.4S, V8.4S
    FCMGE  V7.2D, V23.2D, #0.0
    CMEQ  V21.4S, V25.4S, #0
    CMEQ  D17, D5, #0
    CMEQ  D19, D6, #0
    FCMGE  V21.2D, V23.2D, #0.0
    FCMGT  D7, D7, #0.0
    FACGE  S21, S21, S7
    CMHS  D11, D15, D21
    CMEQ  V1.16B, V31.16B, #0
    FACGT  V22.4S, V27.4S, V31.4S
    CMGT  D14, D1, #0
    CMHI  D17, D25, D4
    CMLT  D24, D10, #0
    CMEQ  D17, D28, D25
    FCMEQ  S11, S20, S1
    CMLT  V9.4S, V21.4S, #0
    FCMGT  D18, D9, D14
    CMEQ  V29.4H, V2.4H, V27.4H
    FACGT  D19, D2, D30
    CMEQ  D31, D5, #0
    CMGE  D24, D25, #0
    CMLE  V24.4H, V23.4H, #0
    FACGE  S17, S30, S16
    FCMLE  D22, D27, #0.0
    CMGE  D16, D29, D5
    CMGE  V2.4H, V9.4H, V15.4H
    FCMGE  V7.2S, V16.2S, #0.0
    FACGE  V4.2D, V11.2D, V23.2D
    FACGT  S17, S28, S14
    CMHI  V22.16B, V7.16B, V1.16B
    FCMGT  S17, S27, S17
    FCMGT  D19, D17, #0.0
    CMLT  D11, D19, #0
    CMEQ  D7, D9, #0
    CMEQ  V25.8H, V18.8H, V21.8H
    FCMGT  S5, S19, #0.0
    CMGT  D7, D12, #0
    CMGT  V20.2D, V8.2D, #0
    CMLT  V24.8H, V30.8H, #0
    FCMLE  S11, S2, #0.0
    FACGT  D28, D8, D0
    CMLT  V9.2S, V11.2S, #0
    FCMEQ  V4.2D, V22.2D, V25.2D
    CMGT  D7, D1, D13
    CMHS  V13.8H, V14.8H, V19.8H
    FCMGT  D23, D13, D5
    CMLE  V27.2D, V12.2D, #0
    CMHS  V0.8B, V18.8B, V17.8B
    FCMGE  D8, D18, #0.0
    FCMEQ  D30, D28, #0.0
    FCMGT  D4, D27, #0.0
    FCMEQ  D14, D15, #0.0
    CMTST  D4, D12, D18
    FACGE  S2, S1, S31
    FCMLE  D30, D21, #0.0
    CMEQ  V20.4H, V27.4H, V10.4H
    FACGT  D25, D9, D9
    FCMGE  S9, S15, S30
    CMLE  D29, D4, #0
    CMGE  V7.2S, V30.2S, #0
    FACGT  S29, S26, S19
    CMHS  D9, D20, D30
    CMHS  V11.2D, V27.2D, V18.2D
    CMGT  D1, D2, #0
    FCMGE  D3, D7, D22
    CMLT  V4.8H, V16.8H, #0
    CMTST  V22.2S, V5.2S, V10.2S
    FACGT  V13.2D, V15.2D, V29.2D
    CMLT  V9.16B, V28.16B, #0
    FCMGE  D29, D6, D29
    CMHI  V2.8B, V19.8B, V8.8B
    CMEQ  D28, D16, D13
    CMLT  D22, D31, #0
    FACGT  V0.2D, V22.2D, V6.2D
    FCMGE  V9.4S, V12.4S, V0.4S
    FCMEQ  S9, S16, #0.0
    FCMEQ  V4.2S, V15.2S, #0.0
    FCMGE  V10.2S, V5.2S, V13.2S
    FCMLT  D11, D2, #0.0
    FCMGE  V1.2S, V6.2S, V30.2S
    CMLT  D16, D21, #0
    FCMGE  D14, D4, #0.0
    FCMGE  S10, S0, S11
    FACGE  D19, D19, D15
    FCMGT  V29.2S, V22.2S, V23.2S
    CMEQ  D2, D28, #0
    CMHS  V14.16B, V30.16B, V4.16B
    FCMGT  D11, D29, #0.0
    FCMGE  V19.2D, V12.2D, #0.0
    FCMEQ  S16, S23, #0.0
    CMGT  V10.2S, V26.2S, V16.2S
    FCMGT  V9.2S, V29.2S, #0.0
    CMEQ  V18.8H, V4.8H, #0
    FCMGT  V22.4S, V19.4S, #0.0
    CMHI  D21, D12, D12
    SUBS  X28, X28, #0x1
    B.NE  TaishanSimdPermuteP01_label_1574
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X23, X25, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X7, X25, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X19, X20, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X7, X6, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X22, X13, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X23, X27, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X16, X9, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdPermuteP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X27, X2, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X10, X12, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X7, X14, X12
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X5, X3, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X22, X14, X14
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X5, X28, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X18
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdPermuteP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X3, X12, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X10, X22, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X4, X19, X22
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdPermuteP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X10, X19, X25
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdPermuteP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X13, X5, X26
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdPermuteP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X22, X23, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdPermuteP01_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X14, D2
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X19, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X19, D3
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X28, X18, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X5, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X12
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdPermuteP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X26, X14, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X16, D6
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X26, X14, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X24, X4, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X25, D8
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X20, X4, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdPermuteP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X12, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X12
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X19, X16, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D10
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    SUB  X19, X16, X3
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D11
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X17, D12
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X17
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdPermuteP01_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X8, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X21, X26, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X27, X6, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X24, D14
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X27, X6, X24
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
TaishanSimdPermuteP01_label_1377:
    FMOV  X17, D16
    MOVZ  X22, #0xffff, LSL #0
TaishanSimdPermuteP01_label_1480:
    MOVK  X22, #0xffff, LSL #16
TaishanSimdPermuteP01_label_1439:
    SUB  X2, X22, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdPermuteP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X6, D17
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X23, X10, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D18
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X23, X10, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X14, X17, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X9, D19
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X14, X17, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X23, X13, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdPermuteP01_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X11, D22
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D23
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdPermuteP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X10, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D25
    MOVZ  X27, #0x0, LSL #0
    SUB  X14, X27, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdPermuteP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X21, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdPermuteP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X24, X21, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X18, D27
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X24, X21, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdPermuteP01_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X3, D28
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X21, X25, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdPermuteP01_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail
    FMOV  X2, D29
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdPermuteP01_TestFail

TaishanSimdPermuteP01_TestEnd:
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
TaishanSimdPermuteP01_TestFail:
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
