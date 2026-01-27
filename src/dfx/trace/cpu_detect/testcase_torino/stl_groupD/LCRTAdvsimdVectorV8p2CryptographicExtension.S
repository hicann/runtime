.global LCRTAdvsimdVectorV8p2CryptographicExtension

.text
.p2align 4

LCRTAdvsimdVectorV8p2CryptographicExtension:

LCRTAdvsimdVectorV8p2CryptographicExtension_TestBegin:
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
    SUB  SP, SP, #0x10
    STR  P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P1, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P2, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P3, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P4, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P5, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P6, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P7, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P8, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P9, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P10, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P11, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P12, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P13, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P14, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P15, [SP, #0, MUL VL]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    STR  X15, [X0, #0]
    LDR  P0, [X0, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z0.D, Z1.D, Z2.D, Z3.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z4.D, Z5.D, Z6.D, Z7.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z8.D, Z9.D, Z10.D, Z11.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z12.D, Z13.D, Z14.D, Z15.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z16.D, Z17.D, Z18.D, Z19.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z20.D, Z21.D, Z22.D, Z23.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z24.D, Z25.D, Z26.D, Z27.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z28.D, Z29.D, Z30.D, Z31.D }, P0, [SP, #0, MUL VL]
    MRS  X2, FPCR
    MRS  X3, FPSR
    MRS  X4, NZCV
    STP  X2, X3, [SP, #-16]!
    STP  X4, X2, [SP, #-16]!
    MOVZ  X2, #0x7547, LSL #0
    MOVK  X2, #0x1590, LSL #16
    MOVK  X2, #0x4272, LSL #32
    MOVK  X2, #0x4249, LSL #48
    MOVZ  X3, #0xeda2, LSL #0
    MOVK  X3, #0x7248, LSL #16
    MOVK  X3, #0x7966, LSL #32
    MOVK  X3, #0x90f2, LSL #48
    MOVZ  X4, #0x7fdd, LSL #0
    MOVK  X4, #0x7075, LSL #16
    MOVK  X4, #0xe752, LSL #32
    MOVK  X4, #0x21a1, LSL #48
    MOVZ  X5, #0x5218, LSL #0
    MOVK  X5, #0x7765, LSL #16
    MOVK  X5, #0x3a9b, LSL #32
    MOVK  X5, #0x367b, LSL #48
    MOVZ  X6, #0x82f5, LSL #0
    MOVK  X6, #0x7a1a, LSL #16
    MOVK  X6, #0x18c0, LSL #32
    MOVK  X6, #0x9664, LSL #48
    MOVZ  X7, #0x1a21, LSL #0
    MOVK  X7, #0xc760, LSL #16
    MOVK  X7, #0x3afb, LSL #32
    MOVK  X7, #0xd7bd, LSL #48
    MOVZ  X8, #0x97de, LSL #0
    MOVK  X8, #0x4d14, LSL #16
    MOVK  X8, #0xf2d6, LSL #32
    MOVK  X8, #0x60eb, LSL #48
    MOVZ  X9, #0x1dc3, LSL #0
    MOVK  X9, #0xcf04, LSL #16
    MOVK  X9, #0xf3d7, LSL #32
    MOVK  X9, #0x7af2, LSL #48
    MOVZ  X10, #0xe329, LSL #0
    MOVK  X10, #0x2abc, LSL #16
    MOVK  X10, #0x5a4f, LSL #32
    MOVK  X10, #0x4c51, LSL #48
    MOVZ  X11, #0xb934, LSL #0
    MOVK  X11, #0x6949, LSL #16
    MOVK  X11, #0x2535, LSL #32
    MOVK  X11, #0x6c12, LSL #48
    MOVZ  X12, #0x8ad5, LSL #0
    MOVK  X12, #0x3424, LSL #16
    MOVK  X12, #0xda00, LSL #32
    MOVK  X12, #0x271b, LSL #48
    MOVZ  X13, #0xb68d, LSL #0
    MOVK  X13, #0xc61e, LSL #16
    MOVK  X13, #0x6fc3, LSL #32
    MOVK  X13, #0xf27c, LSL #48
    MOVZ  X14, #0x2e43, LSL #0
    MOVK  X14, #0x3f69, LSL #16
    MOVK  X14, #0x42aa, LSL #32
    MOVK  X14, #0xfc78, LSL #48
    MOVZ  X15, #0xa215, LSL #0
    MOVK  X15, #0x6d65, LSL #16
    MOVK  X15, #0xf3c4, LSL #32
    MOVK  X15, #0xcf6d, LSL #48
    MOVZ  X16, #0xff31, LSL #0
    MOVK  X16, #0xc631, LSL #16
    MOVK  X16, #0xf631, LSL #32
    MOVK  X16, #0x666f, LSL #48
    MOVZ  X17, #0x758e, LSL #0
    MOVK  X17, #0x2e1d, LSL #16
    MOVK  X17, #0x615a, LSL #32
    MOVK  X17, #0xd58d, LSL #48
    MOVZ  X18, #0x89c4, LSL #0
    MOVK  X18, #0x195a, LSL #16
    MOVK  X18, #0xdb2f, LSL #32
    MOVK  X18, #0x87cb, LSL #48
    MOVZ  X19, #0x4a48, LSL #0
    MOVK  X19, #0x955f, LSL #16
    MOVK  X19, #0x790e, LSL #32
    MOVK  X19, #0x2c08, LSL #48
    MOVZ  X20, #0x6989, LSL #0
    MOVK  X20, #0xedac, LSL #16
    MOVK  X20, #0x75a3, LSL #32
    MOVK  X20, #0x2d03, LSL #48
    MOVZ  X21, #0xaca5, LSL #0
    MOVK  X21, #0xee01, LSL #16
    MOVK  X21, #0x3c3f, LSL #32
    MOVK  X21, #0x57a6, LSL #48
    MOVZ  X22, #0xd514, LSL #0
    MOVK  X22, #0xe083, LSL #16
    MOVK  X22, #0x6123, LSL #32
    MOVK  X22, #0x6f2c, LSL #48
    MOVZ  X23, #0x5c3f, LSL #0
    MOVK  X23, #0x398e, LSL #16
    MOVK  X23, #0x8ad9, LSL #32
    MOVK  X23, #0x2b8b, LSL #48
    MOVZ  X28, #0x3883, LSL #0
    MOVK  X28, #0x19b2, LSL #16
    MOVK  X28, #0x1b9a, LSL #32
    MOVK  X28, #0xb0e9, LSL #48
    MOVZ  X10, #0x4a2a, LSL #0
    MOVK  X10, #0x8f64, LSL #16
    MOVK  X10, #0xa3b4, LSL #32
    MOVK  X10, #0xe7da, LSL #48
    MSR  FPCR, X10
    MRS  X22, FPCR
    MOVZ  X14, #0x60ff, LSL #0
    MOVK  X14, #0xffff, LSL #16
    MOVK  X14, #0xffff, LSL #32
    MOVK  X14, #0xffff, LSL #48
    AND  X22, X22, X14
    MOVZ  X14, #0x0, LSL #0
    ORR  X22, X22, X14
    MSR  FPCR, X22
    ISB  SY
    MOVZ  X10, #0x3b7d, LSL #0
    MOVK  X10, #0x3863, LSL #16
    MOVK  X10, #0x6e6e, LSL #32
    MOVK  X10, #0xc978, LSL #48
    MSR  FPSR, X10
    MRS  X2, FPSR
    MOVZ  X3, #0xff60, LSL #0
    MOVK  X3, #0x7ff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X2, X2, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X2, X2, X3
    MSR  FPSR, X2
    ISB  SY
    ANDS  X2, X2, #0xfffffff0000
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x38b4, LSL #0
    MOVK  X2, #0x6bf8, LSL #16
    MOVK  X2, #0xc9b6, LSL #32
    MOVK  X2, #0x8d07, LSL #48
    MOVZ  X3, #0x66f8, LSL #0
    MOVK  X3, #0x3d27, LSL #16
    MOVK  X3, #0x7698, LSL #32
    MOVK  X3, #0xaa33, LSL #48
    MOVZ  X4, #0x627a, LSL #0
    MOVK  X4, #0x24c3, LSL #16
    MOVK  X4, #0xb120, LSL #32
    MOVK  X4, #0xd8d8, LSL #48
    MOVZ  X5, #0xddae, LSL #0
    MOVK  X5, #0x174a, LSL #16
    MOVK  X5, #0x8ec2, LSL #32
    MOVK  X5, #0x3374, LSL #48
    MOVZ  X6, #0x8772, LSL #0
    MOVK  X6, #0x2aa8, LSL #16
    MOVK  X6, #0x291e, LSL #32
    MOVK  X6, #0x508c, LSL #48
    MOVZ  X7, #0xd04f, LSL #0
    MOVK  X7, #0x6372, LSL #16
    MOVK  X7, #0x57f4, LSL #32
    MOVK  X7, #0xef25, LSL #48
    MOVZ  X8, #0x11f5, LSL #0
    MOVK  X8, #0xb249, LSL #16
    MOVK  X8, #0x9c12, LSL #32
    MOVK  X8, #0x33da, LSL #48
    MOVZ  X9, #0xac3f, LSL #0
    MOVK  X9, #0xc78f, LSL #16
    MOVK  X9, #0x941d, LSL #32
    MOVK  X9, #0x684a, LSL #48
    MOVZ  X10, #0x19f4, LSL #0
    MOVK  X10, #0x1e1b, LSL #16
    MOVK  X10, #0xe649, LSL #32
    MOVK  X10, #0x45b9, LSL #48
    MOVZ  X11, #0x9b3, LSL #0
    MOVK  X11, #0xfe5, LSL #16
    MOVK  X11, #0xca31, LSL #32
    MOVK  X11, #0xf6f5, LSL #48
    MOVZ  X12, #0x6c6f, LSL #0
    MOVK  X12, #0x9658, LSL #16
    MOVK  X12, #0xcb49, LSL #32
    MOVK  X12, #0xd695, LSL #48
    MOVZ  X13, #0x20b7, LSL #0
    MOVK  X13, #0x6b5e, LSL #16
    MOVK  X13, #0xa6a4, LSL #32
    MOVK  X13, #0x7496, LSL #48
    MOVZ  X14, #0x2593, LSL #0
    MOVK  X14, #0xe2f7, LSL #16
    MOVK  X14, #0x4d3f, LSL #32
    MOVK  X14, #0x408a, LSL #48
    MOVZ  X15, #0xe9a9, LSL #0
    MOVK  X15, #0x23b4, LSL #16
    MOVK  X15, #0x164b, LSL #32
    MOVK  X15, #0xc07a, LSL #48
    MOVZ  X16, #0xbcc, LSL #0
    MOVK  X16, #0x8df3, LSL #16
    MOVK  X16, #0xd57c, LSL #32
    MOVK  X16, #0x7f6, LSL #48
    MOVZ  X17, #0x14a0, LSL #0
    MOVK  X17, #0x5897, LSL #16
    MOVK  X17, #0xabef, LSL #32
    MOVK  X17, #0xc70b, LSL #48
    MOVZ  X18, #0x1e86, LSL #0
    MOVK  X18, #0x54f3, LSL #16
    MOVK  X18, #0xbf52, LSL #32
    MOVK  X18, #0x8f3, LSL #48
    MOVZ  X19, #0xa1d2, LSL #0
    MOVK  X19, #0x3066, LSL #16
    MOVK  X19, #0xb0e0, LSL #32
    MOVK  X19, #0xf869, LSL #48
    MOVZ  X20, #0x9288, LSL #0
    MOVK  X20, #0x5222, LSL #16
    MOVK  X20, #0xcf83, LSL #32
    MOVK  X20, #0x4e76, LSL #48
    MOVZ  X21, #0x74d5, LSL #0
    MOVK  X21, #0xbc6e, LSL #16
    MOVK  X21, #0x438d, LSL #32
    MOVK  X21, #0x7a51, LSL #48
    MOVZ  X22, #0x9668, LSL #0
    MOVK  X22, #0x7ca8, LSL #16
    MOVK  X22, #0xf3df, LSL #32
    MOVK  X22, #0x54e4, LSL #48
    MOVZ  X23, #0xd332, LSL #0
    MOVK  X23, #0x1392, LSL #16
    MOVK  X23, #0x453c, LSL #32
    MOVK  X23, #0xf1a5, LSL #48
    MOVZ  X28, #0x4acc, LSL #0
    MOVK  X28, #0xb3ef, LSL #16
    MOVK  X28, #0xd35a, LSL #32
    MOVK  X28, #0x1a71, LSL #48
    FMOV  D0, X3
    FMOV  V0.D[1], X28
    FMOV  D1, X23
    FMOV  V1.D[1], X21
    FMOV  D2, X22
    FMOV  V2.D[1], X8
    FMOV  D3, X20
    FMOV  V3.D[1], X3
    FMOV  D4, X8
    FMOV  V4.D[1], X23
    FMOV  D5, X11
    FMOV  V5.D[1], X23
    FMOV  D6, X11
    FMOV  V6.D[1], X28
    FMOV  D7, X3
    FMOV  V7.D[1], X8
    FMOV  D8, X7
    FMOV  V8.D[1], X17
    FMOV  D9, X22
    FMOV  V9.D[1], X28
    FMOV  D10, X16
    FMOV  V10.D[1], X5
    FMOV  D11, X20
    FMOV  V11.D[1], X2
    FMOV  D12, X19
    FMOV  V12.D[1], X22
    FMOV  D13, X12
    FMOV  V13.D[1], X12
    FMOV  D14, X7
    FMOV  V14.D[1], X18
    FMOV  D15, X19
    FMOV  V15.D[1], X23
    FMOV  D16, X10
    FMOV  V16.D[1], X3
    FMOV  D17, X8
    FMOV  V17.D[1], X17
    FMOV  D18, X14
    FMOV  V18.D[1], X10
    FMOV  D19, X7
    FMOV  V19.D[1], X13
    FMOV  D20, X8
    FMOV  V20.D[1], X4
    FMOV  D21, X7
    FMOV  V21.D[1], X28
    FMOV  D22, X23
    FMOV  V22.D[1], X28
    FMOV  D23, X21
    FMOV  V23.D[1], X12
    FMOV  D24, X12
    FMOV  V24.D[1], X17
    FMOV  D25, X19
    FMOV  V25.D[1], X9
    FMOV  D26, X8
    FMOV  V26.D[1], X6
    FMOV  D27, X11
    FMOV  V27.D[1], X14
    FMOV  D28, X4
    FMOV  V28.D[1], X23
    FMOV  D29, X2
    FMOV  V29.D[1], X4
    FMOV  D30, X23
    FMOV  V30.D[1], X17
    FMOV  D31, X2
    FMOV  V31.D[1], X10
    BCAX V13.16B, V24.16B, V27.16B, V30.16B
    BCAX V24.16B, V25.16B, V18.16B, V20.16B
    BCAX V11.16B, V13.16B, V31.16B, V31.16B
    BCAX V27.16B, V24.16B, V11.16B, V24.16B
    BCAX V31.16B, V29.16B, V2.16B, V6.16B
    BCAX V2.16B, V20.16B, V23.16B, V27.16B
    BCAX V31.16B, V31.16B, V20.16B, V6.16B
    BCAX V11.16B, V31.16B, V25.16B, V31.16B
    BCAX V1.16B, V25.16B, V28.16B, V29.16B
    BCAX V29.16B, V9.16B, V3.16B, V1.16B
    EOR3 V31.16B, V30.16B, V26.16B, V2.16B
    EOR3 V20.16B, V18.16B, V20.16B, V11.16B
    EOR3 V10.16B, V0.16B, V6.16B, V29.16B
    EOR3 V8.16B, V20.16B, V20.16B, V27.16B
    EOR3 V9.16B, V25.16B, V10.16B, V31.16B
    EOR3 V23.16B, V31.16B, V25.16B, V19.16B
    EOR3 V10.16B, V15.16B, V16.16B, V8.16B
    EOR3 V28.16B, V20.16B, V31.16B, V4.16B
    EOR3 V30.16B, V12.16B, V6.16B, V17.16B
    EOR3 V5.16B, V4.16B, V16.16B, V1.16B
    RAX1 V26.2D, V22.2D, V0.2D
    RAX1 V15.2D, V26.2D, V23.2D
    RAX1 V23.2D, V1.2D, V19.2D
    RAX1 V2.2D, V25.2D, V14.2D
    RAX1 V18.2D, V4.2D, V27.2D
    RAX1 V26.2D, V28.2D, V2.2D
    RAX1 V31.2D, V7.2D, V18.2D
    RAX1 V11.2D, V23.2D, V5.2D
    RAX1 V3.2D, V30.2D, V17.2D
    RAX1 V29.2D, V31.2D, V31.2D
    XAR V14.2D, V26.2D, V3.2D, #0x2d
    XAR V1.2D, V29.2D, V10.2D, #0x39
    XAR V14.2D, V15.2D, V14.2D, #0x2a
    XAR V16.2D, V2.2D, V2.2D, #0xb
    XAR V0.2D, V10.2D, V1.2D, #0x16
    XAR V25.2D, V0.2D, V0.2D, #0x2e
    XAR V6.2D, V16.2D, V14.2D, #0x3b
    XAR V26.2D, V25.2D, V9.2D, #0xe
    XAR V16.2D, V6.2D, V1.2D, #0xc
    XAR V17.2D, V26.2D, V26.2D, #0x31
    SHA512H Q14, Q30, V11.2D
    SHA512H Q11, Q16, V5.2D
    SHA512H Q20, Q17, V14.2D
    SHA512H Q29, Q27, V13.2D
    SHA512H Q6, Q25, V15.2D
    SHA512H Q8, Q4, V24.2D
    SHA512H Q16, Q7, V2.2D
    SHA512H Q3, Q5, V22.2D
    SHA512H Q25, Q0, V29.2D
    SHA512H Q15, Q25, V30.2D
    SHA512H2 Q19, Q27, V31.2D
    SHA512H2 Q31, Q13, V26.2D
    SHA512H2 Q7, Q19, V8.2D
    SHA512H2 Q29, Q31, V26.2D
    SHA512H2 Q30, Q6, V3.2D
    SHA512H2 Q22, Q22, V7.2D
    SHA512H2 Q13, Q7, V30.2D
    SHA512H2 Q6, Q6, V13.2D
    SHA512H2 Q1, Q26, V15.2D
    SHA512H2 Q7, Q30, V26.2D
    SHA512SU0 V31.2D, V22.2D
    SHA512SU0 V9.2D, V31.2D
    SHA512SU0 V3.2D, V9.2D
    SHA512SU0 V13.2D, V29.2D
    SHA512SU0 V8.2D, V13.2D
    SHA512SU0 V17.2D, V22.2D
    SHA512SU0 V13.2D, V16.2D
    SHA512SU0 V3.2D, V1.2D
    SHA512SU0 V27.2D, V26.2D
    SHA512SU0 V15.2D, V3.2D
    SHA512SU1 V18.2D, V15.2D, V8.2D
    SHA512SU1 V30.2D, V13.2D, V18.2D
    SHA512SU1 V4.2D, V2.2D, V23.2D
    SHA512SU1 V23.2D, V2.2D, V25.2D
    SHA512SU1 V26.2D, V12.2D, V20.2D
    SHA512SU1 V29.2D, V24.2D, V26.2D
    SHA512SU1 V16.2D, V2.2D, V29.2D
    SHA512SU1 V31.2D, V23.2D, V16.2D
    SHA512SU1 V13.2D, V17.2D, V30.2D
    SHA512SU1 V24.2D, V26.2D, V17.2D
    SM3PARTW1 V30.4S, V24.4S, V2.4S
    SM3PARTW1 V3.4S, V20.4S, V14.4S
    SM3PARTW1 V3.4S, V9.4S, V13.4S
    SM3PARTW1 V9.4S, V31.4S, V21.4S
    SM3PARTW1 V29.4S, V8.4S, V6.4S
    SM3PARTW1 V23.4S, V29.4S, V0.4S
    SM3PARTW1 V16.4S, V23.4S, V23.4S
    SM3PARTW1 V13.4S, V3.4S, V16.4S
    SM3PARTW1 V29.4S, V4.4S, V4.4S
    SM3PARTW1 V8.4S, V26.4S, V20.4S
    SM3PARTW2 V1.4S, V24.4S, V30.4S
    SM3PARTW2 V2.4S, V1.4S, V27.4S
    SM3PARTW2 V16.4S, V9.4S, V28.4S
    SM3PARTW2 V25.4S, V29.4S, V25.4S
    SM3PARTW2 V5.4S, V28.4S, V8.4S
    SM3PARTW2 V21.4S, V30.4S, V16.4S
    SM3PARTW2 V23.4S, V5.4S, V25.4S
    SM3PARTW2 V14.4S, V25.4S, V13.4S
    SM3PARTW2 V27.4S, V5.4S, V21.4S
    SM3PARTW2 V30.4S, V14.4S, V27.4S
    SM3SS1 V31.4S, V2.4S, V19.4S, V4.4S
    SM3SS1 V27.4S, V23.4S, V17.4S, V26.4S
    SM3SS1 V6.4S, V31.4S, V22.4S, V9.4S
    SM3SS1 V3.4S, V6.4S, V29.4S, V30.4S
    SM3SS1 V16.4S, V9.4S, V24.4S, V24.4S
    SM3SS1 V9.4S, V5.4S, V21.4S, V22.4S
    SM3SS1 V20.4S, V16.4S, V23.4S, V30.4S
    SM3SS1 V12.4S, V28.4S, V2.4S, V16.4S
    SM3SS1 V23.4S, V28.4S, V19.4S, V28.4S
    SM3SS1 V26.4S, V27.4S, V1.4S, V20.4S
    SM3TT1A V17.4S, V7.4S, V30.S[0x3]
    SM3TT1A V7.4S, V18.4S, V29.S[0x3]
    SM3TT1A V20.4S, V29.4S, V24.S[0x0]
    SM3TT1A V5.4S, V25.4S, V0.S[0x3]
    SM3TT1A V24.4S, V5.4S, V27.S[0x2]
    SM3TT1A V6.4S, V9.4S, V24.S[0x3]
    SM3TT1A V4.4S, V20.4S, V26.S[0x0]
    SM3TT1A V19.4S, V4.4S, V13.S[0x0]
    SM3TT1A V1.4S, V7.4S, V16.S[0x1]
    SM3TT1A V13.4S, V23.4S, V21.S[0x1]
    SM3TT1B V12.4S, V6.4S, V13.S[0x2]
    SM3TT1B V29.4S, V26.4S, V1.S[0x0]
    SM3TT1B V22.4S, V17.4S, V4.S[0x2]
    SM3TT1B V20.4S, V23.4S, V3.S[0x3]
    SM3TT1B V0.4S, V18.4S, V20.S[0x3]
    SM3TT1B V18.4S, V29.4S, V17.S[0x0]
    SM3TT1B V28.4S, V0.4S, V12.S[0x0]
    SM3TT1B V27.4S, V19.4S, V18.S[0x3]
    SM3TT1B V5.4S, V9.4S, V10.S[0x3]
    SM3TT1B V14.4S, V22.4S, V5.S[0x3]
    SM3TT2A V23.4S, V10.4S, V8.S[0x3]
    SM3TT2A V25.4S, V14.4S, V27.S[0x1]
    SM3TT2A V10.4S, V28.4S, V5.S[0x2]
    SM3TT2A V2.4S, V10.4S, V15.S[0x1]
    SM3TT2A V7.4S, V25.4S, V23.S[0x3]
    SM3TT2A V6.4S, V30.4S, V3.S[0x1]
    SM3TT2A V28.4S, V30.4S, V21.S[0x0]
    SM3TT2A V8.4S, V2.4S, V22.S[0x2]
    SM3TT2A V26.4S, V13.4S, V14.S[0x0]
    SM3TT2A V24.4S, V21.4S, V21.S[0x3]
    SM3TT2B V17.4S, V26.4S, V29.S[0x0]
    SM3TT2B V22.4S, V15.4S, V29.S[0x1]
    SM3TT2B V16.4S, V29.4S, V8.S[0x3]
    SM3TT2B V10.4S, V10.4S, V5.S[0x2]
    SM3TT2B V18.4S, V21.4S, V12.S[0x0]
    SM3TT2B V29.4S, V10.4S, V28.S[0x2]
    SM3TT2B V14.4S, V18.4S, V18.S[0x3]
    SM3TT2B V5.4S, V18.4S, V26.S[0x0]
    SM3TT2B V3.4S, V22.4S, V24.S[0x0]
    SM3TT2B V24.4S, V12.4S, V16.S[0x2]
    SM4E V4.4S, V29.4S
    SM4E V8.4S, V18.4S
    SM4E V18.4S, V7.4S
    SM4E V4.4S, V3.4S
    SM4E V21.4S, V31.4S
    SM4E V26.4S, V4.4S
    SM4E V13.4S, V6.4S
    SM4E V3.4S, V17.4S
    SM4E V12.4S, V5.4S
    SM4E V7.4S, V14.4S
    SM4EKEY V14.4S, V7.4S, V8.4S
    SM4EKEY V4.4S, V20.4S, V18.4S
    SM4EKEY V6.4S, V22.4S, V1.4S
    SM4EKEY V20.4S, V5.4S, V24.4S
    SM4EKEY V18.4S, V13.4S, V10.4S
    SM4EKEY V8.4S, V18.4S, V21.4S
    SM4EKEY V17.4S, V8.4S, V14.4S
    SM4EKEY V5.4S, V27.4S, V26.4S
    SM4EKEY V29.4S, V23.4S, V3.4S
    SM4EKEY V31.4S, V29.4S, V20.4S
    MOVZ  X14, #0x66f8, LSL #0
    MOVK  X14, #0x3d27, LSL #16
    MOVK  X14, #0x7698, LSL #32
    MOVK  X14, #0xaa33, LSL #48
    SUB  X2, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x627a, LSL #0
    MOVK  X14, #0x24c3, LSL #16
    MOVK  X14, #0xb120, LSL #32
    MOVK  X14, #0xd8d8, LSL #48
    SUB  X2, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0xddae, LSL #0
    MOVK  X14, #0x174a, LSL #16
    MOVK  X14, #0x8ec2, LSL #32
    MOVK  X14, #0x3374, LSL #48
    SUB  X2, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x8772, LSL #0
    MOVK  X14, #0x2aa8, LSL #16
    MOVK  X14, #0x291e, LSL #32
    MOVK  X14, #0x508c, LSL #48
    SUB  X2, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0xd04f, LSL #0
    MOVK  X14, #0x6372, LSL #16
    MOVK  X14, #0x57f4, LSL #32
    MOVK  X14, #0xef25, LSL #48
    SUB  X2, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x11f5, LSL #0
    MOVK  X14, #0xb249, LSL #16
    MOVK  X14, #0x9c12, LSL #32
    MOVK  X14, #0x33da, LSL #48
    SUB  X2, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0xac3f, LSL #0
    MOVK  X14, #0xc78f, LSL #16
    MOVK  X14, #0x941d, LSL #32
    MOVK  X14, #0x684a, LSL #48
    SUB  X2, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x19f4, LSL #0
    MOVK  X14, #0x1e1b, LSL #16
    MOVK  X14, #0xe649, LSL #32
    MOVK  X14, #0x45b9, LSL #48
    SUB  X2, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x9b3, LSL #0
    MOVK  X14, #0xfe5, LSL #16
    MOVK  X14, #0xca31, LSL #32
    MOVK  X14, #0xf6f5, LSL #48
    SUB  X2, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x6c6f, LSL #0
    MOVK  X14, #0x9658, LSL #16
    MOVK  X14, #0xcb49, LSL #32
    MOVK  X14, #0xd695, LSL #48
    SUB  X2, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x20b7, LSL #0
    MOVK  X14, #0x6b5e, LSL #16
    MOVK  X14, #0xa6a4, LSL #32
    MOVK  X14, #0x7496, LSL #48
    SUB  X2, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0xbcc, LSL #0
    MOVK  X14, #0x8df3, LSL #16
    MOVK  X14, #0xd57c, LSL #32
    MOVK  X14, #0x7f6, LSL #48
    SUB  X2, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x14a0, LSL #0
    MOVK  X14, #0x5897, LSL #16
    MOVK  X14, #0xabef, LSL #32
    MOVK  X14, #0xc70b, LSL #48
    SUB  X2, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x1e86, LSL #0
    MOVK  X14, #0x54f3, LSL #16
    MOVK  X14, #0xbf52, LSL #32
    MOVK  X14, #0x8f3, LSL #48
    SUB  X2, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0xa1d2, LSL #0
    MOVK  X14, #0x3066, LSL #16
    MOVK  X14, #0xb0e0, LSL #32
    MOVK  X14, #0xf869, LSL #48
    SUB  X2, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x9288, LSL #0
    MOVK  X14, #0x5222, LSL #16
    MOVK  X14, #0xcf83, LSL #32
    MOVK  X14, #0x4e76, LSL #48
    SUB  X2, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x74d5, LSL #0
    MOVK  X14, #0xbc6e, LSL #16
    MOVK  X14, #0x438d, LSL #32
    MOVK  X14, #0x7a51, LSL #48
    SUB  X2, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x9668, LSL #0
    MOVK  X14, #0x7ca8, LSL #16
    MOVK  X14, #0xf3df, LSL #32
    MOVK  X14, #0x54e4, LSL #48
    SUB  X2, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0xd332, LSL #0
    MOVK  X14, #0x1392, LSL #16
    MOVK  X14, #0x453c, LSL #32
    MOVK  X14, #0xf1a5, LSL #48
    SUB  X2, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X14, #0x4acc, LSL #0
    MOVK  X14, #0xb3ef, LSL #16
    MOVK  X14, #0xd35a, LSL #32
    MOVK  X14, #0x1a71, LSL #48
    SUB  X2, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X14, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X2, #0xccaa, LSL #0
    MOVK  X2, #0x4fe1, LSL #16
    MOVK  X2, #0x4eba, LSL #32
    MOVK  X2, #0x3a4, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D0
    MOVZ  X2, #0xfca, LSL #0
    MOVK  X2, #0x54b1, LSL #16
    MOVK  X2, #0xd835, LSL #32
    MOVK  X2, #0xf364, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X2, #0xa2ac, LSL #0
    MOVK  X2, #0x54d, LSL #16
    MOVK  X2, #0xa611, LSL #32
    MOVK  X2, #0xb4fa, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D1
    MOVZ  X2, #0xf1f7, LSL #0
    MOVK  X2, #0xfb24, LSL #16
    MOVK  X2, #0x27a7, LSL #32
    MOVK  X2, #0x44b2, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X2, #0x972d, LSL #0
    MOVK  X2, #0x6d62, LSL #16
    MOVK  X2, #0xd45b, LSL #32
    MOVK  X2, #0x80b3, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D2
    MOVZ  X2, #0x85c, LSL #0
    MOVK  X2, #0x84dd, LSL #16
    MOVK  X2, #0x4b9c, LSL #32
    MOVK  X2, #0x6a29, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X2, #0x967d, LSL #0
    MOVK  X2, #0xbf33, LSL #16
    MOVK  X2, #0xee38, LSL #32
    MOVK  X2, #0xa0f8, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D3
    MOVZ  X2, #0xcf6, LSL #0
    MOVK  X2, #0x36f9, LSL #16
    MOVK  X2, #0x104d, LSL #32
    MOVK  X2, #0xe034, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X2, #0x63, LSL #0
    MOVK  X2, #0x6c0f, LSL #16
    MOVK  X2, #0xd852, LSL #32
    MOVK  X2, #0x10bd, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D4
    MOVZ  X2, #0x5a65, LSL #0
    MOVK  X2, #0xf4e1, LSL #16
    MOVK  X2, #0x3b51, LSL #32
    MOVK  X2, #0x66d6, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X2, #0xaf35, LSL #0
    MOVK  X2, #0x1159, LSL #16
    MOVK  X2, #0x6e2, LSL #32
    MOVK  X2, #0x2ad7, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D5
    MOVZ  X2, #0xcdda, LSL #0
    MOVK  X2, #0xa4d9, LSL #16
    MOVK  X2, #0xa95f, LSL #32
    MOVK  X2, #0x65ac, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X2, #0x746d, LSL #0
    MOVK  X2, #0x9805, LSL #16
    MOVK  X2, #0x9239, LSL #32
    MOVK  X2, #0xcfef, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D6
    MOVZ  X2, #0x9017, LSL #0
    MOVK  X2, #0xdb82, LSL #16
    MOVK  X2, #0x179d, LSL #32
    MOVK  X2, #0xada2, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X2, #0xe5d7, LSL #0
    MOVK  X2, #0x6bad, LSL #16
    MOVK  X2, #0x78cd, LSL #32
    MOVK  X2, #0x1f2c, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D7
    MOVZ  X2, #0x5d20, LSL #0
    MOVK  X2, #0x8491, LSL #16
    MOVK  X2, #0xa1eb, LSL #32
    MOVK  X2, #0x3e42, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X2, #0xbb8a, LSL #0
    MOVK  X2, #0x5cf, LSL #16
    MOVK  X2, #0x27f7, LSL #32
    MOVK  X2, #0xdab2, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D8
    MOVZ  X2, #0xf961, LSL #0
    MOVK  X2, #0xacba, LSL #16
    MOVK  X2, #0x61b9, LSL #32
    MOVK  X2, #0xe71c, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xbbb6, LSL #32
    MOVK  X2, #0xa5af, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D9
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X2, #0x5ea, LSL #0
    MOVK  X2, #0x6727, LSL #16
    MOVK  X2, #0xb3c3, LSL #32
    MOVK  X2, #0x2350, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D10
    MOVZ  X2, #0x8a10, LSL #0
    MOVK  X2, #0x38e, LSL #16
    MOVK  X2, #0xa3ee, LSL #32
    MOVK  X2, #0x62dd, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X2, #0x7d08, LSL #0
    MOVK  X2, #0x86f2, LSL #16
    MOVK  X2, #0x7f5c, LSL #32
    MOVK  X2, #0xfb53, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D11
    MOVZ  X2, #0x1c89, LSL #0
    MOVK  X2, #0x366, LSL #16
    MOVK  X2, #0xcd08, LSL #32
    MOVK  X2, #0x16a7, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X2, #0x38fe, LSL #0
    MOVK  X2, #0x8cb0, LSL #16
    MOVK  X2, #0xee95, LSL #32
    MOVK  X2, #0xa54b, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D12
    MOVZ  X2, #0x6386, LSL #0
    MOVK  X2, #0xd229, LSL #16
    MOVK  X2, #0xdb0, LSL #32
    MOVK  X2, #0x43ab, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X2, #0x1a4, LSL #0
    MOVK  X2, #0xf444, LSL #16
    MOVK  X2, #0x20bd, LSL #32
    MOVK  X2, #0xf61f, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D13
    MOVZ  X2, #0xd6cc, LSL #0
    MOVK  X2, #0x1c38, LSL #16
    MOVK  X2, #0x7db1, LSL #32
    MOVK  X2, #0xfcf, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X2, #0xcb44, LSL #0
    MOVK  X2, #0xc634, LSL #16
    MOVK  X2, #0x5b1f, LSL #32
    MOVK  X2, #0xce93, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D14
    MOVZ  X2, #0x51a1, LSL #0
    MOVK  X2, #0xcbf5, LSL #16
    MOVK  X2, #0x22fa, LSL #32
    MOVK  X2, #0x4007, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X2, #0x5832, LSL #0
    MOVK  X2, #0x9dd9, LSL #16
    MOVK  X2, #0x2439, LSL #32
    MOVK  X2, #0x4fba, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D15
    MOVZ  X2, #0x4164, LSL #0
    MOVK  X2, #0xf6e2, LSL #16
    MOVK  X2, #0xc90b, LSL #32
    MOVK  X2, #0x5c93, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X2, #0x333c, LSL #0
    MOVK  X2, #0x71a5, LSL #16
    MOVK  X2, #0x545f, LSL #32
    MOVK  X2, #0x5909, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X2, #0xbbe4, LSL #0
    MOVK  X2, #0x5a57, LSL #16
    MOVK  X2, #0xc5fc, LSL #32
    MOVK  X2, #0x256b, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D17
    MOVZ  X2, #0xa42c, LSL #0
    MOVK  X2, #0x8dfc, LSL #16
    MOVK  X2, #0x1d5c, LSL #32
    MOVK  X2, #0xaa9c, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X2, #0x512c, LSL #0
    MOVK  X2, #0x4e65, LSL #16
    MOVK  X2, #0x121b, LSL #32
    MOVK  X2, #0x96ff, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D18
    MOVZ  X2, #0xc1f0, LSL #0
    MOVK  X2, #0xdedd, LSL #16
    MOVK  X2, #0xcf91, LSL #32
    MOVK  X2, #0x70bf, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X2, #0xafbf, LSL #0
    MOVK  X2, #0x80ad, LSL #16
    MOVK  X2, #0x7496, LSL #32
    MOVK  X2, #0xc1dd, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D19
    MOVZ  X2, #0x9ea9, LSL #0
    MOVK  X2, #0xb380, LSL #16
    MOVK  X2, #0x21c2, LSL #32
    MOVK  X2, #0x3339, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X2, #0x4d90, LSL #0
    MOVK  X2, #0x2006, LSL #16
    MOVK  X2, #0xdc2, LSL #32
    MOVK  X2, #0x9014, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D20
    MOVZ  X2, #0x5a6c, LSL #0
    MOVK  X2, #0xb99b, LSL #16
    MOVK  X2, #0x1101, LSL #32
    MOVK  X2, #0xc961, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X2, #0x3921, LSL #0
    MOVK  X2, #0xe879, LSL #16
    MOVK  X2, #0xa065, LSL #32
    MOVK  X2, #0x43b, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D21
    MOVZ  X2, #0x7431, LSL #0
    MOVK  X2, #0xeecb, LSL #16
    MOVK  X2, #0x6da7, LSL #32
    MOVK  X2, #0x11f2, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X2, #0xbf88, LSL #0
    MOVK  X2, #0x225a, LSL #16
    MOVK  X2, #0x8fb0, LSL #32
    MOVK  X2, #0xea51, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D22
    MOVZ  X2, #0x21d7, LSL #0
    MOVK  X2, #0x6485, LSL #16
    MOVK  X2, #0x2e1b, LSL #32
    MOVK  X2, #0xa129, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X2, #0x7e93, LSL #0
    MOVK  X2, #0x6680, LSL #16
    MOVK  X2, #0xf8ca, LSL #32
    MOVK  X2, #0xd427, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X2, #0xd257, LSL #0
    MOVK  X2, #0x25c, LSL #16
    MOVK  X2, #0x1009, LSL #32
    MOVK  X2, #0x6134, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D24
    MOVZ  X2, #0x54cb, LSL #0
    MOVK  X2, #0x2aa2, LSL #16
    MOVK  X2, #0x1e87, LSL #32
    MOVK  X2, #0x3376, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X2, #0xedca, LSL #0
    MOVK  X2, #0x80ae, LSL #16
    MOVK  X2, #0xca54, LSL #32
    MOVK  X2, #0xefda, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D25
    MOVZ  X2, #0xa2ca, LSL #0
    MOVK  X2, #0xed39, LSL #16
    MOVK  X2, #0x7070, LSL #32
    MOVK  X2, #0xfd26, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X2, #0xfc48, LSL #0
    MOVK  X2, #0xbbb9, LSL #16
    MOVK  X2, #0xb95c, LSL #32
    MOVK  X2, #0x532a, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D26
    MOVZ  X2, #0x43eb, LSL #0
    MOVK  X2, #0x4a17, LSL #16
    MOVK  X2, #0x5e19, LSL #32
    MOVK  X2, #0x684, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X2, #0x7eb1, LSL #0
    MOVK  X2, #0xf0de, LSL #16
    MOVK  X2, #0xe4c3, LSL #32
    MOVK  X2, #0x32db, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D27
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X2, #0x3232, LSL #0
    MOVK  X2, #0xf159, LSL #16
    MOVK  X2, #0x30a4, LSL #32
    MOVK  X2, #0x4cd3, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D28
    MOVZ  X2, #0x5f30, LSL #0
    MOVK  X2, #0xe3dc, LSL #16
    MOVK  X2, #0x52ad, LSL #32
    MOVK  X2, #0xe4ca, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X2, #0x755d, LSL #0
    MOVK  X2, #0xde72, LSL #16
    MOVK  X2, #0xfda2, LSL #32
    MOVK  X2, #0xfac4, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D29
    MOVZ  X2, #0x5485, LSL #0
    MOVK  X2, #0xc970, LSL #16
    MOVK  X2, #0x4cf0, LSL #32
    MOVK  X2, #0xb2a7, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X2, #0xf974, LSL #0
    MOVK  X2, #0xdda3, LSL #16
    MOVK  X2, #0xde89, LSL #32
    MOVK  X2, #0x44ae, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D30
    MOVZ  X2, #0x7acc, LSL #0
    MOVK  X2, #0x23d4, LSL #16
    MOVK  X2, #0xbe2e, LSL #32
    MOVK  X2, #0xd4fe, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X2, #0xb614, LSL #0
    MOVK  X2, #0x3f11, LSL #16
    MOVK  X2, #0x83e, LSL #32
    MOVK  X2, #0xcc3b, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X14, D31
    MOVZ  X2, #0x50dd, LSL #0
    MOVK  X2, #0x5298, LSL #16
    MOVK  X2, #0xcb5d, LSL #32
    MOVK  X2, #0x219, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0xebcf, LSL #0
    MOVK  X2, #0x4c33, LSL #16
    MOVK  X2, #0xdf69, LSL #32
    MOVK  X2, #0xc778, LSL #48
    MOVZ  X3, #0xe047, LSL #0
    MOVK  X3, #0xf1, LSL #16
    MOVK  X3, #0x3222, LSL #32
    MOVK  X3, #0xda9, LSL #48
    MOVZ  X4, #0xdfdf, LSL #0
    MOVK  X4, #0xf6e6, LSL #16
    MOVK  X4, #0x636e, LSL #32
    MOVK  X4, #0x9cec, LSL #48
    MOVZ  X5, #0x7643, LSL #0
    MOVK  X5, #0xc48d, LSL #16
    MOVK  X5, #0xaa57, LSL #32
    MOVK  X5, #0xf6fb, LSL #48
    MOVZ  X6, #0x11f3, LSL #0
    MOVK  X6, #0xdf5a, LSL #16
    MOVK  X6, #0x56dd, LSL #32
    MOVK  X6, #0x1150, LSL #48
    MOVZ  X7, #0xc8b1, LSL #0
    MOVK  X7, #0xcfe4, LSL #16
    MOVK  X7, #0xe713, LSL #32
    MOVK  X7, #0xc854, LSL #48
    MOVZ  X8, #0x5672, LSL #0
    MOVK  X8, #0xa785, LSL #16
    MOVK  X8, #0xb6ae, LSL #32
    MOVK  X8, #0x389a, LSL #48
    MOVZ  X9, #0x8c02, LSL #0
    MOVK  X9, #0xd241, LSL #16
    MOVK  X9, #0x9341, LSL #32
    MOVK  X9, #0x6667, LSL #48
    MOVZ  X10, #0xe07d, LSL #0
    MOVK  X10, #0x610a, LSL #16
    MOVK  X10, #0xee72, LSL #32
    MOVK  X10, #0x8498, LSL #48
    MOVZ  X11, #0x91a, LSL #0
    MOVK  X11, #0x5f56, LSL #16
    MOVK  X11, #0xc891, LSL #32
    MOVK  X11, #0xb4fd, LSL #48
    MOVZ  X12, #0xdc69, LSL #0
    MOVK  X12, #0xc7d3, LSL #16
    MOVK  X12, #0x59b9, LSL #32
    MOVK  X12, #0x5239, LSL #48
    MOVZ  X13, #0xc700, LSL #0
    MOVK  X13, #0xb315, LSL #16
    MOVK  X13, #0xf9dd, LSL #32
    MOVK  X13, #0xe225, LSL #48
    MOVZ  X14, #0xb03e, LSL #0
    MOVK  X14, #0x8516, LSL #16
    MOVK  X14, #0x774a, LSL #32
    MOVK  X14, #0x948e, LSL #48
    MOVZ  X15, #0x6cbd, LSL #0
    MOVK  X15, #0x2637, LSL #16
    MOVK  X15, #0xde3f, LSL #32
    MOVK  X15, #0xa567, LSL #48
    MOVZ  X16, #0x630e, LSL #0
    MOVK  X16, #0x2cce, LSL #16
    MOVK  X16, #0x7a76, LSL #32
    MOVK  X16, #0x2b97, LSL #48
    MOVZ  X17, #0xa0d4, LSL #0
    MOVK  X17, #0xd9e6, LSL #16
    MOVK  X17, #0x8039, LSL #32
    MOVK  X17, #0x394d, LSL #48
    MOVZ  X18, #0x6b81, LSL #0
    MOVK  X18, #0xec99, LSL #16
    MOVK  X18, #0xeab, LSL #32
    MOVK  X18, #0x6a40, LSL #48
    MOVZ  X19, #0xb8a8, LSL #0
    MOVK  X19, #0xa7ea, LSL #16
    MOVK  X19, #0x877a, LSL #32
    MOVK  X19, #0x8dbb, LSL #48
    MOVZ  X20, #0x9774, LSL #0
    MOVK  X20, #0xd7ac, LSL #16
    MOVK  X20, #0x3905, LSL #32
    MOVK  X20, #0xfa92, LSL #48
    MOVZ  X21, #0xe4e1, LSL #0
    MOVK  X21, #0x37c0, LSL #16
    MOVK  X21, #0xf4ce, LSL #32
    MOVK  X21, #0xa6b4, LSL #48
    MOVZ  X22, #0x29bd, LSL #0
    MOVK  X22, #0xa350, LSL #16
    MOVK  X22, #0xcb75, LSL #32
    MOVK  X22, #0xb0d6, LSL #48
    MOVZ  X23, #0x36cb, LSL #0
    MOVK  X23, #0x2a77, LSL #16
    MOVK  X23, #0x7647, LSL #32
    MOVK  X23, #0x532c, LSL #48
    MOVZ  X28, #0x4fbb, LSL #0
    MOVK  X28, #0x871a, LSL #16
    MOVK  X28, #0x83b, LSL #32
    MOVK  X28, #0x355, LSL #48
    FMOV  D0, X11
    FMOV  V0.D[1], X22
    FMOV  D1, X17
    FMOV  V1.D[1], X13
    FMOV  D2, X28
    FMOV  V2.D[1], X7
    FMOV  D3, X19
    FMOV  V3.D[1], X23
    FMOV  D4, X16
    FMOV  V4.D[1], X10
    FMOV  D5, X14
    FMOV  V5.D[1], X7
    FMOV  D6, X14
    FMOV  V6.D[1], X4
    FMOV  D7, X4
    FMOV  V7.D[1], X23
    FMOV  D8, X6
    FMOV  V8.D[1], X8
    FMOV  D9, X22
    FMOV  V9.D[1], X15
    FMOV  D10, X13
    FMOV  V10.D[1], X3
    FMOV  D11, X20
    FMOV  V11.D[1], X12
    FMOV  D12, X23
    FMOV  V12.D[1], X16
    FMOV  D13, X17
    FMOV  V13.D[1], X18
    FMOV  D14, X17
    FMOV  V14.D[1], X23
    FMOV  D15, X11
    FMOV  V15.D[1], X5
    FMOV  D16, X7
    FMOV  V16.D[1], X12
    FMOV  D17, X5
    FMOV  V17.D[1], X7
    FMOV  D18, X11
    FMOV  V18.D[1], X17
    FMOV  D19, X14
    FMOV  V19.D[1], X5
    FMOV  D20, X2
    FMOV  V20.D[1], X15
    FMOV  D21, X2
    FMOV  V21.D[1], X15
    FMOV  D22, X28
    FMOV  V22.D[1], X15
    FMOV  D23, X13
    FMOV  V23.D[1], X4
    FMOV  D24, X2
    FMOV  V24.D[1], X17
    FMOV  D25, X16
    FMOV  V25.D[1], X18
    FMOV  D26, X9
    FMOV  V26.D[1], X22
    FMOV  D27, X21
    FMOV  V27.D[1], X7
    FMOV  D28, X4
    FMOV  V28.D[1], X6
    FMOV  D29, X20
    FMOV  V29.D[1], X3
    FMOV  D30, X12
    FMOV  V30.D[1], X19
    FMOV  D31, X3
    FMOV  V31.D[1], X2
    MOVZ  X7, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_0:
    SHA512SU0 V15.2D, V9.2D
    SM3TT2B V1.4S, V27.4S, V23.S[0x0]
    SM4EKEY V22.4S, V14.4S, V24.4S
    SHA512H Q16, Q31, V30.2D
    SHA512SU0 V6.2D, V22.2D
    SHA512H2 Q25, Q9, V13.2D
    XAR V14.2D, V6.2D, V6.2D, #0x1f
    SHA512SU1 V5.2D, V14.2D, V16.2D
    SHA512H Q7, Q28, V1.2D
    SM3SS1 V7.4S, V15.4S, V2.4S, V5.4S
    SM3PARTW1 V15.4S, V29.4S, V29.4S
    SM4EKEY V1.4S, V3.4S, V15.4S
    XAR V3.2D, V7.2D, V1.2D, #0x21
    SHA512H Q16, Q20, V3.2D
    SM4E V19.4S, V25.4S
    EOR3 V31.16B, V19.16B, V14.16B, V16.16B
    XAR V30.2D, V28.2D, V22.2D, #0x1d
    SM3PARTW1 V28.4S, V17.4S, V25.4S
    EOR3 V17.16B, V31.16B, V22.16B, V17.16B
    SM3TT1B V27.4S, V17.4S, V9.S[0x0]
    BCAX V23.16B, V29.16B, V4.16B, V17.16B
    EOR3 V1.16B, V15.16B, V4.16B, V7.16B
    SHA512SU1 V6.2D, V17.2D, V0.2D
    SM3PARTW2 V13.4S, V10.4S, V20.4S
    SM4EKEY V20.4S, V4.4S, V26.4S
    SM3PARTW1 V4.4S, V19.4S, V29.4S
    SM4EKEY V19.4S, V6.4S, V1.4S
    SM4EKEY V31.4S, V20.4S, V5.4S
    SM4E V7.4S, V4.4S
    SHA512SU1 V22.2D, V4.2D, V31.2D
    SM4E V8.4S, V19.4S
    SHA512SU0 V14.2D, V30.2D
    SHA512H Q26, Q28, V19.2D
    SHA512SU0 V22.2D, V23.2D
    RAX1 V7.2D, V18.2D, V9.2D
    SM4E V30.4S, V7.4S
    SM3PARTW2 V15.4S, V6.4S, V18.4S
    SM4E V4.4S, V19.4S
    SHA512SU1 V5.2D, V14.2D, V11.2D
    SM3TT2A V6.4S, V27.4S, V30.S[0x1]
    SM3PARTW2 V20.4S, V11.4S, V8.4S
    SHA512SU1 V23.2D, V22.2D, V18.2D
    SM3PARTW1 V22.4S, V4.4S, V14.4S
    EOR3 V30.16B, V5.16B, V15.16B, V15.16B
    SM4EKEY V8.4S, V0.4S, V6.4S
    SM3PARTW1 V0.4S, V18.4S, V23.4S
    SM4EKEY V15.4S, V1.4S, V22.4S
    SHA512SU1 V14.2D, V30.2D, V30.2D
    EOR3 V28.16B, V31.16B, V13.16B, V24.16B
    SM4EKEY V19.4S, V20.4S, V19.4S
    XAR V27.2D, V28.2D, V26.2D, #0x38
    SHA512SU0 V6.2D, V27.2D
    XAR V17.2D, V12.2D, V8.2D, #0x1e
    SM3SS1 V18.4S, V19.4S, V15.4S, V6.4S
    SM3TT2B V13.4S, V17.4S, V18.S[0x0]
    SM3PARTW2 V30.4S, V13.4S, V5.4S
    SHA512SU0 V14.2D, V3.2D
    SHA512H2 Q3, Q30, V30.2D
    SHA512H2 Q14, Q14, V3.2D
    SM4E V28.4S, V12.4S
    EOR3 V31.16B, V11.16B, V27.16B, V31.16B
    SM3PARTW1 V4.4S, V22.4S, V29.4S
    SHA512H2 Q18, Q21, V6.2D
    SM3TT1B V23.4S, V6.4S, V1.S[0x0]
    XAR V8.2D, V18.2D, V25.2D, #0x17
    RAX1 V22.2D, V1.2D, V14.2D
    SM3PARTW1 V25.4S, V4.4S, V26.4S
    SHA512H Q20, Q18, V29.2D
    SM3TT1B V17.4S, V23.4S, V0.S[0x2]
    SHA512H Q19, Q12, V22.2D
    SM4EKEY V12.4S, V13.4S, V29.4S
    BCAX V14.16B, V11.16B, V15.16B, V0.16B
    BCAX V23.16B, V31.16B, V23.16B, V12.16B
    XAR V30.2D, V6.2D, V8.2D, #0x1f
    SM4E V13.4S, V22.4S
    SM4EKEY V21.4S, V14.4S, V19.4S
    SM3TT1B V14.4S, V28.4S, V21.S[0x2]
    SM3TT1A V6.4S, V30.4S, V25.S[0x0]
    RAX1 V28.2D, V15.2D, V20.2D
    SM4EKEY V26.4S, V6.4S, V28.4S
    SM3TT2A V15.4S, V18.4S, V23.S[0x0]
    SM4EKEY V21.4S, V12.4S, V26.4S
    SM4EKEY V4.4S, V15.4S, V15.4S
    SM3TT1A V22.4S, V21.4S, V21.S[0x1]
    SHA512SU1 V1.2D, V4.2D, V17.2D
    EOR3 V8.16B, V14.16B, V22.16B, V12.16B
    SM3TT2A V15.4S, V20.4S, V1.S[0x2]
    SM4EKEY V31.4S, V8.4S, V0.4S
    RAX1 V20.2D, V23.2D, V31.2D
    SM4E V29.4S, V15.4S
    EOR3 V8.16B, V20.16B, V29.16B, V15.16B
    BCAX V21.16B, V26.16B, V20.16B, V10.16B
    SM3PARTW1 V10.4S, V1.4S, V5.4S
    RAX1 V18.2D, V3.2D, V22.2D
    XAR V29.2D, V9.2D, V18.2D, #0xa
    RAX1 V12.2D, V28.2D, V15.2D
    SM3TT2B V8.4S, V4.4S, V22.S[0x1]
    SM3PARTW1 V14.4S, V13.4S, V18.4S
    XAR V20.2D, V25.2D, V30.2D, #0x3b
    EOR3 V18.16B, V6.16B, V2.16B, V7.16B
    RAX1 V1.2D, V23.2D, V5.2D
    XAR V0.2D, V10.2D, V10.2D, #0x3c
    SM3SS1 V11.4S, V20.4S, V31.4S, V8.4S
    BCAX V16.16B, V12.16B, V1.16B, V11.16B
    SM4EKEY V10.4S, V21.4S, V14.4S
    RAX1 V25.2D, V4.2D, V28.2D
    SM3TT1B V3.4S, V15.4S, V18.S[0x0]
    SHA512H2 Q11, Q0, V29.2D
    SHA512H Q5, Q16, V9.2D
    SHA512H2 Q0, Q0, V5.2D
    SM3PARTW2 V1.4S, V10.4S, V25.4S
    RAX1 V5.2D, V0.2D, V0.2D
    BCAX V28.16B, V5.16B, V0.16B, V3.16B
    SM4EKEY V5.4S, V29.4S, V1.4S
    SM3TT2A V26.4S, V6.4S, V3.S[0x1]
    SM4EKEY V18.4S, V26.4S, V5.4S
    SHA512SU0 V12.2D, V23.2D
    SM4EKEY V15.4S, V28.4S, V1.4S
    SM3SS1 V23.4S, V12.4S, V11.4S, V18.4S
    SM4E V9.4S, V8.4S
    BCAX V29.16B, V8.16B, V22.16B, V2.16B
    SM3TT2B V2.4S, V30.4S, V14.S[0x3]
    SM4E V30.4S, V11.4S
    SHA512SU0 V2.2D, V18.2D
    XAR V13.2D, V26.2D, V25.2D, #0x35
    XAR V5.2D, V19.2D, V24.2D, #0x27
    SHA512H Q21, Q17, V0.2D
    SM3TT1A V17.4S, V20.4S, V5.S[0x0]
    SM4EKEY V0.4S, V9.4S, V29.4S
    SM4E V8.4S, V25.4S
    SM4E V28.4S, V15.4S
    RAX1 V25.2D, V23.2D, V17.2D
    SM4E V0.4S, V15.4S
    BCAX V26.16B, V28.16B, V17.16B, V28.16B
    SM4E V24.4S, V9.4S
    SM4EKEY V20.4S, V2.4S, V0.4S
    SM4EKEY V23.4S, V25.4S, V24.4S
    EOR3 V2.16B, V21.16B, V6.16B, V8.16B
    SM4E V28.4S, V26.4S
    SM3SS1 V25.4S, V13.4S, V13.4S, V13.4S
    SM3PARTW1 V13.4S, V28.4S, V29.4S
    SM3TT2A V26.4S, V30.4S, V2.S[0x0]
    SHA512H Q14, Q26, V26.2D
    SM4EKEY V15.4S, V1.4S, V20.4S
    SM4E V5.4S, V13.4S
    SHA512SU1 V12.2D, V25.2D, V6.2D
    SHA512H2 Q8, Q4, V25.2D
    SM4EKEY V2.4S, V5.4S, V5.4S
    SHA512SU1 V6.2D, V1.2D, V14.2D
    RAX1 V26.2D, V5.2D, V15.2D
    SM4E V21.4S, V12.4S
    EOR3 V9.16B, V21.16B, V7.16B, V2.16B
    SM3TT1A V30.4S, V14.4S, V9.S[0x3]
    SHA512H Q8, Q25, V5.2D
    SHA512SU1 V7.2D, V16.2D, V6.2D
    SM3TT1B V20.4S, V8.4S, V30.S[0x1]
    SM3PARTW1 V12.4S, V6.4S, V7.4S
    SM3PARTW1 V8.4S, V7.4S, V12.4S
    SM4E V21.4S, V20.4S
    SM3SS1 V7.4S, V21.4S, V21.4S, V13.4S
    BCAX V9.16B, V26.16B, V27.16B, V23.16B
    SM3TT1A V5.4S, V0.4S, V10.S[0x0]
    BCAX V29.16B, V30.16B, V1.16B, V6.16B
    SM3TT1A V28.4S, V29.4S, V30.S[0x2]
    SHA512H2 Q1, Q7, V5.2D
    SM4EKEY V16.4S, V8.4S, V29.4S
    BCAX V2.16B, V1.16B, V8.16B, V1.16B
    SM4EKEY V4.4S, V16.4S, V16.4S
    SM3TT1A V26.4S, V28.4S, V5.S[0x3]
    SM3SS1 V14.4S, V2.4S, V4.4S, V2.4S
    SM3PARTW2 V29.4S, V14.4S, V14.4S
    SHA512SU0 V15.2D, V3.2D
    SHA512SU0 V13.2D, V29.2D
    SM4E V12.4S, V18.4S
    BCAX V14.16B, V12.16B, V15.16B, V9.16B
    SHA512H2 Q1, Q14, V26.2D
    SM3TT1B V19.4S, V25.4S, V7.S[0x0]
    SM3SS1 V29.4S, V19.4S, V30.4S, V17.4S
    SM3PARTW1 V19.4S, V31.4S, V6.4S
    SM3TT1B V25.4S, V12.4S, V5.S[0x2]
    SM3TT1A V18.4S, V5.4S, V9.S[0x0]
    SM3TT1B V8.4S, V10.4S, V27.S[0x1]
    SM3PARTW1 V5.4S, V5.4S, V22.4S
    SM4E V4.4S, V3.4S
    SHA512H Q16, Q18, V29.2D
    SM3PARTW2 V22.4S, V4.4S, V25.4S
    SM4E V15.4S, V16.4S
    EOR3 V30.16B, V1.16B, V1.16B, V15.16B
    SM4EKEY V23.4S, V23.4S, V5.4S
    XAR V15.2D, V30.2D, V30.2D, #0x32
    SM3TT1A V6.4S, V6.4S, V8.S[0x3]
    SHA512SU1 V12.2D, V19.2D, V15.2D
    SM3TT1B V26.4S, V22.4S, V13.S[0x0]
    EOR3 V17.16B, V29.16B, V31.16B, V25.16B
    SHA512SU1 V20.2D, V26.2D, V17.2D
    SM4EKEY V28.4S, V15.4S, V0.4S
    SM4EKEY V25.4S, V12.4S, V28.4S
    EOR3 V29.16B, V24.16B, V20.16B, V20.16B
    SHA512SU0 V27.2D, V23.2D
    BCAX V14.16B, V29.16B, V1.16B, V25.16B
    SUBS  X7, X7, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_0
    MOVZ  X22, #0xebcf, LSL #0
    MOVK  X22, #0x4c33, LSL #16
    MOVK  X22, #0xdf69, LSL #32
    MOVK  X22, #0xc778, LSL #48
    SUB  X18, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0xe047, LSL #0
    MOVK  X22, #0xf1, LSL #16
    MOVK  X22, #0x3222, LSL #32
    MOVK  X22, #0xda9, LSL #48
    SUB  X18, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0xdfdf, LSL #0
    MOVK  X22, #0xf6e6, LSL #16
    MOVK  X22, #0x636e, LSL #32
    MOVK  X22, #0x9cec, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x7643, LSL #0
    MOVK  X22, #0xc48d, LSL #16
    MOVK  X22, #0xaa57, LSL #32
    MOVK  X22, #0xf6fb, LSL #48
    SUB  X18, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x11f3, LSL #0
    MOVK  X22, #0xdf5a, LSL #16
    MOVK  X22, #0x56dd, LSL #32
    MOVK  X22, #0x1150, LSL #48
    SUB  X18, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5672, LSL #0
    MOVK  X22, #0xa785, LSL #16
    MOVK  X22, #0xb6ae, LSL #32
    MOVK  X22, #0x389a, LSL #48
    SUB  X18, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x8c02, LSL #0
    MOVK  X22, #0xd241, LSL #16
    MOVK  X22, #0x9341, LSL #32
    MOVK  X22, #0x6667, LSL #48
    SUB  X18, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0xe07d, LSL #0
    MOVK  X22, #0x610a, LSL #16
    MOVK  X22, #0xee72, LSL #32
    MOVK  X22, #0x8498, LSL #48
    SUB  X18, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x91a, LSL #0
    MOVK  X22, #0x5f56, LSL #16
    MOVK  X22, #0xc891, LSL #32
    MOVK  X22, #0xb4fd, LSL #48
    SUB  X18, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0xdc69, LSL #0
    MOVK  X22, #0xc7d3, LSL #16
    MOVK  X22, #0x59b9, LSL #32
    MOVK  X22, #0x5239, LSL #48
    SUB  X18, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0xc700, LSL #0
    MOVK  X22, #0xb315, LSL #16
    MOVK  X22, #0xf9dd, LSL #32
    MOVK  X22, #0xe225, LSL #48
    SUB  X18, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0xb03e, LSL #0
    MOVK  X22, #0x8516, LSL #16
    MOVK  X22, #0x774a, LSL #32
    MOVK  X22, #0x948e, LSL #48
    SUB  X18, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x6cbd, LSL #0
    MOVK  X22, #0x2637, LSL #16
    MOVK  X22, #0xde3f, LSL #32
    MOVK  X22, #0xa567, LSL #48
    SUB  X18, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x630e, LSL #0
    MOVK  X22, #0x2cce, LSL #16
    MOVK  X22, #0x7a76, LSL #32
    MOVK  X22, #0x2b97, LSL #48
    SUB  X18, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0xa0d4, LSL #0
    MOVK  X22, #0xd9e6, LSL #16
    MOVK  X22, #0x8039, LSL #32
    MOVK  X22, #0x394d, LSL #48
    SUB  X18, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0xb8a8, LSL #0
    MOVK  X22, #0xa7ea, LSL #16
    MOVK  X22, #0x877a, LSL #32
    MOVK  X22, #0x8dbb, LSL #48
    SUB  X18, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x9774, LSL #0
    MOVK  X22, #0xd7ac, LSL #16
    MOVK  X22, #0x3905, LSL #32
    MOVK  X22, #0xfa92, LSL #48
    SUB  X18, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x36cb, LSL #0
    MOVK  X22, #0x2a77, LSL #16
    MOVK  X22, #0x7647, LSL #32
    MOVK  X22, #0x532c, LSL #48
    SUB  X18, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x4fbb, LSL #0
    MOVK  X22, #0x871a, LSL #16
    MOVK  X22, #0x83b, LSL #32
    MOVK  X22, #0x355, LSL #48
    SUB  X18, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X22, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X18, #0xeb14, LSL #0
    MOVK  X18, #0x1019, LSL #16
    MOVK  X18, #0x6506, LSL #32
    MOVK  X18, #0x314f, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D0
    MOVZ  X18, #0x26f2, LSL #0
    MOVK  X18, #0xab77, LSL #16
    MOVK  X18, #0x2a34, LSL #32
    MOVK  X18, #0x5ea7, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X18, #0xa1b7, LSL #0
    MOVK  X18, #0x9534, LSL #16
    MOVK  X18, #0x932f, LSL #32
    MOVK  X18, #0x34aa, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D1
    MOVZ  X18, #0x7fbc, LSL #0
    MOVK  X18, #0xd6be, LSL #16
    MOVK  X18, #0x8d3c, LSL #32
    MOVK  X18, #0x8fd7, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X18, #0xe976, LSL #0
    MOVK  X18, #0xfffc, LSL #16
    MOVK  X18, #0x2fdf, LSL #32
    MOVK  X18, #0xf579, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D2
    MOVZ  X18, #0xffb, LSL #0
    MOVK  X18, #0x7f1f, LSL #16
    MOVK  X18, #0xf1bf, LSL #32
    MOVK  X18, #0xdf6f, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X18, #0x36c5, LSL #0
    MOVK  X18, #0x488, LSL #16
    MOVK  X18, #0x1f7d, LSL #32
    MOVK  X18, #0x7ab0, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D3
    MOVZ  X18, #0x911b, LSL #0
    MOVK  X18, #0xdbb5, LSL #16
    MOVK  X18, #0x33bd, LSL #32
    MOVK  X18, #0xef08, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X18, #0x34ef, LSL #0
    MOVK  X18, #0xd16d, LSL #16
    MOVK  X18, #0x20b4, LSL #32
    MOVK  X18, #0xac26, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D4
    MOVZ  X18, #0x311e, LSL #0
    MOVK  X18, #0x8461, LSL #16
    MOVK  X18, #0x1e78, LSL #32
    MOVK  X18, #0x93a4, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X18, #0x688, LSL #0
    MOVK  X18, #0x73e9, LSL #16
    MOVK  X18, #0xcc42, LSL #32
    MOVK  X18, #0x85f4, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D5
    MOVZ  X18, #0x5e0a, LSL #0
    MOVK  X18, #0x3299, LSL #16
    MOVK  X18, #0x67d5, LSL #32
    MOVK  X18, #0x11d6, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X18, #0x78be, LSL #0
    MOVK  X18, #0x81e0, LSL #16
    MOVK  X18, #0x7e6a, LSL #32
    MOVK  X18, #0xadd6, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D6
    MOVZ  X18, #0xf875, LSL #0
    MOVK  X18, #0x9478, LSL #16
    MOVK  X18, #0x2c9b, LSL #32
    MOVK  X18, #0xad13, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x2a04, LSL #32
    MOVK  X18, #0xdfbc, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D7
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X18, #0x27d6, LSL #0
    MOVK  X18, #0x479, LSL #16
    MOVK  X18, #0xfa0f, LSL #32
    MOVK  X18, #0x4239, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D8
    MOVZ  X18, #0x4196, LSL #0
    MOVK  X18, #0xd964, LSL #16
    MOVK  X18, #0x293f, LSL #32
    MOVK  X18, #0x9d2, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X18, #0x9432, LSL #0
    MOVK  X18, #0x56d, LSL #16
    MOVK  X18, #0x79d6, LSL #32
    MOVK  X18, #0xee3a, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D9
    MOVZ  X18, #0xa490, LSL #0
    MOVK  X18, #0xa0de, LSL #16
    MOVK  X18, #0x8a13, LSL #32
    MOVK  X18, #0xa15c, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X18, #0x523a, LSL #0
    MOVK  X18, #0xb38d, LSL #16
    MOVK  X18, #0x735c, LSL #32
    MOVK  X18, #0xae82, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D10
    MOVZ  X18, #0x780d, LSL #0
    MOVK  X18, #0x6d2c, LSL #16
    MOVK  X18, #0xebe4, LSL #32
    MOVK  X18, #0xb6b, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X18, #0x13ac, LSL #0
    MOVK  X18, #0xb0c, LSL #16
    MOVK  X18, #0x3c1a, LSL #32
    MOVK  X18, #0xc29d, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D11
    MOVZ  X18, #0xb763, LSL #0
    MOVK  X18, #0x4e3b, LSL #16
    MOVK  X18, #0xe1d3, LSL #32
    MOVK  X18, #0xf82a, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X18, #0x6a0d, LSL #0
    MOVK  X18, #0x871f, LSL #16
    MOVK  X18, #0xd7b8, LSL #32
    MOVK  X18, #0x30c0, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D12
    MOVZ  X18, #0xcb4a, LSL #0
    MOVK  X18, #0xc349, LSL #16
    MOVK  X18, #0xda2f, LSL #32
    MOVK  X18, #0xba93, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X18, #0xa3c6, LSL #0
    MOVK  X18, #0x5c08, LSL #16
    MOVK  X18, #0x797b, LSL #32
    MOVK  X18, #0x4942, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D13
    MOVZ  X18, #0xe586, LSL #0
    MOVK  X18, #0x77c2, LSL #16
    MOVK  X18, #0x4c0d, LSL #32
    MOVK  X18, #0xa834, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X18, #0xa904, LSL #0
    MOVK  X18, #0x6cd0, LSL #16
    MOVK  X18, #0xde9d, LSL #32
    MOVK  X18, #0x6321, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D14
    MOVZ  X18, #0xca20, LSL #0
    MOVK  X18, #0x93a9, LSL #16
    MOVK  X18, #0xbdc9, LSL #32
    MOVK  X18, #0x918a, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D15
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X18, #0x713, LSL #0
    MOVK  X18, #0x61ed, LSL #16
    MOVK  X18, #0x669b, LSL #32
    MOVK  X18, #0xa378, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D16
    MOVZ  X18, #0x8fe2, LSL #0
    MOVK  X18, #0xa442, LSL #16
    MOVK  X18, #0xa94, LSL #32
    MOVK  X18, #0xcde8, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X18, #0x743f, LSL #0
    MOVK  X18, #0xfc5, LSL #16
    MOVK  X18, #0x747d, LSL #32
    MOVK  X18, #0x53d6, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D17
    MOVZ  X18, #0x574c, LSL #0
    MOVK  X18, #0x9591, LSL #16
    MOVK  X18, #0xba3a, LSL #32
    MOVK  X18, #0x6da9, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X18, #0xfb1, LSL #0
    MOVK  X18, #0xd3fb, LSL #16
    MOVK  X18, #0x8e88, LSL #32
    MOVK  X18, #0x664a, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D18
    MOVZ  X18, #0x624b, LSL #0
    MOVK  X18, #0x20fb, LSL #16
    MOVK  X18, #0xfb10, LSL #32
    MOVK  X18, #0x3c00, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X18, #0x6317, LSL #0
    MOVK  X18, #0x192, LSL #16
    MOVK  X18, #0xa496, LSL #32
    MOVK  X18, #0x1820, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D19
    MOVZ  X18, #0x8a39, LSL #0
    MOVK  X18, #0xe84b, LSL #16
    MOVK  X18, #0xda0f, LSL #32
    MOVK  X18, #0x5455, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X18, #0xaea9, LSL #0
    MOVK  X18, #0xf1eb, LSL #16
    MOVK  X18, #0xc363, LSL #32
    MOVK  X18, #0x6faa, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D20
    MOVZ  X18, #0xeea5, LSL #0
    MOVK  X18, #0xaf8c, LSL #16
    MOVK  X18, #0x6fcc, LSL #32
    MOVK  X18, #0xc47f, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X18, #0x6321, LSL #0
    MOVK  X18, #0x6544, LSL #16
    MOVK  X18, #0x8817, LSL #32
    MOVK  X18, #0x923b, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D21
    MOVZ  X18, #0xa99f, LSL #0
    MOVK  X18, #0x5136, LSL #16
    MOVK  X18, #0xe932, LSL #32
    MOVK  X18, #0xd3e8, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X18, #0x9e84, LSL #0
    MOVK  X18, #0x827c, LSL #16
    MOVK  X18, #0x1ab6, LSL #32
    MOVK  X18, #0xf58c, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D22
    MOVZ  X18, #0xbfcb, LSL #0
    MOVK  X18, #0x2c98, LSL #16
    MOVK  X18, #0x66c4, LSL #32
    MOVK  X18, #0xcdc1, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X18, #0xaf44, LSL #0
    MOVK  X18, #0x617c, LSL #16
    MOVK  X18, #0xca36, LSL #32
    MOVK  X18, #0xbe2d, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D23
    MOVZ  X18, #0xb61d, LSL #0
    MOVK  X18, #0xf9d7, LSL #16
    MOVK  X18, #0xed24, LSL #32
    MOVK  X18, #0xe1c5, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X18, #0x29a0, LSL #0
    MOVK  X18, #0xecd4, LSL #16
    MOVK  X18, #0x4cba, LSL #32
    MOVK  X18, #0x6703, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D24
    MOVZ  X18, #0x811c, LSL #0
    MOVK  X18, #0x8307, LSL #16
    MOVK  X18, #0xb0d5, LSL #32
    MOVK  X18, #0x928b, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X18, #0x3d13, LSL #0
    MOVK  X18, #0x1572, LSL #16
    MOVK  X18, #0xdd8, LSL #32
    MOVK  X18, #0x719c, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D25
    MOVZ  X18, #0x34c3, LSL #0
    MOVK  X18, #0xe611, LSL #16
    MOVK  X18, #0xd060, LSL #32
    MOVK  X18, #0x8cd6, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X18, #0x81ad, LSL #0
    MOVK  X18, #0x957, LSL #16
    MOVK  X18, #0xf1ff, LSL #32
    MOVK  X18, #0xe275, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D26
    MOVZ  X18, #0x441a, LSL #0
    MOVK  X18, #0xda3a, LSL #16
    MOVK  X18, #0x2ff7, LSL #32
    MOVK  X18, #0x7b1e, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X18, #0x5d6d, LSL #0
    MOVK  X18, #0x1e12, LSL #16
    MOVK  X18, #0xb87c, LSL #32
    MOVK  X18, #0x4a48, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D27
    MOVZ  X18, #0xad57, LSL #0
    MOVK  X18, #0x3538, LSL #16
    MOVK  X18, #0xf790, LSL #32
    MOVK  X18, #0x30f0, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X18, #0xb6cb, LSL #0
    MOVK  X18, #0xf5c3, LSL #16
    MOVK  X18, #0x15da, LSL #32
    MOVK  X18, #0xb5eb, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D28
    MOVZ  X18, #0x845b, LSL #0
    MOVK  X18, #0xc688, LSL #16
    MOVK  X18, #0xa0c, LSL #32
    MOVK  X18, #0xa764, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X18, #0x29a0, LSL #0
    MOVK  X18, #0xecd4, LSL #16
    MOVK  X18, #0x4cba, LSL #32
    MOVK  X18, #0x6703, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D29
    MOVZ  X18, #0x811c, LSL #0
    MOVK  X18, #0x8307, LSL #16
    MOVK  X18, #0xb0d5, LSL #32
    MOVK  X18, #0x928b, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X18, #0x6374, LSL #0
    MOVK  X18, #0x9dc4, LSL #16
    MOVK  X18, #0x17be, LSL #32
    MOVK  X18, #0x235b, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D30
    MOVZ  X18, #0xe258, LSL #0
    MOVK  X18, #0x373e, LSL #16
    MOVK  X18, #0xbf0, LSL #32
    MOVK  X18, #0x946c, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X18, #0xd985, LSL #0
    MOVK  X18, #0xb0bf, LSL #16
    MOVK  X18, #0xb2a9, LSL #32
    MOVK  X18, #0x7c02, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D31
    MOVZ  X18, #0x574c, LSL #0
    MOVK  X18, #0x9591, LSL #16
    MOVK  X18, #0xba3a, LSL #32
    MOVK  X18, #0x6da9, LSL #48
    SUB  X21, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X7
    FMOV  V0.D[1], X13
    FMOV  D1, X5
    FMOV  V1.D[1], X8
    FMOV  D2, X19
    FMOV  V2.D[1], X3
    FMOV  D3, X15
    FMOV  V3.D[1], X11
    FMOV  D4, X28
    FMOV  V4.D[1], X20
    FMOV  D5, X16
    FMOV  V5.D[1], X21
    FMOV  D6, X23
    FMOV  V6.D[1], X22
    FMOV  D7, X21
    FMOV  V7.D[1], X12
    FMOV  D8, X14
    FMOV  V8.D[1], X19
    FMOV  D9, X11
    FMOV  V9.D[1], X13
    FMOV  D10, X23
    FMOV  V10.D[1], X21
    FMOV  D11, X22
    FMOV  V11.D[1], X3
    FMOV  D12, X3
    FMOV  V12.D[1], X28
    FMOV  D13, X16
    FMOV  V13.D[1], X5
    FMOV  D14, X14
    FMOV  V14.D[1], X28
    FMOV  D15, X4
    FMOV  V15.D[1], X2
    FMOV  D16, X23
    FMOV  V16.D[1], X28
    FMOV  D17, X10
    FMOV  V17.D[1], X5
    FMOV  D18, X8
    FMOV  V18.D[1], X3
    FMOV  D19, X3
    FMOV  V19.D[1], X23
    FMOV  D20, X14
    FMOV  V20.D[1], X18
    FMOV  D21, X10
    FMOV  V21.D[1], X19
    FMOV  D22, X9
    FMOV  V22.D[1], X3
    FMOV  D23, X11
    FMOV  V23.D[1], X8
    FMOV  D24, X7
    FMOV  V24.D[1], X5
    FMOV  D25, X9
    FMOV  V25.D[1], X4
    FMOV  D26, X9
    FMOV  V26.D[1], X3
    FMOV  D27, X4
    FMOV  V27.D[1], X12
    FMOV  D28, X19
    FMOV  V28.D[1], X2
    FMOV  D29, X7
    FMOV  V29.D[1], X2
    FMOV  D30, X12
    FMOV  V30.D[1], X18
    FMOV  D31, X21
    FMOV  V31.D[1], X6
    MOVZ  X14, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_1:
    BCAX V2.16B, V22.16B, V23.16B, V29.16B
    SHA512SU1 V12.2D, V25.2D, V28.2D
    SHA512SU1 V30.2D, V4.2D, V19.2D
    SM3PARTW1 V4.4S, V31.4S, V12.4S
    XAR V21.2D, V30.2D, V24.2D, #0x1a
    SM3TT2B V14.4S, V5.4S, V21.S[0x0]
    SM3PARTW1 V2.4S, V4.4S, V14.4S
    SM3TT2B V23.4S, V2.4S, V4.S[0x3]
    SM4E V14.4S, V23.4S
    SM3TT2A V7.4S, V27.4S, V14.S[0x3]
    SM3TT2A V25.4S, V31.4S, V21.S[0x2]
    SM3TT1A V31.4S, V2.4S, V3.S[0x2]
    SM4EKEY V30.4S, V2.4S, V21.4S
    SM4E V19.4S, V13.4S
    EOR3 V2.16B, V30.16B, V5.16B, V19.16B
    SM4EKEY V28.4S, V31.4S, V2.4S
    SM4E V3.4S, V31.4S
    SHA512SU1 V23.2D, V10.2D, V27.2D
    SM3TT2A V24.4S, V6.4S, V18.S[0x1]
    SHA512SU1 V14.2D, V19.2D, V25.2D
    SM3TT1B V10.4S, V20.4S, V10.S[0x3]
    BCAX V25.16B, V21.16B, V25.16B, V12.16B
    XAR V13.2D, V29.2D, V22.2D, #0x32
    SM3PARTW2 V8.4S, V11.4S, V22.4S
    SM3TT2A V12.4S, V24.4S, V23.S[0x1]
    EOR3 V18.16B, V3.16B, V12.16B, V28.16B
    SHA512SU1 V22.2D, V8.2D, V25.2D
    EOR3 V3.16B, V16.16B, V27.16B, V18.16B
    SM3PARTW1 V11.4S, V7.4S, V16.4S
    EOR3 V11.16B, V22.16B, V3.16B, V11.16B
    SM3TT2A V21.4S, V11.4S, V24.S[0x2]
    SM3TT1B V25.4S, V21.4S, V8.S[0x1]
    SM4EKEY V16.4S, V8.4S, V25.4S
    SHA512SU1 V3.2D, V7.2D, V14.2D
    SM4E V6.4S, V3.4S
    SHA512H Q20, Q30, V10.2D
    SM3TT1B V22.4S, V13.4S, V14.S[0x0]
    SM4EKEY V12.4S, V20.4S, V5.4S
    SM4EKEY V21.4S, V18.4S, V16.4S
    XAR V13.2D, V12.2D, V12.2D, #0x1c
    SM3TT1A V28.4S, V21.4S, V31.S[0x3]
    BCAX V14.16B, V6.16B, V28.16B, V22.16B
    SHA512SU0 V11.2D, V5.2D
    SHA512SU1 V6.2D, V14.2D, V4.2D
    EOR3 V22.16B, V11.16B, V13.16B, V25.16B
    SM4EKEY V7.4S, V22.4S, V21.4S
    SM4E V24.4S, V30.4S
    EOR3 V9.16B, V1.16B, V29.16B, V24.16B
    SHA512H Q8, Q4, V19.2D
    SM3PARTW2 V31.4S, V10.4S, V15.4S
    SHA512SU0 V23.2D, V7.2D
    SM4EKEY V27.4S, V23.4S, V25.4S
    BCAX V21.16B, V11.16B, V1.16B, V27.16B
    SM4EKEY V3.4S, V24.4S, V17.4S
    EOR3 V27.16B, V19.16B, V7.16B, V27.16B
    SM3TT2A V22.4S, V6.4S, V27.S[0x2]
    SHA512SU1 V28.2D, V10.2D, V19.2D
    XAR V29.2D, V22.2D, V25.2D, #0x2e
    SM4E V13.4S, V21.4S
    SM4E V23.4S, V28.4S
    SM4EKEY V25.4S, V26.4S, V26.4S
    SM4EKEY V6.4S, V10.4S, V12.4S
    SHA512H2 Q31, Q8, V31.2D
    SM4E V26.4S, V21.4S
    SHA512H Q7, Q31, V25.2D
    SM3TT1B V15.4S, V23.4S, V26.S[0x3]
    SM3TT2A V31.4S, V6.4S, V3.S[0x1]
    SM3PARTW2 V1.4S, V13.4S, V7.4S
    SHA512SU0 V11.2D, V2.2D
    EOR3 V3.16B, V15.16B, V18.16B, V15.16B
    SM3PARTW2 V6.4S, V29.4S, V31.4S
    SHA512SU0 V12.2D, V3.2D
    SM3TT1B V22.4S, V3.4S, V6.S[0x3]
    BCAX V10.16B, V11.16B, V1.16B, V29.16B
    SM3PARTW1 V21.4S, V22.4S, V22.4S
    SM3PARTW1 V19.4S, V31.4S, V17.4S
    SM4EKEY V1.4S, V19.4S, V24.4S
    SM4EKEY V23.4S, V21.4S, V20.4S
    SM4E V6.4S, V1.4S
    SM3TT2B V28.4S, V12.4S, V12.S[0x3]
    SHA512SU1 V5.2D, V8.2D, V10.2D
    SM3TT2B V27.4S, V12.4S, V5.S[0x1]
    BCAX V10.16B, V28.16B, V29.16B, V27.16B
    SM3TT2A V5.4S, V23.4S, V15.S[0x2]
    SM3TT1A V12.4S, V6.4S, V6.S[0x0]
    SM4EKEY V0.4S, V31.4S, V10.4S
    SM4EKEY V11.4S, V0.4S, V9.4S
    SM3TT1A V7.4S, V12.4S, V31.S[0x0]
    RAX1 V12.2D, V5.2D, V27.2D
    SHA512H Q18, Q6, V5.2D
    SHA512H2 Q28, Q0, V11.2D
    SM3TT1A V3.4S, V25.4S, V19.S[0x3]
    SHA512SU1 V27.2D, V6.2D, V28.2D
    RAX1 V11.2D, V12.2D, V1.2D
    SM4E V29.4S, V0.4S
    BCAX V23.16B, V17.16B, V7.16B, V18.16B
    SM3TT2A V9.4S, V3.4S, V14.S[0x2]
    SHA512SU1 V20.2D, V27.2D, V29.2D
    BCAX V29.16B, V20.16B, V3.16B, V17.16B
    SM3TT1B V6.4S, V29.4S, V27.S[0x2]
    SM3TT1A V21.4S, V9.4S, V6.S[0x3]
    RAX1 V28.2D, V23.2D, V23.2D
    SHA512SU0 V22.2D, V1.2D
    SM4EKEY V1.4S, V22.4S, V5.4S
    EOR3 V16.16B, V11.16B, V21.16B, V21.16B
    XAR V25.2D, V13.2D, V28.2D, #0x12
    SM3TT2A V0.4S, V12.4S, V25.S[0x2]
    EOR3 V12.16B, V16.16B, V4.16B, V19.16B
    SM3TT1A V17.4S, V12.4S, V12.S[0x0]
    SM4EKEY V25.4S, V14.4S, V7.4S
    BCAX V15.16B, V17.16B, V0.16B, V0.16B
    SM4EKEY V12.4S, V14.4S, V1.4S
    EOR3 V5.16B, V15.16B, V18.16B, V15.16B
    SM4EKEY V18.4S, V13.4S, V12.4S
    SM4E V17.4S, V7.4S
    SHA512H Q9, Q25, V1.2D
    SM3TT1B V22.4S, V9.4S, V18.S[0x2]
    SM4EKEY V14.4S, V22.4S, V22.4S
    SM3TT2A V14.4S, V30.4S, V31.S[0x3]
    SHA512SU1 V20.2D, V14.2D, V17.2D
    SHA512SU0 V1.2D, V2.2D
    SM3TT2A V23.4S, V20.4S, V26.S[0x3]
    BCAX V19.16B, V7.16B, V4.16B, V0.16B
    XAR V4.2D, V25.2D, V6.2D, #0x38
    BCAX V20.16B, V1.16B, V30.16B, V22.16B
    SHA512SU0 V17.2D, V0.2D
    RAX1 V16.2D, V17.2D, V13.2D
    BCAX V9.16B, V25.16B, V13.16B, V13.16B
    SM3PARTW1 V19.4S, V5.4S, V5.4S
    BCAX V18.16B, V20.16B, V6.16B, V29.16B
    SM3TT1A V2.4S, V12.4S, V16.S[0x3]
    XAR V13.2D, V20.2D, V25.2D, #0x20
    SM4E V6.4S, V6.4S
    SM4EKEY V14.4S, V13.4S, V4.4S
    SHA512SU0 V22.2D, V7.2D
    SM3TT2A V31.4S, V6.4S, V9.S[0x3]
    RAX1 V6.2D, V25.2D, V22.2D
    SHA512SU1 V12.2D, V30.2D, V23.2D
    SM4EKEY V9.4S, V29.4S, V9.4S
    SM4E V16.4S, V14.4S
    SM4E V7.4S, V17.4S
    SM3PARTW2 V5.4S, V6.4S, V9.4S
    SHA512H2 Q13, Q7, V12.2D
    SM4EKEY V21.4S, V13.4S, V5.4S
    RAX1 V1.2D, V8.2D, V30.2D
    SHA512H2 Q14, Q18, V31.2D
    SM3PARTW2 V7.4S, V21.4S, V21.4S
    SHA512SU1 V31.2D, V28.2D, V19.2D
    SM4EKEY V17.4S, V25.4S, V21.4S
    SM3TT2B V5.4S, V14.4S, V12.S[0x3]
    SHA512SU0 V8.2D, V7.2D
    EOR3 V19.16B, V1.16B, V16.16B, V2.16B
    SHA512SU1 V22.2D, V28.2D, V28.2D
    EOR3 V28.16B, V31.16B, V19.16B, V9.16B
    XAR V12.2D, V8.2D, V17.2D, #0xf
    SM4E V10.4S, V5.4S
    SM3PARTW1 V20.4S, V22.4S, V10.4S
    XAR V10.2D, V9.2D, V13.2D, #0x17
    SHA512H Q6, Q10, V20.2D
    SM3SS1 V30.4S, V6.4S, V12.4S, V29.4S
    SM3TT2A V25.4S, V0.4S, V28.S[0x1]
    SM4E V7.4S, V17.4S
    SM4EKEY V28.4S, V9.4S, V11.4S
    SHA512SU1 V31.2D, V18.2D, V2.2D
    RAX1 V21.2D, V11.2D, V12.2D
    SM4E V22.4S, V14.4S
    XAR V2.2D, V14.2D, V23.2D, #0x3b
    SHA512H2 Q0, Q5, V22.2D
    SM4E V23.4S, V2.4S
    BCAX V10.16B, V19.16B, V22.16B, V25.16B
    EOR3 V8.16B, V28.16B, V3.16B, V21.16B
    SM3SS1 V2.4S, V1.4S, V15.4S, V13.4S
    SM4E V6.4S, V0.4S
    SHA512SU0 V25.2D, V18.2D
    RAX1 V29.2D, V14.2D, V9.2D
    RAX1 V15.2D, V14.2D, V10.2D
    SHA512SU0 V11.2D, V30.2D
    SM3PARTW2 V1.4S, V31.4S, V31.4S
    SM3PARTW1 V30.4S, V7.4S, V0.4S
    SM4E V0.4S, V1.4S
    XAR V3.2D, V23.2D, V23.2D, #0x23
    SHA512SU0 V18.2D, V0.2D
    SHA512SU1 V10.2D, V7.2D, V2.2D
    SM3TT2B V1.4S, V30.4S, V29.S[0x0]
    SM3TT1B V7.4S, V11.4S, V15.S[0x3]
    SM3PARTW1 V13.4S, V1.4S, V28.4S
    SM4E V25.4S, V29.4S
    SM3PARTW2 V14.4S, V8.4S, V19.4S
    XAR V30.2D, V3.2D, V3.2D, #0x0
    SM4E V2.4S, V7.4S
    SM3TT1B V9.4S, V10.4S, V18.S[0x3]
    RAX1 V31.2D, V19.2D, V26.2D
    SHA512SU0 V19.2D, V13.2D
    RAX1 V22.2D, V9.2D, V4.2D
    EOR3 V4.16B, V15.16B, V25.16B, V25.16B
    SHA512SU0 V26.2D, V22.2D
    RAX1 V29.2D, V6.2D, V2.2D
    SM3TT1A V2.4S, V5.4S, V25.S[0x0]
    SM4E V3.4S, V26.4S
    SHA512H Q6, Q26, V23.2D
    SUBS  X14, X14, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_1
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X9, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X11, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X9, #0xfd2, LSL #0
    MOVK  X9, #0x7130, LSL #16
    MOVK  X9, #0x842c, LSL #32
    MOVK  X9, #0xf606, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D0
    MOVZ  X9, #0x7f33, LSL #0
    MOVK  X9, #0x10de, LSL #16
    MOVK  X9, #0x4d19, LSL #32
    MOVK  X9, #0x7b76, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X9, #0x441e, LSL #0
    MOVK  X9, #0x72d3, LSL #16
    MOVK  X9, #0x181f, LSL #32
    MOVK  X9, #0x4f44, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D1
    MOVZ  X9, #0x369f, LSL #0
    MOVK  X9, #0x8323, LSL #16
    MOVK  X9, #0x379f, LSL #32
    MOVK  X9, #0x2416, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X9, #0x5bb, LSL #0
    MOVK  X9, #0x4c4, LSL #16
    MOVK  X9, #0xf403, LSL #32
    MOVK  X9, #0xb136, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D2
    MOVZ  X9, #0xb524, LSL #0
    MOVK  X9, #0x1651, LSL #16
    MOVK  X9, #0x4383, LSL #32
    MOVK  X9, #0x2cb9, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X9, #0x8ad1, LSL #0
    MOVK  X9, #0x438, LSL #16
    MOVK  X9, #0xfbce, LSL #32
    MOVK  X9, #0x5e54, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D3
    MOVZ  X9, #0xc6dc, LSL #0
    MOVK  X9, #0x48f3, LSL #16
    MOVK  X9, #0xa39a, LSL #32
    MOVK  X9, #0xb402, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X9, #0x713a, LSL #0
    MOVK  X9, #0xf085, LSL #16
    MOVK  X9, #0xc9ea, LSL #32
    MOVK  X9, #0x3b24, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D4
    MOVZ  X9, #0x5ab1, LSL #0
    MOVK  X9, #0xd5b3, LSL #16
    MOVK  X9, #0x5715, LSL #32
    MOVK  X9, #0x64e1, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X9, #0x9a64, LSL #0
    MOVK  X9, #0x2b1f, LSL #16
    MOVK  X9, #0x769, LSL #32
    MOVK  X9, #0xb2d1, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D5
    MOVZ  X9, #0xcf3, LSL #0
    MOVK  X9, #0x349b, LSL #16
    MOVK  X9, #0x682d, LSL #32
    MOVK  X9, #0x2029, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X9, #0x99a6, LSL #0
    MOVK  X9, #0x91e9, LSL #16
    MOVK  X9, #0xd06c, LSL #32
    MOVK  X9, #0xe71a, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D6
    MOVZ  X9, #0x5668, LSL #0
    MOVK  X9, #0xba6a, LSL #16
    MOVK  X9, #0x1ee3, LSL #32
    MOVK  X9, #0xbd01, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X9, #0xdcc7, LSL #0
    MOVK  X9, #0x4d6d, LSL #16
    MOVK  X9, #0x9fbb, LSL #32
    MOVK  X9, #0xb1c7, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D7
    MOVZ  X9, #0x91f9, LSL #0
    MOVK  X9, #0xf28f, LSL #16
    MOVK  X9, #0x3572, LSL #32
    MOVK  X9, #0xf154, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X9, #0xa4be, LSL #0
    MOVK  X9, #0x9b21, LSL #16
    MOVK  X9, #0x71e7, LSL #32
    MOVK  X9, #0xe728, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D8
    MOVZ  X9, #0x1333, LSL #0
    MOVK  X9, #0xd7b, LSL #16
    MOVK  X9, #0xf015, LSL #32
    MOVK  X9, #0x1ce, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X9, #0x759c, LSL #0
    MOVK  X9, #0x638a, LSL #16
    MOVK  X9, #0xe1f4, LSL #32
    MOVK  X9, #0x26f0, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D9
    MOVZ  X9, #0x21d4, LSL #0
    MOVK  X9, #0xa1e9, LSL #16
    MOVK  X9, #0xe0e8, LSL #32
    MOVK  X9, #0xd4a5, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X9, #0x65c7, LSL #0
    MOVK  X9, #0xce01, LSL #16
    MOVK  X9, #0xb57f, LSL #32
    MOVK  X9, #0x68ca, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D10
    MOVZ  X9, #0x78ff, LSL #0
    MOVK  X9, #0xe2d5, LSL #16
    MOVK  X9, #0xdca4, LSL #32
    MOVK  X9, #0xd9f0, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X9, #0x5724, LSL #0
    MOVK  X9, #0x34bb, LSL #16
    MOVK  X9, #0x766d, LSL #32
    MOVK  X9, #0x873, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D11
    MOVZ  X9, #0xd911, LSL #0
    MOVK  X9, #0x55a8, LSL #16
    MOVK  X9, #0xdecb, LSL #32
    MOVK  X9, #0x8291, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X9, #0xe33b, LSL #0
    MOVK  X9, #0xc6ef, LSL #16
    MOVK  X9, #0xca2, LSL #32
    MOVK  X9, #0x2050, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D12
    MOVZ  X9, #0x858, LSL #0
    MOVK  X9, #0x9364, LSL #16
    MOVK  X9, #0x4a1, LSL #32
    MOVK  X9, #0x154a, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X9, #0xe7e3, LSL #0
    MOVK  X9, #0xe1bf, LSL #16
    MOVK  X9, #0xc462, LSL #32
    MOVK  X9, #0x3110, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D13
    MOVZ  X9, #0x1df6, LSL #0
    MOVK  X9, #0xbfc, LSL #16
    MOVK  X9, #0xa9a5, LSL #32
    MOVK  X9, #0x5089, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X9, #0xbc17, LSL #0
    MOVK  X9, #0xb3b6, LSL #16
    MOVK  X9, #0x8d08, LSL #32
    MOVK  X9, #0x6c29, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D14
    MOVZ  X9, #0xcc84, LSL #0
    MOVK  X9, #0xd610, LSL #16
    MOVK  X9, #0xbb15, LSL #32
    MOVK  X9, #0x8b4d, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X9, #0x713a, LSL #0
    MOVK  X9, #0xf085, LSL #16
    MOVK  X9, #0xc9ea, LSL #32
    MOVK  X9, #0x3b24, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D15
    MOVZ  X9, #0x5ab1, LSL #0
    MOVK  X9, #0xd5b3, LSL #16
    MOVK  X9, #0x5715, LSL #32
    MOVK  X9, #0x64e1, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X9, #0x3332, LSL #0
    MOVK  X9, #0x8832, LSL #16
    MOVK  X9, #0x2d4b, LSL #32
    MOVK  X9, #0x388e, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D16
    MOVZ  X9, #0x1c09, LSL #0
    MOVK  X9, #0xce83, LSL #16
    MOVK  X9, #0xfe01, LSL #32
    MOVK  X9, #0x77b9, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X9, #0x9d70, LSL #0
    MOVK  X9, #0x94d1, LSL #16
    MOVK  X9, #0xd044, LSL #32
    MOVK  X9, #0x51a8, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D17
    MOVZ  X9, #0x711b, LSL #0
    MOVK  X9, #0x491c, LSL #16
    MOVK  X9, #0xdb90, LSL #32
    MOVK  X9, #0xc18e, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X9, #0x84d8, LSL #0
    MOVK  X9, #0x8115, LSL #16
    MOVK  X9, #0x3da1, LSL #32
    MOVK  X9, #0x7e65, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D18
    MOVZ  X9, #0x8eb1, LSL #0
    MOVK  X9, #0x424d, LSL #16
    MOVK  X9, #0x1db0, LSL #32
    MOVK  X9, #0xd107, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X9, #0xb2f, LSL #0
    MOVK  X9, #0x59af, LSL #16
    MOVK  X9, #0xfbc5, LSL #32
    MOVK  X9, #0x56b3, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D19
    MOVZ  X9, #0x910f, LSL #0
    MOVK  X9, #0x6928, LSL #16
    MOVK  X9, #0x8d44, LSL #32
    MOVK  X9, #0x7766, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X9, #0x2efa, LSL #0
    MOVK  X9, #0xd2e7, LSL #16
    MOVK  X9, #0x9554, LSL #32
    MOVK  X9, #0x55ff, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D20
    MOVZ  X9, #0x2074, LSL #0
    MOVK  X9, #0x1f09, LSL #16
    MOVK  X9, #0xc0ae, LSL #32
    MOVK  X9, #0x5f88, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X9, #0x9152, LSL #0
    MOVK  X9, #0xb964, LSL #16
    MOVK  X9, #0x6f28, LSL #32
    MOVK  X9, #0x48d3, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D21
    MOVZ  X9, #0x6216, LSL #0
    MOVK  X9, #0xe60, LSL #16
    MOVK  X9, #0xb95c, LSL #32
    MOVK  X9, #0x48e4, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X9, #0x309a, LSL #0
    MOVK  X9, #0xbc7, LSL #16
    MOVK  X9, #0x5978, LSL #32
    MOVK  X9, #0xe3df, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D22
    MOVZ  X9, #0x1fd7, LSL #0
    MOVK  X9, #0xa06c, LSL #16
    MOVK  X9, #0x42f, LSL #32
    MOVK  X9, #0xb09c, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X9, #0x837f, LSL #0
    MOVK  X9, #0x217b, LSL #16
    MOVK  X9, #0xce93, LSL #32
    MOVK  X9, #0xbb4a, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D23
    MOVZ  X9, #0x9019, LSL #0
    MOVK  X9, #0xaf99, LSL #16
    MOVK  X9, #0x1537, LSL #32
    MOVK  X9, #0xfb69, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X9, #0x7b6d, LSL #0
    MOVK  X9, #0xa022, LSL #16
    MOVK  X9, #0x96dc, LSL #32
    MOVK  X9, #0x31f9, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D24
    MOVZ  X9, #0xae95, LSL #0
    MOVK  X9, #0xe25c, LSL #16
    MOVK  X9, #0xe297, LSL #32
    MOVK  X9, #0xab45, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X9, #0xed4, LSL #0
    MOVK  X9, #0x8c97, LSL #16
    MOVK  X9, #0xf221, LSL #32
    MOVK  X9, #0x4e25, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D25
    MOVZ  X9, #0xe251, LSL #0
    MOVK  X9, #0x7504, LSL #16
    MOVK  X9, #0x2c51, LSL #32
    MOVK  X9, #0x231e, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X9, #0xf896, LSL #0
    MOVK  X9, #0x783d, LSL #16
    MOVK  X9, #0xeb3b, LSL #32
    MOVK  X9, #0xb1ba, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D26
    MOVZ  X9, #0x25a3, LSL #0
    MOVK  X9, #0xe7fc, LSL #16
    MOVK  X9, #0xb43f, LSL #32
    MOVK  X9, #0x2df4, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X9, #0x7860, LSL #0
    MOVK  X9, #0x13ac, LSL #16
    MOVK  X9, #0xe82e, LSL #32
    MOVK  X9, #0xd555, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D27
    MOVZ  X9, #0x9537, LSL #0
    MOVK  X9, #0xd50b, LSL #16
    MOVK  X9, #0x5d92, LSL #32
    MOVK  X9, #0xe88c, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X9, #0x6f99, LSL #0
    MOVK  X9, #0xcb31, LSL #16
    MOVK  X9, #0xd23c, LSL #32
    MOVK  X9, #0xf7b1, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D28
    MOVZ  X9, #0xd4f, LSL #0
    MOVK  X9, #0x9643, LSL #16
    MOVK  X9, #0xfee9, LSL #32
    MOVK  X9, #0xd78a, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X9, #0x8e6e, LSL #0
    MOVK  X9, #0x611b, LSL #16
    MOVK  X9, #0x678f, LSL #32
    MOVK  X9, #0x11f0, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D29
    MOVZ  X9, #0x2515, LSL #0
    MOVK  X9, #0x8fa7, LSL #16
    MOVK  X9, #0xfd44, LSL #32
    MOVK  X9, #0x627a, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D30
    MOVZ  X9, #0x0, LSL #0
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X9, #0x79c5, LSL #0
    MOVK  X9, #0x4003, LSL #16
    MOVK  X9, #0x27a3, LSL #32
    MOVK  X9, #0x31c8, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D31
    MOVZ  X9, #0x64e0, LSL #0
    MOVK  X9, #0xaeb1, LSL #16
    MOVK  X9, #0x71f5, LSL #32
    MOVK  X9, #0x28e7, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X21
    FMOV  D1, X20
    FMOV  V1.D[1], X19
    FMOV  D2, X23
    FMOV  V2.D[1], X28
    FMOV  D3, X7
    FMOV  V3.D[1], X10
    FMOV  D4, X22
    FMOV  V4.D[1], X7
    FMOV  D5, X5
    FMOV  V5.D[1], X22
    FMOV  D6, X11
    FMOV  V6.D[1], X11
    FMOV  D7, X19
    FMOV  V7.D[1], X16
    FMOV  D8, X22
    FMOV  V8.D[1], X7
    FMOV  D9, X3
    FMOV  V9.D[1], X22
    FMOV  D10, X20
    FMOV  V10.D[1], X23
    FMOV  D11, X6
    FMOV  V11.D[1], X18
    FMOV  D12, X2
    FMOV  V12.D[1], X6
    FMOV  D13, X6
    FMOV  V13.D[1], X16
    FMOV  D14, X16
    FMOV  V14.D[1], X14
    FMOV  D15, X21
    FMOV  V15.D[1], X8
    FMOV  D16, X23
    FMOV  V16.D[1], X17
    FMOV  D17, X2
    FMOV  V17.D[1], X9
    FMOV  D18, X3
    FMOV  V18.D[1], X15
    FMOV  D19, X7
    FMOV  V19.D[1], X10
    FMOV  D20, X15
    FMOV  V20.D[1], X20
    FMOV  D21, X2
    FMOV  V21.D[1], X20
    FMOV  D22, X9
    FMOV  V22.D[1], X17
    FMOV  D23, X22
    FMOV  V23.D[1], X10
    FMOV  D24, X14
    FMOV  V24.D[1], X11
    FMOV  D25, X19
    FMOV  V25.D[1], X6
    FMOV  D26, X15
    FMOV  V26.D[1], X6
    FMOV  D27, X13
    FMOV  V27.D[1], X17
    FMOV  D28, X28
    FMOV  V28.D[1], X28
    FMOV  D29, X10
    FMOV  V29.D[1], X8
    FMOV  D30, X9
    FMOV  V30.D[1], X10
    FMOV  D31, X20
    FMOV  V31.D[1], X18
    MOVZ  X15, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_2:
    SHA512H Q0, Q1, V25.2D
    SHA512SU0 V4.2D, V0.2D
    XAR V28.2D, V4.2D, V29.2D, #0x24
    SM4EKEY V25.4S, V27.4S, V22.4S
    SHA512H Q5, Q28, V8.2D
    SHA512SU0 V31.2D, V23.2D
    BCAX V18.16B, V31.16B, V5.16B, V31.16B
    SM3PARTW1 V7.4S, V23.4S, V9.4S
    SM4EKEY V2.4S, V30.4S, V26.4S
    RAX1 V28.2D, V28.2D, V15.2D
    SM3TT2B V15.4S, V26.4S, V7.S[0x3]
    SHA512H Q8, Q25, V28.2D
    SM3PARTW1 V5.4S, V8.4S, V18.4S
    SHA512H2 Q0, Q15, V24.2D
    SM3TT2B V25.4S, V21.4S, V14.S[0x0]
    SM3TT2A V1.4S, V5.4S, V21.S[0x1]
    SM4E V26.4S, V0.4S
    SM3TT1A V21.4S, V26.4S, V26.S[0x1]
    SM3PARTW1 V27.4S, V2.4S, V1.4S
    SM4E V5.4S, V27.4S
    SM4E V7.4S, V31.4S
    SHA512SU1 V28.2D, V19.2D, V8.2D
    SHA512SU1 V0.2D, V7.2D, V28.2D
    XAR V19.2D, V5.2D, V5.2D, #0x17
    SHA512H2 Q5, Q21, V25.2D
    SM3TT1A V8.4S, V5.4S, V5.S[0x2]
    SHA512H Q24, Q8, V4.2D
    SM3TT2B V14.4S, V9.4S, V29.S[0x3]
    BCAX V31.16B, V24.16B, V9.16B, V0.16B
    SM4E V21.4S, V31.4S
    SHA512SU0 V27.2D, V4.2D
    SM4E V7.4S, V21.4S
    SHA512SU0 V25.2D, V19.2D
    RAX1 V31.2D, V20.2D, V24.2D
    RAX1 V28.2D, V25.2D, V8.2D
    SM3PARTW1 V9.4S, V28.4S, V7.4S
    SHA512SU0 V1.2D, V5.2D
    SM3TT1A V9.4S, V1.4S, V29.S[0x1]
    SHA512H2 Q27, Q31, V14.2D
    SM3PARTW1 V13.4S, V9.4S, V15.4S
    SHA512H2 Q3, Q6, V20.2D
    SM4EKEY V20.4S, V30.4S, V1.4S
    SHA512H Q14, Q30, V15.2D
    EOR3 V3.16B, V9.16B, V5.16B, V13.16B
    SM3TT1B V9.4S, V22.4S, V9.S[0x0]
    BCAX V24.16B, V3.16B, V17.16B, V16.16B
    BCAX V8.16B, V29.16B, V26.16B, V9.16B
    SM3PARTW2 V20.4S, V10.4S, V15.4S
    SM4EKEY V19.4S, V14.4S, V7.4S
    SM3PARTW1 V13.4S, V8.4S, V27.4S
    SM4EKEY V9.4S, V13.4S, V6.4S
    SHA512SU0 V26.2D, V19.2D
    SM3PARTW1 V16.4S, V30.4S, V3.4S
    BCAX V30.16B, V13.16B, V14.16B, V5.16B
    SM4EKEY V8.4S, V31.4S, V1.4S
    SHA512H Q27, Q23, V25.2D
    SHA512H2 Q21, Q20, V18.2D
    XAR V1.2D, V0.2D, V22.2D, #0x3
    SM3TT2B V15.4S, V9.4S, V9.S[0x3]
    SM3TT2A V31.4S, V27.4S, V1.S[0x1]
    SM4E V31.4S, V1.4S
    SM4EKEY V3.4S, V30.4S, V26.4S
    SHA512SU0 V9.2D, V31.2D
    SM4EKEY V6.4S, V3.4S, V18.4S
    SHA512H2 Q13, Q9, V15.2D
    XAR V26.2D, V8.2D, V10.2D, #0x0
    SM3TT1A V25.4S, V18.4S, V21.S[0x3]
    SM4E V0.4S, V25.4S
    SHA512H2 Q14, Q0, V24.2D
    SM4E V7.4S, V18.4S
    SHA512H2 Q30, Q26, V26.2D
    SHA512H2 Q31, Q16, V7.2D
    SHA512H2 Q12, Q3, V4.2D
    SM4EKEY V10.4S, V6.4S, V14.4S
    SM4E V8.4S, V12.4S
    SM4E V16.4S, V13.4S
    BCAX V24.16B, V6.16B, V31.16B, V30.16B
    SM3TT2B V4.4S, V19.4S, V10.S[0x2]
    SM3TT2A V7.4S, V14.4S, V8.S[0x2]
    SM4E V26.4S, V21.4S
    XAR V22.2D, V4.2D, V3.2D, #0x30
    SHA512SU0 V17.2D, V14.2D
    SM3TT1A V13.4S, V24.4S, V26.S[0x2]
    SHA512SU0 V19.2D, V22.2D
    EOR3 V8.16B, V16.16B, V7.16B, V7.16B
    SHA512SU1 V8.2D, V8.2D, V17.2D
    SHA512H Q25, Q3, V8.2D
    SM3SS1 V10.4S, V11.4S, V19.4S, V13.4S
    SM3TT2B V29.4S, V16.4S, V15.S[0x1]
    SM3PARTW1 V11.4S, V20.4S, V15.4S
    SHA512SU0 V1.2D, V20.2D
    SM4E V4.4S, V21.4S
    SHA512H Q20, Q4, V16.2D
    SM3TT2B V30.4S, V6.4S, V17.S[0x0]
    SM4E V4.4S, V5.4S
    SM4E V26.4S, V28.4S
    EOR3 V16.16B, V20.16B, V2.16B, V23.16B
    SM4E V15.4S, V2.4S
    SM4EKEY V28.4S, V11.4S, V13.4S
    RAX1 V22.2D, V26.2D, V26.2D
    SM4EKEY V26.4S, V29.4S, V28.4S
    SM3TT2B V6.4S, V9.4S, V30.S[0x2]
    EOR3 V13.16B, V22.16B, V4.16B, V19.16B
    SM3TT1B V31.4S, V26.4S, V7.S[0x0]
    SM3TT2B V28.4S, V6.4S, V10.S[0x3]
    SHA512SU0 V2.2D, V4.2D
    BCAX V29.16B, V28.16B, V31.16B, V15.16B
    SM4E V4.4S, V29.4S
    SM4E V6.4S, V8.4S
    SHA512H2 Q17, Q2, V4.2D
    SHA512SU1 V23.2D, V25.2D, V1.2D
    BCAX V1.16B, V8.16B, V23.16B, V17.16B
    RAX1 V31.2D, V8.2D, V6.2D
    SM3TT1B V2.4S, V16.4S, V4.S[0x0]
    SHA512H Q12, Q13, V31.2D
    XAR V16.2D, V1.2D, V12.2D, #0x3f
    SHA512SU1 V22.2D, V4.2D, V8.2D
    EOR3 V13.16B, V10.16B, V22.16B, V22.16B
    EOR3 V6.16B, V17.16B, V15.16B, V3.16B
    BCAX V11.16B, V1.16B, V11.16B, V31.16B
    SM4EKEY V30.4S, V31.4S, V25.4S
    RAX1 V29.2D, V13.2D, V1.2D
    XAR V31.2D, V14.2D, V4.2D, #0x3a
    SM4E V14.4S, V15.4S
    EOR3 V17.16B, V19.16B, V25.16B, V8.16B
    BCAX V8.16B, V27.16B, V0.16B, V6.16B
    SHA512H Q6, Q30, V1.2D
    SM4E V27.4S, V29.4S
    SM3SS1 V15.4S, V8.4S, V17.4S, V2.4S
    RAX1 V4.2D, V27.2D, V6.2D
    SHA512H Q7, Q26, V11.2D
    SM4EKEY V22.4S, V16.4S, V8.4S
    SHA512H Q17, Q31, V9.2D
    RAX1 V6.2D, V4.2D, V17.2D
    SM4EKEY V28.4S, V7.4S, V22.4S
    SM4E V10.4S, V12.4S
    SM3TT1B V25.4S, V27.4S, V15.S[0x1]
    SM4EKEY V13.4S, V6.4S, V25.4S
    SHA512H Q23, Q3, V13.2D
    SM4E V27.4S, V10.4S
    XAR V10.2D, V27.2D, V27.2D, #0x23
    SM3SS1 V11.4S, V28.4S, V22.4S, V21.4S
    SM3PARTW1 V4.4S, V1.4S, V29.4S
    SHA512SU1 V12.2D, V22.2D, V23.2D
    SM3SS1 V1.4S, V10.4S, V14.4S, V11.4S
    SM3PARTW1 V29.4S, V1.4S, V19.4S
    RAX1 V10.2D, V9.2D, V4.2D
    SM4EKEY V9.4S, V10.4S, V30.4S
    SM3PARTW1 V14.4S, V9.4S, V29.4S
    SHA512H2 Q29, Q20, V28.2D
    SHA512H Q11, Q4, V21.2D
    SM3TT2B V6.4S, V9.4S, V27.S[0x0]
    XAR V20.2D, V19.2D, V17.2D, #0x19
    EOR3 V17.16B, V21.16B, V27.16B, V15.16B
    SHA512H2 Q21, Q31, V26.2D
    SM4EKEY V9.4S, V23.4S, V15.4S
    SM4EKEY V13.4S, V11.4S, V19.4S
    BCAX V26.16B, V12.16B, V19.16B, V29.16B
    SHA512H Q31, Q26, V17.2D
    SHA512H2 Q22, Q31, V28.2D
    SM4EKEY V22.4S, V31.4S, V29.4S
    SM3TT1B V1.4S, V13.4S, V13.S[0x2]
    SHA512H2 Q11, Q1, V14.2D
    SM4E V11.4S, V6.4S
    XAR V4.2D, V9.2D, V9.2D, #0x30
    SHA512H2 Q10, Q21, V22.2D
    SM3SS1 V1.4S, V27.4S, V11.4S, V10.4S
    SM4EKEY V28.4S, V20.4S, V25.4S
    SM3TT2A V12.4S, V1.4S, V1.S[0x0]
    SM4E V6.4S, V12.4S
    SM4E V10.4S, V28.4S
    EOR3 V29.16B, V3.16B, V10.16B, V6.16B
    SM3TT1B V11.4S, V24.4S, V25.S[0x3]
    SM4EKEY V23.4S, V28.4S, V29.4S
    SHA512H2 Q9, Q24, V10.2D
    RAX1 V21.2D, V24.2D, V8.2D
    SM3SS1 V25.4S, V30.4S, V26.4S, V29.4S
    SM3TT2B V20.4S, V13.4S, V2.S[0x1]
    SM3TT1A V1.4S, V9.4S, V25.S[0x1]
    SM3TT2A V13.4S, V13.4S, V14.S[0x0]
    SM4E V27.4S, V14.4S
    EOR3 V0.16B, V19.16B, V22.16B, V30.16B
    SM4EKEY V6.4S, V21.4S, V28.4S
    SHA512H Q21, Q4, V11.2D
    SM4E V12.4S, V21.4S
    SM3TT2A V11.4S, V10.4S, V27.S[0x0]
    XAR V19.2D, V11.2D, V0.2D, #0x33
    RAX1 V23.2D, V12.2D, V19.2D
    XAR V21.2D, V20.2D, V13.2D, #0x1b
    SM4E V3.4S, V1.4S
    SHA512H Q27, Q17, V3.2D
    BCAX V14.16B, V23.16B, V27.16B, V13.16B
    SM4EKEY V24.4S, V29.4S, V6.4S
    SM3SS1 V28.4S, V14.4S, V21.4S, V21.4S
    SM3PARTW1 V9.4S, V23.4S, V28.4S
    SM3TT1A V18.4S, V22.4S, V26.S[0x2]
    RAX1 V4.2D, V21.2D, V28.2D
    BCAX V14.16B, V22.16B, V31.16B, V2.16B
    SHA512H2 Q11, Q5, V4.2D
    RAX1 V13.2D, V23.2D, V23.2D
    SUBS  X15, X15, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_2
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0x0, LSL #0
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    SUB  X11, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X20, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X11, #0x7c4f, LSL #0
    MOVK  X11, #0x2cd6, LSL #16
    MOVK  X11, #0x8777, LSL #32
    MOVK  X11, #0xd3dd, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D0
    MOVZ  X11, #0xd45f, LSL #0
    MOVK  X11, #0x54c, LSL #16
    MOVK  X11, #0xed53, LSL #32
    MOVK  X11, #0x115c, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X11, #0xe541, LSL #0
    MOVK  X11, #0x94c5, LSL #16
    MOVK  X11, #0xf937, LSL #32
    MOVK  X11, #0xeb6f, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D1
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X11, #0x294c, LSL #0
    MOVK  X11, #0x529b, LSL #16
    MOVK  X11, #0xc42, LSL #32
    MOVK  X11, #0xd200, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D2
    MOVZ  X11, #0xd005, LSL #0
    MOVK  X11, #0xabe7, LSL #16
    MOVK  X11, #0x26ab, LSL #32
    MOVK  X11, #0x71c3, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X11, #0xc788, LSL #0
    MOVK  X11, #0x3b12, LSL #16
    MOVK  X11, #0x5ce2, LSL #32
    MOVK  X11, #0x7479, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D3
    MOVZ  X11, #0xbb2b, LSL #0
    MOVK  X11, #0x6166, LSL #16
    MOVK  X11, #0xece5, LSL #32
    MOVK  X11, #0x9009, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X11, #0xf511, LSL #0
    MOVK  X11, #0x15ea, LSL #16
    MOVK  X11, #0x52f0, LSL #32
    MOVK  X11, #0xe0c1, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D4
    MOVZ  X11, #0xd400, LSL #0
    MOVK  X11, #0x250c, LSL #16
    MOVK  X11, #0xb562, LSL #32
    MOVK  X11, #0xfb2c, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X11, #0xfc97, LSL #0
    MOVK  X11, #0x11c, LSL #16
    MOVK  X11, #0x31a6, LSL #32
    MOVK  X11, #0x204f, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D5
    MOVZ  X11, #0x7d69, LSL #0
    MOVK  X11, #0x7c24, LSL #16
    MOVK  X11, #0x2752, LSL #32
    MOVK  X11, #0xd488, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X11, #0x8dbc, LSL #0
    MOVK  X11, #0x32d8, LSL #16
    MOVK  X11, #0x813b, LSL #32
    MOVK  X11, #0x66ee, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D6
    MOVZ  X11, #0x80c9, LSL #0
    MOVK  X11, #0xbfce, LSL #16
    MOVK  X11, #0xd577, LSL #32
    MOVK  X11, #0x1bf0, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X11, #0x1a45, LSL #0
    MOVK  X11, #0x82e1, LSL #16
    MOVK  X11, #0xd952, LSL #32
    MOVK  X11, #0xf64d, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D7
    MOVZ  X11, #0x85c3, LSL #0
    MOVK  X11, #0xd052, LSL #16
    MOVK  X11, #0x2172, LSL #32
    MOVK  X11, #0xfdf6, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X11, #0xace0, LSL #0
    MOVK  X11, #0x7d97, LSL #16
    MOVK  X11, #0x3fc9, LSL #32
    MOVK  X11, #0xac50, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D8
    MOVZ  X11, #0x7b2f, LSL #0
    MOVK  X11, #0x48d3, LSL #16
    MOVK  X11, #0xa5ab, LSL #32
    MOVK  X11, #0xedf, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X11, #0x871d, LSL #0
    MOVK  X11, #0xc72, LSL #16
    MOVK  X11, #0xcec2, LSL #32
    MOVK  X11, #0x8417, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D9
    MOVZ  X11, #0xc943, LSL #0
    MOVK  X11, #0xe5a0, LSL #16
    MOVK  X11, #0xa423, LSL #32
    MOVK  X11, #0xa7b1, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X11, #0x6a5b, LSL #0
    MOVK  X11, #0xaadd, LSL #16
    MOVK  X11, #0x4e8a, LSL #32
    MOVK  X11, #0x9756, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D10
    MOVZ  X11, #0x3d97, LSL #0
    MOVK  X11, #0x91, LSL #16
    MOVK  X11, #0x4db8, LSL #32
    MOVK  X11, #0x6e6b, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X11, #0xc8d3, LSL #0
    MOVK  X11, #0x21a0, LSL #16
    MOVK  X11, #0xb3b6, LSL #32
    MOVK  X11, #0x780a, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D11
    MOVZ  X11, #0x909e, LSL #0
    MOVK  X11, #0xf683, LSL #16
    MOVK  X11, #0xd81e, LSL #32
    MOVK  X11, #0xf75f, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X11, #0x6cac, LSL #0
    MOVK  X11, #0x7e01, LSL #16
    MOVK  X11, #0x2a8, LSL #32
    MOVK  X11, #0x2d17, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D12
    MOVZ  X11, #0x6a94, LSL #0
    MOVK  X11, #0xe208, LSL #16
    MOVK  X11, #0x585d, LSL #32
    MOVK  X11, #0x6a50, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X11, #0x65d, LSL #0
    MOVK  X11, #0x97a6, LSL #16
    MOVK  X11, #0x6207, LSL #32
    MOVK  X11, #0x5176, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D13
    MOVZ  X11, #0x3399, LSL #0
    MOVK  X11, #0xab9b, LSL #16
    MOVK  X11, #0x3173, LSL #32
    MOVK  X11, #0xa8a7, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X11, #0x8ba8, LSL #0
    MOVK  X11, #0x402, LSL #16
    MOVK  X11, #0x406a, LSL #32
    MOVK  X11, #0xea7c, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D14
    MOVZ  X11, #0x90ac, LSL #0
    MOVK  X11, #0x5756, LSL #16
    MOVK  X11, #0xa00, LSL #32
    MOVK  X11, #0x7c01, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8df2, LSL #32
    MOVK  X11, #0x42d6, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D15
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X11, #0x8c7e, LSL #0
    MOVK  X11, #0x85c8, LSL #16
    MOVK  X11, #0x6842, LSL #32
    MOVK  X11, #0x2869, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D16
    MOVZ  X11, #0x6a01, LSL #0
    MOVK  X11, #0xd8bc, LSL #16
    MOVK  X11, #0x93c4, LSL #32
    MOVK  X11, #0x7e8d, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X11, #0x835a, LSL #0
    MOVK  X11, #0xdf70, LSL #16
    MOVK  X11, #0x46fd, LSL #32
    MOVK  X11, #0x6329, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D17
    MOVZ  X11, #0xb27a, LSL #0
    MOVK  X11, #0xd1c4, LSL #16
    MOVK  X11, #0xca49, LSL #32
    MOVK  X11, #0x48e7, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X11, #0x67bf, LSL #0
    MOVK  X11, #0xd74a, LSL #16
    MOVK  X11, #0x2e7b, LSL #32
    MOVK  X11, #0x1bdc, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D18
    MOVZ  X11, #0x77ea, LSL #0
    MOVK  X11, #0xd59d, LSL #16
    MOVK  X11, #0xfdff, LSL #32
    MOVK  X11, #0x9e5f, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X11, #0xb74c, LSL #0
    MOVK  X11, #0x79b1, LSL #16
    MOVK  X11, #0x6e55, LSL #32
    MOVK  X11, #0x711d, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D19
    MOVZ  X11, #0x420e, LSL #0
    MOVK  X11, #0xbdbf, LSL #16
    MOVK  X11, #0x5bb9, LSL #32
    MOVK  X11, #0x7919, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X11, #0x8ddc, LSL #0
    MOVK  X11, #0x872, LSL #16
    MOVK  X11, #0x134e, LSL #32
    MOVK  X11, #0x39ad, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D20
    MOVZ  X11, #0x5b49, LSL #0
    MOVK  X11, #0xf5b1, LSL #16
    MOVK  X11, #0x406c, LSL #32
    MOVK  X11, #0xd472, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X11, #0xf510, LSL #0
    MOVK  X11, #0x15ea, LSL #16
    MOVK  X11, #0x5b06, LSL #32
    MOVK  X11, #0xd09f, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D21
    MOVZ  X11, #0xd400, LSL #0
    MOVK  X11, #0x250c, LSL #16
    MOVK  X11, #0xb562, LSL #32
    MOVK  X11, #0xfb2c, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X11, #0xdbba, LSL #0
    MOVK  X11, #0xa022, LSL #16
    MOVK  X11, #0xc3e2, LSL #32
    MOVK  X11, #0xcb70, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D22
    MOVZ  X11, #0xbf9e, LSL #0
    MOVK  X11, #0x1346, LSL #16
    MOVK  X11, #0x9b14, LSL #32
    MOVK  X11, #0xf225, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X11, #0x234, LSL #0
    MOVK  X11, #0x8d62, LSL #16
    MOVK  X11, #0xde02, LSL #32
    MOVK  X11, #0xcf2d, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D23
    MOVZ  X11, #0xee88, LSL #0
    MOVK  X11, #0x9976, LSL #16
    MOVK  X11, #0xef2e, LSL #32
    MOVK  X11, #0x9862, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X11, #0xfa80, LSL #0
    MOVK  X11, #0xd778, LSL #16
    MOVK  X11, #0x76e0, LSL #32
    MOVK  X11, #0x40b3, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D24
    MOVZ  X11, #0x7c, LSL #0
    MOVK  X11, #0x5cd1, LSL #16
    MOVK  X11, #0x1ec, LSL #32
    MOVK  X11, #0xe555, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xb1cd, LSL #32
    MOVK  X11, #0xc8a5, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D25
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X11, #0xb08b, LSL #0
    MOVK  X11, #0xca00, LSL #16
    MOVK  X11, #0x37c7, LSL #32
    MOVK  X11, #0x5519, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D26
    MOVZ  X11, #0xf139, LSL #0
    MOVK  X11, #0xe837, LSL #16
    MOVK  X11, #0x27a1, LSL #32
    MOVK  X11, #0xd5b0, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X11, #0xf6f6, LSL #0
    MOVK  X11, #0x1271, LSL #16
    MOVK  X11, #0xc5fa, LSL #32
    MOVK  X11, #0xb0f8, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D27
    MOVZ  X11, #0x1297, LSL #0
    MOVK  X11, #0xdf1f, LSL #16
    MOVK  X11, #0x3af9, LSL #32
    MOVK  X11, #0x4510, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4fb, LSL #32
    MOVK  X11, #0x982f, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D28
    MOVZ  X11, #0x0, LSL #0
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X11, #0x4d39, LSL #0
    MOVK  X11, #0xc66a, LSL #16
    MOVK  X11, #0x5b71, LSL #32
    MOVK  X11, #0x37ea, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D29
    MOVZ  X11, #0xd4f8, LSL #0
    MOVK  X11, #0x2571, LSL #16
    MOVK  X11, #0x7987, LSL #32
    MOVK  X11, #0xc7bb, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X11, #0x9c23, LSL #0
    MOVK  X11, #0x5b5d, LSL #16
    MOVK  X11, #0xe8db, LSL #32
    MOVK  X11, #0x82b0, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D30
    MOVZ  X11, #0x52c9, LSL #0
    MOVK  X11, #0x5ee0, LSL #16
    MOVK  X11, #0x7970, LSL #32
    MOVK  X11, #0xae4e, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X11, #0x785a, LSL #0
    MOVK  X11, #0xa439, LSL #16
    MOVK  X11, #0x83ca, LSL #32
    MOVK  X11, #0xa30c, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X20, D31
    MOVZ  X11, #0xff36, LSL #0
    MOVK  X11, #0xec15, LSL #16
    MOVK  X11, #0x959c, LSL #32
    MOVK  X11, #0xefa4, LSL #48
    SUB  X18, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X20
    FMOV  D1, X21
    FMOV  V1.D[1], X12
    FMOV  D2, X23
    FMOV  V2.D[1], X19
    FMOV  D3, X22
    FMOV  V3.D[1], X5
    FMOV  D4, X6
    FMOV  V4.D[1], X20
    FMOV  D5, X14
    FMOV  V5.D[1], X3
    FMOV  D6, X16
    FMOV  V6.D[1], X6
    FMOV  D7, X9
    FMOV  V7.D[1], X4
    FMOV  D8, X7
    FMOV  V8.D[1], X5
    FMOV  D9, X4
    FMOV  V9.D[1], X16
    FMOV  D10, X15
    FMOV  V10.D[1], X20
    FMOV  D11, X9
    FMOV  V11.D[1], X2
    FMOV  D12, X4
    FMOV  V12.D[1], X15
    FMOV  D13, X14
    FMOV  V13.D[1], X17
    FMOV  D14, X28
    FMOV  V14.D[1], X10
    FMOV  D15, X16
    FMOV  V15.D[1], X17
    FMOV  D16, X16
    FMOV  V16.D[1], X28
    FMOV  D17, X12
    FMOV  V17.D[1], X5
    FMOV  D18, X13
    FMOV  V18.D[1], X4
    FMOV  D19, X17
    FMOV  V19.D[1], X3
    FMOV  D20, X7
    FMOV  V20.D[1], X9
    FMOV  D21, X23
    FMOV  V21.D[1], X28
    FMOV  D22, X28
    FMOV  V22.D[1], X4
    FMOV  D23, X17
    FMOV  V23.D[1], X20
    FMOV  D24, X5
    FMOV  V24.D[1], X6
    FMOV  D25, X6
    FMOV  V25.D[1], X4
    FMOV  D26, X9
    FMOV  V26.D[1], X17
    FMOV  D27, X17
    FMOV  V27.D[1], X2
    FMOV  D28, X7
    FMOV  V28.D[1], X3
    FMOV  D29, X4
    FMOV  V29.D[1], X5
    FMOV  D30, X9
    FMOV  V30.D[1], X12
    FMOV  D31, X21
    FMOV  V31.D[1], X7
    MOVZ  X20, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_3:
    SHA512SU0 V1.2D, V23.2D
    SM4E V20.4S, V19.4S
    XAR V1.2D, V5.2D, V28.2D, #0x1
    SM3TT1B V6.4S, V7.4S, V27.S[0x3]
    SM3TT1A V26.4S, V6.4S, V29.S[0x0]
    SHA512H Q15, Q22, V8.2D
    SM3TT1B V2.4S, V20.4S, V15.S[0x3]
    SHA512SU1 V14.2D, V24.2D, V30.2D
    XAR V5.2D, V14.2D, V12.2D, #0x10
    SM3TT2A V24.4S, V1.4S, V26.S[0x1]
    SM4E V26.4S, V27.4S
    SM4EKEY V28.4S, V26.4S, V14.4S
    SM4EKEY V15.4S, V28.4S, V28.4S
    RAX1 V1.2D, V23.2D, V31.2D
    SM3TT2B V24.4S, V20.4S, V1.S[0x0]
    BCAX V23.16B, V24.16B, V5.16B, V10.16B
    BCAX V1.16B, V3.16B, V23.16B, V2.16B
    SHA512SU0 V27.2D, V1.2D
    EOR3 V28.16B, V26.16B, V27.16B, V27.16B
    SM3TT2B V22.4S, V9.4S, V10.S[0x3]
    SM3TT2A V5.4S, V1.4S, V7.S[0x2]
    XAR V26.2D, V12.2D, V23.2D, #0x9
    BCAX V24.16B, V3.16B, V5.16B, V22.16B
    SHA512H Q29, Q11, V18.2D
    SM3TT1A V8.4S, V30.4S, V4.S[0x0]
    XAR V19.2D, V16.2D, V30.2D, #0x3a
    RAX1 V27.2D, V29.2D, V14.2D
    XAR V11.2D, V14.2D, V9.2D, #0x28
    RAX1 V18.2D, V1.2D, V20.2D
    XAR V12.2D, V8.2D, V11.2D, #0x16
    SM4EKEY V11.4S, V6.4S, V19.4S
    SHA512H Q16, Q15, V18.2D
    SM3TT1A V10.4S, V24.4S, V12.S[0x3]
    SM4EKEY V19.4S, V20.4S, V11.4S
    SHA512SU0 V1.2D, V22.2D
    BCAX V6.16B, V10.16B, V10.16B, V1.16B
    SHA512SU0 V3.2D, V29.2D
    SM3TT2A V8.4S, V16.4S, V24.S[0x0]
    SM3TT1B V31.4S, V8.4S, V18.S[0x2]
    SHA512H2 Q0, Q28, V3.2D
    XAR V8.2D, V6.2D, V3.2D, #0x33
    RAX1 V18.2D, V19.2D, V13.2D
    SM4E V8.4S, V0.4S
    SM3TT2A V5.4S, V8.4S, V18.S[0x0]
    SHA512SU0 V7.2D, V23.2D
    XAR V28.2D, V27.2D, V5.2D, #0x3a
    EOR3 V20.16B, V4.16B, V28.16B, V28.16B
    SHA512H Q22, Q22, V2.2D
    SM4E V6.4S, V7.4S
    SM3TT2B V18.4S, V26.4S, V22.S[0x3]
    SM4E V26.4S, V20.4S
    SHA512H Q23, Q1, V31.2D
    SM4EKEY V5.4S, V1.4S, V6.4S
    EOR3 V20.16B, V5.16B, V23.16B, V23.16B
    SM3PARTW1 V2.4S, V26.4S, V20.4S
    RAX1 V19.2D, V5.2D, V7.2D
    SM3SS1 V31.4S, V0.4S, V21.4S, V16.4S
    SHA512H2 Q22, Q18, V2.2D
    SHA512H Q6, Q1, V27.2D
    RAX1 V23.2D, V25.2D, V17.2D
    XAR V21.2D, V6.2D, V13.2D, #0x3a
    RAX1 V26.2D, V11.2D, V25.2D
    RAX1 V16.2D, V26.2D, V16.2D
    SHA512H Q8, Q23, V20.2D
    BCAX V27.16B, V27.16B, V21.16B, V9.16B
    SHA512H Q6, Q6, V8.2D
    SM4EKEY V1.4S, V15.4S, V22.4S
    EOR3 V23.16B, V12.16B, V25.16B, V9.16B
    BCAX V20.16B, V10.16B, V16.16B, V27.16B
    SM4E V26.4S, V11.4S
    RAX1 V7.2D, V5.2D, V28.2D
    SM4E V18.4S, V23.4S
    SM4EKEY V30.4S, V16.4S, V18.4S
    RAX1 V27.2D, V0.2D, V16.2D
    BCAX V9.16B, V26.16B, V27.16B, V29.16B
    SM4E V27.4S, V30.4S
    SM4E V22.4S, V8.4S
    SHA512SU1 V29.2D, V20.2D, V22.2D
    SHA512H2 Q23, Q7, V1.2D
    SM3PARTW2 V13.4S, V9.4S, V31.4S
    SM4EKEY V28.4S, V6.4S, V9.4S
    SHA512SU0 V25.2D, V28.2D
    SM3PARTW1 V28.4S, V10.4S, V23.4S
    SM3TT1A V11.4S, V19.4S, V1.S[0x0]
    SM3TT2B V12.4S, V1.4S, V27.S[0x1]
    SM4EKEY V18.4S, V28.4S, V3.4S
    SM4EKEY V7.4S, V25.4S, V1.4S
    SM4EKEY V25.4S, V18.4S, V29.4S
    SM3SS1 V17.4S, V10.4S, V15.4S, V12.4S
    SM3SS1 V21.4S, V1.4S, V17.4S, V10.4S
    SM3TT1A V20.4S, V15.4S, V14.S[0x2]
    SHA512SU1 V22.2D, V21.2D, V21.2D
    SM3PARTW1 V18.4S, V11.4S, V22.4S
    SHA512H Q28, Q28, V7.2D
    SHA512H Q30, Q20, V20.2D
    SM4E V31.4S, V30.4S
    BCAX V0.16B, V27.16B, V27.16B, V31.16B
    RAX1 V23.2D, V27.2D, V12.2D
    SHA512SU0 V29.2D, V19.2D
    BCAX V27.16B, V16.16B, V13.16B, V0.16B
    SM4E V17.4S, V21.4S
    SM4EKEY V16.4S, V25.4S, V27.4S
    SM4EKEY V21.4S, V29.4S, V29.4S
    SM3TT1B V7.4S, V16.4S, V23.S[0x2]
    RAX1 V31.2D, V21.2D, V17.2D
    SM3SS1 V31.4S, V7.4S, V7.4S, V19.4S
    BCAX V11.16B, V28.16B, V10.16B, V28.16B
    SM3TT1A V1.4S, V18.4S, V18.S[0x2]
    SHA512SU1 V16.2D, V31.2D, V3.2D
    SM3SS1 V28.4S, V24.4S, V1.4S, V19.4S
    SM3TT2A V3.4S, V11.4S, V28.S[0x1]
    SM3PARTW1 V18.4S, V28.4S, V22.4S
    SM3SS1 V0.4S, V25.4S, V18.4S, V11.4S
    XAR V23.2D, V23.2D, V13.2D, #0x1
    SM4E V31.4S, V12.4S
    EOR3 V30.16B, V4.16B, V15.16B, V9.16B
    SM3TT2B V4.4S, V21.4S, V25.S[0x0]
    SM3SS1 V9.4S, V18.4S, V26.4S, V1.4S
    SM3TT1A V1.4S, V25.4S, V20.S[0x2]
    SHA512H2 Q25, Q0, V16.2D
    SM4E V28.4S, V29.4S
    SM3TT1A V24.4S, V3.4S, V12.S[0x0]
    SM3PARTW2 V16.4S, V15.4S, V9.4S
    EOR3 V22.16B, V25.16B, V25.16B, V25.16B
    EOR3 V10.16B, V23.16B, V13.16B, V4.16B
    SHA512H2 Q17, Q24, V22.2D
    SHA512H Q11, Q1, V31.2D
    SHA512H Q0, Q30, V4.2D
    SM3TT1A V12.4S, V11.4S, V16.S[0x3]
    SM4E V15.4S, V5.4S
    BCAX V24.16B, V17.16B, V12.16B, V28.16B
    EOR3 V27.16B, V21.16B, V24.16B, V11.16B
    SM3SS1 V7.4S, V15.4S, V14.4S, V29.4S
    SM3TT2A V30.4S, V22.4S, V27.S[0x2]
    SHA512SU1 V22.2D, V25.2D, V0.2D
    SHA512H Q12, Q10, V22.2D
    SM3SS1 V14.4S, V12.4S, V17.4S, V30.4S
    BCAX V18.16B, V3.16B, V1.16B, V3.16B
    SHA512H Q17, Q31, V9.2D
    SM4EKEY V22.4S, V14.4S, V21.4S
    SM4EKEY V3.4S, V22.4S, V30.4S
    SHA512SU1 V11.2D, V11.2D, V4.2D
    SHA512SU0 V24.2D, V22.2D
    SM4EKEY V30.4S, V1.4S, V7.4S
    SHA512H Q27, Q22, V12.2D
    EOR3 V16.16B, V23.16B, V1.16B, V8.16B
    SM4E V1.4S, V26.4S
    SM3PARTW2 V5.4S, V3.4S, V1.4S
    SM3PARTW2 V0.4S, V17.4S, V0.4S
    SM3SS1 V12.4S, V0.4S, V22.4S, V16.4S
    SHA512H2 Q8, Q27, V27.2D
    SM4E V28.4S, V11.4S
    SHA512SU0 V0.2D, V24.2D
    SM3TT1A V23.4S, V27.4S, V10.S[0x1]
    SHA512SU1 V26.2D, V5.2D, V8.2D
    SHA512SU1 V6.2D, V28.2D, V30.2D
    SHA512SU0 V22.2D, V14.2D
    SM4EKEY V31.4S, V6.4S, V28.4S
    RAX1 V7.2D, V26.2D, V26.2D
    SM4E V4.4S, V0.4S
    SHA512SU0 V5.2D, V8.2D
    SM3TT2A V14.4S, V7.4S, V21.S[0x3]
    SHA512SU0 V11.2D, V4.2D
    SM4E V6.4S, V14.4S
    EOR3 V2.16B, V5.16B, V31.16B, V22.16B
    SHA512SU1 V28.2D, V22.2D, V2.2D
    SM3PARTW1 V28.4S, V28.4S, V21.4S
    SM3TT2A V9.4S, V1.4S, V12.S[0x2]
    EOR3 V7.16B, V11.16B, V6.16B, V3.16B
    EOR3 V30.16B, V28.16B, V18.16B, V9.16B
    RAX1 V2.2D, V0.2D, V3.2D
    SM3TT1A V3.4S, V11.4S, V28.S[0x3]
    RAX1 V22.2D, V16.2D, V3.2D
    SM3TT1A V28.4S, V30.4S, V22.S[0x3]
    SHA512H Q5, Q7, V2.2D
    SM3TT1B V1.4S, V12.4S, V9.S[0x3]
    BCAX V11.16B, V27.16B, V0.16B, V16.16B
    XAR V0.2D, V22.2D, V23.2D, #0x32
    SM3SS1 V22.4S, V0.4S, V28.4S, V30.4S
    SM4E V23.4S, V11.4S
    SM3SS1 V4.4S, V30.4S, V14.4S, V23.4S
    SM3PARTW2 V7.4S, V0.4S, V6.4S
    SHA512H Q11, Q7, V7.2D
    SM3TT1A V21.4S, V22.4S, V2.S[0x2]
    SHA512SU1 V30.2D, V5.2D, V4.2D
    SM4E V28.4S, V21.4S
    SM3TT1A V8.4S, V25.4S, V8.S[0x1]
    SM4EKEY V6.4S, V28.4S, V30.4S
    SM3PARTW1 V22.4S, V6.4S, V16.4S
    SM4E V4.4S, V22.4S
    SM4E V18.4S, V1.4S
    SM3TT1B V21.4S, V20.4S, V7.S[0x3]
    SHA512SU0 V20.2D, V21.2D
    XAR V0.2D, V20.2D, V8.2D, #0x1d
    SM4EKEY V2.4S, V18.4S, V16.4S
    SM3TT2A V9.4S, V11.4S, V29.S[0x1]
    SM3TT2A V11.4S, V22.4S, V2.S[0x3]
    SM3TT1A V5.4S, V0.4S, V2.S[0x3]
    SM4E V8.4S, V11.4S
    SM3TT1A V23.4S, V5.4S, V9.S[0x0]
    SUBS  X20, X20, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_3
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X21, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X21, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X16, FPSR
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X21, #0x46c7, LSL #0
    MOVK  X21, #0x8a92, LSL #16
    MOVK  X21, #0x509e, LSL #32
    MOVK  X21, #0x6c42, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D0
    MOVZ  X21, #0xaf9a, LSL #0
    MOVK  X21, #0x13f9, LSL #16
    MOVK  X21, #0x25d, LSL #32
    MOVK  X21, #0xa4c1, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X21, #0x2c22, LSL #0
    MOVK  X21, #0x56af, LSL #16
    MOVK  X21, #0x547b, LSL #32
    MOVK  X21, #0xacab, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D1
    MOVZ  X21, #0x7acc, LSL #0
    MOVK  X21, #0xa4d3, LSL #16
    MOVK  X21, #0xa651, LSL #32
    MOVK  X21, #0x18a8, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X21, #0x9ba7, LSL #0
    MOVK  X21, #0x8638, LSL #16
    MOVK  X21, #0x9758, LSL #32
    MOVK  X21, #0x8200, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D2
    MOVZ  X21, #0x985c, LSL #0
    MOVK  X21, #0x6500, LSL #16
    MOVK  X21, #0x87d, LSL #32
    MOVK  X21, #0x34fc, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X21, #0xfb92, LSL #0
    MOVK  X21, #0xb70c, LSL #16
    MOVK  X21, #0x3885, LSL #32
    MOVK  X21, #0x3033, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D3
    MOVZ  X21, #0xd087, LSL #0
    MOVK  X21, #0xb2a4, LSL #16
    MOVK  X21, #0x5772, LSL #32
    MOVK  X21, #0xfbb0, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X21, #0xb319, LSL #0
    MOVK  X21, #0xd5b, LSL #16
    MOVK  X21, #0x942a, LSL #32
    MOVK  X21, #0xc254, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D4
    MOVZ  X21, #0xf527, LSL #0
    MOVK  X21, #0x4e1a, LSL #16
    MOVK  X21, #0x3227, LSL #32
    MOVK  X21, #0x65f7, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X21, #0x7c0c, LSL #0
    MOVK  X21, #0x71eb, LSL #16
    MOVK  X21, #0x6960, LSL #32
    MOVK  X21, #0x43d, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D5
    MOVZ  X21, #0xc84a, LSL #0
    MOVK  X21, #0x2e7c, LSL #16
    MOVK  X21, #0x6c5d, LSL #32
    MOVK  X21, #0x8484, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X21, #0x9f02, LSL #0
    MOVK  X21, #0xd472, LSL #16
    MOVK  X21, #0xa970, LSL #32
    MOVK  X21, #0xa9df, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D6
    MOVZ  X21, #0x4703, LSL #0
    MOVK  X21, #0x38b8, LSL #16
    MOVK  X21, #0x2436, LSL #32
    MOVK  X21, #0x2c75, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X21, #0x21c0, LSL #0
    MOVK  X21, #0x3873, LSL #16
    MOVK  X21, #0xfe3, LSL #32
    MOVK  X21, #0xb813, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D7
    MOVZ  X21, #0xe909, LSL #0
    MOVK  X21, #0x1eca, LSL #16
    MOVK  X21, #0x7a21, LSL #32
    MOVK  X21, #0xd20b, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X21, #0xea0a, LSL #0
    MOVK  X21, #0x7c99, LSL #16
    MOVK  X21, #0x1a55, LSL #32
    MOVK  X21, #0x8243, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D8
    MOVZ  X21, #0xffb6, LSL #0
    MOVK  X21, #0xaddd, LSL #16
    MOVK  X21, #0x4c73, LSL #32
    MOVK  X21, #0x7b3d, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X21, #0xb335, LSL #0
    MOVK  X21, #0x849a, LSL #16
    MOVK  X21, #0xd142, LSL #32
    MOVK  X21, #0x98c2, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D9
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xba04, LSL #32
    MOVK  X21, #0xfa7b, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X21, #0x4c88, LSL #0
    MOVK  X21, #0xc3b1, LSL #16
    MOVK  X21, #0x68ad, LSL #32
    MOVK  X21, #0xd991, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D10
    MOVZ  X21, #0x96d0, LSL #0
    MOVK  X21, #0x94d7, LSL #16
    MOVK  X21, #0x12d0, LSL #32
    MOVK  X21, #0x364, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X21, #0x5289, LSL #0
    MOVK  X21, #0xfe9f, LSL #16
    MOVK  X21, #0xb835, LSL #32
    MOVK  X21, #0x2cd1, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D11
    MOVZ  X21, #0xd9cc, LSL #0
    MOVK  X21, #0xcc42, LSL #16
    MOVK  X21, #0xda6e, LSL #32
    MOVK  X21, #0x847e, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xfa30, LSL #32
    MOVK  X21, #0x9445, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D12
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X21, #0x6d82, LSL #0
    MOVK  X21, #0x4bc, LSL #16
    MOVK  X21, #0xf526, LSL #32
    MOVK  X21, #0xb14c, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D13
    MOVZ  X21, #0x2290, LSL #0
    MOVK  X21, #0xcded, LSL #16
    MOVK  X21, #0x5ef5, LSL #32
    MOVK  X21, #0x9eb0, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X21, #0x7608, LSL #0
    MOVK  X21, #0x30d1, LSL #16
    MOVK  X21, #0x3fc1, LSL #32
    MOVK  X21, #0x3967, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D14
    MOVZ  X21, #0x0, LSL #0
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X21, #0x3d86, LSL #0
    MOVK  X21, #0x211d, LSL #16
    MOVK  X21, #0x3056, LSL #32
    MOVK  X21, #0xf83f, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D15
    MOVZ  X21, #0x35b1, LSL #0
    MOVK  X21, #0x5caf, LSL #16
    MOVK  X21, #0x92d4, LSL #32
    MOVK  X21, #0x4247, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X21, #0x6261, LSL #0
    MOVK  X21, #0x9567, LSL #16
    MOVK  X21, #0xd326, LSL #32
    MOVK  X21, #0x4614, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D16
    MOVZ  X21, #0x5834, LSL #0
    MOVK  X21, #0xd469, LSL #16
    MOVK  X21, #0x3c9a, LSL #32
    MOVK  X21, #0x745d, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X21, #0xc7c4, LSL #0
    MOVK  X21, #0x5c0d, LSL #16
    MOVK  X21, #0x6d55, LSL #32
    MOVK  X21, #0xc28a, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D17
    MOVZ  X21, #0xb8f9, LSL #0
    MOVK  X21, #0x7d86, LSL #16
    MOVK  X21, #0xb12c, LSL #32
    MOVK  X21, #0x2631, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X21, #0x9738, LSL #0
    MOVK  X21, #0x2572, LSL #16
    MOVK  X21, #0xa92, LSL #32
    MOVK  X21, #0xe77e, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D18
    MOVZ  X21, #0xec67, LSL #0
    MOVK  X21, #0x5d4, LSL #16
    MOVK  X21, #0xd39e, LSL #32
    MOVK  X21, #0x47b3, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X21, #0x4ff0, LSL #0
    MOVK  X21, #0x91a3, LSL #16
    MOVK  X21, #0x7401, LSL #32
    MOVK  X21, #0x19b1, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D19
    MOVZ  X21, #0x3ae1, LSL #0
    MOVK  X21, #0xda29, LSL #16
    MOVK  X21, #0xd64a, LSL #32
    MOVK  X21, #0xf4b4, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X21, #0xfd65, LSL #0
    MOVK  X21, #0xc276, LSL #16
    MOVK  X21, #0xc125, LSL #32
    MOVK  X21, #0x7331, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D20
    MOVZ  X21, #0x4e44, LSL #0
    MOVK  X21, #0xd17a, LSL #16
    MOVK  X21, #0x382a, LSL #32
    MOVK  X21, #0x8753, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X21, #0xd6fc, LSL #0
    MOVK  X21, #0x76d9, LSL #16
    MOVK  X21, #0xd901, LSL #32
    MOVK  X21, #0xfa01, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D21
    MOVZ  X21, #0xb761, LSL #0
    MOVK  X21, #0xed99, LSL #16
    MOVK  X21, #0xae55, LSL #32
    MOVK  X21, #0xcc2e, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X21, #0x1226, LSL #0
    MOVK  X21, #0x67bb, LSL #16
    MOVK  X21, #0xd8dc, LSL #32
    MOVK  X21, #0x39ee, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D22
    MOVZ  X21, #0xd4e9, LSL #0
    MOVK  X21, #0x8eb0, LSL #16
    MOVK  X21, #0x82d0, LSL #32
    MOVK  X21, #0x28c9, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X21, #0x4006, LSL #0
    MOVK  X21, #0xd365, LSL #16
    MOVK  X21, #0xee1f, LSL #32
    MOVK  X21, #0xf1a3, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D23
    MOVZ  X21, #0x5454, LSL #0
    MOVK  X21, #0x27ae, LSL #16
    MOVK  X21, #0xae8c, LSL #32
    MOVK  X21, #0x8469, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X21, #0xb970, LSL #0
    MOVK  X21, #0xa85f, LSL #16
    MOVK  X21, #0xaa96, LSL #32
    MOVK  X21, #0x622f, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D24
    MOVZ  X21, #0xa52, LSL #0
    MOVK  X21, #0x3639, LSL #16
    MOVK  X21, #0x7a10, LSL #32
    MOVK  X21, #0xac30, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X21, #0x9575, LSL #0
    MOVK  X21, #0x1bda, LSL #16
    MOVK  X21, #0x8e77, LSL #32
    MOVK  X21, #0x6c93, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D25
    MOVZ  X21, #0xc0e1, LSL #0
    MOVK  X21, #0xe131, LSL #16
    MOVK  X21, #0x35b9, LSL #32
    MOVK  X21, #0x176, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X21, #0x85a, LSL #0
    MOVK  X21, #0x942f, LSL #16
    MOVK  X21, #0x3e80, LSL #32
    MOVK  X21, #0xe930, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D26
    MOVZ  X21, #0xedb3, LSL #0
    MOVK  X21, #0x4d3d, LSL #16
    MOVK  X21, #0xd11, LSL #32
    MOVK  X21, #0xc46b, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X21, #0x90ba, LSL #0
    MOVK  X21, #0xe66b, LSL #16
    MOVK  X21, #0x5810, LSL #32
    MOVK  X21, #0x17ae, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D27
    MOVZ  X21, #0xfd4, LSL #0
    MOVK  X21, #0xdf8b, LSL #16
    MOVK  X21, #0x222e, LSL #32
    MOVK  X21, #0x14c7, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X21, #0x1a58, LSL #0
    MOVK  X21, #0x15e9, LSL #16
    MOVK  X21, #0xd9, LSL #32
    MOVK  X21, #0xcb56, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D28
    MOVZ  X21, #0x13, LSL #0
    MOVK  X21, #0xccd7, LSL #16
    MOVK  X21, #0x56a0, LSL #32
    MOVK  X21, #0xf4e9, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X21, #0xbce4, LSL #0
    MOVK  X21, #0x8c26, LSL #16
    MOVK  X21, #0x7cef, LSL #32
    MOVK  X21, #0xf01f, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D29
    MOVZ  X21, #0x4382, LSL #0
    MOVK  X21, #0x872d, LSL #16
    MOVK  X21, #0x8eb6, LSL #32
    MOVK  X21, #0xe530, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X21, #0x8f5f, LSL #0
    MOVK  X21, #0x1b62, LSL #16
    MOVK  X21, #0x64c2, LSL #32
    MOVK  X21, #0x89df, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D30
    MOVZ  X21, #0x11cb, LSL #0
    MOVK  X21, #0xc421, LSL #16
    MOVK  X21, #0x771b, LSL #32
    MOVK  X21, #0x3c19, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X21, #0xe205, LSL #0
    MOVK  X21, #0x9a4d, LSL #16
    MOVK  X21, #0xae33, LSL #32
    MOVK  X21, #0xe364, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X16, D31
    MOVZ  X21, #0x3830, LSL #0
    MOVK  X21, #0x76e4, LSL #16
    MOVK  X21, #0x28d, LSL #32
    MOVK  X21, #0x63c, LSL #48
    SUB  X4, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X20
    FMOV  D1, X23
    FMOV  V1.D[1], X21
    FMOV  D2, X19
    FMOV  V2.D[1], X28
    FMOV  D3, X9
    FMOV  V3.D[1], X16
    FMOV  D4, X12
    FMOV  V4.D[1], X2
    FMOV  D5, X19
    FMOV  V5.D[1], X21
    FMOV  D6, X16
    FMOV  V6.D[1], X21
    FMOV  D7, X19
    FMOV  V7.D[1], X11
    FMOV  D8, X23
    FMOV  V8.D[1], X13
    FMOV  D9, X7
    FMOV  V9.D[1], X6
    FMOV  D10, X10
    FMOV  V10.D[1], X16
    FMOV  D11, X13
    FMOV  V11.D[1], X5
    FMOV  D12, X5
    FMOV  V12.D[1], X3
    FMOV  D13, X6
    FMOV  V13.D[1], X4
    FMOV  D14, X28
    FMOV  V14.D[1], X21
    FMOV  D15, X10
    FMOV  V15.D[1], X6
    FMOV  D16, X12
    FMOV  V16.D[1], X4
    FMOV  D17, X7
    FMOV  V17.D[1], X8
    FMOV  D18, X8
    FMOV  V18.D[1], X19
    FMOV  D19, X5
    FMOV  V19.D[1], X3
    FMOV  D20, X5
    FMOV  V20.D[1], X17
    FMOV  D21, X8
    FMOV  V21.D[1], X16
    FMOV  D22, X12
    FMOV  V22.D[1], X20
    FMOV  D23, X10
    FMOV  V23.D[1], X5
    FMOV  D24, X22
    FMOV  V24.D[1], X15
    FMOV  D25, X11
    FMOV  V25.D[1], X16
    FMOV  D26, X9
    FMOV  V26.D[1], X15
    FMOV  D27, X23
    FMOV  V27.D[1], X2
    FMOV  D28, X21
    FMOV  V28.D[1], X3
    FMOV  D29, X5
    FMOV  V29.D[1], X13
    FMOV  D30, X18
    FMOV  V30.D[1], X10
    FMOV  D31, X3
    FMOV  V31.D[1], X28
    MOVZ  X22, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_4:
    SM4E V31.4S, V25.4S
    SM3SS1 V5.4S, V26.4S, V28.4S, V21.4S
    SM4EKEY V21.4S, V12.4S, V29.4S
    SM4E V27.4S, V21.4S
    SM3TT1A V5.4S, V5.4S, V5.S[0x0]
    SM3TT2A V1.4S, V31.4S, V27.S[0x1]
    SM3TT1A V6.4S, V24.4S, V11.S[0x0]
    BCAX V1.16B, V5.16B, V1.16B, V9.16B
    SHA512H2 Q29, Q1, V16.2D
    BCAX V21.16B, V29.16B, V22.16B, V17.16B
    XAR V27.2D, V23.2D, V30.2D, #0x5
    SM3SS1 V22.4S, V27.4S, V23.4S, V24.4S
    SM3TT2B V12.4S, V19.4S, V6.S[0x3]
    SM4EKEY V21.4S, V12.4S, V22.4S
    SM4EKEY V31.4S, V6.4S, V18.4S
    SM4E V5.4S, V12.4S
    SM4E V19.4S, V5.4S
    RAX1 V18.2D, V28.2D, V28.2D
    SHA512H2 Q11, Q31, V14.2D
    SHA512H Q30, Q3, V18.2D
    RAX1 V1.2D, V0.2D, V18.2D
    SHA512SU1 V5.2D, V16.2D, V31.2D
    SM4E V31.4S, V7.4S
    SHA512SU0 V29.2D, V17.2D
    SHA512SU1 V14.2D, V8.2D, V26.2D
    SM4EKEY V0.4S, V16.4S, V11.4S
    BCAX V26.16B, V14.16B, V11.16B, V30.16B
    EOR3 V3.16B, V4.16B, V26.16B, V12.16B
    SM3PARTW1 V24.4S, V31.4S, V19.4S
    SHA512SU0 V28.2D, V31.2D
    SHA512SU0 V24.2D, V14.2D
    SM3TT2B V4.4S, V28.4S, V26.S[0x1]
    SM4E V7.4S, V25.4S
    BCAX V28.16B, V5.16B, V0.16B, V5.16B
    XAR V0.2D, V10.2D, V31.2D, #0x3c
    SM3TT2B V11.4S, V0.4S, V3.S[0x1]
    SHA512SU1 V31.2D, V3.2D, V24.2D
    XAR V17.2D, V28.2D, V1.2D, #0x2c
    SM3TT2A V14.4S, V7.4S, V30.S[0x2]
    SHA512SU0 V5.2D, V11.2D
    SM3TT1A V7.4S, V4.4S, V21.S[0x2]
    SHA512H Q25, Q7, V7.2D
    SM3TT2B V26.4S, V5.4S, V5.S[0x0]
    EOR3 V24.16B, V28.16B, V11.16B, V29.16B
    SM3TT1A V16.4S, V25.4S, V14.S[0x2]
    SM3PARTW2 V20.4S, V26.4S, V24.4S
    SHA512SU0 V0.2D, V16.2D
    SM3TT1A V9.4S, V31.4S, V31.S[0x3]
    SHA512H2 Q30, Q20, V3.2D
    SM4EKEY V8.4S, V17.4S, V0.4S
    SM4EKEY V5.4S, V27.4S, V26.4S
    SM3SS1 V19.4S, V30.4S, V18.4S, V15.4S
    SHA512SU1 V7.2D, V19.2D, V5.2D
    SHA512H Q21, Q1, V7.2D
    SHA512H Q31, Q9, V8.2D
    SHA512SU1 V19.2D, V11.2D, V4.2D
    SHA512SU1 V7.2D, V22.2D, V19.2D
    SM3PARTW2 V1.4S, V8.4S, V31.4S
    SM4E V19.4S, V28.4S
    BCAX V24.16B, V15.16B, V22.16B, V7.16B
    SM3TT1A V4.4S, V17.4S, V20.S[0x2]
    SM3SS1 V31.4S, V20.4S, V12.4S, V26.4S
    SHA512SU1 V8.2D, V6.2D, V11.2D
    SM4EKEY V11.4S, V19.4S, V11.4S
    SM4E V26.4S, V12.4S
    SHA512H Q28, Q30, V24.2D
    SM4E V29.4S, V17.4S
    XAR V24.2D, V26.2D, V11.2D, #0x3b
    SM4E V24.4S, V1.4S
    SHA512SU1 V16.2D, V21.2D, V26.2D
    SHA512SU0 V11.2D, V14.2D
    RAX1 V5.2D, V16.2D, V16.2D
    SHA512H Q7, Q17, V27.2D
    SHA512H Q2, Q4, V29.2D
    SHA512H Q17, Q1, V8.2D
    BCAX V29.16B, V11.16B, V29.16B, V2.16B
    SM4E V4.4S, V5.4S
    SM3PARTW1 V30.4S, V29.4S, V19.4S
    SHA512SU0 V27.2D, V24.2D
    BCAX V15.16B, V27.16B, V7.16B, V28.16B
    SHA512SU0 V18.2D, V24.2D
    SHA512H2 Q29, Q18, V20.2D
    RAX1 V24.2D, V4.2D, V31.2D
    SHA512H2 Q26, Q17, V30.2D
    SM3TT1A V27.4S, V10.4S, V15.S[0x1]
    SM3PARTW1 V8.4S, V26.4S, V11.4S
    SM4E V16.4S, V6.4S
    SHA512H2 Q14, Q24, V20.2D
    SM3TT1B V11.4S, V26.4S, V31.S[0x1]
    SM4EKEY V20.4S, V10.4S, V9.4S
    SM4EKEY V18.4S, V29.4S, V16.4S
    BCAX V16.16B, V10.16B, V19.16B, V12.16B
    SHA512H2 Q9, Q18, V1.2D
    SM3PARTW1 V10.4S, V20.4S, V9.4S
    SHA512SU1 V31.2D, V13.2D, V16.2D
    SM3TT2B V4.4S, V31.4S, V31.S[0x3]
    SHA512SU0 V24.2D, V11.2D
    SM4EKEY V16.4S, V28.4S, V14.4S
    SHA512H2 Q7, Q24, V27.2D
    EOR3 V3.16B, V7.16B, V16.16B, V16.16B
    EOR3 V13.16B, V29.16B, V7.16B, V10.16B
    XAR V24.2D, V3.2D, V13.2D, #0x3d
    SM3PARTW2 V29.4S, V24.4S, V23.4S
    SM3TT2B V20.4S, V8.4S, V4.S[0x0]
    BCAX V27.16B, V24.16B, V12.16B, V22.16B
    SHA512SU0 V13.2D, V11.2D
    SM4EKEY V1.4S, V30.4S, V16.4S
    SHA512SU0 V7.2D, V30.2D
    SM3TT2A V4.4S, V21.4S, V19.S[0x1]
    SM4EKEY V7.4S, V3.4S, V6.4S
    SM3TT1B V19.4S, V30.4S, V17.S[0x1]
    SM3PARTW1 V16.4S, V0.4S, V30.4S
    SHA512SU1 V8.2D, V29.2D, V29.2D
    BCAX V24.16B, V19.16B, V18.16B, V20.16B
    SHA512SU0 V12.2D, V13.2D
    SM3TT2A V30.4S, V1.4S, V16.S[0x0]
    SM3TT1A V0.4S, V7.4S, V7.S[0x2]
    SHA512SU1 V29.2D, V24.2D, V4.2D
    SM3PARTW1 V13.4S, V12.4S, V27.4S
    BCAX V22.16B, V0.16B, V14.16B, V20.16B
    SM4EKEY V10.4S, V1.4S, V8.4S
    RAX1 V24.2D, V13.2D, V6.2D
    BCAX V7.16B, V22.16B, V3.16B, V24.16B
    SM4E V7.4S, V7.4S
    SHA512H Q24, Q30, V30.2D
    SM4E V18.4S, V28.4S
    XAR V12.2D, V27.2D, V10.2D, #0x24
    SHA512SU1 V9.2D, V7.2D, V18.2D
    SHA512SU0 V4.2D, V12.2D
    EOR3 V10.16B, V19.16B, V4.16B, V21.16B
    SM4EKEY V30.4S, V29.4S, V22.4S
    SM4E V29.4S, V12.4S
    RAX1 V27.2D, V24.2D, V4.2D
    RAX1 V12.2D, V27.2D, V19.2D
    SHA512H2 Q18, Q10, V15.2D
    EOR3 V21.16B, V24.16B, V30.16B, V18.16B
    SM3TT2A V10.4S, V23.4S, V29.S[0x2]
    SHA512H2 Q22, Q9, V10.2D
    SM4E V0.4S, V12.4S
    SM3TT1B V1.4S, V21.4S, V27.S[0x3]
    SM3PARTW2 V7.4S, V11.4S, V22.4S
    SM4EKEY V26.4S, V7.4S, V28.4S
    SHA512H Q9, Q0, V14.2D
    SM4EKEY V22.4S, V1.4S, V1.4S
    XAR V18.2D, V22.2D, V22.2D, #0x16
    SHA512H Q15, Q18, V9.2D
    BCAX V1.16B, V7.16B, V10.16B, V23.16B
    SHA512SU0 V19.2D, V24.2D
    SM4E V12.4S, V14.4S
    SM4E V0.4S, V14.4S
    SM3TT2B V12.4S, V0.4S, V4.S[0x0]
    SM3PARTW1 V27.4S, V18.4S, V14.4S
    SM3SS1 V2.4S, V26.4S, V21.4S, V28.4S
    EOR3 V9.16B, V10.16B, V21.16B, V2.16B
    SM4E V0.4S, V2.4S
    SM3SS1 V18.4S, V4.4S, V0.4S, V24.4S
    SM3TT1A V4.4S, V16.4S, V20.S[0x3]
    SM4EKEY V10.4S, V8.4S, V16.4S
    SHA512H Q26, Q28, V15.2D
    SM3TT2B V18.4S, V27.4S, V18.S[0x2]
    SM3TT1B V12.4S, V1.4S, V18.S[0x3]
    SM3TT1B V11.4S, V4.4S, V19.S[0x2]
    SM4E V30.4S, V12.4S
    SHA512H2 Q28, Q2, V11.2D
    XAR V16.2D, V9.2D, V28.2D, #0x1f
    SM3TT1B V15.4S, V26.4S, V10.S[0x0]
    SHA512SU1 V21.2D, V29.2D, V15.2D
    SHA512SU1 V5.2D, V1.2D, V16.2D
    SM4EKEY V18.4S, V17.4S, V5.4S
    SM3SS1 V9.4S, V18.4S, V27.4S, V18.4S
    SHA512SU1 V18.2D, V21.2D, V9.2D
    XAR V4.2D, V8.2D, V29.2D, #0x1d
    SHA512H2 Q28, Q7, V25.2D
    SHA512H Q24, Q13, V9.2D
    SHA512H2 Q9, Q0, V24.2D
    SHA512SU0 V13.2D, V5.2D
    SM3TT1A V20.4S, V16.4S, V11.S[0x0]
    SM3TT2B V24.4S, V30.4S, V3.S[0x0]
    SM4EKEY V25.4S, V1.4S, V31.4S
    SM3TT2B V5.4S, V21.4S, V13.S[0x3]
    SM4EKEY V26.4S, V14.4S, V3.4S
    SM4E V14.4S, V9.4S
    SHA512SU0 V2.2D, V3.2D
    SM3TT1B V19.4S, V14.4S, V18.S[0x3]
    SM4E V8.4S, V31.4S
    XAR V7.2D, V25.2D, V11.2D, #0x15
    SM4E V29.4S, V24.4S
    RAX1 V0.2D, V13.2D, V26.2D
    SM4EKEY V21.4S, V29.4S, V8.4S
    SM4EKEY V13.4S, V10.4S, V4.4S
    SM3TT1A V25.4S, V16.4S, V13.S[0x2]
    RAX1 V13.2D, V31.2D, V28.2D
    SM3PARTW2 V30.4S, V7.4S, V7.4S
    SHA512H2 Q5, Q4, V5.2D
    SM4E V9.4S, V0.4S
    SM4E V27.4S, V18.4S
    SM4E V7.4S, V25.4S
    SM4E V28.4S, V27.4S
    XAR V3.2D, V28.2D, V25.2D, #0x7
    SM4EKEY V25.4S, V17.4S, V20.4S
    SUBS  X22, X22, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_4
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X15, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X15, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X8, FPSR
    MOVZ  X15, #0x0, LSL #0
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X15, #0x5183, LSL #0
    MOVK  X15, #0x25d4, LSL #16
    MOVK  X15, #0x6b8, LSL #32
    MOVK  X15, #0x127d, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D0
    MOVZ  X15, #0xcb98, LSL #0
    MOVK  X15, #0xf8f5, LSL #16
    MOVK  X15, #0x90ca, LSL #32
    MOVK  X15, #0x94a4, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X15, #0x658b, LSL #0
    MOVK  X15, #0xca57, LSL #16
    MOVK  X15, #0x1e6e, LSL #32
    MOVK  X15, #0xf18a, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D1
    MOVZ  X15, #0x148e, LSL #0
    MOVK  X15, #0x6cd5, LSL #16
    MOVK  X15, #0xbc02, LSL #32
    MOVK  X15, #0x9831, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X15, #0x601e, LSL #0
    MOVK  X15, #0x2077, LSL #16
    MOVK  X15, #0xe078, LSL #32
    MOVK  X15, #0x64f5, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D2
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xbc00, LSL #16
    MOVK  X15, #0x9090, LSL #32
    MOVK  X15, #0x765a, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X15, #0x5002, LSL #0
    MOVK  X15, #0x63d3, LSL #16
    MOVK  X15, #0xf99e, LSL #32
    MOVK  X15, #0x86ef, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D3
    MOVZ  X15, #0x314, LSL #0
    MOVK  X15, #0x30f8, LSL #16
    MOVK  X15, #0x61e2, LSL #32
    MOVK  X15, #0xffaa, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X15, #0xb359, LSL #0
    MOVK  X15, #0x63ea, LSL #16
    MOVK  X15, #0x3090, LSL #32
    MOVK  X15, #0x6956, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D4
    MOVZ  X15, #0x3b7c, LSL #0
    MOVK  X15, #0x97f4, LSL #16
    MOVK  X15, #0xd3bb, LSL #32
    MOVK  X15, #0xc7ec, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X15, #0x7c9e, LSL #0
    MOVK  X15, #0x4e3b, LSL #16
    MOVK  X15, #0xa977, LSL #32
    MOVK  X15, #0xd22a, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D5
    MOVZ  X15, #0xcf8c, LSL #0
    MOVK  X15, #0xbbd5, LSL #16
    MOVK  X15, #0xacc5, LSL #32
    MOVK  X15, #0xfc96, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X15, #0xed01, LSL #0
    MOVK  X15, #0x6c8, LSL #16
    MOVK  X15, #0xb009, LSL #32
    MOVK  X15, #0xe9e4, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D6
    MOVZ  X15, #0xe06a, LSL #0
    MOVK  X15, #0xeb3a, LSL #16
    MOVK  X15, #0x315b, LSL #32
    MOVK  X15, #0x47a0, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X15, #0xf51b, LSL #0
    MOVK  X15, #0xf2b0, LSL #16
    MOVK  X15, #0x37df, LSL #32
    MOVK  X15, #0x6357, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D7
    MOVZ  X15, #0x1447, LSL #0
    MOVK  X15, #0xd9be, LSL #16
    MOVK  X15, #0x5504, LSL #32
    MOVK  X15, #0xbf2b, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X15, #0x6fd, LSL #0
    MOVK  X15, #0xcd03, LSL #16
    MOVK  X15, #0xc363, LSL #32
    MOVK  X15, #0xde3, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D8
    MOVZ  X15, #0xb20d, LSL #0
    MOVK  X15, #0x664e, LSL #16
    MOVK  X15, #0xebcf, LSL #32
    MOVK  X15, #0xd8ab, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X15, #0xd3c8, LSL #0
    MOVK  X15, #0xf3f3, LSL #16
    MOVK  X15, #0x955d, LSL #32
    MOVK  X15, #0x48cb, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D9
    MOVZ  X15, #0x215b, LSL #0
    MOVK  X15, #0x1412, LSL #16
    MOVK  X15, #0xa5d6, LSL #32
    MOVK  X15, #0x12e9, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X15, #0x7f13, LSL #0
    MOVK  X15, #0x967, LSL #16
    MOVK  X15, #0xaa9a, LSL #32
    MOVK  X15, #0xea6, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D10
    MOVZ  X15, #0x98de, LSL #0
    MOVK  X15, #0x3e7a, LSL #16
    MOVK  X15, #0xb138, LSL #32
    MOVK  X15, #0xc80c, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X15, #0x1a1c, LSL #0
    MOVK  X15, #0x7d00, LSL #16
    MOVK  X15, #0x7785, LSL #32
    MOVK  X15, #0xa214, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D11
    MOVZ  X15, #0x59f6, LSL #0
    MOVK  X15, #0xb72a, LSL #16
    MOVK  X15, #0x33b7, LSL #32
    MOVK  X15, #0xe923, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X15, #0x4cbe, LSL #0
    MOVK  X15, #0x417d, LSL #16
    MOVK  X15, #0x71c5, LSL #32
    MOVK  X15, #0x1e6a, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D12
    MOVZ  X15, #0xadfc, LSL #0
    MOVK  X15, #0x4483, LSL #16
    MOVK  X15, #0xca84, LSL #32
    MOVK  X15, #0x8459, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X15, #0xdf21, LSL #0
    MOVK  X15, #0x2931, LSL #16
    MOVK  X15, #0x5df, LSL #32
    MOVK  X15, #0xc5d6, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D13
    MOVZ  X15, #0xe542, LSL #0
    MOVK  X15, #0x969e, LSL #16
    MOVK  X15, #0x477d, LSL #32
    MOVK  X15, #0xbc33, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X15, #0x7b97, LSL #0
    MOVK  X15, #0xe695, LSL #16
    MOVK  X15, #0x287b, LSL #32
    MOVK  X15, #0xd64b, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D14
    MOVZ  X15, #0xa1df, LSL #0
    MOVK  X15, #0x5786, LSL #16
    MOVK  X15, #0x3cf, LSL #32
    MOVK  X15, #0x6374, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X15, #0xe4d, LSL #0
    MOVK  X15, #0xc5ba, LSL #16
    MOVK  X15, #0xc25b, LSL #32
    MOVK  X15, #0xb1a2, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D15
    MOVZ  X15, #0x2757, LSL #0
    MOVK  X15, #0x82a9, LSL #16
    MOVK  X15, #0xcac8, LSL #32
    MOVK  X15, #0xb8ee, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X15, #0xf74a, LSL #0
    MOVK  X15, #0xcf06, LSL #16
    MOVK  X15, #0xbb98, LSL #32
    MOVK  X15, #0x30bd, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D16
    MOVZ  X15, #0x29eb, LSL #0
    MOVK  X15, #0x50ae, LSL #16
    MOVK  X15, #0x1549, LSL #32
    MOVK  X15, #0x69ad, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X15, #0x77aa, LSL #0
    MOVK  X15, #0xe90f, LSL #16
    MOVK  X15, #0xc834, LSL #32
    MOVK  X15, #0xc1a1, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D17
    MOVZ  X15, #0x6a19, LSL #0
    MOVK  X15, #0xeced, LSL #16
    MOVK  X15, #0x4ed9, LSL #32
    MOVK  X15, #0x5094, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X15, #0x9f79, LSL #0
    MOVK  X15, #0x4db5, LSL #16
    MOVK  X15, #0x7122, LSL #32
    MOVK  X15, #0x421d, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D18
    MOVZ  X15, #0x25ea, LSL #0
    MOVK  X15, #0x1fda, LSL #16
    MOVK  X15, #0x4dbd, LSL #32
    MOVK  X15, #0x508d, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X15, #0xe231, LSL #0
    MOVK  X15, #0x8fc, LSL #16
    MOVK  X15, #0xe17a, LSL #32
    MOVK  X15, #0x579a, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D19
    MOVZ  X15, #0x7aec, LSL #0
    MOVK  X15, #0x8334, LSL #16
    MOVK  X15, #0xe35c, LSL #32
    MOVK  X15, #0x72e7, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X15, #0x5457, LSL #0
    MOVK  X15, #0xb42e, LSL #16
    MOVK  X15, #0xa0d9, LSL #32
    MOVK  X15, #0xc6df, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D20
    MOVZ  X15, #0x9271, LSL #0
    MOVK  X15, #0xe60b, LSL #16
    MOVK  X15, #0xba6c, LSL #32
    MOVK  X15, #0xdbde, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X15, #0xd29e, LSL #0
    MOVK  X15, #0xb2fd, LSL #16
    MOVK  X15, #0x57b1, LSL #32
    MOVK  X15, #0x8311, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D21
    MOVZ  X15, #0xe3d5, LSL #0
    MOVK  X15, #0xf430, LSL #16
    MOVK  X15, #0xab7d, LSL #32
    MOVK  X15, #0x8a97, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X15, #0xd5a4, LSL #0
    MOVK  X15, #0xe8e1, LSL #16
    MOVK  X15, #0x7859, LSL #32
    MOVK  X15, #0x903f, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D22
    MOVZ  X15, #0xd5aa, LSL #0
    MOVK  X15, #0xcf4f, LSL #16
    MOVK  X15, #0x8c95, LSL #32
    MOVK  X15, #0x7bd0, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D23
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X15, #0x336, LSL #0
    MOVK  X15, #0x70ec, LSL #16
    MOVK  X15, #0xba86, LSL #32
    MOVK  X15, #0xa3b2, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D24
    MOVZ  X15, #0x631f, LSL #0
    MOVK  X15, #0x3545, LSL #16
    MOVK  X15, #0xac1e, LSL #32
    MOVK  X15, #0xefcb, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X15, #0xdcb7, LSL #0
    MOVK  X15, #0x3f6, LSL #16
    MOVK  X15, #0x133b, LSL #32
    MOVK  X15, #0xc3be, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D25
    MOVZ  X15, #0xfb68, LSL #0
    MOVK  X15, #0x42db, LSL #16
    MOVK  X15, #0xf902, LSL #32
    MOVK  X15, #0x7574, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X15, #0x6411, LSL #0
    MOVK  X15, #0x93b2, LSL #16
    MOVK  X15, #0xf202, LSL #32
    MOVK  X15, #0xddc8, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D26
    MOVZ  X15, #0x6897, LSL #0
    MOVK  X15, #0xe329, LSL #16
    MOVK  X15, #0x955f, LSL #32
    MOVK  X15, #0xd471, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X15, #0xffa1, LSL #0
    MOVK  X15, #0x1092, LSL #16
    MOVK  X15, #0xda5, LSL #32
    MOVK  X15, #0x31e1, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D27
    MOVZ  X15, #0x8aa3, LSL #0
    MOVK  X15, #0xbb6c, LSL #16
    MOVK  X15, #0xe830, LSL #32
    MOVK  X15, #0xd281, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X15, #0xe08b, LSL #0
    MOVK  X15, #0xa697, LSL #16
    MOVK  X15, #0x8b37, LSL #32
    MOVK  X15, #0x7e4b, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D28
    MOVZ  X15, #0xd461, LSL #0
    MOVK  X15, #0x7a0a, LSL #16
    MOVK  X15, #0x5cd8, LSL #32
    MOVK  X15, #0x807d, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X15, #0xea68, LSL #0
    MOVK  X15, #0x392d, LSL #16
    MOVK  X15, #0xc05f, LSL #32
    MOVK  X15, #0xd78f, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D29
    MOVZ  X15, #0xb853, LSL #0
    MOVK  X15, #0xe7c0, LSL #16
    MOVK  X15, #0xe1e1, LSL #32
    MOVK  X15, #0xa886, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X15, #0x99d7, LSL #0
    MOVK  X15, #0x1cf9, LSL #16
    MOVK  X15, #0xe0a1, LSL #32
    MOVK  X15, #0x4b0a, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D30
    MOVZ  X15, #0xe2c, LSL #0
    MOVK  X15, #0x6327, LSL #16
    MOVK  X15, #0x7dc7, LSL #32
    MOVK  X15, #0x95cd, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X15, #0xcd56, LSL #0
    MOVK  X15, #0x36ec, LSL #16
    MOVK  X15, #0xe48d, LSL #32
    MOVK  X15, #0x9ccb, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X8, D31
    MOVZ  X15, #0x83c4, LSL #0
    MOVK  X15, #0x50b4, LSL #16
    MOVK  X15, #0x11c2, LSL #32
    MOVK  X15, #0xda1e, LSL #48
    SUB  X20, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x7c3c, LSL #0
    MOVK  X2, #0xba33, LSL #16
    MOVK  X2, #0xf759, LSL #32
    MOVK  X2, #0xc6ba, LSL #48
    MOVZ  X3, #0x4285, LSL #0
    MOVK  X3, #0x6dcd, LSL #16
    MOVK  X3, #0x8fff, LSL #32
    MOVK  X3, #0x231a, LSL #48
    MOVZ  X4, #0x9304, LSL #0
    MOVK  X4, #0xd6b, LSL #16
    MOVK  X4, #0x58ed, LSL #32
    MOVK  X4, #0x4212, LSL #48
    MOVZ  X5, #0x9867, LSL #0
    MOVK  X5, #0xdc89, LSL #16
    MOVK  X5, #0x82fc, LSL #32
    MOVK  X5, #0x88b0, LSL #48
    MOVZ  X6, #0x53e0, LSL #0
    MOVK  X6, #0xc3c0, LSL #16
    MOVK  X6, #0x8730, LSL #32
    MOVK  X6, #0x80d3, LSL #48
    MOVZ  X7, #0xafc4, LSL #0
    MOVK  X7, #0xab47, LSL #16
    MOVK  X7, #0x169e, LSL #32
    MOVK  X7, #0x4ff, LSL #48
    MOVZ  X8, #0x9cc, LSL #0
    MOVK  X8, #0xdf6c, LSL #16
    MOVK  X8, #0x972a, LSL #32
    MOVK  X8, #0x3064, LSL #48
    MOVZ  X9, #0x67dd, LSL #0
    MOVK  X9, #0xc3a9, LSL #16
    MOVK  X9, #0x5b8, LSL #32
    MOVK  X9, #0x68ef, LSL #48
    MOVZ  X10, #0xee2e, LSL #0
    MOVK  X10, #0xa367, LSL #16
    MOVK  X10, #0xb2a8, LSL #32
    MOVK  X10, #0x53ce, LSL #48
    MOVZ  X11, #0xae59, LSL #0
    MOVK  X11, #0x9f89, LSL #16
    MOVK  X11, #0x90b4, LSL #32
    MOVK  X11, #0x9b08, LSL #48
    MOVZ  X12, #0xaed6, LSL #0
    MOVK  X12, #0x452, LSL #16
    MOVK  X12, #0x1fc4, LSL #32
    MOVK  X12, #0x6ac6, LSL #48
    MOVZ  X13, #0x2e65, LSL #0
    MOVK  X13, #0x26, LSL #16
    MOVK  X13, #0xe3c7, LSL #32
    MOVK  X13, #0x6f1, LSL #48
    MOVZ  X14, #0x324f, LSL #0
    MOVK  X14, #0x6ba8, LSL #16
    MOVK  X14, #0x43af, LSL #32
    MOVK  X14, #0x5d31, LSL #48
    MOVZ  X15, #0x4a12, LSL #0
    MOVK  X15, #0x147e, LSL #16
    MOVK  X15, #0x48a4, LSL #32
    MOVK  X15, #0xe596, LSL #48
    MOVZ  X16, #0x5c4b, LSL #0
    MOVK  X16, #0x8989, LSL #16
    MOVK  X16, #0xcd33, LSL #32
    MOVK  X16, #0xa17, LSL #48
    MOVZ  X17, #0x995b, LSL #0
    MOVK  X17, #0x8e51, LSL #16
    MOVK  X17, #0xd750, LSL #32
    MOVK  X17, #0x6608, LSL #48
    MOVZ  X18, #0x832f, LSL #0
    MOVK  X18, #0xc37b, LSL #16
    MOVK  X18, #0xb5f5, LSL #32
    MOVK  X18, #0x7f46, LSL #48
    MOVZ  X19, #0x5f79, LSL #0
    MOVK  X19, #0x9a7d, LSL #16
    MOVK  X19, #0x38a3, LSL #32
    MOVK  X19, #0xdb15, LSL #48
    MOVZ  X20, #0xd5c0, LSL #0
    MOVK  X20, #0x5178, LSL #16
    MOVK  X20, #0x6e6c, LSL #32
    MOVK  X20, #0x5676, LSL #48
    MOVZ  X21, #0xec6e, LSL #0
    MOVK  X21, #0xbf1a, LSL #16
    MOVK  X21, #0xdf7b, LSL #32
    MOVK  X21, #0xc1bf, LSL #48
    MOVZ  X22, #0xe8ed, LSL #0
    MOVK  X22, #0x5c7d, LSL #16
    MOVK  X22, #0x9656, LSL #32
    MOVK  X22, #0x2633, LSL #48
    MOVZ  X23, #0xe19e, LSL #0
    MOVK  X23, #0x88d7, LSL #16
    MOVK  X23, #0xa64a, LSL #32
    MOVK  X23, #0xb7d5, LSL #48
    MOVZ  X28, #0xf4e8, LSL #0
    MOVK  X28, #0x23c2, LSL #16
    MOVK  X28, #0x7e83, LSL #32
    MOVK  X28, #0xb00e, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X28
    FMOV  D1, X11
    FMOV  V1.D[1], X21
    FMOV  D2, X23
    FMOV  V2.D[1], X3
    FMOV  D3, X15
    FMOV  V3.D[1], X16
    FMOV  D4, X4
    FMOV  V4.D[1], X12
    FMOV  D5, X22
    FMOV  V5.D[1], X10
    FMOV  D6, X6
    FMOV  V6.D[1], X17
    FMOV  D7, X6
    FMOV  V7.D[1], X4
    FMOV  D8, X8
    FMOV  V8.D[1], X18
    FMOV  D9, X22
    FMOV  V9.D[1], X14
    FMOV  D10, X17
    FMOV  V10.D[1], X21
    FMOV  D11, X15
    FMOV  V11.D[1], X4
    FMOV  D12, X16
    FMOV  V12.D[1], X18
    FMOV  D13, X17
    FMOV  V13.D[1], X21
    FMOV  D14, X19
    FMOV  V14.D[1], X7
    FMOV  D15, X15
    FMOV  V15.D[1], X18
    FMOV  D16, X12
    FMOV  V16.D[1], X19
    FMOV  D17, X23
    FMOV  V17.D[1], X2
    FMOV  D18, X16
    FMOV  V18.D[1], X22
    FMOV  D19, X19
    FMOV  V19.D[1], X16
    FMOV  D20, X4
    FMOV  V20.D[1], X3
    FMOV  D21, X10
    FMOV  V21.D[1], X21
    FMOV  D22, X13
    FMOV  V22.D[1], X7
    FMOV  D23, X4
    FMOV  V23.D[1], X11
    FMOV  D24, X4
    FMOV  V24.D[1], X2
    FMOV  D25, X23
    FMOV  V25.D[1], X3
    FMOV  D26, X3
    FMOV  V26.D[1], X18
    FMOV  D27, X16
    FMOV  V27.D[1], X5
    FMOV  D28, X4
    FMOV  V28.D[1], X6
    FMOV  D29, X6
    FMOV  V29.D[1], X6
    FMOV  D30, X23
    FMOV  V30.D[1], X12
    FMOV  D31, X18
    FMOV  V31.D[1], X16
    MOVZ  X18, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_5:
    SHA512SU0 V20.2D, V30.2D
    BCAX V22.16B, V24.16B, V31.16B, V14.16B
    SM4EKEY V3.4S, V26.4S, V23.4S
    SM4EKEY V14.4S, V0.4S, V4.4S
    SM3TT1A V11.4S, V21.4S, V14.S[0x0]
    SM4EKEY V7.4S, V20.4S, V3.4S
    SM4EKEY V12.4S, V15.4S, V14.4S
    SM4E V20.4S, V0.4S
    SM3PARTW1 V7.4S, V31.4S, V7.4S
    RAX1 V2.2D, V19.2D, V7.2D
    RAX1 V0.2D, V2.2D, V22.2D
    SM4EKEY V26.4S, V27.4S, V29.4S
    SM3SS1 V20.4S, V5.4S, V11.4S, V26.4S
    SM3SS1 V23.4S, V2.4S, V9.4S, V15.4S
    SM3SS1 V26.4S, V0.4S, V12.4S, V28.4S
    SM3SS1 V14.4S, V6.4S, V5.4S, V23.4S
    SHA512SU0 V24.2D, V20.2D
    SM3TT2A V23.4S, V7.4S, V26.S[0x1]
    SHA512H2 Q31, Q14, V24.2D
    SM3SS1 V14.4S, V19.4S, V23.4S, V1.4S
    SHA512SU0 V3.2D, V0.2D
    RAX1 V0.2D, V14.2D, V3.2D
    SM3TT2B V2.4S, V31.4S, V23.S[0x3]
    XAR V20.2D, V18.2D, V28.2D, #0xa
    BCAX V21.16B, V8.16B, V30.16B, V18.16B
    SM4E V9.4S, V0.4S
    XAR V0.2D, V6.2D, V4.2D, #0x15
    SM3PARTW1 V23.4S, V22.4S, V14.4S
    SHA512SU1 V7.2D, V14.2D, V10.2D
    SM4EKEY V28.4S, V7.4S, V29.4S
    SM4E V18.4S, V6.4S
    SHA512H2 Q19, Q1, V27.2D
    BCAX V0.16B, V29.16B, V19.16B, V19.16B
    SM3TT1A V20.4S, V2.4S, V3.S[0x1]
    XAR V27.2D, V9.2D, V0.2D, #0x13
    SM4EKEY V11.4S, V22.4S, V28.4S
    SHA512H2 Q15, Q23, V1.2D
    SM4E V4.4S, V0.4S
    SM4EKEY V0.4S, V7.4S, V15.4S
    SHA512SU0 V3.2D, V27.2D
    BCAX V1.16B, V30.16B, V17.16B, V0.16B
    BCAX V31.16B, V22.16B, V15.16B, V20.16B
    SHA512SU1 V20.2D, V16.2D, V3.2D
    EOR3 V23.16B, V19.16B, V28.16B, V31.16B
    SM3TT1A V7.4S, V20.4S, V21.S[0x3]
    SHA512SU1 V21.2D, V11.2D, V8.2D
    SM4E V16.4S, V7.4S
    SM3TT1B V15.4S, V2.4S, V27.S[0x3]
    SM3TT1A V3.4S, V16.4S, V1.S[0x2]
    SM4E V28.4S, V18.4S
    XAR V14.2D, V13.2D, V10.2D, #0x3f
    SM3TT2A V11.4S, V14.4S, V28.S[0x2]
    SM4EKEY V27.4S, V15.4S, V23.4S
    SM4EKEY V18.4S, V4.4S, V23.4S
    XAR V10.2D, V24.2D, V15.2D, #0x3
    SHA512H2 Q9, Q10, V28.2D
    SM3TT1B V15.4S, V11.4S, V21.S[0x2]
    SM4E V1.4S, V31.4S
    SHA512H2 Q30, Q3, V15.2D
    SM3SS1 V16.4S, V27.4S, V1.4S, V21.4S
    SM3TT1A V1.4S, V16.4S, V18.S[0x1]
    SM4E V24.4S, V14.4S
    SM4EKEY V14.4S, V8.4S, V8.4S
    SHA512H Q28, Q9, V17.2D
    SHA512SU0 V8.2D, V30.2D
    SM4EKEY V21.4S, V6.4S, V14.4S
    SM3TT1B V23.4S, V10.4S, V21.S[0x1]
    SM4E V13.4S, V1.4S
    SM3TT2B V11.4S, V23.4S, V23.S[0x1]
    SM4EKEY V20.4S, V11.4S, V6.4S
    SHA512SU1 V21.2D, V24.2D, V13.2D
    XAR V10.2D, V8.2D, V20.2D, #0x7
    RAX1 V1.2D, V21.2D, V10.2D
    SM4E V24.4S, V1.4S
    BCAX V15.16B, V6.16B, V17.16B, V26.16B
    SHA512SU0 V16.2D, V3.2D
    RAX1 V14.2D, V23.2D, V24.2D
    RAX1 V2.2D, V4.2D, V9.2D
    SM3TT2A V6.4S, V30.4S, V11.S[0x1]
    SM4E V19.4S, V21.4S
    SHA512H2 Q22, Q1, V9.2D
    SHA512H Q8, Q31, V28.2D
    SHA512SU1 V26.2D, V29.2D, V11.2D
    RAX1 V30.2D, V8.2D, V16.2D
    EOR3 V23.16B, V8.16B, V9.16B, V8.16B
    SHA512H2 Q4, Q6, V30.2D
    SHA512SU0 V24.2D, V7.2D
    SHA512SU0 V28.2D, V15.2D
    SM4E V21.4S, V14.4S
    SHA512H2 Q14, Q17, V2.2D
    BCAX V31.16B, V21.16B, V28.16B, V21.16B
    XAR V15.2D, V19.2D, V4.2D, #0x32
    SHA512SU1 V1.2D, V4.2D, V31.2D
    SM4EKEY V21.4S, V24.4S, V23.4S
    SM4E V27.4S, V11.4S
    SM4E V17.4S, V22.4S
    SM4EKEY V2.4S, V27.4S, V26.4S
    EOR3 V20.16B, V19.16B, V11.16B, V15.16B
    SM4E V27.4S, V1.4S
    SHA512SU1 V11.2D, V27.2D, V18.2D
    SHA512SU1 V29.2D, V2.2D, V10.2D
    SHA512SU0 V2.2D, V21.2D
    SM4E V9.4S, V14.4S
    SHA512H Q28, Q11, V9.2D
    SHA512SU1 V24.2D, V29.2D, V28.2D
    SM3TT2A V26.4S, V17.4S, V15.S[0x0]
    RAX1 V11.2D, V26.2D, V16.2D
    BCAX V4.16B, V15.16B, V13.16B, V20.16B
    SM3TT2A V29.4S, V25.4S, V24.S[0x0]
    SM3TT2B V31.4S, V29.4S, V9.S[0x1]
    SHA512SU1 V27.2D, V25.2D, V1.2D
    EOR3 V14.16B, V11.16B, V11.16B, V27.16B
    SM4E V1.4S, V6.4S
    SHA512SU0 V27.2D, V2.2D
    SM4E V15.4S, V31.4S
    SHA512SU1 V7.2D, V15.2D, V1.2D
    SM3SS1 V6.4S, V14.4S, V30.4S, V22.4S
    SHA512SU0 V23.2D, V6.2D
    SM3TT1B V2.4S, V7.4S, V31.S[0x1]
    SHA512H Q7, Q2, V4.2D
    XAR V14.2D, V7.2D, V31.2D, #0x6
    EOR3 V15.16B, V23.16B, V1.16B, V23.16B
    RAX1 V19.2D, V7.2D, V14.2D
    SM3TT1A V1.4S, V8.4S, V3.S[0x1]
    SHA512SU0 V28.2D, V1.2D
    SHA512SU1 V1.2D, V19.2D, V27.2D
    SM4EKEY V31.4S, V1.4S, V15.4S
    SM3PARTW2 V28.4S, V28.4S, V8.4S
    SM4E V29.4S, V29.4S
    XAR V22.2D, V14.2D, V25.2D, #0xd
    SM4EKEY V2.4S, V12.4S, V6.4S
    SHA512H Q6, Q18, V8.2D
    SHA512H2 Q30, Q23, V19.2D
    SM3PARTW1 V17.4S, V13.4S, V4.4S
    SM3PARTW1 V27.4S, V10.4S, V1.4S
    SHA512SU0 V7.2D, V17.2D
    BCAX V13.16B, V6.16B, V30.16B, V30.16B
    SM3TT1A V3.4S, V7.4S, V27.S[0x1]
    SHA512SU1 V3.2D, V13.2D, V29.2D
    SHA512SU0 V1.2D, V12.2D
    SHA512H2 Q8, Q30, V10.2D
    SM4EKEY V4.4S, V0.4S, V1.4S
    XAR V19.2D, V3.2D, V22.2D, #0x27
    SM4E V27.4S, V24.4S
    SM3SS1 V10.4S, V4.4S, V4.4S, V4.4S
    BCAX V18.16B, V29.16B, V12.16B, V31.16B
    SM4EKEY V31.4S, V24.4S, V10.4S
    SM3TT1B V23.4S, V9.4S, V2.S[0x2]
    EOR3 V10.16B, V12.16B, V27.16B, V31.16B
    SHA512SU1 V15.2D, V28.2D, V8.2D
    SM3PARTW2 V4.4S, V10.4S, V11.4S
    EOR3 V28.16B, V4.16B, V4.16B, V19.16B
    EOR3 V7.16B, V15.16B, V28.16B, V23.16B
    SM4EKEY V15.4S, V27.4S, V2.4S
    SM3PARTW2 V22.4S, V17.4S, V7.4S
    SHA512SU0 V30.2D, V12.2D
    SM3TT1A V24.4S, V2.4S, V22.S[0x1]
    SHA512SU1 V0.2D, V13.2D, V17.2D
    SM3TT2B V25.4S, V6.4S, V16.S[0x1]
    SM3TT2A V19.4S, V13.4S, V3.S[0x2]
    SM4EKEY V11.4S, V7.4S, V19.4S
    SM4EKEY V18.4S, V6.4S, V17.4S
    SM4EKEY V1.4S, V23.4S, V17.4S
    SM4EKEY V4.4S, V9.4S, V8.4S
    SM3TT1B V12.4S, V30.4S, V1.S[0x2]
    RAX1 V1.2D, V0.2D, V12.2D
    EOR3 V30.16B, V25.16B, V19.16B, V26.16B
    SHA512H2 Q28, Q24, V30.2D
    BCAX V31.16B, V22.16B, V14.16B, V8.16B
    EOR3 V7.16B, V1.16B, V31.16B, V9.16B
    SM4EKEY V30.4S, V4.4S, V4.4S
    SM4EKEY V31.4S, V30.4S, V30.4S
    SM4EKEY V30.4S, V17.4S, V0.4S
    SHA512SU0 V24.2D, V18.2D
    SM3TT2A V6.4S, V31.4S, V24.S[0x1]
    SM4EKEY V12.4S, V28.4S, V30.4S
    SM3TT2B V17.4S, V6.4S, V8.S[0x0]
    SM4E V18.4S, V12.4S
    EOR3 V4.16B, V22.16B, V25.16B, V11.16B
    SM4E V2.4S, V30.4S
    SHA512SU1 V9.2D, V18.2D, V7.2D
    SHA512SU1 V3.2D, V31.2D, V4.2D
    SM3TT2B V1.4S, V9.4S, V3.S[0x1]
    SHA512SU1 V8.2D, V2.2D, V9.2D
    SM3TT2A V9.4S, V4.4S, V30.S[0x2]
    SM3SS1 V6.4S, V1.4S, V17.4S, V23.4S
    EOR3 V3.16B, V8.16B, V15.16B, V8.16B
    SM4E V26.4S, V6.4S
    RAX1 V17.2D, V16.2D, V25.2D
    SM3PARTW1 V1.4S, V3.4S, V3.4S
    XAR V3.2D, V9.2D, V15.2D, #0xb
    BCAX V12.16B, V1.16B, V3.16B, V19.16B
    SM4E V25.4S, V17.4S
    SHA512SU1 V8.2D, V25.2D, V31.2D
    SM4EKEY V25.4S, V17.4S, V23.4S
    EOR3 V3.16B, V27.16B, V12.16B, V12.16B
    SM4EKEY V15.4S, V1.4S, V8.4S
    EOR3 V6.16B, V3.16B, V26.16B, V15.16B
    RAX1 V24.2D, V11.2D, V4.2D
    SHA512H Q0, Q24, V5.2D
    SUBS  X18, X18, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_5
    MOVZ  X11, #0x7c3c, LSL #0
    MOVK  X11, #0xba33, LSL #16
    MOVK  X11, #0xf759, LSL #32
    MOVK  X11, #0xc6ba, LSL #48
    SUB  X10, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x4285, LSL #0
    MOVK  X11, #0x6dcd, LSL #16
    MOVK  X11, #0x8fff, LSL #32
    MOVK  X11, #0x231a, LSL #48
    SUB  X10, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x9304, LSL #0
    MOVK  X11, #0xd6b, LSL #16
    MOVK  X11, #0x58ed, LSL #32
    MOVK  X11, #0x4212, LSL #48
    SUB  X10, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x9867, LSL #0
    MOVK  X11, #0xdc89, LSL #16
    MOVK  X11, #0x82fc, LSL #32
    MOVK  X11, #0x88b0, LSL #48
    SUB  X10, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x53e0, LSL #0
    MOVK  X11, #0xc3c0, LSL #16
    MOVK  X11, #0x8730, LSL #32
    MOVK  X11, #0x80d3, LSL #48
    SUB  X10, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x9cc, LSL #0
    MOVK  X11, #0xdf6c, LSL #16
    MOVK  X11, #0x972a, LSL #32
    MOVK  X11, #0x3064, LSL #48
    SUB  X10, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x67dd, LSL #0
    MOVK  X11, #0xc3a9, LSL #16
    MOVK  X11, #0x5b8, LSL #32
    MOVK  X11, #0x68ef, LSL #48
    SUB  X10, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0xaed6, LSL #0
    MOVK  X11, #0x452, LSL #16
    MOVK  X11, #0x1fc4, LSL #32
    MOVK  X11, #0x6ac6, LSL #48
    SUB  X10, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x2e65, LSL #0
    MOVK  X11, #0x26, LSL #16
    MOVK  X11, #0xe3c7, LSL #32
    MOVK  X11, #0x6f1, LSL #48
    SUB  X10, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x324f, LSL #0
    MOVK  X11, #0x6ba8, LSL #16
    MOVK  X11, #0x43af, LSL #32
    MOVK  X11, #0x5d31, LSL #48
    SUB  X10, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x4a12, LSL #0
    MOVK  X11, #0x147e, LSL #16
    MOVK  X11, #0x48a4, LSL #32
    MOVK  X11, #0xe596, LSL #48
    SUB  X10, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x5c4b, LSL #0
    MOVK  X11, #0x8989, LSL #16
    MOVK  X11, #0xcd33, LSL #32
    MOVK  X11, #0xa17, LSL #48
    SUB  X10, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x995b, LSL #0
    MOVK  X11, #0x8e51, LSL #16
    MOVK  X11, #0xd750, LSL #32
    MOVK  X11, #0x6608, LSL #48
    SUB  X10, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X10, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0x5f79, LSL #0
    MOVK  X11, #0x9a7d, LSL #16
    MOVK  X11, #0x38a3, LSL #32
    MOVK  X11, #0xdb15, LSL #48
    SUB  X10, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0xd5c0, LSL #0
    MOVK  X11, #0x5178, LSL #16
    MOVK  X11, #0x6e6c, LSL #32
    MOVK  X11, #0x5676, LSL #48
    SUB  X10, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0xec6e, LSL #0
    MOVK  X11, #0xbf1a, LSL #16
    MOVK  X11, #0xdf7b, LSL #32
    MOVK  X11, #0xc1bf, LSL #48
    SUB  X10, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0xe8ed, LSL #0
    MOVK  X11, #0x5c7d, LSL #16
    MOVK  X11, #0x9656, LSL #32
    MOVK  X11, #0x2633, LSL #48
    SUB  X10, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0xe19e, LSL #0
    MOVK  X11, #0x88d7, LSL #16
    MOVK  X11, #0xa64a, LSL #32
    MOVK  X11, #0xb7d5, LSL #48
    SUB  X10, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X11, #0xf4e8, LSL #0
    MOVK  X11, #0x23c2, LSL #16
    MOVK  X11, #0x7e83, LSL #32
    MOVK  X11, #0xb00e, LSL #48
    SUB  X10, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X11, FPSR
    MOVZ  X10, #0x0, LSL #0
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X10, #0x34a3, LSL #0
    MOVK  X10, #0xe696, LSL #16
    MOVK  X10, #0x1d31, LSL #32
    MOVK  X10, #0xc72c, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D0
    MOVZ  X10, #0xfe3e, LSL #0
    MOVK  X10, #0x1a36, LSL #16
    MOVK  X10, #0x6690, LSL #32
    MOVK  X10, #0x2321, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X10, #0xd7dc, LSL #0
    MOVK  X10, #0x20bb, LSL #16
    MOVK  X10, #0x286f, LSL #32
    MOVK  X10, #0xa986, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D1
    MOVZ  X10, #0x61b9, LSL #0
    MOVK  X10, #0x5e66, LSL #16
    MOVK  X10, #0x1757, LSL #32
    MOVK  X10, #0x55d6, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X10, #0xf1ee, LSL #0
    MOVK  X10, #0x5c30, LSL #16
    MOVK  X10, #0x6a5d, LSL #32
    MOVK  X10, #0x756b, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D2
    MOVZ  X10, #0xd60e, LSL #0
    MOVK  X10, #0x1668, LSL #16
    MOVK  X10, #0x3561, LSL #32
    MOVK  X10, #0x523, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X10, #0x4fac, LSL #0
    MOVK  X10, #0xca4d, LSL #16
    MOVK  X10, #0x68f3, LSL #32
    MOVK  X10, #0x4372, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D3
    MOVZ  X10, #0xe5db, LSL #0
    MOVK  X10, #0x3e4d, LSL #16
    MOVK  X10, #0xaa19, LSL #32
    MOVK  X10, #0x2664, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X10, #0xb6cc, LSL #0
    MOVK  X10, #0x160, LSL #16
    MOVK  X10, #0xf81f, LSL #32
    MOVK  X10, #0xd678, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D4
    MOVZ  X10, #0x3eeb, LSL #0
    MOVK  X10, #0x43e4, LSL #16
    MOVK  X10, #0x9f93, LSL #32
    MOVK  X10, #0xfb1c, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X10, #0xee2e, LSL #0
    MOVK  X10, #0xa367, LSL #16
    MOVK  X10, #0xb2a8, LSL #32
    MOVK  X10, #0x53ce, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D5
    MOVZ  X10, #0xe8ed, LSL #0
    MOVK  X10, #0x5c7d, LSL #16
    MOVK  X10, #0x9656, LSL #32
    MOVK  X10, #0x2633, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X10, #0x321a, LSL #0
    MOVK  X10, #0x40d2, LSL #16
    MOVK  X10, #0xe411, LSL #32
    MOVK  X10, #0xad6b, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D6
    MOVZ  X10, #0xd4a, LSL #0
    MOVK  X10, #0x8178, LSL #16
    MOVK  X10, #0xca2e, LSL #32
    MOVK  X10, #0x39f1, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X10, #0x8a4d, LSL #0
    MOVK  X10, #0xe0d9, LSL #16
    MOVK  X10, #0x6d81, LSL #32
    MOVK  X10, #0xb69f, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D7
    MOVZ  X10, #0xa0a9, LSL #0
    MOVK  X10, #0xfbd3, LSL #16
    MOVK  X10, #0xd000, LSL #32
    MOVK  X10, #0x5892, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X10, #0x719, LSL #0
    MOVK  X10, #0x250b, LSL #16
    MOVK  X10, #0xc460, LSL #32
    MOVK  X10, #0x3fe3, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D8
    MOVZ  X10, #0x6ad2, LSL #0
    MOVK  X10, #0xd7a1, LSL #16
    MOVK  X10, #0x4d67, LSL #32
    MOVK  X10, #0x578c, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X10, #0x21f8, LSL #0
    MOVK  X10, #0xdb9b, LSL #16
    MOVK  X10, #0x1294, LSL #32
    MOVK  X10, #0x94df, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D9
    MOVZ  X10, #0xb7c7, LSL #0
    MOVK  X10, #0x7fa2, LSL #16
    MOVK  X10, #0xf26d, LSL #32
    MOVK  X10, #0xfb0f, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X10, #0xeb95, LSL #0
    MOVK  X10, #0x503, LSL #16
    MOVK  X10, #0xb0da, LSL #32
    MOVK  X10, #0x23a6, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D10
    MOVZ  X10, #0x8637, LSL #0
    MOVK  X10, #0x1cd2, LSL #16
    MOVK  X10, #0x4c7a, LSL #32
    MOVK  X10, #0x5fce, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X10, #0xfd60, LSL #0
    MOVK  X10, #0x94e0, LSL #16
    MOVK  X10, #0x4233, LSL #32
    MOVK  X10, #0x7742, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D11
    MOVZ  X10, #0x340b, LSL #0
    MOVK  X10, #0xa1e1, LSL #16
    MOVK  X10, #0x544b, LSL #32
    MOVK  X10, #0x102d, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X10, #0xd6cd, LSL #0
    MOVK  X10, #0x2712, LSL #16
    MOVK  X10, #0x292f, LSL #32
    MOVK  X10, #0xfdd6, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D12
    MOVZ  X10, #0xe39b, LSL #0
    MOVK  X10, #0x9eef, LSL #16
    MOVK  X10, #0xb59, LSL #32
    MOVK  X10, #0x57d7, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X10, #0x9006, LSL #0
    MOVK  X10, #0x43e8, LSL #16
    MOVK  X10, #0x148b, LSL #32
    MOVK  X10, #0x9c9e, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D13
    MOVZ  X10, #0x5d2c, LSL #0
    MOVK  X10, #0x545a, LSL #16
    MOVK  X10, #0xbe10, LSL #32
    MOVK  X10, #0xdbd1, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X10, #0x4ea3, LSL #0
    MOVK  X10, #0x31ee, LSL #16
    MOVK  X10, #0x48a9, LSL #32
    MOVK  X10, #0x2893, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D14
    MOVZ  X10, #0xf07a, LSL #0
    MOVK  X10, #0xc97e, LSL #16
    MOVK  X10, #0xf69c, LSL #32
    MOVK  X10, #0xece9, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X10, #0x5c0a, LSL #0
    MOVK  X10, #0x40f2, LSL #16
    MOVK  X10, #0x1204, LSL #32
    MOVK  X10, #0x1a, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D15
    MOVZ  X10, #0xed53, LSL #0
    MOVK  X10, #0x7966, LSL #16
    MOVK  X10, #0xd06f, LSL #32
    MOVK  X10, #0x496d, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X10, #0x6974, LSL #0
    MOVK  X10, #0xb4b2, LSL #16
    MOVK  X10, #0xf2b, LSL #32
    MOVK  X10, #0xc408, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D16
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7a00, LSL #16
    MOVK  X10, #0x8880, LSL #32
    MOVK  X10, #0x4ef8, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X10, #0xe135, LSL #0
    MOVK  X10, #0x4eed, LSL #16
    MOVK  X10, #0x8438, LSL #32
    MOVK  X10, #0x3a97, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D17
    MOVZ  X10, #0xff82, LSL #0
    MOVK  X10, #0x92ae, LSL #16
    MOVK  X10, #0x483b, LSL #32
    MOVK  X10, #0xce84, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X10, #0xea0f, LSL #0
    MOVK  X10, #0x91b9, LSL #16
    MOVK  X10, #0xe8a7, LSL #32
    MOVK  X10, #0x44fc, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D18
    MOVZ  X10, #0xfcc9, LSL #0
    MOVK  X10, #0xc1d2, LSL #16
    MOVK  X10, #0xf8f6, LSL #32
    MOVK  X10, #0xa418, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X10, #0xdaee, LSL #0
    MOVK  X10, #0x5850, LSL #16
    MOVK  X10, #0xf82e, LSL #32
    MOVK  X10, #0x8b2f, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D19
    MOVZ  X10, #0x7955, LSL #0
    MOVK  X10, #0x3f60, LSL #16
    MOVK  X10, #0x61e0, LSL #32
    MOVK  X10, #0x4c3e, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X10, #0xd251, LSL #0
    MOVK  X10, #0x1d6b, LSL #16
    MOVK  X10, #0xf738, LSL #32
    MOVK  X10, #0x8d73, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D20
    MOVZ  X10, #0x8876, LSL #0
    MOVK  X10, #0x8d8d, LSL #16
    MOVK  X10, #0x9378, LSL #32
    MOVK  X10, #0x9495, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X10, #0x7569, LSL #0
    MOVK  X10, #0xf161, LSL #16
    MOVK  X10, #0xf188, LSL #32
    MOVK  X10, #0x1fc4, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D21
    MOVZ  X10, #0x911d, LSL #0
    MOVK  X10, #0xcb27, LSL #16
    MOVK  X10, #0x63ee, LSL #32
    MOVK  X10, #0xf09d, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X10, #0x8f8c, LSL #0
    MOVK  X10, #0x68af, LSL #16
    MOVK  X10, #0x7fa5, LSL #32
    MOVK  X10, #0x5e75, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D22
    MOVZ  X10, #0x7521, LSL #0
    MOVK  X10, #0x1652, LSL #16
    MOVK  X10, #0xab85, LSL #32
    MOVK  X10, #0xab0f, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X10, #0x37a0, LSL #0
    MOVK  X10, #0x2022, LSL #16
    MOVK  X10, #0x8d80, LSL #32
    MOVK  X10, #0x8554, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D23
    MOVZ  X10, #0x924c, LSL #0
    MOVK  X10, #0x71cc, LSL #16
    MOVK  X10, #0x31e8, LSL #32
    MOVK  X10, #0x7494, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X10, #0x90f9, LSL #0
    MOVK  X10, #0x9621, LSL #16
    MOVK  X10, #0xb20d, LSL #32
    MOVK  X10, #0xdbb3, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D24
    MOVZ  X10, #0x49dc, LSL #0
    MOVK  X10, #0x2629, LSL #16
    MOVK  X10, #0x6b6d, LSL #32
    MOVK  X10, #0xe614, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X10, #0xc02c, LSL #0
    MOVK  X10, #0xbe74, LSL #16
    MOVK  X10, #0x3ce5, LSL #32
    MOVK  X10, #0xdff, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D25
    MOVZ  X10, #0x688b, LSL #0
    MOVK  X10, #0xd8b2, LSL #16
    MOVK  X10, #0x80d7, LSL #32
    MOVK  X10, #0x514d, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X10, #0x21bc, LSL #0
    MOVK  X10, #0xca6d, LSL #16
    MOVK  X10, #0x9ee6, LSL #32
    MOVK  X10, #0xee03, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D26
    MOVZ  X10, #0x5c2, LSL #0
    MOVK  X10, #0xc653, LSL #16
    MOVK  X10, #0xb058, LSL #32
    MOVK  X10, #0x56f8, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X10, #0x4fac, LSL #0
    MOVK  X10, #0xca4d, LSL #16
    MOVK  X10, #0x68f3, LSL #32
    MOVK  X10, #0x4372, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D27
    MOVZ  X10, #0xe5db, LSL #0
    MOVK  X10, #0x3e4d, LSL #16
    MOVK  X10, #0xaa19, LSL #32
    MOVK  X10, #0x2664, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X10, #0x47a6, LSL #0
    MOVK  X10, #0x6816, LSL #16
    MOVK  X10, #0xb2a2, LSL #32
    MOVK  X10, #0x90c7, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D28
    MOVZ  X10, #0xa7c6, LSL #0
    MOVK  X10, #0x2cc9, LSL #16
    MOVK  X10, #0xdb06, LSL #32
    MOVK  X10, #0xf1d7, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X10, #0x65a3, LSL #0
    MOVK  X10, #0xb99f, LSL #16
    MOVK  X10, #0xd88f, LSL #32
    MOVK  X10, #0x9fad, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D29
    MOVZ  X10, #0x31af, LSL #0
    MOVK  X10, #0x8114, LSL #16
    MOVK  X10, #0xacb2, LSL #32
    MOVK  X10, #0x676e, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X10, #0xb63a, LSL #0
    MOVK  X10, #0x7505, LSL #16
    MOVK  X10, #0x6c24, LSL #32
    MOVK  X10, #0xa812, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D30
    MOVZ  X10, #0xaffa, LSL #0
    MOVK  X10, #0xd131, LSL #16
    MOVK  X10, #0x1ba3, LSL #32
    MOVK  X10, #0x6720, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X10, #0xd1f0, LSL #0
    MOVK  X10, #0x5b, LSL #16
    MOVK  X10, #0x30ed, LSL #32
    MOVK  X10, #0x1741, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X11, D31
    MOVZ  X10, #0x561e, LSL #0
    MOVK  X10, #0x6205, LSL #16
    MOVK  X10, #0x4c12, LSL #32
    MOVK  X10, #0xa1f8, LSL #48
    SUB  X7, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X9
    FMOV  V0.D[1], X14
    FMOV  D1, X19
    FMOV  V1.D[1], X17
    FMOV  D2, X10
    FMOV  V2.D[1], X11
    FMOV  D3, X6
    FMOV  V3.D[1], X9
    FMOV  D4, X20
    FMOV  V4.D[1], X16
    FMOV  D5, X10
    FMOV  V5.D[1], X23
    FMOV  D6, X18
    FMOV  V6.D[1], X28
    FMOV  D7, X22
    FMOV  V7.D[1], X21
    FMOV  D8, X12
    FMOV  V8.D[1], X21
    FMOV  D9, X19
    FMOV  V9.D[1], X7
    FMOV  D10, X12
    FMOV  V10.D[1], X2
    FMOV  D11, X4
    FMOV  V11.D[1], X7
    FMOV  D12, X11
    FMOV  V12.D[1], X11
    FMOV  D13, X22
    FMOV  V13.D[1], X13
    FMOV  D14, X18
    FMOV  V14.D[1], X28
    FMOV  D15, X5
    FMOV  V15.D[1], X20
    FMOV  D16, X13
    FMOV  V16.D[1], X8
    FMOV  D17, X8
    FMOV  V17.D[1], X21
    FMOV  D18, X9
    FMOV  V18.D[1], X9
    FMOV  D19, X16
    FMOV  V19.D[1], X13
    FMOV  D20, X9
    FMOV  V20.D[1], X11
    FMOV  D21, X20
    FMOV  V21.D[1], X23
    FMOV  D22, X6
    FMOV  V22.D[1], X8
    FMOV  D23, X6
    FMOV  V23.D[1], X21
    FMOV  D24, X17
    FMOV  V24.D[1], X10
    FMOV  D25, X21
    FMOV  V25.D[1], X20
    FMOV  D26, X5
    FMOV  V26.D[1], X5
    FMOV  D27, X13
    FMOV  V27.D[1], X5
    FMOV  D28, X14
    FMOV  V28.D[1], X19
    FMOV  D29, X22
    FMOV  V29.D[1], X13
    FMOV  D30, X20
    FMOV  V30.D[1], X12
    FMOV  D31, X18
    FMOV  V31.D[1], X15
    MOVZ  X5, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_6:
    SHA512H2 Q17, Q30, V28.2D
    SM4EKEY V6.4S, V29.4S, V13.4S
    SM4E V13.4S, V31.4S
    SM3SS1 V2.4S, V20.4S, V13.4S, V8.4S
    SM3PARTW1 V24.4S, V21.4S, V25.4S
    SHA512H Q26, Q6, V6.2D
    SM3TT2A V13.4S, V6.4S, V5.S[0x1]
    BCAX V14.16B, V7.16B, V26.16B, V2.16B
    SM3PARTW1 V6.4S, V24.4S, V24.4S
    SHA512SU0 V21.2D, V26.2D
    SM4EKEY V23.4S, V14.4S, V21.4S
    SM3PARTW2 V29.4S, V7.4S, V9.4S
    BCAX V7.16B, V13.16B, V18.16B, V10.16B
    SM4E V29.4S, V7.4S
    XAR V30.2D, V23.2D, V6.2D, #0xf
    BCAX V23.16B, V30.16B, V20.16B, V17.16B
    RAX1 V23.2D, V29.2D, V29.2D
    SM4EKEY V29.4S, V17.4S, V23.4S
    SM4E V18.4S, V3.4S
    RAX1 V2.2D, V27.2D, V28.2D
    SHA512H Q28, Q15, V2.2D
    SHA512SU0 V23.2D, V11.2D
    SHA512H Q17, Q22, V13.2D
    SHA512SU0 V25.2D, V5.2D
    SM3PARTW1 V10.4S, V7.4S, V25.4S
    XAR V9.2D, V4.2D, V26.2D, #0x23
    RAX1 V26.2D, V6.2D, V13.2D
    SHA512SU1 V5.2D, V13.2D, V3.2D
    SM3SS1 V6.4S, V8.4S, V10.4S, V10.4S
    SM3PARTW2 V14.4S, V19.4S, V6.4S
    EOR3 V24.16B, V28.16B, V26.16B, V3.16B
    XAR V13.2D, V29.2D, V5.2D, #0x30
    SHA512SU1 V28.2D, V14.2D, V3.2D
    SM4EKEY V21.4S, V23.4S, V23.4S
    EOR3 V27.16B, V18.16B, V17.16B, V21.16B
    SM3SS1 V21.4S, V22.4S, V0.4S, V28.4S
    SHA512SU0 V17.2D, V24.2D
    XAR V18.2D, V11.2D, V9.2D, #0x2d
    XAR V21.2D, V18.2D, V4.2D, #0xf
    SM3TT2A V11.4S, V31.4S, V30.S[0x1]
    SM3TT2B V15.4S, V13.4S, V14.S[0x2]
    SM3TT1B V3.4S, V4.4S, V7.S[0x3]
    RAX1 V13.2D, V21.2D, V30.2D
    SM3TT1A V2.4S, V3.4S, V13.S[0x2]
    SM4EKEY V25.4S, V15.4S, V9.4S
    SHA512H Q3, Q27, V30.2D
    SM4E V7.4S, V3.4S
    EOR3 V24.16B, V2.16B, V2.16B, V7.16B
    SM4E V27.4S, V11.4S
    SM4EKEY V21.4S, V25.4S, V27.4S
    XAR V11.2D, V21.2D, V9.2D, #0xc
    SM4E V23.4S, V11.4S
    XAR V24.2D, V24.2D, V24.2D, #0x2e
    SHA512SU1 V30.2D, V16.2D, V19.2D
    XAR V28.2D, V17.2D, V28.2D, #0x1e
    SHA512H Q29, Q1, V30.2D
    SM3TT1B V9.4S, V31.4S, V21.S[0x0]
    SM3TT1B V21.4S, V9.4S, V24.S[0x1]
    SM3PARTW1 V13.4S, V2.4S, V29.4S
    SM4E V24.4S, V23.4S
    SM3TT2B V5.4S, V18.4S, V24.S[0x3]
    SHA512SU1 V7.2D, V8.2D, V28.2D
    SHA512SU0 V25.2D, V2.2D
    SM4EKEY V15.4S, V13.4S, V13.4S
    SM3TT1A V11.4S, V15.4S, V15.S[0x1]
    SM3TT2B V24.4S, V2.4S, V10.S[0x2]
    EOR3 V27.16B, V21.16B, V25.16B, V30.16B
    SHA512SU1 V19.2D, V27.2D, V11.2D
    BCAX V21.16B, V7.16B, V24.16B, V19.16B
    XAR V30.2D, V27.2D, V30.2D, #0x26
    SM4EKEY V1.4S, V17.4S, V15.4S
    SM3TT2A V11.4S, V4.4S, V8.S[0x0]
    SM4EKEY V7.4S, V24.4S, V13.4S
    EOR3 V25.16B, V24.16B, V23.16B, V26.16B
    XAR V13.2D, V13.2D, V24.2D, #0x3b
    SHA512H2 Q14, Q8, V13.2D
    EOR3 V4.16B, V27.16B, V25.16B, V3.16B
    SM4EKEY V15.4S, V8.4S, V8.4S
    SHA512SU0 V8.2D, V5.2D
    SHA512H2 Q24, Q11, V7.2D
    SM4EKEY V20.4S, V1.4S, V22.4S
    SHA512SU1 V9.2D, V8.2D, V28.2D
    SHA512H2 Q18, Q20, V9.2D
    SM3TT1B V2.4S, V24.4S, V11.S[0x0]
    SM4EKEY V31.4S, V15.4S, V14.4S
    SM4EKEY V31.4S, V18.4S, V4.4S
    RAX1 V13.2D, V6.2D, V10.2D
    SHA512H Q5, Q30, V31.2D
    SHA512H Q25, Q29, V7.2D
    SM3SS1 V11.4S, V5.4S, V9.4S, V25.4S
    SM3TT2B V27.4S, V20.4S, V29.S[0x1]
    SHA512SU1 V8.2D, V7.2D, V29.2D
    SM3TT1A V26.4S, V11.4S, V13.S[0x0]
    SM3TT1A V13.4S, V27.4S, V1.S[0x1]
    BCAX V25.16B, V16.16B, V11.16B, V15.16B
    SHA512SU0 V16.2D, V21.2D
    BCAX V23.16B, V8.16B, V3.16B, V13.16B
    SHA512SU0 V21.2D, V26.2D
    SHA512SU1 V28.2D, V21.2D, V16.2D
    XAR V29.2D, V18.2D, V28.2D, #0x36
    SM4E V3.4S, V4.4S
    SM4EKEY V18.4S, V23.4S, V4.4S
    SM4EKEY V6.4S, V18.4S, V2.4S
    XAR V8.2D, V26.2D, V25.2D, #0x1b
    SM3PARTW1 V13.4S, V6.4S, V17.4S
    EOR3 V7.16B, V8.16B, V29.16B, V3.16B
    SHA512H Q26, Q14, V30.2D
    SM3TT2B V11.4S, V9.4S, V17.S[0x0]
    SM3TT2A V5.4S, V30.4S, V18.S[0x0]
    SM3TT1B V4.4S, V9.4S, V5.S[0x2]
    SM4E V27.4S, V3.4S
    SM3TT2A V5.4S, V16.4S, V19.S[0x3]
    BCAX V23.16B, V27.16B, V0.16B, V29.16B
    SHA512H Q29, Q15, V12.2D
    SM3SS1 V10.4S, V13.4S, V26.4S, V14.4S
    SM4E V15.4S, V9.4S
    SHA512SU0 V2.2D, V7.2D
    SM4E V28.4S, V31.4S
    SM3PARTW2 V31.4S, V23.4S, V15.4S
    EOR3 V0.16B, V10.16B, V28.16B, V28.16B
    XAR V10.2D, V11.2D, V4.2D, #0x0
    SM3TT1A V9.4S, V0.4S, V29.S[0x1]
    RAX1 V3.2D, V7.2D, V26.2D
    BCAX V8.16B, V1.16B, V12.16B, V2.16B
    SHA512SU0 V23.2D, V3.2D
    SM4EKEY V7.4S, V22.4S, V31.4S
    EOR3 V22.16B, V5.16B, V12.16B, V0.16B
    SM3SS1 V30.4S, V8.4S, V26.4S, V7.4S
    XAR V3.2D, V9.2D, V30.2D, #0x16
    BCAX V14.16B, V23.16B, V23.16B, V7.16B
    SM4EKEY V31.4S, V10.4S, V18.4S
    SM3SS1 V17.4S, V28.4S, V3.4S, V5.4S
    BCAX V7.16B, V6.16B, V26.16B, V7.16B
    SM4EKEY V4.4S, V31.4S, V17.4S
    EOR3 V29.16B, V7.16B, V20.16B, V26.16B
    RAX1 V16.2D, V29.2D, V21.2D
    RAX1 V3.2D, V31.2D, V4.2D
    RAX1 V21.2D, V14.2D, V20.2D
    SM3PARTW2 V14.4S, V8.4S, V10.4S
    SM3TT2B V29.4S, V3.4S, V22.S[0x0]
    SHA512SU0 V20.2D, V31.2D
    SM3PARTW1 V0.4S, V20.4S, V20.4S
    BCAX V12.16B, V8.16B, V14.16B, V14.16B
    EOR3 V9.16B, V16.16B, V2.16B, V4.16B
    RAX1 V13.2D, V21.2D, V0.2D
    EOR3 V18.16B, V19.16B, V12.16B, V10.16B
    SHA512H2 Q11, Q2, V10.2D
    SM4EKEY V19.4S, V9.4S, V11.4S
    SM3TT2A V2.4S, V18.4S, V16.S[0x3]
    SHA512H Q31, Q30, V13.2D
    XAR V6.2D, V2.2D, V14.2D, #0x0
    SM4EKEY V19.4S, V10.4S, V19.4S
    SM4E V3.4S, V14.4S
    SM4E V25.4S, V3.4S
    RAX1 V9.2D, V19.2D, V19.2D
    SM3SS1 V8.4S, V3.4S, V6.4S, V6.4S
    BCAX V12.16B, V21.16B, V16.16B, V29.16B
    SM3TT2A V0.4S, V30.4S, V30.S[0x2]
    SHA512SU0 V21.2D, V31.2D
    SM3TT1B V30.4S, V21.4S, V12.S[0x2]
    SM4EKEY V31.4S, V30.4S, V0.4S
    SM3TT1B V0.4S, V7.4S, V8.S[0x3]
    SM3TT1B V16.4S, V21.4S, V31.S[0x2]
    RAX1 V12.2D, V5.2D, V25.2D
    SM3PARTW1 V29.4S, V16.4S, V0.4S
    EOR3 V31.16B, V22.16B, V29.16B, V21.16B
    SM4EKEY V10.4S, V31.4S, V9.4S
    XAR V8.2D, V15.2D, V9.2D, #0x3b
    SHA512H Q27, Q3, V15.2D
    SM4E V0.4S, V19.4S
    SHA512H2 Q9, Q31, V0.2D
    SHA512H Q30, Q30, V6.2D
    SM3TT2B V18.4S, V5.4S, V0.S[0x3]
    RAX1 V22.2D, V16.2D, V8.2D
    SM4EKEY V6.4S, V17.4S, V25.4S
    SM3TT2B V29.4S, V2.4S, V18.S[0x3]
    SM3TT1A V16.4S, V28.4S, V5.S[0x1]
    SM3TT1A V8.4S, V11.4S, V16.S[0x2]
    SM4E V28.4S, V6.4S
    SM4E V17.4S, V29.4S
    SM4EKEY V0.4S, V10.4S, V22.4S
    XAR V5.2D, V30.2D, V27.2D, #0x17
    XAR V29.2D, V8.2D, V20.2D, #0x33
    SHA512H2 Q20, Q5, V9.2D
    SM3PARTW1 V2.4S, V17.4S, V5.4S
    SM4EKEY V8.4S, V2.4S, V2.4S
    SM4E V9.4S, V29.4S
    RAX1 V22.2D, V0.2D, V20.2D
    SM4E V15.4S, V22.4S
    SM3PARTW2 V5.4S, V12.4S, V9.4S
    SHA512SU1 V25.2D, V30.2D, V8.2D
    SM4E V2.4S, V5.4S
    SHA512SU1 V22.2D, V23.2D, V28.2D
    SM3PARTW1 V29.4S, V23.4S, V25.4S
    SM3TT1B V27.4S, V2.4S, V22.S[0x0]
    SM3PARTW2 V28.4S, V9.4S, V29.4S
    SM3PARTW1 V2.4S, V1.4S, V17.4S
    SHA512SU1 V30.2D, V15.2D, V18.2D
    SHA512H Q23, Q28, V24.2D
    SHA512SU0 V16.2D, V19.2D
    SUBS  X5, X5, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_6
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X7, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X17, FPSR
    MOVZ  X7, #0x0, LSL #0
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X7, #0xd568, LSL #0
    MOVK  X7, #0xa744, LSL #16
    MOVK  X7, #0x29f0, LSL #32
    MOVK  X7, #0x24c, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D0
    MOVZ  X7, #0xeed7, LSL #0
    MOVK  X7, #0x62a8, LSL #16
    MOVK  X7, #0xe498, LSL #32
    MOVK  X7, #0x8f9a, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X7, #0xabd0, LSL #0
    MOVK  X7, #0xd031, LSL #16
    MOVK  X7, #0x605e, LSL #32
    MOVK  X7, #0x4176, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D1
    MOVZ  X7, #0x8626, LSL #0
    MOVK  X7, #0x1aed, LSL #16
    MOVK  X7, #0x2815, LSL #32
    MOVK  X7, #0x33ab, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X7, #0x6f4b, LSL #0
    MOVK  X7, #0xadfb, LSL #16
    MOVK  X7, #0x2843, LSL #32
    MOVK  X7, #0x36bc, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D2
    MOVZ  X7, #0xdad6, LSL #0
    MOVK  X7, #0xa1c2, LSL #16
    MOVK  X7, #0x1c2b, LSL #32
    MOVK  X7, #0x975e, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X7, #0xe6dc, LSL #0
    MOVK  X7, #0x6552, LSL #16
    MOVK  X7, #0x5170, LSL #32
    MOVK  X7, #0x2423, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D3
    MOVZ  X7, #0x810e, LSL #0
    MOVK  X7, #0xce65, LSL #16
    MOVK  X7, #0x2602, LSL #32
    MOVK  X7, #0x4a39, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X7, #0x32cf, LSL #0
    MOVK  X7, #0x2533, LSL #16
    MOVK  X7, #0x3f4, LSL #32
    MOVK  X7, #0x825f, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D4
    MOVZ  X7, #0xe56a, LSL #0
    MOVK  X7, #0xe5e6, LSL #16
    MOVK  X7, #0x7d7f, LSL #32
    MOVK  X7, #0xade2, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X7, #0xba48, LSL #0
    MOVK  X7, #0xdced, LSL #16
    MOVK  X7, #0xa91, LSL #32
    MOVK  X7, #0xfb07, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D5
    MOVZ  X7, #0x11e0, LSL #0
    MOVK  X7, #0xea9e, LSL #16
    MOVK  X7, #0xadab, LSL #32
    MOVK  X7, #0xb362, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X7, #0x6fb8, LSL #0
    MOVK  X7, #0xdac9, LSL #16
    MOVK  X7, #0x4ae5, LSL #32
    MOVK  X7, #0xa6d7, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D6
    MOVZ  X7, #0xf094, LSL #0
    MOVK  X7, #0xad78, LSL #16
    MOVK  X7, #0x1674, LSL #32
    MOVK  X7, #0xd204, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X7, #0xe534, LSL #0
    MOVK  X7, #0x1da1, LSL #16
    MOVK  X7, #0xf123, LSL #32
    MOVK  X7, #0xb34e, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D7
    MOVZ  X7, #0x64b1, LSL #0
    MOVK  X7, #0x717d, LSL #16
    MOVK  X7, #0xfeb, LSL #32
    MOVK  X7, #0xe27c, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X7, #0xf2ac, LSL #0
    MOVK  X7, #0xa0c8, LSL #16
    MOVK  X7, #0x727b, LSL #32
    MOVK  X7, #0x3d9e, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D8
    MOVZ  X7, #0xf9c5, LSL #0
    MOVK  X7, #0xf516, LSL #16
    MOVK  X7, #0xfba6, LSL #32
    MOVK  X7, #0x3743, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X7, #0x39bf, LSL #0
    MOVK  X7, #0xf2aa, LSL #16
    MOVK  X7, #0x90b4, LSL #32
    MOVK  X7, #0x5f2b, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D9
    MOVZ  X7, #0xe264, LSL #0
    MOVK  X7, #0xc609, LSL #16
    MOVK  X7, #0x13a1, LSL #32
    MOVK  X7, #0xff75, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X7, #0xa3ad, LSL #0
    MOVK  X7, #0x3c22, LSL #16
    MOVK  X7, #0x2a8f, LSL #32
    MOVK  X7, #0xb9cf, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D10
    MOVZ  X7, #0x8349, LSL #0
    MOVK  X7, #0xc1e8, LSL #16
    MOVK  X7, #0x9c54, LSL #32
    MOVK  X7, #0x3e3f, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X7, #0x2b82, LSL #0
    MOVK  X7, #0xc965, LSL #16
    MOVK  X7, #0x545f, LSL #32
    MOVK  X7, #0x68f0, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D11
    MOVZ  X7, #0xdf45, LSL #0
    MOVK  X7, #0xd9ec, LSL #16
    MOVK  X7, #0x4d60, LSL #32
    MOVK  X7, #0xc069, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X7, #0xdcda, LSL #0
    MOVK  X7, #0xe5c6, LSL #16
    MOVK  X7, #0x8bc2, LSL #32
    MOVK  X7, #0x39f4, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D12
    MOVZ  X7, #0xc1f2, LSL #0
    MOVK  X7, #0xbd94, LSL #16
    MOVK  X7, #0x8485, LSL #32
    MOVK  X7, #0xaad6, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X7, #0x3a0b, LSL #0
    MOVK  X7, #0xc781, LSL #16
    MOVK  X7, #0x31fd, LSL #32
    MOVK  X7, #0x9860, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D13
    MOVZ  X7, #0x55a, LSL #0
    MOVK  X7, #0x9440, LSL #16
    MOVK  X7, #0x1a48, LSL #32
    MOVK  X7, #0x84c4, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X7, #0x3bc, LSL #0
    MOVK  X7, #0xb860, LSL #16
    MOVK  X7, #0xbced, LSL #32
    MOVK  X7, #0xafbd, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D14
    MOVZ  X7, #0x9747, LSL #0
    MOVK  X7, #0x2405, LSL #16
    MOVK  X7, #0xabb6, LSL #32
    MOVK  X7, #0x9ff9, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X7, #0xd78, LSL #0
    MOVK  X7, #0x462f, LSL #16
    MOVK  X7, #0x37b8, LSL #32
    MOVK  X7, #0xaa41, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D15
    MOVZ  X7, #0xbedc, LSL #0
    MOVK  X7, #0x623b, LSL #16
    MOVK  X7, #0xf080, LSL #32
    MOVK  X7, #0x175c, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X7, #0xf480, LSL #0
    MOVK  X7, #0x481b, LSL #16
    MOVK  X7, #0x896e, LSL #32
    MOVK  X7, #0x3959, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D16
    MOVZ  X7, #0xa460, LSL #0
    MOVK  X7, #0xcd44, LSL #16
    MOVK  X7, #0x527f, LSL #32
    MOVK  X7, #0xa47f, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X7, #0x3f76, LSL #0
    MOVK  X7, #0x801d, LSL #16
    MOVK  X7, #0xa855, LSL #32
    MOVK  X7, #0xa286, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D17
    MOVZ  X7, #0x4ec7, LSL #0
    MOVK  X7, #0xd0fa, LSL #16
    MOVK  X7, #0xf64b, LSL #32
    MOVK  X7, #0x3a24, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X7, #0x1ade, LSL #0
    MOVK  X7, #0x55ef, LSL #16
    MOVK  X7, #0xcce1, LSL #32
    MOVK  X7, #0x9b75, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D18
    MOVZ  X7, #0x6f74, LSL #0
    MOVK  X7, #0xcf76, LSL #16
    MOVK  X7, #0x8cce, LSL #32
    MOVK  X7, #0x8bef, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X7, #0x834, LSL #0
    MOVK  X7, #0xf1da, LSL #16
    MOVK  X7, #0x33d4, LSL #32
    MOVK  X7, #0x640, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D19
    MOVZ  X7, #0xd905, LSL #0
    MOVK  X7, #0x954c, LSL #16
    MOVK  X7, #0x4fef, LSL #32
    MOVK  X7, #0x1e90, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X7, #0x7a3d, LSL #0
    MOVK  X7, #0x1efc, LSL #16
    MOVK  X7, #0x88ce, LSL #32
    MOVK  X7, #0xbb3a, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D20
    MOVZ  X7, #0xede0, LSL #0
    MOVK  X7, #0x3c39, LSL #16
    MOVK  X7, #0x398d, LSL #32
    MOVK  X7, #0x4891, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X7, #0x5b5e, LSL #0
    MOVK  X7, #0xc87c, LSL #16
    MOVK  X7, #0x757b, LSL #32
    MOVK  X7, #0x706d, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D21
    MOVZ  X7, #0xb543, LSL #0
    MOVK  X7, #0x3ca3, LSL #16
    MOVK  X7, #0xc3ce, LSL #32
    MOVK  X7, #0x5b30, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X7, #0xf872, LSL #0
    MOVK  X7, #0x31a8, LSL #16
    MOVK  X7, #0x4715, LSL #32
    MOVK  X7, #0x3edd, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D22
    MOVZ  X7, #0xbb00, LSL #0
    MOVK  X7, #0xdc5d, LSL #16
    MOVK  X7, #0x6345, LSL #32
    MOVK  X7, #0x5c07, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X7, #0x2173, LSL #0
    MOVK  X7, #0xa9f4, LSL #16
    MOVK  X7, #0x6a6a, LSL #32
    MOVK  X7, #0xce40, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D23
    MOVZ  X7, #0x3eae, LSL #0
    MOVK  X7, #0xac5b, LSL #16
    MOVK  X7, #0xdefd, LSL #32
    MOVK  X7, #0xda4c, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X7, #0x494a, LSL #0
    MOVK  X7, #0x4404, LSL #16
    MOVK  X7, #0x4ce8, LSL #32
    MOVK  X7, #0xe625, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D24
    MOVZ  X7, #0x1507, LSL #0
    MOVK  X7, #0xff8b, LSL #16
    MOVK  X7, #0xf224, LSL #32
    MOVK  X7, #0x56eb, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X7, #0x140f, LSL #0
    MOVK  X7, #0xf3d3, LSL #16
    MOVK  X7, #0x5491, LSL #32
    MOVK  X7, #0x2f52, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D25
    MOVZ  X7, #0xe898, LSL #0
    MOVK  X7, #0xc0e0, LSL #16
    MOVK  X7, #0xfeee, LSL #32
    MOVK  X7, #0xdba5, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X7, #0xec2f, LSL #0
    MOVK  X7, #0xdc7b, LSL #16
    MOVK  X7, #0xdf2e, LSL #32
    MOVK  X7, #0x750b, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D26
    MOVZ  X7, #0xef0a, LSL #0
    MOVK  X7, #0x5a14, LSL #16
    MOVK  X7, #0x5e7d, LSL #32
    MOVK  X7, #0x718e, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X7, #0xaec4, LSL #0
    MOVK  X7, #0x79d, LSL #16
    MOVK  X7, #0x10af, LSL #32
    MOVK  X7, #0xc4a, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D27
    MOVZ  X7, #0x6309, LSL #0
    MOVK  X7, #0x9e3e, LSL #16
    MOVK  X7, #0xfe80, LSL #32
    MOVK  X7, #0x8483, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X7, #0x8aa0, LSL #0
    MOVK  X7, #0xaba4, LSL #16
    MOVK  X7, #0xbde1, LSL #32
    MOVK  X7, #0x4383, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D28
    MOVZ  X7, #0x2d4a, LSL #0
    MOVK  X7, #0x9669, LSL #16
    MOVK  X7, #0xe88a, LSL #32
    MOVK  X7, #0x394d, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X7, #0x7504, LSL #0
    MOVK  X7, #0xa36b, LSL #16
    MOVK  X7, #0xe913, LSL #32
    MOVK  X7, #0xd118, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D29
    MOVZ  X7, #0x431d, LSL #0
    MOVK  X7, #0xc591, LSL #16
    MOVK  X7, #0xcb50, LSL #32
    MOVK  X7, #0x6285, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X7, #0xa4c3, LSL #0
    MOVK  X7, #0x4215, LSL #16
    MOVK  X7, #0x2e4f, LSL #32
    MOVK  X7, #0xf231, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D30
    MOVZ  X7, #0x993a, LSL #0
    MOVK  X7, #0x8143, LSL #16
    MOVK  X7, #0xa0f1, LSL #32
    MOVK  X7, #0xcfe8, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X7, #0x62b9, LSL #0
    MOVK  X7, #0xb50e, LSL #16
    MOVK  X7, #0xd08c, LSL #32
    MOVK  X7, #0xe409, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D31
    MOVZ  X7, #0xdd28, LSL #0
    MOVK  X7, #0x72, LSL #16
    MOVK  X7, #0xa7a0, LSL #32
    MOVK  X7, #0x2514, LSL #48
    SUB  X2, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X19
    FMOV  D1, X18
    FMOV  V1.D[1], X20
    FMOV  D2, X22
    FMOV  V2.D[1], X21
    FMOV  D3, X11
    FMOV  V3.D[1], X15
    FMOV  D4, X10
    FMOV  V4.D[1], X23
    FMOV  D5, X19
    FMOV  V5.D[1], X15
    FMOV  D6, X19
    FMOV  V6.D[1], X4
    FMOV  D7, X22
    FMOV  V7.D[1], X18
    FMOV  D8, X15
    FMOV  V8.D[1], X15
    FMOV  D9, X16
    FMOV  V9.D[1], X20
    FMOV  D10, X5
    FMOV  V10.D[1], X8
    FMOV  D11, X9
    FMOV  V11.D[1], X22
    FMOV  D12, X14
    FMOV  V12.D[1], X19
    FMOV  D13, X3
    FMOV  V13.D[1], X19
    FMOV  D14, X23
    FMOV  V14.D[1], X11
    FMOV  D15, X14
    FMOV  V15.D[1], X19
    FMOV  D16, X20
    FMOV  V16.D[1], X16
    FMOV  D17, X19
    FMOV  V17.D[1], X18
    FMOV  D18, X17
    FMOV  V18.D[1], X6
    FMOV  D19, X23
    FMOV  V19.D[1], X22
    FMOV  D20, X2
    FMOV  V20.D[1], X4
    FMOV  D21, X3
    FMOV  V21.D[1], X7
    FMOV  D22, X11
    FMOV  V22.D[1], X16
    FMOV  D23, X19
    FMOV  V23.D[1], X6
    FMOV  D24, X5
    FMOV  V24.D[1], X4
    FMOV  D25, X8
    FMOV  V25.D[1], X16
    FMOV  D26, X5
    FMOV  V26.D[1], X2
    FMOV  D27, X8
    FMOV  V27.D[1], X13
    FMOV  D28, X20
    FMOV  V28.D[1], X7
    FMOV  D29, X7
    FMOV  V29.D[1], X10
    FMOV  D30, X18
    FMOV  V30.D[1], X17
    FMOV  D31, X9
    FMOV  V31.D[1], X19
    MOVZ  X21, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_7:
    SM4EKEY V30.4S, V29.4S, V27.4S
    SM3TT1B V0.4S, V30.4S, V16.S[0x0]
    SM3TT2B V6.4S, V26.4S, V0.S[0x1]
    SM3TT2A V31.4S, V31.4S, V30.S[0x2]
    SHA512H Q22, Q12, V19.2D
    SHA512H2 Q27, Q1, V20.2D
    SHA512SU1 V17.2D, V12.2D, V25.2D
    SHA512H2 Q14, Q17, V30.2D
    BCAX V24.16B, V27.16B, V14.16B, V29.16B
    SM3PARTW2 V27.4S, V16.4S, V28.4S
    SM3TT2B V11.4S, V30.4S, V24.S[0x2]
    EOR3 V22.16B, V6.16B, V6.16B, V6.16B
    RAX1 V6.2D, V31.2D, V23.2D
    XAR V5.2D, V27.2D, V6.2D, #0x8
    SM3PARTW2 V27.4S, V22.4S, V22.4S
    BCAX V24.16B, V6.16B, V27.16B, V11.16B
    SHA512H2 Q25, Q9, V14.2D
    XAR V22.2D, V15.2D, V12.2D, #0x37
    SM3TT1B V27.4S, V12.4S, V17.S[0x1]
    SM4E V28.4S, V3.4S
    RAX1 V30.2D, V22.2D, V21.2D
    RAX1 V31.2D, V15.2D, V8.2D
    SHA512H Q3, Q11, V23.2D
    EOR3 V19.16B, V22.16B, V28.16B, V28.16B
    EOR3 V23.16B, V4.16B, V22.16B, V17.16B
    SM4EKEY V15.4S, V23.4S, V8.4S
    XAR V8.2D, V5.2D, V25.2D, #0x17
    SM3SS1 V12.4S, V20.4S, V6.4S, V30.4S
    SM4E V20.4S, V15.4S
    SHA512H2 Q1, Q31, V20.2D
    SM4E V20.4S, V12.4S
    XAR V2.2D, V7.2D, V24.2D, #0x19
    SM4E V31.4S, V27.4S
    SHA512H2 Q30, Q1, V17.2D
    BCAX V12.16B, V25.16B, V5.16B, V19.16B
    SM4EKEY V16.4S, V12.4S, V12.4S
    SM3SS1 V25.4S, V20.4S, V16.4S, V30.4S
    SM4EKEY V19.4S, V31.4S, V1.4S
    XAR V17.2D, V8.2D, V15.2D, #0x30
    SM4E V31.4S, V2.4S
    SM3PARTW1 V20.4S, V9.4S, V24.4S
    RAX1 V5.2D, V31.2D, V3.2D
    SHA512SU1 V9.2D, V4.2D, V14.2D
    BCAX V14.16B, V20.16B, V5.16B, V9.16B
    XAR V6.2D, V25.2D, V17.2D, #0x8
    SM3SS1 V7.4S, V26.4S, V19.4S, V19.4S
    SHA512H2 Q11, Q7, V6.2D
    EOR3 V25.16B, V25.16B, V25.16B, V25.16B
    BCAX V6.16B, V28.16B, V18.16B, V17.16B
    EOR3 V18.16B, V2.16B, V18.16B, V9.16B
    SM4EKEY V20.4S, V16.4S, V28.4S
    SM3TT2B V4.4S, V22.4S, V17.S[0x2]
    SM3SS1 V17.4S, V23.4S, V19.4S, V26.4S
    SHA512H Q2, Q4, V7.2D
    BCAX V5.16B, V31.16B, V28.16B, V16.16B
    BCAX V27.16B, V5.16B, V18.16B, V20.16B
    SHA512SU0 V24.2D, V2.2D
    SM3PARTW1 V26.4S, V25.4S, V14.4S
    SM4EKEY V23.4S, V6.4S, V19.4S
    XAR V18.2D, V24.2D, V23.2D, #0x16
    SM3TT2B V4.4S, V7.4S, V18.S[0x2]
    SHA512H Q8, Q4, V29.2D
    SM3PARTW1 V2.4S, V17.4S, V27.4S
    EOR3 V7.16B, V2.16B, V8.16B, V25.16B
    SM4EKEY V18.4S, V18.4S, V26.4S
    SM4EKEY V4.4S, V7.4S, V5.4S
    SHA512SU1 V2.2D, V13.2D, V11.2D
    SM4EKEY V16.4S, V18.4S, V14.4S
    SM3PARTW2 V27.4S, V28.4S, V16.4S
    BCAX V29.16B, V4.16B, V27.16B, V7.16B
    EOR3 V13.16B, V11.16B, V27.16B, V23.16B
    SM3PARTW2 V16.4S, V13.4S, V29.4S
    SM3SS1 V14.4S, V22.4S, V27.4S, V29.4S
    EOR3 V28.16B, V31.16B, V0.16B, V30.16B
    XAR V24.2D, V23.2D, V20.2D, #0xa
    SM4EKEY V8.4S, V18.4S, V26.4S
    XAR V9.2D, V18.2D, V14.2D, #0x1
    SHA512SU1 V19.2D, V8.2D, V0.2D
    EOR3 V11.16B, V6.16B, V1.16B, V0.16B
    SM4EKEY V17.4S, V29.4S, V18.4S
    SM4EKEY V27.4S, V7.4S, V10.4S
    SHA512SU0 V26.2D, V16.2D
    SHA512SU0 V8.2D, V19.2D
    BCAX V5.16B, V2.16B, V8.16B, V2.16B
    SHA512H2 Q0, Q30, V5.2D
    SM3TT2B V1.4S, V1.4S, V24.S[0x1]
    SM4EKEY V16.4S, V28.4S, V15.4S
    SHA512H2 Q28, Q21, V9.2D
    BCAX V4.16B, V12.16B, V29.16B, V1.16B
    SM3TT2B V15.4S, V28.4S, V22.S[0x1]
    RAX1 V28.2D, V17.2D, V5.2D
    SM4EKEY V19.4S, V28.4S, V0.4S
    EOR3 V7.16B, V11.16B, V18.16B, V19.16B
    SM4EKEY V24.4S, V28.4S, V26.4S
    SM3TT1B V22.4S, V16.4S, V16.S[0x2]
    SHA512SU1 V14.2D, V22.2D, V24.2D
    SHA512SU1 V2.2D, V7.2D, V7.2D
    SM4EKEY V19.4S, V21.4S, V15.4S
    BCAX V11.16B, V27.16B, V8.16B, V27.16B
    SM3TT1A V0.4S, V11.4S, V31.S[0x2]
    EOR3 V9.16B, V19.16B, V14.16B, V2.16B
    SHA512SU1 V19.2D, V4.2D, V25.2D
    SM4EKEY V30.4S, V24.4S, V19.4S
    SM4E V27.4S, V0.4S
    SM4E V18.4S, V20.4S
    SM3TT2B V5.4S, V18.4S, V27.S[0x0]
    SM3TT2B V5.4S, V30.4S, V9.S[0x3]
    SHA512H2 Q25, Q27, V22.2D
    RAX1 V8.2D, V13.2D, V25.2D
    SM3TT1B V30.4S, V23.4S, V20.S[0x0]
    SHA512SU0 V10.2D, V0.2D
    SHA512H2 Q25, Q0, V30.2D
    SM4EKEY V24.4S, V28.4S, V9.4S
    SHA512H2 Q7, Q19, V26.2D
    RAX1 V30.2D, V27.2D, V26.2D
    SM3SS1 V28.4S, V28.4S, V24.4S, V5.4S
    SHA512SU0 V22.2D, V22.2D
    RAX1 V4.2D, V28.2D, V4.2D
    EOR3 V24.16B, V24.16B, V20.16B, V4.16B
    SM4E V29.4S, V1.4S
    SHA512H2 Q4, Q30, V26.2D
    EOR3 V11.16B, V24.16B, V26.16B, V13.16B
    XAR V28.2D, V23.2D, V25.2D, #0x38
    SHA512SU0 V24.2D, V0.2D
    SHA512H Q1, Q21, V11.2D
    SM4EKEY V13.4S, V11.4S, V18.4S
    SHA512H Q5, Q29, V28.2D
    EOR3 V20.16B, V8.16B, V8.16B, V22.16B
    XAR V23.2D, V5.2D, V1.2D, #0x24
    RAX1 V11.2D, V20.2D, V24.2D
    SM4E V1.4S, V23.4S
    SM3TT1B V22.4S, V11.4S, V8.S[0x3]
    BCAX V3.16B, V13.16B, V4.16B, V1.16B
    SM4E V19.4S, V22.4S
    SM3TT2B V11.4S, V3.4S, V5.S[0x3]
    SM4EKEY V18.4S, V11.4S, V19.4S
    SM3TT1A V26.4S, V18.4S, V18.S[0x0]
    SHA512SU0 V20.2D, V13.2D
    SM4E V4.4S, V20.4S
    SM3SS1 V18.4S, V4.4S, V4.4S, V5.4S
    SHA512H Q30, Q26, V8.2D
    SM4EKEY V26.4S, V10.4S, V0.4S
    RAX1 V23.2D, V18.2D, V30.2D
    BCAX V11.16B, V23.16B, V7.16B, V6.16B
    SM3TT1A V7.4S, V13.4S, V12.S[0x2]
    SM4E V19.4S, V30.4S
    SM4E V6.4S, V4.4S
    SM4E V30.4S, V23.4S
    SM3TT1B V12.4S, V25.4S, V13.S[0x0]
    SHA512H Q22, Q26, V27.2D
    SHA512H2 Q1, Q3, V23.2D
    SHA512SU1 V23.2D, V28.2D, V27.2D
    SHA512H2 Q7, Q11, V0.2D
    SHA512H2 Q4, Q4, V30.2D
    SM4E V28.4S, V6.4S
    SHA512SU0 V6.2D, V12.2D
    BCAX V26.16B, V23.16B, V7.16B, V6.16B
    SM4EKEY V3.4S, V22.4S, V26.4S
    SM3SS1 V27.4S, V4.4S, V4.4S, V28.4S
    SM4E V24.4S, V19.4S
    SM3TT2B V11.4S, V1.4S, V16.S[0x1]
    SM4E V23.4S, V24.4S
    SHA512SU1 V6.2D, V31.2D, V11.2D
    XAR V11.2D, V23.2D, V27.2D, #0x30
    RAX1 V24.2D, V11.2D, V30.2D
    SM4EKEY V6.4S, V7.4S, V3.4S
    SM3TT1B V30.4S, V24.4S, V31.S[0x3]
    SM3SS1 V1.4S, V1.4S, V10.4S, V18.4S
    SHA512SU0 V18.2D, V17.2D
    SM3TT2A V12.4S, V8.4S, V5.S[0x1]
    SM3PARTW2 V12.4S, V20.4S, V3.4S
    SM3PARTW1 V17.4S, V2.4S, V6.4S
    XAR V11.2D, V20.2D, V0.2D, #0x2a
    SM4E V6.4S, V27.4S
    SM4EKEY V2.4S, V1.4S, V10.4S
    SHA512H2 Q3, Q1, V5.2D
    EOR3 V28.16B, V27.16B, V30.16B, V22.16B
    SM3PARTW1 V1.4S, V21.4S, V25.4S
    BCAX V7.16B, V12.16B, V1.16B, V11.16B
    SM3TT1B V22.4S, V15.4S, V18.S[0x2]
    SM4EKEY V12.4S, V22.4S, V18.4S
    SHA512SU0 V21.2D, V28.2D
    SM4EKEY V27.4S, V6.4S, V17.4S
    SM3SS1 V6.4S, V14.4S, V10.4S, V2.4S
    SM4E V28.4S, V25.4S
    RAX1 V22.2D, V24.2D, V6.2D
    SM3TT2B V18.4S, V27.4S, V25.S[0x1]
    SM3PARTW2 V5.4S, V7.4S, V21.4S
    SM3PARTW1 V10.4S, V28.4S, V6.4S
    SM3PARTW1 V7.4S, V27.4S, V0.4S
    SM4EKEY V28.4S, V10.4S, V19.4S
    SHA512H Q19, Q28, V7.2D
    SM4E V6.4S, V19.4S
    SM3TT2A V30.4S, V23.4S, V2.S[0x1]
    XAR V7.2D, V4.2D, V30.2D, #0x7
    SM4EKEY V24.4S, V22.4S, V31.4S
    SHA512SU1 V2.2D, V6.2D, V5.2D
    SM4EKEY V28.4S, V28.4S, V24.4S
    SHA512H Q23, Q28, V2.2D
    BCAX V20.16B, V18.16B, V12.16B, V7.16B
    SUBS  X21, X21, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_7
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X9, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    SUB  X9, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X23, FPSR
    MOVZ  X9, #0x0, LSL #0
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X9, #0xdf11, LSL #0
    MOVK  X9, #0x21e2, LSL #16
    MOVK  X9, #0x8c75, LSL #32
    MOVK  X9, #0xae6d, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D0
    MOVZ  X9, #0x3cc6, LSL #0
    MOVK  X9, #0xf5a1, LSL #16
    MOVK  X9, #0x220d, LSL #32
    MOVK  X9, #0x46c9, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X9, #0x808a, LSL #0
    MOVK  X9, #0x5ad0, LSL #16
    MOVK  X9, #0x4808, LSL #32
    MOVK  X9, #0xbc82, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D1
    MOVZ  X9, #0x4ea0, LSL #0
    MOVK  X9, #0xdf42, LSL #16
    MOVK  X9, #0xf3f8, LSL #32
    MOVK  X9, #0x89a5, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X9, #0xe11f, LSL #0
    MOVK  X9, #0x4d59, LSL #16
    MOVK  X9, #0x6e5d, LSL #32
    MOVK  X9, #0xd02e, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D2
    MOVZ  X9, #0x7cdd, LSL #0
    MOVK  X9, #0xc4bb, LSL #16
    MOVK  X9, #0x884b, LSL #32
    MOVK  X9, #0x71a3, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X9, #0xb7c7, LSL #0
    MOVK  X9, #0x3b2a, LSL #16
    MOVK  X9, #0xa15f, LSL #32
    MOVK  X9, #0xe932, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D3
    MOVZ  X9, #0x2ee1, LSL #0
    MOVK  X9, #0xa024, LSL #16
    MOVK  X9, #0xcb1c, LSL #32
    MOVK  X9, #0x9716, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X9, #0x4f39, LSL #0
    MOVK  X9, #0x1df8, LSL #16
    MOVK  X9, #0x4b0a, LSL #32
    MOVK  X9, #0xf354, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D4
    MOVZ  X9, #0x916d, LSL #0
    MOVK  X9, #0xb779, LSL #16
    MOVK  X9, #0x6427, LSL #32
    MOVK  X9, #0x6aff, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X9, #0x61bb, LSL #0
    MOVK  X9, #0xb53b, LSL #16
    MOVK  X9, #0xc3a0, LSL #32
    MOVK  X9, #0xb98c, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D5
    MOVZ  X9, #0x4bdc, LSL #0
    MOVK  X9, #0x73dd, LSL #16
    MOVK  X9, #0x1342, LSL #32
    MOVK  X9, #0x77b2, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X9, #0x131c, LSL #0
    MOVK  X9, #0xecf7, LSL #16
    MOVK  X9, #0x49c7, LSL #32
    MOVK  X9, #0xb578, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D6
    MOVZ  X9, #0xf3e2, LSL #0
    MOVK  X9, #0x2619, LSL #16
    MOVK  X9, #0x332e, LSL #32
    MOVK  X9, #0x6eb, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X9, #0xcb4f, LSL #0
    MOVK  X9, #0x5539, LSL #16
    MOVK  X9, #0x7877, LSL #32
    MOVK  X9, #0xd894, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D7
    MOVZ  X9, #0x9a1a, LSL #0
    MOVK  X9, #0x9585, LSL #16
    MOVK  X9, #0x3d04, LSL #32
    MOVK  X9, #0x86b6, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X9, #0xb178, LSL #0
    MOVK  X9, #0xed2e, LSL #16
    MOVK  X9, #0xa4d3, LSL #32
    MOVK  X9, #0xe1cb, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D8
    MOVZ  X9, #0x7381, LSL #0
    MOVK  X9, #0x86b, LSL #16
    MOVK  X9, #0xdc82, LSL #32
    MOVK  X9, #0x98ce, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X9, #0x2c2d, LSL #0
    MOVK  X9, #0x962, LSL #16
    MOVK  X9, #0xce04, LSL #32
    MOVK  X9, #0x3ad5, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D9
    MOVZ  X9, #0xcdd7, LSL #0
    MOVK  X9, #0x40a5, LSL #16
    MOVK  X9, #0xdb72, LSL #32
    MOVK  X9, #0xd049, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X9, #0x2661, LSL #0
    MOVK  X9, #0xa06b, LSL #16
    MOVK  X9, #0x99aa, LSL #32
    MOVK  X9, #0xa6f7, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D10
    MOVZ  X9, #0xb225, LSL #0
    MOVK  X9, #0x888e, LSL #16
    MOVK  X9, #0x41b9, LSL #32
    MOVK  X9, #0x7bfa, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X9, #0x388f, LSL #0
    MOVK  X9, #0xc32c, LSL #16
    MOVK  X9, #0xe8a3, LSL #32
    MOVK  X9, #0xc546, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D11
    MOVZ  X9, #0xaa47, LSL #0
    MOVK  X9, #0x38fb, LSL #16
    MOVK  X9, #0xaaa4, LSL #32
    MOVK  X9, #0x93, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X9, #0xedb2, LSL #0
    MOVK  X9, #0xee35, LSL #16
    MOVK  X9, #0xf7f6, LSL #32
    MOVK  X9, #0xb05a, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D12
    MOVZ  X9, #0xcd43, LSL #0
    MOVK  X9, #0xc6c7, LSL #16
    MOVK  X9, #0x2255, LSL #32
    MOVK  X9, #0x4680, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X9, #0xbd02, LSL #0
    MOVK  X9, #0x56a1, LSL #16
    MOVK  X9, #0xdab6, LSL #32
    MOVK  X9, #0x5c97, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D13
    MOVZ  X9, #0xaa0d, LSL #0
    MOVK  X9, #0xd0ac, LSL #16
    MOVK  X9, #0xeb8e, LSL #32
    MOVK  X9, #0x7bfc, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X9, #0x1bbd, LSL #0
    MOVK  X9, #0xa87f, LSL #16
    MOVK  X9, #0xa358, LSL #32
    MOVK  X9, #0xcaa3, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D14
    MOVZ  X9, #0x5acc, LSL #0
    MOVK  X9, #0x3c2b, LSL #16
    MOVK  X9, #0x5f57, LSL #32
    MOVK  X9, #0x15ea, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X9, #0xb607, LSL #0
    MOVK  X9, #0x41fb, LSL #16
    MOVK  X9, #0xabf1, LSL #32
    MOVK  X9, #0x37df, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D15
    MOVZ  X9, #0x1ac6, LSL #0
    MOVK  X9, #0xf52, LSL #16
    MOVK  X9, #0xf246, LSL #32
    MOVK  X9, #0x6e73, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X9, #0xb385, LSL #0
    MOVK  X9, #0xdd76, LSL #16
    MOVK  X9, #0x8f81, LSL #32
    MOVK  X9, #0x9dd3, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D16
    MOVZ  X9, #0x1aca, LSL #0
    MOVK  X9, #0x689, LSL #16
    MOVK  X9, #0x7aa8, LSL #32
    MOVK  X9, #0xaa76, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X9, #0x9ed7, LSL #0
    MOVK  X9, #0xfe67, LSL #16
    MOVK  X9, #0x88c5, LSL #32
    MOVK  X9, #0xdd13, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D17
    MOVZ  X9, #0x8c25, LSL #0
    MOVK  X9, #0x6db0, LSL #16
    MOVK  X9, #0x8d08, LSL #32
    MOVK  X9, #0x3bf1, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X9, #0x806b, LSL #0
    MOVK  X9, #0xf7d9, LSL #16
    MOVK  X9, #0x6047, LSL #32
    MOVK  X9, #0xafd0, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D18
    MOVZ  X9, #0x13aa, LSL #0
    MOVK  X9, #0x3ea0, LSL #16
    MOVK  X9, #0x50e, LSL #32
    MOVK  X9, #0x9b75, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X9, #0x8378, LSL #0
    MOVK  X9, #0x14b2, LSL #16
    MOVK  X9, #0x4229, LSL #32
    MOVK  X9, #0x2832, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D19
    MOVZ  X9, #0x4b63, LSL #0
    MOVK  X9, #0xa56, LSL #16
    MOVK  X9, #0xca45, LSL #32
    MOVK  X9, #0xc49a, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X9, #0xa4db, LSL #0
    MOVK  X9, #0x5ddd, LSL #16
    MOVK  X9, #0xe7c7, LSL #32
    MOVK  X9, #0x8f9a, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D20
    MOVZ  X9, #0x56eb, LSL #0
    MOVK  X9, #0x7ce2, LSL #16
    MOVK  X9, #0x75f, LSL #32
    MOVK  X9, #0xdb75, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X9, #0x8127, LSL #0
    MOVK  X9, #0xce7d, LSL #16
    MOVK  X9, #0xf224, LSL #32
    MOVK  X9, #0xf734, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D21
    MOVZ  X9, #0xef57, LSL #0
    MOVK  X9, #0xbaf7, LSL #16
    MOVK  X9, #0xfe4e, LSL #32
    MOVK  X9, #0x4673, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X9, #0xf0b8, LSL #0
    MOVK  X9, #0xf3b1, LSL #16
    MOVK  X9, #0xf5ec, LSL #32
    MOVK  X9, #0xb745, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D22
    MOVZ  X9, #0xa7ef, LSL #0
    MOVK  X9, #0x197a, LSL #16
    MOVK  X9, #0xb136, LSL #32
    MOVK  X9, #0xe189, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X9, #0xe8a, LSL #0
    MOVK  X9, #0x771b, LSL #16
    MOVK  X9, #0x525d, LSL #32
    MOVK  X9, #0x3600, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D23
    MOVZ  X9, #0xff0d, LSL #0
    MOVK  X9, #0xcf33, LSL #16
    MOVK  X9, #0x1abf, LSL #32
    MOVK  X9, #0x763b, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X9, #0xb387, LSL #0
    MOVK  X9, #0xb1fe, LSL #16
    MOVK  X9, #0xd22b, LSL #32
    MOVK  X9, #0x32e9, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D24
    MOVZ  X9, #0x5339, LSL #0
    MOVK  X9, #0xaadb, LSL #16
    MOVK  X9, #0xb947, LSL #32
    MOVK  X9, #0x6dd2, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X9, #0xb8b3, LSL #0
    MOVK  X9, #0x3923, LSL #16
    MOVK  X9, #0x329b, LSL #32
    MOVK  X9, #0xf0c8, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D25
    MOVZ  X9, #0x8114, LSL #0
    MOVK  X9, #0xf2b4, LSL #16
    MOVK  X9, #0x356b, LSL #32
    MOVK  X9, #0xb8f5, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X9, #0xc4a, LSL #0
    MOVK  X9, #0x316c, LSL #16
    MOVK  X9, #0x8fae, LSL #32
    MOVK  X9, #0xb564, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D26
    MOVZ  X9, #0x306f, LSL #0
    MOVK  X9, #0x3846, LSL #16
    MOVK  X9, #0x301e, LSL #32
    MOVK  X9, #0x7f34, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X9, #0xeaf1, LSL #0
    MOVK  X9, #0xb41d, LSL #16
    MOVK  X9, #0x82d0, LSL #32
    MOVK  X9, #0x66b, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D27
    MOVZ  X9, #0xe0a0, LSL #0
    MOVK  X9, #0xec34, LSL #16
    MOVK  X9, #0x37e5, LSL #32
    MOVK  X9, #0x469f, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X9, #0x1ed2, LSL #0
    MOVK  X9, #0x8bec, LSL #16
    MOVK  X9, #0x7ac5, LSL #32
    MOVK  X9, #0xedfd, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D28
    MOVZ  X9, #0xb9a0, LSL #0
    MOVK  X9, #0xa6b, LSL #16
    MOVK  X9, #0x23f5, LSL #32
    MOVK  X9, #0x47eb, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X9, #0x53d7, LSL #0
    MOVK  X9, #0x4f67, LSL #16
    MOVK  X9, #0x246c, LSL #32
    MOVK  X9, #0xb4e9, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D29
    MOVZ  X9, #0xc96d, LSL #0
    MOVK  X9, #0x84a1, LSL #16
    MOVK  X9, #0x2864, LSL #32
    MOVK  X9, #0x52c2, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X9, #0xe8d5, LSL #0
    MOVK  X9, #0x811d, LSL #16
    MOVK  X9, #0x70a0, LSL #32
    MOVK  X9, #0xb968, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D30
    MOVZ  X9, #0x9c2e, LSL #0
    MOVK  X9, #0x75b4, LSL #16
    MOVK  X9, #0xe66d, LSL #32
    MOVK  X9, #0x31e1, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X9, #0x864a, LSL #0
    MOVK  X9, #0x3c85, LSL #16
    MOVK  X9, #0x66b7, LSL #32
    MOVK  X9, #0x6543, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X23, D31
    MOVZ  X9, #0xb35e, LSL #0
    MOVK  X9, #0x69d5, LSL #16
    MOVK  X9, #0x5ec3, LSL #32
    MOVK  X9, #0xf10, LSL #48
    SUB  X6, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X10
    FMOV  V0.D[1], X21
    FMOV  D1, X18
    FMOV  V1.D[1], X23
    FMOV  D2, X3
    FMOV  V2.D[1], X22
    FMOV  D3, X28
    FMOV  V3.D[1], X28
    FMOV  D4, X18
    FMOV  V4.D[1], X17
    FMOV  D5, X17
    FMOV  V5.D[1], X11
    FMOV  D6, X11
    FMOV  V6.D[1], X11
    FMOV  D7, X15
    FMOV  V7.D[1], X5
    FMOV  D8, X15
    FMOV  V8.D[1], X14
    FMOV  D9, X2
    FMOV  V9.D[1], X18
    FMOV  D10, X15
    FMOV  V10.D[1], X11
    FMOV  D11, X15
    FMOV  V11.D[1], X22
    FMOV  D12, X19
    FMOV  V12.D[1], X20
    FMOV  D13, X28
    FMOV  V13.D[1], X11
    FMOV  D14, X16
    FMOV  V14.D[1], X20
    FMOV  D15, X23
    FMOV  V15.D[1], X15
    FMOV  D16, X22
    FMOV  V16.D[1], X21
    FMOV  D17, X28
    FMOV  V17.D[1], X8
    FMOV  D18, X8
    FMOV  V18.D[1], X20
    FMOV  D19, X7
    FMOV  V19.D[1], X12
    FMOV  D20, X22
    FMOV  V20.D[1], X7
    FMOV  D21, X17
    FMOV  V21.D[1], X3
    FMOV  D22, X17
    FMOV  V22.D[1], X28
    FMOV  D23, X23
    FMOV  V23.D[1], X22
    FMOV  D24, X7
    FMOV  V24.D[1], X7
    FMOV  D25, X12
    FMOV  V25.D[1], X2
    FMOV  D26, X14
    FMOV  V26.D[1], X28
    FMOV  D27, X28
    FMOV  V27.D[1], X21
    FMOV  D28, X9
    FMOV  V28.D[1], X21
    FMOV  D29, X9
    FMOV  V29.D[1], X16
    FMOV  D30, X18
    FMOV  V30.D[1], X28
    FMOV  D31, X14
    FMOV  V31.D[1], X12
    MOVZ  X5, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_8:
    SHA512H Q21, Q19, V18.2D
    SM3TT2A V29.4S, V28.4S, V21.S[0x1]
    SHA512SU1 V17.2D, V30.2D, V24.2D
    SM3PARTW1 V25.4S, V31.4S, V30.4S
    SM3TT1A V26.4S, V27.4S, V21.S[0x2]
    EOR3 V21.16B, V22.16B, V14.16B, V26.16B
    SM4EKEY V11.4S, V17.4S, V1.4S
    SM3PARTW1 V8.4S, V22.4S, V15.4S
    SM3TT2B V27.4S, V31.4S, V29.S[0x2]
    SM3SS1 V30.4S, V25.4S, V8.4S, V11.4S
    SM3TT2B V29.4S, V14.4S, V11.S[0x2]
    SM4E V8.4S, V29.4S
    SHA512SU1 V7.2D, V30.2D, V30.2D
    EOR3 V17.16B, V18.16B, V21.16B, V29.16B
    SM3PARTW1 V30.4S, V7.4S, V17.4S
    BCAX V28.16B, V30.16B, V15.16B, V19.16B
    SM3TT1B V15.4S, V27.4S, V8.S[0x2]
    SM3SS1 V31.4S, V13.4S, V19.4S, V14.4S
    SHA512H2 Q30, Q9, V31.2D
    SM3TT1A V8.4S, V3.4S, V7.S[0x1]
    EOR3 V24.16B, V29.16B, V23.16B, V22.16B
    SM4EKEY V19.4S, V19.4S, V21.4S
    SHA512SU0 V14.2D, V3.2D
    SM3SS1 V21.4S, V20.4S, V28.4S, V7.4S
    SM3TT1A V23.4S, V9.4S, V7.S[0x3]
    SHA512SU1 V22.2D, V8.2D, V11.2D
    SM3TT2A V9.4S, V7.4S, V11.S[0x1]
    SM4EKEY V8.4S, V19.4S, V9.4S
    SHA512SU0 V22.2D, V0.2D
    SHA512H2 Q21, Q8, V5.2D
    BCAX V0.16B, V1.16B, V14.16B, V22.16B
    SHA512H2 Q17, Q15, V21.2D
    SM4EKEY V3.4S, V24.4S, V20.4S
    SM4EKEY V25.4S, V21.4S, V15.4S
    SHA512SU0 V24.2D, V5.2D
    SM4EKEY V9.4S, V30.4S, V6.4S
    XAR V30.2D, V25.2D, V3.2D, #0x3d
    SM3TT2A V29.4S, V24.4S, V27.S[0x0]
    RAX1 V6.2D, V9.2D, V30.2D
    XAR V27.2D, V17.2D, V0.2D, #0x26
    SHA512H Q19, Q26, V31.2D
    SHA512H2 Q5, Q27, V29.2D
    BCAX V24.16B, V31.16B, V5.16B, V23.16B
    SHA512SU0 V14.2D, V6.2D
    SM3PARTW2 V15.4S, V19.4S, V24.4S
    BCAX V23.16B, V13.16B, V3.16B, V13.16B
    SM4E V14.4S, V21.4S
    RAX1 V1.2D, V4.2D, V20.2D
    XAR V8.2D, V6.2D, V8.2D, #0x3f
    SHA512SU1 V28.2D, V3.2D, V28.2D
    SM4EKEY V22.4S, V13.4S, V1.4S
    SM4EKEY V18.4S, V6.4S, V24.4S
    SM4E V5.4S, V7.4S
    SM4EKEY V17.4S, V14.4S, V19.4S
    SM3TT2B V1.4S, V2.4S, V27.S[0x0]
    RAX1 V6.2D, V1.2D, V18.2D
    RAX1 V29.2D, V14.2D, V8.2D
    XAR V29.2D, V6.2D, V17.2D, #0x1
    SM4E V30.4S, V22.4S
    SHA512SU1 V8.2D, V5.2D, V9.2D
    SHA512H2 Q0, Q30, V28.2D
    BCAX V20.16B, V29.16B, V17.16B, V14.16B
    SM4EKEY V7.4S, V15.4S, V8.4S
    SM3SS1 V6.4S, V10.4S, V6.4S, V1.4S
    SM4E V24.4S, V23.4S
    SHA512SU1 V21.2D, V5.2D, V6.2D
    SM3PARTW2 V8.4S, V21.4S, V0.4S
    SHA512SU1 V5.2D, V7.2D, V24.2D
    SM4E V13.4S, V5.4S
    SHA512H2 Q31, Q6, V22.2D
    SM3TT2B V21.4S, V31.4S, V13.S[0x1]
    RAX1 V9.2D, V8.2D, V20.2D
    SM3TT2B V23.4S, V6.4S, V25.S[0x1]
    SHA512SU0 V25.2D, V13.2D
    SM4E V13.4S, V28.4S
    SHA512SU1 V10.2D, V14.2D, V23.2D
    SHA512H Q29, Q26, V21.2D
    SM4E V6.4S, V20.4S
    XAR V14.2D, V31.2D, V12.2D, #0x36
    SHA512H Q21, Q21, V20.2D
    XAR V24.2D, V27.2D, V8.2D, #0x36
    BCAX V26.16B, V25.16B, V13.16B, V1.16B
    EOR3 V28.16B, V24.16B, V20.16B, V21.16B
    SM3PARTW1 V30.4S, V10.4S, V20.4S
    SM3TT2A V27.4S, V30.4S, V26.S[0x3]
    SM4E V0.4S, V12.4S
    SHA512H2 Q7, Q8, V14.2D
    SHA512H2 Q25, Q13, V9.2D
    SM4EKEY V22.4S, V29.4S, V29.4S
    SM4E V23.4S, V24.4S
    SHA512SU1 V16.2D, V22.2D, V27.2D
    SHA512H2 Q8, Q27, V22.2D
    SM4EKEY V12.4S, V28.4S, V9.4S
    SHA512H2 Q26, Q6, V0.2D
    SHA512H2 Q0, Q26, V29.2D
    SM3TT1B V29.4S, V8.4S, V12.S[0x1]
    SM3SS1 V24.4S, V18.4S, V13.4S, V23.4S
    SHA512SU1 V22.2D, V25.2D, V27.2D
    SHA512H2 Q9, Q0, V22.2D
    SM4E V21.4S, V29.4S
    SHA512H Q31, Q9, V7.2D
    EOR3 V12.16B, V16.16B, V31.16B, V6.16B
    SM4EKEY V22.4S, V24.4S, V12.4S
    SHA512H2 Q25, Q3, V15.2D
    BCAX V14.16B, V27.16B, V31.16B, V23.16B
    EOR3 V1.16B, V3.16B, V10.16B, V21.16B
    XAR V8.2D, V12.2D, V2.2D, #0x25
    XAR V15.2D, V26.2D, V24.2D, #0x14
    SM3PARTW1 V6.4S, V18.4S, V23.4S
    SM3SS1 V26.4S, V30.4S, V1.4S, V6.4S
    BCAX V27.16B, V9.16B, V11.16B, V28.16B
    SM3SS1 V21.4S, V16.4S, V5.4S, V8.4S
    SM4EKEY V11.4S, V11.4S, V30.4S
    SHA512SU1 V12.2D, V11.2D, V12.2D
    SM3TT2A V24.4S, V4.4S, V23.S[0x1]
    EOR3 V30.16B, V21.16B, V27.16B, V21.16B
    SHA512H2 Q3, Q6, V15.2D
    EOR3 V5.16B, V8.16B, V3.16B, V31.16B
    EOR3 V7.16B, V5.16B, V6.16B, V24.16B
    SM4EKEY V2.4S, V27.4S, V5.4S
    SM4EKEY V0.4S, V25.4S, V14.4S
    BCAX V9.16B, V12.16B, V22.16B, V30.16B
    SM4EKEY V12.4S, V9.4S, V0.4S
    SM3PARTW1 V4.4S, V26.4S, V12.4S
    BCAX V21.16B, V20.16B, V2.16B, V1.16B
    SHA512H2 Q14, Q25, V18.2D
    SM4E V20.4S, V2.4S
    SM3PARTW1 V11.4S, V14.4S, V4.4S
    XAR V2.2D, V11.2D, V21.2D, #0x25
    SHA512H2 Q10, Q20, V2.2D
    SM4E V26.4S, V12.4S
    SM3TT2B V8.4S, V17.4S, V19.S[0x2]
    EOR3 V14.16B, V1.16B, V23.16B, V9.16B
    SM3TT1A V6.4S, V11.4S, V28.S[0x1]
    SM3TT1A V17.4S, V7.4S, V22.S[0x2]
    SM4EKEY V19.4S, V4.4S, V3.4S
    RAX1 V22.2D, V7.2D, V5.2D
    SM4EKEY V11.4S, V8.4S, V1.4S
    RAX1 V27.2D, V24.2D, V21.2D
    SHA512H Q21, Q17, V27.2D
    SM3PARTW2 V4.4S, V6.4S, V21.4S
    SHA512H2 Q23, Q10, V10.2D
    SM3PARTW1 V7.4S, V21.4S, V21.4S
    BCAX V1.16B, V7.16B, V29.16B, V2.16B
    SM3PARTW1 V16.4S, V19.4S, V23.4S
    EOR3 V2.16B, V26.16B, V1.16B, V11.16B
    SM3TT2A V27.4S, V14.4S, V13.S[0x0]
    SM3PARTW2 V29.4S, V27.4S, V2.4S
    SM3PARTW2 V27.4S, V4.4S, V22.4S
    SM3PARTW2 V11.4S, V16.4S, V12.4S
    SM4EKEY V5.4S, V0.4S, V31.4S
    SM4EKEY V21.4S, V7.4S, V27.4S
    SM4EKEY V12.4S, V29.4S, V21.4S
    SM3TT2B V22.4S, V11.4S, V12.S[0x3]
    BCAX V28.16B, V10.16B, V15.16B, V11.16B
    BCAX V14.16B, V30.16B, V19.16B, V21.16B
    EOR3 V23.16B, V29.16B, V26.16B, V30.16B
    SM3PARTW2 V16.4S, V18.4S, V6.4S
    SM3SS1 V19.4S, V12.4S, V2.4S, V13.4S
    SM4EKEY V0.4S, V18.4S, V7.4S
    SHA512H2 Q13, Q2, V0.2D
    SM3SS1 V7.4S, V15.4S, V18.4S, V8.4S
    RAX1 V3.2D, V13.2D, V28.2D
    SM4EKEY V1.4S, V19.4S, V16.4S
    SM4EKEY V21.4S, V7.4S, V31.4S
    SM4EKEY V13.4S, V1.4S, V1.4S
    EOR3 V29.16B, V14.16B, V14.16B, V23.16B
    SM3PARTW2 V24.4S, V3.4S, V13.4S
    SHA512SU1 V10.2D, V30.2D, V9.2D
    SM4EKEY V3.4S, V8.4S, V22.4S
    SHA512SU1 V15.2D, V17.2D, V10.2D
    SM3SS1 V12.4S, V29.4S, V16.4S, V14.4S
    SM3PARTW1 V11.4S, V7.4S, V15.4S
    SM4EKEY V31.4S, V24.4S, V23.4S
    BCAX V9.16B, V21.16B, V31.16B, V3.16B
    SHA512H Q2, Q9, V24.2D
    SM4EKEY V16.4S, V12.4S, V23.4S
    SM4E V29.4S, V30.4S
    SHA512H Q22, Q7, V22.2D
    SM3PARTW1 V18.4S, V20.4S, V14.4S
    SHA512SU0 V0.2D, V29.2D
    SHA512SU1 V28.2D, V2.2D, V16.2D
    SHA512H2 Q20, Q11, V3.2D
    SHA512H2 Q29, Q18, V31.2D
    SHA512H Q7, Q0, V29.2D
    SHA512SU1 V21.2D, V28.2D, V3.2D
    SHA512H Q18, Q22, V31.2D
    EOR3 V21.16B, V18.16B, V7.16B, V18.16B
    SHA512H2 Q23, Q11, V10.2D
    SM3PARTW1 V3.4S, V20.4S, V21.4S
    BCAX V1.16B, V21.16B, V16.16B, V18.16B
    SM4EKEY V19.4S, V14.4S, V14.4S
    SHA512H Q12, Q19, V31.2D
    SM4EKEY V22.4S, V5.4S, V10.4S
    SM4E V13.4S, V15.4S
    RAX1 V5.2D, V26.2D, V6.2D
    SM4EKEY V26.4S, V24.4S, V4.4S
    SM4E V21.4S, V8.4S
    BCAX V10.16B, V16.16B, V27.16B, V5.16B
    SM3SS1 V15.4S, V18.4S, V21.4S, V12.4S
    SUBS  X5, X5, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_8
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X13, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X22, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X13, #0xcef0, LSL #0
    MOVK  X13, #0x3dc2, LSL #16
    MOVK  X13, #0xa9ca, LSL #32
    MOVK  X13, #0x84e8, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D0
    MOVZ  X13, #0xa68f, LSL #0
    MOVK  X13, #0x94f2, LSL #16
    MOVK  X13, #0x8edd, LSL #32
    MOVK  X13, #0x20aa, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X13, #0x52e4, LSL #0
    MOVK  X13, #0x2f65, LSL #16
    MOVK  X13, #0x3fc0, LSL #32
    MOVK  X13, #0xbe7e, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D1
    MOVZ  X13, #0xe81d, LSL #0
    MOVK  X13, #0xda30, LSL #16
    MOVK  X13, #0xb7e2, LSL #32
    MOVK  X13, #0xd4af, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X13, #0x7007, LSL #0
    MOVK  X13, #0x276a, LSL #16
    MOVK  X13, #0xb5d6, LSL #32
    MOVK  X13, #0x44df, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D2
    MOVZ  X13, #0x3ce6, LSL #0
    MOVK  X13, #0x854, LSL #16
    MOVK  X13, #0xcee9, LSL #32
    MOVK  X13, #0xdf81, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X13, #0xcbe7, LSL #0
    MOVK  X13, #0xfe8f, LSL #16
    MOVK  X13, #0xcdfa, LSL #32
    MOVK  X13, #0x3f67, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D3
    MOVZ  X13, #0x860b, LSL #0
    MOVK  X13, #0x6302, LSL #16
    MOVK  X13, #0x1427, LSL #32
    MOVK  X13, #0x3108, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X13, #0x3587, LSL #0
    MOVK  X13, #0x5d4e, LSL #16
    MOVK  X13, #0x9e55, LSL #32
    MOVK  X13, #0xe153, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D4
    MOVZ  X13, #0x34dd, LSL #0
    MOVK  X13, #0x2c5b, LSL #16
    MOVK  X13, #0x639a, LSL #32
    MOVK  X13, #0xf448, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X13, #0xa546, LSL #0
    MOVK  X13, #0xa361, LSL #16
    MOVK  X13, #0x5d07, LSL #32
    MOVK  X13, #0xfbf9, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D5
    MOVZ  X13, #0x460f, LSL #0
    MOVK  X13, #0x20af, LSL #16
    MOVK  X13, #0x6180, LSL #32
    MOVK  X13, #0x13bf, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X13, #0x367c, LSL #0
    MOVK  X13, #0xa742, LSL #16
    MOVK  X13, #0x1090, LSL #32
    MOVK  X13, #0x8ea7, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D6
    MOVZ  X13, #0x474d, LSL #0
    MOVK  X13, #0xe6f2, LSL #16
    MOVK  X13, #0x28f9, LSL #32
    MOVK  X13, #0x6ee4, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X13, #0x50c6, LSL #0
    MOVK  X13, #0x476d, LSL #16
    MOVK  X13, #0xbdc2, LSL #32
    MOVK  X13, #0x1ffe, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D7
    MOVZ  X13, #0xed37, LSL #0
    MOVK  X13, #0xcb35, LSL #16
    MOVK  X13, #0x653c, LSL #32
    MOVK  X13, #0xc52d, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X13, #0x9a0e, LSL #0
    MOVK  X13, #0xfb4b, LSL #16
    MOVK  X13, #0x916b, LSL #32
    MOVK  X13, #0x606f, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D8
    MOVZ  X13, #0xbc53, LSL #0
    MOVK  X13, #0x848a, LSL #16
    MOVK  X13, #0xd7ff, LSL #32
    MOVK  X13, #0xecea, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X13, #0x7f75, LSL #0
    MOVK  X13, #0x3794, LSL #16
    MOVK  X13, #0x959d, LSL #32
    MOVK  X13, #0xa81f, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D9
    MOVZ  X13, #0xcccc, LSL #0
    MOVK  X13, #0x8ea3, LSL #16
    MOVK  X13, #0x5bef, LSL #32
    MOVK  X13, #0x605d, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X13, #0xc287, LSL #0
    MOVK  X13, #0xea1b, LSL #16
    MOVK  X13, #0x2092, LSL #32
    MOVK  X13, #0xa1a2, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D10
    MOVZ  X13, #0xecca, LSL #0
    MOVK  X13, #0x9e55, LSL #16
    MOVK  X13, #0x779e, LSL #32
    MOVK  X13, #0x95ea, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X13, #0x432b, LSL #0
    MOVK  X13, #0xb93a, LSL #16
    MOVK  X13, #0x4d9, LSL #32
    MOVK  X13, #0x7b1a, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D11
    MOVZ  X13, #0x4483, LSL #0
    MOVK  X13, #0xce4f, LSL #16
    MOVK  X13, #0x2b70, LSL #32
    MOVK  X13, #0x409e, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X13, #0x64e2, LSL #0
    MOVK  X13, #0x82c, LSL #16
    MOVK  X13, #0x4dd4, LSL #32
    MOVK  X13, #0x60d, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D12
    MOVZ  X13, #0x521e, LSL #0
    MOVK  X13, #0x2db5, LSL #16
    MOVK  X13, #0xf257, LSL #32
    MOVK  X13, #0x4059, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X13, #0xa4b, LSL #0
    MOVK  X13, #0xd61c, LSL #16
    MOVK  X13, #0xf85, LSL #32
    MOVK  X13, #0xabce, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D13
    MOVZ  X13, #0xee44, LSL #0
    MOVK  X13, #0x96a3, LSL #16
    MOVK  X13, #0x932d, LSL #32
    MOVK  X13, #0x7bfc, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X13, #0xdbfb, LSL #0
    MOVK  X13, #0xaf7e, LSL #16
    MOVK  X13, #0x452b, LSL #32
    MOVK  X13, #0xb143, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D14
    MOVZ  X13, #0x9a04, LSL #0
    MOVK  X13, #0x3342, LSL #16
    MOVK  X13, #0xdb4e, LSL #32
    MOVK  X13, #0x61bf, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xfe1f, LSL #32
    MOVK  X13, #0x34ed, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D15
    MOVZ  X13, #0x0, LSL #0
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X13, #0x822e, LSL #0
    MOVK  X13, #0xea1b, LSL #16
    MOVK  X13, #0x822a, LSL #32
    MOVK  X13, #0xa1a2, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D16
    MOVZ  X13, #0xe5ea, LSL #0
    MOVK  X13, #0x1145, LSL #16
    MOVK  X13, #0xffde, LSL #32
    MOVK  X13, #0x19aa, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X13, #0xd101, LSL #0
    MOVK  X13, #0x73e1, LSL #16
    MOVK  X13, #0x4e3b, LSL #32
    MOVK  X13, #0x2461, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D17
    MOVZ  X13, #0x7c83, LSL #0
    MOVK  X13, #0x818f, LSL #16
    MOVK  X13, #0xe12e, LSL #32
    MOVK  X13, #0xeb29, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X13, #0xb95c, LSL #0
    MOVK  X13, #0x82d3, LSL #16
    MOVK  X13, #0x6dfc, LSL #32
    MOVK  X13, #0x5c62, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D18
    MOVZ  X13, #0xe0c5, LSL #0
    MOVK  X13, #0x4840, LSL #16
    MOVK  X13, #0x2d01, LSL #32
    MOVK  X13, #0x4e3d, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X13, #0xead3, LSL #0
    MOVK  X13, #0x95c5, LSL #16
    MOVK  X13, #0xe28b, LSL #32
    MOVK  X13, #0x2238, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D19
    MOVZ  X13, #0x303f, LSL #0
    MOVK  X13, #0x7aba, LSL #16
    MOVK  X13, #0x14e1, LSL #32
    MOVK  X13, #0x6131, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X13, #0x64a7, LSL #0
    MOVK  X13, #0xcfd2, LSL #16
    MOVK  X13, #0x919, LSL #32
    MOVK  X13, #0xf581, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D20
    MOVZ  X13, #0x1201, LSL #0
    MOVK  X13, #0x1e2a, LSL #16
    MOVK  X13, #0x1c83, LSL #32
    MOVK  X13, #0x2f11, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X13, #0x84ac, LSL #0
    MOVK  X13, #0x266, LSL #16
    MOVK  X13, #0xc862, LSL #32
    MOVK  X13, #0x117c, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D21
    MOVZ  X13, #0x371c, LSL #0
    MOVK  X13, #0xa456, LSL #16
    MOVK  X13, #0x4467, LSL #32
    MOVK  X13, #0x5bfa, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X13, #0xe60, LSL #0
    MOVK  X13, #0xab46, LSL #16
    MOVK  X13, #0xbeea, LSL #32
    MOVK  X13, #0xdba, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D22
    MOVZ  X13, #0x6480, LSL #0
    MOVK  X13, #0x385c, LSL #16
    MOVK  X13, #0xbcd8, LSL #32
    MOVK  X13, #0x8d10, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X13, #0x8432, LSL #0
    MOVK  X13, #0xae48, LSL #16
    MOVK  X13, #0xa625, LSL #32
    MOVK  X13, #0x1326, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D23
    MOVZ  X13, #0xb978, LSL #0
    MOVK  X13, #0xe1, LSL #16
    MOVK  X13, #0xac28, LSL #32
    MOVK  X13, #0xf9a7, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X13, #0xd18a, LSL #0
    MOVK  X13, #0xf5ce, LSL #16
    MOVK  X13, #0xd8e6, LSL #32
    MOVK  X13, #0xf4fc, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D24
    MOVZ  X13, #0x3acc, LSL #0
    MOVK  X13, #0x3519, LSL #16
    MOVK  X13, #0x1729, LSL #32
    MOVK  X13, #0xfb51, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X13, #0x1fd6, LSL #0
    MOVK  X13, #0xbd0e, LSL #16
    MOVK  X13, #0xcf60, LSL #32
    MOVK  X13, #0x3fa5, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D25
    MOVZ  X13, #0xefa6, LSL #0
    MOVK  X13, #0x59aa, LSL #16
    MOVK  X13, #0x24de, LSL #32
    MOVK  X13, #0xdfde, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X13, #0xabd4, LSL #0
    MOVK  X13, #0xff22, LSL #16
    MOVK  X13, #0x4c98, LSL #32
    MOVK  X13, #0x5435, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D26
    MOVZ  X13, #0x5e14, LSL #0
    MOVK  X13, #0x9951, LSL #16
    MOVK  X13, #0x9f72, LSL #32
    MOVK  X13, #0x48a0, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X13, #0xe5af, LSL #0
    MOVK  X13, #0x61, LSL #16
    MOVK  X13, #0xa3bb, LSL #32
    MOVK  X13, #0xa100, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D27
    MOVZ  X13, #0x4f20, LSL #0
    MOVK  X13, #0x8f3e, LSL #16
    MOVK  X13, #0xa940, LSL #32
    MOVK  X13, #0x9ecc, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X13, #0xe475, LSL #0
    MOVK  X13, #0xa104, LSL #16
    MOVK  X13, #0x5c87, LSL #32
    MOVK  X13, #0xf1a6, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D28
    MOVZ  X13, #0x2742, LSL #0
    MOVK  X13, #0x4e85, LSL #16
    MOVK  X13, #0x42c6, LSL #32
    MOVK  X13, #0x36c0, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X13, #0x17c0, LSL #0
    MOVK  X13, #0xaa55, LSL #16
    MOVK  X13, #0xae8b, LSL #32
    MOVK  X13, #0x2d83, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D29
    MOVZ  X13, #0x15a0, LSL #0
    MOVK  X13, #0xf9e6, LSL #16
    MOVK  X13, #0x31f4, LSL #32
    MOVK  X13, #0xc968, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X13, #0xf9fb, LSL #0
    MOVK  X13, #0xe55c, LSL #16
    MOVK  X13, #0x25a9, LSL #32
    MOVK  X13, #0xf153, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D30
    MOVZ  X13, #0x8884, LSL #0
    MOVK  X13, #0x8362, LSL #16
    MOVK  X13, #0x524e, LSL #32
    MOVK  X13, #0xb6, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X13, #0x30c3, LSL #0
    MOVK  X13, #0x2069, LSL #16
    MOVK  X13, #0xe2c3, LSL #32
    MOVK  X13, #0x8646, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X22, D31
    MOVZ  X13, #0xecaf, LSL #0
    MOVK  X13, #0x681b, LSL #16
    MOVK  X13, #0x6b4a, LSL #32
    MOVK  X13, #0x4eb, LSL #48
    SUB  X15, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X14
    FMOV  D1, X20
    FMOV  V1.D[1], X28
    FMOV  D2, X20
    FMOV  V2.D[1], X10
    FMOV  D3, X23
    FMOV  V3.D[1], X19
    FMOV  D4, X17
    FMOV  V4.D[1], X12
    FMOV  D5, X2
    FMOV  V5.D[1], X13
    FMOV  D6, X17
    FMOV  V6.D[1], X15
    FMOV  D7, X5
    FMOV  V7.D[1], X21
    FMOV  D8, X20
    FMOV  V8.D[1], X3
    FMOV  D9, X23
    FMOV  V9.D[1], X21
    FMOV  D10, X11
    FMOV  V10.D[1], X17
    FMOV  D11, X23
    FMOV  V11.D[1], X21
    FMOV  D12, X4
    FMOV  V12.D[1], X2
    FMOV  D13, X6
    FMOV  V13.D[1], X12
    FMOV  D14, X20
    FMOV  V14.D[1], X2
    FMOV  D15, X19
    FMOV  V15.D[1], X10
    FMOV  D16, X8
    FMOV  V16.D[1], X14
    FMOV  D17, X10
    FMOV  V17.D[1], X22
    FMOV  D18, X12
    FMOV  V18.D[1], X11
    FMOV  D19, X18
    FMOV  V19.D[1], X11
    FMOV  D20, X16
    FMOV  V20.D[1], X22
    FMOV  D21, X4
    FMOV  V21.D[1], X5
    FMOV  D22, X7
    FMOV  V22.D[1], X23
    FMOV  D23, X5
    FMOV  V23.D[1], X18
    FMOV  D24, X11
    FMOV  V24.D[1], X17
    FMOV  D25, X2
    FMOV  V25.D[1], X7
    FMOV  D26, X19
    FMOV  V26.D[1], X14
    FMOV  D27, X21
    FMOV  V27.D[1], X14
    FMOV  D28, X22
    FMOV  V28.D[1], X18
    FMOV  D29, X15
    FMOV  V29.D[1], X22
    FMOV  D30, X14
    FMOV  V30.D[1], X10
    FMOV  D31, X23
    FMOV  V31.D[1], X28
    MOVZ  X5, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_9:
    EOR3 V18.16B, V25.16B, V17.16B, V26.16B
    XAR V31.2D, V18.2D, V16.2D, #0x27
    SM4E V4.4S, V31.4S
    XAR V21.2D, V27.2D, V24.2D, #0x3b
    EOR3 V5.16B, V4.16B, V19.16B, V1.16B
    SM3TT1B V22.4S, V29.4S, V5.S[0x1]
    SHA512H2 Q15, Q22, V22.2D
    SM4EKEY V31.4S, V6.4S, V21.4S
    EOR3 V16.16B, V28.16B, V2.16B, V13.16B
    SM3PARTW1 V27.4S, V23.4S, V16.4S
    SM4E V10.4S, V10.4S
    SHA512SU0 V24.2D, V30.2D
    SM4EKEY V1.4S, V11.4S, V27.4S
    BCAX V26.16B, V1.16B, V3.16B, V17.16B
    SHA512SU1 V5.2D, V10.2D, V24.2D
    SHA512SU0 V21.2D, V31.2D
    XAR V4.2D, V21.2D, V26.2D, #0xf
    SM4E V29.4S, V5.4S
    SM4E V16.4S, V21.4S
    RAX1 V30.2D, V15.2D, V4.2D
    SM4E V14.4S, V5.4S
    SM3TT1A V11.4S, V14.4S, V23.S[0x0]
    SM3TT1B V6.4S, V16.4S, V25.S[0x1]
    SHA512SU1 V26.2D, V5.2D, V19.2D
    SM4EKEY V15.4S, V11.4S, V30.4S
    EOR3 V27.16B, V12.16B, V15.16B, V14.16B
    SM4E V18.4S, V28.4S
    SM3TT2B V24.4S, V5.4S, V26.S[0x0]
    EOR3 V25.16B, V30.16B, V24.16B, V18.16B
    SM4EKEY V13.4S, V25.4S, V0.4S
    RAX1 V31.2D, V20.2D, V29.2D
    SHA512SU0 V18.2D, V6.2D
    EOR3 V19.16B, V27.16B, V26.16B, V18.16B
    SM4E V16.4S, V19.4S
    SM3SS1 V24.4S, V16.4S, V13.4S, V26.4S
    EOR3 V27.16B, V25.16B, V2.16B, V16.16B
    RAX1 V19.2D, V9.2D, V26.2D
    SM4E V13.4S, V23.4S
    EOR3 V23.16B, V14.16B, V3.16B, V6.16B
    SHA512H Q11, Q16, V16.2D
    SM3SS1 V14.4S, V5.4S, V6.4S, V2.4S
    SHA512H2 Q3, Q2, V23.2D
    SHA512H2 Q18, Q25, V0.2D
    SHA512H Q26, Q1, V19.2D
    SM3TT1B V1.4S, V14.4S, V26.S[0x2]
    RAX1 V28.2D, V27.2D, V8.2D
    SHA512H Q27, Q24, V18.2D
    SHA512SU0 V29.2D, V3.2D
    SM3TT2B V1.4S, V13.4S, V27.S[0x3]
    RAX1 V23.2D, V3.2D, V18.2D
    SHA512SU1 V27.2D, V11.2D, V31.2D
    SM3TT1A V16.4S, V23.4S, V28.S[0x0]
    SM4E V18.4S, V1.4S
    SHA512H Q8, Q23, V29.2D
    SM4E V8.4S, V27.4S
    SM3PARTW1 V26.4S, V18.4S, V5.4S
    BCAX V1.16B, V22.16B, V16.16B, V13.16B
    BCAX V13.16B, V8.16B, V2.16B, V7.16B
    EOR3 V29.16B, V13.16B, V14.16B, V1.16B
    EOR3 V8.16B, V19.16B, V30.16B, V9.16B
    SHA512H2 Q28, Q0, V23.2D
    SM3TT1B V14.4S, V12.4S, V27.S[0x3]
    SM4EKEY V7.4S, V0.4S, V23.4S
    SM4E V16.4S, V23.4S
    RAX1 V13.2D, V15.2D, V4.2D
    SM3TT1A V19.4S, V11.4S, V11.S[0x0]
    XAR V12.2D, V19.2D, V13.2D, #0x37
    EOR3 V3.16B, V5.16B, V28.16B, V26.16B
    SM4EKEY V16.4S, V16.4S, V13.4S
    SM4E V13.4S, V3.4S
    EOR3 V9.16B, V14.16B, V22.16B, V19.16B
    BCAX V24.16B, V7.16B, V9.16B, V25.16B
    SHA512H Q19, Q16, V29.2D
    BCAX V4.16B, V31.16B, V4.16B, V8.16B
    SHA512SU1 V22.2D, V13.2D, V12.2D
    XAR V23.2D, V4.2D, V29.2D, #0x27
    SHA512H2 Q1, Q2, V23.2D
    SM4EKEY V0.4S, V4.4S, V24.4S
    BCAX V12.16B, V19.16B, V0.16B, V0.16B
    RAX1 V15.2D, V12.2D, V12.2D
    SHA512SU1 V8.2D, V10.2D, V18.2D
    SM3PARTW1 V25.4S, V5.4S, V15.4S
    SHA512SU0 V23.2D, V9.2D
    SHA512H2 Q16, Q25, V8.2D
    SM4E V31.4S, V24.4S
    SM4EKEY V3.4S, V29.4S, V22.4S
    SM4EKEY V11.4S, V3.4S, V3.4S
    SM4EKEY V9.4S, V11.4S, V6.4S
    XAR V24.2D, V9.2D, V6.2D, #0x2d
    SM4E V4.4S, V31.4S
    SHA512SU0 V0.2D, V16.2D
    SM3SS1 V21.4S, V24.4S, V1.4S, V24.4S
    SM4E V1.4S, V2.4S
    RAX1 V13.2D, V21.2D, V4.2D
    SM4EKEY V15.4S, V1.4S, V28.4S
    SM3SS1 V26.4S, V0.4S, V6.4S, V13.4S
    SHA512SU1 V1.2D, V26.2D, V20.2D
    SM4EKEY V16.4S, V0.4S, V14.4S
    XAR V18.2D, V2.2D, V30.2D, #0x2e
    SM4E V7.4S, V18.4S
    SM4E V28.4S, V1.4S
    RAX1 V11.2D, V19.2D, V16.2D
    SM4EKEY V16.4S, V28.4S, V28.4S
    SHA512SU1 V29.2D, V16.2D, V15.2D
    EOR3 V13.16B, V11.16B, V7.16B, V29.16B
    RAX1 V22.2D, V16.2D, V1.2D
    SM4EKEY V9.4S, V24.4S, V30.4S
    SM4E V10.4S, V0.4S
    SHA512H2 Q2, Q0, V20.2D
    SM4EKEY V20.4S, V23.4S, V14.4S
    SHA512SU1 V28.2D, V31.2D, V0.2D
    SHA512H Q0, Q27, V1.2D
    SHA512SU0 V8.2D, V7.2D
    EOR3 V1.16B, V13.16B, V10.16B, V9.16B
    SM3TT1A V30.4S, V28.4S, V22.S[0x3]
    BCAX V15.16B, V17.16B, V2.16B, V16.16B
    BCAX V18.16B, V30.16B, V1.16B, V20.16B
    XAR V7.2D, V5.2D, V0.2D, #0x16
    BCAX V17.16B, V15.16B, V15.16B, V15.16B
    SM4EKEY V4.4S, V8.4S, V8.4S
    BCAX V20.16B, V7.16B, V11.16B, V7.16B
    SM4E V9.4S, V17.4S
    BCAX V24.16B, V7.16B, V18.16B, V16.16B
    SHA512H2 Q29, Q16, V4.2D
    SHA512SU0 V6.2D, V30.2D
    XAR V1.2D, V24.2D, V20.2D, #0x3b
    SHA512SU0 V28.2D, V9.2D
    SM3TT2B V16.4S, V28.4S, V29.S[0x0]
    BCAX V19.16B, V1.16B, V13.16B, V16.16B
    SM3PARTW1 V20.4S, V14.4S, V27.4S
    EOR3 V28.16B, V5.16B, V15.16B, V5.16B
    SM3PARTW1 V18.4S, V8.4S, V28.4S
    SM4EKEY V1.4S, V11.4S, V29.4S
    SM3TT1B V13.4S, V28.4S, V3.S[0x1]
    SM3PARTW1 V16.4S, V20.4S, V19.4S
    XAR V19.2D, V5.2D, V6.2D, #0x20
    SHA512H Q30, Q2, V14.2D
    SHA512H2 Q14, Q1, V2.2D
    SM3TT2B V5.4S, V25.4S, V19.S[0x0]
    SM3PARTW2 V24.4S, V3.4S, V14.4S
    EOR3 V22.16B, V12.16B, V8.16B, V18.16B
    SM4EKEY V29.4S, V6.4S, V20.4S
    SM3PARTW1 V27.4S, V18.4S, V11.4S
    SM3TT2B V0.4S, V2.4S, V29.S[0x3]
    SM4E V29.4S, V4.4S
    XAR V18.2D, V23.2D, V1.2D, #0x16
    SHA512SU0 V25.2D, V9.2D
    SM4E V11.4S, V24.4S
    SM3TT2B V24.4S, V16.4S, V27.S[0x2]
    SM4E V15.4S, V25.4S
    SM3TT1A V19.4S, V13.4S, V30.S[0x1]
    SM3TT1B V23.4S, V29.4S, V26.S[0x3]
    XAR V30.2D, V23.2D, V24.2D, #0x31
    SHA512H2 Q12, Q18, V0.2D
    SM3PARTW2 V13.4S, V16.4S, V12.4S
    SHA512H Q6, Q23, V14.2D
    SM4E V24.4S, V22.4S
    SM3PARTW2 V22.4S, V13.4S, V12.4S
    SM3PARTW2 V14.4S, V26.4S, V5.4S
    SM3TT2A V4.4S, V15.4S, V1.S[0x2]
    SM3TT1B V20.4S, V21.4S, V31.S[0x3]
    SM3TT1B V20.4S, V30.4S, V19.S[0x2]
    SM4EKEY V29.4S, V6.4S, V22.4S
    SM3TT2A V16.4S, V9.4S, V20.S[0x3]
    SM3PARTW2 V12.4S, V4.4S, V29.4S
    SHA512H Q8, Q7, V14.2D
    SM3PARTW1 V29.4S, V12.4S, V16.4S
    SHA512SU0 V23.2D, V29.2D
    SM3TT1A V20.4S, V24.4S, V22.S[0x1]
    SM3SS1 V26.4S, V8.4S, V8.4S, V23.4S
    EOR3 V14.16B, V16.16B, V17.16B, V29.16B
    BCAX V0.16B, V26.16B, V31.16B, V14.16B
    SM4E V24.4S, V13.4S
    SHA512SU1 V5.2D, V19.2D, V24.2D
    SM4EKEY V8.4S, V5.4S, V20.4S
    SM4EKEY V7.4S, V19.4S, V1.4S
    SHA512H Q24, Q8, V0.2D
    SM4EKEY V25.4S, V0.4S, V11.4S
    SM4E V12.4S, V25.4S
    BCAX V23.16B, V1.16B, V27.16B, V9.16B
    SM4EKEY V25.4S, V23.4S, V15.4S
    RAX1 V0.2D, V10.2D, V7.2D
    XAR V11.2D, V30.2D, V24.2D, #0xf
    SM3TT2A V16.4S, V30.4S, V25.S[0x1]
    BCAX V19.16B, V16.16B, V12.16B, V11.16B
    RAX1 V22.2D, V1.2D, V1.2D
    EOR3 V1.16B, V15.16B, V1.16B, V24.16B
    SM4EKEY V12.4S, V14.4S, V9.4S
    BCAX V13.16B, V16.16B, V8.16B, V14.16B
    SM3PARTW1 V17.4S, V5.4S, V15.4S
    SM3TT1B V6.4S, V18.4S, V8.S[0x2]
    SM4E V18.4S, V14.4S
    SM4EKEY V10.4S, V30.4S, V13.4S
    SHA512SU1 V27.2D, V17.2D, V1.2D
    SM3TT1B V24.4S, V27.4S, V18.S[0x3]
    BCAX V26.16B, V24.16B, V8.16B, V22.16B
    SHA512H Q8, Q0, V0.2D
    SHA512H2 Q17, Q6, V17.2D
    SM4EKEY V1.4S, V8.4S, V6.4S
    SM3PARTW1 V25.4S, V19.4S, V27.4S
    SUBS  X5, X5, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_9
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X22, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X22, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X17, FPSR
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X22, #0x3188, LSL #0
    MOVK  X22, #0xaad4, LSL #16
    MOVK  X22, #0x36fd, LSL #32
    MOVK  X22, #0xe8c2, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D0
    MOVZ  X22, #0x5115, LSL #0
    MOVK  X22, #0xf5ee, LSL #16
    MOVK  X22, #0xabec, LSL #32
    MOVK  X22, #0x9248, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X22, #0x2697, LSL #0
    MOVK  X22, #0x28f2, LSL #16
    MOVK  X22, #0xcf5c, LSL #32
    MOVK  X22, #0xfaa8, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D1
    MOVZ  X22, #0x5be5, LSL #0
    MOVK  X22, #0xa17c, LSL #16
    MOVK  X22, #0x98b3, LSL #32
    MOVK  X22, #0xc26c, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X22, #0x7482, LSL #0
    MOVK  X22, #0x2af0, LSL #16
    MOVK  X22, #0x531c, LSL #32
    MOVK  X22, #0x54f0, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D2
    MOVZ  X22, #0xc22c, LSL #0
    MOVK  X22, #0x59df, LSL #16
    MOVK  X22, #0xe1a1, LSL #32
    MOVK  X22, #0x3b05, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X22, #0x3900, LSL #0
    MOVK  X22, #0xf412, LSL #16
    MOVK  X22, #0xde26, LSL #32
    MOVK  X22, #0xc5bd, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D3
    MOVZ  X22, #0x469b, LSL #0
    MOVK  X22, #0x7a25, LSL #16
    MOVK  X22, #0x9c17, LSL #32
    MOVK  X22, #0x1f0b, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X22, #0x9bad, LSL #0
    MOVK  X22, #0x2e40, LSL #16
    MOVK  X22, #0xf4be, LSL #32
    MOVK  X22, #0x758, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D4
    MOVZ  X22, #0xe361, LSL #0
    MOVK  X22, #0x295a, LSL #16
    MOVK  X22, #0x425f, LSL #32
    MOVK  X22, #0xa124, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X22, #0xd544, LSL #0
    MOVK  X22, #0x2e5b, LSL #16
    MOVK  X22, #0xc6cf, LSL #32
    MOVK  X22, #0x43ed, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D5
    MOVZ  X22, #0xbd9d, LSL #0
    MOVK  X22, #0xeb96, LSL #16
    MOVK  X22, #0xecd2, LSL #32
    MOVK  X22, #0xf44, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X22, #0xdea5, LSL #0
    MOVK  X22, #0x2464, LSL #16
    MOVK  X22, #0x5fbd, LSL #32
    MOVK  X22, #0xbd46, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D6
    MOVZ  X22, #0x11d9, LSL #0
    MOVK  X22, #0x9060, LSL #16
    MOVK  X22, #0xcef9, LSL #32
    MOVK  X22, #0xb264, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X22, #0xe041, LSL #0
    MOVK  X22, #0xbbe1, LSL #16
    MOVK  X22, #0xf3f7, LSL #32
    MOVK  X22, #0x2cdb, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D7
    MOVZ  X22, #0x4fe4, LSL #0
    MOVK  X22, #0x1159, LSL #16
    MOVK  X22, #0xdd30, LSL #32
    MOVK  X22, #0x2b11, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X22, #0xc952, LSL #0
    MOVK  X22, #0x85b6, LSL #16
    MOVK  X22, #0x6d79, LSL #32
    MOVK  X22, #0xaa58, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D8
    MOVZ  X22, #0xc39e, LSL #0
    MOVK  X22, #0x3cc1, LSL #16
    MOVK  X22, #0x2356, LSL #32
    MOVK  X22, #0xcbe9, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X22, #0x5797, LSL #0
    MOVK  X22, #0xf2f5, LSL #16
    MOVK  X22, #0x188d, LSL #32
    MOVK  X22, #0x30fa, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D9
    MOVZ  X22, #0x850, LSL #0
    MOVK  X22, #0xcff3, LSL #16
    MOVK  X22, #0xbc6e, LSL #32
    MOVK  X22, #0x8c06, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X22, #0xae12, LSL #0
    MOVK  X22, #0xf9e1, LSL #16
    MOVK  X22, #0xde62, LSL #32
    MOVK  X22, #0x91a9, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D10
    MOVZ  X22, #0xe1e6, LSL #0
    MOVK  X22, #0x1420, LSL #16
    MOVK  X22, #0x76d1, LSL #32
    MOVK  X22, #0x45f9, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X22, #0x9e91, LSL #0
    MOVK  X22, #0x5808, LSL #16
    MOVK  X22, #0xf7d1, LSL #32
    MOVK  X22, #0xb22, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D11
    MOVZ  X22, #0xbcd6, LSL #0
    MOVK  X22, #0xabe4, LSL #16
    MOVK  X22, #0xf3a2, LSL #32
    MOVK  X22, #0x83ea, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X22, #0x4b0, LSL #0
    MOVK  X22, #0x3122, LSL #16
    MOVK  X22, #0x6099, LSL #32
    MOVK  X22, #0x5cfe, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D12
    MOVZ  X22, #0x7d95, LSL #0
    MOVK  X22, #0xe56c, LSL #16
    MOVK  X22, #0xc63, LSL #32
    MOVK  X22, #0x7359, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X22, #0xed86, LSL #0
    MOVK  X22, #0x94b4, LSL #16
    MOVK  X22, #0x572d, LSL #32
    MOVK  X22, #0x465c, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D13
    MOVZ  X22, #0xc2ae, LSL #0
    MOVK  X22, #0xf04a, LSL #16
    MOVK  X22, #0x65a6, LSL #32
    MOVK  X22, #0xe876, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X22, #0xd515, LSL #0
    MOVK  X22, #0x4ab1, LSL #16
    MOVK  X22, #0xdc65, LSL #32
    MOVK  X22, #0x6d12, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D14
    MOVZ  X22, #0x2328, LSL #0
    MOVK  X22, #0x4562, LSL #16
    MOVK  X22, #0x38de, LSL #32
    MOVK  X22, #0xf99e, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X22, #0xb42b, LSL #0
    MOVK  X22, #0xe9b0, LSL #16
    MOVK  X22, #0x60fc, LSL #32
    MOVK  X22, #0x7a0f, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D15
    MOVZ  X22, #0x4e5e, LSL #0
    MOVK  X22, #0x3c43, LSL #16
    MOVK  X22, #0xb4e2, LSL #32
    MOVK  X22, #0x6e90, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X22, #0xefc6, LSL #0
    MOVK  X22, #0x84b0, LSL #16
    MOVK  X22, #0x5425, LSL #32
    MOVK  X22, #0x56dd, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D16
    MOVZ  X22, #0x923b, LSL #0
    MOVK  X22, #0xc8df, LSL #16
    MOVK  X22, #0xe4a6, LSL #32
    MOVK  X22, #0xec17, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X22, #0x48ea, LSL #0
    MOVK  X22, #0xcc74, LSL #16
    MOVK  X22, #0xbeee, LSL #32
    MOVK  X22, #0xcee5, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D17
    MOVZ  X22, #0xa65d, LSL #0
    MOVK  X22, #0xa90f, LSL #16
    MOVK  X22, #0xc13e, LSL #32
    MOVK  X22, #0xd198, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X22, #0xb92f, LSL #0
    MOVK  X22, #0xeb65, LSL #16
    MOVK  X22, #0x5a34, LSL #32
    MOVK  X22, #0x6cf3, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D18
    MOVZ  X22, #0x4ad, LSL #0
    MOVK  X22, #0x7a0a, LSL #16
    MOVK  X22, #0x8719, LSL #32
    MOVK  X22, #0x12dc, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X22, #0xaece, LSL #0
    MOVK  X22, #0xa4d6, LSL #16
    MOVK  X22, #0x5c0b, LSL #32
    MOVK  X22, #0xa2d0, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D19
    MOVZ  X22, #0x9233, LSL #0
    MOVK  X22, #0x8cc6, LSL #16
    MOVK  X22, #0xeca3, LSL #32
    MOVK  X22, #0x9813, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X22, #0x963d, LSL #0
    MOVK  X22, #0x7c26, LSL #16
    MOVK  X22, #0x3a73, LSL #32
    MOVK  X22, #0x350e, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D20
    MOVZ  X22, #0xb949, LSL #0
    MOVK  X22, #0xb3ec, LSL #16
    MOVK  X22, #0x7dc4, LSL #32
    MOVK  X22, #0x50cd, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x4d62, LSL #32
    MOVK  X22, #0x7ecf, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D21
    MOVZ  X22, #0x0, LSL #0
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X22, #0x7524, LSL #0
    MOVK  X22, #0x8510, LSL #16
    MOVK  X22, #0x2370, LSL #32
    MOVK  X22, #0x7617, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D22
    MOVZ  X22, #0xb563, LSL #0
    MOVK  X22, #0xa748, LSL #16
    MOVK  X22, #0x411d, LSL #32
    MOVK  X22, #0x5553, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X22, #0xf33c, LSL #0
    MOVK  X22, #0x860f, LSL #16
    MOVK  X22, #0x257d, LSL #32
    MOVK  X22, #0xa1f3, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D23
    MOVZ  X22, #0x5d5e, LSL #0
    MOVK  X22, #0xbd30, LSL #16
    MOVK  X22, #0x82f4, LSL #32
    MOVK  X22, #0xce5e, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X22, #0xe300, LSL #0
    MOVK  X22, #0x4843, LSL #16
    MOVK  X22, #0xd596, LSL #32
    MOVK  X22, #0x988f, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D24
    MOVZ  X22, #0x5a88, LSL #0
    MOVK  X22, #0x2b39, LSL #16
    MOVK  X22, #0x9a09, LSL #32
    MOVK  X22, #0x58a9, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X22, #0x3968, LSL #0
    MOVK  X22, #0xcf46, LSL #16
    MOVK  X22, #0x1e93, LSL #32
    MOVK  X22, #0xf150, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D25
    MOVZ  X22, #0xbdc4, LSL #0
    MOVK  X22, #0x10ba, LSL #16
    MOVK  X22, #0xf066, LSL #32
    MOVK  X22, #0x10be, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X22, #0xe150, LSL #0
    MOVK  X22, #0x1ae6, LSL #16
    MOVK  X22, #0x819a, LSL #32
    MOVK  X22, #0x990f, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D26
    MOVZ  X22, #0x1a14, LSL #0
    MOVK  X22, #0x73ac, LSL #16
    MOVK  X22, #0x1a49, LSL #32
    MOVK  X22, #0xd80d, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X22, #0x54fd, LSL #0
    MOVK  X22, #0x8f60, LSL #16
    MOVK  X22, #0xd98, LSL #32
    MOVK  X22, #0xccd1, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D27
    MOVZ  X22, #0xbfc6, LSL #0
    MOVK  X22, #0xce6e, LSL #16
    MOVK  X22, #0x4eda, LSL #32
    MOVK  X22, #0xd144, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X22, #0x7bcb, LSL #0
    MOVK  X22, #0xbefb, LSL #16
    MOVK  X22, #0x8665, LSL #32
    MOVK  X22, #0xdff0, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D28
    MOVZ  X22, #0x1634, LSL #0
    MOVK  X22, #0x5b2a, LSL #16
    MOVK  X22, #0xddef, LSL #32
    MOVK  X22, #0x52ff, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X22, #0x735c, LSL #0
    MOVK  X22, #0x8de, LSL #16
    MOVK  X22, #0xb5c6, LSL #32
    MOVK  X22, #0x3652, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D29
    MOVZ  X22, #0xf903, LSL #0
    MOVK  X22, #0xc2cf, LSL #16
    MOVK  X22, #0x770a, LSL #32
    MOVK  X22, #0x63be, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X22, #0xd15c, LSL #0
    MOVK  X22, #0x4be4, LSL #16
    MOVK  X22, #0x4f04, LSL #32
    MOVK  X22, #0x33ab, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D30
    MOVZ  X22, #0x5e4b, LSL #0
    MOVK  X22, #0x6ef9, LSL #16
    MOVK  X22, #0xf7a, LSL #32
    MOVK  X22, #0x52e8, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X22, #0x6d87, LSL #0
    MOVK  X22, #0x3428, LSL #16
    MOVK  X22, #0x3cec, LSL #32
    MOVK  X22, #0x7b3, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D31
    MOVZ  X22, #0xd1ac, LSL #0
    MOVK  X22, #0x528e, LSL #16
    MOVK  X22, #0xf27b, LSL #32
    MOVK  X22, #0xd1f5, LSL #48
    SUB  X23, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0xc9f9, LSL #0
    MOVK  X2, #0xfb09, LSL #16
    MOVK  X2, #0x3c70, LSL #32
    MOVK  X2, #0x569f, LSL #48
    MOVZ  X3, #0xe4ab, LSL #0
    MOVK  X3, #0x24eb, LSL #16
    MOVK  X3, #0x3cf4, LSL #32
    MOVK  X3, #0x4d01, LSL #48
    MOVZ  X4, #0xc037, LSL #0
    MOVK  X4, #0x2cf4, LSL #16
    MOVK  X4, #0x305e, LSL #32
    MOVK  X4, #0x241d, LSL #48
    MOVZ  X5, #0xc249, LSL #0
    MOVK  X5, #0x8e5b, LSL #16
    MOVK  X5, #0xe32f, LSL #32
    MOVK  X5, #0x1c14, LSL #48
    MOVZ  X6, #0x7bf5, LSL #0
    MOVK  X6, #0xf74f, LSL #16
    MOVK  X6, #0xcf8e, LSL #32
    MOVK  X6, #0x1128, LSL #48
    MOVZ  X7, #0x487b, LSL #0
    MOVK  X7, #0x606d, LSL #16
    MOVK  X7, #0xf2ec, LSL #32
    MOVK  X7, #0xa80b, LSL #48
    MOVZ  X8, #0xb785, LSL #0
    MOVK  X8, #0x6ba, LSL #16
    MOVK  X8, #0x4a0d, LSL #32
    MOVK  X8, #0x7c07, LSL #48
    MOVZ  X9, #0xe12a, LSL #0
    MOVK  X9, #0x6627, LSL #16
    MOVK  X9, #0x78d4, LSL #32
    MOVK  X9, #0x7327, LSL #48
    MOVZ  X10, #0x15a2, LSL #0
    MOVK  X10, #0x85c2, LSL #16
    MOVK  X10, #0x4cd8, LSL #32
    MOVK  X10, #0x25a4, LSL #48
    MOVZ  X11, #0x6f5a, LSL #0
    MOVK  X11, #0x476d, LSL #16
    MOVK  X11, #0x323b, LSL #32
    MOVK  X11, #0xed64, LSL #48
    MOVZ  X12, #0xa62d, LSL #0
    MOVK  X12, #0x137a, LSL #16
    MOVK  X12, #0xa48a, LSL #32
    MOVK  X12, #0xe8c7, LSL #48
    MOVZ  X13, #0x1fb9, LSL #0
    MOVK  X13, #0x122f, LSL #16
    MOVK  X13, #0x34fe, LSL #32
    MOVK  X13, #0x670a, LSL #48
    MOVZ  X14, #0xb12a, LSL #0
    MOVK  X14, #0xd7dc, LSL #16
    MOVK  X14, #0xac7c, LSL #32
    MOVK  X14, #0xbbb, LSL #48
    MOVZ  X15, #0x7f2d, LSL #0
    MOVK  X15, #0xb2, LSL #16
    MOVK  X15, #0x5f9d, LSL #32
    MOVK  X15, #0x6d72, LSL #48
    MOVZ  X16, #0xa3a6, LSL #0
    MOVK  X16, #0x45c8, LSL #16
    MOVK  X16, #0x6e52, LSL #32
    MOVK  X16, #0xf557, LSL #48
    MOVZ  X17, #0xe914, LSL #0
    MOVK  X17, #0xcb4d, LSL #16
    MOVK  X17, #0xadf3, LSL #32
    MOVK  X17, #0x7bc2, LSL #48
    MOVZ  X18, #0x4f29, LSL #0
    MOVK  X18, #0xe4ba, LSL #16
    MOVK  X18, #0x7b70, LSL #32
    MOVK  X18, #0x71a3, LSL #48
    MOVZ  X19, #0x4e8a, LSL #0
    MOVK  X19, #0x8ec5, LSL #16
    MOVK  X19, #0x5489, LSL #32
    MOVK  X19, #0xcf54, LSL #48
    MOVZ  X20, #0xc28e, LSL #0
    MOVK  X20, #0xee3, LSL #16
    MOVK  X20, #0x34b0, LSL #32
    MOVK  X20, #0xefc4, LSL #48
    MOVZ  X21, #0x3f7d, LSL #0
    MOVK  X21, #0xa685, LSL #16
    MOVK  X21, #0xac44, LSL #32
    MOVK  X21, #0x387c, LSL #48
    MOVZ  X22, #0x1ba1, LSL #0
    MOVK  X22, #0x21b4, LSL #16
    MOVK  X22, #0xa202, LSL #32
    MOVK  X22, #0xad8, LSL #48
    MOVZ  X23, #0x5563, LSL #0
    MOVK  X23, #0xcd62, LSL #16
    MOVK  X23, #0x966c, LSL #32
    MOVK  X23, #0x7369, LSL #48
    MOVZ  X28, #0x6c62, LSL #0
    MOVK  X28, #0x8582, LSL #16
    MOVK  X28, #0xa50c, LSL #32
    MOVK  X28, #0x59b, LSL #48
    FMOV  D0, X4
    FMOV  V0.D[1], X22
    FMOV  D1, X23
    FMOV  V1.D[1], X28
    FMOV  D2, X4
    FMOV  V2.D[1], X21
    FMOV  D3, X6
    FMOV  V3.D[1], X8
    FMOV  D4, X10
    FMOV  V4.D[1], X12
    FMOV  D5, X28
    FMOV  V5.D[1], X8
    FMOV  D6, X11
    FMOV  V6.D[1], X9
    FMOV  D7, X11
    FMOV  V7.D[1], X23
    FMOV  D8, X18
    FMOV  V8.D[1], X12
    FMOV  D9, X15
    FMOV  V9.D[1], X9
    FMOV  D10, X16
    FMOV  V10.D[1], X22
    FMOV  D11, X10
    FMOV  V11.D[1], X28
    FMOV  D12, X5
    FMOV  V12.D[1], X2
    FMOV  D13, X23
    FMOV  V13.D[1], X10
    FMOV  D14, X8
    FMOV  V14.D[1], X11
    FMOV  D15, X3
    FMOV  V15.D[1], X4
    FMOV  D16, X19
    FMOV  V16.D[1], X15
    FMOV  D17, X28
    FMOV  V17.D[1], X19
    FMOV  D18, X13
    FMOV  V18.D[1], X10
    FMOV  D19, X11
    FMOV  V19.D[1], X17
    FMOV  D20, X13
    FMOV  V20.D[1], X2
    FMOV  D21, X13
    FMOV  V21.D[1], X8
    FMOV  D22, X5
    FMOV  V22.D[1], X8
    FMOV  D23, X10
    FMOV  V23.D[1], X5
    FMOV  D24, X15
    FMOV  V24.D[1], X7
    FMOV  D25, X13
    FMOV  V25.D[1], X4
    FMOV  D26, X20
    FMOV  V26.D[1], X5
    FMOV  D27, X17
    FMOV  V27.D[1], X16
    FMOV  D28, X11
    FMOV  V28.D[1], X23
    FMOV  D29, X23
    FMOV  V29.D[1], X22
    FMOV  D30, X12
    FMOV  V30.D[1], X16
    FMOV  D31, X6
    FMOV  V31.D[1], X13
    MOVZ  X15, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_10:
    EOR3 V20.16B, V25.16B, V23.16B, V23.16B
    XAR V26.2D, V24.2D, V19.2D, #0x21
    SM3TT1B V8.4S, V22.4S, V29.S[0x1]
    SM4E V29.4S, V21.4S
    SM4EKEY V17.4S, V10.4S, V27.4S
    SM4EKEY V30.4S, V31.4S, V29.4S
    SHA512H Q16, Q26, V26.2D
    SHA512H2 Q18, Q15, V17.2D
    SHA512H Q30, Q18, V16.2D
    SM3PARTW2 V9.4S, V20.4S, V28.4S
    SM4E V23.4S, V9.4S
    SM3PARTW2 V29.4S, V23.4S, V17.4S
    BCAX V15.16B, V24.16B, V27.16B, V8.16B
    SM4EKEY V23.4S, V11.4S, V11.4S
    SHA512SU1 V11.2D, V15.2D, V26.2D
    SM3TT1A V21.4S, V27.4S, V23.S[0x0]
    SM3TT1B V28.4S, V21.4S, V31.S[0x2]
    SHA512SU1 V23.2D, V26.2D, V28.2D
    SHA512H2 Q21, Q23, V11.2D
    BCAX V27.16B, V30.16B, V22.16B, V21.16B
    RAX1 V17.2D, V21.2D, V8.2D
    SM4E V26.4S, V8.4S
    XAR V28.2D, V9.2D, V28.2D, #0x26
    SM3PARTW2 V20.4S, V11.4S, V9.4S
    SM3TT1B V22.4S, V20.4S, V18.S[0x0]
    BCAX V16.16B, V5.16B, V4.16B, V4.16B
    SHA512H Q24, Q14, V23.2D
    SM3PARTW2 V21.4S, V27.4S, V5.4S
    SM3PARTW1 V31.4S, V18.4S, V31.4S
    SM4EKEY V18.4S, V26.4S, V22.4S
    EOR3 V24.16B, V29.16B, V27.16B, V30.16B
    SHA512SU1 V8.2D, V2.2D, V26.2D
    SHA512SU1 V7.2D, V29.2D, V17.2D
    SM3PARTW2 V5.4S, V8.4S, V9.4S
    SM3PARTW2 V30.4S, V21.4S, V8.4S
    SM3TT2A V17.4S, V7.4S, V18.S[0x1]
    XAR V18.2D, V30.2D, V13.2D, #0x12
    SM4EKEY V22.4S, V16.4S, V17.4S
    SM3TT2A V7.4S, V18.4S, V3.S[0x0]
    SM4EKEY V14.4S, V27.4S, V24.4S
    SM3SS1 V8.4S, V7.4S, V22.4S, V31.4S
    SHA512H2 Q20, Q8, V28.2D
    RAX1 V24.2D, V2.2D, V31.2D
    SHA512H Q16, Q28, V14.2D
    SM3TT2B V23.4S, V5.4S, V11.S[0x2]
    EOR3 V8.16B, V23.16B, V24.16B, V20.16B
    SHA512H Q11, Q11, V19.2D
    BCAX V7.16B, V19.16B, V22.16B, V29.16B
    SM3SS1 V14.4S, V29.4S, V11.4S, V12.4S
    SHA512H2 Q24, Q28, V10.2D
    SM3TT2A V2.4S, V0.4S, V31.S[0x2]
    SM4EKEY V13.4S, V19.4S, V19.4S
    SM3TT2B V25.4S, V19.4S, V23.S[0x2]
    SM4E V31.4S, V12.4S
    SM4EKEY V23.4S, V7.4S, V14.4S
    SHA512SU0 V22.2D, V31.2D
    BCAX V28.16B, V24.16B, V25.16B, V23.16B
    SHA512H Q14, Q8, V28.2D
    SM4EKEY V24.4S, V31.4S, V26.4S
    XAR V19.2D, V24.2D, V28.2D, #0x16
    SM4E V5.4S, V13.4S
    EOR3 V12.16B, V0.16B, V14.16B, V2.16B
    SHA512SU0 V14.2D, V5.2D
    SM4EKEY V26.4S, V14.4S, V19.4S
    SM4EKEY V28.4S, V12.4S, V28.4S
    SHA512SU1 V25.2D, V8.2D, V1.2D
    SM4EKEY V1.4S, V22.4S, V22.4S
    SM4E V13.4S, V28.4S
    RAX1 V16.2D, V2.2D, V14.2D
    SHA512H2 Q22, Q24, V18.2D
    SM3SS1 V20.4S, V22.4S, V25.4S, V1.4S
    RAX1 V23.2D, V20.2D, V13.2D
    SHA512H2 Q10, Q11, V23.2D
    SM3PARTW2 V14.4S, V26.4S, V16.4S
    EOR3 V18.16B, V31.16B, V0.16B, V9.16B
    EOR3 V9.16B, V0.16B, V31.16B, V6.16B
    SM4EKEY V25.4S, V21.4S, V9.4S
    SM4EKEY V21.4S, V14.4S, V20.4S
    SM4E V23.4S, V31.4S
    SHA512H Q23, Q20, V3.2D
    SM3PARTW1 V3.4S, V21.4S, V2.4S
    SM4EKEY V5.4S, V20.4S, V24.4S
    SM4E V22.4S, V15.4S
    SHA512H Q30, Q24, V20.2D
    XAR V14.2D, V27.2D, V4.2D, #0x31
    EOR3 V11.16B, V3.16B, V23.16B, V18.16B
    SHA512SU0 V9.2D, V15.2D
    SM4EKEY V18.4S, V10.4S, V9.4S
    BCAX V15.16B, V16.16B, V11.16B, V11.16B
    XAR V0.2D, V15.2D, V4.2D, #0x3e
    SHA512SU1 V24.2D, V20.2D, V31.2D
    EOR3 V27.16B, V17.16B, V5.16B, V7.16B
    SM3TT2A V5.4S, V25.4S, V25.S[0x2]
    EOR3 V21.16B, V27.16B, V22.16B, V24.16B
    SHA512SU0 V11.2D, V18.2D
    EOR3 V0.16B, V0.16B, V11.16B, V21.16B
    BCAX V18.16B, V0.16B, V30.16B, V5.16B
    SM4E V0.4S, V1.4S
    SM4EKEY V10.4S, V1.4S, V21.4S
    SM3PARTW2 V20.4S, V14.4S, V15.4S
    SM3TT1A V16.4S, V0.4S, V0.S[0x0]
    SM3SS1 V27.4S, V14.4S, V23.4S, V29.4S
    SM4E V21.4S, V26.4S
    SM4E V25.4S, V28.4S
    SHA512SU1 V22.2D, V19.2D, V26.2D
    SM4EKEY V0.4S, V10.4S, V9.4S
    SM4E V17.4S, V25.4S
    RAX1 V10.2D, V22.2D, V19.2D
    SM4E V11.4S, V30.4S
    SM3TT1B V25.4S, V20.4S, V17.S[0x1]
    EOR3 V3.16B, V16.16B, V11.16B, V22.16B
    SM4EKEY V22.4S, V4.4S, V25.4S
    SHA512SU1 V23.2D, V29.2D, V23.2D
    SM4E V7.4S, V19.4S
    SM4E V20.4S, V10.4S
    RAX1 V11.2D, V21.2D, V16.2D
    SHA512SU1 V17.2D, V23.2D, V7.2D
    EOR3 V19.16B, V17.16B, V4.16B, V21.16B
    SHA512SU1 V24.2D, V19.2D, V19.2D
    SM4E V28.4S, V1.4S
    SM4EKEY V11.4S, V24.4S, V3.4S
    SM4E V25.4S, V0.4S
    SHA512SU1 V14.2D, V14.2D, V20.2D
    SHA512SU0 V8.2D, V29.2D
    EOR3 V6.16B, V27.16B, V7.16B, V14.16B
    EOR3 V11.16B, V28.16B, V6.16B, V28.16B
    SM3TT1B V23.4S, V25.4S, V25.S[0x0]
    SM4E V1.4S, V12.4S
    SM4E V9.4S, V1.4S
    SHA512H Q27, Q22, V14.2D
    SM4E V4.4S, V29.4S
    SHA512H Q7, Q23, V27.2D
    SHA512SU0 V29.2D, V11.2D
    SM4EKEY V6.4S, V14.4S, V9.4S
    BCAX V11.16B, V29.16B, V29.16B, V23.16B
    SM3PARTW1 V0.4S, V8.4S, V7.4S
    SHA512SU1 V28.2D, V0.2D, V4.2D
    BCAX V0.16B, V26.16B, V10.16B, V28.16B
    SM4EKEY V30.4S, V6.4S, V11.4S
    SM3SS1 V15.4S, V2.4S, V22.4S, V21.4S
    SM4E V6.4S, V10.4S
    BCAX V21.16B, V21.16B, V3.16B, V26.16B
    SHA512SU0 V25.2D, V13.2D
    SHA512H2 Q4, Q8, V27.2D
    BCAX V10.16B, V30.16B, V0.16B, V24.16B
    SM4E V28.4S, V1.4S
    SHA512SU1 V22.2D, V24.2D, V2.2D
    SHA512SU1 V13.2D, V24.2D, V8.2D
    EOR3 V22.16B, V24.16B, V14.16B, V10.16B
    SM3TT2A V14.4S, V22.4S, V13.S[0x3]
    XAR V2.2D, V25.2D, V14.2D, #0x21
    SHA512H2 Q26, Q11, V28.2D
    SM3TT2A V23.4S, V6.4S, V21.S[0x0]
    EOR3 V21.16B, V2.16B, V26.16B, V30.16B
    SHA512H Q6, Q23, V23.2D
    XAR V24.2D, V21.2D, V24.2D, #0x3e
    SM3TT1A V8.4S, V8.4S, V24.S[0x3]
    SM4EKEY V0.4S, V2.4S, V2.4S
    XAR V28.2D, V1.2D, V9.2D, #0x2a
    SM4E V3.4S, V31.4S
    SM3TT1A V1.4S, V0.4S, V11.S[0x3]
    XAR V2.2D, V8.2D, V28.2D, #0x3d
    SHA512H2 Q2, Q3, V2.2D
    XAR V3.2D, V1.2D, V6.2D, #0x2c
    SM3SS1 V25.4S, V3.4S, V22.4S, V2.4S
    SHA512H Q27, Q25, V25.2D
    SHA512H2 Q21, Q4, V9.2D
    SHA512H Q5, Q16, V3.2D
    SHA512H Q9, Q9, V13.2D
    SM3PARTW1 V26.4S, V21.4S, V19.4S
    SHA512SU0 V19.2D, V26.2D
    SM4EKEY V2.4S, V9.4S, V5.4S
    SM3TT2A V26.4S, V2.4S, V27.S[0x0]
    SM4EKEY V14.4S, V2.4S, V5.4S
    SM4E V27.4S, V16.4S
    BCAX V2.16B, V20.16B, V22.16B, V12.16B
    SHA512H Q6, Q12, V17.2D
    SM3SS1 V13.4S, V13.4S, V23.4S, V19.4S
    SHA512SU0 V31.2D, V4.2D
    SHA512H Q22, Q9, V19.2D
    EOR3 V11.16B, V12.16B, V31.16B, V7.16B
    SHA512SU1 V20.2D, V2.2D, V7.2D
    SM4E V30.4S, V30.4S
    SHA512SU1 V5.2D, V30.2D, V13.2D
    SM4E V21.4S, V31.4S
    SHA512SU0 V4.2D, V5.2D
    EOR3 V13.16B, V11.16B, V6.16B, V26.16B
    BCAX V23.16B, V14.16B, V29.16B, V22.16B
    SM4E V6.4S, V20.4S
    SM4EKEY V30.4S, V27.4S, V6.4S
    SM3TT2A V26.4S, V21.4S, V21.S[0x0]
    SM3PARTW1 V9.4S, V12.4S, V23.4S
    SHA512SU0 V5.2D, V13.2D
    SHA512SU1 V20.2D, V3.2D, V5.2D
    SM3TT2A V14.4S, V20.4S, V31.S[0x3]
    SHA512H Q17, Q14, V24.2D
    SM4EKEY V20.4S, V30.4S, V9.4S
    SHA512SU1 V21.2D, V26.2D, V16.2D
    SM3PARTW1 V24.4S, V6.4S, V21.4S
    XAR V16.2D, V17.2D, V17.2D, #0x2a
    SUBS  X15, X15, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_10
    MOVZ  X12, #0xe4ab, LSL #0
    MOVK  X12, #0x24eb, LSL #16
    MOVK  X12, #0x3cf4, LSL #32
    MOVK  X12, #0x4d01, LSL #48
    SUB  X2, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0xc037, LSL #0
    MOVK  X12, #0x2cf4, LSL #16
    MOVK  X12, #0x305e, LSL #32
    MOVK  X12, #0x241d, LSL #48
    SUB  X2, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0xc249, LSL #0
    MOVK  X12, #0x8e5b, LSL #16
    MOVK  X12, #0xe32f, LSL #32
    MOVK  X12, #0x1c14, LSL #48
    SUB  X2, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x7bf5, LSL #0
    MOVK  X12, #0xf74f, LSL #16
    MOVK  X12, #0xcf8e, LSL #32
    MOVK  X12, #0x1128, LSL #48
    SUB  X2, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x487b, LSL #0
    MOVK  X12, #0x606d, LSL #16
    MOVK  X12, #0xf2ec, LSL #32
    MOVK  X12, #0xa80b, LSL #48
    SUB  X2, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0xb785, LSL #0
    MOVK  X12, #0x6ba, LSL #16
    MOVK  X12, #0x4a0d, LSL #32
    MOVK  X12, #0x7c07, LSL #48
    SUB  X2, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0xe12a, LSL #0
    MOVK  X12, #0x6627, LSL #16
    MOVK  X12, #0x78d4, LSL #32
    MOVK  X12, #0x7327, LSL #48
    SUB  X2, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x15a2, LSL #0
    MOVK  X12, #0x85c2, LSL #16
    MOVK  X12, #0x4cd8, LSL #32
    MOVK  X12, #0x25a4, LSL #48
    SUB  X2, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x6f5a, LSL #0
    MOVK  X12, #0x476d, LSL #16
    MOVK  X12, #0x323b, LSL #32
    MOVK  X12, #0xed64, LSL #48
    SUB  X2, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x1fb9, LSL #0
    MOVK  X12, #0x122f, LSL #16
    MOVK  X12, #0x34fe, LSL #32
    MOVK  X12, #0x670a, LSL #48
    SUB  X2, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0xb12a, LSL #0
    MOVK  X12, #0xd7dc, LSL #16
    MOVK  X12, #0xac7c, LSL #32
    MOVK  X12, #0xbbb, LSL #48
    SUB  X2, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X2, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0xa3a6, LSL #0
    MOVK  X12, #0x45c8, LSL #16
    MOVK  X12, #0x6e52, LSL #32
    MOVK  X12, #0xf557, LSL #48
    SUB  X2, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0xe914, LSL #0
    MOVK  X12, #0xcb4d, LSL #16
    MOVK  X12, #0xadf3, LSL #32
    MOVK  X12, #0x7bc2, LSL #48
    SUB  X2, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x4f29, LSL #0
    MOVK  X12, #0xe4ba, LSL #16
    MOVK  X12, #0x7b70, LSL #32
    MOVK  X12, #0x71a3, LSL #48
    SUB  X2, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x4e8a, LSL #0
    MOVK  X12, #0x8ec5, LSL #16
    MOVK  X12, #0x5489, LSL #32
    MOVK  X12, #0xcf54, LSL #48
    SUB  X2, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0xc28e, LSL #0
    MOVK  X12, #0xee3, LSL #16
    MOVK  X12, #0x34b0, LSL #32
    MOVK  X12, #0xefc4, LSL #48
    SUB  X2, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x1ba1, LSL #0
    MOVK  X12, #0x21b4, LSL #16
    MOVK  X12, #0xa202, LSL #32
    MOVK  X12, #0xad8, LSL #48
    SUB  X2, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x5563, LSL #0
    MOVK  X12, #0xcd62, LSL #16
    MOVK  X12, #0x966c, LSL #32
    MOVK  X12, #0x7369, LSL #48
    SUB  X2, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X12, #0x6c62, LSL #0
    MOVK  X12, #0x8582, LSL #16
    MOVK  X12, #0xa50c, LSL #32
    MOVK  X12, #0x59b, LSL #48
    SUB  X2, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X12, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X2, #0x9bf3, LSL #0
    MOVK  X2, #0x14b4, LSL #16
    MOVK  X2, #0xc77e, LSL #32
    MOVK  X2, #0x3d1d, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D0
    MOVZ  X2, #0x265b, LSL #0
    MOVK  X2, #0x2c5a, LSL #16
    MOVK  X2, #0x74e8, LSL #32
    MOVK  X2, #0xde7f, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X2, #0x7554, LSL #0
    MOVK  X2, #0x661d, LSL #16
    MOVK  X2, #0xa4da, LSL #32
    MOVK  X2, #0xd467, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D1
    MOVZ  X2, #0xa2fc, LSL #0
    MOVK  X2, #0x81f0, LSL #16
    MOVK  X2, #0x806a, LSL #32
    MOVK  X2, #0x940d, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X2, #0xe7fd, LSL #0
    MOVK  X2, #0xe4ad, LSL #16
    MOVK  X2, #0xabcb, LSL #32
    MOVK  X2, #0x5b3e, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D2
    MOVZ  X2, #0x5768, LSL #0
    MOVK  X2, #0x9ca6, LSL #16
    MOVK  X2, #0x9c74, LSL #32
    MOVK  X2, #0xd089, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X2, #0x99d, LSL #0
    MOVK  X2, #0x8fb9, LSL #16
    MOVK  X2, #0xac43, LSL #32
    MOVK  X2, #0xf061, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D3
    MOVZ  X2, #0x9067, LSL #0
    MOVK  X2, #0x3dba, LSL #16
    MOVK  X2, #0x6571, LSL #32
    MOVK  X2, #0x73dc, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X2, #0x843a, LSL #0
    MOVK  X2, #0x379a, LSL #16
    MOVK  X2, #0xf666, LSL #32
    MOVK  X2, #0x86fd, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D4
    MOVZ  X2, #0x61b9, LSL #0
    MOVK  X2, #0xfc0, LSL #16
    MOVK  X2, #0xbd76, LSL #32
    MOVK  X2, #0x782d, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X2, #0x6c83, LSL #0
    MOVK  X2, #0x3d4a, LSL #16
    MOVK  X2, #0xa709, LSL #32
    MOVK  X2, #0xea5e, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D5
    MOVZ  X2, #0x97a0, LSL #0
    MOVK  X2, #0x53cf, LSL #16
    MOVK  X2, #0xd793, LSL #32
    MOVK  X2, #0xbd0, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X2, #0xc52e, LSL #0
    MOVK  X2, #0xdb4, LSL #16
    MOVK  X2, #0x69a6, LSL #32
    MOVK  X2, #0xd0b9, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D6
    MOVZ  X2, #0x961f, LSL #0
    MOVK  X2, #0x77c3, LSL #16
    MOVK  X2, #0xecc5, LSL #32
    MOVK  X2, #0x62c0, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X2, #0xab39, LSL #0
    MOVK  X2, #0xd69f, LSL #16
    MOVK  X2, #0xff32, LSL #32
    MOVK  X2, #0x8afe, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D7
    MOVZ  X2, #0xc73e, LSL #0
    MOVK  X2, #0xf855, LSL #16
    MOVK  X2, #0x4eaa, LSL #32
    MOVK  X2, #0x870f, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X2, #0xcc1e, LSL #0
    MOVK  X2, #0x3cf7, LSL #16
    MOVK  X2, #0xe03c, LSL #32
    MOVK  X2, #0x142e, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D8
    MOVZ  X2, #0xca61, LSL #0
    MOVK  X2, #0xf8c4, LSL #16
    MOVK  X2, #0xf711, LSL #32
    MOVK  X2, #0x9f99, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X2, #0xf51e, LSL #0
    MOVK  X2, #0xed3f, LSL #16
    MOVK  X2, #0x3081, LSL #32
    MOVK  X2, #0x88d1, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D9
    MOVZ  X2, #0xc25c, LSL #0
    MOVK  X2, #0xac1c, LSL #16
    MOVK  X2, #0xdb44, LSL #32
    MOVK  X2, #0xb988, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X2, #0x34c9, LSL #0
    MOVK  X2, #0xaa5e, LSL #16
    MOVK  X2, #0x89ac, LSL #32
    MOVK  X2, #0xb1ad, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D10
    MOVZ  X2, #0xaaad, LSL #0
    MOVK  X2, #0x3147, LSL #16
    MOVK  X2, #0x5a06, LSL #32
    MOVK  X2, #0x58b4, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X2, #0xd8b6, LSL #0
    MOVK  X2, #0x1da0, LSL #16
    MOVK  X2, #0xbd9d, LSL #32
    MOVK  X2, #0x8668, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D11
    MOVZ  X2, #0x153d, LSL #0
    MOVK  X2, #0xb686, LSL #16
    MOVK  X2, #0x9e0, LSL #32
    MOVK  X2, #0x4eba, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X2, #0x6070, LSL #0
    MOVK  X2, #0xc918, LSL #16
    MOVK  X2, #0xcbb9, LSL #32
    MOVK  X2, #0x37f, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D12
    MOVZ  X2, #0x1b, LSL #0
    MOVK  X2, #0xae3e, LSL #16
    MOVK  X2, #0xdf3b, LSL #32
    MOVK  X2, #0xafbe, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X2, #0x9295, LSL #0
    MOVK  X2, #0xf087, LSL #16
    MOVK  X2, #0x7739, LSL #32
    MOVK  X2, #0xc62b, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D13
    MOVZ  X2, #0x4fd1, LSL #0
    MOVK  X2, #0xc3e8, LSL #16
    MOVK  X2, #0x5089, LSL #32
    MOVK  X2, #0x8408, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X2, #0xa348, LSL #0
    MOVK  X2, #0x14af, LSL #16
    MOVK  X2, #0x6c77, LSL #32
    MOVK  X2, #0x7d8e, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D14
    MOVZ  X2, #0xb0f9, LSL #0
    MOVK  X2, #0x3e3c, LSL #16
    MOVK  X2, #0xac4a, LSL #32
    MOVK  X2, #0x73d8, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xab3c, LSL #32
    MOVK  X2, #0xf245, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D15
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X2, #0xb09c, LSL #0
    MOVK  X2, #0xd508, LSL #16
    MOVK  X2, #0x6b85, LSL #32
    MOVK  X2, #0xc416, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D17
    MOVZ  X2, #0x4760, LSL #0
    MOVK  X2, #0xe619, LSL #16
    MOVK  X2, #0x1186, LSL #32
    MOVK  X2, #0xd3b4, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X2, #0x3a68, LSL #0
    MOVK  X2, #0x88ec, LSL #16
    MOVK  X2, #0xee8, LSL #32
    MOVK  X2, #0xfa0d, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D18
    MOVZ  X2, #0x48d0, LSL #0
    MOVK  X2, #0x806d, LSL #16
    MOVK  X2, #0x1e5e, LSL #32
    MOVK  X2, #0x36bf, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X2, #0x2910, LSL #0
    MOVK  X2, #0x9454, LSL #16
    MOVK  X2, #0x1cd4, LSL #32
    MOVK  X2, #0x8968, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D19
    MOVZ  X2, #0x36, LSL #0
    MOVK  X2, #0xdd6c, LSL #16
    MOVK  X2, #0x67b3, LSL #32
    MOVK  X2, #0x10a2, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X2, #0xc9b0, LSL #0
    MOVK  X2, #0x3c8a, LSL #16
    MOVK  X2, #0x5960, LSL #32
    MOVK  X2, #0x743b, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D20
    MOVZ  X2, #0x632e, LSL #0
    MOVK  X2, #0x2091, LSL #16
    MOVK  X2, #0xbf01, LSL #32
    MOVK  X2, #0x17ea, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X2, #0x285a, LSL #0
    MOVK  X2, #0x7362, LSL #16
    MOVK  X2, #0x4381, LSL #32
    MOVK  X2, #0x2ab3, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D21
    MOVZ  X2, #0x61b9, LSL #0
    MOVK  X2, #0x4a86, LSL #16
    MOVK  X2, #0x3a20, LSL #32
    MOVK  X2, #0xbda7, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X2, #0x8cc9, LSL #0
    MOVK  X2, #0xbb0a, LSL #16
    MOVK  X2, #0x3941, LSL #32
    MOVK  X2, #0xff9, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D22
    MOVZ  X2, #0xfe4f, LSL #0
    MOVK  X2, #0x2da2, LSL #16
    MOVK  X2, #0xacf2, LSL #32
    MOVK  X2, #0x194f, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X2, #0x1d6b, LSL #0
    MOVK  X2, #0x51ad, LSL #16
    MOVK  X2, #0xa34e, LSL #32
    MOVK  X2, #0x34af, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D23
    MOVZ  X2, #0xc724, LSL #0
    MOVK  X2, #0x1085, LSL #16
    MOVK  X2, #0xe1f1, LSL #32
    MOVK  X2, #0xba8c, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X2, #0x1f00, LSL #0
    MOVK  X2, #0xe422, LSL #16
    MOVK  X2, #0xb8da, LSL #32
    MOVK  X2, #0x8b0d, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D24
    MOVZ  X2, #0xdb1a, LSL #0
    MOVK  X2, #0xc4a5, LSL #16
    MOVK  X2, #0xde4b, LSL #32
    MOVK  X2, #0xfbbc, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xfb2e, LSL #32
    MOVK  X2, #0xe9ec, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D25
    MOVZ  X2, #0x0, LSL #0
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X2, #0x4f48, LSL #0
    MOVK  X2, #0x9b9c, LSL #16
    MOVK  X2, #0x62fc, LSL #32
    MOVK  X2, #0x8c63, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D26
    MOVZ  X2, #0xaaeb, LSL #0
    MOVK  X2, #0x3b02, LSL #16
    MOVK  X2, #0x4dc2, LSL #32
    MOVK  X2, #0x6b17, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X2, #0x203f, LSL #0
    MOVK  X2, #0x892d, LSL #16
    MOVK  X2, #0x1187, LSL #32
    MOVK  X2, #0x1d01, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D27
    MOVZ  X2, #0xc8f2, LSL #0
    MOVK  X2, #0xb34c, LSL #16
    MOVK  X2, #0x7bc5, LSL #32
    MOVK  X2, #0x946c, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X2, #0x7297, LSL #0
    MOVK  X2, #0x67af, LSL #16
    MOVK  X2, #0x357a, LSL #32
    MOVK  X2, #0x2165, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D28
    MOVZ  X2, #0xfb43, LSL #0
    MOVK  X2, #0x8c6c, LSL #16
    MOVK  X2, #0x97f8, LSL #32
    MOVK  X2, #0x8cfc, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X2, #0x53d1, LSL #0
    MOVK  X2, #0x7f2e, LSL #16
    MOVK  X2, #0x1947, LSL #32
    MOVK  X2, #0x2600, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D29
    MOVZ  X2, #0x4f3b, LSL #0
    MOVK  X2, #0x6312, LSL #16
    MOVK  X2, #0xddca, LSL #32
    MOVK  X2, #0x8cf7, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X2, #0xd449, LSL #0
    MOVK  X2, #0x813b, LSL #16
    MOVK  X2, #0x2242, LSL #32
    MOVK  X2, #0xb82e, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D30
    MOVZ  X2, #0xd3fa, LSL #0
    MOVK  X2, #0xb1b6, LSL #16
    MOVK  X2, #0xe7a7, LSL #32
    MOVK  X2, #0x9128, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X2, #0x13ff, LSL #0
    MOVK  X2, #0x227, LSL #16
    MOVK  X2, #0x8916, LSL #32
    MOVK  X2, #0xfe9, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X12, D31
    MOVZ  X2, #0xd218, LSL #0
    MOVK  X2, #0xe0ed, LSL #16
    MOVK  X2, #0x9871, LSL #32
    MOVK  X2, #0x660b, LSL #48
    SUB  X21, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0x0, LSL #0
    FMOV  D0, X18
    FMOV  V0.D[1], X10
    FMOV  D1, X16
    FMOV  V1.D[1], X13
    FMOV  D2, X3
    FMOV  V2.D[1], X23
    FMOV  D3, X8
    FMOV  V3.D[1], X22
    FMOV  D4, X15
    FMOV  V4.D[1], X20
    FMOV  D5, X17
    FMOV  V5.D[1], X21
    FMOV  D6, X19
    FMOV  V6.D[1], X18
    FMOV  D7, X28
    FMOV  V7.D[1], X12
    FMOV  D8, X13
    FMOV  V8.D[1], X8
    FMOV  D9, X20
    FMOV  V9.D[1], X15
    FMOV  D10, X17
    FMOV  V10.D[1], X10
    FMOV  D11, X15
    FMOV  V11.D[1], X7
    FMOV  D12, X4
    FMOV  V12.D[1], X7
    FMOV  D13, X19
    FMOV  V13.D[1], X18
    FMOV  D14, X21
    FMOV  V14.D[1], X11
    FMOV  D15, X3
    FMOV  V15.D[1], X19
    FMOV  D16, X20
    FMOV  V16.D[1], X11
    FMOV  D17, X16
    FMOV  V17.D[1], X7
    FMOV  D18, X10
    FMOV  V18.D[1], X28
    FMOV  D19, X4
    FMOV  V19.D[1], X11
    FMOV  D20, X2
    FMOV  V20.D[1], X2
    FMOV  D21, X18
    FMOV  V21.D[1], X20
    FMOV  D22, X13
    FMOV  V22.D[1], X20
    FMOV  D23, X11
    FMOV  V23.D[1], X9
    FMOV  D24, X12
    FMOV  V24.D[1], X17
    FMOV  D25, X4
    FMOV  V25.D[1], X18
    FMOV  D26, X8
    FMOV  V26.D[1], X5
    FMOV  D27, X13
    FMOV  V27.D[1], X11
    FMOV  D28, X4
    FMOV  V28.D[1], X20
    FMOV  D29, X12
    FMOV  V29.D[1], X13
    FMOV  D30, X16
    FMOV  V30.D[1], X20
    FMOV  D31, X20
    FMOV  V31.D[1], X23
    MOVZ  X10, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_11:
    XAR V10.2D, V18.2D, V12.2D, #0x18
    SM4EKEY V4.4S, V24.4S, V21.4S
    BCAX V8.16B, V27.16B, V27.16B, V27.16B
    SHA512H Q16, Q25, V3.2D
    BCAX V7.16B, V1.16B, V2.16B, V4.16B
    BCAX V18.16B, V7.16B, V8.16B, V26.16B
    SM3SS1 V24.4S, V0.4S, V21.4S, V18.4S
    SM3PARTW2 V0.4S, V16.4S, V10.4S
    SM3PARTW2 V3.4S, V30.4S, V29.4S
    SM3TT1B V10.4S, V3.4S, V0.S[0x0]
    XAR V1.2D, V4.2D, V31.2D, #0x33
    SM3TT2A V29.4S, V1.4S, V10.S[0x2]
    SHA512SU1 V20.2D, V24.2D, V18.2D
    RAX1 V27.2D, V20.2D, V29.2D
    SHA512H2 Q21, Q27, V28.2D
    SHA512H2 Q7, Q1, V19.2D
    SM3SS1 V10.4S, V16.4S, V12.4S, V23.4S
    BCAX V2.16B, V26.16B, V9.16B, V4.16B
    SM3TT2A V30.4S, V7.4S, V22.S[0x0]
    SHA512SU0 V12.2D, V27.2D
    SHA512SU1 V1.2D, V30.2D, V21.2D
    SM3PARTW1 V18.4S, V14.4S, V11.4S
    SHA512H2 Q11, Q14, V7.2D
    SM3PARTW2 V14.4S, V21.4S, V13.4S
    SM3TT2B V0.4S, V5.4S, V16.S[0x1]
    RAX1 V3.2D, V27.2D, V7.2D
    SM3TT2B V23.4S, V3.4S, V25.S[0x0]
    XAR V2.2D, V18.2D, V6.2D, #0x6
    SM4EKEY V13.4S, V10.4S, V0.4S
    SM4EKEY V27.4S, V1.4S, V27.4S
    BCAX V30.16B, V22.16B, V23.16B, V27.16B
    SM3TT1B V5.4S, V11.4S, V26.S[0x2]
    SM3TT1A V20.4S, V14.4S, V5.S[0x3]
    SM3PARTW1 V16.4S, V17.4S, V4.4S
    SM4E V10.4S, V11.4S
    XAR V3.2D, V10.2D, V11.2D, #0x28
    RAX1 V27.2D, V31.2D, V17.2D
    XAR V15.2D, V12.2D, V13.2D, #0x3f
    SHA512H Q10, Q19, V23.2D
    SM3PARTW2 V17.4S, V3.4S, V12.4S
    EOR3 V22.16B, V15.16B, V29.16B, V27.16B
    EOR3 V5.16B, V0.16B, V20.16B, V16.16B
    SM4E V4.4S, V5.4S
    SHA512SU0 V15.2D, V10.2D
    SHA512SU1 V5.2D, V2.2D, V5.2D
    SM4E V25.4S, V15.4S
    SM3SS1 V28.4S, V17.4S, V4.4S, V4.4S
    SM3PARTW1 V3.4S, V28.4S, V25.4S
    SHA512H2 Q0, Q3, V22.2D
    SM3PARTW1 V13.4S, V29.4S, V30.4S
    SHA512H Q27, Q17, V17.2D
    SM3TT2B V2.4S, V5.4S, V5.S[0x0]
    SM4EKEY V14.4S, V31.4S, V13.4S
    SHA512SU0 V16.2D, V27.2D
    SM3TT1B V31.4S, V30.4S, V2.S[0x2]
    SM4EKEY V29.4S, V30.4S, V14.4S
    SM3PARTW1 V1.4S, V6.4S, V0.4S
    SM3TT1A V28.4S, V22.4S, V14.S[0x1]
    SM4EKEY V23.4S, V15.4S, V17.4S
    SHA512H2 Q13, Q1, V1.2D
    SM3TT1B V8.4S, V13.4S, V25.S[0x3]
    SM4EKEY V22.4S, V20.4S, V31.4S
    XAR V4.2D, V23.2D, V23.2D, #0x2f
    SHA512SU1 V23.2D, V29.2D, V28.2D
    SM4EKEY V14.4S, V4.4S, V19.4S
    XAR V11.2D, V2.2D, V22.2D, #0x14
    SHA512H2 Q3, Q16, V16.2D
    SM3PARTW1 V15.4S, V11.4S, V23.4S
    SM3TT2A V13.4S, V10.4S, V3.S[0x1]
    SM3TT1B V17.4S, V15.4S, V4.S[0x1]
    SM4E V4.4S, V13.4S
    SM3TT1A V25.4S, V8.4S, V9.S[0x0]
    BCAX V29.16B, V17.16B, V17.16B, V25.16B
    BCAX V15.16B, V4.16B, V14.16B, V14.16B
    BCAX V19.16B, V25.16B, V6.16B, V8.16B
    EOR3 V31.16B, V22.16B, V17.16B, V10.16B
    SHA512SU1 V3.2D, V20.2D, V12.2D
    EOR3 V31.16B, V20.16B, V16.16B, V8.16B
    SM3SS1 V10.4S, V4.4S, V29.4S, V7.4S
    SM4EKEY V8.4S, V9.4S, V0.4S
    SM4EKEY V20.4S, V12.4S, V22.4S
    SM3TT1A V17.4S, V7.4S, V14.S[0x0]
    RAX1 V14.2D, V7.2D, V22.2D
    SHA512H Q14, Q8, V31.2D
    SM3TT1A V31.4S, V29.4S, V11.S[0x2]
    SM4EKEY V9.4S, V2.4S, V17.4S
    SHA512SU0 V11.2D, V19.2D
    SM4EKEY V29.4S, V10.4S, V14.4S
    RAX1 V22.2D, V20.2D, V8.2D
    SHA512SU1 V23.2D, V3.2D, V4.2D
    RAX1 V12.2D, V29.2D, V7.2D
    EOR3 V16.16B, V2.16B, V12.16B, V26.16B
    SM3SS1 V20.4S, V26.4S, V15.4S, V11.4S
    SM3TT2A V28.4S, V22.4S, V9.S[0x3]
    XAR V26.2D, V15.2D, V16.2D, #0x1a
    SM3PARTW2 V17.4S, V26.4S, V1.4S
    SM4E V4.4S, V27.4S
    BCAX V9.16B, V6.16B, V28.16B, V29.16B
    SHA512H Q10, Q11, V20.2D
    SHA512SU0 V20.2D, V17.2D
    EOR3 V26.16B, V26.16B, V4.16B, V27.16B
    EOR3 V14.16B, V20.16B, V9.16B, V9.16B
    SHA512SU0 V18.2D, V26.2D
    SHA512H Q19, Q29, V13.2D
    SM3TT1A V16.4S, V18.4S, V10.S[0x3]
    SM4E V3.4S, V14.4S
    SHA512SU1 V6.2D, V28.2D, V2.2D
    SHA512SU0 V20.2D, V6.2D
    SM4EKEY V11.4S, V26.4S, V26.4S
    XAR V29.2D, V16.2D, V26.2D, #0x38
    SM3PARTW1 V30.4S, V20.4S, V29.4S
    RAX1 V4.2D, V30.2D, V3.2D
    SHA512H2 Q18, Q17, V23.2D
    SM3TT2B V8.4S, V11.4S, V20.S[0x3]
    SM3PARTW1 V16.4S, V18.4S, V17.4S
    EOR3 V22.16B, V19.16B, V9.16B, V4.16B
    BCAX V26.16B, V22.16B, V19.16B, V17.16B
    SHA512SU1 V29.2D, V10.2D, V30.2D
    SM4EKEY V3.4S, V29.4S, V31.4S
    SM4EKEY V20.4S, V16.4S, V8.4S
    SM4EKEY V10.4S, V3.4S, V26.4S
    SHA512SU0 V14.2D, V17.2D
    SM4E V11.4S, V5.4S
    SM3PARTW2 V3.4S, V19.4S, V16.4S
    XAR V16.2D, V1.2D, V8.2D, #0x2d
    SM4EKEY V2.4S, V22.4S, V14.4S
    RAX1 V14.2D, V11.2D, V5.2D
    SHA512H2 Q27, Q13, V12.2D
    SM3TT2B V1.4S, V0.4S, V30.S[0x2]
    EOR3 V22.16B, V3.16B, V29.16B, V21.16B
    SHA512H2 Q31, Q22, V1.2D
    BCAX V30.16B, V8.16B, V5.16B, V20.16B
    BCAX V8.16B, V5.16B, V11.16B, V26.16B
    SHA512SU1 V6.2D, V4.2D, V22.2D
    SM4EKEY V23.4S, V16.4S, V5.4S
    XAR V22.2D, V27.2D, V20.2D, #0xd
    SM4E V28.4S, V28.4S
    SM3PARTW1 V1.4S, V21.4S, V10.4S
    EOR3 V18.16B, V1.16B, V2.16B, V8.16B
    SM3TT1B V19.4S, V22.4S, V31.S[0x3]
    SM3TT1B V31.4S, V18.4S, V28.S[0x3]
    SHA512SU1 V6.2D, V28.2D, V31.2D
    BCAX V25.16B, V30.16B, V15.16B, V19.16B
    SM3TT1A V8.4S, V12.4S, V6.S[0x3]
    SM3PARTW1 V27.4S, V25.4S, V23.4S
    SM4EKEY V29.4S, V8.4S, V14.4S
    SM4EKEY V18.4S, V22.4S, V18.4S
    SM3TT2B V28.4S, V27.4S, V16.S[0x3]
    SHA512SU0 V14.2D, V17.2D
    SHA512H2 Q5, Q14, V21.2D
    SM3TT1B V30.4S, V5.4S, V26.S[0x3]
    SHA512H Q25, Q7, V10.2D
    BCAX V14.16B, V20.16B, V13.16B, V22.16B
    RAX1 V27.2D, V14.2D, V19.2D
    SM4EKEY V6.4S, V24.4S, V20.4S
    SM4E V20.4S, V31.4S
    RAX1 V15.2D, V29.2D, V16.2D
    SHA512H Q19, Q13, V6.2D
    SM4E V11.4S, V16.4S
    SHA512SU0 V20.2D, V11.2D
    BCAX V16.16B, V15.16B, V18.16B, V18.16B
    SM4E V7.4S, V24.4S
    SHA512H Q23, Q19, V26.2D
    SM4E V19.4S, V20.4S
    SM3TT2B V6.4S, V19.4S, V25.S[0x0]
    SM4E V13.4S, V28.4S
    SM4EKEY V12.4S, V23.4S, V16.4S
    BCAX V24.16B, V12.16B, V3.16B, V30.16B
    SM3TT2B V11.4S, V13.4S, V24.S[0x0]
    SM3PARTW2 V5.4S, V15.4S, V6.4S
    XAR V31.2D, V21.2D, V5.2D, #0x2f
    SM3TT1B V26.4S, V7.4S, V21.S[0x0]
    SM4E V13.4S, V26.4S
    SM4E V15.4S, V7.4S
    SM3TT2A V25.4S, V11.4S, V27.S[0x0]
    SM3TT1B V3.4S, V26.4S, V28.S[0x2]
    SM3TT2B V7.4S, V15.4S, V13.S[0x3]
    SM3TT2A V0.4S, V3.4S, V7.S[0x1]
    SM4E V12.4S, V26.4S
    SM4E V26.4S, V25.4S
    SHA512H2 Q18, Q0, V28.2D
    SM3TT2A V21.4S, V24.4S, V12.S[0x1]
    SM4E V12.4S, V17.4S
    SHA512H Q6, Q9, V13.2D
    SM4EKEY V29.4S, V26.4S, V7.4S
    SHA512H2 Q7, Q18, V31.2D
    SM3TT1B V8.4S, V12.4S, V29.S[0x2]
    SM3PARTW1 V15.4S, V4.4S, V2.4S
    SM3TT2B V16.4S, V21.4S, V7.S[0x3]
    EOR3 V21.16B, V8.16B, V8.16B, V16.16B
    XAR V12.2D, V15.2D, V21.2D, #0x7
    SM4EKEY V28.4S, V6.4S, V13.4S
    SHA512H2 Q0, Q31, V20.2D
    BCAX V17.16B, V7.16B, V7.16B, V3.16B
    SHA512SU0 V29.2D, V11.2D
    BCAX V23.16B, V6.16B, V2.16B, V25.16B
    SHA512SU1 V20.2D, V20.2D, V18.2D
    SHA512SU1 V31.2D, V4.2D, V10.2D
    SM4E V4.4S, V8.4S
    SHA512SU1 V7.2D, V31.2D, V0.2D
    SUBS  X10, X10, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_11
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X18, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X2, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X18, #0xccfa, LSL #0
    MOVK  X18, #0xb54d, LSL #16
    MOVK  X18, #0x3eaa, LSL #32
    MOVK  X18, #0x542, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D0
    MOVZ  X18, #0x4722, LSL #0
    MOVK  X18, #0xb09e, LSL #16
    MOVK  X18, #0xf2a, LSL #32
    MOVK  X18, #0x2a0, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X18, #0x708, LSL #0
    MOVK  X18, #0xb779, LSL #16
    MOVK  X18, #0xae8, LSL #32
    MOVK  X18, #0xbcd8, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D1
    MOVZ  X18, #0x6e8b, LSL #0
    MOVK  X18, #0xad7e, LSL #16
    MOVK  X18, #0xd1b3, LSL #32
    MOVK  X18, #0x7f03, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X18, #0xd9c5, LSL #0
    MOVK  X18, #0x179d, LSL #16
    MOVK  X18, #0x7211, LSL #32
    MOVK  X18, #0xdec7, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D2
    MOVZ  X18, #0x8ffd, LSL #0
    MOVK  X18, #0x199b, LSL #16
    MOVK  X18, #0xdafa, LSL #32
    MOVK  X18, #0x7ce, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X18, #0x8e44, LSL #0
    MOVK  X18, #0xd509, LSL #16
    MOVK  X18, #0x47c9, LSL #32
    MOVK  X18, #0xe8d6, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D3
    MOVZ  X18, #0xc2dd, LSL #0
    MOVK  X18, #0x9de6, LSL #16
    MOVK  X18, #0x63b6, LSL #32
    MOVK  X18, #0xbcee, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X18, #0x1a4, LSL #0
    MOVK  X18, #0x572b, LSL #16
    MOVK  X18, #0x613e, LSL #32
    MOVK  X18, #0xfe0, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D4
    MOVZ  X18, #0x3f32, LSL #0
    MOVK  X18, #0x3841, LSL #16
    MOVK  X18, #0x1026, LSL #32
    MOVK  X18, #0x3216, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X18, #0xa583, LSL #0
    MOVK  X18, #0xf87c, LSL #16
    MOVK  X18, #0xdc07, LSL #32
    MOVK  X18, #0x2828, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D5
    MOVZ  X18, #0x3f56, LSL #0
    MOVK  X18, #0x9c87, LSL #16
    MOVK  X18, #0x1069, LSL #32
    MOVK  X18, #0x1a49, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X18, #0xfb35, LSL #0
    MOVK  X18, #0x3dde, LSL #16
    MOVK  X18, #0x38f3, LSL #32
    MOVK  X18, #0xbfee, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D6
    MOVZ  X18, #0x8a9c, LSL #0
    MOVK  X18, #0xbf72, LSL #16
    MOVK  X18, #0x201b, LSL #32
    MOVK  X18, #0x55ec, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X18, #0x701b, LSL #0
    MOVK  X18, #0x8f14, LSL #16
    MOVK  X18, #0xd0f5, LSL #32
    MOVK  X18, #0xf9fc, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D7
    MOVZ  X18, #0xb04, LSL #0
    MOVK  X18, #0xb8ea, LSL #16
    MOVK  X18, #0xcfeb, LSL #32
    MOVK  X18, #0x2402, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X18, #0xed07, LSL #0
    MOVK  X18, #0xc55, LSL #16
    MOVK  X18, #0xc8ae, LSL #32
    MOVK  X18, #0x4c58, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D8
    MOVZ  X18, #0xae46, LSL #0
    MOVK  X18, #0x3b89, LSL #16
    MOVK  X18, #0xb470, LSL #32
    MOVK  X18, #0x870e, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X18, #0x53a8, LSL #0
    MOVK  X18, #0x5fbe, LSL #16
    MOVK  X18, #0x1450, LSL #32
    MOVK  X18, #0x7a0, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D9
    MOVZ  X18, #0xe1e3, LSL #0
    MOVK  X18, #0xf9d6, LSL #16
    MOVK  X18, #0x58d6, LSL #32
    MOVK  X18, #0x7284, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X18, #0xf9ce, LSL #0
    MOVK  X18, #0x218f, LSL #16
    MOVK  X18, #0xad6, LSL #32
    MOVK  X18, #0x4cf8, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D10
    MOVZ  X18, #0x858d, LSL #0
    MOVK  X18, #0x8c8f, LSL #16
    MOVK  X18, #0xb5e1, LSL #32
    MOVK  X18, #0xb1d1, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X18, #0xf3e4, LSL #0
    MOVK  X18, #0xc8c3, LSL #16
    MOVK  X18, #0x6df5, LSL #32
    MOVK  X18, #0xbf65, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D11
    MOVZ  X18, #0x68d4, LSL #0
    MOVK  X18, #0xb7b9, LSL #16
    MOVK  X18, #0x7c3d, LSL #32
    MOVK  X18, #0xb1ab, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X18, #0x5372, LSL #0
    MOVK  X18, #0xf785, LSL #16
    MOVK  X18, #0xe4ca, LSL #32
    MOVK  X18, #0xa378, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D12
    MOVZ  X18, #0x126b, LSL #0
    MOVK  X18, #0xaba8, LSL #16
    MOVK  X18, #0xce67, LSL #32
    MOVK  X18, #0x22a9, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X18, #0xd848, LSL #0
    MOVK  X18, #0x59fb, LSL #16
    MOVK  X18, #0x7f92, LSL #32
    MOVK  X18, #0xb223, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D13
    MOVZ  X18, #0xc7a1, LSL #0
    MOVK  X18, #0xf1e7, LSL #16
    MOVK  X18, #0xf409, LSL #32
    MOVK  X18, #0x7ab3, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X18, #0x940c, LSL #0
    MOVK  X18, #0x83a4, LSL #16
    MOVK  X18, #0xd348, LSL #32
    MOVK  X18, #0x1ba8, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D14
    MOVZ  X18, #0xc24a, LSL #0
    MOVK  X18, #0xc9a, LSL #16
    MOVK  X18, #0x35ba, LSL #32
    MOVK  X18, #0x951d, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X18, #0x27c7, LSL #0
    MOVK  X18, #0x8a3a, LSL #16
    MOVK  X18, #0xb0ff, LSL #32
    MOVK  X18, #0xf5a7, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D15
    MOVZ  X18, #0x4d47, LSL #0
    MOVK  X18, #0xd2ad, LSL #16
    MOVK  X18, #0x358e, LSL #32
    MOVK  X18, #0xbc3c, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X18, #0x9e96, LSL #0
    MOVK  X18, #0x4893, LSL #16
    MOVK  X18, #0xd584, LSL #32
    MOVK  X18, #0x49d5, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D16
    MOVZ  X18, #0x78d6, LSL #0
    MOVK  X18, #0x6a4, LSL #16
    MOVK  X18, #0x65b, LSL #32
    MOVK  X18, #0xe8db, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X18, #0x8044, LSL #0
    MOVK  X18, #0x509, LSL #16
    MOVK  X18, #0x4341, LSL #32
    MOVK  X18, #0x2054, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D17
    MOVZ  X18, #0x4c, LSL #0
    MOVK  X18, #0x14e6, LSL #16
    MOVK  X18, #0x6122, LSL #32
    MOVK  X18, #0x242c, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X18, #0xa50a, LSL #0
    MOVK  X18, #0x6b6a, LSL #16
    MOVK  X18, #0x8efb, LSL #32
    MOVK  X18, #0xfb54, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D18
    MOVZ  X18, #0x5d2e, LSL #0
    MOVK  X18, #0x5281, LSL #16
    MOVK  X18, #0x15e8, LSL #32
    MOVK  X18, #0xd032, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X18, #0xc249, LSL #0
    MOVK  X18, #0x99d9, LSL #16
    MOVK  X18, #0xdaac, LSL #32
    MOVK  X18, #0x134d, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D19
    MOVZ  X18, #0x613b, LSL #0
    MOVK  X18, #0x56dd, LSL #16
    MOVK  X18, #0x63d5, LSL #32
    MOVK  X18, #0x88d7, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X18, #0xcf97, LSL #0
    MOVK  X18, #0xb2f3, LSL #16
    MOVK  X18, #0x1ab4, LSL #32
    MOVK  X18, #0x82c7, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D20
    MOVZ  X18, #0x2e0d, LSL #0
    MOVK  X18, #0xf8d0, LSL #16
    MOVK  X18, #0xcee0, LSL #32
    MOVK  X18, #0xf1a6, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X18, #0x9e96, LSL #0
    MOVK  X18, #0x4893, LSL #16
    MOVK  X18, #0xd584, LSL #32
    MOVK  X18, #0x49d5, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D21
    MOVZ  X18, #0x78d6, LSL #0
    MOVK  X18, #0x6a4, LSL #16
    MOVK  X18, #0x65b, LSL #32
    MOVK  X18, #0xe8db, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X18, #0x54c9, LSL #0
    MOVK  X18, #0x16be, LSL #16
    MOVK  X18, #0x9bb0, LSL #32
    MOVK  X18, #0xcaa1, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D22
    MOVZ  X18, #0x7c17, LSL #0
    MOVK  X18, #0xafed, LSL #16
    MOVK  X18, #0xee95, LSL #32
    MOVK  X18, #0x7f24, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X18, #0x73b1, LSL #0
    MOVK  X18, #0x2d5a, LSL #16
    MOVK  X18, #0x18f3, LSL #32
    MOVK  X18, #0x73ea, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D23
    MOVZ  X18, #0xbcc, LSL #0
    MOVK  X18, #0xb76b, LSL #16
    MOVK  X18, #0xe0e1, LSL #32
    MOVK  X18, #0x51a6, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X18, #0xcff8, LSL #0
    MOVK  X18, #0x5a59, LSL #16
    MOVK  X18, #0x2da9, LSL #32
    MOVK  X18, #0xf867, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D24
    MOVZ  X18, #0x1b97, LSL #0
    MOVK  X18, #0x9215, LSL #16
    MOVK  X18, #0x4fd8, LSL #32
    MOVK  X18, #0xf7d8, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X18, #0x7753, LSL #0
    MOVK  X18, #0xe759, LSL #16
    MOVK  X18, #0x5a1b, LSL #32
    MOVK  X18, #0x13db, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D25
    MOVZ  X18, #0x4ead, LSL #0
    MOVK  X18, #0x9782, LSL #16
    MOVK  X18, #0x1e04, LSL #32
    MOVK  X18, #0x7ba4, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X18, #0x80b7, LSL #0
    MOVK  X18, #0xdc5f, LSL #16
    MOVK  X18, #0xeeb0, LSL #32
    MOVK  X18, #0x83dc, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D26
    MOVZ  X18, #0x6965, LSL #0
    MOVK  X18, #0xb862, LSL #16
    MOVK  X18, #0x850e, LSL #32
    MOVK  X18, #0xa38e, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X18, #0xb67d, LSL #0
    MOVK  X18, #0xb68f, LSL #16
    MOVK  X18, #0x7e69, LSL #32
    MOVK  X18, #0x6c29, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D27
    MOVZ  X18, #0x5a35, LSL #0
    MOVK  X18, #0xdd77, LSL #16
    MOVK  X18, #0x9ce9, LSL #32
    MOVK  X18, #0x9cb0, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X18, #0x558e, LSL #0
    MOVK  X18, #0xb09d, LSL #16
    MOVK  X18, #0x8479, LSL #32
    MOVK  X18, #0x1ef1, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D28
    MOVZ  X18, #0x756b, LSL #0
    MOVK  X18, #0xa5f0, LSL #16
    MOVK  X18, #0xe680, LSL #32
    MOVK  X18, #0x3660, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X18, #0xb736, LSL #0
    MOVK  X18, #0xd87e, LSL #16
    MOVK  X18, #0x3d00, LSL #32
    MOVK  X18, #0x2cd5, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D29
    MOVZ  X18, #0xa8fc, LSL #0
    MOVK  X18, #0xb588, LSL #16
    MOVK  X18, #0xb3dc, LSL #32
    MOVK  X18, #0xe91, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X18, #0x4ed9, LSL #0
    MOVK  X18, #0x7d0c, LSL #16
    MOVK  X18, #0xeae, LSL #32
    MOVK  X18, #0x6b76, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D30
    MOVZ  X18, #0xebba, LSL #0
    MOVK  X18, #0x91eb, LSL #16
    MOVK  X18, #0x8d44, LSL #32
    MOVK  X18, #0x25f6, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X18, #0x1f3e, LSL #0
    MOVK  X18, #0x1ee2, LSL #16
    MOVK  X18, #0x55b3, LSL #32
    MOVK  X18, #0x50dc, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X2, D31
    MOVZ  X18, #0x14ae, LSL #0
    MOVK  X18, #0x32ab, LSL #16
    MOVK  X18, #0xb67c, LSL #32
    MOVK  X18, #0x732d, LSL #48
    SUB  X19, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X19
    FMOV  D1, X22
    FMOV  V1.D[1], X28
    FMOV  D2, X22
    FMOV  V2.D[1], X18
    FMOV  D3, X23
    FMOV  V3.D[1], X7
    FMOV  D4, X3
    FMOV  V4.D[1], X6
    FMOV  D5, X5
    FMOV  V5.D[1], X5
    FMOV  D6, X13
    FMOV  V6.D[1], X5
    FMOV  D7, X15
    FMOV  V7.D[1], X19
    FMOV  D8, X12
    FMOV  V8.D[1], X18
    FMOV  D9, X3
    FMOV  V9.D[1], X4
    FMOV  D10, X12
    FMOV  V10.D[1], X9
    FMOV  D11, X16
    FMOV  V11.D[1], X6
    FMOV  D12, X12
    FMOV  V12.D[1], X14
    FMOV  D13, X20
    FMOV  V13.D[1], X18
    FMOV  D14, X4
    FMOV  V14.D[1], X7
    FMOV  D15, X3
    FMOV  V15.D[1], X28
    FMOV  D16, X3
    FMOV  V16.D[1], X28
    FMOV  D17, X22
    FMOV  V17.D[1], X28
    FMOV  D18, X28
    FMOV  V18.D[1], X17
    FMOV  D19, X10
    FMOV  V19.D[1], X17
    FMOV  D20, X2
    FMOV  V20.D[1], X2
    FMOV  D21, X21
    FMOV  V21.D[1], X18
    FMOV  D22, X18
    FMOV  V22.D[1], X13
    FMOV  D23, X22
    FMOV  V23.D[1], X22
    FMOV  D24, X5
    FMOV  V24.D[1], X21
    FMOV  D25, X21
    FMOV  V25.D[1], X23
    FMOV  D26, X19
    FMOV  V26.D[1], X14
    FMOV  D27, X8
    FMOV  V27.D[1], X12
    FMOV  D28, X12
    FMOV  V28.D[1], X18
    FMOV  D29, X11
    FMOV  V29.D[1], X16
    FMOV  D30, X16
    FMOV  V30.D[1], X28
    FMOV  D31, X6
    FMOV  V31.D[1], X18
    MOVZ  X22, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_12:
    SM3TT1A V23.4S, V16.4S, V30.S[0x3]
    SHA512H2 Q23, Q31, V31.2D
    SM3TT1A V13.4S, V3.4S, V15.S[0x1]
    EOR3 V7.16B, V25.16B, V28.16B, V26.16B
    SM3TT2A V14.4S, V13.4S, V29.S[0x1]
    SHA512SU1 V22.2D, V27.2D, V7.2D
    SHA512SU0 V1.2D, V2.2D
    SM3PARTW1 V14.4S, V23.4S, V23.4S
    SHA512SU1 V27.2D, V1.2D, V24.2D
    SM3PARTW1 V21.4S, V24.4S, V22.4S
    SM3PARTW1 V19.4S, V14.4S, V21.4S
    SM4E V7.4S, V23.4S
    XAR V21.2D, V28.2D, V12.2D, #0x3e
    SHA512SU1 V13.2D, V27.2D, V24.2D
    SM4EKEY V27.4S, V31.4S, V24.4S
    SM3TT1B V25.4S, V30.4S, V1.S[0x2]
    SM3SS1 V20.4S, V11.4S, V7.4S, V14.4S
    SM3PARTW2 V16.4S, V26.4S, V8.4S
    SM4E V29.4S, V4.4S
    SM3TT1A V29.4S, V9.4S, V19.S[0x0]
    SM3PARTW1 V24.4S, V18.4S, V23.4S
    RAX1 V26.2D, V26.2D, V19.2D
    RAX1 V10.2D, V29.2D, V24.2D
    SM3PARTW2 V8.4S, V13.4S, V16.4S
    SM4EKEY V4.4S, V10.4S, V5.4S
    SM4E V5.4S, V8.4S
    SM3TT1A V30.4S, V9.4S, V20.S[0x0]
    SM4E V9.4S, V12.4S
    SM4E V7.4S, V9.4S
    EOR3 V13.16B, V25.16B, V8.16B, V25.16B
    SHA512H Q14, Q4, V28.2D
    SM4EKEY V2.4S, V27.4S, V8.4S
    SM3TT2B V23.4S, V26.4S, V26.S[0x2]
    RAX1 V9.2D, V30.2D, V13.2D
    SHA512SU1 V7.2D, V7.2D, V5.2D
    XAR V13.2D, V14.2D, V26.2D, #0x19
    SHA512SU1 V4.2D, V13.2D, V30.2D
    SHA512H2 Q14, Q7, V23.2D
    SM4E V13.4S, V25.4S
    SM3TT2B V12.4S, V21.4S, V21.S[0x3]
    SM3PARTW2 V12.4S, V14.4S, V9.4S
    SM3TT1A V11.4S, V21.4S, V12.S[0x1]
    EOR3 V9.16B, V13.16B, V11.16B, V11.16B
    XAR V8.2D, V4.2D, V9.2D, #0x3c
    SM3TT2A V12.4S, V17.4S, V11.S[0x1]
    SM4E V3.4S, V2.4S
    RAX1 V27.2D, V30.2D, V16.2D
    SM3TT1B V16.4S, V14.4S, V18.S[0x1]
    SM4EKEY V4.4S, V7.4S, V28.4S
    XAR V9.2D, V22.2D, V28.2D, #0x17
    SM3SS1 V23.4S, V28.4S, V2.4S, V10.4S
    SM4E V28.4S, V21.4S
    EOR3 V13.16B, V9.16B, V12.16B, V27.16B
    SM3PARTW1 V12.4S, V17.4S, V4.4S
    SM4E V18.4S, V22.4S
    SHA512SU1 V20.2D, V5.2D, V8.2D
    SM4E V7.4S, V12.4S
    SM3TT2A V12.4S, V11.4S, V14.S[0x0]
    SHA512H Q2, Q13, V20.2D
    SHA512H Q21, Q18, V3.2D
    RAX1 V17.2D, V16.2D, V13.2D
    XAR V9.2D, V21.2D, V5.2D, #0x3c
    SHA512H2 Q18, Q5, V17.2D
    EOR3 V11.16B, V7.16B, V12.16B, V18.16B
    EOR3 V4.16B, V5.16B, V28.16B, V23.16B
    SM4EKEY V23.4S, V2.4S, V4.4S
    SM3SS1 V5.4S, V11.4S, V3.4S, V9.4S
    EOR3 V14.16B, V23.16B, V11.16B, V11.16B
    SHA512H2 Q2, Q13, V28.2D
    SM3SS1 V30.4S, V16.4S, V15.4S, V6.4S
    SHA512H2 Q4, Q26, V22.2D
    SM3PARTW2 V6.4S, V7.4S, V3.4S
    SHA512H Q10, Q20, V12.2D
    SHA512SU1 V18.2D, V10.2D, V18.2D
    SHA512SU1 V12.2D, V29.2D, V10.2D
    BCAX V10.16B, V23.16B, V30.16B, V5.16B
    SM4EKEY V7.4S, V18.4S, V26.4S
    SM4EKEY V11.4S, V7.4S, V8.4S
    SM4E V9.4S, V19.4S
    SHA512SU0 V8.2D, V20.2D
    SHA512H2 Q18, Q4, V11.2D
    SHA512H Q7, Q6, V9.2D
    SM3SS1 V22.4S, V2.4S, V18.4S, V9.4S
    SM4EKEY V6.4S, V27.4S, V17.4S
    SM4EKEY V27.4S, V8.4S, V31.4S
    SM4E V18.4S, V14.4S
    SM4E V3.4S, V10.4S
    SHA512SU1 V29.2D, V5.2D, V21.2D
    SM3SS1 V19.4S, V2.4S, V27.4S, V3.4S
    SM3TT1B V14.4S, V13.4S, V5.S[0x2]
    SHA512H Q25, Q14, V13.2D
    RAX1 V30.2D, V6.2D, V25.2D
    BCAX V26.16B, V9.16B, V7.16B, V0.16B
    EOR3 V15.16B, V12.16B, V29.16B, V17.16B
    SM3SS1 V12.4S, V24.4S, V18.4S, V23.4S
    SHA512H2 Q14, Q30, V22.2D
    SM3TT1A V8.4S, V21.4S, V19.S[0x1]
    SM3PARTW1 V31.4S, V10.4S, V12.4S
    EOR3 V5.16B, V20.16B, V23.16B, V8.16B
    SHA512SU0 V24.2D, V5.2D
    SM3TT2B V19.4S, V31.4S, V24.S[0x3]
    SM3PARTW1 V19.4S, V26.4S, V14.4S
    SM3TT1A V24.4S, V22.4S, V4.S[0x3]
    SHA512SU1 V23.2D, V29.2D, V12.2D
    SHA512H2 Q9, Q9, V27.2D
    BCAX V10.16B, V16.16B, V1.16B, V31.16B
    SM4E V18.4S, V12.4S
    SM3TT2B V6.4S, V25.4S, V13.S[0x3]
    SM3PARTW1 V22.4S, V0.4S, V9.4S
    SM4E V27.4S, V15.4S
    SM4E V12.4S, V28.4S
    EOR3 V16.16B, V10.16B, V23.16B, V31.16B
    XAR V30.2D, V19.2D, V27.2D, #0x33
    SHA512H2 Q10, Q30, V16.2D
    SM4E V21.4S, V4.4S
    SM4EKEY V19.4S, V8.4S, V20.4S
    SM4EKEY V17.4S, V6.4S, V10.4S
    SM3TT2B V26.4S, V26.4S, V30.S[0x1]
    SHA512H Q5, Q18, V19.2D
    SHA512H Q19, Q28, V12.2D
    SM3TT1A V16.4S, V17.4S, V5.S[0x2]
    BCAX V18.16B, V22.16B, V17.16B, V1.16B
    BCAX V8.16B, V16.16B, V18.16B, V19.16B
    BCAX V22.16B, V28.16B, V28.16B, V8.16B
    SM4E V13.4S, V11.4S
    SHA512SU1 V4.2D, V22.2D, V13.2D
    SM4E V2.4S, V6.4S
    SM3TT2A V14.4S, V16.4S, V21.S[0x2]
    XAR V23.2D, V27.2D, V2.2D, #0x1a
    SM3PARTW1 V13.4S, V14.4S, V15.4S
    SM3TT1A V16.4S, V23.4S, V23.S[0x2]
    SM4E V22.4S, V26.4S
    SM4E V0.4S, V22.4S
    SHA512H2 Q12, Q17, V30.2D
    XAR V9.2D, V4.2D, V16.2D, #0x11
    BCAX V30.16B, V6.16B, V9.16B, V12.16B
    XAR V5.2D, V0.2D, V30.2D, #0x36
    RAX1 V31.2D, V25.2D, V4.2D
    SM3SS1 V18.4S, V11.4S, V14.4S, V26.4S
    SM3TT1A V25.4S, V21.4S, V14.S[0x1]
    SM4E V21.4S, V16.4S
    SM3TT1B V2.4S, V19.4S, V14.S[0x2]
    SHA512H2 Q23, Q21, V12.2D
    SM3PARTW2 V28.4S, V11.4S, V14.4S
    SM4EKEY V4.4S, V17.4S, V9.4S
    SM4EKEY V19.4S, V2.4S, V23.4S
    BCAX V0.16B, V29.16B, V13.16B, V0.16B
    SM3TT1B V15.4S, V23.4S, V28.S[0x2]
    SM3TT1A V22.4S, V19.4S, V31.S[0x2]
    SM4E V11.4S, V4.4S
    XAR V31.2D, V15.2D, V22.2D, #0x10
    SM3TT2A V6.4S, V18.4S, V8.S[0x3]
    SM4EKEY V9.4S, V31.4S, V6.4S
    EOR3 V17.16B, V11.16B, V26.16B, V11.16B
    SM4EKEY V8.4S, V5.4S, V9.4S
    SM4E V16.4S, V17.4S
    SM3TT1B V17.4S, V2.4S, V16.S[0x3]
    SHA512SU0 V11.2D, V0.2D
    BCAX V21.16B, V25.16B, V17.16B, V18.16B
    RAX1 V9.2D, V16.2D, V15.2D
    SM4E V22.4S, V5.4S
    SM3TT1B V0.4S, V11.4S, V4.S[0x1]
    SHA512H Q23, Q22, V22.2D
    SM3PARTW2 V22.4S, V0.4S, V0.4S
    SHA512H2 Q12, Q8, V8.2D
    EOR3 V8.16B, V9.16B, V22.16B, V9.16B
    SHA512H2 Q2, Q23, V31.2D
    SM4EKEY V25.4S, V21.4S, V8.4S
    SM3PARTW2 V16.4S, V12.4S, V3.4S
    SM4E V3.4S, V2.4S
    SHA512SU1 V23.2D, V3.2D, V16.2D
    SM4E V7.4S, V23.4S
    RAX1 V23.2D, V8.2D, V30.2D
    SM3TT2B V30.4S, V18.4S, V0.S[0x2]
    SM4E V1.4S, V28.4S
    SM3TT2B V23.4S, V29.4S, V23.S[0x3]
    SM4E V21.4S, V10.4S
    EOR3 V9.16B, V24.16B, V8.16B, V2.16B
    XAR V12.2D, V11.2D, V2.2D, #0x2e
    SHA512SU0 V31.2D, V16.2D
    BCAX V17.16B, V21.16B, V1.16B, V9.16B
    BCAX V9.16B, V7.16B, V20.16B, V12.16B
    SM4E V29.4S, V23.4S
    SM4EKEY V17.4S, V30.4S, V31.4S
    SHA512H2 Q8, Q17, V6.2D
    XAR V4.2D, V25.2D, V29.2D, #0x25
    SHA512H2 Q21, Q13, V24.2D
    SM4EKEY V17.4S, V4.4S, V9.4S
    SM4E V10.4S, V0.4S
    SHA512H2 Q1, Q8, V10.2D
    SHA512H Q25, Q3, V1.2D
    RAX1 V23.2D, V18.2D, V21.2D
    RAX1 V28.2D, V17.2D, V0.2D
    SM4E V29.4S, V23.4S
    SHA512H Q13, Q13, V4.2D
    SHA512H Q21, Q25, V28.2D
    SHA512SU0 V23.2D, V13.2D
    SM3TT1B V6.4S, V20.4S, V21.S[0x0]
    SM3PARTW2 V4.4S, V29.4S, V20.4S
    SHA512H Q13, Q12, V5.2D
    SUBS  X22, X22, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_12
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0x0, LSL #0
    SUB  X12, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X4, #0xffff, LSL #0
    MOVK  X4, #0xffff, LSL #16
    MOVK  X4, #0xffff, LSL #32
    MOVK  X4, #0xffff, LSL #48
    SUB  X12, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X4, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X12, #0x2e04, LSL #0
    MOVK  X12, #0x6274, LSL #16
    MOVK  X12, #0xbd0e, LSL #32
    MOVK  X12, #0xdebb, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D0
    MOVZ  X12, #0x2052, LSL #0
    MOVK  X12, #0x7421, LSL #16
    MOVK  X12, #0xd742, LSL #32
    MOVK  X12, #0x2e3e, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X12, #0xb030, LSL #0
    MOVK  X12, #0xc5ce, LSL #16
    MOVK  X12, #0x8f89, LSL #32
    MOVK  X12, #0x23b6, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D1
    MOVZ  X12, #0xee6b, LSL #0
    MOVK  X12, #0x951b, LSL #16
    MOVK  X12, #0xe45f, LSL #32
    MOVK  X12, #0xe3c0, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X12, #0x2aca, LSL #0
    MOVK  X12, #0xe1de, LSL #16
    MOVK  X12, #0xaceb, LSL #32
    MOVK  X12, #0xad5c, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D2
    MOVZ  X12, #0x3efc, LSL #0
    MOVK  X12, #0x9592, LSL #16
    MOVK  X12, #0xeb41, LSL #32
    MOVK  X12, #0xade6, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X12, #0x878f, LSL #0
    MOVK  X12, #0x3df8, LSL #16
    MOVK  X12, #0xe248, LSL #32
    MOVK  X12, #0x7a2a, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D3
    MOVZ  X12, #0x2eee, LSL #0
    MOVK  X12, #0x290b, LSL #16
    MOVK  X12, #0x1eb5, LSL #32
    MOVK  X12, #0xb474, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X12, #0xed2e, LSL #0
    MOVK  X12, #0x35b2, LSL #16
    MOVK  X12, #0xecf7, LSL #32
    MOVK  X12, #0x290e, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D4
    MOVZ  X12, #0xa1d2, LSL #0
    MOVK  X12, #0xa6aa, LSL #16
    MOVK  X12, #0xd1bf, LSL #32
    MOVK  X12, #0x945d, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X12, #0x792b, LSL #0
    MOVK  X12, #0xf7cb, LSL #16
    MOVK  X12, #0x1f55, LSL #32
    MOVK  X12, #0xc89b, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D5
    MOVZ  X12, #0x9a33, LSL #0
    MOVK  X12, #0x8725, LSL #16
    MOVK  X12, #0x9ed8, LSL #32
    MOVK  X12, #0x4999, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X12, #0x8ed8, LSL #0
    MOVK  X12, #0x5a87, LSL #16
    MOVK  X12, #0x182d, LSL #32
    MOVK  X12, #0xe496, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D6
    MOVZ  X12, #0xdcc7, LSL #0
    MOVK  X12, #0xa4af, LSL #16
    MOVK  X12, #0xc985, LSL #32
    MOVK  X12, #0x73fe, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X12, #0x3040, LSL #0
    MOVK  X12, #0xb7b0, LSL #16
    MOVK  X12, #0xacff, LSL #32
    MOVK  X12, #0xed4e, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D7
    MOVZ  X12, #0x431b, LSL #0
    MOVK  X12, #0x3330, LSL #16
    MOVK  X12, #0x11, LSL #32
    MOVK  X12, #0xf830, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X12, #0xd705, LSL #0
    MOVK  X12, #0xcb32, LSL #16
    MOVK  X12, #0x8886, LSL #32
    MOVK  X12, #0x81e0, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D8
    MOVZ  X12, #0x50bf, LSL #0
    MOVK  X12, #0xbff2, LSL #16
    MOVK  X12, #0x6f6, LSL #32
    MOVK  X12, #0xff8, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X12, #0x32c8, LSL #0
    MOVK  X12, #0xb7b1, LSL #16
    MOVK  X12, #0xeedc, LSL #32
    MOVK  X12, #0xed52, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D9
    MOVZ  X12, #0x4a92, LSL #0
    MOVK  X12, #0x73b1, LSL #16
    MOVK  X12, #0x8441, LSL #32
    MOVK  X12, #0x7810, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X12, #0x1183, LSL #0
    MOVK  X12, #0x4ee3, LSL #16
    MOVK  X12, #0xde86, LSL #32
    MOVK  X12, #0x70b1, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D10
    MOVZ  X12, #0x5966, LSL #0
    MOVK  X12, #0x898e, LSL #16
    MOVK  X12, #0x9fd, LSL #32
    MOVK  X12, #0xdbc3, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X12, #0x827, LSL #0
    MOVK  X12, #0xccae, LSL #16
    MOVK  X12, #0x4293, LSL #32
    MOVK  X12, #0x9501, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D11
    MOVZ  X12, #0xd1ab, LSL #0
    MOVK  X12, #0x4979, LSL #16
    MOVK  X12, #0xf4b5, LSL #32
    MOVK  X12, #0x90ee, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X12, #0xe177, LSL #0
    MOVK  X12, #0x8bb4, LSL #16
    MOVK  X12, #0xb5c0, LSL #32
    MOVK  X12, #0xb9e0, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D12
    MOVZ  X12, #0xf420, LSL #0
    MOVK  X12, #0xbd5c, LSL #16
    MOVK  X12, #0x73af, LSL #32
    MOVK  X12, #0x7fd3, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X12, #0xbfb1, LSL #0
    MOVK  X12, #0x8bc2, LSL #16
    MOVK  X12, #0xc2fa, LSL #32
    MOVK  X12, #0xb39e, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D13
    MOVZ  X12, #0x925c, LSL #0
    MOVK  X12, #0x63f3, LSL #16
    MOVK  X12, #0x7d18, LSL #32
    MOVK  X12, #0x2dbd, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X12, #0x44c4, LSL #0
    MOVK  X12, #0x9698, LSL #16
    MOVK  X12, #0xb578, LSL #32
    MOVK  X12, #0x5f21, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D14
    MOVZ  X12, #0xbbd2, LSL #0
    MOVK  X12, #0xd190, LSL #16
    MOVK  X12, #0x1b79, LSL #32
    MOVK  X12, #0xb1b3, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X12, #0x42e2, LSL #0
    MOVK  X12, #0x5dce, LSL #16
    MOVK  X12, #0x54a5, LSL #32
    MOVK  X12, #0x803b, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D15
    MOVZ  X12, #0xb00a, LSL #0
    MOVK  X12, #0x9797, LSL #16
    MOVK  X12, #0x6d2d, LSL #32
    MOVK  X12, #0x707b, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X12, #0xd612, LSL #0
    MOVK  X12, #0x1e57, LSL #16
    MOVK  X12, #0xa060, LSL #32
    MOVK  X12, #0x723f, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D16
    MOVZ  X12, #0x79c6, LSL #0
    MOVK  X12, #0x1d29, LSL #16
    MOVK  X12, #0xfcc7, LSL #32
    MOVK  X12, #0xb5df, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X12, #0x53e2, LSL #0
    MOVK  X12, #0x84e4, LSL #16
    MOVK  X12, #0xfc2c, LSL #32
    MOVK  X12, #0xea1c, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D17
    MOVZ  X12, #0xed7e, LSL #0
    MOVK  X12, #0x9f11, LSL #16
    MOVK  X12, #0xb339, LSL #32
    MOVK  X12, #0xe048, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xb457, LSL #32
    MOVK  X12, #0x50ae, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D18
    MOVZ  X12, #0x0, LSL #0
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X12, #0xff2, LSL #0
    MOVK  X12, #0x7a9, LSL #16
    MOVK  X12, #0x1a0c, LSL #32
    MOVK  X12, #0xfd16, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D19
    MOVZ  X12, #0x5f57, LSL #0
    MOVK  X12, #0xd7f0, LSL #16
    MOVK  X12, #0xbb1d, LSL #32
    MOVK  X12, #0x73de, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X12, #0x42de, LSL #0
    MOVK  X12, #0x35, LSL #16
    MOVK  X12, #0x5323, LSL #32
    MOVK  X12, #0xa09c, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D20
    MOVZ  X12, #0x8989, LSL #0
    MOVK  X12, #0xfcd5, LSL #16
    MOVK  X12, #0xd5f8, LSL #32
    MOVK  X12, #0xb161, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X12, #0x2e7d, LSL #0
    MOVK  X12, #0x2481, LSL #16
    MOVK  X12, #0xd886, LSL #32
    MOVK  X12, #0x3370, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D21
    MOVZ  X12, #0x7b97, LSL #0
    MOVK  X12, #0x5a02, LSL #16
    MOVK  X12, #0x359c, LSL #32
    MOVK  X12, #0x7576, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X12, #0x82aa, LSL #0
    MOVK  X12, #0xcfa1, LSL #16
    MOVK  X12, #0xb43, LSL #32
    MOVK  X12, #0x341c, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D22
    MOVZ  X12, #0xee1e, LSL #0
    MOVK  X12, #0x7f4c, LSL #16
    MOVK  X12, #0xd9f8, LSL #32
    MOVK  X12, #0x82d8, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X12, #0x9890, LSL #0
    MOVK  X12, #0xb299, LSL #16
    MOVK  X12, #0xff3a, LSL #32
    MOVK  X12, #0x290c, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D23
    MOVZ  X12, #0xc598, LSL #0
    MOVK  X12, #0xdc2b, LSL #16
    MOVK  X12, #0x6961, LSL #32
    MOVK  X12, #0x8897, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X12, #0x3a9e, LSL #0
    MOVK  X12, #0x40ac, LSL #16
    MOVK  X12, #0x5b6e, LSL #32
    MOVK  X12, #0xeaa3, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D24
    MOVZ  X12, #0xb775, LSL #0
    MOVK  X12, #0x7d55, LSL #16
    MOVK  X12, #0xd1d3, LSL #32
    MOVK  X12, #0xd395, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X12, #0x51c5, LSL #0
    MOVK  X12, #0x4f67, LSL #16
    MOVK  X12, #0x7c1a, LSL #32
    MOVK  X12, #0x9b34, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D25
    MOVZ  X12, #0x9488, LSL #0
    MOVK  X12, #0x9a95, LSL #16
    MOVK  X12, #0x54c9, LSL #32
    MOVK  X12, #0xd566, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X12, #0xace0, LSL #0
    MOVK  X12, #0xa91f, LSL #16
    MOVK  X12, #0x732a, LSL #32
    MOVK  X12, #0xec70, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D26
    MOVZ  X12, #0x991, LSL #0
    MOVK  X12, #0x1760, LSL #16
    MOVK  X12, #0xa0dc, LSL #32
    MOVK  X12, #0xfcb3, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X12, #0xb11d, LSL #0
    MOVK  X12, #0x1501, LSL #16
    MOVK  X12, #0x5ad2, LSL #32
    MOVK  X12, #0x93a4, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D27
    MOVZ  X12, #0xc1f1, LSL #0
    MOVK  X12, #0xa4dc, LSL #16
    MOVK  X12, #0x2f29, LSL #32
    MOVK  X12, #0x6f14, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X12, #0xfeb, LSL #0
    MOVK  X12, #0x400c, LSL #16
    MOVK  X12, #0x8630, LSL #32
    MOVK  X12, #0x576b, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D28
    MOVZ  X12, #0xadda, LSL #0
    MOVK  X12, #0x7753, LSL #16
    MOVK  X12, #0x1dbd, LSL #32
    MOVK  X12, #0xbc35, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X12, #0xd675, LSL #0
    MOVK  X12, #0x442, LSL #16
    MOVK  X12, #0x5706, LSL #32
    MOVK  X12, #0x445a, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D29
    MOVZ  X12, #0xd061, LSL #0
    MOVK  X12, #0x926b, LSL #16
    MOVK  X12, #0xeefb, LSL #32
    MOVK  X12, #0x724, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X12, #0x3f25, LSL #0
    MOVK  X12, #0xc6b9, LSL #16
    MOVK  X12, #0xe51e, LSL #32
    MOVK  X12, #0x4a62, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D30
    MOVZ  X12, #0xe75e, LSL #0
    MOVK  X12, #0xed77, LSL #16
    MOVK  X12, #0x59c7, LSL #32
    MOVK  X12, #0xb4b5, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X12, #0xd97d, LSL #0
    MOVK  X12, #0x190e, LSL #16
    MOVK  X12, #0x4901, LSL #32
    MOVK  X12, #0x8a5a, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X4, D31
    MOVZ  X12, #0xd40d, LSL #0
    MOVK  X12, #0xf61e, LSL #16
    MOVK  X12, #0xa128, LSL #32
    MOVK  X12, #0xf4e5, LSL #48
    SUB  X7, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X16
    FMOV  V0.D[1], X20
    FMOV  D1, X22
    FMOV  V1.D[1], X14
    FMOV  D2, X9
    FMOV  V2.D[1], X21
    FMOV  D3, X21
    FMOV  V3.D[1], X23
    FMOV  D4, X4
    FMOV  V4.D[1], X6
    FMOV  D5, X28
    FMOV  V5.D[1], X19
    FMOV  D6, X10
    FMOV  V6.D[1], X17
    FMOV  D7, X18
    FMOV  V7.D[1], X22
    FMOV  D8, X9
    FMOV  V8.D[1], X11
    FMOV  D9, X10
    FMOV  V9.D[1], X6
    FMOV  D10, X10
    FMOV  V10.D[1], X15
    FMOV  D11, X14
    FMOV  V11.D[1], X23
    FMOV  D12, X21
    FMOV  V12.D[1], X19
    FMOV  D13, X18
    FMOV  V13.D[1], X14
    FMOV  D14, X8
    FMOV  V14.D[1], X7
    FMOV  D15, X11
    FMOV  V15.D[1], X20
    FMOV  D16, X21
    FMOV  V16.D[1], X16
    FMOV  D17, X11
    FMOV  V17.D[1], X23
    FMOV  D18, X2
    FMOV  V18.D[1], X5
    FMOV  D19, X22
    FMOV  V19.D[1], X28
    FMOV  D20, X2
    FMOV  V20.D[1], X12
    FMOV  D21, X6
    FMOV  V21.D[1], X12
    FMOV  D22, X6
    FMOV  V22.D[1], X10
    FMOV  D23, X8
    FMOV  V23.D[1], X2
    FMOV  D24, X19
    FMOV  V24.D[1], X22
    FMOV  D25, X11
    FMOV  V25.D[1], X20
    FMOV  D26, X11
    FMOV  V26.D[1], X7
    FMOV  D27, X8
    FMOV  V27.D[1], X16
    FMOV  D28, X4
    FMOV  V28.D[1], X13
    FMOV  D29, X23
    FMOV  V29.D[1], X15
    FMOV  D30, X10
    FMOV  V30.D[1], X23
    FMOV  D31, X23
    FMOV  V31.D[1], X6
    MOVZ  X15, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_13:
    EOR3 V29.16B, V0.16B, V20.16B, V27.16B
    SM4EKEY V2.4S, V16.4S, V28.4S
    RAX1 V11.2D, V18.2D, V30.2D
    SHA512SU0 V26.2D, V5.2D
    SM3TT1A V29.4S, V11.4S, V0.S[0x1]
    RAX1 V28.2D, V4.2D, V2.2D
    RAX1 V29.2D, V28.2D, V27.2D
    SM4E V27.4S, V13.4S
    SM3PARTW2 V8.4S, V27.4S, V27.4S
    EOR3 V9.16B, V28.16B, V8.16B, V26.16B
    SM4E V3.4S, V15.4S
    SHA512SU0 V2.2D, V3.2D
    RAX1 V10.2D, V2.2D, V16.2D
    SM4EKEY V29.4S, V29.4S, V31.4S
    SHA512H2 Q18, Q10, V17.2D
    RAX1 V4.2D, V9.2D, V9.2D
    SM4E V11.4S, V4.4S
    SM4E V16.4S, V8.4S
    SM4E V26.4S, V5.4S
    SHA512SU1 V31.2D, V11.2D, V18.2D
    SHA512H Q9, Q8, V7.2D
    SHA512H2 Q4, Q2, V6.2D
    SHA512H2 Q7, Q9, V9.2D
    SHA512H Q9, Q28, V7.2D
    SHA512H2 Q7, Q31, V31.2D
    SHA512H Q13, Q27, V7.2D
    SM3SS1 V6.4S, V17.4S, V4.4S, V9.4S
    EOR3 V10.16B, V26.16B, V29.16B, V16.16B
    SM4E V26.4S, V8.4S
    XAR V3.2D, V26.2D, V10.2D, #0xb
    SM4E V28.4S, V6.4S
    SHA512H2 Q8, Q13, V3.2D
    SM4E V31.4S, V16.4S
    SM4EKEY V2.4S, V24.4S, V8.4S
    SM4EKEY V15.4S, V22.4S, V11.4S
    RAX1 V24.2D, V1.2D, V0.2D
    RAX1 V18.2D, V11.2D, V8.2D
    SM3TT2A V28.4S, V13.4S, V16.S[0x0]
    SM3TT2A V27.4S, V28.4S, V24.S[0x2]
    SM3TT1B V1.4S, V14.4S, V9.S[0x0]
    SHA512SU0 V29.2D, V21.2D
    XAR V0.2D, V8.2D, V31.2D, #0x2a
    SHA512SU1 V31.2D, V28.2D, V30.2D
    XAR V21.2D, V9.2D, V14.2D, #0x25
    SHA512SU1 V10.2D, V1.2D, V27.2D
    RAX1 V28.2D, V21.2D, V2.2D
    SM4EKEY V1.4S, V0.4S, V14.4S
    SHA512SU0 V22.2D, V13.2D
    SHA512H2 Q14, Q15, V22.2D
    SM4E V2.4S, V8.4S
    EOR3 V30.16B, V10.16B, V14.16B, V1.16B
    SM3PARTW1 V1.4S, V18.4S, V29.4S
    EOR3 V16.16B, V20.16B, V28.16B, V2.16B
    EOR3 V15.16B, V19.16B, V1.16B, V31.16B
    EOR3 V29.16B, V30.16B, V15.16B, V16.16B
    RAX1 V18.2D, V28.2D, V24.2D
    SHA512SU0 V22.2D, V28.2D
    SM4EKEY V27.4S, V8.4S, V2.4S
    SM4EKEY V20.4S, V22.4S, V23.4S
    BCAX V28.16B, V22.16B, V28.16B, V21.16B
    SHA512SU0 V26.2D, V26.2D
    SM4EKEY V13.4S, V31.4S, V23.4S
    SM3TT1A V22.4S, V19.4S, V26.S[0x3]
    SM3PARTW2 V19.4S, V29.4S, V12.4S
    EOR3 V24.16B, V0.16B, V5.16B, V5.16B
    EOR3 V9.16B, V11.16B, V31.16B, V4.16B
    SM3TT2B V21.4S, V20.4S, V22.S[0x3]
    SM3TT2B V22.4S, V9.4S, V16.S[0x0]
    SM4EKEY V29.4S, V6.4S, V27.4S
    SM3TT1B V9.4S, V19.4S, V21.S[0x0]
    XAR V16.2D, V24.2D, V28.2D, #0x1e
    SM3TT2A V23.4S, V24.4S, V13.S[0x2]
    XAR V26.2D, V21.2D, V22.2D, #0x9
    SM3TT1A V19.4S, V12.4S, V7.S[0x2]
    SM4E V6.4S, V16.4S
    SM3TT2B V29.4S, V29.4S, V19.S[0x3]
    SM3SS1 V28.4S, V23.4S, V9.4S, V29.4S
    SM4E V20.4S, V28.4S
    SM4E V5.4S, V16.4S
    RAX1 V24.2D, V26.2D, V5.2D
    SM4E V19.4S, V24.4S
    SHA512H Q28, Q19, V20.2D
    SM3TT1B V26.4S, V22.4S, V18.S[0x0]
    SHA512H2 Q21, Q16, V10.2D
    SM3TT1B V19.4S, V26.4S, V1.S[0x0]
    SM4E V11.4S, V3.4S
    SHA512H2 Q22, Q23, V11.2D
    RAX1 V27.2D, V18.2D, V21.2D
    SHA512SU1 V3.2D, V21.2D, V20.2D
    XAR V17.2D, V15.2D, V10.2D, #0xa
    SHA512SU0 V12.2D, V27.2D
    RAX1 V10.2D, V22.2D, V5.2D
    XAR V24.2D, V12.2D, V6.2D, #0xb
    EOR3 V0.16B, V3.16B, V28.16B, V15.16B
    SM4EKEY V22.4S, V0.4S, V12.4S
    SM4EKEY V12.4S, V25.4S, V26.4S
    SM3TT1A V27.4S, V29.4S, V22.S[0x1]
    SHA512H Q23, Q12, V17.2D
    SM4E V6.4S, V6.4S
    SHA512H2 Q25, Q24, V13.2D
    SM4EKEY V16.4S, V6.4S, V23.4S
    RAX1 V5.2D, V28.2D, V27.2D
    SM3TT1B V27.4S, V10.4S, V5.S[0x3]
    SHA512SU0 V7.2D, V27.2D
    SM4EKEY V22.4S, V7.4S, V7.4S
    SM4EKEY V29.4S, V22.4S, V25.4S
    SM3SS1 V13.4S, V3.4S, V29.4S, V16.4S
    SM3TT1A V23.4S, V15.4S, V31.S[0x3]
    EOR3 V0.16B, V10.16B, V1.16B, V26.16B
    SM4E V5.4S, V12.4S
    SM4E V16.4S, V5.4S
    SHA512H Q27, Q20, V12.2D
    SHA512H2 Q1, Q15, V9.2D
    SHA512H Q5, Q29, V17.2D
    EOR3 V9.16B, V15.16B, V21.16B, V21.16B
    SM4E V31.4S, V16.4S
    SM3TT1B V28.4S, V18.4S, V27.S[0x2]
    SHA512SU1 V0.2D, V0.2D, V16.2D
    SHA512SU1 V11.2D, V13.2D, V4.2D
    BCAX V10.16B, V2.16B, V9.16B, V23.16B
    SM4EKEY V29.4S, V28.4S, V5.4S
    SM3SS1 V5.4S, V15.4S, V28.4S, V0.4S
    RAX1 V26.2D, V10.2D, V24.2D
    SHA512SU1 V4.2D, V5.2D, V4.2D
    SHA512H2 Q2, Q23, V19.2D
    XAR V9.2D, V2.2D, V31.2D, #0x39
    SM3TT2B V23.4S, V31.4S, V4.S[0x3]
    SM4EKEY V20.4S, V23.4S, V9.4S
    RAX1 V31.2D, V20.2D, V27.2D
    SM4EKEY V2.4S, V31.4S, V26.4S
    RAX1 V3.2D, V2.2D, V2.2D
    XAR V4.2D, V29.2D, V20.2D, #0x28
    SHA512SU0 V29.2D, V18.2D
    SHA512H2 Q24, Q29, V3.2D
    SM3SS1 V27.4S, V6.4S, V23.4S, V24.4S
    SM3TT2A V5.4S, V13.4S, V11.S[0x0]
    EOR3 V12.16B, V4.16B, V12.16B, V27.16B
    SM3TT1A V10.4S, V5.4S, V5.S[0x0]
    SM3TT1A V4.4S, V12.4S, V26.S[0x3]
    SM3SS1 V27.4S, V10.4S, V10.4S, V10.4S
    SHA512SU1 V0.2D, V9.2D, V22.2D
    RAX1 V15.2D, V27.2D, V25.2D
    SHA512SU1 V20.2D, V15.2D, V8.2D
    SM4E V27.4S, V0.4S
    XAR V6.2D, V1.2D, V5.2D, #0x11
    SHA512H2 Q24, Q15, V4.2D
    RAX1 V3.2D, V17.2D, V14.2D
    SM4E V28.4S, V4.4S
    SHA512SU0 V29.2D, V2.2D
    SM3PARTW1 V26.4S, V29.4S, V22.4S
    XAR V25.2D, V6.2D, V10.2D, #0x18
    XAR V17.2D, V20.2D, V26.2D, #0x2f
    SHA512H2 Q0, Q28, V27.2D
    SM3TT2A V11.4S, V24.4S, V17.S[0x2]
    BCAX V24.16B, V2.16B, V24.16B, V16.16B
    SM4EKEY V28.4S, V25.4S, V24.4S
    BCAX V14.16B, V4.16B, V12.16B, V28.16B
    SM3SS1 V2.4S, V14.4S, V15.4S, V0.4S
    SM4E V6.4S, V11.4S
    SHA512SU0 V1.2D, V6.2D
    SM3TT1B V6.4S, V2.4S, V21.S[0x0]
    XAR V17.2D, V3.2D, V29.2D, #0x3c
    SHA512H Q23, Q16, V24.2D
    SM4EKEY V14.4S, V0.4S, V17.4S
    SM3TT1A V27.4S, V6.4S, V14.S[0x2]
    XAR V6.2D, V20.2D, V16.2D, #0x8
    SHA512H Q31, Q6, V17.2D
    SM4EKEY V20.4S, V11.4S, V27.4S
    SM4E V8.4S, V20.4S
    EOR3 V0.16B, V7.16B, V23.16B, V5.16B
    RAX1 V16.2D, V29.2D, V3.2D
    SM4EKEY V30.4S, V16.4S, V1.4S
    SM4E V25.4S, V30.4S
    SM4E V21.4S, V2.4S
    SM4EKEY V10.4S, V31.4S, V31.4S
    XAR V6.2D, V8.2D, V8.2D, #0x1a
    SM4EKEY V17.4S, V23.4S, V15.4S
    SM3SS1 V7.4S, V17.4S, V22.4S, V31.4S
    SM4E V14.4S, V25.4S
    EOR3 V24.16B, V21.16B, V24.16B, V3.16B
    XAR V14.2D, V29.2D, V0.2D, #0x24
    SM4E V11.4S, V6.4S
    SM3TT1B V16.4S, V16.4S, V24.S[0x1]
    SM3SS1 V30.4S, V10.4S, V11.4S, V11.4S
    SM4E V25.4S, V30.4S
    SM4E V29.4S, V22.4S
    SM3SS1 V12.4S, V25.4S, V7.4S, V29.4S
    RAX1 V11.2D, V9.2D, V12.2D
    SHA512SU1 V10.2D, V3.2D, V14.2D
    SHA512H Q29, Q5, V11.2D
    SM3TT2A V1.4S, V10.4S, V10.S[0x3]
    BCAX V11.16B, V13.16B, V1.16B, V29.16B
    SHA512H Q12, Q13, V11.2D
    SHA512H2 Q25, Q9, V2.2D
    SHA512H2 Q24, Q4, V0.2D
    SM3PARTW2 V23.4S, V15.4S, V14.4S
    SM3TT2A V10.4S, V8.4S, V31.S[0x3]
    RAX1 V30.2D, V29.2D, V4.2D
    RAX1 V7.2D, V27.2D, V24.2D
    EOR3 V6.16B, V25.16B, V0.16B, V1.16B
    SUBS  X15, X15, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_13
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X20, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X20, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X17, FPSR
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X20, #0x8174, LSL #0
    MOVK  X20, #0xc3fa, LSL #16
    MOVK  X20, #0x9477, LSL #32
    MOVK  X20, #0x971e, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D0
    MOVZ  X20, #0xbde5, LSL #0
    MOVK  X20, #0x47f9, LSL #16
    MOVK  X20, #0x7087, LSL #32
    MOVK  X20, #0x976b, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X20, #0x972e, LSL #0
    MOVK  X20, #0x6bc5, LSL #16
    MOVK  X20, #0x6575, LSL #32
    MOVK  X20, #0x24a7, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D1
    MOVZ  X20, #0x778a, LSL #0
    MOVK  X20, #0xf80c, LSL #16
    MOVK  X20, #0x3f6f, LSL #32
    MOVK  X20, #0x8f95, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xa261, LSL #32
    MOVK  X20, #0x302a, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X20, #0x448a, LSL #0
    MOVK  X20, #0x8bb3, LSL #16
    MOVK  X20, #0x1f91, LSL #32
    MOVK  X20, #0xc98e, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D3
    MOVZ  X20, #0xc931, LSL #0
    MOVK  X20, #0x5a33, LSL #16
    MOVK  X20, #0x4d61, LSL #32
    MOVK  X20, #0x61fd, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X20, #0xbcfc, LSL #0
    MOVK  X20, #0xeed1, LSL #16
    MOVK  X20, #0xf20c, LSL #32
    MOVK  X20, #0xbe4c, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D4
    MOVZ  X20, #0xf4a6, LSL #0
    MOVK  X20, #0xd575, LSL #16
    MOVK  X20, #0xe24c, LSL #32
    MOVK  X20, #0x5477, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X20, #0x5008, LSL #0
    MOVK  X20, #0x35d4, LSL #16
    MOVK  X20, #0xa689, LSL #32
    MOVK  X20, #0xcab2, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D5
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X20, #0xbf87, LSL #0
    MOVK  X20, #0x8258, LSL #16
    MOVK  X20, #0xebbf, LSL #32
    MOVK  X20, #0xcdf7, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D6
    MOVZ  X20, #0xe99, LSL #0
    MOVK  X20, #0xcfc5, LSL #16
    MOVK  X20, #0x6efb, LSL #32
    MOVK  X20, #0xc37, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X20, #0xe9ed, LSL #0
    MOVK  X20, #0x568f, LSL #16
    MOVK  X20, #0x481b, LSL #32
    MOVK  X20, #0x1e34, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D7
    MOVZ  X20, #0x2106, LSL #0
    MOVK  X20, #0xae84, LSL #16
    MOVK  X20, #0xd815, LSL #32
    MOVK  X20, #0x5f85, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X20, #0x64d6, LSL #0
    MOVK  X20, #0x82b1, LSL #16
    MOVK  X20, #0x1256, LSL #32
    MOVK  X20, #0x964d, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D8
    MOVZ  X20, #0xdb84, LSL #0
    MOVK  X20, #0xc41f, LSL #16
    MOVK  X20, #0xd7b9, LSL #32
    MOVK  X20, #0x7661, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X20, #0x9e07, LSL #0
    MOVK  X20, #0x956e, LSL #16
    MOVK  X20, #0x7810, LSL #32
    MOVK  X20, #0xba6e, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D9
    MOVZ  X20, #0x6fad, LSL #0
    MOVK  X20, #0xa927, LSL #16
    MOVK  X20, #0x5d00, LSL #32
    MOVK  X20, #0xe6ab, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X20, #0x10e9, LSL #0
    MOVK  X20, #0xff01, LSL #16
    MOVK  X20, #0x2f8e, LSL #32
    MOVK  X20, #0x5d91, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D10
    MOVZ  X20, #0x2cf, LSL #0
    MOVK  X20, #0xdceb, LSL #16
    MOVK  X20, #0x29fc, LSL #32
    MOVK  X20, #0x86ac, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X20, #0x8420, LSL #0
    MOVK  X20, #0x22c4, LSL #16
    MOVK  X20, #0x4a24, LSL #32
    MOVK  X20, #0x756, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D11
    MOVZ  X20, #0x80, LSL #0
    MOVK  X20, #0xe000, LSL #16
    MOVK  X20, #0x108, LSL #32
    MOVK  X20, #0x185, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X20, #0x2886, LSL #0
    MOVK  X20, #0xaa1a, LSL #16
    MOVK  X20, #0x2c4b, LSL #32
    MOVK  X20, #0xcabf, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D12
    MOVZ  X20, #0x28f8, LSL #0
    MOVK  X20, #0x3f61, LSL #16
    MOVK  X20, #0x9719, LSL #32
    MOVK  X20, #0x8863, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x6a00, LSL #32
    MOVK  X20, #0x2773, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D13
    MOVZ  X20, #0x0, LSL #0
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X20, #0x4fb1, LSL #0
    MOVK  X20, #0x8338, LSL #16
    MOVK  X20, #0x40c3, LSL #32
    MOVK  X20, #0xad3d, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D14
    MOVZ  X20, #0xa3f8, LSL #0
    MOVK  X20, #0x62dc, LSL #16
    MOVK  X20, #0xcbda, LSL #32
    MOVK  X20, #0x96b6, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X20, #0x48f1, LSL #0
    MOVK  X20, #0xd96c, LSL #16
    MOVK  X20, #0x932b, LSL #32
    MOVK  X20, #0x656e, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D15
    MOVZ  X20, #0x7ffc, LSL #0
    MOVK  X20, #0x9dfd, LSL #16
    MOVK  X20, #0x696a, LSL #32
    MOVK  X20, #0x450c, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X20, #0x504e, LSL #0
    MOVK  X20, #0x3786, LSL #16
    MOVK  X20, #0x6d00, LSL #32
    MOVK  X20, #0xff52, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D16
    MOVZ  X20, #0xd5cc, LSL #0
    MOVK  X20, #0x795b, LSL #16
    MOVK  X20, #0xb20e, LSL #32
    MOVK  X20, #0x9008, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X20, #0xbe81, LSL #0
    MOVK  X20, #0x2274, LSL #16
    MOVK  X20, #0xbd1d, LSL #32
    MOVK  X20, #0x8cc2, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D17
    MOVZ  X20, #0x557d, LSL #0
    MOVK  X20, #0xbbfa, LSL #16
    MOVK  X20, #0xec86, LSL #32
    MOVK  X20, #0xee62, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X20, #0x62c5, LSL #0
    MOVK  X20, #0xc745, LSL #16
    MOVK  X20, #0x5012, LSL #32
    MOVK  X20, #0x19cb, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D18
    MOVZ  X20, #0xb07, LSL #0
    MOVK  X20, #0xb4e3, LSL #16
    MOVK  X20, #0xdefc, LSL #32
    MOVK  X20, #0x7aeb, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X20, #0x7e1c, LSL #0
    MOVK  X20, #0x1045, LSL #16
    MOVK  X20, #0xd73c, LSL #32
    MOVK  X20, #0x5def, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D19
    MOVZ  X20, #0x1b8a, LSL #0
    MOVK  X20, #0x99e0, LSL #16
    MOVK  X20, #0xe1af, LSL #32
    MOVK  X20, #0x845a, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X20, #0xddff, LSL #0
    MOVK  X20, #0xf2fc, LSL #16
    MOVK  X20, #0x977c, LSL #32
    MOVK  X20, #0x2791, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D20
    MOVZ  X20, #0x53e8, LSL #0
    MOVK  X20, #0x89e2, LSL #16
    MOVK  X20, #0x8f98, LSL #32
    MOVK  X20, #0xfc6a, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X20, #0x1d67, LSL #0
    MOVK  X20, #0x53d8, LSL #16
    MOVK  X20, #0xd9b7, LSL #32
    MOVK  X20, #0x49a, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D21
    MOVZ  X20, #0x7099, LSL #0
    MOVK  X20, #0x9b0c, LSL #16
    MOVK  X20, #0x261a, LSL #32
    MOVK  X20, #0x6ec9, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X20, #0xc54d, LSL #0
    MOVK  X20, #0x89f4, LSL #16
    MOVK  X20, #0x9623, LSL #32
    MOVK  X20, #0xd379, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D22
    MOVZ  X20, #0xff7, LSL #0
    MOVK  X20, #0xf754, LSL #16
    MOVK  X20, #0x5df, LSL #32
    MOVK  X20, #0x2ef9, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X20, #0xb712, LSL #0
    MOVK  X20, #0x6505, LSL #16
    MOVK  X20, #0xc8ce, LSL #32
    MOVK  X20, #0xdd0b, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D23
    MOVZ  X20, #0x1a65, LSL #0
    MOVK  X20, #0xd871, LSL #16
    MOVK  X20, #0x2b7e, LSL #32
    MOVK  X20, #0x5ef3, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X20, #0xec42, LSL #0
    MOVK  X20, #0xa3e7, LSL #16
    MOVK  X20, #0x9aea, LSL #32
    MOVK  X20, #0xf9f1, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D24
    MOVZ  X20, #0xe86b, LSL #0
    MOVK  X20, #0x1d29, LSL #16
    MOVK  X20, #0x552d, LSL #32
    MOVK  X20, #0xb7cf, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X20, #0xa9dd, LSL #0
    MOVK  X20, #0x2a67, LSL #16
    MOVK  X20, #0x1abd, LSL #32
    MOVK  X20, #0x7e4e, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D25
    MOVZ  X20, #0xc4f6, LSL #0
    MOVK  X20, #0x7030, LSL #16
    MOVK  X20, #0x2113, LSL #32
    MOVK  X20, #0x14c9, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X20, #0x4d6, LSL #0
    MOVK  X20, #0x4f05, LSL #16
    MOVK  X20, #0x7988, LSL #32
    MOVK  X20, #0x4bf5, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D26
    MOVZ  X20, #0x4754, LSL #0
    MOVK  X20, #0xbe76, LSL #16
    MOVK  X20, #0xe821, LSL #32
    MOVK  X20, #0xbeb0, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X20, #0x3168, LSL #0
    MOVK  X20, #0x1140, LSL #16
    MOVK  X20, #0x7dce, LSL #32
    MOVK  X20, #0xedd7, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D27
    MOVZ  X20, #0xf1d1, LSL #0
    MOVK  X20, #0x94d7, LSL #16
    MOVK  X20, #0x724f, LSL #32
    MOVK  X20, #0x301b, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X20, #0x3642, LSL #0
    MOVK  X20, #0x32e4, LSL #16
    MOVK  X20, #0x2487, LSL #32
    MOVK  X20, #0xaf3b, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D28
    MOVZ  X20, #0xda72, LSL #0
    MOVK  X20, #0x30e8, LSL #16
    MOVK  X20, #0x61a6, LSL #32
    MOVK  X20, #0x5edf, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X20, #0x3b8e, LSL #0
    MOVK  X20, #0xd923, LSL #16
    MOVK  X20, #0xd55b, LSL #32
    MOVK  X20, #0xd4ca, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D29
    MOVZ  X20, #0x7f3f, LSL #0
    MOVK  X20, #0x18df, LSL #16
    MOVK  X20, #0x3ef7, LSL #32
    MOVK  X20, #0xde3a, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X20, #0x4277, LSL #0
    MOVK  X20, #0x480, LSL #16
    MOVK  X20, #0x3142, LSL #32
    MOVK  X20, #0xa853, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D30
    MOVZ  X20, #0x9673, LSL #0
    MOVK  X20, #0xb234, LSL #16
    MOVK  X20, #0xfa6e, LSL #32
    MOVK  X20, #0x76d5, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X20, #0xc982, LSL #0
    MOVK  X20, #0xb617, LSL #16
    MOVK  X20, #0x846c, LSL #32
    MOVK  X20, #0x5468, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X17, D31
    MOVZ  X20, #0x5d3f, LSL #0
    MOVK  X20, #0x2687, LSL #16
    MOVK  X20, #0x4e49, LSL #32
    MOVK  X20, #0xc3c, LSL #48
    SUB  X5, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X11
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X21
    FMOV  D2, X22
    FMOV  V2.D[1], X9
    FMOV  D3, X10
    FMOV  V3.D[1], X13
    FMOV  D4, X11
    FMOV  V4.D[1], X13
    FMOV  D5, X16
    FMOV  V5.D[1], X16
    FMOV  D6, X19
    FMOV  V6.D[1], X5
    FMOV  D7, X9
    FMOV  V7.D[1], X28
    FMOV  D8, X7
    FMOV  V8.D[1], X22
    FMOV  D9, X9
    FMOV  V9.D[1], X4
    FMOV  D10, X16
    FMOV  V10.D[1], X23
    FMOV  D11, X16
    FMOV  V11.D[1], X18
    FMOV  D12, X28
    FMOV  V12.D[1], X14
    FMOV  D13, X28
    FMOV  V13.D[1], X5
    FMOV  D14, X23
    FMOV  V14.D[1], X2
    FMOV  D15, X6
    FMOV  V15.D[1], X14
    FMOV  D16, X3
    FMOV  V16.D[1], X2
    FMOV  D17, X18
    FMOV  V17.D[1], X20
    FMOV  D18, X19
    FMOV  V18.D[1], X17
    FMOV  D19, X5
    FMOV  V19.D[1], X9
    FMOV  D20, X19
    FMOV  V20.D[1], X23
    FMOV  D21, X17
    FMOV  V21.D[1], X6
    FMOV  D22, X13
    FMOV  V22.D[1], X7
    FMOV  D23, X2
    FMOV  V23.D[1], X22
    FMOV  D24, X9
    FMOV  V24.D[1], X8
    FMOV  D25, X6
    FMOV  V25.D[1], X8
    FMOV  D26, X20
    FMOV  V26.D[1], X3
    FMOV  D27, X14
    FMOV  V27.D[1], X10
    FMOV  D28, X13
    FMOV  V28.D[1], X6
    FMOV  D29, X13
    FMOV  V29.D[1], X11
    FMOV  D30, X9
    FMOV  V30.D[1], X28
    FMOV  D31, X19
    FMOV  V31.D[1], X17
    MOVZ  X2, #0xa, LSL #0
LCRTAdvsimdVectorV8p2CryptographicExtension_label_14:
    SHA512H2 Q24, Q17, V23.2D
    SM3TT2B V20.4S, V30.4S, V19.S[0x1]
    RAX1 V4.2D, V29.2D, V1.2D
    SM3PARTW2 V22.4S, V26.4S, V19.4S
    RAX1 V19.2D, V21.2D, V4.2D
    SM3TT1B V27.4S, V25.4S, V27.S[0x1]
    SHA512H Q19, Q31, V31.2D
    SM4EKEY V18.4S, V28.4S, V19.4S
    SM3TT1A V12.4S, V30.4S, V18.S[0x3]
    SM3PARTW2 V25.4S, V17.4S, V12.4S
    SM3TT2B V23.4S, V24.4S, V22.S[0x1]
    SM3PARTW1 V17.4S, V10.4S, V11.4S
    SM3TT1A V24.4S, V25.4S, V27.S[0x1]
    SM3SS1 V22.4S, V7.4S, V23.4S, V7.4S
    SHA512SU1 V27.2D, V9.2D, V20.2D
    SM4EKEY V31.4S, V27.4S, V17.4S
    SHA512SU0 V27.2D, V0.2D
    BCAX V23.16B, V20.16B, V31.16B, V22.16B
    SM4EKEY V12.4S, V27.4S, V24.4S
    XAR V1.2D, V1.2D, V2.2D, #0x4
    SHA512SU1 V4.2D, V27.2D, V15.2D
    SM4EKEY V22.4S, V17.4S, V3.4S
    SM3SS1 V29.4S, V30.4S, V0.4S, V20.4S
    SM3TT2B V18.4S, V29.4S, V17.S[0x0]
    SM3TT1A V0.4S, V19.4S, V5.S[0x2]
    SHA512SU0 V2.2D, V23.2D
    SM4E V9.4S, V24.4S
    SM3TT1B V24.4S, V6.4S, V8.S[0x0]
    SM4E V30.4S, V12.4S
    SM4E V31.4S, V20.4S
    SM3PARTW2 V3.4S, V13.4S, V9.4S
    SM4EKEY V12.4S, V0.4S, V3.4S
    SM3SS1 V16.4S, V22.4S, V4.4S, V10.4S
    SHA512SU0 V21.2D, V30.2D
    RAX1 V15.2D, V31.2D, V1.2D
    BCAX V27.16B, V24.16B, V2.16B, V15.16B
    SM4E V24.4S, V25.4S
    SM3SS1 V10.4S, V8.4S, V12.4S, V18.4S
    SM4EKEY V25.4S, V5.4S, V16.4S
    SM3TT1B V31.4S, V25.4S, V24.S[0x1]
    SM4E V30.4S, V21.4S
    EOR3 V29.16B, V1.16B, V25.16B, V10.16B
    SHA512H Q2, Q14, V29.2D
    SHA512H2 Q4, Q30, V2.2D
    SM4EKEY V14.4S, V31.4S, V29.4S
    RAX1 V15.2D, V27.2D, V30.2D
    SHA512H Q18, Q4, V7.2D
    SHA512SU0 V4.2D, V15.2D
    SM3TT2A V8.4S, V9.4S, V18.S[0x1]
    XAR V7.2D, V4.2D, V5.2D, #0x35
    SM3PARTW2 V21.4S, V8.4S, V7.4S
    SM4E V29.4S, V12.4S
    SM4E V15.4S, V5.4S
    SM4E V5.4S, V19.4S
    SHA512SU1 V1.2D, V31.2D, V14.2D
    BCAX V16.16B, V7.16B, V17.16B, V13.16B
    SM4E V13.4S, V18.4S
    SM4EKEY V27.4S, V16.4S, V10.4S
    SM4EKEY V18.4S, V23.4S, V21.4S
    SHA512SU0 V8.2D, V31.2D
    BCAX V7.16B, V12.16B, V3.16B, V25.16B
    SHA512SU0 V3.2D, V1.2D
    SM3TT2A V23.4S, V11.4S, V13.S[0x0]
    SHA512SU1 V1.2D, V5.2D, V5.2D
    SHA512H2 Q9, Q12, V2.2D
    SHA512H2 Q17, Q31, V15.2D
    SHA512SU1 V19.2D, V27.2D, V8.2D
    SM4EKEY V11.4S, V9.4S, V17.4S
    EOR3 V30.16B, V11.16B, V29.16B, V3.16B
    SM3TT2A V9.4S, V30.4S, V29.S[0x1]
    SM4E V14.4S, V19.4S
    SHA512SU1 V31.2D, V9.2D, V23.2D
    SM3TT2A V21.4S, V4.4S, V18.S[0x0]
    SM4EKEY V17.4S, V31.4S, V21.4S
    SM4E V25.4S, V25.4S
    SM4EKEY V11.4S, V16.4S, V3.4S
    EOR3 V15.16B, V17.16B, V7.16B, V14.16B
    SHA512H2 Q0, Q19, V11.2D
    SHA512SU0 V16.2D, V20.2D
    SHA512SU1 V25.2D, V27.2D, V15.2D
    BCAX V3.16B, V16.16B, V1.16B, V16.16B
    SHA512H2 Q8, Q0, V29.2D
    SM4E V11.4S, V8.4S
    EOR3 V21.16B, V3.16B, V2.16B, V12.16B
    SM4EKEY V18.4S, V11.4S, V17.4S
    RAX1 V6.2D, V21.2D, V26.2D
    SHA512H2 Q15, Q25, V25.2D
    SM4E V2.4S, V6.4S
    SM3SS1 V0.4S, V15.4S, V12.4S, V5.4S
    XAR V7.2D, V1.2D, V20.2D, #0x24
    SHA512H2 Q4, Q23, V18.2D
    SHA512SU0 V14.2D, V28.2D
    SHA512H Q28, Q20, V7.2D
    SHA512SU1 V28.2D, V13.2D, V10.2D
    SHA512H Q16, Q0, V2.2D
    RAX1 V20.2D, V14.2D, V16.2D
    SHA512SU1 V26.2D, V4.2D, V30.2D
    SM4E V27.4S, V3.4S
    SM3PARTW1 V31.4S, V28.4S, V27.4S
    SHA512SU1 V5.2D, V26.2D, V12.2D
    SM4EKEY V16.4S, V16.4S, V14.4S
    SM3PARTW2 V14.4S, V2.4S, V20.4S
    SM3TT1A V1.4S, V16.4S, V11.S[0x2]
    SM4E V10.4S, V1.4S
    XAR V19.2D, V14.2D, V31.2D, #0x4
    SM4EKEY V30.4S, V5.4S, V19.4S
    SM4E V4.4S, V11.4S
    RAX1 V6.2D, V14.2D, V24.2D
    RAX1 V14.2D, V2.2D, V9.2D
    SHA512SU1 V11.2D, V9.2D, V7.2D
    RAX1 V18.2D, V26.2D, V23.2D
    SHA512SU1 V30.2D, V7.2D, V9.2D
    BCAX V16.16B, V26.16B, V17.16B, V28.16B
    EOR3 V7.16B, V2.16B, V18.16B, V10.16B
    SHA512H2 Q0, Q3, V5.2D
    RAX1 V31.2D, V12.2D, V2.2D
    EOR3 V25.16B, V12.16B, V1.16B, V16.16B
    RAX1 V21.2D, V20.2D, V7.2D
    EOR3 V10.16B, V10.16B, V10.16B, V4.16B
    SM4E V17.4S, V14.4S
    SM4EKEY V9.4S, V28.4S, V10.4S
    SM3TT1B V2.4S, V25.4S, V6.S[0x0]
    XAR V26.2D, V9.2D, V2.2D, #0x8
    SM3SS1 V20.4S, V31.4S, V30.4S, V11.4S
    RAX1 V9.2D, V21.2D, V19.2D
    RAX1 V14.2D, V31.2D, V26.2D
    BCAX V23.16B, V16.16B, V20.16B, V17.16B
    SM3PARTW1 V11.4S, V14.4S, V4.4S
    SHA512SU1 V25.2D, V0.2D, V9.2D
    XAR V26.2D, V11.2D, V11.2D, #0x1f
    SHA512SU0 V14.2D, V26.2D
    SM3SS1 V2.4S, V31.4S, V8.4S, V26.4S
    SM3TT2B V1.4S, V28.4S, V2.S[0x3]
    SM4EKEY V2.4S, V1.4S, V25.4S
    SHA512H2 Q31, Q18, V23.2D
    SHA512SU0 V21.2D, V24.2D
    SM3TT1A V0.4S, V31.4S, V14.S[0x3]
    SM4EKEY V18.4S, V2.4S, V3.4S
    SM3TT2A V6.4S, V21.4S, V18.S[0x0]
    SM3PARTW1 V20.4S, V7.4S, V25.4S
    SM4EKEY V15.4S, V10.4S, V24.4S
    BCAX V14.16B, V13.16B, V0.16B, V29.16B
    SHA512SU1 V30.2D, V30.2D, V8.2D
    XAR V3.2D, V8.2D, V2.2D, #0x39
    SM4E V24.4S, V22.4S
    SHA512H Q2, Q24, V27.2D
    SM3TT1B V27.4S, V1.4S, V12.S[0x2]
    SHA512SU1 V31.2D, V17.2D, V21.2D
    XAR V18.2D, V6.2D, V27.2D, #0x2a
    XAR V0.2D, V14.2D, V30.2D, #0x23
    SM3TT2A V14.4S, V14.4S, V0.S[0x3]
    SM3PARTW1 V22.4S, V25.4S, V3.4S
    SHA512SU0 V7.2D, V17.2D
    SM3TT1A V30.4S, V31.4S, V28.S[0x3]
    SM4EKEY V25.4S, V22.4S, V30.4S
    SM3PARTW2 V17.4S, V23.4S, V7.4S
    XAR V28.2D, V2.2D, V14.2D, #0xc
    SM4EKEY V21.4S, V2.4S, V18.4S
    SM3PARTW2 V8.4S, V21.4S, V6.4S
    SM3TT2B V1.4S, V27.4S, V15.S[0x0]
    XAR V24.2D, V16.2D, V8.2D, #0x9
    SHA512SU0 V14.2D, V19.2D
    SM4E V10.4S, V23.4S
    SM3SS1 V22.4S, V28.4S, V21.4S, V25.4S
    SM4E V15.4S, V20.4S
    SHA512SU0 V13.2D, V22.2D
    SHA512H Q7, Q24, V17.2D
    SHA512SU0 V20.2D, V6.2D
    SM3PARTW2 V23.4S, V13.4S, V15.4S
    SM4EKEY V15.4S, V1.4S, V23.4S
    SHA512SU0 V16.2D, V15.2D
    XAR V6.2D, V14.2D, V11.2D, #0x2d
    SM3PARTW2 V23.4S, V16.4S, V6.4S
    BCAX V14.16B, V23.16B, V10.16B, V7.16B
    RAX1 V11.2D, V30.2D, V25.2D
    RAX1 V16.2D, V6.2D, V2.2D
    SHA512SU0 V8.2D, V0.2D
    SHA512SU1 V30.2D, V22.2D, V1.2D
    RAX1 V9.2D, V15.2D, V18.2D
    SHA512H2 Q27, Q5, V27.2D
    SM4EKEY V24.4S, V3.4S, V15.4S
    SM4E V18.4S, V9.4S
    XAR V28.2D, V11.2D, V10.2D, #0x2
    SM3SS1 V2.4S, V24.4S, V30.4S, V8.4S
    SM3PARTW2 V19.4S, V2.4S, V0.4S
    BCAX V22.16B, V27.16B, V18.16B, V3.16B
    SM4EKEY V5.4S, V31.4S, V10.4S
    EOR3 V13.16B, V14.16B, V19.16B, V5.16B
    SM3PARTW2 V23.4S, V16.4S, V24.4S
    SHA512H Q14, Q27, V23.2D
    BCAX V17.16B, V13.16B, V22.16B, V19.16B
    BCAX V15.16B, V1.16B, V17.16B, V3.16B
    SM4E V27.4S, V15.4S
    SM3TT2A V17.4S, V27.4S, V28.S[0x0]
    SM3TT1B V7.4S, V6.4S, V17.S[0x2]
    SM4E V8.4S, V7.4S
    SM4EKEY V7.4S, V12.4S, V14.4S
    SHA512SU1 V18.2D, V8.2D, V21.2D
    SM4EKEY V19.4S, V7.4S, V18.4S
    SHA512H Q22, Q21, V18.2D
    SUBS  X2, X2, #0x1
    B.NE  LCRTAdvsimdVectorV8p2CryptographicExtension_label_14
    MOVZ  X5, #0x0, LSL #0
    SUB  X17, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X17, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    MRS  X5, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X17, #0x4976, LSL #0
    MOVK  X17, #0xa09d, LSL #16
    MOVK  X17, #0x91c1, LSL #32
    MOVK  X17, #0xac5f, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D0
    MOVZ  X17, #0x6f65, LSL #0
    MOVK  X17, #0xf891, LSL #16
    MOVK  X17, #0x88c4, LSL #32
    MOVK  X17, #0xfee, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X17, #0x26dd, LSL #0
    MOVK  X17, #0xd8ee, LSL #16
    MOVK  X17, #0x444c, LSL #32
    MOVK  X17, #0x2b5b, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D1
    MOVZ  X17, #0x122d, LSL #0
    MOVK  X17, #0xc727, LSL #16
    MOVK  X17, #0x9620, LSL #32
    MOVK  X17, #0xb2b4, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5023, LSL #32
    MOVK  X17, #0xcbd2, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D2
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X17, #0x140d, LSL #0
    MOVK  X17, #0x7e0b, LSL #16
    MOVK  X17, #0xcde3, LSL #32
    MOVK  X17, #0xd75b, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D3
    MOVZ  X17, #0xe08e, LSL #0
    MOVK  X17, #0xf03f, LSL #16
    MOVK  X17, #0x94e6, LSL #32
    MOVK  X17, #0xd9de, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X17, #0x6acf, LSL #0
    MOVK  X17, #0x59e2, LSL #16
    MOVK  X17, #0x5172, LSL #32
    MOVK  X17, #0x6e94, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D4
    MOVZ  X17, #0x64b4, LSL #0
    MOVK  X17, #0xaad3, LSL #16
    MOVK  X17, #0xe60, LSL #32
    MOVK  X17, #0xf8a7, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X17, #0xe583, LSL #0
    MOVK  X17, #0xee08, LSL #16
    MOVK  X17, #0xe31f, LSL #32
    MOVK  X17, #0xd9bb, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D5
    MOVZ  X17, #0x2a79, LSL #0
    MOVK  X17, #0x806a, LSL #16
    MOVK  X17, #0x3c30, LSL #32
    MOVK  X17, #0x735f, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X17, #0xe0f0, LSL #0
    MOVK  X17, #0xfe4f, LSL #16
    MOVK  X17, #0x82a4, LSL #32
    MOVK  X17, #0xa21f, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D6
    MOVZ  X17, #0xdf5d, LSL #0
    MOVK  X17, #0x9582, LSL #16
    MOVK  X17, #0xe221, LSL #32
    MOVK  X17, #0xfb2, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X17, #0xbdf9, LSL #0
    MOVK  X17, #0x7dbf, LSL #16
    MOVK  X17, #0xb732, LSL #32
    MOVK  X17, #0x8fb, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D7
    MOVZ  X17, #0x5914, LSL #0
    MOVK  X17, #0x5aaf, LSL #16
    MOVK  X17, #0x16fb, LSL #32
    MOVK  X17, #0x267f, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X17, #0xa12c, LSL #0
    MOVK  X17, #0xa986, LSL #16
    MOVK  X17, #0x3693, LSL #32
    MOVK  X17, #0x3458, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D8
    MOVZ  X17, #0x5734, LSL #0
    MOVK  X17, #0x4ad0, LSL #16
    MOVK  X17, #0x2d21, LSL #32
    MOVK  X17, #0x87a, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X17, #0x9cde, LSL #0
    MOVK  X17, #0xea40, LSL #16
    MOVK  X17, #0xc2d1, LSL #32
    MOVK  X17, #0xf6, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D9
    MOVZ  X17, #0xb6b1, LSL #0
    MOVK  X17, #0x827a, LSL #16
    MOVK  X17, #0xf04b, LSL #32
    MOVK  X17, #0x8344, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X17, #0x8bf1, LSL #0
    MOVK  X17, #0x6511, LSL #16
    MOVK  X17, #0x1122, LSL #32
    MOVK  X17, #0x49eb, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D10
    MOVZ  X17, #0xacc9, LSL #0
    MOVK  X17, #0x95b1, LSL #16
    MOVK  X17, #0x914c, LSL #32
    MOVK  X17, #0x76d9, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X17, #0xc141, LSL #0
    MOVK  X17, #0xca62, LSL #16
    MOVK  X17, #0xfb6, LSL #32
    MOVK  X17, #0x7bfb, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D11
    MOVZ  X17, #0x1c5a, LSL #0
    MOVK  X17, #0xc035, LSL #16
    MOVK  X17, #0x8a57, LSL #32
    MOVK  X17, #0x693a, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X17, #0xd9e8, LSL #0
    MOVK  X17, #0xf243, LSL #16
    MOVK  X17, #0x68dd, LSL #32
    MOVK  X17, #0x873, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D12
    MOVZ  X17, #0xd971, LSL #0
    MOVK  X17, #0x4981, LSL #16
    MOVK  X17, #0x592b, LSL #32
    MOVK  X17, #0x1ba1, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X17, #0x8fad, LSL #0
    MOVK  X17, #0xcdc5, LSL #16
    MOVK  X17, #0x65e, LSL #32
    MOVK  X17, #0x7213, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D13
    MOVZ  X17, #0x1bf3, LSL #0
    MOVK  X17, #0x9105, LSL #16
    MOVK  X17, #0x57db, LSL #32
    MOVK  X17, #0x8709, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X17, #0x3524, LSL #0
    MOVK  X17, #0x77b4, LSL #16
    MOVK  X17, #0x5c50, LSL #32
    MOVK  X17, #0x2e62, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D14
    MOVZ  X17, #0xb9f2, LSL #0
    MOVK  X17, #0xa2de, LSL #16
    MOVK  X17, #0xa1bf, LSL #32
    MOVK  X17, #0xc230, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X17, #0xed4d, LSL #0
    MOVK  X17, #0xd96a, LSL #16
    MOVK  X17, #0x4450, LSL #32
    MOVK  X17, #0xb5b, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D15
    MOVZ  X17, #0x87c, LSL #0
    MOVK  X17, #0xc7a7, LSL #16
    MOVK  X17, #0xf639, LSL #32
    MOVK  X17, #0xb0b5, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X17, #0xfea3, LSL #0
    MOVK  X17, #0x144f, LSL #16
    MOVK  X17, #0x7ced, LSL #32
    MOVK  X17, #0xd7bb, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D16
    MOVZ  X17, #0xb9d2, LSL #0
    MOVK  X17, #0xb685, LSL #16
    MOVK  X17, #0x8d28, LSL #32
    MOVK  X17, #0x161f, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X17, #0x45f, LSL #0
    MOVK  X17, #0x3113, LSL #16
    MOVK  X17, #0x86ae, LSL #32
    MOVK  X17, #0x4790, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D17
    MOVZ  X17, #0x745b, LSL #0
    MOVK  X17, #0x8a99, LSL #16
    MOVK  X17, #0x6c3e, LSL #32
    MOVK  X17, #0x7ce8, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X17, #0x7d1d, LSL #0
    MOVK  X17, #0x8a82, LSL #16
    MOVK  X17, #0x940d, LSL #32
    MOVK  X17, #0xe935, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D18
    MOVZ  X17, #0x69aa, LSL #0
    MOVK  X17, #0x5cb7, LSL #16
    MOVK  X17, #0xc020, LSL #32
    MOVK  X17, #0x410d, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X17, #0xedfb, LSL #0
    MOVK  X17, #0x23ee, LSL #16
    MOVK  X17, #0x1313, LSL #32
    MOVK  X17, #0x3cf1, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D19
    MOVZ  X17, #0x3670, LSL #0
    MOVK  X17, #0xfc32, LSL #16
    MOVK  X17, #0x301c, LSL #32
    MOVK  X17, #0x5576, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X17, #0xfcf6, LSL #0
    MOVK  X17, #0x47bb, LSL #16
    MOVK  X17, #0x3991, LSL #32
    MOVK  X17, #0xf6cd, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D20
    MOVZ  X17, #0x7fc0, LSL #0
    MOVK  X17, #0x6883, LSL #16
    MOVK  X17, #0x20e4, LSL #32
    MOVK  X17, #0x7d6c, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X17, #0x691e, LSL #0
    MOVK  X17, #0xb948, LSL #16
    MOVK  X17, #0xe966, LSL #32
    MOVK  X17, #0x86f5, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D21
    MOVZ  X17, #0x7386, LSL #0
    MOVK  X17, #0xf73e, LSL #16
    MOVK  X17, #0x55ca, LSL #32
    MOVK  X17, #0x35e, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X17, #0x3dd, LSL #0
    MOVK  X17, #0x4253, LSL #16
    MOVK  X17, #0x1f1a, LSL #32
    MOVK  X17, #0x4906, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D22
    MOVZ  X17, #0x16ac, LSL #0
    MOVK  X17, #0x4507, LSL #16
    MOVK  X17, #0xc856, LSL #32
    MOVK  X17, #0x475e, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X17, #0xeac2, LSL #0
    MOVK  X17, #0xd600, LSL #16
    MOVK  X17, #0xdc59, LSL #32
    MOVK  X17, #0xeb00, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D23
    MOVZ  X17, #0x14b1, LSL #0
    MOVK  X17, #0xceda, LSL #16
    MOVK  X17, #0x3257, LSL #32
    MOVK  X17, #0xe95f, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X17, #0x4db7, LSL #0
    MOVK  X17, #0xe37d, LSL #16
    MOVK  X17, #0x19cd, LSL #32
    MOVK  X17, #0xb43e, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D24
    MOVZ  X17, #0xa608, LSL #0
    MOVK  X17, #0x61d9, LSL #16
    MOVK  X17, #0x9911, LSL #32
    MOVK  X17, #0xc0bb, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X17, #0x10f, LSL #0
    MOVK  X17, #0x32a1, LSL #16
    MOVK  X17, #0x1735, LSL #32
    MOVK  X17, #0xed31, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D25
    MOVZ  X17, #0x26a5, LSL #0
    MOVK  X17, #0xb27, LSL #16
    MOVK  X17, #0x938d, LSL #32
    MOVK  X17, #0xc280, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D26
    MOVZ  X17, #0x0, LSL #0
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X17, #0x7dc6, LSL #0
    MOVK  X17, #0xfd46, LSL #16
    MOVK  X17, #0xe7f6, LSL #32
    MOVK  X17, #0x84ac, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D27
    MOVZ  X17, #0x341, LSL #0
    MOVK  X17, #0xd146, LSL #16
    MOVK  X17, #0x5cea, LSL #32
    MOVK  X17, #0xf98, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X17, #0xd2ac, LSL #0
    MOVK  X17, #0x2bdc, LSL #16
    MOVK  X17, #0x7a5, LSL #32
    MOVK  X17, #0xc84, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D28
    MOVZ  X17, #0x2c24, LSL #0
    MOVK  X17, #0xd561, LSL #16
    MOVK  X17, #0xc6c6, LSL #32
    MOVK  X17, #0xc7f8, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X17, #0x8f71, LSL #0
    MOVK  X17, #0xbf0b, LSL #16
    MOVK  X17, #0xf757, LSL #32
    MOVK  X17, #0x9168, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D29
    MOVZ  X17, #0xe438, LSL #0
    MOVK  X17, #0xaa1c, LSL #16
    MOVK  X17, #0x75c8, LSL #32
    MOVK  X17, #0xdcde, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X17, #0x6a3b, LSL #0
    MOVK  X17, #0x5de1, LSL #16
    MOVK  X17, #0x2da1, LSL #32
    MOVK  X17, #0xa801, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D30
    MOVZ  X17, #0x633e, LSL #0
    MOVK  X17, #0x9da2, LSL #16
    MOVK  X17, #0x436e, LSL #32
    MOVK  X17, #0x9ef0, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X17, #0x578e, LSL #0
    MOVK  X17, #0xb032, LSL #16
    MOVK  X17, #0x679e, LSL #32
    MOVK  X17, #0x6894, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail
    FMOV  X5, D31
    MOVZ  X17, #0xda50, LSL #0
    MOVK  X17, #0x2472, LSL #16
    MOVK  X17, #0x582f, LSL #32
    MOVK  X17, #0x71ea, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail

LCRTAdvsimdVectorV8p2CryptographicExtension_TestEnd:
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
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    STR  X15, [X0, #0]
    LDR  P0, [X0, #0, MUL VL]
    LD4D  { Z28.D, Z29.D, Z30.D, Z31.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z24.D, Z25.D, Z26.D, Z27.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z20.D, Z21.D, Z22.D, Z23.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z16.D, Z17.D, Z18.D, Z19.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z12.D, Z13.D, Z14.D, Z15.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z8.D, Z9.D, Z10.D, Z11.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z4.D, Z5.D, Z6.D, Z7.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z0.D, Z1.D, Z2.D, Z3.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LDR  P15, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P14, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P13, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P12, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P11, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P10, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P9, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P8, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P7, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P6, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P5, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P4, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P3, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P2, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P1, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P0, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
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
LCRTAdvsimdVectorV8p2CryptographicExtension_TestFail:
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
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    STR  X15, [X0, #0]
    LDR  P0, [X0, #0, MUL VL]
    LD4D  { Z28.D, Z29.D, Z30.D, Z31.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z24.D, Z25.D, Z26.D, Z27.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z20.D, Z21.D, Z22.D, Z23.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z16.D, Z17.D, Z18.D, Z19.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z12.D, Z13.D, Z14.D, Z15.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z8.D, Z9.D, Z10.D, Z11.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z4.D, Z5.D, Z6.D, Z7.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z0.D, Z1.D, Z2.D, Z3.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LDR  P15, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P14, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P13, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P12, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P11, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P10, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P9, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P8, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P7, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P6, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P5, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P4, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P3, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P2, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P1, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P0, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
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
