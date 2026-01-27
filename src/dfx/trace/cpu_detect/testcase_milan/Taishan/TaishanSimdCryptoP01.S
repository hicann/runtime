.global TaishanSimdCryptoP01

.text
.p2align 4

TaishanSimdCryptoP01:

TaishanSimdCryptoP01_TestBegin:
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
    MOVK  X2, #0x1255, LSL #48
    MOVK  X2, #0xe950, LSL #32
    MOVK  X2, #0xce2d, LSL #16
    MOVK  X2, #0x5d16, LSL #0
    MOVK  X3, #0x5900, LSL #48
    MOVK  X3, #0xc7f3, LSL #32
    MOVK  X3, #0x31e6, LSL #16
    MOVK  X3, #0x4020, LSL #0
    MOVK  X4, #0xa59e, LSL #48
    MOVK  X4, #0x1b76, LSL #32
    MOVK  X4, #0xfbe6, LSL #16
    MOVK  X4, #0x3f8, LSL #0
    MOVK  X5, #0x4d4e, LSL #48
    MOVK  X5, #0x4fa7, LSL #32
    MOVK  X5, #0x5b01, LSL #16
    MOVK  X5, #0x8977, LSL #0
    MOVK  X6, #0xd438, LSL #48
    MOVK  X6, #0x3c17, LSL #32
    MOVK  X6, #0xb1a3, LSL #16
    MOVK  X6, #0x13a6, LSL #0
    MOVK  X7, #0xff65, LSL #48
    MOVK  X7, #0xa311, LSL #32
    MOVK  X7, #0xebac, LSL #16
    MOVK  X7, #0x6462, LSL #0
    MOVK  X8, #0xf32f, LSL #48
    MOVK  X8, #0x8f6d, LSL #32
    MOVK  X8, #0xa8de, LSL #16
    MOVK  X8, #0x2912, LSL #0
    MOVK  X9, #0x5c12, LSL #48
    MOVK  X9, #0xc556, LSL #32
    MOVK  X9, #0xa163, LSL #16
    MOVK  X9, #0x601a, LSL #0
    MOVK  X10, #0xf66a, LSL #48
    MOVK  X10, #0x9502, LSL #32
    MOVK  X10, #0x6a14, LSL #16
    MOVK  X10, #0x49de, LSL #0
    MOVK  X11, #0x539a, LSL #48
    MOVK  X11, #0xad56, LSL #32
    MOVK  X11, #0xf814, LSL #16
    MOVK  X11, #0x6b1d, LSL #0
    MOVK  X12, #0xc1ec, LSL #48
    MOVK  X12, #0x2834, LSL #32
    MOVK  X12, #0x9405, LSL #16
    MOVK  X12, #0x531, LSL #0
    MOVK  X13, #0xb27e, LSL #48
    MOVK  X13, #0xae19, LSL #32
    MOVK  X13, #0xba95, LSL #16
    MOVK  X13, #0xd3f4, LSL #0
    MOVK  X14, #0x9db8, LSL #48
    MOVK  X14, #0x407, LSL #32
    MOVK  X14, #0xb318, LSL #16
    MOVK  X14, #0x697b, LSL #0
    MOVK  X16, #0xc4a1, LSL #48
    MOVK  X16, #0xdece, LSL #32
    MOVK  X16, #0x693b, LSL #16
    MOVK  X16, #0x4d54, LSL #0
    MOVK  X17, #0xf5a2, LSL #48
    MOVK  X17, #0xb426, LSL #32
    MOVK  X17, #0xf575, LSL #16
    MOVK  X17, #0x5e0a, LSL #0
    MOVK  X18, #0x860b, LSL #48
    MOVK  X18, #0x5989, LSL #32
    MOVK  X18, #0x433, LSL #16
    MOVK  X18, #0xe39f, LSL #0
    MOVK  X19, #0x97ed, LSL #48
    MOVK  X19, #0x9725, LSL #32
    MOVK  X19, #0xa3e, LSL #16
    MOVK  X19, #0x2d21, LSL #0
    MOVK  X20, #0xef26, LSL #48
    MOVK  X20, #0xa052, LSL #32
    MOVK  X20, #0x1b95, LSL #16
    MOVK  X20, #0x108b, LSL #0
    MOVK  X21, #0xa4bf, LSL #48
    MOVK  X21, #0x31b3, LSL #32
    MOVK  X21, #0x288f, LSL #16
    MOVK  X21, #0xd03c, LSL #0
    MOVK  X22, #0x7280, LSL #48
    MOVK  X22, #0x4604, LSL #32
    MOVK  X22, #0x1760, LSL #16
    MOVK  X22, #0x2324, LSL #0
    MOVK  X23, #0xed44, LSL #48
    MOVK  X23, #0x339b, LSL #32
    MOVK  X23, #0x85cc, LSL #16
    MOVK  X23, #0x7195, LSL #0
    MOVK  X24, #0xd6f, LSL #48
    MOVK  X24, #0x7dc0, LSL #32
    MOVK  X24, #0x1080, LSL #16
    MOVK  X24, #0xd90b, LSL #0
    MOVK  X25, #0x2016, LSL #48
    MOVK  X25, #0x72a5, LSL #32
    MOVK  X25, #0xbe60, LSL #16
    MOVK  X25, #0x3b18, LSL #0
    MOVK  X26, #0xc7cf, LSL #48
    MOVK  X26, #0x1ef2, LSL #32
    MOVK  X26, #0x361d, LSL #16
    MOVK  X26, #0x7152, LSL #0
    MOVK  X27, #0x5f1a, LSL #48
    MOVK  X27, #0xa108, LSL #32
    MOVK  X27, #0x3a0f, LSL #16
    MOVK  X27, #0xb7ce, LSL #0
    MOVK  X28, #0xc30d, LSL #48
    MOVK  X28, #0x3af, LSL #32
    MOVK  X28, #0x5326, LSL #16
    MOVK  X28, #0xf0fc, LSL #0
    MOVK  X29, #0xe8e1, LSL #48
    MOVK  X29, #0xa681, LSL #32
    MOVK  X29, #0xe4e5, LSL #16
    MOVK  X29, #0xc455, LSL #0
    SUBS  W14, W16, #0x4a1, LSL #12
    MOVZ  X12, #0x3e28, LSL #0
    MOVK  X12, #0x4519, LSL #16
    MSR  FPCR, X12
    MRS  X2, FPSR
    MOVZ  X16, #0xff60, LSL #0
    MOVK  X16, #0x7ff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    AND  X2, X2, X16
    MOVZ  X16, #0x0, LSL #0
    ORR  X2, X2, X16
    MSR  FPSR, X2
    ISB  SY
    MOVZ  X2, #0xfe2c, LSL #0
    MOVK  X2, #0xe575, LSL #16
    MOVK  X2, #0xcba0, LSL #32
    MOVK  X2, #0xc62b, LSL #48
    MOVZ  X3, #0x62b1, LSL #0
    MOVK  X3, #0xc2c5, LSL #16
    MOVK  X3, #0xd83c, LSL #32
    MOVK  X3, #0x8109, LSL #48
    MOVZ  X4, #0x8e1d, LSL #0
    MOVK  X4, #0x208f, LSL #16
    MOVK  X4, #0xc9bc, LSL #32
    MOVK  X4, #0x3018, LSL #48
    MOVZ  X5, #0x2031, LSL #0
    MOVK  X5, #0xdbf5, LSL #16
    MOVK  X5, #0xaeb6, LSL #32
    MOVK  X5, #0xfcb1, LSL #48
    MOVZ  X6, #0xd974, LSL #0
    MOVK  X6, #0x16b5, LSL #16
    MOVK  X6, #0xa2, LSL #32
    MOVK  X6, #0x86a1, LSL #48
    MOVZ  X7, #0xecef, LSL #0
    MOVK  X7, #0xcec3, LSL #16
    MOVK  X7, #0xaf06, LSL #32
    MOVK  X7, #0x9d3e, LSL #48
    MOVZ  X8, #0x42df, LSL #0
    MOVK  X8, #0xf249, LSL #16
    MOVK  X8, #0x193f, LSL #32
    MOVK  X8, #0xfd4d, LSL #48
    MOVZ  X9, #0xb4e8, LSL #0
    MOVK  X9, #0x4550, LSL #16
    MOVK  X9, #0x7814, LSL #32
    MOVK  X9, #0x68d9, LSL #48
    MOVZ  X10, #0xa680, LSL #0
    MOVK  X10, #0xaf64, LSL #16
    MOVK  X10, #0x6bfc, LSL #32
    MOVK  X10, #0xa83e, LSL #48
    MOVZ  X11, #0xd285, LSL #0
    MOVK  X11, #0xf8b2, LSL #16
    MOVK  X11, #0x217a, LSL #32
    MOVK  X11, #0x76d6, LSL #48
    MOVZ  X12, #0xc9c, LSL #0
    MOVK  X12, #0xa01d, LSL #16
    MOVK  X12, #0x563e, LSL #32
    MOVK  X12, #0xe15a, LSL #48
    MOVZ  X13, #0x330, LSL #0
    MOVK  X13, #0xd543, LSL #16
    MOVK  X13, #0xded8, LSL #32
    MOVK  X13, #0xf42c, LSL #48
    MOVZ  X14, #0x668c, LSL #0
    MOVK  X14, #0xf15e, LSL #16
    MOVK  X14, #0xc97f, LSL #32
    MOVK  X14, #0xbd9d, LSL #48
    MOVZ  X16, #0xfb3b, LSL #0
    MOVK  X16, #0xcf66, LSL #16
    MOVK  X16, #0x3b58, LSL #32
    MOVK  X16, #0x19e4, LSL #48
    MOVZ  X17, #0x268b, LSL #0
    MOVK  X17, #0x6ca, LSL #16
    MOVK  X17, #0xd18, LSL #32
    MOVK  X17, #0x7, LSL #48
    MOVZ  X18, #0x2d7b, LSL #0
    MOVK  X18, #0x3e63, LSL #16
    MOVK  X18, #0xf160, LSL #32
    MOVK  X18, #0x46df, LSL #48
    MOVZ  X19, #0xd2a4, LSL #0
    MOVK  X19, #0x22ce, LSL #16
    MOVK  X19, #0xa1b9, LSL #32
    MOVK  X19, #0xf6a1, LSL #48
    MOVZ  X20, #0xf801, LSL #0
    MOVK  X20, #0xe606, LSL #16
    MOVK  X20, #0x1417, LSL #32
    MOVK  X20, #0x5ff, LSL #48
    MOVZ  X21, #0xd202, LSL #0
    MOVK  X21, #0x8886, LSL #16
    MOVK  X21, #0x2d58, LSL #32
    MOVK  X21, #0x246f, LSL #48
    MOVZ  X22, #0x2a72, LSL #0
    MOVK  X22, #0xbc3e, LSL #16
    MOVK  X22, #0x6a28, LSL #32
    MOVK  X22, #0xa8a3, LSL #48
    MOVZ  X23, #0x9e33, LSL #0
    MOVK  X23, #0x7c93, LSL #16
    MOVK  X23, #0x7516, LSL #32
    MOVK  X23, #0x4fef, LSL #48
    MOVZ  X24, #0x7082, LSL #0
    MOVK  X24, #0xf9f2, LSL #16
    MOVK  X24, #0x9175, LSL #32
    MOVK  X24, #0x3e3c, LSL #48
    MOVZ  X25, #0x1f1f, LSL #0
    MOVK  X25, #0x1a4b, LSL #16
    MOVK  X25, #0xd28a, LSL #32
    MOVK  X25, #0x14c7, LSL #48
    MOVZ  X26, #0x1f02, LSL #0
    MOVK  X26, #0x712c, LSL #16
    MOVK  X26, #0xbe5b, LSL #32
    MOVK  X26, #0xb0cc, LSL #48
    MOVZ  X27, #0xe6a4, LSL #0
    MOVK  X27, #0xf215, LSL #16
    MOVK  X27, #0x9331, LSL #32
    MOVK  X27, #0xf37, LSL #48
    MOVZ  X28, #0xcbef, LSL #0
    MOVK  X28, #0x1f57, LSL #16
    MOVK  X28, #0xc98a, LSL #32
    MOVK  X28, #0x2d1d, LSL #48
    MOVZ  X29, #0xc14c, LSL #0
    MOVK  X29, #0xc0d0, LSL #16
    MOVK  X29, #0x139, LSL #32
    MOVK  X29, #0x5fe1, LSL #48
    FMOV  D0, X2
    FMOV  V0.D[1], X25
    FMOV  D1, X12
    FMOV  V1.D[1], X10
    FMOV  D2, X10
    FMOV  V2.D[1], X2
    FMOV  D3, X5
    FMOV  V3.D[1], X4
    FMOV  D4, X3
    FMOV  V4.D[1], X20
    FMOV  D5, X13
    FMOV  V5.D[1], X13
    FMOV  D6, X21
    FMOV  V6.D[1], X18
    FMOV  D7, X27
    FMOV  V7.D[1], X14
    FMOV  D8, X29
    FMOV  V8.D[1], X19
    FMOV  D9, X5
    FMOV  V9.D[1], X7
    FMOV  D10, X21
    FMOV  V10.D[1], X10
    FMOV  D11, X24
    FMOV  V11.D[1], X7
    FMOV  D12, X16
    FMOV  V12.D[1], X4
    FMOV  D13, X19
    FMOV  V13.D[1], X9
    FMOV  D14, X27
    FMOV  V14.D[1], X12
    FMOV  D15, X10
    FMOV  V15.D[1], X25
    FMOV  D16, X7
    FMOV  V16.D[1], X8
    FMOV  D17, X19
    FMOV  V17.D[1], X16
    FMOV  D18, X4
    FMOV  V18.D[1], X5
    FMOV  D19, X9
    FMOV  V19.D[1], X2
    FMOV  D20, X8
    FMOV  V20.D[1], X16
    FMOV  D21, X27
    FMOV  V21.D[1], X4
    FMOV  D22, X24
    FMOV  V22.D[1], X11
    FMOV  D23, X20
    FMOV  V23.D[1], X5
    FMOV  D24, X13
    FMOV  V24.D[1], X29
    FMOV  D25, X20
    FMOV  V25.D[1], X9
    FMOV  D26, X13
    FMOV  V26.D[1], X19
    FMOV  D27, X29
    FMOV  V27.D[1], X23
    FMOV  D28, X25
    FMOV  V28.D[1], X7
    FMOV  D29, X25
    FMOV  V29.D[1], X23
    FMOV  D30, X24
    FMOV  V30.D[1], X8
    FMOV  D31, X2
    FMOV  V31.D[1], X23
    MOVZ  X13, #0xa, LSL #0
TaishanSimdCryptoP01_label_0:
    ZIP2  V24.8H, V30.8H, V27.8H
    EXT  V16.8B, V21.8B, V3.8B, #0x1
    UZP2  V0.8H, V12.8H, V12.8H
    ZIP2  V16.2S, V24.2S, V23.2S
    ZIP1  V0.8H, V28.8H, V2.8H
    EXT  V17.8B, V14.8B, V21.8B, #0x7
    EXT  V29.8B, V6.8B, V26.8B, #0x4
    ZIP1  V29.8H, V17.8H, V2.8H
    EXT  V6.8B, V1.8B, V31.8B, #0x5
    EXT  V22.8B, V17.8B, V27.8B, #0x0
    ZIP1  V29.16B, V0.16B, V26.16B
    TRN2  V22.4H, V26.4H, V27.4H
    TRN1  V2.8B, V12.8B, V1.8B
    EXT  V24.8B, V7.8B, V26.8B, #0x6
    UZP1  V17.8B, V2.8B, V26.8B
    UZP2  V2.4S, V0.4S, V31.4S
    ZIP1  V20.8B, V3.8B, V19.8B
    UZP2  V23.16B, V7.16B, V17.16B
    ZIP1  V14.4S, V7.4S, V18.4S
    ZIP1  V17.2S, V28.2S, V0.2S
    UZP1  V30.4S, V2.4S, V16.4S
    TRN1  V0.2S, V7.2S, V25.2S
    EXT  V1.16B, V28.16B, V24.16B, #0xa
    TRN2  V2.8B, V23.8B, V26.8B
    EXT  V26.16B, V14.16B, V21.16B, #0x6
    ZIP2  V16.8B, V8.8B, V29.8B
    ZIP2  V22.4S, V27.4S, V14.4S
    TRN2  V2.8B, V25.8B, V27.8B
    ZIP2  V11.4H, V3.4H, V30.4H
    EXT  V16.16B, V28.16B, V1.16B, #0x0
    EXT  V20.16B, V17.16B, V16.16B, #0x5
    UZP2  V29.8B, V25.8B, V28.8B
    UZP2  V23.2D, V30.2D, V9.2D
    ZIP1  V20.8H, V4.8H, V1.8H
    ZIP1  V18.8H, V27.8H, V26.8H
    TRN2  V26.16B, V23.16B, V6.16B
    ZIP2  V29.8B, V13.8B, V20.8B
    ZIP2  V22.4H, V18.4H, V30.4H
    ZIP1  V18.8H, V25.8H, V1.8H
    TRN2  V0.16B, V9.16B, V23.16B
    TRN2  V11.2S, V24.2S, V18.2S
    ZIP1  V31.2S, V13.2S, V29.2S
    EXT  V2.16B, V5.16B, V12.16B, #0x7
    UZP1  V18.8B, V11.8B, V3.8B
    TRN1  V8.2S, V12.2S, V14.2S
    EXT  V6.16B, V15.16B, V29.16B, #0x5
    EXT  V12.16B, V6.16B, V24.16B, #0xf
    EXT  V10.16B, V8.16B, V26.16B, #0x9
    ZIP2  V4.4H, V1.4H, V29.4H
    EXT  V27.16B, V4.16B, V15.16B, #0xd
    ZIP2  V30.2S, V7.2S, V24.2S
    UZP1  V3.2S, V1.2S, V1.2S
    ZIP1  V28.2D, V11.2D, V5.2D
    EXT  V7.16B, V31.16B, V6.16B, #0xe
    EXT  V3.8B, V7.8B, V1.8B, #0x4
    EXT  V18.8B, V28.8B, V3.8B, #0x3
    UZP1  V3.8B, V5.8B, V27.8B
    ZIP1  V23.2D, V30.2D, V11.2D
    UZP1  V1.4H, V7.4H, V5.4H
    UZP1  V24.2D, V1.2D, V19.2D
    TRN1  V9.8B, V28.8B, V0.8B
    UZP2  V8.4S, V13.4S, V10.4S
    TRN1  V27.4S, V20.4S, V18.4S
    ZIP2  V23.4S, V10.4S, V20.4S
    TRN1  V13.2S, V18.2S, V20.2S
    EXT  V14.16B, V18.16B, V20.16B, #0xa
    TRN2  V9.2D, V12.2D, V1.2D
    TRN1  V0.8H, V0.8H, V6.8H
    TRN2  V14.4H, V6.4H, V19.4H
    UZP2  V12.2S, V5.2S, V31.2S
    ZIP1  V0.4S, V10.4S, V13.4S
    EXT  V3.8B, V0.8B, V17.8B, #0x0
    ZIP1  V1.16B, V12.16B, V1.16B
    EXT  V30.8B, V23.8B, V25.8B, #0x6
    ZIP2  V17.2S, V1.2S, V3.2S
    TRN2  V24.16B, V0.16B, V23.16B
    UZP1  V24.4S, V18.4S, V28.4S
    TRN1  V21.4H, V17.4H, V12.4H
    ZIP1  V23.8B, V15.8B, V7.8B
    UZP2  V0.8H, V13.8H, V2.8H
    ZIP2  V19.4S, V3.4S, V27.4S
    ZIP1  V21.4H, V9.4H, V19.4H
    ZIP2  V3.8H, V30.8H, V7.8H
    UZP1  V10.8H, V19.8H, V27.8H
    ZIP1  V8.16B, V12.16B, V27.16B
    EXT  V3.16B, V18.16B, V18.16B, #0x0
    EXT  V9.16B, V27.16B, V7.16B, #0xd
    UZP1  V2.2D, V7.2D, V25.2D
    EXT  V17.16B, V1.16B, V15.16B, #0x6
    EXT  V8.8B, V14.8B, V1.8B, #0x7
    EXT  V14.8B, V20.8B, V28.8B, #0x2
    ZIP1  V4.4H, V8.4H, V5.4H
    EXT  V12.8B, V20.8B, V2.8B, #0x4
    TRN2  V0.2S, V2.2S, V23.2S
    EXT  V2.8B, V11.8B, V19.8B, #0x5
    ZIP1  V1.2D, V29.2D, V2.2D
    TRN2  V8.4H, V13.4H, V24.4H
    UZP1  V28.2S, V9.2S, V25.2S
    EXT  V26.8B, V12.8B, V9.8B, #0x6
    UZP1  V3.2D, V7.2D, V17.2D
    TRN1  V28.4H, V31.4H, V20.4H
    TRN2  V14.4H, V8.4H, V14.4H
    EXT  V21.16B, V13.16B, V20.16B, #0xf
    TRN1  V30.8H, V28.8H, V15.8H
    EXT  V31.16B, V30.16B, V20.16B, #0x6
    ZIP2  V12.16B, V8.16B, V31.16B
    ZIP1  V12.4S, V21.4S, V18.4S
    TRN1  V0.2D, V26.2D, V18.2D
    TRN2  V23.16B, V3.16B, V1.16B
    EXT  V25.16B, V23.16B, V30.16B, #0xa
    UZP1  V17.8B, V13.8B, V21.8B
    UZP1  V4.2S, V30.2S, V4.2S
    TRN2  V30.2S, V30.2S, V11.2S
    TRN2  V24.8H, V10.8H, V11.8H
    TRN2  V17.4H, V13.4H, V21.4H
    EXT  V13.8B, V1.8B, V20.8B, #0x0
    TRN2  V30.4H, V29.4H, V21.4H
    ZIP2  V1.4H, V14.4H, V0.4H
    TRN1  V13.4H, V9.4H, V4.4H
    ZIP1  V2.8B, V11.8B, V24.8B
    EXT  V24.8B, V17.8B, V22.8B, #0x4
    ZIP1  V30.8H, V18.8H, V18.8H
    ZIP2  V22.4H, V29.4H, V6.4H
    EXT  V1.8B, V24.8B, V1.8B, #0x4
    UZP2  V30.2D, V23.2D, V1.2D
    UZP1  V6.8B, V21.8B, V25.8B
    ZIP2  V23.16B, V19.16B, V22.16B
    ZIP2  V10.4S, V30.4S, V12.4S
    UZP1  V15.8H, V28.8H, V17.8H
    EXT  V21.16B, V18.16B, V4.16B, #0x6
    TRN1  V20.4S, V9.4S, V17.4S
    EXT  V0.8B, V26.8B, V23.8B, #0x2
    TRN2  V10.4S, V18.4S, V12.4S
    EXT  V3.16B, V18.16B, V17.16B, #0x6
    UZP2  V29.16B, V30.16B, V17.16B
    TRN1  V30.2D, V31.2D, V31.2D
    EXT  V3.16B, V1.16B, V23.16B, #0x2
    UZP1  V4.4S, V17.4S, V10.4S
    TRN2  V24.4H, V0.4H, V25.4H
    TRN2  V7.4S, V27.4S, V20.4S
    EXT  V18.16B, V12.16B, V8.16B, #0x9
    UZP2  V8.2D, V17.2D, V7.2D
    UZP2  V4.4H, V28.4H, V28.4H
    EXT  V4.16B, V12.16B, V20.16B, #0xb
    TRN2  V14.8H, V4.8H, V2.8H
    EXT  V28.8B, V21.8B, V18.8B, #0x4
    UZP1  V13.8B, V31.8B, V10.8B
    EXT  V2.16B, V1.16B, V22.16B, #0x6
    EXT  V15.8B, V14.8B, V26.8B, #0x1
    TRN1  V7.16B, V8.16B, V3.16B
    EXT  V5.8B, V7.8B, V10.8B, #0x4
    ZIP1  V30.8B, V14.8B, V2.8B
    TRN1  V20.8H, V13.8H, V4.8H
    ZIP1  V21.2D, V31.2D, V10.2D
    EXT  V31.8B, V4.8B, V26.8B, #0x6
    EXT  V25.8B, V24.8B, V18.8B, #0x2
    EXT  V12.16B, V0.16B, V10.16B, #0x0
    TRN1  V20.8H, V25.8H, V31.8H
    UZP2  V29.4S, V0.4S, V1.4S
    ZIP2  V21.8B, V25.8B, V28.8B
    ZIP2  V26.8B, V26.8B, V10.8B
    ZIP2  V2.8B, V26.8B, V31.8B
    ZIP1  V29.8B, V30.8B, V23.8B
    UZP1  V1.16B, V29.16B, V11.16B
    UZP2  V24.2D, V15.2D, V22.2D
    EXT  V5.16B, V0.16B, V28.16B, #0x4
    EXT  V3.8B, V27.8B, V10.8B, #0x1
    TRN1  V27.2S, V1.2S, V21.2S
    EXT  V2.8B, V18.8B, V27.8B, #0x2
    ZIP2  V25.8B, V18.8B, V0.8B
    UZP1  V14.8H, V16.8H, V24.8H
    EXT  V23.8B, V11.8B, V8.8B, #0x7
    ZIP2  V16.8H, V2.8H, V25.8H
    TRN1  V30.4H, V27.4H, V21.4H
    EXT  V28.8B, V11.8B, V30.8B, #0x2
    TRN2  V22.2D, V9.2D, V27.2D
    TRN2  V27.16B, V20.16B, V19.16B
    EXT  V16.8B, V0.8B, V22.8B, #0x6
    UZP2  V29.16B, V5.16B, V1.16B
    ZIP2  V11.16B, V8.16B, V21.16B
    ZIP1  V6.8H, V7.8H, V23.8H
    TRN1  V16.4S, V31.4S, V6.4S
    TRN2  V23.8H, V2.8H, V25.8H
    TRN2  V27.4S, V28.4S, V28.4S
    EXT  V29.8B, V3.8B, V30.8B, #0x0
    TRN1  V18.16B, V9.16B, V30.16B
    TRN2  V19.8H, V6.8H, V12.8H
    TRN2  V0.2D, V7.2D, V20.2D
    ZIP2  V5.4S, V24.4S, V3.4S
    TRN2  V10.16B, V19.16B, V30.16B
    TRN1  V17.4H, V23.4H, V19.4H
    ZIP2  V0.4S, V31.4S, V16.4S
    TRN2  V5.8H, V30.8H, V13.8H
    ZIP1  V10.2S, V11.2S, V22.2S
    EXT  V8.8B, V16.8B, V30.8B, #0x7
    UZP2  V8.8B, V0.8B, V16.8B
    TRN2  V4.4S, V20.4S, V31.4S
    ZIP1  V14.2S, V23.2S, V19.2S
    ZIP2  V15.2D, V17.2D, V20.2D
    TRN1  V16.2S, V10.2S, V18.2S
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdCryptoP01_label_0
    MOVZ  X25, #0xfe2c, LSL #0
    MOVK  X25, #0xe575, LSL #16
    MOVK  X25, #0xcba0, LSL #32
    MOVK  X25, #0xc62b, LSL #48
    SUB  X17, X25, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x62b1, LSL #0
    MOVK  X12, #0xc2c5, LSL #16
    MOVK  X12, #0xd83c, LSL #32
    MOVK  X12, #0x8109, LSL #48
    SUB  X11, X12, X3
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x8e1d, LSL #0
    MOVK  X29, #0x208f, LSL #16
    MOVK  X29, #0xc9bc, LSL #32
    MOVK  X29, #0x3018, LSL #48
    SUB  X17, X29, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x2031, LSL #0
    MOVK  X20, #0xdbf5, LSL #16
    MOVK  X20, #0xaeb6, LSL #32
    MOVK  X20, #0xfcb1, LSL #48
    SUB  X18, X20, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0xd974, LSL #0
    MOVK  X21, #0x16b5, LSL #16
    MOVK  X21, #0xa2, LSL #32
    MOVK  X21, #0x86a1, LSL #48
    SUB  X29, X21, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0xecef, LSL #0
    MOVK  X2, #0xcec3, LSL #16
    MOVK  X2, #0xaf06, LSL #32
    MOVK  X2, #0x9d3e, LSL #48
    SUB  X9, X2, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x42df, LSL #0
    MOVK  X25, #0xf249, LSL #16
    MOVK  X25, #0x193f, LSL #32
    MOVK  X25, #0xfd4d, LSL #48
    SUB  X14, X25, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xa680, LSL #0
    MOVK  X5, #0xaf64, LSL #16
    MOVK  X5, #0x6bfc, LSL #32
    MOVK  X5, #0xa83e, LSL #48
    SUB  X13, X5, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X11
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0xfb3b, LSL #0
    MOVK  X25, #0xcf66, LSL #16
    MOVK  X25, #0x3b58, LSL #32
    MOVK  X25, #0x19e4, LSL #48
    SUB  X3, X25, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X3, X17, X17
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X18
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X13, X9, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x2031, LSL #0
    MOVK  X3, #0xdbf5, LSL #16
    MOVK  X3, #0xaeb6, LSL #32
    MOVK  X3, #0xfcb1, LSL #48
    SUB  X5, X3, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0xd974, LSL #0
    MOVK  X17, #0x16b5, LSL #16
    MOVK  X17, #0xa2, LSL #32
    MOVK  X17, #0x86a1, LSL #48
    SUB  X21, X17, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0x2a72, LSL #0
    MOVK  X23, #0xbc3e, LSL #16
    MOVK  X23, #0x6a28, LSL #32
    MOVK  X23, #0xa8a3, LSL #48
    SUB  X16, X23, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x2a72, LSL #0
    MOVK  X13, #0xbc3e, LSL #16
    MOVK  X13, #0x6a28, LSL #32
    MOVK  X13, #0xa8a3, LSL #48
    SUB  X4, X13, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x7082, LSL #0
    MOVK  X6, #0xf9f2, LSL #16
    MOVK  X6, #0x9175, LSL #32
    MOVK  X6, #0x3e3c, LSL #48
    SUB  X25, X6, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X25
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x1f02, LSL #0
    MOVK  X21, #0x712c, LSL #16
    MOVK  X21, #0xbe5b, LSL #32
    MOVK  X21, #0xb0cc, LSL #48
    SUB  X10, X21, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0xcbef, LSL #0
    MOVK  X2, #0x1f57, LSL #16
    MOVK  X2, #0xc98a, LSL #32
    MOVK  X2, #0x2d1d, LSL #48
    SUB  X22, X2, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D2
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D4
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D5
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X26
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D6
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D9
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X24
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D10
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D12
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D13
    MOVZ  X3, #0x0, LSL #0
    SUB  X10, X3, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X22
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D17
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X3
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D20
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D21
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X10
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D23
    MOVZ  X9, #0x0, LSL #0
    SUB  X17, X9, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D25
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D26
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D27
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D28
    MOVZ  X25, #0x0, LSL #0
    SUB  X23, X25, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D29
    MOVZ  X21, #0x0, LSL #0
    SUB  X17, X21, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X21
    FMOV  V0.D[1], X4
    FMOV  D1, X11
    FMOV  V1.D[1], X22
    FMOV  D2, X5
    FMOV  V2.D[1], X28
    FMOV  D3, X4
    FMOV  V3.D[1], X24
    FMOV  D4, X26
    FMOV  V4.D[1], X19
    FMOV  D5, X23
    FMOV  V5.D[1], X29
    FMOV  D6, X18
    FMOV  V6.D[1], X3
    FMOV  D7, X16
    FMOV  V7.D[1], X17
    FMOV  D8, X14
    FMOV  V8.D[1], X18
    FMOV  D9, X13
    FMOV  V9.D[1], X18
    FMOV  D10, X9
    FMOV  V10.D[1], X19
    FMOV  D11, X18
    FMOV  V11.D[1], X5
    FMOV  D12, X12
    FMOV  V12.D[1], X25
    FMOV  D13, X29
    FMOV  V13.D[1], X7
    FMOV  D14, X9
    FMOV  V14.D[1], X20
    FMOV  D15, X14
    FMOV  V15.D[1], X4
    FMOV  D16, X9
    FMOV  V16.D[1], X12
    FMOV  D17, X16
    FMOV  V17.D[1], X6
    FMOV  D18, X24
    FMOV  V18.D[1], X9
    FMOV  D19, X14
    FMOV  V19.D[1], X13
    FMOV  D20, X7
    FMOV  V20.D[1], X13
    FMOV  D21, X20
    FMOV  V21.D[1], X17
    FMOV  D22, X11
    FMOV  V22.D[1], X20
    FMOV  D23, X4
    FMOV  V23.D[1], X4
    FMOV  D24, X22
    FMOV  V24.D[1], X25
    FMOV  D25, X7
    FMOV  V25.D[1], X28
    FMOV  D26, X3
    FMOV  V26.D[1], X10
    FMOV  D27, X16
    FMOV  V27.D[1], X25
    FMOV  D28, X26
    FMOV  V28.D[1], X22
    FMOV  D29, X22
    FMOV  V29.D[1], X24
    FMOV  D30, X27
    FMOV  V30.D[1], X10
    FMOV  D31, X11
    FMOV  V31.D[1], X26
    MOVZ  X24, #0xa, LSL #0
TaishanSimdCryptoP01_label_82:
    EXT  V11.8B, V7.8B, V26.8B, #0x3
    ZIP2  V23.4S, V23.4S, V28.4S
    EXT  V28.8B, V8.8B, V25.8B, #0x1
    ZIP1  V30.8H, V12.8H, V1.8H
    UZP1  V10.4S, V7.4S, V30.4S
    UZP2  V27.4S, V21.4S, V17.4S
    UZP2  V19.16B, V1.16B, V7.16B
    UZP1  V15.16B, V28.16B, V4.16B
    ZIP1  V9.16B, V3.16B, V6.16B
    TRN1  V19.8H, V21.8H, V20.8H
    ZIP2  V27.2S, V23.2S, V28.2S
    TRN2  V9.4S, V4.4S, V19.4S
    UZP1  V3.4H, V31.4H, V1.4H
    TRN1  V10.8B, V15.8B, V14.8B
    EXT  V6.8B, V11.8B, V9.8B, #0x4
    ZIP1  V15.4H, V12.4H, V0.4H
    ZIP2  V12.4H, V4.4H, V7.4H
    TRN1  V13.4H, V16.4H, V17.4H
    ZIP1  V17.4H, V17.4H, V2.4H
    TRN1  V3.8B, V25.8B, V19.8B
    TRN1  V2.2S, V19.2S, V16.2S
    EXT  V13.8B, V0.8B, V20.8B, #0x1
    UZP2  V15.4S, V10.4S, V3.4S
    ZIP2  V15.2D, V16.2D, V30.2D
    ZIP2  V30.16B, V21.16B, V27.16B
    ZIP1  V28.2D, V6.2D, V26.2D
    EXT  V7.8B, V16.8B, V14.8B, #0x7
    TRN2  V7.2S, V11.2S, V12.2S
    TRN1  V21.2S, V4.2S, V21.2S
    UZP2  V7.4S, V17.4S, V12.4S
    TRN1  V22.2D, V27.2D, V10.2D
    ZIP2  V20.2S, V4.2S, V10.2S
    TRN1  V28.8H, V7.8H, V9.8H
    TRN1  V31.4S, V7.4S, V2.4S
    ZIP2  V30.8H, V13.8H, V6.8H
    ZIP1  V9.2S, V9.2S, V1.2S
    EXT  V4.16B, V16.16B, V13.16B, #0x6
    ZIP2  V26.2S, V1.2S, V7.2S
    EXT  V18.8B, V24.8B, V6.8B, #0x1
    EXT  V30.8B, V22.8B, V1.8B, #0x2
    ZIP2  V26.8B, V21.8B, V25.8B
    TRN2  V31.2S, V4.2S, V15.2S
    ZIP2  V14.8B, V27.8B, V21.8B
    ZIP2  V28.4S, V24.4S, V29.4S
    EXT  V12.16B, V23.16B, V20.16B, #0x0
    ZIP2  V28.2D, V0.2D, V7.2D
    EXT  V26.8B, V0.8B, V8.8B, #0x6
    ZIP2  V31.2D, V18.2D, V7.2D
    EXT  V2.8B, V18.8B, V21.8B, #0x5
    TRN1  V10.8B, V10.8B, V10.8B
    UZP1  V24.2D, V15.2D, V2.2D
    TRN2  V21.2S, V15.2S, V31.2S
    UZP2  V13.8B, V19.8B, V6.8B
    UZP1  V4.8H, V1.8H, V26.8H
    ZIP2  V30.8B, V27.8B, V19.8B
    UZP1  V25.4H, V30.4H, V18.4H
    EXT  V10.8B, V8.8B, V22.8B, #0x4
    EXT  V14.8B, V14.8B, V29.8B, #0x0
    TRN1  V6.8B, V7.8B, V14.8B
    EXT  V19.16B, V1.16B, V13.16B, #0x8
    TRN2  V11.16B, V23.16B, V5.16B
    ZIP2  V13.16B, V9.16B, V15.16B
    UZP2  V19.8B, V25.8B, V26.8B
    ZIP1  V26.4H, V12.4H, V14.4H
    ZIP2  V19.4H, V30.4H, V27.4H
    EXT  V1.8B, V23.8B, V0.8B, #0x7
    UZP2  V24.2D, V22.2D, V15.2D
    EXT  V28.8B, V5.8B, V17.8B, #0x7
    ZIP2  V19.4H, V26.4H, V10.4H
    UZP1  V14.8H, V30.8H, V26.8H
    UZP1  V19.2D, V16.2D, V13.2D
    TRN1  V5.16B, V19.16B, V23.16B
    EXT  V28.8B, V8.8B, V28.8B, #0x1
    UZP2  V14.8B, V19.8B, V7.8B
    EXT  V5.8B, V10.8B, V2.8B, #0x4
    TRN1  V22.2D, V9.2D, V26.2D
    TRN1  V29.4S, V0.4S, V30.4S
    EXT  V14.16B, V18.16B, V29.16B, #0xf
    TRN2  V5.2D, V22.2D, V17.2D
    UZP1  V6.2S, V1.2S, V24.2S
    ZIP1  V2.8H, V20.8H, V18.8H
    EXT  V12.8B, V22.8B, V0.8B, #0x5
    UZP2  V3.4H, V5.4H, V9.4H
    TRN2  V28.2S, V25.2S, V2.2S
    EXT  V3.8B, V16.8B, V5.8B, #0x1
    ZIP1  V14.2D, V11.2D, V11.2D
    ZIP2  V29.4H, V14.4H, V24.4H
    UZP2  V22.4S, V3.4S, V12.4S
    UZP2  V6.4H, V29.4H, V13.4H
    EXT  V30.8B, V11.8B, V23.8B, #0x6
    EXT  V2.16B, V31.16B, V17.16B, #0xb
    TRN2  V13.4S, V18.4S, V26.4S
    EXT  V30.16B, V3.16B, V0.16B, #0xc
    TRN2  V8.16B, V2.16B, V7.16B
    EXT  V25.8B, V28.8B, V1.8B, #0x0
    EXT  V25.8B, V16.8B, V3.8B, #0x3
    TRN2  V6.2D, V30.2D, V9.2D
    TRN1  V8.2S, V18.2S, V1.2S
    TRN1  V2.16B, V17.16B, V26.16B
    EXT  V13.16B, V29.16B, V8.16B, #0x2
    UZP2  V8.16B, V31.16B, V20.16B
    UZP1  V16.4S, V0.4S, V26.4S
    EXT  V21.16B, V17.16B, V23.16B, #0xe
    EXT  V24.8B, V13.8B, V14.8B, #0x5
    UZP2  V6.8B, V28.8B, V9.8B
    ZIP1  V8.16B, V24.16B, V29.16B
    UZP1  V10.4H, V19.4H, V1.4H
    EXT  V13.8B, V1.8B, V31.8B, #0x1
    TRN1  V18.8H, V27.8H, V25.8H
    ZIP2  V9.2S, V1.2S, V24.2S
    EXT  V2.16B, V26.16B, V6.16B, #0xb
    ZIP1  V21.16B, V31.16B, V9.16B
    UZP2  V21.4S, V3.4S, V18.4S
    UZP2  V6.4S, V24.4S, V11.4S
    TRN1  V31.2S, V1.2S, V20.2S
    UZP1  V25.4S, V22.4S, V4.4S
    TRN2  V27.2S, V12.2S, V13.2S
    TRN2  V11.2S, V0.2S, V7.2S
    TRN1  V1.16B, V30.16B, V18.16B
    TRN1  V8.16B, V3.16B, V5.16B
    EXT  V21.16B, V17.16B, V31.16B, #0x8
    ZIP2  V14.8H, V7.8H, V5.8H
    UZP1  V0.16B, V16.16B, V25.16B
    UZP1  V17.8H, V28.8H, V21.8H
    EXT  V17.8B, V12.8B, V26.8B, #0x4
    TRN2  V5.2D, V0.2D, V26.2D
    ZIP1  V31.2D, V3.2D, V16.2D
    EXT  V29.16B, V21.16B, V17.16B, #0x4
    EXT  V9.8B, V21.8B, V6.8B, #0x7
    EXT  V2.8B, V18.8B, V31.8B, #0x2
    ZIP1  V6.16B, V18.16B, V1.16B
    ZIP1  V31.16B, V15.16B, V26.16B
    UZP1  V14.4S, V21.4S, V12.4S
    UZP1  V2.4S, V9.4S, V12.4S
    TRN1  V10.8H, V31.8H, V24.8H
    UZP2  V0.8B, V7.8B, V6.8B
    UZP2  V7.16B, V21.16B, V20.16B
    EXT  V16.8B, V26.8B, V28.8B, #0x5
    TRN1  V24.8B, V29.8B, V16.8B
    TRN1  V5.8B, V16.8B, V2.8B
    EXT  V9.16B, V0.16B, V1.16B, #0x7
    UZP2  V16.2D, V18.2D, V10.2D
    EXT  V13.8B, V25.8B, V14.8B, #0x3
    EXT  V23.16B, V29.16B, V10.16B, #0x3
    EXT  V24.8B, V2.8B, V6.8B, #0x5
    UZP2  V18.2D, V16.2D, V10.2D
    EXT  V3.8B, V5.8B, V20.8B, #0x5
    TRN1  V7.16B, V3.16B, V8.16B
    TRN1  V1.4S, V29.4S, V13.4S
    EXT  V23.16B, V21.16B, V23.16B, #0xf
    UZP2  V24.2D, V18.2D, V9.2D
    EXT  V24.16B, V10.16B, V4.16B, #0x0
    EXT  V3.8B, V6.8B, V11.8B, #0x1
    EXT  V13.16B, V24.16B, V9.16B, #0x9
    UZP2  V31.8H, V15.8H, V31.8H
    TRN2  V25.16B, V9.16B, V28.16B
    UZP1  V13.2S, V7.2S, V3.2S
    ZIP1  V31.2S, V17.2S, V29.2S
    UZP2  V5.2D, V2.2D, V19.2D
    ZIP1  V10.8H, V13.8H, V7.8H
    ZIP1  V5.2D, V24.2D, V1.2D
    EXT  V0.16B, V7.16B, V10.16B, #0x4
    TRN1  V14.2S, V10.2S, V18.2S
    UZP2  V3.2S, V15.2S, V0.2S
    UZP2  V9.2D, V5.2D, V23.2D
    UZP2  V0.8H, V15.8H, V9.8H
    ZIP1  V30.16B, V2.16B, V8.16B
    UZP2  V30.8H, V8.8H, V20.8H
    EXT  V26.16B, V1.16B, V5.16B, #0x8
    TRN1  V16.16B, V30.16B, V11.16B
    TRN2  V16.2S, V28.2S, V26.2S
    ZIP2  V20.8H, V22.8H, V7.8H
    TRN2  V28.2S, V1.2S, V23.2S
    UZP1  V26.8B, V17.8B, V17.8B
    UZP2  V30.8H, V1.8H, V3.8H
    ZIP1  V23.2S, V31.2S, V26.2S
    TRN1  V17.2S, V18.2S, V12.2S
    EXT  V12.16B, V27.16B, V9.16B, #0xc
    UZP1  V0.4S, V5.4S, V9.4S
    ZIP1  V16.16B, V23.16B, V13.16B
    EXT  V30.8B, V22.8B, V10.8B, #0x0
    UZP2  V17.8B, V12.8B, V20.8B
    EXT  V23.8B, V6.8B, V26.8B, #0x4
    ZIP1  V24.8H, V7.8H, V0.8H
    TRN2  V19.2S, V17.2S, V16.2S
    UZP2  V7.8H, V19.8H, V15.8H
    TRN2  V1.4S, V12.4S, V9.4S
    TRN2  V30.2D, V14.2D, V23.2D
    ZIP1  V12.16B, V27.16B, V28.16B
    UZP1  V1.2D, V13.2D, V19.2D
    ZIP1  V30.2S, V14.2S, V2.2S
    UZP1  V17.4S, V31.4S, V3.4S
    EXT  V8.16B, V1.16B, V18.16B, #0x1
    ZIP2  V8.4S, V29.4S, V16.4S
    UZP2  V17.2S, V21.2S, V30.2S
    TRN1  V30.2D, V10.2D, V6.2D
    TRN2  V19.2D, V0.2D, V26.2D
    EXT  V16.16B, V26.16B, V31.16B, #0xc
    TRN1  V14.4H, V29.4H, V24.4H
    EXT  V18.16B, V16.16B, V14.16B, #0xf
    SUBS  X24, X24, #0x1
    B.NE  TaishanSimdCryptoP01_label_82
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X3
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X4
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X17, X14, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X13, X4, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X20, X10, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X10
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X11
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X11, X25, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X14, X7, X16
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X17
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X11, X24, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X29, X10, X20
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X26, X2, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X13, X14, X25
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X21, X5, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D2
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X11
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D4
    MOVZ  X17, #0x0, LSL #0
    SUB  X14, X17, X5
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D6
    MOVZ  X8, #0x0, LSL #0
    SUB  X11, X8, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D7
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X17
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D13
    MOVZ  X17, #0x0, LSL #0
    SUB  X21, X17, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X12
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D17
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X25
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X17
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D20
    MOVZ  X21, #0x0, LSL #0
    SUB  X7, X21, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D22
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D23
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X3
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X16
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X13
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D28
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D29
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X8
    FMOV  V0.D[1], X7
    FMOV  D1, X29
    FMOV  V1.D[1], X20
    FMOV  D2, X8
    FMOV  V2.D[1], X10
    FMOV  D3, X17
    FMOV  V3.D[1], X10
    FMOV  D4, X28
    FMOV  V4.D[1], X27
    FMOV  D5, X27
    FMOV  V5.D[1], X21
    FMOV  D6, X21
    FMOV  V6.D[1], X3
    FMOV  D7, X18
    FMOV  V7.D[1], X29
    FMOV  D8, X17
    FMOV  V8.D[1], X7
    FMOV  D9, X23
    FMOV  V9.D[1], X29
    FMOV  D10, X13
    FMOV  V10.D[1], X8
    FMOV  D11, X12
    FMOV  V11.D[1], X13
    FMOV  D12, X28
    FMOV  V12.D[1], X22
    FMOV  D13, X28
    FMOV  V13.D[1], X13
    FMOV  D14, X26
    FMOV  V14.D[1], X13
    FMOV  D15, X26
    FMOV  V15.D[1], X26
    FMOV  D16, X27
    FMOV  V16.D[1], X22
    FMOV  D17, X14
    FMOV  V17.D[1], X14
    FMOV  D18, X5
    FMOV  V18.D[1], X5
    FMOV  D19, X8
    FMOV  V19.D[1], X4
    FMOV  D20, X29
    FMOV  V20.D[1], X26
    FMOV  D21, X16
    FMOV  V21.D[1], X21
    FMOV  D22, X6
    FMOV  V22.D[1], X21
    FMOV  D23, X16
    FMOV  V23.D[1], X4
    FMOV  D24, X24
    FMOV  V24.D[1], X4
    FMOV  D25, X24
    FMOV  V25.D[1], X18
    FMOV  D26, X19
    FMOV  V26.D[1], X27
    FMOV  D27, X22
    FMOV  V27.D[1], X23
    FMOV  D28, X3
    FMOV  V28.D[1], X9
    FMOV  D29, X19
    FMOV  V29.D[1], X5
    FMOV  D30, X29
    FMOV  V30.D[1], X16
    FMOV  D31, X10
    FMOV  V31.D[1], X14
    MOVZ  X3, #0xf, LSL #0
TaishanSimdCryptoP01_label_165:
    TRN2  V15.4H, V31.4H, V29.4H
    TRN2  V28.8B, V31.8B, V10.8B
    UZP2  V7.4S, V1.4S, V10.4S
    UZP1  V4.4S, V3.4S, V28.4S
    ZIP2  V0.2S, V18.2S, V24.2S
    TRN1  V22.4S, V28.4S, V31.4S
    UZP2  V27.2S, V19.2S, V17.2S
    ZIP1  V20.4S, V26.4S, V15.4S
    EXT  V24.16B, V20.16B, V7.16B, #0x5
    ZIP2  V18.8B, V1.8B, V2.8B
    ZIP2  V21.8B, V0.8B, V16.8B
    EXT  V27.8B, V19.8B, V20.8B, #0x2
    EXT  V6.8B, V4.8B, V30.8B, #0x2
    UZP2  V25.8B, V30.8B, V22.8B
    UZP2  V30.2D, V29.2D, V10.2D
    TRN1  V30.2S, V8.2S, V3.2S
    UZP2  V19.2D, V30.2D, V20.2D
    TRN2  V27.4S, V13.4S, V19.4S
    UZP1  V13.8H, V21.8H, V7.8H
    UZP1  V7.16B, V29.16B, V25.16B
    UZP1  V1.8H, V21.8H, V6.8H
    ZIP1  V30.4H, V8.4H, V7.4H
    ZIP2  V18.4H, V18.4H, V15.4H
    UZP2  V26.4S, V29.4S, V30.4S
    UZP1  V15.16B, V24.16B, V6.16B
    ZIP2  V4.8B, V22.8B, V19.8B
    TRN2  V26.2D, V2.2D, V19.2D
    EXT  V3.8B, V21.8B, V8.8B, #0x3
    UZP2  V31.8H, V14.8H, V19.8H
    UZP2  V6.2S, V28.2S, V16.2S
    ZIP2  V8.2S, V4.2S, V15.2S
    TRN2  V8.4H, V6.4H, V10.4H
    UZP2  V14.4H, V25.4H, V17.4H
    UZP2  V22.4S, V15.4S, V30.4S
    ZIP2  V15.2D, V29.2D, V19.2D
    UZP1  V17.8H, V20.8H, V19.8H
    EXT  V11.16B, V27.16B, V2.16B, #0xc
    TRN1  V23.8H, V13.8H, V21.8H
    UZP1  V26.4S, V8.4S, V20.4S
    TRN1  V24.4H, V17.4H, V26.4H
    EXT  V17.8B, V26.8B, V15.8B, #0x3
    EXT  V14.16B, V13.16B, V18.16B, #0x3
    EXT  V15.16B, V20.16B, V2.16B, #0xf
    EXT  V21.8B, V3.8B, V12.8B, #0x2
    TRN2  V29.8H, V11.8H, V16.8H
    ZIP2  V13.16B, V30.16B, V21.16B
    ZIP2  V15.8H, V7.8H, V29.8H
    EXT  V2.16B, V29.16B, V30.16B, #0x0
    EXT  V18.16B, V11.16B, V15.16B, #0xa
    ZIP1  V9.4S, V10.4S, V31.4S
    TRN1  V24.4S, V30.4S, V13.4S
    TRN1  V19.2D, V8.2D, V10.2D
    EXT  V22.8B, V14.8B, V4.8B, #0x4
    EXT  V7.8B, V1.8B, V19.8B, #0x1
    ZIP2  V5.2S, V5.2S, V20.2S
    ZIP1  V7.2D, V22.2D, V21.2D
    ZIP2  V2.2S, V15.2S, V3.2S
    EXT  V31.16B, V2.16B, V5.16B, #0x9
    TRN1  V22.2D, V29.2D, V17.2D
    ZIP2  V26.16B, V22.16B, V19.16B
    EXT  V18.8B, V11.8B, V13.8B, #0x4
    UZP2  V20.2D, V30.2D, V12.2D
    EXT  V9.16B, V19.16B, V12.16B, #0xa
    ZIP1  V24.16B, V3.16B, V27.16B
    TRN2  V15.2S, V3.2S, V24.2S
    UZP1  V7.4H, V19.4H, V5.4H
    UZP1  V17.8B, V18.8B, V31.8B
    ZIP2  V6.2S, V25.2S, V20.2S
    ZIP2  V21.8H, V31.8H, V15.8H
    ZIP2  V7.8B, V11.8B, V13.8B
    EXT  V27.8B, V28.8B, V17.8B, #0x0
    UZP2  V17.2S, V26.2S, V30.2S
    ZIP1  V31.2D, V7.2D, V6.2D
    UZP2  V17.4S, V8.4S, V19.4S
    EXT  V24.8B, V17.8B, V2.8B, #0x1
    UZP2  V17.16B, V5.16B, V27.16B
    EXT  V31.8B, V20.8B, V6.8B, #0x4
    EXT  V3.8B, V2.8B, V3.8B, #0x0
    EXT  V2.16B, V31.16B, V31.16B, #0x5
    ZIP1  V24.4H, V30.4H, V24.4H
    ZIP2  V14.4H, V9.4H, V20.4H
    ZIP2  V30.4S, V3.4S, V3.4S
    ZIP1  V31.2S, V24.2S, V5.2S
    UZP2  V21.16B, V25.16B, V31.16B
    UZP2  V27.8H, V0.8H, V26.8H
    EXT  V30.16B, V27.16B, V18.16B, #0x0
    UZP2  V26.4S, V14.4S, V17.4S
    UZP1  V19.2S, V28.2S, V28.2S
    TRN2  V0.16B, V17.16B, V27.16B
    ZIP1  V8.4S, V5.4S, V23.4S
    TRN2  V10.16B, V17.16B, V23.16B
    TRN2  V28.8B, V10.8B, V30.8B
    ZIP2  V5.8B, V6.8B, V13.8B
    TRN2  V17.4S, V30.4S, V23.4S
    UZP2  V2.4H, V10.4H, V2.4H
    ZIP1  V18.2D, V11.2D, V17.2D
    EXT  V3.8B, V4.8B, V6.8B, #0x0
    TRN1  V13.4H, V3.4H, V8.4H
    ZIP2  V8.4S, V7.4S, V16.4S
    UZP2  V21.4S, V1.4S, V4.4S
    UZP2  V27.4H, V7.4H, V28.4H
    ZIP2  V21.16B, V20.16B, V0.16B
    UZP2  V8.4S, V16.4S, V25.4S
    ZIP1  V15.2S, V26.2S, V11.2S
    TRN1  V13.2S, V31.2S, V4.2S
    UZP2  V27.4S, V0.4S, V28.4S
    ZIP1  V18.4S, V30.4S, V23.4S
    ZIP2  V3.16B, V3.16B, V12.16B
    TRN1  V30.2D, V4.2D, V18.2D
    UZP1  V2.2D, V5.2D, V7.2D
    UZP1  V24.8B, V9.8B, V14.8B
    ZIP1  V0.2S, V19.2S, V26.2S
    ZIP1  V15.2D, V28.2D, V15.2D
    UZP1  V2.2S, V21.2S, V29.2S
    TRN2  V1.2S, V31.2S, V26.2S
    ZIP1  V5.2D, V30.2D, V0.2D
    ZIP2  V21.16B, V27.16B, V26.16B
    EXT  V20.8B, V16.8B, V22.8B, #0x4
    UZP2  V20.4S, V9.4S, V29.4S
    ZIP2  V2.4S, V17.4S, V8.4S
    ZIP1  V24.16B, V15.16B, V30.16B
    EXT  V20.16B, V16.16B, V13.16B, #0xe
    UZP2  V23.2S, V29.2S, V29.2S
    TRN2  V7.4H, V0.4H, V0.4H
    ZIP2  V20.4S, V7.4S, V28.4S
    ZIP2  V27.4S, V4.4S, V9.4S
    ZIP2  V17.8H, V30.8H, V31.8H
    UZP1  V31.8B, V23.8B, V7.8B
    TRN1  V1.2S, V14.2S, V11.2S
    ZIP2  V18.8H, V7.8H, V22.8H
    ZIP2  V30.2D, V4.2D, V0.2D
    UZP1  V18.16B, V10.16B, V19.16B
    TRN1  V18.2S, V23.2S, V11.2S
    ZIP2  V4.2S, V28.2S, V25.2S
    UZP2  V3.8H, V28.8H, V25.8H
    EXT  V5.8B, V31.8B, V25.8B, #0x2
    UZP2  V10.2S, V0.2S, V24.2S
    EXT  V27.16B, V27.16B, V30.16B, #0x2
    TRN2  V26.2D, V27.2D, V12.2D
    TRN2  V3.2D, V12.2D, V17.2D
    UZP1  V17.2S, V30.2S, V15.2S
    TRN2  V16.4H, V21.4H, V29.4H
    TRN2  V26.16B, V26.16B, V7.16B
    EXT  V3.8B, V22.8B, V25.8B, #0x5
    EXT  V23.16B, V14.16B, V1.16B, #0x0
    ZIP2  V1.2S, V4.2S, V30.2S
    ZIP2  V24.2S, V29.2S, V26.2S
    ZIP2  V17.4S, V24.4S, V29.4S
    UZP1  V20.2D, V3.2D, V2.2D
    UZP2  V18.2D, V9.2D, V21.2D
    ZIP1  V19.8H, V2.8H, V15.8H
    ZIP2  V18.2S, V1.2S, V0.2S
    ZIP2  V4.4S, V31.4S, V2.4S
    ZIP1  V30.8H, V28.8H, V17.8H
    TRN1  V25.8B, V22.8B, V23.8B
    UZP1  V0.8H, V4.8H, V27.8H
    UZP1  V9.4H, V14.4H, V19.4H
    UZP1  V8.2D, V18.2D, V20.2D
    EXT  V21.8B, V19.8B, V26.8B, #0x1
    ZIP2  V4.8H, V30.8H, V31.8H
    ZIP2  V15.2S, V20.2S, V14.2S
    ZIP1  V3.16B, V8.16B, V16.16B
    ZIP2  V26.4S, V20.4S, V0.4S
    TRN2  V4.4S, V15.4S, V8.4S
    UZP1  V21.8B, V22.8B, V24.8B
    UZP1  V10.2S, V26.2S, V21.2S
    UZP1  V1.8B, V12.8B, V1.8B
    TRN1  V11.16B, V19.16B, V4.16B
    ZIP1  V19.4S, V1.4S, V11.4S
    ZIP1  V15.8B, V4.8B, V26.8B
    ZIP2  V28.2S, V3.2S, V12.2S
    EXT  V12.8B, V15.8B, V9.8B, #0x0
    EXT  V23.16B, V30.16B, V10.16B, #0xc
    UZP1  V15.4S, V8.4S, V3.4S
    UZP1  V31.8H, V21.8H, V3.8H
    TRN2  V1.4H, V9.4H, V19.4H
    TRN2  V10.8B, V16.8B, V17.8B
    EXT  V19.8B, V8.8B, V5.8B, #0x3
    ZIP1  V19.8H, V20.8H, V21.8H
    TRN1  V2.2D, V14.2D, V21.2D
    ZIP2  V24.8H, V28.8H, V1.8H
    EXT  V31.16B, V17.16B, V14.16B, #0xb
    ZIP1  V9.8B, V10.8B, V1.8B
    TRN1  V26.2S, V18.2S, V14.2S
    TRN2  V25.16B, V4.16B, V20.16B
    ZIP1  V15.2D, V10.2D, V2.2D
    ZIP2  V8.2S, V11.2S, V30.2S
    ZIP1  V4.2S, V21.2S, V4.2S
    UZP2  V25.4H, V25.4H, V0.4H
    TRN1  V2.4H, V26.4H, V16.4H
    UZP2  V12.4S, V23.4S, V17.4S
    TRN1  V9.4S, V18.4S, V8.4S
    EXT  V29.16B, V4.16B, V7.16B, #0x9
    ZIP1  V4.8B, V13.8B, V31.8B
    UZP1  V2.16B, V4.16B, V7.16B
    UZP1  V4.2S, V25.2S, V4.2S
    TRN1  V9.4H, V22.4H, V23.4H
    EXT  V13.16B, V15.16B, V19.16B, #0xa
    UZP2  V2.16B, V21.16B, V17.16B
    TRN1  V4.16B, V31.16B, V16.16B
    SUBS  X3, X3, #0x1
    B.NE  TaishanSimdCryptoP01_label_165
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X28, X2, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X9, X5, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X25, X23, X5
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X17, X5, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X18, X17, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X24, X7, X8
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X19, X25, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X5, X20, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X29, X14, X12
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X12, X9, X13
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X11, X7, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X10, X6, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X17, X8, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X21
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X9, X8, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X24
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X12, X20, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X10, X8, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X29
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X27, X11, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D2
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xff, LSL #16
    SUB  X27, X11, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xff00, LSL #32
    MOVK  X24, #0xff00, LSL #48
    SUB  X17, X24, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D3
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xff00, LSL #32
    MOVK  X24, #0xff00, LSL #48
    SUB  X17, X24, X20
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D4
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xff00, LSL #16
    MOVK  X11, #0xff00, LSL #48
    SUB  X19, X11, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D5
    MOVZ  X11, #0xffff, LSL #0
    SUB  X13, X11, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D6
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X9
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D8
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X12
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D9
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xff, LSL #16
    MOVK  X22, #0xff, LSL #32
    SUB  X14, X22, X4
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D10
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xff, LSL #16
    MOVK  X19, #0xff, LSL #48
    SUB  X12, X19, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xff, LSL #48
    SUB  X27, X20, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D11
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D12
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X18, #0xff00, LSL #0
    MOVK  X18, #0xff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    SUB  X28, X18, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D13
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xff00, LSL #48
    SUB  X28, X18, X12
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D14
    MOVZ  X8, #0xff, LSL #0
    SUB  X6, X8, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
TaishanSimdCryptoP01_label_147:
    FMOV  X8, D16
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #48
    SUB  X12, X13, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D18
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X23, X21, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D19
    MOVZ  X21, #0xff00, LSL #0
    MOVK  X21, #0xff00, LSL #16
    MOVK  X21, #0xff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X23, X21, X9
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D20
    MOVZ  X18, #0xff00, LSL #0
    MOVK  X18, #0xff, LSL #16
    SUB  X29, X18, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D21
    MOVZ  X7, #0xff00, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    SUB  X24, X7, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D22
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X9, X11, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X21, #0xff00, LSL #0
    MOVK  X21, #0xffff, LSL #16
    SUB  X16, X21, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D23
    MOVZ  X21, #0xff, LSL #0
    SUB  X16, X21, X19
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D24
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X18, X21, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D26
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xff, LSL #32
    SUB  X18, X21, X23
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D27
    MOVZ  X3, #0x0, LSL #0
    SUB  X24, X3, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D28
    MOVZ  X11, #0xff00, LSL #0
    MOVK  X11, #0xff00, LSL #16
    SUB  X9, X11, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X7, X22, X20
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x333, LSL #0
    MOVK  X2, #0x2f58, LSL #16
    MOVK  X2, #0x5c41, LSL #32
    MOVK  X2, #0xe265, LSL #48
    MOVZ  X3, #0x98b8, LSL #0
    MOVK  X3, #0xc623, LSL #16
    MOVK  X3, #0x58dc, LSL #32
    MOVK  X3, #0xc32d, LSL #48
    MOVZ  X4, #0xfd3c, LSL #0
    MOVK  X4, #0xbd92, LSL #16
    MOVK  X4, #0xeb23, LSL #32
    MOVK  X4, #0x4f53, LSL #48
    MOVZ  X5, #0x646a, LSL #0
    MOVK  X5, #0xbf, LSL #16
    MOVK  X5, #0x39ce, LSL #32
    MOVK  X5, #0x5ad0, LSL #48
    MOVZ  X6, #0xc876, LSL #0
    MOVK  X6, #0x7fb9, LSL #16
    MOVK  X6, #0xa4ba, LSL #32
    MOVK  X6, #0x3c1d, LSL #48
    MOVZ  X7, #0x727f, LSL #0
    MOVK  X7, #0xe0fa, LSL #16
    MOVK  X7, #0x15de, LSL #32
    MOVK  X7, #0x2e4a, LSL #48
    MOVZ  X8, #0x6701, LSL #0
    MOVK  X8, #0xc62d, LSL #16
    MOVK  X8, #0x1745, LSL #32
    MOVK  X8, #0xf78a, LSL #48
    MOVZ  X9, #0x2470, LSL #0
    MOVK  X9, #0x1611, LSL #16
    MOVK  X9, #0x3969, LSL #32
    MOVK  X9, #0x77c0, LSL #48
    MOVZ  X10, #0x8022, LSL #0
    MOVK  X10, #0x4d9f, LSL #16
    MOVK  X10, #0xe93f, LSL #32
    MOVK  X10, #0x506f, LSL #48
    MOVZ  X11, #0xa89f, LSL #0
    MOVK  X11, #0xd79c, LSL #16
    MOVK  X11, #0x4fc3, LSL #32
    MOVK  X11, #0xd0f9, LSL #48
    MOVZ  X12, #0xdc3c, LSL #0
    MOVK  X12, #0xed4d, LSL #16
TaishanSimdCryptoP01_label_180:
    MOVK  X12, #0xf008, LSL #32
    MOVK  X12, #0x9a70, LSL #48
    MOVZ  X13, #0x933, LSL #0
    MOVK  X13, #0xd247, LSL #16
    MOVK  X13, #0x68da, LSL #32
    MOVK  X13, #0x4e6f, LSL #48
    MOVZ  X14, #0x6247, LSL #0
    MOVK  X14, #0x1f9e, LSL #16
    MOVK  X14, #0xf820, LSL #32
    MOVK  X14, #0x6760, LSL #48
    MOVZ  X16, #0x2836, LSL #0
    MOVK  X16, #0x97e2, LSL #16
    MOVK  X16, #0x606e, LSL #32
    MOVK  X16, #0xa9bd, LSL #48
    MOVZ  X17, #0x7d9c, LSL #0
    MOVK  X17, #0x868d, LSL #16
    MOVK  X17, #0xc088, LSL #32
    MOVK  X17, #0x3c7c, LSL #48
    MOVZ  X18, #0xc065, LSL #0
    MOVK  X18, #0x2e10, LSL #16
    MOVK  X18, #0x766f, LSL #32
    MOVK  X18, #0x5c81, LSL #48
    MOVZ  X19, #0x1430, LSL #0
    MOVK  X19, #0xa3cd, LSL #16
    MOVK  X19, #0x107d, LSL #32
    MOVK  X19, #0xf, LSL #48
    MOVZ  X20, #0xeaf2, LSL #0
    MOVK  X20, #0xd6ab, LSL #16
    MOVK  X20, #0x178b, LSL #32
    MOVK  X20, #0x92be, LSL #48
    MOVZ  X21, #0x7544, LSL #0
    MOVK  X21, #0xd4b8, LSL #16
    MOVK  X21, #0x1984, LSL #32
    MOVK  X21, #0xce5, LSL #48
    MOVZ  X22, #0x29e1, LSL #0
    MOVK  X22, #0x8e79, LSL #16
    MOVK  X22, #0x6c1d, LSL #32
    MOVK  X22, #0x60da, LSL #48
    MOVZ  X23, #0xea32, LSL #0
    MOVK  X23, #0x16e7, LSL #16
    MOVK  X23, #0x6e6c, LSL #32
    MOVK  X23, #0x9b83, LSL #48
    MOVZ  X24, #0x296b, LSL #0
    MOVK  X24, #0xcbc8, LSL #16
    MOVK  X24, #0xe61e, LSL #32
    MOVK  X24, #0xca63, LSL #48
    MOVZ  X25, #0xdb13, LSL #0
    MOVK  X25, #0x7498, LSL #16
    MOVK  X25, #0x83e1, LSL #32
    MOVK  X25, #0xa936, LSL #48
    MOVZ  X26, #0x29ca, LSL #0
    MOVK  X26, #0x3bc7, LSL #16
    MOVK  X26, #0xa7f5, LSL #32
    MOVK  X26, #0x2c7b, LSL #48
    MOVZ  X27, #0x38ce, LSL #0
    MOVK  X27, #0x2c72, LSL #16
    MOVK  X27, #0xaad7, LSL #32
    MOVK  X27, #0xe930, LSL #48
    MOVZ  X28, #0x5e1e, LSL #0
    MOVK  X28, #0x4962, LSL #16
    MOVK  X28, #0x9e0a, LSL #32
    MOVK  X28, #0x48a6, LSL #48
    MOVZ  X29, #0x40d6, LSL #0
    MOVK  X29, #0xf2b7, LSL #16
    MOVK  X29, #0x3cdf, LSL #32
    MOVK  X29, #0x47e2, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X7
    FMOV  D1, X13
    FMOV  V1.D[1], X29
    FMOV  D2, X21
    FMOV  V2.D[1], X29
    FMOV  D3, X18
    FMOV  V3.D[1], X2
    FMOV  D4, X22
    FMOV  V4.D[1], X6
    FMOV  D5, X19
    FMOV  V5.D[1], X5
    FMOV  D6, X7
    FMOV  V6.D[1], X7
    FMOV  D7, X3
    FMOV  V7.D[1], X5
    FMOV  D8, X4
    FMOV  V8.D[1], X2
    FMOV  D9, X27
    FMOV  V9.D[1], X14
    FMOV  D10, X28
    FMOV  V10.D[1], X7
    FMOV  D11, X19
    FMOV  V11.D[1], X4
    FMOV  D12, X8
    FMOV  V12.D[1], X27
    FMOV  D13, X4
    FMOV  V13.D[1], X18
    FMOV  D14, X11
    FMOV  V14.D[1], X24
    FMOV  D15, X27
    FMOV  V15.D[1], X7
    FMOV  D16, X4
    FMOV  V16.D[1], X3
    FMOV  D17, X19
    FMOV  V17.D[1], X16
    FMOV  D18, X22
    FMOV  V18.D[1], X18
    FMOV  D19, X22
    FMOV  V19.D[1], X20
    FMOV  D20, X2
    FMOV  V20.D[1], X28
    FMOV  D21, X23
    FMOV  V21.D[1], X10
    FMOV  D22, X16
    FMOV  V22.D[1], X5
    FMOV  D23, X17
    FMOV  V23.D[1], X16
    FMOV  D24, X16
    FMOV  V24.D[1], X23
    FMOV  D25, X6
    FMOV  V25.D[1], X28
    FMOV  D26, X4
    FMOV  V26.D[1], X24
    FMOV  D27, X18
    FMOV  V27.D[1], X12
    FMOV  D28, X11
    FMOV  V28.D[1], X11
    FMOV  D29, X7
    FMOV  V29.D[1], X29
    FMOV  D30, X27
    FMOV  V30.D[1], X20
    FMOV  D31, X10
    FMOV  V31.D[1], X9
    MOVZ  X6, #0xa, LSL #0
TaishanSimdCryptoP01_label_248:
    TRN1  V20.8H, V14.8H, V31.8H
    EXT  V24.16B, V5.16B, V19.16B, #0x7
    EXT  V22.8B, V30.8B, V31.8B, #0x0
    EXT  V3.8B, V27.8B, V23.8B, #0x6
    TRN2  V21.8H, V28.8H, V21.8H
    TRN2  V16.4S, V29.4S, V28.4S
    EXT  V3.16B, V19.16B, V12.16B, #0x8
    ZIP2  V21.2D, V15.2D, V17.2D
    TRN2  V16.16B, V26.16B, V30.16B
    EXT  V28.8B, V15.8B, V20.8B, #0x2
    TRN1  V16.16B, V24.16B, V29.16B
    UZP1  V19.16B, V31.16B, V4.16B
    ZIP2  V28.8H, V19.8H, V27.8H
    ZIP2  V22.4S, V17.4S, V8.4S
    TRN2  V17.8B, V22.8B, V12.8B
    TRN1  V23.2D, V31.2D, V16.2D
    TRN2  V6.4S, V16.4S, V6.4S
    TRN2  V21.4H, V9.4H, V23.4H
    UZP1  V7.2D, V0.2D, V25.2D
    ZIP1  V27.8B, V28.8B, V17.8B
    ZIP1  V30.8H, V22.8H, V28.8H
    UZP1  V29.2S, V22.2S, V15.2S
    ZIP1  V28.16B, V4.16B, V7.16B
    ZIP2  V25.16B, V0.16B, V11.16B
    EXT  V1.8B, V26.8B, V26.8B, #0x4
    UZP2  V8.16B, V20.16B, V8.16B
    TRN2  V26.2D, V2.2D, V17.2D
    TRN2  V7.16B, V27.16B, V0.16B
    EXT  V23.16B, V21.16B, V24.16B, #0x1
    TRN1  V12.16B, V7.16B, V30.16B
    ZIP2  V28.2D, V14.2D, V16.2D
    ZIP1  V0.8H, V26.8H, V3.8H
    ZIP2  V22.2D, V25.2D, V21.2D
    TRN2  V22.16B, V28.16B, V18.16B
    EXT  V18.8B, V22.8B, V0.8B, #0x3
    EXT  V25.16B, V1.16B, V29.16B, #0x0
    ZIP2  V24.16B, V7.16B, V17.16B
    EXT  V15.8B, V11.8B, V17.8B, #0x7
    TRN1  V17.8H, V19.8H, V14.8H
    EXT  V4.16B, V16.16B, V21.16B, #0xb
    EXT  V2.16B, V8.16B, V29.16B, #0xd
    ZIP2  V1.8B, V0.8B, V11.8B
    TRN1  V27.4S, V9.4S, V14.4S
    UZP1  V17.4S, V28.4S, V3.4S
    TRN1  V2.8B, V0.8B, V9.8B
    TRN1  V7.2S, V31.2S, V3.2S
    UZP1  V1.8H, V15.8H, V8.8H
    ZIP2  V20.2D, V23.2D, V1.2D
    TRN1  V4.4S, V8.4S, V0.4S
    EXT  V25.8B, V31.8B, V12.8B, #0x0
    EXT  V1.16B, V5.16B, V30.16B, #0x5
    EXT  V9.8B, V11.8B, V18.8B, #0x0
    EXT  V21.8B, V3.8B, V4.8B, #0x0
    ZIP1  V24.2S, V28.2S, V14.2S
    ZIP1  V30.4S, V1.4S, V21.4S
    TRN1  V17.16B, V8.16B, V23.16B
    UZP1  V3.16B, V10.16B, V21.16B
    UZP2  V1.8H, V3.8H, V23.8H
    EXT  V25.8B, V27.8B, V27.8B, #0x3
    ZIP1  V17.2D, V28.2D, V14.2D
    TRN2  V8.8H, V21.8H, V27.8H
    ZIP2  V24.8B, V13.8B, V14.8B
    UZP2  V14.8B, V24.8B, V5.8B
    ZIP1  V24.2D, V30.2D, V27.2D
    ZIP1  V6.4H, V30.4H, V22.4H
    TRN1  V24.8H, V9.8H, V30.8H
    UZP2  V14.8H, V3.8H, V1.8H
    TRN2  V17.8H, V7.8H, V18.8H
    UZP2  V28.8B, V24.8B, V16.8B
    TRN1  V16.8B, V23.8B, V2.8B
    TRN2  V9.16B, V15.16B, V4.16B
    TRN2  V10.8B, V10.8B, V22.8B
    UZP1  V25.4S, V11.4S, V29.4S
    ZIP2  V30.4H, V9.4H, V5.4H
    EXT  V21.16B, V3.16B, V13.16B, #0x5
    ZIP1  V17.8B, V22.8B, V3.8B
    ZIP2  V24.2D, V3.2D, V17.2D
    EXT  V5.16B, V28.16B, V27.16B, #0xa
    UZP2  V6.4S, V19.4S, V24.4S
    UZP2  V8.4S, V6.4S, V6.4S
    UZP1  V5.8H, V23.8H, V29.8H
    UZP1  V25.4S, V18.4S, V26.4S
    ZIP1  V14.8B, V9.8B, V21.8B
    TRN2  V1.2S, V17.2S, V16.2S
    EXT  V10.8B, V11.8B, V7.8B, #0x2
    ZIP1  V26.2D, V16.2D, V14.2D
    TRN2  V8.2D, V9.2D, V18.2D
    TRN1  V14.16B, V9.16B, V12.16B
    UZP1  V3.8B, V7.8B, V11.8B
    EXT  V30.16B, V3.16B, V11.16B, #0xa
    TRN2  V8.4S, V6.4S, V18.4S
    EXT  V2.16B, V25.16B, V22.16B, #0x4
    TRN1  V0.2S, V28.2S, V23.2S
    TRN1  V25.8H, V5.8H, V0.8H
    UZP2  V17.8H, V6.8H, V6.8H
    ZIP2  V10.2D, V17.2D, V26.2D
    TRN1  V1.4S, V12.4S, V12.4S
    EXT  V24.8B, V17.8B, V8.8B, #0x4
    EXT  V19.16B, V11.16B, V24.16B, #0x8
    UZP2  V25.8H, V6.8H, V10.8H
    ZIP2  V2.2D, V16.2D, V23.2D
    UZP2  V10.8B, V6.8B, V20.8B
    ZIP1  V10.8B, V10.8B, V6.8B
    EXT  V0.16B, V23.16B, V21.16B, #0x6
    ZIP1  V12.8B, V27.8B, V18.8B
    UZP2  V15.4S, V29.4S, V10.4S
    TRN2  V0.8H, V29.8H, V31.8H
    TRN2  V22.4H, V27.4H, V25.4H
    EXT  V28.8B, V12.8B, V1.8B, #0x0
    ZIP2  V2.4H, V19.4H, V23.4H
    ZIP1  V2.4H, V9.4H, V10.4H
    ZIP1  V15.16B, V0.16B, V17.16B
    EXT  V25.16B, V1.16B, V13.16B, #0x6
    EXT  V16.8B, V8.8B, V17.8B, #0x4
    ZIP1  V3.4H, V7.4H, V6.4H
    ZIP2  V1.2S, V18.2S, V19.2S
    UZP2  V19.8B, V20.8B, V8.8B
    TRN2  V11.2S, V22.2S, V24.2S
    UZP1  V17.8B, V7.8B, V10.8B
    EXT  V15.8B, V1.8B, V0.8B, #0x7
    ZIP1  V24.4S, V9.4S, V9.4S
    ZIP2  V11.4H, V15.4H, V2.4H
    TRN1  V9.2D, V28.2D, V20.2D
    UZP2  V27.4H, V28.4H, V14.4H
    TRN2  V8.2D, V8.2D, V23.2D
    EXT  V17.8B, V3.8B, V21.8B, #0x2
    UZP2  V8.16B, V27.16B, V1.16B
    UZP2  V16.2S, V17.2S, V21.2S
    TRN1  V8.8H, V25.8H, V3.8H
    UZP2  V8.2S, V7.2S, V9.2S
    EXT  V25.8B, V9.8B, V16.8B, #0x5
    EXT  V29.8B, V19.8B, V31.8B, #0x1
    EXT  V4.8B, V14.8B, V22.8B, #0x3
    UZP1  V25.2D, V25.2D, V8.2D
    TRN1  V29.16B, V22.16B, V30.16B
    EXT  V11.8B, V14.8B, V17.8B, #0x7
    ZIP1  V10.8H, V3.8H, V0.8H
    EXT  V11.8B, V12.8B, V19.8B, #0x0
    EXT  V19.16B, V27.16B, V22.16B, #0x9
    EXT  V1.8B, V2.8B, V6.8B, #0x3
    ZIP1  V20.16B, V2.16B, V0.16B
    TRN1  V21.8B, V20.8B, V5.8B
    UZP2  V23.4H, V17.4H, V28.4H
    ZIP2  V26.2D, V25.2D, V19.2D
    EXT  V7.8B, V1.8B, V11.8B, #0x6
    ZIP1  V28.2D, V26.2D, V23.2D
    ZIP2  V27.4S, V14.4S, V21.4S
    UZP1  V26.2D, V27.2D, V7.2D
    ZIP2  V27.8B, V12.8B, V8.8B
    TRN2  V9.8H, V19.8H, V15.8H
    UZP1  V27.4S, V10.4S, V9.4S
    TRN1  V26.2D, V11.2D, V28.2D
    UZP2  V13.2S, V30.2S, V4.2S
    ZIP2  V3.2D, V29.2D, V28.2D
    UZP1  V19.8B, V21.8B, V7.8B
    UZP2  V31.4H, V27.4H, V30.4H
    UZP1  V3.2S, V5.2S, V26.2S
    TRN2  V31.2D, V3.2D, V3.2D
    TRN2  V5.4H, V14.4H, V3.4H
    TRN1  V10.4H, V21.4H, V23.4H
    ZIP2  V20.4S, V5.4S, V9.4S
    UZP1  V11.8H, V5.8H, V20.8H
    UZP1  V25.16B, V26.16B, V26.16B
    UZP2  V3.4H, V3.4H, V22.4H
    EXT  V20.16B, V20.16B, V16.16B, #0x1
    TRN2  V0.4S, V7.4S, V13.4S
    UZP1  V8.4H, V9.4H, V13.4H
    EXT  V20.8B, V18.8B, V0.8B, #0x7
    TRN2  V12.16B, V7.16B, V20.16B
    TRN1  V3.8B, V15.8B, V20.8B
    EXT  V15.16B, V12.16B, V29.16B, #0x5
    EXT  V11.16B, V31.16B, V10.16B, #0x1
    EXT  V31.16B, V1.16B, V26.16B, #0x1
    ZIP2  V3.8B, V8.8B, V9.8B
    EXT  V25.16B, V18.16B, V12.16B, #0x4
    EXT  V3.8B, V15.8B, V3.8B, #0x3
    ZIP1  V16.2S, V4.2S, V5.2S
    EXT  V15.16B, V27.16B, V20.16B, #0x1
    UZP2  V12.2D, V12.2D, V29.2D
    EXT  V15.8B, V31.8B, V1.8B, #0x3
    ZIP1  V21.2D, V19.2D, V24.2D
    UZP2  V21.4S, V22.4S, V21.4S
    ZIP2  V25.8H, V19.8H, V3.8H
    ZIP2  V21.4S, V26.4S, V18.4S
    ZIP1  V8.2S, V17.2S, V15.2S
    UZP1  V0.8B, V9.8B, V18.8B
    ZIP1  V12.8H, V21.8H, V11.8H
    TRN1  V20.16B, V22.16B, V17.16B
    UZP1  V8.2D, V20.2D, V4.2D
    TRN1  V4.8B, V11.8B, V19.8B
    ZIP2  V4.2D, V18.2D, V14.2D
    EXT  V21.16B, V13.16B, V26.16B, #0x3
    UZP1  V31.4S, V24.4S, V2.4S
    EXT  V4.16B, V5.16B, V19.16B, #0xe
    EXT  V12.8B, V4.8B, V3.8B, #0x3
    UZP1  V22.4S, V8.4S, V14.4S
    EXT  V28.8B, V21.8B, V25.8B, #0x4
    UZP1  V15.8B, V31.8B, V26.8B
    ZIP1  V7.16B, V16.16B, V13.16B
    EXT  V29.8B, V1.8B, V29.8B, #0x2
    SUBS  X6, X6, #0x1
    B.NE  TaishanSimdCryptoP01_label_248
    MOVZ  X2, #0x333, LSL #0
    MOVK  X2, #0x2f58, LSL #16
    MOVK  X2, #0x5c41, LSL #32
    MOVK  X2, #0xe265, LSL #48
    SUB  X24, X2, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x98b8, LSL #0
    MOVK  X4, #0xc623, LSL #16
    MOVK  X4, #0x58dc, LSL #32
    MOVK  X4, #0xc32d, LSL #48
    SUB  X18, X4, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x98b8, LSL #0
    MOVK  X11, #0xc623, LSL #16
    MOVK  X11, #0x58dc, LSL #32
    MOVK  X11, #0xc32d, LSL #48
    SUB  X6, X11, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x646a, LSL #0
    MOVK  X7, #0xbf, LSL #16
    MOVK  X7, #0x39ce, LSL #32
    MOVK  X7, #0x5ad0, LSL #48
    SUB  X12, X7, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X6
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x646a, LSL #0
    MOVK  X26, #0xbf, LSL #16
    MOVK  X26, #0x39ce, LSL #32
    MOVK  X26, #0x5ad0, LSL #48
    SUB  X24, X26, X7
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X8
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x2470, LSL #0
    MOVK  X10, #0x1611, LSL #16
    MOVK  X10, #0x3969, LSL #32
    MOVK  X10, #0x77c0, LSL #48
    SUB  X19, X10, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x2470, LSL #0
    MOVK  X20, #0x1611, LSL #16
    MOVK  X20, #0x3969, LSL #32
    MOVK  X20, #0x77c0, LSL #48
    SUB  X21, X20, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X4, X2, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x6247, LSL #0
    MOVK  X27, #0x1f9e, LSL #16
    MOVK  X27, #0xf820, LSL #32
    MOVK  X27, #0x6760, LSL #48
    SUB  X16, X27, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X21
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X18, X7, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X16, X28, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X11, X27, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0xdb13, LSL #0
    MOVK  X14, #0x7498, LSL #16
    MOVK  X14, #0x83e1, LSL #32
    MOVK  X14, #0xa936, LSL #48
    SUB  X20, X14, X25
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X26
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X22, X19, X28
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D2
    MOVZ  X5, #0x8000, LSL #0
    MOVK  X5, #0x11, LSL #16
    MOVK  X5, #0x1100, LSL #48
    SUB  X14, X5, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D4
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x8000, LSL #16
    MOVK  X6, #0x11, LSL #32
    MOVK  X6, #0x11, LSL #48
    SUB  X9, X6, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X23, X3, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D5
    MOVZ  X3, #0x1100, LSL #0
    MOVK  X3, #0x2f2f, LSL #16
    MOVK  X3, #0x112f, LSL #32
    SUB  X23, X3, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D6
    MOVZ  X16, #0x1100, LSL #0
    SUB  X29, X16, X14
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X6, #0x1100, LSL #0
    MOVK  X6, #0x11, LSL #16
    MOVK  X6, #0x2f, LSL #32
    MOVK  X6, #0x2f, LSL #48
    SUB  X3, X6, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D7
    MOVZ  X6, #0x11, LSL #0
    MOVK  X6, #0x3, LSL #16
    MOVK  X6, #0x2f, LSL #48
    SUB  X3, X6, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X22, #0x311, LSL #0
    MOVK  X22, #0x2f00, LSL #16
    MOVK  X22, #0x11, LSL #32
    SUB  X12, X22, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X21, X4, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D9
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x2f2f, LSL #48
    SUB  X21, X4, X28
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D10
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x11, LSL #32
    SUB  X9, X25, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X9, X25, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X2, X28, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D12
    MOVZ  X28, #0x1180, LSL #0
    MOVK  X28, #0x1100, LSL #16
    SUB  X2, X28, X8
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X10, X19, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D13
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x11, LSL #32
    SUB  X10, X19, X14
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D14
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x1100, LSL #16
    MOVK  X4, #0x3, LSL #32
    MOVK  X4, #0x112f, LSL #48
    SUB  X26, X4, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D16
    MOVZ  X7, #0x311, LSL #0
    MOVK  X7, #0x2f00, LSL #16
    MOVK  X7, #0x1100, LSL #32
    MOVK  X7, #0x2f2f, LSL #48
    SUB  X6, X7, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D17
    MOVZ  X5, #0x1100, LSL #0
    SUB  X27, X5, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D19
    MOVZ  X22, #0x8000, LSL #0
    MOVK  X22, #0x11, LSL #16
    MOVK  X22, #0x11, LSL #32
    SUB  X28, X22, X20
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D21
    MOVZ  X2, #0x1100, LSL #0
    SUB  X19, X2, X5
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x1100, LSL #16
    SUB  X13, X14, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D22
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x311, LSL #32
    MOVK  X14, #0x2f00, LSL #48
    SUB  X13, X14, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D23
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V24.D[1]
    MOVZ  X5, #0x3, LSL #0
    MOVK  X5, #0x2f, LSL #16
    MOVK  X5, #0x3, LSL #32
    MOVK  X5, #0x2f, LSL #48
    SUB  X14, X5, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D24
    MOVZ  X5, #0x8000, LSL #0
    MOVK  X5, #0x8000, LSL #32
    SUB  X14, X5, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X6
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X14, X22, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D27
    MOVZ  X22, #0x8000, LSL #0
    MOVK  X22, #0x2f03, LSL #48
    SUB  X14, X22, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X5, X29, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D29
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x11, LSL #16
    MOVK  X4, #0x11, LSL #32
    SUB  X19, X4, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X4
    FMOV  V0.D[1], X3
    FMOV  D1, X3
    FMOV  V1.D[1], X2
    FMOV  D2, X20
    FMOV  V2.D[1], X26
    FMOV  D3, X25
    FMOV  V3.D[1], X24
    FMOV  D4, X4
    FMOV  V4.D[1], X22
    FMOV  D5, X17
    FMOV  V5.D[1], X2
    FMOV  D6, X18
    FMOV  V6.D[1], X18
    FMOV  D7, X14
    FMOV  V7.D[1], X23
    FMOV  D8, X29
    FMOV  V8.D[1], X25
    FMOV  D9, X28
    FMOV  V9.D[1], X6
    FMOV  D10, X27
    FMOV  V10.D[1], X22
    FMOV  D11, X9
    FMOV  V11.D[1], X4
    FMOV  D12, X23
    FMOV  V12.D[1], X25
    FMOV  D13, X12
    FMOV  V13.D[1], X27
    FMOV  D14, X7
    FMOV  V14.D[1], X14
    FMOV  D15, X4
    FMOV  V15.D[1], X6
    FMOV  D16, X9
    FMOV  V16.D[1], X10
    FMOV  D17, X2
    FMOV  V17.D[1], X29
    FMOV  D18, X29
    FMOV  V18.D[1], X12
    FMOV  D19, X17
    FMOV  V19.D[1], X10
    FMOV  D20, X22
    FMOV  V20.D[1], X26
    FMOV  D21, X2
    FMOV  V21.D[1], X8
    FMOV  D22, X22
    FMOV  V22.D[1], X12
    FMOV  D23, X29
    FMOV  V23.D[1], X19
    FMOV  D24, X21
    FMOV  V24.D[1], X8
    FMOV  D25, X21
    FMOV  V25.D[1], X22
    FMOV  D26, X2
    FMOV  V26.D[1], X19
    FMOV  D27, X10
    FMOV  V27.D[1], X11
    FMOV  D28, X16
    FMOV  V28.D[1], X23
    FMOV  D29, X9
    FMOV  V29.D[1], X23
    FMOV  D30, X13
    FMOV  V30.D[1], X21
    FMOV  D31, X12
    FMOV  V31.D[1], X12
    MOVZ  X12, #0xa, LSL #0
TaishanSimdCryptoP01_label_331:
    TRN2  V1.2D, V0.2D, V26.2D
    EXT  V1.8B, V0.8B, V17.8B, #0x7
    TRN1  V23.16B, V30.16B, V9.16B
    EXT  V10.8B, V5.8B, V24.8B, #0x7
    EXT  V0.8B, V28.8B, V25.8B, #0x0
    ZIP2  V31.8H, V1.8H, V27.8H
    EXT  V9.8B, V9.8B, V4.8B, #0x1
    TRN1  V26.16B, V30.16B, V19.16B
    ZIP2  V7.8B, V10.8B, V26.8B
    EXT  V4.16B, V23.16B, V2.16B, #0xf
    ZIP2  V8.4S, V17.4S, V20.4S
    TRN2  V19.2D, V1.2D, V15.2D
    EXT  V4.8B, V13.8B, V0.8B, #0x2
    TRN2  V24.16B, V27.16B, V13.16B
    ZIP2  V5.8B, V29.8B, V15.8B
    ZIP2  V24.2D, V0.2D, V11.2D
    EXT  V28.16B, V25.16B, V23.16B, #0xd
    EXT  V28.8B, V14.8B, V29.8B, #0x5
    UZP1  V15.2D, V14.2D, V28.2D
    TRN1  V9.4H, V27.4H, V9.4H
    TRN2  V3.16B, V15.16B, V31.16B
    UZP2  V14.8B, V10.8B, V3.8B
    ZIP2  V8.16B, V30.16B, V18.16B
    ZIP1  V17.2D, V12.2D, V7.2D
    UZP2  V14.4H, V22.4H, V10.4H
    UZP1  V13.2S, V19.2S, V24.2S
    UZP2  V28.2S, V0.2S, V4.2S
    EXT  V8.16B, V4.16B, V11.16B, #0x3
    EXT  V11.16B, V12.16B, V3.16B, #0xa
    EXT  V4.16B, V17.16B, V7.16B, #0x0
    UZP1  V14.2D, V1.2D, V14.2D
    UZP2  V11.8H, V5.8H, V8.8H
    EXT  V15.8B, V3.8B, V28.8B, #0x7
    UZP1  V17.8B, V21.8B, V15.8B
    UZP2  V13.4S, V22.4S, V9.4S
    ZIP2  V6.2S, V23.2S, V25.2S
    EXT  V1.16B, V27.16B, V30.16B, #0x6
    ZIP1  V16.4S, V7.4S, V27.4S
    UZP1  V16.16B, V21.16B, V2.16B
    ZIP1  V18.4S, V9.4S, V18.4S
    TRN2  V9.2S, V10.2S, V19.2S
    EXT  V21.8B, V30.8B, V19.8B, #0x2
    EXT  V4.8B, V12.8B, V26.8B, #0x2
    TRN2  V28.2S, V26.2S, V4.2S
    EXT  V15.8B, V13.8B, V24.8B, #0x7
    EXT  V3.8B, V5.8B, V8.8B, #0x2
    UZP1  V23.8H, V24.8H, V0.8H
    TRN2  V10.2D, V13.2D, V14.2D
    EXT  V15.8B, V28.8B, V7.8B, #0x6
    ZIP2  V18.8B, V6.8B, V14.8B
    ZIP2  V17.4S, V0.4S, V28.4S
    ZIP1  V3.4S, V22.4S, V2.4S
    TRN2  V4.16B, V16.16B, V26.16B
    UZP2  V3.4H, V26.4H, V8.4H
    UZP2  V14.8H, V19.8H, V11.8H
    ZIP2  V20.8B, V0.8B, V3.8B
    TRN1  V31.4S, V0.4S, V17.4S
    EXT  V17.8B, V8.8B, V15.8B, #0x2
    EXT  V18.16B, V8.16B, V17.16B, #0x4
    ZIP2  V8.8H, V8.8H, V17.8H
    EXT  V24.16B, V26.16B, V14.16B, #0xf
    TRN1  V17.8B, V18.8B, V8.8B
    UZP1  V5.16B, V10.16B, V1.16B
    EXT  V12.8B, V22.8B, V12.8B, #0x7
    UZP2  V22.4S, V31.4S, V25.4S
    TRN1  V16.2S, V3.2S, V6.2S
    TRN1  V28.2S, V15.2S, V17.2S
    UZP2  V27.4H, V18.4H, V10.4H
    ZIP1  V27.8H, V4.8H, V24.8H
    UZP2  V12.16B, V2.16B, V23.16B
    ZIP2  V31.8B, V15.8B, V29.8B
    UZP1  V28.2S, V29.2S, V5.2S
    TRN2  V2.4S, V20.4S, V16.4S
    EXT  V18.8B, V18.8B, V11.8B, #0x7
    EXT  V26.16B, V31.16B, V29.16B, #0xc
    EXT  V17.16B, V5.16B, V19.16B, #0x4
    ZIP1  V2.8B, V14.8B, V26.8B
    ZIP1  V29.8H, V15.8H, V16.8H
    ZIP2  V28.4S, V21.4S, V31.4S
    ZIP1  V18.16B, V20.16B, V22.16B
    TRN1  V18.4H, V8.4H, V24.4H
    UZP1  V12.2S, V10.2S, V31.2S
    ZIP2  V15.8H, V23.8H, V29.8H
    EXT  V10.8B, V5.8B, V17.8B, #0x4
    ZIP2  V0.4S, V26.4S, V28.4S
    UZP2  V6.4S, V8.4S, V18.4S
    EXT  V29.8B, V19.8B, V9.8B, #0x1
    TRN2  V24.4H, V20.4H, V29.4H
    EXT  V27.16B, V30.16B, V12.16B, #0x4
    ZIP1  V11.4S, V21.4S, V8.4S
    TRN1  V19.16B, V31.16B, V8.16B
    ZIP1  V15.2D, V26.2D, V11.2D
    TRN2  V22.8B, V21.8B, V18.8B
    TRN2  V15.8H, V28.8H, V12.8H
    ZIP1  V21.8H, V14.8H, V19.8H
    ZIP1  V16.4S, V25.4S, V11.4S
    UZP2  V16.8B, V24.8B, V18.8B
    TRN1  V21.2S, V15.2S, V30.2S
    TRN1  V1.16B, V0.16B, V17.16B
    ZIP1  V19.16B, V10.16B, V1.16B
    ZIP1  V8.4S, V1.4S, V5.4S
    UZP2  V5.2D, V19.2D, V5.2D
    ZIP2  V28.16B, V10.16B, V11.16B
    ZIP1  V4.8H, V29.8H, V12.8H
    ZIP1  V1.2S, V8.2S, V8.2S
    EXT  V22.16B, V18.16B, V28.16B, #0x0
    TRN2  V3.16B, V0.16B, V0.16B
    UZP1  V14.4H, V10.4H, V3.4H
    ZIP2  V24.2D, V15.2D, V14.2D
    UZP2  V12.4H, V5.4H, V5.4H
    EXT  V10.16B, V29.16B, V15.16B, #0x1
    ZIP2  V11.2D, V2.2D, V17.2D
    TRN1  V10.2D, V24.2D, V21.2D
    TRN1  V21.8H, V16.8H, V16.8H
    ZIP2  V4.2D, V29.2D, V0.2D
    EXT  V18.16B, V20.16B, V5.16B, #0x1
    EXT  V21.8B, V7.8B, V0.8B, #0x6
    EXT  V15.8B, V26.8B, V31.8B, #0x5
    TRN2  V24.4H, V15.4H, V1.4H
    EXT  V14.8B, V4.8B, V23.8B, #0x7
    ZIP1  V24.16B, V21.16B, V4.16B
    EXT  V3.16B, V24.16B, V30.16B, #0x6
    UZP1  V21.2S, V3.2S, V23.2S
    TRN1  V10.4S, V25.4S, V15.4S
    ZIP2  V21.2D, V20.2D, V21.2D
    ZIP2  V25.4S, V1.4S, V21.4S
    ZIP2  V11.4H, V16.4H, V26.4H
    EXT  V11.16B, V29.16B, V19.16B, #0x3
    EXT  V21.16B, V22.16B, V15.16B, #0x9
    TRN1  V18.2S, V18.2S, V20.2S
    ZIP1  V30.4H, V25.4H, V8.4H
    TRN1  V22.2S, V2.2S, V22.2S
    EXT  V27.16B, V0.16B, V9.16B, #0xe
    TRN1  V29.2D, V31.2D, V8.2D
    UZP1  V11.4S, V29.4S, V31.4S
    EXT  V19.16B, V15.16B, V12.16B, #0x4
    EXT  V27.8B, V11.8B, V9.8B, #0x5
    TRN1  V6.8B, V16.8B, V7.8B
    TRN1  V21.8H, V4.8H, V6.8H
    ZIP1  V15.8B, V7.8B, V26.8B
    TRN1  V17.8H, V15.8H, V10.8H
    EXT  V24.8B, V16.8B, V11.8B, #0x5
    UZP1  V15.8H, V9.8H, V0.8H
    TRN2  V31.4S, V30.4S, V8.4S
    UZP1  V8.4H, V23.4H, V31.4H
    TRN2  V11.2S, V26.2S, V9.2S
    TRN1  V21.4S, V14.4S, V4.4S
    EXT  V23.8B, V8.8B, V20.8B, #0x2
    ZIP1  V27.16B, V9.16B, V0.16B
    ZIP1  V1.4H, V8.4H, V0.4H
    UZP1  V3.8B, V24.8B, V22.8B
    EXT  V5.8B, V11.8B, V8.8B, #0x3
    TRN1  V30.8H, V27.8H, V3.8H
    UZP2  V27.8H, V12.8H, V17.8H
    ZIP1  V25.2S, V10.2S, V4.2S
    TRN1  V23.8B, V29.8B, V18.8B
    UZP2  V14.2D, V4.2D, V17.2D
    ZIP2  V30.8B, V19.8B, V13.8B
    ZIP1  V20.8B, V24.8B, V31.8B
    UZP2  V18.8B, V29.8B, V27.8B
    TRN1  V5.4H, V7.4H, V6.4H
    ZIP2  V5.16B, V25.16B, V9.16B
    ZIP2  V5.8B, V10.8B, V0.8B
    ZIP2  V12.4H, V29.4H, V11.4H
    TRN2  V19.4H, V1.4H, V15.4H
    TRN1  V2.8H, V3.8H, V17.8H
    UZP1  V29.8H, V0.8H, V24.8H
    UZP1  V1.2S, V6.2S, V26.2S
    EXT  V4.8B, V8.8B, V1.8B, #0x3
    TRN2  V23.2D, V9.2D, V7.2D
    ZIP1  V8.8H, V22.8H, V20.8H
    UZP1  V31.4H, V0.4H, V20.4H
    TRN2  V27.4S, V22.4S, V4.4S
    EXT  V24.16B, V23.16B, V2.16B, #0xb
    EXT  V21.8B, V19.8B, V29.8B, #0x2
    UZP1  V22.16B, V20.16B, V14.16B
    EXT  V21.8B, V30.8B, V18.8B, #0x5
    ZIP1  V25.4S, V17.4S, V31.4S
    ZIP1  V10.4S, V14.4S, V23.4S
    TRN2  V0.8H, V28.8H, V10.8H
    UZP2  V17.4H, V1.4H, V8.4H
    UZP2  V0.8B, V11.8B, V16.8B
    EXT  V11.16B, V22.16B, V20.16B, #0x0
    EXT  V31.16B, V29.16B, V7.16B, #0x9
    TRN2  V4.2S, V18.2S, V23.2S
    TRN2  V2.4S, V13.4S, V1.4S
    UZP2  V24.4H, V0.4H, V5.4H
    UZP1  V9.8H, V7.8H, V9.8H
    ZIP1  V20.8H, V19.8H, V22.8H
    UZP2  V21.4H, V31.4H, V1.4H
    TRN2  V10.8B, V30.8B, V9.8B
    ZIP1  V27.16B, V25.16B, V15.16B
    TRN2  V24.2S, V7.2S, V20.2S
    EXT  V1.8B, V11.8B, V27.8B, #0x2
    TRN2  V22.8B, V2.8B, V4.8B
    EXT  V13.16B, V16.16B, V31.16B, #0x0
    UZP1  V4.16B, V12.16B, V18.16B
    EXT  V5.16B, V4.16B, V30.16B, #0xf
    ZIP1  V13.2D, V28.2D, V16.2D
    TRN2  V23.16B, V18.16B, V0.16B
    SUBS  X12, X12, #0x1
    B.NE  TaishanSimdCryptoP01_label_331
    MOVZ  X16, #0x0, LSL #0
    SUB  X25, X16, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X3
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X9
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X24, X20, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X12
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X14
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X4, X9, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X10, X20, X17
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X24, X19, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X23, X5, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X9, X29, X20
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X29, X9, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X24
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X3, X25, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X28
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D2
    MOVZ  X26, #0x0, LSL #0
    SUB  X27, X26, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X9
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D4
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D5
    MOVZ  X17, #0x0, LSL #0
    SUB  X6, X17, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D6
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X4
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X6, X23, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D9
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X27
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D10
    MOVZ  X8, #0x0, LSL #0
    SUB  X6, X8, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D11
    MOVZ  X16, #0x0, LSL #0
    SUB  X26, X16, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D12
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D13
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X13, X25, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D16
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D17
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D18
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X18, X9, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D20
    MOVZ  X6, #0x0, LSL #0
    SUB  X21, X6, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D22
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X26
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D23
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X13
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D24
    MOVZ  X19, #0x0, LSL #0
    SUB  X11, X19, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D25
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D26
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X29
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X19
    FMOV  D1, X26
    FMOV  V1.D[1], X21
    FMOV  D2, X13
    FMOV  V2.D[1], X17
    FMOV  D3, X4
    FMOV  V3.D[1], X20
    FMOV  D4, X16
    FMOV  V4.D[1], X12
    FMOV  D5, X28
    FMOV  V5.D[1], X29
    FMOV  D6, X16
    FMOV  V6.D[1], X28
    FMOV  D7, X14
    FMOV  V7.D[1], X6
    FMOV  D8, X23
    FMOV  V8.D[1], X3
    FMOV  D9, X28
    FMOV  V9.D[1], X21
    FMOV  D10, X19
    FMOV  V10.D[1], X25
    FMOV  D11, X7
    FMOV  V11.D[1], X5
    FMOV  D12, X22
    FMOV  V12.D[1], X19
    FMOV  D13, X22
    FMOV  V13.D[1], X24
    FMOV  D14, X17
    FMOV  V14.D[1], X25
    FMOV  D15, X7
    FMOV  V15.D[1], X12
    FMOV  D16, X8
    FMOV  V16.D[1], X5
    FMOV  D17, X6
    FMOV  V17.D[1], X25
    FMOV  D18, X4
    FMOV  V18.D[1], X19
    FMOV  D19, X20
    FMOV  V19.D[1], X19
    FMOV  D20, X28
    FMOV  V20.D[1], X8
    FMOV  D21, X12
    FMOV  V21.D[1], X3
    FMOV  D22, X7
    FMOV  V22.D[1], X23
    FMOV  D23, X20
    FMOV  V23.D[1], X29
    FMOV  D24, X28
    FMOV  V24.D[1], X3
    FMOV  D25, X8
    FMOV  V25.D[1], X23
    FMOV  D26, X17
    FMOV  V26.D[1], X29
    FMOV  D27, X20
    FMOV  V27.D[1], X12
    FMOV  D28, X18
    FMOV  V28.D[1], X12
    FMOV  D29, X21
    FMOV  V29.D[1], X8
    FMOV  D30, X28
    FMOV  V30.D[1], X2
    FMOV  D31, X25
    FMOV  V31.D[1], X8
    MOVZ  X16, #0xf, LSL #0
TaishanSimdCryptoP01_label_409:
    ZIP1  V15.2S, V1.2S, V22.2S
    UZP2  V11.4S, V8.4S, V6.4S
    EXT  V22.16B, V16.16B, V20.16B, #0x9
    UZP1  V15.4S, V18.4S, V6.4S
    UZP2  V30.2S, V18.2S, V24.2S
    UZP2  V22.4H, V10.4H, V27.4H
    UZP1  V25.4S, V4.4S, V14.4S
    UZP1  V21.4H, V11.4H, V13.4H
    UZP1  V22.8B, V20.8B, V18.8B
    ZIP2  V15.8H, V15.8H, V10.8H
    TRN1  V0.8B, V19.8B, V31.8B
    EXT  V9.8B, V24.8B, V13.8B, #0x7
    TRN1  V9.2D, V6.2D, V6.2D
    EXT  V22.8B, V6.8B, V20.8B, #0x2
    TRN1  V14.4S, V13.4S, V31.4S
    ZIP1  V1.2S, V12.2S, V19.2S
    ZIP2  V4.8B, V18.8B, V25.8B
    EXT  V15.8B, V14.8B, V31.8B, #0x7
    ZIP1  V14.2S, V18.2S, V22.2S
    EXT  V6.16B, V12.16B, V17.16B, #0x2
    EXT  V13.16B, V6.16B, V19.16B, #0x9
    ZIP2  V23.4S, V24.4S, V24.4S
    ZIP2  V23.8B, V14.8B, V13.8B
    UZP2  V0.4S, V8.4S, V9.4S
    TRN1  V6.4S, V7.4S, V18.4S
    UZP2  V21.4S, V30.4S, V22.4S
    ZIP1  V29.4H, V4.4H, V19.4H
    UZP2  V23.8B, V14.8B, V1.8B
    EXT  V18.16B, V30.16B, V21.16B, #0xe
    EXT  V13.16B, V15.16B, V7.16B, #0xc
    TRN2  V20.8B, V0.8B, V8.8B
    TRN1  V12.8B, V20.8B, V15.8B
    EXT  V19.16B, V6.16B, V29.16B, #0xc
    ZIP2  V29.16B, V14.16B, V13.16B
    ZIP2  V23.16B, V6.16B, V23.16B
    UZP2  V19.4S, V14.4S, V24.4S
    UZP1  V11.2D, V24.2D, V22.2D
    TRN1  V23.16B, V9.16B, V19.16B
    UZP1  V24.2S, V29.2S, V13.2S
    ZIP1  V24.8H, V11.8H, V24.8H
    UZP1  V17.8H, V31.8H, V26.8H
    UZP1  V4.16B, V19.16B, V11.16B
    EXT  V21.8B, V23.8B, V8.8B, #0x7
    ZIP2  V23.4S, V25.4S, V15.4S
    ZIP1  V18.2D, V6.2D, V20.2D
    ZIP1  V18.8B, V19.8B, V13.8B
    EXT  V23.8B, V21.8B, V4.8B, #0x0
    ZIP2  V10.2D, V12.2D, V9.2D
    EXT  V28.8B, V15.8B, V24.8B, #0x1
    ZIP1  V2.4H, V14.4H, V0.4H
    TRN1  V2.4S, V0.4S, V10.4S
    UZP1  V6.8B, V17.8B, V17.8B
    ZIP2  V31.16B, V13.16B, V25.16B
    EXT  V26.8B, V28.8B, V12.8B, #0x4
    TRN1  V30.16B, V23.16B, V9.16B
    UZP1  V18.4H, V8.4H, V23.4H
    TRN2  V8.8H, V5.8H, V10.8H
    ZIP1  V13.4S, V18.4S, V29.4S
    TRN1  V10.4S, V2.4S, V21.4S
    UZP1  V9.2D, V31.2D, V26.2D
    ZIP2  V5.2D, V4.2D, V19.2D
    EXT  V19.16B, V23.16B, V6.16B, #0xa
    ZIP1  V23.2S, V15.2S, V15.2S
    EXT  V23.8B, V24.8B, V1.8B, #0x7
    ZIP2  V13.16B, V6.16B, V8.16B
    EXT  V25.8B, V4.8B, V18.8B, #0x0
    TRN2  V29.4H, V25.4H, V25.4H
    EXT  V4.16B, V3.16B, V26.16B, #0xa
    ZIP1  V24.4S, V30.4S, V2.4S
    ZIP1  V14.8H, V28.8H, V22.8H
    ZIP1  V4.2D, V12.2D, V10.2D
    EXT  V8.16B, V18.16B, V28.16B, #0xb
    ZIP2  V13.2D, V22.2D, V18.2D
    UZP2  V26.4S, V28.4S, V28.4S
    UZP2  V22.2D, V26.2D, V30.2D
    EXT  V1.8B, V20.8B, V10.8B, #0x7
    TRN1  V26.16B, V1.16B, V18.16B
    TRN2  V8.4S, V15.4S, V0.4S
    EXT  V26.16B, V12.16B, V30.16B, #0xa
    TRN2  V2.4H, V2.4H, V5.4H
    ZIP1  V2.2S, V5.2S, V7.2S
    UZP1  V20.2S, V21.2S, V23.2S
    UZP1  V6.4H, V8.4H, V2.4H
    TRN2  V18.4S, V7.4S, V12.4S
    TRN1  V17.4H, V26.4H, V15.4H
    TRN1  V11.8H, V15.8H, V30.8H
    ZIP2  V31.2S, V19.2S, V27.2S
    UZP1  V3.2S, V10.2S, V6.2S
    EXT  V9.8B, V22.8B, V0.8B, #0x5
    UZP1  V4.4S, V22.4S, V9.4S
    UZP1  V8.4H, V9.4H, V25.4H
    TRN2  V8.8H, V8.8H, V10.8H
    UZP1  V17.2S, V4.2S, V25.2S
    UZP2  V12.8H, V10.8H, V13.8H
    TRN1  V13.4H, V19.4H, V4.4H
    ZIP1  V26.8B, V13.8B, V8.8B
    UZP2  V13.4H, V15.4H, V26.4H
    ZIP1  V9.2S, V20.2S, V30.2S
    ZIP1  V21.2D, V23.2D, V25.2D
    UZP2  V26.2S, V17.2S, V19.2S
    ZIP2  V3.2D, V30.2D, V24.2D
    TRN1  V30.8H, V27.8H, V26.8H
    ZIP2  V6.2S, V20.2S, V12.2S
    UZP2  V30.8H, V14.8H, V31.8H
    TRN1  V22.8B, V26.8B, V18.8B
    EXT  V26.8B, V11.8B, V27.8B, #0x5
    EXT  V30.8B, V21.8B, V17.8B, #0x6
    TRN1  V15.8H, V28.8H, V26.8H
    UZP2  V2.4H, V15.4H, V1.4H
    ZIP2  V2.2D, V18.2D, V1.2D
    EXT  V7.8B, V15.8B, V1.8B, #0x5
    ZIP2  V28.4S, V3.4S, V3.4S
    EXT  V7.8B, V29.8B, V13.8B, #0x7
    TRN2  V7.2D, V5.2D, V25.2D
    UZP1  V22.2D, V22.2D, V21.2D
    UZP1  V30.2D, V26.2D, V17.2D
    EXT  V28.8B, V6.8B, V19.8B, #0x6
    ZIP1  V19.16B, V20.16B, V27.16B
    UZP2  V27.4H, V27.4H, V10.4H
    ZIP2  V29.16B, V2.16B, V5.16B
    TRN2  V5.8B, V13.8B, V1.8B
    EXT  V10.16B, V18.16B, V18.16B, #0x1
    EXT  V7.16B, V10.16B, V14.16B, #0xa
    UZP2  V11.2S, V28.2S, V15.2S
    ZIP2  V12.2D, V30.2D, V11.2D
    TRN2  V3.2D, V9.2D, V0.2D
    UZP2  V10.4H, V31.4H, V22.4H
    ZIP2  V6.2S, V12.2S, V6.2S
    ZIP1  V10.8B, V25.8B, V6.8B
    UZP2  V19.8B, V13.8B, V6.8B
    UZP2  V24.2S, V23.2S, V3.2S
    ZIP2  V7.2D, V5.2D, V16.2D
    TRN2  V21.16B, V27.16B, V10.16B
    ZIP1  V4.2S, V29.2S, V14.2S
    ZIP2  V9.2D, V26.2D, V23.2D
    TRN1  V3.4H, V26.4H, V5.4H
    ZIP2  V3.8H, V20.8H, V26.8H
    TRN1  V29.8B, V9.8B, V16.8B
    UZP2  V5.8H, V16.8H, V10.8H
    TRN1  V10.8B, V24.8B, V31.8B
    UZP2  V5.8H, V20.8H, V10.8H
    EXT  V30.16B, V20.16B, V11.16B, #0xf
    ZIP1  V22.4H, V26.4H, V3.4H
    EXT  V25.16B, V26.16B, V5.16B, #0x3
    UZP2  V14.2S, V16.2S, V23.2S
    EXT  V27.16B, V28.16B, V10.16B, #0x7
    EXT  V0.16B, V25.16B, V12.16B, #0x2
    UZP1  V26.2S, V24.2S, V27.2S
    UZP2  V27.2D, V30.2D, V13.2D
    UZP1  V22.4S, V25.4S, V22.4S
    ZIP2  V3.8B, V23.8B, V7.8B
    TRN2  V3.4H, V1.4H, V7.4H
    TRN2  V19.4H, V21.4H, V22.4H
    EXT  V26.16B, V14.16B, V22.16B, #0x4
    TRN1  V24.4H, V29.4H, V16.4H
    UZP1  V11.4S, V17.4S, V24.4S
    EXT  V15.16B, V11.16B, V20.16B, #0xe
    UZP1  V9.4S, V19.4S, V10.4S
    TRN1  V3.4S, V23.4S, V4.4S
    ZIP2  V8.8H, V2.8H, V29.8H
    TRN1  V10.8H, V21.8H, V22.8H
    TRN1  V31.8H, V6.8H, V2.8H
    UZP2  V12.4S, V1.4S, V24.4S
    TRN2  V24.8B, V27.8B, V18.8B
    EXT  V8.16B, V9.16B, V8.16B, #0xa
    UZP2  V3.4H, V15.4H, V3.4H
    TRN1  V25.8H, V25.8H, V23.8H
    ZIP2  V30.8B, V26.8B, V25.8B
    TRN2  V7.2S, V28.2S, V0.2S
    EXT  V12.16B, V30.16B, V7.16B, #0x1
    TRN2  V6.4S, V3.4S, V20.4S
    UZP1  V25.4S, V27.4S, V10.4S
    EXT  V0.8B, V23.8B, V10.8B, #0x7
    UZP1  V9.4S, V26.4S, V0.4S
    UZP1  V2.2D, V31.2D, V12.2D
    UZP1  V2.8H, V21.8H, V0.8H
    UZP2  V28.4S, V20.4S, V0.4S
    UZP2  V15.2S, V4.2S, V27.2S
    TRN1  V22.16B, V1.16B, V30.16B
    ZIP2  V9.8B, V31.8B, V6.8B
    ZIP2  V8.4S, V27.4S, V24.4S
    TRN1  V28.4H, V20.4H, V20.4H
    ZIP2  V3.8B, V11.8B, V9.8B
    EXT  V4.16B, V18.16B, V28.16B, #0x8
    UZP1  V4.4S, V28.4S, V8.4S
    EXT  V7.16B, V28.16B, V9.16B, #0x5
    ZIP1  V25.2D, V13.2D, V11.2D
    UZP1  V29.4H, V4.4H, V15.4H
    ZIP2  V11.16B, V20.16B, V17.16B
    TRN2  V1.8H, V10.8H, V17.8H
    EXT  V21.16B, V16.16B, V24.16B, #0x0
    ZIP2  V23.16B, V4.16B, V21.16B
    ZIP2  V12.8H, V14.8H, V15.8H
    EXT  V15.8B, V18.8B, V23.8B, #0x4
    TRN2  V19.4H, V8.4H, V11.4H
    UZP1  V7.4S, V24.4S, V5.4S
    UZP1  V16.4S, V3.4S, V29.4S
    ZIP2  V15.8B, V9.8B, V15.8B
    UZP2  V1.8B, V16.8B, V1.8B
    EXT  V10.8B, V11.8B, V0.8B, #0x6
    SUBS  X16, X16, #0x1
    B.NE  TaishanSimdCryptoP01_label_409
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X5, X18, X2
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X12, X7, X3
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X22, X8, X4
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X5
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X21, X27, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X14, X20, X8
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X9
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X9, X26, X10
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X11, X10, X11
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X7, X12, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X11, X21, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X22, X7, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X13, X6, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X5, X22, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X25, X16, X22
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X12, X21, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X24
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X11, X6, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X19, X20, X27
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X10, X24, X28
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X14, X5, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X18, X16, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D3
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D5
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D6
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X12
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X6, X24, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D9
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X11
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D10
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X18
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X4
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X25, X26, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D14
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X19
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D16
    MOVZ  X22, #0x0, LSL #0
    SUB  X24, X22, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D17
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D18
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D19
    MOVZ  X17, #0x0, LSL #0
    SUB  X25, X17, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X7, X25, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D21
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X19
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X2
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D23
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D24
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X14
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D28
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D29
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x7a29, LSL #0
    MOVK  X2, #0xb199, LSL #16
    MOVK  X2, #0xbcd8, LSL #32
    MOVK  X2, #0xc724, LSL #48
    MOVZ  X3, #0xea80, LSL #0
    MOVK  X3, #0x3851, LSL #16
    MOVK  X3, #0xaebe, LSL #32
    MOVK  X3, #0x948c, LSL #48
    MOVZ  X4, #0x5c05, LSL #0
    MOVK  X4, #0x820c, LSL #16
    MOVK  X4, #0x8921, LSL #32
    MOVK  X4, #0xd701, LSL #48
    MOVZ  X5, #0xce4c, LSL #0
    MOVK  X5, #0xcf9b, LSL #16
    MOVK  X5, #0x955c, LSL #32
    MOVK  X5, #0x76f, LSL #48
    MOVZ  X6, #0x250f, LSL #0
    MOVK  X6, #0x22e2, LSL #16
    MOVK  X6, #0x546b, LSL #32
    MOVK  X6, #0x346b, LSL #48
    MOVZ  X7, #0x3b1b, LSL #0
    MOVK  X7, #0x7de3, LSL #16
    MOVK  X7, #0xa0b4, LSL #32
    MOVK  X7, #0xa06a, LSL #48
    MOVZ  X8, #0xbc71, LSL #0
    MOVK  X8, #0x9ea1, LSL #16
    MOVK  X8, #0xdad3, LSL #32
    MOVK  X8, #0x742b, LSL #48
    MOVZ  X9, #0x471e, LSL #0
    MOVK  X9, #0x2589, LSL #16
    MOVK  X9, #0x8d1f, LSL #32
    MOVK  X9, #0x6f9b, LSL #48
    MOVZ  X10, #0xc25e, LSL #0
    MOVK  X10, #0x2f84, LSL #16
    MOVK  X10, #0xc7d7, LSL #32
    MOVK  X10, #0xf3b8, LSL #48
    MOVZ  X11, #0xcadc, LSL #0
    MOVK  X11, #0x4c6c, LSL #16
    MOVK  X11, #0x86aa, LSL #32
    MOVK  X11, #0x66aa, LSL #48
    MOVZ  X12, #0xc0e7, LSL #0
    MOVK  X12, #0xb49d, LSL #16
    MOVK  X12, #0x8a47, LSL #32
    MOVK  X12, #0x3278, LSL #48
    MOVZ  X13, #0xb4e2, LSL #0
    MOVK  X13, #0xa867, LSL #16
    MOVK  X13, #0x1f87, LSL #32
    MOVK  X13, #0xecf5, LSL #48
    MOVZ  X14, #0x48, LSL #0
    MOVK  X14, #0xb4ce, LSL #16
    MOVK  X14, #0x73f4, LSL #32
    MOVK  X14, #0x6291, LSL #48
    MOVZ  X16, #0x49a0, LSL #0
    MOVK  X16, #0x9466, LSL #16
    MOVK  X16, #0xb82a, LSL #32
    MOVK  X16, #0x7e30, LSL #48
    MOVZ  X17, #0xb110, LSL #0
    MOVK  X17, #0x82e9, LSL #16
    MOVK  X17, #0xdca3, LSL #32
    MOVK  X17, #0xdf53, LSL #48
    MOVZ  X18, #0xc6ba, LSL #0
    MOVK  X18, #0x7dcb, LSL #16
    MOVK  X18, #0x8d59, LSL #32
    MOVK  X18, #0x44f4, LSL #48
    MOVZ  X19, #0xfaa5, LSL #0
    MOVK  X19, #0xfd32, LSL #16
    MOVK  X19, #0x64f9, LSL #32
    MOVK  X19, #0xaf6, LSL #48
    MOVZ  X20, #0x1613, LSL #0
    MOVK  X20, #0xc721, LSL #16
    MOVK  X20, #0x2945, LSL #32
    MOVK  X20, #0x5948, LSL #48
    MOVZ  X21, #0xf53b, LSL #0
    MOVK  X21, #0x3d02, LSL #16
    MOVK  X21, #0x81e4, LSL #32
    MOVK  X21, #0xd8ce, LSL #48
    MOVZ  X22, #0xdf73, LSL #0
    MOVK  X22, #0x4bc4, LSL #16
    MOVK  X22, #0x3b94, LSL #32
    MOVK  X22, #0x97d, LSL #48
    MOVZ  X23, #0x5118, LSL #0
    MOVK  X23, #0xfb12, LSL #16
    MOVK  X23, #0xa94d, LSL #32
    MOVK  X23, #0x9cb1, LSL #48
    MOVZ  X24, #0xb760, LSL #0
    MOVK  X24, #0xec7c, LSL #16
    MOVK  X24, #0xa492, LSL #32
    MOVK  X24, #0x3d9c, LSL #48
    MOVZ  X25, #0x8673, LSL #0
    MOVK  X25, #0xd5d1, LSL #16
    MOVK  X25, #0x3367, LSL #32
    MOVK  X25, #0xab14, LSL #48
    MOVZ  X26, #0xdf92, LSL #0
    MOVK  X26, #0xca71, LSL #16
    MOVK  X26, #0x1062, LSL #32
    MOVK  X26, #0x7067, LSL #48
    MOVZ  X27, #0x20d3, LSL #0
    MOVK  X27, #0x65b5, LSL #16
    MOVK  X27, #0x5c08, LSL #32
    MOVK  X27, #0xdeeb, LSL #48
    MOVZ  X28, #0x3f04, LSL #0
    MOVK  X28, #0x3254, LSL #16
    MOVK  X28, #0xae6d, LSL #32
    MOVK  X28, #0xc255, LSL #48
    MOVZ  X29, #0xe03, LSL #0
    MOVK  X29, #0x8457, LSL #16
    MOVK  X29, #0x4f96, LSL #32
    MOVK  X29, #0x9b8f, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X23
    FMOV  D1, X12
    FMOV  V1.D[1], X21
    FMOV  D2, X18
    FMOV  V2.D[1], X13
    FMOV  D3, X9
    FMOV  V3.D[1], X7
    FMOV  D4, X21
    FMOV  V4.D[1], X2
    FMOV  D5, X6
    FMOV  V5.D[1], X18
    FMOV  D6, X5
    FMOV  V6.D[1], X29
    FMOV  D7, X7
    FMOV  V7.D[1], X13
    FMOV  D8, X12
    FMOV  V8.D[1], X19
    FMOV  D9, X18
    FMOV  V9.D[1], X12
    FMOV  D10, X9
    FMOV  V10.D[1], X13
    FMOV  D11, X6
    FMOV  V11.D[1], X25
    FMOV  D12, X14
    FMOV  V12.D[1], X27
    FMOV  D13, X27
    FMOV  V13.D[1], X13
    FMOV  D14, X5
    FMOV  V14.D[1], X2
    FMOV  D15, X6
    FMOV  V15.D[1], X20
    FMOV  D16, X10
    FMOV  V16.D[1], X23
    FMOV  D17, X27
    FMOV  V17.D[1], X10
    FMOV  D18, X12
    FMOV  V18.D[1], X16
    FMOV  D19, X27
    FMOV  V19.D[1], X6
    FMOV  D20, X27
    FMOV  V20.D[1], X7
    FMOV  D21, X14
    FMOV  V21.D[1], X12
    FMOV  D22, X9
    FMOV  V22.D[1], X20
    FMOV  D23, X29
    FMOV  V23.D[1], X26
    FMOV  D24, X18
    FMOV  V24.D[1], X20
    FMOV  D25, X23
    FMOV  V25.D[1], X6
    FMOV  D26, X16
    FMOV  V26.D[1], X3
    FMOV  D27, X18
    FMOV  V27.D[1], X22
    FMOV  D28, X14
    FMOV  V28.D[1], X2
    FMOV  D29, X5
    FMOV  V29.D[1], X23
    FMOV  D30, X6
    FMOV  V30.D[1], X26
    FMOV  D31, X4
    FMOV  V31.D[1], X28
    MOVZ  X28, #0xa, LSL #0
TaishanSimdCryptoP01_label_489:
    TRN1  V26.8B, V17.8B, V8.8B
    UZP1  V11.8B, V24.8B, V29.8B
    ZIP2  V20.2D, V3.2D, V14.2D
    ZIP2  V16.4H, V30.4H, V28.4H
    EXT  V16.16B, V9.16B, V21.16B, #0x1
    EXT  V27.8B, V29.8B, V1.8B, #0x2
    UZP2  V21.2S, V11.2S, V20.2S
    ZIP1  V10.4S, V10.4S, V19.4S
    EXT  V26.8B, V9.8B, V28.8B, #0x5
    ZIP1  V7.4H, V4.4H, V12.4H
    EXT  V3.8B, V18.8B, V6.8B, #0x0
    EXT  V28.8B, V12.8B, V10.8B, #0x1
    EXT  V13.16B, V6.16B, V10.16B, #0xb
    EXT  V18.16B, V4.16B, V24.16B, #0x0
    EXT  V19.16B, V2.16B, V18.16B, #0x8
    EXT  V12.8B, V12.8B, V28.8B, #0x6
    TRN1  V11.2S, V13.2S, V30.2S
    TRN2  V22.4S, V31.4S, V31.4S
    EXT  V10.8B, V27.8B, V17.8B, #0x3
    ZIP2  V5.2S, V5.2S, V1.2S
    UZP1  V22.4S, V1.4S, V21.4S
    ZIP1  V22.4S, V26.4S, V14.4S
    ZIP1  V10.16B, V15.16B, V12.16B
    TRN2  V5.2D, V29.2D, V19.2D
    TRN2  V7.2S, V27.2S, V19.2S
    TRN1  V14.8B, V22.8B, V5.8B
    ZIP2  V25.4S, V23.4S, V24.4S
    TRN1  V23.2D, V21.2D, V26.2D
    EXT  V21.8B, V6.8B, V19.8B, #0x1
    UZP1  V12.8B, V26.8B, V28.8B
    EXT  V2.8B, V24.8B, V31.8B, #0x0
    ZIP1  V23.2S, V19.2S, V11.2S
    ZIP1  V17.8H, V27.8H, V1.8H
    EXT  V16.8B, V9.8B, V1.8B, #0x6
    EXT  V16.8B, V18.8B, V27.8B, #0x4
    ZIP2  V2.2S, V21.2S, V11.2S
    UZP1  V10.8B, V1.8B, V13.8B
    EXT  V10.8B, V29.8B, V3.8B, #0x7
    UZP2  V12.8B, V10.8B, V9.8B
    ZIP2  V2.4S, V6.4S, V14.4S
    EXT  V18.16B, V29.16B, V14.16B, #0x1
    UZP2  V11.2D, V28.2D, V23.2D
    ZIP2  V26.8B, V20.8B, V4.8B
    TRN2  V2.2S, V31.2S, V6.2S
    UZP1  V21.8B, V21.8B, V18.8B
    EXT  V5.8B, V23.8B, V14.8B, #0x4
    TRN1  V13.16B, V2.16B, V28.16B
    EXT  V8.8B, V13.8B, V19.8B, #0x1
    ZIP1  V20.8B, V20.8B, V8.8B
    ZIP2  V16.4H, V16.4H, V31.4H
    TRN1  V6.4S, V18.4S, V20.4S
    ZIP2  V17.2S, V24.2S, V14.2S
    UZP1  V8.8H, V17.8H, V10.8H
    TRN1  V1.2S, V6.2S, V23.2S
    ZIP1  V3.8H, V11.8H, V10.8H
    ZIP2  V4.2D, V31.2D, V4.2D
    TRN1  V9.8B, V5.8B, V19.8B
    ZIP1  V1.2S, V23.2S, V26.2S
    EXT  V25.8B, V14.8B, V6.8B, #0x7
    ZIP1  V6.4S, V9.4S, V16.4S
    EXT  V28.16B, V5.16B, V13.16B, #0x5
    TRN2  V21.8B, V13.8B, V6.8B
    EXT  V30.16B, V30.16B, V8.16B, #0xf
    UZP1  V30.2S, V20.2S, V17.2S
    TRN1  V14.16B, V25.16B, V30.16B
    ZIP2  V11.8B, V16.8B, V5.8B
    ZIP2  V24.8H, V31.8H, V15.8H
    UZP1  V4.4S, V10.4S, V24.4S
    EXT  V19.16B, V8.16B, V19.16B, #0x3
    EXT  V28.16B, V16.16B, V26.16B, #0xd
    EXT  V6.16B, V14.16B, V19.16B, #0x1
    ZIP1  V1.2S, V20.2S, V21.2S
    EXT  V3.16B, V30.16B, V4.16B, #0x3
    ZIP1  V11.4S, V4.4S, V30.4S
    TRN2  V31.8H, V13.8H, V11.8H
    EXT  V28.8B, V8.8B, V6.8B, #0x4
    TRN1  V28.2S, V11.2S, V16.2S
    ZIP1  V18.4S, V1.4S, V7.4S
    UZP2  V21.2D, V3.2D, V24.2D
    ZIP2  V28.16B, V6.16B, V10.16B
    ZIP2  V1.2D, V31.2D, V17.2D
    ZIP2  V15.2D, V10.2D, V12.2D
    UZP1  V20.4S, V1.4S, V14.4S
    UZP2  V7.2S, V30.2S, V22.2S
    UZP2  V15.4H, V23.4H, V16.4H
    ZIP1  V11.2D, V30.2D, V17.2D
    TRN2  V26.2D, V4.2D, V24.2D
    TRN2  V0.4H, V14.4H, V1.4H
    TRN2  V27.4S, V20.4S, V12.4S
    EXT  V24.16B, V10.16B, V20.16B, #0x2
    TRN1  V23.2D, V23.2D, V12.2D
    ZIP2  V17.8B, V18.8B, V5.8B
    ZIP2  V29.16B, V4.16B, V31.16B
    UZP2  V13.8B, V6.8B, V8.8B
    ZIP1  V3.8B, V6.8B, V4.8B
    ZIP1  V3.2D, V5.2D, V21.2D
    UZP1  V14.4H, V7.4H, V13.4H
    EXT  V17.16B, V30.16B, V23.16B, #0x5
    TRN2  V21.2S, V0.2S, V13.2S
    EXT  V9.8B, V17.8B, V0.8B, #0x4
    ZIP2  V27.4H, V1.4H, V19.4H
    EXT  V3.16B, V23.16B, V13.16B, #0x1
    UZP2  V27.16B, V26.16B, V29.16B
    UZP2  V14.4S, V17.4S, V15.4S
    ZIP1  V5.8H, V4.8H, V22.8H
    TRN1  V29.4H, V5.4H, V6.4H
    TRN2  V0.8H, V3.8H, V10.8H
    ZIP1  V3.2D, V10.2D, V14.2D
    UZP2  V25.4H, V0.4H, V26.4H
    EXT  V21.8B, V7.8B, V24.8B, #0x0
    EXT  V24.16B, V21.16B, V19.16B, #0x5
    EXT  V12.16B, V16.16B, V13.16B, #0x5
    ZIP1  V30.2S, V28.2S, V4.2S
    EXT  V1.8B, V23.8B, V8.8B, #0x1
    ZIP1  V17.4H, V1.4H, V11.4H
    EXT  V21.16B, V16.16B, V4.16B, #0x4
    ZIP2  V8.4S, V14.4S, V14.4S
    UZP1  V11.4S, V26.4S, V10.4S
    ZIP1  V0.2D, V3.2D, V25.2D
    EXT  V13.16B, V11.16B, V22.16B, #0xb
    EXT  V29.16B, V4.16B, V27.16B, #0x2
    TRN1  V3.4H, V14.4H, V1.4H
    TRN2  V19.8B, V30.8B, V14.8B
    UZP1  V27.4S, V5.4S, V8.4S
    EXT  V28.8B, V31.8B, V25.8B, #0x3
    UZP1  V9.2S, V16.2S, V7.2S
    EXT  V30.8B, V5.8B, V20.8B, #0x6
    TRN1  V11.8B, V23.8B, V25.8B
    UZP2  V22.16B, V20.16B, V24.16B
    TRN2  V27.4S, V26.4S, V29.4S
    TRN1  V6.2S, V30.2S, V19.2S
    UZP2  V9.8B, V24.8B, V21.8B
    TRN2  V24.4S, V12.4S, V17.4S
    UZP1  V18.2S, V9.2S, V11.2S
    EXT  V24.16B, V21.16B, V13.16B, #0xf
    ZIP2  V14.8B, V23.8B, V19.8B
    UZP2  V1.16B, V13.16B, V24.16B
    ZIP1  V18.8B, V17.8B, V11.8B
    TRN1  V1.2D, V11.2D, V5.2D
    ZIP2  V18.8H, V3.8H, V14.8H
    UZP2  V18.8B, V5.8B, V28.8B
    ZIP2  V15.4H, V5.4H, V9.4H
    TRN1  V24.8H, V26.8H, V20.8H
    TRN2  V30.2D, V6.2D, V16.2D
    ZIP1  V17.4S, V25.4S, V10.4S
    UZP1  V14.4S, V14.4S, V29.4S
    TRN1  V31.4S, V1.4S, V28.4S
    ZIP1  V6.8H, V22.8H, V7.8H
    ZIP2  V9.2D, V23.2D, V25.2D
    TRN1  V27.4H, V6.4H, V26.4H
    ZIP2  V19.4S, V26.4S, V24.4S
    ZIP1  V1.2S, V18.2S, V24.2S
    TRN2  V21.4H, V1.4H, V10.4H
    EXT  V1.16B, V21.16B, V1.16B, #0xe
    EXT  V4.8B, V0.8B, V28.8B, #0x5
    ZIP2  V10.8B, V11.8B, V1.8B
    UZP2  V10.4H, V2.4H, V14.4H
    TRN2  V12.8B, V28.8B, V17.8B
    TRN2  V15.2D, V30.2D, V3.2D
    ZIP2  V8.16B, V23.16B, V24.16B
    UZP2  V20.8H, V2.8H, V6.8H
    ZIP2  V22.4S, V20.4S, V31.4S
    TRN1  V21.16B, V0.16B, V1.16B
    TRN1  V21.16B, V27.16B, V7.16B
    ZIP2  V12.4H, V22.4H, V9.4H
    ZIP1  V3.4S, V25.4S, V21.4S
    EXT  V4.16B, V14.16B, V27.16B, #0x5
    EXT  V15.8B, V31.8B, V11.8B, #0x4
    ZIP2  V27.4H, V7.4H, V20.4H
    TRN2  V9.16B, V16.16B, V2.16B
    ZIP2  V10.4S, V12.4S, V10.4S
    ZIP1  V31.2D, V30.2D, V3.2D
    ZIP1  V26.4H, V7.4H, V31.4H
    UZP1  V1.2S, V4.2S, V2.2S
    EXT  V14.8B, V16.8B, V27.8B, #0x1
    TRN1  V26.8B, V20.8B, V23.8B
    EXT  V3.16B, V8.16B, V19.16B, #0xc
    ZIP1  V2.8H, V22.8H, V24.8H
    UZP1  V9.2D, V0.2D, V4.2D
    EXT  V18.8B, V7.8B, V2.8B, #0x7
    ZIP2  V18.8B, V31.8B, V9.8B
    TRN1  V15.2D, V9.2D, V2.2D
    TRN1  V15.8H, V4.8H, V20.8H
    ZIP2  V28.8B, V20.8B, V19.8B
    TRN1  V16.2S, V2.2S, V30.2S
    ZIP2  V11.4S, V25.4S, V27.4S
    TRN2  V31.16B, V3.16B, V12.16B
    UZP1  V14.2S, V26.2S, V5.2S
    TRN1  V17.2S, V21.2S, V10.2S
    ZIP1  V0.16B, V23.16B, V28.16B
    ZIP1  V30.8H, V27.8H, V30.8H
    ZIP1  V17.2S, V0.2S, V18.2S
    EXT  V26.16B, V15.16B, V30.16B, #0xc
    ZIP1  V8.2S, V31.2S, V24.2S
    EXT  V29.8B, V0.8B, V3.8B, #0x3
    ZIP2  V27.4H, V29.4H, V18.4H
    UZP2  V9.4S, V12.4S, V18.4S
    TRN1  V15.2S, V9.2S, V14.2S
    UZP1  V15.4H, V3.4H, V14.4H
    UZP2  V21.8H, V1.8H, V29.8H
    SUBS  X28, X28, #0x1
    B.NE  TaishanSimdCryptoP01_label_489
    MOVZ  X7, #0x7a29, LSL #0
    MOVK  X7, #0xb199, LSL #16
    MOVK  X7, #0xbcd8, LSL #32
    MOVK  X7, #0xc724, LSL #48
    SUB  X23, X7, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xea80, LSL #0
    MOVK  X8, #0x3851, LSL #16
    MOVK  X8, #0xaebe, LSL #32
    MOVK  X8, #0x948c, LSL #48
    SUB  X7, X8, X3
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x5c05, LSL #0
    MOVK  X3, #0x820c, LSL #16
    MOVK  X3, #0x8921, LSL #32
    MOVK  X3, #0xd701, LSL #48
    SUB  X12, X3, X4
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0xce4c, LSL #0
    MOVK  X4, #0xcf9b, LSL #16
    MOVK  X4, #0x955c, LSL #32
    MOVK  X4, #0x76f, LSL #48
    SUB  X18, X4, X5
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x250f, LSL #0
    MOVK  X18, #0x22e2, LSL #16
    MOVK  X18, #0x546b, LSL #32
    MOVK  X18, #0x346b, LSL #48
    SUB  X10, X18, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X2, X26, X7
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0xea80, LSL #0
    MOVK  X13, #0x3851, LSL #16
    MOVK  X13, #0xaebe, LSL #32
    MOVK  X13, #0x948c, LSL #48
    SUB  X6, X13, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x471e, LSL #0
    MOVK  X17, #0x2589, LSL #16
    MOVK  X17, #0x8d1f, LSL #32
    MOVK  X17, #0x6f9b, LSL #48
    SUB  X18, X17, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0xcadc, LSL #0
    MOVK  X13, #0x4c6c, LSL #16
    MOVK  X13, #0x86aa, LSL #32
    MOVK  X13, #0x66aa, LSL #48
    SUB  X7, X13, X11
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0xcadc, LSL #0
    MOVK  X10, #0x4c6c, LSL #16
    MOVK  X10, #0x86aa, LSL #32
    MOVK  X10, #0x66aa, LSL #48
    SUB  X27, X10, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x48, LSL #0
    MOVK  X16, #0xb4ce, LSL #16
    MOVK  X16, #0x73f4, LSL #32
    MOVK  X16, #0x6291, LSL #48
    SUB  X27, X16, X14
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x48, LSL #0
    MOVK  X11, #0xb4ce, LSL #16
    MOVK  X11, #0x73f4, LSL #32
    MOVK  X11, #0x6291, LSL #48
    SUB  X13, X11, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x471e, LSL #0
    MOVK  X10, #0x2589, LSL #16
    MOVK  X10, #0x8d1f, LSL #32
    MOVK  X10, #0x6f9b, LSL #48
    SUB  X22, X10, X17
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x1613, LSL #0
    MOVK  X25, #0xc721, LSL #16
    MOVK  X25, #0x2945, LSL #32
    MOVK  X25, #0x5948, LSL #48
    SUB  X27, X25, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0xf53b, LSL #0
    MOVK  X29, #0x3d02, LSL #16
    MOVK  X29, #0x81e4, LSL #32
    MOVK  X29, #0xd8ce, LSL #48
    SUB  X14, X29, X21
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X5, X14, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X23
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xb760, LSL #0
    MOVK  X8, #0xec7c, LSL #16
    MOVK  X8, #0xa492, LSL #32
    MOVK  X8, #0x3d9c, LSL #48
    SUB  X20, X8, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x1613, LSL #0
    MOVK  X3, #0xc721, LSL #16
    MOVK  X3, #0x2945, LSL #32
    MOVK  X3, #0x5948, LSL #48
    SUB  X18, X3, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X10, X8, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0xf53b, LSL #0
    MOVK  X6, #0x3d02, LSL #16
    MOVK  X6, #0x81e4, LSL #32
    MOVK  X6, #0xd8ce, LSL #48
    SUB  X26, X6, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D2
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D3
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D5
    MOVZ  X14, #0x0, LSL #0
    SUB  X28, X14, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X25, X22, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D7
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X22
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D8
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X5, #0x8a00, LSL #0
TaishanSimdCryptoP01_label_512:
    SUB  X26, X5, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D9
    MOVZ  X5, #0x0, LSL #0
    SUB  X26, X5, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D10
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D11
    MOVZ  X19, #0x0, LSL #0
    SUB  X21, X19, X29
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D12
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X3
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D16
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D17
    MOVZ  X11, #0x0, LSL #0
    SUB  X21, X11, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D18
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8a00, LSL #32
    SUB  X11, X3, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D20
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X16, X6, X4
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X20, X23, X6
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X19
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D24
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D25
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8a, LSL #16
    SUB  X12, X11, X21
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D26
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X9
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X4, X8, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D27
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8a00, LSL #16
    SUB  X4, X8, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X14
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D29
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
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
    FMOV  V0.D[1], X8
    FMOV  D1, X13
    FMOV  V1.D[1], X17
    FMOV  D2, X24
    FMOV  V2.D[1], X23
    FMOV  D3, X12
    FMOV  V3.D[1], X10
    FMOV  D4, X26
    FMOV  V4.D[1], X29
    FMOV  D5, X14
    FMOV  V5.D[1], X7
    FMOV  D6, X17
    FMOV  V6.D[1], X22
    FMOV  D7, X21
    FMOV  V7.D[1], X17
    FMOV  D8, X22
    FMOV  V8.D[1], X23
    FMOV  D9, X7
    FMOV  V9.D[1], X13
    FMOV  D10, X13
    FMOV  V10.D[1], X18
    FMOV  D11, X18
    FMOV  V11.D[1], X27
    FMOV  D12, X2
    FMOV  V12.D[1], X10
    FMOV  D13, X21
    FMOV  V13.D[1], X27
    FMOV  D14, X2
    FMOV  V14.D[1], X18
    FMOV  D15, X28
    FMOV  V15.D[1], X28
    FMOV  D16, X29
    FMOV  V16.D[1], X16
    FMOV  D17, X18
    FMOV  V17.D[1], X28
    FMOV  D18, X2
    FMOV  V18.D[1], X28
    FMOV  D19, X14
    FMOV  V19.D[1], X7
    FMOV  D20, X3
    FMOV  V20.D[1], X6
    FMOV  D21, X10
    FMOV  V21.D[1], X7
    FMOV  D22, X14
    FMOV  V22.D[1], X26
    FMOV  D23, X12
    FMOV  V23.D[1], X4
    FMOV  D24, X20
    FMOV  V24.D[1], X22
    FMOV  D25, X26
    FMOV  V25.D[1], X13
    FMOV  D26, X5
    FMOV  V26.D[1], X2
    FMOV  D27, X14
    FMOV  V27.D[1], X21
    FMOV  D28, X21
    FMOV  V28.D[1], X27
    FMOV  D29, X4
    FMOV  V29.D[1], X26
    FMOV  D30, X6
    FMOV  V30.D[1], X29
    FMOV  D31, X28
    FMOV  V31.D[1], X9
    MOVZ  X27, #0xa, LSL #0
TaishanSimdCryptoP01_label_571:
    ZIP2  V29.2D, V23.2D, V27.2D
    TRN2  V5.16B, V25.16B, V18.16B
    EXT  V29.8B, V3.8B, V28.8B, #0x2
    ZIP1  V27.2D, V5.2D, V30.2D
    EXT  V31.16B, V14.16B, V29.16B, #0x6
    UZP2  V2.4S, V0.4S, V18.4S
    EXT  V26.8B, V30.8B, V14.8B, #0x5
    TRN2  V10.16B, V25.16B, V28.16B
    UZP2  V10.2D, V20.2D, V21.2D
    EXT  V8.8B, V12.8B, V10.8B, #0x6
    UZP1  V26.2D, V13.2D, V26.2D
    ZIP1  V12.8H, V22.8H, V31.8H
    EXT  V27.16B, V12.16B, V23.16B, #0xe
    ZIP1  V12.8H, V12.8H, V27.8H
    TRN1  V8.8B, V2.8B, V17.8B
    TRN2  V29.8H, V4.8H, V20.8H
    ZIP1  V30.2S, V26.2S, V18.2S
    UZP2  V15.2S, V0.2S, V28.2S
    TRN2  V25.4H, V6.4H, V10.4H
    TRN1  V18.8B, V26.8B, V3.8B
    ZIP2  V4.4H, V2.4H, V14.4H
    ZIP1  V24.4S, V12.4S, V30.4S
    ZIP1  V23.8B, V0.8B, V18.8B
    ZIP1  V15.8B, V20.8B, V5.8B
    UZP1  V8.16B, V10.16B, V26.16B
    ZIP2  V20.4S, V26.4S, V4.4S
    TRN1  V19.2S, V0.2S, V29.2S
    TRN2  V4.2D, V6.2D, V23.2D
    ZIP1  V22.16B, V24.16B, V25.16B
    EXT  V31.8B, V22.8B, V6.8B, #0x6
    ZIP1  V31.4H, V10.4H, V22.4H
    ZIP2  V15.16B, V13.16B, V6.16B
    ZIP2  V15.4S, V8.4S, V11.4S
    UZP1  V18.2D, V26.2D, V8.2D
    UZP1  V13.16B, V20.16B, V20.16B
    UZP1  V8.16B, V17.16B, V8.16B
    TRN1  V18.2S, V13.2S, V28.2S
    UZP1  V28.2D, V15.2D, V28.2D
    TRN1  V30.2S, V31.2S, V0.2S
    TRN2  V27.8B, V30.8B, V0.8B
    UZP1  V7.2D, V14.2D, V13.2D
    TRN2  V1.8B, V20.8B, V17.8B
    ZIP2  V5.2S, V14.2S, V29.2S
    ZIP1  V28.16B, V26.16B, V26.16B
    UZP2  V28.8B, V28.8B, V20.8B
    TRN1  V22.8B, V6.8B, V21.8B
    UZP2  V25.8B, V9.8B, V1.8B
    ZIP1  V1.4S, V1.4S, V12.4S
    EXT  V2.16B, V5.16B, V8.16B, #0x1
    UZP1  V12.8B, V13.8B, V27.8B
    EXT  V19.16B, V8.16B, V28.16B, #0x0
    UZP1  V4.8H, V5.8H, V18.8H
    TRN1  V27.4S, V20.4S, V25.4S
    ZIP2  V22.4S, V20.4S, V14.4S
    TRN1  V18.4S, V27.4S, V28.4S
    TRN2  V27.2S, V7.2S, V20.2S
    EXT  V5.16B, V3.16B, V29.16B, #0x2
    UZP2  V22.4H, V23.4H, V16.4H
    UZP1  V16.2D, V31.2D, V1.2D
    ZIP2  V3.4S, V11.4S, V14.4S
    TRN2  V27.2S, V10.2S, V27.2S
    TRN2  V2.2D, V27.2D, V16.2D
    ZIP1  V18.8H, V1.8H, V19.8H
    ZIP2  V23.4H, V23.4H, V19.4H
    ZIP1  V0.16B, V20.16B, V6.16B
    UZP1  V24.4S, V22.4S, V19.4S
    EXT  V30.16B, V6.16B, V19.16B, #0xe
    UZP1  V29.2S, V22.2S, V0.2S
    TRN2  V23.2D, V5.2D, V31.2D
    EXT  V29.16B, V2.16B, V3.16B, #0xe
    TRN1  V28.8B, V10.8B, V20.8B
    ZIP1  V26.8B, V13.8B, V21.8B
    TRN1  V6.4S, V29.4S, V7.4S
    EXT  V6.8B, V23.8B, V28.8B, #0x6
    UZP1  V23.8B, V25.8B, V17.8B
    UZP1  V26.8H, V28.8H, V17.8H
    ZIP2  V31.2S, V8.2S, V26.2S
    UZP2  V10.4S, V0.4S, V17.4S
    TRN1  V27.8B, V23.8B, V11.8B
    UZP1  V24.16B, V22.16B, V10.16B
    ZIP2  V2.4H, V12.4H, V31.4H
    EXT  V2.8B, V1.8B, V15.8B, #0x6
TaishanSimdCryptoP01_label_173:
    ZIP2  V2.2S, V26.2S, V22.2S
    UZP2  V20.4S, V6.4S, V12.4S
    TRN2  V26.8H, V3.8H, V28.8H
    EXT  V27.8B, V15.8B, V19.8B, #0x3
    TRN2  V14.16B, V27.16B, V26.16B
    TRN2  V20.4S, V20.4S, V21.4S
    UZP1  V3.2D, V25.2D, V13.2D
    ZIP2  V27.4S, V21.4S, V28.4S
    EXT  V3.16B, V29.16B, V14.16B, #0xc
    UZP1  V8.8B, V9.8B, V4.8B
    EXT  V13.8B, V24.8B, V30.8B, #0x3
    EXT  V20.16B, V2.16B, V27.16B, #0x5
    EXT  V8.8B, V14.8B, V21.8B, #0x2
    ZIP2  V5.8H, V13.8H, V24.8H
    EXT  V3.8B, V7.8B, V27.8B, #0x0
    ZIP2  V20.8B, V10.8B, V17.8B
    EXT  V9.16B, V14.16B, V2.16B, #0xc
    EXT  V20.16B, V5.16B, V18.16B, #0x3
    EXT  V3.16B, V31.16B, V0.16B, #0xb
    UZP1  V3.4H, V15.4H, V11.4H
    TRN1  V26.2S, V8.2S, V27.2S
    UZP2  V21.4S, V10.4S, V3.4S
    ZIP1  V24.8B, V19.8B, V7.8B
    EXT  V20.16B, V31.16B, V21.16B, #0x0
    ZIP2  V2.16B, V17.16B, V11.16B
    EXT  V19.16B, V15.16B, V19.16B, #0xe
    EXT  V24.16B, V12.16B, V28.16B, #0x1
    EXT  V27.16B, V29.16B, V16.16B, #0x7
    ZIP2  V10.8H, V2.8H, V30.8H
    TRN1  V12.2D, V0.2D, V9.2D
    UZP1  V13.8B, V2.8B, V29.8B
    ZIP1  V24.4H, V27.4H, V5.4H
    EXT  V12.16B, V25.16B, V29.16B, #0xa
    TRN2  V5.16B, V2.16B, V15.16B
    EXT  V29.16B, V29.16B, V11.16B, #0x7
    TRN1  V1.16B, V19.16B, V0.16B
    ZIP2  V17.2D, V20.2D, V21.2D
    UZP2  V16.2S, V30.2S, V15.2S
    UZP1  V15.4H, V30.4H, V14.4H
    UZP1  V11.16B, V1.16B, V19.16B
    UZP2  V21.4H, V29.4H, V7.4H
    ZIP2  V14.8B, V20.8B, V5.8B
    TRN1  V0.2S, V25.2S, V24.2S
    TRN2  V1.2S, V28.2S, V31.2S
    UZP1  V8.2D, V0.2D, V3.2D
    EXT  V18.16B, V15.16B, V18.16B, #0x4
    UZP1  V30.8H, V9.8H, V24.8H
    ZIP2  V12.8H, V9.8H, V23.8H
    ZIP2  V6.8B, V9.8B, V2.8B
    EXT  V13.16B, V19.16B, V12.16B, #0x3
    TRN1  V24.2D, V8.2D, V7.2D
    TRN1  V26.2D, V18.2D, V17.2D
    TRN1  V29.16B, V13.16B, V23.16B
    EXT  V10.16B, V20.16B, V17.16B, #0xa
    EXT  V26.16B, V16.16B, V28.16B, #0x0
    ZIP1  V29.16B, V25.16B, V5.16B
    UZP1  V4.4H, V8.4H, V10.4H
    EXT  V0.16B, V27.16B, V14.16B, #0x1
    UZP1  V0.2S, V7.2S, V25.2S
    TRN1  V24.16B, V21.16B, V21.16B
    EXT  V15.8B, V29.8B, V6.8B, #0x3
    EXT  V9.16B, V2.16B, V11.16B, #0x5
    UZP1  V17.16B, V10.16B, V1.16B
    EXT  V27.8B, V31.8B, V9.8B, #0x0
    ZIP1  V7.2D, V0.2D, V4.2D
    TRN1  V5.8H, V23.8H, V25.8H
    TRN2  V18.4S, V2.4S, V7.4S
    UZP2  V24.8H, V26.8H, V14.8H
    UZP1  V12.4S, V3.4S, V30.4S
    UZP2  V12.16B, V31.16B, V24.16B
    UZP2  V18.8H, V27.8H, V15.8H
    UZP2  V7.16B, V8.16B, V26.16B
    ZIP1  V7.4S, V11.4S, V28.4S
    TRN1  V21.8B, V29.8B, V20.8B
    ZIP2  V25.2S, V26.2S, V2.2S
    UZP2  V4.8H, V13.8H, V29.8H
    TRN2  V14.2D, V21.2D, V29.2D
    TRN1  V27.4H, V25.4H, V23.4H
    EXT  V18.16B, V29.16B, V11.16B, #0xe
    UZP2  V16.2D, V12.2D, V2.2D
    TRN2  V2.4S, V12.4S, V23.4S
    ZIP1  V20.8B, V26.8B, V19.8B
    UZP2  V6.4H, V21.4H, V2.4H
    EXT  V4.8B, V7.8B, V18.8B, #0x7
    UZP2  V25.2S, V7.2S, V17.2S
    ZIP1  V16.4S, V17.4S, V21.4S
    UZP1  V13.8B, V17.8B, V2.8B
    ZIP2  V30.8H, V27.8H, V20.8H
    TRN1  V25.8B, V6.8B, V26.8B
    EXT  V14.16B, V23.16B, V28.16B, #0x3
    UZP1  V12.4H, V4.4H, V14.4H
    TRN2  V31.8B, V16.8B, V11.8B
    TRN2  V11.8B, V18.8B, V27.8B
    TRN1  V15.2S, V16.2S, V13.2S
    TRN2  V11.4H, V22.4H, V15.4H
    EXT  V19.8B, V5.8B, V20.8B, #0x1
    ZIP1  V15.8B, V4.8B, V4.8B
    TRN1  V12.8H, V4.8H, V13.8H
    EXT  V9.16B, V26.16B, V23.16B, #0x9
    ZIP1  V4.2S, V9.2S, V7.2S
    UZP1  V3.4H, V30.4H, V23.4H
    TRN2  V6.8B, V11.8B, V21.8B
    ZIP2  V12.4S, V2.4S, V12.4S
    EXT  V6.8B, V16.8B, V11.8B, #0x5
    UZP2  V4.8B, V26.8B, V29.8B
    UZP2  V31.4H, V20.4H, V19.4H
    UZP1  V27.8B, V15.8B, V14.8B
    EXT  V15.16B, V22.16B, V31.16B, #0x3
    EXT  V23.8B, V12.8B, V17.8B, #0x7
    TRN2  V23.8H, V6.8H, V24.8H
    EXT  V14.8B, V9.8B, V3.8B, #0x4
    UZP2  V3.2S, V25.2S, V6.2S
    UZP1  V29.4H, V3.4H, V27.4H
    TRN2  V3.8H, V29.8H, V0.8H
    ZIP1  V30.8H, V4.8H, V15.8H
    EXT  V26.16B, V15.16B, V3.16B, #0x7
    TRN1  V14.16B, V30.16B, V19.16B
    TRN2  V5.4S, V7.4S, V11.4S
    SUBS  X27, X27, #0x1
    B.NE  TaishanSimdCryptoP01_label_571
    MOVZ  X12, #0x0, LSL #0
    SUB  X8, X12, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X3
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X8, X2, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X14, X25, X6
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X7
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X3, X23, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X10
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X11, X2, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X7, X4, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X14
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X9, X27, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X27, X23, X18
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X5, X17, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X24
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X5, X19, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X17, X12, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X17, X7, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X17, X25, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D2
    MOVZ  X18, #0x0, LSL #0
    SUB  X4, X18, X11
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D3
    MOVZ  X22, #0x0, LSL #0
    SUB  X29, X22, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D4
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X18, X4, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D6
    MOVZ  X17, #0x0, LSL #0
    SUB  X12, X17, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D8
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X12
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D10
    MOVZ  X7, #0x0, LSL #0
    SUB  X19, X7, X29
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D11
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D13
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D14
    MOVZ  X12, #0x0, LSL #0
    SUB  X18, X12, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D16
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X3
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D17
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D18
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D22
    MOVZ  X29, #0x0, LSL #0
    SUB  X3, X29, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D23
    MOVZ  X13, #0x0, LSL #0
    SUB  X21, X13, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
TaishanSimdCryptoP01_label_324:
    FMOV  X26, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X26
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D25
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X16
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X10, X13, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X2
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D28
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D29
    MOVZ  X25, #0x0, LSL #0
    SUB  X20, X25, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
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
TaishanSimdCryptoP01_label_99:
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
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X10
    FMOV  D2, X23
    FMOV  V2.D[1], X19
    FMOV  D3, X5
    FMOV  V3.D[1], X10
    FMOV  D4, X17
    FMOV  V4.D[1], X8
    FMOV  D5, X18
    FMOV  V5.D[1], X27
    FMOV  D6, X14
    FMOV  V6.D[1], X17
    FMOV  D7, X22
    FMOV  V7.D[1], X22
    FMOV  D8, X16
    FMOV  V8.D[1], X23
    FMOV  D9, X11
    FMOV  V9.D[1], X27
    FMOV  D10, X5
    FMOV  V10.D[1], X22
    FMOV  D11, X7
    FMOV  V11.D[1], X20
    FMOV  D12, X26
    FMOV  V12.D[1], X11
    FMOV  D13, X27
    FMOV  V13.D[1], X19
    FMOV  D14, X5
    FMOV  V14.D[1], X6
    FMOV  D15, X22
    FMOV  V15.D[1], X4
    FMOV  D16, X13
    FMOV  V16.D[1], X28
    FMOV  D17, X9
    FMOV  V17.D[1], X3
    FMOV  D18, X20
    FMOV  V18.D[1], X12
    FMOV  D19, X12
    FMOV  V19.D[1], X10
    FMOV  D20, X28
    FMOV  V20.D[1], X2
    FMOV  D21, X6
    FMOV  V21.D[1], X25
    FMOV  D22, X6
    FMOV  V22.D[1], X14
    FMOV  D23, X8
    FMOV  V23.D[1], X26
    FMOV  D24, X28
    FMOV  V24.D[1], X5
    FMOV  D25, X27
    FMOV  V25.D[1], X25
    FMOV  D26, X20
    FMOV  V26.D[1], X29
    FMOV  D27, X21
    FMOV  V27.D[1], X11
    FMOV  D28, X17
    FMOV  V28.D[1], X28
    FMOV  D29, X27
    FMOV  V29.D[1], X20
    FMOV  D30, X2
    FMOV  V30.D[1], X20
    FMOV  D31, X21
    FMOV  V31.D[1], X6
    MOVZ  X5, #0xf, LSL #0
TaishanSimdCryptoP01_label_651:
    ZIP2  V25.8B, V24.8B, V5.8B
    EXT  V18.8B, V16.8B, V10.8B, #0x0
    ZIP1  V29.8B, V5.8B, V18.8B
    UZP1  V15.8B, V12.8B, V11.8B
    EXT  V6.8B, V26.8B, V31.8B, #0x1
    TRN1  V31.4H, V3.4H, V27.4H
    EXT  V0.8B, V21.8B, V23.8B, #0x6
    TRN2  V15.16B, V8.16B, V21.16B
    EXT  V1.16B, V14.16B, V0.16B, #0x2
    EXT  V25.8B, V22.8B, V8.8B, #0x6
    ZIP1  V30.2D, V30.2D, V7.2D
    TRN2  V14.4H, V31.4H, V6.4H
    TRN2  V14.4S, V29.4S, V10.4S
    EXT  V7.16B, V22.16B, V2.16B, #0xf
    UZP2  V21.2S, V8.2S, V4.2S
    UZP2  V4.2D, V30.2D, V25.2D
    UZP1  V11.4H, V3.4H, V20.4H
    UZP1  V2.8B, V28.8B, V5.8B
    ZIP2  V15.16B, V22.16B, V5.16B
    TRN2  V20.4S, V15.4S, V13.4S
    TRN2  V12.2D, V4.2D, V4.2D
    EXT  V24.16B, V17.16B, V14.16B, #0xe
    TRN2  V30.8H, V2.8H, V24.8H
    UZP1  V28.4S, V20.4S, V11.4S
    UZP2  V27.8B, V7.8B, V25.8B
    TRN2  V6.2S, V17.2S, V8.2S
    TRN1  V29.16B, V1.16B, V24.16B
    UZP2  V8.8B, V22.8B, V19.8B
    ZIP2  V7.4S, V14.4S, V1.4S
    UZP2  V17.8B, V8.8B, V13.8B
    UZP1  V28.2D, V5.2D, V15.2D
    TRN2  V5.2D, V6.2D, V12.2D
    TRN1  V7.8B, V26.8B, V3.8B
    TRN2  V4.2D, V3.2D, V0.2D
    EXT  V23.16B, V19.16B, V31.16B, #0x0
    UZP1  V19.2S, V8.2S, V11.2S
    ZIP2  V27.4S, V29.4S, V0.4S
    EXT  V26.16B, V30.16B, V9.16B, #0xb
    UZP2  V23.4S, V9.4S, V8.4S
    UZP1  V14.4S, V13.4S, V17.4S
    TRN1  V4.16B, V30.16B, V13.16B
    UZP1  V31.4H, V1.4H, V17.4H
    ZIP2  V25.2S, V26.2S, V10.2S
    ZIP2  V0.8H, V1.8H, V24.8H
    UZP1  V0.8H, V14.8H, V7.8H
    EXT  V28.16B, V19.16B, V1.16B, #0xd
    UZP1  V10.8H, V15.8H, V16.8H
    UZP1  V24.8B, V17.8B, V2.8B
    TRN1  V31.4S, V11.4S, V5.4S
    TRN1  V15.8B, V16.8B, V4.8B
    UZP2  V0.8B, V24.8B, V26.8B
    TRN1  V2.8B, V13.8B, V20.8B
    UZP1  V14.2D, V30.2D, V31.2D
    EXT  V22.16B, V19.16B, V7.16B, #0x9
    TRN1  V24.16B, V14.16B, V10.16B
    ZIP2  V17.4H, V1.4H, V26.4H
    UZP1  V29.4H, V8.4H, V0.4H
    UZP2  V19.2D, V22.2D, V11.2D
    ZIP1  V2.2D, V14.2D, V8.2D
    TRN1  V17.2D, V12.2D, V15.2D
    UZP2  V15.2S, V4.2S, V10.2S
    UZP1  V15.8H, V7.8H, V25.8H
    UZP1  V15.2D, V12.2D, V24.2D
    TRN2  V4.8H, V0.8H, V1.8H
    TRN1  V11.2D, V28.2D, V17.2D
    UZP2  V11.8H, V28.8H, V11.8H
    EXT  V15.8B, V30.8B, V27.8B, #0x3
    UZP1  V4.8H, V13.8H, V18.8H
    EXT  V17.8B, V1.8B, V15.8B, #0x3
    ZIP1  V17.16B, V13.16B, V11.16B
    TRN2  V0.8H, V30.8H, V29.8H
    UZP1  V0.8B, V31.8B, V27.8B
    TRN2  V15.8B, V13.8B, V20.8B
    TRN1  V29.8B, V17.8B, V19.8B
    ZIP1  V23.16B, V17.16B, V29.16B
    UZP1  V14.8B, V23.8B, V11.8B
    TRN2  V4.4S, V4.4S, V15.4S
    ZIP1  V10.2S, V11.2S, V27.2S
    ZIP2  V6.2S, V19.2S, V30.2S
    UZP1  V13.2S, V25.2S, V17.2S
    TRN1  V24.8B, V1.8B, V16.8B
    EXT  V26.16B, V10.16B, V20.16B, #0xf
    EXT  V12.8B, V7.8B, V12.8B, #0x6
    ZIP1  V22.4S, V13.4S, V23.4S
    UZP2  V29.2S, V7.2S, V28.2S
    ZIP2  V13.4H, V16.4H, V12.4H
    TRN1  V26.8B, V8.8B, V28.8B
    TRN2  V8.2S, V20.2S, V1.2S
    TRN2  V10.4S, V18.4S, V16.4S
    ZIP2  V0.8H, V10.8H, V27.8H
    ZIP2  V9.2S, V24.2S, V27.2S
    EXT  V26.16B, V10.16B, V28.16B, #0x0
    UZP2  V23.4S, V8.4S, V3.4S
    TRN2  V16.4S, V24.4S, V24.4S
    EXT  V9.16B, V15.16B, V10.16B, #0x5
    ZIP2  V18.16B, V6.16B, V22.16B
    ZIP1  V13.8B, V25.8B, V23.8B
    TRN1  V0.4H, V5.4H, V4.4H
    ZIP1  V29.2S, V25.2S, V11.2S
    EXT  V30.16B, V21.16B, V1.16B, #0x7
    TRN2  V14.2S, V28.2S, V30.2S
    TRN1  V15.2D, V29.2D, V14.2D
    ZIP2  V3.2D, V8.2D, V10.2D
    TRN1  V16.2S, V3.2S, V6.2S
    UZP2  V30.2S, V19.2S, V17.2S
    EXT  V19.8B, V0.8B, V4.8B, #0x0
    ZIP1  V5.2D, V29.2D, V7.2D
    TRN2  V7.8B, V18.8B, V31.8B
    EXT  V28.8B, V17.8B, V25.8B, #0x0
    TRN2  V0.2D, V4.2D, V11.2D
    UZP1  V7.4S, V27.4S, V2.4S
    UZP1  V19.4H, V9.4H, V18.4H
    TRN1  V11.16B, V3.16B, V5.16B
    ZIP1  V13.4S, V29.4S, V6.4S
    ZIP2  V28.8H, V6.8H, V1.8H
    ZIP2  V12.8B, V13.8B, V1.8B
    UZP1  V12.4S, V11.4S, V30.4S
    ZIP1  V16.2S, V5.2S, V11.2S
    ZIP2  V7.8H, V1.8H, V30.8H
    EXT  V26.16B, V0.16B, V31.16B, #0x2
    ZIP2  V24.4S, V21.4S, V5.4S
    UZP1  V21.2D, V3.2D, V30.2D
    UZP1  V19.8B, V14.8B, V13.8B
    UZP1  V31.4S, V21.4S, V11.4S
    TRN1  V4.8H, V25.8H, V21.8H
    TRN1  V11.8H, V5.8H, V29.8H
    TRN1  V2.16B, V22.16B, V3.16B
    ZIP1  V0.4H, V18.4H, V25.4H
    TRN1  V25.4S, V1.4S, V19.4S
    UZP2  V15.2D, V3.2D, V24.2D
    TRN2  V13.2D, V26.2D, V14.2D
    UZP1  V8.4H, V23.4H, V16.4H
    UZP2  V0.4H, V30.4H, V31.4H
    EXT  V13.8B, V0.8B, V21.8B, #0x1
    ZIP1  V22.2S, V16.2S, V25.2S
    EXT  V2.8B, V13.8B, V5.8B, #0x3
    ZIP2  V15.4H, V4.4H, V4.4H
    TRN2  V8.2S, V4.2S, V7.2S
    EXT  V3.8B, V13.8B, V12.8B, #0x1
    TRN2  V13.2S, V29.2S, V9.2S
    EXT  V31.16B, V6.16B, V13.16B, #0x4
    UZP1  V2.16B, V11.16B, V24.16B
    TRN1  V26.4H, V2.4H, V5.4H
    ZIP2  V2.8B, V16.8B, V14.8B
    ZIP1  V0.2S, V24.2S, V12.2S
    UZP2  V19.4S, V15.4S, V12.4S
    EXT  V12.8B, V18.8B, V18.8B, #0x1
    TRN2  V5.8B, V30.8B, V5.8B
    TRN2  V27.4H, V19.4H, V19.4H
    EXT  V0.8B, V31.8B, V4.8B, #0x4
    UZP1  V3.4H, V22.4H, V10.4H
    ZIP2  V26.16B, V17.16B, V7.16B
    TRN1  V7.2D, V19.2D, V28.2D
    UZP1  V20.16B, V12.16B, V9.16B
    EXT  V18.8B, V12.8B, V19.8B, #0x5
    ZIP2  V25.8B, V27.8B, V18.8B
    EXT  V16.16B, V1.16B, V11.16B, #0x9
    UZP1  V5.8H, V1.8H, V17.8H
    TRN1  V0.4H, V31.4H, V29.4H
    UZP2  V20.2S, V18.2S, V24.2S
    EXT  V16.16B, V31.16B, V31.16B, #0xe
    EXT  V19.16B, V29.16B, V3.16B, #0x4
    TRN1  V21.16B, V24.16B, V20.16B
    TRN2  V28.16B, V3.16B, V8.16B
    ZIP2  V15.16B, V6.16B, V25.16B
    TRN1  V27.2D, V5.2D, V23.2D
    TRN1  V3.8B, V25.8B, V1.8B
    EXT  V27.8B, V12.8B, V22.8B, #0x4
    TRN1  V8.4H, V16.4H, V17.4H
    ZIP2  V17.4S, V6.4S, V6.4S
    UZP1  V10.2D, V30.2D, V26.2D
    ZIP2  V4.4S, V30.4S, V24.4S
    UZP1  V24.4H, V17.4H, V7.4H
    UZP2  V2.16B, V15.16B, V24.16B
    ZIP2  V31.2D, V13.2D, V20.2D
    TRN1  V3.2D, V26.2D, V25.2D
    EXT  V24.16B, V21.16B, V31.16B, #0xa
    ZIP1  V9.4S, V19.4S, V27.4S
    ZIP2  V20.8B, V2.8B, V25.8B
    EXT  V0.16B, V27.16B, V9.16B, #0xb
    TRN1  V14.4S, V11.4S, V31.4S
    ZIP2  V6.8H, V21.8H, V7.8H
    ZIP2  V31.4H, V0.4H, V8.4H
    UZP1  V1.4S, V10.4S, V2.4S
    EXT  V17.16B, V3.16B, V11.16B, #0x6
    ZIP1  V10.2S, V1.2S, V23.2S
    ZIP1  V10.8H, V28.8H, V18.8H
    UZP2  V9.2S, V19.2S, V20.2S
    EXT  V15.16B, V19.16B, V28.16B, #0x9
    ZIP1  V6.16B, V25.16B, V14.16B
    EXT  V22.8B, V30.8B, V3.8B, #0x0
    EXT  V13.8B, V7.8B, V20.8B, #0x5
    TRN1  V9.4S, V3.4S, V17.4S
    UZP2  V9.4S, V28.4S, V4.4S
    ZIP1  V5.2S, V24.2S, V8.2S
    EXT  V5.16B, V31.16B, V2.16B, #0xd
    UZP2  V29.8B, V6.8B, V9.8B
    TRN2  V5.4H, V10.4H, V31.4H
    EXT  V4.8B, V26.8B, V15.8B, #0x4
    ZIP1  V14.16B, V19.16B, V30.16B
    SUBS  X5, X5, #0x1
    B.NE  TaishanSimdCryptoP01_label_651
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X9, X22, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X3, X27, X3
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X5, X17, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X25, X9, X6
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X25, X26, X8
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X18, X21, X9
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X21, X6, X10
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X16, X10, X11
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X12, X10, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X25, X11, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X25, X27, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X29, X2, X16
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X25, X12, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X8, X5, X19
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X21, X3, X20
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X20, X28, X21
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X14, X24, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X28, X24, X23
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X14, X10, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X6, X26, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X28
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X2, X25, X29
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X20, X12, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X24, X17, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D3
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xff00, LSL #16
    SUB  X24, X17, X16
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D4
    MOVZ  X18, #0x0, LSL #0
    SUB  X28, X18, X3
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V5.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D5
    MOVZ  X21, #0xff00, LSL #0
    SUB  X29, X21, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X13
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D7
    MOVZ  X5, #0x0, LSL #0
    SUB  X11, X5, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D8
    MOVZ  X4, #0xff00, LSL #0
    SUB  X6, X4, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X11
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D10
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xff00, LSL #16
    SUB  X22, X14, X2
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X14, X21, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D11
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xff00, LSL #32
    MOVK  X21, #0xff00, LSL #48
    SUB  X14, X21, X7
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D12
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xff, LSL #48
    SUB  X23, X7, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D13
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xff00, LSL #48
    SUB  X16, X20, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D14
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xff, LSL #16
    MOVK  X20, #0xff, LSL #48
    SUB  X16, X20, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xff00, LSL #48
    SUB  X12, X21, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D16
    MOVZ  X21, #0xff00, LSL #0
    SUB  X12, X21, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xff00, LSL #48
    SUB  X27, X16, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X27, X16, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D18
    MOVZ  X9, #0xff00, LSL #0
    SUB  X10, X9, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xff, LSL #48
    SUB  X25, X11, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D19
    MOVZ  X11, #0xff00, LSL #0
    MOVK  X11, #0xff00, LSL #16
    SUB  X25, X11, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D20
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X27
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D22
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xff00, LSL #48
    SUB  X11, X12, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D23
    MOVZ  X2, #0xff, LSL #0
    SUB  X12, X2, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D24
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X28
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D25
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D26
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xff00, LSL #16
    SUB  X23, X9, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X2, X24, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D27
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xff, LSL #16
    SUB  X2, X24, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X16
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D29
    MOVZ  X19, #0x0, LSL #0
    SUB  X8, X19, X22
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x671b, LSL #0
    MOVK  X2, #0x15a5, LSL #16
    MOVK  X2, #0x443c, LSL #32
    MOVK  X2, #0xb489, LSL #48
    MOVZ  X3, #0x94c7, LSL #0
    MOVK  X3, #0x9f48, LSL #16
    MOVK  X3, #0x9410, LSL #32
    MOVK  X3, #0xadef, LSL #48
    MOVZ  X4, #0x5c9d, LSL #0
    MOVK  X4, #0xe447, LSL #16
    MOVK  X4, #0x4945, LSL #32
    MOVK  X4, #0x7df1, LSL #48
    MOVZ  X5, #0xfa16, LSL #0
    MOVK  X5, #0x7cbd, LSL #16
    MOVK  X5, #0xe94b, LSL #32
    MOVK  X5, #0x96d8, LSL #48
    MOVZ  X6, #0xf7ee, LSL #0
    MOVK  X6, #0x178, LSL #16
    MOVK  X6, #0xfc01, LSL #32
    MOVK  X6, #0x3e7c, LSL #48
    MOVZ  X7, #0xb7d2, LSL #0
    MOVK  X7, #0x464c, LSL #16
    MOVK  X7, #0x6550, LSL #32
    MOVK  X7, #0x4b53, LSL #48
    MOVZ  X8, #0x7fad, LSL #0
    MOVK  X8, #0xfe2a, LSL #16
    MOVK  X8, #0x2b0, LSL #32
    MOVK  X8, #0x807a, LSL #48
    MOVZ  X9, #0xdd0c, LSL #0
    MOVK  X9, #0x5fb2, LSL #16
    MOVK  X9, #0x862b, LSL #32
    MOVK  X9, #0x294c, LSL #48
    MOVZ  X10, #0x221d, LSL #0
    MOVK  X10, #0x4296, LSL #16
    MOVK  X10, #0x25fd, LSL #32
    MOVK  X10, #0x92b5, LSL #48
    MOVZ  X11, #0x8b97, LSL #0
    MOVK  X11, #0xfccf, LSL #16
    MOVK  X11, #0x9c54, LSL #32
    MOVK  X11, #0xdf70, LSL #48
    MOVZ  X12, #0x31bd, LSL #0
    MOVK  X12, #0x2a8c, LSL #16
    MOVK  X12, #0xc04c, LSL #32
    MOVK  X12, #0x3904, LSL #48
    MOVZ  X13, #0x68ee, LSL #0
    MOVK  X13, #0x76e2, LSL #16
    MOVK  X13, #0xb745, LSL #32
    MOVK  X13, #0xc476, LSL #48
    MOVZ  X14, #0x32e0, LSL #0
    MOVK  X14, #0xfeac, LSL #16
    MOVK  X14, #0x1693, LSL #32
    MOVK  X14, #0xf66c, LSL #48
    MOVZ  X16, #0x8782, LSL #0
    MOVK  X16, #0x8842, LSL #16
    MOVK  X16, #0x307, LSL #32
    MOVK  X16, #0xa023, LSL #48
    MOVZ  X17, #0x901d, LSL #0
    MOVK  X17, #0xb189, LSL #16
    MOVK  X17, #0xa24d, LSL #32
    MOVK  X17, #0xa378, LSL #48
    MOVZ  X18, #0x478c, LSL #0
    MOVK  X18, #0xf1fb, LSL #16
    MOVK  X18, #0xef09, LSL #32
    MOVK  X18, #0x32f3, LSL #48
    MOVZ  X19, #0xda65, LSL #0
    MOVK  X19, #0x7010, LSL #16
    MOVK  X19, #0xfd99, LSL #32
    MOVK  X19, #0x3167, LSL #48
    MOVZ  X20, #0xd22b, LSL #0
    MOVK  X20, #0x217c, LSL #16
    MOVK  X20, #0xa6c0, LSL #32
    MOVK  X20, #0x7a6e, LSL #48
    MOVZ  X21, #0x2b3c, LSL #0
    MOVK  X21, #0x2669, LSL #16
    MOVK  X21, #0x7365, LSL #32
    MOVK  X21, #0x26d3, LSL #48
    MOVZ  X22, #0xd69d, LSL #0
    MOVK  X22, #0x86cc, LSL #16
    MOVK  X22, #0xd6f8, LSL #32
    MOVK  X22, #0x5d26, LSL #48
    MOVZ  X23, #0x3ef, LSL #0
    MOVK  X23, #0x446c, LSL #16
    MOVK  X23, #0xbee5, LSL #32
    MOVK  X23, #0xa72b, LSL #48
    MOVZ  X24, #0x4a2c, LSL #0
    MOVK  X24, #0x966b, LSL #16
    MOVK  X24, #0x11fe, LSL #32
    MOVK  X24, #0x12e7, LSL #48
    MOVZ  X25, #0x1a2c, LSL #0
    MOVK  X25, #0x9c0e, LSL #16
    MOVK  X25, #0x10b, LSL #32
    MOVK  X25, #0xdca2, LSL #48
    MOVZ  X26, #0x4b3b, LSL #0
    MOVK  X26, #0x549c, LSL #16
    MOVK  X26, #0xa51d, LSL #32
    MOVK  X26, #0x37a6, LSL #48
    MOVZ  X27, #0x6ce, LSL #0
    MOVK  X27, #0x1794, LSL #16
    MOVK  X27, #0x4a13, LSL #32
    MOVK  X27, #0x28ac, LSL #48
    MOVZ  X28, #0xa7ae, LSL #0
    MOVK  X28, #0x5516, LSL #16
    MOVK  X28, #0x468d, LSL #32
    MOVK  X28, #0xfb4f, LSL #48
    MOVZ  X29, #0x8184, LSL #0
    MOVK  X29, #0x126b, LSL #16
    MOVK  X29, #0x55c7, LSL #32
    MOVK  X29, #0xa813, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X19
    FMOV  D1, X13
    FMOV  V1.D[1], X23
    FMOV  D2, X2
    FMOV  V2.D[1], X4
    FMOV  D3, X21
    FMOV  V3.D[1], X9
    FMOV  D4, X21
    FMOV  V4.D[1], X17
    FMOV  D5, X13
    FMOV  V5.D[1], X2
    FMOV  D6, X10
    FMOV  V6.D[1], X22
    FMOV  D7, X28
    FMOV  V7.D[1], X27
    FMOV  D8, X27
    FMOV  V8.D[1], X17
    FMOV  D9, X29
    FMOV  V9.D[1], X18
    FMOV  D10, X23
    FMOV  V10.D[1], X17
    FMOV  D11, X22
    FMOV  V11.D[1], X14
    FMOV  D12, X5
    FMOV  V12.D[1], X6
    FMOV  D13, X13
    FMOV  V13.D[1], X6
    FMOV  D14, X24
    FMOV  V14.D[1], X29
    FMOV  D15, X22
    FMOV  V15.D[1], X4
    FMOV  D16, X14
    FMOV  V16.D[1], X21
    FMOV  D17, X16
    FMOV  V17.D[1], X6
    FMOV  D18, X7
    FMOV  V18.D[1], X6
    FMOV  D19, X13
    FMOV  V19.D[1], X17
    FMOV  D20, X28
    FMOV  V20.D[1], X13
    FMOV  D21, X13
    FMOV  V21.D[1], X6
    FMOV  D22, X13
    FMOV  V22.D[1], X18
    FMOV  D23, X3
    FMOV  V23.D[1], X13
    FMOV  D24, X8
    FMOV  V24.D[1], X12
    FMOV  D25, X14
    FMOV  V25.D[1], X27
    FMOV  D26, X16
    FMOV  V26.D[1], X17
    FMOV  D27, X7
    FMOV  V27.D[1], X5
    FMOV  D28, X11
    FMOV  V28.D[1], X28
    FMOV  D29, X27
    FMOV  V29.D[1], X10
    FMOV  D30, X13
    FMOV  V30.D[1], X20
    FMOV  D31, X18
    FMOV  V31.D[1], X9
    MOVZ  X26, #0xa, LSL #0
TaishanSimdCryptoP01_label_729:
    UZP1  V13.2D, V17.2D, V10.2D
    EXT  V0.16B, V22.16B, V20.16B, #0x4
    UZP2  V13.8B, V9.8B, V10.8B
    EXT  V1.16B, V17.16B, V27.16B, #0x3
    UZP1  V3.4H, V15.4H, V11.4H
    TRN1  V15.16B, V9.16B, V27.16B
    TRN1  V12.16B, V1.16B, V7.16B
    UZP2  V9.4H, V14.4H, V10.4H
    UZP2  V26.4S, V20.4S, V30.4S
    UZP2  V17.2D, V3.2D, V12.2D
    ZIP1  V19.4S, V15.4S, V26.4S
    ZIP2  V12.8H, V15.8H, V31.8H
    UZP2  V21.4S, V27.4S, V4.4S
    UZP1  V18.8B, V28.8B, V8.8B
    EXT  V7.8B, V31.8B, V5.8B, #0x1
    TRN2  V7.2S, V11.2S, V13.2S
    EXT  V4.16B, V7.16B, V18.16B, #0x1
    TRN2  V4.8H, V28.8H, V4.8H
    TRN1  V2.8H, V21.8H, V24.8H
    TRN2  V12.4S, V20.4S, V20.4S
    UZP2  V8.4S, V30.4S, V10.4S
    TRN1  V9.8H, V24.8H, V3.8H
    ZIP2  V9.16B, V7.16B, V3.16B
    ZIP2  V7.2D, V2.2D, V2.2D
    EXT  V17.8B, V22.8B, V6.8B, #0x0
    UZP2  V29.8B, V4.8B, V26.8B
    TRN1  V22.16B, V15.16B, V0.16B
    EXT  V1.16B, V9.16B, V20.16B, #0xe
    UZP2  V30.2S, V19.2S, V17.2S
    UZP2  V2.16B, V0.16B, V0.16B
    UZP2  V20.4H, V18.4H, V8.4H
    ZIP1  V1.4S, V16.4S, V17.4S
    ZIP1  V26.2S, V31.2S, V16.2S
    ZIP2  V18.2D, V18.2D, V9.2D
    TRN2  V29.2D, V27.2D, V3.2D
    EXT  V23.8B, V9.8B, V10.8B, #0x6
    TRN2  V4.8H, V6.8H, V18.8H
    ZIP2  V13.16B, V19.16B, V8.16B
    UZP1  V8.16B, V2.16B, V20.16B
    ZIP1  V5.4S, V8.4S, V26.4S
    ZIP1  V30.4S, V28.4S, V8.4S
    UZP1  V7.4H, V15.4H, V28.4H
    ZIP1  V24.16B, V12.16B, V16.16B
    TRN1  V1.16B, V18.16B, V19.16B
    TRN2  V30.2D, V10.2D, V27.2D
    EXT  V21.16B, V29.16B, V12.16B, #0xa
    ZIP1  V3.8H, V16.8H, V29.8H
    ZIP2  V17.4H, V13.4H, V24.4H
    TRN1  V11.2D, V19.2D, V9.2D
    EXT  V5.8B, V31.8B, V1.8B, #0x5
    UZP1  V30.8B, V17.8B, V26.8B
    TRN1  V4.4S, V2.4S, V4.4S
    ZIP1  V26.2D, V21.2D, V13.2D
    UZP2  V8.4S, V20.4S, V18.4S
    ZIP1  V26.8B, V28.8B, V3.8B
    UZP2  V7.16B, V10.16B, V23.16B
    TRN2  V9.8H, V25.8H, V19.8H
    ZIP2  V26.4S, V24.4S, V30.4S
    UZP1  V1.16B, V27.16B, V27.16B
    ZIP1  V5.4S, V11.4S, V24.4S
    UZP1  V5.2S, V6.2S, V15.2S
    UZP1  V8.4H, V4.4H, V1.4H
    EXT  V2.16B, V25.16B, V1.16B, #0x0
    UZP2  V17.8H, V15.8H, V28.8H
    UZP2  V14.2D, V8.2D, V30.2D
    EXT  V13.16B, V21.16B, V31.16B, #0x4
    UZP2  V14.2D, V15.2D, V2.2D
    ZIP2  V0.2S, V7.2S, V9.2S
    TRN2  V10.8B, V26.8B, V2.8B
    TRN1  V1.16B, V18.16B, V27.16B
    ZIP1  V13.4H, V14.4H, V1.4H
    TRN1  V6.16B, V4.16B, V13.16B
    UZP1  V17.8H, V8.8H, V6.8H
    EXT  V5.8B, V26.8B, V13.8B, #0x0
    ZIP1  V25.8H, V13.8H, V30.8H
    ZIP1  V26.8H, V23.8H, V20.8H
    UZP2  V21.2D, V0.2D, V25.2D
    TRN2  V24.4S, V2.4S, V24.4S
    ZIP2  V10.4H, V26.4H, V27.4H
    UZP2  V2.8H, V17.8H, V17.8H
    UZP2  V28.4H, V3.4H, V23.4H
    TRN1  V25.4H, V20.4H, V10.4H
    UZP2  V28.4H, V15.4H, V21.4H
    EXT  V2.16B, V11.16B, V22.16B, #0x2
    EXT  V0.8B, V2.8B, V24.8B, #0x4
    UZP1  V10.16B, V14.16B, V27.16B
    ZIP1  V18.2D, V8.2D, V10.2D
    EXT  V20.16B, V20.16B, V15.16B, #0x5
    EXT  V18.8B, V15.8B, V4.8B, #0x7
    ZIP2  V1.16B, V18.16B, V19.16B
    TRN2  V20.16B, V18.16B, V0.16B
    EXT  V2.16B, V17.16B, V21.16B, #0x8
    UZP1  V5.2S, V20.2S, V14.2S
    TRN2  V20.8H, V0.8H, V20.8H
    EXT  V14.16B, V27.16B, V30.16B, #0xf
    TRN2  V7.8B, V23.8B, V27.8B
    EXT  V10.16B, V11.16B, V18.16B, #0xb
    UZP1  V19.8B, V10.8B, V3.8B
    TRN1  V26.4S, V1.4S, V21.4S
    TRN2  V28.8H, V15.8H, V11.8H
    EXT  V8.16B, V5.16B, V16.16B, #0xf
    EXT  V17.16B, V22.16B, V23.16B, #0xf
    TRN2  V10.2S, V7.2S, V8.2S
    TRN2  V21.4S, V1.4S, V17.4S
    UZP2  V21.8H, V20.8H, V26.8H
    UZP1  V18.8B, V31.8B, V3.8B
    UZP2  V13.8B, V21.8B, V8.8B
    ZIP1  V1.4S, V11.4S, V20.4S
    EXT  V27.8B, V23.8B, V21.8B, #0x0
    UZP2  V21.4H, V14.4H, V2.4H
    ZIP1  V11.8B, V12.8B, V14.8B
    TRN1  V5.4S, V7.4S, V31.4S
    TRN1  V3.8H, V19.8H, V2.8H
    TRN2  V3.2D, V5.2D, V10.2D
    TRN1  V31.2S, V26.2S, V8.2S
    TRN2  V20.4S, V21.4S, V0.4S
    UZP2  V13.2S, V27.2S, V15.2S
    UZP1  V17.4S, V13.4S, V14.4S
    EXT  V26.16B, V24.16B, V6.16B, #0xf
    UZP1  V4.2D, V18.2D, V6.2D
    TRN1  V11.4S, V13.4S, V30.4S
    EXT  V27.16B, V8.16B, V21.16B, #0x0
    UZP2  V1.16B, V27.16B, V16.16B
    ZIP2  V1.4S, V11.4S, V31.4S
    UZP1  V27.4H, V7.4H, V24.4H
    EXT  V18.8B, V17.8B, V27.8B, #0x1
    TRN1  V0.2S, V26.2S, V28.2S
    UZP1  V27.8H, V5.8H, V31.8H
    EXT  V25.8B, V6.8B, V8.8B, #0x3
    EXT  V0.8B, V13.8B, V18.8B, #0x0
    TRN2  V20.2S, V29.2S, V11.2S
    EXT  V12.16B, V18.16B, V5.16B, #0x6
    ZIP1  V7.8B, V11.8B, V1.8B
    UZP2  V10.8H, V27.8H, V23.8H
    ZIP1  V0.2D, V7.2D, V25.2D
    EXT  V23.8B, V30.8B, V5.8B, #0x5
    TRN2  V16.16B, V26.16B, V29.16B
    ZIP2  V26.8H, V23.8H, V20.8H
    UZP1  V10.8B, V19.8B, V4.8B
    ZIP2  V21.2S, V12.2S, V3.2S
    UZP2  V23.4H, V13.4H, V12.4H
    EXT  V26.8B, V10.8B, V21.8B, #0x3
    UZP2  V13.4H, V2.4H, V22.4H
    UZP1  V31.8H, V31.8H, V0.8H
    UZP2  V16.8B, V25.8B, V8.8B
    EXT  V16.16B, V16.16B, V26.16B, #0x7
    UZP1  V23.2S, V0.2S, V10.2S
    TRN2  V25.16B, V7.16B, V14.16B
    EXT  V6.16B, V2.16B, V18.16B, #0x5
    UZP1  V18.4H, V9.4H, V5.4H
    UZP1  V16.2D, V11.2D, V17.2D
    EXT  V21.8B, V25.8B, V14.8B, #0x7
    UZP2  V6.2S, V2.2S, V2.2S
    UZP1  V13.4S, V15.4S, V6.4S
    EXT  V13.16B, V24.16B, V31.16B, #0x5
    ZIP2  V28.2S, V16.2S, V21.2S
    ZIP1  V9.16B, V19.16B, V23.16B
    TRN1  V8.8B, V13.8B, V9.8B
    EXT  V30.8B, V23.8B, V5.8B, #0x0
    TRN1  V19.4H, V1.4H, V23.4H
    ZIP2  V27.8B, V4.8B, V14.8B
    ZIP1  V24.4H, V29.4H, V0.4H
    EXT  V11.8B, V16.8B, V19.8B, #0x3
    TRN2  V23.2S, V11.2S, V25.2S
    EXT  V21.16B, V14.16B, V7.16B, #0xb
    EXT  V8.8B, V13.8B, V16.8B, #0x4
    UZP1  V10.8H, V2.8H, V0.8H
    TRN1  V0.2D, V8.2D, V24.2D
    EXT  V29.8B, V13.8B, V22.8B, #0x2
    TRN2  V15.4H, V23.4H, V4.4H
    TRN1  V28.4H, V8.4H, V0.4H
    TRN2  V20.4H, V30.4H, V2.4H
    EXT  V28.8B, V30.8B, V15.8B, #0x2
    TRN1  V7.2S, V0.2S, V11.2S
    TRN1  V12.2S, V13.2S, V29.2S
    EXT  V10.16B, V12.16B, V18.16B, #0x3
    EXT  V25.8B, V9.8B, V18.8B, #0x7
    TRN2  V1.2D, V28.2D, V25.2D
    ZIP2  V7.8H, V21.8H, V19.8H
    UZP1  V10.2S, V6.2S, V11.2S
    ZIP2  V20.4H, V9.4H, V1.4H
    EXT  V18.16B, V27.16B, V29.16B, #0xc
    TRN2  V18.4H, V20.4H, V2.4H
    TRN1  V8.8B, V18.8B, V2.8B
    ZIP1  V10.2S, V26.2S, V21.2S
    UZP2  V12.8B, V28.8B, V12.8B
    UZP1  V2.8H, V4.8H, V1.8H
    ZIP2  V29.16B, V23.16B, V11.16B
    EXT  V20.8B, V23.8B, V22.8B, #0x2
    TRN2  V2.8B, V0.8B, V24.8B
    ZIP1  V22.2D, V7.2D, V23.2D
    UZP1  V13.4H, V25.4H, V7.4H
    ZIP1  V22.8B, V21.8B, V8.8B
    TRN1  V0.8H, V7.8H, V17.8H
    TRN2  V0.2D, V3.2D, V14.2D
    ZIP2  V14.8H, V3.8H, V4.8H
    EXT  V11.8B, V11.8B, V9.8B, #0x4
    ZIP1  V22.16B, V18.16B, V22.16B
    ZIP2  V10.8H, V3.8H, V12.8H
    UZP1  V30.2D, V31.2D, V24.2D
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdCryptoP01_label_729
    MOVZ  X13, #0x671b, LSL #0
    MOVK  X13, #0x15a5, LSL #16
    MOVK  X13, #0x443c, LSL #32
    MOVK  X13, #0xb489, LSL #48
    SUB  X20, X13, X2
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x94c7, LSL #0
    MOVK  X27, #0x9f48, LSL #16
    MOVK  X27, #0x9410, LSL #32
    MOVK  X27, #0xadef, LSL #48
    SUB  X18, X27, X3
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0x5c9d, LSL #0
    MOVK  X8, #0xe447, LSL #16
    MOVK  X8, #0x4945, LSL #32
    MOVK  X8, #0x7df1, LSL #48
    SUB  X21, X8, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0xfa16, LSL #0
    MOVK  X19, #0x7cbd, LSL #16
    MOVK  X19, #0xe94b, LSL #32
    MOVK  X19, #0x96d8, LSL #48
    SUB  X8, X19, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0xf7ee, LSL #0
    MOVK  X22, #0x178, LSL #16
    MOVK  X22, #0xfc01, LSL #32
    MOVK  X22, #0x3e7c, LSL #48
    SUB  X29, X22, X6
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0xb7d2, LSL #0
    MOVK  X18, #0x464c, LSL #16
    MOVK  X18, #0x6550, LSL #32
    MOVK  X18, #0x4b53, LSL #48
    SUB  X10, X18, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X8
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0xdd0c, LSL #0
    MOVK  X22, #0x5fb2, LSL #16
    MOVK  X22, #0x862b, LSL #32
    MOVK  X22, #0x294c, LSL #48
    SUB  X13, X22, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X10
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x8b97, LSL #0
    MOVK  X7, #0xfccf, LSL #16
    MOVK  X7, #0x9c54, LSL #32
    MOVK  X7, #0xdf70, LSL #48
    SUB  X26, X7, X11
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X22, X4, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X13
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x32e0, LSL #0
    MOVK  X20, #0xfeac, LSL #16
    MOVK  X20, #0x1693, LSL #32
    MOVK  X20, #0xf66c, LSL #48
    SUB  X2, X20, X14
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x8782, LSL #0
    MOVK  X13, #0x8842, LSL #16
    MOVK  X13, #0x307, LSL #32
    MOVK  X13, #0xa023, LSL #48
    SUB  X3, X13, X16
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x901d, LSL #0
    MOVK  X6, #0xb189, LSL #16
    MOVK  X6, #0xa24d, LSL #32
    MOVK  X6, #0xa378, LSL #48
    SUB  X9, X6, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0xb7d2, LSL #0
    MOVK  X12, #0x464c, LSL #16
    MOVK  X12, #0x6550, LSL #32
    MOVK  X12, #0x4b53, LSL #48
    SUB  X5, X12, X18
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X12, X10, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x32e0, LSL #0
    MOVK  X28, #0xfeac, LSL #16
    MOVK  X28, #0x1693, LSL #32
    MOVK  X28, #0xf66c, LSL #48
    SUB  X23, X28, X20
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X21
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X20, X3, X22
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X23
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X13, X3, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x1a2c, LSL #0
    MOVK  X17, #0x9c0e, LSL #16
    MOVK  X17, #0x10b, LSL #32
    MOVK  X17, #0xdca2, LSL #48
    SUB  X16, X17, X25
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X13, X19, X28
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X23, X6, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D3
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D5
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D6
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D7
    MOVZ  X4, #0x0, LSL #0
    SUB  X27, X4, X23
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D8
    MOVZ  X17, #0x0, LSL #0
    SUB  X23, X17, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D9
TaishanSimdCryptoP01_label_460:
    MOVZ  X5, #0x0, LSL #0
    SUB  X2, X5, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D10
    MOVZ  X11, #0x0, LSL #0
    SUB  X3, X11, X4
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X23
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X3
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D13
    MOVZ  X4, #0x0, LSL #0
    SUB  X17, X4, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D14
    MOVZ  X2, #0x0, LSL #0
    SUB  X24, X2, X18
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X8, X4, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X6
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X11
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X5
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D22
    MOVZ  X21, #0x0, LSL #0
    SUB  X26, X21, X9
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X27
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X10
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D25
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X5
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X26
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D29
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X17
    FMOV  V0.D[1], X11
    FMOV  D1, X19
    FMOV  V1.D[1], X28
    FMOV  D2, X21
    FMOV  V2.D[1], X27
    FMOV  D3, X22
    FMOV  V3.D[1], X17
    FMOV  D4, X17
    FMOV  V4.D[1], X25
    FMOV  D5, X29
    FMOV  V5.D[1], X26
    FMOV  D6, X16
    FMOV  V6.D[1], X6
    FMOV  D7, X7
    FMOV  V7.D[1], X10
    FMOV  D8, X18
    FMOV  V8.D[1], X26
    FMOV  D9, X29
    FMOV  V9.D[1], X4
    FMOV  D10, X25
    FMOV  V10.D[1], X13
    FMOV  D11, X25
    FMOV  V11.D[1], X16
    FMOV  D12, X26
    FMOV  V12.D[1], X8
    FMOV  D13, X22
    FMOV  V13.D[1], X7
    FMOV  D14, X14
    FMOV  V14.D[1], X23
    FMOV  D15, X13
    FMOV  V15.D[1], X19
    FMOV  D16, X26
    FMOV  V16.D[1], X12
    FMOV  D17, X7
    FMOV  V17.D[1], X29
    FMOV  D18, X6
    FMOV  V18.D[1], X13
    FMOV  D19, X27
    FMOV  V19.D[1], X14
    FMOV  D20, X7
    FMOV  V20.D[1], X19
    FMOV  D21, X24
    FMOV  V21.D[1], X19
    FMOV  D22, X28
    FMOV  V22.D[1], X9
    FMOV  D23, X14
    FMOV  V23.D[1], X13
    FMOV  D24, X23
    FMOV  V24.D[1], X17
    FMOV  D25, X20
    FMOV  V25.D[1], X24
    FMOV  D26, X20
    FMOV  V26.D[1], X29
    FMOV  D27, X26
    FMOV  V27.D[1], X27
    FMOV  D28, X19
    FMOV  V28.D[1], X12
    FMOV  D29, X26
    FMOV  V29.D[1], X18
    FMOV  D30, X18
    FMOV  V30.D[1], X29
    FMOV  D31, X20
    FMOV  V31.D[1], X3
    MOVZ  X19, #0xa, LSL #0
TaishanSimdCryptoP01_label_804:
    UZP2  V4.8H, V1.8H, V15.8H
    UZP1  V24.4S, V12.4S, V0.4S
    TRN2  V30.2D, V28.2D, V20.2D
    TRN1  V13.4H, V21.4H, V19.4H
    UZP1  V5.4H, V21.4H, V14.4H
    ZIP2  V17.8B, V25.8B, V24.8B
    UZP1  V10.2S, V29.2S, V30.2S
    TRN2  V30.4H, V24.4H, V19.4H
    EXT  V21.16B, V5.16B, V11.16B, #0x7
    UZP1  V10.4H, V3.4H, V29.4H
    ZIP1  V2.16B, V27.16B, V4.16B
    UZP2  V5.16B, V2.16B, V18.16B
    TRN2  V15.2D, V3.2D, V17.2D
    UZP2  V20.16B, V5.16B, V19.16B
    UZP2  V20.4H, V8.4H, V12.4H
    TRN2  V13.16B, V1.16B, V1.16B
    TRN1  V9.16B, V18.16B, V30.16B
    ZIP1  V25.4H, V2.4H, V5.4H
    TRN2  V4.2S, V22.2S, V12.2S
    UZP1  V2.8H, V22.8H, V14.8H
    TRN2  V0.16B, V24.16B, V15.16B
    TRN1  V3.16B, V1.16B, V20.16B
    TRN1  V9.16B, V19.16B, V8.16B
    TRN1  V12.4S, V18.4S, V30.4S
    ZIP2  V10.2S, V17.2S, V6.2S
    EXT  V18.16B, V5.16B, V28.16B, #0x1
    EXT  V16.8B, V27.8B, V10.8B, #0x2
    UZP2  V21.8H, V24.8H, V11.8H
    TRN2  V19.4S, V7.4S, V30.4S
    ZIP1  V26.16B, V21.16B, V26.16B
    ZIP1  V26.4H, V26.4H, V27.4H
    UZP1  V27.16B, V22.16B, V3.16B
    ZIP2  V19.2D, V7.2D, V24.2D
    ZIP2  V19.2D, V12.2D, V24.2D
    TRN1  V31.8H, V20.8H, V14.8H
    EXT  V30.8B, V14.8B, V18.8B, #0x4
    ZIP1  V0.4H, V22.4H, V18.4H
    ZIP2  V3.2D, V31.2D, V27.2D
    TRN1  V16.4S, V31.4S, V30.4S
    EXT  V25.16B, V0.16B, V7.16B, #0xe
    TRN1  V30.8H, V24.8H, V30.8H
    UZP1  V16.16B, V14.16B, V22.16B
    EXT  V7.8B, V8.8B, V18.8B, #0x7
    TRN1  V5.4S, V15.4S, V17.4S
    UZP2  V24.4H, V10.4H, V12.4H
    EXT  V23.16B, V3.16B, V22.16B, #0x5
    EXT  V29.8B, V20.8B, V11.8B, #0x1
    TRN2  V27.2D, V27.2D, V28.2D
    ZIP2  V11.4H, V31.4H, V27.4H
    UZP2  V7.2D, V11.2D, V24.2D
    EXT  V22.8B, V14.8B, V19.8B, #0x3
    UZP2  V6.16B, V7.16B, V0.16B
    UZP1  V18.4S, V30.4S, V6.4S
    TRN2  V30.2D, V14.2D, V22.2D
    TRN2  V12.8B, V15.8B, V10.8B
    TRN2  V31.2S, V14.2S, V18.2S
    TRN2  V23.4H, V6.4H, V19.4H
    EXT  V26.8B, V26.8B, V30.8B, #0x7
    ZIP2  V23.8B, V15.8B, V22.8B
    UZP1  V11.16B, V10.16B, V19.16B
    UZP1  V13.8H, V10.8H, V12.8H
    TRN2  V25.4H, V4.4H, V23.4H
    UZP1  V2.2S, V10.2S, V19.2S
    UZP2  V29.16B, V16.16B, V3.16B
    ZIP2  V4.2D, V2.2D, V24.2D
    EXT  V17.16B, V3.16B, V23.16B, #0xd
    ZIP1  V1.2D, V17.2D, V31.2D
    EXT  V15.16B, V18.16B, V23.16B, #0x7
    EXT  V27.8B, V21.8B, V26.8B, #0x5
    EXT  V1.8B, V21.8B, V1.8B, #0x1
    ZIP2  V26.16B, V10.16B, V30.16B
    UZP1  V8.2S, V31.2S, V24.2S
    ZIP1  V11.4H, V20.4H, V18.4H
    ZIP2  V15.4S, V8.4S, V13.4S
    ZIP2  V28.2S, V31.2S, V26.2S
    UZP2  V20.2S, V28.2S, V30.2S
    EXT  V14.8B, V22.8B, V20.8B, #0x1
    TRN2  V18.2S, V23.2S, V3.2S
    UZP1  V6.2S, V9.2S, V1.2S
    UZP1  V17.16B, V9.16B, V16.16B
    ZIP2  V25.8B, V15.8B, V18.8B
    TRN1  V18.4S, V11.4S, V13.4S
    ZIP2  V26.8B, V26.8B, V6.8B
    TRN1  V2.2S, V29.2S, V7.2S
    ZIP2  V4.8H, V29.8H, V11.8H
    UZP2  V25.4S, V0.4S, V26.4S
    ZIP1  V4.4H, V13.4H, V15.4H
    TRN2  V3.2S, V13.2S, V19.2S
    ZIP2  V25.16B, V19.16B, V3.16B
    TRN2  V16.2S, V8.2S, V3.2S
    UZP1  V30.8B, V15.8B, V29.8B
    UZP1  V19.2S, V16.2S, V17.2S
    EXT  V18.8B, V22.8B, V24.8B, #0x6
    TRN1  V23.4H, V13.4H, V16.4H
    TRN2  V5.2S, V8.2S, V8.2S
    UZP1  V11.2S, V15.2S, V26.2S
    TRN2  V12.8B, V13.8B, V5.8B
    UZP1  V20.16B, V25.16B, V27.16B
    EXT  V31.16B, V25.16B, V19.16B, #0x4
    TRN1  V12.16B, V22.16B, V15.16B
    EXT  V8.8B, V13.8B, V8.8B, #0x6
    TRN1  V31.4H, V17.4H, V15.4H
    EXT  V22.8B, V23.8B, V31.8B, #0x0
    UZP2  V13.16B, V6.16B, V23.16B
    EXT  V24.8B, V13.8B, V4.8B, #0x1
    EXT  V14.8B, V26.8B, V30.8B, #0x1
    TRN1  V5.2D, V1.2D, V18.2D
    UZP2  V14.2S, V1.2S, V26.2S
    UZP2  V13.4H, V14.4H, V26.4H
    TRN2  V8.8H, V18.8H, V10.8H
    ZIP1  V6.2D, V30.2D, V17.2D
    TRN1  V20.16B, V16.16B, V8.16B
    TRN2  V22.8B, V19.8B, V11.8B
    TRN2  V3.8H, V19.8H, V5.8H
    UZP2  V17.2D, V22.2D, V27.2D
    EXT  V6.8B, V29.8B, V31.8B, #0x7
    EXT  V8.16B, V0.16B, V25.16B, #0x2
    TRN2  V12.2S, V24.2S, V15.2S
    TRN2  V23.8H, V14.8H, V0.8H
    ZIP1  V12.8H, V23.8H, V13.8H
    TRN1  V3.2D, V14.2D, V13.2D
    UZP2  V21.8B, V2.8B, V28.8B
    EXT  V26.16B, V14.16B, V6.16B, #0x5
    EXT  V28.8B, V11.8B, V20.8B, #0x2
    TRN1  V13.2S, V4.2S, V8.2S
    TRN2  V1.8B, V20.8B, V17.8B
    TRN2  V10.4H, V10.4H, V18.4H
    ZIP2  V14.16B, V21.16B, V12.16B
    EXT  V25.8B, V3.8B, V7.8B, #0x4
    EXT  V23.8B, V15.8B, V24.8B, #0x6
    UZP2  V26.2S, V6.2S, V6.2S
    ZIP2  V26.4S, V28.4S, V4.4S
    ZIP1  V7.16B, V11.16B, V30.16B
    TRN2  V2.2D, V29.2D, V0.2D
    ZIP2  V1.4S, V15.4S, V0.4S
    UZP1  V16.4S, V5.4S, V2.4S
    ZIP1  V17.2D, V27.2D, V3.2D
    UZP1  V18.16B, V23.16B, V4.16B
    TRN1  V7.8B, V28.8B, V31.8B
    ZIP2  V8.4H, V7.4H, V6.4H
    EXT  V0.8B, V27.8B, V25.8B, #0x0
    ZIP2  V20.8H, V26.8H, V28.8H
    EXT  V23.16B, V19.16B, V28.16B, #0x2
    ZIP2  V15.8B, V24.8B, V13.8B
    ZIP2  V29.8B, V20.8B, V4.8B
    ZIP2  V8.8H, V11.8H, V30.8H
    UZP2  V28.16B, V28.16B, V31.16B
    EXT  V16.16B, V13.16B, V31.16B, #0x3
    EXT  V28.8B, V6.8B, V11.8B, #0x3
    UZP1  V30.2S, V20.2S, V16.2S
    UZP1  V17.16B, V17.16B, V30.16B
    EXT  V1.16B, V0.16B, V23.16B, #0x0
    EXT  V1.8B, V13.8B, V4.8B, #0x3
    UZP1  V2.2S, V3.2S, V28.2S
    EXT  V25.8B, V21.8B, V31.8B, #0x4
    EXT  V18.8B, V25.8B, V26.8B, #0x5
    TRN2  V24.2D, V18.2D, V1.2D
    TRN1  V7.8H, V15.8H, V0.8H
    ZIP2  V26.4S, V11.4S, V12.4S
    TRN2  V10.4S, V23.4S, V29.4S
    ZIP1  V31.16B, V6.16B, V2.16B
    EXT  V24.8B, V15.8B, V11.8B, #0x0
    UZP2  V0.16B, V31.16B, V12.16B
    ZIP2  V7.2D, V16.2D, V7.2D
    UZP2  V28.2S, V25.2S, V26.2S
    TRN2  V1.2S, V13.2S, V5.2S
    TRN1  V19.4S, V10.4S, V8.4S
    TRN1  V19.8B, V27.8B, V27.8B
    EXT  V1.16B, V21.16B, V28.16B, #0x3
    TRN1  V24.2D, V12.2D, V23.2D
    ZIP2  V9.2S, V29.2S, V7.2S
    TRN1  V28.8H, V5.8H, V13.8H
    UZP1  V27.2S, V12.2S, V16.2S
    UZP2  V1.2D, V0.2D, V26.2D
    ZIP1  V17.2S, V9.2S, V12.2S
    UZP2  V30.4H, V31.4H, V12.4H
    EXT  V30.16B, V6.16B, V5.16B, #0x5
    UZP1  V5.2D, V24.2D, V5.2D
    UZP1  V30.2S, V31.2S, V0.2S
    EXT  V6.16B, V29.16B, V11.16B, #0xc
    EXT  V28.16B, V10.16B, V31.16B, #0x9
    ZIP1  V26.4S, V12.4S, V21.4S
    ZIP1  V16.16B, V20.16B, V12.16B
    EXT  V26.16B, V16.16B, V24.16B, #0x0
    EXT  V8.16B, V20.16B, V3.16B, #0xe
    EXT  V0.8B, V11.8B, V28.8B, #0x3
    UZP2  V13.4S, V28.4S, V10.4S
    ZIP1  V19.4H, V7.4H, V9.4H
    TRN1  V20.8H, V13.8H, V6.8H
    TRN1  V8.4H, V8.4H, V12.4H
    TRN2  V28.16B, V8.16B, V17.16B
    ZIP2  V19.4H, V11.4H, V5.4H
    TRN1  V20.8B, V23.8B, V31.8B
    ZIP1  V25.2S, V26.2S, V20.2S
    UZP1  V23.4S, V21.4S, V0.4S
    UZP1  V31.16B, V7.16B, V29.16B
    ZIP1  V23.4H, V16.4H, V30.4H
    TRN2  V13.2D, V24.2D, V11.2D
    EXT  V12.8B, V18.8B, V21.8B, #0x1
    TRN1  V9.16B, V18.16B, V30.16B
    SUBS  X19, X19, #0x1
    B.NE  TaishanSimdCryptoP01_label_804
    MOVZ  X16, #0x0, LSL #0
    SUB  X11, X16, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X25, X7, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X4
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X5, X21, X5
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X8, X28, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X26, X19, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X10, X22, X11
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X11, X6, X12
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X25, X10, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X14
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X16
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X10, X9, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X22, X27, X19
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X20
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X21
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X6, X19, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X24
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X20, X13, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X25, X21, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X3, X14, X29
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D2
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X4
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D3
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D4
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X27
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D5
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X17, X23, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D7
    MOVZ  X27, #0x0, LSL #0
    SUB  X26, X27, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X3, X6, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X8
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X14, X2, X9
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X25
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D12
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D13
    MOVZ  X8, #0x0, LSL #0
    SUB  X24, X8, X19
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D14
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X28
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D16
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X20
TaishanSimdCryptoP01_label_823:
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D17
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D18
    MOVZ  X3, #0x0, LSL #0
    SUB  X11, X3, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D19
    MOVZ  X9, #0x0, LSL #0
    SUB  X16, X9, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D20
    MOVZ  X14, #0x0, LSL #0
    SUB  X4, X14, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D21
    MOVZ  X9, #0x0, LSL #0
    SUB  X26, X9, X4
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X10, X23, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X13, X10, X20
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D24
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X2
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D25
    MOVZ  X5, #0x0, LSL #0
    SUB  X9, X5, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D26
    MOVZ  X5, #0x0, LSL #0
    SUB  X27, X5, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D27
    MOVZ  X14, #0x0, LSL #0
    SUB  X8, X14, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D28
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D29
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X16
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X9
    FMOV  V0.D[1], X26
    FMOV  D1, X6
    FMOV  V1.D[1], X7
    FMOV  D2, X18
    FMOV  V2.D[1], X9
    FMOV  D3, X28
    FMOV  V3.D[1], X12
    FMOV  D4, X26
    FMOV  V4.D[1], X29
    FMOV  D5, X13
    FMOV  V5.D[1], X16
    FMOV  D6, X28
    FMOV  V6.D[1], X7
    FMOV  D7, X28
    FMOV  V7.D[1], X8
    FMOV  D8, X19
    FMOV  V8.D[1], X4
    FMOV  D9, X18
    FMOV  V9.D[1], X5
    FMOV  D10, X26
    FMOV  V10.D[1], X28
    FMOV  D11, X23
    FMOV  V11.D[1], X20
    FMOV  D12, X23
    FMOV  V12.D[1], X16
    FMOV  D13, X22
    FMOV  V13.D[1], X8
    FMOV  D14, X7
    FMOV  V14.D[1], X26
    FMOV  D15, X4
    FMOV  V15.D[1], X27
    FMOV  D16, X17
    FMOV  V16.D[1], X8
    FMOV  D17, X19
    FMOV  V17.D[1], X29
    FMOV  D18, X10
    FMOV  V18.D[1], X8
    FMOV  D19, X9
    FMOV  V19.D[1], X24
    FMOV  D20, X29
    FMOV  V20.D[1], X3
    FMOV  D21, X28
    FMOV  V21.D[1], X29
    FMOV  D22, X16
    FMOV  V22.D[1], X4
    FMOV  D23, X22
    FMOV  V23.D[1], X4
    FMOV  D24, X16
    FMOV  V24.D[1], X8
    FMOV  D25, X19
    FMOV  V25.D[1], X24
    FMOV  D26, X3
    FMOV  V26.D[1], X4
    FMOV  D27, X28
    FMOV  V27.D[1], X13
    FMOV  D28, X12
    FMOV  V28.D[1], X19
    FMOV  D29, X24
    FMOV  V29.D[1], X13
    FMOV  D30, X10
    FMOV  V30.D[1], X8
    FMOV  D31, X13
    FMOV  V31.D[1], X7
    MOVZ  X13, #0xf, LSL #0
TaishanSimdCryptoP01_label_884:
    EXT  V30.8B, V31.8B, V31.8B, #0x5
    UZP2  V17.16B, V5.16B, V28.16B
    TRN1  V15.4H, V0.4H, V11.4H
    EXT  V20.16B, V10.16B, V31.16B, #0x6
    EXT  V27.8B, V2.8B, V8.8B, #0x4
    TRN2  V13.4S, V14.4S, V9.4S
    TRN2  V25.4S, V17.4S, V28.4S
    ZIP1  V1.8H, V7.8H, V18.8H
    TRN1  V23.4S, V17.4S, V13.4S
    TRN1  V20.2S, V29.2S, V17.2S
    ZIP2  V23.4S, V5.4S, V24.4S
    UZP1  V23.8H, V1.8H, V15.8H
    ZIP2  V29.4S, V0.4S, V0.4S
    EXT  V13.8B, V18.8B, V26.8B, #0x1
    ZIP2  V24.4S, V11.4S, V31.4S
    ZIP2  V28.2S, V6.2S, V3.2S
    ZIP1  V21.16B, V25.16B, V7.16B
    EXT  V4.16B, V28.16B, V3.16B, #0x3
    TRN1  V27.8B, V7.8B, V27.8B
    EXT  V0.16B, V26.16B, V7.16B, #0x1
    TRN2  V19.16B, V30.16B, V25.16B
    TRN1  V10.8H, V4.8H, V5.8H
    ZIP2  V7.8B, V6.8B, V10.8B
    UZP1  V0.2S, V17.2S, V12.2S
    UZP2  V11.4S, V30.4S, V20.4S
    TRN2  V30.4S, V2.4S, V27.4S
    UZP2  V9.8B, V3.8B, V21.8B
    ZIP2  V12.8B, V23.8B, V28.8B
    UZP2  V3.16B, V31.16B, V30.16B
    UZP1  V30.4S, V15.4S, V22.4S
    UZP2  V20.4H, V4.4H, V25.4H
    UZP2  V20.4S, V5.4S, V26.4S
    UZP2  V6.4H, V10.4H, V12.4H
    TRN1  V17.16B, V7.16B, V20.16B
    UZP1  V8.2S, V14.2S, V5.2S
    UZP2  V20.2D, V4.2D, V2.2D
    UZP1  V25.2S, V25.2S, V23.2S
    EXT  V26.8B, V6.8B, V14.8B, #0x3
    UZP1  V27.16B, V9.16B, V30.16B
    ZIP2  V27.16B, V25.16B, V0.16B
    EXT  V26.16B, V2.16B, V1.16B, #0x0
    TRN2  V15.8H, V19.8H, V28.8H
    UZP2  V11.16B, V6.16B, V22.16B
    EXT  V25.8B, V5.8B, V17.8B, #0x5
    ZIP1  V22.8H, V29.8H, V7.8H
    UZP2  V31.2S, V10.2S, V14.2S
    ZIP2  V21.8B, V25.8B, V20.8B
    UZP2  V18.8H, V20.8H, V29.8H
    ZIP1  V30.4H, V4.4H, V19.4H
    TRN1  V29.16B, V12.16B, V25.16B
    TRN2  V18.4S, V10.4S, V21.4S
    EXT  V1.8B, V5.8B, V3.8B, #0x0
    UZP2  V2.8B, V3.8B, V24.8B
    ZIP1  V5.2D, V14.2D, V6.2D
    ZIP2  V20.2D, V23.2D, V20.2D
    TRN1  V14.2S, V23.2S, V18.2S
    TRN1  V16.16B, V18.16B, V21.16B
    EXT  V31.8B, V30.8B, V6.8B, #0x3
    EXT  V22.16B, V27.16B, V5.16B, #0x4
    ZIP2  V16.4H, V9.4H, V0.4H
    TRN2  V7.2D, V29.2D, V4.2D
    TRN2  V31.2S, V16.2S, V16.2S
    ZIP2  V26.2S, V11.2S, V6.2S
    UZP2  V11.8H, V20.8H, V10.8H
    ZIP1  V26.4S, V28.4S, V22.4S
    EXT  V22.16B, V23.16B, V8.16B, #0x0
    TRN2  V4.4S, V8.4S, V23.4S
    EXT  V15.16B, V0.16B, V9.16B, #0xe
    ZIP1  V5.8B, V9.8B, V15.8B
    TRN2  V14.2D, V7.2D, V23.2D
    ZIP1  V27.16B, V27.16B, V6.16B
    TRN1  V30.4H, V10.4H, V29.4H
    EXT  V19.16B, V9.16B, V18.16B, #0x8
    UZP1  V12.4H, V3.4H, V2.4H
    TRN2  V18.4H, V25.4H, V5.4H
    UZP1  V20.4H, V0.4H, V0.4H
    EXT  V21.16B, V20.16B, V8.16B, #0x9
    UZP1  V15.16B, V1.16B, V15.16B
    ZIP2  V15.8B, V28.8B, V20.8B
    TRN1  V29.4S, V23.4S, V13.4S
    UZP1  V6.2S, V10.2S, V29.2S
    UZP1  V25.4H, V12.4H, V17.4H
    TRN2  V2.8B, V9.8B, V4.8B
    UZP2  V6.8B, V22.8B, V25.8B
    ZIP1  V25.2D, V11.2D, V8.2D
    TRN2  V6.2D, V30.2D, V27.2D
    ZIP2  V16.8B, V9.8B, V24.8B
    ZIP2  V1.4H, V7.4H, V19.4H
    ZIP2  V11.2D, V4.2D, V26.2D
    UZP2  V9.2D, V8.2D, V5.2D
    EXT  V23.16B, V14.16B, V10.16B, #0xf
    TRN2  V15.4S, V18.4S, V15.4S
    ZIP2  V4.4H, V14.4H, V9.4H
    TRN1  V11.8H, V16.8H, V15.8H
    ZIP2  V31.8B, V17.8B, V29.8B
    TRN2  V0.16B, V18.16B, V29.16B
    UZP1  V11.4S, V11.4S, V25.4S
    ZIP2  V28.16B, V18.16B, V20.16B
    ZIP2  V6.16B, V3.16B, V28.16B
    TRN1  V3.16B, V30.16B, V28.16B
    UZP1  V16.2S, V29.2S, V13.2S
    EXT  V21.8B, V28.8B, V25.8B, #0x0
    EXT  V9.8B, V20.8B, V26.8B, #0x0
    UZP1  V15.2S, V24.2S, V28.2S
    ZIP2  V27.8H, V10.8H, V10.8H
    TRN1  V7.4H, V4.4H, V20.4H
    TRN2  V4.4H, V30.4H, V24.4H
    EXT  V5.8B, V6.8B, V28.8B, #0x4
    TRN1  V17.8H, V8.8H, V5.8H
    EXT  V5.16B, V11.16B, V9.16B, #0x9
    TRN1  V17.4S, V20.4S, V20.4S
    TRN2  V20.16B, V23.16B, V24.16B
    TRN1  V19.2D, V16.2D, V4.2D
    TRN2  V22.2D, V16.2D, V26.2D
    UZP2  V2.8H, V28.8H, V21.8H
    ZIP1  V17.16B, V6.16B, V24.16B
    UZP2  V20.16B, V13.16B, V8.16B
    UZP2  V22.2D, V17.2D, V18.2D
    EXT  V8.8B, V9.8B, V20.8B, #0x3
    ZIP1  V26.8B, V27.8B, V7.8B
    EXT  V6.8B, V5.8B, V14.8B, #0x0
    TRN1  V8.2S, V4.2S, V0.2S
    ZIP1  V2.4S, V10.4S, V19.4S
    UZP1  V26.16B, V6.16B, V1.16B
    TRN2  V22.2S, V0.2S, V8.2S
    ZIP2  V2.4H, V12.4H, V26.4H
    ZIP1  V25.2D, V7.2D, V25.2D
    UZP2  V17.2D, V25.2D, V25.2D
    UZP2  V26.2D, V17.2D, V22.2D
    EXT  V10.16B, V10.16B, V6.16B, #0x6
    ZIP1  V19.16B, V26.16B, V10.16B
    TRN1  V25.2D, V24.2D, V9.2D
    EXT  V1.16B, V1.16B, V19.16B, #0xf
    UZP2  V28.4H, V0.4H, V25.4H
    TRN2  V30.16B, V24.16B, V26.16B
    TRN1  V5.4H, V25.4H, V30.4H
    TRN2  V12.16B, V18.16B, V28.16B
    TRN2  V21.4H, V30.4H, V11.4H
    ZIP1  V2.4H, V14.4H, V1.4H
    ZIP1  V31.8B, V13.8B, V3.8B
    UZP1  V13.4S, V25.4S, V19.4S
    ZIP2  V29.8H, V23.8H, V2.8H
    UZP1  V26.8H, V13.8H, V12.8H
    TRN2  V7.2D, V21.2D, V20.2D
    TRN1  V26.4H, V6.4H, V24.4H
    ZIP1  V16.16B, V23.16B, V28.16B
    EXT  V23.16B, V21.16B, V17.16B, #0xc
    EXT  V7.16B, V24.16B, V21.16B, #0x8
    ZIP1  V23.8B, V0.8B, V4.8B
    ZIP2  V18.2D, V30.2D, V20.2D
    UZP1  V25.4S, V19.4S, V3.4S
    TRN2  V22.2D, V22.2D, V5.2D
    TRN1  V0.16B, V11.16B, V23.16B
    TRN1  V13.2S, V23.2S, V29.2S
    EXT  V24.16B, V18.16B, V23.16B, #0xa
    EXT  V18.8B, V11.8B, V18.8B, #0x6
    UZP2  V25.2S, V25.2S, V7.2S
    UZP1  V23.16B, V24.16B, V3.16B
    TRN2  V25.2S, V29.2S, V18.2S
    TRN1  V21.8B, V1.8B, V5.8B
    ZIP2  V20.4H, V18.4H, V26.4H
    EXT  V13.8B, V3.8B, V25.8B, #0x5
    EXT  V13.8B, V23.8B, V26.8B, #0x7
    TRN2  V13.2S, V31.2S, V19.2S
    EXT  V29.8B, V11.8B, V4.8B, #0x0
    UZP1  V1.4H, V24.4H, V5.4H
    ZIP2  V14.8H, V1.8H, V24.8H
    ZIP1  V16.4S, V29.4S, V29.4S
    EXT  V22.16B, V7.16B, V9.16B, #0x3
    EXT  V14.16B, V4.16B, V29.16B, #0x4
    UZP1  V16.8H, V19.8H, V21.8H
    TRN1  V26.8B, V27.8B, V8.8B
    EXT  V13.8B, V18.8B, V17.8B, #0x1
    UZP1  V6.4H, V8.4H, V0.4H
    TRN1  V2.8B, V5.8B, V22.8B
    UZP2  V10.4S, V5.4S, V12.4S
    UZP2  V10.16B, V10.16B, V27.16B
    EXT  V20.8B, V31.8B, V13.8B, #0x6
    ZIP2  V21.8H, V15.8H, V3.8H
    TRN1  V5.8H, V12.8H, V15.8H
    ZIP1  V10.8B, V23.8B, V11.8B
    TRN1  V29.8B, V19.8B, V21.8B
    EXT  V5.16B, V22.16B, V18.16B, #0xb
    EXT  V26.16B, V20.16B, V13.16B, #0xa
    ZIP1  V4.16B, V6.16B, V12.16B
    EXT  V11.16B, V14.16B, V5.16B, #0x2
    UZP2  V15.2S, V10.2S, V22.2S
    EXT  V3.8B, V7.8B, V3.8B, #0x5
    TRN2  V19.4S, V15.4S, V23.4S
    ZIP1  V27.2D, V5.2D, V7.2D
    EXT  V25.16B, V22.16B, V26.16B, #0x6
    ZIP2  V15.16B, V11.16B, V13.16B
    UZP2  V2.16B, V26.16B, V22.16B
    EXT  V17.8B, V27.8B, V26.8B, #0x3
    EXT  V8.16B, V17.16B, V29.16B, #0x7
    TRN2  V22.2S, V17.2S, V9.2S
    EXT  V11.16B, V25.16B, V4.16B, #0x7
    ZIP2  V15.4S, V23.4S, V29.4S
    UZP1  V13.2D, V21.2D, V31.2D
    ZIP2  V31.4S, V5.4S, V4.4S
    SUBS  X13, X13, #0x1
    B.NE  TaishanSimdCryptoP01_label_884
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X16, X8, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X20, X6, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X5
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X29, X28, X7
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X7, X28, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X29, X24, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X17, X9, X10
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X28, X21, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X11, X13, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X17, X12, X14
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X19, X10, X16
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X5, X27, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X2, X29, X19
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X19, X9, X20
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X3, X29, X21
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X18, X19, X22
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X10, X23, X23
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X24
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X18, X4, X25
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X18, X2, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X28
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X17, X22, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xff00, LSL #48
    SUB  X13, X18, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D2
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xff00, LSL #16
    MOVK  X18, #0xff, LSL #32
    SUB  X13, X18, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X19, X13, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D3
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xff00, LSL #48
    SUB  X19, X13, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X16, #0xff, LSL #0
    MOVK  X16, #0xff, LSL #16
    SUB  X9, X16, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D4
    MOVZ  X16, #0xff00, LSL #0
    MOVK  X16, #0xff00, LSL #16
    MOVK  X16, #0xff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X9, X16, X28
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X27, #0xff00, LSL #0
    SUB  X11, X27, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D5
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xff00, LSL #16
    MOVK  X27, #0xff, LSL #32
    MOVK  X27, #0xff00, LSL #48
    SUB  X11, X27, X26
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D6
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    SUB  X29, X7, X13
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xff00, LSL #32
    SUB  X20, X22, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D7
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xff00, LSL #16
    SUB  X20, X22, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D8
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X21
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D9
    MOVZ  X13, #0xff00, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xff00, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X6, X13, X25
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X9, X7, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D10
    MOVZ  X7, #0xff00, LSL #0
    MOVK  X7, #0xff, LSL #48
    SUB  X9, X7, X14
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xff00, LSL #48
    SUB  X13, X16, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D11
    MOVZ  X16, #0xff00, LSL #0
    MOVK  X16, #0xff, LSL #16
    SUB  X13, X16, X9
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D12
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xff00, LSL #16
    SUB  X2, X11, X4
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xff, LSL #16
    MOVK  X14, #0xff, LSL #48
    SUB  X19, X14, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D13
    MOVZ  X14, #0x0, LSL #0
    SUB  X19, X14, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xff, LSL #32
    SUB  X26, X21, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D14
    MOVZ  X21, #0xff00, LSL #0
    SUB  X26, X21, X23
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X17, X20, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D16
    MOVZ  X20, #0xff00, LSL #0
    SUB  X17, X20, X26
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D17
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xff, LSL #32
    SUB  X16, X24, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V18.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D18
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0xff, LSL #16
    MOVK  X3, #0xff, LSL #32
    SUB  X17, X3, X19
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X3, X20, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D19
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xff, LSL #32
    MOVK  X20, #0xff, LSL #48
    SUB  X3, X20, X10
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X23, X10, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D20
    MOVZ  X10, #0xff, LSL #0
    MOVK  X10, #0xff00, LSL #16
    MOVK  X10, #0xff00, LSL #32
    SUB  X23, X10, X26
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D21
    MOVZ  X11, #0x0, LSL #0
    SUB  X14, X11, X27
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D22
    MOVZ  X16, #0xff, LSL #0
    MOVK  X16, #0xff00, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X8, X16, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xff, LSL #16
    SUB  X18, X7, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D23
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xff00, LSL #16
    MOVK  X7, #0xff, LSL #32
    MOVK  X7, #0xff, LSL #48
    SUB  X18, X7, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X7, #0xff, LSL #0
    MOVK  X7, #0xff00, LSL #16
    MOVK  X7, #0xff, LSL #32
    SUB  X6, X7, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D24
    MOVZ  X7, #0xff00, LSL #0
    MOVK  X7, #0xff, LSL #48
    SUB  X6, X7, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X27, #0xffff, LSL #0
    SUB  X9, X27, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D25
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xff, LSL #32
    SUB  X9, X27, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X24, #0xff00, LSL #0
    SUB  X14, X24, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D26
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xff00, LSL #48
    SUB  X14, X24, X20
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xff00, LSL #16
    SUB  X9, X6, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D27
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xff00, LSL #16
    MOVK  X6, #0xff, LSL #32
    MOVK  X6, #0xff00, LSL #48
    SUB  X9, X6, X7
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X9, X24, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D28
    MOVZ  X24, #0xff00, LSL #0
    MOVK  X24, #0xff00, LSL #16
    MOVK  X24, #0xff, LSL #32
    SUB  X9, X24, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D29
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X22
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0xb6f8, LSL #0
    MOVK  X2, #0x35a3, LSL #16
    MOVK  X2, #0x68f2, LSL #32
    MOVK  X2, #0x8eb2, LSL #48
    MOVZ  X3, #0x15e4, LSL #0
    MOVK  X3, #0x6832, LSL #16
    MOVK  X3, #0xd91e, LSL #32
    MOVK  X3, #0x73f6, LSL #48
    MOVZ  X4, #0x10f9, LSL #0
    MOVK  X4, #0x3819, LSL #16
    MOVK  X4, #0x8ecb, LSL #32
    MOVK  X4, #0xe854, LSL #48
    MOVZ  X5, #0xb20a, LSL #0
    MOVK  X5, #0xd81d, LSL #16
    MOVK  X5, #0xfe38, LSL #32
    MOVK  X5, #0x91fb, LSL #48
    MOVZ  X6, #0x7533, LSL #0
    MOVK  X6, #0x27ef, LSL #16
    MOVK  X6, #0xdbfa, LSL #32
    MOVK  X6, #0x80e7, LSL #48
    MOVZ  X7, #0xb4a7, LSL #0
    MOVK  X7, #0x8878, LSL #16
    MOVK  X7, #0xde8, LSL #32
    MOVK  X7, #0x12f5, LSL #48
    MOVZ  X8, #0x7cfa, LSL #0
    MOVK  X8, #0x1291, LSL #16
    MOVK  X8, #0x3e3b, LSL #32
    MOVK  X8, #0x7d93, LSL #48
    MOVZ  X9, #0xd179, LSL #0
    MOVK  X9, #0x8362, LSL #16
    MOVK  X9, #0x9abd, LSL #32
    MOVK  X9, #0x4dd5, LSL #48
    MOVZ  X10, #0x29fb, LSL #0
    MOVK  X10, #0xfae0, LSL #16
    MOVK  X10, #0x50e2, LSL #32
    MOVK  X10, #0x215, LSL #48
    MOVZ  X11, #0x6cc, LSL #0
    MOVK  X11, #0x93db, LSL #16
    MOVK  X11, #0xa1b, LSL #32
    MOVK  X11, #0x76c, LSL #48
    MOVZ  X12, #0xb023, LSL #0
    MOVK  X12, #0x2070, LSL #16
    MOVK  X12, #0xf44e, LSL #32
    MOVK  X12, #0x1779, LSL #48
    MOVZ  X13, #0xe6d5, LSL #0
    MOVK  X13, #0xa9b, LSL #16
    MOVK  X13, #0x2dc8, LSL #32
    MOVK  X13, #0x4b50, LSL #48
    MOVZ  X14, #0x7deb, LSL #0
    MOVK  X14, #0x285b, LSL #16
    MOVK  X14, #0x7763, LSL #32
    MOVK  X14, #0xcc00, LSL #48
    MOVZ  X16, #0x7e8f, LSL #0
    MOVK  X16, #0x3ebc, LSL #16
    MOVK  X16, #0x5442, LSL #32
    MOVK  X16, #0x77fb, LSL #48
    MOVZ  X17, #0x83df, LSL #0
    MOVK  X17, #0x177e, LSL #16
    MOVK  X17, #0x5428, LSL #32
    MOVK  X17, #0x28f1, LSL #48
    MOVZ  X18, #0xdec5, LSL #0
    MOVK  X18, #0x95a0, LSL #16
    MOVK  X18, #0x313b, LSL #32
    MOVK  X18, #0x4fae, LSL #48
    MOVZ  X19, #0x5d28, LSL #0
    MOVK  X19, #0xce95, LSL #16
    MOVK  X19, #0xbb79, LSL #32
    MOVK  X19, #0x8776, LSL #48
    MOVZ  X20, #0x6996, LSL #0
    MOVK  X20, #0xf29d, LSL #16
    MOVK  X20, #0x796d, LSL #32
    MOVK  X20, #0x7a66, LSL #48
    MOVZ  X21, #0x1b32, LSL #0
    MOVK  X21, #0xab5e, LSL #16
    MOVK  X21, #0x92fd, LSL #32
    MOVK  X21, #0xf246, LSL #48
    MOVZ  X22, #0x8c68, LSL #0
TaishanSimdCryptoP01_label_687:
    MOVK  X22, #0xf50f, LSL #16
    MOVK  X22, #0x4b69, LSL #32
    MOVK  X22, #0x9c24, LSL #48
    MOVZ  X23, #0x2d41, LSL #0
    MOVK  X23, #0x3628, LSL #16
    MOVK  X23, #0xad7b, LSL #32
    MOVK  X23, #0x70a, LSL #48
    MOVZ  X24, #0xadf9, LSL #0
    MOVK  X24, #0xe8e3, LSL #16
    MOVK  X24, #0xc258, LSL #32
    MOVK  X24, #0xd8b6, LSL #48
    MOVZ  X25, #0xfc2, LSL #0
    MOVK  X25, #0x2c25, LSL #16
    MOVK  X25, #0x506c, LSL #32
    MOVK  X25, #0xd91, LSL #48
    MOVZ  X26, #0x8b7b, LSL #0
    MOVK  X26, #0x6190, LSL #16
    MOVK  X26, #0x6eb7, LSL #32
    MOVK  X26, #0x6ed, LSL #48
    MOVZ  X27, #0xd615, LSL #0
    MOVK  X27, #0x17a3, LSL #16
    MOVK  X27, #0x428f, LSL #32
    MOVK  X27, #0x8501, LSL #48
    MOVZ  X28, #0x77ce, LSL #0
    MOVK  X28, #0x1302, LSL #16
    MOVK  X28, #0xca2f, LSL #32
    MOVK  X28, #0x9b2b, LSL #48
    MOVZ  X29, #0xa023, LSL #0
    MOVK  X29, #0xbef8, LSL #16
    MOVK  X29, #0xa469, LSL #32
    MOVK  X29, #0x7b45, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X2
    FMOV  D1, X17
    FMOV  V1.D[1], X29
    FMOV  D2, X4
    FMOV  V2.D[1], X10
    FMOV  D3, X5
    FMOV  V3.D[1], X22
    FMOV  D4, X27
    FMOV  V4.D[1], X18
    FMOV  D5, X27
    FMOV  V5.D[1], X9
    FMOV  D6, X14
    FMOV  V6.D[1], X3
    FMOV  D7, X17
    FMOV  V7.D[1], X28
    FMOV  D8, X13
    FMOV  V8.D[1], X20
    FMOV  D9, X27
    FMOV  V9.D[1], X2
    FMOV  D10, X7
    FMOV  V10.D[1], X18
    FMOV  D11, X14
    FMOV  V11.D[1], X28
    FMOV  D12, X5
    FMOV  V12.D[1], X19
    FMOV  D13, X29
    FMOV  V13.D[1], X20
    FMOV  D14, X3
    FMOV  V14.D[1], X17
    FMOV  D15, X27
    FMOV  V15.D[1], X24
    FMOV  D16, X22
    FMOV  V16.D[1], X13
    FMOV  D17, X7
    FMOV  V17.D[1], X6
    FMOV  D18, X9
    FMOV  V18.D[1], X10
    FMOV  D19, X10
    FMOV  V19.D[1], X6
    FMOV  D20, X29
    FMOV  V20.D[1], X17
    FMOV  D21, X13
    FMOV  V21.D[1], X26
    FMOV  D22, X16
    FMOV  V22.D[1], X8
    FMOV  D23, X9
    FMOV  V23.D[1], X3
    FMOV  D24, X8
    FMOV  V24.D[1], X24
    FMOV  D25, X3
    FMOV  V25.D[1], X13
    FMOV  D26, X14
    FMOV  V26.D[1], X16
    FMOV  D27, X17
    FMOV  V27.D[1], X16
    FMOV  D28, X25
    FMOV  V28.D[1], X13
    FMOV  D29, X4
    FMOV  V29.D[1], X19
    FMOV  D30, X22
    FMOV  V30.D[1], X19
    FMOV  D31, X8
    FMOV  V31.D[1], X8
    MOVZ  X4, #0xa, LSL #0
TaishanSimdCryptoP01_label_966:
    EXT  V23.16B, V25.16B, V18.16B, #0x9
    ZIP1  V25.2D, V28.2D, V23.2D
    UZP2  V27.4H, V28.4H, V30.4H
    ZIP2  V31.8B, V26.8B, V28.8B
    EXT  V5.8B, V0.8B, V5.8B, #0x5
    EXT  V10.16B, V9.16B, V20.16B, #0x4
    TRN2  V16.2D, V13.2D, V0.2D
    TRN2  V25.8B, V4.8B, V11.8B
    TRN1  V11.2S, V24.2S, V31.2S
    UZP1  V4.8H, V22.8H, V10.8H
    EXT  V27.8B, V27.8B, V0.8B, #0x6
    EXT  V15.16B, V1.16B, V11.16B, #0x1
    UZP2  V5.4H, V24.4H, V13.4H
    UZP1  V29.16B, V26.16B, V5.16B
    UZP1  V16.2S, V15.2S, V17.2S
    TRN2  V8.8H, V8.8H, V25.8H
    EXT  V26.16B, V29.16B, V1.16B, #0xd
    UZP2  V13.2S, V19.2S, V20.2S
    ZIP2  V3.8H, V3.8H, V8.8H
    UZP2  V20.2D, V28.2D, V2.2D
    ZIP1  V26.2D, V16.2D, V22.2D
    EXT  V27.16B, V12.16B, V7.16B, #0xa
    ZIP1  V26.4S, V13.4S, V15.4S
    TRN1  V28.8B, V25.8B, V26.8B
    EXT  V28.8B, V27.8B, V15.8B, #0x2
    EXT  V3.16B, V31.16B, V30.16B, #0x0
    EXT  V30.16B, V27.16B, V8.16B, #0x4
    EXT  V30.8B, V26.8B, V31.8B, #0x4
    EXT  V5.16B, V19.16B, V5.16B, #0xa
    ZIP2  V18.2S, V15.2S, V19.2S
    TRN1  V18.2D, V18.2D, V30.2D
    ZIP1  V20.2S, V5.2S, V13.2S
    ZIP2  V11.2D, V12.2D, V1.2D
    ZIP2  V4.16B, V5.16B, V10.16B
    UZP2  V5.4S, V12.4S, V4.4S
    EXT  V31.8B, V7.8B, V25.8B, #0x2
    EXT  V26.16B, V14.16B, V3.16B, #0xa
    EXT  V13.16B, V26.16B, V14.16B, #0x5
    UZP2  V8.8H, V16.8H, V20.8H
    TRN1  V27.4H, V13.4H, V19.4H
    ZIP1  V14.2D, V12.2D, V18.2D
    ZIP2  V29.2S, V3.2S, V28.2S
    EXT  V27.8B, V16.8B, V0.8B, #0x1
    UZP2  V29.4H, V22.4H, V10.4H
    EXT  V25.16B, V15.16B, V31.16B, #0xa
    UZP1  V27.2S, V30.2S, V16.2S
    EXT  V10.16B, V19.16B, V29.16B, #0x3
    TRN1  V15.8H, V14.8H, V10.8H
    ZIP2  V5.2D, V3.2D, V18.2D
    UZP2  V4.4H, V18.4H, V29.4H
    ZIP1  V15.8H, V23.8H, V10.8H
    EXT  V9.8B, V29.8B, V11.8B, #0x6
    UZP1  V9.4S, V1.4S, V8.4S
    ZIP2  V25.16B, V26.16B, V6.16B
    EXT  V24.16B, V15.16B, V17.16B, #0xf
    EXT  V11.16B, V15.16B, V13.16B, #0x1
    EXT  V9.16B, V2.16B, V13.16B, #0xd
    TRN1  V6.4H, V25.4H, V2.4H
    ZIP2  V31.4S, V10.4S, V1.4S
    EXT  V5.8B, V5.8B, V5.8B, #0x4
    TRN1  V27.2S, V26.2S, V18.2S
    ZIP1  V18.8B, V10.8B, V4.8B
    EXT  V10.8B, V25.8B, V18.8B, #0x1
    EXT  V30.16B, V22.16B, V1.16B, #0x7
    UZP2  V30.4S, V10.4S, V16.4S
    ZIP1  V11.4S, V31.4S, V17.4S
    TRN2  V24.8B, V1.8B, V24.8B
    TRN2  V20.16B, V19.16B, V17.16B
    EXT  V18.16B, V21.16B, V13.16B, #0x8
    TRN2  V31.16B, V27.16B, V12.16B
    TRN2  V27.2D, V16.2D, V22.2D
    UZP1  V25.2D, V5.2D, V8.2D
    UZP2  V9.4S, V14.4S, V18.4S
    ZIP2  V22.4S, V16.4S, V25.4S
    TRN1  V22.2D, V28.2D, V8.2D
    ZIP1  V19.2S, V7.2S, V28.2S
    EXT  V24.8B, V7.8B, V25.8B, #0x7
    ZIP2  V23.4S, V6.4S, V30.4S
    ZIP1  V31.4H, V11.4H, V31.4H
    EXT  V29.16B, V18.16B, V1.16B, #0x9
    UZP1  V12.16B, V23.16B, V20.16B
    EXT  V13.16B, V12.16B, V6.16B, #0xb
    UZP1  V6.4H, V20.4H, V31.4H
    TRN2  V4.4S, V24.4S, V17.4S
    ZIP2  V17.8B, V1.8B, V19.8B
    UZP2  V12.2S, V29.2S, V21.2S
    UZP2  V17.4S, V5.4S, V28.4S
    ZIP2  V0.16B, V16.16B, V13.16B
    UZP1  V31.16B, V28.16B, V30.16B
    ZIP1  V22.2D, V23.2D, V29.2D
    ZIP2  V31.8B, V5.8B, V29.8B
    TRN1  V21.4H, V26.4H, V21.4H
    UZP2  V27.4S, V7.4S, V21.4S
    UZP1  V6.4S, V23.4S, V27.4S
    ZIP1  V14.8H, V25.8H, V10.8H
    TRN2  V14.8H, V14.8H, V31.8H
    UZP1  V11.8H, V8.8H, V2.8H
    EXT  V21.16B, V13.16B, V14.16B, #0xf
    TRN1  V4.4H, V8.4H, V22.4H
    UZP2  V1.4S, V4.4S, V17.4S
    EXT  V21.8B, V29.8B, V19.8B, #0x6
    TRN1  V2.4S, V21.4S, V7.4S
    TRN1  V12.4H, V7.4H, V6.4H
    ZIP2  V27.8H, V20.8H, V26.8H
    UZP1  V4.2D, V23.2D, V28.2D
    UZP1  V16.8B, V21.8B, V7.8B
    UZP1  V4.8H, V2.8H, V13.8H
    TRN1  V8.4S, V28.4S, V19.4S
    EXT  V19.8B, V20.8B, V30.8B, #0x6
    ZIP1  V22.16B, V15.16B, V18.16B
    TRN1  V26.4S, V25.4S, V11.4S
    EXT  V9.16B, V1.16B, V3.16B, #0x9
    TRN1  V10.8B, V24.8B, V17.8B
    EXT  V5.16B, V0.16B, V3.16B, #0x4
    ZIP2  V17.4S, V0.4S, V28.4S
    UZP1  V12.16B, V3.16B, V17.16B
    EXT  V17.16B, V28.16B, V18.16B, #0x9
    EXT  V13.16B, V12.16B, V16.16B, #0x5
    TRN1  V2.4H, V7.4H, V22.4H
    TRN2  V30.8B, V23.8B, V1.8B
    EXT  V24.16B, V28.16B, V7.16B, #0x0
    EXT  V19.8B, V19.8B, V27.8B, #0x4
    TRN1  V6.2S, V9.2S, V28.2S
    ZIP2  V24.2D, V11.2D, V20.2D
    ZIP2  V26.2S, V18.2S, V29.2S
    TRN2  V5.4S, V11.4S, V31.4S
    EXT  V16.16B, V1.16B, V10.16B, #0xf
    ZIP1  V7.4S, V12.4S, V9.4S
    EXT  V16.8B, V26.8B, V25.8B, #0x3
    UZP2  V18.4H, V23.4H, V17.4H
    ZIP2  V1.16B, V4.16B, V26.16B
    UZP2  V10.16B, V10.16B, V2.16B
    ZIP2  V26.8H, V0.8H, V16.8H
    ZIP2  V29.8H, V31.8H, V10.8H
    UZP1  V20.4H, V6.4H, V26.4H
    TRN2  V10.4H, V8.4H, V27.4H
    EXT  V27.8B, V16.8B, V22.8B, #0x1
    ZIP2  V6.4H, V22.4H, V5.4H
    TRN2  V25.8H, V10.8H, V20.8H
    UZP2  V8.4S, V22.4S, V9.4S
    ZIP1  V21.2S, V0.2S, V28.2S
    EXT  V9.16B, V23.16B, V28.16B, #0x4
    UZP2  V12.4S, V1.4S, V6.4S
    ZIP1  V16.4H, V11.4H, V10.4H
    ZIP1  V3.4S, V9.4S, V18.4S
    ZIP2  V21.8B, V29.8B, V27.8B
    TRN2  V9.2D, V21.2D, V19.2D
    TRN2  V8.16B, V19.16B, V8.16B
    TRN1  V9.4S, V8.4S, V20.4S
    EXT  V5.16B, V5.16B, V2.16B, #0xc
    ZIP2  V5.16B, V23.16B, V12.16B
    ZIP2  V11.2S, V7.2S, V22.2S
    UZP2  V28.4S, V16.4S, V1.4S
    UZP2  V8.2S, V0.2S, V31.2S
    UZP1  V20.2D, V14.2D, V31.2D
    ZIP2  V13.16B, V0.16B, V21.16B
    ZIP1  V16.2S, V4.2S, V11.2S
    TRN2  V25.4S, V2.4S, V21.4S
    EXT  V6.16B, V2.16B, V11.16B, #0x6
    EXT  V16.8B, V23.8B, V19.8B, #0x1
    TRN2  V7.2D, V20.2D, V21.2D
    UZP2  V3.2S, V30.2S, V13.2S
    UZP1  V31.4H, V1.4H, V14.4H
    ZIP2  V9.4S, V31.4S, V23.4S
    UZP2  V21.2S, V26.2S, V8.2S
    TRN1  V1.8H, V22.8H, V21.8H
    ZIP1  V28.2D, V16.2D, V20.2D
    EXT  V3.8B, V4.8B, V12.8B, #0x4
    UZP2  V7.8B, V24.8B, V11.8B
    EXT  V10.8B, V10.8B, V17.8B, #0x5
    ZIP2  V11.4H, V25.4H, V8.4H
    TRN1  V5.8B, V8.8B, V4.8B
    ZIP1  V20.2S, V11.2S, V15.2S
    TRN1  V18.8B, V5.8B, V19.8B
    EXT  V6.16B, V10.16B, V16.16B, #0x1
    ZIP1  V28.8H, V11.8H, V21.8H
    TRN1  V8.4S, V28.4S, V3.4S
    TRN2  V3.8H, V9.8H, V21.8H
    TRN2  V22.8B, V10.8B, V16.8B
    EXT  V25.16B, V6.16B, V25.16B, #0x4
    TRN2  V6.8B, V31.8B, V20.8B
    TRN1  V17.2S, V15.2S, V0.2S
    EXT  V13.8B, V31.8B, V18.8B, #0x6
    TRN2  V30.2S, V30.2S, V21.2S
    UZP2  V9.2S, V1.2S, V10.2S
    ZIP1  V6.8B, V19.8B, V3.8B
    ZIP2  V4.4S, V12.4S, V29.4S
    ZIP2  V24.8H, V11.8H, V9.8H
    ZIP2  V22.2D, V1.2D, V13.2D
    UZP1  V28.4S, V26.4S, V7.4S
    EXT  V8.16B, V3.16B, V23.16B, #0xe
    TRN2  V29.16B, V17.16B, V30.16B
    UZP1  V31.4S, V5.4S, V27.4S
    TRN2  V1.8B, V13.8B, V19.8B
    EXT  V4.8B, V21.8B, V5.8B, #0x6
    ZIP2  V0.4S, V16.4S, V6.4S
    ZIP2  V5.4S, V16.4S, V25.4S
    EXT  V25.16B, V8.16B, V16.16B, #0xf
    TRN2  V0.2D, V10.2D, V29.2D
    UZP1  V24.4H, V5.4H, V5.4H
    SUBS  X4, X4, #0x1
    B.NE  TaishanSimdCryptoP01_label_966
    MOVZ  X17, #0xb6f8, LSL #0
    MOVK  X17, #0x35a3, LSL #16
    MOVK  X17, #0x68f2, LSL #32
    MOVK  X17, #0x8eb2, LSL #48
    SUB  X21, X17, X2
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x15e4, LSL #0
    MOVK  X18, #0x6832, LSL #16
    MOVK  X18, #0xd91e, LSL #32
    MOVK  X18, #0x73f6, LSL #48
    SUB  X8, X18, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X23, X2, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0xb20a, LSL #0
    MOVK  X23, #0xd81d, LSL #16
    MOVK  X23, #0xfe38, LSL #32
    MOVK  X23, #0x91fb, LSL #48
    SUB  X6, X23, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X13, X11, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0xb4a7, LSL #0
    MOVK  X16, #0x8878, LSL #16
    MOVK  X16, #0xde8, LSL #32
    MOVK  X16, #0x12f5, LSL #48
    SUB  X6, X16, X7
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X8
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0xd179, LSL #0
    MOVK  X24, #0x8362, LSL #16
    MOVK  X24, #0x9abd, LSL #32
    MOVK  X24, #0x4dd5, LSL #48
    SUB  X11, X24, X9
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x29fb, LSL #0
    MOVK  X6, #0xfae0, LSL #16
    MOVK  X6, #0x50e2, LSL #32
    MOVK  X6, #0x215, LSL #48
    SUB  X25, X6, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X11
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x7deb, LSL #0
    MOVK  X7, #0x285b, LSL #16
    MOVK  X7, #0x7763, LSL #32
    MOVK  X7, #0xcc00, LSL #48
    SUB  X25, X7, X14
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0xb4a7, LSL #0
    MOVK  X20, #0x8878, LSL #16
    MOVK  X20, #0xde8, LSL #32
    MOVK  X20, #0x12f5, LSL #48
    SUB  X26, X20, X16
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0xb6f8, LSL #0
    MOVK  X27, #0x35a3, LSL #16
    MOVK  X27, #0x68f2, LSL #32
    MOVK  X27, #0x8eb2, LSL #48
    SUB  X17, X27, X17
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x15e4, LSL #0
    MOVK  X21, #0x6832, LSL #16
    MOVK  X21, #0xd91e, LSL #32
    MOVK  X21, #0x73f6, LSL #48
    SUB  X9, X21, X18
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X20, X4, X19
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X20
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x15e4, LSL #0
    MOVK  X5, #0x6832, LSL #16
    MOVK  X5, #0xd91e, LSL #32
    MOVK  X5, #0x73f6, LSL #48
    SUB  X26, X5, X21
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x8c68, LSL #0
    MOVK  X4, #0xf50f, LSL #16
    MOVK  X4, #0x4b69, LSL #32
    MOVK  X4, #0x9c24, LSL #48
    SUB  X6, X4, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0xb20a, LSL #0
    MOVK  X24, #0xd81d, LSL #16
    MOVK  X24, #0xfe38, LSL #32
    MOVK  X24, #0x91fb, LSL #48
    SUB  X4, X24, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0xb20a, LSL #0
    MOVK  X17, #0xd81d, LSL #16
    MOVK  X17, #0xfe38, LSL #32
    MOVK  X17, #0x91fb, LSL #48
    SUB  X21, X17, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X9, X2, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X21, X27, X26
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X27
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X28
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D4
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X14
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X10
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D7
    MOVZ  X25, #0x0, LSL #0
    SUB  X24, X25, X28
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D9
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D10
    MOVZ  X18, #0x0, LSL #0
    SUB  X24, X18, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D11
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D12
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D13
    MOVZ  X7, #0x0, LSL #0
    SUB  X10, X7, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D14
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D16
    MOVZ  X4, #0x0, LSL #0
    SUB  X23, X4, X25
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D17
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D18
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D19
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X25
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D20
    MOVZ  X16, #0x0, LSL #0
    SUB  X24, X16, X11
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D21
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D22
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X13
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D23
    MOVZ  X10, #0x0, LSL #0
    SUB  X22, X10, X20
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D24
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X13
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D25
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D26
    MOVZ  X16, #0x0, LSL #0
    SUB  X7, X16, X21
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D27
    MOVZ  X10, #0x0, LSL #0
    SUB  X3, X10, X18
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D28
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D29
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X8
    FMOV  D1, X27
    FMOV  V1.D[1], X20
    FMOV  D2, X20
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X23
    FMOV  D4, X22
    FMOV  V4.D[1], X21
    FMOV  D5, X7
    FMOV  V5.D[1], X12
    FMOV  D6, X22
    FMOV  V6.D[1], X25
    FMOV  D7, X7
    FMOV  V7.D[1], X8
    FMOV  D8, X19
    FMOV  V8.D[1], X25
    FMOV  D9, X12
    FMOV  V9.D[1], X23
    FMOV  D10, X27
    FMOV  V10.D[1], X22
    FMOV  D11, X8
    FMOV  V11.D[1], X22
    FMOV  D12, X29
    FMOV  V12.D[1], X11
    FMOV  D13, X24
    FMOV  V13.D[1], X3
    FMOV  D14, X8
    FMOV  V14.D[1], X7
    FMOV  D15, X5
    FMOV  V15.D[1], X2
    FMOV  D16, X20
    FMOV  V16.D[1], X11
    FMOV  D17, X11
    FMOV  V17.D[1], X24
    FMOV  D18, X22
    FMOV  V18.D[1], X11
    FMOV  D19, X6
    FMOV  V19.D[1], X21
    FMOV  D20, X6
    FMOV  V20.D[1], X7
    FMOV  D21, X14
    FMOV  V21.D[1], X14
    FMOV  D22, X5
    FMOV  V22.D[1], X2
    FMOV  D23, X24
    FMOV  V23.D[1], X21
    FMOV  D24, X25
    FMOV  V24.D[1], X27
    FMOV  D25, X13
    FMOV  V25.D[1], X4
    FMOV  D26, X23
    FMOV  V26.D[1], X25
    FMOV  D27, X23
    FMOV  V27.D[1], X10
    FMOV  D28, X12
    FMOV  V28.D[1], X18
    FMOV  D29, X8
    FMOV  V29.D[1], X5
    FMOV  D30, X5
    FMOV  V30.D[1], X27
    FMOV  D31, X4
    FMOV  V31.D[1], X12
    MOVZ  X25, #0xa, LSL #0
TaishanSimdCryptoP01_label_1043:
    TRN2  V0.2S, V3.2S, V23.2S
    UZP2  V31.8H, V20.8H, V18.8H
    UZP2  V4.4S, V1.4S, V3.4S
    UZP1  V28.2S, V16.2S, V6.2S
    UZP1  V30.8B, V9.8B, V10.8B
    UZP2  V22.4H, V27.4H, V23.4H
    ZIP2  V1.8B, V25.8B, V30.8B
    EXT  V21.16B, V28.16B, V22.16B, #0x3
    ZIP2  V24.4S, V26.4S, V0.4S
    UZP1  V22.4H, V22.4H, V29.4H
    ZIP1  V30.4S, V31.4S, V20.4S
    EXT  V6.16B, V28.16B, V0.16B, #0x8
    UZP1  V16.16B, V21.16B, V16.16B
    UZP1  V4.4H, V30.4H, V31.4H
    UZP2  V18.2S, V8.2S, V29.2S
    EXT  V1.16B, V18.16B, V11.16B, #0x6
    TRN2  V19.2D, V24.2D, V8.2D
    UZP1  V20.2D, V0.2D, V5.2D
    UZP2  V22.4S, V16.4S, V25.4S
    ZIP1  V2.2D, V9.2D, V27.2D
    TRN1  V2.8B, V3.8B, V25.8B
    ZIP2  V12.8H, V16.8H, V21.8H
    TRN1  V26.8B, V18.8B, V6.8B
    ZIP2  V12.2D, V12.2D, V23.2D
    TRN2  V16.16B, V2.16B, V9.16B
    EXT  V25.8B, V4.8B, V3.8B, #0x7
    TRN2  V30.2S, V25.2S, V14.2S
    TRN1  V24.4S, V8.4S, V12.4S
    UZP2  V31.4H, V29.4H, V28.4H
    TRN2  V4.2S, V31.2S, V25.2S
    TRN2  V30.16B, V18.16B, V10.16B
    TRN1  V23.4H, V25.4H, V5.4H
    EXT  V28.16B, V27.16B, V17.16B, #0x7
    EXT  V8.16B, V28.16B, V27.16B, #0xa
    EXT  V10.8B, V17.8B, V22.8B, #0x0
    UZP2  V24.2D, V31.2D, V9.2D
    TRN2  V0.2S, V20.2S, V16.2S
    EXT  V28.16B, V12.16B, V28.16B, #0x0
    EXT  V10.16B, V20.16B, V30.16B, #0x8
    UZP2  V16.4H, V16.4H, V13.4H
    TRN2  V22.4H, V28.4H, V24.4H
    EXT  V31.16B, V16.16B, V6.16B, #0x4
    EXT  V29.8B, V21.8B, V17.8B, #0x1
    ZIP2  V8.8H, V26.8H, V29.8H
    ZIP2  V31.2D, V15.2D, V7.2D
    ZIP1  V28.2D, V10.2D, V17.2D
    TRN2  V23.4S, V29.4S, V23.4S
    ZIP2  V2.8B, V23.8B, V27.8B
    EXT  V3.8B, V13.8B, V27.8B, #0x3
    UZP1  V0.8H, V23.8H, V10.8H
    TRN1  V23.2S, V0.2S, V15.2S
    TRN1  V6.2S, V14.2S, V26.2S
    ZIP1  V31.8B, V14.8B, V3.8B
    ZIP2  V11.2D, V17.2D, V29.2D
    TRN2  V21.8B, V5.8B, V26.8B
    ZIP1  V3.16B, V27.16B, V6.16B
    EXT  V4.16B, V23.16B, V29.16B, #0x7
    EXT  V21.16B, V28.16B, V4.16B, #0xf
    UZP2  V16.2S, V17.2S, V3.2S
    UZP1  V16.2D, V2.2D, V11.2D
    ZIP2  V26.2S, V20.2S, V12.2S
    ZIP2  V23.2D, V16.2D, V7.2D
    ZIP1  V13.8H, V5.8H, V8.8H
    ZIP2  V13.4S, V21.4S, V2.4S
    ZIP1  V19.4S, V22.4S, V22.4S
    ZIP1  V16.16B, V30.16B, V3.16B
    UZP1  V23.4H, V27.4H, V31.4H
    TRN1  V12.2D, V22.2D, V26.2D
    ZIP1  V8.8B, V1.8B, V27.8B
    ZIP2  V16.2S, V4.2S, V26.2S
    EXT  V27.8B, V0.8B, V22.8B, #0x7
    ZIP1  V30.2S, V31.2S, V27.2S
    EXT  V29.8B, V22.8B, V9.8B, #0x4
    EXT  V19.8B, V27.8B, V12.8B, #0x2
    UZP1  V6.4S, V6.4S, V28.4S
    UZP2  V14.8H, V13.8H, V16.8H
    ZIP2  V23.2D, V14.2D, V26.2D
    TRN1  V20.2S, V17.2S, V24.2S
    TRN2  V6.2S, V31.2S, V9.2S
    UZP1  V19.8B, V4.8B, V14.8B
    ZIP1  V16.2D, V31.2D, V18.2D
    ZIP2  V29.16B, V3.16B, V20.16B
    ZIP1  V11.4H, V8.4H, V27.4H
    UZP2  V1.4H, V22.4H, V14.4H
    UZP2  V7.4S, V7.4S, V16.4S
    EXT  V28.16B, V21.16B, V27.16B, #0x4
    EXT  V22.8B, V2.8B, V28.8B, #0x5
    ZIP1  V27.8H, V6.8H, V0.8H
    TRN1  V21.8H, V30.8H, V27.8H
    TRN1  V27.2S, V1.2S, V16.2S
    UZP1  V6.4H, V13.4H, V17.4H
    TRN1  V9.4S, V25.4S, V8.4S
    ZIP2  V26.4S, V14.4S, V30.4S
    EXT  V6.8B, V31.8B, V11.8B, #0x6
    ZIP2  V16.4S, V10.4S, V6.4S
    ZIP2  V16.4S, V12.4S, V2.4S
    EXT  V26.16B, V7.16B, V7.16B, #0xf
    TRN1  V0.8B, V11.8B, V13.8B
    EXT  V8.16B, V1.16B, V26.16B, #0x6
    EXT  V21.16B, V16.16B, V16.16B, #0xc
    ZIP2  V3.4S, V7.4S, V17.4S
    EXT  V12.8B, V7.8B, V27.8B, #0x4
    EXT  V12.8B, V1.8B, V8.8B, #0x4
    TRN1  V22.2D, V17.2D, V31.2D
    UZP1  V14.8B, V4.8B, V26.8B
    EXT  V3.16B, V13.16B, V26.16B, #0x2
    TRN2  V28.4S, V16.4S, V29.4S
    UZP1  V22.2D, V23.2D, V16.2D
    TRN2  V18.8H, V22.8H, V9.8H
    ZIP1  V1.8H, V15.8H, V18.8H
    EXT  V10.16B, V16.16B, V0.16B, #0xa
    ZIP1  V11.8B, V4.8B, V23.8B
    UZP2  V10.2S, V23.2S, V8.2S
    UZP2  V9.16B, V31.16B, V4.16B
    EXT  V14.8B, V2.8B, V18.8B, #0x4
    UZP1  V23.2D, V20.2D, V14.2D
    UZP1  V1.16B, V3.16B, V17.16B
    EXT  V11.8B, V22.8B, V2.8B, #0x2
    EXT  V31.16B, V25.16B, V13.16B, #0xf
    ZIP2  V29.2D, V4.2D, V22.2D
    EXT  V22.8B, V1.8B, V16.8B, #0x0
    TRN2  V30.16B, V28.16B, V31.16B
    UZP1  V22.2S, V4.2S, V25.2S
    UZP2  V23.4S, V21.4S, V17.4S
    TRN1  V0.4H, V27.4H, V7.4H
    TRN2  V16.2D, V16.2D, V3.2D
    TRN2  V30.8B, V10.8B, V18.8B
    UZP2  V9.8H, V13.8H, V6.8H
    UZP1  V26.16B, V28.16B, V9.16B
    UZP2  V18.2D, V20.2D, V15.2D
    EXT  V26.16B, V3.16B, V26.16B, #0x9
    ZIP2  V22.2S, V8.2S, V18.2S
    ZIP2  V20.2D, V13.2D, V2.2D
    ZIP2  V0.2D, V6.2D, V9.2D
    UZP2  V14.8H, V9.8H, V29.8H
    UZP1  V14.2S, V31.2S, V1.2S
    TRN2  V14.16B, V15.16B, V4.16B
    TRN1  V31.2S, V26.2S, V11.2S
    ZIP2  V11.2D, V17.2D, V30.2D
    EXT  V11.8B, V1.8B, V5.8B, #0x6
    UZP1  V10.2S, V1.2S, V2.2S
    ZIP2  V2.16B, V5.16B, V21.16B
    TRN2  V22.4S, V0.4S, V29.4S
    EXT  V13.8B, V0.8B, V28.8B, #0x1
    EXT  V25.16B, V25.16B, V3.16B, #0x8
    TRN1  V8.2D, V30.2D, V27.2D
    UZP2  V17.2D, V17.2D, V1.2D
    ZIP1  V27.8H, V9.8H, V6.8H
    EXT  V5.8B, V3.8B, V0.8B, #0x5
    TRN2  V13.4H, V24.4H, V3.4H
    EXT  V21.16B, V25.16B, V2.16B, #0xd
    ZIP2  V10.2D, V27.2D, V13.2D
    TRN1  V2.8H, V2.8H, V27.8H
    UZP2  V13.4H, V13.4H, V16.4H
    ZIP2  V24.2S, V19.2S, V7.2S
    ZIP1  V17.8H, V25.8H, V10.8H
    ZIP1  V29.4S, V10.4S, V13.4S
    ZIP2  V27.16B, V17.16B, V15.16B
    EXT  V23.8B, V3.8B, V9.8B, #0x5
    TRN1  V25.16B, V7.16B, V10.16B
    UZP2  V18.8B, V24.8B, V7.8B
    TRN2  V22.8H, V23.8H, V27.8H
    ZIP2  V1.8B, V21.8B, V19.8B
    TRN1  V0.4S, V17.4S, V25.4S
    UZP1  V27.8H, V31.8H, V10.8H
    UZP2  V10.8H, V7.8H, V8.8H
    ZIP2  V30.16B, V22.16B, V3.16B
    EXT  V14.8B, V4.8B, V0.8B, #0x4
    TRN2  V4.8H, V27.8H, V12.8H
    EXT  V29.16B, V30.16B, V6.16B, #0x2
    TRN1  V12.4H, V24.4H, V30.4H
    TRN2  V1.2D, V22.2D, V6.2D
    EXT  V10.8B, V24.8B, V17.8B, #0x5
    UZP2  V9.8B, V14.8B, V18.8B
    ZIP1  V13.8H, V9.8H, V8.8H
    UZP2  V6.4H, V27.4H, V7.4H
    EXT  V12.8B, V9.8B, V11.8B, #0x5
    EXT  V21.16B, V1.16B, V19.16B, #0x3
    UZP1  V15.8H, V25.8H, V4.8H
    UZP2  V22.2D, V16.2D, V10.2D
    UZP2  V12.8B, V1.8B, V1.8B
    UZP1  V2.8B, V30.8B, V16.8B
    UZP1  V15.2S, V29.2S, V27.2S
    ZIP1  V22.16B, V16.16B, V23.16B
    EXT  V29.8B, V19.8B, V24.8B, #0x4
    EXT  V29.16B, V15.16B, V1.16B, #0x7
    TRN2  V13.2D, V0.2D, V29.2D
    UZP2  V14.16B, V11.16B, V7.16B
    EXT  V14.16B, V23.16B, V23.16B, #0x0
    TRN1  V4.16B, V31.16B, V31.16B
    EXT  V30.16B, V23.16B, V28.16B, #0x9
    TRN1  V19.2D, V5.2D, V2.2D
    ZIP1  V15.8B, V13.8B, V7.8B
    ZIP1  V16.8B, V31.8B, V11.8B
    EXT  V30.16B, V9.16B, V24.16B, #0xa
    EXT  V7.8B, V0.8B, V17.8B, #0x0
    EXT  V10.16B, V27.16B, V12.16B, #0x3
    ZIP1  V1.8H, V1.8H, V24.8H
    ZIP2  V14.8B, V8.8B, V12.8B
    TRN2  V18.2S, V24.2S, V8.2S
    SUBS  X25, X25, #0x1
    B.NE  TaishanSimdCryptoP01_label_1043
    MOVZ  X8, #0x0, LSL #0
    SUB  X14, X8, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X3
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X29, X4, X4
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X26, X22, X5
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X6
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X8
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X20, X6, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X23, X18, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X11, X7, X13
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X16
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X18
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X19
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X28, X26, X21
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X16, X23, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X18, X19, X24
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X26
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X13, X20, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D2
    MOVZ  X6, #0x0, LSL #0
    SUB  X7, X6, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X21
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D5
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X12
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D6
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X27
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X11, X12, X22
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D8
    MOVZ  X26, #0x0, LSL #0
    SUB  X11, X26, X2
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D9
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X5
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D10
    MOVZ  X9, #0x0, LSL #0
    SUB  X11, X9, X5
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D11
    MOVZ  X26, #0x0, LSL #0
    SUB  X8, X26, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D12
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D13
    MOVZ  X24, #0x0, LSL #0
    SUB  X3, X24, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D16
    MOVZ  X18, #0x0, LSL #0
    SUB  X27, X18, X10
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V17.D[1]
TaishanSimdCryptoP01_label_30:
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D17
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X3
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D18
    MOVZ  X6, #0x0, LSL #0
    SUB  X28, X6, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D19
    MOVZ  X26, #0x0, LSL #0
    SUB  X22, X26, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D20
    MOVZ  X13, #0x0, LSL #0
    SUB  X28, X13, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D21
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D22
    MOVZ  X9, #0x0, LSL #0
    SUB  X5, X9, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D23
    MOVZ  X4, #0x0, LSL #0
    SUB  X28, X4, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D24
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X19
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D26
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X20
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D27
    MOVZ  X26, #0x0, LSL #0
    SUB  X20, X26, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D28
    MOVZ  X4, #0x0, LSL #0
    SUB  X19, X4, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D29
    MOVZ  X7, #0x0, LSL #0
    SUB  X24, X7, X5
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X18
    FMOV  V0.D[1], X29
    FMOV  D1, X13
    FMOV  V1.D[1], X8
    FMOV  D2, X6
    FMOV  V2.D[1], X6
    FMOV  D3, X21
    FMOV  V3.D[1], X26
    FMOV  D4, X4
    FMOV  V4.D[1], X24
    FMOV  D5, X25
    FMOV  V5.D[1], X3
    FMOV  D6, X21
    FMOV  V6.D[1], X11
    FMOV  D7, X25
    FMOV  V7.D[1], X9
    FMOV  D8, X29
    FMOV  V8.D[1], X13
    FMOV  D9, X22
    FMOV  V9.D[1], X7
    FMOV  D10, X8
    FMOV  V10.D[1], X11
    FMOV  D11, X19
    FMOV  V11.D[1], X8
    FMOV  D12, X4
    FMOV  V12.D[1], X5
    FMOV  D13, X28
    FMOV  V13.D[1], X29
    FMOV  D14, X25
    FMOV  V14.D[1], X8
    FMOV  D15, X7
    FMOV  V15.D[1], X3
    FMOV  D16, X4
    FMOV  V16.D[1], X24
    FMOV  D17, X19
    FMOV  V17.D[1], X12
    FMOV  D18, X13
    FMOV  V18.D[1], X8
    FMOV  D19, X9
    FMOV  V19.D[1], X11
    FMOV  D20, X18
    FMOV  V20.D[1], X26
    FMOV  D21, X24
    FMOV  V21.D[1], X24
    FMOV  D22, X2
    FMOV  V22.D[1], X3
    FMOV  D23, X3
    FMOV  V23.D[1], X6
    FMOV  D24, X9
    FMOV  V24.D[1], X16
    FMOV  D25, X4
    FMOV  V25.D[1], X8
    FMOV  D26, X16
    FMOV  V26.D[1], X27
    FMOV  D27, X18
    FMOV  V27.D[1], X9
    FMOV  D28, X21
    FMOV  V28.D[1], X21
    FMOV  D29, X9
    FMOV  V29.D[1], X13
    FMOV  D30, X4
    FMOV  V30.D[1], X16
    FMOV  D31, X21
    FMOV  V31.D[1], X8
    MOVZ  X24, #0xf, LSL #0
TaishanSimdCryptoP01_label_1122:
    EXT  V7.8B, V20.8B, V17.8B, #0x5
    TRN1  V15.2S, V19.2S, V10.2S
    EXT  V18.16B, V2.16B, V9.16B, #0x6
    ZIP1  V18.8H, V11.8H, V30.8H
    ZIP2  V5.8B, V3.8B, V26.8B
    UZP1  V25.16B, V14.16B, V19.16B
    EXT  V2.16B, V16.16B, V15.16B, #0x2
    EXT  V30.8B, V3.8B, V7.8B, #0x3
    TRN1  V27.4S, V26.4S, V12.4S
    ZIP2  V18.4S, V18.4S, V20.4S
    TRN2  V28.8B, V17.8B, V13.8B
    UZP2  V20.8B, V28.8B, V23.8B
    TRN2  V15.8B, V18.8B, V23.8B
    EXT  V2.8B, V18.8B, V7.8B, #0x6
    TRN1  V27.2D, V14.2D, V18.2D
    EXT  V25.16B, V7.16B, V6.16B, #0xa
    ZIP1  V13.2D, V29.2D, V30.2D
    ZIP1  V11.2S, V17.2S, V27.2S
    EXT  V8.16B, V26.16B, V3.16B, #0x3
    ZIP1  V5.4S, V13.4S, V7.4S
    EXT  V29.8B, V7.8B, V3.8B, #0x3
    EXT  V14.16B, V19.16B, V30.16B, #0xb
    TRN2  V23.4S, V15.4S, V0.4S
    ZIP1  V5.16B, V11.16B, V12.16B
    UZP2  V25.8H, V20.8H, V18.8H
    EXT  V2.8B, V2.8B, V5.8B, #0x0
    TRN1  V10.16B, V6.16B, V29.16B
    TRN1  V7.8H, V11.8H, V13.8H
    ZIP1  V10.16B, V19.16B, V26.16B
    TRN2  V17.4S, V2.4S, V6.4S
    TRN1  V29.16B, V17.16B, V29.16B
    UZP1  V30.8B, V26.8B, V8.8B
    ZIP2  V11.2S, V25.2S, V13.2S
    TRN1  V22.4H, V13.4H, V7.4H
    TRN2  V12.2D, V19.2D, V11.2D
    UZP2  V0.8B, V13.8B, V26.8B
    ZIP2  V29.8B, V4.8B, V18.8B
    EXT  V13.16B, V15.16B, V8.16B, #0xf
    ZIP2  V23.2D, V3.2D, V20.2D
    ZIP2  V9.2S, V21.2S, V9.2S
    UZP2  V2.8H, V26.8H, V17.8H
    UZP2  V15.2D, V15.2D, V23.2D
    UZP1  V26.4S, V9.4S, V10.4S
    ZIP1  V20.8B, V5.8B, V16.8B
    TRN1  V12.8H, V0.8H, V19.8H
    ZIP2  V29.2D, V12.2D, V7.2D
    UZP2  V20.8H, V27.8H, V3.8H
    ZIP2  V16.4S, V8.4S, V25.4S
    UZP2  V11.16B, V29.16B, V21.16B
    EXT  V25.16B, V30.16B, V6.16B, #0x8
    UZP1  V9.16B, V4.16B, V26.16B
    UZP2  V7.4S, V9.4S, V22.4S
    ZIP1  V24.16B, V8.16B, V18.16B
    ZIP1  V1.2D, V2.2D, V28.2D
    UZP2  V10.2S, V31.2S, V8.2S
    ZIP1  V25.16B, V0.16B, V10.16B
    ZIP1  V23.2S, V8.2S, V18.2S
    UZP2  V15.16B, V30.16B, V29.16B
    EXT  V0.8B, V20.8B, V17.8B, #0x4
    EXT  V2.16B, V5.16B, V2.16B, #0x9
    UZP1  V13.2D, V1.2D, V5.2D
    TRN2  V19.2S, V18.2S, V13.2S
    ZIP2  V8.2D, V14.2D, V18.2D
    ZIP1  V25.2S, V15.2S, V29.2S
    EXT  V11.16B, V12.16B, V29.16B, #0x5
    UZP2  V22.8H, V0.8H, V15.8H
    TRN2  V16.16B, V30.16B, V2.16B
    EXT  V17.16B, V7.16B, V28.16B, #0x2
    UZP2  V24.2S, V10.2S, V18.2S
    ZIP1  V24.8H, V0.8H, V13.8H
    ZIP1  V24.2D, V17.2D, V25.2D
    UZP1  V19.2D, V5.2D, V4.2D
    ZIP2  V13.4H, V25.4H, V22.4H
    UZP2  V17.16B, V7.16B, V27.16B
    TRN1  V7.4S, V29.4S, V16.4S
    UZP2  V23.2D, V11.2D, V15.2D
    EXT  V0.8B, V20.8B, V27.8B, #0x5
    ZIP2  V19.4H, V24.4H, V29.4H
    EXT  V8.8B, V13.8B, V26.8B, #0x5
    TRN2  V9.16B, V14.16B, V25.16B
    ZIP2  V21.8B, V22.8B, V1.8B
    ZIP2  V7.16B, V0.16B, V3.16B
    EXT  V14.16B, V29.16B, V18.16B, #0x6
    ZIP1  V10.4H, V17.4H, V14.4H
    UZP2  V31.2D, V4.2D, V13.2D
    EXT  V21.8B, V23.8B, V9.8B, #0x5
    TRN2  V13.2S, V31.2S, V19.2S
    TRN1  V15.4S, V13.4S, V1.4S
    ZIP2  V11.2S, V24.2S, V23.2S
    UZP1  V21.2D, V18.2D, V17.2D
    ZIP2  V3.4H, V29.4H, V13.4H
    TRN2  V19.2S, V27.2S, V11.2S
    EXT  V1.16B, V5.16B, V3.16B, #0x0
    ZIP2  V28.8B, V2.8B, V22.8B
    ZIP2  V14.2D, V28.2D, V17.2D
    EXT  V26.8B, V2.8B, V31.8B, #0x3
    UZP2  V14.4S, V31.4S, V30.4S
    TRN2  V18.8B, V21.8B, V11.8B
    EXT  V7.8B, V18.8B, V17.8B, #0x0
    TRN1  V19.16B, V21.16B, V22.16B
    UZP2  V28.16B, V1.16B, V1.16B
    EXT  V22.16B, V6.16B, V7.16B, #0x6
    ZIP1  V22.4H, V27.4H, V10.4H
    ZIP2  V17.8H, V8.8H, V3.8H
    UZP2  V5.8H, V4.8H, V31.8H
    ZIP1  V3.8H, V25.8H, V15.8H
    UZP1  V5.4H, V27.4H, V14.4H
    EXT  V5.8B, V17.8B, V6.8B, #0x4
    TRN2  V17.8H, V14.8H, V19.8H
    ZIP2  V3.2D, V21.2D, V17.2D
    EXT  V25.16B, V19.16B, V22.16B, #0x5
    TRN1  V24.2S, V18.2S, V14.2S
    UZP2  V1.4H, V17.4H, V22.4H
    EXT  V4.8B, V23.8B, V13.8B, #0x7
    EXT  V1.16B, V5.16B, V12.16B, #0xd
    ZIP2  V25.2S, V8.2S, V4.2S
    UZP1  V29.8H, V9.8H, V24.8H
    EXT  V22.8B, V20.8B, V25.8B, #0x1
    UZP2  V8.2S, V3.2S, V24.2S
    EXT  V28.16B, V5.16B, V3.16B, #0x6
    UZP1  V17.4H, V15.4H, V28.4H
    EXT  V29.8B, V1.8B, V31.8B, #0x7
    TRN2  V22.16B, V16.16B, V7.16B
    UZP1  V27.8H, V13.8H, V8.8H
    TRN2  V30.16B, V27.16B, V30.16B
    EXT  V7.8B, V8.8B, V30.8B, #0x2
    ZIP1  V26.2D, V5.2D, V27.2D
    TRN2  V18.2D, V26.2D, V30.2D
    UZP1  V20.4S, V19.4S, V9.4S
    UZP1  V13.2S, V30.2S, V19.2S
    TRN2  V8.8B, V1.8B, V5.8B
    EXT  V24.8B, V9.8B, V24.8B, #0x6
    TRN2  V25.2S, V27.2S, V15.2S
    ZIP1  V8.4S, V12.4S, V3.4S
    TRN1  V18.8H, V21.8H, V26.8H
    UZP2  V21.8B, V3.8B, V28.8B
    ZIP1  V23.4H, V24.4H, V14.4H
    EXT  V10.8B, V16.8B, V22.8B, #0x3
    TRN1  V31.2S, V11.2S, V9.2S
    TRN2  V30.2S, V10.2S, V19.2S
    UZP1  V12.4H, V25.4H, V14.4H
    TRN2  V9.8H, V23.8H, V14.8H
    EXT  V21.8B, V7.8B, V19.8B, #0x7
    ZIP2  V19.4S, V18.4S, V8.4S
    ZIP2  V19.16B, V3.16B, V6.16B
    EXT  V26.16B, V15.16B, V17.16B, #0x9
    ZIP2  V29.2D, V2.2D, V12.2D
    EXT  V27.16B, V11.16B, V29.16B, #0xc
    UZP1  V15.2D, V13.2D, V11.2D
    EXT  V30.16B, V2.16B, V24.16B, #0xd
    TRN2  V2.2S, V18.2S, V2.2S
    EXT  V17.8B, V25.8B, V5.8B, #0x4
    ZIP2  V28.16B, V15.16B, V5.16B
    ZIP1  V21.2S, V23.2S, V5.2S
    EXT  V11.16B, V1.16B, V21.16B, #0x2
    EXT  V21.8B, V21.8B, V12.8B, #0x1
    ZIP2  V25.8B, V18.8B, V17.8B
    TRN2  V10.2S, V12.2S, V25.2S
    EXT  V2.16B, V6.16B, V9.16B, #0x9
    ZIP1  V3.2S, V26.2S, V2.2S
    UZP2  V27.8H, V6.8H, V26.8H
    ZIP2  V30.8B, V12.8B, V21.8B
    EXT  V15.8B, V24.8B, V4.8B, #0x4
    ZIP1  V3.2S, V27.2S, V2.2S
    EXT  V11.8B, V3.8B, V17.8B, #0x2
    UZP2  V29.4S, V20.4S, V13.4S
    EXT  V30.16B, V1.16B, V10.16B, #0x8
    ZIP1  V4.8B, V24.8B, V5.8B
    TRN2  V10.2S, V19.2S, V6.2S
    ZIP2  V18.4H, V31.4H, V10.4H
    EXT  V15.16B, V8.16B, V18.16B, #0x7
    EXT  V22.8B, V27.8B, V20.8B, #0x0
    TRN1  V27.4S, V29.4S, V26.4S
    ZIP1  V21.2D, V0.2D, V13.2D
    TRN1  V27.8B, V12.8B, V11.8B
    TRN2  V22.4S, V16.4S, V19.4S
    TRN1  V21.16B, V31.16B, V31.16B
    UZP2  V5.2S, V16.2S, V2.2S
    TRN1  V14.2S, V19.2S, V17.2S
    EXT  V27.8B, V2.8B, V31.8B, #0x4
    ZIP2  V25.2D, V30.2D, V6.2D
    ZIP1  V10.8H, V29.8H, V21.8H
    EXT  V4.8B, V13.8B, V28.8B, #0x5
    ZIP2  V16.8B, V23.8B, V31.8B
    EXT  V22.8B, V11.8B, V27.8B, #0x3
    ZIP2  V24.2D, V20.2D, V5.2D
    UZP1  V3.4H, V14.4H, V24.4H
    UZP2  V23.16B, V5.16B, V16.16B
    EXT  V12.16B, V30.16B, V10.16B, #0x2
    UZP1  V29.2S, V5.2S, V12.2S
    TRN1  V27.8B, V28.8B, V26.8B
    EXT  V15.16B, V3.16B, V17.16B, #0x4
    EXT  V26.16B, V29.16B, V16.16B, #0x8
    EXT  V26.8B, V29.8B, V26.8B, #0x3
    ZIP1  V17.8B, V6.8B, V24.8B
    TRN2  V1.4H, V11.4H, V25.4H
    UZP1  V13.8B, V3.8B, V23.8B
    UZP2  V13.4H, V8.4H, V4.4H
    EXT  V22.16B, V23.16B, V5.16B, #0x8
    EXT  V9.8B, V16.8B, V18.8B, #0x5
    SUBS  X24, X24, #0x1
    B.NE  TaishanSimdCryptoP01_label_1122
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X7, X16, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X13, X3, X3
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X20, X13, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X16, X28, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X6, X24, X6
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X19, X29, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X22, X11, X8
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X9
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X16, X20, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X3, X7, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X6, X8, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X21, X29, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X21, X25, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X26, X25, X17
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X20, X8, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X5, X11, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X22, X20, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X26, X8, X22
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X4, X5, X23
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X3, X29, X24
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X25
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X26
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    SUB  X2, X16, X27
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X2, X13, X28
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0xffff, LSL #0
    MOVK  X6, #0xffff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    SUB  X20, X6, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D2
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xff, LSL #48
    SUB  X25, X4, X7
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X22, X8, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D3
    MOVZ  X8, #0xff00, LSL #0
    SUB  X22, X8, X29
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X8, X23, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D4
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xff00, LSL #16
    MOVK  X23, #0xff00, LSL #32
    MOVK  X23, #0xff00, LSL #48
    SUB  X8, X23, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D5
    MOVZ  X9, #0xff00, LSL #0
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xff, LSL #48
    SUB  X8, X9, X16
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V6.D[1]
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X24, X4, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D6
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X24, X4, X25
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D7
    MOVZ  X23, #0x0, LSL #0
    SUB  X12, X23, X24
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X14, #0xff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xff00, LSL #32
    SUB  X20, X14, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
TaishanSimdCryptoP01_label_1105:
    FMOV  X10, D8
    MOVZ  X14, #0xff, LSL #0
    MOVK  X14, #0xff00, LSL #16
    MOVK  X14, #0xffff, LSL #48
    SUB  X20, X14, X10
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D9
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xff00, LSL #32
    MOVK  X25, #0xff, LSL #48
    SUB  X10, X25, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xff, LSL #32
    SUB  X7, X17, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D10
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X7, X17, X25
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X27, X21, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D11
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    SUB  X27, X21, X22
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xff, LSL #16
    MOVK  X24, #0xff, LSL #32
    SUB  X7, X24, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D12
    MOVZ  X24, #0xff, LSL #0
    MOVK  X24, #0xff, LSL #32
    SUB  X7, X24, X28
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D13
    MOVZ  X12, #0xff00, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xff00, LSL #32
    MOVK  X12, #0xff00, LSL #48
    SUB  X21, X12, X11
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X21, X7, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D14
    MOVZ  X7, #0xff00, LSL #0
    MOVK  X7, #0xff00, LSL #16
    SUB  X21, X7, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X6, X26, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D16
    MOVZ  X26, #0xff, LSL #0
    MOVK  X26, #0xff, LSL #16
    SUB  X6, X26, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D17
    MOVZ  X20, #0xff, LSL #0
    MOVK  X20, #0xff, LSL #16
    MOVK  X20, #0xff, LSL #32
    MOVK  X20, #0xff, LSL #48
    SUB  X19, X20, X9
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X23, X16, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D18
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #48
    SUB  X23, X16, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X6, #0xff00, LSL #0
    MOVK  X6, #0xff00, LSL #16
    MOVK  X6, #0xff00, LSL #32
    MOVK  X6, #0xff00, LSL #48
    SUB  X18, X6, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D19
    MOVZ  X6, #0xff00, LSL #0
    MOVK  X6, #0xff00, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xff00, LSL #48
    SUB  X18, X6, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xff, LSL #48
    SUB  X26, X22, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D20
    MOVZ  X22, #0xff, LSL #0
    MOVK  X22, #0xff, LSL #48
    SUB  X26, X22, X10
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D21
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X12, X18, X6
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X20, #0xff00, LSL #0
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xff, LSL #48
    SUB  X18, X20, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X18, X20, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X10, X18, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D23
    MOVZ  X18, #0xff, LSL #0
    MOVK  X18, #0xff, LSL #16
    SUB  X10, X18, X6
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X21, X10, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D24
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xff, LSL #48
    SUB  X21, X10, X18
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X2, X22, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D25
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xff, LSL #32
    MOVK  X22, #0xff, LSL #48
    SUB  X2, X22, X18
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D26
    MOVZ  X18, #0xff00, LSL #0
    SUB  X21, X18, X14
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X24, X14, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D27
    MOVZ  X14, #0xff, LSL #0
    MOVK  X14, #0xff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xff00, LSL #48
    SUB  X24, X14, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xff, LSL #32
    SUB  X12, X17, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D28
    MOVZ  X17, #0xff, LSL #0
    MOVK  X17, #0xff, LSL #16
    MOVK  X17, #0xff, LSL #32
    SUB  X12, X17, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D29
    MOVZ  X24, #0xff00, LSL #0
    MOVK  X24, #0xff, LSL #32
    SUB  X21, X24, X22
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x4ebe, LSL #0
    MOVK  X2, #0x3765, LSL #16
    MOVK  X2, #0xcf4c, LSL #32
    MOVK  X2, #0xaaa0, LSL #48
    MOVZ  X3, #0x57a9, LSL #0
    MOVK  X3, #0xf3a5, LSL #16
    MOVK  X3, #0x3c4a, LSL #32
    MOVK  X3, #0x5673, LSL #48
    MOVZ  X4, #0x205, LSL #0
    MOVK  X4, #0xa510, LSL #16
    MOVK  X4, #0x7384, LSL #32
    MOVK  X4, #0xff46, LSL #48
    MOVZ  X5, #0xd41d, LSL #0
    MOVK  X5, #0xa53, LSL #16
    MOVK  X5, #0xf97c, LSL #32
    MOVK  X5, #0xa35d, LSL #48
    MOVZ  X6, #0xf538, LSL #0
    MOVK  X6, #0x4d7a, LSL #16
    MOVK  X6, #0xbe2, LSL #32
    MOVK  X6, #0xf917, LSL #48
    MOVZ  X7, #0xc976, LSL #0
    MOVK  X7, #0xc50c, LSL #16
    MOVK  X7, #0x3c37, LSL #32
    MOVK  X7, #0x52fb, LSL #48
    MOVZ  X8, #0xaffd, LSL #0
    MOVK  X8, #0x7015, LSL #16
    MOVK  X8, #0x81c6, LSL #32
    MOVK  X8, #0x7f03, LSL #48
    MOVZ  X9, #0xe11b, LSL #0
    MOVK  X9, #0x6806, LSL #16
    MOVK  X9, #0x2c01, LSL #32
    MOVK  X9, #0xb07a, LSL #48
    MOVZ  X10, #0xde75, LSL #0
    MOVK  X10, #0x662d, LSL #16
    MOVK  X10, #0x3e38, LSL #32
    MOVK  X10, #0x5724, LSL #48
    MOVZ  X11, #0x7b94, LSL #0
    MOVK  X11, #0x9013, LSL #16
    MOVK  X11, #0x5211, LSL #32
    MOVK  X11, #0x3964, LSL #48
    MOVZ  X12, #0x3c19, LSL #0
    MOVK  X12, #0x28c6, LSL #16
    MOVK  X12, #0xb3c2, LSL #32
    MOVK  X12, #0xe029, LSL #48
    MOVZ  X13, #0xb4b9, LSL #0
    MOVK  X13, #0xf8fc, LSL #16
    MOVK  X13, #0xba3f, LSL #32
    MOVK  X13, #0x1e7d, LSL #48
    MOVZ  X14, #0x7e53, LSL #0
    MOVK  X14, #0x7aa1, LSL #16
    MOVK  X14, #0xe310, LSL #32
    MOVK  X14, #0x3294, LSL #48
    MOVZ  X16, #0x7a3, LSL #0
    MOVK  X16, #0x29c8, LSL #16
    MOVK  X16, #0xa417, LSL #32
    MOVK  X16, #0x14b3, LSL #48
    MOVZ  X17, #0xd231, LSL #0
    MOVK  X17, #0xdb5d, LSL #16
    MOVK  X17, #0xfcc5, LSL #32
    MOVK  X17, #0xf281, LSL #48
    MOVZ  X18, #0x31f9, LSL #0
    MOVK  X18, #0x732b, LSL #16
    MOVK  X18, #0x69dc, LSL #32
    MOVK  X18, #0xe2ce, LSL #48
    MOVZ  X19, #0x7974, LSL #0
    MOVK  X19, #0xac71, LSL #16
    MOVK  X19, #0x9e14, LSL #32
    MOVK  X19, #0x803d, LSL #48
    MOVZ  X20, #0x4394, LSL #0
    MOVK  X20, #0x1027, LSL #16
    MOVK  X20, #0xaa0b, LSL #32
    MOVK  X20, #0x883a, LSL #48
    MOVZ  X21, #0x4d75, LSL #0
    MOVK  X21, #0x1eab, LSL #16
    MOVK  X21, #0x1464, LSL #32
    MOVK  X21, #0xf36d, LSL #48
    MOVZ  X22, #0x4678, LSL #0
    MOVK  X22, #0x858b, LSL #16
    MOVK  X22, #0xa091, LSL #32
    MOVK  X22, #0x1d72, LSL #48
    MOVZ  X23, #0x6992, LSL #0
    MOVK  X23, #0x9b92, LSL #16
    MOVK  X23, #0x286e, LSL #32
    MOVK  X23, #0x8dae, LSL #48
    MOVZ  X24, #0x84, LSL #0
    MOVK  X24, #0x81df, LSL #16
    MOVK  X24, #0x4b10, LSL #32
    MOVK  X24, #0x59fa, LSL #48
    MOVZ  X25, #0x4d9b, LSL #0
    MOVK  X25, #0xde67, LSL #16
    MOVK  X25, #0x85ee, LSL #32
    MOVK  X25, #0x5ffc, LSL #48
    MOVZ  X26, #0x8272, LSL #0
    MOVK  X26, #0xfcb4, LSL #16
    MOVK  X26, #0x8cbd, LSL #32
    MOVK  X26, #0x6881, LSL #48
    MOVZ  X27, #0x9156, LSL #0
    MOVK  X27, #0xc461, LSL #16
    MOVK  X27, #0x5ea, LSL #32
    MOVK  X27, #0x22ce, LSL #48
    MOVZ  X28, #0xcdc1, LSL #0
    MOVK  X28, #0x95ca, LSL #16
    MOVK  X28, #0xf7d9, LSL #32
    MOVK  X28, #0xd140, LSL #48
    MOVZ  X29, #0x2020, LSL #0
    MOVK  X29, #0x43f2, LSL #16
    MOVK  X29, #0x2d80, LSL #32
    MOVK  X29, #0x4527, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X2
    FMOV  D1, X12
    FMOV  V1.D[1], X12
    FMOV  D2, X2
    FMOV  V2.D[1], X17
    FMOV  D3, X4
    FMOV  V3.D[1], X10
    FMOV  D4, X10
    FMOV  V4.D[1], X25
    FMOV  D5, X26
    FMOV  V5.D[1], X19
    FMOV  D6, X29
    FMOV  V6.D[1], X5
    FMOV  D7, X5
    FMOV  V7.D[1], X11
    FMOV  D8, X26
    FMOV  V8.D[1], X11
    FMOV  D9, X6
    FMOV  V9.D[1], X19
    FMOV  D10, X8
    FMOV  V10.D[1], X22
    FMOV  D11, X21
    FMOV  V11.D[1], X26
    FMOV  D12, X3
    FMOV  V12.D[1], X8
    FMOV  D13, X26
    FMOV  V13.D[1], X14
    FMOV  D14, X13
    FMOV  V14.D[1], X29
    FMOV  D15, X4
    FMOV  V15.D[1], X24
    FMOV  D16, X27
    FMOV  V16.D[1], X11
    FMOV  D17, X7
    FMOV  V17.D[1], X28
    FMOV  D18, X4
    FMOV  V18.D[1], X3
    FMOV  D19, X6
    FMOV  V19.D[1], X18
    FMOV  D20, X11
    FMOV  V20.D[1], X24
    FMOV  D21, X24
    FMOV  V21.D[1], X22
    FMOV  D22, X11
    FMOV  V22.D[1], X17
    FMOV  D23, X10
    FMOV  V23.D[1], X18
    FMOV  D24, X13
    FMOV  V24.D[1], X6
    FMOV  D25, X26
    FMOV  V25.D[1], X25
    FMOV  D26, X22
    FMOV  V26.D[1], X8
    FMOV  D27, X7
    FMOV  V27.D[1], X25
    FMOV  D28, X24
    FMOV  V28.D[1], X26
    FMOV  D29, X17
    FMOV  V29.D[1], X3
    FMOV  D30, X19
    FMOV  V30.D[1], X25
    FMOV  D31, X16
    FMOV  V31.D[1], X27
    MOVZ  X11, #0xa, LSL #0
TaishanSimdCryptoP01_label_1201:
    EXT  V0.8B, V16.8B, V4.8B, #0x6
    EXT  V23.8B, V7.8B, V24.8B, #0x4
    EXT  V27.8B, V23.8B, V19.8B, #0x7
    EXT  V29.16B, V14.16B, V31.16B, #0x0
    ZIP2  V14.4H, V6.4H, V9.4H
    UZP1  V25.4H, V15.4H, V26.4H
    EXT  V1.16B, V20.16B, V20.16B, #0xb
    TRN2  V5.2D, V18.2D, V4.2D
    EXT  V8.16B, V9.16B, V22.16B, #0x3
    ZIP1  V11.4H, V10.4H, V30.4H
    ZIP2  V24.8B, V11.8B, V25.8B
    EXT  V25.16B, V20.16B, V8.16B, #0x7
    TRN2  V17.4H, V17.4H, V31.4H
    ZIP1  V10.8B, V28.8B, V25.8B
    ZIP1  V9.8H, V29.8H, V3.8H
    ZIP1  V7.16B, V26.16B, V31.16B
    ZIP2  V19.8B, V21.8B, V15.8B
    UZP1  V19.16B, V26.16B, V26.16B
    UZP1  V21.8B, V24.8B, V14.8B
    EXT  V15.8B, V1.8B, V17.8B, #0x5
    TRN2  V12.2D, V4.2D, V23.2D
    UZP1  V24.4H, V21.4H, V22.4H
    UZP1  V15.8B, V8.8B, V27.8B
    EXT  V22.16B, V16.16B, V30.16B, #0x1
    ZIP2  V29.4H, V4.4H, V10.4H
    EXT  V6.8B, V1.8B, V13.8B, #0x2
    UZP2  V0.16B, V27.16B, V23.16B
    ZIP1  V18.4S, V12.4S, V11.4S
    ZIP1  V9.4S, V3.4S, V12.4S
    EXT  V9.16B, V24.16B, V6.16B, #0xc
    UZP2  V28.4S, V4.4S, V8.4S
    UZP1  V5.4S, V25.4S, V11.4S
    TRN2  V26.2S, V1.2S, V13.2S
    UZP1  V14.4H, V8.4H, V26.4H
    EXT  V16.8B, V15.8B, V30.8B, #0x3
    ZIP2  V18.16B, V31.16B, V11.16B
    TRN1  V14.2S, V5.2S, V6.2S
    EXT  V16.16B, V24.16B, V9.16B, #0x3
    TRN1  V30.16B, V6.16B, V22.16B
    UZP1  V10.8B, V12.8B, V3.8B
    TRN2  V17.8B, V3.8B, V12.8B
    UZP2  V6.4H, V11.4H, V16.4H
    TRN1  V3.8B, V11.8B, V20.8B
    ZIP2  V26.4H, V27.4H, V29.4H
    TRN1  V30.4H, V4.4H, V24.4H
    TRN1  V30.8B, V9.8B, V28.8B
    UZP2  V1.4S, V27.4S, V14.4S
    UZP2  V8.4H, V21.4H, V19.4H
    UZP1  V2.2D, V1.2D, V4.2D
    EXT  V2.8B, V26.8B, V5.8B, #0x0
    UZP1  V5.2S, V0.2S, V11.2S
    EXT  V3.8B, V23.8B, V5.8B, #0x3
    ZIP2  V26.2D, V19.2D, V8.2D
    EXT  V17.8B, V11.8B, V6.8B, #0x3
    UZP1  V3.2D, V4.2D, V7.2D
    ZIP1  V13.4H, V28.4H, V18.4H
    UZP2  V1.2D, V30.2D, V7.2D
    ZIP2  V10.4H, V22.4H, V28.4H
    TRN2  V21.4S, V29.4S, V12.4S
    ZIP2  V19.8B, V23.8B, V12.8B
    EXT  V2.16B, V14.16B, V12.16B, #0xb
    ZIP2  V2.8B, V25.8B, V9.8B
    UZP2  V17.16B, V7.16B, V3.16B
    EXT  V4.8B, V6.8B, V26.8B, #0x3
    UZP1  V23.16B, V23.16B, V9.16B
    UZP2  V19.16B, V0.16B, V4.16B
    UZP1  V21.8B, V17.8B, V0.8B
    ZIP2  V7.2D, V17.2D, V24.2D
    UZP1  V23.16B, V30.16B, V30.16B
    TRN2  V11.2S, V6.2S, V16.2S
    EXT  V18.8B, V0.8B, V13.8B, #0x7
    EXT  V16.8B, V1.8B, V21.8B, #0x4
    EXT  V10.8B, V5.8B, V22.8B, #0x1
    TRN2  V21.2D, V8.2D, V16.2D
    TRN2  V29.4S, V25.4S, V12.4S
    TRN1  V24.2D, V2.2D, V21.2D
    EXT  V22.16B, V20.16B, V24.16B, #0x6
    ZIP1  V2.4H, V27.4H, V11.4H
    UZP2  V18.2D, V3.2D, V15.2D
    EXT  V19.8B, V17.8B, V12.8B, #0x6
    EXT  V18.8B, V11.8B, V23.8B, #0x4
    TRN1  V15.16B, V5.16B, V18.16B
    EXT  V8.8B, V15.8B, V7.8B, #0x7
    ZIP2  V7.16B, V21.16B, V19.16B
    UZP2  V29.16B, V9.16B, V27.16B
    TRN1  V10.2S, V2.2S, V21.2S
    TRN1  V29.8H, V1.8H, V5.8H
    TRN1  V9.8H, V12.8H, V25.8H
    UZP2  V11.2D, V18.2D, V5.2D
    ZIP1  V27.8B, V11.8B, V9.8B
    UZP1  V2.16B, V21.16B, V14.16B
    UZP1  V7.2D, V19.2D, V3.2D
    ZIP2  V3.4S, V7.4S, V1.4S
    TRN2  V19.4H, V22.4H, V28.4H
    EXT  V3.16B, V19.16B, V27.16B, #0x2
    UZP2  V9.4H, V22.4H, V12.4H
    UZP2  V2.8H, V20.8H, V15.8H
    UZP2  V6.8H, V24.8H, V0.8H
    EXT  V1.16B, V25.16B, V19.16B, #0x5
    ZIP2  V31.2S, V8.2S, V25.2S
    UZP2  V24.4H, V9.4H, V11.4H
    TRN1  V17.16B, V26.16B, V24.16B
    ZIP1  V27.16B, V26.16B, V2.16B
    TRN2  V28.4H, V14.4H, V31.4H
    EXT  V11.8B, V24.8B, V18.8B, #0x6
    UZP2  V10.2D, V31.2D, V6.2D
    ZIP2  V3.4S, V30.4S, V30.4S
    TRN1  V12.4S, V30.4S, V11.4S
    EXT  V0.8B, V1.8B, V10.8B, #0x4
    EXT  V1.8B, V10.8B, V17.8B, #0x1
    UZP2  V13.16B, V26.16B, V10.16B
    TRN1  V11.16B, V29.16B, V3.16B
    ZIP1  V18.2D, V7.2D, V6.2D
    TRN1  V9.4H, V26.4H, V27.4H
    UZP2  V18.16B, V29.16B, V8.16B
    EXT  V30.8B, V9.8B, V12.8B, #0x7
    ZIP1  V29.4S, V30.4S, V7.4S
    UZP2  V12.8B, V30.8B, V1.8B
    UZP2  V18.8H, V30.8H, V9.8H
    EXT  V8.16B, V7.16B, V27.16B, #0xe
    UZP1  V31.2D, V26.2D, V2.2D
    TRN2  V2.16B, V24.16B, V23.16B
    TRN1  V27.16B, V13.16B, V28.16B
    UZP1  V0.2D, V11.2D, V1.2D
    EXT  V27.16B, V25.16B, V10.16B, #0x7
    ZIP1  V0.4S, V31.4S, V14.4S
    TRN1  V23.8B, V10.8B, V21.8B
    TRN2  V24.16B, V10.16B, V27.16B
    ZIP1  V24.8H, V30.8H, V22.8H
    TRN1  V6.4H, V12.4H, V9.4H
    TRN1  V13.4S, V17.4S, V0.4S
    EXT  V16.8B, V5.8B, V11.8B, #0x5
    TRN1  V27.8B, V24.8B, V4.8B
    ZIP2  V25.2D, V2.2D, V9.2D
    ZIP1  V18.8B, V7.8B, V23.8B
    EXT  V4.8B, V11.8B, V18.8B, #0x6
    ZIP2  V4.8B, V30.8B, V18.8B
    ZIP1  V22.4H, V28.4H, V22.4H
    EXT  V10.16B, V4.16B, V30.16B, #0xa
    EXT  V4.8B, V12.8B, V29.8B, #0x1
    UZP2  V24.8B, V29.8B, V20.8B
    TRN2  V3.4S, V14.4S, V18.4S
    TRN2  V17.16B, V17.16B, V17.16B
    UZP1  V15.4S, V12.4S, V10.4S
    ZIP1  V28.8B, V26.8B, V18.8B
    EXT  V6.8B, V4.8B, V5.8B, #0x3
    EXT  V21.8B, V2.8B, V10.8B, #0x5
TaishanSimdCryptoP01_label_133:
    UZP2  V18.8B, V22.8B, V2.8B
    UZP2  V5.4H, V29.4H, V25.4H
    ZIP1  V29.4S, V17.4S, V8.4S
    EXT  V1.16B, V22.16B, V28.16B, #0x5
    TRN1  V4.8H, V25.8H, V18.8H
    TRN2  V2.8H, V16.8H, V2.8H
    EXT  V21.8B, V9.8B, V29.8B, #0x0
    EXT  V0.16B, V0.16B, V18.16B, #0x5
    UZP2  V2.8H, V29.8H, V23.8H
    TRN2  V15.4H, V6.4H, V24.4H
    EXT  V2.8B, V30.8B, V25.8B, #0x7
    TRN2  V27.2S, V3.2S, V28.2S
    EXT  V30.8B, V26.8B, V23.8B, #0x0
    TRN1  V16.2D, V28.2D, V6.2D
    TRN2  V21.8B, V1.8B, V15.8B
    ZIP1  V15.2S, V31.2S, V22.2S
    TRN1  V4.4S, V6.4S, V9.4S
    ZIP1  V20.8H, V10.8H, V3.8H
    TRN2  V22.8H, V19.8H, V21.8H
    TRN1  V4.2S, V8.2S, V9.2S
    EXT  V22.16B, V6.16B, V13.16B, #0x1
    TRN1  V11.16B, V10.16B, V22.16B
    TRN1  V18.16B, V24.16B, V21.16B
    EXT  V1.8B, V22.8B, V16.8B, #0x7
    EXT  V16.16B, V13.16B, V8.16B, #0x5
    UZP1  V1.4S, V28.4S, V17.4S
    ZIP1  V20.8B, V7.8B, V29.8B
    ZIP2  V13.8H, V9.8H, V15.8H
    TRN2  V24.8H, V22.8H, V17.8H
    TRN2  V18.4S, V16.4S, V31.4S
    UZP1  V12.4H, V21.4H, V4.4H
    TRN2  V0.2S, V6.2S, V1.2S
    TRN2  V6.8H, V9.8H, V8.8H
    UZP2  V9.8H, V23.8H, V16.8H
    UZP2  V18.8H, V8.8H, V10.8H
    UZP1  V21.16B, V0.16B, V21.16B
    EXT  V1.16B, V0.16B, V18.16B, #0xe
    ZIP2  V18.8B, V3.8B, V6.8B
    EXT  V26.16B, V2.16B, V1.16B, #0xc
    EXT  V14.16B, V30.16B, V1.16B, #0x4
    UZP2  V10.8B, V23.8B, V11.8B
    ZIP2  V28.4H, V14.4H, V20.4H
    ZIP2  V21.16B, V11.16B, V28.16B
    UZP1  V23.8H, V2.8H, V19.8H
    TRN2  V26.2S, V2.2S, V16.2S
    ZIP1  V21.8H, V14.8H, V21.8H
    ZIP1  V24.2D, V21.2D, V20.2D
    TRN2  V9.2D, V4.2D, V0.2D
    EXT  V29.8B, V1.8B, V7.8B, #0x4
    EXT  V11.16B, V3.16B, V29.16B, #0x4
    TRN1  V13.16B, V23.16B, V2.16B
    ZIP2  V13.2S, V18.2S, V8.2S
    UZP1  V10.2S, V28.2S, V9.2S
    SUBS  X11, X11, #0x1
    B.NE  TaishanSimdCryptoP01_label_1201
    MOVZ  X27, #0x4ebe, LSL #0
    MOVK  X27, #0x3765, LSL #16
    MOVK  X27, #0xcf4c, LSL #32
    MOVK  X27, #0xaaa0, LSL #48
    SUB  X17, X27, X2
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x57a9, LSL #0
    MOVK  X9, #0xf3a5, LSL #16
    MOVK  X9, #0x3c4a, LSL #32
    MOVK  X9, #0x5673, LSL #48
    SUB  X22, X9, X3
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x205, LSL #0
    MOVK  X7, #0xa510, LSL #16
    MOVK  X7, #0x7384, LSL #32
    MOVK  X7, #0xff46, LSL #48
    SUB  X23, X7, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xd41d, LSL #0
    MOVK  X8, #0xa53, LSL #16
    MOVK  X8, #0xf97c, LSL #32
    MOVK  X8, #0xa35d, LSL #48
    SUB  X17, X8, X5
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0xf538, LSL #0
    MOVK  X28, #0x4d7a, LSL #16
    MOVK  X28, #0xbe2, LSL #32
    MOVK  X28, #0xf917, LSL #48
    SUB  X5, X28, X6
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x205, LSL #0
    MOVK  X18, #0xa510, LSL #16
    MOVK  X18, #0x7384, LSL #32
    MOVK  X18, #0xff46, LSL #48
    SUB  X20, X18, X7
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0xd41d, LSL #0
    MOVK  X20, #0xa53, LSL #16
    MOVK  X20, #0xf97c, LSL #32
    MOVK  X20, #0xa35d, LSL #48
    SUB  X5, X20, X8
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x57a9, LSL #0
    MOVK  X28, #0xf3a5, LSL #16
    MOVK  X28, #0x3c4a, LSL #32
    MOVK  X28, #0x5673, LSL #48
    SUB  X8, X28, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0xde75, LSL #0
    MOVK  X22, #0x662d, LSL #16
    MOVK  X22, #0x3e38, LSL #32
    MOVK  X22, #0x5724, LSL #48
    SUB  X4, X22, X10
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X27, X22, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x3c19, LSL #0
    MOVK  X17, #0x28c6, LSL #16
    MOVK  X17, #0xb3c2, LSL #32
    MOVK  X17, #0xe029, LSL #48
    SUB  X19, X17, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0xb4b9, LSL #0
    MOVK  X27, #0xf8fc, LSL #16
    MOVK  X27, #0xba3f, LSL #32
    MOVK  X27, #0x1e7d, LSL #48
    SUB  X19, X27, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x7e53, LSL #0
    MOVK  X5, #0x7aa1, LSL #16
    MOVK  X5, #0xe310, LSL #32
    MOVK  X5, #0x3294, LSL #48
    SUB  X16, X5, X14
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X4, X25, X16
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x3c19, LSL #0
    MOVK  X12, #0x28c6, LSL #16
    MOVK  X12, #0xb3c2, LSL #32
    MOVK  X12, #0xe029, LSL #48
    SUB  X8, X12, X17
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x205, LSL #0
    MOVK  X17, #0xa510, LSL #16
    MOVK  X17, #0x7384, LSL #32
    MOVK  X17, #0xff46, LSL #48
    SUB  X8, X17, X18
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X7, X18, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0xd41d, LSL #0
    MOVK  X19, #0xa53, LSL #16
    MOVK  X19, #0xf97c, LSL #32
    MOVK  X19, #0xa35d, LSL #48
    SUB  X16, X19, X20
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x4d75, LSL #0
    MOVK  X21, #0x1eab, LSL #16
    MOVK  X21, #0x1464, LSL #32
    MOVK  X21, #0xf36d, LSL #48
    SUB  X9, X21, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X22, X12, X22
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X2, X19, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x84, LSL #0
    MOVK  X18, #0x81df, LSL #16
    MOVK  X18, #0x4b10, LSL #32
    MOVK  X18, #0x59fa, LSL #48
    SUB  X26, X18, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X26
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0xb4b9, LSL #0
    MOVK  X25, #0xf8fc, LSL #16
    MOVK  X25, #0xba3f, LSL #32
    MOVK  X25, #0x1e7d, LSL #48
    SUB  X24, X25, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x57a9, LSL #0
    MOVK  X12, #0xf3a5, LSL #16
    MOVK  X12, #0x3c4a, LSL #32
    MOVK  X12, #0x5673, LSL #48
    SUB  X5, X12, X28
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x2020, LSL #0
    MOVK  X25, #0x43f2, LSL #16
    MOVK  X25, #0x2d80, LSL #32
    MOVK  X25, #0x4527, LSL #48
    SUB  X20, X25, X29
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D2
    MOVZ  X7, #0x0, LSL #0
    SUB  X4, X7, X29
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D3
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D4
    MOVZ  X27, #0x0, LSL #0
    SUB  X17, X27, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D5
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X28
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D6
    MOVZ  X23, #0x0, LSL #0
    SUB  X24, X23, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X23
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D9
    MOVZ  X6, #0x0, LSL #0
    SUB  X25, X6, X16
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D10
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X23
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D11
    MOVZ  X28, #0x0, LSL #0
    SUB  X13, X28, X6
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X26
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D12
    MOVZ  X3, #0x0, LSL #0
    SUB  X5, X3, X26
TaishanSimdCryptoP01_label_341:
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
TaishanSimdCryptoP01_label_954:
    SUB  X23, X20, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X23, X20, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D14
    MOVZ  X20, #0x0, LSL #0
    SUB  X6, X20, X2
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D16
    MOVZ  X26, #0x0, LSL #0
    SUB  X13, X26, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D17
    MOVZ  X18, #0x0, LSL #0
    SUB  X5, X18, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X6, X7, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D19
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X7
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D20
    MOVZ  X19, #0x0, LSL #0
    SUB  X27, X19, X11
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D21
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X22
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D22
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X8
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X17, X2, X29
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D24
    MOVZ  X5, #0x0, LSL #0
    SUB  X10, X5, X7
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D25
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X4
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D26
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X28
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D27
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X8
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D28
    MOVZ  X5, #0x0, LSL #0
    SUB  X3, X5, X25
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X8
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
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
    FMOV  V0.D[1], X19
    FMOV  D1, X20
    FMOV  V1.D[1], X10
    FMOV  D2, X20
    FMOV  V2.D[1], X8
    FMOV  D3, X21
    FMOV  V3.D[1], X20
    FMOV  D4, X8
    FMOV  V4.D[1], X21
    FMOV  D5, X12
    FMOV  V5.D[1], X26
    FMOV  D6, X29
    FMOV  V6.D[1], X28
    FMOV  D7, X11
    FMOV  V7.D[1], X24
    FMOV  D8, X27
    FMOV  V8.D[1], X17
    FMOV  D9, X28
    FMOV  V9.D[1], X8
    FMOV  D10, X12
    FMOV  V10.D[1], X3
    FMOV  D11, X14
    FMOV  V11.D[1], X5
    FMOV  D12, X10
    FMOV  V12.D[1], X27
    FMOV  D13, X2
    FMOV  V13.D[1], X21
    FMOV  D14, X14
    FMOV  V14.D[1], X3
    FMOV  D15, X8
    FMOV  V15.D[1], X27
    FMOV  D16, X27
    FMOV  V16.D[1], X5
    FMOV  D17, X7
    FMOV  V17.D[1], X7
    FMOV  D18, X27
    FMOV  V18.D[1], X13
    FMOV  D19, X22
    FMOV  V19.D[1], X26
    FMOV  D20, X25
    FMOV  V20.D[1], X17
    FMOV  D21, X27
    FMOV  V21.D[1], X11
    FMOV  D22, X11
    FMOV  V22.D[1], X11
    FMOV  D23, X26
    FMOV  V23.D[1], X25
    FMOV  D24, X7
    FMOV  V24.D[1], X3
    FMOV  D25, X13
    FMOV  V25.D[1], X12
    FMOV  D26, X28
    FMOV  V26.D[1], X25
    FMOV  D27, X20
    FMOV  V27.D[1], X20
    FMOV  D28, X7
    FMOV  V28.D[1], X29
    FMOV  D29, X26
    FMOV  V29.D[1], X8
    FMOV  D30, X20
    FMOV  V30.D[1], X11
    FMOV  D31, X14
    FMOV  V31.D[1], X23
    MOVZ  X5, #0xa, LSL #0
TaishanSimdCryptoP01_label_1281:
    EXT  V2.16B, V24.16B, V0.16B, #0x1
    ZIP2  V12.2S, V9.2S, V13.2S
    UZP1  V20.16B, V22.16B, V31.16B
    UZP1  V15.4S, V13.4S, V22.4S
    EXT  V31.16B, V17.16B, V21.16B, #0x1
    EXT  V27.16B, V11.16B, V1.16B, #0x1
    EXT  V28.8B, V25.8B, V25.8B, #0x2
    EXT  V2.8B, V21.8B, V23.8B, #0x6
    UZP2  V14.4H, V16.4H, V15.4H
    ZIP1  V0.8B, V16.8B, V31.8B
    UZP1  V19.2S, V11.2S, V29.2S
    TRN1  V20.8B, V19.8B, V19.8B
    TRN2  V13.8B, V4.8B, V20.8B
    ZIP1  V11.2S, V19.2S, V3.2S
    EXT  V9.16B, V17.16B, V21.16B, #0x4
    UZP1  V29.4H, V2.4H, V26.4H
    ZIP1  V18.16B, V2.16B, V6.16B
    EXT  V6.16B, V9.16B, V0.16B, #0x5
    ZIP2  V6.4S, V9.4S, V15.4S
    ZIP1  V24.8H, V25.8H, V0.8H
    TRN2  V29.4S, V27.4S, V8.4S
    EXT  V6.8B, V24.8B, V10.8B, #0x4
    ZIP1  V20.2S, V16.2S, V28.2S
    ZIP2  V9.8B, V22.8B, V1.8B
    UZP1  V22.4H, V27.4H, V11.4H
    ZIP1  V3.2D, V24.2D, V13.2D
    ZIP2  V28.16B, V31.16B, V28.16B
    ZIP1  V29.8H, V5.8H, V0.8H
    EXT  V29.16B, V25.16B, V28.16B, #0xc
    UZP2  V30.8H, V18.8H, V11.8H
    ZIP1  V10.2D, V19.2D, V9.2D
    ZIP1  V23.4H, V29.4H, V23.4H
    EXT  V30.16B, V23.16B, V2.16B, #0xb
    EXT  V21.8B, V28.8B, V8.8B, #0x4
    UZP1  V26.16B, V0.16B, V20.16B
    TRN2  V9.16B, V2.16B, V28.16B
    TRN2  V31.4H, V26.4H, V2.4H
    UZP2  V20.4S, V6.4S, V31.4S
    EXT  V1.8B, V13.8B, V3.8B, #0x1
    EXT  V11.16B, V22.16B, V16.16B, #0x1
    UZP2  V4.4S, V3.4S, V24.4S
    TRN2  V23.4H, V1.4H, V12.4H
    TRN2  V29.8H, V27.8H, V0.8H
    ZIP2  V3.2D, V24.2D, V12.2D
    ZIP2  V21.16B, V7.16B, V0.16B
    UZP1  V5.4H, V16.4H, V29.4H
    TRN1  V11.16B, V31.16B, V30.16B
    EXT  V10.8B, V9.8B, V10.8B, #0x2
    EXT  V10.16B, V23.16B, V10.16B, #0x2
    TRN2  V11.2D, V21.2D, V9.2D
    TRN2  V24.4H, V10.4H, V5.4H
    EXT  V11.16B, V22.16B, V16.16B, #0x5
    TRN1  V18.8B, V4.8B, V12.8B
    UZP1  V1.2S, V26.2S, V26.2S
    TRN2  V10.2S, V20.2S, V20.2S
    EXT  V28.8B, V5.8B, V30.8B, #0x6
    UZP2  V27.8B, V12.8B, V18.8B
    EXT  V26.8B, V5.8B, V31.8B, #0x2
    TRN1  V31.16B, V15.16B, V15.16B
    EXT  V10.16B, V11.16B, V25.16B, #0xd
    UZP1  V3.4S, V5.4S, V29.4S
    TRN1  V13.4H, V16.4H, V20.4H
    UZP2  V10.4S, V5.4S, V27.4S
    TRN1  V16.8B, V1.8B, V2.8B
    UZP2  V12.16B, V31.16B, V31.16B
    ZIP1  V26.16B, V12.16B, V2.16B
    ZIP2  V4.8B, V15.8B, V2.8B
    ZIP1  V23.4H, V9.4H, V6.4H
    UZP1  V31.4H, V2.4H, V21.4H
    TRN1  V11.2S, V11.2S, V20.2S
    EXT  V23.16B, V18.16B, V14.16B, #0x9
    TRN2  V0.8H, V21.8H, V25.8H
    EXT  V14.8B, V5.8B, V20.8B, #0x3
    ZIP1  V30.2S, V15.2S, V28.2S
    ZIP1  V20.4S, V10.4S, V20.4S
    EXT  V3.8B, V15.8B, V23.8B, #0x3
    UZP1  V29.2S, V20.2S, V17.2S
    UZP2  V11.2D, V4.2D, V24.2D
    EXT  V27.16B, V16.16B, V9.16B, #0x6
    UZP2  V20.4H, V7.4H, V3.4H
    UZP2  V29.4H, V1.4H, V20.4H
    TRN2  V17.4H, V12.4H, V30.4H
    EXT  V27.8B, V15.8B, V30.8B, #0x4
    ZIP2  V13.2S, V11.2S, V26.2S
    ZIP1  V11.2S, V26.2S, V20.2S
    EXT  V12.16B, V12.16B, V5.16B, #0x1
    EXT  V30.8B, V2.8B, V22.8B, #0x0
    ZIP1  V16.4H, V15.4H, V8.4H
    ZIP2  V9.8B, V22.8B, V3.8B
    TRN1  V13.2S, V6.2S, V21.2S
    EXT  V31.16B, V13.16B, V8.16B, #0xc
    UZP1  V31.8H, V19.8H, V18.8H
    TRN1  V10.8H, V4.8H, V24.8H
    ZIP2  V8.4H, V9.4H, V10.4H
    UZP1  V27.16B, V0.16B, V12.16B
    UZP2  V16.8H, V21.8H, V13.8H
    EXT  V1.16B, V17.16B, V11.16B, #0xa
    UZP2  V29.8B, V19.8B, V25.8B
    TRN2  V1.16B, V8.16B, V16.16B
    EXT  V27.8B, V22.8B, V14.8B, #0x2
    ZIP2  V27.16B, V2.16B, V18.16B
    TRN2  V27.4H, V13.4H, V11.4H
    TRN2  V7.8H, V14.8H, V27.8H
    TRN2  V20.8H, V10.8H, V25.8H
    EXT  V19.8B, V21.8B, V28.8B, #0x0
    EXT  V30.8B, V4.8B, V1.8B, #0x7
    EXT  V17.16B, V20.16B, V5.16B, #0xe
    ZIP1  V27.16B, V25.16B, V18.16B
    ZIP1  V19.4S, V11.4S, V4.4S
    ZIP2  V0.4S, V24.4S, V2.4S
    EXT  V16.8B, V28.8B, V8.8B, #0x3
    TRN1  V27.4H, V21.4H, V27.4H
    TRN1  V15.2D, V29.2D, V29.2D
    EXT  V27.16B, V15.16B, V30.16B, #0x4
    TRN1  V11.16B, V21.16B, V1.16B
    UZP1  V21.4H, V16.4H, V0.4H
    TRN2  V31.16B, V31.16B, V3.16B
    EXT  V24.8B, V22.8B, V19.8B, #0x3
    EXT  V11.8B, V17.8B, V25.8B, #0x1
    ZIP1  V4.2S, V28.2S, V4.2S
    ZIP2  V20.2D, V25.2D, V9.2D
    TRN1  V7.4S, V12.4S, V17.4S
    UZP2  V13.8H, V23.8H, V2.8H
    UZP1  V29.2D, V29.2D, V27.2D
    TRN2  V5.16B, V21.16B, V28.16B
    UZP2  V25.2D, V12.2D, V10.2D
    EXT  V28.16B, V3.16B, V29.16B, #0xe
    EXT  V22.16B, V30.16B, V27.16B, #0x0
    ZIP1  V17.8H, V21.8H, V24.8H
    TRN1  V11.8B, V13.8B, V31.8B
    UZP2  V24.8H, V22.8H, V29.8H
    UZP1  V15.2D, V7.2D, V2.2D
    EXT  V28.8B, V22.8B, V7.8B, #0x6
    UZP1  V20.2S, V7.2S, V26.2S
    ZIP2  V25.4H, V9.4H, V13.4H
    EXT  V3.16B, V17.16B, V19.16B, #0x4
    TRN1  V30.8B, V31.8B, V21.8B
    ZIP2  V27.4H, V31.4H, V15.4H
    EXT  V29.8B, V2.8B, V2.8B, #0x0
    UZP1  V14.16B, V19.16B, V21.16B
    UZP1  V16.2S, V9.2S, V0.2S
    ZIP2  V13.4H, V22.4H, V28.4H
    TRN1  V31.2D, V9.2D, V26.2D
    ZIP2  V21.4S, V8.4S, V31.4S
    TRN2  V17.4H, V31.4H, V23.4H
    UZP1  V7.4S, V31.4S, V26.4S
    ZIP2  V24.2D, V12.2D, V24.2D
    EXT  V30.16B, V6.16B, V15.16B, #0x2
    TRN2  V13.8H, V30.8H, V17.8H
    TRN2  V11.4S, V21.4S, V24.4S
    EXT  V29.16B, V0.16B, V13.16B, #0x1
    TRN1  V22.8H, V4.8H, V5.8H
    TRN2  V2.4H, V27.4H, V4.4H
    UZP1  V27.8H, V28.8H, V11.8H
    TRN2  V17.2D, V9.2D, V6.2D
    ZIP1  V11.8B, V3.8B, V3.8B
    ZIP2  V15.2D, V29.2D, V14.2D
    EXT  V21.16B, V12.16B, V30.16B, #0xa
    ZIP1  V31.2S, V24.2S, V11.2S
    TRN1  V11.2D, V6.2D, V20.2D
    ZIP1  V6.4S, V8.4S, V0.4S
    UZP1  V13.2D, V13.2D, V6.2D
    ZIP2  V21.16B, V25.16B, V14.16B
    EXT  V0.16B, V23.16B, V14.16B, #0xb
    EXT  V12.16B, V26.16B, V7.16B, #0xb
    UZP1  V6.4S, V26.4S, V21.4S
    ZIP1  V22.8H, V13.8H, V11.8H
    EXT  V4.8B, V23.8B, V29.8B, #0x7
    UZP1  V0.8B, V21.8B, V29.8B
    EXT  V29.8B, V15.8B, V0.8B, #0x4
    TRN1  V3.8H, V14.8H, V18.8H
    UZP2  V4.2S, V11.2S, V12.2S
    TRN1  V23.2S, V12.2S, V12.2S
    UZP2  V27.16B, V16.16B, V24.16B
    UZP1  V1.4H, V22.4H, V17.4H
    EXT  V6.16B, V25.16B, V29.16B, #0xe
    UZP1  V19.2S, V4.2S, V3.2S
    TRN2  V14.2D, V24.2D, V10.2D
    TRN1  V31.16B, V5.16B, V9.16B
    UZP1  V28.8B, V26.8B, V27.8B
    ZIP2  V28.8H, V12.8H, V0.8H
    UZP1  V10.2D, V2.2D, V0.2D
    ZIP1  V17.8B, V1.8B, V5.8B
    ZIP1  V27.8B, V27.8B, V15.8B
    TRN2  V7.8B, V27.8B, V25.8B
    TRN2  V27.2S, V24.2S, V19.2S
    TRN1  V26.16B, V26.16B, V31.16B
    UZP2  V20.4H, V14.4H, V11.4H
    ZIP2  V8.16B, V28.16B, V20.16B
    EXT  V9.8B, V9.8B, V25.8B, #0x6
    TRN2  V25.2S, V12.2S, V30.2S
    UZP1  V23.4H, V16.4H, V28.4H
    ZIP1  V25.2S, V10.2S, V29.2S
    TRN1  V27.8H, V4.8H, V5.8H
    TRN2  V12.8B, V18.8B, V0.8B
    ZIP1  V31.8B, V5.8B, V8.8B
    ZIP1  V18.4H, V17.4H, V1.4H
    ZIP2  V15.8H, V20.8H, V8.8H
    EXT  V25.16B, V29.16B, V24.16B, #0xc
    EXT  V11.8B, V4.8B, V4.8B, #0x3
    SUBS  X5, X5, #0x1
    B.NE  TaishanSimdCryptoP01_label_1281
    MOVZ  X28, #0x0, LSL #0
    SUB  X23, X28, X2
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X3
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X20, X2, X4
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X13, X21, X5
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X4, X5, X7
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X8
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X7, X2, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
TaishanSimdCryptoP01_label_1107:
    MOVZ  X14, #0x0, LSL #0
    SUB  X6, X14, X10
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X2, X22, X11
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X16, X8, X12
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X13, X29, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X8, X20, X14
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X20, X22, X16
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X14, X3, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X18
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X5, X2, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X21
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X22
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X11, X22, X24
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X19, X2, X25
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X20, X24, X26
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X13, X7, X27
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X12, X2, X28
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X5, X12, X29
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D2
    MOVZ  X19, #0x0, LSL #0
    SUB  X14, X19, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D3
    MOVZ  X4, #0x0, LSL #0
    SUB  X25, X4, X13
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X19
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D5
    MOVZ  X23, #0x0, LSL #0
    SUB  X26, X23, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D6
    MOVZ  X2, #0x0, LSL #0
    SUB  X3, X2, X5
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D7
    MOVZ  X8, #0x0, LSL #0
    SUB  X3, X8, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D8
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X21
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D9
    MOVZ  X3, #0x0, LSL #0
    SUB  X7, X3, X27
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D11
    MOVZ  X8, #0x0, LSL #0
    SUB  X20, X8, X17
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X22, D12
    MOVZ  X10, #0x0, LSL #0
    SUB  X28, X10, X22
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D13
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X20
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D14
    MOVZ  X11, #0x0, LSL #0
    SUB  X28, X11, X2
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D16
    MOVZ  X19, #0x0, LSL #0
    SUB  X9, X19, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D17
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X10
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X20
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D19
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D20
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X4
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D21
    MOVZ  X7, #0x0, LSL #0
    SUB  X23, X7, X4
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X13, X23, X19
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D23
    MOVZ  X8, #0x0, LSL #0
    SUB  X17, X8, X13
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D24
    MOVZ  X4, #0x0, LSL #0
    SUB  X26, X4, X6
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D25
    MOVZ  X23, #0x0, LSL #0
    SUB  X18, X23, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D26
    MOVZ  X20, #0x0, LSL #0
    SUB  X19, X20, X7
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D27
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X8
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X20, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X20
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D29
    MOVZ  X8, #0x0, LSL #0
    SUB  X18, X8, X4
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X4
    FMOV  V0.D[1], X5
    FMOV  D1, X4
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X10
    FMOV  D3, X14
    FMOV  V3.D[1], X5
    FMOV  D4, X16
    FMOV  V4.D[1], X25
    FMOV  D5, X27
    FMOV  V5.D[1], X19
    FMOV  D6, X11
    FMOV  V6.D[1], X28
    FMOV  D7, X4
    FMOV  V7.D[1], X29
    FMOV  D8, X20
    FMOV  V8.D[1], X23
    FMOV  D9, X8
    FMOV  V9.D[1], X19
    FMOV  D10, X4
    FMOV  V10.D[1], X11
    FMOV  D11, X13
    FMOV  V11.D[1], X4
    FMOV  D12, X7
    FMOV  V12.D[1], X25
    FMOV  D13, X19
    FMOV  V13.D[1], X4
    FMOV  D14, X7
    FMOV  V14.D[1], X20
    FMOV  D15, X16
    FMOV  V15.D[1], X26
    FMOV  D16, X22
    FMOV  V16.D[1], X16
    FMOV  D17, X11
    FMOV  V17.D[1], X23
    FMOV  D18, X29
    FMOV  V18.D[1], X6
    FMOV  D19, X17
    FMOV  V19.D[1], X17
    FMOV  D20, X6
    FMOV  V20.D[1], X11
    FMOV  D21, X22
    FMOV  V21.D[1], X13
    FMOV  D22, X4
    FMOV  V22.D[1], X18
    FMOV  D23, X29
    FMOV  V23.D[1], X18
    FMOV  D24, X2
    FMOV  V24.D[1], X18
    FMOV  D25, X27
    FMOV  V25.D[1], X5
    FMOV  D26, X12
    FMOV  V26.D[1], X7
    FMOV  D27, X14
    FMOV  V27.D[1], X26
    FMOV  D28, X14
    FMOV  V28.D[1], X11
    FMOV  D29, X6
    FMOV  V29.D[1], X21
    FMOV  D30, X6
    FMOV  V30.D[1], X22
    FMOV  D31, X27
    FMOV  V31.D[1], X12
    MOVZ  X12, #0xf, LSL #0
TaishanSimdCryptoP01_label_1357:
    TRN1  V28.4S, V31.4S, V6.4S
    UZP1  V14.2D, V27.2D, V21.2D
    UZP1  V29.2S, V9.2S, V5.2S
    UZP1  V14.16B, V10.16B, V18.16B
    ZIP1  V14.4H, V8.4H, V4.4H
    UZP1  V24.2D, V28.2D, V4.2D
    EXT  V29.8B, V30.8B, V11.8B, #0x6
    EXT  V12.8B, V27.8B, V26.8B, #0x2
    ZIP2  V5.8B, V15.8B, V23.8B
    EXT  V21.16B, V26.16B, V1.16B, #0x8
    UZP2  V8.16B, V18.16B, V15.16B
    TRN1  V31.4S, V23.4S, V23.4S
    UZP1  V31.4S, V3.4S, V31.4S
    ZIP1  V27.8H, V4.8H, V19.8H
    EXT  V22.8B, V4.8B, V9.8B, #0x2
    TRN1  V8.2D, V5.2D, V5.2D
    ZIP2  V8.2D, V5.2D, V12.2D
    UZP1  V3.2S, V10.2S, V13.2S
    TRN2  V16.2D, V10.2D, V30.2D
    ZIP2  V28.4S, V8.4S, V30.4S
    TRN2  V6.16B, V9.16B, V3.16B
    ZIP2  V5.8H, V27.8H, V24.8H
    ZIP1  V23.2S, V9.2S, V5.2S
    TRN1  V20.4H, V21.4H, V28.4H
    EXT  V19.16B, V28.16B, V28.16B, #0x4
    TRN1  V6.2D, V19.2D, V21.2D
    EXT  V3.16B, V14.16B, V18.16B, #0x6
    EXT  V25.8B, V17.8B, V30.8B, #0x2
    ZIP2  V0.8H, V8.8H, V26.8H
    TRN2  V13.4S, V6.4S, V4.4S
    ZIP2  V14.16B, V22.16B, V7.16B
    ZIP2  V0.4S, V28.4S, V18.4S
    EXT  V22.8B, V10.8B, V27.8B, #0x0
    UZP2  V6.16B, V8.16B, V5.16B
    ZIP1  V9.16B, V16.16B, V25.16B
    ZIP1  V9.8B, V31.8B, V2.8B
    ZIP1  V24.2S, V19.2S, V6.2S
    TRN1  V18.16B, V11.16B, V9.16B
    ZIP1  V4.8H, V18.8H, V28.8H
    EXT  V17.16B, V1.16B, V16.16B, #0xe
    EXT  V18.8B, V10.8B, V28.8B, #0x2
    TRN2  V17.8B, V5.8B, V9.8B
    UZP2  V25.8B, V4.8B, V0.8B
    TRN2  V27.8H, V26.8H, V11.8H
    TRN1  V14.4H, V30.4H, V27.4H
    UZP1  V22.16B, V10.16B, V17.16B
    EXT  V24.8B, V21.8B, V25.8B, #0x3
    TRN2  V20.8B, V23.8B, V11.8B
    TRN2  V20.8H, V12.8H, V14.8H
    EXT  V22.16B, V18.16B, V23.16B, #0x3
    UZP2  V17.4H, V24.4H, V31.4H
    ZIP2  V3.4S, V31.4S, V21.4S
    TRN1  V8.16B, V13.16B, V20.16B
    EXT  V22.8B, V16.8B, V8.8B, #0x1
    UZP2  V7.2S, V26.2S, V0.2S
    TRN1  V8.4H, V26.4H, V7.4H
    ZIP1  V2.8B, V17.8B, V8.8B
    UZP2  V14.4S, V27.4S, V31.4S
    EXT  V14.16B, V6.16B, V22.16B, #0x9
    UZP2  V27.2S, V22.2S, V28.2S
    EXT  V14.16B, V3.16B, V19.16B, #0x1
    ZIP2  V4.16B, V28.16B, V22.16B
    ZIP1  V22.8H, V29.8H, V22.8H
    ZIP2  V8.8H, V26.8H, V24.8H
    EXT  V31.8B, V11.8B, V22.8B, #0x7
    UZP1  V1.8B, V7.8B, V14.8B
    TRN2  V29.8B, V21.8B, V17.8B
    EXT  V15.16B, V1.16B, V8.16B, #0x2
    UZP2  V14.2D, V31.2D, V23.2D
    UZP2  V3.16B, V11.16B, V27.16B
    UZP1  V18.8B, V27.8B, V2.8B
    EXT  V25.16B, V19.16B, V28.16B, #0x9
    EXT  V21.8B, V11.8B, V4.8B, #0x4
    UZP1  V3.16B, V1.16B, V17.16B
    ZIP1  V5.2D, V3.2D, V12.2D
    ZIP1  V18.2D, V28.2D, V12.2D
    TRN2  V28.16B, V25.16B, V5.16B
    ZIP2  V14.2S, V24.2S, V6.2S
    ZIP1  V20.16B, V8.16B, V13.16B
    UZP2  V6.4S, V28.4S, V18.4S
    EXT  V5.16B, V21.16B, V13.16B, #0x8
    EXT  V10.8B, V5.8B, V22.8B, #0x6
    TRN2  V25.8H, V15.8H, V10.8H
    UZP1  V29.8H, V19.8H, V29.8H
    UZP2  V22.16B, V24.16B, V0.16B
    TRN1  V1.4S, V22.4S, V18.4S
    ZIP2  V28.2D, V30.2D, V17.2D
    UZP2  V11.16B, V11.16B, V20.16B
    TRN1  V31.2D, V14.2D, V23.2D
    EXT  V27.8B, V22.8B, V14.8B, #0x2
    TRN1  V26.2S, V8.2S, V1.2S
    ZIP2  V15.4H, V30.4H, V10.4H
    EXT  V28.16B, V16.16B, V14.16B, #0x4
    ZIP2  V23.2S, V22.2S, V1.2S
    TRN1  V28.4S, V3.4S, V14.4S
    EXT  V25.8B, V26.8B, V15.8B, #0x6
    ZIP2  V11.8H, V26.8H, V10.8H
    TRN2  V29.16B, V13.16B, V2.16B
    UZP1  V29.2S, V2.2S, V0.2S
    TRN1  V21.8H, V29.8H, V1.8H
    EXT  V25.16B, V4.16B, V24.16B, #0x7
    TRN1  V21.4H, V31.4H, V21.4H
    UZP1  V18.4S, V29.4S, V25.4S
    ZIP1  V21.16B, V20.16B, V10.16B
    EXT  V18.8B, V26.8B, V12.8B, #0x2
    ZIP1  V19.8B, V17.8B, V31.8B
    UZP2  V6.4S, V11.4S, V21.4S
    TRN1  V23.8B, V23.8B, V24.8B
    ZIP1  V30.4H, V21.4H, V18.4H
    ZIP1  V28.4S, V30.4S, V17.4S
    EXT  V5.16B, V3.16B, V28.16B, #0x5
    UZP1  V22.4S, V3.4S, V15.4S
    EXT  V26.16B, V2.16B, V15.16B, #0xb
    EXT  V7.8B, V28.8B, V0.8B, #0x7
    EXT  V17.16B, V18.16B, V9.16B, #0x4
    UZP1  V2.2S, V22.2S, V26.2S
    UZP1  V30.8H, V7.8H, V11.8H
    UZP1  V31.4H, V29.4H, V12.4H
    EXT  V31.8B, V7.8B, V31.8B, #0x3
    TRN1  V17.2D, V14.2D, V23.2D
    ZIP2  V21.8H, V2.8H, V31.8H
    EXT  V8.16B, V19.16B, V27.16B, #0x2
    EXT  V6.8B, V26.8B, V9.8B, #0x3
    ZIP1  V8.4H, V21.4H, V10.4H
    UZP1  V13.4H, V22.4H, V15.4H
    EXT  V25.8B, V28.8B, V19.8B, #0x3
    TRN1  V4.2D, V8.2D, V16.2D
    ZIP2  V14.2D, V8.2D, V10.2D
    TRN2  V17.8B, V10.8B, V30.8B
    ZIP1  V11.2D, V15.2D, V3.2D
    EXT  V12.8B, V29.8B, V31.8B, #0x3
    EXT  V22.8B, V22.8B, V8.8B, #0x1
    ZIP1  V27.2D, V11.2D, V19.2D
    TRN2  V28.2S, V20.2S, V3.2S
    TRN1  V18.4H, V4.4H, V19.4H
    UZP1  V4.2S, V31.2S, V16.2S
    ZIP2  V11.2S, V10.2S, V18.2S
    EXT  V29.8B, V3.8B, V5.8B, #0x4
    EXT  V21.16B, V13.16B, V27.16B, #0x9
    EXT  V20.8B, V16.8B, V10.8B, #0x7
    EXT  V28.16B, V15.16B, V19.16B, #0x2
    ZIP1  V21.2S, V3.2S, V27.2S
    TRN1  V11.8H, V18.8H, V2.8H
    UZP1  V5.2S, V21.2S, V12.2S
    EXT  V24.8B, V30.8B, V28.8B, #0x1
    EXT  V2.16B, V23.16B, V20.16B, #0x5
    UZP2  V14.2S, V0.2S, V27.2S
    TRN1  V15.4S, V24.4S, V1.4S
    TRN2  V13.2S, V8.2S, V23.2S
    TRN1  V2.8H, V4.8H, V29.8H
    UZP2  V10.2S, V13.2S, V27.2S
    TRN2  V13.4H, V25.4H, V16.4H
    TRN1  V1.2D, V9.2D, V11.2D
    UZP1  V29.4S, V21.4S, V18.4S
    ZIP2  V30.8H, V6.8H, V3.8H
    UZP1  V0.4S, V20.4S, V15.4S
    TRN2  V15.4H, V10.4H, V25.4H
    EXT  V12.8B, V17.8B, V11.8B, #0x1
    ZIP2  V11.2S, V8.2S, V15.2S
    ZIP2  V22.4H, V5.4H, V14.4H
    ZIP2  V29.4S, V0.4S, V29.4S
    EXT  V7.16B, V10.16B, V24.16B, #0xf
    TRN1  V19.8B, V14.8B, V21.8B
    EXT  V11.8B, V28.8B, V26.8B, #0x0
    EXT  V2.8B, V7.8B, V11.8B, #0x3
    UZP1  V1.4H, V25.4H, V22.4H
    EXT  V13.16B, V5.16B, V22.16B, #0xb
    ZIP2  V5.4H, V27.4H, V4.4H
    ZIP2  V23.4S, V19.4S, V30.4S
    ZIP2  V6.16B, V11.16B, V27.16B
    ZIP1  V2.4S, V8.4S, V5.4S
    TRN1  V13.2D, V3.2D, V16.2D
    EXT  V3.8B, V18.8B, V17.8B, #0x5
    UZP2  V17.2S, V31.2S, V25.2S
    EXT  V23.8B, V0.8B, V16.8B, #0x0
    ZIP2  V20.2D, V31.2D, V2.2D
    EXT  V24.8B, V19.8B, V8.8B, #0x4
    ZIP2  V1.16B, V21.16B, V13.16B
    UZP2  V4.16B, V29.16B, V25.16B
    ZIP1  V22.2S, V29.2S, V9.2S
    TRN2  V10.4S, V23.4S, V14.4S
    ZIP1  V19.16B, V8.16B, V22.16B
    ZIP2  V31.4H, V19.4H, V23.4H
    UZP2  V19.16B, V5.16B, V13.16B
    UZP2  V31.8H, V0.8H, V10.8H
    TRN2  V30.4H, V30.4H, V24.4H
    EXT  V9.8B, V14.8B, V15.8B, #0x0
    EXT  V8.16B, V7.16B, V24.16B, #0x3
    UZP2  V5.8H, V23.8H, V28.8H
    ZIP2  V12.8H, V28.8H, V6.8H
    EXT  V10.8B, V31.8B, V27.8B, #0x7
    UZP1  V12.8H, V16.8H, V17.8H
    UZP2  V23.8B, V20.8B, V23.8B
    EXT  V14.16B, V2.16B, V19.16B, #0x5
TaishanSimdCryptoP01_label_1137:
    EXT  V20.16B, V6.16B, V10.16B, #0x8
    EXT  V28.16B, V8.16B, V12.16B, #0x7
    TRN2  V13.16B, V24.16B, V11.16B
    UZP1  V5.4S, V3.4S, V27.4S
    TRN2  V5.4S, V1.4S, V25.4S
    UZP1  V5.4S, V6.4S, V0.4S
    SUBS  X12, X12, #0x1
    B.NE  TaishanSimdCryptoP01_label_1357
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X7, X9, X2
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X9, X12, X3
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X25, X26, X4
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X16, X12, X5
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X19, X7, X6
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X13, X25, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X17, X29, X8
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X8, X3, X9
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0xffff, LSL #0
    MOVK  X29, #0xffff, LSL #16
    MOVK  X29, #0xffff, LSL #32
    MOVK  X29, #0xffff, LSL #48
    SUB  X8, X29, X10
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X23, X20, X11
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0xffff, LSL #0
    MOVK  X25, #0xffff, LSL #16
    MOVK  X25, #0xffff, LSL #32
    MOVK  X25, #0xffff, LSL #48
    SUB  X21, X25, X12
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X13
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X12, X27, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X13, X6, X16
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X27, X17, X17
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X14, X11, X18
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X19
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X2, X28, X20
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X16, X12, X22
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X21, X17, X24
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X2, X26, X25
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0xffff, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
TaishanSimdCryptoP01_label_1318:
    MOVK  X21, #0xffff, LSL #48
    SUB  X27, X21, X26
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X12, X25, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0xffff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    SUB  X19, X14, X28
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X29
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D2
    MOVZ  X3, #0x0, LSL #0
    SUB  X17, X3, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D4
    MOVZ  X23, #0x0, LSL #0
    SUB  X5, X23, X27
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D5
    MOVZ  X11, #0x0, LSL #0
    SUB  X19, X11, X18
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D6
    MOVZ  X14, #0x0, LSL #0
    SUB  X9, X14, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D8
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D9
    MOVZ  X7, #0x0, LSL #0
    SUB  X26, X7, X27
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D10
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X13
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X13, X12, X17
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D12
    MOVZ  X13, #0x0, LSL #0
    SUB  X14, X13, X25
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D13
    MOVZ  X18, #0x0, LSL #0
    SUB  X14, X18, X17
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D14
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D16
    MOVZ  X17, #0x0, LSL #0
    SUB  X10, X17, X4
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X3, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X3
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D18
    MOVZ  X7, #0x0, LSL #0
    SUB  X8, X7, X21
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D19
    MOVZ  X3, #0x0, LSL #0
    SUB  X26, X3, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D20
    MOVZ  X26, #0x0, LSL #0
    SUB  X16, X26, X2
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D21
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D22
    MOVZ  X20, #0x0, LSL #0
    SUB  X21, X20, X23
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V23.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D23
    MOVZ  X6, #0x0, LSL #0
    SUB  X29, X6, X19
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D24
    MOVZ  X23, #0x0, LSL #0
    SUB  X11, X23, X8
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D25
    MOVZ  X14, #0x0, LSL #0
    SUB  X20, X14, X9
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D26
    MOVZ  X25, #0x0, LSL #0
    SUB  X18, X25, X28
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D27
    MOVZ  X12, #0x0, LSL #0
    SUB  X6, X12, X9
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X16, X7, X10
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D29
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X5
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x85d9, LSL #0
    MOVK  X2, #0x1c3b, LSL #16
    MOVK  X2, #0x93dc, LSL #32
    MOVK  X2, #0x3dd9, LSL #48
    MOVZ  X3, #0xdb6f, LSL #0
    MOVK  X3, #0x3d2a, LSL #16
    MOVK  X3, #0xeb2a, LSL #32
    MOVK  X3, #0x340a, LSL #48
    MOVZ  X4, #0x4567, LSL #0
    MOVK  X4, #0x98a1, LSL #16
    MOVK  X4, #0xf7a1, LSL #32
    MOVK  X4, #0x4800, LSL #48
    MOVZ  X5, #0x8443, LSL #0
    MOVK  X5, #0x35b3, LSL #16
    MOVK  X5, #0x1750, LSL #32
    MOVK  X5, #0x3de3, LSL #48
    MOVZ  X6, #0xa5b, LSL #0
    MOVK  X6, #0x5824, LSL #16
    MOVK  X6, #0x7efd, LSL #32
    MOVK  X6, #0x44e7, LSL #48
    MOVZ  X7, #0x737f, LSL #0
    MOVK  X7, #0x9ad6, LSL #16
    MOVK  X7, #0xc7f, LSL #32
    MOVK  X7, #0xd5f8, LSL #48
    MOVZ  X8, #0x7211, LSL #0
    MOVK  X8, #0xdc1d, LSL #16
    MOVK  X8, #0x426d, LSL #32
    MOVK  X8, #0xf8cd, LSL #48
    MOVZ  X9, #0x9383, LSL #0
    MOVK  X9, #0xea6a, LSL #16
    MOVK  X9, #0xb63e, LSL #32
    MOVK  X9, #0xf7d5, LSL #48
    MOVZ  X10, #0x2d40, LSL #0
    MOVK  X10, #0x67a6, LSL #16
    MOVK  X10, #0x976b, LSL #32
    MOVK  X10, #0x2620, LSL #48
    MOVZ  X11, #0xc69f, LSL #0
    MOVK  X11, #0x680c, LSL #16
    MOVK  X11, #0x4e95, LSL #32
    MOVK  X11, #0xc683, LSL #48
    MOVZ  X12, #0xaecb, LSL #0
    MOVK  X12, #0x76a0, LSL #16
    MOVK  X12, #0x621a, LSL #32
    MOVK  X12, #0x9439, LSL #48
    MOVZ  X13, #0x3d2c, LSL #0
    MOVK  X13, #0x9aca, LSL #16
    MOVK  X13, #0xe1d3, LSL #32
    MOVK  X13, #0x701b, LSL #48
    MOVZ  X14, #0x25ae, LSL #0
    MOVK  X14, #0x5934, LSL #16
    MOVK  X14, #0x9389, LSL #32
    MOVK  X14, #0x9437, LSL #48
    MOVZ  X16, #0x3d17, LSL #0
    MOVK  X16, #0xb925, LSL #16
    MOVK  X16, #0xa0d8, LSL #32
    MOVK  X16, #0xc124, LSL #48
    MOVZ  X17, #0xf432, LSL #0
    MOVK  X17, #0xdae5, LSL #16
    MOVK  X17, #0x31c4, LSL #32
    MOVK  X17, #0x5e62, LSL #48
    MOVZ  X18, #0x612f, LSL #0
    MOVK  X18, #0x559e, LSL #16
    MOVK  X18, #0xd4f0, LSL #32
    MOVK  X18, #0xc63e, LSL #48
    MOVZ  X19, #0x90d8, LSL #0
    MOVK  X19, #0x63fa, LSL #16
    MOVK  X19, #0xf7f4, LSL #32
    MOVK  X19, #0x20e2, LSL #48
    MOVZ  X20, #0x1309, LSL #0
    MOVK  X20, #0x98a6, LSL #16
    MOVK  X20, #0x74c3, LSL #32
    MOVK  X20, #0xc155, LSL #48
    MOVZ  X21, #0xd597, LSL #0
    MOVK  X21, #0xa698, LSL #16
    MOVK  X21, #0xbd26, LSL #32
    MOVK  X21, #0x8d63, LSL #48
    MOVZ  X22, #0xb56f, LSL #0
    MOVK  X22, #0xcb04, LSL #16
    MOVK  X22, #0x893d, LSL #32
    MOVK  X22, #0xa27, LSL #48
    MOVZ  X23, #0xfc49, LSL #0
    MOVK  X23, #0x690a, LSL #16
    MOVK  X23, #0x7285, LSL #32
    MOVK  X23, #0x9764, LSL #48
    MOVZ  X24, #0x58bd, LSL #0
    MOVK  X24, #0xd30b, LSL #16
    MOVK  X24, #0xb08e, LSL #32
    MOVK  X24, #0x900b, LSL #48
    MOVZ  X25, #0xd0c6, LSL #0
    MOVK  X25, #0x5e5, LSL #16
    MOVK  X25, #0xc3f, LSL #32
    MOVK  X25, #0xb25d, LSL #48
    MOVZ  X26, #0xb2e6, LSL #0
    MOVK  X26, #0xf314, LSL #16
    MOVK  X26, #0x5cd6, LSL #32
    MOVK  X26, #0x92e6, LSL #48
    MOVZ  X27, #0x8312, LSL #0
    MOVK  X27, #0xa315, LSL #16
    MOVK  X27, #0x80d0, LSL #32
    MOVK  X27, #0x181d, LSL #48
    MOVZ  X28, #0x43c0, LSL #0
    MOVK  X28, #0x4d33, LSL #16
    MOVK  X28, #0xc021, LSL #32
    MOVK  X28, #0xf23f, LSL #48
    MOVZ  X29, #0xa6aa, LSL #0
    MOVK  X29, #0x31e1, LSL #16
    MOVK  X29, #0xf78e, LSL #32
    MOVK  X29, #0xc214, LSL #48
    FMOV  D0, X10
    FMOV  V0.D[1], X17
    FMOV  D1, X21
    FMOV  V1.D[1], X20
    FMOV  D2, X9
    FMOV  V2.D[1], X24
    FMOV  D3, X3
    FMOV  V3.D[1], X28
    FMOV  D4, X27
    FMOV  V4.D[1], X27
    FMOV  D5, X29
    FMOV  V5.D[1], X28
    FMOV  D6, X23
    FMOV  V6.D[1], X12
    FMOV  D7, X23
    FMOV  V7.D[1], X3
    FMOV  D8, X17
    FMOV  V8.D[1], X2
    FMOV  D9, X5
    FMOV  V9.D[1], X2
    FMOV  D10, X24
    FMOV  V10.D[1], X2
    FMOV  D11, X3
    FMOV  V11.D[1], X5
    FMOV  D12, X6
    FMOV  V12.D[1], X25
    FMOV  D13, X7
    FMOV  V13.D[1], X22
    FMOV  D14, X14
    FMOV  V14.D[1], X22
    FMOV  D15, X11
    FMOV  V15.D[1], X20
    FMOV  D16, X6
    FMOV  V16.D[1], X3
    FMOV  D17, X12
    FMOV  V17.D[1], X20
    FMOV  D18, X6
    FMOV  V18.D[1], X29
    FMOV  D19, X14
    FMOV  V19.D[1], X9
    FMOV  D20, X21
    FMOV  V20.D[1], X7
    FMOV  D21, X12
    FMOV  V21.D[1], X6
    FMOV  D22, X8
    FMOV  V22.D[1], X21
    FMOV  D23, X20
    FMOV  V23.D[1], X6
    FMOV  D24, X14
    FMOV  V24.D[1], X7
    FMOV  D25, X21
    FMOV  V25.D[1], X28
    FMOV  D26, X9
    FMOV  V26.D[1], X23
    FMOV  D27, X5
    FMOV  V27.D[1], X3
TaishanSimdCryptoP01_label_114:
    FMOV  D28, X24
    FMOV  V28.D[1], X22
    FMOV  D29, X11
    FMOV  V29.D[1], X27
    FMOV  D30, X20
    FMOV  V30.D[1], X22
    FMOV  D31, X29
    FMOV  V31.D[1], X7
    MOVZ  X11, #0xa, LSL #0
TaishanSimdCryptoP01_label_1433:
    TRN2  V10.2S, V0.2S, V24.2S
    UZP2  V27.2S, V28.2S, V26.2S
    TRN1  V23.2D, V16.2D, V29.2D
    ZIP1  V30.4S, V25.4S, V28.4S
    UZP1  V12.8B, V16.8B, V17.8B
    ZIP1  V31.4S, V2.4S, V26.4S
    ZIP1  V10.2S, V23.2S, V17.2S
    UZP2  V24.4H, V18.4H, V20.4H
    UZP2  V23.16B, V16.16B, V31.16B
    EXT  V27.16B, V23.16B, V29.16B, #0x9
    EXT  V7.8B, V29.8B, V27.8B, #0x4
    ZIP1  V7.8H, V19.8H, V17.8H
    TRN1  V24.4S, V30.4S, V12.4S
    UZP1  V24.4H, V0.4H, V18.4H
    TRN1  V30.8B, V16.8B, V8.8B
    ZIP2  V22.2S, V26.2S, V26.2S
    EXT  V18.8B, V3.8B, V26.8B, #0x5
    TRN2  V19.8B, V6.8B, V29.8B
    ZIP1  V19.2D, V10.2D, V3.2D
    TRN2  V18.4H, V11.4H, V16.4H
    EXT  V30.8B, V27.8B, V31.8B, #0x3
    ZIP1  V13.8H, V3.8H, V31.8H
    UZP1  V4.8H, V29.8H, V3.8H
    EXT  V21.16B, V19.16B, V20.16B, #0x6
    TRN1  V3.8B, V17.8B, V3.8B
    UZP2  V18.8H, V22.8H, V13.8H
    ZIP1  V17.16B, V12.16B, V8.16B
    EXT  V28.8B, V29.8B, V7.8B, #0x7
    EXT  V11.8B, V27.8B, V31.8B, #0x4
    ZIP2  V25.16B, V6.16B, V23.16B
    UZP1  V21.16B, V28.16B, V28.16B
    TRN2  V20.2D, V12.2D, V18.2D
    TRN1  V7.2D, V3.2D, V4.2D
    EXT  V16.16B, V7.16B, V24.16B, #0x0
    EXT  V7.8B, V5.8B, V5.8B, #0x0
    TRN1  V28.2S, V30.2S, V22.2S
    UZP2  V12.2S, V5.2S, V8.2S
    UZP1  V18.16B, V18.16B, V21.16B
    UZP1  V20.8H, V20.8H, V12.8H
    ZIP2  V10.4S, V16.4S, V30.4S
    EXT  V31.8B, V3.8B, V28.8B, #0x0
    EXT  V11.16B, V19.16B, V27.16B, #0x7
    ZIP2  V6.4H, V25.4H, V10.4H
    EXT  V20.16B, V15.16B, V25.16B, #0xc
    TRN2  V13.8H, V24.8H, V23.8H
    ZIP1  V6.16B, V13.16B, V29.16B
    TRN2  V12.16B, V0.16B, V20.16B
    UZP1  V14.8B, V2.8B, V22.8B
    UZP2  V26.4S, V30.4S, V27.4S
    EXT  V28.8B, V11.8B, V17.8B, #0x6
    EXT  V10.8B, V13.8B, V1.8B, #0x3
    EXT  V14.16B, V9.16B, V11.16B, #0xa
    TRN1  V9.8B, V10.8B, V30.8B
    UZP1  V0.8B, V5.8B, V12.8B
    EXT  V24.16B, V18.16B, V7.16B, #0x9
    UZP2  V13.8H, V3.8H, V31.8H
    EXT  V4.8B, V19.8B, V3.8B, #0x7
    EXT  V19.8B, V9.8B, V20.8B, #0x3
    EXT  V19.16B, V0.16B, V6.16B, #0x4
    ZIP2  V12.4H, V17.4H, V25.4H
    TRN1  V10.8H, V18.8H, V22.8H
    TRN2  V26.8H, V22.8H, V14.8H
    TRN1  V12.8B, V11.8B, V22.8B
    TRN1  V19.4H, V28.4H, V22.4H
    ZIP2  V27.4H, V25.4H, V24.4H
    UZP1  V11.2S, V17.2S, V15.2S
    ZIP1  V27.16B, V29.16B, V1.16B
    EXT  V30.8B, V13.8B, V28.8B, #0x5
    EXT  V12.16B, V6.16B, V4.16B, #0xd
    UZP1  V28.4S, V12.4S, V18.4S
    EXT  V0.8B, V9.8B, V11.8B, #0x7
    EXT  V24.8B, V28.8B, V9.8B, #0x2
    ZIP2  V24.2S, V28.2S, V13.2S
    EXT  V24.16B, V17.16B, V19.16B, #0xb
    TRN2  V31.8H, V30.8H, V21.8H
    UZP2  V14.8B, V11.8B, V11.8B
    ZIP1  V9.8H, V30.8H, V28.8H
    UZP1  V24.4S, V28.4S, V30.4S
    ZIP1  V12.4H, V7.4H, V19.4H
    EXT  V0.8B, V24.8B, V3.8B, #0x2
    ZIP1  V3.8H, V8.8H, V30.8H
    TRN1  V12.8H, V24.8H, V10.8H
    UZP2  V26.2D, V16.2D, V13.2D
    ZIP2  V22.16B, V23.16B, V20.16B
    EXT  V27.8B, V0.8B, V29.8B, #0x1
    ZIP2  V12.8B, V3.8B, V13.8B
    UZP2  V26.2D, V16.2D, V16.2D
    TRN2  V30.4H, V21.4H, V22.4H
    EXT  V13.16B, V10.16B, V4.16B, #0x0
    TRN1  V21.4H, V21.4H, V13.4H
    EXT  V29.16B, V0.16B, V20.16B, #0x2
    TRN1  V29.4H, V13.4H, V29.4H
    UZP2  V12.2S, V12.2S, V29.2S
    TRN1  V23.4S, V12.4S, V17.4S
    EXT  V30.16B, V2.16B, V16.16B, #0x5
    TRN1  V0.4H, V20.4H, V14.4H
    TRN2  V7.8B, V23.8B, V5.8B
    UZP2  V2.16B, V0.16B, V7.16B
    TRN1  V23.8H, V8.8H, V23.8H
    UZP1  V9.2D, V16.2D, V12.2D
    TRN2  V30.8B, V21.8B, V31.8B
    UZP1  V30.4S, V24.4S, V5.4S
    ZIP1  V2.2S, V26.2S, V4.2S
    ZIP1  V22.8H, V7.8H, V29.8H
    ZIP2  V29.16B, V9.16B, V16.16B
    EXT  V29.16B, V29.16B, V15.16B, #0x4
    UZP2  V23.2S, V12.2S, V0.2S
    EXT  V30.16B, V8.16B, V10.16B, #0x5
    UZP2  V2.4S, V1.4S, V20.4S
    TRN1  V27.8H, V21.8H, V10.8H
    ZIP2  V12.8H, V10.8H, V29.8H
    ZIP1  V24.2D, V15.2D, V0.2D
    EXT  V6.16B, V27.16B, V5.16B, #0xc
    UZP2  V24.8H, V7.8H, V27.8H
    TRN1  V24.4H, V22.4H, V22.4H
    TRN2  V18.8B, V4.8B, V21.8B
    UZP1  V23.4H, V15.4H, V31.4H
    ZIP2  V16.8B, V8.8B, V6.8B
    UZP1  V17.2D, V0.2D, V27.2D
    EXT  V22.16B, V1.16B, V28.16B, #0x8
    EXT  V8.16B, V13.16B, V22.16B, #0xc
    TRN2  V20.4S, V22.4S, V10.4S
    EXT  V5.8B, V17.8B, V31.8B, #0x3
    EXT  V5.8B, V21.8B, V4.8B, #0x6
    UZP1  V11.8H, V11.8H, V31.8H
    TRN1  V16.16B, V21.16B, V12.16B
    TRN2  V2.16B, V8.16B, V30.16B
    TRN2  V8.2S, V18.2S, V11.2S
    UZP1  V22.4S, V8.4S, V23.4S
    UZP1  V30.16B, V4.16B, V18.16B
    UZP2  V10.4S, V22.4S, V24.4S
    ZIP1  V4.16B, V30.16B, V10.16B
    TRN2  V29.4S, V21.4S, V15.4S
    EXT  V10.16B, V16.16B, V7.16B, #0xe
    EXT  V0.16B, V13.16B, V11.16B, #0xd
    EXT  V14.8B, V4.8B, V20.8B, #0x7
    UZP2  V25.4H, V30.4H, V22.4H
    ZIP2  V10.8B, V15.8B, V27.8B
    UZP1  V2.2S, V24.2S, V14.2S
    ZIP2  V2.8H, V21.8H, V19.8H
    ZIP2  V0.16B, V11.16B, V20.16B
    EXT  V29.8B, V31.8B, V17.8B, #0x3
    UZP1  V16.4S, V30.4S, V0.4S
    EXT  V5.16B, V22.16B, V18.16B, #0x3
    UZP1  V28.8H, V29.8H, V1.8H
    UZP2  V25.4S, V10.4S, V25.4S
    TRN2  V24.8B, V22.8B, V27.8B
    UZP1  V28.8H, V12.8H, V22.8H
    ZIP2  V27.8B, V12.8B, V5.8B
    UZP2  V5.8H, V3.8H, V7.8H
    TRN2  V13.8B, V13.8B, V22.8B
    UZP2  V28.2D, V0.2D, V25.2D
    TRN2  V25.8B, V5.8B, V13.8B
    ZIP1  V21.8B, V8.8B, V1.8B
    EXT  V28.8B, V21.8B, V17.8B, #0x4
    ZIP1  V16.2D, V9.2D, V6.2D
    ZIP2  V7.4H, V21.4H, V3.4H
    UZP1  V19.8H, V17.8H, V8.8H
    TRN2  V0.16B, V17.16B, V22.16B
    EXT  V28.16B, V21.16B, V17.16B, #0x9
    EXT  V2.16B, V4.16B, V10.16B, #0xc
    EXT  V10.8B, V9.8B, V3.8B, #0x0
    ZIP2  V3.2S, V15.2S, V21.2S
    TRN2  V16.2S, V0.2S, V13.2S
    ZIP1  V27.16B, V18.16B, V17.16B
    ZIP2  V12.8H, V31.8H, V12.8H
    ZIP2  V19.16B, V23.16B, V29.16B
    EXT  V6.16B, V15.16B, V13.16B, #0x4
    ZIP2  V5.8H, V8.8H, V12.8H
    EXT  V9.16B, V12.16B, V31.16B, #0x0
    EXT  V2.16B, V16.16B, V12.16B, #0xb
    UZP2  V19.4S, V4.4S, V13.4S
    ZIP1  V23.8H, V28.8H, V12.8H
    ZIP1  V25.4H, V10.4H, V20.4H
    TRN1  V7.8B, V31.8B, V29.8B
    EXT  V13.8B, V16.8B, V27.8B, #0x7
    ZIP2  V31.2S, V19.2S, V7.2S
    TRN2  V12.16B, V4.16B, V7.16B
    EXT  V21.8B, V8.8B, V20.8B, #0x2
    EXT  V0.16B, V1.16B, V9.16B, #0x1
    UZP1  V1.8B, V17.8B, V8.8B
    EXT  V28.8B, V30.8B, V8.8B, #0x3
    UZP1  V22.8H, V14.8H, V7.8H
    EXT  V7.8B, V3.8B, V12.8B, #0x0
    ZIP1  V14.4S, V20.4S, V28.4S
    EXT  V31.8B, V21.8B, V6.8B, #0x0
    UZP2  V2.4S, V2.4S, V25.4S
    TRN1  V24.2S, V23.2S, V29.2S
    EXT  V19.16B, V1.16B, V6.16B, #0x8
    EXT  V2.8B, V22.8B, V23.8B, #0x0
    ZIP2  V14.8H, V5.8H, V12.8H
    TRN2  V5.2D, V25.2D, V4.2D
    ZIP2  V1.4H, V24.4H, V16.4H
    EXT  V0.8B, V31.8B, V7.8B, #0x5
    ZIP1  V25.4S, V22.4S, V27.4S
    ZIP1  V0.8B, V24.8B, V15.8B
    EXT  V0.8B, V25.8B, V5.8B, #0x5
    ZIP2  V0.8H, V17.8H, V0.8H
    UZP2  V25.2S, V0.2S, V28.2S
    TRN1  V9.8H, V9.8H, V5.8H
    SUBS  X11, X11, #0x1
    B.NE  TaishanSimdCryptoP01_label_1433
    MOVZ  X28, #0x85d9, LSL #0
    MOVK  X28, #0x1c3b, LSL #16
    MOVK  X28, #0x93dc, LSL #32
    MOVK  X28, #0x3dd9, LSL #48
    SUB  X10, X28, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xdb6f, LSL #0
    MOVK  X5, #0x3d2a, LSL #16
    MOVK  X5, #0xeb2a, LSL #32
    MOVK  X5, #0x340a, LSL #48
    SUB  X26, X5, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x4567, LSL #0
    MOVK  X21, #0x98a1, LSL #16
    MOVK  X21, #0xf7a1, LSL #32
    MOVK  X21, #0x4800, LSL #48
    SUB  X9, X21, X4
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0xdb6f, LSL #0
    MOVK  X14, #0x3d2a, LSL #16
    MOVK  X14, #0xeb2a, LSL #32
    MOVK  X14, #0x340a, LSL #48
    SUB  X6, X14, X5
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X6
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x737f, LSL #0
    MOVK  X18, #0x9ad6, LSL #16
    MOVK  X18, #0xc7f, LSL #32
    MOVK  X18, #0xd5f8, LSL #48
    SUB  X7, X18, X7
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x7211, LSL #0
    MOVK  X18, #0xdc1d, LSL #16
    MOVK  X18, #0x426d, LSL #32
    MOVK  X18, #0xf8cd, LSL #48
    SUB  X3, X18, X8
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X29, X19, X9
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X19, X25, X10
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X3, X26, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xaecb, LSL #0
    MOVK  X5, #0x76a0, LSL #16
    MOVK  X5, #0x621a, LSL #32
    MOVK  X5, #0x9439, LSL #48
    SUB  X12, X5, X12
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x3d2c, LSL #0
    MOVK  X14, #0x9aca, LSL #16
    MOVK  X14, #0xe1d3, LSL #32
    MOVK  X14, #0x701b, LSL #48
    SUB  X19, X14, X13
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x3d2c, LSL #0
    MOVK  X3, #0x9aca, LSL #16
    MOVK  X3, #0xe1d3, LSL #32
    MOVK  X3, #0x701b, LSL #48
    SUB  X12, X3, X14
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X5, X24, X16
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0xf432, LSL #0
    MOVK  X24, #0xdae5, LSL #16
    MOVK  X24, #0x31c4, LSL #32
    MOVK  X24, #0x5e62, LSL #48
    SUB  X25, X24, X17
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x7211, LSL #0
    MOVK  X9, #0xdc1d, LSL #16
    MOVK  X9, #0x426d, LSL #32
    MOVK  X9, #0xf8cd, LSL #48
    SUB  X20, X9, X18
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X12, X5, X20
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x4567, LSL #0
    MOVK  X20, #0x98a1, LSL #16
    MOVK  X20, #0xf7a1, LSL #32
    MOVK  X20, #0x4800, LSL #48
    SUB  X19, X20, X21
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0xb56f, LSL #0
    MOVK  X20, #0xcb04, LSL #16
    MOVK  X20, #0x893d, LSL #32
    MOVK  X20, #0xa27, LSL #48
    SUB  X5, X20, X22
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xfc49, LSL #0
    MOVK  X8, #0x690a, LSL #16
    MOVK  X8, #0x7285, LSL #32
    MOVK  X8, #0x9764, LSL #48
    SUB  X25, X8, X23
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0xf432, LSL #0
    MOVK  X24, #0xdae5, LSL #16
    MOVK  X24, #0x31c4, LSL #32
    MOVK  X24, #0x5e62, LSL #48
    SUB  X6, X24, X24
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X4, X11, X25
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x8312, LSL #0
    MOVK  X29, #0xa315, LSL #16
    MOVK  X29, #0x80d0, LSL #32
    MOVK  X29, #0x181d, LSL #48
    SUB  X9, X29, X27
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X18, #0x85d9, LSL #0
    MOVK  X18, #0x1c3b, LSL #16
    MOVK  X18, #0x93dc, LSL #32
    MOVK  X18, #0x3dd9, LSL #48
    SUB  X4, X18, X28
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x8312, LSL #0
    MOVK  X27, #0xa315, LSL #16
    MOVK  X27, #0x80d0, LSL #32
    MOVK  X27, #0x181d, LSL #48
    SUB  X13, X27, X29
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D2
    MOVZ  X13, #0x0, LSL #0
    SUB  X8, X13, X26
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X17, X28, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D3
    MOVZ  X28, #0x4e95, LSL #0
    MOVK  X28, #0xc683, LSL #16
    MOVK  X28, #0xc3, LSL #32
    SUB  X17, X28, X27
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X9, X6, X2
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D4
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x95, LSL #16
    MOVK  X6, #0x83, LSL #32
    MOVK  X6, #0xc3, LSL #48
    SUB  X9, X6, X2
TaishanSimdCryptoP01_label_1380:
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D5
    MOVZ  X27, #0x0, LSL #0
    SUB  X8, X27, X13
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X23, #0x74c3, LSL #0
    MOVK  X23, #0xc155, LSL #16
    SUB  X18, X23, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D6
    MOVZ  X23, #0x4e95, LSL #0
    MOVK  X23, #0xc683, LSL #16
    MOVK  X23, #0x1309, LSL #32
    MOVK  X23, #0x98a6, LSL #48
    SUB  X18, X23, X21
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V7.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X22, X23, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D7
    MOVZ  X23, #0x4e95, LSL #0
    MOVK  X23, #0xc683, LSL #16
    MOVK  X23, #0xc3, LSL #32
    SUB  X22, X23, X6
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X28, X19, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D8
    MOVZ  X19, #0xc3, LSL #0
    MOVK  X19, #0xc3, LSL #16
    SUB  X28, X19, X16
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D9
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x74, LSL #32
    SUB  X26, X11, X24
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X23, X21, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D10
    MOVZ  X21, #0x95c3, LSL #0
    MOVK  X21, #0x83c3, LSL #16
    MOVK  X21, #0xc3c3, LSL #32
    MOVK  X21, #0xc3, LSL #48
    SUB  X23, X21, X6
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc3, LSL #16
    SUB  X4, X9, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D11
    MOVZ  X9, #0xc300, LSL #0
    MOVK  X9, #0xc69f, LSL #16
    SUB  X4, X9, X12
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D12
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7400, LSL #48
    SUB  X10, X16, X18
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X25, X14, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D13
    MOVZ  X14, #0xc300, LSL #0
    MOVK  X14, #0xc3, LSL #16
    MOVK  X14, #0xc374, LSL #32
    MOVK  X14, #0xc3, LSL #48
    SUB  X25, X14, X21
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x680c, LSL #32
    SUB  X29, X25, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X24, D14
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D16
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X13
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V17.D[1]
    MOVZ  X4, #0xc3, LSL #0
    SUB  X3, X4, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D17
    MOVZ  X4, #0x74c3, LSL #0
    MOVK  X4, #0xc3, LSL #16
    MOVK  X4, #0xc3, LSL #32
    MOVK  X4, #0xc3, LSL #48
    SUB  X3, X4, X6
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X3, X13, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X28, D18
    MOVZ  X13, #0xc3, LSL #0
    MOVK  X13, #0xc3, LSL #16
    MOVK  X13, #0xc3, LSL #32
    MOVK  X13, #0xc3, LSL #48
    SUB  X3, X13, X28
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V19.D[1]
TaishanSimdCryptoP01_label_349:
    MOVZ  X12, #0x4e95, LSL #0
    MOVK  X12, #0xc683, LSL #16
    MOVK  X12, #0x1309, LSL #32
    MOVK  X12, #0x98a6, LSL #48
    SUB  X14, X12, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D19
    MOVZ  X12, #0x0, LSL #0
    SUB  X14, X12, X23
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X5, #0xc3c3, LSL #0
    MOVK  X5, #0xc3, LSL #16
    MOVK  X5, #0x74c3, LSL #32
    SUB  X17, X5, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D20
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X12
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X11, X4, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D21
    MOVZ  X4, #0xc3, LSL #0
    SUB  X11, X4, X18
    ADD X1, X1, #1
    CBNZ   X11, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0xc3, LSL #16
    SUB  X10, X26, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D22
    MOVZ  X26, #0x0, LSL #0
    SUB  X10, X26, X27
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x74, LSL #16
    MOVK  X16, #0xc300, LSL #32
    MOVK  X16, #0xc69f, LSL #48
    SUB  X27, X16, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D23
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x74c3, LSL #48
    SUB  X27, X16, X4
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X16, X11, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D24
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xc300, LSL #32
    SUB  X16, X11, X27
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X8, X9, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D25
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc300, LSL #32
    MOVK  X9, #0xc300, LSL #48
    SUB  X8, X9, X7
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X19, #0xc300, LSL #0
    MOVK  X19, #0xc300, LSL #16
    SUB  X16, X19, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D26
    MOVZ  X19, #0xc300, LSL #0
    MOVK  X19, #0xc300, LSL #16
    SUB  X16, X19, X23
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X4, #0xc3c3, LSL #0
    MOVK  X4, #0xc3c3, LSL #32
    SUB  X6, X4, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D27
    MOVZ  X4, #0xc3c3, LSL #0
    MOVK  X4, #0x7400, LSL #16
    MOVK  X4, #0xc3c3, LSL #32
    SUB  X6, X4, X12
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X5, X6, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D28
    MOVZ  X6, #0xc3, LSL #0
    MOVK  X6, #0xc300, LSL #32
    MOVK  X6, #0xc300, LSL #48
    SUB  X5, X6, X21
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X5, X28, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D29
    MOVZ  X28, #0xc300, LSL #0
    MOVK  X28, #0xc300, LSL #32
    MOVK  X28, #0xc374, LSL #48
    SUB  X5, X28, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X2
    FMOV  D2, X5
    FMOV  V2.D[1], X5
    FMOV  D3, X20
    FMOV  V3.D[1], X8
    FMOV  D4, X3
    FMOV  V4.D[1], X7
    FMOV  D5, X29
    FMOV  V5.D[1], X3
    FMOV  D6, X23
    FMOV  V6.D[1], X24
    FMOV  D7, X25
    FMOV  V7.D[1], X4
    FMOV  D8, X10
    FMOV  V8.D[1], X26
    FMOV  D9, X2
    FMOV  V9.D[1], X18
    FMOV  D10, X26
    FMOV  V10.D[1], X4
    FMOV  D11, X28
    FMOV  V11.D[1], X8
    FMOV  D12, X29
    FMOV  V12.D[1], X24
    FMOV  D13, X5
    FMOV  V13.D[1], X13
    FMOV  D14, X19
    FMOV  V14.D[1], X22
    FMOV  D15, X21
    FMOV  V15.D[1], X11
    FMOV  D16, X18
    FMOV  V16.D[1], X5
    FMOV  D17, X11
    FMOV  V17.D[1], X23
    FMOV  D18, X8
    FMOV  V18.D[1], X11
    FMOV  D19, X29
    FMOV  V19.D[1], X12
    FMOV  D20, X24
    FMOV  V20.D[1], X5
    FMOV  D21, X6
    FMOV  V21.D[1], X12
    FMOV  D22, X7
    FMOV  V22.D[1], X10
    FMOV  D23, X12
    FMOV  V23.D[1], X12
    FMOV  D24, X10
    FMOV  V24.D[1], X5
    FMOV  D25, X20
    FMOV  V25.D[1], X19
    FMOV  D26, X2
    FMOV  V26.D[1], X5
    FMOV  D27, X5
    FMOV  V27.D[1], X5
    FMOV  D28, X22
    FMOV  V28.D[1], X26
    FMOV  D29, X7
    FMOV  V29.D[1], X22
    FMOV  D30, X7
    FMOV  V30.D[1], X11
    FMOV  D31, X21
    FMOV  V31.D[1], X5
    MOVZ  X9, #0xa, LSL #0
TaishanSimdCryptoP01_label_1512:
    ZIP2  V27.2S, V13.2S, V29.2S
    UZP1  V24.2S, V12.2S, V25.2S
    ZIP2  V13.4S, V30.4S, V5.4S
    EXT  V5.16B, V19.16B, V26.16B, #0x0
    UZP2  V0.2S, V12.2S, V31.2S
    UZP1  V5.4H, V30.4H, V5.4H
    EXT  V7.8B, V0.8B, V4.8B, #0x6
    EXT  V3.8B, V5.8B, V24.8B, #0x6
    TRN1  V3.2S, V16.2S, V8.2S
    ZIP1  V20.2D, V29.2D, V4.2D
    TRN1  V28.8H, V4.8H, V29.8H
    TRN2  V27.16B, V9.16B, V10.16B
    UZP2  V23.2S, V21.2S, V4.2S
    UZP1  V25.4S, V27.4S, V25.4S
    EXT  V20.8B, V16.8B, V28.8B, #0x0
    ZIP2  V11.4H, V26.4H, V28.4H
    ZIP2  V28.4H, V16.4H, V13.4H
    EXT  V29.8B, V24.8B, V6.8B, #0x4
    UZP2  V21.4S, V25.4S, V19.4S
    EXT  V28.16B, V20.16B, V22.16B, #0x7
    ZIP1  V20.8H, V13.8H, V18.8H
    EXT  V18.8B, V31.8B, V31.8B, #0x3
    ZIP2  V16.4S, V2.4S, V8.4S
    TRN2  V3.8B, V26.8B, V5.8B
    TRN2  V2.8H, V27.8H, V5.8H
    ZIP1  V17.4H, V4.4H, V5.4H
    EXT  V10.8B, V27.8B, V31.8B, #0x3
    EXT  V20.16B, V12.16B, V3.16B, #0x7
    UZP1  V29.2D, V11.2D, V14.2D
    EXT  V11.16B, V22.16B, V2.16B, #0xc
    EXT  V8.8B, V17.8B, V24.8B, #0x3
    TRN1  V8.4H, V27.4H, V3.4H
    UZP1  V20.4S, V26.4S, V10.4S
    TRN2  V3.4S, V25.4S, V22.4S
    ZIP2  V26.8H, V28.8H, V23.8H
    ZIP2  V1.2S, V18.2S, V11.2S
    TRN2  V23.2S, V3.2S, V0.2S
    TRN2  V5.4H, V19.4H, V29.4H
    UZP2  V1.4H, V6.4H, V18.4H
    TRN1  V16.4S, V9.4S, V27.4S
    TRN2  V22.2S, V28.2S, V16.2S
    UZP2  V16.8H, V24.8H, V11.8H
    EXT  V21.8B, V18.8B, V24.8B, #0x2
    TRN1  V21.2S, V7.2S, V21.2S
    TRN2  V26.16B, V6.16B, V10.16B
    UZP1  V18.4H, V21.4H, V8.4H
    TRN2  V18.4H, V23.4H, V11.4H
    ZIP1  V11.16B, V16.16B, V6.16B
    TRN2  V0.8B, V7.8B, V13.8B
    EXT  V28.16B, V29.16B, V20.16B, #0xe
    UZP1  V20.8B, V24.8B, V11.8B
    EXT  V9.16B, V7.16B, V2.16B, #0xf
    TRN1  V7.16B, V31.16B, V31.16B
    UZP2  V29.8B, V19.8B, V25.8B
    ZIP1  V5.4S, V26.4S, V20.4S
    EXT  V18.16B, V26.16B, V4.16B, #0x5
    TRN2  V10.8H, V31.8H, V12.8H
    TRN2  V4.16B, V20.16B, V28.16B
    TRN1  V15.4S, V23.4S, V29.4S
    UZP1  V9.4H, V28.4H, V31.4H
    ZIP1  V4.4H, V8.4H, V18.4H
    UZP1  V19.8H, V10.8H, V2.8H
    TRN1  V0.4H, V21.4H, V9.4H
    TRN2  V2.16B, V21.16B, V12.16B
    EXT  V4.8B, V10.8B, V15.8B, #0x0
    UZP2  V26.4S, V19.4S, V2.4S
    UZP1  V10.8H, V26.8H, V8.8H
    EXT  V12.8B, V11.8B, V15.8B, #0x7
    UZP1  V13.8H, V22.8H, V22.8H
    ZIP2  V11.8B, V13.8B, V17.8B
    EXT  V4.8B, V7.8B, V3.8B, #0x6
    TRN1  V15.8B, V0.8B, V31.8B
    EXT  V15.8B, V21.8B, V2.8B, #0x5
    UZP2  V1.8B, V12.8B, V15.8B
    ZIP1  V5.2S, V4.2S, V16.2S
    TRN2  V24.2S, V10.2S, V16.2S
    EXT  V13.8B, V9.8B, V30.8B, #0x0
    EXT  V27.8B, V9.8B, V3.8B, #0x0
    ZIP1  V21.4S, V21.4S, V9.4S
    EXT  V11.16B, V13.16B, V0.16B, #0x7
    EXT  V9.8B, V27.8B, V3.8B, #0x3
    EXT  V31.16B, V3.16B, V16.16B, #0x5
    ZIP1  V9.16B, V26.16B, V13.16B
    TRN1  V2.8B, V1.8B, V22.8B
    UZP2  V8.16B, V24.16B, V11.16B
    UZP1  V23.8B, V28.8B, V27.8B
    UZP2  V20.4S, V9.4S, V8.4S
    EXT  V0.16B, V13.16B, V28.16B, #0x7
    ZIP1  V21.2S, V23.2S, V20.2S
    TRN2  V28.8H, V15.8H, V31.8H
    UZP2  V29.8B, V27.8B, V25.8B
    ZIP1  V27.2D, V13.2D, V19.2D
    TRN1  V23.8H, V28.8H, V0.8H
    EXT  V24.8B, V30.8B, V18.8B, #0x7
    ZIP1  V25.8H, V31.8H, V21.8H
    EXT  V7.16B, V11.16B, V11.16B, #0x9
    UZP2  V19.8B, V9.8B, V1.8B
    EXT  V0.16B, V13.16B, V4.16B, #0xc
    EXT  V9.8B, V29.8B, V26.8B, #0x2
    TRN2  V10.8B, V22.8B, V10.8B
    TRN2  V12.4S, V26.4S, V1.4S
    UZP2  V22.4S, V22.4S, V20.4S
    EXT  V19.16B, V20.16B, V29.16B, #0x4
    TRN2  V19.8B, V19.8B, V1.8B
    TRN1  V19.4S, V16.4S, V3.4S
    UZP1  V26.4H, V11.4H, V25.4H
    TRN1  V11.4H, V19.4H, V30.4H
    UZP1  V12.16B, V12.16B, V20.16B
TaishanSimdCryptoP01_label_819:
    EXT  V12.16B, V11.16B, V23.16B, #0x1
    ZIP1  V26.4S, V30.4S, V5.4S
    UZP1  V12.4S, V10.4S, V0.4S
    UZP1  V20.16B, V3.16B, V25.16B
    EXT  V16.8B, V23.8B, V11.8B, #0x2
    ZIP1  V16.2S, V7.2S, V7.2S
    ZIP2  V18.16B, V28.16B, V6.16B
    ZIP2  V12.8B, V16.8B, V22.8B
    UZP2  V3.2S, V5.2S, V14.2S
    EXT  V20.8B, V22.8B, V29.8B, #0x0
    ZIP2  V0.16B, V1.16B, V22.16B
    ZIP2  V26.8H, V18.8H, V31.8H
    UZP1  V9.2S, V18.2S, V16.2S
    TRN2  V24.4S, V29.4S, V31.4S
    ZIP1  V21.2S, V30.2S, V25.2S
    ZIP2  V29.8B, V11.8B, V20.8B
    ZIP2  V12.2D, V4.2D, V20.2D
    UZP1  V3.4H, V24.4H, V15.4H
    UZP1  V16.8H, V0.8H, V23.8H
    TRN2  V20.8H, V24.8H, V20.8H
    TRN1  V20.16B, V11.16B, V23.16B
    TRN2  V13.4S, V19.4S, V30.4S
    TRN2  V18.2D, V30.2D, V9.2D
    EXT  V18.16B, V6.16B, V27.16B, #0x5
    TRN2  V13.2D, V18.2D, V15.2D
    TRN2  V26.4H, V6.4H, V26.4H
    TRN1  V16.4H, V31.4H, V13.4H
    EXT  V24.16B, V3.16B, V14.16B, #0x9
    UZP1  V5.2S, V26.2S, V25.2S
    ZIP1  V3.4S, V21.4S, V26.4S
    TRN2  V10.8H, V9.8H, V31.8H
    EXT  V16.8B, V27.8B, V1.8B, #0x1
    TRN2  V27.4S, V3.4S, V3.4S
    TRN1  V27.2D, V17.2D, V20.2D
    EXT  V11.8B, V16.8B, V4.8B, #0x6
    EXT  V3.16B, V27.16B, V9.16B, #0x8
    UZP1  V19.2S, V11.2S, V7.2S
    EXT  V19.16B, V24.16B, V14.16B, #0x3
    TRN2  V1.8B, V9.8B, V22.8B
    ZIP2  V6.16B, V5.16B, V20.16B
    EXT  V5.16B, V21.16B, V10.16B, #0x3
    EXT  V17.16B, V29.16B, V28.16B, #0x9
    TRN1  V22.2D, V7.2D, V18.2D
    TRN2  V12.16B, V1.16B, V20.16B
    UZP2  V3.4S, V23.4S, V5.4S
    ZIP2  V25.2S, V21.2S, V3.2S
    EXT  V24.16B, V22.16B, V28.16B, #0x3
    UZP2  V10.16B, V28.16B, V20.16B
    UZP1  V28.16B, V6.16B, V28.16B
    ZIP2  V4.2D, V24.2D, V0.2D
    EXT  V31.8B, V30.8B, V31.8B, #0x6
    UZP1  V27.8H, V19.8H, V5.8H
    ZIP2  V12.4S, V29.4S, V17.4S
    UZP2  V10.4H, V28.4H, V9.4H
    ZIP1  V12.8H, V12.8H, V20.8H
    ZIP2  V24.16B, V18.16B, V15.16B
    TRN1  V10.4S, V0.4S, V9.4S
    UZP1  V27.16B, V6.16B, V12.16B
    UZP1  V19.4S, V29.4S, V15.4S
    ZIP2  V10.16B, V25.16B, V3.16B
    EXT  V14.16B, V31.16B, V12.16B, #0xd
    UZP2  V12.2D, V18.2D, V12.2D
    UZP2  V4.8B, V0.8B, V20.8B
    UZP2  V6.2D, V22.2D, V4.2D
    UZP2  V30.2S, V0.2S, V4.2S
    TRN2  V29.2S, V10.2S, V24.2S
    TRN1  V27.4H, V16.4H, V26.4H
    UZP1  V4.8B, V19.8B, V17.8B
    ZIP1  V21.8H, V26.8H, V18.8H
    EXT  V12.8B, V25.8B, V21.8B, #0x1
    TRN1  V30.8H, V13.8H, V4.8H
    EXT  V8.16B, V27.16B, V21.16B, #0x3
    EXT  V19.8B, V20.8B, V31.8B, #0x7
    EXT  V12.16B, V19.16B, V21.16B, #0xe
    ZIP1  V24.8H, V30.8H, V5.8H
    UZP2  V13.4S, V17.4S, V29.4S
    UZP1  V6.4S, V0.4S, V31.4S
    ZIP1  V24.8B, V3.8B, V4.8B
    TRN1  V0.4S, V18.4S, V20.4S
    UZP2  V19.4S, V22.4S, V15.4S
    UZP2  V8.8H, V9.8H, V13.8H
    UZP2  V8.2D, V14.2D, V11.2D
    TRN1  V18.4H, V28.4H, V26.4H
    TRN2  V27.4H, V21.4H, V16.4H
    EXT  V25.16B, V27.16B, V26.16B, #0x2
    ZIP1  V29.4S, V12.4S, V21.4S
    TRN1  V12.8H, V5.8H, V8.8H
    EXT  V12.8B, V22.8B, V12.8B, #0x1
    TRN1  V19.8H, V22.8H, V26.8H
    EXT  V5.16B, V30.16B, V4.16B, #0xa
    UZP1  V23.2S, V21.2S, V5.2S
    EXT  V11.8B, V17.8B, V12.8B, #0x0
    SUBS  X9, X9, #0x1
    B.NE  TaishanSimdCryptoP01_label_1512
    MOVZ  X24, #0x0, LSL #0
    SUB  X18, X24, X2
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X26, X11, X3
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X4
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X21, X14, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X6
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X27, X29, X7
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X9
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X29, X11, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X28, X27, X11
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X5, X10, X12
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X2, X6, X13
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X14
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X27, X6, X16
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X17
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X25, X3, X18
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X7, X20, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X5, X13, X20
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X14, X26, X22
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    SUB  X12, X19, X23
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X23, X9, X24
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X25
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X26
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X27
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X28
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X9, X4, X29
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D2
    MOVZ  X22, #0x0, LSL #0
    SUB  X21, X22, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D3
    MOVZ  X11, #0x0, LSL #0
    SUB  X8, X11, X2
    ADD X1, X1, #1
    CBNZ   X8, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D4
    MOVZ  X16, #0x0, LSL #0
    SUB  X9, X16, X17
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X11, D5
    MOVZ  X16, #0x0, LSL #0
    SUB  X3, X16, X11
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D6
    MOVZ  X27, #0x0, LSL #0
    SUB  X4, X27, X8
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D7
    MOVZ  X16, #0x0, LSL #0
    SUB  X10, X16, X2
    ADD X1, X1, #1
    CBNZ   X10, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V8.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D8
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X25
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X6, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X6, D9
    MOVZ  X22, #0x0, LSL #0
    SUB  X4, X22, X6
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X17, D10
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X17
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D11
    MOVZ  X2, #0x0, LSL #0
    SUB  X6, X2, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X4, D12
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X4
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D13
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X18
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X13, D14
    MOVZ  X7, #0x0, LSL #0
    SUB  X27, X7, X13
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D16
    MOVZ  X29, #0x0, LSL #0
    SUB  X26, X29, X12
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V17.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D17
    MOVZ  X16, #0x0, LSL #0
    SUB  X28, X16, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X21, X12, X8
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D19
    MOVZ  X4, #0x0, LSL #0
    SUB  X14, X4, X29
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D20
    MOVZ  X11, #0x0, LSL #0
    SUB  X22, X11, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X12, D21
    MOVZ  X6, #0x0, LSL #0
    SUB  X22, X6, X12
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V22.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D22
    MOVZ  X23, #0x0, LSL #0
    SUB  X7, X23, X19
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D23
    MOVZ  X18, #0x0, LSL #0
    SUB  X17, X18, X9
    ADD X1, X1, #1
    CBNZ   X17, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D24
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X23
    ADD X1, X1, #1
    CBNZ   X20, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D25
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X23
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D26
    MOVZ  X4, #0x0, LSL #0
    SUB  X6, X4, X27
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X2, D27
    MOVZ  X23, #0x0, LSL #0
    SUB  X19, X23, X2
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D28
    MOVZ  X12, #0x0, LSL #0
    SUB  X9, X12, X23
    ADD X1, X1, #1
    CBNZ   X9, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D29
    MOVZ  X2, #0x0, LSL #0
    SUB  X28, X2, X18
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
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
    FMOV  D0, X21
    FMOV  V0.D[1], X20
    FMOV  D1, X12
    FMOV  V1.D[1], X19
    FMOV  D2, X26
    FMOV  V2.D[1], X11
    FMOV  D3, X7
    FMOV  V3.D[1], X21
    FMOV  D4, X29
    FMOV  V4.D[1], X21
    FMOV  D5, X12
    FMOV  V5.D[1], X12
    FMOV  D6, X8
    FMOV  V6.D[1], X9
    FMOV  D7, X26
    FMOV  V7.D[1], X28
    FMOV  D8, X17
    FMOV  V8.D[1], X21
    FMOV  D9, X19
    FMOV  V9.D[1], X24
    FMOV  D10, X7
    FMOV  V10.D[1], X14
    FMOV  D11, X27
    FMOV  V11.D[1], X22
    FMOV  D12, X21
    FMOV  V12.D[1], X5
    FMOV  D13, X2
    FMOV  V13.D[1], X16
    FMOV  D14, X7
    FMOV  V14.D[1], X9
    FMOV  D15, X5
    FMOV  V15.D[1], X18
    FMOV  D16, X8
    FMOV  V16.D[1], X2
    FMOV  D17, X19
    FMOV  V17.D[1], X22
    FMOV  D18, X21
    FMOV  V18.D[1], X20
    FMOV  D19, X4
    FMOV  V19.D[1], X3
    FMOV  D20, X8
    FMOV  V20.D[1], X17
    FMOV  D21, X9
    FMOV  V21.D[1], X25
    FMOV  D22, X7
    FMOV  V22.D[1], X19
    FMOV  D23, X22
    FMOV  V23.D[1], X10
    FMOV  D24, X24
    FMOV  V24.D[1], X18
    FMOV  D25, X13
    FMOV  V25.D[1], X23
    FMOV  D26, X18
    FMOV  V26.D[1], X13
    FMOV  D27, X4
    FMOV  V27.D[1], X13
    FMOV  D28, X10
    FMOV  V28.D[1], X4
    FMOV  D29, X4
    FMOV  V29.D[1], X8
    FMOV  D30, X18
    FMOV  V30.D[1], X18
    FMOV  D31, X5
    FMOV  V31.D[1], X10
    MOVZ  X26, #0xf, LSL #0
TaishanSimdCryptoP01_label_1586:
    ZIP2  V6.4S, V23.4S, V7.4S
    EXT  V10.16B, V12.16B, V5.16B, #0x5
    UZP1  V7.8B, V8.8B, V12.8B
    EXT  V11.16B, V19.16B, V1.16B, #0x5
    ZIP1  V6.8B, V26.8B, V5.8B
    EXT  V5.8B, V18.8B, V11.8B, #0x7
    EXT  V7.16B, V6.16B, V18.16B, #0x5
    ZIP1  V13.4S, V16.4S, V19.4S
    EXT  V30.16B, V29.16B, V23.16B, #0xa
    UZP2  V4.4S, V27.4S, V16.4S
    UZP2  V1.16B, V21.16B, V30.16B
    EXT  V31.16B, V14.16B, V20.16B, #0x3
    EXT  V29.8B, V22.8B, V28.8B, #0x1
    ZIP2  V4.8H, V20.8H, V29.8H
    UZP1  V13.8B, V21.8B, V12.8B
    ZIP1  V13.16B, V8.16B, V30.16B
    ZIP1  V24.4S, V5.4S, V2.4S
    UZP1  V6.16B, V14.16B, V4.16B
    ZIP2  V10.4H, V31.4H, V6.4H
    UZP1  V22.4S, V5.4S, V11.4S
    EXT  V4.16B, V17.16B, V16.16B, #0x0
    UZP2  V12.16B, V24.16B, V13.16B
    EXT  V19.16B, V1.16B, V22.16B, #0xe
    TRN1  V1.16B, V11.16B, V3.16B
    EXT  V13.16B, V20.16B, V27.16B, #0x8
    ZIP1  V24.16B, V14.16B, V8.16B
    TRN1  V28.16B, V1.16B, V3.16B
    TRN1  V31.8B, V31.8B, V15.8B
    TRN2  V23.2D, V9.2D, V26.2D
    EXT  V26.8B, V1.8B, V28.8B, #0x4
    ZIP2  V22.2D, V19.2D, V24.2D
    TRN1  V28.2S, V17.2S, V8.2S
    EXT  V1.8B, V5.8B, V4.8B, #0x2
    ZIP2  V20.8B, V24.8B, V6.8B
    UZP2  V19.8H, V4.8H, V13.8H
    EXT  V16.8B, V3.8B, V5.8B, #0x3
    TRN2  V10.16B, V2.16B, V17.16B
    EXT  V16.16B, V28.16B, V14.16B, #0x6
    UZP2  V27.8H, V31.8H, V1.8H
    ZIP2  V4.8B, V20.8B, V22.8B
    ZIP1  V12.16B, V29.16B, V6.16B
    TRN2  V29.16B, V8.16B, V12.16B
    EXT  V5.8B, V1.8B, V23.8B, #0x2
    EXT  V31.8B, V0.8B, V31.8B, #0x4
    EXT  V11.16B, V24.16B, V27.16B, #0xf
    TRN2  V26.16B, V22.16B, V30.16B
    UZP1  V17.8B, V2.8B, V7.8B
    ZIP1  V13.4S, V17.4S, V6.4S
    ZIP1  V26.8B, V9.8B, V7.8B
    EXT  V4.16B, V13.16B, V16.16B, #0x2
    ZIP2  V15.2S, V8.2S, V20.2S
    EXT  V11.8B, V4.8B, V12.8B, #0x5
    EXT  V31.8B, V31.8B, V21.8B, #0x1
    UZP2  V15.8H, V21.8H, V27.8H
    TRN1  V15.2D, V15.2D, V11.2D
    ZIP1  V9.8B, V10.8B, V16.8B
    ZIP2  V29.8B, V3.8B, V26.8B
    TRN2  V26.2S, V14.2S, V8.2S
    UZP1  V2.4H, V31.4H, V26.4H
    UZP1  V15.16B, V31.16B, V12.16B
    ZIP1  V3.16B, V20.16B, V26.16B
    TRN1  V5.4H, V18.4H, V25.4H
    EXT  V17.16B, V3.16B, V9.16B, #0x7
    ZIP1  V13.16B, V2.16B, V27.16B
    TRN1  V29.4S, V12.4S, V17.4S
    ZIP2  V20.4S, V4.4S, V5.4S
    EXT  V9.16B, V27.16B, V16.16B, #0x5
    ZIP2  V0.16B, V11.16B, V1.16B
    TRN1  V13.16B, V11.16B, V5.16B
    UZP2  V31.16B, V16.16B, V28.16B
    EXT  V28.16B, V14.16B, V8.16B, #0x8
    UZP2  V27.2S, V10.2S, V31.2S
    ZIP2  V21.16B, V15.16B, V9.16B
    UZP2  V10.16B, V19.16B, V29.16B
    ZIP2  V28.4H, V15.4H, V10.4H
    EXT  V1.16B, V2.16B, V6.16B, #0xd
    TRN2  V9.4H, V16.4H, V26.4H
    ZIP2  V11.4S, V27.4S, V10.4S
    UZP1  V13.8H, V11.8H, V0.8H
    ZIP2  V0.2D, V8.2D, V30.2D
    TRN1  V29.4H, V6.4H, V24.4H
    TRN2  V29.4H, V26.4H, V0.4H
    UZP1  V13.8H, V4.8H, V20.8H
    UZP2  V11.16B, V13.16B, V29.16B
    EXT  V11.16B, V23.16B, V18.16B, #0xe
    EXT  V5.8B, V26.8B, V0.8B, #0x6
    EXT  V24.8B, V6.8B, V5.8B, #0x0
    UZP2  V7.8H, V2.8H, V16.8H
    EXT  V10.16B, V17.16B, V14.16B, #0x6
    TRN2  V26.2S, V8.2S, V11.2S
    EXT  V14.16B, V7.16B, V6.16B, #0x9
    ZIP1  V20.16B, V23.16B, V3.16B
    EXT  V26.16B, V24.16B, V28.16B, #0xa
    ZIP1  V20.4H, V24.4H, V5.4H
    UZP1  V2.2S, V30.2S, V24.2S
    UZP1  V2.4S, V28.4S, V14.4S
    ZIP1  V2.2D, V21.2D, V27.2D
    TRN1  V18.2D, V9.2D, V8.2D
    TRN1  V3.8B, V22.8B, V17.8B
    EXT  V28.8B, V0.8B, V27.8B, #0x1
    ZIP1  V8.16B, V19.16B, V14.16B
    ZIP1  V0.16B, V13.16B, V29.16B
    ZIP1  V7.4S, V4.4S, V28.4S
    TRN1  V11.8H, V19.8H, V31.8H
    TRN2  V2.8H, V3.8H, V12.8H
    EXT  V23.16B, V6.16B, V8.16B, #0x8
    UZP1  V3.4S, V29.4S, V3.4S
    UZP2  V16.2S, V26.2S, V19.2S
    UZP1  V7.8B, V13.8B, V11.8B
    EXT  V10.8B, V9.8B, V19.8B, #0x2
    EXT  V8.8B, V26.8B, V0.8B, #0x7
    EXT  V23.8B, V7.8B, V2.8B, #0x2
    EXT  V3.8B, V27.8B, V22.8B, #0x3
    UZP1  V29.2D, V24.2D, V25.2D
    ZIP2  V11.8H, V21.8H, V12.8H
    ZIP2  V9.16B, V2.16B, V12.16B
    ZIP1  V18.2S, V23.2S, V15.2S
    UZP1  V24.2S, V11.2S, V5.2S
    UZP2  V30.2D, V5.2D, V14.2D
    ZIP2  V6.4S, V7.4S, V7.4S
    UZP2  V22.2S, V16.2S, V14.2S
    EXT  V11.16B, V8.16B, V20.16B, #0x5
    UZP1  V0.2D, V31.2D, V18.2D
    UZP2  V1.4H, V31.4H, V10.4H
    UZP1  V14.8B, V9.8B, V8.8B
    EXT  V11.16B, V22.16B, V20.16B, #0xd
    EXT  V19.16B, V7.16B, V30.16B, #0xa
    UZP2  V28.2S, V3.2S, V21.2S
    EXT  V9.8B, V15.8B, V12.8B, #0x1
    UZP1  V12.2S, V7.2S, V23.2S
    ZIP2  V14.2D, V13.2D, V26.2D
    ZIP2  V6.2D, V16.2D, V8.2D
    EXT  V12.8B, V8.8B, V23.8B, #0x6
    ZIP1  V12.2S, V7.2S, V23.2S
    ZIP2  V5.4S, V2.4S, V24.4S
    TRN2  V9.4S, V0.4S, V24.4S
    UZP2  V1.4S, V30.4S, V11.4S
    TRN1  V28.8B, V7.8B, V13.8B
    TRN1  V13.2D, V9.2D, V2.2D
    ZIP1  V20.2D, V29.2D, V4.2D
    EXT  V20.16B, V15.16B, V2.16B, #0x6
    EXT  V12.8B, V4.8B, V18.8B, #0x2
    TRN1  V26.2S, V23.2S, V6.2S
    EXT  V10.16B, V21.16B, V20.16B, #0x6
    UZP1  V20.4S, V18.4S, V10.4S
    ZIP1  V29.8H, V17.8H, V29.8H
    TRN2  V4.8H, V8.8H, V22.8H
    EXT  V0.16B, V3.16B, V23.16B, #0xd
    ZIP2  V31.8H, V7.8H, V0.8H
    ZIP1  V1.2D, V17.2D, V4.2D
    ZIP1  V14.2S, V5.2S, V4.2S
    TRN2  V24.8H, V17.8H, V14.8H
    TRN2  V22.4H, V10.4H, V15.4H
    UZP2  V14.4H, V25.4H, V5.4H
    ZIP2  V23.4H, V15.4H, V20.4H
    ZIP2  V5.4S, V7.4S, V24.4S
    ZIP2  V19.2S, V11.2S, V4.2S
    EXT  V18.8B, V21.8B, V14.8B, #0x1
    TRN2  V13.8B, V23.8B, V17.8B
    TRN2  V1.2D, V24.2D, V29.2D
    EXT  V16.16B, V15.16B, V29.16B, #0x9
    UZP2  V10.8B, V29.8B, V22.8B
    ZIP2  V31.16B, V19.16B, V4.16B
    TRN2  V19.8H, V2.8H, V13.8H
    TRN2  V31.4H, V13.4H, V0.4H
    UZP2  V4.8H, V31.8H, V8.8H
    ZIP1  V16.4S, V10.4S, V2.4S
    TRN2  V5.4H, V4.4H, V2.4H
    ZIP2  V30.2D, V27.2D, V16.2D
    EXT  V17.8B, V29.8B, V30.8B, #0x1
    UZP2  V8.16B, V5.16B, V29.16B
    EXT  V15.8B, V9.8B, V28.8B, #0x7
    EXT  V14.8B, V19.8B, V19.8B, #0x0
    ZIP1  V24.2S, V13.2S, V0.2S
    EXT  V14.16B, V12.16B, V6.16B, #0x8
    ZIP2  V30.8B, V9.8B, V26.8B
    TRN1  V13.4H, V18.4H, V25.4H
    ZIP2  V28.2D, V4.2D, V11.2D
    EXT  V23.16B, V26.16B, V31.16B, #0x4
    EXT  V17.8B, V14.8B, V28.8B, #0x7
    UZP2  V14.8B, V23.8B, V13.8B
    ZIP2  V8.8H, V26.8H, V19.8H
    EXT  V26.16B, V16.16B, V18.16B, #0x4
    TRN2  V16.4S, V30.4S, V13.4S
    TRN2  V15.16B, V21.16B, V9.16B
    ZIP2  V4.8H, V26.8H, V16.8H
    ZIP1  V14.4H, V6.4H, V22.4H
    ZIP1  V23.4H, V17.4H, V25.4H
    EXT  V4.16B, V16.16B, V12.16B, #0x5
    EXT  V10.8B, V24.8B, V13.8B, #0x1
    ZIP1  V26.8B, V10.8B, V6.8B
    UZP1  V14.2S, V27.2S, V16.2S
    TRN1  V31.8B, V13.8B, V12.8B
    TRN2  V31.2D, V7.2D, V15.2D
    EXT  V13.16B, V16.16B, V21.16B, #0xd
    ZIP1  V28.4S, V13.4S, V8.4S
    UZP1  V3.2S, V0.2S, V10.2S
    ZIP1  V14.2S, V28.2S, V1.2S
    UZP1  V22.2D, V26.2D, V7.2D
    TRN1  V7.8H, V13.8H, V17.8H
    SUBS  X26, X26, #0x1
    B.NE  TaishanSimdCryptoP01_label_1586
    MOVZ  X19, #0xffff, LSL #0
    MOVK  X19, #0xffff, LSL #16
    MOVK  X19, #0xffff, LSL #32
    MOVK  X19, #0xffff, LSL #48
    SUB  X14, X19, X2
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X24, X5, X3
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X7, X5, X4
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X21, X2, X5
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0xffff, LSL #0
    MOVK  X26, #0xffff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    SUB  X21, X26, X6
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X7
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X27, X28, X8
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X5, #0xffff, LSL #0
    MOVK  X5, #0xffff, LSL #16
    MOVK  X5, #0xffff, LSL #32
    MOVK  X5, #0xffff, LSL #48
    SUB  X7, X5, X9
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X22, X9, X10
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0xffff, LSL #0
    MOVK  X2, #0xffff, LSL #16
    MOVK  X2, #0xffff, LSL #32
    MOVK  X2, #0xffff, LSL #48
    SUB  X14, X2, X11
    ADD X1, X1, #1
    CBNZ   X14, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X19, X22, X12
    ADD X1, X1, #1
    CBNZ   X19, TaishanSimdCryptoP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X13, X27, X13
    ADD X1, X1, #1
    CBNZ   X13, TaishanSimdCryptoP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X4, X10, X14
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X2, X3, X16
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X26, #0x0, LSL #0
    SUB  X5, X26, X17
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X26, X8, X18
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    SUB  X5, X7, X19
    ADD X1, X1, #1
    CBNZ   X5, TaishanSimdCryptoP01_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X6, X23, X20
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X24, X28, X21
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X29, X22, X22
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X24, #0xffff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    SUB  X2, X24, X23
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X29, X8, X24
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    MOVZ  X17, #0xffff, LSL #0
    MOVK  X17, #0xffff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    SUB  X28, X17, X25
    ADD X1, X1, #1
    CBNZ   X28, TaishanSimdCryptoP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X26
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X24, X21, X27
    ADD X1, X1, #1
    CBNZ   X24, TaishanSimdCryptoP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X27, X2, X28
    ADD X1, X1, #1
    CBNZ   X27, TaishanSimdCryptoP01_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X26, X13, X29
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D2
    MOVZ  X16, #0x0, LSL #0
    SUB  X12, X16, X19
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D3
    MOVZ  X19, #0x0, LSL #0
    SUB  X23, X19, X7
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X25, X5, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D4
    MOVZ  X5, #0xff00, LSL #0
    MOVK  X5, #0xff, LSL #16
    SUB  X25, X5, X27
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D5
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X26
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D6
    MOVZ  X26, #0x0, LSL #0
    SUB  X12, X26, X5
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X9, D7
    MOVZ  X19, #0x0, LSL #0
    SUB  X3, X19, X9
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D8
    MOVZ  X6, #0x0, LSL #0
    SUB  X18, X6, X7
    ADD X1, X1, #1
    CBNZ   X18, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D9
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD X1, X1, #1
    CBNZ   X7, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D10
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X16
    ADD X1, X1, #1
    CBNZ   X21, TaishanSimdCryptoP01_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X7, D11
    MOVZ  X18, #0x0, LSL #0
    SUB  X26, X18, X7
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X25, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X25, D12
    MOVZ  X20, #0x0, LSL #0
    SUB  X26, X20, X25
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X14, D13
    MOVZ  X10, #0x0, LSL #0
    SUB  X6, X10, X14
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D14
    MOVZ  X4, #0x0, LSL #0
    SUB  X16, X4, X18
    ADD X1, X1, #1
    CBNZ   X16, TaishanSimdCryptoP01_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X2, X27, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X26, D16
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xffff, LSL #48
    SUB  X2, X27, X26
    ADD X1, X1, #1
    CBNZ   X2, TaishanSimdCryptoP01_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X5, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X22, X2, X5
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X29, X5, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D18
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xff00, LSL #48
    SUB  X29, X5, X10
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D19
    MOVZ  X14, #0x0, LSL #0
    SUB  X22, X14, X21
    ADD X1, X1, #1
    CBNZ   X22, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D20
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X19
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X10, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X25, X29, X10
    ADD X1, X1, #1
    CBNZ   X25, TaishanSimdCryptoP01_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X18, D22
    MOVZ  X16, #0x0, LSL #0
    SUB  X6, X16, X18
    ADD X1, X1, #1
    CBNZ   X6, TaishanSimdCryptoP01_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X12, X22, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X27, D23
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #48
    SUB  X12, X22, X27
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X29, D24
    MOVZ  X9, #0x0, LSL #0
    SUB  X12, X9, X29
    ADD X1, X1, #1
    CBNZ   X12, TaishanSimdCryptoP01_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X23, X7, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X16, D25
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    SUB  X23, X7, X16
    ADD X1, X1, #1
    CBNZ   X23, TaishanSimdCryptoP01_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X21, D26
    MOVZ  X19, #0x0, LSL #0
    SUB  X4, X19, X21
    ADD X1, X1, #1
    CBNZ   X4, TaishanSimdCryptoP01_TestFail
    FMOV  X19, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X19, D27
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X19
    ADD X1, X1, #1
    CBNZ   X3, TaishanSimdCryptoP01_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X23, D28
    MOVZ  X7, #0x0, LSL #0
    SUB  X29, X7, X23
    ADD X1, X1, #1
    CBNZ   X29, TaishanSimdCryptoP01_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail
    FMOV  X8, D29
    MOVZ  X24, #0x0, LSL #0
    SUB  X26, X24, X8
    ADD X1, X1, #1
    CBNZ   X26, TaishanSimdCryptoP01_TestFail

TaishanSimdCryptoP01_TestEnd:
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
TaishanSimdCryptoP01_TestFail:
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